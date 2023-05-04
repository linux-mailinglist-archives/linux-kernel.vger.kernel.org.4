Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6886F66EB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjEDIMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjEDIL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:11:58 -0400
X-Greylist: delayed 657 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 May 2023 01:09:19 PDT
Received: from m228-4.mailgun.net (m228-4.mailgun.net [159.135.228.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99440421C
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:09:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1683187758; x=1683194958; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To:
 From: From: Sender: Sender; bh=R5BLmr3eeMwabEeSJdJ4VaWur8hCI2hc5v7/efW2mtA=;
 b=Jps6Z+5SQK0z+iG7+Mj7P298Nt3il4RGcIJrLmtUiEmeniEsUCV0qJ4o1jX/VpVqSdgxUQuRhIQQd73GWygu+Zj6sG7eLfzDmfqbpZus/DzIYDMnF1kOXM6I0o169GUaLM0DNuvZ08dQleFDlhTFKSB08t0SGm+glCe4WdktcpH/F1BAIydk9v5oxNSU1wQQKtWiQaX5d9DzC6HomnzkVhi3cvbdyu/4UoyX9UVtnKZzxvRWLeOT0rDKRw/cmv50Iql/rgx3CY332bLyj0GWKidWHvtwp2iTzUiYMPkCjcDOr5Q1VG5c947Xq4L4y8KM2jBbs5U5VJxuE+lE1PBa2w==
X-Mailgun-Sending-Ip: 159.135.228.4
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 9a4ee640ef47 with SMTP id
 645365b88290b6a11e3d9b21 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 04 May 2023 07:58:48 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     James Seo <james@equiv.tech>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 03/11] hwmon: (core) Revise kerneldoc comments
Date:   Thu,  4 May 2023 00:57:44 -0700
Message-Id: <20230504075752.1320967-4-james@equiv.tech>
In-Reply-To: <20230504075752.1320967-1-james@equiv.tech>
References: <20230504075752.1320967-1-james@equiv.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move function and data structure documentation from hwmon
kernel API reference into kerneldocs. Fix minor issues
(spelling, grammar, etc.) and rewrite content as necessary so
that the resulting kerneldocs are less terse and suitable for
inclusion into docs.

Note that the following terms were introduced alongside
expanded explanations of their importance and usage:
* chip descriptor: struct hwmon_chip_info
* callback descriptor: struct hwmon_ops
* channel descriptor: struct hwmon_channel_info

Signed-off-by: James Seo <james@equiv.tech>
---
 drivers/hwmon/hwmon.c       | 160 ++++++++++++++++++++++--------------
 include/linux/hwmon-sysfs.h |  19 ++++-
 include/linux/hwmon.h       |  80 +++++++++++++-----
 3 files changed, 179 insertions(+), 80 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 5f205686065e..cc140cf99290 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -864,16 +864,19 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 }
 
 /**
- * hwmon_device_register_with_groups - register w/ hwmon
- * @dev: the parent device
- * @name: hwmon name attribute
- * @drvdata: driver data to attach to created device
- * @groups: List of attribute groups to create
+ * hwmon_device_register_with_groups - Register a hardware monitoring device
+ * (deprecated).
+ * @dev: A pointer to the parent device.
+ * @name: The ``hwmon`` device name (mandatory).
+ * @drvdata: A pointer to the private driver data structure.
+ * @groups: A pointer to a ``NULL``-terminated list of attribute groups.
  *
- * hwmon_device_unregister() must be called when the device is no
- * longer needed.
+ * The result is a newly allocated ``hwmon`` device with ``sysfs`` attributes
+ * as specified by @name and @groups.
  *
- * Returns the pointer to the new device.
+ * Return: On success: A pointer to the new ``hwmon`` device.
+ * hwmon_device_unregister() must be called on it when it is no longer needed.
+ * On failure, a &PTR_ERR.
  */
 struct device *
 hwmon_device_register_with_groups(struct device *dev, const char *name,
@@ -888,18 +891,25 @@ hwmon_device_register_with_groups(struct device *dev, const char *name,
 EXPORT_SYMBOL_GPL(hwmon_device_register_with_groups);
 
 /**
- * hwmon_device_register_with_info - register w/ hwmon
- * @dev: the parent device (mandatory)
- * @name: hwmon name attribute (mandatory)
- * @drvdata: driver data to attach to created device (optional)
- * @chip: pointer to hwmon chip information (mandatory)
- * @extra_groups: pointer to list of additional non-standard attribute groups
- *	(optional)
+ * hwmon_device_register_with_info - Register a hardware monitoring device.
+ * @dev: A pointer to the parent device (mandatory).
+ * @name: The ``hwmon`` device name (mandatory).
+ * @drvdata: A pointer to the private driver data structure.
+ * @chip: A pointer to the chip descriptor (mandatory).
+ * @extra_groups: A pointer to a ``NULL``-terminated list of additional
+ *	non-standard ``sysfs`` attribute groups.
  *
- * hwmon_device_unregister() must be called when the device is no
- * longer needed.
+ * Creates the standard ``sysfs`` attributes in the hardware monitoring core,
+ * letting the driver focus on reading from and writing to the chip instead of
+ * having to bother with ``sysfs`` attributes.
  *
- * Returns the pointer to the new device.
+ * The result is a newly allocated ``hwmon`` device with standard ``sysfs``
+ * attributes as specified by @name and @groups and additional attributes as
+ * specified by @extra_groups.
+ *
+ * Return: On success, a pointer to the new ``hwmon`` device.
+ * hwmon_device_unregister() must be called on it when it is no longer needed.
+ * On failure, a &PTR_ERR.
  */
 struct device *
 hwmon_device_register_with_info(struct device *dev, const char *name,
@@ -918,18 +928,18 @@ hwmon_device_register_with_info(struct device *dev, const char *name,
 EXPORT_SYMBOL_GPL(hwmon_device_register_with_info);
 
 /**
- * hwmon_device_register_for_thermal - register hwmon device for thermal subsystem
- * @dev: the parent device
- * @name: hwmon name attribute
- * @drvdata: driver data to attach to created device
+ * hwmon_device_register_for_thermal - Register a hardware monitoring device
+ * for the thermal subsystem (restricted).
+ * @dev: A pointer to the parent device.
+ * @name: The ``hwmon`` device name (mandatory).
+ * @drvdata: A pointer to the private driver data structure.
  *
  * The use of this function is restricted. It is provided for legacy reasons
  * and must only be called from the thermal subsystem.
  *
- * hwmon_device_unregister() must be called when the device is no
- * longer needed.
- *
- * Returns the pointer to the new device.
+ * Return: On success, a pointer to the new ``hwmon`` device.
+ * hwmon_device_unregister() must be called on it when it is no longer needed.
+ * On failure, a &PTR_ERR.
  */
 struct device *
 hwmon_device_register_for_thermal(struct device *dev, const char *name,
@@ -943,13 +953,12 @@ hwmon_device_register_for_thermal(struct device *dev, const char *name,
 EXPORT_SYMBOL_NS_GPL(hwmon_device_register_for_thermal, HWMON_THERMAL);
 
 /**
- * hwmon_device_register - register w/ hwmon
- * @dev: the device to register
- *
- * hwmon_device_unregister() must be called when the device is no
- * longer needed.
+ * hwmon_device_register - Register a hardware monitoring device (deprecated).
+ * @dev: A pointer to the device.
  *
- * Returns the pointer to the new device.
+ * Return: On success, a pointer to the new ``hwmon`` device.
+ * hwmon_device_unregister() must be called on it when it is no longer needed.
+ * On failure, a &PTR_ERR.
  */
 struct device *hwmon_device_register(struct device *dev)
 {
@@ -961,9 +970,12 @@ struct device *hwmon_device_register(struct device *dev)
 EXPORT_SYMBOL_GPL(hwmon_device_register);
 
 /**
- * hwmon_device_unregister - removes the previously registered class device
+ * hwmon_device_unregister - Unregister a previously registered hardware
+ * monitoring device.
+ * @dev: A pointer to the registered ``hwmon`` device (mandatory).
  *
- * @dev: the class device to destroy
+ * Must be called from the driver remove function if the hardware monitoring
+ * device was not registered with a device-managed registration function.
  */
 void hwmon_device_unregister(struct device *dev)
 {
@@ -986,14 +998,20 @@ static void devm_hwmon_release(struct device *dev, void *res)
 }
 
 /**
- * devm_hwmon_device_register_with_groups - register w/ hwmon
- * @dev: the parent device
- * @name: hwmon name attribute
- * @drvdata: driver data to attach to created device
- * @groups: List of attribute groups to create
+ * devm_hwmon_device_register_with_groups - Register a hardware monitoring
+ * device (deprecated).
+ * @dev: A pointer to the parent device (mandatory).
+ * @name: The ``hwmon`` device name (mandatory).
+ * @drvdata: A pointer to the private driver data structure.
+ * @groups: A pointer to a ``NULL``-terminated list of attribute groups.
  *
- * Returns the pointer to the new device. The new device is automatically
- * unregistered with the parent device.
+ * Similar to hwmon_device_register_with_groups(), but the ``hwmon`` device it
+ * creates is device-managed, meaning it does not have to be unregistered
+ * explicitly by hwmon_device_unregister().
+ *
+ * Return: On success, a pointer to the new ``hwmon`` device.
+ * The new device is automatically unregistered with the parent device.
+ * On failure, a &PTR_ERR.
  */
 struct device *
 devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
@@ -1024,15 +1042,21 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 EXPORT_SYMBOL_GPL(devm_hwmon_device_register_with_groups);
 
 /**
- * devm_hwmon_device_register_with_info - register w/ hwmon
- * @dev:	the parent device
- * @name:	hwmon name attribute
- * @drvdata:	driver data to attach to created device
- * @chip:	pointer to hwmon chip information
- * @extra_groups: pointer to list of driver specific attribute groups
+ * devm_hwmon_device_register_with_info - Register a hardware monitoring device.
+ * @dev: A pointer to the parent device (mandatory).
+ * @name: The ``hwmon`` device name (mandatory).
+ * @drvdata: A pointer to the private driver data structure.
+ * @chip: A pointer to the chip descriptor (mandatory).
+ * @extra_groups: A pointer to a ``NULL``-terminated list of additional
+ *	non-standard ``sysfs`` attribute groups.
+ *
+ * Similar to hwmon_device_register_with_info(), but the ``hwmon`` device it
+ * creates is device-managed, meaning it does not have to be unregistered
+ * explicitly by hwmon_device_unregister().
  *
- * Returns the pointer to the new device. The new device is automatically
- * unregistered with the parent device.
+ * Return: On success, a pointer to the new ``hwmon`` device.
+ * The new device is automatically unregistered with the parent device.
+ * On failure, a &PTR_ERR.
  */
 struct device *
 devm_hwmon_device_register_with_info(struct device *dev, const char *name,
@@ -1073,9 +1097,18 @@ static int devm_hwmon_match(struct device *dev, void *res, void *data)
 }
 
 /**
- * devm_hwmon_device_unregister - removes a previously registered hwmon device
+ * devm_hwmon_device_unregister - Unregister a previously registered hardware
+ * monitoring device.
  *
- * @dev: the parent device of the device to unregister
+ * @dev: A pointer to the parent device of the device to unregister.
+ *
+ * Does not normally have to be called. Only needed for error handling, and
+ * then only if both of the following apply:
+ *
+ *   - the driver probe fails after the call to
+ *     devm_hwmon_device_register_with_info() (or to the deprecated
+ *     :c:func:`devm_hwmon_device_register_with_groups()`, if applicable), and
+ *   - the automatic (device-managed) removal would be too late.
  */
 void devm_hwmon_device_unregister(struct device *dev)
 {
@@ -1102,14 +1135,20 @@ static char *__hwmon_sanitize_name(struct device *dev, const char *old_name)
 }
 
 /**
- * hwmon_sanitize_name - Replaces invalid characters in a hwmon name
- * @name: NUL-terminated name
+ * hwmon_sanitize_name - Replaces invalid characters in a ``hwmon`` name.
+ * @name: The ``hwmon`` device name to be sanitized (mandatory).
+ *
+ * If the driver doesn't use a static device name (for example, it uses
+ * :c:func:`dev_name()`), and therefore cannot make sure the name only
+ * contains valid characters, this convenience function can be used.
  *
  * Allocates a new string where any invalid characters will be replaced
  * by an underscore. It is the responsibility of the caller to release
  * the memory.
  *
- * Returns newly allocated name, or ERR_PTR on error.
+ * Return: On success, a sanitized duplicate string.
+ * It must be freed using kfree() when it is no longer needed.
+ * On failure, a &PTR_ERR.
  */
 char *hwmon_sanitize_name(const char *name)
 {
@@ -1118,14 +1157,15 @@ char *hwmon_sanitize_name(const char *name)
 EXPORT_SYMBOL_GPL(hwmon_sanitize_name);
 
 /**
- * devm_hwmon_sanitize_name - resource managed hwmon_sanitize_name()
- * @dev: device to allocate memory for
- * @name: NUL-terminated name
+ * devm_hwmon_sanitize_name - Replaces invalid characters in a ``hwmon`` name.
+ * @dev: A pointer to the device to allocate memory for.
+ * @name: The ``hwmon`` device name to be sanitized (mandatory).
  *
- * Allocates a new string where any invalid characters will be replaced
- * by an underscore.
+ * Similar to hwmon_sanitize_name(), but device-managed, meaning its result
+ * does not have to be explicitly freed by kfree().
  *
- * Returns newly allocated name, or ERR_PTR on error.
+ * Return: On success, a sanitized duplicate string.
+ * On failure, a &PTR_ERR.
  */
 char *devm_hwmon_sanitize_name(struct device *dev, const char *name)
 {
diff --git a/include/linux/hwmon-sysfs.h b/include/linux/hwmon-sysfs.h
index d896713359cd..e49963dea342 100644
--- a/include/linux/hwmon-sysfs.h
+++ b/include/linux/hwmon-sysfs.h
@@ -10,7 +10,15 @@
 #include <linux/device.h>
 #include <linux/kstrtox.h>
 
-struct sensor_device_attribute{
+/**
+ * struct sensor_device_attribute - A convenience structure for defining
+ * ``sysfs`` attributes.
+ * @dev_attr: An exported device attribute.
+ * @index: Additional context.
+ *
+ * May be useful if manually defining attributes. Not needed otherwise.
+ */
+struct sensor_device_attribute {
 	struct device_attribute dev_attr;
 	int index;
 };
@@ -43,6 +51,15 @@ struct sensor_device_attribute sensor_dev_attr_##_name		\
 #define SENSOR_DEVICE_ATTR_WO(_name, _func, _index)		\
 	SENSOR_DEVICE_ATTR(_name, 0200, NULL, _func##_store, _index)
 
+/**
+ * struct sensor_device_attribute_2 - A convenience structure for defining
+ * ``sysfs`` attributes.
+ * @dev_attr: An exported device attribute.
+ * @index: Additional context.
+ * @nr: More additional context.
+ *
+ * Similar to struct sensor_device_attribute, but with even more context.
+ */
 struct sensor_device_attribute_2 {
 	struct device_attribute dev_attr;
 	u8 index;
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 492dd27a5dd8..fe80e8e24b5a 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -17,6 +17,22 @@
 struct device;
 struct attribute_group;
 
+/**
+ * enum hwmon_sensor_types - Supported hardware monitoring sensor types.
+ * @hwmon_chip: Virtual sensor type used to describe attributes that are not
+ *	bound to a specific input or output.
+ * @hwmon_temp: Temperature sensor.
+ * @hwmon_in: Voltage sensor.
+ * @hwmon_curr: Current sensor.
+ * @hwmon_power: Power sensor.
+ * @hwmon_energy: Energy sensor.
+ * @hwmon_humidity: Humidity sensor.
+ * @hwmon_fan: Fan speed sensor.
+ * @hwmon_pwm: PWM control.
+ * @hwmon_intrusion: Chassis intrusion sensor.
+ * @hwmon_max: Not a sensor type. Code may refer to this value to determine
+ *	the number of currently supported sensor types.
+ */
 enum hwmon_sensor_types {
 	hwmon_chip,
 	hwmon_temp,
@@ -349,10 +365,9 @@ enum hwmon_intrusion_attributes {
 #define HWMON_INTRUSION_BEEP		BIT(hwmon_intrusion_beep)
 
 /**
- * struct hwmon_ops - hwmon device operations
+ * struct hwmon_ops - A ``hwmon`` callback descriptor.
  * @is_visible: Callback to return attribute visibility. Mandatory.
- *		Parameters are:
- *		@const void *drvdata:
+ *		@drvdata:
  *			Pointer to driver-private data structure passed
  *			as argument to hwmon_device_register_with_info().
  *		@type:	Sensor type
@@ -363,7 +378,6 @@ enum hwmon_intrusion_attributes {
  *		If the return value is 0, no attribute will be created.
  * @read:	Read callback for data attributes. Mandatory if readable
  *		data attributes are present.
- *		Parameters are:
  *		@dev:	Pointer to hardware monitoring device
  *		@type:	Sensor type
  *		@attr:	Sensor attribute
@@ -374,7 +388,6 @@ enum hwmon_intrusion_attributes {
  * @read_string:
  *		Read callback for string attributes. Mandatory if string
  *		attributes are present.
- *		Parameters are:
  *		@dev:	Pointer to hardware monitoring device
  *		@type:	Sensor type
  *		@attr:	Sensor attribute
@@ -384,7 +397,6 @@ enum hwmon_intrusion_attributes {
  *		The function returns 0 on success or a negative error number.
  * @write:	Write callback for data attributes. Mandatory if writeable
  *		data attributes are present.
- *		Parameters are:
  *		@dev:	Pointer to hardware monitoring device
  *		@type:	Sensor type
  *		@attr:	Sensor attribute
@@ -405,10 +417,39 @@ struct hwmon_ops {
 };
 
 /**
- * struct hwmon_channel_info - Channel information
- * @type:	Channel type.
- * @config:	Pointer to NULL-terminated list of channel parameters.
- *		Use for per-channel attributes.
+ * struct hwmon_channel_info - A ``hwmon`` channel descriptor.
+ * @type: The ``hwmon`` sensor type of the channels described.
+ * @config: A pointer to a ``0``-terminated list of channel configurations.
+ *	Use for per-channel attributes.
+ *
+ * Enumerates and specifies the standard ``sysfs`` attributes that should be
+ * created for all sensors of the same type that a chip provides.
+ *
+ * A *channel* refers to a single sensor, and a *channel configuration* is a
+ * :c:type:`u32` bitfield containing a combination of bit values describing
+ * that sensor's capabilities. A chip descriptor-aware hardware monitoring
+ * device registration function creates one or more standard ``sysfs``
+ * attributes for that sensor based on the capability bits set in its channel
+ * configuration.
+ *
+ * The complete list of bit values indicating individual attribute support is
+ * defined in ``<linux/hwmon.h>``. Definition prefixes are as follows:
+ *
+ * ============================ =======================================================
+ * Prefix			Description
+ * ============================ =======================================================
+ * ``HWMON_C_xxxx``		Chip attributes, for use with ``hwmon_chip``.
+ * ``HWMON_T_xxxx``		Temperature attributes, for use with ``hwmon_temp``.
+ * ``HWMON_I_xxxx``		Voltage attributes, for use with ``hwmon_in``.
+ * ``HWMON_C_xxxx``		Current attributes, for use with ``hwmon_curr``.
+ *				Notice the prefix overlap with chip attributes.
+ * ``HWMON_P_xxxx``		Power attributes, for use with ``hwmon_power``.
+ * ``HWMON_E_xxxx``		Energy attributes, for use with ``hwmon_energy``.
+ * ``HWMON_H_xxxx``		Humidity attributes, for use with ``hwmon_humidity``.
+ * ``HWMON_F_xxxx``		Fan speed attributes, for use with ``hwmon_fan``.
+ * ``HWMON_PWM_xxxx``		PWM control attributes, for use with ``hwmon_pwm``.
+ * ``HWMON_INTRUSION_xxxx``	Intrusion attributes, for use with ``hwmon_intrusion``.
+ * ============================ =======================================================
  */
 struct hwmon_channel_info {
 	enum hwmon_sensor_types type;
@@ -424,9 +465,13 @@ struct hwmon_channel_info {
 	})
 
 /**
- * struct hwmon_chip_info - Chip configuration
- * @ops:	Pointer to hwmon operations.
- * @info:	Null-terminated list of channel information.
+ * struct hwmon_chip_info - A ``hwmon`` chip descriptor.
+ * @ops: A pointer to the chip's callback descriptor.
+ * @info: A ``NULL``-terminated list of the chip's channel descriptors.
+ *
+ * Describes the capabilities of a chip (whether real or virtual), the types
+ * of its sensors, the number of sensors of each type, and the standard
+ * ``sysfs`` attributes that should be created for each sensor.
  */
 struct hwmon_chip_info {
 	const struct hwmon_ops *ops;
@@ -472,13 +517,10 @@ char *hwmon_sanitize_name(const char *name);
 char *devm_hwmon_sanitize_name(struct device *dev, const char *name);
 
 /**
- * hwmon_is_bad_char - Is the char invalid in a hwmon name
- * @ch: the char to be considered
- *
- * hwmon_is_bad_char() can be used to determine if the given character
- * may not be used in a hwmon name.
+ * hwmon_is_bad_char - Validate a char that might be used in a ``hwmon`` name.
+ * @ch: The char to be considered.
  *
- * Returns true if the char is invalid, false otherwise.
+ * Return: If the char would be invalid, ``true``. Otherwise, ``false``.
  */
 static inline bool hwmon_is_bad_char(const char ch)
 {
-- 
2.34.1

