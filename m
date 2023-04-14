Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3436E1E77
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjDNIg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjDNIgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:36:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A183769C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:36:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 47AA31FD96;
        Fri, 14 Apr 2023 08:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681461402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mNJXEbFiQYimFkUe6l73eB15mp/nc5vAoZyxEYtJXxg=;
        b=TKKxAlVkNaXR7NkkR8Fj56DducMkUOTUuBUrkCBK9p79psk44NxsdCrCg+bVFDpIhJ11iB
        KG6ayRSTS538kppxoWpUEYjDQbXHI0SCd1ui4OtCJUSQWI9IRwMs5DyQt4UQv7xpGzBpnT
        tLNpSv91LpuadgJSXMeDZ/6VrvKVDEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681461402;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mNJXEbFiQYimFkUe6l73eB15mp/nc5vAoZyxEYtJXxg=;
        b=qV8VPETPh+Uah2LM6+s3qSEgZl8KsAMI6jIMBB+3LFbQkexbYzPj1X6nv0EXwJMxRX3n29
        UZAHPQ+ERXcH8UAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3091B139FC;
        Fri, 14 Apr 2023 08:36:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BrZ2C5oQOWQTbgAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 14 Apr 2023 08:36:42 +0000
Message-ID: <94d6a76c-8ad1-bda1-6336-e9f5fa3a6168@suse.de>
Date:   Fri, 14 Apr 2023 10:36:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] nvme/tcp: Add support to set the tcp worker cpu
 affinity
To:     Li Feng <fengli@smartx.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     lifeng1519@gmail.com
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413132941.2489795-1-fengli@smartx.com>
Content-Language: en-US
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230413132941.2489795-1-fengli@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/23 15:29, Li Feng wrote:
> The default worker affinity policy is using all online cpus, e.g. from 0
> to N-1. However, some cpus are busy for other jobs, then the nvme-tcp will
> have a bad performance.
> 
> This patch adds a module parameter to set the cpu affinity for the nvme-tcp
> socket worker threads.  The parameter is a comma separated list of CPU
> numbers.  The list is parsed and the resulting cpumask is used to set the
> affinity of the socket worker threads.  If the list is empty or the
> parsing fails, the default affinity is used.
> 
> Signed-off-by: Li Feng <fengli@smartx.com>
> ---
> 
> V2 - Fix missing static reported by lkp
> 
>   drivers/nvme/host/tcp.c | 54 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 49c9e7bc9116..47748de5159b 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -31,6 +31,18 @@ static int so_priority;
>   module_param(so_priority, int, 0644);
>   MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
>   
> +/* Support for specifying the CPU affinity for the nvme-tcp socket worker
> + * threads.  This is a comma separated list of CPU numbers.  The list is
> + * parsed and the resulting cpumask is used to set the affinity of the
> + * socket worker threads.  If the list is empty or the parsing fails, the
> + * default affinity is used.
> + */
> +static char *cpu_affinity_list;
> +module_param(cpu_affinity_list, charp, 0644);
> +MODULE_PARM_DESC(cpu_affinity_list, "nvme tcp socket worker cpu affinity list");
> +
> +static struct cpumask cpu_affinity_mask;
> +
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   /* lockdep can detect a circular dependency of the form
>    *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
> @@ -1483,6 +1495,41 @@ static bool nvme_tcp_poll_queue(struct nvme_tcp_queue *queue)
>   			  ctrl->io_queues[HCTX_TYPE_POLL];
>   }
>   
> +static ssize_t update_cpu_affinity(const char *buf)
> +{
> +	cpumask_var_t new_value;
> +	cpumask_var_t dst_value;
> +	int err = 0;
> +
> +	if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	err = bitmap_parselist(buf, cpumask_bits(new_value), nr_cpumask_bits);
> +	if (err)
> +		goto free_new_cpumask;
> +
> +	if (!zalloc_cpumask_var(&dst_value, GFP_KERNEL)) {
> +		err = -ENOMEM;
> +		goto free_new_cpumask;
> +	}
> +
> +	/*
> +	 * If the new_value does not have any intersection with the cpu_online_mask,
> +	 * the dst_value will be empty, then keep the cpu_affinity_mask as cpu_online_mask.
> +	 */
> +	if (cpumask_and(dst_value, new_value, cpu_online_mask))
> +		cpu_affinity_mask = *dst_value;
> +
> +	free_cpumask_var(dst_value);
> +
> +free_new_cpumask:
> +	free_cpumask_var(new_value);
> +	if (err)
> +		pr_err("failed to update cpu affinity mask, bad affinity list [%s], err %d\n",
> +			buf, err);
> +	return err;
> +}
> +
>   static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
>   {
>   	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
> @@ -1496,7 +1543,12 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
>   	else if (nvme_tcp_poll_queue(queue))
>   		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] -
>   				ctrl->io_queues[HCTX_TYPE_READ] - 1;
> -	queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
> +
> +	if (!cpu_affinity_list || update_cpu_affinity(cpu_affinity_list) != 0) {
> +		// Set the default cpu_affinity_mask to cpu_online_mask
> +		cpu_affinity_mask = *cpu_online_mask;
> +	}
> +	queue->io_cpu = cpumask_next_wrap(n - 1, &cpu_affinity_mask, -1, false);
>   }
>   
>   static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)

I am not in favour of this.
NVMe-over-Fabrics has _virtual_ queues, which really have no 
relationship to the underlying hardware.
So trying to be clever here by tacking queues to CPUs sort of works if 
you have one subsystem to talk to, but if you have several where each 
exposes a _different_ number of queues you end up with a quite 
suboptimal setting (ie you rely on the resulting cpu sets to overlap, 
but there is no guarantee that they do).
Rather leave it to the hardware to sort things out, and rely on the 
blk-mq CPU mapping to get I/O aligned to CPUs.

Cheers,

Hannes

