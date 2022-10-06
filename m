Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B0B5F627B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiJFIXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiJFIXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:23:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90DD3A4B8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:23:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EF7E61890
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C97C433D6;
        Thu,  6 Oct 2022 08:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665044593;
        bh=B+IALN2PCNFBETKxZGgdz0EZJtruqB1uB7nHDpyb/QA=;
        h=From:To:Cc:Subject:Date:From;
        b=HqKr9Cl9bwVl4uhhqqoD+MEr0tKT130+3DKJSYpdUQ2QAJR3JAmGfoM5cUmoYVTqV
         jVJ+uKiSmBKOF/iHRaz4mi4H42tqt5eU4prqSkRSAVeYTNL18/jzTBxdGE0Jbq7Btk
         f3d1uyYo2u4QXdl+Jbdc5h8ko8EasJ95QScJQbYY2imHFDYW1iHx/Eoz5h7xu90zcz
         mSB8dcQOMGyr+Ct7j0n4WBLJBCuyUOZSUH+mhxw+lbQFncxjMMD7M7Ox4zH3MmKY2P
         ehMxMMU9WbD5gjOi6YCF66VK3AWrSrJKdvjH9DdHXRn0miLfmF63+c4uZ/4+gbErSK
         o+4huVmPbEpzQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Bharat Jauhari <bjauhari@habana.ai>
Subject: [PATCH 01/13] habanalabs: use lower_32_bits()
Date:   Thu,  6 Oct 2022 11:22:56 +0300
Message-Id: <20221006082308.1266716-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
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

From: Bharat Jauhari <bjauhari@habana.ai>

This fixes sparse warning on doing cast to 32-bits

Signed-off-by: Bharat Jauhari <bjauhari@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index cdc50c2c4de8..f4b3fa4b0976 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2528,7 +2528,7 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 				break; \
 			(val) = __elbi_read; \
 		} else {\
-			(val) = RREG32((u32)(addr)); \
+			(val) = RREG32(lower_32_bits(addr)); \
 		} \
 		if (cond) \
 			break; \
@@ -2539,7 +2539,7 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 					break; \
 				(val) = __elbi_read; \
 			} else {\
-				(val) = RREG32((u32)(addr)); \
+				(val) = RREG32(lower_32_bits(addr)); \
 			} \
 			break; \
 		} \
@@ -2594,7 +2594,7 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 				if (__rc) \
 					break; \
 			} else { \
-				__read_val = RREG32((u32)(addr_arr)[__arr_idx]); \
+				__read_val = RREG32(lower_32_bits(addr_arr[__arr_idx])); \
 			} \
 			if (__read_val == (expected_val))	\
 				__elem_bitmask &= ~BIT_ULL(__arr_idx);	\
-- 
2.25.1

