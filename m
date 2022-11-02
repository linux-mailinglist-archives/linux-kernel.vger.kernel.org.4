Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25D6616A2A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiKBRLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiKBRKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:10:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281F41CB1C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 10:10:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D2F7921D91;
        Wed,  2 Nov 2022 17:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667409050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CN7rpKi1JV2qkEsMCHV68X0g7v+Lhbb9nJKm2oiwPZU=;
        b=mAQp1ZgQJP0vX2tskn5KkVkJOI670pTg2w8TneMpJRXk8RExrcPyoSo+KGEFf1FcdmETE/
        iVExAu+9vD44Rfo6/z2wnOzsXrUFPjqpjPG4u+jqHvz2okPQfidpFwDNBFz10cukhrlzQR
        CMGQZp4gum5CS/Cm3JqrEcLCwGdTouw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83D7113AE0;
        Wed,  2 Nov 2022 17:10:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +vY3H5qkYmN1OAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 02 Nov 2022 17:10:50 +0000
Date:   Wed, 2 Nov 2022 18:10:49 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Josh Don <joshdon@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH v2] sched: async unthrottling for cfs bandwidth
Message-ID: <20221102171049.GC10591@blackbody.suse.cz>
References: <CABk29Nta-RJpTcybgOk9u4DH=1mwQFZsOxFuQ-UpCcTwzjzAuA@mail.gmail.com>
 <Y2Bf+CeQ8x2jKQ3S@slm.duckdns.org>
 <CABk29Nvqv-T1JuAq2cf9=AwRu=y1+YOR4xS2qnVo6+XpWd2UNQ@mail.gmail.com>
 <Y2B6V1PPuCcTXGp6@slm.duckdns.org>
 <CABk29Ns1VWEVRYENud4CW3JQPrcr79i_F2PBTANqt3t-LaYCfQ@mail.gmail.com>
 <Y2FwVX42LIKXSTz3@slm.duckdns.org>
 <CABk29Nua8ZsDfhY+x+VfYDkbkjfXLXTZ5JMVR9uiBygraxDM+g@mail.gmail.com>
 <Y2GUg8CiI68ZBznr@slm.duckdns.org>
 <CABk29Nvj8nRyD0HGo+gZ4CEr0kOJSsUbJnSNFs62D66EDTMGog@mail.gmail.com>
 <Y2Gf3zxJqxRnkVyf@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline
In-Reply-To: <Y2Gf3zxJqxRnkVyf@slm.duckdns.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 01, 2022 at 12:38:23PM -1000, Tejun Heo <tj@kernel.org> wrote:
> (cc'ing Michal, Christian and Li for context)

Thanks.

> > We're in the process of transitioning to using bw instead for this
> > instead in order to maintain parallelism. Fixing bw is definitely
> > going to be useful, but I'm afraid we'll still likely have some issues
> > from low throughput for non-bw reasons (some of which we can't
> > directly control, since arbitrary jobs can spin up and configure their
> > hierarchy/threads in antagonistic ways, in effect pushing out the
> > latency of some of their threads).
>=20
> Yeah, thanks for the explanation. Making the lock more granular is tedious
> but definitely doable. I don't think I can work on it in the near future =
but
> will keep it on mind. If anyone's interested in attacking it, please be my
> guest.

=46rom my experience, throttling while holding kernel locks (not just
cgroup_mutex) causes more trouble than plain cgroup_mutex scalability
currently.
But I acknowledge the latter issue too.

Michal

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY2KklwAKCRAkDQmsBEOq
uZ9JAP4z/W1MGdhX6ZkuGKjgkWAmGksEpsGwm6hcT3ngQNH4PgEAm4jQZq/iaK4d
P42yKxWJy4D0SNDA9w+Dx+N0GFXf6ww=
=aZnM
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
