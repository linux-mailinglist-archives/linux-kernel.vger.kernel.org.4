Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95ECC5B5743
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 11:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiILJhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 05:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiILJho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:37:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D99C33424
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:37:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF508B80CB1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 09:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D5AC433C1;
        Mon, 12 Sep 2022 09:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662975461;
        bh=ZBK94GwuhHbhnlhH6vqruiwddwOomQwn8zcU/NC8z5E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U9/W5iSdh6HqKSfsgz3rHgRpY/SebSalETpBzG+9Di0chPjopPYQ238sixzmdX2Kv
         t9FPhz+dFws83FgQb8xdbXgkE7t0NYLbAqepijlni8QPYeVa2b8FOOFx0/SU+njrB2
         f58Cslt8CX1ivJJcu/OXN0rM3AnI6gbj2eB2ZeNI+1fYIFMV16uBhMneUM/NToZTrm
         KxJSwe7a7kUMdVoRQnl9YfRqwgu/Xmsh4QNjnMfrk7gRqacPUEY0yLKrGNYKxj8GSp
         9+bev2Pw2MYgjUhXCg9JtSp0TA9gqsKmEJ3iYTpozogZKLvOESNcEBdcbZ9S6qLtUi
         SVybmtuqa6Odw==
Date:   Mon, 12 Sep 2022 18:37:38 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <mhiramat@kernel.org>,
        <ast@kernel.org>, <jbacik@fb.com>, <akpm@linux-foundation.org>
Subject: Re: [PATCH -next 1/3] fail_function: Switch to memdup_user_nul()
 helper
Message-Id: <20220912183738.d86c72c87197cfc8dd377d49@kernel.org>
In-Reply-To: <20220826073337.2085798-1-yangyingliang@huawei.com>
References: <20220826073337.2085798-1-yangyingliang@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2022 15:33:35 +0800
Yang Yingliang <yangyingliang@huawei.com> wrote:

> Use memdup_user_nul() helper instead of open-coding to
> simplify the code.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> ---
>  kernel/fail_function.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/fail_function.c b/kernel/fail_function.c
> index 60dc825ecc2b..03643e33e4c3 100644
> --- a/kernel/fail_function.c
> +++ b/kernel/fail_function.c
> @@ -247,15 +247,11 @@ static ssize_t fei_write(struct file *file, const char __user *buffer,
>  	/* cut off if it is too long */
>  	if (count > KSYM_NAME_LEN)
>  		count = KSYM_NAME_LEN;
> -	buf = kmalloc(count + 1, GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
>  
> -	if (copy_from_user(buf, buffer, count)) {
> -		ret = -EFAULT;
> -		goto out_free;
> -	}
> -	buf[count] = '\0';
> +	buf = memdup_user_nul(buffer, count);
> +	if (IS_ERR(buf))
> +		return PTR_ERR(buf);
> +
>  	sym = strstrip(buf);
>  
>  	mutex_lock(&fei_lock);
> @@ -308,7 +304,6 @@ static ssize_t fei_write(struct file *file, const char __user *buffer,
>  	}
>  out:
>  	mutex_unlock(&fei_lock);
> -out_free:
>  	kfree(buf);
>  	return ret;
>  }
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
