Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F486B342B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 03:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjCJCVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 21:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjCJCVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 21:21:02 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5FC111F85
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 18:21:00 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id a2so4126530plm.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 18:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678414860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DjwphGFAmH+P3VBKg8ccdas4BLWzgUBKFji8Q6ip/qc=;
        b=nVgXI24fvBMAuxH0tK7nuj/+eV+NdHm4zIZz7nqgrjwY6HjG06jT0sDkEowN7K5B+N
         WzQEcV/WCsIZA1p68Bdrx4hxL+9DjLqt78C4NjQQ3leEsfjHgBHqAiUaWKkK1SgeOzFJ
         WJrcsoshdoB+DsfWTbEWM4Ni1QtDuKaCY5+f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678414860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjwphGFAmH+P3VBKg8ccdas4BLWzgUBKFji8Q6ip/qc=;
        b=kJlyMkkHvtZ+oBHwRxV1sy1uFVBJpY9fLQbDvsp8DvMT0Sz5TxGkhOMxS23Ip2G+eb
         rMJpqgMlem6dQbIxz42drRLfemOiNafQ8xI5Gs380i3v3RsODUiE/s67zA/E16s21/02
         jbQTIDNAK4j7WEm03FbfZnODXXoEqWOI3HG2L39dV1EsZARmJ19G078u5yBUTN3VavPO
         +UsAfluXfg1DyiZZLo+CxoW5qhjp6Fp6lWPI09M6q2a+Jyw3yZEfwUAWm54obhlX0Ub0
         6Zp+GR4DQsULDaNWEPx7C2PahlcA9UTm+378SG1Ye5oR13rzcStzA70cpOMxgN+c4eMV
         kZ3Q==
X-Gm-Message-State: AO0yUKUON8AEENtSgJ9OG169jLBQbR/QUMaGYswNKaAA85KavEGxIz6d
        xEICABvoXBmRqZgIdqwyeAst+g==
X-Google-Smtp-Source: AK7set9KyP9y8k1KMQxRXzVVbkv+aALqqNFQkpFnFJ0ubJOMVcv5Ro4XWW1twQ+UKWH9axxjE6HQOA==
X-Received: by 2002:a05:6a21:6d9f:b0:cd:a334:a531 with SMTP id wl31-20020a056a216d9f00b000cda334a531mr30455899pzb.62.1678414859816;
        Thu, 09 Mar 2023 18:20:59 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id y15-20020a63e24f000000b004fb997a0bd8sm259112pgj.30.2023.03.09.18.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 18:20:59 -0800 (PST)
Date:   Fri, 10 Mar 2023 11:20:54 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>
Subject: Re: [PATCH v6 3/5] media: uvcvideo: Allow hw clock updates with
 buffers not full
Message-ID: <20230310022054.GG1045797@google.com>
References: <20220920-resend-hwtimestamp-v6-0-c7a99299ec35@chromium.org>
 <20220920-resend-hwtimestamp-v6-3-c7a99299ec35@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920-resend-hwtimestamp-v6-3-c7a99299ec35@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/03/09 13:55), Ricardo Ribalda wrote:
[..]
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -754,10 +754,10 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
>  
>  	spin_lock_irqsave(&clock->lock, flags);
>  
> -	if (clock->count < clock->size)
> +	if (clock->count < 2)
>  		goto done;
>  
> -	first = &clock->samples[clock->head];
> +	first = &clock->samples[(clock->head - clock->count) % clock->size];

This looks like a significant change: `rb->head` and `rb->head - INT`
are quite different things. May I ask for some clarifications?

[..]
> +	/*
> +	 * Have at least 1/4 of a second of timestamps before we
> +	 * try to do any calculation. Otherwise we do not have enough
> +	 * precision. This value was determined by running Android CTS
> +	 * on different devices.
> +	 */
> +	if ((y2 - y1) < (256 << 16))

256 << 16 is 1/4 of a second?
