Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF796496D5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 23:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiLKWor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 17:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKWoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 17:44:44 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F8F65FC
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 14:44:42 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id x11so2316972qtv.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 14:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MJgUubMx6K013hTveCLUBGJSaosFkEgegev9xo78SI4=;
        b=htdBcuY8POIt/EwbxHooosv1VBeObtR60g/+9D2uIc2UhtJlWwgYVMP9LONRb8cfG/
         hXTBT4tOILDN59dGvJQqQr9AYppiPQIn6ipDE5HTo0YiDttUorKVVDfTiiNtyki9cvEu
         v5lKTXWIhZzGOagriW4ZCifRMW0kgp9cdN0kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJgUubMx6K013hTveCLUBGJSaosFkEgegev9xo78SI4=;
        b=k1MZ5buMjdQWB7+JtD5k0mrEfjAkoJAjC8lZGnwF78XXxjKxPE/3Rw0+1RX3r/q7a+
         jeXFGFyH4PLRCRTezEFLvaEoorESYE0Wku5rq0ICZkzgpY/Mpjb+D03Np0Eff6DrEumg
         dDT6G7g3udy5QunJ0038vCCDW+o6WP1KC3VU8CCOzdJRimS9VC+zhRkM/g5MG/s9Gh7+
         n5qS6xSWGHIx1xbwhZU8+f59FNFryAoZM/2XuoM9hO6fyZnLDsBXohMeIQTo6LESBYIb
         cYtrKjQvaKzxLkZXQbIi/t+kvv0WlhXOssssRUFVWXKfHDvSRh97EdX9gsR4KsixS22h
         L80Q==
X-Gm-Message-State: ANoB5pm3hEF/zjRpR3d/h078ZOhgILp370AUy03pV2B7Z9EWRGSJJxbh
        Q06bReb3grvGWAXe0IIvjGnegQYVnP+B5oQC
X-Google-Smtp-Source: AA0mqf4JX8et4ZvE816cPjc+g0AU07d2jdbymgkF1fSaAV8k6Q1VpzO1YZ5UxhLwpXcAMRl0df17uw==
X-Received: by 2002:a05:622a:59ca:b0:3a4:3137:79b6 with SMTP id gc10-20020a05622a59ca00b003a4313779b6mr19635845qtb.24.1670798681344;
        Sun, 11 Dec 2022 14:44:41 -0800 (PST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id f16-20020ac859d0000000b00397e97baa96sm5025559qtf.0.2022.12.11.14.44.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Dec 2022 14:44:40 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id fu10so7718635qtb.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 14:44:40 -0800 (PST)
X-Received: by 2002:a05:622a:1745:b0:3a6:8b84:47ce with SMTP id
 l5-20020a05622a174500b003a68b8447cemr33212730qtk.678.1670798679877; Sun, 11
 Dec 2022 14:44:39 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 11 Dec 2022 14:44:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj_HcgFZNyZHTLJ7qC2613zphKDtLh6ndciwopZRfH0aQ@mail.gmail.com>
Message-ID: <CAHk-=wj_HcgFZNyZHTLJ7qC2613zphKDtLh6ndciwopZRfH0aQ@mail.gmail.com>
Subject: Linux 6.1
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

So here we are, a week late, but last week was nice and slow, and I'm
much happier about the state of 6.1 than I was a couple of weeks ago
when things didn't seem to be slowing down.

Of course, that means that now we have the merge window from hell,
just before the holidays, with me having some pre-holiday travel
coming up too. So while delaying things for a week was the right thing
to do, it does make the timing for the 6.2 merge window awkward.

That said, I'm happy to report that people seem to have taken that to
heart, and I already have two dozen pull requests pending for tomorrow
in my inbox. And hopefully I'll get another batch overnight, so that I
can try to really get as much of the merge window done with early. We
all want to have a calm holiday season.

And because of that "we all want to have a calm holiday season", I
want to re-iterate that I'm going to be pretty strict about the merge
window rules. The rules are that the pull requests sent to me during
the merge window should have been ready _before_ the merge window, and
have seen some time in linux-next. No last-minute batch of
experimental new development that hasn't been seen by our test
automation.

So to make my life easier, I will just drop any pull requests that
come in late, or that look like they haven't been in linux-next. This
time of year, we're all going to be much happier to deal with the
stress of the season _without_ having to deal with the stress of any
late development. So if you already realize that work hasn't been in
linux-next, let's just all agree to not even send me the pull request
at all, and we'll all be happy with the calm end-of-the-year season.
Ok?

Anyway,  I think I've harped on that enough, let's just enjoy this
release and the upcoming festivities. As can be seen from the shortlog
below, last week really was very quiet, and it's mainly a few
last-minute fixes mostly dominated by drivers (networking in
particular, but there's some media, HID and GPU noise in there too).

              Linus

---

Akihiko Odaki (2):
      e1000e: Fix TX dispatch condition
      igb: Allocate MSI-X vector when testing

Alexandra Winter (1):
      s390/qeth: fix use-after-free in hsci

Anastasia Belova (1):
      HID: hid-lg4ff: Add check for empty lbuf

Anders Roxell (1):
      ata: libahci_platform: ahci_platform_find_clk: oops, NULL pointer

Ankit Patel (1):
      HID: usbhid: Add ALWAYS_POLL quirk for some mice

Artem Chernyshev (3):
      net: dsa: ksz: Check return value
      net: dsa: hellcreek: Check return value
      net: dsa: sja1105: Check return value

Aurabindo Pillai (1):
      drm/amd/display: fix array index out of bound error in DCN32 DML

Benjamin Tissoires (3):
      HID: fix I2C_HID not selected when I2C_HID_OF_ELAN is
      Revert "HID: logitech-hidpp: Remove special-casing of Bluetooth devic=
es"
      Revert "HID: logitech-hidpp: Enable HID++ for all the Logitech
Bluetooth devices"

Bibo Mao (1):
      LoongArch: Export symbol for function smp_send_reschedule()

Casper Andersson (1):
      net: microchip: sparx5: correctly free skb in xmit

Chen Zhongjin (1):
      Bluetooth: Fix not cleanup led when bt_init fails

Chethan T N (2):
      Bluetooth: Remove codec id field in vendor codec definition
      Bluetooth: Fix support for Read Local Supported Codecs V2

Dan Carpenter (2):
      net: mvneta: Prevent out of bounds read in mvneta_config_rss()
      net: mvneta: Fix an out of bounds check

Dave Wysochanski (1):
      fscache: Fix oops due to race with cookie_lru and use_cookie

David Hildenbrand (1):
      mm/swap: fix SWP_PFN_BITS with CONFIG_PHYS_ADDR_T_64BIT on 32bit

David Matlack (2):
      KVM: Move halt-polling documentation into common directory
      KVM: Document the interaction between KVM_CAP_HALT_POLL and halt_poll=
_ns

Dawei Li (1):
      drm/vmwgfx: Fix race issue calling pin_user_pages

Emeel Hakim (1):
      macsec: add missing attribute validation for offload

Eric Dumazet (1):
      ipv6: avoid use-after-free in ip6_fragment()

Florian Westphal (1):
      inet: ping: use hlist_nulls rcu iterator during lookup

Francesco Dolcini (1):
      Revert "ARM: dts: imx7: Fix NAND controller size-cells"

Frank Jungclaus (1):
      can: esd_usb: Allow REC and TEC to return to zero

Guillaume BRUN (1):
      drm: bridge: dw_hdmi: fix preference of RGB modes over YUV420

Haiyang Zhang (1):
      net: mana: Fix race on per-CQ variable napi work_done

Hangbin Liu (2):
      ip_gre: do not report erspan version on GRE interface
      bonding: get correct NA dest address

Hans Verkuil (2):
      media: v4l2-dv-timings.c: fix too strict blanking sanity checks
      media: videobuf2-core: take mmap_lock in vb2_get_unmapped_area()

Hans de Goede (1):
      HID: ite: Enable QUIRK_TOUCHPAD_ON_OFF_REPORT on Acer Aspire Switch V=
 10

Harshit Mogalapalli (1):
      io_uring: Fix a null-ptr-deref in io_tctx_exit_cb()

Hauke Mehrtens (1):
      ca8210: Fix crash by zero initializing data

Huacai Chen (1):
      LoongArch: mm: Fix huge page entry update for virtual machine

Hugh Dickins (1):
      tmpfs: fix data loss from failed fallocate

Ido Schimmel (2):
      ipv4: Fix incorrect route flushing when source address is deleted
      ipv4: Fix incorrect route flushing when table ID 0 is used

Ismael Ferreras Morezuelas (2):
      Bluetooth: btusb: Fix CSR clones again by re-adding
ERR_DATA_REPORTING quirk
      Bluetooth: btusb: Add debug message for CSR controllers

Jacob Pan (1):
      iommu/vt-d: Fix buggy QAT device mask

Jann Horn (1):
      ipc/sem: Fix dangling sem_array access in semtimedop race

Jason A. Donenfeld (1):
      mm: do not BUG_ON missing brk mapping, because userspace can unmap it

Jiri Slaby (SUSE) (1):
      can: slcan: fix freed work crash

Jisheng Zhang (1):
      net: stmmac: fix "snps,axi-config" node property parsing

John Starks (1):
      mm/gup: fix gup_pud_range() for dax

Jos=C3=A9 Exp=C3=B3sito (2):
      HID: uclogic: Fix frame templates for big endian architectures
      HID: uclogic: Add HID_QUIRK_HIDINPUT_FORCE quirk

Juergen Gross (2):
      xen/netback: don't call kfree_skb() with interrupts disabled
      xen/netback: fix build warning

Kees Cook (1):
      NFC: nci: Bounds check struct nfc_target arrays

Kuniyuki Iwashima (2):
      af_unix: Get user_ns from in_skb in unix_diag_get_exact().
      af_unix: Add test for sock_diag and UDIAG_SHOW_UID.

Liam Howlett (1):
      mmap: fix do_brk_flags() modifying obviously incorrect VMAs

Lin Liu (1):
      xen-netfront: Fix NULL sring after live migration

Linus Torvalds (3):
      proc: avoid integer type confusion in get_proc_long
      proc: proc_skip_spaces() shouldn't think it is working on C strings
      Linux 6.1

Liu Jian (2):
      net: hisilicon: Fix potential use-after-free in hisi_femac_rx()
      net: hisilicon: Fix potential use-after-free in hix5hd2_rx()

Luiz Augusto von Dentz (1):
      Bluetooth: Fix crash when replugging CSR fake controllers

Mario Limonciello (1):
      platform/x86/amd: pmc: Add a workaround for an s0i3 issue on Cezanne

Mateusz Jo=C5=84czyk (1):
      Bluetooth: silence a dmesg error message in hci_request.c

Matti Vaittinen (1):
      mailmap: update Matti Vaittinen's email address

Max Staudt (1):
      can: can327: flush TX_work on ldisc .close()

Michael Walle (1):
      net: phy: mxl-gpy: add MDINT workaround

Michal Hocko (1):
      kselftests: cgroup: update kmem test precision tolerance

Michal Jaron (1):
      i40e: Fix not setting default xps_cpus after reset

Muchun Song (1):
      MAINTAINERS: update Muchun Song's email

Oliver Hartkopp (1):
      can: af_can: fix NULL pointer dereference in can_rcv_filter

Pablo Neira Ayuso (1):
      netfilter: ctnetlink: fix compilation warning after data race
fixes in ct mark

Pankaj Raghav (1):
      nvme initialize core quirks before calling nvme_init_subsystem

Paolo Bonzini (1):
      KVM: x86: fix uninitialized variable use on KVM_REQ_TRIPLE_FAULT

Peter Rosin (1):
      ARM: at91: fix build for SAMA5D3 w/o L2 cache

Prike Liang (1):
      drm/amdgpu/sdma_v4_0: turn off SDMA ring buffer in the s2idle suspend

Przemyslaw Patynowski (1):
      i40e: Disallow ip4 and ip6 l4_4_bytes

Qiheng Lin (1):
      net: microchip: sparx5: Fix missing destroy_workqueue of mact_queue

Qiqi Zhang (1):
      drm/bridge: ti-sn65dsi86: Fix output polarity setting bug

Radu Nicolae Pirea (OSS) (1):
      net: dsa: sja1105: avoid out of bounds access in
sja1105_init_l2_policing()

Rasmus Villemoes (1):
      net: fec: properly guard irq coalesce setup

Rob Clark (2):
      drm/shmem-helper: Remove errant put in error path
      drm/shmem-helper: Avoid vm_open error paths

Ronak Doshi (2):
      vmxnet3: correctly report encapsulated LRO packet
      vmxnet3: use correct intrConf reference when using extended queues

Ross Lagerwall (1):
      xen/netback: Ensure protocol headers don't fall in the non-linear are=
a

Siddharth Vadapalli (1):
      net: ethernet: ti: am65-cpsw: Fix RGMII configuration at SPEED_10

Stefano Brivio (1):
      netfilter: nft_set_pipapo: Actually validate intervals in fields
after the first one

Sungwoo Kim (1):
      Bluetooth: L2CAP: Fix u8 overflow

Sylwester Dziedziuch (1):
      i40e: Fix for VF MAC address 0

Tejun Heo (2):
      memcg: Fix possible use-after-free in memcg_write_event_control()
      memcg: fix possible use-after-free in memcg_write_event_control()

Thomas Huth (1):
      KVM: s390: vsie: Fix the initialization of the epoch extension
(epdx) field

Tianjia Zhang (1):
      selftests/tls: Fix tls selftests dependency to correct algorithm

Tiezhu Yang (1):
      selftests: net: Use "grep -E" instead of "egrep"

Valentina Goncharenko (2):
      net: encx24j600: Add parentheses to fix precedence
      net: encx24j600: Fix invalid logic in reading of MISTAT register

Vladimir Oltean (1):
      net: dsa: mv88e6xxx: accept phy-mode =3D "internal" for internal PHY =
ports

Wang Kefeng (1):
      ARM: 9278/1: kfence: only handle translation faults

Wang ShaoBo (2):
      Bluetooth: 6LoWPAN: add missing hci_dev_put() in get_l2cap_conn()
      Bluetooth: hci_conn: add missing hci_dev_put() in iso_listen_bis()

Wang Yufen (1):
      gpio/rockchip: fix refcount leak in rockchip_gpiolib_register()

Wei Yongjun (1):
      mac802154: fix missing INIT_LIST_HEAD in ieee802154_if_add()

Will Deacon (1):
      Revert "arm64: dma: Drop cache invalidation from arch_dma_prep_cohere=
nt()"

Xin Long (3):
      netfilter: flowtable_offload: fix using __this_cpu_add in preemptible
      netfilter: conntrack: fix using __this_cpu_add in preemptible
      tipc: call tipc_lxc_xmit without holding node_read_lock

Xiongfeng Wang (1):
      gpio: amd8111: Fix PCI device reference count leak

Yang Yingliang (3):
      net: mdiobus: fix double put fwnode in the error path
      xen/netback: don't call kfree_skb() under spin_lock_irqsave()
      net: plip: don't call kfree_skb/dev_kfree_skb() under spin_lock_irq()

Yanteng Si (2):
      docs/LoongArch: Add booting description
      docs/zh_CN: Add LoongArch booting description's translation

Yinjun Zhang (1):
      nfp: correct desc type when header dma len is 4096

Yongqiang Liu (1):
      net: thunderx: Fix missing destroy_workqueue of nicvf_rx_mode_wq

Yuan Can (1):
      dpaa2-switch: Fix memory leak in dpaa2_switch_acl_entry_add()
and dpaa2_switch_acl_entry_remove()

YueHaibing (3):
      net: broadcom: Add PTP_1588_CLOCK_OPTIONAL dependency for
BCMGENET under ARCH_BCM2835
      ravb: Fix potential use-after-free in ravb_rx_gbeth()
      tipc: Fix potential OOB in tipc_link_proto_rcv()

Zack Rusin (1):
      drm/vmwgfx: Don't use screen objects when SEV is active

Zeng Heng (2):
      gpiolib: fix memory leak in gpiochip_setup_dev()
      net: mdio: fix unbalanced fwnode reference count in mdio_device_relea=
se()

Zhang Changzhong (1):
      ethernet: aeroflex: fix potential skb leak in greth_init_rings()

ZhangPeng (1):
      HID: core: fix shift-out-of-bounds in hid_report_raw_event

Zhengchao Shao (4):
      selftests: rtnetlink: correct xfrm policy rule in kci_test_ipsec_offl=
oad
      net: wwan: iosm: fix memory leak in ipc_mux_init()
      net: dsa: sja1105: fix memory leak in sja1105_setup_devlink_regions()
      net: thunderbolt: fix memory leak in tbnet_open()

Ziyang Xuan (2):
      ieee802154: cc2520: Fix error return code in cc2520_hw_init()
      octeontx2-pf: Fix potential memory leak in otx2_init_tc()
