Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025AA6F90C1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 11:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjEFJBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 05:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjEFJBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 05:01:46 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B2CA5F1;
        Sat,  6 May 2023 02:01:33 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3ef302a642eso13844511cf.1;
        Sat, 06 May 2023 02:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683363692; x=1685955692;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZ/5LqweTtZrPkjTKwCpHOg2/Sdaepy5dm+TbvvEjYs=;
        b=dNrMv2iIFYICQFrW5CIPsF24kFW6ylwSmaK+s6ndfG79f7FUOl6n/9ejqCLLunmQev
         gzDMpDlTxd7GOv7veA63i9xXPJ4s6LzswOKOrVRRaADXGgA1fBY/v8kc/w9EbCEu4KRs
         ZEtGVVVu5DmGWAJrQXCJe+NZUrBBY6fIDUC52BSy9gQSW7NijeG7RBQRDEEXPEmZaQ7j
         dUAC8e6w0bDk4lxdnJaMsr2PblaTth07JaYlhW5ei9mdhegJKtKOsFJBnUiUpLdFSuOH
         3cWaeF7l7/hZ/y252hs6wgC8KR95ahrwqZm6Hy/2zmXDuwDstY8qBR91EsIbaHwWFL6t
         u5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683363692; x=1685955692;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZ/5LqweTtZrPkjTKwCpHOg2/Sdaepy5dm+TbvvEjYs=;
        b=jP4afuJXPLzK7XNjlUGjoaTrRMOeG1+URWbOrx0ezQELblZXjtBE+ZY70aJBUPKbn4
         WSNkBxPf0C3kUflz+oJrLSAFY1+hEXixNa/fMrEQgUsV6tDLHW2C9QbMOZUDo+MYZpwR
         OWcLPqWNt8vQX92Mi8NhfSqhYZZ86eKMV7CG3H7AN0qS4lBbTEiECNewqIJbF014pGCT
         g3sYXbcYqylm6Y9z0Uknv3fIxpWCkQ7hA9N+77l3R0NJd0MTJePRCjWVcPpMqOLyWwYQ
         5Bl6bKEnQQ2y0gjKct3i1LzZJ468DPNkybpKZadNYpc+Ca8FPjtYT9lVv51kXzHbIn/w
         fpBg==
X-Gm-Message-State: AC+VfDyPegbhO5R3zPehscKV4/Uf1ne0RTlx+ZCLX1OuhFSfmzK+UaLD
        +R6UODmyynkSDImRZTq3ATL2vPLX3ddOEDN5
X-Google-Smtp-Source: ACHHUZ5AB0u7MAH7jMRAkwYQ5CVq8beLin+sFaIK1Eh1YcYLJMkrkxKfob07B2nTjp3TMKMXU8AW5Q==
X-Received: by 2002:ad4:5de2:0:b0:5e0:5935:d80e with SMTP id jn2-20020ad45de2000000b005e05935d80emr5338425qvb.45.1683363692294;
        Sat, 06 May 2023 02:01:32 -0700 (PDT)
Received: from Gentoo ([191.96.227.112])
        by smtp.gmail.com with ESMTPSA id f8-20020a0cf3c8000000b005ef6128255bsm1220357qvm.92.2023.05.06.02.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 02:01:31 -0700 (PDT)
Date:   Sat, 6 May 2023 14:31:20 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     dhowells@redhat.com, jarkko@kernel.org, corbet@lwn.net,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]Documentation: Security: Consistent block output by
 removing a misfit line
Message-ID: <ZFYXYPivioHcQ866@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, dhowells@redhat.com,
        jarkko@kernel.org, corbet@lwn.net, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230506033738.16908-1-unixbhaskar@gmail.com>
 <ZFYFi+eS3efdx0jS@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1yHWxPoUvlWEjiHs"
Content-Disposition: inline
In-Reply-To: <ZFYFi+eS3efdx0jS@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yHWxPoUvlWEjiHs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 14:45 Sat 06 May 2023, Bagas Sanjaya wrote:
>On Sat, May 06, 2023 at 09:07:38AM +0530, Bhaskar Chowdhury wrote:
>> -	[root@andromeda root]# cat /proc/key-users
>
>You remove the command line, right? The preceding sentence should be
>adjusted too, e.g. "This file lists the tracking data (including
>quota information and statistics) ... . Example file contents::".
>
I don't think that is needed. Plus look just below that outputted block, the
explanation to the columns are given...isn't it?? That is good enough for the
user to gather.

That command line was unnecessarily present there,so the removal.

>Thanks.
>
>--
>An old man doll... just what I always wanted! - Clara



--
Thanks,
Bhaskar

"Here's looking at you kid"-- Casablanca
https://about.me/unixbhaskar

--1yHWxPoUvlWEjiHs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmRWF2AACgkQsjqdtxFL
KRUV+AgA1KEc8TAbc+AMKK5iH77eJhrWOZfog0+mvb3jM8WxHXZiKwQbkuyN8RtK
7oi9nWHvT4rv9Xk+VxL8Vp+9E2ndbQEqxTkwpHBKt5Cut7riGCHaPP7lxBbJkf9y
57ThzQTIxdYBnioek5YH9Frip3AxRMm61cigW7mxJ+a/okPkLy5NOEqJgzTckfTL
eOT3RvqE7tpSKvIsJeHPLdS7HDfSjWpO5xVX93XmdRBTxnIB4xMEiLoBLpfZh7El
kh8HADEl/B/mkICIv7BtN1IP4tj/KmYBgSDvaHk5vbjAVORbQnSWz1//LXymKSZH
bRAnNjjYzzzNJSX7tDjuESUIIbip0g==
=26sT
-----END PGP SIGNATURE-----

--1yHWxPoUvlWEjiHs--
