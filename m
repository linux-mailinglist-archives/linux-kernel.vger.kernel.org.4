Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DD76A0C96
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbjBWPJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjBWPJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:09:09 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423BF26CCF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:09:06 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PMxDp4QgqzRs9L;
        Thu, 23 Feb 2023 23:06:18 +0800 (CST)
Received: from [10.174.178.198] (10.174.178.198) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 23 Feb 2023 23:09:03 +0800
Message-ID: <f095ec27-cd35-0d00-3a86-bdff69268371@huawei.com>
Date:   Thu, 23 Feb 2023 23:09:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2] uio:uio_pci_generic:Don't clear master bit when the
 process does not exit
From:   Weifeng Su <suweifeng1@huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <mst@redhat.com>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, <zhanghongtao22@huawei.com>
References: <20230220171045.689736-1-suweifeng1@huawei.com>
 <Y/O32v/KZt+RjoHQ@kroah.com>
 <b6994af6-2274-4671-d156-1609f349804d@huawei.com>
In-Reply-To: <b6994af6-2274-4671-d156-1609f349804d@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.198]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/21 20:48, Weifeng Su wrote:
> On 2023/2/21 2:11, Greg KH wrote:
>> On Tue, Feb 21, 2023 at 01:10:44AM +0800, Su Weifeng wrote:
>>> From: Weifeng Su <suweifeng1@huawei.com>
>>>
>>> The /dev/uioX device has concurrent operations in a few scenarios.
>>>
>>> For example, when a process using the device exits abnormally,
>>> the management program starts the same process to operate the device.
>>> When the process exits and closes the /dev/uioX device,
>>> the master bit of the device is cleared. In this case, if the
>>> new process is issuing commands, I/Os are suspended and cannot be
>>> automatically recovered.
>>>
>>> Therefore, reference counting is added to clear the master bit
>>> only when the last process exits.
>>>
>>> Signed-off-by: Weifeng Su <suweifeng1@huawei.com>
>>> ---
>>> The difference between the first patch and the first patch is that
>>> the reference counting operation is performed using the atomic 
>>> semantics,
>>> just like other drivers under UIO:
>>> cdfa835c6e5e87d145f("uio_hv_generic: defer opening vmbus until first 
>>> use").
>>
>> And I would claim that that change too is incorrect.
>>
>> Did you test this with dup()?  Lots of open/close cycles on the same
>> device node?  Passing around the file descriptor?
> The patch is verified to be able to fix the low-probability problem in 
> our scenario. At the same time, we also perform the dup test on the 
> latest kernel(6.2.0-rc8-g0f5e65cd8f9b-dirty) based on your suggestions. 
> The test code model is as follows:
> ...
> int main()
> {
>          int fd = open("/dev/uio0", O_RDWR);
>          if (fd < 0) {
>                  printf("error in open /dev/uio0\n");
>                  return -1;
>          }
>          int dup_fd = dup(fd);
>          while (true) {
>                  sleep(1);
>          }
> }
> 
> After kill the process, The test results are as follows:
> [  335.730916] swf call uio open
> [  338.307306] swf call uio release
> 
> dup does not cause uio_pci_generic.c:open or uio_pci_generic.c:release 
> reference counting exceptions.
> PS: In this example, a print is added to the entries of uio_open and 
> uio_release of the driver to confirm the function invoking status.
> 
> After reading the "dup" code, we confirm that the struct file uses the 
> f_count protect the same file in the process. The file opened by the 
> "dup" only adds reference counting and does not invoke the open 
> operation of the driver. Disabling the fd only decrementes the f_count 
> count. The release function of the driver is invoked to clear resources 
> only when f_count is 0. Different processes use different struct files 
> to open the same file, and f_count cannot enable the constraint 
> function. In this case, the driver needs to handle the concurrency 
> problem of multiple processes,It's like this patch
> cdfa835c6e5e87d145f("uio_hv_generic: defer opening vmbus until first use")
>>
>> Logically, this is identical to your previous change, so why should it
>> be accepted?
>>
>> Again, why not just use a real PCI driver for your device?
> We use the uio_pci_generic driver because we use the DPDK, which is a 
> user-mode development platform on which you can develop the user-mode 
> driver.
>>
>> thanks,
>>
>> greg k-h
> 
> Best regards,
> Weifeng Su
Hi All,

  Do I need to perform more tests on the patch based on the v2 version to
verify it?

Best regards,
Weifeng Su
