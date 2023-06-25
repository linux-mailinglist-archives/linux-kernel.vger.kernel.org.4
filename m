Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A657A73D550
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 01:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjFYXlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 19:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFYXlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 19:41:09 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD22E43
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 16:41:07 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51d9865b7bdso369069a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 16:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687736466; x=1690328466;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B1Z4MLgboiG/of20MP0gMf0iG4HDE96sneM+dPOyrdg=;
        b=B2OCdebHK25158MBRBeJwthjl/wgGQNpZyu33eBV5zPJuc3P4Z09SQU3246gPNlUZk
         eYpG7u3kzfxKNaqD3PYxYJfx3RKI4LTrma2PmK8GjCl1DYnqLDh0qqO8cg2xDO4wJVLJ
         ZlqDT5FVp6vOepgoD/KEtl+GP43FVJcZkpPFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687736466; x=1690328466;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B1Z4MLgboiG/of20MP0gMf0iG4HDE96sneM+dPOyrdg=;
        b=ap5ObzzyddorHl4yEnVOMl/RxF6qTvnj9cs8DKDx5LzvcyVvoxv5RsXs78fsRdSF/3
         LTyy+y+RWZpidRJAwwtgDX64RCMfZzW9kvsT8R9QtNO4X5vz2Kim/s6JXJbyFaR0/lIR
         e+CVzohcmgNlNfKmp0havc933pLqTG9u1hhmzetk7KirW6+u9aM4/LbsReRrdBaoSnq+
         gqKUmoV3IhgM5vmkGkfC2mX3JazDOtP5OqbI3SycVPL1AKnGnSmCEk+WRwUS7sYNsey9
         2lkrdmmcWQXEW5mO3VqPJoZEggytzpsTPRx2lTeVou7JQTVoEYiyJZOLer1xTFvBg/0P
         QWAA==
X-Gm-Message-State: AC+VfDzuj03jouliBW4wpsQGqcvbdbhnESjyQIcv3g3Nib6lSTeLSfV7
        fDr6RgmnWdp7p6klo8iwPgKTdi5FwPwVdYFQq1fNKaU8
X-Google-Smtp-Source: ACHHUZ4Wu8p4sNd2YCLlusmH2lcwzjKHn7hor/BjBoQNAM4vXf/A7laaDptprFQmVDNQaKM2HMUcOA==
X-Received: by 2002:a17:907:746:b0:962:46d7:c8fc with SMTP id xc6-20020a170907074600b0096246d7c8fcmr25081322ejb.21.1687736465777;
        Sun, 25 Jun 2023 16:41:05 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id kg1-20020a17090776e100b0098e2eaec395sm1501300ejc.130.2023.06.25.16.41.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 16:41:05 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-51d9128494cso711857a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 16:41:05 -0700 (PDT)
X-Received: by 2002:a05:6402:4c9:b0:51a:327d:f065 with SMTP id
 n9-20020a05640204c900b0051a327df065mr18852149edw.13.1687736464697; Sun, 25
 Jun 2023 16:41:04 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Jun 2023 16:40:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7fwNWfqj-QQqEfZTUOB4bbKT8QiEUDHoPk0ecuYA7cA@mail.gmail.com>
Message-ID: <CAHk-=wi7fwNWfqj-QQqEfZTUOB4bbKT8QiEUDHoPk0ecuYA7cA@mail.gmail.com>
Subject: Linux 6.4
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

Hmm. Final week of 6.4 is done, and we've mainly got some netfilter
fixes, some mm reverts, and a few tracing updates.

There's random small changes elsewhere: the usual architecture noise,
a number of selftest updates, some filesystem fixes (btrfs, ksmb),
etc.

Most of the stuff in my mailbox the last week has been about upcoming
things for 6.5, and I already have 15 pull requests pending. I
appreciate all you proactive people.

But that's for tomorrow. Today we're all busy build-testing the newest
kernel release, and checking that it's all good. Right?

                 Linus

---

Andrew Lunn (1):
      net: phy: Manual remove LEDs to ensure correct ordering

Andrew Powers-Holmes (1):
      arm64: dts: rockchip: Fix rk356x PCIe register and range mappings

Ar=C4=B1n=C3=A7 =C3=9CNAL (5):
      net: dsa: mt7530: set all CPU ports in MT7531_CPU_PMAP
      net: dsa: mt7530: fix trapping frames on non-MT7621 SoC MT7530 switch
      net: dsa: mt7530: fix handling of BPDUs on MT7530 switch
      net: dsa: mt7530: fix handling of LLDP frames
      MAINTAINERS: add me as maintainer of MEDIATEK SWITCH DRIVER

Azeem Shaikh (1):
      ieee802154: Replace strlcpy with strscpy

Beau Belgrave (7):
      tracing/user_events: Remove user_ns walk for groups
      tracing/user_events: Store register flags on events
      tracing/user_events: Track refcount consistently via put/get
      tracing/user_events: Add auto cleanup and future persist flag
      selftests/user_events: Ensure auto cleanup works as expected
      selftests/user_events: Adapt dyn_test to non-persist events
      tracing/user_events: Document auto-cleanup and remove dyn_event refs

Ben Dooks (1):
      mailmap: add entries for Ben Dooks

Benedict Wong (2):
      xfrm: Treat already-verified secpath entries as optional
      xfrm: Ensure policies always checked on XFRM-I input path

Benjamin Berg (1):
      wifi: mac80211: report all unusable beacon frames

Charles Keepax (1):
      ASoC: intel: sof_sdw: Fixup typo in device link checking

Chen Aotian (1):
      ieee802154: hwsim: Fix possible memory leaks

Chris Mi (2):
      net/mlx5e: TC, Add null pointer check for hardware miss support
      net/mlx5e: TC, Cleanup ct resources for nic flow

Christophe Kerello (1):
      mmc: mmci: stm32: fix max busy timeout calculation

Clark Wang (1):
      i2c: imx-lpi2c: fix type char overflow issue when calculating
the clock cycle

Danielle Ratson (1):
      selftests: forwarding: Fix race condition in mirror installation

David Stevens (1):
      mm/khugepaged: fix iteration in collapse_file

Dexuan Cui (6):
      Drivers: hv: vmbus: Call hv_synic_free() if hv_synic_alloc() fails
      PCI: hv: Fix a race condition bug in hv_pci_query_relations()
      PCI: hv: Fix a race condition in hv_irq_unmask() that can cause panic
      PCI: hv: Remove the useless hv_pcichild_state from struct hv_pci_dev
      Revert "PCI: hv: Fix a timing issue which causes kdump to fail
occasionally"
      PCI: hv: Add a per-bus mutex state_lock

Dheeraj Kumar Srivastava (1):
      x86/apic: Fix kernel panic when booting with intremap=3Doff and x2api=
c_phys

Douglas Anderson (4):
      dt-bindings: firmware: qcom,scm: Document that SCM can be dma-coheren=
t
      arm64: dts: qcom: sc7180: Mark SCM as dma-coherent for IDP
      arm64: dts: qcom: sc7180: Mark SCM as dma-coherent for trogdor
      arm64: dts: qcom: sc7280: Mark SCM as dma-coherent for chrome devices

Eli Cohen (1):
      net/mlx5: Fix driver load with single msix vector

Eric Dumazet (1):
      sch_netem: acquire qdisc lock in netem_change()

Florent Revest (1):
      bpf/btf: Accept function names that contain dots

Florian Fainelli (1):
      scripts/gdb: fix SB_* constants parsing

Francesco Dolcini (1):
      Revert "net: phy: dp83867: perform soft reset and retain established =
link"

Gavin Shan (1):
      KVM: Avoid illegal stage2 mapping on invalid memory slot

Hans de Goede (1):
      thermal/intel/intel_soc_dts_iosf: Fix reporting wrong temperatures

Herbert Xu (1):
      xfrm: Use xfrm_state selector for BEET input

Jeff Layton (1):
      drm: use mgr->dev in drm_dbg_kms in drm_dp_add_payload_part2

Jens Axboe (4):
      io_uring/poll: serialize poll linked timer start with poll removal
      io_uring/net: clear msg_controllen on partial sendmsg retry
      io_uring/net: disable partial retries for recvmsg with cmsg
      io_uring/net: use the correct msghdr union member in io_sendmsg_copy_=
hdr

Jiasheng Jiang (1):
      gpio: sifive: add missing check for platform_get_irq

Jiawen Wu (2):
      gpiolib: Fix GPIO chip IRQ initialization restriction
      net: mdio: fix the wrong parameters

Jiri Olsa (1):
      bpf: Force kprobe multi expected_attach_type for kprobe_multi link

Jisheng Zhang (1):
      mmc: litex_mmc: set PROBE_PREFER_ASYNCHRONOUS

Josua Mayer (1):
      net: dpaa2-mac: add 25gbase-r support

Juerg Haefliger (2):
      ieee802154/adf7242: Add MODULE_FIRMWARE macro
      nfc: fdp: Add MODULE_FIRMWARE macros

Kan Liang (1):
      perf/x86/intel: Fix the FRONTEND encoding on GNR and MTL

Kees Cook (1):
      net: wwan: iosm: Convert single instance struct member to flexible ar=
ray

Krister Johansen (2):
      bpf: ensure main program has an extable
      selftests/bpf: add a test for subprogram extables

Krzysztof Kozlowski (1):
      arm64: dts: rockchip: add missing cache properties

Lee Jones (1):
      x86/mm: Avoid using set_pgd() outside of real PGD pages

Leon Romanovsky (4):
      xfrm: add missed call to delete offloaded policies
      net/mlx5e: Don't delay release of hardware objects
      net/mlx5e: Drop XFRM state lock when modifying flow steering
      net/mlx5e: Fix scheduling of IPsec ASO query while in atomic

Liam R. Howlett (1):
      mm/mprotect: fix do_mprotect_pkey() limit check

Linus Torvalds (3):
      Revert "efi: random: refresh non-volatile random seed when RNG
is initialized"
      workqueue: clean up WORK_* constant types, clarify masking
      Linux 6.4

Lorenz Brun (1):
      arm64: dts: rockchip: fix USB regulator on ROCK64

Lorenzo Stoakes (1):
      mm/vmalloc: do not output a spurious warning when huge vmalloc() fail=
s

Luke D. Jones (2):
      ALSA: hda/realtek: Add quirk for ASUS ROG G634Z
      ALSA: hda/realtek: Add quirk for ASUS ROG GV601V

Maciej =C5=BBenczykowski (2):
      xfrm: fix inbound ipv4/udp/esp packets to UDPv6 dualstack sockets
      revert "net: align SO_RCVMARK required privileges with SO_MARK"

Magali Lemes (4):
      selftests/harness: allow tests to be skipped during setup
      selftests: net: tls: check if FIPS mode is enabled
      selftests: net: vrf-xfrm-tests: change authentication and encryption =
algos
      selftests: net: fcnal-test: check if FIPS mode is enabled

Marc Zyngier (2):
      KVM: arm64: Restore GICv2-on-GICv3 functionality
      perf/core: Drop __weak attribute from
arch_perf_update_userpage() prototype

Mark Brown (1):
      selftests/mm: fix cross compilation with LLVM

Martin Hundeb=C3=B8ll (1):
      mmc: meson-gx: remove redundant mmc_request_done() call from irq cont=
ext

Maxim Mikityanskiy (4):
      bpf: Fix verifier id tracking of scalars on spill
      selftests/bpf: Add test cases to assert proper ID tracking on spill
      net/mlx5e: XDP, Allow growing tail for XDP multi buffer
      net/mlx5e: xsk: Set napi_id to support busy polling on XSK RQ

Michael Kelley (3):
      Drivers: hv: vmbus: Fix vmbus_wait_for_unload() to scan present CPUs
      x86/hyperv: Fix hyperv_pcpu_input_arg handling when CPUs go online/of=
fline
      arm64/hyperv: Use CPUHP_AP_HYPERV_ONLINE state to fix CPU online
sequencing

Michael S. Tsirkin (1):
      Revert "virtio-blk: support completion batching for the IRQ path"

Michael Walle (1):
      gpiolib: Fix irq_domain resource tracking for
gpiochip_irqchip_add_domain()

Mike Kravetz (1):
      udmabuf: revert 'Add support for mapping hugepages (v4)'

Ming Lei (1):
      block: make sure local irq is disabled when calling __blkcg_rstat_flu=
sh

Miquel Raynal (2):
      MAINTAINERS: Update wpan tree
      MAINTAINERS: Add wpan patchwork

Mukesh Sisodiya (1):
      wifi: iwlwifi: pcie: Handle SO-F device for PCI id 0x7AF0

Namjae Jeon (4):
      ksmbd: validate command payload size
      ksmbd: add mnt_want_write to ksmbd vfs functions
      ksmbd: fix out-of-bound read in smb2_write
      ksmbd: validate session id and tree id in the compound request

Neil Armstrong (1):
      spi: spi-geni-qcom: correctly handle -EPROBE_DEFER from dma_request_c=
han()

Nicholas Piggin (1):
      powerpc/64s/radix: Fix exit lazy tlb mm switch with irqs enabled

Nicolas Frattaroli (1):
      arm64: dts: rockchip: fix nEXTRST on SOQuartz

Oliver Upton (1):
      KVM: arm64: Use raw_smp_processor_id() in kvm_pmu_probe_armpmu()

Omar Sandoval (1):
      x86/unwind/orc: Add ELF section with ORC version identifier

Pablo Neira Ayuso (12):
      netfilter: nf_tables: fix chain binding transaction logic
      netfilter: nf_tables: add NFT_TRANS_PREPARE_ERROR to deal with
bound set/chain
      netfilter: nf_tables: drop map element references from preparation ph=
ase
      netfilter: nft_set_pipapo: .walk does not deal with generations
      netfilter: nf_tables: fix underflow in object reference counter
      netfilter: nf_tables: disallow element updates of bound anonymous set=
s
      netfilter: nf_tables: reject unbound anonymous set before commit phas=
e
      netfilter: nf_tables: reject unbound chain set before commit phase
      netfilter: nf_tables: disallow updates of anonymous sets
      netfilter: nf_tables: disallow timeout for anonymous sets
      netfilter: nf_tables: drop module reference after updating chain
      netfilter: nfnetlink_osf: fix module autoload

Paolo Abeni (6):
      mptcp: handle correctly disconnect() failures
      mptcp: fix possible divide by zero in recvmsg()
      mptcp: fix possible list corruption on passive MPJ
      mptcp: consolidate fallback and non fallback state machine
      mptcp: drop legacy code around RX EOF
      mptcp: ensure listener is unhashed before updating the sk status

Patrisious Haddad (1):
      net/mlx5e: Fix ESN update kernel panic

Phil Sutter (1):
      netfilter: nf_tables: Fix for deleting base chains with payload

Pranjal Ramajor Asha Kanojiya (1):
      accel/qaic: Call DRM helper function to destroy prime GEM

Prathu Baronia (1):
      scripts: fix the gfp flags header path in gfp-translate

Qi Zheng (7):
      Revert "mm: shrinkers: convert shrinker_rwsem to mutex"
      Revert "mm: vmscan: remove shrinker_rwsem from synchronize_shrinkers(=
)"
      Revert "mm: vmscan: hold write lock to reparent shrinker nr_deferred"
      Revert "mm: shrinkers: make count and scan in shrinker debugfs lockle=
ss"
      Revert "mm: vmscan: add shrinker_srcu_generation"
      Revert "mm: vmscan: make memcg slab shrink lockless"
      Revert "mm: vmscan: make global slab shrink lockless"

Qu Wenruo (2):
      btrfs: fix u32 overflows when left shifting stripe_nr
      btrfs: fix remaining u32 overflows when left shifting stripe_nr

Rafael Aquini (1):
      writeback: fix dereferencing NULL mapping->host on writeback_page_tem=
plate

Rafael J. Wysocki (1):
      ACPI: sleep: Avoid breaking S3 wakeup due to might_sleep()

Reiji Watanabe (2):
      KVM: arm64: PMU: Restore the host's PMUSERENR_EL0
      KVM: arm64: PMU: Don't overwrite PMUSERENR with vcpu loaded

Rob Herring (1):
      dt-bindings: i2c: opencores: Add missing type for "regstep"

Roberto Sassu (1):
      memfd: check for non-NULL file_seals in memfd_create() syscall

Ross Lagerwall (1):
      be2net: Extend xmit workaround to BE3 chip

Russ Weight (1):
      regmap: spi-avmm: Fix regmap_bus max_raw_write

Ryusuke Konishi (2):
      nilfs2: fix buffer corruption due to concurrent device reads
      nilfs2: prevent general protection fault in nilfs_clear_dirty_page()

Saeed Mahameed (1):
      net/mlx5: Free IRQ rmap and notifier on kernel shutdown

Saurabh Sengar (1):
      x86/hyperv/vtl: Add noop for realmode pointers

Sebastian Andrzej Siewior (1):
      xfrm: Linearize the skb after offloading if needed.

Sergey Shtylyov (12):
      mmc: bcm2835: fix deferred probing
      mmc: meson-gx: fix deferred probing
      mmc: mtk-sd: fix deferred probing
      mmc: mvsdio: fix deferred probing
      mmc: omap: fix deferred probing
      mmc: omap_hsmmc: fix deferred probing
      mmc: owl: fix deferred probing
      mmc: sdhci-acpi: fix deferred probing
      mmc: sdhci-spear: fix deferred probing
      mmc: sh_mmcif: fix deferred probing
      mmc: sunxi: fix deferred probing
      mmc: usdhi60rol0: fix deferred probing

Shuai Jiang (1):
      i2c: qup: Add missing unwind goto in qup_i2c_probe()

Shyam Sundar S K (1):
      platform/x86/amd/pmf: Register notify handler only if SPS is enabled

Stefan Wahren (1):
      net: qca_spi: Avoid high load if QCA7000 is not available

Stephan Gerhold (1):
      mmc: sdhci-msm: Disable broken 64-bit DMA on MSM8916

Steven Rostedt (Google) (1):
      tracing/rv/rtla: Update MAINTAINERS file to point to proper mailing l=
ist

Su Hui (1):
      iommu/amd: Fix possible memory leak of 'domain'

Teresa Remmet (1):
      regulator: pca9450: Fix LDO3OUT and LDO4OUT MASK

Terin Stock (1):
      ipvs: align inner_mac_header for encapsulation

Tetsuo Handa (1):
      cgroup,freezer: hold cpu_hotplug_lock before freezer_mutex in
freezer_css_{online,offline}()

Thomas Gleixner (1):
      tick/common: Align tick period during sched_timer setup

Tianling Shen (1):
      arm64: dts: rockchip: fix button reset pin for nanopi r5c

Vishal Moola (Oracle) (2):
      afs: Fix dangling folio ref counts in writeback
      afs: Fix waiting for writeback then skipping folio

Vladimir Oltean (1):
      net: dsa: introduce preferred_default_local_cpu_port and use on MT753=
0

Xiu Jianfeng (1):
      cgroup: Do not corrupt task iteration when rebinding subsystem

Yevgeny Kliteynik (2):
      net/mlx5: DR, Support SW created encap actions for FW table
      net/mlx5: DR, Fix wrong action data allocation in decap action

Yonghong Song (1):
      bpf: Fix a bpf_jit_dump issue for x86_64 with sysctl bpf_jit_enable.

Zhu YiXin (1):
      MAINTAINERS: Add Chuanhua Lei as Intel LGM GW PCIe maintainer

sunliming (7):
      tracing/user_events: Prevent same name but different args event
      tracing/user_events: Handle matching arguments that is null from
dyn_events
      tracing: Modify print_fields() for fields output order
      tracing/user_events: Fix the incorrect trace record for empty
arguments events
      selftests/user_events: Add ftrace self-test for empty arguments event=
s
      selftests/user_events: Clear the events after perf self-test
      selftests/user_events: Add perf self-test for empty arguments events

=C3=8D=C3=B1igo Huguet (1):
      sfc: use budget for TX completions
