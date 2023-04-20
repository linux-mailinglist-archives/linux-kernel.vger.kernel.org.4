Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB276E8E2E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbjDTJfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjDTJff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:35:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E42FC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:35:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DEB9612BF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 09:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9DAC433D2;
        Thu, 20 Apr 2023 09:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681983333;
        bh=HdXdYZQym10kC00W6v8aqZexsVRWoeV8afyKO+dOT+A=;
        h=From:To:Cc:Subject:Date:From;
        b=shh3XgWtjmfw19L2I93GmoLp8nqi24i/kDwt76X0fh5Si7fetgh5XTk3cNt2r+jC2
         nyMIKL6DLKe/kzAA+YRrN4Vj63Zk4ZobAgc3DSwqW79nru26z6p6Q6fBKQZ06L30Z4
         bYB0ZSBpU1sUgbnjXZVNvUz3l2283aFA0OaLyImc3BpHtj38HPOLgRl42DWHjBxnQD
         ku4htZPvO0Op871FJsHDNxrMoZsKAioMzH5wgXfCGlSVCra53pgiysgh6yxfkFGNkz
         UwyM7rK1jGfJNe09a0KE8EAeFOgHNy0syqNGSY1V868lXD1Zb+Vnn6qbs8iXXMH7Pp
         piVDNYiob5M8g==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH] tty: synclink_gt: don't allocate and pass dummy flags
Date:   Thu, 20 Apr 2023 11:35:30 +0200
Message-Id: <20230420093530.13133-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In synclinc_gt, the flag_buf is allocated, zeroed and passed to ldisc's
receive_buf(). It is never written to, so it serves as a dummy buffer.
That's unneeded because all ldiscs accept NULL as flags. That NULL
resolves to the TTY_NORMAL flag.

So drop all this nonsense.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/synclink_gt.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 543b3224dce9..16e469e581ec 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -287,7 +287,6 @@ struct slgt_info {
 	unsigned char *tx_buf;
 	int tx_count;
 
-	char *flag_buf;
 	bool drop_rts_on_tx_done;
 	struct	_input_signal_events	input_signal_events;
 
@@ -3244,13 +3243,7 @@ static int alloc_tmp_rbuf(struct slgt_info *info)
 	info->tmp_rbuf = kmalloc(info->max_frame_size + 5, GFP_KERNEL);
 	if (info->tmp_rbuf == NULL)
 		return -ENOMEM;
-	/* unused flag buffer to satisfy receive_buf calling interface */
-	info->flag_buf = kzalloc(info->max_frame_size + 5, GFP_KERNEL);
-	if (!info->flag_buf) {
-		kfree(info->tmp_rbuf);
-		info->tmp_rbuf = NULL;
-		return -ENOMEM;
-	}
+
 	return 0;
 }
 
@@ -3258,8 +3251,6 @@ static void free_tmp_rbuf(struct slgt_info *info)
 {
 	kfree(info->tmp_rbuf);
 	info->tmp_rbuf = NULL;
-	kfree(info->flag_buf);
-	info->flag_buf = NULL;
 }
 
 /*
@@ -4657,7 +4648,8 @@ static bool rx_get_frame(struct slgt_info *info)
 				hdlcdev_rx(info,info->tmp_rbuf, framesize);
 			else
 #endif
-				ldisc_receive_buf(tty, info->tmp_rbuf, info->flag_buf, framesize);
+				ldisc_receive_buf(tty, info->tmp_rbuf, NULL,
+						  framesize);
 		}
 	}
 	free_rbufs(info, start, end);
@@ -4691,8 +4683,8 @@ static bool rx_get_buf(struct slgt_info *info)
 	DBGDATA(info, info->rbufs[i].buf, count, "rx");
 	DBGINFO(("rx_get_buf size=%d\n", count));
 	if (count)
-		ldisc_receive_buf(info->port.tty, info->rbufs[i].buf,
-				  info->flag_buf, count);
+		ldisc_receive_buf(info->port.tty, info->rbufs[i].buf, NULL,
+				  count);
 	free_rbufs(info, i, i);
 	return true;
 }
-- 
2.40.0

