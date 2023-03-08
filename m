Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7A06AFD11
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 03:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCHCvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 21:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjCHCvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 21:51:35 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8940BAA260
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 18:51:29 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d7so16809727qtr.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 18:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678243888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mBTA60cZTqBtyoITaMc+SEMUbPVKoktbGsvzyY/a5wM=;
        b=NY3kdFK7QkdkNKWh86qCYTK9vfy3kWbbtMKSHYnaciD6E0uEx7PPj325j++QD8Hs2+
         GRa1BuQohNmdhJLM0fwxA9g3bzrchyRBuNXWMLcwQYMNNjFFeMA1tXFC48Jwe7q7yOAw
         8omiQWLFqa5zUlyEPe+bb3MQcTwQIx9cR1wbZN8xbp5GBNvL9WVSCJsAwtbrrz/Vkww4
         NXdQHipXj9ZPxznRhpIEgUl52BYwCrrHIxkG8N3mQTb5Ozgo6abLCkxwdi86NjjkW4el
         viZi0CS/VBJVW3uE+t/p+N0WZKvsOM+H9Rk0RW+O2XKHiKum3Jd7g0V/z61GV2ADcbn+
         Mx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678243888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBTA60cZTqBtyoITaMc+SEMUbPVKoktbGsvzyY/a5wM=;
        b=fWABImKChi2yDX45ecNOnqryOngYPW/OsMJ0vZLlo7SVYU47VM5XwoQAdujkmsOeCO
         /6T45M8/i2lGxcgDuj5ejpb3cfsdiC1IRyMne3t1d4B+RHUtLkA52gSCLNKGruCsi9aq
         Vkrzq+hzsTWPcvn2ersqTF7I9quOMx+VIrcFnzDwRtTvFG9APlSsC+uczmUcVjQDMhse
         5pzSPSK8Ku5mhGLqv9H5NnwdtWVW3yQTLcBwrjyNnFGtrhm+zJD7Pxqf9picV1+PLyPr
         TJHpyesoyiBjuz/5kxUuQhzZ++xjaxeoSTBY7etfO+DW6wrxu7evVlixMFziguAw1Snk
         /xrA==
X-Gm-Message-State: AO0yUKWW/CTB4CxJnoIGkPvEP+DKD8HGa3F+vgCc0bfLFEOfFE9dZDMV
        QAjaxuF4XHzDo03EyswSgsfSZw==
X-Google-Smtp-Source: AK7set8aR0gyxqI97lIeS6tVAboTuImsID4lv+BvmEQEvfVLjMdwKuNvfLGJ/1alx2KwhzvRMazvSA==
X-Received: by 2002:a05:622a:1a2a:b0:3bf:b8ae:6ece with SMTP id f42-20020a05622a1a2a00b003bfb8ae6ecemr29496646qtb.10.1678243888643;
        Tue, 07 Mar 2023 18:51:28 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id r13-20020a05622a034d00b0039cc0fbdb61sm11244768qtw.53.2023.03.07.18.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 18:51:28 -0800 (PST)
Date:   Tue, 7 Mar 2023 21:51:26 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, techsupport@winsystems.com,
        Paul Demetrotion <pdemetrotion@winsystems.com>
Subject: Re: [PATCH v4 3/3] gpio: ws16c48: Migrate to the regmap API
Message-ID: <ZAf4LudZkYLsWVWh@fedora>
References: <cover.1678106722.git.william.gray@linaro.org>
 <4b6cd42426521808962d68a44952b95818fc5daf.1678106722.git.william.gray@linaro.org>
 <ZAX2k9gW1AA88T/P@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Mi/wX9MNCaaYw2/s"
Content-Disposition: inline
In-Reply-To: <ZAX2k9gW1AA88T/P@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Mi/wX9MNCaaYw2/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2023 at 04:20:03PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 06, 2023 at 07:59:53AM -0500, William Breathitt Gray wrote:
>=20
> ...
>=20
> > -	raw_spinlock_t lock;
> > +	spinlock_t lock;
>=20
> This is a regression.
> That said, do we need a support of raw spin locks in the regmap IRQ?

So this code has a similar need as the gpio-pcie-idio-24 patch: guard
registers between handle_mask_sync() and set_type_config(); however, now
we also need to protect registers in regmap_irq_thread(). We can't use a
mutex here because regmap_irq_thread() is executed in an interrupt
context so we cannot sleep.

This might be a mistake in my understanding: I chose spinlock_t here
because I believed it to map out to a raw_spinlock_t anyway underneath,
whereas on RT kernels it would map out to whatever the equivalent is. I
suspect this is not actually the case. Would using raw_spinlock_t
explicitly be the correct way to go for this particular case?

> > +	u8 irq_mask[WS16C48_NUM_IRQS / WS16C48_NGPIO_PER_REG];
>=20
> Can this be a bitmap? Or is it too over engineered with it?

I also considered a bitmap at first, but I believe it adds an
unnecessary abstraction in this particular case: irq_mask is just a
buffer to hold the previous mask_buf state to check if it's changed when
ws16c48_handle_mask_sync() is called. Since all we do with it is save
the mask_buf directly, using the bitmap API seems like overkill.

William Breathitt Gray

--Mi/wX9MNCaaYw2/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZAf4LgAKCRC1SFbKvhIj
K1BpAP9hFKmskIE63OocEoCF07/hFHcHLdTOgP38UFv3hsndRgD/WPrfTJ+zn4gQ
vWqp5iK5vJbkyAfUBmKpHHsaXIRTBQo=
=KG62
-----END PGP SIGNATURE-----

--Mi/wX9MNCaaYw2/s--
