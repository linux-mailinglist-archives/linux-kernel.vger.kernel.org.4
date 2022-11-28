Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2E263B4E0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 23:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbiK1Whv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 17:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbiK1Whp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 17:37:45 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98957DAF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:37:41 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ml11so4644325ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I9zgwrwiRRupONYrnokcwSugSkhgWBhW5gmMgQKjQcE=;
        b=UsjK72VpwTJ9kAjQFKmVLZiTW90apmuKHlQoEdLarfAWLcu4S3UGNA3SYQGshbWjvX
         ReWL12m8/TafA3IMLneHat42cQc+xvDSpucvcTHUBBTcP1tXMQdoaGtirZF7nTRJgoLt
         WhdZ1cdfIJs+iTVmdQt3XTPXQHNBd6gUWxjxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I9zgwrwiRRupONYrnokcwSugSkhgWBhW5gmMgQKjQcE=;
        b=V5eURpApUjWLC9FL1cuD9QQG5F5u9tMlOi1iTEVbfeje1Oy7mWZ2s3gRpjo2vkSYjh
         uUSMYdUcjCSNQaKQ5zyh9t0RZe5lOUgN2WYpB9sh/BZ2pPdOBaWCnDInACwbLWeucbzG
         9859KJDmEAkMKrT955+L14SbpDNip/879uPeC3ZXgBnDD2nTv9FjhQOeyZKDnrZbyr/b
         1pTefgpJp8/P/Xo1cho7DCNnYTCS0OfBmprW2iI2bvLv4VvzlKZ0Wq4+TV6J9YxGSWUZ
         LhM2JmE17p0cUgYyIdJJ9/pY2YFo6/8lrwVBI0JV9elP+fiGiq973e7FfS9h2SQ7KP8b
         3gGA==
X-Gm-Message-State: ANoB5pnUb5nVgd9I+ySK5sa31XObsLAjX3+dxS//1N40tAR0JNHYWxrE
        IZN4feYT14QG/i8gHi6CIo9qO1U9ruURr8tE
X-Google-Smtp-Source: AA0mqf6sGDR5Q+UieQEZft6z56TZwVA0vEKIPP7ipwOMD0fV1JhfIe/A03GhTjiz3Jo++FZn+goDpQ==
X-Received: by 2002:a17:906:6d04:b0:7bd:9896:60c8 with SMTP id m4-20020a1709066d0400b007bd989660c8mr12250925ejr.194.1669675059578;
        Mon, 28 Nov 2022 14:37:39 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id hz13-20020a1709072ced00b007c00323cc23sm1705623ejc.27.2022.11.28.14.37.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 14:37:37 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id bx10so7227597wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:37:37 -0800 (PST)
X-Received: by 2002:a5d:4950:0:b0:242:1f80:6cd9 with SMTP id
 r16-20020a5d4950000000b002421f806cd9mr1152821wrs.405.1669675056628; Mon, 28
 Nov 2022 14:37:36 -0800 (PST)
MIME-Version: 1.0
References: <20221128221152.1.Ia805c688ee968fbbec7b93dc10742876fdef8024@changeid>
In-Reply-To: <20221128221152.1.Ia805c688ee968fbbec7b93dc10742876fdef8024@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 28 Nov 2022 14:37:24 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wi3Oy9kdFfP6WE1wbtSrGxsr_VC8KZQAyTMgW-uMTOWA@mail.gmail.com>
Message-ID: <CAD=FV=Wi3Oy9kdFfP6WE1wbtSrGxsr_VC8KZQAyTMgW-uMTOWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: qcom: lpass-sc7180: Drop unnecessary
 initialization in _resume()
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
> The initialization of the variable 'ret' in sc7180_lpass_dev_resume()
> is unnecessary, as it is always assigned a few lines below. Drop the
> initialization.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  sound/soc/qcom/lpass-sc7180.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Not that this needs review, but FWIW:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
