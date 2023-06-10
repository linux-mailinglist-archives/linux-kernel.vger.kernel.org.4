Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F8672A8BA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 05:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjFJDVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 23:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFJDU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 23:20:58 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B61E1;
        Fri,  9 Jun 2023 20:20:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VkjuBza_1686367249;
Received: from 30.13.188.136(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VkjuBza_1686367249)
          by smtp.aliyun-inc.com;
          Sat, 10 Jun 2023 11:20:51 +0800
Message-ID: <a0a07bfd-6e44-5478-395d-be6c1f3bd92a@linux.alibaba.com>
Date:   Sat, 10 Jun 2023 11:20:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] virtio-crypto: fixup potential cpu stall when free
 unused bufs
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     arei.gonglei@huawei.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, amit@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xianting Tian <tianxianting.txt@alibaba-inc.com>
References: <20230609131817.712867-1-xianting.tian@linux.alibaba.com>
 <20230609131817.712867-2-xianting.tian@linux.alibaba.com>
 <20230609115617-mutt-send-email-mst@kernel.org>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <20230609115617-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/6/9 下午11:57, Michael S. Tsirkin 写道:
> On Fri, Jun 09, 2023 at 09:18:15PM +0800, Xianting Tian wrote:
>> From: Xianting Tian <tianxianting.txt@alibaba-inc.com>
>>
>> Cpu stall issue may happen if device is configured with multi queues
>> and large queue depth, so fix it.
> What does "may happen" imply exactly?
> was this observed?
I didn't met such issue, this patch set just a theoretical fix.
>
>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>> ---
>>   drivers/crypto/virtio/virtio_crypto_core.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
>> index 1198bd306365..94849fa3bd74 100644
>> --- a/drivers/crypto/virtio/virtio_crypto_core.c
>> +++ b/drivers/crypto/virtio/virtio_crypto_core.c
>> @@ -480,6 +480,7 @@ static void virtcrypto_free_unused_reqs(struct virtio_crypto *vcrypto)
>>   			kfree(vc_req->req_data);
>>   			kfree(vc_req->sgs);
>>   		}
>> +		cond_resched();
>>   	}
>>   }
>>   
>> -- 
>> 2.17.1
