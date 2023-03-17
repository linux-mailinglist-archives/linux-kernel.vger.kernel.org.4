Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAC76BF592
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjCQW5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 18:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjCQW5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:57:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B722BF1A;
        Fri, 17 Mar 2023 15:57:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A0E460C22;
        Fri, 17 Mar 2023 22:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894A9C4331E;
        Fri, 17 Mar 2023 22:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679093833;
        bh=VIy8olwrlGICMSJRbSV49sc6H5GVSRN/zSVEjc1k0Ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dq2IlKXEfLtYs6s6s8Tjsnlk5m8gt3V+HRfoC0L5pv3LX9lFIe9UPCO04V96Pz2Ph
         xQfwdp5mE9X6oZiG8aGMIuwVaxBgBpGeJwCCXqFSsbSt91rXOewezFl1qxibQVP3+i
         WIlxrE91+ftcV4Ce4q1xOW8+6Aa/DWYs1vGoyVIeqRjlQ7wkj/aN+rDQcnZkzaMgXQ
         uGv3BqSfwulVfx4JyIE98jY8hvdRFmaa9N7X2Pq+2Rxl9M9s8dBgLwhZBhDGOuaMla
         xJqrtAwSNsUanIx/7brnKSsknFblKeK7R3fa3bNi+TfMKGRKING0u7npkCDAL41NAN
         A5ZoL9R4lb9WA==
Received: by mercury (Postfix, from userid 1000)
        id 9F6AC1062115; Fri, 17 Mar 2023 23:57:08 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv3 13/14] power: supply: generic-adc-battery: improve error message
Date:   Fri, 17 Mar 2023 23:57:06 +0100
Message-Id: <20230317225707.1552512-14-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317225707.1552512-1-sre@kernel.org>
References: <20230317225707.1552512-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device context and error code to the error messages to make it
useful.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index df1c0a1c6b52..2fa946c93fb4 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -92,7 +92,7 @@ static int read_channel(struct gab *adc_bat, enum gab_chan_type channel,
 
 	ret = iio_read_channel_processed(adc_bat->channel[channel], result);
 	if (ret < 0)
-		pr_err("read channel error\n");
+		dev_err(&adc_bat->psy->dev, "read channel error: %d\n", ret);
 	else
 		*result *= 1000;
 
-- 
2.39.2

