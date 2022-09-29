Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF48E5EFF20
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 23:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiI2VKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 17:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiI2VJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 17:09:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4B67E81C;
        Thu, 29 Sep 2022 14:09:50 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28TKdvOU008957;
        Thu, 29 Sep 2022 21:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4ZTgSP8sSg2HzxmPMppgD2GrrgaljwOOobch62PJdhA=;
 b=lIHrTjNliU0b9g+oZEV6/S9/FU+1JLXGf8dKvwGYRzHu3rwXi4YPbSkDXGeeTfPcGIUC
 dViBDjXKJCEcNAylKPDuUUDlO+584SWQJekRgsKsyJ87kt20kUDOlR2GoGHaNwb2kRtD
 S9/JjsaO/4ehF9GR4PJP/EvekAkKT8lm5t6GJgX4KAIuSQ7uCfrTX6UTt4R/IEIu9RdM
 spZlgLcg37Iur9j+5SKbXR6Jd0CCCiBsTeAw2udBUIFGmkshfXIRIv1Sv6T8WDRQUdkA
 32q2658VG80sm8oc9DAjpmPMYDhKGiroeiXMpF0GVG10g5Tf7kR1WZxpXiGsFuYIYzeN LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jwhyu1tae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 21:09:43 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28TL83NN011468;
        Thu, 29 Sep 2022 21:09:43 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jwhyu1t9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 21:09:43 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28TL7237006867;
        Thu, 29 Sep 2022 21:09:41 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03wdc.us.ibm.com with ESMTP id 3jssh9vk2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 21:09:41 +0000
Received: from smtpav01.dal12v.mail.ibm.com ([9.208.128.133])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28TL9hMT11928308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 21:09:43 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C261758057;
        Thu, 29 Sep 2022 21:09:40 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBD1E58059;
        Thu, 29 Sep 2022 21:09:39 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.77.146.111])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 29 Sep 2022 21:09:39 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     pavel@ucw.cz
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com, joel@jms.id.au,
        dan.carpenter@oracle.com, eajames@linux.ibm.com,
        potin.lai.pt@gmail.com
Subject: [PATCH v7 2/4] leds: pca955x: Use pointers to driver data rather than I2C client
Date:   Thu, 29 Sep 2022 16:09:35 -0500
Message-Id: <20220929210937.253048-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220929210937.253048-1-eajames@linux.ibm.com>
References: <20220929210937.253048-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tTT-5PLLsLkzkb1YjZ3F63vbcXxJw4X9
X-Proofpoint-ORIG-GUID: TRd_B-i1dp8L11ggbYFi96-CsRtrpQZL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_13,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=810 impostorscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209290133
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a minor clean up item, pass the driver data pointer instead of the
I2C client to the reader and writer helper functions. Now the PCA
driver data doesn't have to be looked up again in the I2C client data

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/leds/leds-pca955x.c | 61 ++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 34 deletions(-)

diff --git a/drivers/leds/leds-pca955x.c b/drivers/leds/leds-pca955x.c
index a683c872e1ff..cb1895b79eab 100644
--- a/drivers/leds/leds-pca955x.c
+++ b/drivers/leds/leds-pca955x.c
@@ -172,16 +172,15 @@ static inline int pca955x_ledstate(u8 ls, int led_num)
  * Write to frequency prescaler register, used to program the
  * period of the PWM output.  period = (PSCx + 1) / 38
  */
-static int pca955x_write_psc(struct i2c_client *client, int n, u8 val)
+static int pca955x_write_psc(struct pca955x *pca955x, int n, u8 val)
 {
-	struct pca955x *pca955x = i2c_get_clientdata(client);
 	u8 cmd = pca955x_num_input_regs(pca955x->chipdef->bits) + (2 * n);
 	int ret;
 
-	ret = i2c_smbus_write_byte_data(client, cmd, val);
+	ret = i2c_smbus_write_byte_data(pca955x->client, cmd, val);
 	if (ret < 0)
-		dev_err(&client->dev, "%s: reg 0x%x, val 0x%x, err %d\n",
-			__func__, n, val, ret);
+		dev_err(&pca955x->client->dev, "%s: reg 0x%x, val 0x%x, err %d\n", __func__, n,
+			val, ret);
 	return ret;
 }
 
@@ -192,16 +191,15 @@ static int pca955x_write_psc(struct i2c_client *client, int n, u8 val)
  *
  * Duty cycle is (256 - PWMx) / 256
  */
-static int pca955x_write_pwm(struct i2c_client *client, int n, u8 val)
+static int pca955x_write_pwm(struct pca955x *pca955x, int n, u8 val)
 {
-	struct pca955x *pca955x = i2c_get_clientdata(client);
 	u8 cmd = pca955x_num_input_regs(pca955x->chipdef->bits) + 1 + (2 * n);
 	int ret;
 
-	ret = i2c_smbus_write_byte_data(client, cmd, val);
+	ret = i2c_smbus_write_byte_data(pca955x->client, cmd, val);
 	if (ret < 0)
-		dev_err(&client->dev, "%s: reg 0x%x, val 0x%x, err %d\n",
-			__func__, n, val, ret);
+		dev_err(&pca955x->client->dev, "%s: reg 0x%x, val 0x%x, err %d\n", __func__, n,
+			val, ret);
 	return ret;
 }
 
@@ -209,16 +207,15 @@ static int pca955x_write_pwm(struct i2c_client *client, int n, u8 val)
  * Write to LED selector register, which determines the source that
  * drives the LED output.
  */
-static int pca955x_write_ls(struct i2c_client *client, int n, u8 val)
+static int pca955x_write_ls(struct pca955x *pca955x, int n, u8 val)
 {
-	struct pca955x *pca955x = i2c_get_clientdata(client);
 	u8 cmd = pca955x_num_input_regs(pca955x->chipdef->bits) + 4 + n;
 	int ret;
 
-	ret = i2c_smbus_write_byte_data(client, cmd, val);
+	ret = i2c_smbus_write_byte_data(pca955x->client, cmd, val);
 	if (ret < 0)
-		dev_err(&client->dev, "%s: reg 0x%x, val 0x%x, err %d\n",
-			__func__, n, val, ret);
+		dev_err(&pca955x->client->dev, "%s: reg 0x%x, val 0x%x, err %d\n", __func__, n,
+			val, ret);
 	return ret;
 }
 
@@ -226,32 +223,28 @@ static int pca955x_write_ls(struct i2c_client *client, int n, u8 val)
  * Read the LED selector register, which determines the source that
  * drives the LED output.
  */
-static int pca955x_read_ls(struct i2c_client *client, int n, u8 *val)
+static int pca955x_read_ls(struct pca955x *pca955x, int n, u8 *val)
 {
-	struct pca955x *pca955x = i2c_get_clientdata(client);
 	u8 cmd = pca955x_num_input_regs(pca955x->chipdef->bits) + 4 + n;
 	int ret;
 
-	ret = i2c_smbus_read_byte_data(client, cmd);
+	ret = i2c_smbus_read_byte_data(pca955x->client, cmd);
 	if (ret < 0) {
-		dev_err(&client->dev, "%s: reg 0x%x, err %d\n",
-			__func__, n, ret);
+		dev_err(&pca955x->client->dev, "%s: reg 0x%x, err %d\n", __func__, n, ret);
 		return ret;
 	}
 	*val = (u8)ret;
 	return 0;
 }
 
-static int pca955x_read_pwm(struct i2c_client *client, int n, u8 *val)
+static int pca955x_read_pwm(struct pca955x *pca955x, int n, u8 *val)
 {
-	struct pca955x *pca955x = i2c_get_clientdata(client);
 	u8 cmd = pca955x_num_input_regs(pca955x->chipdef->bits) + 1 + (2 * n);
 	int ret;
 
-	ret = i2c_smbus_read_byte_data(client, cmd);
+	ret = i2c_smbus_read_byte_data(pca955x->client, cmd);
 	if (ret < 0) {
-		dev_err(&client->dev, "%s: reg 0x%x, err %d\n",
-			__func__, n, ret);
+		dev_err(&pca955x->client->dev, "%s: reg 0x%x, err %d\n", __func__, n, ret);
 		return ret;
 	}
 	*val = (u8)ret;
@@ -265,7 +258,7 @@ static enum led_brightness pca955x_led_get(struct led_classdev *led_cdev)
 	u8 ls, pwm;
 	int ret;
 
-	ret = pca955x_read_ls(pca955x->client, pca955x_led->led_num / 4, &ls);
+	ret = pca955x_read_ls(pca955x, pca955x_led->led_num / 4, &ls);
 	if (ret)
 		return ret;
 
@@ -280,7 +273,7 @@ static enum led_brightness pca955x_led_get(struct led_classdev *led_cdev)
 		ret = LED_HALF;
 		break;
 	case PCA955X_LS_BLINK1:
-		ret = pca955x_read_pwm(pca955x->client, 1, &pwm);
+		ret = pca955x_read_pwm(pca955x, 1, &pwm);
 		if (ret)
 			return ret;
 		ret = 255 - pwm;
@@ -302,7 +295,7 @@ static int pca955x_led_set(struct led_classdev *led_cdev,
 
 	mutex_lock(&pca955x->lock);
 
-	ret = pca955x_read_ls(pca955x->client, chip_ls, &ls);
+	ret = pca955x_read_ls(pca955x, reg, &ls);
 	if (ret)
 		goto out;
 
@@ -324,14 +317,14 @@ static int pca955x_led_set(struct led_classdev *led_cdev,
 		 * OFF, HALF, or FULL.  But, this is probably better than
 		 * just turning off for all other values.
 		 */
-		ret = pca955x_write_pwm(pca955x->client, 1, 255 - value);
+		ret = pca955x_write_pwm(pca955x, 1, 255 - value);
 		if (ret)
 			goto out;
 		ls = pca955x_ledsel(ls, bit, PCA955X_LS_BLINK1);
 		break;
 	}
 
-	ret = pca955x_write_ls(pca955x->client, chip_ls, ls);
+	ret = pca955x_write_ls(pca955x, reg, ls);
 
 out:
 	mutex_unlock(&pca955x->lock);
@@ -632,22 +625,22 @@ static int pca955x_probe(struct i2c_client *client)
 	}
 
 	/* PWM0 is used for half brightness or 50% duty cycle */
-	err = pca955x_write_pwm(client, 0, 255 - LED_HALF);
+	err = pca955x_write_pwm(pca955x, 0, 255 - LED_HALF);
 	if (err)
 		return err;
 
 	if (!keep_pwm) {
 		/* PWM1 is used for variable brightness, default to OFF */
-		err = pca955x_write_pwm(client, 1, 0);
+		err = pca955x_write_pwm(pca955x, 1, 0);
 		if (err)
 			return err;
 	}
 
 	/* Set to fast frequency so we do not see flashing */
-	err = pca955x_write_psc(client, 0, 0);
+	err = pca955x_write_psc(pca955x, 0, 0);
 	if (err)
 		return err;
-	err = pca955x_write_psc(client, 1, 0);
+	err = pca955x_write_psc(pca955x, 1, 0);
 	if (err)
 		return err;
 
-- 
2.31.1

