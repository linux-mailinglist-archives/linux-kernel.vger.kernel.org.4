Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B76B5BFE8B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 15:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiIUNBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 09:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiIUNBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 09:01:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9C229C96;
        Wed, 21 Sep 2022 06:01:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6B4F61F88F;
        Wed, 21 Sep 2022 13:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663765267;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SNOx7u/YQMIaTFhVzek1ee94itBFfBqVi5hVjzogOrM=;
        b=w96BX+RZ4LI2I1gSSCNz1WzUxOSmT/ftdP87PZsC/lhCyeX+JSmn5MNEKJCk6rxCZaZJ5i
        q4qup0ww94M49Z18AIlv9NnY3fKzaQbk9R4ra4EbELxgDy2tfUTO/faed177fpkYWa+at3
        1GUaKRbgLJn21ONDnXP5UmldQRL8dbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663765267;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SNOx7u/YQMIaTFhVzek1ee94itBFfBqVi5hVjzogOrM=;
        b=/bDdRRT7yb0B3YNd+chIJllTtWIpxxXPvL9XfsQSP49oD5NrC+KdNEvE/CGcRivMRsMFLK
        ECPigt2cFFDZJeAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3ECF613A89;
        Wed, 21 Sep 2022 13:01:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bCdrDhMLK2PYLwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 21 Sep 2022 13:01:07 +0000
Date:   Wed, 21 Sep 2022 14:55:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Jules Irenge <jbi.octave@gmail.com>, x86@kernel.org
Subject: Re: [tip: perf/core] perf/core: Convert snprintf() to scnprintf()
Message-ID: <20220921125535.GF32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <166374773592.401.16831946846027095231.tip-bot2@tip-bot2>
 <YyrMmyUPk+4t6OLm@hirez.programming.kicks-ass.net>
 <YyrrE8vpFSR+kdHQ@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyrrE8vpFSR+kdHQ@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 12:44:35PM +0200, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, Sep 21, 2022 at 08:08:55AM -0000, tip-bot2 for Jules Irenge wrote:
> > > The following commit has been merged into the perf/core branch of tip:
> > > 
> > > Commit-ID:     678739d622ae7b75b62d550858b6bf104c43e2df
> > > Gitweb:        https://git.kernel.org/tip/678739d622ae7b75b62d550858b6bf104c43e2df
> > > Author:        Jules Irenge <jbi.octave@gmail.com>
> > > AuthorDate:    Sun, 18 Sep 2022 00:41:08 +01:00
> > > Committer:     Ingo Molnar <mingo@kernel.org>
> > > CommitterDate: Wed, 21 Sep 2022 10:01:20 +02:00
> > > 
> > > perf/core: Convert snprintf() to scnprintf()
> > > 
> > > Coccinelle reports a warning:
> > > 
> > >     WARNING: use scnprintf or sprintf
> > > 
> > > Adding to that, there has also been some slow migration from snprintf to scnprintf.
> > > 
> > > This LWN article explains the rationale for this change:
> > > 
> > >     https: //lwn.net/Articles/69419/
> > > 
> > > No change in behavior.
> > > 
> > > [ mingo: Improved the changelog. ]
> > 
> > And yet, at this point I still have no clue what's wrong with
> > snprintf(). So not much improvement :/
> 
> I've added this to the changelog:
> 
>     perf/core: Convert snprintf() to scnprintf()

I'm not sure if it would apply in this case as it's for a device
attribute, but there's another helper sysfs_emit that does the safe
print to string and one does not have to care which flavor of s*printf
it is. We had patches in btrfs converting from snprintf to scnprintf and
the latest one is sysfs_emit which is convenient to use but assumes the
PAGE_SIZE of the buffer.
