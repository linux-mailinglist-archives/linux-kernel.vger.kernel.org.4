Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB743629BDB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiKOOUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKOOUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:20:16 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098F0B96
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:20:15 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id h26-20020adfaa9a000000b002364ad63bbcso2865166wrc.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s58ZaaH7khykLAsdfR1PLA3uBVF9xAfHNVB2s7VvboI=;
        b=tKfLrP+XEln6NMJiQ7YHCAJTjRksmIu8VAz+ouqeP6Xy8AiqHpXIoHExasSgJEJq9O
         fjKKC9RvAnbsG60De+PEzPxneZuqlAT0+UBiIwpOyvp9lu/kgSxdg/xV+JTHGhLnZwG2
         mslf4b/dJZWP2SAqbvfII/SqWfJRTu4LkrEGOPU4Q2W57CohSVgMO2WrYVIrqywyHH81
         xPT3uZX5EoqMV4E7n9cdj5FLkNOrHgzdrNH35/At6egv1FwmcMeurd+UQswLIt19ka11
         LnQzF/m3pKhAR44E0/dwKz6PGSiImcah8RDPFeTcyqwlKY26joADsSbvoCpNMbRILsKp
         LpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s58ZaaH7khykLAsdfR1PLA3uBVF9xAfHNVB2s7VvboI=;
        b=7XDg5/sammb1Yqy8WqMEgrnhtwWP2/hDJjAvSECB4AkqXEgWvR+K4xlLoa2stiQdEZ
         sDUeMQ1bcKFamDLHl74/ZGdT0Zz4jcz1YXEOBpJtofOHyvOqT5SlfubQII7fO0X1KuiL
         vwzSi5Q0dWjcJ/cC4rJ2PNOl8mMYSu5SHdlwEQx+FaPclsXmP3I5jOfMu88BmwcA1/55
         RyYSODkKxH8Or4MVnSuPVDcHkCX29Kjr3BFPivf6U0XiJxIV+4oQgUoMXFuJA0/HZs3R
         9uSz8H/5p1/7SXzaWE/ShfGEhBCJ2uWhINFBVuE3Gm+eAJsxtdOV9221kBwyXTWFP+ZK
         tX0A==
X-Gm-Message-State: ANoB5plGtgTEc1DBM6/cngwxwKGd0d+r3ke4MHDVCyChabzTM/jnoqXe
        Fzg0Tbvt/03bIc0W4rjPMll3fDl5nKPYb0sR7Q==
X-Google-Smtp-Source: AA0mqf6Ljg11jWrIFtPTJk3CJyt+vSuoHOudsi+ev5ETQsarCeoJT8GtgT6p4NG90C4Z0sAvKD+RYLRxRUeH4QvUkg==
X-Received: from peternewman10.zrh.corp.google.com ([2a00:79e0:9d:6:fe62:9ede:ae13:6fda])
 (user=peternewman job=sendgmr) by 2002:a1c:c906:0:b0:3cf:71e4:75b with SMTP
 id f6-20020a1cc906000000b003cf71e4075bmr1766758wmb.114.1668522013552; Tue, 15
 Nov 2022 06:20:13 -0800 (PST)
Date:   Tue, 15 Nov 2022 15:19:51 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
Message-ID: <20221115141953.816851-1-peternewman@google.com>
Subject: [PATCH v3 0/2] x86/resctrl: fix task CLOSID update race
From:   Peter Newman <peternewman@google.com>
To:     reinette.chatre@intel.com, fenghua.yu@intel.com
Cc:     bp@alien8.de, derkling@google.com, eranian@google.com,
        hpa@zytor.com, james.morse@arm.com, jannh@google.com,
        kpsingh@google.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        tglx@linutronix.de, x86@kernel.org,
        Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette, Fenghua,

I've reorganized the patches for clarity, following James's guidance.

The patch series addresses the IPI race we discussed in the container
move RFD thread[1].

The first patch changes group-wide CLOSID/RMID updates to IPI all CPUs.
Now that the synchronization cost of correctly updating a single task is
more than originally thought, we believe that it's cheaper to IPI all
CPUs than forming a more precise CPU mask by synchronizing with all
tasks in an rdtgroup, especially when there is a large number of tasks
in the group. It's possible that this update could upset users who
frequently delete groups with few tasks. If anyone is aware of a use
case that frequently deletes groups, we can consider mitigations.

The second one uses the new task_call_func() interface to serialize
updating closid and rmid with any context switch of the task. AFAICT,
the implementation of this function acts like a mutex with context
switch, but I'm not certain whether it is intended to be one. If this is
not how task_call_func() is meant to be used, I will instead move the
code performing the update under sched/ where it can be done holding the
task_rq_lock() explicitly, as Reinette has suggested before[2].

Updates in v3:
 - Split the handling of multi-task and single-task operations into
   separate patches, now that they're handled differently.
 - Clarify justification in the commit message, including moving some of
   it out of inline code comment.
Updates in v2:
 - Following Reinette's suggestion: use task_call_func() for single
   task, IPI broadcast for group movements.
 - Rebased to v6.1-rc4

v1: https://lore.kernel.org/lkml/20221103141641.3055981-1-peternewman@google.com/
v2: https://lore.kernel.org/lkml/20221110135346.2209839-1-peternewman@google.com/

Thanks!
-Peter

[1] https://lore.kernel.org/all/CALPaoCg2-9ARbK+MEgdvdcjJtSy_2H6YeRkLrT97zgy8Aro3Vg@mail.gmail.com/
[2] https://lore.kernel.org/lkml/d3c06fa3-83a4-7ade-6b08-3a7259aa6c4b@intel.com/

Peter Newman (2):
  x86/resctrl: IPI all CPUs for group updates
  x86/resctrl: update task closid/rmid with task_call_func()

 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 128 +++++++++++--------------
 1 file changed, 58 insertions(+), 70 deletions(-)

--
2.38.1.493.g58b659f92b-goog

