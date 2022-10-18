Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577C6602E72
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiJRO2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJRO2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:28:41 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F9EC09A9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:28:39 -0700 (PDT)
Date:   Tue, 18 Oct 2022 07:28:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666103317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GDKQtD/pRyRFA5o6IwC0xTokKkT/xqo43cAFiLKEE8k=;
        b=PUJMLIwtGQQgfDXETYUg/77lODFCTK6fWltUuHSR91rzLgHf+gfL6bdmc66dpkDc5ubmWl
        heiYCwhug+RqsO0Sdj6xSKmps6BaraToSE/ZrmZzXNwkWc1koE8CtgFo7n215SWzztZag0
        ZLWtFT7+ntk3mTUk4xYCZLOV1mBApX4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kees Cook <kees.cook@linux.dev>
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
CC:     Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_ftrace=2Ckcfi=3A_Separate_f?= =?US-ASCII?Q?trace=5Fstub=28=29_and_ftrace=5Fstub=5Fgraph=28=29?=
In-Reply-To: <Y06ntk9uY5re23WX@hirez.programming.kicks-ass.net>
References: <Y06dg4e1xF6JTdQq@hirez.programming.kicks-ass.net> <Y06ntk9uY5re23WX@hirez.programming.kicks-ass.net>
Message-ID: <A41EBE43-40FE-482A-A795-B4A4F63C345C@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On October 18, 2022 6:18:46 AM PDT, Peter Zijlstra <peterz@infradead=2Eorg=
> wrote:
>On Tue, Oct 18, 2022 at 02:35:16PM +0200, Peter Zijlstra wrote:
>> --- a/include/asm-generic/vmlinux=2Elds=2Eh
>> +++ b/include/asm-generic/vmlinux=2Elds=2Eh
>> @@ -162,6 +162,16 @@
>>  #define PATCHABLE_DISCARDS	*(__patchable_function_entries)
>>  #endif
>> =20
>> +#ifndef ARCH_SUPPORTS_CFI_CLANG
>
>#ifndef CONFIG_ARCH_=2E=2E
>
>works much better as we found=2E

I nearly did this with an IS_ENABLED() recently=2E Saved by checkpatch! I =
wonder if it has similar checks for #ifdefs=2E=2E=2E

>
>> +/*
>> + * Simply points to ftrace_stub, but with the proper protocol=2E
>> + * Defined by the linker script in linux/vmlinux=2Elds=2Eh
>> + */
>> +#define	FTRACE_STUB_HACK	ftrace_stub_graph =3D ftrace_stub;
>> +#else
>> +#define FTRACE_STUB_HACK
>> +#endif
>
>Fixed up version available at:
>
>  git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/peterz/queue=2Egit x8=
6/urgent

Thanks for solving this! Just for future archeology, can you include the s=
plat (I assume you hit a CFI splat) in the commit log, and/or how you trigg=
ered the problem? I usually find it helpful in trying to fix similar issues=
 later, etc=2E

--=20
Kees Cook
