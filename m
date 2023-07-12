Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B180175026C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjGLJFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjGLJFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:05:20 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1512700
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:03:57 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbf1b82d9cso68933935e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689152635; x=1691744635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GupHuaIqXzbPk+pS2yyaKy7yHaFuRf0nsu4uBxchRjs=;
        b=T/hA12xiZrfFKp3JKiCj0EzcXLzJaz2SziWM8IA9uYlH7QUI/nyv5mE9vnwYoO/WOU
         N9INt2gIyOW/jzLV5/cAXXR85K4yBqOOuRAqsWlgC9W/WqKqNedR/2eIcqsh3WFMUQzt
         jexpPFZoPxsqu4UasUpXMoim0zgUjZwZS9k6onTASvvvmsrwvkirgh8wD55gzf0NueV8
         v0Y1yzlWcu+UqQZ97TA1d7TRfIn/7sL+QkQNKjsqXMu+rRWrEnk3bjBty9qlf0VbEWvT
         AzOD79q4WDJPNsi1DFHB//sOu5IbgeKiMNLg/u3YonsUIRAX4oyuuXeEr98BOtNQFNey
         VOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689152635; x=1691744635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GupHuaIqXzbPk+pS2yyaKy7yHaFuRf0nsu4uBxchRjs=;
        b=Bta0dVDHk/TlGk/oO3rjQVBpr2Ig4KCfURMblhEltICWHZc0svu4cfuBsQ+oqOgo+u
         bsCJX5g7hM+rmFcu9MyZkEuiX9MUreyHVt2yN3u+vBrmXdOfzS3qhle/aAFweqJR3EPQ
         C94cjFJCCP177D+K0wqnWTdRG7TqtRL6yfnBtYZ1TV8GKV6SbHni0Asq4cCiM2r9UGUD
         fIa0FAtuLt9ptCkTIdMawdIM2FoLIfBIMo7kyNCBNVhikJwfnWsxltD7r5TEpqz58fsT
         LUhWR0LVVlkEdbjXA8mICt1Zti+bOSSwTHgnFgolO1oXO/SDlOTLl9sQwcj1LOZeoKUC
         sARQ==
X-Gm-Message-State: ABy/qLZLMTN11GAsSz31Mnjb5Sk+A00lYLzUKZsfaWZddUW3PcaPcbKT
        va87kwqaiW27Ua3aWw+BKwKNWg==
X-Google-Smtp-Source: APBJJlFf58Sbazh4Bq2aZg5cfCVoDyDVW1kusrum3uRNQGXJ9/dkAONt85gMQI28jMfIru+mjGQ9wQ==
X-Received: by 2002:a05:600c:229a:b0:3fb:40ff:1cbd with SMTP id 26-20020a05600c229a00b003fb40ff1cbdmr14987929wmf.10.1689152635607;
        Wed, 12 Jul 2023 02:03:55 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c029000b003fc04d13242sm11977328wmk.0.2023.07.12.02.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 02:03:54 -0700 (PDT)
Date:   Wed, 12 Jul 2023 09:36:41 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     airlied@redhat.com, kraxel@redhat.com, gurchetansingh@chromium.org,
        olvaffe@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/virtio: remove some redundant code
Message-ID: <b82057bf-3126-4721-87f5-79ca3682cee4@kadam.mountain>
References: <7f67ed65-647a-44d7-a262-d3f1f48d90b9@kadam.mountain>
 <0561b89b-42a8-35bf-feaa-e5feb4ec3cd5@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0561b89b-42a8-35bf-feaa-e5feb4ec3cd5@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 09:18:42AM +0800, Su Hui wrote:
> On 2023/7/11 19:13, Dan Carpenter wrote:
> > On Tue, Jul 11, 2023 at 05:00:31PM +0800, Su Hui wrote:
> > > virtio_gpu_get_vbuf always be successful,
> > > so remove the error judgment.
> > > 
> > No, just ignore the static checker false positive in this case.  The
> > intent of the code is clear that if it did have an error it should
> > return an error pointer.
> 
> Hi, Dan,
> 
> Function "virtio_gpu_get_vbuf" call "kmem_cache_zalloc (vgdev->vbufs,
> GFP_KERNEL | __GFP_NOFAIL)" to
> allocate memory. Adding the " __GFP_NOFAIL”flag make sure it won't fail. And
> "virtio_gpu_get_vbuf" never
> return an error code, so I think this is not a false positive.

We all see this and agree.

However the check for if (IS_ERR()) is written deliberately because we
might change the code to return error pointers in the future.  Static
checkers are looking for code that does something unintentional but in
this case the code was written that way deliberately.

regards,
dan carpenter

