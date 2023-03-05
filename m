Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456BC6AB2A8
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 22:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCEVsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 16:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCEVsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 16:48:19 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A37EB55
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 13:48:18 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-536bbef1c5eso149909557b3.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 13:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLT9596esNn9+ZcDd3rcdHbsJUKw8b1aHwiveWbhaq4=;
        b=z8VAIRkfAxemi/FtNcAurB8B2D6jDvXRySFM6h+xAQyuToi6WuFeJY1DcnkWkDln4B
         nK0Hkwwq4ZNcB9OpZhT8qq76gu9rv0NWrg89giWkop6p+o3dcPg5T0/VsDc54iolxtEJ
         LTPZuI8c6nNCHC0IyUrbZvR5NdsIoJEOWL+11zsCe2Qu3NH7ng9qB/h8o8Z0YTyDzvFV
         qW1zS1pNW6fsn9UN9F9d+W70tNZFaFDPCTvp3nnu3hHrDXi1qLXirJzWC3nNNcGeVqDF
         J1aAjvlIGTN0R/Rcj+HBn4PQkVuw4CB4pAqjn3+sQXmn/cdZZO9QNH2EKCosQOn+u+Xi
         065Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLT9596esNn9+ZcDd3rcdHbsJUKw8b1aHwiveWbhaq4=;
        b=bauM8vejvRI6TSze6jkTWiBn10ztTwCEws8azbAovDSqtMNlbUbY6EtEA8WXsGajaH
         UI7S1RJrCCrPNnr6H8xB0G0gKW3NAuBRBsvyCZQUVg9+/RUTQGx1aPxYC15hWbBV54ha
         /tanL5iXw/sI8/f0Doybz3nSUhIqOpozgNgLsO2KfLru4Sc1knY6lvf+7VEs4qFxl3fd
         h0WBAIxPDtsoPJrzBwo2/XM2nB59ViEr1mrwg38UEK/+QmmGcSJd1XMlX5/xa7q3K9I7
         pTXrGOBEaRlrlaEM8DaGfuVp0uJxjNzpmlmTmp4FSvYHNCAaSEzi3wKSBowNkVPJ1EnD
         6nbw==
X-Gm-Message-State: AO0yUKXU2vIjCFd40nn6ar3Au8B1JMWsJegbiOD9x3fFeIXYIUpSYmYZ
        B+1mDKgoKY+tQDeUrMTmJrOhT0yKIB/9HIlEx1Y8cA==
X-Google-Smtp-Source: AK7set9PwbP37M+qcdmd1OrmePnuWQ5cf/oim9FxyxWYN5ZTGhjFStopLAhPM2VM1sBwIOJyAtQgfJUn/9eHK0O0pGA=
X-Received: by 2002:a81:431e:0:b0:533:8080:16ee with SMTP id
 q30-20020a81431e000000b00533808016eemr5437131ywa.10.1678052897405; Sun, 05
 Mar 2023 13:48:17 -0800 (PST)
MIME-Version: 1.0
References: <ZAMQjOdi8GfqDUQI@gondor.apana.org.au> <E1pYOKD-000GYe-HX@formenos.hmeau.com>
In-Reply-To: <E1pYOKD-000GYe-HX@formenos.hmeau.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 5 Mar 2023 22:48:05 +0100
Message-ID: <CACRpkdYcGx_=GufsRwtRm_tCeZFvYFM+R0CGK521=DSRo+WXXw@mail.gmail.com>
Subject: Re: [v5 PATCH 1/7] crypto: stm32 - Save 54 CSR registers
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Lionel Debieve <lionel.debieve@foss.st.com>,
        Li kunyu <kunyu@nfschina.com>, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 4, 2023 at 10:37=E2=80=AFAM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:

> The CSR registers go from 0 to 53.  So the number of registers
> should be 54.
>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Hm I don't know where this misunderstanding comes from.
I think it's this tendency by some engineers to use index 1 :/

The datasheet for U8500 says:
0xF8            HASH_CSFULL      HASH context full register
0xFC            HASH_CSDATAIN    HASH context swap data input register
0x100           HASH_CSR0        HASH context swap register 0
0x104 to 0x1CC  HASH_CSR1 to 51  HASH context swap register 1 to 51

0xf8, 0xfc, 0x100 =3D 3 registers
0x104 to 0x1cc =3D 51 registers

Indeed 54.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
