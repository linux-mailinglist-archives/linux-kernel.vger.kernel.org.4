Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF0E70414D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 01:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245565AbjEOXHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 19:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjEOXHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 19:07:35 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0106E94
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:07:15 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f50020e0f8so5572515e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684192033; x=1686784033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6j/nsOgHTR4HSwmATJ+gjDXbPDspqE4tDffur2pBUW8=;
        b=kuHveEzNq4//+GGfS7POo3gtgBRRd++3cNEtMqG8NuA81QDSNRW4tUfJ7y4mBm2mp0
         nITD5lFF5swL0tse+s7SsztgD3/pnMOCM8yANNmc0fYGOnP+gMD2m/uDJyvuhzHzVKlx
         HaQeUS9pVMsPL0fcr9OXh86qsgI8SIbKumC4XUU5Qz0a8TSekVPIlnw7NWfpv0O+EqP0
         tRQL5K2eusLdp0AUhkwUREta6hBmPPypEPYjfUtTTxJZUZ9lDth0Fny8DdtsDpM+R9Zo
         98s7YgZGojwckrAMdYq6a9Evt9JnythOHCOdpx+YCHFYiuaSAHWcuAYSZ3d8/ukocali
         tnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684192033; x=1686784033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6j/nsOgHTR4HSwmATJ+gjDXbPDspqE4tDffur2pBUW8=;
        b=c7iHyPUta5rQsby8tsqzrCyd+s2e3Dv/j1TcMDbRKWTWeDPMYd2Zn/0QGRsX9/7MnA
         dkqxRiqIDA668nPPRc5u0Ug2ezFwLHGXP4tw60Ce16y1NYMl52Tn1W5LPNw0ioVo4s0I
         ai5ZYPIJWm8QFnymH/D9SjYBzEvIbaiE/pwG0UGa8TSsqZRv1bJKBMN+JW7itYXOkJaR
         tdITJNdbu+zFthhFjsLsRXsB4ZOueMhVsfstxF1WEt/HR83E3hjoTRuulRV1HY0/QzH2
         ljOqbnGHbj2WkmFR+9MniR+B1sOezln2jfdo/pA3DBGT2hEpLgZgb3cnb4vYCtCqZlP/
         Uj6w==
X-Gm-Message-State: AC+VfDyqJrJBztocq7mXo8VlCyumt5o2p8+sEZo3c6e55KiYz35/g4JD
        lXs6wnvTUsl6WIP57/aqnQw=
X-Google-Smtp-Source: ACHHUZ7e4XGwKLFeai3EYTdxhXJNrtTXJ3tfSWzkgKRlHyGnyxzT9D47ODs5gApWq4D66xu28G9ijA==
X-Received: by 2002:adf:dfc7:0:b0:307:c0c4:1094 with SMTP id q7-20020adfdfc7000000b00307c0c41094mr14016148wrn.34.1684192033343;
        Mon, 15 May 2023 16:07:13 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id q6-20020adfcd86000000b00307a83ea722sm505531wrj.58.2023.05.15.16.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 16:07:12 -0700 (PDT)
Date:   Tue, 16 May 2023 00:07:11 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] mm: userfaultfd: avoid passing an invalid range to
 vma_merge()
Message-ID: <20abea10-5307-498b-b9df-8f0b2fed1701@lucifer.local>
References: <20230515193232.67552-1-lstoakes@gmail.com>
 <ZGKjvceDfpKMxtfb@x1n>
 <bcfb0376-ccf4-4467-9da5-8ae6f1c86876@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcfb0376-ccf4-4467-9da5-8ae6f1c86876@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 11:04:27PM +0100, Lorenzo Stoakes wrote:
[snip]
> > Could you explain a bit why we don't need to merge in this case?
> >
> > I'm considering, for example, when we have:
> >
> >   vma1(range 0-9, with uffd), vma2(range 10-19, no uffd)
> >
> > Then someone unregisters uffd on range (5-9), iiuc it should become:
> >
> >   vma1(range 0-4, with uffd), vma2(range 5-19, no uffd)
> >
> > But if no merge here it's:
> >
> >   vma1(range 0-4, with uffd), vma3(range 5-9, no uffd), vma2(range 10-19, no uffd)
> >
> > Maybe I missed something?
> >
>
> There's something really, really wrong with this. It simply isn't valid to
> invoke vma_merge() over an existing VMA that != prev where you're not
> specifying addr = vma->vm_start, end == vma->vm_end.
>
> This seems like you're relying on:-
>
>   ***
> CCCCCNNNNN -> CCNNNNNNNN
>
> By specifying parameters that are compatible with N even though you're only
> partially spanning C?
>
> This is crazy, and isn't how this should be used. vma_merge() is not
> supposed to do partial merges. If it works (presumably it does) this is not
> by design unless I've lost my mind and I (and others) have somehow not
> noticed this??
>
> I think you're right that now we'll end up with more fragmentation, but
> what you're suggesting is not how vma_merge() is supposed to work.
>
> As I said above, giving vma_merge() invalid parameters is very dangerous as
> you could end up merging over empty ranges in theory (and could otherwise
> have corruption).
>
> I guess we should probably be passing 0 to the last parameter in
> split_vma() here then to ensure we do a merge pass too. Will experiment
> with this.
>
> I'm confused as to how the remove from case 8 is not proceeding. I'll look
> into this some more...
>
> Happy to be corrected if I'm misconstruing this!
>

OK, so I wrote a small program to do perform exactly this case [0] and it seems
that the outcome is the same before and after this patch - vma_merge() is
clearly rejecting the case 8 merge (phew!) and in both instances you end up with
3 VMAs.

So this patch doesn't change this behaviour and everything is as it was
before. Ideally we'd let it go for another pass, so maybe we should change the
split to add a new VMA _afterwards_. Will experiment with that, separately.

But looks like the patch is good as it is.

(if you notice something wrong with the repro, etc. do let me know!)

[0]: https://gist.github.com/lorenzo-stoakes/a11a10f5f479e7a977fc456331266e0e

[snip]
