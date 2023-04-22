Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7EB6EB996
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 16:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjDVOMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 10:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjDVOMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 10:12:05 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD631FFB
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 07:12:01 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-b996127ec71so211228276.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 07:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682172720; x=1684764720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=echBn7wOteUGSvtvbbIPzPQfMb+BgnJ2zmTl6mo0nEs=;
        b=yRQs6YJx7F7rLwT8JmhecHlL87pLGlDJNq+KV4Ukn0l7ZbNHwioKf1VNq4zReAwN5J
         v2ULTDkSVEqAXsehky5jGM5E4vIXailIn+ZyVCD9cyNrOxVC+vSmjXRB7o+5ZuxQFCwu
         WzFaSKgfXYV3mEkDbgvyShv+dol26PcmMS9Fv1NbExzaniy4jhgKQ6C1YvgA2rfzazJd
         c4wglvPOutYBW+kIVQPXMr2aCGb6LOa17hsbzg88xd/Mkg/ftl4mPh07uvkcoh5LeSGY
         J8hElC/c6m5cs2+exoF2UpORbYQgx1TDi/7h93RDRKiuJhbAiq7tWLY9KnduVe2y4wQJ
         bYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682172720; x=1684764720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=echBn7wOteUGSvtvbbIPzPQfMb+BgnJ2zmTl6mo0nEs=;
        b=KnrF5sQXLFdDkmPymcctB7zf1yuh6B3VdGL8DwgtDZwsY3aqBACqAiMZtl9WLPrceL
         GYsm+RbgRAJir+YvDh80hBicl2h4vKoLwgXezumaT+iBlvfKID+mcWSxQVVrZRpYWfqB
         dgkFbmkovZ9zKKxboQnGgGaP6w+ZrOkByqTw9hOFIaYDlHUwjQQapLURjcgubIefCWbr
         F05IHVoNaRYddK+kXj6aOaSLPSva+2JN/zGTiX6u7+UQ6MoDK9vKirYSM564e4UVVbqQ
         JjyH+Chho5bd6wXRh39FK8ErVI++lGeXAlm1f2mQ/Mvr6mcXqGENBWCDkZ8vh2YdnPm4
         ZdGQ==
X-Gm-Message-State: AAQBX9fr7TZvcjPp9I4dUPlSqTN+DTpnNSl0xiGohBsV4taTZ56YPIwM
        d4mYHlC3JqSXywOOv81s/ss38oMr2tTMr7PNBto=
X-Google-Smtp-Source: AKy350YqtGTSvC+cu6tMEqnxr6ICc/ivHZeX2OhqXJHIPlioPorVvceCeEFZDheM5Apu/X0ZM/uo7Q==
X-Received: by 2002:a25:428b:0:b0:b92:5d8d:aa77 with SMTP id p133-20020a25428b000000b00b925d8daa77mr5169680yba.18.1682172720576;
        Sat, 22 Apr 2023 07:12:00 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id 144-20020a250496000000b00b8f09a8f4f5sm1639005ybe.46.2023.04.22.07.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 07:11:59 -0700 (PDT)
Date:   Sat, 22 Apr 2023 10:11:57 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     rongtao@cestc.cn,
        "open list:COUNTER SUBSYSTEM" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/counter: Makefile: Remove useless 'include' when
 make clean
Message-ID: <ZEPrLfRajOjhv52l@fedora>
References: <tencent_FA682F628E818DD04B96C3E5A94ACFABE206@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PalkCyC95nRJfXq7"
Content-Disposition: inline
In-Reply-To: <tencent_FA682F628E818DD04B96C3E5A94ACFABE206@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PalkCyC95nRJfXq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rong,

This is a nitpick, but I think the word "lingering" is better than
"useless" for the title.

On Fri, Apr 21, 2023 at 07:47:25PM +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
>=20
> 'make' create 'include' directory, we should remove it when 'make clean'.

There are a few typos here, so I think you mean something like this:

    'make' creates the 'include' directory, so we should remove it on
    'make clean'.

>=20
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  tools/counter/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/counter/Makefile b/tools/counter/Makefile
> index 8843f0fa6119..e2475a1f10d8 100644
> --- a/tools/counter/Makefile
> +++ b/tools/counter/Makefile
> @@ -39,7 +39,7 @@ $(OUTPUT)counter_example: $(COUNTER_EXAMPLE)
> =20
>  clean:
>  	rm -f $(ALL_PROGRAMS)
> -	rm -rf $(OUTPUT)include/linux/counter.h
> +	rm -rf $(OUTPUT)include

The Makefile actually first creates the 'include/linux' directory via
the `mkdir -p` command, and then creates a symbolic link for
'include/linux/counter.h'. It would be more appropriate instead to
unroll these actions here in the `clean` section:

    rm -rf $(OUTPUT)include/linux/counter.h
    rmdir -p $(OUTPUT)include/linux

William Breathitt Gray

>  	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
> =20
>  install: $(ALL_PROGRAMS)
> --=20
> 2.40.0
>=20

--PalkCyC95nRJfXq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZEPrLQAKCRC1SFbKvhIj
K4NLAQD18cZH+ATS9hLsCTEKGucTk0Xj4b02+6vTP3OlFHqJiwEA9k+3QwJ4ekCK
76nIX3lB+Y2ac+NmiBLPljRfYaTQDgs=
=r+mV
-----END PGP SIGNATURE-----

--PalkCyC95nRJfXq7--
