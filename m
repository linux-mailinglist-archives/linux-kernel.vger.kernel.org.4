Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A7A739BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjFVJEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjFVJDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:03:40 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4FB26A4;
        Thu, 22 Jun 2023 01:57:50 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35M5m9UG020385;
        Thu, 22 Jun 2023 01:56:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=lXo91VsWjtu849hH0/JLlNIbeEZKQUMSSEievCrhNyY=;
 b=YALfU6u/CAJuEoD8oksS4dPlnxmVgGP7TUiJA2GV7YrI4zauYzT2GEPheeMzi/S5YJT8
 0MlgK5F8utUx9Qj262jz8wVUD9dSYDCmrtfa6RMIgBFgnRrlcn7RAMwrl35omxNEGZ5T
 E4lZAPRXpT8Ez7X3ZQMCPUMWuB0062ThqOWCUiN2z/l9vGUr9LLnJhY6V3pZSeiMR04D
 XC0sXWIDj/G1MyRvf+Ym1OgQsps+H/wZWPxDOEqs/bH2cdhsuTIb5/7nc69DpR7EnYck
 HmCLsS8vJSP98iXlRLE4Hgp79CMChBHB+YK3Q8ZE8c4OcbspmjcAOQvkMJL5B9kzVGoK ow== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3rc97dhe4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 01:56:47 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 22 Jun
 2023 01:56:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 22 Jun 2023 01:56:45 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 2C10F3F7063;
        Thu, 22 Jun 2023 01:56:39 -0700 (PDT)
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
Subject: [net-next Patch 0/3] octeontx2-pf: support Round Robin scheduling
Date:   Thu, 22 Jun 2023 14:26:35 +0530
Message-ID: <20230622085638.3509-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: vVPCThR8ybEWy1uejaJgzVpC3WZ7oujF
X-Proofpoint-ORIG-GUID: vVPCThR8ybEWy1uejaJgzVpC3WZ7oujF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_05,2023-06-16_01,2023-05-22_02
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
