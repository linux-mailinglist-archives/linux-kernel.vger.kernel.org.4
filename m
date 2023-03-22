Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F806C5453
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjCVS6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjCVS5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:57:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61A7664D5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:56:56 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MIMkjQ030889;
        Wed, 22 Mar 2023 18:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=nXUkYuAUVgMJXfQ1b2OVpiN3TmnwlbMSYdai19XO/8o=;
 b=uJjJm+G2o9N9d0ehFB2lSzjMQcXhAkWVETOR7f1AqC7N/z6FVP10KCVZzVLoim1XlKcE
 FW6+mcYltY9Qp3jYMkh3LpiBWhvGV6Z763IXxd4W8NjTUX1X5yDooJ6WufiIdB4IiDNa
 IQFAL509YYR8+sGFZnIsLjrRVD+7vFeJE+cxXK/3EALlV85JiBzFTD79+FOW/k/CNxKC
 kzbOOqAe2r9PxDpPzf4XoVyLQTLPoalymfHO4QiI9xGMZg7og3xhzOmgYwaq+h9QiuWZ
 ae1h8NpdYmPvcP8Bwetd7gnrVOSooy6LF1nwkHMBUZoVW4hDHuHn7j69U/KXGIiiFjHZ uw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd56b1qrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 18:56:10 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32MIWp9n002235;
        Wed, 22 Mar 2023 18:56:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pg7238srj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 18:56:08 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32MIu8UY000312;
        Wed, 22 Mar 2023 18:56:08 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-169-59.vpn.oracle.com [10.154.169.59])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pg7238spf-1;
        Wed, 22 Mar 2023 18:56:07 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com
Subject: [PATCH 1/1] vhost_task: Fix vhost_task_create return value
Date:   Wed, 22 Mar 2023 13:56:05 -0500
Message-Id: <20230322185605.1307-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_15,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=949
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303220131
X-Proofpoint-ORIG-GUID: aHz4IwfU2BEZ_HtlkxtmGjInSvl1fI5p
X-Proofpoint-GUID: aHz4IwfU2BEZ_HtlkxtmGjInSvl1fI5p
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vhost_task_create is supposed to return the vhost_task or NULL on
failure. This fixes it to return the correct value when the allocation
of the struct fails.

Fixes: 77feab3c4156 ("vhost_task: Allow vhost layer to use copy_process") # mainline only
Reported-by: syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com
Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 kernel/vhost_task.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index 4b8aff160640..b7cbd66f889e 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -88,7 +88,7 @@ struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
 
 	vtsk = kzalloc(sizeof(*vtsk), GFP_KERNEL);
 	if (!vtsk)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 	init_completion(&vtsk->exited);
 	vtsk->data = arg;
 	vtsk->fn = fn;
-- 
2.25.1

