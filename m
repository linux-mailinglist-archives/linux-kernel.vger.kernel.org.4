Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC1869E120
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 14:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbjBUNQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 08:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjBUNQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:16:27 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7557C28D2D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 05:16:24 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LCWHDV014178;
        Tue, 21 Feb 2023 13:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=5OogEC/i0WFbo4e5ftWn6YptkRdNqvmJgtHu6j7fVCQ=;
 b=XDO/7CtqQkDoHXqT+2ccdhh7WgyzPRjXkj9BerSkrxstiW2qrVO2DpbbSQJjmx8A225n
 XUWz+aWiuFJfCG7SxsBqhDz44P2bHpxHEsdD2Dyu0K7qyJpB0WtZmySw8s708l3gAovO
 8dYs4gSle8N+EIBG4H6OZvnRM3m0zFWPuqriLWT7xx3AZM1s6+8ygWnjNjYXtqY8LMR9
 0iFX7Kjp58u9suqSHkNi1jz7/y7b0H1mkhlrkTDaHF6AQUhqlF+t0KBFsrePAe9Tkrql
 0pxYOADcarBLs2H8dPd//zWK/EWzHCmxj8uq1fqxBZyvgDWFVHtx9+JAjit0aCv5uLoT og== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nvudfd3wk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 13:16:23 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31L8CdOx007311;
        Tue, 21 Feb 2023 13:16:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3ntpa6c1sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 13:16:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31LDGI2854329624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 13:16:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7A0E20043;
        Tue, 21 Feb 2023 13:16:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8CE220040;
        Tue, 21 Feb 2023 13:16:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Feb 2023 13:16:17 +0000 (GMT)
From:   Mikhail Zaslonko <zaslonko@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, zaslonko@linux.ibm.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/1] lib/zlib: DFLTCC deflate with Z_NO_FLUSH
Date:   Tue, 21 Feb 2023 14:16:16 +0100
Message-Id: <20230221131617.3369978-1-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JHqClc3wlS50CTWagtLAvZUUvhcTwoRU
X-Proofpoint-ORIG-GUID: JHqClc3wlS50CTWagtLAvZUUvhcTwoRU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_08,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=556 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302210111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

please pick another patch for kernel zlib which is an actual fix for
potential data corruption issue when using s390 DFLTCC deflate with
Z_NO_FLUSH option.

Mikhail Zaslonko (1):
  lib/zlib: DFLTCC deflate does not write all available bits for
    Z_NO_FLUSH

 lib/zlib_deflate/defutil.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.37.2

