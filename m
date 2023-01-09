Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA7C6634D0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbjAIXH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjAIXH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:07:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3A91B9DF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:07:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9C15B8109E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 23:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05239C433EF;
        Mon,  9 Jan 2023 23:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673305672;
        bh=L5utGm3sciYJfzyl8xq+sWm9uedBplaVJst8aID6858=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tBNY5A9odUkTWdZMLtW1JVqx7lQN5VNO8xIf1aStfqTY5H+QO0/oBho8oL1Q9Nj6B
         cse7V99LhOoqt7HhTsitgDBwKVx54aj4E8V4X8NjvIzSFiX7Iz1JFfrT5q0K2BHhVs
         rMgxWE7W9HJWmoCniTRr+blvWwRy522Br/wC9kr/CLyV92nFaQZCTcKENHE1rNBQ0M
         xuEf741egdpOlrj1V2tKMNVWZu9VQEEI5WSzFzGwOkOHSlRewI9il7Rxb/TrZsav4G
         3Z+1Ost16bmlbzpFvIVRBdBuRi6YqEjbRyojgDl8kg611FUDUhxhK3yeyqDp4VpwNT
         RcxISpXLR1Qpg==
From:   SeongJae Park <sj@kernel.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     SeongJae Park <sj@kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 22/44] mmap: Pass through vmi iterator to __split_vma()
Date:   Mon,  9 Jan 2023 23:07:50 +0000
Message-Id: <20230109230750.7211-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109203026.nqwhze2d5y62z4tf@revolver>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Liam,

On Mon, 9 Jan 2023 20:30:50 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> * SeongJae Park <sj@kernel.org> [230109 14:28]:
> > On Mon, 9 Jan 2023 16:45:46 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
> > 
> > > * SeongJae Park <sj@kernel.org> [230106 21:40]:
> > > > Hello Liam,
> > > > 
> > > > On Sat, 7 Jan 2023 02:01:26 +0000 SeongJae Park <sj@kernel.org> wrote:
> > > > 
> > > > > Hello Liam,
> > > > > 
> > > > > 
> > > > > I found 'make install' mm-unstable kernel fails from initramfs stage with
> > > > > 'not a dynamic executable' message.  I confirmed the issue is not reproducible
> > > > > before your patchset[1] but after the series[2].
> > > > > 
> > > > > I tried to bisect, but on a commit[3] middle of mm-unstable tree which this
> > > > > patch is applied, I get below error while booting.  Do you have an idea?
> > > > 
> > > > I further bisected for the boot failure.  The first bad commit was a8e0f2e12936
> > > > ("mmap: change do_mas_munmap and do_mas_aligned_munmap() to use vma
> > > > iterator")[1].  The stacktrace on the commit is as below.
> > > > 
> > > ...
> > > 
> > > Thanks for your work on this.
> > > 
> > > I have found the issue and will send out a fix shortly.  I am not
> > > handling the invalidated state correctly in the write path.
> > 
> > Thank you, I tested the patch and confirmed it is fixing the boot failure.  The
> > 'make install' issue on my system is not fixed yet, though.  While doing bisect
> > of the issue again with your boot failure fix, I found below build failure on a
> > commit applying a patch of this series, namely "userfaultfd: use vma iterator".
> > 
> >     mm/madvise.c: In function ‘madvise_update_vma’:
> >     mm/madvise.c:165:11: error: implicit declaration of function ‘__split_vma’; did you mean ‘split_vma’? [-Werror=implicit-function-declaration]
> >       165 |   error = __split_vma(mm, vma, start, 1);
> >           |           ^~~~~~~~~~~
> >           |           split_vma
> >     cc1: some warnings being treated as errors
> > 
> > Maybe "mm: add temporary vma iterator versions of vma_merge(), split_vma(), and
> > __split_vma()" caused the build failure?
> 
> Yes, it seems I removed the external declaration before the function.
> Thanks.

I continued bisect with your fix for this[1], and found my 'make install' issue
comes from 'mm: change mprotect_fixup to vma iterator'.

[1] https://lore.kernel.org/linux-mm/20230109205300.955019-1-Liam.Howlett@oracle.com/


Thanks,
SJ
