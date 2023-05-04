Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344E66F66F0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjEDINB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjEDIML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:12:11 -0400
Received: from m228-4.mailgun.net (m228-4.mailgun.net [159.135.228.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E5E449A
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:09:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1683187776; x=1683194976; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To:
 From: From: Sender: Sender; bh=f3US+s/jajrnUVTiDESp5MOHD58TZGnv9lLhnq/av/A=;
 b=rGvuhEY3rDB18k9M45SMzVuBkzdC2crm1ZLh+VOe3FJF9uQKUj1Q1zvh4PCfen07WXw02U0hmjG0+XkEZSKmyMB2IY1Bo/8E4cZYuVHhqviNF2ljTDgGePL1XFK9+tqNBhMYhuvI+eSOK4VSenLjoC5tQcRzurPuT9k3+bLKB7SD5qZmI2A0qRhpUfGeKZ6Lkj6XbPKWfj+qYPHaJo1XPIL9I00eEM1kyTQ7ItiERxy7t+ZvJd7tF851XEe64suMRbAKVfMpGwNjnVSskQdr6G/64d7UJi+Ag8Z1ALPZN1OPPzInz851NT25+IWBygqwJu9m1RVwjBEoHQsS4JNiiQ==
X-Mailgun-Sending-Ip: 159.135.228.4
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 1e2448ceea75 with SMTP id
 645365caf77227a83038b907 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 04 May 2023 07:59:06 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     James Seo <james@equiv.tech>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 05/11] Documentation/hwmon: Revise PMBus core documentation
Date:   Thu,  4 May 2023 00:57:46 -0700
Message-Id: <20230504075752.1320967-6-james@equiv.tech>
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

Organize content into sections.
Fix minor issues (typos, grammar, etc.) and add markup.

Signed-off-by: James Seo <james@equiv.tech>
---
 Documentation/hwmon/pmbus-core.rst | 348 +++++++++++++++++------------
 1 file changed, 199 insertions(+), 149 deletions(-)

diff --git a/Documentation/hwmon/pmbus-core.rst b/Documentation/hwmon/pmbus-core.rst
index cff93adf6e42..2f88a03446d2 100644
--- a/Documentation/hwmon/pmbus-core.rst
+++ b/Documentation/hwmon/pmbus-core.rst
@@ -2,75 +2,82 @@
 PMBus core driver and internal API
 ==================================
 
+.. contents::
+
 Introduction
 ============
 
-[from pmbus.org] The Power Management Bus (PMBus) is an open standard
-power-management protocol with a fully defined command language that facilitates
-communication with power converters and other devices in a power system. The
-protocol is implemented over the industry-standard SMBus serial interface and
-enables programming, control, and real-time monitoring of compliant power
-conversion products. This flexible and highly versatile standard allows for
-communication between devices based on both analog and digital technologies, and
-provides true interoperability which will reduce design complexity and shorten
-time to market for power system designers. Pioneered by leading power supply and
-semiconductor companies, this open power system standard is maintained and
-promoted by the PMBus Implementers Forum (PMBus-IF), comprising 30+ adopters
-with the objective to provide support to, and facilitate adoption among, users.
+  The Power Management Bus (PMBus) is an open standard power-management protocol
+  with a fully defined command language that facilitates communication with
+  power converters and other devices in a power system. The protocol is
+  implemented over the industry-standard SMBus serial interface and enables
+  programming, control, and real-time monitoring of compliant power conversion
+  products. This flexible and highly versatile standard allows for communication
+  between devices based on both analog and digital technologies, and provides
+  true interoperability which will reduce design complexity and shorten time to
+  market for power system designers. Pioneered by leading power supply and
+  semiconductor companies, this open power system standard is maintained and
+  promoted by the PMBus Implementers Forum (PMBus-IF), comprising 30+ adopters
+  with the objective to provide support to, and facilitate adoption among,
+  users.
+
+    (from pmbus.org)
 
 Unfortunately, while PMBus commands are standardized, there are no mandatory
 commands, and manufacturers can add as many non-standard commands as they like.
-Also, different PMBUs devices act differently if non-supported commands are
-executed. Some devices return an error, some devices return 0xff or 0xffff and
-set a status error flag, and some devices may simply hang up.
+Also, different PMBus devices act differently if non-supported commands are
+executed. Some devices return an error, some devices return ``0xff`` or
+``0xffff`` and set a status error flag, and some devices may simply hang up.
 
 Despite all those difficulties, a generic PMBus device driver is still useful
-and supported since kernel version 2.6.39. However, it was necessary to support
-device specific extensions in addition to the core PMBus driver, since it is
-simply unknown what new device specific functionality PMBus device developers
-come up with next.
+and has been supported since kernel version 2.6.39. However, it was necessary to
+support device-specific extensions in addition to the core PMBus driver, since
+it is simply unknown what new device-specific functionality PMBus device
+developers will come up with next.
 
 To make device specific extensions as scalable as possible, and to avoid having
 to modify the core PMBus driver repeatedly for new devices, the PMBus driver was
-split into core, generic, and device specific code. The core code (in
-pmbus_core.c) provides generic functionality. The generic code (in pmbus.c)
-provides support for generic PMBus devices. Device specific code is responsible
-for device specific initialization and, if needed, maps device specific
-functionality into generic functionality. This is to some degree comparable
-to PCI code, where generic code is augmented as needed with quirks for all kinds
-of devices.
+split into core, generic, and device-specific code.
+The core code (in ``pmbus_core.c``) provides generic functionality.
+The generic code (in ``pmbus.c``) provides support for generic PMBus devices.
+Device-specific code is responsible for device-specific initialization and, if
+needed, maps device-specific functionality into generic functionality.
+This is to some degree comparable to PCI code, where generic code is augmented
+as needed with quirks for all kinds of devices.
 
 PMBus device capabilities auto-detection
 ========================================
 
-For generic PMBus devices, code in pmbus.c attempts to auto-detect all supported
-PMBus commands. Auto-detection is somewhat limited, since there are simply too
-many variables to consider. For example, it is almost impossible to autodetect
-which PMBus commands are paged and which commands are replicated across all
-pages (see the PMBus specification for details on multi-page PMBus devices).
+For generic PMBus devices, code in ``pmbus.c`` attempts to auto-detect all
+supported PMBus commands. Auto-detection is somewhat limited, since there are
+simply too many variables to consider. For example, it is almost impossible to
+autodetect which PMBus commands are paged and which commands are replicated
+across all pages (see the PMBus specification for details on multi-page PMBus
+devices).
 
-For this reason, it often makes sense to provide a device specific driver if not
+For this reason, it often makes sense to provide a device-specific driver if not
 all commands can be auto-detected. The data structures in this driver can be
 used to inform the core driver about functionality supported by individual
 chips.
 
 Some commands are always auto-detected. This applies to all limit commands
-(lcrit, min, max, and crit attributes) as well as associated alarm attributes.
-Limits and alarm attributes are auto-detected because there are simply too many
-possible combinations to provide a manual configuration interface.
+(``lcrit``, ``min``, ``max``, and ``crit`` attributes) as well as associated
+``alarm`` attributes. Limits and alarm attributes are auto-detected because
+there are simply too many possible combinations to provide a manual
+configuration interface.
 
 PMBus internal API
 ==================
 
 The API between core and device specific PMBus code is defined in
-drivers/hwmon/pmbus/pmbus.h. In addition to the internal API, pmbus.h defines
-standard PMBus commands and virtual PMBus commands.
+``drivers/hwmon/pmbus/pmbus.h``. In addition to the internal API, ``pmbus.h``
+defines standard PMBus commands and virtual PMBus commands.
 
 Standard PMBus commands
 -----------------------
 
-Standard PMBus commands (commands values 0x00 to 0xff) are defined in the PMBUs
-specification.
+Standard PMBus commands (commands values ``0x00`` to ``0xff``) are defined in
+the PMBus specification.
 
 Virtual PMBus commands
 ----------------------
@@ -79,26 +86,26 @@ Virtual PMBus commands are provided to enable support for non-standard
 functionality which has been implemented by several chip vendors and is thus
 desirable to support.
 
-Virtual PMBus commands start with command value 0x100 and can thus easily be
-distinguished from standard PMBus commands (which can not have values larger
-than 0xff). Support for virtual PMBus commands is device specific and thus has
-to be implemented in device specific code.
+Virtual PMBus commands start with command value ``0x100`` and can thus easily be
+distinguished from standard PMBus commands (which cannot have values larger than
+``0xff``). Support for virtual PMBus commands is device-specific and thus has
+to be implemented in device-specific code.
 
-Virtual commands are named PMBUS_VIRT_xxx and start with PMBUS_VIRT_BASE. All
-virtual commands are word sized.
+Virtual commands are named ``PMBUS_VIRT_xxx`` and start with
+``PMBUS_VIRT_BASE``. All virtual commands are word-sized.
 
 There are currently two types of virtual commands.
 
-- READ commands are read-only; writes are either ignored or return an error.
-- RESET commands are read/write. Reading reset registers returns zero
-  (used for detection), writing any value causes the associated history to be
+- ``READ`` commands are read-only; writes are either ignored or return an error.
+- ``RESET`` commands are read/write. Reading reset registers returns zero
+  (used for detection). Writing any value causes the associated history to be
   reset.
 
-Virtual commands have to be handled in device specific driver code. Chip driver
+Virtual commands have to be handled in device-specific driver code. Chip driver
 code returns non-negative values if a virtual command is supported, or a
-negative error code if not. The chip driver may return -ENODATA or any other
-Linux error code in this case, though an error code other than -ENODATA is
-handled more efficiently and thus preferred. Either case, the calling PMBus
+negative error code if not. The chip driver may return ``-ENODATA`` or any other
+Linux error code in this case, though an error code other than ``-ENODATA`` is
+handled more efficiently and thus preferred. In either case, the calling PMBus
 core code will abort if the chip driver returns an error code when reading
 or writing virtual registers (in other words, the PMBus core code will never
 send a virtual command to a chip).
@@ -106,8 +113,8 @@ send a virtual command to a chip).
 PMBus driver information
 ------------------------
 
-PMBus driver information, defined in struct pmbus_driver_info, is the main means
-for device specific drivers to pass information to the core PMBus driver.
+PMBus driver information, defined in ``struct pmbus_driver_info``, is the main
+means for device specific drivers to pass information to the core PMBus driver.
 Specifically, it provides the following information.
 
 - For devices supporting its data in Direct Data Format, it provides coefficients
@@ -119,14 +126,14 @@ Specifically, it provides the following information.
 - Several function entry points are provided to support overriding and/or
   augmenting generic command execution. This functionality can be used to map
   non-standard PMBus commands to standard commands, or to augment standard
-  command return values with device specific information.
+  command return values with device-specific information.
 
 PEC Support
 ===========
 
 Many PMBus devices support SMBus PEC (Packet Error Checking). If supported
 by both the I2C adapter and by the PMBus chip, it is by default enabled.
-If PEC is supported, the PMBus core driver adds an attribute named 'pec' to
+If PEC is supported, the PMBus core driver adds an attribute named ``pec`` to
 the I2C device. This attribute can be used to control PEC support in the
 communication with the PMBus chip.
 
@@ -137,69 +144,83 @@ Functions provided by chip driver
 ---------------------------------
 
 All functions return the command return value (read) or zero (write) if
-successful. A return value of -ENODATA indicates that there is no manufacturer
-specific command, but that a standard PMBus command may exist. Any other
-negative return value indicates that the commands does not exist for this
+successful. A return value of ``-ENODATA`` indicates that there is no
+manufacturer-specific command, but that a standard PMBus command may exist. Any
+other negative return value indicates that the command does not exist for this
 chip, and that no attempt should be made to read or write the standard
 command.
 
 As mentioned above, an exception to this rule applies to virtual commands,
-which *must* be handled in driver specific code. See "Virtual PMBus Commands"
+which **must** be handled in driver specific code. See "Virtual PMBus Commands"
 above for more details.
 
-Command execution in the core PMBus driver code is as follows::
+Command execution in the core PMBus driver code is as follows:
+
+.. code-block:: c
 
-	if (chip_access_function) {
-		status = chip_access_function();
-		if (status != -ENODATA)
-			return status;
-	}
-	if (command >= PMBUS_VIRT_BASE)	/* For word commands/registers only */
-		return -EINVAL;
-	return generic_access();
+  if (chip_access_function) {
+          status = chip_access_function();
+          if (status != -ENODATA)
+                  return status;
+  }
+  if (command >= PMBUS_VIRT_BASE) /* For word commands/registers only */
+          return -EINVAL;
+  return generic_access();
 
-Chip drivers may provide pointers to the following functions in struct
-pmbus_driver_info. All functions are optional.
+Chip drivers may provide pointers to the following functions in
+``struct pmbus_driver_info``. All functions are optional.
 
-::
+``read_byte_data()``
+~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
 
   int (*read_byte_data)(struct i2c_client *client, int page, int reg);
 
-Read byte from page <page>, register <reg>.
-<page> may be -1, which means "current page".
+Read byte from page **page**, register **reg**.
+**page** may be ``-1``, which means "current page".
+
+``read_word_data()``
+~~~~~~~~~~~~~~~~~~~~
 
+.. code-block:: c
 
-::
+  int (*read_word_data)(struct i2c_client *client, int page, int phase, int reg);
 
-  int (*read_word_data)(struct i2c_client *client, int page, int phase,
-                        int reg);
+Read word from page **page**, phase **phase**, register **reg**. If the chip
+does not support multiple phases, the **phase** parameter can be ignored. If the
+chip supports multiple phases, a phase value of ``0xff`` indicates all phases.
 
-Read word from page <page>, phase <phase>, register <reg>. If the chip does not
-support multiple phases, the phase parameter can be ignored. If the chip
-supports multiple phases, a phase value of 0xff indicates all phases.
+``write_word_data()``
+~~~~~~~~~~~~~~~~~~~~~
 
-::
+.. code-block:: c
 
-  int (*write_word_data)(struct i2c_client *client, int page, int reg,
-			 u16 word);
+  int (*write_word_data)(struct i2c_client *client, int page, int reg, u16 word);
 
-Write word to page <page>, register <reg>.
+Write word to page **page**, register **reg**.
 
-::
+``write_byte()``
+~~~~~~~~~~~~~~~~
+
+.. code-block:: c
 
   int (*write_byte)(struct i2c_client *client, int page, u8 value);
 
-Write byte to page <page>, register <reg>.
-<page> may be -1, which means "current page".
+Write byte to page **page**, register **reg**.
+**page** may be ``-1``, which means "current page".
+
+``identify()``
+~~~~~~~~~~~~~~
 
-::
+.. code-block:: c
 
   int (*identify)(struct i2c_client *client, struct pmbus_driver_info *info);
 
 Determine supported PMBus functionality. This function is only necessary
 if a chip driver supports multiple chips, and the chip functionality is not
 pre-determined. It is currently only used by the generic pmbus driver
-(pmbus.c).
+(``pmbus.c``).
 
 Functions exported by core driver
 ---------------------------------
@@ -208,119 +229,148 @@ Chip drivers are expected to use the following functions to read or write
 PMBus registers. Chip drivers may also use direct I2C commands. If direct I2C
 commands are used, the chip driver code must not directly modify the current
 page, since the selected page is cached in the core driver and the core driver
-will assume that it is selected. Using pmbus_set_page() to select a new page
-is mandatory.
+will assume that it is selected. Using :c:func:`pmbus_set_page()` to select a
+new page is mandatory.
 
-::
+``pmbus_set_page()``
+~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
 
   int pmbus_set_page(struct i2c_client *client, u8 page, u8 phase);
 
-Set PMBus page register to <page> and <phase> for subsequent commands.
-If the chip does not support multiple phases, the phase parameter is
-ignored. Otherwise, a phase value of 0xff selects all phases.
+Set PMBus page register to **page** and **phase** for subsequent commands.
+If the chip does not support multiple phases, the **phase** parameter is
+ignored. Otherwise, a phase value of ``0xff`` selects all phases.
+
+``pmbus_read_word_data()``
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-::
+.. code-block:: c
 
-  int pmbus_read_word_data(struct i2c_client *client, u8 page, u8 phase,
-                           u8 reg);
+  int pmbus_read_word_data(struct i2c_client *client, u8 page, u8 phase, u8 reg);
 
-Read word data from <page>, <phase>, <reg>. Similar to
+Read word data from **page**, **phase**, **reg**. Similar to
 i2c_smbus_read_word_data(), but selects page and phase first. If the chip does
 not support multiple phases, the phase parameter is ignored. Otherwise, a phase
-value of 0xff selects all phases.
+value of ``0xff`` selects all phases.
 
-::
+``pmbus_write_word_data()``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-  int pmbus_write_word_data(struct i2c_client *client, u8 page, u8 reg,
-			    u16 word);
+.. code-block:: c
 
-Write word data to <page>, <reg>. Similar to i2c_smbus_write_word_data(), but
-selects page first.
+  int pmbus_write_word_data(struct i2c_client *client, u8 page, u8 reg, u16 word);
 
-::
+Write word data to **page**, **reg**. Similar to i2c_smbus_write_word_data(),
+but selects page first.
+
+``pmbus_read_byte_data()``
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
 
   int pmbus_read_byte_data(struct i2c_client *client, int page, u8 reg);
 
-Read byte data from <page>, <reg>. Similar to i2c_smbus_read_byte_data(), but
-selects page first. <page> may be -1, which means "current page".
+Read byte data from **page**, **reg**. Similar to i2c_smbus_read_byte_data(),
+but selects page first. **page** may be ``-1``, which means "current page".
 
-::
+``pmbus_write_byte()``
+~~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
 
   int pmbus_write_byte(struct i2c_client *client, int page, u8 value);
 
-Write byte data to <page>, <reg>. Similar to i2c_smbus_write_byte(), but
-selects page first. <page> may be -1, which means "current page".
+Write byte data to **page**, **reg**. Similar to i2c_smbus_write_byte(), but
+selects page first. **page** may be ``-1``, which means "current page".
+
+``pmbus_clear_faults()``
+~~~~~~~~~~~~~~~~~~~~~~~~
 
-::
+.. code-block:: c
 
   void pmbus_clear_faults(struct i2c_client *client);
 
 Execute PMBus "Clear Fault" command on all chip pages.
 This function calls the device specific write_byte function if defined.
-Therefore, it must _not_ be called from that function.
+Therefore, it **must not** be called from that function.
 
-::
+``pmbus_check_byte_register()``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
 
   bool pmbus_check_byte_register(struct i2c_client *client, int page, int reg);
 
-Check if byte register exists. Return true if the register exists, false
+Check if byte register exists. Return ``true`` if the register exists, ``false``
 otherwise.
 This function calls the device specific write_byte function if defined to
-obtain the chip status. Therefore, it must _not_ be called from that function.
+obtain the chip status. Therefore, it **must not** be called from that function.
+
+``pmbus_check_word_register()``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-::
+.. code-block:: c
 
   bool pmbus_check_word_register(struct i2c_client *client, int page, int reg);
 
-Check if word register exists. Return true if the register exists, false
+Check if word register exists. Return ``true`` if the register exists, ``false``
 otherwise.
 This function calls the device specific write_byte function if defined to
-obtain the chip status. Therefore, it must _not_ be called from that function.
+obtain the chip status. Therefore, it **must not** be called from that function.
 
-::
+``pmbus_do_probe()``
+~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
 
   int pmbus_do_probe(struct i2c_client *client, struct pmbus_driver_info *info);
 
 Execute probe function. Similar to standard probe function for other drivers,
-with the pointer to struct pmbus_driver_info as additional argument. Calls
+with the pointer to ``struct pmbus_driver_info`` as additional argument. Calls
 identify function if supported. Must only be called from device probe
 function.
 
-::
+``pmbus_driver_info()``
+~~~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
 
-  const struct pmbus_driver_info
-	*pmbus_get_driver_info(struct i2c_client *client);
+  const struct pmbus_driver_info *pmbus_get_driver_info(struct i2c_client *client);
 
-Return pointer to struct pmbus_driver_info as passed to pmbus_do_probe().
+Return pointer to ``struct pmbus_driver_info`` as passed to
+:c:func:`pmbus_do_probe()`.
 
 
 PMBus driver platform data
 ==========================
 
-PMBus platform data is defined in include/linux/pmbus.h. Platform data
-currently provides a flags field with four bits used::
+PMBus platform data is defined in ``<linux/pmbus.h>``. Platform data
+currently provides a flags field with four bits used:
 
-	#define PMBUS_SKIP_STATUS_CHECK			BIT(0)
+.. code-block:: c
 
-	#define PMBUS_WRITE_PROTECTED			BIT(1)
+  #define PMBUS_SKIP_STATUS_CHECK                 BIT(0)
 
-	#define PMBUS_NO_CAPABILITY			BIT(2)
+  #define PMBUS_WRITE_PROTECTED                   BIT(1)
 
-	#define PMBUS_READ_STATUS_AFTER_FAILED_CHECK	BIT(3)
+  #define PMBUS_NO_CAPABILITY                     BIT(2)
 
-	struct pmbus_platform_data {
-		u32 flags;              /* Device specific flags */
+  #define PMBUS_READ_STATUS_AFTER_FAILED_CHECK    BIT(3)
 
-		/* regulator support */
-		int num_regulators;
-		struct regulator_init_data *reg_init_data;
-	};
+  struct pmbus_platform_data {
+          u32 flags;              /* Device specific flags */
 
+          /* regulator support */
+          int num_regulators;
+          struct regulator_init_data *reg_init_data;
+  };
 
 Flags
 -----
 
-PMBUS_SKIP_STATUS_CHECK
+``PMBUS_SKIP_STATUS_CHECK``
 
 During register detection, skip checking the status register for
 communication or command errors.
@@ -328,33 +378,33 @@ communication or command errors.
 Some PMBus chips respond with valid data when trying to read an unsupported
 register. For such chips, checking the status register is mandatory when
 trying to determine if a chip register exists or not.
-Other PMBus chips don't support the STATUS_CML register, or report
+Other PMBus chips don't support the ``STATUS_CML`` register, or report
 communication errors for no explicable reason. For such chips, checking the
 status register must be disabled.
 
 Some i2c controllers do not support single-byte commands (write commands with
 no data, i2c_smbus_write_byte()). With such controllers, clearing the status
-register is impossible, and the PMBUS_SKIP_STATUS_CHECK flag must be set.
+register is impossible, and the ``PMBUS_SKIP_STATUS_CHECK`` flag must be set.
 
-PMBUS_WRITE_PROTECTED
+``PMBUS_WRITE_PROTECTED``
 
 Set if the chip is write protected and write protection is not determined
-by the standard WRITE_PROTECT command.
+by the standard ``WRITE_PROTECT`` command.
 
-PMBUS_NO_CAPABILITY
+``PMBUS_NO_CAPABILITY``
 
-Some PMBus chips don't respond with valid data when reading the CAPABILITY
+Some PMBus chips don't respond with valid data when reading the ``CAPABILITY``
 register. For such chips, this flag should be set so that the PMBus core
-driver doesn't use CAPABILITY to determine it's behavior.
+driver doesn't use ``CAPABILITY`` to determine it's behavior.
 
-PMBUS_READ_STATUS_AFTER_FAILED_CHECK
+``PMBUS_READ_STATUS_AFTER_FAILED_CHECK``
 
-Read the STATUS register after each failed register check.
+Read the ``STATUS`` register after each failed register check.
 
 Some PMBus chips end up in an undefined state when trying to read an
 unsupported register. For such chips, it is necessary to reset the
-chip pmbus controller to a known state after a failed register check.
+chip PMBus controller to a known state after a failed register check.
 This can be done by reading a known register. By setting this flag the
-driver will try to read the STATUS register after each failed
+driver will try to read the ``STATUS`` register after each failed
 register check. This read may fail, but it will put the chip into a
 known state.
-- 
2.34.1

