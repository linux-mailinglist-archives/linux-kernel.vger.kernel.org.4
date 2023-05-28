Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32CF71395E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 14:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjE1MCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 08:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1MCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 08:02:18 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF82DAF
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 05:02:15 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5149c51fd5bso389568a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 05:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685275334; x=1687867334;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uJtOoCM2ouJRwnvRLskilFQMl6xuJQO/0QKFQD8ct/I=;
        b=YRNC2/8Ljnt3NJVz6ypHd/r7IsmgGVk/PgXN/Ue7m6Ml6AbYR0lYlONYwtIM65vldl
         0V4vOhIRmml/bK7mIjnENm1hI1YwSHe4Nod8tDSjjGM0JX5P9LByBfrTBDvN4/AAoT/j
         p2Amseyuibi9sS14Nt611HUAqbV9sZLCRU0w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685275334; x=1687867334;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJtOoCM2ouJRwnvRLskilFQMl6xuJQO/0QKFQD8ct/I=;
        b=N6dYnyFt8Uon1WZpCfKRnn0Vn+IXYhFTNstNQlex42PcVgwHVqVbIFOftc/CGfoFHS
         4PBy/t2lLCfb70Dh5uuNVGeC3I/O4g6tD1ymy7UbFKwlStSMqTP+STa+JKO+XYE8Fcrc
         8mru+BKyNYJgo4W8KNETu6w0t80D245Yms6ZwXqm/s3QdMue2feFuOcqhdqSlwkWPPQO
         OYqYV/9ARqVd35YzmSiwyfRZeALhLaKc9HmmmMOwh//vUvumlN064hp2gpCXtJAWtAe0
         rPOe75snatiMcD8v6MhY5q64b732wScQaRGAYycszdxlIaH5x9nXT0MF7NzHlFGNdelI
         dhfg==
X-Gm-Message-State: AC+VfDw3ysDp04MEFIrTcdi2vTramVfikZmQQhKKKewEvmm5dPXKp6hB
        jHxByPWiJAEndzXuHw8W3iNpsn8iPBLLZNSeaez5u6ic
X-Google-Smtp-Source: ACHHUZ5LKup4f8SZrxFuKY/kjAEDEIr9bomPWYDdB96m9XtPgDlD8oNuLtWmf6mI9coVa4+fWcHNSg==
X-Received: by 2002:a17:907:8a22:b0:94a:5819:5a2b with SMTP id sc34-20020a1709078a2200b0094a58195a2bmr9961986ejc.33.1685275333433;
        Sun, 28 May 2023 05:02:13 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709062b4700b0096f6a131b9fsm4564725ejg.23.2023.05.28.05.02.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 May 2023 05:02:13 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-973bf581759so437443766b.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 05:02:12 -0700 (PDT)
X-Received: by 2002:a17:907:3f8f:b0:973:9c54:572c with SMTP id
 hr15-20020a1709073f8f00b009739c54572cmr9650714ejc.14.1685275332300; Sun, 28
 May 2023 05:02:12 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 May 2023 08:01:55 -0400
X-Gmail-Original-Message-ID: <CAHk-=whwNMtwpMxcsdC4bysY+5E9E_wNeUz=R-iciy3DJwQ+vg@mail.gmail.com>
Message-ID: <CAHk-=whwNMtwpMxcsdC4bysY+5E9E_wNeUz=R-iciy3DJwQ+vg@mail.gmail.com>
Subject: Linux 6.4-rc4
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

I'm traveling most of the day today, so the 6.4-rc4 release is tagged
and pushed out a few hours earlier than usual.

Other than that timing change, things look fairly normal. The changes
are all the usual suspects, with drivers, core networking, and arch
updates being the bulk of it. The bpf selftests show up fairly clearly
in the diffstat too, but most of that is code movement.

Nothing stands out to me, but the shortlog is appended for people who
want to scroll through the details.

Please do continue testing,

                    Linus

---

Adam Ford (2):
      arm64: dts: imx8mn: Fix video clock parents
      arm64: dts: imx8mp: Fix video clock parents

Adam Stylinski (1):
      ALSA: hda/ca0132: add quirk for EVGA X299 DARK

Alan Liu (1):
      drm/amd/display: Fix warning in disabling vblank irq

Alejandro Lucero (1):
      sfc: fix devlink info error handling

Alex Deucher (1):
      drm/radeon: reintroduce radeon_dp_work_func content

Alexander Stein (2):
      ARM: dts: imx6qdl-mba6: Add missing pvcie-supply regulator
      regulator: pca9450: Fix BUCK2 enable_mask

Alexandru Sorodoc (1):
      platform/x86: asus-wmi: Ignore WMI events with codes 0x7B, 0xC0

Amadeusz S=C5=82awi=C5=84ski (4):
      ASoC: Intel: avs: Fix module lookup
      ASoC: Intel: avs: Access path components under lock
      ASoC: Intel: avs: Fix avs_path_module::instance_id size
      ASoC: Intel: avs: Add missing checks on FE startup

Amit Kumar Mahapatra (1):
      spi: dw: Replace spi->chip_select references with function calls

Andreas Kemnade (1):
      gpiolib: fix allocation of mixed dynamic/static GPIOs

Andrejs Cainikovs (1):
      arm64: dts: colibri-imx8x: delete adc1 and dsp

Andrii Nakryiko (1):
      samples/bpf: Drop unnecessary fallthrough

Anna Schumaker (1):
      NFSv4.2: Fix a potential double free with READ_PLUS

Anton Protopopov (1):
      bpf: fix a memory leak in the LRU and LRU_PERCPU hash maps

Anuj Gupta (1):
      block: fix bio-cache for passthru IO

Ar=C4=B1n=C3=A7 =C3=9CNAL (1):
      net: ethernet: mtk_eth_soc: fix QoS on DSA MAC on non MTK_NETSYS_V2 S=
oCs

Bin Li (1):
      ALSA: hda/realtek: Enable headset onLenovo M70/M90

Carlos Llamas (5):
      binder: fix UAF caused by faulty buffer cleanup
      Revert "binder_alloc: add missing mmap_lock calls when using the VMA"
      Revert "android: binder: stop saving a pointer to the VMA"
      binder: add lockless binder_alloc_(set|get)_vma()
      binder: fix UAF of alloc->vma in race with munmap()

Cezary Rojewski (3):
      ASoC: Intel: Skylake: Fix declaration of enum skl_ch_cfg
      ASoC: Intel: avs: Fix declaration of enum avs_channel_config
      ASoC: Intel: avs: Account for UID of ACPI device

Charles Keepax (3):
      spi: spi-cadence: Avoid read of RX FIFO before its ready
      spi: spi-cadence: Only overlap FIFO transactions in slave mode
      spi: spi-cadence: Interleave write of TX and read of RX FIFO

ChiaEn Wu (1):
      power: supply: rt9467: Fix passing zero to 'dev_err_probe'

Christian Loehle (1):
      mmc: block: ensure error propagation for non-blk

Christoph Hellwig (1):
      block: make bio_check_eod work for zero sized devices

Christoph Niedermaier (1):
      ARM: dts: imx6ull-dhcor: Set and limit the mode for PMIC buck 1, 2 an=
d 3

Christophe JAILLET (3):
      mmc: sdhci-cadence: Fix an error handling path in sdhci_cdns_probe()
      forcedeth: Fix an error handling path in nv_probe()
      3c589_cs: Fix an error handling path in tc589_probe()

Chuck Lever (8):
      net/handshake: Squelch allocation warning during Kunit test
      net/handshake: Fix sock->file allocation
      net/handshake: Remove unneeded check from handshake_dup()
      net/handshake: Fix handshake_dup() ref counting
      net/handshake: Fix uninitialized local variable
      net/handshake: handshake_genl_notify() shouldn't ignore @flags
      net/handshake: Unpin sock->file if a handshake is cancelled
      net/handshake: Enable the SNI extension to work properly

Conor Dooley (1):
      MAINTAINERS: update arm64 Microchip entries

Daisuke Nojiri (1):
      power: supply: sbs-charger: Fix INHIBITED bit for Status reg

Dan Carpenter (4):
      coresight: Fix signedness bug in tmc_etr_buf_insert_barrier_packet()
      platform/mellanox: mlxbf-pmc: fix sscanf() error checking
      accel/qaic: silence some uninitialized variable warnings
      xen/pvcalls-back: fix double frees with pvcalls_new_active_socket()

Dan Williams (1):
      cxl/port: Enable the HDM decoder capability for switch ports

Dave Hansen (1):
      x86/mm: Avoid incomplete Global INVLPG flushes

Dave Jiang (3):
      cxl: Wait Memory_Info_Valid before access memory related info
      cxl: Move cxl_await_media_ready() to before capacity info retrieval
      cxl: Explicitly initialize resources when media is not ready

David Arcari (1):
      platform/x86/intel/ifs: Annotate work queue on stack so object
debug does not complain

David Epping (5):
      ASoC: dt-bindings: tlv320aic32x4: Fix supply names
      net: phy: mscc: add VSC8502 to MODULE_DEVICE_TABLE
      net: phy: mscc: add support for VSC8501
      net: phy: mscc: remove unnecessary phydev locking
      net: phy: mscc: enable VSC8501/2 RGMII RX clock

David Howells (1):
      cifs: Fix cifs_limit_bvec_subset() to correctly check the maxmimum si=
ze

Douglas Anderson (2):
      dt-bindings: interrupt-controller: arm,gic-v3: Add quirk for
Mediatek SoCs w/ broken FW
      irqchip/gic-v3: Disable pseudo NMIs on Mediatek devices w/ firmware i=
ssues

Emanuele Ghidoli (3):
      arm64: dts: colibri-imx8x: fix eval board pin configuration
      arm64: dts: colibri-imx8x: move pinctrl property from SoM to eval boa=
rd
      arm64: dts: colibri-imx8x: fix iris pinctrl configuration

Erez Shitrit (1):
      net/mlx5: DR, Fix crc32 calculation to work on big-endian (BE) CPUs

Etienne Carriere (1):
      optee: fix uninited async notif value

Evan Quan (1):
      drm/amd/pm: add missing NotifyPowerSource message mapping for SMU13.0=
.7

Fabio M. De Francesco (1):
      NFS: Convert kmap_atomic() to kmap_local_folio()

Fangzhi Zuo (1):
      drm/amd/display: Have Payload Properly Created After Resume

Finn Thain (1):
      m68k: Move signal frame following exception on 68020/030

Frank Li (2):
      dt-binding: cdns,usb3: Fix cdns,on-chip-buff-size type
      arm64: dts: imx8: fix USB 3.0 Gadget Failure in QM & QXPB0 at super s=
peed

Gao Xiang (1):
      erofs: use HIPRI by default if per-cpu kthreads are enabled

Gautham R. Shenoy (1):
      cpufreq: amd-pstate: Add ->fast_switch() callback

Gavrilov Ilia (1):
      ipv6: Fix out-of-bounds access in ipv6_find_tlv()

Haibo Chen (1):
      mmc: sdhci-esdhc-imx: make "no-mmc-hs400" works

Hans de Goede (15):
      power: supply: ab8500: Fix external_power_changed race
      power: supply: axp288_fuel_gauge: Fix external_power_changed race
      power: supply: bq25890: Fix external_power_changed race
      power: supply: sc27xx: Fix external_power_changed race
      power: supply: leds: Fix blink to LED on transition
      power: supply: bq27xxx: Fix bq27xxx_battery_update() race condition
      power: supply: bq27xxx: Fix I2C IRQ race on remove
      power: supply: bq27xxx: Fix poll_interval handling and races on remov=
e
      power: supply: bq27xxx: Add cache parameter to
bq27xxx_battery_current_and_status()
      power: supply: bq27xxx: Move bq27xxx_battery_update() down
      power: supply: bq27xxx: Ensure power_supply_changed() is called
on current sign changes
      power: supply: bq27xxx: After charger plug in/out wait 0.5s for
things to stabilize
      power: supply: bq27xxx: Use mod_delayed_work() instead of
cancel() + schedule()
      power: supply: bq25890: Call power_supply_changed() after
updating input current or voltage
      power: supply: bq24190: Call power_supply_changed() after
updating input current

Hao Ge (1):
      fs: fix undefined behavior in bit shift for SB_NOUSER

Harshit Mogalapalli (1):
      module: Fix use-after-free bug in read_file_mod_stats()

Helge Deller (9):
      parisc: Improve cache flushing for PCXL in arch_sync_dma_for_cpu()
      parisc: Flush gatt writes and adjust gatt mask in parisc_agp_mask_mem=
ory()
      parisc: Use num_present_cpus() in alternative patching code
      parisc: Add lightweight spinlock checks
      parisc: Enable LOCKDEP support
      parisc: Allow to reboot machine after system halt
      parisc: Handle kprobes breakpoints only in kernel context
      parisc: Handle kgdb breakpoints only in kernel context
      parisc: Fix flush_dcache_page() for usage from irq context

Henning Schild (1):
      gpio-f7188x: fix chip name and pin count on Nuvoton chip

Horatiu Vultur (1):
      lan966x: Fix unloading/loading of the driver

Huacai Chen (1):
      power: supply: Fix power_supply_get_battery_info() if parent is NULL

Hugo Villeneuve (1):
      arm64: dts: imx8mn-var-som: fix PHY detection bug by adding deassert =
delay

Imre Deak (1):
      drm/i915: Fix PIPEDMC disabling for a bigjoiner configuration

Jakub Kicinski (10):
      bpf: netdev: init the offload table earlier
      tls: rx: device: fix checking decryption status
      tls: rx: strp: set the skb->len of detached / CoW'ed skbs
      tls: rx: strp: force mixed decrypted records into copy mode
      tls: rx: strp: fix determining record length in copy mode
      tls: rx: strp: factor out copying skb data
      tls: rx: strp: preserve decryption status of skbs when needed
      tls: rx: strp: don't use GFP_KERNEL in softirq context
      net/mlx5e: do as little as possible in napi poll when budget is 0
      docs: netdev: document the existence of the mail bot

Jeff Layton (1):
      fs: don't call posix_acl_listxattr in generic_listxattr

Jeffrey Hugo (1):
      accel/qaic: Fix NNC message corruption

Jeremy Sowden (1):
      selftests/bpf: Fix pkg-config call building sign-file

Jesse Zhang (1):
      drm/amdgpu: don't enable secure display on incompatible platforms

Jiaxun Yang (2):
      irqchip/mips-gic: Don't touch vl_map if a local interrupt is not rout=
able
      irqchip/mips-gic: Use raw spinlock for gic_lock

Jingbo Xu (1):
      erofs: fix null-ptr-deref caused by erofs_xattr_prefixes_init

Jocelyn Falempe (1):
      drm/mgag200: Fix gamma lut not initialized.

Johannes Thumshirn (1):
      btrfs: handle memory allocation failure in btrfs_csum_one_bio

John Fastabend (14):
      bpf, sockmap: Pass skb ownership through read_skb
      bpf, sockmap: Convert schedule_work into delayed_work
      bpf, sockmap: Reschedule is now done through backlog
      bpf, sockmap: Improved check for empty queue
      bpf, sockmap: Handle fin correctly
      bpf, sockmap: TCP data stall on recv before accept
      bpf, sockmap: Wake up polling after data copy
      bpf, sockmap: Incorrectly handling copied_seq
      bpf, sockmap: Pull socket helpers out of listen test for general use
      bpf, sockmap: Build helper to create connected socket pair
      bpf, sockmap: Test shutdown() correctly exits epoll and recv()=3D0
      bpf, sockmap: Test FIONREAD returns correct bytes in rx buffer
      bpf, sockmap: Test FIONREAD returns correct bytes in rx buffer with d=
rops
      bpf, sockmap: Test progs verifier error with latest clang

Jonatas Esteves (1):
      drm/amd/pm: Fix output of pp_od_clk_voltage

Josef Bacik (1):
      btrfs: use nofs when cleaning up aborted transactions

Josh Poimboeuf (1):
      vmlinux.lds.h: Discard .note.gnu.property section

Kan Liang (1):
      perf/x86/uncore: Correct the number of CHAs on SPR

Kang Chen (1):
      power: supply: mt6360: add a check of devm_work_autocancel in
mt6360_charger_probe

Kefeng Wang (1):
      irqchip/mbigen: Unify the error handling in mbigen_of_create_domain()

Krzysztof Kozlowski (4):
      ARM: dts: vexpress: add missing cache properties
      arm64: dts: arm: add missing cache properties
      spi: MAINTAINERS: drop Krzysztof Kozlowski from Samsung SPI
      irqchip/meson-gpio: Mark OF related data as maybe unused

Kuniyuki Iwashima (1):
      udplite: Fix NULL pointer dereference in __sk_mem_raise_allocated().

Like Xu (1):
      perf/x86/intel: Save/restore cpuc->active_pebs_data_cfg when
using guest PEBS

Linus Torvalds (3):
      module: error out early on concurrent load of the same module file
      x86: re-introduce support for ERMS copies for user space accesses
      Linux 6.4-rc4

Linus Walleij (1):
      drm/pl111: Fix FB depth on IMPD-1 framebuffer

Liviu Dudau (1):
      mips: Move initrd_start check after initrd address sanitisation.

Manuel Lauss (3):
      MIPS: unhide PATA_PLATFORM
      MIPS: Restore Au1300 support
      MIPS: Alchemy: fix dbdma2

Marek Vasut (1):
      power: supply: Ratelimit no data debug output

Mario Limonciello (2):
      platform/x86/amd/pmf: Fix CnQF and auto-mode after resume
      power: supply: Fix logic checking if system is running from battery

Matthew Auld (1):
      drm: fix drmm_mutex_init()

Matthias Kaehlcke (1):
      ASoC: rt5682: Disable jack detection interrupt during suspend

Max Filippov (2):
      xtensa: fix signal delivery to FDPIC process
      xtensa: add __bswap{si,di}2 helpers

Maxim Kochetkov (1):
      ASoC: dwc: move DMA init to snd_soc_dai_driver probe()

Maximilian Heyne (1):
      x86/pci/xen: populate MSI sysfs entries

Maya Matuszczyk (1):
      drm: panel-orientation-quirks: Change Air's quirk to support Air Plus

Michael Ellerman (1):
      powerpc/mm: Reinstate ARCH_FORCE_MAX_ORDER ranges

Mika Westerberg (1):
      PCI/DPC: Quirk PIO log size for Intel Ice Lake Root Ports

Milo Spadacini (1):
      tools: gpio: fix debounce_period_us output of lsgpio

Mirsad Todorovac (1):
      selftests: gpio: gpio-sim: Fix BUG: test FAILED due to recent change

Namjae Jeon (1):
      ntfs: Add myself as a reviewer

Neeraj Sanjay Kale (1):
      Bluetooth: btnxpuart: Fix compiler warnings

Nicolas Dichtel (1):
      ipv{4,6}/raw: fix output xfrm lookup wrt protocol

Osama Muhammad (1):
      regulator: Fix error checking for debugfs_create_dir

Paolo Valente (1):
      block, bfq: update Paolo's address in maintainer list

Paul Blakey (1):
      net/mlx5e: TC, Fix using eswitch mapping in nic mode

Paulo Alcantara (1):
      cifs: fix smb1 mount regression

Peter Ujfalusi (1):
      tpm: tpm_tis: Disable interrupts for AEON UPX-i11

Peter Zijlstra (1):
      debugobjects,locking: Annotate debug_object_fill_pool() wait
type violation

Po-Hsu Lin (1):
      selftests: fib_tests: mute cleanup error message

Pranjal Ramajor Asha Kanojiya (4):
      accel/qaic: Validate user data before grabbing any lock
      accel/qaic: Validate if BO is sliced before slicing
      accel/qaic: Flush the transfer list again
      accel/qaic: Grab ch_lock during QAIC_ATTACH_SLICE_BO

Pratyush Yadav (1):
      net: fix skb leak in __skb_tstamp_tx()

Qu Wenruo (1):
      btrfs: scrub: try harder to mark RAID56 block groups read-only

Rahul Rameshbabu (1):
      net/mlx5e: Fix SQ wake logic in ptp napi_poll context

Ranjani Sridharan (1):
      ASoC: soc-pcm: test if a BE can be prepared

Ravulapati Vishnu Vardhan Rao (1):
      ASoC: lpass: Fix for KASAN use_after_free out of bounds

Robert Richter (1):
      cxl/port: Fix NULL pointer access in devm_cxl_add_port()

Roi Dayan (1):
      net/mlx5: Fix error message when failing to allocate device memory

Ross Lagerwall (1):
      xen/blkfront: Only check REQ_FUA for writes

Ruidong Tian (1):
      coresight: perf: Release Coresight path when alloc trace id failed

Ruihan Li (4):
      Bluetooth: Fix potential double free caused by hci_conn_unlink
      Bluetooth: Refcnt drop must be placed last in hci_conn_unlink
      Bluetooth: Fix UAF in hci_conn_hash_flush again
      Bluetooth: Unlink CISes when LE disconnects in hci_conn_del

Sebastian Andrzej Siewior (1):
      r8169: Use a raw_spinlock_t for the register locks.

Sen Chu (1):
      regulator: mt6359: add read check for PMIC MT6359

Shay Drory (8):
      net/mlx5: Collect command failures data only for known commands
      net/mlx5: Handle pairing of E-switch via uplink un/load APIs
      net/mlx5: E-switch, Devcom, sync devcom events and devcom comp regist=
er
      net/mlx5: Devcom, fix error flow in mlx5_devcom_register_device
      net/mlx5: Devcom, serialize devcom registration
      net/mlx5: Free irqs only on shutdown callback
      net/mlx5: Fix irq affinity management
      net/mlx5: Fix indexing of mlx5_irq

Shenwei Wang (1):
      net: fec: add dma_wmb to ensure correct descriptor values

Srinivas Pandruvada (1):
      thermal: intel: int340x: Add new line for UUID display

Stefan Binding (1):
      ASoC: cs35l41: Fix default regmap values for some registers

Steve French (5):
      smb3: display debug information better for encryption
      cifs: mapchars mount option ignored
      smb: move client and server files to common directory fs/smb
      cifs: correct references in Documentation to old fs/cifs path
      smb3: move Documentation/filesystems/cifs to Documentation/filesystem=
s/smb

Steve Wahl (1):
      platform/x86: ISST: Remove 8 socket limit

Sudeep Holla (4):
      firmware: arm_ffa: Check if ffa_driver remove is present before execu=
ting
      firmware: arm_ffa: Fix usage of partition info get count flag
      firmware: arm_ffa: Fix FFA device names for logical partitions
      firmware: arm_ffa: Set reserved/MBZ fields to zero in the memory
descriptors

Sukrut Bellary (1):
      drm:amd:amdgpu: Fix missing buffer object unlock in failure path

Sunil Goutham (1):
      octeontx2-pf: Fix TSOv6 offload

Taehee Yoo (1):
      net: fix stack overflow when LRO is disabled for virtual interfaces

Takashi Iwai (1):
      ALSA: hda: Fix unhandled register update during auto-suspend period

Tatsuki Sugiura (1):
      NVMe: Add MAXIO 1602 to bogus nid list.

Tejun Heo (1):
      firmware: arm_scmi: Fix incorrect alloc_workqueue() invocation

Tetsuo Handa (1):
      debugobjects: Don't wake up kswapd from fill_pool()

Tian Lan (1):
      blk-mq: fix race condition in active queue accounting

Tom Rix (1):
      accel/qaic: initialize ret variable to 0

Trond Myklebust (1):
      SUNRPC: Don't change task->tk_status after the call to rpc_exit_task

Tudor Ambarus (1):
      net: cdc_ncm: Deal with too low values of dwNtbOutMaxSize

Vernon Lovejoy (1):
      x86/show_trace_log_lvl: Ensure stack pointer is aligned, again

Vijaya Krishna Nivarthi (1):
      spi: spi-geni-qcom: Select FIFO mode for chip select

Vlad Buslov (2):
      net/mlx5e: Use correct encap attribute during invalidation
      net/mlx5e: Fix deadlock in tc route query code

Vladimir Oltean (1):
      MAINTAINERS: add myself as maintainer for enetc

Vladislav Efanov (1):
      drm/sched: Remove redundant check

Wen Gu (1):
      net/smc: Reset connection when trying to use SMCRv2 fails.

Wenwen Chen (1):
      io_uring: unlock sqd->lock before sq thread release CPU

Will Deacon (1):
      bpf: Fix mask generation for 32-bit narrow loads of 64-bit fields

Wyes Karny (2):
      cpufreq: amd-pstate: Remove fast_switch_possible flag from active dri=
ver
      cpufreq: amd-pstate: Update policy->cur in amd_pstate_adjust_perf()

Xin Long (1):
      sctp: fix an issue that plpmtu can never go to complete state

Yan Zhao (1):
      vfio/type1: check pfn valid before converting to struct page

Yevgeny Kliteynik (1):
      net/mlx5: DR, Check force-loopback RC QP capability
independently from RoCE

Yu Kuai (1):
      blk-wbt: fix that wbt can't be disabled by default

Yue Hu (1):
      erofs: avoid pcpubuf.c inclusion if CONFIG_EROFS_FS_ZIP is off

Yunsheng Lin (1):
      page_pool: fix inconsistency for page_pool_ring_[un]lock()

Zev Weiss (1):
      gpio: mockup: Fix mode of debugfs files

Zhang Rui (1):
      x86/topology: Fix erroneous smp_num_siblings on Intel Hybrid platform=
s
