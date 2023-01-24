Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8FE67A392
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 21:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbjAXUDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 15:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbjAXUDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:03:04 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F4E2ED75;
        Tue, 24 Jan 2023 12:03:03 -0800 (PST)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 321EBCD51C;
        Tue, 24 Jan 2023 20:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1674590551; bh=Y5e5JN3qUUr0oJYCMxQ/apdya4a1W97ae9pxk72RoDI=;
        h=From:To:Cc:Subject:Date;
        b=BcxgQslthYIeiZ437FZvgmeAZKwFjL4wo6oNO+BAbLAON/WDxviFSJd7XIerE7kwy
         Oy1bG3xxGeJd3FTXaVb03GmMJM8/VSRYpjld4ybZD/TByFqzLmaprNHOBWHHDTxefa
         Ao5sAetOY+IuWCJvhnTp2ZvrFWKvYxOrURaWckdo=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Todor Tomov <todor.too@gmail.com>,
        Robert Foss <robert.foss@linaro.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: camss: Missing cleanup on probe error
Date:   Tue, 24 Jan 2023 21:02:30 +0100
Message-ID: <5898403.lOV4Wx5bFT@g550jk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I hit an issue that was already fixed with upstream commit 3d658980e6da 
("media: camss: Do not attach an already attached power domain on MSM8916 
platform") but this showed that some error handling is missing in camss_probe.

After these errors the resources aren't cleaned up and e.g. sensor drivers 
still try to probe but fail quite badly because some things are NULL or 
whatever.

[    1.979098] qcom-camss fda0ac00.camss: Failed to configure power domains: 
-17
[    1.989327] qcom-camss: probe of fda0ac00.camss failed with error -17

The commit causing this (or at least part of this) is 2f6f8af67203 ("media: 
camss: Refactor VFE power domain toggling")

I tried a bit to add some error handling but in this case it now fails at 
v4l2_device_unregister_subdev -> media_device_unregister_entity -> 
__media_device_unregister_entity -> ida_free.
And I'm not really sure how to fix (and honestly not super motivated).

See following patch (formatting probably messed up, sorry). Maybe someone who 
knows a bit more about the driver or the media subsystem can fix this, thanks!

Regards
Luca

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/
platform/qcom/camss/camss.c
index 16545cecc4f4..0ba3c378d241 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1836,21 +1836,26 @@ static int camss_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = camss_configure_pd(camss);
+	//ret = camss_configure_pd(camss);
+	ret = -17;
 	if (ret < 0) {
 		dev_err(dev, "Failed to configure power domains: %d\n", 
ret);
-		return ret;
+		goto err_configure_pd;
 	}
 
 	pm_runtime_enable(dev);
 
 	return 0;
 
+err_configure_pd:
+	media_device_unregister(&camss->media_dev);
+	media_device_cleanup(&camss->media_dev);
 err_register_subdevs:
 	camss_unregister_entities(camss);
 err_register_entities:
 	v4l2_device_unregister(&camss->v4l2_dev);
 err_cleanup:
+	v4l2_async_nf_unregister(&camss->notifier);
 	v4l2_async_nf_cleanup(&camss->notifier);
 
 	return ret;



