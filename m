Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51306EA1DE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 04:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbjDUCu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 22:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjDUCuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 22:50:54 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A862E75
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 19:50:53 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-247048f86c7so1235313a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 19:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682045453; x=1684637453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmtrNohZohvwwvoXrwix45PfrI45pVOsg46nypoG6vA=;
        b=ZmpAEUq+gjuPKgzNFcuAAdXwmm2GgiMJlJhP1UqCHPzgFmzgT/Z6Ri4oGf+vaelLbF
         bo4eVpMsoWtjWBTio6FfNgAKkq3C5sXwv2quyHuNUvOTEYUuw9ww0QuVP4DrckZQtoJC
         3ADJOE5YEviK6cYzpxW9M25DRSL9ZsUGz+3uPJsgTfoqmZtPSEX+tuMrLqWj81i7An02
         nxmDWw1C2GX+ThleqlvVhVu0Q6NmK4HTO567n+ZW5hevASnd4N1RERG2XiuEe7P45kwI
         zmc4aPBM2h1Bl0gmIJeKUixs5hDOsBbS6DfSJXPSEgahAgLQ1PeLj0Mud/zYDJ2Z+2Zb
         lx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682045453; x=1684637453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QmtrNohZohvwwvoXrwix45PfrI45pVOsg46nypoG6vA=;
        b=Sj6toxp1CfQb4PGuKKkPIMOom0AH94S3E3/OY3Qy9zxiuNcOBa9nRlQKYJEUXdNfzL
         3hYTfU4PQjgXqtq8fWxJVhoTGKSyL2xehPkcrYV8hWNnjnyKqHkQILwjTfS6JXcvEebn
         gGNuAyaGfQfPZ+ThJXhnPGL9ZIdUjDeQAPW3PsGYgPoKmBxR5zAyFXvlHoSgEySldo0r
         j4kuRgbHOc4DyZn57jcWCAZx8HiI8bZf9yBXVY2N+ewahmq9VSmHQiVLFxIqRNdg5SNf
         Qe0MDa9mub/hEsHkz2U1VUmorXPQa/LZHAMI5gdgmwJrQYxFo1yuTq61a2/hfKXMl1p7
         OchQ==
X-Gm-Message-State: AAQBX9eEpCUKoZVAPPu+rgZKw2P+HdyQKm1KDd6gh/lGv2cLGkGMndNP
        GiHf0sHnc5ZyHEK4gfbJ3NI=
X-Google-Smtp-Source: AKy350YCCXl0aX+uUc3WbUIS6fp5Ro/TyaD4dYwRUknPa7n2rlaCcw+doGuOEoZcxrkGH+2h6Bs9qw==
X-Received: by 2002:a17:90a:d985:b0:247:193b:ce84 with SMTP id d5-20020a17090ad98500b00247193bce84mr3540463pjv.15.1682045452656;
        Thu, 20 Apr 2023 19:50:52 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id gg6-20020a17090b0a0600b0023d386e4806sm1742354pjb.57.2023.04.20.19.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 19:50:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/22] powerpc, workqueue: Use alloc_ordered_workqueue() to create ordered workqueues
Date:   Thu, 20 Apr 2023 16:50:25 -1000
Message-Id: <20230421025046.4008499-2-tj@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421025046.4008499-1-tj@kernel.org>
References: <20230421025046.4008499-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BACKGROUND
==========

When multiple work items are queued to a workqueue, their execution order
doesn't match the queueing order. They may get executed in any order and
simultaneously. When fully serialized execution - one by one in the queueing
order - is needed, an ordered workqueue should be used which can be created
with alloc_ordered_workqueue().

However, alloc_ordered_workqueue() was a later addition. Before it, an
ordered workqueue could be obtained by creating an UNBOUND workqueue with
@max_active==1. This originally was an implementation side-effect which was
broken by 4c16bd327c74 ("workqueue: restore WQ_UNBOUND/max_active==1 to be
ordered"). Because there were users that depended on the ordered execution,
5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
made workqueue allocation path to implicitly promote UNBOUND workqueues w/
@max_active==1 to ordered workqueues.

While this has worked okay, overloading the UNBOUND allocation interface
this way creates other issues. It's difficult to tell whether a given
workqueue actually needs to be ordered and users that legitimately want a
min concurrency level wq unexpectedly gets an ordered one instead. With
planned UNBOUND workqueue updates to improve execution locality and more
prevalence of chiplet designs which can benefit from such improvements, this
isn't a state we wanna be in forever.

This patch series audits all callsites that create an UNBOUND workqueue w/
@max_active==1 and converts them to alloc_ordered_workqueue() as necessary.

WHAT TO LOOK FOR
================

The conversions are from

  alloc_workqueue(WQ_UNBOUND | flags, 1, args..)

to

  alloc_ordered_workqueue(flags, args...)

which don't cause any functional changes. If you know that fully ordered
execution is not ncessary, please let me know. I'll drop the conversion and
instead add a comment noting the fact to reduce confusion while conversion
is in progress.

If you aren't fully sure, it's completely fine to let the conversion
through. The behavior will stay exactly the same and we can always
reconsider later.

As there are follow-up workqueue core changes, I'd really appreciate if the
patch can be routed through the workqueue tree w/ your acks. Thanks.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Nathan Lynch <nathanl@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/tau_6xx.c          | 2 +-
 arch/powerpc/platforms/pseries/dlpar.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/tau_6xx.c b/arch/powerpc/kernel/tau_6xx.c
index 828d0f4106d2..cba6dd15de3b 100644
--- a/arch/powerpc/kernel/tau_6xx.c
+++ b/arch/powerpc/kernel/tau_6xx.c
@@ -200,7 +200,7 @@ static int __init TAU_init(void)
 	tau_int_enable = IS_ENABLED(CONFIG_TAU_INT) &&
 			 !strcmp(cur_cpu_spec->platform, "ppc750");
 
-	tau_workq = alloc_workqueue("tau", WQ_UNBOUND, 1);
+	tau_workq = alloc_ordered_workqueue("tau", 0);
 	if (!tau_workq)
 		return -ENOMEM;
 
diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 75ffdbcd2865..e9117b03807e 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -564,8 +564,7 @@ int __init dlpar_workqueue_init(void)
 	if (pseries_hp_wq)
 		return 0;
 
-	pseries_hp_wq = alloc_workqueue("pseries hotplug workqueue",
-			WQ_UNBOUND, 1);
+	pseries_hp_wq = alloc_ordered_workqueue("pseries hotplug workqueue", 0);
 
 	return pseries_hp_wq ? 0 : -ENOMEM;
 }
-- 
2.40.0

