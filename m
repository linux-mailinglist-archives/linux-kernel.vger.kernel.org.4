Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6E66B2272
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjCILQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjCILQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:16:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C37ED0D1;
        Thu,  9 Mar 2023 03:12:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29F42B81ED6;
        Thu,  9 Mar 2023 11:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29EEC433D2;
        Thu,  9 Mar 2023 11:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678360323;
        bh=UjTdMRVXaqEY+xVySMqwPf3Ofga2yedHc4jEmU/eCFY=;
        h=From:To:Cc:Subject:Date:From;
        b=t2iOlfHELw7E8hKJOA+2s/bUMo5oUk0AujU2MOqNAxEQpNwTJpoxnOMelHDAi0vlv
         w5vW92q34ANgty4tpHBVnjUGRPPuF0fiow8Gj+0KP0sIqG1E94iV0KbAjQzN4mMtf+
         RXrVduRxNTPKq9oh7x/H3432IyWqEfy+EFint5/Gl0o1+IH7ZUPNlTAlRs9YM8ZEib
         LwbTIBN58VXpZuE5s8xgM2hvkCjKCnAR1GBfZ6LAdOemo5mt5mitK0YAH2sm336gRm
         AP4pMHDJOu17fnHV9RjbLD55XuL33Lgq3bngiN+v/6FBPd0K+vGPrN5eLtrOW+mYXk
         yCA/mA7CfTj+w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1paECa-0008EG-Kc; Thu, 09 Mar 2023 12:12:52 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH] firmware: qcom: scm: fix bogus irq error at probe
Date:   Thu,  9 Mar 2023 12:12:09 +0100
Message-Id: <20230309111209.31606-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
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

A recent commit added support for an optional interrupt which is only
available on some platforms.

Stop spamming the logs with bogus error messages on platforms that do
not use this new optional resource:

	qcom_scm firmware:scm: error -ENXIO: IRQ index 0 not found

Fixes: 6bf325992236 ("firmware: qcom: scm: Add wait-queue handling logic")
Cc: Guru Das Srinagesh <quic_gurus@quicinc.com>
Cc: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/firmware/qcom_scm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 468d4d5ab550..b1e11f85b805 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1479,7 +1479,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
 
 	init_completion(&__scm->waitq_comp);
 
-	irq = platform_get_irq(pdev, 0);
+	irq = platform_get_irq_optional(pdev, 0);
 	if (irq < 0) {
 		if (irq != -ENXIO)
 			return irq;
-- 
2.39.2

