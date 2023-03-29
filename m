Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C506CDB24
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjC2Ntf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjC2Ntc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:49:32 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9863C11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:49:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LO77xbgYR5zRrnBhA85SkFv7wng1+lWW5cjg3TUQHPvKEchDQwZowfaHaG5eQKO0YhH+ZU2FacCxWwdL00tNy7Jh5TJo5RFg6o3aWuivSDFvahXI/HVUzvuiOWilDt9ctBJ8MMI0UjgkHFRuUx91hZDsgVDfhyb+RUZ2nml3bQ4HyAorQkIveqTbvbrkrJMBZ0yhXcRYpH9rHz+8f53IJDmrTHR7jHEOPNMzz0O1zYGWUkAEnINUWJJjKcQBmXKrMT4t54KU8Wb1zQTxqUC8tUBplZybyt0jwexLhnVQk4y0eyuZQzeCuadNh3e14uoHKJy3k5P1INht6rMEuiVb8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYlJV60dofT7AlTqoKofH3jnewKgjvfOOljoEYPGZRE=;
 b=lfLok0P2hXaWUfdEOL3F9qAPjLqU8PmaTwW3vcIHGVQd+FFccIpDYwJF5ivTy4h36rt75CcGbBC6hHMZ8c5+FiUdOkcE7IwuMxJWj1h7DtnNAKgWHGi51euxXkkcIUHYyIzKKJxlqciW+wOW4YuzGvU0AVf5L7GjGFgCjJ6X/0q9YrSVb7ecbmydBEOtS/+xGDSTWzYJIGvFmeadcSc6I3hCUwz3enyxTkfXaCZTficd4VhT0pDrDfQMxsYJU2nVR6zmbypsS1NPzSW7vt8w2JDjINRMNDtXyTisl8mJz2FVkbxdTnWXkQOKSOaP6q1C231Drd/CMy1khaQFsPbhLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYlJV60dofT7AlTqoKofH3jnewKgjvfOOljoEYPGZRE=;
 b=Dg6HIMSnbHCDaasCNWsf4Ix9fLY0wWmy1mvGIsvXfd6gTJWw3J9vpqA1oICWfRkQ/URXX0788JYptoCtv2hTf7EBdBXH3yi14dJDzP4K6PUaN2QvEuR0t4t/331kdzkzRxoEs34/X0HkCrTH5p1H2FbHVTAHZpmhwQ/qPzt6lYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SJ0PR12MB6877.namprd12.prod.outlook.com (2603:10b6:a03:47f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Wed, 29 Mar
 2023 13:49:28 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60%6]) with mapi id 15.20.6222.033; Wed, 29 Mar 2023
 13:49:27 +0000
Message-ID: <17b65c2a-69a8-6348-da64-641d34be122e@amd.com>
Date:   Wed, 29 Mar 2023 08:49:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] x86/insn: support decode MOVSXD instruction for MMIO
Content-Language: en-US
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tony.luck@intel.com, kirill.shutemov@linux.intel.com,
        wutu.xq2@linux.alibaba.com
References: <1655f5dc49ab77f94e350ecbdc93e8d9b31acf61.1680058548.git.wuzongyong@linux.alibaba.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <1655f5dc49ab77f94e350ecbdc93e8d9b31acf61.1680058548.git.wuzongyong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0144.namprd11.prod.outlook.com
 (2603:10b6:806:131::29) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SJ0PR12MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: be2fbf5c-6eac-4fa6-6034-08db305c69c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /KnVHXlip8747Es1JeW64NnAZAcN842VjH4cK2jROMJVViHrj4J0w7JpT+Pu0DD/nTC4jt7S/ZegltnTyhcMvBoEl346TxUdTRBz8L7aqn4juQrid0tKepX+Lx1Bvzxnbrc4tS8OUl/9eiH0fyGAiiaLzgyQbc/ZH9PXXJUDeVN8hekpCpeQcG/uzyRy1qijLrig25buhL48xJOJoBhU3WiUSHZiW/xyCa/ZBSMjmpSEqZ+6yhsVFXoPsvOiXSqpnhUtOZFhrPaRaszpy7dhoZ8TLlT9UsCOsAls5w1hpwXxTBQjVtTq+9WhKsjk2eVY9Ah5QWPvBdg6r9vFgczOceIeIHCkp0f3pGk9T8UnLMOTkiAfFvIGX3NnNjzHjvB2UmervgLoC9WdSvBDy068tgcZaH1kgQCpBpFMTWpw+oOW7R8eqsgglKS7pl9LokJrM6o9w1k758Drzf+gsfVA0SymvYYBj8dFL6F4DzxImlCTbNqXIYapZBQILofhPpeba0+lrXoDyaRgQP5+0t8i8W0gJTJ1fS/QPCrhQo9fW8tTdkr3wqZIiAjs6ws1IZK9i8LP4GsmVMEjrAhSSC1lmQwYmQ3ZnTc2/sm9gGsyXTiUSrIN0rF/lobuPU8czOf7TPb15iHuwoU/wh32hhhSFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199021)(6666004)(38100700002)(316002)(66946007)(66476007)(8676002)(6512007)(4744005)(5660300002)(4326008)(186003)(41300700001)(8936002)(6506007)(6486002)(2616005)(26005)(53546011)(478600001)(86362001)(31696002)(2906002)(36756003)(66556008)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGZiZTdOQkJmSERJYU4rVzF6UWxZak5KOUx3eDhMbVZsS0FKRXpnSzMzcHFj?=
 =?utf-8?B?emJTbmVGOHVmUDNLZ1BGeGFhU1BocHMzMWZPK2dvd2s1T2VMWEpLWk1sMnZl?=
 =?utf-8?B?eGZSYTB2WnQ3R2hnVFRZUitteHJDeXQyQ3B0R3hEYi9sSmVKV3RSSHFkTW5a?=
 =?utf-8?B?WHQzR0F4UytxbGM2R04yMlB2MHo0bWEwYmVvcWJIM3hmRWxjU0dGY1ZQZFZ5?=
 =?utf-8?B?RHIrUlFhbTBLb3d4c015Ujg5YVZad05iNGtBdDBCUCtWUG92Z1JjRTh2Q2lO?=
 =?utf-8?B?ZW1QelVBS01EVkZ5WDV1Q1hvQ2pkazRTNWs2YXpoZm8rU05FVHFWTWh3MWNr?=
 =?utf-8?B?cDVZeWlyQVJXVVlUa1hTZDZDeVdjL1MydzAxWW1ndTlRazBKbE1rUHloOVZv?=
 =?utf-8?B?S0dXTlltS3U2WUJUUW1aRmJMZlliWXJteUg5VlZZd3d4cmdFdjNtbklMWlNU?=
 =?utf-8?B?RzV2VFdlQkJMLzRrQk9ZdHlLWHJKWVNVL1grUW54N0NLVkZyL243M1RvdFBI?=
 =?utf-8?B?by9RSDgzYmhCVFhGSjk2b1NyUjRzUEl2RytIMnF2K2h3L1NUbXpSSGFXUjhS?=
 =?utf-8?B?U29PcmM4Q3NyVDVucC9iaE9YTWszNEhYaFB3c3NQN2lNTUZQM09aVlVoTlFu?=
 =?utf-8?B?YjRSWXNQR3BzZzFnY05IYWpzVnNTRlVGVnFhaEJJaldteHBKL2t0Sk5VUlZs?=
 =?utf-8?B?eEtNakgwdEt1Q3BJTTFZS0NCV1orNXJkd29FQk5UbFgzd1U1QXlUbkJLelRm?=
 =?utf-8?B?UnQ0U3Z5WXFYWS9ielZaK1NvSDVPMjZWZHhYb29QVmpTKzhQM1h2RUl5amFH?=
 =?utf-8?B?aThSUFk0RWdMeU5SVHhwWFUvaFUvUlZLODFUK3BCOHBrKzMzS0dPU3RXelds?=
 =?utf-8?B?RGxBUFdPZHpkbkZ3SzgxTTNseUZtN0JYK3Y1YUtFU2RvVjRLMmtxcThoQVpR?=
 =?utf-8?B?WlhzVUhmeXJaVXBDdno5VlB1Y3U3Wk1qM3dEN3ZmTitPSVFiczRFREk1M2NJ?=
 =?utf-8?B?UHl6bERHdWE0ODdNMnMzUXNEZ1BjZ0ZCMFVGcUlLeWJhMmhQdEpxRStMMXlj?=
 =?utf-8?B?UzBkV1ZmODFYOHhYWnVqTXV5akY3Y0VsMGUyTEJJRGN3bjh2cDBEYUNUVjVZ?=
 =?utf-8?B?RXNEZmtHTWpsSkllQlVYTUJWbWN3QnR5eWhoV3FLbkV5aDJDRXYwUTVHOGlE?=
 =?utf-8?B?VHFtTHVVUExwZ0dGWExjOFJ1MGZvYURuMG1LeUVONWdidHQxSmI4MmdXd0hK?=
 =?utf-8?B?a0M4RW4razdwdm9Zc29sTGE4WU5qRHhoL3FPd1B0a2pNNHQ4Y3o2OU9hYzJu?=
 =?utf-8?B?QTlqdC9kUTV5b3dFdmhmWlBnVnltQ2FuL2t5dys1VGNWRXduNVNJd2pOS0Zj?=
 =?utf-8?B?S3J5WFFzQWNyZkxTTXNKZzF4RzhXQURMUnFwY1IybVA5eE9LYzk4VTJIWTJs?=
 =?utf-8?B?cFU4ZDFSRlhBMDYzeGRqU1NzSkFWR252R3VoMlZKR1NIYkpiSGFzNHNUU1cy?=
 =?utf-8?B?V3l1MmNibkJ5dXhGbk10WlpIL2F0My9sRkxEeE0zTDY3aUdyRUczZnl1Mnpj?=
 =?utf-8?B?OWptNlpFQlpyQVRHU2FzalBBV1Rkazl2NzdMOW1jL2Q0di9JNmhuUFlWMUpn?=
 =?utf-8?B?MHBZK1AvKzBjWlMxNWs4T2lweGt6ZXJXaXgyWE5FRGU1N01qVUpRS0tFemJv?=
 =?utf-8?B?d1ZiNDhZbDc0c2wyUkpPaUtoT2pUbi9JR1h0OWN6UXFNY2NRVW44OEg5SzNu?=
 =?utf-8?B?SE1iVzFQSzBFVEVBdGFFL0ZwdW1iMXkwWnFITXdQeDZCeXYyUVFDem1pRHRy?=
 =?utf-8?B?YkJLbGJZSHprWjRHeVFveEdiR0YrYVJndklOSURxdnlFZS9hTngvektoRzhJ?=
 =?utf-8?B?OEtXUDBSTUV2RXFYRW9wb2t6RTZrUzZoRFl5Y25Kc3U4ZVZXSUY0SEh2NkQz?=
 =?utf-8?B?VUd4OWM3Y2Z1WHJIT2lucXgvZWJuWlY3eHM0SEVOU3ZFcVljZ0NweE9taXBZ?=
 =?utf-8?B?eEkvak9LRklqVXBGWkNXTjRGRXUvRnZhcnRoL2NjY1BJR1RZWEZJTGh6N3lN?=
 =?utf-8?B?anIwQkxKSEtzSXZTTVdSVmpjLzM5bm9GTExGWGR4T0dOK2g3U0tRUURlZkNj?=
 =?utf-8?Q?/BudzQBhRELcYuevKGEtpwAdz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be2fbf5c-6eac-4fa6-6034-08db305c69c5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 13:49:27.4606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MDil23a4FLwqLpRaCaDO+4e8ltZuDSHHTSl9TlcaXChEXH+S7di3U6CfhusA8G3SOW3y6X3F2jF/YNtcX1UMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6877
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/23 21:59, Wu Zongyong wrote:
> It seems MOVSXD which opcode is 0x63 is not handled, support
> to decode it in insn_decode_mmio().

Aren't there some caveats to worry about with this instruction based on 
the presence of the REX prefix 64-bit operand size bit? Sometimes it can 
be a sign extended and sometimes it can be a zero extended.

Thanks,
Tom

> 
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> ---
>   arch/x86/lib/insn-eval.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
> index 558a605929db..db6f93bad219 100644
> --- a/arch/x86/lib/insn-eval.c
> +++ b/arch/x86/lib/insn-eval.c
> @@ -1607,6 +1607,10 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
>   		return INSN_MMIO_DECODE_FAILED;
>   
>   	switch (insn->opcode.bytes[0]) {
> +	case 0x63: /* MOVSXD r64, m32 */
> +		*bytes = 4;
> +		type = INSN_MMIO_READ_SIGN_EXTEND;
> +		break;
>   	case 0x88: /* MOV m8,r8 */
>   		*bytes = 1;
>   		fallthrough;
