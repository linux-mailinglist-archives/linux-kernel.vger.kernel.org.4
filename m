Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778186F674B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjEDI1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjEDIZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:25:51 -0400
Received: from m228-13.mailgun.net (m228-13.mailgun.net [159.135.228.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB63E83F7
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:19:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1683188350; x=1683195550; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To:
 From: From: Sender: Sender; bh=gg/ZwteKnCyknA67x3fGrGnKfvPnYoUzzkEHg0P7zs4=;
 b=Sjxoyat2XHKf+QOc5FeR8b7HpCm1lvFn5rT2HLl8xm8AFU5FlXeGuGOpZWxTHtcSP7qRshbSoiET4/yzQziena3HMDooI2XJciBSk/Oa3jaXZeiAXwcX6vWfShsG+I3Cob2BYclPmjr7M3LSAOFTZ0LFxXrWlkRc5FR7xDuhKVxrO2Bv7uknpgmIIf7D7nW51wF1/bPD5xjELEjc0BB5vMXxBBL95zNWcJURxCrTW0FcLVtAy+2QAKdQ8csai6cu58QpA9ePEaAT+dVPVIE4jhL/popReAy8wWb48p+MGFVNgfVz8vOR8sNk5CHPEuxcxtVgM9Nf8S1C7LzunxRUXA==
X-Mailgun-Sending-Ip: 159.135.228.13
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 50c0b3ab1411 with SMTP id
 645365af9d771a49fe813ee7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 04 May 2023 07:58:39 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     James Seo <james@equiv.tech>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 02/11] hwmon: (core) Rename last parameter of devm_hwmon_register_with_info()
Date:   Thu,  4 May 2023 00:57:43 -0700
Message-Id: <20230504075752.1320967-3-james@equiv.tech>
In-Reply-To: <20230504075752.1320967-1-james@equiv.tech>
References: <20230504075752.1320967-1-james@equiv.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the name of the groups parameter of
devm_hwmon_device_register_with_info() to extra_groups to
match the name given by the hwmon API reference and in
hwmon_device_register_with_info().

Signed-off-by: James Seo <james@equiv.tech>
---
 drivers/hwmon/hwmon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 573b83b6c08c..5f205686065e 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -1029,7 +1029,7 @@ EXPORT_SYMBOL_GPL(devm_hwmon_device_register_with_groups);
  * @name:	hwmon name attribute
  * @drvdata:	driver data to attach to created device
  * @chip:	pointer to hwmon chip information
- * @groups:	pointer to list of driver specific attribute groups
+ * @extra_groups: pointer to list of driver specific attribute groups
  *
  * Returns the pointer to the new device. The new device is automatically
  * unregistered with the parent device.
@@ -1038,7 +1038,7 @@ struct device *
 devm_hwmon_device_register_with_info(struct device *dev, const char *name,
 				     void *drvdata,
 				     const struct hwmon_chip_info *chip,
-				     const struct attribute_group **groups)
+				     const struct attribute_group **extra_groups)
 {
 	struct device **ptr, *hwdev;
 
@@ -1050,7 +1050,7 @@ devm_hwmon_device_register_with_info(struct device *dev, const char *name,
 		return ERR_PTR(-ENOMEM);
 
 	hwdev = hwmon_device_register_with_info(dev, name, drvdata, chip,
-						groups);
+						extra_groups);
 	if (IS_ERR(hwdev))
 		goto error;
 
-- 
2.34.1

