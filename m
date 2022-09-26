Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA5D5EA907
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbiIZOwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbiIZOvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:51:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DFB8FD41;
        Mon, 26 Sep 2022 06:17:03 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QBgMoQ004765;
        Mon, 26 Sep 2022 13:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=yzaBqGlmr9z0WILYDL7+0YEOCV7bF7YOavzmZIkGJY4=;
 b=R7dwZWzQ7S04vsq2rMwvlqaCZJ3qehDbobZjTzkGRyid769mtos/MPmqZP2A9OlHDzLa
 iemmjpskP53nbwmab/oKH5OD88k3MeeeKd5mvfDtDTqxoWRkUfV7n8iNvCWZFlUUhSfy
 Lz2rgYVi52u27lzU4ixJ21N+K0tNJz/b0M/AIPQ31YRHoK2mtXhd5T0c/fv/NUHVtgFQ
 KvQ+tFOKq2/J6Dq8nK2HrccrnlmvFv2Qst2lzOhQPKP+CETyovdswLGb6jkwoIe7Q7Pq
 +aZbDGDr35+AhBd19aDrJPWjJ6variJazsPbwkybd1CWRaRQs66QQwaoGLyyrkYJvh8g nA== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ju8kh782t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 13:16:45 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28QD6CtU011689;
        Mon, 26 Sep 2022 13:16:44 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01wdc.us.ibm.com with ESMTP id 3jt40rk43w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 13:16:44 +0000
Received: from smtpav01.dal12v.mail.ibm.com ([9.208.128.133])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28QDGh7P12911048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 13:16:43 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C48758057;
        Mon, 26 Sep 2022 13:16:43 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 512CA58059;
        Mon, 26 Sep 2022 13:16:43 +0000 (GMT)
Received: from localhost (unknown [9.163.91.170])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 26 Sep 2022 13:16:43 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jmorris@namei.org, mpe@ellerman.id.au, paul@paul-moore.com,
        serge@hallyn.com, ajd@linux.ibm.com, gcwilson@linux.ibm.com,
        nayna@linux.ibm.com
Subject: [PATCH v2 0/2] powerpc/pseries: restrict error injection and DT changes when locked down
Date:   Mon, 26 Sep 2022 08:16:41 -0500
Message-Id: <20220926131643.146502-1-nathanl@linux.ibm.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1bov1B5pxHJJ6EuhXp0wwiyMVTePjLRe
X-Proofpoint-ORIG-GUID: 1bov1B5pxHJJ6EuhXp0wwiyMVTePjLRe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_08,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 impostorscore=0 adultscore=0 mlxlogscore=863 phishscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two new lockdown reasons for use in powerpc's pseries platform
code.

The pseries platform allows hardware-level error injection via certain
calls to the RTAS (Run Time Abstraction Services) firmware. ACPI-based
error injection is already restricted in lockdown; this facility
should be restricted for the same reasons.

pseries also allows nearly arbitrary device tree changes via
/proc/powerpc/ofdt. Just as overriding ACPI tables is not allowed
while locked down, so should this facility be restricted.

Changes since v1:
* Move LOCKDOWN_DEVICE_TREE next to LOCKDOWN_ACPI_TABLES.

Nathan Lynch (2):
  powerpc/pseries: block untrusted device tree changes when locked down
  powerpc/rtas: block error injection when locked down

 arch/powerpc/kernel/rtas.c                | 25 ++++++++++++++++++++++-
 arch/powerpc/platforms/pseries/reconfig.c |  5 +++++
 include/linux/security.h                  |  2 ++
 security/security.c                       |  2 ++
 4 files changed, 33 insertions(+), 1 deletion(-)

-- 
2.37.3

