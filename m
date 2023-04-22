Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089B76EB998
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 16:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjDVOO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 10:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDVOO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 10:14:56 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B3DDB
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 07:14:54 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-b953887e70eso3719857276.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 07:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682172894; x=1684764894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+sOKQ3PfwhDuD4+Ila87Y+Ci1/sB2bzgwXKI2mv4y2g=;
        b=HLq553s7ZhHUb2GqduTHTIOqFVA6+aVDo+J7zdEtEY664MO7xq2UVsTtXYJPof/Efy
         jK7ESTcLe+4Kd+KB/t1krZ+Dq90PYvrpFAEzwoSlk3gRKcrFFHqGdbOVFXIFx4ktLahn
         jOTZGePFh7q6n28BP7WuZg5te/KMvb8qUGYq4SymdNlk4Fg7L10r8gwMkHFXafY8m2HA
         9FtzwqCCKnLrXA1xvyhul+bdsMmLV43FgpHdi0AXhLecv/jXXOhlVR7EABbElYc6+qyz
         m/TWFWTSJhOpblZbyYlITxCX7Ab5Ag8NcWDvYyophPdsOqNNiAajjrnoio3YgtIDNnd1
         vPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682172894; x=1684764894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sOKQ3PfwhDuD4+Ila87Y+Ci1/sB2bzgwXKI2mv4y2g=;
        b=PL6A2C9ms8gCSGCwyehRKgfwHxTjCV/g/+EgbXi+Ga4g70cHThyOCfp4coTOQWtdDv
         pcnYfrguaWRaxlo4Mw7e3jbdFNgy9A44A/RVCEMJc/dUdr7bKaTvMOFbgNq1nrQtZeBF
         NH2m+Bo/mITlyuKGmQ4fB+Vb1iqA5D+e8fWINv4lt/s1HADfbsJ1Or4YokUV/hW10BXP
         KBowH+gE/X2414WOPNzLvO0o1nARISYIm3ann14cEiYFfDjQo4RB3Jg2T5/Mrel6xLer
         jgYswq0tQoMHNd+g8uFxETUFFwwKPXjV8B7ZHKxazFsFDY/phN1RvfIdfVctWkejhcFZ
         9aSQ==
X-Gm-Message-State: AAQBX9e8mhZx2hktgjv02FqGQHLwvzn5yADdVBjOVW2pgkRvofzMhuGj
        J5PM1nsIoc5mIVEPqFz4PjiGhA==
X-Google-Smtp-Source: AKy350ZJwkdCpgzh5pS7Y6zEo42AOvALq/XR1dMjNeacAemVpLB1+4JKqrDp8ZQx9+6KtY8QbWbqjA==
X-Received: by 2002:a25:d013:0:b0:b8f:54c8:9b52 with SMTP id h19-20020a25d013000000b00b8f54c89b52mr5663048ybg.51.1682172894154;
        Sat, 22 Apr 2023 07:14:54 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id a200-20020a0dd8d1000000b0054c19f4d6d2sm1644425ywe.29.2023.04.22.07.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 07:14:53 -0700 (PDT)
Date:   Sat, 22 Apr 2023 10:14:51 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     rongtao@cestc.cn, open list <linux-kernel@vger.kernel.org>,
        "open list:COUNTER SUBSYSTEM" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] tools/counter: Add .gitignore
Message-ID: <ZEPr21ayW2zL8fc+@fedora>
References: <tencent_1625E21562D40C91CEE047E82E2BFC524305@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qfAJjaKkJAiWX0Xf"
Content-Disposition: inline
In-Reply-To: <tencent_1625E21562D40C91CEE047E82E2BFC524305@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qfAJjaKkJAiWX0Xf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 21, 2023 at 07:52:52PM +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
>=20
> Ignore counter_example and include directory.
>=20
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  tools/counter/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
>  create mode 100644 tools/counter/.gitignore
>=20
> diff --git a/tools/counter/.gitignore b/tools/counter/.gitignore
> new file mode 100644
> index 000000000000..e1f34db02a91
> --- /dev/null
> +++ b/tools/counter/.gitignore
> @@ -0,0 +1,2 @@
> +/counter_example
> +/include/

In the future, we may want to track files in the include directory.
Instead, have .gitignore explicitly ignore the files we're not tracking
(i.e. /include/linux/counter.h).

William Breathitt Gray

> --=20
> 2.39.1
>=20

--qfAJjaKkJAiWX0Xf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZEPr2wAKCRC1SFbKvhIj
K5L0AP9Ss4mEutzRdoVMhT3T5PqmpyKLD4G4fm4+OytHcbi9QQD+OpaCi5l9lzgk
6Z0euviXvO0GtEPQ502Fram86Z6J0QQ=
=1iyw
-----END PGP SIGNATURE-----

--qfAJjaKkJAiWX0Xf--
