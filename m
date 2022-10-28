Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D611610912
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 05:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbiJ1DyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 23:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbiJ1DyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 23:54:07 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D56C9B841;
        Thu, 27 Oct 2022 20:54:06 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id f140so3810659pfa.1;
        Thu, 27 Oct 2022 20:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SsqVuyl6BD6W3LOL9WC66L6RjSvAiVZfFFErAmVMHQE=;
        b=dUYSa32+9bO+LCOLFp+rBQ0F5Pnx+isYGovlF40t2/P9vWnEiDG1Q8itO/+XkeTfSv
         zeWWwwKbS7UPTj37mKzqvzWyo/9u79rMxtpNLZCnsQzGCKG4/XQEGI6rWazC+esHIrR9
         btLXbLJDJGt0QWJbBzwMHmRSR3zavgOTLsv3dHhkf0LRDL8A+8mbGkgYFXyRzhuBME86
         10p2gPkZHql6RgTLb1NnMmQGPGAKRLo8YbKihP4ZEHe9sgtbn0EsxUvy7e386JtBMfKD
         5P2utkAPzf/afxV4NKBCtAnnAe9Xynyms7eS195Tln69ZL4ofRdB8AwNHZDVRwsk8AX9
         RCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsqVuyl6BD6W3LOL9WC66L6RjSvAiVZfFFErAmVMHQE=;
        b=RE6vu/1Mbnb5HwlPtEs1RfGIt4II7SL2AzX0SH6ef5tTpxin8e15RF62zBRI8z8ZwC
         9qERpBLzJ2x+3SraGMZm9jMeQgJjohljJixMo+QC7EAOfSxCdEihAf9v12yRHswX+EDH
         sjycGHW5+PLvtRqRjeYF9i7c+oqUiRRqtLSy1f54w3mXxqUD4Hp6o0+LNTyRhygekhK/
         yfc9JR/MxSt9IDFvDA0r1n7DVK0HHJ7DXXNHMhZf/EMJDiFZAd3c1Tn2+n9hhDWUqQZG
         wrhTVyWqUsLBGlVfmq/yf8pYH63M77cfNUIjxEppJH38dZVzEOyWLfgnHNcDbFF/pS5Z
         /kBg==
X-Gm-Message-State: ACrzQf3elJKJCQ13hizGJNMT05yEOPHIhR8q4mVCOd8n0j4PLSa+3EkW
        APrLBw8v1S1k/r1memU3unw=
X-Google-Smtp-Source: AMsMyM4bStqmnjlTlD7oXh4az3KTHKmmK9eUmdVgeh7CmFo5zsALPHcOUlMD7hSZndCAJD9JRpyh8A==
X-Received: by 2002:a62:174a:0:b0:56b:9fc2:4ebd with SMTP id 71-20020a62174a000000b0056b9fc24ebdmr28907080pfx.21.1666929246176;
        Thu, 27 Oct 2022 20:54:06 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-58.three.co.id. [116.206.28.58])
        by smtp.gmail.com with ESMTPSA id b79-20020a621b52000000b005618189b0ffsm1888035pfb.104.2022.10.27.20.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 20:54:05 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 3F7BD10030A; Fri, 28 Oct 2022 10:54:02 +0700 (WIB)
Date:   Fri, 28 Oct 2022 10:54:02 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        yj.chiang@mediatek.com, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] dma-buf: cma_heap: Fix typo in comment
Message-ID: <Y1tSWo+eRvkVofbv@debian.me>
References: <20221028014422.16422-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9jroqsdkTIsPFvYm"
Content-Disposition: inline
In-Reply-To: <20221028014422.16422-1-mark-pk.tsai@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9jroqsdkTIsPFvYm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2022 at 09:44:17AM +0800, Mark-PK Tsai wrote:
> Remove duplicated "by" from comment in cma_heap_allocate().
>=20

This patch isn't typofix but duplicate word stripping, right? If so, the
patch subject should be "dma-buf: cma_heap: Remove duplicated 'by'".

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--9jroqsdkTIsPFvYm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY1tSWgAKCRD2uYlJVVFO
o7b5AP9yoSZf7rdWvcCNTl0/IR/t+dbwcnJqX/nlQZpEECxVKQD/Z3fAqDYIRA+n
wGfL9LkOMEPw+7g5fFLl5BC/vBZFBgw=
=krRN
-----END PGP SIGNATURE-----

--9jroqsdkTIsPFvYm--
