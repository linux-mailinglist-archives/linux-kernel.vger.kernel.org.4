Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7B769F28E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 11:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjBVKQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 05:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBVKQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 05:16:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9682A34C21
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 02:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677060967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nonjNcBFUe7DRxgftJRhdKhFbyh3lHgldEMBryocPu4=;
        b=EU7iEnkkYIai76tdcylK1GYoLqN/MO9RNBOjIh9yYS6slZKDZV8p7I9yB1N7qEyC1yAHZI
        IUHPbtPIAhxYtESnGh73xToXMzbYKA8EPPpRDya9lVj+tiONPwwjKEaMob+2wTMvQUwuix
        Q2BjVt8qAJMs5VeStaJLx90hbZWBklY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-h9F0qdsvMiyRsF6IuoRAAQ-1; Wed, 22 Feb 2023 05:16:04 -0500
X-MC-Unique: h9F0qdsvMiyRsF6IuoRAAQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E20C53810791;
        Wed, 22 Feb 2023 10:16:03 +0000 (UTC)
Received: from mail.corp.redhat.com (unknown [10.45.227.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5695140EBF6;
        Wed, 22 Feb 2023 10:16:02 +0000 (UTC)
Date:   Wed, 22 Feb 2023 11:16:00 +0100
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID for 6.3
Message-ID: <20230222101600.y2npwk4hw3ss3j73@mail.corp.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023022201

to receive HID subsystem queue for 6.3.

Highlights:

=====
- HID-BPF infrastructure: this allows to start using HID-BPF. Note that
  the mechanism to ship HID-BPF program through the kernel tree is still
  not implemented yet (but is planned).
  This should be a no-op for 99% of users. Also we are gaining kselftests
  for the HID tree (Benjamin Tissoires)
- Some UAF fixes in workers when using uhid (Pietro Borrello & Benjamin
  Tissoires)
- Constify hid_ll_driver (Thomas Weißschuh)
- Allow more custom IIO sensors through HID (Philipp Jungkamp)
- Logitech HID++ fixes for scroll wheel, protocol and debug (Bastien Nocera)
- Some new device support: Steam Deck (Vicki Pfau), UClogic (José
  Expósito), Logitech G923 Xbox Edition steering wheel (Walt Holman),
  EVision keyboards (Philippe Valembois)
- other assorted code cleanups and fixes
=====

Thanks.

----------------------------------------------------------------
Allen Ballway (1):
      HID: multitouch: Add quirks for flipped axes

Andy Shevchenko (2):
      HID: i2c-hid: acpi: Drop unneded NULL check of adev
      HID: i2c-hid: acpi: Unify ACPI ID tables format

Arnd Bergmann (1):
      HID: stop drivers from selecting CONFIG_HID

Bastien Nocera (9):
      HID: logitech-hidpp: Hard-code HID++ 1.0 fast scroll support
      Revert "HID: logitech-hidpp: add a module parameter to keep firmware gestures"
      HID: logitech-hidpp: Add constants for HID++ 2.0 error codes
      HID: logitech-hidpp: Don't restart communication if not necessary
      HID: logitech-hidpp: Remove HIDPP_QUIRK_NO_HIDINPUT quirk
      HID: logitech-hidpp: Add Signature M650
      HID: logitech-hidpp: Add more debug statements
      HID: logitech-hidpp: Retry commands when device is busy
      HID: logitech-hidpp: Add myself to authors

Benjamin Tissoires (32):
      HID: Kconfig: split HID support and hid-core compilation
      HID: initial BPF implementation
      selftests: add tests for the HID-bpf initial implementation
      HID: bpf jmp table: simplify the logic of cleaning up programs
      HID: bpf: allocate data memory for device_event BPF programs
      selftests/hid: add test to change the report size
      HID: bpf: introduce hid_hw_request()
      selftests/hid: add tests for bpf_hid_hw_request
      HID: bpf: allow to change the report descriptor
      selftests/hid: add report descriptor fixup tests
      selftests/hid: Add a test for BPF_F_INSERT_HEAD
      samples/hid: add new hid BPF example
      samples/hid: add Surface Dial example
      Documentation: add HID-BPF docs
      HID: bpf: return non NULL data pointer when CONFIG_HID_BPF is not set
      HID: fix BT_HIDP Kconfig dependencies
      HID: force HID depending on INPUT
      Merge branch 'for-6.2/bpf' into for-6.2/hid-bpf
      HID: bpf: do not rely on ALLOW_ERROR_INJECTION
      HID: bpf: enforce HID_BPF dependencies
      selftests: hid: ensures we have the proper requirements in config
      kselftests: hid: fix missing headers_install step
      selftests: hid: add vmtest.sh
      selftests: hid: allow to compile hid_bpf with LLVM
      selftests: hid: attach/detach 2 bpf programs, not just one
      selftests: hid: ensure the program is correctly pinned
      selftests: hid: prepare tests for HID_BPF API change
      HID: bpf: rework how programs are attached and stored in the kernel
      selftests: hid: enforce new attach API
      HID: bpf: clean up entrypoint
      HID: bpf: reorder BPF registration
      HID: mcp-2221: prevent UAF in delayed work

Colin Ian King (1):
      samples/hid: Fix spelling mistake "wihout" -> "without"

Dmitry Torokhov (1):
      HID: retain initial quirks set up when creating HID devices

Douglas Anderson (3):
      HID: i2c-hid: goodix: Stop tying the reset line to the regulator
      dt-bindings: HID: i2c-hid: goodix: Add mainboard-vddio-supply
      HID: i2c-hid: goodix: Add mainboard-vddio-supply

Jingyuan Liang (1):
      HID: Add Mapping for System Microphone Mute

Jiri Kosina (1):
      HID: hid-sensor-custom: Fix big on-stack allocation in hid_sensor_custom_get_known()

José Expósito (8):
      HID: input: map battery system charging
      HID: uclogic: Add frame type quirk
      HID: uclogic: Add battery quirk
      HID: uclogic: Refactor UGEEv2 probe magic data
      HID: uclogic: Handle wireless device reconnection
      HID: uclogic: Add support for XP-PEN Deco Pro SW
      HID: uclogic: Add support for XP-PEN Deco Pro MW
      HID: uclogic: Use KUNIT_EXPECT_MEMEQ

Philipp Jungkamp (4):
      HID: hid-sensor-custom: Allow more custom iio sensors
      HID: hid-sensor-custom: Add LISS custom sensors
      IIO: hid-sensor-als: Use generic usage
      IIO: hid-sensor-prox: Use generic usage

Philippe Valembois (1):
      HID: evision: Add preliminary support for EVision keyboards

Pietro Borrello (6):
      HID: bigben: use spinlock to protect concurrent accesses
      HID: bigben_worker() remove unneeded check on report_field
      HID: bigben: use spinlock to safely schedule workers
      HID: asus: use spinlock to protect concurrent accesses
      HID: asus: use spinlock to safely schedule workers
      hid: bigben_probe(): validate report count

Randy Dunlap (1):
      Documentation: hid: correct spelling

Roderick Colenbrander (4):
      HID: sony: remove DualShock4 support.
      HID: playstation: fix DualShock4 unreachable calibration code.
      HID: playstation: correct DualShock4 gyro bias handling.
      HID: playstation: correct DualSense gyro bias handling.

Ronald Tschalär (1):
      HID: Recognize sensors with application collections

Thomas Weißschuh (20):
      HID: letsketch: Use hid_is_usb()
      HID: usbhid: Make hid_is_usb() non-inline
      HID: Remove unused function hid_is_using_ll_driver()
      HID: Unexport struct usb_hid_driver
      HID: Unexport struct uhid_hid_driver
      HID: Unexport struct hidp_hid_driver
      HID: Unexport struct i2c_hid_ll_driver
      HID: Make lowlevel driver structs const
      HID: i2c-hid: switch to standard debugging APIs
      HID: i2c-hid: use uniform debugging APIs
      HID: amd_sfh: Constify lowlevel HID driver
      HID: hyperv: Constify lowlevel HID driver
      HID: logitech-dj: Constify lowlevel HID driver
      HID: steam: Constify lowlevel HID driver
      HID: intel-ish-hid: Constify lowlevel HID driver
      HID: surface-hid: Constify lowlevel HID driver
      platform/x86: asus-tf103c-dock: Constify lowlevel HID driver
      platform/x86: asus-tf103c-dock: Constify toprow keymap
      staging: greybus: hid: Constify lowlevel HID driver
      HID: use standard debug APIs

Vicki Pfau (2):
      HID: hid-steam: Add Steam Deck support
      HID: hid-steam: Add rumble on Deck

Walt Holman (1):
      HID: Add support for Logitech G923 Xbox Edition steering wheel

 Documentation/devicetree/bindings/input/goodix,gt7375p.yaml |    7 ++
 Documentation/hid/hid-alps.rst                              |    2 +-
 Documentation/hid/hid-bpf.rst                               |  522 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/hid/hiddev.rst                                |    2 +-
 Documentation/hid/hidraw.rst                                |    2 +-
 Documentation/hid/index.rst                                 |    1 +
 Documentation/hid/intel-ish-hid.rst                         |    2 +-
 MAINTAINERS                                                 |   10 ++
 drivers/Makefile                                            |    2 +-
 drivers/hid/.kunitconfig                                    |    1 +
 drivers/hid/Kconfig                                         |   39 +++++--
 drivers/hid/Makefile                                        |    3 +
 drivers/hid/amd-sfh-hid/Kconfig                             |    2 +-
 drivers/hid/amd-sfh-hid/amd_sfh_hid.c                       |    2 +-
 drivers/hid/bpf/Kconfig                                     |   18 ++++
 drivers/hid/bpf/Makefile                                    |   11 ++
 drivers/hid/bpf/entrypoints/Makefile                        |   93 +++++++++++++++++
 drivers/hid/bpf/entrypoints/README                          |    4 +
 drivers/hid/bpf/entrypoints/entrypoints.bpf.c               |   25 +++++
 drivers/hid/bpf/entrypoints/entrypoints.lskel.h             |  248 +++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/bpf/hid_bpf_dispatch.c                          |  551 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/bpf/hid_bpf_dispatch.h                          |   25 +++++
 drivers/hid/bpf/hid_bpf_jmp_table.c                         |  565 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-asus.c                                      |   37 ++++++-
 drivers/hid/hid-bigbenff.c                                  |   75 ++++++++++---
 drivers/hid/hid-core.c                                      |   46 ++++++--
 drivers/hid/hid-debug.c                                     |    1 +
 drivers/hid/hid-evision.c                                   |   53 ++++++++++
 drivers/hid/hid-hyperv.c                                    |    2 +-
 drivers/hid/hid-ids.h                                       |    7 ++
 drivers/hid/hid-input-test.c                                |   80 ++++++++++++++
 drivers/hid/hid-input.c                                     |   48 ++++++++-
 drivers/hid/hid-letsketch.c                                 |    2 +-
 drivers/hid/hid-logitech-dj.c                               |    4 +-
 drivers/hid/hid-logitech-hidpp.c                            |  152 ++++++++++++++++-----------
 drivers/hid/hid-mcp2221.c                                   |    3 +
 drivers/hid/hid-multitouch.c                                |   39 ++++++-
 drivers/hid/hid-playstation.c                               |   41 ++++----
 drivers/hid/hid-quirks.c                                    |    2 +-
 drivers/hid/hid-sensor-custom.c                             |  242 +++++++++++++++++++++++++++++-------------
 drivers/hid/hid-sensor-hub.c                                |    6 +-
 drivers/hid/hid-sony.c                                      | 1021 +++++++--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 drivers/hid/hid-steam.c                                     |  385 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 drivers/hid/hid-uclogic-core-test.c                         |  105 +++++++++++++++++++
 drivers/hid/hid-uclogic-core.c                              |   61 +++++++----
 drivers/hid/hid-uclogic-params-test.c                       |   16 +++
 drivers/hid/hid-uclogic-params.c                            |  124 ++++++++++++++++++++--
 drivers/hid/hid-uclogic-params.h                            |   40 +++++++
 drivers/hid/hid-uclogic-rdesc-test.c                        |    3 +-
 drivers/hid/hid-uclogic-rdesc.c                             |    6 ++
 drivers/hid/hid-uclogic-rdesc.h                             |    5 +
 drivers/hid/i2c-hid/Kconfig                                 |   31 +++---
 drivers/hid/i2c-hid/i2c-hid-acpi.c                          |   26 ++---
 drivers/hid/i2c-hid/i2c-hid-core.c                          |   24 ++---
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c                    |   42 ++++++++
 drivers/hid/i2c-hid/i2c-hid-of-goodix.c                     |   98 ++++-------------
 drivers/hid/i2c-hid/i2c-hid.h                               |    3 +
 drivers/hid/intel-ish-hid/Kconfig                           |    2 +-
 drivers/hid/intel-ish-hid/ishtp-hid.c                       |    2 +-
 drivers/hid/surface-hid/surface_hid_core.c                  |    2 +-
 drivers/hid/uhid.c                                          |    3 +-
 drivers/hid/usbhid/hid-core.c                               |    9 +-
 drivers/iio/light/hid-sensor-als.c                          |   27 ++---
 drivers/iio/light/hid-sensor-prox.c                         |   37 ++++---
 drivers/platform/x86/asus-tf103c-dock.c                     |    4 +-
 drivers/staging/greybus/hid.c                               |    2 +-
 include/linux/hid-sensor-ids.h                              |    1 +
 include/linux/hid.h                                         |   34 ++----
 include/linux/hid_bpf.h                                     |  170 ++++++++++++++++++++++++++++++
 net/bluetooth/hidp/Kconfig                                  |    2 +-
 net/bluetooth/hidp/core.c                                   |    3 +-
 samples/hid/.gitignore                                      |    8 ++
 samples/hid/Makefile                                        |  250 ++++++++++++++++++++++++++++++++++++++++++++
 samples/hid/Makefile.target                                 |   75 +++++++++++++
 samples/hid/hid_bpf_attach.bpf.c                            |   18 ++++
 samples/hid/hid_bpf_attach.h                                |   14 +++
 samples/hid/hid_bpf_helpers.h                               |   21 ++++
 samples/hid/hid_mouse.bpf.c                                 |  112 ++++++++++++++++++++
 samples/hid/hid_mouse.c                                     |  155 +++++++++++++++++++++++++++
 samples/hid/hid_surface_dial.bpf.c                          |  134 ++++++++++++++++++++++++
 samples/hid/hid_surface_dial.c                              |  226 +++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/Makefile                            |    1 +
 tools/testing/selftests/hid/.gitignore                      |    5 +
 tools/testing/selftests/hid/Makefile                        |  231 ++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/hid/config                          |   21 ++++
 tools/testing/selftests/hid/config.common                   |  241 ++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/hid/config.x86_64                   |    4 +
 tools/testing/selftests/hid/hid_bpf.c                       |  869 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/hid/progs/hid.c                     |  209 +++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/hid/progs/hid_bpf_helpers.h         |   21 ++++
 tools/testing/selftests/hid/vmtest.sh                       |  284 +++++++++++++++++++++++++++++++++++++++++++++++++
 91 files changed, 6736 insertions(+), 1428 deletions(-)
 create mode 100644 Documentation/hid/hid-bpf.rst
 create mode 100644 drivers/hid/bpf/Kconfig
 create mode 100644 drivers/hid/bpf/Makefile
 create mode 100644 drivers/hid/bpf/entrypoints/Makefile
 create mode 100644 drivers/hid/bpf/entrypoints/README
 create mode 100644 drivers/hid/bpf/entrypoints/entrypoints.bpf.c
 create mode 100644 drivers/hid/bpf/entrypoints/entrypoints.lskel.h
 create mode 100644 drivers/hid/bpf/hid_bpf_dispatch.c
 create mode 100644 drivers/hid/bpf/hid_bpf_dispatch.h
 create mode 100644 drivers/hid/bpf/hid_bpf_jmp_table.c
 create mode 100644 drivers/hid/hid-evision.c
 create mode 100644 drivers/hid/hid-input-test.c
 create mode 100644 drivers/hid/hid-uclogic-core-test.c
 create mode 100644 include/linux/hid_bpf.h
 create mode 100644 samples/hid/.gitignore
 create mode 100644 samples/hid/Makefile
 create mode 100644 samples/hid/Makefile.target
 create mode 100644 samples/hid/hid_bpf_attach.bpf.c
 create mode 100644 samples/hid/hid_bpf_attach.h
 create mode 100644 samples/hid/hid_bpf_helpers.h
 create mode 100644 samples/hid/hid_mouse.bpf.c
 create mode 100644 samples/hid/hid_mouse.c
 create mode 100644 samples/hid/hid_surface_dial.bpf.c
 create mode 100644 samples/hid/hid_surface_dial.c
 create mode 100644 tools/testing/selftests/hid/.gitignore
 create mode 100644 tools/testing/selftests/hid/Makefile
 create mode 100644 tools/testing/selftests/hid/config
 create mode 100644 tools/testing/selftests/hid/config.common
 create mode 100644 tools/testing/selftests/hid/config.x86_64
 create mode 100644 tools/testing/selftests/hid/hid_bpf.c
 create mode 100644 tools/testing/selftests/hid/progs/hid.c
 create mode 100644 tools/testing/selftests/hid/progs/hid_bpf_helpers.h
 create mode 100755 tools/testing/selftests/hid/vmtest.sh

