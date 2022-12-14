Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC8664C3A5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 06:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiLNF6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 00:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiLNF6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 00:58:12 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6555922B1B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 21:58:11 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so6020839pjs.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 21:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2cMB0KTRPpjLcSDo8c2MJxYl9QQRsGS0i5AxHQ5wVxU=;
        b=X+3f/2N//f2ogGrUlxDgQQPWtFmf9HLeidf3mqGYExlvbzATxzZpUfe+Pj1WgYl8E0
         f+KBvvYaPqUBJt7SrV8gRwAfCxszKMvkAww4+semz/YCpSQ892hpaIGYGpP/0uyueHEE
         F5qczqJZ28cipo0XkeIB6iWk9aqWu73Xo0suk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2cMB0KTRPpjLcSDo8c2MJxYl9QQRsGS0i5AxHQ5wVxU=;
        b=LnSxnUUeD8vy8BM5eDxbEOum67Yy9l1Wr4pZ130hpv09dUjk81fJTvSmzgSDjdA33a
         y447wgTltuqXIQ8OP9SO3OWYgAllOdIkonkt3jFbNnB3iZUyO1axNLc4GYAgFOrOqXtN
         jB8pxJqzp/re+z3z5+c3QPTNwSQ6KKlTeJskhQVqELlyNP278VY+mzAIu6joGpVFAcof
         xmV1LnEhfLupd8aaJ9Yv4CcbXahxagOnAhjy3/jFww9l5egmIoGENCMTMmvPjDIGlAxA
         6GRDscsjbKSQaLLLOhu2qrdChvmbVv4NFp/eTSI+V27+6PFLESqr/Yrpyv+Gup9Z83FQ
         Bz3w==
X-Gm-Message-State: ANoB5pktdEYRsiCTF2QSIqHxm1atPRNce+ZnkGKXH4bZZU08hSoCyVP+
        UPQVrYRYyA9SZTy9OnSz+UGoU6LQpehDK71O
X-Google-Smtp-Source: AA0mqf55FnQyVz/7CPu/9ur2PxsbOEEQgtnsrWOZ/KC/rwuftE7YsYNip8gr98DcQsMFtdq2vekRZQ==
X-Received: by 2002:a17:90a:9484:b0:219:ba3d:7ee2 with SMTP id s4-20020a17090a948400b00219ba3d7ee2mr26246772pjo.30.1670997490787;
        Tue, 13 Dec 2022 21:58:10 -0800 (PST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com. [209.85.216.53])
        by smtp.gmail.com with ESMTPSA id t14-20020a17090a950e00b00219eefe47c7sm494300pjo.47.2022.12.13.21.58.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 21:58:09 -0800 (PST)
Received: by mail-pj1-f53.google.com with SMTP id t17so5804119pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 21:58:09 -0800 (PST)
X-Received: by 2002:a17:90a:eacb:b0:219:33a1:d05f with SMTP id
 ev11-20020a17090aeacb00b0021933a1d05fmr140491pjb.116.1670997488508; Tue, 13
 Dec 2022 21:58:08 -0800 (PST)
MIME-Version: 1.0
References: <20221212-uvc-race-v2-0-54496cc3b8ab@chromium.org>
 <20221212-uvc-race-v2-2-54496cc3b8ab@chromium.org> <Y5kbXt5lUqUiCmCi@google.com>
In-Reply-To: <Y5kbXt5lUqUiCmCi@google.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 14 Dec 2022 06:57:56 +0100
X-Gmail-Original-Message-ID: <CANiDSCs4onzD-OBYubJpGfyfPGcpMEPfPT8OKd_Q3UtNN1XciA@mail.gmail.com>
Message-ID: <CANiDSCs4onzD-OBYubJpGfyfPGcpMEPfPT8OKd_Q3UtNN1XciA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] media: uvcvideo: Do not alloc dev->status
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Max Staudt <mstaudt@google.com>, Yunke Cao <yunkec@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi Sergey

Thanks for the review

On Wed, 14 Dec 2022 at 01:40, Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (22/12/13 15:35), Ricardo Ribalda wrote:
> [..]
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -559,7 +559,7 @@ struct uvc_device {
> >       /* Status Interrupt Endpoint */
> >       struct usb_host_endpoint *int_ep;
> >       struct urb *int_urb;
> > -     u8 *status;
> > +     u8 status[UVC_MAX_STATUS_SIZE];
>
> Can we use `struct uvc_control_status status;` instead of open-coding it?
> Seems that this is what the code wants anyway:

It can also be a `struct uvc_streaming_status`

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/usb/uvc/uvc_status.c#n230

so we always need the casting :(

>
>         struct uvc_control_status *status =
>                                 (struct uvc_control_status *)dev->status;
>
> And then we can drop casts in uvc_status_complete().



-- 
Ricardo Ribalda
