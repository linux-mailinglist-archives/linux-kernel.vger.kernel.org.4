Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EBA6A0547
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbjBWJwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjBWJwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:52:34 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485B9515E9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:52:29 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-536c02c9dfbso166749147b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyLlud2sMTYzZimgt3LXDWS5h05sJ2yVKAsksslDR6M=;
        b=ZLQtg4FtpfbiG3pBPGZhMDpS7wCOS2l/Vb/EzOb30N3BpV6OVBj7JZJcCdktYZtAS2
         RGW0dtqmnR+dfXUGssVahvHzdlIIb3Wr6NT5kUUJrlu7BrbwGV02bV3l6E5fzO6bDj70
         SvP2iiqLVg6LEFnvB4bPhSTHAD+gDohAdIL888wz1YBebd/zeDePN5CA8aEU002zeqpO
         ZcehMW3NdG05r1TlY879Hxp5xNtowiQ88BYx74B5pMhCj0t8remt3/dVwp6+clGooA2h
         jjbouEQg1rLtL49fdfDKchmHDrOXR/tW5qzs7HMR9ZX/tYH9q7MbxhVJDA529CYGk8kN
         AOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WyLlud2sMTYzZimgt3LXDWS5h05sJ2yVKAsksslDR6M=;
        b=acIxqROVvWIljvda/WohSyRBb/W8T+zI6BNgIGFCOeRT8Pv0DX+mUUTFHxGmzZwd9K
         R8s3oJxlgz7XNRCrkqac/b/WuzvecPa5JvT0RvViTW/56K+lVSxf6qbXHxsPk8pnN/e0
         335b3ICpzw8RshPv+yaJvo551tINoYsGacJ4yD8V73EatGXyuknInY+hc0A8QQehgIdT
         RqThhw1qJNWpUntXiW9XObVe250gBqQHMvtcEO/R1AkBbejivpUscQKKr1QOhJqV7vNy
         reHaV5pWc1TKUKNkWiEOV5zeNuo6a7TO04kc97zD8nte066kLQUKoMs+3xGtOnJRkY92
         VzEw==
X-Gm-Message-State: AO0yUKVNJUxSpSzNkvvv59uiWxMEQKlzo8feR9jS+tA2yt7TiStgYAX7
        wNBOfXO/E48wv7VhDvw6TMwsPREnGYtAq41qJUrEYDigasV6yT2IbgE=
X-Google-Smtp-Source: AK7set/KtoAzQrIYU+2Mgk/pLUdmIb9s9QFOvjUwjQxM7F7nAZs/oSVNu3EBJvX3mgr7i2poBtd8kJyvbE4QOnKDsUs=
X-Received: by 2002:a25:918c:0:b0:8da:d0ab:258a with SMTP id
 w12-20020a25918c000000b008dad0ab258amr1705814ybl.5.1677145948475; Thu, 23 Feb
 2023 01:52:28 -0800 (PST)
MIME-Version: 1.0
References: <Y/cBB+q0Ono9j2Jy@gondor.apana.org.au> <20230224231430.2948-1-kunyu@nfschina.com>
 <Y/cy5wUtk10OahpO@gondor.apana.org.au>
In-Reply-To: <Y/cy5wUtk10OahpO@gondor.apana.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Feb 2023 10:52:17 +0100
Message-ID: <CACRpkdYyB=-UnE1bmdVszSSB5ReECZ0fUoWJX6XtYbKHEe52tA@mail.gmail.com>
Subject: Re: [PATCH] stm32: stm32-hash: Add kmalloc_array allocation check
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Lionel Debieve <lionel.debieve@foss.st.com>
Cc:     Li kunyu <kunyu@nfschina.com>, davem@davemloft.net,
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

On Thu, Feb 23, 2023 at 10:33 AM Herbert Xu <herbert@gondor.apana.org.au> w=
rote:
> On Sat, Feb 25, 2023 at 07:14:29AM +0800, Li kunyu wrote:
> >
> > hello senior:
> >   'rctx->hw_context' is a member of the rctx pointer array object and w=
ill pass 'memcpy(out, rctx, sizeof(*rctx)) at the end of the function;  ', =
copied to the out pointer memory, it cannot be released, I think this patch=
 does an allocation check on the 'rctx->hw_context' pointer should help a b=
it.
>
> Ugh that's completely broken.  You can't export pointers.
>
> I guess this driver needs to be disabled.

Added Lionel to the To: line so he can look at this, I guess we should
also add an entry to MAINTAINERS so that the reports come to the right
address.

Can we fix the actual problem? It seems to have been there since the
initial submission in 2017.

I guess the right fix is to export the *actual* hardware state into "out"
and read it back from there instead of copying out the rctx struct.
Also .statesize needs to be fixed to correspond to that.
I can just use a roof:ed constant size for this.

If Lionel does not have time to look at it I can try to come up with a
quick fix.

Yours,
Linus Walleij
