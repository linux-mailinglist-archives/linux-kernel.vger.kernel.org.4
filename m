Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2031D6D7E69
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238381AbjDEOCt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Apr 2023 10:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237865AbjDEOCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:02:01 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE4E6A61;
        Wed,  5 Apr 2023 07:01:08 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id e471cee2a487451d; Wed, 5 Apr 2023 16:01:07 +0200
Received: from kreacher.localnet (unknown [213.134.163.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 574111B4E9E1;
        Wed,  5 Apr 2023 16:01:06 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 15/32] ACPICA: Avoid undefined behavior: member access within misaligned address
Date:   Wed, 05 Apr 2023 15:44:12 +0200
Message-ID: <3699849.MHq7AAxBmi@kreacher>
In-Reply-To: <4845957.31r3eYUQgx@kreacher>
References: <4845957.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.219
X-CLIENT-HOSTNAME: 213.134.163.219
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepveffueegtddtgfdtgfejudefveetuedvleefieekudeuhffhiedvudfffeeiteelnecuffhomhgrihhnpegrshgrnhdrshhopdhgihhthhhusgdrtghomhdprgguughrvghsshdrihhnfhhonecukfhppedvudefrddufeegrdduieefrddvudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeifedrvdduledphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepfedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgv
 lhdrtghomh
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

ACPICA commit c14708336bd18552b28643575de7b5beb9b864e9

Before this change we see the following UBSAN stack trace in Fuchsia:

  #0    0x0000220c98288eba in acpi_rs_get_address_common(struct acpi_resource*, union aml_resource*) ../../third_party/acpica/source/components/resources/rsaddr.c:331 <platform-bus-x86.so>+0x8f6eba
  #1.2  0x000023625f46077f in ubsan_get_stack_trace() compiler-rt/lib/ubsan/ubsan_diag.cpp:41 <libclang_rt.asan.so>+0x3d77f
  #1.1  0x000023625f46077f in maybe_print_stack_trace() compiler-rt/lib/ubsan/ubsan_diag.cpp:51 <libclang_rt.asan.so>+0x3d77f
  #1    0x000023625f46077f in ~scoped_report() compiler-rt/lib/ubsan/ubsan_diag.cpp:387 <libclang_rt.asan.so>+0x3d77f
  #2    0x000023625f461385 in handletype_mismatch_impl() compiler-rt/lib/ubsan/ubsan_handlers.cpp:137 <libclang_rt.asan.so>+0x3e385
  #3    0x000023625f460ead in compiler-rt/lib/ubsan/ubsan_handlers.cpp:142 <libclang_rt.asan.so>+0x3dead
  #4    0x0000220c98288eba in acpi_rs_get_address_common(struct acpi_resource*, union aml_resource*) ../../third_party/acpica/source/components/resources/rsaddr.c:331 <platform-bus-x86.so>+0x8f6eba
  #5    0x0000220c9828ea57 in acpi_rs_convert_aml_to_resource(struct acpi_resource*, union aml_resource*, struct acpi_rsconvert_info*) ../../third_party/acpica/source/components/resources/rsmisc.c:352 <platform-bus-x86.so>+0x8fca57
  #6    0x0000220c9828992c in acpi_rs_convert_aml_to_resources(u8*, u32, u32, u8, void**) ../../third_party/acpica/source/components/resources/rslist.c:132 <platform-bus-x86.so>+0x8f792c
  #7    0x0000220c982d1cfc in acpi_ut_walk_aml_resources(struct acpi_walk_state*, u8*, acpi_size, acpi_walk_aml_callback, void**) ../../third_party/acpica/source/components/utilities/utresrc.c:234 <platform-bus-x86.so>+0x93fcfc
  #8    0x0000220c98281e46 in acpi_rs_create_resource_list(union acpi_operand_object*, struct acpi_buffer*) ../../third_party/acpica/source/components/resources/rscreate.c:199 <platform-bus-x86.so>+0x8efe46
  #9    0x0000220c98293b51 in acpi_rs_get_method_data(acpi_handle, const char*, struct acpi_buffer*) ../../third_party/acpica/source/components/resources/rsutils.c:770 <platform-bus-x86.so>+0x901b51
  #10   0x0000220c9829438d in acpi_walk_resources(acpi_handle, char*, acpi_walk_resource_callback, void*) ../../third_party/acpica/source/components/resources/rsxface.c:731 <platform-bus-x86.so>+0x90238d
  #11   0x0000220c97db272b in acpi::acpi_impl::walk_resources(acpi::acpi_impl*, acpi_handle, const char*, acpi::Acpi::resources_callable) ../../src/devices/board/lib/acpi/acpi-impl.cc:41 <platform-bus-x86.so>+0x42072b
  #12   0x0000220c97dcec59 in acpi::device_builder::gather_resources(acpi::device_builder*, acpi::Acpi*, fidl::any_arena&, acpi::Manager*, acpi::device_builder::gather_resources_callback) ../../src/devices/board/lib/acpi/device-builder.cc:52 <platform-bus-x86.so>+0x43cc59
  #13   0x0000220c97f94a3f in acpi::Manager::configure_discovered_devices(acpi::Manager*) ../../src/devices/board/lib/acpi/manager.cc:75 <platform-bus-x86.so>+0x602a3f
  #14   0x0000220c97c642c7 in publish_acpi_devices(acpi::Manager*, zx_device_t*, zx_device_t*) ../../src/devices/board/drivers/x86/acpi-nswalk.cc:102 <platform-bus-x86.so>+0x2d22c7
  #15   0x0000220c97caf3e6 in x86::X86::do_init(x86::X86*) ../../src/devices/board/drivers/x86/x86.cc:65 <platform-bus-x86.so>+0x31d3e6
  #16   0x0000220c97cd72ae in λ(x86::X86::ddk_init::(anon class)*) ../../src/devices/board/drivers/x86/x86.cc:82 <platform-bus-x86.so>+0x3452ae
  #17   0x0000220c97cd7223 in fit::internal::target<(lambda at../../src/devices/board/drivers/x86/x86.cc:81:19), false, false, void>::invoke(void*) ../../sdk/lib/fit/include/lib/fit/internal/function.h:181 <platform-bus-x86.so>+0x345223
  #18   0x0000220c97f48eb0 in fit::internal::function_base<16UL, false, void()>::invoke(const fit::internal::function_base<16UL, false, void ()>*) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <platform-bus-x86.so>+0x5b6eb0
  #19   0x0000220c97f48d2a in fit::function_impl<16UL, false, void()>::operator()(const fit::function_impl<16UL, false, void ()>*) ../../sdk/lib/fit/include/lib/fit/function.h:300 <platform-bus-x86.so>+0x5b6d2a
  #20   0x0000220c982f9245 in async::internal::retained_task::Handler(async_dispatcher_t*, async_task_t*, zx_status_t) ../../zircon/system/ulib/async/task.cc:25 <platform-bus-x86.so>+0x967245
  #21   0x000022e2aa1cd91e in λ(const driver_runtime::Dispatcher::post_task::(anon class)*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, zx_status_t) ../../src/devices/bin/driver_runtime/dispatcher.cc:715 <libdriver_runtime.so>+0xed91e
  #22   0x000022e2aa1cd621 in fit::internal::target<(lambda at../../src/devices/bin/driver_runtime/dispatcher.cc:714:7), true, false, void, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int>::invoke(void*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/internal/function.h:128 <libdriver_runtime.so>+0xed621
  #23   0x000022e2aa1a8482 in fit::internal::function_base<24UL, true, void(std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int)>::invoke(const fit::internal::function_base<24UL, true, void (std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int)>*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <libdriver_runtime.so>+0xc8482
  #24   0x000022e2aa1a80f8 in fit::callback_impl<24UL, true, void(std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int)>::operator()(fit::callback_impl<24UL, true, void (std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int)>*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/function.h:451 <libdriver_runtime.so>+0xc80f8
  #25   0x000022e2aa17fc76 in driver_runtime::callback_request::Call(driver_runtime::callback_request*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, zx_status_t) ../../src/devices/bin/driver_runtime/callback_request.h:67 <libdriver_runtime.so>+0x9fc76
  #26   0x000022e2aa18c7ef in driver_runtime::Dispatcher::dispatch_callback(driver_runtime::Dispatcher*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >) ../../src/devices/bin/driver_runtime/dispatcher.cc:1093 <libdriver_runtime.so>+0xac7ef
  #27   0x000022e2aa18fd67 in driver_runtime::Dispatcher::dispatch_callbacks(driver_runtime::Dispatcher*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../src/devices/bin/driver_runtime/dispatcher.cc:1169 <libdriver_runtime.so>+0xafd67
  #28   0x000022e2aa1bc9a2 in λ(const driver_runtime::Dispatcher::create_with_adder::(anon class)*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../src/devices/bin/driver_runtime/dispatcher.cc:338 <libdriver_runtime.so>+0xdc9a2
  #29   0x000022e2aa1bc6d2 in fit::internal::target<(lambda at../../src/devices/bin/driver_runtime/dispatcher.cc:337:7), true, false, void, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>>::invoke(void*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/internal/function.h:128 <libdriver_runtime.so>+0xdc6d2
  #30   0x000022e2aa1aa1e5 in fit::internal::function_base<8UL, true, void(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>)>::invoke(const fit::internal::function_base<8UL, true, void (std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>)>*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <libdriver_runtime.so>+0xca1e5
  #31   0x000022e2aa1a9e32 in fit::function_impl<8UL, true, void(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>)>::operator()(const fit::function_impl<8UL, true, void (std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>)>*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/function.h:300 <libdriver_runtime.so>+0xc9e32
  #32   0x000022e2aa193444 in driver_runtime::Dispatcher::event_waiter::invoke_callback(driver_runtime::Dispatcher::event_waiter*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../src/devices/bin/driver_runtime/dispatcher.h:299 <libdriver_runtime.so>+0xb3444
  #33   0x000022e2aa192feb in driver_runtime::Dispatcher::event_waiter::handle_event(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, async_dispatcher_t*, async::wait_base*, zx_status_t, zx_packet_signal_t const*) ../../src/devices/bin/driver_runtime/dispatcher.cc:1259 <libdriver_runtime.so>+0xb2feb
  #34   0x000022e2aa1bcf74 in async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>::handle_event(async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>*, async_dispatcher_t*, async::wait_base*, zx_status_t, zx_packet_signal_t const*) ../../src/devices/bin/driver_runtime/async_loop_owned_event_handler.h:59 <libdriver_runtime.so>+0xdcf74
  #35   0x000022e2aa1bd1cb in async::wait_method<async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>, &async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>::handle_event>::call_handler(async_dispatcher_t*, async_wait_t*, zx_status_t, zx_packet_signal_t const*) ../../zircon/system/ulib/async/include/lib/async/cpp/wait.h:201 <libdriver_runtime.so>+0xdd1cb
  #36   0x000022e2aa2303a9 in async_loop_dispatch_wait(async_loop_t*, async_wait_t*, zx_status_t, zx_packet_signal_t const*) ../../zircon/system/ulib/async-loop/loop.c:381 <libdriver_runtime.so>+0x1503a9
  #37   0x000022e2aa229a82 in async_loop_run_once(async_loop_t*, zx_time_t) ../../zircon/system/ulib/async-loop/loop.c:330 <libdriver_runtime.so>+0x149a82
  #38   0x000022e2aa229102 in async_loop_run(async_loop_t*, zx_time_t, _Bool) ../../zircon/system/ulib/async-loop/loop.c:288 <libdriver_runtime.so>+0x149102
  #39   0x000022e2aa22aeb7 in async_loop_run_thread(void*) ../../zircon/system/ulib/async-loop/loop.c:840 <libdriver_runtime.so>+0x14aeb7
  #40   0x000041a874980f1c in start_c11(void*) ../../zircon/third_party/ulib/musl/pthread/pthread_create.c:55 <libc.so>+0xd7f1c
  #41   0x000041a874aabe8d in thread_trampoline(uintptr_t, uintptr_t) ../../zircon/system/ulib/runtime/thread.cc:100 <libc.so>+0x202e8d

Link: https://github.com/acpica/acpica/commit/c1470833
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/rsaddr.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/rsaddr.c b/drivers/acpi/acpica/rsaddr.c
index 5737c3af1902..fff48001d7ef 100644
--- a/drivers/acpi/acpica/rsaddr.c
+++ b/drivers/acpi/acpica/rsaddr.c
@@ -272,12 +272,17 @@ u8
 acpi_rs_get_address_common(struct acpi_resource *resource,
 			   union aml_resource *aml)
 {
+	struct aml_resource_address address;
+
 	ACPI_FUNCTION_ENTRY();
 
+	/* Avoid undefined behavior: member access within misaligned address */
+
+	memcpy(&address, aml, sizeof(address));
+
 	/* Validate the Resource Type */
 
-	if ((aml->address.resource_type > 2) &&
-	    (aml->address.resource_type < 0xC0)) {
+	if ((address.resource_type > 2) && (address.resource_type < 0xC0)) {
 		return (FALSE);
 	}
 
@@ -298,7 +303,7 @@ acpi_rs_get_address_common(struct acpi_resource *resource,
 		/* Generic resource type, just grab the type_specific byte */
 
 		resource->data.address.info.type_specific =
-		    aml->address.specific_flags;
+		    address.specific_flags;
 	}
 
 	return (TRUE);
-- 
2.35.3





