Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3A674C972
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 03:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjGJBQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 21:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGJBQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 21:16:02 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FEED1
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 18:16:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwDZvnGWnjOWh73d55RPIsJF3M5l4f/ZkGp6YXyMARd+kpWh3XLPd38dikcg8WC4zL1paZl1vtZs3gMElXwqwNmgzQYGy55EKwM5sK8AHOkR6wNQHjaX3Sa+ibtXaCFbcIy3oEyYti55wF0l0A2/lmhZeikBYMw9nukD12subreDeFM+rspNVhniXBwVTaYRPLDD5VFYULtbyRuaZiqm+8I4Z1To2C4HXdrYZogVQMDkiYFkvKGKq9R/Rd0JRCas6G/Sqx+QSZTvV7jmhLFfdxkyBokua1aZfg4bS20S9eRBU+rThaQu8YybTmKATSmhLjvqAsQmWTtdqgtgIbYXcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnTmBpcXmFeYjGIbERR5JKbHEoWxFeYPOOaAyG/cHhA=;
 b=h8XoTBPo/E1xgqoLaSguLsEQwrGSqnFbMNFpljVIgDPu6C/NJDQDzZgc//m2YM8Ji4AjTLJDNo2cvmLfz4HJNQLvl9BdNOGpUPsOZ1Wmn9PoyCS0AyI9dwDyyXeRaGJ32BGLUqjZeuagTw29DtyBacBazd8L9C+oNjAozwHLu6sasyi37QLcuXe+9kynL4/Yz0J/lenFaHqd865uSByEjWI83r3elepmFTX3WDFnB/XbTanH91jAU+T2IA8wqEUD71XQIlbY34oEBbrC+tmoXMT1XqdLgPqf9vHBiOaLa4Zvs7Z0sEu7rZ5J2woIiPQuUxXg1Zoqgpr6V0pilcE7OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnTmBpcXmFeYjGIbERR5JKbHEoWxFeYPOOaAyG/cHhA=;
 b=TsT2ztsNMvAQr42jF9beMhegXnrOysShEFGZKN2fQbOUcJpM5YJCc5D3p5F5oolpQY9B5n1NffytPlZEdUPcjsA0VzghJE2gI6ZZi3+2sTJAcZg5xZrcCdJKMYidYQG3+sr85WA1oNoZANWmp2iK5hqcw+5di3hUym853Gujn1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.26; Mon, 10 Jul 2023 01:15:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 01:15:58 +0000
Message-ID: <6101a3bb-30eb-97fc-3a8e-6d15afc4efb5@amd.com>
Date:   Sun, 9 Jul 2023 20:15:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] init: Don't proxy console= to earlycon
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     kramasub@chromium.org, Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Li Zhe <lizhe.67@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Zhou jie <zhoujie@nfschina.com>
References: <20230707191721.1.Id08823b2f848237ae90ce5c5fa7e027e97c33ad3@changeid>
 <b32ae8af-7950-c725-5632-6ec13420bf77@infradead.org>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <b32ae8af-7950-c725-5632-6ec13420bf77@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0383.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM8PR12MB5430:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e325ff-b29d-4ee7-6bc9-08db80e337b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: svhz4BBLr40rhRDIzt4SqOm0XZGf0ir6Z0lrda6kbsiRtyRc8/NJKhSAm85fGpJJ2tSqRiI6w9PqCxOLQ16RGjagwPe9Ei/N5/mE48Bq+DUbceb3GGJ9HDF+90GDW+ftVl4gtJFmu9zGW09zPsObQqjYO7gs586gQAZYNoIqwwNegHiZPiU64W3q4Kl1SNKi8vdKzFNRcKhn9ipZk+2qkwcdJftHx6DpU4+AVL630t5ypnc6ijJkLFkmhY3Fovkz3kt4HXWgAqpbORPPIm2ZDMQnCsB6LIibq2t3R+ygTg+1NnKbY2xZ9Y7jR2RZisU8oH2j11FF/mOKLn9thpOiIEuFnavRZWEfg8HvaZuc8pbI1Xs7hiwaSnjOe5p9LRY3Kh8ufoSzoEHPVf12kABpinbTKDKtU0rkPWyAWqVTp3O9qk3E4ZEZA9SwRz1Ivg5OAQpFKpJU/83lFN/S2RudvTaUuysa6rfEpH8+65uYSlwbc0h1NBRqYakf3Rb4uSaURbiitiGLRNeLFVLtaz7MloUAc9rawqhqfyMb3OVRn+Db6Wa92n/5hBSp6t5wWeXhEN9mAcaAa1ETW2dOUB+1WloK3PjWN/R/nElmEAUx8PReWEEwfZfC2w54N+PwNnszmPOMEVbD0KDA/FfF3H1vvAV93bKV2ZjMqxWyCOLnqeE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199021)(31686004)(53546011)(6506007)(38100700002)(186003)(86362001)(478600001)(8676002)(44832011)(41300700001)(31696002)(8936002)(66556008)(66476007)(4326008)(6512007)(54906003)(66946007)(316002)(110136005)(6666004)(6486002)(7416002)(2616005)(5660300002)(2906002)(36756003)(83380400001)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm4vbUc1cUlDKzlUN21kdFBPeU5hQjZ6dnN6K0FwanQxSFhpa2dlcUZTaEtC?=
 =?utf-8?B?VzJUbGhhUldHeE1HcVZ6Witsb2RTNTVWanhuenBqSFZZRE9UK2V4RGxaemlF?=
 =?utf-8?B?NGJvc2lwbG1NekJTeFRMRXJNbzRNWFdpUjV1NXNLNVF5TGxUSm5EMHMrbVcv?=
 =?utf-8?B?OWI5TVY2Zmd6bnB2dmNRUHpaTjVTbG1YeTNycmd1WXZrQ2tNNmdDUWhtRVBO?=
 =?utf-8?B?eFJpbm1XSkw2VmFYOUw5REFwYVhqYUhHTUFTUUkzYUY2NzV6VnNZbTNtUU54?=
 =?utf-8?B?ZGJnOEM5U0QxZlZvcXBZS0R2U0hQcDRTcFhQeUJpbEhGNGhkM2QrbTNuSFdG?=
 =?utf-8?B?eXA4UDUvdkV6QlRIU29rUzNUdVkyS0g4ZzRZdm42NDFpdHFiVU5Zc2grWDJP?=
 =?utf-8?B?L1lrMm5KMTFhUCtiU0lHTXpXYUpQMmhCLytyUGdhUVJnNE5UQmdsVVRYSWM2?=
 =?utf-8?B?M2JvK0xjUmZydXFISmZTU0xvYWxyN0dtdU9KK1pLd1VReFB0T0JCN09ZZC9m?=
 =?utf-8?B?c0J4cElkMnRyMDgrMzU5TXJNQUFncEVxZmNNamF6S0g5ejZIRkFpWGpOVjZs?=
 =?utf-8?B?ODVQM1dPTVJacFRDazBkcG5PRENnTThwcXNwcHJBejdUYXo3dzh2VEEwZ1hP?=
 =?utf-8?B?NCsramJJd3B6SnR4UE1qMU4xWXRUWWc2N1RBWmcyK1hIcHZRTjFoK0hpdStN?=
 =?utf-8?B?QnNuZFppWW1zVVEvVW9rbkt5a1BITFE2SHpGWjVESitQQzlRY1BudVkzZEdS?=
 =?utf-8?B?SHFnbVY3ZUFwSFZHNlR6SStXSXRDdGdSdE44ZnRCbStBVmJDVGdtcnFLdnU3?=
 =?utf-8?B?a2tXRHVPU1ZPZm5qY0pBUjJqemlNbU15MEN2VHBzM3pKYmRmcU5lMVVhYnhH?=
 =?utf-8?B?dEg2N0piQjhhMGpWTlVFYWF3anBPQ0syeGozWlcwNTNCVWpidkltM3NDVExo?=
 =?utf-8?B?MjBXMmFDazBucVNlcFdWb2RPdXNLc201Vm9VblFvUVViYU1paUh1VTVscFJz?=
 =?utf-8?B?cUwyYnphb3BlNHN2Z2JLTWFSdXhZSjRyenljK0NDZk4zMTBsamQ1VzdLSTRu?=
 =?utf-8?B?cnR0UDd3M2JqT05DRlRBaUlCNnZ2Z1NZS3ZqSlEvVnVOWXVpNEdVZzg2dUxK?=
 =?utf-8?B?dHVRbkpOam5WZFF2TXh3bVFSUENKbXdmTWx3RWJKTHRwQjZ0ci8zQzRwVUtY?=
 =?utf-8?B?TDBOTnZlVHlpdVBUczU4TDNEWGJKczdJOXdYZ1hyZTQ5VEFETUJvWTdtdUZ4?=
 =?utf-8?B?Mk1TdndLU01rMmw5OWRGZnBUY0I0c1ozdWNLa3Q1TWQwLzloUjY1ZjYwdWdl?=
 =?utf-8?B?aGUxNzJSL25Tek1GK3l4TEZvNFd5ZUdsaHMrMGxMVmFlRlh1RFY1NDZjSDI3?=
 =?utf-8?B?Z1p3VklOK0NvZWtiSFVPSDR4WkNJTFhjNUtJeFJHTWJ5a1UvVkZDdGQ1VTVL?=
 =?utf-8?B?d0ZXRlR0cG92dUhZZVlqcFlHUDFpejZtcFZvRjdqZG1JaGxZMHBHcXoybUlR?=
 =?utf-8?B?T0JUTzVidjlibFB3aGh4eER3aDBJRjhPTWxKRE5CanFrUTJPbUs5WHE3RkNO?=
 =?utf-8?B?cU1zQUlkSUY1TjdOWTBHU3JRVTJvSVBwSzhjZ1NESW1iRE1ZT1V1b0pkblJn?=
 =?utf-8?B?Y0VIbjJrZHVNQWRWMzc5WEJIN1hheEk2bElRdXlxb1JqQWdqMWVaaWV6L2pk?=
 =?utf-8?B?d1o2YnJTOFM3Z25tdUFrdmd1RUF4amJjZ1FXTS9iUS94Z01kNzhCYVBiWjZC?=
 =?utf-8?B?MUlvYnV6MXV3QVFNMmhyZ0xtYVRrMnVDQmJCTU9Ib2JEeDNXbzcyQlpwbmpr?=
 =?utf-8?B?a0l3eWtUNkc1M2dzRXNvblZzT1FzRW9teDhCeHRaSnZlNWJndzBUUkV6QjNB?=
 =?utf-8?B?R0pVczdjSE1zZExockxhaUdRMjdmTXlmYkkzRHo0Y0VjSlZPOXd2bXdabThO?=
 =?utf-8?B?QnA0ejRpNnhLOVFBSlFNbGxGZXE1OG12SU5kS0JaTk9sMDB0ZzhOblh6QTdS?=
 =?utf-8?B?WVhkWVdwQmxYUUtUYks5SkVJWjZRTmxwdGg2ZzFyNlNEc1g4TWh6RWkvN3Za?=
 =?utf-8?B?alY3MnZnOFdSV2V0ellOQkt1U3J0RWxOUmtTNkxXZUZNWE5rZWVmY0svSndB?=
 =?utf-8?B?a2NDVWt0dXlZSHNLN1JKZFBTMTBKUXkvTTNkeVlCY3VBMXpOZEVLRGs3blJ3?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e325ff-b29d-4ee7-6bc9-08db80e337b2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 01:15:58.5175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrLAOpP+toMbwUxiTh21iIA0PecVeTjYIPa9Ie6lA+PhkoRKKGhSpxN9OF49BoW432LY0SnAeN4UXkjqSoCwFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5430
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/23 18:46, Randy Dunlap wrote:
> 
> 
> On 7/7/23 18:17, Raul E Rangel wrote:
>> Right now we are proxying the `console=XXX` command line args to the
>> param_setup_earlycon. This is done because the following are
>> equivalent:
>>
>>      console=uart[8250],mmio,<addr>[,options]
>>      earlycon=uart[8250],mmio,<addr>[,options]
>>
>> In addition, when `earlycon=` or just `earlycon` is specified on the
>> command line, we look at the SPCR table or the DT to extract the device
>> options.
>>
>> When `console=` is specified on the command line, it's intention is to
>> disable the console. Right now since we are proxying the `console=`
> 
> How do you figure this (its intention is to disable the console)?

I read that as "it's intention is to disable the default console (tty0)".

IE if I add console=ttyS0,115200,n8 to my kernel command line then I 
don't get the output on tty0 anymore.  If I want it on both then I do

console=ttyS0,115200,n8 console=tty0.

> 
>> flag to the earlycon handler, we enable the earlycon_acpi_spcr_enable
>> variable when an SPCR table is present. This means that we
>> inadvertently enable the earlycon.
>>
>> This change makes it so we only proxy the console= command if it's
>> value is not empty. This way we can correctly handle both cases.
>>
>> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
>> ---
>>
>>   init/main.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/init/main.c b/init/main.c
>> index aa21add5f7c54..f72bf644910c1 100644
>> --- a/init/main.c
>> +++ b/init/main.c
>> @@ -738,8 +738,7 @@ static int __init do_early_param(char *param, char *val,
>>   	for (p = __setup_start; p < __setup_end; p++) {
>>   		if ((p->early && parameq(param, p->str)) ||
>>   		    (strcmp(param, "console") == 0 &&
>> -		     strcmp(p->str, "earlycon") == 0)
>> -		) {
>> +		     strcmp(p->str, "earlycon") == 0 && val && val[0])) {
>>   			if (p->setup_func(val) != 0)
>>   				pr_warn("Malformed early option '%s'\n", param);
>>   		}
> 

