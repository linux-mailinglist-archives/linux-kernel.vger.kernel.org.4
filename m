Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046D97406D3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 01:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjF0XXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 19:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjF0XXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 19:23:43 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAFCE58
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:23:41 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-668711086f4so275529b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687908221; x=1690500221;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yz5MOSvh70SpxbkiCYNB234txXBq2XH5lUAMytaNfQg=;
        b=JnBMxyjiMumI/bvgojgVexN3dw2rNuGpnVHNNS1K/H/FVtmktcj96ByU4n8TVG0OCJ
         /xzKURaoONZhPDw1d91Ehs0T8ijxjwTjy48QeJjw0MTAArBsGva5fdFYLukSANuhSCpy
         INkwuc0dlRKc+bnPe05htF/FDWSiEG47C0bl1oLdw8gpyONxFfFmnBLy29UjRkbvYpk5
         +Q2Z1hPC1Df0G6sV54zXyKFkKFQvGr06Uj5BsYdNpx9yDRGVpDdAqDmHgTTVGro0wFSG
         +yogG6FJihMbhndRxsY7IIqRbNMcNipBA5HPBEnzs3uathq5h9EmPu0af17+IrRXE/7m
         il6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687908221; x=1690500221;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yz5MOSvh70SpxbkiCYNB234txXBq2XH5lUAMytaNfQg=;
        b=EndvLqUIXjrwS/qFLLrDRT4BqbKqhtBGdVlrsUNDiPwgg4Qbjx8Af0ixezIGN2g+LT
         G8YV1mmGfhFDUYFbo6tsMPZ6kwdFXKeqsKdUbinwq/qFtJB/cEhCPhcUp8k3urFeqMm/
         7WKJlwo29W7NzBy+NwtKVgAYtStCZZF8D42Ff8k5g7nev2crtsfScbd12x0ETeOTtOu5
         fFJM+gqLWFcsj7v29cN0R6LOVVELtgAYAfUPE6lIpSGf7fClYo3uwayT79CZSCTBkmh3
         zXg9Bz7IuyohAQknocKxZGef2CfLCmKJdYODa6wOtK89pJBFHSmLWnji8W9Y+gaDHp6Z
         Mi1w==
X-Gm-Message-State: AC+VfDwVdgkV9zEaN0wnKhrQNiWFL0xj6Jsdjd9gCZk3RU+nKt5oEaGs
        f2ummfjJYw6nnkcqF2ccnf3ZiKLxHyE=
X-Google-Smtp-Source: ACHHUZ4po+fIb3le3F6EFJGILXI1bC4/skYV0fwjm9d4T+jylKJh5qQ7hixMGXUuNiQEd8NOW2AHdg==
X-Received: by 2002:a05:6a00:4504:b0:667:40ea:c8f4 with SMTP id cw4-20020a056a00450400b0066740eac8f4mr683461pfb.11.1687908220867;
        Tue, 27 Jun 2023 16:23:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b0063b675f01a5sm6157659pfb.11.2023.06.27.16.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 16:23:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cdb13c6c-9cef-905b-0ecd-94649ca075d0@roeck-us.net>
Date:   Tue, 27 Jun 2023 16:23:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, vishal.moola@gmail.com,
        akpm@linux-foundation.org, sfr@canb.auug.org.au
References: <20230627221430.464073-1-dinguyen@kernel.org>
 <CAHk-=wgh1CDUTJD+F_utKnbW6d=wApBMC4D8hMfOs15bAn23Bg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] Revert "nios2: Convert __pte_free_tlb() to use ptdescs"
In-Reply-To: <CAHk-=wgh1CDUTJD+F_utKnbW6d=wApBMC4D8hMfOs15bAn23Bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/23 15:35, Linus Torvalds wrote:
> On Tue, 27 Jun 2023 at 15:14, Dinh Nguyen <dinguyen@kernel.org> wrote:
>>
>> This reverts commit 6ebe94baa2b9ddf3ccbb7f94df6ab26234532734.
>>
>> The patch "nios2: Convert __pte_free_tlb() to use ptdescs" was supposed
>> to go together with a patchset that Vishal Moola had planned taking it
>> through the mm tree. By just having this patch, all NIOS2 builds are
>> broken.
> 
> This is now at least the third time just this merge window where some
> base tree was broken, and people thought that linux-next is some kind
> of testing ground for it all.
> 
> NO!
> 
> Linux-next is indeed for testing, and for finding situations where
> there are interactions between different trees.
> 
> But linux-next is *not* a replacement for "this tree has to work on
> its own". THAT testing needs to be done independently, and *before* a
> tree hits linux-next.
> 
> It is *NOT* ok to say "this will work in combination with that other
> tree". EVERY SINGLE TREE needs to work on its own, because otherwise
> you cannot bisect the end result sanely.
> 
> We apparently had the NIOS2 tree being broken. And the RCU tree was
> broken. And the KUnit tree was broken.
> 

Actually, this one is broken in linux-next as well because it was pulled
into it, but the context patches needed to make it work (compile) are not
there. It is also broken in next/pending-fixes for the same reason.

Only this happened so quick that by the time I noticed and reported
and argued that, no, I did not try to apply this patch on its own,
the pull request into mainline was already sent and applied.

Problem with linux-next is that it is so badly broken that it would take
a full-time position to track down all its failures. Then there are those
last-minute patches added in the week (or days) before the commit window
opens which break it again. This is one example, but there is at least
one more in linux-next (and pending-fixes); see
https://kerneltests.org/builders/next-sh-pending-fixes/builds/822/steps/buildcommand/logs/stdio

Guenter

> In all those cases, the base tree did not compile properly on its own,
> and linux-next "magically fixed" it by either having Stephen Rothwell
> literally fix the build breakage by hand, or by having some other tree
> hide the problem.
> 
> This is very much not ok.
> 
> I'm not sure why it happened so much this release, but this needs to
> stop. People need to realize that you can't just throw shit at the
> wall and see if it sticks. You need to test your own trees *first*,
> and *independently* of other peoples trees.
> 
> Then, if  you have done basic testing, you can then have it in
> linux-next and that hopefully then finds any issues with bad
> interactions with other trees, and maybe also ends up getting more
> coverage testing on odd architectures and with odd configurations.
> 
> But linux-next must not in *any* way be a replacement for doing basic
> testing on your own tree first.
> 
>                    Linus

