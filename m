Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14BB6177F9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiKCHvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiKCHvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:51:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE375FBC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 00:51:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 14BE4221E1;
        Thu,  3 Nov 2022 07:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667461864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xMZ1/xJ+ivqqXiqEy69V2CepWd5ZrOeZBYR6ed7f3e8=;
        b=aOiZS7XFJ3YklcHmkjQTN1uqrMjkvOInWO2MC2j4n5zWROVryAl7PshMGM+tnxeKXjoD00
        Wh4N+RX6R4FMmGBRCQzD1fKJ0Mx2RBjZ5uEOov2HZyxx9G5m4uPZKmgfUUI0miVLzm+WJi
        4WkY3IZsSyKxTFKozZjDQAWKIq11S8o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E910E13AAF;
        Thu,  3 Nov 2022 07:51:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hF0hNudyY2PgJwAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 03 Nov 2022 07:51:03 +0000
Date:   Thu, 3 Nov 2022 08:51:03 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Zach O'Keefe <zokeefe@google.com>
Cc:     Yang Shi <shy828301@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Davidoff <davidoff@qedmf.net>,
        Bob Liu <lliubbo@gmail.com>
Subject: Re: [PATCH] mm: don't warn if the node is offlined
Message-ID: <Y2Ny54MOyr3LveY3@dhcp22.suse.cz>
References: <Y2DQr06mNzk0ITX1@dhcp22.suse.cz>
 <CAHbLzkonsnr4yxUOpMpoch1eCVNgR5hC9YaMkPR=fSV2Uszc6g@mail.gmail.com>
 <CAAa6QmRe1zMp8P-gZjR63Fg6KhOw+fP-v7SQWLNKuc2Y9ZxvyA@mail.gmail.com>
 <Y2IerOXJ+ZoRTHcs@dhcp22.suse.cz>
 <CAHbLzkrBNzsorc9oCq1=ri0uq1xbQ+m+u2gQX5GYrb=Z7n4siA@mail.gmail.com>
 <Y2KXkVmRWOpPT/MI@dhcp22.suse.cz>
 <CAHbLzkosQf8OoL+u+gkfO5-fvCNUuDxEa08FUfks1M4AS7tmjw@mail.gmail.com>
 <Y2KtKVpR69P+E0xT@dhcp22.suse.cz>
 <CAHbLzkpirnzJSu0SHGRbhFMsH7ZzHtL5ZMXjrBoy8r=UywVhMg@mail.gmail.com>
 <CAAa6QmQ+4XndbtE_=mcaC5OaeK4g42dKYfY5FmYoRDTKGO-3nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAa6QmQ+4XndbtE_=mcaC5OaeK4g42dKYfY5FmYoRDTKGO-3nA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-11-22 11:58:26, Zach O'Keefe wrote:
> On Wed, Nov 2, 2022 at 11:18 AM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Wed, Nov 2, 2022 at 10:47 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Wed 02-11-22 10:36:07, Yang Shi wrote:
> > > > On Wed, Nov 2, 2022 at 9:15 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Wed 02-11-22 09:03:57, Yang Shi wrote:
> > > > > > On Wed, Nov 2, 2022 at 12:39 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > >
> > > > > > > On Tue 01-11-22 12:13:35, Zach O'Keefe wrote:
> > > > > > > [...]
> > > > > > > > This is slightly tangential - but I don't want to send a new mail
> > > > > > > > about it -- but I wonder if we should be doing __GFP_THISNODE +
> > > > > > > > explicit node vs having hpage_collapse_find_target_node() set a
> > > > > > > > nodemask. We could then provide fallback nodes for ties, or if some
> > > > > > > > node contained > some threshold number of pages.
> > > > > > >
> > > > > > > I would simply go with something like this (not even compile tested):
> > > > > >
> > > > > > Thanks, Michal. It is definitely an option. As I talked with Zach, I'm
> > > > > > not sure whether it is worth making the code more complicated for such
> > > > > > micro optimization or not. Removing __GFP_THISNODE or even removing
> > > > > > the node balance code should be fine too IMHO. TBH I doubt there would
> > > > > > be any noticeable difference.
> > > > >
> > > > > I do agree that an explicit nodes (quasi)round robin sounds over
> > > > > engineered. It makes some sense to try to target the prevalent node
> > > > > though because this code can be executed from khugepaged and therefore
> > > > > allocating with a completely different affinity than the original fault.
> > > >
> > > > Yeah, the corner case comes from the node balance code, it just tries
> > > > to balance between multiple prevalent nodes, so you agree to remove it
> > > > IIRC?
> > >
> > > Yeah, let's just collect all good nodes into a nodemask and keep
> > > __GFP_THISNODE in place. You can consider having the nodemask per collapse_control
> > > so that you allocate it only once in the struct lifetime.
> >
> > Actually my intention is more aggressive, just remove that node balance code.
> >
> 
> The balancing code dates back to 2013 commit 9f1b868a13ac ("mm: thp:
> khugepaged: add policy for finding target node") where it was made to
> satisfy "numactl --interleave=all". I don't know why any real
> workloads would want this -- but there very well could be a valid use
> case. If not, I think it could be removed independent of what we do
> with __GFP_THISNODE and nodemask.

Thanks for the reference. The patch is really dubious. If the primary
usecase is a memory policy then one should be used. We have the vma
handy. Sure per task policy would be a bigger problem but interleaving
is a mere hint rather than something that has hard requirements.

> Balancing aside -- I haven't fully thought through what an ideal (and
> further overengineered) solution would be for numa, but one (perceived
> - not measured) issue that khugepaged might have (MADV_COLLAPSE
> doesn't have the choice) is on systems with many, many nodes with
> source pages sprinkled across all of them. Should we collapse these
> pages into a single THP from the node with the most (but could still
> be a small %) pages? Probably there are better candidates. So, maybe a
> khugepaged-only check for max_value > (HPAGE_PMD_NR >> 1) or something
> makes sense.

Honestly I do not see any problem to be solved here.

-- 
Michal Hocko
SUSE Labs
