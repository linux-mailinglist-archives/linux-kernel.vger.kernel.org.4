Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BC56AD210
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjCFWxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjCFWxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:53:33 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B8D2FCE9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:53:11 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326KlUIF013804;
        Mon, 6 Mar 2023 22:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=djCBPKOca684XWn8TXzeHHOoQQ07LLH1y4LsII6erYI=;
 b=ZtL7pMjMjENi68gRQeP7NR1sXyfEt/WqA2Ert5olXQTJkanpURI9qbjP3J6L8/YeKRN9
 2+wYsGCeNdyeoHIsffugJU4zmISIuS50HUcsC4CQrRQ5CIIhPobgW9pzbfwn8VXKQjb2
 ovezTfONYYFcxq/klnfCt8xRRdzSFF4PjO18eBKcRHCR9cYhuy4z4A6A4wjn7biu5+YE
 MUJf8ZUKz0E5FVDPcnk1Q9j7QuH+xewiFNcC0tpneL+7OxXHeJwEzK1uoEv0MoVuUz9T
 tg6JIKGYM/zTkk4r74B6jjJVLm2Fe6PEgzE9h55g8Lg++jGK0g3d/4fbzQGrs7TvMMVi 4Q== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4uaeybx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 22:52:57 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 326LkQOZ005407;
        Mon, 6 Mar 2023 22:52:56 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3p4184unps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 22:52:55 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326MqsXi9241254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 22:52:54 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35DFB58043;
        Mon,  6 Mar 2023 22:52:54 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45DA25805D;
        Mon,  6 Mar 2023 22:52:53 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.108.29])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Mar 2023 22:52:53 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, andrew@aj.id.au,
        alistair@popple.id.au, joel@jms.id.au, jk@ozlabs.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] fsi: aspeed: Reset master errors after CFAM reset
Date:   Mon,  6 Mar 2023 16:52:49 -0600
Message-Id: <20230306225249.975495-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I5r1NplQzNvhMLyWY14JZzQ6w6KbBDtW
X-Proofpoint-ORIG-GUID: I5r1NplQzNvhMLyWY14JZzQ6w6KbBDtW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 mlxscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060196
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been observed that sometimes the FSI master will return all 0xffs
after a CFAM has been taken out of reset, without presenting any error.
Resetting the FSI master errors resolves the issue.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-master-aspeed.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index 7cec1772820d..5eccab175e86 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -454,6 +454,8 @@ static ssize_t cfam_reset_store(struct device *dev, struct device_attribute *att
 	gpiod_set_value(aspeed->cfam_reset_gpio, 1);
 	usleep_range(900, 1000);
 	gpiod_set_value(aspeed->cfam_reset_gpio, 0);
+	usleep_range(900, 1000);
+	opb_writel(aspeed, ctrl_base + FSI_MRESP0, cpu_to_be32(FSI_MRESP_RST_ALL_MASTER));
 	mutex_unlock(&aspeed->lock);
 	trace_fsi_master_aspeed_cfam_reset(false);
 
-- 
2.31.1

