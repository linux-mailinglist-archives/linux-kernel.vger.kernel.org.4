Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C0A65D4AA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjADNrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239412AbjADNrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:47:13 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F224175A6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 05:47:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFnRmx6crWCPmX2HHvzY/dXg7/iJ8k1g/XHPOVNDxWpBb4U5djX8shkBT4JvR1R6ZgupXk0B9YYOQzzSiq7Kbp8WL8B4L1/p2aNVogWDX//1678BSAOP9rp+ZJsssX4qn6B0an44iOPAogcsLwXQpsD+xSizcsgFsTiiy2tSqZ5rH7k2Cpi9s2ptjhRGQMbfzG8zTGHtQDIUu8/qwNfArMtehseAtBfFS6ZKlVfzCgMjSj8X6zIIAZoDr39t0y+X9oRYCA55rMrPB4FLnEMBPPiNuqD7Ik11/fGR08w026vdvO+NKFvY91i3dJkboZacycftMCWzjW59YxCUo6kvxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvwR5J+yBk/yhB+mUuN8SVYeNbpNFiIh2CZfyT+ox98=;
 b=FdC/jK6qIuoDjcA1vZUZSblcR2nbqs21Q8fHDvXAy0F1ZlU4f84PQyaCJPgEkEhH2EvuT8D/o0RbcSdrPdxegwSltkw7o34i+TJX1JR46oUnkNI59llsV+W8t877/IHiV86Q42NtNua9aA+4by5JLfWaZ1/Kyz5PY/zHvQHL9KqQYKCwzu9Gk6QwGQ8uUem9GNnofwE653GiEbRvNTrV8Rovm/6pTL9jsQ0yue7DeISOusWn6kXrJwty+VXsLMW1dvfBLqvH1ObmeDYjTMKEZLSEES/nVLtXG/YVR9y9HcFpsU5qsEyc/a98IZMyNGkGIn9UOezw2VPY2luy86ziww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvwR5J+yBk/yhB+mUuN8SVYeNbpNFiIh2CZfyT+ox98=;
 b=il3RBi2YziAkiyt3rg8xdNFrPqxJGxvP1i4uxcEEQaGkVZEGd27tCuwCldIMOD9kKGZZSUyVFWvWBVfiOaL6hqIah437Md5T2UuI4nDL10xOplVyWSJxEAiodtKktH+H165hRPnPJglwGLIBSffXNQaIte9JCyJD+vS9QLqAnkmWqCj65qto7iyV5dw+Db9+xnZZjXaGrwh7y75slyujWqzKYG2HhD3HbZPU+QtxQAVyZ8g95dfwf8eUKs3ReU7fiPalPTU/DHAq6WOvP4Vf7OlV7y+CxSMk3E1/oqXN7RzfuS/gYiSKM/3Ez8KdyGlctS8f8ppgCl2Unjc5YnSPOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by PH7PR12MB8594.namprd12.prod.outlook.com (2603:10b6:510:1b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 13:47:10 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f263:d93d:ba53:25fe]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f263:d93d:ba53:25fe%5]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 13:47:10 +0000
Message-ID: <2a0116a8-fbd0-d866-ada0-ed50f0523f1d@nvidia.com>
Date:   Wed, 4 Jan 2023 07:47:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] arm64: gic: increase the number of IRQ descriptors
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230104023738.1258925-1-sdonthineni@nvidia.com>
 <86sfgq7jb3.wl-maz@kernel.org>
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <86sfgq7jb3.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR01CA0009.prod.exchangelabs.com (2603:10b6:5:296::14)
 To MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|PH7PR12MB8594:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d569fb1-e01e-43f6-de70-08daee5a2d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nYhnqzXvVFeUpI5yt79bKYdEvaKabHZkKRNDUKCkUAu3AYjkVuKSvYtHbqRsBaO56MQ0G4Pw3l6OlLnJFGXEvuqKjH7RyVz4oYiaSoA21Sl1jsP1AkHE8z+uPRr+JjocyvPZyR7WPIslWbJd1l0D/djD40Xg+HMfsExWz7M9wOkqsxGpssuhG635OScYgISrv0EZ7Gw3te0fN7avlBmn3t+FXIrhD1VmAdvrEFETYFLAAnnoPH9ChztyHQ3E930Q0kP2vuD4NNOGqbrepQe8vodcgXutvhtKfILqNeN4/pxF85l8cz8NVIEOZCb2MZN1CqFrnPwsC2E94Opitx0PQdgvAhOHnvqe0XOBn1+StvZWnuuL/acxqov1L7xerNBa4Ux3x88k6eDp9iCaLJpB/lvITsX4RTPUmZhgL79Xw0DUyxy4xMSrff4Idlpw2oA64UazlZnCRFsiM4SrR9MUfk9IujvNdO9vqqcBmWjPYi33k2rWJgHcwc2zwLeQvVrtM4Ly9t8O1kk560nabhCePNn30DftpBzlOiyGiG/05b7h/tNj42CStwLRHuEJYiukq8fCJru20fSzWZkUngRj0/SvMI/lPLb4LWrrbdfwwzWg+3Y4QFdbviYAQ816O7H2cZPiloQov3P9dtJLoN06epCjocVOtbEd2X6A6HaGOThQW0Z7lhRLooBGQ3CoB3/8rko5IoNNidy+Yxke7Y1k6vzPl5wHlIkYZ9+7uZyEyug=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199015)(31686004)(36756003)(4326008)(86362001)(31696002)(6916009)(54906003)(41300700001)(66556008)(8676002)(66946007)(66476007)(38100700002)(6506007)(6486002)(26005)(186003)(478600001)(53546011)(6666004)(8936002)(5660300002)(316002)(2906002)(2616005)(6512007)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3YyZU1XNnN2OG5ibHZJa29hU2JSZWs1RUtqdDg5UW82RjdYRzVSK1l0eDEv?=
 =?utf-8?B?cjlYN0NWdnc0NzZhVjZNN3h5cVE2Q2pwZklaQ0hnWHlGdEdsSGpUVk4vVEJu?=
 =?utf-8?B?VGtlSnZiaVV6VmFJYXpqS0h5NE4zcTEva3VYd3A0OSs3Tm5YbkQxRVkrVHVU?=
 =?utf-8?B?WVlTQ09hYkFDNys3bGdTL1VyRnBGc0UvMUpkbS9MeENyNm1SaXlQMXRQNU1s?=
 =?utf-8?B?d2c4OFpGdGNxVjdYYUxKSCtsVmRRcGhXWDVIYTNxMFl4QktPT1lxWXcvTkNO?=
 =?utf-8?B?aDhFcUpZdVJtUXhqMHI4UTgzaDMvdkhMSUxDTS9wY05ZWEl1K0ZMZXgzOUFX?=
 =?utf-8?B?UVhhaU91NXFCemZrVWJIeXpRMzJWS3VOVW8xNXpBamxkVURuY0FPRTduVDRJ?=
 =?utf-8?B?bk9MUDBKQXplc21GQkRUblBPMHVxT1VUekpqR2N4RUQ2N3I3SEpFTTNyZStH?=
 =?utf-8?B?dzNJMytFTWlwbTQ2T0dxZldrRzFITzgrNWd3WUtoNk5MSnNYNWZNd3hYUXpY?=
 =?utf-8?B?cTMwWkhpRi9wMUd3S3phMll1WjlGVUJ1K1o2a081WlRrWUlCM3NOd0EyTDI0?=
 =?utf-8?B?RmNoZVRsVzlMU3kwSGFFbUdMbUZNK2J2dmMwUTZWQXFINHNNZ1RBeCtIUVBH?=
 =?utf-8?B?cGhOcTZkbUZ6WHg4N3p0UllGOEhLSDBndnlGK1VSZHVvREFTTkVtMTUzMGRN?=
 =?utf-8?B?VTdCSVZrZzVlekdlWGVJQk1sRzk3MFE5MWpOQTU1OWVjRG1BeVdNRWxoUTRn?=
 =?utf-8?B?djF4VW8ySEc4SSttRk9qK0YwdHVHSllZSjJCTGwwOTRvbVBJUjdsSFRQdGVU?=
 =?utf-8?B?WTE3T0lXRWtGYXRxN3oyRlNvcFB4bWhIcUYzQmR6SkZMOHZ3YTZ2a3pzQjg2?=
 =?utf-8?B?STY1K3ZHOWI0Q2pKWGVGazFkWWpHWG5OMHZCVzljaUZ5QitXdWl0WHdPcGkr?=
 =?utf-8?B?VlZUR2ZyQTNTSEphMHRyTWZKZXBTc3lrYWZnTW5QTTFUNkgrOGVaNEN6S3B1?=
 =?utf-8?B?QVdjbGpUK25lOEt0cm94c2UyVGJvU0FuZnFwZXYvMHpLeW43d1VWUi83bHJa?=
 =?utf-8?B?MENQTlRnNmxXMldMOVZ2NCs0WkloUHYweThSTXY3QkdxZWNZbndUeWwzcUtJ?=
 =?utf-8?B?RXQ4VFRmUGd2VmRrWi9lMklWVFlVNy9zRnFvZDFPWmVkYndlRVlNVXorVU1z?=
 =?utf-8?B?NUpOVEZGMERhd1M4N05jZStZWVpjRTBNN1dJdEdPeHdmeWxobFZqMEwwWlpW?=
 =?utf-8?B?NXdKbWJXVUo5L2Y0ZUpQRzU2bmpWS3JVWTV4OTkxTzhQZWI4UWVkZW1Zckha?=
 =?utf-8?B?elF0Q0plbXhSeXNWd2xNRlR1Q0w3eGFPa1BualZTZndIemhYY3Z5WWJINkth?=
 =?utf-8?B?MzljVU5JVEdXWmF5bWIyZ0NFL1lWTHBtRmNNSDRiRXBqRHIzejdhUnRSTWNP?=
 =?utf-8?B?VUlKcmo5OXkzVGkyUXR1VktkNzQxcWgwanlIWFRRcXhGZ1d2ZGNIdyt3VVgr?=
 =?utf-8?B?NUo3VjE4OVE4Yzl4WS9nTTZMNjBidUJFN2k4aWtIRFlhT3lMYWZqbWpFaEt0?=
 =?utf-8?B?R2RZaW91b3IwQmExUXkzQjZ6MGQ4OXU4Y241ZnhyVkFKSW5oNHdvSndCK0sy?=
 =?utf-8?B?emNVamdlbXczblduNU9KRW83bVd0dDkwMjJoSWcyQzhGMjV5SDFJc1lmWkNC?=
 =?utf-8?B?Mmp0S2hPeU54ajh6RUtFb2NWaXNUL1UxdUhRYUhBMnIyUTZQOGFTQ09jU0dx?=
 =?utf-8?B?WUJVdnNYSitkbGIzNllNaXZrdUFKa2tCY1pNNVhHK2d5S3Z3Zk5JOVJpTGp6?=
 =?utf-8?B?QWZZL0laT29RWDFBV01SWWNpMlpweUh6UnRtZG5vOFRNVzBkZGljcGJKZXZ4?=
 =?utf-8?B?cjRKNTk0U3BzZ01zZHUrMHhwNGxGUm0yaDlrdGw0bmlKdk91NHRKbXU4NkZ3?=
 =?utf-8?B?TWpCWmdvMnR5a2YyU2FhY1pqUTJLOFpsa2diRklvTi9kd3dSSnQxVEdNaUta?=
 =?utf-8?B?QUgvUjBTakFhNzlETDAvZHNYUmJsVVpoNCtlcjV2QkZPRmYvTm9Hd1BjYVNK?=
 =?utf-8?B?NENFVmk4LzlLM2wza3RTcjJhZWNwZXZieGM2aytLQkc0RFQreTAzcDJMSlBy?=
 =?utf-8?B?djZIWDRDM2JZdmJBUC9FMmlwZENCZFNkWkpLOE5hY2d2QVFoalF0a0xMcnV3?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d569fb1-e01e-43f6-de70-08daee5a2d31
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 13:47:10.1086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJasd36yktDv8ZQrnK3NMzlxswFg/bEXnGDpxol0ejv97evNbCdFyTN67MLRAnJhyQccN87x9dia7tpLjPwAwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8594
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 1/4/23 03:14, Marc Zyngier wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, 04 Jan 2023 02:37:38 +0000,
> Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>>
>> The default value of NR_IRQS is not sufficient to support GICv4.1
>> features and ~56K LPIs. This parameter would be too small for certain
>> server platforms where it has many IO devices and is capable of
>> direct injection of vSGI and vLPI features.
>>
>> Currently, maximum of 64 + 8192 (IRQ_BITMAP_BITS) IRQ descriptors
>> are allowed. The vCPU creation fails after reaching count ~400 with
>> kvm-arm.vgic_v4_enable=1.
>>
>> This patch increases NR_IRQS to 1^19 to cover 56K LPIs and 262144
>> vSGIs (16K vPEs x 16).
>>
>> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
>> ---
>> Changes since v1:
>>   -create from v6.2-rc1 and edit commit text
>>
>>   arch/arm64/include/asm/irq.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
>> index fac08e18bcd5..3fffc0b8b704 100644
>> --- a/arch/arm64/include/asm/irq.h
>> +++ b/arch/arm64/include/asm/irq.h
>> @@ -4,6 +4,10 @@
>>
>>   #ifndef __ASSEMBLER__
>>
>> +#if defined(CONFIG_ARM_GIC_V3_ITS)
>> +#define  NR_IRQS  (1 << 19)
>> +#endif
>> +
>>   #include <asm-generic/irq.h>
>>
>>   struct pt_regs;
> 
> Sorry, but I don't think this is an acceptable change. This is a large
> overhead that affects *everyone*, and that will eventually be too
> small anyway with larger systems and larger interrupt spaces.
> 
> A better way to address this would be to move to a more dynamic
> allocation, converting the irqdesc rb-tree into an xarray, getting rid
> of the bitmaps (the allocation bitmap and the resend one), and track
> everything in the xarray.

The actual memory allocation for IRQ descriptors is still dynamic for ARM64.
This change increases static memory for variable 'allocated_irqs' by 64KB,
feel not a noticeable overhead.

If 64KB is too high, can we change NR_IRQS to 65536.

#ifdef CONFIG_SPARSE_IRQ
# define IRQ_BITMAP_BITS	(NR_IRQS + 8196)
#else
# define IRQ_BITMAP_BITS	NR_IRQS
#endif

static DECLARE_BITMAP(allocated_irqs, IRQ_BITMAP_BITS);

For ARM64, CONFIG_SPARSE_IR is set to y.
