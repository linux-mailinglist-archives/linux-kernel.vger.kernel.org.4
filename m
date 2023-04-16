Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4123D6E3CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 00:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjDPWik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 18:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjDPWij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 18:38:39 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BAF1FDD
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 15:38:36 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a5so2983143ejb.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 15:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1681684715; x=1684276715;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ilS4Z7Y07JYNmwBW9pMGq2ZfsM6vVHMJL3mOLd3Tpc4=;
        b=U1Qdx7Rp7dyB+6vxaVoH//1InWuUrQvdUUiSiauGsA05KNuLAj0Jg4XGm3XH52557I
         Hp2sCsOjiEUNh2OjyQJfn/2h91FbMupBx4KGYuN5+V1S/BU+n6CP/t+zP6moy1jIgvUN
         GAVcRJLH9u/x47fBnWZvrIz6PS2sp9IEP1EQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681684715; x=1684276715;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ilS4Z7Y07JYNmwBW9pMGq2ZfsM6vVHMJL3mOLd3Tpc4=;
        b=WqYmiwfr6oTGhucpsEnp0RRXpYKOmIDi079OSdiQVlov5TO8YlH3S5HRxIyzGGM9Gn
         My6HbammwmmmMDntLUNz1ot0Psvp7ahflzFecCdKGy/3lwCJ5Iv0iVHE3Yx46NF6KdFU
         W75Lzcrs7HZwq/o7oTTUmvhI+kGreEiK41u2osArhXT51X2VmrCO4ec4YMleXfftVz22
         fwufhc6pu2dbPV5T+CcP2q/H8GFLOCwPisMjQ4X8RlTvhwbKSLFakFAtSMsmxNqwXUtw
         g3yBggwXTVNxqhfjSylIKfPF35sBXBRQmCtiEAQhRyuOgBg9Myj7xxjCGQLFISe8nYFa
         mInQ==
X-Gm-Message-State: AAQBX9eEWRpABj7XD4+CJQpzQ8BKZRIFpZ5MdaiIjExNb0HyZDEK3Fui
        P9Kx+2Bar/gckeCWoktaRUaREQ2uXX4By0oImXqgKQ==
X-Google-Smtp-Source: AKy350ZTTpQBk/r9YE/G6hdAfQoBFJOwY7Vxijj9k2MOv7Pyiw8DtzYkCWRQMFNIFHT7JdITjn0Uig==
X-Received: by 2002:a17:907:7f04:b0:94b:7743:3971 with SMTP id qf4-20020a1709077f0400b0094b77433971mr6020764ejc.63.1681684714943;
        Sun, 16 Apr 2023 15:38:34 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090681c500b0094f7092c231sm844546ejx.6.2023.04.16.15.38.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 15:38:34 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id vc20so4584608ejc.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 15:38:34 -0700 (PDT)
X-Received: by 2002:a17:906:57c7:b0:94e:fe9a:31ff with SMTP id
 u7-20020a17090657c700b0094efe9a31ffmr2684640ejr.4.1681684713831; Sun, 16 Apr
 2023 15:38:33 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 16 Apr 2023 15:38:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjwK59PegTZb9r=EVuCPwbigcbbby5AwEboMBgykhL-KA@mail.gmail.com>
Message-ID: <CAHk-=wjwK59PegTZb9r=EVuCPwbigcbbby5AwEboMBgykhL-KA@mail.gmail.com>
Subject: Linux 6.3-rc7
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Really not a lot in here, although there's a late cgroup cpuset fix
that is a bit more involved than maybe I'd have liked at this point.
But hey, even that isn't exactly huge.

Apart from the cgroup thing, it's all pretty normal, with m,ainly
driver updates (gpu and networking leading the pack as usual, but
there's block fixes and minor noise elsewhere too), with some arch
updates, some selftests, and some packaging fixes.

Let's hope we have just one more calm week, and we'll have had a nice
uneventful release cycle. Knock wood,

             Linus

---

Aaron Conole (1):
      selftests: openvswitch: adjust datapath NL message declaration

Ahmed Zaki (2):
      iavf: refactor VLAN filter states
      iavf: remove active_cvlans and active_svlans bitmaps

Alessandro Manca (1):
      HID: topre: Add support for 87 keys Realforce R2

Alexander Stein (1):
      clk: rs9: Fix suspend/resume

Alexandre Ghiti (3):
      riscv: Move early dtb mapping into the fixmap region
      riscv: Do not set initial_boot_params to the linear address of the dt=
b
      riscv: No need to relocate the dtb as it lies in the fixmap region

Alyssa Ross (1):
      purgatory: fix disabling debug info

Andy Shevchenko (1):
      dmaengine: Actually use devm_add_action_or_reset()

Aneesh Kumar K.V (1):
      powerpc/papr_scm: Update the NUMA distance table for the target node

Arseniy Krasnov (1):
      mtd: rawnand: meson: fix bitmask for length in command word

Asahi Lina (1):
      drm/scheduler: Fix UAF race in drm_sched_entity_push_job()

Bang Li (1):
      mtdblock: tolerate corrected bit-flips

Basavaraj Natikar (1):
      x86/PCI: Add quirk for AMD XHCI controller that loses MSI-X state in =
D3hot

Benjamin Gray (2):
      initramfs: Check negative timestamp to prevent broken cpio archive
      init/initramfs: Fix argument forwarding to panic() in panic_show_mem(=
)

Cheng Xu (4):
      RDMA/erdma: Fix some typos
      RDMA/erdma: Update default EQ depth to 4096 and max_send_wr to 8192
      RDMA/erdma: Inline mtt entries into WQE if supported
      RDMA/erdma: Defer probing if netdevice can not be found

Christoph Hellwig (2):
      btrfs: restore the thread_pool=3D behavior in remount for the end
I/O workqueues
      btrfs: fix fast csum implementation detection

Christophe JAILLET (1):
      drm/armada: Fix a potential double free in an error handling path

Christophe Kerello (2):
      mtd: rawnand: stm32_fmc2: remove unsupported EDO mode
      mtd: rawnand: stm32_fmc2: use timings.mode instead of checking tRC_mi=
n

Chunyan Zhang (1):
      clk: sprd: set max_register according to mapping range

Claudia Draghicescu (1):
      Bluetooth: Set ISO Data Path on broadcast sink

Damien Le Moal (1):
      MAINTAINERS: Change ata maintainer email addresses

Daniel Vetter (3):
      fbmem: Reject FB_ACTIVATE_KD_TEXT from userspace
      fbcon: Fix error paths in set_con2fb_map
      fbcon: set_con2fb_map needs to set con2fb_map!

David Disseldorp (2):
      ksmbd: avoid out of bounds access in decode_preauth_ctxt()
      cifs: fix negotiate context parsing

David Gow (1):
      um: Only disable SSE on clang to work around old GCC bugs

David Howells (1):
      netfs: Fix netfs_extract_iter_to_sg() for ITER_UBUF/IOVEC

Denis Plotnikov (1):
      qlcnic: check pci_reset_function result

Dmitry Fomichev (2):
      virtio-blk: fix to match virtio spec
      virtio-blk: fix ZBD probe in kernels without ZBD support

Douglas Anderson (1):
      r8152: Add __GFP_NOWARN to big allocations

Duy Truong (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for T-FORCE Z330 SSD

Eli Cohen (1):
      vdpa/mlx5: Add and remove debugfs in setup/teardown driver

Eric Dumazet (1):
      udp6: fix potential access to stale information

Eric Van Hensbergen (1):
      Update email address and mailing list for v9fs

Evan Quan (1):
      drm/amd/pm: correct the pcie link state check for SMU13

Felix Huettner (1):
      net: openvswitch: fix race on port output

Fuad Tabba (1):
      KVM: arm64: Advertise ID_AA64PFR0_EL1.CSV2/3 to protected VMs

Geert Uytterhoeven (1):
      treewide: Fix probing of devices in DT overlays

George Guo (1):
      LoongArch, bpf: Fix jit to skip speculation barrier opcode

Gregor Herburger (1):
      i2c: ocores: generate stop condition after timeout in polling mode

Hangbin Liu (3):
      bonding: fix ns validation on backup slaves
      selftests: bonding: re-format bond option tests
      selftests: bonding: add arp validate test

Harshit Mogalapalli (2):
      niu: Fix missing unwind goto in niu_alloc_channels()
      net: wwan: iosm: Fix error handling path in ipc_pcie_probe()

Horatio Zhang (2):
      drm/amd/pm: correct SMU13.0.7 pstate profiling clock settings
      drm/amd/pm: correct SMU13.0.7 max shader clock reporting

Ivan Bornyakov (2):
      net: sfp: initialize sfp->i2c_block_size at sfp allocation
      net: sfp: avoid EEPROM read of absent SFP module

Ivan Orlov (1):
      9P FS: Fix wild-memory-access write in v9fs_get_acl

Jani Nikula (1):
      drm/i915/dsi: fix DSS CTL register offsets for TGL+

Jesper Dangaard Brouer (6):
      selftests/bpf: xdp_hw_metadata remove bpf_printk and add counters
      xdp: rss hash types representation
      mlx5: bpf_xdp_metadata_rx_hash add xdp rss hash type
      veth: bpf_xdp_metadata_rx_hash add xdp rss hash type
      mlx4: bpf_xdp_metadata_rx_hash add xdp rss hash type
      selftests/bpf: Adjust bpf_xdp_metadata_rx_hash for new arg

Jiri Kosina (1):
      scsi: ses: Handle enclosure with just a primary component gracefully

Josh Don (1):
      cgroup: fix display of forceidle time at root

Kai Vehmanen (1):
      ALSA: hda/hdmi: disable KAE for Intel DG2

Karol Herbst (1):
      drm/nouveau/fb: add missing sysmen flush callbacks

Kornel Dul=C4=99ba (1):
      Revert "pinctrl: amd: Disable and mask interrupts on resume"

Kuniyuki Iwashima (1):
      smc: Fix use-after-free in tcp_write_timer_handler().

Liang Chen (1):
      skbuff: Fix a race between coalescing and releasing SKBs

Linus Torvalds (1):
      Linux 6.3-rc7

Liu Peibao (1):
      dt-bindings: interrupt-controller: loongarch: Fix mismatched compatib=
le

Lorenzo Bianconi (1):
      selftests/bpf: fix xdp_redirect xdp-features selftest for veth driver

Luiz Augusto von Dentz (6):
      Bluetooth: hci_conn: Fix not cleaning up on LE Connection failure
      Bluetooth: Fix printing errors if LE Connection times out
      Bluetooth: SCO: Fix possible circular locking dependency on
sco_connect_cfm
      Bluetooth: SCO: Fix possible circular locking dependency
sco_sock_getsockopt
      Bluetooth: hci_conn: Fix possible UAF
      Bluetooth: L2CAP: Fix use-after-free in l2cap_disconnect_{req,rsp}

Maher Sanalla (1):
      IB/mlx5: Add support for 400G_8X lane speed

Mario Limonciello (1):
      ACPI: x86: utils: Add Picasso to the list for forcing StorageD3Enable

Mark Zhang (1):
      RDMA/cma: Allow UD qp_type to join multicast only

Martin KaFai Lau (1):
      bpf: tcp: Use sock_gen_put instead of sock_put in bpf_iter_tcp

Martin Povi=C5=A1er (3):
      dmaengine: apple-admac: Handle 'global' interrupt flags
      dmaengine: apple-admac: Set src_addr_widths capability
      dmaengine: apple-admac: Fix 'current_tx' not getting freed

Martin Willi (1):
      rtnetlink: Restore RTM_NEW/DELLINK notification behavior

Masahiro Yamada (4):
      kbuild: give up untracked files for source package builds
      kbuild: merge cmd_archive_linux and cmd_archive_perf
      kbuild: do not create intermediate *.tar for source tarballs
      kbuild: do not create intermediate *.tar for tar packages

Mathis Salmen (1):
      riscv: add icache flush for nommu sigreturn trampoline

Matija Glavinic Pecotic (1):
      x86/rtc: Remove __init for runtime functions

Matthieu Baerts (1):
      selftests: mptcp: userspace pm: uniform verify events

Mike Christie (2):
      vhost-scsi: Fix vhost_scsi struct use after free
      vhost-scsi: Fix crash during LUN unmapping

Min Li (1):
      Bluetooth: Fix race condition in hidp_session_thread

Ming Lei (1):
      io_uring: complete request via task work in case of DEFER_TASKRUN

Mustafa Ismail (3):
      RDMA/irdma: Do not generate SW completions for NOPs
      RDMA/irdma: Fix memory leak of PBLE objects
      RDMA/irdma: Increase iWARP CM default rexmit count

Nathan Chancellor (1):
      Documentation/llvm: Add a note about prebuilt kernel.org toolchains

Oleksij Rempel (1):
      clk: imx6ul: fix "failed to get parent" error

Oswald Buddenhagen (5):
      ALSA: i2c/cs8427: fix iec958 mixer control deactivation
      ALSA: hda/sigmatel: add pin overrides for Intel DP45SG motherboard
      ALSA: hda/sigmatel: fix S/PDIF out on Intel D*45* motherboards
      ALSA: emu10k1: fix capture interrupt handler unlinking
      ALSA: emu10k1: don't create old pass-through playback device on Audig=
y

Paolo Abeni (3):
      mptcp: use mptcp_schedule_work instead of open-coding it
      mptcp: stricter state check in mptcp_worker
      mptcp: fix NULL pointer dereference on fastopen early fallback

Paul Menzel (1):
      ACPI: resource: Skip IRQ override on ASUS ExpertBook B1502CBA

Philippe Troin (1):
      HID: add HP 13t-aw100 & 14t-ea100 digitizer battery quirks

Pierre-Louis Bossart (1):
      ALSA: hda: patch_realtek: add quirk for Asus N7601ZM

Radu Pirea (OSS) (2):
      net: phy: nxp-c45-tja11xx: fix unsigned long multiplication overflow
      net: phy: nxp-c45-tja11xx: add remove callback

Reiji Watanabe (1):
      KVM: arm64: PMU: Restore the guest's EL0 event counting after migrati=
on

Reinette Chatre (1):
      PCI/MSI: Provide missing stub for pci_msix_can_alloc_dyn()

Rob Herring (2):
      PCI: Fix use-after-free in pci_bus_release_domain_nr()
      net: ti/cpsw: Add explicit platform_device.h and of_platform.h includ=
es

Roman Gushchin (1):
      net: macb: fix a memory corruption in extended buffer descriptor mode

Ross Zwisler (1):
      tools/virtio: fix typo in README instructions

Saravanan Vajravel (1):
      RDMA/core: Fix GID entry ref leak when create_ah fails

Sasha Finkelstein (1):
      bluetooth: btbcm: Fix logic error in forming the board name.

Srinivas Pandruvada (1):
      thermal: intel: Avoid updating unsupported THERM_STATUS_CLEAR mask bi=
ts

Stefan Binding (1):
      ALSA: hda/realtek: Add quirks for Lenovo Z13/Z16 Gen2

Stefano Garzarella (1):
      vdpa_sim_net: complete the initialization before register the device

Tanu Malhotra (1):
      HID: intel-ish-hid: Fix kernel panic during warm reset

Tatyana Nikolova (1):
      RDMA/irdma: Add ipv4 check to irdma_find_listener()

Tetsuo Handa (1):
      cgroup,freezer: hold cpu_hotplug_lock before freezer_mutex

Tharun Kumar P (1):
      i2c: mchp-pci1xxxx: Update Timing registers

Todd Brandt (1):
      HID: hid-sensor-custom: Fix buffer overrun in device name

Vincent Guittot (1):
      sched/fair: Fix imbalance overflow

Vladimir Oltean (1):
      net: enetc: workaround for unresponsive pMAC after receiving
express traffic

Waiman Long (5):
      cgroup/cpuset: Fix partition root's cpuset.cpus update bug
      cgroup/cpuset: Wake up cpuset_attach_wq tasks in cpuset_cancel_attach=
()
      cgroup/cpuset: Make cpuset_fork() handle CLONE_INTO_CGROUP properly
      cgroup/cpuset: Add cpuset_can_fork() and cpuset_cancel_fork() methods
      cgroup/cpuset: Make cpuset_attach_task() skip subpartitions CPUs
for top_cpuset

Wayne Lin (1):
      drm/amd/display: Pass the right info to drm_dp_remove_payload

Wyes Karny (1):
      amd-pstate: Fix amd_pstate mode switch

Xin Long (2):
      sctp: fix a potential overflow in sctp_ifwdtsn_skip
      selftests: add the missing CONFIG_IP_SCTP in net config

Xu Biang (1):
      ALSA: firewire-tascam: add missing unwind goto in
snd_tscm_stream_start_duplex()

Xu Kuohai (1):
      bpf, arm64: Fixed a BTI error on returning to patched function

Yang Li (1):
      dmaengine: xilinx: xdma: Fix some kernel-doc comments

YueHaibing (1):
      tcp: restrict net.ipv4.tcp_app_win

ZhaoLong Wang (1):
      ubi: Fix deadlock caused by recursively holding work_sem

Zheng Wang (2):
      9p/xen : Fix use after free bug in xen_9pfs_front_remove due to
race condition
      Bluetooth: btsdio: fix use after free bug in btsdio_remove due
to race condition

Zhihao Cheng (1):
      ubi: Fix failure attaching when vid_hdr offset equals to (sub)page si=
ze

Ziwei Dai (1):
      rcu/kvfree: Avoid freeing new kfree_rcu() memory after old grace peri=
od

Ziyang Xuan (1):
      net: qrtr: Fix an uninit variable access bug in qrtr_tx_resume()
