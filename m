Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BBB6E0676
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 07:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjDMFis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 01:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMFiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 01:38:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45F42688
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:38:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1qBH4J3N6VcA9kipBwYxNF0mxx2BYabKOyWCX+gxTnZAX3piDRllX4Q6dwGzEwte1fysnEenelfqk/dz3x5Q+HdyTm+ar34AkfRLv3JfudO5QiJaSnJA83G04ATHfB0wUHcQdIjxnHR7WCM3MjzRC8sVKWhNdf6WIqX2wCw0ga+jWNKtJ7FLvbo/G2vO2kRcgZkcc7IG+aWrgNnrBIclH+/warva9qFAWmUGq3/1ZupY2wg/2RWel8u7cTKOPnTHyEHANzMe4FQfbGc0Y8n6MnJ17JbHORy+y9nGlDg3QYBssNziPGz23rhV/itNICKcdMRRuPOQV0L+pr+TAe5HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgmGe+LAbISCbSyfsvBRkMU0gEA8N1F02s+snDuzYK4=;
 b=njzPq+y2pu8pbg3KNyfh7z0Td8m/4Cm3bIy5q7CGlebUi8T64CK9SGBmtdmXVq+dQ7B2XT1emoKdHfSU+OEROx5SRFFCqWyzTwK9asSmnc4g94p9SaBl4kMMsqYC8exB8irAan1cPsGa8/86NCUAIiYp2aRTkKM2CWnXs+udn+0qgSUsF99SVCiv/EHCr/3cR+602WBzw4tGRMANSiY9aNKiPZNrrnZYzNCM2jYGTkX/UTe8ks9iBDAE9Bw2bb1179KNGH1m1+0BP0gwUN8blzneaeMeDPaTGJACpDNueFBxGAIaBRNXCm4Ed8/60NWg/LWbNO65mQlhnH8Ev+u4jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgmGe+LAbISCbSyfsvBRkMU0gEA8N1F02s+snDuzYK4=;
 b=2XZRt6AvMexi+LwAj0iY6LQRhvHfVAOn1rbHX9GRO3UcRQHqjsCCbkQhwJbPrOr4B5dG1AyEEzmWHIW7o6LQ1f9v9T1D+WuPl6Foa4ESlzjcI4l/3plY8EmJb3ZsydSrOjaaFDsD0OG+k7YiToneMD+iUnNSBkaa7JtWCBXY2lQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3661.namprd12.prod.outlook.com (2603:10b6:208:169::31)
 by BN9PR12MB5260.namprd12.prod.outlook.com (2603:10b6:408:101::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 05:38:40 +0000
Received: from MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::6799:5c0:c042:6d5f]) by MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::6799:5c0:c042:6d5f%7]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 05:38:39 +0000
Message-ID: <c5b8b7d8-d478-55ff-17e4-85d1e2146d02@amd.com>
Date:   Thu, 13 Apr 2023 11:02:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] ASoC: amd: Add check for acp config flags
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
        vsujithkumar.reddy@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230412091638.1158901-1-Syed.SabaKareem@amd.com>
 <0295ccee-2ee3-7d8a-9412-1442794157b0@amd.com>
Content-Language: en-US
From:   syed saba kareem <ssabakar@amd.com>
In-Reply-To: <0295ccee-2ee3-7d8a-9412-1442794157b0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::23) To MN2PR12MB3661.namprd12.prod.outlook.com
 (2603:10b6:208:169::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3661:EE_|BN9PR12MB5260:EE_
X-MS-Office365-Filtering-Correlation-Id: bb07c346-f574-434d-fafa-08db3be15559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f/OoJPo+yLARxV30Fy70HNOud7FyQdeA5TyBhZtsB+DH3+Ha2aY57khwMCn+zwHl4t532TiQleuVuClj5KAitexuz101f/+O+AsboV7OaRsooUOicKyU3k2Hq7idB3bA3wmHz73k9hbUXT8cVPPRmU5oVyZNe5qRdJi6GmFfehmvxFejPNjVRMNr1rgcMBeB5o9Fh/FnyJ/9Q6q3O5nW6NwuWBAigRBRUhq2N91ur+rf1Fke75X7gHqFwsVXTh9wtxJiLOrkYiSc3WBDtllHgLyOvBv73rfeqOM+SeEHllBFZlOjFRmyzDk5JT/bTm8j8vjLU1BjEyLrmfgcrNv1UYZNT4Sx4E1u0elDqM4ICAev07cLEWBo7vv31w3cBGRdJ2iKhC3cXKEvuzBABOWdx02Rq/Nwwjv81o4lc9YgMdVGPm8SnVJVipVFYyu2aY3K89OHNzMgiSA4AfSwO2N9SOr3PfYhN/QhvB29fLQydIeNjfD4SKsAgsXtNVYH3uxUG/qFHThJ7a1uIzY2ygDSV2QyqeGt2f/CzXOqyjG9W8MwVmp0LMvkjAf19q9SVkO4DOoN3NunR9iH0O5JcSssFnsg+a1PF1M1K2yPVqATVaLCAgRB3n1cvaOTrQlvwlbr6ioXVE59lOTdLNrbRMjgTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3661.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199021)(6666004)(6486002)(66476007)(66556008)(66946007)(4326008)(36756003)(110136005)(2906002)(31696002)(41300700001)(5660300002)(8676002)(8936002)(316002)(38100700002)(478600001)(54906003)(53546011)(6512007)(6506007)(26005)(31686004)(2616005)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alFFRHY1MTlaYVJTSWMycGY2M3FUR2RwWWgwZGlWUG9WQWJVVlcydlJRN0Vz?=
 =?utf-8?B?NGxKbjA1QUhoMHQzSklkNk0ybjFuTG1LYkFOYU41MEl1bFNnSS8xcWY0NG1z?=
 =?utf-8?B?SVZVaDNoYTYraTJCQkZIY05yY1djYWFLblVaMkxsR0ZneWR0MzhIYmJQV3ow?=
 =?utf-8?B?cXIrVVRpQTZlb2xrREdEQTVHNkQrT2xjWkw4ZVJ0NTgyd0J0UEIxYTBSL2Qv?=
 =?utf-8?B?VmpTUDdGSzRhaXp4Wkk2T29Ed3pXMXMxLzVXRWRWUlk4Y1lWZ0lpcTl4blpm?=
 =?utf-8?B?dFgvVkhTa2JNU2pvemliZzU3MU1GV1d0YktNVDB5SHRGbUxPbVVWOUR2TFBE?=
 =?utf-8?B?Y2FqSkJmS0d1QVpaSFdPRjdsN1dtWTNFVWVYZzFRa0YxcllRT2VQV1d1bFdx?=
 =?utf-8?B?aHVhTlMvWWg4SXJFQnRlbEZyY3Q1bnJWaU9yTXZrb2UvVnF0K0lJMTcweENo?=
 =?utf-8?B?NCtGUmJic3pFTXQ0cUlpQ2lINHQvT1ZnUGFnNGRhZUZGSXBmellUZUw4SDZL?=
 =?utf-8?B?RUQ0b3BDQk1RRWRpT2ptTURmRnNzMUMyM3hDWmdkdENNRjBkQUZlTC9BODdX?=
 =?utf-8?B?bkZieCt2bzQ0clZ3MEdob3BEeVhCSzNHMjlWVjZHM2FnQTB3Yi9SZllzYzli?=
 =?utf-8?B?VWVyaWNNL2xVRDcyTnZSTFhncTFlUHJ5c3p2NkZjdFpjVGFZZWo3Y2g4STFX?=
 =?utf-8?B?bjRhOUhCU1hRZEhBM1V0eWVVa0F2RCt0dnlGQUVjV3RXclJPeFpHa2FsQW9O?=
 =?utf-8?B?eEZSSG5iUTNxUmFlb0o0UnpwUTNIeUxpeTlmSkZDSjhiY2JOU3hnRkR2eDdJ?=
 =?utf-8?B?NkN0bHYxeUwrT0hESU1YSmxuYXo5c0pGUFlyOWhKQTdxR084d1UrYi9zZGc4?=
 =?utf-8?B?dFpMemE0R21qT3NzVm1TVCtXMlduZEhXeTdTNXd6ZWFlaXIvSksyajkySGtS?=
 =?utf-8?B?ZVZNWk42NGNveStlemd1VkRCMUpLazZSUnRFR0JJU25CVmc0dFBaSlBZZzZr?=
 =?utf-8?B?bGcyWWJtRGZaNENPOW5LLzFNNk5MSUFHTkkrU3JoYWpNRStGVEhURkhyVXlO?=
 =?utf-8?B?Zy9Rc3pPcHpwbE9icTh0bXdiY1h6dEdHTzZxTWRZUTk2RjBpMWJ0NFFUVWNH?=
 =?utf-8?B?TkhPWjA0V2RVaER1dzZQLy9VaDJobmo2aDR1MGZGRFkwSHhoNEwrT2tHSXQ3?=
 =?utf-8?B?QUZIOE02Z1lsY0lmemErbVFxNmM3Q2IyWnFuYjZRS1UvWVBnYlp3V1pTaG9m?=
 =?utf-8?B?WEdPOHNXRHhHS20xdExWb0g2OGs1VjVTYUhkRmluWllvY255VUYwSHh0bVdv?=
 =?utf-8?B?ZHY4YkEvT0E4UkorSzhJMy9QdXZBdkk1aWdLMzNPQkJUMS9xRTNDb3d3dXRD?=
 =?utf-8?B?UVFhejVDY2JwY1dIUHNBUmFIL3V1b0ZpVUI3NHFVbXBuS2pqNCtkbVllRENP?=
 =?utf-8?B?R21JUjJSWm51QkdpM25seTh2TGRZNTF5TXR2cEFzM0h3cFJ1WVZoa1BENG5T?=
 =?utf-8?B?NGVjUytKS2lPRjlUVVJVa0lYaWtIRStsTzJQUU9zQTV3eDNMWDNtaWh4UVdt?=
 =?utf-8?B?N2NZT1lEZ29RSms1ZkkzcDYvQm5aZjl4TElsMFhYY2FKNDY4N2gvVU94WnFX?=
 =?utf-8?B?NHFzVm4wL1VtdjJhRzBvdDU3bThDT1liU3FBRDFHbDFFb0VJU2REOFJ1UXNs?=
 =?utf-8?B?TmVaemV1K0ZoeTZnTnlmZlh2M3dBRmFhRXV3Y1lwREQ5eEJXOTQ1S011Vis0?=
 =?utf-8?B?czhrSG9nN1N1b2Zoc0tKdjY4U0dJOHRJakxlTUxFZmlwc2JaZjhnbHdPNVQ2?=
 =?utf-8?B?VWl6K201ajJENXJJc2dZeHA5T0VMRXBzV2dwS0ZyclB2dWxLYkxjWlZyVDkx?=
 =?utf-8?B?d0p3bnFYdFpqMUVOT1E0NHlMb0N6RmZUMTdXQkM1SWRTWHdaRHJmdmlWdXhu?=
 =?utf-8?B?cWJmWTFmdENrb1VYbU1DcHhnWi9TQ29QTFRETGloWEhBM0dtU3RIbTFMZUVL?=
 =?utf-8?B?TWtpYnFFTTA1UTR6UlIwS0dLNWxwUDVDNWFJd2hHVDlPNkE4TU1Xb2NwdS8x?=
 =?utf-8?B?OFh0RUVDblNtOXluS3BrK0RjaHNTamhvZmVWVTNWRGJWdDB0SUpvQVlPUmF6?=
 =?utf-8?Q?rn9P4bNnOr0MPLc1XDAZv4UcK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb07c346-f574-434d-fafa-08db3be15559
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3661.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 05:38:39.2848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQvCfw6KyBPR8LScstNyNhBsZ/u7Q2xBxLU1mLAGYvU2OuuczKLaVAIEUBskgtgTyQFTGOhFeQX2FhzKdomzGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5260
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/12/23 20:30, Limonciello, Mario wrote:
> On 4/12/2023 04:16, Syed Saba Kareem wrote:
>> We have SOF and generic ACP support enabled for Rembrandt and
>> pheonix platforms on some machines. Since we have same PCI id
>
> s,pheonix,Phoenix,
> s,have same,have the same,
>
>> used for probing, add check for machine configuration flag to
>
> You should mention here that the PCI ID is the same but the revision
> is different to make this clearer for the commit message.
>
>> avoid conflict with newer pci drivers. Such machine flag has
>> been initialized via dmi match on few Chrome machines. If no
>> flag is specified probe and register older platform device.
>>
>> Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
>> Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>   sound/soc/amd/Kconfig        | 2 ++
>>   sound/soc/amd/ps/acp63.h     | 2 ++
>>   sound/soc/amd/ps/pci-ps.c    | 8 +++++++-
>>   sound/soc/amd/yc/acp6x.h     | 3 +++
>>   sound/soc/amd/yc/pci-acp6x.c | 8 +++++++-
>>   5 files changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
>> index c88ebd84bdd5..08e42082f5e9 100644
>> --- a/sound/soc/amd/Kconfig
>> +++ b/sound/soc/amd/Kconfig
>> @@ -90,6 +90,7 @@ config SND_SOC_AMD_VANGOGH_MACH
>>     config SND_SOC_AMD_ACP6x
>>       tristate "AMD Audio Coprocessor-v6.x Yellow Carp support"
>> +    select SND_AMD_ACP_CONFIG
>>       depends on X86 && PCI
>>       help
>>         This option enables Audio Coprocessor i.e ACP v6.x support on
>> @@ -130,6 +131,7 @@ config SND_SOC_AMD_RPL_ACP6x
>>     config SND_SOC_AMD_PS
>>           tristate "AMD Audio Coprocessor-v6.3 Pink Sardine support"
>> +    select SND_AMD_ACP_CONFIG
>
> Whitespace looks not aligned here.  I think it's a mix of tabs and 
> spaces in this section.
> It is aligned ,may be due to addition of plus symbol in the patch it 
> is looking like misaligned.
>>           depends on X86 && PCI && ACPI
>>           help
>>             This option enables Audio Coprocessor i.e ACP v6.3 
>> support on
>> diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
>> index 6bf29b520511..dd36790b25ae 100644
>> --- a/sound/soc/amd/ps/acp63.h
>> +++ b/sound/soc/amd/ps/acp63.h
>> @@ -111,3 +111,5 @@ struct acp63_dev_data {
>>       u16 pdev_count;
>>       u16 pdm_dev_index;
>>   };
>> +
>> +int snd_amd_acp_find_config(struct pci_dev *pci);
>> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
>> index 688a1d4643d9..afddb9a77ba4 100644
>> --- a/sound/soc/amd/ps/pci-ps.c
>> +++ b/sound/soc/amd/ps/pci-ps.c
>> @@ -247,11 +247,17 @@ static int snd_acp63_probe(struct pci_dev *pci,
>>   {
>>       struct acp63_dev_data *adata;
>>       u32 addr;
>> -    u32 irqflags;
>> +    u32 irqflags, flag; >       int val;
>>       int ret;
>>         irqflags = IRQF_SHARED;
>> +
>> +    /* Return if acp config flag is defined */
>> +    flag = snd_amd_acp_find_config(pci);
>
> This 'flag' variable seems unnecessary if it's just used in one place 
> and never evaluated.
>
>> +    if (flag)
>> +        return -ENODEV;
>> +
>>       /* Pink Sardine device check */
>>       switch (pci->revision) {
>>       case 0x63:
>> diff --git a/sound/soc/amd/yc/acp6x.h b/sound/soc/amd/yc/acp6x.h
>> index 036207568c04..2de7d1edf00b 100644
>> --- a/sound/soc/amd/yc/acp6x.h
>> +++ b/sound/soc/amd/yc/acp6x.h
>> @@ -105,3 +105,6 @@ static inline void acp6x_writel(u32 val, void 
>> __iomem *base_addr)
>>   {
>>       writel(val, base_addr - ACP6x_PHY_BASE_ADDRESS);
>>   }
>> +
>> +int snd_amd_acp_find_config(struct pci_dev *pci);
>> +
>> diff --git a/sound/soc/amd/yc/pci-acp6x.c b/sound/soc/amd/yc/pci-acp6x.c
>> index 77c5fa1f7af1..7af6a349b1d4 100644
>> --- a/sound/soc/amd/yc/pci-acp6x.c
>> +++ b/sound/soc/amd/yc/pci-acp6x.c
>> @@ -149,10 +149,16 @@ static int snd_acp6x_probe(struct pci_dev *pci,
>>       int index = 0;
>>       int val = 0x00;
>>       u32 addr;
>> -    unsigned int irqflags;
>> +    unsigned int irqflags, flag;
>>       int ret;
>>         irqflags = IRQF_SHARED;
>> +
>> +    /* Return if acp config flag is defined */
>> +    flag = snd_amd_acp_find_config(pci);
>
> This 'flag' variable seems unnecessary if it's just used in one place 
> and never evaluated.
>
>> +    if (flag)
>> +        return -ENODEV;
>> +
>>       /* Yellow Carp device check */
>>       switch (pci->revision) {
>>       case 0x60:
>
