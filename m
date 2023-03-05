Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2516AB2AB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 22:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCEVvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 16:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjCEVvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 16:51:45 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37EF1114F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 13:51:44 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-53916ab0c6bso150219667b3.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 13:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4nagVa5A/zThSizaZWcAj9+LI0HVFxK9izn7FANSgc=;
        b=IAn+kCbqQsCW+Kqg1JURWxcIvDd/JjLFYkB3TvbTA+IrrUjtIuNnoObUDW/G/lxUfc
         XqNOE9bwR29rV5d0tGhTiGygqI4cxkDCN9iOdJ2R3WBNPtkIry86TEK7HlYzn7Obq7M+
         vU+KbEzCWj400IbzEN5fZJUaCXY71Xp5OHXD1UZ6Xni01b3EaRQjOTDkd+8R29scMIvJ
         cl3TAsZ1DAxOcPlwD7YFOgwZIrPu+tO7eqo0xHH2jQYlV05MczXTdGJvaVBbrBw8LrW8
         dlrQdfd+WP5+aHVgQZVUJ9+khXmZ2Czaouv3Iz5G3bqaxmnk+DBGraicQ8eAZEo2XCnH
         xzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4nagVa5A/zThSizaZWcAj9+LI0HVFxK9izn7FANSgc=;
        b=UbKPDgR3u+dWj4MdMlL/i2d/Y9LrmlQ0GvNNP1VqAab+2V1xJ2Ngyh7kJ8RlJ2VjjV
         OQK0LaLC4dYdYoG9aVKSjRbu7NBjLvk4ntYP/JSa4d4ei79zPhqmuGrof6Tg26cGzcMq
         BTB8TVnWthTcXRfUe9wGMUGWRgkpUk7sGekT8fkoIhr05G2Ak4OVg88w0KI4ACTqwgTG
         R0yhehNcsMUiiNRojYpUaoB6dVII9GTkd2/kl2g1mBwGHW5crxmqWkB+duxDX1b5UwD4
         gVEi9JtFfPQUyE7sPmnh4z/OZ64CmIyuhNKM42Og3VSUQY1zq0kaxGB6YC/TPlFCHk54
         ZvdA==
X-Gm-Message-State: AO0yUKUkcTui9f1bTfOjPq+VfGMGeHdoj+7Xb/Vd3kYWXbqVo3sDTeDp
        SH1eZ99GLHXKw8wERYr2rLKdjaEOGzCP+MIKd0qYTw==
X-Google-Smtp-Source: AK7set8WqgWYN9z/yS50vyhHB4nsTvSMESsxVTSN3nt8vqTEYgHy8/ZF/JobK9m0Y3iTYswh1vfHlW0HsmFqfaqLJdk=
X-Received: by 2002:a81:b624:0:b0:52e:f77c:315d with SMTP id
 u36-20020a81b624000000b0052ef77c315dmr5580789ywh.3.1678053103873; Sun, 05 Mar
 2023 13:51:43 -0800 (PST)
MIME-Version: 1.0
References: <ZAMQjOdi8GfqDUQI@gondor.apana.org.au> <E1pYOKF-000GYm-MW@formenos.hmeau.com>
In-Reply-To: <E1pYOKF-000GYm-MW@formenos.hmeau.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 5 Mar 2023 22:51:32 +0100
Message-ID: <CACRpkdYH91rgE7wF17pDi58z9Rq68JqNxbR2XMQ0=si_w7aCnA@mail.gmail.com>
Subject: Re: [v5 PATCH 2/7] crypto: stm32 - Move polling into do_one_request
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

> There is no need to poll separate for update and final.  We could
> merge them into do_one_request.
>
> Also fix the error handling so that we don't poll (and overwrite
> the error) when an error has already occurred.
>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Works like a charm and passes all tests.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
