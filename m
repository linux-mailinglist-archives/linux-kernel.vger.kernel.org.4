Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EE45BDCFB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiITGQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiITGQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:16:28 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9685A817;
        Mon, 19 Sep 2022 23:16:27 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id e17so2312661edc.5;
        Mon, 19 Sep 2022 23:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pXGWiooZdfLQEw6htXJSmmHlrll72T6pMuHJ2O4lII4=;
        b=x9B0ShZlhimaDGkWD38laKzSlKLak9VX+ikPRU003/pmJMg8CEvrou43UtteD2VYrP
         Oebdb0Pwwx6nIc2ZWYlPStmvAdR4zvLKrMOC1yWinTx89i3HCFcezK1socvBWy4y4zQT
         yTKUfb5YRRst+lLNIwGWBtJEMdlO0fXbZ3gUXx3m5YDvwxC7WRyhj/b4Rok7ULLOYC48
         +kzE3kutYVBh3NoKdMr2kLtcUtEzRkr0OlxEOvxH7nlo18MNAZIa8MoS0E9jqkSx0zAo
         cjqvB9rBj3ITeQe0eXSMHriB8Y0S64KZkQC/Ry4WBvfEJgOl1PFw9oSq8q7JZdSCXh+V
         GZSw==
X-Gm-Message-State: ACrzQf0up0rN8XE21YeuJr6d8kxhPkaal0iSubGu0Eg/p84gkJX9UU5l
        OCk1dUWyW6MM+6d80MomxX4=
X-Google-Smtp-Source: AMsMyM6x/RPgRMAxze76M9OQVx+kFOSJReAarH1MFSLa5CvIe7IfV81ccXEwQHUahaQIVk4IkvA+jw==
X-Received: by 2002:aa7:d3cd:0:b0:452:5457:6375 with SMTP id o13-20020aa7d3cd000000b0045254576375mr18611308edr.111.1663654585639;
        Mon, 19 Sep 2022 23:16:25 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id d24-20020a170906c21800b007707fc31b8dsm308824ejz.26.2022.09.19.23.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 23:16:25 -0700 (PDT)
Message-ID: <c2e26880-6d1e-725d-a3df-9a96583e8fb2@kernel.org>
Date:   Tue, 20 Sep 2022 08:16:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] kbuild: pass jobserver to cmd_ld_vmlinux.o
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>, Jiri Slaby <jslaby@suse.cz>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Signed-off-by : Martin Liska" <mliska@suse.cz>
References: <20220719084149.29950-1-jslaby@suse.cz>
 <CAK7LNAQa0QqEG1PLY3nr_ajP59d9cNU-0FBq2WGKnvEnZGJ1MA@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CAK7LNAQa0QqEG1PLY3nr_ajP59d9cNU-0FBq2WGKnvEnZGJ1MA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 07. 22, 11:15, Masahiro Yamada wrote:
> On Tue, Jul 19, 2022 at 5:41 PM Jiri Slaby <jslaby@suse.cz> wrote:
>>
>> Until the link-vmlinux.sh split (cf. the commit below), the linker was
>> run with jobserver set in MAKEFLAGS. After the split, the command in
>> Makefile.vmlinux_o is not prefixed by "+" anymore, so this information
>> is lost.
>>
>> Restore it as linkers working in parallel (esp. the LTO ones) make a use
>> of it. In this case, it is gcc producing this warning otherwise:
>> lto-wrapper: warning: jobserver is not available: ‘--jobserver-auth=’ is not present in ‘MAKEFLAGS’
>>
>> Cc: Sedat Dilek <sedat.dilek@gmail.com>
>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>> Cc: Michal Marek <michal.lkml@markovi.net>
>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> Cc: Signed-off-by: Martin Liska <mliska@suse.cz>
>> Fixes: 5d45950dfbb1 (kbuild: move vmlinux.o link to scripts/Makefile.vmlinux_o)
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> ---
>>
>> Notes:
>>      [v2] only commit message updated
> 
> 
> Did you read my previous email?
> 
> https://lore.kernel.org/linux-kbuild/CAK7LNAS46hrVh3FNiHHL8_Hqp85VgWnsHyjQ4t-TFH_H344NOg@mail.gmail.com/

Huh, I neither received this email nor the linked one to my inbox. 
@suse.cz somehow filters mails from you :/. Let me figure out (and use 
kernel.org account for now). (And get back to your comments too.)

>>   scripts/Makefile.vmlinux_o | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
>> index 84019814f33f..886db0659d9c 100644
>> --- a/scripts/Makefile.vmlinux_o
>> +++ b/scripts/Makefile.vmlinux_o
>> @@ -65,7 +65,7 @@ define rule_ld_vmlinux.o
>>   endef
>>
>>   vmlinux.o: $(initcalls-lds) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS) FORCE
>> -       $(call if_changed_rule,ld_vmlinux.o)
>> +       +$(call if_changed_rule,ld_vmlinux.o)
>>
>>   targets += vmlinux.o
>>
>> --
>> 2.37.1
>>
> 
> 

-- 
js

