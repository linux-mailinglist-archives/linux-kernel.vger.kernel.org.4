Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296506B6336
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 05:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjCLEt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 23:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCLEt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 23:49:26 -0500
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A774D298
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 20:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
        :MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-ID:Content-Description;
        bh=Tz5MdvnicuIK5Oled/YbXmo8a4UUPo0fLXYCdr9Nq2I=; b=CRmA3GcG03fq5lRifyOr4shGyT
        3nOUV6Lt8UMM3ECiARHV1194WCvXk1pQjnxtdhZTqmTLtXKMW57IeYGuqkkVORmMbyWLLRNOnbA6Q
        fG2uYgtwO1frv0KtDZdMDAcH6c6HM2lbVuZotElk2n4zUM6v3JYKyJtMd1aTuTbpJtkrZWoWy9G9S
        pj15acuRf5ax6MuCDfDhInmz5wmXDXhSsCY5oMFnSHK8EJpUwT32LxT5FBiBoWA0RnljszKDOn1IH
        ixZwRX4OvMxf8VzUoOUjMznFkdlrKuKtxJLXelZPccmLp/AK5b5FhjfdkLtuUyB+/jjkrSZkOZyA5
        aDSWN1Dg==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <anuradha@debian.org>)
        id 1pbDdm-006vpq-Ls; Sun, 12 Mar 2023 04:49:03 +0000
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
Subject: [PATCH v2] sched/rt: Fix unused-const-variable W=1 warning and style issue
Date:   Sun, 12 Mar 2023 10:18:14 +0530
Message-Id: <20230312044815.118970-1-anuradha@debian.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230124190638.124a1c7a@gandalf.local.home>
References: <20230124190638.124a1c7a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205; i=anuradha@debian.org; h=from:subject; bh=rBpOXPu4D0m0c/zpViqEbKcN4Jix1OjTWh9PHnAjvpY=; b=owEBbQKS/ZANAwAKAWNttaHZGGD9AcsmYgBkDVmPPV7a4x7/pnsmBwDBCmaCR/tpyfkbt9pZt siKeTce+f+JAjMEAAEKAB0WIQT1a48U4BTN710Ef8FjbbWh2Rhg/QUCZA1ZjwAKCRBjbbWh2Rhg /cQCD/9h3/okW00OccBnsr3eED4fOk8YD5CDQ+ZE8bgpXbtIy0TWlDm/WY4FP80iHssK++TYvty WpQqII53uBrJOsPv4H/S0BDQAF+XG2vnHqTfgZD1mLuGt0RjQaQ+3j769STFFozfm73tAc8EXBh 1y2SrVLH5KlnfeZxCLSoFRZj8YpuFcVbsjkT3WlLrEkJ7Ujnsctdq/QtmKoJQ9HmZB7MpbkvAN4 8mtH7Sv7D8P5M91+djv6NiZ3VXlpp0fbf800YL/hFmsSf/AEeP56bPTpke/SJIiASB8MMvxOPe8 ie0HAzQI5BNLbECey9dKsIlWnkP0enADQIwyZSRelREW1J90Z6T4gING4XGsJLqGkTNx/IXTNkW wuxxLlEoBRC+4vaV3gPMIxGwSkKxpSZ3n7tfI+iKr910dpz01KWmo1gZPigVA7cR9v9u5jmTbF0 w5Qhr0ROc8iAhSwb0NtD2t16cjRAi1Pgs28YQ32U6jQADgN4U+cBQ1EagSxkZCO7UHK15CPkztv upm06yfUKxSJbCqA9fwV+Xt5MOwk8umqtoPxMKB7C7RjgOg4BlgU3AWzB6yBVZ8kcFzgzTgm3Gg Ddz/NQROqr1YYckTpbJ+UOzJmc5EqOIGYJusSZIDw4Jz9roKHzcnfUrPKydMkSpcGDywNFRbtiz LBqOm24DEWjXDow==
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

Fix by adding __maybe_unused attribute to max_rt_runtime.

Also, fix style issue for "else should follow close brace '}'".

Signed-off-by: Anuradha Weeraman <anuradha@debian.org>
---
 kernel/sched/rt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index ed2a47e4ddae..8cd2e1203a81 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -6,7 +6,7 @@
 
 int sched_rr_timeslice = RR_TIMESLICE;
 /* More than 4 hours if BW_SHIFT equals 20. */
-static const u64 max_rt_runtime = MAX_BW;
+static const u64 __maybe_unused max_rt_runtime = MAX_BW;
 
 static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun);
 
@@ -604,8 +604,7 @@ static void sched_rt_rq_dequeue(struct rt_rq *rt_rq)
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

