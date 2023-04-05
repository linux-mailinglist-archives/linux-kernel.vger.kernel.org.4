Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950306D7E68
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238378AbjDEOCo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Apr 2023 10:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238156AbjDEOBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:01:51 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FF46A64;
        Wed,  5 Apr 2023 07:01:05 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 47d973e81acfa915; Wed, 5 Apr 2023 16:01:03 +0200
Received: from kreacher.localnet (unknown [213.134.163.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 0248C1B4E9E1;
        Wed,  5 Apr 2023 16:01:01 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 17/32] ACPICA: Avoid undefined behavior: member access within misaligned address
Date:   Wed, 05 Apr 2023 15:45:45 +0200
Message-ID: <2176684.Icojqenx9y@kreacher>
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

ACPICA commit 60cbb20c009fd67e7b973d67b5dcb4a7b12681d9

Before this change we see the following UBSAN stack traces in Fuchsia:

  #0    0x0000219ce3426bd7 in acpi_rs_get_list_length(u8*, u32, acpi_size*) ../../third_party/acpica/source/components/resources/rscalc.c:631 <platform-bus-x86.so>+0x2cbbd7
  #1.2  0x00002240d84b077f in ubsan_get_stack_trace() compiler-rt/lib/ubsan/ubsan_diag.cpp:41 <libclang_rt.asan.so>+0x3d77f
  #1.1  0x00002240d84b077f in maybe_print_stack_trace() compiler-rt/lib/ubsan/ubsan_diag.cpp:51 <libclang_rt.asan.so>+0x3d77f
  #1    0x00002240d84b077f in ~scoped_report() compiler-rt/lib/ubsan/ubsan_diag.cpp:387 <libclang_rt.asan.so>+0x3d77f
  #2    0x00002240d84b1385 in handletype_mismatch_impl() compiler-rt/lib/ubsan/ubsan_handlers.cpp:137 <libclang_rt.asan.so>+0x3e385
  #3    0x00002240d84b0ead in compiler-rt/lib/ubsan/ubsan_handlers.cpp:142 <libclang_rt.asan.so>+0x3dead
  #4    0x0000219ce3426bd7 in acpi_rs_get_list_length(u8*, u32, acpi_size*) ../../third_party/acpica/source/components/resources/rscalc.c:631 <platform-bus-x86.so>+0x2cbbd7
  #5    0x0000219ce3423777 in acpi_rs_create_resource_list(union acpi_operand_object*, struct acpi_buffer*) ../../third_party/acpica/source/components/resources/rscreate.c:178 <platform-bus-x86.so>+0x2c8777
  #6    0x0000219ce342f1b2 in acpi_rs_get_method_data(acpi_handle, const char*, struct acpi_buffer*) ../../third_party/acpica/source/components/resources/rsutils.c:770 <platform-bus-x86.so>+0x2d41b2
  #7    0x0000219ce342f52d in acpi_walk_resources(acpi_handle, char*, acpi_walk_resource_callback, void*) ../../third_party/acpica/source/components/resources/rsxface.c:731 <platform-bus-x86.so>+0x2d452d
  #8    0x0000219ce3246d48 in acpi::acpi_impl::walk_resources(acpi::acpi_impl*, acpi_handle, const char*, acpi::Acpi::resources_callable) ../../src/devices/board/lib/acpi/acpi-impl.cc:41 <platform-bus-x86.so>+0xebd48
  #9    0x0000219ce324c94d in acpi::device_builder::gather_resources(acpi::device_builder*, acpi::Acpi*, fidl::any_arena&, acpi::Manager*, acpi::device_builder::gather_resources_callback) ../../src/devices/board/lib/acpi/device-builder.cc:52 <platform-bus-x86.so>+0xf194d
  #10   0x0000219ce32d8af2 in acpi::Manager::configure_discovered_devices(acpi::Manager*) ../../src/devices/board/lib/acpi/manager.cc:75 <platform-bus-x86.so>+0x17daf2
  #11   0x0000219ce3200b44 in publish_acpi_devices(acpi::Manager*, zx_device_t*, zx_device_t*) ../../src/devices/board/drivers/x86/acpi-nswalk.cc:102 <platform-bus-x86.so>+0xa5b44
  #12   0x0000219ce32126f7 in x86::X86::do_init(x86::X86*) ../../src/devices/board/drivers/x86/x86.cc:65 <platform-bus-x86.so>+0xb76f7
  #13.1 0x0000219ce321c8ea in λ(x86::X86::ddk_init::(anon class)*) ../../src/devices/board/drivers/x86/x86.cc:82 <platform-bus-x86.so>+0xc18ea
  #13   0x0000219ce321c8ea in fit::internal::target<(lambda at../../src/devices/board/drivers/x86/x86.cc:81:19), false, false, void>::invoke(void*) ../../sdk/lib/fit/include/lib/fit/internal/function.h:181 <platform-bus-x86.so>+0xc18ea
  #14.2 0x0000219ce3461b2c in fit::internal::function_base<16UL, false, void()>::invoke(const fit::internal::function_base<16UL, false, void ()>*) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <platform-bus-x86.so>+0x306b2c
  #14.1 0x0000219ce3461b2c in fit::function_impl<16UL, false, void()>::operator()(const fit::function_impl<16UL, false, void ()>*) ../../sdk/lib/fit/include/lib/fit/function.h:300 <platform-bus-x86.so>+0x306b2c
  #14   0x0000219ce3461b2c in async::internal::retained_task::Handler(async_dispatcher_t*, async_task_t*, zx_status_t) ../../zircon/system/ulib/async/task.cc:25 <platform-bus-x86.so>+0x306b2c
  #15.1 0x000022cc55016d91 in λ(const driver_runtime::Dispatcher::post_task::(anon class)*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, zx_status_t) ../../src/devices/bin/driver_runtime/dispatcher.cc:715 <libdriver_runtime.so>+0x4bd91
  #15   0x000022cc55016d91 in fit::internal::target<(lambda at../../src/devices/bin/driver_runtime/dispatcher.cc:714:7), true, false, void, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int>::invoke(void*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/internal/function.h:128 <libdriver_runtime.so>+0x4bd91
  #16   0x000022cc5500fbc9 in fit::internal::function_base<24UL, true, void(std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int)>::invoke(const fit::internal::function_base<24UL, true, void (std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int)>*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <libdriver_runtime.so>+0x44bc9
  #17   0x000022cc5500f8dd in fit::callback_impl<24UL, true, void(std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int)>::operator()(fit::callback_impl<24UL, true, void (std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int)>*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/function.h:451 <libdriver_runtime.so>+0x448dd
  #18   0x000022cc550006a6 in driver_runtime::callback_request::Call(driver_runtime::callback_request*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, zx_status_t) ../../src/devices/bin/driver_runtime/callback_request.h:67 <libdriver_runtime.so>+0x356a6
  #19   0x000022cc550074c8 in driver_runtime::Dispatcher::dispatch_callback(driver_runtime::Dispatcher*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >) ../../src/devices/bin/driver_runtime/dispatcher.cc:1093 <libdriver_runtime.so>+0x3c4c8
  #20   0x000022cc550082c1 in driver_runtime::Dispatcher::dispatch_callbacks(driver_runtime::Dispatcher*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../src/devices/bin/driver_runtime/dispatcher.cc:1169 <libdriver_runtime.so>+0x3d2c1
  #21.1 0x000022cc5501381e in λ(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>, const driver_runtime::Dispatcher::create_with_adder::(anon class)*) ../../src/devices/bin/driver_runtime/dispatcher.cc:338 <libdriver_runtime.so>+0x4881e
  #21   0x000022cc5501381e in fit::internal::target<(lambda at../../src/devices/bin/driver_runtime/dispatcher.cc:337:7), true, false, void, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>>::invoke(void*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/internal/function.h:128 <libdriver_runtime.so>+0x4881e
  #22   0x000022cc5500fe7e in fit::internal::function_base<8UL, true, void(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>)>::invoke(const fit::internal::function_base<8UL, true, void (std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>)>*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <libdriver_runtime.so>+0x44e7e
  #23.1 0x000022cc55009964 in fit::function_impl<8UL, true, void(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>)>::operator()(const fit::function_impl<8UL, true, void (std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>)>*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/function.h:300 <libdriver_runtime.so>+0x3e964
  #23   0x000022cc55009964 in driver_runtime::Dispatcher::event_waiter::invoke_callback(driver_runtime::Dispatcher::event_waiter*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../src/devices/bin/driver_runtime/dispatcher.h:299 <libdriver_runtime.so>+0x3e964
  #24   0x000022cc5500935d in driver_runtime::Dispatcher::event_waiter::handle_event(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, async_dispatcher_t*, async::wait_base*, zx_status_t, zx_packet_signal_t const*) ../../src/devices/bin/driver_runtime/dispatcher.cc:1259 <libdriver_runtime.so>+0x3e35d
  #25.1 0x000022cc55013c00 in async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>::handle_event(async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>*, zx_status_t, zx_packet_signal_t const*, async_dispatcher_t*, async::wait_base*) ../../src/devices/bin/driver_runtime/async_loop_owned_event_handler.h:59 <libdriver_runtime.so>+0x48c00
  #25   0x000022cc55013c00 in async::wait_method<async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>, &async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>::handle_event>::call_handler(async_dispatcher_t*, async_wait_t*, zx_status_t, zx_packet_signal_t const*) ../../zircon/system/ulib/async/include/lib/async/cpp/wait.h:201 <libdriver_runtime.so>+0x48c00
  #26.1 0x000022cc55035ead in async_loop_run_once(async_loop_t*, zx_time_t) ../../zircon/system/ulib/async-loop/loop.c:415 <libdriver_runtime.so>+0x6aead
  #26   0x000022cc55035ead in async_loop_run(async_loop_t*, zx_time_t, _Bool) ../../zircon/system/ulib/async-loop/loop.c:288 <libdriver_runtime.so>+0x6aead
  #27   0x000022cc5503778f in async_loop_run_thread(void*) ../../zircon/system/ulib/async-loop/loop.c:840 <libdriver_runtime.so>+0x6c78f
  #28   0x000042d43f9f1edc in start_c11(void*) ../../zircon/third_party/ulib/musl/pthread/pthread_create.c:55 <libc.so>+0xd7edc
  #29   0x000042d43fb2296d in thread_trampoline(uintptr_t, uintptr_t) ../../zircon/system/ulib/runtime/thread.cc:100 <libc.so>+0x20896d

and

  #0    0x000022db2bfa3753 in acpi_rs_get_list_length(u8*, u32, acpi_size*) ../../third_party/acpica/source/components/resources/rscalc.c:704 <platform-bus-x86.so>+0x2cb753
  #1.2  0x000020c421f9777f in ubsan_get_stack_trace() compiler-rt/lib/ubsan/ubsan_diag.cpp:41 <libclang_rt.asan.so>+0x3d77f
  #1.1  0x000020c421f9777f in maybe_print_stack_trace() compiler-rt/lib/ubsan/ubsan_diag.cpp:51 <libclang_rt.asan.so>+0x3d77f
  #1    0x000020c421f9777f in ~scoped_report() compiler-rt/lib/ubsan/ubsan_diag.cpp:387 <libclang_rt.asan.so>+0x3d77f
  #2    0x000020c421f98385 in handletype_mismatch_impl() compiler-rt/lib/ubsan/ubsan_handlers.cpp:137 <libclang_rt.asan.so>+0x3e385
  #3    0x000020c421f97ead in compiler-rt/lib/ubsan/ubsan_handlers.cpp:142 <libclang_rt.asan.so>+0x3dead
  #4    0x000022db2bfa3753 in acpi_rs_get_list_length(u8*, u32, acpi_size*) ../../third_party/acpica/source/components/resources/rscalc.c:704 <platform-bus-x86.so>+0x2cb753
  #5    0x000022db2bfa0777 in acpi_rs_create_resource_list(union acpi_operand_object*, struct acpi_buffer*) ../../third_party/acpica/source/components/resources/rscreate.c:178 <platform-bus-x86.so>+0x2c8777
  #6    0x000022db2bfac0f2 in acpi_rs_get_method_data(acpi_handle, const char*, struct acpi_buffer*) ../../third_party/acpica/source/components/resources/rsutils.c:770 <platform-bus-x86.so>+0x2d40f2
  #7    0x000022db2bfac46d in acpi_walk_resources(acpi_handle, char*, acpi_walk_resource_callback, void*) ../../third_party/acpica/source/components/resources/rsxface.c:731 <platform-bus-x86.so>+0x2d446d
  #8    0x000022db2bdc3d48 in acpi::acpi_impl::walk_resources(acpi::acpi_impl*, acpi_handle, const char*, acpi::Acpi::resources_callable) ../../src/devices/board/lib/acpi/acpi-impl.cc:41 <platform-bus-x86.so>+0xebd48
  #9    0x000022db2bdc994d in acpi::device_builder::gather_resources(acpi::device_builder*, acpi::Acpi*, fidl::any_arena&, acpi::Manager*, acpi::device_builder::gather_resources_callback) ../../src/devices/board/lib/acpi/device-builder.cc:52 <platform-bus-x86.so>+0xf194d
  #10   0x000022db2be55af2 in acpi::Manager::configure_discovered_devices(acpi::Manager*) ../../src/devices/board/lib/acpi/manager.cc:75 <platform-bus-x86.so>+0x17daf2
  #11   0x000022db2bd7db44 in publish_acpi_devices(acpi::Manager*, zx_device_t*, zx_device_t*) ../../src/devices/board/drivers/x86/acpi-nswalk.cc:102 <platform-bus-x86.so>+0xa5b44
  #12   0x000022db2bd8f6f7 in x86::X86::do_init(x86::X86*) ../../src/devices/board/drivers/x86/x86.cc:65 <platform-bus-x86.so>+0xb76f7
  #13.1 0x000022db2bd998ea in λ(x86::X86::ddk_init::(anon class)*) ../../src/devices/board/drivers/x86/x86.cc:82 <platform-bus-x86.so>+0xc18ea
  #13   0x000022db2bd998ea in fit::internal::target<(lambda at../../src/devices/board/drivers/x86/x86.cc:81:19), false, false, void>::invoke(void*) ../../sdk/lib/fit/include/lib/fit/internal/function.h:181 <platform-bus-x86.so>+0xc18ea
  #14.2 0x000022db2bfdea6c in fit::internal::function_base<16UL, false, void()>::invoke(const fit::internal::function_base<16UL, false, void ()>*) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <platform-bus-x86.so>+0x306a6c
  #14.1 0x000022db2bfdea6c in fit::function_impl<16UL, false, void()>::operator()(const fit::function_impl<16UL, false, void ()>*) ../../sdk/lib/fit/include/lib/fit/function.h:300 <platform-bus-x86.so>+0x306a6c
  #14   0x000022db2bfdea6c in async::internal::retained_task::Handler(async_dispatcher_t*, async_task_t*, zx_status_t) ../../zircon/system/ulib/async/task.cc:25 <platform-bus-x86.so>+0x306a6c
  #15.1 0x0000216d819f2d91 in λ(const driver_runtime::Dispatcher::post_task::(anon class)*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, zx_status_t) ../../src/devices/bin/driver_runtime/dispatcher.cc:715 <libdriver_runtime.so>+0x4bd91
  #15   0x0000216d819f2d91 in fit::internal::target<(lambda at../../src/devices/bin/driver_runtime/dispatcher.cc:714:7), true, false, void, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int>::invoke(void*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/internal/function.h:128 <libdriver_runtime.so>+0x4bd91
  #16   0x0000216d819ebbc9 in fit::internal::function_base<24UL, true, void(std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int)>::invoke(const fit::internal::function_base<24UL, true, void (std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int)>*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <libdriver_runtime.so>+0x44bc9
  #17   0x0000216d819eb8dd in fit::callback_impl<24UL, true, void(std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request>>, int)>::operator()(fit::callback_impl<24UL, true, void (std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int)>*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib/fit/function.h:451 <libdriver_runtime.so>+0x448dd
  #18   0x0000216d819dc6a6 in driver_runtime::callback_request::Call(driver_runtime::callback_request*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >, zx_status_t) ../../src/devices/bin/driver_runtime/callback_request.h:67 <libdriver_runtime.so>+0x356a6
  #19   0x0000216d819e34c8 in driver_runtime::Dispatcher::dispatch_callback(driver_runtime::Dispatcher*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driver_runtime::callback_request> >) ../../src/devices/bin/driver_runtime/dispatcher.cc:1093 <libdriver_runtime.so>+0x3c4c8
  #20   0x0000216d819e42c1 in driver_runtime::Dispatcher::dispatch_callbacks(driver_runtime::Dispatcher*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../src/devices/bin/driver_runtime/dispatcher.cc:1169 <libdriver_runtime.so>+0x3d2c1
  #21.1 0x0000216d819ef81e in λ(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>, const driver_runtime::Dispatcher::create_with_adder::(anon class)*) ../../src/devices/bin/driver_runtime/dispatcher.cc:338 <libdriver_runtime.so>+0x4881e
  #21   0x0000216d819ef81e in fit::internal::target<(lambda at../../src/devices/bin/driver_runtime/dispatcher.cc:337:7), true, false, void, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>>::invoke(void*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/internal/function.h:128 <libdriver_runtime.so>+0x4881e
  #22   0x0000216d819ebe7e in fit::internal::function_base<8UL, true, void(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>)>::invoke(const fit::internal::function_base<8UL, true, void (std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>)>*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/internal/function.h:505 <libdriver_runtime.so>+0x44e7e
  #23.1 0x0000216d819e5964 in fit::function_impl<8UL, true, void(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime::Dispatcher>)>::operator()(const fit::function_impl<8UL, true, void (std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>)>*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/function.h:300 <libdriver_runtime.so>+0x3e964
  #23   0x0000216d819e5964 in driver_runtime::Dispatcher::event_waiter::invoke_callback(driver_runtime::Dispatcher::event_waiter*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../src/devices/bin/driver_runtime/dispatcher.h:299 <libdriver_runtime.so>+0x3e964
  #24   0x0000216d819e535d in driver_runtime::Dispatcher::event_waiter::handle_event(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, async_dispatcher_t*, async::wait_base*, zx_status_t, zx_packet_signal_t const*) ../../src/devices/bin/driver_runtime/dispatcher.cc:1259 <libdriver_runtime.so>+0x3e35d
  #25.1 0x0000216d819efc00 in async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>::handle_event(async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>*, zx_status_t, zx_packet_signal_t const*, async_dispatcher_t*, async::wait_base*) ../../src/devices/bin/driver_runtime/async_loop_owned_event_handler.h:59 <libdriver_runtime.so>+0x48c00
  #25   0x0000216d819efc00 in async::wait_method<async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>, &async_loop_owned_event_handler<driver_runtime::Dispatcher::event_waiter>::handle_event>::call_handler(async_dispatcher_t*, async_wait_t*, zx_status_t, zx_packet_signal_t const*) ../../zircon/system/ulib/async/include/lib/async/cpp/wait.h:201 <libdriver_runtime.so>+0x48c00
  #26.1 0x0000216d81a11ead in async_loop_run_once(async_loop_t*, zx_time_t) ../../zircon/system/ulib/async-loop/loop.c:415 <libdriver_runtime.so>+0x6aead
  #26   0x0000216d81a11ead in async_loop_run(async_loop_t*, zx_time_t, _Bool) ../../zircon/system/ulib/async-loop/loop.c:288 <libdriver_runtime.so>+0x6aead
  #27   0x0000216d81a1378f in async_loop_run_thread(void*) ../../zircon/system/ulib/async-loop/loop.c:840 <libdriver_runtime.so>+0x6c78f
  #28   0x0000417ba4b4bedc in start_c11(void*) ../../zircon/third_party/ulib/musl/pthread/pthread_create.c:55 <libc.so>+0xd7edc
  #29   0x0000417ba4c7c96d in thread_trampoline(uintptr_t, uintptr_t) ../../zircon/system/ulib/runtime/thread.cc:100 <libc.so>+0x20896d

Link: https://github.com/acpica/acpica/commit/60cbb20c
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/rscalc.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index ffb448fa51fd..6e7a152d6459 100644
--- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -606,15 +606,23 @@ acpi_rs_get_list_length(u8 *aml_buffer,
 			}
 			break;
 
-		case ACPI_RESOURCE_NAME_SERIAL_BUS:
+		case ACPI_RESOURCE_NAME_SERIAL_BUS:{
 
-			minimum_aml_resource_length =
-			    acpi_gbl_resource_aml_serial_bus_sizes
-			    [aml_resource->common_serial_bus.type];
-			extra_struct_bytes +=
-			    aml_resource->common_serial_bus.resource_length -
-			    minimum_aml_resource_length;
-			break;
+				/* Avoid undefined behavior: member access within misaligned address */
+
+				struct aml_resource_common_serialbus
+				    common_serial_bus;
+				memcpy(&common_serial_bus, aml_resource,
+				       sizeof(common_serial_bus));
+
+				minimum_aml_resource_length =
+				    acpi_gbl_resource_aml_serial_bus_sizes
+				    [common_serial_bus.type];
+				extra_struct_bytes +=
+				    common_serial_bus.resource_length -
+				    minimum_aml_resource_length;
+				break;
+			}
 
 		case ACPI_RESOURCE_NAME_PIN_CONFIG:
 
@@ -680,10 +688,16 @@ acpi_rs_get_list_length(u8 *aml_buffer,
 		 */
 		if (acpi_ut_get_resource_type(aml_buffer) ==
 		    ACPI_RESOURCE_NAME_SERIAL_BUS) {
+
+			/* Avoid undefined behavior: member access within misaligned address */
+
+			struct aml_resource_common_serialbus common_serial_bus;
+			memcpy(&common_serial_bus, aml_resource,
+			       sizeof(common_serial_bus));
+
 			buffer_size =
 			    acpi_gbl_resource_struct_serial_bus_sizes
-			    [aml_resource->common_serial_bus.type] +
-			    extra_struct_bytes;
+			    [common_serial_bus.type] + extra_struct_bytes;
 		} else {
 			buffer_size =
 			    acpi_gbl_resource_struct_sizes[resource_index] +
-- 
2.35.3





