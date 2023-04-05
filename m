Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADE66D7E6E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbjDEODN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjDEOCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:02:08 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6046A60;
        Wed,  5 Apr 2023 07:01:12 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 0a9710086bac5137; Wed, 5 Apr 2023 16:01:09 +0200
Received: from kreacher.localnet (unknown [213.134.163.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 2172C1B4EA4C;
        Wed,  5 Apr 2023 16:01:09 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 13/32] ACPICA: Avoid undefined behavior: applying zero offset to null pointer
Date:   Wed, 05 Apr 2023 15:42:43 +0200
Message-ID: <2580576.Lt9SDvczpP@kreacher>
In-Reply-To: <4845957.31r3eYUQgx@kreacher>
References: <4845957.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.219
X-CLIENT-HOSTNAME: 213.134.163.219
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepleduvdfhudehvddukeetffdtffejkedttefgveeftdeuvedvleelgeeiteelueelnecuffhomhgrihhnpegrshgrnhdrshhopdhgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudeifedrvdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieefrddvudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS,
        WEIRD_PORT autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tamir Duberstein <tamird@google.com>

ACPICA commit 770653e3ba67c30a629ca7d12e352d83c2541b1e

Before this change we see the following UBSAN stack trace in Fuchsia:

  #0    0x000021e4213b3302 in acpi_ds_init_aml_walk(struct acpi_walk_state*, union acpi_parse_object*, struct acpi_namespace_node*, u8*, u32, struct acpi_evaluate_info*, u8) ../../third_party/acpica/source/components/dispatcher/dswstate.c:682 <platform-bus-x86.so>+0x233302
  #1.2  0x000020d0f660777f in ubsan_get_stack_trace() compiler-rt/lib/ubsan/ubsan_diag.cpp:41 <libclang_rt.asan.so>+0x3d77f
  #1.1  0x000020d0f660777f in maybe_print_stack_trace() compiler-rt/lib/ubsan/ubsan_diag.cpp:51 <libclang_rt.asan.so>+0x3d77f
  #1    0x000020d0f660777f in ~scoped_report() compiler-rt/lib/ubsan/ubsan_diag.cpp:387 <libclang_rt.asan.so>+0x3d77f
  #2    0x000020d0f660b96d in handlepointer_overflow_impl() compiler-rt/lib/ubsan/ubsan_handlers.cpp:809 <libclang_rt.asan.so>+0x4196d
  #3    0x000020d0f660b50d in compiler-rt/lib/ubsan/ubsan_handlers.cpp:815 <libclang_rt.asan.so>+0x4150d
  #4    0x000021e4213b3302 in acpi_ds_init_aml_walk(struct acpi_walk_state*, union acpi_parse_object*, struct acpi_namespace_node*, u8*, u32, struct acpi_evaluate_info*, u8) ../../third_party/acpica/source/components/dispatcher/dswstate.c:682 <platform-bus-x86.so>+0x233302
  #5    0x000021e4213e2369 in acpi_ds_call_control_method(struct acpi_thread_state*, struct acpi_walk_state*, union acpi_parse_object*) ../../third_party/acpica/source/components/dispatcher/dsmethod.c:605 <platform-bus-x86.so>+0x262369
  #6    0x000021e421437fac in acpi_ps_parse_aml(struct acpi_walk_state*) ../../third_party/acpica/source/components/parser/psparse.c:550 <platform-bus-x86.so>+0x2b7fac
  #7    0x000021e4214464d2 in acpi_ps_execute_method(struct acpi_evaluate_info*) ../../third_party/acpica/source/components/parser/psxface.c:244 <platform-bus-x86.so>+0x2c64d2
  #8    0x000021e4213aa052 in acpi_ns_evaluate(struct acpi_evaluate_info*) ../../third_party/acpica/source/components/namespace/nseval.c:250 <platform-bus-x86.so>+0x22a052
  #9    0x000021e421413dd8 in acpi_ns_init_one_device(acpi_handle, u32, void*, void**) ../../third_party/acpica/source/components/namespace/nsinit.c:735 <platform-bus-x86.so>+0x293dd8
  #10   0x000021e421429e98 in acpi_ns_walk_namespace(acpi_object_type, acpi_handle, u32, u32, acpi_walk_callback, acpi_walk_callback, void*, void**) ../../third_party/acpica/source/components/namespace/nswalk.c:298 <platform-bus-x86.so>+0x2a9e98
  #11   0x000021e4214131ac in acpi_ns_initialize_devices(u32) ../../third_party/acpica/source/components/namespace/nsinit.c:268 <platform-bus-x86.so>+0x2931ac
  #12   0x000021e42147c40d in acpi_initialize_objects(u32) ../../third_party/acpica/source/components/utilities/utxfinit.c:304 <platform-bus-x86.so>+0x2fc40d
  #13   0x000021e42126d603 in acpi::acpi_impl::initialize_acpi(acpi::acpi_impl*) ../../src/devices/board/lib/acpi/acpi-impl.cc:224 <platform-bus-x86.so>+0xed603

Add a simple check that avoids incrementing a pointer by zero, but
otherwise behaves as before. Note that our findings are against ACPICA
20221020, but the same code exists on master.

Link: https://github.com/acpica/acpica/commit/770653e3
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/dswstate.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstate.c
index 95af370a7dce..d3841ded3a81 100644
--- a/drivers/acpi/acpica/dswstate.c
+++ b/drivers/acpi/acpica/dswstate.c
@@ -576,9 +576,14 @@ acpi_ds_init_aml_walk(struct acpi_walk_state *walk_state,
 	ACPI_FUNCTION_TRACE(ds_init_aml_walk);
 
 	walk_state->parser_state.aml =
-	    walk_state->parser_state.aml_start = aml_start;
-	walk_state->parser_state.aml_end =
-	    walk_state->parser_state.pkg_end = aml_start + aml_length;
+	    walk_state->parser_state.aml_start =
+	    walk_state->parser_state.aml_end =
+	    walk_state->parser_state.pkg_end = aml_start;
+	/* Avoid undefined behavior: applying zero offset to null pointer */
+	if (aml_length != 0) {
+		walk_state->parser_state.aml_end += aml_length;
+		walk_state->parser_state.pkg_end += aml_length;
+	}
 
 	/* The next_op of the next_walk will be the beginning of the method */
 
-- 
2.35.3





