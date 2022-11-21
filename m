Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329D363179C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 01:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiKUA0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 19:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiKUA0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 19:26:31 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473C320F47
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 16:26:29 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id cz18so787165qvb.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 16:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xYUuLC7w+40o7I6wW/YgLG9LWUUeG8gRBM448aA9Jd8=;
        b=LgiXdGj2Hlx8k+vk+dftidxbXLgiFWAt6V5aqfbFpM32D+yAswFbDXF/9ewi2OCgkA
         2IAHJmOmcPDmRhTsxyL7buLXduvEHEMR9rZzBzxsjg/yZeSx6iQWna79pA+sUeoP7wY9
         /0sE6XplmT4DMulm+ln8W6pZ7nVNkFE/dA1ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYUuLC7w+40o7I6wW/YgLG9LWUUeG8gRBM448aA9Jd8=;
        b=aW8wmclPiLVNBMLgFgMj6oZ+TEURBr08Wghblo/M2nE9OXl8u1ifV7Pgf2y16a22sB
         m4uHaslm5nMQ6x27gx9rWApFTqNxe6RQM/yK5Frhk1zmmc0O8r+29Pyn8z8KVarG1PDu
         K+0FXDcTRdPP/Mx1EX//yiBd+lyjwoitn/ZfFWDsUZFr0XN+67n4gR07GOr386tmtQ5k
         uT2XXumF6N2jBc0F5CSmKg7Euk2W0qg5ZS0rEaH9aXXUaQhZtYvbcoJBPTqk3SP9v3Me
         842OBIJ1TTnm1rUITcAFkm0iLc0y+H3ZblH0bE3OnjuF/9fE3cQzQWdgMBIQmdqXlp5N
         vW4g==
X-Gm-Message-State: ANoB5plcuOtg9miyYwgbVKb5VM/1jsNmT6m7dpfAK5y+niTN3NZGYX/F
        6xCqNl/va+GO6ILAVpgg/ug9KTWeNJmqTQ==
X-Google-Smtp-Source: AA0mqf65yX1UwiUUEjaaa6zQ9x/wgKT+p1UGZ6KpXnlWSIDO3N3jUsHb2vnW1Duwvv7/cO0cvWgZHg==
X-Received: by 2002:a05:6214:310b:b0:4bb:5714:1d2e with SMTP id ks11-20020a056214310b00b004bb57141d2emr15268750qvb.42.1668990387571;
        Sun, 20 Nov 2022 16:26:27 -0800 (PST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id a11-20020ac8108b000000b0035d08c1da35sm5859146qtj.45.2022.11.20.16.26.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 16:26:26 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id s20so7121733qkg.5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 16:26:26 -0800 (PST)
X-Received: by 2002:a37:8883:0:b0:6fb:628a:1aea with SMTP id
 k125-20020a378883000000b006fb628a1aeamr14701933qkd.697.1668990386012; Sun, 20
 Nov 2022 16:26:26 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Nov 2022 16:26:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjKJyzfJmOzBdEOqCFRc8Fh-rdGM4tvMXfW0WXbbHwV0w@mail.gmail.com>
Message-ID: <CAHk-=wjKJyzfJmOzBdEOqCFRc8Fh-rdGM4tvMXfW0WXbbHwV0w@mail.gmail.com>
Subject: Linux 6.1-rc6
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

So here we are at rc6 and the story hasn't changed: this rc is still a
bit larger than I would have preferred, but at the same time there's
nothing that looks scary or particularly odd in here.

It's predominantly driver changes all over, with networking and gpu
drivers (not surprisingly) leading the pack, but it's really a fairly
mixed bag.

Outside of drivers you have the usual smattering of core kernel code -
architecture updates, some filesystem work, and some core kernel and
networking.

It's easy enough to scan through the appended shortlog and get a
feeling for what's going on. Absolutely nothing that makes me worried,
apart just from the fact that there's still a fair number of them. I'm
still waffling about whether there will be an rc8 or not, leaning a
bit towards it happening. We'll see - it will make the 6.2 merge
window leak into the holidays, but maybe that's fine and just makes
people make sure they have everything lined up and ready *before* the
merge window opens, the way things _should_ work.

So we'll see. Nothing worrisome, just 300+ small fixes in the last
week. Please go test,

               Linus

---

Aashish Sharma (1):
      tracing: Fix warning on variable 'struct trace_array'

Adam Borowski (1):
      mtd: rawnand: placate "$VARIABLE is used uninitialized" warnings

Adrian Hunter (1):
      perf/x86/intel/pt: Fix sampling using single range output

Aishwarya Kothari (1):
      drm/panel: simple: set bpc field for logic technologies displays

Akira Yokosawa (1):
      docs/driver-api/miscellaneous: Remove kernel-doc of serial_core.c

Alban Crequy (2):
      maccess: Fix writing offset in case of fault in
strncpy_from_kernel_nofault()
      selftests: bpf: Add a test when bpf_probe_read_kernel_str() returns E=
FAULT

Alex Deucher (1):
      drm/amdgpu: there is no vbios fb on devices with no display hw (v2)

Alexander Potapenko (1):
      misc/vmw_vmci: fix an infoleak in vmci_host_do_receive_datagram()

Alexander Stein (1):
      arm64: dts: imx8mm-tqma8mqml-mba8mx: Fix USB DR

Alexandru Tachici (1):
      net: usb: smsc95xx: fix external PHY reset

Aman Dhoot (1):
      Input: synaptics - switch touchpad on HP Laptop 15-da3001TU to RMI mo=
de

Aminuddin Jamaluddin (1):
      net: phy: marvell: add sleep time after enabling the loopback bit

Amit Cohen (1):
      mlxsw: Avoid warnings when not offloaded FDB entry with IPv6 is remov=
ed

Anastasia Belova (2):
      cifs: add check for returning value of SMB2_close_init
      cifs: add check for returning value of SMB2_set_info_init

AngeloGioacchino Del Regno (2):
      pinctrl: mediatek: common-v2: Fix bias-disable for PULL_PU_PD_RSEL_TY=
PE
      pinctrl: mediatek: Fix EINT pins input debounce time configuration

Anjana Hari (1):
      pinctrl: qcom: sc8280xp: Rectify UFS reset pins

Anthony DeRossi (3):
      vfio: Fix container device registration life cycle
      vfio: Export the device set open count
      vfio/pci: Check the device set open count on reset

Arnav Rawat (1):
      platform/x86: ideapad-laptop: Fix interrupt storm on fn-lock
toggle on some Yoga laptops

Baisong Zhong (1):
      bpf, test_run: Fix alignment problem in bpf_prog_test_run_skb()

Bean Huo (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Micron Nitro

Benjamin Block (1):
      scsi: zfcp: Fix double free of FSF request when qdio send fails

Beno=C3=AEt Monin (1):
      USB: serial: option: add Sierra Wireless EM9191

Borislav Petkov (1):
      x86/cpu: Restore AMD's DE_CFG MSR after resume

Borys Pop=C5=82awski (1):
      x86/sgx: Add overflow check in sgx_validate_offset_length()

Brent Mendelsohn (1):
      ASoC: amd: yc: Add Alienware m17 R5 AMD into DMI table

Brian Masney (1):
      arm64: dts: qcom: sc8280xp: correct ref clock for ufs_mem_phy

Brian Norris (1):
      firmware: coreboot: Register bus in module init

Candice Li (1):
      drm/amdgpu: Add psp_13_0_10_ta firmware to modinfo

Carlos Llamas (1):
      binder: validate alloc->mm in ->mmap() handler

Chen Jun (1):
      Input: i8042 - fix leaking of platform device on module removal

Chen Zhongjin (2):
      ASoC: core: Fix use-after-free in snd_soc_exit()
      ASoC: soc-utils: Remove __exit for snd_soc_util_exit()

Chevron Li (1):
      mmc: sdhci-pci-o2micro: fix card detect fail issue caused by CD#
debounce timeout

Chris Mason (1):
      blk-cgroup: properly pin the parent in blkcg_css_online

Christian K=C3=B6nig (1):
      drm/amdgpu: use the last IB as gang leader v2

Christian Lamparter (1):
      nvmem: u-boot-env: fix crc32_data_offset on redundant u-boot-env

Christian Marangi (1):
      mtd: rawnand: qcom: handle ret from parse with codeword_fixup

Christophe JAILLET (1):
      x86/xen: Use kstrtobool() instead of strtobool()

Chuang Wang (1):
      net: macvlan: Use built-in RCU list checking

Chuck Lever (1):
      NFSD: Fix trace_nfsd_fh_verify_err() crasher

Claudiu Beznea (2):
      iio: adc: at91-sama5d2_adc: get rid of 5 degrees Celsius adjustment
      ARM: at91: pm: avoid soft resetting AC DLL

Cong Wang (1):
      kcm: close race conditions on sk_receive_queue

Conor Dooley (4):
      MAINTAINERS: add entries for misc. RISC-V SoC drivers and devicetrees
      MAINTAINERS: generify the Microchip RISC-V entry name
      MAINTAINERS: add an entry for StarFive devicetrees
      MAINTAINERS: repair Microchip corei2c driver entry

Damien Le Moal (2):
      zonefs: fix zone report size in __zonefs_io_error()
      zonefs: Remove to_attr() helper function

Dan Carpenter (3):
      iio: imu: bno055: uninitialized variable bug in bno055_trigger_handle=
r()
      ceph: fix a NULL vs IS_ERR() check when calling ceph_lookup_inode()
      drbd: use after free in drbd_create_device()

Daniil Tatianin (1):
      ring_buffer: Do not deactivate non-existant pages

David Howells (2):
      netfs: Fix missing xas_retry() calls in xarray iteration
      netfs: Fix dodgy maths

Davide Tronchin (3):
      USB: serial: option: remove old LARA-R6 PID
      USB: serial: option: add u-blox LARA-R6 00B modem
      USB: serial: option: add u-blox LARA-L6 modem

Dillon Varone (3):
      drm/amd/display: Fix prefetch calculations for dcn32
      drm/amd/display: use uclk pstate latency for fw assisted mclk
validation dcn32
      drm/amd/display: Set max for prefetch lines on dcn32

Dmitry Baryshkov (1):
      Revert "arm64: dts: qcom: msm8996: add missing TCSR syscon compatible=
"

Dong Chenchen (1):
      drm/amdgpu: Fix memory leak in amdgpu_cs_pass1

Douglas Anderson (6):
      arm64: dts: qcom: sa8155p-adp: Specify which LDO modes are allowed
      arm64: dts: qcom: sa8295p-adp: Specify which LDO modes are allowed
      arm64: dts: qcom: sc8280xp-crd: Specify which LDO modes are allowed
      arm64: dts: qcom: sm8150-xperia-kumano: Specify which LDO modes
are allowed
      arm64: dts: qcom: sm8250-xperia-edo: Specify which LDO modes are allo=
wed
      arm64: dts: qcom: sm8350-hdk: Specify which LDO modes are allowed

Duoming Zhou (2):
      tty: n_gsm: fix sleep-in-atomic-context bug in gsm_control_send
      usb: chipidea: fix deadlock in ci_otg_del_timer

Emil Flink (1):
      ALSA: hda/realtek: fix speakers for Samsung Galaxy Book Pro

Enrico Sau (1):
      net: usb: qmi_wwan: add Telit 0x103a composition

Eric Huang (1):
      drm/amdkfd: Fix a memory limit issue

Erico Nunes (1):
      drm/lima: Fix opp clkname setting in case of missing regulator

Evan Quan (3):
      drm/amd/pm: enable runpm support over BACO for SMU13.0.0
      drm/amd/pm: enable runpm support over BACO for SMU13.0.7
      drm/amd/pm: fix SMU13 runpm hang due to unintentional workaround

Fedor Pchelkin (2):
      Revert "tty: n_gsm: avoid call of sleeping functions from atomic cont=
ext"
      Revert "tty: n_gsm: replace kicktimer with delayed_work"

Gaosheng Cui (2):
      drm/vc4: kms: Fix IS_ERR() vs NULL check for vc4_kms
      bnxt_en: Remove debugfs when pci_register_driver failed

George Shen (2):
      drm/amd/display: Support parsing VRAM info v3.0 from VBIOS
      drm/amd/display: Fix calculation for cursor CAB allocation

Gerald Schaefer (1):
      s390/dcssblk: fix deadlock when adding a DCSS

Gleb Mazovetskiy (1):
      tcp: configurable source port perturb table size

Guangbin Huang (1):
      net: hns3: fix setting incorrect phy link ksettings for firmware
in resetting process

Guchun Chen (1):
      drm/amdgpu: disable BACO support on more cards

Guo Jin (1):
      locking: Fix qspinlock/x86 inline asm error

Hangbin Liu (1):
      net: use struct_group to copy ip/ipv6 header addresses

Hans de Goede (6):
      ASoC: Intel: bytcht_es8316: Add quirk for the Nanote UMPC-01
      Input: goodix - try resetting the controller when no config is set
      Input: soc_button_array - add use_low_level_irq module parameter
      Input: soc_button_array - add Acer Switch V 10 to dmi_use_low_level_i=
rq[]
      platform/x86: acer-wmi: Enable SW_TABLET_MODE on Switch V 10 (SW5-017=
)
      platform/x86: ideapad-laptop: Add module parameters to match DMI
quirk tables

Horatiu Vultur (2):
      ARM: dts: lan966x: Enable sgpio on pcb8291
      nvmem: lan9662-otp: Fix compatible string

Ido Schimmel (1):
      bridge: switchdev: Fix memory leaks when changing VLAN protocol

Ilpo J=C3=A4rvinen (4):
      serial: 8250: Fall back to non-DMA Rx if IIR_RDI occurs
      serial: 8250_lpss: Configure DMA also w/o DMA filter
      serial: 8250_lpss: Use 16B DMA burst with Elkhart Lake
      serial: 8250: Flush DMA Rx on RLSI

Jaco Coetzee (1):
      nfp: change eeprom length to max length enumerators

Jakub Sitnicki (1):
      l2tp: Serialize access to sk_user_data with sk_callback_lock

Janne Grunau (1):
      usb: dwc3: Do not get extcon device when usb-role-switch is used

Jason A. Donenfeld (1):
      staging: rtl8192e: remove bogus ssid character sign test

Jason Montleon (2):
      ASoC: rt5514: fix legacy dai naming
      ASoC: rt5677: fix legacy dai naming

Jeremy Kerr (1):
      mctp i2c: don't count unused / invalid keys for flow release

Jian Shen (1):
      net: hns3: fix incorrect hw rss hash type of rx packet

Jie Wang (1):
      net: hns3: fix return value check bug of rx copybreak

Jingbo Xu (4):
      erofs: put metabuf in error path in fscache mode
      erofs: get correct count for unmapped range in fscache mode
      erofs: fix use-after-free of fsid and domain_id string
      erofs: fix missing xas_retry() in fscache mode

Johan Hovold (7):
      arm64: dts: qcom: sc8280xp: fix ufs_card_phy ref clock
      arm64: dts: qcom: sc8280xp: fix USB0 PHY PCS_MISC registers
      arm64: dts: qcom: sc8280xp: fix USB1 PHY RX1 registers
      arm64: dts: qcom: sc8280xp: fix USB PHY PCS registers
      arm64: dts: qcom: sc8280xp: drop broken DP PHY nodes
      arm64: dts: qcom: sc8280xp: fix UFS PHY serdes size
      Revert "usb: dwc3: disable USB core PHY management"

Jonathan Cameron (1):
      iio: accel: bma400: Ensure VDDIO is enable defore reading the chip ID=
.

Juergen Gross (1):
      xen/platform-pci: use define instead of literal number

Kai Vehmanen (1):
      ASoC: SOF: ipc3-topology: use old pipeline teardown flow with
SOF2.1 and older

Kai-Heng Feng (1):
      platform/x86: hp-wmi: Ignore Smart Experience App event

Keith Busch (5):
      block: make dma_alignment a stacking queue_limit
      dm-crypt: provide dma_alignment limit in io_hints
      block: make blk_set_default_limits() private
      dm-integrity: set dma_alignment limit in io_hints
      dm-log-writes: set dma_alignment limit in io_hints

Krzysztof Kozlowski (2):
      mtd: onenand: omap2: add dependency on GPMC
      slimbus: stream: correct presence rate frequencies

Lennard G=C3=A4her (1):
      platform/x86: thinkpad_acpi: Enable s2idle quirk for 21A1 machine typ=
e

Li Huafei (1):
      kprobes: Skip clearing aggrprobe's post_handler in kprobe-on-ftrace c=
ase

Li Jun (1):
      usb: cdns3: host: fix endless superspeed hub port reset

Linus Torvalds (1):
      Linux 6.1-rc6

Linus Walleij (2):
      USB: bcma: Make GPIO explicitly optional
      pinctrl: mediatek: Export debounce time tables

Liu Jian (1):
      net: ag71xx: call phylink_disconnect_phy if ag71xx_hw_enable()
fail in ag71xx_open()

Liu Shixin (1):
      arm64/mm: fix incorrect file_map_count for non-leaf pmd/pud

Lukas Wunner (1):
      serial: 8250: 8250_omap: Avoid RS485 RTS glitch on ->set_termios()

Maarten Zanders (1):
      ASoC: fsl_asrc fsl_esai fsl_sai: allow CONFIG_PM=3DN

Maciej W. Rozycki (1):
      parport_pc: Avoid FIFO port location truncation

Marc Zyngier (1):
      kbuild: Restore .version auto-increment behaviour for Debian packages

Marco Elver (1):
      perf: Improve missing SIGTRAP checking

Marek Marczykowski-G=C3=B3recki (1):
      xen-pciback: Allow setting PCI_MSIX_FLAGS_MASKALL too

Marek Vasut (3):
      ARM: dts: imx7: Fix NAND controller size-cells
      arm64: dts: imx8mm: Fix NAND controller size-cells
      arm64: dts: imx8mn: Fix NAND controller size-cells

Mario Limonciello (1):
      platform/x86/amd: pmc: Remove more CONFIG_DEBUG_FS checks

Martin Povi=C5=A1er (3):
      ASoC: tas2770: Fix set_tdm_slot in case of single slot
      ASoC: tas2764: Fix set_tdm_slot in case of single slot
      ASoC: tas2780: Fix set_tdm_slot in case of single slot

Masami Hiramatsu (Google) (1):
      tracing/eprobe: Fix eprobe filter to make a filter correctly

Mathieu Desnoyers (1):
      rseq: Use pr_warn_once() when deprecated/unknown ABI flags are encoun=
tered

Matthew Auld (1):
      drm/i915/ttm: fix uaf with lmem_userfault_list handling

Matthias Schiffer (1):
      serial: 8250_omap: remove wait loop from Errata i202 workaround

Matti Vaittinen (1):
      tools: iio: iio_generic_buffer: Fix read size

Maximilian Luz (3):
      platform/surface: aggregator: Do not check for repeated
unsequenced packets
      platform/surface: aggregator_registry: Add support for Surface Pro 9
      platform/surface: aggregator_registry: Add support for Surface Laptop=
 5

Mel Gorman (1):
      x86/fpu: Drop fpregs lock before inheriting FPU permissions

Melissa Wen (1):
      drm/amd/display: don't enable DRM CRTC degamma property for DCE

Michael Sit Wei Hong (1):
      net: phy: dp83867: Fix SGMII FIFO depth for non OF devices

Mihai Sain (1):
      ARM: dts: at91: sama7g5: fix signal name of pin PB2

Mikulas Patocka (3):
      dm ioctl: fix misbehavior if list_versions races with module loading
      dm integrity: flush the journal on suspend
      dm integrity: clear the journal on suspend

Mitja Spes (2):
      iio: pressure: ms5611: fixed value compensation bug
      iio: pressure: ms5611: changed hardcoded SPI speed to value limited

Mohd Faizal Abdul Rahim (1):
      net: stmmac: ensure tx function is not running in stmmac_xdp_release(=
)

Mushahid Hussain (1):
      speakup: fix a segfault caused by switching consoles

Nathan Chancellor (1):
      bpf: Add explicit cast to 'void *' for __BPF_DISPATCHER_UPDATE()

Nicholas Piggin (1):
      powerpc: Fix writable sections being moved into the rodata region

Nicolas Dumazet (1):
      usb: add NO_LPM quirk for Realforce 87U Keyboard

Nicolas Schier (3):
      MAINTAINERS: Add Nathan and Nicolas to Kbuild reviewers
      MAINTAINERS: Remove Michal Marek from Kbuild maintainers
      MAINTAINERS: Add linux-kbuild's patchwork

Olivier Moysan (1):
      ASoC: stm32: dfsdm: manage cb buffers cleanup

Palmer Dabbelt (2):
      MAINTAINERS: git://github.com -> https://github.com for ceph
      MAINTAINERS: git://github.com -> https://github.com for HiSilicon

Paul Cercueil (1):
      ASoC: dapm: Don't use prefix for regulator name

Pavel Begunkov (5):
      io_uring: update res mask in io_poll_check_events
      io_uring: fix tw losing poll events
      io_uring: fix multishot accept request leaks
      io_uring: fix multishot recv request leaks
      io_uring: disallow self-propelled ring polling

Peng Fan (1):
      arm64: dts: imx93-pinfunc: drop execution permission

Peter Ujfalusi (1):
      ASoC: SOF: topology: No need to assign core ID if token parsing faile=
d

Peter Zijlstra (3):
      bpf: Revert ("Fix dispatcher patchable function entry to 5 bytes nop"=
)
      bpf: Convert BPF_DISPATCHER to use static_call() (not ftrace)
      sched: Fix race in task_call_func()

Petr Vorel (1):
      kernel/utsname_sysctl.c: Add missing enum uts_proc value

Pierre-Louis Bossart (2):
      ASoC: Intel: soc-acpi: add ES83x6 support to IceLake
      ASoC: hda: intel-dsp-config: add ES83x6 quirk for IceLake

Pu Lehui (1):
      selftests/bpf: Fix casting error when cross-compiling
test_verifier for 32-bit platforms

Qiujun Huang (1):
      tracing: Remove unused __bad_type_size() method

Quentin Schulz (1):
      pinctrl: rockchip: list all pins in a possible mux route for PX30

Rafael Mendonca (2):
      tracing/eprobe: Fix memory leak of filter string
      tracing/eprobe: Fix warning in filter creation

Rajat Khandelwal (1):
      usb: typec: mux: Enter safe mode only when pins need to be reconfigur=
ed

Ravi Bangoria (1):
      perf/x86/amd: Fix crash due to race between amd_pmu_enable_all,
perf NMI and throttling

Reinhard Speyerer (1):
      USB: serial: option: add Fibocom FM160 0x0111 composition

Robert Marko (1):
      arm64: dts: qcom: ipq8074: correct APCS register space size

Robin Murphy (1):
      gpu: host1x: Avoid trying to use GART on Tegra20

Rodrigo Siqueira (1):
      drm/amd/display: Add HUBP surface flip interrupt handler

Roger Pau Monn=C3=A9 (1):
      platform/x86/intel: pmc: Don't unconditionally attach Intel PMC
when virtualized

Roman Li (1):
      drm/amd/display: Fix optc2_configure warning on dcn314

Sagi Grimberg (1):
      nvmet: fix a memory leak in nvmet_auth_set_key

Sami Tolvanen (1):
      arm64: ftrace: Define ftrace_stub_graph only with FUNCTION_GRAPH_TRAC=
ER

Sandipan Das (1):
      perf/x86/amd/uncore: Fix memory leak for events array

Saravanan Sekar (2):
      iio: adc: mp2629: fix wrong comparison of channel
      iio: adc: mp2629: fix potential array out of bound access

Satya Priya (1):
      arm64: dts: qcom: sc7280: Add the reset reg for lpass audiocc on SC72=
80

Shang XiaoJing (8):
      drm/drv: Fix potential memory leak in drm_dev_init()
      drm: Fix potential null-ptr-deref in drm_vblank_destroy_worker()
      net: lan966x: Fix potential null-ptr-deref in lan966x_stats_init()
      net: microchip: sparx5: Fix potential null-ptr-deref in
sparx_stats_init() and sparx5_start()
      tracing: Fix memory leak in test_gen_synth_cmd() and
test_empty_synth_event()
      tracing: Fix wild-memory-access in register_synth_event()
      tracing: kprobe: Fix potential null-ptr-deref on
trace_event_file in kprobe_event_gen_test_exit()
      tracing: kprobe: Fix potential null-ptr-deref on trace_array in
kprobe_event_gen_test_exit()

Shawn Guo (1):
      serial: imx: Add missing .thaw_noirq hook

Sheng-Liang Pan (1):
      dt-bindings: input: touchscreen: Add compatible for Goodix GT7986U ch=
ip

Sherry Sun (1):
      tty: serial: fsl_lpuart: don't break the on-going transfer when
global reset

Shin'ichiro Kawasaki (1):
      scsi: mpi3mr: Suppress command reply debug prints

Shuah Khan (1):
      docs: update mediator contact information in CoC doc

Shyam Sundar S K (1):
      platform/x86/amd: pmc: Add new ACPI ID AMDI0009

Simon Rettberg (1):
      drm/display: Don't assume dual mode adaptors support i2c sub-addressi=
ng

Simon Ser (1):
      Revert "drm: hide unregistered connectors from GETCONNECTOR IOCTL"

Steven Rostedt (Google) (3):
      tracing/ring-buffer: Have polling block on watermark
      ring-buffer: Include dropped pages in counting dirty patches
      tracing: Fix race where eprobes can be called before the event

Stylon Wang (2):
      drm/amd/display: Fix access timeout to DPIA AUX at boot time
      drm/amd/display: Fix invalid DPIA AUX reply causing system hang

Sven Peter (1):
      usb: typec: tipd: Prevent uninitialized event{1,2} in IRQ handler

Takashi Iwai (3):
      Input: i8042 - apply probe defer to more ASUS ZenBook models
      ALSA: usb-audio: Drop snd_BUG_ON() from snd_usbmidi_output_open()
      ALSA: hda/realtek: Fix the speaker output on Samsung Galaxy Book Pro =
360

Tejun Heo (1):
      kernfs: Fix spurious lockdep warning in kernfs_find_and_get_node_by_i=
d()

Tetsuo Handa (1):
      Input: iforce - invert valid length check when fetching device IDs

Thinh Nguyen (1):
      usb: dwc3: gadget: Return -ESHUTDOWN on ep disable

Tiago Dias Ferreira (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Netac NV7000

Tina Zhang (2):
      iommu/vt-d: Preset Access bit for IOVA in FL non-leaf paging entries
      iommu/vt-d: Set SRE bit only when hardware has SRS cap

Tony Lindgren (3):
      serial: 8250: omap: Fix missing PM runtime calls for omap8250_set_mct=
rl()
      serial: 8250: omap: Fix unpaired pm_runtime_put_sync() in
omap8250_remove()
      serial: 8250: omap: Flush PM QOS work on remove

Tzung-Bi Shih (1):
      MAINTAINERS: update Tzung-Bi's email address

Ulf Hansson (1):
      arm64: dts: qcom: sm8250: Disable the not yet supported cluster idle =
state

Vasily Gorbik (1):
      s390: avoid using global register for current_stack_pointer

Vladimir Oltean (2):
      net: dsa: make dsa_master_ioctl() see through port_hwtstamp_get() shi=
ms
      net: dsa: don't leak tagger-owned storage on switch driver unbind

Wang ShaoBo (1):
      mISDN: fix misuse of put_device() in mISDN_register_device()

Wang Wensheng (2):
      ftrace: Fix the possible incorrect kernel message
      ftrace: Optimize the allocation for mcount entries

Wang Yufen (3):
      bpf: Fix memory leaks in __check_func_call
      netdevsim: Fix memory leak of nsim_dev->fa_cookie
      tracing: Fix memory leak in tracing_read_pipe()

Wei Yongjun (3):
      net: bgmac: Drop free_netdev() from bgmac_enet_remove()
      net: mhi: Fix memory leak in mhi_net_dellink()
      net/x25: Fix skb leak in x25_lapb_receive_frame()

Xiaolei Wang (1):
      soc: imx8m: Enable OCOTP clock before reading the register

Xiongfeng Wang (2):
      platform/x86: asus-wmi: add missing pci_dev_put() in
asus_wmi_set_xusb2pr()
      mmc: sdhci-pci: Fix possible memory leak caused by missing pci_dev_pu=
t()

Xiu Jianfeng (1):
      ftrace: Fix null pointer dereference in ftrace_add_mod()

Xiubo Li (2):
      ceph: avoid putting the realm twice when decoding snaps fails
      ceph: fix NULL pointer dereference for req->r_session

Xu Kuohai (2):
      bpf: Initialize same number of free nodes for each pcpu_freelist
      bpf: Fix offset calculation error in __copy_map_value and zero_map_va=
lue

Yang Jihong (1):
      selftests/bpf: Fix test_progs compilation failure in 32-bit arch

Yang Yingliang (6):
      iio: trigger: sysfs: fix possible memory leak in iio_sysfs_trig_init(=
)
      iio: adc: at91_adc: fix possible memory leak in
at91_adc_allocate_trigger()
      siox: fix possible memory leak in siox_device_add()
      mISDN: fix possible memory leak in mISDN_dsp_element_register()
      xen/pcpu: fix possible memory leak in register_pcpu()
      scsi: target: tcm_loop: Fix possible name leak in tcm_loop_setup_hba_=
bus()

Yann Gautier (1):
      mmc: core: properly select voltage range without power cycle

Yassine Oudjana (1):
      extcon: usbc-tusb320: Call the Type-C IRQ handler only if a port
is registered

Yi Yang (1):
      rethook: fix a potential memleak in rethook_alloc()

Yu Liao (1):
      net/tls: Fix memory leak in tls_enc_skb() and tls_sw_fallback_init()

Yuan Can (5):
      net: hinic: Fix error handling in hinic_module_init()
      net: ionic: Fix error handling in ionic_init_module()
      net: ena: Fix error handling in ena_init()
      net: thunderbolt: Fix error handling in tbnet_init()
      scsi: scsi_debug: Fix possible UAF in sdebug_add_host_helper()

Yue Hu (1):
      erofs: fix general protection fault when reading fragment

Zeng Heng (1):
      pinctrl: devicetree: fix null pointer dereferencing in pinctrl_dt_to_=
map

Zhang Xiaoxu (2):
      cifs: Fix connections leak when tlink setup failed
      cifs: Fix wrong return value checking when GETFLAGS

Zheng Bin (1):
      slimbus: qcom-ngd: Fix build error when
CONFIG_SLIM_QCOM_NGD_CTRL=3Dy && CONFIG_QCOM_RPROC_COMMON=3Dm

Zheng Yejian (1):
      tracing: Fix potential null-pointer-access of entry in list 'tr->err_=
log'

Zhengchao Shao (2):
      net: liquidio: release resources when liquidio driver open failed
      net: caif: fix double disconnect client in chnl_net_open()

Zhihao Cheng (1):
      dm bufio: Fix missing decrement of no_sleep_enabled if
dm_bufio_client_create failed

Zhou Guanghui (1):
      scsi: iscsi: Fix possible memory leak when device_register() failed

Zhu Ning (1):
      ASoC: sof_es8336: reduce pop noise on speaker

Ziyang Xuan (4):
      octeon_ep: delete unnecessary napi rollback under set_queues_err
in octep_open()
      octeon_ep: ensure octep_get_link_status() successfully before
octep_link_up()
      octeon_ep: fix potential memory leak in octep_device_setup()
      octeon_ep: ensure get mac address successfully before eth_hw_addr_set=
()

ruanjinjie (1):
      xen/platform-pci: add missing free_irq() in error path

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh (1):
      speakup: replace utils' u_char with unsigned char
