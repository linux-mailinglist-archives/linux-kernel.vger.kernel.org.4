Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E796BC4B5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjCPD20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjCPD10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:27:26 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AD2A2F0F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 20:26:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vp58hAFbBpoGoSoB7wxXZ3mAxDs4z57miGyxLrYx7fZAcLX6DJ1mk2zsfC1eZN6+CmnggMp8TNsx1rkTe7RVtx0EP7U/dwt1bWdKDrI2+d4XeBveVImx19oZMv0SeKva+osyrX5RnH8b62geZ/rnD3bb09kk3Hu0W4BT10B+syhZfpSrAVshrs8yq/h6tXkFOmRygnhDc4GrkHBXDhnZg0xK5l+vmfFgh5JloCIKZAD0KfcLAOtRgeY4nm6UZ+IgU1+3WgoDcmHcomkeVrMyp85k6+z0pEa+AcYykdL69B2QVAn+5suYZDciRpNun89m/LAH9hPG9x2gg5UII86TCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8t21pzH2hqESwaCCAJuH7RmSxL1PepXhymIChttK05M=;
 b=LvOAFVrIcV4HYzpFRsJaeiUkQnGnLRSfwayqRCETkRmaHDX7OmRASA985Wd8J7VVo8psH8B0WIQed558aD7D/C9Ei4nelbTOpfMGh4dRQ6KzQiuJi4y+Jcb2K0ZhenuG9vhchHrT8dpGT5G+nAQGrWw0yNhkY+4tVGKV0CUCcT1LDzP8IqfKx8l6I9VqlV0dW2JJnq2bO/nsmU48JDashNfl19U6Hmv8AZxDl+idXEE4YnY+65JyKriymhrkLNiQbqfgygXeWyMTe5qyrhEw2i9r1RojnFXWPcYLGQFxO/XUTXAJbqGJ+D+gKRjEHaE0xW3LadonAcOhREMFjR1iFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8t21pzH2hqESwaCCAJuH7RmSxL1PepXhymIChttK05M=;
 b=WV7AXz7M5jPW/yUA555XZOQgZcaUJwJ3tcneQJ0hocnXipmBw0gChTUKpubfpsBlozMptCb1D+PQFr6596aHI5xotVanmx8vTTwe6Vbqr0pffiJy9C13j8DOjAb2GOEu7Byvi9Gq/iBEJlJAUDn07phRtUxWrCIoOMWdqX+ZUQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by CO6PR12MB5474.namprd12.prod.outlook.com (2603:10b6:303:139::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 03:25:57 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e4f3:9509:c6ee:41cb]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e4f3:9509:c6ee:41cb%3]) with mapi id 15.20.6178.024; Thu, 16 Mar 2023
 03:25:57 +0000
Message-ID: <d80db13a-bb87-039c-da20-7ebf5e68d841@amd.com>
Date:   Thu, 16 Mar 2023 08:59:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V6 4/8] soundwire: amd: enable build for AMD SoundWire
 manager driver
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, amadeuszx.slawinski@linux.intel.com,
        Mastan.Katragadda@amd.com, Arungopal.kondaveeti@amd.com,
        claudiu.beznea@microchip.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
 <20230307133135.545952-5-Vijendar.Mukunda@amd.com> <ZBGW9ThXgcT0tIui@matsya>
Content-Language: en-US
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <ZBGW9ThXgcT0tIui@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::15) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|CO6PR12MB5474:EE_
X-MS-Office365-Filtering-Correlation-Id: 73874f14-9c32-4732-c8e2-08db25ce2803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dEJxZ/i+Bn0VIxI70AvGXdCViikN4Aq3fqZNjQfzrSoCCisXG27L3KfJOSgLZ9hBEe4Tf+iEjSje0DY5P8e6Dx6RyoAi3Md3E1Oq1qg3Jols5qpJXzk1fgY4YWYFuZyfl2Ss8nT7+Td1iQXy8Gwd/E8toGG6NkEI+D3aW6fSWB4ycRoTTEaE5BEqywuk7d3ofCOthFxTpzT93x9y8Csw7kl1uJaYRw1O0cGWLpAWihXpcoijgfBOgcu8zbDaCa6cbN8mCNzixkIj5bi1rgkdQM1Y24NtyDv3fIb8ty6YfiwOfp0wIJfDNMQ+AH1g/oYSU+GuKGuC56aCOACTEGVBq905QxHh8EIky8zTe5s5V3jeIHhyvncW6O2w0fz5J72dUp+Jlg6XYgWAN1xCcMCcHVn7yRiiv8h6PfmGH+vpu1vi//wfHWqylWQXUz/0uxl5554smN2UczV4TvFTPtt0ojYotIcN0Up0kmnKBNlyAPV6xiEG9fP3PHPv6IglFM+hMETwKVGAkaudAy1pOZrq0Ot5b8gaFOP8d0gwXkEoGkmpXKnWe6mkoAqWO7fwHMfg99Z5kxLludy/KdZw0p0EOVeHje6WQpruhiJyTKEVN+Agwi5DeWLBbBy3yWfmLQh6SvtoOghdgv4meX8eDTCqAPKiPo8jC0KZ6Hqtb57rPOChVOxXUrm8h/NVFsNME+KElpiAt9bAxv2pwmvZQkvzsYmBeQm4/0s3m/F3DXBAc9A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199018)(478600001)(2616005)(186003)(6486002)(966005)(8676002)(83380400001)(6666004)(6506007)(66476007)(54906003)(316002)(26005)(6512007)(66946007)(66556008)(53546011)(31686004)(41300700001)(4326008)(6916009)(8936002)(5660300002)(38100700002)(2906002)(31696002)(36756003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEVueU5iSmZKQ1ZVN21vUERQV3VvbUV2RUhwNGlRZEFKT0dtazJGZ2lVbUR3?=
 =?utf-8?B?ejRVVUV0RGdZM3V5d3pNQ2hWd1dMd1dyRUJ2bmhhOG5MQjVKNjFIMDV4aEFK?=
 =?utf-8?B?SU9vTkp4QnMxWVZsR1NLM2N1QVV6WkR0bHpzWUwxUDZETDZXUTFCNjNoTzEv?=
 =?utf-8?B?SlhseWtzLzVabjU5QXdoNlZQVE1NZWNaMCt5YUdmVFpyNnRSN3FRWGFLTnlK?=
 =?utf-8?B?QWlzM2VzS1htMnBWNTlJN0pNNmJCZEdCVnFNQzNEd1BjRUV5OWlTcXREazdE?=
 =?utf-8?B?TDZmdG9TWDlTK3hoS1poSmxKN3hFOEttWXAxWm1MSUxDRTV5aWQvVlN0Zksx?=
 =?utf-8?B?WXhiY0JwK0RLR2tVYk9TOWZNZTk0NGdTamM3TVVjOVdiOFJ2SDZKaHJBT1N2?=
 =?utf-8?B?OXEyVjdTODRkSkp6U3lDN3JvVDdadFlGVEY1MVR0SkZkVjZ3UXVOTmlaY3Ns?=
 =?utf-8?B?NTBhUDliRXJCS29xa29lWExRYU1zbkdWSVk4S1RZNTdycVFRNlNTR3E0TENa?=
 =?utf-8?B?c2FvSkRmTnVmYnVBcTBLZUNQUEUybjFYVDRMYVBnam5ScjdUd3BMcWdVam52?=
 =?utf-8?B?NUYyeHZJdi8rdHJKSDRSYTd1V0U4a0owQVUyNEFtZFpEN2FDaDhjZ1Y2SDda?=
 =?utf-8?B?S09YN0p4REN5R1RsT1Bjbk01b0JIREVCTmxtOTBQZVRNRTRuWlM2bFY5MVZY?=
 =?utf-8?B?cU1oOG83TzZGRzNtQ2V3WUtYSUNUSURIUnJ1ZTJDUTkxZEJ5S1c1L0YxOTZM?=
 =?utf-8?B?TmJXRGQ0dnBodDM3dXZmV3RHdU1sWWhGa25meXpwbVU4ZUNNRDBsNmdBbDIv?=
 =?utf-8?B?Q3FsMzRqUFQ3S3ByYm80UFl6Y1FFYVNqcW5OWEFxRUtCMXc1dUozNUxDOXYy?=
 =?utf-8?B?UVIwOEJLWDM3SldHc1Y0ZlRSMy9CT0hqSGVGWDUrK3lwVjlJSCsvdjlXcHNo?=
 =?utf-8?B?a1B2cFpId2ZzYUxmamZ3KzQ1WFdmV1N5bXZFTDFxWXdyY2JoS2lOamkvSGpJ?=
 =?utf-8?B?K0JSVVZ4ZjdTc1JIdXVkVkZnQ05ocDlrdWZuSWluS21oOXRpdTVrRjExOG5Y?=
 =?utf-8?B?d1ppK2dyQ1MwOWQ4NWFESlBTdWplUXBqNmRJVnA5RW80ei91VHE0ZzJTTzhU?=
 =?utf-8?B?bkVQNUUydFVMeTlBMVpaU1cyV1AxYzd2S2dVL29hemxoSjZIZ0g5QlMrM2U5?=
 =?utf-8?B?YmJST0FMRzZ2azBlc3c5dFpVWG41eVExRkpaNUprcHBSWFl3bTFCVkdnbmtl?=
 =?utf-8?B?ekJ4SXFRRkRMRkFJclo3MWNZbVRTM1FCS2tjeXE1M2QvcEkyay9RdGdMbFJj?=
 =?utf-8?B?T2xSWjgwSUZOS0ZNZTRuYVVUZ0cvQTNwVlUwTk5lY0MxNkQ5V3R4cm0rRXBq?=
 =?utf-8?B?bWVxVGl5YlRhZkt3YU5xbEJtZ0gzTnNiN0NrbmVLOVFLaDJTdk9KQkVXWFd2?=
 =?utf-8?B?R1IvMWxPZElQSE1pMU10T1FjNGk0Y2xRT29lblNSTER2TmxydmF2MjA3THl5?=
 =?utf-8?B?S3kydXlEQm5ZSUtDRVZpUTR4Rms2aGJSQUNoeXVpc0RUTGVodGg1S3ZhTDRx?=
 =?utf-8?B?UERDajNrOGJ1V25ES1lRSGdwN0xhKy8vRXM4NExiMjA1SXdqcndiQmNCdy8w?=
 =?utf-8?B?bTVCWTZHd0dFb2ZiMm9zeUU4VkNQcVJyZ0YvS1ZlZ0lCZ2JLWktkb0VnUFUy?=
 =?utf-8?B?L2hlcjFrbG5oUm1BUFFSazJ2MFVUZEwzMFVpSXdDcVBYSHV5ZDRRRWlWVHRn?=
 =?utf-8?B?OXRhN2JpVzB5QjFxWEZmQTFIeG1SczlpU3BYdTY3WGRrRUxCRTNOWG1PNjhM?=
 =?utf-8?B?SjRnRmNSZ2FtQ3ZWK3p3VzlZWDhyZ29sSWtGalZ2Z29QL2x4ckJORDNnSkZC?=
 =?utf-8?B?ci9IRkxBN0o2UDdXZDNWNk5uOU9hdzd3cnQzTzkvTEdQbHhxSmdtREpueGdI?=
 =?utf-8?B?eHBXekpqVVpNajcvRlBjSXJESFlqM3ppdTVXS1BFcnJ0YnVSZVpwR2ZTa2Ri?=
 =?utf-8?B?SlVFUE9KU05OZEdhQXhXeUZGZ2JSb2N4dm9pY0gxUm9Zd1ArM29UVHg2ZFF2?=
 =?utf-8?B?ajVoZHZqYnlzWDB3UE10L0tEU2JSdmp6V0VHM2lJSGplQ1M3T3dQczVOYWRO?=
 =?utf-8?Q?h5jsqav8uyOfczTMgGcVma2BL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73874f14-9c32-4732-c8e2-08db25ce2803
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 03:25:57.1803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOinaLhOm14UWWB2lbq8uzdsvXquOFxDXnW4C9w4bf6zdA32Ie4gUbJq/rwyygmyK/Hl6w2pavFoSUYMdjoXxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5474
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/23 15:29, Vinod Koul wrote:
> On 07-03-23, 19:01, Vijendar Mukunda wrote:
>> Enable build for SoundWire manager driver for AMD platforms.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Link: https://lore.kernel.org/lkml/20230220100418.76754-5-Vijendar.Mukunda@amd.com
>> ---
>>  drivers/soundwire/Kconfig  | 10 ++++++++++
>>  drivers/soundwire/Makefile |  4 ++++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
>> index 2b7795233282..983afe3570b2 100644
>> --- a/drivers/soundwire/Kconfig
>> +++ b/drivers/soundwire/Kconfig
>> @@ -46,4 +46,14 @@ config SOUNDWIRE_QCOM
>>  config SOUNDWIRE_GENERIC_ALLOCATION
>>  	tristate
>>  
>> +config SOUNDWIRE_AMD
>> +	tristate "AMD SoundWire Manager driver"
> Alphabetically sorted please
will fix it.
>
>> +	select SOUNDWIRE_GENERIC_ALLOCATION
>> +	depends on ACPI && SND_SOC
>> +	help
>> +	  SoundWire AMD Manager driver.
>> +	  If you have an AMD platform which has a SoundWire Manager then
>> +	  enable this config option to get the SoundWire support for that
>> +	  device.
>> +
>>  endif
>> diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
>> index ca97414ada70..5956229d3eb3 100644
>> --- a/drivers/soundwire/Makefile
>> +++ b/drivers/soundwire/Makefile
>> @@ -26,3 +26,7 @@ obj-$(CONFIG_SOUNDWIRE_INTEL) += soundwire-intel.o
>>  #Qualcomm driver
>>  soundwire-qcom-y :=	qcom.o
>>  obj-$(CONFIG_SOUNDWIRE_QCOM) += soundwire-qcom.o
>> +
>> +#AMD driver
>> +soundwire-amd-y :=	amd_manager.o
>> +obj-$(CONFIG_SOUNDWIRE_AMD) += soundwire-amd.o
> here as well
Will fix it.
>
>> -- 
>> 2.34.1

