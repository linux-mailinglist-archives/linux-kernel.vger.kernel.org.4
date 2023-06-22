Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A29673A496
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjFVPS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjFVPS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:18:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1B418C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687447057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vfQ6quAmY6zsqtXluePc7kqeM9cJ8q//kXYeofi4FPg=;
        b=FQmGDT12CvEtxSrV8UpvIAMHVHCX6lmA9JO2uLZrdUM4qDllS46qzJ0XKT34wZz2zCgg+R
        dwlzTTQix/H0hNZ59rghZDiICVe2iglQRLxe8NNpumWJH3D93/C9uLjG9hu9a8W7lnyRqF
        C7tNHQ9sKypyeUGp+FMTx8mSbhi0Cmg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-onAN7T07POq-gREoJ5-BHg-1; Thu, 22 Jun 2023 11:17:33 -0400
X-MC-Unique: onAN7T07POq-gREoJ5-BHg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 260B9185A7BA;
        Thu, 22 Jun 2023 15:17:08 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E17C841EF82;
        Thu, 22 Jun 2023 15:17:06 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for 6.4-rc8
Date:   Thu, 22 Jun 2023 17:16:56 +0200
Message-Id: <20230622151656.54164-1-pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

This contains a last minute, slightly bigger than usual, series from
the netfilter subtree: it's mainly to address the recent issue you
have been CC-ed. I guess we want such fix included in 6.4.

There are no known issues pending.

The following changes since commit 40f71e7cd3c6ac04293556ab0504a372393838ff:

  Merge tag 'net-6.4-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-06-15 21:11:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.4-rc8

for you to fetch changes up to 2ba7e7ebb6a71407cbe25cd349c9b05d40520bf0:

  Merge tag 'nf-23-06-21' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2023-06-22 14:39:06 +0200)

----------------------------------------------------------------
Networking fixes for 6.4-rc8, including fixes from ipsec, bpf,
mptcp and netfilter.

Current release - regressions:

  - netfilter: add NFT_TRANS_PREPARE_ERROR to deal with bound set/chain

  - eth: mlx5e:
    - fix scheduling of IPsec ASO query while in atomic
    - free IRQ rmap and notifier on kernel shutdown

Current release - new code bugs:

  - phy: manual remove LEDs to ensure correct ordering

Previous releases - regressions:

  - mptcp: fix possible divide by zero in recvmsg()

  - dsa: revert "net: phy: dp83867: perform soft reset and retain established link"

Previous releases - always broken:

  - sched: netem: acquire qdisc lock in netem_change()

  - bpf:
    - fix verifier id tracking of scalars on spill
    - fix NULL dereference on exceptions
    - accept function names that contain dots

  - netfilter: disallow element updates of bound anonymous sets

  - mptcp: ensure listener is unhashed before updating the sk status

  - xfrm:
    - add missed call to delete offloaded policies
    - fix inbound ipv4/udp/esp packets to UDPv6 dualstack sockets

  - selftests: fixes for FIPS mode

  - dsa: mt7530: fix multiple CPU ports, BPDU and LLDP handling

  - eth: sfc: use budget for TX completions

Misc:

  - wifi: iwlwifi: add support for SO-F device with PCI id 0x7AF0

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'bpf: fix NULL dereference during extable search'

Andrew Lunn (1):
      net: phy: Manual remove LEDs to ensure correct ordering

Arınç ÜNAL (5):
      net: dsa: mt7530: set all CPU ports in MT7531_CPU_PMAP
      net: dsa: mt7530: fix trapping frames on non-MT7621 SoC MT7530 switch
      net: dsa: mt7530: fix handling of BPDUs on MT7530 switch
      net: dsa: mt7530: fix handling of LLDP frames
      MAINTAINERS: add me as maintainer of MEDIATEK SWITCH DRIVER

Azeem Shaikh (1):
      ieee802154: Replace strlcpy with strscpy

Benedict Wong (2):
      xfrm: Treat already-verified secpath entries as optional
      xfrm: Ensure policies always checked on XFRM-I input path

Benjamin Berg (1):
      wifi: mac80211: report all unusable beacon frames

Chen Aotian (1):
      ieee802154: hwsim: Fix possible memory leaks

Chris Mi (2):
      net/mlx5e: TC, Add null pointer check for hardware miss support
      net/mlx5e: TC, Cleanup ct resources for nic flow

Danielle Ratson (1):
      selftests: forwarding: Fix race condition in mirror installation

David S. Miller (4):
      Merge tag 'mlx5-fixes-2023-06-16' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge tag 'ieee802154-for-net-2023-06-19' of git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan
      Merge branch 'dsa-mt7530-fixes'
      Merge tag 'ipsec-2023-06-20' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec

Eli Cohen (1):
      net/mlx5: Fix driver load with single msix vector

Eric Dumazet (1):
      sch_netem: acquire qdisc lock in netem_change()

Florent Revest (1):
      bpf/btf: Accept function names that contain dots

Francesco Dolcini (1):
      Revert "net: phy: dp83867: perform soft reset and retain established link"

Herbert Xu (1):
      xfrm: Use xfrm_state selector for BEET input

Jakub Kicinski (3):
      Merge branch 'check-if-fips-mode-is-enabled-when-running-selftests'
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge branch 'mptcp-fixes-for-6-4'

Jiawen Wu (1):
      net: mdio: fix the wrong parameters

Jiri Olsa (1):
      bpf: Force kprobe multi expected_attach_type for kprobe_multi link

Josua Mayer (1):
      net: dpaa2-mac: add 25gbase-r support

Juerg Haefliger (2):
      ieee802154/adf7242: Add MODULE_FIRMWARE macro
      nfc: fdp: Add MODULE_FIRMWARE macros

Kees Cook (1):
      net: wwan: iosm: Convert single instance struct member to flexible array

Krister Johansen (2):
      bpf: ensure main program has an extable
      selftests/bpf: add a test for subprogram extables

Leon Romanovsky (4):
      xfrm: add missed call to delete offloaded policies
      net/mlx5e: Don't delay release of hardware objects
      net/mlx5e: Drop XFRM state lock when modifying flow steering
      net/mlx5e: Fix scheduling of IPsec ASO query while in atomic

Maciej Żenczykowski (2):
      xfrm: fix inbound ipv4/udp/esp packets to UDPv6 dualstack sockets
      revert "net: align SO_RCVMARK required privileges with SO_MARK"

Magali Lemes (4):
      selftests/harness: allow tests to be skipped during setup
      selftests: net: tls: check if FIPS mode is enabled
      selftests: net: vrf-xfrm-tests: change authentication and encryption algos
      selftests: net: fcnal-test: check if FIPS mode is enabled

Maxim Mikityanskiy (4):
      bpf: Fix verifier id tracking of scalars on spill
      selftests/bpf: Add test cases to assert proper ID tracking on spill
      net/mlx5e: XDP, Allow growing tail for XDP multi buffer
      net/mlx5e: xsk: Set napi_id to support busy polling on XSK RQ

Miquel Raynal (2):
      MAINTAINERS: Update wpan tree
      MAINTAINERS: Add wpan patchwork

Mukesh Sisodiya (1):
      wifi: iwlwifi: pcie: Handle SO-F device for PCI id 0x7AF0

Pablo Neira Ayuso (12):
      netfilter: nf_tables: fix chain binding transaction logic
      netfilter: nf_tables: add NFT_TRANS_PREPARE_ERROR to deal with bound set/chain
      netfilter: nf_tables: drop map element references from preparation phase
      netfilter: nft_set_pipapo: .walk does not deal with generations
      netfilter: nf_tables: fix underflow in object reference counter
      netfilter: nf_tables: disallow element updates of bound anonymous sets
      netfilter: nf_tables: reject unbound anonymous set before commit phase
      netfilter: nf_tables: reject unbound chain set before commit phase
      netfilter: nf_tables: disallow updates of anonymous sets
      netfilter: nf_tables: disallow timeout for anonymous sets
      netfilter: nf_tables: drop module reference after updating chain
      netfilter: nfnetlink_osf: fix module autoload

Paolo Abeni (7):
      mptcp: handle correctly disconnect() failures
      mptcp: fix possible divide by zero in recvmsg()
      mptcp: fix possible list corruption on passive MPJ
      mptcp: consolidate fallback and non fallback state machine
      mptcp: drop legacy code around RX EOF
      mptcp: ensure listener is unhashed before updating the sk status
      Merge tag 'nf-23-06-21' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Patrisious Haddad (1):
      net/mlx5e: Fix ESN update kernel panic

Phil Sutter (1):
      netfilter: nf_tables: Fix for deleting base chains with payload

Ross Lagerwall (1):
      be2net: Extend xmit workaround to BE3 chip

Saeed Mahameed (1):
      net/mlx5: Free IRQ rmap and notifier on kernel shutdown

Sebastian Andrzej Siewior (1):
      xfrm: Linearize the skb after offloading if needed.

Stefan Wahren (1):
      net: qca_spi: Avoid high load if QCA7000 is not available

Terin Stock (1):
      ipvs: align inner_mac_header for encapsulation

Vladimir Oltean (1):
      net: dsa: introduce preferred_default_local_cpu_port and use on MT7530

Yevgeny Kliteynik (2):
      net/mlx5: DR, Support SW created encap actions for FW table
      net/mlx5: DR, Fix wrong action data allocation in decap action

Yonghong Song (1):
      bpf: Fix a bpf_jit_dump issue for x86_64 with sysctl bpf_jit_enable.

Íñigo Huguet (1):
      sfc: use budget for TX completions

 MAINTAINERS                                        |  10 +-
 arch/x86/net/bpf_jit_comp.c                        |   2 +-
 drivers/net/dsa/mt7530.c                           |  48 ++-
 drivers/net/dsa/mt7530.h                           |   6 +
 drivers/net/ethernet/emulex/benet/be_main.c        |   4 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c   |   7 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |   8 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.h    |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c |   2 +
 .../net/ethernet/mellanox/mlx5/core/en/xsk/setup.c |   2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |  22 +-
 .../mellanox/mlx5/core/en_accel/ipsec_offload.c    |  17 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   7 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |  50 ++-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  |   7 +
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |  33 +-
 .../mellanox/mlx5/core/steering/dr_action.c        |  13 +-
 .../ethernet/mellanox/mlx5/core/steering/fs_dr.c   |  27 +-
 .../ethernet/mellanox/mlx5/core/steering/fs_dr.h   |   7 +
 .../ethernet/mellanox/mlx5/core/steering/mlx5dr.h  |   2 +
 drivers/net/ethernet/qualcomm/qca_spi.c            |   3 +-
 drivers/net/ethernet/sfc/ef10.c                    |  25 +-
 drivers/net/ethernet/sfc/ef100_nic.c               |   7 +-
 drivers/net/ethernet/sfc/ef100_tx.c                |   4 +-
 drivers/net/ethernet/sfc/ef100_tx.h                |   2 +-
 drivers/net/ethernet/sfc/tx_common.c               |   4 +-
 drivers/net/ethernet/sfc/tx_common.h               |   2 +-
 drivers/net/ieee802154/adf7242.c                   |   2 +
 drivers/net/ieee802154/mac802154_hwsim.c           |   6 +-
 drivers/net/phy/dp83867.c                          |   2 +-
 drivers/net/phy/mdio_bus.c                         |   2 +-
 drivers/net/phy/phy_device.c                       |  15 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   2 +
 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c         |  15 +-
 drivers/net/wwan/iosm/iosm_ipc_mux_codec.h         |   2 +-
 drivers/nfc/fdp/fdp.c                              |   3 +
 include/net/dsa.h                                  |   8 +
 include/net/netfilter/nf_tables.h                  |  31 +-
 include/net/xfrm.h                                 |   1 +
 kernel/bpf/btf.c                                   |  20 +-
 kernel/bpf/syscall.c                               |   5 +
 kernel/bpf/verifier.c                              |  10 +-
 net/core/sock.c                                    |   6 -
 net/dsa/dsa.c                                      |  24 +-
 net/ieee802154/trace.h                             |   2 +-
 net/ipv4/esp4_offload.c                            |   3 +
 net/ipv4/xfrm4_input.c                             |   1 +
 net/ipv6/esp6_offload.c                            |   3 +
 net/ipv6/xfrm6_input.c                             |   3 +
 net/mac80211/rx.c                                  |   2 +-
 net/mac802154/trace.h                              |   2 +-
 net/mptcp/pm_netlink.c                             |   1 +
 net/mptcp/protocol.c                               | 160 ++++-----
 net/mptcp/protocol.h                               |   5 +-
 net/mptcp/subflow.c                                |  17 +-
 net/netfilter/ipvs/ip_vs_xmit.c                    |   2 +
 net/netfilter/nf_tables_api.c                      | 366 +++++++++++++++++----
 net/netfilter/nfnetlink_osf.c                      |   1 +
 net/netfilter/nft_immediate.c                      |  90 ++++-
 net/netfilter/nft_set_bitmap.c                     |   5 +-
 net/netfilter/nft_set_hash.c                       |  23 +-
 net/netfilter/nft_set_pipapo.c                     |  20 +-
 net/netfilter/nft_set_rbtree.c                     |   5 +-
 net/netfilter/xt_osf.c                             |   1 -
 net/sched/sch_netem.c                              |   8 +-
 net/xfrm/xfrm_input.c                              |   8 +-
 net/xfrm/xfrm_interface_core.c                     |  54 ++-
 net/xfrm/xfrm_policy.c                             |  14 +
 .../selftests/bpf/prog_tests/subprogs_extable.c    |  29 ++
 .../selftests/bpf/progs/test_subprogs_extable.c    |  51 +++
 .../selftests/bpf/progs/verifier_spill_fill.c      |  79 +++++
 tools/testing/selftests/kselftest_harness.h        |   6 +-
 tools/testing/selftests/net/fcnal-test.sh          |  27 +-
 .../net/forwarding/mirror_gre_bridge_1d.sh         |   4 +
 .../net/forwarding/mirror_gre_bridge_1q.sh         |   4 +
 tools/testing/selftests/net/tls.c                  |  24 +-
 tools/testing/selftests/net/vrf-xfrm-tests.sh      |  32 +-
 78 files changed, 1178 insertions(+), 351 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subprogs_extable.c

