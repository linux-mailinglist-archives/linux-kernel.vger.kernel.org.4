Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC2162397C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 03:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiKJCEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 21:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiKJCE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 21:04:28 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8731F27B35;
        Wed,  9 Nov 2022 18:03:56 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N74rJ5g41zRp2Z;
        Thu, 10 Nov 2022 10:03:44 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 10:03:54 +0800
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 10:03:54 +0800
Subject: Re: [PATCH] crypto/hisilicon: Add null judgment to the callback
 interface
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     <wangzhou1@hisilicon.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220930024320.29922-1-liulongfang@huawei.com>
 <YzZZTsIHLSkuufeb@gondor.apana.org.au>
 <717adf23-3080-5041-14ed-6ab5dcaddbf9@huawei.com>
 <Y1tTLAEi7ukUCCmB@gondor.apana.org.au>
 <a1229856-fbe4-9ae7-5789-332ed0af87eb@huawei.com>
 <Y2TWpyynYMyStKRX@gondor.apana.org.au>
 <d914a099-06ef-acfe-f394-f4790a821598@huawei.com>
 <Y2oodE+5us++mbSl@gondor.apana.org.au>
 <df561fbe-12eb-25b0-2173-a7ffb3bfd53a@huawei.com>
 <Y2twbHyQkTMoTz+O@gondor.apana.org.au>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <32686c5b-04b2-7103-bf2e-113db2315ef4@huawei.com>
Date:   Thu, 10 Nov 2022 10:03:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y2twbHyQkTMoTz+O@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/9 17:18, Herbert Xu wrote:
> On Wed, Nov 09, 2022 at 02:21:11PM +0800, liulongfang wrote:
>>
>> The trigger method is to not call the function skcipher_request_set_callback()
>> when using the skcipher interface for encryption and decryption services.
> 
> Yes but which function exactly? Please give the exact call path
> leading to this crash.
> 

This problem occurs in the application code of the encryption usage scenario
(unfortunately, these codes are not open to the public and cannot be given to you),
but its code logic is similar to test_skcipher_vec_cfg() in kernel\crypto\testmgr.c,
and it is also in accordance with this call logic execution:
crypto_alloc_skcipher()--->skcipher_request_alloc()--->crypto_skcipher_setkey()--->
sg_init_table()--->skcipher_request_set_crypt()--->
crypto_skcipher_encrypt()/crypto_skcipher_decrypt()--->
skcipher_request_free()--->crypto_free_skcipher()

Just don't add "wait" and skcipher_request_set_callback(),
use it as a synchronous mode.

Thanks
Longfang.
> Cheers,
> 
