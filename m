Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAE174CC35
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjGJFcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjGJFcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:32:09 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7DEA8;
        Sun,  9 Jul 2023 22:32:08 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666ecf9a0ceso1970367b3a.2;
        Sun, 09 Jul 2023 22:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688967128; x=1691559128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xZq+Hz2DVjmoDUQM0f90c2lbY2SLTyJDQfq3fBqLjkw=;
        b=sz6TrAumUip4aqI9GNBXa+tm5Y04pfzFRl0h0y+Gk+yWS2OZ8jYhkOGq/ct7x8u/Z4
         s8Xf+aBQ9byGEHsoHHAnQqb5FAfZsCz5ADeD2xGryCFCurscL5mkDG48KJCIC1rkqxXB
         WPEdHtC3teWr3+Ig6wykTdd5gJtLyMmNOU7tx0kTggwIwfrYfFp4iKwOoeHvn4x+t0r2
         jZOW8JeD7z/DICTcINlpdCmED/SB5KdBvJCF9nEsDNLz7QMUnhCH75O1SqE6oVOyxf+U
         a+HwqtYXuS84Ni98TxDwQTcUI8+to+djaJIRhCQC43PlQcOJPujJrHnc1NCFUTI1MInf
         cIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688967128; x=1691559128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZq+Hz2DVjmoDUQM0f90c2lbY2SLTyJDQfq3fBqLjkw=;
        b=OAOi0+BE99NsPoDjJkMX6MjiDelKT9Xp/ukeD5n1dDeItL0JXAnWL06pXe8Q/dZ4E5
         i9xKkx9lhB/S+2Dm+shoR914pnphTXozbuj/889c8lfUiUYCzaoCEJS4ESycOOpQ5KSF
         6i7zvuUgGSHhEFiaroFdeAbQ1KKqf0t4C8JxaByyxMBKOBdU8xNVBKpl4uPp3rLxhTgE
         QXsK+STGhgL66H1fUMWaF9pp7EIU5I52PSu8/WZvR9heczncYFI2ZkevJKFCgR8LeJR1
         ff4D9liHxJLRxAtPfjrGilnb5kLxhlwS6fqr0ijT2xZaYyJkZHhTlrdoZ5l6VfsaYnoB
         edAg==
X-Gm-Message-State: ABy/qLaox0xNxna6NrlPIDfqPP2cLrDi65g2jLgMRpXA7AYNT+dh7uPf
        5u0y3YhIIo9Ig453NN0E0AA=
X-Google-Smtp-Source: APBJJlHT4TVWDELt5QfX9k+VIh4sRV7vHhUQSonOcWQsrQTbt0453kd9DdfLrSieVAQGKdfO+j4hbQ==
X-Received: by 2002:a05:6a20:4424:b0:131:dd92:4805 with SMTP id ce36-20020a056a20442400b00131dd924805mr1251390pzb.57.1688967127906;
        Sun, 09 Jul 2023 22:32:07 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id z3-20020a63b043000000b0055bc21caa09sm6491247pgo.77.2023.07.09.22.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 22:32:07 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 7EEE58208E71; Mon, 10 Jul 2023 12:32:02 +0700 (WIB)
Date:   Mon, 10 Jul 2023 12:32:02 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 0/6] 6.4.3-rc2 review
Message-ID: <ZKuX0gSlKFnSITOi@debian.me>
References: <20230709203826.141774942@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AjhBD/Ows7aw9aei"
Content-Disposition: inline
In-Reply-To: <20230709203826.141774942@linuxfoundation.org>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AjhBD/Ows7aw9aei
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 09, 2023 at 10:45:16PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.3 release.
> There are 6 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--AjhBD/Ows7aw9aei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZKuXzAAKCRD2uYlJVVFO
o91DAP4sMRRejEh4mQ9Ejbh8eUPw0EiK30tmOk5cKYkbGldaHAD/c8Em6JEDHTqv
/K+qBIzh2OnBYmhVchMpveU+lBup2go=
=NpJm
-----END PGP SIGNATURE-----

--AjhBD/Ows7aw9aei--
