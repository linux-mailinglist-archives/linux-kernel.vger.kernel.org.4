Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E9C67355A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjASKTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjASKTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:19:30 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20630.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173436EBE;
        Thu, 19 Jan 2023 02:19:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4pq2s9i29SGMReYkq7dbZ4wxxrFnjXbXmlCZIsbBGKRKxH2inyZRrYlNwVPWWzNhRuj0DMBNTquwGgS5MMeGEhLuqpxpICQOS9ZJYBzUs0UFYudbdvqzDAwnfqLMS6kbG7SBXh1wH5ekb8I3SwQmkaM05aRcqOwZZPH1E5r22CzKMMf6GRBtNcOKD96JVm13V3OVs9P4EgcLnRkbHIsg2WaPsS6i9OAGEZNBeAd2AqqXceUyR/AQkcjuP80WRzpmtrcPHUczr8or9sK7gsj30sixZcdq5g6M6+GUMmK9mVHTCKn+Fq5XiTazkL/elPGauZPNuTmjQlhkJV89mrApw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDdwzCgv0NmFt8P17TSXgyt7x72kRk4qA3+IRxkW/9o=;
 b=MgPy/qf2J4ds6iQVGRafCkTyPu/lg7HgojGovqJbW4vVdcQO/SVlahg6c6YIQ9xExnlpbb8c5sqVN/jivSIyBWXgCdcIgzBXuOSCgJIGo6wqH7HMybkmVtmJk9DJqiYkCaGDWHabg9/Ry7EQ6UfJWBkrtrgqQ3AYKXrizhRJzzMA9JZB9PS+3eBAJ2BSllH5B7oG+Nc6LEdhYgbDq71mCVJFSDCGoSCX3zbEpoTQn6EGUrzcV4U7fCfocJ5JivdBkTCvfJRbk1LqGAihr0RaLuZHFCqEVr51T4aJv2jVCb6OLcPeqxEpM/7PjIkj+P9BqAcmQsFOI7z9ZEqqMmOFTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDdwzCgv0NmFt8P17TSXgyt7x72kRk4qA3+IRxkW/9o=;
 b=CAM+K/9VH0btV9Jipe6+x8OR8OpFYT5al4ibzDXmJ3P7DbXMh2/Jq3o7DibOQd/EDviDTp7yIpLz0NRvMq9w5njjUm+dTng/hekkMmJ0xYTeOClK5ZFemegwGiggh/IoP7SXSALn/MtRkPAtBFrk9YGwIx17/RvcGNFL3nQC6QAwOSOtLzjwXRtwLDvjeBLiugrFp0ArbMAP6pFZ98T9lAb/95e5EIIh5dK6HhYUyrdwHE6HwKRD0FkVAoFtoi3aH4ZyUKF4nEw1z+E0y6j1IM5m8CyR72KK+nUCH0U+sz02NjUjXmFedk3+FgT1Y1Acuk1avuq8+jWy82l+CJ/7Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 IA1PR12MB8406.namprd12.prod.outlook.com (2603:10b6:208:3da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Thu, 19 Jan
 2023 10:19:26 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f1be:5d:f297:e2f]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f1be:5d:f297:e2f%7]) with mapi id 15.20.6002.013; Thu, 19 Jan 2023
 10:19:26 +0000
Message-ID: <344ab84a-ab31-33cb-0222-9b75fbd981b2@nvidia.com>
Date:   Thu, 19 Jan 2023 10:14:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V2 1/2] usb: gadget: u_ether: Improve print in
 gether_setup_name_default()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
References: <20230116155545.101391-1-jonathanh@nvidia.com>
 <Y8a45WrjLUdCEHH+@kroah.com>
Content-Language: en-US
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <Y8a45WrjLUdCEHH+@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0664.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::8) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|IA1PR12MB8406:EE_
X-MS-Office365-Filtering-Correlation-Id: 71cfe622-21f1-46e2-6f3b-08dafa06a45b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0UAebsl8oggMW6LP+6WlPWBBqLrPyzt9nYCocCQnYuMu3YvPGXJP4juDR44VG5kvl69UunVQ+QdROOOVZK8BiBIFBQWetWx/2B55zJrw+qKsG8X2axdfUbZ0v6IcmyeLH3bctyYhbR7RYLi9RL7DF/Pa9NTCBE1s3ZRaxFtMI/H+yBb9Fnaj5Cu0GPFdxA6JvIdvGYF13odD1hYcaBVpp0YqhHtJV5TIoV1u306q+xMENeCxpvNMKEKe6EteetLhSeNGA1FgK1CH8NgNOaMNavOC2i4rNEsEEdWPDrkqHjoYh5679EbhH1ClrX2FeewCDr/F8O+mdZ8syaZu985yDw4lmGAR3SDkqDv3vkauLQk3PZXPE+bglIat6TMhXMCqMlafmmoUBK87jgi3DamhynVGHQvJ2hFE9QkndGxMygvgtCChnLPlJqp2bwOMc5ZNH8KI2dDlQu7gcvWoQCW0GkzYC5g4E5DfvihRK+0mKc3JfgWp58HmMntX4WePQVeA0Q8bQrwspax5xKOXaqsq8RisGxisDtfuI8ULHhcgTSu/B3oEpZQ3BYdrCaQ2CGl/zkfxvmQdKvjEEl90FY75MAfGRKDkZ9hXZHd7RUNgFwnL7wWpKZVowgVwrlXJyEheQNqRA799dWvrrROY1EhDZWzuTqewq9x6PWawT2CSQgqW5nRgsPXt2DEEXl/G/YsS5aiEkTQWGF9/1RZIsx2/V3Lb14M3XsQYzckF4h2U4Nk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199015)(83380400001)(38100700002)(5660300002)(6916009)(2906002)(86362001)(8676002)(66476007)(4326008)(66946007)(66556008)(8936002)(31696002)(478600001)(2616005)(6506007)(53546011)(26005)(186003)(6512007)(55236004)(316002)(6486002)(41300700001)(6666004)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjAxV3NVaVhBRnZRK01Vd2dheGxRS1EyVURuaVlaeDRrNTV6Vk0zK2xlWThR?=
 =?utf-8?B?SjNlUVFwdElmd1FsZEVtSXhDVHZnRkJySjQ2UEpoWlo5MDUvdXptMVhIOU8z?=
 =?utf-8?B?NmdrT1lSOVI0VGZlZnlzTmFHbXgxcGRjamNDZnNHaTY3ZVRBYXc3YVRJRnZJ?=
 =?utf-8?B?R0ZIbGpEck5ZSzNJdU5QMjQrZ051SFJZS291ZVI1WnJuL2lKUEEzK09jSjNQ?=
 =?utf-8?B?WE5TK3Z3dlJyUkJiZEloOXB5c2ZNVVdndVY1TEtwUHI0bnJEYXlBYXQ2TEMv?=
 =?utf-8?B?YmNPSnJyWUlwMjJyM3Y0SGNXbEwyb1c0LzVyNkp1bG9kZmRESldUVENvbXdM?=
 =?utf-8?B?OUhNWk9nZC9CbU53eFMzc1JVdm5JN1VaV3lKNDVDTy9POWxjWjloVE9QRHVS?=
 =?utf-8?B?N0Vrbzg1OXlSYmtXb2NRZ0k2cWFBY3JuN015N1kzT2V1N1Jub2Jkd0VXeWUv?=
 =?utf-8?B?aUdpSUdLOXI0Mkd1dlltZU81OXVwc2R3cUU3Z3pOeUhKZ09mcDBGYzFSbndI?=
 =?utf-8?B?R0NvR2M4bThrWm1ESXRHYzlyTzVMeXpycDdEWFdPK3ZtL001SXFYWVBTaUNw?=
 =?utf-8?B?Uk5wYVBQL3dtVHE3QlVjc3hHczVKYitlRGNab1ZvVEVVcXkxMGw4OGRqK0o0?=
 =?utf-8?B?KzJzZVpja0hWa25nTDdZaEpIWFlHckkrK1dyWWY3aDdnTlhBdzkya0g2UFZX?=
 =?utf-8?B?L3l6SEJXcDhOQXlpZmxla3h3QnlvOWJCOXJmRURpZExZOS9XYlR0TnlBSFBS?=
 =?utf-8?B?elRkNkRSZE1lNnArdFc3WVFabllDREVoNEp5VVVGcThndWpKRnBTT01UdVo3?=
 =?utf-8?B?OWlBb0x2VDcxNVcxSFZvWWN1a2pRZHB0eGhPRnNqbmtYNFlwQ3pDRHpHejFG?=
 =?utf-8?B?WXo2MWo5VGM4VmxicTJnZk5WaTBHOWVmR3lJR0oxVCtITTNBc3gzWnJUdzhK?=
 =?utf-8?B?emNjMVpyWDEvKy9ZUVBqYXVYanRjL1k5L0NEcGQxN2Y2MUIvYkhycjZwRWVH?=
 =?utf-8?B?ZUJNQm42U0hSMC9tcUVMOXdneTQyRGFhSE8zY1ZNcTIraW9seEF1Z1BsY002?=
 =?utf-8?B?aWZDZFdyVlVBRVFNekxEUzBKRTNpeFNGZHNEblFuU0c3ZUdGaHFHcGxhN2R1?=
 =?utf-8?B?Q1Fwb2ttRy9xTnRvSm85eEhpRUZwZHo1RnhsSitmNjUvMXdDRXV1YXA1a0ty?=
 =?utf-8?B?QkRudUhOcGg5dzVLY1A3dFJyU05KTmorRDhxdERhZ1EyNXBNRUJCWlNnRXRV?=
 =?utf-8?B?SWxWQXE5cGV5QTJ0NUZjeC8xRHZkVEE2WVg5SzdCNTVEY0lScllSU1VNTjZz?=
 =?utf-8?B?bE4vSGcvN0NjNFNFTkJPajBoYzJEM0JBbEJuajlNZm1NVnVBKzRsU0RyQXZj?=
 =?utf-8?B?TjV4NXlnUzJ2alA2REhxY29MbjdkOE5DRHpFb1ZRQkNuWEg5YmR5V2Y1aEts?=
 =?utf-8?B?QnE0TmFnY3ZlYm1nejBiMG4raFFvQ2dSaDROa0QwYitkblJzcG02M29kRnhm?=
 =?utf-8?B?NytSMGNIT2QyWmJMVjlPWDdiOGpmSWFna3lOcWVEeWhubHNIZEFFeUMyN3Bx?=
 =?utf-8?B?UHBCU2VjUmpJWGZoMkNXcXUzbW1OMUhsU1FRZXp4bS9XRThoNTRPR1AzdGlw?=
 =?utf-8?B?VDFLdm83VDA5TlBTbWlIcUhLalBRdnh0eUN4ZWlQbkp4eHRmc000MnppUldD?=
 =?utf-8?B?RzNKYU9Wb2Y4dnpKNlVENVhuOEpjOU1Gejc2ZkNqbCtiNFF6S29mQmlSRnBp?=
 =?utf-8?B?NzhUQ1RWNzZUMVhlZDVNcDdPNzZUSWw0OUlVS1VmVHh2b085VzRDUFJDSnVV?=
 =?utf-8?B?VENQbysyeWhhWjRNVVVJMEdsZkd4R010bHI1WUNvOGNzcGRRZlpNTjM0azRG?=
 =?utf-8?B?MkQvM09McVljejZub1AvaE5pTm1BNUZzcE1aV0pHQzBoYlVYZ25pUktBSzBr?=
 =?utf-8?B?NG1ubEdObERaNmxYS0FjYXhrR012bXEzWXZSN2hYZGlQTHk4bnhkVTdDU2Fs?=
 =?utf-8?B?STBYdWpJb0swNlUyNXYvdS83NWhTaG9PeFlaRjdVaXl4eDUxMFNqTlRtT0RZ?=
 =?utf-8?B?S0wxbVBtVmZmNWRmcVdvSENkS0h0Nnprd1Y4bGUyUTRldituRDRQQ01Wa2dr?=
 =?utf-8?Q?mub7n30fm5KUZpd6V26BSG+VV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71cfe622-21f1-46e2-6f3b-08dafa06a45b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 10:19:26.3362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YI+mCo5Mw0n4vz1k1+8/fUneFFRJr9dVdQCH1Y6ijmUQVkreO1rlVYs+HIOI8Rr3zyej4bVdgzmz/Oo4sQbZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8406
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/01/2023 15:04, Greg Kroah-Hartman wrote:
> On Mon, Jan 16, 2023 at 03:55:44PM +0000, Jon Hunter wrote:
>> The print in in gether_setup_name_default() does not provide any useful
>> information because a random MAC address will always be generated when
>> calling this function. Rather than removing the print, update the print
>> to show MAC address that is generated which is similar to other ethernet
>> drivers.
>>
>> Finally, given that the strings 'self' and 'host' are static we do not
>> need to pass these strings as an arguments.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>> V1 -> V2: Added this patch
>>
>>   drivers/usb/gadget/function/u_ether.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
>> index 8f12f3f8f6ee..be8e7b448933 100644
>> --- a/drivers/usb/gadget/function/u_ether.c
>> +++ b/drivers/usb/gadget/function/u_ether.c
>> @@ -845,13 +845,13 @@ struct net_device *gether_setup_name_default(const char *netname)
>>   	snprintf(net->name, sizeof(net->name), "%s%%d", netname);
>>   
>>   	eth_random_addr(dev->dev_mac);
>> -	pr_warn("using random %s ethernet address\n", "self");
>> +	pr_warn("using random self ethernet address %pM\n", dev->dev_mac);
> 
> If you are going to fix these up, please use dev_warn() and friends,
> don't use "raw" pr_* calls in a driver.


I had a look at that, but I don't think we can in this case. The 'dev' 
structure you see above is of type 'struct eth_dev' and not 'struct 
device'. In other places in the driver where dev_warn is used the device 
structure comes from the 'struct usb_gadget' but FWICT this is not 
initialised in the above function.

Jon

-- 
nvpublic
