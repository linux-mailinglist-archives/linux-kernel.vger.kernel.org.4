Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928CC61A19F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiKDT4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiKDTzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:55:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6B842F61
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 12:55:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AB51221941;
        Fri,  4 Nov 2022 19:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667591751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hI5OSNvXigNGk2vVduLj+s1GoBjQ1nDCrrLAkbiWlHY=;
        b=Bq40Q4hXjQRHlkGHhdYFNS7VO9xohvldjuTzF2j7ruLIik3cHRJwAhNS1afmk8+IJPuYRg
        BQtk55daHZltBwibmElifaSXEMCS/CQOLyTufZBHMQlmYjbW2GPM2vvdrLe7lt0wTbBfRA
        F2mo/22C6Fzw+5tSDHZG01mGnfxEkPU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8775A13216;
        Fri,  4 Nov 2022 19:55:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id g5njHUduZWO4WgAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 04 Nov 2022 19:55:51 +0000
Date:   Fri, 4 Nov 2022 20:55:50 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     zokeefe@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 1/2] mm: khugepaged: allow page allocation fallback to
 eligible nodes
Message-ID: <Y2VuRplhVmKiabR9@dhcp22.suse.cz>
References: <20221103213641.7296-1-shy828301@gmail.com>
 <Y2TOAdHk97pPYwJY@dhcp22.suse.cz>
 <CAHbLzkpPioG8kiTHtepEtTC8sr8JAc2JTJk0s7WQH+fCh6YFKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkpPioG8kiTHtepEtTC8sr8JAc2JTJk0s7WQH+fCh6YFKA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-11-22 10:37:39, Yang Shi wrote:
> On Fri, Nov 4, 2022 at 1:32 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 03-11-22 14:36:40, Yang Shi wrote:
> > [...]
> > > So use nodemask to record the nodes which have the same hit record, the
> > > hugepage allocation could fallback to those nodes.  And remove
> > > __GFP_THISNODE since it does disallow fallback.  And if nodemask is
> > > empty (no node is set), it means there is one single node has the most
> > > hist record, the nodemask approach actually behaves like __GFP_THISNODE.
> > >
> > > Reported-by: syzbot+0044b22d177870ee974f@syzkaller.appspotmail.com
> > > Suggested-by: Zach O'Keefe <zokeefe@google.com>
> > > Suggested-by: Michal Hocko <mhocko@suse.com>
> > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > ---
> > >  mm/khugepaged.c | 32 ++++++++++++++------------------
> > >  1 file changed, 14 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index ea0d186bc9d4..572ce7dbf4b0 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -97,8 +97,8 @@ struct collapse_control {
> > >       /* Num pages scanned per node */
> > >       u32 node_load[MAX_NUMNODES];
> > >
> > > -     /* Last target selected in hpage_collapse_find_target_node() */
> > > -     int last_target_node;
> > > +     /* nodemask for allocation fallback */
> > > +     nodemask_t alloc_nmask;
> >
> > This will eat another 1k on the stack on most configurations
> > (NODE_SHIFT=10). Along with 4k of node_load this is quite a lot even
> > on shallow call chains like madvise resp. khugepaged.  I would just
> > add a follow up patch which changes both node_load and alloc_nmask to
> > dynamically allocated objects.
> 
> The collapse_control is allocated by kmalloc dynamically for
> MADV_COLLAPSE path, and defined as a global variable for khugepaged
> (khugepaged_collapse_control). So it is not on stack.

Dang, I must have been blind because I _think_ I have seen it as a local
stack defined. Maybe I just implicitly put that to the same bucket as
othe $foo_control (e.g. scan_control, oom_control etc) which leave on the
stack usually. Sorry about the confusion. Sorry for the noise.

Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
