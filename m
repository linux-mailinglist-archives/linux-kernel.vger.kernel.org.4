Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC7072D8B1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbjFMEg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFMEgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:36:15 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEABDB;
        Mon, 12 Jun 2023 21:36:14 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-54f75f85a17so1352929a12.0;
        Mon, 12 Jun 2023 21:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686630974; x=1689222974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLey+7BUO2+v17+Z/uap9UjvAbO893/3s+NdkwIj1tU=;
        b=kQsV1t1Eyqm8Zm+jY6rt2A8U9bIjx/T8ySnLIOAoXPHj0ovnliDTWTwUPmKbIrPuTB
         T5ugGZP7QLYdK6GaZuZX2TgmKUdTzZeShm5YtVVljKH/9bT8d7XAhrdmzZXDfxS7mcTG
         zD/J6J6Cjkl95YcsQzOE7kfb2Uj6h6936q8MX36vFwcC8OqaI5P8GeOPv4C869Pa5hjq
         Wn+xKnfOY476WxY3DL6Z6VzXEzjtRAwwMTORR4Xw83T7xIUGmgbYYRUPdFfrG7a3aQ2q
         3204p+LOau0HOIFYxej+FjG9Ku3eG7pCSpZKOQPzjG5n8fWNT+sb+DNaXvvdXr1mwmcW
         JoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686630974; x=1689222974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLey+7BUO2+v17+Z/uap9UjvAbO893/3s+NdkwIj1tU=;
        b=Ui4PT+Eq2mss4gBbqKPMwWG/7sdYD86Ojz8+D/SZzcG8jvDOYQ3L+RSYiZY0Cjs9zz
         VIwfmfvywsJvS11+6DEwJV3AIdP4kmSvgWr0ol18Lm1oE1sUlSMdi9pA9c/JICQShsTw
         z2m+vBQuRavoMPjRMRgvcNmWID7NV3VkhbzjVFllyqtZG+buZCAfKNfuXIh5kmUPQ1eK
         0+JAC7cGcBlwKisyatcQUfwUNBS4ZYhhobIyoqQsJMFmKqXB83uxYdZwDB4M/j2ZqE7M
         18QhO5BOqGSYn7IOi9ikmGUJAjO4Rwmxw9QnNfMEr8nuEKGJU1W2tYQnIsKHca8eYlTY
         TGMA==
X-Gm-Message-State: AC+VfDzOJ1nUMGP2oVA921RwqNUavwdvrWRgIACI3qnelbOTlyGi5X0n
        9RDQaaRnUBqjb4KNzl/5geQ=
X-Google-Smtp-Source: ACHHUZ5VZF1FuJCXEL+pyvS4Q5nj8ZJtVqGazuh5rkdjbvs6yoecAkFV5ZP4hCbp+20SZ5nSsr261Q==
X-Received: by 2002:a17:90a:9f82:b0:256:5637:2b30 with SMTP id o2-20020a17090a9f8200b0025656372b30mr9259319pjp.40.1686630973944;
        Mon, 12 Jun 2023 21:36:13 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-27.three.co.id. [180.214.232.27])
        by smtp.gmail.com with ESMTPSA id j13-20020a170902da8d00b001b06c106844sm9114212plx.151.2023.06.12.21.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 21:36:13 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 56B21106BB9; Tue, 13 Jun 2023 11:36:10 +0700 (WIB)
Date:   Tue, 13 Jun 2023 11:36:09 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/160] 6.3.8-rc1 review
Message-ID: <ZIfyOdBtdhCkwJmj@debian.me>
References: <20230612101715.129581706@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9vZIuwzAQwncgYxj"
Content-Disposition: inline
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9vZIuwzAQwncgYxj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2023 at 12:25:32PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.8 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--9vZIuwzAQwncgYxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZIfyMQAKCRD2uYlJVVFO
o9WwAP0c5JBvbxPUwQCUVX9cQqQdmbolsg/yus7Lk1ukE1GBAgEA7Nml4743Hx0I
fygwgvAS7T+MtZ/5VQ1Ce86Wvwx+FQ0=
=iA8N
-----END PGP SIGNATURE-----

--9vZIuwzAQwncgYxj--
