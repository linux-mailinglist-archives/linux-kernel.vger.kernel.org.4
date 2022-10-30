Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C3C612D80
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 23:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJ3WgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 18:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ3WgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 18:36:12 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8780DBA5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 15:36:10 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id x21so481243qkj.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 15:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dvUYJw7VhnKan9TnPA4MyqeLUwzLrSYVfKC1ez2bE/0=;
        b=Wh2PutBS5Vtykgcw3/HelUsnhIpok/agfv+RnSQs/p4aybFoRRSLGKM3xI/AOxTjmP
         UQMIkFIKZaCQB/HYsjhOvAm3vEHstHGl43cwsJMcUDs30zisiexGkKkF8V/feHv7H1o7
         iwjh/J+VzOB8ock21teQaJlwynGPyUhYQiKeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dvUYJw7VhnKan9TnPA4MyqeLUwzLrSYVfKC1ez2bE/0=;
        b=gMwKqf384kixRjPyd2kxUBSkUD07KkE34ngsHp7ITxk2SvqoSFSOaiKVmZLB6s8RCm
         YpWDHUPC/3F1zhRyVrYAkCs8qdfrcH8rYgQSfiLR/G+iQCo9q6kHZ3LGTqECWeD0LZyx
         YXDu9aXQLH6YeWythrsiemyX0v51RZJpAe5AJF+MZ73RSYPR4ynYrP78Wq6afhMZPf4i
         vn3YbgbAj0Ak1HukXHS4gfwfE1L4jj/SOnf65guYJIo9497Cgatpnu5lF5FRmWXWdLjW
         hfEqdRikiFxSiYWgg0Ry+TP4IyiYr7/B1+KI3ssJSzPiy847uRU90XrVOWrGkpyD66KR
         c2DA==
X-Gm-Message-State: ACrzQf1toRekXUpyDPIMSnpqNdAeZFy3FMdqu84hrbEJO0d4pcdiZUIt
        hZkYoR/T8FCjUPKlUmmaZkQjbIJs6pt+vw==
X-Google-Smtp-Source: AMsMyM6EL87AC7mZG0K6rbY/CORQr4QbW65Zywb8xz613teWL/540wASzJE1eGkktcFVzBB8xqnAWw==
X-Received: by 2002:a37:6347:0:b0:6f8:e1c1:97c0 with SMTP id x68-20020a376347000000b006f8e1c197c0mr7235821qkb.308.1667169368852;
        Sun, 30 Oct 2022 15:36:08 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id g19-20020a05620a40d300b006eea4b5abcesm3611663qko.89.2022.10.30.15.36.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 15:36:08 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id n130so11894075yba.10
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 15:36:08 -0700 (PDT)
X-Received: by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr10659439ybu.310.1667169367238; Sun, 30
 Oct 2022 15:36:07 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 30 Oct 2022 15:35:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJVNe4mUxGJE5B-_GMg0oOgxkZz3UxehVRiCT3QvoZ0w@mail.gmail.com>
Message-ID: <CAHk-=wgJVNe4mUxGJE5B-_GMg0oOgxkZz3UxehVRiCT3QvoZ0w@mail.gmail.com>
Subject: Linux 6.1-rc3
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

It's Sunday afternoon, so it must be time for an rc release.

I know I said last week that rc2 was unusually large. It turns out
that rc3 is almost exactly the same size. But at least for an rc3
release, that bigger size is a bit more normal: this is when people
are starting to find problems and send in fixes for them.

So while rc2 was just _way_ bigger than usual, rc3 is only a bit
larger than an average rc3 release is. But it's still on the largish
side. I hope that things start calming down, and we'll start seeing
the size of these rc's shrink. Please?

Unlike rc2, there's no one single reason for the bulk of the rc3
changes. They're pretty much all over, with the usual distribution -
drivers dominating (networking, gpu and sound are most noticeable, but
there's a little bit of everything).

Outside of drivers, tool updates stand out, with selftests, perf, and
the pm-graph tool all seeing a fair amount of changes.

And then we have the usual things: architecture updates, some
filesystem work, and core kernel fixes (mainly networking and mm).

Anyway, while it isn't small, nothing looks particularly worrisome or
strange, and I thin kyou can just scan the appended shortlog to get a
feel for the kinds of fixes we have here. Please do give it more
testing, and here's to hoping we'll start seeing the rc's shrink from
now on.

           Linus

---

Aaron Conole (2):
      openvswitch: switch from WARN to pr_warn
      selftests: add openvswitch selftest suite

Aashish Sharma (1):
      drm/msm: Remove redundant check for 'submit'

Adrian Hunter (2):
      perf docs: Fix man page build wrt perf-arm-coresight.txt
      perf auxtrace: Fix address filter symbol name match for modules

Aidan MacDonald (1):
      ASoC: simple-card: Fix up checks for HW param fixups

Akhil P Oommen (2):
      drm/msm/a6xx: Replace kcalloc() with kvzalloc()
      drm/msm/gpu: Fix crash during system suspend after unbind

Alexander Aring (1):
      net: ieee802154: return -EINVAL for unknown addr type

Alexander Potapenko (5):
      mm: kmsan: export kmsan_copy_page_meta()
      x86/purgatory: disable KMSAN instrumentation
      Kconfig.debug: disable CONFIG_FRAME_WARN for KMSAN by default
      x86: asm: make sure __put_user_size() evaluates pointer once
      x86: fortify: kmsan: fix KMSAN fortify builds

Alexandre Belloni (1):
      rtc: cmos: fix build on non-ACPI platforms

Alvin Lee (1):
      drm/amd/display: Don't return false if no stream

Amadeusz S=C5=82awi=C5=84ski (1):
      ARC: bitops: Change __fls to return unsigned long

Andrew Jones (1):
      RISC-V: Fix /proc/cpuinfo cpumask warning

Andrew Morton (2):
      ipc/msg.c: fix percpu_counter use after free
      fs/ext4/super.c: remove unused `deprecated_msg'

Andrey Smirnov (1):
      usb: dwc3: Don't switch OTG -> peripheral if extcon is present

Andy Shevchenko (1):
      device property: Fix documentation for *_match_string() APIs

Ankit Nautiyal (1):
      drm/i915/dp: Reset frl trained flag before restarting FRL training

Anshuman Gupta (1):
      drm/i915/dgfx: Keep PCI autosuspend control 'on' by default on all dG=
PU

Anssi Hannula (1):
      can: kvaser_usb: Fix possible completions during init_completion

Ariel Levkovich (1):
      net/mlx5e: TC, Reject forwarding from internal port to internal port

Arnaldo Carvalho de Melo (10):
      tools headers UAPI: Sync powerpc syscall tables with the kernel sourc=
es
      perf bpf: Fix build with libbpf 0.7.0 by adding prototype for
bpf_load_program()
      perf bpf: Fix build with libbpf 0.7.0 by checking if
bpf_program__set_insns() is available
      tools headers arm64: Sync arm64's cputype.h with the kernel sources
      tools headers: Update the copy of x86's memcpy_64.S used in 'perf ben=
ch'
      tools headers uapi: Update linux/in.h copy
      tools include UAPI: Sync sound/asound.h copy with the kernel sources
      tools headers uapi: Sync linux/stat.h with the kernel sources
      tools headers cpufeatures: Sync with the kernel sources
      tools headers UAPI: Sync linux/perf_event.h with the kernel sources

Aya Levin (1):
      net/mlx5e: Extend SKB room check to include PTP-SQ

Baolin Wang (1):
      mm: migrate: fix return value if all subpages of THPs are
migrated successfully

Benjamin Gaignard (1):
      net: stmmac: rk3588: Allow multiple gmac controller

Benjamin Poirier (2):
      selftests: net: Fix cross-tree inclusion of scripts
      selftests: net: Fix netdev name mismatch in cleanup

Bernd Edlinger (1):
      exec: Copy oldsighand->action under spin-lock

Biju Das (2):
      can: rcar_canfd: rcar_canfd_handle_global_receive(): fix IRQ
storm on global FIFO receive
      can: rcar_canfd: fix channel specific IRQ handling for RZ/G2L

Bird, Tim (1):
      spi: spi-gxp: fix typo in SPDX identifier line

Brian Norris (1):
      mmc: sdhci_am654: 'select', not 'depends' REGMAP_MMIO

Caleb Connolly (3):
      net: ipa: fix v3.5.1 resource limit max values
      net: ipa: fix v3.1 resource limit masks
      net: ipa: don't configure IDLE_INDICATION on v3.1

Chengming Gui (1):
      drm/amdgpu: fix pstate setting issue

Chin-Ting Kuo (1):
      spi: aspeed: Fix typo in mode_bits field for AST2600 platform

Christian K=C3=B6nig (1):
      drm/scheduler: fix fence ref counting

Christian L=C3=B6hle (2):
      mmc: block: Remove error check of hw_reset on reset
      mmc: queue: Cancel recovery work on cleanup

Christoph Hellwig (1):
      scsi: target: iblock: Fold
iblock_emulate_read_cap_with_block_size() into iblock_get_blocks()

Christophe Leroy (1):
      spi: mpc52xx: Replace NO_IRQ by 0

Colin Ian King (3):
      scsi: lpfc: Fix spelling mistake "unsolicted" -> "unsolicited"
      drm/msm: Kconfig: Fix spelling mistake "throught" -> "through"
      ASoC: codecs: jz4725b: Fix spelling mistake "Sourc" -> "Source",
"Routee" -> "Route"

Conor Dooley (2):
      riscv: fix detection of toolchain Zicbom support
      riscv: fix detection of toolchain Zihintpause support

Cosmin Tanislav (1):
      iio: temperature: ltc2983: allocate iio channels once

C=C3=A9dric Le Goater (1):
      spi: aspeed: Fix window offset of CE1

Dan Carpenter (3):
      iio: adc: mcp3911: fix sizeof() vs ARRAY_SIZE() bug
      counter: ti-ecap-capture: fix IS_ERR() vs NULL check
      kunit: update NULL vs IS_ERR() tests

Dan Vacura (2):
      usb: gadget: uvc: fix dropped frame after missed isoc
      usb: gadget: uvc: fix sg handling in error case

David Francis (1):
      drm/amd: Add IMU fw version to fw version queries

David Vernet (2):
      bpf: Allow bpf_user_ringbuf_drain() callbacks to return 1
      selftests/bpf: Make bpf_user_ringbuf_drain() selftest callback return=
 1

Derek Fang (2):
      ASoC: rt5682s: Fix the TDM Tx settings
      ASoC: rt1019: Fix the TDM settings

Dmitry Bogdanov (5):
      scsi: target: core: Fix preempt and abort for allreg res
      scsi: target: core: Fix memory leak in preempt_and_abort
      scsi: target: core: Abort all preempted regs if requested
      scsi: target: core: New key must be used for moved PR
      scsi: target: core: UA on all LUNs after reset

Dmitry Osipenko (1):
      ACPI: video: Fix missing native backlight on Chromebooks

Dongliang Mu (2):
      can: mscan: mpc5xxx: mpc5xxx_can_probe(): add missing
put_clock() in error path
      can: mcp251x: mcp251x_can_probe(): add missing
unregister_candev() in error path

Douglas Anderson (2):
      pinctrl: qcom: Avoid glitching lines when we first mux to output
      drm/bridge: ps8640: Add back the 50 ms mystery delay after HPD

Dukhyun Kwon (1):
      scsi: ufs: core: Fix the error log in ufshcd_query_flag_retry()

Dylan Yudaken (2):
      io_uring: use io_run_local_work_locked helper
      io_uring: unlock if __io_run_local_work locked inside

Eric Biggers (1):
      fscrypt: fix keyring memory leak on mount failure

Eric Dumazet (5):
      kcm: annotate data-races around kcm->rx_psock
      kcm: annotate data-races around kcm->rx_wait
      ipv6: ensure sane device mtu in tunnels
      net: do not sense pfmemalloc status in skb_append_pagefrags()
      kcm: do not sense pfmemalloc status in kcm_sendpage()

Florian Fainelli (1):
      net: bcmsysport: Indicate MAC is in charge of PHY PM

Gayatri Kammela (1):
      platform/x86/intel: pmc/core: Add Raptor Lake support to pmc core dri=
ver

Geert Uytterhoeven (1):
      ASoC: codecs: tlv320adc3xxx: Wrap adc3xxx_i2c_remove() in __exit_p()

Greg Kroah-Hartman (3):
      MAINTAINERS: move USB gadget and phy entries under the main USB entry
      Revert "coresight: cti: Fix hang in cti_disable_hw()"
      Revert "usb: gadget: uvc: limit isoc_sg to super speed gadgets"

Guixin Liu (5):
      scsi: megaraid_sas: Correct value passed to scsi_device_lookup()
      scsi: megaraid_sas: Correct an error message
      scsi: megaraid_sas: Simplify megasas_update_device_list
      scsi: megaraid_sas: Remove unnecessary memset()
      scsi: megaraid_sas: Move megasas_dbg_lvl init to megasas_init()

Hans Verkuil (8):
      media: vivid: s_fbuf: add more sanity checks
      media: vivid: dev->bitmap_cap wasn't freed in all cases
      media: v4l2-dv-timings: add sanity checks for blanking values
      media: videodev2.h: V4L2_DV_BT_BLANKING_HEIGHT should check 'interlac=
ed'
      media: vivid: fix control handler mutex deadlock
      media: vivid: drop GFP_DMA32
      media: vivid: set num_in/outputs to 0 if not supported
      media: vivid.rst: loop_video is set on the capture devnode

Hans de Goede (1):
      ACPI: scan: Add LATT2021 to acpi_ignore_dep_ids[]

Haren Myneni (2):
      powerpc/pseries/vas: Add VAS IRQ primary handler
      powerpc/pseries: Use lparcfg to reconfig VAS windows for DLPAR CPU

Heikki Krogerus (2):
      usb: typec: ucsi: Check the connection on resume
      usb: typec: ucsi: acpi: Implement resume callback

Heiko Carstens (4):
      MAINTAINERS: remove outdated linux390 link
      s390/uaccess: add missing EX_TABLE entries to __clear_user()
      s390/futex: add missing EX_TABLE entry to __futex_atomic_op()
      s390/pci: add missing EX_TABLE entries to
__pcistg_mio_inuser()/__pcilg_mio_inuser()

Helge Deller (1):
      fbdev: stifb: Fall back to cfb_fillrect() on 32-bit HCRX cards

Henning Schild (1):
      leds: simatic-ipc-leds-gpio: fix incorrect LED to GPIO mapping

Horatiu Vultur (3):
      pinctrl: ocelot: Fix incorrect trigger of the interrupt.
      net: lan966x: Fix the rx drop counter
      net: lan966x: Stop replacing tx dcbs and dcbs_buf when changing MTU

Hou Tao (2):
      bpf: Wait for busy refill_work when destroying bpf memory allocator
      bpf: Use __llist_del_all() whenever possbile during memory draining

Huacai Chen (2):
      LoongArch: BPF: Avoid declare variables in switch-case
      platform/loongarch: laptop: Adjust resume order for
loongson_hotkey_resume()

Huang Ying (1):
      memory tier, sysfs: rename attribute "nodes" to "nodelist"

Hugh Dickins (1):
      mm: prep_compound_tail() clear page->private

Hyong Youb Kim (1):
      net/mlx5e: Do not increment ESN when updating IPsec ESN state

Hyunwoo Kim (1):
      fbdev: smscufx: Fix several use-after-free bugs

Ian Rogers (1):
      perf record: Fix event fd races

Igor Pylypiv (1):
      scsi: pm80xx: Display proc_name in sysfs

Ira Weiny (2):
      mm/userfaultfd: replace kmap/kmap_atomic() with kmap_local_page()
      mm/shmem: ensure proper fallback if page faults

Jakub Kicinski (6):
      ethtool: pse-pd: fix null-deref on genl_info in dump
      MAINTAINERS: add keyword match on PTP
      docs: netdev: offer performance feedback to contributors
      net-memcg: avoid stalls when under memory pressure
      genetlink: piggy back on resv_op to default to a reject policy
      genetlink: limit the use of validation workarounds to old ops

James Clark (3):
      coresight: cti: Fix hang in cti_disable_hw()
      coresight: cti: Fix hang in cti_disable_hw()
      perf: Fix missing raw data on tracepoint events

Jason A. Donenfeld (4):
      fbdev: sisfb: use explicitly signed char
      ALSA: au88x0: use explicitly signed char
      ALSA: rme9652: use explicitly signed char
      misc: sgi-gru: use explicitly signed char

Jason J. Herne (1):
      s390/vfio-ap: Fix memory allocation for mdev_types array

Jean-Philippe Brucker (1):
      random: use arch_get_random*_early() in random_init()

Jeff Vanhoof (1):
      usb: gadget: uvc: fix sg handling during video encode

Jelle van der Waa (1):
      platform/x86: thinkpad_acpi: Fix reporting a non present second
fan on some models

Jens Glathe (1):
      usb: xhci: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite being a
V0.96 controller

Jesse Zhang (1):
      drm/amdkfd: correct the cache info for gfx1036

Jiangshan Yi (1):
      ASoC: cx2072x: fix spelling typo in comment

Jilin Yuan (2):
      ARC: Fix comment typo
      fbdev: sisfb: fix repeated word in comment

Jinyang He (1):
      LoongArch: Remove unused kernel stack padding

Jiri Olsa (1):
      bpf: Fix dispatcher patchable function entry to 5 bytes nop

Jisheng Zhang (1):
      riscv: jump_label: mark arguments as const to satisfy asm constraints

Joaqu=C3=ADn Ignacio Aramend=C3=ADa (1):
      drm/amd/display: Revert logic for plane modifiers

Joel Stanley (1):
      usb: gadget: aspeed: Fix probe regression

Johan Hovold (8):
      drm/msm: fix use-after-free on probe deferral
      drm/msm/dp: fix memory corruption with too many bridges
      drm/msm/dsi: fix memory corruption with too many bridges
      drm/msm/hdmi: fix memory corruption with too many bridges
      drm/msm/dp: fix IRQ lifetime
      drm/msm/dp: fix aux-bus EP lifetime
      drm/msm/dp: fix bridge lifetime
      drm/msm/hdmi: fix IRQ lifetime

John Garry (1):
      blk-mq: Properly init requests from blk_mq_alloc_request_hctx()

Jonathan Neusch=C3=A4fer (1):
      spi: spi-mem: Fix typo (of -> or)

Jos=C3=A9 Roberto de Souza (1):
      drm/i915: Extend Wa_1607297627 to Alderlake-P

Juergen Borleis (1):
      net: fec: limit register access on i.MX6UL

Justin Chen (2):
      MAINTAINERS: Update maintainers for broadcom USB
      usb: bdc: change state when port disconnected

Kai Vehmanen (1):
      ASoC: SOF: ipc4-mtrace: protect per-core nodes against multiple open

Kajol Jain (1):
      perf vendor events power10: Fix hv-24x7 metric events

Kees Cook (3):
      fbdev: MIPS supports iomem addresses
      overflow: Fix kern-doc markup for functions
      overflow: Refactor test skips for Clang-specific issues

Keith Busch (1):
      nvme-multipath: set queue dma alignment to 3

Kenneth Feng (2):
      drm/amd/pm: update driver-if header for smu_v13_0_10
      drm/amd/pm: allow gfxoff on gc_11_0_3

Keoseong Park (2):
      scsi: ufs: core: Fix typo for register name in comments
      scsi: ufs: core: Fix typo in comment

Krishna Yarlagadda (1):
      spi: tegra210-quad: Fix combined sequence

Kunihiko Hayashi (1):
      net: ethernet: ave: Fix MAC to be in charge of PHY PM

Kuogee Hsieh (2):
      drm/msm/dp: add atomic_check to bridge ops
      drm/msm/dp: cleared DP_DOWNSPREAD_CTRL register before start link tra=
ining

Leohearts (1):
      ASoC: amd: yc: Add Lenovo Thinkbook 14+ 2022 21D0 to quirks table

Leon Romanovsky (1):
      net/mlx5e: Cleanup MACsec uninitialization routine

Li Zetao (1):
      fs/binfmt_elf: Fix memory leak in load_elf_binary()

Liam Howlett (1):
      mmap: fix remap_file_pages() regression

Lijo Lazar (1):
      drm/amdgpu: Remove ATC L2 access for MMHUB 2.1.x

Linus Torvalds (1):
      Linux 6.1-rc3

Linus Walleij (1):
      mtd: parsers: bcm47xxpart: Fix halfblock reads

Lu Wei (1):
      tcp: fix a signed-integer-overflow bug in tcp_add_backlog()

Lukas Bulwahn (2):
      arc: update config files
      lib: maple_tree: remove unneeded initialization in mtree_range_walk()

Luke D. Jones (1):
      platform/x86: asus-wmi: Add support for ROG X16 tablet mode

Maciej S. Szmigiero (6):
      ALSA: control: add snd_ctl_rename()
      ALSA: usb-audio: Use snd_ctl_rename() to rename a control
      ALSA: hda/realtek: Use snd_ctl_rename() to rename a control
      ALSA: emu10k1: Use snd_ctl_rename() to rename a control
      ALSA: ca0106: Use snd_ctl_rename() to rename a control
      ALSA: ac97: Use snd_ctl_rename() to rename a control

Manank Patel (1):
      ACPI: PCC: Fix unintentional integer overflow

Manish Rangankar (1):
      scsi: qla2xxx: Use transport-defined speed mask for supported_speeds

Marcus Folkesson (3):
      iio: adc: mcp3911: return proper error code on failure to allocate tr=
igger
      iio: adc: mcp3911: use correct id bits
      iio: adc: mcp3911: mask out device ID in debug prints

Maria Yu (1):
      mm/page_isolation: fix clang deadcode warning

Mario Limonciello (3):
      platform/x86/amd: pmc: Read SMU version during suspend on Cezanne sys=
tems
      PM: hibernate: Allow hybrid sleep to work with s2idle
      xhci-pci: Set runtime PM as default policy on all xHC 1.2 or later de=
vices

Markus Fuchs (1):
      scsi: ufs: core: Remove unneeded casts from void *

Mathias Nyman (2):
      xhci: Add quirk to reset host back to default state at shutdown
      xhci: Remove device endpoints from bandwidth list when freeing the de=
vice

Matthew Ma (1):
      mmc: core: Fix kernel panic when remove non-standard SDIO card

Matti Vaittinen (6):
      tools: iio: iio_utils: fix digit calculation
      iio: at91-sama5d2_adc: Fix unsafe buffer attributes
      iio: adxl372: Fix unsafe buffer attributes
      iio: adxl367: Fix unsafe buffer attributes
      iio: bmc150-accel-core: Fix unsafe buffer attributes
      MAINTAINERS: Change myself to a maintainer

Mauro Lima (1):
      spi: intel: Fix the offset to get the 64K erase opcode

Michael Grzeschik (1):
      usb: gadget: uvc: limit isoc_sg to super speed gadgets

Michal Kubecek (1):
      scsi: mpi3mr: Select CONFIG_SCSI_SAS_ATTRS

Micha=C5=82 Miros=C5=82aw (1):
      fbdev/core: Avoid uninitialized read in
aperture_remove_conflicting_pci_device()

Mika Westerberg (1):
      mtd: spi-nor: core: Ignore -ENOTSUPP in spi_nor_init()

Ming Lei (1):
      blk-mq: don't add non-pt request with ->end_io to batch

Miquel Raynal (1):
      mac802154: Fix LQI recording

Moshe Shemesh (1):
      net/mlx5: Wait for firmware to enable CRS before pci_restore_state

Nam Cao (1):
      nvme-tcp: replace sg_init_marker() with sg_init_table()

Namhyung Kim (1):
      perf test: Do not fail Intel-PT misc test w/o libpython

Nathan Huckleberry (2):
      drm/msm: Fix return type of mdp4_lvds_connector_mode_valid
      crypto: x86/polyval - Fix crashes when keys are not 16-byte aligned

Neal Cardwell (1):
      tcp: fix indefinite deferral of RTO with SACK reneging

Nicholas Piggin (10):
      powerpc/64s: Add lockdep for HPTE lock
      powerpc/64s: make HPTE lock and native_tlbie_lock irq-safe
      powerpc/64s: make linear_map_hash_lock a raw spinlock
      powerpc/64s: Disable preemption in hash lazy mmu mode
      powerpc/64s: Fix hash__change_memory_range preemption warning
      powerpc: Fix reschedule bug in KUAP-unlocked user copy
      KVM: PPC: BookS PR-KVM and BookE do not support context tracking
      powerpc/64/interrupt: Prevent NMI PMI causing a dangerous warning
      powerpc/64s/interrupt: Perf NMI should not take normal exit path
      powerpc/64s/interrupt: Fix clear of PACA_IRQS_HARD_DIS when
returning to soft-masked context

Nick Desaulniers (1):
      overflow: disable failing tests for older clang versions

Nicolas Dichtel (3):
      Revert "ip: fix triggering of 'icmp redirect'"
      Revert "ip: fix dflt addr selection for connected nexthop"
      nh: fix scope used to find saddr when adding non gw nh

Olivier Moysan (1):
      iio: adc: stm32-adc: fix channel sampling time init

Palmer Dabbelt (2):
      MAINTAINERS: git://github.com -> https://github.com for sifive
      MAINTAINERS: git://github.com -> https://github.com for nilfs2

Paolo Abeni (3):
      mptcp: set msk local address earlier
      mptcp: factor out mptcp_connect()
      mptcp: fix abba deadlock on fastopen

Patrice Chotard (1):
      usb: dwc3: st: Rely on child's compatible instead of name

Patrick Thompson (1):
      mmc: sdhci-pci-core: Disable ES for ASUS BIOS on Jasper Lake

Paul Blakey (1):
      net/mlx5e: Update restore chain id for slow path packets

Paul E. McKenney (1):
      rcu: Keep synchronize_rcu() from enabling irqs in early boot

Pavel Kozlov (1):
      ARC: mm: fix leakage of memory allocated for PTE

Peter Oberparleiter (2):
      s390/boot: add secure boot trailer
      s390/cio: fix out-of-bounds access on cio_ignore free

Peter Ujfalusi (1):
      Revert "ASoC: soc-component: using pm_runtime_resume_and_get
instead of pm_runtime_get_sync"

Peter Xu (1):
      mm/uffd: fix vma check on userfault for wp

Phillip Lougher (3):
      squashfs: fix read regression introduced in readahead code
      squashfs: fix extending readahead beyond end of file
      squashfs: fix buffer release race condition in readahead code

Pierre-Louis Bossart (3):
      ASoC: Intel: sof_sdw: add quirk variant for LAPBC710 NUC15
      ASoC: SOF: Intel: pci-mtl: fix firmware name
      ASoC: SOF: Intel: pci-tgl: fix ADL-N descriptor

Prike Liang (2):
      drm/amdkfd: update gfx1037 Lx cache setting
      drm/amdgpu: disallow gfxoff until GC IP blocks complete s2idle resume

Qinglin Pan (1):
      riscv: mm: add missing memcpy in kasan_init

Raed Salem (4):
      net/mlx5e: Fix macsec coverity issue at rx sa update
      net/mlx5e: Fix macsec rx security association (SA) update/delete
      net/mlx5e: Fix wrong bitwise comparison usage in
macsec_fs_rx_add_rule function
      net/mlx5e: Fix macsec sci endianness at rx sa update

Rafael J. Wysocki (3):
      rtc: cmos: Fix wake alarm breakage
      cpufreq: intel_pstate: Read all MSRs on the target CPU
      cpufreq: intel_pstate: hybrid: Use known scaling factor for P-cores

Rafael Mendonca (2):
      scsi: qla2xxx: Fix serialization of DCBX TLV data request
      drm/amdkfd: Fix memory leak in kfd_mem_dmamap_userptr()

Rafa=C5=82 Mi=C5=82ecki (2):
      mtd: core: add missing of_node_get() in dynamic partitions code
      net: broadcom: bcm4908_enet: update TX stats after actual transmissio=
n

Raju Rangoju (5):
      amd-xgbe: Yellow carp devices do not need rrc
      amd-xgbe: use enums for mailbox cmd and sub_cmds
      amd-xgbe: enable PLL_CTL for fixed PHY modes only
      amd-xgbe: fix the SFP compliance codes check for DAC cables
      amd-xgbe: add the bit rate quirk for Molex cables

Randy Dunlap (3):
      ASoC: codec: tlv320adc3xxx: add GPIOLIB dependency
      arc: iounmap() arg is volatile
      ASoC: qcom: SND_SOC_SC7180 optionally depends on SOUNDWIRE

Ravi Bangoria (1):
      perf/mem: Rename PERF_MEM_LVLNUM_EXTN_MEM to PERF_MEM_LVLNUM_CXL

Ricardo Ca=C3=B1uelo (3):
      selftests/futex: fix build for clang
      selftests/intel_pstate: fix build for ARCH=3Dx86_64
      selftests/kexec: fix build for ARCH=3Dx86_64

Rik van Riel (1):
      mm,madvise,hugetlb: fix unexpected data loss with MADV_DONTNEED
on hugetlbfs

Rob Clark (4):
      drm/msm/gem: Unpin objects slightly later
      drm/msm/a6xx: Fix kvzalloc vs state_kcalloc usage
      drm/msm/a6xx: Skip snapshotting unused GMU buffers
      drm/msm/a6xx: Remove state objects from list before freeing

Robert Marko (1):
      spi: qup: support using GPIO as chip select line

Rodrigo Siqueira (1):
      drm/amd/display: Remove wrong pipe control lock

Roi Dayan (1):
      net/mlx5e: TC, Fix cloned flow attr instance dests are not zeroed

Rolf Eike Beer (1):
      rhashtable: make test actually random

Rongwei Liu (1):
      net/mlx5: DR, Fix matcher disconnect error flow

Roy Novich (1):
      net/mlx5: Update fw fatal reporter state on PCI handlers
successful recover

Saeed Mahameed (1):
      net/mlx5: ASO, Create the ASO SQ with the correct timestamp format

Sagi Grimberg (1):
      nvme-tcp: fix possible circular locking when deleting a
controller under memory pressure

Sai Krishna Potthuri (2):
      Revert "pinctrl: pinctrl-zynqmp: Add support for output-enable
and bias-high-impedance"
      Revert "dt-bindings: pinctrl-zynqmp: Add output-enable configuration"

Sascha Hauer (1):
      mmc: sdhci-esdhc-imx: Propagate ESDHC_FLAG_HS400* only on 8bit bus

Sean Anderson (1):
      net: fman: Use physical address for userspace interfaces

Sebastian Andrzej Siewior (1):
      mm: multi-gen LRU: move lru_gen_add_mm() out of IRQ-off region

Serge Semin (1):
      arc: dts: Harmonize EHCI/OHCI DT nodes name

Sergiu Moga (1):
      net: macb: Specify PHY PM management done by MAC

Shang XiaoJing (3):
      scsi: ufs: qcom: Remove redundant dev_err() call
      nfc: virtual_ncidev: Fix memory leak in virtual_nci_send()
      perf vendor events arm64: Fix incorrect Hisi hip08 L3 metrics

Shreeya Patel (1):
      iio: light: tsl2583: Fix module unloading

Shuming Fan (2):
      ASoC: rt1308-sdw: update the preset settings
      ASoC: rt1308-sdw: add the default value of some registers

Siarhei Volkau (5):
      pinctrl: Ingenic: JZ4755 bug fixes
      ASoC: codecs: jz4725b: add missed Line In power control bit
      ASoC: codecs: jz4725b: fix reported volume for Master ctl
      ASoC: codecs: jz4725b: use right control for Capture Volume
      ASoC: codecs: jz4725b: fix capture selector naming

Slawomir Laba (2):
      i40e: Fix ethtool rx-flow-hash setting for X722
      i40e: Fix flow-type by setting GL_HASH_INSET registers

Sreekanth Reddy (1):
      scsi: mpt3sas: re-do lost mpt3sas DMA mask fix

Srinivasa Rao Mandadapu (2):
      ASoC: qcom: lpass-cpu: mark HDMI TX registers as volatile
      ASoC: qcom: lpass-cpu: Mark HDMI TX parity register as volatile

Stanislav Fomichev (2):
      selftests/bpf: Add reproducer for decl_tag in func_proto return type
      bpf: prevent decl_tag from being referenced in func_proto

Stefan Binding (1):
      ALSA: hda/realtek: Add quirk for ASUS Zenbook using CS35L41

Steven Rostedt (Google) (2):
      x86/mm: Do not verify W^X at boot up
      ALSA: Use del_timer_sync() before freeing timer

Sudeep Holla (2):
      coresight: Fix possible deadlock with lock dependency
      PM: domains: Fix handling of unavailable/disabled idle states

Suresh Devarakonda (1):
      net/mlx5: Fix crash during sync firmware reset

Sven Schnelle (1):
      selftests/ftrace: fix dynamic_events dependency check

Svyatoslav Ryhel (1):
      gpio: tegra: Convert to immutable irq chip

Sylwester Dziedziuch (1):
      i40e: Fix VF hang when reset is triggered on another VF

Takashi Iwai (3):
      ALSA: usb-audio: Add quirks for M-Audio Fast Track C400/600
      ALSA: hda/realtek: Add another HP ZBook G9 model quirks
      ALSA: aoa: Fix I2S device accounting

Tamim Khan (1):
      ACPI: resource: Skip IRQ override on Asus Vivobook S5602ZA

Tariq Toukan (1):
      net/mlx5: Fix possible use-after-free in async command interface

Thinh Nguyen (3):
      usb: dwc3: gadget: Don't delay End Transfer on delayed_status
      usb: dwc3: gadget: Stop processing more requests on IMI
      usb: dwc3: gadget: Don't set IMI for no_interrupt

Thomas Richter (2):
      perf list: Fix PMU name pai_crypto in perf list on s390
      s390/pai: fix raw data collection for PMU pai_ext

Todd Brandt (1):
      pm-graph v5.10

Tony O'Brien (1):
      mtd: rawnand: marvell: Use correct logic for nand-keep-config

Uwe Kleine-K=C3=B6nig (2):
      fbdev: da8xx-fb: Fix error handling in .remove()
      fbdev: xilinxfb: Make xilinxfb_release() return void

Vincent Whitchurch (1):
      mmc: core: Fix WRITE_ZEROES CQE handling

Vladimir Oltean (1):
      net: enetc: survive memory pressure without crashing

Waiman Long (1):
      mm/kmemleak: prevent soft lockup in kmemleak_scan()'s object
iteration loops

Wei Yongjun (1):
      net: ieee802154: fix error return code in dgram_bind()

William Breathitt Gray (3):
      counter: Reduce DEFINE_COUNTER_ARRAY_POLARITY() to defining counter_a=
rray
      counter: microchip-tcb-capture: Handle Signal1 read and Synapse
      counter: 104-quad-8: Fix race getting function mode and direction

Xiaolei Wang (1):
      ASoC: wm8962: Add an event handler for TEMP_HP and TEMP_SPK

Xin Long (2):
      tipc: fix a null-ptr-deref in tipc_topsrv_accept
      ethtool: eeprom: fix null-deref on genl_info in dump

Xuezhi Zhang (2):
      fbdev: sm501fb: Convert sysfs snprintf to sysfs_emit
      fbdev: gbefb: Convert sysfs snprintf to sysfs_emit

Yang Yingliang (13):
      ALSA: hda/realtek: simplify the return of comp_bind()
      mtd: rawnand: intel: Add missing of_node_put() in ebu_nand_probe()
      ALSA: ac97: fix possible memory leak in snd_ac97_dev_register()
      net: netsec: fix error handling in netsec_register_mdio()
      ASoC: Intel: Skylake: fix possible memory leak in skl_codec_device_in=
it()
      ASoC: SOF: Intel: hda-codec: fix possible memory leak in
hda_codec_device_init()
      net: ksz884x: fix missing pci_disable_device() on error in pcidev_ini=
t()
      ALSA: aoa: i2sbus: fix possible memory leak in i2sbus_add_dev()
      net: ehea: fix possible memory leak in ehea_register_port()
      can: j1939: transport: j1939_session_skb_drop_old():
spin_unlock_irqrestore() before kfree_skb()
      rbd: fix possible memory leak in rbd_sysfs_init()
      fbdev: cyber2000fb: fix missing pci_disable_device()
      platform/loongarch: laptop: Fix possible UAF and simplify
generic_acpi_laptop_init()

Yinjun Zhang (1):
      nfp: only clean `sp_indiff` when application firmware is unloaded

Yiqing Yao (1):
      drm/amdgpu: Adjust MES polling timeout for sriov

Yong Zhi (1):
      ASoC: Intel: sof_rt5682: Add quirk for Rex board

Yu Kuai (1):
      block: fix memory leak for elevator on add_disk failure

YuBiao Wang (1):
      drm/amdgpu: skip mes self test for gc 11.0.3 in recover

Yushan Zhou (1):
      LoongArch: Use flexible-array member instead of zero-length array

Zeng Heng (1):
      cifs: fix use-after-free caused by invalid pointer `hostname`

Zhang Changzhong (1):
      net: lantiq_etop: don't free skb when returning NETDEV_TX_BUSY

Zhang Jiaming (1):
      ARC: Fix comment typo

Zhang Qilong (8):
      ASoC: wm8997: Fix PM disable depth imbalance in wm8997_probe
      ASoC: wm5110: Fix PM disable depth imbalance in wm5110_probe
      ASoC: wm5102: Fix PM disable depth imbalance in wm5102_probe
      ASoC: wm5102: Revert "ASoC: wm5102: Fix PM disable depth
imbalance in wm5102_probe"
      ASoC: wm5110: Revert "ASoC: wm5110: Fix PM disable depth
imbalance in wm5110_probe"
      ASoC: wm8997: Revert "ASoC: wm8997: Fix PM disable depth
imbalance in wm8997_probe"
      ASoC: mt6660: Keep the pm_runtime enables before component stuff
in mt6660_i2c_probe
      mtd: rawnand: tegra: Fix PM disable depth imbalance in probe

Zhang Rui (2):
      perf/x86/rapl: Add support for Intel AlderLake-N
      perf/x86/rapl: Add support for Intel Raptor Lake

Zhang Xiaoxu (2):
      cifs: Fix pages array leak when writedata alloc failed in
cifs_writedata_alloc()
      cifs: Fix pages leak when writedata alloc failed in cifs_write_from_i=
ter()

Zhao Gongyi (1):
      selftests/memory-hotplug: Remove the redundant warning information

Zhengchao Shao (8):
      net: hinic: fix incorrect assignment issue in hinic_set_interrupt_cfg=
()
      net: hinic: fix memory leak when reading function table
      net: hinic: fix the issue of CMDQ memory leaks
      net: hinic: fix the issue of double release MBOX callback of VF
      net: fix UAF issue in nfqnl_nf_hook_drop() when ops_init() failed
      netdevsim: fix memory leak in nsim_bus_dev_new()
      netdevsim: fix memory leak in nsim_drv_probe() when
nsim_dev_resources_register() failed
      netdevsim: remove dir in nsim_dev_debugfs_init() when creating
ports dir failed

linkt (1):
      ASoC: amd: yc: Adding Lenovo ThinkBook 14 Gen 4+ ARA and Lenovo
ThinkBook 16 Gen 4+ ARA to the Quirks List

=C3=8D=C3=B1igo Huguet (1):
      atlantic: fix deadlock at aq_nic_stop
