Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DF66F66EE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjEDIM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjEDIMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:12:07 -0400
Received: from m228-4.mailgun.net (m228-4.mailgun.net [159.135.228.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D73B4ECD
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:09:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1683187766; x=1683194966; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To:
 From: From: Sender: Sender; bh=mzC3q3WmfI8APWa00eshzq1Cl9idNyizJ0UZbLwJd6E=;
 b=gYC8Vpu/CFinwi/ShpzbTU1PC0iuNWwiiiFnURKqWpFVoRFT+LYYNeOk5rItAqGqbWSFeBJshDYVhFUB3AB89UGuVJPKSXpUIvw2Yv5r7mvwwRZ93L44BxOmymtkXdnZrO8xBZYCuh3YgYEd98Vo54a3zRDSbCaMAiRzF0qSG3SsXVpb94IlRk5ow+YbBIb3oYBbM/L9OPeq3jYL6pMXFeQmZdefa0SCRfVtQj7XJOIAWIyn6TSiyrO1QJHaH0P4vNd4OtWHQ+aqnPvL9ZL1AHbQjzgdJExgyAym9PtnIIl5J3xRF5s91MG2L66fl5AUoeQxSvGUwJYiExNqq57qoA==
X-Mailgun-Sending-Ip: 159.135.228.4
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 897f46a039a2 with SMTP id
 645365bf8290b6a11e3daa73 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 04 May 2023 07:58:55 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     James Seo <james@equiv.tech>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 04/11] Documentation/hwmon: Revise hwmon kernel API reference
Date:   Thu,  4 May 2023 00:57:45 -0700
Message-Id: <20230504075752.1320967-5-james@equiv.tech>
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

Reorganize content into coherent sections.
Use kerneldocs to document functions and data structures when
possible and add more details on using various API facilities.
Fix minor issues (typos, grammar, etc.) and add markup.

Signed-off-by: James Seo <james@equiv.tech>
---
 Documentation/hwmon/hwmon-kernel-api.rst | 740 ++++++++++++-----------
 1 file changed, 384 insertions(+), 356 deletions(-)

diff --git a/Documentation/hwmon/hwmon-kernel-api.rst b/Documentation/hwmon/hwmon-kernel-api.rst
index c2d1e0299d8d..cf084e040522 100644
--- a/Documentation/hwmon/hwmon-kernel-api.rst
+++ b/Documentation/hwmon/hwmon-kernel-api.rst
@@ -1,374 +1,402 @@
+========================================
 The Linux Hardware Monitoring kernel API
 ========================================
 
 Guenter Roeck
 
+.. contents::
+
 Introduction
-------------
+============
 
 This document describes the API that can be used by hardware monitoring
 drivers that want to use the hardware monitoring framework.
 
-This document does not describe what a hardware monitoring (hwmon) Driver or
-Device is. It also does not describe the API which can be used by user space
-to communicate with a hardware monitoring device. If you want to know this
-then please read the following file: Documentation/hwmon/sysfs-interface.rst.
+This document does not describe what a hardware monitoring (``hwmon``) driver
+or device is, nor does it describe the API for communicating with a hardware
+monitoring device from userspace. For more information on these topics,
+please read Documentation/hwmon/sysfs-interface.rst.
 
-For additional guidelines on how to write and improve hwmon drivers, please
-also read Documentation/hwmon/submitting-patches.rst.
+For additional guidelines on how to write and improve ``hwmon`` drivers,
+please also read Documentation/hwmon/submitting-patches.rst.
 
 The API
--------
-Each hardware monitoring driver must #include <linux/hwmon.h> and, in some
-cases, <linux/hwmon-sysfs.h>. linux/hwmon.h declares the following
-register/unregister functions::
-
-  struct device *
-  hwmon_device_register_with_info(struct device *dev,
-				  const char *name, void *drvdata,
-				  const struct hwmon_chip_info *info,
-				  const struct attribute_group **extra_groups);
-
-  struct device *
-  devm_hwmon_device_register_with_info(struct device *dev,
-				       const char *name,
-				       void *drvdata,
-				       const struct hwmon_chip_info *info,
-				       const struct attribute_group **extra_groups);
-
-  void hwmon_device_unregister(struct device *dev);
-
-  void devm_hwmon_device_unregister(struct device *dev);
-
-  char *hwmon_sanitize_name(const char *name);
-
-  char *devm_hwmon_sanitize_name(struct device *dev, const char *name);
-
-hwmon_device_register_with_info registers a hardware monitoring device.
-It creates the standard sysfs attributes in the hardware monitoring core,
-letting the driver focus on reading from and writing to the chip instead
-of having to bother with sysfs attributes. The parent device parameter
-as well as the chip parameter must not be NULL. Its parameters are described
-in more detail below.
-
-devm_hwmon_device_register_with_info is similar to
-hwmon_device_register_with_info. However, it is device managed, meaning the
-hwmon device does not have to be removed explicitly by the removal function.
-
-All other hardware monitoring device registration functions are deprecated
-and must not be used in new drivers.
-
-hwmon_device_unregister deregisters a registered hardware monitoring device.
-The parameter of this function is the pointer to the registered hardware
-monitoring device structure. This function must be called from the driver
-remove function if the hardware monitoring device was registered with
-hwmon_device_register_with_info.
-
-devm_hwmon_device_unregister does not normally have to be called. It is only
-needed for error handling, and only needed if the driver probe fails after
-the call to hwmon_device_register_with_info and if the automatic (device
-managed) removal would be too late.
-
-All supported hwmon device registration functions only accept valid device
-names. Device names including invalid characters (whitespace, '*', or '-')
-will be rejected. The 'name' parameter is mandatory.
-
-If the driver doesn't use a static device name (for example it uses
-dev_name()), and therefore cannot make sure the name only contains valid
-characters, hwmon_sanitize_name can be used. This convenience function
-will duplicate the string and replace any invalid characters with an
-underscore. It will allocate memory for the new string and it is the
-responsibility of the caller to release the memory when the device is
-removed.
-
-devm_hwmon_sanitize_name is the resource managed version of
-hwmon_sanitize_name; the memory will be freed automatically on device
-removal.
-
-Using devm_hwmon_device_register_with_info()
---------------------------------------------
-
-hwmon_device_register_with_info() registers a hardware monitoring device.
-The parameters to this function are
-
-=============================================== ===============================================
-`struct device *dev`				Pointer to parent device
-`const char *name`				Device name
-`void *drvdata`					Driver private data
-`const struct hwmon_chip_info *info`		Pointer to chip description.
-`const struct attribute_group **extra_groups` 	Null-terminated list of additional non-standard
-						sysfs attribute groups.
-=============================================== ===============================================
-
-This function returns a pointer to the created hardware monitoring device
-on success and a negative error code for failure.
-
-The hwmon_chip_info structure looks as follows::
-
-	struct hwmon_chip_info {
-		const struct hwmon_ops *ops;
-		const struct hwmon_channel_info * const *info;
-	};
-
-It contains the following fields:
-
-* ops:
-	Pointer to device operations.
-* info:
-	NULL-terminated list of device channel descriptors.
-
-The list of hwmon operations is defined as::
-
-  struct hwmon_ops {
-	umode_t (*is_visible)(const void *, enum hwmon_sensor_types type,
-			      u32 attr, int);
-	int (*read)(struct device *, enum hwmon_sensor_types type,
-		    u32 attr, int, long *);
-	int (*write)(struct device *, enum hwmon_sensor_types type,
-		     u32 attr, int, long);
-  };
+=======
+
+Each hardware monitoring driver must ``#include <linux/hwmon.h>`` and, in some
+cases, ``<linux/hwmon-sysfs.h>``.
+
+Functions
+---------
+
+``<linux/hwmon.h>`` declares several functions related to hardware monitoring
+device registration and deregistration.
+
+.. attention::
+  All functions not listed here are deprecated and **must not** be used in new
+  drivers.
+
+All supported ``hwmon`` device registration functions have a mandatory **name**
+parameter that must contain a valid device name. Device names including invalid
+characters (whitespace, '``*``', or '``-``') will be rejected. This becomes the
+device's ``name`` standard attribute in ``sysfs``.
+
+Drivers may later retrieve the pointer passed as the **drvdata** parameter to a
+registration function by using :c:func:`dev_get_drvdata()` on the pointer to the
+``hwmon`` device.
+
+These functions signal failure by returning "a :c:type:`PTR_ERR`", a pointer
+value containing an error code that can be obtained using :c:func:`PTR_ERR()`.
+
+``hwmon_device_register_with_info()``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. _hwmon_device_register_with_info:
+.. kernel-doc:: drivers/hwmon/hwmon.c
+  :identifiers: hwmon_device_register_with_info
+
+``devm_hwmon_device_register_with_info()``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. _devm_hwmon_device_register_with_info:
+.. kernel-doc:: drivers/hwmon/hwmon.c
+  :identifiers: devm_hwmon_device_register_with_info
+
+``hwmon_device_unregister()``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. kernel-doc:: drivers/hwmon/hwmon.c
+  :identifiers: hwmon_device_unregister
+
+``devm_hwmon_device_unregister()``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. kernel-doc:: drivers/hwmon/hwmon.c
+  :identifiers: devm_hwmon_device_unregister
+
+``hwmon_sanitize_name()``
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. kernel-doc:: drivers/hwmon/hwmon.c
+  :identifiers: hwmon_sanitize_name
+
+``devm_hwmon_sanitize_name()``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. kernel-doc:: drivers/hwmon/hwmon.c
+  :identifiers: devm_hwmon_sanitize_name
+
+Data structures
+---------------
+
+The following data structures are declared in ``<linux/hwmon.h>``,
+except for struct sensor_device_attribute and struct sensor_device_attribute,
+which are declared in ``<linux/hwmon_sysfs.h>``.
+
+``enum hwmon_sensor_types``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. kernel-doc:: include/linux/hwmon.h
+  :identifiers: hwmon_sensor_types
+
+``struct hwmon_chip_info``
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. kernel-doc:: include/linux/hwmon.h
+  :identifiers: hwmon_chip_info
+
+``struct hwmon_ops``
+~~~~~~~~~~~~~~~~~~~~
+
+.. kernel-doc:: include/linux/hwmon.h
+  :identifiers: hwmon_ops
+
+**Description**
 
-It defines the following operations.
-
-* is_visible:
-    Pointer to a function to return the file mode for each supported
-    attribute. This function is mandatory.
-
-* read:
-    Pointer to a function for reading a value from the chip. This function
-    is optional, but must be provided if any readable attributes exist.
-
-* write:
-    Pointer to a function for writing a value to the chip. This function is
-    optional, but must be provided if any writeable attributes exist.
-
-Each sensor channel is described with struct hwmon_channel_info, which is
-defined as follows::
-
-	struct hwmon_channel_info {
-		enum hwmon_sensor_types type;
-		u32 *config;
-	};
-
-It contains following fields:
-
-* type:
-    The hardware monitoring sensor type.
-
-    Supported sensor types are
-
-     ================== ==================================================
-     hwmon_chip		A virtual sensor type, used to describe attributes
-			which are not bound to a specific input or output
-     hwmon_temp		Temperature sensor
-     hwmon_in		Voltage sensor
-     hwmon_curr		Current sensor
-     hwmon_power		Power sensor
-     hwmon_energy	Energy sensor
-     hwmon_humidity	Humidity sensor
-     hwmon_fan		Fan speed sensor
-     hwmon_pwm		PWM control
-     ================== ==================================================
-
-* config:
-    Pointer to a 0-terminated list of configuration values for each
-    sensor of the given type. Each value is a combination of bit values
-    describing the attributes supposed by a single sensor.
-
-As an example, here is the complete description file for a LM75 compatible
-sensor chip. The chip has a single temperature sensor. The driver wants to
-register with the thermal subsystem (HWMON_C_REGISTER_TZ), and it supports
-the update_interval attribute (HWMON_C_UPDATE_INTERVAL). The chip supports
-reading the temperature (HWMON_T_INPUT), it has a maximum temperature
-register (HWMON_T_MAX) as well as a maximum temperature hysteresis register
-(HWMON_T_MAX_HYST)::
-
-	static const u32 lm75_chip_config[] = {
-		HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL,
-		0
-	};
-
-	static const struct hwmon_channel_info lm75_chip = {
-		.type = hwmon_chip,
-		.config = lm75_chip_config,
-	};
-
-	static const u32 lm75_temp_config[] = {
-		HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST,
-		0
-	};
-
-	static const struct hwmon_channel_info lm75_temp = {
-		.type = hwmon_temp,
-		.config = lm75_temp_config,
-	};
-
-	static const struct hwmon_channel_info * const lm75_info[] = {
-		&lm75_chip,
-		&lm75_temp,
-		NULL
-	};
-
-	The HWMON_CHANNEL_INFO() macro can and should be used when possible.
-	With this macro, the above example can be simplified to
-
-	static const struct hwmon_channel_info * const lm75_info[] = {
-		HWMON_CHANNEL_INFO(chip,
-				HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL),
-		HWMON_CHANNEL_INFO(temp,
-				HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST),
-		NULL
-	};
-
-	The remaining declarations are as follows.
-
-	static const struct hwmon_ops lm75_hwmon_ops = {
-		.is_visible = lm75_is_visible,
-		.read = lm75_read,
-		.write = lm75_write,
-	};
-
-	static const struct hwmon_chip_info lm75_chip_info = {
-		.ops = &lm75_hwmon_ops,
-		.info = lm75_info,
-	};
-
-A complete list of bit values indicating individual attribute support
-is defined in include/linux/hwmon.h. Definition prefixes are as follows.
-
-=============== =================================================
-HWMON_C_xxxx	Chip attributes, for use with hwmon_chip.
-HWMON_T_xxxx	Temperature attributes, for use with hwmon_temp.
-HWMON_I_xxxx	Voltage attributes, for use with hwmon_in.
-HWMON_C_xxxx	Current attributes, for use with hwmon_curr.
-		Notice the prefix overlap with chip attributes.
-HWMON_P_xxxx	Power attributes, for use with hwmon_power.
-HWMON_E_xxxx	Energy attributes, for use with hwmon_energy.
-HWMON_H_xxxx	Humidity attributes, for use with hwmon_humidity.
-HWMON_F_xxxx	Fan speed attributes, for use with hwmon_fan.
-HWMON_PWM_xxxx	PWM control attributes, for use with hwmon_pwm.
-=============== =================================================
+Please see `Driver callback functions`_ for more information.
+
+``struct hwmon_channel_info``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. kernel-doc:: include/linux/hwmon.h
+  :identifiers: hwmon_channel_info
+
+``struct sensor_device_attribute``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. kernel-doc:: include/linux/hwmon-sysfs.h
+  :identifiers: sensor_device_attribute
+
+Please see `Driver-provided sysfs attributes`_ for usage scenarios.
+
+``struct sensor_device_attribute_2``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. kernel-doc:: include/linux/hwmon-sysfs.h
+  :identifiers: sensor_device_attribute_2
 
 Driver callback functions
 -------------------------
 
-Each driver provides is_visible, read, and write functions. Parameters
-and return values for those functions are as follows::
-
-  umode_t is_visible_func(const void *data, enum hwmon_sensor_types type,
-			  u32 attr, int channel)
-
-Parameters:
-	data:
-		Pointer to device private data structure.
-	type:
-		The sensor type.
-	attr:
-		Attribute identifier associated with a specific attribute.
-		For example, the attribute value for HWMON_T_INPUT would be
-		hwmon_temp_input. For complete mappings of bit fields to
-		attribute values please see include/linux/hwmon.h.
-	channel:
-		The sensor channel number.
-
-Return value:
-	The file mode for this attribute. Typically, this will be 0 (the
-	attribute will not be created), 0444, or 0644.
-
-::
-
-	int read_func(struct device *dev, enum hwmon_sensor_types type,
-		      u32 attr, int channel, long *val)
-
-Parameters:
-	dev:
-		Pointer to the hardware monitoring device.
-	type:
-		The sensor type.
-	attr:
-		Attribute identifier associated with a specific attribute.
-		For example, the attribute value for HWMON_T_INPUT would be
-		hwmon_temp_input. For complete mappings please see
-		include/linux/hwmon.h.
-	channel:
-		The sensor channel number.
-	val:
-		Pointer to attribute value.
-
-Return value:
-	0 on success, a negative error number otherwise.
-
-::
-
-	int write_func(struct device *dev, enum hwmon_sensor_types type,
-		       u32 attr, int channel, long val)
-
-Parameters:
-	dev:
-		Pointer to the hardware monitoring device.
-	type:
-		The sensor type.
-	attr:
-		Attribute identifier associated with a specific attribute.
-		For example, the attribute value for HWMON_T_INPUT would be
-		hwmon_temp_input. For complete mappings please see
-		include/linux/hwmon.h.
-	channel:
-		The sensor channel number.
-	val:
-		The value to write to the chip.
-
-Return value:
-	0 on success, a negative error number otherwise.
-
-
-Driver-provided sysfs attributes
---------------------------------
-
-In most situations it should not be necessary for a driver to provide sysfs
-attributes since the hardware monitoring core creates those internally.
-Only additional non-standard sysfs attributes need to be provided.
-
-The header file linux/hwmon-sysfs.h provides a number of useful macros to
-declare and use hardware monitoring sysfs attributes.
-
-In many cases, you can use the existing define DEVICE_ATTR or its variants
-DEVICE_ATTR_{RW,RO,WO} to declare such attributes. This is feasible if an
-attribute has no additional context. However, in many cases there will be
-additional information such as a sensor index which will need to be passed
-to the sysfs attribute handling function.
-
-SENSOR_DEVICE_ATTR and SENSOR_DEVICE_ATTR_2 can be used to define attributes
-which need such additional context information. SENSOR_DEVICE_ATTR requires
-one additional argument, SENSOR_DEVICE_ATTR_2 requires two.
-
-Simplified variants of SENSOR_DEVICE_ATTR and SENSOR_DEVICE_ATTR_2 are available
-and should be used if standard attribute permissions and function names are
-feasible. Standard permissions are 0644 for SENSOR_DEVICE_ATTR[_2]_RW,
-0444 for SENSOR_DEVICE_ATTR[_2]_RO, and 0200 for SENSOR_DEVICE_ATTR[_2]_WO.
-Standard functions, similar to DEVICE_ATTR_{RW,RO,WO}, have _show and _store
-appended to the provided function name.
-
-SENSOR_DEVICE_ATTR and its variants define a struct sensor_device_attribute
-variable. This structure has the following fields::
-
-	struct sensor_device_attribute {
-		struct device_attribute dev_attr;
-		int index;
-	};
-
-You can use to_sensor_dev_attr to get the pointer to this structure from the
-attribute read or write function. Its parameter is the device to which the
-attribute is attached.
-
-SENSOR_DEVICE_ATTR_2 and its variants define a struct sensor_device_attribute_2
-variable, which is defined as follows::
-
-	struct sensor_device_attribute_2 {
-		struct device_attribute dev_attr;
-		u8 index;
-		u8 nr;
-	};
-
-Use to_sensor_dev_attr_2 to get the pointer to this structure. Its parameter
-is the device to which the attribute is attached.
+.. kernel-docs do not render correctly for function pointer struct fields.
+
+If the driver is using one of the recommended
+`chip descriptor <#struct-hwmon-chip-info>`_-aware device registration functions
+(devm_hwmon_device_register_with_info() or hwmon_device_register_with_info()),
+it must implement callback functions with the function signatures below and fill
+in its chip descriptor's **ops** `callback descriptor <#struct-hwmon-ops>`_
+field as needed.
+
+If this is not the case, or if the driver provides additional non-standard
+attributes, please see `Driver-provided sysfs attributes`_.
+
+For complete mappings of **attr** bit fields to attribute values, please see
+``<linux/hwmon.h>``.
+
+.. note::
+  The callback function names below are for illustration only.
+
+``is_visible_func()``
+~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+  umode_t is_visible_func(const void *drvdata, enum hwmon_sensor_types type,
+                          u32 attr, int channel)
+
+..
+
+  **Parameters**
+
+  ``const void *drvdata``
+    A pointer to the device private data structure.
+    This is the **drvdata** pointer provided during registration.
+
+  ``enum hwmon_sensor_types type``
+    The ``hwmon`` sensor type.
+
+  ``u32 attr``
+    The attribute identifier associated with a specific attribute.
+
+    For example, the attribute value for ``HWMON_T_INPUT`` would be
+    ``hwmon_temp_input``.
+
+  ``int channel``
+    The sensor channel number.
+
+  **Description**
+
+  Implements the ``hwmon`` callback :c:func:`is_visible()`. Mandatory.
+
+  Drivers request automatic creation of standard ``sysfs`` attributes by
+  specifying them in a `channel descriptor <#struct-hwmon-channel-info>`_
+  list. This function is called once per attribute during device registration
+  to determine the file mode that the attribute will have.
+
+  **Return**
+
+  The file mode for the specified attribute. Typically, this will be
+  ``0`` (the attribute will not be created after all), ``0444``, or ``0644``.
+
+``read_func()``
+~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+  int read_func(struct device *dev, enum hwmon_sensor_types type,
+                u32 attr, int channel, long *val)
+
+..
+
+  **Parameters**
+
+  ``struct device *dev``
+    A pointer to the hardware monitoring device.
+
+  ``enum hwmon_sensor_types type``
+    The ``hwmon`` sensor type.
+
+  ``u32 attr``
+    The attribute identifier associated with a specific attribute.
+
+    For example, the attribute value for ``HWMON_T_INPUT`` would be
+    ``hwmon_temp_input``.
+
+  ``int channel``
+    The sensor channel number.
+
+  ``long *val``
+    An out pointer to the attribute value.
+
+    A string representation of the value will be exported to
+    userspace as the result of reading from the attribute.
+
+  **Description**
+
+  Implements the ``hwmon`` callback :c:func:`read()`.
+  Mandatory if any readable attributes exist.
+
+  Called when the user reads from a readable ``sysfs`` attribute.
+
+  **Return**
+
+  On success, ``0``. On failure, a negative error code.
+
+``write_func()``
+~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+  int write_func(struct device *dev, enum hwmon_sensor_types type,
+                 u32 attr, int channel, long val)
+
+..
+
+  **Parameters**
+
+  ``struct device *dev``
+    A pointer to the hardware monitoring device.
+
+  ``enum hwmon_sensor_types type``
+    The ``hwmon`` sensor type.
+
+  ``u32 attr``
+    The attribute identifier associated with a specific attribute.
+
+    For example, the attribute value for ``HWMON_T_INPUT`` would be
+    ``hwmon_temp_input``.
+
+  ``int channel``
+    The sensor channel number.
+
+  ``long val``
+    The value to write to the chip.
+
+    This is the string the user wrote to the ``sysfs`` attribute,
+    parsed to a ``long`` value.
+
+  **Description**
+  Implements the ``hwmon`` callback :c:func:`read()`. Mandatory if any
+  readable attributes exist.
+
+  Called when the user reads from a readable ``sysfs`` attribute.
+
+  **Return**
+
+  On success, ``0``. On failure, a negative error code.
+
+Driver-provided ``sysfs`` attributes
+------------------------------------
+
+.. note::
+  In most situations it should not be necessary for a driver to provide its own
+  ``sysfs`` attributes, since the hardware monitoring core creates those
+  internally.
+
+  Unless using a deprecated device registration function, only additional
+  non-standard ``sysfs`` attributes need to be provided, and non-standard
+  attributes are generally discouraged unless really needed.
+
+The header file ``<linux/hwmon-sysfs.h>`` provides a number of useful macros to
+declare and use hardware monitoring ``sysfs`` attributes.
+
+In many cases, you can use the existing ``DEVICE_ATTR`` macro from
+``<linux/device.h>`` or its variants ``SENSOR_ATTR_{RW,RO,WO}`` to declare such
+attributes. This is feasible if an attribute has no additional context. However,
+in many cases there will be additional information, such as a sensor index,
+which will need to be passed to the ``sysfs`` attribute handling function.
+
+The ``SENSOR_DEVICE_ATTR`` and ``SENSOR_DEVICE_ATTR_2`` macros can be used to
+define attributes which need such additional context information.
+``SENSOR_DEVICE_ATTR`` requires one additional argument.
+``SENSOR_DEVICE_ATTR_2`` requires two.
+
+Simplified variants of ``SENSOR_DEVICE_ATTR`` and ``SENSOR_DEVICE_ATTR_2`` are
+available, and should be used if standard attribute permissions and function
+names are feasible. Standard permissions are ``0644`` for
+``SENSOR_DEVICE_ATTR[_2]_RW``, ``0444`` for ``SENSOR_DEVICE_ATTR[_2]_RO``, and
+``0200`` for ``SENSOR_DEVICE_ATTR[_2]_WO``. Standard functions, similar to
+``DEVICE_ATTR_{RW,RO,WO}``, have ``_show`` and ``_store`` appended to the
+provided function name.
+
+``SENSOR_DEVICE_ATTR`` and its variants expand to a declaration of a struct
+sensor_device_attribute variable. You can use the :c:func:`to_sensor_dev_attr()`
+function-like macro to get the pointer to this structure from the attribute read
+or write function. Its parameter is the device to which the attribute is
+attached.
+
+``SENSOR_DEVICE_ATTR_2`` and its variants expand to a declaration of a struct
+sensor_device_attribute_2 variable. Use the :c:func:`to_sensor_dev_attr_2()`
+function-like macro to get the pointer to this structure. Its parameter is the
+device to which the attribute is attached.
+
+Example: An LM75-compatible sensor chip
+=======================================
+
+As an example, here is the `chip descriptor <#struct-hwmon-chip-info>`_ for an
+LM75-compatible sensor chip, comprising a
+`callback descriptor <#struct-hwmon-ops>`_  and a list of
+`channel descriptors <#struct-hwmon-channel-info>`_.
+
+First, consider the chip's channel descriptors. Notice the following:
+
+* The chip has a single temperature sensor.
+* The driver wants to register with the thermal subsystem
+  (``HWMON_C_REGISTER_TZ``), and it supports the ``update_interval`` attribute
+  (``HWMON_C_UPDATE_INTERVAL``), requiring a virtual channel to be defined.
+* The chip supports reading the temperature (``HWMON_T_INPUT``), and it has a
+  maximum temperature register (``HWMON_T_MAX``) as well as a maximum
+  temperature hysteresis register (``HWMON_T_MAX_HYST``).
+
+.. code-block:: c
+
+  static const u32 lm75_chip_config[] = {
+          HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL,
+          0
+  };
+
+  static const struct hwmon_channel_info lm75_chip = {
+          .type = hwmon_chip,
+          .config = lm75_chip_config,
+  };
+
+  static const u32 lm75_temp_config[] = {
+          HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST,
+          0
+  };
+
+  static const struct hwmon_channel_info lm75_temp = {
+          .type = hwmon_temp,
+          .config = lm75_temp_config,
+  };
+
+  static const struct hwmon_channel_info * const lm75_info[] = {
+          &lm75_chip,
+          &lm75_temp,
+          NULL
+  };
+
+There is also a ``HWMON_CHANNEL_INFO()`` macro that can and should be used when
+possible in order to simplify the declaration of a channel descriptor list.
+With this macro, the complete chip descriptor definition becomes:
+
+.. code-block:: c
+
+  static const struct hwmon_channel_info * const lm75_info[] = {
+          HWMON_CHANNEL_INFO(chip,
+                             HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL),
+          HWMON_CHANNEL_INFO(temp,
+                             HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST),
+          NULL
+  };
+
+  static const struct hwmon_ops lm75_hwmon_ops = {
+          .is_visible = lm75_is_visible,
+          .read = lm75_read,
+          .write = lm75_write,
+  };
+
+  static const struct hwmon_chip_info lm75_chip_info = {
+          .ops = &lm75_hwmon_ops,
+          .info = lm75_info,
+  };
-- 
2.34.1

