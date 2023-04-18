Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F3F6E6EA7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjDRVve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbjDRVvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:51:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E139ED9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ClDY4zHXRxRv2R7Gk0yxGFQ9XOyZD63mK1Ox3vqagFk=; b=tLrHj4dpnxEso0zEI7YDFkRe8c
        ccFF/qmeH0RhHBIz3uv6kHhvZCxc2qY6avkIHU6R2A4DI7lyB4C2vyszGoON7OELrM18pDKzcOf+x
        6V3NjGz5FcREQN1Rt3T7yReInwnEYFl7ve2fLcXs5A+UzX0oPcsEDH2MbmWx7CGLwIVnDRmPuaSSb
        vFuqm5As8EbB7LF+Hrk/UH4w8yxfaFdeiY6ZZz38NF/ujIMZ+opaidxDOZu3v0lMkeGDdWiePSEzR
        XDpgUX/FzPEt1EwQegGHRWoQBT47xC2RlFe/WAi2hLF30NkOso6UMWnwbJ75pExjMRt+dNuFCqRkk
        6mGiSQDQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1potEP-003RhZ-23;
        Tue, 18 Apr 2023 21:51:21 +0000
Date:   Tue, 18 Apr 2023 14:51:21 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org,
        willy@infradead.org, linux-mm@kvack.org, p.raghav@samsung.com,
        da.gomez@samsung.com, a.manzanares@samsung.com, dave@stgolabs.net,
        yosryahmed@google.com, keescook@chromium.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] shmem: add support to ignore swap
Message-ID: <ZD8Q2SzVr3xDmCgY@bombadil.infradead.org>
References: <20230309230545.2930737-1-mcgrof@kernel.org>
 <20230309230545.2930737-7-mcgrof@kernel.org>
 <79eae9fe-7818-a65c-89c6-138b55d609a@google.com>
 <20230418-zynisch-satzglied-55821361f70a@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418-zynisch-satzglied-55821361f70a@brauner>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 09:38:10AM +0200, Christian Brauner wrote:
> On Mon, Apr 17, 2023 at 10:50:59PM -0700, Hugh Dickins wrote:
> > On Thu, 9 Mar 2023, Luis Chamberlain wrote:
> > 
> > > In doing experimentations with shmem having the option to avoid swap
> > > becomes a useful mechanism. One of the *raves* about brd over shmem is
> > > you can avoid swap, but that's not really a good reason to use brd if
> > > we can instead use shmem. Using brd has its own good reasons to exist,
> > > but just because "tmpfs" doesn't let you do that is not a great reason
> > > to avoid it if we can easily add support for it.
> > > 
> > > I don't add support for reconfiguring incompatible options, but if
> > > we really wanted to we can add support for that.
> > > 
> > > To avoid swap we use mapping_set_unevictable() upon inode creation,
> > > and put a WARN_ON_ONCE() stop-gap on writepages() for reclaim.
> > 
> > I have one big question here, which betrays my ignorance:
> > I hope that you or Christian can reassure me on this.
> > 
> > tmpfs has fs_flags FS_USERNS_MOUNT.  I know nothing about namespaces,
> > nothing; but from overhearings, wonder if an ordinary user in a namespace
> > might be able to mount their own tmpfs with "noswap", and thereby evade
> > all accounting of the locked memory.
> > 
> > That would be an absolute no-no for this patch; but I assume that even
> > if so, it can be easily remedied by inserting an appropriate (unknown
> > to me!) privilege check where the "noswap" option is validated.
> 
> Oh, good catch. Thanks! So you would just need sm like:
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 787e83791eb5..21ce9b26bb4d 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3571,6 +3571,10 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
>                 ctx->seen |= SHMEM_SEEN_INUMS;
>                 break;
>         case Opt_noswap:
> +               if ((fc->user_ns != &init_user_ns) || !capable(CAP_SYS_ADMIN)) {
> +                       return invalfc(fc,
> +                                      "Turning off swap in unprivileged tmpfs mounts unsupported");
> +               }
>                 ctx->noswap = true;
>                 ctx->seen |= SHMEM_SEEN_NOSWAP;
>                 break;
> 
> The fc->user_ns is the userns that the tmpfs mount will be mounted in, i.e.,
> fc->user_ns will become sb->s_user_ns if FS_USERNS_MOUNT is raised. So with the
> check above we require that the tmpfs instance must ultimately belong to the
> initial userns and that the caller has CAP_SYS_ADMIN in the initial userns
> (CAP_SYS_ADMIN guards swapon and swapoff) according to capabilities(7).

Christian, mind sending this as a fix?

  Luis
