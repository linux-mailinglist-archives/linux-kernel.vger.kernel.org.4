Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F3C73FDC9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjF0O0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjF0O0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:26:15 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7BF2D6A;
        Tue, 27 Jun 2023 07:26:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGSvGTe8Fe/8+43NiBRL2Mxk+CU5bn91wWkdNIxV7J4DKAqwSrhue3Un+zitRqrzmMMG4z5U43EHgN5yoUKXcrPbeUMTHISyp8Cc7f6nzq3esBuAhhMah8CJI0nPuC/jp5ScWW30vgexjA0RWQTOMFdgZ3+rLwkDNH2nIAKlbaEXp86oXUGPzbjtFDMnAUFx1l3fbhWxC6UC/VdGBNZ5wLzo81EWHjB/6DPakwEq0JjXsMycJ0J62BT5HnMQzPNqBCu9DTbgn7FB9COx0kOJROz1dVlaOnhVhautcXY630qb9WmFMwM3zBs9vA/Vg1FySShlvPcF/lOHfwSc18iwgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxkgnJ/rnUkaNwdwBHs5n7zpDzrY2rVOi32WMKX7WR4=;
 b=jkUSJXF0Qw50GDnpN0PsnfK9JGndfLjDhrobwSIeRuUcCSKhjFPfEbpfQJYD+Am0z8h5OYwLK529sqh56UzJK/ixRp3bYdfQWD8CpZ/b6rcWplbzbaio+TILGaTkZ7lsJCBOFbWZaSVFOl4P1J7Nr3NzzBv/5VLQjmfALVl3i/dglDT4MYjJlTq5kmz+Ay5c5UQbCSKIWFgTZCx3/y3WjhsAmsn0EE3719LwcCtOckgV0QBpwow22Fx6J6Fzg7Kjj9U1G4mOenCH2zIPYMoWybfx1gW1Sqew9q2/CzGPQ5O0pmxHaA5qn36SdXCvswEW6K9iUrq75zPbnnOzImMjbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxkgnJ/rnUkaNwdwBHs5n7zpDzrY2rVOi32WMKX7WR4=;
 b=ZYgMclQzDAnL+t8yoMQytK6Q6SRWHgQ3VmzrcTp18LZAo+plYNGAhpzmVKtGMuZN8S/h3tCoOCcjDvdt4QkNMNIKti6+LcAjSHrdG6I1apYAUq8WRzO6ntLCdfI4ZKHfGn6YU0Ll70E+xVoPBJUCvngAbTYx3NUbRzEht7Qigww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB7454.namprd12.prod.outlook.com (2603:10b6:510:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 14:26:10 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbc1:dd6b:26eb:d46e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbc1:dd6b:26eb:d46e%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 14:26:10 +0000
Message-ID: <cd69a5f1-63eb-70f7-9689-7d9b5b99ab62@amd.com>
Date:   Tue, 27 Jun 2023 09:26:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 0/8] x86/resctrl: Miscellaneous resctrl features
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
Cc:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "eranian@google.com" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0153.namprd04.prod.outlook.com
 (2603:10b6:806:125::8) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d4d80e-5731-487f-73d0-08db771a73c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cr7qqeZs4Fu4CB9GfpVi7Kukj53i7rgKgnrU7EmSCzjQQgahggWLCVbtSO9zaf6TJhRPzqkdzRY0Cb/lsP1DZm1oMLnbir4jss4n04fuNeoLgx84nxfb7S1l1PJMGhxtLXKEX+7iVK/pjrov936e27P54P5d860F31597ZkQDNamwaqh/jqf8pUrCS0SS5EoC6xtCxYUn3J+k6Or+Eie95Fd9SwTRdUeESC5y/DbWoZjGZVaUdwEcv1eEjqmyp1Gm41b5VA1eQAnYEGCraIkqoz6/oK6nuClfm72NGVC7GjQC+MfkyBAabpScn8eRSep1S2shtGEvnreRZOvaWtbSYxLhsc6dpU84gYlwmGqCalAKPzM1a/r1Z7B74a2dcwZDSW6S9JGMwkAV/8WzFjNG7TdV0GYYfasLCs5PUAg3JXGqDlCy2UdTuB5E+4wfRUGANlWHSgsL7N9VuWrsMjNI/UDviynYN91RqCEaoqYFhBayEvcvMNKuvRxEL5juevUiv9jxMrXED7M9+yti/VGab+erGryEtGD0wRFtj26J0J4Ie6xKp6VWlKSWBx5O5ksnvcU+QH02r7M7tlZwZLeT7onCMmSd6KRfCCbeQp99K46bJN53na9AHc6tCYFcbHnCyia4zR2YK0S4apaz00/64acb34MIU4UkyqS1YkcvOhZxQ0QKDeRIVn4UISIXzd/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(6512007)(478600001)(6506007)(7416002)(66556008)(7406005)(66946007)(66476007)(4326008)(316002)(36756003)(5660300002)(8936002)(8676002)(31686004)(966005)(86362001)(54906003)(110136005)(41300700001)(31696002)(6486002)(2906002)(83380400001)(186003)(26005)(53546011)(6666004)(38100700002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STJucmpOc2F3K2tMcjExWHBzU1NBSDA5NWtOY0RDVVk4ajJjcjh3R2U4TWxK?=
 =?utf-8?B?UjFwRTJRQ3ZQbkpvd0FHbFVreER0VCs5YmtMclJRYTRGTHY3eVh4SVNUWEMw?=
 =?utf-8?B?SGJHSWRTcThjNmNKUHlyU2wxY0hoTUMyQmxGV2x3NVNKMmNVYW5nbXpCWjVy?=
 =?utf-8?B?ZjljNjNndzRKUkpCN0p4bWZUaXA2M3pWa01hMjZEYU5QaXVmYkVWQjUzT245?=
 =?utf-8?B?TXBUZS8zZnArUkRKWG5rZSt6WTR5dXRHOEpjR0VRaUR0VlVQaXl0eTNtWURU?=
 =?utf-8?B?dFByOXpZUXFyRXJSYTZMNDA5WEhLcFIrOGhHU0krSUlJb0p1M0MyeEI0OEVE?=
 =?utf-8?B?NkorSTkwZUNPQ2xzUS9Gc0xCNU9rVHAyYUQ4eE9UdWJHazF5c2FzRjVkVEFu?=
 =?utf-8?B?L3hKT1l5NmphYTNvYXhNanllSnhWdEVZZ3N5NDN2S042Y0VEZ29jTUxERzho?=
 =?utf-8?B?NTV5eFpTVUdpN1ZEWW1vTldQQWtpbFhTbFdnOTRPK3JXVWdqSXkyRWs3UEJ5?=
 =?utf-8?B?VWVSOGErSm5YS2FzaHlFMEFtOUZ3ZkRQWE1pN0FUOXNxZklTR0R1bThhTzNl?=
 =?utf-8?B?b21zQ1ZldmVtZXVEdnVYc2dEZXdSci91RHdYVFJKWjhZR3EyZWh6M2x0ejV4?=
 =?utf-8?B?RXVqV0tyVHVLSk1vbU9yTDZRV3FrMk1wT2dJbFBSdkJHazJ3dTdoNkpZZ2Ez?=
 =?utf-8?B?WS82ME82dWMvakNXeUdPZDdnWVVROUlFcVVSSVJsKzA3U0NJUFVIVGVxaVVv?=
 =?utf-8?B?WE9vZlI5dGJsdW1CTnUrVEFZS1JnM3dZMWM3dmpPa2RYQWpPT2Vndnhob29X?=
 =?utf-8?B?YVd3TkVaczJQVG1MRlh4M3FoenFwN1pvWFMrMHZXUDRSN0YxM2Vpb2pKM2cv?=
 =?utf-8?B?MS9PNDFhR25iNm5JQUVtZWQrdkJRWlhFK0ZNZHZ2TnFGeC9JL1owekxYR3lP?=
 =?utf-8?B?OXlyUWx0Y3pXU3doZ3NZenlqQzE4K200K3ZGWW1SVEpVVlVuN3krYW4zTjZs?=
 =?utf-8?B?U3QwWDR1dGV2S0wzSk52TFl1dFlnTFhCellKYzYyd3R3VVE3aC9pVGc4T1Ur?=
 =?utf-8?B?VjF2Sk1mMTdERmZNdzhuaDJxbHZoYXlpVUFVOFYwaUlwV3FwZEpXSlFpcUVV?=
 =?utf-8?B?dGtIeFJGL0xtMGh3T3NNNU9nNlZ1NjVWZGRvditrdFVHQXhUNVdyZXNvM2tO?=
 =?utf-8?B?dmJUczYzMHpOM2p6V05ZUjhJZFBoZmF3Z0tzTkI0N2VoQjYxQ0pYVTJGbGc5?=
 =?utf-8?B?MWg2M2IvWEtlR0haUkFuUzJDQ1djTlVra2VENGxVMmNPeEUxMnpmYnkwZFdO?=
 =?utf-8?B?RXk1MzlYWXg3ckJUUVYzbGFOczJudDE2TDBMblh4RnBNbmtSTjZ0cTZabkpW?=
 =?utf-8?B?WjZLRWUyN1I2bU9ORjZRdDdsRkhPY1dlM3pmOVl0TGhqWmdOdFVqSCs1ZkxS?=
 =?utf-8?B?WHpaZ2RYU0x3aWs5OXdkVDhkZkt1bER3emE0a1pqdGQ4QndZYWExbUdnUmhr?=
 =?utf-8?B?d1hTcGxtM3BLMDVBdlN2bzJiTCtGRHc1dDI4cjNvT01GbGQrc2FsQktrVFZJ?=
 =?utf-8?B?bU1RTTBEUFRFMmNTUUVsSVhNNE5FMW90K1l3a3RDeTREL2FuQjllWVB2czFK?=
 =?utf-8?B?OUovUFhJZ2JpNFdjcndLK2hPa3Nzd2pLZDlibDE5MWl4K3FxcWhUc1VKelBr?=
 =?utf-8?B?RE1rVWRFOUpuOTgzUVByUk51dWgzd2hPT0VTYnpKMXY1empJUWtSSDl4WStv?=
 =?utf-8?B?OXQvOEoyR3hiYTdGekNyc3M3QjZBNHVxRDdJT1V6b2NvWEx1UHFkTHU4VnVi?=
 =?utf-8?B?NnlUbTBCTG16TGk4Zm1Pc1R5d0JaMTYyNjIzWDlFbG1DY1N3M1pjbFBZM0R6?=
 =?utf-8?B?WFJUMTRsNXA4V3YrMVhXcVlFeEtaOTIyamxtRVBoTEFDTXZpVytSMEpLV1l1?=
 =?utf-8?B?SElhcVBpUWUza1hJSmtFZjFCTEsreWpyNjFyS3BVV09LTy94ZUZxZ0NjZnky?=
 =?utf-8?B?TjVERE5XMmZ1VlhRUXRuSEU2ODZvbkV1cXMxRHpKWUs0SCtPeVlWb2U3OExs?=
 =?utf-8?B?em1tQW4xMVkyUy96VnBoMnJTdXViQzB3Q1NOcFg1QnF5aURXTWpnVGlGczd6?=
 =?utf-8?Q?C92c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d4d80e-5731-487f-73d0-08db771a73c6
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 14:26:10.0525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sPEUZccWkzpdugkCI5WZuTS8+dIt455MVjyutyLTrLT6jga4rwvuNnGIryEPXPl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7454
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping, Any comments on this series.
Thanks
Babu

> -----Original Message-----
> From: Moger, Babu <Babu.Moger@amd.com>
> Sent: Thursday, June 1, 2023 2:01 PM
> To: corbet@lwn.net; reinette.chatre@intel.com; tglx@linutronix.de;
> mingo@redhat.com; bp@alien8.de
> Cc: fenghua.yu@intel.com; dave.hansen@linux.intel.com; x86@kernel.org;
> hpa@zytor.com; paulmck@kernel.org; akpm@linux-foundation.org;
> quic_neeraju@quicinc.com; rdunlap@infradead.org;
> damien.lemoal@opensource.wdc.com; songmuchun@bytedance.com;
> peterz@infradead.org; jpoimboe@kernel.org; pbonzini@redhat.com; Moger,
> Babu <Babu.Moger@amd.com>; chang.seok.bae@intel.com;
> pawan.kumar.gupta@linux.intel.com; jmattson@google.com;
> daniel.sneddon@linux.intel.com; Das1, Sandipan <Sandipan.Das@amd.com>;
> tony.luck@intel.com; james.morse@arm.com; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; bagasdotme@gmail.com; eranian@google.com;
> christophe.leroy@csgroup.eu; pawan.kumar.gupta@linux.intel.com;
> jarkko@kernel.org; adrian.hunter@intel.com; quic_jiles@quicinc.com;
> peternewman@google.com; Moger, Babu <Babu.Moger@amd.com>
> Subject: [PATCH v5 0/8] x86/resctrl: Miscellaneous resctrl features
> 
> These series adds support few minor features.
> 1. Support assigning multiple tasks to control/mon groups in one command.
> 2. Add debug mount option for resctrl interface.
> 3. Add RMID and CLOSID in resctrl interface when mounted with debug option.
> 4. Moves the default control group creation during the mount instead of during
> init.
> 5. While doing these above changes, found that rftype flags needed some
> cleanup.
>    They were named inconsistently. Re-arranged them much more cleanly now
> and added
>    few comments.  Hope it can help future additions.
> 
> ---
> v5:
>    Changes since v4:
>    Moved the default group creation during mount instead of kernel init.
>    Tried to address most of the comments on commit log. Added more context
> and details.
>    Addressed feedback about the patch4. Removed the code changes and only
> kept the comments.
>    I am ok to drop patch4. But I will wait for the comment on that.
>    There were lots of comments. Hope I did not miss anything. Even if I missed, it
> is
>    not intentional.
> 
> v4: Changes since v3
>     Addressed comments from Reinette and others.
>     Removed newline requirement when adding tasks.
>     Dropped one of the changes on flags. Kept the flag names mostly same.
>     Changed the names of closid and rmid to ctrl_hw_id and mon_hw_id
> respectively.
>     James had some concerns about adding these files. Addressed it by making
> these
>     files x86 specific.
>     Tried to address Reinette's comment on patch 7. But due to current code
> design
>     I could not do it exact way. But changed it little bit to make it easy debug
>     file additions in the future.
> 
> v3: Changes since v2
>     Still waiting for more comments. While waiting, addressed few comments
> from Fenghua.
>     Added few more texts in the documentation about multiple tasks assignment
> feature.
>     Added pid in last_cmd_status when applicable.
>     Introduced static resctrl_debug to save the debug option.
>     Few minor text changes.
> 
> v2: Changes since v1
>   a. Removed the changes to add the task's threads automatically. It required
>      book keeping to handle the failures and gets complicated. Removed that
> change
>      for now.
>   b. Added -o debug option to mount in debug mode(comment from Fenghua)
>   c. Added debug files rmid and closid. Stephane wanted to rename them more
>      generic to accommodate ARM. It kind of loses meaning if is renamed
> differently.
>      Kept it same for now. Will change if he feels strong about it.
> 
> v4:
> https://lore.kernel.org/lkml/168177435378.1758847.8317743523931859131.stg
> it@bmoger-ubuntu/
> v3:
> https://lore.kernel.org/lkml/167778850105.1053859.14596357862185564029.st
> git@bmoger-ubuntu/
> v2:
> https://lore.kernel.org/lkml/167537433143.647488.9641864719195184123.stgit
> @bmoger-ubuntu/
> v1:
> https://lore.kernel.org/lkml/167278351577.34228.12803395505584557101.stgit
> @bmoger-ubuntu/
> 
> Babu Moger (8):
>       x86/resctrl: Add multiple tasks to the resctrl group at once
>       x86/resctrl: Simplify rftype flag definitions
>       x86/resctrl: Rename rftype flags for consistency
>       x86/resctrl: Add comments on RFTYPE flags hierarchy
>       x86/resctrl: Introduce "-o debug" mount option
>       x86/resctrl: Display CLOSID and RMID for the resctrl groups
>       x86/resctrl: Move default control group creation during mount
>       x86/resctrl: Introduce RFTYPE_DEBUG flag
> 
> 
>  Documentation/arch/x86/resctrl.rst     |  19 ++-
>  arch/x86/kernel/cpu/resctrl/internal.h |  66 ++++++--
> arch/x86/kernel/cpu/resctrl/rdtgroup.c | 199 +++++++++++++++++--------
>  3 files changed, 212 insertions(+), 72 deletions(-)
> 
> --

