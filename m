Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59AD6D8417
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjDEQuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjDEQun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:50:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472D43AAB;
        Wed,  5 Apr 2023 09:50:42 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335FmPfs027578;
        Wed, 5 Apr 2023 16:50:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=UXgOY7AuIGFAsaQsdgBTKV+Xqw3tw6NbkRPvrtDm+Qg=;
 b=bs+K18wZUVZVwZhNBYTGkjwVJE+XPMMdCMmdj/sYkV4zbEfz10aiO6v5lxG++wFy3BMK
 uAoP1nD1R1AbH1SKC8UrI+IjjVu+xFhGUhfbyD5Cbk/gmYoWoACPPGukQqiQkHLgWiU8
 wx/ggv8qeTvmaM930ySsngJh4MkZ2Keb26hWVD1t3GObXhTs0Ar8oDjAy/R6vm/20jwJ
 FBDC0A9aCYVtzqPvBJl40bB10AuYsHSg/pNDHpM6UXdsEJ4y5WobK4J4XmvrOCb+b8iM
 3BZH/gBvzL7CK69SaPpSr26//UC8bfOD0MgF48ivSi7y9NTgOq979Ta9CIBjybGSvq4a 4g== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3psaamvqa1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 16:50:36 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 335F9JNE017698;
        Wed, 5 Apr 2023 16:50:35 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3ppc87y75p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 16:50:35 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 335GoYnd24576592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Apr 2023 16:50:34 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89BD258054;
        Wed,  5 Apr 2023 16:50:34 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2FAD5803F;
        Wed,  5 Apr 2023 16:50:33 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.127.161])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  5 Apr 2023 16:50:33 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-leds@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, lee@kernel.org, pavel@ucw.cz,
        Eddie James <eajames@linux.ibm.com>
Subject: [RESEND] leds: Ensure hardware blinking turns off when requested
Date:   Wed,  5 Apr 2023 11:50:28 -0500
Message-Id: <20230405165028.73579-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PvPSYGVOZCqw9KDxnNvoCOsffa5zoKz2
X-Proofpoint-ORIG-GUID: PvPSYGVOZCqw9KDxnNvoCOsffa5zoKz2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_11,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1011
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=584 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304050149
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an LED is blinking through the hardware and the trigger is deactivated,
the driver will set the brightness to 0 to disable blinking. However, if
the LED driver doesn't support non-blocking operations, the request for
setting brightness to 0 will get queued. Then if a user requests a new
non-zero brightness before the request for 0 brightness is executed, the
LED blinking will not get disabled since the brightness will simply be
updated.
Fix this by flushing the workqueue before updating the requested
brightness.

Fixes: 4d71a4a12b13 ("leds: Add support for setting brightness in a synchronous way")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/leds/led-class.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 9255bc11f99d..78a270300d30 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -57,6 +57,8 @@ static ssize_t brightness_store(struct device *dev,
 
 	if (state == LED_OFF)
 		led_trigger_remove(led_cdev);
+	/* flush out any request to disable blinking */
+	flush_work(&led_cdev->set_brightness_work);
 	led_set_brightness(led_cdev, state);
 	flush_work(&led_cdev->set_brightness_work);
 
-- 
2.31.1

