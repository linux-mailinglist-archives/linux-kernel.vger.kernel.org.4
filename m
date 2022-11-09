Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26F662258F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiKIIfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiKIIfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:35:40 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBB813D40
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 00:35:36 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id l11so26123263edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 00:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k8fvs6ZLrtWuqZVQNJvhrDmomoK5We4DH+DPcS14DXs=;
        b=lnOICEvfI5Cmg/z+B29K6fsVoFPSvm96Tn0v0oSq9SQe5PpKjBBNuZsKlOHuw3prwh
         bz5WRPbuW8Rka8Ov1RD+alZNC+IGt6lelQ/k46POqvcqK9KMpaPAJO0nvSk30OMe4DUx
         c6B1hnH7/1NloX0lBCiQzi4hcOHa6PXcPU8tqMDnwTpSzfuMLPKQ7eIkqxNEn/q9JHEe
         /b7nHPWfo40sqY9iMNbRkLhcHfAoocfTO3bP1a/z2DnxjZf6uUZ36PTEq96wPoqlDHvx
         ZyDL6hMW1hHVSey4g59sgQwVUwc57hJXDkf1R0yTCvS1md7bUzg/OIrr/8q7RnFyGbEZ
         uGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8fvs6ZLrtWuqZVQNJvhrDmomoK5We4DH+DPcS14DXs=;
        b=yapqDPecH5pBmejOmCM5BSr+rFj1NKxgWz1OX7aAcy5EJnnpaxDHS8TvJFhnIMHrlb
         RP19w5wcdtVHHBLWitxsubBnXObO3dE+VHqgWMjX91YUnQdbv6M35IbATvi8hXKJm6tr
         wHtl5DBn5f3+DqhyLf/id5Mx7ZodtoPRArMn3je+SpYkyqwT+Vahqg45oD50buGiTL9I
         XHCF4hF2dqjQny6KwCAtcYJKSR/Jop2M4yl1R6i6DQdl/2O8rJxg1SARXmbzJm3w5GFm
         eTaCPdh+sqFQrT8HSbpALpFrlfVZDK9fnK4n4VH8L7w5sfrHzG+lrm3Dke1qKjmvV/hD
         /mwQ==
X-Gm-Message-State: ACrzQf0dsqZpcQhXnWTvdt2PLImbNopgMPhkOrGo856p+FD19fuy8W1W
        wxRL6S45+WwRTJ+VD7I0CJcQuYeOlXm3rtdKzlAU+Q==
X-Google-Smtp-Source: AMsMyM5OJCIBIeknoBw6Lq+al4dOTO2RtuWkP39C/1cvOzN3fAtGKtOFElaafSt8zrTEgVy24311eV5FoVnIXUyChE4=
X-Received: by 2002:a05:6402:2996:b0:463:ce05:c00e with SMTP id
 eq22-20020a056402299600b00463ce05c00emr999064edb.46.1667982934854; Wed, 09
 Nov 2022 00:35:34 -0800 (PST)
MIME-Version: 1.0
References: <20221104105605.33720-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221104105605.33720-1-angelogioacchino.delregno@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Nov 2022 09:35:23 +0100
Message-ID: <CACRpkdav-TK5VrJ+qdzw9af-+orPTfHUhUDmaw0VyYW4Kh9c8g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: common-v2: Fix bias-disable for PULL_PU_PD_RSEL_TYPE
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sean.wang@kernel.org, matthias.bgg@gmail.com,
        zhiyong.tao@mediatek.com, wenst@chromium.org,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 11:56 AM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:

> In pinctrl-paris we're calling the .bias_set_combo() callback when we
> are asked to set the pin bias to either pull up/down or pull disable.
>
> On newer platforms, this callback is mtk_pinconf_bias_set_combo(),
> located in pinctrl-mtk-common-v2.c: this will check the "pull type"
> assigned to the requested pin and in case said pin's pull type is
> MTK_PULL_PU_PD_RSEL_TYPE, this function will set RSEL first, PUPD
> last, which is fine.
>
> The issue comes when we're requesting PIN_CONFIG_BIAS_DISABLE, as
> this does *not* require setting RSEL but only PU_PD: in this case,
> the arg is MTK_DISABLE (zero), which is not a supported RSEL, due
> to which function mtk_pinconf_bias_set_rsel() returns a failure;
> because of that, mtk_pinconf_bias_set_pu_pd() is never called,
> hence the pin bias is never set to DISABLE.
>
> To fix this issue, add a check to mtk_pinconf_bias_set_rsel(): if
> we are entering that function with no pullup requested and at the
> same time the arg is MTK_DISABLE, this means that we're trying to
> disable pin bias, hence it's safe to return cleanly without ever
> setting any RSEL register.
> This makes mtk_pinconf_bias_set_combo() happy, going on with setting
> the PU_PD registers, which is the only action to actually take to
> disable bias on a pin/pingroup.
>
> Fixes: fb34a9ae383a ("pinctrl: mediatek: support rsel feature")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Patch applied for fixes.

Yours,
Linus Walleij
