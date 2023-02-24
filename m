Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42236A14B7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 02:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjBXB4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 20:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBXB4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 20:56:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA325DCF4;
        Thu, 23 Feb 2023 17:56:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51020617FF;
        Fri, 24 Feb 2023 01:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F444C433EF;
        Fri, 24 Feb 2023 01:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677203773;
        bh=Y1p16khhuNiaOQ8TtHLqFIlVsf8ohxLEG3wTGlzSQmE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eANX7ReyiXd7GgvIYEJ+HAfN1kWqSN6nVVy/VSIKRc3skukMy623AIDP6OaOYSc3J
         b6i56cSLIGkU0/pXM4uvkNbYG6Xfif7BQETdWOyik0LNc6udnVyWMi9Aa+OKA09f0v
         gTOP7uJIlkjcy/fCiAM4kXfIQOf68RP605TRNLlY=
Date:   Thu, 23 Feb 2023 17:56:12 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, Vishal Moola <vishal.moola@gmail.com>,
        Paulo Alcantara <pc@cjr.nz>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Xin Hao <xhao@linux.alibaba.com>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] MM updates for 6.3-rc1
Message-Id: <20230223175612.e0cd1efde10ff32451cab5b7@linux-foundation.org>
In-Reply-To: <CAHk-=whAAOVBrzwb2uMjCmdRrtudGesYj0tuqdUgi8X_gbw1jw@mail.gmail.com>
References: <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
        <CAHk-=whAAOVBrzwb2uMjCmdRrtudGesYj0tuqdUgi8X_gbw1jw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2023 17:33:37 -0800 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Feb 20, 2023 at 1:52 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > Linus, please merge this cycle's MM updates.
> 
> Ok, finally got around to this one, and I am not thrilled about it.
> 
> A few notes:
> 
>  - my fs/udf/inode.c is "minimal". Ugly, ugly, I think
> udf_adinicb_writepage() should just be made to actually deal with
> folios inherently, but I did *NOT* do that, and just did
> 
>         struct page *page = &folio->page;
> 
>    at the top, and left it at that. I'm not proud of it, but I hope
> Jan might want to do this properly.
> 
>    That conflict wasn't mentioned, and now I wonder if the UDF changes
> were in -next at all?

This was a mea culpa, sorry.  Stephen did encounter and resolve this
(https://lkml.kernel.org/r/20230127165912.0e4a7b66@canb.auug.org.au)
but I was fixated on his "linux-next: manual merge of the mm-stable
tree with the XXX tree" emails and not his "linux-next: build failure after
merge of the mm tree" emails.  Self-LART has been applied.


