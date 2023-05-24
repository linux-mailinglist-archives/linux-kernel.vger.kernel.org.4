Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459A570EC84
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 06:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbjEXEXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 00:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjEXEXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 00:23:53 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A6CC1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 21:23:51 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f606912ebaso5876415e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 21:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684902230; x=1687494230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NRuouVRQ/wxWNbz483jQ6XwRBWGjdIht0MWlJ69UoUA=;
        b=E/fGatXFNqKdWxkPWD9mXlTuSPelkKO0WqUWrvcbItn6kVUIET/dSBO007AFcMzAKx
         hsSXgHv/nIgsK9yQnbhZRXWCpeB7iuVVUaGMGhIL/2sx62FAcruy2IwnOC30Dnw3uxq5
         l5M5l4Er+LkCx5p90jjZePrbZIvUw6+pV6PKfKFO6/D9welB6T182phEFh9SsHwMbWjC
         /APE36L9kPdKaVcGhlgx5P1GYeI2xtATH3RavQv4QwpR3EGs9Rq9Zte3hgcHkTimzS5c
         ykE6jMx9eJmlVTSPsXmUxypKJosyVNGAHb3T/wOaHopP6Kkh22GE77UhiK92RwSDkM6S
         mWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684902230; x=1687494230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRuouVRQ/wxWNbz483jQ6XwRBWGjdIht0MWlJ69UoUA=;
        b=BrOsFtue32nVSe1UgXDsZMnVHhO1NM2oEHAWrOCmKsiBOV2QB/QUcfkVb4r2sjcQ0G
         g7JoOGVNnoegbieV8khiDDDVFrsA+3BcOERaFOd7H1RqmJgUMYoNsyiZE7VyVhsnRYBE
         EtP/S+ffIfoISzS7bqdUCLGv1H9mp0rbWZGNxlB8tHmHlHaKp3IuFt3qhBk/sp4aSuet
         NcGa4x7nSz9Ldb0PqzhXia+I6XUCMUlj9I12ex+ojm88qrFq5utcEg2raxVPHFJLck1H
         9uVNcAoK2OVTCGJpW8pqnQ1ghmq6LIsuGXpu3AyNZ9CmOu21Q3xwvz1SmvVbqopWgM10
         skyw==
X-Gm-Message-State: AC+VfDw2V/3t1Uc3cjyd/3h75cOerUCwCJDIrXxoJuxBHdDUABecuOKv
        pf24Lg9vtEX+T7mk7FKwEzpaWg==
X-Google-Smtp-Source: ACHHUZ5bXIvY/MYTDZ3QyksukcRe9NgWXvGJ8opvFz9oK2jEFj4vnk1wHV2hU+CEWFJE/NKSAkrGqQ==
X-Received: by 2002:a7b:c7d8:0:b0:3f4:f0c2:143 with SMTP id z24-20020a7bc7d8000000b003f4f0c20143mr11868819wmk.20.1684902230014;
        Tue, 23 May 2023 21:23:50 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z10-20020a7bc7ca000000b003f602e2b653sm815605wmk.28.2023.05.23.21.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 21:23:47 -0700 (PDT)
Date:   Wed, 24 May 2023 07:23:45 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        YongSu Yoo <yongsuyoo0215@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] media: dvb_ringbuffer: Return -EFAULT if copy fails
Message-ID: <7af16b9a-09d1-46ff-b9f9-c178173cf940@kili.mountain>
References: <20230524012733.414441-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524012733.414441-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 09:27:33AM +0800, Su Hui wrote:
> The copy_to/from_user() functions return the number of bytes remaining
> to be copied, but we want to return -EFAULT to the user.
> 
> Fixes: 04da2daee383 ("[media] ngene: properly handle __user ptr")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/media/dvb-core/dvb_ringbuffer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/dvb-core/dvb_ringbuffer.c b/drivers/media/dvb-core/dvb_ringbuffer.c
> index 7d4558de8e83..f132578840ad 100644
> --- a/drivers/media/dvb-core/dvb_ringbuffer.c
> +++ b/drivers/media/dvb-core/dvb_ringbuffer.c
> @@ -216,7 +216,7 @@ ssize_t dvb_ringbuffer_write_user(struct dvb_ringbuffer *rbuf,
>  	if (split > 0) {
>  		status = copy_from_user(rbuf->data+rbuf->pwrite, buf, split);
>  		if (status)
> -			return len - todo;
> +			return -EFAULT;

No no no.  This is obviously deliberate.  It's returning the number of
bytes that were successfully copied.

(I'm not sure I like this API.  If buf is a bad address then shouldn't
we report that to the user?  It's not like we ran out of space or hit
some limit in the kernel, it's just a bug in the user space program.
However, changing the API is dangerous and could break user space).

Same for the other.

regards,
dan carpenter

