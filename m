Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332AA620F28
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbiKHLeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbiKHLeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:34:03 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08391AF3B;
        Tue,  8 Nov 2022 03:34:01 -0800 (PST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N65b03jzhz15MR4;
        Tue,  8 Nov 2022 19:33:48 +0800 (CST)
Received: from [10.67.100.231] (10.67.100.231) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 19:33:59 +0800
Subject: Re: [External] : Re: [PATCH] scsi: libsas: Check and update the link
 rate during discovery
To:     John Garry <john.g.garry@oracle.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
References: <20221102100555.3537275-1-liyihang9@huawei.com>
 <90217102-8767-b077-2615-1a5e41b58660@oracle.com>
 <43f496c4-4808-bee2-5a67-93e1114f646a@huawei.com>
 <6971d59e-2a72-2812-d289-53e61121f35a@oracle.com>
CC:     <bvanassche@acm.org>, <chenxiang66@hisilicon.com>,
        <daejun7.park@samsung.com>, <damien.lemoal@opensource.wdc.com>,
        <yanaijie@huawei.com>, <duoming@zju.edu.cn>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <prime.zeng@hisilicon.com>, <yangxingui@huawei.com>,
        <linuxarm@huawei.com>, <liyihang9@huawei.com>
From:   Yihang Li <liyihang9@huawei.com>
Message-ID: <24916311-2a46-4673-7f79-f0bbd20b0bfe@huawei.com>
Date:   Tue, 8 Nov 2022 19:33:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <6971d59e-2a72-2812-d289-53e61121f35a@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.100.231]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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



On 2022/11/7 20:44, John Garry wrote:
> 
>>>>
>>>> SATA disk which connected to expander PHY maybe reject IO request due to
>>>> the connection setup error (OPEN_REJECT-CONNECTION RATE NOT SUPPORTED).
>>>> The log as follows:
>>>>
>>>> [175712.419423] hisi_sas_v3_hw 0000:74:02.0: erroneous completion iptt=2985 task=00000000268357f1 dev id=10 exp 0x500e004aaaaaaa1f phy9 addr=500e004aaaaaaa09 CQ hdr: 0x102b 0xa0ba9 0x1000 0x20000 Error info: 0x200 0x0 0x0 0x0
>>>>
>>>> After analysis, it is concluded that: when one of the physical links
>>>> connected on the wide port is re-established, the link rate of the port
>>>> and expander device and the expander SATA PHY are not updated. As a
>>>> result, the expander PHY attached to a SATA PHY is using link rate
>>>> (6.0 Gbit) greater than the physical PHY link rate (3.0 Gbit).
>>>
>>> Please mention the SAS spec section in which min pathway is described.
>>
>> Do you mean the original text of the SAS spec section needs to be added here?
>>
> 
> I mean to at least mention the spec version and section number and title (in that spec version).

ok

> 
>> Like this:
>>
>> According to Serial Attached SCSI:
>> If an STP initiator port discovers a SATA device behind an STP/SATA bridge with a physical link rate greater
>> than the maximum connection rate supported by the pathway from the STP initiator port, the STP initiator port
>> should use the SMP PHY CONTROL function (see 10.4.3.10) to set the MAXIMUM PHYSICAL LINK RATE field of
>> the expander phy attached to the SATA device to the maximum connection rate supported by the pathway.
> 
> I think that this condition in the spec is a flaw. Or at least annoying.
> 
>>
>>>
>>>>
>>>> Therefore, add function sas_check_port_linkrate() to check whether the
>>>> link rate of physical PHY which is connected to the wide port changes
>>>> after the phy up occur, if the link rate of the newly established
>>>> physical phy is lower than the link rate of the port, a smaller link rate
>>>> value is transmitted to port->linkrate.
>>>>
>>>> Use the sas_update_linkrate_root_expander() function to update the root
>>>> expander link rate. Traverse all expanders connected to the port, check
>>>> and update expander PHYs that need to be updated and triggers revalidation.
>>>
>>> So are you saying that you want to lower the linkrate on all pathways to the SATA disk? In your example, that would be 3Gbps. If so, won't that affect the end-to-end linkrate of all other devices attached (and lower throughput drastically)?
>>
>> Yes, this will lower performance drastically, but I consider the following two things:
>>
>> a. Ensure that all disks work properly when the issue we discussed occurs.
>>
>> b. When the user limits the linkrate to a lower level through the sysfs interface, the linkrate on all pathways to the SATA disk should be reduced.
>>
>> [root@localhost phy-5:0]# lsscsi
>> [5:0:0:0]    disk    HUAWEI   HWE32SS3008M001N 2774  /dev/sda
>> [5:0:1:0]    disk    ATA      ST4000NM0035-1V4 TN03  /dev/sdb
>> [5:0:12:0]   enclosu HUAWEI   Expander 12Gx16  131   -
>> [root@localhost phy-5:0]# cat maximum_linkrate
>> 12.0 Gbit
>> [root@localhost phy-5:0]# cat minimum_linkrate
>> 1.5 Gbit
>> [root@localhost phy-5:0]# echo 1.5 Gbit > maximum_linkrate
>> [root@localhost phy-5:0]# cat negotiated_linkrate
>> 1.5 Gbit
>> [root@localhost phy-5:0]# lsscsi
>> [5:0:0:0]    disk    HUAWEI   HWE32SS3008M001N 2774  /dev/sda
>> [5:0:12:0]   enclosu HUAWEI   Expander 12Gx16  131   -
>> [5:0:13:0]   disk    ATA      ST4000NM0035-1V4 TN03  /dev/sdb
>> [root@localhost phy-5:0]# cd ../phy-5\:0:1
>> [root@localhost phy-5:0:1]# cat negotiated_linkrate
> 
> So do we reset the linkrate of the SATA-attached phy, right? Could that cause the disk to be lost and found again? If so, doesn't seem useful if that disk had a filesystem mounted...

Yes, the disk will be lost and found again, and I don't think of a good solution for disk with a filesystem mounted, perhaps the way you mentioned disable that phy does solve this issue.

> 
>> 1.5 Gbit
>>
>>
> 
> I just wonder if it is better to disable that phy altogether rather than drag every other pathway down to this lower linkrate:
> 
> a. that would be simpler than trying to maintain this min pathway
> b. the condition that gives rise to issue is very rare (so don't need to burden libsas with supporting it according to the spec).

However, if the user decreases the linkrate through the sysfs interface, the corresponding phy is disabled, which seems to violate the user's intention.

So I think the libsas layer lacks a mechanism to detect linkrate changes and reduce the linkrate of all SATA-attached phys, whether due to active or passive linkrate changes, and my patch amounts to adding this mechanism.

In other words, it is better to disable the phy in abnormal scenarios. On the other hand, a new mechanism needs to be established to detect and reset the phy if the user actively changes the link rate?

Thanks,
Yihang
