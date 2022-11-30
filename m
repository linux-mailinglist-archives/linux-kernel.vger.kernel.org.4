Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B434163CD9F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 04:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiK3DAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 22:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiK3DAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 22:00:16 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038E56DFEA;
        Tue, 29 Nov 2022 19:00:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIaAHQJQFxuBn+k6Pg1Cf5x8MChNXRdyiS6C0bw0VZA5Vd0xwOY1ysmpHqoLzRv7wWpUkIOQyF5UYiIfMsoBuaHB96Hnge8l0Wu17MAry7YtF+QdyOT9eC+wta1k/9i7wiiLWCEe0nJLoXmxlz7DWnYrkvv4iUh8YD8pwq0F4JAbLgkTRVmJbCFnL19Y4uqGwDzUfEYlzurXVhFc8MO9J+5OgPLclKXZZhIxVIkKfb8rDH8t+y8NYWKDyoLmH4UxlxjkRJzs5Xxm9IpnmRuU7cAxA6ihfGtzvfnekg/5yP3KuAWjMgxLHebulD2W5qd09uMZLA9yeVEyXV4N+aL4XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujkNxDo/Ieh2Nuu451Zp9QdWFitGOCnAnM54D7l7wGg=;
 b=AlPEl4sJp0cVLzl09EjFCAechcTDvswmq5Koci14btJnw+YDAElcBv5eK2N+CY+mSQzmTUGCTDbR3Wy3ks4RoCH03T97XReOro9r9zLJ2KVg8luIe4J71JIZvnZPp0r5EcI3J3v3pCWX++yhwX47wtOoK0HdmqnTim1UTv0veGzvGbY8E1jwCM6UAhTkgNl1zjq+wlT1hAzorC9aIpXu+Ki+bF7aKhhJ/S23ko6PofqKCw4Ev5Hvfz99yFcnLdDXLz0g83cMdWOelPXRh1qdjKM2qqn4rqcUbnM+COWdLxv89pk02gnA/SnPYMg2KOW7K2ZgiN8qcX5VjV28b3f3+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujkNxDo/Ieh2Nuu451Zp9QdWFitGOCnAnM54D7l7wGg=;
 b=UrQQ8BmN+zlMJ2023Jdk5nMpl99xT6E04YvrcCjTH8Wh7d4yB6eB1hl0icgi4c7vQsBnB0eKPYPfp9sCRIotH10Yepnu19dB8IjhESrgD8EzOz9JG9jxVhw2T9RCU4KpHFUfzFV6eysqF2XWZXMJjIY/J3Rjb1QoMyQon8MblkDEP3AwVdpyDiMGZaAEn9fflaDYgBPF0PQOJsJ30U7ERkN9ItYKzBQV7lNDSI/HnNTpfS2PVo9ldB0ccMvpf/eCFD+so34Gh9B39THWRMRbLb2yk6pvq5Jf6/mT8tV6xGR9qoF2kXo5ojztFBH67mQnZznanNkeEjlPVSszgNxzfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 03:00:10 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::2349:ec6b:2442:8c52]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::2349:ec6b:2442:8c52%3]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 03:00:10 +0000
Message-ID: <1a186be2-498a-a63b-a383-c165a9f8e732@nvidia.com>
Date:   Tue, 29 Nov 2022 19:00:04 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH 2/7] hte: Add Tegra234 provider
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org,
        timestamp@lists.linux.dev
References: <20221103174523.29592-1-dipenp@nvidia.com>
 <20221103174523.29592-3-dipenp@nvidia.com> <Y25x9gc4tpF1f022@orome>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <Y25x9gc4tpF1f022@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::25) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|CH2PR12MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: e37bdec9-6320-460b-8b6e-08dad27efd57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UOHUYY0RW9BNGdNxV7TFG81+/mIV8Kv+Lk6627ZEF0Wkjqdf8g6wm8/rDAHY8XU8MZkCebYp3Q2JT5EmvP2oBhFioFecyBjzjDX7k9MqKaTIdgS56G4hky5dNOwEJWTyieLIIblGFMR9qRlTKR0Zx1b+pxUxXWpNZynsNRjxrPKYXJkHsrrl9BTh+C/l+oeR/MmSMiitbTQmxAN1l7uLm+A7FWRNqQr4v71Cchc9wlc4Eg/Gtn4HKTBs/FrOEhHlMQHm7Bi2bSR3/C7Qo1XhJuORH6ep/JMcrVZ7H0gYuh4DLs1wMzBb718stcuwgjo7bsm/2AVoSHGG7vmZ1r92Pjr0RgYWQm7Ww8Jb8fKvF109q8eF/LEsjMs6ex1yNvwQA+c5nzZODX6Cjg27BPt7hwjcEsIxX0zmxSmnFXCFpO79s6GWyK0fTuws1qAHdVnf+cZcp0627ugkKr0AilS1LZkHWKdpjGy2dNd2cZFSDlSum8r3sTJm5AtDaWdV2Cf4LjiyYgrbCRmWv/aWK+wfKL5GhEAo80GnjQGqSUTmqQWIbE4ubrWew3ytkSbHAxEw3uZnHMxbQ2FREnmt7IwTkD0Pya5HMKVCHg6MWx6EiuMdWRAtfcnOic5LpLTCjcvEjhu2h9SW7ndH783IR2hUZ0rs8nIulRCIuuN/6LlQu2K1fqKDnCeXM+Xk1ZVpxSBEH25/2s/cLb752NarlK4mNENlGkaMuqiheww0p05pAVc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(26005)(31696002)(31686004)(86362001)(6666004)(4326008)(66946007)(41300700001)(66556008)(8676002)(2616005)(316002)(6512007)(8936002)(6486002)(6916009)(6506007)(38100700002)(83380400001)(2906002)(5660300002)(53546011)(478600001)(186003)(66476007)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NytHMmpjTVdlSE0vZnA3WnR0VnA4UzJVRFdOcDZpYys2K2lDZllrQnBHMmFI?=
 =?utf-8?B?V0ppWkJPVjdOeG4xdTFndU9zOVJWUTB6ZS9ualh2ajdrdm9XOEhxalZmR054?=
 =?utf-8?B?aDZTUTRUT3BNV3h0aFIwM29RR1N0K1JRaWRKWWFlMTVhQ2ltcWMxcVZzOTNm?=
 =?utf-8?B?bGRFZ1U0MnhqVDZSWUtKRkxsSEV3S24zNjdaZVdpcGRaZ2F1OGdPRnE5Vmk3?=
 =?utf-8?B?ai9WbUVsTTl6d21yREgra1pqMlBEOGtQM0p5TkpqMTZWODhCNytXNmtudDQ2?=
 =?utf-8?B?cGpLMTNFdHIvVnduVWZ2S1RzREtiY3BhcTlxaHdESDJ3YWhDQ3FYMUYyT0hV?=
 =?utf-8?B?YXJCNG9YVXlVTDl5dGcvL3ZkcWhtajI1WUlNaGV5K2FSTk5qNE1VeUxYRXp3?=
 =?utf-8?B?cTRNUm9Ua01sTHJ6OCt5Kzg1TnZuUzJlcUxWZWtVcW1aUHJ4RmQwOFpyTGpX?=
 =?utf-8?B?UmFRNE5SaUswRGZ1UDBCcDlubkN1OE1MR1NQMW9SLytFQ0xqSVdtbzJvdzBu?=
 =?utf-8?B?eDM1cTFoYi8vcEpEMUpXQlJWdXR3YUR1STQ4bUxhSEpaZEdjL0RaTTBBS2Js?=
 =?utf-8?B?MmU5ZFNPcGFNSmV3eGtCYm5DSEs3Y21zN3Z3ZjlZMzBIMnpGdUhTZWhQdHAr?=
 =?utf-8?B?TUJoLzBFYUNVdUpOYkVSUGRDOFlrZ3pMU0RuT2RSTVpVTVNpejdrSFpPV3Vx?=
 =?utf-8?B?V1N4V2MvQTNxNGRSTjROakY2akJva1lvU3lYdm94cjdhZ2R3R3Vpa0IrSm5i?=
 =?utf-8?B?eENYQkd5cGpHa0twQ1d3MzJQKytWdWFrZkNEdFpCd1dIRzFVemdGTk5HYjMy?=
 =?utf-8?B?QTVvTHBteFA2a01pbHU0bU8wcWwwYWtlZFB4U1lZWGxzS00xZGdJbTRJaWwy?=
 =?utf-8?B?VDJ6RWhtU3ZySmdBbVd3azE1QlhEZVE4Z3VEQ1BsSy9Vajk2MldpRXdkYXUx?=
 =?utf-8?B?eitxZ1BURG93Um9YdDYyYkJGNWxPakpEUW1uY3NvSE1oUFgxbDdtWGdlUUNr?=
 =?utf-8?B?SzR2NWJqb2JJWWRCQklSa1BjRWJqU21BaDZEdy9tV3dlWTlIQUI3a3drYzly?=
 =?utf-8?B?c2doUTBPbEdhZ2hDc0VITnBuRS8rdXkzMWY3RWhDb1lZMXRDTDg4V1FxVE1q?=
 =?utf-8?B?UFZOSzQ0N1gxTFNYc2ZyODN1QTJEZndmZ2FUYzR5RGFZa2F1Z0Z0Wi9rdmxM?=
 =?utf-8?B?SzdFay9zaXYyc2pTVnF5UVgxUHFETVJEWU8wUGRrWTNSUE1RTzVLdWJzVTky?=
 =?utf-8?B?eGU3TURpZGEyK25JN3NBd1AxdGkvalovSC9mc28zZFJGQ3dZTVN1c0x2QVNX?=
 =?utf-8?B?eHVEa3dqL3Z4NGdINzZIb2t1cmIrV1BiM1lBWlRuWnRxZnBhcUxqVFV0ZSs2?=
 =?utf-8?B?VldtYlZQMHIrbExsK2hPeGdhS0RmSHFsT25DcXErd2NVY21rY1J5ZTFwakhR?=
 =?utf-8?B?S1ZhaFdLSWJkTFpOWTl5UnJQM204U2pXeXpDNU5CVmI0ZGhuVVlQSmtDWUhr?=
 =?utf-8?B?aE9neXZZbS9CeFZ6VkVsSnZwNHQ3OWpDN2xvRWw1NFdIOWdubC84WGoxVEtk?=
 =?utf-8?B?L2huWWFtU05CUVNWQ0t5WDlzR1NsQkh0L1hiU0hJVVZ1Y1RvdVp1TG1CUjdr?=
 =?utf-8?B?RDhXMTAxVUE5OEZDNDRhTFFYdjJhQ2FwYlRKSjg1N0NDa0J3S3l3UFRqMDhW?=
 =?utf-8?B?NDlCOU4rN29GRFdIUVkwS001OVBjZS9tRnhTc3V3ZU8wdHJxZUp3K01hN09m?=
 =?utf-8?B?K1VHWktpTjBEaFN4V2RxRGpSa0tOMERuSzRtMldibUozdmJlMXl2Nyt3TUh2?=
 =?utf-8?B?Y1hINTJYUWhqZGVVSEhoM016NGVleExEcStFNkV5MGVmenRuSnI0V0YrNjBW?=
 =?utf-8?B?ZlNady9GbUh1OE50dDdqei8vMTd6SkJzY3FTSkhMSkhFYlBuTTI1dnM1K2dl?=
 =?utf-8?B?bk1ISVJaRlY3Sk9IcEpPOWE2NG1Pek5LTG4raWp6eDlhN3RKUkZBNTA4cVBP?=
 =?utf-8?B?WHpaa1lPQ3dGUHJRTUlnVlg1WCtscndUUjNwcEdwTUlwNlBCVHp2YXAyLzZP?=
 =?utf-8?B?RWZUd1dIUW1SNUZVWHpQaGFzd3A1Ym0vV2QyU3JYS2crWHhTVUI3MFF5OHZE?=
 =?utf-8?Q?RygXLWrcxZwLzZITgG1Qj0lid?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e37bdec9-6320-460b-8b6e-08dad27efd57
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 03:00:10.0378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nd3BQOzmyJ94Lv/Tx6Hcj+FGwecccVHpIHPHuDBIAd+on+zxJTenDekpCLff+U4Nold6gkjGHatTt9iyHEuiOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/22 8:01 AM, Thierry Reding wrote:
> On Thu, Nov 03, 2022 at 10:45:18AM -0700, Dipen Patel wrote:
>> The Tegra234 AON GPIO instance and LIC IRQ support HTE. For the GPIO
>> HTE support, it requires to add mapping between GPIO and HTE framework.
>>
>> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
>> ---
>>  drivers/hte/hte-tegra194-test.c |   2 +-
>>  drivers/hte/hte-tegra194.c      | 124 ++++++++++++++++++++++++++++++--
>>  2 files changed, 121 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/hte/hte-tegra194-test.c b/drivers/hte/hte-tegra194-test.c
>> index 5d776a185bd6..d79c28a80517 100644
>> --- a/drivers/hte/hte-tegra194-test.c
>> +++ b/drivers/hte/hte-tegra194-test.c
>> @@ -16,7 +16,7 @@
>>  #include <linux/hte.h>
>>  
>>  /*
>> - * This sample HTE GPIO test driver demonstrates HTE API usage by enabling
>> + * This sample HTE test driver demonstrates HTE API usage by enabling
>>   * hardware timestamp on gpio_in and specified LIC IRQ lines.
>>   *
>>   * Note: gpio_out and gpio_in need to be shorted externally in order for this
>> diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
>> index 49a27af22742..5d1f947db0f6 100644
>> --- a/drivers/hte/hte-tegra194.c
>> +++ b/drivers/hte/hte-tegra194.c
>> @@ -62,6 +62,10 @@
>>  #define NV_AON_HTE_SLICE2_IRQ_GPIO_25	25
>>  #define NV_AON_HTE_SLICE2_IRQ_GPIO_26	26
>>  #define NV_AON_HTE_SLICE2_IRQ_GPIO_27	27
>> +#define NV_AON_HTE_SLICE2_IRQ_GPIO_28	28
>> +#define NV_AON_HTE_SLICE2_IRQ_GPIO_29	29
>> +#define NV_AON_HTE_SLICE2_IRQ_GPIO_30	30
>> +#define NV_AON_HTE_SLICE2_IRQ_GPIO_31	31
>>  
>>  #define HTE_TECTRL		0x0
>>  #define HTE_TETSCH		0x4
>> @@ -220,7 +224,100 @@ static const struct tegra_hte_line_mapped tegra194_aon_gpio_sec_map[] = {
>>  	[39] = {NV_AON_SLICE_INVALID, 0},
>>  };
>>  
>> -static const struct tegra_hte_data aon_hte = {
>> +static const struct tegra_hte_line_mapped tegra234_aon_gpio_map[] = {
>> +	/* gpio, slice, bit_index */
>> +	/* AA port */
>> +	[0]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_11},
>> +	[1]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_10},
>> +	[2]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_9},
>> +	[3]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_8},
>> +	[4]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_7},
>> +	[5]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_6},
>> +	[6]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_5},
>> +	[7]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_4},
>> +	/* BB port */
>> +	[8]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_3},
>> +	[9]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_2},
>> +	[10] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_1},
>> +	[11] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_0},
>> +	/* CC port */
>> +	[12] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_22},
>> +	[13] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_21},
>> +	[14] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_20},
>> +	[15] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_19},
>> +	[16] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_18},
>> +	[17] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_17},
>> +	[18] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_16},
>> +	[19] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_15},
>> +	/* DD port */
>> +	[20] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_14},
>> +	[21] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_13},
>> +	[22] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_12},
>> +	/* EE port */
>> +	[23] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_31},
>> +	[24] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_30},
>> +	[25] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_29},
>> +	[26] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_28},
>> +	[27] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_27},
>> +	[28] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_26},
>> +	[29] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_25},
>> +	[30] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_24},
>> +	/* GG port */
>> +	[31] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_23},
>> +};
>> +
>> +static const struct tegra_hte_line_mapped tegra234_aon_gpio_sec_map[] = {
>> +	/* gpio, slice, bit_index */
>> +	/* AA port */
>> +	[0]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_11},
>> +	[1]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_10},
>> +	[2]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_9},
>> +	[3]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_8},
>> +	[4]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_7},
>> +	[5]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_6},
>> +	[6]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_5},
>> +	[7]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_4},
>> +	/* BB port */
>> +	[8]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_3},
>> +	[9]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_2},
>> +	[10] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_1},
>> +	[11] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_0},
>> +	[12] = {NV_AON_SLICE_INVALID, 0},
>> +	[13] = {NV_AON_SLICE_INVALID, 0},
>> +	[14] = {NV_AON_SLICE_INVALID, 0},
>> +	[15] = {NV_AON_SLICE_INVALID, 0},
>> +	/* CC port */
>> +	[16] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_22},
>> +	[17] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_21},
>> +	[18] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_20},
>> +	[19] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_19},
>> +	[20] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_18},
>> +	[21] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_17},
>> +	[22] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_16},
>> +	[23] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_15},
>> +	/* DD port */
>> +	[24] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_14},
>> +	[25] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_13},
>> +	[26] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_12},
>> +	[27] = {NV_AON_SLICE_INVALID, 0},
>> +	[28] = {NV_AON_SLICE_INVALID, 0},
>> +	[29] = {NV_AON_SLICE_INVALID, 0},
>> +	[30] = {NV_AON_SLICE_INVALID, 0},
>> +	[31] = {NV_AON_SLICE_INVALID, 0},
>> +	/* EE port */
>> +	[32] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_31},
>> +	[33] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_30},
>> +	[34] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_29},
>> +	[35] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_28},
>> +	[36] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_27},
>> +	[37] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_26},
>> +	[38] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_25},
>> +	[39] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_24},
>> +	/* GG port */
>> +	[40] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_23},
>> +};
>> +
>> +static const struct tegra_hte_data t194_aon_hte = {
>>  	.map_sz = ARRAY_SIZE(tegra194_aon_gpio_map),
>>  	.map = tegra194_aon_gpio_map,
>>  	.sec_map_sz = ARRAY_SIZE(tegra194_aon_gpio_sec_map),
>> @@ -228,6 +325,14 @@ static const struct tegra_hte_data aon_hte = {
>>  	.type = HTE_TEGRA_TYPE_GPIO,
>>  };
>>  
>> +static const struct tegra_hte_data t234_aon_hte = {
>> +	.map_sz = ARRAY_SIZE(tegra234_aon_gpio_map),
>> +	.map = tegra234_aon_gpio_map,
>> +	.sec_map_sz = ARRAY_SIZE(tegra234_aon_gpio_sec_map),
>> +	.sec_map = tegra234_aon_gpio_sec_map,
>> +	.type = HTE_TEGRA_TYPE_GPIO,
>> +};
>> +
>>  static const struct tegra_hte_data lic_hte = {
>>  	.map_sz = 0,
>>  	.map = NULL,
>> @@ -535,7 +640,9 @@ static bool tegra_hte_match_from_linedata(const struct hte_chip *chip,
>>  
>>  static const struct of_device_id tegra_hte_of_match[] = {
>>  	{ .compatible = "nvidia,tegra194-gte-lic", .data = &lic_hte},
>> -	{ .compatible = "nvidia,tegra194-gte-aon", .data = &aon_hte},
>> +	{ .compatible = "nvidia,tegra194-gte-aon", .data = &t194_aon_hte},
>> +	{ .compatible = "nvidia,tegra234-gte-lic", .data = &lic_hte},
>> +	{ .compatible = "nvidia,tegra234-gte-aon", .data = &t234_aon_hte},
>>  	{ }
>>  };
>>  MODULE_DEVICE_TABLE(of, tegra_hte_of_match);
>> @@ -635,8 +742,17 @@ static int tegra_hte_probe(struct platform_device *pdev)
>>  
>>  		gc->match_from_linedata = tegra_hte_match_from_linedata;
>>  
>> -		hte_dev->c = gpiochip_find("tegra194-gpio-aon",
>> -					   tegra_get_gpiochip_from_name);
>> +		if (of_device_is_compatible(dev->of_node,
>> +					    "nvidia,tegra194-gte-aon"))
>> +			hte_dev->c = gpiochip_find("tegra194-gpio-aon",
>> +						tegra_get_gpiochip_from_name);
>> +		else if (of_device_is_compatible(dev->of_node,
>> +						 "nvidia,tegra234-gte-aon"))
>> +			hte_dev->c = gpiochip_find("tegra234-gpio-aon",
>> +						tegra_get_gpiochip_from_name);
>> +		else
>> +			return -ENODEV;
> 
> I'm wondering: instead of doing this cumbersome lookup, perhaps it would
> be easier to create a direct link to the right GPIO controller with a
> phandle?
Possible, need to see if gpiod framework has API exposed to get the gpiochip from
the phandle.
> 
> Thierry

