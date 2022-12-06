Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D81643B0C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 03:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiLFCAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 21:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiLFCAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 21:00:21 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35CF11C1A;
        Mon,  5 Dec 2022 18:00:20 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5Nc5WY007253;
        Tue, 6 Dec 2022 02:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=AHpWGCjVFBEvNercQbQ1UN96WSruitA2aiZhvPdhNjU=;
 b=hIgELaJapQqfR4YcMafD0IHM5G4txV6TlYItU+64YnWqKhYYOtstLuX3LECVeaGwhzQQ
 WZj6XxJsPkYxtqvzSksGkDIQ+VkwhfGzoYwkf2RssWTPssIab0YAno/us9WPSmA5aLRG
 8H0xkvdzWeVk7ihBVqJLj0NX9xRKxeLXovMTXEi/zA27/Ej0/PIxeTSgAwjV7JQmpJ0L
 q7lQptZZ1HjL0lWVyLtEzRTIpkAMQFl8dpU5k3MEYa8c93lc7q1W3TjRrlGT+EHmhr4C
 pLPBS1kgAEF+/R27aHsBnYLE7UYdbLqeu6cm8ShnwJraMMUEWUaLZE4ocYNhKjd/wW8k IQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m7v5me4nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 02:00:15 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B620EcZ020410
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Dec 2022 02:00:14 GMT
Received: from aiquny2-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 5 Dec 2022 18:00:12 -0800
From:   Maria Yu <quic_aiquny@quicinc.com>
To:     <mathieu.poirier@linaro.org>, <andersson@kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Maria Yu <quic_aiquny@quicinc.com>, <quic_clew@quicinc.com>,
        <quic_mojha@quicinc.com>
Subject: [PATCH v6 0/1] remoteproc: core: do pm relax when in
Date:   Tue, 6 Dec 2022 09:59:56 +0800
Message-ID: <20221206015957.2616-1-quic_aiquny@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SOrdIRpD2gdEcUIO96h_dzZgKI_w8ikx
X-Proofpoint-GUID: SOrdIRpD2gdEcUIO96h_dzZgKI_w8ikx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=877 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212060012
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the remote processor is offline, no need to recover anything, and
pm_relax is needed to be called.


summary from some discussion points:

pm_stay_awake() is needed to stop and reverse the suspend process that
is currently underway.

RPROC_OFFLINE state indicate there is no recovery process
is in progress and no chance to do the pm_relax.
Because when recovering from crash, rproc->lock is held and
state is RPROC_CRASHED -> RPROC_OFFLINE -> RPROC_RUNNING,
and then unlock rproc->lock.
When the state is in RPROC_OFFLINE it means separate request
of rproc_stop was done and no need to hold the wakeup source
in crash handler to recover any more.


Changelog
===
V6
---
Address the comments.
Drop the allocate ordered workqueue change.

V5
---
Use goto out instead of directly call pm_relax and return. Suggested by
Mathieu.
Add new change with allocate ordered workqueue for allow only 1 active
work.

V4
---
Add pm relax when in RPROC_OFFLINE.

previous discussion here:
[1] https://lore.kernel.org/lkml/1bcd3fe8-f68d-ea7f-c0f9-68771e3421d5@quicinc.com/
[2] https://lore.kernel.org/linux-remoteproc/20221202094532.2925-1-quic_aiquny@quicinc.com/T/#t

Maria Yu (1):
  remoteproc: core: do pm_relax when in RPROC_OFFLINE state

 drivers/remoteproc/remoteproc_core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.17.1

