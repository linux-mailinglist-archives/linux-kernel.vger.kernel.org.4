Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D37649B8F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiLLKCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiLLKB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:01:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBA3A47F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670839258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=67gB3ORosS0ConpkZZBUUcq/aPiALtghA9gZOPG9rz4=;
        b=KUSH+S1yCCvSK3upnwDg5+EUWJXTEL8FJKBYjsXY55SvsTazDtLMDStM2vJm60ODrpS8da
        xFiCZWehxC/Iqy9S0WbM7hei8n8OWlfrQV7Hz8KRv8Xec2RcPHLenzN9t+8YO7/DSygyXU
        SeZDL6aNpHsUSl0O0shgBkS9xd8OcVQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-76-_WdhcJjoOmSYA1QnHgb8EQ-1; Mon, 12 Dec 2022 05:00:56 -0500
X-MC-Unique: _WdhcJjoOmSYA1QnHgb8EQ-1
Received: by mail-ed1-f71.google.com with SMTP id t4-20020a056402524400b004620845ba7bso4712672edd.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:00:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=67gB3ORosS0ConpkZZBUUcq/aPiALtghA9gZOPG9rz4=;
        b=Dh43ar0ahWxQ5QhwAol9xELnvCr4iTx4A992uBuzjmOSqvY8CvecisIEleFjQDhLTo
         1+ZCiiCKEzmFDUgvMlrhjEVoE4BXDqltIySYFYiLJwm81r/iYsmAFHPn8HoAY+5QLS3I
         TzlDaLkYL6PnIbib/TS+KQW7Fh7aBO1s1pY6J7FCwjESkApMl19SmvDTTXmjk6PvHPEW
         DP5D/0+mPbsECyWImwvVWdIIwKx+gBN4Ommvk0p+KYYPb1ETz8K/7g4Hx/Zfd9BTSd0f
         DO3w1i79dR1tyCtUQX1XZFQNWk8iZP8KFsl+u2wnrZwcCF09D9EJ3G9cnDBHZKQNzHyc
         4lbQ==
X-Gm-Message-State: ANoB5pn+vCJ6B4tgBUWRC8WM4AypCYT/m728CGuf1z34FKvJDsnvBycP
        lhLoqDIwK4fwf3KvjhNX6vWcgozmbjrgzHFfy0ki5q65We2Zy5dYyROFxsakOZbhKHxMarWQCgI
        0OLXR6NjkUPz+lu40b5m8KM3T
X-Received: by 2002:a17:906:6d52:b0:7c1:5b5e:4d78 with SMTP id a18-20020a1709066d5200b007c15b5e4d78mr5966831ejt.51.1670839255518;
        Mon, 12 Dec 2022 02:00:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5JK48J5z+UL651hesYs4aH847Oakcryrboz47IPA5WronTjS8o5jnkwcA19MKr6IO78q9nfw==
X-Received: by 2002:a17:906:6d52:b0:7c1:5b5e:4d78 with SMTP id a18-20020a1709066d5200b007c15b5e4d78mr5966809ejt.51.1670839255278;
        Mon, 12 Dec 2022 02:00:55 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id b10-20020a17090630ca00b0073dbaeb50f6sm3086863ejb.169.2022.12.12.02.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 02:00:54 -0800 (PST)
Message-ID: <4bbe54cb-744a-eb84-df67-024e01b9501e@redhat.com>
Date:   Mon, 12 Dec 2022 11:00:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.2-1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
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

Here is the main PDx86 PR for 6.2.

Highlights:
 -  Intel:
    -  PMC: Add support for Meteor Lake
    -  Intel On Demand: various updates
 -  ideapad-laptop:
    -  Add support for various Fn keys on new models
    -  Fix touchpad on/off handling in a generic way to avoid having
       to add more and more quirks
 -  android-x86-tablets: Add support for 2 more X86 Android tablet models
 -  New Dell WMI DDV driver
 -  Miscellaneous cleanups and small bugfixes

I am aware of one small conflict with the linx-pm/acpi tree due to one
ACPI battery change being in my tree as dependency of other patches.

Here is the conflict report + resolution from Stephen:

"""
Today's linux-next merge of the drivers-x86 tree got a conflict in:

  drivers/acpi/battery.c

between commit:

  98b0cf207b61 ("ACPI: battery: Call power_supply_changed() when adding hooks")

from the pm tree and commit:

  878a82c23469 ("ACPI: battery: Pass battery hook pointer to hook callbacks")

from the drivers-x86 tree.

diff --cc drivers/acpi/battery.c
index 883c75757400,9482b0b6eadc..000000000000
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@@ -696,8 -696,7 +696,8 @@@ static void __battery_hook_unregister(s
  	if (lock)
  		mutex_lock(&hook_mutex);
  	list_for_each_entry(battery, &acpi_battery_list, list) {
- 		if (!hook->remove_battery(battery->bat))
 -		hook->remove_battery(battery->bat, hook);
++		if (!hook->remove_battery(battery->bat, hook))
 +			power_supply_changed(battery->bat);
  	}
  	list_del(&hook->list);
  	if (lock)
"""


Regards,

Hans



The following changes since commit b44fd994e45112b58b6c1dec4451d9a925784589:

  platform/x86: ideapad-laptop: Add module parameters to match DMI quirk tables (2022-11-16 08:47:08 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.2-1

for you to fetch changes up to b0b698b80c56b0712f0d4346d51bf0363ba03068:

  platform/mellanox: mlxbf-pmc: Fix event typo (2022-12-12 10:31:27 +0100)

----------------------------------------------------------------
platform-drivers-x86 for v6.2-1

Highlights:
 -  Intel:
    -  PMC: Add support for Meteor Lake
    -  Intel On Demand: various updates
 -  ideapad-laptop:
    -  Add support for various Fn keys on new models
    -  Fix touchpad on/off handling in a generic way to avoid having
       to add more and more quirks
 -  android-x86-tablets: Add support for 2 more X86 Android tablet models
 -  New Dell WMI DDV driver
 -  Miscellaneous cleanups and small bugfixes

The following is an automated git shortlog grouped by driver:

ACPI:
 -  battery: Pass battery hook pointer to hook callbacks

ISST:
 -  Fix typo in comments

Move existing HP drivers to a new hp subdir:
 - Move existing HP drivers to a new hp subdir

dell:
 -  Add new dell-wmi-ddv driver

dell-ddv:
 -  Warn if ePPID has a suspicious length
 -  Improve buffer handling

huawei-wmi:
 -  remove unnecessary member
 -  fix return value calculation
 -  do not hard-code sizes

ideapad-laptop:
 -  Make touchpad_ctrl_via_ec a module option
 -  Stop writing VPCCMD_W_TOUCHPAD at probe time
 -  Send KEY_TOUCHPAD_TOGGLE on some models
 -  Only toggle ps2 aux port on/off on select models
 -  Do not send KEY_TOUCHPAD* events on probe / resume
 -  Refactor ideapad_sync_touchpad_state()
 -  support for more special keys in WMI
 -  Add new _CFG bit numbers for future use
 -  Revert "check for touchpad support in _CFG"

intel/pmc:
 -  Relocate Alder Lake PCH support
 -  Relocate Tiger Lake PCH support
 -  Relocate Ice Lake PCH support
 -  Relocate Cannon Lake Point PCH support
 -  Relocate Sunrise Point PCH support
 -  Move variable declarations and definitions to header and core.c
 -  Replace all the reg_map with init functions

intel/pmc/core:
 -  Add Meteor Lake support to pmc core driver

intel_scu_ipc:
 -  fix possible name leak in __intel_scu_ipc_register()

mxm-wmi:
 -  fix memleak in mxm_wmi_call_mx[ds|mx]()

platform/mellanox:
 -  mlxbf-pmc: Fix event typo
 -  Add BlueField-3 support in the tmfifo driver

platform/x86/amd:
 -  pmc: Add a workaround for an s0i3 issue on Cezanne

platform/x86/amd/pmf:
 -  pass the struct by reference

platform/x86/dell:
 -  alienware-wmi: Use sysfs_emit() instead of scnprintf()

platform/x86/intel:
 -  pmc: Fix repeated word in comment

platform/x86/intel/hid:
 -  Add module-params for 5 button array + SW_TABLET_MODE reporting

platform/x86/intel/sdsi:
 -  Add meter certificate support
 -  Support different GUIDs
 -  Hide attributes if hardware doesn't support
 -  Add Intel On Demand text

sony-laptop:
 -  Convert to use sysfs_emit_at() API

thinkpad_acpi:
 -  use strstarts()
 -  Fix max_brightness of thinklight

tools/arch/x86:
 -  intel_sdsi: Add support for reading meter certificates
 -  intel_sdsi: Add support for new GUID
 -  intel_sdsi: Read more On Demand registers
 -  intel_sdsi: Add Intel On Demand text
 -  intel_sdsi: Add support for reading state certificates

uv_sysfs:
 -  Use sysfs_emit() instead of scnprintf()

wireless-hotkey:
 -  use ACPI HID as phys

x86-android-tablets:
 -  Add Advantech MICA-071 extra button
 -  Add Lenovo Yoga Tab 3 (YT3-X90F) charger + fuel-gauge data
 -  Add Medion Lifetab S10346 data

----------------------------------------------------------------
Alex Hung (1):
      platform/x86: wireless-hotkey: use ACPI HID as phys

Armin Wolf (4):
      ACPI: battery: Pass battery hook pointer to hook callbacks
      platform/x86: dell: Add new dell-wmi-ddv driver
      platform/x86: dell-ddv: Improve buffer handling
      platform/x86: dell-ddv: Warn if ePPID has a suspicious length

Barnabás Pőcze (4):
      platform/x86: huawei-wmi: do not hard-code sizes
      platform/x86: huawei-wmi: fix return value calculation
      platform/x86: huawei-wmi: remove unnecessary member
      platform/x86: thinkpad_acpi: use strstarts()

David E. Box (9):
      platform/x86/intel/sdsi: Add Intel On Demand text
      platform/x86/intel/sdsi: Hide attributes if hardware doesn't support
      platform/x86/intel/sdsi: Support different GUIDs
      platform/x86/intel/sdsi: Add meter certificate support
      tools/arch/x86: intel_sdsi: Add support for reading state certificates
      tools/arch/x86: intel_sdsi: Add Intel On Demand text
      tools/arch/x86: intel_sdsi: Read more On Demand registers
      tools/arch/x86: intel_sdsi: Add support for new GUID
      tools/arch/x86: intel_sdsi: Add support for reading meter certificates

Eray Orçunus (2):
      platform/x86: ideapad-laptop: Revert "check for touchpad support in _CFG"
      platform/x86: ideapad-laptop: Add new _CFG bit numbers for future use

Gayatri Kammela (4):
      platform/x86: intel/pmc: Replace all the reg_map with init functions
      platform/x86: intel/pmc: Relocate Tiger Lake PCH support
      platform/x86: intel/pmc: Relocate Alder Lake PCH support
      platform/x86: intel/pmc/core: Add Meteor Lake support to pmc core driver

Hans de Goede (11):
      platform/x86: thinkpad_acpi: Fix max_brightness of thinklight
      platform/x86: ideapad-laptop: Refactor ideapad_sync_touchpad_state()
      platform/x86: ideapad-laptop: Do not send KEY_TOUCHPAD* events on probe / resume
      platform/x86: ideapad-laptop: Only toggle ps2 aux port on/off on select models
      platform/x86: ideapad-laptop: Send KEY_TOUCHPAD_TOGGLE on some models
      platform/x86: ideapad-laptop: Stop writing VPCCMD_W_TOUCHPAD at probe time
      platform/x86: ideapad-laptop: Make touchpad_ctrl_via_ec a module option
      platform/x86/intel/hid: Add module-params for 5 button array + SW_TABLET_MODE reporting
      platform/x86: x86-android-tablets: Add Medion Lifetab S10346 data
      platform/x86: x86-android-tablets: Add Lenovo Yoga Tab 3 (YT3-X90F) charger + fuel-gauge data
      platform/x86: x86-android-tablets: Add Advantech MICA-071 extra button

James Hurley (1):
      platform/mellanox: mlxbf-pmc: Fix event typo

Jilin Yuan (1):
      platform/x86/intel: pmc: Fix repeated word in comment

Jorge Lopez (1):
      platform/x86: Move existing HP drivers to a new hp subdir

Liming Sun (1):
      platform/mellanox: Add BlueField-3 support in the tmfifo driver

Mario Limonciello (1):
      platform/x86/amd: pmc: Add a workaround for an s0i3 issue on Cezanne

Muhammad Usama Anjum (1):
      platform/x86/amd/pmf: pass the struct by reference

Philipp Jungkamp (1):
      platform/x86: ideapad-laptop: support for more special keys in WMI

Rajvi Jingar (1):
      platform/x86: intel/pmc: Relocate Sunrise Point PCH support

Xi Pardee (3):
      platform/x86: intel/pmc: Move variable declarations and definitions to header and core.c
      platform/x86: intel/pmc: Relocate Cannon Lake Point PCH support
      platform/x86: intel/pmc: Relocate Ice Lake PCH support

Yang Yingliang (1):
      platform/x86: intel_scu_ipc: fix possible name leak in __intel_scu_ipc_register()

Yu Liao (1):
      platform/x86: mxm-wmi: fix memleak in mxm_wmi_call_mx[ds|mx]()

chen zhang (1):
      platform/x86: ISST: Fix typo in comments

ye xingchen (3):
      platform/x86: uv_sysfs: Use sysfs_emit() instead of scnprintf()
      platform/x86/dell: alienware-wmi: Use sysfs_emit() instead of scnprintf()
      platform/x86: sony-laptop: Convert to use sysfs_emit_at() API

 Documentation/ABI/testing/debugfs-dell-wmi-ddv     |  21 +
 Documentation/ABI/testing/sysfs-driver-intel_sdsi  |  47 +-
 .../ABI/testing/sysfs-platform-dell-wmi-ddv        |   7 +
 MAINTAINERS                                        |  11 +-
 drivers/acpi/battery.c                             |   8 +-
 drivers/platform/mellanox/mlxbf-pmc.c              |   2 +-
 drivers/platform/mellanox/mlxbf-tmfifo-regs.h      |  10 +
 drivers/platform/mellanox/mlxbf-tmfifo.c           |  86 +-
 drivers/platform/x86/Kconfig                       |  43 +-
 drivers/platform/x86/Makefile                      |   4 +-
 drivers/platform/x86/amd/pmc.c                     |   6 +
 drivers/platform/x86/amd/pmf/cnqf.c                |  92 +-
 drivers/platform/x86/asus-wmi.c                    |   4 +-
 drivers/platform/x86/dell/Kconfig                  |  13 +
 drivers/platform/x86/dell/Makefile                 |   1 +
 drivers/platform/x86/dell/alienware-wmi.c          |  41 +-
 drivers/platform/x86/dell/dell-wmi-ddv.c           | 375 ++++++++
 drivers/platform/x86/hp/Kconfig                    |  63 ++
 drivers/platform/x86/hp/Makefile                   |  10 +
 drivers/platform/x86/{ => hp}/hp-wmi.c             |   0
 drivers/platform/x86/{ => hp}/hp_accel.c           |   2 +-
 drivers/platform/x86/{ => hp}/tc1100-wmi.c         |   0
 drivers/platform/x86/huawei-wmi.c                  |  51 +-
 drivers/platform/x86/ideapad-laptop.c              | 388 +++++---
 drivers/platform/x86/intel/Kconfig                 |   8 +-
 drivers/platform/x86/intel/hid.c                   |  36 +-
 drivers/platform/x86/intel/pmc/Makefile            |   3 +-
 drivers/platform/x86/intel/pmc/adl.c               | 325 +++++++
 drivers/platform/x86/intel/pmc/cnp.c               | 210 +++++
 drivers/platform/x86/intel/pmc/core.c              | 994 ++-------------------
 drivers/platform/x86/intel/pmc/core.h              |  91 +-
 drivers/platform/x86/intel/pmc/icl.c               |  56 ++
 drivers/platform/x86/intel/pmc/mtl.c               |  52 ++
 drivers/platform/x86/intel/pmc/spt.c               | 140 +++
 drivers/platform/x86/intel/pmc/tgl.c               | 269 ++++++
 drivers/platform/x86/intel/sdsi.c                  | 136 ++-
 .../x86/intel/speed_select_if/isst_if_common.c     |   2 +-
 drivers/platform/x86/intel_scu_ipc.c               |   2 +-
 drivers/platform/x86/lg-laptop.c                   |   4 +-
 drivers/platform/x86/mxm-wmi.c                     |   8 +-
 drivers/platform/x86/sony-laptop.c                 |  10 +-
 drivers/platform/x86/system76_acpi.c               |   4 +-
 drivers/platform/x86/thinkpad_acpi.c               |  63 +-
 drivers/platform/x86/toshiba_acpi.c                |   4 +-
 drivers/platform/x86/uv_sysfs.c                    |  16 +-
 drivers/platform/x86/wireless-hotkey.c             |  60 +-
 drivers/platform/x86/wmi.c                         |   1 +
 drivers/platform/x86/x86-android-tablets.c         | 285 +++++-
 include/acpi/battery.h                             |   4 +-
 tools/arch/x86/intel_sdsi/intel_sdsi.c             | 464 ++++++++--
 50 files changed, 3080 insertions(+), 1452 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-dell-wmi-ddv
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dell-wmi-ddv
 create mode 100644 drivers/platform/x86/dell/dell-wmi-ddv.c
 create mode 100644 drivers/platform/x86/hp/Kconfig
 create mode 100644 drivers/platform/x86/hp/Makefile
 rename drivers/platform/x86/{ => hp}/hp-wmi.c (100%)
 rename drivers/platform/x86/{ => hp}/hp_accel.c (99%)
 rename drivers/platform/x86/{ => hp}/tc1100-wmi.c (100%)
 create mode 100644 drivers/platform/x86/intel/pmc/adl.c
 create mode 100644 drivers/platform/x86/intel/pmc/cnp.c
 create mode 100644 drivers/platform/x86/intel/pmc/icl.c
 create mode 100644 drivers/platform/x86/intel/pmc/mtl.c
 create mode 100644 drivers/platform/x86/intel/pmc/spt.c
 create mode 100644 drivers/platform/x86/intel/pmc/tgl.c

