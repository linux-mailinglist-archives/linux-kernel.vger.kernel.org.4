Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE124705942
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 23:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjEPVEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 17:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjEPVEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 17:04:22 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9F66EB6
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:04:21 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-52079a12451so10560941a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684271061; x=1686863061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R93tkvEtSyz3YtU78eyvXjYmdxsbp4hYMRMbW122LIs=;
        b=LJRQ4P+tMZI+1x+Z70dKKlTd5/8Aq1heFXHpQ9DDsqCwSwijDgYXhDpd/Hnq9Px+Cp
         1gukiwIWQrzO3krbhVpyh2ateBJGiYyO47XLaJg6yvfWrFzbCECrTcscfu82p5rth5RF
         LLbuieiU3yBjrrVqDSDPdLRwOjThGvWB/ioDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684271061; x=1686863061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R93tkvEtSyz3YtU78eyvXjYmdxsbp4hYMRMbW122LIs=;
        b=gsDf1cWjXvKLQnxAmh4dYo/3qQPYJ0czBxehGlbjLBOMswwsH6/s7rLnzlolanZzzS
         TOx0nzEGAA3yvRB9yt+ytqy2b+wqCoWUIADnF+ZxlZq97/XoCcdc46N4n4tJ/nqrexx0
         qK5jKnfdI57qG8noenrB3yRiYHdQsMIGMk7oUQPLpckWicddV42SOFgw6NALCGRQfSXV
         TEUK5aJsI/FFhWwHQVAIzqQDPzTZiLHm1NeOSc+RQ2lvlfIricImeTgzkR4mMWZsYVUE
         6F23ZIpW+gWcwLfQX6PHU+cuba0ZY1iRz+UYr6kF+psS2boELZqkw3b7lTTk/NYb7Udg
         T6fw==
X-Gm-Message-State: AC+VfDxGBLVWp9FUnjXJ3CdyHKZi9nbdBIKYibsC3yJHWCn+lsHFcbMX
        EkcLk/YjEL/RbB5ud+xPIICJVg==
X-Google-Smtp-Source: ACHHUZ4alEuWp0NXjdyHu1loTFOOF5uR6wg79aQJ2l0c/X9gDIxEXdyAfsA9hlCGkAUd5BC8oyzFSQ==
X-Received: by 2002:a05:6a20:9184:b0:100:d4ee:ba80 with SMTP id v4-20020a056a20918400b00100d4eeba80mr29398227pzd.27.1684271061239;
        Tue, 16 May 2023 14:04:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a4-20020a62bd04000000b0063d47bfcdd5sm13860888pff.111.2023.05.16.14.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 14:04:20 -0700 (PDT)
Date:   Tue, 16 May 2023 14:04:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        linux-hardening@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NFS: Prefer strscpy over strlcpy calls
Message-ID: <202305161403.15ED4EC@keescook>
References: <20230512155749.1356958-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512155749.1356958-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 03:57:49PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> Check for strscpy()'s return value of -E2BIG on truncate for safe
> replacement with strlcpy().
> 
> This is part of a tree-wide cleanup to remove the strlcpy() function
> entirely from the kernel [2].
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
> Note to reviewers: the one case where this patch would modify existing behavior
> is when strlen(src)==destlen==0. Current behavior returns 0, with this patch it
> would return -1.
> 
> Not sure what the implication of this updated behavior would be,
> so bringing it to your attention.

I'm not sure either, but I would prefer non-terminated strings produce
an error, which this change does. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
>  fs/nfs/nfsroot.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/nfsroot.c b/fs/nfs/nfsroot.c
> index 620329b7e6ae..7600100ba26f 100644
> --- a/fs/nfs/nfsroot.c
> +++ b/fs/nfs/nfsroot.c
> @@ -164,7 +164,7 @@ __setup("nfsroot=", nfs_root_setup);
>  static int __init root_nfs_copy(char *dest, const char *src,
>  				     const size_t destlen)
>  {
> -	if (strlcpy(dest, src, destlen) > destlen)
> +	if (strscpy(dest, src, destlen) == -E2BIG)
>  		return -1;
>  	return 0;
>  }
> -- 
> 2.40.1.606.ga4b1b128d6-goog
> 
> 

-- 
Kees Cook
