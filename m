Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7574D74D30D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjGJKMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbjGJKMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:12:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807BB30CB;
        Mon, 10 Jul 2023 03:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688983789; x=1689588589; i=efault@gmx.de;
 bh=vWxlwa4RN2N9hCfbf+/JCap4SdbQGfrMduX8vY3ZB1Q=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=acKTHLDGhEpYgiiLy05zde2QBnjexFuWwDShuva21z5qMEuZfxFfKmBWsRzizkCJh9ugjMm
 sLsmL1eczBjg8lHlHU3UQPsoD3at85qzTvgop9Va/Ps1dnRp60gDh3jUfUuDFW7ZavmHfOLdA
 NBxkzMQDF/tNCG2IFrMOtScXiOq6xQWpBywATC76t+CDawDEBNAKpAPtEfc4MNnKPI1c730Jq
 agh8L64VC+evOa5O3R6NfTbdCzmmnsrN+nEg/P8tBUVS+YgzGPNd3eVet9TIe6I8EDwqwmy25
 LsnarIp/VPY9lcB3oojhiDOJ0kDd+dP+Zf5Ud+jTiSboCUbbvABg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([212.114.172.150]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXp9i-1qUqVF0shw-00Y7JF; Mon, 10
 Jul 2023 12:09:49 +0200
Message-ID: <ae3f172d49bcf1af3c0e566bbc4f2967c9e65f2e.camel@gmx.de>
Subject: Re: [RT] i915 sleeping function from atomic in gen6_reset_engines()
From:   Mike Galbraith <efault@gmx.de>
To:     Juri Lelli <juri.lelli@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 10 Jul 2023 12:09:48 +0200
In-Reply-To: <ZKuxdVJcsHdcbmYs@localhost.localdomain>
References: <Y86wDg/EZfJOnlwJ@localhost.localdomain>
         <ZKuxdVJcsHdcbmYs@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K+FXX+fFHhKvdViZsyA5JZWWh9/pnar6JS32Z8a7OeoTL9Zsocn
 BS417dzkhMqTFL0uDks1APmPaQ0etEePvvL2zRlS16uLLMhavZN7tDwlgVyNXVB8CY35JOj
 1ZumGsh1v/rS/qL85Fw76WlasM0OzgeKNI8FIJX9oa4UkaFYslQUAfo6G7ClN1S0x51c+QC
 SJD/RfXTwXOy2oVlhpg6g==
UI-OutboundReport: notjunk:1;M01:P0:764qi3taeGo=;IPreEhDeXoRwmgwZLw/CaoiHSZv
 IiaESumeUfAeiOlhg731rUmN9cicxfO/w+GWAGbjIkl2n6uOF42BKZddbdAjcwfrRBUqK3+bn
 yeD/3HxSEWVPLDj0RNMzhzKcyBd55Y8A/73o258s8OJtLs0/pHetS6tmefpzNMYJ1f3ibfpN9
 iVKXzsgJcA19U/2S95R6HyRPbYAw6f2c3RcsmxSaZ+YBgg8KLh2QTQCzsqJ3HNZ0WsY5yv4L0
 JfL4N1nF6rWb8HZI7MSzwKC9MqNjVsqY/5qPNrrqmsO9iP0RFW+Vya9tQB/WR6UPsTTTgwNYW
 DE400zYGHznABmZhQVrlqe6FSIpwz0zeFSMnhzxfhy99mhWi1FJ5Bp8g2lP3fM0Znf2+g4Wi4
 2mFm9taXpr5zvOA+D2ClMiANpoHm3zGs5WrJ6PpEIFUV1XEaoFAJYA5e1pw88PFOC2T9vdLY0
 2TnK0OQ5M12EG0ppque55S9MbuUFnE5++RQxqaF6K94/eYqWYh3eI0GrhfimRFqkZ4z3BIFUO
 9OQIbQ9cg2nPs8FvhK78s6c9yi8AdsIoPilABq0YZW5w6qwu8XpltKkpxYGodkXb2uJ3Wr1yN
 0sNyLOPzHksyAd9YTMQBl59kJp1BNNgXwXxFMpxt8NFYxIFQIVsWZGp8diY8NdkNcWxoNFve0
 HzcZ9nFCXQmsyzMUHvQy+A/AL/bCWSFrZ5Sih9NrBMKuHKE+wXYWSKGQBhqaNqH/AgEY/23rL
 MYFbDqTmpzpEM40TwVwGe0/OhWBjjivvhX9MCEvob/I3KX0IPTAiLhmqfvdkP4fqIpIL8ngjH
 1eiO0Fb8QJNSaLkSL2T7UgwrlKMquY7z6RCionn6v0CibxO3DOcfHH7d3maUCZMz/HGtARNx7
 ah3TFnlawkIiHrdk+9/tUgNHxOOfi2R/bEI9zZOjzfV+5+Kahjm5ZHdXNIP8Q7b833Te4IUB8
 ihdeVYVjAXveQayJkxGqTHvfuZA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-07-10 at 09:21 +0200, Juri Lelli wrote:
> Hi!
>
> On 23/01/23 17:04, Juri Lelli wrote:
> > Hi,
> >
> > I've just noticed the following while testing v6.2-rc3-rt1.
>
> I'm still seeing the following on v6.4-rt6.
>
> I believe 20211006164628.s2mtsdd2jdbfyf7g@linutronix.de=C2=A0should cure=
 it,
> but I don't think it did go anywhere?

The raw lock cyclictest deltas don't look great.  I shut it up with the
below.  For my i915 equipped lappy, a raw lock fix would be just fine,
its cyclictest numbers already being well south of 'oh dear'.

Subject: drm,i915: Don't disable preemption in __intel_gt_reset() for PREE=
MPT_RT
From: Mike Galbraith <efault@gmx.de>
Date: Wed Dec  7 10:13:21 CET 2022

 BUG: sleeping function called from invalid context at kernel/locking/spin=
lock_rt.c:46
 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 330, name: systemd=
-udevd
 preempt_count: 1, expected: 0
 RCU nest depth: 0, expected: 0
 Preemption disabled at:
 [<ffffffffa090e08e>] __intel_gt_reset+0x6e/0xe0 [i915]
 CPU: 0 PID: 330 Comm: systemd-udevd Tainted: G          I E      6.1.0.g8=
ed710d-master-rt #27
 Hardware name: HP HP Spectre x360 Convertible/804F, BIOS F.47 11/22/2017
 Call Trace:
  <TASK>
  dump_stack_lvl+0x33/0x46
  ? __intel_gt_reset+0x6e/0xe0 [i915]
  __might_resched+0x162/0x1b0
  ? __gen11_reset_engines.isra.21+0x2d0/0x2d0 [i915]
  rt_spin_lock+0x2d/0x70
  gen8_reset_engines+0x33/0x220 [i915]
  ? __gen11_reset_engines.isra.21+0x2d0/0x2d0 [i915]
  __intel_gt_reset+0x79/0xe0 [i915]
  sanitize_gpu.part.17+0x2d/0x40 [i915]
  i915_driver_probe+0x7b8/0xf20 [i915]
  ...

Replace the preempt_disable()/enable() with a local_lock()/unlock().

Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 drivers/gpu/drm/i915/gt/intel_reset.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

=2D-- a/drivers/gpu/drm/i915/gt/intel_reset.c
+++ b/drivers/gpu/drm/i915/gt/intel_reset.c
@@ -6,6 +6,7 @@
 #include <linux/sched/mm.h>
 #include <linux/stop_machine.h>
 #include <linux/string_helpers.h>
+#include <linux/local_lock.h>

 #include "display/intel_display_reset.h"
 #include "display/intel_overlay.h"
@@ -766,6 +767,14 @@ wa_14015076503_end(struct intel_gt *gt,
 			 HECI_H_GS1_ER_PREP, 0);
 }

+struct reset_lock {
+	local_lock_t lock;
+};
+
+static DEFINE_PER_CPU(struct reset_lock, reset_lock) =3D {
+	.lock	=3D INIT_LOCAL_LOCK(lock),
+};
+
 int __intel_gt_reset(struct intel_gt *gt, intel_engine_mask_t engine_mask=
)
 {
 	const int retries =3D engine_mask =3D=3D ALL_ENGINES ? RESET_MAX_RETRIES=
 : 1;
@@ -788,9 +797,9 @@ int __intel_gt_reset(struct intel_gt *gt
 		reset_mask =3D wa_14015076503_start(gt, engine_mask, !retry);

 		GT_TRACE(gt, "engine_mask=3D%x\n", reset_mask);
-		preempt_disable();
+		local_lock(&reset_lock.lock);
 		ret =3D reset(gt, reset_mask, retry);
-		preempt_enable();
+		local_unlock(&reset_lock.lock);

 		wa_14015076503_end(gt, reset_mask);
 	}

