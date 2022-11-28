Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6686363B4F1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 23:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbiK1Ws5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 17:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbiK1Wss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 17:48:48 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA0A2AC40
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:48:43 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id vv4so29616603ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nu0Wm5f4XHfxhly48FwbjFsVIQyDhi7mw5JYF1qpKxM=;
        b=GgWhcIWNTHiCi5MnZBv6F5qanKIoKqUg59VaTWZbF+LxTGwnaN60sI4Ym7v3ZC2Poe
         BJM91WqGBXpM0eAj8wm8qZgtPK5Ti6o6X/v/Y22uYuhdqJIgmalPTTr5xc73bm+FFbGs
         8c2ok07nrcnNkDxOaDzycUKNfo+Ty/6u69Xls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nu0Wm5f4XHfxhly48FwbjFsVIQyDhi7mw5JYF1qpKxM=;
        b=LpBeFrvWQfPP+cfWHWJMJz8IP0NEblK0ruHBKhNgCde704Zr0ZAXqka5AZmUGEt/em
         90EkbPID+o5jpfel7NGOjyYoG2qpQ+cgfVoZNcWv7RJAcuJ7P9sm2UkpP9SmTA7lD0IJ
         sbqlXt/yp/rYB7ZHOJBKnLLZUm7KI79UICpt56EBKy28H5W0DfAzrGp+S7xG/HwgVuV6
         iM0QOHOsZA8ryLVTT8DRKxl4tai5gFoedswzyDEeSl+d6LqYs2i92WkgJ8rdHUNAFAZi
         qHXLyy8fFONNJcUp+Yyn7Hd+Gu9WAQYK6uq4Dpf19zPZTiPMD/tXnShebj885eRXq6KJ
         in6g==
X-Gm-Message-State: ANoB5pkCjcunpo2fSCjh3ULXYaeVLvp94CgGkoXd1Glq3MWH+/EL7rDx
        o275CEIKoQbyZJIqLPXQGR/81g7Sq9CmX42D
X-Google-Smtp-Source: AA0mqf5OsSlVQtlWauKxaSz+ad1YhwSGpetsa9ZT43vc8CqYe3JlRUTU48Ofx1H6f/u21Jd6HZfHzA==
X-Received: by 2002:a17:907:d005:b0:7bf:b628:8306 with SMTP id va5-20020a170907d00500b007bfb6288306mr6585612ejc.698.1669675721827;
        Mon, 28 Nov 2022 14:48:41 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906301200b007af75e6b6fesm5510135ejz.147.2022.11.28.14.48.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 14:48:40 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id t1so9613078wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:48:40 -0800 (PST)
X-Received: by 2002:a1c:cc04:0:b0:3cf:7716:8954 with SMTP id
 h4-20020a1ccc04000000b003cf77168954mr39478234wmb.57.1669675719812; Mon, 28
 Nov 2022 14:48:39 -0800 (PST)
MIME-Version: 1.0
References: <20221128221152.1.Ia805c688ee968fbbec7b93dc10742876fdef8024@changeid>
 <20221128221152.2.I8d1993f41f0da1eac0ecba321678ac489f9c0b9b@changeid>
In-Reply-To: <20221128221152.2.I8d1993f41f0da1eac0ecba321678ac489f9c0b9b@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 28 Nov 2022 14:48:28 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Uf3JiNf=339ktULYSUjreRU2k_tR2Q=LSNb+u-U4hQ6A@mail.gmail.com>
Message-ID: <CAD=FV=Uf3JiNf=339ktULYSUjreRU2k_tR2Q=LSNb+u-U4hQ6A@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: qcom: lpass-sc7180: Return 0 instead of 'ret'
 at the end of _resume()
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-kernel@vger.kernel.org, Judy Hsiao <judyhsiao@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 28, 2022 at 2:12 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> sc7180_lpass_dev_resume() returns 'ret' at the end of the function,
> where 'ret' is always 0. Just return 0 to make it plain obvious that
> this is always the success path.
>
> Also add an empty line between the error handling path and the
> return.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  sound/soc/qcom/lpass-sc7180.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
> index 7a81e609727c..30a28e3152cb 100644
> --- a/sound/soc/qcom/lpass-sc7180.c
> +++ b/sound/soc/qcom/lpass-sc7180.c
> @@ -173,7 +173,8 @@ static int sc7180_lpass_dev_resume(struct device *dev)
>                 dev_err(dev, "sc7180 clk prepare and enable failed\n");
>                 return ret;
>         }
> -       return ret;
> +
> +       return 0;

Yeah, I noticed this too when I was approving your pick. FWIW, I
probably would have written this way, but it's 6 of one and half dozen
of the other:

if (ret)
  dev_err(dev, ...);
return ret;

...but I just dug a tiny bit deeper and actually, there's no need for
the error print here and it's just wasteful. clk_bulk_prepare_enable()
already prints errors for you. So really this whole function could
just be:

struct lpass_data *drvdata = dev_get_drvdata(dev);
return clk_bulk_prepare_enable(drvdata->num_clks, drvdata->clks);

I guess theoretically one could even go further and look at pm_clk,
but perhaps that's overboard.


-Doug
