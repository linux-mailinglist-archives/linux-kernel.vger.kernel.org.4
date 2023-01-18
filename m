Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27DE671A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjARLLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjARLKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:10:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8762A402DA;
        Wed, 18 Jan 2023 02:18:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE9C9B81C12;
        Wed, 18 Jan 2023 10:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5FCC433D2;
        Wed, 18 Jan 2023 10:18:23 +0000 (UTC)
Message-ID: <b1a8593b-b4f3-b943-39db-ed17679e32cb@xs4all.nl>
Date:   Wed, 18 Jan 2023 11:18:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] media:cec:fix double free and uaf issue when cancel data
 during noblocking
Content-Language: en-US
To:     korantwork@gmail.com, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>, loydlv <loydlv@tencent.com>
References: <20230111123712.160882-1-korantwork@gmail.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230111123712.160882-1-korantwork@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xinghui Li,

On 11/01/2023 13:37, korantwork@gmail.com wrote:
> From: Xinghui Li <korantli@tencent.com>
> 
> data could be free when it is not completed during transmit if
> the opt is nonblocking.In this case,the regular free could lead
> to double-free.So, add the return value '-EPERM' to mark the
> above case.
> 
> Reported-by: loydlv <loydlv@tencent.com>
> Signed-off-by: Xinghui Li <korantli@tencent.com>
> ---
>  drivers/media/cec/core/cec-adap.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
> index 4f5ab3cae8a7..c2ba8d1173c1 100644
> --- a/drivers/media/cec/core/cec-adap.c
> +++ b/drivers/media/cec/core/cec-adap.c
> @@ -311,7 +311,7 @@ static void cec_post_state_event(struct cec_adapter *adap)
>   *
>   * This function is called with adap->lock held.
>   */
> -static void cec_data_completed(struct cec_data *data)
> +static int cec_data_completed(struct cec_data *data)
>  {
>  	/*
>  	 * Delete this transmit from the filehandle's xfer_list since
> @@ -339,7 +339,9 @@ static void cec_data_completed(struct cec_data *data)
>  		if (data->fh)
>  			cec_queue_msg_fh(data->fh, &data->msg);
>  		kfree(data);
> +		return -EPERM;

This free is called if data->blocking is false...

>  	}
> +	return 0;
>  }
>  
>  /*
> @@ -349,7 +351,7 @@ static void cec_data_completed(struct cec_data *data)
>   *
>   * This function is called with adap->lock held.
>   */
> -static void cec_data_cancel(struct cec_data *data, u8 tx_status, u8 rx_status)
> +static int cec_data_cancel(struct cec_data *data, u8 tx_status, u8 rx_status)
>  {
>  	struct cec_adapter *adap = data->adap;
>  
> @@ -388,7 +390,7 @@ static void cec_data_cancel(struct cec_data *data, u8 tx_status, u8 rx_status)
>  		/* Allow drivers to process the message first */
>  		call_op(adap, received, &data->msg);
>  
> -	cec_data_completed(data);
> +	return cec_data_completed(data);
>  }
>  
>  /*
> @@ -744,6 +746,7 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
>  {
>  	struct cec_data *data;
>  	bool is_raw = msg_is_raw(msg);
> +	int ret = 0;
>  
>  	if (adap->devnode.unregistered)
>  		return -ENODEV;
> @@ -916,18 +919,20 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
>  	/* Cancel the transmit if it was interrupted */
>  	if (!data->completed) {
>  		if (data->msg.tx_status & CEC_TX_STATUS_OK)
> -			cec_data_cancel(data, CEC_TX_STATUS_OK, CEC_RX_STATUS_ABORTED);
> +			ret = cec_data_cancel(data, CEC_TX_STATUS_OK, CEC_RX_STATUS_ABORTED);
>  		else
> -			cec_data_cancel(data, CEC_TX_STATUS_ABORTED, 0);
> +			ret = cec_data_cancel(data, CEC_TX_STATUS_ABORTED, 0);
>  	}
>  
>  	/* The transmit completed (possibly with an error) */
> -	*msg = data->msg;
> -	if (WARN_ON(!list_empty(&data->list)))
> -		list_del(&data->list);
> -	if (WARN_ON(!list_empty(&data->xfer_list)))
> -		list_del(&data->xfer_list);
> -	kfree(data);
> +	if (!ret) {
> +		*msg = data->msg;
> +		if (WARN_ON(!list_empty(&data->list)))
> +			list_del(&data->list);
> +		if (WARN_ON(!list_empty(&data->xfer_list)))
> +			list_del(&data->xfer_list);
> +		kfree(data);

...while this free is called if data->blocking is true. (see the 'if (!block) return 0;'
further up).

So I have my doubts if this patch actually addresses the correct issue.

Do you have an actual debug trace of the UAF? Or even better, code to reproduce
this issue.

Regards,

	Hans

> +	}
>  	return 0;
>  }
>  

