Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805CF7025E4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 09:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238340AbjEOHSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 03:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240770AbjEOHRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 03:17:50 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456872699
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 00:17:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f41dceb9c9so64522555e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 00:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684135026; x=1686727026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MPLWP3CUj7nXbwK1eig/zxowYW15P1YnC8aJ9O61dnk=;
        b=Xb6ItDRVMlzOOtJl7GbVYbqyugpgd2ZNrxB/ClgRnmCk7h7W076rSAs1VA2Zcrb9aE
         gXUgfq0+SF3gsgOjxNzXuawUHKpF+yXh90bm17bBHlgo/b8hKVyem/S6U/SeCLeVSCgL
         L7KwQuDD0FRFRf2qQSzATtju13vPd1YIZBPwcMq1b1sQtO+k2CnO/0k6QEsNe9DunfYo
         srzP1gDjTGkrN0mVdVkbiv45gZxf1qH8PK6DAp3pmz6lC4c3aCaOhr3lg/bQm3us9dy5
         +JIMBEG02AwoQRx21icwGZzw4EAJeTBe/7rR5zF81bk2eGCwut7dc6ahRmul00bQqfzH
         Z/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684135026; x=1686727026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPLWP3CUj7nXbwK1eig/zxowYW15P1YnC8aJ9O61dnk=;
        b=Eu6N5qR9fyl4YklI6Vwgv2LRrOsYwHoFDr1AQ3OLrgXg7FjH5bPA+kkj7fI+d27k6V
         mM0oGLt3204gJlrT47G/MY2s/pi0+7lPpPi6Qb7RhRoCADacoUh5tL08ex3TiJ9+4Ui6
         WZRU0JV5SL+F4jO28uoF2WYpZzN1VE1yxnPn79yHyCVUlBabrZ5WJROigpj+DM6xH82Z
         hImKeCDnFJV6Ik4nNxL50QhMNQoflYJ17Bwk2R8cZT8J8GJaBcCa5fNpdt3Dp3jN9pE9
         e2v87JT86QxZno5Ao1tW2xUK7GWbbpdU90+n1iBTwgPdshv5cItLY1FGwFVrURuHJ6gk
         NtVw==
X-Gm-Message-State: AC+VfDyr4xupmcutDOKU/IgI4TmP8DRThj9BMEyx6qnith6W4D1rwK9d
        1kwZ9U5CHwbFe8bqjgi65yM1Pw==
X-Google-Smtp-Source: ACHHUZ5VZHyW5V3zus65QYbAGDvzqPzVTRPUULpm8xMzYTaQO0OkqbPRJU0vTIbpP43eCZs0g/0c4Q==
X-Received: by 2002:a05:600c:2195:b0:3f4:e4cd:f6e with SMTP id e21-20020a05600c219500b003f4e4cd0f6emr9797595wme.17.1684135026626;
        Mon, 15 May 2023 00:17:06 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t25-20020a1c7719000000b003f43f82001asm16132768wmi.31.2023.05.15.00.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 00:17:04 -0700 (PDT)
Date:   Mon, 15 May 2023 10:17:00 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: remove unnecessary (void*) conversions
Message-ID: <ebe9d98c-148d-4694-8f97-96bacd0b9f7d@kili.mountain>
References: <20230515013428.38798-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515013428.38798-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 09:34:28AM +0800, Su Hui wrote:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index f60753f97ac5..c837e0bf2cfc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1470,7 +1470,7 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
>  
>  static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>  {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
> +	struct amdgpu_device *adev = m->private;
>  	struct drm_device *dev = adev_to_drm(adev);
>  	int r = 0, i;
>  

This declaration block was originally written in reverse Christmas tree
order:

	long long long variable name;
	medium length name;
	short name;

So you probably want to change the order now that the lengths have
changed.  Same in the other places as well.

regards,
dan carpenter

