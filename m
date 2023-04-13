Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5566E1562
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjDMTrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjDMTrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:47:02 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865D665B6;
        Thu, 13 Apr 2023 12:47:00 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33DJkde9010136;
        Thu, 13 Apr 2023 19:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=9bXJxQDpqf1FHLqGzpmDLwhqgj0ZIvKATcvCppLD37c=;
 b=r0GRWg6onBfCy+Ud/Ja+kk63Q68i4wgCjw68rZfbSVHGeLCdP0OLL8apQzbXMYxGqkTY
 Lad0Dv7Fmj3YK3Uf4pTTpzs9BGU61zkuiHQbIqnJAM+L4Ff4o34HoG52I5LIndL25Km1
 yvCkBGZtlEo3ALzAuhooNTLqlzAhTj75l8orUnrm/GFc5xrO+c0vPTRpJtH8+nbqeArT
 0e7g7iaw4YfMvhI+IWm3DKgm8kJt4PEjNfM4sEQsI2Y5vSfAm0xFIhWEiCaySOxTMHFN
 f71Q7IqWw2vEBq/YTvMKu0077GXtMvWt1v7IEfyt4ZbNPi6H0q7wjo+hAnZx8mansaiZ Bw== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pxmf6hruc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 19:46:40 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33DGbSCn020774;
        Thu, 13 Apr 2023 19:46:39 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3pu0jhd4qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 19:46:39 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33DJkbYm22151704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 19:46:37 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A35715803F;
        Thu, 13 Apr 2023 19:46:37 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16C1A58054;
        Thu, 13 Apr 2023 19:46:37 +0000 (GMT)
Received: from ltcden12-lp3.aus.stglabs.ibm.com (unknown [9.40.195.53])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 13 Apr 2023 19:46:37 +0000 (GMT)
From:   Danny Tsen <dtsen@linux.ibm.com>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com,
        Danny Tsen <dtsen@linux.ibm.com>
Subject: [PATCH v2 0/2] Remove POWER10_CPU dependency and move PPC_MODULE_FEATURE_P10.
Date:   Thu, 13 Apr 2023 15:46:23 -0400
Message-Id: <20230413194625.10631-1-dtsen@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kkHix0dOBNVrQxcEppfrkjkeKkloETFL
X-Proofpoint-ORIG-GUID: kkHix0dOBNVrQxcEppfrkjkeKkloETFL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_14,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=639
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130174
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        TVD_SUBJ_WIPE_DEBT autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove Power10 dependency in Kconfig and detect Power10 feature at runtime.
Move PPC_MODULE_FEATURE_P10 definition to be in
arch/powerpc/include/asm/cpufeature.h.

Signed-off-by: Danny Tsen <dtsen@linux.ibm.com>

Danny Tsen (2):
  Kconfig: Remove POWER10_CPU dependency.
  aes-gcm-p10-glue.c, cpufeature.h: Move Power10 feature, PPC_MODULE_FEATURE_P10.

 arch/powerpc/crypto/Kconfig            | 2 +-
 arch/powerpc/crypto/aes-gcm-p10-glue.c | 1 -
 arch/powerpc/include/asm/cpufeature.h  | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.31.1

