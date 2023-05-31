Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5E6718F20
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 01:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjEaXsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 19:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEaXsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 19:48:17 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC9212F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 16:48:15 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-33bbf34b497so683655ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 16:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685576894; x=1688168894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xl/rPfybuWWRREKP0y1CQScxSYr/byrO3VlKqP/h1s=;
        b=WdWPXGLfqJN3uJzhpy5lBQ1NXyB7nJIH8g3pN2eddplananhwguaQuSE10Z3hC+2HR
         6N9+5FU5552q9H0U6tSDgzyst+KdDy10Jsp3UkHVcFxCU3pa2UbhrX1PdGFgUUYupjaS
         NPyOY3JJIX/hp4TKuQhlP9pBzBLJSy2Ep38uY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685576894; x=1688168894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xl/rPfybuWWRREKP0y1CQScxSYr/byrO3VlKqP/h1s=;
        b=Okq7NwDCU8F52IUR5Fwd8QY7VD2lVv2HSWPHRNTUFmejfCdHpftp0e/L0zSe2r1CIw
         tca3qW35AriYM/DxD5c2VgxlYB0RwY2SH3OUPxRZaOwWVF3iKOmni7Dz18P6rQ++7AUY
         fn4yw2SjaCtLCGB+QtnTs6kh6di/xyoFpLyj2Zrut51phCYCYnRbjrp6DHuajleIfGks
         nh0j1c5Biex86GiAgF/aiOEd0WQ3jhlRt5mFdFH1XseN6In/daBegBS/Vqb+BvgRJsCs
         Y/qmERPujvWTa103tfPLWGaetkAg2woX4dTfgwx48J2abc7Uc0BWyQ45zNzV+5/YPPCl
         zIRw==
X-Gm-Message-State: AC+VfDzexeqonhFMzURoKy13bTibOOSvKrZDOrcSMEjdsHOG3FixJcHv
        RfvSzi+OqZx5EjPGgGhovYTQSnxblhNDDHMIYys=
X-Google-Smtp-Source: ACHHUZ5h9F+3eaumnDzhyx99+WynQzZHtNpdCep075qPxcq8ULuOQfz+ydvDyoN+kHVFxotExkf3yA==
X-Received: by 2002:a92:d683:0:b0:335:5b3b:72 with SMTP id p3-20020a92d683000000b003355b3b0072mr2889577iln.23.1685576893942;
        Wed, 31 May 2023 16:48:13 -0700 (PDT)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id j15-20020a926e0f000000b0032b56a80e1csm3343371ilc.58.2023.05.31.16.48.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 16:48:13 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-33bf12b5fb5so30435ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 16:48:11 -0700 (PDT)
X-Received: by 2002:a05:6e02:1ca4:b0:33b:7a45:a950 with SMTP id
 x4-20020a056e021ca400b0033b7a45a950mr93109ill.18.1685576890947; Wed, 31 May
 2023 16:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230530072514.22001-1-trevor.wu@mediatek.com> <20230530072514.22001-3-trevor.wu@mediatek.com>
In-Reply-To: <20230530072514.22001-3-trevor.wu@mediatek.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 31 May 2023 16:47:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XUKuDVb+B9i31TfyNwGY11MM-q6eJJVkrasj=GGboRcg@mail.gmail.com>
Message-ID: <CAD=FV=XUKuDVb+B9i31TfyNwGY11MM-q6eJJVkrasj=GGboRcg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: mediatek: mt8195: fix use-after-free in driver
 remove path
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.com,
        perex@perex.cz, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 30, 2023 at 12:25=E2=80=AFAM Trevor Wu <trevor.wu@mediatek.com>=
 wrote:
>
> diff --git a/sound/soc/mediatek/mt8195/mt8195-audsys-clk.c b/sound/soc/me=
diatek/mt8195/mt8195-audsys-clk.c
> index e0670e0dbd5b..09bd1a020421 100644
> --- a/sound/soc/mediatek/mt8195/mt8195-audsys-clk.c
> +++ b/sound/soc/mediatek/mt8195/mt8195-audsys-clk.c
> @@ -148,6 +148,29 @@ static const struct afe_gate aud_clks[CLK_AUD_NR_CLK=
] =3D {
>         GATE_AUD6(CLK_AUD_GASRC19, "aud_gasrc19", "top_asm_h", 19),
>  };
>
> +static void mt8195_audsys_clk_unregister(void *data)
> +{
> +       struct mtk_base_afe *afe =3D (struct mtk_base_afe *)data;

Same as in patch #1, the above cast isn't necessary. Other than that:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
