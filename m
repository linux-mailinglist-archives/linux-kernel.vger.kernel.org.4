Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F216D7E76
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238415AbjDEODm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbjDEOCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:02:39 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387BC6E9B;
        Wed,  5 Apr 2023 07:01:24 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 9ea673bad7a70f96; Wed, 5 Apr 2023 16:01:16 +0200
Received: from kreacher.localnet (unknown [213.134.163.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 3A03C1B4EA6F;
        Wed,  5 Apr 2023 16:01:15 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 09/32] ACPICA: add support for ClockInput resource (v6.5)
Date:   Wed, 05 Apr 2023 15:39:23 +0200
Message-ID: <3183480.5fSG56mABF@kreacher>
In-Reply-To: <4845957.31r3eYUQgx@kreacher>
References: <4845957.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.219
X-CLIENT-HOSTNAME: 213.134.163.219
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudeifedrvdduleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieefrddvudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niyas Sait <niyas.sait@linaro.org>

ACPICA commit 661feab5ee01a34af95a389a18c82e79f1aba05a

Link: https://github.com/acpica/acpica/commit/661feab5
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/aclocal.h     |  3 +-
 drivers/acpi/acpica/acresrc.h     |  2 ++
 drivers/acpi/acpica/acutils.h     |  2 ++
 drivers/acpi/acpica/amlresrc.h    | 17 +++++++++++
 drivers/acpi/acpica/rscalc.c      | 17 +++++++++++
 drivers/acpi/acpica/rsdumpinfo.c  | 17 +++++++++++
 drivers/acpi/acpica/rsinfo.c      |  5 ++++
 drivers/acpi/acpica/rsserial.c    | 49 +++++++++++++++++++++++++++++++
 drivers/acpi/acpica/utresdecode.c | 11 +++++++
 drivers/acpi/acpica/utresrc.c     |  3 ++
 include/acpi/acrestyp.h           | 13 +++++++-
 11 files changed, 137 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 2b876dac7558..12d4a024f029 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -1122,7 +1122,8 @@ struct acpi_port_info {
 #define ACPI_RESOURCE_NAME_PIN_GROUP            0x90
 #define ACPI_RESOURCE_NAME_PIN_GROUP_FUNCTION   0x91
 #define ACPI_RESOURCE_NAME_PIN_GROUP_CONFIG     0x92
-#define ACPI_RESOURCE_NAME_LARGE_MAX            0x92
+#define ACPI_RESOURCE_NAME_CLOCK_INPUT          0x93
+#define ACPI_RESOURCE_NAME_LARGE_MAX            0x94
 
 /*****************************************************************************
  *
diff --git a/drivers/acpi/acpica/acresrc.h b/drivers/acpi/acpica/acresrc.h
index c2e6c8455587..d772ff9ca07d 100644
--- a/drivers/acpi/acpica/acresrc.h
+++ b/drivers/acpi/acpica/acresrc.h
@@ -306,6 +306,7 @@ extern struct acpi_rsconvert_info acpi_rs_convert_pin_config[];
 extern struct acpi_rsconvert_info acpi_rs_convert_pin_group[];
 extern struct acpi_rsconvert_info acpi_rs_convert_pin_group_function[];
 extern struct acpi_rsconvert_info acpi_rs_convert_pin_group_config[];
+extern struct acpi_rsconvert_info acpi_rs_convert_clock_input[];
 
 /* These resources require separate get/set tables */
 
@@ -361,6 +362,7 @@ extern struct acpi_rsdump_info acpi_rs_dump_pin_config[];
 extern struct acpi_rsdump_info acpi_rs_dump_pin_group[];
 extern struct acpi_rsdump_info acpi_rs_dump_pin_group_function[];
 extern struct acpi_rsdump_info acpi_rs_dump_pin_group_config[];
+extern struct acpi_rsdump_info acpi_rs_dump_clock_input[];
 #endif
 
 #endif				/* __ACRESRC_H__ */
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index dd060844189e..edfdbbef81c1 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -53,6 +53,8 @@ extern const char *acpi_gbl_sb_decode[];
 extern const char *acpi_gbl_fc_decode[];
 extern const char *acpi_gbl_pt_decode[];
 extern const char *acpi_gbl_ptyp_decode[];
+extern const char *acpi_gbl_clock_input_mode[];
+extern const char *acpi_gbl_clock_input_scale[];
 #endif
 
 /*
diff --git a/drivers/acpi/acpica/amlresrc.h b/drivers/acpi/acpica/amlresrc.h
index 89093111bfd2..48df447ef5bb 100644
--- a/drivers/acpi/acpica/amlresrc.h
+++ b/drivers/acpi/acpica/amlresrc.h
@@ -70,6 +70,8 @@
 #define ACPI_RESTAG_TYPE                        "_TTP"	/* Translation(1), Static (0) */
 #define ACPI_RESTAG_XFERTYPE                    "_SIZ"	/* 8(0), 8And16(1), 16(2) */
 #define ACPI_RESTAG_VENDORDATA                  "_VEN"
+#define ACPI_RESTAG_FQN                         "_FQN"
+#define ACPI_RESTAG_FQD                         "_FQD"
 
 /* Default sizes for "small" resource descriptors */
 
@@ -427,6 +429,20 @@ struct aml_resource_pin_config {
 	 */
 };
 
+#define AML_RESOURCE_CLOCK_INPUT_REVISION      1	/* ACPI 6.5 */
+
+struct aml_resource_clock_input {
+	AML_RESOURCE_LARGE_HEADER_COMMON u8 revision_id;
+	u16 flags;
+	u16 frequency_divisor;
+	u32 frequency_numerator;
+	/*
+	 * Optional fields follow immediately:
+	 * 1) Resource Source index
+	 * 2) Resource Source String
+	 */
+};
+
 #define AML_RESOURCE_PIN_CONFIG_REVISION      1	/* ACPI 6.2 */
 
 struct aml_resource_pin_group {
@@ -533,6 +549,7 @@ union aml_resource {
 	struct aml_resource_pin_group pin_group;
 	struct aml_resource_pin_group_function pin_group_function;
 	struct aml_resource_pin_group_config pin_group_config;
+	struct aml_resource_clock_input clock_input;
 
 	/* Utility overlays */
 
diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index 90583db459a2..ffb448fa51fd 100644
--- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -320,6 +320,16 @@ acpi_rs_get_aml_length(struct acpi_resource *resource,
 
 			break;
 
+		case ACPI_RESOURCE_TYPE_CLOCK_INPUT:
+
+			total_size = (acpi_rs_length)(total_size +
+						      resource->data.
+						      clock_input.
+						      resource_source.
+						      string_length);
+
+			break;
+
 		case ACPI_RESOURCE_TYPE_SERIAL_BUS:
 
 			total_size =
@@ -650,6 +660,13 @@ acpi_rs_get_list_length(u8 *aml_buffer,
 
 			break;
 
+		case ACPI_RESOURCE_NAME_CLOCK_INPUT:
+			extra_struct_bytes =
+			    acpi_rs_stream_option_length(resource_length,
+							 minimum_aml_resource_length);
+
+			break;
+
 		default:
 
 			break;
diff --git a/drivers/acpi/acpica/rsdumpinfo.c b/drivers/acpi/acpica/rsdumpinfo.c
index b8b37449011b..998a79cc09c2 100644
--- a/drivers/acpi/acpica/rsdumpinfo.c
+++ b/drivers/acpi/acpica/rsdumpinfo.c
@@ -301,6 +301,23 @@ struct acpi_rsdump_info acpi_rs_dump_pin_function[10] = {
 	 "VendorData", NULL},
 };
 
+struct acpi_rsdump_info acpi_rs_dump_clock_input[7] = {
+	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_clock_input),
+	 "ClockInput", NULL},
+	{ACPI_RSD_UINT8, ACPI_RSD_OFFSET(clock_input.revision_id), "RevisionId",
+	 NULL},
+	{ACPI_RSD_UINT32, ACPI_RSD_OFFSET(clock_input.frequency_numerator),
+	 "FrequencyNumerator", NULL},
+	{ACPI_RSD_UINT32, ACPI_RSD_OFFSET(clock_input.frequency_divisor),
+	 "FrequencyDivisor", NULL},
+	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(clock_input.scale), "Scale",
+	 acpi_gbl_clock_input_scale},
+	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(clock_input.mode), "Mode",
+	 acpi_gbl_clock_input_mode},
+	{ACPI_RSD_SOURCE, ACPI_RSD_OFFSET(clock_input.resource_source),
+	 "ResourceSource", NULL},
+};
+
 struct acpi_rsdump_info acpi_rs_dump_pin_config[11] = {
 	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_pin_config),
 	 "PinConfig", NULL},
diff --git a/drivers/acpi/acpica/rsinfo.c b/drivers/acpi/acpica/rsinfo.c
index eaeb7ab58c2a..ad7465ddfe13 100644
--- a/drivers/acpi/acpica/rsinfo.c
+++ b/drivers/acpi/acpica/rsinfo.c
@@ -49,6 +49,7 @@ struct acpi_rsconvert_info *acpi_gbl_set_resource_dispatch[] = {
 	acpi_rs_convert_pin_group,	/* 0x16, ACPI_RESOURCE_TYPE_PIN_GROUP */
 	acpi_rs_convert_pin_group_function,	/* 0x17, ACPI_RESOURCE_TYPE_PIN_GROUP_FUNCTION */
 	acpi_rs_convert_pin_group_config,	/* 0x18, ACPI_RESOURCE_TYPE_PIN_GROUP_CONFIG */
+	acpi_rs_convert_clock_input,	/* 0x19, ACPI_RESOURCE_TYPE_CLOCK_INPUT */
 };
 
 /* Dispatch tables for AML-to-resource (Get Resource) conversion functions */
@@ -94,6 +95,7 @@ struct acpi_rsconvert_info *acpi_gbl_get_resource_dispatch[] = {
 	acpi_rs_convert_pin_group,	/* 0x10, ACPI_RESOURCE_NAME_PIN_GROUP */
 	acpi_rs_convert_pin_group_function,	/* 0x11, ACPI_RESOURCE_NAME_PIN_GROUP_FUNCTION */
 	acpi_rs_convert_pin_group_config,	/* 0x12, ACPI_RESOURCE_NAME_PIN_GROUP_CONFIG */
+	acpi_rs_convert_clock_input,	/* 0x13, ACPI_RESOURCE_NAME_CLOCK_INPUT */
 };
 
 /* Subtype table for serial_bus -- I2C, SPI, UART, and CSI2 */
@@ -136,6 +138,7 @@ struct acpi_rsdump_info *acpi_gbl_dump_resource_dispatch[] = {
 	acpi_rs_dump_pin_group,	/* ACPI_RESOURCE_TYPE_PIN_GROUP */
 	acpi_rs_dump_pin_group_function,	/* ACPI_RESOURCE_TYPE_PIN_GROUP_FUNCTION */
 	acpi_rs_dump_pin_group_config,	/* ACPI_RESOURCE_TYPE_PIN_GROUP_CONFIG */
+	acpi_rs_dump_clock_input,	/* ACPI_RESOURCE_TYPE_CLOCK_INPUT */
 };
 
 struct acpi_rsdump_info *acpi_gbl_dump_serial_bus_dispatch[] = {
@@ -178,6 +181,7 @@ const u8 acpi_gbl_aml_resource_sizes[] = {
 	sizeof(struct aml_resource_pin_group),	/* ACPI_RESOURCE_TYPE_PIN_GROUP */
 	sizeof(struct aml_resource_pin_group_function),	/* ACPI_RESOURCE_TYPE_PIN_GROUP_FUNCTION */
 	sizeof(struct aml_resource_pin_group_config),	/* ACPI_RESOURCE_TYPE_PIN_GROUP_CONFIG */
+	sizeof(struct aml_resource_clock_input),	/* ACPI_RESOURCE_TYPE_CLOCK_INPUT */
 };
 
 const u8 acpi_gbl_resource_struct_sizes[] = {
@@ -221,6 +225,7 @@ const u8 acpi_gbl_resource_struct_sizes[] = {
 	ACPI_RS_SIZE(struct acpi_resource_pin_group),
 	ACPI_RS_SIZE(struct acpi_resource_pin_group_function),
 	ACPI_RS_SIZE(struct acpi_resource_pin_group_config),
+	ACPI_RS_SIZE(struct acpi_resource_clock_input),
 };
 
 const u8 acpi_gbl_aml_resource_serial_bus_sizes[] = {
diff --git a/drivers/acpi/acpica/rsserial.c b/drivers/acpi/acpica/rsserial.c
index f9267956535c..279bfa27da94 100644
--- a/drivers/acpi/acpica/rsserial.c
+++ b/drivers/acpi/acpica/rsserial.c
@@ -109,6 +109,55 @@ struct acpi_rsconvert_info acpi_rs_convert_gpio[18] = {
 	 0},
 };
 
+/*******************************************************************************
+ *
+ * acpi_rs_convert_clock_input
+ *
+ ******************************************************************************/
+
+struct acpi_rsconvert_info acpi_rs_convert_clock_input[8] = {
+	{ACPI_RSC_INITGET, ACPI_RESOURCE_TYPE_CLOCK_INPUT,
+	 ACPI_RS_SIZE(struct acpi_resource_clock_input),
+	 ACPI_RSC_TABLE_SIZE(acpi_rs_convert_clock_input)},
+
+	{ACPI_RSC_INITSET, ACPI_RESOURCE_NAME_CLOCK_INPUT,
+	 sizeof(struct aml_resource_clock_input),
+	 0}
+	,
+
+	{ACPI_RSC_MOVE8, ACPI_RS_OFFSET(data.clock_input.revision_id),
+	 AML_OFFSET(clock_input.revision_id),
+	 1}
+	,
+
+	{ACPI_RSC_1BITFLAG, ACPI_RS_OFFSET(data.clock_input.mode),
+	 AML_OFFSET(clock_input.flags),
+	 0}
+	,
+
+	{ACPI_RSC_2BITFLAG, ACPI_RS_OFFSET(data.clock_input.scale),
+	 AML_OFFSET(clock_input.flags),
+	 1}
+	,
+
+	{ACPI_RSC_MOVE16, ACPI_RS_OFFSET(data.clock_input.frequency_divisor),
+	 AML_OFFSET(clock_input.frequency_divisor),
+	 2}
+	,
+
+	{ACPI_RSC_MOVE32, ACPI_RS_OFFSET(data.clock_input.frequency_numerator),
+	 AML_OFFSET(clock_input.frequency_numerator),
+	 4}
+	,
+
+	/* Resource Source */
+	{ACPI_RSC_SOURCE, ACPI_RS_OFFSET(data.clock_input.resource_source),
+	 0,
+	 sizeof(struct aml_resource_clock_input)}
+	,
+
+};
+
 /*******************************************************************************
  *
  * acpi_rs_convert_pinfunction
diff --git a/drivers/acpi/acpica/utresdecode.c b/drivers/acpi/acpica/utresdecode.c
index 85730fcd7d00..d801d9069841 100644
--- a/drivers/acpi/acpica/utresdecode.c
+++ b/drivers/acpi/acpica/utresdecode.c
@@ -284,4 +284,15 @@ const char *acpi_gbl_ptyp_decode[] = {
 	"Input Schmitt Trigger",
 };
 
+const char *acpi_gbl_clock_input_mode[] = {
+	"Fixed",
+	"Variable",
+};
+
+const char *acpi_gbl_clock_input_scale[] = {
+	"Hz",
+	"KHz",
+	"MHz",
+};
+
 #endif
diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index 16f9a7035b39..e1cc3d348750 100644
--- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -57,6 +57,8 @@ const u8 acpi_gbl_resource_aml_sizes[] = {
 	ACPI_AML_SIZE_LARGE(struct aml_resource_pin_group),
 	ACPI_AML_SIZE_LARGE(struct aml_resource_pin_group_function),
 	ACPI_AML_SIZE_LARGE(struct aml_resource_pin_group_config),
+	ACPI_AML_SIZE_LARGE(struct aml_resource_clock_input),
+
 };
 
 const u8 acpi_gbl_resource_aml_serial_bus_sizes[] = {
@@ -114,6 +116,7 @@ static const u8 acpi_gbl_resource_types[] = {
 	ACPI_VARIABLE_LENGTH,	/* 10 pin_group */
 	ACPI_VARIABLE_LENGTH,	/* 11 pin_group_function */
 	ACPI_VARIABLE_LENGTH,	/* 12 pin_group_config */
+	ACPI_VARIABLE_LENGTH,	/* 13 clock_input */
 };
 
 /*******************************************************************************
diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
index e5c875f91203..f913983ef55e 100644
--- a/include/acpi/acrestyp.h
+++ b/include/acpi/acrestyp.h
@@ -536,6 +536,15 @@ struct acpi_resource_pin_config {
 	u8 *vendor_data;
 };
 
+struct acpi_resource_clock_input {
+	u8 revision_id;
+	u8 mode;
+	u8 scale;
+	u16 frequency_divisor;
+	u32 frequency_numerator;
+	struct acpi_resource_source resource_source;
+};
+
 /* Values for pin_config_type field above */
 
 #define ACPI_PIN_CONFIG_DEFAULT                 0
@@ -613,7 +622,8 @@ struct acpi_resource_pin_group_config {
 #define ACPI_RESOURCE_TYPE_PIN_GROUP            22	/* ACPI 6.2 */
 #define ACPI_RESOURCE_TYPE_PIN_GROUP_FUNCTION   23	/* ACPI 6.2 */
 #define ACPI_RESOURCE_TYPE_PIN_GROUP_CONFIG     24	/* ACPI 6.2 */
-#define ACPI_RESOURCE_TYPE_MAX                  24
+#define ACPI_RESOURCE_TYPE_CLOCK_INPUT          25	/* ACPI 6.5 */
+#define ACPI_RESOURCE_TYPE_MAX                  25
 
 /* Master union for resource descriptors */
 
@@ -647,6 +657,7 @@ union acpi_resource_data {
 	struct acpi_resource_pin_group pin_group;
 	struct acpi_resource_pin_group_function pin_group_function;
 	struct acpi_resource_pin_group_config pin_group_config;
+	struct acpi_resource_clock_input clock_input;
 
 	/* Common fields */
 
-- 
2.35.3





