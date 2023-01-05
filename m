Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20CC65E456
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 05:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjAEEEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 23:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjAEEEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 23:04:38 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F8237259
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 20:04:37 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id w3so6537398ply.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 20:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RApvxshuZdMS0E/1FNF+yTZLZpugDqrkxZLJmORMSgQ=;
        b=H4CxW0UkDE0BZmtaWVlT/jpDqtc3xMLG83CBHM0nXfs0iBS777sQdNKwFMjznCtR4k
         inhXzFyfj+TtHVAGVhsV6dSG2VFsQR0TTvvq+fXl0Plmu/xv8aP5jjVkEbnpnujtDyVT
         8CD/zs1KX4D/Fzims8DGtwbsH4r6NoVJX5BWwKG9+ZDNkKtq+4jdiGYjMdYnuF9tdNAa
         Eo1sU5GqSoiWQDrkX1iTX8UNlTjnIvidwqNleYTUVoBLZDwLnD6SpYUVysc1pSRM8O7j
         caq7bk2RvRlcCdzKKY+0Fzw6mj3CDwXmYOg3D+9GtK8DlhZIYB30Y4Fj7714VQ6V+Oar
         HLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RApvxshuZdMS0E/1FNF+yTZLZpugDqrkxZLJmORMSgQ=;
        b=GNkB+JRRY4DYnsbupqpCRDIKJSJbCAJnMov9oT6W1bq79b3p6PA4RxTf9zZdkJ722X
         gCxoGA/ect15zpVh5SlztOvP8pOgiSuK4+GSI4lhoc9w2vy0rVQ4YXXFO9Q6lUJSoqZg
         RYfPEzik635rJFFmDeyph6E7x3yHfvHfbAl7IVAD7+jxrTnKomv7V72enXV3a8YthZut
         Slvb7yEDIXX+1bcK+nX7NYcPlOWHvno+7Wh8qh8XXSwGoXUFTZ7i8QJh9U5AYCCCKVPL
         r+4UMC5BJk2IysX8eskAo+WjZJ8uM+16GHAISHDRSZ02tPs3C3fsbi7EAFvkXtpjLgwz
         PrKQ==
X-Gm-Message-State: AFqh2kpk5kXZhpOlvvr96+eHAnd87BfT5jzt5+NfIkVCY9FjU8g5QRcP
        wlq+dbD46cXAYkpmNcEbzIQXcA==
X-Google-Smtp-Source: AMrXdXth9NLc1gzCJXnk5JUnyW/W7beAtfH+YBJ5b8yuS99fSoEmu2sQxdBxwExRiXaSe3NzKaOOVQ==
X-Received: by 2002:a17:90a:9dc2:b0:219:ed0b:f11a with SMTP id x2-20020a17090a9dc200b00219ed0bf11amr53314870pjv.8.1672891476679;
        Wed, 04 Jan 2023 20:04:36 -0800 (PST)
Received: from localhost ([122.172.82.107])
        by smtp.gmail.com with ESMTPSA id on16-20020a17090b1d1000b0020b21019086sm2529074pjb.3.2023.01.04.20.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 20:04:35 -0800 (PST)
Date:   Thu, 5 Jan 2023 09:34:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH rcu 10/27] drivers/cpufreq: Remove "select SRCU"
Message-ID: <20230105040433.wgxqwztfrizcvb2m@vireshk-i7>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-10-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105003813.1770367-10-paulmck@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-01-23, 16:37, Paul E. McKenney wrote:
> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in selecting it.  Therefore, remove the "select SRCU"
> Kconfig statements.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: <linux-pm@vger.kernel.org>
> ---
>  drivers/cpufreq/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 2a84fc63371e2..785541df59379 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -3,7 +3,6 @@ menu "CPU Frequency scaling"
>  
>  config CPU_FREQ
>  	bool "CPU Frequency scaling"
> -	select SRCU
>  	help
>  	  CPU Frequency scaling allows you to change the clock speed of 
>  	  CPUs on the fly. This is a nice method to save power, because 

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
