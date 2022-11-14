Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF4C627D4E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbiKNMFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235655AbiKNMFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:05:06 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811A71D9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:04:55 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id g12so17695490wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:04:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=URNeRLCaPIzG0hVTY7Yzc9GuRCdrvd8goEPcD9+3mQw=;
        b=hK77CAa425+gD3eEqd/ra9CgeyGHt4SqiUWZq+02Xe3A177TCM6cuLLlNOqABYXkGZ
         knZPm5jGxDhqL1xp6q4fj0AXXUCjTbPwHX93/wtMOBAp9nzrLfyc4Jsc++r1As70H+B0
         WywVGhVYsgxxqOyzeXhNFSaBAbhnS5Wb8h2eeU/EJ8m8SSDhDU65melV2EIzds6cHi39
         kxMQPxodqJYiSLtFbbHAjvhxzdE4BrxYREj3ui8WMXIdkpLJLMqZq+RNVdeabbAKnMXk
         4CB+sizjw4tQDQ8Sb0KwlwY4JqVFPbiPRJq4gnijRoqc36G09Tst42DlRNM6dy05L8A8
         8q9A==
X-Gm-Message-State: ANoB5pmve/y7ixraSIF6VEvmgKNhmYfIOilvUZi9P6qqBxilONFhV5Xd
        LFiTxqog3DiqjGhLE54GE0w=
X-Google-Smtp-Source: AA0mqf5Ty7KSwcp51zRFup0m2k1ZY/WsvoAQjnCQ2wiFjY0M4oNR3ruSwGNqzU/DkjZFjamnWtBhyA==
X-Received: by 2002:adf:fe0c:0:b0:236:d479:b0b7 with SMTP id n12-20020adffe0c000000b00236d479b0b7mr7019474wrr.559.1668427493962;
        Mon, 14 Nov 2022 04:04:53 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id r7-20020adfce87000000b00236488f62d6sm9535329wrn.79.2022.11.14.04.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 04:04:53 -0800 (PST)
Message-ID: <a7dbafcc-410c-55e8-562f-b5125a0e8a88@kernel.org>
Date:   Mon, 14 Nov 2022 13:04:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Don Zickus <dzickus@redhat.com>, Hao Luo <haoluo@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Huang Rui <ray.huang@amd.com>,
        Ingo Molnar <mingo@redhat.com>, Jan Hubicka <jh@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Jiri Kosina <jikos@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Martin Liska <mliska@suse.cz>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mel Gorman <mgorman@suse.de>, Miguel Ojeda <ojeda@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Miroslav Benes <mbenes@suse.cz>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Richard Biener <RGuenther@suse.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Yonghong Song <yhs@fb.com>
References: <20221114114344.18650-1-jirislaby@kernel.org>
 <CAMj1kXFqNvs2OvLJLi2CQYtPe4_BquHQg55F8J=oO76N9wRT9g@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 00/46] gcc-LTO support for the kernel
In-Reply-To: <CAMj1kXFqNvs2OvLJLi2CQYtPe4_BquHQg55F8J=oO76N9wRT9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14. 11. 22, 12:56, Ard Biesheuvel wrote:
> On Mon, 14 Nov 2022 at 12:44, Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
>>
>> Hi,
>>
>> this is the first call for comments (and kbuild complaints) for this
>> support of gcc (full) LTO in the kernel. Most of the patches come from
>> Andi. Me and Martin rebased them to new kernels and fixed the to-use
>> known issues. Also I updated most of the commit logs and reordered the
>> patches to groups of patches with similar intent.
>>
>> The very first patch comes from Alexander and is pending on some x86
>> queue already (I believe). I am attaching it only for completeness.
>> Without that, the kernel does not boot (LTO reorders a lot).
>>
> 
> You didn't cc me on that patch so I will reply here: I don't think
> this is the right solution.
> On x86, there is a lot of stuff injected into .head.text that simply
> does not belong there, and getting rid of the __head annotation and
> dropping __HEAD from the Xen pvh head.S file would be a much better
> solution.

I think Alexander was working on that too. I'm not sure -- anyway, we 
still have the other fix. That is putting startup_64() to a special 
section and put that to the beginning of vmlinux using lds. (Until 
.head.text is completely gone for good -- same as on arm, you wrote 
somewhere.)

In any case, that patch was added only for reference, if anyone wants to 
give the series a try. Next time, I can attach the other workaround ;).

I don't expect anyone will take the series as is. There will be a lot of 
comments, I suppose. Hence many re-spins...

thanks,
-- 
js
suse labs

