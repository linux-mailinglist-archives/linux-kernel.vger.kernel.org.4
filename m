Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E14670B09E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 23:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjEUVNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 17:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUVN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 17:13:28 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E504B4
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 14:13:25 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-510b6a249a8so9619133a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 14:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684703603; x=1687295603;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1kSiGHrP8blJ3oeDH/mCQb1oOMZ9NSzHQcJI08/FSBY=;
        b=PVashqxD/xEPng7NAzZObYF4/LMQZu6VOMa9fgnBkm61h7lENkJaeYGcduYa4cFs9i
         ffC6hOIIlUdM9S5lprAOU1afbZvsjqEqcl51GiUqk8kq/Nm0AKOpahjqdmoTrpaEL3y+
         DBrNxN1sdui/N7nPBJ24BmcMCFHMZxDzm5Tpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684703603; x=1687295603;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1kSiGHrP8blJ3oeDH/mCQb1oOMZ9NSzHQcJI08/FSBY=;
        b=jXJmtuZH5OSW92L+Q+ScAS506kUK6rnzlpNIcWsOMQb5X9/ywuHaKfqI7njGrEYcUV
         p4bvOddzGQB8timxxWt8QLyoPNEbttvoe30ytpxVlwE1jwUYeteyY9wA8BBSFzvHMUbg
         ihw70FpKIt/WNtLMmC4hZuKD9/NT6HCAvsRCG0VObLTYSeF1qumOVYbL7puQMRoQ6vLx
         lEe4Evvu4w9rj1yawi/o3lEC9u/MlX1TKSUoLl32B2dWjnU789ko01CeCSdNNN2kW1rv
         nH6bvAQHGALgP+sLJ5I9Tdgx6tLcVz2OJoPbMRz3TDI3StUQwdNWZSWdhlwclwDJw25W
         xNDQ==
X-Gm-Message-State: AC+VfDyydGWdrsv7Ssz13FMyyy0p2dwtONLzpnboWvC+ItivLN8376Br
        HRxuA7BJRqfve74Ja7XTVEv8FstnxWq2S1qmyY3lVA==
X-Google-Smtp-Source: ACHHUZ5LcI3c79fALgTILiwSumvoO1I8gFEsILkNaLHmOiZYvMQkiUY7zNNvy8eVKKjupCWnQea2OA==
X-Received: by 2002:a05:6402:12c3:b0:510:cff9:465a with SMTP id k3-20020a05640212c300b00510cff9465amr7687212edx.1.1684703602910;
        Sun, 21 May 2023 14:13:22 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id i26-20020aa7dd1a000000b0050bd9d3ddf3sm2194839edv.42.2023.05.21.14.13.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 May 2023 14:13:22 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-50be17a1eceso9558645a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 14:13:22 -0700 (PDT)
X-Received: by 2002:a05:6402:148e:b0:510:e499:1425 with SMTP id
 e14-20020a056402148e00b00510e4991425mr6973763edv.6.1684703601436; Sun, 21 May
 2023 14:13:21 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 May 2023 14:13:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgL4Sa64qUZkpAs06t9UKoNyAYqBpzmukefJz8P8sa2=Q@mail.gmail.com>
Message-ID: <CAHk-=wgL4Sa64qUZkpAs06t9UKoNyAYqBpzmukefJz8P8sa2=Q@mail.gmail.com>
Subject: Linux 6.4-rc3
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here we are, another week gone by, and another rc released.

Nothing really huge stands out there. Roughly half the patch is
drivers, with - as usual - networking and gpu being the bulk of it,
but there's various other driver fixes in there too (usb, sound,
media, ...).

The other half is the usual fairly random stuff: tooling, arch updates
(arm, s390, x86), core networking, documentation, filesystems...

The appended shortlog gives a flavor of the details for anybody who is
interested.

Please do continue testing,

                  Linus

---

Adrian Huang (1):
      nvme-pci: clamp max_hw_sectors based on DMA optimized limitation

Adrian Hunter (2):
      perf test test_intel_pt.sh: Test sample mode with event with PMU name
      perf parse-events: Do not break up AUX event group

Ahmed Zaki (2):
      ice: Fix stats after PF reset
      iavf: send VLAN offloading caps once after VFR

Ai Chao (1):
      ALSA: hda/realtek: Add a quirk for HP EliteDesk 805

Aidan MacDonald (1):
      ASoC: jz4740-i2s: Make I2S divider calculations more robust

Alan Stern (2):
      USB: usbtmc: Fix direction for 0-length ioctl control messages
      fbdev: udlfb: Fix endpoint check

Aleksandr Loktionov (1):
      igb: fix bit_shift to be in [1..8] range

Alex Deucher (2):
      drm/amdgpu/gfx11: update gpu_clock_counter logic
      drm/amdgpu/gmc11: implement get_vbios_fb_size()

Alexander Gordeev (2):
      s390/topology: honour nr_cpu_ids when adding CPUs
      s390/ipl: fix IPIB virtual vs physical address confusion

Alexandru Sorodoc (1):
      ALSA: hda/realtek: Add quirks for ASUS GU604V and GU603V

Alexis Lothor=C3=A9 (1):
      net: dsa: rzn1-a5psw: fix STP states handling

Alon Giladi (2):
      wifi: iwlwifi: fix OEM's name in the ppag approved list
      wifi: iwlwifi: mvm: fix OEM's name in the tas approved list

Andrea Mayer (2):
      selftests: seg6: disable DAD on IPv6 router cfg for
srv6_end_dt4_l3vpn_test
      selftets: seg6: disable rp_filter by default in srv6_end_dt4_l3vpn_te=
st

Andrew Davis (1):
      serial: 8250_exar: Add support for USR298x PCI Modems

Ard Biesheuvel (1):
      SUNRPC: Avoid relying on crypto API to derive CBC-CTS output IV

Ariel Malamud (1):
      wifi: iwlwifi: mvm: Add locking to the rate read flow

Arnaldo Carvalho de Melo (7):
      perf build: Gracefully fail the build if BUILD_BPF_SKEL=3D1 is
specified and clang isn't available
      tools headers UAPI: Sync linux/prctl.h with the kernel sources
      tools headers UAPI: Sync s390 syscall table file that wires up
the memfd_secret syscall
      tools headers x86 cpufeatures: Sync with the kernel sources
      tools headers: Update the copy of x86's mem{cpy,set}_64.S used
in 'perf bench'
      tools headers UAPI: Sync arch prctl headers with the kernel sources
      tools headers disabled-features: Sync with the kernel sources

Arnaud Vrac (2):
      drm/msm/dpu: tweak msm8998 hw catalog values
      drm/msm/dpu: tweak lm pairings in msm8998 hw catalog

Arnd Bergmann (12):
      media: pvrusb2: fix DVB_CORE dependency
      drm/exynos: fix g2d_open/close helper function definitions
      wifi: b43: fix incorrect __packed annotation
      ALSA: cs46xx: mark snd_cs46xx_download_image as static
      ALSA: oss: avoid missing-prototype warnings
      tracing: make ftrace_likely_update() declaration visible
      net: isa: include net/Space.h
      atm: hide unused procfs functions
      bridge: always declare tunnel functions
      mdio_bus: unhide mdio_bus_init prototype
      fbdev: fbmem: mark get_fb_unmapped_area() static
      fbdev: i810: include i810_main.h in i810_dvt.c

Azeem Shaikh (1):
      NFSD: Remove open coding of string copy

Badhri Jagan Sridharan (1):
      usb: typec: altmodes/displayport: fix pin_assignment_show

Bas Nieuwenhuizen (1):
      drm/amdgpu/gfx10: Disable gfxoff before disabling powergating.

Benedict Wong (1):
      xfrm: Check if_id in inbound policy/secpath match

Benjamin Poirier (1):
      net: selftests: Fix optstring

Bharath SM (2):
      SMB3: Close all deferred handles of inode in case of handle lease bre=
ak
      SMB3: drop reference to cfile before sending oplock break

Chih-Yen Chang (3):
      ksmbd: fix global-out-of-bounds in smb2_find_context_vals
      ksmbd: fix wrong UserName check in session_user
      ksmbd: allocate one more byte for implied bcc[0]

Christoph Hellwig (2):
      nvme-multipath: don't call blk_mark_disk_dead in nvme_mpath_remove_di=
sk
      block: remove NFL4_UFLG_MASK

Christophe JAILLET (4):
      KVM: arm64: Slightly optimize flush_context()
      KVM: arm64: Use the bitmap API to allocate bitmaps
      wifi: mac80211: Fix puncturing bitmap handling in
__ieee80211_csa_finalize()
      cassini: Fix a memory leak in the error handling path of cas_init_one=
()

Chuck Lever (3):
      SUNRPC: Fix encoding of accepted but unsuccessful RPC replies
      SUNRPC: Fix error handling in svc_setup_socket()
      SUNRPC: Fix trace_svc_register() call site

Cl=C3=A9ment L=C3=A9ger (2):
      net: dsa: rzn1-a5psw: enable management frames for CPU port
      net: dsa: rzn1-a5psw: disable learning for standalone ports

Dan Carpenter (3):
      ALSA: firewire-digi00x: prevent potential use after free
      usb: dwc3: fix a test for error in dwc3_core_init()
      fbdev: omapfb: panel-tpo-td043mtea1: fix error code in probe()

Daniel Smith (1):
      nvme-pci: Add quirk for Teamgroup MP33 SSD

Dario Binacchi (5):
      dt-bindings: net: can: add "st,can-secondary" property
      ARM: dts: stm32f429: put can2 in secondary mode
      ARM: dts: stm32: add pin map for CAN controller on stm32f7
      can: bxcan: add support for single peripheral configuration
      ARM: dts: stm32: add CAN support on stm32f746

Dawid Wesierski (1):
      ice: Fix ice VF reset during iavf initialization

Domenico Cerasuolo (1):
      mm: fix zswap writeback race condition

Dong Chenchen (1):
      net: nsh: Use correct mac_offset to unwind gso skb in nsh_gso_segment=
()

Doug Berger (2):
      serial: 8250_bcm7271: balance clk_enable calls
      serial: 8250_bcm7271: fix leak in `brcmuart_probe`

Douglas Anderson (1):
      ASoC: mediatek: mt8186: Fix use-after-free in driver remove path

Duoming Zhou (1):
      media: netup_unidvb: fix use-after-free at del_timer()

Eric Dumazet (3):
      ipv6: remove nexthop_fib6_nh_bh()
      tcp: fix possible sk_priority leak in tcp_v4_send_reset()
      vlan: fix a potential uninit-value in vlan_dev_hard_start_xmit()

Evan Quan (1):
      drm/amd/pm: fix possible power mode mismatch between driver and PMFW

Feng Liu (1):
      virtio_net: Fix error unwinding of XDP initialization

Florian Fainelli (1):
      net: bcmgenet: Restore phy_stop() depending upon suspend/close

Florian Westphal (2):
      netfilter: nf_tables: fix nft_trans type confusion
      netfilter: nft_set_rbtree: fix null deref on element insertion

Francesco Dolcini (2):
      Revert "usb: gadget: udc: core: Prevent redundant calls to pullup"
      Revert "usb: gadget: udc: core: Invoke usb_gadget_connect only
when started"

Gaurav Batra (2):
      powerpc/iommu: DMA address offset is incorrectly calculated with 2MB =
TCEs
      powerpc/iommu: Incorrect DDW Table is referenced for SR-IOV device

Geert Uytterhoeven (4):
      serial: 8250: Document termios parameter of serial8250_em485_config()
      can: CAN_BXCAN should depend on ARCH_STM32
      ARM: perf: Mark all accessor functions inline
      arm64: perf: Mark all accessor functions inline

George Kennedy (1):
      vc_screen: reload load of struct vc_data pointer in vcs_write()
to avoid UAF

Greg Kroah-Hartman (1):
      driver core: class: properly reference count class_dev_iter()

Gregory Greenman (2):
      wifi: iwlwifi: mvm: rfi: disable RFI feature
      wifi: iwlwifi: mvm: fix access to fw_id_to_mac_id

Grygorii Strashko (1):
      net: phy: dp83867: add w/a for packet errors seen with short cables

Guchun Chen (1):
      drm/amdgpu: skip disabling fence driver src_irqs when device is unplu=
gged

Guilherme G. Piccoli (1):
      drm/amdgpu/gfx11: Adjust gfxoff before powergating on gfx11 as well

Gustav Johansson (1):
      ksmbd: smb2: Allow messages padded to 8byte boundary

Hans de Goede (1):
      wifi: brcmfmac: Check for probe() id argument being NULL

Hao Zeng (1):
      cpupower:Fix resource leaks in sysfs_get_enabled()

Hari Bathini (1):
      powerpc/bpf: populate extable entries only during the last pass

Heiko Carstens (3):
      s390/crypto: use vector instructions only if available for ChaCha20
      s390/defconfigs: set CONFIG_INIT_STACK_NONE=3Dy
      s390/qdio: fix do_sqbs() inline assembly constraint

Helge Deller (2):
      fbdev: udlfb: Use usb_control_msg_send()
      fbdev: stifb: Whitespace cleanups

Holger Dengler (1):
      s390/pkey: zeroize key blobs

Hristo Venev (1):
      nvme-pci: add quirk for missing secondary temperature thresholds

Huayu Chen (1):
      nfp: fix NFP_NET_MAX_DSCP definition error

Hyunwoo Kim (5):
      media: ttusb-dec: fix memory leak in ttusb_dec_exit_dvb()
      media: dvb-core: Fix use-after-free on race condition at dvb_frontend
      media: dvb-core: Fix use-after-free due on race condition at dvb_net
      media: dvb-core: Fix use-after-free due to race at dvb_register_devic=
e()
      media: dvb-core: Fix use-after-free due to race condition at
dvb_ca_en50221

Ian Rogers (9):
      perf metric: Change divide by zero and !support events behavior
      perf stat: Introduce skippable evsels
      perf metric: JSON flag to not group events if gathering a metric grou=
p
      perf parse-events: Don't reorder ungrouped events by PMU
      perf evsel: Modify group pmu name for software events
      perf build: Add system include paths to BPF builds
      perf metrics: Avoid segv with --topdown for metrics without a group
      perf test attr: Update no event/metric expectations
      perf test attr: Fix python SafeConfigParser() deprecation warning

Ido Schimmel (1):
      devlink: Fix crash with CONFIG_NET_NS=3Dn

Ilan Peer (1):
      wifi: cfg80211: Drop entries with invalid BSSIDs in RNR

Ilya Leoshkevich (2):
      statfs: enforce statfs[64] structure initialization
      s390/uapi: cover statfs padding by growing f_spare

Jacob Xu (1):
      KVM: VMX: Fix header file dependency of asm/vmx.h

Jakub Kicinski (3):
      MAINTAINERS: don't CC docs@ for netlink spec changes
      MAINTAINERS: exclude wireless drivers from netdev
      MAINTAINERS: skip CCing netdev for Bluetooth patches

James Clark (2):
      perf arm64: Fix build with refcount checking
      perf cs-etm: Fix contextid validation

Jan Sokolowski (1):
      ice: Fix undersized tx_flags variable

Jarkko Sakkinen (2):
      tpm_tis: Use tpm_chip_{start,stop} decoration inside tpm_tis_resume
      tpm: Prevent hwrng from activating during resume

Jason Gunthorpe (2):
      powerpc/iommu: Remove iommu_del_device()
      s390/iommu: get rid of S390_CCW_IOMMU and S390_AP_IOMMU

Jeremy Soller (2):
      ASoC: amd: yc: Add DMI entry to support System76 Pangolin 12
      ALSA: hda/realtek: Add quirk for Clevo L140AU

Jerry Snitselaar (1):
      tpm/tpm_tis: Disable interrupts for more Lenovo devices

Jesse Zhang (1):
      drm/amdgpu: Differentiate between Raven2 and Raven/Picasso
according to revision id

Jianhua Lu (1):
      dt-bindings: display/msm: dsi-controller-main: Document qcom,
master-dsi and qcom, sync-dual-dsi

Jie Wang (2):
      net: hns3: fix output information incomplete for dumping tx
queue info with debugfs
      net: hns3: fix reset delay time to avoid configuration timeout

Jijie Shao (2):
      net: hns3: fix sending pfc frames after reset issue
      net: hns3: fix reset timeout when enable full VF

Jimmy Assarsson (6):
      can: kvaser_pciefd: Set CAN_STATE_STOPPED in kvaser_pciefd_stop()
      can: kvaser_pciefd: Clear listen-only bit if not explicitly requested
      can: kvaser_pciefd: Call request_irq() before enabling interrupts
      can: kvaser_pciefd: Empty SRB buffer in probe
      can: kvaser_pciefd: Do not send EFLUSH command on TFD interrupt
      can: kvaser_pciefd: Disable interrupts in probe error path

Jingyu Wang (1):
      KVM: arm64: Fix repeated words in comments

Jiri Olsa (1):
      perf lock contention: Add empty 'struct rq' to satisfy libbpf
'runqueue' type verification

Jiri Pirko (1):
      devlink: change per-devlink netdev notifier to static one

Joan Bruguera Mic=C3=B3 (1):
      mm: shrinkers: fix race condition on debugfs cleanup

Johannes Berg (11):
      um: harddog: fix modular build
      wifi: mac80211: fix min center freq offset tracing
      wifi: mac80211: simplify chanctx allocation
      wifi: mac80211: consider reserved chanctx for mindef
      wifi: mac80211: recalc chanctx mindef before assigning
      wifi: iwlwifi: mvm: always free dup_data
      wifi: iwlwifi: mvm: don't double-init spinlock
      wifi: iwlwifi: mvm: fix cancel_delayed_work_sync() deadlock
      wifi: iwlwifi: mvm: fix number of concurrent link checks
      wifi: iwlwifi: fw: fix DBGI dump
      wifi: iwlwifi: mvm: don't trust firmware n_channels

J=C3=B3 =C3=81gila Bitsch (1):
      usb: gadget: drop superfluous ':' in doc string

Kai Vehmanen (1):
      ASoC: SOF: pm: save io region state in case of errors in resume

Kai-Heng Feng (2):
      ALSA: hda/realtek: Fix mute and micmute LEDs for yet another HP lapto=
p
      net: wwan: t7xx: Ensure init is completed before system sleep

Ke Zhang (1):
      serial: arc_uart: fix of_iomap leak in `arc_serial_probe`

Konrad Gr=C3=A4fe (1):
      usb: gadget: u_ether: Fix host MAC address case

Krzysztof Kozlowski (3):
      serial: qcom-geni: fix enabling deactivated interrupt
      media: mn88443x: fix !CONFIG_OF error by drop of_match_ptr from ID ta=
ble
      ASoC: MAINTAINERS: drop Krzysztof Kozlowski from Samsung audio

Kuniyuki Iwashima (1):
      tun: Fix memory leak for detached NAPI queue.

Leon Romanovsky (2):
      xfrm: release all offloaded policy memory
      xfrm: Fix leak of dev tracker

Linus Torvalds (1):
      Linux 6.4-rc3

Linus Walleij (1):
      arm64: vdso: Pass (void *) to virt_to_page()

Linyu Yuan (1):
      usb: dwc3: fix gadget mode suspend interrupt handler issue

Liviu Dudau (1):
      MAINTAINERS: Cleanup Arm Display IP maintainers

Loic Poulain (1):
      block: Deny writable memory mapping if block is read-only

Luca Weiss (1):
      drm/msm/iommu: Fix null pointer dereference in no-IOMMU case

Lucas Tanure (1):
      MAINTAINERS: Remove self from Cirrus Codec drivers

Lukas Bulwahn (2):
      s390/Kconfig: remove obsolete configs SCHED_{BOOK,DRAWER}
      MAINTAINERS: repair pattern in DIALOG SEMICONDUCTOR DRIVERS

Luke D. Jones (1):
      ALSA: hda/realtek: Add quirk for 2nd ASUS GU603

M Chetan Kumar (1):
      net: wwan: iosm: fix NULL pointer dereference when removing device

Marc Kleine-Budde (1):
      Revert "ARM: dts: stm32: add CAN support on stm32f746"

Marc Zyngier (2):
      KVM: arm64: Constify start/end/phys fields of the pgtable walker data
      KVM: arm64: vgic: Add Apple M2 PRO/MAX cpus to the list of
broken SEIS implementations

Marcelo Ricardo Leitner (1):
      MAINTAINERS: sctp: move Neil to CREDITS

Marco Migliore (1):
      net: dsa: mv88e6xxx: Fix mv88e6393x EPC write command offset

Marijn Suijten (9):
      drm/msm/dpu: Assign missing writeback log_mask
      drm/msm/dpu: Remove unused INTF0 interrupt mask from SM6115/QCM2290
      drm/msm/dpu: Remove TE2 block and feature from DPU >=3D 5.0.0 hardwar=
e
      drm/msm/dpu: Move non-MDP_TOP INTF_INTR offsets out of hwio header
      drm/msm/dpu: Reindent REV_7xxx interrupt masks with tabs
      drm/msm/dpu: Fix PP_BLK_DIPHER -> DITHER typo
      drm/msm/dpu: Use V2 DITHER PINGPONG sub-block in SM8[34]50/SC8280XP
      drm/msm/dpu: Set PINGPONG block length to zero for DPU >=3D 7.0.0
      drm/msm/dpu: Remove duplicate register defines from INTF

Mario Limonciello (2):
      thunderbolt: Clear registers properly when auto clear isn't in use
      xhci-pci: Only run d3cold avoidance quirk for s2idle

Mark Brown (4):
      KVM: arm64: Document check for TIF_FOREIGN_FPSTATE
      KVM: arm64: Restructure check for SVE support in FP trap handler
      KVM: arm64: Clarify host SME state management
      selftests/ftrace: Improve integration with kselftest runner

Martin Blumenstingl (1):
      wifi: rtw88: sdio: Always use two consecutive bytes for word operatio=
ns

Martin Povi=C5=A1er (1):
      ASoC: dt-bindings: Adjust #sound-dai-cells on TI's single-DAI codecs

Martin Willi (1):
      Revert "Fix XFRM-I support for nested ESP tunnels"

Masami Hiramatsu (Google) (1):
      tracing: fprobe: Initialize ret valiable to fix smatch error

Mathias Nyman (1):
      xhci: Fix incorrect tracking of free space on transfer rings

Maurizio Lombardi (1):
      nvme: do not let the user delete a ctrl before a complete initializat=
ion

Maxim Kochetkov (1):
      ASoC: dwc: limit the number of overrun messages

Maxime Bizon (1):
      usb-storage: fix deadlock when a scsi command timeouts more than once

Michael Ellerman (3):
      powerpc/64s/radix: Fix soft dirty tracking
      powerpc/crypto: Fix aes-gcm-p10 build when VSX=3Dn
      mm: kfence: fix false positives on big endian

Michael Kelley (1):
      scsi: storvsc: Don't pass unused PFNs to Hyper-V host

Michael Lee (1):
      wifi: mac80211: Abort running color change when stopping the AP

Michal Luczaj (1):
      KVM: Fix vcpu_array[0] races

Michal Simek (1):
      dt-bindings: ata: ahci-ceva: Cover all 4 iommus entries

Min-Hua Chen (1):
      arm64/mm: mark private VM_FAULT_X defines as vm_fault_t

Ming Lei (1):
      ublk: fix AB-BA lockdep warning

Mingwei Zhang (1):
      KVM: VMX: add MSR_IA32_TSX_CTRL into msrs_to_save

Miri Korenblit (1):
      wifi: iwlwifi: Don't use valid_links to iterate sta links

Mirsad Goran Todorovac (1):
      wifi: mac80211: fortify the spinlock against deadlock by interrupt

Mukesh Sisodiya (1):
      wifi: iwlwifi: mvm: fix initialization of a return value

Mustapha Ghaddar (1):
      drm/amd/display: enable dpia validate

Nathan Chancellor (1):
      powerpc/boot: Disable power10 features after BOOTAFLAGS assignment

NeilBrown (2):
      SUNRPC: double free xprt_ctxt while still in use
      SUNRPC: always free ctxt when freeing deferred request

Nhat Pham (1):
      zsmalloc: move LRU update from zs_map_object() to zs_malloc()

Nikhil Mahale (1):
      ALSA: hda: Add NVIDIA codec IDs a3 through a7 to patch table

Niklas Schnelle (1):
      fbdev: atyfb: Remove unused clock determination

Nikolay Aleksandrov (1):
      mailmap: add entries for Nikolay Aleksandrov

Oliver Hartkopp (3):
      can: isotp: recvmsg(): allow MSG_CMSG_COMPAT flag
      can: j1939: recvmsg(): allow MSG_CMSG_COMPAT flag
      can: dev: fix missing CAN XL support in can_put_echo_skb()

Oliver Upton (2):
      KVM: arm64: Infer the PA offset from IPA in stage-2 map walker
      KVM: arm64: Infer PA offset from VA in hyp map walker

Pawe=C5=82 Anikiel (1):
      ASoC: ssm2602: Add workaround for playback distortions

Peng Zhang (1):
      maple_tree: make maple state reusable after mas_empty_area()

Peter Collingbourne (2):
      arm64: Also reset KASAN tag if page is not PG_mte_tagged
      arm64: mte: Do not set PG_mte_tagged if tags were not initialized

Peter Ujfalusi (1):
      ASoC: SOF: ipc3-topology: Make sure that only one cmd is sent in
dai_config

Petr Pavlu (1):
      cpufreq: ACPI: Prevent a warning when another frequency driver is loa=
ded

Pierre-Louis Bossart (9):
      ASoC: SOF: Intel: hda-mlink: fix sublink refcounting
      ASoC: SOF: Intel: hda-mlink: add helper to get SoundWire hlink
      ASoC: SOF: Intel: hda-mlink: fix base_ptr computation
      ASoC: SOF: Intel: hda-mlink: use 'ml_addr' parameter consistently
      ASoC: SOF: Intel: hda-mlink: initialize instance_offset member
      ASoC: SOF: Intel: hda-mlink: add helper to program SoundWire
PCMSyCM registers
      ASoC: SOF: debug: conditionally bump runtime_pm counter on exceptions
      ASoC: SOF: pcm: fix pm_runtime imbalance in error handling
      ASoC: SOF: sof-client-probes: fix pm_runtime imbalance in error handl=
ing

Pieter Jansen van Vuuren (1):
      sfc: disable RXFCS and RXALL features by default

Ping-Ke Shih (3):
      wifi: rtw89: 8852b: adjust quota to avoid SER L1 caused by
access null page
      wifi: rtw88: use work to update rate to avoid RCU warning
      wifi: rtw88: correct qsel_to_ep[] type as int

Po-Wen Kao (3):
      scsi: ufs: core: Fix MCQ tag calculation
      scsi: ufs: core: Rename symbol sizeof_utp_transfer_cmd_desc()
      scsi: ufs: core: Fix MCQ nr_hw_queues

Randy Dunlap (4):
      powerpc/fsl_uli1575: fix kconfig warnings and build errors
      Documentation: use capitalization for chapters and acronyms
      Documentation/filesystems: sharedsubtree: add section headings
      Documentation/filesystems: ramfs-rootfs-initramfs: use :Author:

Ranjani Sridharan (3):
      ASoC: SOF: topology: Fix logic for copying tuples
      ASoC: SOF: Separate the tokens for input and output pin index
      ASoC: SOF: topology: Fix tuples array allocation

Rob Clark (5):
      drm/msm/atomic: Don't try async if crtc not active
      drm/msm: Fix vmap madv warning
      drm/msm: Fix submit error-path leaks
      iommu/arm-smmu-qcom: Fix missing adreno_smmu's
      drm/msm: Be more shouty if per-process pgtables aren't working

Rob Herring (1):
      powerpc/isa-bridge: Fix ISA mapping when "ranges" is not present

Roger Quadros (2):
      usb: dwc3: gadget: Improve dwc3_gadget_suspend() and dwc3_gadget_resu=
me()
      usb: typec: tps6598x: Fix fault at module removal

Rub=C3=A9n G=C3=B3mez (1):
      ACPI: resource: Add IRQ override quirk for LG UltraPC 17U70P

Russell King (Oracle) (2):
      net: mdio: i2c: fix rollball accessors
      net: phylink: fix ksettings_set() ethtool call

Ryan C. Underwood (1):
      ALSA: hda/realtek: Apply HP B&O top speaker profile to Pavilion 15

Ryder Lee (2):
      wifi: mt76: mt7996: fix endianness of MT_TXD6_TX_RATE
      wifi: mt76: connac: fix stats->tx_bytes calculation

Ryusuke Konishi (1):
      nilfs2: fix use-after-free bug of nilfs_root in nilfs_evict_inode()

Sabrina Dubroca (1):
      xfrm: don't check the default policy if the policy allows the packet

Sagi Grimberg (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for HS-SSD-FUTURE 2048G

Sandipan Das (2):
      perf script: Skip aggregation for stat events
      perf test: Add stat test for record and script

Sean Christopherson (4):
      KVM: Use syscore_ops instead of reboot_notifier to hook restart/shutd=
own
      KVM: Don't enable hardware after a restart/shutdown is initiated
      KVM: VMX: Don't rely _only_ on CPUID to enforce XCR0
restrictions for ECREATE
      KVM: x86: Don't adjust guest's CPUID.0x12.1 (allowed SGX enclave XFRM=
)

Shengjiu Wang (1):
      ASoC: fsl_micfil: Fix error handler with pm_runtime_enable

Shenwei Wang (1):
      net: fec: remove the xdp_return_frame when lack of tx BDs

Simon Trimmer (1):
      ASoC: cs35l56: Prevent unbalanced pm_runtime in dsp_work() on SoundWi=
re

Srinivas Kandagatla (1):
      drm/msm/dp: unregister audio driver during unbind

Stefan Haberland (1):
      s390/dasd: fix command reject error on ESE devices

Suraj Kandpal (1):
      drm/i915/hdcp: Check if media_gt exists

Takashi Iwai (3):
      ALSA: usb-audio: Add a sample rate workaround for Line6 Pod Go
      media: dvb-core: Fix kernel WARNING for blocking operation in
wait_event*()
      ALSA: hda: Fix Oops by 9.1 surround channel names

Thomas Richter (1):
      perf test java symbol: Remove needless debuginfod queries

Thorsten Leemhuis (1):
      docs: quickly-build-trimmed-linux: various small fixes and improvemen=
ts

Tiezhu Yang (1):
      perf bench syscall: Fix __NR_execve undeclared build error

Tobias Brunner (2):
      xfrm: Reject optional tunnel/BEET mode templates in outbound policies
      af_key: Reject optional tunnel/BEET mode templates in outbound polici=
es

Tom Rix (3):
      nfsd: define exports_proc_ops with CONFIG_PROC_FS
      lockd: define nlm_port_min,max with CONFIG_SYSCTL
      netfilter: conntrack: define variables exp_nat_nla_policy and
any_addr with CONFIG_NF_NAT

Udipto Goswami (1):
      usb: dwc3: debugfs: Resume dwc3 before accessing registers

Uwe Kleine-K=C3=B6nig (1):
      net: fec: Better handle pm_runtime_get() failing in .remove()

V sujith kumar Reddy (1):
      ASoC: SOF: amd: Fix NULL pointer crash in acp_sof_ipc_msg_data functi=
on

Vineeth Vijayan (1):
      s390/cio: include subchannels without devices also for evaluation

Vitaliy Tomin (1):
      serial: Add support for Advantech PCI-1611U card

Vitaly Rodionov (1):
      ALSA: hda/realtek: Add quirk for HP EliteBook G10 laptops

Vladimir Oltean (1):
      net: pcs: xpcs: fix C73 AN not getting enabled

Wei Chen (6):
      media: dvb-usb: az6027: fix three null-ptr-deref in az6027_i2c_xfer()
      media: dvb-usb-v2: ec168: fix null-ptr-deref in ec168_i2c_xfer()
      media: dvb-usb-v2: ce6230: fix null-ptr-deref in ce6230_i2c_master_xf=
er()
      media: dvb-usb: digitv: fix null-ptr-deref in digitv_i2c_xfer()
      media: dvb-usb: dw2102: fix uninit-value in su3000_read_mac_address
      media: netup_unidvb: fix irq init by register it at the end of probe

Weitao Wang (1):
      USB: UHCI: adjust zhaoxin UHCI controllers OverCurrent bit value

Wenchao Hao (2):
      scsi: Revert "scsi: core: Do not increase scsi_device's
iorequest_cnt if dispatch failed"
      scsi: core: Decrease scsi_device's iorequest_cnt if dispatch failed

Wyes Karny (1):
      cpupower: Make TSC read per CPU for Mperf monitor

Xin Long (4):
      erspan: get the proto with the md version for collect_md
      tipc: add tipc_bearer_min_mtu to calculate min mtu
      tipc: do not update mtu if msg_max is too small in mtu negotiation
      tipc: check the bearer min mtu properly when setting it by netlink

Xiubo Li (2):
      ceph: silence smatch warning in reconnect_caps_cb()
      ceph: force updating the msg pointer in non-split case

Yang Jihong (1):
      perf bpf skels: Make vmlinux.h use bpf.h and perf_event.h in
source directory

Yanteng Si (7):
      tools headers UAPI: Sync the linux/in.h with the kernel sources
      tools headers UAPI: Sync the drm/drm.h with the kernel sources
      tools headers UAPI: Sync the i915_drm.h with the kernel sources
      tools headers UAPI: Sync the linux/const.h with the kernel headers
      tools include UAPI: Sync the sound/asound.h copy with the kernel sour=
ces
      tools headers kvm: Sync uapi/{asm/linux} kvm.h headers with the
kernel sources
      tools arch x86: Sync the msr-index.h copy with the kernel sources

Yi Lai (1):
      selftests/sgx: Add "test_encl.elf" to TEST_FILES

YongSu Yoo (2):
      media: dvb_demux: fix a bug for the continuity counter
      media: dvb_ca_en50221: fix a size write bug

Yun Lu (1):
      wifi: rtl8xxxu: fix authentication timeout due to incorrect RCR value

Ze Gao (4):
      rethook: use preempt_{disable, enable}_notrace in
rethook_trampoline_handler
      fprobe: make fprobe_kprobe_handler recursion free
      fprobe: add recursion detection in fprobe_exit_handler
      rethook, fprobe: do not trace rethook related functions

Zhang Shurong (1):
      media: dvb-usb-v2: rtl28xxu: fix null-ptr-deref in rtl28xxu_i2c_xfer

Zhengchao Shao (1):
      mac80211_hwsim: fix memory leak in hwsim_new_radio_nl

Zhuang Shengen (1):
      vsock: avoid to close connected socket after the timeout
