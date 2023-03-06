Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F8C6ABA90
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjCFJ7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCFJ7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:59:20 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1F01027B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:59:19 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-53852143afcso173957557b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 01:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmCoxFXOjygQDIzK1tZa6oHAVDWZOb2fMdPu8gYG9LA=;
        b=R1GDPbh4yVZ0p5iRkuHOTmZh5TuKhZv4Wcznyvdjvx0OoqKh7ZF783XLGZ/vpVQMXz
         bCxdyNge9U+zOI4R5TbF+OpFlm5lbt2Qo3EfdH+Mjpqa+skPMwa6qSsiZjmvWLi7nox0
         EQTgXhI1kvDjXvrCq/9ssHTd0DY3B4thYvsE4B7UoyjGhjV+knXolZqr7rp1nqS/yS6+
         QVLPGBm47vUQoRSG3tH5RMEJoNoVYCEBPeG1o7pAKfR14gefnbQGTHm1yD4PzUq2pYvS
         BMJcXBupsMXISEkc3h9zDNew5Z7P8wyr7AluMml9ITeCq0CbnJdj0VSjQhuk0RAEbZfG
         Oavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmCoxFXOjygQDIzK1tZa6oHAVDWZOb2fMdPu8gYG9LA=;
        b=FXwAFnLbkygNBcw6rAwY7mM+0fneXkhMHwrSjNtH0kE/WZHBl9aHcyQv2p9Y2jeJm/
         TaVKCO5myDiIopsBVMk/b0PMGvcCRiLut3SISP9vbk0j5IPRKyvK6xVQ5Tg4da6UjCX3
         WMec7wFdyS49NUcA9pURm4YxWGCKcDpw/idwjxPcsfDaUrrLr4NBbSjwOq3hZ0O2kRNI
         9gCNc7HV75kG7cIjYPtaSVQKmP+CSKZKKos/MnYB75KYAMXHsjlqDdvzgAmpR943jSFq
         96Wz6S+R8XnfPJFKvnH5qqlYCF0y4NBzZeYI0n6BIXTR518u4xQo9a7hgHV1r26sjFLG
         4xMA==
X-Gm-Message-State: AO0yUKXVS7f4n6LOyLerop/p2e1RWZ5KybRga58wIcid07yxjVCNXmFf
        8uiIuaycuSsUoOaI+ULrB9usq4LBApcMMJ71wKElCw==
X-Google-Smtp-Source: AK7set9thiTXKi70kvUYtjvGioPgktg/AQjQIDH9/Y8okcnfS3yBXcctmzIV8JdJro5UMpz5tBKLzbCtxmBve6+SzEo=
X-Received: by 2002:a81:ad24:0:b0:52e:bb2d:2841 with SMTP id
 l36-20020a81ad24000000b0052ebb2d2841mr5996953ywh.10.1678096758438; Mon, 06
 Mar 2023 01:59:18 -0800 (PST)
MIME-Version: 1.0
References: <ZAVu/XHbL9IR5D3h@gondor.apana.org.au> <E1pZ2fn-000e1d-Qm@formenos.hmeau.com>
In-Reply-To: <E1pZ2fn-000e1d-Qm@formenos.hmeau.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Mar 2023 10:59:06 +0100
Message-ID: <CACRpkdZj5Ou75TN4pFjDU==5=6nSzBtsszzOiL3U3D3JK=RLqw@mail.gmail.com>
Subject: Re: [v5 PATCH 5/7] crypto: stm32 - Move hash state into separate structure
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

thanks for keeping going at this!

On Mon, Mar 6, 2023 at 5:42=E2=80=AFAM Herbert Xu <herbert@gondor.apana.org=
.au> wrote:

> Create a new struct stm32_hash_state so that it may be exported
> in future instead of the entire request context.
>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

First the patch bugged but I found the problem in a small semantic
glitch:

diff --git a/drivers/crypto/stm32/stm32-hash.c
b/drivers/crypto/stm32/stm32-hash.c
index de8275a80271..3743f55b5c04 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -785,7 +785,7 @@ static int stm32_hash_final_req(struct stm32_hash_dev *=
hdev)
        if (state->flags & HASH_FLAGS_FINUP)
                return stm32_hash_update_req(hdev);

-       return stm32_hash_xmit_cpu(hdev, state->buffer, state->buflen, 1);
+       return stm32_hash_xmit_cpu(hdev, state->buffer, state->bufcnt, 1);
 }

 static void stm32_hash_emptymsg_fallback(struct ahash_request *req)

Afte this all (extended) tests pass fine.

Just fold in this and you can add:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
