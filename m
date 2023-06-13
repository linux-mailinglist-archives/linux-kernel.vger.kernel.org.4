Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097C172D6E4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 03:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbjFMBax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 21:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjFMBau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:30:50 -0400
X-Greylist: delayed 456 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Jun 2023 18:30:49 PDT
Received: from out-59.mta0.migadu.com (out-59.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB79318E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 18:30:49 -0700 (PDT)
Message-ID: <6a2e8f05-ce2f-bbbb-e6ad-f9db524db997@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686619387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Az7NwX67Bf/1j76+8r8hc++AaCY3OLyQFY+NixwvQvo=;
        b=hz2mq9yqhmWY9nieZx4gzwS/YE9ZWGp0bHn91oSDu5eSjBRB9SRXnmvgpPAJubxIw+lad3
        15MT5ruvlPl+He8bSCbg1jwtPCIZyJwsmKxR+IgJJsr5SHdFcFZW+2c8DBNF6KZDPS50ba
        t/vgfYxefzC2GSqhuwsaeUuBww6SoFA=
Date:   Tue, 13 Jun 2023 09:22:41 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv2] ftrace: Show all functions with addresses in
 available_filter_functions_addrs
To:     Jiri Olsa <olsajiri@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Yonghong Song <yhs@meta.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
References: <20230611130029.1202298-1-jolsa@kernel.org>
 <53a11f31-256d-e7bc-eca5-597571076dc5@meta.com>
 <20230611225407.3e9b8ad2@gandalf.local.home>
 <20230611225754.01350a50@gandalf.local.home>
 <d5ffd64c-65b7-e28c-b8ee-0d2ff9dcd78b@meta.com>
 <20230612110222.50c254f3@gandalf.local.home> <ZId/UL/iujOdgel+@krava>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jackie Liu <liu.yun@linux.dev>
In-Reply-To: <ZId/UL/iujOdgel+@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/13 04:25, Jiri Olsa 写道:
> On Mon, Jun 12, 2023 at 11:02:22AM -0400, Steven Rostedt wrote:
>> On Mon, 12 Jun 2023 07:49:53 -0700
>> Yonghong Song <yhs@meta.com> wrote:
>>
>>> I am actually interested in how available_filter_functions_addrs
>>> will be used. For example, bpf_program__attach_kprobe_multi_opts()
>>> can already take addresses from kallsyms. How to use
>>> available_filter_functions_addrs to facilitate kprobe_multi?
> 
> the problem is that we need to do 2 passes:
> 
>   - through available_filter_functions and find out if the function is traceable
>   - through /proc/kallsyms to get the address for traceable function
> 
> having available_filter_functions symbols together with addresses allow
> us to skip the kallsyms step
> 
> and we are ok with the address in available_filter_functions_addr not being the
> function entry, because kprobe_multi uses fprobe and that handles both entry and
> patch-site address properly
> 
>>> Do we need to change kernel APIs? It would be great at least we
>>> got a RFC patch to answer these questions.
>>
>> I agree, having that information would also be useful to me.
>>
>> Jiri? Andrii?
> 
> so we have 2 interfaces how to create kprobe_multi link:
> 
>    a) passing symbols to kernel
> 
>       1) user gathers symbols and need to ensure that they are
>          trace-able -> pass through available_filter_functions file
> 
>       2) kernel takes those symbols and translates them to addresses
>          through kallsyms api
> 
>       3) addresses are passed to fprobe/ftrace through:
> 
>           register_fprobe_ips
>           -> ftrace_set_filter_ips
> 
>    b) passing addresses to kernel
> 
>       1) user gathers symbols and needs to ensure that they are
>          trace-able -> pass through available_filter_functions file
> 
>       2) user takes those symbols and translates them to addresses
>         through /proc/kallsyms
> 
>       3) addresses are passed to the kernel and kernel calls:
> 
>           register_fprobe_ips
>           -> ftrace_set_filter_ips
> 
> 
> The new available_filter_functions_addrs file helps us with option b),
> because we can make 'b 1' and 'b 2' in one step - while filtering traceable
> functions, we get the address directly.
> 
> I tested the new available_filter_functions_addrs changes with some hacked
> selftest changes, you can check it in here [1].
> 
> I assume Jackie Liu will send new version of her patchset [2] based on this
> new available_filter_functions_addrs file.

Yes, once the new interface is released, I will release a v2 version 
patch based on it.

-- 
Jackie Liu

> 
> I think we should have these changes coming together and add some perf
> measurements from before and after to make the benefit apparent.
> 
> jirka
> 
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?h=bpf/avail_addrs&id=fecaeeaf40bae034715ab2e9a46ca1dc16371e8e
> [2] https://lore.kernel.org/bpf/20230526155026.1419390-1-liu.yun@linux.dev/#r
