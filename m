Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7260F61F433
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiKGNWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbiKGNW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:22:27 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85971B78B;
        Mon,  7 Nov 2022 05:22:25 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N5WyY3J2TzpWDG;
        Mon,  7 Nov 2022 21:18:45 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 21:22:23 +0800
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 21:22:23 +0800
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
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <d914a099-06ef-acfe-f394-f4790a821598@huawei.com>
Date:   Mon, 7 Nov 2022 21:22:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y2TWpyynYMyStKRX@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

On 2022/11/4 17:08, Herbert Xu wrote:
> On Sat, Oct 29, 2022 at 09:25:18AM +0800, liulongfang wrote:
>>
>> The context of the problem may not have been clearly stated in the previous
>> description.
>>
>> This is a problem found in one of our real user scenarios:
>> In this scenario of using an accelerator to perform encryption  services,
>> it was originally intended to use the CPU to perform encryption services
>> in synchronous mode (without loading the hardware device driver, and without
>> registering the asynchronous callback function), but due to a deployment
>> error, the Hisi hardware device driver was loaded into the system,
>> this wrong operation causes the encryption service to call the device
>> driver of the hisi hardware, but the hardware device driver executes the
>> asynchronous mode, so the callback interface is called after the service
>> is completed.
>> This leads to this system calltrace problem.
>>
>> The purpose of this patch is to ensure that the device does not appear
>> calltrace in this abnormal situation.
> 
> I'm still having trouble understanding this.  Please give an
> exact call-trace that triggers the callback with a NULL callback
> pointer.
> 

What do you need is the log of this call trace?

Kernel log:
 Workqueue: 0000:76:00.0 qm_work_process [hisi_qm]
 pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : 0x0
 lr : sec_skcipher_callback+0x108/0x140 [hisi_sec2]
 sp : ffff80002cda3cb0
 x29: ffff80002cda3cb0 x28: ffff0020a9a56080 x27: ffff2040076a4800
 x26: 0000000000000000 x25: dead000000000100 x24: dead000000000122
 x23: ffff0020881eb4d0 x22: ffff0020960c6f00 x21: ffff0020881eb4b0
 x20: ffff0020881eb478 x19: ffff2040076a4880 x18: 000000000000001c
 x17: 00000000a3f246e1 x16: ffffb38bc5e73d40 x15: 000000006c63877d
 x14: 0000000000000000 x13: 0000000000000000 x12: ffff2040063b1dd0
 x11: ffff2040063b1da8 x10: ffff2040063b1da8 x9 : ffffb38b8da71f78
 x8 : ffff2040063b1dd0 x7 : 0000000000000000 x6 : ffff2040063b1fd0
 x5 : 0000000000000228 x4 : 0000000000000000 x3 : ffff00209ba33000
 x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff2040076a4820
 Call trace:
  0x0
  sec_req_cb+0xc8/0x254 [hisi_sec2]
  qm_work_process+0x1d8/0x330 [hisi_qm]
  process_one_work+0x1e0/0x450
  worker_thread+0x158/0x450
  kthread+0x118/0x120
  ret_from_fork+0x10/0x20
  Code: bad PC value
  ---[ end trace 0000000000000000 ]---

> Thanks,
> 
Thanks,
Longfang.
