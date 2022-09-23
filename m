Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF805E79B0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiIWLgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiIWLfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:35:34 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23654E3EEB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:35:32 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-12b542cb1d3so17791068fac.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=nT8tPOMFRWVw211AA5Gp025zMU5m9umHWApmQQ1G5i4=;
        b=FwGbXtmcEgYiPRiho8i2fABRQ3M1PG0BR/flX9jn0JvuSTGOz7Ar8N+o+/dl+bLnqZ
         SvLJKZchPKu72zXcGClNjZgQ/yNccJeIauW6NPj0gSINHwl4HJ4xJ7EQa4BdkidSjr5C
         U+x9ja2kkYPeD+/OS5RmeZ49dBxNlYoM2GYmJi+v5eOblg7y14OMyu9hy4l7UOXPAIzJ
         z4SKCtQUbxIhAMZWY7EikZnd6dCzSyK5bWu8Ir/5tt52nSJcIN0bXj+JCAusEQXOcXCA
         FZdhQkFNYA6Utj0xMOG9tBTcxnp/ziGhCDzNetOxR0Kq/iZpdyQkAf5ByIcg3T8sft0M
         IqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nT8tPOMFRWVw211AA5Gp025zMU5m9umHWApmQQ1G5i4=;
        b=j9V+djuloY8nIoh/WWLa8X+cPdvchVGgLMnqCUu2u/PadYLWCk7t8yiN0ZB0+Kk/b6
         KAu/iMxfELzL/YKIBCGelhf9G1zWKdSdXY0gmqF+0xcY/tTj1jz0GeWvzKFGL6WLp6wV
         bw41H50x1R8rLbZY/Fy7xFXxVPey815DjOwRprGlg19CA/sfkacwoN37MpzD97qfNauv
         RdrmfRzpuTrbm4KgBZjkqsFSZcSKgkzNlit9QflPQafpsywCQg/Fg5fKuQMyFEEcsyVY
         dzIG5lb3Rg/MPrsIaBLliC0v/8gEmLQg1riz0eFChbM+Ywh/TNhx/g6wShX0Fsz67F/j
         1zkw==
X-Gm-Message-State: ACrzQf3sDFUWNejA2NF7KAih1y9Iyd5rkFpUsDXELcMFNIIpq7/TksVh
        Yspel+1Uk/ilOrBzB3tMLJ8XcA==
X-Google-Smtp-Source: AMsMyM60YTJG3Kuk2a0mtZaWPWTvi+BIMBeMOkLgSWmjRCZqsZ7ArPaxrxv8436uU26PoVCEWazcVg==
X-Received: by 2002:a05:6870:c34b:b0:12b:3ba8:1a92 with SMTP id e11-20020a056870c34b00b0012b3ba81a92mr11190562oak.114.1663932931409;
        Fri, 23 Sep 2022 04:35:31 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id k7-20020acaba07000000b0034fef49812dsm3633202oif.30.2022.09.23.04.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 04:35:30 -0700 (PDT)
Date:   Fri, 23 Sep 2022 07:35:28 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
Subject: Re: [PATCH v8 3/4] counter: ti-ecap-capture: capture driver support
 for ECAP
Message-ID: <Yy2aAMv5PRjsJ4s2@fedora>
References: <20220922170402.403683-1-jpanis@baylibre.com>
 <20220922170402.403683-4-jpanis@baylibre.com>
 <Yy0G9a5S3OzwyEwW@fedora>
 <2f3e5036-caab-f892-a4ad-b852f72db331@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jebUT/7FaLb8aGNO"
Content-Disposition: inline
In-Reply-To: <2f3e5036-caab-f892-a4ad-b852f72db331@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jebUT/7FaLb8aGNO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2022 at 09:23:26AM +0200, Julien Panis wrote:
>=20
>=20
> On 23/09/2022 03:08, William Breathitt Gray wrote:
> > On Thu, Sep 22, 2022 at 07:04:01PM +0200, Julien Panis wrote:
> > > ECAP hardware on TI AM62x SoC supports capture feature. It can be used
> > > to timestamp events (falling/rising edges) detected on input signal.
> > >=20
> > > This commit adds capture driver support for ECAP hardware on AM62x So=
C.
> > >=20
> > > In the ECAP hardware, capture pin can also be configured to be in
> > > PWM mode. Current implementation only supports capture operating mode.
> > > Hardware also supports timebase sync between multiple instances, but
> > > this driver supports simple independent capture functionality.
> > >=20
> > > Signed-off-by: Julien Panis <jpanis@baylibre.com>
> > Hello Julien,
> >=20
> > Comments follow inline below.
> >=20
> > > +/**
> > > + * struct ecap_cnt_dev - device private data structure
> > > + * @enabled: device state
> > > + * @clk:     device clock
> > > + * @regmap:  device register map
> > > + * @nb_ovf:  number of overflows since capture start
> > > + * @pm_ctx:  device context for PM operations
> > > + */
> > > +struct ecap_cnt_dev {
> > > +	bool enabled;
> > > +	struct clk *clk;
> > > +	struct regmap *regmap;
> > > +	atomic_t nb_ovf;
> > > +	struct {
> > > +		u8 ev_mode;
> > > +		u32 time_cntr;
> > > +	} pm_ctx;
> > > +};
> > Provide documentation for the ev_mode and time_cntr members. You
> > probably need a lock as well to protect access to this structure or
> > you'll end up with race problems.
>=20
> Hi William,
>=20
> How can I end up with race problems ? pm_ctx members are only accessed at
> suspend (after capture/IRQ are disabled) and resume (before capture/IRQ a=
re
> re-enabled).
> Is there any risk I did not identify ?
>=20
> Julien

I was thinking of the ecap_cnt_dev enabled member. The Counter callbacks
may execute in concurrent threads, so races can appear when you access
members of the ecap_cnt_dev structure in these callbacks.

Take for example this section of ecap_cnt_enable_write():

        if (enable =3D=3D ecap_dev->enabled)
                return 0;
        if (enable)
                ecap_cnt_capture_enable(counter);
        else
                ecap_cnt_capture_disable(counter);
        ecap_dev->enabled =3D enable

Suppose two threads try to enable the count capture. A race condition is
present where the two threads could see ecap_dev->enabled as false and
both proceed to call ecap_cnt_capture_enable(). This results in
pm_runtime_get_sync() bumping the usage count twice and we're left with
a mismatch the next time ecap_cnt_capture_disable() is called.

William Breathitt Gray

--jebUT/7FaLb8aGNO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYy2aAAAKCRC1SFbKvhIj
Kw8hAQDnJHeoUXmuYd86jmDVtiA+OtkSm2xmaMjJ7pEZy2FTTQEA7eVCAgFOZvx5
v6x390GPFK+hp/bcUo6N3p/IoWKVrQg=
=oFnJ
-----END PGP SIGNATURE-----

--jebUT/7FaLb8aGNO--
