Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265F761FDE4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbiKGSus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiKGSuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:50:46 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7EC20BD3;
        Mon,  7 Nov 2022 10:50:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpgwSWbgT3MPlYx9Y9VZUH7kQocfzbwpfCRAcz3AF7t7M5vwKd6qkwmZPfkDabTrA1PNoVyQsg+b0WFdgcO5jGCP2/GbRGcdSvAqR6ZaEBcH1OEYILGkF7Rvhb/2gvNtc5D22wSHsSOGdeNhcR6SaVMEwFX6PyTNtPRJhIB0Zeet0tfyokcU9FhbP3uq02uGO+aJ0oV8zjJnbsr4faToie2Iiilx14vNZFskcn+IP8+Ey9WH0geSYfawMRHw53bVxyAEv4Kh7w6cDJBMH9po9HxxQKDfMidPU1e9DFgtfV4j9Pg3RmaI1ErGC8tyEJN1s6+cD95Dfgsu75PUeBC1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FT+2Vw0HsCkSMAnhMj0YH0j7gYgDe8CbhVEV54Zd7k0=;
 b=m4ZTtauxa7gTMMLNE26aPitKSLTbzoXDDdmpwhdNVhipXttuqPfS8rwUIGTfxiOlVPIMFwMgY8QdY5qy0b7KLUieM8Zdb5bTc7r/p+kMaORiMKv+3pZbmfSQJcl6odaGa7p/5DMFO0pn0NNbJeN6yuMDMJ0d8EAg06gRjl33Bu7EBv6VVLV0RrgTlJ1HMYkRKJLNOG7xkqFnVcctvQ/yHMXTJra0gV947qpULmUfoAy1g1TbwNdj4xkwLToBPDWFlpIRaNW/fYRxK0S0mcWKe/fPIirASSxDWEDQ9dAwTIqMnP9NcpUjnGhB16WRRAJXnjtpnkVL0OfMY1EdBttLWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FT+2Vw0HsCkSMAnhMj0YH0j7gYgDe8CbhVEV54Zd7k0=;
 b=dKhdA5kfMau26jHoUVzTFLuMfc0EdpL1SL3N2oRaPiGeNERVHSajjhfwo+mGZfyWgQC8cCMnKy0wku6KwXKyTmhFKeZMjDjSWqNxNlELBonVpJcM2P7iLJRZZXe7IrhiAUePgG7lVzBP4qdkIGb/UYauJH6zLJUd/g3hcTYoIXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4517.namprd12.prod.outlook.com (2603:10b6:208:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 18:50:42 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2d5:77ac:6d39:e57b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2d5:77ac:6d39:e57b%9]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 18:50:42 +0000
Message-ID: <1cc4ffae-3d36-b369-7cc9-b7130701b944@amd.com>
Date:   Mon, 7 Nov 2022 12:50:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 10/13] x86/resctrl: Add sysfs interface to write
 mbm_total_bytes_config
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>
Cc:     akpm@linux-foundation.org, bagasdotme@gmail.com, bp@alien8.de,
        chang.seok.bae@intel.com, corbet@lwn.net,
        damien.lemoal@opensource.wdc.com, daniel.sneddon@linux.intel.com,
        dave.hansen@linux.intel.com, eranian@google.com,
        fenghua.yu@intel.com, hpa@zytor.com, james.morse@arm.com,
        jmattson@google.com, jpoimboe@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, paulmck@kernel.org,
        pawan.kumar.gupta@linux.intel.com, pbonzini@redhat.com,
        peterz@infradead.org, quic_neeraju@quicinc.com,
        rdunlap@infradead.org, reinette.chatre@intel.com,
        sandipan.das@amd.com, songmuchun@bytedance.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org
References: <166759206900.3281208.11975514088019160962.stgit@bmoger-ubuntu>
 <20221107102134.255757-1-peternewman@google.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20221107102134.255757-1-peternewman@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0204.namprd13.prod.outlook.com
 (2603:10b6:208:2be::29) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4517:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bcc0839-f959-48d1-4fc8-08dac0f0f886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SE4Yd6T2o+UHfG+DfSfG1nyDnfES4rXDI4Gu0rvqQIZld/GPiRkA7J163B1C6Tdtl35bszQ4u/VM1q0KvfWWQfP1FMATV0oQAB4XSFkJ+PYARfhvNQcKgXBlugHKJyA5BQBAWEE2Hju5NNkgEBfkWtU+9gcyl1lf82GjeXvkRFl74h2CYvqghmmFIbbADULZxSXgQzoDFV4auaJzwsAbL1jtElz/0L5t9t7o2MwZ0DmjBr3oYZkmubFj7YixeKL9l7WG3j37QNunr68+0X6/kpyvlQfnC0hGNYPPCyDYmZ3k9EVgPE9ZPGwpeYywB4ZNDhO1fSl396NaiGTNugRDrh4KxoBCe4nU+BOvt3ZcyKP/G5ms2DkwbOvTEtQuBboeMDMqs3DwoH83Tr0HL6L8Or2GpKHGBEBEAfSlZ4VrjZG4X99rfZ92lwwDyzPgxxHfGdPnCAwH2MWwbVqSJG7dA9Jl9Otoj5UCNfuQf+rFhHK1kc9ZMoOrbOdAoC6+kQwTia1cpK/FJYYhIniyaEejWy3c2Adx/OIsxkDzvKHY3NxyTFBuYjyLO9JtuL9BknOo92od7DpUtPHVQumkAwT8MMwHfo+gczhpS0HnZoNvyr3aM6Jz6ftNBSxzBGus2HMGQwygFrBtOzl9z/A81exZ93hvEQvKK5vvingvEu+iqiZXOdyXPV8alkSf1oMdQYG9oCpk/XZiFJlwxiUCuq2V7iCxtYFbw7BVdJR2F28VfpImoYi4pbSYBQDfgtFqFFRZqLeIAQD8EeLmiI0/kfCRxEM7BXeSz6Cw1h5bMBxGCbx0gj2NTldDhSuELb3yID5T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199015)(6486002)(36756003)(6666004)(478600001)(3450700001)(2906002)(53546011)(45080400002)(966005)(31686004)(6506007)(26005)(6916009)(316002)(38100700002)(86362001)(31696002)(66476007)(66946007)(66556008)(4326008)(8676002)(186003)(5660300002)(8936002)(41300700001)(6512007)(2616005)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlBqQzJhUjR1RXN5SWd3VkFwZVA5QWE4WURkR0Z4Rko3bXAvZVM1U2VFbnZE?=
 =?utf-8?B?Y3hwNFZLTzY5bjhoSXJTbXJPckd4c3FweU50MjlUTnEzbzhxRWV0WG5JbVRh?=
 =?utf-8?B?ZWdxZG9EL0N4YXp4YmpqazhpZlNId2pxUzE3VXRZV2FRVkU1OEQ3WGRIaUt1?=
 =?utf-8?B?TWxhK1hPRzlZNDdXSTh5cUVDRytMcFRxYm1kT0FzdG5wRmo5am96bmwraXpm?=
 =?utf-8?B?cXFaY3UxeUxRV24rY2ZJOXVrMkdHSjgyUkFZbDlPM0plaGx1UkVBRHp2YjBH?=
 =?utf-8?B?eVowRWxkWmJ6U0JIaUtiL3J5NUNGT1ZZdlgyN2I5RmFBMGlFNVpPOENLbEd3?=
 =?utf-8?B?SUZZdzdJcXEvcXk3Zk85bUJ5aG40UDg2aURDMjA2bXdHRTZndnNHMTRiWGM4?=
 =?utf-8?B?RHZUWVA3Y2wzeTNCU0kvRVQ1VVNxdDgzc0JkMDdNajUzSjJyRjgxVURSS3Va?=
 =?utf-8?B?MUJMZTZzdHl6QXNOdmhkeURQdnptRm80ZW5QaGRycGtTc0cxYlRsei93WWIv?=
 =?utf-8?B?anpiL0FUME5aa0xTd3R4SERXbnAzWnI2RnZwQkxQZ3I0NkFzbzBzUlBRYnFh?=
 =?utf-8?B?MllTVEIySEp6V3duMHZpRDF5Wm1qS1dmS0Jsc1dPVTlOREFWeWJXeXpCTysz?=
 =?utf-8?B?d3B2YnR2ZC96V0lvWENCdStxdEh3SERqT3J5RGEyWUN0NGdrOTJMU1gvSDhO?=
 =?utf-8?B?aHdtWWNmVk5sKzhSNE5LRFphOWpiQ1hEb3UyeE56REpjZlorZW8wa3hMQU1y?=
 =?utf-8?B?aTdxczRwRlNXMFZFVk01WFM3MjhUUnpEUlk2MHhjcTIrVTc3dlVzUUNWdzEr?=
 =?utf-8?B?eFg5N2xIOVhONk1aK1JUTWRwcWZPaHVSb1ByUW1uZzZGeWJsWTVDQ1ZRM1hG?=
 =?utf-8?B?K2h6RFBhNEFBM1IrL0wybkVuQU5Rd2dHTTF0dGErUUg2eGNrdGhvbHE5M1Q0?=
 =?utf-8?B?TzJ4bTU5aUxXYWZJSkpJVzRnTTFGSmpVMFUzYU11T2EweWtVSmpFMnNZTDk5?=
 =?utf-8?B?cGwvRmFqVVgwZGsveFZ0R1NRQmgxWjcwZlZkbitCM2ljTmwzeEMrMnZwVGFH?=
 =?utf-8?B?UnE5bFpCVTdhbE12MFBhUGdocWQzTWEvSmxVenBwRjFaWnFFZDhaQ0FLNVht?=
 =?utf-8?B?cVVVYmxRWS9JVFRXcHU5am42TDV1TE9EUytIZ1F6ajNMNWVEWWhYUmEyNDlY?=
 =?utf-8?B?bjVvZEdXM0YxUTlLMHVJVFA5VHdLNVROeWZUSk4zU21rYUtpL3dlb0UySGRW?=
 =?utf-8?B?RWR1ZmhCYjZsNFd1SEM5NWVCVlIwaTZPUE5xWTlkYmw1SW93S0Y0T2k0MG5S?=
 =?utf-8?B?RFlUZnlMNEhsSHhjK2hwZWY5Q3J1YzBBcjA5SUZ3VlE2WDNCRGo4M0t0THEr?=
 =?utf-8?B?T0krc2tpQ0d0bnA5TVlaWHYxQUtYWi9XTHIzbDFOL3J2dk9GZWhEeVFra2h0?=
 =?utf-8?B?QnVUdGtmK0JZbFFSWGsxTzMvMEpmZEdMd2F3b0dzeEcyQm4xdGpydzhKYWN4?=
 =?utf-8?B?SSswME1JQmVhejdOZXNjS1ZBUHNpU2dGSlBOaEM0VzUvUk0xM0ozeHZHWmxq?=
 =?utf-8?B?TWEzVHg4Q1VzREt0WW5GMzlDME1YTGs1ZlFSdHRqWXJQS0VOMzVoVUg1Nkpx?=
 =?utf-8?B?WUhPTFJYdjg3VzFOVFBsYnlDRnBOb3VINDd2eXo2VWV3Y2l0cVhyMGNXenUx?=
 =?utf-8?B?NUxNREIvem4zK0tnUlM3c01RaEpFdkN1cFFwYnlqVmtZbjNWTU1xMWgrRnpr?=
 =?utf-8?B?alYrcG5Qd1VvMEFsdnp1TTNKa2M1OTkxdWNOVERJYkh5YjY0aGdYVEkxdnVy?=
 =?utf-8?B?S0kwaUw2MmFGL3BVSXdadGVhRTZ5S2htTTFhNFQzZHZ6WnhML3JnalBXOHZw?=
 =?utf-8?B?Wmd1eTBGSTJ2Tjc2QnNpSDBTblZXVkNJSkEwVXlrS3lOZGJhN1hScnp3bEc1?=
 =?utf-8?B?K2F1K3RSbkxEN2tDaVpDUEFxaGdnK1l0c0prTk1iMElmUUN6OEZHZ2xNQmpz?=
 =?utf-8?B?RzZPSjBUWDJyUUhMRTRGZHcwNHBwMXRRaG5xOTlWY1ZFRWpjbDg4Y3hnZlE1?=
 =?utf-8?B?Tjh6Zm8zN2lOV0dYYkZWeEc2dXFHMktsemJKNG1rMS9uK3pPSEp6SUUwbzNE?=
 =?utf-8?Q?8dN0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bcc0839-f959-48d1-4fc8-08dac0f0f886
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 18:50:42.3394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/kAvOlXtB6651EbcPSZhqg8+vNXeMqSebTHdLFNSIF3BnNzWlV8r2avX1IxpHXG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 11/7/22 04:21, Peter Newman wrote:
> Hi Babu,
>
> On Fri, Nov 04, 2022 at 03:01:09PM -0500, Babu Moger wrote:
>> +	/*
>> +	 * When an Event Configuration is changed, the bandwidth counters
>> +	 * for all RMIDs and Events will be cleared by the hardware. The
>> +	 * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for
>> +	 * every RMID on the next read to any event for every RMID.
>> +	 * Subsequent reads will have MSR_IA32_QM_CTR.Unavailable (bit 62)
>> +	 * cleared while it is tracked by the hardware. Clear the
>> +	 * mbm_local and mbm_total counts for all the RMIDs.
>> +	 */
>> +	memset(d->mbm_local, 0, sizeof(struct mbm_state) * r->num_rmid);
>> +	memset(d->mbm_total, 0, sizeof(struct mbm_state) * r->num_rmid);
> Looking around, I can't find a reader for mbm_total anymore. It looks
> like the last place it was used went away in James's recent change:
>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20220902154829.30399-19-james.morse%40arm.com&amp;data=05%7C01%7Cbabu.moger%40amd.com%7C84a9d0f934894a3031a608dac0a9db33%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638034133003350939%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=i3isjCzxnBp4b2VblC7ZpH3hShUEe7unKiKfngG1kzE%3D&amp;reserved=0
>
> Are we supposed to be clearing arch_mbm_total now?

Yes. You are right. We should be using resctrl_arch_reset_rmid to reset
the rmids here.

This patch should work. Will fix it in next revision after the other comments.

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
b/arch/x86/kernel/cpu/resctrl/rdtgroup.c             │
index 6b222f8e58ae..28d9d99a639e
100644                                                                  │
---
a/arch/x86/kernel/cpu/resctrl/rdtgroup.c                                                            
│
+++
b/arch/x86/kernel/cpu/resctrl/rdtgroup.c                                                            
│
@@ -1517,7 +1517,7 @@ static int mbm_config_write(struct rdt_resource *r,
struct rdt_domain *d,          │
                            u32 evtid, u32
val)                                                          │
 {                                                                                                      
│
        struct mon_config_info mon_info =
{0};                                                           │
-       int ret =
0;                                                                                    
│
+       int ret = 0,
i;                                                                                 
│
                                                                                                        
│
       
rdt_last_cmd_clear();                                                                           
│
                                                                                                        
│
@@ -1557,8 +1557,10 @@ static int mbm_config_write(struct rdt_resource *r,
struct rdt_domain *d,         │
         * cleared while it is tracked by the hardware. Clear
the                                        │
         * mbm_local and mbm_total counts for all the
RMIDs.                                             │
        
*/                                                                                             
│
-       memset(d->mbm_local, 0, sizeof(struct mbm_state) *
r->num_rmid);                                 │
-       memset(d->mbm_total, 0, sizeof(struct mbm_state) *
r->num_rmid);                                 │
+       for (i = 0; i < r->num_rmid; i++)
{                                                              │
+               resctrl_arch_reset_rmid(r, d, i,
QOS_L3_MBM_TOTAL_EVENT_ID);                             │
+               resctrl_arch_reset_rmid(r, d, i,
QOS_L3_MBM_LOCAL_EVENT_ID);                             │
+      
}                                                                                               
│
                                                                                                        
│
 write_exit:                                                                                            
│
        return ret;                                   


Thanks

Babu

