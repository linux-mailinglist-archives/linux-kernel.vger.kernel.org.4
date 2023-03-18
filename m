Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2016BFB38
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 16:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjCRP3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 11:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjCRP3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 11:29:15 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C8A1B57A;
        Sat, 18 Mar 2023 08:29:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyrE9LotM1RU+AQUJBk8LLr+cazL3N7md50/sW7KNOAGrFE2lUGs+y0txsCIF8PyNkRqE09AyKOmBuWrlg9Wv0VBszBQGijiV3zxRevC2BanobvEW8DC56WzDnqSq2YLQZPHVUU9fo2k1unDCkkxthfjBmTZmF1NktLAkgvP628IAc/EnmSiAJ+EExnVUUSYO9g2X5P4G/lxNSFyftmgjQ/6bGeer4AaR6auLfycW0l0EXTV1xzwMzHx6UAQIv8OjrI/8p+EJzHLoFYumcN2SsW+8rh/xdVOqh/izYwzxHltbiiRZ/HXshkzQwsSQbEn51UZiKJlytxTlDYUEqB+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dePX5Yq3kAtkLcaXiDpbBmD5DpnoLvtNYbT8jV0Pz4=;
 b=V3erUpagOYR5zz8n+nCBq7kP7ndC/bKR9W3Hpj7DtD2CVzLS8B6OVD8Hx5LLh8Z5+2XlxTRiNtVn6Cw3RKieD0cAkJNhs1/DmPhO0mB1RAjb2/ICGkW57p/QeCEFnQm2HnxyffuVz1rMKDsZnoPrEBdbCXNcHJByn2hIKHeO8ho6d/ciUUut3yNC5EjVTsCSa6fbg98+kzssgGrNQOtk1hz8cVNQwk2pHg+0D+zg/tK6Iq94nn4iouTiqd11a3Y12CzOLuXxwOuviiIoGWgiB9Bb/3GvaCHc0K9+kxC38GnYNkvFqv+XUYRGxTmtYpsd0g9uQC2oIZGvb0cMMKI2Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dePX5Yq3kAtkLcaXiDpbBmD5DpnoLvtNYbT8jV0Pz4=;
 b=By+rox9zNKqKzyM1HOT6bAz6arGvAG08ZwApbZOd8P+dVVEj+d2EPACM04Ru3mrBX/VY0RSGK2BGptAYSYR/l1WFkejrheLzrOPZ/ZALsH8NdmqXoaFj+pxR5Ocq63X7QEZM9EJzaAo3Yf9NSqpArSOhHyWTMeHlpoJkze/JLj5hRNWo7OrH/hXd8gMpEmpQ1pMVzz3FHpumcmDpHfiCwAj5T2CPxY4kN3BijoDM8StETCLrV32pqHxgaxHcLceiyosTjXXBWL/79SlkxVg9LNp4FZtu6VHMjYRv5zj3uMUiv9BdltIRs1HGDKy53ve5lJ40/CjIWTahFM+XCMm11A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by BY5PR12MB4257.namprd12.prod.outlook.com (2603:10b6:a03:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 15:29:06 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f3e4:c5a8:7103:8ef1]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f3e4:c5a8:7103:8ef1%3]) with mapi id 15.20.6178.036; Sat, 18 Mar 2023
 15:29:06 +0000
Message-ID: <c61f63b6-662e-9c85-9135-50710fec79fc@nvidia.com>
Date:   Sat, 18 Mar 2023 10:29:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4] irqchip/gicv3: Workaround for NVIDIA erratum
 T241-FABRIC-4
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
References: <20230318045812.2043117-1-sdonthineni@nvidia.com>
 <87wn3egzr8.wl-maz@kernel.org>
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <87wn3egzr8.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::19) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|BY5PR12MB4257:EE_
X-MS-Office365-Filtering-Correlation-Id: 0298b11e-f246-4aac-3fc6-08db27c582fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7cScbQvVkx3Hv8bH21w98QPA3olIRg+YGVc8htkVJg1Ag1blLhqER2vDALSbx3t6nvUAJ+9EeH5uL8pnxXH/q7UGAvtyevt1a8PyUy98Zx+LZWCns63ibHbPve0gpdKc6hpBwF9Iy/uHKpFVIuGVgRSx3uSKoceW7K1F7qbDka/7oyS8PRFK/1lgMPvdUJ4m7/FRR8j3At+T/gXRoyFcdF0tFIqWV6kk7mK0iN754TARGfthgSnNFbGnnHElSnMLsGI/gh905k3wPM78YV06X6yf5smy559qcos9x05iTQ1vcUvZ7MpCN3NRqfaRFlOXwFfVqCo6MQVsWiGgE+TMpSI/uPzYYWIdFYss2CsaJ+5dkcN6u2PpUKfUYqfkGzfIFxaerembWCH4BmDOGuvGhQG0P0SHgqUL5hnSKgA4wUzdIgIlXq3AZ5wBldSZ2hn29+b61eX97wPpzYGkxFGLH3Ma9eUabQiaMPEa9gORU542n2/dra3+jxWb6+Gd9ute4CgyIv12y7N9Pe7PG8BxbiGWGtN+UjKC0KqmV4NTS1vCcVf/pqbfpP10f7TKQ0E0n9irHcvOda5YdQIUIHBvhuSsgj3ECcYyExAaNdgwJToPOMiMyR17E9kgTvIbTHb9kLkYApqcT049DDvbF06oRkLdGF/P6K7Xs/15t+ds8+Pi/OL3tdmpz5qb6j0U6gQ0VB6+4b3n12nc46GOu0tocZgPboRj+/4g3j42cVX9iXjNBrcRBrF2PMX7x3/vmvef9qidDz/N0GUEdTwdSKoKAQnOzWEbR+S8GK5N6da+VKFU2tCZtscKkRrEb8sGl9LX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39850400004)(346002)(136003)(376002)(451199018)(6666004)(107886003)(8676002)(7416002)(86362001)(31696002)(66946007)(5660300002)(66556008)(4326008)(6916009)(66476007)(316002)(54906003)(8936002)(41300700001)(2906002)(45080400002)(36756003)(478600001)(83380400001)(966005)(6486002)(2616005)(38100700002)(31686004)(26005)(186003)(6506007)(6512007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmYzLys3ODlIM3R6Ky8xVnN2V1dyRlFTSFcwTHF2QkpqcW52UENMb000ak9S?=
 =?utf-8?B?aVN4UEhKeHk4N2xqVTc4dE01NFR2K3RhVG1Yb2xObmJsWkg5L0czOEFGUzVH?=
 =?utf-8?B?c0N4VS9XSHBJeEtIakdHdFdpZUEzK2tncDRYTmxJRTQ1Vk8wNVZDTjJERmhP?=
 =?utf-8?B?VE9Fekw3cnBiQllXOGtPMTI4dUtqQXVuNVFXSHQxRXYyc2NLWFpFOW1UYUhW?=
 =?utf-8?B?ZHdnN2wvdk1kUUxHWEV0LzkvbHRaMGFVUXhlUkJMYVpNc1dnYkwvV0VUVVpV?=
 =?utf-8?B?L0JmMi9sZUowdUhFQTUxVGVweWg1NGRwQnQwOHZ5dGQwbHpTN01vbDlWdkVW?=
 =?utf-8?B?dUxQcHVCV0k2emlzVThEc2ttb2FCaDQvSWxsUFUyVmlZVVozQjlUZUhkNFho?=
 =?utf-8?B?U1RFRWxlbjBKem1DaDRpUHY1YWY1cFRPVlJKVWhzSlF1V3d4bS83NGdaNEpU?=
 =?utf-8?B?Z3RybXpwbjNKeVpTbUNTNXBKSjNIZkFRbWUvL3FBa0lNZHozWUR1enNTRkhR?=
 =?utf-8?B?QWoybmVOSlNkU21VcHNEOXZKbGpENUJnREIvN1J0eWJpVjdxUnc2VktFQjl3?=
 =?utf-8?B?R2FUc1IraEo1MU5mZmMxLzNrd2JtMGJ3V2xwWGNMWW1adTV5M0FRZnRhdSt3?=
 =?utf-8?B?bE0rMnZXMGhlWTliOUtVTm5OS0R4b1Vjc0szZXBNeWc0R1VqZGg4K3RwWlhy?=
 =?utf-8?B?RHpGU0UveUVOVElWTlZnaWVJWDBQQ0FVUzZSaFA2elNFdnNEMlZoOFNLYVJK?=
 =?utf-8?B?U0lvejNXM04yRWN4dkNnbnRYR3ZuU3ZCQ0RteTFxdXE5QWQ4dWZQbjByQWVS?=
 =?utf-8?B?SEx2VlpEbHlBUHJyMk85aE5TeDZKbzZzRnVTd1JBRmhWdXI5Ny9OcGlZQkhs?=
 =?utf-8?B?RUVjMTRKWHlvZjFOWEZKdU10Yzd5VXp1ZVdnaDc4OUdMN1R1T1hRWXAxajJu?=
 =?utf-8?B?MXlqdFE1S0lqdk1ROTk1YlZhaVlkbnZHL1Zyc2pqcnp0ejNnZmpxZkpzVERo?=
 =?utf-8?B?Z2dmSGw2d0EzTy9wek9SNnlEVVgvbjVZeE1hV01HbDh3UXkxZGxnNXRRa2VL?=
 =?utf-8?B?eXE2clVad0lRa2Qxc0ppUEJ2V1o3S1VFTHdJUEZqaEhFWDFFQm1lREsxWEF6?=
 =?utf-8?B?QWpybHBWa0xXWVhMTDNrMk5idVJBZ3VBd0NoM1FOelVXRTlWQU9UNjlBczBz?=
 =?utf-8?B?SHd3WXBNdDJUc2NHMkdic0hoVytWd3dZN1R4cGRwOUJWNWtoN3dnNFVtZmRo?=
 =?utf-8?B?WU9XOFErd1d6MXFXQXlyRkZJK0xISVNnNlZOeTEvNzBhMjBxUExJMFloTkE1?=
 =?utf-8?B?bVlWR0hZQWpoaWc3YkhnT3JhcE9PaWQrRVpLWWY4cTBiTzJacW5YK09tMzFt?=
 =?utf-8?B?UW80cnQ2SmQxQ1I2TUNkL3M2OEZCa2RVN01OSG9LU0NoZmlERHN0MjA3K2Js?=
 =?utf-8?B?RXRrOTR2VG1RMVRGQ3VEZ1Fpdkp1U0REVkk2WGJqLytjT21VOHMwT3ZkTjJG?=
 =?utf-8?B?THhPUDc1ZW9GRFlzdUhsL2hYdnk5cEJScWxUZU1TTjVJQWRkV2ZTc2FSLzV4?=
 =?utf-8?B?R3hIQmg5a0Z5ZWxsK0J4V1dLZ01BVkRyWGtqaXpNdGZabmlUWjRpRlFCcGlC?=
 =?utf-8?B?T1d2amdSUi9YUmdWTGJQQU5TR3ZVZlNsSUdTbFY2dUpRUFpEVWxrS21YdGgv?=
 =?utf-8?B?OVc1a1k5c0JHbDVodjlENzFHZ0lvMWxaanVXWENOS2pITXVVK281dkZEc2JU?=
 =?utf-8?B?Wkx1MmlYWFk4WTJvS0FQMnVsTFJpeERqTTA1ZjAwWmk5S25vdmJBbExtblVH?=
 =?utf-8?B?cThBOFY5UDhqRVYrcjlUQm9uWEIvV0FVSUtrV1FpczFqVm4zckpxWkFhajBZ?=
 =?utf-8?B?UkQxdlZwd3NnV25zQUJPbEhXTWR3UTRlQ0FQdU5JY3paYXZTWHQxcVhid1BT?=
 =?utf-8?B?S2c2YXVBRC9FcWJlVE9CWU9ad0hscTVmNWhZU2pFMGloeWM5L21TR0RmK2hG?=
 =?utf-8?B?V0VES21yODU2ZUhCY1RoWWpRNDJPaGRTaEs5bytWZzFFQWdvdGFmOVpJV21F?=
 =?utf-8?B?MlRhQXZQSkVlaE5PTTl2RGhXRU00OHBrS2crUVpBY2NvbzRsWDdnTi8zbDhU?=
 =?utf-8?B?ZmNodVk4Y3BoeHdSbGJkRHJSNGdSSFoveGpuK0c3NUIrcUVGZzRDbVF6WHBv?=
 =?utf-8?B?WGc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0298b11e-f246-4aac-3fc6-08db27c582fc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 15:29:06.5179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdZevC+6yNIdKaA3JQY3ZoEcC58oK8cvio3B0nFdpKOrmeu52U4CLdtH1v6XHWcLX50rLtSXtatarkR12/gzRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4257
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 3/18/23 04:44, Marc Zyngier wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Sat, 18 Mar 2023 04:58:12 +0000,
> Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>>
>> The T241 platform suffers from the T241-FABRIC-4 erratum which causes
>> unexpected behavior in the GIC when multiple transactions are received
>> simultaneously from different sources. This hardware issue impacts
>> NVIDIA server platforms that use more than two T241 chips
>> interconnected. Each chip has support for 320 {E}SPIs.
>>
>> This issue occurs when multiple packets from different GICs are
>> incorrectly interleaved at the target chip. The erratum text below
>> specifies exactly what can cause multiple transfer packets susceptible
>> to interleaving and GIC state corruption. GIC state corruption can
>> lead to a range of problems, including kernel panics, and unexpected
>> behavior.
>>
>>  From the erratum text:
>>    "In some cases, inter-socket AXI4 Stream packets with multiple
>>    transfers, may be interleaved by the fabric when presented to ARM
>>    Generic Interrupt Controller. GIC expects all transfers of a packet
>>    to be delivered without any interleaving.
>>
>>    The following GICv3 commands may result in multiple transfer packets
>>    over inter-socket AXI4 Stream interface:
>>     - Register reads from GICD_I* and GICD_N*
>>     - Register writes to 64-bit GICD registers other than GICD_IROUTERn*
>>     - ITS command MOVALL
>>
>>    Multiple commands in GICv4+ utilize multiple transfer packets,
>>    including VMOVP, VMOVI, VMAPP, and 64-bit register accesses."
>>
>>    This issue impacts system configurations with more than 2 sockets,
>>    that require multi-transfer packets to be sent over inter-socket
>>    AXI4 Stream interface between GIC instances on different sockets.
>>    GICv4 cannot be supported. GICv3 SW model can only be supported
>>    with the workaround. Single and Dual socket configurations are not
>>    impacted by this issue and support GICv3 and GICv4."
>>
>> Link: https://developer.nvidia.com/docs/t241-fabric-4/nvidia-t241-fabric-4-errata.pdf
>>
>> Writing to the chip alias region of the GICD_In{E} registers except
>> GICD_ICENABLERn has an equivalent effect as writing to the global
>> distributor. The SPI interrupt deactivate path is not impacted by
>> the erratum.
>>
>> To fix this problem, implement a workaround that ensures read accesses
>> to the GICD_In{E} registers are directed to the chip that owns the
>> SPI, and disables GICv4.x features for KVM. To simplify code changes,
>> the gic_configure_irq() function uses the same alias region for both
>> read and write operations to GICD_ICFGR.
>>
>> Co-developed-by: Vikram Sethi <vsethi@nvidia.com>
>> Signed-off-by: Vikram Sethi <vsethi@nvidia.com>
>> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
>> ---
>> Changes since v2:
>>   - Fix the build issue for the 32bit arch
>> Changes since v2:
>>   - Add accessors for the SOC-ID version & revision
>>   - Include "linux/bitfield.h" and "linux/bits.h" in irq-gic-v3.c
>> Changes since v1:
>>   - Use SMCCC SOC-ID API for detecting the T241 chip
>>   - Implement Marc's suggestions
>>   - Edit commit text
> 
> You seem to have ignored most of my comments on v2[1] apart from the
> SOC_ID stuff. I guess I'll wait for v5...
> 
>          M.
> 
> [1] https://lore.kernel.org/all/871qlqif9v.wl-maz@kernel.org/
> 

Sorry, I did not intentionally ignore your input, but unfortunately, lost
this specific email in my outlook. Your feedback is valuable, and we will
ensure that all of your review comments are addressed in the v5.

-Shanker

