Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB683626644
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 02:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbiKLBwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 20:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKLBwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 20:52:01 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2DD6A747;
        Fri, 11 Nov 2022 17:51:59 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N8JQF5WYdzJnfp;
        Sat, 12 Nov 2022 09:48:53 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 09:51:56 +0800
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 09:51:56 +0800
Subject: Re: [PATCH] crypto/hisilicon: Add null judgment to the callback
 interface
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     <wangzhou1@hisilicon.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <Y1tTLAEi7ukUCCmB@gondor.apana.org.au>
 <a1229856-fbe4-9ae7-5789-332ed0af87eb@huawei.com>
 <Y2TWpyynYMyStKRX@gondor.apana.org.au>
 <d914a099-06ef-acfe-f394-f4790a821598@huawei.com>
 <Y2oodE+5us++mbSl@gondor.apana.org.au>
 <df561fbe-12eb-25b0-2173-a7ffb3bfd53a@huawei.com>
 <Y2twbHyQkTMoTz+O@gondor.apana.org.au>
 <32686c5b-04b2-7103-bf2e-113db2315ef4@huawei.com>
 <Y2xt7/6WGN+uthpL@gondor.apana.org.au>
 <40a0e7aa-362a-0de7-76c0-77381c07f254@huawei.com>
 <Y2y78USk4bXRrRun@gondor.apana.org.au>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <54c1aa3a-9e51-a90f-416a-dc65a70a1b8a@huawei.com>
Date:   Sat, 12 Nov 2022 09:51:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y2y78USk4bXRrRun@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2022/11/10 16:53, Herbert Xu wrote:
> On Thu, Nov 10, 2022 at 12:11:15PM +0800, liulongfang wrote:
>>
>> When using crypto's skcipher series interfaces for encryption and decryption
>> services, User can use synchronous mode(by adjusting some skcipher interfaces,
>> here is to remove skcipher_request_set_callback()) or asynchronous mode,
>> but when using synchronous mode and the current asynchronous mode is loaded
>> it will cause a calltrace.
>>
>> The current problem is that the interface of skcipher does not restrict users
>> to call functions in this way for encryption services.
>>
>> If the current driver doesn't handle this, there is a possibility that some users
>> deliberately create this kind of problem to cause the kernel to crash.
> 
> It sounds like your code is misusing the skcipher API.  By default
> skcipher is always async.  You must always set a callback.
> 
> The only way to legally use skcipher without setting a callback
> is by allocating it with crypto_alloc_sync_skcipher.  In which case

OK! I found in Documentation/crypto/architecture.rst the description
that async mode must provide a callback function.

However, what is confusing is that this document does not describe
the synchronization mode so clearly.

> unless your driver incorrectly declares itself as sync instead of
> async, then it will never be used by such a user.
> 
> Cheers,
> 
Thanks,
Longfang.

