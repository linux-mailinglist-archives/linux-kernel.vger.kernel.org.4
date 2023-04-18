Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902236E5A95
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjDRHiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 03:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjDRHiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:38:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4B23C2B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:38:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E37062C8C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D9FC433D2;
        Tue, 18 Apr 2023 07:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681803497;
        bh=aywSGl7+sE6dTjQmK39DnKLM7QTCjnhC/MpmTJAZGeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qPWwyDYJVFjNXr0MQOogfVNnADpvKkZYjxdvzqivGrwTCvkQibNVJJXBcc5gho//z
         z96gMpaI2SvUA5mPKw0t1mRmdJS9uRVI+OxgwkHM4/PUNOfNqvs955fP4Np2UiDY9v
         xutEPwMwPhAyX9c74/oHI2plz6BjafMXsZflMj6wgojaKmtiivzS1N3oYLS3C1s5ZT
         ehZy1uYfIfjGqj7tuxcZk0HTQlSHChBVI2EXZpbKbUorVHI8/MECayY+SakWjCwtPu
         gQABjByOkhR6Lt2Ws3uR69rPDranKEZx+FK6NeKB68XjDANGPvb59cku3i9Utm/xw7
         Y4lgqLWQ8cFyg==
Date:   Tue, 18 Apr 2023 09:38:10 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org,
        willy@infradead.org, linux-mm@kvack.org, p.raghav@samsung.com,
        da.gomez@samsung.com, a.manzanares@samsung.com, dave@stgolabs.net,
        yosryahmed@google.com, keescook@chromium.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] shmem: add support to ignore swap
Message-ID: <20230418-zynisch-satzglied-55821361f70a@brauner>
References: <20230309230545.2930737-1-mcgrof@kernel.org>
 <20230309230545.2930737-7-mcgrof@kernel.org>
 <79eae9fe-7818-a65c-89c6-138b55d609a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79eae9fe-7818-a65c-89c6-138b55d609a@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 10:50:59PM -0700, Hugh Dickins wrote:
> On Thu, 9 Mar 2023, Luis Chamberlain wrote:
> 
> > In doing experimentations with shmem having the option to avoid swap
> > becomes a useful mechanism. One of the *raves* about brd over shmem is
> > you can avoid swap, but that's not really a good reason to use brd if
> > we can instead use shmem. Using brd has its own good reasons to exist,
> > but just because "tmpfs" doesn't let you do that is not a great reason
> > to avoid it if we can easily add support for it.
> > 
> > I don't add support for reconfiguring incompatible options, but if
> > we really wanted to we can add support for that.
> > 
> > To avoid swap we use mapping_set_unevictable() upon inode creation,
> > and put a WARN_ON_ONCE() stop-gap on writepages() for reclaim.
> 
> I have one big question here, which betrays my ignorance:
> I hope that you or Christian can reassure me on this.
> 
> tmpfs has fs_flags FS_USERNS_MOUNT.  I know nothing about namespaces,
> nothing; but from overhearings, wonder if an ordinary user in a namespace
> might be able to mount their own tmpfs with "noswap", and thereby evade
> all accounting of the locked memory.
> 
> That would be an absolute no-no for this patch; but I assume that even
> if so, it can be easily remedied by inserting an appropriate (unknown
> to me!) privilege check where the "noswap" option is validated.

Oh, good catch. Thanks! So you would just need sm like:

diff --git a/mm/shmem.c b/mm/shmem.c
index 787e83791eb5..21ce9b26bb4d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3571,6 +3571,10 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
                ctx->seen |= SHMEM_SEEN_INUMS;
                break;
        case Opt_noswap:
+               if ((fc->user_ns != &init_user_ns) || !capable(CAP_SYS_ADMIN)) {
+                       return invalfc(fc,
+                                      "Turning off swap in unprivileged tmpfs mounts unsupported");
+               }
                ctx->noswap = true;
                ctx->seen |= SHMEM_SEEN_NOSWAP;
                break;

The fc->user_ns is the userns that the tmpfs mount will be mounted in, i.e.,
fc->user_ns will become sb->s_user_ns if FS_USERNS_MOUNT is raised. So with the
check above we require that the tmpfs instance must ultimately belong to the
initial userns and that the caller has CAP_SYS_ADMIN in the initial userns
(CAP_SYS_ADMIN guards swapon and swapoff) according to capabilities(7).
