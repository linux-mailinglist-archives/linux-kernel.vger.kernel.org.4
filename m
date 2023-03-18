Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399D86BF8DC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 09:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjCRIJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 04:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCRIJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 04:09:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307EE18B39
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 01:08:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D62701FE56;
        Sat, 18 Mar 2023 08:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679126937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tUccHJYRpgH4e/3wFNqwUj50i3i9i3teajxIX8WxbAA=;
        b=ADNw4VxB5SAx+7vXXMK9Pyn6geo/Baw2FyCWsBVkdye1eHYkKaOohrvkLFRWz+NWOsVsIx
        Jg1RdrHmczlApVXMI07rOInCDqIBCcCrGhR397FWDwomvZt8OVCcoJRSpLNSNpN9osxUgx
        407Ilmq2k4L3fyLY2Y/EAiffkPEqR+w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B71B013A00;
        Sat, 18 Mar 2023 08:08:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mxBfKplxFWQUOwAAMHmgww
        (envelope-from <mhocko@suse.com>); Sat, 18 Mar 2023 08:08:57 +0000
Date:   Sat, 18 Mar 2023 09:08:57 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras <leobras@redhat.com>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 2/2] memcg: do not drain charge pcp caches on remote
 isolated cpus
Message-ID: <ZBVxmV78EyfDhvn/@dhcp22.suse.cz>
References: <20230317134448.11082-1-mhocko@kernel.org>
 <20230318032350.2078-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230318032350.2078-1-hdanton@sina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 18-03-23 11:23:50, Hillf Danton wrote:
> On 17 Mar 2023 14:44:48 +0100 Michal Hocko <mhocko@suse.com>
> > Leonardo Bras has noticed that pcp charge cache draining might be
> > disruptive on workloads relying on 'isolated cpus', a feature commonly
> > used on workloads that are sensitive to interruption and context
> > switching such as vRAN and Industrial Control Systems.
> > 
> > There are essentially two ways how to approach the issue. We can either
> > allow the pcp cache to be drained on a different rather than a local cpu
> > or avoid remote flushing on isolated cpus.
> > 
> > The current pcp charge cache is really optimized for high performance
> > and it always relies to stick with its cpu. That means it only requires
> > local_lock (preempt_disable on !RT) and draining is handed over to pcp
> > WQ to drain locally again.
> > 
> > The former solution (remote draining) would require to add an additional
> > locking to prevent local charges from racing with the draining. This
> > adds an atomic operation to otherwise simple arithmetic fast path in the
> > try_charge path. Another concern is that the remote draining can cause a
> > lock contention for the isolated workloads and therefore interfere with
> > it indirectly via user space interfaces.
> > 
> > Another option is to avoid draining scheduling on isolated cpus
> > altogether. That means that those remote cpus would keep their charges
> > even after drain_all_stock returns. This is certainly not optimal either
> > but it shouldn't really cause any major problems. In the worst case
> > (many isolated cpus with charges - each of them with MEMCG_CHARGE_BATCH
> > i.e 64 page) the memory consumption of a memcg would be artificially
> > higher than can be immediately used from other cpus.
> > 
> > Theoretically a memcg OOM killer could be triggered pre-maturely.
> > Currently it is not really clear whether this is a practical problem
> > though. Tight memcg limit would be really counter productive to cpu
> > isolated workloads pretty much by definition because any memory
> > reclaimed induced by memcg limit could break user space timing
> > expectations as those usually expect execution in the userspace most of
> > the time.
> > 
> > Also charges could be left behind on memcg removal. Any future charge on
> > those isolated cpus will drain that pcp cache so this won't be a
> > permanent leak.
> > 
> > Considering cons and pros of both approaches this patch is implementing
> > the second option and simply do not schedule remote draining if the
> > target cpu is isolated. This solution is much more simpler. It doesn't
> > add any new locking and it is more more predictable from the user space
> > POV. Should the pre-mature memcg OOM become a real life problem, we can
> > revisit this decision.
> 
> JFYI feel free to take a look at the non-housekeeping CPUs [1].
> 
> [1] https://lore.kernel.org/lkml/20230223150624.GA29739@lst.de/

Such an approach would require remote draining and I hope I have
explained why that is not a preferred way in this case. Other than that
I do agree with Christoph that a generic approach would be really nice.

-- 
Michal Hocko
SUSE Labs
