Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B73A71463E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 10:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjE2IYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 04:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjE2IYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 04:24:40 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B0BA8
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 01:24:39 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b0424c5137so6515255ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 01:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685348679; x=1687940679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nvt0GJ2QNY+rFYHNBGjXKBYm5GhXHIFHMKlgbX9PLZk=;
        b=R1NVU0pqq0Dlw2lqS4BrSYDie0cRmWwcq722khiiwhlJ1YNKNQ0F6ayuf6Jc25fxEV
         REWSG+z/8WPD1DjCSlsculfyM8tkigqWD5Xj/GJgTPI/phXg37BIF2Hi+yX75SRZLHfH
         iwMokATwsMXSgyps3tN4o2dssa+qY6qCZGwo8wmc+XSLWsrGV0IQmlfiDHLOZiP5RZ5v
         lumbspD7eBzCD6D9G/IHfgfBHPwHtZyw4gl8zf/PJJ+X1RDJd5jkrS6S2s4/C7YW0QX3
         gfLh/85bQ4+4Mj/MxQyGhAI3ac667ZIJMUpq4XfMCUES7qk5Ra1ZRe3TWU3wGHqBzDik
         qKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685348679; x=1687940679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvt0GJ2QNY+rFYHNBGjXKBYm5GhXHIFHMKlgbX9PLZk=;
        b=KUWZQ3SFYJfo6rbLpY7E+9n6Rfdu2hKdiA2IQBeijK2WPYA4Re7waqOfYd3jG3qEpX
         wmMyt1ZNnP157ACINkr/xRqglwh197155Ictqe7RbMUrhLMReboyNe+i45YEoCO/VlK+
         VH1IRjVoneIK6pgV+pb21W7JBaMqwKVoihKe48h//sJqUhWlEUfjDDRxhbJpVjbVx2W1
         m1POrsGh172axtBtV6FRZaLlTuWgo08kS+gksMa3shQPVCjbVEr3pcz4+G8f998hs8Sy
         p70Yj8dbaPxGvLGlntG0NKCOhYvSMky/s3EhM6y03IaCM4XBESak+OMBs3kvpc/t1Swy
         stEA==
X-Gm-Message-State: AC+VfDwqdc4/t6QJ/nqVVO0DQw+2diUh7M3vMaIHkjTWe67LmCK93fgw
        WwahffeVXSgXoLh7kDoTwj8xjGtnzTg=
X-Google-Smtp-Source: ACHHUZ70mYW4u96RSo3Ry/YJBBDWbyHuvhnrjdHhLlQ0uGBtm0rqCM5LLQsGo//UKx+Iq7pYhSiRZg==
X-Received: by 2002:a17:902:a610:b0:1b0:4b65:79db with SMTP id u16-20020a170902a61000b001b04b6579dbmr475567plq.63.1685348678850;
        Mon, 29 May 2023 01:24:38 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-78.three.co.id. [180.214.232.78])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b001b012589c49sm5637750plb.78.2023.05.29.01.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 01:24:38 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id BD8B6106A11; Mon, 29 May 2023 15:24:35 +0700 (WIB)
Date:   Mon, 29 May 2023 15:24:35 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Doru Iorgulescu <doru.iorgulescu1@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>
Subject: Re: Fwd: ./include/linux/mmzone.h:1735:2: error: #error Allocator
 MAX_ORDER exceeds SECTION_SIZE (v6.4-rc3 build regression)
Message-ID: <ZHRhQ92aXQCQa_yK@debian.me>
References: <2a1cd5e6-01f7-66f9-1f9d-c655cc3f919b@gmail.com>
 <5d22e1e9-0307-3664-8b4a-99caaaaa4315@gmail.com>
 <87bki9ai11.fsf@mail.lhotse>
 <CA+39qUjP48n=EwqHzwdGkBE8SC-nTNZHZxEfG4r4hWC-5Bg4HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n0n99li26aKBWElc"
Content-Disposition: inline
In-Reply-To: <CA+39qUjP48n=EwqHzwdGkBE8SC-nTNZHZxEfG4r4hWC-5Bg4HA@mail.gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n0n99li26aKBWElc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 06:13:52PM +0300, Doru Iorgulescu wrote:
> Awesome, thanks!

tl;dr: see [1].

(Hey, looks like complimenting noise here.)

[1]: https://lore.kernel.org/regressions/5df92692-296e-3956-24fa-2bd4393379=
53@gmail.com/

--=20
An old man doll... just what I always wanted! - Clara

--n0n99li26aKBWElc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZHRhQwAKCRD2uYlJVVFO
o+jyAQDEMW9U8RtyW3eLmz1vfYY5zX7zMISeoeMx9Ep+ODtNAgD/XvY+dmTzM2sW
OCQZJxqHfzgzTV/+CFXMZ4UMTRIWagI=
=vA0l
-----END PGP SIGNATURE-----

--n0n99li26aKBWElc--
