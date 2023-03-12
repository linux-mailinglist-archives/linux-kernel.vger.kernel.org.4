Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506096B6B05
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjCLUXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjCLUXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:23:07 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DD81A958;
        Sun, 12 Mar 2023 13:23:05 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id da10so40960811edb.3;
        Sun, 12 Mar 2023 13:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678652584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zx5Hx16VtrsWGIQLk9WwOhEjwlykZ68lI6lzjbPZklw=;
        b=Hf8bDIgSRyHgy9bXQ/Gk4nexYiqXGYoCYtQ04Ivh+iCVbpJ2b5wzrRnb++ax5WG5YU
         l1ECC7hckmqBIWK0FYKledOUlR/8oGb9iU/bprqDFfYvUnH9HXOkXMuEU7AitS1oLCXw
         myetldVYFfznoSCvDzeKhgZkcDBm8pW0l/vGCJjUPX1DzrdmVRAKk857IvrVjfQ9XSKG
         2N5oK1VtlQxJyFx4Mf99gdPkQnYe53VpL6QT66oSCLZqVHMC0inMBQbwy20+y8itU9ok
         BWs74qxV0g+EZr9O9dScl2udx1DcuJJXJz0jv3NNva7rrPcHkok53W0tVeIcIuzzmOKr
         qkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678652584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zx5Hx16VtrsWGIQLk9WwOhEjwlykZ68lI6lzjbPZklw=;
        b=5WazXZ4Qz/NvVm69OT/4CRb+qs3zBybI4XyOjHhtZ2HGBsJnO7YyG4RpfiOcYm6+o5
         cyLDc2l7ucDgX0tzoymHyCVqXlVq1EHGNjs4+dZdkywVG4EkHZdtqhvKK119p/F3piQc
         0TGai7S2XDPqLvSBJcIlhc0OrNsWNiFvZs5yoB0AHVM0VsXC+lAtrjHL3wj0SAOanyBv
         vr+8j1wpmDdfxQxLe3HM/NBWb39hg9UXlvBsjcerqQ89/210CVhg+c5tQy1DE5nT36ea
         PscKoLpWvDxV0m5/90LV5df19AlkOiGOegetNPjbIfsiaV6BVdCZhspFxIPvXBhUroEr
         ZMqA==
X-Gm-Message-State: AO0yUKWDXZNYedqeOj/tFuiK2AoU55wxDKsI6DZlsxd/Ipej6kHQxhQ3
        YOSQe/BnHYB1rYqlmPnxtCG5QxC7RNPpS20Lx40=
X-Google-Smtp-Source: AK7set9zgGbqFrzGWxNsXVoKpAldwMmxSrIf9cZOIFv0n5RvCM/bJPrPW3NGvz9pmm0rGWW96q1mG4aHSyR0BOq+UH0=
X-Received: by 2002:a17:906:e58:b0:922:ff34:d814 with SMTP id
 q24-20020a1709060e5800b00922ff34d814mr2005221eji.6.1678652584109; Sun, 12 Mar
 2023 13:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230312131318.351173-1-krzysztof.kozlowski@linaro.org> <20230312131318.351173-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230312131318.351173-2-krzysztof.kozlowski@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 12 Mar 2023 21:22:53 +0100
Message-ID: <CAFBinCDTRjqLfJvs=dtQNS0=5mZSDAdR8tQNt_qLt-BH9+P7MA@mail.gmail.com>
Subject: Re: [PATCH 02/28] media: cec: meson: drop of_match_ptr for ID table
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Joe Tessler <jrt@google.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Bin Liu <bin.liu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 2:13=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might not be relevant here).
>
>   drivers/media/cec/platform/meson/ao-cec.c:711:34: error: =E2=80=98meson=
_ao_cec_of_match=E2=80=99 defined but not used [-Werror=3Dunused-const-vari=
able=3D]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
