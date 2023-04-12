Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26EC6DF7AC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjDLNuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjDLNuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:50:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA381705
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:50:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C185563557
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F09C4339B;
        Wed, 12 Apr 2023 13:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681307406;
        bh=d697myxGSMJrs0cYzQKYhNiKu5vdRz1Wz5siV1nSnso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ontkxAZvHVytSkZNIN+YM5FRNn6R+X4cYx0X6UCqwa6+fw69SADfidxVgJ0eLU172
         NEODlNMeKgtjHslGeelGIRdJkZb944Fp9Xp8sZjBEz3Z+DEvKkre4GxXcb0SQQ7/Ic
         7h1duizmRldqOpNb8fVqFnEBBIEkbt9twF0vppTqVvov7M3cgRbHvVLxerUUpx/S5o
         uw27NKO4NvWw500yaA4fQozVJEmJUWB8r5oxuJmnd0T28V13tIeI85o5SbPpfmWgXT
         2TiIw8p0nab97xH47C72ucO41qxhujGvxr2hWTVVsuPWAcZ9RF6+czvb4lDNefOU/1
         XsUp5+3IbeSSA==
Date:   Wed, 12 Apr 2023 14:50:01 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org, Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v2 1/3] cacheinfo: Check sib_leaf in
 cache_leaves_are_shared()
Message-ID: <20230412-catalyze-putt-4a0d48042e4f@spud>
References: <20230412071809.12670-1-pierre.gondois@arm.com>
 <20230412071809.12670-2-pierre.gondois@arm.com>
 <20230412-viewpoint-refutable-a31f3657093c@wendy>
 <d7a36615-896b-0f13-a1f6-761715ce460f@arm.com>
 <20230412-hut-unused-21d683fcb8b0@wendy>
 <b87130ba-b3c2-825c-0e2c-634e8aee8d5c@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="31Nhce6gARzTUXUy"
Content-Disposition: inline
In-Reply-To: <b87130ba-b3c2-825c-0e2c-634e8aee8d5c@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--31Nhce6gARzTUXUy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2023 at 03:20:19PM +0200, Pierre Gondois wrote:
> > On Wed, Apr 12, 2023 at 02:34:11PM +0200, Pierre Gondois wrote:

> > Another silly question:
> > For two caches of level M & N; M !=3D N; M, N > 1 should they be detect=
ed
> > as shared in the absence of any information in DT/ACPI?
> > The comment (to me) reads as if they should not, but it is rather vague.
>=20
> I think they should. The naming of cache_leaves_are_shared() might be
> misleading. The function is more trying to find out if 2 cache leaves str=
uct
> are representing the same cache. So maybe renaming the function to
> cache_leaves_identical() might be better?

Nah, I don't think this is really the fault of anything other than the
!DT && !ACPI situation.
I'm just trying to make sure I understand the intended behaviour in that
scenario, that's all.

> If there is no DT/ACPI, it is not possible to identify whether 2 cache le=
aves
> are representing the same cache. The desired behaviour is just:
> - If this_leaf or sib_leaf is a L1 cache, then the caches are not identic=
al
>   (or shared if we use this wording)

> So the meaning of cache_leaves_identical() is a bit bent for this
> configuration.

Fair enough.

--31Nhce6gARzTUXUy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDa3BgAKCRB4tDGHoIJi
0vrcAQCW6Qv7JEnbOaLRCie9bWqvTjhTS9wIpR4saBeeRVODrAEA8WU4D22dkSnN
K5Zhe/I9KdRpdhwCHiO1hBJaBHUdago=
=7IKn
-----END PGP SIGNATURE-----

--31Nhce6gARzTUXUy--
