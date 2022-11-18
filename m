Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1B962FEF2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiKRUmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiKRUmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:42:12 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC7F42F6E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:42:11 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id k2so4269615qkk.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sf7AnfznU4wpG+Kk6IbaTpUBZR9RJxDoBtRddMUUBJo=;
        b=FES1xXielCjlnU6nLLldQEL7U2LyKYg1uxJTFr/GHH3B43OI8ULbeBCd+4HULwGryt
         vSwxYFI1KCbtJ8ADiTxJMB64OUCQYgbdh0vlWDIhaUnkUEwVnAV+y24UYJsMYw4DE97E
         icSKqZ75UtIOoOnVdsPsPcr+0z4Gwgx3VRgv2HGC2ODsgPjHvbkGwNmvoP4MukQ9bpVg
         A8vMxqwRKM6nYoAyRrYUGBUV1IEVEH1CXXFu51bSgDA3pKV6fVJIJ5FBYyB68RknlRpj
         VBF8E5jWP8VzZmKQIU95/5r4V55nleUnmtGI2ubjLBOoOM9v51r8qprmEH0VCZQNKBdb
         wLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sf7AnfznU4wpG+Kk6IbaTpUBZR9RJxDoBtRddMUUBJo=;
        b=PLSvTN4L1txkaXZnfQJkcFfzW3HjV6329CKw3JFmkehTs/yNjOFnmEQHIu+2CNaQMo
         0TBTmpe3ZZ8wm6EYl+J9XE5vYBYD3d5622H9aj+kC3W1UE6PAVtPS1L4PkiAcGbEzR0O
         kuehy5NUWGZK/yVhZN5zE1jpjXJ/6CH0MGLfdPkIzYG6TkmVC3lD79y4WbCoC60vtB8K
         Gd6Qg50G/yGcO04ACmlOKo/I9JZv0RFdKc4uRNUB8AV5o5wGdpz/Y5D51pf5JvDSprw0
         MklPsvNmO+86eWU5elSR3uKq4Kk5FgGz4zeW+NwNjPR5YPKalwna8Toq4MbHcG+VHAzS
         8BpQ==
X-Gm-Message-State: ANoB5plAaqWYRTP69oaufVkmoBvuVzS7bgMDf2Nn8j7NWUDeT1nbIQhl
        kQoGJnWe3ebzpz/7Cun85I6i0w==
X-Google-Smtp-Source: AA0mqf4Z1c0WbscSmPbmpXbekp1NwBPs8mQBji6xV3gLE0ypFnlN3cjdDC/LePIIuNoLohvOTIFQmQ==
X-Received: by 2002:ae9:c010:0:b0:6fb:84ee:ab84 with SMTP id u16-20020ae9c010000000b006fb84eeab84mr7534695qkk.152.1668804130921;
        Fri, 18 Nov 2022 12:42:10 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id bn39-20020a05620a2ae700b006fa16fe93bbsm3037356qkb.15.2022.11.18.12.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 12:42:10 -0800 (PST)
Date:   Fri, 18 Nov 2022 15:42:34 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <Y3fuOo2MPdGHG4lW@cmpxchg.org>
References: <5f52de70-975-e94f-f141-543765736181@google.com>
 <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com>
 <CAHk-=whmq5gHrKmD3j=7nB=n9OmmLb5j1qmoQPHw1=VSQ-V=hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whmq5gHrKmD3j=7nB=n9OmmLb5j1qmoQPHw1=VSQ-V=hg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 12:18:42PM -0800, Linus Torvalds wrote:
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
> 
> I do wonder if this should be now just merged with your previous
> series - it looks a bit odd how your previous series adds that
> bitlock, only for it to be immediately removed.
> 
> But if you think the logic ends up being easier to follow this way as
> two separate patch series, I guess I don't care.
> 
> And the memcg locking is entirely a separate issue, and I hope
> Johannes will deal with that.

Yeah, I'll redo the removal on top of this series and resend it.

Thanks
