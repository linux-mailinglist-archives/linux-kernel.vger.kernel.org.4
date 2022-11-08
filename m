Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F01621D64
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 21:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiKHUE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 15:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiKHUE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 15:04:27 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB9554B0B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 12:04:26 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id w26-20020a056830061a00b0066c320f5b49so8993082oti.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 12:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I5xNZkJ1MAi/yGbEX7wytu+Bp4ajKUtPbyWuXkHlBIo=;
        b=OYUl9+pvY6vZS8KEots9DY8qgY3RzaxsufawXROsLjFHVDov17JCl7mVtVdnVtr99r
         wdtldbMf9/fgvts16BuNFF5LkybA4tnF+8AfIVpkgTp2Iej9+1eR7NzDwonqYp578TW7
         NCRBXg9K4QOLJtPNWYWC2HuOhxhGu8OCcoiic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5xNZkJ1MAi/yGbEX7wytu+Bp4ajKUtPbyWuXkHlBIo=;
        b=X0S58B3I5IYZqaNjT2oZKbnwpb5+MMWxfii7+xaPJ2/77Ava/fy3+vOFjh/OREPouK
         kcj8Ml4tt6ZMUsXpDaEZQA6fj/PxZMY/4il+EDxKsx3p8Q5fBNFZWgwWWvh5Itbg22GK
         DUqDCaDn1G2w9FC2CmUGH5GbztTOZ6ByXKMnj72pe0BtrvA0E+hM7ijeaz8X73H9/ab6
         eaXuhFjsIgzuOkEZ/FvgnN7r3Z4TdtHSti6yWWxKh25y1DiRrxt0VtYSXQmdUBvKkW+E
         vOGXcFoyNsOCXimy/22E/nYlJPHQaCD8JadxQ94XiJFVLCCAjRo8Erh2L9lDN+L2xuxx
         W2nw==
X-Gm-Message-State: ANoB5plNDfRk61KcgW358I6HFH243ZkC4qfC2h7xEwvTXo3WKN1ndhul
        PTBfuBcAkvzne5R5qtcgsv46aLxKkDE2IA==
X-Google-Smtp-Source: AA0mqf4aEiDIuSsEItSLFlQKPHEMGqO0GmI7mc0u0Z3dhulha3hiULTFcD1yrysB6A+b01bGWl49eQ==
X-Received: by 2002:a9d:62cb:0:b0:66c:e6c9:8704 with SMTP id z11-20020a9d62cb000000b0066ce6c98704mr6103451otk.61.1667937865366;
        Tue, 08 Nov 2022 12:04:25 -0800 (PST)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id x12-20020a05683000cc00b0065c2c46077dsm4461398oto.67.2022.11.08.12.04.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 12:04:24 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id g15-20020a4a894f000000b0047f8e899623so2186849ooi.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 12:04:23 -0800 (PST)
X-Received: by 2002:a05:6902:1352:b0:6bb:3f4b:9666 with SMTP id
 g18-20020a056902135200b006bb3f4b9666mr52258496ybu.101.1667937389617; Tue, 08
 Nov 2022 11:56:29 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
 <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
 <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
 <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com>
 <Y1+XCALog8bW7Hgl@hirez.programming.kicks-ass.net> <CAHk-=wjnvPA7mi-E3jVEfCWXCNJNZEUjm6XODbbzGOh9c8mhgw@mail.gmail.com>
 <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com>
 <Y2SyJuohLFLqIhlZ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CAHk-=wjzp65=-QE1dg8KfqG-tVHiT+yAfHXGx9sro=8yOceELg@mail.gmail.com>
 <8a1e97c9-bd5-7473-6da8-2aa75198fbe8@google.com> <Y2llcRiDLHc2kg/N@cmpxchg.org>
 <CAHk-=whw1Oo0eJ7fFjy_Fus80CM8CnA4Lb5BrrCdot3Rc1ZZRQ@mail.gmail.com>
 <CAHk-=wh6MxaCA4pXpt1F5Bn2__6MxCq0Dr-rES4i=MOL9ibjpg@mail.gmail.com> <CAHk-=whi2BB9FviYiuUWV0KHibP_Lx_CWDWkxxv3SXA1PKV0Lg@mail.gmail.com>
In-Reply-To: <CAHk-=whi2BB9FviYiuUWV0KHibP_Lx_CWDWkxxv3SXA1PKV0Lg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Nov 2022 11:56:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wivgyfywteXoO7K0Mj_KoCRF-RyXDH-eGW0A_fev+dGug@mail.gmail.com>
Message-ID: <CAHk-=wivgyfywteXoO7K0Mj_KoCRF-RyXDH-eGW0A_fev+dGug@mail.gmail.com>
Subject: Re: mm: delay rmap removal until after TLB flush
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Konstantin Ryabitsev <mricon@kernel.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Uros Bizjak <ubizjak@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 8:28 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'm sending this out because I'm stepping away from the keyboard,
> because that whole "let's massage it into something legible" was
> really somewhat exhausting. You don't see all the small side turns it
> took only to go "that's ugly, let's try again" ;)

Ok, I actually sent the individual patches with 'git-send-email',
although I only sent them to the mailing list and to people that were
mentioned in the commit descriptions.

I hope that makes review easier.

See

   https://lore.kernel.org/all/20221108194139.57604-1-torvalds@linux-foundation.org

for the series if you weren't mentioned and are interested.

Oh, and because I decided to just use the email in this thread as the
reference and cover letter, it turns out that this all confuses 'b4',
because it actually walks up the whole thread all the way to the
original 13-patch series by PeterZ that started this whole discussion.

I've seen that before with other peoples patch series, but now that it
happened to my own, I'm cc'ing Konstantine here too to see if there's
some magic for b4 to say "look, I pointed you to a msg-id that is
clearly a new series, don't walk all the way up and then take patches
from a completely different one.

Oh well. I guess I should just have not been lazy and done a
cover-letter and a whole new thread.

My bad.

Konstantin, please help me look like less of a tool?

                    Linus
