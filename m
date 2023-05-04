Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A756F6DCB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjEDOeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjEDOeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:34:09 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF464ECA
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 07:34:07 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-74e3de79bf2so43420685a.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 07:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1683210847; x=1685802847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GHDdoC1r+IX1rZBuo0UOLx3dvVPL3q5exl0lVWuYjLY=;
        b=XT2mNxljdb4cmX/bACt+9AfdmKgAkhANKy2uzeQls/dPTs0/LzWR5BqYNdl8etLvsk
         +Fs6zVS3PODI1l9zbuYAaj1oNEODgCtFNzgogc5lEkmUVTdkXndZXQ0H66V2yKMuCX/E
         ks4pTjSPonhaYFPXvBtmgCMOnAEcBr3yvDfKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683210847; x=1685802847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHDdoC1r+IX1rZBuo0UOLx3dvVPL3q5exl0lVWuYjLY=;
        b=BoL7em8794BwuZvWVirf7UG2u/NAdV5jX1oHiVq0kaZ9Tv6IhNZkbIZEWry+Q3MMNi
         I879geucRdBD3rRL+PjQuVc1Vjz/n9FF/2s5SuYabDI0DAjtfrXl5JnFG9VwPZLa48GC
         kpbdtgS8wS+hmBKOce372X8J3fsGBTHs8wJpMrpS5x/XrdocDzs8aQSFGVLhMh5m4XqE
         TgdcbYzYVYpzH8mDDP04yj92pU3zS/yJz1GyPxns/g9lHxZ+Q3n7peFMaU1FMUUA8QIZ
         lNgTC1dIoVQdZnJDtOmcG4fQYhqbSw3+F5oRSzANzg+iFlimLGrqQufrhQrG6st0UZup
         xXqQ==
X-Gm-Message-State: AC+VfDxkiUiNilWN9pGOo9qSdtfjN3fQcgvosVZiMGbtdDCTn04a1t4A
        bEcZPNxhmdS7kDCeDzJyg2mj6Q==
X-Google-Smtp-Source: ACHHUZ5ajupa+b3/nXL5wAGaVr0jouWL7tffzHLa2bSznfjo2enRBdANCgitfaxJLRqkAXNiNZh4wQ==
X-Received: by 2002:a05:6214:234a:b0:5ef:4254:d6f0 with SMTP id hu10-20020a056214234a00b005ef4254d6f0mr15130897qvb.36.1683210847017;
        Thu, 04 May 2023 07:34:07 -0700 (PDT)
Received: from [172.22.22.28] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id l17-20020a0ce511000000b005dd8b9345dbsm4016450qvm.115.2023.05.04.07.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 07:34:05 -0700 (PDT)
Message-ID: <6a016d38-65db-6371-86f2-e16a2aba69bf@ieee.org>
Date:   Thu, 4 May 2023 09:34:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drivers: staging: greybus: fix GPF issue in
 gb_camera_capture
To:     Dongliang Mu <dzm91@hust.edu.cn>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jacopo Mondi <jacopo.mondi@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Greg Kroah-Hartman <gregkh@google.com>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230504135841.1566958-1-dzm91@hust.edu.cn>
Content-Language: en-US
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <20230504135841.1566958-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/23 8:58 AM, Dongliang Mu wrote:
> In gb_camera_capture(), it does not check the value of settings
> before dereferencing it. And gb_camera_debugfs_capture calls
> gb_camera_capture with the 6th parameter settings as NULL.
> 
> Fix this by checking the value of setting at the starting of
> gb_camera_capture.

The req->settings pointer you're checking here is actually an
address.  It refers to the flexible array at the end of the
gb_camera_capture_request structure.  If the settings_size
argument is zero, nothing will be copied; otherwise no more
bytes will be copied than were allocated.  So your proposed
patch serves no purpose.

If you really want to improve this bit of code, I'd suggest
calling struct_size(req, settings, settings_size) rather
than manually computing it in the assignment to req_size.

And...  if you do that, look for other places to do that in
the Greybus code--and plan to fix them all.

					-Alex


> 
> Fixes: 3265edaf0d70 ("greybus: Add driver for the camera class protocol")
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>   drivers/staging/greybus/camera.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
> index cdbb42cd413b..5a4b26e7f645 100644
> --- a/drivers/staging/greybus/camera.c
> +++ b/drivers/staging/greybus/camera.c
> @@ -659,7 +659,7 @@ static int gb_camera_capture(struct gb_camera *gcam, u32 request_id,
>   	size_t req_size;
>   	int ret;
>   
> -	if (settings_size > GB_CAMERA_MAX_SETTINGS_SIZE)
> +	if (settings_size > GB_CAMERA_MAX_SETTINGS_SIZE || !settings)
>   		return -EINVAL;
>   
>   	req_size = sizeof(*req) + settings_size;

