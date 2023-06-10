Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0856072AEEA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 23:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjFJVGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 17:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFJVGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 17:06:40 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027CB2D5F
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 14:06:39 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f6e13940daso30844505e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 14:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686431197; x=1689023197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X5ArI60pwrVQ9QtvOiBmsqb2naBz+wYYySCL2f0Q330=;
        b=GN1cYCm8jIPAnGzJ0FOvYkmUjevdIV2yV98Wj7ie9p5IHjxl8OoO/Gly8jKSKGXKQC
         OeXQtfnm2az1De2gF4OLidOlRv3aij+HvOI1Q8j4G6uvT6TBgatmhMBjMKlYwLNQUKl6
         kqOlckLR9qsb9f2jPGm9USsE98WLC8Oacsxk101Gv4y1SfjP4f8y/WlOXrNzEiE3yoFT
         itpWEOUSP2OLtXd7RGOHIdxgEAVA6GDTJ3nruXYO23uxP+TnrlOat2NlCtLX1Ee/ZLeW
         eGLWqpY+ZU5SMxndxOZzmEjmXxgr2JlXUlrPhDGxQqy2/mQjkwoLstxJIZBY6fatO6/Z
         6DiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686431197; x=1689023197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5ArI60pwrVQ9QtvOiBmsqb2naBz+wYYySCL2f0Q330=;
        b=E2kdUnsE3JnlsEKTYFo4YWCHvPesfk5eaCgp5VegcsyMcV2blmNyKh5Ib6XN3IG55z
         10O4V1bAq32ZLz4AoSL9X+05QsEBLOz+oaBJvr19UD67C19T8oeYsfxIuPrnItbSKIoW
         E2SVCLfKbEZeyV9BA4XWB1hpWSS0MA0CL3spk5EWGUvN3vCFkjUOlVAxGlVktZRM03go
         ltoXlLwDVi5LTAMCfmdAP1UMbMchFYATjmYHyol3zDUmCDnwTlco9rWaBGm5eAiv367+
         6WORNV0qlG3AMYP/jXgG/x35qRE/WstSgf+ovgB3ukf331hQNKlQ80ke0aWe+QW/p6rJ
         VLWg==
X-Gm-Message-State: AC+VfDz542FI1UR7vhcK7fR81sl4IoDL8P5MqVaihKYL3WOY9Zgz+Mof
        fzfR+vHIQIncytuZfJaPO4c=
X-Google-Smtp-Source: ACHHUZ7MIniEsJWEN9mxZwxrNwtRplQSqR1r0lv8GzyQAtPC08CV2xLL8oMikacDqE4tS4cAHEO4ng==
X-Received: by 2002:a1c:7c08:0:b0:3f7:e80b:bfc with SMTP id x8-20020a1c7c08000000b003f7e80b0bfcmr4629154wmc.30.1686431197093;
        Sat, 10 Jun 2023 14:06:37 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id q11-20020a056000136b00b002f9e04459desm7861271wrz.109.2023.06.10.14.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 14:06:35 -0700 (PDT)
Date:   Sat, 10 Jun 2023 22:06:35 +0100
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
Message-ID: <ba45584f-41a2-4d06-8443-e7e64375b07f@lucifer.local>
References: <20230609061309.42453-1-luhongfei@vivo.com>
 <832d7c69-ffd5-4764-8ffe-3a02bef0efb0@lucifer.local>
 <3fc87d60-4e81-4f49-95f0-0503ad5cdf35@lucifer.local>
 <f53f28de489f4c209776e404323ef5a1@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f53f28de489f4c209776e404323ef5a1@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 08:09:28PM +0000, David Laight wrote:
> From: Lorenzo Stoakes
> > Sent: 09 June 2023 09:49
> > On Fri, Jun 09, 2023 at 08:09:45AM +0100, Lorenzo Stoakes wrote:
> > > On Fri, Jun 09, 2023 at 02:13:09PM +0800, Lu Hongfei wrote:
> > > > It would be better to replace the traditional ternary conditional
> > > > operator with min() in zero_iter
> > > >
> > > > Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> > > > ---
> > > >  mm/vmalloc.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index 29077d61ff81..42df032e6c27
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -3571,7 +3571,7 @@ static size_t zero_iter(struct iov_iter *iter, size_t count)
> > > >  	while (remains > 0) {
> > > >  		size_t num, copied;
> > > >
> > > > -		num = remains < PAGE_SIZE ? remains : PAGE_SIZE;
> > > > +		num = min(remains, PAGE_SIZE);
> >
> > OK, as per the pedantic test bot, you'll need to change this to:-
> >
> > num = min_t(size_t, remains, PAGE_SIZE);
>

Ordinarily I wouldn't respond to this (I go into why I feel this is not
useful commentary below) but I am concerned Lu will take you seriously.

> There has to be a valid reason why min/max have strong type checks.

I really don't know what you mean by this? Yes there is a reason, I imagine
it's to avoid unfortunate and invalid type comparisons. This is not
applicable here (explained below...)

> Using min_t() all the time is just subverting them and means that
> bugs are more likely than if the extra tests in min() were absent.

'All the time' - are you just having a general whine + moan about perceived
kernel practices? Can you please keep it focused on the actual issues at
hand? I am not Linus and therefore not responsible for the entirety of the
kernel.

Unless this is a more specific accusation that I personally use min_t()
'all the time'? Unhelpful.

>
> The problem here is that size_t is 'unsigned int' but PAGE_SIZE
> 'unsigned long'.

The reported issue in the kernel bot report is this yes (please be more
specific!) You speak generically, but what you mean to say of course is 'in
some architectures' this is the case.

However in those same architectures, unsigned long will be equal to word
size, will it not? So the data types are in fact equivalent in all cases?
Can you propose one which is not?

If not then your whole commentary here is... just irrelevant bikesheddy
noise? Right?

I will absolutely need an example of a supported architecture where
sizeof(size_t) != sizeof(typeof(PAGE_SIZE)). I am happy to be embarrased
and to be provided one simply out of interest + learning :)

Of course even if there were such an arch, it wouldn't even matter in this
case (I go into this in next response...)

> A 'safe' change is min(remains + 0ULL, PAGE_SIZE).

So now we're promoting an unsigned int (and sometimes unsigned long of
course) to an unsigned long long (for reasons unknown) and comparing it
with an unsigned long? Wouldn't this trigger the sensitive type check
anyway?

To be clear, I'd nack any such ridiculous change unless a hugely compelling
reason is given (you've not given any). That's horrific. And again, you've
not provided one single example of an _actual_ bug or situation where the
'problem' you tiresomely raise would occur.

In fact I'll nack any change along the lines of your commentary here unless
you can give a practical, compelling reason to change something rather than
broad handwaving.

I mean I'm guessing what you mean is in an unspecified architecture size_t
is unsigned int (== uint32_t) and unsigned long is uint64_t, PAGE_SIZE is
larger than 4,294,967,296 bytes and by casting first we truncate it?

This sounds very practical and I'm extremely glad you raised it.

Obviously if you can give a single example of an actual bug or issue that
could arise here (or correct me here!) I'd be interested to hear.

>
> But, in reality, min/max should always be valid when one
> value is a constant between 0 and MAX_INT.

This is getting at a signed/unsigned comparison issue here afaict which is
not the one we're dealing with here.

> The constant just needs forcing to 'signed int' (eg assigning
> to a temporary on that type) before the comparison (etc).

So now you're proposing a signed vs unsigned comparison? Or now is the 'one
value' not a constant but instead both need to be made signed?

Again, please explain one compelling example of any kind that gives
validity to any of your commentary here _in this specific case_ rather than
a perceived broad abuse of min_t()?

>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>

Now since you kicked off this 'all the time' stuff I feel like I have been
given permission to make some broad comments myself...

David, I am not one to commit-shame being a minor contributor myself buuuut
I see 7,610 messages from you on lore and 4 commits, all from 4 years ago
(please correct me if I'm wrong).

You have a reputation as somebody who loves to bikeshed and add tiresome
and trivial commentary to code reviews. I am not sure this review helps
that reputation.

Might I suggest rather than wading in with hand'a'wavin' making might I be
so bold as to say bordering on rude comments, you might do better adopting
a little courtesy and perhaps something in the way of _specific_ review
rather than fist waving at a cloud. Specificity is vital in code review.

Such courtesy is especially appreciated on drive-by reviews which I
absolutely welcome as long as the comments are sensible and presented with
courtesy, however you have failed at both here so I'm afraid I am not sure
_this specific_ commentary is quite so welcome.

Lu - please take no action based on David's comments.
