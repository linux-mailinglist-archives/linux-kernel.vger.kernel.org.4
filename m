Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1193C6A8886
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 19:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCBS3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 13:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjCBS3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:29:44 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C252E17CD3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 10:29:43 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id i4so244570ils.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 10:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpWolHBTfv1e/s85d7Nor58l6lqGaWFhdL+nTiGGVic=;
        b=QI7gz/LeygpGxrmWN08W2VKhqopzlDmPIMqoxGEz9VFAjmlDg199kMccbeLiAyrhdi
         H/Yvc2c5UwqTGdwX9DOSblo6pvnc5iN/NV+8j+BuYzA7+Utu8lpFc+rE87A9QqEFCqbj
         glnz67pYLBz+umPSkDBuPlZ+iiqngAtoKnn7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpWolHBTfv1e/s85d7Nor58l6lqGaWFhdL+nTiGGVic=;
        b=J24BL3V2Eg0voz73Yv2IY/nBy/9WqGMTPY3mKHmk51PzkK18IeyKVABnhaae+sxDPi
         UyQI0h9yqYIduHJDFq6ynjJ8hnbbNayeagLs3uUFqnh4HRiVnjJD/ZrBWG/1hDQ+Ngnr
         oQlPtpsc3yfL7Oprl38Q4ENXa2NHx8yKY9KltbBnhLUZFvnMdC84+5QtBmdccKrN2t4D
         ZTFiOUR/zByWkSRYX+T/R/PE6ue6NoFeYyxCRkAYS6YgrBzmWxcR7Ko93or42VpUJGfG
         YSeDuQ+WiHXclVVe1vzcnbXBz1YHOrG+IgLnPXHwYZqZefLmnzs0hW1nSuf08W6mo86v
         ZqoA==
X-Gm-Message-State: AO0yUKWp8bI0kKUi81iMSw8HJHGAr6uXy0pbufS+onGDgdPlHNfJ4gZn
        uuJ9zGxG++JlCD32VH+0i88EXJeoNnA0R88V
X-Google-Smtp-Source: AK7set++IkCGrxc+43RQhaZ7BDuf83GLMI0d7MYrGGTnFtiGZ7lipopik3gBcSq6NbrEB0pmZjBktA==
X-Received: by 2002:a92:3f0d:0:b0:317:6ead:2e4e with SMTP id m13-20020a923f0d000000b003176ead2e4emr6644583ila.5.1677781782135;
        Thu, 02 Mar 2023 10:29:42 -0800 (PST)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id q22-20020a02cf16000000b0039e89ea68f9sm49943jar.135.2023.03.02.10.29.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 10:29:41 -0800 (PST)
Received: by mail-io1-f48.google.com with SMTP id m22so15924ioy.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 10:29:41 -0800 (PST)
X-Received: by 2002:a02:8545:0:b0:3e5:a7d9:27db with SMTP id
 g63-20020a028545000000b003e5a7d927dbmr4740334jai.6.1677781780914; Thu, 02 Mar
 2023 10:29:40 -0800 (PST)
MIME-Version: 1.0
References: <20230302074704.11371-1-johan+linaro@kernel.org>
In-Reply-To: <20230302074704.11371-1-johan+linaro@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 2 Mar 2023 10:29:29 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WK2yxWqAro6k4N2kr-HeNZLNxi6tuq=_uL0tbSjGVEAg@mail.gmail.com>
Message-ID: <CAD=FV=WK2yxWqAro6k4N2kr-HeNZLNxi6tuq=_uL0tbSjGVEAg@mail.gmail.com>
Subject: Re: [PATCH] drm/edid: fix info leak when failing to get panel id
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Mar 1, 2023 at 11:49=E2=80=AFPM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> Make sure to clear the transfer buffer before fetching the EDID to
> avoid leaking slab data to the logs on errors that leave the buffer
> unchanged.
>
> Fixes: 69c7717c20cc ("drm/edid: Dump the EDID when drm_edid_get_panel_id(=
) has an error")
> Cc: stable@vger.kernel.org      # 6.2
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/gpu/drm/drm_edid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 3841aba17abd..8707fe72a028 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -2797,7 +2797,7 @@ u32 drm_edid_get_panel_id(struct i2c_adapter *adapt=
er)
>          * the EDID then we'll just return 0.
>          */
>
> -       base_block =3D kmalloc(EDID_LENGTH, GFP_KERNEL);
> +       base_block =3D kzalloc(EDID_LENGTH, GFP_KERNEL);

Good catch! I'm landing this to drm-misc-fixes right away.

4d8457fe0eb9 drm/edid: fix info leak when failing to get panel id

I'm sure I copied the kmalloc() from _drm_do_get_edid(), but it looks
like in _that_ case if the read fails we never print the buffer so
that one is OK.

-Doug
