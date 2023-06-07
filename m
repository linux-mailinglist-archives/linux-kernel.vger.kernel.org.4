Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693AD726459
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241169AbjFGPZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241581AbjFGPZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:25:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EBB269A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686151376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+21+UJe7FXTwrAHp4Kil2Yb3E5Xx9Nc7BO+F/S0Qdi8=;
        b=eyRvlO5ncYEs92M8KTYxkn6PvQghun3ZqrhVCKviWfNEy5qBdwdCXZHwXZHNPuO8uE3L2Q
        tBRlfocRe9SghuplZk0/bHgySZn+TsTNX6XFL39ijQH64d5Vyb/31w52W/fPTI4ZjL6pRr
        S+8KDR5OncE0XrrbkFcFYfqx4qX6mnI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-X8UEEqFsN16p8t_j7RDbVA-1; Wed, 07 Jun 2023 09:47:45 -0400
X-MC-Unique: X8UEEqFsN16p8t_j7RDbVA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6262360e603so79219336d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 06:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686145665; x=1688737665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+21+UJe7FXTwrAHp4Kil2Yb3E5Xx9Nc7BO+F/S0Qdi8=;
        b=Xn9pDnPN7YlElKbMA5MN5XK+SMe7aHl4Wd3vEWR6DzmNf9XOdGPWbh8asFcSlOKCZi
         lMdDDy1m9cODsSwWRLKGSqrCRws6woacVSV8dissnOaFJPkbDR1MN042KzvAAnkeSnwl
         l3Szp1UueC90I6//MdTUdOiLh3M76vEwFm4gfetw/+smxTOnUtvKN8qIVCMuJv42MfJZ
         lT6cv82xeX2GaVE3L9ZBFxZfrAvAuqFMtXzLN2AUV9jVm28+XBejwSGdgHeqdBGKL9ZS
         OXz78JXNBi+ToXXoy+CBX3bGxqfCKKLBxBvdoz+Xu2HOwZwMO40f45YnFPIwNFtff/eU
         lpZA==
X-Gm-Message-State: AC+VfDzMa+JEACycGcrmgD99+xGpsSnYTKA0BZZstIPBMNTBf0L/7vmb
        Z2kryt/QFpXaQjfanbfbhsL6Ci+cQKkuFPGBdfEHAtJHGlrR0jOCta+k22gi5FPa7775IDFLWoc
        HmZrpCZPW0Yv+vL/tXl7+N9dTWrV9MucyxnnOwmYN
X-Received: by 2002:a05:6214:2a4c:b0:625:aa48:e628 with SMTP id jf12-20020a0562142a4c00b00625aa48e628mr3798649qvb.56.1686145665032;
        Wed, 07 Jun 2023 06:47:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5LqxdVGt9gx33r5P7dquZMC9hoYE8QxbVMlD5LrvGUwG/TxPa0OKI696JmPUonIqCwR3J+uW/uXUU6LYLmhZE=
X-Received: by 2002:a05:6214:2a4c:b0:625:aa48:e628 with SMTP id
 jf12-20020a0562142a4c00b00625aa48e628mr3798623qvb.56.1686145664752; Wed, 07
 Jun 2023 06:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230607053940.39078-10-bagasdotme@gmail.com> <20230607053940.39078-18-bagasdotme@gmail.com>
In-Reply-To: <20230607053940.39078-18-bagasdotme@gmail.com>
From:   Richard Fontana <rfontana@redhat.com>
Date:   Wed, 7 Jun 2023 09:47:33 -0400
Message-ID: <CAC1cPGx-mD0DAEanCFtoxoGRyHkcu-GTTNX=ePzjhb8XM+73mg@mail.gmail.com>
Subject: Re: [PATCH 8/8] crypto: cts: Convert MIT boilerplate to corresponding
 SPDX license identifier
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Franziska Naepelt <franziska.naepelt@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>,
        Linux Crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 1:41=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com>=
 wrote:
>
> License boilerplate in CTS mode implementation (crypto/cts.c) looks like
> MIT license with advertising clause. Replace it with correspondig
> SPDX tag.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  crypto/cts.c | 24 +-----------------------
>  1 file changed, 1 insertion(+), 23 deletions(-)
>
> diff --git a/crypto/cts.c b/crypto/cts.c
> index 8f604f6554b1c3..9ec7e9787c0f6a 100644
> --- a/crypto/cts.c
> +++ b/crypto/cts.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: MIT
>  /*
>   * CTS: Cipher Text Stealing mode
>   *
> @@ -5,29 +6,6 @@
>   * The Regents of the University of Michigan
>   * ALL RIGHTS RESERVED
>   *
> - * Permission is granted to use, copy, create derivative works
> - * and redistribute this software and such derivative works
> - * for any purpose, so long as the name of The University of
> - * Michigan is not used in any advertising or publicity
> - * pertaining to the use of distribution of this software
> - * without specific, written prior authorization.  If the
> - * above copyright notice or any other identification of the
> - * University of Michigan is included in any copy of any
> - * portion of this software, then the disclaimer below must
> - * also be included.
> - *
> - * THIS SOFTWARE IS PROVIDED AS IS, WITHOUT REPRESENTATION
> - * FROM THE UNIVERSITY OF MICHIGAN AS TO ITS FITNESS FOR ANY
> - * PURPOSE, AND WITHOUT WARRANTY BY THE UNIVERSITY OF
> - * MICHIGAN OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING
> - * WITHOUT LIMITATION THE IMPLIED WARRANTIES OF
> - * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
> - * REGENTS OF THE UNIVERSITY OF MICHIGAN SHALL NOT BE LIABLE
> - * FOR ANY DAMAGES, INCLUDING SPECIAL, INDIRECT, INCIDENTAL, OR
> - * CONSEQUENTIAL DAMAGES, WITH RESPECT TO ANY CLAIM ARISING
> - * OUT OF OR IN CONNECTION WITH THE USE OF THE SOFTWARE, EVEN
> - * IF IT HAS BEEN OR IS HEREAFTER ADVISED OF THE POSSIBILITY OF
> - * SUCH DAMAGES.
>   */

This is not the MIT license (as defined by SPDX) - there may not be an
SPDX identifier covering this license text.

This is at least the second time in your recent patches where you have
assumed that a non-GPL license corresponds to a particular SPDX
identifier without (apparently) checking.

Richard

