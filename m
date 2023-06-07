Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F62725290
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 05:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240861AbjFGDuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 23:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240928AbjFGDuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 23:50:17 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A95D1BCA;
        Tue,  6 Jun 2023 20:50:16 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-565cfe4ece7so76602777b3.2;
        Tue, 06 Jun 2023 20:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686109816; x=1688701816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Na3I9K3/ba8EkhBO8d8TpKjtZepS1FFlDEJmyLoVzfY=;
        b=YAOv7S+XmZKTiruiWIAGkJCsiSYU+BVv9ntx9FPw8bTJAOJcIXk9ERqnTqzlqIEzT1
         g5rLKzhadfW3THVq+WWOSI0KB37jzV08jxONtXU7Dn2uARlbma7YxhcZSyoMHUimpic2
         hWhSmPFmq/KL7cd2xcLpg2BSyznnz4WI1/8CDqaPgohsgts+Qdl2m5aQJhTn4NC3HVUn
         3kdr9z06MQbQnJ8ujWUDFp2MtI5hgt8hgPnOWrKPxw3eewjUH07vMg97U9LTpd5zrJdY
         1MMjPns05Ezz8eDrdOusOdvG2KtiLNJk8rUegXdPBIJtj7gNKAFl9wrF3BZO2fv2SGPU
         qtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686109816; x=1688701816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Na3I9K3/ba8EkhBO8d8TpKjtZepS1FFlDEJmyLoVzfY=;
        b=hmHfhTbo7pEml91QE950hMYTe4dzNEHIdZFl3pxxjCP397umEpgMtNXB4nRpCu3JGw
         amkeqW3lLp7EtViHbqFy6a6KCQvVIYwmH+Thh73HDfLSRysanesNXm8AV3M0hb/QIvco
         AaCiv6/aLzUNVy9zQpbyMBFhIu/p/zAurvQqMleRxFYDlMgfEGpnlnHpAmofM32HOgTi
         uv+KDJXBFQftafrXc3e9SO03Q5tAr+inRkhqJEW0QmFkL8YXhse8G7GiBkRSwh4jOzgN
         4OrmVvOItl6xTj3i2B9vZrXWqtAsVRgSIRGLAaenLan/yMeM4eR7uaKoYIzkLxg/mI5r
         sy+A==
X-Gm-Message-State: AC+VfDzcDJze+NQ8sYkmPUoURC8YPI5Z5ke81qInkMXfkXa/UjTaWZu0
        P3mU5NKT82U56QshFB25G8jVCMLU6b8=
X-Google-Smtp-Source: ACHHUZ4zFSbxL1pTJXYjAYiXR3ngk77EcmpvHWwR2989S7X47iKzObxTZANGKJPscpFtHnch4u6rdQ==
X-Received: by 2002:a81:6f57:0:b0:561:7351:f56f with SMTP id k84-20020a816f57000000b005617351f56fmr5677716ywc.24.1686109815709;
        Tue, 06 Jun 2023 20:50:15 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-15.three.co.id. [180.214.232.15])
        by smtp.gmail.com with ESMTPSA id s19-20020aa78293000000b0063f0068cf6csm7368652pfm.198.2023.06.06.20.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 20:50:15 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id C3AFC1069B8; Wed,  7 Jun 2023 10:50:11 +0700 (WIB)
Date:   Wed, 7 Jun 2023 10:50:11 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Franziska Naepelt <franziska.naepelt@googlemail.com>
Cc:     davem@davemloft.net, franziska.naepelt@gmail.com,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH v2] crypto: crct10dif_common Add SPDX-License-Identifier
 tag
Message-ID: <ZH_-c_WHg2jz0W1R@debian.me>
References: <ZH8ntoGLJHQpZriL@debian.me>
 <20230606180713.99460-1-franziska.naepelt@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="69uuQyi9UHRbAGLa"
Content-Disposition: inline
In-Reply-To: <20230606180713.99460-1-franziska.naepelt@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--69uuQyi9UHRbAGLa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2023 at 08:07:13PM +0200, Franziska Naepelt wrote:
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Cryptographic API.
>   *
> @@ -7,21 +8,6 @@
>   * Written by Martin K. Petersen <martin.petersen@oracle.com>
>   * Copyright (C) 2013 Intel Corporation
>   * Author: Tim Chen <tim.c.chen@linux.intel.com>
> - *
> - * This program is free software; you can redistribute it and/or modify =
it
> - * under the terms of the GNU General Public License as published by the=
 Free
> - * Software Foundation; either version 2 of the License, or (at your opt=
ion)
> - * any later version.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> - * SOFTWARE.
> - *
>   */

LGTM but I'll send a SPDX conversion series for crypto/ instead soon.

--=20
An old man doll... just what I always wanted! - Clara

--69uuQyi9UHRbAGLa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZH/+bwAKCRD2uYlJVVFO
o0EHAP4jGf2twi+ylLJiHcF2EKrmaEGDu27eStgPy+ChLvPkOwD/UbVRcII6evos
uIPSZDwjqPHvWgC5DurP0V8DHueNHgg=
=SXr6
-----END PGP SIGNATURE-----

--69uuQyi9UHRbAGLa--
