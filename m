Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D00666977D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241606AbjAMMiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241383AbjAMMec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:34:32 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341B450E6C
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:33:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMYHAVYXlha+ErCdpFiiPJg3Mo6IHCmGlDt0C1dX3iKYSfeXqtLHdhIjCXnxkFrroZ3hB8Qcq3u/ay4aCrSeb5Ljh/ErLm6707vfI9NhHWmVcmqI7WgRRWb05og7j5pFrGm6PYENTEwHHf5krUO/Jstew0tXMn3Pn9Af9/A3g4HdiiHs5ivO4fxUkyviCSNaio0Y+Xs22QL2aBR5TVN+zao1esyd17SWYcRLzhEy7kVvWEeFJ2400TdVNAZvSA+D3LW6wpCvwigIw5DMxxBSfPi4Rh1vB5uqz8rgeLPaIaVry6JhDUYaLo+4h7MCJY9qPcpRL6WjPb65J/OM74Oqjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZK3S+k4NTsf+x6KUgIl3a9+FPWHt3fEbyyIOm2yUsPg=;
 b=CiMNOdsUD6dXWW5p2OBGP/S9gaKeGSytxKoAPe5xsBOL44XxzY/MobsNsrjlWJd9UKze/mKlejvnW6m+iRZGmHxWwm+JeMpA4/8BYChnZysWUexRxSVFXLHUc06xDhv/myDRROF6UbCgXFbvMi05geSATp4aVOnB/RXLvMhNRBVMPVZz5jhlczjPPYkRp8cTKGM3AlsnWSbTLm1LPp/4VoQEUZFP7Q5evkc8gNPmoumGajxmKv7tMA5fpG2Ak+m1gXlwmR1KIzJYW4wLRH+NymKP0MHW0VPfdpkE9GcFBqyD83gcQQ19rTMelmvHK2n0xQ++JVXrt8SvCOjW6s81bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK3S+k4NTsf+x6KUgIl3a9+FPWHt3fEbyyIOm2yUsPg=;
 b=Yr/XOhdv4RjYiB8LDHQKy2C/VD0COkwYLoEZHKBadUZ9fH++gRJivMtZ4bZZk6NNW4tOqjPrOhbDt2Hl1pZaUP9Q/rNOxFQOL1f2odf+21nyAS0VfgtcBvVN5H1N5UWMQ3lBwFlBHYeCwR4nh0o1RWuSLeYbM3js0RVngr1QT2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by SJ2PR12MB7992.namprd12.prod.outlook.com (2603:10b6:a03:4c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 12:32:59 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%5]) with mapi id 15.20.5986.019; Fri, 13 Jan 2023
 12:32:59 +0000
Message-ID: <257b6f1e-f403-573f-3978-13ffb14342ad@amd.com>
Date:   Fri, 13 Jan 2023 18:06:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 01/19] ASoC: amd: ps: create platform devices based on acp
 config
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Mastan.Katragadda@amd.com,
        arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-2-Vijendar.Mukunda@amd.com>
 <9f2229fb-499b-f802-993b-56a7ad2ce361@linux.intel.com>
Content-Language: en-US
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <9f2229fb-499b-f802-993b-56a7ad2ce361@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::21) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|SJ2PR12MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: be3afe36-58d8-4ba3-a4a0-08daf5624da0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x6ba0QVMV0X8EZ+mylElGZ1CLaMb4Mn2Zgsh/MazoRbaKt5cm2kfxYLs0Ifupd96DgFONqYV3WKDh7grsHKbofBwaZ2Fq29n2zhAo8GnKcHuYOGl5JHF7KKJZXFd+S9IBnlqT+hbuaoHxfUrwjn4iV7V1mjACjr90a3PL8wOjP2eWOb1q1sB+fay2r5PwRMYmgfAyP8bqsgjnuV9tvfZ4IzX0TCRlnyrXYJ8+LWFr0lhYnJSAHVQs6NLgjX5G3vWhh+xUIVRXxdo1g1ew0szbon6iZzlQ7cIPZ65JD/ajtgdTJjMKnsR1IjvFNB/Gy/9Ypn+AmHMU8xKb8FbeDFuQ6MBH0jzmU/9Fy5ITedMWjuFD58jkoiSrtUdP8rRNjm7HPSbCTRbkMkbQ+WSvYOZYZN+z0YaHTXzduTPhGgxReoV/wvHMVjZT3rOar4UpbsvuniHnKJiL+BwPCrHp0LY3GhlYwUagnjymsUOSmDew9JT12WnPFCI8no5sO1e6JRez+YwHaEVzj4tB2WIthrFeHPwrPibMKXwxZ/9Ou5XrJEzgBArgOxDqfIWYEztPyUSw7yIovFoJIEtt/BbXDUW2l59GiuVvLrvVjybmaxAK/yVIsRysiVOr1QuxmhP53O8ZuM80wDVhRc+CzUYl4Fo2nD3f4ENyKmIZFNAalQLUfrPCnBrh2rhmLT1Gt/aMjyZy52IhQpbu1F9sZZTRG+lqHBYuO6c5cXCaD/ri4nObAo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199015)(478600001)(6486002)(41300700001)(6512007)(38100700002)(86362001)(31696002)(316002)(54906003)(2616005)(66556008)(26005)(66946007)(186003)(66476007)(66899015)(5660300002)(53546011)(7416002)(6506007)(36756003)(2906002)(6666004)(8676002)(4326008)(83380400001)(8936002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk1TcEJwY2tIUi9XeHIxSzVGT2ZmSnRrMFNvOWZOZWp1TFNxL0ZaM2pJL0FO?=
 =?utf-8?B?bFZJZVo3VDFFT2ZCdTJ0TWVQRFFqYkFRemZiakNGZ1lYc0hzZjYxYVFhbHNO?=
 =?utf-8?B?YWhxVXJreGJDMEtnRS9Ic0Q1S2xlTVFlcjg3dHdiQk1McmIyUEQwZUhwa1dK?=
 =?utf-8?B?enVIZWdGZGxUNGZnbWJab2ZwbExFNjI1RG15YS81N1Y1UFlUN0ErbTdwWFZ0?=
 =?utf-8?B?eHdyL3crelEwNXgySzFpbllOZHd0QnNJcWU1UjUrekhsQXJnN2RLQUpwczNl?=
 =?utf-8?B?L3U0d0pFa0p6a0QwRkR5eXNtNnpkREd0aytvSkVCZ3pnRTRKcGp1UHkxYzhT?=
 =?utf-8?B?WGNXcms3b2oyRVArTmYvT3BwTm1KZEtZdHJJeVRMVkhqYVZabjZxL0hsZ1dM?=
 =?utf-8?B?MkVXN3FwcGxSUlZ6UjNKRU5aaWhlTEN5UzBKNXdNOFBHVS81ZWs3U2FXZmto?=
 =?utf-8?B?SXU2NEdRS2k2c2lWOEZ5K2pvUTVEUEVTcDVtaG8wMnJlN2Npb1B2S1JDUzhu?=
 =?utf-8?B?ei83OTIyWGJYUVZsSktERUJmU0dxOWdjVU5PRmhYVThBeENaNFdMRXZXNTlk?=
 =?utf-8?B?Q2lrU3JKTFZ3ejBDeCt4YmZWL3IwY0pzZlpub3YyU1dtWG5JUmtjNjA3K3M3?=
 =?utf-8?B?NUtCRUU5SGtFaS93SFJCTzJicnJ6eDVpemhMTUNXcGQvUldBR1R6TWpxay9h?=
 =?utf-8?B?ZXFXZTQwNEpIR2xkcmRYbERVOXNHZm1yemErakVsNTBBb0hBbW02R01uU0pm?=
 =?utf-8?B?UEhBb2JuVUZOTWFSSkM1cnlPZ25McHFKcUh3Z0FMTGxNSjEyWjliV2k3Qkky?=
 =?utf-8?B?ZDhueDFrckJIOTdhN3JTaVdCdXhQNnNDK1YxWGk3WktHbUFhbDdLV1JWaDVy?=
 =?utf-8?B?RjAzRWlsM2VnWHFoT1dyOW9BL1JxSFhjeDROUUZvNnVQaTN2dXh2eVJONFQ1?=
 =?utf-8?B?OTVwMnpwUTFkZWVtUXEveHNQMkorOTVSUFJXN0Z1Q1ZsWWZMR212enJ6a0hp?=
 =?utf-8?B?SW15clhtelRQa3YrbWlGUGo5c29Cc2lUNE8yVXNiY1JRbnpLMFVBb2RKVEt0?=
 =?utf-8?B?YncxYklXNnFhZFo1d1hSSkFOVUIwN1BMZXRwV0FBZnc4SXJrU25aQmVtK3N1?=
 =?utf-8?B?dDYvWEhiUU9QcnVSeWVCTC9RZDltaHBCMUdoM24wVVlld0VWSWJ6SVdDMkdO?=
 =?utf-8?B?NXlSaUoydUVPSG1Tc2V0OVljOE9aNy9vbFpxWUdyZnF1aXFoZml4NmtSUzJZ?=
 =?utf-8?B?TWRSOVhmMjFwT29Zakg5Y0xPOGpTSlpHcmM3SlY4QnhtcWt2QldhZjl6T2x4?=
 =?utf-8?B?NVBXVnB0dU9iNWlLSHluRFFVRjcyTllrL3dTWUFCVkpwQVhESzZqTzdNWjN5?=
 =?utf-8?B?ZVRoK2svK1FySXVUQUR2dC9zSCtycGt3VVVMOW9DQ3FCcllZV0FSRGNhWkFI?=
 =?utf-8?B?ZEJKbUJXS1hjdFZkM0ZlV01xT0VqVzR6c0xDSUV3V2ZhR0duOThFbFo0L3px?=
 =?utf-8?B?SndBMXdmZERDVTQrZVRQT1BOclI1aWhYZ2pLbE5pRi9UZnUrN2tnc0Znemlp?=
 =?utf-8?B?QnlvWHk0SzBFeHZXK002TEVIbENhKzZ6L2lzbHl1bm9HK0ROVEZmd2dmTXJM?=
 =?utf-8?B?bWFTMG52VlRmdGtDWmhqdmhzVkk1Q0pxSzNSWko1L3VIc2gzZFp2ZUhnVG01?=
 =?utf-8?B?WDZqOHQ4NWs1aVMwSVRvK3RkTEMvdTNaUTVoN2hhaWdRRkhHTTFST1RXcGtl?=
 =?utf-8?B?VXJFWW93MnUxeE5DdVhDVWs1aGJ3aTJ0TXl0VExvaXVxOThEYnV3U3YxWGlT?=
 =?utf-8?B?ZWZ0elRVQ3ZUZ3VWM3BNY1g5U3JEcklqbmU3RG9IUmNoNUVaV20yV1ZQVVM5?=
 =?utf-8?B?cE5FSUJqVDVCbkpIVWptNHNsejdjeFEvVVcwdmVPR2JYQ0xCVmYyakVjNnpv?=
 =?utf-8?B?c29PZTlUd1pTRE9wNUVsN25KYUw3LzJCMFByMFQ5NHlINzdWVnZVNS9zSDlk?=
 =?utf-8?B?RkN2S3hZNUs5c1RXd1JaUkVUN1pUbGJkeWpvN2lJNVh6Z0RhRFo4VGdET1Z5?=
 =?utf-8?B?L3dtelJXYXl3dTNhWUFyTE5OY0d6UFFEY2h2NnJzcGd3bFNiNlhkbTRUNGFy?=
 =?utf-8?Q?OjmF+YRABDPudSTA/jtBEmanS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3afe36-58d8-4ba3-a4a0-08daf5624da0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 12:32:58.8381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZawpE6dyxT43kC7POtuh2/QSNGa5lYxS7G8itklj/lD5zP8nHUVQne2QOY2VmpmgJ9Dm0fF+0qDyLSc3qcQiYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7992
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 
On 11/01/23 19:02, Pierre-Louis Bossart wrote:
>
>
>> +#define AMD_SDW_CLK_STOP_MODE		1
> there are multiple modes for clock stop in SoundWire, and multiple ways
> for the link manager to deal with clock stop, you want a comment to
> describe what this define refers to.
will add comments about flags explanation.
>> +#define AMD_SDW_POWER_OFF_MODE		2
>> +
>> +struct acp_sdw_pdata {
>> +	u16 instance;
>> +	struct mutex *sdw_lock;
> need a comment on what this lock protects.
>
>> +};
>> +#endif
>> diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
>> index b7535c7d093f..ed979e6d0c1d 100644
>> --- a/sound/soc/amd/ps/acp63.h
>> +++ b/sound/soc/amd/ps/acp63.h
>> @@ -10,7 +10,7 @@
>>  #define ACP_DEVICE_ID 0x15E2
>>  #define ACP63_REG_START		0x1240000
>>  #define ACP63_REG_END		0x1250200
>> -#define ACP63_DEVS		3
>> +#define ACP63_DEVS		5
>>  
>>  #define ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK	0x00010001
>>  #define ACP_PGFSM_CNTL_POWER_ON_MASK	1
>> @@ -55,8 +55,14 @@
>>  
>>  #define ACP63_DMIC_ADDR		2
>>  #define ACP63_PDM_MODE_DEVS		3
>> -#define ACP63_PDM_DEV_MASK		1
>>  #define ACP_DMIC_DEV	2
>> +#define ACP63_SDW0_MODE_DEVS		2
>> +#define ACP63_SDW0_SDW1_MODE_DEVS	3
>> +#define ACP63_SDW0_PDM_MODE_DEVS	4
>> +#define ACP63_SDW0_SDW1_PDM_MODE_DEVS   5
>> +#define ACP63_DMIC_ADDR			2
>> +#define ACP63_SDW_ADDR			5
>> +#define AMD_SDW_MAX_CONTROLLERS		2
>>  
>>  enum acp_config {
>>  	ACP_CONFIG_0 = 0,
>> @@ -77,6 +83,12 @@ enum acp_config {
>>  	ACP_CONFIG_15,
>>  };
>>  
>> +enum acp_pdev_mask {
>> +	ACP63_PDM_DEV_MASK = 1,
>> +	ACP63_SDW_DEV_MASK,
>> +	ACP63_SDW_PDM_DEV_MASK,
>> +};
>> +
>>  struct pdm_stream_instance {
>>  	u16 num_pages;
>>  	u16 channels;
>> @@ -107,7 +119,15 @@ struct acp63_dev_data {
>>  	struct resource *res;
>>  	struct platform_device *pdev[ACP63_DEVS];
>>  	struct mutex acp_lock; /* protect shared registers */
>> +	struct fwnode_handle *sdw_fw_node;
>>  	u16 pdev_mask;
>>  	u16 pdev_count;
>>  	u16 pdm_dev_index;
>> +	u8 sdw_master_count;
> for new contributions, it's recommended to use manager and peripheral.
will use manager and peripheral terminology.
>> +	u16 sdw0_dev_index;
>> +	u16 sdw1_dev_index;
> probably need a comment on what the 0 and 1 refer to, it's not clear if
> there's any sort of dependency/link with the 'sdw_master_count' above.
>
> If this is related to the two controllers mentioned in the cover letter,
> then an explanation of the sdw_master_count would be needed as well
> (single variable for two controllers?)
will add comments for dev_index variables.
>> +	u16 sdw_dma_dev_index;
>> +	bool is_dmic_dev;
>> +	bool is_sdw_dev;
>> +	bool acp_sdw_power_off;
>>  };
>> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
>> index e86f23d97584..85154cf0b2a2 100644
>> --- a/sound/soc/amd/ps/pci-ps.c
>> +++ b/sound/soc/amd/ps/pci-ps.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/interrupt.h>
>>  #include <sound/pcm_params.h>
>>  #include <linux/pm_runtime.h>
>> +#include <linux/soundwire/sdw_amd.h>
>>  
>>  #include "acp63.h"
>>  
>> @@ -134,12 +135,68 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
>>  	return IRQ_NONE;
>>  }
>>  
>> -static void get_acp63_device_config(u32 config, struct pci_dev *pci,
>> -				    struct acp63_dev_data *acp_data)
>> +static int sdw_amd_scan_controller(struct device *dev)
>> +{
>> +	struct acp63_dev_data *acp_data;
>> +	struct fwnode_handle *link;
>> +	char name[32];
>> +	u8 count = 0;
>> +	u32 acp_sdw_power_mode = 0;
>> +	int index;
>> +	int ret;
>> +
>> +	acp_data = dev_get_drvdata(dev);
>> +	acp_data->acp_sdw_power_off = true;
>> +	/* Found controller, find links supported */
>> +	ret = fwnode_property_read_u8_array((acp_data->sdw_fw_node),
>> +					    "mipi-sdw-master-count", &count, 1);
>> +
>> +	if (ret) {
>> +		dev_err(dev,
>> +			"Failed to read mipi-sdw-master-count: %d\n", ret);
> one line?
will fix it.
>
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Check count is within bounds */
>> +	if (count > AMD_SDW_MAX_CONTROLLERS) {
>> +		dev_err(dev, "Controller count %d exceeds max %d\n",
>> +			count, AMD_SDW_MAX_CONTROLLERS);
> No. controllers and masters are different concepts, see the DisCo
> specification for SoundWire. A Controller can have multiple Masters.
Will correct it.
>
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!count) {
>> +		dev_warn(dev, "No SoundWire controllers detected\n");
>> +		return -EINVAL;
>> +	}
> is this really a warning, looks like a dev_dbg or info to me.
>
>> +	dev_dbg(dev, "ACPI reports %d Soundwire Controller devices\n", count);
> the term device is incorrect here, the DisCo spec does not expose ACPI
> devices for each master.
>
> "ACPI reports %d Managers"
will correct it.
>> +	acp_data->sdw_master_count  = count;
>> +	for (index = 0; index < count; index++) {
>> +		snprintf(name, sizeof(name), "mipi-sdw-link-%d-subproperties", index);
>> +		link = fwnode_get_named_child_node(acp_data->sdw_fw_node, name);
>> +		if (!link) {
>> +			dev_err(dev, "Master node %s not found\n", name);
>> +			return -EIO;
>> +		}
>> +
>> +		fwnode_property_read_u32(link, "amd-sdw-power-mode",
>> +					 &acp_sdw_power_mode);
>> +		if (acp_sdw_power_mode != AMD_SDW_POWER_OFF_MODE)
>> +			acp_data->acp_sdw_power_off = false;
> does power-off mean 'clock-stop'?
> No. We will add comment for acp_sdw_power_off flag.
>> +	}
>> +	return 0;
>> +}
>> +
>> +		if (is_dmic_dev && is_sdw_dev) {
>> +			switch (acp_data->sdw_master_count) {
>> +			case 1:
>> +				acp_data->pdev_mask = ACP63_SDW_PDM_DEV_MASK;
>> +				acp_data->pdev_count = ACP63_SDW0_PDM_MODE_DEVS;
>> +				break;
>> +			case 2:
>> +				acp_data->pdev_mask = ACP63_SDW_PDM_DEV_MASK;
>> +				acp_data->pdev_count = ACP63_SDW0_SDW1_PDM_MODE_DEVS;
>> +				break;
> so the cover letter is indeed wrong and confuses two controllers for two
> managers.
ACP IP has two independent manager instances driven by separate controller
each which are connected in different power domains.

we should create two separate ACPI companion devices for separate
manager instance.  Currently we have limitations with BIOS.
we are going with single ACPI companion device.
We will update the changes later.
>
>> +			default:
>> +				return -EINVAL;
>> +			}
>> +		} else if (is_dmic_dev) {
>>  			acp_data->pdev_mask = ACP63_PDM_DEV_MASK;
>>  			acp_data->pdev_count = ACP63_PDM_MODE_DEVS;
>> +		} else if (is_sdw_dev) {
>> +			switch (acp_data->sdw_master_count) {
>> +			case 1:
>> +				acp_data->pdev_mask = ACP63_SDW_DEV_MASK;
>> +				acp_data->pdev_count = ACP63_SDW0_MODE_DEVS;
>> +				break;
>> +			case 2:
>> +				acp_data->pdev_mask = ACP63_SDW_DEV_MASK;
>> +				acp_data->pdev_count = ACP63_SDW0_SDW1_MODE_DEVS;
>> +				break;
>> +			default:
>> +				return -EINVAL;
>> +			}
>>  		}
>>  		break;
>> +	default:
>> +		break;
>>  	}
>> +	return 0;
>>  }

