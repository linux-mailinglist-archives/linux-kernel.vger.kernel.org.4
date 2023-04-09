Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8052C6DC100
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 20:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjDIS2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 14:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDIS2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 14:28:17 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050A92D5F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 11:28:15 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id f26so1887977ejb.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 11:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1681064893; x=1683656893;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LL0MdahLv+L6lgDoKK4OgKG4ph7LleIPasl5MSrE4Ak=;
        b=eYVuXydxCptFh57Hr9H21SWpi/ieJvKHoAIpsfIxtbdjCT0NNtltlxcf7gzbmWXS+s
         XmyBTIG1IJOgYnoQcATqL0/F0HPldQ0uBifv7x7geSzNpBx36e+uq0bv3Amh6qLPw8Gb
         +K0ri0HSemfHnKF581uTVam1zXpDDBNFkfAp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681064893; x=1683656893;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LL0MdahLv+L6lgDoKK4OgKG4ph7LleIPasl5MSrE4Ak=;
        b=I/hE3JWlOuad7cvONDJdV7GsHtVzyC4Nm6n6H3CPvL9q2MYtFkSkUzHjve5GEvUxAZ
         hJOOEsQja86Mv+fafhb90UvyA6CT+XNlDTbPOHnW4wvcjnlikzyCvR2x4v2XPGqbK6Id
         7DhlVxrQul3krSrfPE9Q57798muRT+p/cQdjQkkzS7jDexJ91BFhcsdkdVtgWZSiaVGS
         dKjlJHnROLzHBj+Mm5tIkeutVxiVHlBU5mlJXmWvIcrf6MtZwMWVa4j+NQaNeRYR8XWK
         3E5G8oA25N6XGYAvWjWuK1AFpxm0C2N1yhxN5cvdxUiVB/ehpZGPHUwC69qUodi6hTWC
         iFjA==
X-Gm-Message-State: AAQBX9ccEESGn1+j9J545mB8JsVX0fIudsU9s5nDLE4k5ZS28sknho/X
        dZHSprCIvi7guQBHwUzNSgOdiVnUy2p0cc0S3gAsMQ==
X-Google-Smtp-Source: AKy350Zpy9Z3mj14y4tlbiei90GYvU0zSgUsqwHOXXet0+4IULbrQFjjwLENNYagQhD3CeEI7/eX/Q==
X-Received: by 2002:a17:906:339b:b0:94a:6f0d:567e with SMTP id v27-20020a170906339b00b0094a6f0d567emr1655290eja.56.1681064892959;
        Sun, 09 Apr 2023 11:28:12 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id g19-20020a1709065d1300b00928e0ea53e5sm4300142ejt.84.2023.04.09.11.28.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 11:28:12 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id gb34so8187737ejc.12
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 11:28:12 -0700 (PDT)
X-Received: by 2002:a17:907:7282:b0:8e5:411d:4d09 with SMTP id
 dt2-20020a170907728200b008e5411d4d09mr2569121ejc.15.1681064891988; Sun, 09
 Apr 2023 11:28:11 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Apr 2023 11:27:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=_UHtmSy-3jB0ZJ7sAPULLy4a86HP3DpYX-C3eu+wpg@mail.gmail.com>
Message-ID: <CAHk-=wi=_UHtmSy-3jB0ZJ7sAPULLy4a86HP3DpYX-C3eu+wpg@mail.gmail.com>
Subject: Linux 6.3-rc6
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

It's Easter Sunday, which means that we're all about to gorge on m=C3=A4mmi
(Right? You *do* have your carton of m=C3=A4mmi ready to go, don't you?).

But before the festivities can begin, we still need to take care of
business: Sunday still means another release candidate. Those rascally
(and biologically confused) egg-laying rabbits must not distract us
from kernel development.

Things continue to look pretty regular - some subsystems may have been
pointing at spring break as a possible cause of slowdown, but nothing
here looks all that unusual. Not even unusually slow.

Shortlog appended,

              Linus

---

Adrien Thierry (1):
      scsi: Revert "scsi: ufs: core: Initialize devfreq synchronously"

Alexey Kardashevskiy (1):
      KVM: PPC: Make KVM_CAP_IRQFD_RESAMPLE platform dependent

Alistair Popple (1):
      mm: take a page reference when removing device exclusive entries

Andrea Righi (1):
      l2tp: generate correct module alias strings

Andy Chi (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for a HP ProBook

Andy Roulin (1):
      ethtool: reset #lanes when lanes is omitted

Andy Shevchenko (1):
      iio: adc: qcom-spmi-adc5: Fix the channel name

Anh Tuan Phan (1):
      selftests mount: Fix mount_setattr_test builds failed

Ard Biesheuvel (1):
      arm64: compat: Work around uninitialized variable warning

Armin Wolf (1):
      platform/x86: think-lmi: Fix memory leak when showing current setting=
s

Arnd Bergmann (3):
      iio: adis16480: select CONFIG_CRC32
      net: netcp: MAX_SKB_FRAGS is now 'int'
      asm-generic: avoid __generic_cmpxchg_local warnings

Arseniy Krasnov (1):
      vsock/vmci: convert VMCI error code to -ENOMEM on send

Ben Greear (1):
      wifi: mt76: mt7921: Fix use-after-free in fw features query.

Benjamin Asbach (1):
      platform/x86: thinkpad_acpi: Add missing T14s Gen1 type to
s2idle quirk list

Biju Das (2):
      tty: serial: sh-sci: Fix transmit end interrupt handler
      tty: serial: sh-sci: Fix Rx on RZ/G2L SCI

Bj=C3=B8rn Mork (1):
      USB: serial: option: add Quectel RM500U-CN modem

Bobby Eshleman (1):
      virtio/vsock: fix leaks due to missing skb owner

Boris Brezillon (1):
      drm/panfrost: Fix the panfrost_mmu_map_fault_addr() error path

Christian Brauner (1):
      fs: drop peer group ids under namespace lock

Chuck Lever (2):
      NFSD: Avoid calling OPDESC() with ops->opnum =3D=3D OP_ILLEGAL
      NFS: Remove "select RPCSEC_GSS_KRB5

Corinna Vinschen (1):
      net: stmmac: fix up RX flow hash indirection table when setting chann=
els

D Scott Phillips (1):
      xhci: also avoid the XHCI_ZERO_64B_REGS quirk with a passthrough iomm=
u

Dai Ngo (1):
      NFSD: callback request does not use correct credential for AUTH_SYS

Dan Carpenter (1):
      cifs: double lock in cifs_reconnect_tcon()

Dan Williams (7):
      cxl/hdm: Fix double allocation of @cxlhdm
      cxl/hdm: Skip emulation when driver manages mem_enable
      cxl/port: Fix find_cxl_root() for RCDs and simplify it
      cxl/region: Fix region setup/teardown for RCDs
      cxl/region: Move coherence tracking into cxl_region_attach()
      cxl/hdm: Limit emulation to the number of range registers
      cxl/hdm: Extend DVSEC range register emulation for region enumeration

Daniel Bristot de Oliveira (2):
      tracing/timerlat: Notify new max thread latency
      tracing/osnoise: Fix notify new tracing_max_latency

Daniel Golle (1):
      net: sfp: add quirk enabling 2500Base-x for HG MXPD-483II

Daniele Ceraolo Spurio (1):
      drm/i915/huc: Cancel HuC delayed load timer on reset.

Dhruva Gole (2):
      gpio: davinci: Do not clear the bank intr enable bit in save_context
      gpio: davinci: Add irq chip flag to skip set wake

Dmytro Maluka (2):
      KVM: irqfd: Make resampler_list an RCU list
      KVM: x86/ioapic: Resample the pending state of an IRQ when unmasking

Duy Nguyen (1):
      ASoC: da7213.c: add missing pm_runtime_disable()

Enrico Sau (1):
      USB: serial: option: add Telit FE990 compositions

Eric DeVolder (1):
      x86/acpi/boot: Correct acpi_is_processor_usable() check

Eric Dumazet (2):
      icmp: guard against too small mtu
      netlink: annotate lockless accesses to nlk->max_recvmsg_len

Eugene Huang (2):
      ASOC: Intel: sof_sdw: add quirk for Intel 'Rooks County' NUC M15
      ASoC: Intel: soc-acpi: add table for Intel 'Rooks County' NUC M15

Felix Fietkau (8):
      wifi: mac80211: drop bogus static keywords in A-MSDU rx
      wifi: mac80211: fix potential null pointer dereference
      wifi: mac80211: fix receiving mesh packets in forwarding=3D0 networks
      wifi: mac80211: fix mesh forwarding
      wifi: mac80211: fix flow dissection for forwarded packets
      wifi: mac80211: fix invalid drv_sta_pre_rcu_remove calls for
non-uploaded sta
      net: ethernet: mtk_eth_soc: fix remaining throughput regression
      wifi: mt76: ignore key disable commands

Florian Fainelli (1):
      mailmap: add an entry for Leonard Crestez

Ge-org Brohammer (1):
      ASoC: amd: yc: Add DMI entries to support Victus by HP Laptop
16-e1xxx (8A22)

Geert Uytterhoeven (1):
      dt-bindings: serial: renesas,scif: Fix 4th IRQ for 4-IRQ SCIFs

Greg Ungerer (1):
      net: fec: make use of MDIO C45 quirk

Guennadi Liakhovetski (1):
      ASoC: SOF: avoid a NULL dereference with unsupported widgets

Gustav Ekelund (1):
      net: dsa: mv88e6xxx: Reset mv88e6393x force WD event bit

Hangbin Liu (1):
      selftests: net: rps_default_mask.sh: delete veth link specifically

Hans de Goede (6):
      ASoC: Intel: bytcr_rt5640: Add quirk for the Acer Iconia One 7 B1-750
      wifi: brcmfmac: Fix SDIO suspend/resume regression
      ACPI: video: Add auto_detect arg to __acpi_video_get_backlight_type()
      ACPI: video: Make acpi_backlight=3Dvideo work independent from GPU dr=
iver
      ACPI: video: Add acpi_backlight=3Dvideo quirk for Apple iMac14,1
and iMac14,2
      ACPI: video: Add acpi_backlight=3Dvideo quirk for Lenovo ThinkPad W53=
0

Heikki Krogerus (1):
      usb: dwc3: pci: add support for the Intel Meteor Lake-S

Ian Ray (1):
      drivers: iio: adc: ltc2497: fix LSB shift

Ilpo J=C3=A4rvinen (1):
      serial: 8250: Prevent starting up DMA Rx on THRI interrupt

Jacek Lawrynowicz (1):
      accel/ivpu: Fix S3 system suspend when not idle

Jakub Kicinski (2):
      Revert "net: netcp: MAX_SKB_FRAGS is now 'int'"
      net: don't let netpoll invoke NAPI if in xmit context

Jason Gunthorpe (3):
      iommufd: Check for uptr overflow
      iommufd: Fix unpinning of pages when an access is present
      iommufd: Do not corrupt the pfn list when doing batch carry

Jason Montleon (1):
      ASoC: hdac_hdmi: use set_stream() instead of set_tdm_slots()

Jeff Layton (2):
      nfsd: call op_release, even when op_func returns an error
      sunrpc: only free unix grouplist after RCU settles

Jens Axboe (1):
      ublk: read any SQE values upfront

Jeremi Piotrowski (1):
      KVM: SVM: Flush Hyper-V TLB when required

Jeremy Soller (1):
      ALSA: hda/realtek: Add quirk for Clevo X370SNW

Jiri Slaby (SUSE) (1):
      net: wwan: t7xx: do not compile with -Werror

John Keeping (1):
      ftrace: Mark get_lock_parent_ip() __always_inline

Kai-Heng Feng (1):
      iio: light: cm32181: Unregister second I2C client if present

Kalle Valo (1):
      wifi: ath11k: reduce the MHI timeout to 20s

Kan Liang (1):
      perf/core: Fix the same task check in perf_event_set_output

Karol Herbst (1):
      drm/nouveau/disp: Support more modes by checking with lower bpc

Karol Wachowski (1):
      accel/ivpu: Add dma fence to command buffers only

Kees Jan Koster (1):
      USB: serial: cp210x: add Silicon Labs IFS-USB-DATACABLE IDs

Keith Busch (2):
      blk-mq: directly poll requests
      nvme: fix discard support without oncs

Kuniyuki Iwashima (2):
      raw: Fix NULL deref in raw_get_next().
      ping: Fix potentail NULL deref for /proc/net/icmp.

Lars-Peter Clausen (1):
      iio: adc: ti-ads7950: Set `can_sleep` flag for GPIO chip

Leonard G=C3=B6hrs (1):
      .mailmap: add entry for Leonard G=C3=B6hrs

Li Zetao (1):
      scsi: qla2xxx: Fix memory leak in qla2x00_probe_one()

Liam Howlett (4):
      maple_tree: be more cautious about dead nodes
      maple_tree: detect dead nodes in mas_start()
      maple_tree: fix freeing of nodes in rcu mode
      maple_tree: remove extra smp_wmb() from mas_dead_leaves()

Liam R. Howlett (4):
      maple_tree: fix write memory barrier of nodes once dead for RCU mode
      maple_tree: add smp_rmb() to dead node detection
      maple_tree: add RCU lock checking to rcu callback functions
      mm: enable maple tree RCU mode by default

Lingyu Liu (1):
      ice: Reset FDIR counter in FDIR init stage

Linus Torvalds (1):
      Linux 6.3-rc6

Lorenzo Bianconi (1):
      wifi: mt76: mt7921: fix fw used for offload check for mt7922

Lukas Wunner (6):
      cxl/pci: Fix CDAT retrieval on big endian
      cxl/pci: Handle truncated CDAT header
      cxl/pci: Handle truncated CDAT entries
      cxl/pci: Handle excessive CDAT length
      PCI/DOE: Silence WARN splat with CONFIG_DEBUG_OBJECTS=3Dy
      PCI/DOE: Fix memory leak with CONFIG_DEBUG_OBJECTS=3Dy

Mario Limonciello (1):
      x86/ACPI/boot: Use FADT version to check support for online capable

Marios Makassikis (1):
      ksmbd: do not call kvmalloc() with __GFP_NORETRY | __GFP_NO_WARN

Mark Pearson (2):
      platform/x86: think-lmi: Fix memory leaks when parsing
ThinkStation WMI strings
      platform/x86: think-lmi: Clean up display of current_value on Thinkst=
ation

Mathias Nyman (2):
      Revert "usb: xhci-pci: Set PROBE_PREFER_ASYNCHRONOUS"
      xhci: Free the command allocated for setting LPM if we return early

Matthew Auld (1):
      drm/i915/ttm: fix sparse warning

Mehdi Djait (1):
      iio: accel: kionix-kx022a: Get the timestamp from the driver's
private data in the trigger_handler

Michael Kelley (1):
      x86/hyperv: Block root partition functionality in a Confidential VM

Michael Sit Wei Hong (4):
      net: phylink: add phylink_expects_phy() method
      net: stmmac: check if MAC needs to attach to a PHY
      net: stmmac: remove redundant fixup to support fixed-link mode
      net: stmmac: check fwnode for phy device before scanning for phy

Michal Sojka (1):
      can: isotp: isotp_ops: fix poll() to not report false EPOLLOUT events

Min Li (1):
      drm/i915: fix race condition UAF in i915_perf_add_config_ioctl

Ming Lei (1):
      block: ublk: make sure that block size is set correctly

Mohammed Gamal (1):
      Drivers: vmbus: Check for channel allocation before looking up relids

Muchun Song (2):
      mm: kfence: fix PG_slab and memcg_data clearing
      mm: kfence: fix handling discontiguous page

M=C3=A5rten Lindahl (1):
      iio: light: vcnl4000: Fix WARN_ON on uninitialized lock

Namjae Jeon (2):
      ksmbd: delete asynchronous work from list
      ksmbd: fix slab-out-of-bounds in init_smb2_rsp_hdr

Nico Boehr (1):
      KVM: s390: pv: fix external interruption loop not always detected

Nuno S=C3=A1 (4):
      iio: buffer: correctly return bytes written in output buffers
      iio: buffer: make sure O_NONBLOCK is respected
      iio: adc: ad7791: fix IRQ flags
      iio: adc: max11410: fix read_poll_timeout() usage

Oleksij Rempel (1):
      can: j1939: j1939_tp_tx_dat_new(): fix out-of-bounds memory access

Oliver Hartkopp (2):
      can: isotp: isotp_recvmsg(): use sock_recv_cmsgs() to get
SOCK_RXQ_OVFL infos
      can: isotp: fix race between isotp_sendsmg() and isotp_release()

Patrik Dahlstr=C3=B6m (1):
      iio: adc: palmas_gpadc: fix NULL dereference on rmmod

Pawel Laszczak (1):
      usb: cdnsp: Fixes error: uninitialized symbol 'len'

Peng Zhang (2):
      maple_tree: fix get wrong data_end in mtree_lookup_walk()
      maple_tree: fix a potential concurrency bug in RCU mode

Peter Xu (1):
      mm/hugetlb: fix uffd wr-protection for CoW optimization path

Peter Zijlstra (1):
      perf: Optimize perf_pmu_migrate_context()

Petr Tesarik (1):
      swiotlb: fix a braino in the alignment check fix

RD Babiera (1):
      usb: typec: altmodes/displayport: Fix configure initial pin assignmen=
t

Randy Dunlap (1):
      gpio: GPIO_REGMAP: select REGMAP instead of depending on it

Ranjan Kumar (1):
      scsi: mpi3mr: Handle soft reset in progress fault code (0xF002)

Ranjani Sridharan (1):
      ASoC: SOF: ipc4: Ensure DSP is in D0I0 during sof_ipc4_set_get_data()

Rongwei Wang (1):
      mm/swap: fix swap_info_struct race between swapoff and get_swap_pages=
()

Ryder Lee (1):
      wifi: mac80211: fix the size calculation of ieee80211_ie_len_eht_cap(=
)

Ryusuke Konishi (2):
      nilfs2: fix potential UAF of struct nilfs_sc_info in
nilfs_segctor_thread()
      nilfs2: fix sysfs interface lifetime

Sandeep Dhavale (2):
      usb: gadget: f_fs: Fix ffs_epfile_read_iter to handle ITER_UBUF
      usb: gadgetfs: Fix ep_read_iter to handle ITER_UBUF

Sean Christopherson (3):
      KVM: x86: Suppress pending MMIO write exits if emulator detects excep=
tion
      KVM: x86: Clear "has_error_code", not "error_code", for RM
exception injection
      KVM: nVMX: Do not report error code when synthesizing VM-Exit
from Real Mode

Sergey Senozhatsky (2):
      zsmalloc: document new fullness grouping
      zsmalloc: document freeable stats

Shailend Chand (1):
      gve: Secure enough bytes in the first TX desc for all TCP pkts

Shengjiu Wang (1):
      ASoC: soc-pcm: fix hw->formats cleared by soc_pcm_hw_init() for dpcm

Sherry Sun (2):
      tty: serial: fsl_lpuart: avoid checking for transfer complete
when UARTCTRL_SBK is asserted in lpuart32_tx_empty
      tty: serial: fsl_lpuart: fix crash in lpuart_uport_is_active

Shiyang Ruan (3):
      fsdax: unshare: zero destination if srcmap is HOLE or UNWRITTEN
      fsdax: dedupe should compare the min of two iters' length
      fsdax: force clear dirty mark if CoW

Siddharth Vadapalli (1):
      net: ethernet: ti: am65-cpsw: Fix mdio cleanup in probe

Simei Su (1):
      ice: fix wrong fallback logic for FDIR

Song Yoong Siang (1):
      net: stmmac: Add queue reset into stmmac_xdp_open() function

Sricharan Ramabadhran (1):
      net: qrtr: Do not do DEL_SERVER broadcast after DEL_CLIENT

Srinivas Kandagatla (1):
      ASoC: codecs: lpass: fix the order or clks turn off during suspend

Stanislav Lisovskiy (1):
      drm/i915: Use compressed bpp when calculating m/n value for DP MST DS=
C

Steve Clevenger (1):
      coresight-etm4: Fix for() loop drvdata->nr_addr_cmp range bug

Steven Rostedt (Google) (5):
      tracing: Error if a trace event has an array for a __field()
      tracing: Have tracing_snapshot_instance_cond() write errors to
the appropriate instance
      tracing: Fix ftrace_boot_snapshot command line logic
      tracing: Free error logs of tracing instances
      tracing/synthetic: Make lastcmd_mutex static

Suzuki K Poulose (1):
      coresight: etm4x: Do not access TRCIDR1 for identification

Takahiro Itazuri (1):
      docs: kvm: x86: Fix broken field list

Takashi Iwai (1):
      ALSA: hda/hdmi: Preserve the previous PCM device upon re-enablement

Tetsuo Handa (1):
      nilfs2: initialize "struct nilfs_binfo_dat"->bi_pad field

Thiago Rafael Becker (1):
      cifs: sanitize paths in cifs_update_super_prepath.

Tiezhu Yang (1):
      lib/Kconfig.debug: correct help info of LOCKDEP_STACK_TRACE_HASH_BITS

Tom Rix (1):
      ksmbd: remove unused is_char_allowed function

Tony Luck (1):
      x86/cpu: Add model number for Intel Arrow Lake processor

Tvrtko Ursulin (1):
      drm/i915: Fix context runtime accounting

Tze-nan Wu (1):
      tracing/synthetic: Fix races on freeing last_cmd

Uwe Kleine-K=C3=B6nig (6):
      pwm: hibvt: Explicitly set .polarity in .get_state()
      pwm: cros-ec: Explicitly set .polarity in .get_state()
      pwm: iqs620a: Explicitly set .polarity in .get_state()
      pwm: sprd: Explicitly set .polarity in .get_state()
      pwm: meson: Explicitly set .polarity in .get_state()
      pwm: Zero-initialize the pwm_state passed to driver's .get_state()

Vladimir Oltean (2):
      asm-generic/io.h: suppress endianness warnings for readq() and writeq=
()
      asm-generic/io.h: suppress endianness warnings for relaxed accessors

Wayne Chang (1):
      usb: xhci: tegra: fix sleep in atomic call

William Breathitt Gray (3):
      iio: dac: cio-dac: Fix max DAC write value check for 12-bit
      counter: 104-quad-8: Fix race condition between FLAG and CNTR reads
      counter: 104-quad-8: Fix Synapse action reported for Index signals

Wojciech Lukowicz (2):
      io_uring: fix return value when removing provided buffers
      io_uring: fix memory leak when removing provided buffers

Xin Long (1):
      sctp: check send stream number after wait_for_sndbuf

Yafang Shao (1):
      mm: vmalloc: avoid warn_alloc noise caused by fatal signal

Yu Kuai (1):
      block: don't set GD_NEED_PART_SCAN if scan partition failed

Zheng Yejian (2):
      ring-buffer: Fix race while reader and writer are on the same page
      ftrace: Fix issue that 'direct->addr' not restored in
modify_ftrace_direct()

Zhong Jinghua (1):
      scsi: iscsi_tcp: Check that sock is valid before iscsi_set_param()

Ziyang Xuan (2):
      net: qrtr: Fix a refcount bug in qrtr_recvmsg()
      ipv6: Fix an uninit variable access bug in __ip6_make_skb()

ye xingchen (1):
      Kconfig.debug: fix SCHED_DEBUG dependency
