Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82566D7E6F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbjDEODP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Apr 2023 10:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237972AbjDEOCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:02:15 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55DB6E92;
        Wed,  5 Apr 2023 07:01:12 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id e9a06f4bd0d167b5; Wed, 5 Apr 2023 16:01:11 +0200
Received: from kreacher.localnet (unknown [213.134.163.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 996111B4E9E1;
        Wed,  5 Apr 2023 16:01:10 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 12/32] ACPICA: Avoid undefined behavior: load of misaligned address
Date:   Wed, 05 Apr 2023 15:41:50 +0200
Message-ID: <1879151.CQOukoFCf9@kreacher>
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

ACPICA commit 807665510f1ea71bbdc063c27782a1da56e8e10a

Before this change we see the following UBSAN stack trace in Fuchsia:

  #0    0x00002234800696e6 in acpi_tb_get_root_table_entry(u8*, u32) ../../third_party/acpica/source/components/tables/tbutils.c:231 <platform-bus-x86.so>+0x9106e6
  #1.2  0x0000233d72c8777f in ubsan_get_stack_trace() compiler-rt/lib/ubsan/ubsan_diag.cpp:41 <libclang_rt.asan.so>+0x3d77f
  #1.1  0x0000233d72c8777f in maybe_print_stack_trace() compiler-rt/lib/ubsan/ubsan_diag.cpp:51 <libclang_rt.asan.so>+0x3d77f
  #1    0x0000233d72c8777f in ~scoped_report() compiler-rt/lib/ubsan/ubsan_diag.cpp:387 <libclang_rt.asan.so>+0x3d77f
  #2    0x0000233d72c88385 in handletype_mismatch_impl() compiler-rt/lib/ubsan/ubsan_handlers.cpp:137 <libclang_rt.asan.so>+0x3e385
  #3    0x0000233d72c87ead in compiler-rt/lib/ubsan/ubsan_handlers.cpp:142 <libclang_rt.asan.so>+0x3dead
  #4    0x00002234800696e6 in acpi_tb_get_root_table_entry(u8*, u32) ../../third_party/acpica/source/components/tables/tbutils.c:231 <platform-bus-x86.so>+0x9106e6
  #5    0x00002234800691dd in acpi_tb_parse_root_table(acpi_physical_address) ../../third_party/acpica/source/components/tables/tbutils.c:385 <platform-bus-x86.so>+0x9101dd
  #6    0x0000223480070b06 in acpi_initialize_tables(struct acpi_table_desc*, u32, u8) ../../third_party/acpica/source/components/tables/tbxface.c:160 <platform-bus-x86.so>+0x917b06
  #7    0x000022347fb803b4 in acpi::acpi_impl::initialize_acpi(acpi::acpi_impl*) ../../src/devices/board/lib/acpi/acpi-impl.cc:200 <platform-bus-x86.so>+0x4273b4
  #8    0x000022347fa30d14 in x86::X86::early_acpi_init(x86::X86*) ../../src/devices/board/drivers/x86/init.cc:34 <platform-bus-x86.so>+0x2d7d14
  #9    0x000022347fa310cf in x86::X86::early_init(x86::X86*) ../../src/devices/board/drivers/x86/init.cc:43 <platform-bus-x86.so>+0x2d80cf
  #10   0x000022347fa79410 in x86::X86::Bind(x86::X86*) ../../src/devices/board/drivers/x86/x86.cc:144 <platform-bus-x86.so>+0x320410
  #11   0x000022347fa78ec0 in x86::X86::create_and_bind(void*, zx_device_t*) ../../src/devices/board/drivers/x86/x86.cc:123 <platform-bus-x86.so>+0x31fec0
  #12   0x000020dc8908502f in λ(const zx_driver::bind_op::(anon class)*) ../../src/devices/bin/driver_host/zx_driver.cc:36 <<application>>+0x41502f
  #13   0x000020dc89084e03 in fit::internal::target<(lambda at../../src/devices/bin/driver_host/zx_driver.cc:34:61), false, false, void>::invoke(void*) ../../sdk/lib/fit/include/lib/fit/internal/function.h:181 <<application>>+0x414e03
  #14   0x000020dc8935a930 in fit::internal::function_base<16UL, false, void()>::invoke(const fit::internal::function_base<16UL, false, void ()>*) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <<application>>+0x6ea930
  #15   0x000020dc893e2f8a in fit::function_impl<16UL, false, void()>::operator()(const fit::function_impl<16UL, false, void ()>*) ../../sdk/lib/fit/include/lib/fit/function.h:300 <<application>>+0x772f8a
  #16   0x000020dc8948dec5 in async::internal::retained_task::Handler(async_dispatcher_t*, async_task_t*, zx_status_t) ../../zircon/system/ulib/async/task.cc:25 <<application>>+0x81dec5
  #17   0x000023ab5abcf91e in λ(const driver_runtime::Dispatcher::post_task::(anon class)*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, zx_status_t) ../../src/devices/bin/driver_runtime/dispatcher.cc:715 <libdriver_runtime.so>+0xed91e
  #18   0x000023ab5abcf621 in fit::internal::target<(lambda at../../src/devices/bin/driver_runtime/dispatcher.cc:714:7), true, false, void, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int>::invoke(void*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/internal/function.h:128 <libdriver_runtime.so>+0xed621
  #19   0x000023ab5abaa482 in fit::internal::function_base<24UL, true, void(std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int)>::invoke(const fit::internal::function_base<24UL, true, void (std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int)>*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <libdriver_runtime.so>+0xc8482
  #20   0x000023ab5abaa0f8 in fit::callback_impl<24UL, true, void(std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int)>::operator()(fit::callback_impl<24UL, true, void (std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int)>*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/function.h:451 <libdriver_runtime.so>+0xc80f8
  #21   0x000023ab5ab81c76 in driver_runtime::callback_request::Call(driver_runtime::callback_request*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, zx_status_t) ../../src/devices/bin/driver_runtime/callback_request.h:67 <libdriver_runtime.so>+0x9fc76
  #22   0x000023ab5ab8e7ef in driver_runtime::Dispatcher::dispatch_callback(driver_runtime::Dispatcher*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >) ../../src/devices/bin/driver_runtime/dispatcher.cc:1093 <libdriver_runtime.so>+0xac7ef
  #23   0x000023ab5ab91d67 in driver_runtime::Dispatcher::dispatch_callbacks(driver_runtime::Dispatcher*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../src/devices/bin/driver_runtime/dispatcher.cc:1169 <libdriver_runtime.so>+0xafd67
  #24   0x000023ab5abbe9a2 in λ(const driver_runtime::Dispatcher::create_with_adder::(anon class)*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../src/devices/bin/driver_runtime/dispatcher.cc:338 <libdriver_runtime.so>+0xdc9a2
  #25   0x000023ab5abbe6d2 in fit::internal::target<(lambda at../../src/devices/bin/driver_runtime/dispatcher.cc:337:7), true, false, void, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>>::invoke(void*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/internal/function.h:128 <libdriver_runtime.so>+0xdc6d2
  #26   0x000023ab5abac1e5 in fit::internal::function_base<8UL, true, void(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>)>::invoke(const fit::internal::function_base<8UL, true, void (std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>)>*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <libdriver_runtime.so>+0xca1e5
  #27   0x000023ab5ababe32 in fit::function_impl<8UL, true, void(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>)>::operator()(const fit::function_impl<8UL, true, void (std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>)>*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/function.h:300 <libdriver_runtime.so>+0xc9e32
  #28   0x000023ab5ab95444 in driver_runtime::Dispatcher::event_waiter::invoke_callback(driver_runtime::Dispatcher::event_waiter*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../src/devices/bin/driver_runtime/dispatcher.h:299 <libdriver_runtime.so>+0xb3444
  #29   0x000023ab5ab94feb in driver_runtime::Dispatcher::event_waiter::handle_event(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, async_dispatcher_t*, async::wait_base*, zx_status_t, zx_packet_signal_t const*) ../../src/devices/bin/driver_runtime/dispatcher.cc:1259 <libdriver_runtime.so>+0xb2feb
  #30   0x000023ab5abbef74 in async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>::handle_event(async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>*, async_dispatcher_t*, async::wait_base*, zx_status_t, zx_packet_signal_t const*) ../../src/devices/bin/driver_runtime/async_loop_owned_event_handler.h:59 <libdriver_runtime.so>+0xdcf74
  #31   0x000023ab5abbf1cb in async::wait_method<async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>, &async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>::handle_event>::call_handler(async_dispatcher_t*, async_wait_t*, zx_status_t, zx_packet_signal_t const*) ../../zircon/system/ulib/async/include/lib/async/cpp/wait.h:201 <libdriver_runtime.so>+0xdd1cb
  #32   0x000023ab5ac323a9 in async_loop_dispatch_wait(async_loop_t*, async_wait_t*, zx_status_t, zx_packet_signal_t const*) ../../zircon/system/ulib/async-loop/loop.c:381 <libdriver_runtime.so>+0x1503a9
  #33   0x000023ab5ac2ba82 in async_loop_run_once(async_loop_t*, zx_time_t) ../../zircon/system/ulib/async-loop/loop.c:330 <libdriver_runtime.so>+0x149a82
  #34   0x000023ab5ac2b102 in async_loop_run(async_loop_t*, zx_time_t, _Bool) ../../zircon/system/ulib/async-loop/loop.c:288 <libdriver_runtime.so>+0x149102
  #35   0x000023ab5ac2ceb7 in async_loop_run_thread(void*) ../../zircon/system/ulib/async-loop/loop.c:840 <libdriver_runtime.so>+0x14aeb7
  #36   0x000040b3be411f1c in start_c11(void*) ../../zircon/third_party/ulib/musl/pthread/pthread_create.c:55 <libc.so>+0xd7f1c
  #37   0x000040b3be53ce8d in thread_trampoline(uintptr_t, uintptr_t) ../../zircon/system/ulib/runtime/thread.cc:100 <libc.so>+0x202e8d

Link: https://github.com/acpica/acpica/commit/80766551
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/tbutils.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index cfe50c53ad4d..bb4a56e5673a 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -165,6 +165,7 @@ struct acpi_table_header *acpi_tb_copy_dsdt(u32 table_index)
 static acpi_physical_address
 acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size)
 {
+	u32 address32;
 	u64 address64;
 
 	/*
@@ -176,8 +177,8 @@ acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size)
 		 * 32-bit platform, RSDT: Return 32-bit table entry
 		 * 64-bit platform, RSDT: Expand 32-bit to 64-bit and return
 		 */
-		return ((acpi_physical_address)
-			(*ACPI_CAST_PTR(u32, table_entry)));
+		ACPI_MOVE_32_TO_32(&address32, table_entry);
+		return address32;
 	} else {
 		/*
 		 * 32-bit platform, XSDT: Truncate 64-bit to 32-bit and return
-- 
2.35.3




