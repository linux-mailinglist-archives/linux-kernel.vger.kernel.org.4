Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833DC663057
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjAIT3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbjAIT3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:29:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC5E63389
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:28:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E53DBB80DAA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 19:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED8BC433D2;
        Mon,  9 Jan 2023 19:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673292513;
        bh=N4nFMKavoUqojR3nB9WdTnhsDQneBJM2upN298Etx5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OowNnYnIwRfcPN1hoyJEyTnQQOwaxsoMsmFDDxyvRL2NHuhPq6INcfewJfyy2RYmZ
         9HELSYT3iwla32ma8gUl1IC40miQhIHuYNPESIHJciLGlGBxKcjInjZ6WMT/fCknfI
         O622+eZE3uHdGfYj7zp5Uhwo11ou4SfFS1JnL0k/GY8i1Y/W5o2LhmrR4ssP1IaiQ+
         fyfvgkKQtZRQMwpWRCAy6NqwyDKcABvl83g9AGLJ3aOJK0wS10hUn872DnCyjeTe3l
         /dZtKyII/ytAREY/8Tfy8xONgv0LIAoDV6Dt7E9q0UEhlIIvIt48A4zPYaf3aBD2hX
         mbgjaAeajIhkw==
From:   SeongJae Park <sj@kernel.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     SeongJae Park <sj@kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 22/44] mmap: Pass through vmi iterator to __split_vma()
Date:   Mon,  9 Jan 2023 19:28:31 +0000
Message-Id: <20230109192831.61258-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109164533.3qkorup75h3zsi7t@revolver>
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

On Mon, 9 Jan 2023 16:45:46 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> * SeongJae Park <sj@kernel.org> [230106 21:40]:
> > Hello Liam,
> > 
> > On Sat, 7 Jan 2023 02:01:26 +0000 SeongJae Park <sj@kernel.org> wrote:
> > 
> > > Hello Liam,
> > > 
> > > 
> > > I found 'make install' mm-unstable kernel fails from initramfs stage with
> > > 'not a dynamic executable' message.  I confirmed the issue is not reproducible
> > > before your patchset[1] but after the series[2].
> > > 
> > > I tried to bisect, but on a commit[3] middle of mm-unstable tree which this
> > > patch is applied, I get below error while booting.  Do you have an idea?
> > 
> > I further bisected for the boot failure.  The first bad commit was a8e0f2e12936
> > ("mmap: change do_mas_munmap and do_mas_aligned_munmap() to use vma
> > iterator")[1].  The stacktrace on the commit is as below.
> > 
> ...
> 
> Thanks for your work on this.
> 
> I have found the issue and will send out a fix shortly.  I am not
> handling the invalidated state correctly in the write path.

Thank you, I tested the patch and confirmed it is fixing the boot failure.  The
'make install' issue on my system is not fixed yet, though.  While doing bisect
of the issue again with your boot failure fix, I found below build failure on a
commit applying a patch of this series, namely "userfaultfd: use vma iterator".

    mm/madvise.c: In function ‘madvise_update_vma’:
    mm/madvise.c:165:11: error: implicit declaration of function ‘__split_vma’; did you mean ‘split_vma’? [-Werror=implicit-function-declaration]
      165 |   error = __split_vma(mm, vma, start, 1);
          |           ^~~~~~~~~~~
          |           split_vma
    cc1: some warnings being treated as errors

Maybe "mm: add temporary vma iterator versions of vma_merge(), split_vma(), and
__split_vma()" caused the build failure?


Thanks,
SJ
