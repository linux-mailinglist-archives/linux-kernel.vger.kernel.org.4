Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA71A67DF14
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 09:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjA0I14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 03:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbjA0I1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 03:27:54 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FED76416;
        Fri, 27 Jan 2023 00:27:44 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id 5so4284359plo.3;
        Fri, 27 Jan 2023 00:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fVo6/BVQuj9sNJvCAhaAVxcKUF73wKkjXPmCAA6FJ/8=;
        b=EHX/hxe6MGrEaIIlEN1Aed3ThprLO7xCJNQDJq/wsjbfYEjbgdm6hNNl2CWtjHkK/H
         Ln+WY46vgRvP66lXnaMe9mlgeVktAP6n5ZqwsZ6bBDjRAgqnXT+L7MlKP5pkd9vU1qEH
         01VJSkoK9zJcai4H4Ozjw5ijC3ZnhsEj4C1W47ZWG55ROoKp+wu/ytYiDJBwgVVv+DpF
         1tDw7RRY9AXk7N5wFRx8YJt7DrlBSOL5Q1qHiVL8IuBUR22lb96VvTpkmeGRy+zvjEsb
         PJmvwR7MmRYBcX4cnigTiMhjscctn1UEftCKFQPz7oiosabynrm2svueuPPUxPEN6y6I
         WZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVo6/BVQuj9sNJvCAhaAVxcKUF73wKkjXPmCAA6FJ/8=;
        b=go3uQzUTqMfidoexESXSUggizaW5VyE1bQYRjycpsl6chrkXyjTxZmH98DP3c2FQ3g
         5TkT+iokQv5jRJWHCdHbImp+xu4jKUYxgcVjnoAdFZFf3DZiBbBWFYCxamEIx0Uu8LNy
         aIH8xNkvEK7SgmTpYFWo7Xn++rIfNrfOVT+NaeZ0Mbk/I2uKykKYPajXSmFprs1TuZgS
         00FgHUlr/MPliS4pwHUzBp2/FpF/ghzRLG9Olcru7nAPisR7VbuLUcHrL6MhoPaFHAwV
         XktDVAr/lhgPFeuzyWS9AxENv343+w07xyCz2BTDtnau7+8+YpzNTksEU1qR4nRA8Ysg
         JFtQ==
X-Gm-Message-State: AO0yUKXwo/SP3Zyui7QzbgCxXo2ULge/SimPUUFLWObOOdPLpXsgCZWs
        a2we83B9jEsX7sqeKZ+qfUQ=
X-Google-Smtp-Source: AK7set+m1E7zEZ2usunby8D/4yjYR69ULqioJH2bGOcwvL2xRe2G3PenNUkJAFGm8Ep5Nym3WyEqOQ==
X-Received: by 2002:a17:902:e80d:b0:191:3098:8b with SMTP id u13-20020a170902e80d00b001913098008bmr5567434plg.58.1674808063693;
        Fri, 27 Jan 2023 00:27:43 -0800 (PST)
Received: from debian.me (subs02-180-214-232-24.three.co.id. [180.214.232.24])
        by smtp.gmail.com with ESMTPSA id jc5-20020a17090325c500b00189d4c666c8sm2262867plb.153.2023.01.27.00.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 00:27:43 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id AB7F8105582; Fri, 27 Jan 2023 15:27:40 +0700 (WIB)
Date:   Fri, 27 Jan 2023 15:27:40 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 18/35] Documentation: mm: correct spelling
Message-ID: <Y9OK/N/ySuLOAG41@debian.me>
References: <20230127064005.1558-1-rdunlap@infradead.org>
 <20230127064005.1558-19-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Zg4pkEnBsSEu5eSA"
Content-Disposition: inline
In-Reply-To: <20230127064005.1558-19-rdunlap@infradead.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Zg4pkEnBsSEu5eSA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 26, 2023 at 10:39:48PM -0800, Randy Dunlap wrote:
> diff -- a/Documentation/mm/hmm.rst b/Documentation/mm/hmm.rst
> --- a/Documentation/mm/hmm.rst
> +++ b/Documentation/mm/hmm.rst
> @@ -416,10 +416,10 @@ can be used to make a memory range inacc
> =20
>  This replaces all mappings for pages in the given range with special swap
>  entries. Any attempt to access the swap entry results in a fault which is
> -resovled by replacing the entry with the original mapping. A driver gets
> +resolved by replacing the entry with the original mapping. A driver gets
>  notified that the mapping has been changed by MMU notifiers, after which=
 point
>  it will no longer have exclusive access to the page. Exclusive access is
> -guranteed to last until the driver drops the page lock and page referenc=
e, at
> +guaranteed to last until the driver drops the page lock and page referen=
ce, at
>  which point any CPU faults on the page may proceed as described.
> =20
>  Memory cgroup (memcg) and rss accounting
> diff -- a/Documentation/mm/hwpoison.rst b/Documentation/mm/hwpoison.rst
> --- a/Documentation/mm/hwpoison.rst
> +++ b/Documentation/mm/hwpoison.rst
> @@ -50,7 +50,7 @@ of applications. KVM support requires a
>  For the KVM use there was need for a new signal type so that
>  KVM can inject the machine check into the guest with the proper
>  address. This in theory allows other applications to handle
> -memory failures too. The expection is that near all applications
> +memory failures too. The expectation is that near all applications
>  won't do that, but some very specialized ones might.
> =20
>  Failure recovery modes

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--Zg4pkEnBsSEu5eSA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY9OK/AAKCRD2uYlJVVFO
o/64AP99H7wzybdXYjvpeayz6u4l1tmLjTeJ7KfFsXycWKsCkgD/bjzwPn6Y1wlV
TddF/Nd/hRu3wIWSdHppvtJEhR3bgws=
=dz2l
-----END PGP SIGNATURE-----

--Zg4pkEnBsSEu5eSA--
