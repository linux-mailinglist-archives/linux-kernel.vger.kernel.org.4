Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E056BB270
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjCOMgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjCOMf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:35:58 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6940A0B33
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:35:00 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id k2so11954126pll.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678883696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d6hMqbzr+2QKD7iB2OFXLRZx5MGmp0t3ch1cv5eJ1gw=;
        b=GKTN4BoUo5bgP76roytLGlmYeYjQVEqcVO+jv76sWg4R3ZZhbmABv2SwhWZypVHKzp
         TBXkfmrykcbxY1oM8ppnvhopObZ4J9sg+5PGE22Z9buw35pFj6Ewic4LNcDsHeDJJ9iA
         rsjnyFWMCwVSQsgqlJRZFbXmOX5JBK4trSZu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678883696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6hMqbzr+2QKD7iB2OFXLRZx5MGmp0t3ch1cv5eJ1gw=;
        b=KDoGHAqnm0TwSuxUPhlXHvDL0RmWx9R60Ku+OZmOEaDBDIWOwGvK53AsnMN/86aJby
         QxVu7jROHYI9vpXG6SuAbepos3EGZfg1PXKtXKDHbi7lThV/HRPcwl4e5lBnc7aWSK+l
         Rn6LKyKgt+7gBTNXsCe7sgyy31WCxOi19zOMPHlPRRPLbnUOWS2Ui+SmyNOc+t/7UwFR
         Y6v7ipdy0iaZXWH5ZWjZxVGu5HYYmLo7vUmVDWmY5sSYs2vqUvj7jmWYIe88fQfJ4Pw5
         hF/GlIKNJlqYzAV+4JSHclU+iySgmrtM+A/sMMakaRZpbP94FMry84ybtbaUCTEv1Kmv
         L1wg==
X-Gm-Message-State: AO0yUKVCFp2GPL6CZdc3WgScnED2TF6fubUF4hQOWHqdbLubxjhw58dT
        /AMzyPf9VWPOvGP12LroJCr29A==
X-Google-Smtp-Source: AK7set8GvobddgjpVu3fQSdhVar92/aE5NPVv1tR39OuqsCoW+dMd3V9AEWjpyn4dyDeH7svtT+v5g==
X-Received: by 2002:a05:6a20:6914:b0:cb:867d:1594 with SMTP id q20-20020a056a20691400b000cb867d1594mr44353492pzj.6.1678883696547;
        Wed, 15 Mar 2023 05:34:56 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id d6-20020a630e06000000b00508e7bd761fsm3265190pgl.87.2023.03.15.05.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 05:34:56 -0700 (PDT)
Date:   Wed, 15 Mar 2023 21:34:52 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "hn.chen" <hn.chen@sunplusit.com>
Subject: Re: [PATCH v7 6/6] media: uvcvideo: Fix hw timestamp handling for
 slow FPS
Message-ID: <20230315123452.GA1927922@google.com>
References: <20220920-resend-hwtimestamp-v7-0-cf1d78bb8821@chromium.org>
 <20220920-resend-hwtimestamp-v7-6-cf1d78bb8821@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920-resend-hwtimestamp-v7-6-cf1d78bb8821@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/03/10 10:01), Ricardo Ribalda wrote:
[..]
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -473,6 +473,21 @@ static void uvc_video_clock_add_sample(struct uvc_clock *clock,
>  
>  	spin_lock_irqsave(&clock->lock, flags);
>  
> +	/* Delete last overflows */
> +	if (clock->head == clock->last_sof_overflow)
> +		clock->last_sof_overflow = -1;
> +
> +	/* Handle overflows */
> +	if (clock->count > 0 && clock->last_sof > sample->dev_sof) {

Per offline discussion, we set clock->last_sof to sameple->dev_sof
right before uvc_video_clock_add_sample() so this condition is always
false. clock->sof needs to be updated after overflow handling checks.
