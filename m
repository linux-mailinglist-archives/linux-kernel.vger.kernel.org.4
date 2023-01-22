Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BB2676A7A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 01:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjAVAoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 19:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAVAo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 19:44:28 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486B7113FF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 16:44:25 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id o5so7108542qtr.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 16:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4hmFASSe7V+GtmdpDDmfvJALroHqsP2tjnKy0Vcj+mI=;
        b=LCvoLL+2cBzK8ecVbzqYnFEBRtWpti/2fvgp9eYSBN3D30YbfqCcHnkYJZpUhbX/hu
         K9g1a7fPOPHn25vk8A9PMIwfRvUp2ro+IF0CfGbQvVERChgHhRxqBJgzK2+u1OX5Gu4s
         dcONFKBvXj8WCB8575U3VEFAkGNqYNRNxjdl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hmFASSe7V+GtmdpDDmfvJALroHqsP2tjnKy0Vcj+mI=;
        b=FYfKh3l0fNYQkc0G0V7UoPfauFS0d2w9R9OGCZN0XrlkYYYEfDjWTFwtLTHaSkGbu2
         qCa6EghjlLtWn35rsaWFVjekNofYUaqNmzFbwUSAgUNdrz2eVUwAB7BnF/4aIPmAX3bO
         zZzoouboeFt+q9jcdAzgPWJTIbovqG92QbzCuErbGfw6ecpgRd/WBcKdK5KKnqHnjeJb
         0unXztTYhFoJ+ipf9pIXsd1D70FcXkujNoq015gZ7QZqGZfvLLwftcBiM3LOZpH03aLD
         YIFPUEM9ru841UKvv/uhBkfu9fywCDi7k826x5VmIJR5R/QN9AUUtjwJKqxviXDmePzs
         INUg==
X-Gm-Message-State: AFqh2kqoX6fW0k6kAv8wh0h8dZAxbn/CFqUSszR5D/0otKiEpu52bwz+
        EsXA0ACcaBg6Z8uSKdgbECyyJ71xDKjZsHvd
X-Google-Smtp-Source: AMrXdXvzK6gUfE7B3wErq4yoAHKldNZ+GKBtw0XugglSKJTykAfLHUIlY1Q26KkHEDxS4wGpW9/NKw==
X-Received: by 2002:ac8:747:0:b0:3b6:3a28:3377 with SMTP id k7-20020ac80747000000b003b63a283377mr24701232qth.58.1674348263701;
        Sat, 21 Jan 2023 16:44:23 -0800 (PST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com. [209.85.222.173])
        by smtp.gmail.com with ESMTPSA id g8-20020ae9e108000000b006b5cc25535fsm3243655qkm.99.2023.01.21.16.44.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 16:44:23 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id pj1so4731260qkn.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 16:44:23 -0800 (PST)
X-Received: by 2002:a37:45d3:0:b0:706:96dd:8d4a with SMTP id
 s202-20020a3745d3000000b0070696dd8d4amr957503qka.336.1674348262534; Sat, 21
 Jan 2023 16:44:22 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 21 Jan 2023 16:44:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg+E9tTCrSqBOxejUX11f8ebyRWQ+4exC=cmOEupX_d7Q@mail.gmail.com>
Message-ID: <CAHk-=wg+E9tTCrSqBOxejUX11f8ebyRWQ+4exC=cmOEupX_d7Q@mail.gmail.com>
Subject: Linux 6.2-rc5
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, so I thought we were back to normal after the winter holidays at
rc4. Now, a week later, I think I was mistaken - we have fairly
sizable rc5, so I suspect there was still pent up testing and fixes
from people being off.

Anyway, I am expecting to do an rc8 this release regardless, just
because we effectively had a lost week or two in the early rc's, so a
sizable rc5 doesn't really worry me. I do hope we're done with the
release candidates growing, though.

Anyway, there's a bit of everything in rc5: various driver updates
(gpu, rdma, networking, tty, usb..), some architecture updates (mostly
loongarch and arm64), some filesystem updates, some core networking,
and tooling.

The shortlog is appended as usual. Nothing particularly odd stands out to m=
e.

Please do test,

                   Linus

---

Abel Vesa (2):
      misc: fastrpc: Fix use-after-free and race in fastrpc_map_find
      misc: fastrpc: Don't remove map on creater_process and device_release

Adam Ford (3):
      arm64: dts: imx8mm-beacon: Fix ecspi2 pinmux
      arm64: dts: imx8mp: Fix missing GPC Interrupt
      arm64: dts: imx8mp: Fix power-domain typo

Adham Faris (1):
      net/mlx5e: Remove redundant xsk pointer check in mlx5e_mpwrq_validate=
_xsk

Adrian Huang (1):
      md: fix incorrect declaration about claim_rdev in md_import_device

Akhil R (1):
      dmaengine: tegra: Fix memory leak in terminate_all()

Alan Stern (1):
      USB: gadgetfs: Fix race between mounting and unmounting

Alex Deucher (2):
      drm/amd/display: disable S/G display on DCN 3.1.5
      drm/amd/display: disable S/G display on DCN 3.1.4

Alexander Potapenko (1):
      affs: initialize fsdata in affs_truncate()

Alexander Stein (1):
      usb: host: ehci-fsl: Fix module alias

Alexander Usyskin (2):
      mei: bus: fix unlink on bus in error path
      mei: me: add meteor lake point M DID

Alexander Wetzel (3):
      wifi: mac80211: Proper mark iTXQs for resumption
      wifi: mac80211: sdata can be NULL during AMPDU start
      wifi: mac80211: Fix iTXQ AMPDU fragmentation handling

Alexandre Belloni (1):
      ARM: footbridge: drop unnecessary inclusion

Alexey Dobriyan (1):
      proc: fix PIE proc-empty-vm, proc-pid-vm tests

Ali Mirghasemi (1):
      USB: serial: option: add Quectel EC200U modem

Aloka Dixit (1):
      wifi: mac80211: reset multiple BSSID options in stop_ap()

Andrew Halaney (1):
      net: stmmac: enable all safety features by default

Andrey Konovalov (1):
      kasan: mark kasan_kunit_executing as static

Andy Shevchenko (1):
      pinctrl: nomadik: Add missing header(s)

Anuradha Weeraman (1):
      kernel/printk/printk.c: Fix W=3D1 kernel-doc warning

Ard Biesheuvel (1):
      ACPI: PRM: Check whether EFI runtime is available

Arend van Spriel (4):
      scripts: rpm: make clear that mkspec script contains 4.13 feature
      wifi: brcmfmac: avoid handling disabled channels for survey dump
      wifi: brcmfmac: avoid NULL-deref in survey dump for 2G only device
      wifi: brcmfmac: fix regression for Broadcom PCIe wifi devices

Arnaldo Carvalho de Melo (6):
      tools headers UAPI: Sync linux/kvm.h with the kernel sources
      tools headers UAPI: Sync x86's asm/kvm.h with the kernel sources
      tools kvm headers arm64: Update KVM header from the kernel sources
      tools headers arm64: Sync arm64's cputype.h with the kernel sources
      perf beauty: Update copy of linux/socket.h with the kernel sources
      tools headers: Syncronize linux/build_bug.h with the kernel sources

Arnd Bergmann (9):
      pinctrl: sp7021: fix unused function warning
      ARM: pxa: enable PXA310/PXA320 for DT-only build
      ARM: omap1: fix !ARCH_OMAP1_ANY link failures
      ARM: omap1: fix building gpio15xx
      staging: vchiq_arm: fix enum vchiq_status return types
      drm/panfrost: fix GENERIC_ATOMIC64 dependency
      usb: dwc3: fix extcon dependency
      tty: serial: qcom_geni: avoid duplicate struct member init
      firmware: zynqmp: fix declarations for gcc-13

Ashish Mhetre (1):
      memory: tegra: Remove clients SID override programming

Athira Rajeev (2):
      perf buildid-cache: Fix the file mode with copyfile() while
adding file to build-id cache
      perf test build-id: Fix test check for PE file

Basavaraj Natikar (1):
      HID: amd_sfh: Fix warning unwind goto

Ben Dooks (1):
      riscv: dts: sifive: fu740: fix size of pcie 32bit memory

Benedikt Niedermayr (1):
      memory: omap-gpmc: fix wait pin validation

Caleb Connolly (1):
      net: ipa: disable ipa interrupt during suspend

Chanh Nguyen (1):
      USB: gadget: Add ID numbers to configfs-gadget driver names

Chen Zhongjin (1):
      driver core: Fix test_async_probe_init saves device in wrong array

ChiYuan Huang (1):
      usb: typec: tcpm: Fix altmode re-registration causes sysfs create fai=
l

Chris Mi (2):
      net/mlx5e: Set decap action based on attr for sample
      net/mlx5: E-switch, Fix switchdev mode after devlink reload

Chris Packham (1):
      arm64: dts: marvell: AC5/AC5X: Fix address for UART1

Chris Wilson (1):
      drm/i915/selftests: Unwind hugepages to drop wakeref on error

Christian K=C3=B6nig (2):
      drm/amdgpu: fix cleaning up reserved VMID on release
      drm/amdgpu: fix amdgpu_job_free_resources v2

Christoph Hellwig (2):
      btrfs: factor out scratching of one regular super block
      btrfs: stop using write_one_page in btrfs_scratch_superblock

Christophe JAILLET (1):
      PM: AVS: qcom-cpr: Fix an error handling path in cpr_probe()

Claudiu Beznea (1):
      ARM: dts: at91: sam9x60: fix the ddr clock for sam9x60

Cl=C3=A9ment L=C3=A9ger (1):
      net: lan966x: add missing fwnode_handle_put() for ports node

Cong Wang (2):
      l2tp: convert l2tp_tunnel_list to idr
      l2tp: close all race conditions in l2tp_tunnel_register()

Cristian Marussi (4):
      firmware: arm_scmi: Clear stale xfer->hdr.status
      firmware: arm_scmi: Harden shared memory access in fetch_response
      firmware: arm_scmi: Harden shared memory access in fetch_notification
      firmware: arm_scmi: Fix virtio channels cleanup on shutdown

Dai Ngo (2):
      NFSD: register/unregister of nfsd-client shrinker at nfsd
startup/shutdown time
      NFSD: replace delayed_work with work_struct for nfsd_client_shrinker

Daisuke Matsuda (2):
      RDMA/rxe: Fix inaccurate constants in rxe_type_info
      RDMA/rxe: Prevent faulty rkey generation

Damien Le Moal (1):
      zonefs: Detect append writes at invalid locations

Dan Carpenter (1):
      misc: fastrpc: fix error code in fastrpc_req_mmap()

Daniel Scally (1):
      usb: gadget: g_webcam: Send color matching descriptor per frame

Dario Binacchi (1):
      ARM: imx: add missing of_node_put()

David Hildenbrand (3):
      mm/hugetlb: fix PTE marker handling in hugetlb_change_protection()
      mm/hugetlb: fix uffd-wp handling for migration entries in
hugetlb_change_protection()
      mm/userfaultfd: enable writenotify while userfaultfd-wp is
enabled for a VMA

David Howells (1):
      rxrpc: Fix wrong error return in rxrpc_connect_call()

David Morley (1):
      tcp: fix rate_app_limited to default to 1

David Rientjes (1):
      mm, slab: periodically resched in drain_freelist()

Dean Luick (5):
      IB/hfi1: Reject a zero-length user expected buffer
      IB/hfi1: Reserve user expected TIDs
      IB/hfi1: Fix expected receive setup error exit issues
      IB/hfi1: Immediately remove invalid memory from hardware
      IB/hfi1: Remove user expected buffer invalidate race

Dominik Kobinski (2):
      arm64: dts: msm8992-bullhead: add memory hole region
      arm64: dts: msm8994-angler: fix the memory map

Drew Davenport (1):
      drm/i915/display: Check source height is > 0

Duke Xin(=E8=BE=9B=E5=AE=89=E6=96=87) (5):
      USB: serial: option: add Quectel EM05-G (CS) modem
      USB: serial: option: add Quectel EM05-G (GR) modem
      USB: serial: option: add Quectel EM05-G (RS) modem
      USB: serial: option: add Quectel EM05CN (SG) modem
      USB: serial: option: add Quectel EM05CN modem

Elliot Berman (1):
      misc: fastrpc: Pass bitfield into qcom_scm_assign_mem

Emanuele Ghidoli (2):
      arm64: dts: verdin-imx8mm: fix dahlia audio playback
      arm64: dts: verdin-imx8mm: fix dev board audio playback

Enzo Matsumiya (1):
      cifs: do not include page data when checking signature

Eric Dumazet (3):
      net/sched: sch_taprio: fix possible use-after-free
      Revert "wifi: mac80211: fix memory leak in ieee80211_if_add()"
      l2tp: prevent lockdep issue in l2tp_tunnel_register()

Eric Pilmore (1):
      ptdma: pt_core_execute_cmd() should use spinlock

Esina Ekaterina (1):
      net: wan: Add checks for NULL for utdm in undo_uhdlc_init and
unmap_si_regs

Fabio Estevam (4):
      arm64: dts: imx8mp-phycore-som: Remove invalid PMIC property
      ARM: dts: imx6ul-pico-dwarf: Use 'clock-frequency'
      ARM: dts: imx7d-pico: Use 'clock-frequency'
      ARM: dts: imx6qdl-gw560x: Remove incorrect 'uart-has-rtscts'

Felix Fietkau (3):
      wifi: mac80211: fix initialization of rx->link and rx->link_sta
      wifi: mac80211: fix MLO + AP_VLAN check
      wifi: mt76: dma: fix a regression in adding rx buffers

Filipe Manana (7):
      btrfs: fix missing error handling when logging directory items
      btrfs: fix directory logging due to race with concurrent index
key deletion
      btrfs: add missing setup of log for full commit at add_conflicting_in=
ode()
      btrfs: do not abort transaction on failure to write log tree
when syncing log
      btrfs: do not abort transaction on failure to update log root
      btrfs: fix invalid leaf access due to inline extent during lseek
      btrfs: fix race between quota rescan and disable leading to NULL
pointer deref

Flavio Suligoi (1):
      usb: core: hub: disable autosuspend for TI TUSB8041

Florian Westphal (2):
      selftests: netfilter: fix transaction test script timeout handling
      netfilter: conntrack: handle tcp challenge acks during connection reu=
se

Gao Xiang (1):
      erofs: fix kvcalloc() misuse with __GFP_NOFAIL

Gaosheng Cui (3):
      memory: atmel-sdramc: Fix missing clk_disable_unprepare in
atmel_ramc_probe()
      memory: mvebu-devbus: Fix missing clk_disable_unprepare in
mvebu_devbus_probe()
      tty: fix possible null-ptr-defer in spk_ttyio_release

Gavrilov Ilia (1):
      netfilter: ipset: Fix overflow before widen in the
bitmap_ip_create() function.

Geert Uytterhoeven (4):
      ARM: dts: imx: Fix pca9547 i2c-mux node name
      ARM: dts: vf610: Fix pca9548 i2c-mux node names
      arm64: dts: freescale: Fix pca954x i2c-mux node names
      phy: phy-can-transceiver: Skip warning if no "max-bitrate"

Geetha sowjanya (1):
      octeontx2-pf: Avoid use of GFP_KERNEL in atomic context

Greg Kroah-Hartman (3):
      Revert "serial: stm32: Merge hard IRQ and threaded IRQ handling
into single IRQ handler"
      USB: misc: iowarrior: fix up header size for
USB_DEVICE_ID_CODEMERCS_IOW100
      prlimit: do_prlimit needs to have a speculation check

Guoqing Jiang (1):
      block/rnbd-clt: fix wrong max ID in ida_alloc_max

Haibo Chen (2):
      arm64: dts: imx93-11x11-evk: correct clock and strobe pad setting
      mmc: sdhci-esdhc-imx: correct the tuning start tap and step setting

Hamza Mahfooz (1):
      drm/amd/display: fix issues with driver unload

Hans de Goede (1):
      ACPI: video: Add backlight=3Dnative DMI quirk for Acer Aspire 4810T

Hao Sun (2):
      bpf: Skip invalid kfunc call in backtrack_insn
      bpf: Skip task with pid=3D1 in send_signal_common()

Harshit Mogalapalli (1):
      Bluetooth: Fix a buffer overflow in mgmt_mesh_add()

Heiko Carstens (1):
      s390: workaround invalid gcc-11 out of bounds read warning

Heiner Kallweit (4):
      net: mdio: validate parameter addr in mdiobus_get_phy()
      net: stmmac: fix invalid call to mdiobus_get_phy()
      dt-bindings: phy: g12a-usb3-pcie-phy: fix compatible string documenta=
tion
      dt-bindings: phy: g12a-usb2-phy: fix compatible string documentation

Huacai Chen (1):
      LoongArch: Add HWCAP_LOONGARCH_CPUCFG to elf_hwcap

Hugh Dickins (1):
      mm/khugepaged: fix collapse_pte_mapped_thp() to allow anon_vma

Hui Tang (1):
      reset: uniphier-glue: Fix possible null-ptr-deref

Hui Wang (1):
      dmaengine: imx-sdma: Fix a possible memory leak in sdma_transfer_init

Ian Abbott (1):
      comedi: adv_pci1760: Fix PWM instruction handling

Ilpo J=C3=A4rvinen (1):
      serial: pch_uart: Pass correct sg to dma_unmap_sg()

Jack Pham (1):
      usb: ucsi: Ensure connector delayed work items are flushed

Jakub Kicinski (3):
      net: sched: gred: prevent races when adding offloads to stats
      MAINTAINERS: add networking entries for Willem
      Revert "Merge branch 'octeontx2-af-CPT'"

James Houghton (1):
      hugetlb: unshare some PMDs when splitting VMAs

Janne Grunau (2):
      nvme-apple: reset controller during shutdown
      nvme-apple: only reset the controller when RTKit is running

Jason Wang (1):
      virtio-net: correctly enable callback during start_xmit

Jason Xing (1):
      tcp: avoid the lookup process failing to get sk in ehash table

Jayesh Choudhary (1):
      dmaengine: ti: k3-udma: Do conditional decrement of
UDMA_CHAN_RT_PEER_BCNT_REG

Jens Axboe (4):
      pktcdvd: check for NULL returna fter calling bio_split_to_limits()
      io_uring/msg_ring: move double lock/unlock helpers higher up
      io_uring/msg_ring: fix missing lock on overflow for IOPOLL
      io_uring/poll: don't reissue in case of poll race on multishot reques=
t

Jiasheng Jiang (1):
      HID: intel_ish-hid: Add check for ishtp_dma_tx_map

Jie Hai (1):
      MAINTAINERS: update Jie Hai's email address

Jimmy Hu (1):
      usb: xhci: Check endpoint is valid before dereferencing it

Jingbo Xu (2):
      erofs: add documentation for 'domain_id' mount option
      erofs: clean up parsing of fscache related options

Jinyang He (5):
      LoongArch: Adjust PC value when unwind next frame in unwinder
      LoongArch: Get frame info in unwind_start() when regs is not availabl=
e
      LoongArch: Use correct sp value to get graph addr in stack unwinders
      LoongArch: Strip guess unwinder out from prologue unwinder
      LoongArch: Add generic ex-handler unwind in prologue unwinder

Jiri Kosina (1):
      HID: revert CHERRY_MOUSE_000C quirk

Jisoo Jang (1):
      net: nfc: Fix use-after-free in local_cleanup()

Joel Fernandes (Google) (1):
      adreno: Shutdown the GPU properly

Johan Hovold (3):
      arm64: dts: qcom: sc8280xp: fix primary USB-DP PHY reset
      arm64: dts: qcom: sc8280xp: fix USB-DP PHY nodes
      USB: fix misleading usb_set_intfdata() kernel doc

John Ogness (1):
      tty: serial: kgdboc: fix mutex locking order for configure_kgdboc()

Jonas Karlman (2):
      pinctrl: rockchip: fix reading pull type on rk3568
      pinctrl: rockchip: fix mux route data for rk3568

Joshua Ashton (2):
      drm/amd/display: Calculate output_color_space after pixel
encoding adjustment
      drm/amd/display: Fix COLOR_SPACE_YCBCR2020_TYPE matrix

Jos=C3=A9 Exp=C3=B3sito (1):
      HID: uclogic: Add support for XP-PEN Deco 01 V2

Juhyung Park (1):
      usb-storage: apply IGNORE_UAS only for HIKSEMI MD202 on RTL9210

Kees Cook (1):
      bnxt: Do not read past the end of test names

Keith Busch (1):
      nvme-pci: fix timeout request state check

Kevin Hao (1):
      octeontx2-pf: Fix the use of GFP_KERNEL in atomic context on rt

Khazhismel Kumykov (1):
      gsmi: fix null-deref in gsmi_get_variable

Klaus Kudielka (2):
      Revert "ARM: dts: armada-38x: Fix compatible string for gpios"
      Revert "ARM: dts: armada-39x: Fix compatible string for gpios"

Koba Ko (1):
      dmaengine: Fix double increment of client_count in dma_chan_get()

Konrad Dybcio (6):
      dt-bindings: interconnect: Add UFS clocks to MSM8996 A2NoC
      interconnect: qcom: msm8996: Provide UFS clocks to A2NoC
      interconnect: qcom: msm8996: Fix regmap max_register values
      interconnect: qcom: rpm: Use _optional func for provider clocks
      arm64: dts: qcom: msm8992: Don't use sfpb mutex
      arm64: dts: qcom: msm8992-libra: Fix the memory map

Krzysztof Kozlowski (5):
      ARM: dts: qcom: apq8084-ifc6540: fix overriding SDHCI
      arm64: dts: qcom: sm8350: correct SDHCI interconnect arguments
      arm64: dts: imx8mq-thor96: fix no-mmc property for SDHCI
      Bluetooth: hci_qca: Fix driver shutdown on closed serdev
      tty: serial: qcom-geni-serial: fix slab-out-of-bounds on RX FIFO buff=
er

Kurt Kanzenbach (1):
      net: stmmac: Fix queue statistics reading

Lang Yu (2):
      drm/amdgpu: correct MEC number for gfx11 APUs
      drm/amdgpu: allow multipipe policy on ASICs with one MEC

Leon Romanovsky (2):
      net/mlx5e: Remove optimization which prevented update of ESN state
      net/mlx5e: Protect global IPsec ASO

Li Jun (1):
      arm64: dts: imx8mp: correct usb clocks

Liam Howlett (3):
      nommu: fix memory leak in do_mmap() error path
      nommu: fix do_munmap() error path
      nommu: fix split_vma() map_count error

Lino Sanfilippo (1):
      serial: amba-pl011: fix high priority character transmission in rs486=
 mode

Linus Torvalds (2):
      ext4: deal with legacy signed xattr name hash values
      Linux 6.2-rc5

Liu Shixin (1):
      dmaengine: xilinx_dma: call of_node_put() when breaking out of
for_each_child_of_node()

Lizzy Fleckenstein (1):
      init/Kconfig: fix typo (usafe -> unsafe)

Lorenzo Bianconi (2):
      wifi: mt76: dma: do not increment queue head if mt76_dma_add_buf fail=
s
      wifi: mt76: handle possible mt76_rx_token_consume failures

Lorenzo Stoakes (1):
      mm: update mmap_sem comments to refer to mmap_lock

Lucas Stach (2):
      soc: imx: imx8mp-blk-ctrl: enable global pixclk with HDMI_TX_PHY PD
      soc: imx: imx8mp-blk-ctrl: don't set power device name

Luis Gerhorst (1):
      bpf: Fix pointer-leak due to insufficient speculative store
bypass mitigation

Luiz Augusto von Dentz (4):
      Bluetooth: hci_sync: Fix use HCI_OP_LE_READ_BUFFER_SIZE_V2
      Bluetooth: ISO: Fix possible circular locking dependency
      Bluetooth: hci_event: Fix Invalid wait context
      Bluetooth: ISO: Fix possible circular locking dependency

Maciej =C5=BBenczykowski (1):
      usb: gadget: f_ncm: fix potential NULL ptr deref in ncm_bitrate()

Maor Dickman (2):
      net/mlx5: E-switch, Fix setting of reserved fields on
MODIFY_SCHEDULING_ELEMENT
      net/mlx5e: QoS, Fix wrongfully setting parent_element_id on
MODIFY_SCHEDULING_ELEMENT

Marco Felsch (1):
      arm64: dts: imx8mp-evk: pcie0-refclk cosmetic cleanup

Marek Vasut (4):
      arm64: dts: imx8mm: Drop xtal clock specifier from eDM SBC
      gpio: mxc: Protect GPIO irqchip RMW with bgpio spinlock
      gpio: mxc: Always set GPIOs used as interrupt source to INPUT mode
      serial: stm32: Merge hard IRQ and threaded IRQ handling into
single IRQ handler

Marijn Suijten (1):
      phy: Revert "phy: qualcomm: usb28nm: Add MDM9607 init sequence"

Mario Limonciello (2):
      gpiolib: acpi: Allow ignoring wake capability on pins that aren't in =
_AEI
      gpiolib: acpi: Add a ignore wakeup quirk for Clevo NL5xRU

Mark Brown (1):
      kselftest: Fix error message for unconfigured LLVM builds

Martin Liska (1):
      scripts: support GNU make 4.4 in jobserver-exec

Masahiro Yamada (6):
      tomoyo: fix broken dependency on *.conf.default
      tomoyo: avoid unneeded creation of builtin-policy.h
      init/version-timestamp.c: remove unneeded #include <linux/version.h>
      tomoyo: Omit use of bin2c
      kbuild: export top-level LDFLAGS_vmlinux only to scripts/Makefile.vml=
inux
      kbuild: fix 'make modules' error when CONFIG_DEBUG_INFO_BTF_MODULES=
=3Dy

Mathias Nyman (5):
      xhci: Fix null pointer dereference when host dies
      xhci: Add update_hub_device override for PCI xHCI hosts
      xhci: Add a flag to disable USB3 lpm on a xhci root port level.
      usb: acpi: add helper to check port lpm capability using acpi _DSM
      xhci: Detect lpm incapable xHC USB3 roothub ports from ACPI tables

Matt Atwood (2):
      drm/i915/dg2: Introduce Wa_18018764978
      drm/i915/dg2: Introduce Wa_18019271663

Matthew Howell (1):
      serial: exar: Add support for Sealevel 7xxxC serial cards

Matthias Kaehlcke (2):
      usb: misc: onboard_hub: Invert driver registration order
      usb: misc: onboard_hub: Move 'attach' work to the driver

Matthieu Baerts (2):
      mptcp: netlink: respect v4/v6-only sockets
      selftests: mptcp: userspace: validate v4-v6 subflows mix

Maxime Ripard (3):
      firmware: raspberrypi: Fix type assignment
      drm/vc4: bo: Fix drmm_mutex_init memory hog
      drm/vc4: bo: Fix unused variable warning

Miaoqian Lin (1):
      soc: imx8m: Fix incorrect check for of_clk_get_by_name()

Michael Adler (1):
      USB: serial: cp210x: add SCALANCE LPE-9000 device id

Miguel Ojeda (1):
      docs: kbuild: remove mention to dropped $(objtree) feature

Mika Westerberg (3):
      thunderbolt: Do not call PM runtime functions in tb_retimer_scan()
      thunderbolt: Use correct function to calculate maximum USB3 link rate
      thunderbolt: Disable XDomain lane 1 only in software connection manag=
er

Mohan Kumar (1):
      dmaengine: tegra210-adma: fix global intr clear

Naohiro Aota (1):
      btrfs: zoned: enable metadata over-commit for non-ZNS setup

Nhat Pham (1):
      Docs/admin-guide/mm/zswap: remove zsmalloc's lack of writeback warnin=
g

Nirmoy Das (1):
      drm/i915: Remove unused variable

Nithin Dabilpuram (1):
      octeontx2-af: restore rxc conf after teardown sequence

Ola Jeppsson (1):
      misc: fastrpc: Fix use-after-free race condition for maps

Pablo Neira Ayuso (1):
      netfilter: nft_payload: incorrect arithmetics when fetching VLAN
header bits

Paolo Abeni (2):
      mptcp: explicitly specify sock family at subflow creation time
      net/ulp: use consistent error code when blocking ULP

Patrice Chotard (4):
      ARM: dts: stm32: Fix qspi pinctrl phandle for stm32mp15xx-dhcor-som
      ARM: dts: stm32: Fix qspi pinctrl phandle for stm32mp15xx-dhcom-som
      ARM: dts: stm32: Fix qspi pinctrl phandle for stm32mp157c-emstamp-arg=
on
      ARM: dts: stm32: Fix qspi pinctrl phandle for stm32mp151a-prtt1l

Paul E. McKenney (1):
      tomoyo: Remove "select SRCU"

Paul Moore (2):
      bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD and
PERF_BPF_EVENT_PROG_UNLOAD
      bpf: remove the do_idr_lock parameter from bpf_prog_free_id()

Paulo Alcantara (7):
      cifs: fix potential deadlock in cache_refresh_path()
      cifs: avoid re-lookups in dfs_cache_find()
      cifs: don't take exclusive lock for updating target hints
      cifs: remove duplicate code in __refresh_tcon()
      cifs: handle cache lookup errors different than -ENOENT
      cifs: fix return of uninitialized rc in dfs_cache_update_tgthint()
      cifs: remove unused function

Pavel Begunkov (3):
      block: fix hctx checks for batch allocation
      io_uring/msg_ring: fix flagging remote execution
      io_uring/msg_ring: fix remote queue to disabled ring

Pawel Laszczak (1):
      usb: cdns3: remove fetched trb from cache before dequeuing

Peter Foley (1):
      kconfig: Update all declared targets

Peter Harliman Liem (1):
      dmaengine: lgm: Move DT parsing after initialization

Peter Xu (1):
      mm/hugetlb: pre-allocate pgtable pages for uffd wr-protects

Pierre-Olivier Mercier (1):
      Revert "arm64: dts: meson-sm1-odroid-hc4: disable unused USB PHY0"

Pietro Borrello (3):
      HID: check empty report_list in hid_validate_values()
      HID: check empty report_list in bigben_probe()
      HID: betop: check shape of output reports

Prashant Malani (3):
      usb: typec: altmodes/displayport: Add pin assignment helper
      usb: typec: altmodes/displayport: Fix pin assignment calculation
      usb: typec: altmodes/displayport: Use proper macro for pin
assignment check

Qu Wenruo (2):
      btrfs: add extra error messages to cover non-ENOMEM errors from
device_add_list()
      btrfs: qgroup: do not warn on record without old_roots populated

Rafael J. Wysocki (1):
      MAINTAINERS: Update the ACPICA development list address

Rahul Rameshbabu (1):
      sch_htb: Avoid grafting on htb_destroy_class_offload when destroying =
htb

Raju Rangoju (2):
      amd-xgbe: TX Flow Ctrl Registers are h/w ver dependent
      amd-xgbe: Delay AN timeout during KR training

Rakesh Sankaranarayanan (1):
      net: dsa: microchip: ksz9477: port map correction in ALU table
entry register

Randy Dunlap (4):
      reset: ti-sci: honor TI_SCI_PROTOCOL setting when not COMPILE_TEST
      phy: ti: fix Kconfig warning and operator precedence
      lib/win_minmax: use /* notation for regular comments
      net: mlx5: eliminate anonymous module_init & module_exit

Rasmus Villemoes (1):
      init/Kconfig: fix LOCALVERSION_AUTO help text

Reinette Chatre (3):
      dmaengine: idxd: Let probe fail when workqueue cannot be enabled
      dmaengine: idxd: Prevent use after free on completion memory
      dmaengine: idxd: Do not call DMX TX callbacks during workqueue disabl=
e

Ricardo Ribalda (1):
      xhci-pci: set the dma max_seg_size

Richard Zhu (1):
      phy: freescale: imx8m-pcie: Add one missing error return

Rob Clark (1):
      drm/msm/gpu: Fix potential double-free

Robert Foss (1):
      MAINTAINERS: update Robert Foss' email address

Robert Hancock (1):
      net: macb: fix PTP TX timestamp failure due to packet padding

Roderick Colenbrander (2):
      HID: playstation: sanity check DualShock4 calibration data.
      HID: playstation: sanity check DualSense calibration data.

Ryusuke Konishi (1):
      nilfs2: fix general protection fault in nilfs_btree_insert()

Samuel Holland (1):
      mmc: sunxi-mmc: Fix clock refcount imbalance during unbind

Sasa Dragic (1):
      drm/i915: re-disable RC6p on Sandy Bridge

SeongJae Park (1):
      include/linux/mm: fix release_pages_arg kernel doc comment

Shang XiaoJing (2):
      phy: usb: sunplus: Fix potential null-ptr-deref in sp_usb_phy_probe()
      phy: rockchip-inno-usb2: Fix missing clk_disable_unprepare() in
rockchip_usb2phy_power_on()

Shawn.Shao (1):
      Add exception protection processing for vd in axi_chan_handle_err fun=
ction

Shyam Sundar S K (1):
      MAINTAINERS: Update AMD XGBE driver maintainers

Siddh Raman Pant (1):
      erofs/zmap.c: Fix incorrect offset calculation

Sohom Datta (1):
      perf expr: Prevent normalize() from reading into undefined
memory in the expression lexer

Sriram R (1):
      mac80211: Fix MLO address translation for multiple bss case

Srujana Challa (6):
      octeontx2-af: recover CPT engine when it gets fault
      octeontx2-af: add mbox for CPT LF reset
      octeontx2-af: modify FLR sequence for CPT
      octeontx2-af: optimize cpt pf identification
      octeontx2-af: update cpt lf alloc mailbox
      octeontx2-af: add mbox to return CPT_AF_FLT_INT info

Stephan Gerhold (2):
      dt-bindings: soc: qcom: apr: Make qcom,protection-domain optional aga=
in
      soc: qcom: apr: Make qcom,protection-domain optional again

Sudheer Mogilappagari (1):
      ethtool: add netlink attr in rss get reply only if value is not null

Suren Baghdasaryan (1):
      mm: fix vma->anon_name memory leak for anonymous shmem VMAs

Szymon Heidrich (2):
      wifi: rndis_wlan: Prevent buffer overflow in rndis_query_oid
      net: usb: sr9700: Handle negative len

Tetsuo Handa (1):
      tomoyo: Update website link

Thomas Wei=C3=9Fschuh (1):
      kheaders: explicitly validate existence of cpio command

Thomas Zimmermann (2):
      drm/i915: Allow switching away via vga-switcheroo if uninitialized
      drm/fb-helper: Set framebuffer for vga-switcheroo clients

Tiezhu Yang (1):
      LoongArch: Use common function sign_extend64()

Tim Harvey (1):
      arm64: dts: imx8mm-venice-gw7901: fix USB2 controller OC polarity

Tobias Schramm (1):
      serial: atmel: fix incorrect baudrate setup

Tonghao Zhang (1):
      bpf: hash map, avoid deadlock with suitable hash mask

Udipto Goswami (2):
      usb: gadget: f_fs: Prevent race during ffs_ep0_queue_wait
      usb: gadget: f_fs: Ensure ep0req is dequeued before free_request

Ulf Hansson (1):
      Revert "arm64: dts: qcom: sm8250: Disable the not yet supported
cluster idle state"

Utkarsh Patel (1):
      thunderbolt: Do not report errors if on-board retimers are found

Vijaya Krishna Nivarthi (1):
      dmaengine: qcom: gpi: Set link_rx bit on GO TRE for rx operation

Viresh Kumar (1):
      thermal: core: call put_device() only after device_register() fails

Vishnu Dasa (1):
      VMCI: Use threaded irqs instead of tasklets

Vlad Buslov (1):
      net/mlx5e: Avoid false lock dependency warning on tc_ht even more

Vladimir Oltean (1):
      net: enetc: avoid deadlock in enetc_tx_onestep_tstamp()

Willem de Bruijn (1):
      selftests/net: toeplitz: fix race on tpacket_v3 block close

Xin Long (1):
      Revert "net: team: use IFF_NO_ADDRCONF flag to prevent ipv6 addrconf"

Xingyuan Mo (1):
      NFSD: fix use-after-free in nfsd4_ssc_setup_dul()

Xu Yang (1):
      usb: chipidea: core: fix possible constant 0 if use
IS_ERR(ci->role_switch)

Yang Yingliang (5):
      usb: musb: fix error return code in omap2430_probe()
      net/mlx5: fix missing mutex_unlock in mlx5_fw_fatal_reporter_err_work=
()
      device property: fix of node refcount leak in
fwnode_graph_get_next_endpoint()
      w1: fix deadloop in __w1_remove_master_device()
      w1: fix WARNING after calling w1_process()

Ying Hsu (1):
      Bluetooth: Fix possible deadlock in rfcomm_sk_state_change

Yishai Hadas (1):
      lib/scatterlist: Fix to calculate the last_pg properly

Yonatan Nachum (1):
      RDMA/core: Fix ib block iterator counter overflow

Yoshihiro Shimoda (1):
      phy: renesas: r8a779f0-eth-serdes: Fix register setting

Youling Tang (1):
      LoongArch: Simplify larch_insn_gen_xxx implementation

Yu Kuai (2):
      block, bfq: switch 'bfqg->ref' to use atomic refcount apis
      blk-cgroup: fix missing pd_online_fn() while activating policy

Zach O'Keefe (2):
      mm/MADV_COLLAPSE: don't expand collapse when vm_end is past requested=
 end
      mm/shmem: restore SHMEM_HUGE_DENY precedence over MADV_COLLAPSE

Zhengchao Shao (2):
      Bluetooth: hci_conn: Fix memory leaks
      Bluetooth: hci_sync: fix memory leak in hci_update_adv_data()

hongao (1):
      drm/amd/display: Fix set scaling doesn's work

jie1zhan (1):
      drm/amdgpu: Correct the power calcultion for Renior/Cezanne.
