Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216F672192D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 20:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjFDSTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 14:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjFDSTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 14:19:04 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BCE9F
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 11:19:01 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-977cf86aae5so113221666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 11:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685902740; x=1688494740;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pE8MGnzGvvmyWKgFvNSoycCpp0l1HPsExWwWH4WsgGM=;
        b=OatgffyiiCv51p6dlN1etVcn7CXDwUiYueuGP1mzgroKU/7q2M93KvzRk22Rj/U+9L
         J/vdA6EVTodX/lFcQM2dskJNJOxm2SRIkPpP6ypVVmc7Dga8lnxpVng5kj41wsFTN/C9
         WlvQGbD84MSuYABS5MLOarBK+C0Cy2ogqNsJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685902740; x=1688494740;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pE8MGnzGvvmyWKgFvNSoycCpp0l1HPsExWwWH4WsgGM=;
        b=Th0rYA9w3R3Ha8SSMpif8x0arxH6XeRo7zctJnku78oZP47UcnRRLtC7eEyONdLPnY
         e0seoGbTrK5zrg+CgqG3qeUFXmIkdufp+o5jrZ5meKQ7QdiZ8t2zjplKPYUB0saczsMC
         480abeq1bWoRtdlPhEe2P0KC/DyONYcNE1oB21Sz8Xkj4NGx+eQJnR9t5CbwNL2Vo+ui
         YBxi8p1ECJcv2KbVp//ax+tKwgp3EzZZEzAdlqZKKxn95I5qwETPsw2b1+yNIHIJo4x5
         ZRuMfV0b5Bd1xYjNVe/0yud7LLYByhtkuavV8GM3PevGanY6koLLVsCKAL/ef5qMZq9/
         bBRA==
X-Gm-Message-State: AC+VfDxM1JZk14IUhRoBRfv2MEcolKie71jVDUZFCowBVCkg5gVwUws0
        5qqG9E6Nh4GL+a+p/Kjm4htY29qYMyN4Xt377sAOJ9Av
X-Google-Smtp-Source: ACHHUZ5jgwvEwJernaon2UbJA7Qstsg6zstYUp+IIhdpSNclfEUtFiEZx6GhfQ4ZiBYsOnefvScEBQ==
X-Received: by 2002:a17:907:25c8:b0:96f:a86f:9d16 with SMTP id ae8-20020a17090725c800b0096fa86f9d16mr3739085ejc.23.1685902739612;
        Sun, 04 Jun 2023 11:18:59 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id gz18-20020a170906f2d200b0096a5d341b50sm3316831ejb.111.2023.06.04.11.18.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 11:18:58 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5149bdb59daso5803007a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 11:18:58 -0700 (PDT)
X-Received: by 2002:aa7:da42:0:b0:514:9c80:e3ff with SMTP id
 w2-20020aa7da42000000b005149c80e3ffmr5590434eds.2.1685902738314; Sun, 04 Jun
 2023 11:18:58 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Jun 2023 14:18:41 -0400
X-Gmail-Original-Message-ID: <CAHk-=wifuPqAFXQQTTLkp_+FMzxGFHpSG-hEtZazG-46s=noAw@mail.gmail.com>
Message-ID: <CAHk-=wifuPqAFXQQTTLkp_+FMzxGFHpSG-hEtZazG-46s=noAw@mail.gmail.com>
Subject: Linux 6.4-rc5
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

Here we are, one week later, and rc5 has been tagged and pushed out.

Nothing particularly strange here, most notable is probably just the
quick revert of the module loading trial that caused problems for
people in rc4 depending on just random timing luck (or rather, lack
there-of). So if you tried rc4, and some devices randomly didn't work
for you, that was likely the issue.

But there's obviously all the other random fixes in there, and it all
looks fairly familiar, with half of the patch being driver fixes (gpu
and networking being the most notable as usual, but there's rdma,
scsi, and various other things in there too). The rest is just spread
out, with nothing very odd standing out.

The shortlog is appended as usual, and things look normal both in the
diff and in just the regular number of commits. We've certainly seen
smaller, but we've also seen bigger, so this seems fairly much on
target for rc5.

So despite the module loading hiccup (blush, that's all on me), I
think we're in good shape and nothing makes me think this release
wouldn't be one of the nice, boring, regular ones. Yes, there are a
couple of regressions being tracked, but hopefully we'll get them all.

Famous last words.

So please do test, and try to prove me wrong,

               Linus

---

Akihiko Odaki (1):
      KVM: arm64: Populate fault info for watchpoint

Akihiro Suda (1):
      efi: Bump stub image version for macOS HVF compatibility

Alexander Stein (1):
      dt-bindings: iio: imx8qxp-adc: add missing vref-supply

Alexandre Ghiti (4):
      riscv: Fix unused variable warning when BUILTIN_DTB is set
      riscv: Fix relocatable kernels with early alternatives using -fno-pie
      riscv: Fix huge_ptep_set_wrprotect when PTE is a NAPOT
      riscv: Implement missing huge_ptep_get

Andreas Svensson (1):
      net: dsa: mv88e6xxx: Increase wait after reset deactivation

Ard Biesheuvel (2):
      crypto: x86/aria - Use 16 byte alignment for GFNI constant vectors
      efi/libstub: zboot: Avoid eager evaluation of objcopy flags

Arnaldo Carvalho de Melo (1):
      tools headers UAPI: Sync the linux/in.h with the kernel sources

Arnd Bergmann (3):
      efi: fix missing prototype warnings
      mtd: rawnand: ingenic: fix empty stub helper definitions
      mtdchar: mark bits of ioctl handler noinline

Ashutosh Dixit (1):
      drm/i915/perf: Clear out entire reports after reading if not
power of 2 size

Bagas Sanjaya (4):
      Documentation: net/mlx5: Wrap vnic reporter devlink commands in
code blocks
      Documentation: net/mlx5: Use bullet and definition lists for
vnic counters description
      Documentation: net/mlx5: Add blank line separator before numbered lis=
ts
      Documentation: net/mlx5: Wrap notes in admonition blocks

Bart Van Assche (1):
      scsi: stex: Fix gcc 13 warnings

Bastien Nocera (1):
      HID: logitech-hidpp: Handle timeout differently from busy

Beau Belgrave (3):
      tracing/user_events: Use long vs int for atomic bit ops
      tracing/user_events: Rename link fields for clarity
      tracing/user_events: Document user_event_mm one-shot list usage

Ben Noordhuis (1):
      io_uring: undeprecate epoll_ctl support

Benjamin Gaignard (1):
      media: verisilicon: Additional fix for the crash when opening the dri=
ver

Bert Karwatzki (1):
      net: ipa: Use correct value for IPA_STATUS_SIZE

Bjorn Andersson (1):
      leds: qcom-lpg: Fix PWM period limits

Bob Pearson (1):
      RDMA/rxe: Fix double unlock in rxe_qp.c

Cambda Zhu (1):
      tcp: Return user_mss for TCP_MAXSEG in CLOSE/LISTEN state if user_mss=
 set

Chao Wang (1):
      iommu/rockchip: Fix unwind goto issue

Chen-Yu Tsai (1):
      iommu/mediatek: Flush IOTLB completely only if domain has been attach=
ed

Chengchang Tang (2):
      RDMA/hns: Fix timeout attr in query qp for HIP08
      RDMA/hns: Fix base address table allocation

ChiaEn Wu (1):
      iio: adc: mt6370: Fix ibus and ibat scaling value of some
specific vendor ID chips

Chris Mi (2):
      net/mlx5e: Extract remaining tunnel encap code to dedicated file
      net/mlx5e: Prevent encap offload when neigh update is running

Chris Packham (2):
      mtd: rawnand: marvell: ensure timing values are written
      mtd: rawnand: marvell: don't set the NAND frequency select

Christoph Hellwig (2):
      btrfs: call btrfs_orig_bbio_end_io in btrfs_end_bio_work
      nvme: fix the name of Zone Append for verbose logging

Christophe JAILLET (1):
      serial: 8250_tegra: Fix an error handling path in tegra_uart_probe()

Chuck Lever (1):
      net/mlx5: Ensure af_desc.mask is properly initialized

Conor Dooley (1):
      RISC-V: mark hibernation as nonportable

Damien Le Moal (2):
      block: fix revalidate performance regression
      ata: libata-scsi: Use correct device no in ata_find_dev()

Dan Carpenter (9):
      iio: adc: imx93: fix a signedness bug in imx93_adc_read_raw()
      iio: adc: palmas: fix off by one bugs
      dmaengine: at_xdmac: fix potential Oops in at_xdmac_prep_interleaved(=
)
      net/mlx5: Fix check for allocation failure in comp_irqs_request_pci()
      smb: delete an unnecessary statement
      usb: gadget: udc: fix NULL dereference in remove()
      nfsd: fix double fget() bug in __write_ports_addfd()
      mailbox: mailbox-test: fix a locking issue in mbox_test_message_write=
()
      firmware_loader: Fix a NULL vs IS_ERR() check

Daniel Bristot de Oliveira (1):
      tracing/timerlat: Always wakeup the timerlat thread

David Howells (1):
      rxrpc: Truncate UTS_RELEASE for rxrpc version

Denis Arefev (1):
      HID: wacom: Add error check to wacom_parse_and_register()

Deren Wu (1):
      mmc: vub300: fix invalid response handling

Dmytro Linkin (1):
      net/mlx5e: Don't attach netdev profile while handling internal error

Dragos Tatulea (1):
      net/mlx5e: Use query_special_contexts cmd only once per mdev

Edward Cree (1):
      sfc: fix error unwinds in TC offload

Ekansh Gupta (2):
      misc: fastrpc: Pass proper scm arguments for secure map request
      misc: fastrpc: Reassign memory ownership only for remote heap

Eric Dumazet (3):
      netrom: fix info-leak in nr_write_internal()
      af_packet: do not use READ_ONCE() in packet_bind()
      tcp: deny tcp_disconnect() when threads are waiting

Francesco Dolcini (1):
      dt-bindings: serial: 8250_omap: add rs485-rts-active-high

Frank Li (2):
      iio: light: vcnl4035: fixed chip ID check
      usb: cdns3: fix NCM gadget RX speed 20x slow than expection at iMX8QM

Fuad Tabba (1):
      KVM: arm64: Reload PTE after invoking walker callback on
preorder traversal

Gaurav Batra (1):
      powerpc/iommu: Limit number of TCEs to 512 for H_STUFF_TCE hcall

Geert Uytterhoeven (2):
      regmap: REGMAP_KUNIT should not select REGMAP
      dt-bindings: iio: adc: renesas,rcar-gyroadc: Fix adi,ad7476
compatible value

Gleb Chesnokov (1):
      scsi: qla2xxx: Fix NULL pointer dereference in target mode

Guchun Chen (1):
      drm/amd/pm: resolve reboot exception for si oland

Guoqing Jiang (1):
      RDMA/rxe: Convert spin_{lock_bh,unlock_bh} to
spin_{lock_irqsave,unlock_irqrestore}

Gustavo A. R. Silva (1):
      firewire: Replace zero-length array with flexible-array member

Haiyang Zhang (1):
      net: mana: Fix perf regression: remove rx_cqes, tx_cqes counters

Hangyu Hua (1):
      net/sched: flower: fix possible OOB write in fl_set_geneve_opt()

Hans Verkuil (4):
      media: cec: core: disable adapter in cec_devnode_unregister
      media: cec: core: don't set last_initiator if tx in progress
      media: staging: media: atomisp: init high & low vars
      media: staging: media: imx: initialize hs_settle to avoid warning

Hans de Goede (1):
      iio: accel: st_accel: Fix invalid mount_matrix on devices
without ACPI _ONT method

Haoyue Xu (1):
      MAINTAINERS: Update maintainers of HiSilicon RoCE

Harshit Mogalapalli (1):
      dmaengine: idxd: Fix passing freed memory in idxd_cdev_open()

Helge Deller (3):
      fbdev: imsttfb: Release framebuffer and dealloc cmap on error path
      fbdev: imsttfb: Fix error path of imsttfb_probe()
      fbcon: Fix null-ptr-deref in soft_cursor

Herve Codina (2):
      soc: fsl: cpm1: Fix TSA and QMC dependencies in case of COMPILE_TEST
      serial: cpm_uart: Fix a COMPILE_TEST dependency

Horatio Zhang (6):
      drm/amdgpu: separate ras irq from vcn instance irq for UVD_POISON
      drm/amdgpu: add RAS POISON interrupt funcs for vcn_v2_6
      drm/amdgpu: add RAS POISON interrupt funcs for vcn_v4_0
      drm/amdgpu: separate ras irq from jpeg instance irq for UVD_POISON
      drm/amdgpu: add RAS POISON interrupt funcs for jpeg_v2_6
      drm/amdgpu: add RAS POISON interrupt funcs for jpeg_v4_0

Ian Rogers (2):
      perf arm: Fix include path to cs-etm.h
      perf build: Don't compile demangle-cxx.cpp if not necessary

Ikshwaku Chauhan (1):
      drm/amdgpu: enable tmz by default for GC 11.0.1

Ism Hong (1):
      riscv: perf: Fix callchain parse error with kernel tracepoint events

Ivan Bornyakov (2):
      MAINTAINERS: update Microchip MPF FPGA reviewers
      dt-bindings: fpga: replace Ivan Bornyakov maintainership

Jakub Kicinski (3):
      tools: ynl: avoid dict errors on older Python versions
      tls: improve lockless access safety of tls_err_abort()
      netlink: specs: correct types of legacy arrays

James Clark (1):
      perf cs-etm: Copy kernel coresight-pmu.h header

Jan Kara (1):
      ext4: fix fsync for non-directories

Jason Gerecke (1):
      HID: wacom: Check for string overflow from strscpy calls

Jason Gunthorpe (1):
      iommu/amd: Add missing domain type checks

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_icm42600: fix timestamp reset

Jean-Philippe Brucker (4):
      KVM: arm64: vgic: Fix a circular locking issue
      KVM: arm64: vgic: Wrap vgic_its_create() with config_lock
      KVM: arm64: vgic: Fix locking comment
      KVM: arm64: vgic: Fix a comment

Jeff Layton (1):
      nfsd: make a copy of struct iattr before calling notify_change

Jerry Snitselaar (1):
      iommu/amd: Fix up merge conflict resolution

Jiakai Luo (1):
      iio: adc: mxs-lradc: fix the order of two cleanup operations

Jianbo Liu (1):
      net/mlx5e: Move Ethernet driver debugfs to profile init callback

Jim Wylder (1):
      regmap: Account for register length when chunking

Joao Martins (2):
      iommu/amd: Don't block updates to GATag if guest mode is on
      iommu/amd: Handle GALog overflows

Johan Hovold (2):
      phy: qcom-qmp-combo: fix init-count imbalance
      phy: qcom-qmp-pcie-msm8996: fix init-count imbalance

Jon Pan-Doh (1):
      iommu/amd: Fix domain flush size when syncing iotlb

K Prateek Nayak (2):
      drivers: base: cacheinfo: Fix shared_cpu_map changes in event of
CPU hotplug
      drivers: base: cacheinfo: Update cpu_map_populated during CPU Hotplug

Kalesh AP (3):
      RDMA/bnxt_re: Fix a possible memory leak
      RDMA/bnxt_re: Fix return value of bnxt_re_process_raw_qp_pkt_rx
      RDMA/bnxt_re: Do not enable congestion control on VFs

Krzysztof Kozlowski (1):
      phy: qcom-snps: correct struct qcom_snps_hsphy kerneldoc

Kuan-Ting Chen (2):
      ksmbd: fix slab-out-of-bounds read in smb2_handle_negotiate
      ksmbd: fix multiple out-of-bounds read during context decoding

Kuniyuki Iwashima (1):
      af_packet: Fix data-races of pkt_sk(sk)->num.

Lars-Peter Clausen (2):
      iio: tmag5273: Fix runtime PM leak on measurement error
      iio: ad4130: Make sure clock provider gets removed

Laurent Pinchart (1):
      media: uvcvideo: Don't expose unsupported formats to userspace

Lino Sanfilippo (1):
      tpm, tpm_tis: correct tpm_tis_flags enumeration values

Linus Torvalds (4):
      tracing/user_events: Split up mm alloc and attach
      tracing/user_events: Remove RCU lock while pinning pages
      Revert "module: error out early on concurrent load of the same
module file"
      Linux 6.4-rc5

Lucas De Marchi (1):
      module/decompress: Fix error checking on zstd decompression

Lukas Bulwahn (1):
      iio: dac: build ad5758 driver when AD5758 is selected

Maciej Fijalkowski (1):
      ice: recycle/free all of the fragments from multi-buffer frame

Maciej S. Szmigiero (1):
      KVM: SVM: vNMI pending bit is V_NMI_PENDING_MASK not V_NMI_BLOCKING_M=
ASK

Maher Sanalla (2):
      net/mlx5e: Consider internal buffers size in port buffer calculations
      net/mlx5e: Do not update SBCM when prio2buffer command is invalid

Maninder Singh (1):
      powerpc/xmon: Use KSYM_NAME_LEN in array size

Marc Zyngier (3):
      arm64: Add missing Set/Way CMO encodings
      KVM: arm64: Handle trap of tagged Set/Way CMOs
      irqchip/gic: Correctly validate OF quirk descriptors

Marek Vasut (3):
      iio: dac: mcp4725: Fix i2c_master_send() return value handling
      mmc: pwrseq: sd8787: Fix WILC CHIP_EN and RESETN toggling order
      dt-bindings: usb: snps,dwc3: Fix "snps,hsphy_interface" type

Mark Brown (1):
      regmap: maple: Drop the RCU read lock while syncing registers

Masahiro Honda (1):
      iio: adc: ad_sigma_delta: Fix IRQ issue by setting IRQ_DISABLE_UNLAZY=
 flag

Masami Hiramatsu (Google) (1):
      selftests/ftrace: Choose target function for filter test from samples

Matthieu Baerts (8):
      selftests: mptcp: join: avoid using 'cmp --bytes'
      selftests: mptcp: connect: skip if MPTCP is not supported
      selftests: mptcp: pm nl: skip if MPTCP is not supported
      selftests: mptcp: join: skip if MPTCP is not supported
      selftests: mptcp: diag: skip if MPTCP is not supported
      selftests: mptcp: simult flows: skip if MPTCP is not supported
      selftests: mptcp: sockopt: skip if MPTCP is not supported
      selftests: mptcp: userspace pm: skip if MPTCP is not supported

Matti Vaittinen (5):
      iio: fix doc for iio_gts_find_sel_by_int_time
      iio: bu27034: Fix integration time
      iio: gts-helpers: fix integration time units
      iio: bu27034: Ensure reset is written
      iio: accel: kx022a fix irq getting

Maurizio Lombardi (3):
      scsi: target: iscsi: Fix hang in the iSCSI login code
      scsi: target: iscsi: Remove unused transport_timer
      scsi: target: iscsi: Prevent login threads from racing between each o=
ther

Michael Ellerman (1):
      powerpc/crypto: Fix aes-gcm-p10 link errors

Michael Margolin (1):
      MAINTAINERS: Update maintainer of Amazon EFA driver

Michal Luczaj (1):
      KVM: selftests: Add test for race in kvm_recalculate_apic_map()

Michal Simek (1):
      MAINTAINERS: Add myself as reviewer instead of Naga

Michel D=C3=A4nzer (2):
      Revert "drm/amd/display: Block optimize on consecutive FAMS enables"
      Revert "drm/amd/display: Do not set drr on pipe commit"

Mike Christie (1):
      fork, vhost: Use CLONE_THREAD to fix freezer/ps regression

Mirsad Goran Todorovac (3):
      test_firmware: prevent race conditions by a correct
implementation of locking
      test_firmware: fix a memory leak with reqs buffer
      test_firmware: fix the memory leak of the allocated firmware buffer

Moshe Shemesh (1):
      net/mlx5: Read embedded cpu after init bit cleared

Mustafa Ismail (2):
      RDMA/irdma: Prevent QP use after free
      RDMA/irdma: Fix Local Invalidate fencing

Namhyung Kim (2):
      perf ftrace latency: Remove unnecessary "--" from --use-nsec option
      perf bpf filter: Fix a broken perf sample data naming for BPF CO-RE

Namjae Jeon (6):
      ksmbd: fix uninitialized pointer read in ksmbd_vfs_rename()
      ksmbd: fix uninitialized pointer read in smb2_create_link()
      ksmbd: fix credit count leakage
      ksmbd: fix UAF issue from opinfo->conn
      ksmbd: fix incorrect AllocationSize set in smb2_get_info
      ksmbd: call putname after using the last component

Neil Armstrong (1):
      phy: amlogic: phy-meson-g12a-mipi-dphy-analog: fix CNTL2_DIF_TX_CTL0 =
value

Nikita Zhandarovich (1):
      HID: wacom: avoid integer overflow in wacom_intuos_inout()

Niklas Schnelle (1):
      net/mlx5: Fix setting of irq->map.index for static IRQ case

Ojaswin Mujoo (1):
      Revert "ext4: remove ac->ac_found > sbi->s_mb_min_to_scan dead
check in ext4_mb_check_limits"

Oliver Upton (3):
      KVM: arm64: Drop last page ref in kvm_pgtable_stage2_free_removed()
      KVM: arm64: Iterate arm_pmus list to probe for default PMU
      KVM: arm64: Document default vPMU behavior on heterogeneous systems

Osama Muhammad (1):
      nfcsim.c: Fix error checking for debugfs_create_dir

Paolo Abeni (6):
      mptcp: fix connect timeout handling
      mptcp: add annotations around msk->subflow accesses
      mptcp: consolidate passive msk socket initialization
      mptcp: fix data race around msk->first access
      mptcp: add annotations around sk->sk_shutdown accesses
      mptcp: fix active subflow finalization

Paul Cercueil (1):
      iio: adc: ad7192: Change "shorted" channels to differential

Paul Moore (1):
      selinux: don't use make's grouped targets feature yet

Pedro Tammela (1):
      net/netlink: fix NETLINK_LIST_MEMBERSHIPS length report

Peilin Ye (4):
      net/sched: sch_ingress: Only create under TC_H_INGRESS
      net/sched: sch_clsact: Only create under TC_H_CLSACT
      net/sched: Reserve TC_H_INGRESS (TC_H_CLSACT) for ingress (clsact) Qd=
iscs
      net/sched: Prohibit regrafting ingress or clsact Qdiscs

Peter Rosin (2):
      dmaengine: at_hdmac: Repair bitfield macros for peripheral ID handlin=
g
      dmaengine: at_hdmac: Extend the Flow Controller bitfield to three bit=
s

Pietro Borrello (1):
      tracing/probe: trace_probe_primary_from_call(): checked list_first_en=
try

Pin-yen Lin (1):
      media: mediatek: vcodec: Only apply 4K frame sizes on decoder formats

Qu Wenruo (1):
      btrfs: zoned: fix dev-replace after the scrub rework

Raju Rangoju (1):
      amd-xgbe: fix the false linkup in xgbe_phy_status

Randy Dunlap (2):
      iommu: Make IPMMU_VMSA dependencies more strict
      dmaengine: pl330: rename _start to prevent build error

Rasmus Villemoes (1):
      iio: addac: ad74413: fix resistance input processing

Richard Acayan (2):
      misc: fastrpc: return -EPIPE to invocations on device removal
      misc: fastrpc: reject new invocations during device removal

Roger Quadros (1):
      usb: typec: tps6598x: Fix broken polling mode after system suspend/re=
sume

Ruihan Li (4):
      usb: usbfs: Enforce page requirements for mmap
      usb: usbfs: Use consistent mmap functions
      mm: page_table_check: Make it dependent on EXCLUSIVE_SYSTEM_RAM
      mm: page_table_check: Ensure user pages are not slab pages

Saeed Mahameed (1):
      net/mlx5e: Fix error handling in mlx5e_refresh_tirs

Samuel Iglesias Gons=C3=A1lvez (1):
      MAINTAINERS: Vaibhav Gupta is the new ipack maintainer

Sean Christopherson (3):
      KVM: x86/mmu: Grab memslot for correct address space in NX recovery w=
orker
      KVM: x86: Account fastpath-only VM-Exits in vCPU stats
      KVM: x86: Bail from kvm_recalculate_phys_map() if x2APIC ID is
out-of-bounds

Sean Nyekjaer (2):
      iio: adc: stm32-adc: skip adc-diff-channels setup if none is present
      iio: adc: stm32-adc: skip adc-channels setup if none is present

Sebastian Krzyszkowiak (1):
      net: usb: qmi_wwan: Set DTR quirk for BroadMobi BM818

Selvin Xavier (1):
      RDMA/bnxt_re: Fix the page_size used during the MR creation

Shay Drory (4):
      net/mlx5: Drain health before unregistering devlink
      net/mlx5: SF, Drain health before removing device
      net/mlx5: fw_tracer, Fix event handling
      net/mlx5: Remove rmap also in case dynamic MSIX not supported

Sherry Sun (1):
      tty: serial: fsl_lpuart: use UARTCTRL_TXINV to send break
instead of UARTCTRL_SBK

Shida Zhang (1):
      btrfs: fix an uninitialized variable warning in btrfs_log_inode

Song Liu (3):
      perf bpf: Do not use llvm-strip on BPF binary
      perf evsel: Separate bpf_counter_list and bpf_filters, can be
used at the same time
      module: fix module load for ia64

Srinivas Kandagatla (1):
      regmap: sdw: check for invalid multi-register writes config

Steve French (3):
      smb3: update a reviewer email in MAINTAINERS file
      smb3: missing null check in SMB2_change_notify
      cifs: address unused variable warning

Steven Rostedt (Google) (8):
      tracing/histograms: Allow variables to have some modifiers
      tracing: Rename stacktrace field to common_stacktrace
      tracing/selftests: Update synthetic event selftest to use
common_stacktrace
      tracing: Move setting of tracing_selftest_running out of register_tra=
cer()
      tracing: Have tracer selftests call cond_resched() before running
      tracing: Make tracing_selftest_running/delete nops when not used
      tracing: Only make selftest conditionals affect the global_trace
      tracing: Have function_graph selftest call cond_resched()

Sung-Chi Li (1):
      HID: google: add jewel USB id

Theodore Ts'o (5):
      ext4: add EA_INODE checking to ext4_iget()
      ext4: set lockdep subclass for the ea_inode in
ext4_xattr_inode_cache_find()
      ext4: disallow ea_inodes with extended attributes
      ext4: add lockdep annotations for i_data_sem for ea_inode's
      ext4: enable the lazy init thread when remounting read/write

Thomas Bogendoerfer (1):
      net: mellanox: mlxbf_gige: Fix skb_panic splat under memory pressure

Tim Huang (5):
      drm/amd/pm: reverse mclk and fclk clocks levels for SMU v13.0.4
      drm/amd/pm: reverse mclk clocks levels for SMU v13.0.5
      drm/amd/pm: reverse mclk and fclk clocks levels for yellow carp
      drm/amd/pm: reverse mclk and fclk clocks levels for vangogh
      drm/amd/pm: reverse mclk and fclk clocks levels for renoir

Tom Rix (1):
      phy: mediatek: rework the floating point comparisons to fixed point

Tomi Valkeinen (1):
      media: v4l2-subdev: Fix missing kerneldoc for client_caps

Tudor Ambarus (2):
      mtd: spi-nor: spansion: make sure local struct does not contain garba=
ge
      mtd: spi-nor: Fix divide by zero for spi-nor-generic flashes

Uday Shankar (3):
      nvme: double KA polling frequency to avoid KATO with TBKAS on
      nvme: check IO start time when deciding to defer KA
      nvme: improve handling of long keep alives

Uttkarsh Aggarwal (1):
      usb: gadget: f_fs: Add unbind event before functionfs_unbind

Uwe Kleine-K=C3=B6nig (7):
      fbdev: matroxfb ssd1307fb: Switch i2c drivers back to use .probe()
      fbdev: au1100fb: Drop if with an always false condition
      fbdev: arcfb: Convert to platform remove callback returning void
      fbdev: au1100fb: Convert to platform remove callback returning void
      fbdev: au1200fb: Convert to platform remove callback returning void
      fbdev: broadsheetfb: Convert to platform remove callback returning vo=
id
      fbdev: bw2: Convert to platform remove callback returning void

Vaishnav Achath (1):
      media: v4l2-mc: Drop subdev check in v4l2_create_fwnode_links_to_pad(=
)

Vasant Hegde (1):
      iommu/amd/pgtbl_v2: Fix domain max address

Vinod Koul (1):
      dmaengine: ti: k3-udma: annotate pm function with __maybe_unused

Vlad Buslov (1):
      net/mlx5: Fix post parse infra to only parse every action once

Vladislav Efanov (1):
      udp6: Fix race condition in udp6_sendmsg & connect

Wei Fang (1):
      net: stmmac: fix call trace when stmmac_xdp_xmit() is invoked

Wen Gu (2):
      net/smc: Scan from current RMB list when no position specified
      net/smc: Don't use RMBs not mapped to new link in SMCRv2 ADD LINK

Will Deacon (1):
      KVM: arm64: Prevent unconditional donation of unmapped regions
from the host

Xin Long (3):
      rtnetlink: call validate_linkmsg in rtnl_create_link
      rtnetlink: move IFLA_GSO_ tb check to validate_linkmsg
      rtnetlink: add the missing IFLA_GRO_ tb check in validate_linkmsg

Xu Liang (1):
      net: phy: mxl-gpy: extend interrupt fix to all impacted variants

Yangyang Li (1):
      RDMA/hns: Modify the value of long message loopback slice

Yassine Oudjana (1):
      media: camss: camss-video: Don't zero subdev format again after
initialization

Yevgeny Kliteynik (1):
      net/mlx5: DR, Add missing mutex init/destroy in pattern manager

Yonatan Nachum (1):
      RDMA/efa: Fix unsupported page sizes in device

Yoshihiro Shimoda (1):
      net: renesas: rswitch: Fix return value in error path of xmit

Yu Kuai (1):
      md/raid5: fix miscalculation of 'end_sector' in raid5_read_one_chunk(=
)

Zhengchao Shao (1):
      net: sched: fix NULL pointer dereference in mq_attach

fuyuanli (1):
      tcp: fix mishandling when the sack compression is deferred.

min15.li (1):
      nvme: fix miss command type check

pengfuyuan (1):
      btrfs: fix csum_tree_block page iteration to avoid tripping on
-Werror=3Darray-bounds
