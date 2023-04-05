Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A890B6D7E67
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238353AbjDEOCl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Apr 2023 10:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237998AbjDEOBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:01:51 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144136A6B;
        Wed,  5 Apr 2023 07:01:06 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 760e9e0b5e635999; Wed, 5 Apr 2023 16:01:05 +0200
Received: from kreacher.localnet (unknown [213.134.163.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 9A4891B4E9E1;
        Wed,  5 Apr 2023 16:01:04 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 16/32] ACPICA: Avoid undefined behavior: member access within misaligned address
Date:   Wed, 05 Apr 2023 15:44:55 +0200
Message-ID: <1849135.atdPhlSkOF@kreacher>
In-Reply-To: <4845957.31r3eYUQgx@kreacher>
References: <4845957.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.219
X-CLIENT-HOSTNAME: 213.134.163.219
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeetteevgfelhfefveeutefhudekleejgfeviedufefgleeuteeftedvieelleeinecuffhomhgrihhnpegrshgrnhdrshhopdhgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudeifedrvdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieefrddvudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=1.7 required=5.0 tests=SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK,WEIRD_PORT autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tamir Duberstein <tamird@google.com>

ACPICA commit 7b23bdc37432f0b7fb6c3b6aa76debdcb7eb18c3

Before this change we see the following UBSAN stack trace in Fuchsia:

  #0    0x00002132da6299a1 in acpi_ut_validate_resource(struct acpi_walk_state*, void*, u8*) ../../third_party/acpica/source/components/utilities/utresrc.c:426 <platform-bus-x86.so>+0x2f79a1
  #1.2  0x000023e6cd58577f in ubsan_get_stack_trace() compiler-rt/lib/ubsan/ubsan_diag.cpp:41 <libclang_rt.asan.so>+0x3d77f
  #1.1  0x000023e6cd58577f in maybe_print_stack_trace() compiler-rt/lib/ubsan/ubsan_diag.cpp:51 <libclang_rt.asan.so>+0x3d77f
  #1    0x000023e6cd58577f in ~scoped_report() compiler-rt/lib/ubsan/ubsan_diag.cpp:387 <libclang_rt.asan.so>+0x3d77f
  #2    0x000023e6cd586385 in handletype_mismatch_impl() compiler-rt/lib/ubsan/ubsan_handlers.cpp:137 <libclang_rt.asan.so>+0x3e385
  #3    0x000023e6cd585ead in compiler-rt/lib/ubsan/ubsan_handlers.cpp:142 <libclang_rt.asan.so>+0x3dead
  #4    0x00002132da6299a1 in acpi_ut_validate_resource(struct acpi_walk_state*, void*, u8*) ../../third_party/acpica/source/components/utilities/utresrc.c:426 <platform-bus-x86.so>+0x2f79a1
  #5    0x00002132da628ffe in acpi_ut_walk_aml_resources(struct acpi_walk_state*, u8*, acpi_size, acpi_walk_aml_callback, void**) ../../third_party/acpica/source/components/utilities/utresrc.c:216 <platform-bus-x86.so>+0x2f6ffe
  #6    0x00002132da5b2405 in acpi_ex_concat_template(union acpi_operand_object*, union acpi_operand_object*, union acpi_operand_object**, struct acpi_walk_state*) ../../third_party/acpica/source/components/executer/exconcat.c:414 <platform-bus-x86.so>+0x280405
  #7    0x00002132da5ad5a4 in acpi_ex_opcode_2A_1T_1R(struct acpi_walk_state*) ../../third_party/acpica/source/components/executer/exoparg2.c:383 <platform-bus-x86.so>+0x27b5a4
  #8    0x00002132da57ee7d in acpi_ds_exec_end_op(struct acpi_walk_state*) ../../third_party/acpica/source/components/dispatcher/dswexec.c:482 <platform-bus-x86.so>+0x24ce7d
  #9    0x00002132da5ed196 in acpi_ps_parse_loop(struct acpi_walk_state*) ../../third_party/acpica/source/components/parser/psloop.c:554 <platform-bus-x86.so>+0x2bb196
  #10   0x00002132da5ea458 in acpi_ps_parse_aml(struct acpi_walk_state*) ../../third_party/acpica/source/components/parser/psparse.c:525 <platform-bus-x86.so>+0x2b8458
  #11   0x00002132da5f8a92 in acpi_ps_execute_method(struct acpi_evaluate_info*) ../../third_party/acpica/source/components/parser/psxface.c:244 <platform-bus-x86.so>+0x2c6a92
  #12   0x00002132da55c2b2 in acpi_ns_evaluate(struct acpi_evaluate_info*) ../../third_party/acpica/source/components/namespace/nseval.c:250 <platform-bus-x86.so>+0x22a2b2
  #13   0x00002132da61fd45 in acpi_ut_evaluate_object(struct acpi_namespace_node*, const char*, u32, union acpi_operand_object**) ../../third_party/acpica/source/components/utilities/uteval.c:100 <platform-bus-x86.so>+0x2edd45
  #14   0x00002132da606197 in acpi_rs_get_method_data(acpi_handle, const char*, struct acpi_buffer*) ../../third_party/acpica/source/components/resources/rsutils.c:757 <platform-bus-x86.so>+0x2d4197
  #15   0x00002132da60652d in acpi_walk_resources(acpi_handle, char*, acpi_walk_resource_callback, void*) ../../third_party/acpica/source/components/resources/rsxface.c:731 <platform-bus-x86.so>+0x2d452d
  #16   0x00002132da41dd48 in acpi::acpi_impl::walk_resources(acpi::acpi_impl*, acpi_handle, const char*, acpi::Acpi::resources_callable) ../../src/devices/board/lib/acpi/acpi-impl.cc:41 <platform-bus-x86.so>+0xebd48
  #17   0x00002132da42394d in acpi::device_builder::gather_resources(acpi::device_builder*, acpi::Acpi*, fidl::any_arena&, acpi::Manager*, acpi::device_builder::gather_resources_callback) ../../src/devices/board/lib/acpi/device-builder.cc:52 <platform-bus-x86.so>+0xf194d
  #18   0x00002132da4afaf2 in acpi::Manager::configure_discovered_devices(acpi::Manager*) ../../src/devices/board/lib/acpi/manager.cc:75 <platform-bus-x86.so>+0x17daf2
  #19   0x00002132da3d7b44 in publish_acpi_devices(acpi::Manager*, zx_device_t*, zx_device_t*) ../../src/devices/board/drivers/x86/acpi-nswalk.cc:102 <platform-bus-x86.so>+0xa5b44
  #20   0x00002132da3e96f7 in x86::X86::do_init(x86::X86*) ../../src/devices/board/drivers/x86/x86.cc:65 <platform-bus-x86.so>+0xb76f7
  #21.1 0x00002132da3f38ea in λ(x86::X86::ddk_init::(anon class)*) ../../src/devices/board/drivers/x86/x86.cc:82 <platform-bus-x86.so>+0xc18ea
  #21   0x00002132da3f38ea in fit::internal::target<(lambda at../../src/devices/board/drivers/x86/x86.cc:81:19), false, false, void>::invoke(void*) ../../sdk/lib/fit/include/lib/fit/internal/function.h:181 <platform-bus-x86.so>+0xc18ea
  #22.2 0x00002132da638c6c in fit::internal::function_base<16UL, false, void()>::invoke(const fit::internal::function_base<16UL, false, void ()>*) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <platform-bus-x86.so>+0x306c6c
  #22.1 0x00002132da638c6c in fit::function_impl<16UL, false, void()>::operator()(const fit::function_impl<16UL, false, void ()>*) ../../sdk/lib/fit/include/lib/fit/function.h:300 <platform-bus-x86.so>+0x306c6c
  #22   0x00002132da638c6c in async::internal::retained_task::Handler(async_dispatcher_t*, async_task_t*, zx_status_t) ../../zircon/system/ulib/async/task.cc:25 <platform-bus-x86.so>+0x306c6c
  #23.1 0x000022c67b305d91 in λ(const driver_runtime::Dispatcher::post_task::(anon class)*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, zx_status_t) ../../src/devices/bin/driver_runtime/dispatcher.cc:715 <libdriver_runtime.so>+0x4bd91
  #23   0x000022c67b305d91 in fit::internal::target<(lambda at../../src/devices/bin/driver_runtime/dispatcher.cc:714:7), true, false, void, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int>::invoke(void*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/internal/function.h:128 <libdriver_runtime.so>+0x4bd91
  #24   0x000022c67b2febc9 in fit::internal::function_base<24UL, true, void(std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int)>::invoke(const fit::internal::function_base<24UL, true, void (std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int)>*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <libdriver_runtime.so>+0x44bc9
  #25   0x000022c67b2fe8dd in fit::callback_impl<24UL, true, void(std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int)>::operator()(fit::callback_impl<24UL, true, void (std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int)>*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/function.h:451 <libdriver_runtime.so>+0x448dd
  #26   0x000022c67b2ef6a6 in driver_runtime::callback_request::Call(driver_runtime::callback_request*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, zx_status_t) ../../src/devices/bin/driver_runtime/callback_request.h:67 <libdriver_runtime.so>+0x356a6
  #27   0x000022c67b2f64c8 in driver_runtime::Dispatcher::dispatch_callback(driver_runtime::Dispatcher*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >) ../../src/devices/bin/driver_runtime/dispatcher.cc:1093 <libdriver_runtime.so>+0x3c4c8
  #28   0x000022c67b2f72c1 in driver_runtime::Dispatcher::dispatch_callbacks(driver_runtime::Dispatcher*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../src/devices/bin/driver_runtime/dispatcher.cc:1169 <libdriver_runtime.so>+0x3d2c1
  #29.1 0x000022c67b30281e in λ(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>, const driver_runtime::Dispatcher::create_with_adder::(anon class)*) ../../src/devices/bin/driver_runtime/dispatcher.cc:338 <libdriver_runtime.so>+0x4881e
  #29   0x000022c67b30281e in fit::internal::target<(lambda at../../src/devices/bin/driver_runtime/dispatcher.cc:337:7), true, false, void, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>>::invoke(void*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/internal/function.h:128 <libdriver_runtime.so>+0x4881e
  #30   0x000022c67b2fee7e in fit::internal::function_base<8UL, true, void(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>)>::invoke(const fit::internal::function_base<8UL, true, void (std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>)>*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <libdriver_runtime.so>+0x44e7e
  #31.1 0x000022c67b2f8964 in fit::function_impl<8UL, true, void(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>)>::operator()(const fit::function_impl<8UL, true, void (std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>)>*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/function.h:300 <libdriver_runtime.so>+0x3e964
  #31   0x000022c67b2f8964 in driver_runtime::Dispatcher::event_waiter::invoke_callback(driver_runtime::Dispatcher::event_waiter*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../src/devices/bin/driver_runtime/dispatcher.h:299 <libdriver_runtime.so>+0x3e964
  #32   0x000022c67b2f835d in driver_runtime::Dispatcher::event_waiter::handle_event(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, async_dispatcher_t*, async::wait_base*, zx_status_t, zx_packet_signal_t const*) ../../src/devices/bin/driver_runtime/dispatcher.cc:1259 <libdriver_runtime.so>+0x3e35d
  #33.1 0x000022c67b302c00 in async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>::handle_event(async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>*, zx_status_t, zx_packet_signal_t const*, async_dispatcher_t*, async::wait_base*) ../../src/devices/bin/driver_runtime/async_loop_owned_event_handler.h:59 <libdriver_runtime.so>+0x48c00
  #33   0x000022c67b302c00 in async::wait_method<async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>, &async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>::handle_event>::call_handler(async_dispatcher_t*, async_wait_t*, zx_status_t, zx_packet_signal_t const*) ../../zircon/system/ulib/async/include/lib/async/cpp/wait.h:201 <libdriver_runtime.so>+0x48c00
  #34.1 0x000022c67b324ead in async_loop_run_once(async_loop_t*, zx_time_t) ../../zircon/system/ulib/async-loop/loop.c:415 <libdriver_runtime.so>+0x6aead
  #34   0x000022c67b324ead in async_loop_run(async_loop_t*, zx_time_t, _Bool) ../../zircon/system/ulib/async-loop/loop.c:288 <libdriver_runtime.so>+0x6aead
  #35   0x000022c67b32678f in async_loop_run_thread(void*) ../../zircon/system/ulib/async-loop/loop.c:840 <libdriver_runtime.so>+0x6c78f
  #36   0x0000431cc3246edc in start_c11(void*) ../../zircon/third_party/ulib/musl/pthread/pthread_create.c:55 <libc.so>+0xd7edc
  #37   0x0000431cc337796d in thread_trampoline(uintptr_t, uintptr_t) ../../zircon/system/ulib/runtime/thread.cc:100 <libc.so>+0x20896d

Link: https://github.com/acpica/acpica/commit/7b23bdc3
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/utresrc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index e1cc3d348750..cff7901f7866 100644
--- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -361,16 +361,20 @@ acpi_ut_validate_resource(struct acpi_walk_state *walk_state,
 	aml_resource = ACPI_CAST_PTR(union aml_resource, aml);
 	if (resource_type == ACPI_RESOURCE_NAME_SERIAL_BUS) {
 
+		/* Avoid undefined behavior: member access within misaligned address */
+
+		struct aml_resource_common_serialbus common_serial_bus;
+		memcpy(&common_serial_bus, aml_resource,
+		       sizeof(common_serial_bus));
+
 		/* Validate the bus_type field */
 
-		if ((aml_resource->common_serial_bus.type == 0) ||
-		    (aml_resource->common_serial_bus.type >
-		     AML_RESOURCE_MAX_SERIALBUSTYPE)) {
+		if ((common_serial_bus.type == 0) ||
+		    (common_serial_bus.type > AML_RESOURCE_MAX_SERIALBUSTYPE)) {
 			if (walk_state) {
 				ACPI_ERROR((AE_INFO,
 					    "Invalid/unsupported SerialBus resource descriptor: BusType 0x%2.2X",
-					    aml_resource->common_serial_bus.
-					    type));
+					    common_serial_bus.type));
 			}
 			return (AE_AML_INVALID_RESOURCE_TYPE);
 		}
-- 
2.35.3





