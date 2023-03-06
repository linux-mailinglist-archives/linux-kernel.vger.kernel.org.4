Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3517B6AB844
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCFI3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjCFI2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:28:55 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED3CAD02
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:28:54 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-53cb9ac9470so169505487b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 00:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=519NpLUqxOKWPBwAuOC9bU9ZvrYJvgJKHiIp383stmI=;
        b=W3sGp9tNOLk4oOb1TbBhmTVgOkfoc3jNvYh/DHNAvPgy67bZMPKLQWxrpJ0zDdcp+m
         S3wh1xHQnwUyPdXvJ2fnkADVNJh2ucQuqk4rR7iDOAB1VWSAMBZ3P5S2esv8D81mx3FE
         ySbGrtbzeZbdtXEo3ZG24oQN8iTy8LnSxuKH8dw90uG1ciqhzoJCBWUZhZsfgiv2IoPf
         aMVk4WiNShz8IChoW/yMstyhaBVYtGJ+MTlDC2Yv/xDdfulCssgz4JYckicGNUKxZrb+
         YrQT7vimpOgsn4RLRyxeyCJ1YxtNjprHA6SvcTTjvdn0BOvpVeUsEtY2+pqoxK1Svzc/
         TgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=519NpLUqxOKWPBwAuOC9bU9ZvrYJvgJKHiIp383stmI=;
        b=RT/FcLKjJp1vLatP6XVc1TZzVTmcy314it4/Sjzs1t4Lz8NVwDRJuaX7yv1PzUofr8
         O+vG8E2ok4eOLNZSeeMcvxXnOyCUhPva8wjoi/OQ4Ek3gCnmFo/FZR26nYiii1f/oOwy
         eMqdBfNMPmIajF9mLomTBMNAk/eJnn20lrN2oQsXz8Q0Z3YYKLBFk4J1ner2CKABRP3H
         uGm8PIn4cafswGYayL7gpHzpVQlVSuIn2pZdHULuvly0SFPDaDehyu0G1xeMXTbIIPyv
         pIvZzhDypwTFJZADqTubV0Z+p611YmlX+5vJ+zv/e6T4AQvuNJyYA3zZJAGeRs+BIPhS
         IpYw==
X-Gm-Message-State: AO0yUKVl2b6rz+gkuuimbDTsRcD1m7+3MEcO0aJzOMUR7IbPH2S1kaSx
        pOEMiH4RFIFIsBr8fsVn3zRAd1gurAYTM5EAeqnVZg==
X-Google-Smtp-Source: AK7set8qJpcrUyUWuXm2GtgPYfVJIrTfSr7hyswBMwx4xoG28NxTC5y13Rie+RRDGbzHFSPGeKUBnzA9auOnDQ4Aey0=
X-Received: by 2002:a81:b624:0:b0:52e:f77c:315d with SMTP id
 u36-20020a81b624000000b0052ef77c315dmr6476228ywh.3.1678091333277; Mon, 06 Mar
 2023 00:28:53 -0800 (PST)
MIME-Version: 1.0
References: <ZAVu/XHbL9IR5D3h@gondor.apana.org.au> <E1pZ2fj-000e1B-Kg@formenos.hmeau.com>
In-Reply-To: <E1pZ2fj-000e1B-Kg@formenos.hmeau.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Mar 2023 09:28:41 +0100
Message-ID: <CACRpkdbfttwCoMPQATNkj1_sbhs1H_s7vfXRQbW_dDf4d_dUBw@mail.gmail.com>
Subject: Re: [v5 PATCH 3/7] crypto: stm32 - Simplify finup
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

On Mon, Mar 6, 2023 at 5:42=E2=80=AFAM Herbert Xu <herbert@gondor.apana.org=
.au> wrote:

> The current finup code is unnecessarily convoluted.  There is no
> need to call update and final separately as update already does
> all the necessary work on its own.
>
> Simplify this by utilising the HASH_FLAGS_FINUP bit in rctx to
> indicate only finup and use the HASH_FLAGS_FINAL bit instead to
> signify processing common to both final and finup.
>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

This "v5.5 version" indeed works!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>

I had to pick the patch manually because Konstantin's b4 tool
got completely confused by the version numbering and picked
the old v5, but once I got the right one, all worked fine!

Yours,
Linus Walleij
