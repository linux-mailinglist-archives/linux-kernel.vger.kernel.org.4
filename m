Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD80774A36C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 19:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjGFRtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 13:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjGFRtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:49:03 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC18D199F;
        Thu,  6 Jul 2023 10:49:01 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2b69e11fa0aso2946541fa.0;
        Thu, 06 Jul 2023 10:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688665740; x=1691257740;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4g3iGOTuRVVAduXIDQ5lVw5E6xrdfj8KWQJtFXm23Cc=;
        b=Ne3ObRdpcWlvemzAczi1zS/jIZ7RlyGvb4NFa3N6O9HHbYIN16hVVAvFarsBGVr96n
         Jdf4lEQ+Dorm4Rl6ne39wvUaVQYdFoW1V7ew+apkYYnK0r9+VZ+baCnYuo3UeHvHLM+G
         ql4cbv3XJpudtV+zebErgxlJqYLgpxZkhIn/x0Hgav1k1L8+WkRhLVnYFqFteYidwhoL
         wjOsDe2FOnlAHxnjFcmW6W5L63oB3lyOv6jIuMFmzaWPYc2tDiIWIMo7Ek3pOL3uVxMB
         YKe9x07G+fBjHBn7DtAomeP0uP/xlJla9fdqk6cWco20pvR6nMzHtQ2zt4wnE1uAb/8d
         OcXw==
X-Gm-Message-State: ABy/qLZ+kpzWRq/YDlCQuIpyNo1ndFK8ESqKY3mjw3KfGrAXLlLiDo0B
        8BWGAHQQNXohxeTQayPQnsYXozZRhcLJJ8e5Rlh1yXrmwro=
X-Google-Smtp-Source: APBJJlGmCmIusH5ZTJB91Me490qiv7AARCUFaRGmR4trsXk+WlNixyUkkJlxVNrjM26Ubqg0dpVxLX47GHZRxOYHN/g=
X-Received: by 2002:a05:651c:989:b0:2b6:99a2:fe00 with SMTP id
 b9-20020a05651c098900b002b699a2fe00mr2324596ljq.2.1688665739811; Thu, 06 Jul
 2023 10:48:59 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 Jul 2023 19:48:48 +0200
Message-ID: <CAJZ5v0hN3FW_wgM_GP6oqLZe=9=aNmHE3_rWnzoAFrgcHXYA+Q@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v6.5-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.5-rc1-3

with top-most commit 2e178ee13b02d95c7380f6a21149de535ccdfc7f

 Merge branches 'acpi-bus' and 'acpi-scan'

on top of commit b5539eb5ee70257520e40bb636a295217c329a50

 ACPI: EC: Fix acpi_ec_dispatch_gpe()

to receive additional ACPI updates for 6.5-rc1.

These fix a couple of compiler warnings, refine an ACPI device
enumeration quirk to address a driver regression and clean up
code.

Specifics:

 - Make acpi_companion_match() return a const pointer and update its
   callers accordingly (Andy Shevchenko).

 - Move the extern declaration of the acpi_root variable to a header
   file so as to address a compiler warning (Andy Shevchenko).

 - Address compiler warnings in the ACPI device enumeration code by
   adding a missing header file inclusion to it (Ben Dooks).

 - Refine the SMB0001 quirk in the ACPI device enumeration code so as to
   address an i2c-scmi driver regression (Andy Shevchenko).

 - Clean up two pieces of the ACPI device enumeration code (Andy
   Shevchenko).

Thanks!


---------------

Andy Shevchenko (6):
      ACPI: scan: Move acpi_root to internal header
      ACPI: bus: Constify acpi_companion_match() returned value
      ACPI: bus: Introduce acpi_match_acpi_device() helper
      ACPI: platform: Ignore SMB0001 only when it has resources
      ACPI: platform: Move SMB0001 HID to the header and reuse
      ACPI: scan: Use the acpi_match_acpi_device() helper

Ben Dooks (1):
      ACPI: scan: fix undeclared variable warnings by including sleep.h

---------------

 drivers/acpi/acpi_platform.c  | 31 ++++++++++++++++++++++++++++---
 drivers/acpi/bus.c            | 31 ++++++++++++++++++++++++-------
 drivers/acpi/device_sysfs.c   |  2 +-
 drivers/acpi/internal.h       |  4 +++-
 drivers/acpi/scan.c           | 24 +++++++++++++-----------
 drivers/i2c/busses/i2c-scmi.c |  3 ---
 include/acpi/acpi_drivers.h   |  2 ++
 include/linux/acpi.h          |  9 +++++++++
 8 files changed, 80 insertions(+), 26 deletions(-)
