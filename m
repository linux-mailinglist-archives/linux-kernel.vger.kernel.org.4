Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84467673E99
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjASQXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjASQXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:23:35 -0500
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030D75D7E4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
        :MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=75ZTUtmXxImxf/4SfvBBs7mx0Ck6Xht0V7SxXTOl+RQ=; b=M8j1ocol7bxTnHNch55MzRcsJ2
        SefErejGVLYAbUi8mbmTRTimaZyTDnmHdEIE6Cbd+MaRDy6npGQMUliOdqLa7193RciCuYpg3boMv
        U4SmqgQXqbQRK+o6tNtlvLTwoKwRshcU6QZ3H7s2pfYqK0nftQA1PNz8rbd6TOvqCj78kwuMLuihU
        8v39EakCz70qJ8/mnpIT8uSLe2+CNYuTaiBuz908VeB6PqrArMSwx/v/z2GNVRUDnreSoo3tehw5s
        mlnR2K8mQJBkDpB/C177kUIfpb35QV6cCYEuhkva10JIo3ZmDsLmfnwMz1CcCmju0xS0/QP5OSO2C
        QAu/l09Q==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <anuradha@debian.org>)
        id 1pIXh0-00BmzM-S9; Thu, 19 Jan 2023 16:23:11 +0000
From:   Anuradha Weeraman <anuradha@debian.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     anuradha@debian.org
Subject: [PATCH] sched/rt: Fix unused-const-variable W=1 warning and style issue
Date:   Thu, 19 Jan 2023 21:52:32 +0530
Message-Id: <20230119162233.887915-1-anuradha@debian.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1329; i=anuradha@debian.org; h=from:subject; bh=vL43IVWMaiuIGcaoY6pIwiJ85yvteGiqbV4ccFoDt8Y=; b=owEBbQKS/ZANAwAKAWNttaHZGGD9AcsmYgBjyW5FyaaeUzhZDI37mfV71ho3ee+y4uyMPXgKs6sZ +hnw63yJAjMEAAEKAB0WIQT1a48U4BTN710Ef8FjbbWh2Rhg/QUCY8luRQAKCRBjbbWh2Rhg/U3YD/ 9oL/fUkscxw27ARgVDIjmYXsIY2rxPWQS8WTY5P8T61JeaO02sqytdqyzxEBg21ug82zm+gHRoTbvU bTu6jt1abX1njtGQWp+wMsbhX+evY/MnlJ+libKBASFzVPTzmAvzkXHmLnJ0shcbgUimfry2snfsmR kqixC+EXeMIzvORiQuApQj//vTTtfEJMmW7nCcwChUVpCa3J5s1BbEVMeSd+o8TngLOelbXwROdsPt R7Lewwd1GFWwe/0nKZqzRtxPdtFkr+KKpfdk94x3Y9F7wDoUU7sjZj85IiSs1ffFi686QUMU0I9StM ++VvanW/8dcOClmQItTcuutnr3yfIzbtKYZz3XUDDDulZiT+8G0bTDD5feXWvbmgGDZNo6vFC2epxA kpQQez+CWalto6tbvKQWKCEU6OdvF3uwrSjLBYwrGv0EqSWKcn44foYYozR+3dOYMSwdqhcjoAYUiH TH4ar/DXmg/XHTj9ZS9gtuLHZQedLJ0rBZryDWoHUw3OpOEa9MrJlODMoLDXiEUeNjdWPNLsm/0oZ1 4ZqD4zzj+DnDjUAVU4lDSbqZnjCO2MaNDLQFk5r+SF/jvGXIsTj63To0ogLzXqEKjLyBnYizfTM7mI vBoDW8yf2xcrEKJXkWSk/yW9oCGOujkLPfWq4yaJfJkJgeHv51HJC7W8eZdg==
X-Developer-Key: i=anuradha@debian.org; a=openpgp; fpr=F56B8F14E014CDEF5D047FC1636DB5A1D91860FD
Content-Transfer-Encoding: 8bit
X-Debian-User: anuradha
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiler warning with W=1 due to unused constant in
    kernel/sched/rt.c:9:18: warning: ‘max_rt_runtime’ defined but not used

Fix by wrapping the variable in an #if check for CONFIG_SYSCTL and
CONFIG_RT_GROUP_SCHED, which are the only blocks where this variable
is referenced from.

Also, fix style issue for "else should follow close brace '}'".

Signed-off-by: Anuradha Weeraman <anuradha@debian.org>
---
 kernel/sched/rt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index ed2a47e4ddae..e46e76893a0c 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -5,8 +5,11 @@
  */
 
 int sched_rr_timeslice = RR_TIMESLICE;
+
+#if defined(CONFIG_SYSCTL) || defined(CONFIG_RT_GROUP_SCHED)
 /* More than 4 hours if BW_SHIFT equals 20. */
 static const u64 max_rt_runtime = MAX_BW;
+#endif
 
 static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun);
 
@@ -604,8 +607,7 @@ static void sched_rt_rq_dequeue(struct rt_rq *rt_rq)
 		dequeue_top_rt_rq(rt_rq, rt_rq->rt_nr_running);
 		/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
 		cpufreq_update_util(rq_of_rt_rq(rt_rq), 0);
-	}
-	else if (on_rt_rq(rt_se))
+	} else if (on_rt_rq(rt_se))
 		dequeue_rt_entity(rt_se, 0);
 }
 
-- 
2.39.0

