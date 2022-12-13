Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FADD64BCBB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 20:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbiLMTIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 14:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236732AbiLMTI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:08:27 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F4CAE4A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:08:26 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id o5so16771125wrm.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjKfdDb3dVQRH9QGdWarHpg6fVpjYIE5/rutlklzFVs=;
        b=TiMmwIq8t9p+8QDga/zHafLkMg5TTfJhsoErhJkYVIAhGrGqEBuCtBCIOtYAuvRzKc
         Yy9XuTgtYN2I5mPy9ZgOobjRCvXp33MhPFBr6mmUz9Y2wesKI/idSrJV1JIJjg/xN8m6
         XYOVDxhbqZMaOkUbZNiVRMHJrB7zZoalQ8TyaCiSGsjLwc918dQWfZzourPty/HDczfo
         yGMDfKpeuAW8WtZwEBUiZPSAr+c4Fov9YNa4EPhhKzs3VzRq9X9cw8KlbtfqHu5Y3Fsd
         FrDROZ+wwQrqu0tV1G+5+EXEWfrkvsQB1GvcHZCLIvIMS0esR+kfnUVnrQMxydt5esF0
         cZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjKfdDb3dVQRH9QGdWarHpg6fVpjYIE5/rutlklzFVs=;
        b=gWPC+u4pD+c21CXhlnk3/Amv9VUkESx8q8YLE1DCwImFI96eONesUtFNqNwRjr+/66
         B4RrVEZrug10chaAA5FGX5JcV6wUbgunpan3TOqAP2+IndMcoEfgAyUAPQCP3egkNmmH
         tXumB2o5gSWeBE9dRc9xJAOA8oR2Q0IQJjN0b7F+xS7DaRzhyy/DJy2DoYweSNCrKO4+
         0S8cxFVKfXdxH9pNTxM+Aj+m3rqsFDRUkimE5xcLBgXMl7ZFkVzdMO5IcX/weNvbw1HT
         VHdpIIzMu/rJKPgeu+feDt0aNrUiEofL4+pnkHDLJ94f060AUJp9/2SGS2H0f//BGS75
         9Zkg==
X-Gm-Message-State: ANoB5plft83zkqJK6yeJKUh+IPTkm9Ej8vHIJDvJHzK4br54A4QvDH94
        O9Nph9wdqnRC7AAFvVfrf11s/VafMrM=
X-Google-Smtp-Source: AA0mqf5Zj6XTySCH1eEWM+Jc5a7XCDX4sbT3nBH71+4Iav47j+wjnAMIKb/Mzt3G/A84PP+fqC6mEg==
X-Received: by 2002:a5d:4a0e:0:b0:242:643e:6954 with SMTP id m14-20020a5d4a0e000000b00242643e6954mr14892440wrq.14.1670958504838;
        Tue, 13 Dec 2022 11:08:24 -0800 (PST)
Received: from suse.localnet (host-87-12-209-78.business.telecomitalia.it. [87.12.209.78])
        by smtp.gmail.com with ESMTPSA id bo28-20020a056000069c00b002362f6fcaf5sm560698wrb.48.2022.12.13.11.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 11:08:24 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Evgeniy Dushistov <dushistov@mail.ru>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v2 2/3] fs/ufs: Change the signature of ufs_get_page()
Date:   Tue, 13 Dec 2022 20:08:22 +0100
Message-ID: <3174926.0WQXIW03uk@suse>
In-Reply-To: <Y5glgpD7fFifC4Fi@ZenIV>
References: <Y5glgpD7fFifC4Fi@ZenIV>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On marted=EC 13 dicembre 2022 08:10:58 CET Al Viro wrote:
> On Tue, Dec 13, 2022 at 12:19:05AM +0100, Fabio M. De Francesco wrote:
> > +static void *ufs_get_page(struct inode *dir, unsigned long n, struct p=
age
> > **page)>=20
> >  {
> > =20
> >  	struct address_space *mapping =3D dir->i_mapping;
> >=20
> > -	struct page *page =3D read_mapping_page(mapping, n, NULL);
> > -	if (!IS_ERR(page)) {
> > -		kmap(page);
> > -		if (unlikely(!PageChecked(page))) {
> > -			if (!ufs_check_page(page))
> > +	*page =3D read_mapping_page(mapping, n, NULL);
> > +	if (!IS_ERR(*page)) {
> > +		kmap(*page);
> > +		if (unlikely(!PageChecked(*page))) {
> > +			if (!ufs_check_page(*page))
> >=20
> >  				goto fail;
> >  	=09
> >  		}
> >  =09
> >  	}
> >=20
> > -	return page;
> > +	return page_address(*page);
>=20
> Er...   You really don't want to do that when you've got ERR_PTR()
> from read_mapping_page().
>=20

Sure :-)

Obviously, I'll fix it ASAP.

But I can't yet understand why that pointer was returned unconditionally in=
=20
the code which I'm changing with this patch (i.e., regardless of any potent=
ial =20
errors from read_mapping_page()) :-/=20

>
> >  fail:
> > -	ufs_put_page(page);
> > +	ufs_put_page(*page);
> >=20
> >  	return ERR_PTR(-EIO);
> > =20
> >  }
>=20
> IDGI...
>=20
> static void *ufs_get_page(struct inode *dir, unsigned long n, struct page=
=20
**p)
> {
> 	struct address_space *mapping =3D dir->i_mapping;
> 	struct page *page =3D read_mapping_page(mapping, n, NULL);
>=20
> 	if (!IS_ERR(page)) {
> 		kmap(page);
> 		if (unlikely(!PageChecked(page))) {
> 			if (!ufs_check_page(page))
> 				goto fail;
> 		}
> 		*p =3D page;
> 		return page_address(page);
> 	}
> 	return ERR_CAST(page);
>=20
> fail:
> 	ufs_put_page(page);
> 	return ERR_PTR(-EIO);
> }
>=20
> all there is to it...  The only things you need to change are
> 1) type of function
> 2) make sure to store the page into that pointer to pointer to page on=20
success
> 3) return page_address(page) instead of page on success
> 4) use ERR_CAST() to convert ERR_PTR() that is struct page * into equal
> ERR_PTR() that is void * (the last one is optional, just makes the intent
> more clear).

I've never seen anything like this: you are spoon feeding me :-)

Please don't misunderstand: I'm OK with it and, above all, I'm surely =20
appreciating how much patience and time you are devolving to help me.

I'll send v3 ASAP (for sure within the next 24 hours).

=46urthermore, if there are no other issues, I'd start ASAP with the=20
decomposition of the patch to fs/sysv into a series of three units and rewo=
rk=20
the whole design in accordance to the suggestions you have been kindly=20
providing.

I'm sorry for responding and reacting so slowly. Aside from being slow beca=
use=20
of a fundamental lack of knowledge and experience, I can do Kernel developm=
ent=20
(including studying new subjects and code, doing patches, doing reviews, an=
d=20
the likes) about 7 hours a week. This is all the time I can set aside until=
 I=20
quit one of my jobs at the end of January.

Again thanks,

=46abio

P.S.: While at this patch I'd like to gently ping you about another convers=
ion=20
that I sent (and resent) months ago:

[RESEND PATCH] fs/aio: Replace kmap{,_atomic}() with kmap_local_page() at:
https://lore.kernel.org/lkml/20221016150656.5803-1-fmdefrancesco@gmail.com/

This patch to fs/aio.c has already received two "Reviewed-by" tags: the fir=
st=20
from Ira Weiny and the second from Jeff Moyer (you won't see the second the=
re,=20
because I forgot to forward it when I sent again :-( ).

The tag from Jeff is in the following message (from another [RESEND PATCH]=
=20
thread):
https://lore.kernel.org/lkml/x49h6zzvn1a.fsf@segfault.boston.devel.redhat.c=
om/

In that same thread, I explained better I meant in the last sentence of the=
=20
commit message, because Jeff commented that it is ambiguous (I'm adding him=
 in=20
the Cc list of recipients).

The original patch, submitted on Thu, 7 Jul 2022 01:33:28 +0200 is at:
https://lore.kernel.org/lkml/20220706233328.18582-1-fmdefrancesco@gmail.com/

I'd appreciate very much if you can spend some time on that patch too :)



