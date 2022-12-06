Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54779643B38
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 03:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbiLFCNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 21:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbiLFCMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 21:12:53 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3952417AA3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 18:12:52 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 21so13222971pfw.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 18:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c14cpbENCYZNKC7u3nvm/pV+pN6D09fmQR9Vg77kP7E=;
        b=Puf5KmAloTMG82ul7mVb3DjfNsyo5ylLf2c86JaNIj0DRSwnbqyT5dFPV5PV62+JZv
         bWODrmKHzlDHCPGWqUP5k+aupZxoY6qnjBb/JMpfwTeSmalwdqJjDqS6pGSwICU2I0PE
         IvvvpZHbv68ZWDXW/N+OQrvHMtrHx98Ghjdz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c14cpbENCYZNKC7u3nvm/pV+pN6D09fmQR9Vg77kP7E=;
        b=T6W+T1yEiWeSf1Zt8D6MDE3axfaq7crlnY4GaCue5ZlVDp2Kq/qqUQDqUUTNocXuI8
         t6+Z0nWO7I/TWmED+iR/fS7oXlm8xgCQqprq94AgNGXKTzXdhYYgLYJadXuLHzJQCy/j
         No/rR58NGFvFwabmmXDQqsV+/kOHIZ8fHyHHzPSRz3ssYSurKecZW5HLg2RF2MZKlorB
         00N4+4607a88lOyqb6SKwJJiwzg3+at0JUGvOhEze4sSgYAa9Rsq2jRmBuIXJixllnV+
         Ed5e+0py0D2CtJIt8UtCQSQiFo6+V7KGR7c78T0jU/dNdED6kk+KcveNCY/PIJjqLvqQ
         UqHQ==
X-Gm-Message-State: ANoB5pkep060sAQBG6Syb0amzpRy9uz7D4BfhTdC9YjSgTZNx+r92+vt
        gfN+dNE8zibFDRp7Pszkvf+a3oUSOEHppzUh
X-Google-Smtp-Source: AA0mqf6aQacPSyfFiQzOm8CXVaSz1VIVy23ZQ5+/FZE57I15VEUSYLEjwQxOATQTdC4VkXC8I9/f5Q==
X-Received: by 2002:a63:c46:0:b0:476:ed2a:6228 with SMTP id 6-20020a630c46000000b00476ed2a6228mr60063696pgm.137.1670292771791;
        Mon, 05 Dec 2022 18:12:51 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e80600b0017849a2b56asm11337097plg.46.2022.12.05.18.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 18:12:51 -0800 (PST)
Date:   Tue, 6 Dec 2022 11:12:46 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Yunke Cao <yunkec@chromium.org>,
        Max Staudt <mstaudt@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] media: uvcvideo: Refactor streamon/streamoff
Message-ID: <Y46lHvHCFHH8J/ao@google.com>
References: <20220920-resend-powersave-v4-0-47484ae40761@chromium.org>
 <20220920-resend-powersave-v4-1-47484ae40761@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920-resend-powersave-v4-1-47484ae40761@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/12/02 18:19), Ricardo Ribalda wrote:
> @@ -840,13 +840,19 @@ static int uvc_ioctl_streamon(struct file *file, void *fh,
[..]
> +	handle->is_streaming = !ret;


> @@ -857,15 +863,22 @@ static int uvc_ioctl_streamoff(struct file *file, void *fh,
[..]
> +	handle->is_streaming = !!ret;

Had uvc_ioctl_streamABC() be 3 functions we would have seen

	handle->is_streaming = !!!ret;

:)


[..]

A nit:

>  struct uvc_fh {
>  	struct v4l2_fh vfh;
> +	bool is_streaming;

That's a lot of padding.

>  	struct uvc_video_chain *chain;
>  	struct uvc_streaming *stream;
>  	enum uvc_handle_state state;

I guess is_streaming better be next to enum uvc_handle_state, in which
case is_streaming should not change sizeof(uvc_fh) (at least so on
64-bit).
