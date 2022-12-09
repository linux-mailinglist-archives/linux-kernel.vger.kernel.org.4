Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C075A6481A8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 12:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiLIL2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 06:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiLIL2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 06:28:00 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72A045A3A;
        Fri,  9 Dec 2022 03:27:57 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B9B9iT0003641;
        Fri, 9 Dec 2022 11:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ZSlPhvT/Gwt3QBnevDKmiLdO/2ODroa0WQHJW/W3Nzs=;
 b=fxrW5YkcLRZnVzvUH6NfcsrYkynmfHCYiZkVsCXD9HGXtvlyjxBth+Zc4INNV40Kysht
 saP5obwcZcsh2jqduzG0rBxqm8XOzY9JmVuZ1T92+fLDLzMm9xw9LCeTwujmJMFwb+pw
 RE86tCTXEzPzFMDW8sOKYUhgFHgEMZEDUN7gSWiCUrOwLoXXacCw2cM2lj3xZUbMjFoM
 l+DV1EyGZsUU68fd28UaJDp1YeyKa9MJ0FhgC0quVfQ7oOIJw5sDQlx98CO0Uc4PqUn0
 CRIU0ywV7gqcl/p/zkqZ+kL8+sSXspr/gWQpNPmZrfXjv2WhyJRwozfU9x3u0R3XezwF ug== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mbxakfuf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 11:27:53 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8Kw6Mh004817;
        Fri, 9 Dec 2022 11:27:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3m9kvbdvx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 11:27:51 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B9BRlsV44827088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Dec 2022 11:27:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D524620040;
        Fri,  9 Dec 2022 11:27:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C43DA2004D;
        Fri,  9 Dec 2022 11:27:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  9 Dec 2022 11:27:47 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 8656BE027E; Fri,  9 Dec 2022 12:27:47 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 2/2] tty/vt: prevent registration of console with invalid number
Date:   Fri,  9 Dec 2022 12:27:37 +0100
Message-Id: <20221209112737.3222509-3-svens@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209112737.3222509-1-svens@linux.ibm.com>
References: <20221209112737.3222509-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2CbJFMTMhpsNEWfV2R6OLT-wR3N1LIQk
X-Proofpoint-ORIG-GUID: 2CbJFMTMhpsNEWfV2R6OLT-wR3N1LIQk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_04,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxlogscore=774 impostorscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212090066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a user specifies an invalid console like 'console=tty3000',
the vt driver should prevent setting up a vt entry for that.

Suggested-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 drivers/tty/vt/vt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 981d2bfcf9a5..62c8a45ad731 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3156,8 +3156,14 @@ static struct tty_driver *vt_console_device(struct console *c, int *index)
 	return console_driver;
 }
 
+static int vt_console_setup(struct console *co, char *options)
+{
+	return co->index >= MAX_NR_CONSOLES ? -EINVAL : 0;
+}
+
 static struct console vt_console_driver = {
 	.name		= "tty",
+	.setup		= vt_console_setup,
 	.write		= vt_console_print,
 	.device		= vt_console_device,
 	.unblank	= unblank_screen,
-- 
2.34.1

