Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D82C6169E2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiKBQ73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiKBQ70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:59:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36248BC24
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:59:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C8247229BE;
        Wed,  2 Nov 2022 16:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667408363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ah+k1HHHyy0taWg599acxl3PDtcC8v9M4mgXqN3XA0=;
        b=fKQs0AHxKdE+or9pFOABc0yBQnpBBJfDIvfYJFv/pm3Y28tCFjUz18A7v35WTcjRLdpmpW
        TzRfwLGA05WSbCMPlncbJX3pcq8GRTdeyxGeNYMcP4Sy2OUyVY+CodcD40H5jik5FFWROe
        IjA3JVkTfxxq44x7GhoXLbvrsOGwl30=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 899DC13AE0;
        Wed,  2 Nov 2022 16:59:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id i3rIIOuhYmMZMwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 02 Nov 2022 16:59:23 +0000
Date:   Wed, 2 Nov 2022 17:59:22 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: async unthrottling for cfs bandwidth
Message-ID: <20221102165922.GA31833@blackbody.suse.cz>
References: <20221026224449.214839-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <20221026224449.214839-1-joshdon@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Wed, Oct 26, 2022 at 03:44:49PM -0700, Josh Don <joshdon@google.com> wrote:
> To fix this, we can instead unthrottle cfs_rq's asynchronously via a
> CSD. Each cpu is responsible for unthrottling itself, thus sharding the
> total work more fairly across the system, and avoiding hard lockups.

FIFO behavior of the cfs_b->throttled_cfs_rq is quite important to
ensure fairness of throttling (historically when it FIFO wasn't honored,
it caused some cfs_rq starving issues).

Despite its name, distribute_cfs_runtime() doesn't distribute the
runtime, the time is pulled inside assign_cfs_rq_runtime() (but that's
already on target cpu).
Currently, it's all synchronized under cfs_b->lock but with your change,
throttled cfs_rq would be dissolved among cpus that'd run concurrently
(assign_cfs_rq_runtime() still takes cfs_b->lock but it won't be
necessarily in the unthrottling order).

Have you observed any such fairness issues? [1][2]

> +static inline void __unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
> [...]
> +	if (rq == this_rq()) {
> +		unthrottle_cfs_rq(cfs_rq);
> +		return;
> +	}

It was pointed out to me that generic_exec_single() does something
similar.
Wouldn't the flow bandwidth control code be simpler relying on that?

Also, can a particular cfs_rq be on both cfs_b->throttled_csd_list and
cfs_b->throttled_cfs_rq lists at any moment?
I wonder if having a single list_head node in cfs_rq would be feasible
(and hence enforcing this constraint in data).

Regards,
Michal


[1] I'm not familiar with IPIs, just to illustrate the concurrency: the
    fairness could be skewed towards CPUs that are on same "NUMA" node
    as the timer callback if closer CPUs received them sooner.

[2] Currently, I don't think it's a prohibitive issue because with my
    reasoning even the current code relies on cfs_b->lock being a queued
    spinlock to ensure the FIFO of cfs_b->throttled_cfs_rq.

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY2Kh6AAKCRAkDQmsBEOq
ufLnAP0QHQBHrtHpOiTgDOBuoI7CM5OCYYXbU2JiLoWaA3qT9gD/aU2v2wLlgHsB
wh4R8oXsEXhhmcSKxJvxgGp7izuQcwA=
=4UKU
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
