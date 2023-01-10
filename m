Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A248F6649AC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239258AbjAJSXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239290AbjAJSXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:23:15 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2145917405
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:21:17 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id u9so30991031ejo.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E971UMGcXwgaAFeIMfskNyBawiDJacixiUkz6okj188=;
        b=n6Y61za4DxKZcQVv04jf0Kgy/LIVUVbd4dG6UI8Zy/mgSnLr8dFB94wEL3D8vJWy07
         3fYwMJAyasn8+fgepgopiyJW5gT0JlyNIYGnbYYZqaf89dLtI/Ckiz+e9CVeijhxne3B
         1CEL/s/UaNtXnjR9P/8nONCzQPlb7gMzuzSB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E971UMGcXwgaAFeIMfskNyBawiDJacixiUkz6okj188=;
        b=xQxM1OLJcwhilG+seGnvPnB+xunOjgMHRteZtRj4B1KgJs5X9MMRSog1KqXkyhEJxV
         4bDdQq7iExSvC/m/2bA3oGcGZNLmhjcgTgzHgQT91DvscyILMMOwvvHW/s+b0J85HT26
         N39kT8J6yGI/Cia9ApD4PUthn2ptYogDQ+dndD91ymgnHi9PnBCKUrQQLBr5Odc4E5EF
         zefd9+8WbZzvodami0qzn6/8NEca75FpMuUDTAOquegdTlvtBziKohr8M+kzYuXzhNJj
         YRBIvQgtv3ZPNhsGUE3cz1hqLy2y8htpRlLWGtwk/kknfDLUTk4V5c2dcYnDp0cGK3OM
         s5JA==
X-Gm-Message-State: AFqh2ko+iYV2Lf6u2bDMHz1K/0A0UTd8zgOgqdbDXHKfBz3hJF9PzoZO
        +bxff0DrIiEFCdcxRSnaTVlZsJNfh36rie6BJOI=
X-Google-Smtp-Source: AMrXdXs7DYf4CvDPkzCJVJwSLMdIxGI/YmmmPBOm6dkJuzCFU+uZnR7EBrvmV+rYkTQPdgPTg2yQXQ==
X-Received: by 2002:a17:906:6a1a:b0:7b9:ee36:6153 with SMTP id qw26-20020a1709066a1a00b007b9ee366153mr78024237ejc.2.1673374876286;
        Tue, 10 Jan 2023 10:21:16 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id qu25-20020a170907111900b0084c7574630csm5297757ejb.97.2023.01.10.10.21.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 10:21:16 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id az7so12709635wrb.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:21:16 -0800 (PST)
X-Received: by 2002:a5d:6ad0:0:b0:2bc:da90:2ab8 with SMTP id
 u16-20020a5d6ad0000000b002bcda902ab8mr99344wrw.659.1673374407473; Tue, 10 Jan
 2023 10:13:27 -0800 (PST)
MIME-Version: 1.0
References: <20230110025006.10409-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20230110025006.10409-1-jiasheng@iscas.ac.cn>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 10 Jan 2023 10:13:13 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V5DDNtmpLRDGgSx1YVbd8UqTpcYFmvSAxFczn_JY+VmQ@mail.gmail.com>
Message-ID: <CAD=FV=V5DDNtmpLRDGgSx1YVbd8UqTpcYFmvSAxFczn_JY+VmQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dsi: Drop the redundant fail label
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     dmitry.baryshkov@linaro.org, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, marijn.suijten@somainline.org, vkoul@kernel.org,
        marex@denx.de, vladimir.lypak@gmail.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Hi,

On Mon, Jan 9, 2023 at 6:50 PM Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>
> @@ -1954,9 +1949,8 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
>
>         msm_host->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
>         if (msm_host->irq < 0) {
> -               ret = msm_host->irq;
>                 dev_err(&pdev->dev, "failed to get irq: %d\n", ret);
> -               return ret;
> +               return msm_host->irq;

The dev_err() is no longer printing the right value of "ret" above.

Other than that this looks reasonable to me. Feel free to add my
Reviewed-by tag once the above bug is fixed.

-Doug
