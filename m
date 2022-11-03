Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE64618749
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiKCSRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiKCSRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:17:11 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354057641;
        Thu,  3 Nov 2022 11:17:11 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id v8so1676779qkg.12;
        Thu, 03 Nov 2022 11:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwInbiQpYH0R+lv1Uxr2msjru8SH9TRKDoxjbpGyKW4=;
        b=AKp4aMwwVdDIsIiADTHHRqHWv7tthcid9rYmx9Q8xMXLsqCCYFqAIHsXGq9b8yCsuQ
         VVTXuDjTcObYeaiGOE9b5iPwOeuxhbfkJIt4jBMXkjwUqOtbDBKElift9uL2g6lrhvt1
         BfvfV5P0jQudZL7M60Jola64+KzCfY/3N6l2tIB9FlRq9uHIh/HVbfvpeRXym72Hq5aR
         dS/f5U7AiU824PjPmuEhRozPvmbGonRjCX1B3omN/M8lH5R1s2BQ8kRHVno7Tg5WWytV
         u0s8E1NNM3VWuP+S0I2jO/Ts0Zn3ijDySe2K3y3KWudLD4g14+1S9syAqdhUCfzy3JZu
         KIkQ==
X-Gm-Message-State: ACrzQf2dQNaYBYhTltDWTiz0tJ/oGgmWOuPL9OiY3ZOfwVooCY1JudYU
        o4Cu3MnBtD5Ff2h5ODt8XiiD4VjK/1X6vZlyRFU=
X-Google-Smtp-Source: AMsMyM6tkfZXD9POFVGn74lYYhvpO+OzZF6kPvQKHvUQ/mKo3qFjTpRJL+iMMRsH1fnDuURk5k4+bn6aGfB71NXNX7E=
X-Received: by 2002:a05:620a:d89:b0:6cf:c98b:744c with SMTP id
 q9-20020a05620a0d8900b006cfc98b744cmr22592850qkl.443.1667499430353; Thu, 03
 Nov 2022 11:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221103143654.85275-1-colin.i.king@gmail.com>
In-Reply-To: <20221103143654.85275-1-colin.i.king@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Nov 2022 19:16:59 +0100
Message-ID: <CAJZ5v0hN691V+n1HbUc5J8jZCwONMFQX4exGj=M6A8eeRgLjdw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: SPEAr: Make read-only array sys_clk_src static
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 3, 2022 at 3:37 PM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> Don't populate the read-only array sys_clk_src on the stack but instead
> make it static and add in a missing const. Also makes the object code a
> little smaller.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/cpufreq/spear-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
> index 7d0d62a06bf3..c6fdf019dbde 100644
> --- a/drivers/cpufreq/spear-cpufreq.c
> +++ b/drivers/cpufreq/spear-cpufreq.c
> @@ -39,7 +39,7 @@ static struct clk *spear1340_cpu_get_possible_parent(unsigned long newfreq)
>          * In SPEAr1340, cpu clk's parent sys clk can take input from
>          * following sources
>          */
> -       const char *sys_clk_src[] = {
> +       static const char * const sys_clk_src[] = {
>                 "sys_syn_clk",
>                 "pll1_clk",
>                 "pll2_clk",
> --

Applied as 6.2 material, thanks!
