Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC3270E43D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbjEWRyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjEWRyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:54:31 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC8B119
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:53:25 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-75764d20db3so13823985a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684864405; x=1687456405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXyP48UZlJHqtZCaroxC4ZeuGBPVBmHVxi5WAh4UKYc=;
        b=CWPTrVMToDP83bmibsGYbAPhCuZiQYLMM/lYQ2GZHxson16PCpmkT2gO8qfnxa2rvc
         x9YhcSIVSESdBujpvus+71rNG56nhUyRDBCh8BsXa0NmfoxkDrzUjSBJGFcIcgLEwLh2
         SXq16LNrBn9M7d2zVa9+HD5Gk1BQqDIlkf7+OaiZcjfJhQw4PuvTWZr1YapeclgPQjPH
         Od+DqRDLo+JfLm2ofYuPGjro+QVx9ICIAkx87btcKw9PElya6eW+atoKIqeJ8BuYgEqK
         jxXfXtHtKif6KZ7VbvVRn5LIfc170W3ca1GfpywguAXWMxNWc8K9OaUZkApNcYLFnY1F
         kKxw==
X-Gm-Message-State: AC+VfDzcO0f9Wj4JRht8sgjR/exx4BKxwxVeo2h7WrhCEIc7tiQvgbfK
        CVuUra3AOuJoxs6WsRzBhW1x
X-Google-Smtp-Source: ACHHUZ4rOayS5f+CymY4fSs5G6oZU0RuGq8SeSpkrGKuo6iEZ9yLC1EypwkS+345axZrgh+XPK8abw==
X-Received: by 2002:a05:620a:3f48:b0:75b:23a1:480 with SMTP id ty8-20020a05620a3f4800b0075b23a10480mr4595232qkn.70.1684864405044;
        Tue, 23 May 2023 10:53:25 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id r29-20020a05620a03dd00b007592f2016f4sm2673771qkm.110.2023.05.23.10.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:53:24 -0700 (PDT)
Date:   Tue, 23 May 2023 13:53:23 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     linux-kernel@vger.kernel.org, agk@redhat.com, dm-devel@redhat.com,
        Ignat Korchagin <ignat@cloudflare.com>
Subject: Re: dm crypt: fix sleep-in-atomic-context bug in
 kcryptd_crypt_tasklet
Message-ID: <ZGz9k3jnVqiO20a2@redhat.com>
References: <20230523075857.76520-1-duoming@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523075857.76520-1-duoming@zju.edu.cn>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23 2023 at  3:58P -0400,
Duoming Zhou <duoming@zju.edu.cn> wrote:

> In order to improve the IO performance of the dm-crypt
> implementation, the commit 39d42fa96ba1 ("dm crypt:
> add flags to optionally bypass kcryptd workqueues")
> adds tasklet to do the crypto operations.
> 
> The tasklet callback function kcryptd_crypt_tasklet()
> calls kcryptd_crypt() which is an original workqueue
> callback function that may sleep. As a result, the
> sleep-in-atomic-context bug may happen. The process
> is shown below.
> 
>    (atomic context)
> kcryptd_crypt_tasklet()
>   kcryptd_crypt()
>     kcryptd_crypt_write_convert()
>       wait_for_completion() //may sleep
> 
> The wait_for_completion() is a function that may sleep.
> In order to mitigate the bug, this patch changes
> wait_for_completion() to try_wait_for_completion().
> 
> Fixes: 39d42fa96ba1 ("dm crypt: add flags to optionally bypass kcryptd workqueues")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
>  drivers/md/dm-crypt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index 8b47b913ee8..5e2b2463d87 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -2085,7 +2085,8 @@ static void kcryptd_crypt_write_convert(struct dm_crypt_io *io)
>  	crypt_finished = atomic_dec_and_test(&ctx->cc_pending);
>  	if (!crypt_finished && kcryptd_crypt_write_inline(cc, ctx)) {
>  		/* Wait for completion signaled by kcryptd_async_done() */
> -		wait_for_completion(&ctx->restart);
> +		while (!try_wait_for_completion(&ctx->restart))
> +			;
>  		crypt_finished = 1;
>  	}
>  
> -- 
> 2.17.1
> 

Cc'ing Ignat for closer review.

But wasn't this already addressed with this commit?:
8abec36d1274 dm crypt: do not wait for backlogged crypto request completion in softirq

Mike
