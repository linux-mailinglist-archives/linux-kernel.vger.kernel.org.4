Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70AC73D86A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 09:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjFZHYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 03:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFZHYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 03:24:35 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF661AC;
        Mon, 26 Jun 2023 00:24:34 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35Q4cFVa013318;
        Mon, 26 Jun 2023 00:24:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=fqHrSBL3hoY+JjPtKwIfd8KWeoYZRh46fiQOckzwMdQ=;
 b=XGxYJz1AFJt4HQZiGZ1PFAWXQePEYmRTYH1KXucCFPzM33drrEjWavsQVnMk1rzUfHQ5
 QnUcm991Hz8v6pLIZDIZqlsRAui7mPcw+j2wQc7N0NXa+QDN0IyPMMXt7RCbiqrWWEsG
 jv/je2u/g/4iJwqyLLeAD/+NcHeE9rwEHxjej9glfODinXDk2cLH/BSxr8Xf9TM9ne7j
 lodr9nCq/6X73rtHgCz+t7K1RR917rfNxvKgPBSzPbMC62au+kK+V0UgLIm6aS02edkE
 u20iF7jJ2mnPlayCMkm2/O0PvphFiItjnPQEdCE+PPO7T+JwMdbccipHK3RYgu9Hm4o5 UA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3re00juuf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 00:24:16 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 26 Jun
 2023 00:24:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 26 Jun 2023 00:24:14 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id A2F693F7063;
        Mon, 26 Jun 2023 00:24:08 -0700 (PDT)
From:   Hariprasad Kelam <hkelam@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>,
        <willemdebruijn.kernel@gmail.com>, <andrew@lunn.ch>,
        <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <naveenm@marvell.com>, <edumazet@google.com>,
        <pabeni@redhat.com>, <jhs@mojatatu.com>,
        <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <maxtram95@gmail.com>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
Subject: [net-next Patchv2 0/3] support Round Robin scheduling
Date:   Mon, 26 Jun 2023 12:54:04 +0530
Message-ID: <20230626072407.32158-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: vNeRXWrTxbJqQtv2s7bxOfdxXm9gdQPh
X-Proofpoint-ORIG-GUID: vNeRXWrTxbJqQtv2s7bxOfdxXm9gdQPh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_04,2023-06-22_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

octeontx2 and CN10K silicons support Round Robin scheduling. When multiple
traffic flows reach transmit level with the same priority, with Round Robin
scheduling traffic flow with the highest quantum value is picked. With this
support, the user can add multiple classes with the same priority and
different quantum in htb offload.

This series of patches adds support for the same.

Patch1: implement transmit schedular allocation algorithm as preparation
        for support round robin scheduling.

Patch2: Allow quantum parameter in HTB offload mode.

Patch3: extends octeontx2 htb offload support for  Round Robin scheduling


Naveen Mamindlapalli (3):
  octeontx2-pf: implement transmit schedular allocation algorithm
  sch_htb: Allow HTB quantum parameter in offload mode
  octeontx2-pf: htb offload support for Round Robin scheduling
--
v2 * change data type of otx2_index_used to reduce size of structure
     otx2_qos_cfg


 .../marvell/octeontx2/nic/otx2_common.c       |   1 +
 .../marvell/octeontx2/nic/otx2_common.h       |   1 +
 .../net/ethernet/marvell/octeontx2/nic/qos.c  | 347 ++++++++++++++++--
 .../net/ethernet/marvell/octeontx2/nic/qos.h  |  11 +-
 .../net/ethernet/mellanox/mlx5/core/en/qos.c  |   4 +-
 include/net/pkt_cls.h                         |   1 +
 net/sched/sch_htb.c                           |   7 +-
 7 files changed, 329 insertions(+), 43 deletions(-)

--
2.17.1
