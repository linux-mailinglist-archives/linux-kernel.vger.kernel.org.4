Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3973706337
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjEQIpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjEQIo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:44:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED555269F;
        Wed, 17 May 2023 01:44:54 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34H7xjvZ025469;
        Wed, 17 May 2023 08:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=0dTK9SqxayUN+1e9gRtbnM5n3yjd3BGdZ2EbdV92l70=;
 b=BWwdRE/NqF3lKPIkU+FaGMtkxpWV8VjGKdcTrvMMKMneZ785tLSCa3ub3yZ0ht6113XX
 Wn6cyWU/bN/iQvSSS1Um7PHJLqNYHXDNYrez4feU7OSzQ93SLraSvY+YqFs0b3mmIGtw
 l8e/1UN2eH/9MyIiK6CR1sh58joz8tu7iWisKRnMvCeziiWChamsXhQQNDO+V47YdaYj
 ilZMvSUJfVN5OrPWL1mR2JfgwuCGhMiuPm69YXj0btDBfpTytIlODPMSAHGW5GecnIOb
 b+vgLIETNfw3QgCfr0Lo5vzgAvR45xMGnDMWDu/kEsTzc/aAlcFxHanuSNHKrTybd8jV Tw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmbk79yfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 08:44:53 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34H8guA1023017;
        Wed, 17 May 2023 08:44:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3qj3mk5t6v-1;
        Wed, 17 May 2023 08:44:49 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34H8insv024372;
        Wed, 17 May 2023 08:44:49 GMT
Received: from hyd-e160-a01-1-05.qualcomm.com (hyd-e160-a01-1-05.qualcomm.com [10.147.154.233])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 34H8imt0024371;
        Wed, 17 May 2023 08:44:49 +0000
Received: by hyd-e160-a01-1-05.qualcomm.com (Postfix, from userid 2304101)
        id 015908CE2; Wed, 17 May 2023 14:14:47 +0530 (IST)
From:   Pradeep P V K <quic_pragalla@quicinc.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pradeep P V K <quic_pragalla@quicinc.com>
Subject: [PATCH V1] block: Fix null pointer dereference issue on struct io_cq
Date:   Wed, 17 May 2023 14:14:34 +0530
Message-Id: <20230517084434.18932-1-quic_pragalla@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cT6VP9PHtFRSQg5lakFs0OXVhKbLuZGg
X-Proofpoint-ORIG-GUID: cT6VP9PHtFRSQg5lakFs0OXVhKbLuZGg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 adultscore=0 priorityscore=1501 mlxlogscore=694 bulkscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170071
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential race between ioc_clear_fn() and
exit_io_context() as shown below, due to which below
crash is observed. It can also result into use-after-free
issue.

context#1:                           context#2:
ioc_release_fn()                     do_exit();
->spin_lock(&ioc->lock);             ->exit_io_context();
->ioc_destroy_icq(icq);              ->ioc_exit_icqs();
 ->list_del_init(&icq->q_node);       ->spin_lock_irq(&ioc->lock);
 ->call_rcu(&icq->__rcu_head,
     icq_free_icq_rcu);
->spin_unlock(&ioc->lock);
                                      ->ioc_exit_icq(); gets the same icq
				       ->bfq_exit_icq();
                                  This results into below crash as bic
				  is NULL as it is derived from icq.
				  There is a chance that icq could be
				  free'd as well.

[33.245722][ T8666] Unable to handle kernel NULL pointer dereference
at virtual address 0000000000000018.
...
Call trace:
[33.325782][ T8666]  bfq_exit_icq+0x28/0xa8
[33.325785][ T8666]  exit_io_context+0xcc/0x100
[33.325786][ T8666]  do_exit+0x764/0xa58
[33.325791][ T8666]  do_group_exit+0x0/0xa0
[33.325793][ T8666]  invoke_syscall+0x48/0x114
[33.325802][ T8666]  el0_svc_common+0xcc/0x118
[33.325805][ T8666]  do_el0_svc+0x34/0xd0
[33.325807][ T8666]  el0_svc+0x38/0xd0
[33.325812][ T8666]  el0t_64_sync_handler+0x8c/0xfc
[33.325813][ T8666]  el0t_64_sync+0x1a0/0x1a4

Fix this by checking with ICQ_DESTROYED flags in ioc_exit_icqs().
Also, ensure ioc_exit_icq() is accessing icq within rcu_read_lock/unlock
so that icq doesn't get free'd up while it is still using it.

Signed-off-by: Pradeep P V K <quic_pragalla@quicinc.com>
---
 block/blk-ioc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 63fc02042408..1aa34fd46ac8 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -60,10 +60,14 @@ static void ioc_exit_icqs(struct io_context *ioc)
 {
 	struct io_cq *icq;
 
+	rcu_read_lock();
 	spin_lock_irq(&ioc->lock);
-	hlist_for_each_entry(icq, &ioc->icq_list, ioc_node)
-		ioc_exit_icq(icq);
+	hlist_for_each_entry(icq, &ioc->icq_list, ioc_node) {
+		if (!(icq->flags & ICQ_DESTROYED))
+			ioc_exit_icq(icq);
+	}
 	spin_unlock_irq(&ioc->lock);
+	rcu_read_unlock();
 }
 
 /*
-- 
2.17.1

