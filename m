Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9875364089A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbiLBOih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbiLBOid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:38:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FA363BB9;
        Fri,  2 Dec 2022 06:38:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A20D6B82185;
        Fri,  2 Dec 2022 14:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2219C433D6;
        Fri,  2 Dec 2022 14:38:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GmyxGuFQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669991904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sj3sV8ZF7V6ZxV0fZYVQwprsf9twVEkMvj7MCPVNWHc=;
        b=GmyxGuFQp01uapUzRl7YaSjdjmIqqzsPUwKU6mQ2gE0BK8y2nZxasRl1JTs3QgLZb55mFN
        Fh7cAQ+hjTkU8z+9E5aw7a8xbV2mPAHSTSf80vdda0JwxoPDcynQIaTOFSvdJts5qEyFki
        ERZ91gFHRp8vMEyq8/qdSI41j4LOgOQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ccdf8612 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 2 Dec 2022 14:38:24 +0000 (UTC)
Date:   Fri, 2 Dec 2022 15:38:20 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v10 1/4] random: add vgetrandom_alloc() syscall
Message-ID: <Y4oN3JDG4uH2+OUo@zx2c4.com>
References: <20221129210639.42233-1-Jason@zx2c4.com>
 <20221129210639.42233-2-Jason@zx2c4.com>
 <877czc7m0g.fsf@oldenburg.str.redhat.com>
 <Y4d5SyU3akA9ZBaJ@zx2c4.com>
 <Y4eG9cUE28s0YpgO@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y4eG9cUE28s0YpgO@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 05:38:13PM +0100, Jason A. Donenfeld wrote:
> On Wed, Nov 30, 2022 at 04:39:55PM +0100, Jason A. Donenfeld wrote:
> > 2) Convert vgetrandom_alloc() into a clone3-style syscall, as Christian
> >    suggested earlier, which might allow for a bit more overloading
> >    capability. That would be a struct that looks like:
> > 
> >       struct vgetrandom_alloc_args {
> > 	  __aligned_u64 flags;
> >           __aligned_u64 states;
> > 	  __aligned_u64 num;
> > 	  __aligned_u64 size_of_each;
> >       }
> > 
> >   - If flags is VGRA_ALLOCATE, states and size_of_each must be zero on
> >     input, while num is the hint, as is the case now. On output, states,
> >     size_of_each, and num are filled in.
> > 
> >   - If flags is VGRA_DEALLOCATE, states, size_of_each, and num must be as
> >     they were originally, and then it deallocates.
> > 
> > I suppose (2) would alleviate your concerns entirely, without future
> > uncertainty over what it'd be like to add special cases to munmap(). And
> > it'd add a bit more future proofing to the syscall, depending on what we
> > do.
> > 
> > So maybe I'm warming up to that approach a bit.
> 
> So I just did a little quick implementation to see what it'd feel like,
> and actually, it's quite simple, and might address a lot of concerns all
> at once. What do you think of the below? Documentation and such still
> needs work obviously, but the bones should be there.

Well, despite writing into the ether here, I continue to chase my tail
around in circles over this. After Adhemerval expressed a sort of "meh"
opinion to me on IRC around doing the clone3-like thing, I went down a
mm rabbit hole and started looking at all the various ways memory is
allocated in userspace and under what conditions and for what and why.
Turns out there are a few drivers doing interesting things in this
space.

The long and short of it is that:
- All addresses involve maps and page tables.
- Allocating is mapping, deallocating is unmapping, and there's no way
  around that.
- Memory that's "special" usually comes with special attributes or
  operations on its vma.

So, this makes me think that `munmap` is the fine *and correct* API for
deallocation. It's what everything else uses, even "special" things. And
it doesn't constrain us in the future in case this gets "registered"
somehow, as Florian described it, because it's still attached to
current->mm and will still always go through the same mapping APIs
anyway.

In light of that, I'm going to stick with the original API design, and
not do the clone3() args struct thing and the VGRA_DEALLOCATE flag.
However, I think it'd be a good idea to add an additional parameter of
"unsigned long addr", which is enforced/reserved to be always 0 for now.
This might prove useful for something together with the currently unused
flags argument, sometime in the future.

Jason
