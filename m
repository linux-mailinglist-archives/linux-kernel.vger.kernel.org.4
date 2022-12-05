Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F6E643100
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiLETE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbiLETEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:04:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E3123EA6;
        Mon,  5 Dec 2022 11:04:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E197761300;
        Mon,  5 Dec 2022 19:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF08C433D6;
        Mon,  5 Dec 2022 19:04:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cKDSYYzt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1670267058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oDteMypEpYpY0CiDbGvFEDl48gIcKWjcXZEnNb6r76Y=;
        b=cKDSYYztUncnpgz7a4ytBhfxGrSYZJQLpGzEUm7tNme//NgWpesMDn2Ig8uWOMo9VwKDzr
        A6sxXCwW4OT4aDtUGf7XbOJLdTVIcIY0sw1R2oyamOP9bvmPR+7aGY/z+WpYCdEpUW3Bba
        TnnqdkN95DzYDy4IyphCEAmnvJJ+W30=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ac339290 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 5 Dec 2022 19:04:18 +0000 (UTC)
Date:   Mon, 5 Dec 2022 20:04:15 +0100
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
Subject: Re: [PATCH v11 3/4] random: introduce generic vDSO getrandom()
 implementation
Message-ID: <Y45Ar3mwRBSr+X7F@zx2c4.com>
References: <20221205020046.1876356-1-Jason@zx2c4.com>
 <20221205020046.1876356-4-Jason@zx2c4.com>
 <878rjlr85s.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878rjlr85s.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Mon, Dec 05, 2022 at 07:56:47PM +0100, Florian Weimer wrote:
> * Jason A. Donenfeld:
> 
> > +retry_generation:
> > +	/*
> > +	 * @rng_info->generation must always be read here, as it serializes @state->key with the
> > +	 * kernel's RNG reseeding schedule.
> > +	 */
> > +	current_generation = READ_ONCE(rng_info->generation);
> 
> > +		if (unlikely(READ_ONCE(state->generation) != READ_ONCE(rng_info-
> 
> I'm pretty sure you need some sort of barrier here.  We have a similar
> TM-lite construct in glibc ld.so for locating link maps by address, and
> there the compiler performed reordering.
> 
>   _dl_find_object miscompilation on powerpc64le
>   <https://sourceware.org/bugzilla/show_bug.cgi?id=28745>
> 
> I'm not familiar with READ_ONCE, but Documentation/atomic_t.txt suggests
> it's a “regular LOAD”, and include/asm-generic/rwonce.h concurs.

Do you mean compiler barriers or SMP barriers?

> Likewise, the signal safety mechanism needs compiler barriers (signal
> fences).

READ_ONCE() should prevent the compiler from reordering the read.
 
> I'm also not sure how READ_ONCE realizes atomic 64-bit reads on 32-bit
> platforms.  i386 can do them in user space via the FPU worst-case (if
> the control word hasn't been corrupted).  CMPXCHG8B is not applicable
> here because it's a read-only mapping.  Maybe add a comment at least
> about that “strong prevailing wind”?

There's read tearing in that case, which isn't super, but perhaps not
all together harmful.

Jason
