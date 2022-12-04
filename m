Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E03642024
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 23:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiLDWzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 17:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiLDWzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 17:55:00 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAB0FAC4
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 14:54:58 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id mn15so7150808qvb.13
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 14:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cd9BORNFPhgXPNHPYxOQMhh20WLO0fB7Zvi+t88mgxw=;
        b=KkrRyhfwR+hpVB219d33Y+B9wzaLW1RCbgr+EccWoR5TUtZFqMJKqSe6IanMDxVJPf
         Jtcy57H10zKdTUhr344UMs3o6tveRdHju6cfApF7ezVrFHG5bDVE0jbflofVqsIqNQWY
         tDSTewUxYcCFytdSPZVZYoV55una7Y/cjtRDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cd9BORNFPhgXPNHPYxOQMhh20WLO0fB7Zvi+t88mgxw=;
        b=4EN8+J45FA1RPMzh7pxiGqDUn1uxNGyED+YGixT8h5I3DAq4ihDLfnWGag12u5urwG
         ZujBKJEK11dXfQtr+sM6cxuuUpKjfvQXBJUZ2U2XMES3qT/jmRdDlfw2I3r2RWrjNrqN
         kTag0W5THyVrISjajfir277KmT5/4oO68wco+IkhdbXf0cLoFAh2wGyPzZ9GswG1IJHY
         wJCKXsNdP8H9vP/1SvAWTDf+23JmBAu+Rw9TAissO53882cmOzYrJNQN+tqt/RjIvoe3
         Svse4idzDGKFyCFXFKRmzY9NZK4yzqxpTnivE/DX1hfX4qfOGmhWUDSC9xTvF0uinQvF
         0fQA==
X-Gm-Message-State: ANoB5pneoy2h+oP1a289k4tAFioMWpGGvbVaVW0/1Tn+EIa4lP+IXSfw
        iPBfnBWPZHRpwi6AQoRd8l8v8ITXfMwTmwSY
X-Google-Smtp-Source: AA0mqf7j4c4VXkX9ycPIL5BJzKP5gpkmUefHkIQLpLwJ6edR/hz7Un6h/JTQomtkNM88/i2zsji/5Q==
X-Received: by 2002:ad4:52ca:0:b0:4bb:cb21:df19 with SMTP id p10-20020ad452ca000000b004bbcb21df19mr61082648qvs.85.1670194497032;
        Sun, 04 Dec 2022 14:54:57 -0800 (PST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com. [209.85.219.42])
        by smtp.gmail.com with ESMTPSA id cf16-20020a05622a401000b003996aa171b9sm8421325qtb.97.2022.12.04.14.54.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Dec 2022 14:54:56 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id c14so7200575qvq.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 14:54:56 -0800 (PST)
X-Received: by 2002:ad4:4101:0:b0:4b1:856b:4277 with SMTP id
 i1-20020ad44101000000b004b1856b4277mr56532610qvp.129.1670194495823; Sun, 04
 Dec 2022 14:54:55 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Dec 2022 14:54:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgyXu4D44b8wQU9dpTYUft6WhZ0wr3nV1fziy6k0GwCCw@mail.gmail.com>
Message-ID: <CAHk-=wgyXu4D44b8wQU9dpTYUft6WhZ0wr3nV1fziy6k0GwCCw@mail.gmail.com>
Subject: Linux 6.1-rc8
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So we've finally started calming down, and rc8 is noticeably smaller
than previous release candidates.

So everything looks good, and while the calming down may have happened
later than I wished for, it did happen. Let's hope this upcoming week
is as quiet (or quieter).

The changes here are few enough that scanning through the shortlog
below should give you an idea of what's been going on, but it's
basically small changes spread all over. Nothing particularly stands
out to me.

I'm also happy to see that I already have a few pull requests
scheduled for when the 6.2 merge window opens up, so some people are
being proactive and want to have everything already lined up for a
calm holiday season. Hint, hint.

                Linus

---

Adrian Hunter (1):
      mmc: sdhci: Fix voltage switch delay

Alexandre Ghiti (1):
      riscv: Sync efi page table's kernel mappings before switching

Andrew Lunn (1):
      i2c: imx: Only DMA messages with I2C_M_DMA_SAFE flag set

Andrew Morton (1):
      revert "kbuild: fix -Wimplicit-function-declaration in
license_is_gpl_compatible"

Andrzej Hajda (1):
      drm/i915: fix TLB invalidation for Gen12 video and compute engines

Andy Shevchenko (1):
      pinctrl: intel: Save and restore pins in "direct IRQ" mode

Ard Biesheuvel (1):
      arm64: efi: Revert "Recover from synchronous exceptions ..."

Ayush Sawal (1):
      MAINTAINERS: Update maintainer list for chelsio drivers

Bj=C3=B6rn T=C3=B6pel (1):
      riscv: mm: Proper page permissions after initmem free

Caleb Sander (1):
      nvme: fix SRCU protection of nvme_ns_head list

Carsten Haitzler (1):
      i2c: cadence: Fix regression with bus recovery

Charles Keepax (2):
      ASoC: ops: Correct bounds check for second channel on SX controls
      ASoC: cs42l51: Correct PGA Volume minimum value

Chris Mi (3):
      net/mlx5: E-switch, Destroy legacy fdb table when needed
      net/mlx5: E-switch, Fix duplicate lag creation
      net/mlx5: Lag, Fix for loop when checking lag

Christian L=C3=B6hle (1):
      mmc: core: Fix ambiguous TRIM and DISCARD arg

Christophe Leroy (1):
      powerpc/bpf/32: Fix Oops on tail call tests

Colin Ian King (1):
      tracing/hist: add in missing * in comment blocks

Conor Dooley (1):
      Revert "clocksource/drivers/riscv: Events are stopped during CPU susp=
end"

Dan Carpenter (1):
      net/mlx5e: Fix a couple error codes

Dan Williams (1):
      device-dax: Fix duplicate 'hmem' device registration

Daniel Bristot de Oliveira (1):
      tracing/osnoise: Fix duration type

David Howells (1):
      afs: Fix fileserver probe RTT handling

David Virag (1):
      clk: samsung: exynos7885: Correct "div4" clock parents

Derek Nguyen (1):
      hwmon: (ltc2947) fix temperature scaling

Duoming Zhou (1):
      qlcnic: fix sleep-in-atomic-context bugs caused by msleep

Emeel Hakim (3):
      net/mlx5e: MACsec, fix add Rx security association (SA) rule memory l=
eak
      net/mlx5e: MACsec, remove replay window size limitation in offload pa=
th
      net/mlx5e: MACsec, block offload requests with encrypt off

Gaosheng Cui (2):
      hwmon: (ibmpex) Fix possible UAF when ibmpex_register_bmc() fails
      mmc: mtk-sd: Fix missing clk_disable_unprepare in msdc_of_clock_parse=
()

Gavin Shan (1):
      mm: migrate: fix THP's mapcount on isolation

Goh, Wei Sheng (1):
      net: stmmac: Set MAC's flow control register to reflect current setti=
ngs

Guo Ren (2):
      riscv: kexec: Fixup irq controller broken in kexec crash path
      riscv: kexec: Fixup crash_smp_send_stop without multi cores

Heiko Schocher (1):
      can: sja1000: fix size of OCR_MODE_MASK define

Hou Tao (5):
      bpf, perf: Use subprog name when reporting subprog ksymbol
      libbpf: Use page size as max_entries when probing ring buffer map
      libbpf: Handle size overflow for ringbuf mmap
      libbpf: Handle size overflow for user ringbuf mmap
      libbpf: Check the validity of size in user_ring_buffer__reserve()

Hui Tang (1):
      ASoC: tlv320adc3xxx: Fix build error for implicit function declaratio=
n

Ido Schimmel (1):
      ipv4: Fix route deletion when nexthop info is not specified

Inbaraj E (1):
      dt-bindings: clock: exynosautov9: fix reference to CMU_FSYS1

Izabela Bakollari (1):
      aquantia: Do not purge addresses when setting the number of rings

Jacob Pan (1):
      iommu/vt-d: Add a fix for devices need extra dtlb flush

Jan Dabros (1):
      char: tpm: Protect tpm_pm_suspend with locks

Jann Horn (3):
      mm/khugepaged: take the right locks for page table retraction
      mm/khugepaged: fix GUP-fast interaction by sending IPI
      mm/khugepaged: invoke MMU notifiers in shmem/file collapse paths

Janusz Krzysztofik (2):
      drm/i915: Fix negative value passed as remaining time
      drm/i915: Never return 0 if not all requests retired

Jerry Ray (1):
      dsa: lan9303: Correct stat name

Jiasheng Jiang (1):
      can: m_can: Add check for devm_clk_get

Jiri Olsa (3):
      libbpf: Use correct return pointer in attach_raw_tp
      selftests/bpf: Filter out default_idle from kprobe_multi bench
      selftests/bpf: Make test_bench_attach serial

Jisheng Zhang (2):
      riscv: fix race when vmap stack overflow
      riscv: vdso: fix section overlapping under some conditions

Johannes Berg (2):
      wifi: cfg80211: fix buffer overflow in elem comparison
      wifi: cfg80211: don't allow multi-BSSID in S1G

Juergen Gross (2):
      mm: add dummy pmd_young() for architectures not having it
      mm: introduce arch_has_hw_nonleaf_pmd_young()

Lee Jones (2):
      drm/amdgpu: temporarily disable broken Clang builds due to blown
stack-frame
      Kconfig.debug: provide a little extra FRAME_WARN leeway when
KASAN is enabled

Lei Rao (1):
      nvme-pci: clear the prp2 field when not used

Leo Liu (1):
      drm/amdgpu: enable Vangogh VCN indirect sram mode

Linus Torvalds (3):
      v4l2: don't fall back to follow_pfn() if pin_user_pages_fast() fails
      Revert "mm: align larger anonymous mappings on THP boundaries"
      Linux 6.1-rc8

Lorenzo Bianconi (1):
      wifi: mac8021: fix possible oob access in ieee80211_get_rate_duration

Lukas Bulwahn (1):
      qed: avoid defines prefixed with CONFIG

M Chetan Kumar (4):
      net: wwan: iosm: fix kernel test robot reported error
      net: wwan: iosm: fix dma_alloc_coherent incompatible pointer type
      net: wwan: iosm: fix crash in peek throughput test
      net: wwan: iosm: fix incorrect skb length

Marc Dionne (1):
      afs: Fix server->active leak in afs_put_server

Marek Szyprowski (1):
      clk: samsung: Revert "clk: samsung: exynos-clkout: Use
of_device_get_match_data()"

Marek Vasut (1):
      MAINTAINERS: mark rsi wifi driver as orphan

Mark Brown (2):
      ASoC: ops: Fix bounds check for _sx controls
      ASoC: ops: Check bounds for second channel in snd_soc_put_volsw_sx()

Maxim Korotkov (1):
      pinctrl: single: Fix potential division by zero

Menglong Dong (1):
      mptcp: don't orphan ssk in mptcp_close()

Michael Ellerman (1):
      powerpc/64s: Add missing declaration for machine_check_early_boot()

Michael Grzeschik (1):
      ARM: at91: rm9200: fix usb device clock id

Mike Kravetz (2):
      madvise: use zap_page_range_single for madvise dontneed
      hugetlb: don't delete vma_lock in hugetlb MADV_DONTNEED processing

Miklos Szeredi (1):
      fuse: lock inode unconditionally in fuse_fallocate()

Ninad Malwade (1):
      hwmon: (ina3221) Fix shunt sum critical calculation

Paolo Abeni (1):
      mptcp: fix sleep in atomic at close time

Pawan Gupta (1):
      x86/bugs: Make sure MSR_SPEC_CTRL is updated properly upon resume fro=
m S3

Peter Zijlstra (1):
      perf: Fix perf_pending_task() UaF

Phil Auld (1):
      hwmon: (coretemp) Check for null before removing sysfs attrs

Phil Turnbull (4):
      wifi: wilc1000: validate pairwise and authentication suite offsets
      wifi: wilc1000: validate length of
IEEE80211_P2P_ATTR_OPER_CHANNEL attribute
      wifi: wilc1000: validate length of
IEEE80211_P2P_ATTR_CHANNEL_LIST attribute
      wifi: wilc1000: validate number of channels

Radhakrishna Sripada (1):
      drm/i915/mtl: Fix dram info readout

Raed Salem (5):
      net/mlx5e: MACsec, fix RX data path 16 RX security channel limit
      net/mlx5e: MACsec, fix memory leak when MACsec device is deleted
      net/mlx5e: MACsec, fix update Rx secure channel active field
      net/mlx5e: MACsec, fix mlx5e_macsec_update_rxsa bail condition
and functionality
      net/mlx5e: MACsec, fix Tx SA active field update

Rasmus Villemoes (2):
      net: fec: don't reset irq coalesce settings to defaults on "ip link u=
p"
      net: loopback: use NET_NAME_PREDICTABLE for name_assign_type

Ricardo Ribalda (2):
      i2c: Restore initial power state if probe fails
      pinctrl: meditatek: Startup with the IRQs disabled

Roi Dayan (1):
      net/mlx5e: Fix use-after-free when reverting termination table

Russell King (Oracle) (1):
      net: phylink: fix PHY validation with rate adaption

Saeed Mahameed (1):
      Revert "net/mlx5e: MACsec, remove replay window size limitation
in offload path"

Samuel Holland (1):
      riscv: Fix NR_CPUS range conditions

Sebastian Falbesoner (1):
      mmc: sdhci-esdhc-imx: correct CQHCI exit halt state check

SeongJae Park (1):
      mm/damon/sysfs: fix wrong empty schemes assumption under online
tuning in damon_sysfs_set_schemes()

Shang XiaoJing (3):
      ixgbevf: Fix resource leak in ixgbevf_init_module()
      i40e: Fix error handling in i40e_init_module()
      net: marvell: prestera: Fix a NULL vs IS_ERR() check in some function=
s

Shannon Nelson (1):
      ionic: update MAINTAINERS entry

Shazad Hussain (1):
      clk: qcom: gcc-sc8280xp: add cxo as parent for three ufs ref clks

Shengjiu Wang (2):
      ASoC: fsl_micfil: explicitly clear software reset bit
      ASoC: fsl_micfil: explicitly clear CHnF flags

Shigeru Yoshida (1):
      net: tun: Fix use-after-free in tun_detach()

Stephen Boyd (1):
      clk: qcom: gdsc: Remove direct runtime PM calls

Steven Rostedt (Google) (4):
      tracing: Fix race where histograms can be called before the event
      tracing: Add tracing_reset_all_online_cpus_unlocked() function
      tracing: Free buffers when a used dynamic event is removed
      error-injection: Add prompt for function error injection

Suman Ghosh (1):
      octeontx2-pf: Fix pfc_alloc_status array overflow

Takashi Sakamoto (1):
      ALSA: dice: fix regression for Lexicon I-ONIX FW810S

Tiezhu Yang (1):
      tools/vm/slabinfo-gnuplot: use "grep -E" instead of "egrep"

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Remove non-existent pipes from bigjoiner pipe mask

Vishal Verma (2):
      ACPI: HMAT: remove unnecessary variable initialization
      ACPI: HMAT: Fix initiator registration for single-initiator systems

Wang Hai (2):
      e100: Fix possible use after free in e100_xmit_prepare
      net/9p: Fix a potential socket leak in p9_socket_open

Wang Yufen (1):
      i2c: qcom-geni: fix error return code in geni_i2c_gpi_xfer

Wenchao Chen (1):
      mmc: sdhci-sprd: Fix no reset data and command after voltage switch

Willem de Bruijn (1):
      packet: do not set TP_STATUS_CSUM_VALID on CHECKSUM_COMPLETE

Xin Long (1):
      tipc: re-fetch skb cb after tipc_msg_validate

Xiongfeng Wang (2):
      iommu/vt-d: Fix PCI device refcount leak in has_external_pci()
      iommu/vt-d: Fix PCI device refcount leak in dmar_dev_scope_init()

Xiu Jianfeng (1):
      tracing/user_events: Fix memory leak in user_event_create()

Xu Kuohai (2):
      bpf: Do not copy spin lock field from user in bpf_selem_alloc
      bpf: Set and check spin lock value in sk_storage_map_test

Yang Shi (1):
      mm: replace VM_WARN_ON to pr_warn if the node is offline with
__GFP_THISNODE

Yang Yingliang (6):
      hwmon: (i5500_temp) fix missing pci_disable_device()
      of: property: decrement node refcount in of_fwnode_get_reference_args=
()
      net: phy: fix null-ptr-deref while probe() failed
      net: mdiobus: fix unbalanced node reference count
      hwmon: (coretemp) fix pci device refcount leak in nv1a_ram_new()
      iommu/vt-d: Fix PCI device refcount leak in prq_event_thread()

Yasushi SHOJI (1):
      can: mcba_usb: Fix termination command argument

Ye Bin (1):
      mmc: mmc_test: Fix removal of debugfs file

Yoshihiro Shimoda (1):
      net: ethernet: renesas: ravb: Fix promiscuous mode after system resum=
ed

Yuan Can (5):
      i2c: npcm7xx: Fix error handling in npcm_i2c_init()
      fm10k: Fix error handling in fm10k_init_module()
      iavf: Fix error handling in iavf_init_module()
      net: net_netdev: Fix error handling in ntb_netdev_init_module()
      hwmon: (asus-ec-sensors) Add checks for devm_kcalloc

YueHaibing (4):
      net/mlx5: DR, Fix uninitialized var warning
      net/mlx5: Fix uninitialized variable bug in outlen_write()
      net/mlx5e: Use kvfree() in mlx5e_accel_fs_tcp_create()
      net: hsr: Fix potential use-after-free

Yuri Karpov (1):
      net: ethernet: nixge: fix NULL dereference

Zhang Changzhong (5):
      can: sja1000_isa: sja1000_isa_probe(): add missing free_sja1000dev()
      can: cc770: cc770_isa_probe(): add missing free_cc770dev()
      can: etas_es58x: es58x_init_netdev(): free netdev when register_cande=
v()
      can: m_can: pci: add missing m_can_class_free_dev() in
probe/remove methods
      net: ethernet: ti: am65-cpsw: fix error handling in am65_cpsw_nuss_pr=
obe()

Zhang Xiaoxu (1):
      Input: raydium_ts_i2c - fix memory leak in raydium_i2c_send()

ZhangPeng (1):
      nilfs2: fix NULL pointer dereference in nilfs_palloc_commit_free_entr=
y()

Zhengchao Shao (1):
      sctp: fix memory leak in sctp_stream_outq_migrate()

Ziyang Xuan (1):
      can: can327: can327_feed_frame_to_netdev(): fix potential skb
leak when netdev is down
