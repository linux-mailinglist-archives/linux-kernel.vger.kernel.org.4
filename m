Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC8B6D939F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 12:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbjDFKFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 06:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjDFKFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:05:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399C55FCF;
        Thu,  6 Apr 2023 03:05:08 -0700 (PDT)
Date:   Thu, 06 Apr 2023 10:05:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680775505;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G9bnni2qE+KJKUu6Bc/CyqquYnVEcMbzQozYy1BO+BI=;
        b=nfX1T98dWe3IfkI85QD8rAassbC/Vq9vh81/5WhVBC7xQFDenWuJkkvC8U+gbXuKGvtsHU
        R1m/UuKSXyLquDGnFSaj5KXUBiBvlKCT3rNsiibFKP4wuTcx74yx+iYBu/XTALsl/9rfoL
        AnKHbtm6DcdrT8aNTBogMQPhPDFCXPph/j/qhHDAe7gIbbnD6OzA0F0smHZtUGtVZdF7dg
        JE6Mc0gJC16c2UaRDHZIEP6UGEwxHJNN6mvxXDfRqn2VDz4iCzX7RdabONAeU3fqcOMHyL
        2bk5slWNz/VCeDNpXnCTV+tRII9k6h6h1v6nez+FDq5Sdn/LovbrWFWO5dV7jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680775505;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G9bnni2qE+KJKUu6Bc/CyqquYnVEcMbzQozYy1BO+BI=;
        b=0rT0U5uopLKHRXjnAlS80z7pH6mTRsnS3gdRZsYY8Jn+CBw1CjhY2WjdKjoDhPkbRfNqJ1
        vr/D+xR3aJQ7zPDw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Fix the same task check in
 perf_event_set_output
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230322202449.512091-1-kan.liang@linux.intel.com>
References: <20230322202449.512091-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <168077550501.404.1381259757947658488.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     24d3ae2f37d8bc3c14b31d353c5d27baf582b6a6
Gitweb:        https://git.kernel.org/tip/24d3ae2f37d8bc3c14b31d353c5d27baf58=
2b6a6
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 22 Mar 2023 13:24:49 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 05 Apr 2023 09:58:46 +02:00

perf/core: Fix the same task check in perf_event_set_output

The same task check in perf_event_set_output has some potential issues
for some usages.

For the current perf code, there is a problem if using of
perf_event_open() to have multiple samples getting into the same mmap=E2=80=
=99d
memory when they are both attached to the same process.
https://lore.kernel.org/all/92645262-D319-4068-9C44-2409EF44888E@gmail.com/
Because the event->ctx is not ready when the perf_event_set_output() is
invoked in the perf_event_open().

Besides the above issue, before the commit bd2756811766 ("perf: Rewrite
core context handling"), perf record can errors out when sampling with
a hardware event and a software event as below.
 $ perf record -e cycles,dummy --per-thread ls
 failed to mmap with 22 (Invalid argument)
That's because that prior to the commit a hardware event and a software
event are from different task context.

The problem should be a long time issue since commit c3f00c70276d
("perk: Separate find_get_context() from event initialization").

The task struct is stored in the event->hw.target for each per-thread
event. It is a more reliable way to determine whether two events are
attached to the same task.

The event->hw.target was also introduced several years ago by the
commit 50f16a8bf9d7 ("perf: Remove type specific target pointers"). It
can not only be used to fix the issue with the current code, but also
back port to fix the issues with an older kernel.

Note: The event->hw.target was introduced later than commit
c3f00c70276d. The patch may cannot be applied between the commit
c3f00c70276d and commit 50f16a8bf9d7. Anybody that wants to back-port
this at that period may have to find other solutions.

Fixes: c3f00c70276d ("perf: Separate find_get_context() from event initializa=
tion")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Link: https://lkml.kernel.org/r/20230322202449.512091-1-kan.liang@linux.intel=
.com
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 115320f..435815d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12173,7 +12173,7 @@ perf_event_set_output(struct perf_event *event, struc=
t perf_event *output_event)
 	/*
 	 * If its not a per-cpu rb, it must be the same task.
 	 */
-	if (output_event->cpu =3D=3D -1 && output_event->ctx !=3D event->ctx)
+	if (output_event->cpu =3D=3D -1 && output_event->hw.target !=3D event->hw.t=
arget)
 		goto out;
=20
 	/*
