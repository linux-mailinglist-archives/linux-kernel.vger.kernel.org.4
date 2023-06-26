Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDC873DF10
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjFZMZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjFZMYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:24:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654372D62;
        Mon, 26 Jun 2023 05:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687782192; x=1719318192;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QAtvPIkccnlu6Ank7qJ23cw0df5MPmI943wyhruOK7I=;
  b=BCd/MaiDg+HtxceL576XQeC0hn9/ZvEeSfwoeuiOJZWGP+jJl6TYOdmK
   VQSoFh8FwlWt8ia506twE8fnK3jG9X0eIMj/MbMr676r57VDyS5kCLenV
   x3Qqvbq9ihYY8xUrr1fR7dWA71/aJO6dUsbXH+WmSv6ZTNT5RNzkOn3QX
   Y38HH2oq+NptrIP09t0lUSBfy2+zZYuVDIgLG62Oc7K0nHdXgTOF9sBJ1
   LpHMVQe5+CsbA9m9HKSs9kdB1+y8PFtniNySzwfhAtXZ2YoGbbfSj26Jy
   oRxiJI5VDEea7PlDjXVz5Q5lJIXcN5uHz44YkFQNj6kYBojOlf2hrVSa/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="424921617"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="424921617"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 05:23:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="1046490771"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="1046490771"
Received: from ettammin-mobl1.ger.corp.intel.com (HELO [10.249.254.105]) ([10.249.254.105])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 05:23:09 -0700
Message-ID: <e7098908-811b-3d26-5b72-b57afd8a1fdd@linux.intel.com>
Date:   Mon, 26 Jun 2023 14:23:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v2 4/4] drm/ttm: Don't leak a resource on swapout move
 error
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        intel-xe@lists.freedesktop.org
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
        Nirmoy Das <nirmoy.das@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230626091450.14757-1-thomas.hellstrom@linux.intel.com>
 <20230626091450.14757-5-thomas.hellstrom@linux.intel.com>
 <f63137cd-2032-1598-a1d7-484248ef1d02@gmail.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>
In-Reply-To: <f63137cd-2032-1598-a1d7-484248ef1d02@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christian,

Will you take a look at 2/4 as well? Will you merge these?

Thanks,

Thomas


On 6/26/23 13:33, Christian König wrote:
> Am 26.06.23 um 11:14 schrieb Thomas Hellström:
>> If moving the bo to system for swapout failed, we were leaking
>> a resource. Fix.
>>
>> Fixes: bfa3357ef9ab ("drm/ttm: allocate resource object instead of 
>> embedding it v2")
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: "Christian König" <ckoenig.leichtzumerken@gmail.com>
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: <stable@vger.kernel.org> # v5.14+
>> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
>> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
>
> Reviewed-by: Christian König <christian.koenig@amd.com>
>
>> ---
>>   drivers/gpu/drm/ttm/ttm_bo.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
>> index c0e3bbd21d3d..d9a8f227f310 100644
>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>> @@ -1166,6 +1166,7 @@ int ttm_bo_swapout(struct ttm_buffer_object 
>> *bo, struct ttm_operation_ctx *ctx,
>>           ret = ttm_bo_handle_move_mem(bo, evict_mem, true, ctx, &hop);
>>           if (unlikely(ret != 0)) {
>>               WARN(ret == -EMULTIHOP, "Unexpected multihop in swaput 
>> - likely driver bug.\n");
>> +            ttm_resource_free(bo, &evict_mem);
>>               goto out;
>>           }
>>       }
>
