Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CEC5EF94C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbiI2Pma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbiI2PmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:42:09 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E06ED5F4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 08:41:19 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id lc7so3695055ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 08:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=T6/M92tDqAap2CUetFUNSvf5fKxFn0XgEHDjWBCcOpg=;
        b=l15LngSHAiInxobzxdMyeRClT0LlMX2C5EMzDAX4h4hOcSc2OPrJpSm1VN9Nj/mtup
         t2gMXWCsesW4EnV98234v4+dUkc3mSve1WX7qAIrJK9g83K1ZsCB3nMrHIhum3heG5Rw
         bDSXx+n/bu5AuF8DGZaMRx8C/mMDHovX95VqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=T6/M92tDqAap2CUetFUNSvf5fKxFn0XgEHDjWBCcOpg=;
        b=JwCIq447lkaiY9GV5L5E9KZ1WZklVCOac4J3CVR2ntMg0Cz77FJmwHGqQDqFqmnbgt
         M+3+9XH7J/OJuLVsLzQedzdC66nK4PDW/ogCTXfx+UwUyL365n6qdoHE6xOdvFc2I2un
         F30EiyVue7ikF0iUzGwiudWJgTZTTl1PqCCHlAzbaBFEJUCCAx3cICJc9dRY4y7c0UUV
         0tu4eHNlmJ94ZsMeK78spcfvRmWJ6qDZXdz3uW7B2e8jbAWtYotZo6yj49TxdS/Laebu
         j08JTDeSEgdXpyj7Oh3BQYJ7/MBH2IR9u+LgHdbxYLC6lZGvuXU4rtrahrW0S78agvq4
         JWiw==
X-Gm-Message-State: ACrzQf1on8P8oKBTDnegNoOMBu1em2DnX3m2Aha1dJ+OclE6GJB/zp+m
        fZ3zuQMMH2zwidPDaMcQEaqi97pKeGbRuNP+
X-Google-Smtp-Source: AMsMyM4I6vq6pXL/VV1cbW1E1qsnKcewbyPGqhvN/BKkbbChnz6Cq1M3f8GSUVABD+fBbz/1gMIriA==
X-Received: by 2002:a17:907:162a:b0:783:d11a:a553 with SMTP id hb42-20020a170907162a00b00783d11aa553mr3266524ejc.482.1664466078009;
        Thu, 29 Sep 2022 08:41:18 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id f24-20020a50fc98000000b00456d40f6b73sm5622389edq.87.2022.09.29.08.41.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 08:41:17 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id s14so2862687wro.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 08:41:17 -0700 (PDT)
X-Received: by 2002:a5d:522f:0:b0:228:dc7f:b9a8 with SMTP id
 i15-20020a5d522f000000b00228dc7fb9a8mr2928239wra.617.1664466077020; Thu, 29
 Sep 2022 08:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220929012911.2521786-1-jason.yen@paradetech.corp-partner.google.com>
In-Reply-To: <20220929012911.2521786-1-jason.yen@paradetech.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 29 Sep 2022 08:41:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xauvh1XhMUQZc8cp3-Wo4TRgD1waLiwAXP5z8EBW9Nrg@mail.gmail.com>
Message-ID: <CAD=FV=Xauvh1XhMUQZc8cp3-Wo4TRgD1waLiwAXP5z8EBW9Nrg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ps8640: Add software to support aux defer
To:     Jason Yen <jason.yen@paradetech.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Pin-yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 28, 2022 at 6:29 PM Jason Yen
<jason.yen@paradetech.corp-partner.google.com> wrote:
>
> This chip can not handle aux defer if the host directly program
> its aux registers to access edid/dpcd. So we need let software
> to handle the aux defer situation.
>
> Signed-off-by: Jason Yen <jason.yen@paradetech.corp-partner.google.com>
> ---
>
>  drivers/gpu/drm/bridge/parade-ps8640.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> index 31e88cb39f8a..967dec840b91 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -303,6 +303,14 @@ static ssize_t ps8640_aux_transfer_msg(struct drm_dp_aux *aux,
>         case SWAUX_STATUS_ACKM:
>                 len = data & SWAUX_M_MASK;
>                 break;
> +       case SWAUX_STATUS_DEFER:
> +       case SWAUX_STATUS_I2C_DEFER:
> +               if (is_native_aux)
> +                       msg->reply |= DP_AUX_NATIVE_REPLY_DEFER;
> +               else
> +                       msg->reply |= DP_AUX_I2C_REPLY_DEFER;
> +               len = data & SWAUX_M_MASK;
> +               break;

Overall this looks OK to me, but please send a v2 that removes the
line above that states:

/* Ignore the DEFER cases as they are already handled in hardware */

-Doug
