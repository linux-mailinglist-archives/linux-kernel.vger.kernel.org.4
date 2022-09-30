Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664C75F1500
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbiI3Vg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 17:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiI3VgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:36:17 -0400
X-Greylist: delayed 443 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Sep 2022 14:36:07 PDT
Received: from smtpout.efficios.com (smtpout.efficios.com [IPv6:2607:5300:203:5aae::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4D61D1A7A;
        Fri, 30 Sep 2022 14:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1664573322;
        bh=IeElQUlqF64RPQi35fK61e7RZ3GuX2m6yr/3ebs/rc4=;
        h=Date:From:Subject:To:From;
        b=Agh/dY+Fli7Cp6Vpj3DRdbztMXGvWQ/LW9qjedpwWXi6VhHWNQ/vO3zhB1iG7JLud
         4YY3Qst5/vrheJL/f8kmFbEtv6jc5AEBAoh6zIDyg0xLgIFmp+LoTLqJ991EwRJ5MF
         GAKwVeNRhoH/j9EOrVv9i+wQNGcSaxbLnZrctnqP2FZHVzw9gfcmjZrKJOWlQPUc1W
         14ABRpYuOVHhBT+xE4pbd5qRSXpQB24HP+veB6MT+XjfJ0wckE9v3yPfQvM/PRicN8
         VSX4/szcwXHQb0BF9lCaFIXxgwn70vdOcKdw47FYM+KXhdrAlmMYT/420HaWebkR4j
         iDlyFZob/M1og==
Received: from [172.16.0.72] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4MfNdQ2M21zPK8;
        Fri, 30 Sep 2022 17:28:42 -0400 (EDT)
Message-ID: <e3b9a12a-4202-fe3f-dfd4-5a9c3753ee6b@efficios.com>
Date:   Fri, 30 Sep 2022 17:29:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-modules 2.13.7, 2.12.11 and LTTng-UST 2.13.5, 2.12.7
To:     lttng-dev@lists.lttng.org,
        Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-trace-users <linux-trace-users@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These bug fix releases of the LTTng kernel and user-space tracers 
contain security fixes which address memory disclosure and denial of 
service issues. Those are of relatively low severity mainly because they 
involve specific uses of the tracer by users that belong to the 
`tracing` group.

Here is the explanation of the impact for each issue corrected. The 
issues that have a security impact are tagged with [security].

The issues that were corrected in LTTng 2.12 were likely present in 
older versions, which are not maintained anymore. All users of 
LTTng-modules and LTTng-UST should upgrade.

* Kernel tracer (LTTng-modules) 2.13.7:

[security] A user belonging to the `tracing` group can use the event 
notification capture or the filtering features to target a userspace 
string (e.g. pathname input field of the openat system call) while any 
user on the system feeds an invalid pointer or a pointer to kernel 
memory to the instrumented system call. This results in a kernel OOPS in 
case of an invalid pointer, or disclosure of kernel memory to the 
tracing group if the pointer targets a kernel memory address. This is 
corrected by properly keeping track of user pointers and using the 
appropriate methods to access userspace memory.

[security] A user belonging to the `tracing` group can use the event 
notification capture or the filtering features to target a userspace 
array of integers (e.g. fildes output field of the pipe2 system call) 
while any user on the system feeds an invalid pointer or a pointer to 
kernel memory to the instrumented system call. This results in a kernel 
OOPS in case of an invalid pointer, or disclosure of kernel memory to 
the tracing group if the pointer targets a kernel memory address. This 
is corrected by properly keeping track of user pointers and using the 
appropriate methods to access userspace memory.

[security] A `tracing` group user crafting an ill-intended event 
notification capture or filter bytecode can emit load and load-field-ref 
instructions which are already specialized for the wrong field type, 
thus bypassing the instruction selection performed by the bytecode 
linker and bytecode specialization phases. When combined with passing 
invalid or kernel memory pointers to userspace memory arguments (e.g. 
pathname input field of openat or fildes output field of pipe2), this 
can result in a kernel OOPS in case of an invalid pointer, or a 
disclosure of kernel memory to the tracing group if the pointer targets 
a kernel memory address. This is corrected by rejecting specialized load 
and load-field-ref instructions in the bytecode validation phase.

Event notification capture fields that end up using more than 512 bytes 
of msgpack buffer space for a single event notification emit warnings in 
the kernel console and result in a corrupted msgpack buffer. This is 
fixed by emitting a "NIL" msgpack field rather than the field that would 
require too much space.

When an event notification capture for a userspace string or a userspace 
integer triggers a page fault, emit a "NIL" msgpack field rather than an 
empty string or a zero-value integer.

Fix a kernel OOPS on powerpc64 when the lttng_tracer module initializes, 
because the do_get_kallsyms LTTng wrapper returns the address of the 
local entry point rather than the global entry point. This is corrected 
by adjusting the offset (+4 and then -4) to get the global entry point 
on PPC64_ELF_ABI_v2.


* Kernel tracer (LTTng-modules) 2.12.11:

[security] A user belonging to the `tracing` group can use the filtering 
feature to target a userspace array of integers (e.g. fildes output 
field of the pipe2 system call) while any user on the system feeds an 
invalid pointer or a pointer to kernel memory to the instrumented system 
call. This results in a kernel OOPS in case of an invalid pointer, or 
disclosure of kernel memory to the tracing group if the pointer targets 
a kernel memory address. This is corrected by properly keeping track of 
user pointers and using the appropriate methods to access userspace memory.

[security] A `tracing` group user crafting an ill-intended filter 
bytecode can emit load and load-field-ref instructions which are already 
specialized for the wrong field type, thus bypassing the instruction 
selection performed by the bytecode linker and bytecode specialization 
phases. When combined with passing invalid or kernel memory pointers to 
userspace memory arguments (e.g. pathname input field of openat or 
fildes output field of pipe2), this can result in a kernel OOPS in case 
of an invalid pointer, or a disclosure of kernel memory to the tracing 
group if the pointer targets a kernel memory address. This is corrected 
by rejecting specialized load and load-field-ref instructions in the 
bytecode validation phase.

Fix a kernel OOPS on powerpc64 when the lttng_tracer module initializes, 
because the do_get_kallsyms LTTng wrapper returns the address of the 
local entry point rather than the global entry point. This is corrected 
by adjusting the offset (+4 and then -4) to get the global entry point 
on PPC64_ELF_ABI_v2.

The filter bytecode interpreter leaves context field byte order 
uninitialized, which can cause erratic filtering behavior when targeting 
context fields. This is not currently observable because current 
lttng-tools do not currently emit BYTECODE_OP_GET_SYMBOL instructions to 
load the context value for filtering. Fix this by initializing the byte 
order field.


* Application tracer (LTTng-UST) 2.13.5:

[security] A `tracing` group user crafting an ill-intended event 
notification capture or filter bytecode can emit load and load-field-ref 
instructions which are already specialized for the wrong field type, 
thus bypassing the instruction selection performed by the bytecode 
linker and bytecode specialization phases. This can result in a 
disclosure of application memory to the tracing group if the type 
expected by the instrumentation is larger than the instrumented type, or 
application crash if a string is expected but the top of interpreter 
stack does not point to a valid address. This is corrected by rejecting 
specialized load and load-field-ref instructions in the bytecode 
validation phase.

Event notification capture fields that end up using more than the number 
of bytes allocated for the msgpack buffer space for a single event 
notification can cause the resulting msgpack buffer to be corrupted. 
This is fixed by emitting a "NIL" msgpack field rather than the field 
that would require too much space.

When getting the shared memory area at initialization time, wait(3) is 
used to wait on the forked child process to exit, which can cause the 
library to wait on any child process of the application. Use waitpid(3) 
instead to make sure the right child is waited for, and therefore don't 
wait for unrelated, unreaped, child processes.


* Application tracer (LTTng-UST) 2.12.7:

[security] A `tracing` group user crafting an ill-intended event 
notification capture or filter bytecode can emit load and load-field-ref 
instructions which are already specialized for the wrong field type, 
thus bypassing the instruction selection performed by the bytecode 
linker and bytecode specialization phases. This can result in a 
disclosure of application memory to the tracing group if the type 
expected by the instrumentation is larger than the instrumented type, or 
application crash if a string is expected but the top of interpreter 
stack does not point to a valid address. This is corrected by rejecting 
specialized load and load-field-ref instructions in the bytecode 
validation phase.

When getting the shared memory area at initialization time, wait(3) is 
used to wait on the forked child process to exit, which can cause the 
library to wait on any child process of the application. Use waitpid(3) 
instead to make sure the right child is waited for, and therefore don't 
wait for unrelated, unreaped, child processes.

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
