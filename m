Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3654672487
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjARRLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjARRLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:11:04 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284CD4ABCE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:11:04 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id x5so6725500qti.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fdqIaz/OuT3KiECAYbJfl+d3yacajyE8FY/hHAgDXU4=;
        b=bW+I6GT3472rBqyqGwRHftx7r2GGIogKz2Y0oQTedgzUrfMCpXWKof68tlXZFbetUY
         2WATXsTp3RN1pb5gw6psBaXonl0PhuZDMJziCI8xLhFsEUJHCwD7EFzPgWd1Kuk7vxkd
         FZsGsrkAAdXlgWHrdqvwR81hEpMUYuiE/bHLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fdqIaz/OuT3KiECAYbJfl+d3yacajyE8FY/hHAgDXU4=;
        b=j0j3T6SbZ1asqztfQD647I3lb6qyU5yi4Etmkc4muXD4e0xWlubpryAwbWij3IWOcW
         6j2zAk7INoKpj3LylcLRGud8SFdTYp5ONFXQOrjzhGm0I5BJrBoDQ72kpmO8wSVTB5dV
         Oq8gIpe3xqf9JcvKKVelCdlYRSx7IDJ6bOH+mEvBwiWgz1yfdr5Wl2zclQ0FMLNZnYf5
         vqoUczYVONX+PrSSARY6we6moP8nUa9wa6ZDAJ/cu20g9rS3Q3mo+hLqUEHgkJOdMMxj
         Rgdgm11t9GzGvaxp0mzTM3RdNAM0mtM5f0UfDOp7LH7HlUen3KVQMRaDDLAn7kC+kKCS
         hxSg==
X-Gm-Message-State: AFqh2kr7PopMr9u5+LxqnTIsmwyOhzGSQciH8ulU5NJ2i/64Y6woS6X7
        WErsAtnvcqPzpOwj4HG5Dd1N2ydZvhaAX21D
X-Google-Smtp-Source: AMrXdXuyQSrKQF/2/p4PvGgNaWuZT+ychvqiooJSsRAhMiV+OldHjK6JWAPVUx+k1IHK6lr67wV2nA==
X-Received: by 2002:a05:622a:428a:b0:3ab:7391:28b with SMTP id cr10-20020a05622a428a00b003ab7391028bmr11197802qtb.6.1674061862854;
        Wed, 18 Jan 2023 09:11:02 -0800 (PST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com. [209.85.219.43])
        by smtp.gmail.com with ESMTPSA id l6-20020ac81486000000b003a981f7315bsm17769107qtj.44.2023.01.18.09.11.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 09:11:01 -0800 (PST)
Received: by mail-qv1-f43.google.com with SMTP id h10so24190083qvq.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:11:01 -0800 (PST)
X-Received: by 2002:a05:6214:5f82:b0:534:252f:b091 with SMTP id
 ls2-20020a0562145f8200b00534252fb091mr345510qvb.130.1674061861468; Wed, 18
 Jan 2023 09:11:01 -0800 (PST)
MIME-Version: 1.0
References: <202301170941.49728982-oliver.sang@intel.com> <2f483247-da76-9ec9-3e51-f690939f4585@suse.cz>
 <Y8ZVxJSZdtEk8Nco@feng-clx> <Y8aSc5xGO+rW2pyo@feng-clx> <CAHk-=wiS84nS9apjs_Vt=jjZ_+j+F8HQ3B+ABSvbzcqtW9x5Kg@mail.gmail.com>
 <Y8f0miUc//BQXN3A@feng-clx>
In-Reply-To: <Y8f0miUc//BQXN3A@feng-clx>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Jan 2023 09:10:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh0pdJm6tS4-ywR3Zi70PnBjMXeCkuQKnu8utcSKjxNEw@mail.gmail.com>
Message-ID: <CAHk-=wh0pdJm6tS4-ywR3Zi70PnBjMXeCkuQKnu8utcSKjxNEw@mail.gmail.com>
Subject: Re: [linus:master] [hugetlb] 7118fc2906: kernel_BUG_at_lib/list_debug.c
To:     Feng Tang <feng.tang@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        "Song, Youquan" <youquan.song@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>, hongjiu.lu@intel.com
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

On Wed, Jan 18, 2023 at 5:33 AM Feng Tang <feng.tang@intel.com> wrote:
>
> > Finally, your objdump version also does some horrendous decoding, like
> >
> >   c13b3e29:       8d b4 26 00 00 00 00    lea    0x0(%esi,%eiz,1),%esi
>
> I know little about these tools, and I tried objdump tool from
> Cent OS 9 (objdump version 2.35.2) and Ubuntu 22.04 (objdump version
> 2.38), they both dumped similar assembly. Please let me know if you
> want us to try other version of objdump.

It's fine - it just makes things even less legible than they already were.

I personally very seldom try to look at objdump output - I tend to do
things like

     make mm/page_alloc.s

and look at the compiler-generated assembly instead. That ends up
generally being a lot more legible for various reasons, not the least
of which is the variable name commentary that the compiler also
outputs.

So objdump is kind of a last resort, and then you just have to deal
with the fact that its output format is very nasty.

> We modify the kconfig to disable GCOV and UBSAN, and the issue can't
> be reproudced in 1000 runs.

Ok, it does seem like this is a compiler bug, as per Vlastimil's decoding.

And the reason it happens on 32-bit is probably that we just have much
fewer registers available there, and the 64-bit GCOV counts then
complicate things even more, and then some interaction between that
and UBSAN just generates crazy code.

And it probably has very little compiler test coverage in real life anyway.

From Vlastimil's decode, it does look like gcc has mixed up the
"update GCOV counts" with actual real values for "nr_pages", and is
using %eax for both things because of some register allocation
mistake.

So I think we can dismiss this one as a compiler bug. It might be good
to see if it happens with a newer version of gcc too, and even perhaps
post a gcc bugzilla entry, but since this probably isn't really a very
interesting config for real life, I'm not sure how interested people
are going to be.

                Linus
