Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7668172CFE9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 21:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbjFLT5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 15:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjFLT5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:57:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3230CE77;
        Mon, 12 Jun 2023 12:57:17 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CJkhSb021406;
        Mon, 12 Jun 2023 19:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yTuOPuTIZ5qIjR61b/ip9h6OGHcqoNr3zzAKHdVxDxM=;
 b=Ir12TBecTzzfQqD/et7w3taF7TfpA78dzOf02YEhECGouNw/oVMa4Bb2aldbc5fFdA9f
 HkcriGwZpwraf0z5fguu7YN2m+kB89ZF+xd0iPe5Y/CtTloSyc9E/xOy7BWDnH9drqx4
 WjdsqM43HRrTMvtClL8BJrrYFji1/vWHRiZeUMfZ/jnfTBQHibG1AB32hiKuLG2y3pP+
 vgsCMiQjWr0MLvL+ngRsy8S6cpdPDCBuqUlReVZk0/USAXAACvvFBVJW1xXXSjklPSRJ
 OKx8sHgjKoiNOXVRXptuOZgAtH6jC/9NRDW/Uz9wLoeVos23r//UVxDapTwV4HgEEUHb 1A== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r69tqg6as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 19:57:01 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35CHNIis014554;
        Mon, 12 Jun 2023 19:57:00 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3r4gt5cnrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 19:57:00 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35CJv0di28574342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 19:57:00 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 080FC58059;
        Mon, 12 Jun 2023 19:57:00 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD48E5805E;
        Mon, 12 Jun 2023 19:56:59 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.148.226])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 12 Jun 2023 19:56:59 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jk@ozlabs.org, joel@jms.id.au,
        alistair@popple.id.au, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 06/14] fsi: sbefifo: Remove limits on user-specified read timeout
Date:   Mon, 12 Jun 2023 14:56:49 -0500
Message-Id: <20230612195657.245125-7-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230612195657.245125-1-eajames@linux.ibm.com>
References: <20230612195657.245125-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HO52h9VAJj3uso-jHawSe3hIam2Y-cvV
X-Proofpoint-ORIG-GUID: HO52h9VAJj3uso-jHawSe3hIam2Y-cvV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_14,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120169
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason to limit the user here. The way the driver is
designed, extremely large transfers require extremely long timeouts.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-sbefifo.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index 5e6a9e08a92d..3364ddd90ee0 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -971,17 +971,12 @@ static int sbefifo_read_timeout(struct sbefifo_user *user, void __user *argp)
 
 	if (timeout == 0) {
 		user->read_timeout_ms = SBEFIFO_TIMEOUT_START_RSP;
-		dev_dbg(dev, "Timeout reset to %d\n", user->read_timeout_ms);
+		dev_dbg(dev, "Timeout reset to %us\n", user->read_timeout_ms / 1000);
 		return 0;
 	}
 
-	if (timeout < 10 || timeout > 120)
-		return -EINVAL;
-
 	user->read_timeout_ms = timeout * 1000; /* user timeout is in sec */
-
-	dev_dbg(dev, "Timeout set to %d\n", user->read_timeout_ms);
-
+	dev_dbg(dev, "Timeout set to %us\n", timeout);
 	return 0;
 }
 
-- 
2.31.1

