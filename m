Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7926C4F06
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjCVPJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjCVPJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:09:18 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996554D28B;
        Wed, 22 Mar 2023 08:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5xR1ZBjdPZ45hHYLpXUaHggqHD96TDIGChG/Sz4DTBhRSqF1r1KilhUqy963iBeCWpXTr6Xm7QBx8l3jm0nXsBbL/VeIMPuSJji+iX4LOBPKO9UUmairLDYbtIp42sZBjUdAhBNfV1X4JoHMYDe9rPWQAbe4BDUy7MU0TzKNZ6TQoKB8mkOm3wmQ1B8FpQMmAiR87cNPAq/OXmIIwyo4If+DrqAlPzzg4qBeZSDiJdYIt74pHUtgC+GpqBC7G2gMJ759Vsu6oaHeP3gHks84be4zKd832iqhiNahqSC4PAMFPGOImbd9cFZRXaBHv4Dch9zlJcxbIjS3nrFfiMcOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WlQbpQaDhJyeDBivBBgau+lDegKp+jKAMlBN4aRPZQ=;
 b=Y0bih2oU58Z+e1ewuCQGkumMa0LQMKIdBqkJfHbvlGDfxo9Ys7ibR/XJIb2rxuIWAqWoTvJwZ76Kb6kzI6bx8a8d7XlmQPHRPMtCvzHx/cskUCpJGakchWGUvBspMavmBqluypm0beZRTDBh7d/h/Y3Xtraa/Ja2cmQQ+l1low54k/BavSg3oqswiZv0R3K4PSi8JW4//3uz945hrsZr4PQ7TOFCyk9QR43saHVWV+St13VesjjfEIsGTc558B24om3bRGE355YErOU8bz/kfn9bPiF9Hoc3YBh4JeSkqTnrC66c2Be0HZI56b6WclweJZwLcGkabtSz9/9whW2yQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WlQbpQaDhJyeDBivBBgau+lDegKp+jKAMlBN4aRPZQ=;
 b=WZqIpe82vkOXMNJtXeHRPSZxPy3RNJfWalyKXH1HsfDHU1BF/580YgxeW3NSymtlKNahOymcdOmrCsSk/apEIa28He1c8IKQGZ4k3uDd/ZqtW+WUoFO0FyToQjm+TuyZUESbugZn0ffsfrwB/lZbe8YAdX0LlNn0yVhPqOJa4AI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB7592.namprd12.prod.outlook.com (2603:10b6:208:428::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 15:09:15 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6%8]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 15:09:15 +0000
Message-ID: <ac5f5bf8-0fa9-3e93-80ec-bba20a615bfe@amd.com>
Date:   Wed, 22 Mar 2023 10:09:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 7/7] x86/resctrl: Add debug files when mounted with
 debug option
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
 <167778870823.1053859.9940104139782066465.stgit@bmoger-ubuntu>
 <fef12c9e-7d6f-bcd4-f92e-e776eb9e673b@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <fef12c9e-7d6f-bcd4-f92e-e776eb9e673b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:208:c0::16) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: ad670a59-9f3d-4655-72ed-08db2ae7667c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pI4i2jAVEXTIdwkZdYQuzsDuHmjUHDAkD+z5g4ndUphV0P9/k+vLJH4d/WBZEyPWBJi7A4GgBXPck/x8lQaKHNZEGupOArmqajOc94etn1J08O7RPxM+WPCGcvrR9/JHYtpdIblxn0Kf4HEmNi8hv8et4h/cwkgmdZAkqvNfIyBolD2sLK2HMBmG7xFn3SmvpsQXnyXoNiXYY3Z8QOUsWeB9G3fmL91HdtEGDiZw9u8rHTFQry+73E3dEUxs8qItofle4RJOogHlb34hRm92XKBnMuYwaS+wbo7f3Oeof4XnZewY7MNZKJv3oWbmlNEjJIWo2wnq3YbryPdTiCsZnZ+GJb9+vEpDu4uEm/HIFcjlL9Jwbc5ML07sbBdrQpm93D1m1+5X8GrXjkvJ4F2j8O7xdbS41ILEehFA2U9IDdyYYEKx8dOj/TdRBNhGv3KhIDttk7MUTZzKbLhB5/2t7NsGQXB9/aTBOd49c6n/QsuK/f6uzR+seNc6xZJDP4I1gyfrFvVBkSooFxctNO7JM3KTLVer+Cc7McvAYWomtHEhXIaEoywjCKpHlXE8R1Qk/9s+lSfo917KtkiePmT0PNrTvZOp1s275MKurbE14PWFHkmoW5P0KFAf+Jt2pdokM7IzjUJfOnjSBto0/5YYkO2tta1QtjB0SgAMV9ohhQrJxNjGt71/3OQvPgOvySp3vG+Qju1f4spZL/xgjn1CTjLZdjbB+58/azFIygZEl1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199018)(86362001)(31696002)(6506007)(38100700002)(4326008)(66556008)(36756003)(6512007)(5660300002)(7416002)(7406005)(8936002)(66476007)(66946007)(3450700001)(2906002)(41300700001)(26005)(186003)(2616005)(6486002)(53546011)(478600001)(316002)(6666004)(83380400001)(31686004)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0dKWUNiZzJLcmN1RGRTMDlJRXM2cUs3T2dsajBsc3A2L3RndzJmSms5enlH?=
 =?utf-8?B?c3dIV1hTZEZwTjdIVHBJeGdKWVlvb240YUF1djU0N0xXckZhZGVpSUkxYzg2?=
 =?utf-8?B?d1lTVFFnNlJLVDh5cm5WZ1dacFFycXRtN0JURVNDZGlHZHVzcitxQVk4NDI0?=
 =?utf-8?B?T0lhSmNMd3pvaXhZSmlrK09mNkJ1OTBrdDhLQml6TjhCcGVteTRJV0E4bUxW?=
 =?utf-8?B?eW1CTW05ZGJscW1UTmxiYjF1S096cTMwblk0aW1JbkpITEhwUG9TanRKLzd1?=
 =?utf-8?B?c3lDRDRlb0pucUJHUktST3pXM1R2Y013OUo3RTRsOExNbkp2SHJHbEdyZWVz?=
 =?utf-8?B?bkozZU1oc1FueXBGNTVzSGx6WklHWXBGb1VtRkRHeDY1MDRkZjBsQXhtOUNN?=
 =?utf-8?B?UUdZYVV3UDJMa3RmQ2krbTNpUVhuTEcxR0pJNGhhVTFEVjVzbFRrNXNWQWRn?=
 =?utf-8?B?eEF2a0Y4cmFSZXlnMnpjK1hKb2Jkd3NxY3NubnowWVE0R2g3S04rYnNZaW5l?=
 =?utf-8?B?T0twTTFQb0Rva2x0SnkrQVowR3dLRUwvWlc5UktMdXZqUS9tcVhpWjlFS3RC?=
 =?utf-8?B?VEduZmZLMytwTEJHc1VUMXBWRmc5S0p4VnhFKzZGcGpSRnZSOUUxMUtIYzdj?=
 =?utf-8?B?dlJ6d29Xd3dwbU9uYk1VV3ZRZmdoWUNjU3QxcC9Ma1ZCMjRENHVHRTF1M1Jr?=
 =?utf-8?B?MWV6aTVMNUlTOWpKSmpPdytySkZWMnZwa1d2aFViNnlWcDUvbWE2dlRlSWxG?=
 =?utf-8?B?TjEyeTZsc3dhRkhWaU5RY1RXMEFvRXFwczBUcVlXbDBQWHJwbWFTdjNhWjY4?=
 =?utf-8?B?bk11SjJOQlVOTm52ZGlnQzNJNm00dnRwVkc3Yk1ub1B1dTFiNklJS1lJaVZt?=
 =?utf-8?B?eDFCMkZyaDQ5bjVnWW1nVmNDV2tTZTBDYkF1d0d6SGFjVERzd1NLZFdrbGxW?=
 =?utf-8?B?Z0o0U1ZZcllBUEZENnFJZnRsaGpQeVViN0V5U2hWcGFaU1pCVzJKSWpsT0lG?=
 =?utf-8?B?WXZPV05MdXY5UktmQTJIQnNCRWkxYlFDenVENWRhYzBsbVdEWEt2THFvMkJY?=
 =?utf-8?B?MEtndUtzQ2NZbk1nNE5FenBNY1M2cnQxeUNqTkErVGFjbW1idjNHS1ViWkZV?=
 =?utf-8?B?MzJCQ25FOHhkZUlSZGZ2bHVHbEgveTVTQ1B5eDJ3bm9KanZ6d3NzVkwxN3hR?=
 =?utf-8?B?V1ZleTNod2MvelByMjY1QThpTmNENVdFYy9VTjhuRU5reXdvVUhTMHZKTHRD?=
 =?utf-8?B?OHlZcWxDR2RIem4xRjRCTHdwK0s2VWpkckR2RDhFS1F2NFZySTd1aG0rRHlP?=
 =?utf-8?B?MnAwTXIrTVZhUEZURGVobi9telZ6eWJFTE5GQytPNUR5a1ZlOXJUVHJUMGxM?=
 =?utf-8?B?UWdCM3hsbHB3allydnJ6VUJlYS9aT2IxSytXRkhtR3RxT0JjMWNjMDM2dHZx?=
 =?utf-8?B?ek9PS3ZpMk9ROHpLck9NWUxRS3VNRkIyL01WaTNHMHZZUkRoUzlIbEFsdEQ3?=
 =?utf-8?B?RG1PMWtBSHBnd09iS0dTYS83bTlGbHFuQ3pocmVSekZXR2cwZXNxS0gveDJR?=
 =?utf-8?B?YUNuQU0yOUd0djIwRkZKRkRYemgwNUZwOEpFb0E3OUR3V1FZSkd0NUZUSTZq?=
 =?utf-8?B?UHBzdGZtcEtOTTBhL2J6VE95enJGdTJiYlduQy9qNGZiY0N4M09OSGRYaEpU?=
 =?utf-8?B?SW9YSm55NXdONTZ4N0hLblh3S0FnL29qY21SSmlDc1pBWGR4RFY2T2UzQXR4?=
 =?utf-8?B?b2llU0o0QnErV2xzdG5sOEJuR1pKYnozYjF3eWMzSXYyMVJSYmdwUlBqbWlK?=
 =?utf-8?B?RW16YWxHd2V5cmtoUDNNRzdZT2ZnSzlsVVROM3VTc0ltUVBOZkR3WjFSa2l3?=
 =?utf-8?B?SkVCendGTzgzVUtwYk8wS2hLay9hUWEyVjR4YnhyRXZ1akJKaktFTm9ic1ky?=
 =?utf-8?B?VnhvZmV1emVNQjhwcDRPejdxYzdiT0dVRWdBeTlwV0JDZm5KdXU0NmZyN21Z?=
 =?utf-8?B?cVZhL3VSbXB2OURwK1RsVWZxbnZLUG04YXRMRjZERkhxZnZLLzN5aUE2QlY2?=
 =?utf-8?B?dHc5SnRaQVN2NVFzMlYxdkNXWldKUjJ1eU03WUxqTTVCWWNPemlBbThQMUE4?=
 =?utf-8?Q?YAtA7TT/qiF/hdsIr3teL6CNX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad670a59-9f3d-4655-72ed-08db2ae7667c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 15:09:15.1894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXAZ3eoGJNOPF2D/deyFur7CLdAagbGY5aqkL9VwJWBL7328eVD2TF//ZRV43LG/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7592
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/23 13:45, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/2/2023 12:25 PM, Babu Moger wrote:
>> Add the debug files to the resctrl hierarchy.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   48 +++++++++++++++++++++++++++++++-
>>  1 file changed, 47 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index a1f13715a65c..790c6b9f9031 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2400,6 +2400,45 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
>>  			     struct rdtgroup *prgrp,
>>  			     struct kernfs_node **mon_data_kn);
>>  
>> +void resctrl_add_debug_file(struct kernfs_node *parent_kn, const char *config,
>> +			    unsigned long fflags)
>> +{
>> +	struct rftype *rft;
>> +
>> +	rft = rdtgroup_get_rftype_by_name(config);
>> +	if (rft) {
>> +		rft->fflags |= fflags;
>> +		rdtgroup_add_file(parent_kn, rft);
>> +	}
>> +}
>> +
>> +static void resctrl_add_debug_files(void)
>> +{
>> +	resctrl_add_debug_file(rdtgroup_default.kn, "rmid", RFTYPE_BASE);
>> +	resctrl_add_debug_file(rdtgroup_default.kn, "closid", RFTYPE_BASE_CTRL);
>> +	kernfs_activate(rdtgroup_default.kn);
>> +}
>> +
> 
> I think that separating this from all the other resctrl file creation
> can be a source of confusion and bugs. Why not add the debug files
> at the same time as all the other files belonging to a resource group?
> 
> How about introducing new flags, perhaps RFTYPE_MON_DEBUG and
> RFTYPE_CTRL_DEBUG. When the debug option is enabled (when resctrl_debug
> is true) then the appropriate flag can be OR'd with the other flags
> before rdtgroup_add_files() is called.

Yes. I could try that.
> 
> It sounds to me if there are plans to add more of these files. A function
> like resctrl_add_debug_files() requires a lot of changes and care (and thus
> potential for errors) every time a new debug file is added.
> 
> On another note ... what are the plans with this debug area? At some
> point it may be better to expand resctrl debugfs.

Hmm.. I have not thought about that.

-- 
Thanks
Babu Moger
