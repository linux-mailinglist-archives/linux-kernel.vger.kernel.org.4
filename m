Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401546AD1AF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCFWfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCFWfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:35:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9927D2D56;
        Mon,  6 Mar 2023 14:35:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 405FE21A4B;
        Mon,  6 Mar 2023 22:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678142107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4CnI7z+MNChd5BPK0qQbVcdiTxmqCnVztBhXbgFMk6w=;
        b=zYl9ahF2kFJNefvIQCkPOvNsCIP6Hepv9MCS4qySWngEB6VDAbO1TOQ5qaA3x6joQogoBi
        b2ebElKQSsKPR1zOMo6Sy1f//kkCrduhNyyvpBckhKJqWW8RCe4Aqpsq/4VHnhWpjy1FiM
        bevbVUwWe8HjUuZiRJLL/Cx2FO7hq+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678142107;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4CnI7z+MNChd5BPK0qQbVcdiTxmqCnVztBhXbgFMk6w=;
        b=Xk7J+ybSrP/MqD1XmOP6lx+Lz/UTWIliEMjg6GQcRpapZYkDE7BKvK4/TUg7RawawTEUvK
        Acj+75iBOhIhsTAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32E9513513;
        Mon,  6 Mar 2023 22:35:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fnbeNphqBmSACgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 06 Mar 2023 22:35:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Song Liu" <song@kernel.org>
Cc:     "Linux regressions mailing list" <regressions@lists.linux.dev>,
        Jes.Sorensen@gmail.com, "linux-raid" <linux-raid@vger.kernel.org>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Nikolay Kichukov" <hijacker@oldum.net>
Subject: Re: [regression] Bug 217074 - upgrading to kernel 6.1.12 from 5.15.x
 can no longer assemble software raid0
In-reply-to: <CAPhsuW64R2ze1AYZhEmQcGf0cKBjjX=4EZZowD+=Cr=VPg1QYg@mail.gmail.com>
References: <a13cd3b5-cc41-bf2f-c8ac-e031ad0d5dd7@leemhuis.info>,
 <CAPhsuW7ZWthh0PZt71hQh1_51C0yMSpOqWYJKc_+VzzTmW_r5A@mail.gmail.com>,
 <167805126796.8008.3635368722810568057@noble.neil.brown.name>,
 <CAPhsuW64R2ze1AYZhEmQcGf0cKBjjX=4EZZowD+=Cr=VPg1QYg@mail.gmail.com>
Date:   Tue, 07 Mar 2023 09:35:01 +1100
Message-id: <167814210165.8008.4497120634222267375@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Mar 2023, Song Liu wrote:
> On Sun, Mar 5, 2023 at 1:21=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
> >
> > On Sat, 04 Mar 2023, Song Liu wrote:
> > > + Jes.
> > >
> > > It appeared to me that we can assemble the array if we have any of the
> > > following:
> > > 1. Enable CONFIG_BLOCK_LEGACY_AUTOLOAD;
> > > 2. Have a valid /etc/mdadm.conf;
> > > 3. Update mdadm to handle this case. (I tried some ugly hacks, which wo=
rked but
> > >     weren't clean).
> > >
> > > Since we eventually would like to get rid of CONFIG_BLOCK_LEGACY_AUTOLO=
AD, I
> > > think we need mdadm to handle this properly. But the logistics might
> > > be complicated, as
> > > mdadm are shipped separately.
> > >
> > > Jes, what do you think about this? AFAICT, we need to update the logic =
in
> > > mdopen.c:create_mddev().
> >
> > mdadm already handles this, but only if
> >    CREATE names=3Dyes
> > is present in /etc/mdadm.conf
> >
> > Maybe we should flip the default for the next mdadm release, and patch
> > the kernel (with a stable backport) to select BLOCK_LEGACY_AUTOLOAD if
> > BLK_DEV_MD=3Dm
> > Then revert that - say - 6 months after the new mdadm is released.
>=20
> I like this idea. I guess we also need to select BLOCK_LEGACY_AUTOLOAD
> if BLK_DEV_MD=3Dy?

Yes of course - sorry.

Something like the following.

Thanks,
NeilBrown


From: NeilBrown <neilb@suse.de>
Subject: md: select BLOCK_LEGACY_AUTOLOAD

When BLOCK_LEGACY_AUTOLOAD is not enable, mdadm is not able to
activate new arrays unless "CREATE names=3Dyes" appears in
mdadm.conf

As this is a regression we need to always enable BLOCK_LEGACY_AUTOLOAD
for when MD is selected - at least until mdadm is updated and the
updates widely available.

Fixes: fbdee71bb5d8 ("block: deprecate autoloading based on dev_t")
Signed-off-by: NeilBrown <neilb@suse.de>

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 998a5cfdbc4e..662d219c39bf 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -16,6 +16,10 @@ if MD

 config BLK_DEV_MD
 	tristate "RAID support"
 	select BLOCK_HOLDER_DEPRECATED if SYSFS
+	# BLOCK_LEGACY_AUTOLOAD requirement should be removed
+	# after relevant mdadm enhancements - to make "names=3Dyes"
+	# the default - are widely available.
+	select BLOCK_LEGACY_AUTOLOAD
 	help
 	  This driver lets you combine several hard disk partitions into one
 	  logical block device. This can be used to simply append one


