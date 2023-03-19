Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9816C04F5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 21:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjCSUus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 16:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjCSUup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 16:50:45 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47152D72
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 13:50:41 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id eg48so39385373edb.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 13:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679259040;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OtXLkQM3tytynuI/dxyIIR1FD0g73T92Xkmzh/c6mE4=;
        b=QmAytx0Q1GZcBipQueufJj9Mj/P2FG9DHyDPB1bzcfczVtExDB/todD9dxPnbG/4NI
         Fy2ekeCphdRAcw75IzAbsd5sBAoYetOpcI40QHhcSBL5cjwj7g+27SuCtT/wvfjDLpjp
         DOt+iDLNv1ALhRLkyPb5bHvUG9S94XZVdVxlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679259040;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OtXLkQM3tytynuI/dxyIIR1FD0g73T92Xkmzh/c6mE4=;
        b=tgktrbf09y4+gohAAjokb11g7Ep7vML5sZNUyeoOExP0madtro5zXeZSKd9TjATLPu
         3n1J77pwnc+XhzJwvrAlu8PGHyMq/bzVgrYrQS9MP+9HFhjSoX2lKeZZEAsolCWQAuNC
         YsOCEf1Pxb0MhBTlykwoH/Oc0UnPUEvuCB082+moFhxuhZvUOsuMBr56iSrkmkIp0Zrv
         92Rpk4I8ZOZluAQK3ub5UAlYPBaBQG9ymCI8yHIEUnUeIjPl3P2WeNIKwWkPGNJvCJUu
         s40nQ01/NAmy43d936Eactb0tkj8dKJ2hMa58cWUBX/NrKmv4vyCFRa7qVDsevjraUDG
         L5cw==
X-Gm-Message-State: AO0yUKVyseVqV28W3zqBfZk+qhfNoz2UvsXEmsVqMEgNrnsJwg68yNOu
        UwNVvW9PuTPBRsUcc7NE+XhTM5BgLPAYfJ/4JE8=
X-Google-Smtp-Source: AK7set8euXbIGpr8NCPxjjheTc0uF6rc0Hr2cehjYZ0A1cc7n4FE2pYAF6cMM6SUbND43ioP1c15rA==
X-Received: by 2002:a17:906:d154:b0:8b0:ad0b:7ab8 with SMTP id br20-20020a170906d15400b008b0ad0b7ab8mr6852987ejb.14.1679259039508;
        Sun, 19 Mar 2023 13:50:39 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id g5-20020a170906394500b0092fb818127dsm3618395eje.94.2023.03.19.13.50.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 13:50:38 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id er8so27785132edb.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 13:50:38 -0700 (PDT)
X-Received: by 2002:a50:8705:0:b0:4fa:da46:6f1c with SMTP id
 i5-20020a508705000000b004fada466f1cmr4935441edb.2.1679259037997; Sun, 19 Mar
 2023 13:50:37 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Mar 2023 13:50:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPd8R8-zSqTOtJ9KYeZLBByHug7ny3rgP-ZqzpP_KELg@mail.gmail.com>
Message-ID: <CAHk-=wiPd8R8-zSqTOtJ9KYeZLBByHug7ny3rgP-ZqzpP_KELg@mail.gmail.com>
Subject: Linux 6.3-rc3
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

So rc3 is fairly big, but that's not hugely usual: it's when a lot of
the fixes tick up as it takes a while before people find and start
reporting issues.

And nothing here looks hugely worrisome. The diffstat looks a bit
unusual in that there are relatively big changes to the scripts and
selftest directories, but that's mainly due to the git-ignore script
removal and some kvm selftest cleanups respectively. Nothing scary.

If you ignore those parts, it's a fairly standard "two thirds drivers,
one third rest" thing. The drivers are all over, but networking, gpu
and sound are the usual big ones, with the fbdev code showing up
mainly just because of a coding style fixup to the logo conversion
scripting (mainly to use proper tab indentation). The qcom
interconnect driver also shows up for major cleanup and fixes.

Outside of those areas, it's a random collection of fixes: the usual
arch updates (much - but not all - of it being kvm), some filesystem
fixes (mainly cifs), core networking, tracing, and some core mm fixes.

Anyway, it's early days still, but nothing here looks particularly odd.

Please test and report any issues you find,

                   Linus

---

Adham Faris (1):
      net/mlx5e: Lower maximum allowed MTU in XSK to match XDP prerequisite=
s

Alex Deucher (1):
      drm/amdgpu/nv: fix codec array for SR_IOV

Alex Elder (5):
      net: ipa: fix a surprising number of bad offsets
      net: ipa: reg: include <linux/bug.h>
      net: ipa: add two missing declarations
      net: ipa: kill FILT_ROUT_CACHE_CFG IPA register
      net: ipa: fix some register validity checks

Alexander Sverdlin (1):
      tty: serial: fsl_lpuart: fix race on RX DMA shutdown

Alexandra Winter (1):
      net/iucv: Fix size of interrupt data

Alexandre Ghiti (1):
      .mailmap: add Alexandre Ghiti personal email address

Amadeusz S=C5=82awi=C5=84ski (3):
      ASoC: Intel: avs: max98357a: Explicitly define codec format
      ASoC: Intel: avs: da7219: Explicitly define codec format
      ASoC: Intel: avs: rt5682: Explicitly define codec format

Andrea Righi (1):
      drm/i915/sseu: fix max_subslices array-index-out-of-bounds access

Andy Shevchenko (1):
      ACPI: docs: enumeration: Correct reference to the I=C2=B2C device dat=
a type

Ankit Nautiyal (1):
      drm/i915/dg2: Add HDMI pixel clock frequencies 267.30 and 319.89 MHz

Anton Gusev (1):
      tracing: Fix wrong return in kprobe_event_gen_test.c

Antti Laakso (1):
      tools/power turbostat: fix decoding of HWP_STATUS

Arnd Bergmann (3):
      kallsyms: add kallsyms_seqs_of_names to list of special symbols
      ftrace,kcfi: Define ftrace_stub_graph conditionally
      fbdev: omapfb: remove omap1 osk driver

Arseniy Krasnov (4):
      virtio/vsock: don't use skbuff state to account credit
      virtio/vsock: remove redundant 'skb_pull()' call
      virtio/vsock: don't drop skbuff on copy failure
      test/vsock: copy to user failure test

Ar=C4=B1n=C3=A7 =C3=9CNAL (2):
      net: dsa: mt7530: remove now incorrect comment regarding port 5
      net: dsa: mt7530: set PLL frequency and trgmii only when trgmii is us=
ed

Ashutosh Dixit (1):
      drm/i915/hwmon: Enable PL1 power limit

Asutosh Das (1):
      scsi: ufs: mcq: Use active_reqs to check busy in clock scaling

Ayush Gupta (1):
      drm/amd/display: disconnect MPCC only on OTG change

Bard Liao (1):
      ALSA: hda: intel-dsp-config: add MTL PCI id

Bart Van Assche (2):
      scsi: core: Fix a procfs host directory removal regression
      loop: Fix use-after-free issues

Benjamin Cheng (1):
      drm/amd/display: Write to correct dirty_rect

Bhawanpreet Lakha (1):
      drm/amd/display: Fix HDCP failing to enable after suspend

Biju Das (1):
      serial: 8250_em: Fix UART port type

Bjorn Helgaas (1):
      ALSA: hda: Match only Intel devices with CONTROLLER_IN_GPU()

Borislav Petkov (AMD) (6):
      virt/coco/sev-guest: Check SEV_SNP attribute at probe time
      virt/coco/sev-guest: Simplify extended guest request handling
      virt/coco/sev-guest: Remove the disable_vmpck label in
handle_guest_request()
      virt/coco/sev-guest: Carve out the request issuing logic into a helpe=
r
      virt/coco/sev-guest: Do some code style cleanups
      virt/coco/sev-guest: Convert the sw_exit_info_2 checking to a switch-=
case

Breno Leitao (1):
      tcp: tcp_make_synack() can be called from process context

Budimir Markovic (1):
      perf: Fix check before add_event_to_groups() in perf_group_detach()

B=C5=82a=C5=BCej Szczygie=C5=82 (1):
      drm/amd/pm: Fix sienna cichlid incorrect OD volage after resume

Cezary Rojewski (2):
      ASoC: Intel: avs: ssm4567: Remove nau8825 bits
      ASoC: Intel: avs: nau8825: Adjust clock control

Chen Yu (1):
      ACPI: tools: pfrut: Check if the input of level and type is in
the right numeric range

Chen Zhongjin (1):
      ftrace: Fix invalid address access in lookup_rec() when index is 0

Chia-I Wu (2):
      drm/amdkfd: fix a potential double free in pqm_create_queue
      drm/amdkfd: fix potential kgd_mem UAFs

Chia-Lin Kao (AceLan) (1):
      ACPI: video: Add backlight=3Dnative DMI quirk for Dell Vostro 15 3535

Chris Leech (1):
      blk-mq: fix "bad unlock balance detected" on q->srcu in
__blk_mq_run_dispatch_ops

Christian Hewitt (1):
      drm/meson: fix 1px pink line on GXM when scaling video overlay

Christian K=C3=B6nig (1):
      drm/ttm: drop extra ttm_bo_put in ttm_bo_cleanup_refs

Cindy Lu (1):
      vp_vdpa: fix the crash in hot unplug with vp_vdpa

Conor Dooley (2):
      MAINTAINERS: add missing clock driver coverage for Microchip FPGAs
      clk: k210: remove an implicit 64-bit division

Costa Shulyupin (1):
      tracing/hwlat: Replace sched_setaffinity with set_cpus_allowed_ptr

Cruise Hung (1):
      drm/amd/display: Fix DP MST sinks removal issue

D. Wythe (1):
      net/smc: fix NULL sndbuf_desc in smc_cdc_tx_handler()

Damien Le Moal (3):
      block: null_blk: Fix handling of fake timeout request
      block: null_blk: cleanup null_queue_rq()
      nvmet: avoid potential UAF in nvmet_req_complete()

Dan Carpenter (1):
      fbdev: chipsfb: Fix error codes in chipsfb_pci_init()

Daniel Golle (2):
      net: ethernet: mtk_eth_soc: reset PCS state
      net: ethernet: mtk_eth_soc: only write values if needed

Daniel Jurgens (1):
      net/mlx5: Disable eswitch before waiting for VF pages

Daniil Tatianin (2):
      qed/qed_dev: guard against a possible division by zero
      qed/qed_mng_tlv: correctly zero out ->min instead of ->hour

Dave Ertman (1):
      ice: avoid bonding causing auxiliary plug/unplug under RTNL lock

David Belanger (1):
      drm/amdkfd: Fixed kfd_process cleanup on module exit.

David Hildenbrand (1):
      mm/userfaultfd: propagate uffd-wp bit when PTE-mapping the huge zerop=
age

David Woodhouse (2):
      KVM: selftests: Use enum for test numbers in xen_shinfo_test
      KVM: selftests: Add EVTCHNOP_send slow path test to xen_shinfo_test

Dionna Glaze (1):
      virt/coco/sev-guest: Add throttling awareness

Dmitry Baryshkov (3):
      interconnect: qcom: osm-l3: fix icc_onecell_data allocation
      interconnect: qcom: sm8450: switch to qcom_icc_rpmh_* function
      interconnect: qcom: sm8550: switch to qcom_icc_rpmh_* function

Dmitry Osipenko (3):
      drm/shmem-helper: Remove another errant put in error path
      drm/msm/gem: Prevent blocking within shrinker loop
      drm/panfrost: Don't sync rpm suspension after mmu flushing

Dylan Jhong (1):
      RISC-V: mm: Support huge page in vmalloc_fault()

Elmer Miroslav Mosher Golovin (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Netac NV3000

Emeel Hakim (1):
      net/mlx5e: Fix macsec ASO context alignment

Emil Abildgaard Svendsen (1):
      ASoC: hdmi-codec: only startup/shutdown on supported streams

Eric Dumazet (1):
      net: tunnels: annotate lockless accesses to dev->needed_headroom

Eugenio P=C3=A9rez (1):
      vdpa_sim: set last_used_idx as last_avail_idx in vdpasim_queue_ready

Fedor Pchelkin (1):
      nfc: pn533: initialize struct pn533_out_arg properly

Felix Kuehling (1):
      drm/amdgpu: Don't resume IOMMU after incomplete init

Francesco Dolcini (1):
      mmc: sdhci_am654: lower power-on failed message severity

Gal Pressman (1):
      net/mlx5e: kTLS, Fix missing error unwind on unsupported cipher type

Gautam Dawar (1):
      vhost-vdpa: free iommu domain after last use during cleanup

Geliang Tang (1):
      mptcp: add ro_after_init for tcp{,v6}_prot_override

Glenn Washburn (1):
      docs: Correct missing "d_" prefix for dentry_operations member
d_weak_revalidate

Guchun Chen (1):
      drm/amdgpu: move poll enabled/disable into non DC path

Guenter Roeck (1):
      ASoC: da7219: Initialize jack_det_mutex

Guilherme G. Piccoli (1):
      drm/amdgpu/vcn: Disable indirect SRAM on Vangogh broken BIOSes

Guillaume Tucker (2):
      selftests: amd-pstate: fix TEST_FILES
      selftests: fix LLVM build for i386 and x86_64

Guo Ren (1):
      riscv: asid: Fixup stale TLB entry cause application crash

Hamidreza H. Fard (1):
      ALSA: hda/realtek: Fix the speaker output on Samsung Galaxy Book2 Pro

Hangbin Liu (2):
      Revert "net/sched: act_api: move TCA_EXT_WARN_MSG to the correct
hierarchy"
      net/sched: act_api: add specific EXT_WARN_MSG for tc action

Hans de Goede (3):
      ACPI: x86: Introduce an acpi_quirk_skip_gpio_event_handlers() helper
      ACPI: x86: Add skip i2c clients quirk for Acer Iconia One 7 B1-750
      ACPI: x86: Add skip i2c clients quirk for Lenovo Yoga Book X90

Heiko Carstens (1):
      s390: update defconfigs

Heiner Kallweit (1):
      net: phy: smsc: bail out in lan87xx_read_status if
genphy_read_status fails

Helge Deller (1):
      fbdev: stifb: Provide valid pixelclock and add fb_check_var() checks

Herbert Xu (2):
      xfrm: Zero padding when dumping algos and encap
      xfrm: Allow transport-mode states with AF_UNSPEC selector

Huang Ying (3):
      migrate_pages: fix deadlock in batched migration
      migrate_pages: move split folios processing out of migrate_pages_batc=
h()
      migrate_pages: try migrate in batch asynchronously firstly

Ido Schimmel (2):
      mlxsw: spectrum: Fix incorrect parsing depth after reload
      ipv4: Fix incorrect table ID in IOCTL path

Irvin Cote (1):
      nvme-pci: fixing memory leak in probe teardown path

Ivan Vecera (1):
      i40e: Fix kernel crash during reboot when adapter is in recovery mode

Jakub Kicinski (4):
      tools: ynl: make definitions optional again
      ynl: broaden the license even more
      ynl: make the tooling check the license
      net: xdp: don't call notifiers during driver init

James Houghton (1):
      mm: teach mincore_hugetlb about pte markers

Jan Beulich (1):
      x86/PVH: obtain VGA console info in Dom0

Jan Kara (1):
      block: do not reverse request order when flushing plug list

Jan Kara via Ocfs2-devel (1):
      ocfs2: fix data corruption after failed write

Jane Jian (1):
      drm/amdgpu/vcn: custom video info caps for sriov

Janusz Krzysztofik (1):
      drm/i915/active: Fix misuse of non-idle barriers as fence trackers

Jarkko Sakkinen (1):
      mailmap: updates for Jarkko Sakkinen

Jaska Uimonen (1):
      ASoC: SOF: ipc4-topology: set dmic dai index from copier

Jeremy Sowden (4):
      netfilter: nft_nat: correct length for loading protocol registers
      netfilter: nft_masq: correct length for loading protocol registers
      netfilter: nft_redir: correct length for loading protocol registers
      netfilter: nft_redir: correct value of inet type `.maxattrs`

Jeremy Szu (1):
      ALSA: hda/realtek: fix speaker, mute/micmute LEDs not work on a
HP platform

Jianguo Wu (1):
      ipvlan: Make skb->skb_iif track skb->dev for l3s mode

Jiri Pirko (2):
      MAINTAINERS: make my email address consistent
      docs: vfio: fix header path

Johan Hovold (24):
      drm/edid: fix info leak when failing to get panel id
      drm/sun4i: fix missing component unbind on bind errors
      interconnect: fix mem leak when freeing nodes
      interconnect: fix icc_provider_del() error handling
      interconnect: fix provider registration API
      interconnect: imx: fix registration race
      interconnect: qcom: osm-l3: fix registration race
      interconnect: qcom: rpm: fix probe child-node error handling
      serial: 8250_fsl: fix handle_irq locking
      serial: qcom-geni: fix console shutdown hang
      serial: qcom-geni: fix DMA mapping leak on shutdown
      serial: qcom-geni: fix mapping of empty DMA buffer
      serial: qcom-geni: drop bogus uart_write_wakeup()
      interconnect: qcom: rpm: fix registration race
      interconnect: qcom: rpmh: fix probe child-node error handling
      interconnect: qcom: rpmh: fix registration race
      interconnect: qcom: msm8974: fix registration race
      interconnect: exynos: fix node leak in probe PM QoS error path
      interconnect: exynos: fix registration race
      interconnect: exynos: drop redundant link destroy
      memory: tegra: fix interconnect registration race
      memory: tegra124-emc: fix interconnect registration race
      memory: tegra20-emc: fix interconnect registration race
      memory: tegra30-emc: fix interconnect registration race

Johannes Berg (4):
      wifi: nl80211: fix NULL-ptr deref in offchan check
      wifi: nl80211: fix puncturing bitmap policy
      wifi: mac80211: check basic rates validity
      wifi: cfg80211: fix MLO connection ownership

Jonathan Neusch=C3=A4fer (1):
      zstd: Fix definition of assert()

Jouni H=C3=B6gander (1):
      drm/i915/psr: Use calculated io and fast wake lines

Jurica Vukadin (1):
      kconfig: Update config changed flag before calling callback

Kees Cook (1):
      lib: zstd: Fix -Wstringop-overflow warning

Konrad Dybcio (2):
      interconnect: qcom: qcm2290: Fix MASTER_SNOC_BIMC_NRT
      mailmap: correct Dikshita Agarwal's Qualcomm email address

Krister Johansen (2):
      xen: update arch/x86/include/asm/xen/cpuid.h
      x86/xen/time: cleanup xen_tsc_safe_clocksource

Kristian Overskeid (1):
      net: hsr: Don't log netdev_err message on unknown prp dst node

Krzysztof Kozlowski (2):
      ASoC: qcom: q6prm: fix incorrect clk_root passed to ADSP
      hwmon: tmp512: drop of_match_ptr for ID table

Kumaravel Thiagarajan (1):
      serial: 8250_pci1xxxx: Disable SERIAL_8250_PCI1XXXX config by default

Kuninori Morimoto (2):
      ALSA: asihpi: check pao in control_message()
      ALSA: hda/ca0132: fixup buffer overrun at tuning_ctl_set()

Kuniyuki Iwashima (2):
      tcp: Fix bind() conflict check for dual-stack wildcard address.
      selftest: Add test for bind() conflicts.

Lars-Peter Clausen (3):
      hwmon: (ucd90320) Add minimum delay between bus accesses
      hwmon: (adm1266) Set `can_sleep` flag for GPIO chip
      hwmon: (ltc2992) Set `can_sleep` flag for GPIO chip

Lee Duncan (1):
      scsi: core: Add BLIST_NO_VPD_SIZE for some VDASD

Len Brown (3):
      tools/power turbostat: update dump of SECONDARY_TURBO_RATIO_LIMIT
      tools/power turbostat: remove stray newlines from warn/warnx strings
      tools/power turbostat: version 2023.03.17

Li zeming (1):
      io_uring: rsrc: Optimize return value variable 'ret'

Liang He (2):
      block: sunvdc: add check for mdesc_grab() returning NULL
      ethernet: sun: add check for the mdesc_grab()

Linus Torvalds (3):
      sched_getaffinity: don't assume 'cpumask_size()' is fully initialized
      media: m5mols: fix off-by-one loop termination error
      Linux 6.3-rc3

Liu Ying (1):
      drm/bridge: Fix returned array size name for
atomic_get_input_bus_fmts kdoc

Lorenzo Bianconi (8):
      tools: ynl: fix render-max for flags definition
      tools: ynl: fix get_mask utility routine
      xdp: add xdp_set_features_flag utility routine
      net: thunderx: take into account xdp_features setting tx/rx queues
      net: ena: take into account xdp_features setting tx/rx queues
      veth: take into account device reconfiguration for xdp_features flag
      net/mlx5e: take into account device reconfiguration for xdp_features =
flag
      veth: rely on rtnl_dereference() instead of on rcu_dereference()
in veth_set_xdp_features()

Luca Ceresoli (1):
      ASoC: clarify that SND_SOC_IMX_SGTL5000 is the old driver

Lucy Mielke (1):
      fbdev: omapfb: cleanup inconsistent indentation

Lukas Bulwahn (3):
      MAINTAINERS: orphan SIS FRAMEBUFFER DRIVER
      MAINTAINERS: repair malformed T: entries in NVM EXPRESS DRIVERS
      block: remove obsolete config BLOCK_COMPAT

Maciej Fijalkowski (1):
      ice: xsk: disable txq irq before flushing hw

Maor Dickman (2):
      net/mlx5: E-switch, Fix wrong usage of source port rewrite in split r=
ules
      net/mlx5: E-switch, Fix missing set of split_count when forward
to ovs internal port

Marc Zyngier (1):
      KVM: arm64: timers: Convert per-vcpu virtual offset to a global value

Marcus Folkesson (1):
      hwmon: (ina3221) return prober error code

Marek Szyprowski (1):
      drm/meson: dw-hdmi: Fix devm_regulator_*get_enable*() conversion agai=
n

Marek Vasut (1):
      net: dsa: microchip: fix RGMII delay configuration on
KSZ8765/KSZ8794/KSZ8795

Masahiro Yamada (7):
      kbuild: deb-pkg: make debian source package working again
      kbuild: deb-pkg: do not take KERNELRELEASE from the source version
      kbuild: deb-pkg: set CROSS_COMPILE only when undefined
      kbuild: deb-pkg: split image and debug objects staging out into funct=
ions
      kbuild: deb-pkg: use dh_listpackages to know enabled packages
      kbuild: rpm-pkg: move source components to rpmbuild/SOURCES
      kbuild: use git-archive for source package creation

Matteo Croce (1):
      mvpp2: take care of xdp_features when reconfiguring queues

Matthieu Baerts (3):
      selftests: mptcp: userspace pm: fix printed values
      mptcp: avoid setting TCP_CLOSE state twice
      hsr: ratelimit only when errors are printed

Michael Walle (1):
      nvmem: core: return -ENOENT if nvmem cell is not found

Michal Koutn=C3=BD (1):
      io_uring/sqpoll: Do not set PF_NO_SETAFFINITY on sqpoll threads

Miguel Ojeda (2):
      docs: programming-language: remove mention of the Intel compiler
      docs: programming-language: add Rust programming language section

Mike Rapoport (IBM) (2):
      docs/mm: Physical Memory: fix a reference to a file that doesn't exis=
t
      docs/mm: hugetlbfs_reserv: fix a reference to a file that doesn't exi=
st

Ming Lei (1):
      nvme: fix handling single range discard request

Minwoo Im (1):
      nvme-trace: show more opcode names

Nathan Chancellor (1):
      clk: Avoid invalid function names in CLK_OF_DECLARE()

NeilBrown (2):
      md: avoid signed overflow in slot_store()
      md: select BLOCK_LEGACY_AUTOLOAD

Nick Alcock (2):
      kbuild, clk: bcm2835: remove MODULE_LICENSE in non-modules
      kbuild, clk: remove MODULE_LICENSE in non-modules

Nick Terrell (1):
      lib: zstd: Backport fix for in-place decompression

Nikita Romanyuk (2):
      drivers: video: logo: fix code style issues in pnmtologo.c
      drivers: video: logo: add SPDX comment, remove GPL notice in pnmtolog=
o.c

Nikita Zhandarovich (1):
      x86/mm: Fix use of uninitialized buffer in sme_enable()

Niklas Schnelle (1):
      PCI: s390: Fix use-after-free of PCI resources with per-function hotp=
lug

Nikolay Aleksandrov (3):
      bonding: restore IFF_MASTER/SLAVE flags on bond enslave ether type ch=
ange
      bonding: restore bond's IFF_SLAVE flag if a non-eth dev enslave fails
      selftests: bonding: add tests for ether type changes

Oleksandr Tyshchenko (1):
      drm/virtio: Pass correct device to dma_sync_sgtable_for_device()

Ondrej Zary (2):
      ata: pata_parport: fix parport release without claim
      ata: pata_parport: fix memory leaks

Oz Shlomo (4):
      net/sched: TC, fix raw counter initialization
      net/mlx5e: TC, fix missing error code
      net/mlx5e: TC, fix cloned flow attribute
      net/mlx5e: TC, Remove error message log print

Paolo Abeni (5):
      mptcp: fix possible deadlock in subflow_error_report
      mptcp: refactor passive socket initialization
      mptcp: use the workqueue to destroy unaccepted sockets
      mptcp: fix UaF in listener shutdown
      mptcp: fix lockdep false positive in mptcp_pm_nl_create_listen_socket=
()

Paolo Bonzini (3):
      KVM: nVMX: add missing consistency checks for CR0 and CR4
      KVM: nVMX: remove unnecessary #ifdef
      selftests: KVM: skip hugetlb tests if huge pages are not available

Parav Pandit (2):
      net/mlx5e: Don't cache tunnel offloads capability
      net/mlx5: Fix setting ec_function bit in MANAGE_PAGES

Paul Blakey (1):
      net/mlx5e: Fix cleanup null-ptr deref on encap lock

Paulo Alcantara (4):
      cifs: set DFS root session in cifs_get_smb_ses()
      cifs: fix use-after-free bug in refresh_cache_worker()
      cifs: return DFS root session id in DebugData
      cifs: use DFS root session instead of tcon ses

Pavel Begunkov (2):
      io_uring/msg_ring: let target know allocated index
      io_uring/rsrc: fix folio accounting

Peter Ujfalusi (1):
      ASoC: SOF: ipc3: Check for upper size limit for the received message

Philipp Geulen (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Lexar NM620

Pierre-Louis Bossart (4):
      ASoC: Intel: soc-acpi: fix copy-paste issue in topology names
      ASoC: SOF: Intel: pci-tng: revert invalid bar size setting
      ASoC: SOF: Intel: hda-ctrl: re-add sleep after entering and exiting r=
eset
      ASoC: SOF: sof-audio: don't squelch errors in WIDGET_SETUP phase

Po-Hsu Lin (1):
      selftests: net: devlink_port_split.py: skip test if no suitable
device available

Prarit Bhargava (2):
      tools/power turbostat: Provide better debug messages for failed
capabilities accesses
      tools/power turbostat: Fix /dev/cpu_dma_latency warnings

Radu Pirea (OSS) (1):
      net: phy: nxp-c45-tja11xx: fix MII_BASIC_CONFIG_REV bit

Rander Wang (2):
      ASoC: SOF: Intel: hda-dsp: harden D0i3 programming sequence
      ASoC: SOF: IPC4: update gain ipc msg definition to align with fw

Randy Dunlap (3):
      clk: HI655X: select REGMAP instead of depending on it
      serial: 8250: ASPEED_VUART: select REGMAP instead of depending on it
      powerpc/pseries: RTAS work area requires GENERIC_ALLOCATOR

Ranjani Sridharan (6):
      ASoC: SOF: Intel: MTL: Fix the device description
      ASoC: SOF: Intel: HDA: Fix device description
      ASoC: SOF: Intel: SKL: Fix device description
      ASOC: SOF: Intel: pci-tgl: Fix device description
      ASoC: SOF: topology: Fix error handling in sof_widget_ready()
      ASoC: SOF: sof-audio: Fix broken early bclk feature for SSP

Ravulapati Vishnu Vardhan Rao (1):
      ASoC: codecs: tx-macro: Fix for KASAN: slab-out-of-bounds

Rob Herring (3):
      fbdev: Use of_property_read_bool() for boolean properties
      fbdev: Use of_property_present() for testing DT property presence
      net: Use of_property_read_bool() for boolean properties

Roman Gushchin (1):
      firmware: xilinx: don't make a sleepable memory allocation from
an atomic context

Rong Tao (3):
      tools/virtio: Ignore virtio-trace/trace-agent
      KVM: VMX: Fix indentation coding style issue
      KVM: VMX: Use tabs instead of spaces for indentation

Russell Currey (1):
      powerpc/mm: Fix false detection of read faults

Saaem Rizvi (1):
      drm/amd/display: Remove OTG DIV register write for Virtual signals.

Sagi Grimberg (2):
      nvme-tcp: fix opcode reporting in the timeout handler
      nvme-tcp: add nvme-tcp pdu size build protection

Samuel Thibault (1):
      tty: vt: protect KD_FONT_OP_GET_TALL from unbound access

Saravana Kannan (2):
      clk: Mark a fwnode as initialized when using CLK_OF_DECLARE() macro
      serdev: Set fwnode for serdev devices

Sean Christopherson (5):
      KVM: SVM: Fix a benign off-by-one bug in AVIC physical table mask
      KVM: SVM: WARN if GATag generation drops VM or vCPU ID information
      KVM: selftests: Move the guts of kvm_hypercall() to a separate macro
      KVM: selftests: Add helpers to make Xen-style VMCALL/VMMCALL hypercal=
ls
      KVM: selftests: Add macro to generate KVM exit reason strings

SeongJae Park (2):
      mm/damon/paddr: fix folio_size() call after folio_put() in
damon_pa_young()
      mm/damon/paddr: fix folio_nr_pages() after folio_put() in
damon_pa_mark_accessed_or_deactivate()

Seppo Ingalsuo (1):
      ASoC: SOF: ipc4-topology: Fix incorrect sample rate print unit

Sergey Matyukevich (1):
      Revert "riscv: mm: notify remote harts about mmu cache updates"

Shawn Bohrer (1):
      veth: Fix use after free in XDP_REDIRECT

Shawn Guo (1):
      cpuidle: psci: Iterate backwards over list in psci_pd_remove()

Shawn Wang (1):
      x86/resctrl: Clear staged_config[] before and after it is used

Shay Drory (1):
      net/mlx5: Set BREAK_FW_WAIT flag first when removing driver

Sherry Sun (1):
      tty: serial: fsl_lpuart: skip waiting for transmission complete
when UARTCTRL_SBK is asserted

Shyam Prasad N (1):
      cifs: generate signkey for the channel that's reconnecting

Si-Wei Liu (1):
      vdpa/mlx5: should not activate virtq object when suspended

Song Liu (1):
      perf: fix perf_event_context->time

Song Shuai (1):
      sched/doc: supplement CPU capacity with RISC-V

Stanislaw Gruszka (1):
      accel: Build sub-directories based on config options

Stefan Raspl (1):
      net/smc: Fix device de-init sequence

Steven Rostedt (Google) (3):
      tracing: Do not let histogram values have some modifiers
      tracing: Check field value in hist_field_name()
      tracing: Make tracepoint lockdep check actually test something

Sudeep Holla (1):
      ACPI: PPTT: Fix to avoid sleep in the atomic context when PPTT is abs=
ent

Sung-hun Kim (1):
      tracing: Make splice_read available again

Suravee Suthikulpanit (1):
      KVM: SVM: Modify AVIC GATag to support max number of 512 vCPUs

Sven Schnelle (1):
      s390/ipl: add missing intersection check to ipl_report handling

Szymon Heidrich (2):
      net: usb: smsc75xx: Limit packet length to skb->len
      net: usb: smsc75xx: Move packet length check to prevent kernel
panic in skb_pull

Takashi Iwai (1):
      fbdev: Fix incorrect page mapping clearance at fb_deferred_io_release=
()

Tero Kristo (2):
      trace/hwlat: Do not wipe the contents of per-cpu thread data
      trace/hwlat: Do not start per-cpu thread if it is already running

Theodore Ts'o (1):
      ext4: fix possible double unlock when moving a directory

Thomas Bogendoerfer (1):
      i825xx: sni_82596: use eth_hw_addr_set()

Thomas Hellstr=C3=B6m (1):
      drm/ttm: Fix a NULL pointer dereference

Tim Huang (1):
      drm/amd/pm: bump SMU 13.0.4 driver_if header version

Todd Brandt (1):
      pm-graph: sleepgraph: Avoid crashing on binary data in device names

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      net: atlantic: Fix crash when XDP is enabled but no program is loaded

Tom Rix (3):
      Revert "tty: serial: fsl_lpuart: adjust
SERIAL_FSL_LPUART_CONSOLE config dependency"
      tracing/osnoise: set several trace_osnoise.c variables
storage-class-specifier to static
      ftrace: Set direct_ops storage-class-specifier to static

Tomas Henzl (6):
      scsi: mpi3mr: Fix throttle_groups memory leak
      scsi: mpi3mr: Fix config page DMA memory leak
      scsi: mpi3mr: Fix mpi3mr_hba_port memory leak in mpi3mr_remove()
      scsi: mpi3mr: Fix sas_hba.phy memory leak in mpi3mr_remove()
      scsi: mpi3mr: Fix memory leaks in mpi3mr_init_ioc()
      scsi: mpi3mr: Fix expander node leak in mpi3mr_remove()

Tony O'Brien (2):
      hwmon: (adt7475) Display smoothing attributes in correct order
      hwmon: (adt7475) Fix masking of hysteresis registers

Tzafrir Cohen (1):
      Makefile: Make kernelrelease target work with M=3D

Uwe Kleine-K=C3=B6nig (1):
      docs: rebasing-and-merging: Drop wrong statement about git

Vadim Fedorenko (1):
      bnxt_en: reset PHC frequency in free-running mode

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Fix audio ELD handling for DP MST

Vipin Sharma (3):
      KVM: selftests: Make vCPU exit reason test assertion common
      KVM: selftests: Print expected and actual exit reason in KVM
exit reason assert
      KVM: selftests: Sync KVM exit reasons in selftests

Vladimir Oltean (3):
      net: phy: mscc: fix deadlock in phy_ethtool_{get,set}_wol()
      net: dsa: don't error out when drivers return ETH_DATA_LEN in
.port_max_mtu()
      net: dsa: mv88e6xxx: fix max_mtu of 1492 on 6165, 6191, 6220, 6250, 6=
290

Vlastimil Babka (1):
      ring-buffer: remove obsolete comment for free_buffer_page()

Volker Lendecke (1):
      cifs: Fix smb2_set_path_size()

Wei Chen (5):
      fbdev: tgafb: Fix potential divide by zero
      fbdev: nvidia: Fix potential divide by zero
      fbdev: intelfb: Fix potential divide by zero
      fbdev: lxfb: Fix potential divide by zero
      fbdev: au1200fb: Fix potential divide by zero

Wenchao Hao (1):
      scsi: mpt3sas: Fix NULL pointer access in mpt3sas_transport_port_add(=
)

Wenjia Zhang (1):
      net/smc: fix deadlock triggered by cancel_delayed_work_syn()

Wesley Chalmers (1):
      drm/amd/display: Do not set DRR on pipe Commit

William Qiu (1):
      mmc: dw_mmc-starfive: Fix initialization of prev_err

Wolfram Sang (2):
      ravb: avoid PHY being resumed when interface is not up
      sh_eth: avoid PHY being resumed when interface is not up

Xiao Ni (1):
      md: Free resources in __md_stop

Xiaogang Chen (2):
      drm/amdkfd: Fix BO offset for multi-VMA page migration
      drm/amdkfd: Get prange->offset after svm_range_vram_node_new

Xuan Zhuo (5):
      virtio_net: reorder some funcs
      virtio_net: separate the logic of checking whether sq is full
      virtio_net: add checking sq is full inside xdp xmit
      virtio_net: fix page_to_skb() miss headroom
      virtio_net: free xdp shinfo frags when build_skb_from_xdp_buff() fail=
s

Xujun Leng (1):
      docs: process: typo fix

Yang Jihong (1):
      perf/core: Fix perf_output_begin parameter is incorrectly
invoked in perf_event_bpf_output

Yang Li (4):
      fbdev: clps711x-fb: Use devm_platform_get_and_ioremap_resource()
      fbdev: pxa3xx-gcu: Use devm_platform_get_and_ioremap_resource()
      fbdev: wm8505fb: Use devm_platform_ioremap_resource()
      fbdev: xilinxfb: Use devm_platform_get_and_ioremap_resource()

Yazen Ghannam (1):
      x86/mce: Make sure logged MCEs are processed after sysfs update

Yoshihiro Shimoda (2):
      net: renesas: rswitch: Fix the output value of quote from rswitch_rx(=
)
      net: renesas: rswitch: Fix GWTSDIE register handling

Yu Kuai (1):
      block: count 'ios' and 'sectors' when io is done for bio-based device

Yu Zhe (1):
      xen: remove unnecessary (void*) conversions

Zhang Rui (1):
      tools/power turbostat: Introduce support for EMR

Zhang Xiaoxu (1):
      cifs: Move the in_send statistic to __smb_send_rqst()

Zheng Wang (2):
      hwmon: (xgene) Fix use after free bug in xgene_hwmon_remove due
to race condition
      nfc: st-nci: Fix use after free bug in ndlc_remove due to race condit=
ion
