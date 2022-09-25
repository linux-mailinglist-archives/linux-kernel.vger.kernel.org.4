Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920275E9620
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 23:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiIYVPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 17:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiIYVPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 17:15:01 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BCF14D0F
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 14:14:59 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-13122bfaea6so1970562fac.11
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 14:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date;
        bh=mB9JNGUy+36AvV3vRjPC9IwsW6A6u295kVpEd9yXFPk=;
        b=NWmT2OX3E+EnGnNHtH1A2hBlb7aI8ao1sU6C+jSz9LLtI3LkcwDMRdDWHDZmluzjbt
         uvWvhvHcAeZkVmio/K+/sQRBhfcJgjXBeYi4Oo6fsYplUjcPXpGq61ZUHp400KubIsig
         GdPcjpNguwSocHmDPuW32uExnRSQSJIFr5f2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mB9JNGUy+36AvV3vRjPC9IwsW6A6u295kVpEd9yXFPk=;
        b=afuM8rJ7xcBSp9fVxb11CtUkzJCM3v0H1IGbG8S+j6YYnssw6m5nF6AiGo9+JhT6JP
         IY227EUs/l+oX/3cAPuA9dh4UO09KIZd7G/XVIkf4wBiyjrioW6p6BtXQwY3cbv+gUmW
         v6X5BlFODqakEr2AUywNq01bSdbpJSszVXhRhrNg5FXlvVx3Oujfs+pzM8kztGVHZ642
         evG9fHH1kA5EXNEFFXpOoRfGTm9egIxVg3oYl9nCXXoX+AK4v95+EFEDbFoxngYHJPgc
         rhaBG+ZaM8h60+3xFmELeoYLgPLSwMwpQerLmEQf3DNVm0E7+6DYfgVzQHHlFyHMvHI/
         tdNw==
X-Gm-Message-State: ACrzQf1ukBmQRkk/dVvxrjswQVdFCQb65UuSkBQPK0RzkaHLV23XZKMk
        IhsLwkJc0hZJE9oWw5DE75RuAx00gGu8ag==
X-Google-Smtp-Source: AMsMyM7JEbgGHKkgZVw5/dNHOWpqvb8s+Dh6XJ3cHFmv+Kn/O7p+Hw3vhKRvSoVYijme2KzI3UpczA==
X-Received: by 2002:a05:6870:3485:b0:12b:df60:622d with SMTP id n5-20020a056870348500b0012bdf60622dmr10760638oah.25.1664140497762;
        Sun, 25 Sep 2022 14:14:57 -0700 (PDT)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com. [209.85.160.50])
        by smtp.gmail.com with ESMTPSA id h2-20020a9d6a42000000b00637032a39a3sm6979925otn.6.2022.09.25.14.14.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 14:14:56 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-12b542cb1d3so6977410fac.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 14:14:56 -0700 (PDT)
X-Received: by 2002:a05:6870:c888:b0:12c:7f3b:d67d with SMTP id
 er8-20020a056870c88800b0012c7f3bd67dmr11135469oab.229.1664140496207; Sun, 25
 Sep 2022 14:14:56 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Sep 2022 14:14:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjc_CDPy5WbN=e_FtPrd0Yn2Wp4JcdRByeyDoM9azK1mA@mail.gmail.com>
Message-ID: <CAHk-=wjc_CDPy5WbN=e_FtPrd0Yn2Wp4JcdRByeyDoM9azK1mA@mail.gmail.com>
Subject: Linux 6.0-rc7
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

So I was thinking rc7 might end up larger than usual due to travel
hitting rc6, but it doesn't really seem to have happened.

Yeah, maybe it's marginally bigger than the historical average for
this time of the release cycle, but it definitely isn't some outlier,
and it looks fairly normal. Which is all good, and makes me think that
the final release will happen right on schedule next weekend, unless
something unexpected happens. Knock wood.

Incidentally, rc7 is also (I think) the first time we have a clean
'make allmodconfig' build with no warnings from clang, since the
patches for frame size problems in the amd display code got merged.
The stack frame size is still pretty big (and the code isn't exactly
pretty), but now it's below the level we warn about.

So that's nice to see.

Anyway, full shortlog below - a lot of it is GPU and network drivers,
but there's various random other fixes in there too.

Let's give this one (hopefully) final week of testing, but it all
looks pretty good.

                  Linus

---

Adrian Hunter (3):
      perf record: Fix cpu mask bit setting for mixed mmaps
      libperf evlist: Fix polling of system-wide events
      perf kcore_copy: Do not check /proc/modules is unchanged

Al Viro (1):
      riscv: fix a nasty sigreturn bug...

Alan Stern (1):
      USB: core: Fix RST error in hub.c

Alex Deucher (1):
      drm/amdgpu: don't register a dirty callback for non-atomic

Alex Elder (1):
      net: ipa: properly limit modem routing table use

Alexander Stein (2):
      arm64: dts: tqma8mpxl-ba8mpxl: Fix button GPIOs
      arm64: dts: imx8mp-tqma8mpql-mba8mpxl: add missing pinctrl for RTC al=
arm

Allen-KH Cheng (1):
      drm/mediatek: Fix wrong dither settings

Alvin Lee (1):
      drm/amd/display: Only consider pixle rate div policy for DCN32+

Andrei Vagin (2):
      Revert "selftests/timens: add a test for vfork+exit"
      Revert "fs/exec: allow to unshare a time namespace on vfork+exec"

Andy Shevchenko (2):
      nvdimm/namespace: drop nested variable in create_namespace_pmem()
      gpio: mockup: Fix potential resource leakage when register a chip

AngeloGioacchino Del Regno (1):
      drm/mediatek: dsi: Add atomic {destroy,duplicate}_state, reset callba=
cks

Ard Biesheuvel (2):
      efi: x86: Wipe setup_data on pure EFI boot
      efi: libstub: check Shim mode using MokSBStateRT

Arnaldo Carvalho de Melo (1):
      tools headers cpufeatures: Sync with the kernel sources

Asmaa Mnebhi (3):
      i2c: mlxbf: incorrect base address passed during io write
      i2c: mlxbf: prevent stack overflow in mlxbf_i2c_smbus_start_transacti=
on()
      i2c: mlxbf: Fix frequency calculation

Bartosz Golaszewski (1):
      gpio: mockup: fix NULL pointer dereference when removing debugfs

Benjamin Poirier (4):
      net: bonding: Share lacpdu_mcast_addr definition
      net: bonding: Unsync device addresses on ndo_stop
      net: team: Unsync device addresses on ndo_stop
      net: Add tests for bonding and team address list management

Bhupesh Sharma (1):
      MAINTAINERS: Add myself as a reviewer for Qualcomm ETHQOS Ethernet dr=
iver

Brett Creeley (1):
      iavf: Fix cached head and tail value for iavf_get_tx_pending

Brian Norris (1):
      arm64: dts: rockchip: Pull up wlan wake# on Gru-Bob

Callum Osmotherly (2):
      ALSA: hda/realtek: Enable 4-speaker output Dell Precision 5570 laptop
      ALSA: hda/realtek: Enable 4-speaker output Dell Precision 5530 laptop

Carl Yin(=E6=AE=B7=E5=BC=A0=E6=88=90) (1):
      USB: serial: option: add Quectel BG95 0x0203 composition

Chao Yu (1):
      mm/slub: fix to return errno if kmalloc() fails

Charlene Liu (1):
      drm/amd/display: correct num_dsc based on HW cap

Chris Park (1):
      drm/amd/display: Port DCN30 420 logic to DCN32

Chris Wilson (1):
      drm/i915/gem: Really move i915_gem_context.link under ref protection

Christian Lamparter (1):
      um: fix default console kernel parameter

Christoph Hellwig (1):
      Revert "block: freeze the queue earlier in del_gendisk"

Christophe JAILLET (1):
      OPP: Fix an un-initialized variable usage

Cong Wang (1):
      tcp: read multiple skbs in tcp_read_skb()

Cristian Marussi (7):
      firmware: arm_scmi: Fix missing kernel-doc in optee
      firmware: arm_scmi: Improve checks in the info_get operations
      firmware: arm_scmi: Harden accesses to the sensor domains
      firmware: arm_scmi: Harden accesses to the reset domains
      firmware: arm_scmi: Fix the asynchronous reset requests
      firmware: arm_scmi: Add SCMI PM driver remove routine
      firmware: arm_scmi: Harmonize SCMI tracing message format

Cruise Hung (1):
      drm/amd/display: Fix DP MST timeslot issue when fallback happened

Dan Carpenter (1):
      i2c: mux: harden i2c_mux_alloc() against integer overflows

Dan Williams (1):
      devdax: Fix soft-reservation memory description

Daniel Houldsworth (1):
      ALSA: hda/realtek: Add a quirk for HP OMEN 16 (8902) mute LED

Daniel Miess (1):
      drm/amd/display: Add shift and mask for ICH_RESET_AT_END_OF_LINE

Dave Airlie (1):
      MAINTAINERS: switch graphics to airlied other addresses

Dave Ertman (1):
      ice: Don't double unplug aux on peer initiated reset

David Gow (1):
      arch: um: Mark the stack non-executable to fix a binutils warning

David Leadbeater (1):
      netfilter: nf_conntrack_irc: Tighten matching on DCC message

David Thompson (1):
      mlxbf_gige: clear MDIO gateway lock after read

Ding Hui (1):
      ice: Fix crash by keep old cfg when update TCs more than queues

Dmytro Laktyushkin (2):
      drm/amd/display: fix dcn315 memory channel count and width read
      drm/amd/display: increase dcn315 pstate change latency

Dongliang Mu (1):
      gpio: tqmx86: fix uninitialized variable girq

Dr. David Alan Gilbert (1):
      KVM: x86: Always enable legacy FP/SSE in allowed user XFEATURES

Evan Quan (2):
      drm/amd/pm: add support for 3794 pptable for SMU13.0.0
      drm/amd/pm: drop the pptable related workarounds for SMU 13.0.0

Fabio Estevam (3):
      arm64: dts: rockchip: Remove 'enable-active-low' from rk3399-puma
      arm64: dts: rockchip: Remove 'enable-active-low' from rk3566-quartz64=
-a
      arm64: dts: tqma8mqml: Include phy-imx8-pcie.h header

Felix Fietkau (2):
      wifi: mt76: fix reading current per-tid starting sequence number
for aggregation
      wifi: mt76: fix 5 GHz connection regression on mt76x0/mt76x2

Feng Tang (1):
      mm/slab_common: fix possible double free of kmem_cache

Filipe Manana (2):
      btrfs: fix hang during unmount when stopping block group reclaim work=
er
      btrfs: fix hang during unmount when stopping a space reclaim worker

Florian Westphal (3):
      selftests: nft_concat_range: add socat support
      netfilter: ebtables: fix memory leak when blob is malformed
      netfilter: nf_ct_ftp: fix deadlock when nat rewrite is needed

Francesco Dolcini (2):
      Revert "fec: Restart PPS after link state change"
      Revert "net: fec: Use a spinlock to guard `fep->ptp_clk_on`"

Frank Wunderlich (1):
      arm64: dts: rockchip: fix upper usb port on BPI-R2-Pro

Geert Uytterhoeven (2):
      net: ravb: Fix PHY state warning splat during system resume
      net: sh_eth: Fix PHY state warning splat during system resume

George Shen (1):
      drm/amd/display: Update dummy P-state search to use DCN32 DML

Gil Fine (1):
      thunderbolt: Add support for Intel Maple Ridge single port controller

Greg Kroah-Hartman (1):
      Revert "driver core: Set fw_devlink.strict=3D1 by default"

Guilherme G. Piccoli (1):
      efi: efibc: Guard against allocation failure

Haimin Zhang (1):
      net/ieee802154: fix uninit value bug in dgram_sendmsg

Haiyang Zhang (1):
      net: mana: Add rmb after checking owner bits

Hangbin Liu (1):
      selftests: forwarding: add shebang for sch_red.sh

Hangyu Hua (1):
      net: sched: fix possible refcount leak in tc_new_tfilter()

Heiko Schocher (1):
      drm/panel: simple: Fix innolux_g121i1_l01 bus_format

Heiko Stuebner (1):
      riscv: make t-head erratas depend on MMU

Horatiu Vultur (1):
      ARM: dts: lan966x: Fix the interrupt number for internal PHYs

Hugo Hu (1):
      drm/amd/display: update gamut remap if plane has changed

Ido Schimmel (4):
      netdevsim: Fix hwstats debugfs file permissions
      ipmr: Always call ip{,6}_mr_forward() from RCU read-side critical sec=
tion
      selftests: forwarding: Add test cases for unresolved multicast routes
      ipv6: Fix crash when IPv6 is administratively disabled

Igor Ryzhov (1):
      netfilter: nf_conntrack_sip: fix ct_sip_walk_headers

Ilkka Koskinen (1):
      perf/arm-cmn: Add more bits to child node address offset field

Ilpo J=C3=A4rvinen (3):
      serial: Create uart_xmit_advance()
      serial: tegra: Use uart_xmit_advance(), fixes icount.tx accounting
      serial: tegra-tcu: Use uart_xmit_advance(), fixes icount.tx accountin=
g

Ioana Ciornei (1):
      net: phy: aquantia: wait for the suspend/resume operations to finish

Jagan Teki (1):
      arm64: dts: rockchip: Fix typo in lisense text for PX30.Core

Jakub Kicinski (1):
      bnxt: prevent skb UAF after handing over to PTP worker

Jan Kara (5):
      ext4: make mballoc try target group first even with mb_optimize_scan
      ext4: avoid unnecessary spreading of allocations among groups
      ext4: make directory inode spreading reflect flexbg size
      ext4: use locality group preallocation for small closed files
      ext4: use buckets for cr 1 block scan instead of rbtree

Jane Chu (1):
      pmem: fix a name collision

Janis Schoetterl-Glausch (1):
      KVM: s390: Pass initialized arg even if unused

Janusz Krzysztofik (1):
      drm/i915/gem: Flush contexts on driver release

Jaroslav Kysela (1):
      ALSA: hda/hdmi: Fix the converter reuse for the silent stream

Jason A. Donenfeld (4):
      wifi: iwlwifi: don't spam logs with NSS>2 messages
      wireguard: ratelimiter: disable timings test by default
      wireguard: selftests: do not install headers on UML
      wireguard: netlink: avoid variable-sized memcpy on sockaddr

Jens Axboe (1):
      io_uring: ensure that cached task references are always put on exit

Jeroen de Borst (1):
      MAINTAINERS: gve: update developers

Jianglei Nie (1):
      net: atlantic: fix potential memory leak in aq_ndev_close()

Jinrong Liang (1):
      selftests: kvm: Fix a compile error in selftests/kvm/rseq_test.c

Johan Hovold (1):
      media: flexcop-usb: fix endpoint type check

Jonathan Toppins (2):
      bonding: fix NULL deref in bond_rr_gen_slave_id
      selftests: bonding: cause oops in bond_rr_gen_slave_id

Juergen Gross (1):
      xen/xenbus: fix xenbus_setup_ring()

Kai Vehmanen (1):
      ALSA: hda: add Intel 5 Series / 3400 PCI DID

Krzysztof Kozlowski (1):
      dt-bindings: memory-controllers: fsl,imx8m-ddrc: drop Leonard Crestez

Larysa Zaremba (1):
      ice: Fix ice_xdp_xmit() when XDP TX queue number is not sufficient

Leo Li (1):
      drm/amd/display: Fix double cursor on non-video RGB MPO

Letu Ren (1):
      scsi: qedf: Fix a UAF bug in __qedf_probe()

Li Jinlin (1):
      fsdax: Fix infinite loop in dax_iomap_rw()

Liang He (3):
      dmaengine: ti: k3-udma-private: Fix refcount leak bug in
of_xudma_dev_get()
      of: mdio: Add of_node_put() when breaking out of for_each_xx
      net: marvell: Fix refcounting bugs in prestera_port_sfp_bind()

Lieven Hey (1):
      perf jit: Include program header in ELF files

Linus Torvalds (1):
      Linux 6.0-rc7

Linus Walleij (1):
      gpio: ftgpio010: Make irqchip immutable

Lorenzo Bianconi (1):
      net: ethernet: mtk_eth_soc: enable XDP support just for MT7986 SoC

Lu Baolu (1):
      Revert "iommu/vt-d: Fix possible recursive locking in intel_iommu_ini=
t()"

Lu Wei (1):
      ipvlan: Fix out-of-bound bugs caused by unset skb->mac_header

Ludovic Cintrat (1):
      net: core: fix flow symmetric hash

Luiz Augusto von Dentz (1):
      Bluetooth: Fix HCIGETDEVINFO regression

Lukas Straub (2):
      um: Cleanup syscall_handler_t cast in syscalls_32.h
      um: Cleanup compiler warning in arch/x86/um/tls_32.c

Lukas Wunner (1):
      serial: fsl_lpuart: Reset prior to registration

Luke D. Jones (3):
      ALSA: hda/realtek: Add pincfg for ASUS G513 HP jack
      ALSA: hda/realtek: Add pincfg for ASUS G533Z HP jack
      ALSA: hda/realtek: Add quirk for ASUS GA503R laptop

Lu=C3=ADs Henriques (1):
      ext4: fix bug in extents parsing when eh_entries =3D=3D 0 and eh_dept=
h > 0

Marc Kleine-Budde (3):
      can: flexcan: flexcan_mailbox_read() fix return value for drop =3D tr=
ue
      can: gs_usb: gs_can_open(): fix race dev->can.state condition
      can: gs_usb: gs_usb_set_phys_id(): return with error if identify
is not supported

Marco Felsch (1):
      arm64: dts: imx8mn: remove GPU power domain reset

Marek Vasut (1):
      arm64: dts: imx8mm: Reverse CPLD_Dn GPIO label mapping on MX8Menlo

Mark Rutland (1):
      arm64: mm: don't acquire mutex when rewriting swapper

Masahiro Yamada (1):
      certs: make system keyring depend on built-in x509 parser

Mateusz Palczewski (1):
      ice: Fix interface being down after reset with link-down-on-close fla=
g on

Matthew Rosato (3):
      KVM: s390: pci: fix plain integer as NULL pointer warnings
      KVM: s390: pci: fix GAIT physical vs virtual pointers usage
      KVM: s390: pci: register pci hooks without interpretation

Matthias Schiffer (1):
      serial: 8250: omap: Use serial8250_em485_supported

Matthieu Baerts (1):
      Documentation: mptcp: fix pm_type formatting

Maurizio Lombardi (1):
      mm: slub: fix flush_cpu_slab()/__free_slab() invocations in task cont=
ext.

Meenakshikumar Somasundaram (1):
      drm/amd/display: Display distortion after hotplug 5K tiled display

Meng Li (1):
      gpiolib: cdev: Set lineevent_state::irq after IRQ register successful=
ly

Miaohe Lin (1):
      KVM: x86/mmu: add missing update to max_mmu_rmap_size

Michael Riesch (2):
      arm64: dts: rockchip: fix property for usb2 phy supply on rock-3a
      arm64: dts: rockchip: fix property for usb2 phy supply on rk3568-evb1=
-v10

Michael Strauss (1):
      drm/amd/display: Assume an LTTPR is always present on fixed_vs links

Michael Walle (2):
      arm64: defconfig: enable ARCH_NXP
      net: phy: micrel: fix shared interrupt on LAN8814

Michal Jaron (3):
      iavf: Fix set max MTU size with port VLAN and jumbo frames
      i40e: Fix VF set max MTU size
      i40e: Fix set max_tx_rate when it is lower than 1 Mbps

Michal Swiatkowski (1):
      ice: config netdev tc before setting queues number

Micka=C3=ABl Sala=C3=BCn (1):
      selftests/landlock: Fix out-of-tree builds

Ming Lei (1):
      cgroup: cgroup_get_from_id() must check the looked-up kn is a directo=
ry

Mohan Kumar (2):
      ALSA: hda/tegra: set depop delay for tegra
      ALSA: hda: Fix Nvidia dp infoframe

Mukul Joshi (1):
      drm/amdgpu: Update PTE flags with TF enabled

Namhyung Kim (6):
      perf stat: Fix BPF program section name
      perf stat: Fix cpu map index in bperf cgroup code
      perf stat: Use evsel->core.cpus to iterate cpus in BPF cgroup counter=
s
      perf test: Add a new test for perf stat cgroup BPF counter
      perf test: Skip wp modify test on old kernels
      perf tools: Honor namespace when synthesizing build-ids

Naohiro Aota (1):
      btrfs: zoned: wait for extent buffer IOs before finishing a zone

Nathan Chancellor (2):
      drm/amd/display: Reduce number of arguments of dml314's
CalculateWatermarksAndDRAMSpeedChangeSupport()
      drm/amd/display: Reduce number of arguments of dml314's
CalculateFlipSchedule()

Nicholas Kazlauskas (1):
      drm/amd/display: Disable OTG WA for the plane_state NULL case on DCN3=
14

Nick Desaulniers (2):
      Makefile.debug: set -g unconditional on CONFIG_DEBUG_INFO_SPLIT
      Makefile.debug: re-enable debug info for .S files

Nicolas Frattaroli (1):
      arm64: dts: rockchip: Lower sd speed on quartz64-b

Norbert Zulinski (1):
      iavf: Fix bad page state

N=C3=ADcolas F. R. A. Prado (1):
      drm/mediatek: dsi: Move mtk_dsi_stop() call back to mtk_dsi_poweroff(=
)

Oleksandr Mazur (1):
      net: marvell: prestera: add support for for Aldrin2

Olof Johansson (1):
      serial: sifive: enable clocks for UART when probed

Pablo Neira Ayuso (2):
      netfilter: nfnetlink_osf: fix possible bogus match in nf_osf_find()
      netfilter: conntrack: remove nf_conntrack_helper documentation

Pali Roh=C3=A1r (1):
      phy: marvell: phy-mvebu-a3700-comphy: Remove broken reset support

Palmer Dabbelt (2):
      RISC-V: Clean up the Zicbom block size probing
      RISC-V: Avoid coupling the T-Head CMOs and Zicbom

Paolo Abeni (1):
      mptcp: fix fwd memory accounting on coalesce

Peilin Ye (2):
      tcp: Use WARN_ON_ONCE() in tcp_read_skb()
      udp: Use WARN_ON_ONCE() in udp_read_skb()

Peng Fan (1):
      arm64: dts: imx8ulp: add #reset-cells for pcc

Peter Collingbourne (1):
      kasan: call kasan_malloc() from __kmalloc_*track_caller()

Phil Auld (1):
      drivers/base: Fix unsigned comparison to -1 in CPUMAP_FILE_MAX_BYTES

Philippe Schenker (1):
      arm64: dts: imx8mm-verdin: extend pmic voltages

Rafael Mendonca (1):
      scsi: qla2xxx: Fix memory leak in __qlt_24xx_handle_abts()

Rakesh Sankaranarayanan (1):
      net: dsa: microchip: lan937x: fix maximum frame length check

Randy Dunlap (3):
      riscv: fix RISCV_ISA_SVPBMT kconfig dependency warning
      MIPS: lantiq: export clk_get_io() for lantiq_wdt.ko
      drm/hisilicon: Add depends on MMU

Ren Zhijie (1):
      usb: typec: anx7411: Fix build error without CONFIG_POWER_SUPPLY

Rob Herring (1):
      dt-bindings: opp: Add missing (unevaluated|additional)Properties
on child nodes

Russ Weight (1):
      fpga: m10bmc-sec: Fix possible memory leak of flash_buf

Sean Anderson (1):
      net: sunhme: Fix packet reception for len < RX_COPY_THRESHOLD

Sean Christopherson (2):
      KVM: x86: Reinstate kvm_vcpu_arch.guest_supported_xcr0
      KVM: x86: Inject #UD on emulated XSETBV if XSAVES isn't enabled

Serge Semin (1):
      MIPS: Loongson32: Fix PHY-mode being left unspecified

Sergei Antonov (1):
      ARM: dts: fix Moxa SDIO 'compatible', remove 'sdhci' misnomer

Sergey Shtylyov (1):
      arm64: topology: fix possible overflow in amu_fie_setup()

Shailend Chand (1):
      gve: Fix GFP flags when allocing pages

Shigeru Yoshida (1):
      batman-adv: Fix hang up with small MTU hard-interface

Shivaprasad G Bhat (1):
      ndtest: Cleanup all of blk namespace specific code

Shravya Kumbham (1):
      dmaengine: zynqmp_dma: Typecast with enum to fix the coverity warning

Sreekanth Reddy (1):
      scsi: mpt3sas: Fix return value check of dma_get_required_mask()

Stefan Haberland (1):
      s390/dasd: fix Oops in dasd_alias_get_start_dev due to missing pavgro=
up

Swati Agarwal (3):
      dmaengine: xilinx_dma: Fix devm_platform_ioremap_resource error handl=
ing
      dmaengine: xilinx_dma: cleanup for fetching xlnx,num-fstores property
      dmaengine: xilinx_dma: Report error in case of
dma_set_mask_and_coherent API failure

Sylwester Dziedziuch (1):
      iavf: Fix change VF's mac address

Takashi Iwai (4):
      ALSA: hda: Fix hang at HD-audio codec unbinding due to refcount satur=
ation
      ALSA: hda/realtek: Re-arrange quirk table entries
      ALSA: core: Fix double-free at snd_card_new()
      Revert "ALSA: usb-audio: Split endpoint setups for hw_params and prep=
are"

Tejun Heo (1):
      cpuset: Add Waiman Long as a cpuset maintainer

Tetsuo Handa (5):
      workqueue: don't skip lockdep work dependency in cancel_work_sync()
      open: always initialize ownership fields
      net: clear msg_get_inq in __get_compat_msghdr()
      netfilter: nf_tables: fix nft_counters_enabled underflow at
nf_tables_addchain()
      netfilter: nf_tables: fix percpu memory leak at nf_tables_addchain()

Theodore Ts'o (1):
      ext4: limit the number of retries after discarding preallocations blo=
cks

Thomas Zimmermann (1):
      drm/mgag200: Force 32 bpp on the console

Tim Harvey (3):
      arm64: dts: imx8mp-venice-gw74xx: fix CAN STBY polarity
      arm64: dts: imx8mp-venice-gw74xx: fix ksz9477 cpu port
      arm64: dts: imx8mp-venice-gw74xx: fix port/phy validation

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      wifi: iwlwifi: Mark IWLMEI as broken

Tony Krowiak (1):
      s390/vfio-ap: bypass unnecessary processing of AP resources

Uwe Kleine-K=C3=B6nig (1):
      i2c: imx: If pm_runtime_get_sync() returned 1 device access is possib=
le

Vadim Fedorenko (1):
      bnxt_en: fix flags to check for supported fw version

Vincent Whitchurch (1):
      um: Prevent KASAN splats in dump_stack()

Vladimir Oltean (4):
      net: enetc: move enetc_set_psfp() out of the common enetc_set_feature=
s()
      net: enetc: deny offload of tc-based TSN features on VF interfaces
      net/sched: taprio: avoid disabling offload when it was never enabled
      net/sched: taprio: make qdisc_leaf() see the per-netdev-queue
pfifo child qdiscs

Wen Gu (1):
      net/smc: Stop the CLC flow if no link to map buffers on

Will Deacon (1):
      vmlinux.lds.h: CFI: Reduce alignment of jump-table to function alignm=
ent

William Breathitt Gray (1):
      counter: 104-quad-8: Fix skipped IRQ lines during events configuratio=
n

William Wu (1):
      usb: dwc3: core: leave default DMA if the controller does not
support 64-bit DMA

Wolfram Sang (2):
      MAINTAINERS: remove Nehal Shah from AMD MP2 I2C DRIVER
      Documentation: i2c: fix references to other documents

Yi Liu (1):
      iommu/vt-d: Check correct capability for sagaw determination

Yifan Zhang (1):
      drm/amdgpu/mes: zero the sdma_hqd_mask of 2nd SDMA engine for SDMA 6.=
0.1

Yuezhang Mo (1):
      exfat: fix overflow for large capacity partition

Zeng Heng (1):
      Kconfig: remove unused function 'menu_get_root_menu'

Zenghui Yu (1):
      KVM: arm64: Use kmemleak_free_part_phys() to unregister hyp_mem_base

huangwenhui (1):
      ALSA: hda/realtek: Add quirk for Huawei WRT-WX9

jerry meng (1):
      USB: serial: option: add Quectel RM520N

yangxingwu (1):
      scripts/clang-tools: remove unused module

zain wang (1):
      arm64: dts: rockchip: Set RK3399-Gru PCLK_EDP to 24 MHz

zhikzhai (1):
      drm/amd/display: skip audio setup when audio stream is enabled

=C3=8D=C3=B1igo Huguet (4):
      sfc: fix TX channel offset when using legacy interrupts
      sfc: fix null pointer dereference in efx_hard_start_xmit
      sfc/siena: fix TX channel offset when using legacy interrupts
      sfc/siena: fix null pointer dereference in efx_hard_start_xmit
