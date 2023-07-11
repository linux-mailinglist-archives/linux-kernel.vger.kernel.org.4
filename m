Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD7F74F972
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 22:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjGKU62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 16:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjGKU60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:58:26 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC54170C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:58:24 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8bd586086so46298635ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689109104; x=1691701104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g8KOiARB33Qn2eQiVXhRlyJdDsctValxz3yLwjk0g1Y=;
        b=d0KLinwEBO85IyDrVcM2/y8PB0cmJhxtQOVyvg2twPerU70J8KrHLb4vsZ5fAE3l0N
         Gyl5pfkZugVA2/lPDvG6hUDhcIDjgxVywglTXA8gEZnIne2JUebijAd6jPOlLXhHRe12
         uLrm7TDexGzYePNOOryVRsVKzWV9H76hdIwuQIubI7tMwGFjZ/ZJc0trySOSQNPoV2em
         CYmVN6R3jqKI9v3JAgyWJZQxwNompXOuFSWBtuRdeLuVOmXYjijfnRa1uvh0pT4zOA+I
         Ne4tcR+KvxT/zW9zkNA2kCRW7fgtbrYDpaGhkkNDMSr1uENmkwHol8AbQ/3Rr0QxELIr
         UPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689109104; x=1691701104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8KOiARB33Qn2eQiVXhRlyJdDsctValxz3yLwjk0g1Y=;
        b=RJEddle77nB3Oxvo0nWYMRkfhmfTtXRLfblstYMN8e9PkBhumfGAJnuCcqQnlbXIy9
         b5TuvOUlW3TrjU5AhXidaaqGL+JoRrdMNHmQ/eRae/ZE1TFD2Pm2vNNHUtbRf+7MXWN7
         n3vLul4EvNOhZev7gnc/Odqfv2nz0/mmrgpejLeX9lvPNkEw6AZc+LqRR1at01HevJtw
         r6CHmwLoGy3QdRBH/6KcbESgphxd83tGyjRMlniG24TufjjgI0llF+gqoRefxKoBrUR+
         8IhkhEJObwtsu5pkvpVrsHon/QK0Oh/bi1UwseSk4ScqqcqJQdtYxpP1qeJTf9wLmkAh
         Q9+A==
X-Gm-Message-State: ABy/qLbsQp00pr4WNrRQd2vse8WeEqSZQSyBenERIeEfrMPV9ogD7/wZ
        DPmTU59Lgt9m+xc+w1AcpQkbDQ==
X-Google-Smtp-Source: APBJJlEWupqXJzTkSXeMkFcC11KWGbsSJzERularWZNESQhAfks4Cr0DgcD0Z/PwTbTJxN73t/trag==
X-Received: by 2002:a17:902:daca:b0:1b8:ae8c:7d88 with SMTP id q10-20020a170902daca00b001b8ae8c7d88mr21832491plx.7.1689109104339;
        Tue, 11 Jul 2023 13:58:24 -0700 (PDT)
Received: from fedora (61-114-134-192.ppp.bbiq.jp. [61.114.134.192])
        by smtp.gmail.com with ESMTPSA id bg4-20020a1709028e8400b001b53be3d942sm2350749plb.232.2023.07.11.13.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 13:58:23 -0700 (PDT)
Date:   Tue, 11 Jul 2023 16:58:19 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, techsupport@winsystems.com,
        stable@vger.kernel.org,
        Paul Demetrotion <pdemetrotion@winsystems.com>
Subject: Re: [RESEND] gpio: ws16c48: Fix off-by-one error in WS16C48 resource
 region extent
Message-ID: <ZK3Ca825eTtNFL9V@fedora>
References: <20230228081724.94786-1-william.gray@linaro.org>
 <CAMRc=MfD3=ifo9EJf=5_HZKLXnbASi=ehYm=Zs4WQA+YxfffQw@mail.gmail.com>
 <ZAXfZbywWOo2pg4L@fedora>
 <ZC2J9ru1VN5fmeXZ@fedora>
 <ZH3mxt4f5HaCCtph@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0SJN+oWbDHvdTo04"
Content-Disposition: inline
In-Reply-To: <ZH3mxt4f5HaCCtph@fedora>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0SJN+oWbDHvdTo04
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2023 at 09:44:38AM -0400, William Breathitt Gray wrote:
> On Wed, Apr 05, 2023 at 10:47:18AM -0400, William Breathitt Gray wrote:
> > On Mon, Mar 06, 2023 at 07:41:09AM -0500, William Breathitt Gray wrote:
> > > On Mon, Mar 06, 2023 at 10:23:30AM +0100, Bartosz Golaszewski wrote:
> > > > On Thu, Mar 2, 2023 at 11:30=E2=80=AFPM William Breathitt Gray
> > > > <william.gray@linaro.org> wrote:
> > > > >
> > > > > The WinSystems WS16C48 I/O address region spans offsets 0x0 throu=
gh 0xA,
> > > > > which is a total of 11 bytes. Fix the WS16C48_EXTENT define to the
> > > > > correct value of 11 so that access to necessary device registers =
is
> > > > > properly requested in the ws16c48_probe() callback by the
> > > > > devm_request_region() function call.
> > > > >
> > > > > Fixes: 2c05a0f29f41 ("gpio: ws16c48: Implement and utilize regist=
er structures")
> > > > > Cc: stable@vger.kernel.org
> > > > > Cc: Paul Demetrotion <pdemetrotion@winsystems.com>
> > > > > Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> > > > > ---
> > > >=20
> > > > Why did you need to resend this? Anything changed?
> > > >=20
> > > > Bart
> > >=20
> > > No changes in code, just added the stable@ver.kernel.org Cc tag.
> > >=20
> > > William Breathitt Gray
> >=20
> > Hi Bart,
> >=20
> > Would you take this fix through the gpio tree?
> >=20
> > William Breathitt Gray
>=20
> It looks like this patch was missed. Is there anything further needed or
> can it be queued as it is now?
>=20
> William Breathitt Gray

The fix was missed again this past cycle. Are there any particular
issues with merging this patch that I should address? WS16C48 interrupt
handling is still broken so that's the motivation for getting this fix
into the GPIO tree.

William Breathitt Gray

--0SJN+oWbDHvdTo04
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZK3CawAKCRC1SFbKvhIj
K9GCAP0cO7V37RWi59bgL6jwGculR+L+HxyeBXdQXQapKRTjKAEA56Xhu/irRplu
kiskQAWIe3GpNBquZxY2ybeDe9G+Bg4=
=KmlC
-----END PGP SIGNATURE-----

--0SJN+oWbDHvdTo04--
