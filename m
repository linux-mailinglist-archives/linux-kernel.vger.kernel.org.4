Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522EB65CDC7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 08:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjADHn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 02:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjADHnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 02:43:55 -0500
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C11E193D5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 23:43:54 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id m18so80427975eji.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 23:43:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sZ8pbCA+OTt6oEpW5LfqQng/isugNYiLjWw5Cr2oGF8=;
        b=Hei71CS+Y2vRzFTEhQOPZEcCCDBDA1JczyUbjZMj8BCgzi74H7vGeyike5AXpcGFnp
         /aaUn5naSIKb+03bLXdUpmY5OlJAArpaNP1ZCIh/qZnFDY5PWKDdX+ZzDkcrcuXxWAtE
         +Oj76dibOQbZ7haWU1ts+lvhhVduli+YTnfzb3CFDIJSBkyUMXzaFH3qG/5yBDFJk06/
         gOPsu9PSqQmyQQWA/w5+XgdvypNuaLQ8rd2JvClaGiE7xNRFiSe5RigfvTV1SJskRd9E
         vQgW3W+MX6N9lEMRXFlkC7tZbh+UfPUU6tertyq9kOJJocDsYNMGyb3H32ndXjU4rn/5
         DtBQ==
X-Gm-Message-State: AFqh2kq0NssoDrrsOyEehxQLS0I1/qW+TRjYfEHtB/4E3IlBcy6seO6n
        QBPpUA6DH0yiUWtGwZsNTGQGJ+fcBlg=
X-Google-Smtp-Source: AMrXdXv0S5wtWh5nI3F5bmPCu+jZbqgKCjNoL8HUUu5jspwVNqETZ+95Nn3H6repYf/I918hVMBnBg==
X-Received: by 2002:a17:906:9f12:b0:7c1:61a6:2cd2 with SMTP id fy18-20020a1709069f1200b007c161a62cd2mr39824253ejc.9.1672818232848;
        Tue, 03 Jan 2023 23:43:52 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id c19-20020a170906341300b007a8de84ce36sm14886835ejb.206.2023.01.03.23.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 23:43:52 -0800 (PST)
Message-ID: <1b184587-128d-e5cc-67e9-1d27feb87213@kernel.org>
Date:   Wed, 4 Jan 2023 08:43:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] x86: also disable FSRM if ERMS is disabled
Content-Language: en-US
To:     Daniel Verkamp <dverkamp@chromium.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
References: <20220923005827.1533380-1-dverkamp@chromium.org>
 <Yy2U2BW6Tx0imGpK@zn.tnic>
 <CABVzXAk9AXj2Ns7YAh7cCA38t2sGxOEYLv-EfLCoFHr-SUQ2Mw@mail.gmail.com>
 <Yy3yJfz213Lqo4KC@zn.tnic>
 <CABVzXAkO4pU+gpUcWOEWDw+W4id=1WEOgeP5+3tBG_LR6=oa=g@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CABVzXAkO4pU+gpUcWOEWDw+W4id=1WEOgeP5+3tBG_LR6=oa=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 10. 22, 20:08, Daniel Verkamp wrote:
> On Fri, Sep 23, 2022 at 10:51 AM Borislav Petkov <bp@alien8.de> wrote:
>>
>> On Fri, Sep 23, 2022 at 10:25:05AM -0700, Daniel Verkamp wrote:
>>> Yes, we hit this in crosvm when booting the guest kernel with either
>>> OVMF or u-boot on an Intel 12th Gen CPU. The guest kernel boots fine
>>> when loaded directly (using the crosvm kernel loader and not running
>>> any firmware setup in the guest), but it crashes when booting with
>>> firmware inside the first forward memmove() after alternatives are set
>>> up (which happens to be in printk). I haven't gotten to the bottom of
>>> why exactly using firmware is causing this to be set up in an
>>> inconsistent way, but this is a real-world situation, not just a
>>> hypothetical.
>>
>> Sounds like broken virt firmware or so. And if that is not an issue on
>> baremetal, then the virt stack should be fixed - not the kernel.
>>
>>> Now that I look at it with fresh eyes again, maybe we should instead
>>> directly patch the memmove FSRM alternative so that the flag-set
>>> version just does the same jmp as the ERMS one. I can prepare a patch
>>> for that instead of (or in addition to) this one if that sounds
>>> better.
>>
>> So, if the virt firmware deviates from how the real hardware behaves,
>> then the kernel needs no fixing.
>>
>> So you'd have to figure out why is the virt firmware causing this and
>> not baremetal.
>>
>> Then we can talk about fixes.
> 
> Hi Borislav,
> 
> We found that the IA32_MISC_ENABLE MSR setup was missing in the crosvm
> firmware boot path (but not when directly booting a kernel, which is
> why it did not get noticed for a while). Setting the fast string bit
> in the MSR avoids the issue.
> 
> However, I still think it would be appropriate to apply this patch or
> something like it, since there could be a CPU, microcode update, BIOS,
> etc. that clears this bit while still having the CPUID flags for FSRM
> and ERMS.

Let me resurrect this thread... Our customer has an AMD CPU which has 
indeed both capabilities under normal circumstances. But they have a 
cool UEFI BIOS too. They say:

"""
In AMD platform, while disalbe ERMS(Enhanced Rep MOVSB/STOSB) in UEFI 
(system setup -> processor -> Enhanced Rep MOVSB/STOSB), the OS can't 
boot normally.
"""

That is exactly the case here. So can we have the patch (the original 
one, the one below or a better one) to fix this?

> The Intel SDM says: "Software can disable fast-string
> operation by clearing the fast-string-enable bit (bit 0) of
> IA32_MISC_ENABLE MSR", so it's not an invalid configuration for this
> bit to be unset.
> 
> Additionally, something like this avoids the problem by making the
> FSRM case jump directly to the REP MOVSB rather than falling through
> to the ERMS jump in the next instruction, which seems like basically
> free insurance (but if the FSRM flag gets used somewhere else in the
> future, having it set consistently with ERMS is probably still a good
> idea, per the original patch):
> 
> diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
> index 724bbf83eb5b..8ac557409c7d 100644
> --- a/arch/x86/lib/memmove_64.S
> +++ b/arch/x86/lib/memmove_64.S
> @@ -38,7 +38,7 @@ SYM_FUNC_START(__memmove)
> 
>           /* FSRM implies ERMS => no length checks, do the copy directly */
>   .Lmemmove_begin_forward:
> -        ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "", X86_FEATURE_FSRM
> +        ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "jmp .Lmemmove_erms",
> X86_FEATURE_FSRM
>           ALTERNATIVE "", "jmp .Lmemmove_erms", X86_FEATURE_ERMS
> 
> And hey, this means one less instruction to execute in the FSRM path. :)

thanks,
-- 
js
suse labs

