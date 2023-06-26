Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700AF73D596
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 03:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjFZBr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 21:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFZBrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 21:47:53 -0400
Received: from out-2.mta1.migadu.com (out-2.mta1.migadu.com [IPv6:2001:41d0:203:375::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC438180
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 18:47:51 -0700 (PDT)
Message-ID: <773de46a-fef9-54de-75fd-c1c6a97326f5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687744070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FJB0VvYTG87mr/6bxPUvLxNLcEpmxlf6gbHI8JQXnfs=;
        b=VQ5ezXEtUt4R46BXdIsW7fAw+CES0LSozNr+bFqZgVxzFL2v9yzVmKHPlzw1ePKfZtWZxE
        6MgHsQidycItFOp5rWmq+yWzbO5r63wLI4c79AUYekYuoQXqYq+aiv4kG7YBQ+hweDInFq
        JGcQkvB3uUNFHDD0bK0tFgJ9Po8UPQM=
Date:   Mon, 26 Jun 2023 09:47:42 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] binder: fix memory leak in binder_init()
Content-Language: en-US
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
        cmllamas@google.com, surenb@google.com
Cc:     linux-kernel@vger.kernel.org
References: <20230625154937.64316-1-qi.zheng@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20230625154937.64316-1-qi.zheng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/25 23:49, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> In binder_init(), the destruction of binder_alloc_shrinker_init() is not
> performed in the wrong path, which will cause memory leaks. So this commit
> introduces binder_alloc_shrinker_exit() and calls it in the wrong path to
> fix that.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Oh, I forgot to add Fixes tag:

Fixes: f2517eb76f1f ("android: binder: Add global lru shrinker to binder")

> ---
>   drivers/android/binder.c       | 1 +
>   drivers/android/binder_alloc.c | 6 ++++++
>   drivers/android/binder_alloc.h | 1 +
>   3 files changed, 8 insertions(+)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 486c8271cab7..d720f93d8b19 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -6617,6 +6617,7 @@ static int __init binder_init(void)
>   
>   err_alloc_device_names_failed:
>   	debugfs_remove_recursive(binder_debugfs_dir_entry_root);
> +	binder_alloc_shrinker_exit();
>   
>   	return ret;
>   }
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 662a2a2e2e84..e3db8297095a 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -1087,6 +1087,12 @@ int binder_alloc_shrinker_init(void)
>   	return ret;
>   }
>   
> +void binder_alloc_shrinker_exit(void)
> +{
> +	unregister_shrinker(&binder_shrinker);
> +	list_lru_destroy(&binder_alloc_lru);
> +}
> +
>   /**
>    * check_buffer() - verify that buffer/offset is safe to access
>    * @alloc: binder_alloc for this proc
> diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
> index 138d1d5af9ce..dc1e2b01dd64 100644
> --- a/drivers/android/binder_alloc.h
> +++ b/drivers/android/binder_alloc.h
> @@ -129,6 +129,7 @@ extern struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
>   						  int pid);
>   extern void binder_alloc_init(struct binder_alloc *alloc);
>   extern int binder_alloc_shrinker_init(void);
> +extern void binder_alloc_shrinker_exit(void);
>   extern void binder_alloc_vma_close(struct binder_alloc *alloc);
>   extern struct binder_buffer *
>   binder_alloc_prepare_to_free(struct binder_alloc *alloc,
