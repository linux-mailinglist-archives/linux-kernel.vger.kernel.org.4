Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15FA70DA78
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjEWK1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbjEWK1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:27:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3DE1AD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:27:13 -0700 (PDT)
Received: from [IPV6:2405:201:0:21ea:e49:10dd:40c0:e842] (unknown [IPv6:2405:201:0:21ea:e49:10dd:40c0:e842])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9FE4A6606E75;
        Tue, 23 May 2023 11:27:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684837632;
        bh=/cZpY/DKk5fAZOo6SiYRERzxSUjyx353F4endTRRSo4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=btnZAAQPlKxgroncGmTp3yjgSRL5MgT6cZvPcPX4larqhFPob0jvaz5BeIOl18OPl
         PZd+Pbf8QIJY5xSHJ6y57ZzWy3167LwYDoLqg3ENVXMBaBsDVZ5R3fJBJDu+ePfeKi
         Frh1Mc313r6OdfIUrP1trhhPaqCXTlOWfwecZgDZwd3tkNNp36VndrF8XXwgYVYMGc
         MjoDNgU78Aza3z8wgCJhMaffnZFAWFhqdDVzLFYgmivitI403nWwNZbb2oNXJeQKDG
         ZLUcrBeZT51Pw5gLMhdvqLf60ndM2RWjKiSgmILIOKmpI7cU/v+nf5+KAw3wn1SGmQ
         3fyLvdowXCRyw==
Message-ID: <cff33e12-3d80-7e62-1993-55411ccabc01@collabora.com>
Date:   Tue, 23 May 2023 15:57:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4] Makefile.compiler: replace cc-ifversion with
 compiler-specific macros
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Maksim Panchenko <maks@meta.com>,
        =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        regressions@lists.linux.dev,
        "gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>,
        Guillaume Charles Tucker <guillaume.tucker@collabora.com>,
        denys.f@collabora.com, kernelci@lists.linux.dev
References: <CAKwvOd=4hBcU4fAkddU0b-GOZc9FzTZoj3PFW6ZZrX0jS8x+bg@mail.gmail.com>
 <17c91d37-7d9c-0df4-2438-2b30ca0b5777@collabora.com>
 <CAKwvOdk4QO8x_bs64fFRCsMu__AjhXd4Ew2KfgzQOb9Q3FMqSA@mail.gmail.com>
 <b5d0cf82-0e42-f6a1-c9f5-c145fdc4c622@collabora.com>
 <CAKwvOdkFxu9hYSL_RCXadpR0dQd1+dZmAUVXdfFiLUfxg4D_Xw@mail.gmail.com>
 <878rdlk9bi.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
 <CAKwvOd=8LVU+iANkFx18Wm1jg7gYiAXovAmo9t5ZZaVdMULn-Q@mail.gmail.com>
 <875y8ok9b5.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
 <CAKwvOdmJJibt6sHSp91v2s7BxUWBC6xG7F7+3C6gUxNMzZ2xRA@mail.gmail.com>
 <87353ok78h.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
 <2023052247-bobtail-factsheet-d104@gregkh>
 <CAKwvOd=2zAV_mizvzLFdyHE_4OzBY5OVu6KLWuQPOMZK37vsmQ@mail.gmail.com>
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <CAKwvOd=2zAV_mizvzLFdyHE_4OzBY5OVu6KLWuQPOMZK37vsmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick and Masahiro,

On 23/05/23 01:22, Nick Desaulniers wrote:
> On Mon, May 22, 2023 at 9:52 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>> On Mon, May 22, 2023 at 12:09:34PM +0200, Ricardo Cañuelo wrote:
>>> On vie, may 19 2023 at 08:57:24, Nick Desaulniers <ndesaulniers@google.com> wrote:
>>>> It could be; if the link order was changed, it's possible that this
>>>> target may be hitting something along the lines of:
>>>> https://isocpp.org/wiki/faq/ctors#static-init-order i.e. the "static
>>>> initialization order fiasco"
>>>>
>>>> I'm struggling to think of how this appears in C codebases, but I
>>>> swear years ago I had a discussion with GKH (maybe?) about this. I
>>>> think I was playing with converting Kbuild to use Ninja rather than
>>>> Make; the resulting kernel image wouldn't boot because I had modified
>>>> the order the object files were linked in.  If you were to randomly
>>>> shuffle the object files in the kernel, I recall some hazard that may
>>>> prevent boot.
>>> I thought that was specifically a C++ problem? But then again, the
>>> kernel docs explicitly say that the ordering of obj-y goals in kbuild is
>>> significant in some instances [1]:
>> Yes, it matters, you can not change it.  If you do, systems will break.
>> It is the only way we have of properly ordering our init calls within
>> the same "level".
> Ah, right it was the initcall ordering. Thanks for the reminder.
>
> (There's a joke in there similar to the use of regexes to solve a
> problem resulting in two new problems; initcalls have levels for
> ordering, but we still have (unexpressed) dependencies between calls
> of the same level; brittle!).
>
> +Maksim, since that might be relevant info for the BOLT+Kernel work.
>
> Ricardo,
> https://elinux.org/images/e/e8/2020_ELCE_initcalls_myjosserand.pdf
> mentions that there's a kernel command line param `initcall_debug`.
> Perhaps that can be used to see if
> 5750121ae7382ebac8d47ce6d68012d6cd1d7926 somehow changed initcall
> ordering, resulting in a config that cannot boot?


Here are the links to Lava jobs ran with initcall_debug added to the 
kernel command line.

1. Where regression happens (5750121ae7382ebac8d47ce6d68012d6cd1d7926)
https://lava.collabora.dev/scheduler/job/10417706
<https://lava.collabora.dev/scheduler/job/10417706>

2. With a revert of the commit 5750121ae7382ebac8d47ce6d68012d6cd1d7926
https://lava.collabora.dev/scheduler/job/10418012 
<https://lava.collabora.dev/scheduler/job/10418012>


Thanks,
Shreeya Patel

