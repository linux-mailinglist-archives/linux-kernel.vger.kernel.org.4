Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B96F6481A5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 12:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiLIL2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 06:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiLIL14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 06:27:56 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAAE43ADD;
        Fri,  9 Dec 2022 03:27:54 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B995JPf018605;
        Fri, 9 Dec 2022 11:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=lr8FlHb5L+VJR40kJ/GrAGAAjLPIS+pgH6GTe2l/4GQ=;
 b=jJQjgDXqW6cyantg7+629A6yXn3sUCBjw/ozNQlBBPbfPW6d+N5+Tvbt2xI4NVfCckC1
 QA+GGFYwhCZVIBP0tJD/J+vXfsD00XwDuayarRDrraiXG3X7qfeMzV+V3qxuE+L4NZmR
 ASOSq3ccKJ3f1l4J3jRtHYdx6uLNUinbsJo0+9CNWt5w+Iqn87mxq64z2M54Qvs4Uq01
 WMEYwjMowOsDx1kfRFkYlUH7XXUzYm8PoFE/u8wNvegc4LM4vTtJnU0d/RsSd4MO5HL9
 zVmA2vKtjiqKTcJfwkabUMUuE5ft8sAur4JfoKS1p/kWejbD2wMjAE+iDKoGAdOXK7Ak qQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mbuw92rxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 11:27:50 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.16.1.2) with ESMTP id 2B98JYw8018447;
        Fri, 9 Dec 2022 11:27:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3m9m7rca37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 11:27:47 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B9BRj5F43516408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Dec 2022 11:27:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 906A820043;
        Fri,  9 Dec 2022 11:27:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81DC420040;
        Fri,  9 Dec 2022 11:27:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  9 Dec 2022 11:27:45 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 5241BE027E; Fri,  9 Dec 2022 12:27:45 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 0/2] fix out-of-bounds access when specifying invalid console
Date:   Fri,  9 Dec 2022 12:27:35 +0100
Message-Id: <20221209112737.3222509-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2sUlgT5ZT9mzptxguIx4hfPZIB8c9Fcz
X-Proofpoint-ORIG-GUID: 2sUlgT5ZT9mzptxguIx4hfPZIB8c9Fcz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_04,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 mlxlogscore=661 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212090066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

these two patches fix a crash in the tty driver when a user specifies an
invalid console like 'console=tty3000'. The first patch adds a check to
tty_driver_lookup_tty(), the second one prevents that such a console gets
registered in the vt driver.

Changes in v2:
- trim commit message in first patch
- add second patch as suggested by Jiri Slaby

Sven Schnelle (2):
  tty: fix out-of-bounds access in tty_driver_lookup_tty()
  tty/vt: prevent registration of console with invalid number

 drivers/tty/tty_io.c | 8 +++++---
 drivers/tty/vt/vt.c  | 6 ++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.34.1

