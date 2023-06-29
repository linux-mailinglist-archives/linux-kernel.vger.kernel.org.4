Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBB874234D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 11:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjF2JbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 05:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjF2Jah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:30:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F2A3C05
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 02:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688030939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=955+Kq98f8CLQi/jJ/hEW+R9CkrTP74NQn+BrJDShZM=;
        b=E/Jp0pIcf1fVjpYYM8n7ZHD22RXFi0t0KF4QJxx9L+NLLzUm/RBkRXx3i1jz1RXH0tOlz6
        yrgKagDsTVca7VvvZ6miKz1+vRR7JpWCzDs2EQA4+J2AXdeQKMiD+5H4pRRAEh3NKaMf00
        vsN47jialJ2vgwndTSi9Eimr0B7k93M=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-QkD-pq1qNdKOQ5nLAmMP7g-1; Thu, 29 Jun 2023 05:28:57 -0400
X-MC-Unique: QkD-pq1qNdKOQ5nLAmMP7g-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-51866148986so357198a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 02:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688030936; x=1690622936;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=955+Kq98f8CLQi/jJ/hEW+R9CkrTP74NQn+BrJDShZM=;
        b=QA1hwE4U+NMz02lVywofW9YfwggDi8OMIbo729VcM+4Oov4KXC84UhDKhgmTBrHt+b
         7UPLpS/jskEXrI6MLjlsg+pW4s9xSLbgKybum+nmddyLtEKcSffhH6M4QQ71MB90oo7B
         vpilhlK3PFUcXgpU0yzs7qHk3h9qaZ90SDq3/yfDlIbTRrmbnfkbpndWIU5bbh5rUWZZ
         vu7DudrFuM743usM0JVljTLikP27T06XWP6/kIwzeZkMZR0jmVbg6Yq1VTiRn9kh4ZZR
         YMvs4JyQrRhC879bBHxZuBFpl/E+vPZy8aFObwf4rXLOFRZysleyULLtbi/kxmkCoRMG
         C1xg==
X-Gm-Message-State: AC+VfDwLJtpF2JGJx65W6ORhlE145cRDbGwoFyvhwawyRerrAz9oMjZ9
        ykvgW1Vwh0ZQweCUTEMOrn2JmF2CwaWmCPrX/BqW3xs64C9qi0IFtWv/rMTUhZXIIXrHd3Bm5xv
        cm+5mC4igRDPpU04wUs+t/pVp
X-Received: by 2002:a17:907:a01:b0:973:d1ce:dbe8 with SMTP id bb1-20020a1709070a0100b00973d1cedbe8mr31023259ejc.46.1688030935749;
        Thu, 29 Jun 2023 02:28:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4vak+8zHnj//9SSiG+sO2uxcWl9j5R8AGnX0hjo8m+RnHQS66W4wcYSvri8fb3NfhSuKFSAA==
X-Received: by 2002:a17:907:a01:b0:973:d1ce:dbe8 with SMTP id bb1-20020a1709070a0100b00973d1cedbe8mr31023247ejc.46.1688030935373;
        Thu, 29 Jun 2023 02:28:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id e21-20020a170906c01500b009929ab17bdfsm1098044ejz.168.2023.06.29.02.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 02:28:54 -0700 (PDT)
Message-ID: <a3486764-fdb3-5df2-e3be-c0262768ce0d@redhat.com>
Date:   Thu, 29 Jun 2023 11:28:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.5-1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the main PDx86 PR for 6.5.

Highlights:
 -  AMD PMC and PMF drivers:
    - Various bugfixes
    - Improved debugging support
 -  Intel PMC:
    - Refactor to support hw with multiple PMCs
    - Various other improvements / new hw support
 -  Intel Speed Select Technology (ISST):
    - TPMI Uncore Frequency + Cluster Level Power Controls
    - Various bugfixes
    - tools/intel-speed-select: Misc. improvements
 -  Dell-DDV: Add documentation
 -  INT3472 ACPI camera sensor glue code:
    - Evaluate device's _DSM method to control imaging clock
    - Drop the need to have a table with per sensor-model info
 -  Lenovo Yogabook: Refactor / rework to also support Android models
 -  Think-LMI: Multiple improvements and fixes
 -  WMI: Add proper API documentation for the WMI bus
 -  x86-android-tablets: Misc. new hw support
 -  Miscellaneous other cleanups / fixes


Regards,

Hans


The following changes since commit 3d43f9f639542fadfb28f40b509bf147a6624d48:

  platform/mellanox: fix potential race in mlxbf-tmfifo driver (2023-05-09 11:54:35 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.5-1

for you to fetch changes up to d2a7bd3690990ab8a8239096ee432ad51985d5b6:

  platform/x86:intel/pmc: Add Meteor Lake IOE-M PMC related maps (2023-06-20 12:51:08 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.5-1

Highlights:
 -  AMD PMC and PMF drivers:
    - Various bugfixes
    - Improved debugging support
 -  Intel PMC:
    - Refactor to support hw with multiple PMCs
    - Various other improvements / new hw support
 -  Intel Speed Select Technology (ISST):
    - TPMI Uncore Frequency + Cluster Level Power Controls
    - Various bugfixes
    - tools/intel-speed-select: Misc. improvements
 -  Dell-DDV: Add documentation
 -  INT3472 ACPI camera sensor glue code:
    - Evaluate device's _DSM method to control imaging clock
    - Drop the need to have a table with per sensor-model info
 -  Lenovo Yogabook: Refactor / rework to also support Android models
 -  Think-LMI: Multiple improvements and fixes
 -  WMI: Add proper API documentation for the WMI bus
 -  x86-android-tablets: Misc. new hw support
 -  Miscellaneous other cleanups / fixes

The following is an automated git shortlog grouped by driver:

ISST:
 -  Fix usage counter
 -  Reset default callback on unregister

Merge remote-tracking branch 'intel-speed-select/intel-sst' into review-hans:
 - Merge remote-tracking branch 'intel-speed-select/intel-sst' into review-hans

apple-gmux:
 -  don't use be32_to_cpu and cpu_to_be32

asus-tf103c-dock:
 -  Switch back to use struct i2c_driver's .probe()

dell-ddv:
 -  Update ABI documentation
 -  Add documentation

dell-sysman:
 -  Improve instance detection

gigabyte:
 -  constify pointers to hwmon_channel_info

gigabyte-wmi:
 -  remove allowlist

hp:
 -  constify pointers to hwmon_channel_info

hp-wmi:
 -  Add thermal profile for Victus 16-d1xxx
 -  Add HP Envy special key support
 -  Add HP WMI camera switch

int3472:
 -  discrete: Log a warning if the pin-numbers don't match
 -  discrete: Use FIELD_GET() on the GPIO _DSM return value
 -  discrete: Add alternative "AVDD" regulator supply name
 -  discrete: Add support for 1 GPIO regulator shared between 2 sensors
 -  discrete: Remove sensor_config-s
 -  discrete: Drop GPIO remapping support
 -  Switch back to use struct i2c_driver's .probe()
 -  Evaluate device's _DSM method to control imaging clock

intel/pmc:
 -  Add Meteor Lake IOE-M PMC related maps
 -  Add Meteor Lake IOE-P PMC related maps
 -  Use SSRAM to discover pwrm base address of primary PMC
 -  Discover PMC devices
 -  Enable debugfs multiple PMC support
 -  Add support to handle multiple PMCs
 -  Combine core_init() and core_configure()
 -  Update maps for Meteor Lake P/M platforms
 -  Remove Meteor Lake S platform support

lenovo-yogabook:
 -  add I2C dependency
 -  Rename lenovo-yogabook-wmi to lenovo-yogabook
 -  Add keyboard backlight control to platform driver
 -  Add platform driver support
 -  Add YB_KBD_BL_MAX define
 -  Group WMI specific code together
 -  Drop _wmi_ from remaining generic symbols
 -  Add a yogabook_toggle_digitizer_mode() helper function
 -  Abstract kbd backlight setting
 -  Stop checking adev->power.state
 -  Split probe() into generic and WMI specific parts
 -  Use PMIC LED driver for pen icon LED control
 -  Add dev local variable to probe()
 -  Store dev instead of wdev in drvdata struct
 -  Switch to DEFINE_SIMPLE_DEV_PM_OPS()
 -  Simplify gpio lookup table cleanup
 -  Set default keyboard backligh brightness on probe()
 -  Reprobe devices on remove()
 -  Fix work race on remove()

mlxbf-bootctl:
 -  Add sysfs file for BlueField boot log

platform/surface:
 -  surface3_power: Switch back to use struct i2c_driver's .probe()

platform/x86/amd:
 -  pmc: Update metrics table info for Pink Sardine
 -  pmc: Add helper function to check the cpu id
 -  pmc: Get STB DRAM size from PMFW
 -  pmc: Pass true/false to bool argument

platform/x86/amd/pmf:
 -  Fix compiler warnings in static slider
 -  Add PMF debug facilities
 -  Add PMF acpi debug support

platform/x86/dell/dell-rbtn:
 -  Fix resources leaking on error path

platform/x86/intel:
 -  tpmi: Remove hardcoded unit and offset

platform/x86/intel-uncore-freq:
 -  tpmi: Provide cluster level control
 -  Support for cluster level controls
 -  Uncore frequency control via TPMI

platform/x86/intel/pmc:
 -  Add resume callback

platform/x86/intel/pmc/mtl:
 -  Put devices in D3 during resume

system76:
 -  constify pointers to hwmon_channel_info

think-lmi:
 -  Don't display unnecessary authentication settings
 -  Correct NVME index default
 -  Correct NVME password handling
 -  Update password fields to use BIT
 -  Update password attribute comments
 -  Correct System password interface
 -  Enable opcode support on BIOS settings
 -  mutex protection around multiple WMI calls

thinkpad_acpi:
 -  Fix lkp-tests warnings for platform profiles

tools/power/x86/intel-speed-select:
 -  v1.16 release
 -  Fix json formatting issue
 -  Adjust scope of core-power config

toshiba:
 -  constify pointers to hwmon_channel_info

wmi:
 -  Allow retrieving the number of WMI object instances
 -  Add device specific documentation
 -  Add documentation
 -  Mark GUID-based WMI interface as deprecated
 -  Add kernel doc comments

x86-android-tablets:
 -  Add support for extra buttons on Cyberbook T116
 -  Add support for more then 1 gpio_key
 -  Add Lenovo Yoga Book lid switch
 -  Fix Bluetooth on Lenovo Yoga Book
 -  Add Nextbook Ares 8A data
 -  Remove unnecessary invalid_aei_gpiochip settings
 -  Add ALS sensor support for Yoga Tablet 2 1050/830 series

----------------------------------------------------------------
Armin Wolf (8):
      platform/x86: wmi: Add kernel doc comments
      platform/x86: wmi: Mark GUID-based WMI interface as deprecated
      platform/x86: wmi: Add documentation
      platform/x86: wmi: Add device specific documentation
      platform/x86: dell-ddv: Add documentation
      platform/x86: dell-ddv: Update ABI documentation
      platform/x86: wmi: Allow retrieving the number of WMI object instances
      platform/x86: dell-sysman: Improve instance detection

Arnd Bergmann (1):
      platform/x86: lenovo-yogabook: add I2C dependency

Bingbu Cao (1):
      platform/x86: int3472: Evaluate device's _DSM method to control imaging clock

David E. Box (3):
      platform/x86/intel/pmc: Add resume callback
      platform/x86/intel/pmc/mtl: Put devices in D3 during resume
      platform/x86:intel/pmc: Discover PMC devices

Hans de Goede (32):
      platform/x86: x86-android-tablets: Add ALS sensor support for Yoga Tablet 2 1050/830 series
      platform/x86: x86-android-tablets: Remove unnecessary invalid_aei_gpiochip settings
      platform/x86: x86-android-tablets: Add Nextbook Ares 8A data
      platform/x86: x86-android-tablets: Fix Bluetooth on Lenovo Yoga Book
      platform/x86: x86-android-tablets: Add Lenovo Yoga Book lid switch
      platform/x86: x86-android-tablets: Add support for more then 1 gpio_key
      platform/x86: x86-android-tablets: Add support for extra buttons on Cyberbook T116
      platform/x86: lenovo-yogabook: Fix work race on remove()
      platform/x86: lenovo-yogabook: Reprobe devices on remove()
      platform/x86: lenovo-yogabook: Set default keyboard backligh brightness on probe()
      platform/x86: lenovo-yogabook: Simplify gpio lookup table cleanup
      platform/x86: lenovo-yogabook: Switch to DEFINE_SIMPLE_DEV_PM_OPS()
      platform/x86: lenovo-yogabook: Store dev instead of wdev in drvdata struct
      platform/x86: lenovo-yogabook: Add dev local variable to probe()
      platform/x86: lenovo-yogabook: Use PMIC LED driver for pen icon LED control
      platform/x86: lenovo-yogabook: Split probe() into generic and WMI specific parts
      platform/x86: lenovo-yogabook: Stop checking adev->power.state
      platform/x86: lenovo-yogabook: Abstract kbd backlight setting
      platform/x86: lenovo-yogabook: Add a yogabook_toggle_digitizer_mode() helper function
      platform/x86: lenovo-yogabook: Drop _wmi_ from remaining generic symbols
      platform/x86: lenovo-yogabook: Group WMI specific code together
      platform/x86: lenovo-yogabook: Add YB_KBD_BL_MAX define
      platform/x86: lenovo-yogabook: Add platform driver support
      platform/x86: lenovo-yogabook: Add keyboard backlight control to platform driver
      platform/x86: lenovo-yogabook: Rename lenovo-yogabook-wmi to lenovo-yogabook
      Merge remote-tracking branch 'intel-speed-select/intel-sst' into review-hans
      platform/x86: int3472: discrete: Drop GPIO remapping support
      platform/x86: int3472: discrete: Remove sensor_config-s
      platform/x86: int3472: discrete: Add support for 1 GPIO regulator shared between 2 sensors
      platform/x86: int3472: discrete: Add alternative "AVDD" regulator supply name
      platform/x86: int3472: discrete: Use FIELD_GET() on the GPIO _DSM return value
      platform/x86: int3472: discrete: Log a warning if the pin-numbers don't match

Jonathan Singer (2):
      platform/x86: hp-wmi: Add HP WMI camera switch
      platform/x86: hp-wmi: Add HP Envy special key support

Krzysztof Kozlowski (4):
      platform/x86: gigabyte: constify pointers to hwmon_channel_info
      platform/x86: hp: constify pointers to hwmon_channel_info
      platform/x86: system76: constify pointers to hwmon_channel_info
      platform/x86: toshiba: constify pointers to hwmon_channel_info

Liming Sun (1):
      mlxbf-bootctl: Add sysfs file for BlueField boot log

Mark Pearson (9):
      platform/x86: think-lmi: mutex protection around multiple WMI calls
      platform/x86: think-lmi: Enable opcode support on BIOS settings
      platform/x86: think-lmi: Correct System password interface
      platform/x86: think-lmi: Update password attribute comments
      platform/x86: think-lmi: Update password fields to use BIT
      platform/x86: think-lmi: Correct NVME password handling
      platform/x86: think-lmi: Correct NVME index default
      platform/x86: think-lmi: Don't display unnecessary authentication settings
      platform/x86: thinkpad_acpi: Fix lkp-tests warnings for platform profiles

Michal Wilczynski (1):
      platform/x86/dell/dell-rbtn: Fix resources leaking on error path

Orlando Chamberlain (1):
      platform/x86: apple-gmux: don't use be32_to_cpu and cpu_to_be32

Shyam Sundar S K (7):
      platform/x86/amd/pmf: Add PMF acpi debug support
      platform/x86/amd/pmf: Add PMF debug facilities
      platform/x86/amd/pmf: Fix compiler warnings in static slider
      platform/x86/amd: pmc: Pass true/false to bool argument
      platform/x86/amd: pmc: Get STB DRAM size from PMFW
      platform/x86/amd: pmc: Add helper function to check the cpu id
      platform/x86/amd: pmc: Update metrics table info for Pink Sardine

Srinivas Pandruvada (9):
      platform/x86/intel-uncore-freq: Uncore frequency control via TPMI
      platform/x86/intel-uncore-freq: Support for cluster level controls
      platform/x86/intel-uncore-freq: tpmi: Provide cluster level control
      tools/power/x86/intel-speed-select: Adjust scope of core-power config
      tools/power/x86/intel-speed-select: Fix json formatting issue
      tools/power/x86/intel-speed-select: v1.16 release
      platform/x86: ISST: Reset default callback on unregister
      platform/x86: ISST: Fix usage counter
      platform/x86/intel: tpmi: Remove hardcoded unit and offset

SungHwan Jung (1):
      platform/x86: hp-wmi: Add thermal profile for Victus 16-d1xxx

Thomas Weißschuh (1):
      platform/x86: gigabyte-wmi: remove allowlist

Uwe Kleine-König (3):
      platform/surface: surface3_power: Switch back to use struct i2c_driver's .probe()
      platform/x86: asus-tf103c-dock: Switch back to use struct i2c_driver's .probe()
      platform/x86: int3472: Switch back to use struct i2c_driver's .probe()

Xi Pardee (8):
      platform/x86:intel/pmc: Remove Meteor Lake S platform support
      platform/x86:intel/pmc: Update maps for Meteor Lake P/M platforms
      platform/x86:intel/pmc: Combine core_init() and core_configure()
      platform/x86:intel/pmc: Add support to handle multiple PMCs
      platform/x86:intel/pmc: Enable debugfs multiple PMC support
      platform/x86:intel/pmc: Use SSRAM to discover pwrm base address of primary PMC
      platform/x86:intel/pmc: Add Meteor Lake IOE-P PMC related maps
      platform/x86:intel/pmc: Add Meteor Lake IOE-M PMC related maps

 Documentation/ABI/stable/sysfs-platform-wmi-bmof   |   7 +
 Documentation/ABI/testing/debugfs-dell-wmi-ddv     |  29 +-
 .../ABI/testing/sysfs-class-firmware-attributes    |   4 +-
 .../ABI/testing/sysfs-platform-dell-wmi-ddv        |   4 +-
 .../ABI/testing/sysfs-platform-mellanox-bootctl    |   9 +
 .../pm/intel_uncore_frequency_scaling.rst          |  57 +-
 Documentation/driver-api/index.rst                 |   1 +
 Documentation/driver-api/wmi.rst                   |  21 +
 Documentation/subsystem-apis.rst                   |   1 +
 Documentation/wmi/acpi-interface.rst               |  96 ++
 Documentation/wmi/devices/dell-wmi-ddv.rst         | 296 +++++++
 Documentation/wmi/devices/index.rst                |  22 +
 Documentation/wmi/devices/wmi-bmof.rst             |  25 +
 Documentation/wmi/index.rst                        |  19 +
 MAINTAINERS                                        |  10 +
 drivers/platform/mellanox/mlxbf-bootctl.c          | 144 ++-
 drivers/platform/surface/surface3_power.c          |   2 +-
 drivers/platform/x86/Kconfig                       |  11 +-
 drivers/platform/x86/Makefile                      |   2 +-
 drivers/platform/x86/amd/pmc.c                     | 123 ++-
 drivers/platform/x86/amd/pmf/Kconfig               |  11 +
 drivers/platform/x86/amd/pmf/auto-mode.c           | 143 +++
 drivers/platform/x86/amd/pmf/cnqf.c                |  75 ++
 drivers/platform/x86/amd/pmf/sps.c                 |  55 ++
 drivers/platform/x86/apple-gmux.c                  |   4 +-
 drivers/platform/x86/asus-tf103c-dock.c            |   2 +-
 drivers/platform/x86/dell/dell-rbtn.c              |  13 +-
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c |  13 +-
 drivers/platform/x86/gigabyte-wmi.c                |  46 +-
 drivers/platform/x86/hp/hp-wmi.c                   | 156 +++-
 .../platform/x86/intel/int3472/clk_and_regulator.c | 164 +++-
 drivers/platform/x86/intel/int3472/common.h        |  28 +-
 drivers/platform/x86/intel/int3472/discrete.c      | 102 +--
 drivers/platform/x86/intel/int3472/tps68470.c      |   2 +-
 drivers/platform/x86/intel/pmc/Makefile            |   4 +-
 drivers/platform/x86/intel/pmc/adl.c               |  16 +-
 drivers/platform/x86/intel/pmc/cnp.c               |  18 +-
 drivers/platform/x86/intel/pmc/core.c              | 487 ++++++----
 drivers/platform/x86/intel/pmc/core.h              | 128 ++-
 drivers/platform/x86/intel/pmc/core_ssram.c        | 133 +++
 drivers/platform/x86/intel/pmc/icl.c               |   7 +-
 drivers/platform/x86/intel/pmc/mtl.c               | 977 ++++++++++++++++++++-
 drivers/platform/x86/intel/pmc/spt.c               |   7 +-
 drivers/platform/x86/intel/pmc/tgl.c               |  21 +-
 .../x86/intel/speed_select_if/isst_if_common.c     |   1 +
 .../x86/intel/speed_select_if/isst_tpmi_core.c     |   2 +
 drivers/platform/x86/intel/tpmi.c                  |   8 +-
 .../platform/x86/intel/uncore-frequency/Kconfig    |   4 +
 .../platform/x86/intel/uncore-frequency/Makefile   |   2 +
 .../uncore-frequency/uncore-frequency-common.c     |  51 +-
 .../uncore-frequency/uncore-frequency-common.h     |  16 +-
 .../intel/uncore-frequency/uncore-frequency-tpmi.c | 413 +++++++++
 .../x86/intel/uncore-frequency/uncore-frequency.c  |   1 +
 drivers/platform/x86/lenovo-yogabook-wmi.c         | 408 ---------
 drivers/platform/x86/lenovo-yogabook.c             | 573 ++++++++++++
 drivers/platform/x86/system76_acpi.c               |   2 +-
 drivers/platform/x86/think-lmi.c                   |  65 +-
 drivers/platform/x86/thinkpad_acpi.c               |   6 +-
 drivers/platform/x86/toshiba_acpi.c                |   2 +-
 drivers/platform/x86/wmi.c                         | 104 ++-
 drivers/platform/x86/x86-android-tablets/asus.c    |   6 +-
 drivers/platform/x86/x86-android-tablets/core.c    |  32 +-
 drivers/platform/x86/x86-android-tablets/dmi.c     |  22 +-
 drivers/platform/x86/x86-android-tablets/lenovo.c  |  41 +-
 drivers/platform/x86/x86-android-tablets/other.c   | 112 ++-
 .../x86/x86-android-tablets/x86-android-tablets.h  |   5 +-
 include/linux/acpi.h                               |   2 +
 include/linux/wmi.h                                |  43 +-
 tools/power/x86/intel-speed-select/isst-config.c   |  13 +-
 .../power/x86/intel-speed-select/isst-core-tpmi.c  |  43 +-
 70 files changed, 4517 insertions(+), 955 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-platform-wmi-bmof
 create mode 100644 Documentation/driver-api/wmi.rst
 create mode 100644 Documentation/wmi/acpi-interface.rst
 create mode 100644 Documentation/wmi/devices/dell-wmi-ddv.rst
 create mode 100644 Documentation/wmi/devices/index.rst
 create mode 100644 Documentation/wmi/devices/wmi-bmof.rst
 create mode 100644 Documentation/wmi/index.rst
 create mode 100644 drivers/platform/x86/intel/pmc/core_ssram.c
 create mode 100644 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
 delete mode 100644 drivers/platform/x86/lenovo-yogabook-wmi.c
 create mode 100644 drivers/platform/x86/lenovo-yogabook.c

