Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EAD6DF939
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjDLPAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjDLPAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:00:39 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8729E6A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:00:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QB1j70cfbimxBJEsN7dSsI86O1rbTmDSV4npb9bf5FnRHHNsdbyNTVIGw5YMpB/8QHwqQ03AJm+LBLNagmf/hqhlNvnE6PeEU/+++VTE82bUdjwD0780SoGF/CYoh9A56oEx42x1Vhqa5x30T5BAMVT3eUPSwnEyyzYxxRki4jTcNCz7TE7vFOFepssWZy2X1S54Onyjd6kkHAtqFAvLGhZkmopwBdTDFiYiIrPs5Hp9lHXyIcUCx9D3OlVEB1h30TnXZ4ejG/pq2f1YNdffWxQ+ymgIGoaZUj3MviKiLNivMNdLKLBZoQ3w/74JZHq8HLVipAXcrQqzSFKT+unn5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60xuJRrZnrKvYUI53F7Ce/TdLbDbnbFajKtJN0vZvf0=;
 b=DcJm+vq2cHzgseeoEaGfo1JDHhqR9f8C+aTrnrG6txMcH65t/ueh+F3K0sLpxnPnMRh/NaoSKPFbah7wNq3AfSyHtrXlBfR3fV3DoUw+IfcdJ3X1boaTduSWSKyVW1DChQWFpDgHP4LeVLQ6oUYFiMRVVYlzK2l+FJgIT96EeoKN9lo0UmSnlj1Zj/5KK9TR/m1proyVdIWLuBngAMP2+SenIQwyop5U6YiBQWTGDJqqmGuI9rDMSVqy0366eQmlVwZfkkBy8y1XRky8KswlorK/8t5XtWYr8bRPy/AeVt7yCvCLm5FLsrHq5T0iBjcteNm4TqJ4lrpVTVr4oMwNEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60xuJRrZnrKvYUI53F7Ce/TdLbDbnbFajKtJN0vZvf0=;
 b=rCrxoCJLcZay8oEnv3B7ENJD6ADvKe9WDUIJ86fy1SYxvFTMmDrdpqy8DXMBnu83N8Ti2Wbl4deo4lvUcqzl2XuNeQ5xM1wuxRvZqW58fpyO4E3Nv4XlaU4/Z8Vj6/xN4bkgiucffn7dtduexqrA8e5VObyAVQ7U2Y1Tp9HxrX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 15:00:35 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 15:00:34 +0000
Message-ID: <0295ccee-2ee3-7d8a-9412-1442794157b0@amd.com>
Date:   Wed, 12 Apr 2023 10:00:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] ASoC: amd: Add check for acp config flags
Content-Language: en-US
To:     Syed Saba Kareem <Syed.SabaKareem@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
        vsujithkumar.reddy@amd.com, ssabakar@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230412091638.1158901-1-Syed.SabaKareem@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230412091638.1158901-1-Syed.SabaKareem@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:208:fc::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA0PR12MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7d5677-7c89-4373-25d7-08db3b66aaea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NSAg3vgHCO/GgT8+ZrTkI1qkCRj3JyHHCSnm4qaMp+GwNfjQvK7o9/cRhw1zodDEPhXfY3wpYCql3vcD9wio7y2+2cMTNzz+DXbQu5R7bVJvZuI8nDSsseEW2bxzHMSAXNCGYtf+T1B/cO3+k2TVvUkik0f0kOcHKqFjvrg7my6dhSydxop8di4ODvLFzIkTvzbRfNcQPXpPMGctr5SLH9pm8lhHHTBTLrcT87lbaqGFoLvsORQaq4gYHhtBb8u/I+tf0GIxoz2/4Sd+sfW5Tik1IniDdCcvOkGzoxKw4UOCfrIbnp5cTZZyKe9ZnchqCELBF/bQk++VZaiOK4cNlh4A77keknbwXRNt9sm12EbXTiEi5VKgpVvmy50pX3WSQ8TqqZ9dmjGX1j0K2Y3JbdqoTcDTqwg+I7JpaFfmZDg5+byoBRyd7B0G5UuPasmYVZqBR2mpFlRaNk9Ys1VLurUFO4w0HeXeGfZuRcXSnN86YPYjhR+SK2OHTAjF2rpuD/JK+hEEB2mhDkwwwtP89mpN6OyRRlLxgFJbIVg6oKrQEMYuN551wmvpUN8dkJFrb0X1JvFbsLP1Cm2kGPTxJAZ/qo+aaEv1qrMphePNApWBe3Ewf4ku6syKZBXsyUaK+4GdHG7mfdy17XbjxPYIyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199021)(6486002)(66476007)(66946007)(66556008)(8676002)(54906003)(4326008)(478600001)(41300700001)(316002)(31686004)(36756003)(31696002)(86362001)(6666004)(2616005)(6512007)(6506007)(26005)(53546011)(83380400001)(2906002)(8936002)(5660300002)(38100700002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXYwVnF5SW1SbUNHWFRnNHRDNXNoL2hma3pjOTZnb081Mnh3THY2RCt5dVdK?=
 =?utf-8?B?c1dFalhoMmVpM3AxeTlXOGpWNC9kZTkrSTZjNGd2bUdtL01uM1JZNHh0SW14?=
 =?utf-8?B?RW9wbzlHeVBuU1Vjd2QydGJlRzFGeGw4VnBqWHc5VGM4bXc4MkpnZ0lmSUNZ?=
 =?utf-8?B?VU9iNFNoQnAvMWNxY2J5MFFRenRMSDVxTnRFRHdFaUo3Nk5nWllhcHJHNU9S?=
 =?utf-8?B?NXdIeWZrbnpGbzIwbTNHWDRrbDBobFFrbHlCNUV5bU41REs4SzV4L0FhbXBj?=
 =?utf-8?B?RkhBL0pld3llT0ZqazhtbTFpZjhqQkFOOEFzNzdkZDd2d1Q2TUx5M28rM2pl?=
 =?utf-8?B?VVVDRGJYV0NmcE1xcXAvQ3dFRURWQ3lPS0RqV3hRZTg0YnI3VHRaRms3WlJT?=
 =?utf-8?B?ZCsyZzI5dEp4U2JqLytzTC9odFh4OHhpZ1JvRXVQRzlCNE5wTTVDU0xwZm1t?=
 =?utf-8?B?NDRuQkF1Szc2UEVXendVcHI5bUVnYk5zTFQxaTliSUJpYi9UTXZMSDhORkxJ?=
 =?utf-8?B?end1ZVJzRGNFYmdOWnlzdmgrbGpOMTZ6d1BOZjhQQnpRTEJxcElLRnR3bUho?=
 =?utf-8?B?VnZKeHFIMGphVE5KTldDSktnenhJc0xvMmg1ZHY3ZzF1UDByWDc1R3lkVkM3?=
 =?utf-8?B?QU00ZzhrZUtLSGhoM3hmY3RvUVo4VzJWTFNVczBjQXlLR0c2SUl5UjJQd1lz?=
 =?utf-8?B?bEpyQkc3MitsaEdKdk5PVHFGbmtiMm9OU3VPTEh0bUFmUzVnU1BtOWNyY1Js?=
 =?utf-8?B?VS92ZWRzYW9WN0x3Rk9Zc0NZUnFmeFRVYS9BVFF5Zk9qejVpa2Fza2dsS1VS?=
 =?utf-8?B?TCt4NnRwZ3lMWHNqN2V0Q2MvaXRHOEkxRWJFbER0dWdLWjJSMDR3dm9WUjFa?=
 =?utf-8?B?ZDhqRk84WkVXV3FqSjNZV0xLNGZnOXJrWlcxSmxVamJ5WmZtM3RyQVNYT1J6?=
 =?utf-8?B?Z0hDbjltV2lMRXNDUzd1L0xJdE5NM2FrNitlQjlzS2k1Y3JJTXlrNGxUSE9O?=
 =?utf-8?B?bHRUbXZ3b0lUcnB4ZjVGSjdYYU4yK1BZV3ZhRW5ibmdzKzQ2Z2ZRcjBjQ1Jq?=
 =?utf-8?B?OVpWRkxoM1VCNDRNV0hqN3dXRytxdms0Rk5vQUxXc2tKUkVHVGptOStBcFNh?=
 =?utf-8?B?V3NyUzVGK3N6MDM5dmE2THVCakFTYjN0K2diYVNjMU9uMXRPVnhHRlJYOG9I?=
 =?utf-8?B?eFBsNzlYWTlNTjlkMGE2ZmJBbTJORVVEVmt4N3ZGdTJ0VDJJNXZ1UFF3SGVH?=
 =?utf-8?B?UDFkOTg5VHkzM00xc3RYU0xkYS9xNjZQVmw0YWJSQVdHaWJOV1l1dUc2K0Q3?=
 =?utf-8?B?a0ZvV1hiVVNyOGg2dm1GZXlRUUVCSTNLdFh6QThPNE1FWUVrR2lXcjFkVjhH?=
 =?utf-8?B?eVdNSG5zWlRsVi9sYjUxOFBERVA1aGZWU1FYUXlyRmhWZVRpczVrUGFMbmFw?=
 =?utf-8?B?TEZTNmQ5Rk1EaDhkY1JIUm5Ba2VEc3VLNjh4QTMwLzIyQlJ2aWtjd3Rqb1B2?=
 =?utf-8?B?NW9MZE1xUE1aMmRUTmU0ZmV1Yis1UWdBNUVLS3Y3eEJzY0pHaHlqNHk1WWRF?=
 =?utf-8?B?d2VOZGsvelBxQW11cm0rbERHVmFwaVBCb3NHeVJkNzE2VmlmWlI0bHpTWVpr?=
 =?utf-8?B?TzhINEJVTVBPdzNkbHVhWXREbjdLQmF6enNrOThGT1JScUdYNXdJWDd3TnFh?=
 =?utf-8?B?Q0lMajBwdUFlYjVWckp6ZXNKRFJ5TXF4SlpVdHAzeGdpd3MvMXdVcWs3d2hC?=
 =?utf-8?B?YVZJeDl6UkpWYThuSnlaWUtsYm5RbitzR0xrUVdqUVJlOG9yaXc1Y1MxWGxF?=
 =?utf-8?B?RzdnQ0JzV1Nwd1RXZE1xanh2NStBbnBoZ0hFUkdtcnRRWGU0YjNoOEp1RGti?=
 =?utf-8?B?c3p4YjBUaWY3d3QrYzY0bmhBMUZkRDIvV3YxZVlrWWJZTitndkY5b0U1MnJ6?=
 =?utf-8?B?N3psbW5MTHE3RDhFNVJlcUpQdFVhZUgzZ1M5MUdJblo1VFJLakZBWm9FcVll?=
 =?utf-8?B?QSt1V1M2bmEwMDg0SXREcnF2VDdCMi9ZWmM3YlB5cnIzQ2E4MDl6VVBqSEJC?=
 =?utf-8?B?QjNKZXhveXRtbk01ZXBIbHNKdUNKdHU4RWVVTzA5eGduZHd6ME14TkZ2b0tQ?=
 =?utf-8?Q?J2y2D0Of0OFuzohq/jGC5dFCb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7d5677-7c89-4373-25d7-08db3b66aaea
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 15:00:34.5013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0Cp6q8EK5gEyOe7v+wL9hGarwgdJ5L41cDVpJKklhfY4q6tBuANVzBu1pgf9O6Y4kvPgDZOZzbh4tleZZiFYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/2023 04:16, Syed Saba Kareem wrote:
> We have SOF and generic ACP support enabled for Rembrandt and
> pheonix platforms on some machines. Since we have same PCI id

s,pheonix,Phoenix,
s,have same,have the same,

> used for probing, add check for machine configuration flag to

You should mention here that the PCI ID is the same but the revision
is different to make this clearer for the commit message.

> avoid conflict with newer pci drivers. Such machine flag has
> been initialized via dmi match on few Chrome machines. If no
> flag is specified probe and register older platform device.
> 
> Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
> Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>   sound/soc/amd/Kconfig        | 2 ++
>   sound/soc/amd/ps/acp63.h     | 2 ++
>   sound/soc/amd/ps/pci-ps.c    | 8 +++++++-
>   sound/soc/amd/yc/acp6x.h     | 3 +++
>   sound/soc/amd/yc/pci-acp6x.c | 8 +++++++-
>   5 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
> index c88ebd84bdd5..08e42082f5e9 100644
> --- a/sound/soc/amd/Kconfig
> +++ b/sound/soc/amd/Kconfig
> @@ -90,6 +90,7 @@ config SND_SOC_AMD_VANGOGH_MACH
>   
>   config SND_SOC_AMD_ACP6x
>   	tristate "AMD Audio Coprocessor-v6.x Yellow Carp support"
> +	select SND_AMD_ACP_CONFIG
>   	depends on X86 && PCI
>   	help
>   	  This option enables Audio Coprocessor i.e ACP v6.x support on
> @@ -130,6 +131,7 @@ config SND_SOC_AMD_RPL_ACP6x
>   
>   config SND_SOC_AMD_PS
>           tristate "AMD Audio Coprocessor-v6.3 Pink Sardine support"
> +	select SND_AMD_ACP_CONFIG

Whitespace looks not aligned here.  I think it's a mix of tabs and 
spaces in this section.

>           depends on X86 && PCI && ACPI
>           help
>             This option enables Audio Coprocessor i.e ACP v6.3 support on
> diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
> index 6bf29b520511..dd36790b25ae 100644
> --- a/sound/soc/amd/ps/acp63.h
> +++ b/sound/soc/amd/ps/acp63.h
> @@ -111,3 +111,5 @@ struct acp63_dev_data {
>   	u16 pdev_count;
>   	u16 pdm_dev_index;
>   };
> +
> +int snd_amd_acp_find_config(struct pci_dev *pci);
> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
> index 688a1d4643d9..afddb9a77ba4 100644
> --- a/sound/soc/amd/ps/pci-ps.c
> +++ b/sound/soc/amd/ps/pci-ps.c
> @@ -247,11 +247,17 @@ static int snd_acp63_probe(struct pci_dev *pci,
>   {
>   	struct acp63_dev_data *adata;
>   	u32 addr;
> -	u32 irqflags;
> +	u32 irqflags, flag; >   	int val;
>   	int ret;
>   
>   	irqflags = IRQF_SHARED;
> +
> +	/* Return if acp config flag is defined */
> +	flag = snd_amd_acp_find_config(pci);

This 'flag' variable seems unnecessary if it's just used in one place 
and never evaluated.

> +	if (flag)
> +		return -ENODEV;
> +
>   	/* Pink Sardine device check */
>   	switch (pci->revision) {
>   	case 0x63:
> diff --git a/sound/soc/amd/yc/acp6x.h b/sound/soc/amd/yc/acp6x.h
> index 036207568c04..2de7d1edf00b 100644
> --- a/sound/soc/amd/yc/acp6x.h
> +++ b/sound/soc/amd/yc/acp6x.h
> @@ -105,3 +105,6 @@ static inline void acp6x_writel(u32 val, void __iomem *base_addr)
>   {
>   	writel(val, base_addr - ACP6x_PHY_BASE_ADDRESS);
>   }
> +
> +int snd_amd_acp_find_config(struct pci_dev *pci);
> +
> diff --git a/sound/soc/amd/yc/pci-acp6x.c b/sound/soc/amd/yc/pci-acp6x.c
> index 77c5fa1f7af1..7af6a349b1d4 100644
> --- a/sound/soc/amd/yc/pci-acp6x.c
> +++ b/sound/soc/amd/yc/pci-acp6x.c
> @@ -149,10 +149,16 @@ static int snd_acp6x_probe(struct pci_dev *pci,
>   	int index = 0;
>   	int val = 0x00;
>   	u32 addr;
> -	unsigned int irqflags;
> +	unsigned int irqflags, flag;
>   	int ret;
>   
>   	irqflags = IRQF_SHARED;
> +
> +	/* Return if acp config flag is defined */
> +	flag = snd_amd_acp_find_config(pci);

This 'flag' variable seems unnecessary if it's just used in one place 
and never evaluated.

> +	if (flag)
> +		return -ENODEV;
> +
>   	/* Yellow Carp device check */
>   	switch (pci->revision) {
>   	case 0x60:

