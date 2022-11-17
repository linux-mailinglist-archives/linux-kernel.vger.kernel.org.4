Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE6962DFCC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiKQP1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239758AbiKQP04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:26:56 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9658D22527
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:25:38 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id h10so1383480qvq.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qc7+zaKXIH748CZaku7bgeQA/ReE+fYPlO45pSTJDq0=;
        b=xpY0zt7c8PFHwiXvJEWZQ9cRA2xfBqG4NMJVKocfUmFpDGS3y6XJmizFPEBARwF5ve
         pJ9VH8tmyT4yK+uH7+tEXv65jnluDi9mjSV0fpmS3nm8/A/IFpcExc/MCI08iFEkg43Y
         8w+TUyKQpDSoad2kIMPtTJ9DeT9Y0FDPdHnACG4UaVnWNdxVOet6Ibf8F0RV9O4887Zz
         I05N6w/je0LK1/x9DVYSlazHQfHlA58Q1VQLWjhe3BUvAsR/X+TBuorhU/tXvNNAFOIR
         evPIKi+N//BSvJMrR+msf9dWf8xILywQ4vhIMO9UhZi8uU2DOnA8u/RdpuYtWhBX8a+9
         wXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qc7+zaKXIH748CZaku7bgeQA/ReE+fYPlO45pSTJDq0=;
        b=liqrBCpvlH4KyrKCoArrRKox/pYCgA9Qj+QgIBs7uVchOyjq+YJtQL2TCjHL3s8pHq
         cC2XntvYpqKEhIqG++PgKGdRQDCqhhkonX/OdqKwllypyU0xijvQ/mvm9PpyZJHcgm05
         zw1xoz2GhTRNOPMV0qZTTNnn5QRKzWzph7Qh+PtUc9PZjg8mNyK8FxK5mb//jckvbTHh
         VpNDOEaxrOa7YH9smeggwdKoBau0RW9KL2vqkGdgk9p0pTnfyoKUuKydRnSa57W7t0mw
         jI2MkI3f5dk0spjuLKGptWFeo319S/SKK75e6sTtqW4RgfCMsxi1an9nMOSJFYKIceWm
         481g==
X-Gm-Message-State: ANoB5pkor6lYJFn1LcO8ZuF0Uha3pRWPrq6aEfNZyCibdhJSCimcUEQx
        L30W02wZjeYGFRRLZZr+lCZe4g==
X-Google-Smtp-Source: AA0mqf7QHFoRBh/VpJtrlbjn6odbmAPfogJSw9qJRRGdGsdx5DgqPcrGPeGgnE7OYdN+gr9WpirzUg==
X-Received: by 2002:a0c:f788:0:b0:4bb:6518:4592 with SMTP id s8-20020a0cf788000000b004bb65184592mr2824773qvn.77.1668698737730;
        Thu, 17 Nov 2022 07:25:37 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id h4-20020a05620a284400b006f9e103260dsm609831qkp.91.2022.11.17.07.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 07:25:37 -0800 (PST)
Date:   Thu, 17 Nov 2022 10:00:17 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc
Subject: Re: [PATCH v2 2/4] regmap-irq: Add handle_mask_sync() callback
Message-ID: <Y3ZMga3nphqmAtka@fedora>
References: <cover.1668129763.git.william.gray@linaro.org>
 <53e9e89cc9d7e9c20cbdfc13b360dcb43d07f832.1668129763.git.william.gray@linaro.org>
 <Y3PI5n8FXxOtGhzP@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pKPDdkdohjMYUtPY"
Content-Disposition: inline
In-Reply-To: <Y3PI5n8FXxOtGhzP@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pKPDdkdohjMYUtPY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 15, 2022 at 05:14:14PM +0000, Mark Brown wrote:
> On Thu, Nov 10, 2022 at 08:55:51PM -0500, William Breathitt Gray wrote:
>=20
> > Provide a public callback handle_mask_sync() that drivers can use when
> > they have more complex IRQ masking logic. The default implementation is
> > regmap_irq_handle_mask_sync(), used if the chip doesn't provide its own
> > callback.
>=20
> Can you provide examples of something that would make sense to
> open code in a driver rather than factoring out?  It looks like
> this has been added due to one of the devices you're looking at
> for some reason disabling it's upstream interrupt when all of the
> downstream interrupts are masked, while weird that doesn't seem
> especally device specific.

Sure, I actually intend to use this callback for the 104-idi-48 module
as well in the v3 submission so I'll describe that situations well.

For the 104-dio-48e we have the following:

    Base Address +B (Write): Enable Interrupt
    Base Address +B (Read): Disable Interrupt
    Base Address +F (Read/Write): Clear Interrupt

So for 104-dio-48e, any write to 0xB will enable interrupts, while any
read will disable interrupts; interrupts are with either a read or any
write to 0xF. There's no status register either so software just has to
assume that if an interrupt is raised then it was for the
104-dio-48e device.

For the 104-idi-48, we do get a status register and some basic masking
but it's broken down by banks rather than individual GPIO; there are six
8-bit banks (Port 0 Low Byte, Port 0 Mid Byte, Port 0 High Byte, Port 1
Low Byte, Port 1 Mid Byte, Port 1 High Byte):

    Base Address + 0 (Read/Write): Port 0 Low Byte
    Base Address + 1 (Read/Write): Port 0 Mid Byte
    Base Address + 2 (Read/Write): Port 0 High Byte
    Base Address + 3: N/A
    Base Address + 4 (Read/Write): Port 1 Low Byte
    Base Address + 5 (Read/Write): Port 1 Mid Byte
    Base Address + 6 (Read/Write): Port 1 High Byte
    Base Address + 7 (Read): IRQ Status Register/IRQ Clear
        Bit 0-5: Respective Bank IRQ Statuses
        Bit 6: IRQ Status (Active Low)
        Bit 7: IRQ Enable Status
    Base Address + 7 (Write): IRQ Enable/Disable
        Bit 0-5: Respective Bank IRQ Enable/Disable

In this case, masking a bank will mask all 8 GPIO within that bank;
so ideally I want a way to only mask a bank when all GPIO are masked,
and unmasking when at least one is unmasked.

Are there existing ways to support these kinds of configuration in
regmap_irq?

William Breathitt Gray

--pKPDdkdohjMYUtPY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY3ZMgQAKCRC1SFbKvhIj
K0tkAP0W7qrriEL+8XcqAtlCtVo5jH3iXr0hCdlvBlQ0qGpsQwD/YE6KpyUdScEb
EpyPGmUgeR+FFhcDXh4ZxmnoBZXgWQE=
=EmJX
-----END PGP SIGNATURE-----

--pKPDdkdohjMYUtPY--
