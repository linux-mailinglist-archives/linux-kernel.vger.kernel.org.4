Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50285E77FE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiIWKMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiIWKMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:12:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8D8B4B5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:12:05 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYns60tT7zlWjr;
        Fri, 23 Sep 2022 18:07:54 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 18:12:03 +0800
Message-ID: <95e4a84f-dcc6-72cd-69a0-3ba59ea73a9c@huawei.com>
Date:   Fri, 23 Sep 2022 18:12:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] tty: moxa: add missing pci_disable_device()
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <jirislaby@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220923092530.3088080-1-ruanjinjie@huawei.com>
 <Yy2C1gKxIENxMiT3@kroah.com>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <Yy2C1gKxIENxMiT3@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/23 17:56, Greg KH wrote:
> On Fri, Sep 23, 2022 at 05:25:30PM +0800, ruanjinjie wrote:
>> Driver should call pci_disable_device() if it returns from
>> moxa_pci_probe() with error.
> 
> Why?
> 
> That is not a normal thing to do, as you can disable other PCI devices
> attached to it, right?
> 
>> Meanwhile, the driver calls pci_enable_device() in
>> moxa_pci_probe(), but never calls pci_disable_device() during removal.
> 
> And is that really a problem?
> 
>>
>> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
>> ---
>>  drivers/tty/moxa.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Do you have this hardware to test with?
> 
> How did you find this issue?
> 

We use static analysis via coccinelle to find the above issue. The
command we use is below:

spatch -I include -timeout 60 -very_quiet -sp_file
pci_disable_device_missing.cocci drivers/tty/moxa.c

> thanks,
> 
> greg k-h
