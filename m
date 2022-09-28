Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2F55ED372
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 05:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiI1D0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 23:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiI1D0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 23:26:05 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C474580A9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 20:26:05 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id v186so11363293pfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 20:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=To+MkJjyqyo7jncRu+HUvODDez2TVKQAug//Me+ROz4=;
        b=B6fdJzHXTDJJ2PhJJiDAAqrJQXgMnawDmP3QtixcjLGm566J8hbODf8sgSPeK9T7bm
         5qS9Bd/G/lQYUq107JO66NCsvE9Z91fPHdm7ci86Bj4zjAYDlJNCw6f9fUwIQYKkzA2W
         AXeMRixGcPHO/99q9ZnNctpMgMEOcoDyAQ1ZaqEVNXxyAFu/nrxKe3VF/GJ2BzAdfSAJ
         V3kK+F5k35rGrFhA2Jd7gP2ooHt+BT+X3NKtw2sMHh2PmBhYYLoNiIrA7i09HhPPaeeS
         mqSRotcClaHooL/lE2xaqqgAth3xb/muA32B0QbxexxKcUrvxMCIBOmFfbbqpMSvPGgT
         ROYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=To+MkJjyqyo7jncRu+HUvODDez2TVKQAug//Me+ROz4=;
        b=0tNBHrTem0iI4+q2lviecXL6ZayYNcXe5mlpVCjfvc14yLHJkvZnSFPW/tlt+YVAgN
         Bz12V5zunjMavuN2uyR7uFxdGNkgfWLtXz261+nAA/ysZXipQXtSrX0FiXYPfPIT9psQ
         csrGvNQSqbYNxl9YilXam44Sm4ETInrjd39awZtUH0W6AWi6n3kD5+X/IrQ6ipxAXxs3
         9ti+OmZ5hWiLkmxSYyG3mTILJPK/BgbNLcdG4U3ECcOtZHMkxEzdUtxEJgCZ57b+oWFV
         tkw6HgMOozvwEqd8TuNR1xsIDcBxVos4dLcX7RHuP/t2zYBzwYsqtZwixJHtmlYQCOF6
         ZPKw==
X-Gm-Message-State: ACrzQf2qTdqNdZUN6lQL1Vd0X9PTNHs1tG7eT6jbKbwptdwxH0x2XhFw
        QHpzNDVYKg3dNQciMrx2CZpQfH5I96PADLNpdFQ=
X-Google-Smtp-Source: AMsMyM6L5rl3/JyTMMTbFcUfk64g1ng0jkNTfS8qvP0wh5l1kiGV/r3VGvZBVnhkhH3MgDkr6RLoKPgX4A5zLWa7H74=
X-Received: by 2002:a63:5f16:0:b0:439:41a8:ab4e with SMTP id
 t22-20020a635f16000000b0043941a8ab4emr27305865pgb.195.1664335564729; Tue, 27
 Sep 2022 20:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220921060616.73086-1-ying.huang@intel.com> <20220921060616.73086-3-ying.huang@intel.com>
 <87o7v2lbn4.fsf@nvdebian.thelocal> <CAHbLzkpPNbggD+AaT7wFQXkKqCS2cXnq=Xv3m4WuHLMBWGTmpQ@mail.gmail.com>
 <87fsgdllmb.fsf@nvdebian.thelocal> <87ill937qe.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <46807002-c42c-1232-0938-5b48050171ee@nvidia.com> <CAHbLzkqRyav0fZ5gzaKbkTfGBxkQXTpu0NJz-A9j7UaHhVBxEQ@mail.gmail.com>
 <87pmfgjnpj.fsf@nvdebian.thelocal> <87czbg2s3b.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <240bbb01-1f26-71ee-233a-ad65313ac358@nvidia.com> <CAHbLzkpnCTD_c60QPu25hPymCYwLP6fYRMxp1EWmzX0SBF4g1w@mail.gmail.com>
 <4a44bf59-a984-8ac4-c613-a03d74dc6a5a@nvidia.com> <CAHbLzkoEDUauo-H=zYvnDTC8TX4uezPxA4nV=QVQK_qxyZ3wjQ@mail.gmail.com>
 <9d72f2ed-9a92-e67b-3af5-79050004a1a4@nvidia.com>
In-Reply-To: <9d72f2ed-9a92-e67b-3af5-79050004a1a4@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 27 Sep 2022 20:25:52 -0700
Message-ID: <CAHbLzkqTz9aNE=thZR2sw2SVf2YWOLCmSNgmEOJD587s+28A1w@mail.gmail.com>
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

On Tue, Sep 27, 2022 at 7:57 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 9/27/22 19:14, Yang Shi wrote:
> > IIRC, the writeback may not call generic_writepages. On my ext4
> > filesystem, the writeback call stack looks like:
> >
> > @[
> >     ext4_writepages+1
> >     do_writepages+191
> >     __writeback_single_inode+65
> >     writeback_sb_inodes+477
> >     __writeback_inodes_wb+76
> >     wb_writeback+457
> >     wb_workfn+680
> >     process_one_work+485
> >     worker_thread+80
> >     kthread+231
> >     ret_from_fork+34
> > ]: 2
> >
>
> Sure, that's fine for ext4, in that particular case, but
>
> a) not all filesystems have .writepages hooked up. That's why
> do_writepages() checks for .writepages(), and falls back to
> .writepage():
>
>         if (mapping->a_ops->writepages)
>                 ret = mapping->a_ops->writepages(mapping, wbc);
>         else
>                 ret = generic_writepages(mapping, wbc);
>
> , and
>
> b) there are also a lot of places and ways to invoke writebacks. There
> are periodic writebacks, and there are data integrity (WB_SYNC_ALL)
> writebacks, and other places where a page needs to be cleaned--so, a lot
> of call sites. Some of which will land on a .writepage() sometimes, even
> now.
>
> For just one example, I see migrate.c's writeout() function directly
> calling writepage():
>
>         rc = mapping->a_ops->writepage(&folio->page, &wbc);

Thanks, John. You are right. I think "deprecated" is inaccurate,
.writepage is actually no longer used in memory reclaim context, but
it is still used for other contexts.

Anyway I think what we tried to figure out in the first place is
whether it is possible that filesystem writeback have dead lock with
the new batch migration or not. I think the conclusion didn't change.

>
>
> thanks,
>
> --
> John Hubbard
> NVIDIA
>
