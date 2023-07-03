Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD8B7462AA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjGCSoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjGCSoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:44:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3100FE6D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 11:44:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1DB66100F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 18:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D2AC433C7;
        Mon,  3 Jul 2023 18:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688409860;
        bh=2uAqICqoHfr9JtNMBA+xJ3OMXBg414ERFpRhYQggwas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z7K9FathaHPI6/wxy5SOzbw+Mn3X/luBzM657rDx4HJNm/6VjummZyAFF/3sfzVYF
         LxMRVIqsVH39SZ+5khv50NT8+BLJktP3dug43pWtYN8QAKJhSueo7i4IHOa7osISsg
         6L983hQun2qcLOjWngQMIZXxjvWbVIiOoK+4uq0w=
Date:   Mon, 3 Jul 2023 20:44:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Young <jacobly.alt@gmail.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management <linux-mm@kvack.org>,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Fwd: Memory corruption in multithreaded user space program while
 calling fork
Message-ID: <2023070359-evasive-regroup-f3b8@gregkh>
References: <facbfec3-837a-51ed-85fa-31021c17d6ef@gmail.com>
 <5c7455db-4ed8-b54f-e2d5-d2811908123d@leemhuis.info>
 <CAJuCfpH7BOBYGEG=op09bZrh1x3WA8HMcGBXXRhe6M5RJaen5A@mail.gmail.com>
 <CAJuCfpH7t7gCV2FkctzG2eWTUVTFZD7CtD14-WuHqBqOYBo1jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpH7t7gCV2FkctzG2eWTUVTFZD7CtD14-WuHqBqOYBo1jA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 11:27:19AM -0700, Suren Baghdasaryan wrote:
> On Mon, Jul 3, 2023 at 11:08 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Mon, Jul 3, 2023 at 2:53 AM Linux regression tracking (Thorsten
> > Leemhuis) <regressions@leemhuis.info> wrote:
> > >
> > > On 02.07.23 14:27, Bagas Sanjaya wrote:
> > > > I notice a regression report on Bugzilla [1]. Quoting from it:
> > > >
> > > >> After upgrading to kernel version 6.4.0 from 6.3.9, I noticed frequent but random crashes in a user space program.  After a lot of reduction, I have come up with the following reproducer program:
> > > > [...]
> > > >> After tuning the various parameters for my computer, exit code 2, which indicates that memory corruption was detected, occurs approximately 99% of the time.  Exit code 1, which occurs approximately 1% of the time, means it ran out of statically-allocated memory before reproducing the issue, and increasing the memory usage any more only leads to diminishing returns.  There is also something like a 0.1% chance that it segfaults due to memory corruption elsewhere than in the statically-allocated buffer.
> > > >>
> > > >> With this reproducer in hand, I was able to perform the following bisection:
> > > > [...]
> > > >
> > > > See Bugzilla for the full thread.
> > >
> > > Additional details from
> > > https://bugzilla.kernel.org/show_bug.cgi?id=217624#c5 :
> > >
> > > ```
> > > I can confirm that v6.4 with 0bff0aaea03e2a3ed6bfa302155cca8a432a1829
> > > reverted no longer causes any memory corruption with either my
> > > reproducer or the original program.
> > > ```
> > >
> > > FWIW: 0bff0aaea03 ("x86/mm: try VMA lock-based page fault handling
> > > first") [merged for v6.4-rc1, authored by Suren Baghdasaryan [already CCed]]
> > >
> > > That's the same commit that causes build problems with go:
> > >
> > > https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@kernel.org/
> >
> > Thanks! I'll investigate this later today. After discussing with
> > Andrew, we would like to disable CONFIG_PER_VMA_LOCK by default until
> > the issue is fixed. I'll post a patch shortly.
> 
> Posted at: https://lore.kernel.org/all/20230703182150.2193578-1-surenb@google.com/

As that change fixes something in 6.4, why not cc: stable on it as well?

thanks,

greg k-h
