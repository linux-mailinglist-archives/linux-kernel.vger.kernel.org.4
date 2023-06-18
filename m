Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F767348A9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 23:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjFRVhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 17:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjFRVh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 17:37:28 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61FD10CF
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 14:37:00 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f122ff663eso3379568e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 14:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687124207; x=1689716207;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F/xTM6rTnNOoj7os5yCLpjyvon2lKC/76xjPMiS3CGc=;
        b=VIbGFd3SpW1buum9zljw//lbI/+Rto5IM+sNQI4bQkJn3CputbzTNoVG8qUuVYIIHk
         D79MoWCcxIU9avY0rBAl6nVoaGIxASeYldS5wlctQcWKXJ9OU1ho52rm5k0iTrCjZFqK
         eBNvRI6hz9PM5E7N+ciw/dwu64o4hee8BaJV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687124207; x=1689716207;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/xTM6rTnNOoj7os5yCLpjyvon2lKC/76xjPMiS3CGc=;
        b=aNLUuJjRvCyIISIEZ1wruPhjdvDHBI1s1JhrrkaLDNcoZjgw6GPu630zBO9cB38ZcP
         A9hoS2hRRlKsxztbhoEbqgxsLGeo3fGtKApK8BNUqk4aMvr6r6vCzj6IBWqZ9FMXuZrK
         +7CnE14fSt55MFjMRfaWDz18HQ9jTEocxhuNda9bysUKTWQhUg/Vu4gn4GidkKr75PdD
         960WB1QVg1Xoidkjvw/s9X7toAgqrDJ1B5+qiMLQwhFkaXXoujA26u9zasv4w6PeFbj2
         YgW6cj2X0O5zDL4DAVIChf9C5Cka/lJ4eOOwq5YxRYlf80RU8TF0nHAkaoDlv00AO9UN
         wvIA==
X-Gm-Message-State: AC+VfDzvm382qd7gdXOGIn9SEGzrZ5RIRxdcmS2z7cqQzRl2Bya0c+9q
        XkAqDdgdh6zD+rTe6jVZGpJMunRqslPgWeU7wV+II7/L
X-Google-Smtp-Source: ACHHUZ5O+AumlKcT7UjjkVFHvcg4dDlcuJz828ZMW6Se/uHz9J3XQG5+gnkcSgODV/NES1NUL8HbQA==
X-Received: by 2002:a19:6544:0:b0:4f4:cebe:a7aa with SMTP id c4-20020a196544000000b004f4cebea7aamr3708522lfj.39.1687124206872;
        Sun, 18 Jun 2023 14:36:46 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id u5-20020ac248a5000000b004f5a548820asm3972229lfg.156.2023.06.18.14.36.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 14:36:46 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2b455855fb2so35234361fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 14:36:46 -0700 (PDT)
X-Received: by 2002:a2e:8296:0:b0:2b4:76f6:63a8 with SMTP id
 y22-20020a2e8296000000b002b476f663a8mr605548ljg.12.1687124205584; Sun, 18 Jun
 2023 14:36:45 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 18 Jun 2023 14:36:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjtPpxeR0t980F8P+pkQ-wNLiH2fpyjxUFJNWGMYRmnuA@mail.gmail.com>
Message-ID: <CAHk-=wjtPpxeR0t980F8P+pkQ-wNLiH2fpyjxUFJNWGMYRmnuA@mail.gmail.com>
Subject: Linux 6.4-rc7
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

Hmm. Nothing particular stands out in the rc this week, unless you
count the mptcp selftest changes that are about making the tests work
on stable kernels too. That accounts for almost a quarter of the
patch...

Other than that it's just various driver updates (rdma, gpu,
networking and usb, with a smattering of small patches elsewhere),
some networking changes, and a couple of filesystem fixes. And the
usual random noise elsewhere.

Shortlog appended.

               Linus

---

Aaro Koskinen (1):
      staging: octeon: delete my name from TODO contact

Abe Kohandel (1):
      spi: dw: Replace incorrect spi_get_chipselect with set

Abel Vesa (1):
      regulator: qcom-rpmh: Fix regulators for PM8550

Ahmed Zaki (1):
      iavf: remove mask from iavf_irq_enable_queues()

Aleksandr Loktionov (1):
      igb: fix nvm.ops.read() error handling

Alex Deucher (1):
      drm/amdgpu: add missing radeon secondary PCI ID

Alex Maftei (1):
      selftests/ptp: Fix timestamp printf format for PTP_SYS_OFFSET

Alexandre Mergnat (1):
      clk: mediatek: mt8365: Fix index issue

Arnd Bergmann (2):
      radix-tree: move declarations to header
      clk: pxa: fix NULL pointer dereference in pxa3xx_clk_update_accr

Arunpravin Paneer Selvam (1):
      Revert "drm/amdgpu: remove TOPDOWN flags when allocating VRAM in
large bar system"

Badhri Jagan Sridharan (2):
      usb: gadget: udc: core: Offload usb_udc_vbus_handler processing
      usb: gadget: udc: core: Prevent soft_connect_store() race

Baruch Siach (2):
      docs: dt: fix documented Primecell compatible string
      docs: zh_CN/devicetree: sync usage-model fix

Ben Hutchings (1):
      parisc: Delete redundant register definitions in <asm/assembly.h>

Benjamin Berg (3):
      wifi: cfg80211: fix link del callback to call correct handler
      wifi: mac80211: take lock before setting vif links
      wifi: mac80211: fragment per STA profile correctly

Benjamin Segall (1):
      epoll: ep_autoremove_wake_function should use list_del_init_careful

Bernhard Seibold (1):
      serial: lantiq: add missing interrupt ack

Biju Das (1):
      usb: gadget: udc: renesas_usb3: Fix RZ/V2M {modprobe,bind} error

Binbin Zhou (1):
      clk: clk-loongson2: Zero init clk_init_data

Bob Pearson (4):
      RDMA/rxe: Fix packet length checks
      RDMA/rxe: Fix ref count error in check_rkey()
      RDMA/rxe: Fix rxe_cq_post
      scsi: target: core: Fix error path in target_setup_session()

Carl Vanderlip (1):
      accel/qaic: Free user handle on interrupted mutex

Chen-Yu Tsai (1):
      notifier: Initialize new struct srcu_usage field

Chris Mason (2):
      btrfs: properly enable async discard when switching from RO->RW
      btrfs: can_nocow_file_extent should pass down args->strict from calle=
rs

Chris Morgan (1):
      dt-bindings: net: realtek-bluetooth: Fix RTL8821CS binding

Christian Marangi (1):
      net: ethernet: stmicro: stmmac: fix possible memory leak in __stmmac_=
open

Christoph Hellwig (1):
      btrfs: fix iomap_begin length for nocow writes

Conor Dooley (1):
      Documentation: RISC-V: patch-acceptance: mention patchwork's role

Damien Le Moal (2):
      dt-bindings: Change Damien Le Moal's contact email
      ata: libata-scsi: Avoid deadlock on rescan after device resume

Dan Carpenter (4):
      wifi: cfg80211: fix double lock bug in reg_wdev_chan_valid()
      sctp: handle invalid error codes without calling BUG()
      sctp: fix an error code in sctp_sf_eat_auth()
      net: ethernet: ti: am65-cpsw: Call of_node_put() on error path

Danielle Ratson (1):
      selftests: forwarding: hw_stats_l3: Set addrgenmode in a separate ste=
p

Dave Airlie (1):
      nouveau: fix client work fence deletion race

David Christensen (1):
      bnx2x: fix page fault following EEH recovery

David Howells (1):
      afs: Fix vlserver probe RTT handling

Diederik de Haas (1):
      dt-bindings: net: realtek-bluetooth: Fix double RTL8723CS in desc

Dmitry Mastykin (1):
      netlabel: fix shift wrapping bug in netlbl_catmap_setlong()

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Add a quirk for Compaq N14JP6

Edward Srouji (1):
      RDMA/uverbs: Restrict usage of privileged QKEYs

Elson Roy Serrao (1):
      usb: dwc3: gadget: Reset num TRBs before giving back the request

Enzo Matsumiya (1):
      smb/client: print "Unknown" instead of bogus link speed value

Eric Dumazet (1):
      net: lapbether: only support ethernet devices

Fabio M. De Francesco (1):
      ext4: drop the call to ext4_error() from ext4_get_group_info()

Fedor Pchelkin (1):
      net: macsec: fix double free of percpu stats

Guillaume Nault (1):
      ping6: Fix send to link-local addresses with VRF.

Haibo Li (1):
      mm/gup_test: fix ioctl fail for compat task

Hangbin Liu (1):
      ipvlan: fix bound dev checking for IPv6 l3s mode

Heikki Krogerus (1):
      usb: typec: ucsi: Fix command cancellation

Hersen Wu (1):
      drm/amd/display: edp do not add non-edid timings

Hongchen Zhang (1):
      LoongArch: Let pmd_present() return true when splitting pmd

Huacai Chen (1):
      LoongArch: Fix perf event id calculation

Hugh Dickins (1):
      wifi: iwlwifi: mvm: spin_lock_bh() to fix lockdep regression

Ilan Peer (1):
      wifi: mac80211: Use active_links instead of valid_links in Tx

Immad Mir (1):
      LoongArch: Fix debugfs_create_dir() error checking

Jakub Buchocki (1):
      ice: Fix ice module unload

Jakub Kicinski (1):
      net: ethtool: correct MAX attribute value for stats

Jan Karcher (1):
      MAINTAINERS: add reviewers for SMC Sockets

Janne Grunau (1):
      nios2: dts: Fix tse_mac "max-frame-size" property

Jeffrey Hugo (1):
      accel/qaic: Fix NULL pointer deref in qaic_destroy_drm_device()

Jens Axboe (3):
      io_uring/io-wq: don't clear PF_IO_WORKER on exit
      io_uring/net: save msghdr->msg_control for retries
      io_uring/io-wq: clear current->worker_private on exit

Jerry Meng (1):
      USB: serial: option: add Quectel EM061KGL series

Jiadong Zhu (4):
      drm/amdgpu: Reset CP_VMID_PREEMPT after trailing fence signaled
      drm/amdgpu: Program gds backup address as zero if no gds allocated
      drm/amdgpu: Modify indirect buffer packages for resubmission
      drm/amdgpu: Implement gfx9 patch functions for resubmission

Jiasheng Jiang (2):
      spi: cadence-quadspi: Add missing check for dma_set_mask
      octeon_ep: Add missing check for ioremap

Johan Hovold (2):
      USB: dwc3: qcom: fix NULL-deref on suspend
      USB: dwc3: fix use-after-free on core driver unbind

Johannes Berg (2):
      wifi: mac80211: fix link activation settings order
      wifi: cfg80211: remove links only on AP

John Keeping (1):
      mailmap: add entry for John Keeping

Jon Hunter (1):
      ASoC: tegra: Fix Master Volume Control

Julian Ruess (1):
      s390/ism: Fix trying to free already-freed IRQ by repeated ism_dev_ex=
it()

Justin Tee (1):
      scsi: lpfc: Fix incorrect big endian type assignment in bsg loopback =
path

Kamal Heib (1):
      RDMA/bnxt_re: Fix reporting active_{speed,width} attributes

Kamil Maziarz (1):
      ice: Fix XDP memory leak when NIC is brought up and down

Kefeng Wang (1):
      mm/damon/core: fix divide error in damon_nr_accesses_to_accesses_bp()

Kemeng Shi (1):
      Revert "ext4: remove unnecessary check in ext4_bg_num_gdb_nometa"

Kenneth Feng (1):
      drm/amd/pm: workaround for compute workload type on some skus

Krzysztof Kozlowski (1):
      dt-bindings: i3c: silvaco,i3c-master: fix missing schema restriction

Kunihiko Hayashi (1):
      of: overlay: Fix missing of_node_put() in error case of
init_overlay_changeset()

Kuniyuki Iwashima (2):
      udplite: Print deprecation notice.
      dccp: Print deprecation notice.

Lee Jones (1):
      net/sched: cls_u32: Fix reference counter leak leading to overflow

Li Lingfeng (2):
      dm: don't lock fs when the map is NULL during suspend or resume
      dm thin metadata: check fail_io before using data_sm

Li Zhijian (2):
      RDMA/rtrs: Fix the last iu->buf leak in err path
      RDMA/rtrs: Fix rxe_dealloc_pd warning

Liam R. Howlett (1):
      mm/mmap: Fix error path in do_vmi_align_munmap()

Lin Ma (2):
      net/handshake: remove fput() that causes use-after-free
      net: tipc: resize nlattr array to correct size

Linus Torvalds (1):
      Linux 6.4-rc7

Lorenzo Stoakes (1):
      lib/test_vmalloc.c: avoid garbage in page array

Lukasz Tyl (1):
      ALSA: usb-audio: Add quirk flag for HEM devices to enable native
DSD playback

Lu=C3=ADs Henriques (2):
      ocfs2: fix use-after-free when unmounting read-only filesystem
      ocfs2: check new file size on fallocate call

Maher Sanalla (1):
      RDMA/mlx5: Initiate dropless RQ for RAW Ethernet functions

Mario Limonciello (2):
      drm/amd: Make sure image is written to trigger VBIOS image update flo=
w
      drm/amd: Tighten permissions on VBIOS flashing attributes

Mark Bloch (2):
      RDMA/mlx5: Create an indirect flow table for steering anchor
      RDMA/mlx5: Fix affinity assignment

Mark Zhang (1):
      RDMA/cma: Always set static rate to 0 for RoCE

Markus Schneider-Pargmann (1):
      clk: mediatek: mt8365: Fix inverted topclk operations

Matthieu Baerts (31):
      selftests: mptcp: lib: skip if missing symbol
      selftests: mptcp: connect: skip transp tests if not supported
      selftests: mptcp: connect: skip disconnect tests if not supported
      selftests: mptcp: connect: skip TFO tests if not supported
      selftests: mptcp: diag: skip listen tests if not supported
      selftests: mptcp: diag: skip inuse tests if not supported
      selftests: mptcp: pm nl: remove hardcoded default limits
      selftests: mptcp: pm nl: skip fullmesh flag checks if not supported
      selftests: mptcp: sockopt: relax expected returned size
      selftests: mptcp: sockopt: skip getsockopt checks if not supported
      selftests: mptcp: sockopt: skip TCP_INQ checks if not supported
      selftests: mptcp: userspace pm: skip if 'ip' tool is unavailable
      selftests: mptcp: userspace pm: skip if not supported
      selftests: mptcp: userspace pm: skip PM listener events tests if
unavailable
      selftests: mptcp: lib: skip if not below kernel version
      selftests: mptcp: join: use 'iptables-legacy' if available
      selftests: mptcp: join: helpers to skip tests
      selftests: mptcp: join: skip check if MIB counter not supported
      selftests: mptcp: join: skip test if iptables/tc cmds fail
      selftests: mptcp: join: support local endpoint being tracked or not
      selftests: mptcp: join: skip Fastclose tests if not supported
      selftests: mptcp: join: support RM_ADDR for used endpoints or not
      selftests: mptcp: join: skip implicit tests if not supported
      selftests: mptcp: join: skip backup if set flag on ID not supported
      selftests: mptcp: join: skip fullmesh flag tests if not supported
      selftests: mptcp: join: skip userspace PM tests if not supported
      selftests: mptcp: join: skip fail tests if not supported
      selftests: mptcp: join: skip MPC backups tests if not supported
      selftests: mptcp: join: skip PM listener tests if not supported
      selftests: mptcp: join: uniform listener tests
      selftests: mptcp: join: skip mixed tests if not supported

Mauro Carvalho Chehab (1):
      Revert "media: dvb-core: Fix use-after-free on race condition at
dvb_frontend"

Max Tottenham (1):
      net/sched: act_pedit: Parse L3 Header for L4 offset

Maxime Chevallier (2):
      net: phylink: report correct max speed for QUSGMII
      net: phylink: use a dedicated helper to parse usgmii control word

Michael Kelley (1):
      scsi: storvsc: Always set no_report_opcodes

Mika Westerberg (4):
      thunderbolt: dma_test: Use correct value for absent rings when
creating paths
      thunderbolt: Increase DisplayPort Connection Manager handshake timeou=
t
      thunderbolt: Do not touch CL state configuration during discovery
      thunderbolt: Mask ring interrupt on Intel hardware as well

Mike Kravetz (1):
      page cache: fix page_cache_next/prev_miss off by one

Mike Snitzer (2):
      dm thin: fix issue_discard to pass GFP_NOIO to __blkdev_issue_discard
      dm: use op specific max_sectors when splitting abnormal io

Ming Lei (1):
      blk-cgroup: Flush stats before releasing blkcg_gq

Muhammad Husaini Zulkifli (1):
      igc: Clean the TX buffer and TX descriptor ring

Natalia Petrova (2):
      drm/nouveau/dp: check for NULL nv_connector->native_mode
      drm/nouveau: add nv_encoder pointer check for NULL

Nhat Pham (1):
      zswap: do not shrink if cgroup may not zswap

Nithin Dabilpuram (1):
      octeontx2-af: fix lbk link credits on cn10k

Pablo Neira Ayuso (3):
      netfilter: nf_tables: integrate pipapo into commit protocol
      netfilter: nfnetlink: skip error delivery on batch in case of ENOMEM
      netfilter: nf_tables: incorrect error path handling with NFT_MSG_NEWR=
ULE

Patrisious Haddad (3):
      RDMA/mlx5: Fix Q-counters per vport allocation
      RDMA/mlx5: Remove vport Q-counters dependency on normal Q-counters
      RDMA/mlx5: Fix Q-counters query in LAG mode

Paul Blakey (1):
      net/sched: act_ct: Fix promotion of offloaded unreplied tuple

Pavan Holla (1):
      usb: typec: Fix fast_role_swap_current show function

Peichen Huang (1):
      drm/amd/display: limit DPIA link rate to HBR3

Peilin Ye (2):
      net/sched: Refactor qdisc_graft() for ingress and clsact Qdiscs
      net/sched: qdisc_destroy() old ingress and clsact Qdiscs before graft=
ing

Peter Xu (2):
      mm/uffd: fix vma operation where start addr cuts part of vma
      mm/uffd: allow vma to merge as much as possible

Qi Hu (1):
      LoongArch: Fix the write_fcsr() macro

Qing Zhang (1):
      LoongArch: Avoid uninitialized alignment_mask

Qu Wenruo (5):
      btrfs: subpage: fix a crash in metadata repair path
      btrfs: scrub: respect the read-only flag during repair
      btrfs: scrub: also report errors hit during the initial read
      btrfs: do not ASSERT() on duplicated global roots
      btrfs: scrub: fix a return value overwrite in scrub_stripe()

Ratchanan Srirattanamet (1):
      drm/nouveau: don't detect DSM for non-NVIDIA device

Ratheesh Kannoth (1):
      octeontx2-af: Fix promiscuous mode

Ricardo Ribalda (4):
      kexec: support purgatories with .text.hot sections
      x86/purgatory: remove PGO flags
      powerpc/purgatory: remove PGO flags
      riscv/purgatory: remove PGO flags

Richard Fitzgerald (1):
      firmware: cs_dsp: Log correct region name in bin error messages

Rob Herring (1):
      dt-bindings: pinctrl: qcom,pmic-mpp: Fix schema for "qcom,paired"

Robert Hodaszi (1):
      tty: serial: fsl_lpuart: reduce RX watermark to 0 on LS1028A

Ryusuke Konishi (3):
      nilfs2: fix incomplete buffer cleanup in nilfs_btnode_abort_change_ke=
y()
      nilfs2: fix possible out-of-bounds segment allocation in resize ioctl
      nilfs2: reject devices with insufficient block count

Sagar Biradar (1):
      scsi: aacraid: Reply queue mapping to CPUs based on IRQ affinity

Saravanan Vajravel (3):
      IB/isert: Fix dead lock in ib_isert
      IB/isert: Fix possible list corruption in CMA handler
      IB/isert: Fix incorrect release of isert connection

Satha Rao (1):
      octeontx2-af: fixed resource availability check

Sebastian Reichel (1):
      clk: composite: Fix handling of high clock rates

Shyam Prasad N (5):
      cifs: fix status checks in cifs_tree_connect
      cifs: print all credit counters in DebugData
      cifs: fix sockaddr comparison in iface_cmp
      cifs: fix max_credits implementation
      cifs: add a warning when the in-flight count goes negative

Simon Horman (1):
      ice: Don't dereference NULL in ice_gnss_read error path

Sonny Jiang (1):
      drm/amdgpu: vcn_4_0 set instance 0 init sched score to 1

Steve French (1):
      cifs: fix lease break oops in xfstest generic/098

Su Hui (1):
      drm/bridge: ti-sn65dsi86: Avoid possible buffer overflow

Takashi Iwai (3):
      regmap: regcache: Don't sync read-only registers
      ALSA: seq: oss: Fix racy open/close of MIDI devices
      ALSA: usb-audio: Fix broken resume due to UAC3 power state

Thomas Zimmermann (1):
      drm/radeon: Disable outputs when releasing fbdev client

Tom Chung (1):
      drm/amd/display: fix the system hang while disable PSR

Vinicius Costa Gomes (1):
      igc: Fix possible system crash when loading module

Vlad Buslov (5):
      selftests/tc-testing: Fix Error: Specified qdisc kind is unknown.
      selftests/tc-testing: Fix Error: failed to find target LOG
      selftests/tc-testing: Fix SFB db test
      selftests/tc-testing: Remove configs that no longer exist
      net/sched: cls_api: Fix lockup on flushing explicitly created chain

Vladimir Oltean (2):
      spi: fsl-dspi: avoid SCK glitches with continuous transfers
      net: dsa: felix: fix taprio guard band overflow at 10Mbps with
jumbo frames

Wei Fang (1):
      net: enetc: correct the indexes of highest and 2nd highest TCs

Wes Huang (1):
      net: usb: qmi_wwan: add support for Compal RXM-G1

Yishai Hadas (1):
      IB/uverbs: Fix to consider event queue closing also upon non-blocking=
 mode

Yoshihiro Shimoda (1):
      net: renesas: rswitch: Fix timestamp feature after all
descriptors are used

Yuezhen Luan (1):
      igb: Fix extts capture value format for 82580/i354/i350

Zhengchao Shao (1):
      net/sched: taprio: fix slab-out-of-bounds Read in taprio_dequeue_from=
_txq

Zhu Yanjun (1):
      RDMA/rxe: Fix the use-before-initialization error of resp_pkts

=C3=8D=C3=B1igo Huguet (1):
      sfc: fix XDP queues mode with legacy IRQ

=E9=91=AB=E5=8D=8E (1):
      smb: remove obsolete comment
