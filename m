Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30745E804B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiIWRDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiIWRDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:03:02 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EBC1280E0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:03:01 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id bm4loSg0Hg7y2bm4loVquQ; Fri, 23 Sep 2022 19:02:59 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 23 Sep 2022 19:02:59 +0200
X-ME-IP: 86.243.100.34
Message-ID: <a66b0aa5-28d7-a3bb-cbee-bb2021a98ff8@wanadoo.fr>
Date:   Fri, 23 Sep 2022 19:02:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH linux-next] memstick/ms_block: fix the spelling mistakes
Content-Language: en-US
To:     cgel.zte@gmail.com, ulf.hansson@linaro.org
Cc:     maximlevitsky@gmail.com, oakad@yahoo.com, axboe@kernel.dk,
        hare@suse.de, mcgrof@kernel.org, arnd@arndb.de,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>
References: <20220923085601.239691-1-ye.xingchen@zte.com.cn>
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220923085601.239691-1-ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 23/09/2022 à 10:56, cgel.zte@gmail.com a écrit :
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> fix spelling mistake "sucessfuly_written" -> "successfully_written"
> "sucessfuly_read" -> "successfully_read"
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>   drivers/memstick/core/ms_block.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
> index ba8414519515..c6b92a777cc8 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -1809,11 +1809,11 @@ static int msb_init_card(struct memstick_dev *card)
>   }
>   
>   static int msb_do_write_request(struct msb_data *msb, int lba,
> -	int page, struct scatterlist *sg, size_t len, int *sucessfuly_written)
> +	int page, struct scatterlist *sg, size_t len, int *successfully_written)

Hi,

not related to this patch itself, but 'len' is a size_t here and an int 
below.
And these 'len' parameters both come from blk_rq_bytes() which returns 
an "unsigned int"

I guess that if the type was used consistently, it would be better.
(My own preference goes to size_t)

>   {
>   	int error = 0;
>   	off_t offset = 0;
> -	*sucessfuly_written = 0;
> +	*successfully_written = 0;
>   
>   	while (offset < len) {
>   		if (page == 0 && len - offset >= msb->block_size) {
> @@ -1827,7 +1827,7 @@ static int msb_do_write_request(struct msb_data *msb, int lba,
>   				return error;
>   
>   			offset += msb->block_size;
> -			*sucessfuly_written += msb->block_size;
> +			*successfully_written += msb->block_size;
>   			lba++;
>   			continue;
>   		}
> @@ -1837,7 +1837,7 @@ static int msb_do_write_request(struct msb_data *msb, int lba,
>   			return error;
>   
>   		offset += msb->page_size;
> -		*sucessfuly_written += msb->page_size;
> +		*successfully_written += msb->page_size;
>   
>   		page++;
>   		if (page == msb->pages_in_block) {
> @@ -1849,11 +1849,11 @@ static int msb_do_write_request(struct msb_data *msb, int lba,
>   }
>   
>   static int msb_do_read_request(struct msb_data *msb, int lba,
> -		int page, struct scatterlist *sg, int len, int *sucessfuly_read)
> +		int page, struct scatterlist *sg, int len, int *successfully_read)

Here.

>   {
>   	int error = 0;
>   	int offset = 0;
> -	*sucessfuly_read = 0;
> +	*successfully_read = 0;
>   
>   	while (offset < len) {
>   
> @@ -1862,7 +1862,7 @@ static int msb_do_read_request(struct msb_data *msb, int lba,
>   			return error;
>   
>   		offset += msb->page_size;
> -		*sucessfuly_read += msb->page_size;
> +		*successfully_read += msb->page_size;
>   
>   		page++;
>   		if (page == msb->pages_in_block) {
