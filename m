Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C63634AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 00:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbiKVXCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 18:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbiKVXCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 18:02:10 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D88240BC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 15:02:08 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso162142wmp.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 15:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:disposition-notification-to
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YflRbTJJppGsFRJaIp3wpSKP6Z72fkmLDSxYwEoZ/lw=;
        b=EL+TVXRXFJT/bONR+miJnWSVajNGBsx7D+jDFWG4vd/KMPLAYLXOdWieEEJs6DIl6H
         NJ2h2h1mEh451ZvvpeYfxViHL48BlQLHgGCgPVp3F0VO2VMu1GcZ/PL5Qu2xqpMNkmDg
         cmgl67oyzAr1U7ir4Ln+J+1DRGICGAl5Ik7tgSEdiVVSyrBWC9ztjgIwAbAYmRXUJUzA
         5wsSpFKntkPR8dIL0WA1607RUSwJNj+7q41KM4dCZEuLaqqATOySGUkez/YTcytoL16H
         8iuctL5M57TM1JWOBpfTKqucNvJRyBUFloe4RPjtoVgn7wKXqyGuUrU3cy6x8V88VW+5
         4edQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:disposition-notification-to
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YflRbTJJppGsFRJaIp3wpSKP6Z72fkmLDSxYwEoZ/lw=;
        b=gh/9TidqlWRQja5aRCNi7avJ3pU4Qd4RB2js+09Bbarfb5PcijmXm4jyxeX0oFl8Va
         PamhQhw+Z61DC1Nxamps2c6yYZOGAQEsS8om9A+nOz+IhrTenFIkCnVVkqvGZ11s9dM5
         bDLtbTMSSsMKIPscx3YPiwmSa8MiuIAARH2RrjV/XqTW+8H93sT6i30yjyfitMi5AqBY
         D0vDOzQvdb2wiDIuRGIN4HS6GL3K0Rpb1ihRgjTRvmvEkhgcRFaS8rmgDYZFs86XapJ6
         9lZijsVoY7ctKQX96gOxf0KwhmQHY0HaKbGtV8D6y6RaELAoaFNHO4i9FBD7dCGbIIbE
         b1eA==
X-Gm-Message-State: ANoB5pk4q+R7KgnmnfHufo2Q5dT5n1NSHpDt2clP3bnUeSA++N5JdRvY
        wIKJWkeIaNIaZ7t3SFNvqEM=
X-Google-Smtp-Source: AA0mqf4pRpCdJZT5q80IMfFUT1bYaaEaofyP7rcQdhwX9JiXlOeWBh32JclG0oDeLKGqd2X0KM9p0Q==
X-Received: by 2002:a7b:c045:0:b0:3cf:6f5f:da0e with SMTP id u5-20020a7bc045000000b003cf6f5fda0emr4721068wmc.19.1669158127203;
        Tue, 22 Nov 2022 15:02:07 -0800 (PST)
Received: from ?IPV6:2001:1ae9:2f0:fa00:5962:fdfb:2a9a:17bd? (2001-1ae9-2f0-fa00-5962-fdfb-2a9a-17bd.ip6.tmcz.cz. [2001:1ae9:2f0:fa00:5962:fdfb:2a9a:17bd])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b003c71358a42dsm266426wmb.18.2022.11.22.15.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 15:02:05 -0800 (PST)
Message-ID: <4e1dcf10-dba0-4cd4-cfa7-db6b8e06eeff@gmail.com>
Date:   Wed, 23 Nov 2022 00:01:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 0/1] *** Fix kill(-1,s) returning 0 on 0 kills ***
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
References: <20221122161240.137570-1-pskocik@gmail.com>
 <202211220913.AF86992@keescook>
Content-Language: en-US
From:   Petr Skocik <pskocik@gmail.com>
In-Reply-To: <202211220913.AF86992@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        GB_FREEMAIL_DISPTO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/22 18:15, Kees Cook wrote:
> On Tue, Nov 22, 2022 at 05:12:40PM +0100, Petr Skocik wrote:
>> Hi. I've never sent a kernel patch before but this one seemed trivial,
>> so I thought I'd give it a shot.
>>
>> My issue: kill(-1,s) on Linux doesn't return -ESCHR when it has nothing
>> to kill.
> It looks like LTP already tests for this, and gets -ESRCH?
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/containers/pidns/pidns10.c
>
> Does it still pass with your change?
>
I went ahead and ran it and it does pass with the change.

But it should be obvious from the code alone too. It's only a few
(and fewer after the patch) simple lines of code.
The original:

         int retval = 0, count = 0;
         struct task_struct * p;

         for_each_process(p) {
             if (task_pid_vnr(p) > 1 &&
                     !same_thread_group(p, current)) {
                 int err = group_send_sig_info(sig, info, p,
                                   PIDTYPE_MAX);
                 ++count;
                 if (err != -EPERM)
                     retval = err;
             }
         }
         ret = count ? retval : -ESRCH;

counts kills made after the `task_pid_vnr(p) > 1 && 
!same_thread_group(p, current)` check.
Some, and possibly all, of those kills fail with -EPERM, but the the 
final line only sets -ESRCH
if the count is zero (i.e., the initial check fails). It should be 
counting only kill attempts that
have _not_ returned -EPERM (if all returned -EPERM, then no suitable 
target was found and
a -ESRCH is would be in order -- but it won't be set with the original 
code!).

So the change can be as minor as

     diff --git a/kernel/signal.c b/kernel/signal.c
     index d140672185a4..e42076e2332b 100644
     --- a/kernel/signal.c
     +++ b/kernel/signal.c
     @@ -1608,9 +1608,10 @@ static int kill_something_info(int sig, 
struct kernel_siginfo *info, pid_t pid)
                         !same_thread_group(p, current)) {
                     int err = group_send_sig_info(sig, info, p,
                                       PIDTYPE_MAX);
     -                ++count;
     -                if (err != -EPERM)
     +                if (err != -EPERM){
     +                    ++count;
                         retval = err;
     +                }
                 }
             }
             ret = count ? retval : -ESRCH;

But since the count variable isn't used other than for the zeroness 
check,  I simplified it further
into
     -        int retval = 0, count = 0;
             struct task_struct * p;

     +        ret = -ESRCH;
             for_each_process(p) {
                 if (task_pid_vnr(p) > 1 &&
                         !same_thread_group(p, current)) {
                     int err = group_send_sig_info(sig, info, p,
                                       PIDTYPE_MAX);
     -                ++count;
                     if (err != -EPERM)
     -                    retval = err;
     +                    ret = err; /*either all 0 or all -EINVAL*/
                 }
             }
     -        ret = count ? retval : -ESRCH;


adding a comment explaining the apparent implicit assumption of the 
original code that
the non-EPERM returns from group_send_sig_info in this context must be 
either all  -EINVAL
(bad signal number) or all 0, i.e., there can't be a signal allocation 
failure
(that would be susceptible to being overshadowed by a 0 returned from a 
later kill)
because none of  those kills in this context (kill not sigqueue) should 
require any memory allocation.

It's a tiny patch.

Cheers,
Petr Skocik

P.S.: Apologies if the code formatting is off. Sent this one with 
Thunderbird. Need to work on my
CLI mailsending skills.

