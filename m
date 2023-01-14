Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D7B66AE3F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 23:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjANWK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 17:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjANWKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 17:10:24 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3205B76B1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 14:10:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A52033EB26;
        Sat, 14 Jan 2023 22:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673734221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hpQd30hM5sD53/V055856NaFnEhJfkox4w8QhX+l1iE=;
        b=PMBat9mnVPH4n4Sh51IztkXT9Y6QlwS4xHm/fpdfBJ4vr62V4Ti2pjzya0owz6sW7BZ99E
        zDnaa13ZJYefw4uH5HB7FyoJY6euoP3Q3ruODzeQcyWT8H4phxORifgVkeFLfRq48eIKXK
        JR66dQtuWFJ+5ivcJ8CkscfqmlQSo2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673734221;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hpQd30hM5sD53/V055856NaFnEhJfkox4w8QhX+l1iE=;
        b=mUIsUAbn4pnBlAU5TKwl3008gVwjhdIESKGp0T1k9Dp9WNXfVvYmylatWuFldGxWE/vTLO
        NPqFFfPORo+flgBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5ACAD1391E;
        Sat, 14 Jan 2023 22:10:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4FZCBEoow2NTEAAAMHmgww
        (envelope-from <neilb@suse.de>); Sat, 14 Jan 2023 22:10:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mel Gorman" <mgorman@techsingularity.net>
Cc:     "Michal Hocko" <mhocko@suse.com>, "Linux-MM" <linux-mm@kvack.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/7] mm/page_alloc: Give GFP_ATOMIC and non-blocking
 allocations access to reserves
In-reply-to: <20230111170552.5b7z5hetc2lcdwmb@techsingularity.net>
References: <20230109151631.24923-1-mgorman@techsingularity.net>,
 <20230109151631.24923-7-mgorman@techsingularity.net>,
 <Y77cikPSHepZ/GQj@dhcp22.suse.cz>,
 <20230111170552.5b7z5hetc2lcdwmb@techsingularity.net>
Date:   Sun, 15 Jan 2023 09:10:13 +1100
Message-id: <167373421396.4602.14376527067766958302@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023, Mel Gorman wrote:
> On Wed, Jan 11, 2023 at 04:58:02PM +0100, Michal Hocko wrote:
> > On Mon 09-01-23 15:16:30, Mel Gorman wrote:
> > > Explicit GFP_ATOMIC allocations get flagged ALLOC_HARDER which is a bit
> > > vague. In preparation for removing __GFP_ATOMIC, give GFP_ATOMIC and
> > > other non-blocking allocation requests equal access to reserve.  Rename
> > > ALLOC_HARDER to ALLOC_NON_BLOCK to make it more clear what the flag
> > > means.
> >=20
> > GFP_NOWAIT can be also used for opportunistic allocations which can and
> > should fail quickly if the memory is tight and more elaborate path
> > should be taken (e.g. try higher order allocation first but fall back to
> > smaller request if the memory is fragmented). Do we really want to give
> > those access to memory reserves as well?
>=20
> Good question. Without __GFP_ATOMIC, GFP_NOWAIT only differs from GFP_ATOMIC
> by __GFP_HIGH but that is not enough to distinguish between a caller that
> cannot sleep versus one that is speculatively attempting an allocation but
> has other options.

Isn't that a distinction without a difference?
A caller than cannot sleep MUST have other options, because failure is
always possible.
The "other option" might be failure (error to user space, dropped packets
etc), but sometimes failure IS an option.

So the difference between ATOMIC and NOWAIT boils down to the perceived
cost of the "other options".  If that cost is high, then include
__GFP_HIGH to get GFP_ATOMIC.  If that cost is low, then don't include
__GFP_HIGH and get GFP_NOWAIT.

I don't think there is any useful third option that is worth supporting.

NeilBrown



>                     That changelog is misleading, it's not equal access
> as GFP_NOWAIT ends up with 25% of the reserves which is less than what
> GFP_ATOMIC gets.
>=20
> Because it becomes impossible to distinguish between non-blocking and
> atomic without __GFP_ATOMIC, there is some justification for allowing
> access to reserves for GFP_NOWAIT. bio for example attempts an allocation
> (clears __GFP_DIRECT_RECLAIM) before falling back to mempool but delays
> in IO can also lead to further allocation pressure. mmu gather failing
> GFP_WAIT slows the rate memory can be freed. NFS failing GFP_NOWAIT will
> have to retry IOs multiple times. The examples were picked at random but
> the point is that there are cases where failing GFP_NOWAIT can degrade
> the system, particularly delay the cleaning of pages before reclaim.
>=20
> A lot of the truly speculative users appear to use GFP_NOWAIT | __GFP_NOWARN
> so one compromise would be to avoid using reserves if __GFP_NOWARN is
> also specified.
>=20
> Something like this as a separate patch?
>=20
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7244ab522028..0a7a0ac1b46d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4860,9 +4860,11 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int orde=
r)
>  	if (!(gfp_mask & __GFP_DIRECT_RECLAIM)) {
>  		/*
>  		 * Not worth trying to allocate harder for __GFP_NOMEMALLOC even
> -		 * if it can't schedule.
> +		 * if it can't schedule. Similarly, a caller specifying
> +		 * __GFP_NOWARN is likely a speculative allocation with a
> +		 * graceful recovery path.
>  		 */
> -		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
> +		if (!(gfp_mask & (__GFP_NOMEMALLOC|__GFP_NOWARN))) {
>  			alloc_flags |=3D ALLOC_NON_BLOCK;
> =20
>  			if (order > 0)
>=20
