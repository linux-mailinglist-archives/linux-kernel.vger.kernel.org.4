Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9275D7434F5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjF3G3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjF3G25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:28:57 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BBD2D63;
        Thu, 29 Jun 2023 23:28:56 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U2CEBx013690;
        Thu, 29 Jun 2023 23:28:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=9Bvkz/qrPlZ1RuCWBWAW2Wv28bCFJ/X2QQfgD7njmkI=;
 b=RwYcHKfIb+UuyTi4jSYDiVk31wPuBDSsj2xFsngki6pSWGcDwJdyqH8lSBFbuaorTdI8
 hwjDaA6xySSVnAFncy3fVc1b05Fj55QcbmjbOnXXYmL3wRFcVIGHakY3z9aTyy4u8+nm
 DCyRLxc5B5y+//avxhj30TT/liqHSgUnKin8aSwq5xpwqss9O01hw0Yu2yVJKph0+utP
 lA+8oDcri/PYUv8Vr4Z0EOlHnb5iYF4mcvVOjqTIk+VirDPOmF3d/Rie5scBRP+epksY
 tS9OBqUhLNwAA/mSVEYJZfERJ3wEeHGjrWFhkS4uRNBaywdDOeryeu5988ArfwV4HZzu 3Q== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rhp2egqsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 23:28:51 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 29 Jun
 2023 23:28:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 29 Jun 2023 23:28:49 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id C17353F707B;
        Thu, 29 Jun 2023 23:28:45 -0700 (PDT)
From:   Hariprasad Kelam <hkelam@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <davem@davemloft.net>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <gakula@marvell.com>, <jerinj@marvell.com>,
        <sbhatta@marvell.com>
Subject: [net Patch 0/4] octeontx2-af: MAC block fixes for CN10KB
Date:   Fri, 30 Jun 2023 11:58:41 +0530
Message-ID: <20230630062845.26606-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bLmbOZyAaLRUZXOc1RY3xwcPm4QM9Q1d
X-Proofpoint-GUID: bLmbOZyAaLRUZXOc1RY3xwcPm4QM9Q1d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_03,2023-06-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set contains fixes for the issues encountered in testing
CN10KB MAC block RPM_USX.

Patch1: firmware to kernel communication is not working due to wrong
        interrupt configuration. CSR addresses are corrected.

Patch2: NIX to RVU PF mapping errors encountered due to wrong firmware
        config. Corrects this mapping error.

Patch3: Driver is trying to access non exist cgx/lmac which is resulting
        in kernel panic. Address this issue by adding proper checks.

Patch4: MAC features are not getting reset on FLR. Fix the issue by
        resetting the stale config.



Hariprasad Kelam (4):
  octeontx2-af: cn10kb: fix interrupt csr addresses
  octeontx2-af: Fix mapping for NIX block from CGX connection
  octeontx2-af: Add validation before accessing cgx and lmac
  octeontx2-af: Reset MAC features in FLR

 .../net/ethernet/marvell/octeontx2/af/cgx.c   | 33 +++++++++++++++++--
 .../net/ethernet/marvell/octeontx2/af/cgx.h   |  2 ++
 .../marvell/octeontx2/af/lmac_common.h        |  3 ++
 .../net/ethernet/marvell/octeontx2/af/rpm.c   | 32 +++++++++++++++---
 .../net/ethernet/marvell/octeontx2/af/rpm.h   |  5 ++-
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  1 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   | 12 +++++++
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 20 ++++++++++-
 8 files changed, 99 insertions(+), 9 deletions(-)

--
2.17.1
