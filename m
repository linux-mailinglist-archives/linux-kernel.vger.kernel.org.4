Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC90C617522
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 04:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiKCDig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 23:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiKCDib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 23:38:31 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F15815717
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 20:38:29 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-13bd2aea61bso913328fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 20:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WZCgXgFOCXchp8R83LT2Psxd0H5ojiq9RKAiaEDfp4g=;
        b=kMHQ0ApyeUDXl9RotzmpyqCRGjKiWf/RyJGnk9YXfoidwX4eJqBA8VZIQw1UbxUYQv
         APtxVSUeD7XpsPfp3R8LiGj/AMKbypg8z3NyDkU71qqCMMmQXB2TBxmRSuotsqOuYpHD
         dnVCBQFjBABT7VdGYfraWry95YcyKJ5OBTPbYOuU6sbw/0UrPk5VVPviq6A4dN9wp3gW
         e8BgMHa2Ciaj0STPQh1ojQLRtRdkrRgTnoRNmLYQRbaSVZ1AJnvm3/3Tn620LColIsyR
         wewfy0sNX2F9QLx0et5tLcE4VBQTWemb5hR7E9igkDmtUPoLuS1kGEv1s9lRUxKhtMsY
         9Yaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZCgXgFOCXchp8R83LT2Psxd0H5ojiq9RKAiaEDfp4g=;
        b=tQMnKcP8xP0BbUUiYpRTJcw/r18J92AemO6yuhLmTCAlehkqBOPK+BR9WiKZFLZ7wy
         yJy1NYasNrp84ilUVhGuEk7LxOfSXAbCaPGdkAumqMIg3N7uPJ00EXRyMQQrt6OW/O9S
         hSXOYCDa724uza09X5sCP8O1Qw7v4Yes/Pj10wgAo+aOK2uP/nawzOFqKekcZm2I44f4
         nc6Zcgd3QqvtefhG6C0AVvSdVvAxlYyvcNsiMrMthSNzGiK+xcFK1PiGHdRZ+IGD4nro
         UgkuUPCFCeele4V/s8w/N5cqo9QlszhJi4O5FhD1+Sjtgy8dg0DUH8v63gR+rA755rxe
         X8cA==
X-Gm-Message-State: ACrzQf2iQgjaL0r9yCM1qsTlZo3Pd8wxc9nkUSxWn3m6dnYBpH103+2w
        M6FvqNO5AerdDBwBMmPyFfhVGw==
X-Google-Smtp-Source: AMsMyM45S18LPBafWNbSrGc/eyKxtL/gexeI4ZqG8G6Zfie2F25d9ctK+K59+on4ZwFG9B1UFgzZJQ==
X-Received: by 2002:a05:6870:ac0d:b0:13b:b9e7:e6d0 with SMTP id kw13-20020a056870ac0d00b0013bb9e7e6d0mr25323926oab.17.1667446708749;
        Wed, 02 Nov 2022 20:38:28 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id n17-20020a05680803b100b00354978180d8sm5247824oie.22.2022.11.02.20.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 20:38:27 -0700 (PDT)
Date:   Wed, 2 Nov 2022 23:38:24 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, linux-iio@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Julien Panis <jpanis@baylibre.com>,
        David Lechner <david@lechnology.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/4] counter: Adjust final parameter type in function and
 signal callbacks
Message-ID: <Y2M3sGLdrL3uHU8X@fedora>
References: <20221102172217.2860740-1-nathan@kernel.org>
 <202211021216.FF49E84C69@keescook>
 <Y2LR13xrrauVmeXP@dev-arch.thelio-3990X>
 <202211021621.34241DC39@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Z/0j4y7TVYG4hdqA"
Content-Disposition: inline
In-Reply-To: <202211021621.34241DC39@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Z/0j4y7TVYG4hdqA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 02, 2022 at 04:22:32PM -0700, Kees Cook wrote:
> On Wed, Nov 02, 2022 at 01:23:51PM -0700, Nathan Chancellor wrote:
> > On Wed, Nov 02, 2022 at 12:21:23PM -0700, Kees Cook wrote:
> > > On Wed, Nov 02, 2022 at 10:22:14AM -0700, Nathan Chancellor wrote:
> > > > The ->signal_u32_read(), ->count_u32_read(), and ->count_u32_write()
> > > > callbacks in 'struct counter_comp' expect the final parameter to ha=
ve a
> > > > type of 'u32' or 'u32 *' but the ops functions that are being assig=
ned
> > > > to those callbacks have an enumerated type as the final parameter. =
While
> > > > these are compatible from an ABI perspective, they will fail the
> > > > aforementioned CFI checks.
> > > >=20
> > > > Adjust the type of the final parameter in the ->signal_read(),
> > > > ->function_read(), and ->function_write() callbacks in 'struct
> > > > counter_ops' and their implementations to match the prototypes in
> > > > 'struct counter_comp' to clear up these warnings and CFI failures.
> > >=20
> > > I don't understand these changes. Where do 'struct counter_comp'
> > > and 'struct counter_ops' get confused? I can only find matching
> > > ops/assignments/calls, so I must be missing something. This looks like
> > > a loss of CFI granularity instead of having wrappers added if there is
> > > an enum/u32 conversion needed somewhere.
> >=20
> > Right, I am not the biggest fan of this change myself and it is entirely
> > possible that I am misreading the warnings from the commit message but I
> > do not see how
> >=20
> >         comp_node.comp.signal_u32_read =3D counter->ops->signal_read;
> >=20
> > and
> >=20
> >         comp_node.comp.count_u32_read =3D counter->ops->function_read;
> >=20
> > in counter_add_watch(),
> >=20
> >         comp.signal_u32_read =3D counter->ops->signal_read;
> >=20
> > in counter_signal_attrs_create(), and
> >=20
> >         comp.count_u32_read =3D counter->ops->function_read;
> >         comp.count_u32_write =3D counter->ops->function_write;
> >=20
> > in counter_count_attrs_create() are currently safe under kCFI, since the
> > final parameter type of the prototypes in 'struct counter_ops' does not
> > match the final parameter type of the prototypes in 'struct
> > counter_comp'. I would expect the indirect calls in counter_get_data()
> > and counter_comp_u32_show() to fail currently.
> >=20
> > I briefly looked at making the 'struct counter_comp' callbacks match the
> > 'struct counter_ops' ones but the COUNTER_COMP macros in
> > include/linux/counter.h made it seem like these callbacks might be used
> > by implementations that might use different enumerated types as the
> > final parameter. I can look a little closer to see if we can make
> > everything match.
> >=20
> > I am not sure how wrappers would work here, I can take a look into how
> > feasible that is.
>=20
> How about this? (I only did signal_read -- similar changes are needed
> for function_read and function_write:

The reason for the u32 type is that all the Counter enum components can
make use of the same *_u32_read/*_u32_write calls; in other words, we
don't have to handle each Counter enum read/write as unique.

If you want to get rid of that design, then you'll need to create
respective code paths for each Counter enum. See the comments inline
below.

>=20
> diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-c=
hrdev.c
> index 80acdf62794a..cb391b2498a6 100644
> --- a/drivers/counter/counter-chrdev.c
> +++ b/drivers/counter/counter-chrdev.c
> @@ -38,6 +38,7 @@ struct counter_comp_node {
>  	a.device_u32_read =3D=3D b.device_u32_read || \
>  	a.count_u32_read =3D=3D b.count_u32_read || \
>  	a.signal_u32_read =3D=3D b.signal_u32_read || \
> +	a.signal_read =3D=3D b.signal_read || \
>  	a.device_u64_read =3D=3D b.device_u64_read || \
>  	a.count_u64_read =3D=3D b.count_u64_read || \
>  	a.signal_u64_read =3D=3D b.signal_u64_read || \
> @@ -54,6 +55,7 @@ struct counter_comp_node {
>  	comp.device_u32_read || \
>  	comp.count_u32_read || \
>  	comp.signal_u32_read || \
> +	comp.signal_read || \
>  	comp.device_u64_read || \
>  	comp.count_u64_read || \
>  	comp.signal_u64_read || \
> @@ -320,7 +322,7 @@ static int counter_add_watch(struct counter_device *c=
onst counter,
>  			return -EINVAL;
> =20
>  		comp_node.comp.type =3D COUNTER_COMP_SIGNAL_LEVEL;
> -		comp_node.comp.signal_u32_read =3D counter->ops->signal_read;
> +		comp_node.comp.signal_read =3D counter->ops->signal_read;
>  		break;
>  	case COUNTER_COMPONENT_COUNT:
>  		if (watch.component.scope !=3D COUNTER_SCOPE_COUNT)
> @@ -530,6 +532,7 @@ static int counter_get_data(struct counter_device *co=
nst counter,
>  	const size_t id =3D comp_node->component.id;
>  	struct counter_signal *const signal =3D comp_node->parent;
>  	struct counter_count *const count =3D comp_node->parent;
> +	enum counter_signal_level level =3D 0;
>  	u8 value_u8 =3D 0;
>  	u32 value_u32 =3D 0;
>  	const struct counter_comp *ext;
> @@ -569,8 +572,8 @@ static int counter_get_data(struct counter_device *co=
nst counter,
>  			ret =3D comp->device_u32_read(counter, &value_u32);
>  			break;
>  		case COUNTER_SCOPE_SIGNAL:
> -			ret =3D comp->signal_u32_read(counter, signal,
> -						    &value_u32);
> +			ret =3D comp->signal_read(counter, signal, &level);
> +			value_u32 =3D level;

This code path is for all Counter enum types currently; changing
signal_u32_read to signal_read here will work for
COUNTER_COMP_SIGNAL_LEVEL but break all the other Counter Signal enum
types. Instead, you should duplicate this code with proper adjustments
for each of the Counter enums in their own respective case blocks.

>  			break;
>  		case COUNTER_SCOPE_COUNT:
>  			ret =3D comp->count_u32_read(counter, count, &value_u32);
> diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sy=
sfs.c
> index b9efe66f9f8d..07ce2543b70d 100644
> --- a/drivers/counter/counter-sysfs.c
> +++ b/drivers/counter/counter-sysfs.c
> @@ -170,6 +170,7 @@ static ssize_t counter_comp_u32_show(struct device *d=
ev,
>  	const struct counter_attribute *const a =3D to_counter_attribute(attr);
>  	struct counter_device *const counter =3D counter_from_dev(dev);
>  	const struct counter_available *const avail =3D a->comp.priv;
> +	enum counter_signal_level level =3D 0;
>  	int err;
>  	u32 data =3D 0;
> =20
> @@ -178,7 +179,8 @@ static ssize_t counter_comp_u32_show(struct device *d=
ev,
>  		err =3D a->comp.device_u32_read(counter, &data);
>  		break;
>  	case COUNTER_SCOPE_SIGNAL:
> -		err =3D a->comp.signal_u32_read(counter, a->parent, &data);
> +		err =3D a->comp.signal_read(counter, a->parent, &level);
> +		data =3D level;

Same issue as comment above: Counter Signal enums besides
COUNTER_COMP_SIGNAL_LEVEL are possible.

>  		break;
>  	case COUNTER_SCOPE_COUNT:
>  		if (a->comp.type =3D=3D COUNTER_COMP_SYNAPSE_ACTION)
> @@ -842,7 +844,7 @@ static int counter_signal_attrs_create(struct counter=
_device *const counter,
> =20
>  	/* Create main Signal attribute */
>  	comp =3D counter_signal_comp;
> -	comp.signal_u32_read =3D counter->ops->signal_read;
> +	comp.signal_read =3D counter->ops->signal_read;
>  	err =3D counter_attr_create(dev, cattr_group, &comp, scope, signal);
>  	if (err < 0)
>  		return err;
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index c41fa602ed28..3f1516076f20 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -169,6 +169,9 @@ struct counter_comp {
>  				      struct counter_count *count, u32 *val);
>  		int (*signal_u32_read)(struct counter_device *counter,
>  				       struct counter_signal *signal, u32 *val);
> +		int (*signal_read)(struct counter_device *counter,
> +				   struct counter_signal *signal,
> +				   enum counter_signal_level *level);
>  		int (*device_u64_read)(struct counter_device *counter,
>  				       u64 *val);
>  		int (*count_u64_read)(struct counter_device *counter,
>=20
> --=20
> Kees Cook

I'm not familiar with kCFI, but a better solution if possible would be
to hint to the compiler the intention of the code here -- that we're
intentionally type punning the last parameter in order to avoid
duplicate code for each Counter enum because they are all handled the
same way.

William Breathitt Gray

--Z/0j4y7TVYG4hdqA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY2M3sAAKCRC1SFbKvhIj
KyvXAP9PjHF2SFAGlc8+ZSJ83BGSWxiZaBEOozlM9Ub5fcInswD/cVEJDMoOq4d+
8CYtwzAOKsqb7/lAIVWiVaEkA9STCQM=
=FgB+
-----END PGP SIGNATURE-----

--Z/0j4y7TVYG4hdqA--
