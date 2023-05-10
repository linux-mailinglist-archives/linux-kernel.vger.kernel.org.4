Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F4C6FDF94
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbjEJOFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237161AbjEJOFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:05:11 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4445FC1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:05:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhzqK6tzFG2Hq10fa5j22NTTqkA3Bv5xalJPg/7wWTO2/EWTiiEV0BClegGv/DiIV68gtr3RUvDfhEFZFx8JWvfV8a/8OJVWq613IRHZMYqTaEgF3nq7xOpdc3FMYhDTMS4IfU1G7X4d0Gg1x0d2GKWBRIQx3Oj/iujALxllqwovcGnZM0M18xxNXF2WpG/IQLvMwdwWvPofrVdrC5XUB73XNSlA91/PIJPSEhaK/PYvv1XY7UQMiM0eNp6emwWSNpL4qLGAEAULlzpJiPIZv6R7DZQ7iZ8noaio9DJAb6PEmfu1hl8+samNQGv6RUusaNLlN+wuzQH9bOdAF7z4ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvlP3ienq1xphAeX1v2USCOGAgwEXyM/U6yDRAJMDpk=;
 b=NZT8gS4iOx8ZyA8vRkyE/mZXnVXHo/UtGmXCL3REWHcsxMw2iyzk5/txiubbCs8Dngw1oWQuDJimoIdKJiZPHQYDiOhezjOnkEUlmW4VCbz/GO3L9iuG3YHshIBGD1YP3FjToJ2eyJ0vU8b5zyTS5h6JgWc2V5fPhw4qKq84EaEc3MimNwnVVzjBHjmm25pX3vyxGCPQdlu8fa+UcQVuICR4nTeGcnwiUvmGCr+txGxBrQ78ZvuytUeo7qM3n5D2BkTU1uD6T9yMwOcJ+ZcJasW/r8EspZBIiOKJwR76e6wsqjx3Es1kmWHy/RppgxZD6CzHYRPWCvMiXN9ff70vQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvlP3ienq1xphAeX1v2USCOGAgwEXyM/U6yDRAJMDpk=;
 b=VLKZV4NUNq/0pvE4OtDgxvMZfL+5qNg/YfG4/zPypdnf6Z9zMT/T/0xr+FYjCNfrVUsnwwRwcov77SpbGDgPsoSQs24PVtGd49OOcsGudyWxVwP+/+fa7EhXqR/OGWDpi84kUI7uF9oGjQF+WPHjaCmdt+88jc7jKpRclqae8VI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 14:05:01 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::4e4f:3a93:b7bd:489c]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::4e4f:3a93:b7bd:489c%5]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 14:05:01 +0000
Message-ID: <6dd142f8-5a8e-b62c-c629-a3a5859e73b3@amd.com>
Date:   Wed, 10 May 2023 19:34:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] cdx: add MSI support for CDX bus
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "maz@kernel.org" <maz@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "git (AMD-Xilinx)" <git@amd.com>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Jansen Van Vuuren, Pieter" <pieter.jansen-van-vuuren@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Gangurde, Abhijit" <abhijit.gangurde@amd.com>,
        "Cascon, Pablo" <pablo.cascon@amd.com>
References: <20230508140950.12717-1-nipun.gupta@amd.com> <874jom2ash.ffs@tglx>
 <CH3PR12MB83081FC5F89386EA9C54B4A7E8769@CH3PR12MB8308.namprd12.prod.outlook.com>
 <87bkityxk3.ffs@tglx>
From:   Nipun Gupta <nipun.gupta@amd.com>
In-Reply-To: <87bkityxk3.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0150.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::35) To CH3PR12MB8308.namprd12.prod.outlook.com
 (2603:10b6:610:131::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8308:EE_|CH3PR12MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: f72a773f-6896-47b7-b263-08db515f8b93
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tpWJea/LcY5pivoBqCw2onIQmRoOba3/dZbaBSNbTjdbYH3wmvoy3w3RW7mYx0LrXKzzN9PRTSyW1BmUOxGjfXY00jzraI4dohVSZqKI855/XjJMJMLVd4Q3yJwZCocwMClZqH0TaVKWaE7NXJgPjM/eA1rq/C17A2p7OHXwONLzGec/TbUVNOQksRj67Z+p3vY9xslL/3GhyMzzenuCb/PMUfogl8YJrZaHp+GeNO0Sm8/2S5+qzcdysVekFfDOt0jFs0Kqf6nmvT8k5XdL97Ffesgg2N6WDDpOi885PBYFzPAXB8C/x3y2Z1qrsmVTc+nxY6pbmodEV1MWkMOSNq8+TzA+yiCph7vrzntnePhPee8zZR7VZp9mpvqp6/4XzIZBfvdg1YFj/l8Xi+8t1ChRJdUYEvrOkBqR+LnouQf68M/NxByM2hSn3QlL1HRhf9LSCyBoWw/T3IgBn6ety+3yk9K3HNce4c4esbs8FDwILzTtpQBsw2PxB8AiyDmvIIa6n/18cXx72BE0mHWVNMXlfunKhj6C7RFigc0F1Isx20a1E5f8waFYPtHFKpCT/iNM+co4LeYKAzJ3j9qWcXbDYqpy4urWQVt+OdLQCM1VZd6lMsmOYq/yfJfZY+xnPcADFPFEdmkteCXawC9TtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199021)(26005)(6512007)(38100700002)(6506007)(6486002)(2616005)(966005)(6666004)(83380400001)(186003)(36756003)(44832011)(2906002)(86362001)(31696002)(66946007)(66556008)(8936002)(110136005)(5660300002)(41300700001)(54906003)(53546011)(478600001)(4326008)(66476007)(8676002)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjZxTzdGVGpTU1FMTWdVbUk0ejZlV2FMM1BZbHJIbEFkU3Y0WjI2VFJLZ1N5?=
 =?utf-8?B?MmY0Myt6c29MNXI5bVBSSGQyY0JLaXdudlpUcnRub0I0UXFYR2greUZjVlZ1?=
 =?utf-8?B?ZTZLUml4MVNCTENMeEhSb0xZaTRrdW1zb0o4UGNmVUhMa1NqNHY2RnRrNE5Y?=
 =?utf-8?B?V2F3T2dpNzA5VzhUcVlsKzJ1Ti8xaEFCWk8wT1llRGZ2RDdTVWZsR0lqZ2Yr?=
 =?utf-8?B?eHRia1Nnd0pNMGxucDEwVFZzaHpxNnFqUUVsUThPUmhtM084MlFsL1JwUGZE?=
 =?utf-8?B?b2IzY2NFeVBaK1c1RWltN1NSVDhKT05LU3FmVm9mcEVyKzgvRlFOUEl2clUz?=
 =?utf-8?B?bmt1Y08zSWxqcTRpbjNVODI5OFpyMng1MGNnOTU0UmlFVTdGTFEyZUxUVWZB?=
 =?utf-8?B?MU42T2xZRFRSUS8rQjJGaEV0UThpNlhzakpnQjA5ODRMekpNTFVHV1IrZFoy?=
 =?utf-8?B?aHZ1VHNFaENCQkVBdVA0U2p3K2YrTWZVQmI2cldObmExOUQyVmpEL2h5c3RV?=
 =?utf-8?B?K1hya2pZYnYxQmhieC9Cc3puMnhNdE96WHlYb0tzTzV1S25GMER4T015eEUv?=
 =?utf-8?B?aGlOVjY1SWZHdHR4Vy9zbUtUSmc5dFU5cUxsaVJrNDc2ckE4YndMVXhZVW1i?=
 =?utf-8?B?TWRXd0lMeE0xTE9Ka3dVK1p2RDFXVUZIVzRlUExDS3lGTXlsalFkMjZBZTYv?=
 =?utf-8?B?V3JzcTNkV0I4bElucW80Mk5tSzNzbVRTUkVaM3RaeUQ3c2hXeHdySS9HYWE3?=
 =?utf-8?B?b1B0TDZSYlhjQ011Mk4yQSsyRlZJQklCWXVudUlQbVIyeUI4OC9LTEdleGto?=
 =?utf-8?B?bUZYSzd1Zk9UODAzekNNdjAxTU9JbW1mbGx0dzh3dmdKWkYzaE5KdHExVXhL?=
 =?utf-8?B?c1F1VCs3U0xIdVZvYlZ5MkcrWFVwd0tQMG4rZmJZaEc2cGNZS1gyQWRPZ3Ay?=
 =?utf-8?B?cXNGT2NScFluNGcyclJnNDVOaUlqb21IU3lTdk5BbEJhOGwyV0ZDZEpybnJM?=
 =?utf-8?B?bG05WkFkR3RSaHU3cmxOSmp0aEQ3YjFXRzFRem9mcE5zYWpXVjN1QjNNSENI?=
 =?utf-8?B?bVFUcjdxdnVMYnBrdjdSYlJOL1k0bkplbGVQL3liOExDUHlxZldoYkNETkRJ?=
 =?utf-8?B?Tm8reW9LeEpWRGNvbnFWVGVYZkNNRnU1YWJHRTBTREtmRnFDWXlJbHdmOGx5?=
 =?utf-8?B?azZjQnpITjVlV0JDVGNBWGsyVEZreXRZMlliN1NvSithdTBPc3dmc2o4MHRU?=
 =?utf-8?B?RSsxZENmSzh3S1h5OXRkV0JtdlJlajJUZFZQZ0R4eVpDMyt1SnVkbnpWVEI4?=
 =?utf-8?B?aTNKSzQ0OXNLTmdCTWwvRU9WeTZsZ3MvRWtrZ3pJMGVjRmF5L01nOHRZWWJK?=
 =?utf-8?B?dTFBZXZNdjdZbWM4cGVUQ3I4UDNHaGpiQmtXbHJONE94SzVyUEZCWW1NM3hS?=
 =?utf-8?B?Tm95aVRnV052VnI1eVpDZkZYanZ2WUtUUFhGem9zaE92N0xMaW1udFFPZGZP?=
 =?utf-8?B?dWl0KzNvaXhxcFdEUlR6UGxFK21NbEZtLzEvOUQ0b3J2TTRnSnhJdC9LQ3NN?=
 =?utf-8?B?a1duOEVsVWE1Sld1WnlYWnV4Nkt2MWtCa2hnVHJKNCtuTXhseTQ3NTQxNE9P?=
 =?utf-8?B?RDI2clZUTGhzdXBHWUpjRlVYWm5NK0grNDN5eHZWZlB1R2JxNXJDYUp5ZHBU?=
 =?utf-8?B?MUhKbXI5dWVVbUQ0b1hkamRmbnBxTEJja09CMDJLQ2J0S3FoS1p2Tk95V3Zl?=
 =?utf-8?B?ZmoxSy94TE5ubVpPM2tYT0VHaDV2VnJNQTFNNWtrTEtXSmluUUpUdXdNc3FF?=
 =?utf-8?B?ZHNlam5uY2JBek1WcE5CeFExUUk2WUVjSm1TYldtT3VUOUJxeFVNUmRSaHBN?=
 =?utf-8?B?cUpBVzc0ZWlUbHgyd0ZpQnlpei8wWTZhMWJPckplYmFPc0VHMlplcnNoak05?=
 =?utf-8?B?ZkdmamszamFEd0lPSUEvYW5hbDg3VUJCWmZ6alBjajdjSGo4cm9vbjVBeTQ1?=
 =?utf-8?B?N0tzdjRBQVdxSU5zNDJMeFhDejNhOHhzZ3pDbUpTb2UvRkZRTWZwOEVtKzFK?=
 =?utf-8?B?VkJGVEtnQkxBTUZhdWFnSTdOL3dQdStwL09DQnZOcTVOaDFqc20zRkMrSFlt?=
 =?utf-8?Q?o4Aiq1Ehpgr++NPj0r3pik+Nc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72a773f-6896-47b7-b263-08db515f8b93
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 14:05:01.3044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jiXL/e8l2HgnPMP4ZP/U2JhyWT1P0fO8O4pYoz49H3x3QpglOcyH906TqnUZiXRr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8909
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/2023 3:31 AM, Thomas Gleixner wrote:
> 
> Nipun!
> 
> On Tue, May 09 2023 at 11:06, Nipun Gupta wrote:
>>> -----Original Message-----
>>> From: Thomas Gleixner <tglx@linutronix.de>
>>> Sent: Tuesday, May 9, 2023 1:32 PM
>>> To: Gupta, Nipun <Nipun.Gupta@amd.com>; gregkh@linuxfoundation.org;
>>> maz@kernel.org; jgg@ziepe.ca; linux-kernel@vger.kernel.org
> 
> Can you please fix your mail client to not copy half of the mail header
> into your reply?

Sure. Got it fixed.

> 
>>> Caution: This message originated from an External Source. Use proper
>>> caution when opening attachments, clicking links, or responding.
> 
> That's also relevant information for me, right?

Sorry to submit with this text, have already contacted concerned 
internal team regarding removal of this text. Have removed it manually 
for now.

> 
>>> The only real CDX specific functionality here is a CDX specific
>>> irq_write_msi_msg() callback, right?
>>>
>>> And I gave you a pointer how this should be handled, but instead of
>>> helping this effort along you go off and implement it differently just
>>> because. Sigh!
>>
>> As you rightly mentioned the irq_chip has only irq_write_msi_msg() as
>> callback, but there is also cdx_msi_prepare() in msi_domain_ops which
>> needs to fetch device ID from CDX device, due to which we are currently
>> using separate CDX domain.
> 
> Sure. But where is that information in the changelog?
> 
>> IIUC, as per your suggestion we should have CDX bus token added into
>> its_init_dev_msi_info() of
>> https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/tree/drivers/irqchip/irq-gic-v3-its-msi-parent.c?h=devmsi-arm,
>> and register CDX specific 'msi_prepare' here; so that we can use
>> msi_create_device_irq_domain() to create a per device domain?
> 
> Correct.
> 
> I'm not insisting on that, but you could at least have had the courtesy
> of responding to my review reply and explain to me why you want to solve
> it differently and why my suggestion is not the right solution.
> 
> Alternatively you could have added that information in the changelog or
> cover letter.
> 
> So in summary you ignored _all_ review comments I made, went off and did
> something different and provided a slightly different useless changelog
> with the extra add on of a broken Signed-off-by chain.
> 
> Feel free to ignore my reviews and the documentation which we put out
> there to make collaboration feasible for both sides, but please don't be
> upset when I ignore you and your patches in return.

Sincere apology for not responding to the earlier comments. Intention 
was never to ignore the review comments. Appreciate your vast changes 
regarding the MSI, and the patch series you shared took time to 
understand (provided other things as well), and it was quite late to 
reply. I understand that even in this case atleast I should have added 
this as part of the cover-letter.

IMHO, use-case for MSI in CDX subsystem is a bit different from per 
device MSI domain. Here we are trying to create a domain per CDX 
controller which is attached to a MSI controller, and all devices on a 
particular CDX controller will have same mechanism of write MSI message. 
Also, the current CDX controller that we have added has a different 
mechanism for MSI prepare (it gets requester ID from firmware).

In your opinion is there any advantage in moving to a per device domain 
for CDX devices? We can definitely rethink the implementation of MSI in 
CDX subsystem.

Thanks,
Nipun

> 
> Thanks,
> 
>          tglx
> 
> 
