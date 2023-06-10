Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6989672AA6A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 10:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbjFJIzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 04:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjFJIzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 04:55:14 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9385330E3;
        Sat, 10 Jun 2023 01:55:13 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9DD0D1C0CA9; Sat, 10 Jun 2023 10:55:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1686387310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fkm5qwxwe9fln5h9oPWp4yMlD7nPCs7k/Txnjnk41WU=;
        b=DeoLFL/sl/3SPQcXuTf8HXXpcy7lxOARUSJkFj7KyDlAynpey9mgfgupFL8XlwA10055Q8
        VlW8tXT+gKLohdvW5f1JWl7JHqmr/wHRs2KKwpHbucWQ7dh66Ov6ZfBHKFKese8CaYFGkD
        1Xu1AZ14f7/w96kY49IE4RK4MY+r3pc=
Date:   Sat, 10 Jun 2023 10:55:10 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Joe Breuer <linux-kernel@jmbreuer.net>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Hardening <linux-hardening@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux SCSI <linux-scsi@vger.kernel.org>, bvanassche@acm.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Hannes Reinecke <hare@suse.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: Re: Fwd: Waking up from resume locks up on sr device
Message-ID: <ZIQ6bkau3j6qGef8@duo.ucw.cz>
References: <2d1fdf6d-682c-a18d-2260-5c5ee7097f7d@gmail.com>
 <5513e29d-955a-f795-21d6-ec02a2e2e128@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="I/HvBl+QkV4d0FVN"
Content-Disposition: inline
In-Reply-To: <5513e29d-955a-f795-21d6-ec02a2e2e128@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--I/HvBl+QkV4d0FVN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> > #regzbot introduced: v5.0..v6.4-rc5 https://bugzilla.kernel.org/show_bu=
g.cgi?id=3D217530
> > #regzbot title: Waking up from resume locks up on SCSI CD/DVD drive
> >=20
>=20
> The reporter had found the culprit (via bisection), so:
>=20
> #regzbot introduced: a19a93e4c6a98c

Maybe cc the authors of that commit?

commit a19a93e4c6a98c9c0f2f5a6db76846f10d7d1f85
Author: Bart Van Assche <bvanassche@acm.org>
Date:   Wed Oct 6 14:54:51 2021 -0700

    scsi: core: pm: Rely on the device driver core for async power manageme=
nt
   =20
    Instead of implementing asynchronous resume support in the SCSI core, r=
ely
    on the device driver core for resuming SCSI devices asynchronously.
    Instead of only supporting asynchronous resumes, also support asynchron=
ous
    suspends.
   =20
    Link: https://lore.kernel.org/r/20211006215453.3318929-2-bvanassche@acm=
=2Eorg
    Cc: Alan Stern <stern@rowland.harvard.edu>
    Cc: Dan Williams <dan.j.williams@intel.com>
    Cc: Hannes Reinecke <hare@suse.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Martin Kepplinger <martin.kepplinger@puri.sm>
    Signed-off-by: Bart Van Assche <bvanassche@acm.org>
    Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

BR,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--I/HvBl+QkV4d0FVN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZIQ6bgAKCRAw5/Bqldv6
8uDkAJ4o3Rr/XgvkbOUJb4DTlUhFwVkDBwCgkbeZzuwepUmQqeVAJgfAcJNTAyE=
=f92w
-----END PGP SIGNATURE-----

--I/HvBl+QkV4d0FVN--
