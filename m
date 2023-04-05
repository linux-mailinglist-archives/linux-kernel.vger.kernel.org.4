Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645756D81EF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238759AbjDEPa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238715AbjDEPai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:30:38 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3754ED0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:30:36 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id d20so5259014ioe.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 08:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680708635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEtViaaPGjuALXV+zDvNSJPX33bcrmdyEjKhggGHKVA=;
        b=NLP/ne3BXo09t0SLzY/wlew5vssnKDQXS78vTVzcqFXphUP4W1TFFEcXw1JRqnAwx+
         lDEW7u6WHIPt2rLG7oyURl2NyBABGmazDSrXzJJOpAVcv926sBuWY9IKfIMRlFsvu+I3
         ZdoZ7Y9QfkprNUWnf+qvm12IggrlpEGgR986M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680708635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEtViaaPGjuALXV+zDvNSJPX33bcrmdyEjKhggGHKVA=;
        b=UNbBj0Ok15CNkz5rhgwMQq4XWkGDoe0k+bTKzmm3/zAPdCCdrpifuDGo/fWfIql1Wq
         4njjw4Hm5O2M7tueprd3YbmbGIoSBOvhwUDh8RJAbmxs6mN1uFXhqNFDjcLdCPZvfhix
         JxfZW72w5MFf3vNwiQsH1zQufsNBztkoibKbjm1o6T5UOlOFycH4Mcf2o+XmvWcVSBh2
         MAy/kpuGWsZGB360YM9NNE3VGODVcHV2uOiO12S17RucgXXGt9LrxCL5eDTEqYO3TIKG
         gEWJdt5RuKYbBF3zF19PBcKz5R9kmt/PqH3eUmi7R2iJXpSn2a7bzrSu7G1s7IobPRpa
         quFg==
X-Gm-Message-State: AAQBX9c1NlJE7QPPPCfdhjerm+tVxFTI6aJYhfOGSS8IXSnAaIkNDwEX
        fPBBvrwwU1Lidol3Ba+QOSdRoTdZ3yk8HD2+lo8=
X-Google-Smtp-Source: AKy350ZvvrqsRBMNh9k6D5SWgj2PIx+wgS+OkGwslOTh/RneduNO7DtV9lclfNR9VWsU22papo72mg==
X-Received: by 2002:a05:6602:14a:b0:75f:eb5c:e8fd with SMTP id v10-20020a056602014a00b0075feb5ce8fdmr4807358iot.6.1680708635637;
        Wed, 05 Apr 2023 08:30:35 -0700 (PDT)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id v13-20020a5ec10d000000b007437276ae6dsm4021999iol.3.2023.04.05.08.30.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 08:30:33 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id g16so5448968iom.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 08:30:33 -0700 (PDT)
X-Received: by 2002:a02:8503:0:b0:3a9:75c9:da25 with SMTP id
 g3-20020a028503000000b003a975c9da25mr3385997jai.1.1680708632983; Wed, 05 Apr
 2023 08:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230405100452.44225-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230405100452.44225-1-angelogioacchino.delregno@collabora.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 5 Apr 2023 08:30:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UsPG+syxzLvtTaT=kK6mQZ76t5NF5M8B5UiDUDLNSKzg@mail.gmail.com>
Message-ID: <CAD=FV=UsPG+syxzLvtTaT=kK6mQZ76t5NF5M8B5UiDUDLNSKzg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add AUO NE135FBM-N41 v8.1 panel entry
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 5, 2023 at 3:05=E2=80=AFAM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add a panel entry with delay_200_500_e50 for the AUO NE135FBM-N41
> version 8.1, found on a number of ACER laptops, including the
> Swift 3 (SF313-52, SF313-53), Chromebook Spin 513 (CP513-2H) and
> others.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

There's not lots of reason to delay landing patches like this, so
pushing to drm-misc-next right away.

a80c882183e3 drm/panel-edp: Add AUO NE135FBM-N41 v8.1 panel entry
