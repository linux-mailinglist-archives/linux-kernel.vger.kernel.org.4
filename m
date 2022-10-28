Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388CC61121B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiJ1NBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiJ1NBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:01:07 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB62A5755E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:01:06 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s196so4780317pgs.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cj+cFSWB3bhdp7XduUn/4e2RygvL5XBdKHCLMG1Ezq8=;
        b=O6DaBoYnrcEcnm5eNCgvLRdsvuRtP7sVUc53dIggCP1DPm/qe0sU0YU3hry8fF88Lk
         90/QvKXOpeYgxtHvLnr1urLL7z1Hj5U57/qK+4GHnxieBr7sTcDfp/7APxH1CHZJ8A/W
         7eU3z+sn87mU6P2hb1J1skJpForlSSu1Y9FtryeAC7xUgWnyBJGf3fzK6ZTrBswAPmQB
         Qeox2vWn2h7ltJbf+DvHMUAqRTMcC82Y8VMgMWocKvP8xQggaln1KxANCQ+96g49HyA+
         9DKFsZCTQwn2Ax9kdfL/Vv/EmpQj46mrlAMA6MmY1x5msu3/bRBM9ZTXoqe7VZpz6zQ7
         tQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cj+cFSWB3bhdp7XduUn/4e2RygvL5XBdKHCLMG1Ezq8=;
        b=qAfNMUaS5EWxAwkBVaWyGMbrKB3vMnk60f1247aqOXWin2Q+oSelDNIohyRVkTNenH
         Ny0X6njJ3cvm/D3vGWwpvX2TDWlUMp5LvzGY65ezacBf+Tm0HwJdNpEJRtGOdgTQhQqi
         uJXSi/lIXP6UuJBQ0pP7BOGtg8plbw01y0Lf/4Wa1X2mgeBixy8OqCp26kpJGLCuMfqG
         5QN9s81rdruhYPti6yuP8uuPfc1DnCQbMz2vyUzTGCffgsBCOHxDWEL+ZHol2/bIC6ju
         cncsdJnnlgkOJN7ZsyGgGsx+Wv4fQICu3znIKveF03UekYh021KJq01X3k5DNJRDhsxU
         MJNg==
X-Gm-Message-State: ACrzQf29moXx7kCjqeLhlzdpfDV6iVt9mYVw83Un8xdFwbXW0yUA27ti
        H5tQ5xFosWqCFWhHW4O2CpHa8+rZYeDKdp4D
X-Google-Smtp-Source: AMsMyM6LSRa1cWipx9sEb0JvczrXkVEj0/vqjDyiNWRWZcl9wt128WQw5AkN25ESjk4UgWXRc/bnBQ==
X-Received: by 2002:a05:6a00:1348:b0:56b:f5c0:1d9d with SMTP id k8-20020a056a00134800b0056bf5c01d9dmr23236578pfu.45.1666962065722;
        Fri, 28 Oct 2022 06:01:05 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-72.three.co.id. [180.214.233.72])
        by smtp.gmail.com with ESMTPSA id n11-20020a17090a394b00b0020d45a155d9sm4181687pjf.35.2022.10.28.06.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 06:01:05 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 77EF810030A; Fri, 28 Oct 2022 20:01:01 +0700 (WIB)
Date:   Fri, 28 Oct 2022 20:01:01 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH] m68k: mac: Reword comment using double "in"
Message-ID: <Y1vSjQfkDfPINUBo@debian.me>
References: <0229879ee3e2d8828707d291cddbb89ac18a10c2.1666945731.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ANg38O8+lLGM5VLB"
Content-Disposition: inline
In-Reply-To: <0229879ee3e2d8828707d291cddbb89ac18a10c2.1666945731.git.geert@linux-m68k.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ANg38O8+lLGM5VLB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2022 at 10:30:26AM +0200, Geert Uytterhoeven wrote:
> People keep on sending (incorrect) patches to remove the second
> occurrence of the word "in".  Reword the comment to stop the inflood.
>=20

Ah! People who aren't fluent in English think that duplicated "in" below
isn't OK, which after stripping that become nonsense without reading the
actual code.

> Suggested-by: Michael Schmitz <schmitzmic@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> To be queued in the m68k branch for v6.2.

Should this patch be Cc: stable'ed so that no more trivial patches as
you mentioned?

>=20
>  arch/m68k/mac/misc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
> index 4fab3479175865d4..c7cb29f0ff016360 100644
> --- a/arch/m68k/mac/misc.c
> +++ b/arch/m68k/mac/misc.c
> @@ -126,7 +126,7 @@ static void via_rtc_send(__u8 data)
> =20
>  	reg =3D via1[vBufB] & ~(VIA1B_vRTCClk | VIA1B_vRTCData);
> =20
> -	/* The bits of the byte go in in MSB order */
> +	/* The bits of the byte go into the RTC in MSB order */
> =20

LGTM, thanks.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--ANg38O8+lLGM5VLB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY1vSjQAKCRD2uYlJVVFO
oyl/AQCne+PlmVryq56xblbXyNvF0nK68wyPIgtQsuuVuAffqgD9HImvqkpYnVhU
JHDcJ8W1xI/YfhNBJO7wcrEhDt0+nAw=
=9DZc
-----END PGP SIGNATURE-----

--ANg38O8+lLGM5VLB--
