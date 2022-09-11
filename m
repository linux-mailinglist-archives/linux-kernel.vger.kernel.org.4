Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AE35B5132
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 23:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiIKVES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 17:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIKVEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 17:04:15 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC858642D
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 14:04:13 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id y29so8414882ljq.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 14:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date;
        bh=gVfjQ65zQwi0wQof1wXgNdD826kFIReZpvg93IxcOXw=;
        b=NLTL3JwYmW7vMiO92PFaIHVSS9rO1L209N6NeT0BRAP1BQlH4zknokoAG90OobZg7f
         cxUPw+UdZ0aB1OpXD+zTQE1Z3KESp3/1chUTrjHTIla4Dd0m9wCzeiXT5rb6oSVDeYcj
         3JUqV3JIYPdnRbByvED1hGXmGyUD46EMSTiSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gVfjQ65zQwi0wQof1wXgNdD826kFIReZpvg93IxcOXw=;
        b=AQ744BFmaFXtJ+zuN0Dlz5k8taNtiS5a2bLbdtDtHQo06UwjeR3/QtJJUxT4kVw4ge
         VLCBttKT7lh5dLM0G5zfPn1nTMioJ1GBb/z2KMKOnWuTSzW9uLSz0FYDWbfOordcGmg5
         y2rWU1o36MTHqYZtUK8hL3zBpHUELT0dS8W9NxyLJUgMshDoRHJGHVvTL/FFexUXNoaa
         J0bzQkC/Qs8yHRTZHqNsrLcj2W1wecw1M41gnpDraFQU4BSbHEJgSjVZg8NNVgwyO253
         r5AmlgsagQtmsYPolKeR4uf6DwJ1NMAZsvpi3raJzde076+BiQ1y0yr7nwWlvGqEYAQJ
         0c+g==
X-Gm-Message-State: ACgBeo3lf6CLW8XGBcyy8EHWg7FojCWFFxY05FLVqZiYIlzh89qF0Jn6
        TpoYsy2tMeH72KBo/EHA/tp9jiV/x/xduPch
X-Google-Smtp-Source: AA6agR70c8LsKaso4gzbjWIECBTl04oLseg/s1+Ox2A/b/sVsQVv1yFSs4O8v0FF9Uz4tePhg/gr/g==
X-Received: by 2002:a2e:2405:0:b0:26a:cda3:7869 with SMTP id k5-20020a2e2405000000b0026acda37869mr7410113ljk.456.1662930251480;
        Sun, 11 Sep 2022 14:04:11 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id c24-20020a197618000000b00497a41b3a42sm727714lff.88.2022.09.11.14.04.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 14:04:10 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id x10so8418335ljq.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 14:04:10 -0700 (PDT)
X-Received: by 2002:a05:651c:1946:b0:26b:fe50:895d with SMTP id
 bs6-20020a05651c194600b0026bfe50895dmr1352489ljb.264.1662930250109; Sun, 11
 Sep 2022 14:04:10 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 11 Sep 2022 17:03:53 -0400
X-Gmail-Original-Message-ID: <CAHk-=wjG0js0MpsoH3-yvp05u_gXHu+uhkvqdAZDVb=9xUmX=g@mail.gmail.com>
Message-ID: <CAHk-=wjG0js0MpsoH3-yvp05u_gXHu+uhkvqdAZDVb=9xUmX=g@mail.gmail.com>
Subject: Linux 6.0-rc5
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

It's Sunday afternoon, time for another -rc release.

Things look fairly normal for the rc5 timeframe, at least in number of
commits, and in the diffstat.

A bit over half the diff is drivers: GPU, rdma, iommu, networking,
sound, scsi... A little bit of everything.

The rest is the usual random fixes, with i2c doc updates standing out,
but also various DT updates, a few filesystem fixes (btrfs and erofs),
some core networking, and some tooling (perf and selftests).

Nothing looks particularly scary, so jump right in.

               Linus

---

Adrian Hunter (3):
      libperf evlist: Fix per-thread mmaps for multi-threaded targets
      perf dlfilter dlfilter-show-cycles: Fix types for print format
      perf record: Fix synthesis failure warnings

Ajay.Kathat@microchip.com (1):
      wifi: wilc1000: fix DMA on stack objects

Alex Williamson (1):
      vfio/type1: Unpin zero pages

Alexander Gordeev (2):
      s390/boot: fix absolute zero lowcore corruption on boot
      s390/smp: enforce lowcore protection on CPU restart

Alexander Stein (1):
      arm64: dts: imx8mq-tqma8mq: Remove superfluous interrupt-names

Alexander Sverdlin (3):
      MIPS: octeon: Get rid of preprocessor directives around RESERVE32
      MIPS: OCTEON: irq: Fix octeon_irq_force_ciu_mapping()
      mips: Select SPARSEMEM_EXTREME

Alexandru Gagniuc (1):
      hwmon: (tps23861) fix byte order in resistance register

Alison Schofield (1):
      tracepoint: Allow trace events in modules with TAINT_TEST

Andrejs Cainikovs (2):
      arm64: dts: imx8mm-verdin: update CAN clock to 40MHz
      arm64: dts: imx8mm-verdin: use level interrupt for mcp251xfd

Andrew Halaney (1):
      regulator: core: Clean up on enable failure

Ard Biesheuvel (1):
      efi: libstub: Disable struct randomization

Arun Ramadoss (1):
      net: phy: lan87xx: change interrupt src of link_up to comm_ready

Athira Rajeev (2):
      perf affinity: Fix out of bound access to "sched_cpus" mask
      tools/perf: Fix out of bound access to cpu mask array

Bard Liao (1):
      ASoC: SOF: ipc4-topology: fix alh_group_ida max value

Bart Van Assche (6):
      scsi: core: Revert "Call blk_mq_free_tag_set() earlier"
      scsi: core: Revert "Simplify LLD module reference counting"
      scsi: core: Revert "Make sure that hosts outlive targets"
      scsi: core: Revert "Make sure that targets outlive devices"
      scsi: core: Fix a use-after-free
      nvmet: fix a use-after-free

Brian Norris (1):
      tracefs: Only clobber mode/uid/gid on remount if asked

Bruce Duncan (1):
      docs: i2c: piix4: Fix typos, add markup, drop link

Chao Gao (2):
      swiotlb: avoid potential left shift overflow
      swiotlb: fix a typo

Chengchang Tang (1):
      RDMA/hns: Fix supported page size

Chengming Gui (1):
      drm/amd/amdgpu: add rlc_firmware_header_v2_4 to amdgpu_firmware_heade=
r

Chris Mi (1):
      RDMA/mlx5: Set local port to one when accessing counters

Christian A. Ehrhardt (1):
      kprobes: Prohibit probes in gate area

Christian K=C3=B6nig (1):
      drm/ttm: cleanup the resource of ghost objects after locking them

Christian Marangi (1):
      net: dsa: qca8k: fix NULL pointer dereference for of_device_get_match=
_data

Christoph Hellwig (1):
      dma-mapping: mark dma_supported static

Christophe JAILLET (1):
      stmmac: intel: Simplify intel_eth_pci_remove()

Claudiu Beznea (8):
      ARM: configs: at91: remove CONFIG_MICROCHIP_PIT64B
      ARM: at91: pm: fix self-refresh for sama7g5
      ARM: at91: pm: fix DDR recalibration when resuming from backup
and self-refresh
      ARM: dts: at91: sama5d27_wlsom1: specify proper regulator output rang=
es
      ARM: dts: at91: sama5d2_icp: specify proper regulator output ranges
      ARM: dts: at91: sama7g5ek: specify proper regulator output ranges
      ARM: dts: at91: sama5d27_wlsom1: don't keep ldo2 enabled all the time
      ARM: dts: at91: sama5d2_icp: don't keep vdd_other enabled all the tim=
e

Cl=C3=A9ment P=C3=A9ron (1):
      drm/panfrost: devfreq: set opp to the recommended one to
configure regulator

Conor Dooley (4):
      MAINTAINERS: add PolarFire SoC dt bindings
      MAINTAINERS: add the Polarfire SoC's i2c driver
      dt-bindings: riscv: sifive-l2: add a PolarFire SoC compatible
      riscv: dts: microchip: use an mpfs specific l2 compatible

Cristian Ciocaltea (1):
      regmap: spi: Reserve space for register address/padding

Cs=C3=B3k=C3=A1s Bence (1):
      net: fec: Use a spinlock to guard `fep->ptp_clk_on`

Dan Carpenter (1):
      tipc: fix shift wrapping bug in map_get()

Daniel Bristot de Oliveira (2):
      rv/monitors: Make monitor's automata definition static
      MAINTAINERS: Add Runtime Verification (RV) entry

David Howells (7):
      rxrpc: Fix ICMP/ICMP6 error handling
      rxrpc: Fix an insufficiently large sglist in rxkad_verify_packet_2()
      rxrpc: Fix local destruction being repeated
      rxrpc: Fix calc of resend age
      afs: Use the operation issue time instead of the reply time for callb=
acks
      rxrpc: Remove rxrpc_get_reply_time() which is no longer used
      afs: Return -EAGAIN, not -EREMOTEIO, when a file already locked

David Jander (2):
      ARM: dts: imx6qdl-vicut1.dtsi: Fix node name backlight_led
      spi: spi: Fix queue hang if previous transfer failed

David Leadbeater (1):
      netfilter: nf_conntrack_irc: Fix forged IP logic

David Lebrun (1):
      ipv6: sr: fix out-of-bounds read when setting HMAC data.

Dennis Maisenbacher (1):
      nvmet: fix mar and mor off-by-one errors

Deren Wu (1):
      wifi: mt76: mt7921e: fix crash in chip reset fail

Dongxiang Ke (1):
      ALSA: usb-audio: Fix an out-of-bounds bug in
__snd_usb_parse_audio_interface()

Eliav Farber (6):
      dt-bindings: hwmon: (mr75203) fix "intel,vm-map" property to be optio=
nal
      hwmon: (mr75203) fix VM sensor allocation when "intel,vm-map" not def=
ined
      hwmon: (mr75203) update pvt->v_num and vm_num to the actual
number of used sensors
      hwmon: (mr75203) fix voltage equation for negative source input
      hwmon: (mr75203) fix multi-channel voltage reading
      hwmon: (mr75203) enable polling for all VM channels

Eric Dumazet (1):
      tcp: TX zerocopy should not sense pfmemalloc status

Eugene Shalygin (1):
      hwmon: (asus-ec-sensors) autoload module via DMI data

Evan Quan (1):
      drm/amd/pm: add missing SetMGpuFanBoostLimitRpm mapping for SMU 13.0.=
7

Gao Xiang (1):
      erofs: fix pcluster use-after-free on UP platforms

Geert Uytterhoeven (1):
      arm64: dts: renesas: r8a779g0: Fix HSCIF0 interrupt number

Greg Kroah-Hartman (6):
      Revert "arch_topology: Make cluster topology span at least SMT CPUs"
      driver core: fix driver_set_override() issue with empty strings
      debugfs: add debugfs_lookup_and_remove()
      sched/debug: fix dentry leak in update_sched_domain_debugfs
      net: mvpp2: debugfs: fix memory leak when using debugfs_lookup()
      drm/amd/display: fix memory leak when using debugfs_lookup()

Guchun Chen (1):
      drm/amdgpu: prevent toc firmware memory leak

Hangbin Liu (3):
      bonding: use unspecified address if no available link local address
      bonding: add all node mcast address when slave up
      bonding: accept unsolicited NA message

Hannes Reinecke (1):
      scsi: lpfc: Return DID_TRANSPORT_DISRUPTED instead of DID_REQUEUE

Harsh Modi (1):
      netfilter: br_netfilter: Drop dst references before setting.

Heiner Kallweit (1):
      Revert "net: phy: meson-gxl: improve link-up behavior"

Hyunwoo Kim (1):
      efi: capsule-loader: Fix use-after-free in efi_capsule_write

Ian Rogers (1):
      perf metric: Return early if no CPU PMU table exists

Isaac Manjarres (1):
      ARM: 9229/1: amba: Fix use-after-free in amba_read_periphid()

Ivan Vecera (2):
      i40e: Fix kernel crash during module removal
      iavf: Detach device during reset task

Jack Wang (2):
      RDMA/rtrs-clt: Use the right sg_cnt after ib_dma_map_sg
      RDMA/rtrs-srv: Pass the correct number of entries for dma mapped SGL

Jason Gunthorpe (1):
      iommu: Fix false ownership failure on AMD systems with PASID activate=
d

Jassi Brar (1):
      arm64: dts: juno: Add missing MHU secure-irq

Jean-Philippe Brucker (2):
      regulator: Fix qcom,spmi-regulator schema
      iommu/virtio: Fix interaction with VFIO

Jens Axboe (1):
      block: add missing request flags to debugfs code

Jens Wiklander (1):
      tee: fix compiler warning in tee_shm_register()

Jiapeng Chong (1):
      io_uring/notif: Remove the unused function io_notif_complete()

Jiaxin Yu (1):
      ASoC: mediatek: mt8186: fix DMIC record noise

Jiri Olsa (1):
      perf script: Skip dummy event attr check

Jiri Slaby (1):
      perf tools: Don't install data files with x permissions

Joe Fradley (1):
      tools: Add new "test" taint to kernel-chktaint

Joey Gouly (1):
      arm64: mm: fix resume for 52-bit enabled builds

Johannes Berg (3):
      wifi: mac80211: mlme: release deflink channel in error case
      wifi: mac80211: fix locking in auth/assoc timeout
      wifi: use struct_group to copy addresses

Johannes Thumshirn (1):
      btrfs: zoned: fix mounting with conventional zones

John Sperbeck (1):
      iommu/amd: use full 64-bit value in build_completion_wait()

Julia Lawall (1):
      ARM: ixp4xx: fix typos in comments

Keith Busch (1):
      nvme: requeue aen after firmware activation

Kuldeep Singh (3):
      ARM: dts: integratorap: Update spi node properties
      ARM: dts: realview: Update spi clock-names property
      ARM: dts: versatile: Update spi clock-names property

Lad Prabhakar (1):
      dt-bindings: i2c: renesas,riic: Fix 'unevaluatedProperties' warnings

Liang He (1):
      soc: brcmstb: pm-arm: Fix refcount leak and __iomem leak bugs

Linus Torvalds (2):
      fs: only do a memory barrier for the first set_buffer_uptodate()
      Linux 6.0-rc5

Linus Walleij (1):
      RDMA/siw: Pass a pointer to virt_to_page()

Lorenzo Bianconi (2):
      net: ethernet: mtk_eth_soc: fix typo in __mtk_foe_entry_clear
      net: ethernet: mtk_eth_soc: check max allowed hash in mtk_ppe_check_s=
kb

Lu Baolu (5):
      iommu/vt-d: Fix kdump kernels boot failure with scalable mode
      iommu/vt-d: Correctly calculate sagaw value of IOMMU
      iommu/vt-d: Fix recursive lock issue in iommu_flush_dev_iotlb()
      iommu/vt-d: Fix lockdep splat due to klist iteration in atomic contex=
t
      iommu/vt-d: Fix possible recursive locking in intel_iommu_init()

Luca Ceresoli (3):
      docs: i2c: i2c-topology: fix typo
      docs: i2c: i2c-topology: fix incorrect heading
      docs: i2c: i2c-topology: reorder sections more logically

Luiz Augusto von Dentz (1):
      Bluetooth: hci_sync: Fix hci_read_buffer_size_sync

Lukas Bulwahn (2):
      scripts: remove obsolete gcc-ld script
      MAINTAINERS: add scripts/tracing/ to TRACING

Maher Sanalla (1):
      RDMA/mlx5: Rely on RoCE fw cap instead of devlink when setting profil=
e

Maor Gottlieb (1):
      RDMA/mlx5: Fix UMR cleanup on error flow of driver init

Marcel Ziswiler (2):
      arm64: dts: freescale: verdin-imx8mm: fix atmel_mxt_ts reset polarity
      arm64: dts: freescale: verdin-imx8mp: fix atmel_mxt_ts reset polarity

Marco Felsch (3):
      Revert "soc: imx: imx8m-blk-ctrl: set power device name"
      ARM: dts: imx6qdl-kontron-samx6i: remove duplicated node
      ARM: dts: imx6qdl-kontron-samx6i: fix spi-flash compatible

Marek Vasut (3):
      arm64: dts: imx8mp: Adjust ECSPI1 pinmux on i.MX8M Plus DHCOM
      soc: imx: gpcv2: Assert reset before ungating clock
      arm64: dts: imx8mp: Fix I2C5 GPIO assignment on i.MX8M Plus DHCOM

Mark Brown (3):
      spi: mux: Fix mux interaction with fast path optimisations
      arm64/bti: Disable in kernel BTI when cross section thunks are broken
      arm64/ptrace: Don't clear calling process' TIF_SME on OOM

Masahiro Yamada (1):
      kbuild: disable header exports for UML in a straightforward way

Masami Hiramatsu (Google) (1):
      tracing: Fix to check event_mutex is held while accessing trigger lis=
t

Mathew McBride (1):
      soc: fsl: select FSL_GUTS driver for DPIO

Matthew Auld (1):
      drm/i915: consider HAS_FLAT_CCS() in needs_ccs_pages

Menglong Dong (1):
      net: skb: export skb drop reaons to user by TRACE_DEFINE_ENUM

Michael Ellerman (1):
      powerpc/pseries: Fix plpks crash on non-pseries

Michael Guralnik (1):
      RDMA/cma: Fix arguments order in net device validation

Michal Swiatkowski (1):
      ice: use bitmap_free instead of devm_kfree

Ming Lei (1):
      block: don't add partitions if GD_SUPPRESS_PART_SCAN is set

Mohan Kumar (1):
      ALSA: hda/tegra: Align BDL entry to 4KB boundary

Mukesh Sisodiya (1):
      wifi: mac80211: fix link warning in RX agg timer expiry

Naohiro Aota (1):
      btrfs: zoned: fix API misuse of zone finish waiting

Nathan Chancellor (1):
      ASoC: mchp-spdiftx: Fix clang -Wbitfield-constant-conversion

Neal Cardwell (1):
      tcp: fix early ETIMEDOUT after spurious non-SACK RTO

Nico Pache (1):
      kunit: fix Kconfig for build-in tests USB4 and Nitro Enclaves

Niravkumar L Rabara (1):
      spi: cadence-quadspi: Disable irqs during indirect reads

Oleksij Rempel (1):
      net: dsa: microchip: fix kernel oops on ksz8 switches

Pablo Neira Ayuso (2):
      netfilter: remove nf_conntrack_helper sysctl and modparam toggles
      netfilter: nf_tables: clean up hook list when offload flags check fai=
ls

Pattara Teerapong (1):
      ALSA: aloop: Fix random zeros in capture data when using jiffies time=
r

Paul Durrant (1):
      xen-netback: only remove 'hotplug-status' when the vif is
actually destroyed

Pavel Begunkov (4):
      io_uring/kbuf: fix not advancing READV kbuf ring
      io_uring: recycle kbuf recycle on tw requeue
      io_uring/net: copy addr for zc on POLL_FIRST
      io_uring/rw: fix short rw error handling

Peng Fan (1):
      arm64: dts: imx8mp-venice-gw74xx: fix sai2 pin settings

Peter Ujfalusi (2):
      ASoC: SOF: Kconfig: Make IPC_FLOOD_TEST depend on SND_SOC_SOF
      ASoC: SOF: Kconfig: Make IPC_MESSAGE_INJECTOR depend on SND_SOC_SOF

Philippe Schenker (1):
      arm64: dts: verdin-imx8mm: add otg2 pd to usbphy

Pieterjan Camerlynck (1):
      ASoC: fsl_sai: fix incorrect mclk number in error message

Przemyslaw Patynowski (2):
      ice: Fix DMA mappings leak
      i40e: Fix ADQ rate limiting for PF

Qu Wenruo (1):
      btrfs: fix the max chunk size and stripe length calculation

Richard Fitzgerald (1):
      ASoC: cs42l42: Only report button state if there was a button interru=
pt

Rob Herring (1):
      arm64: dts: arm: juno: Remove legacy Coresight 'slave-mode' property

Robin Murphy (2):
      spi: bitbang: Fix lsb-first Rx
      dma-debug: improve search for partial syncs

Rodrigo Vivi (1):
      drm/i915/slpc: Let's fix the PCODE min freq table setup for SLPC

Sagi Grimberg (2):
      nvme-tcp: fix UAF when detecting digest errors
      nvme-tcp: fix regression that causes sporadic requests to time out

Sander Vanheule (1):
      kunit: fix assert_type for comparison macros

Sebastian Andrzej Siewior (1):
      asm-generic: Conditionally enable do_softirq_own_stack() via Kconfig.

Sergey Matyukevich (1):
      perf: RISC-V: fix access beyond allocated array

Shang XiaoJing (1):
      perf c2c: Prevent potential memory leak in c2c_he_zalloc()

Shengjiu Wang (3):
      ASoC: fsl_mqs: Fix supported clock DAI format
      ASoC: fsl_aud2htx: register platform component before registering cpu=
 dai
      ASoC: fsl_aud2htx: Add error handler for pm_runtime_enable

Shin'ichiro Kawasaki (1):
      btrfs: zoned: set pseudo max append zone limit in zone emulation mode

Shiraz Saleem (1):
      RDMA/irdma: Fix drain SQ hang with no completion

Sindhu-Devale (5):
      RDMA/irdma: Report the correct max cqes from query device
      RDMA/irdma: Return error on MR deregister CQP failure
      RDMA/irdma: Return correct WC error for bind operation failure
      RDMA/irdma: Use s/g array in post send only when its valid
      RDMA/irdma: Report RNR NAK generation in device caps

Soenke Huster (1):
      wifi: mac80211_hwsim: check length for virtio packets

Sreekanth Reddy (1):
      scsi: mpt3sas: Fix use-after-free warning

Srinivas Kandagatla (1):
      ASoC: qcom: sm8250: add missing module owner

Stanislaw Gruszka (1):
      wifi: iwlegacy: 4965: corrected fix for potential off-by-one
overflow in il4965_rs_fill_link_cmd()

Sun Ke (1):
      erofs: fix error return code in erofs_fscache_{meta_,}read_folio

Takashi Iwai (13):
      ASoC: nau8821: Implement hw constraint for rates
      ASoC: nau8824: Fix semaphore unbalance at error paths
      ASoC: nau8824: Implement hw constraint for rates
      ASoC: nau8825: Implement hw constraint for rates
      ASoC: nau8540: Implement hw constraint for rates
      ALSA: usb-audio: Inform the delayed registration more properly
      ALSA: usb-audio: Register card again for iface over
delayed_register option
      ALSA: usb-audio: Split endpoint setups for hw_params and prepare
      ALSA: hda/sigmatel: Keep power up while beep is enabled
      ALSA: pcm: oss: Fix race at SNDCTL_DSP_SYNC
      ALSA: hda/sigmatel: Fix unused variable warning for beep power change
      ALSA: hda: Once again fix regression of page allocations with IOMMU
      ALSA: usb-audio: Clear fixed clock rate at closing EP

Tasos Sahanidis (1):
      ALSA: emu10k1: Fix out of bounds access in snd_emu10k1_pcm_channel_al=
loc()

Thitat Auareesuksakul (1):
      scripts/extract-ikconfig: add zstd compression support

Tim Harvey (1):
      arm64: dts: imx8mm-venice-gw7901: fix port/phy validation

Toke H=C3=B8iland-J=C3=B8rgensen (2):
      sch_sfb: Don't assume the skb is still around after enqueueing to chi=
ld
      sch_sfb: Also store skb len before calling child enqueue

Ville Syrj=C3=A4l=C3=A4 (3):
      drm/edid: Handle EDID 1.4 range descriptor h/vfreq offsets
      drm/i915/bios: Copy the whole MIPI sequence block
      drm/i915: Implement WaEdpLinkRateDataReload

Vladimir Oltean (4):
      arm64: dts: ls1028a-qds-65bb: don't use in-band autoneg for 2500base-=
x
      net: dsa: felix: tc-taprio intervals smaller than MTU should
send at least one packet
      net: dsa: felix: disable cut-through forwarding for frames
oversized for tc-taprio
      net: dsa: felix: access QSYS_TAG_CONFIG under tas_lock in
vsc9959_sched_speed_set

Wei Fang (1):
      net: fec: add pm_qos support on imx6q platform

Wenpeng Liang (2):
      RDMA/hns: Fix wrong fixed value of qp->rq.wqe_shift
      MAINTAINERS: Update maintainers of HiSilicon RoCE

William Zhang (9):
      ARM: dts: bcmbca: bcm63178: fix timer node cpu mask flag
      ARM: dts: bcmbca: bcm63178: clean up psci node
      ARM: dts: bcmbca: bcm63178: fix interrupt controller node
      ARM: dts: bcmbca: bcm63178: cosmetic change
      ARM: dts: bcmbca: bcm6846: fix timer node cpu mask flag
      ARM: dts: bcmbca: bcm6846: clean up psci node
      ARM: dts: bcmbca: bcm6846: fix interrupt controller node
      ARM: dts: bcmbca: bcm6878: fix timer node cpu mask flag
      ARM: dts: bcmbca: bcm6878: cosmetic change

Xiaolei Wang (1):
      regulator: pfuze100: Fix the global-out-of-bounds access in
pfuze100_regulator_probe()

Xiu Jianfeng (1):
      rv/reactor: add __init/__exit annotations to module init/exit funcs

Yacan Liu (1):
      net/smc: Fix possible access to freed memory in link clear

Yang Jihong (1):
      perf lock: Remove redundant word 'contention' in help message

Yang Ling (1):
      MIPS: loongson32: ls1c: Fix hang during startup

Yang Yingliang (2):
      ASoC: SOF: ipc4-topology: fix wrong use of sizeof in
sof_ipc4_widget_setup_comp_src()
      scsi: lpfc: Add missing destroy_workqueue() in error path

Yicong Yang (2):
      arch_topology: Make cluster topology span at least SMT CPUs
      arch_topology: Make cluster topology span at least SMT CPUs

Yifan Zhang (2):
      drm/amdkfd: print address in hex format rather than decimal
      drm/amdgpu: correct doorbell range/size value for CSDMA_DOORBELL_RANG=
E

Yipeng Zou (1):
      tracing: hold caller_addr to hardirq_{enable,disable}_ip

Yishai Hadas (1):
      IB/core: Fix a nested dead lock as part of ODP flow

Yixing Liu (1):
      RDMA/hns: Remove the num_qpc_timer variable

Youling Tang (1):
      mksysmap: Fix the mismatch of 'L0' symbols in System.map

Yu Zhao (1):
      Revert "swiotlb: panic if nslabs is too small"

Yue Hu (1):
      erofs: avoid the potentially wrong m_plen for big pcluster

ZhenGuo Yin (1):
      drm/ttm: update bulk move object of ghost BO

Zhengjun Xing (2):
      perf stat: Fix L2 Topdown metrics disappear for raw events
      perf script: Fix Cannot print 'iregs' field for hybrid systems

Zixuan Tan (1):
      perf genelf: Switch deprecated openssl MD5_* functions to new EVP API

chen zhang (1):
      efi/x86: libstub: remove unused variable

jerry.meng (1):
      net: usb: qmi_wwan: add Quectel RM520N

yangx.jy@fujitsu.com (1):
      RDMA/srp: Set scmnd->result only when scmnd is not NULL
