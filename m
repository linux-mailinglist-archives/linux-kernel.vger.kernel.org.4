Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06CB6FCE94
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 21:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbjEITbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 15:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbjEITbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 15:31:23 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145EB4499;
        Tue,  9 May 2023 12:31:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ny2oPPjzoVStpqcxFglSmWoLh1jZ1zGlB8JcAy53/Y8EE2PA84nwrHujliIp97ZTplzO6oADQ2JmJaCjKgerFRY/8RAJB/fo5javbQNCTv/cTEI5y6Ee1ocFtaLqyV8oTXiYSAzfaLAaCcayxq5N0j7RTai/h0RG7lRuE58OX4jyVrv3yIX9C048G61uM4hEMcw+8gVvLz0UsYk6MR4dTk+7X4CRg5CFENpttomZfKpl9LXg45WknYHQSTjQm4OMQgaBP2XTNGx8n0v1MfUHxirG8FTcStSIb2HDSSniL/ti/8BOimxSvZAZe4FH/DXDur29SB22TOpYP5CBbBVJqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdBIeUnz21+HXtmk5rIIhNKDGqBZka0z1+W2XDR2g+4=;
 b=AtLenMF3ccskfpHK9N73JCax4Hkhu8BitIO+hxtlUYvik+M3ob67G7nDOmcrmdd+fYi7INlo6Q+uh+clwV6Ofx8LAcq6tr5X2hG8HUR3x3Bc219HqTUCcciWZGpJmYszCR4rJuLo9R8F9fp3YLd7IU+UUzcaXXcylfw3Z0KS1y9yiAbImVJ3Wf3usz7NJ4zhWFJ9rsyySpUUJVYRkmpWxUme77zWOfAmqvpuMd7tQLdAaeZaJvKAwfhWTICqo31FN/XjBcU7kbkDN305K9xRV398HwVIS1zmF5wuqszM5UA1VA801KV6OWu86AYg/sfVzzCasn2ANS3nZH0+6jZ7HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdBIeUnz21+HXtmk5rIIhNKDGqBZka0z1+W2XDR2g+4=;
 b=DFj25K9iWPfMeXkZwyAk3rbBZrJfVlyzJDtg9GgYyjTmJlTkKVtO1h7u+3Mh7T4UMzf8DxDa/jYhV0AdG8NMGULGuOBdgd8TJbRwHxtagqh5BsSO+kTyyM9zLA6D0KgizYQTwqs0dMv5Igk0w0sWDMmXwoApEjT6sz7okKMOTUI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 19:31:20 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::25d0:8212:2ae3:2aec]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::25d0:8212:2ae3:2aec%6]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 19:31:20 +0000
Message-ID: <9baadb79-f78f-2719-68c3-f1e7761c0824@amd.com>
Date:   Tue, 9 May 2023 14:31:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 2/7] x86/resctrl: Remove unnecessary rftype flags
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
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
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <168177445556.1758847.5029687867896978170.stgit@bmoger-ubuntu>
 <4275aa91-5834-2c03-f455-f1d3d666fec7@intel.com>
 <MW3PR12MB4553E65A5D5DE6E27045766595729@MW3PR12MB4553.namprd12.prod.outlook.com>
 <efd45c71-2241-e0b8-e1c0-6fcc1e95b321@intel.com>
 <MW3PR12MB4553C5EF3818F6C54B8BF5B695729@MW3PR12MB4553.namprd12.prod.outlook.com>
 <8acebeed-8c0e-98ac-b7a3-5dd1680fafa3@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <8acebeed-8c0e-98ac-b7a3-5dd1680fafa3@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:8:2f::22) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|DM6PR12MB4340:EE_
X-MS-Office365-Filtering-Correlation-Id: d360f949-e851-4557-683a-08db50c3f723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MdLADfVX3oLg6PMkvt8Ywd29Dwbnyw87LqkyviMkcUwPePGK0NunYBPA7S/y2hWi6PKW8oWznVACfEG5UsHqgxWqzY6lRkUUjZwUNalvYKPJA0p1JuPrwsC4KH9CnMWOFiSBzjpViMRavtFy3m1sK4rdohIhaKHcfjPH/h9WyD2xW5AYqC53qWLBPhuoG30Q5dSNnkbEOfV8iOAN7HA8ZoiTFJij97lV2EfowPm3KWe7hC1svsGVZE/BJlgyDG9yLt6MyxDKx67Ty479j9ckDBdG3lUJIlAzxjpd6gRC7J+E1QY6OI7QhZF1JOAUmxaQKgFqJEXChWviycCZ5Mq7HNCCoe++Gcm+pA0WD5un/m8TlfpRbZwEh1XGzHMj5g6P03R3LfS3z+tNJTzMxFMVAkNI+zTREt6ew6nEuB/gRUGX6xWxdv+EJ4oys6P1dD8sqGN06OCUyLJUPfQdSR9lUAm34JGnqsF7TA1xMSxqcmw9JYkXPjD59pzy2vOwIDOzUqg2ZG57J5nJ9Ml8ze28u+MYuIbTskaFBhCTIAkCyWXa5zWtoy5cOiItLQ7S/GMgMakwfJyFnd18cR/MuyFhKDn/XGzYps6VyR+/bzOhFNGm2u609a6DMQBYmsB8b8WJjFT/2MJIRDJoSuVCdfO8Sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199021)(2616005)(8676002)(8936002)(4326008)(38100700002)(5660300002)(41300700001)(31686004)(66946007)(66476007)(66556008)(316002)(36756003)(7416002)(7406005)(478600001)(6486002)(186003)(6666004)(558084003)(6506007)(3450700001)(26005)(53546011)(86362001)(6512007)(54906003)(2906002)(31696002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RThUVXpWTDBhczVkdWNGdDltTnNoeDNsVWF1NzZSY1VJeitaQXp5dXpPUzl4?=
 =?utf-8?B?SElQejlrK3FScW1BZUY2dHhoL1R5Z3JXdWd6ZFdLUVVFRmVoSnpTK0FEZDFG?=
 =?utf-8?B?eFdmT3pwVUNZMVRWNlZXU3VMQm5uWWM2USs5aXlGeG9rcU54QWljQ1J4VTNG?=
 =?utf-8?B?TnR6VGdoSjdJek04b0IwSWF1RTlzUFh3d2ZrekZEM1pDaDRYZU1waTdQOHZt?=
 =?utf-8?B?bk1FTUwwcjNmQWtDWE5kNU92YmswRFBIU3pSeGZKN25QVmF2VmdhK3hJNnZI?=
 =?utf-8?B?TjJSWDBJTnhJRTVkekpWWkZjZGJRa1EzbzE1anFnQitGcytmMW95c2VIRUM3?=
 =?utf-8?B?QkhQTWNxMVVYbkhWeGZHTHBDUjVyVWpva1IrQkM5dURjQWptMFdEUFFLMXRI?=
 =?utf-8?B?SXl5SGNBVnJwc3lEaTNudUtxV09vdzhsVmFwMXpCcnZQYWthSDBUQW1LYXo1?=
 =?utf-8?B?KytIVEYvM25NQ0pxUFRtclZFbVF3aGFxbzBrandiRDREVEFpdXNGb3QvOTE3?=
 =?utf-8?B?YVZuUDAzdUJiQ3JlQWN1U1JXNUY4ZnVKYm15dGlsa2ZkaW1zbGFTUjl4SFVv?=
 =?utf-8?B?OFUrblp4ckF4UGQ5WUdkQTVFVzMrMDBnYjNOVUVNbGlONzVyVlBwTWp4eHZK?=
 =?utf-8?B?ZmJrNmg5Z0tmcnN4NmVsa3JkVUwxMStDa2h4TUdyL29jc3ZqNjdIWmtRUGVR?=
 =?utf-8?B?bmptWXl5NkdDNWZWcFNoL2tQc2ZJU1JoeGtKRHdpdkcvWjZMMzdRSEJidVh1?=
 =?utf-8?B?SjM0Zk9kbDJuSFl2UGl6dTl3ekhJZDdSdVVVM1ZoeS9zRFBHY1R3Q1ZlcWF5?=
 =?utf-8?B?NjdIT1JSeUpUZlVDbE4wOFFoV0k1MnRQSm11emlLTGhqSEhvMFFSdXRFV1Nz?=
 =?utf-8?B?d0JQNU54MkQ0OURHMUtXYTNzWm5qeDQ4NklPYnZHSVNmNEdJZ0wvOW9lWmhZ?=
 =?utf-8?B?Z2Z3SHN3YlFDc2cxdmVpcFZEU1VqYXRGcE12RUNtaGQyNVR5Zk5yMXBvNmFo?=
 =?utf-8?B?dnRjcWo3L1hHTTJPYVRJU1V2ak9vYjJwaXI1dlRjeGVaYmEvampBc05nS1FU?=
 =?utf-8?B?MEdRR0dyZ3I3KzYwYmRIK2p4aXgvcVk2eFVCZTkwaGM1S0tqYVcwdU5qQnA0?=
 =?utf-8?B?djF3bXl2OVFwQTRuUGZhRnRvSDM4aWF1NGErWUJXSDQ3WTJlRjFBQlVaVHRK?=
 =?utf-8?B?KzRQb25lN05pNTYyVG5nM2pTbnV3QXhVTEloeDBhR2M0WUlXWGpVTUhjczJy?=
 =?utf-8?B?Ym5Tcy9DUU8zSk1FdTZhdVJ2UmVyM0xQRmNHZGlFUUtId29LbXZYT045Ui9J?=
 =?utf-8?B?MHdRMFNGNVRqQS9XYjI3dzRCbHd6Zm9vaFJNdVJQNy8vM2tXZEk2cGlFZklS?=
 =?utf-8?B?cnpKSVo3NG5ha2dzSEQrVDlzOHVwSFRjZzh4cXBzQXFCTklUaFJZdHJ4T1hm?=
 =?utf-8?B?OEhBWWo1ZktGVXo1N2VaaUJHOTNEaGI2eTdYS2xZOTZZZ04wMnp0UDB2N3FY?=
 =?utf-8?B?TmxncjhZUlZpYVR4YjNzcGdoMm1ZSWhQb3AvUTYycENJbnB5cmRsSUZSamNX?=
 =?utf-8?B?MlR0cjNzemhCeEloTkpGU2RLajI2cXM4MnZRUjFGSzBVTXVIcmJRNGNISEJI?=
 =?utf-8?B?em5PV05SSDNJa3VmRmtWVnVmRVpRcUIvYm1QTXo0K1B4RWhVaWZCRm1RNHha?=
 =?utf-8?B?SFBzMWZVSGprQTNjczYwUDVsaGZnOWdnNVRXL1pEWUlvUnlNV3pZM29kY1BK?=
 =?utf-8?B?TVBYZHNUSXhwOG5qZUxnazgzV1JhaUk4eC9VU0ZZd0FCRkR3dUNxamtEVmt2?=
 =?utf-8?B?eFM5ODRSMFFJc3hPWFF1elRWaFlPYnFDVWJnVkV6NGFYaWdsalZ4dHVPUUFy?=
 =?utf-8?B?RDFFczVZTTQ4YTVJNitBUTd4TzJZSmZ2ODFPQ0gwWExLM0pTUkN6RWZxYXFq?=
 =?utf-8?B?TmVkZnI1cjJIdGYxTkcyMnlpVExsR3FUZjBVWGhHTnhtT2Fqb3dsb3QyL2R3?=
 =?utf-8?B?TzN4QjdrWnRyRzBwTXRPQUROc2hkV2Q2WDNHcnpQcVFlTDd2NlZTODlJb2VV?=
 =?utf-8?B?SzRyVEdoa2pDeDhoeGEyaldiUlh4TFdCck5RbkNYWURsVlU1TXl5SGpRWlpm?=
 =?utf-8?Q?7Mc0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d360f949-e851-4557-683a-08db50c3f723
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 19:31:19.9402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jr90Ay1EyRLxkuqwpBX/Pief2qNw5xdldY5/qxLne9OKESAON8VhK5BCvHVjHATz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/5/23 16:28, Reinette Chatre wrote:
> 
> (is it possible to trim the headers in your replies?)

Sure. Got it. Thanks
Babu


