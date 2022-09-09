Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF115B326A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiIIIxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiIIIwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:52:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F31812F22A;
        Fri,  9 Sep 2022 01:52:48 -0700 (PDT)
Date:   Fri, 09 Sep 2022 08:52:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662713567;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LH2Yrzlq6HgAGnFEmdUSHMeTdKZDd9kQ2PG6xN8JCL8=;
        b=mWr32pBP4WRK9Rw3xngga66G6tsX3aq0kjPDj7XoqUIczFT26EALtJupCtCYh9B14YucQq
        FgFAzTuX4c0GrnXUyN27/ieJdYfcxkn7cTR3mLqeFg8J3bLRwmuLUDhJYPkBFDqEY1p1dl
        kErJ4mYGCLKFR/XqBPYIufM9oPms2uQgfNf+lxxfR2/1KKLjs2lcE4vFimycHso3BeUpti
        FjsUk5IoO0vGSID+2qkSkUvNjW+xxThWcC/hyS1V0xLKtRSP5B/xuIWzieXF2emhqTCgGg
        eSw5V1bBLt7c7foICNAN6y/LlIUH+9cy23xv+JaRG9QFnc3GlM1Q8Rszj0b4bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662713567;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LH2Yrzlq6HgAGnFEmdUSHMeTdKZDd9kQ2PG6xN8JCL8=;
        b=ZlWSfenOj1JbYOi0klpMv64szeO+KnL2I6Rko531OW9RFNYXhboJNEBYi+qBosI1QCOgD1
        iXgngR1a/ZRYtiAw==
From:   "tip-bot2 for Anshuman Khandual" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Assert PERF_EVENT_FLAG_ARCH does not
 overlap with generic flags
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        James Clark <james.clark@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220907091924.439193-3-anshuman.khandual@arm.com>
References: <20220907091924.439193-3-anshuman.khandual@arm.com>
MIME-Version: 1.0
Message-ID: <166271356595.401.5500525065986281326.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f67dd218fafd9de9a13d095e775b621db76a058f
Gitweb:        https://git.kernel.org/tip/f67dd218fafd9de9a13d095e775b621db76a058f
Author:        Anshuman Khandual <anshuman.khandual@arm.com>
AuthorDate:    Wed, 07 Sep 2022 14:49:22 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:54:00 +02:00

perf/core: Assert PERF_EVENT_FLAG_ARCH does not overlap with generic flags

This just ensures that PERF_EVENT_FLAG_ARCH does not overlap with generic
hardware event flags.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: James Clark <james.clark@arm.com>
Link: https://lkml.kernel.org/r/20220907091924.439193-3-anshuman.khandual@arm.com
---
 include/linux/perf_event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 3e3c075..f88cb31 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -141,6 +141,8 @@ struct hw_perf_event_extra {
 #define PERF_EVENT_FLAG_ARCH			0x000fffff
 #define PERF_EVENT_FLAG_USER_READ_CNT		0x80000000
 
+static_assert((PERF_EVENT_FLAG_USER_READ_CNT & PERF_EVENT_FLAG_ARCH) == 0);
+
 /**
  * struct hw_perf_event - performance event hardware details:
  */
