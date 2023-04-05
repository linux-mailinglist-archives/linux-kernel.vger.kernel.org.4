Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF806D7E62
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbjDEOC1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Apr 2023 10:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238185AbjDEOBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:01:44 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4263165A8;
        Wed,  5 Apr 2023 07:01:03 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id ba15fa655ef25601; Wed, 5 Apr 2023 16:01:01 +0200
Received: from kreacher.localnet (unknown [213.134.163.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 2969D1B4E9E1;
        Wed,  5 Apr 2023 16:01:00 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 18/32] ACPICA: Avoid undefined behavior: member access within misaligned address
Date:   Wed, 05 Apr 2023 15:46:30 +0200
Message-ID: <2438077.jE0xQCEvom@kreacher>
In-Reply-To: <4845957.31r3eYUQgx@kreacher>
References: <4845957.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.219
X-CLIENT-HOSTNAME: 213.134.163.219
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeetteevgfelhfefveeutefhudekleejgfeviedufefgleeuteeftedvieelleeinecuffhomhgrihhnpegrshgrnhdrshhopdhgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudeifedrvdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieefrddvudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3
X-Spam-Status: No, score=1.7 required=5.0 tests=SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK,WEIRD_PORT autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tamir Duberstein <tamird@google.com>

ACPICA commit 8ea5ada64b48dada42dbd5f0f58a9ce18f882ede

Before this change we see the following UBSAN stack trace in Fuchsia:

  #0    0x000020d00518f81a in acpi_rs_convert_aml_to_resources(u8*, u32, u32, u8, void**) ../../third_party/acpica/source/components/resources/rslist.c:104 <platform-bus-x86.so>+0x2cd81a
  #1.2  0x00002348b567277f in ubsan_get_stack_trace() compiler-rt/lib/ubsan/ubsan_diag.cpp:41 <libclang_rt.asan.so>+0x3d77f
  #1.1  0x00002348b567277f in maybe_print_stack_trace() compiler-rt/lib/ubsan/ubsan_diag.cpp:51 <libclang_rt.asan.so>+0x3d77f
  #1    0x00002348b567277f in ~scoped_report() compiler-rt/lib/ubsan/ubsan_diag.cpp:387 <libclang_rt.asan.so>+0x3d77f
  #2    0x00002348b5673385 in handletype_mismatch_impl() compiler-rt/lib/ubsan/ubsan_handlers.cpp:137 <libclang_rt.asan.so>+0x3e385
  #3    0x00002348b5672ead in compiler-rt/lib/ubsan/ubsan_handlers.cpp:142 <libclang_rt.asan.so>+0x3dead
  #4    0x000020d00518f81a in acpi_rs_convert_aml_to_resources(u8*, u32, u32, u8, void**) ../../third_party/acpica/source/components/resources/rslist.c:104 <platform-bus-x86.so>+0x2cd81a
  #5    0x000020d0051b8ea9 in acpi_ut_walk_aml_resources(struct acpi_walk_state*, u8*, acpi_size, acpi_walk_aml_callback, void**) ../../third_party/acpica/source/components/utilities/utresrc.c:234 <platform-bus-x86.so>+0x2f6ea9
  #6    0x000020d00518a806 in acpi_rs_create_resource_list(union acpi_operand_object*, struct acpi_buffer*) ../../third_party/acpica/source/components/resources/rscreate.c:199 <platform-bus-x86.so>+0x2c8806
  #7    0x000020d005195ff2 in acpi_rs_get_method_data(acpi_handle, const char*, struct acpi_buffer*) ../../third_party/acpica/source/components/resources/rsutils.c:770 <platform-bus-x86.so>+0x2d3ff2
  #8    0x000020d00519636d in acpi_walk_resources(acpi_handle, char*, acpi_walk_resource_callback, void*) ../../third_party/acpica/source/components/resources/rsxface.c:731 <platform-bus-x86.so>+0x2d436d
  #9    0x000020d004fadd48 in acpi::acpi_impl::walk_resources(acpi::acpi_impl*, acpi_handle, const char*, acpi::Acpi::resources_callable) ../../src/devices/board/lib/acpi/acpi-impl.cc:41 <platform-bus-x86.so>+0xebd48
  #10   0x000020d004fb394d in acpi::device_builder::gather_resources(acpi::device_builder*, acpi::Acpi*, fidl::any_arena&, acpi::Manager*, acpi::device_builder::gather_resources_callback) ../../src/devices/board/lib/acpi/device-builder.cc:52 <platform-bus-x86.so>+0xf194d
  #11   0x000020d00503faf2 in acpi::Manager::configure_discovered_devices(acpi::Manager*) ../../src/devices/board/lib/acpi/manager.cc:75 <platform-bus-x86.so>+0x17daf2
  #12   0x000020d004f67b44 in publish_acpi_devices(acpi::Manager*, zx_device_t*, zx_device_t*) ../../src/devices/board/drivers/x86/acpi-nswalk.cc:102 <platform-bus-x86.so>+0xa5b44
  #13   0x000020d004f796f7 in x86::X86::do_init(x86::X86*) ../../src/devices/board/drivers/x86/x86.cc:65 <platform-bus-x86.so>+0xb76f7
  #14.1 0x000020d004f838ea in λ(x86::X86::ddk_init::(anon class)*) ../../src/devices/board/drivers/x86/x86.cc:82 <platform-bus-x86.so>+0xc18ea
  #14   0x000020d004f838ea in fit::internal::target<(lambda at../../src/devices/board/drivers/x86/x86.cc:81:19), false, false, void>::invoke(void*) ../../sdk/lib/fit/include/lib/fit/internal/function.h:181 <platform-bus-x86.so>+0xc18ea
  #15.2 0x000020d0051c896c in fit::internal::function_base<16UL, false, void()>::invoke(const fit::internal::function_base<16UL, false, void ()>*) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <platform-bus-x86.so>+0x30696c
  #15.1 0x000020d0051c896c in fit::function_impl<16UL, false, void()>::operator()(const fit::function_impl<16UL, false, void ()>*) ../../sdk/lib/fit/include/lib/fit/function.h:300 <platform-bus-x86.so>+0x30696c
  #15   0x000020d0051c896c in async::internal::retained_task::Handler(async_dispatcher_t*, async_task_t*, zx_status_t) ../../zircon/system/ulib/async/task.cc:25 <platform-bus-x86.so>+0x30696c
  #16.1 0x00002061a33d3d91 in λ(const driver_runtime::Dispatcher::post_task::(anon class)*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, zx_status_t) ../../src/devices/bin/driver_runtime/dispatcher.cc:715 <libdriver_runtime.so>+0x4bd91
  #16   0x00002061a33d3d91 in fit::internal::target<(lambda at../../src/devices/bin/driver_runtime/dispatcher.cc:714:7), true, false, void, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int>::invoke(void*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/internal/function.h:128 <libdriver_runtime.so>+0x4bd91
  #17   0x00002061a33ccbc9 in fit::internal::function_base<24UL, true, void(std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int)>::invoke(const fit::internal::function_base<24UL, true, void (std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int)>*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <libdriver_runtime.so>+0x44bc9
  #18   0x00002061a33cc8dd in fit::callback_impl<24UL, true, void(std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int)>::operator()(fit::callback_impl<24UL, true, void (std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int)>*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/function.h:451 <libdriver_runtime.so>+0x448dd
  #19   0x00002061a33bd6a6 in driver_runtime::callback_request::Call(driver_runtime::callback_request*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, zx_status_t) ../../src/devices/bin/driver_runtime/callback_request.h:67 <libdriver_runtime.so>+0x356a6
  #20   0x00002061a33c44c8 in driver_runtime::Dispatcher::dispatch_callback(driver_runtime::Dispatcher*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >) ../../src/devices/bin/driver_runtime/dispatcher.cc:1093 <libdriver_runtime.so>+0x3c4c8
  #21   0x00002061a33c52c1 in driver_runtime::Dispatcher::dispatch_callbacks(driver_runtime::Dispatcher*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../src/devices/bin/driver_runtime/dispatcher.cc:1169 <libdriver_runtime.so>+0x3d2c1
  #22.1 0x00002061a33d081e in λ(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>, const driver_runtime::Dispatcher::create_with_adder::(anon class)*) ../../src/devices/bin/driver_runtime/dispatcher.cc:338 <libdriver_runtime.so>+0x4881e
  #22   0x00002061a33d081e in fit::internal::target<(lambda at../../src/devices/bin/driver_runtime/dispatcher.cc:337:7), true, false, void, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>>::invoke(void*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/internal/function.h:128 <libdriver_runtime.so>+0x4881e
  #23   0x00002061a33cce7e in fit::internal::function_base<8UL, true, void(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>)>::invoke(const fit::internal::function_base<8UL, true, void (std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>)>*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <libdriver_runtime.so>+0x44e7e
  #24.1 0x00002061a33c6964 in fit::function_impl<8UL, true, void(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>)>::operator()(const fit::function_impl<8UL, true, void (std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>)>*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/function.h:300 <libdriver_runtime.so>+0x3e964
  #24   0x00002061a33c6964 in driver_runtime::Dispatcher::event_waiter::invoke_callback(driver_runtime::Dispatcher::event_waiter*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../src/devices/bin/driver_runtime/dispatcher.h:299 <libdriver_runtime.so>+0x3e964
  #25   0x00002061a33c635d in driver_runtime::Dispatcher::event_waiter::handle_event(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, async_dispatcher_t*, async::wait_base*, zx_status_t, zx_packet_signal_t const*) ../../src/devices/bin/driver_runtime/dispatcher.cc:1259 <libdriver_runtime.so>+0x3e35d
  #26.1 0x00002061a33d0c00 in async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>::handle_event(async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>*, zx_status_t, zx_packet_signal_t const*, async_dispatcher_t*, async::wait_base*) ../../src/devices/bin/driver_runtime/async_loop_owned_event_handler.h:59 <libdriver_runtime.so>+0x48c00
  #26   0x00002061a33d0c00 in async::wait_method<async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>, &async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>::handle_event>::call_handler(async_dispatcher_t*, async_wait_t*, zx_status_t, zx_packet_signal_t const*) ../../zircon/system/ulib/async/include/lib/async/cpp/wait.h:201 <libdriver_runtime.so>+0x48c00
  #27.1 0x00002061a33f2ead in async_loop_run_once(async_loop_t*, zx_time_t) ../../zircon/system/ulib/async-loop/loop.c:415 <libdriver_runtime.so>+0x6aead
  #27   0x00002061a33f2ead in async_loop_run(async_loop_t*, zx_time_t, _Bool) ../../zircon/system/ulib/async-loop/loop.c:288 <libdriver_runtime.so>+0x6aead
  #28   0x00002061a33f478f in async_loop_run_thread(void*) ../../zircon/system/ulib/async-loop/loop.c:840 <libdriver_runtime.so>+0x6c78f
  #29   0x00004262135b7edc in start_c11(void*) ../../zircon/third_party/ulib/musl/pthread/pthread_create.c:55 <libc.so>+0xd7edc
  #30   0x00004262136e896d in thread_trampoline(uintptr_t, uintptr_t) ../../zircon/system/ulib/runtime/thread.cc:100 <libc.so>+0x20896d

Link: https://github.com/acpica/acpica/commit/8ea5ada6
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/rslist.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/rslist.c b/drivers/acpi/acpica/rslist.c
index e46efaa889cd..164c96e063c6 100644
--- a/drivers/acpi/acpica/rslist.c
+++ b/drivers/acpi/acpica/rslist.c
@@ -55,15 +55,21 @@ acpi_rs_convert_aml_to_resources(u8 * aml,
 	aml_resource = ACPI_CAST_PTR(union aml_resource, aml);
 
 	if (acpi_ut_get_resource_type(aml) == ACPI_RESOURCE_NAME_SERIAL_BUS) {
-		if (aml_resource->common_serial_bus.type >
-		    AML_RESOURCE_MAX_SERIALBUSTYPE) {
+
+		/* Avoid undefined behavior: member access within misaligned address */
+
+		struct aml_resource_common_serialbus common_serial_bus;
+		memcpy(&common_serial_bus, aml_resource,
+		       sizeof(common_serial_bus));
+
+		if (common_serial_bus.type > AML_RESOURCE_MAX_SERIALBUSTYPE) {
 			conversion_table = NULL;
 		} else {
 			/* This is an I2C, SPI, UART, or CSI2 serial_bus descriptor */
 
 			conversion_table =
 			    acpi_gbl_convert_resource_serial_bus_dispatch
-			    [aml_resource->common_serial_bus.type];
+			    [common_serial_bus.type];
 		}
 	} else {
 		conversion_table =
-- 
2.35.3





