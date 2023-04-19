Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31036E802E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 19:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjDSRQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 13:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjDSRQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 13:16:26 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F83B3A82;
        Wed, 19 Apr 2023 10:16:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRBhwy8Pana3yAK5QgM/svzbvDsrrJHSbky8p3UsSqF5uXFn1rOPxeo8JFiWzp3y4UJAoFvClpX5nsia0uBP1488/HbKwGUSgnMw3fy2qD+NbWue3bU9pH9ytcGXU5dX3KQBLuBaQS/SC245ojP7Imoh7pAZO2payIV//3YoUxT+6OGthcyD9/D8J55iDPIeFXZmYfRLil+Om9Vzqb3nPJLJu3eD/EyPY1wLW9ZwsvAGB2vNJMD8LSuGMiTbFGyMEAXAOVgpRiziXLtCeUtdE646tInCi1aPsZKjkcOclga+y0dpMHVZQSlclMOqx0EnBL0HQnSb4oTxpuSdGn7XFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3rtXYMQaQZUD2XNAha6JJfVX+Ua+gMuaIREQ/hTHBI=;
 b=Er61+oAocIT12M1s2R6G2aAxSHgiNjvdK4DAMjFqdUsbx7/nkzt8jPS5AE+SAOMDtMRIe6rfm1FzsZInvO2wcqu0fFEhWakVZAQxkA7Goq2DLhL5C8YTCXbxmA7t+g2m0pZ5lMw+Yl+rbJEEcpuxWWf3n4q/JPOPpgbtIrFAgkJsmcs5HKocPhSbHpDvdlbMJWMDw3kGVPqQEk1WthNMYoiDSXimKoOSBsZtt7e5XgEtmxcMrslTlJXrXM7h1tyY1+lq0Sv63BPofrGhyRHzd1N22Ni3fsBwy0aRpN3RuwbdswV1Qc8jyPCFPuxmGEN/Ehpa3hjuIg1mTVfhPbNJQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3rtXYMQaQZUD2XNAha6JJfVX+Ua+gMuaIREQ/hTHBI=;
 b=MyDV7/untDxfShJVUjF4tw/DQWDJyRzuigyV2/QXnAj3WSCFWzY+nJAQP3bUfn5MbI4WCXto0tUmYvXioLMSR620SOFHdpiujXW7bXPGoesbjUHSqAC7tjBm0rV2NQt7M3UUp9bJbskBaXmoUm3KzEintYOVWsYKepgv8dfdV7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB8017.namprd12.prod.outlook.com (2603:10b6:8:146::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 17:16:22 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57ca:ec64:35da:a5b1]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57ca:ec64:35da:a5b1%7]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 17:16:22 +0000
Message-ID: <933d8ae2-d8b7-7436-5918-f639405c9ecb@amd.com>
Date:   Wed, 19 Apr 2023 12:16:15 -0500
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
X-ClientProxiedBy: BL0PR02CA0076.namprd02.prod.outlook.com
 (2603:10b6:208:51::17) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: bb71b89e-c75b-4b54-f64f-08db40f9cc16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZWffq2m7XW0k3HvdXzCNe8+P8o+ci4faYgK5JexmfClLeKuOs9NfXl1/XYRWHQmEqVmuwJ1it6AWlSFTQqSHbsUPuNqZJvPrS0CbwY7Ly3/rIZ9leaWX2KMHXq16jnqUk0B7i16DlxiPdzPYEGmEu8Xv6+dI9OQ7V1ROkqwKuRqUjI3lVgH/wP2Wh+ZYAXZom2arg3ffZeSICzUjCp5pWMC7pjn7scSZoTRbGP4fBIHvfqJOGAC7ddbZSu+dJ1P77aQAZxB5iU2+kSWC0KWE0wnmb2bACB99CJCaGPy/mY4B1OW0HtldO5ksk/+cMI2kKCPc2CwTRTaCZHhdB+kdlZj49r9RRvAxi/jJBf5KJbnYT4OxclGlDdPKEs4u52W9wtUm8SyarP+cqwpJtABbN/DrgH0MwizsDViIapiqV6/CJkH3nwfcDjGQFcLWSKtHmnnkPTBlDus5/MPCxoz5zPZtY1aOnd7yJxBSllfNQLOh/HXt4im0pxeFBLjUIRHWfnx3fzD2pyJCOL32LvKh7LsVmyyPScUguGcmJ24BxA/rGbTIhX1IZpqfJQjmGwbG2d74Z9knaSbRpqozIZ47bw/sU3Q3Pg7qyNl5J2p/ENA7Is1h/odEcdCLzTuak47Q62RPKiCdDqCvtq7JE0nqCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199021)(83380400001)(66574015)(2616005)(38100700002)(6512007)(31686004)(6506007)(26005)(53546011)(478600001)(6486002)(6666004)(54906003)(66946007)(4326008)(66556008)(6916009)(66476007)(7406005)(316002)(86362001)(36756003)(186003)(5660300002)(7416002)(41300700001)(8676002)(8936002)(2906002)(3450700001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFhxdm1vOWFqck1ETTFEanIxZEw0R0gxWlBTQSsyYzhOc2VVSDRDWWE4UDRt?=
 =?utf-8?B?U2pTbFZ5OFZNRHF4bnhXSStjSXk2aWp6bmJ5ZW1JVjUrU3VQYkxQbThIVXNh?=
 =?utf-8?B?eUxjWG04bk56U1dTMXVLa3E4RDZXVlhQRHJHbnllcUVrbHRkcjRtSlR0aHVU?=
 =?utf-8?B?bi9WYTBQV1hSckhYaE8rTUhDL2dGRW1Pd2V5bUtvdi9UV09MMzNYNWt6QlpQ?=
 =?utf-8?B?Y0kwc1VUZ1Myb1V0bE1pSmlpL2FZemhCcDc3Q3ZOdFg3Z1dtUXV2NmlyNEpG?=
 =?utf-8?B?eGhPMnpqY1l6b0JpNlozTmhXNktOUW9jNVB2aE5QLzJ3QVY5L3pQZDhkS2dC?=
 =?utf-8?B?WEY0bzNpM1AyMEZCMm5iVVQvWHk2WW1jeHJUOGgzc0swQjhsaWRodVpHcTZw?=
 =?utf-8?B?QnhyNWhCYjJ2Z3I4aWRab3E5bkFuWGtmQklNZXNXM1dSYWl6V1YyYUR4eDNt?=
 =?utf-8?B?bmcxUVdBbFFXR3BkNWRsQmNteHBkQXBIMUxiUnNTMlpnOFVwSGsyZEpXb0dT?=
 =?utf-8?B?Y1QrZFFsT0UvN3pqd0pkWjViNDNPbUd2UnF4RzBqSGZTOGdPMWo4T3JXK0Qv?=
 =?utf-8?B?amtrSzFwNkppb1JrMDBtOTZtWjZzSVFMMDNNSHBpZkwzQTRHYTIzSm13d3kw?=
 =?utf-8?B?cjJ6enRaZ2lGWmZhbngwR1F6aGpaeVdWR0VjWG1TTnNrUlpPNkRyMkQ3ZHBq?=
 =?utf-8?B?aFo0ajZRbXk4WUtQdHBRSEVqbCtTcWF1TkkxUkU5ZGJSRnZ2NnUvNWd0elBX?=
 =?utf-8?B?REZ1VCtRMFNxbGtGNjRLcWViZnNwK0w0WGl3SHQ3bGIwN3Q4amNzYmpOYnF1?=
 =?utf-8?B?Y2E1YmRKNzhwV3RRU2hNOWx1cmNKbDVQdDdhcGNaQXZOaFkrSmhFM2NWeHBQ?=
 =?utf-8?B?YVpWM21MdFJLYUlwM0Nmd0o4SStTRThXYXBmMjJXdnFoNlhkM0dzNXdYbDIz?=
 =?utf-8?B?QnFiY0lldTc1U0VCYzNxVDA1WE80OXduTTVXRUhUQUxiN1BiU0VHQjJGNVli?=
 =?utf-8?B?UmtVUlN2WHZia3JTS2R2RE9MMHZiNlZvSktLZGRMZzQwTXNHbVRKVDh3TXQ3?=
 =?utf-8?B?dEdBRmk5SE9PVkJ0RFFJQXhXTEFUR1JhMk56ZU9laXUzdzFCZkpEMWtxWm1E?=
 =?utf-8?B?YmkxSFM5MTZpTEFSZ3dLTWRLWWRjdEc4UFUvSWJVK2RDZVVuVHBoKzhHeDVI?=
 =?utf-8?B?RDkzanEwWW1UaWpLdEhoZUM0VXZaVllIYnVaM0xncEdvRzZZZGxHbE0yVWEx?=
 =?utf-8?B?MzdBNDFLSnZtdmVtb1dhOUk4b3RISmZWOUdhdzRmMmpyb1k3SUh2TnVjdWhL?=
 =?utf-8?B?U1UrWTMxMi9Ldm1pM1VSSGRSMC9QZGlKR2JNdThLTGdFVVplNXBtWEszajhK?=
 =?utf-8?B?c0M0SjFsdFBsOEZDQ0srVE9Kdm4ySHV0NHlOYnZFUVQ4ZGY0RkFSK2N2UXZV?=
 =?utf-8?B?NEprYUxJeHZJVHYvOUxMdlhUcVNyMVpib2l0d0wxSC9lYmowNkVsTURjNnNR?=
 =?utf-8?B?TkNNQ0M1MjdqZmhKZWkzSVBtNU1WMVhCOG1ZY2toRFZLOTViNUZpTmdJdVlZ?=
 =?utf-8?B?ZnFOSEQrTFhGcEJMUExBVTA4KzQxNnJoRTdMMGN3WDB4eTEyaGtzdGV0QzZt?=
 =?utf-8?B?emVXb3pVZ0VQREJvVURXb1g0K0E2T2d4K09uK3dvdXBLMERaT0RQYmdnL1Vx?=
 =?utf-8?B?ZS9nKzQ4YlF5Sit1TjU3SWVXMWx1Q1J6QVZLMkNkT0dnTndNVTlmNTMxMHNJ?=
 =?utf-8?B?SnlQVmRuWkVrYXZqOWNkY2gvaTZha0pidExUNHJrWmlmT3NCd0MxSTN0bVls?=
 =?utf-8?B?eXlpV3JpdGZBZUdZdUlSVXBFRm1RTFJKaHY3MzlkRWJ4dVlLckFKL1FBT3Qw?=
 =?utf-8?B?ekZGRTQxdkpBOHpHK0N6RnB4TElma3E1aHgxbDI4aTR5NXNrclBUQm1wSW9q?=
 =?utf-8?B?UFRYQzQ4TUFNdWdzN2ZYNmlmQjkzNm1oV1FTa0JjYnZzaUUwUFBmNTd3S1Rp?=
 =?utf-8?B?UDlVS1RoZG1CSnVlbVRLc0FHZGpNYUZaaDI5ZjI3M0R6QkhGM01USTJkUkZO?=
 =?utf-8?B?c2JiSkNZU2JqVWQ0VUI4UTZZVDFOVGpQRko0SThxK054a1VlS0VJNFI5ekNt?=
 =?utf-8?Q?qPyg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb71b89e-c75b-4b54-f64f-08db40f9cc16
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 17:16:22.1510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wssjlkALKes5St2fW5shbXTR/CpGQEDnxXG1V2/gKzivb4zOg4HRGI0673zBn+Wi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8017
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
> 
> Is it for the ->fflags test in rdtgroup_add_files()? Can't you just do 
> some extra masking there for RFTYPE_DEBUG based on resctrl_debug which 
> you already keep?

Actually with this change, I can remove all these tricks here.
I don't have to change the check "if (rft->fflags && ((fflags &
rft->fflags) == rft->fflags)) {"

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1ec4359348c2..b560c44817bb 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1925,6 +1925,9 @@ static int rdtgroup_add_files(struct kernfs_node
*kn, unsigned long fflags)

        lockdep_assert_held(&rdtgroup_mutex);

+       if (resctrl_debug)
+               fflags |= RFTYPE_DEBUG;
+
        for (rft = rfts; rft < rfts + len; rft++) {
                if (rft->fflags && ((fflags & rft->fflags) == rft->fflags)) {
                        ret = rdtgroup_add_file(kn, rft);


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
