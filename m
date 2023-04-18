Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389EF6E674A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjDROjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDROi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:38:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F317A448E;
        Tue, 18 Apr 2023 07:38:56 -0700 (PDT)
Date:   Tue, 18 Apr 2023 16:38:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681828735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=HDWs2ddjtNGHMlnGV0ZEvDXQY8w3gDQpVYK7AV0UPeM=;
        b=NBZYVBatqhtjwKHQ5vPt8VNVjpzPLJWQ5ocxzLNpS5CvbX88osqVD1IlNnnOUo8Y4oRHM8
        VxV3qlpujjYbTOxbY0ukfx0ub9H6bXxbV4sWxNKZWcxwbDqMKsT1miEtNSDV+o7+zinIc+
        xIYAElLGGaKXjQoimk5dcROOT5iE1bU+bBB9WYds13aAxhujX8oDGPQwJ5XzGT2D079ZcN
        bmB92Ah5XFiaV3PvkASobNMA9ZqWBmpFbaCBibuUQTdG7K04dbEgjIl4csZIAYf8j36KcD
        P1a8klNLECKDajx2yaQbncfIKMQCsY4V25v6aqJHgwPBHj5vqjd0+sYYE7wrSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681828735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=HDWs2ddjtNGHMlnGV0ZEvDXQY8w3gDQpVYK7AV0UPeM=;
        b=1a7Le/7KspJHQ+qTPfNPzGWYt1DvHAOu29Huc/FQm6XkCacKlPN60IZyZ9j4qc1SlXKNOj
        whrW4glXW0Bcd7Aw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] tracing/timer: Add missing hrtimer modes to
 decode_hrtimer_mode().
Message-ID: <20230418143854.8vHWQKLM@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trace output for the HRTIMER_MODE_.*_HARD modes is seen as a number
since these modes are not decoded. The author was not aware of the fancy
decoding function which makes the life easier.

Extend decode_hrtimer_mode() with the additional HRTIMER_MODE_.*_HARD
modes.

Fixes: ae6683d815895 ("hrtimer: Introduce HARD expiry mode")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/trace/events/timer.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 2e713a7d9aa3a..5d43751a766c6 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -158,7 +158,11 @@ DEFINE_EVENT(timer_class, timer_cancel,
 		{ HRTIMER_MODE_ABS_SOFT,	"ABS|SOFT"	},	\
 		{ HRTIMER_MODE_REL_SOFT,	"REL|SOFT"	},	\
 		{ HRTIMER_MODE_ABS_PINNED_SOFT,	"ABS|PINNED|SOFT" },	\
-		{ HRTIMER_MODE_REL_PINNED_SOFT,	"REL|PINNED|SOFT" })
+		{ HRTIMER_MODE_REL_PINNED_SOFT,	"REL|PINNED|SOFT" },	\
+		{ HRTIMER_MODE_ABS_HARD,	"ABS|HARD" },		\
+		{ HRTIMER_MODE_REL_HARD,	"REL|HARD" },		\
+		{ HRTIMER_MODE_ABS_PINNED_HARD, "ABS|PINNED|HARD" },	\
+		{ HRTIMER_MODE_REL_PINNED_HARD,	"REL|PINNED|HARD" })
 
 /**
  * hrtimer_init - called when the hrtimer is initialized
-- 
2.40.0

