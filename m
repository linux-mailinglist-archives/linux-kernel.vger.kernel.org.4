Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28671639D65
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 22:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiK0Vuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 16:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiK0Vuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 16:50:44 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6230CB4AF
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:50:41 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id j26so6048609qki.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vcaw4oM6IlIShT7slLmNgSoCb/E0dezykcWKT9oB+zU=;
        b=JVDxL4hprh+PXYzOWGtQPieepE7GEUwoCwBlZ4uI/h2RYDsJ1s8KfECqbxf7dsrTGW
         8cdJxGqfBJ1recNkhO4+UVBqHJS6dqXXbK9ABkhWLJrv4qo5uLz6EZftIPpi2iduES8Y
         SRGvDo3qj6BEJYtCV0somapk8oAxhuZxx5/xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vcaw4oM6IlIShT7slLmNgSoCb/E0dezykcWKT9oB+zU=;
        b=SFcq5LnbJRp7v2ALGIzPokyRAOsFTcK1M7VW4+PurbtyTLsm/cNSwzwsz9F09xgrM6
         hRiW4JxwnyDyOqeCpWT06nk5/WayqNvvqNRQy6/U9ETDrRoYBNZGQyTn1lNjqzsPbRhw
         TaWB3Tj0+dX5xasHam0Xa7/UXsci6MEN2LqzXML/JlIna0HfSX921Xb493EEVdaPbN3p
         7oXfb8N9XoRpBB99knseuihoKLNWvQ6duiY+HwabneNtqgByZLfIuZ+3L682vvZlr6CY
         qFX996uk0DOitBqVmRH/pPpD4JcNt/fmBXVFw8Ni73Ennts58BK5ss87xjRoE0hC9J2E
         MM5w==
X-Gm-Message-State: ANoB5pkDpE78TVkz2Wv4dpYE2oqQa6wDcfrCAUR0KJ38JVUAfMTcGLhI
        0PM9g/jeOa37SBxQ/rszjGKhavqrNa2cmg==
X-Google-Smtp-Source: AA0mqf4s0/vr0NiGxz80c4EHJAw1TcOmDbmsrmjAoW6Ntfeyk2rSWsU0tiRQgUhbhFFJYL+rBk/EQw==
X-Received: by 2002:a37:b0c:0:b0:6f9:9e05:1677 with SMTP id 12-20020a370b0c000000b006f99e051677mr43973867qkl.506.1669585839611;
        Sun, 27 Nov 2022 13:50:39 -0800 (PST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id d4-20020a05620a240400b006fa43e139b5sm7105434qkn.59.2022.11.27.13.50.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 13:50:39 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id j26so6048580qki.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:50:39 -0800 (PST)
X-Received: by 2002:a37:8883:0:b0:6fb:628a:1aea with SMTP id
 k125-20020a378883000000b006fb628a1aeamr43696894qkd.697.1669585838364; Sun, 27
 Nov 2022 13:50:38 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Nov 2022 13:50:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgUZwX8Sbb8Zvm7FxWVfX6CGuE7x+E16VKoqL7Ok9vv7g@mail.gmail.com>
Message-ID: <CAHk-=wgUZwX8Sbb8Zvm7FxWVfX6CGuE7x+E16VKoqL7Ok9vv7g@mail.gmail.com>
Subject: Linux 6.1-rc7
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

Another week has gone by. It started quietly, and I was fairly sure
that it being Thanksgiving week here in the US would mean that it
would continue fairly quietly too.

But I was wrong. The end of the week was the usual "people send me
their stuff on Friday", and the weekend hardly slowed people down. And
so the stats for this week look almost exactly the same as they did
for the previous two weeks.

And it's not just the statistics - everything feels very similar.
There is really nothing here that makes me at all worried, except that
it's just a bit more than I'm comfortable with. It should just have
slowed down more by now.

As a result, I'm now pretty sure that this is going to be one of those
"we'll have an extra week and I'll make an rc8" releases. Which then
in turn means that now the next merge window will be solidly in the
holiday season. Whatever. It is what it is.

Now, this means that I will be more hard-nosed than usual in the next
merge window: the usual rule is that things that I get sent for the
merge window should have been all ready _before_ the merge window
opened. But with the merge window happening largely during the holiday
season, I'll just be enforcing that pretty strictly. I want to see all
that work in the pull requests having been done *before* the
festivities, not while you're imbibing your egg-nog and just generally
being stressed out about the season. If I get sent pull requests late,
I'll just go "this can wait". Ok?

Now, I suspect that everybody _else_ wants to get their work out
before the holiday season starts too, so I hope that we're all in
complete and violent agreement about this all. But I thought I'd start
making people aware of this.

Anyway, enough about the next release. Right now we're still in the
last couple of weeks of this one, so let's make it count. Go test, and
can we _please_ just start calming things down? Don't send me anything
that isn't a clear and present bug. No more last-minute cleanups.
Hear?

            Linus

---

Alejandro Concepci=C3=B3n Rodr=C3=ADguez (1):
      iio: light: apds9960: fix wrong register for gesture gain

Alex Deucher (2):
      drm/amdgpu/psp: don't free PSP buffers on suspend
      drm/amdgpu: Partially revert "drm/amdgpu: update
drm_display_info correctly when the edid is read"

Alex Hung (2):
      mailmap: update Alex Hung's email address
      MAINTAINERS: update Alex Hung's email address

Alexandre Belloni (1):
      init/Kconfig: fix CC_HAS_ASM_GOTO_TIED_OUTPUT test with dash

Alistair Popple (2):
      mm/memory: return vm_fault_t result from migrate_to_ram() callback
      mm/migrate_device: return number of migrating pages in args->cpages

Amir Goldstein (1):
      vfs: fix copy_file_range() averts filesystem freeze protection

Anand Jain (3):
      btrfs: free btrfs_path before copying inodes to userspace
      btrfs: free btrfs_path before copying fspath to userspace
      btrfs: free btrfs_path before copying subvol info to userspace

Andreas Kemnade (2):
      regulator: twl6030: re-add TWL6032_SUBCLASS
      regulator: twl6030: fix get status of twl6032 regulators

Aneesh Kumar K.V (1):
      mm/cgroup/reclaim: fix dirty pages throttling on cgroup v1

Baokun Li (1):
      ext4: fix use-after-free in ext4_ext_shift_extents

Billy Tsai (2):
      iio: adc: aspeed: Remove the trim valid dts property.
      dt-bindings: iio: adc: Remove the property "aspeed,trim-data-valid"

Brian Norris (1):
      arm64: dts: rockchip: Drop RK3399-Scarlet's repeated ec_ap_int_l
definition

Chancel Liu (1):
      ASoC: wm8962: Wait for updated value of WM8962_CLOCKING1 register

Charan Teja Kalla (1):
      mm/page_exit: fix kernel doc warning in page_ext_put()

Chen Wandun (1):
      swapfile: fix soft lockup in scan_swap_map_slots

Chen Zhongjin (3):
      iio: core: Fix entry not deleted when iio_register_sw_trigger_type() =
fails
      xfrm: Fix ignored return value in xfrm6_init()
      nilfs2: fix nilfs_sufile_mark_dirty() not set segment usage as dirty

Chen-Yu Tsai (3):
      arm64: dts: rockchip: Fix Pine64 Quartz4-B PMIC interrupt
      media: dt-bindings: allwinner: h6-vpu-g2: Add IOMMU reference propert=
y
      arm64: dts: allwinner: h6: Add IOMMU reference to Hantro G2

ChenXiaoSong (2):
      btrfs: qgroup: fix sleep from invalid context bug in
btrfs_qgroup_inherit()
      cifs: fix missing unlock in cifs_file_copychunk_range()

Chris Mi (1):
      net/mlx5e: Offload rule only when all encaps are valid

Chris Morgan (1):
      power: supply: rk817: Change rk817_chg_cur_to_reg to int

Christian K=C3=B6nig (3):
      drm/amdgpu: handle gang submit before VMID
      drm/amdgpu: always register an MMU notifier for userptr
      drm/amdgpu: fix userptr HMM range handling v2

Christian Langrock (1):
      xfrm: replay: Fix ESN wrap around for GSO

Christoph Hellwig (3):
      btrfs: zoned: fix missing endianness conversion in sb_write_pointer
      blk-mq: fix queue reference leak on blk_mq_alloc_disk_for_queue failu=
re
      btrfs: use kvcalloc in btrfs_get_dev_zone_info

Chuck Lever (1):
      NFSD: Fix reads with a non-zero offset that don't end on a page bound=
ary

Colin Ian King (1):
      s390/dasd: Fix spelling mistake "Ivalid" -> "Invalid"

Damien Le Moal (1):
      zonefs: Fix active zone accounting

Dan Carpenter (3):
      power: supply: rk817: check correct variable
      cifs: Use after free in debug code
      octeontx2-af: cn10k: mcs: Fix copy and paste bug in mcs_bbe_intr_hand=
ler()

Daniel D=C3=ADaz (1):
      selftests/net: Find nettest in current directory

Daniel Xu (1):
      netfilter: conntrack: Fix data-races around ct mark

David Galiffi (1):
      drm/amd/display: Fix rotated cursor offset calculation

David Howells (2):
      rxrpc: Fix race between conn bundle lookup and bundle removal
[ZDI-CAN-15975]
      fscache: fix OOB Read in __fscache_acquire_volume

David Matlack (3):
      KVM: Cap vcpu->halt_poll_ns before halting rather than after
      KVM: Avoid re-reading kvm->max_halt_poll_ns during halt-polling
      KVM: Obey kvm.halt_poll_ns in VMs not using KVM_CAP_HALT_POLL

David Woodhouse (3):
      KVM: x86/xen: Validate port number in SCHEDOP_poll
      KVM: x86/xen: Only do in-kernel acceleration of hypercalls for guest =
CPL0
      KVM: Update gfn_to_pfn_cache khva when it moves within the same page

Davide Tronchin (1):
      net: usb: qmi_wwan: add u-blox 0x1342 composition

Dawei Li (1):
      dma-buf: fix racing conflict of dma_heap_add()

Detlev Casanova (1):
      ASoC: sgtl5000: Reset the CHIP_CLK_CTRL reg on remove

Dexuan Cui (1):
      PCI: hv: Only reuse existing IRTE allocation for Multi-MSI

Diana Wang (1):
      nfp: fill splittable of devlink_port_attrs correctly

Dillon Varone (3):
      drm/amd/display: Update soc bounding box for dcn32/dcn321
      drm/amd/display: Use viewport height for subvp mall allocation size
      drm/amd/display: Use new num clk levels struct for max mclk index

Dominik Haller (1):
      ARM: dts: am335x-pcm-953: Define fixed regulators in root node

Dominique Martinet (1):
      9p/xen: check logical size for buffer size

Dong Chenchen (1):
      iio: accel: bma400: Fix memory leak in bma400_get_steps_reg()

Eli Cohen (1):
      net/mlx5: Lag, avoid lockdep warnings

Emeel Hakim (3):
      net/mlx5e: Fix MACsec SA initialization routine
      net/mlx5e: Fix MACsec update SecY
      net/mlx5e: Fix possible race condition in macsec extended packet
number update routine

Eyal Birger (2):
      xfrm: fix "disable_policy" on ipv4 early demux
      xfrm: lwtunnel: squelch kernel warning in case XFRM encap type
is not available

FUKAUMI Naoki (1):
      arm64: dts: rockchip: keep I2S1 disabled for GPIO function on
ROCK Pi 4 series

Fabio Estevam (1):
      ARM: dts: imx6q-prti6q: Fix ref/tcxo-clock-frequency properties

Felix Fietkau (1):
      netfilter: flowtable_offload: add missing locking

Filipe Manana (3):
      btrfs: fix assertion failure and blocking during nowait buffered writ=
e
      btrfs: send: avoid unaligned encoded writes when attempting to clone =
range
      btrfs: do not modify log tree while holding a leaf from fs tree locke=
d

Frieder Schrempf (1):
      spi: spi-imx: Fix spi_bus_clk if requested clock is higher than
input clock

Furkan Kardame (3):
      arm64: dts: rockchip: Fix gmac failure of rgmii-id from rk3566-roc-pc
      arm64: dts: rockchip: Fix i2c3 pinctrl on rk3566-roc-pc
      arm64: dts: rockchip: remove i2c5 from rk3566-roc-pc

GUO Zihua (2):
      9p/fd: Fix write overflow in p9_read_work
      9p/fd: Use P9_HDRSZ for header size

Gautam Menghani (1):
      mm/khugepaged: refactor mm_khugepaged_scan_file tracepoint to
remove filename from function call

Gerhard Engleder (1):
      tsnep: Fix rotten packets

Giulio Benetti (1):
      ARM: 9266/1: mm: fix no-MMU ZERO_PAGE() implementation

Greg Kroah-Hartman (1):
      lib/vdso: use "grep -E" instead of "egrep"

Hangbin Liu (1):
      bonding: fix ICMPv6 header handling when receiving IPv6 messages

Hanjun Guo (1):
      net: wwan: t7xx: Fix the ACPI memory leak

Heiko Carstens (2):
      s390/crashdump: fix TOD programmable field size
      MAINTAINERS: add S390 MM section

Herbert Xu (1):
      af_key: Fix send_acquire race with pfkey_register

Horatiu Vultur (1):
      nvmem: lan9662-otp: Change return type of lan9662_otp_wait_flag_clear=
()

Huacai Chen (5):
      LoongArch: Combine acpi_boot_table_init() and acpi_boot_init()
      LoongArch: SMP: Change prefix from loongson3 to loongson
      LoongArch: Clear FPU/SIMD thread info flags for kernel thread
      LoongArch: Set _PAGE_DIRTY only if _PAGE_WRITE is set in
{pmd,pte}_mkdirty()
      LoongArch: Set _PAGE_DIRTY only if _PAGE_MODIFIED is set in
{pmd,pte}_mkwrite()

Hui Tang (1):
      net: mvpp2: fix possible invalid pointer dereference

Ian Cowan (1):
      mm: mmap: fix documentation for vma_mas_szero

Imre Deak (1):
      drm/i915: Fix warn in intel_display_power_*_domain() functions

Ivan Vecera (2):
      iavf: Fix a crash during reset task
      iavf: Do not restart Tx queues after reset task failure

Jack Xiao (1):
      drm/amd/amdgpu: reserve vm invalidation engine for firmware

Jaco Coetzee (1):
      nfp: add port from netdev validation for EEPROM access

Jacob Keller (1):
      ice: fix handling of burst Tx timestamps

Jakob Unterwurzacher (1):
      arm64: dts: rockchip: lower rk3399-puma-haikou SD controller
clock frequency

Jakub Sitnicki (1):
      l2tp: Don't sleep and disable BH under writer-side sk_callback_lock

Jane Jian (1):
      drm/amdgpu/vcn: re-use original vcn0 doorbell value

Jann Horn (1):
      fs: use acquire ordering in __fget_light()

Jason Ekstrand (1):
      dma-buf: Use dma_fence_unwrap_for_each when importing fences

Jens Axboe (1):
      io_uring: clear TIF_NOTIFY_SIGNAL if set and task_work not available

Jensen Huang (1):
      arm64: dts: rockchip: add enable-strobe-pulldown to emmc phy on nanop=
i4

Jiasheng Jiang (2):
      ASoC: max98373: Add checks for devm_kcalloc
      octeontx2-pf: Add check for devm_kcalloc

Joe Korty (1):
      clocksource/drivers/arm_arch_timer: Fix XGene-1 TVAL register math er=
ror

Johan Jonker (6):
      ARM: dts: rockchip: fix adc-keys sub node names
      arm64: dts: rockchip: fix adc-keys sub node names
      ARM: dts: rockchip: fix ir-receiver node names
      arm64: dts: rockchip: fix ir-receiver node names
      ARM: dts: rockchip: rk3188: fix lcdc1-rgb24 node name
      ARM: dts: rockchip: disable arm_global_timer on rk3066 and rk3188

Johannes Weiner (1):
      mm: vmscan: fix extreme overreclaim and swap floods

Josef Bacik (1):
      btrfs: free btrfs_path before copying root refs to userspace

Jozsef Kadlecsik (1):
      netfilter: ipset: restore allowing 64 clashing elements in hash:net,i=
face

Junxiao Chang (1):
      ASoC: hdac_hda: fix hda pcm buffer overflow issue

KaiLong Wang (1):
      LoongArch: Fix unsigned comparison with less than zero

Kazuki Takiguchi (1):
      KVM: x86/mmu: Fix race condition in direct_page_fault

Kees Cook (2):
      ALSA: seq: Fix function prototype mismatch in snd_seq_expand_var_even=
t
      ipv4/fib: Replace zero-length array with DECLARE_FLEX_ARRAY() helper

Konrad Dybcio (1):
      regulator: slg51000: Wait after asserting CS pin

Krishna Yarlagadda (1):
      spi: tegra210-quad: Fix duplicate resource error

Krzysztof Kozlowski (1):
      dt-bindings: interconnect: qcom,msm8998-bwmon: Correct SC7280
CPU compatible

Kuniyuki Iwashima (4):
      dccp/tcp: Reset saddr on failure after inet6?_hash_connect().
      dccp/tcp: Remove NULL check for prev_saddr in inet_bhash2_update_sadd=
r().
      dccp/tcp: Update saddr under bhash's lock.
      dccp/tcp: Fixup bhash2 bucket when connect() fails.

Leon Romanovsky (1):
      net: liquidio: simplify if expression

Lev Popov (1):
      arm64: dts: rockchip: fix quartz64-a bluetooth configuration

Li Hua (1):
      test_kprobes: fix implicit declaration error of test_kprobes

Li Liguang (1):
      mm: correctly charge compressed memory to its memcg

Li Zetao (1):
      virtio_net: Fix probe failed when modprobe virtio_net

Lin Ma (3):
      nfc/nci: fix race with opening and closing
      io_uring/filetable: fix file reference underflow
      io_uring/poll: fix poll_refs race with cancelation

Linus Torvalds (1):
      Linux 6.1-rc7

Linus Walleij (2):
      power: supply: ab8500: Defer thermal zone probe
      bus: ixp4xx: Don't touch bit 7 on IXP42x

Liu Jian (3):
      net: ethernet: mtk_eth_soc: fix error handling in mtk_open()
      net: sparx5: fix error handling in sparx5_port_open()
      net: altera_tse: release phylink resources in tse_shutdown()

Liu Shixin (1):
      NFC: nci: fix memory leak in nci_rx_data_packet()

Lu Wei (1):
      net: microchip: sparx5: Fix return value in sparx5_tc_setup_qdisc_ets=
()

Lyude Paul (6):
      drm/amdgpu/mst: Stop ignoring error codes and deadlocking
      drm/display/dp_mst: Fix drm_dp_mst_add_affected_dsc_crtcs() return co=
de
      drm/amdgpu/dm/mst: Use the correct topology mgr pointer in
amdgpu_dm_connector
      drm/amdgpu/dm/dp_mst: Don't grab mst_mgr->lock when computing DSC sta=
te
      drm/amdgpu/dm/mst: Fix uninitialized var in
pre_compute_mst_dsc_configs_for_state()
      drm/amd/dc/dce120: Fix audio register mapping, stop triggering KASAN

Mahesh Bandewar (1):
      ipvlan: hold lower dev to avoid possible use-after-free

Manivannan Sadhasivam (1):
      MAINTAINERS: Add Manivannan Sadhasivam as Qcom PCIe RC maintainer

Marc Kleine-Budde (1):
      spi: spi-imx: spi_imx_transfer_one(): check for DMA transfer first

Marco Elver (1):
      kfence: fix stack trace pruning

Marek Szyprowski (1):
      usb: dwc3: exynos: Fix remove() function

Martin Faltesek (3):
      nfc: st-nci: fix incorrect validating logic in EVT_TRANSACTION
      nfc: st-nci: fix memory leaks in EVT_TRANSACTION
      nfc: st-nci: fix incorrect sizing calculations in EVT_TRANSACTION

Masahiro Yamada (1):
      kbuild: fix "cat: .version: No such file or directory"

Matthew Auld (1):
      drm/i915/ttm: never purge busy objects

Matthieu Baerts (2):
      selftests: mptcp: run mptcp_sockopt from a new netns
      selftests: mptcp: fix mibit vs mbit mix up

Maxim Levitsky (9):
      KVM: x86: nSVM: leave nested mode on vCPU free
      KVM: x86: nSVM: harden svm_free_nested against freeing vmcb02
while still in use
      KVM: x86: add kvm_leave_nested
      KVM: x86: forcibly leave nested mode on vCPU reset
      KVM: selftests: move idt_entry to header
      kvm: selftests: add svm nested shutdown test
      KVM: x86: allow L1 to not intercept triple fault
      KVM: selftests: add svm part to triple_fault_test
      KVM: x86: remove exit_int_info warning in svm_handle_exit

Michael Grzeschik (2):
      ARM: dts: at91: sam9g20ek: enable udc vbus gpio pinctrl
      usb: gadget: uvc: also use try_format in set_format

Michael Kelley (2):
      scsi: storvsc: Fix handling of srb_status and capacity change events
      x86/ioremap: Fix page aligned size calculation in __ioremap_caller()

Mike Kravetz (2):
      ipc/shm: call underlying open/close vm_ops
      hugetlb: fix __prep_compound_gigantic_page page flag setting

Ming Lei (1):
      ublk_drv: don't forward io commands in reserve order

Moshe Shemesh (4):
      net/mlx5: Fix FW tracer timestamp calculation
      net/mlx5: cmdif, Print info on any firmware cmd failure to tracepoint
      net/mlx5: Fix handling of entry refcount when command is not issued t=
o FW
      net/mlx5: Fix sync reset event handler error flow

Mukesh Ojha (1):
      gcov: clang: fix the buffer overflow issue

Nir Levy (1):
      Documentation: networking: Update generic_netlink_howto URL

Olivier Moysan (1):
      ASoC: stm32: i2s: remove irqf_oneshot flag

Ondrej Jirman (1):
      power: supply: ip5xxx: Fix integer overflow in current_now calculatio=
n

Pablo Neira Ayuso (1):
      netfilter: nf_tables: do not set up extensions for end interval

Paolo Abeni (1):
      selftests: mptcp: gives slow test-case more time

Paran Lee (1):
      scripts: add rust in scripts/Makefile.package

Paul Gazzillo (1):
      iio: light: rpr0521: add missing Kconfig dependencies

Pavel Begunkov (2):
      io_uring: cmpxchg for poll arm refs release
      io_uring: make poll refs more robust

Pawan Gupta (2):
      x86/tsx: Add a feature bit for TSX control MSR support
      x86/pm: Add enumeration check before spec MSRs save/restore setup

Pawel Laszczak (2):
      usb: cdnsp: Fix issue with Clear Feature Halt Endpoint
      usb: cdnsp: fix issue with ZLP - added TD_SIZE =3D 1

Peng Fan (1):
      arm64: dts: imx8mp-evk: correct pcie pad settings

Perry Yuan (4):
      cpufreq: amd-pstate: change amd-pstate driver to be built-in type
      cpufreq: amd-pstate: add amd-pstate driver parameter for mode selecti=
on
      Documentation: amd-pstate: add driver working mode introduction
      Documentation: add amd-pstate kernel command line options

Peter Gonda (1):
      virt/sev-guest: Prevent IV reuse in the SNP guest driver

Peter Griffin (1):
      vfs: vfs_tmpfile: ensure O_EXCL flag is enforced

Peter Kosyh (1):
      net/mlx4: Check retval of mlx4_bitmap_init

Peter Zijlstra (2):
      perf: Fixup SIGTRAP and sample_flags interaction
      perf: Consider OS filter fail

Pierre-Louis Bossart (1):
      ASoC: SOF: dai: move AMD_HS to end of list to restore
backwards-compatibility

Qi Zheng (1):
      mm: fix unexpected changes to {failslab|fail_page_alloc}.attr

Ramesh Errabolu (1):
      drm/amdgpu: Enable Aldebaran devices to report CU Occupancy

Randy Dunlap (1):
      nios2: add FORCE for vmlinuz.gz

Richard Fitzgerald (1):
      ASoC: soc-pcm: Don't zero TDM masks in __soc_pcm_open()

Rob Herring (1):
      MAINTAINERS: Include PCI bindings in host bridge entry

Roi Dayan (1):
      net/mlx5: E-Switch, Set correctly vport destination

Roman Li (1):
      drm/amd/display: Align dcn314_smu logging with other DCNs

Roy Novich (1):
      net/mlx5: Do not query pci info while pci disabled

Russ Weight (1):
      fpga: m10bmc-sec: Fix kconfig dependencies

Sam James (1):
      kbuild: fix -Wimplicit-function-declaration in license_is_gpl_compati=
ble

Sam Wu (1):
      Revert "cpufreq: schedutil: Move max CPU capacity to sugov_policy"

Samuel Holland (2):
      bus: sunxi-rsb: Remove the shutdown callback
      bus: sunxi-rsb: Support atomic transfers

Santiago Ruano Rinc=C3=B3n (1):
      net/cdc_ncm: Fix multicast RX support for CDC NCM devices with ZLP

Satya Priya (1):
      mailmap: update email address for Satya Priya

Sean Christopherson (2):
      drm/i915/gvt: Get reference to KVM iff attachment to VM is successful
      drm/i915/gvt: Unconditionally put reference to KVM when detaching vGP=
U

Sebastian Reichel (4):
      arm64: dts: rockchip: fix node name for hym8563 rtc
      arm64: dts: rockchip: remove clock-frequency from rtc
      arm: dts: rockchip: fix node name for hym8563 rtc
      arm: dts: rockchip: remove clock-frequency from rtc

SeongJae Park (1):
      mm/damon/sysfs-schemes: skip stats update if the scheme
directory is removed

Shang XiaoJing (3):
      nfc: nfcmrvl: Fix potential memory leak in nfcmrvl_i2c_nci_send()
      nfc: nxp-nci: Fix potential memory leak in nxp_nci_send()
      nfc: s3fwrn5: Fix potential memory leak in s3fwrn5_nci_send()

Shay Drory (1):
      net/mlx5: SF: Fix probing active SFs during driver probe phase

Shuming Fan (1):
      ASoC: rt711-sdca: fix the latency time of clock stop prepare
state machine transitions

Slawomir Laba (1):
      iavf: Fix race condition between iavf_shutdown and iavf_remove

Srikar Dronamraju (1):
      scripts/faddr2line: Fix regression in name resolution on ppc64le

Srinivasa Rao Mandadapu (1):
      ASoC: soc-pcm: Add NULL check in BE reparenting

Stanley.Yang (1):
      drm/amdgpu: fix use-after-free during gpu recovery

Stefan Assmann (1):
      iavf: remove INITIAL_MAC_SET to allow gARP to work properly

Stefan Haberland (3):
      s390/dasd: increase printing of debug data payload
      s390/dasd: fix no record found for raw_track_access
      s390/dasd: fix possible buffer overflow in copy_pair_show

Svyatoslav Feldsherov (1):
      fs: do not update freeing inode i_io_list

Taimur Hassan (1):
      drm/amd/display: Avoid setting pixel rate divider to N/A

Tariq Toukan (2):
      net/mlx5e: Fix missing alignment in size of MTT/KLM entries
      net/mlx5e: Remove leftovers from old XSK queues enumeration

Tetsuo Handa (1):
      fbcon: Use kzalloc() in fbcon_prepare_logo()

Thinh Nguyen (2):
      usb: dwc3: gadget: Disable GUSB2PHYCFG.SUSPHY for End Transfer
      usb: dwc3: gadget: Clear ep descriptor last

Thomas Jarosch (1):
      xfrm: Fix oops in __xfrm_state_delete()

Thomas Zeitlhofer (1):
      net: neigh: decrement the family specific qlen

Tiezhu Yang (2):
      LoongArch: Makefile: Use "grep -E" instead of "egrep"
      docs/zh_CN/LoongArch: Fix wrong description of FPRs Note

Tomislav Novak (1):
      ARM: 9251/1: perf: Fix stacktraces for tracepoint events in THUMB2 ke=
rnels

Tsung-hua Lin (1):
      drm/amd/display: No display after resume from WB/CB

Vishwanath Pai (1):
      netfilter: ipset: regression in ip_set_hash_ip.c

Vitaly Kuznetsov (1):
      x86/hyperv: Restore VP assist page after cpu offlining/onlining

Vladimir Oltean (2):
      net: dsa: sja1105: disallow C45 transactions on the BASE-TX MDIO bus
      net: enetc: preserve TX ring priority across reconfiguration

Wang Hai (2):
      net: pch_gbe: fix potential memleak in pch_gbe_tx_queue()
      arcnet: fix potential memory leak in com20020_probe()

Wang ShaoBo (1):
      net: wwan: iosm: use ACPI_FREE() but not kfree() in
ipc_pcie_read_bios_cfg()

Wang Yufen (1):
      selftests/net: fix missing xdp_dummy

Wei Yongjun (5):
      iio: health: afe4403: Fix oob read in afe4403_read_raw
      iio: health: afe4404: Fix oob read in afe4404_[read|write]_raw
      net: phy: at803x: fix error return code in at803x_probe()
      nvmem: rmem: Fix return value check in rmem_read()
      s390/ap: fix memory leak in ap_init_qci_info()

Wyes Karny (1):
      cpufreq: amd-pstate: cpufreq: amd-pstate: reset MSR_AMD_PERF_CTL
register at init

Xin Long (3):
      tipc: set con sock in tipc_conn_alloc
      tipc: add an extra conn_get in tipc_conn_alloc
      net: sched: allow act_ct to be built without NF_NAT

Xiongfeng Wang (2):
      spi: dw-dma: decrease reference count in dw_spi_dma_init_mfld()
      octeontx2-af: Fix reference count issue in rvu_sdp_init()

Yan Cangang (2):
      net: ethernet: mtk_eth_soc: fix resource leak in error path
      net: ethernet: mtk_eth_soc: fix memory leak in error path

Yang Shi (1):
      mm: khugepaged: allow page allocation fallback to eligible nodes

Yang Yingliang (8):
      regulator: rt5759: fix OOB in validate_desc()
      regulator: core: fix UAF in destroy_regulator()
      tee: optee: fix possible memory leak in optee_register_device()
      octeontx2-af: debugsfs: fix pci device refcount leak
      net: pch_gbe: fix pci device refcount leak while module exiting
      Drivers: hv: vmbus: fix double free in the error path of
vmbus_add_channel_work()
      Drivers: hv: vmbus: fix possible memory leak in vmbus_device_register=
()
      bnx2x: fix pci device refcount leak in bnx2x_vf_is_pcie_pending()

Yosry Ahmed (1):
      proc/meminfo: fix spacing in SecPageTables

Yu Liao (1):
      net: thunderx: Fix the ACPI memory leak

Yu Zhao (1):
      mm: multi-gen LRU: retry folios written back while isolated

Yuan Can (1):
      net: dm9051: Fix missing dev_kfree_skb() in dm9051_loop_rx()

YueHaibing (2):
      macsec: Fix invalid error code set
      tipc: check skb_linearize() return value in tipc_disc_rcv()

Zeng Heng (1):
      regulator: core: fix kobject release warning and memory leak in
regulator_register()

Zhang Changzhong (3):
      net/qla3xxx: fix potential memleak in ql3xxx_send()
      sfc: fix potential memleak in __ef100_hard_start_xmit()
      net: marvell: prestera: add missing unregister_netdev() in
prestera_port_create()

Zhang Xiaoxu (1):
      zonefs: Fix race between modprobe and mount

Zhen Lei (1):
      btrfs: sysfs: normalize the error handling branch in btrfs_init_sysfs=
()

Zheng Bin (1):
      octeontx2-pf: Remove duplicate MACSEC setting

Zheng Yongjun (1):
      ARM: mxs: fix memory leak in mxs_machine_init()

Zhengchao Shao (1):
      9p/fd: fix issue of list_del corruption in p9_fd_cancel()

Zhichao Liu (1):
      spi: mediatek: Fix DEVAPC Violation at KO Remove

Ziyang Xuan (2):
      net: ethernet: mtk_eth_soc: fix potential memory leak in mtk_rx_alloc=
()
      ipv4: Fix error return code in fib_table_insert()

lyndonli (1):
      drm/amd/pm: update driver if header for smu_13_0_7
