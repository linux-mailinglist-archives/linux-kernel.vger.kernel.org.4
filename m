Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4189E5F54B9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 14:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiJEMq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 08:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJEMqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 08:46:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A82E6A480
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 05:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664974012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Xm9ouRYXR2/GZPVtgOLMH8O+6kApO0LTU3Riww4XY/A=;
        b=c7cJtAwSUcKFhkKmVfXSgsAWlp+nBoVY3zMaoT/B2N846CruhsqG88/sdxH1u7CLXQaNDN
        dTd2ZhW6bnfwPhEl8x8Q+XiZKt+HjltLSIKKPYJl29GNSa2bV4MlDjtDcHox8e0jBJds9P
        1pgWLBU/miS3+fNeMiZlmh69aYTrTwA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-468-WRqIOjkGPUikkfOwhUzEQw-1; Wed, 05 Oct 2022 08:46:51 -0400
X-MC-Unique: WRqIOjkGPUikkfOwhUzEQw-1
Received: by mail-ej1-f69.google.com with SMTP id he8-20020a1709073d8800b007838dd153f4so6415470ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 05:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=Xm9ouRYXR2/GZPVtgOLMH8O+6kApO0LTU3Riww4XY/A=;
        b=eZacGvu+6kW9c5tfVa0YLG+FHkZBKuWme9rA+umV1O1ZoTlPqJ8OpqpudXFWlYEWXO
         TJ8XqUQ+AdFpggOaFnmMoaS5zyQXy4Q49M6tqfhvpsQM2w4I8PeEYwmXzXOptoCz8Knb
         LoNBymzURZcI4b8fMYU772UK1MiGGE6Pgs8avd3vHRiS93yhuHrM/32trFukgeA72nhO
         fp21+vLwywdVURMEnrpsxHMoDlxVyZzXAOavW94MVvdShJ5wWJTsDUmAA7cx1r+EpwjD
         O8Cbpr61QfgWWehUxfY4DKPdlo/nhA3UXP3fTPhVF7qIJCa6rJaLQoedBSpzH4HCwLKS
         tTHw==
X-Gm-Message-State: ACrzQf2sgoz7WOQx1gvc4DRZPaHrDoTX2VpBJ2aiMpyB4JFoeFrGy0Eg
        IOLR35M26eRTTR1MTJ1NsV/tyOtRXLVhVIY17WyHcvkCdtS7pFRKEUe2e7nGlHddq/OxkT+xbW0
        bVbOB/0jCqmsaHuB1KPODSr5y
X-Received: by 2002:a17:907:8a09:b0:78d:3863:a98d with SMTP id sc9-20020a1709078a0900b0078d3863a98dmr924532ejc.538.1664974009800;
        Wed, 05 Oct 2022 05:46:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM64rCeRJstMjCCgAGJNL13Jihmzd8fcqpDk0fn8RUI2ZS6Qne7gQZyL6v2dQs/n5grAdz8PRg==
X-Received: by 2002:a17:907:8a09:b0:78d:3863:a98d with SMTP id sc9-20020a1709078a0900b0078d3863a98dmr924519ejc.538.1664974009430;
        Wed, 05 Oct 2022 05:46:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id lc23-20020a170906dff700b00787f91a6b16sm8640911ejc.26.2022.10.05.05.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 05:46:48 -0700 (PDT)
Message-ID: <b23c765b-4999-17a4-d89a-55d6ba72f68d@redhat.com>
Date:   Wed, 5 Oct 2022 14:46:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.1-1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the main PDx86 PR for 6.1.

Highlights:
 -  AMD Platform Management Framework (PMF) driver with AMT and QnQF support
 -  AMD PMC: Improved logging for debugging s2idle issues
 -  Big refactor of the ACPI/x86 backlight handling, ensuring that we only
    register 1 /sys/class/backlight device per LCD panel
 -  Microsoft Surface:
    -  Surface Laptop Go 2 support
    -  Surface Pro 8 HID sensor support
 -  Asus WMI:
    -  Lots of cleanups
    -  Support for TUF RGB keyboard backlight control
    -  Add support for ROG X13 tablet mode
 -  Siemens Simatic: IPC227G and IPC427G support
 -  Toshiba ACPI laptop driver: Fan hwmon and battery ECO mode support
 -  tools/power/x86/intel-speed-select: Various improvements
 -  Various cleanups
 -  Various small bugfixes

One of the bigger parts of this PR is the backlight refactor which involves
a mix of ACPI, DRM and PDx86 changes. There is a small conflict here due
to a bugfix/quirk for some Toshiba laptops which has landed late in the
cycle for 6.0, with the quirk handling in question being reworked in
the refactor, leading to a conflict between:

  574160b8548d ("ACPI: video: Add Toshiba Satellite/Portege Z830 quirk")
  c5b94f5b7819 ("ACPI: video: Change disable_backlight_sysfs_if quirks to acpi_backlight=native")

The latter commit already includes the addition of the Z830 models to
the list of quirked Toshiba models. The quirk handling for these
is now moved from drivers/acpi/acpi_video.c to drivers/acpi/video_detect.c.

So the resolution of the conflict is to simply remove the entire conflicting
block (the Toshiba models) from drivers/acpi/acpi_video.c.

There also is a small conflict in drivers/platform/mellanox/mlxreg-lc.c
due to a locking fix which landed mid 6.0 mixing unlock + return with
goto style exits in error paths. My tree has a fix on top to consistently
use the goto style. Here you can just take the version from me tree.

Regards,

Hans


The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.1-1

for you to fetch changes up to 8d05fc039456517d2c246c7b202891188ba40c4d:

  platform/x86: use PLATFORM_DEVID_NONE instead of -1 (2022-10-03 09:40:04 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.1-1

Highlights:
 -  AMD Platform Management Framework (PMF) driver with AMT and QnQF support
 -  AMD PMC: Improved logging for debugging s2idle issues
 -  Big refactor of the ACPI/x86 backlight handling, ensuring that we only
    register 1 /sys/class/backlight device per LCD panel
 -  Microsoft Surface:
    -  Surface Laptop Go 2 support
    -  Surface Pro 8 HID sensor support
 -  Asus WMI:
    -  Lots of cleanups
    -  Support for TUF RGB keyboard backlight control
    -  Add support for ROG X13 tablet mode
 -  Siemens Simatic: IPC227G and IPC427G support
 -  Toshiba ACPI laptop driver: Fan hwmon and battery ECO mode support
 -  tools/power/x86/intel-speed-select: Various improvements
 -  Various cleanups
 -  Various small bugfixes

The following is an automated git shortlog grouped by driver:

ACPI:
 -  video: Change disable_backlight_sysfs_if quirks to acpi_backlight=native
 -  s2idle: Add a new ->check() callback for platform_s2idle_ops
 -  video: Fix indentation of video_detect_dmi_table[] entries
 -  video: Drop NL5x?U, PF4NU1F and PF5?U?? acpi_backlight=native quirks
 -  video: Drop "Samsung X360" acpi_backlight=native quirk
 -  video: Remove acpi_video_set_dmi_backlight_type()
 -  video: Add Apple GMUX brightness control detection
 -  video: Add Nvidia WMI EC brightness control detection (v3)
 -  video: Refactor acpi_video_get_backlight_type() a bit
 -  video: Remove code to unregister acpi_video backlight when a native backlight registers
 -  video: Make backlight class device registration a separate step (v2)
 -  video: Simplify acpi_video_unregister_backlight()
 -  video: Remove acpi_video_bus from list before tearing it down
 -  video: Drop backlight_device_get_by_type() call from acpi_video_get_backlight_type()
 -  video: Add acpi_video_backlight_use_native() helper

acer-wmi:
 -  Move backlight DMI quirks to acpi/video_detect.c
 -  Acer Aspire One AOD270/Packard Bell Dot keymap fixes

apple-gmux:
 -  Stop calling acpi/video.h functions

asus-wmi:
 -  Expand support of GPU fan to read RPM and label
 -  Make kbd_rgb_mode_groups static
 -  Move acpi_backlight=native quirks to ACPI video_detect.c
 -  Move acpi_backlight=vendor quirks to ACPI video_detect.c
 -  Drop DMI chassis-type check from backlight handling
 -  Increase FAN_CURVE_BUF_LEN to 32
 -  Fix the name of the mic-mute LED classdev
 -  Implement TUF laptop keyboard power states
 -  Implement TUF laptop keyboard LED modes
 -  Support the GPU fan on TUF laptops
 -  Modify behaviour of Fn+F5 fan key
 -  Update tablet_mode_sw module-param help text
 -  Simplify tablet-mode-switch handling
 -  Simplify tablet-mode-switch probing
 -  Add support for ROG X13 tablet mode
 -  Adjust tablet/lidflip handling to use enum
 -  Support the hardware GPU MUX on some laptops
 -  Simplify some of the *_check_present() helpers
 -  Refactor panel_od attribute
 -  Refactor egpu_enable attribute
 -  Refactor disable_gpu attribute
 -  Document the panel_od sysfs attribute
 -  Document the egpu_enable sysfs attribute
 -  Document the dgpu_disable sysfs attribute
 -  Use kobj_to_dev()
 -  Convert all attr-show to use sysfs_emit

compal-laptop:
 -  Get rid of a few forward declarations

dell-privacy:
 -  convert to use dev_groups

dell-smbios-base:
 -  Use sysfs_emit()

dell-wmi:
 -  Add WMI event 0x0012 0x0003 to the list

docs:
 -  ABI: charge_control_end_threshold may not support all values

drivers/platform:
 -  toshiba_acpi: Call HCI_PANEL_POWER_ON on resume on some models

drm/amdgpu:
 -  Register ACPI video backlight when skipping amdgpu backlight registration
 -  Don't register backlight when another backlight should be used (v3)

drm/i915:
 -  Call acpi_video_register_backlight() (v3)
 -  Don't register backlight when another backlight should be used (v2)

drm/nouveau:
 -  Register ACPI video backlight when nv_backlight registration fails (v2)
 -  Don't register backlight when another backlight should be used (v2)

drm/radeon:
 -  Register ACPI video backlight when skipping radeon backlight registration
 -  Don't register backlight when another backlight should be used (v3)

drm/todo:
 -  Add entry about dealing with brightness control on devices with > 1 panel

gpio-f7188x:
 -  use unique labels for banks/chips
 -  Add GPIO support for Nuvoton NCT6116
 -  add a prefix to macros to keep gpio namespace clean
 -  switch over to using pr_fmt

hp-wmi:
 -  Support touchpad on/off
 -  Setting thermal profile fails with 0x06

int3472/discrete:
 -  Drop a forward declaration

intel-uncore-freq:
 -  Use sysfs_emit() to instead of scnprintf()

intel_cht_int33fe:
 -  Fix comment according to the code flow

leds:
 -  simatic-ipc-leds-gpio: Make simatic_ipc_led_gpio_table static
 -  simatic-ipc-leds-gpio: add new model 227G

move from strlcpy with unused retval to strscpy:
 - move from strlcpy with unused retval to strscpy

msi-laptop:
 -  Change DMI match / alias strings to fix module autoloading
 -  Add msi_scm_disable_hw_fn_handling() helper
 -  Add msi_scm_model_exit() helper
 -  Fix resource cleanup
 -  Simplify ec_delay handling
 -  Fix old-ec check for backlight registering
 -  Drop MSI_DRIVER_VERSION
 -  Use MODULE_DEVICE_TABLE()

nvidia-wmi-ec-backlight:
 -  Use acpi_video_get_backlight_type()
 -  Move fw interface definitions to a header (v2)

p2sb:
 -  Fix UAF when caller uses resource name

platform/mellanox:
 -  mlxreg-lc: Make error handling flow consistent
 -  Remove redundant 'NULL' check
 -  Remove unnecessary code
 -  mlxreg-lc: Fix locking issue
 -  mlxreg-lc: Fix coverity warning

platform/surface:
 -  Split memcpy() of struct ssam_event flexible array
 -  aggregator_registry: Add HID devices for sensors and UCSI client to SP8
 -  aggregator_registry: Rename HID device nodes based on new findings
 -  aggregator_registry: Rename HID device nodes based on their function
 -  aggregator_registry: Add support for Surface Laptop Go 2

platform/x86:
 - use PLATFORM_DEVID_NONE instead of -1

platform/x86/amd:
 -  pmc: Dump idle mask during "check" stage instead
 -  pmc: remove CONFIG_DEBUG_FS checks
 -  pmc: Fix build without debugfs
 -  pmc: Add sysfs files for SMU
 -  pmc: Add an extra STB message for checking s2idle entry
 -  pmc: Always write to the STB
 -  pmc: Add defines for STB events

platform/x86/amd/pmf:
 -  Remove unused power_delta instances
 -  install notify handler after acpi init
 -  Add sysfs to toggle CnQF
 -  Add support for CnQF
 -  Fix clang unused variable warning
 -  Fix undefined reference to platform_profile
 -  Force load driver on older supported platforms
 -  Handle AMT and CQL events for Auto mode
 -  Add support for Auto mode feature
 -  Get performance metrics from PMFW
 -  Add fan control support
 -  Add heartbeat signal support
 -  Add debugfs information
 -  Add support SPS PMF feature
 -  Add support for PMF APCI layer
 -  Add support for PMF core layer
 -  Add ABI doc for AMD PMF
 -  Add AMD PMF driver entry

platform/x86/intel/wmi:
 -  thunderbolt: Use dev_groups callback

pmc_atom:
 -  Amend comment style and grammar
 -  Make terminator entry uniform
 -  Improve quirk message to be less cryptic
 -  Fix SLP_TYPx bitfield mask

samsung-laptop:
 -  Move acpi_backlight=[vendor|native] quirks to ACPI video_detect.c

simatic-ipc:
 -  add new model 427G
 -  enable watchdog for 227G

thinkpad_acpi:
 -  Explicitly set to balanced mode on startup

tools/power/x86/intel-speed-select:
 -  Release v1.13
 -  Optimize CPU initialization
 -  Utilize cpu_map to get physical id
 -  Remove unused struct clos_config fields
 -  Enforce isst_id value
 -  Do not export get_physical_id
 -  Introduce is_cpu_in_power_domain helper
 -  Cleanup get_physical_id usage
 -  Convert more function to use isst_id
 -  Add pkg and die in isst_id
 -  Introduce struct isst_id
 -  Remove unused core_mask array
 -  Remove dead code
 -  Fix cpu count for TDP level display

toshiba_acpi:
 -  change turn_on_panel_on_resume to static
 -  Remove duplicate include
 -  Set correct parent for input device.
 -  Add fan RPM reading (hwmon interface)
 -  Add fan RPM reading (internals)
 -  Stop using acpi_video_set_dmi_backlight_type()
 -  Fix ECO LED control on Toshiba Z830
 - Battery charge mode in toshiba_acpi (internals)
 - Battery charge mode in toshiba_acpi (sysfs)

wmi:
 -  Drop forward declaration of static functions
 -  Allow duplicate GUIDs for drivers that use struct wmi_driver

x86-android-tablets:
 -  Fix broken touchscreen on Chuwi Hi8 with Windows BIOS

----------------------------------------------------------------
Andy Shevchenko (6):
      platform/x86: pmc_atom: Fix SLP_TYPx bitfield mask
      platform/x86: pmc_atom: Improve quirk message to be less cryptic
      platform/x86: pmc_atom: Make terminator entry uniform
      platform/x86: pmc_atom: Amend comment style and grammar
      platform/x86: intel_cht_int33fe: Fix comment according to the code flow
      platform/x86: p2sb: Fix UAF when caller uses resource name

Arvid Norlander (7):
      platform/x86: toshiba_acpi: Fix ECO LED control on Toshiba Z830
      platform/x86: toshiba_acpi: Add fan RPM reading (internals)
      platform/x86: toshiba_acpi: Add fan RPM reading (hwmon interface)
      platform/x86: Battery charge mode in toshiba_acpi (internals)
      platform/x86: Battery charge mode in toshiba_acpi (sysfs)
      docs: ABI: charge_control_end_threshold may not support all values
      platform/x86: toshiba_acpi: Set correct parent for input device.

Barnabás Pőcze (1):
      platform/x86: use PLATFORM_DEVID_NONE instead of -1

Daniel Houldsworth (1):
      platform/x86: hp-wmi: Support touchpad on/off

Greg Kroah-Hartman (1):
      platform/x86: dell-privacy: convert to use dev_groups

Hans de Goede (54):
      ACPI: video: Add acpi_video_backlight_use_native() helper
      drm/i915: Don't register backlight when another backlight should be used (v2)
      drm/amdgpu: Don't register backlight when another backlight should be used (v3)
      drm/radeon: Don't register backlight when another backlight should be used (v3)
      Merge branch 'platform-drivers-x86-amd-pmf' into pdx86-base
      platform/x86: x86-android-tablets: Fix broken touchscreen on Chuwi Hi8 with Windows BIOS
      platform/x86: asus-wmi: Simplify some of the *_check_present() helpers
      platform/x86: asus-wmi: Simplify tablet-mode-switch probing
      platform/x86: asus-wmi: Simplify tablet-mode-switch handling
      platform/x86: asus-wmi: Update tablet_mode_sw module-param help text
      platform/x86: msi-laptop: Use MODULE_DEVICE_TABLE()
      platform/x86: msi-laptop: Drop MSI_DRIVER_VERSION
      platform/x86: msi-laptop: Fix old-ec check for backlight registering
      platform/x86: msi-laptop: Simplify ec_delay handling
      platform/x86: msi-laptop: Fix resource cleanup
      platform/x86: msi-laptop: Add msi_scm_model_exit() helper
      platform/x86: msi-laptop: Add msi_scm_disable_hw_fn_handling() helper
      platform/x86: acer-wmi: Acer Aspire One AOD270/Packard Bell Dot keymap fixes
      Merge tag 'platform-drivers-x86-simatec-1' into review-hans
      drm/nouveau: Don't register backlight when another backlight should be used (v2)
      ACPI: video: Drop backlight_device_get_by_type() call from acpi_video_get_backlight_type()
      ACPI: video: Remove acpi_video_bus from list before tearing it down
      ACPI: video: Simplify acpi_video_unregister_backlight()
      ACPI: video: Make backlight class device registration a separate step (v2)
      ACPI: video: Remove code to unregister acpi_video backlight when a native backlight registers
      drm/i915: Call acpi_video_register_backlight() (v3)
      drm/nouveau: Register ACPI video backlight when nv_backlight registration fails (v2)
      drm/amdgpu: Register ACPI video backlight when skipping amdgpu backlight registration
      drm/radeon: Register ACPI video backlight when skipping radeon backlight registration
      platform/x86: nvidia-wmi-ec-backlight: Move fw interface definitions to a header (v2)
      ACPI: video: Refactor acpi_video_get_backlight_type() a bit
      ACPI: video: Add Nvidia WMI EC brightness control detection (v3)
      ACPI: video: Add Apple GMUX brightness control detection
      platform/x86: nvidia-wmi-ec-backlight: Use acpi_video_get_backlight_type()
      platform/x86: apple-gmux: Stop calling acpi/video.h functions
      platform/x86: toshiba_acpi: Stop using acpi_video_set_dmi_backlight_type()
      platform/x86: acer-wmi: Move backlight DMI quirks to acpi/video_detect.c
      platform/x86: asus-wmi: Drop DMI chassis-type check from backlight handling
      platform/x86: asus-wmi: Move acpi_backlight=vendor quirks to ACPI video_detect.c
      platform/x86: asus-wmi: Move acpi_backlight=native quirks to ACPI video_detect.c
      platform/x86: samsung-laptop: Move acpi_backlight=[vendor|native] quirks to ACPI video_detect.c
      ACPI: video: Remove acpi_video_set_dmi_backlight_type()
      ACPI: video: Drop "Samsung X360" acpi_backlight=native quirk
      ACPI: video: Drop NL5x?U, PF4NU1F and PF5?U?? acpi_backlight=native quirks
      ACPI: video: Fix indentation of video_detect_dmi_table[] entries
      drm/todo: Add entry about dealing with brightness control on devices with > 1 panel
      Merge tag 'backlight-detect-refactor-1' into review-hans
      drivers/platform: toshiba_acpi: Call HCI_PANEL_POWER_ON on resume on some models
      ACPI: video: Change disable_backlight_sysfs_if quirks to acpi_backlight=native
      platform/x86: asus-wmi: Make kbd_rgb_mode_groups static
      leds: simatic-ipc-leds-gpio: Make simatic_ipc_led_gpio_table static
      Merge remote-tracking branch 'intel-sst/intel-sst' into review-hans
      platform/x86: msi-laptop: Change DMI match / alias strings to fix module autoloading
      Merge branch 'platform-drivers-x86-amd-pmf' into review-hans

Henning Schild (7):
      gpio-f7188x: switch over to using pr_fmt
      gpio-f7188x: add a prefix to macros to keep gpio namespace clean
      gpio-f7188x: Add GPIO support for Nuvoton NCT6116
      gpio-f7188x: use unique labels for banks/chips
      leds: simatic-ipc-leds-gpio: add new model 227G
      platform/x86: simatic-ipc: enable watchdog for 227G
      platform/x86: simatic-ipc: add new model 427G

Jorge Lopez (1):
      platform/x86: hp-wmi: Setting thermal profile fails with 0x06

Kees Cook (1):
      platform/surface: Split memcpy() of struct ssam_event flexible array

Luke D. Jones (16):
      platform/x86: asus-wmi: Convert all attr-show to use sysfs_emit
      platform/x86: asus-wmi: Document the dgpu_disable sysfs attribute
      platform/x86: asus-wmi: Document the egpu_enable sysfs attribute
      platform/x86: asus-wmi: Document the panel_od sysfs attribute
      platform/x86: asus-wmi: Refactor disable_gpu attribute
      platform/x86: asus-wmi: Refactor egpu_enable attribute
      platform/x86: asus-wmi: Refactor panel_od attribute
      platform/x86: asus-wmi: Support the hardware GPU MUX on some laptops
      platform/x86: asus-wmi: Adjust tablet/lidflip handling to use enum
      platform/x86: asus-wmi: Add support for ROG X13 tablet mode
      platform/x86: asus-wmi: Modify behaviour of Fn+F5 fan key
      platform/x86: asus-wmi: Support the GPU fan on TUF laptops
      platform/x86: asus-wmi: Implement TUF laptop keyboard LED modes
      platform/x86: asus-wmi: Implement TUF laptop keyboard power states
      platform/x86: asus-wmi: Increase FAN_CURVE_BUF_LEN to 32
      platform/x86: asus-wmi: Expand support of GPU fan to read RPM and label

Mario Limonciello (8):
      platform/x86: thinkpad_acpi: Explicitly set to balanced mode on startup
      platform/x86: wmi: Allow duplicate GUIDs for drivers that use struct wmi_driver
      ACPI: s2idle: Add a new ->check() callback for platform_s2idle_ops
      platform/x86/amd: pmc: Add defines for STB events
      platform/x86/amd: pmc: Always write to the STB
      platform/x86/amd: pmc: Add an extra STB message for checking s2idle entry
      platform/x86/amd: pmc: Add sysfs files for SMU
      platform/x86/amd: pmc: Dump idle mask during "check" stage instead

Maximilian Luz (4):
      platform/surface: aggregator_registry: Add support for Surface Laptop Go 2
      platform/surface: aggregator_registry: Rename HID device nodes based on their function
      platform/surface: aggregator_registry: Rename HID device nodes based on new findings
      platform/surface: aggregator_registry: Add HID devices for sensors and UCSI client to SP8

Nathan Chancellor (1):
      platform/x86/amd: pmc: Fix build without debugfs

PaddyKP_Yao (1):
      platform/x86: asus-wmi: Fix the name of the mic-mute LED classdev

Pali Rohár (1):
      platform/x86: dell-wmi: Add WMI event 0x0012 0x0003 to the list

Shyam Sundar S K (20):
      platform/x86/amd/pmf: Add support for PMF core layer
      platform/x86/amd/pmf: Add support for PMF APCI layer
      platform/x86/amd/pmf: Add support SPS PMF feature
      platform/x86/amd/pmf: Add debugfs information
      platform/x86/amd/pmf: Add heartbeat signal support
      platform/x86/amd/pmf: Add fan control support
      platform/x86/amd/pmf: Get performance metrics from PMFW
      platform/x86/amd/pmf: Add support for Auto mode feature
      platform/x86/amd/pmf: Handle AMT and CQL events for Auto mode
      platform/x86/amd/pmf: Force load driver on older supported platforms
      MAINTAINERS: Add AMD PMF driver entry
      platform/x86/amd/pmf: Fix undefined reference to platform_profile
      platform/x86/amd/pmf: Fix clang unused variable warning
      platform/x86/amd/pmf: Add support for CnQF
      platform/x86/amd/pmf: Add sysfs to toggle CnQF
      Documentation/ABI/testing/sysfs-amd-pmf: Add ABI doc for AMD PMF
      platform/x86/amd/pmf: install notify handler after acpi init
      platform/x86/amd/pmf: Remove unused power_delta instances
      platform/x86/amd: pmc: remove CONFIG_DEBUG_FS checks
      platform/x86/intel/wmi: thunderbolt: Use dev_groups callback

Srinivas Pandruvada (1):
      tools/power/x86/intel-speed-select: Release v1.13

Uwe Kleine-König (3):
      platform/x86: wmi: Drop forward declaration of static functions
      platform/x86: int3472/discrete: Drop a forward declaration
      platform/x86: compal-laptop: Get rid of a few forward declarations

Vadim Pasternak (5):
      platform/mellanox: mlxreg-lc: Fix coverity warning
      platform/mellanox: mlxreg-lc: Fix locking issue
      platform/mellanox: Remove unnecessary code
      platform/mellanox: Remove redundant 'NULL' check
      platform/mellanox: mlxreg-lc: Make error handling flow consistent

Wolfram Sang (1):
      platform/x86: move from strlcpy with unused retval to strscpy

Yang Yingliang (1):
      platform/x86: toshiba_acpi: change turn_on_panel_on_resume to static

Yihao Han (1):
      platform/x86: toshiba_acpi: Remove duplicate include

Zhang Rui (13):
      tools/power/x86/intel-speed-select: Fix cpu count for TDP level display
      tools/power/x86/intel-speed-select: Remove dead code
      tools/power/x86/intel-speed-select: Remove unused core_mask array
      tools/power/x86/intel-speed-select: Introduce struct isst_id
      tools/power/x86/intel-speed-select: Add pkg and die in isst_id
      tools/power/x86/intel-speed-select: Convert more function to use isst_id
      tools/power/x86/intel-speed-select: Cleanup get_physical_id usage
      tools/power/x86/intel-speed-select: Introduce is_cpu_in_power_domain helper
      tools/power/x86/intel-speed-select: Do not export get_physical_id
      tools/power/x86/intel-speed-select: Enforce isst_id value
      tools/power/x86/intel-speed-select: Remove unused struct clos_config fields
      tools/power/x86/intel-speed-select: Utilize cpu_map to get physical id
      tools/power/x86/intel-speed-select: Optimize CPU initialization

ye xingchen (3):
      platform/x86: asus-wmi: Use kobj_to_dev()
      platform/x86: dell-smbios-base: Use sysfs_emit()
      platform/x86: intel-uncore-freq: Use sysfs_emit() to instead of scnprintf()

 Documentation/ABI/testing/sysfs-amd-pmc            |  13 +
 Documentation/ABI/testing/sysfs-amd-pmf            |  13 +
 Documentation/ABI/testing/sysfs-class-power        |   5 +-
 Documentation/ABI/testing/sysfs-platform-asus-wmi  |  41 ++
 Documentation/gpu/todo.rst                         |  68 +++
 MAINTAINERS                                        |   8 +
 drivers/acpi/Kconfig                               |   1 +
 drivers/acpi/acpi_video.c                          | 112 ++--
 drivers/acpi/sleep.h                               |   1 +
 drivers/acpi/video_detect.c                        | 449 ++++++++------
 drivers/acpi/x86/s2idle.c                          |  14 +
 drivers/gpio/Kconfig                               |   3 +-
 drivers/gpio/gpio-f7188x.c                         | 275 +++++----
 drivers/gpu/drm/Kconfig                            |  14 +
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c     |  14 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   9 +
 drivers/gpu/drm/gma500/Kconfig                     |   2 +
 drivers/gpu/drm/i915/Kconfig                       |   2 +
 drivers/gpu/drm/i915/display/intel_acpi.c          |  27 +
 drivers/gpu/drm/i915/display/intel_acpi.h          |   3 +
 drivers/gpu/drm/i915/display/intel_backlight.c     |   7 +
 drivers/gpu/drm/i915/display/intel_display.c       |   2 +-
 drivers/gpu/drm/nouveau/nouveau_acpi.c             |  10 +
 drivers/gpu/drm/nouveau/nouveau_acpi.h             |   4 +
 drivers/gpu/drm/nouveau/nouveau_backlight.c        |  13 +
 drivers/gpu/drm/radeon/atombios_encoders.c         |   7 +
 drivers/gpu/drm/radeon/radeon_encoders.c           |  11 +-
 drivers/gpu/drm/radeon/radeon_legacy_encoders.c    |   7 +
 drivers/leds/simple/simatic-ipc-leds-gpio.c        |  42 +-
 drivers/platform/mellanox/mlxreg-lc.c              |  55 +-
 drivers/platform/surface/surface3_power.c          |   2 +-
 drivers/platform/surface/surface_acpi_notify.c     |   3 +-
 .../platform/surface/surface_aggregator_registry.c |  47 +-
 drivers/platform/x86/Kconfig                       |   3 +
 drivers/platform/x86/acer-wmi.c                    |  77 +--
 drivers/platform/x86/acerhdf.c                     |   2 +-
 drivers/platform/x86/amd/Kconfig                   |   2 +
 drivers/platform/x86/amd/Makefile                  |   1 +
 drivers/platform/x86/amd/hsmp.c                    |   2 +-
 drivers/platform/x86/amd/pmc.c                     | 131 ++--
 drivers/platform/x86/amd/pmf/Kconfig               |  16 +
 drivers/platform/x86/amd/pmf/Makefile              |   9 +
 drivers/platform/x86/amd/pmf/acpi.c                | 304 ++++++++++
 drivers/platform/x86/amd/pmf/auto-mode.c           | 305 ++++++++++
 drivers/platform/x86/amd/pmf/cnqf.c                | 395 ++++++++++++
 drivers/platform/x86/amd/pmf/core.c                | 412 +++++++++++++
 drivers/platform/x86/amd/pmf/pmf.h                 | 417 +++++++++++++
 drivers/platform/x86/amd/pmf/sps.c                 | 146 +++++
 drivers/platform/x86/amilo-rfkill.c                |   3 +-
 drivers/platform/x86/apple-gmux.c                  |   3 -
 drivers/platform/x86/asus-laptop.c                 |   2 +-
 drivers/platform/x86/asus-nb-wmi.c                 |  59 +-
 drivers/platform/x86/asus-wmi.c                    | 667 +++++++++++++--------
 drivers/platform/x86/asus-wmi.h                    |  12 +-
 drivers/platform/x86/compal-laptop.c               | 153 +++--
 drivers/platform/x86/dell/alienware-wmi.c          |   2 +-
 drivers/platform/x86/dell/dcdbas.c                 |   2 +-
 drivers/platform/x86/dell/dell-laptop.c            |   2 +-
 drivers/platform/x86/dell/dell-smbios-base.c       |   4 +-
 drivers/platform/x86/dell/dell-wmi-base.c          |   3 +
 drivers/platform/x86/dell/dell-wmi-privacy.c       |  12 +-
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c |   2 +-
 drivers/platform/x86/dell/dell_rbu.c               |   2 +-
 drivers/platform/x86/eeepc-laptop.c                |   2 +-
 drivers/platform/x86/eeepc-wmi.c                   |  25 +-
 drivers/platform/x86/fujitsu-laptop.c              |   2 +-
 drivers/platform/x86/hdaps.c                       |   2 +-
 drivers/platform/x86/hp-wmi.c                      |  33 +-
 drivers/platform/x86/huawei-wmi.c                  |   2 +-
 drivers/platform/x86/intel/chtwc_int33fe.c         |   8 +-
 drivers/platform/x86/intel/int3472/discrete.c      |  34 +-
 drivers/platform/x86/intel/oaktrail.c              |   2 +-
 .../uncore-frequency/uncore-frequency-common.c     |   2 +-
 drivers/platform/x86/intel/wmi/thunderbolt.c       |  24 +-
 drivers/platform/x86/mlx-platform.c                |   2 +-
 drivers/platform/x86/msi-laptop.c                  | 106 ++--
 drivers/platform/x86/nvidia-wmi-ec-backlight.c     |  82 +--
 drivers/platform/x86/p2sb.c                        |  18 +-
 drivers/platform/x86/panasonic-laptop.c            |   2 +-
 drivers/platform/x86/pmc_atom.c                    |  44 +-
 drivers/platform/x86/samsung-laptop.c              |  89 +--
 drivers/platform/x86/simatic-ipc.c                 |  10 +-
 drivers/platform/x86/sony-laptop.c                 |   2 +-
 drivers/platform/x86/tc1100-wmi.c                  |   2 +-
 drivers/platform/x86/thinkpad_acpi.c               |  15 +-
 drivers/platform/x86/topstar-laptop.c              |   2 +-
 drivers/platform/x86/toshiba_acpi.c                | 337 ++++++++++-
 drivers/platform/x86/winmate-fm07-keys.c           |   2 +-
 drivers/platform/x86/wmi.c                         |  66 +-
 drivers/platform/x86/x86-android-tablets.c         |  14 +
 include/acpi/video.h                               |   9 +-
 include/linux/acpi.h                               |   1 +
 include/linux/platform_data/x86/asus-wmi.h         |  11 +
 .../platform_data/x86/nvidia-wmi-ec-backlight.h    |  76 +++
 include/linux/platform_data/x86/pmc_atom.h         |  10 +-
 include/linux/platform_data/x86/simatic-ipc-base.h |   1 +
 include/linux/platform_data/x86/simatic-ipc.h      |   2 +
 include/linux/suspend.h                            |   1 +
 kernel/power/suspend.c                             |   3 +
 tools/power/x86/intel-speed-select/hfi-events.c    |   5 +-
 tools/power/x86/intel-speed-select/isst-config.c   | 511 ++++++++--------
 tools/power/x86/intel-speed-select/isst-core.c     | 313 +++++-----
 tools/power/x86/intel-speed-select/isst-daemon.c   |  36 +-
 tools/power/x86/intel-speed-select/isst-display.c  |  76 ++-
 tools/power/x86/intel-speed-select/isst.h          |  88 +--
 105 files changed, 4650 insertions(+), 1856 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-amd-pmc
 create mode 100644 Documentation/ABI/testing/sysfs-amd-pmf
 create mode 100644 drivers/platform/x86/amd/pmf/Kconfig
 create mode 100644 drivers/platform/x86/amd/pmf/Makefile
 create mode 100644 drivers/platform/x86/amd/pmf/acpi.c
 create mode 100644 drivers/platform/x86/amd/pmf/auto-mode.c
 create mode 100644 drivers/platform/x86/amd/pmf/cnqf.c
 create mode 100644 drivers/platform/x86/amd/pmf/core.c
 create mode 100644 drivers/platform/x86/amd/pmf/pmf.h
 create mode 100644 drivers/platform/x86/amd/pmf/sps.c
 create mode 100644 include/linux/platform_data/x86/nvidia-wmi-ec-backlight.h

