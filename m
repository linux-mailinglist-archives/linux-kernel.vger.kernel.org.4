Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7786243A8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiKJNyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKJNyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:54:47 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AA9289
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:54:47 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v81-20020a252f54000000b006cb87d7042cso1792478ybv.20
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cb213OyZGD4p3UgOqm80gLSTI8CQlk8oYDw7qrrV9/E=;
        b=GNBNh36YuLs/a18Tw7gt2pRfnRrIMz2/RZUsfZhq3mjNc9RG1GmAuJasRBoGv9Y1UN
         4XdfTUcVPdQ4deJ3oEu6wjvW2acwec66E8KodlL+cCvqDfJoubm2f00TeyZdX/JKiSVV
         5urJQfOb/DifLPk759mGngGTdkfAGsDWlHURQ4uV9M4IdJZLMLRPHizfiNWHKqI07STm
         7eGPR4jQhXChd+shk6YFT5Aorxnp8Rd2AfAtjefTEwPxg4JuIaMxpbHQFdS2Pp0Ufk4J
         TkyxiAeT4OR/zCV9A4+ATI4dgyMMfKBvBdE81wvyFpatJqrf3mpHi0KglfK0VLp1Hr4s
         MboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cb213OyZGD4p3UgOqm80gLSTI8CQlk8oYDw7qrrV9/E=;
        b=j3omz2B9R56L8goc+7C6or7BAJzyPy6OP6GFm7+JvvMnz3fWrTYsLachJsT9J8CW5u
         C3trByB82I4b6aFyMr/oyi4QQKdvMZ1egPYtoStPRj5jHoNn/H2Jd4/jK62OtCFPcl7K
         HiFfCTH9TrnujsKXVtO7rdhMiWeacVS/zeSDmgvsODs1tG1wZfFypUMJ07oldBZ/eYRS
         /oQ7fBnf/mL6XdXyE8Qy/v9I/oxVa95rmlvYZlHeF8DMoOcREvxKK3Bp1tOPcp46HBoQ
         O69+xBQVeFKlrtb3gWMP2cjpPgEnVjbhpb1IYm06W2A/D53Tb3bf0TA0U+wYz0a53hBb
         Ymdg==
X-Gm-Message-State: ACrzQf2CYQ9ZSmE/oznm71h31szy63sN32D8oHRI5VdvkNOjcr1o4KBl
        mib0x4iW6coFBNhkBiKJvOla7EpdYoR+/jPYgg==
X-Google-Smtp-Source: AMsMyM6Mupa5LuL2AsNGCoNSf2l+UeFiTY+/9HS2pVzrXTHV8L1iIRuwwHaHy+XQWTkNYBPevdJjLFpD5Z0NK55HDw==
X-Received: from peternewman10.zrh.corp.google.com ([2a00:79e0:9d:6:f007:de:9ed3:3a96])
 (user=peternewman job=sendgmr) by 2002:a81:8ac2:0:b0:370:7a9:20eb with SMTP
 id a185-20020a818ac2000000b0037007a920ebmr1339624ywg.424.1668088486336; Thu,
 10 Nov 2022 05:54:46 -0800 (PST)
Date:   Thu, 10 Nov 2022 14:53:44 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221110135346.2209839-1-peternewman@google.com>
Subject: [PATCH v2 0/1] x86/resctrl: fix task CLOSID update race
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

Below is my updated patch to address the IPI race we discussed in the
container move RFD thread[1].

The patch below uses the new task_call_func() interface to serialize
updating closid and rmid with any context switch of the task. AFAICT,
the implementation of this function acts like a mutex with context
switch, but I'm not certain whether it is intended to be one. If this is
not how task_call_func() is meant to be used, I will instead move the
code performing the update under sched/ where it can be done holding the
task_rq_lock() explicitly, as Reinette has suggested before[2].

task_call_func() is only used when moving as single task, as group
changes would require task_call_func() to be called on every task in a
potentially large list, which is likely more detrimental than an IPI
broadcast. Furthermore, when moving a large group, the resulting CPU
update mask will probably contain all CPUs anyways.

Updates since v1:
 - Following Reinette's suggestion: use task_call_func() for single
   task, IPI broadcast for group movements.
 - Rebased to v6.1-rc4

v1: https://lore.kernel.org/lkml/20221103141641.3055981-1-peternewman@google.com/

Thanks!
-Peter

[1] https://lore.kernel.org/all/CALPaoCg2-9ARbK+MEgdvdcjJtSy_2H6YeRkLrT97zgy8Aro3Vg@mail.gmail.com/
[2] https://lore.kernel.org/lkml/d3c06fa3-83a4-7ade-6b08-3a7259aa6c4b@intel.com/

Peter Newman (1):
  x86/resctrl: fix task closid/rmid update race

 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 134 ++++++++++++-------------
 1 file changed, 62 insertions(+), 72 deletions(-)

-- 
2.38.1.431.g37b22c650d-goog

