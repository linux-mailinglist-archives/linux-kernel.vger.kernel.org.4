Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6A25F6287
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiJFIYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiJFIXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:23:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FE68D0C6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:23:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDC8761890
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688D6C433C1;
        Thu,  6 Oct 2022 08:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665044609;
        bh=queeyU42GLbbe9cRxT95tegYOpeFx8tuEQz2Kc03eGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cn6460+gBdikyhnQpPAxHX6JkOiWG35hal4tOkuGm0i9z8LavcShjpgp6dxFyRup8
         bxIe28vFfoTrdtc73Wp2qM+xKiljTcTpcVYG6tz4WJQtQlKhhtuOUgKsM4Xte5vwi9
         MrlgigJyJ/KXQe8+mXSF4xXxKYHbbyYE0cBB8c97dJOWt0UE09jakSZLzZJc9MfM+8
         RvxOyKGTOJ8eM9pSRdYfnf0Ls0KYrQja6C2srkXE2ceCF1W9YxYB99a1LcB3xTU+xv
         Bg7iTCHs+Gz/iukQpGLVqajaTyKmJUpBvW7agxmnGqTdhboBVBeIbT/LH2t4PQIsVq
         mhA3DJ2+UpIVg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 12/13] habanalabs/gaudi2: capture page fault data
Date:   Thu,  6 Oct 2022 11:23:07 +0300
Message-Id: <20221006082308.1266716-12-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006082308.1266716-1-ogabbay@kernel.org>
References: <20221006082308.1266716-1-ogabbay@kernel.org>
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

From: Dani Liberman <dliberman@habana.ai>

Capture page fault data when it happens.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 13a5356f1ec3..9dc1a328a4bd 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -8286,6 +8286,7 @@ static void gaudi2_handle_page_error(struct hl_device *hdev, u64 mmu_base, bool
 
 	dev_err_ratelimited(hdev->dev, "%s page fault on va 0x%llx\n",
 				is_pmmu ? "PMMU" : "HMMU", addr);
+	hl_capture_page_fault(hdev, addr, 0, is_pmmu);
 
 	WREG32(mmu_base + MMU_OFFSET(mmDCORE0_HMMU0_MMU_PAGE_ERROR_CAPTURE), 0);
 }
-- 
2.25.1

