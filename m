Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F317D74DA15
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjGJPlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbjGJPls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:41:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8AF115
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=IqtE8bxydGnxenKOefy+ykO3CYnjrck24uGHgIZ57LA=; b=pT+d7I5wUMIU2xUL0+YD7beR9+
        dWe4feT6a0V4y0upUnLpY9E8iH+I8IT4UFgkveS+ji0Zvj1uQImighbAmI0QRbspgjm1HRjdBVsqu
        lpLQ1lyoWqWVzisZ47AV0fOh83/8lXZ/PbPbhrcOboVOHPSImxWsWjDXw5mC77YRt71Y2VBJJ51Kd
        skmrGUujQdOsyk7T84fK2395yU6NoKC9IGxgNoNBBwfqrJz1MG1R+s4xCTHJFMkH729jvsUxseAbG
        cWi+Vp+u49tjb4SiVmQ0bCIP8qGYS9fJKYvonQ51vaqo9hGR2WPzuXqOEXAdUVao7YigDpAFPe0se
        4s6JZTpA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qIt1C-00C2Qn-2x;
        Mon, 10 Jul 2023 15:41:42 +0000
Message-ID: <cae5cf32-4ad1-0dbf-1b61-c57dd5549798@infradead.org>
Date:   Mon, 10 Jul 2023 08:41:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] init: Don't proxy console= to earlycon
Content-Language: en-US
To:     Raul Rangel <rrangel@chromium.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>, kramasub@chromium.org,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Li Zhe <lizhe.67@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Zhou jie <zhoujie@nfschina.com>
References: <20230707191721.1.Id08823b2f848237ae90ce5c5fa7e027e97c33ad3@changeid>
 <b32ae8af-7950-c725-5632-6ec13420bf77@infradead.org>
 <6101a3bb-30eb-97fc-3a8e-6d15afc4efb5@amd.com>
 <3de1ff24-3970-6e22-a73c-70446b8de4bd@infradead.org>
 <CAHQZ30BLb13Mz5+3MCgV30eG-LiU-6-4F7AEinGQmsgiyzD-yA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAHQZ30BLb13Mz5+3MCgV30eG-LiU-6-4F7AEinGQmsgiyzD-yA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/10/23 08:30, Raul Rangel wrote:
> On Sun, Jul 9, 2023 at 8:43 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>
>>
>> On 7/9/23 18:15, Mario Limonciello wrote:
>>> On 7/9/23 18:46, Randy Dunlap wrote:
>>>>
>>>>
>>>> On 7/7/23 18:17, Raul E Rangel wrote:
>>>>> Right now we are proxying the `console=XXX` command line args to the
>>>>> param_setup_earlycon. This is done because the following are
>>>>> equivalent:
>>>>>
>>>>>      console=uart[8250],mmio,<addr>[,options]
>>>>>      earlycon=uart[8250],mmio,<addr>[,options]
>>>>>
>>>>> In addition, when `earlycon=` or just `earlycon` is specified on the
>>>>> command line, we look at the SPCR table or the DT to extract the device
>>>>> options.
>>>>>
>>>>> When `console=` is specified on the command line, it's intention is to
>>>>> disable the console. Right now since we are proxying the `console=`
>>>>
>>>> How do you figure this (its intention is to disable the console)?
>>>
> 
> https://www.kernel.org/doc/html/v6.1/admin-guide/kernel-parameters.html
> says the following:

> console=

[many lines deleted here in kernel-parameters.txt]

>     { null | "" }
>             Use to disable console output, i.e., to have kernel
>             console messages discarded.
>             This must be the only console= parameter used on the
>             kernel command line.
> 

OK, I see what you are referring to: "console=" without any following parameters,
not the general "console=" command line parameter.

Thanks for the clarification.

>         earlycon=       [KNL] Output early console device and options.
> 
>             When used with no options, the early console is
>             determined by stdout-path property in device tree's
>             chosen node or the ACPI SPCR table if supported by
>             the platform.
> 
> The reason this bug showed up is that ChromeOS has set `console=` for a
> very long time:
> https://chromium.googlesource.com/chromiumos/platform/crosutils/+/main/build_kernel_image.sh#282
> I'm not sure on the exact history, but AFAIK, we don't have the ttyX devices.
> 
> Coreboot recently added support for the ACPI SPCR table which in
> combination with the
> `console=` arg, we are now seeing earlycon enabled when it shouldn't be.
> 
>>> I read that as "it's intention is to disable the default console (tty0)".
>>
>> Yes, that "default" word should be there IMO.
>>
>> Does this patch affect behavior if someone uses
>>         console=tty0
>> i.e., the default?
>>
> 
> No, it shouldn't. This change makes it so that the
> param_setup_earlycon function gets
> skipped if there is no value.
> See https://chromium.googlesource.com/chromiumos/third_party/kernel/+/v6.1/drivers/tty/serial/earlycon.c#223


-- 
~Randy
