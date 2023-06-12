Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F2972B7E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 08:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbjFLGFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 02:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjFLGEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 02:04:49 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C50DE7D;
        Sun, 11 Jun 2023 23:04:48 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35BNWKV3031749;
        Sun, 11 Jun 2023 23:04:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=WxXrhLiO/deqX4GO8SgnzMggY2nlYSYf6AEF7SJQ1qA=;
 b=Qo/Wtk0C3QGcCkbVgXQNc3fzy7L1aFEyvd22zsCTOoTyLQf2OiDpwJZeiUxyKtqlDe3n
 cwZDLI4JHaIKFAOav7gMyiJFBfVGwEfz5uDItVxzc+0l3zFj6yv+FVc4SqXVegN0cfIm
 0c5HptWG2+S+rpO9OO1uZUx/foOC25eh5gfh/llcsnv9zmaTAB6ot6kzKYGjjAleeYq4
 VfQCaCPXXQdYMgNdor5fhK3TcnwlSNwfauwABXyVye0JvDAfF724GCoYuKbEk6KSsJRo
 FP9/x0/oxkOeNZ8tVLI9djVSgEkcliFYz++6AYGdQnH90qD2y0SQodp/zEKmq9m3mKhC Vw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3r4rpkbenf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 11 Jun 2023 23:04:30 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 11 Jun
 2023 23:04:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 11 Jun 2023 23:04:29 -0700
Received: from #hyd1583.marvell.com (unknown [10.29.37.44])
        by maili.marvell.com (Postfix) with ESMTP id 885375B6943;
        Sun, 11 Jun 2023 23:04:26 -0700 (PDT)
From:   Naveen Mamindlapalli <naveenm@marvell.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>
CC:     Naveen Mamindlapalli <naveenm@marvell.com>
Subject: [net-next PATCH v2 0/6] RVU NIX AF driver updates
Date:   Mon, 12 Jun 2023 11:34:18 +0530
Message-ID: <20230612060424.1427-1-naveenm@marvell.com>
X-Mailer: git-send-email 2.39.0.198.ga38d39a4c5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: h5Zk2uNddZ4pHOwnQNr2HCrNAivDso83
X-Proofpoint-GUID: h5Zk2uNddZ4pHOwnQNr2HCrNAivDso83
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_03,2023-06-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series includes a few enhancements and other updates to the
RVU NIX AF driver.

The first patch adds devlink option to configure NPC MCAM high priority
zone entries reservation. This is useful when the requester needs more
high priority entries than default reserved entries.

The second patch adds support for RSS hash computation using L3 SRC or
DST only, or L4 SRC or DST only.

The third patch updates DWRR MTU configuration for CN10KB silicon. HW uses 
the DWRR MTU to compute DWRR weight.

Patch 4 configures the LBK link in TL3_TL2 configuration only when switch
mode is enabled.

Patch 5 adds an option in the mailbox request to enable/disable DROP_RE bit
which drops packets with L2 errors when set.

Patch 6 updates SMQ flush mechanism to stop other child nodes from
enqueuing any packets while SMQ flush is active. Otherwise SMQ flush may
timeout.

Kiran Kumar K (1):
  octeontx2-af: extend RSS supported offload types

Naveen Mamindlapalli (2):
  octeontx2-af: Add devlink option to adjust mcam high prio zone entries
  octeontx2-af: Set XOFF on other child transmit schedulers during SMQ
    flush

Nithin Dabilpuram (1):
  octeontx2-af: add option to toggle DROP_RE enable in rx cfg

Subbaraya Sundeep (1):
  octeontx2-af: Enable LBK links only when switch mode is on.

Sunil Goutham (1):
  octeontx2-af: cn10k: Set NIX DWRR MTU for CN10KB silicon

---
v2:
    Rebased on net-next/main.

 .../ethernet/marvell/octeontx2/af/common.h    |   7 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  11 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  20 ++
 .../marvell/octeontx2/af/rvu_devlink.c        |  74 +++++-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 247 ++++++++++++++++--
 .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   3 +-
 .../marvell/octeontx2/af/rvu_switch.c         |  18 ++
 .../marvell/octeontx2/nic/otx2_common.c       |  18 +-
 .../marvell/octeontx2/nic/otx2_common.h       |   1 +
 9 files changed, 379 insertions(+), 20 deletions(-)

-- 
2.39.0.198.ga38d39a4c5

