Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810B75ED2EA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 04:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbiI1COi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 22:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiI1COf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 22:14:35 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4593B15
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 19:14:32 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s206so10999021pgs.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 19:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=2W5JaxbFer3z5OAkUwrQJfU0QqTCG9GKJCIv71u2Re8=;
        b=ilGkUYPmuYu5Te6RpyJ6i9ewXc4xeF9W1Xs+8uenQaE3WnaZ8oqCVa1PE6iiYXb5HE
         zIPJQ2xBzHmXJW5BfeTtkipcX2GqnyHWtOjA0KK6ix6xr0aHG7BVcnKPjZ/dYDnyrBdK
         yYJ3xMERUj00swHg9bB0os5sFnMMLPy+OZYaGZHetwN6w6aCF4c4R5XdgBC1U0/D9eiH
         PXsvv+Izvuu9aNLzi1OfSAcsvgbEEtWAiwRuPePOPcrX9pOjpfZGzzeclbRdkSeH22dq
         ZIALr/4FZZM3dTGv3sJIlofeuDabo2Wwk+aPU0B2Bj7iDzve9bEHD8j+k7v4R1SVfrRx
         HtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2W5JaxbFer3z5OAkUwrQJfU0QqTCG9GKJCIv71u2Re8=;
        b=zKJe1P4MprxqHnvQZXMjEs0cRg5DN00e6EUNTmM7anFLXLdhmm9sDgnUhtBWd/BNr4
         U0j8NsH6gN8+2NP5oz65aHZ2+WFzbuexyVbSYmctpbcBGlf5aBKXmE1NCq4zZh517r/w
         iATl4B+vvygDOTt/gitmIk2bAftujWJH5A9TfX73RI4kJ3ub6l2Lc36zsmoaATa1pwTb
         36GKvamYcY0DrEU/wUo/TGq2zIBbnh/VwBXGPrkCozioayCuFw9w6MzRGeM/1ltawf8E
         afFSmbYsXaLvAGSP1/eWSR3z88fNV1bTJ0h1UbpxnODTgePW+RzLq5JYroMYB2Xse16P
         shSg==
X-Gm-Message-State: ACrzQf2k4s5szeNHRQ6ZRMGoHKGto7ip2TY2or4Grs8jJtMJGDU0sGkR
        8tWRV4IFRTfDNRtiP278vB2Wi9AcKunYedjehtI=
X-Google-Smtp-Source: AMsMyM74PZvJHJzmNokYSrgSFgDkzvXUVfY9Rp1IrLighoEsac0Jdun2PWtxR+g6mhZtACi4WKzjpp/GP1DP0YNP2sI=
X-Received: by 2002:aa7:88c9:0:b0:541:2b7:d655 with SMTP id
 k9-20020aa788c9000000b0054102b7d655mr32508672pff.72.1664331272150; Tue, 27
 Sep 2022 19:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220921060616.73086-1-ying.huang@intel.com> <20220921060616.73086-3-ying.huang@intel.com>
 <87o7v2lbn4.fsf@nvdebian.thelocal> <CAHbLzkpPNbggD+AaT7wFQXkKqCS2cXnq=Xv3m4WuHLMBWGTmpQ@mail.gmail.com>
 <87fsgdllmb.fsf@nvdebian.thelocal> <87ill937qe.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <46807002-c42c-1232-0938-5b48050171ee@nvidia.com> <CAHbLzkqRyav0fZ5gzaKbkTfGBxkQXTpu0NJz-A9j7UaHhVBxEQ@mail.gmail.com>
 <87pmfgjnpj.fsf@nvdebian.thelocal> <87czbg2s3b.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <240bbb01-1f26-71ee-233a-ad65313ac358@nvidia.com> <CAHbLzkpnCTD_c60QPu25hPymCYwLP6fYRMxp1EWmzX0SBF4g1w@mail.gmail.com>
 <4a44bf59-a984-8ac4-c613-a03d74dc6a5a@nvidia.com>
In-Reply-To: <4a44bf59-a984-8ac4-c613-a03d74dc6a5a@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 27 Sep 2022 19:14:19 -0700
Message-ID: <CAHbLzkoEDUauo-H=zYvnDTC8TX4uezPxA4nV=QVQK_qxyZ3wjQ@mail.gmail.com>
Subject: Re: [RFC 2/6] mm/migrate_pages: split unmap_and_move() to _unmap()
 and _move()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 6:56 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 9/27/22 18:49, Yang Shi wrote:
> > On Tue, Sep 27, 2022 at 6:45 PM John Hubbard <jhubbard@nvidia.com> wrote:
> >>
> >> On 9/27/22 18:41, Huang, Ying wrote:
> >>>>>> I also agree that we cannot make any rules such as "do not lock > 1 page
> >>>>>> at the same time, elsewhere in the kernel", because it is already
> >>>>>> happening, for example in page-writeback.c, which locks PAGEVEC_SIZE
> >>>>>> (15) pages per batch [1].
> >>>>
> >>>> That's not really the case though. The inner loop of write_cache_page()
> >>>> only ever locks one page at a time, either directly via the
> >>>> unlock_page() on L2338 (those goto's are amazing) or indirectly via
> >>>> (*writepage)() on L2359.
> >>>>
> >>>> So there's no deadlock potential there because unlocking any previously
> >>>> locked page(s) doesn't depend on obtaining the lock for another page.
> >>>> Unless I've missed something?
> >>>
> >>> Yes.  This is my understanding too after checking ext4_writepage().
> >>>
> >>
> >> Yes, I missed the ".writepage() shall unlock the page" design point. Now
> >> it seems much more reasonable and safer. :)
> >
> > .writepage is deprecated (see
> > https://lore.kernel.org/linux-fsdevel/20220719041311.709250-1-hch@lst.de/),
> > write back actually uses .writepages.
>
> write_cache_pages() seems to directly call it, though:
>
> generic_writepages()
>   write_cache_pages(__writepage)
>     __writepage()
>       mapping->a_ops->writepage(page, wbc)
>
> So it seems like it's still alive and well. And in any case, it is definitely
> passing one page at a time from write_cache_pages(), right?

IIRC, the writeback may not call generic_writepages. On my ext4
filesystem, the writeback call stack looks like:

@[
    ext4_writepages+1
    do_writepages+191
    __writeback_single_inode+65
    writeback_sb_inodes+477
    __writeback_inodes_wb+76
    wb_writeback+457
    wb_workfn+680
    process_one_work+485
    worker_thread+80
    kthread+231
    ret_from_fork+34
]: 2


>
>
>  thanks,
>
> --
> John Hubbard
> NVIDIA
>
