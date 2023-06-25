Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894EE73D1EF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjFYQCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjFYQCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:02:40 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8A7F3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:02:38 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 020725C004D;
        Sun, 25 Jun 2023 12:02:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 25 Jun 2023 12:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1687708954; x=1687795354; bh=wMcppq5HZO253j+hyCAKfHs6I2/WnmUX/Zy
        15bchwPI=; b=WXIUvR94NwwBVEpbCv4bzPfUVlxpmshpV5YIa38BBBGWmkytgHm
        ny/x28OJawbgrwTz3iYu2it9WM62s4xCoJlsM/XIJBYxGue0lxOUw+oLFZFouiYF
        2N35r61q6tuP2uhSqbsIRXnse58EAO/PUs5Dc7GJ0Y8WbyV/tTdDaa7JSNZT8Vv5
        Tf0WKm3wK0GpLZy4S4zsgnEU5mnQ10B7gI1KF1WBkXcUJrvwvjtqiYPfdJQiFtaz
        5zhhSn+53EVWJ3EDxjt1X47Xj7HOVOQaL6Rv4GgdgoP5fs4OsFynB0O7m32kP9kG
        VYKDnUhvI4IaFh8P3yFGoQR8KaVj/HsnrDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687708954; x=1687795354; bh=wMcppq5HZO253
        j+hyCAKfHs6I2/WnmUX/Zy15bchwPI=; b=ArxSAcgUovlGAMkkQ/nJWNYomxffw
        yuSLrqLCuf1C7CXjqgO1M3YQuX0bxMxtPwDN8WXsWJ17O3RkYR4uFk+K3rd206wk
        QcYPiregtKDam+JKnWf0nNro0WYKiK38GAODimbOzKsT7mdqFRPEmxhUV5ryT1vr
        IMvl3x54h5hwfB/69R9RnwTTCyNX8vAcWJc5Mro1UkuuvoPxOzbQdoflmmZorGGg
        mP771jxc2wOJBPOmm8a0RBgh4XtNLxYVwtJGon3D2imV/ShU/Py80BP968Y9aBoE
        41jUWh50XUjfKxisNMr8BwyXtRd5u/OCdVURR7RGqji13VUQjm1J054Xg==
X-ME-Sender: <xms:GmWYZCWULat7KGgHa9IGw3o2z9gjYO6m9KFhaTxo3UmkBlz7ui9v3Q>
    <xme:GmWYZOltk8WCQsaWYJKCyM9iUhcu25Y2Dt0tdIbFYkR55aK4NHUfulse1IPtHz4iM
    dlVjU87nBuPDB4>
X-ME-Received: <xmr:GmWYZGZ6sezKSwfCF7ii-CoEROzhqpto0Yw_FF0erL9EC4XS1LOozXTzTYY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehtddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepudeileefueetvdelheeuteffjeeg
    jeegffekleevueelueekjeejudffteejkeetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:GmWYZJUtdMriWx5-doxidGy8_e5aq4_oWvfGy607Fixosd5vWtIXzw>
    <xmx:GmWYZMkKCwye8fpzP8AYM6piKu_OJe2FanRFchrWxPWdbxcxwlTTsg>
    <xmx:GmWYZOfJlszZ6h6wuIk03eeG4EGzSjjacJUcL9kU3CYfIenkw2H0GQ>
    <xmx:GmWYZBxI94sNwxDxIAHyzrxXxR-Z7RbRNUkwFIXhYSg90U8zHDf-cg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Jun 2023 12:02:34 -0400 (EDT)
Date:   Sun, 25 Jun 2023 12:02:29 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Milan Broz <gmazyland@gmail.com>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] [PATCH v2 3/4] dm ioctl: Allow userspace to suppress
 uevent generation
Message-ID: <ZJhlGCP0gTz7T3gG@itl-email>
References: <20230624230950.2272-1-demi@invisiblethingslab.com>
 <20230624230950.2272-4-demi@invisiblethingslab.com>
 <0b22e328-40e1-54d7-367c-96059a3fef7c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LLikrifq3elm0+u6"
Content-Disposition: inline
In-Reply-To: <0b22e328-40e1-54d7-367c-96059a3fef7c@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LLikrifq3elm0+u6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Jun 2023 12:02:29 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Milan Broz <gmazyland@gmail.com>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] [PATCH v2 3/4] dm ioctl: Allow userspace to suppress
 uevent generation

On Sun, Jun 25, 2023 at 03:25:38PM +0200, Milan Broz wrote:
> On 6/25/23 01:09, Demi Marie Obenour wrote:
> > Userspace can use this to avoid spamming udev with events that udev
> > should ignore.
>=20
> Well, does it also mean that udev will not create /dev/disk/by-* symlinks
> (as response to the change udev event followed by internal udev blkid sca=
n)?

In the use-case I have for this feature (block devices for Qubes VMs)
the blkid scan is unwanted and there are udev rules to prevent this.

> If it is a private device, that is ok. But for a visible device I think
> that it breaks some assumptions in userspace (presence of symlinks mentio=
ned
> above etc).

The devices I am considering are implementation details of a userspace
process.  Nobody else should be opening them.  Ideally, no other
userspace process would even know they exist, at least without mucking
around in /proc or using ptrace.

> So, what is the exact use for this patch?

Ephemeral devices that are created, opened, marked for deferred removal,
assigned to a Xen VM (needs another patch currently being worked on),
and then closed.  udev has no business scanning these devices, and
indeed for it to scan them at all would be a security vulnerability
since their contents are under guest control.  There are udev rules to
ignore these devices, but for udev to even process the event wastes CPU
time and delays processing of other events that actually matter.  The
only symlink that possibly ought to be created is /dev/disk/by-diskseq
and I can just do that myself.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--LLikrifq3elm0+u6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmSYZRgACgkQsoi1X/+c
IsHJyA/+IJjlQ3TEADPdYhQeK6IxVs0Ggy0keFLY6+r4jHI5FM3SJ99om+Iu8WkN
jQ2iQ24VyeO3lu3J6Y5GkpkJ6qLvfY0HpqgN6+2TKQoOgXyYuvGRODoFPpB/xA41
jtPTIGtZF+U9AdweW9p0W63z3tTf9v9tDVFB0XF8F0Bp3/cWdSrS6BbhC9BFCqke
0c5JNsz+OVSx0C7VJ+SYEWZ6Va/DM9tybZpygumsyu3ZKZjyFdyL23x1e0HYKZis
rAr39c2ntv0VtwGmDFly6oWLzdhtkDXahJ7DvQKt4cpslDfrwMjgLNpvbRj49RO3
LcJWNpoXm9vNfzIr/p2T3NUajczXCmygE5OvIi5286tOjU/LdE9b2Fgjhpbsh6+3
leOU3ntYPrW9brLPExg5PaJTa6q4ZGr8YiOfv40lOlaHjG6I9QcaPEBVBBJ3QQ5L
VTc0XPyzMJxKLSNsM5jqxgtKt+uFhqNqkGwKemIvabOjWaLwZAYj+TpJU4HNFdaw
BldSECUfgCagcYsSFpvwcTMTdV48bdlN4hJUXxPBlVcJ93TldBop95mp/mjLMeAr
hiQvd9MCHKJpRRZwTO214eFYejYVEntxYYrk6nfWRz8lmrWiTS+hFE+4bXZ0MdJY
bV4yGsUBfTpS1PM4dHMxmF3sELoKTjo6ssSHhqfeyi2DMxgOmdo=
=1n/o
-----END PGP SIGNATURE-----

--LLikrifq3elm0+u6--
