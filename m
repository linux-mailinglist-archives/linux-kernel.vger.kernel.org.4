Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA0669D10F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 17:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjBTQGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 11:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjBTQGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 11:06:13 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE151C302
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 08:06:12 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id s12so1195655qtq.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 08:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n7NItqL5WlXKvPSPcmvVIXa/5KtssSjGrZiATi5QVhk=;
        b=PWs2K0JhZjtqflvScdSGmd0Y0hWFtVpSYuI9LLqpM88SthMeysJ2lRX6YdJA9b9Rch
         3Ly+O1cawkJ4ufcuHUzPB0mUe1rhbs04vuvNvCjdFYCbiZAFdxe7qVWrVymeEbe8eazw
         M9DtfABRplQtK+Y4r8bRtdcC2+A6NIdqoliqfPfFDBmGtmXE06UQmA19vImMQx82YI1Y
         xtim+We+dVtFWwZpUXp8UplPpE4a3ioRGciRGK5RikJOFgC3h0BWaZwQoCqO2dGwkyei
         P5LoD+RIAuSTtURri2UySGFaCRixBSrwVsbebVPM5h5H0qaq0zmFVqEKhr5CZUf+sNLl
         E9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7NItqL5WlXKvPSPcmvVIXa/5KtssSjGrZiATi5QVhk=;
        b=7Y1BNBHUO0T+dVvoFea3MEhPAKRatGzEdLOgbNHoRN2NDX04GZUQpM5niNZ3XshI7I
         7YHetNjMbb0jVL+kzhruUjB6DJZWve0DP1+e8rOXu+2XURo49Kk/vcO+enWNpVq7aRFu
         I4LKLBUGnN9IYrOyXHYRD7lK12ScUvoHHPgoyIy/bwBNVLNUgDQp1997N3DykBwcmkXw
         EvssWAhrVwqGlC0QrMiJDjex/+lFHfIiqpDASemSaoGz5vi1nKsAr7McMRWWuXGA1Pmd
         8UA2oHlfgLpb8JtaXie0qu0U0itYgcpDFFs0nATDvhnp5bSl0mc43ykCeBgE5bLdafYe
         3TPA==
X-Gm-Message-State: AO0yUKWImCSQPl3X83C5Mn67+xVJu8kxqrbkTiqwh84ibWQZonZrs+0B
        9DGkhA9RU1pGm94omXOUKzk=
X-Google-Smtp-Source: AK7set/YEESzSwtQVU5dIpOwx8NgJN2QEeD281zIf8VbvxsLMCdWOn27B1li5WUE2NM4FDpYRqM59A==
X-Received: by 2002:ac8:7f13:0:b0:3bc:dd23:cbb2 with SMTP id f19-20020ac87f13000000b003bcdd23cbb2mr3446457qtk.33.1676909171267;
        Mon, 20 Feb 2023 08:06:11 -0800 (PST)
Received: from hotmail.com ([137.118.186.11])
        by smtp.gmail.com with ESMTPSA id f30-20020ac8015e000000b003bd0e7ff466sm8265636qtg.7.2023.02.20.08.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 08:06:10 -0800 (PST)
Date:   Mon, 20 Feb 2023 11:06:08 -0500
From:   Storm Dragon <stormdragon2976@gmail.com>
To:     linux@weissschuh.net
Cc:     George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] vc_screen: don't clobber return value in vcs_read
Message-ID: <Y/OacHw6nL/ZtrH3@hotmail.com>
References: <Y/KtG9vK0oz0nQrN@hotmail.com>
 <20230220064612.1783-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F5B7JLjsd7PEmIoy"
Content-Disposition: inline
In-Reply-To: <20230220064612.1783-1-linux@weissschuh.net>
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--F5B7JLjsd7PEmIoy
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2023 at 06:46:12AM +0000, linux@weissschuh.net wrote:
>From: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>
>@Storm Could you validate this patch?


I am willing to test, but I have almost no experience doing anything
with the kernel other than upgrading it from time to time. Can you send
me some instructions for testing this?

Thanks,
Storm

--F5B7JLjsd7PEmIoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEjjImGMhZhYoKESBfW+ojcUPdwZMFAmPzmmwACgkQW+ojcUPd
wZNphg/7BsCOV4l6YkxwLCza4W15yEky5qLkQZ+ACRriC+hOgl/y/dCRZ89j96at
knNR2EqLG/9YUXMBtt+jmLSaqvJrbTqYVi9FY3Eq/stKK3Jspex+SbRLhUPnz/cQ
wNxjJ4vwfRIjr8C8ty8/wH3AlafxNqNHxrYDc4Qr01NaMdUTEU7xMi178Z6xIYXA
WlUmiUnZ1TuzvN/JaQrZan0aIvIyCfc/UiTpMJF5kTsUQBvwzdzWKN9VEhtlcFqE
haE92srM21Pn0yTO7ZLTdqGEHOTdODmDa6yrNBUZkeeQ99kuaYzh0NVRkh5mtF9W
+F2UNiiZsayNO+ZjcgD65DHN1/CyZnOMqDheijueZcV/hvEQsT03h1BAD1FkCaaO
JSeDH8yjo3wSvaaSf2wwRd3RAY1cgOtiIuJffsJdO8l6Qj8MdYHrVhQWvYEJp7A9
78w3cuvrvvypANIKsjZdZ8xclrbwwQ5Z10271x9jZtgkI1QYKduUzxH9dKNKj4YW
KGb6ztK9it+Bke7NzW6aWzcTkiTmH0e7ccyrMyj7T1crxqfK+Sq/CU41bdrwxHJl
xmaCgit8q/sNdLvpzLUWU+6TncEhBgOYpmXhJ3Wk5yuHUFjEstdi29xONPoFr+Zm
ft2ImsrWKbF6IATXHID0ptQCzgzCOYyNaW4tT4rNlDZ6D6xt/PI=
=jaVa
-----END PGP SIGNATURE-----

--F5B7JLjsd7PEmIoy--
