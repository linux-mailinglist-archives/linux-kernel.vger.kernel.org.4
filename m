Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674E16E79FB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjDSMux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbjDSMuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:50:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1047F6E91
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:50:39 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54fde069e4aso133812027b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681908638; x=1684500638;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vtQNVq7Tkq5JYsdAztRyQiMAwBPR1T74LnOYfB2OB8o=;
        b=JnuQLe67fxFNGZP6aGT4Rt2265a8DK4wOhMB54E+JbqCYtDhq0+opciAwXG78c4q8v
         NVQpbxbR0SjZXOVj8XEM1xVOabzOIcW1DdISmYgFW8GM5sXMruVTnWEFhJSNlNsxH0eB
         JexL9CKd7esXhtXKqaYeO9OPnmzqXJV5994oL8LoaPS+Nf5yrwDiW1Nc//fznJhk2JuF
         CDQ9ohB6xiyVxVasZAgVCdaiGlaWO5yqTWkSuOsmP+NEdqtjoM/9HajZF5PSFYmB+WzR
         eHkMmPQ3t3A9RKWUHO+0Vj6cjHtsTozH06CfpFWBJk3Dpb8YISvNPlFlZpXPNJuFaS+7
         xPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681908638; x=1684500638;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vtQNVq7Tkq5JYsdAztRyQiMAwBPR1T74LnOYfB2OB8o=;
        b=dBAp5xqp2Cjnkqd6GjMUwgQw7kTTTatfltQWiDd/RCLItR0l6jQxFpupxJ/BrBuFnb
         VgArxXG1odeQ/3p8YGO8g6V9vIW4MVpd40Oxunbh9cnB3CpuDSf0kQgJJwkvqmPnc1tc
         lwq2bU3ncAtH9CQnyycK37z7wNR43SYDB2iRSB3vVMH8f/j4iuGJKh2Sp1NvKfSXd9Y9
         YWXY9VrsZ6VgyJ1IG5qiB8cFz6oLcRaoue8/GEQT+bQJ4Lu83hnkVMNZuu6sR7m65emQ
         Y9bTb8RPjkcvg4ma7y2QFjDv5Ejpe0Zb9VFgYFsY2+GC6/2ZtCcTz0efHCFPR1PYAMgd
         It4A==
X-Gm-Message-State: AAQBX9c9k4uO0iDcagKs+uM5TkqiqZx3pmV1/laGKyD6AR21neD36076
        4bb1wzPhKLS9VYABt4sbaHCsZHfSC7f++3i4Wg==
X-Google-Smtp-Source: AKy350Z2/zLVvrHp8qwxmc8LTqgjgS/Ax6r0E3mLuLQzYvtuhoYjZIxLYXs2PjccIP3Sndti6jV/BInRA1DiPIp3UQ==
X-Received: from peternewman0.zrh.corp.google.com ([2a00:79e0:9d:6:b36e:a25e:826d:b66a])
 (user=peternewman job=sendgmr) by 2002:a25:d8c4:0:b0:b96:7676:db4a with SMTP
 id p187-20020a25d8c4000000b00b967676db4amr1504922ybg.0.1681908637609; Wed, 19
 Apr 2023 05:50:37 -0700 (PDT)
Date:   Wed, 19 Apr 2023 14:50:12 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230419125015.693566-1-peternewman@google.com>
Subject: [PATCH v6 0/3] x86/resctrl: Implement rename to help move containers' tasks
From:   Peter Newman <peternewman@google.com>
To:     fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     Babu.Moger@amd.com, bp@alien8.de, dave.hansen@linux.intel.com,
        eranian@google.com, gupasani@google.com, hpa@zytor.com,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, skodak@google.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org,
        Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette, Fenghua,

This patch series implements the solution Reinette suggested in the
earlier RFD thread[1] for the problem of moving a container's tasks to a
different control group on systems that don't provide enough CLOSIDs to
give every container its own control group.

This patch series assumes that a MON group's CLOSID can simply be
changed to that of a new parent CTRL_MON group. This is allowed on Intel
and AMD, but not MPAM implementations. While we (Google) only foresee
needing this functionality on Intel and AMD systems, this series should
hopefully be a good starting point for supporting MPAM.

Thanks!
-Peter

Updates:

v6:
 - rebase to v6.3-rc7
 - clarify changelog wording
 - clarify error message for non-directory move
 - remove unneeded parenthesis for checkpatch.pl --strict
 - add Reviewed-By's from Reinette

v5:
 - rebase to v6.3-rc4
 - dropped rdt_move_group_tasks() task filter patch
 - code/comment clarifications and errno updates requested by Reinette
 - added Documentation patch

v4:
 - rebase to v6.2
 - commit message updates suggested by Reinette
 - replace rdt_move_one_task() patch with rdt_move_group_tasks() filter
   function patch
 - prevent rename on files or renaming to "mon_groups"
 - optimize simple rename case
 - disallow renaming groups with non-empty cpumask
 - ensure source is a proper MON group directory
 - fix missing rdtgrp->closid update
 - add more last_command_status output

v3: use revised task CLOSID/RMID update IPI sync method from [3]
v2: reworded change logs based on what I've learned from review comments
    in another patch series[2]

[v1] https://lore.kernel.org/lkml/20221115154515.952783-1-peternewman@google.com/
[v2] https://lore.kernel.org/lkml/20221129120149.1035444-1-peternewman@google.com/
[v3] https://lore.kernel.org/lkml/20230125101334.1069060-1-peternewman@google.com/
[v4] https://lore.kernel.org/lkml/20230308131452.383914-1-peternewman@google.com/
[v5] https://lore.kernel.org/lkml/20230330135558.1019658-1-peternewman@google.com/

[1] https://lore.kernel.org/lkml/7b09fb62-e61a-65b9-a71e-ab725f527ded@intel.com/
[2] https://lore.kernel.org/lkml/54e50a9b-268f-2020-f54c-d38312489e2f@intel.com/
[3] https://lore.kernel.org/lkml/20221220161123.432120-1-peternewman@google.com/

Peter Newman (3):
  x86/resctrl: Factor rdtgroup lock for multi-file ops
  x86/resctrl: Implement rename op for mon groups
  Documentation/x86: Documentation for MON group move feature

 Documentation/x86/resctrl.rst          |   7 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 163 +++++++++++++++++++++++--
 2 files changed, 157 insertions(+), 13 deletions(-)


base-commit: 6a8f57ae2eb07ab39a6f0ccad60c760743051026
-- 
2.40.0.634.g4ca3ef3211-goog

