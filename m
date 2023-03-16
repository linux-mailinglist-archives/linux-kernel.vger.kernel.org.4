Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2D76BC43A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCPDIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjCPDIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:08:36 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F1410433
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 20:08:01 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id rj10so344068pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 20:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678936081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TRNi7iKKko9bFi4WxyfswopyPccHPiahTmhj6NUg/QA=;
        b=IlSFfLnzoq7Ac+ZnAcN6WqcbHR50y8Co7g4nW6ReL7ltSR8zwPyXvzfE0mRX+Ag/ty
         Yc8LAbPRLYjCcZ1Js6EzVvym/YIoHiqTaVhkSRX0RQI8IjCcSaMt6ZDAaPI5qiRY8GKG
         aPD5Uq0ppBXfYdYCrI+f//1Ll1HGes8MF1rsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678936081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRNi7iKKko9bFi4WxyfswopyPccHPiahTmhj6NUg/QA=;
        b=omqrEt2ctet1idyOw7GPogEAtkMO7mRGKTdjQz1EtgKAVxiVOg1HgQmDoti9CVEUHB
         c1S5ILVcQaYlFK4W0SGy7FjVGQXNIpcqFOBqg9h0fDt8EpQZjQ+msd/azuwto+7glMm7
         o07eKYPSNo4L9P0F86snvhzgHt2ZO2o6walY/JB3GLwK+5v6poa08b0s1e4VvEjGYGXa
         T85Hxq6BBgbg8WN52kNXwTv7Ib70j8MJ+yjg/zIV5d8ZSi6KKMZgOQtrZmffhHAtCULL
         UXQmxs3LZmsNikBHGw7tJNmQ3H5F2S6YWhJvOmYYjTg1qcUAkipaNp4T4r7SA+DmpNxG
         iMpQ==
X-Gm-Message-State: AO0yUKUFF61WSGr2/RaaMone5gSqA59YP2UBAwknySKBktdw8cf0Wt97
        FHQrLXgT0wYgF1JjjT+KPwyCuc9kAyeu9d8ths6Z8A==
X-Google-Smtp-Source: AK7set+cOEk0KM6tmJKzarRViGgOwefI/foR8kuQzQd27qnLrPIYFVPa6m4zumtpp4UbfAtyqkbsGA==
X-Received: by 2002:a05:6a20:c52f:b0:d4:2cc1:c7cd with SMTP id gm47-20020a056a20c52f00b000d42cc1c7cdmr1864250pzb.18.1678936081060;
        Wed, 15 Mar 2023 20:08:01 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id c20-20020aa78814000000b005907716bf8bsm1734754pfo.60.2023.03.15.20.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 20:08:00 -0700 (PDT)
Date:   Thu, 16 Mar 2023 12:07:55 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v9 6/6] media: uvcvideo: Fix hw timestamp handling for
 slow FPS
Message-ID: <20230316030755.GC1927922@google.com>
References: <20220920-resend-hwtimestamp-v9-0-55a89f46f6be@chromium.org>
 <20220920-resend-hwtimestamp-v9-6-55a89f46f6be@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920-resend-hwtimestamp-v9-6-55a89f46f6be@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/03/15 14:30), Ricardo Ribalda wrote:
> In UVC 1.5 we get a single clock value per frame. With the current
> buffer size of 32, FPS slowers than 32 might roll-over twice.
> 
> The current code cannot handle two roll-over and provide invalid
> timestamps.
> 
> Revome all the samples from the circular buffer that are more than two
> rollovers old, so the algorithm always provides good timestamps.
> 
> Note that we are removing values that are more than one second old,
> which means that there is enough distance between the two points that
> we use for the interpolation to provide good values.
> 
> Tested-by: HungNien Chen <hn.chen@sunplusit.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

[..]
> +	if (clock->count > 0 && clock->last_sof > sample->dev_sof) {
> +		/*
> +		 * Remove data from the circular buffer that is older than the
> +		 * last overflow. We only support one overflow per circular
> +		 * buffer.
> +		 */
> +		if (clock->last_sof_overflow != -1) {
> +			clock->count = (clock->head - clock->last_sof_overflow
> +					+ clock->count)	% clock->count;

A minor nit: there is a tab between `clock->count)` and `% clock->count` :)
