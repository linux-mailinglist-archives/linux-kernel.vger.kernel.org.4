Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45A261A190
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiKDTv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiKDTvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:51:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9953B1C92B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 12:51:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DED1D218D6;
        Fri,  4 Nov 2022 19:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667591477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gDOGeXrmX7icgkepYrjKYckzxUWHvShoiQ1nxpZt4oo=;
        b=XsYJJxK986TaTHkLjogC7lmW5zS9xLzwznfY0/W9rFMKLQc0if1VnwbzPFbrQNz0VjsLpC
        YoTWAJ7fnwmlqRNgg306W0xFR/2G8ADJjsg9rXzAZVTIDmrdBLPE24wvNZV3JgeD/eswfK
        Y2EBhHqG7zFNbf19qu6AqsltL9F/Qtg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BDA4913216;
        Fri,  4 Nov 2022 19:51:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uTrkKjVtZWOAWAAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 04 Nov 2022 19:51:17 +0000
Date:   Fri, 4 Nov 2022 20:51:17 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     zokeefe@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 2/2] mm: don't warn if the node is offlined
Message-ID: <Y2VtNfkwciJ5hHF6@dhcp22.suse.cz>
References: <20221103213641.7296-1-shy828301@gmail.com>
 <20221103213641.7296-2-shy828301@gmail.com>
 <Y2Tc2JNeFWXmZbQ1@dhcp22.suse.cz>
 <Y2ThtYKSxoP9S44i@dhcp22.suse.cz>
 <CAHbLzkpvZ05+xSGWLCYKJntsLGzdda449XpjCH7sRE-3S8h+0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkpvZ05+xSGWLCYKJntsLGzdda449XpjCH7sRE-3S8h+0g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-11-22 10:42:45, Yang Shi wrote:
> On Fri, Nov 4, 2022 at 2:56 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Fri 04-11-22 10:35:21, Michal Hocko wrote:
> > [...]
> > > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > > index ef4aea3b356e..308daafc4871 100644
> > > --- a/include/linux/gfp.h
> > > +++ b/include/linux/gfp.h
> > > @@ -227,7 +227,10 @@ static inline
> > >  struct folio *__folio_alloc_node(gfp_t gfp, unsigned int order, int nid)
> > >  {
> > >       VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
> > > -     VM_WARN_ON((gfp & __GFP_THISNODE) && !node_online(nid));
> > > +     if((gfp & __GFP_THISNODE) && !node_online(nid)) {
> >
> > or maybe even better
> >         if ((gfp & (__GFP_THISNODE|__GFP_NOWARN) == __GFP_THISNODE|__GFP_NOWARN) && !node_online(nid))
> >
> > because it doesn't really make much sense to dump this information if
> > the allocation failure is going to provide sufficient (and even more
> > comprehensive) context for the failure. It looks more hairy but this can
> > be hidden in a nice little helper shared between the two callers.
> 
> Thanks a lot for the suggestion, printing warning if the gfp flag
> allows sounds like a good idea to me. Will adopt it. But the check
> should look like:
> 
> if ((gfp & __GFP_THISNODE) && !(gfp & __GFP_NOWARN) && !node_online(nid))

The idea was to warn if __GFP_NOWARN _was_ specified. Otherwise we will
get an allocation failure splat from the page allocator and there it
will be clear that the node doesn't have any memory associated. It is
exactly __GFP_NOWARN case that would be a silent failure and potentially
a buggy code (like this THP collapse path). See my point?
-- 
Michal Hocko
SUSE Labs
