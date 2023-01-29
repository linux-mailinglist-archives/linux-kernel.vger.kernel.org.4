Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39870680235
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 23:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbjA2WUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 17:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjA2WUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 17:20:13 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D7A1C58C
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 14:20:10 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id n6so6670151edo.9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 14:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yd9Udq4kyC1xaryyLcU2+0eXhAz7OrJO62FY/XxHJ1c=;
        b=BAEYZO+3I/wkX6CkrJvzYpuWege1x87R1xaSfK0cFCG3gOxxuZ0/Z6gk3TOwt5LqBE
         eg86Z9duAxouaB/gH1uDFXzwRZxZ1cKXwTOz8fhu1IxugBg+QxoTzL6Aki7LiTyW35Or
         EYpCfJLOi0Lcv/akMJah66J1LAh6VyDbZ5QrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yd9Udq4kyC1xaryyLcU2+0eXhAz7OrJO62FY/XxHJ1c=;
        b=p4eScY3f+o7eJlSC3mQxH9QV0g0yoO2WO7q3OzuMpf4c23i64AZmJOkZLrsNwSqZty
         ug8GlLl0AYHLu/FD3HAejiuDsFy6pafJHJ4hC6X5tzNdR38J4Q1QyuNeXmdQOMXx6byi
         lGePuRdtSgY8MjBXLRZq3LJF5gufZBvVf8I+jLSiY3i6VhAQOQbGzyYKwFaPxfTBOe5g
         yTmzZy/1eJnGGnFiMOw5nKucPyK7mMfX8aeOASehliq9k+yvzy+0utoBYW/O75VtJGfI
         kV4+4FdVmAutMR/iB9PHfnWxUJSQOUi1qSEzDNSKSKyLAvoZsCHtE6EOA1Gy28UFz3u2
         VJSQ==
X-Gm-Message-State: AO0yUKUQf1pOU/5tV4ABa1zVbCcsoHjpUPWODtXwiS7D7UN1bI3BnWvI
        cUVhGFdiSP2WNJq6uRVz/7BR2xPAAlNoB9TWT70=
X-Google-Smtp-Source: AK7set9QJlnNeh6UnK8JdHL7Zceu8LCLJccPRr8jd5LnMUo/cdcN7F/K9M4Ey0c35M5tWmeW4G61Tw==
X-Received: by 2002:a05:6402:360c:b0:4a0:c3f7:69c3 with SMTP id el12-20020a056402360c00b004a0c3f769c3mr16318976edb.29.1675030808700;
        Sun, 29 Jan 2023 14:20:08 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id x26-20020a1709060a5a00b00877f2b842fasm5916814ejf.67.2023.01.29.14.20.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 14:20:08 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id me3so27050700ejb.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 14:20:07 -0800 (PST)
X-Received: by 2002:a17:906:a3c9:b0:879:4f94:41ea with SMTP id
 ca9-20020a170906a3c900b008794f9441eamr2835919ejb.79.1675030807449; Sun, 29
 Jan 2023 14:20:07 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Jan 2023 14:19:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiJcsgmgjEitJ97x3unFpaKv1d=YyNr_5NbOTGsGqCG=A@mail.gmail.com>
Message-ID: <CAHk-=wiJcsgmgjEitJ97x3unFpaKv1d=YyNr_5NbOTGsGqCG=A@mail.gmail.com>
Subject: Linux 6.2-rc6
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here we are, one week later, and rc6 is out.

It's suspiciously small, but who am I to look a gift horse in the
mouth? I'll take it and hope it's not an aberration, but instead a
sign that 6.2 is shaping up nicely. Call me optimistic, call me naive,
but let's enjoy it and hope the trend continues.

The diffstat looks pretty normal too, with various driver fixes
(networking, gpu, i2c and x86 platform drivers stand out) and
netfilter fixes leading the pack. But there's the usual arch updates,
random filesystem fixes, and misc other things going on too. The
shortlog is appended for people who want to scan through the detailed
overview.

I've already mentioned this a couple of times earlier: despite rc6
being nice and small, I expect to drag 6.2 out to an rc8 just because
of the time lost to the holidays. But I'll be much happier if we can
*keep* the remaining rc's nice and small. Ok?

              Linus

---

Ahmad Fatoum (1):
      net: dsa: microchip: fix probe of I2C-connected KSZ8563

Alexandru Tachici (1):
      net: ethernet: adi: adin1110: Fix multicast offloading

Alexey V. Vissarionov (1):
      scsi: hpsa: Fix allocation size for scsi_host_alloc()

Andreas Gruenbacher (1):
      Revert "gfs2: stop using generic_writepages in gfs2_ail1_start_one"

Ard Biesheuvel (3):
      arm64: efi: Avoid workqueue to check whether EFI runtime is live
      arm64: efi: Account for the EFI runtime stack in stack unwinder
      efi: Remove Matthew Garrett as efivarfs maintainer

Arnd Bergmann (2):
      drm/i915/selftest: fix intel_selftest_modify_policy argument types
      gpio: ep93xx: remove unused variable

Aurabindo Pillai (1):
      drm/amd/display: Fix timing not changning when freesync video is enabled

Bart Van Assche (1):
      scsi: device_handler: alua: Remove a might_sleep() annotation

Basavaraj Natikar (1):
      i2c: designware-pci: Add new PCI IDs for AMD NAVI GPU

Catalin Marinas (1):
      KVM: arm64: Pass the actual page address to mte_clear_page_tags()

Christian Brauner (1):
      fuse: fixes after adapting to new posix acl api

Chuang Wang (1):
      tracing/osnoise: Use built-in RCU list checking

Colin Ian King (1):
      rv: remove redundant initialization of pointer ptr

Conor Dooley (3):
      dt-bindings: riscv: fix underscore requirement for multi-letter extensions
      dt-bindings: riscv: fix single letter canonical order
      MAINTAINERS: add an IRC entry for RISC-V

Dan Carpenter (1):
      gpio: mxc: Unlock on error path in mxc_flip_edge()

Dan Williams (1):
      cxl/pmem: Fix nvdimm unregistration when cxl_pmem driver is absent

Dave Airlie (1):
      amdgpu: fix build on non-DCN platforms.

Dave Jiang (1):
      cxl: fix cxl_report_and_clear() RAS UE addr mis-assignment

David Christensen (1):
      net/tg3: resolve deadlock in tg3_reset_task() during EEH

David Howells (1):
      cifs: Fix oops due to uncleared server->smbd_conn in reconnect

David Woodhouse (1):
      x86/pci/xen: Set MSI_FLAG_PCI_MSIX support in Xen MSI domain

Dmitry Torokhov (1):
      Revert "Input: synaptics - switch touchpad on HP Laptop
15-da3001TU to RMI mode"

Doug Smythies (1):
      selftests: amd-pstate: Don't delete source files via Makefile

Dylan Yudaken (1):
      io_uring: always prep_async for drain requests

Eric Biggers (2):
      MAINTAINERS: update fsverity git repo, list, and patchwork
      MAINTAINERS: update fscrypt git repo

Eric Dumazet (7):
      netlink: prevent potential spectre v1 gadgets
      netlink: annotate data races around nlk->portid
      netlink: annotate data races around dst_portid and dst_group
      netlink: annotate data races around sk_state
      ipv4: prevent potential spectre v1 gadget in ip_metrics_convert()
      ipv4: prevent potential spectre v1 gadget in fib_metrics_match()
      net/sched: sch_taprio: do not schedule in taprio_reset()

Evan Quan (1):
      drm/amd/pm: add missing AllowIHInterrupt message mapping for SMU13.0.0

Fabrizio Castro (1):
      dt-bindings: i2c: renesas,rzv2m: Fix SoC specific string

Gergely Risko (1):
      ipv6: fix reachability confirmation with proxy_ndp

Gerhard Engleder (1):
      tsnep: Fix TX queue stop/wake for multiple queues

Giulio Benetti (1):
      ARM: 9280/1: mm: fix warning on phys_addr_t to void pointer assignment

Haiyang Zhang (1):
      net: mana: Fix IRQ name - add PCI and queue number

Hans de Goede (8):
      ACPI: video: Add backlight=native DMI quirk for HP Pavilion g6-1d80nr
      ACPI: video: Add backlight=native DMI quirk for HP EliteBook 8460p
      ACPI: video: Add backlight=native DMI quirk for Asus U46E
      platform/x86: asus-wmi: Fix kbd_dock_devid tablet-switch reporting
      platform/x86: hp-wmi: Fix cast to smaller integer type warning
      platform/x86: apple-gmux: Move port defines to apple-gmux.h
      platform/x86: apple-gmux: Add apple_gmux_detect() helper
      ACPI: video: Fix apple gmux detection

Heiko Stuebner (1):
      RISC-V: fix compile error from deduplicated __ALTERNATIVE_CFG_2

Hendrik Borghorst (1):
      KVM: x86/vmx: Do not skip segment attributes if unusable bit is set

Hyunwoo Kim (1):
      net/x25: Fix to not accept on connected socket

Ivan Vecera (1):
      docs: networking: Fix bridge documentation URL

Ivo Borisov Shopov (1):
      tools: gpio: fix -c option of gpio-event-mon

Jason Gunthorpe (1):
      genirq/msi: Free the fwnode created by msi_create_device_irq_domain()

Javier Martinez Canillas (2):
      drm/fb-helper: Check fb_deferred_io_init() return value
      drm/fb-helper: Use a per-driver FB deferred I/O handler

Jeff Layton (1):
      nfsd: don't free files unconditionally in __nfsd_file_cache_purge

Jens Axboe (1):
      io_uring/net: cache provided buffer group value for multishot receives

Jeremy Kerr (3):
      net: mctp: add an explicit reference from a mctp_sk_key to sock
      net: mctp: move expiry timer delete to unhash
      net: mctp: mark socks as dead on unhash, prevent re-add

Jerome Brunet (1):
      net: mdio-mux-meson-g12a: force internal PHY off on mux switch

Johan Hovold (1):
      scsi: ufs: core: Fix devfreq deadlocks

Jonathan Kim (1):
      drm/amdgpu: remove unconditional trap enable on add gfx11 queues

Juergen Gross (1):
      acpi: Fix suspend with Xen PV

Kan Liang (2):
      perf/x86/intel: Add Emerald Rapids
      perf/x86/intel/cstate: Add Emerald Rapids

Kees Cook (3):
      kunit: memcpy: Split slow memcpy tests into MEMCPY_SLOW_KUNIT_TEST
      gcc-plugins: Reorganize gimple includes for GCC 13
      bcache: Silence memcpy() run-time false positive warnings

Keith Busch (2):
      nvme-pci: flush initial scan_work for async probe
      nvme: fix passthrough csi check

Kevin Kuriakose (1):
      platform/x86: gigabyte-wmi: add support for B450M DS3H WIFI-CF

Koba Ko (1):
      platform/x86: dell-wmi: Add a keymap for KEY_MUTE in type 0x0010 table

Krzysztof Kozlowski (1):
      regulator: dt-bindings: samsung,s2mps14: add lost
samsung,ext-control-gpios

Kuniyuki Iwashima (1):
      netrom: Fix use-after-free of a listening socket.

Lareine Khawaly (1):
      i2c: designware: use casting of u64 in clock multiplication to
avoid overflow

Ley Foon Tan (1):
      riscv: Move call to init_cpu_topology() to later initialization stage

Li Ma (2):
      drm/amdgpu: enable imu firmware for GC 11.0.4
      drm/amdgpu: declare firmware for new MES 11.0.4

Liao Chang (1):
      riscv/kprobe: Fix instruction simulation of JALR

Linus Torvalds (4):
      ext4: make xattr char unsignedness in hash explicit
      treewide: fix up files incorrectly marked executable
      Fix up more non-executable files marked executable
      Linux 6.2-rc6

Lucas De Marchi (1):
      drm/i915/mtl: Fix bcs default context

Lyude Paul (1):
      drm/amdgpu/display/mst: Fix mst_state->pbn_div and slot count assignments

Manivannan Sadhasivam (2):
      EDAC/device: Respect any driver-supplied workqueue polling value
      EDAC/qcom: Do not pass llcc_driv_data as edac_device_ctl_info's pvt_info

Marc Zyngier (1):
      KVM: arm64: GICv4.1: Fix race with doorbell on VPE activation/deactivation

Marcelo Ricardo Leitner (1):
      sctp: fail if no bound addresses can be used for a given scope

Marcin Szycik (1):
      iavf: Move netdev_update_features() into watchdog task

Mario Limonciello (3):
      gpiolib-acpi: Don't set GPIOs for wakeup in S3 mode
      platform/x86/amd: pmc: Disable IRQ1 wakeup for RN/CZN
      platform/x86/amd: pmc: Add a module parameter to disable workarounds

Marios Makassikis (1):
      ksmbd: do not sign response to session request for guest login

Mark Pearson (1):
      platform/x86: thinkpad_acpi: Fix profile modes on Intel platforms

Mark Rutland (2):
      ftrace: Export ftrace_free_filter() to modules
      ftrace: Maintain samples/ftrace

Masahiro Yamada (2):
      ARM: 9284/1: include <asm/pgtable.h> from proc-macros.S to fix
-Wundef warnings
      riscv: fix -Wundef warning for CONFIG_RISCV_BOOT_SPINWAIT

Masami Hiramatsu (Google) (1):
      bootconfig: Update MAINTAINERS file to add tree and mailing list

Mat Martineau (1):
      MAINTAINERS: Update MPTCP maintainer list and CREDITS

Maurizio Lombardi (1):
      scsi: target: core: Fix warning on RT kernels

Michal Schmidt (1):
      iavf: fix temporary deadlock and failure to set MAC address

Miguel Ojeda (1):
      rust: print: avoid evaluating arguments in `pr_*` macros in
`unsafe` blocks

Mike Christie (2):
      scsi: iscsi_tcp: Fix UAF during logout when accessing the shost ipaddress
      scsi: iscsi_tcp: Fix UAF during login when accessing the shost ipaddress

Miklos Szeredi (2):
      ovl: fix tmpfile leak
      ovl: fail on invalid uid/gid mapping at copy up

Ming Lei (1):
      block: ublk: move ublk_chr_class destroying after devices are removed

Namjae Jeon (3):
      ksmbd: add max connections parameter
      ksmbd: limit pdu length size according to connection status
      ksmbd: downgrade ndr version error message to debug

Natalia Petrova (1):
      trace_events_hist: add check for return value of 'create_hist_field'

Nathan Chancellor (2):
      x86/build: Move '-mindirect-branch-cs-prefix' out of GCC-only block
      ARM: 9287/1: Reduce __thumb2__ definition to crypto files that require it

Nikita Shubin (2):
      gpio: ep93xx: Fix port F hwirq numbers in handler
      gpio: ep93xx: Make irqchip immutable

Niklas Schnelle (1):
      vfio/type1: Respect IOMMU reserved regions in vfio_test_domain_fgsp()

Nikunj A Dadhania (1):
      x86/sev: Add SEV-SNP guest feature negotiation support

Nirmoy Das (2):
      drm/drm_vma_manager: Add drm_vma_node_allow_once()
      drm/i915: Fix a memory leak with reused mmap_offset

Pablo Neira Ayuso (2):
      netfilter: nft_set_rbtree: Switch to node list walk for overlap detection
      netfilter: nft_set_rbtree: skip elements in transaction from
garbage collection

Paolo Abeni (3):
      net: fix UaF in netns ops registration error path
      Revert "Merge branch 'ethtool-mac-merge'"
      net: mctp: hold key reference when looking up a general key

Paolo Bonzini (1):
      selftests: kvm: move declaration at the beginning of main()

Paul M Stillwell Jr (1):
      ice: move devlink port creation/deletion

Petr Pavlu (1):
      module: Don't wait for GOING modules

Qais Yousef (2):
      sched/uclamp: Fix a uninitialized variable warnings
      sched/fair: Fixes for capacity inversion detection

Rafael J. Wysocki (1):
      thermal: intel: int340x: Add locking to int340x_thermal_get_trip_type()

Randy Dunlap (5):
      i2c: axxia: use 'struct' for kernel-doc notation
      i2c: rk3x: fix a bunch of kernel-doc warnings
      tracing: Kconfig: Fix spelling/grammar/punctuation
      lib: Kconfig: fix spellos
      tracing/filter: fix kernel-doc warnings

Richard Fitzgerald (1):
      i2c: designware: Fix unbalanced suspended flag

Rishit Bansal (1):
      platform/x86: hp-wmi: Handle Omen Key event

Robin Murphy (1):
      Partially revert "perf/arm-cmn: Optimise DTC counter accesses"

Ross Lagerwall (1):
      nvme-fc: fix initialization order

Srinivas Pandruvada (1):
      thermal: intel: int340x: Protect trip temperature from concurrent updates

Sriram Yagnaraman (4):
      netfilter: conntrack: fix vtag checks for ABORT/SHUTDOWN_COMPLETE
      netfilter: conntrack: fix bug in for_each_sctp_chunk
      Revert "netfilter: conntrack: add sctp DATA_SENT state"
      netfilter: conntrack: unify established states for SCTP paths

Stefan Assmann (1):
      iavf: schedule watchdog immediately when changing primary MAC

Stefan Wahren (1):
      i2c: mxs: suppress probe-deferral error message

Steven Rostedt (Google) (2):
      tracing: Make sure trace_printk() can output as soon as it can be used
      ftrace/scripts: Update the instructions for ftrace-bisect.sh

Thomas Gleixner (2):
      x86/i8259: Mark legacy PIC interrupts with IRQ_LEVEL
      x86/pci/xen: Fixup fallout from the PCI/MSI overhaul

Vipin Sharma (1):
      KVM: selftests: Make reclaim_period_ms input always be positive

Vladimir Oltean (1):
      net: ethtool: netlink: introduce ethnl_update_bool()

Vlastimil Babka (1):
      Revert "mm/compaction: fix set skip in fast_find_migrateblock"

Waiman Long (1):
      sched/core: Fix NULL pointer access fault in sched_setaffinity()
with non-SMP configs

Wayne Lin (3):
      drm/amdgpu/display/mst: limit payload to be updated one by one
      drm/amdgpu/display/mst: update mst_mgr relevant variable when long HPD
      drm/display/dp_mst: Correct the kref of port.

Wei Fang (1):
      net: fec: Use page_pool_put_full_page when freeing rx buffers

Werner Sembach (1):
      Input: i8042 - add Clevo PCX0DX to i8042 quirk table

Yair Podemsky (1):
      x86/aperfmperf: Erase stale arch_freq_scale values when
disabling frequency invariance readings

Yi Liu (1):
      kvm/vfio: Fix potential deadlock on vfio group_lock

Yoshihiro Shimoda (3):
      net: ethernet: renesas: rswitch: Fix ethernet-ports handling
      net: ravb: Fix lack of register setting after system resumed for Gen3
      net: ravb: Fix possible hang if RIS2_QFF1 happen
