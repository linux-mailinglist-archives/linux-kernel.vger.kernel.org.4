Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0313D6871C1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 00:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjBAXQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 18:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjBAXQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 18:16:24 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189BA66022
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 15:15:59 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id e6so64968plg.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 15:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qFIM4C5atXHVLvz2rYvQqRO5oe5CXRLVhG4Y2WIPWCM=;
        b=RjcmLjC6j4HJmsqqUj3IYFr3gTER/0CfLHzkonLsmQK4mha5W73Ww6XyvbdwrddbB4
         0LM+zzapKvXidMwOGQyON8IYej0+/VwtcDf1t2JgjGiyrVSBVxTyHZF0iWI0K9Sd8XY7
         JAT9cTSw2zkl/kjrEs5X3pi0sdx9UrfBP656Ari83qUMZb1TQZHK/UNAZ3a11exUpl4T
         deGYYilJ87FlhKHPRYqE8d30GWNP0Z4oX7jh82JnA0Q39No64VrL8LKIbgkJrVDWayFV
         Jo9jg3Gc7SjEzV29RJ56Sqewrz4R9JEFrPdpgDNKihDEsNYtyvojBg8tPHH686h8a5yp
         sIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFIM4C5atXHVLvz2rYvQqRO5oe5CXRLVhG4Y2WIPWCM=;
        b=fjmHrIgK6w+BOdQJSQ45FlVUTiMKMBookrUUbkn+9hW1E2vMQ1siS7ZCccIupDnnzT
         i+/g2yo3Ggb1dqPss2eumVoCfwlf9991df3w0NNUxzGEjwimo5LHByRlbqkrGT3SDjO2
         tLZ+UsR5gkkNPMNkZxkqPofNCZpv0IIuE10Mj1yzA6y6AU8JtmoTrgUZtZ7MObWOJYW1
         uvwJXeoL/TpIc/b9AAdVDv3NwOnKA9MN1CkSx7hmzhiEYxL5t2l9rSkqJHBxT/lflRbc
         gCxDIQiMGWAcn+J0NoRwy0KW+EcbDebnXMqZYMQXlNh8x3EVGHBQWZH2qBoVOVsa50M0
         shjQ==
X-Gm-Message-State: AO0yUKWr8RQk1RFMHjUFXeAbwds8PLSEv72/0o6+gn5touWqYM9wjEbW
        V9G4yTyMnrJW4mYu+9NMLOsF8DbWAWGe4/Dwenk=
X-Google-Smtp-Source: AK7set8zbrNyAs2bnFB+ImWFnRtySQ0uM3iN4+USnPB9165NQN26ofVDH8bHcqrwTbOU4R3vjWaFUQ==
X-Received: by 2002:a05:6a21:6d95:b0:bc:8c5e:ed0d with SMTP id wl21-20020a056a216d9500b000bc8c5eed0dmr5900717pzb.40.1675293278613;
        Wed, 01 Feb 2023 15:14:38 -0800 (PST)
Received: from google.com ([2620:15c:2d1:203:341e:6979:102e:c9d9])
        by smtp.gmail.com with ESMTPSA id o16-20020a656150000000b004db367c10b0sm11066399pgv.46.2023.02.01.15.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 15:14:38 -0800 (PST)
Date:   Wed, 1 Feb 2023 15:14:33 -0800
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Tom Rix <trix@redhat.com>
Cc:     jack@suse.com, nathan@kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] udf: remove reporting loc in debug output
Message-ID: <Y9ryWROdCrKYWBzY@google.com>
References: <20230127162906.872395-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127162906.872395-1-trix@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 08:29:06AM -0800, Tom Rix wrote:
> clang build fails with
> fs/udf/partition.c:86:28: error: variable 'loc' is uninitialized when used here [-Werror,-Wuninitialized]
>                           sb, block, partition, loc, index);
>                                                 ^~~
> 
> loc is now only know when bh is valid.  So remove reporting loc in debug output.

typo: s/know/known/

> 
> Fixes: 4215db46d538 ("udf: Use udf_bread() in udf_get_pblock_virt15()")
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks Tom, kernelci has also been reporting this.
https://lore.kernel.org/linux-next/?q=error%3A+variable+%27loc%27+is+uninitialized+when+used+here

Reported-by: "kernelci.org bot" <bot@kernelci.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  fs/udf/partition.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/udf/partition.c b/fs/udf/partition.c
> index 92765d2f6958..5bcfe78d5cab 100644
> --- a/fs/udf/partition.c
> +++ b/fs/udf/partition.c
> @@ -82,8 +82,8 @@ uint32_t udf_get_pblock_virt15(struct super_block *sb, uint32_t block,
>  
>  	bh = udf_bread(sbi->s_vat_inode, newblock, 0, &err);
>  	if (!bh) {
> -		udf_debug("get_pblock(UDF_VIRTUAL_MAP:%p,%u,%u) VAT: %u[%u]\n",
> -			  sb, block, partition, loc, index);
> +		udf_debug("get_pblock(UDF_VIRTUAL_MAP:%p,%u,%u)\n",
> +			  sb, block, partition);
>  		return 0xFFFFFFFF;
>  	}
>  
> -- 
> 2.26.3
> 
> 
