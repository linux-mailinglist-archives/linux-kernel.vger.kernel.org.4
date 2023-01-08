Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8279066174C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 18:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjAHRU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 12:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbjAHRUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 12:20:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F825FA5
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 09:20:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8714B80B55
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 17:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32001C433EF;
        Sun,  8 Jan 2023 17:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673198448;
        bh=GKMA2fV1Cacham2OcLqjIAWmNFhtwsHwPsuLTOtpocY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jcHcVK1lwfyDWbUmLk+hwlXYnPHLOy97VaL6S9nLsH9XuXWXUHwqelQ20OqKRcuVd
         fMglGyzXr4G3abe1683B7o00Iro2qPyO5X1dAxCOjdY+MwiRuD+qdrl07XP/KpyCOH
         qRJkAwGU46dFYdKm0dnStBLqmWcj1Nu+NG90vQ/4KVtUhHkflBV1G5/1o34FJtt7oK
         SsjyN3QG4Tsgaf9Zg85wHzMoC3S5Vcq3VnCsTtmiOgePg6T/7Icr5qFFSXNOPqGl2r
         m6Fi13TyGBlQxhO4rHGJ37+16U+fAqzIVy2d1dYA8PtuU6Fw1rs6V79V1LXT6OeFVn
         vFS6LEJJ9ekkg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Carmit Carmel <ccarmel@habana.ai>
Subject: [PATCH 3/7] habanalabs/gaudi2: fix log for sob value overflow/underflow
Date:   Sun,  8 Jan 2023 19:20:36 +0200
Message-Id: <20230108172040.3991204-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230108172040.3991204-1-ogabbay@kernel.org>
References: <20230108172040.3991204-1-ogabbay@kernel.org>
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

From: Carmit Carmel <ccarmel@habana.ai>

The value in SM_SEI_CAUSE includes the SOB index and not the SOB group
index.
Remove usage of log_mask in sm_sei_cause structure as it was never
used.

Signed-off-by: Carmit Carmel <ccarmel@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 0f3e690041af..503a52db203f 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -676,14 +676,13 @@ static const char * const gaudi2_kdma_core_interrupts_cause[GAUDI2_NUM_OF_DMA_CO
 struct gaudi2_sm_sei_cause_data {
 	const char *cause_name;
 	const char *log_name;
-	u32 log_mask;
 };
 
 static const struct gaudi2_sm_sei_cause_data
 gaudi2_sm_sei_cause[GAUDI2_NUM_OF_SM_SEI_ERR_CAUSE] = {
-	{"calculated SO value overflow/underflow", "SOB group ID", 0x7FF},
-	{"payload address of monitor is not aligned to 4B", "monitor addr", 0xFFFF},
-	{"armed monitor write got BRESP (SLVERR or DECERR)", "AXI id", 0xFFFF},
+	{"calculated SO value overflow/underflow", "SOB ID"},
+	{"payload address of monitor is not aligned to 4B", "monitor addr"},
+	{"armed monitor write got BRESP (SLVERR or DECERR)", "AXI id"},
 };
 
 static const char * const
@@ -8418,7 +8417,7 @@ static int gaudi2_handle_sm_err(struct hl_device *hdev, u16 event_type, u8 sm_in
 				"err cause: %s. %s: 0x%X\n",
 				gaudi2_sm_sei_cause[i].cause_name,
 				gaudi2_sm_sei_cause[i].log_name,
-				sei_cause_log & gaudi2_sm_sei_cause[i].log_mask);
+				sei_cause_log);
 			error_count++;
 			break;
 		}
-- 
2.25.1

