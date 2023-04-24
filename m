Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8936ED3EB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjDXRv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDXRvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:51:55 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F336A78;
        Mon, 24 Apr 2023 10:51:52 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9594916df23so49932466b.1;
        Mon, 24 Apr 2023 10:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682358711; x=1684950711;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/QvfYqIhO/XlPG4glcdwmK3JXUslmY9lQkeiMxD73Xs=;
        b=WxunFS/RgryQaQNjz+sSK78v0c6E9XEbSPrc7GSemRKlWUSVhpSGCmGuqgEOqKpAbp
         6/H8bse5zf3TNODMKXMbZdbCCKQ+HxnLvPxRQz3OporZLA3ZyH55yt2p+yMpTSF60aje
         qmga/NCouWuUG2kOJ0SG5IlNwbq3TUFlkSnuo127PQsebHSHDlkDm2SfzYQxxVfdeqnQ
         TkgCUs98ouXAuvcyMi3Rdtu5DAuSHXZegBfyMvtffzISp6scaU9+ssjT+2ZCxxHG8idM
         tKS/tCBAuVcAfNzapYqpgSuEbDA415AML+1+BaTy+1CqtmdJiQ/bLC8priLmET0y+mJc
         146A==
X-Gm-Message-State: AAQBX9c4YmlkLUxDhMUACpUyTW+i8ztMj77yKGO3Li/g/USVTXDlfa6K
        +8iKPU3T9UGgoU2SdEuenJHy0fcTOh3sWVW+/CAeSJDZYVU=
X-Google-Smtp-Source: AKy350YEQllbl4wbs+eVpaVacQ+nbxRBMBzNdR0DWKgdZoM2ofw/izOjrFSNUIweHSqcmysXgFZo7E4MmRDRDt2mHyw=
X-Received: by 2002:a17:906:82c1:b0:92f:27c2:13c0 with SMTP id
 a1-20020a17090682c100b0092f27c213c0mr12253790ejy.6.1682358710603; Mon, 24 Apr
 2023 10:51:50 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 Apr 2023 19:51:39 +0200
Message-ID: <CAJZ5v0h8Biaa+9GMaXs4N-OQDKa=k+fPO5zgzroATTUaaay4Ug@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v6.4-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
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
 acpi-6.4-rc1

with top-most commit 4f810294e00bd99da9ec3c8fe3185a73e39bcd6c

 Merge branches 'acpi-utils' and 'acpi-docs'

on top of commit 6a8f57ae2eb07ab39a6f0ccad60c760743051026

 Linux 6.3-rc7

to receive ACPI updates for 6.4-rc1.

These update the ACPICA code in the kernel to upstream revision 20230331,
fix the ACPI SBS driver and the evaluation of the _PDC method on Xen
dom0 in the ACPI processor driver, update the ACPI driver for Intel SoCs
and clean up code in multiple places.

Specifics:

 - Update the ACPICA code in the kernel to upstream revision 20230331
   including the following changes:
   * Delete bogus node_array array of pointers from AEST table (Jessica
     Clarke).
   * Add support for trace buffer extension in GICC to the ACPI MADT
     parser (Xiongfeng Wang).
   * Add missing macro ACPI_FUNCTION_TRACE() for acpi_ns_repair_HID()
     (Xiongfeng Wang).
   * Add missing tables to astable (Pedro Falcato).
   * Add support for 64 bit loong_arch compilation to ACPICA (Huacai
     Chen).
   * Add support for ASPT table in disassembler to ACPICA (Jeremi
     Piotrowski).
   * Add support for Arm's MPAM ACPI table version 2 (Hesham Almatary).
   * Update all copyrights/signons in ACPICA to 2023 (Bob Moore).
   * Add support for ClockInput resource (v6.5) (Niyas Sait).
   * Add RISC-V INTC interrupt controller definition to the list of
     supported interrupt controllers for MADT (Sunil V L).
   * Add structure definitions for the RISC-V RHCT ACPI table (Sunil V L).
   * Address several cases in which the ACPICA code might lead to
     undefined behavior (Tamir Duberstein).
   * Make ACPICA code support flexible arrays properly (Kees Cook).
   * Check null return of ACPI_ALLOCATE_ZEROED in
     acpi_db_display_objects() (void0red).
   * Add os specific support for Zephyr RTOS to ACPICA (Najumon).
   * Update version to 20230331 (Bob Moore).

 - Fix evaluating the _PDC ACPI control method when running as Xen
   dom0 (Roger Pau Monne).

 - Use platform devices to load ACPI PPC and PCC drivers (Petr Pavlu).

 - Check for null return of devm_kzalloc() in fch_misc_setup() (Kang
   Chen).

 - Log a message if enable_irq_wake() fails for the ACPI SCI (Simon
   Gaiser).

 - Initialize the correct IOMMU fwspec while parsing ACPI VIOT
   (Jean-Philippe Brucker).

 - Amend indentation and prefix error messages with FW_BUG in the ACPI
   SPCR parsing code (Andy Shevchenko).

 - Enable ACPI sysfs support for CCEL records (Kuppuswamy
   Sathyanarayanan).

 - Make the APEI error injection code warn on invalid arguments when
   explicitly indicated by platform (Shuai Xue).

 - Add CXL error types to the error injection code in APEI (Tony Luck).

 - Refactor acpi_data_prop_read_single() (Andy Shevchenko).

 - Fix two issues in the ACPI SBS driver (Armin Wolf).

 - Replace ternary operator with min_t() in the generic ACPI thermal
   zone driver (Jiangshan Yi).

 - Ensure that ACPI notify handlers are not running after removal and
   clean up code in acpi_sb_notify() (Rafael Wysocki).

 - Remove register_backlight_delay module option and code and remove
   quirks for false-positive backlight control support advertised on
   desktop boards (Hans de Goede).

 - Replace irqdomain.h include with struct declarations in ACPI headers
   and update several pieces of code previously including of.h
   implicitly through those headers (Rob Herring).

 - Fix acpi_evaluate_dsm_typed() redefinition error (Kiran K).

 - Update the pm_profile sysfs attribute documentation (Rafael Wysocki).

 - Add 80862289 ACPI _HID for second PWM controller on Cherry Trail to
   the ACPI driver for Intel SoCs (Hans de Goede).

Thanks!


---------------

Andy Shevchenko (3):
      ACPI: SPCR: Prefix error messages with FW_BUG
      ACPI: property: Refactor acpi_data_prop_read_single()
      ACPI: SPCR: Amend indentation

Armin Wolf (3):
      ACPI: EC: Limit explicit removal of query handlers to custom
query handlers
      ACPI: EC: Fix oops when removing custom query handlers
      ACPI: SBS: Fix handling of Smart Battery Selectors

Bob Moore (2):
      ACPICA: Update all copyrights/signons to 2023
      ACPICA: Update version to 20230331

Hans de Goede (3):
      ACPI: video: Remove register_backlight_delay module option and code
      ACPI: video: Remove desktops without backlight DMI quirks
      ACPI: LPSS: Add 80862289 ACPI _HID for second PWM controller on
Cherry Trail

Hesham Almatary (1):
      ACPICA: Add support for Arm's MPAM ACPI table version 2

Huacai Chen (1):
      ACPICA: Add support for 64 bit loong_arch compilation

Jean-Philippe Brucker (1):
      ACPI: VIOT: Initialize the correct IOMMU fwspec

Jeremi Piotrowski (1):
      ACPICA: Add support for ASPT table in disassembler

Jessica Clarke (1):
      ACPICA: Headers: Delete bogus node_array array of pointers from AEST table

Jiangshan Yi (1):
      ACPI: thermal: Replace ternary operator with min_t()

Kang Chen (1):
      ACPI: processor: Check for null return of devm_kzalloc() in
fch_misc_setup()

Kees Cook (10):
      ACPICA: struct acpi_resource_vendor: Replace 1-element array
with flexible array
      ACPICA: actbl1: Replace 1-element arrays with flexible arrays
      ACPICA: actbl2: Replace 1-element arrays with flexible arrays
      ACPICA: struct acpi_nfit_interleave: Replace 1-element array
with flexible array
      ACPICA: Introduce ACPI_FLEX_ARRAY
      ACPICA: struct acpi_resource_dma: Replace 1-element array with
flexible array
      ACPICA: acpi_pci_routing_table: Replace fixed-size array with
flex array member
      ACPICA: acpi_dmar_andd: Replace 1-element array with flexible array
      ACPICA: acpi_madt_oem_data: Fix flexible array member definition
      ACPICA: acpi_resource_irq: Replace 1-element arrays with flexible array

Kiran K (1):
      ACPI: utils: Fix acpi_evaluate_dsm_typed() redefinition error

Kuppuswamy Sathyanarayanan (1):
      ACPI: sysfs: Enable ACPI sysfs support for CCEL records

Najumon (1):
      ACPICA: add os specific support for Zephyr RTOS

Niyas Sait (1):
      ACPICA: add support for ClockInput resource (v6.5)

Pedro Falcato (1):
      ACPICA: acpisrc: Add missing tables to astable

Petr Pavlu (1):
      ACPI: cpufreq: Use platform devices to load ACPI PPC and PCC drivers

Rafael J. Wysocki (3):
      ACPI: docs: Update the pm_profile sysfs attribute documentation
      ACPI: bus: Add missing braces to acpi_sb_notify()
      ACPI: bus: Ensure that notify handlers are not running after removal

Rob Herring (10):
      iio: adc: ad7292: Add explicit include for of.h
      staging: iio: resolver: ad2s1210: Add explicit include for of.h
      net: rfkill-gpio: Add explicit include for of.h
      serial: 8250_tegra: Add explicit include for of.h
      ata: pata_macio: Add explicit include of irqdomain.h
      pata: ixp4xx: Add explicit include for of.h
      virtio-mmio: Add explicit include for of.h
      tpm: atmel: Add explicit include for of.h
      fpga: lattice-sysconfig-spi: Add explicit include for of.h
      ACPI: Replace irqdomain.h include with struct declarations

Roger Pau Monne (1):
      ACPI: processor: Fix evaluating _PDC method when running as Xen dom0

Shuai Xue (1):
      ACPI: APEI: EINJ: warn on invalid argument when explicitly
indicated by platform

Simon Gaiser (1):
      ACPI: s2idle: Log when enabling wakeup IRQ fails

Sunil V L (2):
      ACPICA: MADT: Add RISC-V INTC interrupt controller
      ACPICA: Add structure definitions for RISC-V RHCT

Tamir Duberstein (8):
      ACPICA: Avoid undefined behavior: load of misaligned address
      ACPICA: Avoid undefined behavior: applying zero offset to null pointer
      ACPICA: Avoid undefined behavior: member access within null pointer
      ACPICA: Avoid undefined behavior: member access within misaligned address
      ACPICA: Avoid undefined behavior: member access within misaligned address
      ACPICA: Avoid undefined behavior: member access within misaligned address
      ACPICA: Avoid undefined behavior: member access within misaligned address
      ACPICA: Avoid undefined behavior: load of misaligned address

Tony Luck (1):
      ACPI: APEI: EINJ: Add CXL error types

Xiongfeng Wang (2):
      ACPICA: ACPI 6.5: MADT: add support for trace buffer extension in GICC
      ACPICA: Add missing macro ACPI_FUNCTION_TRACE() for acpi_ns_repair_HID()

void0red (1):
      ACPICA: ACPICA: check null return of ACPI_ALLOCATE_ZEROED in
acpi_db_display_objects

---------------

 Documentation/ABI/stable/sysfs-acpi-pmprofile      |  20 +-
 drivers/acpi/acpi_apd.c                            |   2 +
 drivers/acpi/acpi_lpss.c                           |   7 +
 drivers/acpi/acpi_processor.c                      |  42 +++-
 drivers/acpi/acpi_video.c                          |  38 ----
 drivers/acpi/acpica/acapps.h                       |   2 +-
 drivers/acpi/acpica/accommon.h                     |   2 +-
 drivers/acpi/acpica/acconvert.h                    |   2 +-
 drivers/acpi/acpica/acdebug.h                      |   2 +-
 drivers/acpi/acpica/acdispat.h                     |   2 +-
 drivers/acpi/acpica/acevents.h                     |   2 +-
 drivers/acpi/acpica/acglobal.h                     |   2 +-
 drivers/acpi/acpica/achware.h                      |   2 +-
 drivers/acpi/acpica/acinterp.h                     |   2 +-
 drivers/acpi/acpica/aclocal.h                      |   5 +-
 drivers/acpi/acpica/acmacros.h                     |   2 +-
 drivers/acpi/acpica/acnamesp.h                     |   2 +-
 drivers/acpi/acpica/acobject.h                     |   2 +-
 drivers/acpi/acpica/acopcode.h                     |   2 +-
 drivers/acpi/acpica/acparser.h                     |   2 +-
 drivers/acpi/acpica/acpredef.h                     |   2 +-
 drivers/acpi/acpica/acresrc.h                      |   4 +-
 drivers/acpi/acpica/acstruct.h                     |   2 +-
 drivers/acpi/acpica/actables.h                     |   2 +-
 drivers/acpi/acpica/acutils.h                      |   4 +-
 drivers/acpi/acpica/amlcode.h                      |   2 +-
 drivers/acpi/acpica/amlresrc.h                     |  24 ++-
 drivers/acpi/acpica/dbhistry.c                     |   2 +-
 drivers/acpi/acpica/dbnames.c                      |   3 +
 drivers/acpi/acpica/dsargs.c                       |   2 +-
 drivers/acpi/acpica/dscontrol.c                    |   2 +-
 drivers/acpi/acpica/dsdebug.c                      |   2 +-
 drivers/acpi/acpica/dsfield.c                      |   2 +-
 drivers/acpi/acpica/dsinit.c                       |   2 +-
 drivers/acpi/acpica/dsmethod.c                     |   2 +-
 drivers/acpi/acpica/dsobject.c                     |   2 +-
 drivers/acpi/acpica/dsopcode.c                     |   2 +-
 drivers/acpi/acpica/dspkginit.c                    |   2 +-
 drivers/acpi/acpica/dswexec.c                      |   2 +-
 drivers/acpi/acpica/dswload.c                      |   2 +-
 drivers/acpi/acpica/dswload2.c                     |   2 +-
 drivers/acpi/acpica/dswscope.c                     |   2 +-
 drivers/acpi/acpica/dswstate.c                     |  13 +-
 drivers/acpi/acpica/evevent.c                      |   2 +-
 drivers/acpi/acpica/evglock.c                      |   2 +-
 drivers/acpi/acpica/evgpe.c                        |   2 +-
 drivers/acpi/acpica/evgpeblk.c                     |   2 +-
 drivers/acpi/acpica/evgpeinit.c                    |   2 +-
 drivers/acpi/acpica/evgpeutil.c                    |   2 +-
 drivers/acpi/acpica/evhandler.c                    |   2 +-
 drivers/acpi/acpica/evmisc.c                       |   2 +-
 drivers/acpi/acpica/evregion.c                     |   2 +-
 drivers/acpi/acpica/evrgnini.c                     |   6 +-
 drivers/acpi/acpica/evxface.c                      |   2 +-
 drivers/acpi/acpica/evxfevnt.c                     |   2 +-
 drivers/acpi/acpica/evxfgpe.c                      |   2 +-
 drivers/acpi/acpica/evxfregn.c                     |   2 +-
 drivers/acpi/acpica/exconcat.c                     |   2 +-
 drivers/acpi/acpica/exconfig.c                     |   2 +-
 drivers/acpi/acpica/exconvrt.c                     |   2 +-
 drivers/acpi/acpica/excreate.c                     |   2 +-
 drivers/acpi/acpica/exdebug.c                      |   2 +-
 drivers/acpi/acpica/exdump.c                       |   2 +-
 drivers/acpi/acpica/exfield.c                      |   2 +-
 drivers/acpi/acpica/exfldio.c                      |   2 +-
 drivers/acpi/acpica/exmisc.c                       |   2 +-
 drivers/acpi/acpica/exmutex.c                      |   2 +-
 drivers/acpi/acpica/exnames.c                      |   2 +-
 drivers/acpi/acpica/exoparg1.c                     |   2 +-
 drivers/acpi/acpica/exoparg2.c                     |   2 +-
 drivers/acpi/acpica/exoparg3.c                     |   2 +-
 drivers/acpi/acpica/exoparg6.c                     |   2 +-
 drivers/acpi/acpica/exprep.c                       |   2 +-
 drivers/acpi/acpica/exregion.c                     |   6 +-
 drivers/acpi/acpica/exresnte.c                     |   2 +-
 drivers/acpi/acpica/exresolv.c                     |   2 +-
 drivers/acpi/acpica/exresop.c                      |   2 +-
 drivers/acpi/acpica/exserial.c                     |   2 +-
 drivers/acpi/acpica/exstore.c                      |   2 +-
 drivers/acpi/acpica/exstoren.c                     |   2 +-
 drivers/acpi/acpica/exstorob.c                     |   2 +-
 drivers/acpi/acpica/exsystem.c                     |   2 +-
 drivers/acpi/acpica/extrace.c                      |   2 +-
 drivers/acpi/acpica/exutils.c                      |   2 +-
 drivers/acpi/acpica/hwacpi.c                       |   2 +-
 drivers/acpi/acpica/hwesleep.c                     |   2 +-
 drivers/acpi/acpica/hwgpe.c                        |   2 +-
 drivers/acpi/acpica/hwsleep.c                      |   2 +-
 drivers/acpi/acpica/hwtimer.c                      |   2 +-
 drivers/acpi/acpica/hwvalid.c                      |   2 +-
 drivers/acpi/acpica/hwxface.c                      |   2 +-
 drivers/acpi/acpica/hwxfsleep.c                    |   2 +-
 drivers/acpi/acpica/nsarguments.c                  |   2 +-
 drivers/acpi/acpica/nsconvert.c                    |   2 +-
 drivers/acpi/acpica/nsdump.c                       |   2 +-
 drivers/acpi/acpica/nsdumpdv.c                     |   2 +-
 drivers/acpi/acpica/nsinit.c                       |   2 +-
 drivers/acpi/acpica/nsload.c                       |   2 +-
 drivers/acpi/acpica/nsparse.c                      |   2 +-
 drivers/acpi/acpica/nspredef.c                     |   2 +-
 drivers/acpi/acpica/nsprepkg.c                     |   2 +-
 drivers/acpi/acpica/nsrepair.c                     |   2 +-
 drivers/acpi/acpica/nsrepair2.c                    |   4 +-
 drivers/acpi/acpica/nsutils.c                      |   2 +-
 drivers/acpi/acpica/nswalk.c                       |   2 +-
 drivers/acpi/acpica/nsxfname.c                     |   2 +-
 drivers/acpi/acpica/psargs.c                       |   2 +-
 drivers/acpi/acpica/psloop.c                       |   2 +-
 drivers/acpi/acpica/psobject.c                     |   2 +-
 drivers/acpi/acpica/psopcode.c                     |   2 +-
 drivers/acpi/acpica/psopinfo.c                     |   2 +-
 drivers/acpi/acpica/psparse.c                      |   2 +-
 drivers/acpi/acpica/psscope.c                      |   2 +-
 drivers/acpi/acpica/pstree.c                       |   2 +-
 drivers/acpi/acpica/psutils.c                      |   2 +-
 drivers/acpi/acpica/pswalk.c                       |   2 +-
 drivers/acpi/acpica/psxface.c                      |   2 +-
 drivers/acpi/acpica/rsaddr.c                       |  11 +-
 drivers/acpi/acpica/rscalc.c                       |  51 ++++-
 drivers/acpi/acpica/rsdumpinfo.c                   |  17 ++
 drivers/acpi/acpica/rsinfo.c                       |   5 +
 drivers/acpi/acpica/rslist.c                       |  12 +-
 drivers/acpi/acpica/rsmisc.c                       |  10 +-
 drivers/acpi/acpica/rsserial.c                     |  49 +++++
 drivers/acpi/acpica/tbdata.c                       |   2 +-
 drivers/acpi/acpica/tbfadt.c                       |   2 +-
 drivers/acpi/acpica/tbfind.c                       |   2 +-
 drivers/acpi/acpica/tbinstal.c                     |   2 +-
 drivers/acpi/acpica/tbprint.c                      |   2 +-
 drivers/acpi/acpica/tbutils.c                      |   7 +-
 drivers/acpi/acpica/tbxface.c                      |   2 +-
 drivers/acpi/acpica/tbxfload.c                     |   2 +-
 drivers/acpi/acpica/tbxfroot.c                     |   2 +-
 drivers/acpi/acpica/utaddress.c                    |   2 +-
 drivers/acpi/acpica/utalloc.c                      |   2 +-
 drivers/acpi/acpica/utascii.c                      |   2 +-
 drivers/acpi/acpica/utbuffer.c                     |   2 +-
 drivers/acpi/acpica/utcache.c                      |   2 +-
 drivers/acpi/acpica/utcksum.c                      |   2 +-
 drivers/acpi/acpica/utcopy.c                       |   2 +-
 drivers/acpi/acpica/utdebug.c                      |   2 +-
 drivers/acpi/acpica/utdecode.c                     |   2 +-
 drivers/acpi/acpica/uteval.c                       |   2 +-
 drivers/acpi/acpica/utglobal.c                     |   2 +-
 drivers/acpi/acpica/uthex.c                        |   2 +-
 drivers/acpi/acpica/utids.c                        |   2 +-
 drivers/acpi/acpica/utinit.c                       |   2 +-
 drivers/acpi/acpica/utlock.c                       |   2 +-
 drivers/acpi/acpica/utobject.c                     |   2 +-
 drivers/acpi/acpica/utosi.c                        |   2 +-
 drivers/acpi/acpica/utpredef.c                     |   2 +-
 drivers/acpi/acpica/utprint.c                      |   2 +-
 drivers/acpi/acpica/utresdecode.c                  |  11 ++
 drivers/acpi/acpica/utresrc.c                      |  17 +-
 drivers/acpi/acpica/uttrack.c                      |   2 +-
 drivers/acpi/acpica/utuuid.c                       |   2 +-
 drivers/acpi/acpica/utxface.c                      |   2 +-
 drivers/acpi/acpica/utxfinit.c                     |   2 +-
 drivers/acpi/apei/einj.c                           |  14 +-
 drivers/acpi/bus.c                                 |   4 +-
 drivers/acpi/ec.c                                  |  18 +-
 drivers/acpi/nfit/core.c                           |   6 +-
 drivers/acpi/processor_pdc.c                       |  11 ++
 drivers/acpi/property.c                            |  80 ++++----
 drivers/acpi/sbs.c                                 |  27 ++-
 drivers/acpi/sleep.c                               |   8 +-
 drivers/acpi/spcr.c                                |  13 +-
 drivers/acpi/sysfs.c                               |  17 ++
 drivers/acpi/thermal.c                             |   7 +-
 drivers/acpi/video_detect.c                        |  35 ----
 drivers/acpi/viot.c                                |   5 +-
 drivers/ata/pata_ixp4xx_cf.c                       |   1 +
 drivers/ata/pata_macio.c                           |   1 +
 drivers/char/tpm/tpm_atmel.h                       |   2 +-
 drivers/cpufreq/acpi-cpufreq.c                     |  39 ++--
 drivers/cpufreq/pcc-cpufreq.c                      |  34 +++-
 drivers/fpga/lattice-sysconfig-spi.c               |   1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   4 -
 drivers/iio/adc/ad7292.c                           |   1 +
 drivers/staging/iio/resolver/ad2s1210.c            |   1 +
 drivers/tty/serial/8250/8250_tegra.c               |   1 +
 drivers/virtio/virtio_mmio.c                       |   1 +
 drivers/xen/pcpu.c                                 |  20 ++
 include/acpi/acbuffer.h                            |   2 +-
 include/acpi/acconfig.h                            |   2 +-
 include/acpi/acexcep.h                             |   2 +-
 include/acpi/acnames.h                             |   2 +-
 include/acpi/acoutput.h                            |   2 +-
 include/acpi/acpi.h                                |   2 +-
 include/acpi/acpi_bus.h                            |   3 +-
 include/acpi/acpiosxf.h                            |   2 +-
 include/acpi/acpixf.h                              |   4 +-
 include/acpi/acrestyp.h                            |  39 +++-
 include/acpi/actbl.h                               |   2 +-
 include/acpi/actbl1.h                              |  59 +++++-
 include/acpi/actbl2.h                              | 211 +++++++++++++++++++--
 include/acpi/actbl3.h                              |   2 +-
 include/acpi/actypes.h                             |   8 +-
 include/acpi/acuuid.h                              |   2 +-
 include/acpi/platform/acenv.h                      |   4 +-
 include/acpi/platform/acenvex.h                    |   2 +-
 include/acpi/platform/acgcc.h                      |  13 +-
 include/acpi/platform/acgccex.h                    |   2 +-
 include/acpi/platform/aclinux.h                    |   7 +-
 include/acpi/platform/aclinuxex.h                  |   2 +-
 include/acpi/platform/aczephyr.h                   |  48 +++++
 include/acpi/video.h                               |   2 -
 include/linux/acpi.h                               |   6 +-
 include/xen/xen.h                                  |  11 ++
 net/rfkill/rfkill-gpio.c                           |   1 +
 tools/power/acpi/common/cmfsize.c                  |   2 +-
 tools/power/acpi/common/getopt.c                   |   2 +-
 .../acpi/os_specific/service_layers/oslinuxtbl.c   |   2 +-
 .../acpi/os_specific/service_layers/osunixdir.c    |   2 +-
 .../acpi/os_specific/service_layers/osunixmap.c    |   2 +-
 .../acpi/os_specific/service_layers/osunixxf.c     |   2 +-
 tools/power/acpi/tools/acpidump/acpidump.h         |   2 +-
 tools/power/acpi/tools/acpidump/apdump.c           |   2 +-
 tools/power/acpi/tools/acpidump/apfiles.c          |   2 +-
 tools/power/acpi/tools/acpidump/apmain.c           |   2 +-
 tools/testing/nvdimm/test/nfit.c                   |   4 +-
 221 files changed, 1014 insertions(+), 439 deletions(-)
