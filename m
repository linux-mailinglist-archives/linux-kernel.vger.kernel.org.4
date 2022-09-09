Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41BE5B3A3F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiIIOBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbiIIOAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:00:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56CF72EFE;
        Fri,  9 Sep 2022 07:00:20 -0700 (PDT)
Date:   Fri, 09 Sep 2022 14:00:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662732019;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x5w+y+WjNrCtV+Ss463MRTo/oExf3wBRmSDXnqwL3VI=;
        b=aa2XRaWI6M56kVKVEVRq6pDDZUZLzIEULOi8fFaDPWSMwNXNhjtX5C1ZjwfBXEAaXCOuqG
        +4w+R8UsITo6QIYOGO0gaIdv0KPHsmiS7NQG2vjZUgf7By6X2wqOHkhYUcZ8Onu+szkCic
        DbvRFzQqlgZYS2qJ6Enc+egO/rJ/2QRvlC2DkOOIYqxbMikjkf0U2cujbN1pY7+417y6Jc
        KsSxcd8XgGLx4k95vMe+sdg6r2opagNBJrykNaAld7ZAuLmslzXgz6EhBVnFHnUIschuCs
        YPs/6P2u9ZnRSPaZlgUrGfkSzqh6/ZryYkXc36iOkeBgSm2MoMYvklRvePjcEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662732019;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x5w+y+WjNrCtV+Ss463MRTo/oExf3wBRmSDXnqwL3VI=;
        b=zkBHfJqKO8CVVndRwDA+ZusxiF+K1yFzmqfd3tSjhi5j+M9TIsyLoHn/m4fZ+ExwBxEIQH
        fadSNIG/8HzPi7Cw==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/psi] sched/psi: Don't create cgroup PSI files when psi_disabled
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220825164111.29534-3-zhouchengming@bytedance.com>
References: <20220825164111.29534-3-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <166273201827.401.2854791490008009050.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/psi branch of tip:

Commit-ID:     58d8c2586cedb8a67f6f0dffa5eaed0f89135b39
Gitweb:        https://git.kernel.org/tip/58d8c2586cedb8a67f6f0dffa5eaed0f89135b39
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Fri, 26 Aug 2022 00:41:03 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 09 Sep 2022 11:08:31 +02:00

sched/psi: Don't create cgroup PSI files when psi_disabled

commit 3958e2d0c34e ("cgroup: make per-cgroup pressure stall tracking configurable")
make PSI can be configured to skip per-cgroup stall accounting. And
doesn't expose PSI files in cgroup hierarchy.

This patch do the same thing when psi_disabled.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lore.kernel.org/r/20220825164111.29534-3-zhouchengming@bytedance.com
---
 kernel/cgroup/cgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 718a70c..96aefdb 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3780,6 +3780,9 @@ static void cgroup_pressure_release(struct kernfs_open_file *of)
 
 bool cgroup_psi_enabled(void)
 {
+	if (static_branch_likely(&psi_disabled))
+		return false;
+
 	return (cgroup_feature_disable_mask & (1 << OPT_FEATURE_PRESSURE)) == 0;
 }
 
