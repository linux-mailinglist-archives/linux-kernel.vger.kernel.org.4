Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C6C693A73
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 23:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjBLWWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 17:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBLWWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 17:22:44 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530B6FF21
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 14:22:37 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id c26so22903421ejz.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 14:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7KsfEoMcA+zB198RWYfhZvSAjmKI2ykN5u2+SVfLEfo=;
        b=hREQYuRrwKkAVq0s44zOZWxqY+lsT4rNTqNurFTNnzzo6jNODsRuvEVkA4kWn7nYRy
         3LpPQEIl2m+RvEpuRLfKByZ6cRrrJUoPjwSbfdQLs//Kbpt//aCMn1AllNyiPwfBZUgL
         R4xIGSqQ8xuA5U/ytSB9AttsgP6/KFIu5uKZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7KsfEoMcA+zB198RWYfhZvSAjmKI2ykN5u2+SVfLEfo=;
        b=m1Elak9k7hiHZ/YPlyA7zk7Sj9AtmnlWvj1VjtGDdE6VdVzFRHerRPA2EAIj7rnpVC
         AC4phPf/0tOmIune7qFC05P7uGN+Ej6FLQfQGMdCbMcPXulaT7xsa36cEGguBq83nb8e
         LCnRtAA4RCmsXutNzgrtQYx1zZSSqrsmyBKbPIuUrslz2Z/9kGxfWIOFQr9HNoZoQ/LA
         CgnKuv77+Gat/FAvvpLXKKgRY477naN+wpnoSWNmtHqbbfSIpXEUhnKcNzersSTYKbQX
         IrJq9Tujb5dO7qvbyuJ149Y8boPJwNZrO7luTAJFDbJe29IOPIZPr0L9VUMUqMtmBrn/
         JM/g==
X-Gm-Message-State: AO0yUKUOfLHfh2+2oe+IGLjcUUxBaFI2bfauqo/xTLQXKS687f3RwQQW
        oYKZYTcrmoJ9Y1R/J3a/NoBMU750cn00Zay7sVE=
X-Google-Smtp-Source: AK7set/cUOOy+nCbomXj9FgpfrIwSl+e+9tE38sj5DbIG/9BST1anmxRQEB77TW6yh3nPCMtX+qIkg==
X-Received: by 2002:a17:907:7da0:b0:8aa:c038:974c with SMTP id oz32-20020a1709077da000b008aac038974cmr28212418ejc.54.1676240555367;
        Sun, 12 Feb 2023 14:22:35 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id s2-20020a1709060c0200b008786619684csm5848007ejf.125.2023.02.12.14.22.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Feb 2023 14:22:34 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id qw12so27729017ejc.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 14:22:34 -0800 (PST)
X-Received: by 2002:a17:906:3b84:b0:878:561c:6665 with SMTP id
 u4-20020a1709063b8400b00878561c6665mr3598359ejf.0.1676240554312; Sun, 12 Feb
 2023 14:22:34 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Feb 2023 14:22:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj1=T1KzpPWbhqfFWOEp5Wf_kj3JjTHSHmEngf0-Vv7aA@mail.gmail.com>
Message-ID: <CAHk-=wj1=T1KzpPWbhqfFWOEp5Wf_kj3JjTHSHmEngf0-Vv7aA@mail.gmail.com>
Subject: Linux 6.2-rc8
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

The 6.2 series continues to be fairly calm, and the only real reason
for an rc8 is - as now mentioned several times - just to make up for
some time during the holiday season. Not that we seem to really have
needed it, but there was also no real reason to deviate from the plan.
So here we are. And we did have a few late regression fixes, and a
couple still pending that will hopefully make it during next week, so
absolutely no harm done.

Most of the discussion I see seems to have already been about future
stuff, and I also already have one pull request for the next merge
window in my inbox (and I won't mind more if they show up). But in the
meantime we did have a scattering of the usual fixes, with networking,
GPU and sound drivers being the most noticeable. As is usual.

But there's other fixes in there too - both smaller driver subsystems
and to various other code. See the shortlog below for details.

              Linus

---

Aaron Thompson (1):
      Revert "mm: Always release pages to the buddy allocator in
memblock_free_late()."

Adham Faris (1):
      net/mlx5e: Update rx ring hw mtu upon each rx-fcs flag change

Alan Stern (1):
      net: USB: Fix wrong-direction WARNING in plusb.c

Alex Deucher (8):
      drm/amd/display: disable S/G display on DCN 2.1.0
      drm/amd/display: disable S/G display on DCN 3.1.2/3
      drm/amd/display: properly handling AGP aperture in vm setup
      Revert "drm/amd/display: disable S/G display on DCN 3.1.4"
      drm/amdgpu: add S/G display parameter
      Revert "drm/amd/display: disable S/G display on DCN 3.1.2/3"
      Revert "drm/amd/display: disable S/G display on DCN 2.1.0"
      Revert "drm/amd/display: disable S/G display on DCN 3.1.5"

Alexander Potapenko (1):
      btrfs: zlib: zero-initialize zlib workspace

Alexey Firago (1):
      ASoC: codecs: es8326: Fix DTS properties reading

Allen Hubbe (1):
      ionic: missed doorbell workaround

Amadeusz S=C5=82awi=C5=84ski (1):
      ASoC: topology: Return -ENOMEM on memory allocation failure

Amir Tzin (1):
      net/mlx5e: Fix crash unsetting rx-vlan-filter in switchdev mode

Anand Jain (1):
      btrfs: free device in btrfs_close_devices for a single device filesys=
tem

Anastasia Belova (1):
      xfrm: compat: change expression for switch in xfrm_xlate64

Andy Chi (1):
      ALSA: hda/realtek: fix mute/micmute LEDs don't work for a HP platform=
.

Andy Shevchenko (2):
      dt-bindings: Fix .gitignore
      pinctrl: intel: Restore the pins that used to be in Direct IRQ mode

Andy Yan (1):
      arm64: dts: rockchip: add io domain setting to rk3566-box-demo

Anirudh Venkataramanan (1):
      ice: Do not use WQ_MEM_RECLAIM flag for workqueue

Aravind Iddamsetty (1):
      drm/i915: Initialize the obj flags for shmem objects

Arnaud Ferraris (1):
      arm64: dts: rockchip: fix input enable pinconf on rk3399

Artemii Karasev (1):
      ALSA: emux: Avoid potential array out-of-bound in snd_emux_xg_control=
()

Ar=C4=B1n=C3=A7 =C3=9CNAL (1):
      net: ethernet: mtk_eth_soc: enable special tag when any MAC uses DSA

Bartosz Golaszewski (1):
      spi: spidev: fix a recursive locking error

Bastien Nocera (1):
      HID: logitech: Disable hi-res scrolling on USB

Benedict Wong (1):
      Fix XFRM-I support for nested ESP tunnels

Bert Karwatzki (1):
      drm/amdgpu: fix memory leak in amdgpu_cs_sync_rings

Bjorn Helgaas (3):
      MAINTAINERS: Move to shared PCI tree
      Revert "PCI/ASPM: Save L1 PM Substates Capability for suspend/resume"
      Revert "PCI/ASPM: Refactor L1 PM Substates Control Register programmi=
ng"

Brett Creeley (1):
      ice: Fix disabling Rx VLAN filtering with port VLAN enabled

Casper Andersson (1):
      net: microchip: sparx5: fix PTP init/deinit not checking all ports

Chen-Yu Tsai (1):
      arm64: dts: mediatek: mt8195: Fix vdosys* compatible strings

Christian Hopps (1):
      xfrm: fix bug with DSCP copy to v6 from v4 tunnel

Christian K=C3=B6nig (1):
      drm/client: fix circular reference counting issue

Chukun Pan (1):
      arm64: dts: rockchip: remove unsupported property from sdmmc2 for roc=
k-3a

Cl=C3=A9ment L=C3=A9ger (1):
      net: phylink: move phy_device_free() to correctly release phy device

Corentin Labbe (1):
      arm64: dts: rockchip: use correct reset names for rk3399 crypto nodes

Dan Carpenter (4):
      ALSA: pci: lx6464es: fix a debug loop
      RDMA/mana_ib: Prevent array underflow in mana_ib_create_qp_raw()
      ice: Fix off by one in ice_tc_forward_to_queue()
      net: sched: sch: Fix off by one in htb_activate_prios()

Dan Johansen (1):
      arm64: dts: rockchip: set sdmmc0 speed to sd-uhs-sdr50 on rock-3a

Dan Williams (2):
      nvdimm: Support sizeof(struct page) > MAX_STRUCT_PAGE_SIZE
      cxl/region: Fix passthrough-decoder detection

Daniel Beer (2):
      ASoC: tas5805m: rework to avoid scheduling while atomic.
      ASoC: tas5805m: add missing page switch.

Darren Hart (1):
      arm64: efi: Force the use of SetVirtualAddressMap() on eMAG and
Altra Max machines

Dave Airlie (1):
      nvidiafb: detect the hardware support before removing console.

David Chen (1):
      Fix page corruption caused by racy check in __free_pages

David Sterba (1):
      btrfs: send: limit number of clones and allocated memory size

Dean Luick (2):
      IB/hfi1: Restore allocated resources on failed copyout
      IB/hfi1: Assign npages earlier

Devid Antonio Filoni (1):
      can: j1939: do not wait 250 ms if the same addr was already claimed

Dmitry Torokhov (1):
      ARM: dts: stihxxx-b2120: fix polarity of reset line of tsin0 port

Douglas Anderson (1):
      cpufreq: qcom-hw: Fix cpufreq_driver->get() for non-LMH systems

Dragos Tatulea (2):
      IB/IPoIB: Fix legacy IPoIB due to wrong number of queues
      net/mlx5e: IPoIB, Show unknown speed instead of error

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Add Positivo N14KP6-TG

Elvis Angelaccio (1):
      ALSA: hda/realtek: Enable mute/micmute LEDs on HP Elitebook, 645 G9

Eric Dumazet (3):
      xfrm/compat: prevent potential spectre v1 gadget in xfrm_xlate32_attr=
()
      xfrm: consistently use time64_t in xfrm_timer_handler()
      xfrm: annotate data-race around use_time

Evan Quan (3):
      drm/amd/pm: add SMU 13.0.7 missing GetPptLimit message mapping
      drm/amd/pm: bump SMU 13.0.0 driver_if header version
      drm/amd/pm: bump SMU 13.0.7 driver_if header version

Fan Ni (1):
      cxl/region: Fix null pointer dereference for resetting decoder

Filipe Manana (2):
      btrfs: simplify update of last_dir_index_offset when logging a direct=
ory
      btrfs: lock the inode in shared mode before starting fiemap

Friedrich Vock (1):
      drm/amdgpu: Use the TGID for trace_amdgpu_vm_update_ptes

Geert Uytterhoeven (2):
      coredump: Move dump_emit_page() to kill unused warning
      clk: microchip: mpfs-ccc: Use devm_kasprintf() for allocating
formatted strings

Guilherme G. Piccoli (1):
      drm/amdgpu/fence: Fix oops due to non-matching drm_sched init/fini

Guillaume Pinot (1):
      ALSA: hda/realtek: Fix the speaker output on Samsung Galaxy Book2 Pro=
 360

Guo Ren (2):
      riscv: kprobe: Fixup misaligned load text
      riscv: Fixup race condition on PG_dcache_clean in flush_icache_pte

Guodong Liu (1):
      pinctrl: mediatek: Fix the drive register definition of some Pins

Haiyang Zhang (1):
      net: mana: Fix accessing freed irq affinity_hint

Hangbin Liu (1):
      selftests: forwarding: lib: quote the sysctl values

Heiner Kallweit (4):
      net: phy: meson-gxl: use MMD access dummy stubs for GXL, internal PHY
      arm64: dts: meson-axg: Make mmc host controller interrupts level-sens=
itive
      arm64: dts: meson-g12-common: Make mmc host controller
interrupts level-sensitive
      arm64: dts: meson-gx: Make mmc host controller interrupts level-sensi=
tive

Herton R. Krzesinski (1):
      uapi: add missing ip/ipv6 header dependencies for linux/stddef.h

Ido Schimmel (1):
      selftests: Fix failing VXLAN VNI filtering test

Jack Yu (1):
      ASoC: rt715-sdca: fix clock stop prepare timeout issue

Jane Jian (1):
      drm/amdgpu/smu: skip pptable init under sriov

Jarrah Gosbell (1):
      arm64: dts: rockchip: reduce thermal limits on rk3399-pinephone-pro

Jensen Huang (1):
      arm64: dts: rockchip: add missing #interrupt-cells to rk356x pcie2x1

JesseZhang (1):
      amd/amdgpu: remove test ib on hw ring

Jiawen Wu (1):
      net: txgbe: Update support email address

Jiri Pirko (1):
      devlink: change port event netdev notifier from per-net to global

Joel Stanley (2):
      pinctrl: aspeed: Fix confusing types in return value
      pinctrl: aspeed: Revert "Force to disable the function's signal"

Johan Jonker (1):
      ARM: dts: rockchip: add power-domains property to dp node on rk3288

John Paul Adrian Glaubitz (1):
      MAINTAINERS: Add myself as maintainer for arch/sh (SUPERH)

Jonas Karlman (1):
      arm64: dts: rockchip: fix probe of analog sound card on rock-3a

Josef Bacik (1):
      btrfs: limit device extents to the device size

Jouni H=C3=B6gander (1):
      drm/i915/fbdev: Implement fb_dirty for intel custom fb helper

Julian Anastasov (1):
      neigh: make sure used and confirmed times are valid

Kan Liang (1):
      x86/cpu: Add Lunar Lake M

Kenneth Feng (1):
      drm/amd/amdgpu: enable athub cg 11.0.3

Kent Russell (1):
      drm/amdgpu: Add unique_id support for GC 11.0.1/2

Kevin Yang (1):
      txhash: fix sk->sk_txrehash default

Krzysztof Kozlowski (3):
      arm64: dts: rockchip: drop unused LED mode property from rk3328-roc-c=
c
      arm64: dts: rockchip: align rk3399 DMC OPP table with bindings
      pinctrl: qcom: sm8450-lpass-lpi: correct swr_rx_data group

Lad Prabhakar (1):
      dt-bindings: interrupt-controller: arm,gic-v3: Fix typo in
description of msi-controller property

Li Zhijian (1):
      RDMA/rtrs: Don't call kobject_del for srv_path->kobj

Linus Torvalds (1):
      Linux 6.2-rc8

Liu Shixin (1):
      riscv: stacktrace: Fix missing the first frame

Lorenzo Pieralisi (1):
      MAINTAINERS: Promote Krzysztof to PCI controller maintainer

Luka Guzenko (1):
      HID: Ignore battery for ELAN touchscreen 29DF on HP

Maher Sanalla (2):
      net/mlx5: Store page counters in a single array
      net/mlx5: Expose SF firmware pages counter

Maor Gottlieb (1):
      RDMA/umem: Use dma-buf locked API to solve deadlock

Mario Limonciello (2):
      pinctrl: amd: Fix debug output for debounce time
      HID: amd_sfh: if no sensors are enabled, clean up

Mark Brown (1):
      of/address: Return an error when no valid dma-ranges are found

Mark Pearson (1):
      usb: core: add quirk for Alcor Link AK9563 smartcard reader

Matthieu Baerts (1):
      selftests: mptcp: stop tests earlier

Maxim Korotkov (1):
      pinctrl: single: fix potential NULL dereference

Mayuresh Chitale (1):
      riscv: mm: Implement pmdp_collapse_flush for THP

Melissa Wen (1):
      drm/amd/display: fix cursor offset on rotation 180

Michael Ellerman (1):
      powerpc: Don't select ARCH_WANTS_NO_INSTR

Michael Kelley (1):
      hv_netvsc: Allocate memory in netvsc_dma_map() with GFP_ATOMIC

Michal Suchanek (1):
      of: Make OF framebuffer device names unique

Michal Swiatkowski (1):
      ice: fix out-of-bounds KASAN warning in virtchnl

Nadav Amit (1):
      x86/kprobes: Fix 1 byte conditional jump target

Neel Patel (1):
      ionic: clean interrupt before enabling queue to avoid credit race

Nicholas Piggin (1):
      powerpc/64s/interrupt: Fix interrupt exit race with security
mitigation switch

Nikita Zhandarovich (1):
      RDMA/irdma: Fix potential NULL-ptr-dereference

Paolo Abeni (5):
      mptcp: do not wait for bare sockets' timeout
      mptcp: fix locking for setsockopt corner-case
      mptcp: fix locking for in-kernel listener creation
      mptcp: be careful on subflow status propagation on errors
      selftests: mptcp: allow more slack for slow test-case

Paul Cercueil (2):
      clk: ingenic: jz4760: Update M/N/OD calculation algorithm
      Revert "usb: gadget: u_ether: Do not make UDC parent of the net devic=
e"

Pietro Borrello (1):
      rds: rds_rm_zerocopy_callback() use list_first_entry()

Prashant Malani (1):
      usb: typec: altmodes/displayport: Fix probe pin assign check

Qi Zheng (1):
      bonding: fix error checking in bond_debug_reregister()

Qu Wenruo (1):
      btrfs: raid56: make error_bitmap update atomic

Radhey Shyam Pandey (1):
      net: macb: Perform zynqmp dynamic configuration only for SGMII interf=
ace

Randy Dunlap (2):
      dax: super.c: fix kernel-doc bad line warning
      powerpc/kexec_file: fix implicit decl error

Rob Clark (1):
      drm/i915: Move fd_install after last use of fence

Ryan Neph (1):
      drm/virtio: exbuf->fence_fd unmodified on interrupted wait

Sasha Neftin (1):
      igc: Add ndo_tx_timeout support

Serge Semin (1):
      spi: dw: Fix wrong FIFO level setting for long xfers

Shannon Nelson (1):
      ionic: clear up notifyq alloc commentary

Shay Drory (3):
      net/mlx5: fw_tracer, Clear load bit when freeing string DBs buffers
      net/mlx5: fw_tracer, Zero consumer index when reloading the tracer
      net/mlx5: Serialize module cleanup with reload and remove

Shengjiu Wang (1):
      ASoC: fsl_sai: fix getting version from VERID

Shiju Jose (1):
      tracing: Fix poll() and select() do not work on per_cpu
trace_pipe and trace_pipe_raw

Stefan Binding (1):
      ALSA: hda/realtek: Add quirk for ASUS UM3402 using CS35L41

Takahiro Fujii (1):
      HID: elecom: add support for TrackBall 056E:011C

Tanmay Bhushan (1):
      btrfs: raid56: fix stripes if vertical errors are found

Tariq Toukan (1):
      net: ethernet: mtk_eth_soc: fix wrong parameters order in
__xdp_rxq_info_reg()

Tom Rix (1):
      nvme-auth: mark nvme_auth_wq static

V sujith kumar Reddy (1):
      ASoC: SOF: amd: Fix for handling spurious interrupts from DSP

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915: Don't do the WM0->WM1 copy w/a if WM1 is already enabled
      drm/i915: Fix VBT DSI DVO port handling

Vishal Verma (1):
      ACPI: NFIT: fix a potential deadlock during NFIT teardown

Vlad Buslov (1):
      net/mlx5: Bridge, fix ageing of peer FDB entries

Vladimir Oltean (5):
      net: dsa: mt7530: don't change PVC_EG_TAG when CPU port becomes VLAN-=
aware
      net: mscc: ocelot: fix VCAP filters not matching on MAC with
"protocol 802.1Q"
      selftests: ocelot: tc_flower_chains: make
test_vlan_ingress_modify() more comprehensive
      net: ethernet: mtk_eth_soc: fix DSA TX tag hwaccel for switch port 0
      net: mscc: ocelot: fix all IPv6 getting trapped to CPU when PTP
timestamping is used

Waiman Long (1):
      cgroup/cpuset: Don't filter offline CPUs in
cpuset_cpus_allowed() for top cpuset tasks

Wander Lairson Costa (1):
      rtmutex: Ensure that the top waiter is always woken up

Will Deacon (1):
      cpuset: Call set_cpus_allowed_ptr() with appropriate mask for task

Xin Zhao (1):
      HID: core: Fix deadloop in hid_apply_multiplier.

Xiubo Li (1):
      ceph: flush cap releases when the session is flushed

Yafang Shao (1):
      tracing: Fix TASK_COMM_LEN in trace event format file

Yang Yingliang (1):
      RDMA/usnic: use iommu_map_atomic() under spin_lock()

Yevgeny Kliteynik (1):
      net/mlx5: DR, Fix potential race in dr_rule_create_rule_nic

Yu Xiao (1):
      nfp: ethtool: fix the bug of setting unsupported port speed

Zhang Changzhong (1):
      ice: switch: fix potential memleak in ice_add_adv_recipe()

ZhaoLong Wang (1):
      cifs: Fix use-after-free in rdata->read_into_pages()

marco.rodolfi@tuta.io (1):
      HID: Ignore battery for Elan touchscreen on Asus TP420IA
