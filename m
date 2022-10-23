Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91371609724
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 01:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJWXEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 19:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJWXEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 19:04:09 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71C96919A
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 16:04:06 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id l9so2704816qkk.11
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 16:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T6J6rV/Z1gDKaW3ebAL0FKEUio8dSfYxWMWRvLFY/ss=;
        b=IBMsa0Ccmm6avV/ZD8andCgsDgMZiJfehoSjS4pB9GMPyq92+uotbVyoOVj2n3W0tr
         H11YhKhNUfyvdzuahM6lFvDMLW4CfZf+9n4wOv3Q5MWe6n03Sw4HyZQIwVR/Irxq1hRv
         kiOSXosAzpOlZYCuiuCIfbSHelLtY/daoNfIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6J6rV/Z1gDKaW3ebAL0FKEUio8dSfYxWMWRvLFY/ss=;
        b=LcHMlA4bEEVUrT3XXpUjqMHnY4hTN7fSTRqFF7oduwDjwV4iAt9+Zhe+HtvKhusiO0
         tHRLJAQuF2KTAmLhWKKYhTiwPGSISwMOrR0U7jr1Ua7v+T4lxMAZUur1DejQglGzL6cb
         wJqFm72Fb7TCIWqGYNcRQ63uLOf12dyxBkr9jfROudnD74GaKKMFndHUfRnViFLB/q34
         cWiX7FEU2JnSxRzewu/2b9ndBhNNAKvaHzGfYsSjJXqXM80nNx1+q8fC/RQJVpNj+hKG
         Zg2d4xhWCo+Py9aulZ13uSxbzqU99t08p5WpMz1p4Iaxe2YTBmYZI/yqfWnCfun2t6gA
         1c/A==
X-Gm-Message-State: ACrzQf1Qo07R663YIwxHLyUGSmGF4DKKm0hrkNGls7AJSjnzj6Sw0aue
        H6nkXhEKRYAff9LmT4QKgrb1SqgCwDlFgA==
X-Google-Smtp-Source: AMsMyM6uUWMNKWZzhdtQ7cXkewcKh9JwchckpuHmB6sI9/m2xsabfvKsEvM4ZJRO927V0FCs09rfxA==
X-Received: by 2002:a05:620a:131b:b0:6ec:bce7:99a9 with SMTP id o27-20020a05620a131b00b006ecbce799a9mr21041107qkj.84.1666566242852;
        Sun, 23 Oct 2022 16:04:02 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id k11-20020a05620a0b8b00b006cf3592cc20sm13669704qkh.55.2022.10.23.16.04.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 16:04:02 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 187so221778ybe.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 16:04:02 -0700 (PDT)
X-Received: by 2002:a05:6902:1352:b0:6bb:3f4b:9666 with SMTP id
 g18-20020a056902135200b006bb3f4b9666mr24898626ybu.101.1666566241482; Sun, 23
 Oct 2022 16:04:01 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 23 Oct 2022 16:03:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgLV1tNP0EYz7qWK-xeKzO6bh5Kogbpn2wxKLPPpOit3w@mail.gmail.com>
Message-ID: <CAHk-=wgLV1tNP0EYz7qWK-xeKzO6bh5Kogbpn2wxKLPPpOit3w@mail.gmail.com>
Subject: Linux 6.1-rc2
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

Hmm. Usually rc2 is a pretty quiet week, and it mostly started out
that way too, but then things took a turn for the strange. End result:
6.1-rc2 ended up being unusually large.

The main reason is fairly benign, though: Mauro had screwed up the
media tree pull request during the merge window, so rc2 ends up having
a "oops, here's the part that was missing" moment. Since it had all
been in linux-next (yes, I checked, so nobody else should try that
trick), I ended up pulling that missing part during the rc2 week.

But if you ignore that media tree portion, things look pretty normal for an=
 rc2.

Anyway, ignoring those media changes, we have a little bit of
everything in here - arch updates, drivers (gpu, device mapper,
networking), EFI, some core kernel fixes (mm, scheduler, cgroup,
networking). The full shortlog is appended (and that shortlog does
include the media pieces).

Please do go test,
                 Linus

---

Adam Borowski (1):
      i2c: mlxbf: depend on ACPI; clean away ifdeffage

Alan Stern (1):
      media: mceusb: Use new usb_control_msg_*() routines

Alex Deucher (1):
      drm/amdgpu: fix sdma doorbell init ordering on APUs

Alexander Graf (3):
      kvm: Add support for arch compat vm ioctls
      KVM: x86: Copy filter arg outside kvm_vm_ioctl_set_msr_filter()
      KVM: x86: Add compat handler for KVM_X86_SET_MSR_FILTER

Alexander Potapenko (1):
      tipc: fix an information leak in tipc_topsrv_kern_subscr

Alexander Stein (2):
      media: v4l2: Fix v4l2_i2c_subdev_set_name function documentation
      ata: ahci-imx: Fix MODULE_ALIAS

Alexey Romanov (1):
      zsmalloc: zs_destroy_pool: add size_class NULL check

Alistair Popple (1):
      nouveau: fix migrate_to_ram() for faulting page

Andrew Jones (1):
      RISC-V: Fix compilation without RISCV_ISA_ZICBOM

Andrew Morton (1):
      mm/mmap.c: __vma_adjust(): suppress uninitialized var warning

Andy Shevchenko (2):
      media: atomisp_gmin_platform: Switch to use acpi_evaluate_dsm_typed()
      media: atomisp_gmin_platform: Unexport and split camera_sensor_csi()

Anup Patel (1):
      RISC-V: KVM: Fix kvm_riscv_vcpu_timer_pending() for Sstc

Ard Biesheuvel (6):
      efi: libstub: Remove zboot signing from build options
      efi: ssdt: Don't free memory if ACPI table was loaded successfully
      efi: efivars: Fix variable writes without query_variable_store()
      efi: libstub: Give efi_main() asmlinkage qualification
      efi: libstub: Fix incorrect payload size in zboot header
      efi: runtime: Don't assume virtual mappings are missing if VA =3D=3D =
PA =3D=3D 0

Arunpravin Paneer Selvam (1):
      drm/amdgpu: Fix for BO move issue

Asher Song (1):
      drm/amdgpu: Revert "drm/amdgpu: getting fan speed pwm for vega10 prop=
erly"

Ashish Kalra (1):
      ACPI: APEI: Fix integer overflow in ghes_estatus_pool_init()

Babu Moger (1):
      x86/resctrl: Fix min_cbm_bits for AMD

Bagas Sanjaya (1):
      Documentation: ACPI: Prune DSDT override documentation from index

Benjamin Gaignard (7):
      media: hantro: Store HEVC bit depth in context
      media: hantro: HEVC: Fix auxilary buffer size calculation
      media: hantro: HEVC: Fix chroma offset computation
      media: hantro: postproc: Configure output regs to support 10bit
      media: Hantro: HEVC: Allows 10-bit bitstream
      media: hantro: imx8m: Enable 10bit decoding
      media: hantro: Allows luma and chroma depth to be different

Boris Burkov (1):
      btrfs: send: allow protocol version 3 with CONFIG_BTRFS_DEBUG

Borislav Petkov (1):
      x86/microcode/AMD: Apply the patch early on every logical thread

Brett Creeley (1):
      ionic: catch NULL pointer issue on reconfig

Bryan O'Donoghue (3):
      media: venus: dec: Handle the case where find_format fails
      media: venus: Fix NV12 decoder buffer discovery on HFI_VERSION_1XX
      i2c: qcom-cci: Fix ordering of pm_runtime_xx and i2c_add_adapter

Cezar Bulinaru (1):
      net: hv_netvsc: Fix a warning triggered by memcpy in rndis_filter

Chang S. Bae (4):
      x86/fpu: Configure init_fpstate attributes orderly
      x86/fpu: Fix the init_fpstate size check with the actual size
      x86/fpu: Exclude dynamic states from init_fpstate
      x86/fpu: Fix copy_xstate_to_uabi() to copy init states correctly

Charlotte Tan (1):
      iommu/vt-d: Allow NVS regions in arch_rmrr_sanity_check()

Chen Zhongjin (1):
      x86/unwind/orc: Fix unreliable stack dump with gcov

Christian K=C3=B6nig (2):
      drm/sched: add DRM_SCHED_FENCE_DONT_PIPELINE flag
      drm/amdgpu: use DRM_SCHED_FENCE_DONT_PIPELINE for VM updates

Christian Marangi (2):
      net: dsa: qca8k: fix inband mgmt for big-endian systems
      net: dsa: qca8k: fix ethtool autocast mib for big-endian systems

Christoph B=C3=B6hmwalder (1):
      drbd: only clone bio if we have a backing device

Christoph Hellwig (2):
      nvme: add Guenther as nvme-hwmon maintainer
      nvme-hwmon: consistently ignore errors from nvme_hwmon_init

Christophe JAILLET (3):
      media: ov8865: Fix an error handling path in ov8865_probe()
      media: sunxi: Fix some error handling path of sun8i_a83t_mipi_csi2_pr=
obe()
      media: sunxi: Fix some error handling path of sun6i_mipi_csi2_probe()

Colin Ian King (2):
      HID: lenovo: Make array tp10ubkbd_led static const
      init: Kconfig: fix spelling mistake "satify" -> "satisfy"

Damien Le Moal (6):
      ata: ahci_st: Fix compilation warning
      ata: sata_rcar: Fix compilation warning
      ata: ahci_brcm: Fix compilation warning
      ata: ahci_xgene: Fix compilation warning
      ata: ahci_imx: Fix compilation warning
      ata: ahci_qoriq: Fix compilation warning

Dan Carpenter (7):
      media: platform: mtk-mdp3: fix error code in mdp_vpu_dev_init()
      media: atomisp: prevent integer overflow in sh_css_set_black_frame()
      net/smc: Fix an error code in smc_lgr_create()
      sunhme: Uninitialized variable in happy_meal_init()
      net: dsa: uninitialized variable in dsa_slave_netdevice_event()
      nvme: fix error pointer dereference in error handling
      mailmap: update Dan Carpenter's email address

Daniel Bristot de Oliveira (1):
      rv/dot2c: Make automaton definition static

Daniel Gonz=C3=A1lez Cabanelas (1):
      media: cx88: add IR remote support for NotOnlyTV LV3H

Daniel Lundberg Pedersen (1):
      media: docs: libv4l-introduction.rst: Fix function signature and link

Daniel Wagner (1):
      nvmet: fix invalid memory reference in nvmet_subsys_attr_qid_max_show

Danijel Slivka (1):
      drm/amdgpu: set vm_update_mode=3D0 as default for Sienna Cichlid
in SRIOV case

David Gow (1):
      drm: tests: Fix a buffer overflow in format_helper_test

David Sterba (3):
      btrfs: send: update command for protocol version check
      btrfs: delete stale comments after merge conflict resolution
      MAINTAINERS: update btrfs website links and files

Dawei Li (1):
      erofs: protect s_inodes with s_inode_list_lock for fscache

Denis Nikitin (1):
      KVM: arm64: nvhe: Fix build with profile optimization

Dikshita Agarwal (1):
      media: venus : Addition of support for VIDIOC_TRY_ENCODER_CMD

Eric Dumazet (3):
      skmsg: pass gfp argument to alloc_sk_msg()
      net: hsr: avoid possible NULL deref in skb_clone()
      net: sched: fix race condition in qdisc_graft()

Eric Ren (1):
      KVM: arm64: vgic: Fix exit condition in scan_its_table()

Evan Quan (3):
      drm/amd/pm: fulfill SMU13.0.0 cstate control interface
      drm/amd/pm: fulfill SMU13.0.7 cstate control interface
      drm/amd/pm: disable cstate feature for gpu reset scenario

Fabien Parent (3):
      cpufreq: qcom: fix memory leak in error path
      cpufreq: qcom: fix writes in read-only memory region
      cpufreq: qcom: remove unused parameter in function definition

Felix Riemann (1):
      net: phy: dp83822: disable MDI crossover status change interrupt

Filipe Manana (4):
      btrfs: add missing path cache update during fiemap
      btrfs: fix processing of delayed data refs during backref walking
      btrfs: fix processing of delayed tree block refs during backref walki=
ng
      btrfs: ignore fiemap path cache if we have multiple leaves for a
data extent

GONG, Ruiqi (1):
      selinux: enable use of both GFP_KERNEL and GFP_ATOMIC in convert_cont=
ext()

Gao Xiang (2):
      erofs: shouldn't churn the mapping page for duplicated copies
      erofs: fix up inplace decompression success rate

Gavin Shan (1):
      KVM: selftests: Fix number of pages for memory slot in
memslot_modification_stress_test

Genjian Zhang (1):
      dm: remove unnecessary assignment statement in alloc_dev()

Guenter Roeck (1):
      drm/amd/display: Increase frame size limit for display_mode_vba_util_=
32.o

Guillaume Nault (1):
      netfilter: rpfilter/fib: Set ->flowic_uid correctly for user namespac=
es.

Hangyu Hua (1):
      media: meson: vdec: fix possible refcount leak in vdec_probe()

Hans Verkuil (5):
      media: s5p_cec: limit msg.len to CEC_MAX_MSG_SIZE
      media: cros-ec-cec: limit msg.len to CEC_MAX_MSG_SIZE
      media: v4l2-ctrls: drop 'elems' argument from control type ops.
      media: dvb-frontends/drxk: initialize err to 0
      media: cec: add support for Absolute Volume Control

Hans de Goede (41):
      media: atomisp-ov2680: Fix ov2680_set_fmt()
      media: atomisp-ov2680: Don't take the input_lock for try_fmt calls.
      media: atomisp-ov2680: Improve ov2680_set_fmt() error handling
      media: atomisp-notes: Add info about sensors
v4l2_get_subdev_hostdata() use
      media: atomisp: Fix VIDIOC_TRY_FMT
      media: atomisp: Make atomisp_try_fmt_cap() take padding into account
      media: atomisp: hmm_bo: Simplify alloc_private_pages()
      media: atomisp: hmm_bo: Further simplify alloc_private_pages()
      media: atomisp: hmm_bo: Rewrite alloc_private_pages() using
pages_array helper funcs
      media: atomisp: hmm_bo: Rewrite free_private_pages() using
pages_array helper funcs
      media: atomisp: hmm_bo: Drop PFN code path from alloc_user_pages()
      media: atomisp: Ensure that USERPTR pointers are page aligned
      media: atomisp: Fix device_caps reporting of the registered video-dev=
s
      media: atomisp: Remove file-injection support
      media: atomisp: Remove atomisp_file_fops and atomisp_file_ioctl_ops
      media: atomisp: Remove the outq videobuf queue
      media: atomisp: Remove never set file_input flag
      media: atomisp: Remove the ACC device node
      media: atomisp: Remove some further ATOMISP_ACC_* related dead code
      media: atomisp: Remove empty
atomisp_css_set_cont_prev_start_time() function
      media: atomisp: Split subdev and video-node registration into 2 steps
      media: atomisp: Register /dev/* nodes at the end of atomisp_pci_probe=
()
      media: atomisp: Remove loading mutex
      media: atomisp: Fix v4l2_fh resource leak on open errors
      media: atomisp: Simplify v4l2_fh_open() error handling
      media: atomisp: Use a normal mutex for the main lock
      media: atomisp: Remove unused lock member from struct atomisp_sub_dev=
ice
      media: atomisp: Fix locking around asd->streaming read/write
      media: atomisp: Remove asd =3D=3D NULL checks from ioctl handling
      media: atomisp: Add atomisp_pipe_check() helper
      media: atomisp: Remove watchdog timer
      media: atomisp: Move atomisp_streaming_count() check into
__atomisp_css_recover()
      media: atomisp: Rework asd->streaming state update in
__atomisp_streamoff()
      media: atomisp: Drop streamoff_mutex
      media: atomisp: Use video_dev.lock for ioctl locking
      media: atomisp: Remove a couple of not useful function wrappers
      media: atomisp: Drop unnecessary first_streamoff check
      media: atomisp: Make atomisp_set_raw_buffer_bitmap() static
      media: atomisp: Remove unused atomisp_css_get_dis_statistics()
      media: atomisp: Remove const/fixed camera_caps
      media: atomisp: Remove atomisp_source_pad_to_stream_id()

Harini Katakam (1):
      net: phy: dp83867: Extend RX strap quirk for SGMII mode

Harshit Mogalapalli (1):
      io_uring/msg_ring: Fix NULL pointer dereference in io_msg_send_fd()

Hugh Dickins (1):
      mm: /proc/pid/smaps_rollup: fix maple tree search

Jacopo Mondi (1):
      media: mc: entity: Add iterator helper for entity pads

Jakub Kicinski (3):
      tls: strp: make sure the TCP skbs do not have overlapping data
      Revert "net: fix cpu_max_bits_warn() usage in netif_attrmask_next{,_a=
nd}"
      genetlink: fix kdoc warnings

Jan Sokolowski (1):
      i40e: Fix DMA mappings leak

Jason A. Donenfeld (2):
      hwrng: bcm2835 - use hwrng_msleep() instead of cpu_relax()
      Revert "mfd: syscon: Remove repetition of the regmap_get_val_endian()=
"

Jean-Michel Hautbois (1):
      media: staging: ipu3-imgu: Fix BNR wb gain documentation

Jeff Layton (1):
      nfsd: ensure we always call fh_verify_error tracepoint

Jens Axboe (1):
      io_uring/rw: remove leftover debug statement

Jerry Snitselaar (1):
      iommu/vt-d: Clean up si_domain in the init_dmars() error path

Jiangshan Yi (2):
      dm raid: fix typo in analyse_superblocks code comment
      i2c: fix spelling typos in comments

Jiapeng Chong (1):
      net: ethernet: mediatek: ppe: Remove the unused function
mtk_foe_entry_usable()

Jilin Yuan (4):
      media: usb/msi2500: fix repeated words in comments
      media: usb/dvb-usb-v2: fix repeated words in comments
      media: pci/cx18: fix repeated words in comments
      dm raid: delete the redundant word 'that' in comment

Jiri Slaby (SUSE) (2):
      ACPI: resource: do IRQ override on LENOVO IdeaPad
      ACPI: resource: note more about IRQ override

Jon Hunter (2):
      Revert "PCI: tegra: Use PCI_CONF1_EXT_ADDRESS() macro"
      cpufreq: tegra194: Fix module loading

Jonathan Cooper (1):
      sfc: Change VF mac via PF as first preference if available.

Josef Bacik (1):
      btrfs: unlock locked extent area if we have contention

Joseph Qi (2):
      ocfs2: fix BUG when iput after ocfs2_mknod fails
      ocfs2: clear dinode links count in case of error

Jos=C3=A9 Exp=C3=B3sito (1):
      HID: magicmouse: Do not set BTN_MOUSE on double report

Kai-Heng Feng (1):
      ata: ahci: Match EM_MAX_SLOTS with SATA_PMP_MAX_PORTS

Kees Cook (1):
      sched: Introduce struct balance_callback to avoid CFI mismatches

Kenneth Feng (5):
      drm/amd/pm: temporarily disable thermal alert on smu_v13_0_10
      drm/amd/pm: remove the pptable id override on smu_v13_0_10
      drm/amd/amdgpu: enable gfx clock gating features on smu_v13_0_10
      drm/amd/pm: skip loading pptable from driver on secure board for
smu_v13_0_10
      drm/amd/pm: enable thermal alert on smu_v13_0_10

Kishon Vijay Abraham I (2):
      MAINTAINERS: Add Vignesh Raghavendra as maintainer of TI
DRA7XX/J721E PCI driver
      MAINTAINERS: Update Kishon's email address in PCI endpoint subsystem

Krzysztof Kozlowski (3):
      media: dt-bindings: dongwoon,dw9714: convert to dtschema
      media: dt-bindings: media: samsung,exynos5250-gsc: convert to dtschem=
a
      MAINTAINERS: nfc: s3fwrn5: Drop Krzysztof Opasiak

Kuniyuki Iwashima (1):
      udp: Update reuse->has_conns under reuseport_lock.

Laurent Pinchart (22):
      media: rockchip: rkisp1: Set DPCC methods enable bits inside loop
      media: rockchip: rkisp1: Mask invalid bits in DPCC parameters
      media: rockchip: rkisp1: Define macros for DPCC configurations in UAP=
I
      media: rkisp1: Initialize color space on ISP sink and source pads
      media: rkisp1: Allow setting color space on ISP sink pad
      media: rkisp1: Fix source pad format configuration
      media: rkisp1: Allow setting all color space fields on ISP source pad
      media: rkisp1: Configure quantization using ISP source pad
      media: rkisp1: Don't pass the quantization to rkisp1_csm_config()
      media: rkisp1: Configure CSM based on YCbCr encoding
      media: rkisp1: Initialize color space on resizer sink and source pads
      media: rkisp1: Allow setting color space on resizer sink pad
      media: rkisp1: Clean up LSC configuration code
      media: rkisp1: Store LSC register values in u32 variables
      media: rkisp1: Simplify LSC x/y size and grad register macros
      media: rkisp1: Use correct macro for gradient registers
      media: rkisp1: Configure LSC after enabling the ISP
      media: rkisp1: Zero v4l2_subdev_format fields in when validating link=
s
      media: mc: entity: Merge media_entity_enum_init and
__media_entity_enum_init
      media: mc: entity: Move media_entity_get_fwnode_pad() out of
graph walk section
      media: mc: entity: Add media_entity_pipeline() to access the
media pipeline
      media: mc: entity: Rewrite media_pipeline_start()

Liam Howlett (2):
      mm/mempolicy: fix mbind_range() arguments to vma_merge()
      mm/mmap: fix MAP_FIXED address return on VMA merge

Liam R. Howlett (1):
      mm/page_alloc: reduce potential fragmentation in make_alloc_exact()

Likun Gao (1):
      drm/amdgpu: skip mes self test for gc 11.0.3

Lin Shengwang (1):
      sched/core: Fix comparison in sched_group_cookie_match()

Linus Torvalds (2):
      kernel/utsname_sysctl.c: Fix hostname polling
      Linux 6.1-rc2

Linus Walleij (2):
      media: i2c: isl7998x: Use right include
      media: si4713: Use the right include

Lu Baolu (2):
      iommu: Add gfp parameter to iommu_alloc_resv_region
      iommu/vt-d: Use rcu_lock in get_resv_regions

Lukas Bulwahn (3):
      media: remove reference to CONFIG_EMBEDDED in MEDIA_SUPPORT_FILTER
      media: MAINTAINERS: adjust entry to zoran driver movement
      media: MAINTAINERS: rectify entry in SAA7146 VIDEO4LINUX-2 DRIVER

Manank Patel (1):
      ethernet: marvell: octeontx2 Fix resource not freed after malloc

Marco Elver (1):
      selftests/perf_events: Add a SIGTRAP stress test with disables

Mark Tomlinson (1):
      tipc: Fix recognition of trial period

Martin Liska (1):
      gcov: support GCC 12.1 and newer compilers

Martin T=C5=AFma (1):
      i2c: xiic: Add platform module alias

Matthias Schiffer (1):
      hwmon: (pwm-fan) Explicitly switch off fan power when setting
pwm1_enable to 0

Mauro Carvalho Chehab (1):
      media: atomisp: don't store an unused sink data on a var

Maxim Levitsky (1):
      perf/x86/intel/lbr: Use setup_clear_cpu_cap() instead of clear_cpu_ca=
p()

Maxime Ripard (4):
      drm/vc4: Add module dependency on hdmi-codec
      drm/vc4: hdmi: Enforce the minimum rate at runtime_resume
      drm/vc4: hdmi: Check the HSM rate at runtime_resume
      drm/connector: Set DDC pointer in drmm_connector_init

Mel Gorman (1):
      mm/huge_memory: do not clobber swp_entry_t during THP split

Michal Koutn=C3=BD (1):
      cgroup: Reorganize css_set_lock and kernfs path processing

Mike Kravetz (2):
      mm/mmap: undo ->mmap() when mas_preallocate() fails
      hugetlb: fix memory leak associated with vma_lock structure

Mikulas Patocka (2):
      dm bufio: use the acquire memory barrier when testing for B_READING
      dm: change from DMWARN to DMERR or DMCRIT for fatal errors

Milan Broz (1):
      dm verity: Add documentation for try_verify_in_tasklet option

Ming Qian (1):
      media: amphion: release m2m ctx when releasing vpu instance

Moudy Ho (1):
      media: platform: mtk-mdp3: add pointer checks and use devm_kfree

Namhyung Kim (1):
      perf stat: Support old kernels for bperf cgroup counting

Nathan Chancellor (2):
      x86/Kconfig: Drop check for -mabi=3Dms for CONFIG_EFI_STUB
      drm/amdkfd: Fix type of reset_type parameter in hqd_destroy() callbac=
k

Nathan Huckleberry (1):
      dm verity: enable WQ_HIGHPRI on verify_wq

Nikos Tsironis (1):
      dm clone: Fix typo in block_device format specifier

Oleksandr Tyshchenko (2):
      xen/virtio: Handle cases when page offset > PAGE_SIZE properly
      xen/virtio: Convert PAGE_SIZE/PAGE_SHIFT/PFN_UP to Xen counterparts

Oliver Upton (2):
      KVM: arm64: Work out supported block level at compile time
      KVM: arm64: Limit stage2_apply_range() batch size to largest block

Pablo Neira Ayuso (1):
      netfilter: nf_tables: relax NFTA_SET_ELEM_KEY_END set flags requireme=
nts

Palmer Dabbelt (1):
      MAINTAINERS: git://github -> https://github.com for petkan

Paolo Bonzini (1):
      tools: include: sync include/api/linux/kvm.h

Paul Blakey (2):
      net: Fix return value of qdisc ingress handling on success
      selftests: add selftest for chaining of tc ingress handling to egress

Paul Elder (1):
      media: ov5640: Use runtime PM

Paul Kocialkowski (22):
      media: sun6i-mipi-csi2: Add a Kconfig dependency on RESET_CONTROLLER
      media: sun8i-a83t-mipi-csi2: Add a Kconfig dependency on RESET_CONTRO=
LLER
      media: sun6i-csi: Add a Kconfig dependency on RESET_CONTROLLER
      media: sun4i-csi: Add a Kconfig dependency on RESET_CONTROLLER
      media: sun8i-di: Add a Kconfig dependency on RESET_CONTROLLER
      media: sun8i-rotate: Add a Kconfig dependency on RESET_CONTROLLER
      media: cedrus: Add a Kconfig dependency on RESET_CONTROLLER
      media: sun6i-csi: Define and use driver name and (reworked) descripti=
on
      media: sun6i-csi: Refactor main driver data structures
      media: sun6i-csi: Tidy up platform code
      media: sun6i-csi: Always set exclusive module clock rate
      media: sun6i-csi: Define and use variant to get module clock rate
      media: sun6i-csi: Use runtime pm for clocks and reset
      media: sun6i-csi: Tidy up Kconfig
      media: sun6i-csi: Tidy up v4l2 code
      media: sun6i-csi: Tidy up video code
      media: sun6i-csi: Pass and store csi device directly in video code
      media: sun6i-csi: Register the media device after creation
      media: sun6i-csi: Remove controls handler from the driver
      media: sun6i-csi: Add media ops with link notify callback
      media: sun6i-csi: Introduce and use video helper functions
      media: sun6i-csi: Move csi buffer definition to main header file

Paulo Alcantara (1):
      cifs: fix memory leaks in session setup

Pavel Begunkov (8):
      io_uring: remove FFS_SCM
      io_uring: kill hot path fixed file bitmap debug checks
      io_uring: reuse io_alloc_req()
      io_uring: don't iopoll from io_ring_ctx_wait_and_kill()
      bio: safeguard REQ_ALLOC_CACHE bio put
      net: flag sockets supporting msghdr originated zerocopy
      io_uring/net: fail zc send when unsupported by socket
      io_uring/net: fail zc sendmsg when unsupported by socket

Peter Zijlstra (3):
      perf: Fix missing SIGTRAPs
      x86/ftrace: Remove ftrace_epilogue()
      ftrace,kcfi: Separate ftrace_stub() and ftrace_stub_graph()

Philipp Zabel (1):
      media: coda: jpeg: drop coda9_jpeg_dec_huff_setup() return value

Pieter Jansen van Vuuren (1):
      sfc: include vport_id in filter spec hash and equal()

Qais Yousef (1):
      mailmap: update email for Qais Yousef

Rafael J. Wysocki (2):
      thermal: intel_powerclamp: Use first online CPU as control_cpu
      ACPI: PCI: Fix device reference counting in acpi_get_pci_dev()

Rafael Mendonca (2):
      scsi: lpfc: Fix memory leak in lpfc_create_port()
      io-wq: Fix memory leak in worker creation

Rik van Riel (1):
      mm,hugetlb: take hugetlb_lock before decrementing h->resv_huge_pages

Robin Murphy (1):
      ACPI: scan: Fix DMA range assignment

Roderick Colenbrander (3):
      HID: playstation: stop DualSense output work on remove.
      HID: playstation: add initial DualSense Edge controller support
      HID: playstation: support updated DualSense rumble mode.

Ronnie Sahlberg (2):
      cifs: set rc to -ENOENT if we can not get a dentry for the cached dir
      cifs: drop the lease for cached directories on rmdir or rename

Rory Liu (1):
      media: platform: cros-ec: Add Kuldax to the match table

Russell King (Oracle) (1):
      nvme-apple: don't limit DMA segement size

Sagi Grimberg (1):
      nvmet: fix workqueue MEM_RECLAIM flushing dependency

Sakari Ailus (6):
      media: ar0521: Remove redundant variable ret
      media: ipu3-imgu: Fix NULL pointer dereference in active selection ac=
cess
      media: v4l: subdev: Fail graciously when getting try data for NULL st=
ate
      media: ar0521: Fix return value check in writing initial registers
      media: sun6i-mipi-csi2: Depend on PHY_SUN6I_MIPI_DPHY
      media: Remove incorrect comment from struct v4l2_fwnode_endpoint

Samuel Bailey (1):
      HID: saitek: add madcatz variant of MMO7 mouse device ID

Sean Young (1):
      media: mceusb: set timeout to at least timeout provided

Serge Semin (1):
      nvme-hwmon: kmalloc the NVME SMART log buffer

Shaomin Deng (1):
      dm cache: delete the redundant word 'each' in comment

Shenwei Wang (2):
      net: phylink: add mac_managed_pm in phylink_config structure
      net: stmmac: Enable mac_managed_pm phylink config

Slark Xiao (1):
      media: i2c: mt9v111: Fix typo 'the the' in comment

Stanimir Varbanov (4):
      media: venus : Add default values for the control
      media: venus : CAPTURE Plane width/height alignment with OUT plane.
      media: venus: venc_ctrls: Add default value for CLL info
      media: venus: venc: Set HDR10 PQ SEI property only for MAIN10 profile

Steve French (2):
      smb3: interface count displayed incorrectly
      cifs: update internal module number

Steven Price (2):
      drm/panfrost: Remove type name from internal structs
      drm/panfrost: replace endian-specific types with native ones

Sumanth Korikkar (1):
      bpf: Fix sample_flags for bpf_perf_event_output

Sun Ke (1):
      media: platform: mtk-mdp3: fix PM reference leak in mdp_comp_clock_on=
()

Tejun Heo (2):
      Revert "cgroup: enable cgroup_get_from_file() on cgroup1"
      blkcg: Update MAINTAINERS entry

Tetsuo Handa (1):
      NFSD: unregister shrinker when nfsd_init_net() fails

Tim Huang (2):
      drm/amd/pm: update SMU IP v13.0.4 driver interface version
      drm/amd/pm: add SMU IP v13.0.4 IF version define to V7

Tomi Valkeinen (11):
      media: Documentation: mc: add definitions for stream and pipeline
      media: media-entity.h: add include for min()
      media: subdev: increase V4L2_FRAME_DESC_ENTRY_MAX to 8
      media: mc: entity: Rename streaming_count -> start_count
      media: v4l2-dev: Add videodev wrappers for media pipelines
      media: drivers: use video device pipeline start/stop
      media: drivers: use video_device_pipeline()
      media: mc: entity: add alloc variant of pipeline_start
      media: drivers: use video_device_pipeline_alloc_start()
      media: mc: entity: Add has_pad_interdep entity operation
      media: mc: convert pipeline funcs to take media_pad

Tony Luck (1):
      ACPI: extlog: Handle multiple records

Uday Shankar (1):
      scsi: core: Restrict legal sdev_state transitions via sysfs

Uwe Kleine-K=C3=B6nig (1):
      watchdog: Add tracing events for the most usual watchdog events

Victor Zhao (3):
      Revert "drm/amdgpu: add debugfs amdgpu_reset_level"
      Revert "drm/amdgpu: let mode2 reset fallback to default when failure"
      drm/amdgpu: Refactor mode2 reset logic for v11.0.7

Vikas Gupta (1):
      bnxt_en: fix memory leak in bnxt_nvm_test()

Vikash Garodia (1):
      media: venus : Allow MIN/MAX settings for the v4l2 encoder
controls defined range.

Vincent Donnefort (1):
      KVM: arm64: Enable stack protection and branch profiling for VHE

Viswanath Boma (3):
      media: venus : Addition of control support -
V4L2_CID_MIN_BUFFERS_FOR_OUTPUT
      media: venus : Addition of EOS Event support for Encoder
      media: venus : Remove the capture plane settings for
venc_g_parm/venc_s_parm

Wilken Gottwalt (2):
      hwmon: (corsair-psu) fix typo in USB id description
      hwmon: (corsair-psu) Add USB id of the new HX1500i psu

Xander Li (1):
      nvme-pci: disable write zeroes on various Kingston SSD

Xiaobo Liu (1):
      net/atm: fix proc_mpc_write incorrect return value

Yang Yingliang (11):
      media: ar0521: fix error return code in ar0521_power_on()
      net: ethernet: mtk_eth_soc: fix possible memory leak in mtk_probe()
      net: ethernet: mtk_eth_wed: add missing put_device() in mtk_wed_add_h=
w()
      net: ethernet: mtk_eth_wed: add missing of_node_put()
      cpufreq: dt: Switch to use dev_err_probe() helper
      cpufreq: imx6q: Switch to use dev_err_probe() helper
      cpufreq: qcom-nvmem: Switch to use dev_err_probe() helper
      cpufreq: sun50i: Switch to use dev_err_probe() helper
      cifs: use LIST_HEAD() and list_move() to simplify code
      wwan_hwsim: fix possible memory leak in wwan_hwsim_dev_new()
      net: hns: fix possible memory leak in hnae_ae_register()

Ye Bin (3):
      blktrace: introduce 'blk_trace_{start,stop}' helper
      blktrace: fix possible memleak in '__blk_trace_remove'
      blktrace: remove unnessary stop block trace in 'blk_trace_shutdown'

YiPeng Chai (3):
      drm/amdgpu: Enable gmc soft reset on gmc_v11_0_3
      drm/amdgpu: Enable ras support for mp0 v13_0_0 and v13_0_10
      drm/amdgpu: Add sriov vf ras support in amdgpu_ras_asic_supported

Yifan Zha (1):
      drm/amdgpu: Program GC registers through RLCG interface in gfx_v11/gm=
c_v11

Yosry Ahmed (3):
      cgroup: add cgroup_v1v2_get_from_[fd/file]()
      bpf: cgroup_iter: support cgroup1 using cgroup fd
      mm: cgroup: fix comments for get from fd/file helpers

Yu Kuai (1):
      blk-mq: fix null pointer dereference in blk_mq_clear_rq_mapping()

YuBiao Wang (1):
      drm/amdgpu: dequeue mes scheduler during fini

Yue Hu (1):
      erofs: fix illegal unmapped accesses in z_erofs_fill_inode_lazy()

Yushan Zhou (1):
      ublk_drv: use flexible-array member instead of zero-length array

Yuwei Guan (1):
      block, bfq: remove unused variable for bfq_queue

Zenghui Yu (1):
      KVM: arm64: selftests: Fix multiple versions of GIC creation

Zhang Rui (3):
      hwmon/coretemp: Handle large core ID value
      x86/topology: Fix multiple packages shown on a single-package system
      x86/topology: Fix duplicated core ID within a package

Zhang Xiaoxu (6):
      cifs: Fix xid leak in cifs_create()
      cifs: Fix xid leak in cifs_copy_file_range()
      cifs: Fix xid leak in cifs_flock()
      cifs: Fix xid leak in cifs_ses_add_channel()
      cifs: Fix xid leak in cifs_get_file_info_unix()
      cifs: Fix memory leak when build ntlmssp negotiate blob failed

ZhenGuo Yin (1):
      drm/amd/pm: Init pm_attr_list when dpm is disabled

Zhengchao Shao (4):
      ip6mr: fix UAF issue in ip6mr_sk_done() when addrconf_init_net() fail=
ed
      net: sched: cake: fix null pointer access issue when cake_init() fail=
s
      Revert "net: sched: fq_codel: remove redundant resource cleanup
in fq_codel_init()"
      net: sched: sfb: fix null pointer access issue when sfb_init() fails

ZiyangZhang (1):
      Documentation: document ublk user recovery feature

ye xingchen (4):
      media: imon: Remove the unneeded result variable
      media: radio-si476x: Remove the unneeded result variable
      media: tuners: Remove the unneeded result variable
      media: venus: hfi: Remove the unneeded result variable

zhangxiangqian (1):
      net: macvlan: change schedule system_wq to system_unbound_wq
