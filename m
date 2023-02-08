Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8379568E763
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 06:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjBHFMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 00:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBHFMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 00:12:31 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADA840C1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 21:12:30 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id i2so4656457ple.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 21:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ynQKtPREQJX8aXcg8wQwLkU6v0zuOPN0C8VlE9gcTUE=;
        b=KpIPffhcmH9yMYB9yKh+S880iANL1KEZ0VMvMtBnf1BLEb/Z7E2/aa4vK6MoOLSigI
         OUydFCpa7/LkAf4VdZayur5uLSmAMhJ6G7953F6JQnUFYDyFgnQhhBUfTcKQ1CR+ljr5
         YOOyAhs8U+H0LGbixw7NkJR16ZUhvb9CNG23oVYrMrpefTX9bGFsrIy30oyCzLCJp1ij
         r62lWGlhoTMF0rvON3EgNtjvvzh9tQ42Ez/91mY0+5gLBpOTIyWdWprE+Eu+JZ/1xXdc
         7MFTRL4njGxOEnykzRvoVMCFrr5qA9imjzJ5pPo01G+uv4UiGFS66KjUGJV/bLpNf5TS
         G2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynQKtPREQJX8aXcg8wQwLkU6v0zuOPN0C8VlE9gcTUE=;
        b=5fxmR4TqajplWoIfrqxZl2f1rOFvvSRi6Hv8byclBHrgD2idyOdHElRwcFME9c7ca6
         vVdr0nFG2gBj7ZTYRdXpTRlA37vGjEs4qhCcVnM4dJJWx8CGsdqEou+FHs+3wDJ+eqvX
         YR5EO6vz3McWBNY9GL5GekQER7vGgedpuZoAqSh21iJh09rZrERqqSCctKqVQduVWoNH
         5dprGb+yyLzQjJtOG8UUp81jo0dYDHvzx6r275yK2U+NWOCEI9R5gDA03fWelBxOf8Nl
         xOBiptZXxyRnZXWAgDi85l96UgH8HqjpZA8vd2vIZylv44t+WJwe870VfQuvpKtZOW42
         GFGA==
X-Gm-Message-State: AO0yUKVPiv+W6YTraFYOcPJrJRd+MkdgZDp/dbFXhfYpg7WLhpBC9XUw
        Sbc7cTMM980SGpYIy+aoyaSB0DFaJVSSZU8z
X-Google-Smtp-Source: AK7set+9KEkWwJa8xzGCAGXhFRxnb3x48Rg0TiPn2cYSFGv0Cgczz4t0se49tq1Sl8p54cAeBcOwGw==
X-Received: by 2002:a17:90a:11:b0:230:fac8:d7e7 with SMTP id 17-20020a17090a001100b00230fac8d7e7mr3960827pja.2.1675833149229;
        Tue, 07 Feb 2023 21:12:29 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id s4-20020a17090a764400b0022941908b80sm465351pjl.47.2023.02.07.21.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 21:12:28 -0800 (PST)
Date:   Wed, 8 Feb 2023 10:42:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        gregkh@linuxfoundation.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] PM/OPP: fix error checking in opp_migrate_dentry()
Message-ID: <20230208051226.2lp736c67fem35ex@vireshk-i7>
References: <20230208040037.60305-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208040037.60305-1-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-02-23, 12:00, Qi Zheng wrote:
> Since commit ff9fb72bc077 ("debugfs: return error values,
> not NULL") changed return value of debugfs_rename() in
> error cases from %NULL to %ERR_PTR(-ERROR), we should
> also check error values instead of NULL.
> 
> Fixes: ff9fb72bc077 ("debugfs: return error values, not NULL")
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
> Resend as a separate patch.
> 
>  drivers/opp/debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
> index 96a30a032c5f..2c7fb683441e 100644
> --- a/drivers/opp/debugfs.c
> +++ b/drivers/opp/debugfs.c
> @@ -235,7 +235,7 @@ static void opp_migrate_dentry(struct opp_device *opp_dev,
>  
>  	dentry = debugfs_rename(rootdir, opp_dev->dentry, rootdir,
>  				opp_table->dentry_name);
> -	if (!dentry) {
> +	if (IS_ERR(dentry)) {
>  		dev_err(dev, "%s: Failed to rename link from: %s to %s\n",
>  			__func__, dev_name(opp_dev->dev), dev_name(dev));
>  		return;

Applied. Thanks.

-- 
viresh
