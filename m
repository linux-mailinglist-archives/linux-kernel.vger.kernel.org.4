Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B058C6B772F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjCMMIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjCMMIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:08:51 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886102A9AD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:08:46 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id q16so11088262wrw.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678709325;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AKdmd3ybGNzUKxSgz2QwAW61PV0agkT7vVa3w7/HBa8=;
        b=2LkkLuk6Z6af4wAyjdAX2zDvqoxiYcAO7gEquQVhGBD+mveI+iE8x2Ezr/9xnKlD7Y
         n786RIJSlD3mZzo5Qgyx7v2bbITd5AwWyQvjTs2ThxpmMKh0WzY+Y/T5tf0bWf1BChqf
         1hvwGsrf/i2EsfotXnwf59yQPbasqwAFm5zDywBz3Y7bGk2BYQb6hhzEUiY1W3rgZei8
         sw7nyEBHuWXEI5fTNwY+ZLVPx03qo1NLyIsFJ6kcc4BA7czXKpNzRpZBwcdiDm0kzcj9
         ierS8q1ZmHhn3W5138w4nRCG6n5kcZEzgGjFcXeavZBO6hGOJMhPc0a65NViRIxms70K
         KIEQ==
X-Gm-Message-State: AO0yUKWJp2tnIE6zUdBtscTnqoO4chVxVnMGeNzIn9z7DUxk7WkILtdO
        j0fzEmV2Chf3xeKPKaeQ1BQ=
X-Google-Smtp-Source: AK7set+Gh0PeK9DtTZuhRQ55dLUGwLC53aKNGmhgDxP8+p1hm1aabAGHBTTcAKhwM7PqgL/OQMVupw==
X-Received: by 2002:a5d:68c2:0:b0:2c7:175e:e201 with SMTP id p2-20020a5d68c2000000b002c7175ee201mr9603882wrw.1.1678709324990;
        Mon, 13 Mar 2023 05:08:44 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f2-20020adfdb42000000b002cf1c435afcsm2809475wrj.11.2023.03.13.05.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 05:08:44 -0700 (PDT)
Message-ID: <adf88c55-64b0-6138-fea8-797d2b30b770@grimberg.me>
Date:   Mon, 13 Mar 2023 14:08:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH] nvme-tcp: fix possible crash when only partilal
 queues are allocated by nvme_tcp_alloc_queue
Content-Language: en-US
From:   Sagi Grimberg <sagi@grimberg.me>
To:     zhangyanjun@cestc.cn, kbusch@kernel.org, axboe@fb.com, hch@lst.de
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        xiang.li@cestc.cn, shaopeijie@cestc.cn
References: <20230313113204.2205730-1-zhangyanjun@cestc.cn>
 <55bfaef2-1faf-ac7a-53b1-60f9e7b8afea@grimberg.me>
In-Reply-To: <55bfaef2-1faf-ac7a-53b1-60f9e7b8afea@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>   So we query that directly freeing these allocated
>> I/O queues may result in this issue. To avoid this issuse, we try to make
>> the following code modifications, but have not verified to be valid yet
>> because of the occasionality of this issue.
>>
>> Now, we can not confirm the caller of queuing on the io_work during
>> allocating all the I/O queues, but we doubt that the socket interface
>> sk_data_ready=nvme_tcp_data_ready initialized by nvme_tcp_alloc_queue
>> may do this action in this interval. Hope to get some suggestions, 
>> Thanks!
> 
> I would start by determining that the running io_work is an io queue or
> the admin queue. It is also possible that the admin queue cleanup after
> we io queues allocation failed is the problematic teardown that is
> causing this bug.
> 
>>
>> Signed-off-by: Yanjun Zhang <zhangyanjun@cestc.cn>
>> ---
>>   drivers/nvme/host/tcp.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 9b47dcb2a..5782183b8 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -1761,6 +1761,7 @@ static int nvme_tcp_alloc_admin_queue(struct 
>> nvme_ctrl *ctrl)
>>   static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>>   {
>>       int i, ret;
>> +    struct nvme_tcp_ctrl *tcp_ctrl = NULL;
>>       for (i = 1; i < ctrl->queue_count; i++) {
>>           ret = nvme_tcp_alloc_queue(ctrl, i);
>> @@ -1771,9 +1772,11 @@ static int __nvme_tcp_alloc_io_queues(struct 
>> nvme_ctrl *ctrl)
>>       return 0;
>>   out_free_queues:
>> -    for (i--; i >= 1; i--)
>> +    for (i--; i >= 1; i--) {
>> +        tcp_ctrl = to_tcp_ctrl(ctrl);
>> +        __nvme_tcp_stop_queue(&tcp_ctrl->queues[i]);
>>           nvme_tcp_free_queue(ctrl, i);
>> -
>> +    }
>>       return ret;
>>   }
> 
> The crash dump reminds me of a reported issue fixed by:
> 160f3549a907 ("nvme-tcp: fix UAF when detecting digest errors")
> 
> Is this applied in your host kernel?
> 
> I'd also add this trace to your reproduction attempts:
> -- 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 0ec7d3329595..0cbc8afb41c8 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -919,6 +919,10 @@ static void nvme_tcp_data_ready(struct sock *sk)
> 
>          read_lock_bh(&sk->sk_callback_lock);
>          queue = sk->sk_user_data;
> +       if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags)) {
> +               pr_err("got data on a deallocated queue %d\n", 
> nvme_tcp_queue_id(queue));
> +               WARN_ON_ONCE(1);
> +       }
>          if (likely(queue && queue->rd_enabled) &&
>              !test_bit(NVME_TCP_Q_POLLING, &queue->flags))
>                  queue_work_on(queue->io_cpu, nvme_tcp_wq, 
> &queue->io_work);
> -- 

If indeed this is the io_queue and for some reason it is running,
perhaps the correct fix would be to set the socket ops later in
start_queue. It will also be symmetric because we clear them in
stop_queue:
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 0ec7d3329595..b3b1e39966c0 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1617,22 +1617,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl 
*nctrl, int qid)
         if (ret)
                 goto err_init_connect;

-       queue->rd_enabled = true;
         set_bit(NVME_TCP_Q_ALLOCATED, &queue->flags);
-       nvme_tcp_init_recv_ctx(queue);
-
-       write_lock_bh(&queue->sock->sk->sk_callback_lock);
-       queue->sock->sk->sk_user_data = queue;
-       queue->state_change = queue->sock->sk->sk_state_change;
-       queue->data_ready = queue->sock->sk->sk_data_ready;
-       queue->write_space = queue->sock->sk->sk_write_space;
-       queue->sock->sk->sk_data_ready = nvme_tcp_data_ready;
-       queue->sock->sk->sk_state_change = nvme_tcp_state_change;
-       queue->sock->sk->sk_write_space = nvme_tcp_write_space;
-#ifdef CONFIG_NET_RX_BUSY_POLL
-       queue->sock->sk->sk_ll_usec = 1;
-#endif
-       write_unlock_bh(&queue->sock->sk->sk_callback_lock);

         return 0;

@@ -1690,6 +1675,21 @@ static int nvme_tcp_start_queue(struct nvme_ctrl 
*nctrl, int idx)
         struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
         int ret;

+       queue->rd_enabled = true;
+       nvme_tcp_init_recv_ctx(queue);
+       write_lock_bh(&queue->sock->sk->sk_callback_lock);
+       queue->sock->sk->sk_user_data = queue;
+       queue->state_change = queue->sock->sk->sk_state_change;
+       queue->data_ready = queue->sock->sk->sk_data_ready;
+       queue->write_space = queue->sock->sk->sk_write_space;
+       queue->sock->sk->sk_data_ready = nvme_tcp_data_ready;
+       queue->sock->sk->sk_state_change = nvme_tcp_state_change;
+       queue->sock->sk->sk_write_space = nvme_tcp_write_space;
+#ifdef CONFIG_NET_RX_BUSY_POLL
+       queue->sock->sk->sk_ll_usec = 1;
+#endif
+       write_unlock_bh(&queue->sock->sk->sk_callback_lock);
+
         if (idx)
                 ret = nvmf_connect_io_queue(nctrl, idx);
         else
--
