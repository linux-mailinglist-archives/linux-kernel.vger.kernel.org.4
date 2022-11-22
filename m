Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F81633887
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbiKVJca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbiKVJcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:32:23 -0500
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C832B4E42D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:32:22 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id bj12so34330243ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:32:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mExqMfrB7+6cODsWTqQo+eyVaSKptOKkOmzcem/xvUg=;
        b=qFe43MhW9t83JkNFLR72wnOa+6xiOBOpP5BCOShAxQVrsmNR3QsSnRpLoHjNamJ05e
         1eGnKmj8Vve5PCaLwwMNpM4NQi7nmFpfphL7Y0fMK9iFb6WJrChSnZaVJVCwot+2HPYB
         XpbwqOAwNuXk03Z96moOmtj3BMUNxjU4k9MvnD7RnXldx7A1DvseYvxMnTXefCKMcuBA
         /GUO7Q9wxCGjE/EOhuqhqM4CtYjuptVCryUFcfce6dHlyAyAxDgnHKoYMGN634s41EI9
         KgO9paPhiMU1dX4rMB/P9Pf/Y8Ula4GTQtqAQRQ/OVkO20a3iZXOw3mDVGXPAVY2rp2A
         tgXA==
X-Gm-Message-State: ANoB5pngDf5Qd2OqcYZqdXdqLzHnWyHkDZPGO8dBPvbASHQwW1Afq8dc
        alE+TwFHFhTRQak5vcDYiWa9dFuFWsOFOw==
X-Google-Smtp-Source: AA0mqf6YyZ7DnYa05HH+z16/XW0Bx5sKZZE5OQb2hvJUEkABqzyHkVyqxr28CFBq2okvHgNBJgU1RA==
X-Received: by 2002:a17:906:f252:b0:7ae:4236:bfb5 with SMTP id gy18-20020a170906f25200b007ae4236bfb5mr17970265ejb.428.1669109541312;
        Tue, 22 Nov 2022 01:32:21 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id lb13-20020a170907784d00b0072a881b21d8sm5846268ejc.119.2022.11.22.01.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 01:32:20 -0800 (PST)
Message-ID: <c1136a51-2eea-8ebd-784e-2d165ac6fed3@kernel.org>
Date:   Tue, 22 Nov 2022 10:32:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
References: <20221114114344.18650-1-jirislaby@kernel.org>
 <20221114114344.18650-19-jirislaby@kernel.org> <87a64qo4th.ffs@tglx>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 18/46] entry, lto: Mark raw_irqentry_exit_cond_resched()
 as __visible
In-Reply-To: <87a64qo4th.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17. 11. 22, 0:30, Thomas Gleixner wrote:
> On Mon, Nov 14 2022 at 12:43, Jiri Slaby wrote:
>> Symbols referenced from assembler (either directly or e.f. from
> 
> from assembler? I'm not aware that the assembler references anything.

"""
Noun assembler

assembler (countable and uncountable, plural assemblers)

1.  (programming, countable) A program that reads source code written in 
assembly language and produces executable machine code, possibly 
together with information needed by linkers, debuggers and other tools.

2. (computer languages, informal, chiefly uncountable) Assembly language.

     I wrote that program in assembler.
""" [1]

I refer in the above to 2. You refer to 1.

In some languages, incl. mine, we don't distinguish between the two. 
It's always assembler. Yet, that might confuse you, even though it's 
correct as you can see above. I can switch to mode 1 (assembler and 
assembly) for sure.

[1] https://en.wiktionary.org/wiki/assembler

> Also what does e.f. mean? Did you want to write e.g.?

Yes, my and my spellchecker's bad.

>> DEFINE_STATIC_KEY()) need to be global and visible in gcc LTO because
>> they could end up in a different object file than the assembler. This
> 
> than the assembler? Are we shipping the assembler in an object file?

Nope, see above.

>> can lead to linker errors without this patch.
> 
> git grep -i 'this patch' Documentation/process/

Sorry, I don't understand, care to elaborate? None of the lines from the 
output seems to match the case here.

>> So mark raw_irqentry_exit_cond_resched() as __visible.
> 
> And all that tells me what? I know what you want to say, but it's not
> there.
> 
>    Symbols in different compilation units which are referenced from
>    assembly code either directly or indirectly, e.g. from
>    DEFINE_STATIC_KEY(), must be marked visible for GCC based LTO builds.
> 
>    Add the missing __visible annotation to raw_irqentry_exit_cond_resched().
> 
> See?
> 
> There is no 'global' because it's obvious that a symbol in a different
> compilation unit must be global to be resolvable. It's also obvious that
> code in different compilation units ends up in different object files.

It's not about different compilation units. It's about different partitions.

> So stating that it's a 'must' to have such symbols marked visible is
> good enough for an argument because that tells the reader that this is a
> mandatory requirement for an GCC based LTO build.

My bad that I failed to explain properly in the commit log. But we are 
working on throwing all this __visible thing away. Agreed, that it's 
ridiculous/absurd.

thanks,
-- 
js
suse labs

