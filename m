Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B94A6435DC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbiLEUkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiLEUkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:40:11 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9362A731;
        Mon,  5 Dec 2022 12:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=uKMIiWg7WMfEfBo1Es+0k/dOYC/WMrl1VUa9+5uwzE0=; b=WI+A2dg1zGr7mUREYNlOTu2i00
        lW0PG15Nx+V8GnMUg+UzLSI3O8Z+/dx8iuBQF4oiXOjXIeU9847rns43rafqz8yKXjYpXtv1DFRbv
        oxrjEcy4oDyuBoHcPLWeBHjpsmDuot3MmtSlnfzamAu7aEjlTO5FhNtSBX6biDA97hVsWCw0YQlS0
        t+Lc0w0IyOgqca6U2jAzmsGek7Dfyq/ISG3CJmewit5FNK3lYv9BSf3qznDT4REcx5wWRb/p26SwA
        jUN3T8VAu5bEzXTt1v1P/LMZu90LS3ANFwtqIIXizU4RdEzwUOZ/n8lZc9cy9wTJ7iQgbSKElVdvk
        W9DN4MSGbS1PN+niE8l8XT3CXyAdymLpBTQVe/6fAFLMsOlWwmrb82WM/O7GhKQaMB/o+mGfndKqt
        cV3Y4Px+DT+Q6IklzPNb70GjoGp7QL6KAMJl0PR/DxP0ndZ4V4Im3ZDJ8DYEJv24Q2yOMGyoBf+0L
        bq5Qls2Ft5hKKMVKzrtVSQIIx1rANbt5JeqRODEs9aibM/wijqky3Tb2sebdvYQMMyrfDigC/Pmy3
        bIXPHn08/RVU3Gl4I3s9uHgLR6MBCwMwUr9NAordhWLxYUDMbOdJ8XMDsqLPNYzmz+/d2uYIw6sp+
        VwVLTCAcjvg6D31R6YXvb2V78t0J06ZEUz44R9TqY=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the v9fs tree
Date:   Mon, 05 Dec 2022 21:40:06 +0100
Message-ID: <3823616.UlgstfPZBx@silver>
In-Reply-To: <46397336.ChKRcxMYMu@silver>
References: <20221205150316.6fac25f2@canb.auug.org.au> <Y41vKkaH9tvRXCfv@codewreck.org>
 <46397336.ChKRcxMYMu@silver>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, December 5, 2022 3:31:57 PM CET Christian Schoenebeck wrote:
> On Monday, December 5, 2022 5:10:18 AM CET Dominique Martinet wrote:
> > Stephen Rothwell wrote on Mon, Dec 05, 2022 at 03:03:16PM +1100:
> > > After merging the v9fs tree, today's linux-next build (i386 defconfig)
> 
> > > failed like this:
> [...]
> 
> > > net/9p/client.c:523:17: note: in expansion of macro 'pr_err'
> > > 
> > >   523 |                 pr_err(
> > >   
> > >       |                 ^~~~~~
> > > 
> > > cc1: all warnings being treated as errors
> > > 
> > > Caused by commit
> > > 
> > >   36cd2f80abf8 ("net/9p: fix response size check in p9_check_errors()")
> > > 
> > > I have applied the following patch for today:
> > Thank you!
> > I guess I should start building one 32bit kernel somewhere...
> :
> :/ I'll setup a 32-bit build system as well, sorry!

Dominique, looking at your 9p queue, I just realized what happened here: I 
posted a v2 of these two patches, which got lost for some reason:

https://lore.kernel.org/all/cover.1669144861.git.linux_oss@crudebyte.com/

The currently queued 1st patch is still v1 as well.

Best regards,
Christian Schoenebeck



