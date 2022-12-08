Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE866472AB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiLHPP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiLHPOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:14:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CFFAD33F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:14:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FFF161F6B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2899C433D7;
        Thu,  8 Dec 2022 15:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512469;
        bh=fGmEfHJ5sJXZ4aGfedlfBXl5fLVhG6tOkoie688PUzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jxo4D/pFiATIio7WyLEC0/K6IM0pK+9Wv2tJFVntxAgrntpJQuNPC2coDRzAHfgny
         SfkHLcmb5Jx2yJI6HSUx6aF73hkavskXD38lMtQw1YALyvZPi72mZ6bIqMjG5EOzf2
         gGY0yrEoqodUg7I0bB4jeEGDAUAE7JMbh0CmKYUlnbs32xbAe9jwv+s+XbRrk53xAR
         7NRw4w5fQtYNVSISIOJVny3jNWYUQAzjjVEztFVcFKOlqjs6/Awu4vl1xPWEJcNPIm
         75EZtsiBzRMx05wmEdd6EUGR4wWtReeDiP8K5jP/gHtzzEdKJ0Bnyk7L/H4Cl5bVkT
         6Lz06slDlxkdw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 26/26] habanalabs: fix wrong variable type used for vzalloc
Date:   Thu,  8 Dec 2022 17:13:50 +0200
Message-Id: <20221208151350.1833823-26-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208151350.1833823-1-ogabbay@kernel.org>
References: <20221208151350.1833823-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

vzalloc expects void* and not void __iomem*.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index cda0bf3dbf1b..ee4d1c5ca527 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -2019,9 +2019,10 @@ static int hl_fw_dynamic_read_and_validate_descriptor(struct hl_device *hdev,
 						struct fw_load_mgr *fw_loader)
 {
 	struct lkd_fw_comms_desc *fw_desc;
-	void __iomem *src, *temp_fw_desc;
 	struct pci_mem_region *region;
 	struct fw_response *response;
+	void *temp_fw_desc;
+	void __iomem *src;
 	u16 fw_data_size;
 	enum pci_region region_id;
 	int rc;
-- 
2.25.1

