Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947D169C873
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjBTKTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjBTKTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:19:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C6640C3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676888282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=E5QH0XjK/2mI3uFcmWIFTgu6W6Ma/zrzy+oip3onN3w=;
        b=Iqjcm3WS0FAHOqY9l3VLSFLMplrxqCyb5CfmE4u0rKHHE2bETqk/hiAjmvFm6fqjc79pty
        ZIpS+6jBbYRmdMUpidU2Rz/XX6uIOyBx3RzZj5BlX9SA1hY2u7aAbIsBimNme0I7KqFJaG
        EKHIQ18Rs9gsRx4f4f1FnPba4lG5k7w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-638-fdZCPE8IPAy-nAgSxiGE4w-1; Mon, 20 Feb 2023 05:18:00 -0500
X-MC-Unique: fdZCPE8IPAy-nAgSxiGE4w-1
Received: by mail-ed1-f69.google.com with SMTP id ec13-20020a0564020d4d00b004a621e993a8so825506edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:18:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E5QH0XjK/2mI3uFcmWIFTgu6W6Ma/zrzy+oip3onN3w=;
        b=Ra15mxhdKCo+GSMimv7K4KrZJROsPKeGiG7OIn8gQNajN1xmzqGGLl+mKqWwHVXpFm
         aXW/vXPKdqFOLj64N07ID29TCFWBgBZNX2H/Ur0n/Jj+7NZrCAQF9NBtLERG3QjCDKm/
         Dagr6jTZSSMBIZvvdxAy7joGz4dVRhAls6kGCipIUmneio/p04kpIdVZAcFcnptkXA3R
         RUMXdmToBPvEJFFJTyVg7OuymW/xcQOoxNGUMv91lUGpbHRCFIR14Ql3eUfVIb+BazXY
         xuJ93M+OpByURlWnctDDoLa0uixgysXoM3QDldARwMLOGFNSE4T8lOTioo/QgJzzFvQu
         JIxw==
X-Gm-Message-State: AO0yUKWLlPHfkDB6lOjlVytmfVlGpwIm/cBJ3lKTdUY1tpyQlLSaTF1i
        Oi4RnsD85CsaPJxHqViUBA52w2frrgoz/vAuTKzES/xtHZkbZyEuR6EhzCT+lzNHaKJ/lb01m7w
        pF53Eu/DFLApKCyt202rui3VGTEhioA==
X-Received: by 2002:a17:906:580d:b0:8bd:11a1:fe9 with SMTP id m13-20020a170906580d00b008bd11a10fe9mr6597607ejq.16.1676888278735;
        Mon, 20 Feb 2023 02:17:58 -0800 (PST)
X-Google-Smtp-Source: AK7set+SxoAFi+dQ2897O+UlBviu7MOsuIzVFRpkvUpUsITT/H2ivSY3g/HN8H3Tr9Q8OXyuG+oMFA==
X-Received: by 2002:a17:906:580d:b0:8bd:11a1:fe9 with SMTP id m13-20020a170906580d00b008bd11a10fe9mr6597592ejq.16.1676888278358;
        Mon, 20 Feb 2023 02:17:58 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id q11-20020a17090622cb00b008b1569b37edsm5576788eja.214.2023.02.20.02.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 02:17:57 -0800 (PST)
Message-ID: <9f696a6a-9161-ab4c-5304-dc2db865f5d8@redhat.com>
Date:   Mon, 20 Feb 2023 11:17:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.3-1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the main PDx86 PR for 6.3.

Highlights:
 -  AMD PMC: Improvements to aid s2idle debugging
 -  Dell WMI-DDV: hwmon support
 -  INT3472 camera sensor power-management: Improve privacy LED support
 -  Intel VSEC: Base TPMI (Topology Aware Register and PM Capsule Interface) support
 -  Mellanox: SN5600 and Nvidia L1 switch support
 -  Microsoft Surface Support: Various cleanups + code improvements
 -  tools/intel-speed-select: Various improvements
 -  Miscellaneous other cleanups / fixes

Note this includes some drivers/leds changes from ib-leds-led_get-v6.3
and also some drivers/media/v4l2-core/ changes related to privacy LED
handling which have been acked by Sakari (one of the media maintainers).

Regards,

Hans


The following changes since commit eecf2acd4a580e9364e5087daf0effca60a240b7:

  platform/x86: touchscreen_dmi: Add Chuwi Vi8 (CWI501) DMI match (2023-02-02 11:34:38 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.3-1

for you to fetch changes up to 0d9bdd8a550170306c2021b8d6766c5343b870c2:

  platform/x86: nvidia-wmi-ec-backlight: Add force module parameter (2023-02-18 11:45:52 +0100)

----------------------------------------------------------------
platform-drivers-x86 for v6.3-1

Highlights:
 -  AMD PMC: Improvements to aid s2idle debugging
 -  Dell WMI-DDV: hwmon support
 -  INT3472 camera sensor power-management: Improve privacy LED support
 -  Intel VSEC: Base TPMI (Topology Aware Register and PM Capsule Interface) support
 -  Mellanox: SN5600 and Nvidia L1 switch support
 -  Microsoft Surface Support: Various cleanups + code improvements
 -  tools/intel-speed-select: Various improvements
 -  Miscellaneous other cleanups / fixes

The following is an automated git shortlog grouped by driver:

Add include/linux/platform_data/x86 to MAINTAINERS:
 -  Add include/linux/platform_data/x86 to MAINTAINERS

Documentation/ABI:
 -  Add new attribute for mlxreg-io sysfs interfaces

Fix header inclusion in linux/platform_data/x86/soc.h:
 -  Fix header inclusion in linux/platform_data/x86/soc.h

HID:
 -  surface-hid: Use target-ID enum instead of hard-coding values

MAINTAINERS:
 -  dell-wmi-sysman: drop Divya Bharathi
 -  Add entry for TPMI driver

Merge tag 'ib-leds-led_get-v6.3' into HEAD:
 - Merge tag 'ib-leds-led_get-v6.3' into HEAD

acerhdf:
 -  Drop empty platform remove function

apple_gmux:
 -  Drop no longer used ACPI_VIDEO Kconfig dependency

dell-ddv:
 -  Prefer asynchronous probing
 -  Add hwmon support
 -  Add "force" module param
 -  Replace EIO with ENOMSG
 -  Return error if buffer is empty
 -  Add support for interface version 3

dell-smo8800:
 -  Use min_t() for comparison and assignment

dell-wmi-sysman:
 -  Make kobj_type structure constant

hp-wmi:
 -  Ignore Win-Lock key events

int1092:
 -  Switch to use acpi_evaluate_dsm_typed()

int3472/discrete:
 -  add LEDS_CLASS dependency
 -  Drop unnecessary obj->type == string check
 -  Get the polarity from the _DSM entry
 -  Move GPIO request to skl_int3472_register_clock()
 -  Create a LED class device for the privacy LED
 -  Refactor GPIO to sensor mapping

intel:
 -  punit_ipc: Drop empty platform remove function
 -  oaktrail: Drop empty platform remove function

intel/pmc:
 -  Switch to use acpi_evaluate_dsm_typed()

leds:
 -  led-class: Add generic [devm_]led_get()
 -  led-class: Add __devm_led_get() helper
 -  led-class: Add led_module_get() helper
 -  led-class: Add missing put_device() to led_put()

media:
 -  v4l2-core: Make the v4l2-core code enable/disable the privacy LED if present

nvidia-wmi-ec-backlight:
 -  Add force module parameter

platform:
 -  mellanox: mlx-platform: Move bus shift assignment out of the loop
 -  mellanox: mlx-platform: Add mux selection register to regmap
 -  mellanox: Extend all systems with I2C notification callback
 -  mellanox: Split logic in init and exit flow
 -  mellanox: Split initialization procedure
 -  mellanox: Introduce support of new Nvidia L1 switch
 -  mellanox: Introduce support for next-generation 800GB/s switch
 -  mellanox: Cosmetic changes - rename to more common name
 -  mellanox: Change "reset_pwr_converter_fail" attribute
 -  mellanox: Introduce support for rack manager switch

platform/mellanox:
 -  mlxreg-hotplug: Allow more flexible hotplug events configuration

platform/surface:
 -  Switch to use acpi_evaluate_dsm_typed()
 -  aggregator: Rename top-level request functions to avoid ambiguities
 -  aggregator_registry: Fix target-ID of base-hub
 -  aggregator: Enforce use of target-ID enum in device ID macros
 -  dtx: Use target-ID enum instead of hard-coding values
 -  aggregator_tabletsw: Use target-ID enum instead of hard-coding values
 -  aggregator_hub: Use target-ID enum instead of hard-coding values
 -  aggregator: Add target and source IDs to command trace events
 -  aggregator: Improve documentation and handling of message target and source IDs

platform/x86/amd:
 -  pmc: Add line break for readability
 -  pmc: differentiate STB/SMU messaging prints
 -  pmc: Write dummy postcode into the STB DRAM
 -  pmc: Add num_samples message id support to STB

platform/x86/amd/pmf:
 -  Add depends on CONFIG_POWER_SUPPLY

platform/x86/intel:
 -  Intel TPMI enumeration driver

platform/x86/intel/tpmi:
 -  ADD tpmi external interface for tpmi feature drivers
 -  Process CPU package mapping

platform/x86/intel/vsec:
 -  Use mutex for ida_alloc() and ida_free()
 -  Support private data
 -  Enhance and Export intel_vsec_add_aux()
 -  Add TPMI ID

platform_data/mlxreg:
 -  Add field with mapped resource address

think-lmi:
 -  Make kobj_type structure constant
 -  Use min_t() for comparison and assignment

tools/power/x86/intel-speed-select:
 -  v1.14 release
 -  Adjust uncore max/min frequency
 -  Add Emerald Rapid quirk
 -  Fix display of uncore min frequency
 -  turbo-freq auto mode with SMT off
 -  cpufreq reads on offline CPUs
 -  Use null-terminated string
 -  Remove duplicate dup()
 -  Handle open() failure case
 -  Remove unused non_block flag
 -  Remove wrong check in set_isst_id()

x86/platform/uv:
 -  Make kobj_type structure constant

----------------------------------------------------------------
Andy Shevchenko (5):
      platform/surface: Switch to use acpi_evaluate_dsm_typed()
      platform/x86: intel/pmc: Switch to use acpi_evaluate_dsm_typed()
      platform/x86: int1092: Switch to use acpi_evaluate_dsm_typed()
      platform/x86: Fix header inclusion in linux/platform_data/x86/soc.h
      platform/x86: Add include/linux/platform_data/x86 to MAINTAINERS

Armin Wolf (6):
      platform/x86: dell-ddv: Add support for interface version 3
      platform/x86: dell-ddv: Return error if buffer is empty
      platform/x86: dell-ddv: Replace EIO with ENOMSG
      platform/x86: dell-ddv: Add "force" module param
      platform/x86: dell-ddv: Add hwmon support
      platform/x86: dell-ddv: Prefer asynchronous probing

Arnd Bergmann (1):
      platform/x86: int3472/discrete: add LEDS_CLASS dependency

Deepak R Varma (2):
      platform/x86: dell-smo8800: Use min_t() for comparison and assignment
      platform/x86: think-lmi: Use min_t() for comparison and assignment

Hans de Goede (13):
      leds: led-class: Add missing put_device() to led_put()
      leds: led-class: Add led_module_get() helper
      leds: led-class: Add __devm_led_get() helper
      leds: led-class: Add generic [devm_]led_get()
      platform/x86: apple_gmux: Drop no longer used ACPI_VIDEO Kconfig dependency
      Merge tag 'ib-leds-led_get-v6.3' into HEAD
      media: v4l2-core: Make the v4l2-core code enable/disable the privacy LED if present
      platform/x86: int3472/discrete: Refactor GPIO to sensor mapping
      platform/x86: int3472/discrete: Create a LED class device for the privacy LED
      platform/x86: int3472/discrete: Move GPIO request to skl_int3472_register_clock()
      platform/x86: int3472/discrete: Get the polarity from the _DSM entry
      platform/x86: int3472/discrete: Drop unnecessary obj->type == string check
      platform/x86: nvidia-wmi-ec-backlight: Add force module parameter

Maximilian Luz (9):
      platform/surface: aggregator: Improve documentation and handling of message target and source IDs
      platform/surface: aggregator: Add target and source IDs to command trace events
      platform/surface: aggregator_hub: Use target-ID enum instead of hard-coding values
      platform/surface: aggregator_tabletsw: Use target-ID enum instead of hard-coding values
      platform/surface: dtx: Use target-ID enum instead of hard-coding values
      HID: surface-hid: Use target-ID enum instead of hard-coding values
      platform/surface: aggregator: Enforce use of target-ID enum in device ID macros
      platform/surface: aggregator_registry: Fix target-ID of base-hub
      platform/surface: aggregator: Rename top-level request functions to avoid ambiguities

Rishit Bansal (1):
      platform/x86: hp-wmi: Ignore Win-Lock key events

Shyam Sundar S K (5):
      platform/x86/amd: pmc: Add num_samples message id support to STB
      platform/x86/amd: pmc: Write dummy postcode into the STB DRAM
      platform/x86/amd: pmc: differentiate STB/SMU messaging prints
      platform/x86/amd: pmc: Add line break for readability
      platform/x86/amd/pmf: Add depends on CONFIG_POWER_SUPPLY

Srinivas Pandruvada (13):
      tools/power/x86/intel-speed-select: cpufreq reads on offline CPUs
      tools/power/x86/intel-speed-select: turbo-freq auto mode with SMT off
      tools/power/x86/intel-speed-select: Fix display of uncore min frequency
      tools/power/x86/intel-speed-select: Adjust uncore max/min frequency
      tools/power/x86/intel-speed-select: v1.14 release
      platform/x86/intel/vsec: Add TPMI ID
      platform/x86/intel/vsec: Enhance and Export intel_vsec_add_aux()
      platform/x86/intel/vsec: Support private data
      platform/x86/intel: Intel TPMI enumeration driver
      platform/x86/intel/tpmi: Process CPU package mapping
      platform/x86/intel/tpmi: ADD tpmi external interface for tpmi feature drivers
      MAINTAINERS: Add entry for TPMI driver
      platform/x86/intel/vsec: Use mutex for ida_alloc() and ida_free()

Thomas Weißschuh (4):
      platform/x86: dell-wmi-sysman: Make kobj_type structure constant
      platform/x86: think-lmi: Make kobj_type structure constant
      x86/platform/uv: Make kobj_type structure constant
      MAINTAINERS: dell-wmi-sysman: drop Divya Bharathi

Uwe Kleine-König (3):
      platform/x86: acerhdf: Drop empty platform remove function
      platform/x86: intel: oaktrail: Drop empty platform remove function
      platform/x86: intel: punit_ipc: Drop empty platform remove function

Vadim Pasternak (13):
      platform: mellanox: Introduce support for rack manager switch
      platform: mellanox: Change "reset_pwr_converter_fail" attribute
      platform: mellanox: Cosmetic changes - rename to more common name
      platform: mellanox: Introduce support for next-generation 800GB/s switch
      platform: mellanox: Introduce support of new Nvidia L1 switch
      platform: mellanox: Split initialization procedure
      platform: mellanox: Split logic in init and exit flow
      platform: mellanox: Extend all systems with I2C notification callback
      platform/mellanox: mlxreg-hotplug: Allow more flexible hotplug events configuration
      platform_data/mlxreg: Add field with mapped resource address
      platform: mellanox: mlx-platform: Add mux selection register to regmap
      platform: mellanox: mlx-platform: Move bus shift assignment out of the loop
      Documentation/ABI: Add new attribute for mlxreg-io sysfs interfaces

Zhang Rui (6):
      tools/power/x86/intel-speed-select: Remove wrong check in set_isst_id()
      tools/power/x86/intel-speed-select: Remove unused non_block flag
      tools/power/x86/intel-speed-select: Handle open() failure case
      tools/power/x86/intel-speed-select: Remove duplicate dup()
      tools/power/x86/intel-speed-select: Use null-terminated string
      tools/power/x86/intel-speed-select: Add Emerald Rapid quirk

 Documentation/ABI/stable/sysfs-driver-mlxreg-io    |  122 +-
 .../driver-api/surface_aggregator/client.rst       |   12 +-
 .../driver-api/surface_aggregator/ssh.rst          |   36 +-
 MAINTAINERS                                        |    9 +-
 drivers/hid/surface-hid/surface_hid.c              |    8 +-
 drivers/hid/surface-hid/surface_kbd.c              |    8 +-
 drivers/leds/led-class.c                           |  138 +-
 drivers/media/v4l2-core/v4l2-async.c               |    4 +
 drivers/media/v4l2-core/v4l2-fwnode.c              |    7 +
 drivers/media/v4l2-core/v4l2-subdev-priv.h         |   14 +
 drivers/media/v4l2-core/v4l2-subdev.c              |   46 +
 drivers/platform/mellanox/mlxreg-hotplug.c         |   28 +-
 drivers/platform/surface/aggregator/bus.c          |    6 +-
 drivers/platform/surface/aggregator/controller.c   |   44 +-
 drivers/platform/surface/aggregator/ssh_msgb.h     |    4 +-
 .../surface/aggregator/ssh_request_layer.c         |   11 +-
 drivers/platform/surface/aggregator/trace.h        |   73 +-
 drivers/platform/surface/surface_acpi_notify.c     |    2 +-
 drivers/platform/surface/surface_aggregator_cdev.c |    6 +-
 drivers/platform/surface/surface_aggregator_hub.c  |    8 +-
 .../platform/surface/surface_aggregator_registry.c |    2 +-
 .../platform/surface/surface_aggregator_tabletsw.c |   12 +-
 drivers/platform/surface/surface_dtx.c             |   20 +-
 drivers/platform/surface/surface_hotplug.c         |   13 +-
 .../platform/surface/surface_platform_profile.c    |    2 +-
 drivers/platform/x86/Kconfig                       |    1 -
 drivers/platform/x86/acerhdf.c                     |    6 -
 drivers/platform/x86/amd/pmc.c                     |   40 +-
 drivers/platform/x86/amd/pmf/Kconfig               |    1 +
 drivers/platform/x86/dell/Kconfig                  |    8 +-
 drivers/platform/x86/dell/dell-smo8800.c           |    5 +-
 drivers/platform/x86/dell/dell-wmi-ddv.c           |  528 +++++++-
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c |    2 +-
 drivers/platform/x86/hp/hp-wmi.c                   |    2 +
 drivers/platform/x86/intel/Kconfig                 |   13 +
 drivers/platform/x86/intel/Makefile                |    4 +
 drivers/platform/x86/intel/int1092/intel_sar.c     |   15 +-
 drivers/platform/x86/intel/int3472/Kconfig         |    1 +
 drivers/platform/x86/intel/int3472/Makefile        |    2 +-
 .../platform/x86/intel/int3472/clk_and_regulator.c |   34 +-
 drivers/platform/x86/intel/int3472/common.h        |   18 +-
 drivers/platform/x86/intel/int3472/discrete.c      |  108 +-
 drivers/platform/x86/intel/int3472/led.c           |   75 ++
 drivers/platform/x86/intel/oaktrail.c              |    6 -
 drivers/platform/x86/intel/pmc/tgl.c               |    6 +-
 drivers/platform/x86/intel/punit_ipc.c             |    6 -
 drivers/platform/x86/intel/tpmi.c                  |  415 ++++++
 drivers/platform/x86/intel/vsec.c                  |   30 +-
 drivers/platform/x86/intel/vsec.h                  |    6 +
 drivers/platform/x86/mlx-platform.c                | 1394 +++++++++++++++++---
 drivers/platform/x86/nvidia-wmi-ec-backlight.c     |    6 +-
 drivers/platform/x86/think-lmi.c                   |    8 +-
 drivers/platform/x86/uv_sysfs.c                    |    6 +-
 drivers/power/supply/surface_battery.c             |    4 +-
 drivers/power/supply/surface_charger.c             |    2 +-
 include/linux/intel_tpmi.h                         |   30 +
 include/linux/leds.h                               |   21 +
 include/linux/platform_data/mlxreg.h               |    2 +
 include/linux/platform_data/x86/soc.h              |    7 +-
 include/linux/surface_aggregator/controller.h      |   60 +-
 include/linux/surface_aggregator/device.h          |   58 +-
 include/linux/surface_aggregator/serial_hub.h      |   40 +-
 include/media/v4l2-subdev.h                        |    4 +
 tools/power/x86/intel-speed-select/hfi-events.c    |    4 -
 tools/power/x86/intel-speed-select/isst-config.c   |   82 +-
 tools/power/x86/intel-speed-select/isst-core.c     |   23 +
 tools/power/x86/intel-speed-select/isst-daemon.c   |    3 +-
 tools/power/x86/intel-speed-select/isst-display.c  |   11 +-
 tools/power/x86/intel-speed-select/isst.h          |    4 +
 69 files changed, 3174 insertions(+), 562 deletions(-)
 create mode 100644 drivers/media/v4l2-core/v4l2-subdev-priv.h
 create mode 100644 drivers/platform/x86/intel/int3472/led.c
 create mode 100644 drivers/platform/x86/intel/tpmi.c
 create mode 100644 include/linux/intel_tpmi.h

