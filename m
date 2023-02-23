Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CBA6A0C23
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbjBWOrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBWOrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:47:42 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D3858B53;
        Thu, 23 Feb 2023 06:47:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AChyQ6cc6N61jW1jfA+mg0Ig9okBcbwuHd7qsDn/ImMODd4O4GdY7j2E7ZXhOvkpdUQem004rjcEfmfIXB9CRq2UfSNgS6Y1PlHvXek2COMvAdj07tA21T27KouCHRw0CxN1cqV53Gbu/RwSH0VTBST50bklGujwI1RwzYRtsaQisjMDcqpXnsWI7Mui154u4FdaZuQe48LC8in1b2sBAHqY2s/4KvavdmZkpwMCePqS9Ha4jStQEhUUb+FU7873YS2zDLqhvCRGx7HRdgIcqFG5Sgv8p2geDzovcIo7/QlEKHtFpM0mmLlxsymjOu0AnauJF3ptcXuz+KNv7ezQXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+pjJW5RP4bluvAlDBcMGDMArZDI28651qX5gCd+4p0=;
 b=HCehJtRTV/iggSBDtxjPaMez78OVOMO4SxyJCw2FB92gxDwUFS9kqooMM2YepKIXwJLLKQBbI2uC1d1rWtWGzjnpT0HHMuVxgFsbxpOF2+PLUGgAfZNVK1T4w3E3CVGVhlAYG3GzB27bpkStZecBwGOGfBHtK357k4OH/Bi3VyKAU2zL1nOaGhIm5WejrTY6vUB3kM3yUWbZiRRgwkFUjNAC2fqs/0Xd3uyw3mYZzXMf3e23FkRw3DCR26urdkiMSQNw6R3FQVUk5/wqUWxOGSMCHSgh3o6n92Szu7+bRlIf8TXHPd7UaiIxmDew5QmA9RKcB+JP3RJuEWDNSkqUgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+pjJW5RP4bluvAlDBcMGDMArZDI28651qX5gCd+4p0=;
 b=Bmdj3EI/o3Q7jYHkbVfmd3OujXg+xZSqKPqB5glFSDbx0uz7U2ARpQ/DGkOMqERkjL23Iin87LogmSXurZ7bmRQnuVuSOseIICSMWvCsDjrokyteO8SEcbKsW9uQEsEdLhNNC1b5W/8b86kFMh76vwhBLW43paF7ffNWZP95te8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 14:47:37 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3ddf:d47:b37a:5a7a]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3ddf:d47:b37a:5a7a%4]) with mapi id 15.20.6134.021; Thu, 23 Feb 2023
 14:47:37 +0000
Message-ID: <130e75d3-034e-67a2-0c27-0599a996b20f@amd.com>
Date:   Thu, 23 Feb 2023 08:47:35 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:110.0)
 Gecko/20100101 Thunderbird/110.0
Subject: Re: [PATCH v3 1/3] drivers: mailbox: zynqmp: handle multiple child
 nodes
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Cc:     andersson@kernel.org, jaswinder.singh@linaro.org,
        ben.levinsky@amd.com, shubhrajyoti.datta@amd.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
References: <20230213211825.3507034-1-tanmay.shah@amd.com>
 <20230213211825.3507034-2-tanmay.shah@amd.com> <20230222173448.GA909075@p14s>
 <b11cd9f2-3759-1df2-ea00-50c574668c28@amd.com>
From:   Tanmay Shah <tanmays@amd.com>
In-Reply-To: <b11cd9f2-3759-1df2-ea00-50c574668c28@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:74::34) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|IA0PR12MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b62b36-6ebe-434a-4a1e-08db15ace80b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mGbC7Wx3PkIfbW+pe+AW9L1+ghk2yVx+sa/P+quBXCkZ893dZCXHTbU9WSN4pys4WyHjjkJMlo9tLXgo6i8TlyDyLlM/7gP04QRnm+80VVW28PAKSIh6hY0meNKF+Y9StEEcbmQurbvhtlSqnhk5hMxpV5Lyh7vx0TSv4STBZJKbun8Moq7iKbB1ibGuclNnhh/Ff3UgCwqGcciJpE9nXhPo44CYwJplyzSmgP88hUEBtMHJU7+5v58nYrFZ7TsmxPMMkEsiBOeEmMCutzNejx6iY2rRk9t3tBYmuXugdnMEFbK2/kpTpgbRljrCukFitQr9gZfuy7I8VhphZNGysXLmLtpSOxwb8y8lgj8B2LEsgQE/B7SwgJJYxz0J++mECRz/O7H5nUMVp4NIDDeqzWHEvAv99XKUmdCOkphREt2AhpYPz8joovpWspoHOVZrq4hO7iKsx00rgfWBOyrcmoJaAKsMW0+RC/h/ErZZoSCdgqQaBOsKAHvdSEVB95p+Q4BL5XrPAdiGkiXjrIZtA7YehEhsyIppUUnkvQywRlURMTZFVbSQgS6gBHOUA2akccoQISupjWK6UhQxGQm6wJ4Q+hgK6BPjfcpzUW/D04dqwAiV417oo952pOz3vTBpwqqDa1XVI2sifdU7yNJaCj0Um2uWWV1jRd7ibSHcXoOZm/joEE/B5E4aVv6IkKIq+qqxLtxDMK65yuTUbIRtp+3taE8/Q2XuzKNrpAcBJzw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199018)(5660300002)(8936002)(41300700001)(31696002)(36756003)(2906002)(15650500001)(38100700002)(2616005)(6486002)(966005)(66476007)(478600001)(6512007)(53546011)(186003)(66556008)(31686004)(66946007)(6506007)(316002)(83380400001)(6636002)(110136005)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVBYbnNHOXRSaUNqK3J6QWJkb2tPb3I4b0I0cjNZT3B6cDZ4TjFjQkpGY1M2?=
 =?utf-8?B?cnF5YXozWGdXS0NpUzllTk92VW9GcU43Nll3d1hTUDBGMkllVFEvbUttRHU0?=
 =?utf-8?B?b1JLTUNJb3BCUFl4UUk0bjdZYW55SVpjQm9od041dGlFYWVGVXNCenFwUndD?=
 =?utf-8?B?Z01leGljUmc1TzBtTE9lNDlld0xaRHdkTkIvNTdSQ2pPWmVYcXhkc3NodGlQ?=
 =?utf-8?B?OHVVazRWN0Q0MENxUG8xZ0NOeHg0M3J2bDBOQ1BsZGlJaXJNdDJYYzhFWWRB?=
 =?utf-8?B?ZEZqcVFURHdsUXZYSE14L0xrYUlNakVXeFd6Z2VmdHFNWWVpUXRSdFd3NkNE?=
 =?utf-8?B?VXBSK3hmRXhGaWlySDZSSkRNYVFiQUhqSzhDUGtiZEZEN3JOQzdqTHNBcEpB?=
 =?utf-8?B?bW5ISDdXT2VYZ1A3d0RCb3AybGM0VUlyM3ZxMVBSR0o5dnpqWHZ2MnVtOUM5?=
 =?utf-8?B?VkZNOUJoWkppUDJSUVpRNWNpcDNPRHpkczN1ajFZNTNqeDczTUFhQ1BtWnV1?=
 =?utf-8?B?cWxVV0pNQzBJcGw3V0RLZHhGN2xueFhuMzV2RmxIYStNaHhmcVh0ekhMZVFv?=
 =?utf-8?B?bXA0elM0ejBqNFZ6OWZ1ZFBpM3lGMFdoenlTQlk0c1l2Ulpram1HTkYxWHFl?=
 =?utf-8?B?dGJzNnVZRU53c3FPa3FVb3JTRVUzajNKNFRkNzBWZlVFSkQ3OG93OHg5Tjd5?=
 =?utf-8?B?dFZyZmkyQVRvOVNQdzFjYUxoeTBZYWMwbjkyQmFsck90Lzk0c3FmWUN0RUNH?=
 =?utf-8?B?dnNGanF1R041RWFPeDdjV09TWW1PMkpidlFGMlBLbWZIL1B3cU85aHdPZ3Vo?=
 =?utf-8?B?dlk3bzRqTXk2NkRCLzBOMUdwVitqTlRoUW51cEhTVjJUL090QnlZOWlQc0dI?=
 =?utf-8?B?VzZGejl2RWFMNXZXVzQrUHAzclkwMDZkY2VPQ0tmbTBTc3pCeW4wT0pwbG9m?=
 =?utf-8?B?YU5nUTdFNGVQQlI1SzdTWUFVaDdKeFQveVB4K0o2K1Z1VlJNMXE5Tll4WGFR?=
 =?utf-8?B?VjZmZ0QrY0Fod2pmT0tWOWdMakRmNmdqaDczcWJrNUNONWZoOEQwZXpmL3Ix?=
 =?utf-8?B?QWhmd1NUK1FUUHdUTkFLenlicDlyZGlTSWs2QS8va0s5VEZndHhjcmNod0FC?=
 =?utf-8?B?QkorT2I2Qm1pQWxJQVU2cENoSld0YTUyM3AzM2JEODV4SGUrZDE5Szk2MnNE?=
 =?utf-8?B?ZGd6cnFLOWpraWtJQmR6TnMvSDNHN2lTVHBieDZmTWZVTWU0SFNyQy9DQVlC?=
 =?utf-8?B?NExhK0hCTlhlcmNKM1k1bEIvUXZTWE9ySVFCWURpRWYyN0NGSmF3SjYzN3ln?=
 =?utf-8?B?MXJYZzhGTGZGWklqNDFhT3hrRkhhanc4V1hXODN1eE5mQlkxVWxhRnRDVkJj?=
 =?utf-8?B?cEhaM0FpZHM5WjJ3K1hjYWtESlFXQktxSER4Slkvc2ovaCtqVytiaFlEZG01?=
 =?utf-8?B?SzB4ZEdIc1V0czVRdFo5b3NPNWdRYkM3SDBidm96WUFodHFLS0U4Sk5NdWNs?=
 =?utf-8?B?cTRoQ2doWVh6dkR4ZExJM0RPVlowQlpVbHYxbmJHT2s3dG1TbmRzYTNtTURz?=
 =?utf-8?B?eGdVQ3FXWjJoanF4VGYvb0pkNEhxT2RIQXExaWtrM0RTdnU5MlpXY3VyZVRo?=
 =?utf-8?B?U2hNU0NOVDhJZVc4YThPV282WkMraXZYWXZzSVRraEoxbzIwTEhKUHJ5Witw?=
 =?utf-8?B?QlYxR3ZqV0VqWDlBMWJSWjZGeFgrUnJzdTBBVmkyUnhzMHJFL25tWjJGdGhw?=
 =?utf-8?B?WjNOS2J2RkNQMmx3ejRMSFFIZDg1YnU0UGxrK2RMVCtZVEE2VlI3QmpUNm9W?=
 =?utf-8?B?RUNwY3pqSEdaaVptUDgwd3lmcFBONDRCaVBNZkZzNmpKU0NXZDlWNk5nWlFJ?=
 =?utf-8?B?dU1LNXQyWStxdFFuMXBDUlBXb0xjc2dCRHR0QmJscEpmNTUwQ2Q2VmROQXhY?=
 =?utf-8?B?YW5adFdvQzlpU3ozYUViTmw5TU4vNldoNEdtR2xTdHZaQ055KzdiblVjMGty?=
 =?utf-8?B?cm5VWjdHWlR5UGtXU2plbjUyNGxJbjA2NG8xTHdNMzROangwRTAzMlVyUVl5?=
 =?utf-8?B?V1dmUklRR3Bvd2NkVHNQNnF1YjJoK3JxaWVsK1ZENzBKck5yVXpzK0cxd050?=
 =?utf-8?B?NlZiZ2hIbHc4eldpRVpkdjZ0bEJyNDgyUy9qc0ZwVElYVUJYa09xMDJJQmh1?=
 =?utf-8?Q?gU8s5s6UL4m0aQTNSnrxbVZbksMxuxzh7uqYlfcSV9UN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b62b36-6ebe-434a-4a1e-08db15ace80b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 14:47:37.6544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmFrstHgNvodDC7RNDGZpDW0dtl/Tos6C8YjiAdV/OJ8+9reLmLfcZyW4L6K2SiQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8301
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/23/23 1:40 AM, Michal Simek wrote:
>
>
> On 2/22/23 18:34, Mathieu Poirier wrote:
>> On Mon, Feb 13, 2023 at 01:18:24PM -0800, Tanmay Shah wrote:
>>> As of now only one child node is handled by zynqmp-ipi
>>> mailbox driver. Upon introducing remoteproc r5 core mailbox
>>> nodes, found few enhancements in Xilinx zynqmp mailbox driver
>>> as following:
>>>
>>> - fix mailbox child node counts
>>>    If child mailbox node status is disabled it causes
>>>    crash in interrupt handler. Fix this by assigning
>>>    only available child node during driver probe.
>>>
>>> - fix typo in IPI documentation %s/12/32/
>>>    Xilinx IPI message buffers allows 32-byte data transfer.
>>>    Fix documentation that says 12 bytes
>>>
>>> - fix bug in zynqmp-ipi isr handling
>>>    Multiple IPI channels are mapped to same interrupt handler.
>>>    Current isr implementation handles only one channel per isr.
>>>    Fix this behavior by checking isr status bit of all child
>>>    mailbox nodes.
>>>
>>> Fixes: 4981b82ba2ff ("mailbox: ZynqMP IPI mailbox controller")
>>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>>> ---
>>>
>>> Changelog:
>>>    - This is first version of this change, however posting as part 
>>> of the series
>>>      that has version v3.
>>>
>>> v2: 
>>> https://lore.kernel.org/all/20230126213154.1707300-1-tanmay.shah@amd.com/
>>>
>>>   drivers/mailbox/zynqmp-ipi-mailbox.c       | 8 ++++----
>>>   include/linux/mailbox/zynqmp-ipi-message.h | 2 +-
>>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c 
>>> b/drivers/mailbox/zynqmp-ipi-mailbox.c
>>> index 12e004ff1a14..b1498f6f06e1 100644
>>> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
>>> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
>>> @@ -152,7 +152,7 @@ static irqreturn_t zynqmp_ipi_interrupt(int irq, 
>>> void *data)
>>>       struct zynqmp_ipi_message *msg;
>>>       u64 arg0, arg3;
>>>       struct arm_smccc_res res;
>>> -    int ret, i;
>>> +    int ret, i, status = IRQ_NONE;
>>>         (void)irq;
>>>       arg0 = SMC_IPI_MAILBOX_STATUS_ENQUIRY;
>>> @@ -170,11 +170,11 @@ static irqreturn_t zynqmp_ipi_interrupt(int 
>>> irq, void *data)
>>>                   memcpy_fromio(msg->data, mchan->req_buf,
>>>                             msg->len);
>>>                   mbox_chan_received_data(chan, (void *)msg);
>>> -                return IRQ_HANDLED;
>>> +                status = IRQ_HANDLED;
>>>               }
>>>           }
>>>       }
>>> -    return IRQ_NONE;
>>> +    return status;
>>>   }
>>>     /**
>>> @@ -634,7 +634,7 @@ static int zynqmp_ipi_probe(struct 
>>> platform_device *pdev)
>>>       struct zynqmp_ipi_mbox *mbox;
>>>       int num_mboxes, ret = -EINVAL;
>>>   -    num_mboxes = of_get_child_count(np);
>>> +    num_mboxes = of_get_available_child_count(np);
>>>       pdata = devm_kzalloc(dev, sizeof(*pdata) + (num_mboxes * 
>>> sizeof(*mbox)),
>>>                    GFP_KERNEL);
>>>       if (!pdata)
>>> diff --git a/include/linux/mailbox/zynqmp-ipi-message.h 
>>> b/include/linux/mailbox/zynqmp-ipi-message.h
>>> index 35ce84c8ca02..31d8046d945e 100644
>>> --- a/include/linux/mailbox/zynqmp-ipi-message.h
>>> +++ b/include/linux/mailbox/zynqmp-ipi-message.h
>>> @@ -9,7 +9,7 @@
>>>    * @data: message payload
>>>    *
>>>    * This is the structure for data used in mbox_send_message
>>> - * the maximum length of data buffer is fixed to 12 bytes.
>>> + * the maximum length of data buffer is fixed to 32 bytes.
>>>    * Client is supposed to be aware of this.
>>
>> I agree that this should be split in 3 patches but the fixes are so 
>> small that
>> it is hardly required.  I'll leave it up to Michal to decide.
>
> Generic guidance is saying that you should split that patches. I 
> personally prefer to have one patch per change. It is useful for 
> bisecting and faster for reviewing.
> I would expect that this patch should go via mailbox tree and the rest 
> via remoteproc tree. That's why maintainer should say what it is 
> preferred way.
>

Thanks Michal for reviews. I will split the patch in three different 
patches.


> In connection mailbox. I recently had some time to look at this driver 
> and I didn't really get why there are registers listed. Because all 
> that addresses can be calculated based on soc compatible string and by 
> xlnx,ipi-id for both sides.


Yes the IPI configuration register addresses are retrieved from TF-A in 
zynqmp-ipi-driver using xlnx,ipi-id property.

Other than that there are message buffers provided in hardware for IPI 
communication. We list those message buffer addresses

using reg addresses and they are expected in dts. As per bindings we do 
not map message buffers to IPI ID.

I am not sure which register listing you are referring to ?


>
> Thanks,
> Michal
>
