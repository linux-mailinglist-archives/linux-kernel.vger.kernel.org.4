Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717A7647FC2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 10:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiLIJBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 04:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiLIJBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 04:01:43 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D6B4C26B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 01:01:42 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id bj12so9908094ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 01:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VkIO4Hdy29JcOCmLWTJCzzBNA025RxZZ30RRyjorBXg=;
        b=1cp8zANOM54G3lFtlHbxBo/F2nYTbunRc2H/MOPeNtwTtyPK+OmXUrkEHW4UkSnM0h
         iaFoJABGeQYJBBuukUgq4vvGvfDmbJD6jtrJkfTbHNrAZT2m7F+w8E1WTI7d9T4DNHYq
         UIsOBrFrfzZWtqJHfolMzack+ddzwN3eB0Vx70CQ1BnkuIr452PYwUUerD4SJVPPG2Ot
         OuFmXv2jCGq8mm+EY53oGGxuXbaiuQoH9ULpyIwvrHNWj+X4lV9xmyzMpZtykZ7OHG5E
         3zRyh8WIED3pY8OqsV/ihq/J6qFpMH3VFrjU2TNe3uRjDT2cOnq7L/hemb2iAX0mFJuN
         gGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkIO4Hdy29JcOCmLWTJCzzBNA025RxZZ30RRyjorBXg=;
        b=m71gSdS9oucbk0pxiQ1g/Uy9Z8EfklV1KqLgdpsjvr5LxbMDE9qimE8YUNBfU7mWWC
         lSrC0jRsVmZLV3IBoh7mdsw1vSrMzRnCIgTeXscWwzLYkRKUS281A8EM0fBuhrqOJj7x
         nKAlyeHBmFn+Lco5WDp68Wl1A9/EeMYSzOR8XyrY4MqlxlNEFeiSAK1WU0vveBRV2gZV
         pS2CxvlAb7cqGRe3TMrUhqLuJYjL3gtgLj510fDYvKLmvLX23M7Xr525TvDDGXR4I0AJ
         eiMfBbtDke2zOXvtEwnXWFOPhMHmuXxGJV/ZMDjqfwr3whisYQGRDYuX13XLWhTIIuKz
         6+bw==
X-Gm-Message-State: ANoB5pkP354/JeEjIzxOZqHF5LBWAIjoEVjV76Vo6UiPvdr/TRkJ8GWk
        U/DFS9BxebKmfpB83iL5c0cpTHgTtypFTRPZX5w=
X-Google-Smtp-Source: AA0mqf5L2cnKZLSjP0EYt5Yb1wFUSBemia5vSCifCutvwtt59S63T5+hNCHMRDnLu0qgv7H9dn/bPw==
X-Received: by 2002:a17:906:3a96:b0:78d:f454:ba4a with SMTP id y22-20020a1709063a9600b0078df454ba4amr5025756ejd.73.1670576500814;
        Fri, 09 Dec 2022 01:01:40 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id f20-20020a170906825400b007bfc5cbaee8sm330977ejx.17.2022.12.09.01.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 01:01:40 -0800 (PST)
Date:   Fri, 9 Dec 2022 10:01:39 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     yang.yang29@zte.com.cn
Cc:     dchickles@marvell.com, sburla@marvell.com, fmanlunas@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xu.panda@zte.com.cn
Subject: Re: [PATCH net-next v2] liquidio: use strscpy() to instead of
 strncpy()
Message-ID: <Y5L5c2fG0Ro49Nuv@nanopsycho>
References: <202212091534493764895@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212091534493764895@zte.com.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Dec 09, 2022 at 08:34:49AM CET, yang.yang29@zte.com.cn wrote:
>From: Xu Panda <xu.panda@zte.com.cn>
>
>The implementation of strscpy() is more robust and safer.
>That's now the recommended way to copy NUL terminated strings.
>
>Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
>Signed-off-by: Yang Yang <yang.yang29@zte.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
