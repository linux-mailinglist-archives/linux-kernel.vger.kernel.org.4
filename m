Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995BF5FFA08
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 14:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJOMet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 08:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJOMer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 08:34:47 -0400
Received: from mail.yuka.dev (mail.yuka.dev [IPv6:2a0f:4ac0:0:1::ec3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98772AE31
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 05:34:42 -0700 (PDT)
Message-ID: <74f03e2e-ad5c-22ae-591f-6afae2d7bad0@yuka.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yuka.dev; s=mail;
        t=1665837272; bh=LDQ//UqRy7EZ0cqMYzzoPn7+KkIawu0kSpKwCWw05AY=;
        h=Date:Subject:To:References:Cc:From:In-Reply-To;
        b=T8zQts6DTDrwjw6v69/2Ck+XqxPrqM1QuZOvexWg9+FqFW5r5/SRcaNnWKfWoTQ/E
         cVfG5aY1/ouFBswJxI5OCQOdSr6tL/aos4LA8yVDzc9pmXAJrnTWBbUFwUz6Et8qVL
         CD4S9rEy+0t+3a5DhDT9XYZ64TAfE7GO61CGGhgc=
Date:   Sat, 15 Oct 2022 14:34:32 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] speakup: remove usage of non-standard u_char
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
References: <9b7e4894-deec-39ba-bb7c-3c6d6427fa1d@yuka.dev>
 <Y0UKhAzH+RSGyhKi@kroah.com>
Cc:     linux-kernel@vger.kernel.org
From:   Yureka <yuka@yuka.dev>
In-Reply-To: <Y0UKhAzH+RSGyhKi@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/22 08:17, Greg KH wrote:
> On Tue, Oct 11, 2022 at 02:17:43AM +0200, Yureka wrote:
>> From: Yureka Lilian <yuka@yuka.dev>
>>
>> This code is included in the build tools makemapdata and genmap, and it
>> expects that libc exposes a definition of u_char. But u_char is not
>> defined in either C or POSIX standards, and some systems don't have it.
>> Namely this breaks the build on hosts using musl libc, because musl only
>> exposes u_char if _GNU_SOURCE is defined.
>>
>> Signed-off-by: Yureka Lilian <yuka@yuka.dev>
>> ---
>>  drivers/accessibility/speakup/utils.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/accessibility/speakup/utils.h b/drivers/accessibility/speakup/utils.h
>> index 4bf2ee8ac..4ce9a12f7 100644
>> --- a/drivers/accessibility/speakup/utils.h
>> +++ b/drivers/accessibility/speakup/utils.h
>> @@ -54,7 +54,7 @@ static inline int oops(const char *msg, const char *info)
>>  
>>  static inline struct st_key *hash_name(char *name)
>>  {
>> -   u_char *pn = (u_char *)name;
>> +   unsigned char *pn = (unsigned char *)name;
>>     int hash = 0;
>>  
>>     while (*pn) {
>> -- 
>> 2.37.3
>
> Hi,
>
> This is the friendly semi-automated patch-bot of Greg Kroah-Hartman.
> You have sent him a patch that has triggered this response.
>
> Right now, the development tree you have sent a patch for is "closed"
> due to the timing of the merge window.  Don't worry, the patch(es) you
> have sent are not lost, and will be looked at after the merge window is
> over (after the -rc1 kernel is released by Linus).
>
> So thank you for your patience and your patches will be reviewed at this
> later time, you do not have to do anything further, this is just a short
> note to let you know the patch status and so you don't worry they didn't
> make it through.
>
> thanks,
>
> greg k-h's patch email bot


I noticed in hindsight this patch might be suitable for the 6.0.x stable line as well, since it is a build fix with otherwise seemingly little impact.
Let me know if I should do anything to get it in the queue for stable/fix reviews.

Thanks,

Yureka

