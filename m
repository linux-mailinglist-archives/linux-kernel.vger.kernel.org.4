Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1D56481AD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 12:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiLIL3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 06:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiLIL2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 06:28:45 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6074C70BB9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 03:28:35 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id js9so3536612pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 03:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aoo/cX4IZ2UyYHO4YqGyALy4RhYqCFL96tWg9Kbsz+s=;
        b=lD9K6jv4/lVYwOsAhaAFdI95eUCppnuBLupdI7ZkjSU9kHf+Hr6DEtcYLu6hfcww/1
         DPGqdp0WrQgVeYdQjIbf52rnlTV633MXGhWCO66EPnSTs++nOizV6GhLmKrs+7EZYpDY
         mziZITxDfBncjmeVtcm6cEEA7Yz1nL6RvcemAdDL+xSLWR6PFTyvgVkKkgwEPcptYrW7
         m5OrBul3dYdV4TrUydP1AhMNhbOw428Q+cK7Vw0MgdQfyZS96QXxEjMoN+p/x1S+V6cC
         usMQrXf4IS9S2YyNzIyz2tOSFSQbVgu1b8On3DW9Eily6tQTu8xEmS8MJryzplcn7mlc
         8+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aoo/cX4IZ2UyYHO4YqGyALy4RhYqCFL96tWg9Kbsz+s=;
        b=UrxHgdyr+TzR4hfy4gfH4ZT9Pi5+OcQlw26HuwrabGacGak08Tq3JJEBRFM/KDqVg3
         gAodqHIrqTwo+lm3xJbil62gS3GmRB5VXHp04DGFsi/GUx3/bnG2pyP8bO+NSluxa+SQ
         3prz1/pOACzOc4E7r5Bs9iCaN9zS6dKW0DiVeIFXEzuoz+NNjCYwhpEr5Xo9wgvacHV3
         Z1HvyeVJGo0+Bi1PiCFpf6VRAGmY3dUUDJzvd5erDRfXE+JooGCwZKfmXaauAxwwjDm1
         8xVhaA2RfZ8UYU8Qph6mGY+wVY7f9yG9KQ/eOAAgZDlcwtsuXYePBj3fDOYsKKP2VPl9
         s0qw==
X-Gm-Message-State: ANoB5pnMJtfQGzpvUy7HRiCWtNlyNGssOOqYzT3cDwn+Ripuf9b+7PZh
        Q8X4B1i1weR7KuaW6KlYGio=
X-Google-Smtp-Source: AA0mqf6OzkKnmKhBujUklLEHyQsbCNBr0/7+6lnit808FFzDxnyPrrCUypLZ4qB4K+mT5+UlJpp8ig==
X-Received: by 2002:a05:6a20:9e04:b0:a7:929d:4017 with SMTP id ms4-20020a056a209e0400b000a7929d4017mr5600945pzb.9.1670585314836;
        Fri, 09 Dec 2022 03:28:34 -0800 (PST)
Received: from VirtualBox.. ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id r1-20020a63ce41000000b004790eb3fee1sm837928pgi.90.2022.12.09.03.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 03:28:34 -0800 (PST)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
Subject: [PATCH] f2fs: do decrease_sleep_time() if any of the victims have been selected
Date:   Fri,  9 Dec 2022 19:28:13 +0800
Message-Id: <20221209112813.73700-1-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
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

In non-foreground gc mode, if no victim is selected, the gc process
will wait for no_gc_sleep_time before waking up again. In this
subsequent time, even though a victim will be selected, the gc process
still waits for no_gc_sleep_time before waking up. The configuration
of wait_ms is not reasonable.

After any of the victims have been selected, we need to do
decrease_sleep_time() to reduce wait_ms.

If it is GC_URGENT_HIGH or GC_URGENT_MID gc mode,
wait_ms will keep urgent_sleep_time after executing decrease_sleep_time().

In decrease_sleep_time() wait_time will be reduced to max_sleep_time
from no_gc_sleep_time, if *wait is no_gc_sleep_time. And then it goes
down in the next step.

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 fs/f2fs/gc.c | 2 ++
 fs/f2fs/gc.h | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index f0c6506d8975..c023ffeb9268 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -141,6 +141,8 @@ static int gc_thread_func(void *data)
 			/* don't bother wait_ms by foreground gc */
 			if (!foreground)
 				wait_ms = gc_th->no_gc_sleep_time;
+		} else {
+			decrease_sleep_time(gc_th, &wait_ms);
 		}
 
 		if (foreground)
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 19b956c2d697..6402584dcd72 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -150,8 +150,13 @@ static inline void decrease_sleep_time(struct f2fs_gc_kthread *gc_th,
 {
 	unsigned int min_time = gc_th->min_sleep_time;
 
-	if (*wait == gc_th->no_gc_sleep_time)
+	if (*wait == gc_th->urgent_sleep_time)
+		return;
+
+	if (*wait == gc_th->no_gc_sleep_time) {
 		*wait = gc_th->max_sleep_time;
+		return;
+	}
 
 	if ((long long)*wait - (long long)min_time < (long long)min_time)
 		*wait = min_time;
-- 
2.34.1

