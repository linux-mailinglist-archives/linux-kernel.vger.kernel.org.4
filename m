Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB87768D24A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjBGJNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjBGJNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:13:48 -0500
X-Greylist: delayed 446 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Feb 2023 01:13:45 PST
Received: from ouvsmtp1.octopuce.fr (ouvsmtp1.octopuce.fr [194.36.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED00F18B15;
        Tue,  7 Feb 2023 01:13:45 -0800 (PST)
Received: from panel.vitry.ouvaton.coop (unknown [194.36.166.20])
        by ouvsmtp1.octopuce.fr (Postfix) with ESMTPS id 9366B1DC;
        Tue,  7 Feb 2023 10:06:16 +0100 (CET)
Received: from [192.168.1.18] (lfbn-idf2-1-1024-123.w86-238.abo.wanadoo.fr [86.238.255.123])
        by panel.vitry.ouvaton.coop (Postfix) with ESMTPSA id B6FD15E204B;
        Tue,  7 Feb 2023 10:06:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ouvaton.org;
        s=default; t=1675760776;
        bh=YX0gNKJmv7B0U2PNuC8epDN4OrK4OL3H/or53nn8tMo=; l=1246;
        h=Subject:To:From;
        b=Woy/6i0vuWfkj+rwRaV0Dy58emaOmJ6FHz7/scGmMSQmhen0COQMvdlBxHpGBpksH
         D4slGo59errcnxtR6htO5A8Goc2MsxFLAUapuHll5BsqAR0jTwvcDQ4eHDRK0YDBKQ
         7s0m28Pv8yjA6A0di69TWMAX6g9q9+IueVowqOc8=
Message-ID: <9f549c7b-bc72-8037-abfc-fe2f146ff82c@ouvaton.org>
Date:   Tue, 7 Feb 2023 10:06:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] uaccess: Add minimum bounds check on kernel buffer size
Content-Language: fr-FR, en-US, en-GB
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230203193523.never.667-kees@kernel.org>
 <6c728dfc-d777-4beb-b463-649704c81a5e@app.fastmail.com>
 <CAMuHMdXXSwYYoUMskhcgjF9SVjraZC-UsBT3sN+xkcUAYmJj4Q-2143@mail.gmail.com>
From:   Yann Droneaud <ydroneaud@ouvaton.org>
In-Reply-To: <CAMuHMdXXSwYYoUMskhcgjF9SVjraZC-UsBT3sN+xkcUAYmJj4Q-2143@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 06/02/2023 à 21:03, Geert Uytterhoeven a écrit :

> Hi Arnd,
>
> On Fri, Feb 3, 2023 at 10:23 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Fri, Feb 3, 2023, at 20:35, Kees Cook wrote:
>>> --- a/include/linux/uaccess.h
>>> +++ b/include/linux/uaccess.h
>>> @@ -329,6 +329,10 @@ copy_struct_from_user(void *dst, size_t ksize,
>>> const void __user *src,
>>>        size_t size = min(ksize, usize);
>>>        size_t rest = max(ksize, usize) - size;
>>>
>>> +     /* Double check if ksize is larger than a known object size. */
>>> +     if (WARN_ON_ONCE(ksize > __builtin_object_size(dst, 1)))
>>> +             return -E2BIG;
>>> +
>> WARN_ON_ONCE() may be a little expensive since that adds two
>> comparisons and a static variable to each copy, but it's probably
>> fine.
> When seeing this, I was a bit worried about the size increase.
> Hence I gave it a try on atari_defconfig and ran bloat-o-meter.
> Surprisingly, there was no size increase at all, as all checks
> were optimized away.
>
> Hence perhaps this can become a compile-time check?

It should be a compile-time check, because one would not want __builtin_object_size(dst, 1) to return -1 if dst' size is not known at compile-time.

Regards.

-- 
Yann Droneaud
OPTEYA

