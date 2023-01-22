Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA12B677060
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 17:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjAVQCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 11:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjAVQCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 11:02:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB351A4BF;
        Sun, 22 Jan 2023 08:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=/g9L+qiibEi9xUy2Z4GqwjBdwGnmjLETL+DDfll48JY=; b=DpDqm3hqj1PshDwnnQarEFdScI
        SLYYeXxI6y1dGddURkblGiQf4nV4jwTXtuQyjlEOUvUFD0jHqHW0DWBsoqgIxe/qY39eoCFtJeDzO
        psE0EpyXuMOWSAEYQ3BnqT9/kuah7lyX+ZNeBr4s6ms3uuJjryuj883jTNmy7rn0bTBPJR4E6yJef
        Ip617cCXufprrSqyGhygnCRgehbY/EZBQk3xqcfnUZSu3fD0dMpmpClqFHP8ijrDh1CJXbyJ8Fhou
        /BgX/dMK9pXnH3/GnUBn0gvDHLET2fN6TAGrkIiTVT3Znp+0Cy1J9VOiWGVWT7CvjeuTRxBd14uBM
        exwePYMQ==;
Received: from [2601:1c2:d80:3110::9307]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJcnX-00FWJ0-TK; Sun, 22 Jan 2023 16:02:23 +0000
Message-ID: <31dd9db6-413b-cddb-60e8-9e5d44ed8cb9@infradead.org>
Date:   Sun, 22 Jan 2023 08:02:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH: 1/1] sh4: avoid spurious gcc warning
Content-Language: en-US
To:     Jakub Jelinek <jakub@redhat.com>,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Cc:     linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.osdn.me>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        jakub@gcc.gnu.org
References: <52952170-f1a9-89a0-e307-f974ce2b7977@fu-berlin.de>
 <2085aec3-796b-71c3-7cb2-d4103d3b6175@infradead.org>
 <c74cad7b-9ea3-5223-8292-3fe1172a9419@mkarcher.dialup.fu-berlin.de>
 <Y80vRJfPJ4mIO8Cm@tucnak>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Y80vRJfPJ4mIO8Cm@tucnak>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/22/23 04:42, Jakub Jelinek wrote:
> On Sun, Jan 22, 2023 at 12:33:41PM +0100, Michael Karcher wrote:
>> Am 22.01.2023 um 08:00 schrieb Randy Dunlap:
>>>> -#define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
>>>> +#define _INTC_ARRAY(a) a, sizeof(a)/(_Generic((a), typeof(NULL): 0xFFFFFFFFU, default: sizeof(*a)))
>>> s/: / : / in 2 places.
>>>
>>> Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
>>
>> Thanks for your confirmation! Are you sure about the space before the colon?

Nope, my bad. Thanks, Jakub.

> No, it should be without those, see various other _Generic uses in
> include/linux/
> All those are formatted on one line for each case, so for the above macro it
> would be
> #define _INTC_ARRAY(a) (a), sizeof(a)/(_Generic((a),			\
> 				       typeof(NULL):	-1,		\
> 				       default:		sizeof(*(a)))
> or so.
> Anyway, two comments:
> 1) I'd use -1 as that would be after promotion to size_t the largest size_t
>    unlike 0xFFFFFFFFU; of course, as for the void * case a can't be an array,
>    any value > sizeof(void*) will do
> 2) if *a and a is fine (i.e. argument of the macro has to be really simple or
>    wrapped in ()s, then perhaps (a) as first operand to _Generic isn't needed
>    either, or use (a) in the two spots (sizeof(a) is of course fine) and
>    *(a)
> 
>> The colon in this case terminates a case descriptor for the type-level
>> switch construction using "_Generic". It says: "In case 'a' has the 'type of
>> NULL', divide by 0xFFFFFFFFU, in all other cases, divide by the size of a
>> single array element". It's not a colon of the ternary ?: operator, in which
>> case I would agree with the space before it.
>>
>> If you confirm that you want a space before the colon in this case as well,
>> I'm going to add it, though.
>>
>>> How far back in gcc versions does this work?
>>
>> I tested the support of _Generic on Compiler Explorer at godbolt.org. This
>> construction is rejected by gcc 4.8, but accepted by gcc 4.9.
> 
> Yeah, introduced in gcc 4.9, as I think kernel minimum version is 5.1, that is fine.
> And various headers already use _Generic.

and thanks for that info also.

-- 
~Randy
