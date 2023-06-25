Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900B273D20A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjFYQQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjFYQQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:16:35 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDEF193
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:16:33 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666ecf9a0ceso1090569b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687709793; x=1690301793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JFLugxsktEUk30I/si+Vh7SSN9mbnWpk0wcoJLvWRbg=;
        b=o+gQCD0IFZimetDkGfUumIUgvjQDJeczwryuDzZTdLj/cEc2wchP6dFeh7DcUtX8og
         9KTP/LUIXHhy6G22l1GDA4S+omumyn4ZXjN3aXru8ors3Mo79yrEPtyG5UPT/Y3bA3U3
         vZD1m3ktvPrFixuzM3M5vLu4XvrVMndO655xO/t5pe/VoklkmDTLZwtN8kUCOZhjfmQD
         +sgPH7CEarLJzQKQS38Lqs0+yyyXmsqJIxbHi78SsNcks2nmq6GNu+1Pg3AusemPoC3B
         CLHC5eLtiIfgvtbqbKOSOwuVvnQTr5Z68f3p3dlvulOJRfC51rUndELnT0axw2Mtyo93
         K26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687709793; x=1690301793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFLugxsktEUk30I/si+Vh7SSN9mbnWpk0wcoJLvWRbg=;
        b=jbiyxCbAID6Qwx5zTgIQm9aeex5EOQNmnOFETpXcGaRTWRAIyd/InHVJnqmXwVqotK
         wU2b1ewCA1Ae4vck6uUVnMcEKSa32BwQrkwzN9pplJgaEeihplCDcQsQ9XGb7KLiPHpY
         5QHVwwm6A260ZpnDCt0Kzs7Qz5OTql6MFzFG67zesM2K1VLkR9GLlrAuVrOfwKe1F/ww
         AhFOaL6l4rB+AuoZ/YbZuHuVMwznNuUh9Er0CTD5No/EamyT1y5x6J/1ltkWFfyJ3fKU
         rWUn+WMcuIkb2chhgBSuPWdhO/HHKfVCLISxADLBPFO6jiWANzWmdF3SSax4vLDfxeuv
         +XPw==
X-Gm-Message-State: AC+VfDx4Rq0NgO5cbIkKhKmf9jXIybO0DSybAkjvIMVsQ3PgDHy8Y9ZT
        ljPId7LSLtXhFG1fOAqBGlKoog==
X-Google-Smtp-Source: ACHHUZ4wXGSRphScZBpXuMnM1lWA/TjdJeU+XTxpWZDlXsyVAtX1eQZsLQja5ye7+7P9M+k1Dlzb9A==
X-Received: by 2002:a05:6a00:3a10:b0:668:8596:7524 with SMTP id fj16-20020a056a003a1000b0066885967524mr17673313pfb.20.1687709793248;
        Sun, 25 Jun 2023 09:16:33 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f4-20020aa78b04000000b0066884d4efdbsm2503440pfd.12.2023.06.25.09.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 09:16:32 -0700 (PDT)
Date:   Sun, 25 Jun 2023 16:16:28 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Qi Zheng <qi.zheng@linux.dev>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
        surenb@google.com, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH] binder: fix memory leak in binder_init()
Message-ID: <ZJhoXDpX0tOWI01M@google.com>
References: <20230625154937.64316-1-qi.zheng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625154937.64316-1-qi.zheng@linux.dev>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 03:49:37PM +0000, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> In binder_init(), the destruction of binder_alloc_shrinker_init() is not
> performed in the wrong path, which will cause memory leaks. So this commit
> introduces binder_alloc_shrinker_exit() and calls it in the wrong path to
> fix that.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  drivers/android/binder.c       | 1 +
>  drivers/android/binder_alloc.c | 6 ++++++
>  drivers/android/binder_alloc.h | 1 +
>  3 files changed, 8 insertions(+)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 486c8271cab7..d720f93d8b19 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -6617,6 +6617,7 @@ static int __init binder_init(void)
>  
>  err_alloc_device_names_failed:
>  	debugfs_remove_recursive(binder_debugfs_dir_entry_root);
> +	binder_alloc_shrinker_exit();
>  
>  	return ret;
>  }
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 662a2a2e2e84..e3db8297095a 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -1087,6 +1087,12 @@ int binder_alloc_shrinker_init(void)
>  	return ret;
>  }
>  
> +void binder_alloc_shrinker_exit(void)
> +{
> +	unregister_shrinker(&binder_shrinker);
> +	list_lru_destroy(&binder_alloc_lru);
> +}
> +
>  /**
>   * check_buffer() - verify that buffer/offset is safe to access
>   * @alloc: binder_alloc for this proc
> diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
> index 138d1d5af9ce..dc1e2b01dd64 100644
> --- a/drivers/android/binder_alloc.h
> +++ b/drivers/android/binder_alloc.h
> @@ -129,6 +129,7 @@ extern struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
>  						  int pid);
>  extern void binder_alloc_init(struct binder_alloc *alloc);
>  extern int binder_alloc_shrinker_init(void);
> +extern void binder_alloc_shrinker_exit(void);
>  extern void binder_alloc_vma_close(struct binder_alloc *alloc);
>  extern struct binder_buffer *
>  binder_alloc_prepare_to_free(struct binder_alloc *alloc,
> -- 
> 2.30.2
> 

Thanks for the fix Qi Zheng.

Acked-by: Carlos Llamas <cmllamas@google.com>
