Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46555BE5F6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiITMe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiITMev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:34:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2F2E69;
        Tue, 20 Sep 2022 05:34:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E5AE121B56;
        Tue, 20 Sep 2022 12:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663677287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kEBiP8Irblq9kj6QD799kTTxDt9/WWTcEX16z78NVkU=;
        b=jEoqDmjkCh7lyGBrkzZd8PrCQUDJjtkeuHecIFyS92AX6uJ7FFPOFurawsKVDMSiRx/x2Y
        /t/mkCBA2Gzgk765VaD/hh5sp+XrNqZRIgdhd4oYuD7qTh0xYoyU9Uw0+gVTljiht/APIO
        xvV45IMK5+ddhtcbpGH5+9kAE19jUnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663677287;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kEBiP8Irblq9kj6QD799kTTxDt9/WWTcEX16z78NVkU=;
        b=5g+WP+tvoIEfKRnDKwmXYo9RZENhPK4LXtcae6P0xhY4a8NNflV/TV6EZc8QVEwRUhJkjf
        mLB27rIOwLIDCeCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3AA113ABB;
        Tue, 20 Sep 2022 12:34:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LwACKmezKWPHWwAAMHmgww
        (envelope-from <mliska@suse.cz>); Tue, 20 Sep 2022 12:34:47 +0000
Message-ID: <e1261036-238a-513c-1b6d-fa4f47e6edb2@suse.cz>
Date:   Tue, 20 Sep 2022 14:34:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/2] kbuild: lto: preserve MAKEFLAGS for module linking
Content-Language: en-US
To:     Jiri Slaby <jirislaby@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20220719084149.29950-1-jslaby@suse.cz>
 <20220719084149.29950-2-jslaby@suse.cz>
 <CAK7LNATNy6-W+9USiO1pEK1syj1M1fVB1Zda2NuDmPogVp4cmQ@mail.gmail.com>
 <0d2464f2-b900-4fd9-74cb-61d635d45799@kernel.org>
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
In-Reply-To: <0d2464f2-b900-4fd9-74cb-61d635d45799@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/22 10:06, Jiri Slaby wrote:
> On 19. 07. 22, 11:15, Masahiro Yamada wrote:
>> On Tue, Jul 19, 2022 at 5:41 PM Jiri Slaby <jslaby@suse.cz> wrote:
>>>
>>> From: Martin Liska <mliska@suse.cz>
>>>
>>> Prefix command in makefile run in order to preserve access to jobserver.
>>> This is needed for gcc at least.
>>>
>>> Fixes this warning:
>>> lto-wrapper: warning: jobserver is not available: ‘--jobserver-auth=’ is not present in ‘MAKEFLAGS’
>>
>>
>> What is lto-wrapper ?
> 
> lto-wrapper is a part of gcc:
> https://gcc.gnu.org/git/?p=gcc.git;a=blob;f=gcc/lto-wrapper.cc
> 
> And is invoked during the link of LTO objects (also to link in parallel if jobserver is available).

Yes, it's a driver that is invoked by Linker when it decides to use LTO mode in GCC compiler.
Later on the lto-wrapper connects to make's jobserver and runs in parallel. Note a recent [1]
make implemented named pipes when it comes to communication with jobserver. And thus the '+'
won't be needed in the future, but we need it for now.

Cheers,
Martin

[1] https://git.savannah.gnu.org/cgit/make.git/commit/?id=7ad2593b2d2bb5b9332f4444d8bf93ac6f958bc6

> 
> I am leaving the unanswered questions below for Martin to answer.
> 
>>> Cc: Sedat Dilek <sedat.dilek@gmail.com>
>>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>>> Cc: Michal Marek <michal.lkml@markovi.net>
>>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>>> Fixes: 5d45950dfbb1 (kbuild: move vmlinux.o link to scripts/Makefile.vmlinux_o)
>>> Signed-off-by: Martin Liska <mliska@suse.cz>
>>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>>> ---
>>>
>>> Notes:
>>>      [v2] this is new in v2
>>>
>>>   scripts/Makefile.build | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
>>> index bb63374fb055..493f3c4e8461 100644
>>> --- a/scripts/Makefile.build
>>> +++ b/scripts/Makefile.build
>>> @@ -247,8 +247,8 @@ endef
>>>
>>>   # Built-in and composite module parts
>>>   $(obj)/%.o: $(src)/%.c $(recordmcount_source) FORCE
>>> -       $(call if_changed_rule,cc_o_c)
>>> -       $(call cmd,force_checksrc)
>>> +       +$(call if_changed_rule,cc_o_c)
>>> +       +$(call cmd,force_checksrc)
>>
>>
>> cmd_force_checksrc invokes sparse.
>> How is it related to GCC?
>>
>>
>>
>>
>>>
>>>   # To make this rule robust against "Argument list too long" error,
>>>   # ensure to add $(obj)/ prefix by a shell command.
>>> @@ -457,7 +457,7 @@ endef
>>>   $(multi-obj-m): objtool-enabled := $(delay-objtool)
>>>   $(multi-obj-m): part-of-module := y
>>>   $(multi-obj-m): %.o: %.mod FORCE
>>> -       $(call if_changed_rule,ld_multi_m)
>>> +       +$(call if_changed_rule,ld_multi_m)
>>>   $(call multi_depend, $(multi-obj-m), .o, -objs -y -m)
>>
>>
>> cmd_ld_multi_m invokes $(LD) directly.
>> How is it related to gcc?
> 
> 
> 

