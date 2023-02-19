Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E637669C2F9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 23:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjBSWn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 17:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjBSWnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 17:43:24 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63AACC3B
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 14:43:22 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id ek25so5008763edb.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 14:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zZYD43YrgycQ7ZCRDwG7E8h4epGRuQR4FZE48eTG7bA=;
        b=GX3d29xKeBA6FTodoHPSBpn5iSRiaAi5xj3DmFms73MibPZjNkoBAcrdHm7sjORvzj
         B8SvUtKyuJ/95szedIWmjNgtuCPm1mbbvGGIY5DCrr7x/XhtA85d/HLEM7q6B4MEQQB2
         6tKc6sAI+cPoAweEtK+xt2xf1+ACGILBUjo8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZYD43YrgycQ7ZCRDwG7E8h4epGRuQR4FZE48eTG7bA=;
        b=Cqb0rE9lzDVeO/BuZAFa3crJQvBLsRDTxwq0cV4nZwaWofqkge/hZdmCWEGEeE0GLV
         /0RTiZ0xR5ulXUBGBDhNKKxi1KlqeLNsnD9SaSiXU2sqAXRjyjVIkSBXUXurcjTXzigY
         +G2dyF7JebreKC2WbbbXgJl73M9qltGofeUC890iYeDnm4emjcRZ5tS9t0qWkcI5/9d6
         NccjM3lJoqfYiaLGAznNOipTfF5xQ+Ughu9QGp8z4DfjiTPMOANylVgpCcEa042iDRjp
         RPtOOMzuUGc0K6zkLEB4MGMe+13+znGDCsCCi4FRQnxXy3xFyx2NIQuOaTc/rPiBOG3R
         5mBw==
X-Gm-Message-State: AO0yUKV36ornUqoDP1/HOKegWFxfrnf3ifLS9gVqAVR49Zph9YUWt9zk
        70qdHTvR0e6gFe0liO6azDJDBSci/o5sK72kFcw=
X-Google-Smtp-Source: AK7set8o1DG134oV2FMG7KbSNng+xA5OiNOenzUzE6nSBiVl7t6DhCBbYiDsHKqwMV5jFU5jNioNyg==
X-Received: by 2002:a17:906:db07:b0:88d:ba89:1853 with SMTP id xj7-20020a170906db0700b0088dba891853mr4556690ejb.36.1676846600868;
        Sun, 19 Feb 2023 14:43:20 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id zc18-20020a170906989200b008cae50b0115sm1236432ejb.87.2023.02.19.14.43.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Feb 2023 14:43:20 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id dk16so4853160edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 14:43:20 -0800 (PST)
X-Received: by 2002:a50:f614:0:b0:4ab:c702:65a with SMTP id
 c20-20020a50f614000000b004abc702065amr554237edn.5.1676846599526; Sun, 19 Feb
 2023 14:43:19 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Feb 2023 14:43:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wio46vC4t6xXD-sFqjoPwFm_u515jm3suzmkGxQTeA1_A@mail.gmail.com>
Message-ID: <CAHk-=wio46vC4t6xXD-sFqjoPwFm_u515jm3suzmkGxQTeA1_A@mail.gmail.com>
Subject: Linux 6.2
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

So here we are, right on (the extended) schedule, with 6.2 out.

Nothing unexpected happened last week, with just a random selection of
small fixes spread all over, with nothing really standing out. The
shortlog is tiny and appended below, you can scroll through it if
you're bored.

Wed have a couple of small things that Thorsten was tracking on the
regression side, but I wasn't going to apply any last-minute patches
that weren't actively pushed by maintainers, so they will have to show
up for stable. Nothing seemed even remotely worth trying to delay
things for.

And this obviously means that the 6.3 merge window will open tomorrow,
and I already have 30+ pull requests queued up, which I really
appreciate. I like how people have started to take the whole "ready
for the merge window" to heart.

But in the meantime, please do give 6.2 a testing. Maybe it's not a
sexy LTS release like 6.1 ended up being, but all those regular
pedestrian kernels want some test love too.

         Linus

---

Alexander Mikhalitsyn (1):
      mailmap: add entry for Alexander Mikhalitsyn

Alexander Stein (1):
      gpio: vf610: make irq_chip immutable

Andrew Morton (1):
      revert "squashfs: harden sanity check in squashfs_read_xattr_id_table=
"

Andy Chi (2):
      ALSA: hda/realtek: fix mute/micmute LEDs don't work for a HP platform=
.
      ALSA: hda/realtek: Enable mute/micmute LEDs and speaker support
for HP Laptops

Anna Schumaker (1):
      Revert "NFSv4.2: Change the default KConfig value for READ_PLUS"

Arnd Bergmann (1):
      mm: extend max struct page size for kmsan

Bartosz Golaszewski (1):
      gpio: sim: fix a memory leak

Benjamin Gray (1):
      powerpc/64s: Prevent fallthrough to hash TLB flush when using radix

Bo Liu (1):
      ALSA: hda/conexant: add a new hda codec SN6180

Cezary Rojewski (1):
      ALSA: hda: Fix codec device field initializan

Christoph Hellwig (3):
      nvme-pci: set the DMA mask earlier
      orphan sysvfs
      stop mainaining UUID

Christophe Leroy (1):
      kasan: fix Oops due to missing calls to kasan_arch_is_ready()

Corinna Vinschen (1):
      igb: conditionalize I2C bit banging on external thermal sensor suppor=
t

Cristian Ciocaltea (1):
      net: stmmac: Restrict warning on disabling DMA store and fwd mode

Daniel Wagner (1):
      nvme-pci: add bogus ID quirk for ADATA SX6000PNP

Dave Stevenson (1):
      drm/vc4: Fix YUV plane handling when planes are in different buffers

Dom Cobley (2):
      drm/vc4: hdmi: Always enable GCP with AVMUTE cleared
      drm/vc4: crtc: Increase setup cost in core clock calculation to
handle extreme reduced blanking

Eric Dumazet (2):
      net: initialize net->notrefcnt_tracker earlier
      net: use a bounce buffer for copying skb->mark

Felix Riemann (1):
      net: Fix unwanted sign extension in netdev_stats_to_stats64()

Gayatri Kammela (1):
      platform/x86/intel/vsec: Add support for Meteor Lake

Greg Kroah-Hartman (1):
      kvm: initialize all of the kvm_debugregs structure before
sending it to userspace

Guillaume Nault (3):
      ipv6: Fix datagram socket connection with DSCP.
      ipv6: Fix tcp socket connection with DSCP.
      selftests: fib_rule_tests: Test UDP and TCP connections with DSCP rul=
es.

Hangyu Hua (1):
      net: openvswitch: fix possible memory leak in ovs_meter_cmd_set()

Heiner Kallweit (1):
      mmc: meson-gx: fix SDIO mode if cap_sdio_irq isn't set

Hyunwoo Kim (1):
      af_key: Fix heap information leak

Ido Schimmel (1):
      devlink: Fix netdev notifier chain corruption

Irvin Cote (1):
      nvme-pci: always return an ERR_PTR from nvme_pci_alloc_dev

Isaac J. Manjarres (1):
      of: reserved_mem: Have kmemleak ignore dynamically allocated reserved=
 mem

Jack Xiao (1):
      drm/amd/amdgpu: fix warning during suspend

Jakub Kicinski (1):
      net: mpls: fix stale pointer if allocation fails during device rename

Janne Grunau (1):
      spi: Use a 32-bit DT property for spi-cs-setup-delay-ns

Jason Xing (3):
      ixgbe: allow to increase MTU to 3K with XDP enabled
      i40e: add double of VLAN header when computing the max MTU
      ixgbe: add double of VLAN header when computing the max MTU

Jeff Layton (1):
      nfsd: don't destroy global nfs4_file table in per-net shutdown

Jeff Xie (1):
      scripts/gdb: fix 'lx-current' for x86

Jesse Brandeburg (1):
      ice: fix lost multicast packets in promisc mode

Jocelyn Falempe (1):
      drm/ast: Fix start address computation

Johannes Zink (1):
      net: stmmac: fix order of dwmac5 FlexPPS parametrization sequence

John Johansen (1):
      apparmor: Fix regression in compat permissions for getattr

Juergen Gross (1):
      x86/mtrr: Revert 90b926e68f50 ("x86/pat: Fix pat_x_mtrr_type()
for MTRR disabled case")

Kailang Yang (1):
      ALSA: hda/realtek - fixed wrong gpio assigned

Kefeng Wang (1):
      mm: hwpoison: support recovery from ksm_might_need_to_copy()

Keith Busch (1):
      nvme-pci: refresh visible attrs for cmb attributes

Kuan-Ying Lee (1):
      mm/gup: add folio to list when folio_isolate_lru() succeed

Kuniyuki Iwashima (2):
      dccp/tcp: Avoid negative sk_forward_alloc by ipv6_pinfo.pktoptions.
      net: Remove WARN_ON_ONCE(sk->sk_forward_alloc) from
sk_stream_kill_queues().

Larysa Zaremba (1):
      ice: xsk: Fix cleaning of XDP_TX frames

Leo Li (1):
      drm/amd/display: Fail atomic_check early on normalize_zpos error

Li Lingfeng (1):
      lib: parser: optimize match_NUMBER apis to use local array

Linus Torvalds (1):
      Linux 6.2

Linus Walleij (1):
      gpio: mlxbf2: select GPIOLIB_IRQCHIP

Manivannan Sadhasivam (1):
      cpufreq: qcom-hw: Add missing null pointer check

Mark Rutland (2):
      arm_pmu: fix event CPU filtering
      arm64: perf: reject CHAIN events at creation time

Matt Roper (1):
      drm/i915/gen11: Wa_1408615072/Wa_1407596294 should be on GT list

Michael Chan (1):
      bnxt_en: Fix mqprio and XDP ring checking logic

Michal Wilczynski (1):
      ice: Fix check for weight and priority of a scheduling node

Mike Kravetz (1):
      hugetlb: check for undefined shift on 32 bit architectures

Miko Larsson (1):
      net/usb: kalmia: Don't pass act_len in usb_bulk_msg error path

Miroslav Lichvar (1):
      igb: Fix PPS input and output using 3rd and 4th SDP

Munehisa Kamata (1):
      sched/psi: Fix use-after-free in ep_remove_wait_queue()

Natalia Petrova (1):
      i40e: Add checking for null for nlmsg_find_attr()

Paolo Bonzini (1):
      Documentation/hw-vuln: Fix rST warning

Patrick McLean (1):
      ata: libata-core: Disable READ LOG DMA EXT for Samsung MZ7LH

Paul Cercueil (1):
      mmc: jz4740: Work around bug on JZ4760(B)

Pedro Tammela (3):
      net/sched: tcindex: update imperfect hash filters respecting rcu
      net/sched: act_ctinfo: use percpu stats
      net/sched: tcindex: search key must be 16 bits

Peter Xu (1):
      mm/migrate: fix wrongly apply write bit after mkdirty on sparc64

Peter Zijlstra (1):
      freezer,umh: Fix call_usermode_helper_exec() vs SIGKILL

Pierre-Louis Bossart (1):
      ASoC: SOF: Intel: hda-dai: fix possible stream_tag leak

Pietro Borrello (1):
      sctp: sctp_sock_filter(): avoid list_entry() on possibly empty list

Qi Zheng (1):
      mm: shrinkers: fix deadlock in shrinker debugfs

Qian Yingjin (1):
      mm/filemap: fix page end in filemap_get_read_batch

Raag Jadav (1):
      gpiolib: acpi: remove redundant declaration

Rafa=C5=82 Mi=C5=82ecki (1):
      net: bgmac: fix BCM5358 support by setting correct flags

Rander Wang (1):
      ASoC: SOF: ops: refine parameters order in function snd_sof_dsp_updat=
e8

Randy Dunlap (2):
      ata: pata_octeon_cf: drop kernel-doc notation
      MAINTAINERS: update FPU EMULATOR web page

Reinette Chatre (1):
      PCI/MSI: Provide missing stubs for CONFIG_PCI_MSI=3Dn

Ronak Doshi (1):
      vmxnet3: move rss code block under eop descriptor

Ryusuke Konishi (1):
      nilfs2: fix underflow in second superblock position calculations

Sean Christopherson (2):
      KVM: x86/pmu: Disable vPMU support on hybrid CPUs (host PMUs)
      perf/x86: Refuse to export capabilities for hybrid PMUs

Seth Jenkins (1):
      aio: fix mremap after fork null-deref

Shiyang Ruan (1):
      fsdax: dax_unshare_iter() should return a valid length

Siddharth Vadapalli (1):
      net: ethernet: ti: am65-cpsw: Add RX DMA Channel Teardown Quirk

Simon Gaiser (1):
      ata: ahci: Add Tiger Lake UP{3,4} AHCI controller

Steven Rostedt (Google) (1):
      tracing: Make trace_define_field_ext() static

Takashi Iwai (1):
      fbdev: Fix invalid page access after closing deferred I/O devices

Thomas Gleixner (1):
      alarmtimer: Prevent starvation by small intervals and SIG_IGN

Tom Lendacky (3):
      x86/speculation: Identify processors vulnerable to SMT RSB prediction=
s
      KVM: x86: Mitigate the cross-thread return address predictions bug
      Documentation/hw-vuln: Add documentation for Cross-Thread Return
Predictions

Tung Nguyen (1):
      tipc: fix kernel warning when sending SYN message

Ville Syrj=C3=A4l=C3=A4 (1):
      drm: Disable dynamic debug as broken

Waiman Long (1):
      sched/core: Fix a missed update of user_cpus_ptr

Werner Sembach (1):
      gpiolib: acpi: Add a ignore wakeup quirk for Clevo NH5xAx

Yang Yingliang (2):
      mmc: sdio: fix possible resource leaks in some error paths
      mmc: mmc_spi: fix error handling in mmc_spi_probe()

Yinjun Zhang (2):
      nfp: fix incorrect use of mbox in IPsec code
      nfp: fix schedule in atomic context when offloading sa

Zach O'Keefe (1):
      mm/MADV_COLLAPSE: set EAGAIN on unexpected page refcount

Zack Rusin (2):
      drm/vmwgfx: Stop accessing buffer objects which failed init
      drm/vmwgfx: Do not drop the reference to the handle too soon
