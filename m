Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00DA6061B6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiJTNer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiJTNen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:34:43 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12A213D6B;
        Thu, 20 Oct 2022 06:34:37 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id f9-20020a17090a654900b00210928389f8so3494997pjs.2;
        Thu, 20 Oct 2022 06:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pbzLARdfDYI9Ff/olyED+n7BZ3NSvaMpDSCiHZZlV3A=;
        b=jVYL5qhSbFZik/5trV3sfpE5B65Ijq4PdUNEH1QW26XH1slnCTj4wM4Dndw+O0arQ/
         r/4i6cSk2HBWKWMM/r8yKTSaU/s7qbBqAeyqO4VihWsFjJRa3v03ZjyvvM2hKHNljTzc
         13mYWx5fLqWLUUZn00fO/PPkN1EBLWkfuNme5/74b26Jf0Y98x+NR0ZpH8syYUMo2UqC
         WZzadUcBHHrNEDAP6ARe+RJqMpXPW38a7hGrcXBx9IES8XKHqz9Y6KPKY2qQSOiKSQ6X
         a+83svxW6BevaJfNnhD7iRqOtd9QsD9agdqIm1sHGuSJ/tLhixsrnF7PpmmnQ1+psV9p
         5OOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbzLARdfDYI9Ff/olyED+n7BZ3NSvaMpDSCiHZZlV3A=;
        b=YP9cc9m4yknmzEMlIPWk4/lSEC1NdGpRC5KCcHabPrxjP9+6SgXwKieEAg/XHqsDwe
         rm64SQmGjH8NMDY21Yp/R/VdDRLhEbXtk6A09lb9TxoNSYiYwi0/C4gVV0zBTV92AXeN
         uRG1N1n+j2mRaYyv+/5Z4DUribi1sYHxWd1Bfn94qPBosALVMM+4G+SbL6W3RjmlEM0Z
         lOy9ILwQn95aYnFrqvISfZPVqQYFBgE5mSQogrh3W1Ja1bH5nK7UE/1IgRAbdVa/nLAu
         RSJRcXWoh7EQjJvprgrO5+obJdvAt89Gu+/oyQWJMDgeEljtfU9aCLnmAOUUatvB5oTI
         SUow==
X-Gm-Message-State: ACrzQf2s8IwRnuWrXj4bd90JsULAHjnCQVWBFZcDuDKYYA47uVpQxUwp
        7EL9cRwHXHiT7beoAj+tb4pSbFNWxwC3bw==
X-Google-Smtp-Source: AMsMyM67gCW0k+ChdE0o0qjGUxVm2tZ77Jcp/vRzQ8cRMV/TI0HbSpPVadKvI9EeKsRMUDFRhbMJAA==
X-Received: by 2002:a17:903:230b:b0:186:6041:51bf with SMTP id d11-20020a170903230b00b00186604151bfmr4192435plh.24.1666272876871;
        Thu, 20 Oct 2022 06:34:36 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-50.three.co.id. [116.206.12.50])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090a1f0900b00202618f0df4sm1865363pja.0.2022.10.20.06.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 06:34:36 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E568B103F24; Thu, 20 Oct 2022 20:34:32 +0700 (WIB)
Date:   Thu, 20 Oct 2022 20:34:32 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jilin Yuan <yuanjilin@cdjrlc.com>, robh+dt@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: fix repeated words in comments
Message-ID: <Y1FOaBGzIuKlCkq4@debian.me>
References: <20221019130200.60460-1-yuanjilin@cdjrlc.com>
 <9fb4c010-b465-e908-6868-d9e493a9688f@infradead.org>
 <6e6935bc-6de9-99fe-be17-1845b1910e2c@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BD4AS0YE8FWkgUTO"
Content-Disposition: inline
In-Reply-To: <6e6935bc-6de9-99fe-be17-1845b1910e2c@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BD4AS0YE8FWkgUTO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 19, 2022 at 07:57:44PM +0100, Conor Dooley wrote:
> Good luck getting a response out of these guys, at this point
> you've gotta wonder if they're real people or bots.
>=20

I think @cdjrlc.com people only have one-way communication with kernel
community, since they send patches but ignoring (critical) review on
these.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--BD4AS0YE8FWkgUTO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY1FOZAAKCRD2uYlJVVFO
o8Y2AP9DHldmyPOw3l8al4Z66y8Q9j1knVCmIjV2cFK8wNgPuwD/c74yv9F1Ue3p
J15vRyScuuSyxKQ/yuML75Z7U284Sgw=
=Huxt
-----END PGP SIGNATURE-----

--BD4AS0YE8FWkgUTO--
