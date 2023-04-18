Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F6E6E57EC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 05:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjDRDxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 23:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDRDxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 23:53:12 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE57D3C24
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 20:53:11 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a68d61579bso7245145ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 20:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681789991; x=1684381991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UB6ieBFEuIZztgRulEtiKmJ0O9/UlCo5NZGoGL1i4vw=;
        b=dRCnvZecuMcnPoMp706cWVVRApc7gnUhMkQqEWnbr442qYxccgHDhUHDeO7KxhzuM0
         AUHdDjoDOA+sKWD6WW7mUyKzychnzoH2kxjbbRuqT72oWZahoYgUwNrdLVuatyu3yISa
         myvoc23p/LaWnCEnZigUIDU4cAE0IogmN/I4/RNpnEzYi81SyA6ebopCJUt0H6fOQqtH
         +01tgmMD3UNR9l88vbjW9qVx0Y6GBHXJE64XVyWhXTlZI0NZ8y7X4IXlbCyZarxQu3hX
         Fv5YQJqN/HsT3UF2pzOnEWjz8Rgt6CsoWjb6Un8Y6ZgBRPe0vtWgOcGGDYbxC8fxYB6V
         XFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681789991; x=1684381991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UB6ieBFEuIZztgRulEtiKmJ0O9/UlCo5NZGoGL1i4vw=;
        b=Ie0Jybvajo08Z5/BG7dRqJZc0ZmIZs9hW/Z4s2JiNZK19NEV5BGmCIFchlQhLRHTdE
         3rOc/NN/MAQpnwDEyyH1Sq0qjLng0Ab6W7Kv42kTyytchGhot6y4o0/M4H/TY7lynZTo
         U97sqn1o4HL9pBGKqZ7HODkft1HRrrPgOsC6fqp7BaGTdynJH72+XxryjDgGGsMNgAdX
         dTC+EPL0DPz1p2zS6u/H9yBY95k+dqkKgM3fS7TDMA8dg5y+DB4c7HW0DG8lzAROKW8Z
         Gt1Wbh6F8Mpt3EHwZ2w/MdsQ+D7iOtW9P+IjA86a29UGpHvZi7UpoS2naj75Xr3Z6kLz
         8Wvg==
X-Gm-Message-State: AAQBX9d4S8S/EsE97EgK4qpKFoD4/0zDVGsfr/+kCEJ9+iJHjV0BDfCx
        R6BhGLUEBjDWoE3oJI/plVzxJA==
X-Google-Smtp-Source: AKy350Y/0RnVwSJT7DaVAqt0HLO71OI3v6IV6VXk6elbnvwwCdypp3Eg/sgMU3B5ifSqTlk0NodVNA==
X-Received: by 2002:a17:903:2cc:b0:1a6:b52a:b00b with SMTP id s12-20020a17090302cc00b001a6b52ab00bmr860967plk.29.1681789991223;
        Mon, 17 Apr 2023 20:53:11 -0700 (PDT)
Received: from localhost ([122.172.85.8])
        by smtp.gmail.com with ESMTPSA id iw18-20020a170903045200b001960706141fsm8492807plb.149.2023.04.17.20.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 20:53:10 -0700 (PDT)
Date:   Tue, 18 Apr 2023 09:23:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Chenggang Wang <wangchenggang@vivo.com>
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal/drivers/cpuidle_cooling: Delete unmatched
 comments
Message-ID: <20230418035307.f6p2jp3nxgfyebns@vireshk-i7>
References: <1681789108-28130-1-git-send-email-wangchenggang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1681789108-28130-1-git-send-email-wangchenggang@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-04-23, 11:38, Chenggang Wang wrote:
> The function no longer returns a value, synchronize the comments.
> 
> Signed-off-by: wangchenggang@vivo.com
> ---
>  drivers/thermal/cpuidle_cooling.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
> index 4f41102..7779739 100644
> --- a/drivers/thermal/cpuidle_cooling.c
> +++ b/drivers/thermal/cpuidle_cooling.c
> @@ -236,9 +236,6 @@ static int __cpuidle_cooling_register(struct device_node *np,
>   *
>   * This function is in charge of creating a cooling device per cpuidle
>   * driver and register it to the thermal framework.
> - *
> - * Return: zero on success, or negative value corresponding to the
> - * error detected in the underlying subsystems.
>   */
>  void cpuidle_cooling_register(struct cpuidle_driver *drv)
>  {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
