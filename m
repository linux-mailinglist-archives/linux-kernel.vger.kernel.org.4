Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFB860FFA8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 19:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbiJ0R7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 13:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbiJ0R7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:59:12 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CFC17D29B;
        Thu, 27 Oct 2022 10:59:11 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 1adc8de0c868de06; Thu, 27 Oct 2022 19:59:09 +0200
Received: from kreacher.localnet (unknown [213.134.169.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 84ED566D838;
        Thu, 27 Oct 2022 19:59:08 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 07/11] ACPICA: Add support for FFH Opregion special context data
Date:   Thu, 27 Oct 2022 19:54:32 +0200
Message-ID: <3135123.5fSG56mABF@kreacher>
In-Reply-To: <4756726.GXAFRqVoOG@kreacher>
References: <4756726.GXAFRqVoOG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.169.45
X-CLIENT-HOSTNAME: 213.134.169.45
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeggdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepueetieelhfeufefgffetiefhudduveejfefhjeefvdelueehkeeltddttedvuedvnecuffhomhgrihhnpehtihgrnhhotghorhgvrdhorhhgpdhgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudeiledrgeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeiledrgeehpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

ACPICA commit fad527b6e76babc7527c41325bfbef6bd1a1132b

FFH(Fixed Function Hardware) Opregion is approved to be added in ACPI 6.5 via
code first approach [1]. It requires special context data similar to GPIO and
Generic Serial Bus as it needs to know platform specific offset and length.

Add support for the special context data needed by FFH Opregion.

FFH op_region enables advanced use of FFH on some architectures. For example,
it could be used to easily proxy AML code to architecture-specific behavior
(to ensure it is OS initiated)

Actual behavior of FFH is ofcourse architecture specific and depends on
the FFH bindings. The offset and length could have arch specific meaning
or usage.

Link: https://bugzilla.tianocore.org/show_bug.cgi?id=3598 # [1]
Link: https://github.com/acpica/acpica/commit/fad527b6
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/evregion.c |    9 +++++++++
 drivers/acpi/acpica/exfield.c  |    8 ++++++--
 drivers/acpi/acpica/exserial.c |    6 ++++++
 include/acpi/acconfig.h        |    2 ++
 include/acpi/actypes.h         |    7 +++++++
 5 files changed, 30 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/acpica/evregion.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evregion.c
+++ linux-pm/drivers/acpi/acpica/evregion.c
@@ -172,6 +172,15 @@ acpi_ev_address_space_dispatch(union acp
 			ctx->subspace_id = (u8)region_obj->region.address;
 		}
 
+		if (region_obj->region.space_id ==
+		    ACPI_ADR_SPACE_FIXED_HARDWARE) {
+			struct acpi_ffh_info *ctx =
+			    handler_desc->address_space.context;
+
+			ctx->length = region_obj->region.length;
+			ctx->offset = region_obj->region.address;
+		}
+
 		/*
 		 * We must exit the interpreter because the region setup will
 		 * potentially execute control methods (for example, the _REG method
Index: linux-pm/drivers/acpi/acpica/exfield.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exfield.c
+++ linux-pm/drivers/acpi/acpica/exfield.c
@@ -141,7 +141,9 @@ acpi_ex_read_data_from_field(struct acpi
 		    || obj_desc->field.region_obj->region.space_id ==
 		    ACPI_ADR_SPACE_IPMI
 		    || obj_desc->field.region_obj->region.space_id ==
-		    ACPI_ADR_SPACE_PLATFORM_RT)) {
+		    ACPI_ADR_SPACE_PLATFORM_RT
+		    || obj_desc->field.region_obj->region.space_id ==
+		    ACPI_ADR_SPACE_FIXED_HARDWARE)) {
 
 		/* SMBus, GSBus, IPMI serial */
 
@@ -305,7 +307,9 @@ acpi_ex_write_data_to_field(union acpi_o
 		    || obj_desc->field.region_obj->region.space_id ==
 		    ACPI_ADR_SPACE_IPMI
 		    || obj_desc->field.region_obj->region.space_id ==
-		    ACPI_ADR_SPACE_PLATFORM_RT)) {
+		    ACPI_ADR_SPACE_PLATFORM_RT
+		    || obj_desc->field.region_obj->region.space_id ==
+		    ACPI_ADR_SPACE_FIXED_HARDWARE)) {
 
 		/* SMBus, GSBus, IPMI serial */
 
Index: linux-pm/drivers/acpi/acpica/exserial.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exserial.c
+++ linux-pm/drivers/acpi/acpica/exserial.c
@@ -323,6 +323,12 @@ acpi_ex_write_serial_bus(union acpi_oper
 		function = ACPI_WRITE;
 		break;
 
+	case ACPI_ADR_SPACE_FIXED_HARDWARE:
+
+		buffer_length = ACPI_FFH_INPUT_BUFFER_SIZE;
+		function = ACPI_WRITE;
+		break;
+
 	default:
 		return_ACPI_STATUS(AE_AML_INVALID_SPACE_ID);
 	}
Index: linux-pm/include/acpi/acconfig.h
===================================================================
--- linux-pm.orig/include/acpi/acconfig.h
+++ linux-pm/include/acpi/acconfig.h
@@ -190,6 +190,8 @@
 
 #define ACPI_PRM_INPUT_BUFFER_SIZE      26
 
+#define ACPI_FFH_INPUT_BUFFER_SIZE      256
+
 /* _sx_d and _sx_w control methods */
 
 #define ACPI_NUM_sx_d_METHODS           4
Index: linux-pm/include/acpi/actypes.h
===================================================================
--- linux-pm.orig/include/acpi/actypes.h
+++ linux-pm/include/acpi/actypes.h
@@ -1116,6 +1116,13 @@ struct acpi_pcc_info {
 	u8 *internal_buffer;
 };
 
+/* Special Context data for FFH Opregion (ACPI 6.5) */
+
+struct acpi_ffh_info {
+	u64 offset;
+	u64 length;
+};
+
 typedef
 acpi_status (*acpi_adr_space_setup) (acpi_handle region_handle,
 				     u32 function,



