Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334676EE7B3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjDYStI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbjDYStF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:49:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C5F16F38
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:48:58 -0700 (PDT)
Message-ID: <20230425181827.219128101@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682448536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=yIOPgPMU2Byq9FIQh9CetuDY5vSUSLh17oBNeM4tOuM=;
        b=Q7KpO9S9Qy1OKRhI3+ZciIEtNlVpVhp1KWmgtnPiAYTDFVdWPCtao9Jov7PvP2D1xkjl//
        UdLdE/IwhheCAvEJdoTOLnKr1JqNeoguBYX/GlnNuUjKs9oC7zZXDR9Eea6dpGR5stfFHZ
        ZFA6d7pTB2GXMY0hLhGzjy9TbAgp9oVu8tCKHBe5KJNCu1R1if5UY3r93ZPn1POVqwBETT
        pSRDrU3PXA/3oEcFMXWLec41O2zJo88lY5gzPxrZI6CNljnYLJD9n0stcQepwaT3rFzr2S
        hY/uvpjNkFP47ROQ7nwaaBZU5OB6Bipn4hSVIIzFeducT9wRrdrhLhoJQl1DnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682448536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=yIOPgPMU2Byq9FIQh9CetuDY5vSUSLh17oBNeM4tOuM=;
        b=1ofOAtD2TfK3E8fNXwBEzr5oynzoO7kDcTjCxittXWe1U+xDbWVicRqWr6x2SmkJxFRCxJ
        x1xKqND+jNR3GFCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [patch 00/20] posix-timers: Fixes and cleanups
Date:   Tue, 25 Apr 2023 20:48:55 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

A recent syzcaller/KCSAN report about a data race and an actually broken
loop termination due to that race made me look deeper into the posix timer
code.

Aside of the loop termination issue this unearthed another issue in the
exit() path where timer deletion might livelock on RT enabled kernels.

While going through the code with a fine comb, I stumbled over another
place which needs READ/WRITE_ONCE() annotations, tons of outdated and/or
uncomprehensible comments and a bunch of silly code.

The series has therefore a larger set of cleanups on top of the two fixes.

It is based on

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core

and also availble from git:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git timers/posix

Thanks,

	tglx
---
 include/linux/sched/signal.h |    2 
 kernel/time/posix-timers.c   |  523 ++++++++++++++++++++++++++-----------------
 2 files changed, 321 insertions(+), 204 deletions(-)


