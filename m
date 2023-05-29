Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D8F7143C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 07:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjE2Fb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 01:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjE2Fbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 01:31:53 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71E79F
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 22:31:51 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2566f66190dso833898a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 22:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685338311; x=1687930311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4PPFonEhDSP8gLC8BJ9+HvAE9BMM5+O6SrwzMbFYDbw=;
        b=BG77cKFMbbtQaVW0nAg4Je7YFmXgzvHOgK0j+KCXw29PFYAmJJCClKwElyG2QDtgW0
         IqWnO8Qd1fWmnmai4QNC9kdM8u8hyiDgc8LpViVOdJNJ7fqkQr4nihvCg2bXMJhjxXj3
         GkmEhrAeGEk4NKiPoGU/u1v5yQwYSvTKyXu+bWZMsUhZGF0lenQNQOXd0miF/tZ1ARFT
         /hjWJ3DS/GInl5x0J45EWJKkUas3C/LusjyxjbKJoAbaKh3tXNWNlOqxUM+WGFqCUl6Y
         vQD+KVKgNFoqeohnFPoR9K/899TK9Oy4ba7pfHa8fMVD8ThJAbc3RKpbSJjpSpImgAxS
         y6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685338311; x=1687930311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PPFonEhDSP8gLC8BJ9+HvAE9BMM5+O6SrwzMbFYDbw=;
        b=O9uqTCZBzpS8bqheMPNj1Cq7WXx7D8+lyT2rVBY+H9OtdnCLZNPT6taPcOAg2Xbpd/
         UvtxmKB+gE+pmmdK/wvaPvtsDj27iIujluq7QWC/Wg95zVF4y0rjMmc7K7xPxNnshcog
         Dgl9ShrwTxlOKGmlrW73nyAiU+CLAoAtaG6NF9wJios77YZ7SV9o2MLD1WhrbVGJSIRx
         sS9flDDdC5TTT7G/xwr7bjFtW0NshZRwX1o/wraMA4tLLny4Fmgu02Yfx7pCQwOnt9Yv
         stBoodu+Rbh42ZlZc7Pp/mMAeIddV3ZEx7LGYxuXV4SOneER4/3zfnqm/NYxaSJRe9m0
         hlxA==
X-Gm-Message-State: AC+VfDwVb3ne0ChDN9jPu7Njc7qXQXmkDxRnP9sL7bu7MQ9AVdqWrF1U
        5gTbZzlIKTq4iJPpsZeEwFSHTg==
X-Google-Smtp-Source: ACHHUZ492JkVbVMwadub6cNpLxDqf+cAwCg3OJlG0pA62Sl8NKCneXD5hDVRh6c/f0Wz+bvK9B+7DQ==
X-Received: by 2002:a17:903:2093:b0:1b0:4c32:5d6d with SMTP id d19-20020a170903209300b001b04c325d6dmr56502plc.31.1685338311173;
        Sun, 28 May 2023 22:31:51 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001b0395c4002sm1941527plb.210.2023.05.28.22.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 22:31:50 -0700 (PDT)
Date:   Mon, 29 May 2023 11:01:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] opp: Fix use-after-free in lazy_opp_tables after probe
 deferral
Message-ID: <20230529053148.xuhuv6skg2xqworr@vireshk-i7>
References: <20230524-opp-lazy-uaf-v1-1-f5f95cb4b6de@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524-opp-lazy-uaf-v1-1-f5f95cb4b6de@kernkonzept.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-05-23, 19:56, Stephan Gerhold wrote:
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
> Fix this by removing the opp_table from the list before freeing it.

I think you need this instead:

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 954c94865cf5..b5973fefdfd8 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1358,7 +1358,10 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
        return opp_table;

 remove_opp_dev:
+       _of_clear_opp_table(opp_table);
        _remove_opp_dev(opp_dev, opp_table);
+       mutex_destroy(&opp_table->genpd_virt_dev_lock);
+       mutex_destroy(&opp_table->lock);
 err:
        kfree(opp_table);
        return ERR_PTR(ret);

> Cc: stable@vger.kernel.org
> Fixes: 7eba0c7641b0 ("opp: Allow lazy-linking of required-opps")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
> This fixes the crash I ran into after adding an OPP table with
> both "required-opps" and interconnect paths (opp-peak-kBps).
> 
> By the way, the "lazy_opp_tables" does not seem to be protected by any
> locks(?)

It is always accessed with opp_table_lock held I believe.

-- 
viresh
