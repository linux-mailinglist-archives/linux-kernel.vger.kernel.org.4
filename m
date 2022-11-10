Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A619624907
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiKJSGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiKJSGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:06:38 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE60463C0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 10:06:36 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAGL0nG029537;
        Thu, 10 Nov 2022 18:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=x9qGOFXLRv+uNhIKAtTPNY7eA9HL4PsoZn3ZoDOZtmc=;
 b=P7QJDLBUTHyO2UG5q42yrD5YlRcaPfb5XoitdtYpkCHHZr/4ZO7UnOcPgGybUcQqxorv
 4S1/bb4AA4FEwxCoG7Ph8sWWw/99qiXrQaMD55kKTz5GutHy1GTD+DhKBkEffZ9bEfqS
 Y95LyXh3Ah2jxWq7vXdez+pRaDXw8+Bjg9yZeJ2lV3KuPaMSkEfNMokBeZbnXpbAXPi2
 wytGaztF7SjvlHGloZIyH6y0o/jBzZDiE9k2DhRdi6qeaXVfu17oTBHlsgwhwzTAUjiL
 IFv27ESBFKCiXAqcNETl3C5aIIS17Ei89IfDvAgzupsbA87zUbVBn2S9qWYtchVcfru3 hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ks4r9kevv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 18:06:26 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AAHxovq004044;
        Thu, 10 Nov 2022 18:06:26 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ks4r9keuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 18:06:26 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AAI6N2M018071;
        Thu, 10 Nov 2022 18:06:23 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3kngncfnex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 18:06:23 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AAI6LTI36569638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 18:06:21 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 888AEAE04D;
        Thu, 10 Nov 2022 18:06:21 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35443AE045;
        Thu, 10 Nov 2022 18:06:21 +0000 (GMT)
Received: from pomme.tlslab.ibm.com (unknown [9.101.4.33])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Nov 2022 18:06:21 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Consider the size of the added CPU nodes in the kexec FDT
Date:   Thu, 10 Nov 2022 19:06:17 +0100
Message-Id: <20221110180619.15796-1-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zoVLFG3OJV6pHXkxWDfLyhBtQByd5MIx
X-Proofpoint-ORIG-GUID: zc8BYcdGoR9I64qUgwW1AI7Hpx_-H7et
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_12,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211100126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding CPUs to an already big system (test show it seems to start with
more than 256 CPUs), the kernel is showing error messages when building the
FDT for the kexec kernel (kdump or kexec).

It's worth to mention that the kdump kernel is reloaded after a CPU add
operation.

The messages look like (property's name may vary):
10175.025675] Unable to add 32-64-bridge property: FDT_ERR_NOSPACE

This happens because the size of the FDT is computed based on the size of
the FDT the kernel received at boot time. There is additional space added
in kexec_extra_fdt_size_ppc64() for the added memory but nothing is done
for the added CPUs.

This patch adds this feature so adding new CPUs will increase the size of
the FDT for the kexec kernel.

To compute the additional size required, the number of CPU nodes of the
initial FDT (the one the kernel receive at boot time) are recorded. When a
kexec FDT is created, the number of CPU nodes in the current FDT is used to
compute the additional size.

The first patch of this series is creating a variable provided by the boot
code when parsing the initial FDT at boot time.
The second patch is computing the required additional space.

This has been tested on a PowerVM LPAR running with than 256 CPUs in shared
mode, adding 320 CPUs to this LPAR.

Changes in v2:
 - Fix build issue, moving definition in prom.h

Laurent Dufour (2):
  powerpc: export the CPU node count
  powerpc: Take in account addition CPU node when building kexec FDT

 arch/powerpc/include/asm/prom.h   |  1 +
 arch/powerpc/kernel/prom.c        |  3 ++
 arch/powerpc/kexec/file_load_64.c | 60 ++++++++++++++++++++++++++++++-
 3 files changed, 63 insertions(+), 1 deletion(-)

-- 
2.38.1

