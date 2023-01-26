Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF0767CBD6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbjAZNPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236603AbjAZNOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:14:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649636536C
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:14:36 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QDCPGZ030893;
        Thu, 26 Jan 2023 13:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=Xu1V32uapK60jhhMREIdzRlkxvWtwJFAQecaUzUpUWQ=;
 b=VMsAGn+RFMfyytVXrF+zEWNHq61s++nUPOr5Tcef4JC4o/3bJtbB8C5D5g+ihxc2dnZm
 jyMRaJoF7TF6emSNI2R3kiYsfTEDZtf7jwjfvcuAB/R+RtlcdOeatztGfvEyrOa635Pe
 eUWv2f+fsZvqOZpRy7Ciwxt30JVgL1UkMbJ453ZICJakT56QbB5J2lopIdih27QZphdq
 TFqPSuj0Sz77dGwROyd6EW3lRiDHhoqEmKnTRqWrMdQcLo2k0n/G01qSbXjfdAr1JBEx
 PhG1yFVd0hdwf5DMZ5TYsJmjKszJAJzGti0on74G8wv6+GcNM+WEYizSJMZBwD3D6iJa SQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbt6mr1ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 13:14:35 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QBMXF2010330;
        Thu, 26 Jan 2023 13:14:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6pdjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 13:14:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30QDETBk50201008
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 13:14:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5716420043;
        Thu, 26 Jan 2023 13:14:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 222C420040;
        Thu, 26 Jan 2023 13:14:29 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jan 2023 13:14:29 +0000 (GMT)
From:   Mikhail Zaslonko <zaslonko@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>
Subject: [PATCH 0/8] lib/zlib: Set of s390 DFLTCC related patches for kernel zlib
Date:   Thu, 26 Jan 2023 14:14:20 +0100
Message-Id: <20230126131428.1222214-1-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N9_R9_5QbY3cGJL0f2AVpIkN4LojfvBn
X-Proofpoint-GUID: N9_R9_5QbY3cGJL0f2AVpIkN4LojfvBn
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_05,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 malwarescore=0 mlxlogscore=516
 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches 1-7 represent a set of s390 zlib hardware support (DFLTCC) related fixes
and enhancements integrated from zlib-ng repo relevant to kernel zlib
(https://github.com/zlib-ng/zlib-ng).
Since the official zlib repository never got DFLTCC support code merged, all
the patches have been picked from zlib-ng fork (zlib data compression library
for the next generation systems). This repo contains new optimizations and
fixes not getting implemented into the official zlib repository and falls under
the same zlib License. All of the original patches from zlib-ng were authored
by Ilya Leoshkevich <iii@linux.ibm.com>. Coding style has been preserved for
future maintainability.
Patches 1-2 should have no effect for the kernel zlib but make the code
closer to zlib-ng for future maintainability.
Only Patch 3 touches common zlib_deflate code, other patches are relevant to
s390 tree only.

Patch 8 is separate and intends to resolve an issue with kernel PPP driver
which can use kernel zlib for packet compression. Without this patch PPP
decompression can fail due to error code returned by hardware (dfltcc_inflate)
and PPP disables zlib compression for further packets.

@Andrew, would you pick this patch series yourself (which is totally fine
with me) or shall we carry it via s390 tree?

Mikhail Zaslonko (8):
  lib/zlib: Adjust offset calculation for dfltcc_state
  lib/zlib: Implement switching between DFLTCC and software
  lib/zlib: Fix DFLTCC not flushing EOBS when creating raw streams
  lib/zlib: Fix DFLTCC ignoring flush modes when avail_in == 0
  lib/zlib: DFLTCC not writing header bits when avail_out == 0
  lib/zlib: Split deflate and inflate states for DFLTCC
  lib/zlib: DFLTCC support inflate with small window
  lib/zlib: DFLTCC always switch to software inflate for Z_PACKET_FLUSH
    option

 lib/zlib_deflate/deflate.c       | 23 ++++++---
 lib/zlib_dfltcc/dfltcc.c         | 25 ++-------
 lib/zlib_dfltcc/dfltcc.h         | 57 +++++---------------
 lib/zlib_dfltcc/dfltcc_deflate.c | 89 +++++++++++++++++++++-----------
 lib/zlib_dfltcc/dfltcc_deflate.h | 21 ++++++++
 lib/zlib_dfltcc/dfltcc_inflate.c | 24 +++++----
 lib/zlib_dfltcc/dfltcc_inflate.h | 37 +++++++++++++
 lib/zlib_inflate/inflate.c       |  2 +-
 8 files changed, 163 insertions(+), 115 deletions(-)
 create mode 100644 lib/zlib_dfltcc/dfltcc_deflate.h
 create mode 100644 lib/zlib_dfltcc/dfltcc_inflate.h

-- 
2.34.1

