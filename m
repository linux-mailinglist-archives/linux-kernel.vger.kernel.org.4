Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6945F036B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 05:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiI3DsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 23:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiI3DsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 23:48:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E69A1D73DF;
        Thu, 29 Sep 2022 20:48:06 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mdx030mVfzHtpR;
        Fri, 30 Sep 2022 11:43:15 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 11:48:04 +0800
Received: from [10.67.102.118] (10.67.102.118) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 11:48:03 +0800
Subject: Re: [PATCH] crypto/hisilicon: Add null judgment to the callback
 interface
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     <wangzhou1@hisilicon.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220930024320.29922-1-liulongfang@huawei.com>
 <YzZZTsIHLSkuufeb@gondor.apana.org.au>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <717adf23-3080-5041-14ed-6ab5dcaddbf9@huawei.com>
Date:   Fri, 30 Sep 2022 11:48:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YzZZTsIHLSkuufeb@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/30 10:49, Herbert Xu wrote:
> On Fri, Sep 30, 2022 at 10:43:20AM +0800, Longfang Liu wrote:
>> The algorithm acceleration function interface provided by the
>> current crypto subsystem is in asynchronous mode, but some users
>> will call it in synchronous mode, thus not providing a callback
>> interface for the "base.complete" of the request.
> 
> Please give more details.  Who is calling the callback functions
> in synchronous mode?
> 

Even if the task is sent in synchronous mode, when using the hardware
driver, the hardware still informs the driver software through an
interrupt after completing the task, and the workqueue in the driver
software will call this callback function.

And I found that the device drivers of other manufacturers under the
crypto subsystem are also in this asynchronous mode, and this problem
is also encountered when using the synchronous mode.

> Thanks,
> 
Thanks,
Longfang.
