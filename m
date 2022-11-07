Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FCE61F239
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiKGLwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiKGLwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:52:08 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF52219C1A;
        Mon,  7 Nov 2022 03:52:06 -0800 (PST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N5Tz52tHkzJnT5;
        Mon,  7 Nov 2022 19:49:05 +0800 (CST)
Received: from [10.67.100.231] (10.67.100.231) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 19:52:04 +0800
Subject: Re: [PATCH] scsi: libsas: Check and update the link rate during
 discovery
To:     John Garry <john.g.garry@oracle.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
References: <20221102100555.3537275-1-liyihang9@huawei.com>
 <90217102-8767-b077-2615-1a5e41b58660@oracle.com>
CC:     <bvanassche@acm.org>, <chenxiang66@hisilicon.com>,
        <daejun7.park@samsung.com>, <damien.lemoal@opensource.wdc.com>,
        <yanaijie@huawei.com>, <duoming@zju.edu.cn>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <prime.zeng@hisilicon.com>, <yangxingui@huawei.com>,
        <linuxarm@huawei.com>, <liyihang9@huawei.com>
From:   Yihang Li <liyihang9@huawei.com>
Message-ID: <43f496c4-4808-bee2-5a67-93e1114f646a@huawei.com>
Date:   Mon, 7 Nov 2022 19:52:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <90217102-8767-b077-2615-1a5e41b58660@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.100.231]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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



On 2022/11/2 19:55, John Garry wrote:
> On 02/11/2022 10:05, Yihang Li wrote:
> 
> note: This is not discovery in which this erroneous condition occurs. Discovery is the phase in which the device is found initially.

ok, I will change the description in the next version.

> 
>>     +----------+              +----------+
>>     |          |              |          |
>>     |          |--- 12.0 G ---|          |--- 12.0 G --- SAS  disk
>>     |initiator |              | Expander |
>>     | device   |--- 12.0 G ---|          |--- 12.0 G --- SAS  disk
>>     |          |              |          |
>>     |          |--- 12.0 G ---|          |--- 6.0 G --- SATA disk
>>     |          |              |          |
>>     |      phy0|--- 12.0 G ---|          |--- 6.0 G --- SATA disk
>>     |          |              |          |
>>     +----------+              +----------+
>>
>> In the scenario where the expander device is connected to a wide port,
>> the preceding figure shows the link topology after initialization.
>> All physical PHYs negotiate connections at the rate of 12 Gbit, and
>> the expander SATA PHY negotiates connections at the rate of 6 Gbit.
>>
>> We found that when the FIO was running, if phy0 was link down due to link
>> instability, and the link connection was reestablished after a period of
>> time. During the physical link disconnection, the physical PHY gradually
>> decreases the link rate, attempts to renegotiate the link rate and
>> establish the connection. This is an HW behavior. When the physical PHY
>> try to re-establish the link at a link rate of 3 Gbit and the physical
>> link is successfully established, the negotiated link rate is 3 Gbit.
>> Like this:
>>
>>     +----------+              +----------+
>>     |          |              |          |
>>     |          |--- 12.0 G ---|          |--- 12.0 G --- SAS  disk
>>     |initiator |              | Expander |
>>     | device   |--- 12.0 G ---|          |--- 12.0 G --- SAS  disk
>>     |          |              |          |
>>     |          |--- 12.0 G ---|          |--- 6.0 G --- SATA disk
>>     |          |              |          |
>>     |      phy0|--- 3.0 G ----|          |--- 6.0 G --- SATA disk
>>     |          |              |          |
>>     +----------+              +----------+
>>
>> SATA disk which connected to expander PHY maybe reject IO request due to
>> the connection setup error (OPEN_REJECT-CONNECTION RATE NOT SUPPORTED).
>> The log as follows:
>>
>> [175712.419423] hisi_sas_v3_hw 0000:74:02.0: erroneous completion iptt=2985 task=00000000268357f1 dev id=10 exp 0x500e004aaaaaaa1f phy9 addr=500e004aaaaaaa09 CQ hdr: 0x102b 0xa0ba9 0x1000 0x20000 Error info: 0x200 0x0 0x0 0x0
>>
>> After analysis, it is concluded that: when one of the physical links
>> connected on the wide port is re-established, the link rate of the port
>> and expander device and the expander SATA PHY are not updated. As a
>> result, the expander PHY attached to a SATA PHY is using link rate
>> (6.0 Gbit) greater than the physical PHY link rate (3.0 Gbit).
> 
> Please mention the SAS spec section in which min pathway is described.

Do you mean the original text of the SAS spec section needs to be added here?

Like this:

According to Serial Attached SCSI:
If an STP initiator port discovers a SATA device behind an STP/SATA bridge with a physical link rate greater
than the maximum connection rate supported by the pathway from the STP initiator port, the STP initiator port
should use the SMP PHY CONTROL function (see 10.4.3.10) to set the MAXIMUM PHYSICAL LINK RATE field of
the expander phy attached to the SATA device to the maximum connection rate supported by the pathway.

> 
>>
>> Therefore, add function sas_check_port_linkrate() to check whether the
>> link rate of physical PHY which is connected to the wide port changes
>> after the phy up occur, if the link rate of the newly established
>> physical phy is lower than the link rate of the port, a smaller link rate
>> value is transmitted to port->linkrate.
>>
>> Use the sas_update_linkrate_root_expander() function to update the root
>> expander link rate. Traverse all expanders connected to the port, check
>> and update expander PHYs that need to be updated and triggers revalidation.
> 
> So are you saying that you want to lower the linkrate on all pathways to the SATA disk? In your example, that would be 3Gbps. If so, won't that affect the end-to-end linkrate of all other devices attached (and lower throughput drastically)?

Yes, this will lower performance drastically, but I consider the following two things:

a. Ensure that all disks work properly when the issue we discussed occurs.

b. When the user limits the linkrate to a lower level through the sysfs interface, the linkrate on all pathways to the SATA disk should be reduced.

[root@localhost phy-5:0]# lsscsi
[5:0:0:0]    disk    HUAWEI   HWE32SS3008M001N 2774  /dev/sda
[5:0:1:0]    disk    ATA      ST4000NM0035-1V4 TN03  /dev/sdb
[5:0:12:0]   enclosu HUAWEI   Expander 12Gx16  131   -
[root@localhost phy-5:0]# cat maximum_linkrate
12.0 Gbit
[root@localhost phy-5:0]# cat minimum_linkrate
1.5 Gbit
[root@localhost phy-5:0]# echo 1.5 Gbit > maximum_linkrate
[root@localhost phy-5:0]# cat negotiated_linkrate
1.5 Gbit
[root@localhost phy-5:0]# lsscsi
[5:0:0:0]    disk    HUAWEI   HWE32SS3008M001N 2774  /dev/sda
[5:0:12:0]   enclosu HUAWEI   Expander 12Gx16  131   -
[5:0:13:0]   disk    ATA      ST4000NM0035-1V4 TN03  /dev/sdb
[root@localhost phy-5:0]# cd ../phy-5\:0:1
[root@localhost phy-5:0:1]# cat negotiated_linkrate
1.5 Gbit


Thanks,
Yihang

> 
> 
> 
> .
> 
