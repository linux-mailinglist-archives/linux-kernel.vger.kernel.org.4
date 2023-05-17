Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111B6706ECC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjEQQxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjEQQxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:53:07 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD29A7A95
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:52:41 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-510d1972d5aso1305538a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684342357; x=1686934357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbLIWNwbWi1oPfkJYehay++7vldUE9mgEn/i2k6StuA=;
        b=LOT6zd+dCqQmaTvAuzv+iEr0Jw4BhTBe521buKQszAUMoN1iBVTP9sWxjD8uf8VN2d
         jl6HA6GVlY3gmKGnODyfN7mElerddiKMdf+q0GNJ659dsKmskJOC1wlUfdZY1nYkub4a
         zl8RwPvQ+lareVeMcG84Xi48Aa8OFZ9lN1HsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684342357; x=1686934357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbLIWNwbWi1oPfkJYehay++7vldUE9mgEn/i2k6StuA=;
        b=US1SGUxCX8/FsPGVNNqs1X2YOzkSMIO+A3okMsI0f+QW7+0md5TsVLREukzPWFqMhP
         XMxmh8IPvIVTedp2IB0MVFjP+xtkPUrZs2oPGlsxpQEa2G66JM8tepO32E7BgD+v4np3
         wArCeN3thkTTpFWcrvCnWNPLtCHIyzFkxQi2hocf97IaO7qSuPvD4Ycrp7Ub3QQEjreT
         mT8uwK3FU1hS6BCctI9GYAB/INfUGKYi7gWjOjHhwaz9tclzPJ8pMO9tn69W9kfdz7C1
         sEqi/O1S7S1+5lg6dSulbwIDG0aMuntikc09dFxntCoCzPLo9+dz/FMgoyH95Li4NUJK
         P48Q==
X-Gm-Message-State: AC+VfDzWR5iqNbPI0VBfvZwW5ixywpRYsFv1uYTjp7/2yzk4nrU2fFeg
        iezDz6pXSAjSuYvl7EiorUR4zZ4qdVR7HLpM0+lm/Iom
X-Google-Smtp-Source: ACHHUZ57Aj9UjiMlJIZaieg37tMLNKaSngX+0mG1UadWKM+PHXt+2cYfJx71iNohZ0ssK5pNmxzwTw==
X-Received: by 2002:a17:907:2d11:b0:96a:411a:1cc4 with SMTP id gs17-20020a1709072d1100b0096a411a1cc4mr25647241ejc.66.1684342357367;
        Wed, 17 May 2023 09:52:37 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id p1-20020a170906838100b009662b4230cesm12758901ejx.148.2023.05.17.09.52.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 09:52:37 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-96a2b6de3cbso156768066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:52:36 -0700 (PDT)
X-Received: by 2002:a17:907:7d9e:b0:969:f54c:dee2 with SMTP id
 oz30-20020a1709077d9e00b00969f54cdee2mr28364544ejc.26.1684342355901; Wed, 17
 May 2023 09:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230516000208.4008443-1-jarkko@kernel.org>
In-Reply-To: <20230516000208.4008443-1-jarkko@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 May 2023 09:52:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiEYewsSM0SbdBbdX2DhUNcaZptvS8NPKZES41vr_H=bA@mail.gmail.com>
Message-ID: <CAHk-=wiEYewsSM0SbdBbdX2DhUNcaZptvS8NPKZES41vr_H=bA@mail.gmail.com>
Subject: Re: [GIT PULL] tpmdd: three bug fixes for v6.4-rc2
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 5:02=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/jarkkojs/linux-tpmdd.git/=
 tpmdd-v6.4-rc2

That didn't work at all.

That "jarkkojs" part of the path seems to be just wrong, and it should
be - like always before - just "jarkko".

I pulled it from the correct location, but I don't know how you messed
that up - maybe just a fat-fingered mistaken edit, or maybe something
else.

So you might try to see what went wrong...

              Linus
