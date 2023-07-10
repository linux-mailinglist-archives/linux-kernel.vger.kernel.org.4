Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DEF74DE27
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjGJTZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGJTZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:25:27 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A4DE6E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:25:01 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e429e1eabso4312946a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689017099; x=1691609099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jAJrLaj81nDh4wW1pP27vJFmY8UiJKSEaQ+/Hb04Nc=;
        b=hnX3o4peRysHE4PlLHbB9M+JugRMzR7VVp6giACiIXm0TS66MpvDNrmpEM20fnHH2A
         oSFUd0VYZ/MdWgmzGsmXue6dq2b+VMz3GxtLT1LjmN2vOJPTyB1MlJVUP4Zg1582I7Ih
         bvByd4d2/2KrUOhapdZ5gYfpSGWLMwWzS/Wj/NbCJxGevCFI9QeDcs9Auy4zAcVQ/Tf8
         inx384WtL7/fUnA4qAcq/gmiQWcOE2I+2JT4Su/1IT5W/UTbkLOtSMHLNoEqNw2olwUV
         YBlaAEf7Uv05hM5H6jTxldHdo0TkB+So0trN2HA+X0Z1MAsWYaG52b6cC+vifMgd8TY2
         hLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689017099; x=1691609099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jAJrLaj81nDh4wW1pP27vJFmY8UiJKSEaQ+/Hb04Nc=;
        b=la9/tb9bYitJ1FN4MvdaML+FCTPS9XGzJ3P6qg6y5b6ECUoQaRoVf4gzxW6or3/oHw
         MRHsmt1SqE3tPk4zy/eRWRtz3UcTvMAEeIz1CZChOKj4uVnes0WxuT6jAzPTBbrPDUWj
         R+y2F3U2BdYXOLbYsxNeOjrX/v/+0t8Awh9wQh78PdMuZyH55bSU2KnHZzR83glE4U5u
         YJIAJpG8UeiyCo7Gdyl6GbCZ+oHMuEfZQLJD0ExhsCTh3dNVFX8LzOkCoFReyWRhbKVm
         LJXqOdWLA2Vwc6wcLG42G60CfRai99HxLi3NZWji/22f7JOME26Q5Qwyn90hh52pcuP3
         7kLQ==
X-Gm-Message-State: ABy/qLZSpzs3nUQ0ISlib4AMsxbvZ6DNmBAauBpda114EB1j7XD7Bop3
        rpYOb/tJRV1H9QQX3Wof022XjXT+kyWbfVAr
X-Google-Smtp-Source: APBJJlHwVT5frp02REiaP08Tw2FykEOwGxdLWWsPCiw5aMtj6jXyTUwf06D5IHzSoxQJfVL+VWOmXA==
X-Received: by 2002:a17:906:5307:b0:993:f996:52d3 with SMTP id h7-20020a170906530700b00993f99652d3mr6394846ejo.25.1689017099074;
        Mon, 10 Jul 2023 12:24:59 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id w15-20020a170906480f00b0096a6be0b66dsm110076ejq.208.2023.07.10.12.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 12:24:58 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: [PATCH 3/3] xen: Illustrate the transition to sync_try_cmpxchg
Date:   Mon, 10 Jul 2023 21:21:56 +0200
Message-ID: <20230710192440.47140-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710192440.47140-1-ubizjak@gmail.com>
References: <20230710192440.47140-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch illustrates the transition to sync_try_cmpxchg.
It is not intended to be merged as-is.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 drivers/xen/events/events_fifo.c | 26 ++++++++++++--------------
 drivers/xen/grant-table.c        | 10 ++++------
 2 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/xen/events/events_fifo.c b/drivers/xen/events/events_fifo.c
index ad9fe51d3fb3..655775db7caf 100644
--- a/drivers/xen/events/events_fifo.c
+++ b/drivers/xen/events/events_fifo.c
@@ -226,21 +226,20 @@ static bool evtchn_fifo_is_masked(evtchn_port_t port)
  */
 static bool clear_masked_cond(volatile event_word_t *word)
 {
-	event_word_t new, old, w;
+	event_word_t new, old;
 
-	w = *word;
+	old = *word;
 
 	do {
-		if (!(w & (1 << EVTCHN_FIFO_MASKED)))
+		if (!(old & (1 << EVTCHN_FIFO_MASKED)))
 			return true;
 
-		if (w & (1 << EVTCHN_FIFO_PENDING))
+		if (old & (1 << EVTCHN_FIFO_PENDING))
 			return false;
 
-		old = w & ~(1 << EVTCHN_FIFO_BUSY);
+		old = old & ~(1 << EVTCHN_FIFO_BUSY);
 		new = old & ~(1 << EVTCHN_FIFO_MASKED);
-		w = sync_cmpxchg(word, old, new);
-	} while (w != old);
+	} while (!sync_try_cmpxchg(word, &old, new));
 
 	return true;
 }
@@ -259,17 +258,16 @@ static void evtchn_fifo_unmask(evtchn_port_t port)
 
 static uint32_t clear_linked(volatile event_word_t *word)
 {
-	event_word_t new, old, w;
+	event_word_t new, old;
 
-	w = *word;
+	old = *word;
 
 	do {
-		old = w;
-		new = (w & ~((1 << EVTCHN_FIFO_LINKED)
-			     | EVTCHN_FIFO_LINK_MASK));
-	} while ((w = sync_cmpxchg(word, old, new)) != old);
+		new = (old & ~((1 << EVTCHN_FIFO_LINKED)
+			       | EVTCHN_FIFO_LINK_MASK));
+	} while (!sync_try_cmpxchg(word, &old, new));
 
-	return w & EVTCHN_FIFO_LINK_MASK;
+	return old & EVTCHN_FIFO_LINK_MASK;
 }
 
 static void consume_one_event(unsigned cpu, struct evtchn_loop_ctrl *ctrl,
diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index e1ec725c2819..211d083d4fbe 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -427,16 +427,14 @@ EXPORT_SYMBOL_GPL(gnttab_grant_foreign_access);
 
 static int gnttab_end_foreign_access_ref_v1(grant_ref_t ref)
 {
-	u16 flags, nflags;
-	u16 *pflags;
+	u16 *pflags = &gnttab_shared.v1[ref].flags;
+	u16 flags;
 
-	pflags = &gnttab_shared.v1[ref].flags;
-	nflags = *pflags;
+	flags = *pflags;
 	do {
-		flags = nflags;
 		if (flags & (GTF_reading|GTF_writing))
 			return 0;
-	} while ((nflags = sync_cmpxchg(pflags, flags, 0)) != flags);
+	} while (!sync_try_cmpxchg(pflags, &flags, 0));
 
 	return 1;
 }
-- 
2.41.0

