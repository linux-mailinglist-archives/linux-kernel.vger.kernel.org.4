Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBEF6C4645
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjCVJXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjCVJX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:23:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCA5BBA4;
        Wed, 22 Mar 2023 02:23:01 -0700 (PDT)
Date:   Wed, 22 Mar 2023 09:22:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679476945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZUDXQN2TPlL+6pbR5pqWxYbtYIPTF74Zq4msCmdBph4=;
        b=oRoQ9W7g1WSuvCMqTlSBT2IRU7V+W/fCa42V3lre0H3Ty/I4gLfi5qFyQCE4xHDredGQBX
        CE9+4vbIiRRtlUrK6Ij8+pjEL0R/fOT1Xg4sjtMI8vXXBxznyu3FqNtRRrpr7mUfxwiFKJ
        k0nBIkBOryoDe9Vy9xbfQW7tV8+aR8O+KiH4UoBAjzzqFqAQE2dT5feJco7LU0vXxRauQV
        7mvE7W4YVT2PWJUJLQ+4NENu6Q5aPoillUdMjNLJ+XnLIVgpsj4Fh/thb4Ibq8QyI3lKai
        ACjtHtzUR+c7SgTgqsKvRdwsskk2VGpQZRx0KjGRk8Akeks/Rin+Wn/145aTTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679476945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZUDXQN2TPlL+6pbR5pqWxYbtYIPTF74Zq4msCmdBph4=;
        b=dYxcQ1/gLICZ4HhFTYrJNTu2QA/iD1uSLFK8aS6ZXMjt2kqZ+yOqlZGZdjxtCbyoz+xJWp
        XNmm97vi/2T91RBQ==
From:   "tip-bot2 for Tom Rix" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Make sched_energy_mutex,update static
Cc:     Tom Rix <trix@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230314144818.1453523-1-trix@redhat.com>
References: <20230314144818.1453523-1-trix@redhat.com>
MIME-Version: 1.0
Message-ID: <167947694527.5837.14989784602233129020.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d91e15a21d4b3823ce93a42b05f0d171689f4e6a
Gitweb:        https://git.kernel.org/tip/d91e15a21d4b3823ce93a42b05f0d171689f4e6a
Author:        Tom Rix <trix@redhat.com>
AuthorDate:    Tue, 14 Mar 2023 10:48:18 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Mar 2023 10:10:57 +01:00

sched/topology: Make sched_energy_mutex,update static

smatch reports
kernel/sched/topology.c:212:1: warning:
  symbol 'sched_energy_mutex' was not declared. Should it be static?
kernel/sched/topology.c:213:6: warning:
  symbol 'sched_energy_update' was not declared. Should it be static?

These variables are only used in topology.c, so should be static

Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20230314144818.1453523-1-trix@redhat.com
---
 kernel/sched/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 051aaf6..6682535 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -209,8 +209,8 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 DEFINE_STATIC_KEY_FALSE(sched_energy_present);
 static unsigned int sysctl_sched_energy_aware = 1;
-DEFINE_MUTEX(sched_energy_mutex);
-bool sched_energy_update;
+static DEFINE_MUTEX(sched_energy_mutex);
+static bool sched_energy_update;
 
 void rebuild_sched_domains_energy(void)
 {
