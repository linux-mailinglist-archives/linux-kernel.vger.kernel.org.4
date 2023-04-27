Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98646F0BAA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244293AbjD0R7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243708AbjD0R7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:59:20 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDF53A91;
        Thu, 27 Apr 2023 10:59:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7DfTTt2lnLiamPjtmjVAQPixFZRv/iWHqCi7EARrMXYKXzJILBozIbTpuqvmJwTkV9ETBOSMoLJLaXiwyCRrGDdQrruupHVrzIOBNDdySYaJeTOpXMhnZm9Gf69ICcL0vxfHBJ4UbLcUGy1Cn9hxSZN/lODEh0WXQpB3lROutOelGESdcDCq9RlvqbxJl0PE6nBs7W+RWeiTN2CRn+E6ZYlIwuHucTLTYViBPIaODF26EfIT7N3YxnpP+yb3thkYyXlkRRQDhIan/gXzJ4OL3vrmC2kT9tz2TXa/TNHJpp92KY2qfaDxhMY754+pIzB3bxWiMxTDXurJFptJtsabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIUqSxTOMAtKAepGZPw+pOk9t7NryFZndtTZ8aZ7Q+Y=;
 b=UrXQpSgxtmVoQSOTKa7JmO3opYOd3cFPMAdXWZHnoaSl0nA2CrUhpZxez/DyKpSduDHsNU4h+Z0p+8SI8+4v0013LMf6IbpW7kpvTcZb3xC7uMarX+zSB1PpaFxBkisc0bQBFO/G+UH2p+wyZILXVhYq0hZlcHSBDYnAkwcE5t7oCu+ZPzir0L2pLI6/cZUB00wxU027EKgwjQwsMGSVLje4/1ziJbsThV23mjYd00qbGZEA5KbSkQVo8//jIzazhqq62iZ5gdqkU386h3cxfclIkf526OQdIJu17nKn6cmWvYVm8zqU7JLKowH4zAgoZ84/syRdhfvk6TF8JmQRzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIUqSxTOMAtKAepGZPw+pOk9t7NryFZndtTZ8aZ7Q+Y=;
 b=Q3+lQQ1geY/3/Vb+eFMm99qTQswIxwWVMSagp0r8COwgEUMJRPu0C1ALjrr9hxeNWgSFh2lqDro3rPouVoM/5mLzyXt29r2vsIHD1/6y+zjXu1CHib/PkKpaUzwNcUCeQtRJh8I9OAzGsrsY+a7+hjbs2x39sbJxyMdjcDpCFoc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 17:59:14 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::fcfe:62dd:e938:3a84]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::fcfe:62dd:e938:3a84%7]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 17:59:14 +0000
Message-ID: <069c8e3e-5776-b350-7a61-c86e4e448c1c@amd.com>
Date:   Thu, 27 Apr 2023 12:59:09 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] docs: security: Confidential computing intro and threat
 model
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Elena Reshetova <elena.reshetova@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
        "michael.day@amd.com" <michael.day@amd.com>,
        "pavankumar.paluri@amd.com" <pavankumar.paluri@amd.com>,
        "David.Kaplan@amd.com" <David.Kaplan@amd.com>,
        "Reshma.Lal@amd.com" <Reshma.Lal@amd.com>,
        "Jeremy.Powell@amd.com" <Jeremy.Powell@amd.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dinechin@redhat.com" <dinechin@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "berrange@redhat.com" <berrange@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "cdupontd@redhat.com" <cdupontd@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "security@kernel.org" <security@kernel.org>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Rajnesh Kanwal <rkanwal@rivosinc.com>,
        Dylan Reid <dylan@rivosinc.com>,
        Ravi Sahita <ravi@rivosinc.com>, suzuki.poulose@arm.com,
        atishp@rivosinc.com
References: <ZEfrjtgGgm1lpadq@google.com>
 <DM8PR11MB575046B6DAA17B41FFED8080E7659@DM8PR11MB5750.namprd11.prod.outlook.com>
 <9fa5ce43-584d-878d-227a-fb458254c00a@amd.com> <ZElIjw7Ca6N2mYHe@google.com>
 <9021d861-cde6-a51a-7d8c-b3f67eaa01d8@amd.com> <ZEmBULXp24oMxaUH@google.com>
 <04383d21-b71e-93dd-5f4c-b39f5bc21937@amd.com> <ZEmYR0fWl05lGW0d@google.com>
 <DM8PR11MB57502652613A19C1A65D10BDE76A9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <c99d6a6b-cb8b-c62d-7305-6b739a8c0671@amd.com> <ZEqSRTirPCxjy6M4@google.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <ZEqSRTirPCxjy6M4@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR08CA0008.namprd08.prod.outlook.com
 (2603:10b6:805:66::21) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: de3bc4d0-1cc6-49ef-5a7a-08db47491c93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ov1GOi9VftN9gZcsTKZz7xJuMc4/TlRx6NaucFZ/x/TSnKIwJaYmoY6awr5ofYS9eHxqmNN4VBVw2uEBhjGM6Jo5I1ohHuODz/f8UBMSCY165i2kHdfoZvo4iAahXtmgrFwrEukdyi/Sqp31LchJVPZuwv9vr/H+ahUcBg8bFVY68q5SFNupqwAoTxQbBfIdMzhe55/bvrMgk7//mhS3FXMZf2a2iJ6l9l7+7oyrrfgD4EF0x9sb/Pu/kbJt2vnthu2kjM1hziNuk5+yyIRbA+KB3GeTVBZG9qGO1dCLWwY0oLT7h72VYo6dFtARvvQ5GPqPxCOHtVs21+Ix3bLIb3mNgpmS91BUNJWxZvmq69cCfUC5Ej0tqDWth1+TXhGYG/Keazk88vdL2D9aBRPzR6P5kJk4j232uARSWUL0EwR0xjZgvRHr/x62qFXfABG7ZSdZf0+XLwN7hGEh+NygUYT4klTbgJU7Vo9RpHySOFOnwwgOljJUfp87CxanZ0oJdMaPGKBs25TXiu/GXVL9rq4EPMsxk/eGUK9U/X/2g2/2Dsmv0pZKJqaukittdDlHca57fGLlW6XtC/M1HqMAAakgmYG9FfQEtuG/N6ux6pu1fvAJgPkMkXoUnTcGGup0WEJhL/EX0X731Li/sn3TSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(31686004)(2616005)(186003)(6506007)(6512007)(53546011)(86362001)(6916009)(4326008)(316002)(66476007)(31696002)(66556008)(66946007)(7406005)(44832011)(2906002)(38100700002)(41300700001)(478600001)(54906003)(8936002)(36756003)(5660300002)(8676002)(6486002)(6666004)(966005)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWJYZytJMEdBbWVwZkFiM3RzeDEwSjJ4WURJelJka0l4cnkzVEdWZGJZNmhT?=
 =?utf-8?B?U0phN0JrcXZtSG84UklOUEZTUkFxdmpEdnpkOVdSYWpDYmRlZVRsd2tsSSsy?=
 =?utf-8?B?RWdTN2VSVG1LdnVTZXllOFhYR2VpaGk5R0hRK1NlU2ZDYStnWk0zdHBoOWRI?=
 =?utf-8?B?TFloVEdicmxPQlF0UG43VDBvdnhaWjlWcW15aEZucHJmUnFzMlVYTjhTVDRn?=
 =?utf-8?B?MkF2TENzaXBhYVp6T0l1MW9TZk5KVlhDemxIWW41R0FFRElHSXFVZFl6MXh6?=
 =?utf-8?B?UTJScXBVeE9qK0Z2ZXhSVjBQM2FPS2FXL0pZWmZUOWR4SkFyWHBJZ0dmQVhU?=
 =?utf-8?B?djYrR2RXT2Y4UTV4b1VyK3ZKc3BBbnVxRTlTUStUbDV6S3IyUzJYZmdCQXMy?=
 =?utf-8?B?aVk4aDNVOG5HMXIyb3FYeVVrRlBQU1dxMExxZGsvNGlnVzJRZzZEZ3ZUZjg1?=
 =?utf-8?B?QSs5c3ZScjlLL1dyZE9CeWp2NER3VjFUSE52UllVdlVRakMrSElnNGZBTzFR?=
 =?utf-8?B?MmJ1S1dtWXJLYTlCYnF1c2MyLzk3dGFyQkJ6NmJzOG40aWdQMVRwK0NicGs5?=
 =?utf-8?B?bmZtY3cvMU5lTFoxbGxnUW9qUjJ6TG9VVnZveEYzODNhbkxJRGJoeG84bDVa?=
 =?utf-8?B?UGh4a1hmMXJQU0M5OGFGYzFIRnJjVjlwaXBxZHRQWDlBc2cwbzU2Nnpic2Na?=
 =?utf-8?B?eWE0dGVXTTNnanhBdEdtK0ErZk9NdU1RaXc2NTJpczFMcjcwV2V1Yml1b1Jk?=
 =?utf-8?B?YU5rTVI4WHJEYVdjQzJBSGM4UWtiRVR4QWFzVHhUd20vRHNIbktDTUlMSUIz?=
 =?utf-8?B?NnJrSEpqc1NmL0t3SkpNMFVFU2ZMOGg5VkYzZ1l0Z1l3aStNRmkzY1N6RDZI?=
 =?utf-8?B?QnhzckJ0YTFjVHJhcCtxdjRFa0FHM1A3NnUzQXBDNUd2WDl4RWlCZE1rTnBn?=
 =?utf-8?B?MW5JSnpTeHhCZ3ZhcFEvYVFTTklLTUh3R2Q4dWE2cE9EdmlhNkI0b3hNYmtH?=
 =?utf-8?B?YWx0cmZPc2JpeVdiY3RsNlJBbmpQVDBrSDBha003RitOTFZhOHoxZWJtRkw5?=
 =?utf-8?B?KzkxdFFXL2tRWHltZHpCVDhZQ3NwMW1FNFhZaG5KZGR5OUE3c21pTWo0TklY?=
 =?utf-8?B?VWFJM29GVm5VOGtlRDEzcjFlT3AvcXcvU3JHZlc4SmplNkxMZ3BTNmdIU24v?=
 =?utf-8?B?dldxTGhybVlLa0hNZDFyR1Z3aXRsZEQyb0JPR2w3eVRISXloYTJXc2dNR3ZC?=
 =?utf-8?B?dldmSTY1MlR6a2p4dWhKV21wUG85TFVncXQ5dXBKbElRZExza0Y5UFp5MGJN?=
 =?utf-8?B?QVMxdUpWRDJGQ2UyajA5YnhLWC8ycStUSXpNRi9OZlk3ZDNjc0tOemExK25B?=
 =?utf-8?B?RXExWWlnL3FmbVI2WmRaRjUxN3l0Vk54QTRKSEpqWWFKZ0cvU0ZBSnlOanc5?=
 =?utf-8?B?QStsZktxd1k0UVhqdUNBZlNDNzFRNTlPV3JHWStKWmErY3JlUndLZzdtMTMw?=
 =?utf-8?B?RlVHb1NnU3pTbzFSUjBhbWFqSmFvT0dLV1pUeDdOajNQalYrNDMyeDN1cis2?=
 =?utf-8?B?QXo2OXdLMUtmUkt1d24rSnMvc3hhVGQwS2oxQURBZFlubWNuRW51WkpodW0z?=
 =?utf-8?B?KzdVTGp4eStsK2c2dE5Yc2NRTGUvUTliQmZZUTVoaUJTOTFTTGIxbU5TK0c2?=
 =?utf-8?B?WjVsd0U0ekRhSW1JSjdRUjJXR0pPMHVScm45dFVGandoeGlyejdOVEdNaFl6?=
 =?utf-8?B?ZC9VL25wTVpsa0FjTUlzb1ZNMGV1UlpaMDVtVUJnZHNsNE9VekRuSHJJbmdL?=
 =?utf-8?B?VUsyU2FMME1uekYwZkpPeXRmdE11TjI0TGE0dktWOWFadCtaQmQvanhHU29i?=
 =?utf-8?B?S0VuZWJxQTRKYjc4cFBscnVjdTNZZlMySjlMb0VxZlI1cSthaXh2TUZzUTJh?=
 =?utf-8?B?MzM0M1BUU3ZHR2lMUHhHK1JFUUxYZ255b3BpbEZsT2pVTk5LV2VtbzBvRkpT?=
 =?utf-8?B?VnBLSmVPa0o0RWtuTVQ2SFZiTS92MXBGZFZDMkE2UVhKVGo2OEdaUGRsNVBa?=
 =?utf-8?B?STBYcEYzWU5ma0o4L0pHdWphVHNwR2xiSFJuNlZPT1ZuSFBycFVJN1hCclgz?=
 =?utf-8?B?U2xCeTNwZ25jbkZKYTNxbHF1N2xFWnFkeXRaNTUyWHRnVEM5czhSYWJudVJ2?=
 =?utf-8?Q?OwfwQvkAyUTDbvFhj7lg+f8JUWHLEuLM0swNbwlI1am8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de3bc4d0-1cc6-49ef-5a7a-08db47491c93
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 17:59:14.3132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNlEDWTcN2str8Ou8iG5Jg8LE2UVCAI/ORx59jeJVOiuUsOFFdr4E1Qu0AU4WEwdXyiLA0lwF/2nq2dmLVOhrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/23 10:18 AM, Sean Christopherson wrote:
> On Thu, Apr 27, 2023, Carlos Bilbao wrote:
>> On 4/27/23 7:29 AM, Reshetova, Elena wrote:
>>> I agree with Dave that I think the goal of this document is not to come up with a
>>> fancy name (I am fine with call it anything), but to introduce kernel developers to the 
>>> new Linux threat model angle for this-particular-use-case-of-confidential-computing.
>>> So that when we submit the hardening mechanisms in the future people are 
>>> already familiar with why we need to do this and we don’t have to repeat this story 
>>> again and again. 
>>
>> Yes! To reiterate, there's two things we definitely wish to do:
>>
>> 1. Narrow down the problem: This new document can be specific to CoCo in
>>    virtual environments. v2 should be clear about that.
> 
> Then rename the document as I already suggested.  If you want to claim
> confidential-computing.rst, then IMO such a doc needs to be written something
> like the surprisingly good Wikipedia article[*].  Until one of those two things
> happens, my NAK stands.
> 
> [*] https://en.wikipedia.org/wiki/Confidential_computing

That's "mea culpa". I should have made it clearer in my previous emails that
changing the name is a non-issue. Also that we are very interested in
feedback from other CoCo flavors. In this regard, we've reached out to ARM
and RISC-V folks. Hopefully, they help us improve the doc and we can add
them as maintainers. Whenever we have a v2, I'd like to CC people from CSP
sector (Oracle, etc.) as well.

Thanks,
Carlos
