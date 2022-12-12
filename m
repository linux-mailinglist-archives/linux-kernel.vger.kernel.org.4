Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E3464A601
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 18:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbiLLRed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 12:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbiLLRdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 12:33:38 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D1C13DF2;
        Mon, 12 Dec 2022 09:33:24 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id fz10so9563085qtb.3;
        Mon, 12 Dec 2022 09:33:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FcqamNVbp2aF+rmJo2Yl2S00UCkp4K/1HRXPJQILO00=;
        b=Y+XFcPoQEWmRbAlMItxamB+qncbao0ab6Wm03Cby3JllXy0hWfKZiJ3MoVvLNai32e
         QDzDTeLX3qj4ukrJsHHrERxVC4WYfPgapl6/lHitfexlKCUZMHunIoekBQhBkPxSyrMS
         LZoI1Ru6Snv/3U/HiaQtHXLfnKuDo7EBswsaxgvBN74M2uC/tMA+cGjFjmKxPbdRV7fh
         /TFm2yv9oJXSFpGp7/NdaBQrdCouS67DIGO+f/BXx52DOxhrc7efQLbeuysAX2Zdh++j
         lZEvgFhFFQiPevXkVWaufvMHG+Wqb+w6iJnjYN7kZPW1Y20jRKEzk2CMWCcX8M+auoCW
         NEow==
X-Gm-Message-State: ANoB5pkjiTJ+N6EF5RjalG0kgI71FqB6V/0fFRfjuIppx2RnjmoDcor2
        nk427ZhF6PCu9DIf61Jx7MzSyN9QkzIozO3LZAPs33YMqz8=
X-Google-Smtp-Source: AA0mqf5MgQVaK81m6F3yxgCcFQeSExBExZ8BZQghS0o7yl+jzKceAXygQL/YE3HkwayBLqKypMR6t/nERv8F7xoVJdc=
X-Received: by 2002:a05:622a:410a:b0:3a5:5987:42c6 with SMTP id
 cc10-20020a05622a410a00b003a5598742c6mr87408854qtb.147.1670866403757; Mon, 12
 Dec 2022 09:33:23 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Dec 2022 18:33:12 +0100
Message-ID: <CAJZ5v0j=CNHAC-H9ci6qpTEeG4R1TD78oQWoKZXALN4TzPZubw@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v6.2-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
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
 thermal-6.2-rc1

with top-most commit 75b15aa0d83ec835082129b62e8cb9a44703ad72

 Merge branch 'thermal-intel'

on top of commit 247f34f7b80357943234f93f247a1ae6b6c3a740

 Linux 6.1-rc2

to receive thermal control updates for 6.2-rc1.

These include thermal core fixes to protect thermal device operations
against thermal device removal, other thermal core fixes and updates of
Intel thermal control drivers.

Specifics:

 - Fix race conditions related to thermal device operations that are not
   protected against thermal device removal (Guenter Roeck).

 - Fix error code in __thermal_cooling_device_register() (Dan Carpenter).

 - Validate new cooling device state (coming from user space) in
   cur_state_store() and reuse the max_state value from cooling device
   structure in the sysfs interface (Viresh Kumar).

 - Fix some possible name leaks in error paths in the thermal control
   core code (Yang Yingliang).

 - Detect TCC lock bit set in the intel_tcc_cooling driver and make it
   refuse to update the TCC offset in that case (Zhang Rui).

 - Add TCC cooling support for RaptorLake-S (Zhang Rui).

 - Prevent accidental clearing of HFI status by one of the other
   drivers using the same status register (Srinivas Pandruvada).

 - Protect clearing of thermal status bits in Intel thermal control
   drivers (Srinivas Pandruvada).

 - Allow the HFI thermal control driver to ACK an HFI event for the
   previously observed timestamp (Srinivas Pandruvada).

 - Remove a pointless die_id check from the HFI thermal driver and
   adjust the definition of a data structure used by it (Ricardo Neri).

The above said, there is potentially more thermal control material for
6.2, but I only received a pull request for it from Daniel on Friday
(https://patchwork.kernel.org/project/linux-pm/patch/3ccca41f-0899-b205-903b-ec8c742f3e91@linaro.org/).

It is not included here, because in my view it hasn't received
sufficient linux-next coverage yet, at least in its current form (some
of it was in linux-next before, but then it had to be rebased on top
of the fixes mentioned above), but deferring it by a whole release
cycle wouldn't be my choice either.  In this particular case, the
reason for the delay was an unfortunate coincidence of events rather
than anything else (Daniel's extended sick leave that prevented him
from being able to participate in the development process while he had
had quite a bit of work staged already that overlapped with the
submission of important fixes).  While I realize that this is a "late"
merge window, deferring stuff from people that was submitted timely,
but had not been processed because of a maintainer's absence that
wasn't his fault, feels a bit harsh.

I would really appreciate it if you please give me your recommendation
regarding the extra thermal control material.  Would you like to
receive a pull request with it later during this merge window, or
would you prefer it to wait for the 6.3 one?

Thanks!


---------------

Dan Carpenter (1):
      thermal/core: fix error code in __thermal_cooling_device_register()

Guenter Roeck (9):
      thermal/core: Destroy thermal zone device mutex in release function
      thermal/core: Delete device under thermal device zone lock
      thermal/core: Ensure that thermal device is registered in
thermal_zone_get_temp
      thermal/core: Move parameter validation from
__thermal_zone_get_temp to thermal_zone_get_temp
      thermal/core: Introduce locked version of thermal_zone_device_update
      thermal/core: Protect hwmon accesses to thermal operations with
thermal zone mutex
      thermal/core: Protect sysfs accesses to thermal operations with
thermal zone mutex
      thermal/core: Remove thermal_zone_set_trips()
      thermal/core: Protect thermal device operations against thermal
device removal

Ricardo Neri (2):
      thermal: intel: hfi: Improve the type of hfi_features::nr_table_pages
      thermal: intel: hfi: Remove a pointless die_id check

Srinivas Pandruvada (3):
      thermal: intel: Prevent accidental clearing of HFI status
      thermal: intel: Protect clearing of thermal status bits
      thermal: intel: hfi: ACK HFI for the same timestamp

Viresh Kumar (2):
      thermal: Validate new state in cur_state_store()
      thermal: sysfs: Reuse cdev->max_state

Yang Yingliang (1):
      thermal: core: fix some possible name leaks in error paths

Zhang Rui (2):
      thermal: intel: intel_tcc_cooling: Detect TCC lock bit
      thermal: intel: intel_tcc_cooling: Add TCC cooling support for
RaptorLake-S

---------------

 drivers/thermal/gov_fair_share.c             |   6 +-
 drivers/thermal/intel/intel_hfi.c            |  34 +++++---
 drivers/thermal/intel/intel_tcc_cooling.c    |  11 +++
 drivers/thermal/intel/therm_throt.c          |  25 +++---
 drivers/thermal/intel/thermal_interrupt.h    |   6 ++
 drivers/thermal/intel/x86_pkg_temp_thermal.c |   9 +--
 drivers/thermal/thermal_core.c               | 110 +++++++++++++++----------
 drivers/thermal/thermal_core.h               |   3 +-
 drivers/thermal/thermal_helpers.c            |  67 ++++++++++------
 drivers/thermal/thermal_hwmon.c              |  10 ++-
 drivers/thermal/thermal_sysfs.c              | 116 ++++++++++++++++++---------
 include/linux/thermal.h                      |   1 +
 12 files changed, 256 insertions(+), 142 deletions(-)
