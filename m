Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAF4617F40
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiKCOSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiKCOSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:18:09 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4D612772
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 07:17:19 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-36f8318e4d0so19736737b3.20
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 07:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l+u2K0t45cnZAV/GDs5HtBlAaa6X3vs/zsHgWN6LaqE=;
        b=juRhD6PIzWr9gunWjN+/OEJc/ZeFnRt6uXgZqrX+tyP/MuwYUuxI+iOrCg80P5eOsF
         n2gLGVJ/MR7HCVyyQgNawgEeNpSyN9eEZdtKq12MHstMZaFUqCrXxdup4hh6QsTA+nnY
         FiQXN2FxA2SSqfoba3NN1Zbpdex6zzPMbT8Qip+ETXWEXH7W4bK4BNi7y/U0qZk2zhQ1
         aLCvmWcGiYcQOGotts4FyjyDcBYCbtq4qT/kLBwTgOWxeFQo7N+EfU0rKQMmczEhnSAh
         Yh6sTi39bvuAQj0ikaC8B6gcbbofyIRSppN0SQRQM6H9DeZ7Cyp24OoO7Uarf8o9JnlE
         1seA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+u2K0t45cnZAV/GDs5HtBlAaa6X3vs/zsHgWN6LaqE=;
        b=oH5aFpGd3yaakx1M9c7yhXxZIkCuuOcdw6fWn9s2dQrXGRHABDfyf6XUTcxTju46ZH
         cWhoGlfuQVAFOD1jxJw0DeFYovtVxPm35THojLE0k0KASJWWjj9YuVpH3k5K+fyrx6pm
         KngrnoBoo5TllGE3DyBLvrD+OXeIoWNdSbzYE/54i/HfNOdZkFqU4p1Ss9fxyUOMey9v
         ATnuD7O+LumUTpoEXKBTBJCufaVAFn+4xyXtZE3bWT7afaEyBWZnl0soYiOWgEeAclSq
         xUZlaTT7OVGoNemhmOU3ncrBtxbsKAS8p42Hspjft9IiNDoauli/fmT/Oiym7coIvniN
         MEaA==
X-Gm-Message-State: ACrzQf23vtSTkhZgafvlQdpKSkk9mB7vrPGDcUGW4VFJwyjpSxjP2nkl
        cTGDUgUO9c3JFoy/K4VgKtdVq6bwzYveiFXaJg==
X-Google-Smtp-Source: AMsMyM5kWqCm/p3o1fRxmzalbPvYaKOrhMuNZeGIB1vMsK34bpSbNee8Mdzd3eZQTOAhiSRlHBeTKP+yLMo+7z+J1w==
X-Received: from peternewman10.zrh.corp.google.com ([2a00:79e0:9d:6:5fe6:648d:f013:835f])
 (user=peternewman job=sendgmr) by 2002:a0d:d549:0:b0:36e:a0f2:a475 with SMTP
 id x70-20020a0dd549000000b0036ea0f2a475mr29593896ywd.38.1667485039009; Thu,
 03 Nov 2022 07:17:19 -0700 (PDT)
Date:   Thu,  3 Nov 2022 15:16:40 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221103141641.3055981-1-peternewman@google.com>
Subject: [PATCH 0/1] x86/resctrl: fix task CLOSID update race
From:   Peter Newman <peternewman@google.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, jannh@google.com, eranian@google.com,
        kpsingh@google.com, derkling@google.com, james.morse@arm.com,
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

Below is my patch to address the IPI race we discussed in the container
move RFD thread[1].

The patch below uses the new task_call_func() interface to serialize
updating closid and rmid with any context switch of the task. AFAICT,
the implementation of this function acts like a mutex with context
switch, but I'm not certain whether it is intended to be one. If this is
not how task_call_func() is meant to be used, I will instead move the
code performing the update under sched/ where it can be done holding the
task_rq_lock() explicitly, as Reinette has suggested before[2].

From my own measurements, this change will double the time to complete a
mass-move operation, such as rmdir on an rdtgroup with a large task
list. But to the best of my knowedge, these large-scale reconfigurations
of the control groups are infrequent, and the baseline I'm measuring
against is racy anyways.

What's still unclear to me is, when processing a large task list, is
obtaining the pi/rq locks for thousands of tasks (all while read-locking
the tasklist_lock) better than just blindly notifying all CPUs? My guess
is that the situation where notifying all CPUs would be better is
uncommon for most users and probably more likely in Google's use case
than most others, as we have a use case for moving large container jobs
to a different MBA group.

Thanks!
-Peter

[1] https://lore.kernel.org/all/CALPaoCg2-9ARbK+MEgdvdcjJtSy_2H6YeRkLrT97zgy8Aro3Vg@mail.gmail.com/
[2] https://lore.kernel.org/lkml/d3c06fa3-83a4-7ade-6b08-3a7259aa6c4b@intel.com/

Peter Newman (1):
  x86/resctrl: serialize task CLOSID update with task_call_func()

 arch/x86/include/asm/resctrl.h         | 11 ++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 83 +++++++++++++++-----------
 2 files changed, 51 insertions(+), 43 deletions(-)

-- 
2.38.1.273.g43a17bfeac-goog

