Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A386218F8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbiKHQBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbiKHQBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:01:10 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1161A380
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 08:01:09 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x2so23193680edd.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 08:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Cs/tzdzMNxyrkME08FtkUJHq/5+jxAWtBxJkRKMVSo=;
        b=dHv+YvRHsFfiWO1fcs6ArCsBbZg5HSKFkglygNPjpjWyGiX+AO7rYbXOpflkG3ytj8
         AHXUF7uSRh6oI/nTEJ8wtEj8E8ByMHs2xSQKg2LmxY75hEbuvPhnKqp55Uodr4eWa9NS
         B/j4Q2v082uFC1Z/Db8IXir8xe7g/nG97fdqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Cs/tzdzMNxyrkME08FtkUJHq/5+jxAWtBxJkRKMVSo=;
        b=zI+9+V2CW7UrSk5NkIB+FB3pNtJ6Eec49kPHeLtRCIcmuX2ahRh6GjkjKviLYuuLEu
         Byw154m45vCrWkZCuHBDn4Ls234rIoGg7Rt4osRIqGEZW2OUIs/k6NDCD8wtguwuGZZb
         gsgXEp/osKa6uPQmblMZjIuiJpNnnj0nU6OYNifc68dy2n7fiDXEY3S4fNL9E3kJn0DB
         V7L1tGMrjkKyDgcMaz4nrMjdLZIadwiWYIEEPXni3EedkxCOKzy8B+E9PcBGChKxh1F1
         nThGGn6mbAzqgUTHeL2uCb1+rv4l9y1aJ9ukJoHjLoQF5jVxCP3QLi28H2HrU0GYII1Q
         m+ew==
X-Gm-Message-State: ACrzQf1eL0rph//1QznINb7XfPaonvHqcIRRErCCKHJDXzKyWdQzygMC
        Lpbo6ilI1UBn++ssBbM+pYj9gA==
X-Google-Smtp-Source: AMsMyM7k84xE0Vp2RnScuP0vAATzQQr6nR48LmO1Cm0kWzxrLiFGrr13BA0xgcGf9RCJ0A2oQf8TEg==
X-Received: by 2002:aa7:cb59:0:b0:461:7378:7be0 with SMTP id w25-20020aa7cb59000000b0046173787be0mr56905949edt.60.1667923267738;
        Tue, 08 Nov 2022 08:01:07 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id l2-20020a1709063d2200b0076ff600bf2csm4832601ejf.63.2022.11.08.08.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 08:01:07 -0800 (PST)
Date:   Tue, 8 Nov 2022 17:01:05 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>
Cc:     Melissa Wen <mwen@igalia.com>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        "Juan A . Suarez" <jasuarez@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/v3d: add missing mutex_destroy
Message-ID: <Y2p9QX2r+0MoY1+C@phenom.ffwll.local>
Mail-Followup-To: =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
        Melissa Wen <mwen@igalia.com>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@gmail.com>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        "Juan A . Suarez" <jasuarez@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221107224656.278135-1-mcanal@igalia.com>
 <20221107224656.278135-3-mcanal@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221107224656.278135-3-mcanal@igalia.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 07:46:56PM -0300, Maíra Canal wrote:
> v3d_perfmon_open_file() instantiates a mutex for a particular file
> instance, but it never destroys it by calling mutex_destroy() in
> v3d_perfmon_close_file().
> 
> Similarly, v3d_perfmon_create_ioctl() instantiates a mutex for a
> particular perfmon, but it never destroys it by calling mutex_destroy()
> in v3d_perfmon_destroy_ioctl().
> 
> So, add the missing mutex_destroy on both cases.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>  drivers/gpu/drm/v3d/v3d_perfmon.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
> index 48aaaa972c49..292c73544255 100644
> --- a/drivers/gpu/drm/v3d/v3d_perfmon.c
> +++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
> @@ -113,6 +113,7 @@ void v3d_perfmon_close_file(struct v3d_file_priv *v3d_priv)
>  	idr_for_each(&v3d_priv->perfmon.idr, v3d_perfmon_idr_del, NULL);
>  	idr_destroy(&v3d_priv->perfmon.idr);
>  	mutex_unlock(&v3d_priv->perfmon.lock);
> +	mutex_destroy(&v3d_priv->perfmon.lock);
>  }
>  
>  int v3d_perfmon_create_ioctl(struct drm_device *dev, void *data,
> @@ -177,6 +178,7 @@ int v3d_perfmon_destroy_ioctl(struct drm_device *dev, void *data,
>  	if (!perfmon)
>  		return -EINVAL;
>  
> +	mutex_destroy(&perfmon->lock);

This one looks wrong, I think this should be put into v3d_perfmon_put.
There is also an error case in v3d_perfmon_create_ioctl() that I think you
missed, right above the kfree(perfmon).

With these two fixes this is Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>


>  	v3d_perfmon_put(perfmon);
>  
>  	return 0;
> -- 
> 2.38.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
