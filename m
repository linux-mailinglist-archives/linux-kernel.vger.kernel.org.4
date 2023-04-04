Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DC76D5983
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjDDH0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbjDDHZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:25:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0982705;
        Tue,  4 Apr 2023 00:25:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80CAB62F73;
        Tue,  4 Apr 2023 07:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBBEC4339C;
        Tue,  4 Apr 2023 07:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680593145;
        bh=1RmeZ7eM69xUCZQiQmM1oIPdpmsX9p3ONCsxLC4LpKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hftUNjyeBIzD0TIC8tbdbDUVbToOmeCUC+JR48PbQdj/Kzq1Ll9/ZxCODsb1KLLFM
         gJE6vCyfgz4ObPQPb/WfQttIjACTR60jMYKi8ieq8wgdaNXservG+gtiJiKTVpfjam
         UE9gckp1phC5Vduf7/HiToSuGu0YnpchVoVZVyY9cme6Nv6E5l6DH7WS1oC9zcpw53
         2n9db6UuYMlW5YAvuaMRO5L0nGrHMFs/Pf2Wg4UgW/7flgRobLbauGdcxRV9O8AB95
         JScJFuWQ3kqMv014hR+iSL0mRQaaIcDdWvipU+0JP4LVu06+i9seeqlXwIETbDIVSV
         YG2XseYDts5Vw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pjb3U-0004xU-R8; Tue, 04 Apr 2023 09:26:12 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 03/11] USB: dwc3: disable autosuspend on unbind
Date:   Tue,  4 Apr 2023 09:25:16 +0200
Message-Id: <20230404072524.19014-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404072524.19014-1-johan+linaro@kernel.org>
References: <20230404072524.19014-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing calls to disable autosuspend on probe errors and on
driver unbind.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9f8c988c25cb..5b362ed43e7e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1954,6 +1954,7 @@ static int dwc3_probe(struct platform_device *pdev)
 err2:
 	pm_runtime_allow(dev);
 	pm_runtime_disable(dev);
+	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_set_suspended(dev);
 	pm_runtime_put_noidle(dev);
 disable_clks:
@@ -1981,6 +1982,7 @@ static int dwc3_remove(struct platform_device *pdev)
 
 	pm_runtime_allow(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 
-- 
2.39.2

