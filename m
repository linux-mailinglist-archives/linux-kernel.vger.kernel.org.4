Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133AB72AF86
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 00:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjFJWfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 18:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjFJWfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 18:35:05 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B47D3A87
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 15:35:03 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f7353993cbso22247355e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 15:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686436502; x=1689028502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ag0KvnrINiKF0/PZIxk1qYCQu6jO10rq427ozyOq42c=;
        b=NP0/Wz1Tz1fKtEVZa781o3518k6MVjaghaie2tpAXbvIOEzk2JT3MKtHQEg+W4uTcz
         cb7DKdgslE0+gMYmNxmJ9IdSuf7jnLlmMV/RIS5NSj+xUHlJmbal+H/eBY/c5LYKdQMS
         baDq9w7DfbB2PIF9aZ8hg6cjAT7w6Mxr54ufbINjUGArE7v0hWuw6eQkDWVs6mPDMVLi
         CHfLcWpJDxplNDHGV+q/nti89JLtL1zqVhXfmSaIMWW3Tr6uaiGafu3SuftrCCHPkmOp
         3dRoJtmEamVw81AjfibcurDnDwCFQHEoJWTPXC6CH6DCyIlyh48MoEca1Ok941nqzADt
         OfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686436502; x=1689028502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ag0KvnrINiKF0/PZIxk1qYCQu6jO10rq427ozyOq42c=;
        b=AO1JxyLDYH2byzU63DEPwqUT6LAffGGppCNpC69TphbBVvxGr+DoCb34VOYLCcMMGs
         BDynVShGnRCPYEHR46Q342BDYo/O2ttuq07PVN9zjDFlO5vys7bsWnfQ2Setzt69zHSn
         pjRkURUGolJL1JGhCpIv95mPSiN6SiwN6OUAPlhQZU/4XTNuIUso+r/JNLtPk2531tif
         hRptfXVjEnZbVHuF2dzm4JHmScb7Aa+euE5NrQeEaoeigZDNpnNwLt7/zw55/xP5sbPH
         kRJmgu6MG0WS57Hyd6hK2+OdUzkBdpjKJkNn3ZsJdj5cCVpomzvOW1XhC/FCnwMBSU4N
         Q1lQ==
X-Gm-Message-State: AC+VfDzBN1+pKtZeFSufLwM8ymuVnpi+WHadF3yOSDzUUnYYGkN/D9a3
        LUZQXx9gFNIruv3hLKvrmrg=
X-Google-Smtp-Source: ACHHUZ4RyqsUbtYL/K2/C9gh98Wubcn46BOE9v/d4wUY7YupfJZVkkmCUXfMaQAoLDeUA69ts6poBQ==
X-Received: by 2002:a1c:f418:0:b0:3f6:1ac:5feb with SMTP id z24-20020a1cf418000000b003f601ac5febmr4580845wma.16.1686436501520;
        Sat, 10 Jun 2023 15:35:01 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id f13-20020a056000036d00b0030aefa3a957sm8085429wrf.28.2023.06.10.15.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 15:35:00 -0700 (PDT)
Date:   Sat, 10 Jun 2023 23:35:00 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Lu Hongfei <luhongfei@vivo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "open list:VMALLOC" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: Re: [PATCH] mm/vmalloc: Replace the ternary conditional operator
 with min()
Message-ID: <5597fc8f-43ed-457a-a777-4dbf52d0fbe0@lucifer.local>
References: <20230609061309.42453-1-luhongfei@vivo.com>
 <832d7c69-ffd5-4764-8ffe-3a02bef0efb0@lucifer.local>
 <3fc87d60-4e81-4f49-95f0-0503ad5cdf35@lucifer.local>
 <f53f28de489f4c209776e404323ef5a1@AcuMS.aculab.com>
 <ba45584f-41a2-4d06-8443-e7e64375b07f@lucifer.local>
 <3e35b679f17a434b9da2ceffba086bfa@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e35b679f17a434b9da2ceffba086bfa@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 10:18:34PM +0000, David Laight wrote:
> From: Lorenzo Stoakes
> > Sent: 10 June 2023 22:07
> ...
> > > > OK, as per the pedantic test bot, you'll need to change this to:-
> > > >
> > > > num = min_t(size_t, remains, PAGE_SIZE);
> > >
> >
> > Ordinarily I wouldn't respond to this (I go into why I feel this is not
> > useful commentary below) but I am concerned Lu will take you seriously.
> >
> > > There has to be a valid reason why min/max have strong type checks.
> >
> > I really don't know what you mean by this? Yes there is a reason, I imagine
> > it's to avoid unfortunate and invalid type comparisons.
>
> Indeed, the 'unfortunate conversion' is a negative value
> being converted to a large positive one.
> That doesn't require anything like the type checking that min/max do.

Yes this is precisely what I thought it ought to be protecting again

>
> > This is not applicable here (explained below...)
> >
> > > Using min_t() all the time is just subverting them and means that
> > > bugs are more likely than if the extra tests in min() were absent.
> >
> > 'All the time' - are you just having a general whine + moan about perceived
> > kernel practices? Can you please keep it focused on the actual issues at
> > hand? I am not Linus and therefore not responsible for the entirety of the
> > kernel.
>
> I see a general problem (that Linus ought to worried about)
> is that whenever min() reports a type error the answer is
> do immediately drop in a min_t() instead of looking at the
> type of the values and fixing them to that min() doesn't complain.
> (Or fixing min() so it doesn't object to a much larger class
> of comparisons.0

Sure, but it's not really relevant here for the reasons I went
into. Probably as Andrew says elsewhere in the thread, PAGE_SIZE not being
size_t is pretty annoying.

>
> ...
> > > A 'safe' change is min(remains + 0ULL, PAGE_SIZE).
> >
> > So now we're promoting an unsigned int (and sometimes unsigned long of
> > course) to an unsigned long long (for reasons unknown) and comparing it
> > with an unsigned long? Wouldn't this trigger the sensitive type check
> > anyway?
>
> PAGE size is defined to be 'long long' - so min() will be happy.
> The compiler will just DTRT, even if 'remains' is 32bit it will
> optimise away all the implied 64-bit extension.

It's unsigned long in every arch I've seen right? And in a 32-bit arch long
long will be 64-bit, so I think you'd still have the error here.

>
> Almost all the min_t() are min_t((some unsigned type),a,b).
> If the values are known to be positive then:
> #define min_unsigned(a, b) min((a) + 0u + 0ul + 0ull, (b) + 0u + 0ul + 0ull))
> will zero extend whatever type is supplied before the comparison.
> The compiler will just discard zero extensions.
>
> > To be clear, I'd nack any such ridiculous change unless a hugely compelling
> > reason is given (you've not given any). That's horrific. And again, you've
> > not provided one single example of an _actual_ bug or situation where the
> > 'problem' you tiresomely raise would occur.
>
> The (size_t) cast isn't in itself a problem - provided you've
> checked that it is larger than the types of both sides.
> But search the kernel and you'll find places when min_t((u8),a,b)
> is used.
> This all follows the same pattern of min() gave a warning so
> so use min_t().

Yes obviously instances of inappropriate narrowing are horrible, but that
isn't happening here.

In this specific instance, for any actual architecture in reality there is
no issue.

I do absolutely agree we should address the instances where an
inappropriate type is used.

>
> ...
> > > But, in reality, min/max should always be valid when one
> > > value is a constant between 0 and MAX_INT.
> >
> > This is getting at a signed/unsigned comparison issue here afaict which is
> > not the one we're dealing with here.
>
> But it is exactly what min() is checking for and almost why min()
> exists.
> A min_unsafe() that didn't try to do any checks would be better
> than train wreck that min_t() can create.

All this ultimately sounds like a broader criticism of the min/max type
checks and not really relevant to this patch, that should be addressed at a
more general level.

>
> ...
> > Now since you kicked off this 'all the time' stuff I feel like I have been
> > given permission to make some broad comments myself...
> >
> > David, I am not one to commit-shame being a minor contributor myself buuuut
> > I see 7,610 messages from you on lore and 4 commits, all from 4 years ago
> > (please correct me if I'm wrong).
>
> I don't work for google, intel, aws (etc).
> Getting patches accepted is surprisingly hard.
>

Yes, sorry, I was probably a little too mean there (long hot day and up too
early) I didn't mean to be personal, what I was saying in blunt fashion is
the commentary needs to be proportionate to the problem and placed at the
right position, I don't feel this is.

By the way I can relate on this fully as I'm a 100% hobbyist who does this
part time (and writing a book on mm, yes I should get out more), and I know
how difficult it can be to get patches in!

> I've been writing device driver and comms protocol stack code
> for best part of 40 years.

Yes again apologies, I really didn't mean anything personal, I just found
the review a little frustrating. You are certainly more experienced than I
am! :)

Cheers, Lorenzo

>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
