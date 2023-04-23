Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463F06EC1D0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 21:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjDWTTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 15:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjDWTTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 15:19:40 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EACE52
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 12:19:38 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-94f3cd32799so654484066b.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 12:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682277576; x=1684869576;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hilGBnSRBVBacQyasHcW0iuKpuyn3KYDFq6hiP4NTfQ=;
        b=cnw8alcfi7s8iBaf2cux1FtDN7UR99jfvQOGZ8nEM83W4ocPfNf5rE3zKRpbVhgx+R
         TQsVlpZB+ASHDPcocmu+SrHO5eUaFo2apk/W4uH5+U45hSytfil9cvPzkH+5Oo8p1oND
         YT7YFQFJr1rL1M31Ja28qv6xQ5byQ+ZIkgVek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682277576; x=1684869576;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hilGBnSRBVBacQyasHcW0iuKpuyn3KYDFq6hiP4NTfQ=;
        b=bShzwCcREenSVkclibjrtI4rjkx5n6elgVjYr05nsEAdshQe9nXDy6LdzoTov8wTiX
         GOurWhniIYVqsufXNnCYZuIjkV2VLF0IXh9JdZoeoTwsXJQ0Zu48kpcFWO/668hR5qeQ
         DA4pjFs11fg2dfb9IyQsOxoPQhhNwYDKpdPYL8Zh1adu3afuu0nQjDASOI3RvFFiAPm5
         q9BTTEwreLy1jC/j2xwcjKQZaoQ7DREW+5qdXYRDXlEe1FVqfBwm1TfkT83XfId3eSHp
         TpkXN7nbiE7h/LN3fMijKVSIh6d9NaZ6xvLLvDoovUGlbaLRj/ePIz5T32g/+bNJtJNC
         EbbQ==
X-Gm-Message-State: AAQBX9esFzPQKZbmXoasou/GRxBYDFUjUuJayWU2TqpOrj0i9lbPVkv9
        npHWoZhC6rqV0sGTUmeQd5zozijO1Ef9lMTB3fG4KA==
X-Google-Smtp-Source: AKy350bS99ocHsBxqnKB5nZQP2tygwUHdv1/UtDvDSzaV9xW5HDXEyrAxNO+JEbCGFKttna1zf1+dg==
X-Received: by 2002:a17:906:7310:b0:94f:17b7:5dbc with SMTP id di16-20020a170906731000b0094f17b75dbcmr9034574ejc.75.1682277576091;
        Sun, 23 Apr 2023 12:19:36 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id e1-20020a17090681c100b0094f67ea6598sm4646245ejx.193.2023.04.23.12.19.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Apr 2023 12:19:35 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-507bdc5ca2aso6373334a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 12:19:35 -0700 (PDT)
X-Received: by 2002:aa7:ca4e:0:b0:506:b2a3:a8cd with SMTP id
 j14-20020aa7ca4e000000b00506b2a3a8cdmr8890020edt.40.1682277575120; Sun, 23
 Apr 2023 12:19:35 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 23 Apr 2023 12:19:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg02PoScxDO0wwD5EkFpx50DF1c2TxXqyAnzGjdFf71jw@mail.gmail.com>
Message-ID: <CAHk-=wg02PoScxDO0wwD5EkFpx50DF1c2TxXqyAnzGjdFf71jw@mail.gmail.com>
Subject: Linux 6.3
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

It's been a calm release this time around, and the last week was
really no different. So here we are, right on schedule, with the 6.3
release out and ready for your enjoyment.

That doesn't mean that something nasty couldn't have been lurking all
these weeks, of course, but let's just take things at face value and
hope it all means that everything is fine, and it really was a nice
controlled release cycle. It happens.

This also obviously means the merge window for 6.4 will open tomorrow.
I already have two dozen pull requests waiting for me to start doing
my pulls, and I appreciate it. I expect I'll have even more when I
wake up tomorrow.

But in the meantime, let's enjoy (and test) the 6.3 release. As
always, the shortlog below is just this last week's worth of fixes,
which is a pretty random collection.  Some misc VM fixes stand out,
but that sounds scarier than it is - they stand out mainly because
everything else is small, and it's unusual to see the mm/ subdirectory
in the diffstat. But it's all pretty small, and a fair chunk of it is
for things like kmsan, not "normal" VM code. Although there's still
some fallout from the conversion to the maple tree and vma iterator.
Let's hope we're all done with that pain.

Anyway - I think we're in good shape, but please do try to prove me
wrong: testing in the real world is where it's at.

              Linus

---

Abhinav Kumar (1):
      arm64: dts: qcom: sc7280: remove hbr3 support on herobrine boards

Alan Liu (1):
      drm/amdgpu: Fix desktop freezed after gpu-reset

Aleksandr Loktionov (2):
      i40e: fix accessing vsi->active_filters without holding lock
      i40e: fix i40e_setup_misc_vector() error handling

Alex Hung (1):
      drm/amd/display: fix a divided-by-zero error

Alexander Aring (1):
      net: rpl: fix rpl header size calculation

Alexander Potapenko (2):
      mm: kmsan: handle alloc failures in kmsan_vmap_pages_range_noflush()
      mm: kmsan: handle alloc failures in kmsan_ioremap_page_range()

Alexander Stein (1):
      arm64: dts: imx8mp: fix address length for LCDIF2

Alexis Lothor=C3=A9 (1):
      fpga: bridge: properly initialize bridge device before populating chi=
ldren

Andrea Righi (2):
      rust: fix regexp in scripts/is_rust_module.sh
      rust: allow to use INIT_STACK_ALL_ZERO

Andy Chi (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for a HP ProBook

Arnd Bergmann (1):
      hamradio: drop ISA_DMA_API dependency

Asahi Lina (1):
      scripts: generate_rust_analyzer: Handle sub-modules with no Makefile

Axel Lin (1):
      regulator: sm5703: Fix missing n_voltages for fixed regulators

Baokun Li (1):
      writeback, cgroup: fix null-ptr-deref write in bdi_split_work_to_wbs

Bhavya Kapoor (1):
      mmc: sdhci_am654: Set HIGH_SPEED_ENA for SDR12 and SDR25

Bjorn Helgaas (1):
      fpga: dfl-pci: Drop redundant pci_enable_pcie_error_reporting()

Boris Burkov (2):
      btrfs: set default discard iops_limit to 1000
      btrfs: reinterpret async discard iops_limit=3D0 as no delay

Brian Masney (1):
      iio: light: tsl2772: fix reading proximity-diodes from device tree

Chancel Liu (1):
      ASoC: fsl_sai: Fix pins setting for i.MX8QM platform

Chen Aotian (1):
      netfilter: nf_tables: Modify nla_memdup's flag to GFP_KERNEL_ACCOUNT

Chris Morgan (1):
      arm64: dts: rockchip: Add clk_rtc_32k to Anbernic xx3 Devices

Christophe JAILLET (1):
      net: dsa: microchip: ksz8795: Correctly handle huge frame configurati=
on

Chuck Lever (1):
      SUNRPC: Fix failures of checksum Kunit tests

Cristian Ciocaltea (2):
      regulator: fan53555: Explicitly include bits header
      regulator: fan53555: Fix wrong TCS_SLEW_MASK

Dan Carpenter (2):
      iio: adc: at91-sama5d2_adc: fix an error code in
at91_adc_allocate_trigger()
      KVM: arm64: Fix buffer overflow in kvm_arm_set_fw_reg()

Dan Johansen (2):
      arm64: dts: rockchip: Lower sd speed on rk3566-soquartz
      arm64: dts: rockchip: Lower SD card speed on rk3399 Pinebook Pro

Daniel Baluta (1):
      ASoC: SOF: pm: Tear down pipelines only if DSP was active

Daniel Borkmann (1):
      bpf: Fix incorrect verifier pruning due to missing register
precision taints

Daniel Miess (1):
      drm/amd/display: limit timing for single dimm memory

David Gow (1):
      rust: kernel: Mark rust_fmt_argument as extern "C"

David Hildenbrand (1):
      mm/userfaultfd: fix uffd-wp handling for THP migration entries

David Howells (3):
      sunrpc: Fix RFC6803 encryption test
      cifs: Fix unbuffered read
      cifs: Reapply lost fix from commit 30b2b2196d6e

Ding Hui (1):
      sfc: Fix use-after-free due to selftest_work

Dmitry Baryshkov (2):
      arm64: dts: qcom: ipq8074-hk01: enable QMP device, not the PHY node
      arm64: dts: qcom: ipq8074-hk10: enable QMP device, not the PHY node

Dmytro Laktyushkin (1):
      drm/amd/display: set dcn315 lb bpp to 48

Duoming Zhou (1):
      cxgb4: fix use after free bugs caused by circular dependency problem

Ekaterina Orlova (1):
      ASN.1: Fix check for strdup() success

Enze Li (1):
      LoongArch: Replace hard-coded values in comments with VALEN

Fabio Estevam (3):
      ARM: dts: imx7d-remarkable2: Remove unnecessary #address-cells/#size-=
cells
      ARM: dts: imx6ull-colibri: Remove unnecessary #address-cells/#size-ce=
lls
      ARM: imx_v6_v7_defconfig: Fix unintentional disablement of PCI

Florian Westphal (2):
      netfilter: br_netfilter: fix recent physdev match breakage
      netfilter: nf_tables: fix ifdef to also consider nf_tables=3Dm

Greg Kroah-Hartman (1):
      memstick: fix memory leak if card device is never registered

Gwangun Jung (1):
      net: sched: sch_qfq: prevent slab-out-of-bounds in qfq_activate_agg

Huacai Chen (6):
      LoongArch: Make WriteCombine configurable for ioremap()
      LoongArch: Fix probing of the CRC32 feature
      LoongArch: Fix build error if CONFIG_SUSPEND is not set
      LoongArch: Enable PG when wakeup from suspend
      LoongArch: Mark 3 symbol exports as non-GPL
      LoongArch: module: set section addresses to 0x0

Ido Schimmel (2):
      bonding: Fix memory leak when changing bond type to Ethernet
      mlxsw: pci: Fix possible crash during initialization

Ilpo J=C3=A4rvinen (1):
      fpga: m10bmc-sec: Fix rsu_send_data() to return FW_UPLOAD_ERR_HW_ERRO=
R

Ilya Leoshkevich (1):
      s390/bpf: Fix bpf_arch_text_poke() with new_addr =3D=3D NULL

Jacob Keller (1):
      ice: document RDMA devlink parameters

Jakub Kicinski (1):
      Revert "net/mlx5: Enable management PF initialization"

Jaroslav Kysela (1):
      ALSA: hda/realtek: Remove specific patch for Dell Precision 3260

Javier Martinez Canillas (1):
      arm64: dts: rockchip: Remove non-existing pwm-delay-us property

Jianqun Xu (1):
      ARM: dts: rockchip: fix a typo error for rk3288 spdif node

Jiaxun Yang (1):
      MIPS: Define RUNTIME_DISCARD_EXIT in LD script

Johan Hovold (2):
      arm64: dts: qcom: sc8280xp-pmics: fix pon compatible and registers
      firmware/psci: demote suspend-mode warning to info level

John Ogness (1):
      drm/nouveau: fix incorrect conversion to dma_resv_wait_timeout()

Jonathan Toppins (1):
      mailmap: update jtoppins' entry to reference correct email

Jules Maselbas (1):
      tee: optee: Fix typo Unuspported -> Unsupported

Kalesh AP (1):
      bnxt_en: Fix a possible NULL pointer dereference in unload path

Krzysztof Kozlowski (8):
      arm64: dts: qcom: sdm850-lenovo-yoga-c630: Use proper WSA881x
shutdown GPIO polarity
      arm64: dts: qcom: sdm850-samsung-w737: Use proper WSA881x
shutdown GPIO polarity
      arm64: dts: qcom: sm8250-mtp: Use proper WSA881x shutdown GPIO polari=
ty
      arm64: dts: qcom: qrb5165-rb5: Use proper WSA881x shutdown GPIO polar=
ity
      riscv: dts: canaan: drop invalid spi-max-frequency
      arm64: dts: rockchip: use just "port" in panel on Pinebook Pro
      arm64: dts: rockchip: use just "port" in panel on RockPro64
      arm64: dts: rockchip: correct panel supplies on some rk3326 boards

Li Lanzhe (1):
      spi: spi-rockchip: Fix missing unwind goto in rockchip_sfc_probe()

Liam R. Howlett (5):
      mm/mprotect: fix do_mprotect_pkey() return on error
      mm/mempolicy: fix use-after-free of VMA iterator
      maple_tree: make maple state reusable after mas_empty_area_rev()
      maple_tree: fix mas_empty_area() search
      mm/mmap: regression fix for unmapped_area{_topdown}

Liang He (1):
      iio: dac: ad5755: Add missing fwnode_handle_put()

Linus Torvalds (3):
      Revert "ACPICA: Events: Support fixed PCIe wake event"
      gcc: disable '-Warray-bounds' for gcc-13 too
      Linux 6.3

Linus Walleij (1):
      tee: Pass a pointer to virt_to_page()

Long Wang (1):
      ASoC: max98373: change power down sequence for smart amp

Lorenzo Bianconi (1):
      veth: take into account peer device for NETDEV_XDP_ACT_NDO_XMIT
xdp_features flag

Marc Gonzalez (3):
      arm64: dts: meson-g12-common: specify full DMC range
      arm64: dts: meson-g12-common: resolve conflict between canvas & pmu
      perf/amlogic: adjust register offsets

Marc Zyngier (1):
      KVM: arm64: Make vcpu flag updates non-preemptible

Masahiro Yamada (1):
      kbuild: use proper prefix for tarballs to fix rpm-pkg build error

Mat Martineau (1):
      MAINTAINERS: Resume MPTCP co-maintainer role

Mathieu Desnoyers (1):
      mm: fix memory leak on mm_init error handling

Matthieu Baerts (1):
      mailmap: add entries for Mat Martineau

Mel Gorman (1):
      mm: page_alloc: skip regions with hugetlbfs pages when allocating 1G =
pages

Michael Chan (1):
      bnxt_en: Do not initialize PTP on older P3/P4 chips

Michal Simek (1):
      fpga: xilinx-pr-decoupler: Use readl wrapper instead of pure readl

Ming Lei (1):
      Revert "block: Merge bio before checking ->cached_rq"

Naoya Horiguchi (1):
      mm/huge_memory.c: warn with pr_warn_ratelimited instead of
VM_WARN_ON_ONCE_FOLIO

Nikita Zhandarovich (2):
      mlxfw: fix null-ptr-deref in mlxfw_mfa2_tlv_next()
      ASoC: fsl_asrc_dma: fix potential null-ptr-deref

Ondrej Mosnacek (1):
      kernel/sys.c: fix and improve control flow in __sys_setres[ug]id()

Pablo Neira Ayuso (2):
      netfilter: nf_tables: validate catch-all set elements
      netfilter: nf_tables: tighten netlink attribute requirements for
catch-all elements

Paolo Abeni (2):
      mptcp: stops worker on unaccepted sockets at listener close
      mptcp: fix accept vs worker race

Patrick Blass (1):
      rust: str: fix requierments->requirements typo

Paulo Alcantara (1):
      cifs: avoid dup prefix path in dfs_get_automount_devname()

Pedro Tammela (1):
      net/sched: clear actions pointer in miss cookie init fail

Peng Fan (3):
      arm64: dts: imx8mm-evk: correct pmic clock source
      arm64: dts: imx8mm-verdin: correct off-on-delay
      arm64: dts: imx8mp-verdin: correct off-on-delay

Peng Zhang (1):
      maple_tree: fix a potential memory leak, OOB access, or other
unpredictable bug

Peter Ujfalusi (1):
      ASoC: SOF: ipc4-topology: Clarify bind failure caused by missing fw_m=
odule

Peter Xu (2):
      mm/khugepaged: check again on anon uffd-wp during isolation
      Revert "userfaultfd: don't fail on unrecognized features"

Qi Zheng (1):
      mm: swap: fix performance regression on sparsetruncate-tiny

Qing Zhang (3):
      LoongArch: Fix _CONST64_(x) as unsigned
      LoongArch: Adjust user_watch_state for explicit alignment
      LoongArch: Adjust user_regset_copyin parameter to the correct offset

Rob Herring (2):
      arm64: dts: rockchip: Fix rk3399 GICv3 ITS node name
      PCI: Restrict device disabled status check to DT

Ryusuke Konishi (1):
      nilfs2: initialize unused bytes in segment summary blocks

Sascha Hauer (2):
      drm/rockchip: vop2: fix suspend/resume
      drm/rockchip: vop2: Use regcache_sync() to fix suspend/resume

Sebastian Basierski (1):
      e1000e: Disable TSO on i219-LM card to increase speed

Sebastian Reichel (1):
      arm64: dts: rockchip: add rk3588 cache level information

Seiji Nishikawa (1):
      net: vmxnet3: Fix NULL pointer dereference in vmxnet3_rq_rx_complete(=
)

SeongJae Park (1):
      tools/Makefile: do missed s/vm/mm/

Soumya Negi (1):
      Input: pegasus-notetaker - check pipe type when probing

Steve Chou (1):
      tools/mm/page_owner_sort.c: fix TGID output when cull=3Dtg is used

Tetsuo Handa (1):
      mm/page_alloc: fix potential deadlock on zonelist_update_seq seqlock

Thomas Bamelis (1):
      rust: sort uml documentation arch support table

Thomas Gleixner (1):
      PCI/MSI: Remove over-zealous hardware size check in
pci_msix_validate_entries()

Tiezhu Yang (3):
      LoongArch: Check unwind_error() in arch_stack_walk()
      LoongArch: Clean up plat_swiotlb_setup() related code
      tools/loongarch: Use __SIZEOF_LONG__ to define __BITS_PER_LONG

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      wifi: ath9k: Don't mark channelmap stack variable read-only in
ath9k_mci_update_wlan_channels()

Vadim Fedorenko (1):
      bnxt_en: fix free-runnig PHC mode

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Fix fast wake AUX sync len

Vincenzo Palazzo (1):
      rust: build: Fix grep warning

Vitaly Prosyak (1):
      drm/sched: Check scheduler ready before calling timeout handling

Vladimir Oltean (1):
      net: bridge: switchdev: don't notify FDB entries with "master dynamic=
"

William Breathitt Gray (2):
      gpio: 104-dio-48e: Enable use_raw_spinlock for dio48e_regmap_config
      gpio: 104-idi-48: Enable use_raw_spinlock for idi48_regmap_config

Willy Tarreau (1):
      x86/alternatives: Do not use integer constant suffixes in inline asm

Woody Suwalski (1):
      kbuild: deb-pkg: Fix a spell typo in mkdebian script

Xuan Zhuo (1):
      virtio_net: bugfix overflow inside xdp_linearize_page()

hrdl (1):
      Input: cyttsp5 - fix sensing configuration data structure
