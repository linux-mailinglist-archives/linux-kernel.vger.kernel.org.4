Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F496C1717
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjCTPLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjCTPLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:11:20 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902B930EAD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:06:20 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-544b959a971so195285367b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679324775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h7QKwmnDsultUs7P04JgZDKG6OgjB7qlJObVmRmggeo=;
        b=p49FRkUpa1onj861owxR+cbfkVnBlLbJtuZi5TZBnMJXSSaIbhf/VQNWrSWgdlU1pM
         0NyYbI3zjL8czjOnrV8W6ccHFFdPuz10pqO7O2q2cBZ86fDCnsE7jDPOtghpWBKEfH2f
         b91PuoXNuBsH5i7DpJGcougkcijNYEOqAxTSA5d2fkiZYOMSJvkJrd+n4h/kEziooN/e
         6j/LGmLE1nxkmnvlsZeWQZ07K2NARkAPyaRTceg9SzMnj8R9S3IbblvJYft79oh6gIvn
         orsW5tfj7HNYrnD6tJqd5CJvGCZKBAHxW1AtMFMdXnrrP6d2njA6qmFfFoxOp58jTI9y
         N6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679324775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7QKwmnDsultUs7P04JgZDKG6OgjB7qlJObVmRmggeo=;
        b=vnkkjRjz0F2qltx5/qp2OVgZIfFep50zuqZJRrm4uIsFK6n9d7Q135cUfu8AeKkwPw
         PRH6A+WGDuMt5mtIgdmiUFSxZp0IFtVL3Ia1PE/INYybE8/TZMo7FVkyn6bimbIow4XK
         QjyueNzVkU/emCAK+NcOYwfDNlaL8FZdo+iZoahgzynDhWwU0r8vQIVH6U+djb9LmUIX
         coMtdlR4P7s/KtOEB5DKXQzs2DnfMmfGEz6galZSOq489QLqbgGMfSklzI41mbiN+Rwh
         E8RRPRUvAO/nUX9TnTCy7lDviXh72OU3oVb9ONbiyEoEFIgP4uq9Uxe/pGLobF39PaH4
         SKBg==
X-Gm-Message-State: AO0yUKXeba+Coo06FZG3mQwDMGACE3X0YAPlvKi99CA0n2NY7dRJVVkB
        bdWUjZ2pDiIVCXaElGoKEX5Ktw==
X-Google-Smtp-Source: AK7set8F5wtPeeMQXBQuil2kSxCrxL1PD/6MVTUn5/U8lzeifvdg4qgj0Gb6Lc6I0cIT5qV3t9CCYQ==
X-Received: by 2002:a0d:dd86:0:b0:544:77f1:a0f3 with SMTP id g128-20020a0ddd86000000b0054477f1a0f3mr15939653ywe.37.1679324775631;
        Mon, 20 Mar 2023 08:06:15 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id i22-20020a05620a249600b0074411b03972sm6394896qkn.51.2023.03.20.08.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 08:06:04 -0700 (PDT)
Date:   Mon, 20 Mar 2023 11:03:32 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] bitfield: Introduce the FIELD_MODIFY() macro
Message-ID: <ZBh1xFkjAtZW6kaA@fedora>
References: <cover.1679149542.git.william.gray@linaro.org>
 <1c1492558c1a72b64bb26f7a44c4e69fff0e6b44.1679149543.git.william.gray@linaro.org>
 <7cd746c7b585c5086cfbd9db22414a060356cdd8.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vugPevjziSdHkgiz"
Content-Disposition: inline
In-Reply-To: <7cd746c7b585c5086cfbd9db22414a060356cdd8.camel@sipsolutions.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vugPevjziSdHkgiz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2023 at 09:50:35AM +0100, Johannes Berg wrote:
> On Sat, 2023-03-18 at 14:59 +0000, William Breathitt Gray wrote:
> > It is a common code pattern to modify a bitfield by masking the field
> > and performing a bitwise OR with the respective FIELD_PREP. Wrap such a
> > task into a macro by introducing FIELD_MODIFY() which modifies the field
> > specified by a mask from a bitfield by putting a val in the field.
>=20
> So I have no objection to adding this and you using FIELD_* macros, but
> just wanted to say that personally I've come to prefer the typed
> versions declared later in the fiel, and there we have
> <type>_replace_bits() already.
>=20
> Hmm. And now that I mentioned that, maybe that means FIELD_REPLACE()
> would be nicer as a name?
>=20
> johannes

Perhaps I can convert all of these FIELD_GET(), FIELD_MODIFY(), and
FIELD_GET() to the equivalent of u8_get_bits(), u8p_replace_bits(), and
u8_encode_bits(). If that works, then I'll just drop the FIELD_MODIFY()
patch in the v2 patchset submission.

William Breathitt Gray

--vugPevjziSdHkgiz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZBh1xAAKCRC1SFbKvhIj
KyfzAP4y6u/CyvcL+6NIZgavaoJSI9BCKLnRx+nR1KvhGcC8RwD/eXnjHRFHPLhG
WTSVwvraLRUk/0p/rf8R3oFrzkgehgQ=
=O7Vi
-----END PGP SIGNATURE-----

--vugPevjziSdHkgiz--
