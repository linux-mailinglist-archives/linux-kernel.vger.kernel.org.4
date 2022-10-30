Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF42612D30
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 23:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJ3WCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 18:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiJ3WCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 18:02:16 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98297BC31
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 15:02:12 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l6so8933325pjj.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 15:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7XieXpcJrzhapQHtWCNoW0rQy5yiKhkq34SDOyw0xw=;
        b=Z2rp9mxaTzm5Kh46RSwGk7G6rZY/KQhbeDA2IAjzJGp/KbgOvSg7hhvjOqyULqd566
         //TWc8mDkHbQ+DYXM0UrXa1OFHB+kcFlfhSr5EpBPAZ4BenGOAV8UQytYF1B2Zu15GZW
         5wSN+m6knpruLvqwjn/CbyS0LcSLGDOxBx2XJBPBYD36NcCOwgnf8PE0K83/qoHEWITB
         CoB+1QFBWq2K9ejFNlUmTFH4z4jR/GN1EKDtyv0QkZWRvmvLrhnWvunYux57608rO2K1
         NyfP1zPcMuWKUItcpD6jYYjGRh9hLNQQpDbfHBw2vNSNUUlLYIpcgwApfo0fwBwOZ87a
         d44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7XieXpcJrzhapQHtWCNoW0rQy5yiKhkq34SDOyw0xw=;
        b=T8Rad4xsqogYtRXMSTdVoXUXX8a4Qmpn5tBZIdfq8Zoc2IYE/L1491eMLtwNP++PsF
         UEBMZ2lpShdekq8joZCjxPdWQpfyKC8TdsjZkVOMrXcctGkF8F9gwjd2PHQnl+4hqZ9C
         mMVQ/xlcA9YJQFKQTEzPBTPGUtLZbjYCQ36LI1e1sdnxsE18wvkE+6Ya/LvuDy92j2mG
         ttKOdKvZ3Vmg3DqRSjAFUz2rbKNPMWYalrlOrrvrq3OcadQFV8q+Z8VmsvQiIiF8N1ZP
         rqsd4OR9HBExQ+92pIqUTDUbeTpPLdwBXKGZHiQEqVKnS+nGWV1ezv2TpIBbIJvSLFP8
         tEOQ==
X-Gm-Message-State: ACrzQf0xM0fapMIKn/zXGMKaSxUUhKHZUlNiF1mM9BWE11LFy8oY3W9G
        cFoKh/bYE5puc0ZuHrsEmi1PoQGFjN15GAqT
X-Google-Smtp-Source: AMsMyM4tMCu7URYFgaAQZgnaRiMY0iyFuLab70utjXxpA0cL2CeaZK4UGziOCx2oR15XKHFOeUNPiQ==
X-Received: by 2002:a17:903:258b:b0:186:8bb2:de32 with SMTP id jb11-20020a170903258b00b001868bb2de32mr11380804plb.63.1667167331690;
        Sun, 30 Oct 2022 15:02:11 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79e03000000b0056d73ef41fdsm562852pfq.75.2022.10.30.15.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 15:02:11 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/6] eventpoll: move expires to epoll_wq
Date:   Sun, 30 Oct 2022 16:02:01 -0600
Message-Id: <20221030220203.31210-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221030220203.31210-1-axboe@kernel.dk>
References: <20221030220203.31210-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the expiration available to the wakeup handler. No functional
changes expected in this patch, purely in preparation for being able to
use the timeout on the wakeup side.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/eventpoll.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 888f565d0c5f..0994f2eb6adc 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1765,6 +1765,7 @@ static int ep_autoremove_wake_function(struct wait_queue_entry *wq_entry,
 struct epoll_wq {
 	wait_queue_entry_t wait;
 	struct hrtimer timer;
+	ktime_t timeout_ts;
 	bool timed_out;
 };
 
@@ -1825,7 +1826,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 {
 	int res, eavail;
 	u64 slack = 0;
-	ktime_t expires, *to = NULL;
+	ktime_t *to = NULL;
 	struct epoll_wq ewq;
 
 	lockdep_assert_irqs_enabled();
@@ -1834,7 +1835,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 
 	if (timeout && (timeout->tv_sec | timeout->tv_nsec)) {
 		slack = select_estimate_accuracy(timeout);
-		to = &expires;
+		to = &ewq.timeout_ts;
 		*to = timespec64_to_ktime(*timeout);
 	} else if (timeout) {
 		/*
-- 
2.35.1

