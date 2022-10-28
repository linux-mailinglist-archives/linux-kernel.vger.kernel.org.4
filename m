Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F4E6115B6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiJ1PSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiJ1PRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:17:46 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6134420C9B3;
        Fri, 28 Oct 2022 08:17:45 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id a27so327972qtw.10;
        Fri, 28 Oct 2022 08:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3yHtPsMV0ZtZibYDErsuqkp3aAUiU24r8aPqIVoD3v4=;
        b=G0PReAJxRHHhECs1xMrpz5JVRr0BPiY1fuvuAVG8/73NvKBO/56fFLrWtwJDVXK1em
         HSprFf8E3dw96NGJB/ZFUvr/1Yd15ugT9VOmzSyx6bfy7GD7HMRWPUUF9nUX+KBZpKLE
         HPt7ccgfQJwx8Dn76UX4FB6xOn5UOYdJHozwg7BhkBi7NdkhyFlK+WiR4VjxUXPrR9sS
         urfu6JcBK6cHz4sl3yCWxmg/eUoDUz6vMAgCOZpKqiEi7eAmXKq5XW5mG9XVgOhRf8zV
         B4wGaFOIM07lwpuGdSyxDj6xXF4T1EYP6iLuMPsqhWmBXXdJB/HvnmgIa2BESFJQcjcF
         xD7Q==
X-Gm-Message-State: ACrzQf0Mb3ahE9iDWgvKHTf6Jw1h2mT9OVHhl9MdkTEyT5af0ePcpr6I
        2skqCA6IQRioePQElyJYX5HF+cN5f9An9JNcX49yr0xpXIo=
X-Google-Smtp-Source: AMsMyM56+qk07VCJaQuHTA7kiZu2yoXyzvWZRejmZVKLQ2Gw033Kj2tA8Gfpghm1mG5cgYgDhng5931CHHO42Nc2k38=
X-Received: by 2002:a05:622a:1750:b0:39a:82aa:f4ab with SMTP id
 l16-20020a05622a175000b0039a82aaf4abmr46105697qtk.411.1666970264407; Fri, 28
 Oct 2022 08:17:44 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Oct 2022 17:17:33 +0200
Message-ID: <CAJZ5v0hT3gebDJdqjoODa_z+WgJqJBgusCg1j2P8Os4=mJ0G4g@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.1-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.1-rc3

with top-most commit 6f257934ed6170ed0094149e0e1bac09f7997103

 Merge branches 'pm-sleep', 'pm-domains' and 'pm-tools'

on top of commit 247f34f7b80357943234f93f247a1ae6b6c3a740

 Linux 6.1-rc2

to receive power management fixes for 6.1-rc3.

These make the intel_pstate driver work as expected on all hybrid
platforms to date (regardless of possible platform firmware issues),
fix hybrid sleep on systems using suspend-to-idle by default, make
the generic power domains code handle disabled idle states properly
and update pm-graph.

Specifics:

 - Make intel_pstate use what is known about the hardware instead of
   relying on information from the platform firmware (ACPI CPPC in
   particular) to establish the relationship between the HWP CPU
   performance levels and frequencies on all hybrid platforms
   available to date (Rafael Wysocki).

 - Allow hybrid sleep to use suspend-to-idle as a system suspend method
   if it is the current suspend method of choice (Mario Limonciello).

 - Fix handling of unavailable/disabled idle states in the generic
   power domains code (Sudeep Holla).

 - Update the pm-graph suite of utilities to version 5.10 which is
   fixes-mostly and does not add any new features (Todd Brandt).

Thanks!


---------------

Mario Limonciello (1):
      PM: hibernate: Allow hybrid sleep to work with s2idle

Rafael J. Wysocki (2):
      cpufreq: intel_pstate: Read all MSRs on the target CPU
      cpufreq: intel_pstate: hybrid: Use known scaling factor for P-cores

Sudeep Holla (1):
      PM: domains: Fix handling of unavailable/disabled idle states

Todd Brandt (1):
      pm-graph v5.10

---------------

 drivers/base/power/domain.c        |   4 +
 drivers/cpufreq/intel_pstate.c     | 133 ++++++++--------------
 kernel/power/hibernate.c           |   2 +-
 tools/power/pm-graph/README        |  12 +-
 tools/power/pm-graph/sleepgraph.8  |   3 +
 tools/power/pm-graph/sleepgraph.py | 225 ++++++++++++++++++-------------------
 6 files changed, 170 insertions(+), 209 deletions(-)
