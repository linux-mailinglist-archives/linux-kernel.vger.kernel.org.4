Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9472690BD5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjBIObw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjBIObW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:31:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA335C49C;
        Thu,  9 Feb 2023 06:31:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD27961AA2;
        Thu,  9 Feb 2023 14:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA0EC4339B;
        Thu,  9 Feb 2023 14:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675953080;
        bh=zAwLjTfHZkA4Un8Wr96bawLWi9udk66aSBO3uZqtYAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VG5jFqXowBO4k3HxzeJWpfut2l0emYLJiIhkuZRgIavsBSTDTP8w9UHu5bMOwz6az
         KDhpEkzdmx8AzjN6VDm3d79kkWwGfKZ3zv15VslgJvIfWn3BckIIPOx26HRHPWsb7+
         JUSX7XenJnIUONq8rg7BC9rIb1aNamgywSg1Qtdtz4ZccT/Q+XGmD8xK8Rvo7PWZxM
         DZc+yN0yeqppujKqn3ectEj7YYmTNaWjfKoVbeZVsHfGgs9xz7l8BkQUfJC0oKeLG1
         no+cx8P3SwCP4tVqMjsVHdGRKJyNTjEFUN5PvJ3xy81FNkix+uaId+dWBihVWuzVgt
         ZNhw/sUJ5xMDQ==
Date:   Thu, 9 Feb 2023 16:31:07 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chinwen.chang@mediatek.com, andrew.yang@mediatek.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/doc: Replace isolate_lru_page with folio_isolate_lru
Message-ID: <Y+UDq2DYJJSA3L60@kernel.org>
References: <20230131062853.28449-1-Kuan-Ying.Lee@mediatek.com>
 <87a61wvtcs.fsf@meer.lwn.net>
 <Y+Twr+g8PPL3uKhL@kernel.org>
 <Y+T78Wzeg3BgwiuY@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+T78Wzeg3BgwiuY@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 01:58:09PM +0000, Matthew Wilcox wrote:
> On Thu, Feb 09, 2023 at 03:10:07PM +0200, Mike Rapoport wrote:
> > On Thu, Feb 02, 2023 at 11:02:11AM -0700, Jonathan Corbet wrote:
> > > Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com> writes:
> > > 
> > > > Since we introduce folio, replace isolate_lru_page() with
> > > > folio_isolate_lru().
> > > >
> > > > Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> > > > ---
> > > >  Documentation/mm/page_migration.rst | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > This seems like a good patch to copy to linux-mm - done now.
> > > 
> > > The patch perhaps is a closer match to what's in linux-next, but it
> > > seems that, if we're going to update this document, we should reflect
> > > the use folios throughout?
> > 
> > Most of the current users of migrate_pages() still use isolate_lru_page()
> > so I think that updating page_migration.rst to folios is premature.
> > But when we do the update it also should include the translations.
> 
> It's a slim majority -- 9 of isolate_lru_pages() and 7 of
> folio_isolate_lru().  I don't think that changing the documentation is
> premature; we should document the functions we want people to use.
> I'd be surprised if isolate_lru_pages() still existed in six months.

That's a bit of a problem when documentation describes how things are done
rather than how to do them, but I don't have a strong feeling about
updating the docs while we are still in the transition period or postponing
it until e.g. isolate_lru_page() is gone.

But in any case, this should be much more comprehensive update rather than
replacing two occurrences out of three in a single file.

-- 
Sincerely yours,
Mike.
