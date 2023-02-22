Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2EF69FC7E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjBVTvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjBVTvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:51:00 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18A042BC9;
        Wed, 22 Feb 2023 11:50:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvasscICHGs42atfy2NN/cbUV193IN9TmALDEMGV3JB+0QndZ0ARXY8WiQrh02G58Eg0rt0tH384o0ckKICKJCAFaFuP6eapKaCe09LzUhf/OW584NOlBMqe905Pob11YfUhhiCzY98fZ5hNDoJpC1ZSE/UVBgVMCzc0Bek3gSYTqrvbdVa3k/J2DgR10bUCbuga8bmw9RL+/t2VkltZQ3TwWjEeGURrZd3PMxPiS2zN2ApREGhxrKrcYYVagkW+HnfFo8FZJaqZYgNgggYSxM2NNiKU25pEfJMxNVgGtr591/H/CdraBIa3qLXsNu5c/gHHx8UZfwvumLy7NcqPJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZvjnY7266cYr5lYlUaA7lihhb8+FxwWRtSGQnTUitA=;
 b=TxubQq5DSfOy7BPhwvemIiq951olxUSThi6eA6fdpYXNlIYAAt7ZNMuazH7jIFRPMfuJda0wLyE6uVPSZfzA+eEfrhcV58h8Q4aUS1itqaIDI3cDTyYdbSxl4DKfNaqZOvxf6lBu9aF9eQeD9cNq2ysiOw7rBNSWylcQ7lu3cVD66ouB9txuRpPbyuAaccbVnd2NfZFu2jtuVRGLi7zpdh2gpkO0Gt2pcY3y1MYiEBj4Kg8Y2h98HzN0GpQ3C2P/gW6MHWFsa8TcJtTrCE5ZnnWxEWh4UOZsPqYCE8HjMBO8IlWgCQZk8vHIrBlZImge7Bo8jrweJ+b1owBnUopwNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZvjnY7266cYr5lYlUaA7lihhb8+FxwWRtSGQnTUitA=;
 b=xfqtiQBk/HpLrIdUqQVrJ7MFpVw3qmRcuAYcsDwIN9Ce1N9OUVC8t1IN7FbKBi7GR2HkEBVgLqL3afvxFpnKF31cUWhdQT3yrYvph5YI40p7uFN0a3VmIekezp7QgbqXSGBnAcBnktXLVYenRBWMiKL7V88IaWuyDzhs06tPEWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6763.namprd12.prod.outlook.com (2603:10b6:510:1ad::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 19:50:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%5]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 19:50:50 +0000
Message-ID: <c99a7ae3-b8ab-30e2-67bc-87b5a7736728@amd.com>
Date:   Wed, 22 Feb 2023 13:50:31 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] HID: usbhid: enable remote wakeup for mice
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Michael Wu <michael@allwinnertech.com>,
        Richard Gong <richard.gong@amd.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230222013944.31095-1-michael@allwinnertech.com>
 <Y/WwXBF37hoZBbQa@kroah.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <Y/WwXBF37hoZBbQa@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:610:32::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cce9d2d-c834-4099-54fb-08db150e1955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fe9Wzg+N3/7251Qcu1fSgnulchTurNkJdZHqmrYNfqoHvOpxs2tdMoM/BiM2J9K0JczmB+RTQJ1hOUCjAmGz4Jbt3MOfZWnV/g5OdmlZ53D8PVNdO6Po8azAgaxs3/+KjnnQedlySt+iJRf8+tmZorTjLKOfKglyvuR+KMYxsknYWAvmgeTPziO38szyELcHcyqIYT1P8I1iEFEHleuFossA6xHgCs+2S8YuZJW3E8Qu2CGJdzE7FO68NJhGRFXMbCul1eE0eZmqcO8eO0tvSHGlGcaITgyUd8Dy4f+IOXP5wfnmIPSQnEC83sz2zkhTkw84I477gjWFLdW+Xikt6LnancBmorAkhWZ7O8M/6pN4xDVB7ecvD8aUd+dQmpRtXIkdoCXdBXkM9mKlNBZZVFMWvY6Hwe5e2TzNq3ZlSugjGuwc2GUU1ZIlEVRn28GjHGZXe+x7AzRPBkbXrBc31mEpWLQsdoH7Xa/7PHXv3U1FdMPKMevMQPU2AYYf9rE1NBZgih8F8s6zRL+nXMDL/BKdDWjKv1Te4fQtcJwSoguhITiQ9BfcxkaHgz4uNsfinFdbhygdCwz5j4nxofcU2uNYigEjZ9ad52kpq5rLf6IbbedBA49vR2MZQ7w0wd0cf65s9Um9k8wtOqo93VJ7zf9oCDBeKexRO20+BM4BPZeQQ1GtMsLlovn+1niShtI8Z3EWFM0NuiOF/i40rvI486MsFV6Es8uqd6XO1Vp2SbghrcRkTDQrJ4rDnbKm1AsXjrqF7f+Pn+lyoZFYnrPbiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199018)(8936002)(5660300002)(66476007)(8676002)(66946007)(31696002)(86362001)(36756003)(316002)(478600001)(6636002)(110136005)(83380400001)(41300700001)(2616005)(4326008)(66556008)(966005)(6506007)(6512007)(53546011)(186003)(26005)(31686004)(2906002)(38100700002)(6486002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWUzVzZ6dDlici9VODA3YjhoZmg2cUhwWGNBTEhtVTZBRlA0REQ1bnpSeWM0?=
 =?utf-8?B?bnBWU29aaFlpSDNsU0t4dWREMkU3M3VXbTNRNXNBUEtzaUsrdUZPMGNlK2U1?=
 =?utf-8?B?cUtpTXJvZGFHeEdITzFrUElNSEdRUVZqZmFoUFhkTUlrREhEc3RBY0xzYkFP?=
 =?utf-8?B?b29CY1BPUFZqUkRjTmVPemtHcDNDdEcyaXVvTVViOXl0bDhSUDdrakpmeTVQ?=
 =?utf-8?B?SHBpdThxdjQ0TjNPa3RERENjb1dxR2RpdS8vVVZuY285TDBkb3hpeFJySXpG?=
 =?utf-8?B?UVVwT3FsZU5ZeGtzNU0vVWpzdnhLZ1AwMDhPOWQ4M1FFdWNYNEZSWHBrNzJy?=
 =?utf-8?B?M2VsMk44dnlKaG15aUNTTWJtaUlpd3owZXhONXk5RmJiZEczcjArSXd1UXNG?=
 =?utf-8?B?VVhLQm8zVVpvb3gyRzFwY3VGR3RjOXU1b2E2bzZ4M05NNG1IaDQ5MnhqY0N5?=
 =?utf-8?B?cUNPS2ZiNDZ1TTlHRXZGNnh0ZVh1U01JWEdKTXF2Mytqekl2Y1lMdlhvdGRJ?=
 =?utf-8?B?TUxqaHFid0Q0REdNTXVkWnk5U1ZmQWNiTUNaYkRSS2RmeFNuZjhiM09GZUhZ?=
 =?utf-8?B?M2NBVzl5QjdpSmh3QU00VUJTamVoR2h0elFWNUhqVEgzVWMwdXpBVHJLcGtN?=
 =?utf-8?B?U0RTMjh0T0d2bkdHZG1MYVU3RlRnT0RFYUFSZnRZWml1OXE2U0xlYzJkWGZ1?=
 =?utf-8?B?d3pLb0tuaE1YOGJjczBRREZkeGFnd1d5QlZsZGxOMW94WDFtRmN5OGoveHY4?=
 =?utf-8?B?dXdOemJzSkcybnJkanFoaFdtQWtxSVI1cWR2MTloSVJOT0M3THo0S1hkU2xj?=
 =?utf-8?B?K3Y1WktRUHRIZ3hsY09qTmEvaFlvUWFiblJBZEhlWWZXUnlXbmwzZ3FQaXM0?=
 =?utf-8?B?UmFNdEVGOUhFRkF5bkVSU2E0MFQwYXlUZ2p5S3g3OUE0MzBFZmM5eXN5REZr?=
 =?utf-8?B?NDZlN001MW1RU0RVVFJhYUpWcWVaKzh4RlJNZVlZNUZSUnV1ZDNsZS9rdy9I?=
 =?utf-8?B?RXZPRjFiQndabkg2VWRDK2FXMGJQcDl0RkUyK0FYVXo2N2xEUmM5SVVzK21w?=
 =?utf-8?B?ZFI1Q0paMS80WEM2ZnA2aW5RR01SVDhKTTV2SW1mMmMwT21SZExJdnRBWFZR?=
 =?utf-8?B?T2dWSnlUUzZwU1l2ZHYwdm9abVVxK25pMDI0aWpOeXdLSGd6VWtoWTludzhC?=
 =?utf-8?B?UkxGcHR2SU5JemQwVGZIYkloNktzdWIxUU5oTnV5aHFHSllLS2dUR05oeDdJ?=
 =?utf-8?B?MEErVXYwNGlxQ1RWYW1GUFk3OUh0d0xHUWhqMUcxOUxUY01NdCtMWTRLRWI2?=
 =?utf-8?B?TERPMTlqRFpDSk1uY2JOTFlMN095TXAwbytpRXV5bG5UVUJPSTByN3BJdE4x?=
 =?utf-8?B?S0FheEpPMkxqODZ4djRmcVpUQytvc0lRUDdxZm9lUkp1WXN2c1R5QWFLekYy?=
 =?utf-8?B?bk5vNHNXZEt3eGlPVVhBL2NMek03dlAvbnlUMUhVeFpKUUFwRERFeXl5N3FF?=
 =?utf-8?B?Rnd1OU9MS1RjV3hCS3dGWTJsaFY2emt5Vms3Q1FHUDczb3ZnTzRYZXpOYU1w?=
 =?utf-8?B?OG5Wc3RkMjYwaGZOMXo4aTcxTk9Vbk12ZEJDdW1HQXk5QlBEL2pNMGdLRDJi?=
 =?utf-8?B?Z1B5b2hqWkxydjd6WVB4eTh3MFpMYW50UVJTdEswOGNIQ0svVEZ1QjBSbHhh?=
 =?utf-8?B?SGlSbVNQeDNjYTh1bjNzRGFxS0dXUDlmbEk3dTM4Y1A1WXpyeXdzejFwR3lt?=
 =?utf-8?B?bWZjZEFibW5uT21wVmRmVzNOUWlHckxIOU9uNFl5Zjg0ZlNrbkxvdDR2aVVw?=
 =?utf-8?B?K2FFQjE3N1gzSkxjZlZuZUdmOE9Ib21JdXYxWW1lMHlGeEN4MkhLNC90SXdo?=
 =?utf-8?B?Uk1Ld3NSSnE1a3RFQ2QzRGZncTNhVWVLNzI1RXdKeHNicFdZa0Y0Vnc3U2hk?=
 =?utf-8?B?SjdOOWhyVzFtTUkxUjVFdXFCREhIYTZvQVNpTTJWY3BEOHhlQ2dIZi9JTDJa?=
 =?utf-8?B?STgzVEdRZmNNT1VuczErYTdHSDFQb0c0MmJOVVZ2SkcvZElPN2JRdjVKTWV1?=
 =?utf-8?B?MkFSc2pIaytDN05MenFLbnYzNXozUEtxRWtibHV3R1MzUjRhUGtSL1VuOVdG?=
 =?utf-8?Q?ysCtMDZ72Mo+Qv1lZ9byVzXTo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cce9d2d-c834-4099-54fb-08db150e1955
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 19:50:50.4461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLxckJ7hG2JfXdeQwFrZDrPcu/hkRrfojqEXnW+u7JHy2evQZzeoNgTmNV5X7iY8ddxurlyowziTuyvC10P2kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6763
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Richard

On 2/22/2023 00:04, Greg KH wrote:
> On Wed, Feb 22, 2023 at 09:39:44AM +0800, Michael Wu wrote:
>> This patch fixes a problem that USB mouse can't wake up the device that
>> enters standby.
> 
> This not a problem, it is that way by design.
> 
>> At present, the kernel only checks whether certain USB manufacturers
>> support wake-up, which will easily cause inconvenience to the
>> development work of other manufacturers and add unnecessary work to the
>> maintenance of kernel.
>>
>> The USB protocol supports judging whether a usb supports the wake-up
>> function, so it should be more reasonable to add a wake-up source by
>> directly checking the settings from the USB protocol.
> 
> But you do not do that in this patch, why not?
> 
>> There was a similar issue on the keyboard before, which was fixed by
>> this patch (3d61510f4eca), but now the problem happened on the mouse.
>> This patch uses a similar idea to fix this problem.
>>
>> Signed-off-by: Michael Wu <michael@allwinnertech.com>
>> ---
>>   drivers/hid/usbhid/hid-core.c | 8 ++++++++
>>   drivers/hid/usbhid/usbmouse.c | 1 +
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
>> index be4c731aaa65..d3a6755cca09 100644
>> --- a/drivers/hid/usbhid/hid-core.c
>> +++ b/drivers/hid/usbhid/hid-core.c
>> @@ -1189,6 +1189,14 @@ static int usbhid_start(struct hid_device *hid)
>>   		device_set_wakeup_enable(&dev->dev, 1);
>>   	}
>>   
>> +	/**
>> +	 * NOTE: enable remote wakeup by default for all mouse devices
>> +	 * supporting the boot protocol.
>> +	 */
>> +	if (interface->desc.bInterfaceSubClass == USB_INTERFACE_SUBCLASS_BOOT &&
>> +	    interface->desc.bInterfaceProtocol == USB_INTERFACE_PROTOCOL_MOUSE)
>> +		device_set_wakeup_enable(&dev->dev, 1);
> 
> Sorry, but we can not take this unless it is proven that this will work
> properly for all of these devices.  Other operating systems do not do
> this last I checked, so there will be problems.
> 
> thanks,
> 
> greg k-h
> 

Richard and I both sent out relatively similar patches in the past, but 
they never went anywhere.
We did confirm that Windows does set a similar policy as well though, 
which is what prompted us to attempt this.

As there is more interest again maybe we can revive that discussion and 
merge together some ideas from the sets of patches.

Previous submissions:

v4:
https://lore.kernel.org/linux-usb/20220825045517.16791-1-mario.limonciello@amd.com/

v3:
https://lore.kernel.org/linux-usb/20220701023328.2783-10-mario.limonciello@amd.com/

v2:
https://lore.kernel.org/linux-usb/20220616183142.14472-1-mario.limonciello@amd.com/

v1:
https://lore.kernel.org/linux-usb/20220404214557.3329796-1-richard.gong@amd.com/

