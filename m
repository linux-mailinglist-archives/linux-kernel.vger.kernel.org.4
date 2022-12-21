Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1119B652DDF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 09:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbiLUI3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 03:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLUI3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 03:29:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E631DF37
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 00:28:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EAEDB811F6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 08:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B3EC433D2;
        Wed, 21 Dec 2022 08:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671611333;
        bh=Rn7MkbT6UsUL4kZ1Ldi0pJvoV9nUIf59eDilGtdiyGw=;
        h=From:To:Cc:Subject:Date:From;
        b=NA4C4PGkWi8RDz0b2dTZ8emvF8Zrm4PoWOmwuHVjcC2ZIBB4/6ZuQZQXU/zMr+cTs
         LWX6ISoV264Bmh5eg43Q6lgpH20p1q5Eplyos2KuItFq4f+zD8RPf7jEap8D5h2PaQ
         +Vt0g5OGRanIugpUcGyRvfLW1pnULfoLIuH+rx+pXTCMPVB+Dxz2AhtxUiF+yTc7W+
         CDXea5QpGP9H64BtmYXt1YgQxr3Vcz1B6TsTHS7RaTZ++rOuZRU5lu2C8tM6excYjc
         RTxPUCgxLwyx2dkxNRa0KziUTjDCxcxFz6N2reX0kuwbCUGAZbXjwmoJxmgHA/FN38
         b2+a0pSSUEw+Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/2] habanalabs/gaudi2: dump event description even if no cause
Date:   Wed, 21 Dec 2022 10:28:45 +0200
Message-Id: <20221221082846.3164-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
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

From: Ofir Bitton <obitton@habana.ai>

In order to have the no-cause error print be more informative,
we add the event description in addition to the event id.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 987ec44fa378..7df1a68dd403 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -9271,8 +9271,8 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	if (error_count == GAUDI2_NA_EVENT_CAUSE && !is_info_event(event_type))
 		gaudi2_print_event(hdev, event_type, true, "%d", event_type);
 	else if (error_count == 0)
-		dev_err_ratelimited(hdev->dev,
-			"No Error cause for H/W event %d\n", event_type);
+		gaudi2_print_event(hdev, event_type, true,
+				"No error cause for H/W event %u\n", event_type);
 
 	if ((gaudi2_irq_map_table[event_type].reset || reset_required) &&
 				(hdev->hard_reset_on_fw_events ||
-- 
2.34.1

