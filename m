Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA24A722025
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjFEHwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjFEHwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:52:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729BD103;
        Mon,  5 Jun 2023 00:52:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E50B617AC;
        Mon,  5 Jun 2023 07:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20330C433EF;
        Mon,  5 Jun 2023 07:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685951543;
        bh=YKV9rYI6B5n8j0pIn4B5DhAs9AetbGNFC8iXPukHeWU=;
        h=From:To:Cc:Subject:Date:From;
        b=p84LwzitrbSUOsLI+stIIh076T+r0hmJXHJDKVwPxLzEZFoh6D7S1P2XT360zPHg1
         6G87JfhUj1GSvhrKs6zqp5apZP6H9MqpaTWt+h82QqO63POJEEEG5qFCWIMYV9cul5
         YN4A2PN6uQ9k3H90URtVi1v5FmPnJV+soSdSxt+Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.32
Date:   Mon,  5 Jun 2023 09:52:14 +0200
Message-ID: <2023060510-espionage-handyman-d919@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.1.32 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                   |    2 
 block/blk-map.c                                            |    2 
 block/blk-mq-tag.c                                         |   12 
 drivers/cpufreq/amd-pstate.c                               |   45 ++
 drivers/firmware/arm_ffa/driver.c                          |    3 
 drivers/gpio/Kconfig                                       |    2 
 drivers/gpio/gpio-f7188x.c                                 |   28 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                   |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                    |    7 
 drivers/infiniband/sw/rxe/rxe_qp.c                         |    7 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c            |    8 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h          |    1 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c |    9 
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c         |  209 ++++++++++---
 drivers/net/phy/mscc/mscc.h                                |    1 
 drivers/net/phy/mscc/mscc_main.c                           |   54 +--
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h             |   37 ++
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                |   35 ++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c              |    9 
 drivers/platform/x86/amd/pmf/core.c                        |   32 +
 drivers/vfio/vfio_iommu_type1.c                            |    5 
 include/linux/skbuff.h                                     |   10 
 include/linux/skmsg.h                                      |    3 
 include/net/inet_sock.h                                    |    4 
 include/net/ip.h                                           |    5 
 include/net/page_pool.h                                    |   18 -
 include/net/tcp.h                                          |   10 
 include/net/tls.h                                          |    1 
 include/uapi/linux/in.h                                    |    2 
 net/bluetooth/hci_sock.c                                   |   28 +
 net/core/page_pool.c                                       |   34 +-
 net/core/skmsg.c                                           |   81 ++---
 net/core/sock_map.c                                        |    3 
 net/ipv4/inet_connection_sock.c                            |   25 +
 net/ipv4/inet_hashtables.c                                 |    2 
 net/ipv4/ip_sockglue.c                                     |   30 +
 net/ipv4/raw.c                                             |    5 
 net/ipv4/tcp.c                                             |   11 
 net/ipv4/tcp_bpf.c                                         |   79 ++++
 net/ipv4/udp.c                                             |    9 
 net/ipv6/raw.c                                             |    3 
 net/netfilter/nf_conntrack_netlink.c                       |    8 
 net/sctp/socket.c                                          |    2 
 net/tls/tls.h                                              |    5 
 net/tls/tls_device.c                                       |   22 -
 net/tls/tls_strp.c                                         |  185 +++++++++--
 net/unix/af_unix.c                                         |    7 
 tools/include/uapi/linux/in.h                              |    1 
 tools/testing/selftests/bpf/Makefile                       |    2 
 49 files changed, 826 insertions(+), 280 deletions(-)

Anuj Gupta (1):
      block: fix bio-cache for passthru IO

David Epping (1):
      net: phy: mscc: enable VSC8501/2 RGMII RX clock

Eric Huang (1):
      wifi: rtw89: correct 5 MHz mask setting

Gautham R. Shenoy (1):
      cpufreq: amd-pstate: Add ->fast_switch() callback

Greg Kroah-Hartman (1):
      Linux 6.1.32

Haim Dreyfuss (1):
      wifi: iwlwifi: mvm: support wowlan info notification version 2

Hariprasad Kelam (1):
      octeontx2-af: Add validation for lmac type

Henning Schild (1):
      gpio-f7188x: fix chip name and pin count on Nuvoton chip

Ido Schimmel (1):
      Revert "thermal/drivers/mellanox: Use generic thermal_zone_get_trip() function"

Jakub Kicinski (6):
      tls: rx: device: fix checking decryption status
      tls: rx: strp: set the skb->len of detached / CoW'ed skbs
      tls: rx: strp: fix determining record length in copy mode
      tls: rx: strp: force mixed decrypted records into copy mode
      tls: rx: strp: factor out copying skb data
      tls: rx: strp: preserve decryption status of skbs when needed

Jakub Sitnicki (1):
      inet: Add IP_LOCAL_PORT_RANGE socket option

Jeremy Sowden (1):
      selftests/bpf: Fix pkg-config call building sign-file

Johannes Berg (1):
      wifi: iwlwifi: mvm: fix potential memory leak

John Fastabend (8):
      bpf, sockmap: Pass skb ownership through read_skb
      bpf, sockmap: Convert schedule_work into delayed_work
      bpf, sockmap: Reschedule is now done through backlog
      bpf, sockmap: Improved check for empty queue
      bpf, sockmap: Handle fin correctly
      bpf, sockmap: TCP data stall on recv before accept
      bpf, sockmap: Wake up polling after data copy
      bpf, sockmap: Incorrectly handling copied_seq

Mario Limonciello (2):
      platform/x86/amd/pmf: Fix CnQF and auto-mode after resume
      drm/amd: Don't allow s0ix on APUs older than Raven

Nicolas Dichtel (1):
      ipv{4,6}/raw: fix output xfrm lookup wrt protocol

Paul Blakey (1):
      netfilter: ctnetlink: Support offloaded conntrack entry deletion

Qingfang DENG (1):
      net: page_pool: use in_softirq() instead

Ruihan Li (1):
      bluetooth: Add cmd validity checks at the start of hci_sock_ioctl()

Shay Drory (1):
      net/mlx5: E-switch, Devcom, sync devcom events and devcom comp register

Sudeep Holla (1):
      firmware: arm_ffa: Fix usage of partition info get count flag

Tian Lan (1):
      blk-mq: fix race condition in active queue accounting

Wyes Karny (1):
      cpufreq: amd-pstate: Update policy->cur in amd_pstate_adjust_perf()

Yan Zhao (1):
      vfio/type1: check pfn valid before converting to struct page

Yanteng Si (1):
      tools headers UAPI: Sync the linux/in.h with the kernel sources

Yunsheng Lin (1):
      page_pool: fix inconsistency for page_pool_ring_[un]lock()

Zhu Yanjun (1):
      RDMA/rxe: Fix the error "trying to register non-static key in rxe_cleanup_task"

