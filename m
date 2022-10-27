Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301C260F352
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbiJ0JLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbiJ0JKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:10:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DCF255BC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:10:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03A7C62240
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9116EC433D7;
        Thu, 27 Oct 2022 09:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666861831;
        bh=rIk8jKMhlIFhlHw+rsEUWOL8K4fslKFxTHy3uNVL2tM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PjxkOKjA5XjTMmA9rsknmXP6ASpUDfMeFE4VgVatFfrAI1qAWJitNU/+3bF3ArxOv
         MRZipNFgM0UtyrRPOcaQ35ZCfNg3kJWhuv9SrBZCUnTD939gc+JlT7Ha6MxlT1QDtR
         Gux0kogyG0pvWTsLPfSXmWfdA762mazs6klbLG+YxVG6F0Xi6va9rDSOcKkOBaCiaG
         iMlOW3gV7IcJD46ciJ9iB+hMO4M/9QGb5osyRI6ucfPNSmRAKA3jkFTQSbogFGm2Bx
         iSKnm2Mt+3avDc5kvfIbDDDumtKUWtQGjyEPIk5KRvAd1HD6HfoOouGIwm/CsDcvIW
         zGFUh3MLkM8Zg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 14/15] habanalabs: add warning print upon a PCI error
Date:   Thu, 27 Oct 2022 12:10:06 +0300
Message-Id: <20221027091007.664797-14-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221027091007.664797-1-ogabbay@kernel.org>
References: <20221027091007.664797-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In order to know if driver catches PCI errors correctly, we need to
print a warning per each error.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs_drv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 714994725224..e82af8989700 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -595,15 +595,16 @@ hl_pci_err_detected(struct pci_dev *pdev, pci_channel_state_t state)
 
 	switch (state) {
 	case pci_channel_io_normal:
+		dev_warn(hdev->dev, "PCI normal state error detected\n");
 		return PCI_ERS_RESULT_CAN_RECOVER;
 
 	case pci_channel_io_frozen:
-		dev_warn(hdev->dev, "frozen state error detected\n");
+		dev_warn(hdev->dev, "PCI frozen state error detected\n");
 		result = PCI_ERS_RESULT_NEED_RESET;
 		break;
 
 	case pci_channel_io_perm_failure:
-		dev_warn(hdev->dev, "failure state error detected\n");
+		dev_warn(hdev->dev, "PCI failure state error detected\n");
 		result = PCI_ERS_RESULT_DISCONNECT;
 		break;
 
@@ -639,6 +640,10 @@ static void hl_pci_err_resume(struct pci_dev *pdev)
  */
 static pci_ers_result_t hl_pci_err_slot_reset(struct pci_dev *pdev)
 {
+	struct hl_device *hdev = pci_get_drvdata(pdev);
+
+	dev_warn(hdev->dev, "PCI slot reset detected\n");
+
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-- 
2.25.1

