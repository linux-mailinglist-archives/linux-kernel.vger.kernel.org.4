Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095456C355E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjCUPRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjCUPRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:17:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F60A26CF3;
        Tue, 21 Mar 2023 08:17:15 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LEh78R024839;
        Tue, 21 Mar 2023 15:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CHCxWc3rbFcp6UZWpf/pCxYlaalqi6G6tNsTY1PMYM4=;
 b=iIaJFDFlcNCRPRB3mGP+5Q6NWvTt/7b4dV4LX4IfMH+yjWT8ykhluGWXXzCzuLiyKTjX
 HyBLuPib/tI5rNk2oqvgVzp7oM5K00TWeF5N+lTMqlAf2uMRoUfMPsWNEZ1sYZi+Y2/n
 W1A6YYn485TsjxPSe67iZp8qmOrNQ5RAXhRF0MOAa3K4JjZJfeo/VpzH2kMcJW3h1Q4C
 rDSGehGyagX+4f6JQ8XIYCt10qWUn/adOsPisTLIcoBj4brIKmi3yfWra/jNiQ8vsNgI
 UhUxCFkbWDe8TSMDD6lyzJ7bZo2BbBlFWodwvCexsHE1p1oTwg2GtunBYlGL3p2V+LPN rA== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pf7qnv3pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 15:16:56 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32LEE4lx030320;
        Tue, 21 Mar 2023 15:16:55 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3pd4x6u7gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 15:16:55 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32LFGrFJ61800786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 15:16:54 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDFF55805B;
        Tue, 21 Mar 2023 15:16:53 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 521F958063;
        Tue, 21 Mar 2023 15:16:52 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.111.39])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Mar 2023 15:16:52 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        andrew@aj.id.au, joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 2/4] doc: Add Atmel AT30TSE serial eeprom
Date:   Tue, 21 Mar 2023 10:16:40 -0500
Message-Id: <20230321151642.461618-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230321151642.461618-1-eajames@linux.ibm.com>
References: <20230321151642.461618-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BDGxzua8XQlU3P1guiQT_48bq79xeThX
X-Proofpoint-ORIG-GUID: BDGxzua8XQlU3P1guiQT_48bq79xeThX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210118
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AT30TSE is compatible with the JEDEC EE1004 standard. Document it
as a trivial I2C device.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 6f482a254a1d..43e26c73a95f 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -47,6 +47,8 @@ properties:
           - ams,iaq-core
             # i2c serial eeprom (24cxx)
           - at,24c08
+            # i2c serial eeprom (EE1004 standard)
+          - atmel,at30tse
             # i2c trusted platform module (TPM)
           - atmel,at97sc3204t
             # ATSHA204 - i2c h/w symmetric crypto module
-- 
2.31.1

