Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7997F64C853
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238285AbiLNLpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 06:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238290AbiLNLo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:44:58 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CBB20F7A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:44:56 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id v188-20020a1cacc5000000b003cf76c4ae66so7102093wme.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ehicEisSO5hD1eBR93dUbONfvJrO435zMk4POVy4+EE=;
        b=RBpknXW1ddt3hmjv/UiNbTT0l3oTS279CCyh9CKM/+v5f2urrOtfUkVsgtBYwGIDKN
         z8SqjflDXC+2NGNrT4mXb6IbgdqBqzqO5AfDbUO6C2gfKLqFtlHiobvP8OPY7iPWsSXv
         eJSXxD8yEHuJ/IHhJFaN7PWTNCo5A1B2Kp/5S7YU9i+ME0Ma75M7v+RYGeUVuRQJZ1ui
         eaCWvDo4zhFO9RU1X5wSqIf5LMjXEuqFt0fPFAhtAgApBi/0fV7iJ1djwNRq/2OLGCk5
         o8sZZNN5SnRI02NQIRTakOuMyRZMveXg0nRoJaJkhksfEKWLORPerKbGEWJ8/quOmWK8
         rbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ehicEisSO5hD1eBR93dUbONfvJrO435zMk4POVy4+EE=;
        b=Dbr3+PpYgIfAa+yi8/WDaHwIxAjX9HQvMgplXTrKr3C5lEkE135OdP4J0mfe/4L/fX
         qdiKezNy+hhqna2rWLBUaKQbaZUJkPXzQEk8v6KkkwdMhdlEHyT7NE4JiFUnAh2RyaGs
         Y/F7EDVX42Zrqx5ynsJ7KHhmTmwe88q4fo27YgbROe+rp0Osw3hO/bFzioI8H5AOkNwC
         ezVMDiXE9IuYNHPcraklvRfEnGTgVwfUcFQ1UgUmI0wlGAlU+t0OAoszB/+PQKgNs+4P
         CTzAvzY5hsm7mcL1WzbPJEPY0EoLe5UlAJjRjyt7FJDcmS8Zz1lZ/C0CyAO3Y5wLovfn
         2vDw==
X-Gm-Message-State: ANoB5pmwwQ4pJ5jLBr37T7+seNhpqvQGcCas0dhIfHTKgqk/I5DJVH9k
        K6u4OyP0/tBCGfEiwIznAWem1Cb2mDnlSb/4uQ==
X-Google-Smtp-Source: AA0mqf4Zxe45jDZVMvbT61VJL5gyjByFSFutPJmGf66pY3nsPK9DVU+q4HigBTuf6Js+/K6YBIXlVnLMXn9g9L0C7w==
X-Received: from peternewman-vh.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:30cc])
 (user=peternewman job=sendgmr) by 2002:a5d:5a95:0:b0:250:90fa:3e3 with SMTP
 id bp21-20020a5d5a95000000b0025090fa03e3mr552847wrb.653.1671018295255; Wed,
 14 Dec 2022 03:44:55 -0800 (PST)
Date:   Wed, 14 Dec 2022 12:44:46 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221214114447.1935755-1-peternewman@google.com>
Subject: [PATCH v5 0/1] Subject: x86/resctrl: Fix task CLOSID update race
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

Now that we know there is a full barrier in context switch and that
smp_mb() on every task in a group update isn't nearly as expensive as
task_call_func(), I can present you a much smaller fix.

The diffs are small enough to go down to a single patch. The changelogs
are not much simpler, but hopefully this isn't as big of a concern.

This patch is different enough that I thought it necessary to remove
James's Reviewed-By.

Updates in v5:
 - Just put an smp_mb() between CLOSID/RMID stores and task_curr() calls
 - Add a diagram detailing the race to the changelog
Updates in v4:
 - Reorder the patches so that justification for sending more IPIs can
   reference the patch fixing __rdtgroup_move_task().
 - Correct tense of wording used in changelog and comments
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
v3: https://lore.kernel.org/lkml/20221115141953.816851-1-peternewman@google.com/
v4: https://lore.kernel.org/lkml/20221129111055.953833-1-peternewman@google.com/

Thank you for your careful reviews and feedback so far.

-Peter

Peter Newman (1):
  x86/resctrl: Fix task CLOSID/RMID update race

 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)


base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
-- 
2.39.0.rc1.256.g54fd8350bd-goog

