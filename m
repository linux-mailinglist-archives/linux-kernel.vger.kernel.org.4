Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F31964A3C3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 15:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiLLOxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 09:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbiLLOxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 09:53:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7A0B337
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 06:53:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F154B1FB;
        Mon, 12 Dec 2022 06:54:10 -0800 (PST)
Received: from [192.168.89.251] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D52E73F71E;
        Mon, 12 Dec 2022 06:53:28 -0800 (PST)
Message-ID: <6dda5e1d-9416-b55e-88f3-31d148bc925f@arm.com>
Date:   Mon, 12 Dec 2022 14:53:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [for-next][PATCH 02/11] tracing: Add __cpumask to denote a trace
 event field that is a cpumask_t
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        douglas.raillard@arm.com
References: <20221124145019.782980678@goodmis.org>
 <20221124145045.743308431@goodmis.org>
Content-Language: en-US
From:   Douglas Raillard <douglas.raillard@arm.com>
In-Reply-To: <20221124145045.743308431@goodmis.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-11-2022 14:50, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The trace events have a __bitmask field that can be used for anything
> that requires bitmasks. Although currently it is only used for CPU
> masks, it could be used in the future for any type of bitmasks.
> 
> There is some user space tooling that wants to know if a field is a CPU
> mask and not just some random unsigned long bitmask. Introduce
> "__cpumask()" helper functions that work the same as the current
> __bitmask() helpers but displays in the format file:
> 
>    field:__data_loc cpumask_t *[] mask;    offset:36;      size:4; signed:0;
> 
> Instead of:
> 
>    field:__data_loc unsigned long[] mask;  offset:32;      size:4; signed:0;
> 
> The main difference is the type. Instead of "unsigned long" it is
> "cpumask_t *". Note, this type field needs to be a real type in the
> __dynamic_array() logic that both __cpumask and__bitmask use, but the
> comparison field requires it to be a scalar type whereas cpumask_t is a
> structure (non-scalar). But everything works when making it a pointer.

How is tooling expected to distinguish between a real dynamic array of pointers
from a type that is using dynamic arrays as an "implementation detail"
with a broken type description ? Any reasonable
interpretation of that type by the consuming tool will be broken
unless it specifically knows about __data_loc cpumask*[].
However, the set of types using that trick is unbounded so forward
compatibilty is impossible to ensure. On top of that, an actual
dynamic array of cpumask pointers becomes impossible to represent.

You might object that if the tool does not know about cpumask,
it does not matter "how it breaks" as the display will be useless anyway,
but that is not true. A parsing library might just parse up to
its knowledge limit and return the most elaborate it can for a given field.
It's acceptable for that representation to not be elaborated with the full
semantic expected by the end user, but it should not return
something that is lying on its nature. For example, it would be sane for
the user to assert the size of an array of pointers to be a multiple
of a pointer size. cpumask is currently an array of unsigned long but there is
nothing preventing a similar type to be based on an array of u8.
Such a type would also have different endianness handling and the resulting buffer
would be garbage.


To fix that issue, I propose to expose the following to userspace:
1. The binary representation type (unsigned long[] in cpumask case).
2. An (ordered list of) semantic type that may or may not be the same as 1.

Type (1) can be used to guarantee correct handling of endianness and a reasonable
default display, while (2) allows any sort of fancy interpretation, all that while preserving
forward compatibility. For cpumask, this would give:
1. unsigned long []
2. bitmask, cpumask

A consumer could know about bitmask as they are likely used in multiple places,
but not about cpumask specifically (e.g. assuming cpumask is a type recently introduced).
Displaying as a list of bits set in the mask would already allow proper formatting, and
knowing it's actually a cpumask can allow fancier behaviors.

 From an event format perspective, this could preserve reasonable backward compat
by simply adding another property:

   field:__data_loc unsigned long[] mask;    offset:36;      size:4; signed:0; semantic_type:bitmask,cpumask;

By default, "semantic_type" would simply have the same value as the normal type.

This applies to any type, not just dynamic arrays.

Thanks,

Douglas
    

