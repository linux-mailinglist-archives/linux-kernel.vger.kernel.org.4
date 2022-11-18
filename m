Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FE462FE4F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiKRTwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKRTwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:52:33 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B07B08FD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:52:32 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o7so5400868pjj.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V9pF5mpVc3B6b5fPqNSwwVAKIqb3BcTax6YAV4Xry14=;
        b=qNg0CIGaljUFzhEfI4vH3ilp1WNLxwEYLuLTg2/nDaXyF8RtJ5J3fgSt4pPrMuPHR/
         3fX9ZMJkyKJ1L7i9ZYga96hfG9qF/5dKmouAS75cDgAltrEShqqjpKRVJBjeWrGs84s8
         zb2FOwrJSVJdoIW3D6bJ254XqCIvEAc84niDnr+CWTj59FHI1er80f1dLbL+G2DnlM01
         dWAtjzn1xEu0sLWlhAdPV677CD6o87LRCx83oGwqmm0HmYSjMRKkbki5Q/xWGpUob1r2
         tm7wTT5W2DjIlJv37BC3hQ22uIsDDggSkg9opQG56JJeDw+vQFmGP6MRbPfDpWt9X/ZL
         23WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9pF5mpVc3B6b5fPqNSwwVAKIqb3BcTax6YAV4Xry14=;
        b=S17adZ6H5UEILSwp1f+Vy/kRot31IJbIm1zDi6weQpitfIaIRnBay2o1qsRBVmP8NA
         ylqM373aODB/xPgq9NNEuqVKfYxVIpOt8Q7DIN0qr2Ms1+aq95hbvVyEJ+fBgpH3cf7m
         pe/b+gC2HNUevlWmpKlv9FS0bEUNj1NDfP2PfKPcWnd9z57+flXI3JnIOBrb+/GquHvA
         h+bW2+vgldLYFuJQGLo+yWsOKI/em0ixFtxCYwgw0J/eB9p8k756sLIBhnVJr70Q3GRr
         qxTa7CAiRW9V2A11/uGG2PuXl1aqW6HRFZBi0mq5uAys5h2Pfct7Pfh36sFdi8Y/JhPl
         q9mw==
X-Gm-Message-State: ANoB5pnMvxmdIr5fyEX9LiB97YT6M7gAjkYOwDT2CS7pjXHGN9wtC0l3
        tlNZTs0E5ASsbGxVNjp4hyy+GA==
X-Google-Smtp-Source: AA0mqf7FWoYKybRn5fseRjhUf3xjBQFYjHdmdctR3NDS0M1rjX+qWJeY5s1nwX21Y9ulybgSC9iwJw==
X-Received: by 2002:a17:902:ebc1:b0:176:a6c5:20c9 with SMTP id p1-20020a170902ebc100b00176a6c520c9mr1028458plg.57.1668801151469;
        Fri, 18 Nov 2022 11:52:31 -0800 (PST)
Received: from localhost ([75.172.139.56])
        by smtp.gmail.com with ESMTPSA id w10-20020a63160a000000b00473c36ea150sm3106891pgl.92.2022.11.18.11.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 11:52:30 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bernhard =?utf-8?Q?Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogiocchino.delregno@collabora.com
Subject: Re: [PATCH v3 4/7] dt-bindings: pinctrl: add bindings for Mediatek
 MT8365 SoC
In-Reply-To: <06e916b7-f8f2-6de5-f86e-7b020c052451@linaro.org>
References: <20221117210356.3178578-1-bero@baylibre.com>
 <20221117210356.3178578-5-bero@baylibre.com>
 <06e916b7-f8f2-6de5-f86e-7b020c052451@linaro.org>
Date:   Fri, 18 Nov 2022 11:52:30 -0800
Message-ID: <7ha64o9h1d.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> On 17/11/2022 22:03, Bernhard Rosenkr=C3=A4nzer wrote:
>> Add devicetree bindings for Mediatek MT8365 pinctrl driver.
>>=20
>> Signed-off-by: Bernhard Rosenkr=C3=A4nzer <bero@baylibre.com>
>
> Thank you for your patch. There is something to discuss/improve.
>
>> +
>> +  pins-are-numbered:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description: |
>> +      Specify the subnodes are using numbered pinmux to specify pins.
>
> Why would you name pins differently per board? And why this different
> naming of the same pins is a property of hardware?
>
> This looks like something to drop.

Yeah, having this as a flag kind of implies that this could be present
for some boards but not others.  But in practice, the driver requires it
to be present or just fails[1].  What's the right way to describe that?
We're just trying to add a binding that reflects the existing driver.

We also noticed that there's another documented binding with this
same flag[2] where similiarily, the driver simply requires it to be
present[2].

So is the way this flag is documented in the stm32 binding OK for the
mediatek one also?  If not, what would you suggest?

Thanks for the review,

Kevin

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/pinctrl/mediatek/pinctrl-mtk-common.c#n1053
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml#n37
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/pinctrl/stm32/pinctrl-stm32.c#n1499

