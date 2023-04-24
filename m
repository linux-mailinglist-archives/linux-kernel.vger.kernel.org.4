Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97ED36ED0EF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjDXPHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjDXPHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:07:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEB765B6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682348774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2imGvM9qZTlGkvCqIy+GXoy6doaZqZLtaAvRD5vK2Ic=;
        b=VL4ZSZu+4SnxYRNPkZe+CI++Vq+rENc/+JF8waXrfyFYSgJm8cUTP8x6Meg15DImh0boWD
        GYQFscgyNZuz0fRLpcKP/rpli0AGTroWQr2HelZOG3VvsCuusYa8KvK799ZHqZpol8Djfo
        hGafzVY+cG0lp2TRwjTRkAQdXmTgUUI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-tMT5wEiZONSXiMbi6q0r1w-1; Mon, 24 Apr 2023 11:06:13 -0400
X-MC-Unique: tMT5wEiZONSXiMbi6q0r1w-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5067d65c251so4210329a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682348771; x=1684940771;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2imGvM9qZTlGkvCqIy+GXoy6doaZqZLtaAvRD5vK2Ic=;
        b=NCKYLKGc9gRl6W6DCbgxG52OWBkNTt310y6g9VGYs3bjT/9wRa6b42bH5JZn8kCYgX
         U/a3g7y7f3AnKrPDsGh+0ozcX7skbKajOSGC1VWypSBjbPiX11QnRyLXcUObE7N7xzyS
         jfZrLlqZ318CW0RmD1TFUHIn1HupJ15Rj6qwuWHwCnpJHg1W+FV8QCEoTI/IdvI39nrM
         fhtHI6SCUIsa+0vPlFjoQSslK9gbT14pcPOyDZPvrUakwwkVR3Gz4RqZmvyvJdHeYb/6
         oMHvhkk2w7fYcn2lRMsX6E1o5Omivn/BbHHqYc23YtrIQlFLfwJb389KsPGDg6y/qgyv
         BoVg==
X-Gm-Message-State: AAQBX9fKup4w6A/F/nv3Khm/U6WcoTk/TeiG/cGM/Em34BWCTllc9Xd+
        Kx2psTU7Gn19KEfvDrLjkU6Q2gOflFqbDEhFnnCW5dcQH1U4IIt4OWmHiJUHGYPaAKnBzp9njzm
        2Blc78BeETxmCWOMD7fNWTT0b0MQmp3XL
X-Received: by 2002:a17:906:7809:b0:94f:1a23:2f1d with SMTP id u9-20020a170906780900b0094f1a232f1dmr12191585ejm.64.1682348771037;
        Mon, 24 Apr 2023 08:06:11 -0700 (PDT)
X-Google-Smtp-Source: AKy350aNXt3BRHRY9E4Tz6UwCa18JuyirEqsMmeQxQUtJ49HpzJbWYk7ZfS4k4MMkqcnleebcbaUmg==
X-Received: by 2002:a17:906:7809:b0:94f:1a23:2f1d with SMTP id u9-20020a170906780900b0094f1a232f1dmr12191540ejm.64.1682348770601;
        Mon, 24 Apr 2023 08:06:10 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id s17-20020a170906285100b0094e597f0e4dsm5554890ejc.121.2023.04.24.08.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 08:06:10 -0700 (PDT)
Message-ID: <81fbca39-bbd9-102f-247a-22c1998dd51f@redhat.com>
Date:   Mon, 24 Apr 2023 17:06:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.4-1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the main PDx86 PR for 6.4.

Highlights:
 -  AMD PMC and PMF drivers:
    - Numerous bugfixes
 -  Intel Speed Select Technology (ISST):
    - TPMI (Topology Aware Register and PM Capsule Interface) support
      for ISST support on upcoming processor models
    - Various other improvements / new hw support
    - tools/intel-speed-select: TPMI support + other improvements
 -  Intel In Field Scan (IFS):
    - Add Array Bist test support
 -  New drivers:
    - intel_bytcrc_pwrsrc Crystal Cove PMIC pwrsrc / reset-reason driver
    - lenovo-ymc Yoga Mode Control driver for reporting SW_TABLET_MODE
    - msi-ec Driver for MSI laptop EC features like battery charging limits
 -  apple-gmux:
    - Support for new MMIO based models (T2 Macs)
    - Honor acpi_backlight= auto-detect-code + kernel cmdline option
      to switch between gmux and apple_bl backlight drivers and remove
      own custom handling for this
 -  x86-android-tablets: Refactor / cleanup + new hw support
 -  Miscellaneous other cleanups / fixes

Regards,

Hans


The following changes since commit 1a0009abfa7893b9cfcd3884658af1cbee6b26ce:

  platform: mellanox: mlx-platform: Initialize shift variable to 0 (2023-03-07 12:08:30 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.4-1

for you to fetch changes up to e578c943e363ff47d08e7b4f5648f3da9db325d8:

  platform/x86: x86-android-tablets: Add accelerometer support for Yoga Tablet 2 1050/830 series (2023-04-17 12:23:26 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.4-1

Highlights:
 -  AMD PMC and PMF drivers:
    - Numerous bugfixes
 -  Intel Speed Select Technology (ISST):
    - TPMI (Topology Aware Register and PM Capsule Interface) support
      for ISST support on upcoming processor models
    - Various other improvements / new hw support
    - tools/intel-speed-select: TPMI support + other improvements
 -  Intel In Field Scan (IFS):
    - Add Array Bist test support
 -  New drivers:
    - intel_bytcrc_pwrsrc Crystal Cove PMIC pwrsrc / reset-reason driver
    - lenovo-ymc Yoga Mode Control driver for reporting SW_TABLET_MODE
    - msi-ec Driver for MSI laptop EC features like battery charging limits
 -  apple-gmux:
    - Support for new MMIO based models (T2 Macs)
    - Honor acpi_backlight= auto-detect-code + kernel cmdline option
      to switch between gmux and apple_bl backlight drivers and remove
      own custom handling for this
 -  x86-android-tablets: Refactor / cleanup + new hw support
 -  Miscellaneous other cleanups / fixes

The following is an automated git shortlog grouped by driver:

Add driver for Yoga Tablet Mode switch:
 - Add driver for Yoga Tablet Mode switch

Add intel_bytcrc_pwrsrc driver:
 - Add intel_bytcrc_pwrsrc driver

Add new msi-ec driver:
 - Add new msi-ec driver

Documentation/ABI:
 -  Update IFS ABI doc

ISST:
 -  unlock on error path in tpmi_sst_init()
 -  Add suspend/resume callbacks
 -  Add SST-TF support via TPMI
 -  Add SST-BF support via TPMI
 -  Add SST-PP support via TPMI
 -  Add SST-CP support via TPMI
 -  Parse SST MMIO and update instance
 -  Enumerate TPMI SST and create framework
 -  Add support for MSR 0x54
 -  Add API version of the target
 -  Add IOCTL default callback
 -  Add TPMI target

Merge remote-tracking branch 'intel-speed-select/intel-sst' into review-hans:
 - Merge remote-tracking branch 'intel-speed-select/intel-sst' into review-hans

Merge tag 'ib-pdx86-backlight-6.4' into review-hans:
 - Merge tag 'ib-pdx86-backlight-6.4' into review-hans

Move ideapad ACPI helpers to a new header:
 - Move ideapad ACPI helpers to a new header

acer-wmi:
 -  Convert to platform remove callback returning void

acerhdf:
 -  Remove unneeded semicolon

adv_swbutton:
 -  Convert to platform remove callback returning void

amilo-rfkill:
 -  Convert to platform remove callback returning void

apple-gmux:
 -  Fix iomem_base __iomem annotation
 -  return -EFAULT if copy fails
 -  Update apple_gmux_detect documentation
 -  Add acpi_video_get_backlight_type() check
 -  add debugfs interface
 -  support MMIO gmux on T2 Macs
 -  refactor gmux types
 -  use first bit to check switch state

backlight:
 -  apple_bl: Use acpi_video_get_backlight_type()

barco-p50-gpio:
 -  Convert to platform remove callback returning void

classmate:
 -  mark SPI related data as maybe unused

compal-laptop:
 -  Convert to platform remove callback returning void

dell:
 -  dell-smo8800: Convert to platform remove callback returning void
 -  dcdbas: Convert to platform remove callback returning void

dell-laptop:
 -  Register ctl-led for speaker-mute

hp:
 -  tc1100-wmi: Convert to platform remove callback returning void
 -  hp_accel: Convert to platform remove callback returning void

huawei-wmi:
 -  Convert to platform remove callback returning void

ideapad-laptop:
 -  Convert to platform remove callback returning void

intel:
 -  vbtn: Convert to platform remove callback returning void
 -  telemetry: pltdrv: Convert to platform remove callback returning void
 -  pmc: core: Convert to platform remove callback returning void
 -  mrfld_pwrbtn: Convert to platform remove callback returning void
 -  int3472: discrete: Convert to platform remove callback returning void
 -  int1092: intel_sar: Convert to platform remove callback returning void
 -  int0002_vgpio: Convert to platform remove callback returning void
 -  hid: Convert to platform remove callback returning void
 -  chtwc_int33fe: Convert to platform remove callback returning void
 -  chtdc_ti_pwrbtn: Convert to platform remove callback returning void
 -  bxtwc_tmu: Convert to platform remove callback returning void

intel-uncore-freq:
 -  Add client processors

mlxbf-bootctl:
 -  Add sysfs file for BlueField boot fifo

pcengines-apuv2:
 -  Drop platform:pcengines-apuv2 module-alias

platform/mellanox:
 -  add firmware reset support

platform/olpc:
 -  olpc-xo175-ec: Use SPI device ID data to bind device

platform/surface:
 -  aggregator_registry: Add support for tablet-mode switch on Surface Pro 9
 -  aggregator_tabletsw: Add support for Type-Cover posture source
 -  aggregator_tabletsw: Properly handle different posture source IDs

platform/x86/amd:
 -  pmc: provide user message where s0ix is not supported
 -  pmc: Remove __maybe_unused from amd_pmc_suspend_handler()
 -  pmc: Convert to platform remove callback returning void
 -  pmc: Fix memory leak in amd_pmc_stb_debugfs_open_v2()
 -  pmc: Move out of BIOS SMN pair for STB init
 -  pmc: Utilize SMN index 0 for driver probe
 -  pmc: Move idlemask check into `amd_pmc_idlemask_read`
 -  pmc: Don't dump data after resume from s0i3 on picasso
 -  pmc: Hide SMU version and program attributes for Picasso
 -  pmc: Don't try to read SMU version on Picasso
 -  pmf: core: Convert to platform remove callback returning void
 -  hsmp: Convert to platform remove callback returning void

platform/x86/amd/pmf:
 -  Move out of BIOS SMN pair for driver probe

platform/x86/intel:
 -  vsec: Use intel_vsec_dev_release() to simplify init() error cleanup
 -  vsec: Explicitly enable capabilities

platform/x86/intel/ifs:
 -  Update IFS doc
 -  Implement Array BIST test
 -  Sysfs interface for Array BIST
 -  Introduce Array Scan test to IFS
 -  IFS cleanup
 -  Reorganize driver data
 -  Separate ifs_pkg_auth from ifs_data

platform/x86/intel/pmc/mtl:
 -  Put GNA/IPU/VPU devices in D3

platform/x86/intel/pmt:
 -  Ignore uninitialized entries
 -  Add INTEL_PMT module namespace

platform/x86/intel/sdsi:
 -  Change mailbox timeout

samsung-q10:
 -  Convert to platform remove callback returning void

serial-multi-instantiate:
 -  Convert to platform remove callback returning void

sony:
 -  mark SPI related data as maybe unused

think-lmi:
 -  Remove unnecessary casts for attributes
 -  Remove custom kobject sysfs_ops
 -  Properly interpret return value of tlmi_setting

thinkpad_acpi:
 -  Fix Embedded Controller access on X380 Yoga

tools/power/x86/intel-speed-select:
 -  Update version
 -  Change TRL display for Emerald Rapids
 -  Identify Emerald Rapids
 -  Display AMX base frequency
 -  Use cgroup v2 isolation
 -  Add missing free cpuset
 -  Fix clos-max display with TPMI I/F
 -  Add cpu id check
 -  Avoid setting duplicate tdp level
 -  Remove cpu mask display for non-cpu power domain
 -  Hide invalid TRL level
 -  Display fact info for non-cpu power domain
 -  Show level 0 name for new api_version
 -  Prevent cpu clos config for non-cpu power domain
 -  Allow display non-cpu power domain info
 -  Display amx_p1 and cooling_type
 -  Display punit info
 -  Introduce TPMI interface support
 -  Get punit core mapping information
 -  Introduce api_version helper
 -  Support large clos_min/max
 -  Introduce is_debug_enabled()
 -  Allow api_version based platform callbacks
 -  Move send_mbox_cmd to isst-core-mbox.c
 -  Abstract adjust_uncore_freq
 -  Abstract read_pm_config
 -  Abstract clos_associate
 -  Abstract clos_get_assoc_status
 -  Abstract set_clos
 -  Abstract pm_get_clos
 -  Abstract pm_qos_config
 -  Abstract get_clos_information
 -  Abstract get_get_trls
 -  Enhance get_tdp_info
 -  Abstract get_uncore_p0_p1_info
 -  Abstract get_fact_info
 -  Abstract set_pbf_fact_status
 -  Remove isst_get_pbf_info_complete
 -  Abstract get_pbf_info
 -  Abstract set_tdp_level
 -  Abstract get_trl_bucket_info
 -  Abstract get_get_trl
 -  Abstract get_coremask_info
 -  Abstract get_tjmax_info
 -  Move code right before its caller
 -  Abstract get_pwr_info
 -  Abstract get_tdp_info
 -  Abstract get_ctdp_control
 -  Abstract get_config_levels
 -  Abstract is_punit_valid
 -  Introduce isst-core-mbox.c
 -  Always invoke isst_fill_platform_info
 -  Introduce isst_get_disp_freq_multiplier
 -  Move mbox functions to isst-core.c
 -  Improve isst_print_extended_platform_info
 -  Rename for_each_online_package_in_set
 -  Introduce support for multi-punit
 -  Introduce isst_is_punit_valid()
 -  Introduce punit to isst_id
 -  Follow TRL nameing for FACT info
 -  Unify TRL levels

wmi:
 -  Convert to platform remove callback returning void

x86-android-tablets:
 -  Add accelerometer support for Yoga Tablet 2 1050/830 series
 -  Add "yogabook-touch-kbd-digitizer-switch" pdev for Lenovo Yoga Book
 -  Add Wacom digitizer info for Lenovo Yoga Book
 -  Update Yoga Book HiDeep touchscreen comment
 -  Add Lenovo Yoga Book X90F/L data
 -  Share lp855x_platform_data between different models
 -  Use LP8557 in direct mode on both the Yoga 830 and the 1050
 -  Add depends on PMIC_OPREGION
 -  Lenovo Yoga Book match is for YB1-X91 models only
 -  Add LID switch support for Yoga Tablet 2 1050/830 series
 -  Add backlight ctrl for Lenovo Yoga Tab 3 Pro YT3-X90F
 -  Add touchscreen support for Lenovo Yoga Tab 3 Pro YT3-X90F
 -  Add support for the Dolby button on Peaq C1010
 -  Add gpio_keys support to x86_android_tablet_init()
 -  Move remaining tablets to other.c
 -  Move Lenovo tablets to their own file
 -  Move Asus tablets to their own file
 -  Move shared power-supply fw-nodes to a separate file
 -  Move DMI match table into its own dmi.c file
 -  Move core code into new core.c file
 -  Move into its own subdir
 -  Add Acer Iconia One 7 B1-750 data

x86/include/asm/msr-index.h:
 -  Add IFS Array test bits

xo1-rfkill:
 -  Convert to platform remove callback returning void

----------------------------------------------------------------
Andrew Kallmeyer (1):
      platform/x86: Move ideapad ACPI helpers to a new header

Dan Carpenter (2):
      platform/x86: apple-gmux: return -EFAULT if copy fails
      platform/x86: ISST: unlock on error path in tpmi_sst_init()

Daniel Bertalan (1):
      platform/x86: thinkpad_acpi: Fix Embedded Controller access on X380 Yoga

David E. Box (5):
      platform/x86/intel: vsec: Explicitly enable capabilities
      platform/x86/intel/pmt: Add INTEL_PMT module namespace
      platform/x86/intel/pmc/mtl: Put GNA/IPU/VPU devices in D3
      platform/x86/intel/pmt: Ignore uninitialized entries
      platform/x86/intel/sdsi: Change mailbox timeout

Feng Jiang (1):
      platform/x86/amd: pmc: Fix memory leak in amd_pmc_stb_debugfs_open_v2()

Gergo Koteles (1):
      platform/x86: Add driver for Yoga Tablet Mode switch

Hans de Goede (31):
      platform/x86: x86-android-tablets: Add Acer Iconia One 7 B1-750 data
      platform/x86: x86-android-tablets: Move into its own subdir
      platform/x86: x86-android-tablets: Move core code into new core.c file
      platform/x86: x86-android-tablets: Move DMI match table into its own dmi.c file
      platform/x86: x86-android-tablets: Move shared power-supply fw-nodes to a separate file
      platform/x86: x86-android-tablets: Move Asus tablets to their own file
      platform/x86: x86-android-tablets: Move Lenovo tablets to their own file
      platform/x86: x86-android-tablets: Move remaining tablets to other.c
      platform/x86: x86-android-tablets: Add gpio_keys support to x86_android_tablet_init()
      platform/x86: x86-android-tablets: Add support for the Dolby button on Peaq C1010
      platform/x86: x86-android-tablets: Add touchscreen support for Lenovo Yoga Tab 3 Pro YT3-X90F
      platform/x86: x86-android-tablets: Add backlight ctrl for Lenovo Yoga Tab 3 Pro YT3-X90F
      platform/x86: x86-android-tablets: Add LID switch support for Yoga Tablet 2 1050/830 series
      platform/x86: x86-android-tablets: Lenovo Yoga Book match is for YB1-X91 models only
      platform/x86: apple-gmux: Add acpi_video_get_backlight_type() check
      backlight: apple_bl: Use acpi_video_get_backlight_type()
      platform/x86: x86-android-tablets: Add depends on PMIC_OPREGION
      Merge tag 'ib-pdx86-backlight-6.4' into review-hans
      platform/x86: Add intel_bytcrc_pwrsrc driver
      platform/x86: pcengines-apuv2: Drop platform:pcengines-apuv2 module-alias
      platform/x86/intel: vsec: Use intel_vsec_dev_release() to simplify init() error cleanup
      Merge remote-tracking branch 'intel-speed-select/intel-sst' into review-hans
      platform/x86: x86-android-tablets: Use LP8557 in direct mode on both the Yoga 830 and the 1050
      platform/x86: x86-android-tablets: Share lp855x_platform_data between different models
      platform/x86: x86-android-tablets: Add Lenovo Yoga Book X90F/L data
      platform/x86: apple-gmux: Fix iomem_base __iomem annotation
      platform/x86: amd: pmc: Remove __maybe_unused from amd_pmc_suspend_handler()
      platform/x86: x86-android-tablets: Update Yoga Book HiDeep touchscreen comment
      platform/x86: x86-android-tablets: Add Wacom digitizer info for Lenovo Yoga Book
      platform/x86: x86-android-tablets: Add "yogabook-touch-kbd-digitizer-switch" pdev for Lenovo Yoga Book
      platform/x86: x86-android-tablets: Add accelerometer support for Yoga Tablet 2 1050/830 series

Jiapeng Chong (1):
      platform/x86: acerhdf: Remove unneeded semicolon

Jithu Joseph (9):
      platform/x86/intel/ifs: Separate ifs_pkg_auth from ifs_data
      platform/x86/intel/ifs: Reorganize driver data
      platform/x86/intel/ifs: IFS cleanup
      x86/include/asm/msr-index.h: Add IFS Array test bits
      platform/x86/intel/ifs: Introduce Array Scan test to IFS
      platform/x86/intel/ifs: Sysfs interface for Array BIST
      platform/x86/intel/ifs: Implement Array BIST test
      platform/x86/intel/ifs: Update IFS doc
      Documentation/ABI: Update IFS ABI doc

Khalil Blaiech (1):
      platform/mellanox: add firmware reset support

Koba Ko (1):
      platform/x86: dell-laptop: Register ctl-led for speaker-mute

Krzysztof Kozlowski (3):
      platform/x86: classmate: mark SPI related data as maybe unused
      platform/x86: sony: mark SPI related data as maybe unused
      platform/olpc: olpc-xo175-ec: Use SPI device ID data to bind device

Liming Sun (1):
      mlxbf-bootctl: Add sysfs file for BlueField boot fifo

Mario Limonciello (4):
      platform/x86/amd: pmc: Don't try to read SMU version on Picasso
      platform/x86/amd: pmc: Hide SMU version and program attributes for Picasso
      platform/x86/amd: pmc: Don't dump data after resume from s0i3 on picasso
      platform/x86/amd: pmc: Move idlemask check into `amd_pmc_idlemask_read`

Maximilian Luz (3):
      platform/surface: aggregator_tabletsw: Properly handle different posture source IDs
      platform/surface: aggregator_tabletsw: Add support for Type-Cover posture source
      platform/surface: aggregator_registry: Add support for tablet-mode switch on Surface Pro 9

Nikita Kravets (1):
      platform/x86: Add new msi-ec driver

Orlando Chamberlain (5):
      platform/x86: apple-gmux: use first bit to check switch state
      platform/x86: apple-gmux: refactor gmux types
      platform/x86: apple-gmux: support MMIO gmux on T2 Macs
      platform/x86: apple-gmux: add debugfs interface
      platform/x86: apple-gmux: Update apple_gmux_detect documentation

Shyam Sundar S K (4):
      platform/x86/amd/pmf: Move out of BIOS SMN pair for driver probe
      platform/x86/amd: pmc: Utilize SMN index 0 for driver probe
      platform/x86/amd: pmc: Move out of BIOS SMN pair for STB init
      platform/x86: amd: pmc: provide user message where s0ix is not supported

Srinivas Pandruvada (18):
      platform/x86: ISST: Add TPMI target
      platform/x86: ISST: Add IOCTL default callback
      platform/x86: ISST: Add API version of the target
      platform/x86: ISST: Add support for MSR 0x54
      platform/x86: ISST: Enumerate TPMI SST and create framework
      platform/x86: ISST: Parse SST MMIO and update instance
      platform/x86: ISST: Add SST-CP support via TPMI
      platform/x86: ISST: Add SST-PP support via TPMI
      platform/x86: ISST: Add SST-BF support via TPMI
      platform/x86: ISST: Add SST-TF support via TPMI
      platform/x86: ISST: Add suspend/resume callbacks
      tools/power/x86/intel-speed-select: Get punit core mapping information
      tools/power/x86/intel-speed-select: Add missing free cpuset
      tools/power/x86/intel-speed-select: Use cgroup v2 isolation
      tools/power/x86/intel-speed-select: Display AMX base frequency
      tools/power/x86/intel-speed-select: Identify Emerald Rapids
      tools/power/x86/intel-speed-select: Change TRL display for Emerald Rapids
      platform/x86: intel-uncore-freq: Add client processors

Thomas Weißschuh (3):
      platform/x86: think-lmi: Properly interpret return value of tlmi_setting
      platform/x86: think-lmi: Remove custom kobject sysfs_ops
      platform/x86: think-lmi: Remove unnecessary casts for attributes

Uwe Kleine-König (29):
      platform/x86: acer-wmi: Convert to platform remove callback returning void
      platform/x86: adv_swbutton: Convert to platform remove callback returning void
      platform/x86: amd: hsmp: Convert to platform remove callback returning void
      platform/x86: amd: pmc: Convert to platform remove callback returning void
      platform/x86: amd: pmf: core: Convert to platform remove callback returning void
      platform/x86: amilo-rfkill: Convert to platform remove callback returning void
      platform/x86: barco-p50-gpio: Convert to platform remove callback returning void
      platform/x86: compal-laptop: Convert to platform remove callback returning void
      platform/x86: dell: dcdbas: Convert to platform remove callback returning void
      platform/x86: dell: dell-smo8800: Convert to platform remove callback returning void
      platform/x86: hp: hp_accel: Convert to platform remove callback returning void
      platform/x86: hp: tc1100-wmi: Convert to platform remove callback returning void
      platform/x86: huawei-wmi: Convert to platform remove callback returning void
      platform/x86: ideapad-laptop: Convert to platform remove callback returning void
      platform/x86: intel: bxtwc_tmu: Convert to platform remove callback returning void
      platform/x86: intel: chtdc_ti_pwrbtn: Convert to platform remove callback returning void
      platform/x86: intel: chtwc_int33fe: Convert to platform remove callback returning void
      platform/x86: intel: hid: Convert to platform remove callback returning void
      platform/x86: intel: int0002_vgpio: Convert to platform remove callback returning void
      platform/x86: intel: int1092: intel_sar: Convert to platform remove callback returning void
      platform/x86: intel: int3472: discrete: Convert to platform remove callback returning void
      platform/x86: intel: mrfld_pwrbtn: Convert to platform remove callback returning void
      platform/x86: intel: pmc: core: Convert to platform remove callback returning void
      platform/x86: intel: telemetry: pltdrv: Convert to platform remove callback returning void
      platform/x86: intel: vbtn: Convert to platform remove callback returning void
      platform/x86: samsung-q10: Convert to platform remove callback returning void
      platform/x86: serial-multi-instantiate: Convert to platform remove callback returning void
      platform/x86: wmi: Convert to platform remove callback returning void
      platform/x86: xo1-rfkill: Convert to platform remove callback returning void

Zhang Rui (55):
      tools/power/x86/intel-speed-select: Unify TRL levels
      tools/power/x86/intel-speed-select: Follow TRL nameing for FACT info
      tools/power/x86/intel-speed-select: Introduce punit to isst_id
      tools/power/x86/intel-speed-select: Introduce isst_is_punit_valid()
      tools/power/x86/intel-speed-select: Introduce support for multi-punit
      tools/power/x86/intel-speed-select: Rename for_each_online_package_in_set
      tools/power/x86/intel-speed-select: Improve isst_print_extended_platform_info
      tools/power/x86/intel-speed-select: Move mbox functions to isst-core.c
      tools/power/x86/intel-speed-select: Introduce isst_get_disp_freq_multiplier
      tools/power/x86/intel-speed-select: Always invoke isst_fill_platform_info
      tools/power/x86/intel-speed-select: Introduce isst-core-mbox.c
      tools/power/x86/intel-speed-select: Abstract is_punit_valid
      tools/power/x86/intel-speed-select: Abstract get_config_levels
      tools/power/x86/intel-speed-select: Abstract get_ctdp_control
      tools/power/x86/intel-speed-select: Abstract get_tdp_info
      tools/power/x86/intel-speed-select: Abstract get_pwr_info
      tools/power/x86/intel-speed-select: Move code right before its caller
      tools/power/x86/intel-speed-select: Abstract get_tjmax_info
      tools/power/x86/intel-speed-select: Abstract get_coremask_info
      tools/power/x86/intel-speed-select: Abstract get_get_trl
      tools/power/x86/intel-speed-select: Abstract get_trl_bucket_info
      tools/power/x86/intel-speed-select: Abstract set_tdp_level
      tools/power/x86/intel-speed-select: Abstract get_pbf_info
      tools/power/x86/intel-speed-select: Remove isst_get_pbf_info_complete
      tools/power/x86/intel-speed-select: Abstract set_pbf_fact_status
      tools/power/x86/intel-speed-select: Abstract get_fact_info
      tools/power/x86/intel-speed-select: Abstract get_uncore_p0_p1_info
      tools/power/x86/intel-speed-select: Enhance get_tdp_info
      tools/power/x86/intel-speed-select: Abstract get_get_trls
      tools/power/x86/intel-speed-select: Abstract get_clos_information
      tools/power/x86/intel-speed-select: Abstract pm_qos_config
      tools/power/x86/intel-speed-select: Abstract pm_get_clos
      tools/power/x86/intel-speed-select: Abstract set_clos
      tools/power/x86/intel-speed-select: Abstract clos_get_assoc_status
      tools/power/x86/intel-speed-select: Abstract clos_associate
      tools/power/x86/intel-speed-select: Abstract read_pm_config
      tools/power/x86/intel-speed-select: Abstract adjust_uncore_freq
      tools/power/x86/intel-speed-select: Move send_mbox_cmd to isst-core-mbox.c
      tools/power/x86/intel-speed-select: Allow api_version based platform callbacks
      tools/power/x86/intel-speed-select: Introduce is_debug_enabled()
      tools/power/x86/intel-speed-select: Support large clos_min/max
      tools/power/x86/intel-speed-select: Introduce api_version helper
      tools/power/x86/intel-speed-select: Introduce TPMI interface support
      tools/power/x86/intel-speed-select: Display punit info
      tools/power/x86/intel-speed-select: Display amx_p1 and cooling_type
      tools/power/x86/intel-speed-select: Allow display non-cpu power domain info
      tools/power/x86/intel-speed-select: Prevent cpu clos config for non-cpu power domain
      tools/power/x86/intel-speed-select: Show level 0 name for new api_version
      tools/power/x86/intel-speed-select: Display fact info for non-cpu power domain
      tools/power/x86/intel-speed-select: Hide invalid TRL level
      tools/power/x86/intel-speed-select: Remove cpu mask display for non-cpu power domain
      tools/power/x86/intel-speed-select: Avoid setting duplicate tdp level
      tools/power/x86/intel-speed-select: Add cpu id check
      tools/power/x86/intel-speed-select: Fix clos-max display with TPMI I/F
      tools/power/x86/intel-speed-select: Update version

 Documentation/ABI/testing/sysfs-platform-intel-ifs |   17 +-
 .../ABI/testing/sysfs-platform-mellanox-bootctl    |    7 +
 MAINTAINERS                                        |   15 +-
 arch/x86/include/asm/msr-index.h                   |    2 +
 drivers/platform/mellanox/mlxbf-bootctl.c          |   87 +
 drivers/platform/mellanox/mlxbf-bootctl.h          |    6 +
 drivers/platform/olpc/olpc-xo175-ec.c              |    1 +
 .../platform/surface/surface_aggregator_registry.c |    2 +-
 .../platform/surface/surface_aggregator_tabletsw.c |  180 +-
 drivers/platform/x86/Kconfig                       |   42 +-
 drivers/platform/x86/Makefile                      |    5 +-
 drivers/platform/x86/acer-wmi.c                    |    5 +-
 drivers/platform/x86/acerhdf.c                     |    2 +-
 drivers/platform/x86/adv_swbutton.c                |    6 +-
 drivers/platform/x86/amd/Kconfig                   |    2 +-
 drivers/platform/x86/amd/hsmp.c                    |    6 +-
 drivers/platform/x86/amd/pmc.c                     |  170 +-
 drivers/platform/x86/amd/pmf/Kconfig               |    1 +
 drivers/platform/x86/amd/pmf/core.c                |   27 +-
 drivers/platform/x86/amilo-rfkill.c                |    5 +-
 drivers/platform/x86/apple-gmux.c                  |  404 ++++-
 drivers/platform/x86/barco-p50-gpio.c              |    6 +-
 drivers/platform/x86/classmate-laptop.c            |    2 +-
 drivers/platform/x86/compal-laptop.c               |    8 +-
 drivers/platform/x86/dell/dcdbas.c                 |    6 +-
 drivers/platform/x86/dell/dell-laptop.c            |   42 +
 drivers/platform/x86/dell/dell-smbios.h            |    2 +
 drivers/platform/x86/dell/dell-smo8800.c           |    5 +-
 drivers/platform/x86/hp/hp_accel.c                 |    5 +-
 drivers/platform/x86/hp/tc1100-wmi.c               |    6 +-
 drivers/platform/x86/huawei-wmi.c                  |    6 +-
 drivers/platform/x86/ideapad-laptop.c              |  141 +-
 drivers/platform/x86/ideapad-laptop.h              |  152 ++
 drivers/platform/x86/intel/Kconfig                 |   10 +
 drivers/platform/x86/intel/Makefile                |    2 +
 drivers/platform/x86/intel/bxtwc_tmu.c             |    5 +-
 drivers/platform/x86/intel/bytcrc_pwrsrc.c         |  181 ++
 drivers/platform/x86/intel/chtdc_ti_pwrbtn.c       |    5 +-
 drivers/platform/x86/intel/chtwc_int33fe.c         |    6 +-
 drivers/platform/x86/intel/hid.c                   |   10 +-
 drivers/platform/x86/intel/ifs/core.c              |   81 +-
 drivers/platform/x86/intel/ifs/ifs.h               |   68 +-
 drivers/platform/x86/intel/ifs/load.c              |    9 +-
 drivers/platform/x86/intel/ifs/runtest.c           |   94 +-
 drivers/platform/x86/intel/ifs/sysfs.c             |   21 +-
 drivers/platform/x86/intel/int0002_vgpio.c         |    5 +-
 drivers/platform/x86/intel/int1092/intel_sar.c     |    5 +-
 drivers/platform/x86/intel/int3472/discrete.c      |    6 +-
 drivers/platform/x86/intel/mrfld_pwrbtn.c          |    5 +-
 drivers/platform/x86/intel/pmc/core.c              |    5 +-
 drivers/platform/x86/intel/pmc/mtl.c               |   31 +
 drivers/platform/x86/intel/pmt/class.c             |    6 +-
 drivers/platform/x86/intel/pmt/crashlog.c          |    1 +
 drivers/platform/x86/intel/pmt/telemetry.c         |    3 +-
 drivers/platform/x86/intel/sdsi.c                  |    2 +-
 drivers/platform/x86/intel/speed_select_if/Kconfig |    4 +
 .../platform/x86/intel/speed_select_if/Makefile    |    2 +
 .../x86/intel/speed_select_if/isst_if_common.c     |   47 +-
 .../x86/intel/speed_select_if/isst_if_common.h     |    8 +-
 .../platform/x86/intel/speed_select_if/isst_tpmi.c |   72 +
 .../x86/intel/speed_select_if/isst_tpmi_core.c     | 1440 ++++++++++++++++
 .../x86/intel/speed_select_if/isst_tpmi_core.h     |   18 +
 drivers/platform/x86/intel/telemetry/pltdrv.c      |    5 +-
 .../x86/intel/uncore-frequency/uncore-frequency.c  |    7 +
 drivers/platform/x86/intel/vbtn.c                  |   10 +-
 drivers/platform/x86/intel/vsec.c                  |   75 +-
 drivers/platform/x86/intel/vsec.h                  |    9 +-
 drivers/platform/x86/lenovo-ymc.c                  |  187 ++
 drivers/platform/x86/msi-ec.c                      |  897 ++++++++++
 drivers/platform/x86/msi-ec.h                      |  122 ++
 drivers/platform/x86/pcengines-apuv2.c             |    1 -
 drivers/platform/x86/peaq-wmi.c                    |  128 --
 drivers/platform/x86/samsung-q10.c                 |    6 +-
 drivers/platform/x86/serial-multi-instantiate.c    |    6 +-
 drivers/platform/x86/sony-laptop.c                 |    2 +-
 drivers/platform/x86/think-lmi.c                   |   49 +-
 drivers/platform/x86/thinkpad_acpi.c               |   16 +
 drivers/platform/x86/wmi.c                         |    6 +-
 drivers/platform/x86/x86-android-tablets.c         | 1803 --------------------
 drivers/platform/x86/x86-android-tablets/Kconfig   |   21 +
 drivers/platform/x86/x86-android-tablets/Makefile  |    9 +
 drivers/platform/x86/x86-android-tablets/asus.c    |  325 ++++
 drivers/platform/x86/x86-android-tablets/core.c    |  391 +++++
 drivers/platform/x86/x86-android-tablets/dmi.c     |  165 ++
 drivers/platform/x86/x86-android-tablets/lenovo.c  |  679 ++++++++
 drivers/platform/x86/x86-android-tablets/other.c   |  522 ++++++
 .../x86/x86-android-tablets/shared-psy-info.c      |  100 ++
 .../x86/x86-android-tablets/shared-psy-info.h      |   32 +
 .../x86/x86-android-tablets/x86-android-tablets.h  |  108 ++
 drivers/platform/x86/xo1-rfkill.c                  |    5 +-
 drivers/video/backlight/Kconfig                    |    1 +
 drivers/video/backlight/apple_bl.c                 |   31 +-
 include/linux/apple-gmux.h                         |   72 +-
 include/linux/apple_bl.h                           |   27 -
 include/uapi/linux/isst_if.h                       |  303 ++++
 tools/power/x86/intel-speed-select/Build           |    2 +-
 tools/power/x86/intel-speed-select/isst-config.c   |  769 +++++----
 .../power/x86/intel-speed-select/isst-core-mbox.c  | 1066 ++++++++++++
 .../power/x86/intel-speed-select/isst-core-tpmi.c  |  787 +++++++++
 tools/power/x86/intel-speed-select/isst-core.c     |  846 ++-------
 tools/power/x86/intel-speed-select/isst-daemon.c   |   38 +-
 tools/power/x86/intel-speed-select/isst-display.c  |  245 ++-
 tools/power/x86/intel-speed-select/isst.h          |   96 +-
 103 files changed, 9613 insertions(+), 3881 deletions(-)
 create mode 100644 drivers/platform/x86/ideapad-laptop.h
 create mode 100644 drivers/platform/x86/intel/bytcrc_pwrsrc.c
 create mode 100644 drivers/platform/x86/intel/speed_select_if/isst_tpmi.c
 create mode 100644 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
 create mode 100644 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.h
 create mode 100644 drivers/platform/x86/lenovo-ymc.c
 create mode 100644 drivers/platform/x86/msi-ec.c
 create mode 100644 drivers/platform/x86/msi-ec.h
 delete mode 100644 drivers/platform/x86/peaq-wmi.c
 delete mode 100644 drivers/platform/x86/x86-android-tablets.c
 create mode 100644 drivers/platform/x86/x86-android-tablets/Kconfig
 create mode 100644 drivers/platform/x86/x86-android-tablets/Makefile
 create mode 100644 drivers/platform/x86/x86-android-tablets/asus.c
 create mode 100644 drivers/platform/x86/x86-android-tablets/core.c
 create mode 100644 drivers/platform/x86/x86-android-tablets/dmi.c
 create mode 100644 drivers/platform/x86/x86-android-tablets/lenovo.c
 create mode 100644 drivers/platform/x86/x86-android-tablets/other.c
 create mode 100644 drivers/platform/x86/x86-android-tablets/shared-psy-info.c
 create mode 100644 drivers/platform/x86/x86-android-tablets/shared-psy-info.h
 create mode 100644 drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
 delete mode 100644 include/linux/apple_bl.h
 create mode 100644 tools/power/x86/intel-speed-select/isst-core-mbox.c
 create mode 100644 tools/power/x86/intel-speed-select/isst-core-tpmi.c

