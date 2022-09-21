Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3229F5BF8ED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiIUIUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiIUIUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:20:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF61237CF;
        Wed, 21 Sep 2022 01:20:03 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MXWSq0b6qzlWmK;
        Wed, 21 Sep 2022 16:15:55 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 16:20:02 +0800
Received: from [10.67.103.158] (10.67.103.158) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 16:20:01 +0800
Message-ID: <69a629de-a2f8-202c-da31-a5f11c87427a@huawei.com>
Date:   Wed, 21 Sep 2022 16:20:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [RFC PATCH 2/6] crypto: benchmark - add a crypto benchmark tool
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
References: <20220919120537.39258-1-shenyang39@huawei.com>
 <20220919120537.39258-3-shenyang39@huawei.com> <YylsNQb/EjUqkWEZ@kroah.com>
From:   Yang Shen <shenyang39@huawei.com>
In-Reply-To: <YylsNQb/EjUqkWEZ@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/9/20 15:31, Greg KH 写道:
> On Mon, Sep 19, 2022 at 08:05:33PM +0800, Yang Shen wrote:
>> Provide a crypto benchmark to help the developer quickly get the
>> performance of a algorithm registered in crypto.
>>
>> Due to the crypto algorithms have multifarious parameters, the tool
>> cannot support all test scenes. In order to provide users with simple
>> and easy-to-use tools and support as many test scenarios as possible,
>> benchmark refers to the crypto method to provide a unified struct
>> 'crypto_bm_ops'. And the algorithm registers its own callbacks to parse
>> the user's input. In crypto, a algorithm class has multiple algorithms,
>> but all of them uses the same API. So in the benchmark, a algorithm
>> class uses the same 'ops' and distinguish specific algorithm by name.
>>
>> First, consider the performance calculation model. Considering the
>> crypto subsystem model, a reasonable process code based on crypto api
>> should create a numa node based 'crypto_tfm' in advance and apply for
>> a certain amount of 'crypto_req' according to their own business.
>> In the real business processing stage, the thread send tasks based on
>> 'crypto_req' and wait for completion.
>>
>> Therefore, the benchmark will create 'crypto_tfm' and 'crypto_req' at
>> first, and then count all requests time to calculate performance.
>> So the result is the pure algorithm performance. When each algorithm
>> class implements its own 'ops', it needs to pay attention to the content
>> completed in the callback. Before the 'ops.perf', the tool had better
>> prepare the request data set. And in order to avoid the false high
>> performance of the algorithm caused by the false cache and TLB hit rate,
>> the size of data set should be larger than 'crypto_req' number.
>> The 'crypto_bm_ops' has following api:
>>   - init & uninit
>>   The initialize related functions. Algorithm can do some private setting.
>>   - create_tfm & release_tfm
>>   The 'crypto_tfm' related functions. Algorithm has different tfm name in
>>   crypto. But they both has a member named tfm, so use tfm to stand for
>>   algorithm handle. The benchmark has provides the tfm array.
>>   - create_req & release_req
>>   The 'crypto_req' related functions. The callbacks should create a 'reqnum'
>>   'crypto_req' group in struct 'crypto_bm_base'. And the also suggest
>>   prepare the request data in this function. In order to avoid the false
>>   high performance of the algorithm caused by the false cache and TLB hit
>>   rate, the size of data set should be larger than 'crypto_req' number.
>>   - perf
>>   The request sending functions. The registrant should use parameter 'loop'
>>   to send requests repeatly. And update the count in struct
>>   'crypto_bm_thread_data'.
>>
>> Then consider the parameters that user can configure. Generally speaking,
>> the following parameters will affect the performance of the algorithm:
>> tfm number, request number, block size, numa node. And some parameters
>> will affect the stability of performance: testing time and requests sent
>> number. To sum up, the benchmark has following parameters:
>>   - algorithm
>>   The testing algorithm name. Showed in /proc/crypto.
>>   - algtype
>>   The testing algorithm class. Can get the algorithm class by echo 'algtype'
>>   to /sys/module/crypto_benchmark/parameters/help.
>>   - inputsize
>>   The testing length that can greatly impact performance. Such as data size
>>   for compress or key length for encryption.
>>   - loop
>>   The testing loop times. Avoid performance fluctuations caused by
>>   environment.
>>   - numamask
>>   The testing bind numamask. Used for allocate memory, create threads and
>>   create 'crypto_tfm'.
>>   - optype
>>   The testing algorithm operation type. Can get the algorithm available
>>   operation types by cat /sys/module/crypto_benchmark/parameters/help
>>   with specified 'algtype'.
>>   - reqnum
>>   The testing request number for per tfm. Used for test asynchrony api
>>   performance.
>>   - threadnum
>>   The testing thread number. To simplify model, create a 'crypto_tfm' per
>>   thread.
>>   - time
>>   The testing time. Used for stop the test thread.
>>   - run
>>   Start or stop the test.
>>
>> Users can configure parameters under
>> /sys/modules/crypto_benchmark/parameters/.
> Please don't use module parameters for stuff like this, use configfs
> which was designed for this type of interactions.
>
> thanks,
>
> greg k-h
Got it!

Thanks,

Yang

