Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F20D66B216
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 16:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjAOPaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 10:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjAOPaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 10:30:07 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A7BC668
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 07:30:05 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id d13so18131902qvj.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 07:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P6xjlBZLXHRyoD8lykEWxqzEE4UC36Olszo2+o0m4pc=;
        b=HQ/1Vb48H6skEiMtHBIUnB2X8e4ee9wxqQAuNiRTJBmieABlvR7rA3NLw6Orgfm5Ki
         FEFLBH+TWx+QGE7KlRPL2M7hqNfmB9HMp32dTIJBjBw8DIZOHi8K90CVpsrov/sVMsAl
         3pjRH5tOUI3LT1x75ICHrWFvtJ4/ryQAidQfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P6xjlBZLXHRyoD8lykEWxqzEE4UC36Olszo2+o0m4pc=;
        b=wMR0s8rKtkzJPZqUdKlSAU6+5AHaM+5uzHgQqbiB5b3GcO0d27h5YyduUqiq338lQq
         BGsfJr/lYYZDiGlygjEHnbhBTjbU4TQ2BvMJ+XUzC9qTBSRR3aidMXzYefdkBWUqSjHi
         ArnUb1CFk15LtMKx6fEfpWbd/1uSDsj1XBSkE3RpnbET4yUTE0zxB8q1L/DNqAcAldan
         muutwvhWrWT2SwUGbi997ScRWM3jxItnnQei5tsiYga8sKFrTLMuiuoekA499jcnncD7
         cMYdBkJlm/jOxMOeouGcT+2Hjsz59FvwwzKlqbUkoi1isGiZ5iiO05sRpXVUT75EWjew
         Om9A==
X-Gm-Message-State: AFqh2krIvnnVgQBEHHuvy6S4rc0kMUnW6tct0rWA+gBsRJuAIB+tXf+d
        Jlaoa/Ks6wp1mqs11SXztDEUgj6TY5IAL9yivz4=
X-Google-Smtp-Source: AMrXdXuDQLWuOp/QKRGrBORcuENEA47BdNPbu3ordRuZhibU6+LJ2LdNNAAd4E6zR3ZvdveLr91YVw==
X-Received: by 2002:a05:6214:188e:b0:4c6:eca0:4870 with SMTP id cx14-20020a056214188e00b004c6eca04870mr23208964qvb.30.1673796603885;
        Sun, 15 Jan 2023 07:30:03 -0800 (PST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com. [209.85.222.182])
        by smtp.gmail.com with ESMTPSA id dm4-20020a05620a1d4400b00705bac8891esm3916111qkb.40.2023.01.15.07.30.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 07:30:03 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id f28so13172085qkh.10
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 07:30:03 -0800 (PST)
X-Received: by 2002:ae9:ef09:0:b0:705:efa8:524c with SMTP id
 d9-20020ae9ef09000000b00705efa8524cmr736757qkg.594.1673796602838; Sun, 15 Jan
 2023 07:30:02 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Jan 2023 09:29:46 -0600
X-Gmail-Original-Message-ID: <CAHk-=wgcOEWvT-WjmRf-zCCXyFJaVVFH=26BPQ+N1OFTTnN=RA@mail.gmail.com>
Message-ID: <CAHk-=wgcOEWvT-WjmRf-zCCXyFJaVVFH=26BPQ+N1OFTTnN=RA@mail.gmail.com>
Subject: Linux 6.2-rc4
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

It's Sunday afternoon in some parts of the world, and since I'm going
to spend the rest of the day on airports and flights, that's good
enough for me.

So here's another -rc release, this time with pretty much everybody
back from winter holidays, and so things should be back to normal. And
you can see that in the size, this is pretty much bang in the middle
of a regular rc size for this time in the merge window.

The stats look fairly normal too, perhaps with a slight emphasis on
networking that was playing catch-up after the holidays. But there's
various changes all over - scan the appended shortlog for a taste of
what has been going on.

                    Linus

---

Aaron Thompson (1):
      mm: Always release pages to the buddy allocator in memblock_free_late=
().

Adam Skladowski (1):
      dt-bindings: display: msm: Rename mdss node name in example

Adrian Chan (1):
      ALSA: hda/hdmi: Add a HP device 0x8715 to force connect list

Adrian Hunter (1):
      perf auxtrace: Fix address filter duplicate symbol selection

Ajye Huang (1):
      ASoC: Intel: sof_nau8825: add variant with nau8318 amplifier.

Akhil P Oommen (1):
      drm/msm/a6xx: Avoid gx gbit halt during rpm suspend

Akira Yokosawa (1):
      docs/conf.py: Use about.html only in sidebar of alabaster theme

Alex Elder (1):
      net: ipa: correct IPA v4.7 IMEM offset

Alexander Egorenkov (1):
      s390/kexec: fix ipl report address for kdump

Alexander Gordeev (1):
      s390: expicitly align _edata and _end symbols on page boundary

Alexandru Elisei (1):
      MAINTAINERS: Remove myself as a KVM/arm64 reviewer

Allen-KH Cheng (1):
      ASoC: mediatek: mt8186: Add machine support for max98357a

Andre Przywara (1):
      r8152: add vendor/device ID pair for Microsoft Devkit

Angela Czubak (1):
      octeontx2-af: Fix LMAC config in cgx_lmac_rx_tx_enable

Aniol Mart=C3=AD (1):
      ASoC: amd: yc: Add ASUS M5402RA into DMI table

Anshuman Khandual (1):
      arm64: errata: Workaround possible Cortex-A715 [ESR|FAR]_ELx corrupti=
on

Ard Biesheuvel (2):
      efi: rt-wrapper: Add missing include
      efi: tpm: Avoid READ_ONCE() for accessing the event log

Ariel Levkovich (2):
      net/mlx5: check attr pointer validity before dereferencing it
      net/mlx5e: TC, Keep mod hdr actions after mod hdr alloc

Arnaldo Carvalho de Melo (2):
      perf tools: Don't install libtraceevent plugins as its not
anymore in the kernel sources
      perf bpf: Avoid build breakage with libbpf < 0.8.0 + LIBBPF_DYNAMIC=
=3D1

Arnd Bergmann (4):
      ASoC: Intel: fix sof-nau8825 link failure
      ASoC: Intel: sof-nau8825: fix module alias overflow
      cpufreq: apple: remove duplicate intializer
      mtd: cfi: allow building spi-intel standalone

Arunpravin Paneer Selvam (1):
      drm: Optimize drm buddy top-down allocation method

Athira Rajeev (1):
      perf tests bpf prologue: Fix bpf-script-test-prologue test
compile issue with clang

Aya Levin (1):
      net/mlx5e: Fix memory leak on updating vport counters

Bartosz Golaszewski (2):
      spi: spidev: fix a race condition when accessing spidev->spi
      spi: spidev: remove debug messages that access spidev->spi without lo=
cking

Biao Huang (1):
      stmmac: dwmac-mediatek: remove the dwmac_fix_mac_speed

Bjorn Helgaas (2):
      x86/pci: Simplify is_mmconf_reserved() messages
      x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM space

Brian Norris (1):
      ASoC: qcom: lpass-cpu: Fix fallback SD line index handling

Bryan O'Donoghue (4):
      dt-bindings: msm: dsi-phy-28nm: Add missing qcom,
dsi-phy-regulator-ldo-mode
      dt-bindings: msm: dsi-controller-main: Fix operating-points-v2 constr=
aint
      dt-bindings: msm: dsi-controller-main: Fix power-domain constraint
      dt-bindings: msm: dsi-controller-main: Fix description of core clock

Catalin Marinas (3):
      arm64: mte: Fix double-freeing of the temporary tag storage
during coredump
      elfcore: Add a cprm parameter to elf_core_extra_{phdrs,data_size}
      arm64: mte: Avoid the racy walk of the vma list during core dump

Chancel Liu (1):
      ASoC: fsl_micfil: Correct the number of steps on SX controls

ChiYuan Huang (1):
      ASoC: rt9120: Make dev PM runtime bind AsoC component PM

Chris Chiu (1):
      ALSA: hda - Enable headset mic on another Dell laptop with ALC3254

Chris Wilson (1):
      drm/i915/gt: Reset twice

Christian K=C3=B6nig (3):
      drm/amdgpu: fix another missing fence reference in the CS code
      drm/amdgpu: fix missing dma_fence_put in error path
      drm/amdgpu: fix pipeline sync v2

Christoph Hellwig (3):
      nvme: remove __nvme_ioctl
      nvme: replace the "bool vec" arguments with flags in the ioctl path
      nvme: don't allow unprivileged passthrough on partitions

Christophe JAILLET (2):
      drm/msm/hdmi: Fix the error handling path of msm_hdmi_dev_probe()
      iommu/mediatek-v1: Fix an error handling path in mtk_iommu_v1_probe()

Christopher S Hall (1):
      igc: Fix PPS delta between two synchronized end-points

Chuck Lever (2):
      Revert "SUNRPC: Use RMW bitops in single-threaded hot paths"
      NFSD: Use set_bit(RQ_DROPME)

Clement Lecigne (1):
      ALSA: pcm: Move rwsem lock inside snd_ctl_elem_read to prevent UAF

Cl=C3=A9ment L=C3=A9ger (1):
      net: lan966x: check for ptp to be enabled in lan966x_ptp_deinit()

Colin Ian King (1):
      cifs: remove redundant assignment to the variable match

Curtis Malainey (1):
      ASoC: SOF: Add FW state to debugfs

Daniil Tatianin (1):
      iavf/iavf_main: actually log ->src mask when talking about it

Darrick J. Wong (3):
      xfs: don't assert if cmap covers imap after cycling lock
      xfs: make xfs_iomap_page_ops static
      xfs: fix off-by-one error in xfs_btree_space_to_height

David Howells (19):
      rxrpc: Stash the network namespace pointer in rxrpc_local
      rxrpc: Make the local endpoint hold a ref on a connected call
      rxrpc: Separate call retransmission from other conn events
      rxrpc: Only set/transmit aborts in the I/O thread
      rxrpc: Only disconnect calls in the I/O thread
      rxrpc: Implement a mechanism to send an event notification to a conne=
ction
      rxrpc: Clean up connection abort
      rxrpc: Tidy up abort generation infrastructure
      rxrpc: Make the set of connection IDs per local endpoint
      rxrpc: Offload the completion of service conn security to the I/O thr=
ead
      rxrpc: Set up a connection bundle from a call, not rxrpc_conn_paramet=
ers
      rxrpc: Split out the call state changing functions into their own fil=
e
      rxrpc: Wrap accesses to get call state to put the barrier in one plac=
e
      rxrpc: Move call state changes from sendmsg to I/O thread
      rxrpc: Move call state changes from recvmsg to I/O thread
      rxrpc: Remove call->state_lock
      rxrpc: Move the client conn cache management to the I/O thread
      rxrpc: Move client call connection to the I/O thread
      rxrpc: Fix incoming call setup race

David Woodhouse (4):
      KVM: x86/xen: Fix lockdep warning on "recursive" gpc locking
      KVM: x86/xen: Fix potential deadlock in kvm_xen_update_runstate_guest=
()
      KVM: Ensure lockdep knows about kvm->lock vs. vcpu->mutex ordering ru=
le
      KVM: x86/xen: Avoid deadlock by adding kvm->arch.xen.xen_lock
leaf node lock

Dawei Li (1):
      xen: make remove callback of xen driver void returned

Ding Hui (1):
      efi: fix userspace infinite retry read efivars after EFI runtime
services page fault

Dmitry Baryshkov (1):
      drm/msm: another fix for the headless Adreno GPU

Dragos Tatulea (3):
      net/mlx5e: IPoIB, Block queue count configuration when sub
interfaces are present
      net/mlx5e: IPoIB, Block PKEY interfaces with less rx queues than pare=
nt
      net/mlx5e: IPoIB, Fix child PKEY interface stats on rx path

Eliav Farber (1):
      EDAC/device: Fix period calculation in edac_device_reset_delay_period=
()

Emanuele Ghidoli (1):
      ASoC: wm8904: fix wrong outputs volume after power reactivation

Emeel Hakim (2):
      net/mlx5e: Fix macsec ssci attribute handling in offload path
      net/mlx5e: Fix macsec possible null dereference when updating
MAC security entity (SecY)

Eric Dumazet (1):
      gro: take care of DODGY packets

Eric Huang (2):
      drm/amdkfd: Add sync after creating vram bo
      drm/amdkfd: Fix NULL pointer error for GC 11.0.1 on mGPU

Evan Quan (2):
      drm/amd/pm: correct the reference clock for fan speed(rpm) calculatio=
n
      drm/amd/pm: add the missing mapping for PPT feature on SMU13.0.0
and 13.0.7

Frederick Lawler (1):
      net: sched: disallow noqueue for qdisc classes

Gavin Li (1):
      net/mlx5e: Don't support encap rules with gbp option

Gayatri Kammela (1):
      platform/x86: intel/pmc/core: Add Meteor Lake mobile support

Gongjun Song (2):
      ASoC: Intel: soc-acpi: add configuration for variant of 0C40 product
      ASoC: Intel: soc-acpi: add configuration for variant of 0C11 product

Guchun Chen (1):
      drm/amd/pm/smu13: BACO is supported when it's in BACO state

Guillaume Nault (3):
      selftests/net: l2_tos_ttl_inherit.sh: Set IPv6 addresses with "nodad"=
.
      selftests/net: l2_tos_ttl_inherit.sh: Run tests in their own netns.
      selftests/net: l2_tos_ttl_inherit.sh: Ensure environment cleanup
on failure.

Gustavo Sousa (1):
      drm/i915/gt: Cover rest of SVG unit MCR registers

Hannes Reinecke (1):
      scsi: core: scsi_error: Do not queue pointless abort workqueue functi=
ons

Hans de Goede (8):
      platform/x86: sony-laptop: Don't turn off 0x153 keyboard
backlight during probe
      platform/x86: ideapad-laptop: Add Legion 5 15ARH05 DMI id to
set_fn_lock_led_list[]
      ACPI: video: Allow selecting NVidia-WMI-EC or Apple GMUX
backlight from the cmdline
      ACPI: Fix selecting wrong ACPI fwnode for the iGPU on some Dell lapto=
ps
      platform/x86: asus-nb-wmi: Add alternate mapping for KEY_SCREENLOCK
      platform/x86: dell-privacy: Fix SW_CAMERA_LENS_COVER reporting
      platform/x86: dell-privacy: Only register SW_CAMERA_LENS_COVER if pre=
sent
      platform/x86: int3472/discrete: Ensure the clk/power enable pins
are in output mode

Hariprasad Kelam (1):
      octeontx2-pf: Fix resource leakage in VF driver unbind

Hector Martin (5):
      cpufreq: apple-soc: Switch to the lowest frequency on suspend
      spi: dt-bindings: Rename spi-cs-setup-ns to spi-cs-setup-delay-ns
      spi: Rename spi-cs-setup-ns property to spi-cs-setup-delay-ns
      nvme-apple: add NVME_QUIRK_IDENTIFY_CNS quirk to fix regression
      nvme-pci: add NVME_QUIRK_IDENTIFY_CNS quirk to Apple T2 controllers

Heiko Carstens (4):
      s390/cpum_sf: add READ_ONCE() semantics to compare and swap loops
      s390/percpu: add READ_ONCE() to arch_this_cpu_to_op_simple()
      KVM: s390: interrupt: use READ_ONCE() before cmpxchg()
      s390: update defconfigs

Heiner Kallweit (1):
      Revert "r8169: disable detection of chip version 36"

Henning Schild (2):
      platform/x86: simatic-ipc: correct name of a model
      platform/x86: simatic-ipc: add another model

Herbert Xu (1):
      ipv6: raw: Deduct extension header length in rawv6_push_pending_frame=
s

Hironori Shiina (1):
      xfs: get root inode correctly at bulkstat

Horatiu Vultur (1):
      net: lan966x: Allow to add rules in TCAM even if not enabled

Hui Wang (1):
      net: usb: cdc_ether: add support for Thales Cinterion PLS62-W modem

Ian Rogers (2):
      perf build: Properly guard libbpf includes
      perf build: Fix build error when NO_LIBBPF=3D1

Ido Schimmel (1):
      net/sched: act_mpls: Fix warning during failed attribute validation

Ivan T. Ivanov (1):
      brcmfmac: Prefer DT board type over DMI board type

Jakub Kicinski (1):
      bnxt: make sure we return pages to the pool

James Clark (2):
      KVM: arm64: PMU: Fix PMCR_EL0 reset value
      arm64: Fix build with CC=3Dclang, CONFIG_FTRACE=3Dy and CONFIG_STACK_=
TRACER=3Dy

Jaroslav Kysela (3):
      ALSA: usb-audio: Always initialize fixed_rate in
snd_usb_find_implicit_fb_sync_format()
      ALSA: control-led: use strscpy in set_led_id()
      ALSA: usb-audio: Fix possible NULL pointer dereference in
snd_usb_pcm_has_fixed_rate()

Jason Yan (1):
      scsi: hisi_sas: Fix tag freeing for reserved tags

Jeff Layton (1):
      nfsd: fix handling of cached open files in nfsd4_open codepath

Jens Axboe (4):
      io_uring/io-wq: only free worker if it was allocated for creation
      io_uring/poll: add hash if ready poll request can't complete inline
      io_uring/fdinfo: include locked hash table in fdinfo output
      io_uring/poll: attempt request issue after racy poll wakeup

Jeremy Szu (1):
      ALSA: hda/realtek: fix mute/micmute LEDs don't work for a HP platform

Jiapeng Chong (1):
      x86/xen: Remove the unused function p2m_index()

Jiasheng Jiang (1):
      ice: Add check for kzalloc

Jie Wang (1):
      net: hns3: fix wrong use of rss size during VF rss config

Johan Hovold (1):
      efi: fix NULL-deref in init error path

John Garry (1):
      scsi: scsi_debug: Delete unreachable code in inquiry_vpd_b0()

Jonathan Corbet (2):
      docs: Fix the docs build with Sphinx 6.0
      docs: Deprecate use of Sphinx < 2.4.x

Juergen Gross (2):
      x86/pat: Fix pat_x_mtrr_type() for MTRR disabled case
      x86/mm: fix poking_init() for Xen PV guests

Kajol Jain (1):
      powerpc/imc-pmu: Fix use of mutex in IRQs disabled section

Kan Liang (4):
      perf/x86/cstate: Add Meteor Lake support
      perf/x86/msr: Add Meteor Lake support
      perf/x86/msr: Add Emerald Rapids
      perf/x86/intel/uncore: Add Emerald Rapids

Kees Cook (2):
      mlxsw: spectrum_router: Replace 0-length array with flexible array
      firmware: coreboot: Check size of table entry and use flex-array

Konrad Dybcio (5):
      cpufreq: qcom-hw: Fix reading "reg" with address/size-cells !=3D 2
      dt-bindings: msm/dsi: Don't require vcca-supply on 14nm PHY
      dt-bindings: msm/dsi: Don't require vdds-supply on 10nm PHY
      cpufreq: Add SM6375 to cpufreq-dt-platdev blocklist
      drm/msm/adreno: Make adreno quirks not overwrite each other

Krzysztof Kozlowski (3):
      dt-bindings: cpufreq: cpufreq-qcom-hw: document interrupts
      ASoC: dt-bindings: qcom,lpass-wsa-macro: correct clocks on SM8250
      ASoC: dt-bindings: qcom,lpass-tx-macro: correct clocks on SC7280

Kuogee Hsieh (1):
      drm/msm/dp: do not complete dp_aux_cmd_fifo_tx() if irq is not
for aux transfer

Leo Yan (2):
      perf kmem: Support legacy tracepoints
      perf kmem: Support field "node" in evsel__process_alloc_event()
coping with recent tracepoint restructuring

Li zeming (1):
      xfs: xfs_qm: remove unnecessary =E2=80=980=E2=80=99 values from error

Linus Torvalds (2):
      gcc: disable -Warray-bounds for gcc-11 too
      Linux 6.2-rc4

Liu Shixin (2):
      arm64/mm: fix incorrect file_map_count for invalid pmd
      arm64/mm: add pud_user_exec() check in pud_user_accessible_page()

Luben Tuikov (1):
      drm/amdgpu: Fix potential NULL dereference

Luka Guzenko (1):
      ALSA: hda/realtek: Enable mute/micmute LEDs on HP Spectre x360 13-aw0=
xxx

Lukas Bulwahn (1):
      PCI: dwc: Adjust to recent removal of PCI_MSI_IRQ_DOMAIN

Marc Zyngier (6):
      KVM: arm64: Fix S1PTW handling on RO memslots
      KVM: arm64: Document the behaviour of S1PTW faults on RO memslots
      KVM: arm64: Convert FSC_* over to ESR_ELx_FSC_*
      KVM: arm64: vgic: Add Apple M2 cpus to the list of broken SEIS
implementations
      MAINTAINERS: Add Zenghui Yu as a KVM/arm64 reviewer
      firmware/psci: Don't register with debugfs if PSCI isn't available

Mario Limonciello (1):
      drm/amd: Delay removal of the firmware framebuffer

Marios Makassikis (1):
      ksmbd: send proper error response in smb2_tree_connect()

Mark Brown (5):
      arm64/sme: Fix context switch for SME only systems
      arm64/signal: Always accept SVE signal frames on SME only systems
      arm64/signal: Always allocate SVE signal frames on SME only systems
      ASoC: fsl_ssi: Rename AC'97 streams to avoid collisions with AC'97 CO=
DEC
      ASoC: fsl-asoc-card: Fix naming of AC'97 CODEC widgets

Mark Pearson (1):
      platform/x86: thinkpad_acpi: Fix profile mode display in AMT mode

Mark Rutland (1):
      arm64: cmpxchg_double*: hazard against entire exchange variable

Mars Chen (1):
      ASoC: support machine driver with max98360

Masahiro Yamada (2):
      s390: define RUNTIME_DISCARD_EXIT to fix link error with GNU ld < 2.3=
6
      s390: fix -Wundef warning for CONFIG_KERNEL_ZSTD

Mateusz Guzik (1):
      lockref: stop doing cpu_relax in the cmpxchg loop

Max Filippov (2):
      kcsan: test: don't put the expect array on the stack
      xtensa: drop unused members of struct thread_struct

Maximilian Luz (2):
      platform/surface: aggregator: Ignore command messages not intended fo=
r us
      platform/surface: aggregator: Add missing call to ssam_request_sync_f=
ree()

Miaoqian Lin (4):
      drm/msm/dpu: Fix memory leak in msm_mdss_parse_data_bus_icc_path
      EDAC/highbank: Fix memory leak in highbank_mc_probe()
      platform/x86/amd: Fix refcount leak in amd_pmc_probe
      iommu: Fix refcount leak in iommu_device_claim_dma_owner

Michael Kelley (1):
      scsi: storvsc: Fix swiotlb bounce buffer leak in confidential VM

Michael Klein (1):
      platform/x86: touchscreen_dmi: Add info for the CSL Panther Tab HD

Mikhail Zhilkin (1):
      mtd: parsers: scpart: fix __udivdi3 undefined on mips

Miles Chen (1):
      cpufreq: armada-37xx: stop using 0 as NULL pointer

Minsuk Kang (1):
      nfc: pn533: Wait for out_urb's completion in pn533_usb_send_frame()

Mirsad Goran Todorovac (1):
      af_unix: selftest: Fix the size of the parameter to connect()

Moshe Shemesh (1):
      net/mlx5: Fix command stats access after free

Namjae Jeon (1):
      ksmbd: fix infinite loop in ksmbd_conn_handler_loop()

Neil Armstrong (1):
      regulator: qcom-rpmh: PM8550 ldo11 regulator is an nldo

Nicholas Piggin (2):
      objtool: Tolerate STT_NOTYPE symbols at end of section
      kallsyms: Fix scheduling with interrupts disabled in self-test

Niklas Schnelle (1):
      s390/debug: add _ASM_S390_ prefix to header guard

Nirmoy Das (1):
      drm/i915: Reserve enough fence slot for i915_vma_unbind_async

Noor Azura Ahmad Tarmizi (1):
      net: stmmac: add aux timestamps fifo clearance wait

Ojaswin Mujoo (1):
      powerpc/boot: Fix incorrect version calculation issue in ld_version

Oleksii Moisieiev (1):
      xen/pvcalls: free active map buffer on pvcalls_front_free_map

Oz Shlomo (2):
      net/mlx5e: TC, ignore match level for post meter rules
      net/mlx5e: TC, Restore pkt rate policing support

Paolo Bonzini (3):
      KVM: nSVM: clarify recalc_intercepts() wrt CR8
      KVM: x86: Do not return host topology information from
KVM_GET_SUPPORTED_CPUID
      Documentation: kvm: fix SRCU locking order docs

Patrick Thompson (1):
      drm: Add orientation quirk for Lenovo ideapad D330-10IGL

Paulo Alcantara (5):
      cifs: fix file info setting in cifs_query_path_info()
      cifs: fix file info setting in cifs_open_file()
      cifs: fix double free on failed kerberos auth
      cifs: do not query ifaces on smb1 mounts
      cifs: fix potential memory leaks in session setup

Pavel Begunkov (1):
      io_uring: lock overflowing for IOPOLL

Perry Yuan (1):
      cpufreq: amd-pstate: fix kernel hang issue while amd-pstate unregiste=
ring

Peter Foley (1):
      ata: pata_cs5535: Don't build on UML

Peter Newman (2):
      x86/resctrl: Fix task CLOSID/RMID update race
      x86/resctrl: Fix event counts regression in reused RMIDs

Peter Wang (1):
      scsi: ufs: core: WLUN suspend SSU/enter hibern8 fail recovery

Peter Zijlstra (2):
      sh/mm: Fix pmd_t for real
      x86/boot: Avoid using Intel mnemonics in AT&T syntax asm

Pierre Gondois (1):
      cpufreq: CPPC: Add u64 casts to avoid overflowing

Rahul Rameshbabu (1):
      net/mlx5: Fix ptp max frequency adjustment range

Randy Dunlap (1):
      time: Fix various kernel-doc problems

Ranjani Sridharan (2):
      ASoC: SOF: pm: Set target state earlier
      ASoC: SOF: pm: Always tear down pipelines before DSP suspend

Ricardo Ribalda (3):
      regulator: da9211: Use irq handler when ready
      spi: mediatek: Enable irq before the spi registration
      spi: mediatek: Enable irq before the spi registration

Rob Clark (2):
      drm/i915: Fix potential context UAFs
      drm/virtio: Fix GEM handle creation UAF

Robin Murphy (1):
      iommu/arm-smmu: Report IOMMU_CAP_CACHE_COHERENCY even betterer

Roger Pau Monne (1):
      hvc/xen: lock console list traversal

Roy Novich (1):
      net/mlx5e: Verify dev is present for fix features ndo

Russell King (Oracle) (1):
      MAINTAINERS: stop nvme matching for nvmem files

Sami Tolvanen (1):
      kbuild: Fix CFI hash randomization with KASAN

Shay Drory (1):
      net/mlx5: E-switch, Coverity: overlapping copy

Shin'ichiro Kawasaki (1):
      scsi: mpi3mr: Refer CONFIG_SCSI_MPI3MR in Makefile

Sreekanth Reddy (2):
      scsi: mpt3sas: Remove usage of dma_get_required_mask() API
      scsi: mpi3mr: Remove usage of dma_get_required_mask() API

Stephan Gerhold (1):
      ASoC: qcom: Fix building APQ8016 machine driver without SOUNDWIRE

Sumit Gupta (1):
      cpufreq: Add Tegra234 to cpufreq-dt-platdev blocklist

Sven Schnelle (1):
      nolibc: fix fd_set type

Takashi Iwai (6):
      ALSA: usb-audio: Make sure to stop endpoints before closing EPs
      ALSA: usb-audio: Relax hw constraints for implicit fb sync
      ALSA: usb-audio: More refactoring of hw constraint rules
      Revert "ALSA: usb-audio: Drop superfluous interface setup at parsing"
      ALSA: hda: cs35l41: Don't return -EINVAL from system suspend/resume
      ALSA: hda: cs35l41: Check runtime suspend capability at runtime_idle

Tamim Khan (1):
      ACPI: resource: Skip IRQ override on Asus Expertbook B2402CBA

Tejun Heo (1):
      block: Drop spurious might_sleep() from blk_put_queue()

Thomas Wei=C3=9Fschuh (4):
      platform/x86: asus-nb-wmi: Add alternate mapping for KEY_CAMERA
      platform/x86: asus-wmi: Add quirk wmi_ignore_fan
      platform/x86: asus-wmi: Ignore fan on E410MA
      platform/x86: asus-wmi: Don't load fan curves without fan

Thomas Zimmermann (1):
      drm/nouveau: Remove file nouveau_fbcon.c

Tong Zhang (1):
      nvme-pci: fix error handling in nvme_pci_enable()

Tudor Ambarus (1):
      MAINTAINERS: Update email of Tudor Ambarus

Tung Nguyen (1):
      tipc: fix unexpected link reset due to discovery messages

Vladimir Oltean (2):
      iommu/arm-smmu: Don't unregister on shutdown
      iommu/arm-smmu-v3: Don't unregister on shutdown

Volker Lendecke (1):
      cifs: Fix uninitialized memory read for smb311 posix symlink create

Waiman Long (2):
      sched/core: Fix use-after-free bug in dup_user_cpus_ptr()
      sched/core: Use kfree_rcu() in do_set_cpus_allowed()

Warner Losh (1):
      tools/nolibc: Fix S_ISxxx macros

Wenchao Hao (1):
      scsi: iscsi: Fix multiple iSCSI session unbind events sent to userspa=
ce

Wengang Wang (1):
      xfs: fix extent busy updating

Will Deacon (2):
      firmware/psci: Fix MEM_PROTECT_RANGE function numbers
      arm64/mm: Define dummy pud_user_exec() when using 2-level page-table

William Liu (1):
      ksmbd: check nt_len to be at least CIFS_ENCPWD_SIZE in
ksmbd_decode_ntlmssp_auth_blob

Willy Tarreau (4):
      tools/nolibc: restore mips branch ordering in the _start block
      tools/nolibc: fix missing includes causing build issues at -O0
      tools/nolibc: prevent gcc from making memset() loop over itself
      tools/nolibc: fix the O_* fcntl/open macro definitions for riscv

Wim Van Boven (1):
      ASoC: amd: yc: Add Razer Blade 14 2022 into DMI table

Witold Sadowski (1):
      spi: cadence: Fix busy cycles calculation

Wu Guanghao (1):
      xfs: Fix deadlock on xfs_inodegc_worker

Xingui Yang (2):
      scsi: libsas: Grab the ATA port lock in sas_ata_device_link_abort()
      scsi: hisi_sas: Use abort task set to reset SAS disks when discovered

Yair Podemsky (1):
      sched/core: Fix arch_scale_freq_tick() on tickless systems

Yang Li (1):
      drm/msm/dpu: Fix some kernel-doc comments

Yang Yingliang (2):
      ixgbe: fix pci device refcount leak
      powerpc/64s/hash: Make stress_hpt_timer_fn() static

Yevgeny Kliteynik (1):
      net/mlx5: DR, Fix 'stack frame size exceeds limit' error in dr_rule

YiPeng Chai (1):
      drm/amdgpu: Fixed bug on error when unloading amdgpu

Yihang Li (1):
      scsi: hisi_sas: Set a port invalid only if there are no devices
attached when refreshing port id

Yuan Can (2):
      mtd: parsers: Fix potential memory leak in
mtd_parser_tplink_safeloader_parse()
      ice: Fix potential memory leak in ice_gnss_tty_write()

Yuchi Yang (1):
      ALSA: hda/realtek - Turn on power early

Yunfei Wang (1):
      iommu/iova: Fix alloc iova overflows issue

Zack Rusin (2):
      drm/vmwgfx: Remove rcu locks from user resources
      drm/ttm: Fix a regression causing kernel oops'es

Zenghui Yu (1):
      arm64: ptrace: Use ARM64_SME to guard the SME register enumerations

junhua huang (1):
      arm64/uprobes: change the uprobe_opcode_t typedef to fix the
sparse warning

tongjian (2):
      ASoC: mediatek: mt8186: support rt5682s_max98360
      ASoC: dt-bindings: mt8186-mt6366: add new compatible for max98360a
