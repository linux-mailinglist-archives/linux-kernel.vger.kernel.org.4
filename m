Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D367308E7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 22:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjFNUAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 16:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237086AbjFNUAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 16:00:00 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5C42125
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 12:59:57 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-56ce6bbe274so11756267b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 12:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686772797; x=1689364797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAeqM73hQTib+qIo+x85lSlZb1TEjjCMGiaiVcecPps=;
        b=TcXc37K8Z8nWxkcBaLdjZynn9z931IfFafYdBwOstUFBYX+kC1xE0ZkfRcfJ7a8tWj
         lQxec/GGX9PgEBt5lE2jmUE9j0TQqrirZO3lbXU8yeE9tRsZZRAKF6tF6VYqQ2zb6dfy
         T3nvJ2kG3R1kFpX6YCreF2lx11QCe8UHP6lxt/VGHIpq4JS1J9SljjopydnjfaVlXYzY
         2kNBz43+oOkB40p5zq8FxB9osp8D8hylbcA5dlbsjK7+FaCxKDWUIEZ92bQsNDzMrXK0
         fp4FZ9uyhcEfBOPIZ+/2xYMM6CZGNVkIX2F1ajL/gFEj0/v8j4+qYfQqs2ugKXMoBGqs
         3sPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686772797; x=1689364797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAeqM73hQTib+qIo+x85lSlZb1TEjjCMGiaiVcecPps=;
        b=hdt0oyLCpUJ/tNuMCiF6xioDWmKD0ZNQVLO06uv4ubNGqOMwlz28jpkQoVuf+1Anlf
         w0wOh4YGNdd5NxVhwF0q0714fQ9SHl2KPv77r9DhuBAixr/I2jsKUpCJRsnCyU/R2pVp
         ibRm19vANVIgTUbnXdkqNhFIRzIxT/kCVMtB9jXxJxw9H7Z33eTd6mb1qgcQlOKP1Joh
         76UvNMec4bc/j0x4gBISyhG/66wQaLH6uc7scEaF+d6j35L1eaStUL0AYZJKMa72rw/u
         EeMJ1Sz2nrhbsWh+ODQrOAV3QalChU1UM+VhhfGi4kxTTIzBOk1t8FpcJBCTkk1Oi3fx
         d8QQ==
X-Gm-Message-State: AC+VfDxNjrINiPpjoep6I5j9F8ESKNNX68DHrRrbWuoo30Q3TcTO6aUX
        lVH7ZaWLSlezTDo+vKJ3YjxxTD/BZxfTGLcmXqOuQQ==
X-Google-Smtp-Source: ACHHUZ6rg4Fc07moo8jNCEDxHPGsN3cmxKzyaD0Btrl7EQZiIZkg2yi8CHlM9ZCeCxFjFv42Ypvx9qXZ22mAI7q5eH8=
X-Received: by 2002:a25:aa85:0:b0:b8e:cb88:1b69 with SMTP id
 t5-20020a25aa85000000b00b8ecb881b69mr2923225ybi.34.1686772796831; Wed, 14 Jun
 2023 12:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230602115201.415718-1-matthias.schiffer@ew.tq-group.com>
 <628b7411-7d12-4915-80c8-cabb74ac6590@sirena.org.uk> <CACRpkdYhFmG-Cb-5+dt1Huktnm+tkOjSGO5ZFPjGeOXRott6Dw@mail.gmail.com>
 <20230614193044.GA2595668-robh@kernel.org>
In-Reply-To: <20230614193044.GA2595668-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Jun 2023 21:59:45 +0200
Message-ID: <CACRpkdaBtM8zzcdnXZH0pNFwTVOUPkUjfuahSJxgFRjcyDJ25A@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: dt-bindings: introduce linux,use-rt-queue flag
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
        Wolfram Sang <wsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 9:30=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
> On Tue, Jun 06, 2023 at 04:37:08PM +0200, Linus Walleij wrote:

> > On the other hand I think the DT maintainers said it is basically fine
> > to use undocumented DT properties for this kind of thing. Having
> > completely undocumented DT properties might seem evil in another
> > sense, but I think Apple does nothing but...
>
> I don't don't know where you got that impression. I'm fine with them in
> the sense that I don't look at downstream and anything goes there.

No I was mistaken.

This was me misremembering that the "sloppy logic analyzer" from
Wolfram Sang was OK to merge without any proper bindings, but the
reason there was that this is for debugging only, but I don't know if
someone told him that or it's his own claim.

This is not for debugging only so it doesn't apply anyway.

Yours,
Linus Walleij
