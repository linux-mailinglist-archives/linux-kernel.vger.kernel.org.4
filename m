Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1316A623940
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiKJByN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiKJByL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:54:11 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C823A2982C;
        Wed,  9 Nov 2022 17:54:07 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N74cw5wKgz15MW5;
        Thu, 10 Nov 2022 09:53:52 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 09:54:05 +0800
Subject: Re: [PATCH] wifi: ath10k: Fix resource leak in ath10k_pci_init()
To:     Jeff Johnson <quic_jjohnson@quicinc.com>, <kvalo@kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <rmani@qti.qualcomm.com>
CC:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221108133858.53308-1-xiujianfeng@huawei.com>
 <4e81efea-23f1-e52c-b0b4-abf445ed5f15@quicinc.com>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <cd3194f8-3cad-ce12-602f-8651e99365ab@huawei.com>
Date:   Thu, 10 Nov 2022 09:54:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <4e81efea-23f1-e52c-b0b4-abf445ed5f15@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2022/11/10 0:34, Jeff Johnson 写道:
> On 11/8/2022 5:38 AM, Xiu Jianfeng wrote:
>> When ath10k_ahb_init() fails, it does not unregister ath10k_pci_driver,
>> which will cause a resource leak issue, call pci_unregister_driver() in
>> the error path to fix this issue.
>>
>> Fixes: 0b523ced9a3c ("ath10k: add basic skeleton to support ahb")
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>>   drivers/net/wireless/ath/ath10k/pci.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath10k/pci.c 
>> b/drivers/net/wireless/ath/ath10k/pci.c
>> index e56c6a6b1379..22f8f8b20762 100644
>> --- a/drivers/net/wireless/ath/ath10k/pci.c
>> +++ b/drivers/net/wireless/ath/ath10k/pci.c
>> @@ -3800,8 +3800,10 @@ static int __init ath10k_pci_init(void)
>>                  ret);
>>       ret = ath10k_ahb_init();
>> -    if (ret)
>> +    if (ret) {
>>           printk(KERN_ERR "ahb init failed: %d\n", ret);
>> +        pci_unregister_driver(&ath10k_pci_driver);
>> +    }
>>       return ret;
>>   }
> 
> imo neither the existing code nor the modified code is correct.
> 
> the driver is attempting to register to support two different buses.
> 
> if either of these is successful then ath10k_pci_init() should return 0 
> so that hardware attached to the successful bus can be probed and 
> supported.
> 
> only if both of these are unsuccessful should ath10k_pci_init() return 
> an errno.
> 
> so I suggest
>      int ret1, ret2;
> 
>      ret1 = pci_register_driver(&ath10k_pci_driver);
>      if (ret1)
>          printk(KERN_ERR "failed to register ath10k pci driver: %d\n",
>                 ret1);
> 
>      ret2 = ath10k_ahb_init();
>      if (ret2)
>          printk(KERN_ERR "ahb init failed: %d\n", ret2);
> 
>      if (ret1 && ret2)
>          return ret1;
> 
>      /* registered to at least one bus */
>      return 0;
> }

Thanks, this is better. however, if pci_register_driver() returns 0
while ath10k_ahb_init() returns error, it's better to unregister the
first bus, here is my another proposal:

         int ret;

         ret = pci_register_driver(&ath10k_pci_driver);
         if (ret) {
                 printk(KERN_ERR "failed to register ath10k pci driver: 
%d\n",
                        ret);
                 return ret;
         }

         ret = ath10k_ahb_init();
         if (ret) {
                 printk(KERN_ERR "ahb init failed: %d\n", ret);
                 pci_unregister_driver(&ath10k_pci_driver);
                 return ret;
         }

         return 0;

If you agree, I will send v2 with this.

> 
> .
