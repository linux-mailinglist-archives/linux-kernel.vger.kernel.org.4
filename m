Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671295EDFF6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiI1PUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbiI1PUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:20:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02038367A7;
        Wed, 28 Sep 2022 08:20:11 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a26so27891706ejc.4;
        Wed, 28 Sep 2022 08:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=pwCDDK28hb4UpQ9revMHgiAyCCay8GdGw5zmTIcoydE=;
        b=Swj7MEub0tHXzYd254eVWgh6GFaf21nRP0b3EFineaG/+4iMWu6r/AB0aL8csLowGb
         SWp5thb6usJjxuEHh4JhU125GVKan98amLgCez2vJxi5qAUO1M741IvwIXIBn9R7sbo2
         2ubpjvsQHRMe2HGQSh1qDPthEgbUpe1UiTbkEg3OYFkiDTfD0MNp3tbjWTOVrgQVL8pO
         qvHFkZWIsy1sjUaJodGACNjINsAkaoqKz4f8NNnvTpdQPTkPVXzKE39fa2tTr3YyxGxD
         EoV84KpxWPWnsm+p0o0kZ4AsP9vTIpk2bFerBP5musM9wjQN1/A/9OBVSCW+p3Qj2+69
         sazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pwCDDK28hb4UpQ9revMHgiAyCCay8GdGw5zmTIcoydE=;
        b=aQn/tcoqjTEQJYBSLOAquv3OeCf0ARsMnYVJvvKZAzW+ImzaqoZPFH1X8WSTzL3jqN
         oXtyekd/jG6d6OH7Y6E+nBIwr+U519NpOMRENX0uijTxcd0VxWbOrXS1IYNfQoAb4rNE
         F6oetK3FcmKa1w4c8HVoafFzx8I7ZVRrLoNIH3ccESgPDfiPwVjBDTjBR4U8NCXB7lOm
         LCbleuz8FXR7GQsgX9q8ia2/5UbJyLJhgHroaOG8pZpRUbREDhPSOtWkcl5OVner0mF7
         gTW4k31O2HecA85bkr16uc4dvEOPCLYHdb4Yih2NCp1IVW1ZA+iF9PaluNAT/6AsyM1P
         HONA==
X-Gm-Message-State: ACrzQf0h0M6ZOCRSIOAGAGU5wh49UOBQuFiBQ5A/mFWCS86YFHuxyoqu
        hu3fSpAmkQrdjfNNW6z3cOU=
X-Google-Smtp-Source: AMsMyM541sOh1PNmwcIyAnfKJlAUue8FDXBMImQNQYHkpU0fCcMMa90x+UrygFkLYXvCbRnvAaWgjw==
X-Received: by 2002:a17:907:7704:b0:780:da38:4480 with SMTP id kw4-20020a170907770400b00780da384480mr27926393ejc.64.1664378410258;
        Wed, 28 Sep 2022 08:20:10 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id c10-20020a17090618aa00b0073dd1ac2fc8sm2544107ejf.195.2022.09.28.08.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:20:09 -0700 (PDT)
Date:   Wed, 28 Sep 2022 17:20:07 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 3/4] pwm: sysfs: Replace sprintf() with sysfs_emit()
Message-ID: <YzRmJ3mBKf+cvy5T@orome>
References: <20220826170716.6886-1-andriy.shevchenko@linux.intel.com>
 <20220826170716.6886-3-andriy.shevchenko@linux.intel.com>
 <YzQ9+Wzhfnila1s3@orome>
 <YzRO0xrzlrHAYdaI@smile.fi.intel.com>
 <YzRS+VIBK1AiysEN@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JxqEZzeMGAiL553x"
Content-Disposition: inline
In-Reply-To: <YzRS+VIBK1AiysEN@smile.fi.intel.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JxqEZzeMGAiL553x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 28, 2022 at 04:58:17PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 28, 2022 at 04:40:35PM +0300, Andy Shevchenko wrote:
> > On Wed, Sep 28, 2022 at 02:28:41PM +0200, Thierry Reding wrote:
> > > On Fri, Aug 26, 2022 at 08:07:15PM +0300, Andy Shevchenko wrote:
> > > > For sysfs outputs, it's safer to use a new helper, sysfs_emit(),
> > > > instead of the raw sprintf() & co. This patch replaces such a
> > > > sprintf() call straightforwardly with the new helper.
> >=20
> > > How exactly is sysfs_emit() safer here? In all of these cases, the
> > > values that sprintf() writes are the only values that are written into
> > > the buffer and we know that none of them exceed PAGE_SIZE. So the
> > > additional checks that sysfs_emit() performs are useless.
> >=20
> > This is a recommended way to use sysfs_emit() mentioned in Documentatio=
n.
> > Care to fix documentation?
>=20
> For your convenience, Documentation/filesystems/sysfs.rst says:
>=20
> - show() should only use sysfs_emit() or sysfs_emit_at() when formatting
>   the value to be returned to user space.

Took some digging to find enough information to convince me. Again, the
commit message says that sysfs_emit() is safer, but that's a bad reason
in this case because these cases are fine. The sprintf() calls that this
replaces aren't unbound and we're not appending to an existing seq_buf,
so nothing to worry on that front.

I think the better argument for broadly applying this is to specifically
distinguish the sysfs sprintf() calls from others so that they can be
auditioned better and perhaps help with the documentation[0].

Do you mind if I apply this with a reworded documentation?

Thierry

[0]: https://lore.kernel.org/all/20200930115740.GA1611809@kroah.com/

--JxqEZzeMGAiL553x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM0ZicACgkQ3SOs138+
s6FIIhAArw205w4uxXwsq07NNpibvRbb5AdiralmSNaS3NYlvKQFouEecCtUo+jW
XX85Abk1gRAmwGu2YZ75B4LS2ycEWlyMrUZfLtzfCx5C9iEwFdPYQiehPvo7TXLB
S1UeLx66CkkK2sn1a1wPw86+m4VwRdg0gwp/+iPMSLQZcjXiRwDMYrp/TcE0Ypow
Gzybn5IHgEG4KaFED+qLIp07pIuB0tjCa+djdb9mW6jUj/eNwHVbo1ByIxYd1hlY
1kRnmvwNegalLZDKl6etSKDnFnRyJJ7MftWF7gkcDDvaV7m0nWgfzHJyuC8ts58R
hHZbOGJ2aKyFQZIEOodmUL4ZkG+BcFqXulGhxVZEyQH9YPl8GkP8GpG0fwSgQkIh
cU+pemcjiwPP8/bee8R2L3zLfA+VNMV9l/KMetkBk91LgluIlqYJxwAg2f2thAc6
zLW9z9sOTWQPcFRb57oRxpTr0wNBiK8SgP33k0vEi7Cq7HNmaivyf/dQacbuN2RG
b8ZhFvBXOVpU2IZPaqucMOVtx+xR2zKVhnX5BA67BM6Ngjw/DAV7bObNjl+aXzyL
I568jwhN63lYPqEQRBUEElbpPHxzg18bNIzf+mcGOf86qG1IYXRT7KWJyKlDX+Ht
6ToMxbX9QI4o88uF45OiwrXRlqI9eYIxfzaAJ1jMVUcDz1t341w=
=vu6T
-----END PGP SIGNATURE-----

--JxqEZzeMGAiL553x--
