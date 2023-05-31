Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDCA717485
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 05:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbjEaDv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 23:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjEaDvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 23:51:24 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC42FC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 20:51:21 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6af93a6166fso4108534a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 20:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685505081; x=1688097081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mc749fSoT7HRuZHMhc7vPNXSe/JLAydSHJGmkjEZ7Fw=;
        b=Tyw1GlPkBOpYbtCaPr1gWiNTs0bxcS6ipEd5PkOHCkTMrkh1ohHRoksZR0UIArJ3rg
         hsYeEAhYA0cXPOqUq2M+3QFgZEUXxlYNU3ZxeyfnqnulkOIDEX6fkmRpLDxIAp4GZghe
         EyJvK5eEVUeQWu0uZDXJAPY0yJA5p49qVhRCucigkF0nbqGHcvxIq9lT1RDydxJbZzhi
         E35zaf4AdqKIrM2DyWkr6PIX4uEONBZrlOGqQUGSE8Ad6C8xMhOFypJr9FUPLlCSHJkJ
         Fwntqrm4vyIeOcD6Ec3g0RvqurFYAQRtgu0K3r3vSHcorv11AxDERz5EaCwgbad/0rIe
         GEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685505081; x=1688097081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mc749fSoT7HRuZHMhc7vPNXSe/JLAydSHJGmkjEZ7Fw=;
        b=LrdBmd8CgQ55zv54QZ5bhMzY0O/h3tBoUzJEusTFIwKqc+VzyzlqV10kMweARyzDID
         K3E9zuhlN0BKLOU/P1QiBm1h3Z7AhDV5BJnaGUJruX6XT2yIbu+ivnABFDrOM4xLXNNP
         5iZgHGe+dXp7+eBg3Zk/nI0UewnP6efa1svfUeqgYkZIxGwdp1T6cb55GLxfrBj9pj60
         MYnHXt+9qlgSXIwGvRkkJfrzK9jbGnlP4XDqrb4qmnlDa5smKI1JbCeuj9HAOLIJbxxx
         qSG0l9DBX6qYaq7g0cCpaRdGkOUuoXo4mLKUvqRJwOgvvzA0tdGmLQNi7swrNKkLtgKC
         aeJw==
X-Gm-Message-State: AC+VfDxN9Kg0rrd7XmiUS5hgWVO2eTSxzJvKdULRvCFxKqGuzU/DYUv1
        XoL5gcu3cI10JwL8EKCrBNj+xA==
X-Google-Smtp-Source: ACHHUZ60r75L+3Ycnf3xvFGl18uDOQ2gSUt6IFQ22YuOR4Dob9Ig7awwVDgye5CrNzIKDflk01jw+g==
X-Received: by 2002:a05:6358:7241:b0:123:3133:1899 with SMTP id i1-20020a056358724100b0012331331899mr590034rwa.1.1685505081036;
        Tue, 30 May 2023 20:51:21 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b001af98dcf958sm81371plr.288.2023.05.30.20.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 20:51:20 -0700 (PDT)
Date:   Wed, 31 May 2023 09:21:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] opp: Fix use-after-free in lazy_opp_tables after
 probe deferral
Message-ID: <20230531035118.p3iogejcmatd7nql@vireshk-i7>
References: <20230524-opp-lazy-uaf-v2-1-c26304544a47@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524-opp-lazy-uaf-v2-1-c26304544a47@kernkonzept.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-05-23, 17:54, Stephan Gerhold wrote:
> When dev_pm_opp_of_find_icc_paths() in _allocate_opp_table() returns
> -EPROBE_DEFER, the opp_table is freed again, to wait until all the
> interconnect paths are available.
> 
> However, if the OPP table is using required-opps then it may already
> have been added to the global lazy_opp_tables list. The error path
> does not remove the opp_table from the list again.
> 
> This can cause crashes later when the provider of the required-opps
> is added, since we will iterate over OPP tables that have already been
> freed. E.g.:
> 
>   Unable to handle kernel NULL pointer dereference when read
>   CPU: 0 PID: 7 Comm: kworker/0:0 Not tainted 6.4.0-rc3
>   PC is at _of_add_opp_table_v2 (include/linux/of.h:949
>   drivers/opp/of.c:98 drivers/opp/of.c:344 drivers/opp/of.c:404
>   drivers/opp/of.c:1032) -> lazy_link_required_opp_table()
> 
> Fix this by calling _of_clear_opp_table() to remove the opp_table from
> the list and clear other allocated resources. While at it, also add the
> missing mutex_destroy() calls in the error path.
> 
> Cc: stable@vger.kernel.org
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Fixes: 7eba0c7641b0 ("opp: Allow lazy-linking of required-opps")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
> Changes in v2:
> - Call _of_clear_opp_table() as suggested by Viresh
> - Also add missing mutex_destroy() calls in the error path
> - Link to v1: https://lore.kernel.org/r/20230524-opp-lazy-uaf-v1-1-f5f95cb4b6de@kernkonzept.com
> ---
> This fixes the crash I ran into after adding an OPP table with
> both "required-opps" and interconnect paths (opp-peak-kBps).
> ---
>  drivers/opp/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 85cbc8de407c..7046487dc6f4 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1358,7 +1358,10 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
>  	return opp_table;
>  
>  remove_opp_dev:
> +	_of_clear_opp_table(opp_table);
>  	_remove_opp_dev(opp_dev, opp_table);
> +	mutex_destroy(&opp_table->genpd_virt_dev_lock);
> +	mutex_destroy(&opp_table->lock);
>  err:
>  	kfree(opp_table);
>  	return ERR_PTR(ret);
> 

Applied. Thanks.

-- 
viresh
