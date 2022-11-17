Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E98D62E080
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239934AbiKQP6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239727AbiKQP56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:57:58 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4160769CD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:57:57 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id t25so6100635ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xPYVdWQGKyAxRr86FuSPZgi+RasDOpkqD17vGK7Zz+k=;
        b=hj/G4BeW/V/LA3u+r6+4U1y/fmx6qLA9fBpI/xGuRQXFMWYeuIxLf8flJbXtEPn7k3
         CJFX7gdHL/JYXZVFfK+V+i5yB6l8i0/km1OFaT1MrT1i7yHHjFlCWqhsoV5XdI6DnSka
         3PxHIEQfJE5JSXXYK3B78m37cEI5Efz4ItdxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xPYVdWQGKyAxRr86FuSPZgi+RasDOpkqD17vGK7Zz+k=;
        b=H7nwT8dWrf8U4YS5DemxAYfzjw3yFRY+UxAsaFvu2jcbg+CNMo5JcCCMYlXYIicOkP
         I+vQKleis1bvXVNMC40IX4e7K2wvNWam0pPH2iUCE/5bwqbN4MhRXQoIsTC8vruR/jg6
         G7T8Z8XcvQoE8asSxFPPrzmfVSTC09KwWI3QlMaNncx4xFlHmXjnupUW/8+936T7TdOe
         ihr00svGcl2kdqcw4M066qV2ZJZHdXbrKq8jp+7DmnnR9CzchmWxheuvVAy+NnnnYIMY
         reKJfkY8KF3I3Z3RsNj/ljQGzFjsDkhg4vfyxWbBh/wcQxmqm/VqNC5dwTRzaLyTdd6C
         lvrg==
X-Gm-Message-State: ANoB5pmaN8nrrPrcF3lRgLBKmyKVXa2ZgZeOQGd5jSqisthOq/fjYOPy
        jSUMnVeB/lBMHDUk7oN136zZOq4wYDI9tFV6
X-Google-Smtp-Source: AA0mqf7fPQPKGc2KBjdfUoHSy2/VgKo52d3/33tSWIUCVmabq0os2yuI0XkG5Miw/mIiB73qBPDkIw==
X-Received: by 2002:a17:906:6146:b0:789:d2fc:41d1 with SMTP id p6-20020a170906614600b00789d2fc41d1mr2606985ejl.642.1668700676053;
        Thu, 17 Nov 2022 07:57:56 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id g11-20020a170906594b00b007af75e6b6fesm536243ejr.147.2022.11.17.07.57.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 07:57:54 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id g2so911405wrv.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:57:54 -0800 (PST)
X-Received: by 2002:adf:d085:0:b0:241:b3d6:d6a0 with SMTP id
 y5-20020adfd085000000b00241b3d6d6a0mr1898756wrh.617.1668700674040; Thu, 17
 Nov 2022 07:57:54 -0800 (PST)
MIME-Version: 1.0
References: <20221117110804.1431024-1-hsinyi@chromium.org>
In-Reply-To: <20221117110804.1431024-1-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Nov 2022 07:57:41 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VEC=GzkDfaOqauBB5Y79teS1ENA5wFUHZmnTRkg6Z4tg@mail.gmail.com>
Message-ID: <CAD=FV=VEC=GzkDfaOqauBB5Y79teS1ENA5wFUHZmnTRkg6Z4tg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] drm_bridge: register content protect property
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Allen Chen <allen.chen@ite.com.tw>,
        David Airlie <airlied@gmail.com>
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

On Thu, Nov 17, 2022 at 3:08 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Some bridges are able to update HDCP status from userspace request if
> they support HDCP.
>
> HDCP property is the same as other connector properties that needs to be
> created after the connecter is initialized and before the connector is
> registered.
>
> If there exists a bridge that supports HDCP, add the property to the
> bridge connector.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Sean Paul <seanpaul@chromium.org>
> Reported-by: kernel test robot <lkp@intel.com>

Not sure it's worth spinning for, but FWIW I wouldn't put
"Reported-by: kernel test robot <lkp@intel.com>". The emails from that
bot are always a bit confusing in this regards, but I think they mean
"if the patch has already landed and you're sending a separate patch
with a fix then please add the "Reported-by" tag". ...but adding it to
the original patch just doesn't make a lot of sense.
