Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00115701F60
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 22:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjENUDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 16:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjENUDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 16:03:50 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C522F1A6
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 13:03:47 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bcb229adaso21808342a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 13:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684094626; x=1686686626;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DfYEEEuee9Ep1evPpIgq/q8ZM/fv3HPS4hYGLxMazMw=;
        b=Q2X+C3KkUKc0FQMY62BQHa2BXhSRrcfeYmmfgd2ye3UzaWLmzAn8Bzlv9sYD/Krqp4
         G97rFWLE2Taklgcpfo+idRYC/0hHcwnn94X/2acMZCfn2DC8cxQ11Lfn/OWqTb+YwLTg
         FKpPWTesRKSp3XboLW2cA8jY/wBN9dOHPFVRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684094626; x=1686686626;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DfYEEEuee9Ep1evPpIgq/q8ZM/fv3HPS4hYGLxMazMw=;
        b=DKudgNOKBZGXrbFz/2dTqZaGy2/4zKWhVv8uO6+va4CAO4S0M4h5RNTb2ngELTLZFU
         lxmB1QBG21H5LP8aTonKeEWYpJwHPLB0tjTJQt4rWf834uTHGaAiG2CY+NDR/LuqAcv7
         EeWwqZ0i+kk6XL6/ld1p/77PVJpZGim7zoPKOrJOH4DX7iS44emi7nCCgHKVLVmue+nk
         sns6NN2TtN7omBy1J6nrlLqpFN7d72BrBW3guVQs1K1FN5+GWpCjW0gJZ+vcNYaNKvY7
         sxZGnyq+/6HOZPMamijpLfHUdtUgdBhi6w8i31lDeVXd1IE4IxHvLv7cmNy+TawP5Ele
         oLPA==
X-Gm-Message-State: AC+VfDzIr/5m7ozy/zZYKvDlV4gSEWgXGXSrfOUBO5N2gee8wD2VpvGI
        WZ9nrAosWiZWOzCj+WG0ghLhrXDRIeN0m2Cv8khnCQ==
X-Google-Smtp-Source: ACHHUZ7l7ERtxxxJ1ogZDOAZw1So2CpkTzfzh1xaarR224H5qSk8UXVZA66IKO97lEZvPl0WhnvQXA==
X-Received: by 2002:a17:907:a424:b0:96a:246b:c65d with SMTP id sg36-20020a170907a42400b0096a246bc65dmr16137022ejc.12.1684094625694;
        Sun, 14 May 2023 13:03:45 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id p1-20020a170906838100b009662b4230cesm8686726ejx.148.2023.05.14.13.03.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 May 2023 13:03:45 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso2214404966b.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 13:03:45 -0700 (PDT)
X-Received: by 2002:a17:906:478b:b0:96a:7bf7:4ac9 with SMTP id
 cw11-20020a170906478b00b0096a7bf74ac9mr11654400ejc.44.1684094624626; Sun, 14
 May 2023 13:03:44 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 May 2023 13:03:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3jDtVCi2LqyijGzut2cq=AkPrAMfF0+6gtZ1WB6ruWQ@mail.gmail.com>
Message-ID: <CAHk-=wj3jDtVCi2LqyijGzut2cq=AkPrAMfF0+6gtZ1WB6ruWQ@mail.gmail.com>
Subject: Linux 6.4-rc2
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

It's Mother's Day, which obviously means that you can surprise her
with a brand new kernel. And you're in luck, since I just happened to
push out the very newest one: 6.4-rc2 is out there in all the usual
places.

This being rc2, it's been a fairly calm week as people are only
starting to find any issues from the merge window, but it all looks
fine. The stats are unusual, in that it's about a third drivers
(mostly gpu, some media and networking), a third filesystems (ext4,
btrfs, and xfs), and a third "miscellaneous" (mostly selftests and
documentation updates, but there's some arch updates and some core
kernel code too).

The shortlog is appended, it's easy enough to just quickly scroll
through it to get a flavor of the kinds of fixes have been going
around..

Now, back to our regularly scheduled Mother's Day kernel compiles,

                   Linus

---

Alexandre Ghiti (1):
      riscv: Fix orphan section warnings caused by kernel/pi

Alvin Lee (1):
      drm/amd/display: Enforce 60us prefetch for 200Mhz DCFCLK modes

Anastasia Belova (1):
      btrfs: print-tree: parent bytenr must be aligned to sector size

Andrey Avdeev (1):
      platform/x86: touchscreen_dmi: Add info for the Dexp Ursus KX210i

Ard Biesheuvel (1):
      ARM: 9297/1: vfp: avoid unbalanced stack on 'success' return path

Arnd Bergmann (3):
      media: nxp: ignore unused suspend operations
      media: platform: mtk-mdp3: work around unused-variable warning
      media: nxp: imx8-isi: fix buiding on 32-bit

Baokun Li (1):
      ext4: check iomap type only if ext4_iomap_begin() does not fail

Bob Peterson (1):
      gfs2: Don't deref jdesc in evict

Boris Burkov (1):
      btrfs: fix encoded write i_size corruption with no-holes

Boris Sukholitko (4):
      selftests: nft_flowtable.sh: use /proc for pid checking
      selftests: nft_flowtable.sh: no need for ps -x option
      selftests: nft_flowtable.sh: wait for specific nc pids
      selftests: nft_flowtable.sh: monitor result file sizes

Borislav Petkov (AMD) (1):
      x86/retbleed: Fix return thunk alignment

Christoph Hellwig (1):
      btrfs: zero the buffer before marking it dirty in btrfs_redirty_list_=
add

Christophe JAILLET (1):
      net: mdio: mvusb: Fix an error handling path in mvusb_mdio_probe()

Colin Foster (1):
      net: mscc: ocelot: fix stat counter register values

Dan Williams (1):
      tools/testing/cxl: Use DEFINE_STATIC_SRCU()

Daniel Golle (1):
      net: ethernet: mtk_eth_soc: fix NULL pointer dereference

Darrick J. Wong (9):
      xfs: don't unconditionally null args->pag in xfs_bmap_btalloc_at_eof
      xfs: set bnobt/cntbt numrecs correctly when formatting new AGs
      xfs: flush dirty data and drain directios before scrubbing cow fork
      xfs: don't allocate into the data fork for an unshare request
      xfs: fix negative array access in xfs_getbmap
      xfs: explicitly specify cpu when forcing inodegc delayed work to
run immediately
      xfs: check that per-cpu inodegc workers actually run on that cpu
      xfs: disable reaping in fscounters scrub
      xfs: fix xfs_inodegc_stop racing with mod_delayed_work

Dave Jiang (1):
      cxl: Add missing return to cdat read error path

Eric Dumazet (7):
      net: skb_partial_csum_set() fix against transport header magic value
      netlink: annotate accesses to nlk->cb_running
      net: annotate sk->sk_err write from do_recvmmsg()
      net: deal with most data-races in sk_wait_event()
      net: add vlan_get_protocol_and_depth() helper
      tcp: add annotations around sk->sk_shutdown accesses
      net: datagram: fix data-races in datagram_poll()

Fae (1):
      platform/x86: hp-wmi: add micmute to hp_wmi_keymap struct

Filipe Manana (6):
      btrfs: fix btrfs_prev_leaf() to not return the same key twice
      btrfs: fix leak of source device allocation state after device replac=
e
      btrfs: abort transaction when sibling keys check fails for leaves
      btrfs: print extent buffers when sibling keys check fails
      btrfs: fix space cache inconsistency after error loading it from disk
      btrfs: fix backref walking not returning all inode refs

Florian Fainelli (1):
      net: phy: bcm7xx: Correct read from expansion register

Florian Westphal (3):
      netfilter: nf_tables: always release netdev hooks from notifier
      netfilter: conntrack: fix possible bug_on with enable_hooks=3D1
      selftests: nft_flowtable.sh: check ingress/egress chain too

Guchun Chen (4):
      drm/amd/pm: parse pp_handle under appropriate conditions
      drm/amdgpu: disable sdma ecc irq only when sdma RAS is enabled in sus=
pend
      drm/amd/pm: avoid potential UBSAN issue on legacy asics
      drm/amdgpu/gfx: disable gfx9 cp_ecc_error_irq only when enabling
legacy gfx ras

Guoqing Jiang (1):
      block/rnbd: replace REQ_OP_FLUSH with REQ_OP_WRITE

Haibo Li (1):
      ARM: 9295/1: unwind:fix unwind abort for uleb128 case

Hangbin Liu (4):
      bonding: fix send_peer_notif overflow
      Documentation: bonding: fix the doc of peer_notif_delay
      selftests: forwarding: lib: add netns support for tc rule handle stat=
s get
      kselftest: bonding: add num_grat_arp test

Hans de Goede (1):
      platform/x86: touchscreen_dmi: Add upside-down quirk for
GDIX1002 ts on the Juno Tablet

Helge Deller (3):
      fbdev: modedb: Add 1920x1080 at 60 Hz video mode
      fbdev: stifb: Fix info entry in sti_struct on error path
      parisc: Fix encoding of swp_entry due to added SWP_EXCLUSIVE flag

Horatio Zhang (1):
      drm/amdgpu: drop gfx_v11_0_cp_ecc_error_irq_funcs

Ivan Orlov (1):
      nbd: Fix debugfs_create_dir error checking

Jammy Huang (1):
      drm/ast: Fix ARM compatibility

Jan Kara (4):
      inotify: Avoid reporting event with invalid wd
      ext4: fix lockdep warning when enabling MMP
      ext4: avoid deadlock in fs reclaim with page writeback
      ext4: fix data races when using cached status extents

Jani Nikula (3):
      drm/dsc: fix drm_edp_dsc_sink_output_bpp() DPCD high byte usage
      drm/dsc: fix DP_DSC_MAX_BPP_DELTA_* macro values
      drm/i915: taint kernel when force probing unsupported devices

Jens Axboe (2):
      io_uring: make io_uring_sqe_cmd() unconditionally available
      pipe: check for IOCB_NOWAIT alongside O_NONBLOCK

John Harrison (1):
      drm/i915/guc: Don't capture Gen8 regs on Xe devices

John Stultz (1):
      locking/rwsem: Add __always_inline annotation to
__down_read_common() and inlined callers

Josef Bacik (1):
      btrfs: don't free qgroup space unless specified

Julian Winkler (1):
      platform/x86: intel_scu_pcidrv: Add back PCI ID for Medfield

Kan Liang (1):
      perf/x86/intel/ds: Flush PEBS DS when changing PEBS_DATA_CFG

Kees Cook (1):
      drm/nouveau/disp: More DP_RECEIVER_CAP_SIZE array fixes

Keoseong Park (1):
      scsi: ufs: core: Fix I/O hang that occurs when BKOPS fails in
W-LUN suspend

Krzysztof Kozlowski (1):
      dt-bindings: PCI: fsl,imx6q: fix assigned-clocks warning

Kuniyuki Iwashima (3):
      net: Fix load-tearing on sk->sk_stamp in sock_recv_cmsgs().
      af_unix: Fix a data race of sk->sk_receive_queue->qlen.
      af_unix: Fix data races around sk->sk_shutdown.

Leo Chen (1):
      drm/amd/display: Add symclk workaround during disable link output

Liming Sun (1):
      platform/mellanox: fix potential race in mlxbf-tmfifo driver

Lin.Cao (1):
      drm/amdgpu: Fix vram recover doesn't work after whole GPU reset (v2)

Linus Torvalds (3):
      nfs: fix another case of NULL/IS_ERR confusion wrt folio pointers
      MAINTAINERS: re-sort all entries and fields
      Linux 6.4-rc2

Luca Weiss (1):
      media: dt-bindings: ov2685: Correct data-lanes attribute

Lukas Bulwahn (1):
      MAINTAINERS: adjust file entry for ARM/APPLE MACHINE SUPPORT

Marek Vasut (1):
      net: stmmac: Initialize MAC_ONEUS_TIC_COUNTER register

Mario Limonciello (2):
      x86/amd_nb: Add PCI ID for family 19h model 78h
      hwmon: (k10temp) Add PCI ID for family 19, model 78h

Mark Pearson (2):
      platform/x86: thinkpad_acpi: Fix platform profiles on T490
      platform/x86: thinkpad_acpi: Add profile force ability

Ming Lei (1):
      ublk: fix command op code check

Namhyung Kim (1):
      perf/x86: Fix missing sample size update on AMD BRS

Naohiro Aota (3):
      btrfs: zoned: fix wrong use of bitops API in btrfs_ensure_empty_zones
      btrfs: zoned: zone finish data relocation BG with last IO
      btrfs: zoned: fix full zone super block reading on ZNS

Nikita Zhandarovich (1):
      drm/i915/dp: prevent potential div-by-zero

Niklas S=C3=B6derlund (3):
      media: rcar-vin: Gen3 can not scale NV12
      media: rcar-vin: Fix NV12 size alignment
      media: rcar-vin: Select correct interrupt mode for V4L2_FIELD_ALTERNA=
TE

Pawel Witek (1):
      cifs: fix pcchunk length type in smb2_copychunk_range

Pierre Asselin (1):
      firmware/sysfb: Fix VESA format selection

Qu Wenruo (2):
      btrfs: properly reject clear_cache and v1 cache for block-group-tree
      btrfs: make clear_cache mount option to rebuild FST without disabling=
 it

Randy Dunlap (4):
      ARM: 9296/1: HP Jornada 7XX: fix kernel-doc warnings
      sched: fix cid_lock kernel-doc warnings
      docs: networking: fix x25-iface.rst heading & index order
      Documentation/block: drop the request.rst file

Roy Novich (1):
      linux/dim: Do nothing if no time delta between samples

Russell King (Oracle) (1):
      net: pcs: xpcs: fix incorrect number of interfaces

Saleemkhan Jamadar (1):
      drm/amdgpu/jpeg: Remove harvest checking for JPEG3

Saravana Kannan (1):
      drm/mipi-dsi: Set the fwnode for mipi_dsi_device

Simon Horman (1):
      parisc: kexec: include reboot.h

Srinivas Pandruvada (1):
      platform/x86/intel-uncore-freq: Return error on write frequency

Stanislav Lisovskiy (1):
      drm/i915: Fix NULL ptr deref by checking new_crtc_state

Steve French (5):
      do not reuse connection if share marked as isolated
      smb3: improve parallel reads of large files
      SMB3: force unmount was failing to close deferred close files
      smb3: fix problem remounting a share after shutdown
      cifs: release leases for deferred close handles when freezing

Sui Jingfeng (1):
      drm/fbdev-generic: prohibit potential out-of-bounds access

Takashi Sakamoto (1):
      firewire: net: fix unexpected release of object for asynchronous
request packet

Theodore Ts'o (10):
      ext4: allow ext4_get_group_info() to fail
      ext4: remove a BUG_ON in ext4_mb_release_group_pa()
      ext4: fix invalid free tracking in ext4_xattr_move_to_block()
      ext4: don't clear SB_RDONLY when remounting r/w until quota is re-ena=
bled
      ext4: improve error handling from ext4_dirhash()
      ext4: improve error recovery code paths in __ext4_remount()
      ext4: fix deadlock when converting an inline directory in nojournal m=
ode
      ext4: add indication of ro vs r/w mounts in the mount message
      ext4: add bounds checking in get_max_inline_xattr_value_size()
      ext4: bail out of ext4_xattr_ibody_get() fails for any reason

Thomas Gleixner (1):
      tick/broadcast: Make broadcast device replacement work correctly

Thomas Zimmermann (15):
      fbdev: 68328fb: Remove trailing whitespaces
      fbdev: atmel_lcdfb: Remove trailing whitespaces
      fbdev: cg14: Remove trailing whitespaces
      fbdev: controlfb: Remove trailing whitespaces
      fbdev: g364fb: Remove trailing whitespaces
      fbdev: hgafb: Remove trailing whitespaces
      fbdev: hpfb: Remove trailing whitespaces
      fbdev: macfb: Remove trailing whitespaces
      fbdev: maxinefb: Remove trailing whitespaces
      fbdev: p9100: Remove trailing whitespaces
      fbdev: platinumfb: Remove trailing whitespaces
      fbdev: sa1100fb: Remove trailing whitespaces
      fbdev: stifb: Remove trailing whitespaces
      fbdev: valkyriefb: Remove trailing whitespaces
      fbdev: vfb: Remove trailing whitespaces

Thong Thai (1):
      drm/amdgpu/nv: update VCN 3 max HEVC encoding resolution

Tudor Ambarus (1):
      ext4: avoid a potential slab-out-of-bounds in ext4_group_desc_csum

Vitaly Prosyak (1):
      drm/sched: Check scheduler work queue before calling timeout handling

Yang Jihong (1):
      perf/core: Fix perf_sample_data not properly initialized for
different swevents in perf_tp_event()

Ye Bin (1):
      ext4: fix WARNING in mb_find_extent

Yifan Zhang (2):
      drm/amdgpu: set gfx9 onwards APU atomics support to be true
      drm/amdgpu: change gfx 11.0.4 external_id range

Zheng Wang (1):
      fbdev: imsttfb: Fix use after free bug in imsttfb_probe

Ziwei Xiao (1):
      gve: Remove the code of clearing PBA bit

Zongjie Li (1):
      fbdev: arcfb: Fix error handling in arcfb_probe()

t.feng (1):
      ipvlan:Fix out-of-bounds caused by unclear skb->cb

xiaoshoukui (1):
      btrfs: fix assertion of exclop condition when starting balance
