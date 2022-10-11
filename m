Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC085FBB0E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJKTGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiJKTF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:05:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E97B85D;
        Tue, 11 Oct 2022 12:05:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17A49B8166B;
        Tue, 11 Oct 2022 19:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8853AC433D6;
        Tue, 11 Oct 2022 19:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665515150;
        bh=ODHx9TW1R0DNxJe9ifRLST7AHBUBOdF+OZpirGF8FL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aMz05sO0s6UGqiZQacsgQpXGjClkqOx8sQLzSH3vIt49HhKC0i+B+Z+4fssQXq0b4
         00S+4RQjeiJYsw2p688732UayPfQukF1wcY46jNLHsREM9avaAnXOxyaD8cUVUxrGR
         pptN0uVjoEk1KWLe0gJtb8kqhJrus0Rg/OTAMbUBKvMryLX6ETM3ee+aFDnaZefZ+c
         bcXRZ9NJIQxvaXjmH76ymH3ACT8kvTZqc5T+k5OpW1pw5M+wcfSg0XjgSAIOrivKnU
         qbk51fk74ONUwne1ShIFKrTSYjA5P+N6AdE4HsyYmKxy4hk7vyMXTCYcoYAn3QGr3A
         SDqYwfsIBnN5w==
Date:   Tue, 11 Oct 2022 12:05:48 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kasan: disable stackleak plugin in report code
Message-ID: <20221011190548.blixlqj6dripitaf@treble>
References: <20221008132113.919b9b894426297de78ac00f@linux-foundation.org>
 <CAHk-=wigZoriP8ZB+V87Jf+EQV=ka6DQe_HCAQmh3Dmus2FFhw@mail.gmail.com>
 <Y0UoO2+NsJjbZtaf@hirez.programming.kicks-ass.net>
 <20221011184444.npthr2pmzqb32x6z@treble>
 <20221011185907.s3kakdlrxcqr6boh@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221011185907.s3kakdlrxcqr6boh@treble>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kasan_report() has a uaccess critical section which can't have any
instrumentation calls in the middle.  Disable the stackleak plugin for
the report code.

Fixes the following warning:

  vmlinux.o: warning: objtool: kasan_report+0x12: call to stackleak_track_stack() with UACCESS enabled

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 mm/kasan/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index d4837bff3b60..da2976365197 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -27,7 +27,7 @@ CFLAGS_common.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_generic.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_init.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_quarantine.o := $(CC_FLAGS_KASAN_RUNTIME)
-CFLAGS_report.o := $(CC_FLAGS_KASAN_RUNTIME)
+CFLAGS_report.o := $(CC_FLAGS_KASAN_RUNTIME) $(DISABLE_STACKLEAK_PLUGIN)
 CFLAGS_report_generic.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_report_hw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_report_sw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
-- 
2.37.3

