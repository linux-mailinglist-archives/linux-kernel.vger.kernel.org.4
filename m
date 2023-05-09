Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B4F6FC7EF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbjEINcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbjEINcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:32:15 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE731707;
        Tue,  9 May 2023 06:32:14 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64388cf3263so4174932b3a.3;
        Tue, 09 May 2023 06:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683639134; x=1686231134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jQ/yIyYnbZbKg8g90S1XE68/Rwvr6KsEAjyFTeYtEj4=;
        b=B0ArtTWyhv49+8tDuQVz36UQeupkIqIeW/hIB3NQny8MY5BJA2j5vBH6KdVHLNqEuz
         vAGXZYBT6UoqQ835CLCxCN0ZucH6FYlCoqd3BKKIXo7VOUKOvxFr7KNd336xqYn5yoVx
         aiFmODeMz8EkinkPgCwzfsWydiej+FLrEfs2Ica1WnSylchx5y5Yp9M0cFP1f4RdqWWN
         31A4Mq519mCs9s/k3ZQSQS0VtGi0Vf0O/qpHf52OXNo+JobrpPFF4CIgWRfNndpdpb5/
         2waeVPP3188Eei9k8cc0K9ED0XkmQ7Rjv3bw3m5B1KWo0fT6cP24k4JNyo9sTo+eg8HQ
         q2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683639134; x=1686231134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQ/yIyYnbZbKg8g90S1XE68/Rwvr6KsEAjyFTeYtEj4=;
        b=NoLSfS+rIh22FeCaG1qOCtMzAg/MZIdEximA6VuRv661CFlFIv097Ip74v23AJGtU+
         mewf1h0+KcB9RS9lnyNWcbgA3AjIdqcBYUAbCXl077gOiYKm8YUzEW1ZunvYguOaJPVz
         DaaYn5EkjjGPWGzmcnk4Z+PLONesydQmP4cV2vHfwvz9i9nNehylTZbUHhwDipvrfbgh
         MIr0IC1rxRvZQ6lGawReIebOW/B08n4ZsYQgbiWhb8lOya1eYB07PZQhd+AZKpuZKMiF
         RjNjS0nvUS0s4ryRtgZLlQ3BZmgw/p8Y87O2WPnQRWVx2QEztjHDKb0m5w7gUDYJxQyF
         vDuw==
X-Gm-Message-State: AC+VfDyHcB2FkrwB56waxB7mwkY96K256JyvSB2UIv5qHBTuq2qaI4Ee
        0DFh4IDbEEt0ODu4h5ZLw1g=
X-Google-Smtp-Source: ACHHUZ56B1e7eSUBx1TVQvPl5q9DlYEj4Pkuc3M88jxpkdO/XkcUggXdtrTSDN6cUUt7oiABFIB/7Q==
X-Received: by 2002:a05:6a20:7f85:b0:100:4a2f:4777 with SMTP id d5-20020a056a207f8500b001004a2f4777mr8621991pzj.38.1683639133781;
        Tue, 09 May 2023 06:32:13 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-84.three.co.id. [180.214.233.84])
        by smtp.gmail.com with ESMTPSA id g15-20020a63f40f000000b0053031f7a367sm1321523pgi.85.2023.05.09.06.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 06:32:13 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 5D0A91068FD; Tue,  9 May 2023 20:32:09 +0700 (WIB)
Date:   Tue, 9 May 2023 20:32:08 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.2 000/662] 6.2.15-rc2 review
Message-ID: <ZFpLWPBfs9daaGFc@debian.me>
References: <20230509030701.507375024@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CO2BRZQ9++T4pGG8"
Content-Disposition: inline
In-Reply-To: <20230509030701.507375024@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CO2BRZQ9++T4pGG8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2023 at 05:27:04AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.15 release.
> There are 662 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled in my computer (Acer Aspire E15, Intel Core i3
Haswell).

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--CO2BRZQ9++T4pGG8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFpLUgAKCRD2uYlJVVFO
ozjwAQC3sIqABNO1Z/zaCV9Yls5fdOEscEWTXiOyoiGJfqB6ygD/acEu3g5s76Xg
VpuNm5J4YJGqpadmkGbAODQQYSp2hgY=
=m4KZ
-----END PGP SIGNATURE-----

--CO2BRZQ9++T4pGG8--
