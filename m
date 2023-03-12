Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2930D6B6CA8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 00:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCLXqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 19:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCLXqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 19:46:19 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EF67D99
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 16:46:16 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id o12so42005347edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 16:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678664775;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aHxlTSkwdhsRW0k3cVNpNlbHVUWr0XKlJavFjo37PCc=;
        b=e1CNzCvere90Yw4Bn9Hkp7TC4fiu7zr8zFS3QgQ4WSkcVhLgLjhGO7qTYt+PgHGWxS
         4wkzfEY7jT5rDKRyq7DGnSjITQ8s6U+CHM/NFgXumHUv/eL5dadwNDwjaakCS+gYJB2e
         BN04Nq3GfViYEve4AURAMaWXiUWFUMgUhES5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678664775;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aHxlTSkwdhsRW0k3cVNpNlbHVUWr0XKlJavFjo37PCc=;
        b=rIZFNzKGC6kUm9dGFxggBocSutXy4gbam3qda7WrbFhr2WqzaVxLpZTqdmLWM5FnNe
         VtJKTO4NSh23w/Ut0HtGlOMQ1YZ6vciLx6ILYtGf47oUAmxxM90YYYNETUYY07aUwlYE
         OuKIMhcA5lojzmULq+QVfXy+3rvXdl/y9k59wRcQWU4iwefPoDGwtRHcrTkyLILeYzFK
         PGMwTZ/9WH8d7oQ/0zPk1OVXyZ/jCepk4OjzHcLwVrnw+qj+oociznOJ3mz51djs+dx1
         snGF9CMkX4gff/4PM9jB2Id6dV8ndLRCueqEYoMueusK4RCqEHTpDaKxxAGBufjHVGE6
         rxAw==
X-Gm-Message-State: AO0yUKXVseDJahHCqb7ZxosARew+kRl1VN46C4ABs8x2qltamHCnR7+l
        D1LzY0QFB/dzzGW9PtaPIbSaDkU00UtptsQiFn870w==
X-Google-Smtp-Source: AK7set+Nxv3gj3V0HKsH01tTiasmkHDaTE+nQbaByhUEsGpzC7jMGgwuZaHlGHSo9s9Bl4pqKYSzng==
X-Received: by 2002:a17:907:31c3:b0:8af:2d2e:5d31 with SMTP id xf3-20020a17090731c300b008af2d2e5d31mr42868058ejb.31.1678664774910;
        Sun, 12 Mar 2023 16:46:14 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id u25-20020a1709063b9900b0092396a853bbsm1789974ejf.143.2023.03.12.16.46.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 16:46:14 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id cy23so41907185edb.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 16:46:14 -0700 (PDT)
X-Received: by 2002:a17:906:3d51:b0:8f1:4c6a:e72 with SMTP id
 q17-20020a1709063d5100b008f14c6a0e72mr15514882ejf.0.1678664773751; Sun, 12
 Mar 2023 16:46:13 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Mar 2023 16:45:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wii6BZtVKYfvQCQqbE3+t1_yAb-ea80-3PcJ4KxgpfHkA@mail.gmail.com>
Message-ID: <CAHk-=wii6BZtVKYfvQCQqbE3+t1_yAb-ea80-3PcJ4KxgpfHkA@mail.gmail.com>
Subject: Linux 6.3-rc2
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

It's another Sunday afternoon. which must mean another rc release.

This one looks fairly normal, although if you look at the diffs, they
are dominated by the removal of a staging driver (r8188eu) that has
been superceded by a proper driver. That removal itself is 90% of the
diffs.

But if you filter that out, it all looks normal. Still more than two
thirds in drivers, but hey, that's pretty normal. It's mostly gpu and
networking as usual, but there's various other driver fixes in there
too.

Outside of that regular driver noise (and the unusual driver removal
noise) it's a little bit of everything: core networking, arch fixes,
documentation, filesystems (btrfs, xfs, and ext4, but also some core
vfs fixes). And io_uring and some tooling.

The full shortlog is appended, for the adventurous souls that want to
get that kind of details. The release feels fairly normal so far, but
it's early days. Please keep testing and reporting any issues,

                 Linus

---

Adrien Thierry (1):
      scsi: ufs: core: Add soft dependency on governor_simpleondemand

Al Viro (3):
      alpha: fix lazy-FPU mis(merged/applied/whatnot)
      new helper: put_and_unmap_page()
      sh: sanitize the flags on sigreturn

Alex Deucher (3):
      drm/amdgpu: fix error checking in amdgpu_read_mm_registers for soc15
      drm/amdgpu: fix error checking in amdgpu_read_mm_registers for soc21
      drm/amdgpu: fix error checking in amdgpu_read_mm_registers for nv

Alexander Aring (1):
      ca8210: fix mac_len negative array access

Alexander Lobakin (1):
      bpf, test_run: fix &xdp_frame misplacement for LIVE_FRAMES

Alexandr Sapozhnikov (1):
      drm/cirrus: NULL-check pipe->plane.state->fb in cirrus_pipe_update()

Alexandre Ghiti (1):
      riscv: Use READ_ONCE_NOCHECK in imprecise unwinding stack mode

Andrew Cooper (1):
      x86/CPU/AMD: Disable XSAVES on AMD family 0x17

Andy Shevchenko (1):
      cpumask: Fix typo nr_cpumask_size --> nr_cpumask_bits

Armin Wolf (2):
      platform/x86: dell-ddv: Fix cache invalidation on resume
      platform/x86: dell-ddv: Fix temperature scaling

Arnaldo Carvalho de Melo (12):
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools headers svm: Sync svm headers with the kernel sources
      tools headers: Update the copy of x86's mem{cpy,set}_64.S used
in 'perf bench'
      tools headers UAPI: Sync linux/prctl.h with the kernel sources
      tools headers: Synchronize {linux,vdso}/bits.h with the kernel source=
s
      tools include UAPI: Synchronize linux/fcntl.h with the kernel sources
      tools headers kvm: Sync uapi/{asm/linux} kvm.h headers with the
kernel sources
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools include UAPI: Sync linux/vhost.h with the kernel sources
      tools headers x86 cpufeatures: Sync with the kernel sources
      tools headers UAPI: Sync linux/perf_event.h with the kernel sources
      perf tools: Add Adrian Hunter to MAINTAINERS as a reviewer

Arnd Bergmann (2):
      platform/x86/amd: pmc: remove CONFIG_SUSPEND checks
      ethernet: ice: avoid gcc-9 integer overflow warning

Asutosh Das (2):
      scsi: ufs: mcq: qcom: Fix passing zero to PTR_ERR
      scsi: ufs: mcq: qcom: Clean the return path of
ufs_qcom_mcq_config_resource()

Bagas Sanjaya (3):
      bpf, docs: Fix link to BTF doc
      bpf, doc: Do not link to docs.kernel.org for kselftest link
      bpf, doc: Link to submitting-patches.rst for general patch submission=
 info

Ben Skeggs (1):
      drm/nouveau/fb/gp102-: cache scrubber binary on first load

Benjamin Coddington (1):
      SUNRPC: Fix a server shutdown leak

Benjamin Tissoires (1):
      selftest: hid: fix hid_bpf not set in config

Boris Burkov (2):
      btrfs: sysfs: add size class stats
      btrfs: fix potential dead lock in size class loading logic

Brian Vazquez (1):
      net: use indirect calls helpers for sk_exit_memory_pressure()

Candice Li (2):
      drm/amdgpu: Support umc node harvest config on umc v8_10
      drm/amd/pm: Enable ecc_info table support for smu v13_0_10

Chandrakanth Patil (3):
      scsi: megaraid_sas: Update max supported LD IDs to 240
      scsi: megaraid_sas: Add crash dump mode capability bit in MFI capabil=
ities
      scsi: megaraid_sas: Driver version update to 07.725.01.00-rc1

Changbin Du (1):
      perf stat: Fix counting when initial delay configured

Chuck Lever (1):
      NFSD: Protect against filesystem freezing

Conor Dooley (2):
      RISC-V: fix taking the text_mutex twice during sifive errata patching
      RISC-V: Don't check text_mutex during stop_machine

D. Wythe (1):
      net/smc: fix fallback failed while sendmsg with fastopen

Dan Carpenter (2):
      net: phy: unlock on error in phy_probe()
      scsi: ufs: ufs-qcom: Remove impossible check

Daniel Golle (1):
      net: ethernet: mtk_eth_soc: fix RX data corruption issue

Daniel Machon (1):
      net: microchip: sparx5: fix deletion of existing DSCP mappings

Daniel Scally (1):
      platform/x86: int3472: Add GPIOs to Surface Go 3 Board data

Daniel Wagner (1):
      scsi: qla2xxx: Add option to disable FC2 Target support

Danny Kaehn (1):
      HID: cp2112: Fix driver not registering GPIO IRQ chip as threaded

Darrick J. Wong (1):
      ext4: fix another off-by-one fsmap error on 1k block filesystems

Dave Airlie (1):
      mailmap: add mailmap entries for Faith.

Dave Chinner (2):
      xfs: quotacheck failure can race with background inode inactivation
      xfs: fix off-by-one-block in xfs_discard_folio()

Dave Ertman (1):
      ice: Fix DSCP PFC TLV creation

David Disseldorp (1):
      watch_queue: fix IOC_WATCH_QUEUE_SET_SIZE alloc error paths

Dmitry Baryshkov (18):
      drm/msm/a5xx: fix setting of the CP_PREEMPT_ENABLE_LOCAL register
      drm/msm/a5xx: fix highest bank bit for a530
      drm/msm/a5xx: fix the emptyness check in the preempt code
      drm/msm/a5xx: fix context faults during ring switch
      drm/msm/dpu: set DPU_MDP_PERIPH_0_REMOVED for sc8280xp
      drm/msm/dpu: disable features unsupported by QCM2290
      drm/msm/dpu: fix typo in in sm8550's dma_sblk_5
      drm/msm/dpu: fix len of sc7180 ctl blocks
      drm/msm/dpu: fix sm6115 and qcm2290 mixer width limits
      drm/msm/dpu: correct sm8550 scaler
      drm/msm/dpu: correct sc8280xp scaler
      drm/msm/dpu: correct sm8450 scaler
      drm/msm/dpu: correct sm8250 and sm8350 scaler
      drm/msm/dpu: correct sm6115 scaler
      drm/msm/dpu: drop DPU_DIM_LAYER from MIXER_MSM8998_MASK
      drm/msm/dpu: fix clocks settings for msm8998 SSPP blocks
      drm/msm/dpu: don't use DPU_CLK_CTRL_CURSORn for DMA SSPP clocks
      drm/msm/dpu: fix stack smashing in dpu_hw_ctl_setup_blendstage

Douglas Anderson (1):
      drm/msm/a6xx: Make GPU destroy a bit safer

Enrico Sau (2):
      net: usb: cdc_mbim: avoid altsetting toggling for Telit FE990
      net: usb: qmi_wwan: add Telit 0x1080 composition

Eric Biggers (1):
      ext4: fix cgroup writeback accounting with fs-layer encryption

Eric Dumazet (5):
      net: avoid skb end_offset change in __skb_unclone_keeptruesize()
      ila: do not generate empty messages in ila_xlat_nl_cmd_get_mapping()
      net/sched: flower: fix fl_change() error recovery path
      netfilter: conntrack: adopt safer max chain length
      af_unix: fix struct pid leaks in OOB support

Eric Whitney (1):
      ext4: fix RENAME_WHITEOUT handling for inline directories

Fedor Pchelkin (1):
      nfc: change order inside nfc_se_io error path

Filipe Manana (2):
      btrfs: fix extent map logging bit not cleared for split maps
after dropping range
      btrfs: fix block group item corruption after inserting new block grou=
p

Florian Westphal (1):
      netfilter: tproxy: fix deadlock due to missing BH disable

Gao Xiang (3):
      erofs: fix wrong kunmap when using LZMA on HIGHMEM platforms
      erofs: Revert "erofs: fix kvcalloc() misuse with __GFP_NOFAIL"
      erofs: get rid of a useless DBG_BUGON

Geert Uytterhoeven (2):
      m68k: mm: Move initrd phys_to_virt handling after paging_init()
      i2c: dev: Fix bus callback return values

Greg Kroah-Hartman (1):
      staging: r8188eu: delete driver

Hangbin Liu (1):
      selftests: nft_nat: ensuring the listening side is up before
starting the client

Hangyu Hua (1):
      net: tls: fix possible race condition between
do_tls_getsockopt_conf() and do_tls_setsockopt_conf()

Hans de Goede (3):
      platform: mellanox: mlx-platform: Initialize shift variable to 0
      staging: rtl8723bs: Fix key-store index handling
      staging: rtl8723bs: Pass correct parameters to cfg80211_get_bss()

Harry Wentland (2):
      drm/display: Don't block HDR_OUTPUT_METADATA on unknown EOTF
      drm/connector: print max_requested_bpc in state debugfs

Hector Martin (1):
      wifi: cfg80211: Partial revert "wifi: cfg80211: Fix use after
free for wext"

Heiner Kallweit (1):
      net: phy: smsc: fix link up detection in forced irq mode

Horatiu Vultur (1):
      net: lan966x: Fix port police support using tc-matchall

Huanhuan Wang (3):
      nfp: fix incorrectly set csum flag for nfd3 path
      nfp: fix incorrectly set csum flag for nfdk path
      nfp: fix esp-tx-csum-offload doesn't take effect

Ian Rogers (2):
      perf tests stat+csv_output: Switch CSV separator to @
      perf test: Avoid counting commas in json linter

Ivan Delalande (1):
      netfilter: ctnetlink: revert to dumping mark regardless of event type

Jakob Koschel (1):
      scsi: lpfc: Avoid usage of list iterator variable after loop

Jakub Kicinski (11):
      tls: rx: fix return value for async crypto
      net: tls: avoid hanging tasks on the tx_lock
      tools: ynl: fully inherit attrs in subsets
      tools: ynl: use 1 as the default for first entry in attrs/ops
      netlink: specs: update for codegen enumerating from 1
      net: tls: fix device-offloaded sendpage straddling records
      mailmap: add entry for Maxim Mikityanskiy
      ynl: re-license uniformly under GPL-2.0 OR BSD-3-Clause
      eth: fealnx: bring back this old driver
      tools: ynl: move the enum classes to shared code
      tools: ynl: fix enum-as-flags in the generic CLI

Jan Kara (4):
      udf: Fix lost writes in udf_adinicb_writepage()
      udf: Fix reading of in-ICB files
      udf: Warn if block mapping is done for in-ICB files
      ext4: Fix deadlock during directory rename

Jens Axboe (3):
      io_uring/io-wq: stop setting PF_NO_SETAFFINITY on io-wq workers
      io_uring/uring_cmd: ensure that device supports IOPOLL
      io_uring: silence variable =E2=80=98prev=E2=80=99 set but not used wa=
rning

Jiapeng Chong (2):
      splice: Remove redundant assignment to ret
      fs/locks: Remove redundant assignment to cmd

Jiri Slaby (SUSE) (1):
      drm/nouveau/kms/nv50: fix nv50_wndw_new_ prototype

Johan Hovold (1):
      drm/msm/adreno: fix runtime PM imbalance at unbind

Johannes Thumshirn (1):
      btrfs: fix percent calculation for bg reclaim message

Justin Tee (1):
      scsi: lpfc: Check kzalloc() in lpfc_sli4_cgn_params_read()

Kalyan Thota (1):
      drm/msm/dpu: clear DSPP reservations in rm release

Kang Chen (2):
      nfc: fdp: add null check of devm_kmalloc_array in
fdp_nci_i2c_read_device_properties
      scsi: hisi_sas: Check devm_add_action() return value

Kars de Jong (1):
      m68k: mm: Fix systems with memory at end of 32-bit address space

Kuogee Hsieh (1):
      drm/msm/disp/dpu: fix sc7280_pp base offset

Lee Jones (2):
      HID: core: Provide new max_buffer_size attribute to over-ride the def=
ault
      HID: uhid: Over-ride the default maximum data buffer value with our o=
wn

Linus Torvalds (5):
      cpumask: fix incorrect cpumask scanning result checks
      cpumask: be more careful with 'cpumask_setall()'
      x86/resctl: fix scheduler confusion with 'current'
      cpumask: relax sanity checking constraints
      Linux 6.3-rc2

Liu Jian (1):
      bpf, sockmap: Fix an infinite loop error when len is 0 in
tcp_bpf_recvmsg_parser()

Lorenz Bauer (2):
      btf: fix resolving BTF_KIND_VAR after ARRAY, STRUCT, UNION, PTR
      selftests/bpf: check that modifier resolves after pointer

Lukas Bulwahn (1):
      MAINTAINERS: repair a malformed T: entry in IDMAPPED MOUNTS

Mario Limonciello (2):
      drm/amd: Fix initialization mistake for NBIO 7.3.0
      tpm: disable hwrng for fTPM on some AMD designs

Maurizio Lombardi (1):
      scsi: target: iscsi: Fix an error message in iscsi_check_key()

Michael Chan (1):
      bnxt_en: Avoid order-5 memory allocation for TPA data

Michael Kelley (1):
      scsi: storvsc: Handle BlockSize change in Hyper-V VHD/VHDX file

Michael Schmitz (1):
      m68k: Only force 030 bus error if PC not in exception table

Michal Swiatkowski (1):
      ice: don't ignore return codes in VSI related code

Miquel Raynal (1):
      ieee802154: Prevent user from crashing the host

Morten Linderud (1):
      tpm/eventlog: Don't abort tpm_read_log on faulty ACPI address

Namhyung Kim (2):
      perf test: Fix offcpu test prev_state check
      perf inject: Fix --buildid-all not to eat up MMAP2

Naohiro Aota (1):
      btrfs: fix unnecessary increment of read error stat on write error

Pablo Neira Ayuso (2):
      netfilter: nft_last: copy content when cloning expression
      netfilter: nft_quota: copy content when cloning expression

Palmer Dabbelt (1):
      RISC-V: Stop emitting attributes

Pedro Tammela (1):
      net/sched: act_connmark: handle errno on tcf_idr_check_alloc

Petr Oros (1):
      ice: copy last block omitted in ice_get_module_eeprom()

Philipp Hortmann (2):
      staging: rtl8192e: Remove function ..dm_check_ac_dc_power calling a s=
cript
      staging: rtl8192e: Remove call_usermodehelper starting RadioPower.sh

Qu Wenruo (1):
      btrfs: ioctl: return device fsid from DEV_INFO ioctl

Rafa=C5=82 Mi=C5=82ecki (1):
      bgmac: fix *initial* chip reset to support BCM5358

Rafa=C5=82 Szalecki (1):
      HID: logitech-hidpp: Add support for Logitech MX Master 3S mouse

Randy Dunlap (4):
      riscv, bpf: Fix patch_text implicit declaration
      platform: mellanox: select REGMAP instead of depending on it
      platform: x86: MLX_PLATFORM: select REGMAP instead of depending on it
      drm/msm: DEVFREQ_GOV_SIMPLE_ONDEMAND is no longer needed

Ranjan Kumar (6):
      scsi: mpi3mr: ioctl timeout when disabling/enabling interrupt
      scsi: mpi3mr: Driver unload crashes host when enhanced logging is ena=
bled
      scsi: mpi3mr: Wait for diagnostic save during controller init
      scsi: mpi3mr: Return proper values for failures in firmware init path
      scsi: mpi3mr: NVMe command size greater than 8K fails
      scsi: mpi3mr: Bad drive in topology results kernel crash

Reka Norman (1):
      HID: intel-ish-hid: ipc: Fix potential use-after-free in work functio=
n

Richard Weinberger (1):
      ubi: block: Fix missing blk_mq_end_request

Rob Clark (1):
      drm/msm: Fix potential invalid ptr free

Rongguang Wei (1):
      net: stmmac: add to set device wake up flag when stmmac init phy

Russell King (Oracle) (1):
      net: phylib: get rid of unnecessary locking

Sagi Grimberg (1):
      docs: sysfs-block: document hidden sysfs entry

Selvin Xavier (1):
      bnxt_en: Fix the double free during device removal

Seth Forshee (1):
      filelocks: use mount idmapping for setlease permission check

Shashank Sharma (1):
      drm/amdgpu: fix return value check in kfd

Shigeru Yoshida (1):
      net: caif: Fix use-after-free in cfusbl_device_notify()

Shin'ichiro Kawasaki (1):
      scsi: sd: Fix wrong zone_write_granularity value during revalidate

Srinivas Pandruvada (4):
      thermal: intel: int340x: processor_thermal: Fix deadlock
      platform/x86: ISST: Increase range of valid mail box commands
      platform/x86/intel/tpmi: Fix double free reported by Smatch
      platform/x86: ISST: Fix kernel documentation warnings

Stephen Hemminger (1):
      mailmap: update entries for Stephen Hemminger

Suman Ghosh (1):
      octeontx2-af: Unlock contexts in the queue context cache in case
of fault detection

Swapnil Patel (1):
      drm/amd/display: Update clock table to include highest clock setting

Thadeu Lima de Souza Cascardo (1):
      net: avoid double iput when sock_alloc_file fails

Theodore Ts'o (2):
      fs: prevent out-of-bounds array speculation when closing a file descr=
iptor
      ext4, jbd2: add an optimized bmap for the journal inode

Thomas Wei=C3=9Fschuh (1):
      ext4: make kobj_type structures constant

Thomas Zimmermann (1):
      drm/msm: Fix possible uninitialized access in fbdev

Tobias Klauser (2):
      fork: allow CLONE_NEWTIME in clone3 flags
      selftests/clone3: test clone3 with CLONE_NEWTIME

Tudor Ambarus (1):
      ext4: Fix comment about the 64BIT feature

Uwe Kleine-K=C3=B6nig (9):
      misc: ad525x_dpot-i2c: Convert to i2c's .probe_new()
      mtd: maps: pismo: Convert to i2c's .probe_new()
      serial: sc16is7xx: Convert to i2c's .probe_new()
      w1: ds2482: Convert to i2c's .probe_new()
      media: i2c: ov5695: convert to i2c's .probe_new()
      media: i2c: ov2685: convert to i2c's .probe_new()
      i2c: Switch .probe() to not take an id parameter
      i2c: mux: Convert all drivers to new .probe() callback
      i2c: Convert drivers to new .probe() callback

Veerabadhran Gopalakrishnan (1):
      drm/amdgpu/soc21: Add video cap query support for VCN_4_0_4

Vladimir Oltean (3):
      powerpc: dts: t1040rdb: fix compatible string for Rev A boards
      powerpc: dts: t1040rdb: enable both CPU ports
      net: dsa: mt7530: permit port 5 to work without port 6 on MT7621 SoC

Wu Bo (1):
      docs: ext4: modify the group desc size to 64

Yangtao Li (1):
      erofs: mark z_erofs_lzma_init/erofs_pcpubuf_init w/ __init

Ye Bin (4):
      ext4: move where set the MAY_INLINE_DATA flag is set
      ext4: fix WARNING in ext4_update_inline_data
      ext4: commit super block if fs record error when journal record
without error
      ext4: make sure fs error flag setted before clear journal error

Yu Kuai (2):
      block: fix wrong mode for blkdev_put() from disk_scan_partitions()
      block, bfq: fix uaf for 'stable_merge_bfqq'

Yue Hu (1):
      erofs: use wrapper i_blocksize() in erofs_file_read_iter()

Yuiko Oshino (1):
      net: lan78xx: fix accessing the LAN7800's internal phy specific
registers from the MAC driver

Zhihao Cheng (1):
      ext4: zero i_disksize when initializing the bootloader inode

lyndonli (2):
      drm/amdgpu: Fix call trace warning and hang when removing amdgpu devi=
ce
      drm/amdgpu: Fix the warning info when removing amdgpu device

void0red (1):
      btrfs: handle btrfs_del_item errors in __btrfs_update_delayed_inode
