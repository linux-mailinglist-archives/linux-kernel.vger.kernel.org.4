Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864FA73A96A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjFVUUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjFVUUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:20:47 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 490511BFE;
        Thu, 22 Jun 2023 13:20:46 -0700 (PDT)
Received: from CPC-beaub-VBQ1L.localdomain (unknown [4.155.48.114])
        by linux.microsoft.com (Postfix) with ESMTPSA id C88CF21C20AC;
        Thu, 22 Jun 2023 13:20:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C88CF21C20AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1687465245;
        bh=RAT0iDUtzjz+5JfOsFH9SpTpq7B5LHWBm6Sv3uMm9Ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PKN5ftEARR7Gra+CFHm7hKYRp+c569viadSpxfcuF2PLEZTxh5xzgn4zp5ap4kzcM
         l78ojKEfNTv165OE+6c5JzLMQg25sh+a2t7OT4TpUfWNcZSenf8fuAhkJdzq6crL+f
         cqb/rZW5GASX1DmHb9mz4P9/7fIRIrH2nJyW1unY=
Date:   Thu, 22 Jun 2023 20:20:40 +0000
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     sunliming <sunliming@kylinos.cn>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, kelulanainsley@gmail.com,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] tracing/user_events: Fix incorrect return value
 for writing operation when events are disable
Message-ID: <ZJStGAVk3fZaAoug@CPC-beaub-VBQ1L.localdomain>
References: <20230621060827.151564-1-sunliming@kylinos.cn>
 <20230621060827.151564-2-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621060827.151564-2-sunliming@kylinos.cn>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 02:08:24PM +0800, sunliming wrote:
> The writing operation return the count of writes regardless of whether events
> are enabled or disabled. Switch it to return 0 to indicates that the event
> is disabled.
> 
> Signed-off-by: sunliming <sunliming@kylinos.cn>

This looks good to me.

Acked-by: Beau Belgrave <beaub@linux.microsoft.com>

Thanks!

> ---
>  kernel/trace/trace_events_user.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 1ac5ba5685ed..c085ff829a58 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -1957,7 +1957,8 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
>  
>  		if (unlikely(faulted))
>  			return -EFAULT;
> -	}
> +	} else
> +		return 0;
>  
>  	return ret;
>  }
> -- 
> 2.25.1
