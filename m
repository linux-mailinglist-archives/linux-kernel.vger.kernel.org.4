Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C61965607B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 07:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiLZGlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 01:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiLZGlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 01:41:15 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1499261E
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 22:41:14 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id k23so2207858ual.8
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 22:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pIFJvpkO7mmQ+cyz+DICxCYAUcnhXk54K2D6tr7hNmA=;
        b=BYmghKmwaLqWgV1R5z53x4FUhMOzvIgRO9ihAgSXUmHX4vbdh5vTQOTkDCYMeEW/BJ
         9uXmqxp7uPywqNtiAFPIAI3Q7cFo4sYuumlx7IqSQV9U4Kgn8n3ppLZVzusgwlHoxsT0
         uRNyYw6PVm2Nl9gh+ZtQcQtAWpOaEhe3Rtg28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pIFJvpkO7mmQ+cyz+DICxCYAUcnhXk54K2D6tr7hNmA=;
        b=N5rs5Oqn/si9TzlRg23SX9biygPVzpGqk5m3xkFX9kC/EKFqUwuFqo82M9r21RzcLm
         bETMHwrgJ/IEfcUZfqieFFB8aXEoFN7Xg32wksFm0J6UGKAhiHk1w39ElaFQXLGmESzq
         ctMICoH/lvLbfoz/VrwzqnqA1gJzQT5Pxyq5h7YrMasRVSrq46OE6x5TXeT0G0ArGj7Z
         WMPUZQPvZ4l+8aVcEFq3s3wvEdX7MjLe+WlOreYQlvO3lzNGVfHXqFds+QmaVrESZcl/
         Z1Sq+S/wiERx+CtbeI0I1tplJiXM/g9hc7h+Zo3SIZVn7mhHpYbh/VN6SVrXmaJvFmfn
         8P9g==
X-Gm-Message-State: AFqh2krrFL3zOdePo3VPS4efZz/hMkyvWv4WQDO5w+1W5VlS2hBrVvsg
        2AQMZhM6kXlwPQbFUVG+48uoQbPkcMea8fmxfyNUCZ+LEL0B5A==
X-Google-Smtp-Source: AMrXdXtocbgpBPb70sNQS0nN5Qje72F2peRA9iLUAtVoyaKwtwgnm3WCoQ4AVmRPpjMRkUISpECBKKr1mzk1nSgdIqw=
X-Received: by 2002:ab0:7411:0:b0:418:b849:8187 with SMTP id
 r17-20020ab07411000000b00418b8498187mr1580687uap.43.1672036796827; Sun, 25
 Dec 2022 22:39:56 -0800 (PST)
MIME-Version: 1.0
References: <20221226061711.3988-1-chuanjian@nfschina.com>
In-Reply-To: <20221226061711.3988-1-chuanjian@nfschina.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 26 Dec 2022 14:39:45 +0800
Message-ID: <CAGXv+5HT4CD5eRYCuAdwrdAPRbNcd9SPEdDCnPfLpAAQbooBYQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/media/v4l2-core/v4l2-h264.c : add detection of
 null pointers
To:     Dong Chuanjian <chuanjian@nfschina.com>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.com, sebastian.fricke@collabora.com,
        ezequiel@vanguardiasur.com.ar, linux-media@vger.kernel.org,
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

On Mon, Dec 26, 2022 at 2:17 PM Dong Chuanjian <chuanjian@nfschina.com> wrote:
>
> Continue the program when the pointer assignment is successful.
>
> Signed-off-by: Dong Chuanjian <chuanjian@nfschina.com>
>
> diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
> index 72bd64f65198..1163cd48ff33 100644
> --- a/drivers/media/v4l2-core/v4l2-h264.c
> +++ b/drivers/media/v4l2-core/v4l2-h264.c
> @@ -343,18 +343,19 @@ static const char *format_ref_list_b(const struct v4l2_h264_reflist_builder *bui
>         int n = 0, i;
>
>         *out_str = kmalloc(tmp_str_size, GFP_KERNEL);
> -
> -       n += snprintf(*out_str + n, tmp_str_size - n, "|");
> -
> -       for (i = 0; i < builder->num_valid; i++) {
> -               int frame_num = builder->refs[reflist[i].index].frame_num;
> -               u32 poc = v4l2_h264_get_poc(builder, reflist + i);
> -               bool longterm = builder->refs[reflist[i].index].longterm;
> -
> -               n += scnprintf(*out_str + n, tmp_str_size - n, "%i%c%c|",
> -                              longterm ? frame_num : poc,
> -                              longterm ? 'l' : 's',
> -                              ref_type_to_char(reflist[i].fields));
> +       if (*out_str != NULL) {

I would suggest returning early if it's NULL. The change would be cleaner
as you wouldn't need to reindent the whole code block.

ChenYu

> +               n += snprintf(*out_str + n, tmp_str_size - n, "|");
> +
> +               for (i = 0; i < builder->num_valid; i++) {
> +                       int frame_num = builder->refs[reflist[i].index].frame_num;
> +                       u32 poc = v4l2_h264_get_poc(builder, reflist + i);
> +                       bool longterm = builder->refs[reflist[i].index].longterm;
> +
> +                       n += scnprintf(*out_str + n, tmp_str_size - n, "%i%c%c|",
> +                                      longterm ? frame_num : poc,
> +                                      longterm ? 'l' : 's',
> +                                      ref_type_to_char(reflist[i].fields));
> +               }
>         }
>
>         return *out_str;
> --
> 2.18.2
>
