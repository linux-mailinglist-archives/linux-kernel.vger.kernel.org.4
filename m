Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C35E6116C5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJ1QEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiJ1QDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:03:52 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842562265B0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:01:08 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SFnm6s031754;
        Fri, 28 Oct 2022 16:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=nQq60V1oo5J1R3ASm51G6DPiVcrtmxiC1pICdKF43hg=;
 b=sclVKHF0y2hmKYrbhujVHiQSuTBhtWhVK5GLeFxJt5svHnwqmURbV9DHH0QaFZ2827kf
 qJHIIufLS6n4XnH+Z5Iz+6iTZvzQYvQtk8FzmJdiIdlRn+5Ip5N5yrtZsUPPqStNG9pd
 HpJ2Dv6wpW6hw4Kq7zOFMttKso3fKptFhpioYCRwCWu1IcPmmEB/TcMmyEt1j0YxSGzi
 TES0jX0FSFMl/EI8g7Y1rxHxX/upujC2KrnMrCVbuGQw14rpvbEGSAC//yGinmAWVwvO
 9gFh2F4V2XOjuOs19J89vhAdpxBd8ZgUSwQy6D1FYD3XBXwu9RLaZszhFJoRcMG1JRAo Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kgj2n8a8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 16:00:40 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29SFobSS002110;
        Fri, 28 Oct 2022 16:00:40 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kgj2n8a7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 16:00:40 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29SFoZK3026796;
        Fri, 28 Oct 2022 16:00:38 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3kfahd2u2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 16:00:38 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29SG0ZXc64553266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 16:00:35 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CADFE11C04C;
        Fri, 28 Oct 2022 16:00:35 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85D4011C050;
        Fri, 28 Oct 2022 16:00:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.94.157])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Oct 2022 16:00:35 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Consider the size of the added CPU nodes in the kexec FDT
Date:   Fri, 28 Oct 2022 18:00:32 +0200
Message-Id: <20221028160034.44400-1-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3Pkl365ZxNgnF8-rgtoZ6S6KvVLjQLHX
X-Proofpoint-GUID: AvFhshpIl_JIZaWRakBzBdxt3W0jsZ_0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=945
 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280097
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

Laurent Dufour (2):
  powerpc: export the CPU node count
  powerpc: Take in account addition CPU node when building kexec FDT

 arch/powerpc/include/asm/kexec_ranges.h |  2 +
 arch/powerpc/kernel/prom.c              |  4 ++
 arch/powerpc/kexec/file_load_64.c       | 59 ++++++++++++++++++++++++-
 3 files changed, 64 insertions(+), 1 deletion(-)

-- 
2.38.1

