Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F230718F1F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 01:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjEaXsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 19:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEaXsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 19:48:13 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506A912C
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 16:48:12 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-33b3cfb9495so802195ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 16:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685576890; x=1688168890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssi9hji3ougqZcnJfZaYXLr+1zSSxDjh3rVcPrdEtNo=;
        b=K9vtiLjauLAheH/706FVQchuFhyZnP5Lrpl3x/r/LZcYoWfDbldHhY6Pg0wiMMk34L
         FiVrxU1jrZsvA7ha/w7YHVnx6HTokPSvdzsfrMud0L8sX1SK/5Hp03BJU/trjdNGhSop
         PVg4MEQrq4sWRneZnpmf1yFpKHEHWQg7aCf8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685576890; x=1688168890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssi9hji3ougqZcnJfZaYXLr+1zSSxDjh3rVcPrdEtNo=;
        b=QmNkHOf7mJiQM1lEiea/AlOq6l8d5xvlivA2NatpfLo3qOZCjp4OZklLXzDTPMvf7m
         enYpgnqy4Qrme1qAVgcSZk6Bbj5dmcqunhWUsnck1zdA2LwYLUHW7bb2l3671oo+/Z2m
         3L0KB4rAhOd7g29zx5f8NUpEbA+TKU4oRlluxSjAmaSeIVhy2O8hAZTcL1bJtD3I512G
         veZMXXqNgY+nUdBOI2MTkdT+a8wkWWxFmlVq26DPCFeUrv+qIw0dP+K+INV7ZE1bjSoC
         31vHkPJWy//268RaHG1HEnW34ISeto5CDo62TacVGZzVyOZA2gghODLTJsSWLEd7CswX
         fP3w==
X-Gm-Message-State: AC+VfDyOo9HUCwhJIve1Wt608P9EnqgqHn+skmRJh6Ah0GfDNMXm287v
        PWVwGdQ8z5KotaVpx11D4Q3MD+dc7Zz545DtYU4=
X-Google-Smtp-Source: ACHHUZ5ePqtXYcspqbSvGQNMOcJNTEPjABZkNDCd5tPLZJo0RWc25Ne/VAH5yy60foBvTnyjKoKHkg==
X-Received: by 2002:a92:c611:0:b0:33b:dcbf:e711 with SMTP id p17-20020a92c611000000b0033bdcbfe711mr4701967ilm.8.1685576889973;
        Wed, 31 May 2023 16:48:09 -0700 (PDT)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id m8-20020a924a08000000b00326bd11f5d1sm2040638ilf.11.2023.05.31.16.48.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 16:48:08 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-33b7f217dd0so61675ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 16:48:08 -0700 (PDT)
X-Received: by 2002:a05:6e02:1786:b0:33b:3bf4:9f42 with SMTP id
 y6-20020a056e02178600b0033b3bf49f42mr32601ilu.19.1685576888336; Wed, 31 May
 2023 16:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230530072514.22001-1-trevor.wu@mediatek.com> <20230530072514.22001-2-trevor.wu@mediatek.com>
In-Reply-To: <20230530072514.22001-2-trevor.wu@mediatek.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 31 May 2023 16:47:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X1JURLwZHraNwSMT7vwLNRNw7h0MmpbeWnr1yht6-3VA@mail.gmail.com>
Message-ID: <CAD=FV=X1JURLwZHraNwSMT7vwLNRNw7h0MmpbeWnr1yht6-3VA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: mediatek: mt8188: fix use-after-free in driver
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
> diff --git a/sound/soc/mediatek/mt8188/mt8188-audsys-clk.c b/sound/soc/me=
diatek/mt8188/mt8188-audsys-clk.c
> index be1c53bf4729..05d6f9d78e10 100644
> --- a/sound/soc/mediatek/mt8188/mt8188-audsys-clk.c
> +++ b/sound/soc/mediatek/mt8188/mt8188-audsys-clk.c
> @@ -138,6 +138,29 @@ static const struct afe_gate aud_clks[CLK_AUD_NR_CLK=
] =3D {
>         GATE_AUD6(CLK_AUD_GASRC11, "aud_gasrc11", "top_asm_h", 11),
>  };
>
> +static void mt8188_audsys_clk_unregister(void *data)
> +{
> +       struct mtk_base_afe *afe =3D (struct mtk_base_afe *)data;

The above cast is unnecessary since the compiler lets you assign from
a "void *" to another pointer without a cast. Unnecessary casts are
considered harmful because they suspend the compiler's ability to do
type checking. Other than that, this looks good. Sorry for not
noticing that the same problem affected more than just the driver I
fixed previously.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
