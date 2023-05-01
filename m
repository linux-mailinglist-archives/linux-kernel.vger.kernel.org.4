Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B76A6F35DE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjEASgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 14:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjEASgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:36:22 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3E7E4B;
        Mon,  1 May 2023 11:36:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2tKpsWJDgTGJ6OyjX4OJ8CQCK0SjcMCeZkBQjuL4AirvtVlBVGVxhk+2LQrqpj4JfiLYj11GJIxXJzasqUSy6FMrBhlXCZ8ib8Z0eLPIDMpN3EIlZQvQguqpv9G2dIIq2BsYDFSYBX/H8R00pSnxkDvUXnTWWg8RcdAlXAlZ6Vw0ueNgAAdiyr8/Cq91CBSCHJ9Wqv/GNGx+/3J2bwKh7IbSJrA6dQZlL/tX/1CAt9OJ8wjzPyaNNglEDsuinxXKkeSunKavaxGhhwlofChu+7V7qEOT00Jo9pMq8njBqXlHyB1fEot9jd3wENGEFcXfGn5+IT93/5MZ6xbqSOK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjzAGzjDquYCe+ZX54yJYVnXdZhqZuNpqlDoqVoRXjQ=;
 b=O3ZiAhZpGM+vYMLs+D4by54LCGOANaodlBGQB2/Bq+n28RHuG/YH1G30T3aq4lziee0IcuPPut2YSw6Dm4jUJxBxM+VdyyR0WtFp09bIm9l2eHEXygHiyueRUd9X3gve1xLpGBJEhn+wCiXzLXTmsG9AynFiL9f42UKj6bKgPQdCQIp5rCnOK8FHMGu2DXiRDXhPjNyh1y4gtIk16I2KCJ8eYkrE0hdU03RS//UEDzd2SLDXcW9WvJYnspJWqHAfAm2fE1PQ92FyaBWv6AVUU8rAf5FpodjgcE7SN/Jt0le24SNRvIamZMIuBJH4bpXSj1UWYj37Dpb0BVB3hwcDhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjzAGzjDquYCe+ZX54yJYVnXdZhqZuNpqlDoqVoRXjQ=;
 b=EE09CUgr105MKYe5tSeDdWb3ssr5H+TK7nzUEuaRIr/AevtpkZsC57IZH6e9H+xerxAmf4qLpi2bHHRQGUqhZkamwvck4lZh3Xs4TGemm78Q03M4GJSlr8OcnReths5xphovBHWDfBxViNb1lo+Ve2bBZ13fY+S7f14sMXAe2Tw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CY8PR12MB7708.namprd12.prod.outlook.com (2603:10b6:930:87::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 18:36:18 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 18:36:18 +0000
Message-ID: <83fd1a29-3af2-e2b7-02ea-edbaead8103a@amd.com>
Date:   Mon, 1 May 2023 13:36:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 01/10] crypto: ccp: Rename macro for security
 attributes
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>
Cc:     David S Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230428185543.8381-1-mario.limonciello@amd.com>
 <20230428185543.8381-2-mario.limonciello@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230428185543.8381-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0018.namprd12.prod.outlook.com
 (2603:10b6:806:6f::23) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CY8PR12MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 573fa655-cbe8-4129-f8c9-08db4a72f3d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +XH6VoDs4+hrRRvno3EX7rBddKrhQlZVFd/9f9tJIAlqk3CnYojesAbQB03zQi5V0QV+OEBd2gf3U1+538DVpilno38Mx+iFRpCSgb2+nNTjI8GHxxQpK3yhRlV8G7tItkWOE1Cyeeo2L+8omk0OlLoNjcBGThw2UDe+PgzZUcVOtIEKX11KYmERtCMdGoHOAGiGS0lYZsOYuKrkXaOXp+vYlWMI4hD/4EWDI3TNQU53y8FWSpMePngihD4Suvbw55F7mu8WoBkgATB0O/DPEW3CdHPIp8icKOJz+2PiGlCnnQWxgkx2W0fuCzh24GIAlPgmLh6bCYtmTXqCJ09hWnNELbRngRJTqbFS7/iipfDz1GLE57jZ+IZNns825cCqr/qmVwpCOprHXszLEpeKfDcgKHPTM6nmOZMOWvkZoWX6NwJi8w9c8nWD3OEJryEEG9J1T4FTyLais3Q0N0LqrhVVDGi6Dyy45WRrYtS4QeGkrOjFIhu/ci241wuI5dYBhPq5Z7KcLmQUPQs+PjRy8WJKPEv9bo8gRFTI+f1c1MTh10OVXS90O60PpntXqB0nQs9GClP2vqPKECSHWhWzOi8ptU1ymKALuWxw0NfzkWoOSRZXCKbDylwuYM8XUwFHkMDtkoHmuNR/y65vd/FqkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199021)(41300700001)(8936002)(15650500001)(5660300002)(8676002)(86362001)(31686004)(83380400001)(31696002)(38100700002)(316002)(2616005)(26005)(6486002)(478600001)(110136005)(36756003)(6636002)(4326008)(6666004)(66476007)(66556008)(66946007)(2906002)(6512007)(53546011)(186003)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ri8yRU5GREg2R0duR1NoQ3Q1andjclVCWlkwZlV2RVV4a29zc3ovQVNJRTZo?=
 =?utf-8?B?WGhjNlZnaXpVNGFxNUZweHpxRGJzejBYbGh6cWVpNTRSYlVXOERpQmgycmRT?=
 =?utf-8?B?TGdIVldrNTROTmh6MTJwY2k3ekhaTHBSdU1VajBuRmo1ZHhyZVpZUVpaY3Fi?=
 =?utf-8?B?T2VCMm1GOGpKWmQ5aUcyVFNUSUxJcGtLc0FjWUJjUzR6U3ViS05KQnNZMGZ2?=
 =?utf-8?B?Q0tnaEVOcFJ0emRFSldNZ2hkMlA1VkMzRW53azZsMDYxV25jUkU0T1dDTUNh?=
 =?utf-8?B?cmZTQWFudnorSEpLdjBnSXlrak5ZcEt1QjhZVFdDOFpJampRWHZmNXFPMVBn?=
 =?utf-8?B?QTk0UnBjMGtZZFV3OERselFnazdOTWg2Y2tEY3dYSTUzcmVzOWRsaFUwNVky?=
 =?utf-8?B?TVV1TGt0YkNlc2w0OFJVdmtRLzNQd1ZoUkNVbG52cXpleVdod012VXFFa1NY?=
 =?utf-8?B?L2xKZnZXT05KS25OeWN2VVZFdjFMdUVQek01Tk9MTW11TGYzdkJsUkxhOUVz?=
 =?utf-8?B?MGV6SlptTTljYkwzbkpqWWJyWUxWOEdTd3BPVHBRL3FmZjZtcUYwSXR4MjIv?=
 =?utf-8?B?QXk1dnMrV0F1SXcxbzlTZkdqeExpc1NBcnc1ZkExZHlCa0NrcWozVFlHY2tu?=
 =?utf-8?B?Ri85aCsrMGU1cElMaW9JSDZiclVoSDRDMzNRY3dGMkFiN1Zkd1ZzNXMrakJ5?=
 =?utf-8?B?TWpQMGY5MUVOb3J0RmV2cFIxWUtud0hNMVU2ZUFjYlFmYU41aFd4MnR0Z0NE?=
 =?utf-8?B?S1R3Tk1qdjN0VUJqbVVSWGFBN0IvMkxjdGtQeC9maHcyV0JNQ1JsTE5Ba09x?=
 =?utf-8?B?K1oreUFBUW5PQUZDZ2lyTFpJSmZPS3FJZi9tSkhKV2dpL2lRRWJORTZ2aHhV?=
 =?utf-8?B?Z3dhTlM5V1p2YnVpcks3aG1seWdiWEZ1S0xFdkJVejRMTTQrNVRLQWJvV1FL?=
 =?utf-8?B?N01JaHVXNW15QjIrazhoK3JwSTRyOEFmSWwrSGsydTNVR0ZJNHBuV2l2OXJF?=
 =?utf-8?B?WWNqR1JwZk9Ddi9TeWwxbU55SHJKdFBYOFdMQzM1ZHNhb3hvRWtST05QdFR0?=
 =?utf-8?B?UThXMTlBQTVPaU9vaStCdmJJSEdjazlFZ2ROOE9aV2xleWRJYWNudWJzWU56?=
 =?utf-8?B?bCs0M29LQW8xeGJDWisyZldvaEsrSDV2RkRScFh0SnJ4cXZXbndId2xQNGFZ?=
 =?utf-8?B?NUltOVZ3TkpGL0tkK2JHSk5WUzFCc3NqN0tDY0piZDJ4WHZVVGNUcUJOc0Vm?=
 =?utf-8?B?RlpKR0FCWUd2NDQ5Mi9VZElheWZ0Qm44M1ZuUFlTK2Vua0ZHdHI4b1hRTDU1?=
 =?utf-8?B?YmZSQlkvRG1yK01aYlFkNTB4ZFI4YzYvWmNzZ3JhSWZEbUpUMjBBa3ZXbGVG?=
 =?utf-8?B?M1Y5L3BlWHJuMVpvc2ZzeFVEVkZGYzVWa2ZpNFk3TndnQVRockM0WFFhVGNB?=
 =?utf-8?B?dk8rTDBCb2tSK0xJR3lVRmhMQzBpOWdMWnR1a3hqMHV2cVJmcUwwSUN1RzVm?=
 =?utf-8?B?TUVPcmxLeWVJc25kOVRaWlBZa2VOa2tLUEFkaXZTM2Q0Q0FuRml0SFlZQlFu?=
 =?utf-8?B?aWcvTmlQbVl3UmVaY2xXTktRbDhtRkQ1eXA3NzZwQ0lnUXpFY1ZNSjVZQlFD?=
 =?utf-8?B?T0VMTVh2QjJYcWg3dkI5NFpBdGdGMGN5MXQvWk81TG9nU3NXT1p1RFYrMWZ0?=
 =?utf-8?B?K3M5NzEzMmJYY3gxODhweXJkNSszSEtVMlFOTlptN0dHUU4yNCtITkNvQVMw?=
 =?utf-8?B?VmpuMy9pVVZ0c2o3eExlTERCekhzeG9IOHdWRFd4QTlkdGhXYWw3dTZDWnRt?=
 =?utf-8?B?YWJ2dWp2NFlEM3dybFhTNlVGY2NwZmVoaXFSRk9EcDN2Mm9BeFhwbkh4QjRS?=
 =?utf-8?B?ZDB2Rmp0elRTVWY4MmhSaFRqdmUwWTczUFhhb3VBblNJT2kwakVVeFhrOU9R?=
 =?utf-8?B?ZDJMQVNBaWlGTW5rWFRHVDR1L3FpcUs1aXRhS2k5TmZ3MkRVcXVqbVlmc3RU?=
 =?utf-8?B?SUp1azF6QytMWlgvK3BHdEF1OFlVMmZYR0djRUZ3clB6ZU1MWEs1QkppMkVE?=
 =?utf-8?B?V2lWdTVDUCtFVElFTDh2S1ExczJRV0ZMSWREcTRnZGJwTDl5VWIzWVNKbjdU?=
 =?utf-8?Q?iqIeOzVxYDCAY44ULlsb9LLAE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 573fa655-cbe8-4129-f8c9-08db4a72f3d7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 18:36:18.3226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aefCNLGHCdt4Cn9GJ46gVxzRg5jj38iSQ4KSBBUyEY2c+Oq7A+P1C+RWc/u3aCaTXH75jzlzQgbGwFWzB1uhDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7708
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/23 13:55, Mario Limonciello wrote:
> The attribute_show() macro is only valid for determining the availability
> of security related sysfs entries. Rename the macro to better show this
> relationship.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   drivers/crypto/ccp/sp-pci.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
> index aa15bc4cac2b..85e3dc8853e2 100644
> --- a/drivers/crypto/ccp/sp-pci.c
> +++ b/drivers/crypto/ccp/sp-pci.c
> @@ -32,7 +32,7 @@ struct sp_pci {
>   };
>   static struct sp_device *sp_dev_master;
>   
> -#define attribute_show(name, def)						\
> +#define security_attribute_show(name, def)					\
>   static ssize_t name##_show(struct device *d, struct device_attribute *attr,	\
>   			   char *buf)						\
>   {										\
> @@ -42,24 +42,24 @@ static ssize_t name##_show(struct device *d, struct device_attribute *attr,	\
>   	return sysfs_emit(buf, "%d\n", (psp->capability & bit) > 0);		\
>   }
>   
> -attribute_show(fused_part, FUSED_PART)
> +security_attribute_show(fused_part, FUSED_PART)
>   static DEVICE_ATTR_RO(fused_part);
> -attribute_show(debug_lock_on, DEBUG_LOCK_ON)
> +security_attribute_show(debug_lock_on, DEBUG_LOCK_ON)
>   static DEVICE_ATTR_RO(debug_lock_on);
> -attribute_show(tsme_status, TSME_STATUS)
> +security_attribute_show(tsme_status, TSME_STATUS)
>   static DEVICE_ATTR_RO(tsme_status);
> -attribute_show(anti_rollback_status, ANTI_ROLLBACK_STATUS)
> +security_attribute_show(anti_rollback_status, ANTI_ROLLBACK_STATUS)
>   static DEVICE_ATTR_RO(anti_rollback_status);
> -attribute_show(rpmc_production_enabled, RPMC_PRODUCTION_ENABLED)
> +security_attribute_show(rpmc_production_enabled, RPMC_PRODUCTION_ENABLED)
>   static DEVICE_ATTR_RO(rpmc_production_enabled);
> -attribute_show(rpmc_spirom_available, RPMC_SPIROM_AVAILABLE)
> +security_attribute_show(rpmc_spirom_available, RPMC_SPIROM_AVAILABLE)
>   static DEVICE_ATTR_RO(rpmc_spirom_available);
> -attribute_show(hsp_tpm_available, HSP_TPM_AVAILABLE)
> +security_attribute_show(hsp_tpm_available, HSP_TPM_AVAILABLE)
>   static DEVICE_ATTR_RO(hsp_tpm_available);
> -attribute_show(rom_armor_enforced, ROM_ARMOR_ENFORCED)
> +security_attribute_show(rom_armor_enforced, ROM_ARMOR_ENFORCED)
>   static DEVICE_ATTR_RO(rom_armor_enforced);
>   
> -static struct attribute *psp_attrs[] = {
> +static struct attribute *psp_security_attrs[] = {
>   	&dev_attr_fused_part.attr,
>   	&dev_attr_debug_lock_on.attr,
>   	&dev_attr_tsme_status.attr,
> @@ -83,13 +83,13 @@ static umode_t psp_security_is_visible(struct kobject *kobj, struct attribute *a
>   	return 0;
>   }
>   
> -static struct attribute_group psp_attr_group = {
> -	.attrs = psp_attrs,
> +static struct attribute_group psp_security_attr_group = {
> +	.attrs = psp_security_attrs,
>   	.is_visible = psp_security_is_visible,
>   };
>   
>   static const struct attribute_group *psp_groups[] = {
> -	&psp_attr_group,
> +	&psp_security_attr_group,
>   	NULL,
>   };
>   
