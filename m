Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A88745CD6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjGCNGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjGCNGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:06:53 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CAF1B5;
        Mon,  3 Jul 2023 06:06:52 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5703cb4bcb4so46569627b3.3;
        Mon, 03 Jul 2023 06:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688389612; x=1690981612;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=E/UIpD/SrkLTx6OVnCwv/YXnUS5IysH+eycuEeM76/E=;
        b=BBdBGotrRDCts8dsP+Iqv/KbwxLpKRS1msq2KDaSkoTMetauVEE001eZ4UjhUIZreP
         bjwNopiQ0m1B9EO9eE/3xGVuIz6rQ93UmvAGcUoea8RWq1Brz12qzj70ejIhQV5SOlSq
         0nCvwbkGIiKH0DLTLfrdZ6IzV2uZ+Fm7QEQdiTYzewuoHvP41Xfo4Nn4cHoUTSLXKQNO
         iKnM95wMBGQxrNJWkRjvHVifhBD0CqX3lOzvzHcZWWhqtwcL8edg28RAuPyPVAXu0dp/
         Y9mqmSB57NXKwFrbpHX2M43NYVpXvh32xZ6ogH6Q26ER+hLl38uLIhLeR5IltMOZY7Pz
         +xDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688389612; x=1690981612;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/UIpD/SrkLTx6OVnCwv/YXnUS5IysH+eycuEeM76/E=;
        b=UstGSvCfGTbUvm8fdhpblP6UlufMxFetPxvV6lTmQFIJSgAF7ivIqnXGQjYcYZVMre
         8ZmDEHJlEngoOlXKUdECSGqnN6f1OAcXx0KIdV8GaqpQhfY4egdVeJeNiBsOCpJEYbQr
         DWr46KxgjIvAuwXJTQAcItJenbgN1/93wzM/FxeD5Iyh8yyhpTrlFmrAeh7WdHnxTFn+
         l9M3ibMG/ltIWK2VjCwV3z5nx6yf15ovyFZxOThltzC1MQAqm/h1NlV0T46b4yNcC4pA
         wK8kbE9jXT93/I5J/aqDMlKCv+hW77P5RH8XljR+Qm0IMBfhzjvGX9zkJz7xBOvBprvC
         bteQ==
X-Gm-Message-State: ABy/qLaCplyDdgj53BKFPBtgYV+z9HAs8ohQ2dvqtWxoS+Yo/3izsKWz
        vTbPd7IEKSkN4jdVp5B0gHR21J7kJ9g=
X-Google-Smtp-Source: APBJJlFA4OoXPKC76ahBQyNUCz3bRAW4u9bv/d0+w2rQ8FYfKFA1/1KBcuOobmGfYN5OlK9av2OMNg==
X-Received: by 2002:a81:ab52:0:b0:570:670c:7fe3 with SMTP id d18-20020a81ab52000000b00570670c7fe3mr11162420ywk.46.1688389610179;
        Mon, 03 Jul 2023 06:06:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t11-20020a81460b000000b005616d72f435sm5093236ywa.116.2023.07.03.06.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 06:06:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b886c0ee-2ef6-5ec9-17e0-eb66c63a61d4@roeck-us.net>
Date:   Mon, 3 Jul 2023 06:06:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review - hppa argument list too long
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Helge Deller <deller@gmx.de>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John David Anglin <dave.anglin@bell.net>
References: <20230629184151.888604958@linuxfoundation.org>
 <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
 <2023063001-overlying-browse-de1a@gregkh>
 <0b2aefa4-7407-4936-6604-dedfb1614483@gmx.de>
 <5fd98a09-4792-1433-752d-029ae3545168@gmx.de>
 <CAHk-=wiHs1cL2Fb90NXVhtQsMuu+OLHB4rSDsPVe0ALmbvZXZQ@mail.gmail.com>
 <CAHk-=wj=0jkhj2=HkHVdezvuzV-djLsnyeE5zFfnXxgtS2MXFQ@mail.gmail.com>
 <9b35a19d-800c-f9f9-6b45-cf2038ef235f@roeck-us.net>
 <CAHk-=wgdC6RROG145_YB5yWoNtBQ0Xsrhdcu2TMAFTw52U2E0w@mail.gmail.com>
 <2a2387bf-f589-6856-3583-d3d848a17d34@roeck-us.net>
 <CAHk-=wgczy0dxK9vg-YWbq6YLP2gP8ix7Ys9K+Mr=S2NEj+hGw@mail.gmail.com>
 <c21e8e95-3353-fc57-87fd-271b2c9cc000@roeck-us.net>
 <CAHk-=wj+F8oGK_Hx6YSPJpwL-xyL+-q2SxtxYE0abtZa_jSkLw@mail.gmail.com>
 <36986dd6-4973-65a2-3490-84d3c0967adc@roeck-us.net>
In-Reply-To: <36986dd6-4973-65a2-3490-84d3c0967adc@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/23 05:59, Guenter Roeck wrote:
> On 7/2/23 23:20, Linus Torvalds wrote:
>> On Sun, 2 Jul 2023 at 22:33, Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> Here you are:
>>>
>>> [   31.188688] stack expand failed: ffeff000-fff00000 (ffefeff2)
>>
>> Ahhah!
>>
>> I think the problem is actually ridiculously simple.
>>
>> The thing is, the parisc stack expands upwards. That's obvious. I've
>> mentioned it several times in just this thread as being the thing that
>> makes parisc special.
>>
>> But it's *so* obvious that I didn't even think about what it really implies.
>>
>> And part of all the changes was this part in expand_downwards():
>>
>>          if (!(vma->vm_flags & VM_GROWSDOWN))
>>                  return -EFAULT;
>>
>> and that will *always* fail on parisc, because - as said multiple
>> times - the parisc stack expands upwards. It doesn't have VM_GROWSDOWN
>> set.
>>
>> What a dum-dum I am.
>>
>> And I did it that way because the *normal* stack expansion obviously
>> wants it that way and putting the check there not only made sense, but
>> simplified other code.
>>
>> But fs/execve.c is special - and only special for parisc - in that it
>> really wants to  expand a normally upwards-growing stack downwards
>> unconditionally.
>>
>> Anyway, I think that new check in expand_downwards() is the right
>> thing to do, and the real fix here is to simply make vm_flags reflect
>> reality.
>>
>> Because during execve, that stack that will _eventually_ grow upwards,
>> does in fact grow downwards.  Let's make it reflect that.
>>
>> We already do magical extra setup for the stack flags during setup
>> (VM_STACK_INCOMPLETE_SETUP), so extending that logic to contain
>> VM_GROWSDOWN seems sane and the right thing to do.
>>
>> IOW, I think a patch like the attached will fix the problem for real.
>>
>> It needs a good commit log and maybe a code comment or two, but before
>> I bother to do that, let's verify that yes, it does actually fix
>> things.
>>
> 
> Yes, it does. I'll run a complete qemu test with it applied to be sure
> there is no impact on other architectures (yes, I know, that should not
> be the case, but better safe than sorry). I'll even apply
> https://lore.kernel.org/all/20230609075528.9390-12-bhe@redhat.com/raw
> to be able to test sh4.
> 

Meh, should have figured. That fixes one problem with sh4 builds
and creates another. Should have figured.

Guenter

