Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580C27505C4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjGLLQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjGLLQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:16:28 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8CB1712;
        Wed, 12 Jul 2023 04:16:25 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C7Gr9Z029333;
        Wed, 12 Jul 2023 04:16:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=h6MSzMgdwhHEMHaGbBUnaVwDVxw9rvedzXFPSIWDzhY=;
 b=W0Ug4PEaTbqPmOw0LsqRRzE65Ap2AJWMaohUe5rkLoW0wv6QTUw7bTlRViO2vuHiMfs+
 FmMRXfqPsxmWryz5f05yfoL8oAjQN1/fPd8fiaNlEKt8bUN4CJHIOpbCjpfvwB7Cv5fr
 mc/OcCPht1giwslubZOVfEQOuwdwFlxqvkOFiP3VjEYmrKkjxrwP/M+1hcR7YuLR8cOv
 2Bj0uzofx1yHJ3crpIkk4khe0Yp7ChsR9saBrBMe8ED7+JrrKBZBtOq/WVV6V8KWNxOJ
 Iwp8/K5yMMBjWpcYvjHDZkz5SWs+JVGrW+Vhu0+w+nMmAYTkKhi+UKLvqKWvkwJZMP7U +g== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rsb7rbdhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 04:16:12 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 12 Jul
 2023 04:16:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 12 Jul 2023 04:16:11 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id B56533F703F;
        Wed, 12 Jul 2023 04:16:07 -0700 (PDT)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH 0/3] octeontx2-af: Fix issues with NPC field hash extract
Date:   Wed, 12 Jul 2023 16:46:01 +0530
Message-ID: <20230712111604.2290974-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: CCRGPVomIpl11iYlxFnCAsHNciRzmBa1
X-Proofpoint-ORIG-GUID: CCRGPVomIpl11iYlxFnCAsHNciRzmBa1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_06,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes the issues with NPC field hash extract. This feature is
supported only for CN10KB variant of CN10K series of silicons.

Patch #1 Fix hash extraction mbox message

Patch #2 Fix hash extraction enable configuration

Patch #3 Fix hash configuration for both source and destination IPv6

Suman Ghosh (3):
  octeontx2-af: Fix hash extraction mbox message
  octeontx2-af: Fix hash extraction enable configuration
  octeontx2-af: Fix hash configuration for both source and destination
    IPv6

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  16 +-
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  22 ++-
 .../marvell/octeontx2/af/rvu_npc_fs.h         |   4 +
 .../marvell/octeontx2/af/rvu_npc_hash.c       | 160 ++++++++++++------
 .../marvell/octeontx2/af/rvu_npc_hash.h       |  21 ++-
 5 files changed, 150 insertions(+), 73 deletions(-)

-- 
2.25.1

