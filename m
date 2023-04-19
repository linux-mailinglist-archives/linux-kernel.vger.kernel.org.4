Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342E06E7FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 18:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjDSQld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 12:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjDSQlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 12:41:31 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D832524B;
        Wed, 19 Apr 2023 09:41:30 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1a50cb65c92so1632655ad.0;
        Wed, 19 Apr 2023 09:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681922490; x=1684514490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vyMfPF2gxAgCeN6ITGwi3dqFXBGQyZzAkaQLIvlrtX4=;
        b=iIBBfxpcVZ9hPGf4EdtiA0Twt/1qxf0xd6v8GbFrkCqt0LVRYNVjQXvuzDe43XebWH
         IEdGztNOGqp0XcTr01bbgSdcW96QaEZVpd6Whaed2Egg/QvsHHuUKRaQj1E1EyeVCpc+
         boDp5qxQAmIIcdaoMgSV53e7c7QrR9kDTwTrncOHaQOxumMeqseBl7PbhuDysshJ8uG7
         fvapgzF/73G7l2wSBitynZal6pPVpvmP8jTk0XpPDUb7ENGyw9gptzb2QSic7RCU/T+K
         bK+deiznUY68zo/SA2izzxorPg+V6S/lcW956NmU6/KEPIVqM2h40C/6GBvvcMGpEOOc
         aYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681922490; x=1684514490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyMfPF2gxAgCeN6ITGwi3dqFXBGQyZzAkaQLIvlrtX4=;
        b=fOVqbF/KLaEr0/YIIB6Lbux5smBNZTHeAHNnZMZBogt3RuSGXS5xAz7gD3N7zso/Ob
         eon0yCOXBZ91DsDiD/ZJLm5J7YSujeqX8mhc69C4586L9KEHuFfMghgdbkRcQbni09CK
         MH24Nc+VpUKP41DFErEmgG5+xg8HDOGq9tQeKGxzIwi5hLKii2+jHZVVT1u49oim6iC7
         PtioCq7Ii88dQFwqSMSOW3kIlbfZcCaFkTPWzBHiuoJL73UOV7TGpMAt9mo09VroF1PZ
         nsa0KwrdTF8hJc8F5deLvGMcRk0brEH1E6yiMVOugZFx7tGBu/pMaUmDD2/iEIxoYp6I
         sGtA==
X-Gm-Message-State: AAQBX9d3+LmiybzAG2MpLRw1Q6TvYxmJmxUFVG2oBnSMwNS+gf2xw+v0
        DJjmik/oY8VXXPemZ+IA/4s=
X-Google-Smtp-Source: AKy350Z7Ku8gGUEiOw9RWlsc1Lxp4Q2kZkri37pmsY68Z1GRdfJDYUyQtaXWx+Ka7p7ShLk5GSODbw==
X-Received: by 2002:a17:902:ec8f:b0:1a1:b137:4975 with SMTP id x15-20020a170902ec8f00b001a1b1374975mr7311334plg.49.1681922490008;
        Wed, 19 Apr 2023 09:41:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y13-20020a170902b48d00b001a68991e1b3sm11329809plr.263.2023.04.19.09.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 09:41:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] device property: make device_property functions take const device *
Date:   Wed, 19 Apr 2023 09:41:27 -0700
Message-Id: <20230419164127.3773278-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_property functions do not modify the device pointer passed to them.
The underlying of_device and fwnode_ functions actually already take
const * arguments. Mark the parameter constant to simplify conversion
from of_property to device_property functions, and to let the calling code
use const device pointers where possible.

Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Found by Chris when trying to convert a driver from of_property_ to
device_property_ functions. I don't really see a reason why the device
parameter to device_property functions should not be const.
Please let me know if I am missing sonething.

 drivers/base/property.c  | 16 ++++++++--------
 include/linux/property.h | 36 ++++++++++++++++++------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 083a95791d3b..21d7a5d13e05 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -38,7 +38,7 @@ EXPORT_SYMBOL_GPL(__dev_fwnode_const);
  *
  * Check if property @propname is present in the device firmware description.
  */
-bool device_property_present(struct device *dev, const char *propname)
+bool device_property_present(const struct device *dev, const char *propname)
 {
 	return fwnode_property_present(dev_fwnode(dev), propname);
 }
@@ -86,7 +86,7 @@ EXPORT_SYMBOL_GPL(fwnode_property_present);
  *	   %-EOVERFLOW if the size of the property is not as expected.
  *	   %-ENXIO if no suitable firmware interface is present.
  */
-int device_property_read_u8_array(struct device *dev, const char *propname,
+int device_property_read_u8_array(const struct device *dev, const char *propname,
 				  u8 *val, size_t nval)
 {
 	return fwnode_property_read_u8_array(dev_fwnode(dev), propname, val, nval);
@@ -114,7 +114,7 @@ EXPORT_SYMBOL_GPL(device_property_read_u8_array);
  *	   %-EOVERFLOW if the size of the property is not as expected.
  *	   %-ENXIO if no suitable firmware interface is present.
  */
-int device_property_read_u16_array(struct device *dev, const char *propname,
+int device_property_read_u16_array(const struct device *dev, const char *propname,
 				   u16 *val, size_t nval)
 {
 	return fwnode_property_read_u16_array(dev_fwnode(dev), propname, val, nval);
@@ -142,7 +142,7 @@ EXPORT_SYMBOL_GPL(device_property_read_u16_array);
  *	   %-EOVERFLOW if the size of the property is not as expected.
  *	   %-ENXIO if no suitable firmware interface is present.
  */
-int device_property_read_u32_array(struct device *dev, const char *propname,
+int device_property_read_u32_array(const struct device *dev, const char *propname,
 				   u32 *val, size_t nval)
 {
 	return fwnode_property_read_u32_array(dev_fwnode(dev), propname, val, nval);
@@ -170,7 +170,7 @@ EXPORT_SYMBOL_GPL(device_property_read_u32_array);
  *	   %-EOVERFLOW if the size of the property is not as expected.
  *	   %-ENXIO if no suitable firmware interface is present.
  */
-int device_property_read_u64_array(struct device *dev, const char *propname,
+int device_property_read_u64_array(const struct device *dev, const char *propname,
 				   u64 *val, size_t nval)
 {
 	return fwnode_property_read_u64_array(dev_fwnode(dev), propname, val, nval);
@@ -198,7 +198,7 @@ EXPORT_SYMBOL_GPL(device_property_read_u64_array);
  *	   %-EOVERFLOW if the size of the property is not as expected.
  *	   %-ENXIO if no suitable firmware interface is present.
  */
-int device_property_read_string_array(struct device *dev, const char *propname,
+int device_property_read_string_array(const struct device *dev, const char *propname,
 				      const char **val, size_t nval)
 {
 	return fwnode_property_read_string_array(dev_fwnode(dev), propname, val, nval);
@@ -220,7 +220,7 @@ EXPORT_SYMBOL_GPL(device_property_read_string_array);
  *	   %-EPROTO or %-EILSEQ if the property type is not a string.
  *	   %-ENXIO if no suitable firmware interface is present.
  */
-int device_property_read_string(struct device *dev, const char *propname,
+int device_property_read_string(const struct device *dev, const char *propname,
 				const char **val)
 {
 	return fwnode_property_read_string(dev_fwnode(dev), propname, val);
@@ -242,7 +242,7 @@ EXPORT_SYMBOL_GPL(device_property_read_string);
  *	   %-EPROTO if the property is not an array of strings,
  *	   %-ENXIO if no suitable firmware interface is present.
  */
-int device_property_match_string(struct device *dev, const char *propname,
+int device_property_match_string(const struct device *dev, const char *propname,
 				 const char *string)
 {
 	return fwnode_property_match_string(dev_fwnode(dev), propname, string);
diff --git a/include/linux/property.h b/include/linux/property.h
index 0a29db15ff34..66fe73ee430d 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -40,20 +40,20 @@ struct fwnode_handle *__dev_fwnode(struct device *dev);
 		 const struct device *: __dev_fwnode_const,	\
 		 struct device *: __dev_fwnode)(dev)
 
-bool device_property_present(struct device *dev, const char *propname);
-int device_property_read_u8_array(struct device *dev, const char *propname,
+bool device_property_present(const struct device *dev, const char *propname);
+int device_property_read_u8_array(const struct device *dev, const char *propname,
 				  u8 *val, size_t nval);
-int device_property_read_u16_array(struct device *dev, const char *propname,
+int device_property_read_u16_array(const struct device *dev, const char *propname,
 				   u16 *val, size_t nval);
-int device_property_read_u32_array(struct device *dev, const char *propname,
+int device_property_read_u32_array(const struct device *dev, const char *propname,
 				   u32 *val, size_t nval);
-int device_property_read_u64_array(struct device *dev, const char *propname,
+int device_property_read_u64_array(const struct device *dev, const char *propname,
 				   u64 *val, size_t nval);
-int device_property_read_string_array(struct device *dev, const char *propname,
+int device_property_read_string_array(const struct device *dev, const char *propname,
 				      const char **val, size_t nval);
-int device_property_read_string(struct device *dev, const char *propname,
+int device_property_read_string(const struct device *dev, const char *propname,
 				const char **val);
-int device_property_match_string(struct device *dev,
+int device_property_match_string(const struct device *dev,
 				 const char *propname, const char *string);
 
 bool fwnode_property_present(const struct fwnode_handle *fwnode,
@@ -143,57 +143,57 @@ int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);
 
 unsigned int device_get_child_node_count(const struct device *dev);
 
-static inline bool device_property_read_bool(struct device *dev,
+static inline bool device_property_read_bool(const struct device *dev,
 					     const char *propname)
 {
 	return device_property_present(dev, propname);
 }
 
-static inline int device_property_read_u8(struct device *dev,
+static inline int device_property_read_u8(const struct device *dev,
 					  const char *propname, u8 *val)
 {
 	return device_property_read_u8_array(dev, propname, val, 1);
 }
 
-static inline int device_property_read_u16(struct device *dev,
+static inline int device_property_read_u16(const struct device *dev,
 					   const char *propname, u16 *val)
 {
 	return device_property_read_u16_array(dev, propname, val, 1);
 }
 
-static inline int device_property_read_u32(struct device *dev,
+static inline int device_property_read_u32(const struct device *dev,
 					   const char *propname, u32 *val)
 {
 	return device_property_read_u32_array(dev, propname, val, 1);
 }
 
-static inline int device_property_read_u64(struct device *dev,
+static inline int device_property_read_u64(const struct device *dev,
 					   const char *propname, u64 *val)
 {
 	return device_property_read_u64_array(dev, propname, val, 1);
 }
 
-static inline int device_property_count_u8(struct device *dev, const char *propname)
+static inline int device_property_count_u8(const struct device *dev, const char *propname)
 {
 	return device_property_read_u8_array(dev, propname, NULL, 0);
 }
 
-static inline int device_property_count_u16(struct device *dev, const char *propname)
+static inline int device_property_count_u16(const struct device *dev, const char *propname)
 {
 	return device_property_read_u16_array(dev, propname, NULL, 0);
 }
 
-static inline int device_property_count_u32(struct device *dev, const char *propname)
+static inline int device_property_count_u32(const struct device *dev, const char *propname)
 {
 	return device_property_read_u32_array(dev, propname, NULL, 0);
 }
 
-static inline int device_property_count_u64(struct device *dev, const char *propname)
+static inline int device_property_count_u64(const struct device *dev, const char *propname)
 {
 	return device_property_read_u64_array(dev, propname, NULL, 0);
 }
 
-static inline int device_property_string_array_count(struct device *dev,
+static inline int device_property_string_array_count(const struct device *dev,
 						     const char *propname)
 {
 	return device_property_read_string_array(dev, propname, NULL, 0);
-- 
2.39.2

