Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5B1616A4C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiKBROS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiKBRNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:13:55 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0092D3;
        Wed,  2 Nov 2022 10:13:54 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A2HDeqq111380;
        Wed, 2 Nov 2022 12:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667409220;
        bh=9xXQl3ypMam93TQFZncK480oz+++LfFiwW9TqbQA7ow=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=WqN4PAWBfTgKqYPqWR9QfiQMUSEDkcgH7jMjSv6Cf7d6MMl030QQzz87vmOiCkhmW
         wch90C6cgTFlDbDD20D2mJ1zuddtVjIe7cBPvqx+dTZoly+wJdzW+xxvRFeLfdBPy4
         azLS9WnhAuCZ1JiBBvlQf09MX1qlI/AwwaJw6Pgg=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A2HDeBh090547
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Nov 2022 12:13:40 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 2 Nov
 2022 12:13:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 2 Nov 2022 12:13:40 -0500
Received: from [10.249.33.217] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A2HDd5N022592;
        Wed, 2 Nov 2022 12:13:39 -0500
Message-ID: <ef0636bd-bb23-19b0-ab8f-a37280fe4296@ti.com>
Date:   Wed, 2 Nov 2022 12:13:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3] dma-buf: fix racing conflict of dma_heap_add()
Content-Language: en-US
To:     Dawei Li <set_pte_at@outlook.com>, <sumit.semwal@linaro.org>,
        <christian.koenig@amd.com>
CC:     <benjamin.gaignard@collabora.com>, <labbott@redhat.com>,
        <Brian.Starkey@arm.com>, <jstultz@google.com>,
        <sspatil@android.com>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>
References: <TYCP286MB2323D71DEC1D008BEA6F7ABBCA399@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <TYCP286MB2323D71DEC1D008BEA6F7ABBCA399@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/22 10:58 AM, Dawei Li wrote:
> Racing conflict could be:
> task A                 task B
> list_for_each_entry
> strcmp(h->name))
>                         list_for_each_entry
>                         strcmp(h->name)
> kzalloc                kzalloc
> ......                 .....
> device_create          device_create
> list_add
>                         list_add
> 
> The root cause is that task B has no idea about the fact someone
> else(A) has inserted heap with same name when it calls list_add,
> so a potential collision occurs.
> 
> v1: https://lore.kernel.org/all/TYCP286MB2323950197F60FC3473123B7CA349@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/
> 
> v1->v2: Narrow down locking scope, check the existence of heap before
> insertion, as suggested by Andrew Davis.
> 
> v2->v3: Remove double checking.

The above version info should be in a cover letter or below
the --- line so it doesn't end up in the commit message in tree.

> 
> Fixes: c02a81fba74f ("dma-buf: Add dma-buf heaps framework")
> 
> base-commit: 447fb14bf07905b880c9ed1ea92c53d6dd0649d7
> 

Same as above, plus this is an odd base, maybe just use "v6.1-rc2".

> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>   drivers/dma-buf/dma-heap.c | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index 8f5848aa144f..7a25e98259ea 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -233,18 +233,6 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
>   		return ERR_PTR(-EINVAL);
>   	}
>   
> -	/* check the name is unique */
> -	mutex_lock(&heap_list_lock);
> -	list_for_each_entry(h, &heap_list, list) {
> -		if (!strcmp(h->name, exp_info->name)) {
> -			mutex_unlock(&heap_list_lock);
> -			pr_err("dma_heap: Already registered heap named %s\n",
> -			       exp_info->name);
> -			return ERR_PTR(-EINVAL);
> -		}
> -	}
> -	mutex_unlock(&heap_list_lock);
> -
>   	heap = kzalloc(sizeof(*heap), GFP_KERNEL);
>   	if (!heap)
>   		return ERR_PTR(-ENOMEM);
> @@ -283,13 +271,26 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
>   		err_ret = ERR_CAST(dev_ret);
>   		goto err2;
>   	}
> -	/* Add heap to the list */
> +
>   	mutex_lock(&heap_list_lock);
> +	/* check the name is unique */
> +	list_for_each_entry(h, &heap_list, list) {
> +		if (!strcmp(h->name, exp_info->name)) {
> +			mutex_unlock(&heap_list_lock);
> +			pr_err("dma_heap: Already registered heap named %s\n",
> +			       exp_info->name);
> +			err_ret = ERR_PTR(-EINVAL);
> +			goto err3;
> +		}
> +	}
> +
> +	/* Add heap to the list */
>   	list_add(&heap->list, &heap_list);
>   	mutex_unlock(&heap_list_lock);
>   
>   	return heap;
> -

Would like to keep this new line after the return statement.

Andrew

> +err3:
> +	device_destroy(dma_heap_class, heap->heap_devt);
>   err2:
>   	cdev_del(&heap->heap_cdev);
>   err1:
