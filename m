Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1796271E0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 20:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbiKMTAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 14:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235532AbiKMTAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 14:00:02 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AD9A1BB;
        Sun, 13 Nov 2022 11:00:01 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id v27so14429031eda.1;
        Sun, 13 Nov 2022 11:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8m5wRLYsxEq7AelfE/7w31+qv6bELSvLoZTg6CoYHe4=;
        b=VWu+I6w5v0li2zX8CHeFV0iUxKuPfMECxNxbP6M7mWzAtX5n06OHbzeCIhYGrmS3W+
         mC+XcDA0mqCbuy3Zg9k/wxn7dIvi/1pX7m6VnLSZZM3GCXqIjL8/izdCn7e0icCWbN9s
         3hPpS3oVX1ZjWhrnBIfqpwMzszVHxuPlidvODbEFuHnJ5E9xMsWcp64VnVK3oTQibkn2
         d6FdcyDGsR7l6q//9ysTjdJ1I5VJKJLY5CN1fm4I9XeJmWsFRRxF0YgFVfmzokc26wvC
         uCeoivztWXC7W2npQ6NX9uP6+XwSyptAOrqVQ7iqWhZO+1MQli71ohpz6EtO44F9jtMf
         glAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8m5wRLYsxEq7AelfE/7w31+qv6bELSvLoZTg6CoYHe4=;
        b=wrgdBYNVE7niIePpQPMdLHjCqllQAL7YrvY+G19P9X07nBhf71KHhJJ4py9YKVuz0r
         zcupWzzOivKVtKwFRwegJIYN2s3/nab9IR93jfGa6fNzZpwjF2BT8LbPXoY1nXCJR9PV
         kdqwPjtaT+AaGYjb/dAFnK4tnOxcxLmKQ94ubB6rNWaC0bMWDXh9gPSSeuCX+QqHSav/
         41AQWWIksQIhLZ1GkGnBDHoIH7DBcxQo9kfp/4KnEDKt7gAWRvVcMXdnqlP8FHjufRYy
         V7mJ+ys11RQVVDQDafofX1Shf1fqmBtroxMvDH9txszvSPO1k/sKx4q5YClbRqdaaGTU
         mqfw==
X-Gm-Message-State: ANoB5pmFIVGqoB+lUfujI7XxRsUFfUoBoOafZGE7YddVUrk1bxZyRsdu
        5+CFgtKSNEJdw0ZbKeVxlKU=
X-Google-Smtp-Source: AA0mqf6i2NE1kRGaeRr1vpRYkktEBxESq/GJVI+LMOWXnBR7i+J5Oh8tS5ApF8q7q8jtHly48rIL2g==
X-Received: by 2002:a05:6402:b32:b0:461:a130:ea3c with SMTP id bo18-20020a0564020b3200b00461a130ea3cmr8536838edb.272.1668365999547;
        Sun, 13 Nov 2022 10:59:59 -0800 (PST)
Received: from xws.localdomain ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906140900b007a9a56e2a07sm3233809ejc.49.2022.11.13.10.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 10:59:58 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 1/2] platform/surface: aggregator: Do not check for repeated unsequenced packets
Date:   Sun, 13 Nov 2022 19:59:50 +0100
Message-Id: <20221113185951.224759-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we check any received packet whether we have already seen it
previously, regardless of the packet type (sequenced / unsequenced). We
do this by checking the sequence number. This assumes that sequence
numbers are valid for both sequenced and unsequenced packets. However,
this assumption appears to be incorrect.

On some devices, the sequence number field of unsequenced packets (in
particular HID input events on the Surface Pro 9) is always zero. As a
result, the current retransmission check kicks in and discards all but
the first unsequenced packet, breaking (among other things) keyboard and
touchpad input.

Note that we have, so far, only seen packets being retransmitted in
sequenced communication. In particular, this happens when there is an
ACK timeout, causing the EC (or us) to re-send the packet waiting for an
ACK. Arguably, retransmission / duplication of unsequenced packets
should not be an issue as there is no logical condition (such as an ACK
timeout) to determine when a packet should be sent again.

Therefore, remove the retransmission check for unsequenced packets
entirely to resolve the issue.

Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../surface/aggregator/ssh_packet_layer.c     | 24 +++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
index 6748fe4ac5d5..def8d7ac541f 100644
--- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
@@ -1596,16 +1596,32 @@ static void ssh_ptl_timeout_reap(struct work_struct *work)
 		ssh_ptl_tx_wakeup_packet(ptl);
 }
 
-static bool ssh_ptl_rx_retransmit_check(struct ssh_ptl *ptl, u8 seq)
+static bool ssh_ptl_rx_retransmit_check(struct ssh_ptl *ptl, const struct ssh_frame *frame)
 {
 	int i;
 
+	/*
+	 * Ignore unsequenced packets. On some devices (notably Surface Pro 9),
+	 * unsequenced events will always be sent with SEQ=0x00. Attempting to
+	 * detect retransmission would thus just block all events.
+	 *
+	 * While sequence numbers would also allow detection of retransmitted
+	 * packets in unsequenced communication, they have only ever been used
+	 * to cover edge-cases in sequenced transmission. In particular, the
+	 * only instance of packets being retransmitted (that we are aware of)
+	 * is due to an ACK timeout. As this does not happen in unsequenced
+	 * communication, skip the retransmission check for those packets
+	 * entirely.
+	 */
+	if (frame->type == SSH_FRAME_TYPE_DATA_NSQ)
+		return false;
+
 	/*
 	 * Check if SEQ has been seen recently (i.e. packet was
 	 * re-transmitted and we should ignore it).
 	 */
 	for (i = 0; i < ARRAY_SIZE(ptl->rx.blocked.seqs); i++) {
-		if (likely(ptl->rx.blocked.seqs[i] != seq))
+		if (likely(ptl->rx.blocked.seqs[i] != frame->seq))
 			continue;
 
 		ptl_dbg(ptl, "ptl: ignoring repeated data packet\n");
@@ -1613,7 +1629,7 @@ static bool ssh_ptl_rx_retransmit_check(struct ssh_ptl *ptl, u8 seq)
 	}
 
 	/* Update list of blocked sequence IDs. */
-	ptl->rx.blocked.seqs[ptl->rx.blocked.offset] = seq;
+	ptl->rx.blocked.seqs[ptl->rx.blocked.offset] = frame->seq;
 	ptl->rx.blocked.offset = (ptl->rx.blocked.offset + 1)
 				  % ARRAY_SIZE(ptl->rx.blocked.seqs);
 
@@ -1624,7 +1640,7 @@ static void ssh_ptl_rx_dataframe(struct ssh_ptl *ptl,
 				 const struct ssh_frame *frame,
 				 const struct ssam_span *payload)
 {
-	if (ssh_ptl_rx_retransmit_check(ptl, frame->seq))
+	if (ssh_ptl_rx_retransmit_check(ptl, frame))
 		return;
 
 	ptl->ops.data_received(ptl, payload);
-- 
2.38.1

