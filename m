Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B9A64A554
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiLLQye convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Dec 2022 11:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiLLQyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:54:19 -0500
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8A32AA;
        Mon, 12 Dec 2022 08:54:18 -0800 (PST)
Received: by mail-qk1-f181.google.com with SMTP id k2so5385254qkk.7;
        Mon, 12 Dec 2022 08:54:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TW6thbnM7z7IgnYfclXqxiiG9/yBWQ5aLX8Q25LITNE=;
        b=bwQkSF7bP8RWip7diy16y/G5kxFtp1V3Bs45I2O+dYwTHu+6h73NG0pTLwQLyiNtO7
         RqNktG4l20mhpDJFyc/kXGuzlhQPOG9hfGBPylNwMOojIryzNk0/uD4BJcOcTISM0wU8
         G2FaF1n1/V6GwO/k7c9lrdNexumGoAqbmPNb1iCihKaZR7nsvdMUVVp/yzeH3Y0WvHCg
         qhHnuuIhg/J/HBXyVQBmW9BlGKlVYN6AJ8TzZlM6HgKD3CeELMqbHolTYZzOkjXf7s4g
         2lV5xmUZOKSKQeEIoox6gdBdsEp64dWbw2p+HlhgYby7FHt6k/tIjPW9yqeO7i3Qt7rZ
         GdYQ==
X-Gm-Message-State: ANoB5pnMKel1oMKQZXOnlvxq35gm9MymWW7t1WCpUV5z8liYChVaafoZ
        VZOx3lCFGVNqjzHaxNunhZb6VXDIeDpaURyz7/qCs03v0bQ=
X-Google-Smtp-Source: AA0mqf7WvCsajDgXNo7gzzIAgUeaIpDwX17kbR2VjvU/YXUKM8v5AugDrftNuh1soGucknaIWkXrDlBG3BHdHAdaasc=
X-Received: by 2002:a05:620a:ec4:b0:6ff:86de:55f with SMTP id
 x4-20020a05620a0ec400b006ff86de055fmr323161qkm.648.1670864057076; Mon, 12 Dec
 2022 08:54:17 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Dec 2022 17:54:06 +0100
Message-ID: <CAJZ5v0jVU0jbU6KmQNQ7hUZp=kA+CP7fVibRnb1qCVjHRH2Xow@mail.gmail.com>
Subject: [GIT PULL] ACPI and PNP updates for v6.2-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.2-rc1

with top-most commit bee74dcbd3908291f4bfff3c81a52d52dcd48814

 Merge branches 'acpi-fan', 'acpi-pcc', 'acpi-misc' and 'pnp'

on top of commit 76dcd734eca23168cb008912c0f69ff408905235

 Linux 6.1-rc8

to receive ACPI and PNP updates for 6.2-rc1.

These include new code (for instance, support for the FFH address space
type and support for new firmware data structures in ACPICA), some new
quirks (mostly related to backlight handling and I2C enumeration), a
number of fixes and a fair amount of cleanups all over.

Specifics:

 - Update the ACPICA code in the kernel to the 20221020 upstream
   version and fix a couple of issues in it:

   * Make acpi_ex_load_op() match upstream implementation (Rafael
     Wysocki).
   * Add support for loong_arch-specific APICs in MADT (Huacai Chen).
   * Add support for fixed PCIe wake event (Huacai Chen).
   * Add EBDA pointer sanity checks (Vit Kabele).
   * Avoid accessing VGA memory when EBDA < 1KiB (Vit Kabele).
   * Add CCEL table support to both compiler/disassembler (Kuppuswamy
     Sathyanarayanan).
   * Add a couple of new UUIDs to the known UUID list (Bob Moore).
   * Add support for FFH Opregion special context data (Sudeep Holla).
   * Improve warning message for "invalid ACPI name" (Bob Moore).
   * Add support for CXL 3.0 structures (CXIMS & RDPAS) in the CEDT
     table (Alison Schofield).
   * Prepare IORT support for revision E.e (Robin Murphy).
   * Finish support for the CDAT table (Bob Moore).
   * Fix error code path in acpi_ds_call_control_method() (Rafael
     Wysocki).
   * Fix use-after-free in acpi_ut_copy_ipackage_to_ipackage() (Li
     Zetao).
   * Update the version of the ACPICA code in the kernel (Bob Moore).

 - Use ZERO_PAGE(0) instead of empty_zero_page in the ACPI device
   enumeration code (Giulio Benetti).

 - Change the return type of the ACPI driver remove callback to void and
   update its users accordingly (Dawei Li).

 - Add general support for FFH address space type and implement the low-
   level part of it for ARM64 (Sudeep Holla).

 - Fix stale comments in the ACPI tables parsing code and make it print
   more messages related to MADT (Hanjun Guo, Huacai Chen).

 - Replace invocations of generic library functions with more kernel-
   specific counterparts in the ACPI sysfs interface (Christophe JAILLET,
   Xu Panda).

 - Print full name paths of ACPI power resource objects during
   enumeration (Kane Chen).

 - Eliminate a compiler warning regarding a missing function prototype
   in the ACPI power management code (Sudeep Holla).

 - Fix and clean up the ACPI processor driver (Rafael Wysocki, Li Zhong,
   Colin Ian King, Sudeep Holla).

 - Add quirk for the HP Pavilion Gaming 15-cx0041ur to the ACPI EC
   driver (Mia Kanashi).

 - Add some mew ACPI backlight handling quirks and update some existing
   ones (Hans de Goede).

 - Make the ACPI backlight driver prefer the native backlight control
   over vendor backlight control when possible (Hans de Goede).

 - Drop unsetting ACPI APEI driver data on remove (Uwe Kleine-König).

 - Use xchg_release() instead of cmpxchg() for updating new GHES cache
   slots (Ard Biesheuvel).

 - Clean up the ACPI APEI code (Sudeep Holla, Christophe JAILLET, Jay Lu).

 - Add new I2C device enumeration quirks for Medion Lifetab S10346 and
   Lenovo Yoga Tab 3 Pro (YT3-X90F) (Hans de Goede).

 - Make the ACPI battery driver notify user space about adding new
   battery hooks and removing the existing ones (Armin Wolf).

 - Modify the pfr_update and pfr_telemetry drivers to use ACPI_FREE()
   for freeing acpi_object structures to help diagnostics (Wang ShaoBo).

 - Make the ACPI fan driver use sysfs_emit_at() in its sysfs interface
   code (ye xingchen).

 - Fix the _FIF package extraction failure handling in the ACPI fan
   driver (Hanjun Guo).

 - Fix the PCC mailbox handling error code path (Huisong Li).

 - Avoid using PCC Opregions if there is no platform interrupt allocated
   for this purpose (Huisong Li).

 - Use sysfs_emit() instead of scnprintf() in the ACPI PAD driver and
   CPPC library (ye xingchen).

 - Fix some kernel-doc issues in the ACPI GSI processing code (Xiongfeng
   Wang).

 - Fix name memory leak in pnp_alloc_dev() (Yang Yingliang).

 - Do not disable PNP devices on suspend when they cannot be re-enabled
   on resume (Hans de Goede).

 - Clean up the ACPI thermal driver a bit (Rafael Wysocki).

Thanks!


---------------

Alison Schofield (1):
      ACPICA: Add CXL 3.0 structures (CXIMS & RDPAS) to the CEDT table

Ard Biesheuvel (1):
      apei/ghes: Use xchg_release() for updating new cache slot
instead of cmpxchg()

Armin Wolf (1):
      ACPI: battery: Call power_supply_changed() when adding hooks

Bob Moore (4):
      ACPICA: Add a couple of new UUIDs to the known UUID list
      ACPICA: Improve warning message for "invalid ACPI name"
      ACPICA: Finish support for the CDAT table
      ACPICA: Update version to 20221020

Christophe JAILLET (2):
      ACPI: sysfs: Use kstrtobool() instead of strtobool()
      ACPI: APEI: Remove a useless include

Colin Ian King (1):
      ACPI: processor: throttling: remove variable count

Dawei Li (1):
      ACPI: make remove callback of ACPI driver void

Giulio Benetti (1):
      ACPI: scan: substitute empty_zero_page with helper ZERO_PAGE(0)

Hanjun Guo (2):
      ACPI: tables: Fix the stale comments for acpi_locate_initial_tables()
      ACPI: fan: Bail out if extract package failed

Hans de Goede (10):
      ACPI: video: Add a few bugtracker links to DMI quirks
      ACPI: video: Change GIGABYTE GB-BXBT-2807 quirk to force_none
      ACPI: video: Change Sony Vaio VPCEH3U1E quirk to force_native
      ACPI: video: Add force_vendor quirk for Sony Vaio PCG-FRV35
      ACPI: video: Add force_native quirk for Sony Vaio VPCY11S1E
      ACPI: video: Simplify __acpi_video_get_backlight_type()
      ACPI: video: Prefer native over vendor
      PNP: Do not disable devices on suspend when they cannot be
re-enabled on resume
      ACPI: x86: Add skip i2c clients quirk for Lenovo Yoga Tab 3 Pro (YT3-X90F)
      ACPI: x86: Add skip i2c clients quirk for Medion Lifetab S10346

Huacai Chen (4):
      ACPICA: MADT: Add loong_arch-specific APICs support
      ACPICA: Events: Support fixed PCIe wake event
      Revert "LoongArch: Provisionally add ACPICA data structures"
      ACPI: tables: Print CORE_PIC information when MADT is parsed

Huisong Li (2):
      ACPI: PCC: Setup PCC Opregion handler only if platform interrupt
is available
      mailbox: pcc: Reset pcc_chan_count to zero in case of PCC probe failure

Jay Lu (2):
      ACPI: APEI: EINJ: Fix formatting errors
      ACPI: APEI: EINJ: Refactor available_error_type_show()

Kane Chen (1):
      ACPI: PM: Print full name path while adding power resource

Kuppuswamy Sathyanarayanan (1):
      ACPICA: iASL: Add CCEL table to both compiler/disassembler

Li Zetao (1):
      ACPICA: Fix use-after-free in acpi_ut_copy_ipackage_to_ipackage()

Li Zhong (1):
      ACPI: processor: idle: Check acpi_fetch_acpi_dev() return value

Mia Kanashi (1):
      ACPI: EC: Add quirk for the HP Pavilion Gaming 15-cx0041ur

Rafael J. Wysocki (10):
      ACPICA: Make acpi_ex_load_op() match upstream
      ACPICA: Add utcksum.o to the acpidump Makefile
      ACPICA: Fix error code path in acpi_ds_call_control_method()
      ACPI: thermal: Adjust critical.flags.valid check
      ACPI: processor: idle: Drop unnecessary statements and parens
      ACPI: processor: perflib: Adjust white space
      ACPI: processor: perflib: Drop redundant parentheses
      ACPI: processor: perflib: Rearrange unregistration routine
      ACPI: processor: perflib: Rearrange acpi_processor_notify_smm()
      ACPI: processor: perflib: Adjust acpi_processor_notify_smm() return value

Robin Murphy (1):
      ACPICA: IORT: Update for revision E.e

Sudeep Holla (9):
      ACPICA: Add support for FFH Opregion special context data
      ACPI: Implement a generic FFH Opregion handler
      arm64: Add architecture specific ACPI FFH Opregion callbacks
      ACPI: bus: Fix the _OSC capability check for FFH OpRegion
      ACPI: FFH: Silence missing prototype warnings
      ACPI: APEI: Silence missing prototype warnings
      ACPI: PM: Silence missing prototype warning
      ACPI: processor_idle: Silence missing prototype warnings
      ACPI: processor: Silence missing prototype warnings

Uwe Kleine-König (1):
      ACPI: APEI: Drop unsetting driver data on remove

Vit Kabele (2):
      ACPICA: Check that EBDA pointer is in valid memory
      ACPICA: Do not touch VGA memory when EBDA < 1ki_b

Wang ShaoBo (2):
      ACPI: pfr_telemetry: use ACPI_FREE() to free acpi_object
      ACPI: pfr_update: use ACPI_FREE() to free acpi_object

Xiongfeng Wang (1):
      ACPI: irq: Fix some kernel-doc issues

Xu Panda (1):
      ACPI: sysfs: use sysfs_emit() to instead of scnprintf()

Yang Yingliang (1):
      PNP: fix name memory leak in pnp_alloc_dev()

ye xingchen (2):
      ACPI: use sysfs_emit() instead of scnprintf()
      ACPI: fan: Convert to use sysfs_emit_at() API

---------------

 arch/arm64/kernel/acpi.c                          | 106 ++++++++++++++
 arch/ia64/hp/common/aml_nfw.c                     |   4 +-
 arch/loongarch/include/asm/acpi.h                 | 142 ------------------
 arch/x86/platform/olpc/olpc-xo15-sci.c            |   3 +-
 drivers/acpi/Kconfig                              |  10 ++
 drivers/acpi/Makefile                             |   1 +
 drivers/acpi/ac.c                                 |   8 +-
 drivers/acpi/acpi_ffh.c                           |  55 +++++++
 drivers/acpi/acpi_pad.c                           |   7 +-
 drivers/acpi/acpi_pcc.c                           |  47 +++---
 drivers/acpi/acpi_video.c                         |   8 +-
 drivers/acpi/acpica/Makefile                      |   1 +
 drivers/acpi/acpica/acglobal.h                    |   1 +
 drivers/acpi/acpica/actables.h                    |   5 -
 drivers/acpi/acpica/acutils.h                     |  13 ++
 drivers/acpi/acpica/dsmethod.c                    |  10 +-
 drivers/acpi/acpica/evevent.c                     |  11 ++
 drivers/acpi/acpica/evregion.c                    |   9 ++
 drivers/acpi/acpica/exconfig.c                    |   4 +-
 drivers/acpi/acpica/exfield.c                     |   8 +-
 drivers/acpi/acpica/exserial.c                    |   6 +
 drivers/acpi/acpica/hwsleep.c                     |  14 ++
 drivers/acpi/acpica/tbdata.c                      |   2 +-
 drivers/acpi/acpica/tbfadt.c                      |   2 +-
 drivers/acpi/acpica/tbprint.c                     |  77 +---------
 drivers/acpi/acpica/tbutils.c                     |   2 +-
 drivers/acpi/acpica/tbxfroot.c                    |  32 ++--
 drivers/acpi/acpica/utcksum.c                     | 170 ++++++++++++++++++++++
 drivers/acpi/acpica/utcopy.c                      |   7 -
 drivers/acpi/acpica/utglobal.c                    |   4 +
 drivers/acpi/acpica/utstring.c                    |  10 +-
 drivers/acpi/apei/apei-base.c                     |   2 +-
 drivers/acpi/apei/einj.c                          |  56 ++++---
 drivers/acpi/apei/ghes.c                          |  62 ++++----
 drivers/acpi/battery.c                            |  10 +-
 drivers/acpi/bus.c                                |   3 +
 drivers/acpi/button.c                             |   5 +-
 drivers/acpi/cppc_acpi.c                          |   4 +-
 drivers/acpi/ec.c                                 |  15 +-
 drivers/acpi/fan_attr.c                           |  16 +-
 drivers/acpi/fan_core.c                           |   1 +
 drivers/acpi/hed.c                                |   3 +-
 drivers/acpi/irq.c                                |   5 +-
 drivers/acpi/nfit/core.c                          |   3 +-
 drivers/acpi/pfr_telemetry.c                      |   6 +-
 drivers/acpi/pfr_update.c                         |   6 +-
 drivers/acpi/power.c                              |   2 +-
 drivers/acpi/processor_idle.c                     |   9 +-
 drivers/acpi/processor_perflib.c                  | 100 ++++++-------
 drivers/acpi/processor_throttling.c               |   4 +-
 drivers/acpi/sbs.c                                |   9 +-
 drivers/acpi/sbshc.c                              |   7 +-
 drivers/acpi/scan.c                               |   2 +-
 drivers/acpi/sysfs.c                              |   5 +-
 drivers/acpi/tables.c                             |  17 ++-
 drivers/acpi/thermal.c                            |   9 +-
 drivers/acpi/tiny-power-button.c                  |  10 +-
 drivers/acpi/video_detect.c                       | 110 ++++++++------
 drivers/acpi/x86/utils.c                          |  24 ++-
 drivers/char/sonypi.c                             |   3 +-
 drivers/char/tpm/tpm_crb.c                        |   4 +-
 drivers/hv/vmbus_drv.c                            |   4 +-
 drivers/hwmon/acpi_power_meter.c                  |   5 +-
 drivers/hwmon/asus_atk0110.c                      |   6 +-
 drivers/input/misc/atlas_btns.c                   |   4 +-
 drivers/mailbox/pcc.c                             |   1 +
 drivers/net/fjes/fjes_main.c                      |   4 +-
 drivers/platform/chrome/chromeos_privacy_screen.c |   3 +-
 drivers/platform/chrome/wilco_ec/event.c          |   4 +-
 drivers/platform/surface/surfacepro3_button.c     |   3 +-
 drivers/platform/x86/asus-laptop.c                |   3 +-
 drivers/platform/x86/asus-wireless.c              |   3 +-
 drivers/platform/x86/classmate-laptop.c           |  20 ++-
 drivers/platform/x86/dell/dell-rbtn.c             |   6 +-
 drivers/platform/x86/eeepc-laptop.c               |   3 +-
 drivers/platform/x86/fujitsu-laptop.c             |   4 +-
 drivers/platform/x86/fujitsu-tablet.c             |   3 +-
 drivers/platform/x86/intel/rst.c                  |   4 +-
 drivers/platform/x86/lg-laptop.c                  |   4 +-
 drivers/platform/x86/panasonic-laptop.c           |   8 +-
 drivers/platform/x86/sony-laptop.c                |   9 +-
 drivers/platform/x86/system76_acpi.c              |   4 +-
 drivers/platform/x86/topstar-laptop.c             |   3 +-
 drivers/platform/x86/toshiba_acpi.c               |   4 +-
 drivers/platform/x86/toshiba_bluetooth.c          |   6 +-
 drivers/platform/x86/toshiba_haps.c               |   4 +-
 drivers/platform/x86/wireless-hotkey.c            |   3 +-
 drivers/platform/x86/xo15-ebook.c                 |   3 +-
 drivers/pnp/core.c                                |   4 +-
 drivers/pnp/driver.c                              |   3 +-
 drivers/ptp/ptp_vmw.c                             |   3 +-
 drivers/thermal/intel/intel_menlow.c              |   8 +-
 drivers/video/backlight/apple_bl.c                |   3 +-
 drivers/watchdog/ni903x_wdt.c                     |   4 +-
 drivers/xen/xen-acpi-pad.c                        |   3 +-
 include/acpi/acconfig.h                           |   2 +
 include/acpi/acpi_bus.h                           |   2 +-
 include/acpi/acpixf.h                             |   2 +-
 include/acpi/actbl1.h                             | 151 ++++++++++++++++++-
 include/acpi/actbl2.h                             | 162 ++++++++++++++++++++-
 include/acpi/actypes.h                            |  10 +-
 include/acpi/acuuid.h                             |   3 +-
 include/acpi/processor.h                          |  10 ++
 include/linux/acpi.h                              |  13 ++
 tools/power/acpi/tools/acpidump/Makefile          |   1 +
 tools/power/acpi/tools/acpidump/apdump.c          |   4 +-
 106 files changed, 1172 insertions(+), 635 deletions(-)
