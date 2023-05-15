Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF758702DA9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242310AbjEONLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242230AbjEONKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:10:41 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20617.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::617])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EBD2710
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:10:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhMYzDYL4hOYdwRB8VRd/PNo+TvFXb6WljjBUt0M5S0jI9H+Khpdb8utMjp+nJq/BLozIguMlPTf+GNbE6HLzuW4hJ12OVk+pnNgXr0hD2z/xPnnhxq6TzPI4GMZEea35MZ+1lOVtNenwVMCly07NOW3wyRIzJjbJ/IGYP8BWJIfIV/AUXkMud05p4J0TYACrabJF71FP8hoIbPbFfc2K4lE0LsZnkPZrBx1/uU0oQ92W0+BcJZod1mh7v8uRmN8KLGc54za326QXf1Ix9YRQpUPUIcJOF+fGM6d5EZ4R8txveby2J+Q02NoDXz+NdTVhlRJubBIJfOPJYgE6usgIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ep65ZLcfnWUk0LFGOwofXeFhUhK9CNJ5tVJNURYnZmY=;
 b=D47+v3C4/v7BTDpXSSHLxn+9B3o6UJZ5iddPYdcECXC+YisuH+XNJdaV4Jlv/marFdVNCu0Lh7DB5uDxM/+KexCyij7WP448B5oxutaTvZOSErduW8WeNFOCD71JayQhiiX0wnYTEahz3npnZHJCL7K9noSJtfM4xBhs/fGcn3kESwiuRYVyD5+pg1M7mn6x2mHlKun2+HU3xYIIAwIxkHDZmnVSI9P4hOmQLgndhM5CN2VPgw1Icx+1pDeqfvRk+NvMI1tjN/UoUSRVQAtsac3CR4JBYP+Bu1bNBcQAlz18RN72nC1njw9dskM1uhiOiN0p+jFf7FSXh/UkPaH3xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ep65ZLcfnWUk0LFGOwofXeFhUhK9CNJ5tVJNURYnZmY=;
 b=L/MvRdlDZYhXk7sq3qLPOyR/HO1/ubp0dAaoZLISx4f/FcSQYLWf8QlmdgezRjUBS2o56V3rTaGDqLCkADxT2/sHys5gfEWe98OvJI0uk+TyDlWBiS6hEbNGFmu3cEiLt38vWLTvyN6b0xeL0vuo0K0iamUzF+7qUaqm2XZvTv0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 13:10:17 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::4e4f:3a93:b7bd:489c]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::4e4f:3a93:b7bd:489c%5]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 13:10:17 +0000
Message-ID: <8efbbe8f-62f8-4711-d069-44905c841709@amd.com>
Date:   Mon, 15 May 2023 18:39:21 +0530
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
 <87bkityxk3.ffs@tglx> <6dd142f8-5a8e-b62c-c629-a3a5859e73b3@amd.com>
 <87ednnes6o.ffs@tglx> <182c4d7b-9e91-c00e-43ab-a2c0bd671828@amd.com>
 <875y8xbemu.ffs@tglx>
From:   Nipun Gupta <nipun.gupta@amd.com>
In-Reply-To: <875y8xbemu.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::22) To CH3PR12MB8308.namprd12.prod.outlook.com
 (2603:10b6:610:131::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8308:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c2bbc4-5bfb-4101-d4cf-08db5545ba37
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H89WlQe7NbBAqYFBXkSwsFD9/rG5A4fQj0E/7/p/a234VSc4+OI/K31TF7OsOOLVSzD+sGJMsRFrfD32WjtFENXfPnLpqAYs4qYDC96F4t/BPR9brOE6QKq+IMQGBYpilpmlcCpAkKa2ThjzOrxpHObdoFgXSnGJo03LoYhwi2we4dDTMsGBCbZ2kz0PpcOmNRVSTKe4PviZAxEjlHZdgBHLo3bAlNwQ2Qja/bCflYkRbUh4X2ElSe7snJtyG5xXjTOE4PoDGMnYfyg0VjgMiNhAXcoEkVsPsMYcBJbjcPzrvz6Q6gmzjr7EfwjaXzIY1CpC6XhIcTN+i0JCfLgAgCJANvQ88GrVUdVUghETkjo2rPgYsVMucSSYi+9uTAT3HAlUSyucelI8/8lNm+3/0+8JxRiQj3Y9DK4Yv1mqfCl37SjNLRsGW3kFQDxWz3VhaO6KSibMd19koilXRgC5lyyZAyAFzuSA8NLEjEiLiGHHv4EzJlWmJuLMyl5qFCUnUVq2N2iNEsvu/EYpzQQx+Spmy8dGLb+kX99nfVV9E/8EEWOi5HFP3iI6G3GYT/Yv7Kx1ZVeBlmGVg+WN/d4dhfjYOobzcibZTJncuyHOaUMzowxcgG6HwZS8ZZ/xIkutxUv81Wln4gZQmOom8aS6tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199021)(31686004)(83380400001)(6486002)(36756003)(4326008)(38100700002)(44832011)(2906002)(5660300002)(8676002)(8936002)(31696002)(316002)(86362001)(66476007)(66556008)(41300700001)(66946007)(6512007)(186003)(6506007)(26005)(53546011)(478600001)(54906003)(6666004)(110136005)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW5zTVREQ0MxREFhRGJhb1BySXdRY0NsQlhzTDdVWTlOZ1ByMFVHQVJva1Fo?=
 =?utf-8?B?Q09PWksvMkpmZ3QrbXRGb3U5elNTcVVvbnJSdlZxcFk4NTR3eUJqMGZremc3?=
 =?utf-8?B?TDhkRzd1N1BKd2pJcWZ2TEVtV05VbzRiMlRyV05hVEV1UEI2eWlOSkxVOW1T?=
 =?utf-8?B?OTNtNktCbi95ZjJjL1A0SWxsaUVud1FkdnczRzJzaEU4ZkJ6endldVhGSmlt?=
 =?utf-8?B?VUFINWhucnJQRTVHK3V5Sk1qZi9QQlFRTTJLRDRnN3AwUXlrTUtubFM4QVAw?=
 =?utf-8?B?dEVBbzFXSzdjOXRuR1FrSU9Uakw4MGFmR29Wa1VFaVVFbndiM0VRVW1GSENl?=
 =?utf-8?B?K2s2cjNRYUNEd05pbmg1RjRPdk44bDJDendTaExVOVpLZUVRRWJpNmJBVEVN?=
 =?utf-8?B?N2dlUGpKUm9hMzJuV1I0TmNvREpYOG1ISXBYbUFmUklacEdleVdSL3VwZ0Zo?=
 =?utf-8?B?bGJkRE8xdjJRK1lqUkFHclMweTNMbElvc2FJWGxmbWxJZytuVmh1Rk9TLzNL?=
 =?utf-8?B?YS9mbURYeDhpRU9tWUxKV1BnZlZ4Z3UvbHpoZ0ViRlYwNWRJbmN2NFRlU0w2?=
 =?utf-8?B?M2pGNTAxSStudmt1azQyS3E0NGw0UThqb3J6amM0OFVkeDhsSktzeDAvOW5J?=
 =?utf-8?B?V1lrMFBHQlFtUzRZKzliLzRtcGZWdm90VEcxOXpnbkFHcGQrcjNacjNFcU1N?=
 =?utf-8?B?WWVLUFppMlhwRVp1czUremZ2b29CRlc3emVsVGdodkNzdkVYNlN5eWtDSmRR?=
 =?utf-8?B?bWtwc2hJeW8xdTlxZ1pkUlRFQ2JLUzJwOVpwYjNhb1M5NCs5b2d3MzFUNFBo?=
 =?utf-8?B?aFQvV2V6ejZKVDlaSGNxK2pnUjM5M3ZNOE5sYlB5ZnlGenZOc3NTekRCTFhK?=
 =?utf-8?B?akUzL1JiM2VYNi84L291L3czOGxhVEVDclpkSTA1ZGpyVWpVWXBjMnJTODk4?=
 =?utf-8?B?Uk5sWHo1eHEyaDh3NzBlSEhBRWRqSENtRzRvYnBsd3JmYzBVeUU5dmQyMlQw?=
 =?utf-8?B?VkFwY0l5cXNqWnVTK3p0MCtDRG1pcmhXVHRZcmpLbEVYN2tKVk01RG1jWndi?=
 =?utf-8?B?WnYvcmtWdnpSK1FCcFRZT1FkMGpNaHBqQUtFVHpGM0pRS2x6dUhuNlhrZ3Fy?=
 =?utf-8?B?aGJxbytrSkllQWRFM1ZqMU9uWndscDJMVi9rYWJyMFovLzNKdGJrRDB6NXpZ?=
 =?utf-8?B?NEE1c2QyaU03WDEraGo1QUo4WHNaS3RBeGczMUlQWW1vZldkbXM1V0RGQkVX?=
 =?utf-8?B?WHRGNjRtY091SE9sV1RoS2RTd3ZpZFY4TERLTmkxemdpdXVBLzA0bVVQMmxX?=
 =?utf-8?B?MWZLcmo2VDgzL1ZUWkNKWXVXZHpiM29TNWJvZDRlTDlPclQwdkdGa0dkWWU2?=
 =?utf-8?B?bUZrbzE1bzZ0WHVqLzRLbVl0L1RmdlFlQm43L2RJekJHMDJLdm9MaHpqQURV?=
 =?utf-8?B?ME9JdGZuS2ZZREd2NHJkMGk4TnZmenI4cm8wZndUd29uV1N4aVFlTkFkS2J0?=
 =?utf-8?B?enlYVGZGUWxiSW11UTVNUG81d2UvZ09hU2ZFUjVIM25SL0NNOUVpUUg1WmNp?=
 =?utf-8?B?dm1DV04zdUEvQmRSNDVwT0ZOTzVYOXM4WW5IKy9ZY216Vm44aThTWDZXWE1V?=
 =?utf-8?B?VGpOSi8ySlV1RktIRlFjcXJIVXBZQko4UjZoYklZODhiM05ackdUYklrdHZp?=
 =?utf-8?B?SW5rd0Fuc3N3Z0FVcExTQW1FU1Z2bzhPR0xqYmJQRkFXMWdIV1RvbWdTOWJB?=
 =?utf-8?B?UVN0ZkVMWXNBNUg5b1J1TncvM1FKWVpEYnhzUElaaTVzN3JnakFoZXNHUUVM?=
 =?utf-8?B?YWtIVTlpTno4dW55NEkxVXh3Uk45NzMxd01XM3k3QzFjaGMzSDVFemp6NVlD?=
 =?utf-8?B?S1FFTGVhYjBrb3NKZXVIOHFObUV2ZFFSVFhYOThmdi8rZld3Yk9ydjlpQzdm?=
 =?utf-8?B?cEllcTNOTmViL3N1cXR6VnVzWWMyQnREbExuamlLYXYrQk8wVzZyNldTeVZY?=
 =?utf-8?B?YUZ2NGRwQmNnY2dhcWZXT25UZ20yYmFncFRZVTF4ZVNVcVBLRjNQTDRSRmlp?=
 =?utf-8?B?aUtIdmt0bnJnNnlQNlkwaHRIQ3V4RmMxUnJGOTN4a1FUZ1RRdm45c2RnNmx3?=
 =?utf-8?Q?2YRSQt/aYGJv3fZhYPzumLPpZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c2bbc4-5bfb-4101-d4cf-08db5545ba37
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 13:10:17.2555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +exz4OFiHP8yWxtE3Jo6AaB9g+5dyni5c0PHMMOHbQvMMhgQuV/QTmXC2sB5stsK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/12/2023 11:45 PM, Thomas Gleixner wrote:
> 
> Nipun!
> 
> On Fri, May 12 2023 at 19:50, Nipun Gupta wrote:
>> On 5/11/2023 3:59 AM, Thomas Gleixner wrote:
>>> CDX is not any different than PCI. The actual "interrupt chip" is not
>>> part of the bus, it's part of the device and pretending that it is a bus
>>> specific thing is just running in to the same cul-de-sac sooner than
>>> later.
>>
>> I understand your viewpoint, but would state that CDX bus is somewhat
>> different than PCI in the sense that firmware is a controller for
>> all the devices and their configuration. CDX bus controller sends all
>> the write_msi_msg commands to firmware running on RPU over the RPmsg and
>> it is the firmware which interfaces with actual devices to pass this
>> information to devices in a way agreed between firmware and device. The
>> only way to pass MSI information to device is via firmware and CDX bus
>> controller is only entity which can communicate with the firmware for
>> this.
> 
> Fair enough, but we wouldn't had this dicussion if the above information
> would have been part of the changelog. See?

Yes, you are correct, we will make sure to update and add more info in 
the changelog in next spin.

> 
>>> IIRC, there is a gap vs. interrupt affinity setting from user space,
>>> which is irrelevant for I2C, SPI etc. configured interrupt chips as they
>>> raise interrupt via an SoC interrupt pin and that's the entity which
>>> does the affinity management w/o requiring I2C/SPI. IIRC I posted a
>>> patch snippet to that effect in one of those lengthy PCI/MSI/IMS threads
>>> because that is also required for MSI storage which happens to be in
>>> queue memory and needs to be synchronized via some command channel. But
>>> I can't be bothered to search for it as it's a no-brainer to fix that
>>> up.
>>
>> Thanks for this analysis and pointing the hidden crucial issues with the
>> implementation. These needs to be fixed.
>>
>> As per your suggestion, we can add Firmware interaction code in the
>> irq_bus_sync_xx APIs. Another option is to change the
>> cdx_mcdi_rpc_async() API to atomic synchronous API.
> 
> I'm not a great fan of that. Depending on how long this update takes the
> CPU will busy wait for it to complete with interrupts disabled and locks
> held.

Agree. we are also inclined towards using irq_bus_sync_xx APIs. This 
would definitely solve the issue (#1 and #2) for the setup_irq which you 
mentioned.

For MSI affinity, since GIC-ITS always return IRQ_SET_MASK_OK_DONE, the 
irq_chip_write_msi_msg does not get called.

msi_domain_set_affinity(...)
     ret = parent->chip->irq_set_affinity(...);
     // For GIC ITS it always return IRQ_SET_MASK_OK_DONE
     if (ret >= 0 && ret != IRQ_SET_MASK_OK_DONE) {
         irq_chip_write_msi_msg(...);
     }
Since CDX bus is specific to ARM and uses GIC ITS, it seems we do not 
need to do anything here. Can you please share your opinion on this?

Thanks,
Nipun

> 
>> We are evaluating both the solutions and will update the
>> implementation accordingly.
> 
> Thanks,
> 
>           tglx
