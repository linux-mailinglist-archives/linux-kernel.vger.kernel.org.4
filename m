Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01546EA5A4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjDUIQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjDUIQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:16:05 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A4B13E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:16:00 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7637c5ed865so168824439f.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1682064958; x=1684656958;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qCGHRBc+uVHcj0EdY6TeoG6GbZWnSmTkOlbKkZxZR9A=;
        b=HS27dZTQ/xyvfSneaQekhHkzapypxPOR9xdvahvYgvDQdNwCgmyh+hWm94qg9PDiFJ
         JfysofErBDhQA/HBN1RIPTDUgoNCQPmy28GJT0JfJwXpWVPiEFaEa1eGYpDssxjnPKad
         ND4Do1kKYY1hw4bP72aMorvjUlRYIp89179/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682064958; x=1684656958;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCGHRBc+uVHcj0EdY6TeoG6GbZWnSmTkOlbKkZxZR9A=;
        b=kDIzcDmbwvJ+jXPIhwPWGGVZ4sj6xcvCQhMMQQWxj41A6M7QP/uvnMP1XAjkaayASM
         v+x1mX58V6d5kpaH2901SqhMe2Fa7MC0FvejLLSy8VOCiIxAnYN6e9l/1XqixgakgkUq
         RQ9aiW8pyjAreCzHJM3yNPVTxtAl6cmgVPUXbv3UCe7KymdeFa6IWrtyR7uU9l09JsJ6
         JdwkuMKHke3LZG1CjGTXN06cfWJc+3iDEwaH7xdut0e7VBDzeVLuscB8vUfnuPMMTQod
         jbMu+1RErG76YVsToguBmNAWC2MOMkovPh4+Dl+U1WvPbgjuNI4E35g1M9C82VYDkW6H
         1toA==
X-Gm-Message-State: AAQBX9fGWIiS56fmwJ/gtpkNXkK2aLH/PW5uY3U4uEVtsJJgp4HDwLLF
        DD9MEMWtWPLZYC+r8d7bb5WUpg7S3Va2OSwln2s=
X-Google-Smtp-Source: AKy350a/Ot5qjHO2A6etlksx60Ur9+OLDkpJY5TIXGN6F+YYh4pskZCRYr2Iu4Swk0XPJRox724XXw==
X-Received: by 2002:a5e:9401:0:b0:763:8eea:5d8b with SMTP id q1-20020a5e9401000000b007638eea5d8bmr3006483ioj.4.1682064958394;
        Fri, 21 Apr 2023 01:15:58 -0700 (PDT)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id e22-20020a5d9256000000b0076356c2d1acsm905845iol.52.2023.04.21.01.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 01:15:57 -0700 (PDT)
Message-ID: <57f311ec-381a-e468-3b28-bd73521d5e00@ieee.org>
Date:   Fri, 21 Apr 2023 03:15:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 02/22] greybus: Use alloc_ordered_workqueue() to create
 ordered workqueues
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org
References: <20230421025046.4008499-1-tj@kernel.org>
 <20230421025046.4008499-3-tj@kernel.org>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <20230421025046.4008499-3-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/23 9:50 PM, Tejun Heo wrote:
> BACKGROUND
> ==========
> 
> When multiple work items are queued to a workqueue, their execution order
> doesn't match the queueing order. They may get executed in any order and
> simultaneously. When fully serialized execution - one by one in the queueing
> order - is needed, an ordered workqueue should be used which can be created
> with alloc_ordered_workqueue().
> 
> However, alloc_ordered_workqueue() was a later addition. Before it, an
> ordered workqueue could be obtained by creating an UNBOUND workqueue with
> @max_active==1. This originally was an implementation side-effect which was
> broken by 4c16bd327c74 ("workqueue: restore WQ_UNBOUND/max_active==1 to be
> ordered"). Because there were users that depended on the ordered execution,
> 5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
> made workqueue allocation path to implicitly promote UNBOUND workqueues w/
> @max_active==1 to ordered workqueues.
> 
> While this has worked okay, overloading the UNBOUND allocation interface
> this way creates other issues. It's difficult to tell whether a given
> workqueue actually needs to be ordered and users that legitimately want a
> min concurrency level wq unexpectedly gets an ordered one instead. With
> planned UNBOUND workqueue updates to improve execution locality and more
> prevalence of chiplet designs which can benefit from such improvements, this
> isn't a state we wanna be in forever.
> 
> This patch series audits all callsites that create an UNBOUND workqueue w/
> @max_active==1 and converts them to alloc_ordered_workqueue() as necessary.
> 
> WHAT TO LOOK FOR
> ================
> 
> The conversions are from
> 
>    alloc_workqueue(WQ_UNBOUND | flags, 1, args..)
> 
> to
> 
>    alloc_ordered_workqueue(flags, args...)
> 
> which don't cause any functional changes. If you know that fully ordered
> execution is not ncessary, please let me know. I'll drop the conversion and
> instead add a comment noting the fact to reduce confusion while conversion
> is in progress.
> 
> If you aren't fully sure, it's completely fine to let the conversion
> through. The behavior will stay exactly the same and we can always
> reconsider later.
> 
> As there are follow-up workqueue core changes, I'd really appreciate if the
> patch can be routed through the workqueue tree w/ your acks. Thanks.

Both of the workqueues affected here should be ordered.

Acked-by: Alex Elder <elder@linaro.org>

> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: greybus-dev@lists.linaro.org
> ---
>   drivers/greybus/connection.c | 4 ++--
>   drivers/greybus/svc.c        | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/greybus/connection.c b/drivers/greybus/connection.c
> index e3799a53a193..9c88861986c8 100644
> --- a/drivers/greybus/connection.c
> +++ b/drivers/greybus/connection.c
> @@ -187,8 +187,8 @@ _gb_connection_create(struct gb_host_device *hd, int hd_cport_id,
>   	spin_lock_init(&connection->lock);
>   	INIT_LIST_HEAD(&connection->operations);
>   
> -	connection->wq = alloc_workqueue("%s:%d", WQ_UNBOUND, 1,
> -					 dev_name(&hd->dev), hd_cport_id);
> +	connection->wq = alloc_ordered_workqueue("%s:%d", 0, dev_name(&hd->dev),
> +						 hd_cport_id);
>   	if (!connection->wq) {
>   		ret = -ENOMEM;
>   		goto err_free_connection;
> diff --git a/drivers/greybus/svc.c b/drivers/greybus/svc.c
> index 16cced80867a..0d7e749174a4 100644
> --- a/drivers/greybus/svc.c
> +++ b/drivers/greybus/svc.c
> @@ -1318,7 +1318,7 @@ struct gb_svc *gb_svc_create(struct gb_host_device *hd)
>   	if (!svc)
>   		return NULL;
>   
> -	svc->wq = alloc_workqueue("%s:svc", WQ_UNBOUND, 1, dev_name(&hd->dev));
> +	svc->wq = alloc_ordered_workqueue("%s:svc", 0, dev_name(&hd->dev));
>   	if (!svc->wq) {
>   		kfree(svc);
>   		return NULL;

