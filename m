Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCEA6DA7C0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 04:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239320AbjDGCjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 22:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjDGCjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 22:39:39 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFD57EFE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 19:39:38 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-23f63d5c1e1so75721a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 19:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680835178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NBVOEqxpgiCbAWvdZeqZe+d64IeRDd3vq7CGJXCHfoI=;
        b=IHoEhyFntDYzL98o5LdnvwUlxMyLKhHC2fWYkrXiRfKMxcYAE31ttSfjY/ElRHf5Uh
         XDCm1zEfVsIfrcghY7QFirxTeVTDBZlgfN4KXPKk2D4qUyCQLiq2YQc7vKZkhjC1PnMD
         hlaiG7IRKBu6TcIO/tZhy27mGweeS223arUpblpvQ3nf6WHmt1dtirTdCQdoqVWXMQdZ
         YR6Kqi5OjZyMxSeo5Y6xgpf2/G4F3CVQCf2aIl4kqb8QuiPbVcQjPuV39RWu31tukWfx
         Tfo5BHXIlWBPyTosgwKTTreo8mCKdx66JJc1Im8d8oXYSA7qNtWxIXLITMublx1Z4ufU
         kb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680835178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBVOEqxpgiCbAWvdZeqZe+d64IeRDd3vq7CGJXCHfoI=;
        b=bgkkEHzmapCU/hOUdIWoA7HAUrWcwjSE5LtFT3ZMMxaGWovT+g6sEHTffP+Hcm3jS8
         iwmu2qC1B46ZxzkyLR7TdxNQ+1vrlb/cHqWm1qNTM/hDyoMyY1Qd2xHi70UW8/RRAS+D
         NKE9+Lg1Apk13cbqA2zjBxktqU44krzKXh4dTzlulPU99Q7sis9RRCgR6dOrpGOqhLaJ
         td0COkWWmo3XcjeltJ0lKEr8QsLVkuTe5Wrg32eA1R00cE4w0BKW8cLgXggqVVj/omXJ
         kUxKboovA7AKlQVw39LCDBTkJ3FhdOlCPAaBN0GuWdAkZb2t4GYqXFrYzDc56ry467E9
         XtCw==
X-Gm-Message-State: AAQBX9d0aTBeQKI+MboynUj9zzwcOc0QBM1WcN2ABW3QN9F4X/Aw5B+b
        b0JwGD/+y7lrVrkUpQ5W1J5qiKTTGLkRMA==
X-Google-Smtp-Source: AKy350bR3uo5XxTwtGoKWWH+cHfole/N4ZzMz13r3OX5xHp7BRKunkLqcmGtlffogMVBARkKiq4+ow==
X-Received: by 2002:a62:1a4e:0:b0:575:b783:b6b3 with SMTP id a75-20020a621a4e000000b00575b783b6b3mr812224pfa.28.1680835178223;
        Thu, 06 Apr 2023 19:39:38 -0700 (PDT)
Received: from debian.me (subs09a-223-255-225-71.three.co.id. [223.255.225.71])
        by smtp.gmail.com with ESMTPSA id a27-20020a62d41b000000b006242f4a8945sm1959800pfh.182.2023.04.06.19.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 19:39:37 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E412A1067E5; Fri,  7 Apr 2023 09:39:33 +0700 (WIB)
Date:   Fri, 7 Apr 2023 09:39:33 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: add sanity check for proc_mkdir
Message-ID: <ZC+CZX7t7y5P7pzA@debian.me>
References: <20230406193716.70796-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rO3abuu8EiNNIM9e"
Content-Disposition: inline
In-Reply-To: <20230406193716.70796-1-frank.li@vivo.com>
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


--rO3abuu8EiNNIM9e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 07, 2023 at 03:37:16AM +0800, Yangtao Li wrote:
> Return -ENOMEM when proc_mkdir failed.

When out of memory (memory allocation fail)?

--=20
An old man doll... just what I always wanted! - Clara

--rO3abuu8EiNNIM9e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZC+CYAAKCRD2uYlJVVFO
oxrtAQCnSRDYP6qLenhTtR7gX5UMS3nUGkMCPxVqqTKrJTYMtAEAowFEyo48+rPk
Tp0hLdPH+n21+81qt6ceY8+j+w2QfQg=
=RcoI
-----END PGP SIGNATURE-----

--rO3abuu8EiNNIM9e--
