Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85DA6C9867
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 00:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjCZWEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 18:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCZWEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 18:04:00 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F3D2688
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 15:03:56 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eg48so28322502edb.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 15:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679868234;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xGAK3dqGeakwEqCpzO3oAfW6GHOKisuDmN7BPIfnOLQ=;
        b=Ic5BzZ0GNHeC212Btos+/psHFGgf9l1jsNWVzg0UvA4hFyJy0DHrGu3MRDwZ8tHldC
         1CnjGc/PVQpsw2ZGbXZpr+s1bmc+HaB3vXrAg83ySrPmdJRMg8pfnUHlkL1yfuuWDhhv
         mGUOe9BRxrbo8hAU9T4Vu9rtQPRfvH0COmjLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679868234;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xGAK3dqGeakwEqCpzO3oAfW6GHOKisuDmN7BPIfnOLQ=;
        b=ByMSolf4P23qUrLm7aSRgIQBy5VL47GvCXgNvjico7arGl0AKe1JH18L33jVnfnEGN
         xEAQQ6B6Z7j5rznLamnkrjCM1OQdveX861gsSfSpv0DCd83XU/4o6f4O0Rfz154P2Gov
         Nisj+UG+RfE9AOEAM//RdpfTTOLw2vjg9LL4oEq9CoNudZsvzfH5TmvgOHrJvgMDV0PZ
         sN85dyE03Mhyga/s2bLVYPWuNXokXjc8gtqrBTJPwTO3NMQn9fujGVE9EziEIdeIfEtq
         bzWO0AcI1ICHj2I896WYhIf49XWI+UC7kdxKpyNynS2k7bGQFkbg9omou3Zr3ZPCOW8k
         c4uw==
X-Gm-Message-State: AAQBX9f7tN1dwgPLHQaJgVKJaLiSOIljIYLb6PZ319YXG2jeKFRUqqGG
        iNB5hL6+WgeIJgCnPipJrEaFWL+SAfcpRnepO+s3iA==
X-Google-Smtp-Source: AKy350aIvWD4SJSFFhbkEcBtKdrVVnurmZ9gYhl5+Dfr7XGdm+a/oTJ9cDm5vb4n63NJPb8c+GonBA==
X-Received: by 2002:a17:906:364d:b0:930:60ba:d4b with SMTP id r13-20020a170906364d00b0093060ba0d4bmr10269928ejb.37.1679868234070;
        Sun, 26 Mar 2023 15:03:54 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 22-20020a170906309600b0092f289b6fdbsm13319908ejv.181.2023.03.26.15.03.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 15:03:53 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id eg48so28322331edb.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 15:03:53 -0700 (PDT)
X-Received: by 2002:a17:906:2456:b0:8e5:411d:4d09 with SMTP id
 a22-20020a170906245600b008e5411d4d09mr4667141ejb.15.1679868232187; Sun, 26
 Mar 2023 15:03:52 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Mar 2023 15:03:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whcaHLNpb7Mu_QX7ABwPgyRyfW-V8=v4Mv0S22fpjY4JQ@mail.gmail.com>
Message-ID: <CAHk-=whcaHLNpb7Mu_QX7ABwPgyRyfW-V8=v4Mv0S22fpjY4JQ@mail.gmail.com>
Subject: Linux 6.3-rc4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Things are looking pretty normal for this time of the release process.
All the stats look very regular, and the diffstat mostly does too.

I say "mostly", just because we had a bunch of xfs fixes last week,
which makes the diffstat skew that way more than usual. But even that
is mainly for a self-test addition. The actual code changes are much
smaller.

So instead of the usual 50+% drivers, the rc4 diffstat is about "one
third drivers, one third filesystems, one third rest". Not all of the
filesystem stuff is xfs, of course - we have cifs, btrfs and ksmbd
fixes too.

On the driver side, it's a mix, but networking and gpu shows up as
usual. With USB and thunderbolt fixes showing up, and the rest being
fairly random.

And "the rest" is all the normal stuff. Self-tests, core networking,
architecture updates, nothing odd there.

Let's hope things stay normal. And, as normal, testing and reporting
issues is appreciated,

       Linus

---

AKASHI Takahiro (1):
      igc: fix the validation logic for taprio's gate list

Abel Vesa (2):
      arm64: dts: qcom: sm8550: Add bias pull up value to tlmm i2c
data clk states
      soc: qcom: llcc: Fix slice configuration values for SC8280XP

Ahmed Zaki (1):
      iavf: do not track VLAN 0 filters

Akihiko Odaki (2):
      igb: Enable SR-IOV after reinit
      igbvf: Regard vf reset nack as success

Alex Hung (1):
      drm/amd/display: remove outdated 8bpc comments

Alexander Lobakin (2):
      iavf: fix inverted Rx hash condition leading to disabled hash
      iavf: fix non-tunneled IPv6 UDP packet type and hashing

Alexander Stein (6):
      arm64: dts: freescale: imx8-ss-lsio: Fix flexspi clock order
      usb: misc: onboard-hub: add support for Microchip USB2517 USB 2.0 hub
      arm64: dts: imx93: Fix eqos properties
      arm64: dts: imx93: add missing #address-cells and #size-cells to i2c =
nodes
      i2c: imx-lpi2c: clean rx/tx buffers upon new message
      i2c: imx-lpi2c: check only for enabled interrupt flags

Alexander Wetzel (1):
      wifi: mac80211: Serialize ieee80211_handle_wake_tx_queue()

Alexei Starovoitov (2):
      selftests/bpf: Fix progs/find_vma_fail1.c build error.
      selftests/bpf: Fix progs/test_deny_namespace.c issues.

Alvin =C5=A0ipraga (1):
      usb: gadget: u_audio: don't let userspace block driver unbind

Andrew Halaney (1):
      arm64: dts: imx8dxl-evk: Fix eqos phy reset gpio

Andrew Jeffery (1):
      ARM: 9290/1: uaccess: Fix KASAN false-positives

Andrzej Hajda (1):
      drm/i915/gt: perform uc late init after probe error injection

Andy Shevchenko (1):
      usb: gadget: Use correct endianness of the wLength field for WebUSB

Ard Biesheuvel (10):
      efi/libstub: zboot: Mark zboot EFI application as NX compatible
      efi/libstub: arm64: Remap relocated image with strict permissions
      arm64: efi: Set NX compat flag in PE/COFF header
      efi: earlycon: Reprobe after parsing config tables
      efi/libstub: smbios: Use length member instead of record struct size
      arm64: efi: Use SMBIOS processor version to key off Ampere quirk
      efi/libstub: smbios: Drop unused 'recsize' parameter
      efi/libstub: zboot: Add compressed image to make targets
      efi/libstub: Use relocated version of kernel's struct screen_info
      efi/libstub: randomalloc: Return EFI_OUT_OF_RESOURCES on failure

Arnd Bergmann (2):
      gpu: host1x: fix uninitialized variable use
      gpu: host1x: fix uninitialized variable use

Ar=C4=B1n=C3=A7 =C3=9CNAL (3):
      net: dsa: mt7530: move enabling disabling core clock to mt7530_pll_se=
tup()
      net: dsa: mt7530: move lowering TRGMII driving to mt7530_setup()
      net: dsa: mt7530: move setting ssc_delta to PHY_INTERFACE_MODE_TRGMII=
 case

Ashutosh Dixit (1):
      Revert "drm/i915/hwmon: Enable PL1 power limit"

Aymeric Wibo (1):
      ACPI: resource: Add Medion S17413 to IRQ override quirk

Badal Nilawar (1):
      drm/i915/mtl: Disable MC6 for MTL A step

Bob Peterson (1):
      Reinstate "GFS2: free disk inode which is deleted by remote node -V2"

Breno Leitao (1):
      perf/x86/amd/core: Always clear status for idx

Brian Gix (1):
      Bluetooth: Remove "Power-on" check from Mesh feature

Brian Masney (1):
      arm64: dts: qcom: sa8540p-ride: correct name of remoteproc_nsp0 firmw=
are

Caleb Sander (1):
      nvme-tcp: fix nvme_tcp_term_pdu to match spec

Chang S. Bae (2):
      x86/fpu/xstate: Prevent false-positive warning in __copy_xstate_uabi_=
buf()
      selftests/x86/amx: Add a ptrace test

ChenXiaoSong (1):
      ksmbd: fix possible refcount leak in smb2_open()

Chengen Du (1):
      NFS: Correct timing for assigning access cache timestamp

Christophe JAILLET (1):
      firmware: arm_scmi: Use the bitmap API to allocate bitmaps

Chuck Lever (2):
      NFS & NFSD: Update GSS dependencies
      SUNRPC: Fix a crash in gss_krb5_checksum()

Coly Li (1):
      dm thin: fix deadlock when swapping to thin device

Cristian Marussi (2):
      firmware: arm_scmi: Fix raw coexistence mode behaviour on failure pat=
h
      firmware: arm_scmi: Fix device node validation for mailbox transport

Damien Le Moal (2):
      zonefs: Prevent uninitialized symbol 'size' warning
      zonefs: Fix error message in zonefs_file_dio_append()

Dan Carpenter (3):
      firmware: arm_scmi: Clean up a return statement in scmi_probe
      firmware: arm_scmi: Return a literal instead of a variable
      net/mlx5: E-Switch, Fix an Oops in error handling code

Daniel Borkmann (1):
      bpf: Adjust insufficient default bpf_jit_limit

Daniel Scally (1):
      docs: usb: Add documentation for the UVC Gadget

Daniil Tatianin (1):
      qed/qed_sriov: guard against NULL derefs from qed_iov_get_vf_info

Darrick J. Wong (7):
      xfs: try to idiot-proof the allocators
      xfs: walk all AGs if TRYLOCK passed to xfs_alloc_vextent_iterate_ags
      xfs: add tracepoints for each of the externally visible allocators
      xfs: test dir/attr hash when loading module
      xfs: pass the correct cursor to xfs_iomap_prealloc_size
      xfs: clear incore AGFL_RESET state if it's not needed
      xfs: fix mismerged tracepoints

Dave Chinner (4):
      cpumask: introduce for_each_cpu_or
      pcpcntrs: fix dying cpu summation race
      fork: remove use of percpu_counter_sum_all
      pcpcntr: remove percpu_counter_sum_all()

Dave Wysochanski (1):
      NFS: Fix /proc/PID/io read_bytes for buffered reads

David Howells (1):
      keys: Do not cache key in task struct if key is requested from
kernel thread

Denis Arefev (1):
      power: supply: axp288_fuel_gauge: Added check for negative values

Donald Hunter (1):
      tools: ynl: Fix genlmsg header encoding formats

Dylan Jhong (1):
      riscv: mm: Fix incorrect ASID argument when flushing TLB

Eduard Zingerman (2):
      bpf: Allow reads from uninit stack
      selftests/bpf: Tests for uninitialized stack reads

Emeel Hakim (1):
      net/mlx5e: Overcome slow response for first macsec ASO WQE

Enric Balletbo i Serra (1):
      mailmap: add entry for Enric Balletbo i Serra

Eric Biggers (4):
      fscrypt: destroy keyring after security_sb_delete()
      fsverity: don't drop pagecache at end of FS_IOC_ENABLE_VERITY
      fscrypt: improve fscrypt_destroy_keyring() documentation
      fscrypt: check for NULL keyring in fscrypt_put_master_key_activeref()

Eric Dumazet (1):
      erspan: do not use skb_mac_header() in ndo_start_xmit()

Fabrice Gasnier (2):
      usb: dwc2: fix a devres leak in hw_enable upon suspend resume
      usb: dwc2: fix a race, don't power off/on phy for dual-role mode

Felix Fietkau (3):
      wifi: mt76: mt7915: add back 160MHz channel width support for MT7915
      wifi: mac80211: fix qos on mesh interfaces
      wifi: mac80211: fix mesh path discovery based on unicast packets

Florian Fainelli (2):
      net: phy: Ensure state transitions are processed from phy_stop()
      net: mdio: fix owner field for mdio buses registered using ACPI

Frank Crawford (1):
      hwmon (it87): Fix voltage scaling for chips with 10.9mV  ADCs

Frederic Weisbecker (1):
      entry/rcu: Check TIF_RESCHED _after_ delayed RCU wake-up

Gaosheng Cui (1):
      intel/igbvf: free irq on the error path in igbvf_request_msix()

Gavin Li (2):
      net/mlx5e: Set uplink rep as NETNS_LOCAL
      net/mlx5e: Block entering switchdev mode with ns inconsistency

Geert Uytterhoeven (2):
      mm/slab: Fix undefined init_cache_node_node() for NUMA and !SMP
      lib: dhry: fix unstable smp_processor_id(_) usage

Geoff Levand (2):
      net/ps3_gelic_net: Fix RX sk_buff length
      net/ps3_gelic_net: Use dma_mapping_error

Gil Fine (2):
      thunderbolt: Add missing UNSET_INBOUND_SBTX for retimer access
      thunderbolt: Limit USB3 bandwidth of certain Intel USB4 host routers

Grant Grundler (2):
      power: supply: cros_usbpd: reclassify "default case!" as debug
      net: asix: fix modprobe "sysfs: cannot create duplicate filename"

Grygorii Strashko (1):
      net: ethernet: ti: am65-cpts: reset pps genf adj settings on enable

Hans de Goede (7):
      usb: ucsi: Fix NULL pointer deref in ucsi_connector_change()
      usb: ucsi: Fix ucsi->connector race
      usb: ucsi_acpi: Increase the command completion timeout
      efi: sysfb_efi: Fix DMI quirks not working for simpledrm
      efi: sysfb_efi: Add quirk for Lenovo Yoga Book X91F/L
      ACPI: video: Add backlight=3Dnative DMI quirk for Acer Aspire 3830TG
      drm: panel-orientation-quirks: Add quirk for Lenovo Yoga Book X90F

Hersen Wu (2):
      drm/amd/display: fix wrong index used in dccg32_set_dpstreamclk
      drm/amd/display: Set dcn32 caps.seamless_odm

Hongren Zheng (1):
      MAINTAINERS: make me a reviewer of USB/IP

Howard Chung (1):
      Bluetooth: mgmt: Fix MGMT add advmon with RSSI command

Ido Schimmel (3):
      mlxsw: core_thermal: Fix fan speed in maximum cooling state
      mlxsw: spectrum_fid: Fix incorrect local port type
      thermal: core: Restore behavior regarding invalid trip points

Ivan Bornyakov (1):
      bus: imx-weim: fix branch condition evaluates to a garbage value

Iwona Winiarska (1):
      hwmon: (peci/cputemp) Fix miscalculated DTS for SKX

Jan Beulich (1):
      x86/PVH: avoid 32-bit build warning when obtaining VGA console info

Jane Jian (1):
      drm/amdgpu/gfx: set cg flags to enter/exit safe mode

Jeff Layton (2):
      lockd: set file_lock start and end when decoding nlm4 testargs
      nfsd: don't replace page in rq_pages if it's a continuation of last p=
age

Jens Axboe (2):
      block/io_uring: pass in issue_flags for uring_cmd task_work handling
      io_uring/net: avoid sending -ECONNABORTED on repeated connection requ=
ests

Jesper Dangaard Brouer (1):
      xdp: bpf_xdp_metadata use EOPNOTSUPP for no driver support

Jesus Sanchez-Palencia (1):
      libbpf: Revert poisoning of strlcpy

Jianhua Lu (1):
      arm64: dts: qcom: sm8250-xiaomi-elish: Correct venus firmware path

Jiapeng Chong (1):
      power: supply: rk817: Fix unsigned comparison with less than zero

Jiasheng Jiang (2):
      dm stats: check for and propagate alloc_percpu failure
      octeontx2-vf: Add missing free for alloc_percpu

Jochen Henneberg (1):
      net: stmmac: Fix for mismatched host/device DMA address width

Joel Selvaraj (1):
      scsi: core: Add BLIST_SKIP_VPD_PAGES for SKhynix H28U74301AMR

Joey Gouly (2):
      mm: deduplicate error handling for map_deny_write_exec
      mm: fix error handling for map_deny_write_exec

Johan Hovold (6):
      firmware: qcom: scm: fix bogus irq error at probe
      arm64: dts: qcom: sc8280xp-x13s: mark s11b regulator as always-on
      arm64: dts: qcom: sc8280xp-x13s: mark s10b regulator as always-on
      arm64: dts: qcom: sc8280xp-x13s: mark s12b regulator as always-on
      arm64: dts: qcom: sc8280xp-x13s: mark bob regulator as always-on
      drm/meson: fix missing component unbind on bind errors

Johannes Berg (2):
      wifi: iwlwifi: mvm: fix mvmtxq->stopped handling
      wifi: iwlwifi: mvm: protect TXQ list manipulation

John Harrison (1):
      drm/i915/guc: Fix missing ecodes

Josef Bacik (2):
      btrfs: rename BTRFS_FS_NO_OVERCOMMIT to BTRFS_FS_ACTIVE_ZONE_TRACKING
      btrfs: use temporary variable for space_info in btrfs_update_block_gr=
oup

Josh Poimboeuf (1):
      entry: Fix noinstr warning in __enter_from_user_mode()

Joshua Washington (1):
      gve: Cache link_speed value from device

Kai-Heng Feng (1):
      drm/amdgpu/nv: Apply ASPM quirk on Intel ADL + AMD Navi

Kal Conley (1):
      xsk: Add missing overflow check in xdp_umem_reg

Kiran K (2):
      Bluetooth: btintel: Iterate only bluetooth device ACPI entries
      Bluetooth: btinel: Check ACPI handle for NULL before accessing

Konrad Dybcio (5):
      arm64: dts: qcom: sm6115: Un-enable SPI5 by default
      arm64: dts: qcom: sm6375: Add missing power-domain-named to CDSP
      arm64: dts: qcom: sm8550: Use correct CPU compatibles
      mailmap: map Rajendra Nayak's old address to his current one
      mailmap: map Sai Prakash Ranjan's old address to his current one

Krishna chaitanya chundru (1):
      arm64: dts: qcom: sc7280: Mark PCIe controller as cache coherent

Krzysztof Kozlowski (4):
      arm64: dts: qcom: sm8450: correct WSA2 assigned clocks
      arm64: dts: qcom: sm8550: fix LPASS pinctrl slew base address
      arm64: dts: imx8mm-nitrogen-r2: fix WM8960 clock name
      wifi: mwifiex: mark OF related data as maybe unused

Lama Kayal (1):
      net/mlx5: Fix steering rules cleanup

Li Zetao (1):
      atm: idt77252: fix kmemleak when rmmod idt77252

Liam R. Howlett (3):
      maple_tree: fix mas_skip_node() end slot detection
      test_maple_tree: add more testing for mas_empty_area()
      mm/ksm: fix race with VMA iteration and mm_struct teardown

Liang He (1):
      net: mdio: thunder: Add missing fwnode_handle_put()

Lin Ma (1):
      igb: revert rtnl_lock() that causes deadlock

Linus Torvalds (1):
      Linux 6.3-rc4

Lorenzo Bianconi (2):
      wifi: mt76: do not run mt76_unregister_device() on unregistered hw
      wifi: mt76: connac: do not check WED status for non-mmio devices

Luca Weiss (3):
      soc: qcom: rmtfs: fix error handling reading qcom,vmid
      soc: qcom: rmtfs: handle optional qcom,vmid correctly
      ARM: dts: qcom: apq8026-lg-lenok: add missing reserved memory

Luiz Augusto von Dentz (3):
      Bluetooth: hci_core: Detect if an ACL packet is in fact an ISO packet
      Bluetooth: btusb: Remove detection of ISO packets over bulk
      Bluetooth: L2CAP: Fix responding with wrong PDU type

Maher Sanalla (1):
      net/mlx5: Read the TC mapping of all priorities on ETS query

Manivannan Sadhasivam (5):
      arm64: dts: qcom: sm8150: Fix the iommu mask used for PCIe controller=
s
      arm64: dts: qcom: sc8280xp: Add label property to vadc channel nodes
      arm64: dts: qcom: sm8350: Mark UFS controller as cache coherent
      arm64: dts: qcom: sm8450: Mark UFS controller as cache coherent
      arm64: dts: qcom: sm8550: Mark UFS controller as cache coherent

Marco Elver (3):
      kasan, powerpc: don't rename memintrinsics if compiler adds prefixes
      kfence: avoid passing -g for test
      kcsan: avoid passing -g for test

Marek Vasut (2):
      arm64: dts: imx8mp: Fix LCDIF2 node clock order
      arm64: dts: imx8mn: specify #sound-dai-cells for SAI nodes

Mario Limonciello (2):
      thunderbolt: Use const qualifier for `ring_interrupt_index`
      thunderbolt: Disable interrupt auto clear for rings

Martin George (1):
      nvme: send Identify with CNS 06h only to I/O controllers

Masami Hiramatsu (Google) (2):
      bootconfig: Fix testcase to increase max node
      bootconfig: Change message if no bootconfig with
CONFIG_BOOT_CONFIG_FORCE=3Dy

Matheus Castello (1):
      drm/bridge: lt8912b: return EPROBE_DEFER if bridge is not found

Matthias Schiffer (1):
      i2c: mxs: ensure that DMA buffers are safe for DMA

Maxime Bizon (1):
      net: mdio: fix owner field for mdio buses registered using device-tre=
e

Michael Walle (1):
      Revert "arm64: dts: ls1028a: sl28: get MAC addresses from VPD"

Michal Hocko (1):
      mm, vmalloc: fix high order __GFP_NOFAIL allocations

Michal Koutn=C3=BD (1):
      x86/mm: Do not shuffle CPU entry areas without KASLR

Michal Swiatkowski (2):
      ice: check if VF exists before mode check
      ice: remove filters only if VSI is deleted

Mika Westerberg (3):
      thunderbolt: Fix memory leak in margining
      thunderbolt: Call tb_check_quirks() after initializing adapters
      thunderbolt: Use scale field when allocating USB3 bandwidth

Mike Snitzer (1):
      dm crypt: avoid accessing uninitialized tasklet

Mikulas Patocka (1):
      dm crypt: add cond_resched() to dmcrypt_write()

Min Li (1):
      Bluetooth: Fix race condition in hci_cmd_sync_clear

Ming Lei (1):
      block: ublk_drv: mark device as LIVE before adding disk

Minwoo Im (1):
      mm: mmap: remove newline at the end of the trace

Muchun Song (1):
      mm: kfence: fix using kfence_metadata without initialization in
show_object()

Namjae Jeon (7):
      ksmbd: fix wrong signingkey creation when encryption is AES256
      ksmbd: set FILE_NAMED_STREAMS attribute in FS_ATTRIBUTE_INFORMATION
      ksmbd: add low bound validation to FSCTL_SET_ZERO_DATA
      ksmbd: add low bound validation to FSCTL_QUERY_ALLOCATED_RANGES
      ksmbd: don't terminate inactive sessions after a few seconds
      ksmbd: return STATUS_NOT_SUPPORTED on unsupported smb2.0 dialect
      ksmbd: return unsupported error on smb1 mount

Naohiro Aota (3):
      btrfs: zoned: fix btrfs_can_activate_zone() to support DUP profile
      btrfs: zoned: count fresh BG region as zone unusable
      btrfs: zoned: drop space_info->active_total_bytes

Nathan Chancellor (1):
      riscv: Handle zicsr/zifencei issues between clang and binutils

Nathan Huckleberry (1):
      fsverity: Remove WQ_UNBOUND from fsverity read workqueue

Nilesh Javali (1):
      scsi: qla2xxx: Perform lockless command completion in abort path

Nirmoy Das (1):
      drm/i915/active: Fix missing debug object activation

Pauli Virtanen (1):
      Bluetooth: ISO: fix timestamped HCI ISO data packet parsing

Paulo Alcantara (2):
      cifs: fix missing unload_nls() in smb2_reconnect()
      cifs: fix dentry lookups in directory handle cache

Pawel Laszczak (3):
      usb: cdnsp: Fixes issue with redundant Status Stage
      usb: cdns3: Fix issue with using incorrect PCI device function
      usb: cdnsp: changes PCI Device ID to fix conflict with CNDS3 driver

Peng Fan (3):
      ARM: dts: imx6sll: e70k02: fix usbotg1 pinctrl
      ARM: dts: imx6sll: e60k02: fix usbotg1 pinctrl
      ARM: dts: imx6sl: tolino-shine2hd: fix usbotg1 pinctrl

Peter Collingbourne (1):
      Revert "kasan: drop skip_kasan_poison variable in free_pages_prepare"

Peter Xu (1):
      kselftest: vm: fix unused variable warning

Phinex Hung (1):
      hwmon: fix potential sensor registration fail if of_node is missing

Piotr Raczynski (1):
      ice: fix rx buffers handling for flow director packets

Qu Wenruo (1):
      btrfs: handle missing chunk mapping more gracefully

Quinn Tran (1):
      scsi: qla2xxx: Synchronize the IOCB count to be in order

Radhakrishna Sripada (1):
      drm/i915/mtl: Fix Wa_16015201720 implementation

Radoslaw Tyl (1):
      i40e: fix flow director packet filter programming

Rafael J. Wysocki (4):
      ACPI: processor: Reorder acpi_processor_driver_init()
      thermal: core: Introduce thermal_cooling_device_present()
      thermal: core: Introduce thermal_cooling_device_update()
      ACPI: processor: thermal: Update CPU cooling devices on cpufreq
policy changes

Richard Leitner (1):
      mailmap: add entries for Richard Leitner

Rijo Thomas (1):
      tee: amdtee: fix race condition in amdtee_open_session

Robbie Harwood (2):
      verify_pefile: relax wrapper length check
      asymmetric_keys: log on fatal failures in PE/pkcs7

Roger Pau Monne (1):
      hvc/xen: prevent concurrent accesses to the shared ring

Roy Novich (1):
      net/mlx5e: Initialize link speed to zero

Russell King (Oracle) (1):
      net: sfp: fix state loss when updating state_hw_mask

Ryusuke Konishi (1):
      nilfs2: fix kernel-infoleak in nilfs_ioctl_wrap_copy()

Sanjay R Mehta (1):
      thunderbolt: Add quirk to disable CLx

Savino Dicanosa (1):
      io_uring/rsrc: fix null-ptr-deref in io_file_bitmap_get()

Shyam Prasad N (8):
      cifs: check only tcon status on tcon related functions
      cifs: lock chan_lock outside match_session
      cifs: do not poll server interfaces too regularly
      cifs: empty interface list when server doesn't support query interfac=
es
      cifs: dump pending mids for all channels in DebugData
      cifs: print session id while listing open files
      cifs: append path to open_enter trace event
      cifs: avoid race conditions with parallel reconnects

Srinivas Kandagatla (4):
      arm64: dts: qcom: sc8280xp: fix rx frame shapping info
      arm64: dts: qcom: sc8280xp: fix lpass tx macro clocks
      arm64: dts: qcom: sc8280xp-x13s: fix dmic sample rate
      arm64: dts: qcom: sc8280xp-x13s: fix va dmic dai links and routing

Stefan Assmann (1):
      iavf: fix hang on reboot with ice

Stephan Gerhold (1):
      Bluetooth: btqcomsmd: Fix command timeout after setting BD address

Steve French (2):
      smb3: lower default deferred close timeout to address perf regression
      smb3: fix unusable share after force unmount failure

Sungwoo Kim (1):
      Bluetooth: HCI: Fix global-out-of-bounds

Sweet Tea Dorminy (1):
      btrfs: fix compiler warning on SPARC/PA-RISC handling
fscrypt_setup_filename

Szymon Heidrich (2):
      net: usb: smsc95xx: Limit packet length to skb->len
      net: usb: lan78xx: Limit packet length to skb->len

Tejas Upadhyay (1):
      drm/i915/fbdev: lock the fbdev obj before vma pin

Thierry Reding (1):
      arm64: tegra: Bump CBB ranges property on Tegra194 and Tegra234

Tianyi Jing (1):
      hwmon: (xgene) Fix ioremap and memremap leak

Tiezhu Yang (1):
      checksyscalls: ignore fstat to silence build warning on LoongArch

Tim Huang (2):
      drm/amdgpu: reposition the gpu reset checking for reuse
      drm/amdgpu: skip ASIC reset for APUs when go to S4

Tobias Klauser (1):
      mailmap: add entry for Tobias Klauser

Tom Rix (2):
      usb: plusb: remove unused pl_clear_QuickLink_features function
      thunderbolt: Rename shadowed variables bit to interrupt_bit and
auto_clear_bit

Tong Liu01 (1):
      drm/amdgpu: add mes resume when do gfx post soft reset

Tzung-Bi Shih (1):
      platform/chrome: cros_ec_chardev: fix kernel data leak from ioctl

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915: Preserve crtc_state->inherited during state clearing
      drm/i915: Update vblank timestamping stuff on seamless M/N change

Vinay Belgaumkar (1):
      drm/i915: Fix format for perf_limit_reasons

Vincent Guittot (1):
      sched/fair: Sanitize vruntime of entity being migrated

Vincenzo Palazzo (1):
      usb: dwc3: Fix a typo in field name

Vladimir Oltean (5):
      net: dsa: report rx_bytes unadjusted for ETH_HLEN
      net: mscc: ocelot: fix stats region batching
      net: mscc: ocelot: fix transfer from region->buf to ocelot->stats
      net: mscc: ocelot: add TX_MM_HOLD to ocelot_mm_stats_layout
      net: enetc: fix aggregate RMON counters not showing the ranges

Wei Chen (1):
      i2c: xgene-slimpro: Fix out-of-bounds bug in xgene_slimpro_i2c_xfer()

Wesley Cheng (1):
      usb: dwc3: gadget: Add 1ms delay after end transfer command without I=
OC

Xu Yang (4):
      usb: typec: tcpm: fix create duplicate source-capabilities file
      usb: typec: tcpm: fix warning when handle discover_identity message
      usb: chipdea: core: fix return -EINVAL if request role is the
same with current role
      usb: chipidea: core: fix possible concurrent when switch role

Yang Xiwen (1):
      arm64: dts: qcom: msm8916-ufi: Fix sim card selection pinctrl

Yaroslav Furman (1):
      uas: Add US_FL_NO_REPORT_OPCODES for JMicron JMS583Gen 2

Ye Xingchen (1):
      firmware: arm_scmi: Remove duplicate include header inclusion

Yicong Yang (2):
      i2c: hisi: Avoid redundant interrupts
      i2c: hisi: Only use the completion interrupt to finish the transfer

Yishai Hadas (1):
      vfio/mlx5: Fix the report of dirty_bytes upon pre-copy

Yu Kuai (1):
      scsi: scsi_dh_alua: Fix memleak for 'qdata' in alua_activate()

YuBiao Wang (1):
      drm/amdgpu: Force signal hw_fences that are embedded in non-sched job=
s

Zhang Changzhong (1):
      net/sonic: use dma_mapping_error() for error check

Zheng Wang (5):
      power: supply: bq24190: Fix use after free bug in bq24190_remove
due to race condition
      power: supply: da9150: Fix use after free bug in
da9150_charger_remove due to race condition
      xirc2ps_cs: Fix use after free bug in xirc2ps_detach
      net: qcom/emac: Fix use after free bug in emac_remove due to
race condition
      Bluetooth: btsdio: fix use after free bug in btsdio_remove due
to unfinished work

Zhengping Jiang (1):
      Bluetooth: hci_sync: Resume adv with no RPA when active scan

Ziyang Huang (1):
      usb: dwc2: drd: fix inconsistent mode if role-switch-default-mode=3D"=
host"

=C3=81lvaro Fern=C3=A1ndez Rojas (2):
      net: dsa: b53: mmap: fix device tree support
      net: dsa: tag_brcm: legacy: fix daisy-chained switches
