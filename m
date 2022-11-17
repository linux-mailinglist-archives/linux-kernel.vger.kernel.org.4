Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BAC62E5F5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 21:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240695AbiKQUc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 15:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiKQUcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 15:32:39 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7AD8E299;
        Thu, 17 Nov 2022 12:31:33 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d9so5740799wrm.13;
        Thu, 17 Nov 2022 12:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgNvfOAXHjmuiPC01RZ20qna6kcHy47I8cgRmcZ99PE=;
        b=GPWC5/m7Uw7YC2i7MtfzvNQKjQj92U/QyivvzOTm8wW2FUYg3zYCbAOehzWCJfG2vN
         2PG3m0DjUtTAOH8qCf97ydoFXAqbEfo89LgSJ/GIkW7vz3vY4iDW5utlq56CTQ7O8JUx
         rs98pW7mgYcrl1AJZWJJjAfKWUrtnNX8o1aNj+Bond+O3mo32NnqFpKEt61K7xeXiDmO
         Cp5ljx/Sjv2W4s9gLRmQ7ngyYLzktfXZufWEmMlIgzsaa/DrDu8i8n48qFkW5d81mnTX
         KV+sqb8AQYl+absX7x0b0rwu509eKG8ZKFFE54KR+ioE3gc0jWf+Kw9xxK3jwqrqFBLo
         H6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgNvfOAXHjmuiPC01RZ20qna6kcHy47I8cgRmcZ99PE=;
        b=DevplD2mEPdIJDWffcK9YCkDM1JmabL3HpuxNHOif+9a6wVBRcabNEcC8mEf42F9Zp
         2wm8aavexR5TJcqWXoOg97iwRrARKuFgslhDylrx1kVl1V4Cx6CHWe/eaZ/TBx9AYGWw
         JjQyTI9sNLENo3bpyGjW5WZB6h2UriYpbRx2oyota7sbZ7yC8Zi1CtaIdpfkcphPNeaX
         6CA6zKj1SKWel11H5uE90YKHDmIEi0hru3wFekd32kSbnwForh8Vz7PVs6tttM45Tl+E
         5TvXsPdeuNKNT/CAIFrZsIidur0idCMNmEvtJTaajjbcLQFJULmJjYf94jp9lYFOp2UV
         Pe5Q==
X-Gm-Message-State: ANoB5pmr9OyRo7XR3Wq82WcjnODW3yAPSRTDlN0Eiin4cak7Hthkx34+
        e8sg5A6JTyn+oOOD68o9eAo=
X-Google-Smtp-Source: AA0mqf7RJtH6v9Zfz+C1oJd50K9FMeHOnHakHTlbrjVBkVMLt5/yV5A7SZvyhJITGCArwqpsEss0YQ==
X-Received: by 2002:a05:6000:1d97:b0:241:b99a:949f with SMTP id bk23-20020a0560001d9700b00241b99a949fmr2041636wrb.599.1668717092011;
        Thu, 17 Nov 2022 12:31:32 -0800 (PST)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id e18-20020adfdbd2000000b0022da3977ec5sm1795243wrj.113.2022.11.17.12.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 12:31:31 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        samuel@sholland.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] media: dt-bindings: allwinner: video-engine: Fix number of IOMMU channels
Date:   Thu, 17 Nov 2022 21:31:30 +0100
Message-ID: <3385828.QJadu78ljV@jernej-laptop>
In-Reply-To: <b0125ad2-426c-d908-0839-2021bc59d59f@linaro.org>
References: <20221117060704.367945-1-jernej.skrabec@gmail.com> <20221117060704.367945-2-jernej.skrabec@gmail.com> <b0125ad2-426c-d908-0839-2021bc59d59f@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 17. november 2022 ob 14:13:00 CET je Krzysztof Kozlowski=
=20
napisal(a):
> On 17/11/2022 07:07, Jernej Skrabec wrote:
> > Cedrus (video engine) on Allwinner H6 actually uses two IOMMU channel,
> > not just one. However, Cedrus on SoCs like D1 only uses one channel.
> >=20
> > Allow up to 2 IOMMU channels.
> >=20
> > Fixes: 62a8ccf3a248 ("arm64: dts: allwinner: h6: Fix Cedrus IOMMU usage=
")
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > ---
> >=20
> >  .../bindings/media/allwinner,sun4i-a10-video-engine.yaml       | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-eng=
in
> > e.yaml
> > b/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-eng=
in
> > e.yaml index 541325f900a1..6446004d59d9 100644
> > ---
> > a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-eng=
in
> > e.yaml +++
> > b/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-eng=
in
> > e.yaml>=20
> > @@ -55,7 +55,8 @@ properties:
> >      description: Phandle to the device SRAM
> >   =20
> >    iommus:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
>=20
> You have several compatibles in the file, so usually this is further
> constrained per each variant in allOf:if:then:.

Usually, yes. But this whole binding would need update. It has a few option=
al=20
properties and none of them is tied to any compatible. Additionally, if I d=
o=20
it as you suggest, then Robs automatic test will report the issue, because=
=20
existing H6 based boards won't match this binding anymore. I would much rat=
her=20
send follow up patch which clears up all optional properties.

Best regards,
Jernej


