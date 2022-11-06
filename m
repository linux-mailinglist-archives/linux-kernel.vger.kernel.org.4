Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35BA61E791
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 00:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiKFX10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 18:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiKFX1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 18:27:23 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5851A64E6
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 15:27:21 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id x13so7100148qvn.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 15:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wwwOtZENQ61MbQDfZNAvo1bpsuWMjYICxiCtOpw4ENI=;
        b=PRFutQeoLXM3WV0teToFuRcYqWF+KDDHOzUmDPOuL11JUFklfOEL4fDEYidGOP6q2v
         ZIDQZHbLpcMAt2u7GdpYpBaN+mW/tV7oO2PVuOY5wfKZGILvCpfSx4FMA8xkt4Ke4Uhx
         gZ0p/0XnhRvG3osoZbRfjiu6mTcEyXh2xRt7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwwOtZENQ61MbQDfZNAvo1bpsuWMjYICxiCtOpw4ENI=;
        b=YpZstppRxJhrxSwp5sA/a/gxp9QY8WW8JBPPX9qIk8S/Npo69Yk+hZkooTC8j9xK7n
         MuC5MVAkqPz2H1wKP1MI2IV5fIcnrIG0+EF5FCUAuXpyLp9zZFo5/iH6k1/c8umVTDE9
         z5k5l0ZQZhT6yh5nrCYybTfSTgwmW+yu3u49e6tl1j2B7ZOvyclNVIMURSgw3Cbdv6Tv
         T30nEne3lsIrBiEAsM5MrQ24uHw0+RiCyHlpVdXaFRCpqPV2b74xffv0qBDQzL5yv3Ni
         1ktvC1qJ0v5cWh8lsJwsyBobr5aUT6Wat8Md1rLwG5AAdu3VfY9ArE3dP01DNi9JP0iZ
         1HMQ==
X-Gm-Message-State: ACrzQf2El07htXO7GOTlVfiCh+K82o8ggumSM+hFVpsOqDkGpvYXrzja
        0d+k0+sijUi5qmbQHn6XiO2cakx2v4dL/A==
X-Google-Smtp-Source: AMsMyM5/gNcSTzMqZLDSNZ5kLIAtUUXpuBctHYUrMsH1VspFXQjK5gTLU5z2E5NnJjWagSH2sIBn0Q==
X-Received: by 2002:ad4:5dcd:0:b0:4bb:f9ff:fb73 with SMTP id m13-20020ad45dcd000000b004bbf9fffb73mr34528139qvh.76.1667777239825;
        Sun, 06 Nov 2022 15:27:19 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id cj25-20020a05622a259900b003a4c3c4d2d4sm4838023qtb.49.2022.11.06.15.27.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 15:27:19 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-36cbcda2157so89808277b3.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 15:27:19 -0800 (PST)
X-Received: by 2002:a81:114e:0:b0:36a:fc80:fa62 with SMTP id
 75-20020a81114e000000b0036afc80fa62mr46237865ywr.58.1667777238398; Sun, 06
 Nov 2022 15:27:18 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Nov 2022 15:27:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=whdSr755Jz=w9Kx7XZqsKFATFK5HXzk=XKd=Hf9D6K_=Q@mail.gmail.com>
Message-ID: <CAHk-=whdSr755Jz=w9Kx7XZqsKFATFK5HXzk=XKd=Hf9D6K_=Q@mail.gmail.com>
Subject: Linux 6.1-rc4
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

So as hoped for (and expected), things seem to be starting to calm
down, and rc4 is a pretty normal size for this stage in the process.

The diffstat looks fairly normal too - mostly nice and flat (so small
changes spread out), with a spike for a FW update for drm/amdkfd. The
other thing that stands out is some stricter xfs refcount checking and
related fixes (. And some new clx tests. But even those aren't huge,
they just do show up in the stats.

The shortlog (appended) doesn't look scary either. It's all the usual
stuff - drivers, filesystems, architecture updates, some networking,
and random small things elsewhere.

So hey, please jump right in, the water is fine. But more testing
always appreciated,

                    Linus

---

Akira Yokosawa (1):
      docs/process/howto: Replace C89 with C11

Al Viro (1):
      block: blk_add_rq_to_plug(): clear stale 'last' after flush

Alexandru Tachici (1):
      net: ethernet: adi: adin1110: Fix notifiers

Allison Henderson (1):
      xfs: increase rename inode reservation

Alvin Lee (1):
      drm/amd/display: Enable timing sync on DCN32

Amit Daniel Kachhap (1):
      arm64: cpufeature: Fix the visibility of compat hwcaps

Andreas Schwab (2):
      asm-generic: compat: fix compat_arg_u64() and compat_arg_u64_dual()
      powerpc/32: fix syscall wrappers with 64-bit arguments

Ard Biesheuvel (4):
      efi: random: reduce seed size to 32 bytes
      efi: random: Use 'ACPI reclaim' memory for random seed
      efi: efivars: Fix variable writes with unsupported query_variable_sto=
re()
      arm64: efi: Recover from synchronous exceptions occurring in firmware

Aurelien Jarno (1):
      drm/rockchip: dw_hdmi: filter regulator -EPROBE_DEFER error messages

Ben Gardon (1):
      KVM: x86: Use SRCU to protect zap in __kvm_set_or_clear_apicv_inhibit=
()

Benjamin Coddington (2):
      NFSv4: Retry LOCK on OLD_STATEID during delegation return
      NFSv4.2: Fixup CLONE dest file size for zero-length count

BingJing Chang (1):
      btrfs: send: fix send failure of a subcase of orphan inodes

Brian Norris (2):
      drm/rockchip: dsi: Clean up 'usage_mode' when failing to attach
      drm/rockchip: dsi: Force synchronous probe

Chen Jun (1):
      blk-mq: Fix kmemleak in blk_mq_init_allocated_queue

Chen Zhongjin (7):
      net: dsa: Fix possible memory leaks in dsa_loop_init()
      RDMA/core: Fix null-ptr-deref in ib_core_cleanup()
      block: Fix possible memory leak for rq_wb on add_disk failure
      i2c: piix4: Fix adapter not be removed in piix4_remove()
      netfilter: nf_nat: Fix possible memory leak in nf_nat_init()
      net/smc: Fix possible leaked pernet namespace in smc_init()
      net, neigh: Fix null-ptr-deref in neigh_table_clear()

ChenXiaoSong (1):
      cifs: fix use-after-free on the link name

Christophe JAILLET (3):
      soc: imx: imx93-pd: Fix the error handling path of imx93_pd_probe()
      btrfs: fix a memory allocation failure test in btrfs_submit_direct
      sfc: Fix an error handling path in efx_pci_probe()

Chuck Lever (1):
      SUNRPC: Fix crasher in gss_unwrap_resp_integ()

Colin Ian King (1):
      xfs: remove redundant pointer lip

Conor Dooley (1):
      clk: sifive: select by default if SOC_SIFIVE

Cristian Marussi (8):
      firmware: arm_scmi: Cleanup the core driver removal callback
      firmware: arm_scmi: Suppress the driver's bind attributes
      firmware: arm_scmi: Make tx_prepare time out eventually
      firmware: arm_scmi: Make Rx chan_setup fail on memory errors
      firmware: arm_scmi: Fix devres allocation device in virtio transport
      firmware: arm_scmi: Fix deferred_tx_wq release on error paths
      arm64: dts: juno: Add thermal critical trip points
      hwmon: (scmi) Register explicitly with Thermal Framework

Dan Carpenter (2):
      RDMA/qedr: clean up work queue on failure in qedr_alloc_resources()
      net: sched: Fix use after free in red_enqueue()

Dan Li (1):
      Documentation: kbuild: Add description of git for reproducible builds

Dan Williams (8):
      ACPI: NUMA: Add CXL CFMWS 'nodes' to the possible nodes set
      cxl/region: Fix region HPA ordering validation
      cxl/region: Fix cxl_region leak, cleanup targets at region delete
      cxl/pmem: Fix cxl_pmem_region and cxl_memdev leak
      tools/testing/cxl: Fix some error exits
      tools/testing/cxl: Add a single-port host-bridge regression config
      cxl/region: Fix 'distance' calculation with passthrough ports
      cxl/region: Recycle region ids

Darrick J. Wong (23):
      xfs: avoid a UAF when log intent item recovery fails
      xfs: fix incorrect return type for fsdax fault handlers
      xfs: fix validation in attr log item recovery
      xfs: fix memcpy fortify errors in BUI log format copying
      xfs: fix memcpy fortify errors in CUI log format copying
      xfs: fix memcpy fortify errors in RUI log format copying
      xfs: make sure aglen never goes negative in xfs_refcount_adjust_exten=
ts
      xfs: fix memcpy fortify errors in EFI log format copying
      xfs: create a predicate to verify per-AG extents
      xfs: refactor all the EFI/EFD log item sizeof logic
      xfs: check deferred refcount op continuation parameters
      xfs: actually abort log recovery on corrupt intent-done log items
      xfs: move _irec structs to xfs_types.h
      xfs: dump corrupt recovered log intent items to dmesg consistently
      xfs: refactor refcount record usage in xchk_refcountbt_rec
      xfs: track cow/shared record domains explicitly in xfs_refcount_irec
      xfs: report refcount domain in tracepoints
      xfs: refactor domain and refcount checking
      xfs: remove XFS_FIND_RCEXT_SHARED and _COW
      xfs: check record domain when accessing refcount records
      xfs: fix agblocks check in the cow leftover recovery function
      xfs: fix uninitialized list head in struct xfs_refcount_recovery
      xfs: rename XFS_REFC_COW_START to _COWFLAG

Dave Hansen (1):
      x86/tdx: Prepare for using "INFO" call for a second purpose

David Gow (1):
      perf/hw_breakpoint: test: Skip the test if dependencies unmet

David Sterba (2):
      btrfs: reorder btrfs_bio for better packing
      btrfs: fix type of parameter generation in btrfs_get_dentry

Dean Luick (1):
      IB/hfi1: Correctly move list in sc_disable()

Dexuan Cui (2):
      vsock: remove the unused 'wait' in vsock_connectible_recvmsg()
      vsock: fix possible infinite sleep in vsock_connectible_wait_data()

Dillon Varone (2):
      drm/amd/display: Update latencies on DCN321
      drm/amd/display: Set memclk levels to be at least 1 for dcn32

Eiichi Tsukata (1):
      KVM: x86/xen: Fix eventfd error handling in kvm_xen_eventfd_assign()

Emanuele Giuseppe Esposito (1):
      KVM: VMX: fully disable SGX if SECONDARY_EXEC_ENCLS_EXITING unavailab=
le

Fangzhi Zuo (1):
      drm/amd/display: Ignore Cable ID Feature

Filipe Manana (7):
      btrfs: fix lost file sync on direct IO write with nowait and dsync io=
cb
      btrfs: fix inode list leak during backref walking at
resolve_indirect_refs()
      btrfs: fix inode list leak during backref walking at find_parent_node=
s()
      btrfs: fix ulist leaks in error paths of qgroup self tests
      btrfs: remove pointless and double ulist frees in error paths of
qgroup tests
      btrfs: fix nowait buffered write returning -ENOSPC
      btrfs: fix inode reserve space leak due to nowait buffered write

Florian Westphal (1):
      netlink: introduce bigendian integer types

Gaosheng Cui (2):
      capabilities: fix potential memleak on error path from
vfs_getxattr_alloc()
      net: mdio: fix undefined behavior in bit shift for __mdiobus_register

Gavin Shan (1):
      KVM: Check KVM_CAP_DIRTY_LOG_{RING, RING_ACQ_REL} prior to enabling t=
hem

Gavin Wan (1):
      drm/amdgpu: Disable GPU reset on SRIOV before remove pci.

Geert Uytterhoeven (2):
      clk: renesas: r8a779g0: Add SASYNCPER clocks
      clk: renesas: r8a779g0: Fix HSCIF parent clocks

George Shen (4):
      drm/amd/display: Fix DCN32 DSC delay calculation
      drm/amd/display: Use forced DSC bpp in DML
      drm/amd/display: Round up DST_after_scaler to nearest int
      drm/amd/display: Add DSC delay factor workaround

Govindarajulu Varadarajan (1):
      enic: MAINTAINERS: Update enic maintainers

Graham Sider (2):
      drm/amdgpu: correct MES debugfs versions
      drm/amdgpu: disable GFXOFF during compute for GFX11

Guenter Roeck (1):
      Revert "hwmon: (pmbus) Add regulator supply into macro"

Guo Xuenan (1):
      xfs: fix exception caused by unexpected illegal bestcount in leaf dir

Hawkins Jiawei (1):
      Bluetooth: L2CAP: Fix memory leak in vhci_write

Hector Martin (1):
      drm/format-helper: Only advertise supported formats for conversion

Helge Deller (5):
      parisc: Make 8250_gsc driver dependend on CONFIG_PARISC
      parisc/serial: Rename 8250_gsc.c to 8250_parisc.c
      parisc: Use signed char for hardware path in pdc.h
      parisc: Export iosapic_serial_irq() symbol for serial port driver
      parisc: Avoid printing the hardware path twice

Horatiu Vultur (4):
      net: lan966x: Fix the MTU calculation
      net: lan966x: Adjust maximum frame size when vlan is enabled/disabled
      net: lan966x: Fix FDMA when MTU is changed
      net: lan966x: Fix unmapping of received frames using FDMA

Hou Wenlong (2):
      KVM: x86: Reduce refcount if single_open() fails in
kvm_mmu_rmaps_stat_open()
      KVM: debugfs: Return retval of simple_attr_open() if it fails

H=C3=A5kon Bugge (1):
      RDMA/cma: Use output interface for net_dev check

Ido Schimmel (1):
      bridge: Fix flushing of dynamic FDB entries

Imre Deak (1):
      drm/i915/tgl+: Add locking around DKL PHY register accesses

Ioana Ciornei (3):
      arm64: dts: lx2160a: specify clock frequencies for the MDIO controlle=
rs
      arm64: dts: ls1088a: specify clock frequencies for the MDIO controlle=
rs
      arm64: dts: ls208xa: specify clock frequencies for the MDIO controlle=
rs

Jakub Kicinski (2):
      netlink: hide validation union fields from kdoc
      net: openvswitch: add missing .resv_start_op

Jason A. Donenfeld (1):
      ipvs: use explicitly signed chars

Jason Yan (1):
      ext4: fix wrong return err in ext4_load_and_init_journal()

Jay Cornwall (1):
      drm/amdkfd: update GFX11 CWSR trap handler

Jay Fang (1):
      MAINTAINERS: Update HiSilicon LPC BUS Driver maintainer

Jeff Layton (1):
      nfsd: fix net-namespace logic in __nfsd_file_cache_purge

Jerry Snitselaar (1):
      efi/tpm: Pass correct address to memblock_reserve

Jiangshan Yi (1):
      watchdog: sp805_wdt: fix spelling typo in comment

Jim Mattson (5):
      KVM: x86: Mask off reserved bits in CPUID.80000001H
      KVM: x86: Mask off reserved bits in CPUID.80000006H
      KVM: x86: Mask off reserved bits in CPUID.80000008H
      KVM: x86: Mask off reserved bits in CPUID.8000001AH
      KVM: x86: Mask off reserved bits in CPUID.8000001FH

Jiri Olsa (1):
      x86/syscall: Include asm/ptrace.h in syscall_wrapper header

John Keeping (1):
      drm/rockchip: fix fbdev on non-IOMMU devices

Jonathan Cameron (3):
      cxl/mbox: Add a check on input payload size
      cxl/region: Fix null pointer dereference due to pass through
decoder commit
      cxl/pmem: Fix failure to account for 8 byte header for writes to
the device LSA.

Josef Bacik (1):
      btrfs: fix tree mod log mishandling of reallocated nodes

Jozsef Kadlecsik (1):
      netfilter: ipset: enforce documented limit to prevent allocating
huge memory

Juergen Gross (2):
      x86/xen: silence smatch warning in pmu_msr_chk_emulated()
      x86/xen: simplify sysenter and syscall setup

Jun Lei (1):
      drm/amd/display: Limit dcn32 to 1950Mhz display clock

Kan Liang (3):
      perf/x86/intel: Fix pebs event constraints for ICL
      perf/x86/intel: Fix pebs event constraints for SPR
      perf/x86/intel: Add Cooper Lake stepping to isolation_ucodes[]

Kees Cook (2):
      NFS: Avoid memcpy() run-time warning for struct sockaddr overflows
      fortify: Capture __bos() results in const temp vars

Kirill A. Shutemov (1):
      x86/tdx: Panic on bad configs that #VE on "private" memory access

Leo Chen (1):
      drm/amd/display: Update DSC capabilitie for DCN314

Li Huafei (1):
      ftrace: Fix use-after-free for dynamic ftrace_ops

Li Jun (4):
      arm64: dts: imx8mm: remove otg1/2 power domain dependency on hsio
      arm64: dts: imx8mm: correct usb power domains
      arm64: dts: imx8mn: remove otg1 power domain dependency on hsio
      arm64: dts: imx8mn: Correct the usb power domain

Li Qiang (1):
      kprobe: reverse kp->flags when arm_kprobe failed

Li Zetao (1):
      xfs: Fix unreferenced object reported by kmemleak in xfs_sysfs_init()

Li Zhijian (3):
      RDMA/rxe: Fix mr leak in RESPST_ERR_RNR
      ksefltests: pidfd: Fix wait_states: Test terminated by timeout
      selftests: pidfd: Fix compling warnings

Liao Chang (1):
      KVM: x86: Fix a typo about the usage of kvcalloc()

Linus Torvalds (1):
      Linux 6.1-rc4

Linus Walleij (1):
      ARM: dts: ux500: Add trips to battery thermal zones

Liu Peibao (1):
      stmmac: dwmac-loongson: fix invalid mdio_node

Liu Ying (1):
      drm/imx: Kconfig: Remove duplicated 'select DRM_KMS_HELPER' line

Luiz Augusto von Dentz (4):
      Bluetooth: hci_conn: Fix not restoring ISO buffer count on disconnect
      Bluetooth: L2CAP: Fix accepting connection request for invalid SPSM
      Bluetooth: L2CAP: Fix l2cap_global_chan_by_psm
      Bluetooth: L2CAP: Fix attempting to access uninitialized memory

Lukas Bulwahn (1):
      MAINTAINERS: adjust entry after renaming parisc serial driver

Lu=C3=ADs Henriques (1):
      ext4: fix BUG_ON() when directory entry has invalid rec_len

Manank Patel (1):
      drivers: watchdog: exar_wdt.c fix use after free

Marc Zyngier (1):
      KVM: arm64: Fix SMPRI_EL1/TPIDR2_EL0 trapping on VHE

Marek Vasut (2):
      clk: rs9: Fix I2C accessors
      arm64: dts: imx8mm: Enable CPLD_Dn pull down resistor on MX8Menlo

Mario Limonciello (2):
      ACPI: x86: Add another system to quirk list for forcing StorageD3Enab=
le
      drm/amd: Fail the suspend if resources can't be evicted

Mark Brown (1):
      arm64: booting: Document our requirements for fine grained traps with=
 SME

Mark Rutland (1):
      arm64: entry: avoid kprobe recursion

Masahiro Yamada (2):
      kbuild: fix SIGPIPE error message for AR=3Dgcc-ar and AR=3Dllvm-ar
      kconfig: fix segmentation fault in menuconfig search

Masami Hiramatsu (Google) (1):
      tracing/fprobe: Fix to check whether fprobe is registered correctly

Max Krummenacher (1):
      arm64: dts: verdin-imx8mp: fix ctrl_sleep_moci

Max Tseng (1):
      drm/amd/display: cursor update command incomplete

Maxim Levitsky (5):
      KVM: x86: emulator: em_sysexit should update ctxt->mode
      KVM: x86: emulator: introduce emulator_recalc_and_set_mode
      KVM: x86: emulator: update the emulation mode after rsm
      KVM: x86: emulator: update the emulation mode after CR0 write
      KVM: x86: smm: number of GPRs in the SMRAM image depends on the
image format

Maxim Mikityanskiy (1):
      Bluetooth: L2CAP: Fix use-after-free caused by l2cap_reassemble_sdu

Maxime Ripard (3):
      clk: Remove WARN_ON NULL parent in clk_core_init_rate_req()
      clk: Initialize the clk_rate_request even if clk_core is NULL
      clk: Initialize max_rate in struct clk_rate_request

Michael Ellerman (2):
      powerpc/64e: Fix amdgpu build on Book3E w/o AltiVec
      powerpc/32: Select ARCH_SPLIT_ARG64

Michael Margolin (1):
      RDMA/efa: Add EFA 0xefa2 PCI ID

Michael Tretter (2):
      drm/rockchip: vop2: fix null pointer in plane_atomic_disable
      drm/rockchip: vop2: disable planes when disabling the crtc

Michal Luczaj (2):
      KVM: Initialize gfn_to_pfn_cache locks in dedicated helper
      KVM: selftests: Add tests in xen_shinfo_test to detect lock races

Micka=C3=ABl Sala=C3=BCn (1):
      selftests/landlock: Build without static libraries

Miklos Szeredi (2):
      fuse: fix readdir cache race
      fuse: add file_modified() to fallocate

Ming Lei (4):
      ublk_drv: return flag of UBLK_F_URING_CMD_COMP_IN_TASK in case of mod=
ule
      ublk_drv: comment on ublk_driver entry of Kconfig
      ublk_drv: avoid to touch io_uring cmd in blk_mq io path
      ublk_drv: add ublk_queue_cmd() for cleanup

Mushahid Hussain (1):
      Documentation: Fix spelling mistake in hacking.rst

Nam Cao (1):
      i2c: i801: add lis3lv02d's I2C address for Vostro 5568

Nathan Huckleberry (1):
      drm/imx: imx-tve: Fix return type of imx_tve_connector_mode_valid

Nevenko Stupar (1):
      drm/amd/display: Investigate tool reported FCLK P-state deviations

Nick Child (1):
      ibmvnic: Free rwi on reset success

Nick Desaulniers (1):
      Documentation: process: replace outdated LTS table w/ link

Ondrej Jirman (1):
      drm/rockchip: dsi: Fix VOP selection on SoCs that support it

Pablo Neira Ayuso (2):
      netfilter: nf_tables: netlink notifier might race to release objects
      netfilter: nf_tables: release flow rule object from commit path

Palmer Dabbelt (2):
      MAINTAINERS: git://github -> https://github.com for broadcom
      MAINTAINERS: git://github -> https://github.com for kvm-riscv

Pauli Virtanen (1):
      Bluetooth: hci_conn: Fix CIS connection dst_type handling

Pavel Begunkov (3):
      udp: advertise ipv6 udp support for msghdr::ubuf_info
      net: remove SOCK_SUPPORT_ZC from sockmap
      net/ulp: remove SOCK_SUPPORT_ZC from tls sockets

Peng Fan (4):
      arm64: dts: imx8: correct clock order
      dt-bindings: power: gpcv2: add power-domains property
      arm64: dts: imx93: correct s4mu interrupt names
      arm64: dts: imx93: correct gpio-ranges

Petr Benes (1):
      ARM: dts: imx6dl-yapp4: Do not allow PM to switch PU regulator off on=
 Q/QP

Qu Wenruo (4):
      btrfs: raid56: properly handle the error when unable to find the
missing stripe
      btrfs: raid56: avoid double freeing for rbio if full_stripe_write() f=
ailed
      btrfs: make thaw time super block check to also verify checksum
      btrfs: don't use btrfs_chunk::sub_stripes from disk

Quentin Perret (1):
      KVM: arm64: Use correct accessor to parse stage-1 PTEs

Radhey Shyam Pandey (1):
      net: emaclite: update reset_lock member documentation

Rafael Mendonca (1):
      fprobe: Check rethook_alloc() return in rethook initialization

Rasmus Villemoes (1):
      tools/nolibc/string: Fix memcmp() implementation

Rick Lindsley (1):
      ibmvnic: change maintainers for vnic driver

Robert Beckett (1):
      drm/i915: stop abusing swiotlb_max_segment

Ryan Roberts (1):
      KVM: arm64: Fix bad dereference on MTE-enabled systems

Sean Christopherson (6):
      KVM: x86: Exempt pending triple fault from event injection sanity che=
ck
      KVM: Reject attempts to consume or refresh inactive gfn_to_pfn_cache
      KVM: selftests: Mark "guest_saw_irq" as volatile in xen_shinfo_test
      KVM: VMX: Advertise PMU LBRs if and only if perf supports LBRs
      KVM: VMX: Fold vmx_supported_debugctl() into vcpu_supported_debugctl(=
)
      KVM: VMX: Ignore guest CPUID for host userspace writes to DEBUGCTL

Sergey Shtylyov (1):
      ata: pata_legacy: fix pdc20230_set_piomode()

Shang XiaoJing (5):
      nfc: fdp: Fix potential memory leak in fdp_nci_send()
      nfc: nxp-nci: Fix potential memory leak in nxp_nci_send()
      nfc: s3fwrn5: Fix potential memory leak in s3fwrn5_nci_send()
      nfc: nfcmrvl: Fix potential memory leak in nfcmrvl_i2c_nci_send()
      tracing: kprobe: Fix memory leak in test_gen_kprobe/kretprobe_cmd()

Shyam Prasad N (2):
      cifs: always iterate smb sessions using primary channel
      cifs: avoid unnecessary iteration of tcp sessions

Soenke Huster (1):
      Bluetooth: virtio_bt: Use skb_put to set length

Stefan Hansson (1):
      kbuild: use POSIX-compatible grep option

Stefan Metzmacher (1):
      net: also flag accepted sockets supporting msghdr originated zerocopy

Steven Rostedt (Google) (1):
      ring-buffer: Check for NULL cpu_buffer in ring_buffer_wake_waiters()

Taniya Das (1):
      clk: qcom: Update the force mem core bit for GPU clocks

Theodore Ts'o (2):
      ext4: update the backup superblock's at the end of the online resize
      ext4: fix fortify warning in fs/ext4/fast_commit.c:1551

Thierry Reding (1):
      i2c: tegra: Allocate DMA memory for DMA engine

Tim Harvey (1):
      ARM: dts: imx6qdl-gw59{10,13}: fix user pushbutton GPIO offset

Tony Luck (1):
      x86/cpu: Add several Intel server CPU model numbers

Trond Myklebust (3):
      NFSv4: Fix a potential state reclaim deadlock
      NFSv4.1: Handle RECLAIM_COMPLETE trunking errors
      NFSv4.1: We must always send RECLAIM_COMPLETE after a reboot

Ville Syrj=C3=A4l=C3=A4 (4):
      drm/i915/sdvo: Filter out invalid outputs more sensibly
      drm/i915/sdvo: Setup DDC fully before output init
      drm/i915: Simplify intel_panel_add_edid_alt_fixed_modes()
      drm/i915/sdvo: Grab mode_config.mutex during LVDS init to avoid WARNs

Vishal Verma (1):
      cxl/region: Fix decoder allocation crash

Vladimir Oltean (1):
      net: dsa: fall back to default tagger if we can't load the one from D=
T

Will McVicker (1):
      kbuild: fix typo in modpost

Willy Tarreau (1):
      tools/nolibc: Fix missing strlen() definition and infinite loop
with gcc-12

Yang Li (1):
      drm/amdkfd: Fix NULL pointer dereference in svm_migrate_to_ram()

Yang Yingliang (5):
      clk: mediatek: clk-mt8195-topckgen: Fix error return code in
clk_mt8195_topck_probe()
      ata: palmld: fix return value check in palmld_pata_probe()
      mISDN: fix possible memory leak in mISDN_register_device()
      isdn: mISDN: netjet: fix wrong check of device registration
      Documentation: devres: add missing I2C helper

Yangyang Li (1):
      RDMA/hns: Disable local invalidate operation

Ye Bin (1):
      ext4: fix warning in 'ext4_da_release_space'

Yifan Zhang (1):
      drm/amdgpu: set fb_modifiers_not_supported in vkms

Yixing Liu (1):
      RDMA/hns: Fix NULL pointer problem in free_mr_init()

Yu Zhe (1):
      cxl/pmem: Use size_add() against integer overflow

Yushan Zhou (1):
      nfs: Remove redundant null checks before kfree

Zeng Heng (1):
      xfs: fix memory leak in xfs_errortag_init

Zhang Changzhong (1):
      net: fec: fix improper use of NETDEV_TX_BUSY

Zhang Qilong (1):
      rose: Fix NULL pointer dereference in rose_send_frame()

Zhang Rui (1):
      perf/x86/rapl: Use standard Energy Unit for SPR Dram RAPL domain

Zhang Xiaoxu (2):
      SUNRPC: Fix null-ptr-deref when xps sysfs alloc failed
      nfs4: Fix kmemleak when allocate slot failed

Zhao Gongyi (1):
      selftests/pidfd_test: Remove the erroneous ','

Zheng Yejian (1):
      tracing/histogram: Update document for KEYS_MAX size

Zhengchao Shao (4):
      ipvs: fix WARNING in __ip_vs_cleanup_batch()
      ipvs: fix WARNING in ip_vs_app_net_cleanup()
      Bluetooth: L2CAP: fix use-after-free in l2cap_conn_del()
      ipv6: fix WARNING in ip6_route_net_exit_late()

Ziyang Xuan (1):
      net: tun: fix bugs for oversize packet when napi frags enabled
