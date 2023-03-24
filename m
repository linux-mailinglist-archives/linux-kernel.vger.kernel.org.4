Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9326C7528
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 02:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCXBly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 21:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCXBlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 21:41:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C8D40C0;
        Thu, 23 Mar 2023 18:41:50 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PjPyV3RdwzKrWD;
        Fri, 24 Mar 2023 09:39:30 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 09:41:48 +0800
Subject: Re: [PATCH] scsi: fix hung_task when change host from recovery to
 running via sysfs
To:     Mike Christie <michael.christie@oracle.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Ye Bin <yebin@huaweicloud.com>
References: <20230321084204.1860900-1-yebin@huaweicloud.com>
 <20230321142237.GC311313@t480-pf1aa2c2.fritz.box>
 <641A58D0.1020205@huawei.com>
 <1df01cd0-e56e-b615-9418-e3fd69819798@oracle.com>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <641CFFDC.2040201@huawei.com>
Date:   Fri, 24 Mar 2023 09:41:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <1df01cd0-e56e-b615-9418-e3fd69819798@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/24 0:12, Mike Christie wrote:
> On 3/21/23 8:24 PM, yebin (H) wrote:
>>
>> On 2023/3/21 22:22, Benjamin Block wrote:
>>> On Tue, Mar 21, 2023 at 04:42:04PM +0800, Ye Bin wrote:
>>>> From: Ye Bin <yebin10@huawei.com>
>>>>
>>>> When do follow test:
>>>> Step1: echo  "recovery" > /sys/class/scsi_host/host0/state
>>> Hmm, that make me wonder, what potential use-case this is for? Just
>>> testing?
>> Thank you for your reply.
>> Actually, I'm looking for a way to temporarily stop sending IO to the driver.
> Is this just for testing something or does a user/app need this
> functionality for something?

This can be used to store IO in the block layer, enabling some fault recovery
that is insensitive to the upper layer.Also want to use this state to test the
block layer.

> We used to be able to block specific devices but we removed that.
> It was useful for people like us where we need to do some low kernel
> testing like testing for how upper layers handle IO hangs, but I
> think it was not useful for other users so it was removed.
>
> .
>

