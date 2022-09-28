Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136B25EE4C0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 21:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiI1TEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 15:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiI1TEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 15:04:06 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8385F3139;
        Wed, 28 Sep 2022 12:04:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjGCX3H4aSI/GU82G003TGbpcplmE8xyofLD7Wd2ThsgcCnti1sws3Z22Blqw+33JmPtDhsbuZ4cBjGU9s54Al0lnwaZmRmVomaEgvB5Q8DdlkhZMIoQbfPoL0SEhBfma1vS7i5pRSn/fSbCSDxdlPA1u5vCiI7KitDNRoJkwObWPRAc5giJRCXjJ5wAFSE1C/NofWRDyrZfQUqbABQH5bHPj3rUZh3miMETeRodjkXasXpqjollCgeP0HpG2wADgT+gUxUUJf1qXoiNLmcbjNRsYLvWHzSzx4ccdXyWogVDKv8Dfrp8/itlKn2Vb+llG0WSgOkeZ5LwEKcckiFLfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvcwIiFfTBcGkUXTUYn2GEwijQyDtS22EJP91fCn5fQ=;
 b=odQuqyKG1NphF/ZGjLjUZAo0bojA09kJpRtGTaAmRlxUB34duTaI1yL3QCOCrqWrNa16hN7xY5v+gKanCsAtbse+tNTbuRQwQ0/ptDoUi7uvw0f0No4iC7JRD+sJe1OkNwRcpNcrCb32Lq6YaIV+lz8FecwB3gjk0AMvGUg4bbqH0AFt31VOSYcNKYo9iD+n0uAEF6bMs2JMC89CzRkoxLntBMo669Hc55J4lOiF6Iiys9aeJEnLJeGkpkLAMK1bqf6JzC3N0NCI/hd5k5lDUf4q9FMiPXFDmazPfpajNw/cvTibLj9yi1dC/4Yiq4wfTSRqolTaTUundH+VLa4HQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvcwIiFfTBcGkUXTUYn2GEwijQyDtS22EJP91fCn5fQ=;
 b=oU8FkkQoA/qKqBpwQLKfYwXHaGrvYaDgBiItd97K1zuo+suYrqc/Ju/9iN1jcPgXiuUlp2RW3+Dgkl0/6HVg/YZ8k36tJJip6Rt3Rla4WAxIboxdHXecJK8z3qITDGEhSM2/FKUtPNON+jQplJZBTgnh4CPTvOK1O+oD5CxPZk/EXY5T6AG5TEQgGx/BBYkRscrsbbGA4gyg6WEjAwtqyiim64PRGW5I5xHHMDSCuoAhM3kWKmGw/JwLvuChQur4PHF9C466m97BZWwBwqDKqhIPpRG5b/UgleQaKGaNiWe5SI9JXI4AaadqDJVA4hSni/7H1clKdDp7nZ61BYAyIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BL0PR12MB4883.namprd12.prod.outlook.com (2603:10b6:208:1c6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Wed, 28 Sep
 2022 19:04:02 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d%5]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 19:04:02 +0000
Message-ID: <6648ece7-0a8e-2217-0c5a-5d58dd5a012c@nvidia.com>
Date:   Wed, 28 Sep 2022 20:03:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] usb: gadget: tegra-xudc: Add Tegra234 SOC support
Content-Language: en-US
To:     Wayne Chang <waynec@nvidia.com>, balbi@kernel.org,
        gregkh@linuxfoundation.org, thierry.reding@gmail.com
Cc:     singhanc@nvidia.com, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220928135502.3458833-1-waynec@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220928135502.3458833-1-waynec@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0212.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::32) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|BL0PR12MB4883:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb0a8b8-2b1c-4921-f096-08daa18434ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ijFUPMMd20nE9Z28gqKlK5Oj8yV09nJLAAslY9xupkp6W+ElCCKyFDq1Lh5ybaNCKPAc/8NV/uxBRQCiBW5VZMmetYXXL+Q5N2Irls72h+A7gw196LK+CbqhNwrSbkfxtyOQRTV0iayzk4lPTMhzRjTYROVa/V3CFjCuAycoQZV+gjDSrFJkh4vzIgqUxI1qhvnrpyOaibnuWnuYh1Ud0ZtCGlDLk/M1QMUidmbl+99E5JCPnRiUVUE+vxe8ng6VCNPd+V4iiiS8rJhZddzW133qjXZ/Prtu/rA/lYKEYEWsRgHxdUPsL4ewBi2v8mO678oFszgcgeInjeKxBCI6eZtAuKtv8WyJcZiBngOLWfRV5TCF1VMlIujrBxF6PCGDjolVItNZX2GMdUv7MGRQkeqagNwqrATpXCBl+RfSt5Z1i8AIqStj/vuCR8syO2YFVfCYle9zcfKUMIdYxTiiIheRJpfSsESg11BLDz9B5J9L3ud6fkzkHT6eQR3V5UVdzM+XM2DSt1yYO/OZ6oQS61vAzxdauQThYYC3iNxCaDPyH+Kpru3DcVoS6rRhNrhrzbDkABKK884BS2wRRf1WbnYO1IoNaBaYzehmySOJDv1MwhzTZQaGUygX0OYFlp3fm5BE71ovIl3hneARMdsa5sc7ripOu2GRljqhxuocRHxMDhP1cVU6fCUMRXHofftts4sRxkGOhm5QTP29nrxPWcn/d3HFiE3+L+wkryT4z6x045M5pT5anfosNV5A238psni/uossPoqDgDiaRRUgZ7pJ1kZj1nLm+tbSnn58CgY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199015)(31686004)(186003)(6512007)(2616005)(6506007)(53546011)(6666004)(38100700002)(316002)(8676002)(66476007)(66946007)(478600001)(4326008)(66556008)(36756003)(6486002)(41300700001)(2906002)(31696002)(86362001)(8936002)(5660300002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkhuUHBWdDNjcGkrNjIzeEhnUlcvbllQanY1V1VoTHRMRlgyWW94ZWljMFJ2?=
 =?utf-8?B?NzI1TmRMa2UxdnBWTFU4SUUwM3JzeFlJN1FxajNMOGY2UjB1bGVVZkt1RXBF?=
 =?utf-8?B?S0RiaTlubGlzS1piZGlSem9abUFtYjJGWmxMajVYQmx1M2JNWE1CNVRKR0VB?=
 =?utf-8?B?UEU3N1ZWZmNWd01aS2NUSE1XdVV5d0hES1pXdEFyaVlPRU5XMk1oQ3lVNDZQ?=
 =?utf-8?B?THNUcGZrYTZ2b1dqOEkrZ2ZFczNwNGt4cThjTWU0bFdEbTU3c1NqaW93cmR3?=
 =?utf-8?B?RldkR3dYSzl6M1pTYzJJRmRDZGNGTTY1UFRuWTRuOEFFN3VKWWZsdVZBSS8v?=
 =?utf-8?B?K0t5eUlLOW81QVFyVGtNeTJwZzVwS3I5VlMvRUZDd2pTdXVjeThDcER4czlJ?=
 =?utf-8?B?Mk9SS0U5anVXSi9wV0E3YThwZzdJUUJCWlFSZmFOZW1JSm9mWjh1L2ZuZ2R6?=
 =?utf-8?B?blZoYXUwQXBjbXFRQngwejZCb0lkNkF6Mkg3dlpKbnBVSWhERmtTMTRtRnI1?=
 =?utf-8?B?a0tIRkd4c2hSTTQ1YXZwZlBCWXRWaWdNWjN0SjgvNTl3RzJySHBaSUlCb3Fm?=
 =?utf-8?B?SDlPTmNDZ1ptYTU5MHZZMHZBcnJIOEdyZHpyWjZFS3ozYmkzbW10bTJBa1Bo?=
 =?utf-8?B?aWYzREJJcVBQaFNYVm8wWmw1elV5UnF1N0U0R0VyaytDKzlHZmRkTmZaTEk3?=
 =?utf-8?B?SjdpamFROXVlTHBYa3d6SDlDWUZQTk5kRWxQOVpPYWNvSWprdlhCUXJ5NVJs?=
 =?utf-8?B?Smk1ZXpwbGlnQlBVejFxWWU2RTQyYUVNdjgxekFlSkFCLzNnQ0plUFlhSlBQ?=
 =?utf-8?B?c3RVZWNXcS9yODR6VWN0NWovSlU0ck1DTEF5TXZZd2dDVjI5cmtRSnY5bGc2?=
 =?utf-8?B?TmVWZzloZll0a1lMWW9rN0NvQ1JqcFVUZ29PNStRN01YTUdQSnI5SVl3TnFt?=
 =?utf-8?B?ZFQvTS8yU0VOWjkxazFxS0Mwdk5zYkVCMUs3U1JyVUdzV1JyV0c4QS9XbFp3?=
 =?utf-8?B?QkI3NFhDOXVUbyt2UzhvcE9RM0tCSktsWUVhS2lZYktENm9keUM0ck55WGVV?=
 =?utf-8?B?SEFJdzNPdit1SVlEaHF5VFRad3poazVQYlVvMHFhRENCYlZKeWZDc0xXSVdW?=
 =?utf-8?B?OFpSRlpnYkh4emVaTFV0ZWlsd0twelpCbS9CK0RTVWxzSTl3S0hIL2NtZ2hS?=
 =?utf-8?B?cjV2Qi80UHhOQUl3bVRKaFdPdE42MktoNit2dUQzM0lGT0RFUmw5a3MzTTNH?=
 =?utf-8?B?dkxFRXEySEhLak4yU2JDV0V6bHpTckxGNytUb2RHTjhXU3BCb1dkYmd0dzhQ?=
 =?utf-8?B?aHpQaHJMRmd1RjFTcmJKQzFGaVpjQk0rV01XOVFGS3krb2pjVm5ZTStQTDVn?=
 =?utf-8?B?K3d2VWVBRmtRUDlaZkJWTkNFRGI0UlVRTVk3SkZKT1hidDQ5Qm41NXFta3pE?=
 =?utf-8?B?bldEcnZBdXFucDIrN29NMFRBQXFXWDU5RG93SWRCR3BVQXF5VXBXbnRVOGlC?=
 =?utf-8?B?MXd4NEJJa0hnM0dCSlp3N3pWUVRrSFdEWnBPdStoWnM2SU45V0RoWEVJbGQz?=
 =?utf-8?B?N0tOYXhSakpJVUJaLy9sTjZXS2dYUGlpMzVBa0hmM0tMYVFXSXFTV1duSStN?=
 =?utf-8?B?K1VpODB2dkRQcEFHUmRpRlovNjBOb1RMVGIyMHpoVldEaHE2djJOQU56VjFj?=
 =?utf-8?B?ZmllU0xZYU8yY1E3RENkVnpOdi90U3A5TEhZYW5YK0JlT0dJVFZSdmZDWmNl?=
 =?utf-8?B?R2pROE54QWJ4M0VCWm5xNXMvZ2N3bWd2aUswM04rek8wZzl3dEpvc01lcExy?=
 =?utf-8?B?dmt3Vitwem5MY29qZm5LWXVXUUROcVFXVjY2N1dkU2xYeDZqZHA4R1gwclBI?=
 =?utf-8?B?UTBzOWkvbXViSFBMOHoyb2tOV1JKNklOQURySVNaN0ZpeGg4akVycE1pUS9l?=
 =?utf-8?B?Z3VreXFUaVpWMmhTVFhYVUVHL05WV0NienUxT3YveXd5NkE2WkFoeEJIcnVC?=
 =?utf-8?B?N1UwcXlTRWpuakJ2ejc4bDlXRUh1eXA5cXB0aEl0aHI4S2pYa1c1NWFqU2xv?=
 =?utf-8?B?V1pZYStWam5PMmh5dFB0bUpLY0FHQlZjbjJzbGhWc3dDK2s1RDF0a2xWZUJD?=
 =?utf-8?B?a1BvcVdwS1drdnVoRDBnMzFab1B5SjlaUEZ6UTN4bkk3S3J6bGJ6dUw1bkZJ?=
 =?utf-8?B?QTdmQ3JXdzByZ0VCZDlwZDBXRVY2NTVJQm40RVZXOTR1QmNmaVZRSFpvdHFX?=
 =?utf-8?B?SUlkNVk5dkhLTTF3NFNtRHg3Z0NRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb0a8b8-2b1c-4921-f096-08daa18434ee
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:04:02.5612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6x/37Tq82K7iTW0prpfZbRMglQnrIHiomm23UMPjtYgFkMHeFT7FO9Es/o03+bn/x3kW05ZWwFJiHveT+lbTQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4883
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28/09/2022 14:55, Wayne Chang wrote:
> From: Sing-Han Chen <singhanc@nvidia.com>
> 
> This commit adds XUSB device mode controller support on Tegra234 SoC.
> Tegra234 XUDC is very similar to the existing Tegra194 XUDC.
> 
> Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>
> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> ---
>   drivers/usb/gadget/udc/tegra-xudc.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
> index 3c37effdfa64..53277aa5a270 100644
> --- a/drivers/usb/gadget/udc/tegra-xudc.c
> +++ b/drivers/usb/gadget/udc/tegra-xudc.c
> @@ -3656,6 +3656,19 @@ static struct tegra_xudc_soc tegra194_xudc_soc_data = {
>   	.has_ipfs = false,
>   };
>   
> +static struct tegra_xudc_soc tegra234_xudc_soc_data = {
> +	.clock_names = tegra186_xudc_clock_names,
> +	.num_clks = ARRAY_SIZE(tegra186_xudc_clock_names),
> +	.num_phys = 4,
> +	.u1_enable = true,
> +	.u2_enable = true,
> +	.lpm_enable = true,
> +	.invalid_seq_num = false,
> +	.pls_quirk = false,
> +	.port_reset_quirk = false,
> +	.has_ipfs = false,
> +};
> +
>   static const struct of_device_id tegra_xudc_of_match[] = {
>   	{
>   		.compatible = "nvidia,tegra210-xudc",
> @@ -3669,6 +3682,10 @@ static const struct of_device_id tegra_xudc_of_match[] = {
>   		.compatible = "nvidia,tegra194-xudc",
>   		.data = &tegra194_xudc_soc_data
>   	},
> +	{
> +		.compatible = "nvidia,tegra234-xudc",
> +		.data = &tegra234_xudc_soc_data
> +	},


The device-tree binding documentation is missing for this compatible 
string. Please send a patch to add this compatible string to the 
appropriate binding doc.

Thanks!
Jon

-- 
nvpublic
