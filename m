Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF3561FE1B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiKGTAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiKGTAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:00:22 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C785825C46;
        Mon,  7 Nov 2022 11:00:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBWJ4C5QAAvSOxAji9OgTggR/H0H1ZHr1aQgmUsyg9pW7ZCtuHsnAwse2GK1625mklM9E7MpkRj1bCFpv6CN1fF5QHvX4HkCmQ0eAestCZ+WxudKYfE3c32TmBG8G9PpDTh0DP0I/rT3/Xme/58O5Fwl4kHAKL2UWqA4GCEjBIDShkYEY5w7qIFKLdaq2yqpTzJHNMcbDywhxedXpY5QMaBdw9LO+C5vGo4CcDZMM4HiSWNwZ3WbSODWSoELCnJzYeExFfdnF4xf36RLd+iaONt+5pCFdQs+El/GtZVzn+QWDOYfk7Bx7tlK74IZpJdv4kYf12JG+f5UOXk3elmOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMv7k3jQQ8nGI/r4Bm/hAdIpwX5sM9Aw0KSpeuhTBT4=;
 b=hTzOMdp5HHFWRGk+E0a39r6ZPBongXUx1lR47t4kBXERBhUwVZD0W0qdzFbCAQHIj3JOlGtpcMWA4xIyZL2nXW3WjbU79wtHpbGoyZKVG/9rTTErpXklDhz8Fg9BCRN4BYXPd4zeODIqoLE7O0b9EhKzQjsbkBIzljAb2HuLY9V0XAh+Q/lv+tS3tdneB47Oqh66/u+yYAMiF2rtZA0bsys0SfpGx2/+vAw06KuyTPU3LqPBW4fsSLLvNUDOGDNtuQqpAPhsP5w/YBJ7/JJ6UJmaxKo9Gkxzupr1l2lVUudpaNKHcB0R6a0xqfLtVz0QgR/xrckqKqvjHpbWcJFV7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMv7k3jQQ8nGI/r4Bm/hAdIpwX5sM9Aw0KSpeuhTBT4=;
 b=yycfs5YN7os5MFAWY4DBWAak90N5XOB6tfxRW9B2zWlsCaJGQbxfWiyHU1DljRNorbPi69lScTHn92YoEKius/e0sAwJHQNnpLBJNiFgOvPB6gcYKygdwiJoAGsOGrMSqpTy7GzEkmijHFiqUBCQpPDBzvS6NvofKlIs3sn1fy4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH0PR12MB5300.namprd12.prod.outlook.com (2603:10b6:610:d7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 19:00:17 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2d5:77ac:6d39:e57b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2d5:77ac:6d39:e57b%9]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 19:00:17 +0000
Message-ID: <cccacde9-7d0b-f0c8-2e3d-2b09c910b8c5@amd.com>
Date:   Mon, 7 Nov 2022 13:00:11 -0600
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
X-ClientProxiedBy: CH0P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH0PR12MB5300:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a231ecd-bc29-4c81-6cef-08dac0f24f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AReFN3sQ/NuV2Wv4/fI6TxVaPSGCNvnIEgoaJiJz8JDoRlmTle7G/fU46Dk5jYCQX1EDapJHH0oxwR13kHz/rCGetndglcyxs61nIXWb3cpPPVbV/jKXlIs9esq0kzo+yI8kPTlOBhM9TBbcNKya5fkFvLeFOoVQdYlMXckldoX+5hF4lJiNatanN/wBHry2m0RxOJk8mB91sdoFoQcR/z27plv2yh9vaL/At/0oK0syaKDG7loWVMrJ0vl2UOGIgcUuaPHR+lP/Q2w3Rq81XuVaIWNL8FOXUgiQrft3s8pcD13rlY2j10u+F+uTql3IbzQRXBw2iJtThXaJLhWccVxwhlQVT0YnGS66s8oyGUUeD1TizwXCiaq/09jeHW50nui96Yeoi3Ne5t++EvrQyGSJDIJhKqV312U9GyBEXzUhc2tboRMOVztcJpfxQaOVGhLwHfzwxE9fixaiktIB0AOQUdFEQ1DQoXFc0iLwU7DAWqEid0H2GQoi8+o8iFJ+SNHyZoTGFbVpp6QckQrPrMXCpfY13r7r1syAIlNlHoYVphhieXdh4zMwWb2Xlffa38SomKWb1YAnkz2d/L5/B1ad/+hI9Jk174+N+3BirhkLmOh30W+3vvk47GzAEby4UpzZ1zsamDbFwcvGG5CGLcwciBKDfoqom77HIIuUIC7Y/KDiBo83q1WxUJNwaSXyC+VjaqWTildUlau6o8iCDbxFj+Y3h4MmpERFdI0C49+a8w4IdJG7QBl4Bvqom1f+dJrkEc02lCkwCqgLKdnvxvcGOCQxt1Vz+KauxZF6SIi9DSfN5e38/LJLMMIxBXqmEPUltYXkcHuqoK7tMK2uAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199015)(36756003)(31686004)(38100700002)(86362001)(6486002)(478600001)(966005)(41300700001)(31696002)(6666004)(6512007)(26005)(186003)(3450700001)(6506007)(7416002)(66476007)(66946007)(53546011)(4326008)(8936002)(5660300002)(8676002)(316002)(6916009)(2906002)(2616005)(66556008)(45080400002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVZpMWpFVVVMNURtN0tsdFJ4alp5YURVQU9nWTNqTGtDMDdrY2JuaC8zUms5?=
 =?utf-8?B?dmw0aXRNSUZXN2JsdGNkUVBVbllDdmZFa0d1N3NVSjVGdmRJQVBITnJ2bUJn?=
 =?utf-8?B?cFJEQ3J4dlJrS05wZXl1WlRvVVVaWi9sbkMxK3hhWHpwanJnTTZuMTZNSHAy?=
 =?utf-8?B?bnZPUWI3cGpmTUhXcWFldzdwc1VpSFYwL0JqdkZQN2JwOURBcTNpNyt1Vmlz?=
 =?utf-8?B?c29YQ295QllBY2ZOMjJhc1FDMTJKKzRwMi95a284TXd0Z1NtT1EyN2tSOWt4?=
 =?utf-8?B?UmcrdnpPNktGUkVlVTJsWmRDUjBodGtnK1N2Q3hhVmgzWXpEZjRrU3dqVzZK?=
 =?utf-8?B?NW5KQW1TQW1EUFlvNlZMZnJOSW0xeHd1b09yRTY3RkF6QVJBN1lWb2UzNTFh?=
 =?utf-8?B?QStqOGNSY25LazlXbmpQMDlob05seW9rTGhyK1JTR3JJTnVPSEVreXlYQ3hq?=
 =?utf-8?B?dEFCNXh1T1EyaGtHVEpXNmJKUEJucXdiWWl5YTg4MjNyVDhlTE5taVdoTXgy?=
 =?utf-8?B?UlErS3hSSFVTaXVNSTNDTFVzYnNMK1B4M2F4T0g0RCtOdHo1MWZqbzN2c1c0?=
 =?utf-8?B?clJqK0VHRlBBakV4L3BTejE4bE96MlJvdnhpckRyKytsTVMzWGovaFNMS1Zy?=
 =?utf-8?B?UVA5YStBMVBRanlZR3oreGVZWHZjbHBzU0ppbitVcHNPcEVEWTVlekt5K0oz?=
 =?utf-8?B?SEt5MTRzRElESXZjRmI1SlowenFnTGppTlRTOWV4ZjFWYjk5Mk9YYSt3NWdr?=
 =?utf-8?B?a3pFcHArN2lxVlNtQ3A4cEdnZFc4eXpsMkM3bGlsWG0vME9aZ1owc0U3dE93?=
 =?utf-8?B?d3U0WXE4aHRRQjcwS011YkhVbzdDS3lCZmc3enpSLzlyeC9TaHlFZFR2V2Uv?=
 =?utf-8?B?dGticUY0eGRoSWR2V2cyV05vYWdaZGk3M2JycDd3VjBxbnpYdUoreERKTGtm?=
 =?utf-8?B?Wi9nbUJ1eUF5OGpqaVRDSDBieDROb2hiRFdiQjdHcUxYYU44NnpEQ3QwOVh3?=
 =?utf-8?B?aTdWR3JuUjcrUnp3Vko4dVBySCtUenI1MEhGKzlIajNrMHk1VUhxejV0TzNU?=
 =?utf-8?B?REZrcUltYWJiU2xPdThlQWZ0NmpMaVJOKytjV2V3MXFkN0paNkVjUDA1Umd0?=
 =?utf-8?B?a2k4R0I1R2lRVkhRZ2w0clE1OVh5VFAyOFMza0EwZTk0ZzlWYnI0UzlYc1Zq?=
 =?utf-8?B?ellPeTNITnErZnBIUGtIV09UME1zSmJwLzZaWkFvK0tTK1dMK1ZzMTNzMUh6?=
 =?utf-8?B?bkhEL1lXeDI2UDZLQmlHQWZNaHg0RzNRTnZHQmRkZUhhaHNHR3B3dGJJVmpK?=
 =?utf-8?B?STBMUmU0UEFCdmQ0eDAzeHc1MVg0bWhZSThPSGhWRWdvZVBqTEFhMmI5V25N?=
 =?utf-8?B?MmZJZXJCS1hYSUs3U1J2VXVWSTZMZ3JrWUh2cmh5cTRCZlkvQ0x0WW1SRE5o?=
 =?utf-8?B?Y3FnTkdlb2EwdGF4dFRVRytKaUNQQS85bnNsQ1R0TFFNczdnd0RLeVVyRjRM?=
 =?utf-8?B?bzE0bEpSaFh6enlDTER2Rnh4c3hhTTFoMDd2Wnk2N0I4eU1jWndnbHNYdE8x?=
 =?utf-8?B?TnhQanVUbTBVQ01EejJCcG9hMEFIVlZId21FTi9XcC9DRzhUTkRkK0dJSUo3?=
 =?utf-8?B?SHZIakh6Zm9YeHdzZFNhQWl4dFNoZ2N4dXh5cm9qUEZHckM2SU96VUMxRlZN?=
 =?utf-8?B?OGhOdk01dndKQUwvcHZlRFR6QjZoL3I5d2ovUDdUSmtoU0I3dzFBYkFJNEFQ?=
 =?utf-8?B?eUNxbzdJSGROVmxYQW5MWU9JazgzbitTczJGTERvekM1SWNsR3NvMWhzVEow?=
 =?utf-8?B?VXFwSEl0aXJrRXVYSHB4Wkp3cnNIYml0allrNUJHVmxtZVZsMXlSK245ajlv?=
 =?utf-8?B?WVBlcnZFcDF5OUFtTEUyZ1ZJZm9nbmM4ZWtKU05EdG1SVzNqblEzek1WRnhX?=
 =?utf-8?B?Uy80dlJZbURwdmZMUUxvUlVoTXB2aWhFbnhaOWxIVStQSFpibmFuc3dmWXNv?=
 =?utf-8?B?N2xJNytpalZhci9hb2Z0NzQ3TmNLWkdRbnk4a3pYUVVHN1ZhTmhwM0NURmVr?=
 =?utf-8?B?cXJYNnZEVXJCdS9kZmdKWjdCQS9JQUxTOVJ3ek5IM1dSUWE5N0wvVCs3dGlu?=
 =?utf-8?Q?2sSg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a231ecd-bc29-4c81-6cef-08dac0f24f2a
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 19:00:17.1332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pmLalpyNsnx54ZW/L5AVKfXeQTkRAPQkmjThpKbhpHUGl1ZLsQGmZ2q1/mTy+p5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5300
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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
>
Patch got garbled in previous response.

Here is it now.

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6b222f8e58ae..28d9d99a639e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1517,7 +1517,7 @@ static int mbm_config_write(struct rdt_resource *r,
struct rdt_domain *d,
                            u32 evtid, u32 val)
 {
        struct mon_config_info mon_info = {0};
-       int ret = 0;
+       int ret = 0, i;
 
        rdt_last_cmd_clear();
 
@@ -1557,8 +1557,10 @@ static int mbm_config_write(struct rdt_resource *r,
struct rdt_domain *d,
         * cleared while it is tracked by the hardware. Clear the
         * mbm_local and mbm_total counts for all the RMIDs.
         */
-       memset(d->mbm_local, 0, sizeof(struct mbm_state) * r->num_rmid);
-       memset(d->mbm_total, 0, sizeof(struct mbm_state) * r->num_rmid);
+       for (i = 0; i < r->num_rmid; i++) {
+               resctrl_arch_reset_rmid(r, d, i, QOS_L3_MBM_TOTAL_EVENT_ID);
+               resctrl_arch_reset_rmid(r, d, i, QOS_L3_MBM_LOCAL_EVENT_ID);
+       }
 
 write_exit:
        return ret;

Tthanks

Babu

