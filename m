Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D7C6D3836
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 16:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjDBOHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 10:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjDBOHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 10:07:41 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17771880E
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 07:07:39 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id e65so31971595ybh.10
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 07:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680444459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DI6/Ak/JJt+3WHhmoVkbAa6tTXcA/pQNWtwkocmXirM=;
        b=hqbb8eeKj9LcaWWn5n4N5zsMLpTDf+czIkU9logUtj7DZSXfUnASzbsHxbV8UnocuS
         Zt5TmDAu9MsKBZS/6zwera0ekZhCvgDFcrpRezGd+eim4vI3EXDeyPLCVsrtIrvYKVqA
         54dHbi8dFoKj66Idad0xnc3S7Pukyb7aRIaIYtZuYc47aGwialQ76D5rF4fnBqjQF58p
         JtsBb0U9iFTch1NhuuIBXJk8ifLTxHmEYh+yvBCQRTO9yW0WG2WKP5ypkQjd/ola21rk
         sLyztdgRDmMPp8rzqmV9KLyyywd0gU8/g+fCFcZSJvngOriQvy9b8Qb7tXU0WWZv4Gl0
         J6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680444459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DI6/Ak/JJt+3WHhmoVkbAa6tTXcA/pQNWtwkocmXirM=;
        b=BSBxMEIybf77yIDmUJAZqTc/tjS7IKLJei3dVC3Hok8W7tNsera5iJdhyMQH/uqA5F
         LRSy0BWt237ZYtpavi+opgNt+Ft2O8js+7s7qJkfba7AS25kN93JXhU71a+4ecHbq/PX
         /hc6KpwW3hzR2VIaNl9m1MxtFEH3e4LojYZx+c4/G8A2G6DmhTwX3hWYMlY9V2wCweFK
         C81yY4RDPC3pw1J88T+dzQ5OOcueDl2w2m0vg1NG2HtWo1ntDXY0UZJJgc6iVrDx0D9O
         adfGr0nygXnfUQAkZLyMaK4v7lPuz5Co3N2q9FibyB4CAMGDNSYNdEjgaS8HVLbLBDon
         JR+A==
X-Gm-Message-State: AAQBX9eOvfENswTQc97BZmxRCkOL0rJgSJFPC40y8i2WJFQYq1n5/Lg/
        7HXfcfVdENDdLL7pLxYr5ZUt9g==
X-Google-Smtp-Source: AKy350ZUSTR5enbxqtFuTqXnDDlPsf6ty0MI2igYQqSPoQg43m5EeCPsrrw5jm1JeGhw1aR+IjGTrg==
X-Received: by 2002:a25:ac86:0:b0:a84:a887:5468 with SMTP id x6-20020a25ac86000000b00a84a8875468mr32913642ybi.37.1680444458980;
        Sun, 02 Apr 2023 07:07:38 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id p9-20020a254209000000b00b7767ca7497sm1910036yba.52.2023.04.02.07.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 07:07:38 -0700 (PDT)
Date:   Sun, 2 Apr 2023 10:07:36 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Paul Demetrotion <pdemetrotion@winsystems.com>,
        techsupport@winsystems.com
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] watchdog: ebc-c384_wdt: Migrate to the regmap API
Message-ID: <ZCmMKC+/RwmWshCP@fedora>
References: <20230314152916.185939-1-william.gray@linaro.org>
 <87df4524-5a64-c285-238d-ac1ae0c31249@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8C0AsSzB9kL3yZkq"
Content-Disposition: inline
In-Reply-To: <87df4524-5a64-c285-238d-ac1ae0c31249@roeck-us.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8C0AsSzB9kL3yZkq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 14, 2023 at 10:47:28AM -0700, Guenter Roeck wrote:
> On 3/14/23 08:29, William Breathitt Gray wrote:
> > The regmap API supports IO port accessors so we can take advantage of
> > regmap abstractions rather than handling access to the device registers
> > directly in the driver.
> >=20
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
>=20
> The changes are too invasive to accept without testing.
> I hope we can get a Tested-by: tag from someone. Other than
> that, we are good to go from my perspective.
>=20
> Thanks,
> Guenter

Paul,

Is anyone at WINSYSTEMS interested in this driver? I no longer have
access to this hardware so I can no longer maintain this driver, and the
original users of this driver indicated to me that they have moved on to
another device. If there is no longer interest at WINSYSTEMS to maintain
this driver, perhaps we should discuss removal of it from the Linux
codebase.

William Breathitt Gray

--8C0AsSzB9kL3yZkq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZCmMKAAKCRC1SFbKvhIj
K7wDAP9mpspBKbhCjMBgVowbmmc1NhYh1MbCFMYokJRPSUa9iwD/XFdR7Ebz+la8
SIfsXUegli9h3ryx0ASYmLfNKnJRGAY=
=ixSk
-----END PGP SIGNATURE-----

--8C0AsSzB9kL3yZkq--
