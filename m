Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684CA5BDF5C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiITILP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiITIKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:10:22 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9984466A63;
        Tue, 20 Sep 2022 01:06:50 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 29so2673504edv.2;
        Tue, 20 Sep 2022 01:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yyVaGCz/6JjrkagRCTiycnxdM7zVqCEBd7VFC7oEt6Q=;
        b=iQ5FlNGykrmhlL8mHxteOSdtdsaXx5j3upYbocYDfmCZ+Lkk/ukNKJdVP/kA76dAHt
         9jfwuKiSRRXmi6hJDs+sh60bVt9dswye3yLHx97fzBIhKkigV2uAhoT0UnYo7J0nD64R
         2puuYPymGHsouxzDH93WsIYrzSL60ZHFbZX0qB+1Xo6TYJVsd8TfCv8e5vUSd7d+sRPY
         B+rvpJ8ha61ZLMrZwdzTjfJypRWqykZYvW7z+ihIkg1EN9U/Ys9vy3oJI26urIqyhdXC
         jwseOdncUTQ+pOYQdOLra7ocFZaRGMoU7aoTEv5M/dq+bKF+CSKHYU+kK1Ppovzi49TX
         b4sQ==
X-Gm-Message-State: ACrzQf1ZBgxyayiPK4Fiz7XXcDRxO3ZRpnqLYq8M6iPutHBOXTpSmeP+
        qtXP+NRMi4I0xN3Tdp0TwAE=
X-Google-Smtp-Source: AMsMyM7MavVFEkqG4SSjR/srSVbIf9pPZRRcVI94LBaaSlBVgreRTTXkUhyH4aZ18IsNjPsxH83vfw==
X-Received: by 2002:a05:6402:5210:b0:451:d4ff:ab02 with SMTP id s16-20020a056402521000b00451d4ffab02mr19197216edd.345.1663661208369;
        Tue, 20 Sep 2022 01:06:48 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id d11-20020a50fe8b000000b004542e65337asm796060edt.51.2022.09.20.01.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 01:06:47 -0700 (PDT)
Message-ID: <0d2464f2-b900-4fd9-74cb-61d635d45799@kernel.org>
Date:   Tue, 20 Sep 2022 10:06:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/2] kbuild: lto: preserve MAKEFLAGS for module linking
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Liska <mliska@suse.cz>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20220719084149.29950-1-jslaby@suse.cz>
 <20220719084149.29950-2-jslaby@suse.cz>
 <CAK7LNATNy6-W+9USiO1pEK1syj1M1fVB1Zda2NuDmPogVp4cmQ@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CAK7LNATNy6-W+9USiO1pEK1syj1M1fVB1Zda2NuDmPogVp4cmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,
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
>> From: Martin Liska <mliska@suse.cz>
>>
>> Prefix command in makefile run in order to preserve access to jobserver.
>> This is needed for gcc at least.
>>
>> Fixes this warning:
>> lto-wrapper: warning: jobserver is not available: ‘--jobserver-auth=’ is not present in ‘MAKEFLAGS’
> 
> 
> What is lto-wrapper ?

lto-wrapper is a part of gcc:
https://gcc.gnu.org/git/?p=gcc.git;a=blob;f=gcc/lto-wrapper.cc

And is invoked during the link of LTO objects (also to link in parallel 
if jobserver is available).

I am leaving the unanswered questions below for Martin to answer.

>> Cc: Sedat Dilek <sedat.dilek@gmail.com>
>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>> Cc: Michal Marek <michal.lkml@markovi.net>
>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> Fixes: 5d45950dfbb1 (kbuild: move vmlinux.o link to scripts/Makefile.vmlinux_o)
>> Signed-off-by: Martin Liska <mliska@suse.cz>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> ---
>>
>> Notes:
>>      [v2] this is new in v2
>>
>>   scripts/Makefile.build | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
>> index bb63374fb055..493f3c4e8461 100644
>> --- a/scripts/Makefile.build
>> +++ b/scripts/Makefile.build
>> @@ -247,8 +247,8 @@ endef
>>
>>   # Built-in and composite module parts
>>   $(obj)/%.o: $(src)/%.c $(recordmcount_source) FORCE
>> -       $(call if_changed_rule,cc_o_c)
>> -       $(call cmd,force_checksrc)
>> +       +$(call if_changed_rule,cc_o_c)
>> +       +$(call cmd,force_checksrc)
> 
> 
> cmd_force_checksrc invokes sparse.
> How is it related to GCC?
> 
> 
> 
> 
>>
>>   # To make this rule robust against "Argument list too long" error,
>>   # ensure to add $(obj)/ prefix by a shell command.
>> @@ -457,7 +457,7 @@ endef
>>   $(multi-obj-m): objtool-enabled := $(delay-objtool)
>>   $(multi-obj-m): part-of-module := y
>>   $(multi-obj-m): %.o: %.mod FORCE
>> -       $(call if_changed_rule,ld_multi_m)
>> +       +$(call if_changed_rule,ld_multi_m)
>>   $(call multi_depend, $(multi-obj-m), .o, -objs -y -m)
> 
> 
> cmd_ld_multi_m invokes $(LD) directly.
> How is it related to gcc?



-- 
js
suse labs

