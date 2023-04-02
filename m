Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245146D3A72
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 23:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjDBVyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 17:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBVyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 17:54:03 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F4C65AD
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 14:54:01 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w9so110080382edc.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 14:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680472439; x=1683064439;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vMGNb3zNxTpjBfkYCuM6OJsT33bWErHMp7MAkc14DNY=;
        b=Zlmp7DaRTPvfovm3HCySmjTC/xEESsabvvItIYNNH2Srb2jIugyVrObZDVVEhSaHpd
         0q00nHoGvSO03z0CLikO+HkT5xBu1h3X79KMGjK5MKV//wYICHoQA4MAZN9qKaLh3mq4
         TR1jFPqMXheyYBpQPViCh5GiUY6oO6BtRRWmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680472439; x=1683064439;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMGNb3zNxTpjBfkYCuM6OJsT33bWErHMp7MAkc14DNY=;
        b=x1RjUVD70QH3D5/uQHhyrd213DryA/4OYIDxiL/Xd418V8yVUdEgjeqTtj6ZlsljtT
         isi/5ixp7wqPUtoa2/X4vcK8vCZ/fHo+DNZAeV9zyjmU6xB68JWznjmiKCicUGiOsaMU
         0fc5gSttgDSW1soSU8eqEUevcBo1+bpzmz85mciorAQeTYwnkoL27yu6ZQfEViWqZ8WH
         SH/+itwoXS0zIdoFAT2oESWkQN7YRpSTSa87/4xe2OMiQeIHWqeXz/Z8OmatDL3H5YJo
         /fLLhUN7tm5aWfqngjJaQplU7qLo9EBSlYqzCe0l7iIDyPKmUjJrY3O2huzJOYJKdQ3C
         mVGg==
X-Gm-Message-State: AAQBX9dYkSITb5d6O/xEhmyKGbTA+9werf4tLx3E03XqERazNLNVBJG1
        Nwvq+ekuQqHcGH5QmKPjWzxAcYk3qHW/IZdVeEuH1Q==
X-Google-Smtp-Source: AKy350aD32TYBMEDojSjerxf3vUlynlP1A2ToBK+0cbnXhaRdqjWqg2chwH0G0ULuOi4ur1hKpOgdw==
X-Received: by 2002:aa7:ccce:0:b0:500:5627:a20a with SMTP id y14-20020aa7ccce000000b005005627a20amr29583671edt.25.1680472439157;
        Sun, 02 Apr 2023 14:53:59 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id o2-20020a50c282000000b00501cc88b3adsm3716208edf.46.2023.04.02.14.53.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 14:53:58 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id eh3so109993331edb.11
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 14:53:58 -0700 (PDT)
X-Received: by 2002:a17:906:a86:b0:933:f6e8:26d9 with SMTP id
 y6-20020a1709060a8600b00933f6e826d9mr17582888ejf.15.1680472438031; Sun, 02
 Apr 2023 14:53:58 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 Apr 2023 14:53:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi92YtfjcczOm20_mYkWZwKKjn+dCcrx8BL9n9f55MY5g@mail.gmail.com>
Message-ID: <CAHk-=wi92YtfjcczOm20_mYkWZwKKjn+dCcrx8BL9n9f55MY5g@mail.gmail.com>
Subject: Linux 6.3-rc5
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This release continues to appear very normal and boring, which is just
how I like it. The commit count says that we've started calming down
right on schedule, and the diffstat looks normal too.

Of course, there may be something nasty still hiding, so you never
know, but at least for now we seem to be all set for a normal release
in three weeks.  Knock wood.

If the diffstat for rc4 week was a bit unusual in how drivers didn't
completely dominate, then rc5 makes up for it, with pretty much 75% of
the diff being drivers. And it's all the usual ones that dominate:
networking and gpu drivers make up for over half of it, and the rest
is a random mix of other stragglers (x86 platform drivers, input,
pinctrl, sound..).

Outside of drivers, it's various random stuff. Architecture fixes
(arm64 kvm, riscv, powerpc), filesystems (btrfs, cifs), core
networking, documentation and tooling.

---

Ahmad Fatoum (1):
      net: dsa: realtek: fix out-of-bounds access

Alex Elder (1):
      net: ipa: compute DMA pool size properly

Alyssa Ross (1):
      loop: LOOP_CONFIGURE: send uevents for partitions

Anand Jain (1):
      btrfs: scan device in non-exclusive mode

Andrzej Kacprowski (1):
      accel/ivpu: Fix IPC buffer header status field value

Arnd Bergmann (1):
      media: i2c: imx290: fix conditional function defintions

Arseniy Krasnov (5):
      mtd: rawnand: meson: initialize struct with zeroes
      mtd: rawnand: meson: invalidate cache on polling ECC bit
      virtio/vsock: fix header length on skb merging
      virtio/vsock: WARN_ONCE() for invalid state of socket
      test/vsock: new skbuff appending test

Ar=C4=B1n=C3=A7 =C3=9CNAL (2):
      pinctrl: mediatek: add missing options to PINCTRL_MT7981
      pinctrl: mediatek: fix naming inconsistency

Ashutosh Dixit (1):
      drm/i915/pmu: Use functions common with sysfs to read actual freq

Ben Hutchings (1):
      modpost: Fix processing of CRCs on 32-bit build machines

Benjamin Gray (1):
      powerpc/64s: Fix __pte_needs_flush() false positive warning

Brett Creeley (1):
      ice: Fix ice_cfg_rdma_fltr() to only update relevant fields

Chris Wilson (2):
      drm/i915/gem: Flush lmem contents after construction
      drm/i915/perf: Drop wakeref on GuC RC error

Christophe JAILLET (2):
      mtd: nand: mxic-ecc: Fix
mxic_ecc_data_xfer_wait_for_completion() when irq is used
      regulator: Handle deferred clk

ChunHao Lin (1):
      r8169: fix RTL8168H and RTL8107E rx crc error

Conor Dooley (2):
      RISC-V: add non-alternative fallback for riscv_has_extension_[un]like=
ly()
      RISC-V: always select RISCV_ALTERNATIVE for non-xip kernels

Damien Le Moal (3):
      scsi: core: Improve scsi_vpd_inquiry() checks
      zonefs: Always invalidate last cached page on append write
      zonefs: Do not propagate iomap_dio_rw() ENOTBLK error to user space

Dario Binacchi (1):
      pinctrl: stm32: use dynamic allocation of GPIO base

David Arcari (1):
      thermal: intel: powerclamp: Fix cpumask and max_idle module parameter=
s

David Disseldorp (1):
      cifs: fix DFS traversal oops without CONFIG_CIFS_DFS_UPCALL

David Gow (2):
      drm: buddy_allocator: Fix buddy allocator init on 32-bit systems
      drm: test: Fix 32-bit issue in drm_buddy_test

David Matlack (1):
      KVM: arm64: Retry fault if vma_lookup() results become invalid

Dongliang Mu (4):
      net: ieee802154: remove an unnecessary null pointer check
      platform/x86/intel: vsec: Fix a memory leak in intel_vsec_add_aux
      platform/x86/intel: tpmi: Fix double free in tpmi_create_device()
      platform/x86/intel: tpmi: Revise the comment of intel_vsec_add_aux

Douglas Raillard (2):
      f2fs: Fix f2fs_truncate_partial_nodes ftrace event
      rcu: Fix rcu_torture_read ftrace event

Faicker Mo (1):
      net/net_failover: fix txq exceeding warning

Fangzhi Zuo (2):
      drm/amd/display: Add DSC Support for Synaptics Cascaded MST Hub
      drm/amd/display: Take FEC Overhead into Timeslot Calculation

Felix Fietkau (4):
      net: ethernet: mtk_eth_soc: fix tx throughput regression with
direct 1G links
      net: ethernet: mtk_eth_soc: fix flow block refcounting logic
      net: ethernet: mtk_eth_soc: fix L2 offloading with DSA untag offload
      net: ethernet: mtk_eth_soc: add missing ppe cache flush when
deleting a flow

Filipe Manana (3):
      btrfs: fix race between quota disable and quota assign ioctls
      btrfs: fix deadlock when aborting transaction during relocation with =
scrub
      btrfs: ignore fiemap path cache when there are multiple paths for a n=
ode

Frank Crawford (1):
      platform/x86 (gigabyte-wmi): Add support for A320M-S2H V2

Geert Uytterhoeven (1):
      dt-bindings: mtd: jedec,spi-nor: Document CPOL/CPHA support

Greg Kroah-Hartman (1):
      mtd: spi-nor: fix memory leak when using debugfs_lookup()

GuoRui.Yu (1):
      swiotlb: fix the deadlock in swiotlb_do_find_slots

Hans de Goede (4):
      Input: goodix - add Lenovo Yoga Book X90F to nine_bytes_report DMI ta=
ble
      drm/nouveau/kms: Fix backlight registration
      platform/x86: gigabyte-wmi: add support for X570S AORUS ELITE
      platform/x86: ideapad-laptop: Stop sending KEY_TOUCHPAD_TOGGLE

Haren Myneni (1):
      powerpc/pseries/vas: Ignore VAS update for DLPAR if copy/paste
is not enabled

Harshit Mogalapalli (1):
      ca8210: Fix unsigned mac_len comparison with zero in ca8210_skb_tx()

Heiko Carstens (2):
      s390/uaccess: add missing earlyclobber annotations to __clear_user()
      s390/ptrace: fix PTRACE_GET_LAST_BREAK error handling

Horatiu Vultur (1):
      pinctrl: ocelot: Fix alt mode for ocelot

Imre Deak (1):
      drm/i915/tc: Fix the ICL PHY ownership check in TC-cold state

Ivan Orlov (1):
      can: bcm: bcm_tx_setup(): fix KMSAN uninit-value in vfs_write

Jakob Koschel (1):
      ice: fix invalid check for empty list in ice_sched_assoc_vsi_to_agg()

Jakub Kicinski (1):
      bnx2x: use the right build_skb() helper

Jaroslav Kysela (1):
      ALSA: hda/realtek: Fix support for Dell Precision 3260

Jason A. Donenfeld (1):
      Input: focaltech - use explicitly signed char type

Javier Martinez Canillas (1):
      Revert "venus: firmware: Correct non-pix start and end addresses"

Jens Axboe (2):
      powerpc: Don't try to copy PPR for task with NULL pt_regs
      io_uring/poll: clear single/double poll flags on poll arming

Jerry Snitselaar (1):
      scsi: mpt3sas: Don't print sense pool info twice

Jesse Brandeburg (1):
      ice: fix W=3D1 headers mismatch

Jiawen Wu (1):
      net: wangxun: Fix vector length of interrupt cause

Jiri Slaby (SUSE) (1):
      s390: reintroduce expoline dependence to scripts

Johan Hovold (1):
      pinctrl: at91-pio4: fix domain name assignment

Jonathan Denose (1):
      Input: i8042 - add quirk for Fujitsu Lifebook A574/H

Josua Mayer (1):
      net: phy: dp83869: fix default value for tx-/rx-internal-delay

Juergen Gross (3):
      xen/netback: don't do grant copy across page boundary
      xen/netback: remove not needed test in xenvif_tx_build_gops()
      xen/netback: use same error messages for same errors

Junfeng Guo (1):
      ice: add profile conflict check for AVF FDIR

Juraj Pecigos (1):
      nvme-pci: mark Lexar NM760 as IGNORE_DEV_SUBNQN

Kalesh AP (2):
      bnxt_en: Fix reporting of test result in ethtool selftest
      bnxt_en: Fix typo in PCI id to device description string mapping

Kan Liang (1):
      iommu/vt-d: Fix an IOMMU perfmon warning when CPU hotplug

Kevin Locke (1):
      kbuild: deb-pkg: set version for linux-headers paths

Kornel Dul=C4=99ba (1):
      pinctrl: amd: Disable and mask interrupts on resume

Krzysztof Kozlowski (1):
      dt-bindings: pinctrl: qcom,sm8550-lpass-lpi: allow input-enabled
and bias-bus-hold

Liang He (1):
      platform/surface: aggregator: Add missing fwnode_handle_put()

Linus Torvalds (1):
      Linux 6.3-rc5

Lu Baolu (2):
      iommu/vt-d: Remove unnecessary locking in intel_irq_remapping_alloc()
      iommu/vt-d: Allow zero SAGAW if second-stage not supported

Lucas Stach (3):
      drm/etnaviv: fix reference leak when mmaping imported buffer
      Revert "drm/etnaviv: export client GPU usage statistics via fdinfo"
      Revert "drm/scheduler: track GPU active time per entity"

Lukas Bulwahn (1):
      MAINTAINERS: remove the linux-nfc@lists.01.org list

M Chetan Kumar (1):
      net: wwan: iosm: fixes 7560 modem crash

Marc Zyngier (2):
      KVM: arm64: Disable interrupts while walking userspace PTs
      KVM: arm64: Check for kvm_vma_mte_allowed in the critical section

Marek Szyprowski (1):
      iommu/exynos: Fix set_platform_dma_ops() callback

Mark Pearson (4):
      platform/x86: think-lmi: add missing type attribute
      platform/x86: think-lmi: use correct possible_values delimiters
      platform/x86: think-lmi: only display possible_values if available
      platform/x86: think-lmi: Add possible_values for ThinkStation

Matthias Benkmann (1):
      Input: xpad - fix incorrectly applied patch for MAP_PROFILE_BUTTON

Max Filippov (2):
      xtensa: fix KASAN report for show_stack
      MAINTAINERS: xtensa: drop linux-xtensa@linux-xtensa.org mailing list

Michael Chan (1):
      bnxt_en: Add missing 200G link speed reporting

Mike Snitzer (2):
      dm: fix improper splitting for abnormal bios
      dm: fix __send_duplicate_bios() to always allow for splitting IO

Miquel Raynal (1):
      mtd: rawnand: nandsim: Artificially prevent sequential page reads

Mirsad Goran Todorovac (1):
      scripts: merge_config: Fix typo in variable name.

Nick Desaulniers (1):
      selftests: sigaltstack: fix -Wuninitialized

Niklas Schnelle (1):
      MAINTAINERS: Update s390-iommu driver maintainer information

Oleksij Rempel (8):
      net: dsa: microchip: ksz8: fix ksz8_fdb_dump()
      net: dsa: microchip: ksz8: fix ksz8_fdb_dump() to extract all 1024 en=
tries
      net: dsa: microchip: ksz8: fix offset for the timestamp filed
      net: dsa: microchip: ksz8: ksz8_fdb_dump: avoid extracting ghost
entry from empty dynamic MAC table.
      net: dsa: microchip: ksz8863_smi: fix bulk access
      net: dsa: microchip: ksz8: fix MDB configuration with non-zero VID
      net: phy: micrel: correct KSZ9131RNX EEE capabilities and advertiseme=
nt
      can: j1939: prevent deadlock by moving j1939_sk_errqueue()

Paulo Alcantara (3):
      cifs: avoid races in parallel reconnects in smb1
      cifs: prevent infinite recursion in CIFSGetDFSRefer()
      cifs: get rid of dead check in smb2_reconnect()

Pavel Begunkov (2):
      io_uring/rsrc: fix rogue rsrc node grabbing
      io_uring: fix poll/netmsg alloc caches

Petr Tesarik (2):
      swiotlb: use wrap_area_index() instead of open-coding it
      swiotlb: fix slot alignment checks

Radoslaw Tyl (1):
      i40e: fix registers dump after run ethtool adapter self test

Rafael J. Wysocki (2):
      ACPI: bus: Rework system-level device notification handling
      thermal: core: Drop excessive lockdep_assert_held() calls

Rajnesh Kanwal (1):
      riscv/kvm: Fix VM hang in case of timer delta being zero.

Rajvi Jingar (1):
      platform/x86/intel/pmc: Alder Lake PCH slp_s0_residency fix

Reiji Watanabe (2):
      KVM: arm64: PMU: Fix GET_ONE_REG for vPMC regs to return the current =
value
      KVM: arm64: PMU: Don't save PMCR_EL0.{C,P} for the vCPU

Ronak Doshi (1):
      vmxnet3: use gro callback when UPT is enabled

Russell King (Oracle) (4):
      net: sfp: make sfp_bus_find_fwnode() take a const fwnode
      net: sfp: constify sfp-bus internal fwnode uses
      net: phy: constify fwnode_get_phy_node() fwnode argument
      net: mvneta: fix potential double-frees in mvneta_txq_sw_deinit()

Sagi Grimberg (1):
      nvme-tcp: fix a possible UAF when failing to allocate an io queue

Sean Anderson (1):
      net: fman: Add myself as a reviewer

Siddharth Kawar (1):
      SUNRPC: fix shutdown of NFS TCP client socket

SongJingyi (1):
      ptp_qoriq: fix memory leak in probe()

Srinivas Pandruvada (1):
      thermal: intel: int340x: processor_thermal: Fix additional deadlock

Stanislaw Gruszka (7):
      accel/ivpu: Do not access HW registers after unbind
      accel/ivpu: Cancel recovery work
      accel/ivpu: Do not use SSID 1
      accel/ivpu: Fix power down sequence
      accel/ivpu: Disable buttress on device removal
      accel/ivpu: Remove support for 1 tile SKUs
      accel/ivpu: Fix VPU clock calculation

Stefano Garzarella (1):
      vsock/loopback: use only sk_buff_head.lock to protect the packet queu=
e

Steffen B=C3=A4tz (1):
      net: dsa: mv88e6xxx: Enable IGMP snooping on user ports only

Sven Auhagen (3):
      net: mvpp2: classifier flow fix fragmentation flags
      net: mvpp2: parser fix QinQ
      net: mvpp2: parser fix PPPoE

Takashi Iwai (3):
      ALSA: hda/conexant: Partial revert of a quirk for Lenovo
      ALSA: usb-audio: Fix recursive locking at XRUN during syncing
      ALSA: usb-audio: Fix regression on detection of Roland VS-100

Tasos Sahanidis (2):
      ALSA: ymfpci: Create card with device-managed snd_devm_card_new()
      ALSA: ymfpci: Fix BUG_ON in probe function

Thomas Wei=C3=9Fschuh (1):
      platform/x86: gigabyte-wmi: add support for B650 AORUS ELITE AX

Tim Crawford (1):
      ALSA: hda/realtek: Add quirks for some Clevo laptops

Tim Huang (1):
      drm/amdgpu: allow more APUs to do mode2 reset when go to S4

Tomas Henzl (2):
      scsi: megaraid_sas: Fix fw_crash_buffer_show()
      scsi: megaraid_sas: Fix crash after a double completion

Tony Krowiak (1):
      s390/vfio-ap: fix memory leak in vfio_ap device driver

Trond Myklebust (1):
      NFSv4: Fix hangs when recovering open state after a server reboot

Vegard Nossum (1):
      Documentation/security-bugs: move from admin-guide/ to process/

Ville Syrj=C3=A4l=C3=A4 (6):
      drm/i915: Split icl_color_commit_noarm() from skl_color_commit_noarm(=
)
      drm/i915: Move CSC load back into .color_commit_arm() when PSR
is enabled on skl/glk
      drm/i915: Add a .color_post_update() hook
      drm/i915: Workaround ICL CSC_MODE sticky arming
      drm/i915: Disable DC states for all commits
      drm/i915/dpt: Treat the DPT BO as a framebuffer

Vladimir Oltean (2):
      net: stmmac: don't reject VLANs when IFF_PROMISC is set
      net: dsa: sync unicast and multicast addresses for VLAN filters too

Werner Sembach (1):
      Input: i8042 - add TUXEDO devices to i8042 quirk tables for partial f=
ix

Wolfram Sang (1):
      smsc911x: avoid PHY being resumed when interface is not up

Yicong Yang (1):
      cacheinfo: Fix LLC is not exported through sysfs

Yoshihiro Shimoda (1):
      PCI: dwc: Fix PORT_LINK_CONTROL update when CDM check enabled

Yu Kuai (1):
      md: fix regression for null-ptr-deference in __md_stop()

huangwenhui (1):
      ALSA: hda/realtek: Add quirk for Lenovo ZhaoYang CF4620Z

msizanoen (1):
      Input: alps - fix compatibility with -funsigned-char

weiliang1503 (1):
      platform/x86: asus-nb-wmi: Add quirk_asus_tablet_mode to other
ROG Flow X13 models

=C3=81lvaro Fern=C3=A1ndez Rojas (2):
      mips: bmips: BCM6358: disable RAC flush for TP1
      net: dsa: b53: mmap: add phy ops

=C3=8D=C3=B1igo Huguet (1):
      sfc: ef10: don't overwrite offload features at NIC reset
