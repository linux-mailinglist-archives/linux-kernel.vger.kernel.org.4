Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B457660CFBF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiJYO7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiJYO7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:59:10 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953CE1A6503
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:59:09 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id i65so10573741ioa.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qf9l8TdBoqI3NSI3uJgvcfgTwT27VcCao15/BLv2mmM=;
        b=CS3mnQ7JD6Q8rKoVfoDkCC+DFRUfHfkHxcAvQ72s5DnYhjp6MdDQGy5vs/jIuAZl8w
         fGqhH+rPyCGoccxGPyuMShyPPDgCRLIBzTT5PIbNLhk+736yD/7X/OeUAAgvRUBSW1Gg
         gTwzP/q5lUOMZZLv0Zs9jFyhWc3ADpyEJRgt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qf9l8TdBoqI3NSI3uJgvcfgTwT27VcCao15/BLv2mmM=;
        b=lapqkN28gsMBkB6REM3pZDZ9/XP8vePpn4NDiQTZAxFrmOpdZQITaO2OJgfRarR0im
         hq6hM9XnO7LK2VoblhtuAsHRTeu4YOZrtBVpfoG4izO0iDDKFy/XCJkRebbPjSmpaVEd
         XjIiXNnovEQ8CRSjn/O7oCwS0qWpWeEq040aDjUAOAD+MDq1pNATY+RkMCCxlFDEjJvv
         AbdIzoi8/h35AVMf9yMkGsU29LTCTrbVEXM+/MsbVPu96GKetW5cGehSUJBuB+Xdtgwo
         pBQp60opQkCfv7HvlU8zYlkytr5Zmnk2QP+26M8IrcSKTf6ZoXLaxtyR7ea/VSiE9eSg
         qSKw==
X-Gm-Message-State: ACrzQf3R/YPgJive1qx6SD1G8VNTyX8fXdxjMibreP4G+yhOpzmS8KB2
        prdZnPTq86CdMPherlgMUidUf9M0XEhTRxri
X-Google-Smtp-Source: AMsMyM7yZx/WSVqSoNbUjxbzBw7048u31xbQi+hRcRbsDgwpVqzK8bS4LmP1dsbjKST0rC11uaG1Iw==
X-Received: by 2002:a02:a00b:0:b0:363:5daa:99b8 with SMTP id a11-20020a02a00b000000b003635daa99b8mr24310332jah.276.1666709948847;
        Tue, 25 Oct 2022 07:59:08 -0700 (PDT)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id o5-20020a92dac5000000b002ff54e19cb0sm1087193ilq.36.2022.10.25.07.59.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 07:59:08 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id y80so10535261iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:59:07 -0700 (PDT)
X-Received: by 2002:a5d:9ac1:0:b0:6a3:1938:e6b0 with SMTP id
 x1-20020a5d9ac1000000b006a31938e6b0mr22659626ion.186.1666709947180; Tue, 25
 Oct 2022 07:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221025050450.1743072-1-pedro.guilherme@espectro.eng.br> <20221025050450.1743072-3-pedro.guilherme@espectro.eng.br>
In-Reply-To: <20221025050450.1743072-3-pedro.guilherme@espectro.eng.br>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 25 Oct 2022 16:58:56 +0200
X-Gmail-Original-Message-ID: <CANiDSCvN5DEDdjCkO-KXgYwnhF_FGE4c=DMGiUTy4KKp51ANFA@mail.gmail.com>
Message-ID: <CANiDSCvN5DEDdjCkO-KXgYwnhF_FGE4c=DMGiUTy4KKp51ANFA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] media: uvc_driver: fix usage of symbolic
 permissions to octal
To:     Pedro Guilherme Siqueira Moreira <pedro.guilherme@espectro.eng.br>
Cc:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022 at 07:40, Pedro Guilherme Siqueira Moreira
<pedro.guilherme@espectro.eng.br> wrote:
>
> Change symbolic permissions to octal equivalents as recommended by
> scripts/checkpatch.pl on drivers/media/usb/uvc/uvc_driver.c.
>
> Signed-off-by: Pedro Guilherme Siqueira Moreira <pedro.guilherme@espectro.eng.br>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 7b6c97ad3a41..c5adad4e51e2 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2362,17 +2362,17 @@ static int uvc_clock_param_set(const char *val, const struct kernel_param *kp)
>  }
>
>  module_param_call(clock, uvc_clock_param_set, uvc_clock_param_get,
> -                 &uvc_clock_param, S_IRUGO|S_IWUSR);
> +                 &uvc_clock_param, 0644);
>  MODULE_PARM_DESC(clock, "Video buffers timestamp clock");
> -module_param_named(hwtimestamps, uvc_hw_timestamps_param, uint, S_IRUGO|S_IWUSR);
> +module_param_named(hwtimestamps, uvc_hw_timestamps_param, uint, 0644);
>  MODULE_PARM_DESC(hwtimestamps, "Use hardware timestamps");
> -module_param_named(nodrop, uvc_no_drop_param, uint, S_IRUGO|S_IWUSR);
> +module_param_named(nodrop, uvc_no_drop_param, uint, 0644);
>  MODULE_PARM_DESC(nodrop, "Don't drop incomplete frames");
> -module_param_named(quirks, uvc_quirks_param, uint, S_IRUGO|S_IWUSR);
> +module_param_named(quirks, uvc_quirks_param, uint, 0644);
>  MODULE_PARM_DESC(quirks, "Forced device quirks");
> -module_param_named(trace, uvc_dbg_param, uint, S_IRUGO|S_IWUSR);
> +module_param_named(trace, uvc_dbg_param, uint, 0644);
>  MODULE_PARM_DESC(trace, "Trace level bitmask");
> -module_param_named(timeout, uvc_timeout_param, uint, S_IRUGO|S_IWUSR);
> +module_param_named(timeout, uvc_timeout_param, uint, 0644);
>  MODULE_PARM_DESC(timeout, "Streaming control requests timeout");
>
>  /* ------------------------------------------------------------------------
> --
> 2.38.1
>


-- 
Ricardo Ribalda
