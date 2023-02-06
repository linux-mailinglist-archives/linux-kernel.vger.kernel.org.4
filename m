Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B9068BB20
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjBFLSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjBFLSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:18:04 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B719ECB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:18:03 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id s24so12239663vsi.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 03:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/rwXX77gDObBsNSKOYPKq8KrSqNKeQDtYRqpUJ33YBs=;
        b=jCUFeCsz6BfoHukI2ABxuTMF6frheMup3DbNltf74R+lX5vdhqT82KSrIsPkTmAlqH
         P9WTfXjQBNReHstzUK5VCcyNK8sTRGc5acp/3EmbWQzJlaJUOh88/8ukFH33dUUZDNq2
         VvrIM7vGnUvJtzPpLYx5Lu6VhhkmPBtsUaij8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/rwXX77gDObBsNSKOYPKq8KrSqNKeQDtYRqpUJ33YBs=;
        b=pGpUo6FLvOdChR7w0DkfoxjCDH7CpU277ATvRjNOUwndjrraNlic6TvfpVK4L4vaX9
         pwLDipVG6zbcThrhtSVs/srhILBSmRmvR7UMcoN9DrLVnhquJ3Ss6Q6rqLVS3id9k9mg
         XgPfAMB6ji5a2Y/bUpEGsgXnvcHCbcQrfkSfPuj/S3TLcox6iERVQmMJRiSeD7hVmi/Z
         U2NOtW/FW8A/gsviMS+s0U6ASa1iPBUR3aHEM1UQtth1Uy77bdkqo64an+DUNE5BW8YX
         x/QbIR1x9YJWzyF939eM9XZIRruMUx9cje9BF/8p+q+rsR7Q3wALwDBf2oaE+enSsifB
         3slA==
X-Gm-Message-State: AO0yUKVx1WGlOeXl2xj5H14pmyQkATUNomzaBW+3fkNdVUz8n2r/HPt9
        eDsQbRM2e1A+MxXJiVSQ0PzyjINUAUpq5Xoiqxng/w==
X-Google-Smtp-Source: AK7set/KGmltEInT6XzqPPO0IQbyeDjR6qLXf6JqdQTYRJiNedxftxWZahdnYF2TPrmK1NolkMQXMg26ZTZ9DH7wHKs=
X-Received: by 2002:a67:d21a:0:b0:3ed:2cd6:deed with SMTP id
 y26-20020a67d21a000000b003ed2cd6deedmr3458075vsi.65.1675682282519; Mon, 06
 Feb 2023 03:18:02 -0800 (PST)
MIME-Version: 1.0
References: <20230206091109.1324-1-moudy.ho@mediatek.com> <20230206091109.1324-6-moudy.ho@mediatek.com>
In-Reply-To: <20230206091109.1324-6-moudy.ho@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 6 Feb 2023 19:17:51 +0800
Message-ID: <CAGXv+5GFkNmH=Ltb1o+9eB=4+FfuNk2T3OGk1zWjsrweGbzKkA@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] soc: mediatek: mutex: Add mtk_mutex_set_mod
 support to set MOD1
To:     Moudy Ho <moudy.ho@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Roy-CW.Yeh" <roy-cw.yeh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 5:11 PM Moudy Ho <moudy.ho@mediatek.com> wrote:
>
> From: "Roy-CW.Yeh" <roy-cw.yeh@mediatek.com>
>
> Add mtk_mutex_set_mod support to set MOD1
>
> Signed-off-by: Roy-CW.Yeh <roy-cw.yeh@mediatek.com>
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
