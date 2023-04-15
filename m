Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50EF6E2FA6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 10:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjDOIL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 04:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDOILZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 04:11:25 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116A35B93
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 01:11:24 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f0a0c4e1ebso3021595e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 01:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681546282; x=1684138282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S22VGJ0XRDXPgrrj923zdow2tJJ05sGU7B7/V2tOQBg=;
        b=quL1RzOYTYd3ZlRj1et56cpDCoNofX4HxgFTt3/WOt0D+jF3i1YiF7oHmiEcfv6J+r
         f4VflBM5rK1rhvRjz2sUYimHnzLgK25ZMox99kXvJgv3ICevBuOT+Sp2ktP9wzUTXCUR
         KqQQaJB12U/QKq8iExb3Yq3e3p6hBTtJFAbwi/z03DNGW49cliXilt7Vg9/3UhtvQRJ3
         VrWC1V4K+egqoqSn9XYBk/HL0sTfVba+CVPW/F7IL1Yx4qR1mdVETHChAyDGImGmEZLn
         VTSMFF+BeS7Ah6OoUS0kWVxwIWLjRrA2ruBxWrUkipgcQ5vtJKVL33ojE6RA94BpFhFH
         qK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681546282; x=1684138282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S22VGJ0XRDXPgrrj923zdow2tJJ05sGU7B7/V2tOQBg=;
        b=dUNJAVHuI1ORoBiLgvG6/JyvNiUhx51h2xnmLtADIzR85Ql2DU3EcOTUA1Pf7rOn3b
         Eogx3sdwiAymhkw+O7cLIVLDu/rEK0BfnFUjfRZfIwpsJuYNvIE0D/bj5iuKf3c8YuZR
         s7E1exa5hDgD2MDlWTEAWGNiwiLiCX0Rzgnz7AqfdKQxDGS50SSdd+pAytWyyuRbBu66
         x59nxeDEzPZ5k50WNZ0fVnYY37C14ei6v9yWZ3xznL3fffv0i+cYrjNI04bBwcIwFiNb
         fBXVgPInYesDXKsfcQr9U9hLgFQI57eK23dh0vPx11YmiGd6WNOpShJMzeEInIboCQp/
         CSyA==
X-Gm-Message-State: AAQBX9dz3gbn8HlGAl7rNmjfC7g93YM7ZeZ5E9NOfojpqwX1Rq66rCv4
        YNI2ObczNQKI7xXdwmeNcWM=
X-Google-Smtp-Source: AKy350ZFUOV3lb/N3pwovfqQKqxVveAM/jucyDTRW7rG76eyJpc8VgDXj2V71JE5in0yCsfw4yn+hA==
X-Received: by 2002:adf:e38d:0:b0:2f5:953a:4f59 with SMTP id e13-20020adfe38d000000b002f5953a4f59mr1353918wrm.5.1681546282383;
        Sat, 15 Apr 2023 01:11:22 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id i4-20020a5d55c4000000b002f74578f494sm2834402wrw.41.2023.04.15.01.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 01:11:21 -0700 (PDT)
Date:   Sat, 15 Apr 2023 09:11:20 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] mm/gup: remove vmas parameter from
 get_user_pages_remote()
Message-ID: <e712589f-f4c0-4037-8a3c-0d48bd35baef@lucifer.local>
References: <cover.1681508038.git.lstoakes@gmail.com>
 <5a4cf1ebf1c6cdfabbf2f5209facb0180dd20006.1681508038.git.lstoakes@gmail.com>
 <e715ec72-682f-291c-7131-8355843660d0@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e715ec72-682f-291c-7131-8355843660d0@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 09:25:51AM +0900, Tetsuo Handa wrote:
> On 2023/04/15 8:27, Lorenzo Stoakes wrote:
> > diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> > index f5bcb0dc6267..74d8d4007dec 100644
> > --- a/arch/arm64/kernel/mte.c
> > +++ b/arch/arm64/kernel/mte.c
> > @@ -437,8 +437,9 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
> >  		struct page *page = NULL;
> >
> >  		ret = get_user_pages_remote(mm, addr, 1, gup_flags, &page,
> > -					    &vma, NULL);
> > -		if (ret <= 0)
> > +					    NULL);
> > +		vma = vma_lookup(mm, addr);
> > +		if (ret <= 0 || !vma)
> >  			break;
>
> This conversion looks wrong. When get_user_pages_remote(&page) returned > 0,
> put_page(page) is needed even if vma_lookup() returned NULL, isn't it?
>

You're right, though actually it's not possible for ret > 0 and vma != NULL
because the GUP code requires the VMA to exist for it to have returned > 0.

I was trying to be too cute here I think, actually we only want to be doing
that lookup if the GUP succeeded in any case.

Let me respin with a fix for this.
