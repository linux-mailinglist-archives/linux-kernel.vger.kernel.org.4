Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FDD6E66CC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjDROL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjDROLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:11:54 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DFF13FBB;
        Tue, 18 Apr 2023 07:11:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wt4q0OPKcJ2NfCjvRPPoujR0MQq08+qra6duxbFaP2EFsNI0tLmDkdWnpuyu5COQrbNQ78JJWjZh8qQu7f3RRssrtGuxNcot4ev/FXcvUL+wTSuc6POPanN0cfFEfs7zRYeW2ybd7fj2O7vK+CVrawAtuD6kaRN5B2UKUs6C8PUUzuzTGGfbmjzGHfcW/SMDSIl2AuedSR1dxmR73eOPrAqMOmuQPdpad2gqo0wq/aWHuRfkvV7Pwuyb/3Qa1L0jWqwUfxgYNc2wbWVcXdG+gKWMnDxf0/mJmi/xQR5OgJ4CI+eUyBr9B8FTHrne+RJeTR4ug6JuO6KAMyldin19GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFIf0O77zqDG1iqGSXcWibPsKx2Du5AkvGmeHfffxB4=;
 b=e166X6+SzQZkYaUu3pkjuFedYtU7b7ATQwPJA88BKxkbmnupaNL/fW1BMEfqgncl7akteBrzbqznTtodtzBpvzz8hrU6XP2/NbYwd9yJC0GKvbfeVWAlk7p5uAwXIAF9u0GH/Veb8gSym9NP81rG62jsZGb+nypSTuoPLf3/K1V6719udnfAIO29p9JP4LvKxAbwPSCtl/tbNjlYiNhJu+5MCFwBVUuZqbaLA7DavxVrMAcfSTyJvDDnT5doI3XjS/EVhONliipOqjHZezRYqjVAda37fUA3ShUhs49JIPM2KF0qcKCFi9j069D2+mmstoDCoWsCkT3sbrsnRESEoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFIf0O77zqDG1iqGSXcWibPsKx2Du5AkvGmeHfffxB4=;
 b=mczjoPLZaoufq5TZa5xql3bCxvEPnV/zlaqnstYFimOLekV0ly2A2bZvyBXUmmkCpeYUvTkdu8wB5+U8NA6Lv1OP50hpTO+bbyQDmu6phmoHWnVe+GJoM8ZLeBHoG66IAvWp8HToQ5lJ7+AtnS2nvpJS5vni6tfVMja/fblsXa8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Tue, 18 Apr
 2023 14:11:46 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57ca:ec64:35da:a5b1]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57ca:ec64:35da:a5b1%7]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 14:11:46 +0000
Message-ID: <3fee06bb-a9a1-19db-b1da-70981b6f979c@amd.com>
Date:   Tue, 18 Apr 2023 09:11:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 6/7] x86/resctrl: Display CLOSID and RMID for the
 resctrl groups
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, corbet@lwn.net,
        reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <168177449635.1758847.13040588638888054027.stgit@bmoger-ubuntu>
 <a608d2f3-e498-8253-a58f-7be0e4d832d8@gmail.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <a608d2f3-e498-8253-a58f-7be0e4d832d8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:610:32::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dd6b819-4162-47e4-076a-08db4016d82e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vXR0/RLVJshoB5OGPTKYAmJZDxfEAEAKHy6ptfJymVKrg2ldz/Cht9Nyg07++NnQVKUOmvkCph6KStyLNGcVI32ekO3PrfXhMQI6DYsvYPT8YLynjBxxxA9FpPfdCfPsQu039YaijrEp0qCy/XvXgSDtAHqY6pp6Qe0BUfdPOpbyPyUL7c/0rQmGK8b2JX8/ra5yJUZbH6hzYUlhbi5QNJdZn27E/qtiPfBYcYGGZazzbD315LLnjOgO7H0/fiG23tAkF/DvLC/lXy7tHF6IKtEjtQ96+K9FsYibnLZ6DsSXPErI/51sV+BbA0Vmpx5CGdXtIHLqw/55ovvh1VQ7amp/3XBhXkannv7XKWfhy4+d1HQoDm7hwrXu3vGZsNoHgCzFdI3cFcKAwHuuL8lph+empNv6W6Pdw6KrnNWLcE4/xn8sS8N8e4FL2TI35ElTKKcGUaQ0vqmpYlZo21RCD4k44LvHmCZqpZpOh7oO2vtkPURA4EId5sM3WdvtQGR9uMUFi5/mO40eK/UYYN1q/Jq0N5zpm/tt9k3CWIxGKMZl6n4oGurNYfnH3awwdQ++DPQElo/JyEbEE5cFko7mg4In8yW5N7rmZgzWHhZaWp0oQjqcJCnEKNu5O3l1HWXTeGy14LTVZrY2pSWfndl3rQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199021)(6666004)(6486002)(478600001)(31696002)(86362001)(36756003)(2616005)(186003)(6506007)(6512007)(26005)(53546011)(38100700002)(316002)(4326008)(66476007)(66556008)(66946007)(2906002)(7406005)(7416002)(8676002)(8936002)(5660300002)(31686004)(41300700001)(3450700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjZKMGpZOXlvZmM4dEtxQzhqaktScHpSY3Exb2RXODQwQkNCa2h6ZytINTlU?=
 =?utf-8?B?L0hlU1liTHVISktKRHBpeDVmSHdJbGppeWpERXhqdFJvLzBiVW9sZlhOSWVs?=
 =?utf-8?B?aGFDaFhHUHlOMjZ2d3lkVUMyTXRwVC9qYUErWkwxTHpOU08vTXpNM1JwNTBO?=
 =?utf-8?B?ZGJFNmZENDA1YjVaYVBMUEhIbU1YOGZHVURvYnZ4QWViMFpFemppMUVpOG16?=
 =?utf-8?B?NGFaMmJSamZvTkZFbzUvRkxpNnh1cW0yQklLKzMyU2pTVEFPcytxZFN1elNJ?=
 =?utf-8?B?MVM5MHRNY0RGUlhQc2Q2R1ZNN0o1MlFDTmFVcGFXZjlnS3FSVldLcmwvN0pr?=
 =?utf-8?B?YVpHeFh6K1BSclI1dDkzSUdlWUFDTUJ6ZEJISDJQSzVKdzRMakE0cDEzNmdT?=
 =?utf-8?B?Z0xVZjhZVVJsYXJ6RTErWGFBQXBmaERDclI5d1ZLMEYxVmgxUVJ0TzlsbzlB?=
 =?utf-8?B?RnF3RGNybnZ6emNhQk93bDFoN1MrVWFrWmdMUFRlWjY5dkluR2dGR0YxZmN3?=
 =?utf-8?B?YUZ6WUhQN3dIOUV3MjUzR3l0bG83TDZUSFJxbXdWTTBncmVzdVF3bGQveUxk?=
 =?utf-8?B?V1RROGVwcXA4NklkSU9TMnZiWW85OWRFakYxdzA1Z2Z6MWd5SkpWU3JwK01u?=
 =?utf-8?B?Vm9nSllrbzRyZmV6QTlEZnUzNkF4ZFdYaUE5bXBBR1VtWXhjYStoZDJRV3Mr?=
 =?utf-8?B?NlhOSldKekh2akZXYTNVWXI0N1U3RDFhdktDbzZGblE3dUZQMDNNOC9ZZ3FI?=
 =?utf-8?B?V256Qk1lTXdHd0tJMlNGWjZsQnNBdW44dmlkSHc0akd5SWJqOVBtNGRSYlky?=
 =?utf-8?B?V1RVSTVkUmkvSjlneHdZVlZkRXI0Ynh1NFJoajI2NzdGNVlnNVhneUpINXN3?=
 =?utf-8?B?YlFnTytSQ0RkQ1dMWWpnQ0lkOUhFTDV5UUxhQml1VWZNanpJYTlRS0tTZDRk?=
 =?utf-8?B?MTJoTzdQYVFlaFNIcUt6Z0pkZktVWjFXTmJoWGFjd3F0SmNxUWVBZ1VnRlBK?=
 =?utf-8?B?R2Z1NkNxMm1CNWFic3lTbVZSa3RMRnMrVHI0N2N4OEROdnIzd3gwdWdhU3BD?=
 =?utf-8?B?YUxaK1dRTXlHMmZrOVk5dTVVNUlKN0o1Y0p5NmkyNVluOGF3VDBkZXBCc2lq?=
 =?utf-8?B?T0toOUp5alhRMCtkb3hUUmU1YWkydmVkY01YaGpMNUZaeVc4T3NvN0FxSG1I?=
 =?utf-8?B?MEJnbzl4MFRFRURVemc0ZmJIL2dZQzR0dnFobEtvejI5U2pieDNHcFVQTU1I?=
 =?utf-8?B?TmxkazJyR0c3ZXZDU0R3YWJEZXU2VFB2RWYzbVNvb0FuMStOQ0VicC9UcWRj?=
 =?utf-8?B?NEdEOXZlMG5adEpuOHhaeHllZ0F2MTFOQzlyNEpnSUxPdHNmbFlaaUM2eUE0?=
 =?utf-8?B?R3lrQmtZV0hJeDBjS1ozTE5RUUtjS3BRRWVKaDEwTG5oNEhnVWFXdXNNRkNJ?=
 =?utf-8?B?QXJiZHlhdFdCQzBGeUVZcUFueWFINXZKbkJQSXZnQUpjdWJXQ2Y0Ukk2T2pt?=
 =?utf-8?B?alFLeExmQmNtS1VZQnBNa0x4SlVGVVIvMFhURWUrTUhOaXFiOUk1OFNPOHVF?=
 =?utf-8?B?Wmw0OUZTSnF1QUlqQlNNcDZqY1VrelpjdS9KK1EydE1xTDJqL2tkS296WG44?=
 =?utf-8?B?a3VjY2pWMWVrQm9BcFphWUZldzZsZTEzaXBtdzFWWXBLakRFeHpwRkQzdEdG?=
 =?utf-8?B?SENzRVg3UC9VL0VzSkI2RFFESDRvTEdhKytPbStlbDErL3hBeEFDOWVPeGk0?=
 =?utf-8?B?MEZUb1VldW5hQ21GNmZvUUlpNFhMUmY2RHIzNGRENlBaVStmVzVoUUNjZUtF?=
 =?utf-8?B?TnpzZzhLK21HNC93UC9zY05SZ21sMks4aHNDVHVLT3FDSUREVjQ1TmozWUxh?=
 =?utf-8?B?RFY1UzhtdHdySXZ0d2psQ241di9tTDRrSTY5UjNOemRxVm5OZFg0bWh2b1Fn?=
 =?utf-8?B?NE4zdXdCckJPNVgydnZ6cmdPeUUrQnY0RDhFbWhjUy9lM2ZaV2U0RWRtM25I?=
 =?utf-8?B?SXdLRWYwbHlZNm10RFVPV25rQjF2NVdvOHRMdVlibVIzdzkvVHk5dy8rSnA0?=
 =?utf-8?B?TmsrNHVGNGZYcmh4U2w2bHE0SDNhTzJrOTFqdlZlblpxYi9uNUNYcFNZTEls?=
 =?utf-8?Q?PYMc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd6b819-4162-47e4-076a-08db4016d82e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 14:11:46.6097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5IgVHBRGPdfMfmIskaXmr0YqRhq0HG9+p+DcosNziw8mvgoVFPHKWZaHXM3AtGy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740
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



On 4/17/23 21:22, Bagas Sanjaya wrote:
> On 4/18/23 06:34, Babu Moger wrote:
>> +"ctrl_hw_id":
>> +	Available only with debug option. On x86, reading this file shows
>> +	the Class of Service (CLOS) id which acts as a resource control
>> +	tag on which the resources can be throttled. Kernel assigns a new
>> +	CLOSID a control group is created depending on the available
>> +	CLOSIDs. Multiple cores(or threads) or processes can share a
>> +	same CLOSID in a resctrl group.
>> +
>> <snipped>...
>> +"mon_hw_id":
>> +	Available only with debug option. On x86, reading this file shows
>> +	the Resource Monitoring ID (RMID) for monitoring the resource
>> +	utilization. Monitoring is performed by tagging each core (or
>> +	thread) or process via a RMID. Kernel assigns a new RMID when
>> +	a group is created depending on the available RMIDs. Multiple
>> +	cores (or threads) or processes can share a same RMID in a
>> +	resctrl group.
>> +
> 
> Is CONFIG_DEBUG=y required?
No. Available with resctrl dubug option.
Thanks
Babu Moger
