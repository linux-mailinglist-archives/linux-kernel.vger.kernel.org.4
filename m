Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FEF6AF8F4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCGWgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjCGWfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:35:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72C7B2570;
        Tue,  7 Mar 2023 14:34:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 434BF21A19;
        Tue,  7 Mar 2023 22:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678228438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MX+2KpqT8wrCqyg7j0dP+wq52LnT6AyIVkSxEYwnFa8=;
        b=SSBWxDam7wOMnt7TF0pQLTpDz6cVUcjH4zfaXE84D6yczhNPEpnCNC2Uw3+ivHmi6wGK92
        3xIFlD7ccw6c+bztZE+fbhx79TxDDLGCQW4LdhH1hjNIUR5syrqiZ9J45Q2IS6u8kxMUDz
        mOeVX8CZxtJ+1IFKqxGOkoPWugbJHhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678228438;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MX+2KpqT8wrCqyg7j0dP+wq52LnT6AyIVkSxEYwnFa8=;
        b=qnPLRNUlptwMcZkRvHJNVydHAdcCorh/vpKqdZx7AhnBbWklvsD0c6RYBynY7oBv+9TzC6
        lzcRhv6HHWRQ8JDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0A7113440;
        Tue,  7 Mar 2023 22:33:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b3I6IdO7B2T3AwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 07 Mar 2023 22:33:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mariusz Tkaczyk" <mariusz.tkaczyk@linux.intel.com>
Cc:     "Song Liu" <song@kernel.org>,
        "Linux regressions mailing list" <regressions@lists.linux.dev>,
        Jes.Sorensen@gmail.com, "linux-raid" <linux-raid@vger.kernel.org>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Nikolay Kichukov" <hijacker@oldum.net>
Subject: Re: [regression] Bug 217074 - upgrading to kernel 6.1.12 from 5.15.x
 can no longer assemble software raid0
In-reply-to: <20230307095258.00001cb3@linux.intel.com>
References: <a13cd3b5-cc41-bf2f-c8ac-e031ad0d5dd7@leemhuis.info>,
 <CAPhsuW7ZWthh0PZt71hQh1_51C0yMSpOqWYJKc_+VzzTmW_r5A@mail.gmail.com>,
 <167805126796.8008.3635368722810568057@noble.neil.brown.name>,
 <20230307095258.00001cb3@linux.intel.com>
Date:   Wed, 08 Mar 2023 09:33:52 +1100
Message-id: <167822843274.8008.1142380266687607670@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Mar 2023, Mariusz Tkaczyk wrote:
> On Mon, 06 Mar 2023 08:21:07 +1100
> "NeilBrown" <neilb@suse.de> wrote:
>=20
> > On Sat, 04 Mar 2023, Song Liu wrote:
> > > + Jes.
> > >=20
> > > It appeared to me that we can assemble the array if we have any of the
> > > following:
> > > 1. Enable CONFIG_BLOCK_LEGACY_AUTOLOAD;
> > > 2. Have a valid /etc/mdadm.conf;
> > > 3. Update mdadm to handle this case. (I tried some ugly hacks, which wo=
rked
> > > but weren't clean).
> > >=20
> > > Since we eventually would like to get rid of CONFIG_BLOCK_LEGACY_AUTOLO=
AD, I
> > > think we need mdadm to handle this properly. But the logistics might
> > > be complicated, as
> > > mdadm are shipped separately.
> > >=20
> > > Jes, what do you think about this? AFAICT, we need to update the logic =
in
> > > mdopen.c:create_mddev(). =20
> >=20
> > mdadm already handles this, but only if=20
> >    CREATE names=3Dyes
> > is present in /etc/mdadm.conf
>=20
> Hi,
>=20
> "CREATE names=3Dyes" enforces creation of /dev/md_name arrays instead of
> /dev/mdXXX. It is a large change for users, too aggressive IMO. It will des=
troy
> many setups.
>=20
> To resolve it, we need is to use create_named_array() but respect old naming
> convention. We already have find_free_devnm(), and we are able to keep
> consistency because we can create 'mdXXX':
>=20
> /sys/module/md_mod/parameters # echo md125 > new_array
>=20
> /sys/module/md_mod/parameters # ll /sys/block/md125
> lrwxrwxrwx 1 root root 0 Mar  7 10:54 /sys/block/md125 ->
> ../devices/virtual/block/md125
>=20
> That will require adjustments in mdadm, but I think that we can keep
> names the same way. I created the test for verification of base creation fl=
ows,
> we can use it to avoid regression:
> https://git.kernel.org/pub/scm/utils/mdadm/mdadm.git/tree/tests/00createnam=
es
>=20
> Thoughts?

Yes, that is probably sensible.

It would be nice to have a way to expose the "names=3Dyes" functionality
more obviously.  I think people would generally prefer it (/proc/mdstat
becomes more meaningful) but I agree that forcing it on people is the
the best approach.

Maybe a super-block flag that enables it for that array, and we start
setting that flag when creating new arrays?

NeilBrown


>=20
> BTW. I wanted to get rid of this legacy "create_on_open" from mdadm anyway =
but
> never had time to. If you agree, I can proceed with fixing it.
>=20
> Thanks,
> Mariusz
>=20

