Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD7962FF02
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiKRUvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKRUvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:51:41 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFBF7615F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:51:40 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id q186so6613222oia.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pnv/AcibuVlHkWWrn9NvH3zq6Vm135VxzOsOFf6QZKI=;
        b=gFXMFOqmW0RMul/DdKfwDG62G+ABj0IB78rq9gSetzwIaS+UPKqPErjDSsiBHWUQw9
         NUVnruR35lTlrjm81tpWsPTyPAKpWIF/zyxVLwCKeNsy8a9o0Eyp6ilf+oJDMBfS045a
         ofgKIojFLFodw32oJYhKEar3+MZ2b8NeZ6e4ewYMv1sCAbr9GHTOjNQ3t7zRUp+WbMx/
         LC6a9XZo2bfdC7hOns88AaTsh+vSSBw1OidcmcH2hPXIYOjMfgb7WSOUBi8zBYAjpKAV
         baC7D3smbTLQEzemCPraruuTbPEQDQBJA162eh3lr9jHUvZXK07+zPdenbqM8i5J28OE
         pL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pnv/AcibuVlHkWWrn9NvH3zq6Vm135VxzOsOFf6QZKI=;
        b=LRELGZEFEc6gFpYeIfkdLAsTsz8gtSpt3njNWuBhLjcxxlV9Wn5uprRdJaoataX17f
         1p7fBmF2cGu1byAQErGMJdtNu66jswsAPLp8uqxdMoA7+U22i+2evs2vlbQLQgbKkts9
         NnOhHbMtd9jhHBcdkEzVS+tFjB/gMflUQPH+aRT0zx6OG835RGP8zcvxgxp7E0qW5Qo+
         vwEPdngCh5JfuSly1mGs2ErAp8xeXExoCJlgxjrklDYt29wVVhZVKRY6ONnoQrjM0E3F
         bsnDvNSKw62UyDg0Ne4nVhhFfhpIxTlFvXeFr+e4FXy84cD2zbFLoVxXRzzz3xV51KxT
         ug0g==
X-Gm-Message-State: ANoB5pmaoS3eakTXeVZ6aIr8niMdIS2Xal4PAP5GsMg+8ILFogd5NDjC
        gTLTk1yRlFSpkvu+8AhCEs3h7w==
X-Google-Smtp-Source: AA0mqf4giCJcjJID1X3/l1Gp967DEW/pJcOXomtJhqPGBJUF6GO8tkq6sBU2omWmjQg/pQRwcqgeuQ==
X-Received: by 2002:a05:6808:1d8:b0:35a:3e6f:3635 with SMTP id x24-20020a05680801d800b0035a3e6f3635mr4570376oic.63.1668804699283;
        Fri, 18 Nov 2022 12:51:39 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l32-20020a0568302b2000b00661b5e95173sm2012730otv.35.2022.11.18.12.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 12:51:36 -0800 (PST)
Date:   Fri, 18 Nov 2022 12:51:09 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/3] mm,thp,rmap: rework the use of subpages_mapcount
In-Reply-To: <CAHk-=whmq5gHrKmD3j=7nB=n9OmmLb5j1qmoQPHw1=VSQ-V=hg@mail.gmail.com>
Message-ID: <93fa81ae-d848-58c2-9f70-27446bf9baa8@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com> <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com> <CAHk-=whmq5gHrKmD3j=7nB=n9OmmLb5j1qmoQPHw1=VSQ-V=hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022, Linus Torvalds wrote:
> On Fri, Nov 18, 2022 at 1:08 AM Hugh Dickins <hughd@google.com> wrote:
> >
> > Linus was underwhelmed by the earlier compound mapcounts series:
> > this series builds on top of it (as in next-20221117) to follow
> > up on his suggestions - except rmap.c still using lock_page_memcg(),
> > since I hesitate to steal the pleasure of deletion from Johannes.
> 
> This looks good to me. Particularly 2/3 made me go "Aww, yes" but the
> overall line removal stats look good too.
> 
> That said, I only looked at the patches, and not the end result
> itself. But not having the bit spin lock is, I think, a huge
> improvement.

Great, thanks a lot for looking through.

> 
> I do wonder if this should be now just merged with your previous
> series - it looks a bit odd how your previous series adds that
> bitlock, only for it to be immediately removed.
> 
> But if you think the logic ends up being easier to follow this way as
> two separate patch series, I guess I don't care.

I rather like having its evolution on record there, but that might just
be my sentimentality + laziness.  Kirill did a grand job of reviewing
the first series: I think that, at least for now, it would be easier
for people to review the changes if the two series are not recombined.

But the first series has not yet graduated from mm-unstable,
so if Andrew and/or Kirill also prefer to have them combined into one
bit_spin_lock-less series, that I can do.  (And the end result should be
identical, so would not complicate Johannes's lock_page_memcg() excision.)

Hugh

> 
> And the memcg locking is entirely a separate issue, and I hope
> Johannes will deal with that.
> 
> Thanks,
>               Linus
