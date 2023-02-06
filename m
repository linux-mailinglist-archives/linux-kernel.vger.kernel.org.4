Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2186C68C68E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjBFTOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBFTOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:14:02 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39FD2CFD3;
        Mon,  6 Feb 2023 11:13:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUmKtkALqXZT3W4DywhIUdQJoGJ1eHTQ5ecnW9JtWp32Wr/YfyVLJ2Yucu7VdEugHZ2z25XVzGjSJe1kWrQRFXUq/P39XvAhF/VT9xEe3CV0tzE+Y3c/ZxGW+72pmZFCj7mcHMl1Ga5kKfXIbm6AS6dq1Mf+antimUx8ML0wK0LCEgrdU6EcQM0pxSmXL2WKGW63yAkATbN2dn578CItSrUSA5C7ka0Q+aBJJkK/hfl4QQT8ySH6vB75Pf8GmYIOyMuFni4SEFdb5oGhya2wsIZkNzQ8E3/1O4KITr2V4G4YFqLPy0/8rr4kAPrWfTdrMaLVjMjtxfUTYc7h/Lb3qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPWgkPzhSpZvs89LqxoefyeP5wJeFTLo1LzDwZhZQwg=;
 b=c+o62yrLa0TP6RZwQFNCrz5gNeWPMD3FtnaMLHjBCqc+AgiUQfHkuYLivg3S+F5AdCrbHnrszCfbCJuBQh77KpKhXbSfHxmF+3u5ANrSOlxjP+UurKWNsfSiGvY1Wik53i3quSRXyk8Plg6JcqKj6mEc4j4qHChd5UkY5JPpbHZhWv4jklbMVfuhFnAu9oQJYXKChleJ1cpJeV9hoFB+54BQXPQayzuwXJijrDKIB3bie+3rl4Qtrkr8IaQ2ZVtTbXhOQ9QiOVcNB5qSJGBjC2B3hrXfytNW4Xx971NjjwOBaNTKkO9/f9ZjziK8DqbzScB4Q8cYfkT6TOlHmLo2mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPWgkPzhSpZvs89LqxoefyeP5wJeFTLo1LzDwZhZQwg=;
 b=p10ukOrxTmftH9DMn1uUQxZpJzIfK2rdTN3rUf8Smdp5M46XrNWlwTI8yxV2HPWhJxs4SU3m6usbDhCF7ihhf2PrmRBhT3JrMkDJz5oE4ergBbOW7D8HcJA1glVnFQ6nse3YcQNF+rKmOMOxZHBgqhVR+Epku2bKlpeXyZFVjBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 19:13:44 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c%9]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 19:13:44 +0000
Message-ID: <b4b8e49c-ea5d-916c-5808-7c6aefa44dd2@amd.com>
Date:   Mon, 6 Feb 2023 13:13:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 6/8] crypto: ccp - Add vdata for platform device
Content-Language: en-US
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org
References: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
 <20230123152250.26413-7-jpiotrowski@linux.microsoft.com>
 <6f76fe2b-63ea-8c45-87d8-3de30d3d76c2@amd.com>
 <20230201192409.GA14074@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230201192409.GA14074@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0025.namprd20.prod.outlook.com
 (2603:10b6:610:58::35) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa49137-549d-4ff6-1550-08db087643bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: du2Rd87r1Bykt5PUBKNq6kgCg49aggtdRksnF8VJnrL++E/xkcVYJn3Vobs1Ep3pJcMYEi7pI7KCwyl3WCNCsXY1H9EFdiroUopMTJsSMjBungrBbEFUekBUQKsvOBwGZnGbeLB+XkZ1yXwn+ZSPWrbxEaQXj53NomlNJi4VfgGJWemrSsfTMkZpEBEC25tfpOKRCX8d9S05J2CNlbAKhUMSGLtitAQ2leEAuy+ciUeWsYexAM6urt5OdBW+Fvg/1BqMrg7f/aX/Y3FdAJoVYBTzQuCc8ze+tL5gV9yugTrR78veexkZt3xU4QEHUuMZQSiQgcR61fcFOTyLr3+GOhIl1XlLUGdVPcqDRNJeH17mtINh21YRA+SV2SWZDS6D5SrXN3s6mQvDqKxMR/32q/z390LVnToQuXMaEYIpN1rlhiYlA6yt6qzm0ZfETzpHWWz+lgAGZcOc3jiNgxDAj24IdNAxNhhGBp9xeBPH1vVJjKYoiBvM1S2x6wGcbOCPzycleQpOEsnn1n+dft0z4ukt26tM5kxNjpAxhkLACSg+M9Q6R4oKpL8jb+EbfnNpeFepwGZ/dWUcnQpE7bh1vQX3E1/PshoO4ui2PBWX81w+x9+YT5pT1pgHWqiZrfaBR1SQn3yF96bVa9Q32mgsfAIBTb+t7+BxFWSS8YZD0/KaQu2Oo7RQj7mAyxliNdzSgfw8DxVaHK83+LfNOBhaHYm/gZKsUo4cGOgFE+CClO8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199018)(31686004)(66946007)(66556008)(54906003)(8676002)(316002)(6916009)(41300700001)(4326008)(5660300002)(8936002)(36756003)(31696002)(86362001)(38100700002)(66476007)(6506007)(186003)(53546011)(26005)(6666004)(6512007)(2906002)(6486002)(478600001)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0pGWXRHRmErdHZnVkZKbCtMdmxtbGJKVFV5S1huR1dLZUJpdkZVZXZCa3dI?=
 =?utf-8?B?KzJkOVl2bkl3aVI5WmtYczB6NW5uNnJxQXJONTJQVFI2c0hpZHFiaHRITVJW?=
 =?utf-8?B?eDZZaldhZ01Qd0lNZkkvRlNibnVVRHRpOXdMb3lma1k2cW8vTG54Y0dZdUkx?=
 =?utf-8?B?STFRSHpxZUVKS0ZrVVpoL3VISXloMUk1dWJ1WDFjb2c4VC9aSUxtNEthbkZG?=
 =?utf-8?B?L293ZGUzMkc5dTFWb1lRaVVWdXRmRUdrT3lUdllKWFFiOWtCQ2gzS1lkVmtL?=
 =?utf-8?B?K0pBSXEzMFBvRWMvR2tHZm43MmhNMlZKdWhRK1pwZlE1eXE4QUduWXFQUm5R?=
 =?utf-8?B?ZTA1cWRqOUxFU0FoaDVlRUIwR2Vmb1RSRU5SSG5ZOGpmb01URFc4cENPb2xJ?=
 =?utf-8?B?RG9SekJJcWpyK0dNSWttZjdHWG9VOE9uc0h1eXgrR0E2Zi9YYjZEQVB5SFRW?=
 =?utf-8?B?bnY0L1JBbUNzNWZwdzN4bnpjWE5MZ3BNTU15SE1Vc3B2UnV1K1M3anVqeUVJ?=
 =?utf-8?B?aU1yNkN3Y2VGYjY0WVdhWEI0dlpCK2NUSE1weXY3VjhUY1QxanMzYUgweHVp?=
 =?utf-8?B?eDB4MElFcVlMbmZleGlHQXJlMDBKbDlGckR4R0VINzlRV3NwUzBBS2pzMGtQ?=
 =?utf-8?B?Q01iT3A0c3VrN3RmcVk0bWFpTHVURlh2ckRQZzg0cjZ2Sjh0TTFSelVDVUVa?=
 =?utf-8?B?ekZSeXRZMVpjd1VGaHNSRGlwajI2UXFlQ3QxUGFRK1hUalJjMGtYRDA3enRJ?=
 =?utf-8?B?eldNVlZ5cFBhbU05eVZWd2FnVlBmeG5GdWsvbEpBSzNXdzM2eDNvbVlsMVhD?=
 =?utf-8?B?ZjZzaXNEdVNSRTc1SS9wWW5SVmJyelFEOW96ajUza3NoelZtWGpYTmd4a0pE?=
 =?utf-8?B?SlVEUlZtaFc1V0U3L2NQY00zM2pXYVhoK2pIZGNFSWxnYXZsMWJkUlJuTWph?=
 =?utf-8?B?MU9VdUp5RXV5bDRXL05HNkNhZUpHQmRFNUNoaVMzcVFQQzRwbzd0NkdKclgx?=
 =?utf-8?B?c21id3VqYmVrWDIrb1lVODg0U0g5cURKRHNFeWUxYTFMc0VsRFNLWE1YWGFS?=
 =?utf-8?B?YVJjRnNrb1M0M0lMaXBkeHFaOFljTm5iNER1dTJWeVFlOWx3c1B2UnJuREs5?=
 =?utf-8?B?dGMxZjNlcENycElPOE44bnZCM0grK0Y3TkZ5MWEvTTRlODRPTXo5dTVYeGp5?=
 =?utf-8?B?TDBRYTRVbGl4VytzT3BTKzNscGRsU3dBeTRaL1BsK0xkdmt1Qzg4UklJWVFr?=
 =?utf-8?B?bzN3ZVJzekRaVUNINmU4ejZySHpydkgxTkU0VStyeHBCRGRBSTNUSGhCQUhr?=
 =?utf-8?B?WmdzS1ZheThldjVHUUtGK05KSStYM0RXRjR0RnhtQzZQdkFUdlR1c2dQMWV6?=
 =?utf-8?B?dEc5YkZZVUpzcFRTQ2tVaGtldVA5c0llKzZjeUFmdVVtcFhuMFhLNEVXWjc0?=
 =?utf-8?B?UWhjSkVwa0g4NzdUKzZwNXhVN29BaG4rWXJNS09QenJtOUNPR3FHT2cwTDFh?=
 =?utf-8?B?NTJjQmRZUGE1QzhHV25ScGFTOTJiRWRldHppT2hXaTFnaGQ4T2h0djVhY2I0?=
 =?utf-8?B?QUtKRjNWRnczZWJHWk15Rmp3aTZIelBjQ3JqSTQweWwzcllSeEFrbXBkQXU2?=
 =?utf-8?B?Wk1adEc4OFU5WmZxT0RLSTNxVjZFb0sxVXJYdVRMR3ZLTTNVbnUwWTJqNHNu?=
 =?utf-8?B?SEV1b25jTEZTK2gwbVYxYjZjVXhqbTJ0RjZBTDdtQlRHaEJSVTRWZ3Evck11?=
 =?utf-8?B?MzV6WU9rZXRlMDJXU2dnQVFWbTY1b0hBTkFoSEZpNmlnb1V0L0lIN1A3QW8z?=
 =?utf-8?B?eU4walFSN1crQ0FqV0N5c1kzNGU4NS94Ym1aL2hXanNzRGZHRmpOdEFWZzhs?=
 =?utf-8?B?bWZiMHdlL2lGTFVzQm9YSU5OQjdjb1NIUmg0TG5aN1JCTnJGZjNQTEVHSE9H?=
 =?utf-8?B?L1pNKzd5b25pMjhTVlU0b2VuMzFCZTZLN1dlUlBicWZnZmxxWERHVHFIN084?=
 =?utf-8?B?WTZNTlRBL2VZdGQrZmxrOGllRDBSTDIzNUJHU2labXNpbGpCZWNnRjlKOHBl?=
 =?utf-8?B?MzFidUR4SlU4MU0ydDFnV3FvQWs4R1FtNXViMlZnOFlkY3cxTlN2aG5TS00x?=
 =?utf-8?Q?tUNf6OxSSRXRhK5u9y4dk/Ht6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa49137-549d-4ff6-1550-08db087643bc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 19:13:44.0494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5y3JpOphVCHDfBy2RovPsYXstxCxKU7/8iNkbYH3bzbGIG0ejAeyAoDHsnb8TFeYHE9C/TapE9NxWRKUyWA45Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/23 13:24, Jeremi Piotrowski wrote:
> On Tue, Jan 31, 2023 at 02:36:01PM -0600, Tom Lendacky wrote:
>> On 1/23/23 09:22, Jeremi Piotrowski wrote:
>>> When matching the "psp" platform_device, determine the register offsets
>>> at runtime from the ASP ACPI table. Pass the parsed register offsets
>> >from the ASPT through platdata.
>>>
>>> To support this scenario, mark the members of 'struct sev_vdata' and
>>> 'struct psp_vdata' non-const so that the probe function can write the
>>> values. This does not affect the other users of sev_vdata/psp_vdata as
>>> they define the whole struct const and the pointer in struct
>>> sp_dev_vdata stays const too.
>>>
>>> Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
>>> ---
>>>   arch/x86/kernel/psp.c            |  3 ++
>>>   drivers/crypto/ccp/sp-dev.h      | 12 +++----
>>>   drivers/crypto/ccp/sp-platform.c | 57 +++++++++++++++++++++++++++++++-
>>>   3 files changed, 65 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/psp.c b/arch/x86/kernel/psp.c
>>> index 24181d132bae..68511a14df63 100644
>>> --- a/arch/x86/kernel/psp.c
>>> +++ b/arch/x86/kernel/psp.c
>>> @@ -199,6 +199,9 @@ static int __init psp_init_platform_device(void)
>>>   	if (err)
>>>   		return err;
>>>   	err = platform_device_add_resources(&psp_device, res, 2);
>>> +	if (err)
>>> +		return err;
>>> +	err = platform_device_add_data(&psp_device, &pdata, sizeof(pdata));
>>>   	if (err)
>>>   		return err;
>>> diff --git a/drivers/crypto/ccp/sp-dev.h b/drivers/crypto/ccp/sp-dev.h
>>> index 20377e67f65d..aaa651364425 100644
>>> --- a/drivers/crypto/ccp/sp-dev.h
>>> +++ b/drivers/crypto/ccp/sp-dev.h
>>> @@ -40,9 +40,9 @@ struct ccp_vdata {
>>>   };
>>>   struct sev_vdata {
>>> -	const unsigned int cmdresp_reg;
>>> -	const unsigned int cmdbuff_addr_lo_reg;
>>> -	const unsigned int cmdbuff_addr_hi_reg;
>>> +	unsigned int cmdresp_reg;
>>> +	unsigned int cmdbuff_addr_lo_reg;
>>> +	unsigned int cmdbuff_addr_hi_reg;
>>>   };
>>>   struct tee_vdata {
>>> @@ -56,9 +56,9 @@ struct tee_vdata {
>>>   struct psp_vdata {
>>>   	const struct sev_vdata *sev;
>>>   	const struct tee_vdata *tee;
>>> -	const unsigned int feature_reg;
>>> -	const unsigned int inten_reg;
>>> -	const unsigned int intsts_reg;
>>> +	unsigned int feature_reg;
>>> +	unsigned int inten_reg;
>>> +	unsigned int intsts_reg;
>>>   };
>>>   /* Structure to hold SP device data */
>>> diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
>>> index ea8926e87981..281dbf6b150c 100644
>>> --- a/drivers/crypto/ccp/sp-platform.c
>>> +++ b/drivers/crypto/ccp/sp-platform.c
>>> @@ -22,6 +22,7 @@
>>>   #include <linux/of.h>
>>>   #include <linux/of_address.h>
>>>   #include <linux/acpi.h>
>>> +#include <linux/platform_data/psp.h>
>>>   #include "ccp-dev.h"
>>> @@ -30,11 +31,31 @@ struct sp_platform {
>>>   	unsigned int irq_count;
>>>   };
>>> +#ifdef CONFIG_CRYPTO_DEV_SP_PSP
>>> +static struct sev_vdata sev_platform = {
>>> +	.cmdresp_reg = -1,
>>> +	.cmdbuff_addr_lo_reg = -1,
>>> +	.cmdbuff_addr_hi_reg = -1,
>>> +};
>>> +static struct psp_vdata psp_platform = {
>>> +	.sev = &sev_platform,
>>> +	.feature_reg = -1,
>>> +	.inten_reg = -1,
>>> +	.intsts_reg = -1,
>>> +};
>>> +#endif
>>> +
>>>   static const struct sp_dev_vdata dev_vdata[] = {
>>>   	{
>>>   		.bar = 0,
>>>   #ifdef CONFIG_CRYPTO_DEV_SP_CCP
>>>   		.ccp_vdata = &ccpv3_platform,
>>> +#endif
>>> +	},
>>> +	{
>>> +		.bar = 0,
>>> +#ifdef CONFIG_CRYPTO_DEV_SP_PSP
>>> +		.psp_vdata = &psp_platform,
>>>   #endif
>>>   	},
>>>   };
>>> @@ -57,7 +78,7 @@ MODULE_DEVICE_TABLE(of, sp_of_match);
>>>   #endif
>>>   static const struct platform_device_id sp_plat_match[] = {
>>> -	{ "psp" },
>>> +	{ "psp", (kernel_ulong_t)&dev_vdata[1] },
>>>   	{ },
>>>   };
>>>   MODULE_DEVICE_TABLE(platform, sp_plat_match);
>>> @@ -86,6 +107,38 @@ static struct sp_dev_vdata *sp_get_acpi_version(struct platform_device *pdev)
>>>   	return NULL;
>>>   }
>>> +static struct sp_dev_vdata *sp_get_plat_version(struct platform_device *pdev)
>>> +{
>>> +	struct sp_dev_vdata *drvdata = (struct sp_dev_vdata *)pdev->id_entry->driver_data;
>>
>> s/drvdata/vdata/
>>
> 
> ok
> 
>>> +	struct device *dev = &pdev->dev;
>>> +
>>
>> Should check for null vdata and return NULL, e.g.:
>>
>> 	if (!vdata)
>> 		return NULL;
>>
> 
> ok
> 
>>> +	if (drvdata == &dev_vdata[1]) {
>>
>> This should be a check for vdata->psp_vdata being non-NULL and
>> vdata->psp_vdata->sev being non-NULL, e.g.:
>>
>> 	if (vdata->psp_vdata && vdata->psp_vdata->sev) {
>>
>>> +		struct psp_platform_data *pdata = dev_get_platdata(dev);
>>> +
>>> +		if (!pdata) {
>>> +			dev_err(dev, "missing platform data\n");
>>> +			return NULL;
>>> +		}
>>> +#ifdef CONFIG_CRYPTO_DEV_SP_PSP
>>
>> No need for this with the above checks
>>
>>> +		psp_platform.feature_reg = pdata->feature_reg;
>>
>> These should then be:
>>
>> 		vdata->psp_vdata->inten_reg = pdata->feature_reg;
>> 		...
> 
> I see where you're going with this and the above suggestions, but
> the psp_vdata pointer is const in struct sp_dev_vdata and so is the
> sev pointer in struct psp_vdata. I find these consts to be important
> and doing it this way would require casting away the const. I don't
> think that's worth doing.

Ok, then maybe it would be better to kmalloc a vdata structure that you 
fill in and then assign that to dev_vdata field for use. That could 
eliminate the removal of the "const" notations in one of the previous 
patches. I just don't think you should be changing the underlying module 
data that isn't expected to be changed.

> 
>>
>>> +		psp_platform.inten_reg = pdata->irq_en_reg;
>>> +		psp_platform.intsts_reg = pdata->irq_st_reg;
>>> +		sev_platform.cmdresp_reg = pdata->sev_cmd_resp_reg;
>>
>> And this should be:
>>
>> 		vdata->psp_vdata->sev->cmdbuff_addr_lo = ...
>>
>>> +		sev_platform.cmdbuff_addr_lo_reg = pdata->sev_cmd_buf_lo_reg;
>>> +		sev_platform.cmdbuff_addr_hi_reg = pdata->sev_cmd_buf_hi_reg;
>>> +		dev_dbg(dev, "GLBL feature:\t%x\n", pdata->feature_reg);
>>
>> s/GLBL feature/PSP feature register/
>>
>>> +		dev_dbg(dev, "GLBL irq en:\t%x\n", pdata->irq_en_reg);
>>
>> s/GLBL irq en/PSP IRQ enable register/
>>
>>> +		dev_dbg(dev, "GLBL irq st:\t%x\n", pdata->irq_st_reg);
>>
>> s/GLBL irq st/PSP IRQ status register/
>>
>>> +		dev_dbg(dev, "SEV cmdresp:\t%x\n", pdata->sev_cmd_resp_reg);
>>
>> s/SEV cmdresp/SEV cmdresp register/
>>
>>> +		dev_dbg(dev, "SEV cmdbuf lo:\t%x\n", pdata->sev_cmd_buf_lo_reg);
>>
>> s/SEV cmdbuf lo/SEV cmdbuf lo register/
>>
>>> +		dev_dbg(dev, "SEV cmdbuf hi:\t%x\n", pdata->sev_cmd_buf_hi_reg);
>>
>> s/SEV cmdbuf hi/SEV cmdbuf hi register/
>>
>>> +		dev_dbg(dev, "SEV mbox:\t%x\n", pdata->mbox_irq_id);
>>
>> s/SEV mbox/SEV cmdresp IRQ/
>>
> 
> ok to all the above rewordings
> 
>>
>>> +		dev_dbg(dev, "ACPI cmdresp:\t%x\n", pdata->acpi_cmd_resp_reg);
>>
>> Duplicate entry
> 
> I don't see it. This is the ACPI register (the one used for the IRQ config).
> Here's how these prints look when the module is loaded with dyndbg=+p:

My bad, misread it as SEV cmdresp.

Thanks,
Tom

> 
>    ccp psp: GLBL feature:  0
>    ccp psp: GLBL irq en:   4
>    ccp psp: GLBL irq st:   8
>    ccp psp: SEV cmdresp:   10
>    ccp psp: SEV cmdbuf lo: 14
>    ccp psp: SEV cmdbuf hi: 18
>    ccp psp: SEV mbox:      1
>    ccp psp: ACPI cmdresp:  20
> 
>>
>>> +#endif
>>> +	}
>>> +	return drvdata;
>>> +}
>>> +
>>>   static int sp_get_irqs(struct sp_device *sp)
>>>   {
>>>   	struct sp_platform *sp_platform = sp->dev_specific;
>>> @@ -137,6 +190,8 @@ static int sp_platform_probe(struct platform_device *pdev)
>>>   	sp->dev_specific = sp_platform;
>>>   	sp->dev_vdata = pdev->dev.of_node ? sp_get_of_version(pdev)
>>>   					 : sp_get_acpi_version(pdev);
>>> +	if (!sp->dev_vdata && pdev->id_entry)
>>
>> Move this pdev->id_entry check into sp_get_plat_version(), returning
>> NULL if not set.
>>
> 
> ok
> 
>> Thanks,
>> Tom
>>
>>> +		sp->dev_vdata = sp_get_plat_version(pdev);
>>>   	if (!sp->dev_vdata) {
>>>   		ret = -ENODEV;
>>>   		dev_err(dev, "missing driver data\n");
