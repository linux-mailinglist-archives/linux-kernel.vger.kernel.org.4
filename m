Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9DE7411E1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjF1NB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjF1NBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:01:51 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3B8ED
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:01:50 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b80512a7f2so22840335ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687957310; x=1690549310;
        h=content-transfer-encoding:in-reply-to:subject:references:cc:to:from
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B/ob4oj5FBmGVAjKUF5srJ+1qThDVZSlaHUwIGnS6Jo=;
        b=pwxViPZFWJbvonLd6e3TtUbLVA8BQjwshmXfXeS2tTddPCgBSl+pVya625bMPxHlvz
         kamdILD3UAe9IYNxw2vCgnvSUph+mCwV8cqqYyoVVFwunp/CyR9nz+yjbSqAuu7Ke3MJ
         NhER4FbGaQxr2l/Y+TjAKDNlXVUI8blvFdtFxH31D+Xab0WGT6aNTLbyvj5kQSU8Td1q
         rdSTMsECu0hT/g4E7EKy5MzdaahtOlBlgJ6TJLCh/4Mqf1WFvyYaAd0pIV1egXtF0Ti6
         In8v2m8+9vA43LvAw7wtr+7K4vH2+2MKsZqUNblafIdT3Nua4DWYH7tdeAEGfZjbPsFP
         uFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687957310; x=1690549310;
        h=content-transfer-encoding:in-reply-to:subject:references:cc:to:from
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/ob4oj5FBmGVAjKUF5srJ+1qThDVZSlaHUwIGnS6Jo=;
        b=APcNzweC8JXlGhJyxN0AnrHeqNyHQbk4o8ZYKX8+xMeQtlh7/sTEY3Fpa6dNSIfnZs
         V/w1Zy/+r0UXPIm7eJ/9sCiJ8UpH0cXXLaXIkU7pwplhGCj0YpvFwm4WEf8feJhxNXLT
         5MDtIMcAhIiw69mEpuncnPQ2LtSg1LsSQDhI7QGrVak767JMnNoyEY36XaJK1+vZRRoV
         3iJYW1hpjkBF5/V6FS5in31Jb8/k3wdtMlpSgxsYnpzdx0+fg9FebNuOcngnOLUy8nll
         +RkUq3B68DEhGCgwzbGKg3AzLx4ORbfQPK0ZidtmOhwNrFcLeUsaACNecgXGgOrchNgB
         7guQ==
X-Gm-Message-State: AC+VfDwArINh4heSR7s1u8hbR3W06gEkWKThD8P3dbcMfbioLmezukZ9
        I8mj9Kh64tsltPy0/wRgnDI=
X-Google-Smtp-Source: ACHHUZ6qcGRTNu5RFHddjIizG7OmhKOral2TZ4MJXYn0z1E9EEAIEjGkw4mwGC6PKsgNKryShZ5bpg==
X-Received: by 2002:a17:902:aa84:b0:1af:b678:5168 with SMTP id d4-20020a170902aa8400b001afb6785168mr9915673plr.67.1687957309552;
        Wed, 28 Jun 2023 06:01:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902760900b001b54a88e6adsm7515466pll.309.2023.06.28.06.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 06:01:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d83eb041-258a-c0ba-69cd-e544dda9d22f@roeck-us.net>
Date:   Wed, 28 Jun 2023 06:01:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, vishal.moola@gmail.com,
        akpm@linux-foundation.org, sfr@canb.auug.org.au
References: <20230627221430.464073-1-dinguyen@kernel.org>
 <CAHk-=wgh1CDUTJD+F_utKnbW6d=wApBMC4D8hMfOs15bAn23Bg@mail.gmail.com>
 <cdb13c6c-9cef-905b-0ecd-94649ca075d0@roeck-us.net>
Subject: Re: [PATCH] Revert "nios2: Convert __pte_free_tlb() to use ptdescs"
In-Reply-To: <cdb13c6c-9cef-905b-0ecd-94649ca075d0@roeck-us.net>
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

On 6/27/23 16:23, Guenter Roeck wrote:
> On 6/27/23 15:35, Linus Torvalds wrote:
>> On Tue, 27 Jun 2023 at 15:14, Dinh Nguyen <dinguyen@kernel.org> wrote:
>>>
>>> This reverts commit 6ebe94baa2b9ddf3ccbb7f94df6ab26234532734.
>>>
>>> The patch "nios2: Convert __pte_free_tlb() to use ptdescs" was supposed
>>> to go together with a patchset that Vishal Moola had planned taking it
>>> through the mm tree. By just having this patch, all NIOS2 builds are
>>> broken.
>>
>> This is now at least the third time just this merge window where some
>> base tree was broken, and people thought that linux-next is some kind
>> of testing ground for it all.
>>
>> NO!
>>
>> Linux-next is indeed for testing, and for finding situations where
>> there are interactions between different trees.
>>
>> But linux-next is *not* a replacement for "this tree has to work on
>> its own". THAT testing needs to be done independently, and *before* a
>> tree hits linux-next.
>>
>> It is *NOT* ok to say "this will work in combination with that other
>> tree". EVERY SINGLE TREE needs to work on its own, because otherwise
>> you cannot bisect the end result sanely.
>>
>> We apparently had the NIOS2 tree being broken. And the RCU tree was
>> broken. And the KUnit tree was broken.
>>
> 
> Actually, this one is broken in linux-next as well because it was pulled
> into it, but the context patches needed to make it work (compile) are not
> there. It is also broken in next/pending-fixes for the same reason.
> 
> Only this happened so quick that by the time I noticed and reported
> and argued that, no, I did not try to apply this patch on its own,
> the pull request into mainline was already sent and applied.
> 
> Problem with linux-next is that it is so badly broken that it would take
> a full-time position to track down all its failures. Then there are those
> last-minute patches added in the week (or days) before the commit window
> opens which break it again. This is one example, but there is at least
> one more in linux-next (and pending-fixes); see
> https://kerneltests.org/builders/next-sh-pending-fixes/builds/822/steps/buildcommand/logs/stdio
> 

And now the broken (never compiled) patch made it into mainline
and breaks the sh:dreamcast_defconfig build there.

Yes, it does happen a lot that builds are temporarily broken in mainline
because patch series are split up among maintainers and submitted to mainline
without regard of buildability. I have learned to live with that and don't
normally report it because I know (ok, hope) it is going to be fixed
by the end of the commit window.

I personally find patch series - typically doing some cleanup - which are
not even build tested on the affected architectures much more annoying.

Guenter

