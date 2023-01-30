Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37CE680381
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 02:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbjA3BcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 20:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3BcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 20:32:23 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361FA193E9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 17:32:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jD9BGH8QG9SoktQ9zvMJzxUuv3oKtcTg0gqG0Rvuu48C9Fx+avjSLI6x9jhIzaykXgK/18GT4OhTO/9DFzBmgpfxOZikO6LmRua/I3uOLH5RV28MtwCOpYymujlI7x3EcnMakAQTF7NRkD64JuFJqzzb8DdOgQeotj0B6m3GTJdmLQtvdX1BM7PIRvxcQzJuldeQ5+kn4FAJES6eRyKXqwhKW3YeXaWLDdlKpY8wqz0zGqeK22hn1X+Qvk/qyLKIJ/b2p9lQ/fMMA7tlMYg2HVHP3JSihKZsivKmh4chb7RzQ3m75jnnpqGaLHCCb228fv9/1/fb92biztTGmThS8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaWu2M8ki9lPajSROgP1JZg9Xitd0A+LTwVQT50NbLg=;
 b=Vw8s+6NLPVye/7+LS/YITVmXnqsYtknNwASg+F3/s7NWFbdVY/nkXqBKE69Mwe3hZ3IYVDjbVx5+/NSLD7QvTIdCVnYPZON4R3jgmEosufJNrobz9Rt93sXpO4cWXncqyw4PH2xJXUXRXnQUcyR7f75zE9lyPf1HD/pHl40VNoikai4SZRLkMoriO1JQyHEZiZ+IizQioQ9M41FrbYNbpqh9jis4IjBX7RHaR7lkDD3OGOj60K+EjFXLErNzPnM3nxSblidGeawkYugAvvX1lG8yk99wPS5HjTjMnIOUXm4JoEYhosQmW2Vu+FL7l2pp9+WFJ1my2INDLgMdhVhckQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaWu2M8ki9lPajSROgP1JZg9Xitd0A+LTwVQT50NbLg=;
 b=HAHF3rg1/Som1xLpUZF3MZm3/p1jvwjsB6DKgnMjwFfueVt37oeoxFY7kx6YnsdsmN1VJOssm/JUfhptInxwQc2bUe0deEogeOPmXBSE3JCtEc3Q7T/SMVIIX+RvbuYPv5YMDiygi992tzNR5jxUyjxRJtf7T3/CQzRJtTXQ5UAdXDOsiVgWlzw8Ya3pAK+bODBhgsNXZ7Ow1wPLSg/DbFXys9N62g/asnVQv4A9ljWJ1QBCkOyVtMIOuDY05xUcSdY2EdT9qkJwhgyJKM1pp6vD32R5oxpBFzvFDTbr/S63z5Uf7XkpJbD3OwtOSqPsvht4lMIS/RrvRXp/E0zBhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by PH7PR12MB7428.namprd12.prod.outlook.com (2603:10b6:510:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 01:32:20 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::6fa0:875c:39b1:1960]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::6fa0:875c:39b1:1960%9]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 01:32:20 +0000
Message-ID: <76781bc7-ba6c-db6d-2ed0-3aa0e53053e2@nvidia.com>
Date:   Sun, 29 Jan 2023 19:32:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] arm64: gic: increase the number of IRQ descriptors
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230104023738.1258925-1-sdonthineni@nvidia.com>
 <86sfgq7jb3.wl-maz@kernel.org>
 <2a0116a8-fbd0-d866-ada0-ed50f0523f1d@nvidia.com>
 <86k0216ydh.wl-maz@kernel.org>
 <4cc4114d-7fa5-1c23-3504-0ca4dbdd0f62@nvidia.com>
 <86fscjoe3i.wl-maz@kernel.org>
 <ed471259-5d32-e93b-20d6-42a32b8b3d89@nvidia.com>
 <87pmbmer6x.wl-maz@kernel.org>
 <d64145d6-966c-2e9d-beca-b8f896c8d2f0@nvidia.com> <875ydej9ur.ffs@tglx>
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <875ydej9ur.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0023.namprd12.prod.outlook.com
 (2603:10b6:806:6f::28) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|PH7PR12MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ef295f-6cd8-4916-449e-08db0261d42c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7TN/5erF0xSDMDk2p5LLw5kCVuxg2Xda68Z83s5MhYdRopGKSvjvUCJbk9yReb9MZAxjP5sZngxh1I5DmXNaOoJDp3Cn5ZaYdpRxNetAUEZJuqL3jdddfbqAnH3RwX6DcittRFsZ8LG+SItxq6Ngy6JbDFk9Ackxo2fW609Px4cbQqREI/L/UBaVLUAed5OHnluy0X8HbPaCeMEft7cHSDHdRt2/k1yihvzkg/0OSS3YF7Q16UhgPu2xz11dZiuHo5yc/4G3STQnmP2Ti19RX90YRqdWgtDKTv3Iv+3EYrlYqrIwQJAWkvSLyV858EK7C9QHxDlRwvzO3ctd1yYyX4Qe4Ki//ddioFZBU3a7ZfuT989kQA0lAtYxAbI4aB4rx1w6qFuXscxTaQDiZKe82vvRtVtpVBervZUXTCwjtOa88qprXbrefgepV8ScCY00C5bGF3e76cNFyM4KrN8sHyI8DqOwHBVWTRHUQhVyY+63UHm4K1j7MykwAzpCOR162Ecd1S9JbBDytW7D3XdUTplewybgDHgpZ6e7ic8mmMR92pmIdJW89GUs1lTwbv/4k+wTRqXt1u39j+DnhPpaNTBN4GnWLegdLlFQduVY4NgG3Iqt7A5CJbugy1GxevojOFft5nRDGRSNqvTA0UwYao32ajtk0lECVqkMppaDPJqYTHGS0kf6hkg0yT+mt10KmGfz6Ql9Xn6fyyq4UWSMn9z1iStOAlDVUGonzqeqMmxAWCNny5p0KFYzCVSBHDGTiLO3/+OLsSFtvCi9fNlklZ0zSi9/2Axr1PkfyoajsygmihSaWkk8194uj4Ts1YlEPADPVya5RPvYg9xYygQXJXkxiewGjlCLbEZCoIXThbE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199018)(31686004)(2906002)(5660300002)(86362001)(83380400001)(8936002)(41300700001)(31696002)(36756003)(478600001)(6486002)(6512007)(26005)(53546011)(966005)(6506007)(186003)(2616005)(66556008)(66946007)(38100700002)(66476007)(4326008)(8676002)(54906003)(110136005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU43UVBQTjRzcEwvM3NMQzFVMGxFY0h2K0F2S1pnbytVWFl0RFp6ME5sa001?=
 =?utf-8?B?M2EvNmhibUIxMFZyaGx5aDF0bm9HUkJkMFRvVXhZM2gyYjlkbU40SzNuTko1?=
 =?utf-8?B?UWkrR3dnSVlHSVhhREl6SGpVVHRLTmhNZ1ZMWGZpcVVuOXlVb0R5K0UyemFT?=
 =?utf-8?B?TWt3c0tlSzM3YndLZ2t6c05yZjdMOGd1U01HbmFHNGs2Y0d5YnNzMDRkZm44?=
 =?utf-8?B?bEVCMGU2MERmek1JU3JLeUE2UTFlL2l5aFZwdXo2bmh6ampuYkxnUDdnOGlJ?=
 =?utf-8?B?d0pDeUQ0aE5rQ0ZFOTdNMTY5ZHNwNXpqQkVSaWpMK2pvTFU0MGtLSEVkZEwv?=
 =?utf-8?B?Ykd5aVlPWXQ4d2pxQWNJZG1ubC9NTm1kTS9IRFZDU1Jlb2kxTExpM0M1Vjd0?=
 =?utf-8?B?WmZ5NHIzYVpsYmFJcnZlUzBTUlVDRVJUUXJEbGJnOWdOeWVIdUJKRmF2bk13?=
 =?utf-8?B?ZVZDQ3pHTklscHBWa1c0MVlEbWxLbnVldlFkbUtWMjU0ZDdUK2tldEZxZEN1?=
 =?utf-8?B?UHlyaEI2UlZHcDJSVEZZdjhXQjJrRktNUzFrK0V5VXFIMFl6aXRCOG9hVTli?=
 =?utf-8?B?azFVeUMrV3Eyb0g2NGcvaDJoUFM4dDJsTE54NlBWY3VPbCtEbVNlOWsyVVVr?=
 =?utf-8?B?czk2eVpXNnNiUkdIckw4K0o3TW9lUjYwa1lJVXg1LzVVdDczNW0yamt0dE1k?=
 =?utf-8?B?WnRCbExjakNDRXVsS0VzQjVrNU80OUlHRlN2bTZuZWpWbi9HY2gzRDhuMjY1?=
 =?utf-8?B?RUZlQTRLOG85TER6M1lhYm0wZUxlR3JYVmg0TFErMHdqcUsydWhXbnlIWTlI?=
 =?utf-8?B?MVR4VjFJREpUazh6SjJ4bkt5Qm1QWHFjT0V3bnZHV2hZRk9LeFkyYXNzV1Zh?=
 =?utf-8?B?M29STnhqU1A0eTFmUEVpVXVQUWdhTmtEbzVFUnlySk4vK1RBb25pRFE4d3ls?=
 =?utf-8?B?VU1zUXROaGxTZ1VmTkl6YXFidlJzT1BzTU85WEJTWDR5OEVtM0ZiOEdZQXJZ?=
 =?utf-8?B?QjNjeHljcHRqNVdMUEVzbjdpbWVnRjVzZzVQY1dVOHNrUjYxc0hqa0tLSWkw?=
 =?utf-8?B?U1U0anlzUHNxQVNWWGxxQnN5Zm1VdFFiY2Z4cVIwaFU3cHp5UWNhUjNFbEdF?=
 =?utf-8?B?SE1tbDgwMDdSbVMyb2w3UlpFUWR1QVVQb0pMaFUwNWRlM2VhK3RLa2thRWdk?=
 =?utf-8?B?S1I5SGx1cU5MM1cremlxdlByVkh1akE5ODRRMUs3Y3lEc3VtN0JqeklyQ0t3?=
 =?utf-8?B?bWEyczRLUi9OZFNUa3FHa0J3UHY3RmJiYnExWHZzd0tpcnk5K2FUM01ma0kw?=
 =?utf-8?B?cldrVldmQzQ5czBoanNxOTIwVkgxS0ErVDc1bytBYXE2SmxOM1J5ZnRFY1ZG?=
 =?utf-8?B?Tm02TnZBT2Ewd3EyOURUajkvTW0vbHh6eHdQWW81QkNUKzVDNnkzcElKNCtW?=
 =?utf-8?B?OXlTcnlxYnJkbngreVY4ZmFRdTVNVm84YzFoR1UvbStCZFRGa0VpcS91Y05N?=
 =?utf-8?B?K05zQ1FkdW12MWZvQitOaWJ1bEx5OVowNHovY2dBSGpFTHJLT3RDTlJydGVx?=
 =?utf-8?B?OFFuV0ZITlV0MHg3cmpGMVNoT0NFMXB6YnJieERpSDRRNnl4RVU4SzUyaUNt?=
 =?utf-8?B?Vm16b0VhS3dndllWejM3Ni9BR3ZXVXI4SFZpQnBqRTJhQUdvTXRQRUQwYjhi?=
 =?utf-8?B?NUVFdmFuQjc4dVhSblVXSEdkVnpCZUdqbDFkWGVWQkdhTG0vWnZIS2k5L2Rk?=
 =?utf-8?B?TXZZaUR1MmZDUUI0OCttWWZBT1hGNVFxSDF5c0s5anIyeVMyZjhEQ2paMjh0?=
 =?utf-8?B?ZGZNZE5FN2MrNFA4RWNsZXUyVDFyckRlMDZvcWlnYlZzQ25RWlE2ek5BK0la?=
 =?utf-8?B?VVRvak5pcHBsTStqSFhIUGVKZS9xQTRjNW96M2dtWk5vVy9RNVVyRTQ5dTcr?=
 =?utf-8?B?MFpxVTJUOXBKMXBhUDFvZmIwRm5ZNTBxK3BIM0lzSnZTdEVvRHl3eXl5RmZR?=
 =?utf-8?B?RUNXRW11WkZsdjNoc2ltajlLVEtDUnBibE5paTNsTjNETVl0MHBRZ1JCOGtp?=
 =?utf-8?B?N084enR4dVliMGxITTFLTXRIampmS01HVDhFSTdLaUV0U1hBbHVyMUpUK1N6?=
 =?utf-8?B?UDl2ZFhXVmFYNUtnUjZQUGI1ZmdqSDNQdlpJMnl2RGw3a0poWFlaOENqNVds?=
 =?utf-8?B?K1E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ef295f-6cd8-4916-449e-08db0261d42c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 01:32:19.9841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0bE2b1pKZpLxUh7cPDimpsIZWCMi+sZCn05w81M4HBhj1hOYVMdcCLNhMy0W0uaRtU+k8x8Paj2X1MO3G7hGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7428
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas & Marc,

On 1/10/23 16:36, Thomas Gleixner wrote:
> You can simply use a maple_tree for this.
> 
> static MTREE_INIT_EXT(sparse_irqs, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN,
>                        sparse_irq_lock);
> 
> And the functions become:
> 
> static int irq_find_free_area(unsigned int from, unsigned int cnt)
> {
>          MA_STATE(mas, &sparse_irqs, 0, 0);
> 
>          if (mas_empty_area(&mas, from, MAX_SPARSE_IRQS, cnt))
>                  return -ENOSPC;
>          return mas.index;
> }
> 
> static unsigned int irq_find_next_irq(unsigned int offset)
> {
>          MA_STATE(mas, &sparse_irqs, offset, nr_irqs);
>          struct irq_desc *desc = mas_next(&mas, nr_irqs);
> 
>          return desc ? irq_desc_get_irq(desc) : nr_irqs;
> }
> 
> static int irq_insert_desc(irq, desc)
> {
>          MA_STATE(mas, @sparse_irqs, irq, irq);
> 
>          return mas_store_gfp(&mas, desc, GFP_KERNEL);
> }
> 
> static void irq_remove_desc(irq)
> {
>          MA_STATE(mas, @sparse_irqs, irq, irq);
> 
>          return mas_erase(&mas);
> }

Thank you for providing the necessary functions, they have been extremely
useful in getting started with implementing patches. However, I have encountered
corruption in the maple data structure within mtree_load() when multiple virtual
machines are being shut down simultaneously. To address this, I have added the
flag MT_FLAGS_USE_RCU to ensure safe concurrent access during reads and writes.

Please review patch series https://lore.kernel.org/all/20230130005725.3517597-1-sdonthineni@nvidia.com/

I have applied 6 patches from
  https://lore.kernel.org/all/20230109205336.3665937-2-surenb@google.com/#r
to resolve RCU mode issues. The patches were tested on an ARM64 server and
underwent several hours of evaluation with multiple virtual machines, yielding
positive results.


Thanks,
Shanker
