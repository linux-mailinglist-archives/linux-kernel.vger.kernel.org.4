Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD0B68379A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 21:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjAaUgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 15:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjAaUgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 15:36:09 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6321C58D;
        Tue, 31 Jan 2023 12:36:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfE3vT8UGLkHagVa8VaMwNJh4Z4iwqVRWY3WL5rXun1DXuPZEN5PI2cAYsfRg8o6QIn8uA8Iek5/4g1cpPGioEyta1WlgLYwK3YpOdPxU8OPoeMAcqjgV0pAhNFyfvJSUK6zN+jedflFqOUS2Oiwu156In5l668ILZGJEclb5hmKPRp02sNc5XRiKqwhCknCJdrHcF3X2moyG2JV2/9nsrD5OzBW3EnPrx6B7vaNLcBDKZgWdbVnJSD3Zbe/U0Jp6aRsElaZ6gFvClD9blww/N1ebx7y9KNFx6HreFOcGd81KAkj3HL+gqAMUbkQlC8syIad7PGOtN3FC2R0+JGCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDIVLtFAE5WtSCAnbrmdnkSk8VGa2Qd6KLMhPhs1DPs=;
 b=fddOIucGgb8HCTkP81fRwRe4cXFgbpMad+O7aXR8NOlchyBFiCLxj39Z+Z50mOF/Ox80ZS6vdDZdmE/qX06msqRY+ZkcmDkg+KhhM9Ul/msHkSiEHSjKDjIPErE9TFnD8tXEEJWwcVx/AkgCxU+Lt9dX2YpYbDR0A/H6LYcHAhYARNEbOp/1Q1KsDbu7RA2fzgg3MO1qn8Ur9SeXS2JOQdUxcnnfBPhd3p8pdyDoB1FvHmUo2bC5E2fun7OrEvSb0GtpZnQJ/S4jNRGQt6qnF5GCfP72C9R+JB7Q7AY39r2z5J25giTULox5dzRJbJl7Eo4v8UX3UEiKMzlSaJUcwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDIVLtFAE5WtSCAnbrmdnkSk8VGa2Qd6KLMhPhs1DPs=;
 b=0seIzXBEf1VZgT3tnmUe5A4VlaQhz7ncPiqACi+NLorUtbWpDJttoMycVfO6fB8fDszNDTkk/ZQv1p0gDnTumFubTU0igpQgvxyYygcYOBVAktuatPGoEviNwYadlXwa94KlORZjP0kcCJ7FE1AW366R9PARimDm1+8pnjXrJxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 20:36:03 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c%9]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 20:36:03 +0000
Message-ID: <6f76fe2b-63ea-8c45-87d8-3de30d3d76c2@amd.com>
Date:   Tue, 31 Jan 2023 14:36:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 6/8] crypto: ccp - Add vdata for platform device
Content-Language: en-US
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org
References: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
 <20230123152250.26413-7-jpiotrowski@linux.microsoft.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230123152250.26413-7-jpiotrowski@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0178.namprd04.prod.outlook.com
 (2603:10b6:806:125::33) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|LV2PR12MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a7983cd-e4fb-4a12-dbb4-08db03cac53f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8MiLdqqIhGufY0koA255GV+cSLsxmqbAwuBU9zxoY2/ym8HdETtt5mNjybQ8Xku9+qNo2dc89WoQI4kRf2Yrc/gYY4o8JRH3+mxWboolXGUIGv0PtOiW5HLPGPKYHxPvP5GoIR58cJtHN0HkqF02XGowHBkX2v6XkrfINJUqRSiVvX1dzJ0I/6SO+jBvoo0aN+Jkj3zhciqVsJQ52yX1HTG/gIgvEZ8tY0j9vI5UswN7o9DKUnGqjWm6/ux2OI34JzOGNy276mAFzUgYJtLr58OIBTKYSVLVISaVyP3/6+bUjWjUgEFgkThWAtqWsbtv/K2UR28fcx6zsyyX2F3VcFAWHVZ77LtdZszGw1M9uJPhUlgD3EvmKFJ8z8Ai2Q3GhdEY0TbS+W8/c5zUi5X5sVqKF27s2DDMRCEuPOJBEW7H1Qqny3fhP9Qfx0P+9/bUAjx3MEYAO9gFhOPfoQ1S1ovplpdDB1ZOqRJ8McXSpL/ZpSxoQ3F5kBc5v0wCVelHHKodct888LJ14vPKF9vqNlc6RVwTYquw1/cbSN0XBuXnEiVs9kVI1PGp+HVX89mmLmWUhq9CDJbwA+kNUM2iT+S+YMUtOP+XTbyLAzqFO/6EEnv8p7tX3knExcYX+RXcYOVFYjd67+yvfcJfNGlGy3uMJoyT/8ppyIh2+a/LBS/P+3miif08IGi5G2SqKPkuVnH356Td20TSrcAByr7JtWaoWBQS9NHKiglDSLjDwno=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199018)(66946007)(4326008)(41300700001)(31686004)(8676002)(66556008)(66476007)(8936002)(316002)(54906003)(5660300002)(6486002)(83380400001)(186003)(2906002)(36756003)(6512007)(478600001)(26005)(2616005)(53546011)(6506007)(31696002)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVBsM0hHYXM2eUtNaGdtTzB3eWxqKzNHQ2NEbHZwcy8zeU9KRklFdFNvVnpo?=
 =?utf-8?B?c0lsditCUzZLb2dwUVF4NW9mbkRyVTRDcmtOak5MNUJVY1Yram9CUWgvSnZq?=
 =?utf-8?B?U0MxTTJxaUQ0anlyVHArdkZPTTRNaVJSQ1dnejg4KzlZZ2dnRFZnT0NGUlBp?=
 =?utf-8?B?RTg1WE5DbGNwMXB5SVllak41UFNqbUJadTZoeXUrOG5ieFhCaDJycHBUNWZY?=
 =?utf-8?B?SGxJaTRRSmcvVWhYRTZVQzVIMjFtTXNWcmxBdVRFVkdYTDV4ajB0Si9XN3BZ?=
 =?utf-8?B?RmtRVUZCR3JjRkpwZkt0Zk5RWE1BQlpIbkZrbFlmTE9JR051LzNjQ29Vbjhp?=
 =?utf-8?B?Rkl1dUIyOUgwS3NqTGxxWUUxQzZPWXk4bC85WndTMzE1a2tmZ21FVVdseWRK?=
 =?utf-8?B?ZDR1MGxaL2FDSnBqMjZSRnNXQWd5SDlyQ1dndUFjZzZlM1JmdXgvN3A0ZnBr?=
 =?utf-8?B?Z3FZd3ZleWxxdnp0Y0NDVGVNNGZkalJ4Z052bWUrMkV2OFRMYytWSUlZaTk0?=
 =?utf-8?B?azVaZktrOXQydXRDOGdhVjBGZHR0QVJ0bzdCVkJ0TWhzOWtBeXgzWmNqaE9v?=
 =?utf-8?B?RFRsVllnRndtRVJTOFRqcVlVV0xrL1pBbkw5NHY2NjhCQ2NzNXEva3hYRmdv?=
 =?utf-8?B?dllFRlNCMmJhL0dRL1JLdnFWekJJQzFsM1hkVG82YWJ2ZEJvYTFrWkJDTVpj?=
 =?utf-8?B?YWF4dmt4ODQrRnhuVE8reXZtSFJhb09CVVdUY0t1T2cvVGM4YWw3NDY5NHVK?=
 =?utf-8?B?SDRVK2xuZncyQUdRNnNjTUJHUEZlRm1ha21MTGtXQllmbWgrLzZCRGhpQWRP?=
 =?utf-8?B?K2dpczdLZ211YzJhcnlpUm1PQlNBTEM5b2szdGlQNzdJUjF0QlJ5ZDNKK0xZ?=
 =?utf-8?B?VHdvazdGTHVpcm1TZmhLMllDQnorQ1hYV1YvUVkrWkdycHN4V1FwSG1hRkwv?=
 =?utf-8?B?cFBWY0pVTHp0Qmd4emRiZmE2bVpYMmlXbERrWjY4RnR6OVNzdEwyVFlNWHR1?=
 =?utf-8?B?M2NrTVJJL1FlUkloaWNjWC9OMVJmb01XbU91SVF0UkRFakcyeFpqejR1TXla?=
 =?utf-8?B?N0R3aG11WEJUMkhzN2tJeFZDUXVkRldNUnJMTHIvMVMzcmErWmw5WHkzTk9S?=
 =?utf-8?B?bjdzK0RGQzJlaEVqM0dsQ0U1aTZtUG9hMjdmNy9sS3FvZWlIZjd4WVFsUk1y?=
 =?utf-8?B?N3pmLyt5UnF2Zm8zUGpDcGZONEp4dUFBRzFhVTRKUFF1eEw2VVpCQ1lBOTVU?=
 =?utf-8?B?TENBcmYzeDFCeENQLzJUSGNlU2RkNGxsNTlSQjBqeUNxWm5RTjdlQnZsWUlE?=
 =?utf-8?B?eUJkeExuM241Y0krQ1RmcEpiMFBpekNjdUJqNmZjRjBOZjROYUVyaXQwZHJ3?=
 =?utf-8?B?Q2VPcHhic09ncTlsN29ubUNtMitHMWluQzFnaTh4TWxCckxQTTY3ZWxKbkQ1?=
 =?utf-8?B?M1BjQWRsMG9OQ1hFbUZmQ21DV0lVeFkrOGhPZ0VYd0tJeUhJenNmdnlWQ0Mr?=
 =?utf-8?B?WXdXOFpZcHFTL3VLdmxoK21RT2xBVi9zUmgwNWF6d0Nud2N5eTFSdy9BZVNN?=
 =?utf-8?B?dmNvL3dPRklHc1RQWEYwdUNvWjFDTHpPR05mMHVlc3lQTVlTUU9uWjBISFUv?=
 =?utf-8?B?V2g5VHVWNFZnbG0xenJuSjlFRjg3S2VDVk9id3RrZTA3dnZEd3VvM0VnVDRl?=
 =?utf-8?B?amRPdTdYekxvdnp4aDloWWxSd1g4eVZlTldiRUFIUVpZMmQxZGR2QldaMlN2?=
 =?utf-8?B?VHZWaEVudUFaRENNRnlXZDJYcHFFdno3a0J3OWx5RVRSdlpUM3RxMjQ0M0RG?=
 =?utf-8?B?dUV1N2VNR1dDS2MvTHJrUVY4UEEwcTNzRkRERzNDRS8wUEVUMUFDZGQ5MlBG?=
 =?utf-8?B?MlRPSE1QWXk1aHcwT2pJRll3aEFOYkpYYWtueUlROGtKMHdHS05sN0VNUFhu?=
 =?utf-8?B?dUw0REV4UVJOYkxJakRJYWxOODMzYnp1UnJ1cDNvTHVCZnJGWlBqRWxhMU5F?=
 =?utf-8?B?UHVZaklQWEVJWjhiY29aZWlvQzBWd2JKZmdsa1kyRjkvNHd0akNWK003ZWg4?=
 =?utf-8?B?VHg2eXdWUHZnWlFGZlVNL09ZbXFGdEYydXRWTUMvS1lVejQ0VDNKWTBZWlRh?=
 =?utf-8?Q?ZNHPUWXIxj9OPLfgviZwBAQHR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7983cd-e4fb-4a12-dbb4-08db03cac53f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 20:36:03.2505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VT6h/q7ShEp+y2cp2KUsxF8ET6ZPIZ5MD7suh7/iJ+Sv2Ptt0bQmjRlvPo6fogRUqUxfsUue4JwutDJ0XFfW3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/23 09:22, Jeremi Piotrowski wrote:
> When matching the "psp" platform_device, determine the register offsets
> at runtime from the ASP ACPI table. Pass the parsed register offsets
> from the ASPT through platdata.
> 
> To support this scenario, mark the members of 'struct sev_vdata' and
> 'struct psp_vdata' non-const so that the probe function can write the
> values. This does not affect the other users of sev_vdata/psp_vdata as
> they define the whole struct const and the pointer in struct
> sp_dev_vdata stays const too.
> 
> Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
> ---
>   arch/x86/kernel/psp.c            |  3 ++
>   drivers/crypto/ccp/sp-dev.h      | 12 +++----
>   drivers/crypto/ccp/sp-platform.c | 57 +++++++++++++++++++++++++++++++-
>   3 files changed, 65 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/psp.c b/arch/x86/kernel/psp.c
> index 24181d132bae..68511a14df63 100644
> --- a/arch/x86/kernel/psp.c
> +++ b/arch/x86/kernel/psp.c
> @@ -199,6 +199,9 @@ static int __init psp_init_platform_device(void)
>   	if (err)
>   		return err;
>   	err = platform_device_add_resources(&psp_device, res, 2);
> +	if (err)
> +		return err;
> +	err = platform_device_add_data(&psp_device, &pdata, sizeof(pdata));
>   	if (err)
>   		return err;
>   
> diff --git a/drivers/crypto/ccp/sp-dev.h b/drivers/crypto/ccp/sp-dev.h
> index 20377e67f65d..aaa651364425 100644
> --- a/drivers/crypto/ccp/sp-dev.h
> +++ b/drivers/crypto/ccp/sp-dev.h
> @@ -40,9 +40,9 @@ struct ccp_vdata {
>   };
>   
>   struct sev_vdata {
> -	const unsigned int cmdresp_reg;
> -	const unsigned int cmdbuff_addr_lo_reg;
> -	const unsigned int cmdbuff_addr_hi_reg;
> +	unsigned int cmdresp_reg;
> +	unsigned int cmdbuff_addr_lo_reg;
> +	unsigned int cmdbuff_addr_hi_reg;
>   };
>   
>   struct tee_vdata {
> @@ -56,9 +56,9 @@ struct tee_vdata {
>   struct psp_vdata {
>   	const struct sev_vdata *sev;
>   	const struct tee_vdata *tee;
> -	const unsigned int feature_reg;
> -	const unsigned int inten_reg;
> -	const unsigned int intsts_reg;
> +	unsigned int feature_reg;
> +	unsigned int inten_reg;
> +	unsigned int intsts_reg;
>   };
>   
>   /* Structure to hold SP device data */
> diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
> index ea8926e87981..281dbf6b150c 100644
> --- a/drivers/crypto/ccp/sp-platform.c
> +++ b/drivers/crypto/ccp/sp-platform.c
> @@ -22,6 +22,7 @@
>   #include <linux/of.h>
>   #include <linux/of_address.h>
>   #include <linux/acpi.h>
> +#include <linux/platform_data/psp.h>
>   
>   #include "ccp-dev.h"
>   
> @@ -30,11 +31,31 @@ struct sp_platform {
>   	unsigned int irq_count;
>   };
>   
> +#ifdef CONFIG_CRYPTO_DEV_SP_PSP
> +static struct sev_vdata sev_platform = {
> +	.cmdresp_reg = -1,
> +	.cmdbuff_addr_lo_reg = -1,
> +	.cmdbuff_addr_hi_reg = -1,
> +};
> +static struct psp_vdata psp_platform = {
> +	.sev = &sev_platform,
> +	.feature_reg = -1,
> +	.inten_reg = -1,
> +	.intsts_reg = -1,
> +};
> +#endif
> +
>   static const struct sp_dev_vdata dev_vdata[] = {
>   	{
>   		.bar = 0,
>   #ifdef CONFIG_CRYPTO_DEV_SP_CCP
>   		.ccp_vdata = &ccpv3_platform,
> +#endif
> +	},
> +	{
> +		.bar = 0,
> +#ifdef CONFIG_CRYPTO_DEV_SP_PSP
> +		.psp_vdata = &psp_platform,
>   #endif
>   	},
>   };
> @@ -57,7 +78,7 @@ MODULE_DEVICE_TABLE(of, sp_of_match);
>   #endif
>   
>   static const struct platform_device_id sp_plat_match[] = {
> -	{ "psp" },
> +	{ "psp", (kernel_ulong_t)&dev_vdata[1] },
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(platform, sp_plat_match);
> @@ -86,6 +107,38 @@ static struct sp_dev_vdata *sp_get_acpi_version(struct platform_device *pdev)
>   	return NULL;
>   }
>   
> +static struct sp_dev_vdata *sp_get_plat_version(struct platform_device *pdev)
> +{
> +	struct sp_dev_vdata *drvdata = (struct sp_dev_vdata *)pdev->id_entry->driver_data;

s/drvdata/vdata/

> +	struct device *dev = &pdev->dev;
> +

Should check for null vdata and return NULL, e.g.:

	if (!vdata)
		return NULL;

> +	if (drvdata == &dev_vdata[1]) {

This should be a check for vdata->psp_vdata being non-NULL and 
vdata->psp_vdata->sev being non-NULL, e.g.:

	if (vdata->psp_vdata && vdata->psp_vdata->sev) {

> +		struct psp_platform_data *pdata = dev_get_platdata(dev);
> +
> +		if (!pdata) {
> +			dev_err(dev, "missing platform data\n");
> +			return NULL;
> +		}
> +#ifdef CONFIG_CRYPTO_DEV_SP_PSP

No need for this with the above checks

> +		psp_platform.feature_reg = pdata->feature_reg;

These should then be:

		vdata->psp_vdata->inten_reg = pdata->feature_reg;
		...

> +		psp_platform.inten_reg = pdata->irq_en_reg;
> +		psp_platform.intsts_reg = pdata->irq_st_reg;
> +		sev_platform.cmdresp_reg = pdata->sev_cmd_resp_reg;

And this should be:

		vdata->psp_vdata->sev->cmdbuff_addr_lo = ...

> +		sev_platform.cmdbuff_addr_lo_reg = pdata->sev_cmd_buf_lo_reg;
> +		sev_platform.cmdbuff_addr_hi_reg = pdata->sev_cmd_buf_hi_reg;
> +		dev_dbg(dev, "GLBL feature:\t%x\n", pdata->feature_reg);

s/GLBL feature/PSP feature register/

> +		dev_dbg(dev, "GLBL irq en:\t%x\n", pdata->irq_en_reg);

s/GLBL irq en/PSP IRQ enable register/

> +		dev_dbg(dev, "GLBL irq st:\t%x\n", pdata->irq_st_reg);

s/GLBL irq st/PSP IRQ status register/

> +		dev_dbg(dev, "SEV cmdresp:\t%x\n", pdata->sev_cmd_resp_reg);

s/SEV cmdresp/SEV cmdresp register/

> +		dev_dbg(dev, "SEV cmdbuf lo:\t%x\n", pdata->sev_cmd_buf_lo_reg);

s/SEV cmdbuf lo/SEV cmdbuf lo register/

> +		dev_dbg(dev, "SEV cmdbuf hi:\t%x\n", pdata->sev_cmd_buf_hi_reg);

s/SEV cmdbuf hi/SEV cmdbuf hi register/

> +		dev_dbg(dev, "SEV mbox:\t%x\n", pdata->mbox_irq_id);

s/SEV mbox/SEV cmdresp IRQ/


> +		dev_dbg(dev, "ACPI cmdresp:\t%x\n", pdata->acpi_cmd_resp_reg);

Duplicate entry

> +#endif
> +	}
> +	return drvdata;
> +}
> +
>   static int sp_get_irqs(struct sp_device *sp)
>   {
>   	struct sp_platform *sp_platform = sp->dev_specific;
> @@ -137,6 +190,8 @@ static int sp_platform_probe(struct platform_device *pdev)
>   	sp->dev_specific = sp_platform;
>   	sp->dev_vdata = pdev->dev.of_node ? sp_get_of_version(pdev)
>   					 : sp_get_acpi_version(pdev);
> +	if (!sp->dev_vdata && pdev->id_entry)

Move this pdev->id_entry check into sp_get_plat_version(), returning NULL 
if not set.

Thanks,
Tom

> +		sp->dev_vdata = sp_get_plat_version(pdev);
>   	if (!sp->dev_vdata) {
>   		ret = -ENODEV;
>   		dev_err(dev, "missing driver data\n");
