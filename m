Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5455BBDA2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 13:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiIRLhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 07:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiIRLh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 07:37:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B262529C
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 04:37:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 591C4614B4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 11:37:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0635CC433C1;
        Sun, 18 Sep 2022 11:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663501047;
        bh=E5Va0WE/iXHQVkKhaFVmQUdRGdBJUPReEDM2wQHoORk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jA8FNCPMo7FNM0vNz7jdX5VSsfSp3l2/HzzcDPv2ZcHCH2ObbNhxUl2WUDRzSllsZ
         3f6ty+0Mx9kmz0uX1NosyZJ5VaELf6s8OwTHDBiJ822vqE+xRwsKDYN825Wq7oviV8
         Os2pdBCNmw/frjaPkcPylYmPzTPmC160x+UvfC8rLYYPoQ70COWr0VBBwTHyk3rnTw
         de1M+g82lY6xXDlfNxbRvi+vIO017abaTv2cIOkwrXxlmBNmbEwNASWWnJfwxi6SsE
         H1Q0QY3Vo1cA/up87hBQr/NP0n8Hw+Z0shOWPYwjKp7Z+kDQF0lqENC6Vx73NKuiFi
         KlY0P9QFKG6MQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tal Cohen <talcohen@habana.ai>
Subject: [PATCH 5/7] habanalabs/gaudi: change TPC Assert to use TPC DEC instead of QMAN err
Date:   Sun, 18 Sep 2022 14:37:15 +0300
Message-Id: <20220918113717.2637094-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220918113717.2637094-1-ogabbay@kernel.org>
References: <20220918113717.2637094-1-ogabbay@kernel.org>
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

From: Tal Cohen <talcohen@habana.ai>

This change is done while there is a problem to use QMAN error for
TPC assert async. The problem involves security limitation that exists
to generate the assert via QMAN error.

Signed-off-by: Tal Cohen <talcohen@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index f81a141b4741..e80ebace49c8 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7216,12 +7216,6 @@ static void gaudi_handle_qman_err(struct hl_device *hdev, u16 event_type, u64 *e
 
 	switch (event_type) {
 	case GAUDI_EVENT_TPC0_QM ... GAUDI_EVENT_TPC7_QM:
-		/* In TPC QM event, notify on TPC assertion. While there isn't
-		 * a specific event for assertion yet, the FW generates QM event.
-		 * The SW upper layer will inspect an internal mapped area to indicate
-		 * if the event is a tpc assertion or tpc QM.
-		 */
-		*event_mask |= HL_NOTIFIER_EVENT_TPC_ASSERT;
 		index = event_type - GAUDI_EVENT_TPC0_QM;
 		qid_base = GAUDI_QUEUE_ID_TPC_0_0 + index * QMAN_STREAMS;
 		qman_base = mmTPC0_QM_BASE + index * TPC_QMAN_OFFSET;
@@ -7731,6 +7725,12 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 	case GAUDI_EVENT_TPC5_DEC:
 	case GAUDI_EVENT_TPC6_DEC:
 	case GAUDI_EVENT_TPC7_DEC:
+		/* In TPC DEC event, notify on TPC assertion. While there isn't
+		 * a specific event for assertion yet, the FW generates TPC DEC event.
+		 * The SW upper layer will inspect an internal mapped area to indicate
+		 * if the event is a TPC Assertion or a "real" TPC DEC.
+		 */
+		event_mask |= HL_NOTIFIER_EVENT_TPC_ASSERT;
 		gaudi_print_irq_info(hdev, event_type, true);
 		reset_required = gaudi_tpc_read_interrupts(hdev,
 					tpc_dec_event_to_tpc_id(event_type),
-- 
2.25.1

