Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0054168B1F5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 22:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjBEVc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 16:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBEVcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 16:32:55 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C3F76A3
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 13:32:51 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id hx15so29096547ejc.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 13:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ci+L+5IDeRiL/Rz7Ap9x6UL8BIQIOVVJxJrNT2IAaKg=;
        b=ga8wejeCfScYwjSctk4xDOG3Q26cK5uMN1+qry2VAbOuWn5SVTjb6BEKHSDQBLfaJc
         x7iU6Qfs5coxQQd6SWZa9Mc9IzomQ1/uNT58jSaX60TQKbZ1LjJ/S/bP76qenYZ7IqHl
         6d3PfnSOSOK+DLsSGJPOpH86tlf/VUpTEk/vQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ci+L+5IDeRiL/Rz7Ap9x6UL8BIQIOVVJxJrNT2IAaKg=;
        b=qVJxL8bvQsaMu+zRAci+FpioOqsOfLx3Dye2/U1FBQ1zkQuJlwPcb1T/gP1eUY+/RV
         X+Eh78t76HzZwTBKNed7ga0WQCvKxTrvFIGcFfjs0tGA3Hn15ewZAxPZlzqlkCR8VkE6
         0L6jmnUwIIbT6JoGRozamCq3UJ76k9IOWK7X0nm6E42FqE/Xf1Pc19Bqw54fMXKn3J96
         d5pVc/VRztcZ8MJ37Hxjla80CCP1sj/K2VCw3KwptDL/3x7rmIJuZF1mmtNvW88OU/8d
         mwrrnjTjzIy0Y6MrMr7s6n2viSUoZtxC40xnX1HeA1PwGtciqBJVeg0JMaX0P6+0YV5G
         /OXQ==
X-Gm-Message-State: AO0yUKUk2A38Pw+cm5xp7Ch1mWXf9DXkgM/HUBIsV598+8X/1NQAGPka
        Sy+hDGnXI3G0+UhCZyJxkEbN3D5TqUZ8V0tRRdQ=
X-Google-Smtp-Source: AK7set9nqARYW7/hD5t311q5kaj917pdEskAL7olUnD97R+3y3Zrh0UJknGck6l9xeTlQog8oU8Bnw==
X-Received: by 2002:a17:906:1810:b0:885:5682:7e52 with SMTP id v16-20020a170906181000b0088556827e52mr16451051eje.13.1675632768953;
        Sun, 05 Feb 2023 13:32:48 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906701300b00888f92f0708sm4652834ejj.15.2023.02.05.13.32.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Feb 2023 13:32:48 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id z11so9942311ede.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 13:32:48 -0800 (PST)
X-Received: by 2002:a50:d0da:0:b0:4aa:9bd9:d81b with SMTP id
 g26-20020a50d0da000000b004aa9bd9d81bmr1607629edf.70.1675632767842; Sun, 05
 Feb 2023 13:32:47 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Feb 2023 13:32:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=whSVeeQN9vO-WSxFkNs0zbUJEBqND-1VO8OJtmu_sn_nw@mail.gmail.com>
Message-ID: <CAHk-=whSVeeQN9vO-WSxFkNs0zbUJEBqND-1VO8OJtmu_sn_nw@mail.gmail.com>
Subject: Linux 6.2-rc7
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

So the 6.2 rc releases are continuing to be fairly small and
controlled, to the point where normally I'd just say that this is the
last rc. But since I've stated multiple times that I'll do an rc8 due
to the holiday start of the release, that's what I'll do. And we do
have a few regressions outstanding that Thorsten is tracking, so just
as well.

Nothing in here looks all that scary, and we just have smallish fixes
all over the tree, in all the usual places. I think the single biggest
patch is a race fix to zsmalloc, which I guess is fairly unusual, but
I think that's more indicative of everything else being pretty small.

We've got driver fixes (gpu, networking, sound, but a smattering of
other stuff too), some core mm stuff (that zsmalloc one dominating),
various selftest updates, and just random other things. The shortlog
below gives the details.

               Linus

---

Aaro Koskinen (1):
      usb: gadget: udc: do not clear gadget driver.bus

Ahmad Fatoum (1):
      MAINTAINERS: match freescale ARM64 DT directory in i.MX entry

Alex Deucher (1):
      drm/amd/display: Properly handle additional cases where DCN is
not supported

Alexander Couzens (2):
      net: mediatek: sgmii: ensure the SGMII PHY is powered down on
configuration
      mtk_sgmii: enable PCS polling to allow SFP work

Alexander Duyck (1):
      skb: Do mix page pool and page referenced frags in GRO

Alexander Egorenkov (2):
      watchdog: diag288_wdt: do not use stack buffers for hardware data
      watchdog: diag288_wdt: fix __diag288() inline assembly

Amadeusz S=C5=82awi=C5=84ski (1):
      ASoC: Intel: avs: Implement PCI shutdown

Amit Engel (1):
      nvme-fc: fix a missing queue put in nvmet_fc_ls_create_association

Andre Kalb (1):
      net: phy: dp83822: Fix null pointer access on DP83825/DP83826 devices

Andreas Kemnade (2):
      iio:adc:twl6030: Enable measurements of VUSB, VBAT and others
      iio:adc:twl6030: Enable measurement of VAC

Andreas Schwab (1):
      riscv: disable generation of unwind tables

Andrei Gherzan (5):
      selftest: net: Improve IPV6_TCLASS/IPV6_HOPLIMIT tests apparmor
compatibility
      selftests: net: udpgso_bench_rx: Fix 'used uninitialized' compiler wa=
rning
      selftests: net: udpgso_bench_rx/tx: Stop when wrong CLI args are prov=
ided
      selftests: net: udpgso_bench: Fix racing bug between the rx/tx progra=
ms
      selftests: net: udpgso_bench_tx: Cater for pending datagrams
zerocopy benchmarking

Andrey Konovalov (1):
      net: stmmac: do not stop RX_CLK in Rx LPI state for qcs404 SoC

Andy Shevchenko (6):
      ASoC: amd: acp-es8336: Drop reference count of ACPI device after use
      ASoC: Intel: bytcht_es8316: Drop reference count of ACPI device after=
 use
      ASoC: Intel: bytcr_rt5651: Drop reference count of ACPI device after =
use
      ASoC: Intel: bytcr_rt5640: Drop reference count of ACPI device after =
use
      ASoC: Intel: bytcr_wm5102: Drop reference count of ACPI device after =
use
      ASoC: Intel: sof_es8336: Drop reference count of ACPI device after us=
e

Anton Gusev (1):
      efi: fix potential NULL deref in efi_mem_reserve_persistent

Ard Biesheuvel (1):
      efi: Accept version 2 of memory attributes table

Arnd Bergmann (4):
      kunit: Export kunit_running()
      rtc: sunplus: fix format string for printing resource
      ASoC: cs42l56: fix DT probe
      platform/x86/amd: pmc: add CONFIG_SERIO dependency

Artemii Karasev (1):
      ALSA: hda/via: Avoid potential array out-of-bound in add_secret_dac_p=
ath()

Ar=C4=B1n=C3=A7 =C3=9CNAL (2):
      net: dsa: mt7530: fix tristate and help description
      net: ethernet: mtk_eth_soc: disable hardware DSA untagging for second=
 MAC

Bard Liao (3):
      ASoC: SOF: sof-audio: start with the right widget type
      ASoC: SOF: sof-audio: unprepare when swidget->use_count > 0
      ASoC: SOF: keep prepare/unprepare widgets in sink path

Bart Van Assche (2):
      scsi: core: Fix the scsi_device_put() might_sleep annotation
      block: Fix the blk_mq_destroy_queue() documentation

Ben Skeggs (3):
      drm/nouveau/devinit/tu102-: wait for GFW_BOOT_PROGRESS =3D=3D COMPLET=
ED
      drm/nouveau/fb/tu102-: fix register used to determine scrub status
      drm/nouveau/acr/gm20b: regression fixes

Bj=C3=B8rn Mork (1):
      net: mediatek: sgmii: fix duplex configuration

Brendan Higgins (1):
      kunit: fix kunit_test_init_section_suites(...)

Carlos Song (9):
      iio: imu: fxos8700: fix map label of channel type to MAGN sensor
      iio: imu: fxos8700: fix swapped ACCEL and MAGN channels readback
      iio: imu: fxos8700: fix incomplete ACCEL and MAGN channels readback
      iio: imu: fxos8700: fix IMU data bits returned to user space
      iio: imu: fxos8700: fix ACCEL measurement range selection
      iio: imu: fxos8700: fix incorrect ODR mode readback
      iio: imu: fxos8700: fix failed initialization ODR mode assignment
      iio: imu: fxos8700: remove definition FXOS8700_CTRL_ODR_MIN
      iio: imu: fxos8700: fix MAGN sensor scale and unit

Cezary Rojewski (1):
      ALSA: hda: Do not unset preset when cleaning up codec

Chaitanya Kumar Borah (1):
      drm/i915/adlp: Fix typo for reference clock

Chris Healy (1):
      net: phy: meson-gxl: Add generic dummy stubs for MMD register access

Christophe JAILLET (1):
      fbdev: omapfb: Use kstrtobool() instead of strtobool()

Colin Foster (1):
      net: phy: fix null dereference in phy_attach_direct

Damien Le Moal (1):
      ata: libata: Fix sata_down_spd_limit() when no link speed is reported

Dan Carpenter (1):
      ASoC: SOF: ipc4-mtrace: prevent underflow in
sof_ipc4_priority_mask_dfs_write()

Daniel Miess (2):
      drm/amd/display: Add missing brackets in calculation
      drm/amd/display: Adjust downscaling limits for dcn314

Daniel Scally (1):
      MAINTAINERS: Add myself as UVC Gadget Maintainer

Danilo Krummrich (1):
      dma-buf: actually set signaling bit for private stub fences

Dave Ertman (1):
      ice: Prevent set_channel from changing queues while RDMA active

Dmitry Perchanov (2):
      iio: hid: fix the retval in accel_3d_capture_sample
      iio: hid: fix the retval in gyro_3d_capture_sample

Eddie James (1):
      ARM: dts: aspeed: Fix pca9849 compatible

Eduard Zingerman (2):
      bpf: Fix to preserve reg parent/live fields when copying range info
      selftests/bpf: Verify copy_register_state() preserves parent/live fie=
lds

Eric Auger (1):
      vhost/net: Clear the pending messages when the backend is removed

Eugen Hristev (1):
      .mailmap: update e-mail address for Eugen Hristev

Evan Quan (1):
      drm/amdgpu: enable HDP SD for gfx 11.0.3

Fabio Estevam (2):
      arm64: dts: imx8m-venice: Remove incorrect 'uart-has-rtscts'
      ARM: dts: imx7d-smegw01: Fix USB host over-current polarity

Fedor Pchelkin (2):
      squashfs: harden sanity check in squashfs_read_xattr_id_table
      net: openvswitch: fix flow memory leak in ovs_flow_cmd_new

Florian Westphal (2):
      netfilter: br_netfilter: disable sabotage_in hook after first suppres=
sion
      Revert "netfilter: conntrack: fix bug in for_each_sctp_chunk"

Frank Li (2):
      iio: imx8qxp-adc: fix irq flood when call imx8qxp_adc_read_raw()
      arm64: dts: freescale: imx8dxl: fix sc_pwrkey's property name
linux,keycode

Gavin Shan (3):
      KVM: arm64: Add helper vgic_write_guest_lock()
      KVM: arm64: Allow no running vcpu on restoring vgic3 LPI pending stat=
us
      KVM: arm64: Allow no running vcpu on saving vgic3 pending table

George Kennedy (1):
      vc_screen: move load of struct vc_data pointer in vcs_read() to avoid=
 UAF

George Shen (1):
      drm/amd/display: Unassign does_plane_fit_in_mall function from dcn3.2

Graham Sider (1):
      drm/amdgpu: update wave data type to 3 for gfx11

Greg Kroah-Hartman (2):
      HV: hv_balloon: fix memory leak with using debugfs_lookup()
      kernel/irq/irqdomain.c: fix memory leak with using debugfs_lookup()

Guo Ren (1):
      riscv: kprobe: Fixup kernel panic when probing an illegal position

Hans Verkuil (3):
      media: v4l2-ctrls-api.c: move ctrl->is_new =3D 1 to the correct line
      media: videobuf2: set q->streaming later
      drm/vc4: hdmi: make CEC adapter name unique

Hans de Goede (3):
      platform/x86/amd/pmf: Ensure mutexes are initialized before use
      platform/x86: thinkpad_acpi: Fix thinklight LED brightness returning =
255
      platform/x86: touchscreen_dmi: Add Chuwi Vi8 (CWI501) DMI match

Heikki Krogerus (1):
      usb: typec: ucsi: Don't attempt to resume the ports before they exist

Helge Deller (3):
      parisc: Fix return code of pdc_iodc_print()
      parisc: Replace hardcoded value with PRIV_USER constant in ptrace.c
      parisc: Wire up PTRACE_GETREGS/PTRACE_SETREGS for compat case

Hou Tao (3):
      bpf: Fix off-by-one error in bpf_mem_cache_idx()
      fscache: Use wait_on_bit() to wait for the freeing of relinquished vo=
lume
      fscache: Use clear_and_wake_up_bit() in fscache_create_volume_work()

Hyunwoo Kim (2):
      net/rose: Fix to not accept on connected socket
      netrom: Fix use-after-free caused by accept on already connected sock=
et

Ilpo J=C3=A4rvinen (3):
      fpga: m10bmc-sec: Fix probe rollback
      serial: 8250_dma: Fix DMA Rx completion race
      serial: 8250_dma: Fix DMA Rx rearm race

Isaac J. Manjarres (1):
      Revert "mm: kmemleak: alloc gray object for reserved region with
direct map"

Jakub Kicinski (4):
      MAINTAINERS: bonding: move Veaceslav Falico to CREDITS
      mailmap: add John Crispin's entry
      MAINTAINERS: ipv6: retire Hideaki Yoshifuji
      MAINTAINERS: update SCTP maintainers

Jakub Sitnicki (4):
      bpf, sockmap: Don't let sock_map_{close,destroy,unhash} call itself
      bpf, sockmap: Check for any of tcp_bpf_prots when cloning a listener
      selftests/bpf: Pass BPF skeleton to sockmap_listen ops tests
      selftests/bpf: Cover listener cloning with progs attached to sockmap

James Clark (1):
      perf: Fix perf_event_pmu_context serialization

James Morse (1):
      ia64: fix build error due to switch case label appearing next to
declaration

Jan Luebbe (2):
      certs: Fix build error when PKCS#11 URI contains semicolon
      kbuild: modinst: Fix build error when CONFIG_MODULE_SIG_KEY is a
PKCS#11 URI

Jann Horn (1):
      mm/khugepaged: fix ->anon_vma race

Jason Wang (1):
      vhost-scsi: unbreak any layout for response

Javier Martinez Canillas (1):
      drm/ssd130x: Init display before the SSD130X_DISPLAY_ON command

Jeremy Kerr (1):
      net: mctp: purge receive queues on sk destruction

Jeremy Szu (1):
      ALSA: hda/realtek: fix mute/micmute LEDs, speaker don't work for
a HP platform

Jiasheng Jiang (1):
      nvmem: brcm_nvram: Add check for kzalloc

Jiri Olsa (1):
      bpf: Add missing btf_put to register_btf_id_dtor_kfuncs

Joerg Roedel (1):
      x86/debug: Fix stack recursion caused by wrongly ordered DR7 accesses

Johan Hovold (2):
      dt-bindings: rtc: qcom-pm8xxx: allow 'wakeup-source' property
      nvmem: qcom-spmi-sdam: fix module autoloading

John Harrison (3):
      drm/i915/guc: Fix locking when searching for a hung request
      drm/i915: Fix request ref counting during error capture & debugfs dum=
p
      drm/i915: Fix up locking around dumping requests lists

Jonathan Neusch=C3=A4fer (1):
      ARM: dts: wpcm450: Add nuvoton,shm =3D <&shm> to FIU node

Kai-Heng Feng (1):
      iio: light: cm32181: Fix PM support on system with 2 I2C resources

Kees Cook (2):
      net: ethernet: mtk_eth_soc: Avoid truncating allocation
      net: sched: sch: Bounds check priority

Kefeng Wang (1):
      mm: memcg: fix NULL pointer in mem_cgroup_track_foreign_dirty_slowpat=
h()

Kornel Dul=C4=99ba (2):
      net: wwan: t7xx: Fix Runtime PM resume sequence
      net: wwan: t7xx: Fix Runtime PM initialization

Krzysztof Kozlowski (2):
      ASoC: codecs: wsa883x: correct playback min/max rates
      MAINTAINERS: amd: drop inactive Brijesh Singh

Kui-Feng Lee (1):
      bpf: Fix the kernel crash caused by bpf_setsockopt().

Kuninori Morimoto (1):
      ASoC: hdmi-codec: zero clear HDMI pdata

Liam Howlett (1):
      maple_tree: fix mas_empty_area_rev() lower bound validation

Linus Torvalds (1):
      Linux 6.2-rc7

Liu Xiaodong (1):
      block: ublk: extending queue_size to fix overflow

Longlong Xia (1):
      mm/swapfile: add cond_resched() in get_swap_pages()

Magnus Karlsson (5):
      qede: execute xdp_do_flush() before napi_complete_done()
      lan966x: execute xdp_do_flush() before napi_complete_done()
      virtio-net: execute xdp_do_flush() before napi_complete_done()
      dpaa_eth: execute xdp_do_flush() before napi_complete_done()
      dpaa2-eth: execute xdp_do_flush() before napi_complete_done()

Marc Kleine-Budde (1):
      can: mcp251xfd: mcp251xfd_ring_set_ringparam(): assign missing
tx_obj_num_coalesce_irq

Marco Pagani (1):
      iio: adc: xilinx-ams: fix devm_krealloc() return value check

Marek Vasut (2):
      arm64: dts: imx8mm: Reinstate GPIO watchdog always-running
property on eDM SBC
      serial: stm32: Merge hard IRQ and threaded IRQ handling into
single IRQ handler

Mario Limonciello (1):
      drm/amd: Fix initialization for nbio 4.3.0

Martin K. Petersen (1):
      scsi: Revert "scsi: core: map PQ=3D1, PDT=3Dother values to
SCSI_SCAN_TARGET_PRESENT"

Matthew Wilcox (Oracle) (1):
      highmem: round down the address passed to kunmap_flush_on_unmap()

Matthias Brugger (1):
      MAINTAINERS: Update entry for MediaTek SoC support

Maurizio Lombardi (2):
      nvme: clear the request_queue pointers on failure in
nvme_alloc_admin_tag_set
      nvme: clear the request_queue pointers on failure in nvme_alloc_io_ta=
g_set

Michael Ellerman (5):
      powerpc/imc-pmu: Revert nest_init_lock to being a mutex
      powerpc/kexec_file: Fix division by zero in extra size estimation
      powerpc/64s/radix: Fix crash with unaligned relocated kernel
      powerpc/64s/radix: Fix RWX mapping with relocated kernel
      powerpc/64s: Reconnect tlb_flush() to hash__tlb_flush()

Michael Kelley (1):
      hv_netvsc: Fix missed pagebuf entries in netvsc_dma_map/unmap()

Michael Walle (2):
      nvmem: core: fix device node refcounting
      nvmem: core: fix cell removal on error

Michal Hocko (1):
      Revert "mm: add nodes=3D arg to memory.reclaim"

Michal Wilczynski (1):
      ice: Fix broken link in ice NAPI doc

Mike Kravetz (2):
      mm: hugetlb: proc: check for hugetlb shared PMD in /proc/PID/smaps
      migrate: hugetlb: check for hugetlb shared PMD in node migration

Ming Lei (1):
      blk-cgroup: don't update io stat for root cgroup

Miquel Raynal (1):
      mac802154: Fix possible double free upon parsing error

Natalia Petrova (1):
      net: qrtr: free memory on error path in radix_tree_insert()

Neil Armstrong (1):
      usb: dwc3: qcom: enable vbus override when in OTG dr-mode

Nhat Pham (1):
      zsmalloc: fix a race with deferred_handles storing

Nicholas Kazlauskas (1):
      drm/amd/display: Reset DMUB mailbox SW state after HW reset

Nicholas Piggin (2):
      powerpc/64s: Fix local irq disable when PMIs are disabled
      powerpc/64: Fix perf profiling asynchronous interrupt handlers

Oliver Hartkopp (3):
      can: raw: fix CAN FD frame transmissions over CAN XL devices
      can: isotp: handle wait_event_interruptible() return values
      can: isotp: split tx timer into transmission and timeout

Olivier Moysan (1):
      iio: adc: stm32-dfsdm: fill module aliases

Parav Pandit (1):
      virtio-net: Keep stop() to follow mirror sequence of open()

Pengfei Xu (1):
      selftests/filesystems: grant executable permission to run_fat_tests.s=
h

Peter Ujfalusi (1):
      ASoC: SOF: sof-audio: prepare_widgets: Check swidget for NULL on
sink failure

Peter Xu (3):
      mm/uffd: fix pte marker when fork() without fork event
      mm: fix a few rare cases of using swapin error pte marker
      selftests/vm: remove __USE_GNU in hugetlb-madvise.c

Philippe Schenker (1):
      arm64: dts: imx8mm-verdin: Do not power down eth-phy

Phillip Lougher (1):
      Squashfs: fix handling and sanity checking of xattr_ids count

Pierluigi Passaro (1):
      arm64: dts: imx8mm: Fix pad control for UART1_DTE_RX

Pierre-Louis Bossart (4):
      ASoC: Intel: sof_rt5682: always set dpcm_capture for amplifiers
      ASoC: Intel: sof_cs42l42: always set dpcm_capture for amplifiers
      ASoC: Intel: sof_nau8825: always set dpcm_capture for amplifiers
      ASoC: Intel: sof_ssp_amp: always set dpcm_capture for amplifiers

Pietro Borrello (1):
      net/tls: tls_is_tx_ready() checked list_entry

Pratham Pratap (1):
      usb: gadget: f_uac2: Fix incorrect increment of bNumEndpoints

Rae Moar (1):
      kunit: fix bug in KUNIT_EXPECT_MEMEQ

Randy Dunlap (2):
      fbdev: fbmon: fix function name in kernel-doc
      freevxfs: Kconfig: fix spelling

Ranjani Sridharan (1):
      ASoC: SOF: sof-audio: skip prepare/unprepare if swidget is NULL

Ratheesh Kannoth (1):
      octeontx2-af: Fix devlink unregister

Ricardo Koller (4):
      KVM: selftests: aarch64: Relax userfaultfd read vs. write checks
      KVM: selftests: aarch64: Do not default to dirty PTE pages on all S1P=
TWs
      KVM: selftests: aarch64: Fix check of dirty log PT write
      KVM: selftests: aarch64: Test read-only PT memory regions

Rob Clark (2):
      drm/i915: Avoid potential vm use-after-free
      drm/i915: Fix potential bit_17 double-free

Russell King (Oracle) (5):
      nvmem: core: initialise nvmem->id early
      nvmem: core: remove nvmem_config wp_gpio
      nvmem: core: fix cleanup after dev_set_name()
      nvmem: core: fix registration vs use race
      nvmem: core: fix return value

Samuel Holland (2):
      nvmem: sunxi_sid: Always use 32-bit MMIO reads
      riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy

Samuel Thibault (1):
      fbcon: Check font dimension limits

Sathvika Vasireddy (2):
      powerpc/85xx: Fix unannotated intra-function call warning
      powerpc/kvm: Fix unannotated intra-function call warning

Shanker Donthineni (1):
      rtc: efi: Enable SET/GET WAKEUP services as optional

Shin'ichiro Kawasaki (1):
      nvme-auth: use workqueue dedicated to authentication

Shunsuke Mie (1):
      tools/virtio: fix the vringh test for virtio ring changes

Shyam Sundar S K (5):
      platform/x86/amd/pmf: Add helper routine to update SPS thermals
      platform/x86/amd/pmf: Add helper routine to check pprof is balanced
      platform/x86/amd/pmf: update to auto-mode limits only after AMT event
      platform/x86/amd/pmf: Fix to update SPS default pprof thermals
      platform/x86/amd/pmf: Fix to update SPS thermals when power supply ch=
ange

Sourabh Jain (1):
      powerpc/kexec_file: Count hot-pluggable memory in FDT estimate

Stafford Horne (1):
      MAINTAINERS: Update OpenRISC mailing list

Stephen Boyd (1):
      drm/panel: boe-tv101wum-nl6: Ensure DSI writes succeed during disable

Stephen Kitt (8):
      fbdev: aty128fb: Use backlight helper
      fbdev: atyfb: Use backlight helper
      fbdev: radeon: Use backlight helper
      fbdev: mx3fb: Use backlight helper
      fbdev: nvidia: Use backlight helper
      fbdev: omapfb: panel-dsi-cm: Use backlight helper
      fbdev: riva: Use backlight helper
      fbdev: atmel_lcdfb: Rework backlight status updates

Syed Saba Kareem (1):
      ASoC: amd: yc: Add DMI support for new acer/emdoor platforms

Takashi Iwai (2):
      ALSA: usb-audio: Add FIXED_RATE quirk for JBL Quantum610 Wireless
      ALSA: memalloc: Workaround for Xen PV

Takashi Sakamoto (2):
      firewire: fix memory leak for payload of request subaction to
IEC 61883-1 FCP region
      ALSA: firewire-motu: fix unreleased lock warning in hwdep device

Tanmay Bhushan (1):
      vdpa: ifcvf: Do proper cleanup if IFCVF init fails

Thomas Winter (2):
      ip/ip6_gre: Fix changing addr gen mode not generating IPv6 link
local address
      ip/ip6_gre: Fix non-point-to-point tunnel not generating IPv6
link local address

Tim Huang (1):
      drm/amd/pm: drop unneeded dpm features disablement for SMU 13.0.4/11

Tom Rix (1):
      igc: return an error if the mac type is unknown in
igc_ptp_systim_to_hwtstamp()

Tom Saeger (1):
      sh: define RUNTIME_DISCARD_EXIT

Udipto Goswami (1):
      usb: gadget: f_fs: Fix unbalanced spinlock in __ffs_ep0_queue_wait

Vasily Gorbik (1):
      s390/decompressor: specify __decompress() buf len to avoid overflow

Victor Shyba (1):
      ALSA: hda/realtek: Add Acer Predator PH315-54

Vladimir Oltean (2):
      iio: imu: st_lsm6dsx: fix build when CONFIG_IIO_TRIGGERED_BUFFER=3Dm
      net: fman: memac: free mdio device if lynx_pcs_create() fails

Vlastimil Babka (1):
      mm, mremap: fix mremap() expanding for vma's with vm_ops->close()

Waiman Long (1):
      cgroup/cpuset: Fix wrong check in update_parent_subparts_cpumask()

Wei Yang (1):
      maple_tree: should get pivots boundary by type

Xin Long (1):
      sctp: do not check hb_timer.expires when resetting hb_timer

Xiongfeng Wang (1):
      iio: adc: berlin2-adc: Add missing of_node_put() in error path

Xiubo Li (2):
      ceph: move mount state enum to super.h
      ceph: blocklist the kclient when receiving corrupted snap trace

Xu Panda (1):
      parisc: pdc_stable: use strscpy() to instead of strncpy()

Yan Zhai (1):
      net: fix NULL pointer in skb_segment_list

Yanguo Li (1):
      nfp: flower: avoid taking mutex in atomic context

Yiqing Yao (1):
      drm/amdgpu: Enable vclk dclk node for gc11.0.3

Yonghong Song (1):
      bpf: Fix a possible task gone issue with
bpf_send_signal[_thread]() helpers

Yu Kuai (1):
      block, bfq: fix uaf for bfqq in bic_set_bfqq()

Yu Zhao (1):
      mm: multi-gen LRU: fix crash during cgroup migration

Yuan Can (1):
      bus: sunxi-rsb: Fix error handling in sunxi_rsb_init()

Zach O'Keefe (1):
      mm/MADV_COLLAPSE: catch !none !huge !bad pmd lookups

Zhaoyang Huang (1):
      mm: use stack_depot_early_init for kmemleak

Zheng Yongjun (1):
      fpga: stratix10-soc: Fix return value check in s10_ops_write_init()

Ziyang Xuan (1):
      can: j1939: fix errant WARN_ON_ONCE in j1939_session_deactivate

fengwk (1):
      ASoC: amd: yc: Add Xiaomi Redmi Book Pro 15 2022 into DMI table

ye xingchen (1):
      Kconfig.debug: fix the help description in SCHED_DEBUG

=C3=8D=C3=B1igo Huguet (1):
      sfc: correctly advertise tunneled IPv6 segmentation
