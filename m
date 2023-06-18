Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAC0734858
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 22:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjFRUuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 16:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjFRUuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 16:50:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1D3E49;
        Sun, 18 Jun 2023 13:50:01 -0700 (PDT)
Date:   Sun, 18 Jun 2023 20:49:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687121400;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N7RBMQAyFoU1tLMB7KHZWr2nij7mtaFgUK/OgRAYfUw=;
        b=v0QtCh3e7hZrqp4xBt3Wjfw6DFrUO5dNwCq9ZXuRHvYSpbuvIS7ATP1BE8jWlcWC/c8DX3
        SUmmrBHNS91zKPjhjM1AULEquw5X1CkPnwNS+Wiy8UEgFP2Xi68P8wCTKfY8osEf0dovvN
        /T5grC1RrhWVmNYW6x9iSgomZGz3mUc2nialW7kU0Gha2GljbA6PU/T/JAalEprr536R6r
        uX59vPfk/glTV4+lahLO3TMTNj7bXFaepPmmoBrLMY4d13wWlL51TrizwxlPH40Gx489Bj
        TwDCNG9O7wnvWrv5SvXZHQKfxHeph7ad54Ii/0xLiYSx3S68DEGz42pQwEdK2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687121400;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N7RBMQAyFoU1tLMB7KHZWr2nij7mtaFgUK/OgRAYfUw=;
        b=xvCAAGz+ZkdQu3wRaKDYQXi68d1Fy6jqo25CQx4bvO8GfueKc774Sfjep7JaE/1h+V9gpl
        FHFHBRhqlavyElAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Document nanosleep() details
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230425183313.567072835@linutronix.de>
References: <20230425183313.567072835@linutronix.de>
MIME-Version: 1.0
Message-ID: <168712139985.404.3194019800908036645.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     640fe745d7d4b6e47f3b455cb5de99a08c6b6d23
Gitweb:        https://git.kernel.org/tip/640fe745d7d4b6e47f3b455cb5de99a08c6b6d23
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:17 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 18 Jun 2023 22:41:51 +02:00

posix-timers: Document nanosleep() details

The descriptions for common_nsleep() is wrong and common_nsleep_timens()
lacks any form of comment.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230425183313.567072835@linutronix.de

---
 kernel/time/posix-timers.c |  9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 03ef6af..54adb4c 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1370,7 +1370,7 @@ SYSCALL_DEFINE2(clock_getres_time32, clockid_t, which_clock,
 #endif
 
 /*
- * nanosleep for monotonic and realtime clocks
+ * sys_clock_nanosleep() for CLOCK_REALTIME and CLOCK_TAI
  */
 static int common_nsleep(const clockid_t which_clock, int flags,
 			 const struct timespec64 *rqtp)
@@ -1382,8 +1382,13 @@ static int common_nsleep(const clockid_t which_clock, int flags,
 				 which_clock);
 }
 
+/*
+ * sys_clock_nanosleep() for CLOCK_MONOTONIC and CLOCK_BOOTTIME
+ *
+ * Absolute nanosleeps for these clocks are time-namespace adjusted.
+ */
 static int common_nsleep_timens(const clockid_t which_clock, int flags,
-			 const struct timespec64 *rqtp)
+				const struct timespec64 *rqtp)
 {
 	ktime_t texp = timespec64_to_ktime(*rqtp);
 
