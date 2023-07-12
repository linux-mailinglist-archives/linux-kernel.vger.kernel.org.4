Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B552174FC6A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 02:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjGLAxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 20:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjGLAxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 20:53:48 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EA010CF;
        Tue, 11 Jul 2023 17:53:47 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-55bac17b442so4863959a12.3;
        Tue, 11 Jul 2023 17:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689123227; x=1691715227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zE3TMDck5lpTaysCkLYztWeGCa3jjnBraPBJuUOxBZc=;
        b=T1ya6xLd2+kY12r3ePT/cBb80kSrkxS+qGaE9j0dwRyHN5FzReYijIvEBHfrzlAgvO
         DU/7E+ywtsz5ezmRq0zw4IlXnJsCeBfdWLbAiHgrw5TOcNlKGC8Vw62aP6hrq2x1WaZZ
         n2pBO9wDYrzErwSUqKn6f87ZB3npcjzU0eQQ/YomGRbuVeWHEs15qtNtQHaRlXtH0pTN
         gmIH5rng61dRoKUVDFeSI6LucMdhlCXNDbZeWskIy474usGwgp9vEEom6sA/r3Ak0ZEr
         2xtBkwRL9dA2t5PZ5jsgAlRquTolsOFXuRoab7SXHw5gd0s7GuPzXRcUct2WEz9cZDj+
         5vRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689123227; x=1691715227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zE3TMDck5lpTaysCkLYztWeGCa3jjnBraPBJuUOxBZc=;
        b=USuubLMFCnGS4lyNaskw11vXRtBeItLShAw1HemRR1QCvahJwHIYzmv9LZWhihWqWk
         yvMvYExQ0+5y2oDgGtkmSYDUKWD4d52CWDM7jLRh5RA8oCexI+ahUiT66+K+GOMmODAg
         vJKYjMYL4QwHjp3XtLLMJZNqqBYLB3Itklkuuugl67OWQgLujKHxliDO6JPWhxTpFUaQ
         lUvoprPt4AKy7XgRkxpZCTd9D3Ci4BmUIJiTpK7erFeTG5iSgQm0KzicKT5TSk5f7GLe
         6RS3vKnbUbYPoa9QY4BJ01C9lwNmTAnKR3qrwCheeFj391JWVuN9MVqWcLfJ4GaLudNL
         7MsQ==
X-Gm-Message-State: ABy/qLaCGDVYH2i6TeemdquB86mUbpGLpgzZ+pBzkV7pQBDFapQY0b7g
        /EQJ9XbebiMBNoka2+nnDXo=
X-Google-Smtp-Source: APBJJlF0l4ZMvmsvRZi82JzlUCbj5BpS+mWKcrP7/b3fmnkdQ+1/HsVk5wOYTQSSVhnmDJCxt9hJKA==
X-Received: by 2002:a05:6a20:4326:b0:12f:6aee:7e43 with SMTP id h38-20020a056a20432600b0012f6aee7e43mr21085104pzk.57.1689123226873;
        Tue, 11 Jul 2023 17:53:46 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id fk25-20020a056a003a9900b00682a0184742sm2376797pfb.148.2023.07.11.17.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 17:53:45 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 17B848206CA5; Wed, 12 Jul 2023 07:53:41 +0700 (WIB)
Date:   Wed, 12 Jul 2023 07:53:41 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>, wuyonggang001@208suo.com
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: usbhid: Fix use assignment in if condition
Message-ID: <ZK35lRo/FkzC7BM6@debian.me>
References: <20230711014359.11991-1-zhanglibing@cdjrlc.com>
 <a4ca3852846e220cf378a664cf1c6213@208suo.com>
 <2023071100-recoup-rebuild-c55a@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H7nSbCSV8FY5sDSB"
Content-Disposition: inline
In-Reply-To: <2023071100-recoup-rebuild-c55a@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H7nSbCSV8FY5sDSB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 06:09:22AM +0200, Greg KH wrote:
> You are receiving this message because of the following common error(s)
> as indicated below:
>=20
> - Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
>   and can not be applied.  Please read the file,
>   Documentation/process/email-clients.rst in order to fix this.

Hi Greg,

208suo.com people send their patches (including this one) using
Roundcube, which is knwon to corrupt patches as you mentioned. Maybe
I have to send Documentation/process/email-client.rst patch to mention
this, right?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--H7nSbCSV8FY5sDSB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZK35lQAKCRD2uYlJVVFO
owB3AQDsx+hCvZLIi82xSIdz5Y/+iOLkEGLbWSHt4oP2A+m8xwD9EKkQCz6xSMXO
Ui56WVw/2yTSka1iY3n+UYVMKOCM+w4=
=ZZFl
-----END PGP SIGNATURE-----

--H7nSbCSV8FY5sDSB--
