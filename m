Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F356E1233
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjDMQY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjDMQY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:24:57 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978CB869E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:24:56 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33DFKhNB013427;
        Thu, 13 Apr 2023 16:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ARLRHoHpS55qm8rtlTvlDCPA8/zgmyitwtHhAXty57Y=;
 b=Nw3CFdosSJauPwZ+kJ1fDELgGtLK+7iarPCCjCJ2tovsY25hbyhXMlRpYtVEm2/4LApT
 6ZTZUn2hPZiqfT89BzdwOrCkk2IsSP45i1n3NsYpRQevmkoqPGVwfDYtY2JxcLnk95AB
 /CDTrRbLOaG4V6ERziRkiekxAHNJIymvM7H/p1uxRKzgodVz77WRwUCS+yCDnZpH1RK2
 9ek4k31LmO/x1y2ez3Rs2RopTtAq38drCqgzPX2CD1cU5ArwNoucalL2E2AOfKm+I0z+
 pqkFmzZoVKoaCHzCYbFNRG1QJacv+9eCSnphFdTqVjgWFf1T7QEY64CHXVt3Vup73oGa Ng== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pxma1tseg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 16:24:45 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33DD1IW9020744;
        Thu, 13 Apr 2023 16:24:45 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3pu0jhccm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 16:24:45 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33DGOhEI20775570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 16:24:44 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D544258059;
        Thu, 13 Apr 2023 16:24:43 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DC3B58055;
        Thu, 13 Apr 2023 16:24:43 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.69.135])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 13 Apr 2023 16:24:42 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, joel@jms.id.au, jk@ozlabs.org,
        alistair@popple.id.au, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] fsi: core: Fix legacy minor numbering
Date:   Thu, 13 Apr 2023 11:24:40 -0500
Message-Id: <20230413162440.3313036-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4jQ0wmQ9Wh3-EPjZLpc_WUzFThzE6xT9
X-Proofpoint-GUID: 4jQ0wmQ9Wh3-EPjZLpc_WUzFThzE6xT9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_11,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304130143
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FSI reserves the first 64 minor numbers for the legacy numbering
based on the chip id. However the legacy number shifts the chip
id too much, resulting in overlap between legacy and non-legacy
numbers. Reduce the chip id bit shift since the type field only
takes 2 bits.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 0b927c9f4267..b9f410170655 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -950,7 +950,7 @@ static int __fsi_get_new_minor(struct fsi_slave *slave, enum fsi_dev_type type,
 	/* Check if we qualify for legacy numbering */
 	if (cid >= 0 && cid < 16 && type < 4) {
 		/* Try reserving the legacy number */
-		id = (cid << 4) | type;
+		id = (cid << 2) | type;
 		id = ida_simple_get(&fsi_minor_ida, id, id + 1, GFP_KERNEL);
 		if (id >= 0) {
 			*out_index = fsi_adjust_index(cid);
-- 
2.31.1

