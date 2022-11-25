Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B21263857E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 09:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiKYItl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 03:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiKYIti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:49:38 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0765B275DB;
        Fri, 25 Nov 2022 00:49:36 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NJT716Bvhz15Mtp;
        Fri, 25 Nov 2022 16:49:01 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 16:49:35 +0800
Received: from [10.67.103.212] (10.67.103.212) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 16:49:34 +0800
Subject: Re: [PATCH v10 0/3] crypto: hisilicon - supports device isolation
 feature
To:     <gregkh@linuxfoundation.org>, <herbert@gondor.apana.org.au>
References: <20221119074817.12063-1-yekai13@huawei.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>
From:   "yekai (A)" <yekai13@huawei.com>
Message-ID: <9b934709-2f74-7392-aab6-eb506ddcf708@huawei.com>
Date:   Fri, 25 Nov 2022 16:49:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20221119074817.12063-1-yekai13@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.212]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/19 15:48, Kai Ye wrote:
> 1、Add the uacce hardware error isolation interface. Hardware error 
>    thresholds can be configured by sysfs node. User can get the hardware
>    isolated state by sysfs node.
> 2、Defining the isolation strategy for uacce device by uacce sysfs node. 
>    If the number of hardware errors exceeds the configured value, the 
>    uacce device will not be available in user space.
> 3、The ACC VF device use the PF device isolation strategy.
>    
> changes v1->v2:
> 	- deleted dev_to_uacce api.
> 	- add vfs node doc. 
> 	- move uacce->ref to driver.
> changes v2->v3:
> 	- deleted some redundant code.
> 	- use qm state instead of reference count.
> 	- add null pointer check.
> 	- isolate_strategy_read() instead of a copy.
> changes v3->v4:
> 	- modify a comment
> changes v4->v5:
> 	- use bool instead of atomic.
> 	- isolation frequency instead of isolation command.
> changes v5->v6:
> 	- add is_visible in uacce.
> 	- add the description of the isolation strategy file node.
> changes v6->v7
> 	- add an example for isolate_strategy in Documentation.
> changes v7->v8
> 	- update the correct date.
> changes v8->v9
>     - move isolation strategy from qm to uacce.
> changes v9->v10
> 	- Go back to the v8 version of the solution.
> 	- Modify some code according to suggestions.
>
> Kai Ye (3):
>   uacce: supports device isolation feature
>   Documentation: add the device isolation feature sysfs nodes for uacce
>   crypto: hisilicon/qm - define the device isolation strategy
>
>  Documentation/ABI/testing/sysfs-driver-uacce |  18 ++
>  drivers/crypto/hisilicon/qm.c                | 169 +++++++++++++++++--
>  drivers/misc/uacce/uacce.c                   |  50 ++++++
>  include/linux/hisi_acc_qm.h                  |  15 ++
>  include/linux/uacce.h                        |  12 ++
>  5 files changed, 249 insertions(+), 15 deletions(-)
>
Hi Grek

Just a friendly ping.

Thanks
Kai
