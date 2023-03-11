Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAF86B6117
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCKVpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCKVpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:45:06 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722776920D
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:45:05 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id d84so951864ybb.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678571104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V78i6y2U0JrvgA27xfI4kIOjh7BS243z1h7M0b9g4iI=;
        b=CAWhIbPWKjVi7CdJFPa7TuXndq4ajKqJs7evVWtdvZ1Pm8sMxs5sOFbn2CFGHFiVXS
         g2hzPCQRVOgkYRF8TkjIMf1oF+ZamxeA/w5E/VAufRVu5xWmM6UPUQ4KufBLuxnz96mJ
         GSEor/3TSqHw7KHYRUYMR7Id0wWUxney1RDbUuK/Mi0HT6tj/rjG1po4YeIb8F6GA/AM
         P+vGZB4uQgfLL+XzyZnQiLYZSQmQTFLj4GdkShV0lfzb+z0/DroSnhVMUaHtukAWFc+x
         0AH9qEw13tlZn5lJHc29ngleS1VCBg6q0uAyXPdaFV+w2smVJjxa1PO0cogHtqypnOIE
         yfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678571104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V78i6y2U0JrvgA27xfI4kIOjh7BS243z1h7M0b9g4iI=;
        b=vXdwKYIlJDdlosQbVhT5K2cW5yUd93td+aHpocieR9OyHWIKAfo3CG/dmXQpe08a9n
         YIiZJnPUoH9Txg0FwpFwYO6PNyL8ao0ku451Qwhz5TNyEYAk7kDLc16fgpry92Wmh6oO
         vr7FrVp3Az7TDRX2XTtDyp7eh/kPlEaCeVWHrxMNBJcz291GBOGsgoUYmcNwXQWaT1l5
         n4X3Q8v/vr+yhsrqM/KHOSFRMiRZ0qaZHHHMxg9jfE2NUOgjm+JsS3bUm5jun4nGwBkT
         GenHWefXExi9+ULLfAW+MLSmueunDc+2ufovDjBRJabgLIwCBwYZPFgKELWGKYjIsO1N
         3RLQ==
X-Gm-Message-State: AO0yUKWMDl8l9V6/no61t12Z5thv+DT7KcXtmcWsRIoGubzrKEuUBbbC
        ANpneK6fP5slWo0iRJusZ/HAowl3HdU37QzDnhv9ww==
X-Google-Smtp-Source: AK7set+39HzMoBpl+vvm9JGXuO6EGGnCk4eBVUYGG6a176w4mALlPDxN42Bby7S6RrQONDPKM6nr5DzH2Xk3Aa6DWwk=
X-Received: by 2002:a05:6902:4f4:b0:a06:5ef5:3a82 with SMTP id
 w20-20020a05690204f400b00a065ef53a82mr14712961ybs.5.1678571104368; Sat, 11
 Mar 2023 13:45:04 -0800 (PST)
MIME-Version: 1.0
References: <ZAxFBR3TdA7jUAgJ@gondor.apana.org.au> <E1pavEB-002xbR-I9@formenos.hmeau.com>
In-Reply-To: <E1pavEB-002xbR-I9@formenos.hmeau.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 11 Mar 2023 22:44:52 +0100
Message-ID: <CACRpkdb-tCWAHS3Bt8q2q3sXE5bWVVf42_qOS0ogKhCj_VRksw@mail.gmail.com>
Subject: Re: [v7 PATCH 7/8] crypto: stm32 - Fix empty message processing
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 10:09=E2=80=AFAM Herbert Xu <herbert@gondor.apana.o=
rg.au> wrote:

> Change the emptymsg check in stm32_hash_copy_hash to rely on whether
> we have any existing hash state, rather than whether this particular
> update request is empty.
>
> Also avoid computing the hash for empty messages as this could hang.
>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Excellent patch. Also works flawlessly.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
