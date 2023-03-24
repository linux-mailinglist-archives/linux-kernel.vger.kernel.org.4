Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCA96C7F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjCXNup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjCXNun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:50:43 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E691B2D4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:50:37 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id r7-20020a17090b050700b002404be7920aso1076530pjz.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679665837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VvvSi+5iA/5tlxMT+sJ3fTetfG9Rc3EXeqwc0N6JACY=;
        b=HGU+Mr5iduwcW0LXBuS3eQEkIO5IJQSwVMvcdJ/WaosQKCZ3oSqTClH9mss1KtyTYd
         aYX+8rnsld/vT93zMB7J5un9LvNViWez6IJHSrOFgUrzmYWMYOzTP4Ecv2O/8aDm3Who
         S5QtlX6e8HCpJZHcHEznl2Tdr5FdwkGemcvlv4GpQLoO4VB6hR+eHtd8jOijahtomA8L
         4gVaN0eZWNvU31VEc59iYsEBEE8RqzZz16l2aX+Ck2YwyrD8ME40hJgzPaMGB04RUFGh
         OnZYWR89vcQAKSp2XXzyGtmvDrvDLbt511mhDc/ren0XsWqOueNBHbaySjLynTdvG3Qt
         jCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679665837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvvSi+5iA/5tlxMT+sJ3fTetfG9Rc3EXeqwc0N6JACY=;
        b=UUvSuxJ1dxGRyW3hBwfCL/VpcF9i4k2faB8krt5x3vCGWgoxhkBodw41d38zHiUmZH
         YyzpjpRrgChiEMLg4gi4PcnC6hL9lCopPC1NsJgdWS3gb5uEaGq2aOxLw2pfNapZBDMv
         JAdPtVg6JWtb4kwaGwV9BIJrrDGdIBGtUYvT8hjB3lBUKqe3Ycis5AwNvwqtKPu0Czsj
         +TmxmdfX+/lJ/xOV79BBI/CLRVUFsbX1/3wn/7kRvdQL2r2CUwq9CfSgu5iWA6oLPsSN
         IS3xESLSe9hpc+730VD5oeL1zlVFH/VB77MGW2oeVatn2XkIJw4tUr1ne4yCMWRcQ3a5
         f6fw==
X-Gm-Message-State: AAQBX9c0ZItQ8Wf8NO51neihQNTyk3Rsr5u8/KrXvU3BRePOE+E4urgp
        kOYM1TaiHl42LLWGBCF6N/WmtUYDXEw/BQ==
X-Google-Smtp-Source: AKy350b6pccE3wDumL/D98ou7EvPQyfzKdFleAxUumzuVcfFOxXkHnfFOSwqcBj6zVAhRR8voTlIWQ==
X-Received: by 2002:a17:902:ecc2:b0:1a1:f95a:2505 with SMTP id a2-20020a170902ecc200b001a1f95a2505mr7886315plh.29.1679665836741;
        Fri, 24 Mar 2023 06:50:36 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-20.three.co.id. [180.214.232.20])
        by smtp.gmail.com with ESMTPSA id iz4-20020a170902ef8400b0019f9fd5c24asm14181006plb.207.2023.03.24.06.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 06:50:36 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 0E7AB106544; Fri, 24 Mar 2023 20:50:32 +0700 (WIB)
Date:   Fri, 24 Mar 2023 20:50:32 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging rtl8192u: fix block comments
Message-ID: <ZB2qqKCHiYwNr5la@debian.me>
References: <ZB2a5zwYpBZ/6qwU@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BLg0yowj9UD64YiR"
Content-Disposition: inline
In-Reply-To: <ZB2a5zwYpBZ/6qwU@khadija-virtual-machine>
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BLg0yowj9UD64YiR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2023 at 05:43:19PM +0500, Khadija Kamran wrote:
> ---*/
> + * Copyright-c Realtek Semiconductor Corp. All rights reserved.
> + *
> + * Module Name:
> + *	r8192U_dm.c
> + *
> + * Abstract:
> + *	HW dynamic mechanism.
> + *
> + * Major Change History:
> + *	When		Who				What
> + *	----------	--------------- -------------------------------
> + *	2008-05-14	amy                     create version 0 porting from wind=
ows code.
> + *

Hi,

The revision history can also be trimmed (since most developers use git
to browse file history, leaving the copyright alone and abstract alone.

For the abstract, what about "Hardware dynamic mechanism for rtl8192u"?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--BLg0yowj9UD64YiR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZB2qpQAKCRD2uYlJVVFO
o7mbAQDvkJXMStCNksJ9+t9Mbb0cjKw2rbfqe+ArEHPyV53khwEAkTKJ+b104ZX0
Fz3KBg7gi+LDhi7dDYNzK6UI/MJ5MQY=
=Ns+6
-----END PGP SIGNATURE-----

--BLg0yowj9UD64YiR--
