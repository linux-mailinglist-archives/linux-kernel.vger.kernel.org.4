Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D64A64D290
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiLNWqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLNWp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:45:59 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840692F667;
        Wed, 14 Dec 2022 14:45:54 -0800 (PST)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 2447343598;
        Wed, 14 Dec 2022 22:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1671057950;
        bh=jNfxgcjTNSBTXONPgkpyCwV4HUQZqAd+KNcHlXwVZ6Q=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=onvzqVCHIPy+LRzF9Oe4wXUGtti/4LVSxpezkHHt1UmLIImZvny6iQR5/Wy8KPbRs
         ZrkfS5XnQpWBEiCYCHofH1/Er37gqDCWrJnQ3N9BP/mrcIs3qUxG1CMYnhQgQFc8Za
         BmEmgjQRYHxvR1yUr80ezHYrPGLmhtUxX1e0Uj3frCBrNWE7FrMLldP6L7dNbguzjr
         qSKJ7aCNtPbFE/kWDIvgLH2c/eHLxckDMdJdG5C3BVwn7otPDTzelmGYDJjvbhEPZg
         EGGUsQ86NSbgjC/MNTUbf97l3/MxdhCn9zdr1ptmYmlZ87VPxQ1i1HA5q0sMePlsEK
         vf/xn9bP+sIww==
Message-ID: <466869a2-b583-2c7a-5b23-d0ce9797a6bd@canonical.com>
Date:   Wed, 14 Dec 2022 14:45:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [GIT PULL] apparmor changes for v6.2
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <218cac2c-47ae-435d-d7d0-48e4937a7f99@canonical.com>
 <CAHk-=wiBjnEtm8cFBp=6YNFe51z6Mdb-BbEJyfka9w1fkWfPvg@mail.gmail.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <CAHk-=wiBjnEtm8cFBp=6YNFe51z6Mdb-BbEJyfka9w1fkWfPvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/22 13:54, Linus Torvalds wrote:
> On Wed, Dec 14, 2022 at 10:36 AM John Johansen
> <john.johansen@canonical.com> wrote:
>>
>> John Johansen (45):
>>         apparmor: make unpack_array return a trianary value
> 
> John, this is unacceptable.
> 

ack, sorry.

> I noticed it due to the conflict, but this really is garbage.
> 
> First off, the word is "ternary" (or possibly "tristate").
> 
> Secondly, we don't do types like this
> 
>      #define tri int
> 

ack

> and even if we did, that's a *horrible* name not just for a type, but
> for a #define.
> 
> Finally, what the heck is "TRI_TRUE/TRI_NONE/TRI_FALSE"? WTF?
> 
> It looks like it is used in one single place - the return value for
> "unpack_array()" (now renamed "aa_unpack_array()"), and the TRI_FALSE
> case is basically an error case for an invalid case.
> 
> And TRI_NONE is just a *different* failure case ("name does not exist"
> vs "data is invalid").
> 
> And then, to make matters worse, ABSOLUTELY NOBODY CARES ABOUT THE
> DIFFERENCE. All real users just want to see TRI_TRUE (for "success"),
> and anything else is an error anyway.
> 
right, the end goal being not two invalid cases but a case of this
is optional but if not present some default data needs to be tied
in. This can be represented different ways, and using the int as
you suggest below seems like the right way to go.

It also looks like I kicked out the following patch that used this
mess, for further revision and sadly didn't drop this one as well.

> Yes, yes, there's that one KUNIT test, which wants to actually see
> that TRI_FALSE because it's testing that array-out-of-bounds case. It
> also - for some unfathomable reason - seems to then want to see some
> particular pointer values in that invalid data after the failure,
> which seems bogus, but whatever.
> 
> In other words, that type is badly done and mis-named to start with,
> but then the different ternary values themselves are confusingly
> mis-named too in ways that make no sense.
> 
> And to cap it all off, NOBODY CARES about those horrid things anyway.
> 
> Anyway, I started out doing the mindless conflict resolution, but then
> I just couldn't deal with that 'tri' type. There were just too many
> things wrong with it for me to accept it, and I felt dirty for just
> editing it.
> 
> Then I tried out just making it a
> 
>       typedef enum { TRI_TRUE/TRI_NONE/TRI_FALSE } ternary_t;
> 
> which fixes some of the syntactic issues.
> 
> But the whole naming confusion of the values and how NONE-vs-FALSE
> wasn't actually a useful distinction anyway made me just axe it
> completely.
> 

okay

> I'm honestly baffled by why you didn't just make it return the size or
> a negative error code, like is the norm. The size is limited to 16
> bits anyway, so returning an 'int' with a negative error would have
> been very natural.

indeed, tbh I have no clue why. As you say the int type fits right
in with existing kernel code, and doesn't have any range problems.

> 
> But just to keep the pattern with some of the other users, and
> minimize my surgery, I made it just return 'bool'.
> 
okay

> I'm sorry to do all that surgery on it, but I just couldn't stomach
> doing anything else.
> 

understandable

> The resulting merge diff is fairly messy, and to make matters worse I
> can't actually *test* any of this. But the code looks more palatable

I will make sure it gets run through all the testing

> to me, and I did try to be careful about my surgery.
> 
as always, I have no worries about that

> Apologies if I broke something,
> 

none, needed. You did what you needed to do. If needed I will follow-up
with a patch.


