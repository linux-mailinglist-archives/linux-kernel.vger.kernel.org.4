Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C7D6E7E25
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjDSPX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjDSPXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:23:53 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20613.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D795E55AD;
        Wed, 19 Apr 2023 08:23:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zdjn6HdKqwIzmGgpbS4Cryfv4R5vXZSI19AwG3eIhRJ51i0SG3rnI7BLO5FtWXk7ANEfG0XfIyh4FStmCqOI8OPiwaHgKlBQp68YymYqctNMAhAzOKm9dE+9jgA3ynWXNvlB64jVExqyjQWhJLw0hwhR+nLjKaZ0ei03/qEk41geMUFG1DM7qBA761V/0S8mNQj/h8IXWKjVj8niYClgy96fKtISC2mlW1mwHuhNZcut01p3FBI9yl/95Bo2IEHi+TIj4rgQZDm54rXLdAdxK0soZxaAUWUaOhhOLZajF6baWRPdnmBIoJ8ysMqAXkcpvrtgMrZQEv63TGXKFcWHMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzO0jUgLWXetaNFyh0H2kjjZH3m3JlmlSNR/soSb4/w=;
 b=n7/4alJKNwtO5fYZBfqefbAq2SbyOhp/8nf2TV73s4RqXjJdOUJAyUGorLsq4H/kZuDClQXlPDV0p/b1kOCJZ5lKxcCeVHXRuvKNjKvCD07iGddSwWPuIVWxe0EZ/MyNGA0vAMMlDP2eP89Cmso/snAJG8Lwfq0COO+RRLpaJSwlZMD8aOb6zmJVj6DRYP32rtwr/uf+8pMB5FIN902s4BpxAaiteqz1YrFlE9oUmlhpSkYO7nwJAA/0cvHKqnLsZlc85+IGkY7AZuqsHU6IxwnEfiEnoHd9x9LyPq9I2W9h5Q2UiH+eksAMXbHO/eQ7O8F/ZBR9GomNNxJB62p2sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzO0jUgLWXetaNFyh0H2kjjZH3m3JlmlSNR/soSb4/w=;
 b=eu9qixi8a6VDsyH1uZv7mWDJkshfmET3OUsjO9tfF9Py6wxBDPnQawcy9KyXWlK7XpoVXAWrfsT8IwgmY9Hwh7unzHgIBDeNxQ2BftqHPyL2Q3u5AVYSYFd7pCA4UeXoK77oZsCqqKTc2QWjL4XGZDMFAl6wlBQGbK94Nq3jwGM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB7936.namprd12.prod.outlook.com (2603:10b6:806:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 15:16:47 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57ca:ec64:35da:a5b1]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57ca:ec64:35da:a5b1%7]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 15:16:47 +0000
Message-ID: <3392445f-b64f-b9a8-0f3f-3a6f9d6aeadd@amd.com>
Date:   Wed, 19 Apr 2023 10:16:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 7/7] x86/resctrl: Add debug files when mounted with
 debug option
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     corbet@lwn.net, Reinette Chatre <reinette.chatre@intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <168177451010.1758847.568218491528297451.stgit@bmoger-ubuntu>
 <56497126-8f60-e590-bb13-b3739114375@linux.intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <56497126-8f60-e590-bb13-b3739114375@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:610:74::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SN7PR12MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: 96cd7da3-eb49-4872-17cb-08db40e917e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1bDlnJ9VpCR5fcGuyrRwZJDOSZ6Jr9xPcFSn2o1ROo570Rp5YhJqkJm/Nj88TuBBBA48/nV4ULzXSOap0uLlveQtn05LxmWqgrEQ20DSoZ/KPtTjqqgNyedY1xMkS7Pl9QlBo/2TXBpoPjmiYslNhXzLG4nIVrvAeoStldFOTLs7W1q0zWSZM/0nXe8iQfiTH45Wwt2YXw3XEODS9dMyzMMBOmzQYt+KI3zSGfDY4iRzzT5Juw4/GWLwYXfokoTadwEro16ag1U/qukWS80TloKVoII3xmCNVWnWuB/FbGe9RRzCQEmlWV8WHEx2rFHSMd1GEi9RabqFpVGxIRZlyK08Bs269tXGX8oxAvwEF1nphGpjKEAK9Jw53qqaCejIQdJlSdBdtuTPLB5BkmrfrBxb1LDdz9CiTACx35Mlk7cN++pGZitCgj7eQ+RrDryzKKtTceLoa0QC5Yc8AB2nVcdrxlKU2D064hj0LleuNrR+9mk4X5Egrfer2of+5b0OSiUEBkFafqgPCy4Bs242hweXJ/Gy+Yu3OZhqMymocSrzBm2uf6L7X87cA0zVmwVWLr+tixogVdeyFKJywkbodLyjtvzhuKfMNQAvn2wIdQllnjYiVlkic2GiRZRkBT0lm81BF/LBiBbqkNL+nZKHHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199021)(186003)(6916009)(2616005)(4326008)(53546011)(66476007)(6512007)(6506007)(66556008)(6486002)(66574015)(54906003)(83380400001)(66946007)(316002)(41300700001)(6666004)(478600001)(26005)(38100700002)(8676002)(86362001)(36756003)(8936002)(31696002)(2906002)(7416002)(3450700001)(7406005)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzFHcjllbmlyZEhjWXU1UFJoQ082V0JENUdMb1NaSG5VVmJSTDBueWlQT2dQ?=
 =?utf-8?B?SGZrRTZlc3lhSVZnYVVPaWEvQVZiSUROanZnVXEvMGVyRlMvUVd1cDRNeEJK?=
 =?utf-8?B?UnBQN2xzdHgyTVk5TWVWbEpMamswdUVKWExXTEl2SjRmZGFTbzFwSCtrQjJv?=
 =?utf-8?B?bElUZzBKbG1qR01LOXRpSE9TRnhiRGxiSTZ6bHg3elVZM3FQZnA4cXE1TVl3?=
 =?utf-8?B?UEJlWWxYRkMyZDVKelhxcUptUWIwQWJiQUFFY2IrSStFR0tIcjNSVXRZOThp?=
 =?utf-8?B?VVIvc00zZmN5bmxxM2hDTDJhaWRGZDhmQVhsQTJCVmR1SnpsMmxsM3ZRUVQz?=
 =?utf-8?B?a282VkU3OUhQNjNHZWxxZURveUxKTlM1MkxEQ2R5a1BOWTFHZWdROEpVaTVF?=
 =?utf-8?B?UUVMN0cvMys2TkRuSXZ2QkRLc0pOM0JXVGQ3SlVHY0NxLzJzdEFNKzlWUUl2?=
 =?utf-8?B?eS9KQUhUQ0NoRGkrcExnN2Rpc0kvYmxxRkVEeGx1NmJBZXJqTG1uWTFwWEo3?=
 =?utf-8?B?UFBsVHN4K3JDZ3RUOXEvUXA2bEQ4ck9WMHVhZUkvcTF0UTlLdzlsTXNsV0Nz?=
 =?utf-8?B?NDBrcHorTG5qSjdPek5UYlJsNWthVk4xdkUxcm1VQm9iQTlLMXFmcmU3TlpF?=
 =?utf-8?B?WklKZ2tTeXliek1hNWRSdFl5N1paSUV0K2hVSjJSbCtiRDE0MDRHVXhMcEZW?=
 =?utf-8?B?UFhtREYrRzdsQS9kbElTZWMwakFmMnlYbGZBeFVqc2hPRzQxTGI4UW5qM3Zy?=
 =?utf-8?B?WkFaZ3daajVhK2kwbUZRNFR3bzJGWlFLeWpVK0NRM1Y5Q042OFQ2TzRIL0I4?=
 =?utf-8?B?cHdERjdQaVV5TTRBL3oxZkh5NVhVaE8xTHU0Z2pKOHlrMWdnelJPRU1BdEJT?=
 =?utf-8?B?eURxUEdUQTBsSU9yeUdQNk9tN1ppb01wSWZLMzY4aGJYWmJUZnlzSktRRVc5?=
 =?utf-8?B?VGdIODNaenZ0Z3Q2eXZHdWVsanlnMUhFZFg1dUYyTHp4T3NkZnIwRTVKZVZE?=
 =?utf-8?B?dkZIanY0RDlaWDE5KzFMMjNUNGlhdldaSzB3ODJTNHduaVJueDhER1FNTXQ5?=
 =?utf-8?B?NUM1MjI1ZUU5UHQ1Nno0SzcxaUdCNnBPRW1CR0N5TXpUOUZJTk5oS2pBOWx2?=
 =?utf-8?B?WjEzZ2RDNjREUDlJSVA5bTVjRlJMcjZ5a2ZxbE91WHBhdGVpdGU4S2M2QUo4?=
 =?utf-8?B?NFQ2TUpNTzFKR3pWWDM3dE84RlhmeEw0NE1tR1QwRGVRcU1ndmJ6TUNrZ1VO?=
 =?utf-8?B?dFlRb2tobUpOVFVmd096Zm0veW82MEdqM3BJQXZMZ202Zmhmd0d0U2t1Y0s0?=
 =?utf-8?B?a1ZhYmticlh1NmY4V24rNURRZGZvRjA2cVRnOEtxNFM0K2F0b2pIbjRPSVlD?=
 =?utf-8?B?THV1T0NSN2h4aTR3TmF4K28rSUJOeVV6ZDRhWklBT1pOK1QwV0I2RksrQkd4?=
 =?utf-8?B?d0h0SGxRc29saUFvaTZnZmpwNm9ZWmFaOHRiMTBKdVRSNlJUSjJuTkFGVnNw?=
 =?utf-8?B?enBwcTdiMDRsUFB4TXVaSXpXNWE1azBVYVM5UnNTY2ttYTBTUWNLd0JxMWJ0?=
 =?utf-8?B?TTkrcmxIbTIxVWE0aWJaNDhXc2lGMjBOMDhPUTlBSE9JREpnei9nMEN3Q2s2?=
 =?utf-8?B?a1J1a2dyWWl1RDNrbklSbWlZd2liZnNQNDV6a3ZQNVUwWUErbC8wUmorL3ZH?=
 =?utf-8?B?RFlFZ1Z3WHlEYUpGTW44dTI5Z1FLeTJPMFVMUnFyaXV1dy9sakZEYkdhRzBx?=
 =?utf-8?B?K0tMTkFnQS93WWVmU2VCeTZGYnFKbS84eTJtYmJvYTh5bTNSZTNXekxMVHVV?=
 =?utf-8?B?dWh6QWZVL0U0bjlGRHFFUzA4d09Ca3VacnNTSFpHOXlOQnJCUmpUT3dzWEhv?=
 =?utf-8?B?WUVmNlVFelBXMjN4cnp2WFN0czhKeTArWHlEcjl1UDVBbTJtMGFmMUlwZ3pq?=
 =?utf-8?B?OTQ5OXJ0M1k2OUgyLytoM09NakxCOEVKSk5QQ1p1akxXWDNnbzRuU2pmTFlV?=
 =?utf-8?B?YTZndHlpTGZmanlVMm81Y1c4enU3a1IrbGlmR0d5bEV4WUlndzlVbEJVUXY1?=
 =?utf-8?B?QkVHbG9FZzhpb1ZvT2Vtc1JuL04wTlZzRjNQcmFKbVVHOFh1Y2RWTFVzN0Qw?=
 =?utf-8?Q?XOH0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96cd7da3-eb49-4872-17cb-08db40e917e7
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 15:16:47.8375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQJ2YCj3QRab3A2gcJF/Jmu5WyuI2PsTuHUvkbibcUqdfujuEKt+5+2cPVunhzoX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7936
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/23 08:20, Ilpo Järvinen wrote:
> On Mon, 17 Apr 2023, Babu Moger wrote:
> 
>> Add the debug files to the resctrl hierarchy.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/internal.h |    1 +
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   54 +++++++++++++++++++++++++++++++-
>>  2 files changed, 54 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 1eac07ebc31b..855109abb480 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -288,6 +288,7 @@ struct rdtgroup {
>>  #define RFTYPE_TOP			BIT(4)
>>  #define RFTYPE_RES_CACHE		BIT(5)
>>  #define RFTYPE_RES_MB			BIT(6)
>> +#define RFTYPE_DEBUG			BIT(7)
>>  #define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
>>  #define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
>>  #define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 15ded0dd5b09..1ec4359348c2 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1880,6 +1880,7 @@ static struct rftype res_common_files[] = {
>>  		.mode		= 0444,
>>  		.kf_ops		= &rdtgroup_kf_single_ops,
>>  		.seq_show	= rdtgroup_rmid_show,
>> +		.fflags		= RFTYPE_BASE | RFTYPE_DEBUG,
>>  	},
>>  	{
>>  		.name		= "schemata",
>> @@ -1909,6 +1910,7 @@ static struct rftype res_common_files[] = {
>>  		.mode		= 0444,
>>  		.kf_ops		= &rdtgroup_kf_single_ops,
>>  		.seq_show	= rdtgroup_closid_show,
>> +		.fflags		= RFTYPE_CTRL_BASE | RFTYPE_DEBUG,
>>  	},
>>  
>>  };
>> @@ -2420,6 +2422,49 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
>>  			     struct rdtgroup *prgrp,
>>  			     struct kernfs_node **mon_data_kn);
>>  
>> +static void resctrl_add_debug_files(void)
>> +{
>> +	struct rftype *rfts, *rft;
>> +	int len;
>> +
>> +	rfts = res_common_files;
>> +	len = ARRAY_SIZE(res_common_files);
>> +
>> +	lockdep_assert_held(&rdtgroup_mutex);
>> +
>> +	for (rft = rfts; rft < rfts + len; rft++) {
>> +		if (rft->fflags & RFTYPE_DEBUG) {
>> +			rft->fflags &= ~RFTYPE_DEBUG;
> 
> I don't fully follow why you need to play with ->fflags like this.
> 
> Is it for the ->fflags test in rdtgroup_add_files()? Can't you just do 
> some extra masking there for RFTYPE_DEBUG based on resctrl_debug which 
> you already keep?
> 
>> +			rdtgroup_add_file(rdtgroup_default.kn, rft);
>> +		}
>> +	}
>> +
>> +	kernfs_activate(rdtgroup_default.kn);
>> +}
>> +
>> +static void resctrl_remove_debug_files(void)
>> +{
>> +	struct rftype *rfts, *rft;
>> +	int len;
>> +
>> +	rfts = res_common_files;
>> +	len = ARRAY_SIZE(res_common_files);
>> +
>> +	lockdep_assert_held(&rdtgroup_mutex);
>> +
>> +	for (rft = rfts; rft < rfts + len; rft++) {
>> +		if (!strcmp(rft->name, "mon_hw_id")) {
>> +			rft->fflags |= RFTYPE_DEBUG;
>> +			kernfs_remove_by_name(rdtgroup_default.kn, rft->name);
>> +		} else if (!strcmp(rft->name, "ctrl_hw_id")) {
>> +			rft->fflags |= RFTYPE_DEBUG;
>> +			kernfs_remove_by_name(rdtgroup_default.kn, rft->name);
>> +		}
>> +	}
>> +
>> +	kernfs_activate(rdtgroup_default.kn);
>> +}
>> +
>>  static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>>  {
>>  	int ret = 0;
>> @@ -2433,8 +2478,10 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>>  	if (!ret && ctx->enable_mba_mbps)
>>  		ret = set_mba_sc(true);
>>  
>> -	if (!ret && ctx->enable_debug)
>> +	if (!ret && ctx->enable_debug) {
>>  		resctrl_debug = true;
>> +		resctrl_add_debug_files();
>> +	}
>>  
>>  	return ret;
>>  }
>> @@ -2851,6 +2898,11 @@ static void rdt_kill_sb(struct super_block *sb)
>>  
>>  	set_mba_sc(false);
>>  
>> +	if (resctrl_debug) {
>> +		resctrl_remove_debug_files();
>> +		resctrl_debug = false;
> 
> Logically, this false assignment belongs to the earlier patch.

Ok. Sure

-- 
Thanks
Babu Moger
