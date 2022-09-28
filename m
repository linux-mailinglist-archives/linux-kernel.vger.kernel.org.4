Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FE45ED38F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 05:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiI1Djo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 23:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiI1Djj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 23:39:39 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62739BE1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 20:39:36 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gp22so1727055pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 20:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=XYKAuPD3+GZdJQNHnghuXSWwE9LJi0wNzSXXCoPHwq8=;
        b=KBUM/cr7qDLk3npbruidlCg7uiE2f2C4OLbnVvnA/DOAYyDXsf3G0SliElNEC3GWMb
         Y9NNRmrZ9Tj+5cQAGuDZQnylk9hChk8W6de7XamGr/BYIi0o0OTiKukCB4TfwkbN8zTz
         LfbM0ql16bwNZNgOAtkQt132+55+o2rsi303+NLzG0RcbAjjOLtwZoRiJV44Gb6QB62I
         eGovjp7F4iwEw8f0jnxYDlpaj5qxyIA98Ld9MCF9PZFGJEWv/IRGET5cAl+f0D6q2+hy
         6CNV/yXF9huDdTUV29v+4PfrA8WZ1zbysPzazjiWmKigmMkbOkNuw+CNBa2rghw/hVR0
         COYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=XYKAuPD3+GZdJQNHnghuXSWwE9LJi0wNzSXXCoPHwq8=;
        b=z3bVcG5N8m5kjPz2luZg2i6iAltwphjWQGkjAMDHV1+ZYJLWnrST1iDE0D5useIIuG
         OXp+POQGlRL9kC0Jes2TM9r3ZIeJvv4yHwP0wFf2BlBFUgq3qgHRWQqGQRuGL9P6KnjK
         mgI8bn8HOwSmk9qFQ89Oggd+a7F5AxlR7hkijkcACuOeS1ACwyz3rI9or5RWf1ZMAvJd
         /GsxtwCsechFnQj5AnesMx4pE+p41CApXYyrwVNlrV9xXtmb+7wF+PiIoJMV7rWF+jOc
         aTt8CoWCd4agxhLqYshzMrJHeuZj0iBYpp5fxZS7CKrg/I0o99a6Z6V7x1XdDvKeH2al
         ucvA==
X-Gm-Message-State: ACrzQf0+LXs78vnNAV6k85oMyA2oqM6r8DXjmr+0PEAaSDZ9JRYB0h4N
        nK7N7RIoxwOQLTgAKcWW0purd0/xfIvRHGz/LWYo8dAGMHc=
X-Google-Smtp-Source: AMsMyM7clATObyreo5DgUnto3bkr7OKwcVru6n7A5tqcL2D8DL3YtLCLvd0xlSSHEotHCx0g77j5k2PuFs54vsPdDY8=
X-Received: by 2002:a17:902:d508:b0:178:b7b1:beb3 with SMTP id
 b8-20020a170902d50800b00178b7b1beb3mr30772887plg.102.1664336375934; Tue, 27
 Sep 2022 20:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220921060616.73086-1-ying.huang@intel.com> <20220921060616.73086-3-ying.huang@intel.com>
 <87o7v2lbn4.fsf@nvdebian.thelocal> <CAHbLzkpPNbggD+AaT7wFQXkKqCS2cXnq=Xv3m4WuHLMBWGTmpQ@mail.gmail.com>
 <87fsgdllmb.fsf@nvdebian.thelocal> <87ill937qe.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <46807002-c42c-1232-0938-5b48050171ee@nvidia.com> <CAHbLzkqRyav0fZ5gzaKbkTfGBxkQXTpu0NJz-A9j7UaHhVBxEQ@mail.gmail.com>
 <87pmfgjnpj.fsf@nvdebian.thelocal> <87czbg2s3b.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <240bbb01-1f26-71ee-233a-ad65313ac358@nvidia.com> <CAHbLzkpnCTD_c60QPu25hPymCYwLP6fYRMxp1EWmzX0SBF4g1w@mail.gmail.com>
 <4a44bf59-a984-8ac4-c613-a03d74dc6a5a@nvidia.com> <CAHbLzkoEDUauo-H=zYvnDTC8TX4uezPxA4nV=QVQK_qxyZ3wjQ@mail.gmail.com>
 <9d72f2ed-9a92-e67b-3af5-79050004a1a4@nvidia.com> <CAHbLzkqTz9aNE=thZR2sw2SVf2YWOLCmSNgmEOJD587s+28A1w@mail.gmail.com>
In-Reply-To: <CAHbLzkqTz9aNE=thZR2sw2SVf2YWOLCmSNgmEOJD587s+28A1w@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 27 Sep 2022 20:39:23 -0700
Message-ID: <CAHbLzkqS4Lf6oCjeNp7K17Qok_B8w26V9ywbTtdpXvUD_OcuUQ@mail.gmail.com>
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

On Tue, Sep 27, 2022 at 8:25 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Tue, Sep 27, 2022 at 7:57 PM John Hubbard <jhubbard@nvidia.com> wrote:
> >
> > On 9/27/22 19:14, Yang Shi wrote:
> > > IIRC, the writeback may not call generic_writepages. On my ext4
> > > filesystem, the writeback call stack looks like:
> > >
> > > @[
> > >     ext4_writepages+1
> > >     do_writepages+191
> > >     __writeback_single_inode+65
> > >     writeback_sb_inodes+477
> > >     __writeback_inodes_wb+76
> > >     wb_writeback+457
> > >     wb_workfn+680
> > >     process_one_work+485
> > >     worker_thread+80
> > >     kthread+231
> > >     ret_from_fork+34
> > > ]: 2
> > >
> >
> > Sure, that's fine for ext4, in that particular case, but
> >
> > a) not all filesystems have .writepages hooked up. That's why
> > do_writepages() checks for .writepages(), and falls back to
> > .writepage():
> >
> >         if (mapping->a_ops->writepages)
> >                 ret = mapping->a_ops->writepages(mapping, wbc);
> >         else
> >                 ret = generic_writepages(mapping, wbc);
> >
> > , and
> >
> > b) there are also a lot of places and ways to invoke writebacks. There
> > are periodic writebacks, and there are data integrity (WB_SYNC_ALL)
> > writebacks, and other places where a page needs to be cleaned--so, a lot
> > of call sites. Some of which will land on a .writepage() sometimes, even
> > now.
> >
> > For just one example, I see migrate.c's writeout() function directly
> > calling writepage():
> >
> >         rc = mapping->a_ops->writepage(&folio->page, &wbc);
>
> Thanks, John. You are right. I think "deprecated" is inaccurate,
> .writepage is actually no longer used in memory reclaim context, but
> it is still used for other contexts.

Hmm.. it is definitely used currently, but it seems like the plan is
to deprecate ->writepage finally IIUC. See
https://lore.kernel.org/linux-mm/YvQYjpDHH5KckCrw@casper.infradead.org/

>
> Anyway I think what we tried to figure out in the first place is
> whether it is possible that filesystem writeback have dead lock with
> the new batch migration or not. I think the conclusion didn't change.
>
> >
> >
> > thanks,
> >
> > --
> > John Hubbard
> > NVIDIA
> >
