Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C475FE773
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJNDN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiJNDNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:13:22 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AB31A0C00;
        Thu, 13 Oct 2022 20:12:36 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MpWZn742RzDsWX;
        Fri, 14 Oct 2022 11:09:37 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 11:12:11 +0800
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 11:12:10 +0800
Subject: Re: [PATCH] xhci: print warning when HCE was set
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yisen.zhuang@huawei.com>
References: <20220915011134.58400-1-liulongfang@huawei.com>
 <6b5a45f1-caf3-4259-77da-e36788f5b8a9@linux.intel.com>
 <2648444c-2f2a-4d9b-8545-6677663adcf0@huawei.com>
 <8271d551-4034-71fe-5be4-e08e28b6dd6b@linux.intel.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <19ab61d6-c2a2-42be-2bb6-500636868703@huawei.com>
Date:   Fri, 14 Oct 2022 11:12:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8271d551-4034-71fe-5be4-e08e28b6dd6b@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/26 15:58, Mathias Nyman wrote:
> On 24.9.2022 5.35, liulongfang wrote:
>> On 2022/9/22 21:01, Mathias Nyman Wrote:
>>> Hi
>>>
>>> On 15.9.2022 4.11, Longfang Liu wrote:
>>>> When HCE(Host Controller Error) is set, it means that the xhci hardware
>>>> controller has an error at this time, but the current xhci driver
>>>> software does not log this event.
>>>>
>>>> By adding an HCE event detection in the xhci interrupt processing
>>>> interface, a warning log is output to the system, which is convenient
>>>> for system device status tracking.
>>>>
>>>
>>> xHC should cease all activity when it sets HCE, and is probably not
>>> generating interrupts anymore.
>>>
>>> Would probably be more useful to check for HCE at timeouts than in the
>>> interrupt handler.
>>>
>>
>> Which function of the driver code is this timeout in?
> 
> xhci_handle_command_timeout() will usually trigger at some point,
> 

Because this HCE error is reported in the form of an interrupt signal, it is more
concise to put it in xhci_irq() than in xhci_handle_command_timeout().

>>
>>> If this is something seen on actual hardware then it makes sense to add it.
>>>
>>
>> This HCE error is sure to report an interrupt on the chip we are using.
> 
> Ok, then makes sense to add this patch.
> 
> Thanks
> -Mathias
>
Thanks,
Longfang.
> .
> 
