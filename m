Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC366D7E61
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbjDEOCW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Apr 2023 10:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238242AbjDEOBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:01:43 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CE765AD;
        Wed,  5 Apr 2023 07:01:00 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 9912572ad5d7b4d6; Wed, 5 Apr 2023 16:00:58 +0200
Received: from kreacher.localnet (unknown [213.134.163.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id B9AA71B4EA62;
        Wed,  5 Apr 2023 16:00:57 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 19/32] ACPICA: Avoid undefined behavior: load of misaligned address
Date:   Wed, 05 Apr 2023 15:47:18 +0200
Message-ID: <840381413.0ifERbkFSE@kreacher>
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

ACPICA commit b3317239749d1907ec95e7aa2057d7ea29d3c638

Before this change we see the following UBSAN stack trace in Fuchsia:

  #0    0x000020c1f68c9959 in acpi_rs_convert_aml_to_resource(struct acpi_resource*, union aml_resource*, struct acpi_rsconvert_info*) ../../third_party/acpica/source/components/resources/rsmisc.c:244 <platform-bus-x86.so>+0x2d0959
  #1.2  0x000020e5d259f77f in ubsan_get_stack_trace() compiler-rt/lib/ubsan/ubsan_diag.cpp:41 <libclang_rt.asan.so>+0x3d77f
  #1.1  0x000020e5d259f77f in maybe_print_stack_trace() compiler-rt/lib/ubsan/ubsan_diag.cpp:51 <libclang_rt.asan.so>+0x3d77f
  #1    0x000020e5d259f77f in ~scoped_report() compiler-rt/lib/ubsan/ubsan_diag.cpp:387 <libclang_rt.asan.so>+0x3d77f
  #2    0x000020e5d25a0385 in handletype_mismatch_impl() compiler-rt/lib/ubsan/ubsan_handlers.cpp:137 <libclang_rt.asan.so>+0x3e385
  #3    0x000020e5d259fead in compiler-rt/lib/ubsan/ubsan_handlers.cpp:142 <libclang_rt.asan.so>+0x3dead
  #4    0x000020c1f68c9959 in acpi_rs_convert_aml_to_resource(struct acpi_resource*, union aml_resource*, struct acpi_rsconvert_info*) ../../third_party/acpica/source/components/resources/rsmisc.c:244 <platform-bus-x86.so>+0x2d0959
  #5    0x000020c1f68c65a9 in acpi_rs_convert_aml_to_resources(u8*, u32, u32, u8, void**) ../../third_party/acpica/source/components/resources/rslist.c:137 <platform-bus-x86.so>+0x2cd5a9
  #6    0x000020c1f68efda9 in acpi_ut_walk_aml_resources(struct acpi_walk_state*, u8*, acpi_size, acpi_walk_aml_callback, void**) ../../third_party/acpica/source/components/utilities/utresrc.c:234 <platform-bus-x86.so>+0x2f6da9
  #7    0x000020c1f68c1806 in acpi_rs_create_resource_list(union acpi_operand_object*, struct acpi_buffer*) ../../third_party/acpica/source/components/resources/rscreate.c:199 <platform-bus-x86.so>+0x2c8806
  #8    0x000020c1f68ccef2 in acpi_rs_get_method_data(acpi_handle, const char*, struct acpi_buffer*) ../../third_party/acpica/source/components/resources/rsutils.c:770 <platform-bus-x86.so>+0x2d3ef2
  #9    0x000020c1f68cd26d in acpi_walk_resources(acpi_handle, char*, acpi_walk_resource_callback, void*) ../../third_party/acpica/source/components/resources/rsxface.c:731 <platform-bus-x86.so>+0x2d426d
  #10   0x000020c1f66e4d48 in acpi::acpi_impl::walk_resources(acpi::acpi_impl*, acpi_handle, const char*, acpi::Acpi::resources_callable) ../../src/devices/board/lib/acpi/acpi-impl.cc:41 <platform-bus-x86.so>+0xebd48
  #11   0x000020c1f66ea94d in acpi::device_builder::gather_resources(acpi::device_builder*, acpi::Acpi*, fidl::any_arena&, acpi::Manager*, acpi::device_builder::gather_resources_callback) ../../src/devices/board/lib/acpi/device-builder.cc:52 <platform-bus-x86.so>+0xf194d
  #12   0x000020c1f6776af2 in acpi::Manager::configure_discovered_devices(acpi::Manager*) ../../src/devices/board/lib/acpi/manager.cc:75 <platform-bus-x86.so>+0x17daf2
  #13   0x000020c1f669eb44 in publish_acpi_devices(acpi::Manager*, zx_device_t*, zx_device_t*) ../../src/devices/board/drivers/x86/acpi-nswalk.cc:102 <platform-bus-x86.so>+0xa5b44
  #14   0x000020c1f66b06f7 in x86::X86::do_init(x86::X86*) ../../src/devices/board/drivers/x86/x86.cc:65 <platform-bus-x86.so>+0xb76f7
  #15.1 0x000020c1f66ba8ea in λ(x86::X86::ddk_init::(anon class)*) ../../src/devices/board/drivers/x86/x86.cc:82 <platform-bus-x86.so>+0xc18ea
  #15   0x000020c1f66ba8ea in fit::internal::target<(lambda at../../src/devices/board/drivers/x86/x86.cc:81:19), false, false, void>::invoke(void*) ../../sdk/lib/fit/include/lib/fit/internal/function.h:181 <platform-bus-x86.so>+0xc18ea
  #16.2 0x000020c1f68ff86c in fit::internal::function_base<16UL, false, void()>::invoke(const fit::internal::function_base<16UL, false, void ()>*) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <platform-bus-x86.so>+0x30686c
  #16.1 0x000020c1f68ff86c in fit::function_impl<16UL, false, void()>::operator()(const fit::function_impl<16UL, false, void ()>*) ../../sdk/lib/fit/include/lib/fit/function.h:300 <platform-bus-x86.so>+0x30686c
  #16   0x000020c1f68ff86c in async::internal::retained_task::Handler(async_dispatcher_t*, async_task_t*, zx_status_t) ../../zircon/system/ulib/async/task.cc:25 <platform-bus-x86.so>+0x30686c
  #17.1 0x000022d99b37bd91 in λ(const driver_runtime::Dispatcher::post_task::(anon class)*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, zx_status_t) ../../src/devices/bin/driver_runtime/dispatcher.cc:715 <libdriver_runtime.so>+0x4bd91
  #17   0x000022d99b37bd91 in fit::internal::target<(lambda at../../src/devices/bin/driver_runtime/dispatcher.cc:714:7), true, false, void, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int>::invoke(void*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/internal/function.h:128 <libdriver_runtime.so>+0x4bd91
  #18   0x000022d99b374bc9 in fit::internal::function_base<24UL, true, void(std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int)>::invoke(const fit::internal::function_base<24UL, true, void (std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int)>*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <libdriver_runtime.so>+0x44bc9
  #19   0x000022d99b3748dd in fit::callback_impl<24UL, true, void(std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int)>::operator()(fit::callback_impl<24UL, true, void (std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int)>*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/function.h:451 <libdriver_runtime.so>+0x448dd
  #20   0x000022d99b3656a6 in driver_runtime::callback_request::Call(driver_runtime::callback_request*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, zx_status_t) ../../src/devices/bin/driver_runtime/callback_request.h:67 <libdriver_runtime.so>+0x356a6
  #21   0x000022d99b36c4c8 in driver_runtime::Dispatcher::dispatch_callback(driver_runtime::Dispatcher*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >) ../../src/devices/bin/driver_runtime/dispatcher.cc:1093 <libdriver_runtime.so>+0x3c4c8
  #22   0x000022d99b36d2c1 in driver_runtime::Dispatcher::dispatch_callbacks(driver_runtime::Dispatcher*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../src/devices/bin/driver_runtime/dispatcher.cc:1169 <libdriver_runtime.so>+0x3d2c1
  #23.1 0x000022d99b37881e in λ(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>, const driver_runtime::Dispatcher::create_with_adder::(anon class)*) ../../src/devices/bin/driver_runtime/dispatcher.cc:338 <libdriver_runtime.so>+0x4881e
  #23   0x000022d99b37881e in fit::internal::target<(lambda at../../src/devices/bin/driver_runtime/dispatcher.cc:337:7), true, false, void, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>>::invoke(void*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/internal/function.h:128 <libdriver_runtime.so>+0x4881e
  #24   0x000022d99b374e7e in fit::internal::function_base<8UL, true, void(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>)>::invoke(const fit::internal::function_base<8UL, true, void (std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>)>*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <libdriver_runtime.so>+0x44e7e
  #25.1 0x000022d99b36e964 in fit::function_impl<8UL, true, void(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>)>::operator()(const fit::function_impl<8UL, true, void (std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>)>*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/function.h:300 <libdriver_runtime.so>+0x3e964
  #25   0x000022d99b36e964 in driver_runtime::Dispatcher::event_waiter::invoke_callback(driver_runtime::Dispatcher::event_waiter*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../src/devices/bin/driver_runtime/dispatcher.h:299 <libdriver_runtime.so>+0x3e964
  #26   0x000022d99b36e35d in driver_runtime::Dispatcher::event_waiter::handle_event(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, async_dispatcher_t*, async::wait_base*, zx_status_t, zx_packet_signal_t const*) ../../src/devices/bin/driver_runtime/dispatcher.cc:1259 <libdriver_runtime.so>+0x3e35d
  #27.1 0x000022d99b378c00 in async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>::handle_event(async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>*, zx_status_t, zx_packet_signal_t const*, async_dispatcher_t*, async::wait_base*) ../../src/devices/bin/driver_runtime/async_loop_owned_event_handler.h:59 <libdriver_runtime.so>+0x48c00
  #27   0x000022d99b378c00 in async::wait_method<async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>, &async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>::handle_event>::call_handler(async_dispatcher_t*, async_wait_t*, zx_status_t, zx_packet_signal_t const*) ../../zircon/system/ulib/async/include/lib/async/cpp/wait.h:201 <libdriver_runtime.so>+0x48c00
  #28.1 0x000022d99b39aead in async_loop_run_once(async_loop_t*, zx_time_t) ../../zircon/system/ulib/async-loop/loop.c:415 <libdriver_runtime.so>+0x6aead
  #28   0x000022d99b39aead in async_loop_run(async_loop_t*, zx_time_t, _Bool) ../../zircon/system/ulib/async-loop/loop.c:288 <libdriver_runtime.so>+0x6aead
  #29   0x000022d99b39c78f in async_loop_run_thread(void*) ../../zircon/system/ulib/async-loop/loop.c:840 <libdriver_runtime.so>+0x6c78f
  #30   0x00004230f4a33edc in start_c11(void*) ../../zircon/third_party/ulib/musl/pthread/pthread_create.c:55 <libc.so>+0xd7edc
  #31   0x00004230f4b6496d in thread_trampoline(uintptr_t, uintptr_t) ../../zircon/system/ulib/runtime/thread.cc:100 <libc.so>+0x20896d

and

  #0    0x00002357f60edb6d in acpi_rs_convert_aml_to_resource(struct acpi_resource*, union aml_resource*, struct acpi_rsconvert_info*) ../../third_party/acpica/source/components/resources/rsmisc.c:257 <platform-bus-x86.so>+0x2d0b6d
  #1.2  0x0000212756f4777f in ubsan_get_stack_trace() compiler-rt/lib/ubsan/ubsan_diag.cpp:41 <libclang_rt.asan.so>+0x3d77f
  #1.1  0x0000212756f4777f in maybe_print_stack_trace() compiler-rt/lib/ubsan/ubsan_diag.cpp:51 <libclang_rt.asan.so>+0x3d77f
  #1    0x0000212756f4777f in ~scoped_report() compiler-rt/lib/ubsan/ubsan_diag.cpp:387 <libclang_rt.asan.so>+0x3d77f
  #2    0x0000212756f48385 in handletype_mismatch_impl() compiler-rt/lib/ubsan/ubsan_handlers.cpp:137 <libclang_rt.asan.so>+0x3e385
  #3    0x0000212756f47ead in compiler-rt/lib/ubsan/ubsan_handlers.cpp:142 <libclang_rt.asan.so>+0x3dead
  #4    0x00002357f60edb6d in acpi_rs_convert_aml_to_resource(struct acpi_resource*, union aml_resource*, struct acpi_rsconvert_info*) ../../third_party/acpica/source/components/resources/rsmisc.c:257 <platform-bus-x86.so>+0x2d0b6d
  #5    0x00002357f60ea5a9 in acpi_rs_convert_aml_to_resources(u8*, u32, u32, u8, void**) ../../third_party/acpica/source/components/resources/rslist.c:137 <platform-bus-x86.so>+0x2cd5a9
  #6    0x00002357f6113d09 in acpi_ut_walk_aml_resources(struct acpi_walk_state*, u8*, acpi_size, acpi_walk_aml_callback, void**) ../../third_party/acpica/source/components/utilities/utresrc.c:234 <platform-bus-x86.so>+0x2f6d09
  #7    0x00002357f60e5806 in acpi_rs_create_resource_list(union acpi_operand_object*, struct acpi_buffer*) ../../third_party/acpica/source/components/resources/rscreate.c:199 <platform-bus-x86.so>+0x2c8806
  #8    0x00002357f60f0e52 in acpi_rs_get_method_data(acpi_handle, const char*, struct acpi_buffer*) ../../third_party/acpica/source/components/resources/rsutils.c:770 <platform-bus-x86.so>+0x2d3e52
  #9    0x00002357f60f11cd in acpi_walk_resources(acpi_handle, char*, acpi_walk_resource_callback, void*) ../../third_party/acpica/source/components/resources/rsxface.c:731 <platform-bus-x86.so>+0x2d41cd
  #10   0x00002357f5f08d48 in acpi::acpi_impl::walk_resources(acpi::acpi_impl*, acpi_handle, const char*, acpi::Acpi::resources_callable) ../../src/devices/board/lib/acpi/acpi-impl.cc:41 <platform-bus-x86.so>+0xebd48
  #11   0x00002357f5f0e94d in acpi::device_builder::gather_resources(acpi::device_builder*, acpi::Acpi*, fidl::any_arena&, acpi::Manager*, acpi::device_builder::gather_resources_callback) ../../src/devices/board/lib/acpi/device-builder.cc:52 <platform-bus-x86.so>+0xf194d
  #12   0x00002357f5f9aaf2 in acpi::Manager::configure_discovered_devices(acpi::Manager*) ../../src/devices/board/lib/acpi/manager.cc:75 <platform-bus-x86.so>+0x17daf2
  #13   0x00002357f5ec2b44 in publish_acpi_devices(acpi::Manager*, zx_device_t*, zx_device_t*) ../../src/devices/board/drivers/x86/acpi-nswalk.cc:102 <platform-bus-x86.so>+0xa5b44
  #14   0x00002357f5ed46f7 in x86::X86::do_init(x86::X86*) ../../src/devices/board/drivers/x86/x86.cc:65 <platform-bus-x86.so>+0xb76f7
  #15.1 0x00002357f5ede8ea in λ(x86::X86::ddk_init::(anon class)*) ../../src/devices/board/drivers/x86/x86.cc:82 <platform-bus-x86.so>+0xc18ea
  #15   0x00002357f5ede8ea in fit::internal::target<(lambda at../../src/devices/board/drivers/x86/x86.cc:81:19), false, false, void>::invoke(void*) ../../sdk/lib/fit/include/lib/fit/internal/function.h:181 <platform-bus-x86.so>+0xc18ea
  #16.2 0x00002357f61237cc in fit::internal::function_base<16UL, false, void()>::invoke(const fit::internal::function_base<16UL, false, void ()>*) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <platform-bus-x86.so>+0x3067cc
  #16.1 0x00002357f61237cc in fit::function_impl<16UL, false, void()>::operator()(const fit::function_impl<16UL, false, void ()>*) ../../sdk/lib/fit/include/lib/fit/function.h:300 <platform-bus-x86.so>+0x3067cc
  #16   0x00002357f61237cc in async::internal::retained_task::Handler(async_dispatcher_t*, async_task_t*, zx_status_t) ../../zircon/system/ulib/async/task.cc:25 <platform-bus-x86.so>+0x3067cc
  #17.1 0x000023df096b1d91 in λ(const driver_runtime::Dispatcher::post_task::(anon class)*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, zx_status_t) ../../src/devices/bin/driver_runtime/dispatcher.cc:715 <libdriver_runtime.so>+0x4bd91
  #17   0x000023df096b1d91 in fit::internal::target<(lambda at../../src/devices/bin/driver_runtime/dispatcher.cc:714:7), true, false, void, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int>::invoke(void*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/internal/function.h:128 <libdriver_runtime.so>+0x4bd91
  #18   0x000023df096aabc9 in fit::internal::function_base<24UL, true, void(std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int)>::invoke(const fit::internal::function_base<24UL, true, void (std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int)>*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <libdriver_runtime.so>+0x44bc9
  #19   0x000023df096aa8dd in fit::callback_impl<24UL, true, void(std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int)>::operator()(fit::callback_impl<24UL, true, void (std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int)>*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/function.h:451 <libdriver_runtime.so>+0x448dd
  #20   0x000023df0969b6a6 in driver_runtime::callback_request::Call(driver_runtime::callback_request*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, zx_status_t) ../../src/devices/bin/driver_runtime/callback_request.h:67 <libdriver_runtime.so>+0x356a6
  #21   0x000023df096a24c8 in driver_runtime::Dispatcher::dispatch_callback(driver_runtime::Dispatcher*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >) ../../src/devices/bin/driver_runtime/dispatcher.cc:1093 <libdriver_runtime.so>+0x3c4c8
  #22   0x000023df096a32c1 in driver_runtime::Dispatcher::dispatch_callbacks(driver_runtime::Dispatcher*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../src/devices/bin/driver_runtime/dispatcher.cc:1169 <libdriver_runtime.so>+0x3d2c1
  #23.1 0x000023df096ae81e in λ(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>, const driver_runtime::Dispatcher::create_with_adder::(anon class)*) ../../src/devices/bin/driver_runtime/dispatcher.cc:338 <libdriver_runtime.so>+0x4881e
  #23   0x000023df096ae81e in fit::internal::target<(lambda at../../src/devices/bin/driver_runtime/dispatcher.cc:337:7), true, false, void, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>>::invoke(void*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/internal/function.h:128 <libdriver_runtime.so>+0x4881e
  #24   0x000023df096aae7e in fit::internal::function_base<8UL, true, void(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>)>::invoke(const fit::internal::function_base<8UL, true, void (std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>)>*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <libdriver_runtime.so>+0x44e7e
  #25.1 0x000023df096a4964 in fit::function_impl<8UL, true, void(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>)>::operator()(const fit::function_impl<8UL, true, void (std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>)>*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/function.h:300 <libdriver_runtime.so>+0x3e964
  #25   0x000023df096a4964 in driver_runtime::Dispatcher::event_waiter::invoke_callback(driver_runtime::Dispatcher::event_waiter*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../src/devices/bin/driver_runtime/dispatcher.h:299 <libdriver_runtime.so>+0x3e964
  #26   0x000023df096a435d in driver_runtime::Dispatcher::event_waiter::handle_event(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, async_dispatcher_t*, async::wait_base*, zx_status_t, zx_packet_signal_t const*) ../../src/devices/bin/driver_runtime/dispatcher.cc:1259 <libdriver_runtime.so>+0x3e35d
  #27.1 0x000023df096aec00 in async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>::handle_event(async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>*, zx_status_t, zx_packet_signal_t const*, async_dispatcher_t*, async::wait_base*) ../../src/devices/bin/driver_runtime/async_loop_owned_event_handler.h:59 <libdriver_runtime.so>+0x48c00
  #27   0x000023df096aec00 in async::wait_method<async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>, &async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>::handle_event>::call_handler(async_dispatcher_t*, async_wait_t*, zx_status_t, zx_packet_signal_t const*) ../../zircon/system/ulib/async/include/lib/async/cpp/wait.h:201 <libdriver_runtime.so>+0x48c00
  #28.1 0x000023df096d0ead in async_loop_run_once(async_loop_t*, zx_time_t) ../../zircon/system/ulib/async-loop/loop.c:415 <libdriver_runtime.so>+0x6aead
  #28   0x000023df096d0ead in async_loop_run(async_loop_t*, zx_time_t, _Bool) ../../zircon/system/ulib/async-loop/loop.c:288 <libdriver_runtime.so>+0x6aead
  #29   0x000023df096d278f in async_loop_run_thread(void*) ../../zircon/system/ulib/async-loop/loop.c:840 <libdriver_runtime.so>+0x6c78f
  #30   0x0000424c7690eedc in start_c11(void*) ../../zircon/third_party/ulib/musl/pthread/pthread_create.c:55 <libc.so>+0xd7edc
  #31   0x0000424c76a3f96d in thread_trampoline(uintptr_t, uintptr_t) ../../zircon/system/ulib/runtime/thread.cc:100 <libc.so>+0x20896d

and

  #0    0x000020883e0b9c01 in acpi_rs_convert_aml_to_resource(struct acpi_resource*, union aml_resource*, struct acpi_rsconvert_info*) ../../third_party/acpica/source/components/resources/rsmisc.c:334 <platform-bus-x86.so>+0x2d0c01
  #1.2  0x000022cae2d8677f in ubsan_get_stack_trace() compiler-rt/lib/ubsan/ubsan_diag.cpp:41 <libclang_rt.asan.so>+0x3d77f
  #1.1  0x000022cae2d8677f in maybe_print_stack_trace() compiler-rt/lib/ubsan/ubsan_diag.cpp:51 <libclang_rt.asan.so>+0x3d77f
  #1    0x000022cae2d8677f in ~scoped_report() compiler-rt/lib/ubsan/ubsan_diag.cpp:387 <libclang_rt.asan.so>+0x3d77f
  #2    0x000022cae2d87385 in handletype_mismatch_impl() compiler-rt/lib/ubsan/ubsan_handlers.cpp:137 <libclang_rt.asan.so>+0x3e385
  #3    0x000022cae2d86ead in compiler-rt/lib/ubsan/ubsan_handlers.cpp:142 <libclang_rt.asan.so>+0x3dead
  #4    0x000020883e0b9c01 in acpi_rs_convert_aml_to_resource(struct acpi_resource*, union aml_resource*, struct acpi_rsconvert_info*) ../../third_party/acpica/source/components/resources/rsmisc.c:334 <platform-bus-x86.so>+0x2d0c01
  #5    0x000020883e0b65a9 in acpi_rs_convert_aml_to_resources(u8*, u32, u32, u8, void**) ../../third_party/acpica/source/components/resources/rslist.c:137 <platform-bus-x86.so>+0x2cd5a9
  #6    0x000020883e0dfd89 in acpi_ut_walk_aml_resources(struct acpi_walk_state*, u8*, acpi_size, acpi_walk_aml_callback, void**) ../../third_party/acpica/source/components/utilities/utresrc.c:234 <platform-bus-x86.so>+0x2f6d89
  #7    0x000020883e0b1806 in acpi_rs_create_resource_list(union acpi_operand_object*, struct acpi_buffer*) ../../third_party/acpica/source/components/resources/rscreate.c:199 <platform-bus-x86.so>+0x2c8806
  #8    0x000020883e0bced2 in acpi_rs_get_method_data(acpi_handle, const char*, struct acpi_buffer*) ../../third_party/acpica/source/components/resources/rsutils.c:770 <platform-bus-x86.so>+0x2d3ed2
  #9    0x000020883e0bd24d in acpi_walk_resources(acpi_handle, char*, acpi_walk_resource_callback, void*) ../../third_party/acpica/source/components/resources/rsxface.c:731 <platform-bus-x86.so>+0x2d424d
  #10   0x000020883ded4d48 in acpi::acpi_impl::walk_resources(acpi::acpi_impl*, acpi_handle, const char*, acpi::Acpi::resources_callable) ../../src/devices/board/lib/acpi/acpi-impl.cc:41 <platform-bus-x86.so>+0xebd48
  #11   0x000020883deda94d in acpi::device_builder::gather_resources(acpi::device_builder*, acpi::Acpi*, fidl::any_arena&, acpi::Manager*, acpi::device_builder::gather_resources_callback) ../../src/devices/board/lib/acpi/device-builder.cc:52 <platform-bus-x86.so>+0xf194d
  #12   0x000020883df66af2 in acpi::Manager::configure_discovered_devices(acpi::Manager*) ../../src/devices/board/lib/acpi/manager.cc:75 <platform-bus-x86.so>+0x17daf2
  #13   0x000020883de8eb44 in publish_acpi_devices(acpi::Manager*, zx_device_t*, zx_device_t*) ../../src/devices/board/drivers/x86/acpi-nswalk.cc:102 <platform-bus-x86.so>+0xa5b44
  #14   0x000020883dea06f7 in x86::X86::do_init(x86::X86*) ../../src/devices/board/drivers/x86/x86.cc:65 <platform-bus-x86.so>+0xb76f7
  #15.1 0x000020883deaa8ea in λ(x86::X86::ddk_init::(anon class)*) ../../src/devices/board/drivers/x86/x86.cc:82 <platform-bus-x86.so>+0xc18ea
  #15   0x000020883deaa8ea in fit::internal::target<(lambda at../../src/devices/board/drivers/x86/x86.cc:81:19), false, false, void>::invoke(void*) ../../sdk/lib/fit/include/lib/fit/internal/function.h:181 <platform-bus-x86.so>+0xc18ea
  #16.2 0x000020883e0ef84c in fit::internal::function_base<16UL, false, void()>::invoke(const fit::internal::function_base<16UL, false, void ()>*) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <platform-bus-x86.so>+0x30684c
  #16.1 0x000020883e0ef84c in fit::function_impl<16UL, false, void()>::operator()(const fit::function_impl<16UL, false, void ()>*) ../../sdk/lib/fit/include/lib/fit/function.h:300 <platform-bus-x86.so>+0x30684c
  #16   0x000020883e0ef84c in async::internal::retained_task::Handler(async_dispatcher_t*, async_task_t*, zx_status_t) ../../zircon/system/ulib/async/task.cc:25 <platform-bus-x86.so>+0x30684c
  #17.1 0x000021ae7c20cd91 in λ(const driver_runtime::Dispatcher::post_task::(anon class)*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, zx_status_t) ../../src/devices/bin/driver_runtime/dispatcher.cc:715 <libdriver_runtime.so>+0x4bd91
  #17   0x000021ae7c20cd91 in fit::internal::target<(lambda at../../src/devices/bin/driver_runtime/dispatcher.cc:714:7), true, false, void, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int>::invoke(void*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/internal/function.h:128 <libdriver_runtime.so>+0x4bd91
  #18   0x000021ae7c205bc9 in fit::internal::function_base<24UL, true, void(std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int)>::invoke(const fit::internal::function_base<24UL, true, void (std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int)>*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <libdriver_runtime.so>+0x44bc9
  #19   0x000021ae7c2058dd in fit::callback_impl<24UL, true, void(std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int)>::operator()(fit::callback_impl<24UL, true, void (std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int)>*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/function.h:451 <libdriver_runtime.so>+0x448dd
  #20   0x000021ae7c1f66a6 in driver_runtime::callback_request::Call(driver_runtime::callback_request*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, zx_status_t) ../../src/devices/bin/driver_runtime/callback_request.h:67 <libdriver_runtime.so>+0x356a6
  #21   0x000021ae7c1fd4c8 in driver_runtime::Dispatcher::dispatch_callback(driver_runtime::Dispatcher*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >) ../../src/devices/bin/driver_runtime/dispatcher.cc:1093 <libdriver_runtime.so>+0x3c4c8
  #22   0x000021ae7c1fe2c1 in driver_runtime::Dispatcher::dispatch_callbacks(driver_runtime::Dispatcher*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../src/devices/bin/driver_runtime/dispatcher.cc:1169 <libdriver_runtime.so>+0x3d2c1
  #23.1 0x000021ae7c20981e in λ(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>, const driver_runtime::Dispatcher::create_with_adder::(anon class)*) ../../src/devices/bin/driver_runtime/dispatcher.cc:338 <libdriver_runtime.so>+0x4881e
  #23   0x000021ae7c20981e in fit::internal::target<(lambda at../../src/devices/bin/driver_runtime/dispatcher.cc:337:7), true, false, void, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>>::invoke(void*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/internal/function.h:128 <libdriver_runtime.so>+0x4881e
  #24   0x000021ae7c205e7e in fit::internal::function_base<8UL, true, void(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>)>::invoke(const fit::internal::function_base<8UL, true, void (std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>)>*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <libdriver_runtime.so>+0x44e7e
  #25.1 0x000021ae7c1ff964 in fit::function_impl<8UL, true, void(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>)>::operator()(const fit::function_impl<8UL, true, void (std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>)>*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/function.h:300 <libdriver_runtime.so>+0x3e964
  #25   0x000021ae7c1ff964 in driver_runtime::Dispatcher::event_waiter::invoke_callback(driver_runtime::Dispatcher::event_waiter*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../src/devices/bin/driver_runtime/dispatcher.h:299 <libdriver_runtime.so>+0x3e964
  #26   0x000021ae7c1ff35d in driver_runtime::Dispatcher::event_waiter::handle_event(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, async_dispatcher_t*, async::wait_base*, zx_status_t, zx_packet_signal_t const*) ../../src/devices/bin/driver_runtime/dispatcher.cc:1259 <libdriver_runtime.so>+0x3e35d
  #27.1 0x000021ae7c209c00 in async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>::handle_event(async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>*, zx_status_t, zx_packet_signal_t const*, async_dispatcher_t*, async::wait_base*) ../../src/devices/bin/driver_runtime/async_loop_owned_event_handler.h:59 <libdriver_runtime.so>+0x48c00
  #27   0x000021ae7c209c00 in async::wait_method<async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>, &async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>::handle_event>::call_handler(async_dispatcher_t*, async_wait_t*, zx_status_t, zx_packet_signal_t const*) ../../zircon/system/ulib/async/include/lib/async/cpp/wait.h:201 <libdriver_runtime.so>+0x48c00
  #28.1 0x000021ae7c22bead in async_loop_run_once(async_loop_t*, zx_time_t) ../../zircon/system/ulib/async-loop/loop.c:415 <libdriver_runtime.so>+0x6aead
  #28   0x000021ae7c22bead in async_loop_run(async_loop_t*, zx_time_t, _Bool) ../../zircon/system/ulib/async-loop/loop.c:288 <libdriver_runtime.so>+0x6aead
  #29   0x000021ae7c22d78f in async_loop_run_thread(void*) ../../zircon/system/ulib/async-loop/loop.c:840 <libdriver_runtime.so>+0x6c78f
  #30   0x000042b2518e3edc in start_c11(void*) ../../zircon/third_party/ulib/musl/pthread/pthread_create.c:55 <libc.so>+0xd7edc
  #31   0x000042b251a1496d in thread_trampoline(uintptr_t, uintptr_t) ../../zircon/system/ulib/runtime/thread.cc:100 <libc.so>+0x20896d

Link: https://github.com/acpica/acpica/commit/b3317239
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/rsmisc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/rsmisc.c b/drivers/acpi/acpica/rsmisc.c
index c2dd9aae4745..6e8e98cf598d 100644
--- a/drivers/acpi/acpica/rsmisc.c
+++ b/drivers/acpi/acpica/rsmisc.c
@@ -194,7 +194,8 @@ acpi_rs_convert_aml_to_resource(struct acpi_resource *resource,
 
 		case ACPI_RSC_COUNT_SERIAL_VEN:
 
-			item_count = ACPI_GET16(source) - info->value;
+			ACPI_MOVE_16_TO_16(&temp16, source);
+			item_count = temp16 - info->value;
 
 			resource->length = resource->length + item_count;
 			ACPI_SET16(destination, item_count);
@@ -202,9 +203,10 @@ acpi_rs_convert_aml_to_resource(struct acpi_resource *resource,
 
 		case ACPI_RSC_COUNT_SERIAL_RES:
 
+			ACPI_MOVE_16_TO_16(&temp16, source);
 			item_count = (aml_resource_length +
 				      sizeof(struct aml_resource_large_header))
-			    - ACPI_GET16(source) - info->value;
+			    - temp16 - info->value;
 
 			resource->length = resource->length + item_count;
 			ACPI_SET16(destination, item_count);
@@ -289,9 +291,9 @@ acpi_rs_convert_aml_to_resource(struct acpi_resource *resource,
 
 			/* Copy the resource_source string */
 
+			ACPI_MOVE_16_TO_16(&temp16, source);
 			source =
-			    ACPI_ADD_PTR(void, aml,
-					 (ACPI_GET16(source) + info->value));
+			    ACPI_ADD_PTR(void, aml, (temp16 + info->value));
 			acpi_rs_move_data(target, source, item_count,
 					  info->opcode);
 			break;
-- 
2.35.3





