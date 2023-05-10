Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA066FE2D0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjEJQ4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjEJQ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:56:40 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A04180
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:56:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f42d937d61so17509205e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683737797; x=1686329797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Gc42bzaewvbzuVY4XS1BAUy3IQI/qYsbZWzsf3GfP0=;
        b=cVqT1ib9QJ9/kzKSOTrNRKUbrjFXsGdqeYhc+sl3GIaaiQoSSiWjaiKpzzyY7nVDul
         b7EiokHUG3Gt+0er8OBdwhd9EfIySBdyvkXcbFe07PpYc17OSHvGFkksgsmZpa8sdxre
         jNADZnOp0yzjwZqfnJrO9mWcPtNlUdF51ebwYeeury3NNZqR8Zp87b8Y9ixIJMPq2TJN
         0xdVoNAvjTK59i8wYlIDb2FZoKUII5pTdx5egOrA4n4SQ4I/EcTP189nw1o3FYYGkbwj
         eaHvBihLqCUKVZBGXFPokDC8Hvrm91tXUoANiG7GRwYINzuFxC0KjDzZ2X063f4rwrjx
         oEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683737797; x=1686329797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Gc42bzaewvbzuVY4XS1BAUy3IQI/qYsbZWzsf3GfP0=;
        b=JsBTxgidPsNRu9CUilC2O7eoil8akvuVhI6HypGc7J6UQ5iICl5uQmUsivE2QeEsXI
         hXvK4t2A8A7VC+nfCyqzDnsOljsnh8ROD2FXwytLGJOq0bm3hR2Rol89fzmkcNUYDu8h
         P/ee6STGk73zApYOdRchl+OGeN6ZC5dEwg3HM6dFgQ0Xi7M6BIbgnfwLh9sA4//mDBVt
         RuWkT0dfbYES0UsnfbcPMPRSt+Kxlbno5lKdyEoBrFQQlBJVY+uXZDorDCVsv+9dRIVb
         QeXq28wyCfMN3PXRBJkXGO/iplGgugOv6A9/3OGTc3dSS66eWHBYqDdxST+iJR6pBYoY
         tMUQ==
X-Gm-Message-State: AC+VfDwfYxDdAMTg1uDZSzUUp+SQR3RIOgYhMEA5yJBnujhAxhHK2yRx
        2T6x66yyczAhlDGtKovkBC+VSQ==
X-Google-Smtp-Source: ACHHUZ6qVCedZJaUlxkTnZAmvQ1PaaZpHadEIgUXazjoLAIMDpp9IpqCHyYK3Ho/Q75x73mF1RUMGA==
X-Received: by 2002:adf:ecc4:0:b0:306:2c5b:9da6 with SMTP id s4-20020adfecc4000000b003062c5b9da6mr13711866wro.56.1683737797002;
        Wed, 10 May 2023 09:56:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o2-20020a5d62c2000000b003062c609115sm17818387wrv.21.2023.05.10.09.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 09:56:35 -0700 (PDT)
Date:   Wed, 10 May 2023 19:56:29 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Yogesh Hegde <yogi.kernel@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] staging: rtl8192e: Rename tmpRegA and TempCCk
Message-ID: <290473de-5946-49d4-9309-6bebf7cc9873@kili.mountain>
References: <cover.1683730854.git.yogi.kernel@gmail.com>
 <c9c67f832db3a776c04f26e0afb083ae3ba99c07.1683730854.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9c67f832db3a776c04f26e0afb083ae3ba99c07.1683730854.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 08:39:07PM +0530, Yogesh Hegde wrote:
> @@ -680,17 +680,17 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
>  		return;
>  	}
>  
> -	tmpRegA = rtl92e_get_rf_reg(dev, RF90_PATH_A, 0x12, 0x078);
> -	if (tmpRegA < 3 || tmpRegA > 13)
> +	tmp_reg = rtl92e_get_rf_reg(dev, RF90_PATH_A, 0x12, 0x078);
> +	if (tmp_reg < 3 || tmp_reg > 13)
>  		return;
> -	if (tmpRegA >= 12)
> -		tmpRegA = 12;
> +	if (tmp_reg >= 12)
> +		tmp_reg = 12;

Not related to your patch (which is fine) but this if statement can be
deleted.

>  	priv->thermal_meter[0] = ThermalMeterVal;
>  	priv->thermal_meter[1] = ThermalMeterVal;
>  
> -	if (priv->thermal_meter[0] >= (u8)tmpRegA) {
> +	if (priv->thermal_meter[0] >= (u8)tmp_reg) {

And casting tmp_reg to u8 is nonsense so that casting can be deleted too.
2 separate patches:
patch 1: delete unecessary if statement
patch 2: delete unecessary casting

regards,
dan carpenter

