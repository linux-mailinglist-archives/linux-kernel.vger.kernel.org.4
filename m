Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2ED0706F60
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjEQR0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjEQR01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:26:27 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B57A5C7;
        Wed, 17 May 2023 10:26:02 -0700 (PDT)
Received: from vefanov-Precision-3650-Tower.intra.ispras.ru (unknown [10.10.2.69])
        by mail.ispras.ru (Postfix) with ESMTPSA id 6BEC340755CE;
        Wed, 17 May 2023 17:25:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6BEC340755CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1684344348;
        bh=aom6zdq+nb9ytMsl0njXJSZ8hBFPWeXehVcz6nJqeBk=;
        h=From:To:Cc:Subject:Date:From;
        b=b6ILUDy5tVtHTiedTk1ynvQrY53mc9N/+34FAKpQgbEZww0c6FcikJ+m0yEIdaCAW
         CZhTx7KZzFBxzx1/O8c9gY5QAVR4r1EpwHL9RAzFidYLln9RXaLsIA7n+p52qIpro1
         FPNSvFn10XGwsFP4n+k2Rx4308mm5lJyg/GwGOeE=
From:   Vladislav Efanov <VEfanov@ispras.ru>
To:     Andy Gross <agross@kernel.org>
Cc:     Vladislav Efanov <VEfanov@ispras.ru>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] usb: dwc3: qcom: Fix potential memory leak
Date:   Wed, 17 May 2023 20:25:18 +0300
Message-Id: <20230517172518.442591-1-VEfanov@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function dwc3_qcom_probe() allocates memory for resource structure
which is pointed by parent_res pointer. This memory is not
freed. This leads to memory leak. Use stack memory to prevent
memory leak.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 2bc02355f8ba ("usb: dwc3: qcom: Add support for booting with ACPI")
Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>
---
 drivers/usb/dwc3/dwc3-qcom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 959fc925ca7c..f52241883694 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -791,6 +791,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	struct device		*dev = &pdev->dev;
 	struct dwc3_qcom	*qcom;
 	struct resource		*res, *parent_res = NULL;
+	struct resource		local_res;
 	int			ret, i;
 	bool			ignore_pipe_clk;
 	bool			wakeup_source;
@@ -842,9 +843,8 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	if (np) {
 		parent_res = res;
 	} else {
-		parent_res = kmemdup(res, sizeof(struct resource), GFP_KERNEL);
-		if (!parent_res)
-			return -ENOMEM;
+		memcpy(&local_res, res, sizeof(struct resource));
+		parent_res = &local_res;
 
 		parent_res->start = res->start +
 			qcom->acpi_pdata->qscratch_base_offset;
-- 
2.34.1

