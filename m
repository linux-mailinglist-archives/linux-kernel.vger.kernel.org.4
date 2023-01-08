Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9B06617C6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbjAHSHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236199AbjAHSHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:07:08 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8AB2625
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 10:07:06 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id y8so4712479qvn.11
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 10:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oWAHf6Zki2SOqV4NpWLH8jb645+YeZkQg7TJaPqOmmY=;
        b=PhLTRAdKXNHOPw3b/BruoOXcDRkXnoyBFBUyK/Vmvvkx8K80tAwO5BqFqe1pRFGJE0
         GJ+qa4vBQBjSy4sCSnXwINUGR0QCgqr22D4E+Wj7rrnzc4H78YPmUjk3eSaVesplysRH
         NlsrV29p9TRZFJaUTGqmjGh3Fs7vSiJb+0/G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWAHf6Zki2SOqV4NpWLH8jb645+YeZkQg7TJaPqOmmY=;
        b=Sp8eRZYUJTK7nwFnn/NUIv0pQFtS1fJ+sQRXVT3vKbNWZAramazY8iS1jVMulm6R0/
         XV76N4UlaGQmgYwj3b8m51/FXf1AWAEz/9/LmS2QSah9sbt0XMQ3Mu21vgNovbBRtIEs
         k3oq2mdb1pA48licRhcgmxHlZW5k2CtSsheS1DoK7/mOqOBXuGXGg2vhNSVEOX9HpycC
         vw8lns5NeR/j8InljvOw8qtObqy31033/n6UGzcrf53+K1OJfRHDssKyIRNQwbS3z8Rg
         QziK9BEC2rP4Nu4+wrLedP8AT/jzQPTiJlypwlAAmB5ot4M4zaioB6l0xmQYyrNX4eyd
         Pqag==
X-Gm-Message-State: AFqh2koEEsm9jdUVu4QgOh2eG4/ScqRxEhzN4hyk5zFRyIMRQvrezzZ5
        UAn8fQbYDH0qVY1caLRsTRBkZYiYGm256gUl
X-Google-Smtp-Source: AMrXdXtgZrXXK1FQ1U9ZB5rXBWJaGN0XKI9sS+lzPEpnSKKA+Vfw50KISNT48NJIzjuhVQzUl7ZIug==
X-Received: by 2002:a05:6214:4386:b0:4c7:47f:5511 with SMTP id oh6-20020a056214438600b004c7047f5511mr91807339qvb.48.1673201224622;
        Sun, 08 Jan 2023 10:07:04 -0800 (PST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id u12-20020a05620a430c00b006ee949b8051sm4002817qko.51.2023.01.08.10.07.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 10:07:04 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id h26so6289202qtu.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 10:07:04 -0800 (PST)
X-Received: by 2002:ac8:67da:0:b0:3a5:122:fb79 with SMTP id
 r26-20020ac867da000000b003a50122fb79mr1711812qtp.452.1673201223483; Sun, 08
 Jan 2023 10:07:03 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Jan 2023 12:06:47 -0600
X-Gmail-Original-Message-ID: <CAHk-=wjwrqFcC9-KkfboqATYwLfJHi_8Z5mTrJh=nf8KT_SjUA@mail.gmail.com>
Message-ID: <CAHk-=wjwrqFcC9-KkfboqATYwLfJHi_8Z5mTrJh=nf8KT_SjUA@mail.gmail.com>
Subject: Linux 6.2-rc3
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

Here we are, another week done, and things are starting to look a lot
more normal after that very quiet holiday week that made rc2 so very
small.

Nothing in particular here stands out: the bulk of this is driver
fixes (networking, gpu, block, virtio - but also usb, fbdev, rdma etc,
so a little bit of everything).  That is as should be, and just
matches where the bulk of the code is.

Outside of the various driver fixes, we've got core networking, some
filesystem fixes (btrfs, cifs, f2fs and nfs), and some perf tooling
work.

With the rest being mostly selftests and documentation.

The shortlog is below, plase do give it a good test, and holler if you
find anything.

               Linus

---

Aaron Conole (1):
      net: openvswitch: release vport resources on failure

Aaron Thompson (1):
      memblock tests: Fix compilation error.

Adham Faris (1):
      net/mlx5e: Fix hw mtu initializing at XDP SQ allocation

Ahelenia Ziemia=C5=84ska (1):
      perf tools: Don't include signature in version strings

Alex Elder (1):
      net: ipa: use proper endpoint mask for suspend

Alexei Starovoitov (1):
      selftests/bpf: Temporarily disable part of btf_dump:var_data test.

Andreas Rammhold (1):
      of/fdt: run soc memory setup when early_init_dt_scan_memory fails

Angus Chen (2):
      virtio_pci: modify ENOENT to EINVAL
      virtio_blk: use UINT_MAX instead of -1U

Antoine Tenart (1):
      net: vrf: determine the dst using the original ifindex for multicast

Anton Protopopov (1):
      bpftool: Fix linkage with statically built libllvm

Anuradha Weeraman (1):
      net: ethernet: marvell: octeontx2: Fix uninitialized variable warning

Arnaldo Carvalho de Melo (2):
      perf tools: Fix segfault when trying to process tracepoints in
perf.data and not linked with libtraceevent
      perf test record_probe_libc_inet_pton: Fix failure due to extra
inet_pton() backtrace in glibc >=3D 2.35

Arnd Bergmann (6):
      wifi: mt76: mt7996: select CONFIG_RELAY
      wifi: ath9k: use proper statements in conditionals
      drm/tests: reduce drm_mm_test stack usage
      usb: fotg210: fix OTG-only build
      fbdev: omapfb: avoid stack overflow warning
      usb: dwc3: xilinx: include linux/gpio/consumer.h

Ben Dooks (1):
      riscv: uaccess: fix type of 0 variable on error in get_user()

Bj=C3=B6rn T=C3=B6pel (1):
      riscv, kprobes: Stricter c.jr/c.jalr decoding

Boris Burkov (1):
      btrfs: fix resolving backrefs for inline extent followed by prealloc

Caleb Sander (1):
      qed: allow sleep in qed_mcp_trace_dump()

Carlo Caione (1):
      drm/meson: Reduce the FIFO lines held when AFBC is not used

Chao Yu (1):
      f2fs: fix to avoid NULL pointer dereference in f2fs_issue_flush()

Chengen Du (1):
      NFS: Judge the file access cache's timestamp in rcu path

Chris Mi (2):
      net/mlx5e: CT: Fix ct debugfs folder name
      net/mlx5e: Always clear dest encap in neigh-update-del

Chris Wilson (1):
      perf/x86/rapl: Treat Tigerlake like Icelake

Christian K=C3=B6nig (1):
      dma-buf: fix dma_buf_export init order v2

Christian Marangi (5):
      net: dsa: qca8k: fix wrong length value for mgmt eth packet
      net: dsa: tag_qca: fix wrong MGMT_DATA2 size
      Revert "net: dsa: qca8k: cache lo and hi for mdio write"
      net: dsa: qca8k: introduce single mii read/write lo/hi
      net: dsa: qca8k: improve mdio master read/write by using single lo/hi

Christophe JAILLET (2):
      btrfs: fix an error handling path in btrfs_rename()
      btrfs: fix an error handling path in btrfs_defrag_leaves()

Chuang Wang (1):
      bpf: Fix panic due to wrong pageattr of im->image

Chunhao Lin (2):
      r8169: move rtl_wol_enable_rx() and rtl_prepare_power_down()
      r8169: fix dmar pte write access is not set error

Cindy Lu (2):
      vhost_vdpa: fix the crash in unmap a large memory
      vdpa_sim_net: should not drop the multicast/broadcast packet

Cixi Geng (3):
      gpio: eic-sprd: Make the irqchip immutable
      gpio: pmic-eic-sprd: Make the irqchip immutable
      gpio: sprd: Make the irqchip immutable

Colin Ian King (1):
      RDMA/mlx5: remove variable i

Dan Carpenter (1):
      drm/i915: unpin on error in intel_vgpu_shadow_mm_pin()

Daniil Tatianin (5):
      qlcnic: prevent ->dcb use-after-free on qlcnic_dcb_enable() failure
      net/ethtool/ioctl: return -EOPNOTSUPP if we have no phy stats
      net/ethtool/ioctl: remove if n_stats checks from ethtool_get_phy_stat=
s
      net/ethtool/ioctl: split ethtool_get_phy_stats into multiple helpers
      drivers/net/bonding/bond_3ad: return when there's no aggregator

David Arinzon (7):
      net: ena: Fix toeplitz initial hash value
      net: ena: Don't register memory info on XDP exchange
      net: ena: Account for the number of processed bytes in XDP
      net: ena: Use bitmask to indicate packet redirection
      net: ena: Fix rx_copybreak value update
      net: ena: Set default value for RX interrupt moderation
      net: ena: Update NUMA TPH hint register upon NUMA node update

David Howells (1):
      rxrpc: Fix a couple of potential use-after-frees

Davidlohr Bueso (2):
      tools/virtio: remove stray characters
      tools/virtio: remove smp_read_barrier_depends()

Dawei Li (1):
      virtio: Implementing attribute show with sysfs_emit

Dmitry Fomichev (1):
      virtio-blk: use a helper to handle request queuing errors

Dmitry Osipenko (2):
      drm/scheduler: Fix lockup in drm_sched_entity_kill()
      drm/scheduler: Fix lockup in drm_sched_entity_kill()

Dragos Tatulea (1):
      net/mlx5e: IPoIB, Don't allow CQE compression to be turned on by defa=
ult

Eli Cohen (6):
      vdpa/mlx5: Fix rule forwarding VLAN to TIR
      vdpa/mlx5: Return error on vlan ctrl commands if not supported
      vdpa/mlx5: Fix wrong mac address deletion
      vdpa/mlx5: Avoid using reslock in event_handler
      vdpa/mlx5: Avoid overwriting CVQ iotlb
      net/mlx5: Lag, fix failure to cancel delayed bond work

Eric Dumazet (2):
      bonding: fix lockdep splat in bond_miimon_commit()
      inet: control sockets should not use current thread task_frag

Eric Lin (1):
      perf tools riscv: Fix build error on riscv due to missing header
for 'struct perf_sample'

Ferry Toth (1):
      Revert "usb: ulpi: defer ulpi_register on ulpi_read_id timeout"

Filipe Manana (3):
      btrfs: fix leak of fs devices after removing btrfs module
      btrfs: fix fscrypt name leak after failure to join log transaction
      btrfs: fix off-by-one in delalloc search during lseek

Florian Westphal (1):
      netfilter: conntrack: fix ipv6 exthdr error check

Geetha sowjanya (1):
      octeontx2-pf: Fix lmtst ID used in aura free

Haibo Chen (1):
      gpio: pca953x: avoid to use uninitialized value pinctrl

Hans de Goede (1):
      gpiolib: Fix using uninitialized lookup-flags on ACPI platforms

Hao Sun (2):
      bpf: fix nullness propagation for reg to reg comparisons
      selftests/bpf: check null propagation only neither reg is PTR_TO_BTF_=
ID

Harshit Mogalapalli (1):
      vduse: Validate vq_num in vduse_validate_config()

Hawkins Jiawei (1):
      net: sched: fix memory leak in tcindex_set_parms

Horatiu Vultur (2):
      net: lan966x: Fix configuration of the PCS
      net: sparx5: Fix reading of the MAC address

Hou Tao (1):
      bpf: Define sock security related BTF IDs under CONFIG_SECURITY_NETWO=
RK

Ian Rogers (1):
      perf build: Don't propagate subdir to submakes for install_headers

Ido Schimmel (1):
      vxlan: Fix memory leaks in error path

Ira Weiny (1):
      cifs: Fix kmap_local_page() unmapping

Jaegeuk Kim (4):
      f2fs: initialize extent_cache parameter
      f2fs: don't mix to use union values in extent_info
      f2fs: should use a temp extent_info for lookup
      f2fs: let's avoid panic if extent_tree is not created

Jakub Kicinski (3):
      bpf: pull before calling skb_postpull_rcsum()
      docs: netdev: reshuffle sections in prep for de-FAQization
      docs: netdev: convert to a non-FAQ document

Jamal Hadi Salim (2):
      net: sched: atm: dont intepret cls results when asked to drop
      net: sched: cbq: dont intepret cls results when asked to drop

Jan Kara (1):
      udf: Fix extension of the last extent in the file

Jason A. Donenfeld (2):
      x86/insn: Avoid namespace clash by separating instruction
decoder MMIO type from MMIO trace type
      tpm: Allow system suspend to continue when TPM suspend fails

Jason Wang (2):
      vdpa: conditionally fill max max queue pair for stats
      vdpasim: fix memory leak when freeing IOTLBs

Jeff Layton (2):
      nfsd: shut down the NFSv4 state objects before the filecache
      nfsd: fix handling of readdir in v4root vs. mount upcall timeout

Jens Axboe (8):
      io_uring/io-wq: free worker if task_work creation is canceled
      ARM: renumber bits related to _TIF_WORK_MASK
      block: handle bio_split_to_limits() NULL return
      block: don't allow splitting of a REQ_NOWAIT bio
      io_uring: move 'poll_multi_queue' bool in io_ring_ctx
      Revert "block: bio_copy_data_iter"
      Revert "block: remove devnode callback from struct
block_device_operations"
      Revert "pktcdvd: remove driver."

Jesus Sanchez-Palencia (1):
      perf tools: Fix build on uClibc systems by adding missing
sys/types.h include

Jian Shen (3):
      net: hns3: fix miss L3E checking for rx packet
      net: hns3: fix VF promisc mode not update when mac table full
      net: hns3: refine the handling for VF heartbeat

Jie Wang (1):
      net: hns3: add interrupts re-initialization while doing VF FLR

Jiguang Xiao (1):
      net: amd-xgbe: add missed tasklet_kill

Jiri Pirko (1):
      net/mlx5: Add forgotten cleanup calls into mlx5_init_once() error pat=
h

Jiri Slaby (SUSE) (1):
      RDMA/srp: Move large values to a new enum for gcc13

Johannes Berg (1):
      wifi: iwlwifi: fw: skip PPAG for JF

Johnny S. Lee (1):
      net: dsa: mv88e6xxx: depend on PTP conditionally

Josef Bacik (2):
      btrfs: restore BTRFS_SEQ_LAST when looking up qgroup backref lookup
      btrfs: scrub: fix uninitialized return value in recover_scrub_rbio

Jozsef Kadlecsik (2):
      netfilter: ipset: fix hash:net,port,net hang with /0 subnet
      netfilter: ipset: Rework long task execution when adding/deleting ent=
ries

Kees Cook (1):
      bpf: Always use maximal size for copy_array()

Krzysztof Kozlowski (1):
      dt-bindings: soundwire: qcom,soundwire: correct sizes related to
number of ports

Kui-Feng Lee (2):
      bpf: keep a reference to the mm, in case the task is dead.
      selftests/bpf: add a test for iter/task_vma for short-lived processes

Kuniyuki Iwashima (2):
      tcp: Add TIME_WAIT sockets in bhash2.
      tcp: Add selftest for bind() and TIME_WAIT.

Linus Torvalds (2):
      hfs/hfsplus: avoid WARN_ON() for sanity check, use proper error handl=
ing
      Linux 6.2-rc3

Lukas Bulwahn (1):
      wifi: ti: remove obsolete lines in the Makefile

Ma Jun (1):
      drm/plane-helper: Add the missing declaration of drm_atomic_state

Maciej Fijalkowski (1):
      ice: xsk: do not use xdp_return_frame() on tx_buf->raw_buf

Maor Dickman (1):
      net/mlx5e: Set geneve_tlv_option_0_exist when matching on geneve opti=
on

Maor Gottlieb (1):
      RDMA/mlx5: Fix validation of max_rd_atomic caps for DC

Martin KaFai Lau (1):
      selftests/bpf: Test bpf_skb_adjust_room on CHECKSUM_PARTIAL

Masahiro Yamada (2):
      kbuild: fix single *.ko build
      kbuild: readd -w option when vmlinux.o or Module.symver is missing

Miaoqian Lin (5):
      nfc: Fix potential resource leaks
      net: phy: xgmiitorgmii: Fix refcount leak in xgmiitorgmii_probe
      gpio: sifive: Fix refcount leak in sifive_gpio_probe
      perf tools: Fix resources leak in perf_data__open_dir()
      memblock: Fix doc for memblock_phys_free

Michael Chan (4):
      bnxt_en: Simplify bnxt_xdp_buff_init()
      bnxt_en: Fix XDP RX path
      bnxt_en: Fix first buffer size calculations for XDP multi-buffer
      bnxt_en: Fix HDS and jumbo thresholds for RX packets

Michael Ellerman (3):
      powerpc/vmlinux.lds: Define RUNTIME_DISCARD_EXIT
      powerpc/vmlinux.lds: Don't discard .rela* for relocatable builds
      powerpc/vmlinux.lds: Don't discard .comment

Micha=C5=82 Grzelak (1):
      dt-bindings: net: marvell,orion-mdio: Fix examples

Michel D=C3=A4nzer (1):
      Revert "drm/amd/display: Enable Freesync Video Mode by default"

Mikulas Patocka (1):
      x86/asm: Fix an assembler warning with current binutils

Ming Lei (1):
      ublk: honor IO_URING_F_NONBLOCK for handling control command

Moshe Shemesh (1):
      net/mlx5: E-Switch, properly handle ingress tagged packets on VST

Mukul Joshi (1):
      drm/amdkfd: Fix kernel warning during topology setup

Namhyung Kim (2):
      perf stat: Fix handling of unsupported cgroup events when using
BPF counters
      perf stat: Fix handling of --for-each-cgroup with --bpf-counters
to match non BPF mode

Naohiro Aota (1):
      btrfs: fix trace event name typo for FLUSH_DELAYED_REFS

Nikolaus Voss (1):
      crypto: caam - fix CAAM io mem access in blob_gen

Olga Kornievskaia (1):
      pNFS/filelayout: Fix coalescing test for single DS

Pablo Neira Ayuso (4):
      netfilter: nf_tables: consolidate set description
      netfilter: nf_tables: add function to create set stateful expressions
      netfilter: nf_tables: perform type checking for existing sets
      netfilter: nf_tables: honor set timeout and garbage collection update=
s

Paolo Abeni (3):
      mptcp: fix deadlock in fastopen error path
      mptcp: fix lockdep false positive
      net/ulp: prevent ULP without clone op from entering the LISTEN status

Paul E. McKenney (1):
      block: Remove "select SRCU"

Paul Menzel (1):
      fbdev: matroxfb: G200eW: Increase max memory from 1 MB to 16 MB

Paulo Alcantara (3):
      cifs: ignore ipc reconnect failures during dfs failover
      cifs: fix race in assemble_neg_contexts()
      cifs: protect access of TCP_Server_Info::{dstaddr,hostname}

Pavel Begunkov (3):
      io_uring: pin context while queueing deferred tw
      io_uring: lockdep annotate CQ locking
      io_uring: fix CQ waiting timeout handling

Pedro Tammela (1):
      net/sched: fix retpoline wrapper compilation on configs without tc fi=
lters

Philipp Zabel (1):
      drm/imx: ipuv3-plane: Fix overlay plane width

Po-Hsu Lin (3):
      selftests: net: fix cmsg_so_mark.sh test hang
      selftests: net: fix cleanup_v6() for arp_ndisc_evict_nocarrier
      selftests: net: return non-zero for failures reported in
arp_ndisc_evict_nocarrier

Qu Wenruo (5):
      btrfs: add error message for metadata level mismatch
      btrfs: fix false alert on bad tree level check
      btrfs: handle case when repair happens with dev-replace
      btrfs: always report error in run_one_delayed_ref()
      btrfs: fix compat_ro checks against remount

Rafael Mendonca (1):
      virtio_blk: Fix signedness bug in virtblk_prep_rq()

Randy Dunlap (2):
      fbdev: make offb driver tristate
      net: sched: htb: fix htb_classify() kernel-doc

Ricardo Ca=C3=B1uelo (1):
      tools/virtio: initialize spinlocks in vring_test.c

Rob Herring (2):
      Revert "of: fdt: Honor CONFIG_CMDLINE* even without /chosen node"
      of: fdt: Honor CONFIG_CMDLINE* even without /chosen node, take 2

Rodrigo Branco (1):
      x86/bugs: Flush IBP in ib_prctl_set()

Ronak Doshi (1):
      vmxnet3: correctly report csum_level for encapsulated packet

Rong Tao (1):
      atm: uapi: fix spelling typos in comments

Rong Wang (1):
      vdpa/vp_vdpa: fix kfree a wrong pointer in vp_vdpa_remove

Samson Tam (1):
      drm/amd/display: Uninitialized variables causing 4k60 UCLK to
stay at DPM1 and not DPM0

Samuel Holland (1):
      dt-bindings: net: sun8i-emac: Add phy-supply property

Sean Anderson (3):
      powerpc: dts: t208x: Disable 10G on MAC1 and MAC2
      net: phy: Update documentation for get_rate_matching
      net: dpaa: Fix dtsec check for PCS availability

Shaomin Deng (1):
      tools: Delete the unneeded semicolon after curly braces

Shaoqin Huang (2):
      virtio_pci: use helper function is_power_of_2()
      virtio_ring: use helper function is_power_of_2()

Shawn Bohrer (1):
      veth: Fix race with AF_XDP exposing old or uninitialized descriptors

Shay Drory (4):
      net/mlx5: Fix io_eq_size and event_eq_size params validation
      net/mlx5: Avoid recovery in probe flows
      net/mlx5: Fix RoCE setting at HCA level
      RDMA/mlx5: Fix mlx5_ib_get_hw_stats when used for device

Shyam Prasad N (2):
      cifs: refcount only the selected iface during interface update
      cifs: fix interface count calculation during refresh

Si-Wei Liu (1):
      vdpa: merge functionally duplicated dev_features attributes

Srinivas Pandruvada (1):
      thermal: int340x: Add missing attribute for data rate base

Srivatsa S. Bhat (VMware) (1):
      MAINTAINERS: Update maintainers for ptp_vmw driver

Stanislav Fomichev (1):
      selftests/bpf: Add host-tools to gitignore

Stefano Garzarella (4):
      vringh: fix range used in iotlb_translate()
      vhost: fix range used in translate_desc()
      vhost-vdpa: fix an iotlb memory leak
      vdpa_sim: fix vringh initialization in vdpasim_queue_ready()

Steven Price (1):
      drm/panfrost: Fix GEM handle creation ref-counting

Szymon Heidrich (1):
      usb: rndis_host: Secure rndis_query check against int overflow

Takashi Iwai (1):
      x86/kexec: Fix double-free of elf header buffer

Tanmay Bhushan (1):
      btrfs: fix ASSERT em->len condition in btrfs_get_extent

Tariq Toukan (1):
      net/mlx5e: Fix RX reporter for XSK RQs

Tetsuo Handa (1):
      fs/ntfs3: don't hold ni_lock when calling truncate_setsize()

Thinh Nguyen (1):
      usb: dwc3: gadget: Ignore End Transfer delay on teardown

Thomas Richter (2):
      perf lock contention: Fix core dump related to not finding the
"__sched_text_end" symbol on s/390
      perf test record_probe_libc_inet_pton: Fix test on s/390 where
'text_to_binary_address' now appears on the backtrace

Tianjia Zhang (1):
      crypto: arm64/sm4 - fix possible crash with CFI enabled

Tom Rix (1):
      udf: initialize newblock to 0

Trond Myklebust (1):
      NFS: Fix up a sparse warning

Uwe Kleine-K=C3=B6nig (2):
      net: ethernet: broadcom: bcm63xx_enet: Drop empty platform remove fun=
ction
      net: ethernet: freescale: enetc: Drop empty platform remove function

Vikas Gupta (1):
      bnxt_en: fix devlink port registration to netdev

Wei Yongjun (1):
      virtio-crypto: fix memory leak in
virtio_crypto_alg_skcipher_close_session()

Xiu Jianfeng (1):
      drm/virtio: Fix memory leak in virtio_gpu_object_create()

Xiubo Li (2):
      ceph: switch to vfs_inode_has_locks() to fix file lock bug
      ceph: avoid use-after-free in ceph_fl_release_lock()

Xu Panda (2):
      fbdev: omapfb: use strscpy() to instead of strncpy()
      fbdev: atyfb: use strscpy() to instead of strncpy()

Xuezhi Zhang (1):
      s390/qeth: convert sysfs snprintf to sysfs_emit

Yang Jihong (1):
      perf help: Use HAVE_LIBTRACEEVENT to filter out unsupported commands

Yang Yingliang (1):
      usb: fotg210-udc: fix error return code in fotg210_udc_probe()

Yinjun Zhang (1):
      nfp: fix schedule in atomic context when sync mc address

Yishai Hadas (1):
      lib/scatterlist: Fix to merge contiguous pages into the last SG prope=
rly

Yoshihiro Shimoda (2):
      net: ethernet: renesas: rswitch: Fix error path in renesas_eth_sw_pro=
be()
      net: ethernet: renesas: rswitch: Fix getting mac address from device =
tree

Yuan Can (1):
      vhost/vsock: Fix error handling in vhost_vsock_init()

Zhang Rui (2):
      perf/x86/rapl: Add support for Intel Meteor Lake
      perf/x86/rapl: Add support for Intel Emerald Rapids

Zheng Wang (1):
      drm/i915/gvt: fix double free bug in split_2MB_gtt_entry

Zhengchao Shao (1):
      caif: fix memory leak in cfctrl_linkup_request()

Zhenyu Wang (2):
      drm/i915/gvt: fix gvt debugfs destroy
      drm/i915/gvt: fix vgpu debugfs clean in remove

Zhi Wang (1):
      drm/i915/gvt: use atomic operations to change the vGPU status

minoura makoto (1):
      SUNRPC: ensure the matching upcall is in-flight upon downcall

ruanjinjie (1):
      vdpa_sim: fix possible memory leak in vdpasim_net_init() and
vdpasim_blk_init()

wangjianli (1):
      tools/virtio: Variable type completion
