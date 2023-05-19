Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC34709B57
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 17:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjESPaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 11:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjESPaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 11:30:09 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8963ECF;
        Fri, 19 May 2023 08:30:08 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-96a6c0cc0fbso85150566b.1;
        Fri, 19 May 2023 08:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684510207; x=1687102207;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hcZ/Ub84YadBRwYZeJ0rs+CniJfE2wBfphDsgARviFw=;
        b=Zkx7uoxrkoVBzCuzGy1rMFkNs3VIqOCK+vFWH21ZAQS+Y23vCMW3ZN4QoW72MNbyWC
         KPk5FK9qT5aIgmFXCFIZ92VpTR0PIjqmYkpNKf6ZcBtRpGxUUFf4MVbWrNQzE8dFMB7m
         0SZTpG2PabZ8PJjksp1OC/uUqvGhzAPDSH2+aQIKZXE6XwNgWMtUoM/pEH+6x6EGLWIT
         Cd6qDRbBvEC3dUmknms+AuoX+uMVaAL9OPuF4I9IYkc8e31JtFvIbj77GFNKQ/yinTzr
         0U4I6gtTjQWX2Ijz2NI1v7RQmp/xWiBG9marup80zSkxn/26zRq2bkKTTf8tWxtJGUD7
         zW2A==
X-Gm-Message-State: AC+VfDz4wB7M5WE7Ckj8Y/o7PEb96m0Sk5szQTp4GiWttn6F5qSZsN1g
        GIlnpdwL7IYuDK6Ddl1la347/wzUBiD8deERmz4=
X-Google-Smtp-Source: ACHHUZ42Pwf/DpsQ/roRNrt1pUd9unjJ13E4hrqjMO8VNbOSd+9qmhWWCiO3jCcwjGwEYRD+RWyKM3h66zY0IFCIiCg=
X-Received: by 2002:a17:906:74dd:b0:929:b101:937d with SMTP id
 z29-20020a17090674dd00b00929b101937dmr2628424ejl.1.1684510206855; Fri, 19 May
 2023 08:30:06 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 19 May 2023 17:29:55 +0200
Message-ID: <CAJZ5v0ifvaf3FBLtKGkSJxEkxLWA8dSatp2hygtYnSbnNRo65w@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.4-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.4-rc3

with top-most commit 5783ecc90e24a870a563b1acbfd13cad3786e519

 Merge branch 'pm-tools'

on top of commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6

 Linux 6.4-rc2

to receive power management fixes for 6.4-rc3.

These fix two issues in the cpupower utility and get rid of a spurious
warning message printed to the kernel log by the ACPI cpufreq driver
after recent changes.

Specifics:

 - Get rid of a warning message printed by the ACPI cpufreq driver
   after recent changes in it when anohter CPU performance scaling
   driver is registered already when it starts (Petr Pavlu).

 - Make cpupower read TSC on each CPU right before reading MPERF so as
   to reduce the potential time difference between the TSC and MPERF
   accesses and improve the C0 percentage calculation (Wyes Karny).

 - Fix a possible file handle leak and clean up the code in the
   sysfs_get_enabled() function in cpupower (Hao Zeng).

Thanks!


---------------

Hao Zeng (1):
      cpupower:Fix resource leaks in sysfs_get_enabled()

Petr Pavlu (1):
      cpufreq: ACPI: Prevent a warning when another frequency driver is loaded

Wyes Karny (1):
      cpupower: Make TSC read per CPU for Mperf monitor

---------------

 drivers/cpufreq/acpi-cpufreq.c                     |  2 +-
 drivers/cpufreq/pcc-cpufreq.c                      |  2 +-
 tools/power/cpupower/lib/powercap.c                | 23 +++++++++++-----
 .../cpupower/utils/idle_monitor/mperf_monitor.c    | 31 ++++++++++------------
 4 files changed, 32 insertions(+), 26 deletions(-)
