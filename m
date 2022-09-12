Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37325B5742
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 11:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiILJhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 05:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiILJhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:37:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1370133375
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:37:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2D4061165
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 09:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA055C433D6;
        Mon, 12 Sep 2022 09:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662975454;
        bh=RfElTGrIzepVBlXKvZQanWRb9Oy61jya/t8G4QYxjFc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JW87ZC2uS0wan2k4C7RJ03kZs4WErxiO50f211CKh5AqIEZyZaXkODwSEY05/eHd8
         y0kVfXQKoeX+Rk7+Wj6i+ZMJjAcnqbcmAQjy1elVvUfu5g49UZ2IdY2AuYB/nceeXb
         eihaEyLTIu7MMWe1plq1PN0IFRC9gqCPnEu6s2NDAbMQ72kztb4CUKwvGkVOqNwAE/
         zPWZkrIApheJW0vYi9/tY5vu3PZ3mqXpQrquAOKxqhhnARoWENrUIJogc+c3HqmAcQ
         BlDXTsaxFFISAVxrsSAdDjsNuX08dGTTBQ4IQMFSWwWlVFrypfOcbjeRX2JXHIAOhg
         Y2/Qg5z6fzzMQ==
Date:   Mon, 12 Sep 2022 18:37:30 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <mhiramat@kernel.org>,
        <ast@kernel.org>, <jbacik@fb.com>, <akpm@linux-foundation.org>
Subject: Re: [PATCH -next 2/3] fail_function: refctor code of checking
 return value of register_kprobe()
Message-Id: <20220912183730.5890cbbc5c062145c07a577a@kernel.org>
In-Reply-To: <20220826073337.2085798-2-yangyingliang@huawei.com>
References: <20220826073337.2085798-1-yangyingliang@huawei.com>
        <20220826073337.2085798-2-yangyingliang@huawei.com>
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

On Fri, 26 Aug 2022 15:33:36 +0800
Yang Yingliang <yangyingliang@huawei.com> wrote:

> Refactor the error handling of register_kprobe() to improve readability.
> No functional change.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

OK, but in this case, could you fold [2/3] and [3/3], because
[3/3] can not be applied without this change.

Thank you,

> ---
>  kernel/fail_function.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/fail_function.c b/kernel/fail_function.c
> index 03643e33e4c3..893e8f9a9118 100644
> --- a/kernel/fail_function.c
> +++ b/kernel/fail_function.c
> @@ -294,14 +294,13 @@ static ssize_t fei_write(struct file *file, const char __user *buffer,
>  	}
>  
>  	ret = register_kprobe(&attr->kp);
> -	if (!ret)
> -		fei_debugfs_add_attr(attr);
> -	if (ret < 0)
> +	if (ret) {
>  		fei_attr_remove(attr);
> -	else {
> -		list_add_tail(&attr->list, &fei_attr_list);
> -		ret = count;
> +		goto out;
>  	}
> +	fei_debugfs_add_attr(attr);
> +	list_add_tail(&attr->list, &fei_attr_list);
> +	ret = count;
>  out:
>  	mutex_unlock(&fei_lock);
>  	kfree(buf);
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
