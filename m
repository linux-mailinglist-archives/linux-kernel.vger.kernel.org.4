Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33E56272B9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 22:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbiKMV3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 16:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbiKMV3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 16:29:42 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBEC13F34
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 13:29:40 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id k2so6401254qkk.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 13:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ohIeod1DGMKzS8TWU4ZpliY5u6fEpljk7E17B8kbGtg=;
        b=S/3Rar+McKYQxqmk8lAnvV/49QF9H8n/mtlp9w91Un7Ld05fInvplviVbFa4wzWV8X
         yXOa443ZGQJ5MzQ5o129M67Gb8GuBTPsV4/fBO9UXQF90lmqRlOS+F0qylJmzOpUkK1Q
         WpVJe8hMp6hHhmL3tLr6j2JGcj296zsbPZF24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ohIeod1DGMKzS8TWU4ZpliY5u6fEpljk7E17B8kbGtg=;
        b=iprBjGkoZJ4I0vswX43ELY0Lk07wVcPNff7fale3zLgO96pBUX8EPpQSVguwLCWrGG
         OMEfoZ6o6uayyvjKj2doOoXG6MRBnz6rXBQvor2/3f7Qj/G7SegVuUW4QG4Q0I5gBrvN
         Z/9nIfko9Mz8dIIUbXz2MUDy+kd8bj2bgcNm9zQZY/QX83gw+obDgzR2kHpm1QK873PR
         6sC5sL9BB5TNJz6sn+RftYJML19ZnBb/uo2GPjLAC8cq1IAwEsooj2ovxDoysRpiWRk0
         3AFSnav2ZmeIrv1d/Q9O72uURfXJQk9iCqF0j7NYwsaV1yPtSEoqYml4cSxJDSME8VO4
         yR0A==
X-Gm-Message-State: ANoB5pmmcDzHVDd9bMjvilLODknFQUc2JWLcEJFfoCOQArSn8oCli+wi
        +AL+6vCkpQKbTlyblxi8bfbOtGn4pSXyPg==
X-Google-Smtp-Source: AA0mqf5pnsHPzcgwRHhkcocnCC8mJVehxupJnyXFq4YsOznN7P5Pho/ZjAOnfoOgrXeXjqPgEKSzLQ==
X-Received: by 2002:a37:b007:0:b0:6f8:cdc2:b7a2 with SMTP id z7-20020a37b007000000b006f8cdc2b7a2mr8827477qke.132.1668374978301;
        Sun, 13 Nov 2022 13:29:38 -0800 (PST)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com. [209.85.219.53])
        by smtp.gmail.com with ESMTPSA id f16-20020a05620a409000b006bb78d095c5sm5423497qko.79.2022.11.13.13.29.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 13:29:37 -0800 (PST)
Received: by mail-qv1-f53.google.com with SMTP id x15so6833525qvp.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 13:29:37 -0800 (PST)
X-Received: by 2002:a05:6214:3105:b0:4c6:3c9a:e514 with SMTP id
 ks5-20020a056214310500b004c63c9ae514mr2130499qvb.130.1668374976446; Sun, 13
 Nov 2022 13:29:36 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 13 Nov 2022 13:29:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wicGu7PD25w7BCdvxRcs6Yvo-BPwCkzSYjM2CYtDjz2kg@mail.gmail.com>
Message-ID: <CAHk-=wicGu7PD25w7BCdvxRcs6Yvo-BPwCkzSYjM2CYtDjz2kg@mail.gmail.com>
Subject: Linux 6.1-rc5
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

Another week, another rc.

Did things calm down and shrink this week? No. We've got about as many
commits in rc5 as we had in rc4. It's not outrageously big, but it's
certainly on the bigger side for this timeframe.

Am I getting worried? Not yet. There's nothing particularly worrisome
in here, and the rc5 changes are just a little bit of everything, so
I'm hoping it's just that it's one of those timing things and all the
pull requests came in this week, and it's going to calm down now.

But we'll see. If things don't start calming down, this may be one of
those releases that need an extra week. It wasn't a particularly big
merge window, but I don't particularly like how the rc's keep being on
the bigger side.

Anyway, lots of small fixes, fairly spread out (the diffstat looks
fairly flat apart from some maple tree tests moving to the testing
subdirectory). Nothing really stands out, the stats all look normal
apart from the "just slightly more than usual". Drivers, networking,
architecture fixes, with some smattering of noise elsewhere.

                      Linus

---

Adrien Thierry (1):
      selftests/net: give more time to udpgro bg processes to complete star=
tup

Ai Chao (1):
      ALSA: usb-audio: add quirk to fix Hamedal C20 disconnect issue

Aleksandr Miloserdov (1):
      nvmet: fix memory leak in nvmet_subsys_attr_model_store_locked

Alex Barba (1):
      bnxt_en: fix potentially incorrect return value for ndo_rx_flow_steer

Alexander Potapenko (7):
      ipv6: addrlabel: fix infoleak when sending struct ifaddrlblmsg to net=
work
      kmsan: core: kmsan_in_runtime() should return true in NMI context
      x86/uaccess: instrument copy_from_user_nmi()
      Kconfig.debug: ensure early check for KMSAN in CONFIG_KMSAN_WARN
      kmsan: make sure PREEMPT_RT is off
      x86/traps: avoid KMSAN bugs originating from handle_bug()
      docs: kmsan: fix formatting of "Example report"

Amelie Delaunay (2):
      dmaengine: stm32-mdma: memset stm32_mdma_chan_config struct
before using it
      dmaengine: stm32-dma: fix potential race between pause and resume

Andrii Nakryiko (2):
      net/ipv4: Fix linux/in.h header dependencies
      tools/headers: Pull in stddef.h to uapi to fix BPF selftests build in=
 CI

Andy Shevchenko (1):
      platform/x86: p2sb: Don't fail if unknown CPU is found

Anirudh Rayabharam (2):
      clocksource/drivers/hyperv: add data structure for reference TSC MSR
      x86/hyperv: fix invalid writes to MSRs during root partition kexec

Antoine Tenart (2):
      net: phy: mscc: macsec: clear encryption keys when freeing a flow
      net: atlantic: macsec: clear encryption keys from the stack

Ard Biesheuvel (3):
      arm64: fix rodata=3Dfull again
      arm64: efi: Force the use of SetVirtualAddressMap() on Altra machines
      arm64: efi: Fix handling of misaligned runtime regions and drop warni=
ng

Arend van Spriel (1):
      wifi: cfg80211: fix memory leak in query_regdb_file()

Asher Song (1):
      Revert "drm/amdgpu: Revert "drm/amdgpu: getting fan speed pwm
for vega10 properly""

Athira Rajeev (1):
      perf stat: Fix printing os->prefix in CSV metrics output

Aurabindo Pillai (1):
      drm/amd/display: Zeromem mypipe heap struct before using it

Bart Van Assche (1):
      scsi: scsi_debug: Make the READ CAPACITY response compliant with ZBC

Brian King (1):
      scsi: ibmvfc: Avoid path failures during live migration

Brian Norris (6):
      mmc: cqhci: Provide helper for resetting both SDHCI and CQHCI
      mmc: sdhci-of-arasan: Fix SDHCI_RESET_ALL for CQHCI
      mmc: sdhci-brcmstb: Fix SDHCI_RESET_ALL for CQHCI
      mms: sdhci-esdhc-imx: Fix SDHCI_RESET_ALL for CQHCI
      mmc: sdhci-tegra: Fix SDHCI_RESET_ALL for CQHCI
      mmc: sdhci_am654: Fix SDHCI_RESET_ALL for CQHCI

Chaitanya Dhere (1):
      drm/amd/display: Fix FCLK deviation and tool compile issues

Chen Zhongjin (1):
      can: af_can: can_exit(): add missing dev_remove_pack() of canxl_packe=
t

Chris Mi (1):
      net/mlx5: E-switch, Set to legacy mode if failed to change switchdev =
mode

Christian K=C3=B6nig (1):
      drm/amdgpu: workaround for TLB seq race

Christophe JAILLET (1):
      dmaengine: mv_xor_v2: Fix a resource leak in mv_xor_v2_remove()

Chuang Wang (1):
      net: macvlan: fix memory leaks of macvlan_common_newlink

Colin Ian King (1):
      HID: asus: Remove unused variable in asus_report_tool_width()

Cong Wang (1):
      bpf, sock_map: Move cancel_work_sync() out of sock lock

Conor Dooley (1):
      riscv: fix reserved memory setup

D Scott Phillips (1):
      arm64: Fix bit-shifting UB in the MIDR_CPU_MODEL() macro

Dan Carpenter (1):
      phy: stm32: fix an error code in probe

David E. Box (1):
      platform/x86/intel/pmt: Sapphire Rapids PMT errata fix

David Sterba (1):
      btrfs: don't print stack trace when transaction is aborted due to ENO=
MEM

Dexuan Cui (1):
      PCI: hv: Fix the definition of vector in hv_compose_msi_msg()

Dillon Varone (1):
      drm/amd/display: Enforce minimum prefetch time for low memclk on DCN3=
2

Dokyung Song (1):
      wifi: brcmfmac: Fix potential buffer overflow in brcmf_fweh_event_wor=
ker()

Donglin Peng (1):
      perf tools: Add the include/perf/ directory to .gitignore

Doug Brown (1):
      dmaengine: pxa_dma: use platform_get_irq_optional

Dylan Yudaken (1):
      io_uring: calculate CQEs from the user visible value

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Add Positivo C6300 model quirk

Emil Renner Berthing (1):
      riscv: dts: sifive unleashed: Add PWM controlled LEDs

Eric Dumazet (1):
      net: tun: call napi_schedule_prep() to ensure we own a napi

Evan Quan (1):
      ALSA: hda/hdmi - enable runtime pm for more AMD display audio

Felix Kuehling (2):
      drm/amdkfd: Fix error handling in kfd_criu_restore_events
      drm/amdkfd: Fix error handling in criu_checkpoint

Fenghua Yu (1):
      dmaengine: idxd: Do not enable user type Work Queue without
Shared Virtual Addressing

Fengqian Gao (1):
      dmaengine: idxd: fix RO device state error after been disabled/reset

Florian Fainelli (1):
      MAINTAINERS: Move Vivien to CREDITS

Gaosheng Cui (2):
      audit: fix undefined behavior in bit shift for AUDIT_BIT
      capabilities: fix undefined behavior in bit shift for CAP_TO_MASK

Geert Uytterhoeven (1):
      can: rcar_canfd: Add missing ECC error checks for channels 2-7

Guangbin Huang (1):
      net: hns3: fix get wrong value of function hclge_get_dscp_prio()

Guchun Chen (1):
      drm/amdgpu: disable BACO on special BEIGE_GOBY card

HW He (2):
      net: wwan: iosm: fix memory leak in ipc_wwan_dellink
      net: wwan: mhi: fix memory leak in mhi_mbim_dellink

Haibo Chen (1):
      mmc: sdhci-esdhc-imx: use the correct host caps for MMC_CAP_8_BIT_DAT=
A

Hamza Mahfooz (1):
      drm/amd/display: only fill dirty rectangles when PSR is enabled

Hans de Goede (6):
      ACPI: video: Improve Chromebook checks
      ACPI: video: Make acpi_video_backlight_use_native() always return tru=
e
      ACPI: video: Add backlight=3Dnative DMI quirk for Dell G15 5515
      platform/x86: touchscreen_dmi: Add info for the RCA Cambio W101 v2 2-=
in-1
      drm: panel-orientation-quirks: Add quirk for Nanote UMPC-01
      drm: panel-orientation-quirks: Add quirk for Acer Switch V 10 (SW5-01=
7)

Harald Freudenberger (1):
      s390/zcrypt: fix warning about field-spanning write

Heiko Carstens (5):
      s390: update defconfigs
      s390/configs: move CONFIG_DEBUG_INFO_BTF into btf.config addon config
      s390/configs: add kasan.config addon config file
      s390: always build relocatable kernel
      scripts/min-tool-version.sh: raise minimum clang version to
15.0.0 for s390

Howard Hsu (1):
      wifi: mac80211: Set TWT Information Frame Disabled bit as 1

Ivan Hu (1):
      platform/x86/intel/hid: Add some ACPI device IDs

James Clark (1):
      perf test: Fix skipping branch stack sampling test

James Houghton (1):
      hugetlbfs: don't delete error page from pagecache

Jason A. Donenfeld (3):
      wifi: rt2x00: use explicitly signed or unsigned types
      wifi: airo: do not assign -1 to unsigned char
      MIPS: pic32: treat port as signed integer

Jason Gerecke (1):
      HID: wacom: Fix logic used for 3rd barrel switch emulation

Jay Fang (1):
      MAINTAINERS: Update HiSilicon SFC Driver maintainer

Jeff Layton (2):
      nfsd: fix use-after-free in nfsd_file_do_acquire tracepoint
      nfsd: put the export reference in nfsd4_verify_deleg_dentry

Jens Axboe (2):
      io_uring: fix typo in io_uring.h comment
      io_uring: check for rollover of buffer ID when providing buffers

Jianbo Liu (1):
      net/mlx5e: TC, Fix wrong rejection of packet-per-second policing

Jiaxun Yang (1):
      MIPS: jump_label: Fix compat branch range check

Jilin Yuan (1):
      Drivers: hv: fix repeated words in comments

Jiri Benc (1):
      net: gso: fix panic on frag_list with mixed head alloc types

Jisheng Zhang (2):
      riscv: process: fix kernel info leakage
      riscv: vdso: fix build with llvm

Johan Hovold (1):
      phy: qcom-qmp-combo: fix NULL-deref on runtime resume

Johannes Berg (1):
      wifi: cfg80211: silence a sparse RCU warning

Johannes Thumshirn (3):
      btrfs: zoned: clone zoned device info when cloning a device
      btrfs: zoned: initialize device's zone info for seeding
      btrfs: zoned: fix locking imbalance on scrub

Johannes Weiner (1):
      fs: fix leaked psi pressure state

John Thomson (2):
      phy: ralink: mt7621-pci: add sentinel to quirks table
      mips: boot/compressed: use __NO_FORTIFY

Jon Hunter (2):
      phy: tegra: xusb: Fix crash during pad power on/down
      spi: tegra210-quad: Don't initialise DMA if not supported

Jonas Jelonek (1):
      wifi: mac80211_hwsim: fix debugfs attribute ps with rc table support

Jorge Lopez (1):
      platform/x86: hp_wmi: Fix rfkill causing soft blocked wifi

Jouni H=C3=B6gander (1):
      drm/i915/psr: Send update also on invalidate

Jussi Laako (1):
      ALSA: usb-audio: Add DSD support for Accuphase DAC-60

Kees Cook (2):
      bpf, verifier: Fix memory leak in array reallocation for stack state
      mm/slab_common: Restore passing "caller" for tracing

Keith Busch (1):
      nvme: quiet user passthrough command errors

Kishon Vijay Abraham I (1):
      MAINTAINERS: Update Kishon's email address in GENERIC PHY FRAMEWORK

Krzysztof Kozlowski (5):
      dt-bindings: hwlock: qcom-hwspinlock: add support for MMIO on older S=
oCs
      dt-bindings: hwlock: qcom-hwspinlock: correct example indentation
      hwspinlock: qcom: correct MMIO max register for newer SoCs
      hwspinlock: qcom: add support for MMIO on older SoCs
      dt-bindings: hwlock: qcom-hwspinlock: add syscon to MSM8974

Kuniyuki Iwashima (1):
      arm64/syscall: Include asm/ptrace.h in syscall_wrapper header.

Laurent Pinchart (1):
      drm: rcar-du: Fix Kconfig dependency between RCAR_DU and RCAR_MIPI_DS=
I

Li Zetao (1):
      mm/mmap: fix memory leak in mmap_region()

Liam Howlett (6):
      fs/userfaultfd: Fix maple tree iterator in userfaultfd_unregister()
      maple_tree: remove pointer to pointer use in mas_alloc_nodes()
      maple_tree: mas_anode_descend() clang-analyzer cleanup
      maple_tree: reorganize testing to restore module testing
      maple_tree: fix depth tracking in maple_state
      maple_tree: don't set a new maximum on the node when not reusing node=
s

Liao Chang (1):
      MIPS: Loongson64: Add WARN_ON on kexec related kmalloc failed

Like Xu (3):
      KVM: x86/pmu: Do not speculatively query Intel GP PMCs that
don't exist yet
      KVM: x86/pmu: Limit the maximum number of supported Intel GP counters
      KVM: x86/pmu: Limit the maximum number of supported AMD GP counters

Linus Torvalds (1):
      Linux 6.1-rc5

Linus Walleij (1):
      mips: alchemy: gpio: Include the right header

Liu Shixin (1):
      btrfs: fix match incorrectly in dev_args_match_device

Lu Wei (1):
      tcp: prohibit TCP_REPAIR_OPTIONS if data was already sent

Lukas Bulwahn (1):
      mm/slab_common: repair kernel-doc for __ksize()

M Chetan Kumar (4):
      net: wwan: iosm: fix memory leak in ipc_pcie_read_bios_cfg
      net: wwan: iosm: fix driver not working with INTEL_IOMMU disabled
      net: wwan: iosm: fix invalid mux header type
      net: wwan: iosm: fix kernel test robot reported errors

Ma Jun (1):
      drm/amdgpu: Fix the lpfn checking condition in drm buddy

Manyi Li (1):
      platform/x86: ideapad-laptop: Disable touchpad_switch

Marek Vasut (1):
      spi: stm32: Print summary 'callbacks suppressed' message

Martin Povi=C5=A1er (1):
      dmaengine: apple-admac: Fix grabbing of channels in of_xlate

Matthew Auld (2):
      drm/i915/dmabuf: fix sg_table handling in map_dma_buf
      drm/i915/userptr: restore probe_range behaviour

Matthias Gerstner (1):
      tools/kvm_stat: fix incorrect detection of debugfs

Maxim Mikityanskiy (2):
      net/mlx5e: Add missing sanity checks for max TX WQE size
      net/mlx5e: Fix usage of DMA sync API

Michael Chan (1):
      bnxt_en: Fix possible crash in bnxt_hwrm_set_coal()

Michal Jaron (1):
      iavf: Fix VF driver counting VLAN 0 filters

Mika Westerberg (1):
      spi: intel: Use correct mask for flash and protected regions

Miquel Raynal (1):
      dt-bindings: net: tsnep: Fix typo on generic nvmem property

Namhyung Kim (1):
      perf stat: Fix crash with --per-node --metric-only in CSV mode

Naoya Horiguchi (1):
      arch/x86/mm/hugetlbpage.c: pud_huge() returns 0 when using 2-level pa=
ging

Nathan Chancellor (2):
      vmlinux.lds.h: Fix placement of '.data..decrypted' section
      RISC-V: vdso: Do not add missing symbols to version section in
linker script

Neil Armstrong (2):
      spi: meson-spicc: move wait completion in driver to take bursts
delay in account
      spi: meson-spicc: fix do_div build error on non-arm64

Nicholas Kazlauskas (2):
      drm/amd/display: Update SR watermarks for DCN314
      drm/amd/display: Fix reg timeout in enc314_enable_fifo

Nick Child (1):
      ibmveth: Reduce default tx queues to 8

Nico Boehr (1):
      KVM: s390: pv: don't allow userspace to set the clock under PV

Nicolas Cavallari (1):
      wifi: mac80211: Fix ack frame idr leak when mesh has no route

Niklas Cassel (1):
      ata: libata-core: do not issue non-internal commands once EH is pendi=
ng

Niranjana Vishwanathapura (1):
      drm/i915: Do not set cache_dirty for DGFX

Norbert Zulinski (1):
      ice: Fix spurious interrupt during removal of trusted VF

Oliver Hartkopp (3):
      can: isotp: fix tx state handling for echo tx processing
      can: j1939: j1939_send_one(): fix missing CAN header initialization
      can: dev: fix skb drop check

Pankaj Gupta (1):
      mm/memremap.c: map FS_DAX device memory as decrypted

Paolo Bonzini (11):
      KVM: x86: use a separate asm-offsets.c file
      KVM: SVM: replace regs argument of __svm_vcpu_run() with vcpu_svm
      KVM: SVM: adjust register allocation for __svm_vcpu_run()
      KVM: SVM: retrieve VMCB from assembly
      KVM: SVM: remove unused field from struct vcpu_svm
      KVM: SVM: remove dead field from struct svm_cpu_data
      KVM: SVM: do not allocate struct svm_cpu_data dynamically
      KVM: SVM: move guest vmsave/vmload back to assembly
      KVM: SVM: restore host save area from assembly
      KVM: SVM: move MSR_IA32_SPEC_CTRL save/restore to assembly
      x86, KVM: remove unnecessary argument to x86_virt_spec_ctrl and calle=
rs

Paul Zhang (1):
      wifi: cfg80211: Fix bitrates overflow issue

Pavel Begunkov (3):
      selftests/net: don't tests batched TCP io_uring zc
      io_uring/poll: fix double poll req->flags races
      io_uring/poll: lockdep annote io_poll_req_insert_locked

Peng Wu (1):
      phy: sunplus: Fix an IS_ERR() vs NULL bug in sp_usb_phy_probe

Peter Gonda (1):
      KVM: SVM: Only dump VMSA to klog at KERN_DEBUG level

Peter Xu (2):
      Partly revert "mm/thp: carry over dirty bit when thp splits on pmd"
      mm/shmem: use page_mapping() to detect page cache for uffd continue

Phil Sutter (1):
      selftests: netfilter: Fix and review rpath.sh

Philip Yang (2):
      drm/amdgpu: Unlock bo_list_mutex after error handling
      drm/amdgpu: Drop eviction lock when allocating PT BO

Pierre-Louis Bossart (1):
      ALSA: hda: clarify comments on SCF changes

Pu Lehui (1):
      bpftool: Fix NULL pointer dereference when pin {PROG, MAP, LINK}
without FILE

Qu Wenruo (1):
      Revert "btrfs: scrub: use larger block size for data extent scrub"

Rafael Mendonca (1):
      KVM: s390: pci: Fix allocation size of aift kzdev elements

Randy Dunlap (1):
      net: octeontx2-pf: mcs: consider MACSEC setting

Rasmus Villemoes (1):
      net: stmmac: dwmac-meson8b: fix meson8b_devm_clk_prepare_enable()

Ratheesh Kannoth (2):
      octeontx2-pf: NIX TX overwrites SQ_CTX_HW_S[SQ_INT]
      octeontx2-pf: Fix SQE threshold checking

Robin Murphy (1):
      drm/panfrost: Split io-pgtable requests properly

Roger Quadros (1):
      net: ethernet: ti: am65-cpsw: Fix segmentation fault at module unload

Roi Dayan (3):
      net/mlx5e: Fix tc acts array not to be dependent on enum order
      net/mlx5e: E-Switch, Fix comparing termination table instance
      net/mlx5e: TC, Fix slab-out-of-bounds in parse_tc_actions

Rong Tao (1):
      tools/kvm_stat: update exit reasons for vmx/svm/aarch64/userspace

Rongwei Zhang (1):
      MIPS: fix duplicate definitions for exported symbols

Roy Novich (1):
      net/mlx5: Allow async trigger completion execution on single CPU syst=
ems

Ryusuke Konishi (2):
      nilfs2: fix deadlock in nilfs_count_free_blocks()
      nilfs2: fix use-after-free bug of ns_writer on remount

Sabrina Dubroca (5):
      Revert "net: macsec: report real_dev features when HW offloading
is enabled"
      macsec: delete new rxsc when offload fails
      macsec: fix secy->n_rx_sc accounting
      macsec: fix detection of RXSCs when toggling offloading
      macsec: clear encryption keys from the stack after setting up offload

Sagi Grimberg (1):
      nvmet: fix a memory leak

Sean Anderson (1):
      net: fman: Unregister ethernet device on removal

Sean Christopherson (1):
      KVM: x86/mmu: Block all page faults during kvm_zap_gfn_range()

Sean Nyekjaer (1):
      spi: stm32: fix stm32_spi_prepare_mbr() that halves spi clk for every=
 run

SeongJae Park (1):
      mm/damon/dbgfs: check if rm_contexts input is for a real context

Serge Semin (1):
      block: sed-opal: kmalloc the cmd/resp buffers

Shay Drory (1):
      net/mlx5: fw_reset: Don't try to load device in case PCI isn't workin=
g

Shigeru Yoshida (1):
      netfilter: Cleanup nft_net->module_list from nf_tables_exit_net()

Shin'ichiro Kawasaki (1):
      ata: libata-scsi: fix SYNCHRONIZE CACHE (16) command failure

Sjoerd Simons (1):
      soundwire: intel: Initialize clock stop timeout

Srinivas Kandagatla (2):
      soundwire: qcom: reinit broadcast completion
      soundwire: qcom: check for outanding writes before doing a read

Stefan Binding (1):
      ALSA: hda/realtek: Add quirk for ASUS Zenbook using CS35L41

Stephen Hemminger (1):
      MAINTAINERS: remove sthemmin

Steve Su (1):
      drm/amd/display: Fix gpio port mapping issue

Steven Price (1):
      drm/panfrost: Remove type name from internal struct again

Takashi Iwai (5):
      ALSA: usb-audio: Yet more regression for for the delayed card registr=
ation
      ALSA: usb-audio: Remove redundant workaround for Roland quirk
      ALSA: usb-audio: Add quirk entry for M-Audio Micro
      ALSA: memalloc: Don't fall back for SG-buffer with IOMMU
      ALSA: memalloc: Try dma_alloc_noncontiguous() at first

Tan, Tee Min (1):
      stmmac: intel: Update PCH PTP clock rate from 200MHz to 204.8MHz

Tim Huang (1):
      drm/amd/pm: update SMU IP v13.0.4 msg interface header

Tudor Ambarus (15):
      dmaengine: at_hdmac: Fix at_lli struct definition
      dmaengine: at_hdmac: Don't start transactions at tx_submit level
      dmaengine: at_hdmac: Start transfer for cyclic channels in issue_pend=
ing
      dmaengine: at_hdmac: Fix premature completion of desc in issue_pendin=
g
      dmaengine: at_hdmac: Do not call the complete callback on
device_terminate_all
      dmaengine: at_hdmac: Protect atchan->status with the channel lock
      dmaengine: at_hdmac: Fix concurrency problems by removing
atc_complete_all()
      dmaengine: at_hdmac: Fix concurrency over descriptor
      dmaengine: at_hdmac: Free the memset buf without holding the chan loc=
k
      dmaengine: at_hdmac: Fix concurrency over the active list
      dmaengine: at_hdmac: Fix descriptor handling when issuing it to hardw=
are
      dmaengine: at_hdmac: Fix completion of unissued descriptor in
case of errors
      dmaengine: at_hdmac: Don't allow CPU to reorder channel enable
      dmaengine: at_hdmac: Fix impossible condition
      dmaengine: at_hdmac: Check return code of dma_async_device_register

Tyler J. Stachecki (1):
      wifi: ath11k: Fix QCN9074 firmware boot on x86

Vasily Gorbik (1):
      mm: hugetlb_vmemmap: include missing linux/moduleparam.h

Vikas Gupta (2):
      bnxt_en: refactor bnxt_cancel_reservations()
      bnxt_en: fix the handling of PCIE-AER

Vitaly Rodionov (1):
      spi: amd: Fix SPI_SPD7 value

Vlad Buslov (1):
      net/mlx5: Bridge, verify LAG state when adding bond to bridge

Vlastimil Babka (2):
      mm/slab: remove !CONFIG_TRACING variants of kmalloc_[node_]trace()
      mm, slab: remove duplicate kernel-doc comment for ksize()

Wang Yufen (2):
      bpf, sockmap: Fix the sk->sk_forward_alloc warning of
sk_stream_kill_queues
      net: tun: Fix memory leaks of napi_get_frags

Wei Yongjun (2):
      mctp: Fix an error handling path in mctp_init()
      eth: sp7021: drop free_netdev() from spl2sw_init_netdev()

Wen Gong (1):
      wifi: ath11k: avoid deadlock during regulatory update in
ath11k_regd_update()

Xian Wang (1):
      ALSA: hda/ca0132: add quirk for EVGA Z390 DARK

Xiaochen Shen (1):
      dmaengine: idxd: Fix max batch size for Intel IAA

Xin Long (3):
      tipc: fix the msg->req tlv len check in
tipc_nl_compat_name_table_dump_header
      sctp: remove the unnecessary sinfo_stream check in
sctp_prsctp_prune_unsent
      sctp: clear out_curr if all frag chunks of current msg are pruned

Yang Yingliang (12):
      ALSA: arm: pxa: pxa2xx-ac97-lib: fix return value check of
platform_get_irq()
      HID: hyperv: fix possible memory leak in mousevsc_probe()
      scsi: scsi_transport_sas: Fix error handling in sas_phy_add()
      octeontx2-pf: fix build error when CONFIG_OCTEONTX2_PF=3Dy
      dmaengine: ti: k3-udma-glue: fix memory leak when register device fai=
l
      stmmac: dwmac-loongson: fix missing pci_disable_msi() while module ex=
iting
      stmmac: dwmac-loongson: fix missing pci_disable_device() in
loongson_dwmac_probe()
      stmmac: dwmac-loongson: fix missing of_node_put() while module exitin=
g
      ata: libata-transport: fix double ata_host_put() in ata_tport_add()
      ata: libata-transport: fix error handling in ata_tport_add()
      ata: libata-transport: fix error handling in ata_tlink_add()
      ata: libata-transport: fix error handling in ata_tdev_add()

Ye Bin (1):
      ALSA: hda: fix potential memleak in 'add_widget_node'

Youlin Li (2):
      bpf: Fix wrong reg type conversion in release_reference()
      selftests/bpf: Add verifier test for release_reference()

Yu Kuai (1):
      block, bfq: fix null pointer dereference in bfq_bio_bfqg()

Yuan Can (1):
      drm/vc4: Fix missing platform_unregister_drivers() call in
vc4_drm_register()

YueHaibing (1):
      net: broadcom: Fix BCMGENET Kconfig

Zhang Xiaoxu (1):
      btrfs: selftests: fix wrong error check in btrfs_free_dummy_root()

ZhangPeng (1):
      udf: Fix a slab-out-of-bounds write bug in udf_find_entry()

Zhao Liu (1):
      x86/hyperv: Remove BUG_ON() for kmap_local_page()

Zhaoping Shu (1):
      net: wwan: iosm: Remove unnecessary if_mutex lock

Zhengchao Shao (15):
      wifi: mac80211: fix general-protection-fault in
ieee80211_subif_start_xmit()
      net: lapbether: fix issue of dev reference count leakage in
lapbeth_device_event()
      hamradio: fix issue of dev reference count leakage in bpq_device_even=
t()
      can: af_can: fix NULL pointer dereference in can_rx_register()
      net: lapbether: fix issue of invalid opcode in lapbeth_open()
      net: ethernet: mtk-star-emac: disable napi when connect and
start PHY failed in mtk_star_enable()
      drivers: net: xgene: disable napi when register irq failed in
xgene_enet_open()
      net: marvell: prestera: fix memory leak in prestera_rxtx_switch_init(=
)
      net: nixge: disable napi when enable interrupts failed in nixge_open(=
)
      net: cpsw: disable napi in cpsw_ndo_open()
      net: cxgb3_main: disable napi when bind qsets failed in cxgb_up()
      cxgb4vf: shut down the adapter when t4vf_update_port_info()
failed in cxgb4vf_open()
      ethernet: s2io: disable napi when start nic failed in s2io_card_up()
      net: mv643xx_eth: disable napi when init rxq or txq failed in
mv643xx_eth_open()
      ethernet: tundra: free irq when alloc ring failed in tsi108_open()

Ziyang Xuan (1):
      netfilter: nfnetlink: fix potential dead lock in nfnetlink_rcv_msg()

maxime@cerno.tech (3):
      drm/vc4: hdmi: Take our lock to reset the link
      drm/vc4: hdmi: Fix outdated function name in comment
      drm/vc4: hdmi: Fix HSM clock too low on Pi4

taozhang (1):
      wifi: mac80211: fix memory free error when registering wiphy fail

zhichao.liu (1):
      spi: mediatek: Fix package division error
