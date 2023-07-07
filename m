Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F15774AF30
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 12:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjGGK4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 06:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjGGK4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:56:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C80F1BE1;
        Fri,  7 Jul 2023 03:56:31 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367AiOqu009053;
        Fri, 7 Jul 2023 10:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=YpkU4DETyxze9YQ5B6pozKdSgx24FBvCZkjftOAClB4=;
 b=I5vphQjF1NBjdXo/8Z7mxYOQpfei5s5BVnJ49ZeglGOScTVwixDgwWtvCUyZbTrr0Ewv
 je8V1YVODNrMnouasa+151NsgKYEvptYGDWvWI6jN1Z08WPw85utXQiVlKmwiKacFT11
 8oN1ubLrwrKFlDsgVgrdc2YUYO1VfajBa/H4bjj5QH5IjylvWQGyZlfymYQvi1sIodDA
 vwp11CK+G8nynaGgUBkZ5xahUuxnKhEyj25wtw0G+b36Dj+WeM3kKnsyIyb2N/Xnl4GJ
 DnWMmpWMrVLnn5P4hoMQKV+Mt9bNHE4S0IA7fY2972sYSZwvXdnf4ihrsQqdSd0FDT88 SA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rph76883q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 10:56:30 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 367AlxAh018828;
        Fri, 7 Jul 2023 10:56:29 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rph76882r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 10:56:29 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3677TDri007387;
        Fri, 7 Jul 2023 10:56:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3rjbs4tvs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 10:56:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 367AuNvr27656852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jul 2023 10:56:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88B2A20040;
        Fri,  7 Jul 2023 10:56:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 355382004B;
        Fri,  7 Jul 2023 10:56:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  7 Jul 2023 10:56:23 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Paolo Abeni <pabeni@redhat.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/3] s390/ism: Fixes to client handling
Date:   Fri,  7 Jul 2023 12:56:19 +0200
Message-Id: <20230707105622.3332261-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LOu2cITEhNnJDZxzXtNwP9WGU21Im7yM
X-Proofpoint-GUID: ry0gpWASMMY4oGaPGLwfOKojkb9VBgQH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_06,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=716 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi networking developers,

This is v2 of the patch previously titled "s390/ism: Detangle ISM client
IRQ and event forwarding". As suggested by Paolo Abeni I split the patch
up. While doing so I noticed another problem that was fixed by this patch
concerning the way the workqueues access the client structs. This means the
second patch turning the workqueues into simple direct calls also fixes
a problem. Finally I split off a third patch just for fixing
ism_unregister_client()s error path.

The code after these 3 patches is identical to the result of the v1 patch
except that I also turned the dev_err() for still registered DMBs into
a WARN().

Thanks,
Niklas

Changes since v1:
- Split into three patches (Paolo Abeni)
- Turned the dev_err() in ism_unregsiter_client() on still registered DMBs
  into a WARN() as it should only happen due to client bugs.

Niklas Schnelle (3):
  s390/ism: Fix locking for forwarding of IRQs and events to clients
  s390/ism: Fix and simplify add()/remove() callback handling
  s390/ism: Do not unregister clients with registered DMBs

 drivers/s390/net/ism_drv.c | 153 ++++++++++++++++++-------------------
 include/linux/ism.h        |   7 +-
 2 files changed, 74 insertions(+), 86 deletions(-)


base-commit: d528014517f2b0531862c02865b9d4c908019dc4
-- 
2.39.2

