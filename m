Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAC0748DB2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbjGETXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbjGETXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:23:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1672136
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 12:20:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B2AA616EC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 19:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F073C433C7;
        Wed,  5 Jul 2023 19:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688584186;
        bh=mR64JF1TEVW3OtrKf+1FvPGsR+gSV54GdH+m5bMPqUo=;
        h=From:To:Cc:Subject:Date:From;
        b=DS36kRO8EwcnW6iL4ZRq+bfTOlRubZ0gbtXs8FMifKP3sBiVX5V9PmVvEoeEQen2r
         2PMdMNfzmXWughnbKLl94POrKlKVMUMUzWcqAl4CTti8Q9FI27nll1dqRY8ilCzqJl
         oAM51jSDRIiQeLOgQznSx41kh866X56wVVNeBfYIRutoLwEEMcDqWItYMK+9D12xkS
         Et722w9qrmNcVayGCpqSqMQrDE3jZJ4tAxzlF7C3QzaBVQZuvmyNdCTyQx5uUIzYOz
         kWueJVJlp4THAZnyMYIvhvRiB/cyF1ZNLBDA63mewSy45UWTTezZ35sq2Ln434XHsC
         ZSw27K0oeA9VQ==
From:   Jakub Kicinski <kuba@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.5-rc1
Date:   Wed,  5 Jul 2023 12:09:45 -0700
Message-ID: <20230705190945.602792-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

The following changes since commit 3a8a670eeeaa40d87bd38a587438952741980c18:

  Merge tag 'net-next-6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2023-06-28 16:43:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.5-rc1

for you to fetch changes up to cc7eab25b1cf3f9594fe61142d3523ce4d14a788:

  nfp: clean mc addresses in application firmware when closing port (2023-07-05 10:59:12 -0700)

----------------------------------------------------------------
Including fixes from bluetooth, bpf and wireguard.

Current release - regressions:

 - nvme-tcp: fix comma-related oops after sendpage changes

Current release - new code bugs:

 - ptp: make max_phase_adjustment sysfs device attribute invisible
   when not supported

Previous releases - regressions:

 - sctp: fix potential deadlock on &net->sctp.addr_wq_lock

 - mptcp:
   - ensure subflow is unhashed before cleaning the backlog
   - do not rely on implicit state check in mptcp_listen()

Previous releases - always broken:

 - net: fix net_dev_start_xmit trace event vs skb_transport_offset()

 - Bluetooth:
   - fix use-bdaddr-property quirk
   - L2CAP: fix multiple UaFs
   - ISO: use hci_sync for setting CIG parameters
   - hci_event: fix Set CIG Parameters error status handling
   - hci_event: fix parsing of CIS Established Event
   - MGMT: fix marking SCAN_RSP as not connectable

 - wireguard: queuing: use saner cpu selection wrapping

 - sched: act_ipt: various bug fixes for iptables <> TC interactions

 - sched: act_pedit: add size check for TCA_PEDIT_PARMS_EX

 - dsa: fixes for receiving PTP packets with 8021q and sja1105 tagging

 - eth: sfc: fix null-deref in devlink port without MAE access

 - eth: ibmvnic: do not reset dql stats on NON_FATAL err

Misc:

 - xsk: honor SO_BINDTODEVICE on bind

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Azeem Shaikh (1):
      net: Replace strlcpy with strscpy

Chengfeng Ye (1):
      sctp: fix potential deadlock on &net->sctp.addr_wq_lock

Dan Carpenter (1):
      mlxsw: spectrum_router: Fix an IS_ERR() vs NULL check

Dan Gora (2):
      Bluetooth: btrtl: Add missing MODULE_FIRMWARE declarations
      Bluetooth: btusb: Add device 6655:8771 to device tables

Daniel Díaz (1):
      selftests/net: Add xt_policy config for xfrm_policy test

David Howells (1):
      nvme-tcp: Fix comma-related oops

David S. Miller (4):
      Merge branch 'octeontx2-af-fixes'
      Merge branch 'wireguard-fixes'
      Merge branch 'dsa-ll-fixes'
      Merge branch 'mptcp-fixes'

Davide Tronchin (1):
      net: usb: cdc_ether: add u-blox 0x1313 composition.

Eric Dumazet (2):
      net: fix net_dev_start_xmit trace event vs skb_transport_offset()
      tcp: annotate data races in __tcp_oow_rate_limited()

Florian Westphal (3):
      net/sched: act_ipt: add sanity checks on table name and hook locations
      net/sched: act_ipt: add sanity checks on skb before calling target
      net/sched: act_ipt: zero skb->cb before calling target

Guillaume Nault (1):
      pptp: Fix fib lookup calls.

Hariprasad Kelam (5):
      octeontx2-af: cn10kb: fix interrupt csr addresses
      octeontx2-af: Fix mapping for NIX block from CGX connection
      octeontx2-af: Add validation before accessing cgx and lmac
      octeontx2-af: Reset MAC features in FLR
      octeontx-af: fix hardware timestamp configuration

Ilya Maximets (1):
      xsk: Honor SO_BINDTODEVICE on bind

Ivan Orlov (1):
      Bluetooth: hci_sysfs: make bt_class a static const structure

J.J. Martzki (1):
      samples: pktgen: fix append mode failed issue

Jakub Kicinski (3):
      Merge branch 'bluetooth-fixes-from-next'
      docs: netdev: broaden mailbot to all MAINTAINERS
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf

Jason A. Donenfeld (3):
      wireguard: queueing: use saner cpu selection wrapping
      wireguard: netlink: send staged packets when setting initial private key
      wireguard: timers: move to using timer_delete_sync

Jiapeng Chong (1):
      Bluetooth: hci_conn: Use kmemdup() to replace kzalloc + memcpy

Johan Hovold (3):
      Bluetooth: fix invalid-bdaddr quirk for non-persistent setup
      Bluetooth: fix use-bdaddr-property quirk
      Bluetooth: hci_bcm: do not mark valid bd_addr as invalid

Lin Ma (1):
      net/sched: act_pedit: Add size check for TCA_PEDIT_PARMS_EX

Luiz Augusto von Dentz (3):
      Bluetooth: MGMT: Fix marking SCAN_RSP as not connectable
      Bluetooth: ISO: Rework sync_interval to be sync_factor
      Bluetooth: hci_event: Fix parsing of CIS Established Event

Martin Habets (1):
      sfc: support for devlink port requires MAE access

Matthew Anderson (1):
      Bluetooth: btusb: Add MT7922 bluetooth ID for the Asus Ally

Matthieu Baerts (7):
      selftests: mptcp: connect: fail if nft supposed to work
      selftests: mptcp: sockopt: use 'iptables-legacy' if available
      selftests: mptcp: sockopt: return error if wrong mark
      selftests: mptcp: userspace_pm: use correct server port
      selftests: mptcp: userspace_pm: report errors with 'remove' tests
      selftests: mptcp: depend on SYN_COOKIES
      selftests: mptcp: pm_nl_ctl: fix 32-bit support

Min-Hua Chen (1):
      Bluetooth: btqca: use le32_to_cpu for ver.soc_id

Moritz Fischer (1):
      net: lan743x: Don't sleep in atomic context

Nick Child (1):
      ibmvnic: Do not reset dql stats on NON_FATAL err

Paolo Abeni (5):
      Merge branch 'net-sched-act_ipt-bug-fixes'
      Merge branch 'fix-ptp-packet-drops-with-ocelot-8021q-dsa-tag-protocol'
      Merge branch 'fix-ptp-received-on-wrong-port-with-bridged-sja1105-dsa'
      mptcp: ensure subflow is unhashed before cleaning the backlog
      mptcp: do not rely on implicit state check in mptcp_listen()

Pauli Virtanen (2):
      Bluetooth: ISO: use hci_sync for setting CIG parameters
      Bluetooth: hci_event: fix Set CIG Parameters error status handling

Pawel Dembicki (1):
      net: dsa: vsc73xx: fix MTU configuration

Rahul Rameshbabu (1):
      ptp: Make max_phase_adjustment sysfs device attribute invisible when not supported

SeongJae Park (1):
      bpf, btf: Warn but return no error for NULL btf from __register_btf_kfunc_id_set()

Subash Abhinov Kasiviswanathan (2):
      docs: networking: Update codeaurora references for rmnet
      Documentation: ABI: sysfs-class-net-qmi: pass_through contact update

Sungwoo Kim (1):
      Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_cb

Thorsten Winkler (1):
      s390/qeth: Fix vipa deletion

Tobias Heider (1):
      Add MODULE_FIRMWARE() for FIRMWARE_TG357766.

Vladimir Oltean (9):
      net: mscc: ocelot: don't report that RX timestamping is enabled by default
      net: mscc: ocelot: don't keep PTP configuration of all ports in single structure
      net: dsa: felix: don't drop PTP frames with tag_8021q when RX timestamping is disabled
      net: dsa: sja1105: always enable the INCL_SRCPT option
      net: dsa: tag_sja1105: always prefer source port information from INCL_SRCPT
      net: bridge: keep ports without IFF_UNICAST_FLT in BR_PROMISC mode
      net: dsa: tag_sja1105: fix source port decoding in vlan_filtering=0 bridge mode
      net: dsa: tag_sja1105: fix MAC DA patching from meta frames
      net: dsa: sja1105: always enable the send_meta options

Yinjun Zhang (1):
      nfp: clean mc addresses in application firmware when closing port

Zhengchao Shao (1):
      mlxsw: minimal: fix potential memory leak in mlxsw_m_linecards_init

Zhengping Jiang (1):
      Bluetooth: L2CAP: Fix use-after-free

 Documentation/ABI/testing/sysfs-class-net-qmi      |  2 +-
 Documentation/networking/af_xdp.rst                |  9 +++
 .../device_drivers/cellular/qualcomm/rmnet.rst     |  7 +-
 Documentation/process/maintainer-netdev.rst        |  7 +-
 drivers/bluetooth/btqca.c                          |  2 +-
 drivers/bluetooth/btrtl.c                          | 18 ++++-
 drivers/bluetooth/btusb.c                          |  5 ++
 drivers/bluetooth/hci_bcm.c                        |  3 +-
 drivers/net/dsa/ocelot/felix.c                     | 12 +++
 drivers/net/dsa/sja1105/sja1105.h                  |  2 +-
 drivers/net/dsa/sja1105/sja1105_main.c             | 14 +---
 drivers/net/dsa/sja1105/sja1105_ptp.c              | 48 +----------
 drivers/net/dsa/vitesse-vsc73xx-core.c             |  6 +-
 drivers/net/ethernet/broadcom/tg3.c                |  1 +
 drivers/net/ethernet/ibm/ibmvnic.c                 |  9 ++-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    | 33 +++++++-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h    |  2 +
 .../ethernet/marvell/octeontx2/af/lmac_common.h    |  3 +
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c    | 32 +++++++-
 drivers/net/ethernet/marvell/octeontx2/af/rpm.h    |  5 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |  1 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    | 12 +++
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    | 22 +++++-
 drivers/net/ethernet/mellanox/mlxsw/minimal.c      |  1 +
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |  4 +-
 drivers/net/ethernet/microchip/lan743x_main.c      | 21 ++++-
 drivers/net/ethernet/mscc/ocelot.c                 |  1 -
 drivers/net/ethernet/mscc/ocelot_ptp.c             | 66 ++++++++++------
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |  5 ++
 drivers/net/ethernet/sfc/efx_devlink.c             |  3 +
 drivers/net/ppp/pptp.c                             | 31 +++++---
 drivers/net/usb/cdc_ether.c                        |  6 ++
 drivers/net/wireguard/netlink.c                    | 14 ++--
 drivers/net/wireguard/queueing.c                   |  1 +
 drivers/net/wireguard/queueing.h                   | 25 +++---
 drivers/net/wireguard/receive.c                    |  2 +-
 drivers/net/wireguard/send.c                       |  2 +-
 drivers/net/wireguard/timers.c                     | 10 +--
 drivers/nvme/host/tcp.c                            |  2 +-
 drivers/ptp/ptp_sysfs.c                            |  3 +
 drivers/s390/net/qeth_l3_sys.c                     |  2 +-
 include/linux/dsa/sja1105.h                        |  4 -
 include/net/bluetooth/bluetooth.h                  |  2 +-
 include/net/bluetooth/mgmt.h                       |  1 +
 include/soc/mscc/ocelot.h                          | 10 ++-
 include/trace/events/fib.h                         |  2 +-
 include/trace/events/fib6.h                        |  2 +-
 include/trace/events/net.h                         |  3 +-
 kernel/bpf/btf.c                                   |  6 +-
 net/bluetooth/hci_conn.c                           | 49 +++++++++---
 net/bluetooth/hci_event.c                          | 63 +++++++++------
 net/bluetooth/hci_sync.c                           | 28 +++----
 net/bluetooth/hci_sysfs.c                          | 14 ++--
 net/bluetooth/iso.c                                |  4 +-
 net/bluetooth/l2cap_core.c                         |  5 ++
 net/bluetooth/l2cap_sock.c                         |  2 +
 net/bridge/br_if.c                                 |  5 +-
 net/dsa/tag_sja1105.c                              | 92 ++++++++--------------
 net/ipv4/tcp_input.c                               | 12 ++-
 net/mptcp/protocol.c                               |  7 +-
 net/sched/act_ipt.c                                | 72 +++++++++++++++--
 net/sched/act_pedit.c                              |  1 +
 net/sctp/socket.c                                  |  4 +-
 net/xdp/xsk.c                                      |  5 ++
 samples/pktgen/functions.sh                        | 13 +--
 .../pktgen/pktgen_bench_xmit_mode_netif_receive.sh |  4 +
 .../pktgen/pktgen_bench_xmit_mode_queue_xmit.sh    |  4 +
 samples/pktgen/pktgen_sample01_simple.sh           |  4 +
 samples/pktgen/pktgen_sample02_multiqueue.sh       |  3 +
 .../pktgen/pktgen_sample03_burst_single_flow.sh    |  4 +
 samples/pktgen/pktgen_sample04_many_flows.sh       |  4 +
 samples/pktgen/pktgen_sample05_flow_per_thread.sh  |  4 +
 ...tgen_sample06_numa_awared_queue_irq_affinity.sh |  3 +
 tools/testing/selftests/net/config                 |  1 +
 tools/testing/selftests/net/mptcp/config           |  1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  3 +
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 29 ++++---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c      | 10 +--
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |  4 +-
 tools/testing/selftests/wireguard/netns.sh         | 30 ++++++-
 80 files changed, 639 insertions(+), 329 deletions(-)
