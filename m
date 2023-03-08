Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316FF6B0851
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjCHNSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjCHNS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:18:26 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ED38F522
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 05:15:05 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id e22-20020a05600c219600b003e000facbb1so936560wme.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 05:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678281303;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FwUyXbFoeylnGL1ofVQkFUgeUX2pI6+3MVKKMokxUts=;
        b=P/AceM2m1q0TKRqeY3MH0yGWYqLGcsWLOaA8UVdPe/Pf0xJAgW/ftIWNkrk9KX1Xme
         GpLQJemX0p/2UvbZX3iFf2EqvbEnr7n9ZuII9s9Rwto1i8J+evd9V2bT/14cY/DiSk6I
         vH8jq3SZLrdeFP7zwnUtLdIh0FA6ZzAahVbNvJxDuPvRQZwWdZpuA5mgfrjNCj2zZNS5
         fQ5YbcjGl02CcywSwf926mx4vrk0DKcgpOz8geMOguQZqwlvNrluSlr6aBTxBzJgPr+t
         kVq8XPoCOjTqU2L+gzm70pPTxChnq7kfueY69yrE6dKZBh0w7GYekMPMlzIkkeVVSEVq
         W9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678281303;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FwUyXbFoeylnGL1ofVQkFUgeUX2pI6+3MVKKMokxUts=;
        b=hXXdb86mw0bOUlrq1+yKtbrFtINYGWSmfcUJvY+nbW50e4IpE3m4EJut2xCDcM0Iee
         vKJom72IY9+oDHO8wTjLxgU4q7lPu80/8GCsSekO6Q2C9gDnL9V2qs19cltuMRPIzWzD
         Bj3LD+pxD/t59cITacQbGGFQkcYAoIKLLQzvjMQ392b6GB/u87MJPY7ef77xlx8T6tsh
         XsxK5xA8kbmN/3LqtT+Bj7P3dytDlna2V2GfBRpCqX6c8euIdjKn2+K3UTGqSqZKIzHe
         9FpqvInWOwIJhYXayT8PrSb+04JzYdpgSsUk6wJWCtJR9VhC+rZOZ4/zwm99MmSCG7uQ
         gQsg==
X-Gm-Message-State: AO0yUKXh7cEfhwN5YemdfyP+xRIXTvPtWqUPQPuf6gnL+fzEhKxVzgdy
        4Cnvwc8WfTlWCDIeiBtJ4sEBRgUD7ZzFtaCHcw==
X-Google-Smtp-Source: AK7set/gwdydcqZ87RbDtCBkqgp78w5d4r2ba/T+82XvW5Gwgf3d6mwOjsffme8tTr1eqnsB4jyw083UccxVUGGzDA==
X-Received: from peternewman-vh.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:30cc])
 (user=peternewman job=sendgmr) by 2002:a5d:4403:0:b0:2c6:ed0b:614e with SMTP
 id z3-20020a5d4403000000b002c6ed0b614emr3995656wrq.2.1678281303617; Wed, 08
 Mar 2023 05:15:03 -0800 (PST)
Date:   Wed,  8 Mar 2023 14:14:49 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230308131452.383914-1-peternewman@google.com>
Subject: [PATCH v4 0/3] Subject: x86/resctrl: Implement rename to help move
 containers' tasks
From:   Peter Newman <peternewman@google.com>
To:     reinette.chatre@intel.com, fenghua.yu@intel.com
Cc:     Babu.Moger@amd.com, bp@alien8.de, dave.hansen@linux.intel.com,
        eranian@google.com, gupasani@google.com, hpa@zytor.com,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, skodak@google.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org,
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

[1] https://lore.kernel.org/lkml/7b09fb62-e61a-65b9-a71e-ab725f527ded@intel.com/
[2] https://lore.kernel.org/lkml/54e50a9b-268f-2020-f54c-d38312489e2f@intel.com/
[3] https://lore.kernel.org/lkml/20221220161123.432120-1-peternewman@google.com/

Peter Newman (3):
  x86/resctrl: Factor rdtgroup lock for multi-file ops
  x86/resctrl: Parameterize rdt_move_group_tasks() task matching
  x86/resctrl: Implement rename op for mon groups

 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 196 ++++++++++++++++++++++---
 1 file changed, 174 insertions(+), 22 deletions(-)


base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

