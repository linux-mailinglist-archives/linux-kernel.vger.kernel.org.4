Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E956E7E1B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbjDSPU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbjDSPTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:19:43 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CBF83D8;
        Wed, 19 Apr 2023 08:19:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpXBWJZQExBrDprlAYPuGPySFe+VXdUBiwc8te5b4V32RgnUYOEpI7Uu2wM/vwM2MrNNkRrIHRX+eLYolqvjWxWbGCfX55vUeYvhuUVVqwqe/BRwUUmdHsMLuQQu5ggu0I/R/C0vdkQ/Cpj1UqjYzZAa1cQXqRkhOICTaM9OpCQDlVmoXEsBJbz8BBE83qhSSwqyXnetJCdEbNGmZijOHSzEp1f9vBTNAJMo7MAdQ+FIhSZL+NKB2CfA7x6r6y9hX+gRCxAK1dLfVOnsv3KlBrosAe4oYnTRxmKUYeD8LVPP+YVpagbFVo/D1+xDTlfdMWJT7FoFYQvzRnfQiANQZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGEKK3Kd79eK+22wFKb2GL11ovu5aBVga3/tr0pE9BA=;
 b=GHae8v1/d6UbgU8hSjoZ05wOxsEkdlmgEtVU9vE474yF8J4zdvhNZ41MkGDBmnteF0bOgHmQWnS47UCVjhq0LWRowYyzgQR44l16tHEExSMdmUJYbngO8xBE55jnpit/SJ/gYa61EEYh8vZPEHxsmaG4MscgwcdQNYkZcgdbjiH3yIEreUO7F3sswZVcpXd6E5G9EvPpVrkPmGfuYubv8QcRE2eFEEjbeRNontbCaP6LfKe5DtfcQf3bTEVxrYB1F/TnntM8l0gyDMVLf2TG45u75rEPPPHZEngjrFIQP9sw6+JO13UYYa5JqjztyJQq4mlUXWco+AD54cnl/IcKrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGEKK3Kd79eK+22wFKb2GL11ovu5aBVga3/tr0pE9BA=;
 b=2WWZuJtiBqPSQu//QcUlzwBIGqtveldDlxeXgiVykJ8GTG2pH2R/F+ITNzV/vzhO9CEjqvEojdWbPNBH46Rzd9Lpadx+juY87XYc78zBvec2xRIz+Wysqwfw4mjS9ih+TWLKosz/BHBi91BhkclZEwko13EgNKNuqSG573olfjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH0PR12MB8174.namprd12.prod.outlook.com (2603:10b6:510:298::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Wed, 19 Apr
 2023 15:16:13 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57ca:ec64:35da:a5b1]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57ca:ec64:35da:a5b1%7]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 15:16:13 +0000
Message-ID: <8e1903a4-28c3-a38b-8e65-5f37ce7c0d66@amd.com>
Date:   Wed, 19 Apr 2023 10:16:08 -0500
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
X-ClientProxiedBy: CH0PR04CA0074.namprd04.prod.outlook.com
 (2603:10b6:610:74::19) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH0PR12MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 13fad6cf-93b0-40b7-b6fa-08db40e90363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J0JoFyqkqRVDNOwLTs0JoUg5iB3Q8SSI18mS/8dhVeGon4oOUZpSOrAKRFtfgkRIzYshmal105UyXcq6yFn2fxeba+B8jTxuBmeGbm2q09EvdJiB0IjowVl0Lith8laKUPj7bC6r2omyRXVCuAHYAY45woSCRw/xLhGT8nb+xAP1J7Bvadyc5gNywzT+NTAFartSUpAXQEdjTSJ1YUKtauG1SxrWXL4cITjLLEVFKrFaltICLg7TqTWdEX1cM07tKO1e5hvbdAVEuCZI3V9f7ce6bUXyqj9tFkUJhHGkfbVXXVf4dkGeXG6RQ9nz0BKrolYLPk305efhhLTUzsuN25DhV/CZjHRWBySeg0yYftVd88v/BFEZkia7QNjMpNUaYwAzbW737WeSFc0j5lYUE8rz/IQ2IP2jGRuIIBsRvRpDq6a70yCcBVnTrkdDtnlhUMYmsd85Gh45x9LggqVF75q7CHy1F0ltvZUpKf74mskPCyhzKNtTBRD98aBwuI2Sc0tQb6RCSQhYWEW0wFmeYV06lUztMurL7vKpALPrvzOaVrT8MHXACYhak1s281Tt7wi5Cu//u1BiQKZPJPX4wQ6+CIje5styPgA0YRFw1ZBkmMOIXwuYkpMQtSYaBWa027pm6rxWKqkq6s9J09y2pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199021)(2906002)(2616005)(3450700001)(478600001)(6666004)(86362001)(31696002)(26005)(53546011)(6512007)(6506007)(6486002)(36756003)(186003)(41300700001)(54906003)(38100700002)(8676002)(8936002)(31686004)(4326008)(66556008)(66476007)(66574015)(83380400001)(66946007)(316002)(6916009)(7416002)(5660300002)(7406005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWhyRWhyTmM5MitHSnRLYTFSQzRaRWJJOENjK1RIZkd2REMrUTdMREVHNHNO?=
 =?utf-8?B?WGw0NGU1ZUJTTGpIUWo4RTJtQktkeWVKWHl1Y0lZNFJOREJ2Y1crazJudStl?=
 =?utf-8?B?cWN3SXRBbElCekJUN0JnNHJsSGlyek1uUzZRNC8zLzdZWXZpaVFFRXNwSHdt?=
 =?utf-8?B?UkNWSkdSZi9xR2UwUFdyTzYxb012ZG4zWUx6YklHb0tUQXZnL1BTdy92aTk2?=
 =?utf-8?B?eWczQ1lNTDFIRWljR0l4TWhrdWZQSExGNUp0dzNUNlZwcWR1NUw0MEpMUWhV?=
 =?utf-8?B?RFNCOHdnQW9rclRIYVBBbUdseWtHZTVhWjBKZkdydGJ6c2dZU2tLWUQ2VFBq?=
 =?utf-8?B?WXlmL1BER3ZnTjVZTm1HMGNPcnNxR3daZy8zSnU4WGJpNndYYnBwc21zQUU4?=
 =?utf-8?B?TDhXTU1mZm5TSUIwL3dHdmtsbEdjdmFreVdBM25oK0ptcVFKWWpKQ2hKZm85?=
 =?utf-8?B?QUxYN1NVcHUrMEQrWnV5NmxwYSszUkZlQTJyaVYvL0RpN2VrQ2ZSV2tVSTZo?=
 =?utf-8?B?NVd5Z1JFWjhtcVd2eW0yMCt0ZmN1UDR5Y3IzVk16S3Jud3RBZHlnbkpXbGV6?=
 =?utf-8?B?V1lPV2t1K3JVQTNEbk5hQnF4QjlCZklwc25GNThNbGZQUGRnb0FKNXgxVldL?=
 =?utf-8?B?RWh1aVE4ZVExd0kxcllXbkdqRm5EWVg5WVJhMWpDYzZ6dWtZS3pHTWF4Qjho?=
 =?utf-8?B?TnRreHp3SlpUTVlJVUxTL0N2b3BnaWlId3AyQ0dxaGNaMTdNS1lkY2JNR1lp?=
 =?utf-8?B?SlZsZzhiMldiWThVanp0R1RJM1JGdmczMUhJYXhGOFpBQlpVSTN5WGVCSUhu?=
 =?utf-8?B?amlRa2tLS0VMQ1RQWlVidm5oWnUxSGl5VDc2ejZZTHUzZHVFMDVxdkRtYjFv?=
 =?utf-8?B?R3VTVFl1VnMvSWk2blJud2J3SmFwQjFYcFBmM1dYZGhxR1pBcFBjZ2hMN3NL?=
 =?utf-8?B?NnJ1OTBkRDRuZTVDNzlyV1l3ZGs5TmJXMHVzQlZDeEt3WmJEQitsdlNnMWIr?=
 =?utf-8?B?WWgxZDcxZ2lZQXljT1dyTENoTEc2SWtCa2xkZW9qbllzMW8yaldva3JieFU3?=
 =?utf-8?B?WVNkUjJ4K1puQkluZ0pXc1hEcHI0VEVDWUpYNkhXcXpBYkx6VGVKRHZ1V29M?=
 =?utf-8?B?Wll4RHc2c1lLUDZGRWlrcVdXTjUySFdFQlU4eEdmd3BGL3pyQ1ZyelJkOHZp?=
 =?utf-8?B?MjZaREJ0aE5iQ1FUeW9LWXBwNkJtTitWRTlScHZEWXAwc1RTNkhGVkh3WE0v?=
 =?utf-8?B?UkFRVFRRTUZhVEU3bFpVUGtHdUgvaWFrbjc2SHBEY1RmUTMxSjZWbTRRaHBC?=
 =?utf-8?B?ZksvdlFyTjFaWTE4Qkc4Wnpib1pMcWJIYkFNeE9FUjlHWWZXckVEL25iUXEz?=
 =?utf-8?B?elpkOW5JQXZBOGZaMTdRSXZmSEVLcUx5bUZxcnFoYWh4Y3VlakJPbHJDWkww?=
 =?utf-8?B?a296TzFLaXpZcTlPai9NbGFSM3ZkVWNkRHNkTzhqaCs3L1NRa3liSXB0ZTdv?=
 =?utf-8?B?ZktwdngzS0hWenM5eTN0b1NrQjFMOCtCK3d5Mjc5QmlhVmc2ZzFWUFJ2QVRO?=
 =?utf-8?B?OTdRMWRhSTQ5d01pZFpJZllpVyt6L3JULzZrYkpJNVJXeThuYlZTOUR4WHd6?=
 =?utf-8?B?NmJXdFlEZGF1NGIxaHhzYTFuY21tNi9uU05rd1BlQjh4TEVxWDNYQWc4akY4?=
 =?utf-8?B?MEV2QmIyM1dMM2trVHB0d3poWXF3OHRDU1NJYlpYTHFKeWNKd0h5TlFpb0lW?=
 =?utf-8?B?ODM4dGNYbDZoempsYUlJZFdnTk5lUXZJc3EyOFVlczk3clJSSDNpNzMyc2pH?=
 =?utf-8?B?KzhvekFrTVVhSE12aXdKQmR3OEFEV3M1RUFkekNZNmFoMjdJRHl4MS8zRnd2?=
 =?utf-8?B?d1RkZk9mYmZBN2J5VDZmY016T3MyUUtrOFV5Sm9oVWhHMHRhWjZlTzE2S0l4?=
 =?utf-8?B?UVlDclJXLy96bllIaFdMaG9MenVoNjZlbHJ0cmhiTkZVd0RBN0RYVWgzUEZT?=
 =?utf-8?B?ZDlwQ09jNTFELzg3dnRoV2pwMDM5SmdtRkpIRW5xWTBVUi9ZWnBIN1dheFZw?=
 =?utf-8?B?SVNrUlhBRVJaUVFEbVpLN3FTL3VvNlM5MkZBNXpSUlNXZXZpd244eVNGdmds?=
 =?utf-8?Q?og6A=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13fad6cf-93b0-40b7-b6fa-08db40e90363
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 15:16:13.4219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXW+S1cCo1gkZF7IMlurt4dKoitximwjvmPOVNPlj8WjuK1f/hJ0fT1+QTIl/5vA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8174
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Yes. It is because of this check.
    if (rft->fflags && ((fflags & rft->fflags) == rft->fflags)) {

I am not sure about "== rft->fflags" check. If I remove this check then I
may not have to do all this trick. I can try that.


> Is it for the ->fflags test in rdtgroup_add_files()? Can't you just do 
> some extra masking there for RFTYPE_DEBUG based on resctrl_debug which 
> you already keep?

Yes. Let me experiment little bit.
Thanks
Babu
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
> 

-- 
Thanks
Babu Moger
