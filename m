Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1636E9C5B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 21:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjDTTRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 15:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDTTRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:17:16 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27674103;
        Thu, 20 Apr 2023 12:17:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmi35y5xQi2OwHvHrvJ7IjegvoS2IgyC8xJayxTHYyAFTIFgNKNX2Z0rWjo3itcq2uC+54VY2k/UlV3UptaMVmEWCvpX3sIFZXwahyGIcM1JGi2DnF5isg4wbkX0qTA7WuLYJBFHa9q2RAXzXjzOy58GJ5WTMq7eMxstOuhh6Io1JFq7GC83kf392Jl9zTdS6OEbpB+wej831nRLK7TsB8g2D7YhmwY/QHszH4M3W3D6oRjU/D1MzEfs8wLCkNwvfPOwTYS9i51mN10Up5yXn4HRitkvaTdLh+PY0JiQ0nPte7zutRBC/Pn1K2BMzmuhWeNTlJA3oo/qUp7eLKM0Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Q2Yb/b9wn8pnrZAmTupTzd+Bi0gUhNvhdkRj5poiNQ=;
 b=YlkoavgWvZfQ0YeaBZ19wREDd5bQMnFAIhG2V/K2vLq0SF5bFPKLYn5y6mH1rIp3U54Sdt4OHYOuRTVE9XQkJEp17Y/uhQKgU/LW+U8wo36UwfTFs4CDQxZ4bFOf/iOlLL9emYijbR7cQNw3xKG2yM9WbIfZamVGjh2hCYSpd6dg9pG+g4bLaVBiylmWTQu7HTnkkFO1NDBq4Rc3Ryc4G0NoHwR9VBL9FRAiyUJUKFblMlMTYxdDnW//JS3E7rLIZceAdTjJimPs5UrjXyMf7UvAjK8BcNt2Q5uNt5y+/qghmtHvWNkWAnRsTRIDDbhsyyrhTYxDWStOdbmnftaVtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Q2Yb/b9wn8pnrZAmTupTzd+Bi0gUhNvhdkRj5poiNQ=;
 b=qIt8gckrADSejnnd/T5HyXWnQyHMJMOgI7/m+RBtAP+1Z46SiSlnyZlmEqHErTG7d8PBK9e4b6gBlNLTjavPnFAyTU5D3vChG/tw3VK6fKXGDk9kyhgFho+br684ViyzspYl3uuu5Sdm4qOCdS15TkTWaGfD3XOK4Lg5tcUdod8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by LV2PR12MB5919.namprd12.prod.outlook.com (2603:10b6:408:173::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Thu, 20 Apr
 2023 19:17:10 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 19:17:09 +0000
Message-ID: <2a296473-3abb-a1d0-93c6-42b074ca9f7f@amd.com>
Date:   Thu, 20 Apr 2023 14:17:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 02/10] crypto: ccp: Add support for displaying PSP
 firmware versions
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
References: <20230420163140.14940-1-mario.limonciello@amd.com>
 <20230420163140.14940-3-mario.limonciello@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230420163140.14940-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0121.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::9) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|LV2PR12MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d7e86e8-1b8e-4196-2a49-08db41d3d677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V3vXEjPftjTQz0SujCOho6onQ9hA42pnc36iZ2yn2hnh2hfp4hrxsFtNtR88RqoQvqyLvuTFm+NvyLzaJz9g7p36CWH12wUmXhbVrXE0t9qaLUIVJo6TU2NIEVJ6Y/FwO7L5WhfLTK/VGSZYKBUVYkrOL4/60YjBQoVruMX8SxXnO4Ln9nTypx/5te3jf3uc4CJaEnJuk/17Glx2VxV0+LLXt7Ughb1TkXYaww17JwnNDT0U3Jmp3uGYZAPQvmi4DhxU7ybTVbwsnLT1ETFPDbZLP7KpMZEax3H5UgOCxGyOKtb1/6xwK46DLH0NdAjk/CSR+qqrRwU/QaBEEMAA6HIJmb2/AASF7ya8wNbw5A2vYv6+JJ9vduHUIzTGwpzPlJetIgUDM9tPfxyFdacILIMPXmyuIGEaTIN+MBr0aNJ9LkQI9mfysWR4qOh7ZPjGFqTCAfGuKeJ/GqEd9e6Ah4hh894eV5XSotRkt3aMXrcRe/0v43MFG25GA4x214jx2Liex6AF5esz26HUP5EMw4JQvZM9QVTdLl0BB1WFFsILsrvawjjsPFJgO9Hur7/06ZjjI53Mtlr/3MU67TDJbmMvd2KQrJFvqnNoW9U2aNPj4eiMDUVrb5exrihh18OwEFYdSeQWqm4VOcjd933nQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199021)(38100700002)(8936002)(8676002)(41300700001)(5660300002)(4326008)(31686004)(6636002)(316002)(66476007)(66556008)(110136005)(83380400001)(66946007)(2616005)(2906002)(36756003)(186003)(6486002)(6666004)(478600001)(26005)(86362001)(53546011)(31696002)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVdKRGRzaFNyZUcreXpFTVIydk1QQ1lJcXczK3J3Q1BVU3NBYXJEdi9lVnh4?=
 =?utf-8?B?MFltMWpxaVM2Wk45KzA4Yi9Ud1Z1bStjSDZLVWpURHFnMXJqRkVDQzI5blpF?=
 =?utf-8?B?TTdiOFp4ZlFoUUtXOGJmY0VVV3JWdVpaT214WUVSUDlHMVRzbXFEZUdNVmZJ?=
 =?utf-8?B?UytyMWlPcTBHckFDMzhVcWsrTDFRRGRYNXJ2NTJxeEJsRXMzUERjdmtzeCsw?=
 =?utf-8?B?SVFFc3VjQTg1Zzh2QU1Vc3RvS3NDVVFyNWpMR0dLUmlxNjlPT0o0NTlmdGxP?=
 =?utf-8?B?WXcxUXA5YzBvOWEzY0pPbnh4TDBLWVRDU2UvSDdISWloRTVhUXhHeVZYdkZP?=
 =?utf-8?B?b1hOSFlUS2Fodzd2THVBYjVzRVA4djJCRUJPL2pQWlhtQ3JZQnR6dFB4VFJq?=
 =?utf-8?B?dlNFbnZidnJhM0RaRWxmb1E1MzM1TEw0c205Y1pBZ0RiaUFBMDI2ald2STM2?=
 =?utf-8?B?TTZ0WUVyQnJVc3pzRDVoc3FqSERKMzVBY2poZk5OUmxpeXo4dVVpR1RyYlFB?=
 =?utf-8?B?bTdjeGQzRjdYSGhNWDdjcXE2YnRzbmtRdTB5aDVGSGlRdTZOODUzblVrMVVx?=
 =?utf-8?B?cTA2RzNhZ1lVa2R5alc4OE9zVmFWbXYwNDVzV1NLcEhERW5odzhQZGxJWnFU?=
 =?utf-8?B?c0M1cnhwWFB3MTNER09sVEMrNjNKSWxreUI3QmNoMk80WC9keERySHhwZkR4?=
 =?utf-8?B?R0FIS0lrMndHbmxPclM2ZlRQeVVHTnhLeHNxVjlOenFwTDA4UkFoRHVLYXQz?=
 =?utf-8?B?Y0pKUU9XR1lvYmtyV3NpdFJTcnpTNHQ2QlU4MDduOGhvWEtWd2gwdk96c2Ev?=
 =?utf-8?B?TXFtdWVWTEF2VG40V3VRS0NLQ0FGd2p5S2VKTEUyN0lMZFpwSjd6bWNSV3Fy?=
 =?utf-8?B?aFRlaHMwQm1JcGxmK3JXdGZ4cmpTLy80Z2dXQWp1RWpndGc4dHpaN0krKzZI?=
 =?utf-8?B?b0x2MmpSZFZaWmpUeUMvWUFyemErcVMyQ3RoUDk2Q2g0eUhmaTFjdHpGR0RG?=
 =?utf-8?B?cnhWWnMzMUhyb29HdlFYRVI0K1RsWkRzdWZrVVFrYkdYRms4VDg2WkduZy9J?=
 =?utf-8?B?Z3NsTWQ4Vitidkt0K2dlT2M0ZCsvaGN1ODJWdVBvTWJ2OUJMcDBNN2pQRUZ5?=
 =?utf-8?B?ZVpkdk9XMUJ1MkZZK3o3YTN2MEVVWVJwSXNYeVpJK3BPQThWeTV4Yi9pRnRN?=
 =?utf-8?B?SzNyT3UvVVBvYzRXQkdPRkdpMTRWZkJPc0lJL3EyTC94V1JIRitWUzZUNTRj?=
 =?utf-8?B?Q2Y3M05OK2syNEVXNE9QYzBvdllVUE1sa09kN29Kenhock02MkErdzh5SkEx?=
 =?utf-8?B?aVB2eVQ1VkdVQ1c2ZUNpeG1JQVlyZGkySXh6aVAzU24vU0UzN0xzUWdYVmRu?=
 =?utf-8?B?VVp1blp4Z2JYQVU5Z1Boc2IrUjhsZWVJcFI2VEt4VlNBcEs3SFBpdE5MVXEx?=
 =?utf-8?B?ZUM2ZjdIU0VUa0FWQmtES3BOMUdHc004NWJEamEreGpOVjlHczhSZTBzNmkw?=
 =?utf-8?B?eWc0UFR3V0YzWFdpU2ZsQ3RDaE5QTjJ6dVp2Mk9EaDl2R2Z1SWZYUTFhTzNt?=
 =?utf-8?B?WkRNc1JTc2lyVit4Uk4rbjRqV1pwNm8wNTFhcUVyaC95WkZIQlk2Z2FnUHVB?=
 =?utf-8?B?anBxMTczYldCT0NzK3pucmFMNzJnV1N6NndFWERobFRpeVMyMitDSGIxMW1N?=
 =?utf-8?B?Z0JYaTF2Y2lnbGJCKzIxL2RqRXVkY3dQRVZpVE9QSVE1THFlb04yS1NMcnJ6?=
 =?utf-8?B?c3FFMkFQUENNQlRQeEludXNJeGZmYVNMUDYxQmN4UkpzUTlkM0VyT0QxN1Jr?=
 =?utf-8?B?MDYxUFczN0N4dzNORUFOUHVIdHBFSERra3BCODF5clNxYlViRTZ4TE5MdE54?=
 =?utf-8?B?M21JWWt6RzdrcFpOeSsvV1BJZC9LQm9zT1Npd1ZDcVJrNUJLV2dQeVgwOFk3?=
 =?utf-8?B?UlJwYjM1S1REbzROSWpyb0tCRE1FVW9PcUdiT3pxV3lqazBkcXpmU0lRSU5u?=
 =?utf-8?B?d3VZYmw3NldaSTNDLzZHRWg4UjJSelhaUDlwREhPVzBWbUQ3U3VBUEhBNnB4?=
 =?utf-8?B?MXZmdzZlQkZYYyszV2x3bHR6UENHam5VODZraDArUzR6cEpmR2YwZVBQQ2Ja?=
 =?utf-8?Q?9xEAYuYuyBshq7j9iWZ2DoBNl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7e86e8-1b8e-4196-2a49-08db41d3d677
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 19:17:09.7334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQNkkMY7/vm6lLhMvSxIGHDUsjQqRXOD7eQjl3hCTKSvB/roEDNRGaB9TvACOAbn6ljmsHan6JzNjVSi3yKqAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5919
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/23 11:31, Mario Limonciello wrote:
> As it's not always obvious what PSP bootloader or TEE version are
> present in OEM systems, add the ability to get this information from
> sysfs for supported platforms.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   Documentation/ABI/testing/sysfs-driver-ccp | 18 +++++++
>   drivers/crypto/ccp/sp-dev.h                |  2 +
>   drivers/crypto/ccp/sp-pci.c                | 58 ++++++++++++++++++++++
>   3 files changed, 78 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-ccp b/Documentation/ABI/testing/sysfs-driver-ccp
> index 7aded9b75553..ee6b787eee7a 100644
> --- a/Documentation/ABI/testing/sysfs-driver-ccp
> +++ b/Documentation/ABI/testing/sysfs-driver-ccp
> @@ -85,3 +85,21 @@ Description:
>   		Possible values:
>   		0: Not enforced
>   		1: Enforced
> +
> +What:		/sys/bus/pci/devices/<BDF>/bootloader_version
> +Date:		June 2023
> +KernelVersion:	6.4
> +Contact:	mario.limonciello@amd.com
> +Description:
> +		The /sys/bus/pci/devices/<BDF>/bootloader_version
> +		file reports the firmware version of the AMD AGESA
> +		bootloader.
> +
> +What:		/sys/bus/pci/devices/<BDF>/tee_version
> +Date:		June 2023
> +KernelVersion:	6.4
> +Contact:	mario.limonciello@amd.com
> +Description:
> +		The /sys/bus/pci/devices/<BDF>/tee_version
> +		file reports the firmware version of the AMD Trusted
> +		Execution Environment (TEE).
> diff --git a/drivers/crypto/ccp/sp-dev.h b/drivers/crypto/ccp/sp-dev.h
> index 1253a0217985..76c32ee6bd65 100644
> --- a/drivers/crypto/ccp/sp-dev.h
> +++ b/drivers/crypto/ccp/sp-dev.h
> @@ -51,6 +51,7 @@ struct tee_vdata {
>   	const unsigned int cmdbuff_addr_hi_reg;
>   	const unsigned int ring_wptr_reg;
>   	const unsigned int ring_rptr_reg;
> +	const unsigned int info_reg;
>   };
>   
>   struct platform_access_vdata {
> @@ -69,6 +70,7 @@ struct psp_vdata {
>   	const unsigned int feature_reg;
>   	const unsigned int inten_reg;
>   	const unsigned int intsts_reg;
> +	const unsigned int bootloader_info_reg;
>   };
>   
>   /* Structure to hold SP device data */
> diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
> index 85e3dc8853e2..4d729aa1b260 100644
> --- a/drivers/crypto/ccp/sp-pci.c
> +++ b/drivers/crypto/ccp/sp-pci.c
> @@ -8,6 +8,7 @@
>    * Author: Gary R Hook <gary.hook@amd.com>
>    */
>   
> +#include <linux/bitfield.h>
>   #include <linux/module.h>
>   #include <linux/kernel.h>
>   #include <linux/device.h>
> @@ -88,8 +89,65 @@ static struct attribute_group psp_security_attr_group = {
>   	.is_visible = psp_security_is_visible,
>   };
>   
> +#define version_attribute_show(name, _offset)					\
> +static ssize_t name##_show(struct device *d, struct device_attribute *attr,	\
> +			   char *buf)						\
> +{										\
> +	struct sp_device *sp = dev_get_drvdata(d);				\
> +	struct psp_device *psp = sp->psp_data;					\
> +	unsigned int val = ioread32(psp->io_regs + _offset);			\
> +	return sysfs_emit(buf, "%02lx.%02lx.%02lx.%02lx\n",			\
> +			  FIELD_GET(GENMASK(31, 24), val),			\
> +			  FIELD_GET(GENMASK(23, 16), val),			\
> +			  FIELD_GET(GENMASK(15, 8), val),			\
> +			  FIELD_GET(GENMASK(7, 0), val));			\
> +}
> +
> +version_attribute_show(bootloader_version, psp->vdata->bootloader_info_reg)
> +static DEVICE_ATTR_RO(bootloader_version);
> +version_attribute_show(tee_version, psp->vdata->tee->info_reg)
> +static DEVICE_ATTR_RO(tee_version);
> +
> +static struct attribute *psp_firmware_attrs[] = {
> +	&dev_attr_bootloader_version.attr,
> +	&dev_attr_tee_version.attr,
> +	NULL,
> +};
> +
> +static umode_t psp_firmware_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct sp_device *sp = dev_get_drvdata(dev);
> +	struct psp_device *psp = sp->psp_data;
> +	unsigned int val = 0xffffffff;
> +
> +	if (!psp)
> +		return 0;
> +
> +	if (attr == &dev_attr_bootloader_version.attr &&
> +	    psp->vdata->bootloader_info_reg)
> +		val = ioread32(psp->io_regs + psp->vdata->bootloader_info_reg);
> +
> +	if (attr == &dev_attr_tee_version.attr &&
> +	    psp->capability & PSP_CAPABILITY_TEE &&
> +	    psp->vdata->tee->info_reg)
> +		val = ioread32(psp->io_regs + psp->vdata->tee->info_reg);
> +
> +

Extra blank line.

Also, add a comment about how the PSP security policy might block access 
to these areas resulting in reading all f's, so this hides the sysfs 
attribute in that case.

Thanks,
Tom

> +	if (val != 0xffffffff)
> +		return 0444;
> +
> +	return 0;
> +}
> +
> +static struct attribute_group psp_firmware_attr_group = {
> +	.attrs = psp_firmware_attrs,
> +	.is_visible = psp_firmware_is_visible,
> +};
> +
>   static const struct attribute_group *psp_groups[] = {
>   	&psp_security_attr_group,
> +	&psp_firmware_attr_group,
>   	NULL,
>   };
>   
