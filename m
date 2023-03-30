Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580D46D0766
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjC3N4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjC3N4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:56:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D647F5266
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:56:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f66-20020a255145000000b00b714602d43fso19056761ybb.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680184569;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Jw1BbU3G1vWWd2aYAwIMv2kp7z100nGjWlqtflgrAc=;
        b=EohCILKk2TdGha5zOMheE+fnG+ota0CGyE78J0LgoRSYqdGJD94O8sTgmZH8vREJky
         7bs47pZR0rZxDBjj+hWUSCSALuDVrgD4WGUY//Xa6TFJ31mpRbSB+iL7AXLzXMVmzuIA
         mFF0fdaFRveeQnElVcd5FBoLJQOIRBqJnbQF0uxqCC2Vkpa/WELoLOz9cx10B1+wzeBh
         JsrPkb4telwRT6rYezqEEpwpML0C5VOpXuelj3lGzRG9jnz/Fnsnf8rHVq907FdOphmk
         9ZqU6zIjHbsKTC1owIHqwU7wMXo3Ddv0tCyCJDAN+qtDzV+RtmAX9ugY1zyusRtgqn3p
         Du4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680184569;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Jw1BbU3G1vWWd2aYAwIMv2kp7z100nGjWlqtflgrAc=;
        b=yG5mWgujEZA55EL6CaTidjGsn1ygOHLnAHEZLAixNCZ2cn1uFM9hiN7EddkTiufzMm
         /OvaGoPa2yaqn/E1P2sTvSLydHt2CXj/wYIwczaYSPfnTnCQsekfHRdu91pOSi61+0Nt
         ijuqa/rno+DKYq/sCpN1tOI6WpKx23LUoflYas8a1AORJexL0pGlXR3pm0BZV4bp/+12
         4LVzepWqubmUBTcmr8QG+FAMvW8QdpXbfi6fq/mD5xW/6kMisO/EL1RPRKyam5hjvxDc
         MU19TkdzycQMHBx40z3Yg/fz+1wq+v1h/XItF1xhs1anXHFSkBXuy2XKapooZ1iQLfEA
         vDUw==
X-Gm-Message-State: AAQBX9cRGD4tQOzeh/2NsVcbX/p+UXnv3cEv2RpySqIG00Bypeg+EPRY
        5eDbrx1XTcaKy2DeUVuVyKJrAqUffi0X/1MJ4w==
X-Google-Smtp-Source: AKy350Y6hCev3BJVsYvEaMT8W/66OgvjX6OnHAAUGXwt3fdVTtNUdEW6k0w2FU8OVgrvdT/aIHooSqLtbdxk50gFsQ==
X-Received: from peternewman-vh.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:30cc])
 (user=peternewman job=sendgmr) by 2002:a81:bc0c:0:b0:545:612a:c04a with SMTP
 id a12-20020a81bc0c000000b00545612ac04amr11140543ywi.8.1680184569073; Thu, 30
 Mar 2023 06:56:09 -0700 (PDT)
Date:   Thu, 30 Mar 2023 15:55:55 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230330135558.1019658-1-peternewman@google.com>
Subject: [PATCH v5 0/3] Subject: x86/resctrl: Implement rename to help move
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
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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


base-commit: 197b6b60ae7bc51dd0814953c562833143b292aa
-- 
2.40.0.348.gf938b09366-goog

