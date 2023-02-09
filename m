Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3E06912A2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 22:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjBIV2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 16:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjBIV2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 16:28:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07215ACC1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 13:28:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B486B816DD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 21:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50F3C433D2;
        Thu,  9 Feb 2023 21:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1675978127;
        bh=JIXw2whbdGgWRTsPpHpxiQgqK9yNjc5I1PyyB7kT9B4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L3DhU8c3kIoz1NtjNBxBPlQ9e9aKdXbcI5DWWgm0RJHI37wAChN6ynKlC5V+HULml
         rON3mjf3PkSeQ6xVa2xf2xMaLGXwoC6wtGhX3XHGWV8u6636cGIuh0xlY3RXiXWSqC
         VZKbh0v63MGx9rdHXzXNGUqf0dOYJHU8svkir+JU=
Date:   Thu, 9 Feb 2023 13:28:46 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>,
        Zach O'Keefe <zokeefe@google.com>
Subject: Re: [PATCH 1/2] mm/MADV_COLLAPSE: set EAGAIN on unexpected page
 refcount
Message-Id: <20230209132846.122ad88e1c2bd0603a630e5c@linux-foundation.org>
In-Reply-To: <ecb2cf3-45f0-8aae-3e1-da4e79de9c27@google.com>
References: <20230125015738.912924-1-zokeefe@google.com>
        <ecb2cf3-45f0-8aae-3e1-da4e79de9c27@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2023 21:09:04 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:

> On Tue, 24 Jan 2023, Zach O'Keefe wrote:
> 
> > During collapse, in a few places we check to see if a given small page
> > has any unaccounted references.  If the refcount on the page doesn't
> > match our expectations, it must be there is an unknown user concurrently
> > interested in the page, and so it's not safe to move the contents
> > elsewhere. However, the unaccounted pins are likely an ephemeral state.
> > 
> > In such a situation, make MADV_COLLAPSE set EAGAIN errno, indicating that
> > collapse may succeed on retry.
> > 
> > Fixes: 7d8faaf15545 ("mm/madvise: introduce MADV_COLLAPSE sync hugepage collapse")
> > Reported-by: Hugh Dickins <hughd@google.com>
> > Signed-off-by: Zach O'Keefe <zokeefe@google.com>
> 
> This was
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> and now I'll give it a nudge with
> Acked-by: Hugh Dickins <hughd@google.com>
> since it hasn't appeared in mm-unstable or linux-next yet:

Buildbot failed on [2/2] so I skipped the whole series in expectation
of a v2 series, which didn't happen.  Instead, Zach trickily sent what
was [2/2] as a standalone patch.  So [1/2] got lost.  Sigh, poor me.

Thanks, I'll merge [1/2] into mm-hotfixes.

> I think its Cc:stable sibling 2/2, already in 6.2-rc, got all the attention.

I'm not seeing anything in the [1/2] changelog which indicates that a
backport is needed.  IOW,

# cat .signature
When fixing a bug, please describe the end-user visible effects of that bug.



