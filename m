Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76DA67AF69
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjAYKNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbjAYKNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:13:46 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C802E0D7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:13:44 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n8-20020a258d08000000b007facaf67acfso19318662ybl.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nLUsTBHrrP1VhsvDJnzbuN/5sK2viyEG6W8L3lNl6Sk=;
        b=KDQQgzA6ROA2joiFtYVUURuaQ1Hsp1OMCTQ7RsdBogEMxTx122OSOHHe/2ladw+zv0
         SzzJeyLfJS/ccz87LZGefevS6O2iblGCSEqXx7UM26cCyX9jP6MN1E2EdjwgKlZcTZMA
         pHCKWTG2IdJ6tKiyjC+D6ECoCoc/X1D3Gk1HNh0y4NgVmioOfI4OPHknIdtt4aNWRA9p
         WE5m1qE4qQkzI3s2c762i19eabLJ/P6M9ioPZBWAiGwtTFwddbbROIocPguNqdzo2G94
         9Ml6Tpb+/4bnQHEZbmzYKHjsjZn+TYqS+pJT7lAh2hCaQdILQSpX9QJIQ58BM9ddCXG8
         S/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nLUsTBHrrP1VhsvDJnzbuN/5sK2viyEG6W8L3lNl6Sk=;
        b=haqY+npTTjDCa51buei/XvPgN+B0LcOpELt5qO0yBjSVsfpdhuc33G9FsFPOdgop3v
         FTto2kxJSKNeTX7xyjmYDMEsHFj8FymOiv/bWG363go50PiCPKm7feJ5dg7rcvE9WVlm
         AJuF7eJ/ZMiiB3r+cMyffctG4JpUIVWa+vf8X6zJPHbvBNDxUF7W6QJCH9HI9fglTDW0
         3cT2z/yEZIjjczQ090Pdh6GyiT0gesqyBYu4Q26LHaKNDSeR8judvRWc+ht1hvBy5uCH
         ko2g4a8qCJ1yKASW2XWe0G/T1r5zvDFkxNyRgGSaM4WhnGjH/ruupVwkHWN4sXk516vh
         KYuw==
X-Gm-Message-State: AO0yUKVn9jNx02789R6MWQgD840LhgIaWUx5BssJWyRhL9TjOOHioM6B
        GASDCDpxnylbcVPkSwrpnXZRaHf2VKeF2QoS/g==
X-Google-Smtp-Source: AK7set/G3elPQMLkoX2O/dUa20K7aJ8Wo3NmUnSPSQK1p55cNhluRRsiz2mOPwccHdq2A9RQ1uICefB4yzlsCbc8RA==
X-Received: from peternewman10.zrh.corp.google.com ([2a00:79e0:9d:6:e533:80e6:38fe:22c])
 (user=peternewman job=sendgmr) by 2002:a25:a28e:0:b0:80b:72cc:ba35 with SMTP
 id c14-20020a25a28e000000b0080b72ccba35mr481251ybi.330.1674641623977; Wed, 25
 Jan 2023 02:13:43 -0800 (PST)
Date:   Wed, 25 Jan 2023 11:13:31 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f-goog
Message-ID: <20230125101334.1069060-1-peternewman@google.com>
Subject: [PATCH v3 0/3] x86/resctrl: Implement rename to help move containers' tasks
From:   Peter Newman <peternewman@google.com>
To:     reinette.chatre@intel.com, fenghua.yu@intel.com
Cc:     Babu.Moger@amd.com, bp@alien8.de, dave.hansen@linux.intel.com,
        eranian@google.com, gupasani@google.com, hpa@zytor.com,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, skodak@google.com, tony.luck@intel.com,
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

v3: use revised task CLOSID/RMID update IPI sync method from [3]
v2: reworded change logs based on what I've learned from review comments
    in another patch series[2]

[v1] https://lore.kernel.org/lkml/20221115154515.952783-1-peternewman@google.com/
[v2] https://lore.kernel.org/lkml/20221129120149.1035444-1-peternewman@google.com/

[1] https://lore.kernel.org/lkml/7b09fb62-e61a-65b9-a71e-ab725f527ded@intel.com/
[2] https://lore.kernel.org/lkml/54e50a9b-268f-2020-f54c-d38312489e2f@intel.com/
[3] https://lore.kernel.org/lkml/20221220161123.432120-1-peternewman@google.com/

Peter Newman (3):
  x86/resctrl: Factor rdtgroup lock for multi-file ops
  x86/resctrl: Factor work to update task CLOSID/RMID
  x86/resctrl: Implement rename op for mon groups

 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 170 ++++++++++++++++++-------
 1 file changed, 126 insertions(+), 44 deletions(-)


base-commit: 2241ab53cbb5cdb08a6b2d4688feb13971058f65
-- 
2.39.1.405.gd4c25cc71f-goog

