Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B916F3B9E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 03:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjEBBD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 21:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjEBBD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 21:03:57 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BF73581;
        Mon,  1 May 2023 18:03:56 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1aad6f2be8eso26100965ad.3;
        Mon, 01 May 2023 18:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682989436; x=1685581436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6lzbnAwJquhvg8Kc/5cCYxx0EHomQmC+dFR+xtNtk8=;
        b=Vai3xjNJJUuYG3xmFiuayY6WSUKQjZcnx04cUUXf3vd5WvxTTngtIrxhtU5HH7qoAr
         EWHpEU/ElKl69rJxRpRHTWBssTVrGmAZPu/7LLdBnQtIy334h2HRY0yy4cLEjDTcx+C5
         qOGl18lGo1jROw8h9brzNux2gkcRcUokz1Sf1rUhsgBCUeYPNX4JbnatgjkIBCY0ifbG
         BUWeXS2wY7+CCXnbAb6ePlN5Pu2QGPONELqGsxuKRsigWzGZWgQrL12weILoWetpCQaf
         0vr0vCLjl1GmRHUJ+Bygaj+Z3RxeSJXU3jOOfuwp7T0ZDO/jZFfauERhqDXNLUhN95TF
         fBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682989436; x=1685581436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6lzbnAwJquhvg8Kc/5cCYxx0EHomQmC+dFR+xtNtk8=;
        b=N8bkq9ZI9PtfP3gYZwC/e3MLB296NvGw329PNIfZg36AcvnWac5ZV5MyTrV/LWzY9a
         VUi9fOV6TCAdzYRMVSsGXYt3bzx37UnoESGLemUBCmOMq3N7mCrX8s7weTqhlg+ohBS3
         iVAp1vekFion69BFDUcZGUY+5HePtSeznEsSJq/iRC8wTqKCcMcIdF7oLHDuD/YM868p
         +Uzoqo41956nNopEprCjCbq+JGsIuJ5u57pq+Jxi8cloikGgwiRNMxwXYq39I0luINoc
         s4C/mySgYh/knGxZv4aoTqIj5Set95+7jlOwXCAeYnPHpl4B5TcBM7HQuVYU4BK1B93y
         xS1A==
X-Gm-Message-State: AC+VfDwshMDKwI+Vl4oYwGoSRCRF0tI6JUmEJEfF/g67mRlscVFpzrNJ
        /hxE03uqdZabLeziGnwEUlE=
X-Google-Smtp-Source: ACHHUZ5nfwVUGRCYPoQqfWJL6ELphCOi/xskoMP9EeTdBpXuF9SCfq6t5qNDRBkyWuQgK4obUOw90g==
X-Received: by 2002:a17:903:1210:b0:1aa:cddd:57d8 with SMTP id l16-20020a170903121000b001aacddd57d8mr12101778plh.30.1682989435775;
        Mon, 01 May 2023 18:03:55 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b6ce:736b:e4f7:adb])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902b70600b001a934af187esm18245064pls.153.2023.05.01.18.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 18:03:55 -0700 (PDT)
Date:   Mon, 1 May 2023 18:03:52 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     starmiku1207184332@gmail.com
Cc:     rydberg@bitmath.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: input: input: Fix possible sleep-in-atomic bug
 in input_alloc_absinfo()
Message-ID: <ZFBheCRW5fbzVK1V@google.com>
References: <20230425074951.1042694-1-starmiku1207184332@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425074951.1042694-1-starmiku1207184332@gmail.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Teng Qi,

On Tue, Apr 25, 2023 at 07:49:51AM +0000, starmiku1207184332@gmail.com wrote:
> From: Teng Qi <starmiku1207184332@gmail.com>
> 
> input_alloc_absinfo() may cause the kernel to sleep by calling kcalloc() with
> the GFP_KERNEL flag. It may be called by input_event() holding spinlock through
> the following call path: 
> 
> input_event(), 433
> input_handle_event(), 399
> input_get_disposition(), 294
> input_handle_abs_event(), 232
> input_abs_set_val(), Clang suggests it calls input_alloc_absinfo()
> 	unconditionally
> input_alloc_absinfo(), 483
> kcalloc(..., GFP_KERNEL)
> 
> This call path can potentially trigger a sleep-in-atomic bug. To prevent this
> potential bug, we modify input_alloc_absinfo() to use the GFP_ATOMIC flag
> instead of the GFP_KERNEL flag.

This can not happen in practice, and changing the allocation type to
GFP_ATOMIC hurts the other code. We can avoid the issue by not using the
helper and have input core access the slot info directly. I CCed you on
a patch doing so.

> The possible bug is detected by a static code analysis tool.
> 
> Signed-off-by: Teng Qi <starmiku1207184332@gmail.com>
> ---
>  drivers/input/input.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 37e876d45eb9..eefc4c85a693 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -480,7 +480,7 @@ void input_alloc_absinfo(struct input_dev *dev)
>  	if (dev->absinfo)
>  		return;
>  
> -	dev->absinfo = kcalloc(ABS_CNT, sizeof(*dev->absinfo), GFP_KERNEL);
> +	dev->absinfo = kcalloc(ABS_CNT, sizeof(*dev->absinfo), GFP_ATOMIC);
>  	if (!dev->absinfo) {
>  		dev_err(dev->dev.parent ?: &dev->dev,
>  			"%s: unable to allocate memory\n", __func__);
> -- 
> 2.25.1
> 

Thanks.

-- 
Dmitry
