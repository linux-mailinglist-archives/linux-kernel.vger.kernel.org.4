Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F5471A2FF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbjFAPqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjFAPqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:46:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D3018D;
        Thu,  1 Jun 2023 08:46:06 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-96f5685f902so135929266b.2;
        Thu, 01 Jun 2023 08:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685634365; x=1688226365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IklIgLnDv67Hj1MMNmzU2HBbBaSNxYen7DB/Lbq+r38=;
        b=Db3slDYbs6+0atRzy1FP9c6+k/n4PieWOJfpRxPPfOlhlhRN9/EVb6OgpebC5tm+qU
         /1kNIqDBQJwn+/yA0YSSMMYinmdUsWYR7YEFJp7C7jScE0DAKIdiJXu/t2D7IRrRsKro
         dwJoe8OMBCq2SKX+1VMlXybrPj9+uS8skJTpu570ZKFrDjL/Y9JRbvio3+9uw33GkE0P
         eX43X/9n3T23Gbqfor5bUNgE23DERuOJdC/h58WcCUNwsTnASMuGXWJRBx1RsEt83Suy
         hiLYFUIC5l8E4JQT4SwX8OnJBBYVJdCUhLyXoWcz/qmJJ3PC5emlc11Fd5Q4pMja9jO+
         6TkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685634365; x=1688226365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IklIgLnDv67Hj1MMNmzU2HBbBaSNxYen7DB/Lbq+r38=;
        b=GiT+6YPSewvYQ/vRL2fmPtkm4/uQdeM5V9I4IUO6Uu/LtSjRhEuwB3Q3p/Ax9yQQ3W
         7J9+qxLGDlKDFSDG6Std08n3K1R7LX4R6lJInM+MpKJ/7tuVxusG6mJz8su4Q416+tE8
         zbRf0kZSUt3UkYPqvjfF9iTA3gqwoTPZcF3WDqAU7og5z/Uk0ouMSsOtSnF/HXHXh+9E
         pt4DT8c9lsHgMN1he/0Y6cvC2zqUIrKFotWIewhdZ9lLIg6hu5T7ysv5fc4Ep4mfaJdV
         fJMe51QyycZygsNvZP77EWoJgafzMCfNDj4iefG8sUxZ2ru7ZfWk7ThhX2kcf5wSXdX9
         g4Pw==
X-Gm-Message-State: AC+VfDxEUFWa4ixGxQohjtJzASbD32qWQvCcrihjDdVSAGKPeTR98EVD
        O/4OFXQfJy1YFxgGs8ouEr4=
X-Google-Smtp-Source: ACHHUZ7Fbw9B2kY3i0cLSoiipzTsYASE2XF2iggqBNdNQITA9VLCljQ7MOgpw4SU2+Gba0EnHRO3hg==
X-Received: by 2002:a17:907:7b85:b0:971:5a46:8ac8 with SMTP id ne5-20020a1709077b8500b009715a468ac8mr10300665ejc.27.1685634364702;
        Thu, 01 Jun 2023 08:46:04 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id a8-20020a1709062b0800b00970f0e2dab2sm10601105ejg.112.2023.06.01.08.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 08:46:04 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/3] spi: dt-bindings: allwinner: simplify with
 unevaluatedProperties
Date:   Thu, 01 Jun 2023 17:46:02 +0200
Message-ID: <2226283.iZASKD2KPV@jernej-laptop>
In-Reply-To: <20230601095908.563865-1-krzysztof.kozlowski@linaro.org>
References: <20230601095908.563865-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 01. junij 2023 ob 11:59:06 CEST je Krzysztof Kozlowski na=
pisal(a):
> Remove properties already mentioned by common spi-controller.yaml and
> switch to unevaluatedProperties:false to achieve same functional effect.
> This makes the binding a bit smaller.  Similarly there is no need to
> allow additionalProperties for children, because spi-controller.yaml
> already does it.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


