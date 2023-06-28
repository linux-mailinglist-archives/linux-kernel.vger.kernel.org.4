Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C51E7419DA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjF1Uqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjF1Uqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:46:37 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B701FF5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:46:36 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6687096c6ddso173713b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687985196; x=1690577196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kBhJKyD7bJwEozlu6VGmqEJtVOOTdpq3aGqlzavxyb4=;
        b=QWE+loXzU3wKDS8ejmYVrM1fvW7AcQBsWfrRd9M6KnNwMAdJCD0nJim15NjpalqeuR
         5OK2peY57vRnKl4CjQaw5y7uXU6wWWHy4eQazHd839z585RfywUalJZLfWqcVdvb9ITi
         cHBZuj6woWszwebYdkvbTjAjhSOkwRZJ/ItrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687985196; x=1690577196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBhJKyD7bJwEozlu6VGmqEJtVOOTdpq3aGqlzavxyb4=;
        b=kcDiaX4Kf0fF6R+QvoNBBwDNkMgFJu8dY4jHeJdtmAwtOnFwrx51R76EUIorLTCUVE
         9DzpvxGvsIje61yv5NRzLq1hq+Kat3OCYjNzUYZze+zJnmXe9B2xN+YNW6ilgE7H+Cha
         1wyHvswy47EXDvlNdJ3XrPAgC+jg94raPmWvucO6xMif65UYtYnlYSbbUbCchCOZcNEB
         Cg+1j+BD9AHjnkV8LTRbxeJmcTIP+016JGjdrRI/AHla3rhrYgn6acyNDMSDK2HfKxUu
         j3XMuOlaja6/TmoJ6XMGjsYS2nq5q05OJ092fLhYIGS5IVnK1qhQ0jZ9L2vidAod3rUk
         PW0w==
X-Gm-Message-State: AC+VfDxqBO8TA9OwCUBtEFS2E/N7oEOGn1tGemlV6veGOYEl92juWf0y
        X4cYkC5Gqb2q680m7abZDFSzZA==
X-Google-Smtp-Source: ACHHUZ4+7odXJ0w41n+UICBA7a8VNpdAePajhftdeAf+kTzdbAyBRr6TACllyBIVPquapYHBKFcJAA==
X-Received: by 2002:a05:6a00:a29:b0:674:1dde:4c59 with SMTP id p41-20020a056a000a2900b006741dde4c59mr10827321pfh.28.1687985195409;
        Wed, 28 Jun 2023 13:46:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m18-20020aa79012000000b0064d47cd117esm7388086pfo.39.2023.06.28.13.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:46:34 -0700 (PDT)
Date:   Wed, 28 Jun 2023 13:46:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     aacraid@microsemi.com, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 09/10][next] scsi: aacraid: Replace one-element array
 with flexible-array member in struct sgmap64
Message-ID: <202306281344.FA95C5E@keescook>
References: <cover.1687974498.git.gustavoars@kernel.org>
 <169a28c9e45d1f237308b1ca716122c5d0ee3488.1687974498.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169a28c9e45d1f237308b1ca716122c5d0ee3488.1687974498.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:57:30AM -0600, Gustavo A. R. Silva wrote:
> Replace one-element array with flexible-array member in struct
> sgmap64 and refactor the rest of the code, accordingly.
> 
> Issue found with the help of Coccinelle and audited and fixed,
> manually.

Like with the sgmap patch, I see (expected) binary differences in
aac_write_block64() and aac_read_block64() due to the simplified
calculations. I don't see anything unaccounted for, so:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/ClangBuiltLinux/linux/issues/1851
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/scsi/aacraid/aachba.c  | 9 +++------
>  drivers/scsi/aacraid/aacraid.h | 2 +-
>  2 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
> index b2849e5cc104..90df697e7c5f 100644
> --- a/drivers/scsi/aacraid/aachba.c
> +++ b/drivers/scsi/aacraid/aachba.c
> @@ -1301,8 +1301,7 @@ static int aac_read_block64(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u
>  	if (ret < 0)
>  		return ret;
>  	fibsize = sizeof(struct aac_read64) +
> -		((le32_to_cpu(readcmd->sg.count) - 1) *
> -		 sizeof (struct sgentry64));
> +		  le32_to_cpu(readcmd->sg.count) * sizeof(struct sgentry64);
>  	BUG_ON (fibsize > (fib->dev->max_fib_size -
>  				sizeof(struct aac_fibhdr)));
>  	/*
> @@ -1433,8 +1432,7 @@ static int aac_write_block64(struct fib * fib, struct scsi_cmnd * cmd, u64 lba,
>  	if (ret < 0)
>  		return ret;
>  	fibsize = sizeof(struct aac_write64) +
> -		((le32_to_cpu(writecmd->sg.count) - 1) *
> -		 sizeof (struct sgentry64));
> +		  le32_to_cpu(writecmd->sg.count) * sizeof(struct sgentry64);
>  	BUG_ON (fibsize > (fib->dev->max_fib_size -
>  				sizeof(struct aac_fibhdr)));
>  	/*
> @@ -2271,8 +2269,7 @@ int aac_get_adapter_info(struct aac_dev* dev)
>  			dev->scsi_host_ptr->sg_tablesize =
>  				(dev->max_fib_size -
>  				sizeof(struct aac_fibhdr) -
> -				sizeof(struct aac_write64) +
> -				sizeof(struct sgentry64)) /
> +				sizeof(struct aac_write64)) /
>  					sizeof(struct sgentry64);
>  		} else {
>  			dev->a_ops.adapter_read = aac_read_block;
> diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
> index 3fbc22ae72b6..fb3d93e4a99e 100644
> --- a/drivers/scsi/aacraid/aacraid.h
> +++ b/drivers/scsi/aacraid/aacraid.h
> @@ -517,7 +517,7 @@ struct user_sgmap {
>  
>  struct sgmap64 {
>  	__le32		count;
> -	struct sgentry64 sg[1];
> +	struct sgentry64 sg[];
>  };
>  
>  struct user_sgmap64 {
> -- 
> 2.34.1
> 

-- 
Kees Cook
