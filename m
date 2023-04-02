Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752626D381F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 15:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjDBNha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 09:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBNh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 09:37:28 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557C1BBA4;
        Sun,  2 Apr 2023 06:37:27 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id iw3so25603377plb.6;
        Sun, 02 Apr 2023 06:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680442647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yJE4pnnm0VUmz2w+YWBprkOi8rvRZMPtDmxykOoTYl0=;
        b=FMU7hZhlEGokCgTkSlI+CZmrkXTLHUq3462QmDzr5XRKGXHE+wRKAvyF0KjAjp7AzR
         x5S51/tBKEqm8uzwaDMYmZTbWA0niw5NY8M9V+HOcyCDcT9FugPaiJD1LDkDLHGHbizM
         19IIhh95/d30jcBFqPsvYFljT0N+5Q5IKs/34h4iZxqps1srA0b09IgQwZ2mCV02IexC
         rwIvvHuN0mpWovDft1j8/QR3dkpDSaZu+bF1dJehUk2MRUFSa1KBcz0CvDDNmAOMPJea
         +bvAOf+M1j2hQCRqSX8m3aTUnVR/9yvheXX5gCGc0E5nX6xYC5K+FZXUddDJsCkW1nkl
         8M4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680442647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJE4pnnm0VUmz2w+YWBprkOi8rvRZMPtDmxykOoTYl0=;
        b=wmKnOX/uqaridGqqKRvtteTkVmnzU/btGRJEF6kXHGF/jRM21vOClUcAAg1WoGEp85
         YPMrrjLPGbMCuNHMy3NF7CzOkuchNQI0RPRmmRsIBkm1IMqvH5JW63VdPDbHTkxF5sue
         Qc2W1SQv0DTcmEFGt9Fjm3iNxkW7ce3QozJvsXr0qEklcXTCoSym+K4rsT12KVW8R1em
         i8jWsF8cS9nhBn3TdN7XojbrEPxgAhMhZPFXfPFd8LdRVpWT4r37DqvW5C1WJsyvwrMa
         V4orchK7uvHamE8u5Lg8tBzFVOM/Czdjy1W4uopwLytLpNL95aQnlRJG3JY1jAG1bwkY
         1UtA==
X-Gm-Message-State: AAQBX9d0HpT6RKFGU0AGO0jksXh0ZkRSavz+DejczmSRXLfGx8kFXKdN
        WIAWge2NCGA4QtekzOnAgeM=
X-Google-Smtp-Source: AKy350Yxz2CiSI0uFgBbOpXYxtZGf7jmzV6zy8iqCUmxCu8v3vRH8lvCoUEkqjO2J2gRF+NfjeTDAA==
X-Received: by 2002:a17:903:28c5:b0:1a2:9183:a499 with SMTP id kv5-20020a17090328c500b001a29183a499mr9689820plb.34.1680442646834;
        Sun, 02 Apr 2023 06:37:26 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-38.three.co.id. [116.206.12.38])
        by smtp.gmail.com with ESMTPSA id jf2-20020a170903268200b001a27e5ee634sm4798774plb.33.2023.04.02.06.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 06:37:26 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 893461066A7; Sun,  2 Apr 2023 20:37:23 +0700 (WIB)
Date:   Sun, 2 Apr 2023 20:37:23 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-stable@vger.kernel.org
Subject: Re: [PATCH] mm/swap: fix swap_info_struct race between swapoff and
 get_swap_pages()
Message-ID: <ZCmFExoOsho9pt+Q@debian.me>
References: <20230401221920.57986-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kZSKbbifSvmxXjNz"
Content-Disposition: inline
In-Reply-To: <20230401221920.57986-1-rongwei.wang@linux.alibaba.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kZSKbbifSvmxXjNz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 02, 2023 at 06:19:20AM +0800, Rongwei Wang wrote:
> Without this modification, a core will wait (mostly)
"Currently, a core will ..."

> But, a worse consequence, panic also can be caused by
"However, in the worst case, ..."

> In this patch, we lock p->lock before calling
"Lock p->lock before calling ..."

> We also find this problem exists in stable 5.10.

So, you claim that 5.15.y and 6.1.y aren't affected, right?

Also, Cc: stable@vger.kernel.org on the SoB area (as pointed by kernel
test robot [1].

Thanks.

[1]: https://lore.kernel.org/stable/ZCiuGEkyk%2F1Afisk@ec83ac1404bb/
=20
--=20
An old man doll... just what I always wanted! - Clara

--kZSKbbifSvmxXjNz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZCmFEwAKCRD2uYlJVVFO
o7N9AQD6KAL9B/rP0BIGjyYtOvCZvnVm5e3JKQg+Aoc/W8gKbAD8CecN3SdI0E2k
n1uesdLFbR0vE9W8lDWjeZLr3z0cnwU=
=P7MJ
-----END PGP SIGNATURE-----

--kZSKbbifSvmxXjNz--
