Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376BD72B1AA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 13:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjFKLb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 07:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjFKLbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 07:31:53 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053E7BD;
        Sun, 11 Jun 2023 04:31:52 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b3c0c476d1so3131785ad.1;
        Sun, 11 Jun 2023 04:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686483111; x=1689075111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ET+8jv1Sr4c8KNb9UT3DWTBXEn+DrM0MENG4Vij4uyQ=;
        b=ByLAexixDGYoAAbP+TdnYMa5G8F/VvOmM2T7/k+wQ3cghFSNw4Kj2IASok17J7GtyC
         pCfzHh4wSayC2NXfPUYE5UTGZGAvsxY0hoesHUUjSvY+EXJAg9ApMd/ncGMQ8Zpt2zo5
         2dWmy69/WS7xsoZGYIbNEeHU1wTzK9gHgmOHmK5TVmSO//bspmX9a+Q4oiBHTTJIybS5
         oLsqXrllscjmhjrL7peXQSqiWz/CugCFIORxjrW1urVFQzRXSdzR2nNPxSfGRevYccb6
         jvg/uAW9JNITn/Y2P/ySuDZpDuzJQnuAIaagbCQMyiIaIeG1iJzNxF5hkMtCzUQG2zy5
         Yiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686483111; x=1689075111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ET+8jv1Sr4c8KNb9UT3DWTBXEn+DrM0MENG4Vij4uyQ=;
        b=F25x8/9q6RvQzI5mpZMUirrQIWMaerufuyOkn3jVNhaxqin9zviZvTYc/GXb5/vUwB
         ozd067vNTRMo3tf+itxhcD18YzpdAVfUyLG9sQJQXG1ewPuuzctpCUjGuTixOFCiBmkY
         vToCJM2Y/uH/iXAa2mXsqikqT3GxYR8xECv3K/CoSyDff89m5agd8o0BsDf0N1Ew9RHY
         WYq2wWUR8iGsnWeLLfmgH1B9pc+VgNYFgfkZpVHz5htOfi0hYqDSnWEPVtKEEoAZzMRw
         VsPtuM9z2lO4papvOtkbu+DExHuYSpPVkbRUzbA2XNnan7M1SIF2zJe9h3+FrF6kVS8V
         RAuA==
X-Gm-Message-State: AC+VfDwCtHyr3ZTu+nsOro4GEhvuZPy8iA5Iqg3jMhZii+hLsR7M+6Kn
        MZ6GZQACepJKtYSX3nJipRg=
X-Google-Smtp-Source: ACHHUZ7cRXXUiwx/VGfZs4Qirpj+wNLdNsY/9ynhNKhbPawe6sObhyNHGvcYnjCovYAKTibn3tXS+Q==
X-Received: by 2002:a17:902:8642:b0:1b0:348:2498 with SMTP id y2-20020a170902864200b001b003482498mr3561999plt.2.1686483111258;
        Sun, 11 Jun 2023 04:31:51 -0700 (PDT)
Received: from debian.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id jd4-20020a170903260400b001b3b83b7d4esm1417503plb.211.2023.06.11.04.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 04:31:50 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 18522106A3A; Sun, 11 Jun 2023 18:31:34 +0700 (WIB)
Date:   Sun, 11 Jun 2023 18:31:34 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Joe Breuer <linux-kernel@jmbreuer.net>,
        Bart Van Assche <bvanassche@acm.org>,
        Pavel Machek <pavel@ucw.cz>,
        Damien Le Moal <dlemoal@kernel.org>
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
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Hardening <linux-hardening@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux SCSI <linux-scsi@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Hannes Reinecke <hare@suse.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: Fwd: Waking up from resume locks up on sr device
Message-ID: <ZIWwlptfVphjGz9u@debian.me>
References: <2d1fdf6d-682c-a18d-2260-5c5ee7097f7d@gmail.com>
 <5513e29d-955a-f795-21d6-ec02a2e2e128@gmail.com>
 <ZIQ6bkau3j6qGef8@duo.ucw.cz>
 <07d6e2e7-a50a-8cf4-5c5d-200551bd6687@gmail.com>
 <02e4f87a-80e8-dc5d-0d6e-46939f2c74ac@acm.org>
 <b2cf6d96-a55a-d444-d22e-e9b3945ba43f@jmbreuer.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pJUn/uCZg2bV7nGQ"
Content-Disposition: inline
In-Reply-To: <b2cf6d96-a55a-d444-d22e-e9b3945ba43f@jmbreuer.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pJUn/uCZg2bV7nGQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 11, 2023 at 11:05:27AM +0200, Joe Breuer wrote:
> I'm the reporter of this issue.
>=20
> I just tried this patch against 6.3.4, and it completely fixes my
> suspend/resume issue.
>=20
> The optical drive stays usable after resume, even suspending/resuming dur=
ing
> playback of CDDA content works flawlessly and playback resumes seamlessly
> after system resume.
>=20
> So, from my perspective: Good one!
>=20

Thanks for trying the fix and telling the result. But tl;dr:

> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>=20
> A: No.
> Q: Should I include quotations after my reply?
>=20
> http://daringfireball.net/2007/07/on_top

(while I'm removing the quoted context below your reply after the fact).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--pJUn/uCZg2bV7nGQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZIWwkAAKCRD2uYlJVVFO
o0dcAQDBLvOwhF7MNiLJ3qtN+3ezvWqHj9xZ1JeN01prxbawGgD+NSKtGG1O0leF
rjwIYm0dINVegT1HRoIZQ0flawMzpAg=
=j2UP
-----END PGP SIGNATURE-----

--pJUn/uCZg2bV7nGQ--
