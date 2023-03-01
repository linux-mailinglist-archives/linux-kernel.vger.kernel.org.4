Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BF06A77A1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjCAXXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCAXXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:23:32 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A0E15CB5
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:23:30 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id ck15so60883472edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 15:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jPSeSIsr5mXC1QtdcjXg3z86eU3NdRRW/+f0yct69pU=;
        b=UI/aez+ZxcvNmdmjPiMUJ721V7SBdIWCfZn3WPlyZa/jNPnG9KYqUpPx+js0aC2aGA
         sbauSBbGPtmcjpnEMsuvvuKar6y2Y2IVujlg34eju4JoT6U/WXEhQjqcQNhqg7bEF9+d
         wxOgS9R7TFUJ4IpXVps188wBR+bmhIbYkuFglHGSNzHbXh5sSrPg0vc+b+70y06M7MNJ
         GmB+8Ksm4OML148a2q8g6ztnPyqnE7deCIOxYEtA+c7b5DEdFsJm902DBZ5GenlUhzGN
         P59K30VDZ2+Xdi7rL4nVh+6lHfCGGkKPKwYpURVZhu+98BeDvyOMZUH+YfBRIT7yeFAN
         lQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jPSeSIsr5mXC1QtdcjXg3z86eU3NdRRW/+f0yct69pU=;
        b=l44dMqy8FU6rZiGDVgPAjkAR+zBCCZlYMAMAr5og79cnsFkSVPJZLua7zBGFawRa71
         Zo4WXq4i+TRg1f4y4w+f/7ZP67GtBQ69KM9M9vtuAQPEkMxBMKRtqiqvvx4U6XaiBTlH
         W+6PYpL17oo4EgDvh1Rif0ApjdmfY++LjuAReEOI/c58Uc1SpSBeaQwahF5eRWYjqsc/
         foGgmbgvhccWrrXWCfrZbCwG2qseLgWhtGYHrRh0eDNCpfJyualz9LNb7fknMRHZeFD/
         fGu9/T+EFDX+KOqn2bbMEEVyfwa5L5Fu0AUajF9Sjs7lTqSurprba3MW99h6Zv5/QSyY
         PJuA==
X-Gm-Message-State: AO0yUKXFpxUDA5vf+1Hok1vJ5Pq5s9pe+phh3B2AMgZf2FDGxUkIm0AP
        yiF+qA3BDCvSGgeY34khDpA=
X-Google-Smtp-Source: AK7set/afLXu7htiuhpQ+4Gm6vrOnDBn1QpcyY8qfOLbQDh1EmnIq4pTL5gR6VZnnEHYEefHtCe8fA==
X-Received: by 2002:a17:907:a64a:b0:88c:6345:d0e7 with SMTP id vu10-20020a170907a64a00b0088c6345d0e7mr7526261ejc.36.1677713008951;
        Wed, 01 Mar 2023 15:23:28 -0800 (PST)
Received: from [127.0.1.1] (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id s25-20020a1709066c9900b008d5183c1e20sm6298362ejr.190.2023.03.01.15.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 15:23:28 -0800 (PST)
From:   Jakob Koschel <jkl820.git@gmail.com>
Date:   Thu, 02 Mar 2023 00:23:19 +0100
Subject: [PATCH] workqueue: avoid usage of list iterator after loop in
 __flush_workqueue()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230302-workqueue-avoid-iter-after-loop-v1-1-d83324743b99@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGbe/2MC/x2NwQrCMBBEf6Xs2YWY1qL+injYJFu7qEnd2CqU/
 ruJl4HHDG9WyKzCGc7NCsqLZEmxwH7XgB8p3hglFAZrbGtaY/GT9P6aeWakJUlAebMiDTUfKU1
 4CrYPrjv2h85DsTjKjE4p+rF6npTLtBaT8iDf//Xlum0/CF+gRYoAAAA=
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677713008; l=2686;
 i=jkl820.git@gmail.com; s=20230112; h=from:subject:message-id;
 bh=uPCYYOck1Kt4M4RKpI1Q+T0DJ/WEJ39BpG9/LrYfPPU=;
 b=kqXXLAPoBxVuBLQE7K+5gHqqRMsXUlV+wvo76ksuPK5bOtMJElzbeuweoxXeFFRU+kA+C/YGf941
 EYJQicItC27T22953H0JanWg1l6U8Jzti8z896FsKahhBPpGxCZp
X-Developer-Key: i=jkl820.git@gmail.com; a=ed25519;
 pk=rcRpP90oZXet9udPj+2yOibfz31aYv8tpf0+ZYOQhyA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the list_for_each_entry_safe() iteration never breaks, 'next' would
contain an invalid pointer past the iterator loop. To ensure 'next' is
always valid, we only set it if the correct element was found. That
allows adding a WARN_ON_ONCE in case the code works incorrectly,
exposing currently undetectable potential bugs.

Additionally, Linus proposed to avoid any use of the list iterator
variable after the loop, in the attempt to move the list iterator
variable declaration into the macro to avoid any potential misuse after
the loop [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
---
 kernel/workqueue.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b8b541caed48..73aff7b42903 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2982,14 +2982,16 @@ void __flush_workqueue(struct workqueue_struct *wq)
 	WARN_ON_ONCE(wq->flush_color != this_flusher.flush_color);
 
 	while (true) {
-		struct wq_flusher *next, *tmp;
+		struct wq_flusher *next = NULL, *iter, *tmp;
 
 		/* complete all the flushers sharing the current flush color */
-		list_for_each_entry_safe(next, tmp, &wq->flusher_queue, list) {
-			if (next->flush_color != wq->flush_color)
+		list_for_each_entry_safe(iter, tmp, &wq->flusher_queue, list) {
+			if (iter->flush_color != wq->flush_color) {
+				next = iter;
 				break;
-			list_del_init(&next->list);
-			complete(&next->done);
+			}
+			list_del_init(&iter->list);
+			complete(&iter->done);
 		}
 
 		WARN_ON_ONCE(!list_empty(&wq->flusher_overflow) &&
@@ -3006,8 +3008,8 @@ void __flush_workqueue(struct workqueue_struct *wq)
 			 * flusher_queue.  This is the start-to-wait
 			 * phase for these overflowed flushers.
 			 */
-			list_for_each_entry(tmp, &wq->flusher_overflow, list)
-				tmp->flush_color = wq->work_color;
+			list_for_each_entry(iter, &wq->flusher_overflow, list)
+				iter->flush_color = wq->work_color;
 
 			wq->work_color = work_next_color(wq->work_color);
 
@@ -3025,6 +3027,7 @@ void __flush_workqueue(struct workqueue_struct *wq)
 		 * Need to flush more colors.  Make the next flusher
 		 * the new first flusher and arm pwqs.
 		 */
+		WARN_ON_ONCE(!next);
 		WARN_ON_ONCE(wq->flush_color == wq->work_color);
 		WARN_ON_ONCE(wq->flush_color != next->flush_color);
 

---
base-commit: c0927a7a5391f7d8e593e5e50ead7505a23cadf9
change-id: 20230302-workqueue-avoid-iter-after-loop-9d26db48654c

Best regards,
-- 
Jakob Koschel <jkl820.git@gmail.com>

