Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A856A6CD87F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjC2Lca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjC2Lc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:32:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230853C24
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:32:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 441EB61CCA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 11:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2502C433D2;
        Wed, 29 Mar 2023 11:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680089544;
        bh=g+bWYP2kmf5ZYSDx4o/Kl40M5wU8ZiJuFCe2pEPBl7Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lxCWixa7cyoadUchVEFh4bWRx33ZF/mDjPz03y8ssHd8QjNZwFWQOuUS44OeJrz0q
         YkHZXQ5xK7cw2bWffeI/PY1XrPPeQI2C8Nv8YbhhRCFW+7DD4dcQzhZCac1vYip4t2
         BgXq1BpLNvmt6pQtRddlJHswU105nExI8g5vxpNCRFxsDdSG/phn6V8oKcAO4Ei+ad
         71AzcO7y1x+t+fqXPXFATi2WkAV4+Cc/epSYi5GzzOWYh8+Up/2EBSqiMZzq9Tyry5
         OfOWFRK0CWOm5Jl60XZKDjIN01KeH9M6mH3p/oYWm8j+Pz2VLwek6FtpkwQmu/9Y0W
         n3E0O0zXnyYxQ==
Message-ID: <6f89f0ac34956e7f527c7efa3d162b4a1f5ea71a.camel@kernel.org>
Subject: Re: 9p caching with cache=loose and cache=fscache
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Date:   Wed, 29 Mar 2023 07:32:22 -0400
In-Reply-To: <2322056.HEUtEhvpMu@silver>
References: <ZA0FEyOtRBvpIXbi@bombadil.infradead.org>
         <ZCMmrnmZFcH65Orp@bombadil.infradead.org> <ZCNlWnQTbWoBBPd2@codewreck.org>
         <2322056.HEUtEhvpMu@silver>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-03-29 at 13:19 +0200, Christian Schoenebeck wrote:
> On Wednesday, March 29, 2023 12:08:26 AM CEST Dominique Martinet wrote:
> > Luis Chamberlain wrote on Tue, Mar 28, 2023 at 10:41:02AM -0700:
> > > >   "To speedup things you can also consider to use e.g. cache=3Dloos=
e instead.
> > >=20
> > > My experience is that cache=3Dloose is totally useless.
> >=20
> > If the fs you mount isn't accessed by the host while the VM is up, and
> > isn't shared with another guest (e.g. "exclusive share"), you'll get
> > what you expect.
> >=20
> > I have no idea what people use qemu's virtfs for but this is apparently
> > common enough that it was recommended before without anyone complaining
> > since that started being recommended in 2011[1] until now?
> >=20
> > [1] https://wiki.qemu.org/index.php?title=3DDocumentation/9psetup&diff=
=3D2178&oldid=3D2177
> >=20
> > (now I'm not arguing it should be recommended, my stance as a 9p
> > maintainer is that the default should be used unless you know what
> > you're doing, so the new code should just remove the 'cache=3Dnone'
> > altogether as that's the default.
> > With the new cache models Eric is preparing comes, we'll get a new safe
> > default that will likely be better than cache=3Dnone, there is no reaso=
n
> > to explicitly recommend the historic safe model as the default has
> > always been on the safe side and we have no plan of changing that.)
>=20
> It's not that I receive a lot of feedback for what people use 9p for, nor=
 am I
> QEMU's 9p maintainer for a long time, but so far contributors cared more =
about
> performance and other issues than propagating changes host -> guest witho=
ut
> reboot/remount/drop_caches. At least they did not care enough to work on
> patches.
>=20
> Personally I also use cache=3Dloose and only need to push changes host->g=
uest
> once in a while.
>=20
> > > >    That will deploy a filesystem cache on guest side and reduces th=
e amount of
> > > >    9p requests to hosts. As a consequence however guest might not s=
ee file
> > > >    changes performed on host side *at* *all*
> > >=20
> > > I think that makes it pretty useless, aren't most setups on the guest=
 read-only?
> > >=20
> > > It is not about "may not see", just won't. For example I modified the
> > > Makefile and compiled a full kernel and even with those series of
> > > changes, the guest *minutes later* never saw any updates.
> >=20
> > read-only on the guest has nothing to do with it, nor has time.
> >=20
> > If the directory is never accessed on the guest before the kernel has
> > been built, you'll be able to make install on the guest -- once, even i=
f
> > the build was done after the VM booted and fs mounted.
> >=20
> > After it's been read once, it'll stay in cache until memory pressure (o=
r
> > an admin action like umount/mount or sysctl vm.drop_caches=3D3) clears =
it.
> >=20
> > I believe that's why it appeared to work until you noticed the issue an=
d
> > had to change the mount option -- I'd expect in most case you'll run
> > make install once and reboot/kexec into the new kernel.
> >=20
> > It's not safe for your usecase and cache=3Dnone definitely sounds bette=
r
> > to me, but people should use defaults make their own informed decision.
>=20
> It appears to me that read-only seems not to be the average use case for =
9p,
> at least from the command lines I received. It is often used in combinati=
on
> with overlayfs though.
>=20
> I (think) the reason why cache=3Dloose was recommended as default option =
on the
> QEMU wiki page ages ago, was because of its really poor performance at th=
at
> point. I would personally not go that far and discourage people from usin=
g
> cache=3Dloose in general, as long as they get informed about the conseque=
nces.
> You still get a great deal of performance boost, the rest is for each
> individual to decide.
>=20
> Considering that Eric already has patches for revalidating the cache in t=
he
> works, I think the changes I made on the other QEMU wiki page are appropr=
iate,
> including the word "might" as it's soon only a matter of kernel version.
>=20
> > > >   In the above example the folder /home/guest/9p_setup/ shared of t=
he
> > > >   host is shared with the folder /tmp/shared on the guest. We use n=
o
> > > >   cache because current caching mechanisms need more work and the
> > > >   results are not what you would expect."
> > >=20
> > > I got a wiki account now and I was the one who had clarified this.
> >=20
> > Thanks for helping making this clearer.
>=20
> Yep, and thanks for making a wiki account and improving the content there
> directly. Always appreciated!
>=20

Catching up on this thread.

Getting cache coherency right on a network filesystem is quite
difficult. It's always a balance between correctness and performance.

Some protocols (e.g. CIFS and Ceph) take a very heavy-handed approach to
try ensure that the caches are always coherent. Basically, these clients
are only allowed to cache when the server grants permission for it. That
can have a negative effect on performance, of course.

NFS as a protocol is more "loose", but we've generally beat its cache
coherency mechanisms into shape over the years, so you don't see these
sorts of problems there as much. FWIW, NFS uses a sliding time window to
revalidate the cache, such that it'll revalidate frequently when an
inodes is changing frequently, but less so when it's more stable.

9P I haven't worked with as much, but it sounds like it doesn't try to
keep caches coherent (at least not with cache=3Dloose).

Probably the simplest solution here is to simply unmount/mount before
you have the clients call "make modules_install && make install". That
should ensure that the client doesn't have any stale data in the cache=20
when the time comes to do the reads. A full reboot shouldn't be
required.

--=20
Jeff Layton <jlayton@kernel.org>
