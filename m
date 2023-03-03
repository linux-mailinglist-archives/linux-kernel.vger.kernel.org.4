Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4F96A95C0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjCCLCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjCCLCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:02:40 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF6F5F6ED;
        Fri,  3 Mar 2023 03:02:38 -0800 (PST)
Received: from [192.168.10.39] (unknown [182.179.171.187])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9BADE6600363;
        Fri,  3 Mar 2023 11:02:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677841357;
        bh=jYpU2R+/5CCDdv+B9z7WY6WA2foey3UzjG0WVVgYfrg=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=DawcHy4cIsKanK3u1RtWmcN9Z0IGLkwcE3cDI43A1EIpDNBa/4JCUN+TJwTOy9GiC
         cb4z/eUUyZwB6nslhca7BKzxSkVq7v5gpKcp75vD8MjQo5QB/wUpptwS6IXWcHj9BD
         LXFPNWVy6KoCg9Jz7wrnqajpIatquB8Vu41mxrK2yZcQP7ILQiqIssXrBUs0bgXZHQ
         YL+bFpaU7qPhn7OWbpx6ifSBzFjVQHDir2N2qdxAO04vWrHHNeP5Shftxfhp0uLB8k
         jZk4mM8cnz9IkXfmfk9LchMEUYLzek6WgtXgG8wEiPxgOaaShhElV67lrZl0nTYDBf
         iQMDkXsINOjnQ==
Message-ID: <67d475aa-b999-bf57-3aa3-40ad4b50e21d@collabora.com>
Date:   Fri, 3 Mar 2023 16:02:26 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com
Subject: Re: [PATCH v3] s390/zcrypt: remove unnecessary (void*) conversions
Content-Language: en-US
To:     Yu Zhe <yuzhe@nfschina.com>, freude@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com
References: <20230303013250.3058-1-yuzhe@nfschina.com>
 <20230303052155.21072-1-yuzhe@nfschina.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230303052155.21072-1-yuzhe@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/23 10:21 AM, Yu Zhe wrote:
> Pointer variables of void * type do not require type cast.
> 
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  drivers/s390/crypto/zcrypt_msgtype6.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
> index 5ad251477593..a2e7fe33ba62 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> @@ -926,8 +926,7 @@ static void zcrypt_msgtype6_receive(struct ap_queue *aq,
>  		.type = TYPE82_RSP_CODE,
>  		.reply_code = REP82_ERROR_MACHINE_FAILURE,
>  	};
> -	struct response_type *resp_type =
> -		(struct response_type *)msg->private;
> +	struct response_type *resp_type = msg->private;
>  	struct type86x_reply *t86r;
>  	int len;
>  
> @@ -982,8 +981,7 @@ static void zcrypt_msgtype6_receive_ep11(struct ap_queue *aq,
>  		.type = TYPE82_RSP_CODE,
>  		.reply_code = REP82_ERROR_MACHINE_FAILURE,
>  	};
> -	struct response_type *resp_type =
> -		(struct response_type *)msg->private;
> +	struct response_type *resp_type = msg->private;
>  	struct type86_ep11_reply *t86r;
>  	int len;
>  
> @@ -1157,7 +1155,7 @@ static long zcrypt_msgtype6_send_cprb(bool userspace, struct zcrypt_queue *zq,
>  				      struct ap_message *ap_msg)
>  {
>  	int rc;
> -	struct response_type *rtype = (struct response_type *)(ap_msg->private);
> +	struct response_type *rtype = ap_msg->private;
>  	struct {
>  		struct type6_hdr hdr;
>  		struct CPRBX cprbx;
> @@ -1240,7 +1238,7 @@ static long zcrypt_msgtype6_send_ep11_cprb(bool userspace, struct zcrypt_queue *
>  {
>  	int rc;
>  	unsigned int lfmt;
> -	struct response_type *rtype = (struct response_type *)(ap_msg->private);
> +	struct response_type *rtype = ap_msg->private;
>  	struct {
>  		struct type6_hdr hdr;
>  		struct ep11_cprb cprbx;
> @@ -1359,7 +1357,7 @@ static long zcrypt_msgtype6_rng(struct zcrypt_queue *zq,
>  		short int verb_length;
>  		short int key_length;
>  	} __packed * msg = ap_msg->msg;
> -	struct response_type *rtype = (struct response_type *)(ap_msg->private);
> +	struct response_type *rtype = ap_msg->private;
>  	int rc;
>  
>  	msg->cprbx.domain = AP_QID_QUEUE(zq->queue->qid);

-- 
BR,
Muhammad Usama Anjum
