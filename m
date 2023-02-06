Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9756468C43F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjBFRKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFRKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:10:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9332449C;
        Mon,  6 Feb 2023 09:10:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05A68B81588;
        Mon,  6 Feb 2023 17:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B9AC433D2;
        Mon,  6 Feb 2023 17:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675703398;
        bh=T6nMlMtjoX6nM1kpqNXBW0g7A7KPs11O2AjUDAhAjpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0iz1ivBLo8y3bHaI0HhMvcjLRjKFd7jHbXOPOwRjnOL9QgQLUfpscK36uj77LWqr
         uMKcdc/u3eiEng7jQJiGj32RvMDS0zXDoIaCraxqTBFcCXxwRTn1qj76FTusigz9Mr
         dAU5KiZwtk4knDj8wAMj1CBUQpjH1bJV3jomqw3XTks/ABa9u2tnWPWThu3JEXn2di
         kvhaItUMCgcyDbpvZhIlFwwyRFw3X1RpruZulQWXLgbDs5JGirmZ8+wW+VMqr2kdI3
         HvtBWmrF5EzVL5patiEo2KmKLbA729GvQWSDjgJo6fZCwT9lzFYAFfcbjx4pmOL41U
         ENFnNFe3jzyAw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pP50f-0000MO-HS; Mon, 06 Feb 2023 18:10:29 +0100
Date:   Mon, 6 Feb 2023 18:10:29 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [PATCH v4 06/19] irqdomain: Drop revmap mutex
Message-ID: <Y+E0hRcvjMb9bynE@hovoldconsulting.com>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
 <20230116135044.14998-7-johan+linaro@kernel.org>
 <871qnslut3.ffs@tglx>
 <Y8e6Us0Qgt0p5S4R@hovoldconsulting.com>
 <87r0vshu1y.ffs@tglx>
 <Y8fv3KWoxmaykrP6@hovoldconsulting.com>
 <87zg9rx7o1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zg9rx7o1.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 02:09:02PM +0100, Thomas Gleixner wrote:
> On Wed, Jan 18 2023 at 14:10, Johan Hovold wrote:
> > On Wed, Jan 18, 2023 at 02:05:29PM +0100, Thomas Gleixner wrote:
> >> You can do this in a two step approach.
> >> 
> >>     1) Add the new locking and ensure that the lock is held when
> >>        the functions are called
> >
> > But the new locking has nothing to do with these functions. They are
> > added because they fix various races elsewhere. Adding lockdep
> > assertions in unrelated function as part of those fixes doesn't really
> > make much sense.
> 
> Seriously? The point is that revmap_mutex is not protecting against any
> of the races which you are trying to protect against. Ergo, any callsite
> which does not hold the irqdomain mutex is part of the problem you are
> trying to solve, no?

The current locking using the revmap_mutex is indeed incomplete as it
only serialises updates of the revmap structures themselves and
specifically does not prevent two mappings for the same interrupt to be
created. It basically just protects the integrity of the revmap tree.

The association and disassocation fixes are not sufficient to address the
mapping race, but those two changes do guarantee that all current paths
that access the revmap structures hold the irq_domain_mutex.

Once that has been established, there is no point in keeping the
revmap_mutex around for the update path (lookups are still protected by
RCU).

But this change is separate from the race that the disassociation fix
addressed (e.g. the racy updates of the domain mapcount) and it is also
independent of the fix for the mapping race (which still exists after
removing the revmap mutex with the current order of the patches).

Therefore the dropping the revmap mutex belongs in its own patch and I
placed it here after the disassociation fix to highlight that it is
indeed independent of the later fixes for the mapping race.

It can be moved after, but I still think the lockdep asserts belong in
the patch that removes the revmap tree lock.

Johan
