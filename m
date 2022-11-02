Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007A9616B2D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiKBRrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiKBRrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:47:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9845927B18
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 10:47:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4B48E1F855;
        Wed,  2 Nov 2022 17:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667411242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bIXibXXjjmnVVHx6xjVFUipVPFmWAiVSbZzEqPxgGqU=;
        b=gIsTGpGgO0MrSHOFFGoAwL+viqPrxOnfGXqwBcdrDNOz2aiMyvX2X8419Cvfk6GWPGoJB5
        4mQ8qcsOKYh6eF3aAb36+YLp1iq5ueprzeCyLwRpHHa8LEezhpAVTTS1aLnc+19TdlZ+lT
        CfQWH4wz9OsbO9obcDsQtc+EpgcMwQ8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3089A139D3;
        Wed,  2 Nov 2022 17:47:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id e3wLCiqtYmMKSQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 02 Nov 2022 17:47:22 +0000
Date:   Wed, 2 Nov 2022 18:47:21 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Zach O'Keefe <zokeefe@google.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: don't warn if the node is offlined
Message-ID: <Y2KtKVpR69P+E0xT@dhcp22.suse.cz>
References: <20221031183122.470962-1-shy828301@gmail.com>
 <Y2BHcBCR2FIJgU4w@dhcp22.suse.cz>
 <CAAa6QmQt9Us8YpirQGXV0_AetuPS+EOqMSGqNn6KW24HXvwO_A@mail.gmail.com>
 <Y2DQr06mNzk0ITX1@dhcp22.suse.cz>
 <CAHbLzkonsnr4yxUOpMpoch1eCVNgR5hC9YaMkPR=fSV2Uszc6g@mail.gmail.com>
 <CAAa6QmRe1zMp8P-gZjR63Fg6KhOw+fP-v7SQWLNKuc2Y9ZxvyA@mail.gmail.com>
 <Y2IerOXJ+ZoRTHcs@dhcp22.suse.cz>
 <CAHbLzkrBNzsorc9oCq1=ri0uq1xbQ+m+u2gQX5GYrb=Z7n4siA@mail.gmail.com>
 <Y2KXkVmRWOpPT/MI@dhcp22.suse.cz>
 <CAHbLzkosQf8OoL+u+gkfO5-fvCNUuDxEa08FUfks1M4AS7tmjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkosQf8OoL+u+gkfO5-fvCNUuDxEa08FUfks1M4AS7tmjw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-11-22 10:36:07, Yang Shi wrote:
> On Wed, Nov 2, 2022 at 9:15 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 02-11-22 09:03:57, Yang Shi wrote:
> > > On Wed, Nov 2, 2022 at 12:39 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Tue 01-11-22 12:13:35, Zach O'Keefe wrote:
> > > > [...]
> > > > > This is slightly tangential - but I don't want to send a new mail
> > > > > about it -- but I wonder if we should be doing __GFP_THISNODE +
> > > > > explicit node vs having hpage_collapse_find_target_node() set a
> > > > > nodemask. We could then provide fallback nodes for ties, or if some
> > > > > node contained > some threshold number of pages.
> > > >
> > > > I would simply go with something like this (not even compile tested):
> > >
> > > Thanks, Michal. It is definitely an option. As I talked with Zach, I'm
> > > not sure whether it is worth making the code more complicated for such
> > > micro optimization or not. Removing __GFP_THISNODE or even removing
> > > the node balance code should be fine too IMHO. TBH I doubt there would
> > > be any noticeable difference.
> >
> > I do agree that an explicit nodes (quasi)round robin sounds over
> > engineered. It makes some sense to try to target the prevalent node
> > though because this code can be executed from khugepaged and therefore
> > allocating with a completely different affinity than the original fault.
> 
> Yeah, the corner case comes from the node balance code, it just tries
> to balance between multiple prevalent nodes, so you agree to remove it
> IIRC?

Yeah, let's just collect all good nodes into a nodemask and keep
__GFP_THISNODE in place. You can consider having the nodemask per collapse_control
so that you allocate it only once in the struct lifetime.

And as mentioned in other reply it would be really nice to hide this
under CONFIG_NUMA (in a standalong follow up of course).

-- 
Michal Hocko
SUSE Labs
