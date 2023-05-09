Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5FE6FC24E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbjEIJGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjEIJGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:06:43 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D41B40E4
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:06:41 -0700 (PDT)
Received: from karterlan2-VirtualBox.. ([10.12.188.37])
        (user=m202271736@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 34995s5S021406-34995s5T021406
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 May 2023 17:05:54 +0800
From:   Yi Yingao <m202271736@hust.edu.cn>
To:     Vincent Shih <vincent.sunplus@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Yi Yingao <m202271736@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: sunplus-ocotp: release otp->clk before return
Date:   Tue,  9 May 2023 16:52:36 +0800
Message-Id: <20230509085237.5917-1-m202271736@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: m202271736@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports:
drivers/nvmem/sunplus-ocotp.c:205 sp_ocotp_probe()
warn: 'otp->clk' from clk_prepare() not released on lines: 196.

In the function sp_ocotp_probe(struct platform_device *pdev), otp->clk may
not be released before return.

To fix this issue, using function clk_unprepare() to release otp->clk.

Fixes: 8747ec2e9762 ("nvmem: Add driver for OCOTP in Sunplus SP7021")
Signed-off-by: Yi Yingao <m202271736@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
The issue is found by static analysis and the patch remains untested.
---
 drivers/nvmem/sunplus-ocotp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/sunplus-ocotp.c b/drivers/nvmem/sunplus-ocotp.c
index 52b928a7a6d5..f85350b17d67 100644
--- a/drivers/nvmem/sunplus-ocotp.c
+++ b/drivers/nvmem/sunplus-ocotp.c
@@ -192,9 +192,11 @@ static int sp_ocotp_probe(struct platform_device *pdev)
 	sp_ocotp_nvmem_config.dev = dev;
 
 	nvmem = devm_nvmem_register(dev, &sp_ocotp_nvmem_config);
-	if (IS_ERR(nvmem))
-		return dev_err_probe(&pdev->dev, PTR_ERR(nvmem),
+	if (IS_ERR(nvmem)) {
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(nvmem),
 						"register nvmem device fail\n");
+		goto err;
+	}
 
 	platform_set_drvdata(pdev, nvmem);
 
@@ -203,6 +205,9 @@ static int sp_ocotp_probe(struct platform_device *pdev)
 		(int)OTP_WORD_SIZE, (int)QAC628_OTP_SIZE);
 
 	return 0;
+err:
+	clk_unprepare(otp->clk);
+	return ret;
 }
 
 static const struct of_device_id sp_ocotp_dt_ids[] = {
-- 
2.34.1

