Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CDB647296
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiLHPO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiLHPOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:14:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17528C69C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:14:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36AD261F7D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8ACAC433D7;
        Thu,  8 Dec 2022 15:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512446;
        bh=LyaZU2I2loV4W36afzInpEjWhu8FPBoABSC+JiOO0bI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cjwsM0rKyAbn7b/ZWfml4xHwfDFxpxYeLXGBLH9YIPRSimvvM0r1grwp5ER5EtL0r
         gLw2jkjqRnjuWIB0wLpVFtg8QcPWFu7lY9m1fsVwvO1AJy/iy2u23reBobAxLG0tEL
         mLEc2zAjYPik6IZmDlQkuimgE5GkZmFFykswJ2yZQu30NAghhcBON464Oy8Ql4KQ2o
         rjSfHDcvqzvOtno+qLxLbrbI085favd5xqX6ixGFDLuPq7lPXd0vJj6j+51QGDte+U
         301z54vFo98k7MaeTd1WUQcHerpZI30f/fKhrQ3epdWGr4g+m57022crQLTlJ33v6c
         IhmtSmhhiFh2g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Marco Pagani <marpagan@redhat.com>
Subject: [PATCH 09/26] habanalabs: fix double assignment in MMU V1
Date:   Thu,  8 Dec 2022 17:13:33 +0200
Message-Id: <20221208151350.1833823-9-ogabbay@kernel.org>
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

From: Marco Pagani <marpagan@redhat.com>

Removing double assignment of the hop2_pte_addr
variable in dram_default_mapping_fini().

Dead store reported by clang-analyzer.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/mmu/mmu_v1.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/mmu/mmu_v1.c b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
index 8a40de4a4761..d925dc4dd097 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu_v1.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
@@ -344,7 +344,6 @@ static void dram_default_mapping_fini(struct hl_ctx *ctx)
 		}
 	}
 
-	hop2_pte_addr = hop2_addr;
 	hop2_pte_addr = hop2_addr;
 	for (i = 0 ; i < num_of_hop3 ; i++) {
 		clear_pte(ctx, hop2_pte_addr);
-- 
2.25.1

