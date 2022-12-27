Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7383656A12
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiL0Lvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 06:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiL0Lv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:51:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8CB767C;
        Tue, 27 Dec 2022 03:51:26 -0800 (PST)
Date:   Tue, 27 Dec 2022 11:51:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672141884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H8Oc708uuNRJS/NyoKOl+HJ3muQJ2uYIQmtF0Hxiq/c=;
        b=PgWXviF3Hs9/TjIash8+QSGCcK5LDpOEiMzxD7nqzQtb5UUjqYKkYnoFg3+NDyrRKS/vyL
        qmHDt4T7RT5SmSns/x9WnsAt94X6fKAG6VKZTIMjtjvcglPErReAESIwYY+fnjazYO+PfK
        bt/VZR2VaMdupnWNdZrRr3Y7B9Bz2pvjN9q6dXWDh0XxHWMWq6S9GdRygSgf4+aJ3n0r+u
        lzCTNFLTvT2+wXzJhG7EvxTItsUjGSO3/WDX3OV4rrB95AgcxwbywiDH6CQ9C0M6jnm8LN
        5dma7DJsHKMpuO4aT2L1CWFZUwXU7H+F2369WDU57+sCKTEzTHQCivri7FILgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672141884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H8Oc708uuNRJS/NyoKOl+HJ3muQJ2uYIQmtF0Hxiq/c=;
        b=L6keM0ofsj9qqSg7hCLJ2Fft5nMhufkwI5Z9Oz/91VIvRuSLCoSWgeoGpKNWo9tu+ZGhaO
        Od32EjriSmsWXnAQ==
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf core: Return error pointer if inherit_event()
 fails to find pmu_ctx
Cc:     Dan Carpenter <error27@gmail.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221118051539.820-1-ravi.bangoria@amd.com>
References: <20221118051539.820-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <167214188410.4906.8195204511062431247.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     e2d371484653ac83b970d3ebcf343383f39f8b6b
Gitweb:        https://git.kernel.org/tip/e2d371484653ac83b970d3ebcf343383f39f8b6b
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Fri, 18 Nov 2022 10:45:39 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:44:00 +01:00

perf core: Return error pointer if inherit_event() fails to find pmu_ctx

inherit_event() returns NULL only when it finds orphaned events
otherwise it returns either valid child_event pointer or an error
pointer. Follow the same when it fails to find pmu_ctx.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221118051539.820-1-ravi.bangoria@amd.com
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index eacc370..4bd2434 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13231,7 +13231,7 @@ inherit_event(struct perf_event *parent_event,
 	pmu_ctx = find_get_pmu_context(child_event->pmu, child_ctx, child_event);
 	if (IS_ERR(pmu_ctx)) {
 		free_event(child_event);
-		return NULL;
+		return ERR_CAST(pmu_ctx);
 	}
 	child_event->pmu_ctx = pmu_ctx;
 
