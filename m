Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17E96A62E4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjB1Wz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjB1Wz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:55:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A573644D;
        Tue, 28 Feb 2023 14:55:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26F93B80DD0;
        Tue, 28 Feb 2023 22:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C4AC433EF;
        Tue, 28 Feb 2023 22:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677624922;
        bh=+J5dybGf17o0wN1DobraFoU++9dN2UmIDOv7C6NV+aY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=flY9czc83DDmsYRvRyj51brgCuz5OJjlqkhHd0hsIlK6K3kXg87uM7mxJ/ZuSR3Yx
         qb6YM6EZrUP/K5mmcvBPUwyemrINyRtFXAEYksIzSZ0DrQUpwEtQVezhM6ks1ik5HM
         Yz5i0sRFKOn8KZEDbHawnJKPMgfZBDAwVpxJbkgQAs0ZZfnlpSeOToE5tqr7qLlpmz
         D7aoDtWPHl5YTPDjdLL8Qzvghs1SiJl2agfe3ieL3K2+ELIosk7nxGaorq5GGce8RK
         lzOJh/k0KgYzcVFjO2Rz6pph1MdDZzsZlnOTEPoIHGxcf2xE0BsGNckfkGvUI2erdy
         +0NBRFAJszaKg==
Date:   Wed, 1 Mar 2023 07:55:19 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 1/3] ring_buffer: Change some static functions to void
Message-Id: <20230301075519.dbf770fed0476e2b6ecdad37@kernel.org>
In-Reply-To: <20230228175929.7534-2-ubizjak@gmail.com>
References: <20230228175929.7534-1-ubizjak@gmail.com>
        <20230228175929.7534-2-ubizjak@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023 18:59:27 +0100
Uros Bizjak <ubizjak@gmail.com> wrote:

> The results of some static functions are not used. Change the
> type of these function to void and remove unnecessary returns.
> 
> No functional change intended.

NAK, instead of dropping the errors, please handle it on the caller side.

Thank you,

> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
>  kernel/trace/ring_buffer.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index af50d931b020..05fdc92554df 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1569,15 +1569,12 @@ static void rb_tail_page_update(struct ring_buffer_per_cpu *cpu_buffer,
>  	}
>  }
>  
> -static int rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
> +static void rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
>  			  struct buffer_page *bpage)
>  {
>  	unsigned long val = (unsigned long)bpage;
>  
> -	if (RB_WARN_ON(cpu_buffer, val & RB_FLAG_MASK))
> -		return 1;
> -
> -	return 0;
> +	RB_WARN_ON(cpu_buffer, val & RB_FLAG_MASK);
>  }
>  
>  /**
> @@ -1587,30 +1584,28 @@ static int rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
>   * As a safety measure we check to make sure the data pages have not
>   * been corrupted.
>   */
> -static int rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
> +static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
>  {
>  	struct list_head *head = rb_list_head(cpu_buffer->pages);
>  	struct list_head *tmp;
>  
>  	if (RB_WARN_ON(cpu_buffer,
>  			rb_list_head(rb_list_head(head->next)->prev) != head))
> -		return -1;
> +		return;
>  
>  	if (RB_WARN_ON(cpu_buffer,
>  			rb_list_head(rb_list_head(head->prev)->next) != head))
> -		return -1;
> +		return;
>  
>  	for (tmp = rb_list_head(head->next); tmp != head; tmp = rb_list_head(tmp->next)) {
>  		if (RB_WARN_ON(cpu_buffer,
>  				rb_list_head(rb_list_head(tmp->next)->prev) != tmp))
> -			return -1;
> +			return;
>  
>  		if (RB_WARN_ON(cpu_buffer,
>  				rb_list_head(rb_list_head(tmp->prev)->next) != tmp))
> -			return -1;
> +			return;
>  	}
> -
> -	return 0;
>  }
>  
>  static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
> @@ -4500,7 +4495,6 @@ rb_update_read_stamp(struct ring_buffer_per_cpu *cpu_buffer,
>  	default:
>  		RB_WARN_ON(cpu_buffer, 1);
>  	}
> -	return;
>  }
>  
>  static void
> @@ -4531,7 +4525,6 @@ rb_update_iter_read_stamp(struct ring_buffer_iter *iter,
>  	default:
>  		RB_WARN_ON(iter->cpu_buffer, 1);
>  	}
> -	return;
>  }
>  
>  static struct buffer_page *
> @@ -4946,7 +4939,6 @@ rb_reader_unlock(struct ring_buffer_per_cpu *cpu_buffer, bool locked)
>  {
>  	if (likely(locked))
>  		raw_spin_unlock(&cpu_buffer->reader_lock);
> -	return;
>  }
>  
>  /**
> -- 
> 2.39.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
