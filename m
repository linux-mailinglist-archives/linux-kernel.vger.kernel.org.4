Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0926C8154
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjCXPfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjCXPfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:35:31 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25553E057
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:35:07 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-54184571389so39639677b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679672106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cit55CUjU58GshHnPftuk6box9yTHYhOt3pQ8Q8rdLE=;
        b=KZJkjna7k/X1TGqk6FYZ2yPaKYuZvZiAkBynkUcoxqPEYRazzDHuQFXDPIZccsYuWJ
         XJ4wyVRojdHmZoAYbJqAI69OgwWCg5bOXJf+824wfpC0gyzYgWLuwEYDDWIudCUMuB6b
         L8w0dkEKfcl/NTe8G9IcZjHX6xRx9B4cY6kcnW84dzjx39CCGfE+i/c/eXDPCc/yc3/i
         F+jRpwYsHXMug0XIOb7xqj5UDMdkR/zQdoy4nw6dveGVii3iif+e88KcTGRKAb/IyctY
         0wWf++S+ZEyybRIDAGql6c4bDRL6ckHu07Bt0WXhJAjrM8Dvlmi9aqipIUGgohgKBRXZ
         4Y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679672106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cit55CUjU58GshHnPftuk6box9yTHYhOt3pQ8Q8rdLE=;
        b=yhg3aBbDz23mXOlCIcWdhNeOtjXBt3EzDADKqF8YGF/Mp72IPeqQ9zCF7q+OBYP4Cc
         K/qc8Z4ElXU0EnxmFsMbm6qHMSswhpPGZxuvSHuKfkZZ4KbPD1Cjt7esmM5PX0Zka2Ha
         0huU82aEJyDZJK6M6eXBAqAOod5sMz3bnGHK+0DrK8UXpVgMYqvzL34yRhOcxfsvFtAK
         7XzCJNAqEwdUNn/iIkWqzAlXe2oZAbvy6Lw16kKfsFW1whcaX9PEu5B5QB/P5k1n9BRA
         7Yqr/xwQenfFGyhXXcEeEeL7mQh03oh33m7GojBBE9RvpcRDfeqYf69hONIF4ic5gHpm
         pLWQ==
X-Gm-Message-State: AAQBX9eDLEUoDYxqBU4WA2PxQYehJpK+QSXDHJDdwvgwsNNeAP8TMW09
        PaifJkNrJnb8kPfU782CQwtnxEBmFp9KiR2PtR6BMg==
X-Google-Smtp-Source: AKy350aHJ1exqUT3VW+t6sElKSDIePYATo1ZDMaDjHCWoDZJTROkrtzhUMcxbIV12/FC+QrPqeyJYA==
X-Received: by 2002:a0d:c401:0:b0:541:8b0f:caa9 with SMTP id g1-20020a0dc401000000b005418b0fcaa9mr2284447ywd.31.1679672106188;
        Fri, 24 Mar 2023 08:35:06 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id 137-20020a81128f000000b00545a081848bsm463539yws.27.2023.03.24.08.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 08:35:05 -0700 (PDT)
Date:   Fri, 24 Mar 2023 11:35:02 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Johannes Berg <johannes.berg@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] counter: 104-quad-8: Refactor to buffer states
 for CMR, IOR, and IDR
Message-ID: <ZB3DJjQLa48AodSD@fedora>
References: <cover.1679605919.git.william.gray@linaro.org>
 <c5adb13b4b0887beb1df40b34d2ef03d63a2860d.1679605919.git.william.gray@linaro.org>
 <ZB2OG4zZXsqqyN8v@smile.fi.intel.com>
 <ZB2Ob9VGe3GoEVko@smile.fi.intel.com>
 <ZB2k9m7rL7Hpy/zU@fedora>
 <ZB2qI7k/Igws5khg@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SdN1MVy4I4UAX10+"
Content-Disposition: inline
In-Reply-To: <ZB2qI7k/Igws5khg@smile.fi.intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SdN1MVy4I4UAX10+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2023 at 03:48:19PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 24, 2023 at 09:26:14AM -0400, William Breathitt Gray wrote:
> > On Fri, Mar 24, 2023 at 01:50:07PM +0200, Andy Shevchenko wrote:
> > > On Fri, Mar 24, 2023 at 01:48:43PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Mar 23, 2023 at 05:25:28PM -0400, William Breathitt Gray wr=
ote:
>=20
> ...
>=20
> > > > > +static void quad8_control_register_update(struct quad8 *const pr=
iv, u8 *const buf,
> > > > > +					  const size_t channel, const u8 val, const u8 field)
> > > > > +{
> > > > > +	u8p_replace_bits(&buf[channel], val, field);
> > > > > +	iowrite8(buf[channel], &priv->reg->channel[channel].control);
> > > > > +}
> > > >=20
> > > > How did you compile this?
> > > > Due to nature of *_replace_bits() this may only be a macro.
> > > >=20
> > > > That's what LKP is telling about I think.
> > >=20
> > > Ah, no, that's because the last parameter is not constant in the last=
 patch in
> > > the series.
>=20
> > I'm having trouble cross-compiling for riscv, but I'm unable to recreate
> > the build error when I compile for x86_64. However, I'd like to
> > understand this error so I can fix it properly.
> >=20
> > Is the problem here due to the "const u8 field" parameter? Instead of a
> > constant variable, does this need to be a constant literal value for
> > u8p_replace_bits()? I don't think that parameter changed in the last
> > patch of the series, so why is the build error occurring for the last
> > patch and not this penultimate patch here?
>=20
> Good question. Perhaps my understanding is incorrect.
>=20
> > Would qualifying the
> > quad8_control_register_update() function with "__always_inline" resolve
> > this issue?
>=20
> Hmm... Don't know. You can always download a toolchain specifically build=
 for
> building kernels: https://mirrors.edge.kernel.org/pub/tools/crosstool/.
>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

I tried to build using crosstools, so I followed the reproduce sequence
=66rom the kernel test robot message: download make.cross, fetch branch
and checkout commit, and then I executed the following (I'm on an arm64
system):

        URL=3Dhttps://cdn.kernel.org/pub/tools/crosstool/files/bin/arm64 CO=
MPILER_INSTALL_PATH=3D$HOME/Projects/Linux/testwilliam/0day COMPILER=3Dgcc-=
12.1.0 ../make.cross W=3D1 O=3Dbuild_dir ARCH=3Driscv olddefconfig
        URL=3Dhttps://cdn.kernel.org/pub/tools/crosstool/files/bin/arm64 CO=
MPILER_INSTALL_PATH=3D$HOME/Projects/Linux/testwilliam/0day COMPILER=3Dgcc-=
12.1.0 ../make.cross W=3D1 O=3Dbuild_dir ARCH=3Driscv SHELL=3D/bin/bash dri=
vers/

I encountered the following errors regarding GCC plugins:

        cc1: error: cannot load plugin ./scripts/gcc-plugins/randomize_layo=
ut_plugin.so: ./scripts/gcc-plugins/randomize_layout_plugin.so: undefined s=
ymbol: _ZN8opt_pass14set_pass_paramEjb
        cc1: error: cannot load plugin ./scripts/gcc-plugins/latent_entropy=
_plugin.so: ./scripts/gcc-plugins/latent_entropy_plugin.so: undefined symbo=
l: _ZN8opt_pass14set_pass_paramEjb
        cc1: error: cannot load plugin ./scripts/gcc-plugins/randomize_layo=
ut_plugin.so: ./scripts/gcc-plugins/randomize_layout_plugin.so: undefined s=
ymbol: _ZN8opt_pass14set_pass_paramEjb
        make[2]: *** [../scripts/Makefile.build:252: scripts/mod/empty.o] E=
rror 1
        cc1: error: cannot load plugin ./scripts/gcc-plugins/latent_entropy=
_plugin.so: ./scripts/gcc-plugins/latent_entropy_plugin.so: undefined symbo=
l: _ZN8opt_pass14set_pass_paramEjb

I'm not quite sure how to resolve that plugin issue, but regardless I
continued investigating the original build error reported by the kernel
test robot.

There are eight calls to quad8_control_register_update() in 104-quad-8:

        quad8_control_register_update(priv, priv->idr, id, DISABLE_INDEX_MO=
DE, INDEX_MODE);
        quad8_control_register_update(priv, priv->cmr, id, mode_cfg, QUADRA=
TURE_MODE);
        quad8_control_register_update(priv, priv->ior, event_node->channel,=
 flg_pins, FLG_PINS);
        quad8_control_register_update(priv, priv->idr, channel_id, index_po=
larity, INDEX_POLARITY);
        quad8_control_register_update(priv, priv->idr, channel_id, synchron=
ous_mode, INDEX_MODE);
        quad8_control_register_update(priv, priv->cmr, count->id, count_mod=
e, COUNT_MODE);
        quad8_control_register_update(priv, priv->ior, count->id, enable, A=
B_GATE);
        quad8_control_register_update(priv, priv->ior, count->id, !preset_e=
nable, LOAD_PIN);

The field arguments for these calls are all preprocessor defines:

        #define INDEX_MODE BIT(0)
        #define QUADRATURE_MODE GENMASK(4, 3)
        #define FLG_PINS GENMASK(4, 3)
        #define INDEX_POLARITY BIT(1)
        #define COUNT_MODE GENMASK(2, 1)
        #define AB_GATE BIT(0)
        #define LOAD_PIN BIT(1)

Removing the duplicates, we get the following four field masks:

        BIT(0)
        BIT(1)
        GENMASK(2, 1)
        GENMASK(4, 3)

I don't think there's a problem with these masks (unless there's
something broken in the BIT() or GENMASK() implementations for riscv) so
I'm suspecting something is wrong in bitfields.h. Here's the relevant
function:

        extern void __compiletime_error("bad bitfield mask")
        __bad_mask(void);
        static __always_inline u64 field_multiplier(u64 field)
        {
        	if ((field | (field - 1)) & ((field | (field - 1)) + 1))
        		__bad_mask();
        	return field & -field;
        }

If I compute the conditional check by hand, it evaluates to false for
all four possible field masks. Is it possible the compiler is ignoring
the if statement evaluation and attempting the __bad_mask() compilation
regardless of the field passed in?

William Breathitt Gray

--SdN1MVy4I4UAX10+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZB3DJgAKCRC1SFbKvhIj
KwNvAQDPISHW5wBfP+llsJByQcYGcT54LInfCmGzX4By5hiNTAEAtwkj0b3JK8pE
pRXOES9WDuZFqyVVT0cFnArND8r8VgY=
=ghod
-----END PGP SIGNATURE-----

--SdN1MVy4I4UAX10+--
