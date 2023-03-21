Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7A96C3648
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjCUPzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCUPy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:54:59 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B303B645;
        Tue, 21 Mar 2023 08:54:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEx+Laf2H0U7+d2uNDRlD8MY41C+OPg8FdYLL7Da4fcl42IJdCikztW9UV+/7UDP0h3U8D+bTBSaQY1m8JvpRadKVWZFmKTRPQaUkiqkO0+5ojTJYjXsNG5rlvsbL80PRMWH2WOJLw5/es4lOjNjmuiywIYRu2Jo4GNvO7rNkD+ymahzYcPl1oYr/KbgnQIIQpsv2LsglADa1HdG3nK3qx6l0dp++tND1R9+pSut9Etuy/+2zZdXRVrmtjT/N4W3ow2U8RMLVd8ZOFPp7i94oOd/Tx0YoRtobwvT8vja0YNKBxAiyhLaZB4BYJ2ETS3mZHzEgOd9rqzXOwmLcMn3sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEs19ldN6bRByOWZyFPBM3IWONAPmUGjsHFpB20BiRw=;
 b=ntZ3Ya0dckW6dKNF5h1WO3iEFXwJEVYfaKitVW2VJ7TQ+rGzDolPV2fnHuMHB5REIzwMQKjruIsYfUIVTvTJu90ya1SUJ6/89oEgPCBON3YllVPJcVDBcncDgZ5QnYLLecG8hMkrZIZwD3VeJYgyBhNphmstIbhuVi54BoRokQaTipRX4ZGmmRQPtjuknYLwoekYy6bGF6MBZ/BwVOsUcAE/uVw5tPWa2aO57M0uJN5Am/FIshekus0eFI+S1+SbmbjshJ9UGbQcKqxvTGLy7xWslVW4PZU5Y7JEbIhcgKvZplvcLVBsDjb1gKVUdh/COq5PxkTfqMi5Xgc/6+9ASQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEs19ldN6bRByOWZyFPBM3IWONAPmUGjsHFpB20BiRw=;
 b=TETI9o+bmzjWIaqE0FpFsLnq9veFmPUijDsYtYyJ35HKEvwDHiXCmHLiyA3tdZ5vTNFV24nzKlU/Ciaa1KpZpUtI8DcQK0WNEMd8YNN3UlTBjQh8ku+PDYysqlm/sJgR9obB7tcTe9UzsA4hMPYdvZcE/S+EfMjx/knsaImblxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB8698.namprd12.prod.outlook.com (2603:10b6:806:38b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 15:54:53 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6%8]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 15:54:53 +0000
Message-ID: <c083cfb4-3282-2aeb-c704-9cc21ada918e@amd.com>
Date:   Tue, 21 Mar 2023 10:54:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 4/7] x86/resctrl: Re-arrange RFTYPE flags based on
 hierarchy
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
 <167778868692.1053859.13490646651097380957.stgit@bmoger-ubuntu>
 <26400c6a-dcde-9ac2-df7a-117a12875f0c@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <26400c6a-dcde-9ac2-df7a-117a12875f0c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:610:cd::8) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: 85eb2150-770b-446a-7bd5-08db2a249c20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aCuiaWwqfh+qBu2pd1/IakvZE4ASP5pn3nDTaatVzbT1N8LD2XTnD0b20GXSRd/JyJsXVpLg3i39r/poZXAxZj03Y0LCTz/IzNWoWWvswxL9xEAh3Jm+Mi2yq1ZpMq0VngG2RrMfN89RXe8q7vhbI9n+qP2kYpKtVa5lLQ2UYfgIQux6t52l4orwyg0ElKJEVml34SxsDYhIdSSABOOKEOireJ+SQE/A0xAejA+aUcVUtUwsBOQYfOunqfqfNwzh04PP7VAa3d2jW6IGmF6xM/tFwUM9KyZe2jJPa10z3Dd3m6XZkOnR+mSmlEWeU1iU8k44JBKG87RaN8f1STXkhJCDajQlvA81H4EaksvLAmKePpm5871oXveKKSdzaI4DGfzuvxGUiqzSdb2HvI3cl3/DcyVgpc2vkq9TubtnaRdnX9Z+TsvdxK912zh+wBgk9OkbE7dAP6pKse51tDOuATrtRV4Tgo9tybGfD4t64a9e+vpXertgPCzDYUWf3kNZs3VtmAcDoy2bTsePvPfxt5128qhfkkIHtJMuHJNhXbVjiOgCQ8NpN3NYp2TcBVNi5y3AEPYdUaqjIwJhflrzgSI/m3zSyoVx8z+yY6NpzTNagjBtcH6c5M7YAwdoWaO0FVpQGTt7Ar1J+vCIGlwSnkWqvX/jyPrBeT2VRIYbqNnznHOob8B9bZ66f09ubVwhIBQOlwnZyn4yYBjFPtB0I+irICbiDh8/N9evstMjdpw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199018)(2616005)(186003)(6486002)(4326008)(6666004)(53546011)(478600001)(83380400001)(316002)(66476007)(66556008)(66946007)(31686004)(6506007)(26005)(6512007)(8676002)(41300700001)(7416002)(7406005)(5660300002)(38100700002)(3450700001)(2906002)(86362001)(36756003)(31696002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTZ4YmYyUnB3anpjN0RqYU4xLzdrUVdwQWVhNVo2aWM5ZlZtbkhoRWgxaTdL?=
 =?utf-8?B?UGRTbWppS21PQmFRcy9WcFdNRCs4eHorM04vd2V4aUdRTGdTUTFFNGR4Vi93?=
 =?utf-8?B?OHVoUHRHblBPNElQREk5SUJoN3RyelZmVStMVWFUQ1FkYjhTTlR3ckhBejVz?=
 =?utf-8?B?RlUyQW9wbXcrbUU2RWtSZWtCK2RVK2FrNFVsVVMrZjU4YmVMeElEblZjRDhV?=
 =?utf-8?B?bHFiUXVXQXVBOCtpdHowK1BOMktmaStxYWk0WVZIOXQ1U1FZRHJpeVBNQ3dC?=
 =?utf-8?B?R0RNeG15SzQ5aVlOYk5LZVRyUlMzNUFpL3RwK0JNbDhZMXVuOFZUV3Zvb00x?=
 =?utf-8?B?UGFDSkpITzFRcnkwWlEvVndMdVVPckhTV3gwU28vSTY3L3ZIbFFLV0lqdE8x?=
 =?utf-8?B?OUtTdmhSNTM5TVhQYlNpV1AzUDFLRk9MblR3Nk80OEMwcytsUzdhSkE2SVhH?=
 =?utf-8?B?WXM4YnMxWkx4VEt6Q1FvVmF4dHZUamRYSXk1YWdFazZNRjZOSTNXQ3d3TURN?=
 =?utf-8?B?eDVoUkEyRzdMYmFEdEtGVWlRVGgvVUovendKRm5yckdWMHcvUUdWWC9GelpC?=
 =?utf-8?B?SFpHOTBQUmFYdVZ6V2dqMVBLY2lXTDdhUDJWbTc2NU1XQWYzYmtETld2ZWNt?=
 =?utf-8?B?V1Ztd3lKbVdLZW00dDl4cmFYa3hSUUhWNmx5RkhRcXF1M2RpZ1Q1dDZ2eUFJ?=
 =?utf-8?B?Mmptd0VpSjV6S0hLd0pyM0hLNDc3TEFEK2lsdkxPZXVlbGYwK0RkRVZjV21v?=
 =?utf-8?B?cGE5SmJjYVV4VnVtaGxXbkI1L1VoYThicEJFOS8zMnZkc0ZiRWlpTEpvUC9X?=
 =?utf-8?B?ZGlVNjF5TkdQeEEwV0tsUTNoc0t6Q2tBczR5dGpmcUl5ZVZrRXdabWE4VXlP?=
 =?utf-8?B?czl3bk53NEZ0NDNpZXlpTEVyL1ozRHI1MDZPV20ySzZ4SWpuSHRIMkVNUzZP?=
 =?utf-8?B?VEZ1VEtHV09KdldWeldZbUo3a1ZMK3NDbTI4RFByMnRUMlQ0d2pSeEtvSU5j?=
 =?utf-8?B?bVppVUhsSjZYQytoMjlYNitWaytIL3FJOFB1SUNsRTgxMkUzcUQ4UzBVNmN1?=
 =?utf-8?B?M25DVWUwcEdsWUtZbG9uT09YdlJMdTQrV1hiYk5kbHRPa2FZVmFBazJYaGlJ?=
 =?utf-8?B?dlNIZTVjTWIyR2NCbVF1UzZUQUhTK1NyTVNMVXlieENCUnlaNURzVEpPaUVR?=
 =?utf-8?B?ZGU0eC9SSmNwTVVjN2pCb2xlVENaWlJCREhKN0tCakVIbjhQZjA5U3JGL1RM?=
 =?utf-8?B?TVdGYUpDL0RObzZXWndCZnZ5Tndod0ZGaU83M2JMUmJmbDZTUkxhWncvMU00?=
 =?utf-8?B?U2NBOGVWejhLSG85OHNDeUxSZEwycUh1VlhjdzBNZDlsRXFnZ0pCWjRoNVRY?=
 =?utf-8?B?N3paMjFtalJiT0srS09RYzhFVUlZUnpKL0p4d1BNNXh4azRjcFVQUDJFZTVi?=
 =?utf-8?B?ajBxT0dZaS9IMFJueW04Y28wNVp2Qms2ZzlRZFRER3RUZWlGRWpNN1V1c1d4?=
 =?utf-8?B?SitvekxrSkdpcGd6TEJKTEVScEx3Mmt6bjFDbzZWWnBmWGtIYVBzQUpYbHJT?=
 =?utf-8?B?SkZVcVNNVnZTRzQwSnFRd0pLSGtnSS8wNmcxM3h0ZElSbmNtQzlUaGoxTi9N?=
 =?utf-8?B?a293UUtFS1dlaWw2YlZPMytmWmhRTWZoOFNkTjNGTDd3aEI1NkRkUmxuZy8w?=
 =?utf-8?B?aHdQa3JYNTNOYk1GYTU4dTVyNzBUMndJeWx2enUwYUVkZWlIVk5DUmdhbXNR?=
 =?utf-8?B?cEFsR0h0WFNwOXlsWjNuTTE5aG1CUm80bTJFRVVVWERFd09Gang1SWtxQUFr?=
 =?utf-8?B?dS9qS1kzREhxMDRPMGxiRkgwSS9ra2ZSVjBnOWFZdmtzU0t3ZDRoUDhhN3Fr?=
 =?utf-8?B?NnFTUm1GUVdOY0dNdGo4OUhLTFBrbnJEQWRZVU5YRkJNTnZRVUppV1UveWs3?=
 =?utf-8?B?ZE5aK1lyTmFpL04vci9zbFVCa2ZLb2wxTTBWWHczQWNCSUhlbGovdGJJMGVI?=
 =?utf-8?B?K2FQSWNkU1FsMWYwYXVrQXVJUS9rRzI3V1NMbWEyWCtxZWtWN2xHS1huV0lz?=
 =?utf-8?B?ZUNUMDBBemVTakU3OUw5dXYzSVp0eVNBSDVVMnl4U3ZlTWFvVllrVWk2RHQ0?=
 =?utf-8?Q?F1AOk2qNZeNXYPyl8S9ffGs6p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85eb2150-770b-446a-7bd5-08db2a249c20
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 15:54:53.3370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G19qAhTw8waPvTKN0/g1B1rREavfhZAmSkZYAZN4AwIgh/1ON53P9Itkq6jkeDWx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8698
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,
To be honest, I had tough time understanding these flags. Also, I need to
add more files in the future. So, I am trying make these these things
clear before I do those changes.

These flags decoding is pretty confusing. Also, there are some flags which
are duplicate. Not really required.

For example:
  In group structure, we have control group or mon group. We just need two
bits here. The code uses combination of 3 flags here.
#define RFTYPE_BASE                     BIT(1)
#define RFTYPE_CTRL                     BIT(4)
#define RFTYPE_MON                      BIT(5)

Also, the flag RFTYPE_MON again used in creation on info directory.
Basically, very confusing to add anything new.

I will try to minimize the changes in the next version but still make it
clear.


On 3/15/23 13:37, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/2/2023 12:24 PM, Babu Moger wrote:
>> RESCTRL filesystem has two main components:
>> a. info (Details on resources and monitoring)
>> b. base (Details on CONTROL and MON groups)
>>
>> The rftype flags can be renamed accordingly for better understanding.
>> For example:
>> RFTYPE_INFO     : Files with these flags go in info directory
> 
> This is not a rename but the current name.

Agree. I am giving some example here. I may not need to change the text here.
> 
>> RFTYPE_INFO_MON : Files with these flags go in info/L3_MON
> 
> How does this improve the current RFTYPE_MON_INFO?

RFTYPE_INFO_MON -> info/L3_MON.

I tried to improve some readability based on hierarchy. Basically, looking
at the flags we know exaclty where these files land.


> 
>> RFTYPE_BASE     : Files with these flags go in group's(control or mon)
>>                   base directory
> This is not a rename but the current name.
> 
>> RFTYPE_BASE_CTRL: Files with these flags go in only CONTROL groups
> 
> How does this improve current RFTYPE_CTRL_BASE ?

Again, same explanation as above. Started with RFTYPE_BASE and added
RFTYPE_BASE_CTRL to say these files are on top of base.


> 
>>
>> Add comments to make it easy for future additions.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/core.c     |    8 ++--
>>  arch/x86/kernel/cpu/resctrl/internal.h |   64 ++++++++++++++++++++++++++++----
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   44 +++++++++++-----------
>>  3 files changed, 81 insertions(+), 35 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 030d3b409768..d1c6b2cc8611 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -69,7 +69,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>>  			.domains		= domain_init(RDT_RESOURCE_L3),
>>  			.parse_ctrlval		= parse_cbm,
>>  			.format_str		= "%d=%0*x",
>> -			.fflags			= RFTYPE_RES_CACHE,
>> +			.fflags			= RFTYPE_CACHE,
>>  		},
> 
> How does this rename improve understanding?

Agree. This change may not be required. I can actually remove these changes
> 
> ...
> 
>> @@ -97,7 +97,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>>  			.domains		= domain_init(RDT_RESOURCE_MBA),
>>  			.parse_ctrlval		= parse_bw,
>>  			.format_str		= "%d=%*u",
>> -			.fflags			= RFTYPE_RES_MB,
>> +			.fflags			= RFTYPE_MB,
>>  		},
>>  	},
>>  	[RDT_RESOURCE_SMBA] =
> 
> ditto.

Agree. This change may not be required. I can actually remove these changes
.
> 
> 
> ...
> 
>> + *
>>   */
>>  #define RFTYPE_INFO			BIT(0)
>>  #define RFTYPE_BASE			BIT(1)
>> -#define RFTYPE_CTRL			BIT(4)
>> -#define RFTYPE_MON			BIT(5)
>> -#define RFTYPE_TOP			BIT(6)
>> -#define RFTYPE_RES_CACHE		BIT(8)
>> -#define RFTYPE_RES_MB			BIT(9)
>> -#define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
>> -#define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
>> -#define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
>> -#define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)
>> +
>> +#define RFTYPE_TOP			BIT(2)
>> +#define RFTYPE_MON			BIT(3)
>> +#define RFTYPE_RES			BIT(4)
>> +
>> +#define RFTYPE_CACHE			BIT(5)
>> +#define RFTYPE_MB			BIT(6)
>> +
>> +#define RFTYPE_CTRL			BIT(8)
>> +
>> +#define RFTYPE_INFO_TOP			(RFTYPE_INFO | RFTYPE_TOP)
>> +#define RFTYPE_INFO_MON			(RFTYPE_INFO | RFTYPE_MON)
>> +#define RFTYPE_INFO_RES			(RFTYPE_INFO | RFTYPE_RES)
>> +
>> +#define RFTYPE_BASE_CTRL		(RFTYPE_BASE | RFTYPE_CTRL)
>>  
> 
> It is not clear to me how any of the renames improves understanding.
> 
> How does renaming RFTYPE_CTRL_BASE to RFTYPE_BASE_CTRL improve
> understanding? Renaming RFTYPE_MON_INFO to RFTYPE_INFO_MON?
> 
> This all seems unnecessary.

Again see my comments in the beginning.
> 
> ...
> 
>> @@ -3218,7 +3218,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>>  	if (rtype == RDTCTRL_GROUP)
>>  		fflags = RFTYPE_BASE | RFTYPE_CTRL;
>>  	else
>> -		fflags = RFTYPE_BASE | RFTYPE_MON;
>> +		fflags = RFTYPE_BASE;
>>  
> 
> Is this intended?

Yes. We don't need this extra flag (RFTYPE_MON) here.
Thanks
Babu Moger
