Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765636A180F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 09:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjBXIhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 03:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBXIhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 03:37:34 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C5D60D7B;
        Fri, 24 Feb 2023 00:37:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEIiP6svC6AiV8wmYDu/lvedAxA61yuhy4c/fXRi52T0ZYkry0tjyRLpa4j8hxT72LsZKeJEkG9oiTuipsSKVyPtOe3AW9fNiuRBk9tX4Ru3ear3FT4Tt1sAJ7JpRMEDFt5332gRJfZVraN/HQyswHDhWf/+g8QhbIn/Hi6THOU+rP+5tKncEJStTLC0L5MkkcVDpCsokZyWDoELg+D6OQ0isTy3PvC2Rv6Bu+01j0pl42KbNun8kPJ3wpHaERKS67n8bFbgt9tG9MhBb2P4X5dRBqMgeLcalv0AU+P8eITL0UJNc7sBGZWW8xrLGJNEPneT53L3IxZ/AiDexBlx8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFQ7F6lYOK2Ryxr5w3KhSW6CIX3Xln8E7rTXQpepvrA=;
 b=fUOZp4Mh/hzo6cbb6X35fLV6ighiNbBozB9sKZTnMc/VedCOfRYb9twxa6alKSNJ9DSCuZOEGTgfRPc+PNklKTAaL5eGKUmEQf9B8AtbKqTPD9yo3nAO/0HHTaXGqErgraHQKW4Fy8YR/GlmrHWzBtJ/+d85hK3L71QBuL73e9xQAe7/QfytFcYkRPjl0Wcy4HexB77lO4kpA9LKi1p7hnahnfHN5hQ3PrQl2uO8/IEO1LRWa/dt2gXdEW5ytbZ0x+65PSSTIzLk/kDlqjWOEXfWpWK6YpGuZbWgXG1S/UirrJPgrNwFfZpQEZaXWvQbkyrhJlyxk/FrHJvy4nVcvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFQ7F6lYOK2Ryxr5w3KhSW6CIX3Xln8E7rTXQpepvrA=;
 b=KP5ly9TBd8N0I2wtjGXHMirhpGZvE/Gs+GvIZEAtMN1u1Vkexo1UFFFQCkLrGC2ayA2CyQ61SrmoAatZBFRG1u7IvGGNEfYNXJXajV8KbcR+/kM6VHZrhEOnLd+qJRPcMsGPNiljh37xJ2mIfZMTchkbYEOTAbkqp9xtbxwq54o=
Received: from MW4PR03CA0212.namprd03.prod.outlook.com (2603:10b6:303:b9::7)
 by DS0PR12MB6464.namprd12.prod.outlook.com (2603:10b6:8:c4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.24; Fri, 24 Feb 2023 08:37:30 +0000
Received: from CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::93) by MW4PR03CA0212.outlook.office365.com
 (2603:10b6:303:b9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24 via Frontend
 Transport; Fri, 24 Feb 2023 08:37:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT089.mail.protection.outlook.com (10.13.175.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.24 via Frontend Transport; Fri, 24 Feb 2023 08:37:29 +0000
Received: from [10.254.241.51] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Feb
 2023 02:37:19 -0600
Message-ID: <e2ef52ba-7633-3958-4b40-e047a7bba820@amd.com>
Date:   Fri, 24 Feb 2023 09:37:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Tanmay Shah <tanmays@amd.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tanmay Shah <tanmay.shah@amd.com>
CC:     <andersson@kernel.org>, <jaswinder.singh@linaro.org>,
        <ben.levinsky@amd.com>, <shubhrajyoti.datta@amd.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>
References: <20230213211825.3507034-1-tanmay.shah@amd.com>
 <20230213211825.3507034-2-tanmay.shah@amd.com> <20230222173448.GA909075@p14s>
 <b11cd9f2-3759-1df2-ea00-50c574668c28@amd.com>
 <130e75d3-034e-67a2-0c27-0599a996b20f@amd.com>
From:   Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v3 1/3] drivers: mailbox: zynqmp: handle multiple child
 nodes
In-Reply-To: <130e75d3-034e-67a2-0c27-0599a996b20f@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT089:EE_|DS0PR12MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: c0055a05-02b5-4770-de8a-08db16425dbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JQyvfPTA5BDk82N0LGlkjfDmTuVMC8YM23aNChmGKRAZKMbQZ5S5r/uSAqW7MO7DD82BN6xT5zA20UsZRRPRAhqaSrs36kDQqroxNsLuKMd5zSHDyrR6Eo0M5i4zd20rXkUta9X/yA7/jkYt9nw2GrKP4m4egTU8f650tde5PrDNbR41LV9uQBzEJPyza8Gh5EAuEXErUA+i4XbHmraxJmj0tMCp9XfT/IWvDz1UvMnhmJMTv7ApYQdf9r3zONBhjcFGlQsv/N5GiiYpmA7E3S7ORUMio5yB8o+AK6RvSY2GtyJN+OSzQpnfpLoS2y3nkdmst6EqttcposuBpXhQwdFpgL5Fo8tL9zyEFeOEy4iezOwdgwf6CmdUHWU7EqUKoJ9C7wJScO346uIUrFWENMs9amJkfJ6BuzI2/ApPftYudMfGWjSYZtpPMGDQHLwv1x1DmOE1bvuwVevtAZ0jIrPa2kjcG+CStGMn8K/y9uIFsC7OsOPhivdRJjtmqAnnePLGyrmfBJiiY1W5kZwaIAvnaDovXAhv5SGbiDmyvjVD+pmHEY6A05an6jO3Gv8+E1wuC5pW3hHjxLSPVjEoy7bf95r4rN2/I21N2oDXYhPtcuvfctDh/bNZVMFM8B8tSpr4v/vetPvXROIU7Lx+bSicqdbZ9Y5XEdT/6EGCL/VM/KNw8XtcM9cL5IxpAnpq+cTltAKNZDHR5YcUHPVaJAGpkTSf8QNYdCK5xr27b23u9bPF+Ixs6phCgfOsxVAu3mc6b9fETOY2uhtLy41/n1tT9aOKYXaMmtW0u3w7vE0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(478600001)(40460700003)(2616005)(6666004)(70206006)(82310400005)(86362001)(70586007)(31696002)(8676002)(54906003)(6636002)(110136005)(83380400001)(316002)(16576012)(5660300002)(36860700001)(4326008)(44832011)(41300700001)(8936002)(82740400003)(81166007)(336012)(966005)(47076005)(36756003)(426003)(40480700001)(15650500001)(2906002)(356005)(26005)(186003)(31686004)(16526019)(53546011)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 08:37:29.7962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0055a05-02b5-4770-de8a-08db16425dbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6464
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/23 15:47, Tanmay Shah wrote:
> 
> On 2/23/23 1:40 AM, Michal Simek wrote:
>>
>>
>> On 2/22/23 18:34, Mathieu Poirier wrote:
>>> On Mon, Feb 13, 2023 at 01:18:24PM -0800, Tanmay Shah wrote:
>>>> As of now only one child node is handled by zynqmp-ipi
>>>> mailbox driver. Upon introducing remoteproc r5 core mailbox
>>>> nodes, found few enhancements in Xilinx zynqmp mailbox driver
>>>> as following:
>>>>
>>>> - fix mailbox child node counts
>>>>    If child mailbox node status is disabled it causes
>>>>    crash in interrupt handler. Fix this by assigning
>>>>    only available child node during driver probe.
>>>>
>>>> - fix typo in IPI documentation %s/12/32/
>>>>    Xilinx IPI message buffers allows 32-byte data transfer.
>>>>    Fix documentation that says 12 bytes
>>>>
>>>> - fix bug in zynqmp-ipi isr handling
>>>>    Multiple IPI channels are mapped to same interrupt handler.
>>>>    Current isr implementation handles only one channel per isr.
>>>>    Fix this behavior by checking isr status bit of all child
>>>>    mailbox nodes.
>>>>
>>>> Fixes: 4981b82ba2ff ("mailbox: ZynqMP IPI mailbox controller")
>>>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>>>> ---
>>>>
>>>> Changelog:
>>>>    - This is first version of this change, however posting as part of the 
>>>> series
>>>>      that has version v3.
>>>>
>>>> v2: https://lore.kernel.org/all/20230126213154.1707300-1-tanmay.shah@amd.com/
>>>>
>>>>   drivers/mailbox/zynqmp-ipi-mailbox.c       | 8 ++++----
>>>>   include/linux/mailbox/zynqmp-ipi-message.h | 2 +-
>>>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c 
>>>> b/drivers/mailbox/zynqmp-ipi-mailbox.c
>>>> index 12e004ff1a14..b1498f6f06e1 100644
>>>> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
>>>> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
>>>> @@ -152,7 +152,7 @@ static irqreturn_t zynqmp_ipi_interrupt(int irq, void 
>>>> *data)
>>>>       struct zynqmp_ipi_message *msg;
>>>>       u64 arg0, arg3;
>>>>       struct arm_smccc_res res;
>>>> -    int ret, i;
>>>> +    int ret, i, status = IRQ_NONE;
>>>>         (void)irq;
>>>>       arg0 = SMC_IPI_MAILBOX_STATUS_ENQUIRY;
>>>> @@ -170,11 +170,11 @@ static irqreturn_t zynqmp_ipi_interrupt(int irq, void 
>>>> *data)
>>>>                   memcpy_fromio(msg->data, mchan->req_buf,
>>>>                             msg->len);
>>>>                   mbox_chan_received_data(chan, (void *)msg);
>>>> -                return IRQ_HANDLED;
>>>> +                status = IRQ_HANDLED;
>>>>               }
>>>>           }
>>>>       }
>>>> -    return IRQ_NONE;
>>>> +    return status;
>>>>   }
>>>>     /**
>>>> @@ -634,7 +634,7 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
>>>>       struct zynqmp_ipi_mbox *mbox;
>>>>       int num_mboxes, ret = -EINVAL;
>>>>   -    num_mboxes = of_get_child_count(np);
>>>> +    num_mboxes = of_get_available_child_count(np);
>>>>       pdata = devm_kzalloc(dev, sizeof(*pdata) + (num_mboxes * sizeof(*mbox)),
>>>>                    GFP_KERNEL);
>>>>       if (!pdata)
>>>> diff --git a/include/linux/mailbox/zynqmp-ipi-message.h 
>>>> b/include/linux/mailbox/zynqmp-ipi-message.h
>>>> index 35ce84c8ca02..31d8046d945e 100644
>>>> --- a/include/linux/mailbox/zynqmp-ipi-message.h
>>>> +++ b/include/linux/mailbox/zynqmp-ipi-message.h
>>>> @@ -9,7 +9,7 @@
>>>>    * @data: message payload
>>>>    *
>>>>    * This is the structure for data used in mbox_send_message
>>>> - * the maximum length of data buffer is fixed to 12 bytes.
>>>> + * the maximum length of data buffer is fixed to 32 bytes.
>>>>    * Client is supposed to be aware of this.
>>>
>>> I agree that this should be split in 3 patches but the fixes are so small that
>>> it is hardly required.  I'll leave it up to Michal to decide.
>>
>> Generic guidance is saying that you should split that patches. I personally 
>> prefer to have one patch per change. It is useful for bisecting and faster for 
>> reviewing.
>> I would expect that this patch should go via mailbox tree and the rest via 
>> remoteproc tree. That's why maintainer should say what it is preferred way.
>>
> 
> Thanks Michal for reviews. I will split the patch in three different patches.
> 
> 
>> In connection mailbox. I recently had some time to look at this driver and I 
>> didn't really get why there are registers listed. Because all that addresses 
>> can be calculated based on soc compatible string and by xlnx,ipi-id for both 
>> sides.
> 
> 
> Yes the IPI configuration register addresses are retrieved from TF-A in 
> zynqmp-ipi-driver using xlnx,ipi-id property.
> 
> Other than that there are message buffers provided in hardware for IPI 
> communication. We list those message buffer addresses
> 
> using reg addresses and they are expected in dts. As per bindings we do not map 
> message buffers to IPI ID.
> 
> I am not sure which register listing you are referring to ?

Based on
https://docs.xilinx.com/r/en-US/am011-versal-acap-trm/Message-Buffer

xlnx,ipi-id = 2 (versal case) APU
pmu1 has xlnx,ipi-id = 1; PMC

Base on versal is 0xFF3F0000

Local buffers for sending from 2 -> 1
Buffer 2 starts at offset 0x400

Order in destination is PSM, PMC, IPI0... where you have request 32B and 
response 32B too.

It means 2->1 - target is PMC
that means 0x40 for request 0x60 for response.

When this is put together

0xff3f0000 + 0x400 + 0x40 = ff3f0440 - local request
0xff3f0000 + 0x400 + 0x60 = ff3f0460 - local response

For the way back from 1->2
Buffer one starts at 0x200
I want to send it to APU which we use channel 2 for.
Channel 2 start at ID * 0x40 = 0x80 is for request
0x80 + 32 = 0xa0 for response

It means 2->1 - target is APU at ID 2
0xff3f0000 + 0x200 + 0x80 = ff3f0280 - remote request
0xff3f0000 + 0x200 + 0xa0 = ff3f02a0 - remote response

Based on this you see that reg/reg names property are pretty much useless and 
should be removed from dt binding document because simply base and source ipi-id 
and destination ipi-id will tell you which addresses should be used.

As far as I know ZynqMP is using the same logic. The only difference is really 
just different base address for buffers.

That's why I think the DT node should be just like this and all addresses

Versal
         versal_ipi {
                 compatible = "xlnx,versal-ipi-mailbox";
                 interrupt-parent = <&gic>;
                 interrupts = <0 30 4>;
                 xlnx,ipi-id = <2>;

                 ipi_mailbox_pmu1: mailbox {
                         #mbox-cells = <1>;
                         xlnx,ipi-id = <1>;
                 };
         };

Where different compatible string will ensure that base address is assigned 
based on SOC.

Thanks,
Michal
