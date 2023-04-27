Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85FC6F071B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243909AbjD0OQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243700AbjD0OQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:16:55 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D663D170A;
        Thu, 27 Apr 2023 07:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5yVd9DUWTLvsobdFWRcFNYTj412GKyec8QXKiSESBwv8m5dqCfAaAC5jMFL5hUFVRnm1KhPg5Hju0OT/c7mYskyd0I9CdIkiVmPlnC90Y2ez2XVeuZcFpajckql6Wp1yqzrtzj5Kvt9iSpM1zByyV5B7Dn+OZw9wpTiADTElLryH+gXW+ksyqM3z2ijo8TmRdO7SR4ez4TjknbowflzZTRt5cwCOIQVy3hTCMLm42Cg4rMCNe114U6s6QJw53pMUrN/vddiuC7Fc8lMnUF4K28GrGnxSkB8hWHkaIa3hCFka9tC2Y0UQ/hyMRAXCr8yejOsygXEblOkH4UZGVJPKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4pZ4jH9OnM3OMOv0dRhy/BKnt7vuI+bluZvnJ2Jdwc=;
 b=mlpiYC8ob7G1aXoa89rMCiXQNXo1k64Lef4mWBR3AILib7gtuNYbKtjcHMZPmY7VXt2tIQsLyjwRVxK/fu4nteJmKCAB7EMsOHb9sodh+tXsa1SVGPCAK9ouTq+xdyZqdWs2cCbtYa1OJsk7hcp+Nl2q4nPJD2YAWixIpe+FhleEGkkhiK9CilSPHAcRC25+PZJmhFc4aeHwANpVFWnAHB2isqVyJIgl5x6e+mAXLKhG61LNmTYDXdLK2+MIK76YksXhUPuFrerVh7188R5yDPsl0L4no0tXZ01C+w8ZnClQ5HMnPDVDr175zrEDU6rbbfEr+C8Dfdov355zCX1PMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4pZ4jH9OnM3OMOv0dRhy/BKnt7vuI+bluZvnJ2Jdwc=;
 b=kRgE7nlFLiuum25xepuKtOk/y5PKgdXdW12V/rV1ttdz3kZPDeaxy5sTOSAmgcufu8kWA44vw7vIh6DIcpud/x8pUvgP7NB+yGMn50LqdXRq8q2as/Ua0CK/0+Cv+xV/kWX/8fuWxuWfVAXJMRwARVbPBufPG0LSQ2Tj+6x07QU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by BY5PR12MB4869.namprd12.prod.outlook.com (2603:10b6:a03:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 14:16:51 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::fcfe:62dd:e938:3a84]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::fcfe:62dd:e938:3a84%7]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 14:16:50 +0000
Message-ID: <c99d6a6b-cb8b-c62d-7305-6b739a8c0671@amd.com>
Date:   Thu, 27 Apr 2023 09:16:45 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] docs: security: Confidential computing intro and threat
 model
Content-Language: en-US
To:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
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
        Ravi Sahita <ravi@rivosinc.com>
References: <20230327141816.2648615-1-carlos.bilbao@amd.com>
 <ZEfrjtgGgm1lpadq@google.com>
 <DM8PR11MB575046B6DAA17B41FFED8080E7659@DM8PR11MB5750.namprd11.prod.outlook.com>
 <9fa5ce43-584d-878d-227a-fb458254c00a@amd.com> <ZElIjw7Ca6N2mYHe@google.com>
 <9021d861-cde6-a51a-7d8c-b3f67eaa01d8@amd.com> <ZEmBULXp24oMxaUH@google.com>
 <04383d21-b71e-93dd-5f4c-b39f5bc21937@amd.com> <ZEmYR0fWl05lGW0d@google.com>
 <DM8PR11MB57502652613A19C1A65D10BDE76A9@DM8PR11MB5750.namprd11.prod.outlook.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <DM8PR11MB57502652613A19C1A65D10BDE76A9@DM8PR11MB5750.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0116.namprd05.prod.outlook.com
 (2603:10b6:803:42::33) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|BY5PR12MB4869:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f322078-a388-4ae3-9a6c-08db472a0b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zZzBAU41PU+58kqlme3oFp/WoYBLQ1gEghvcaTVgY+YDfGB0gkEaA2Ra4PKReaeeFJjVe/+1ZWPNvnMON/FZfkjomZVMcLPJv8s/J/HHjyAOKvY7zBoP9vvplO/PsfigidhFEeAYOmoxRFny5k7qbDYR+rWXrgdNRhfWnC0u1QdfJZKxaSVE+xVjy6Uf7std9d2Nu8iiOCkd/ZRbfONysefa/UYjuEt1LJauD3xLRRiQwqMJm6i2QIW7WOJuu2IoQLxIViHyRaH/FWcYMeG+rM26aMxDiW7rNsavWCKMLcBRm05b0uA6JTvzCI5/tmbILrfF2vw8hypqygN4TJQpea3mwa/VFdlEL0jI1qF55a5MbGqDPUpJWPMjzUjte0u23n3CKUf99SPOmPpu8GHFozPKAU+b0d0y/ok0O1hvYu42KYt9kH9m8DSwP8C5RF07FZQQyv0Y0voq1LFdm6vfVKhtEU51DxODAAKc5RwpcE/g8ixoVIB4YT1LgKJd1BPVo2kInAtAsh98CQzMW46IL8mvi3wNuPQgssRs/WVYxj2DapRQPe7ptkJLzVRmw3V3BmIr2MpWqYZlX5iMmLIrPXNartlEJyRjxi5n7ksU8vIUH04wmR2i3u1kb/G+eWJEDHtE4EJS8OHWRbl7e6xNuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(186003)(53546011)(6512007)(6506007)(83380400001)(38100700002)(36756003)(2616005)(7416002)(478600001)(44832011)(5660300002)(110136005)(54906003)(7406005)(31696002)(15650500001)(316002)(66556008)(31686004)(4326008)(66476007)(66946007)(41300700001)(8936002)(8676002)(86362001)(6666004)(6486002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHB6d0NEZjNWUDdLYU9aWXBNdjZJSG9OR0hTcnZzK3dTSWpzNGhscS8rQVlS?=
 =?utf-8?B?YkxkdUhZM092NWZqVlFscyt3Q3hHZC9IYzZoWE82Q0xpVyszRHl2MmZ1SUN4?=
 =?utf-8?B?WFlQblZVd1Rzcm4vbFhUUVoyL3JnaUZnNXdIMkVuRCtDWGI1TTlHd1Jlcytv?=
 =?utf-8?B?M1YzZmJPWFlvRUlpQ21EZGs3d0ZrNTZ1WjZ2cDVnV01vbWF0WDlNRjBiS2Ju?=
 =?utf-8?B?YVQzRnZtS0dFNFBReGhTNTlWQVNjb054TlFmbk4rMG1SWGg3YU9pcHRLVFpC?=
 =?utf-8?B?U0lSVWRuMlIxVi9VYWhNb2tiWXpWTzNGYXpzaXlHMkpBbjZqcHIvUDk3Rmw5?=
 =?utf-8?B?WGJlZjkzaW1hdWxKTk9vdjFzM0t0dW5GanNHQUgxWkNLNk1xUzVTYWttSGdH?=
 =?utf-8?B?a1JocXVML0RiUjYwVjBEd0oyRlErZEZYWmNNNjRvTUxnbFI3TkxOa0l5cUQw?=
 =?utf-8?B?YnNnUldFMmFqWU12NEJPbmRHTG9yZWRHa05nMEpZWFM5YUVBTGptUGJtblRk?=
 =?utf-8?B?K2YxMTFyN1NjVUI5M1REWi9kZU1Ba3E1UnhRVThJVWNZc1FWaFZjZ2syREdw?=
 =?utf-8?B?c28yRHl5UnBvMTFKdnVaS3loVUE4LzlmbHBJN3ZIVHBoOUdWTWgyUXBObGM0?=
 =?utf-8?B?dkFXejdjb0lzUXdmRmVyZk1MWnJ2MytBbCtRS2xIdWhiNmxtUFVDcitVQUlr?=
 =?utf-8?B?UGV5b1JueHMvOFplOTVTTCtHaTVuQjlBbHFHdUM3MWNudDJRMTdEMVF1VEZl?=
 =?utf-8?B?Vm1wSUIwemU2eEhtMXBTa0thakt4K3pMcTlWUXhHcTBNVE5ySGpTdXFReWpP?=
 =?utf-8?B?ck1mYldZVEdjc2xCOXZ4dVJpZks5bUlvWlNlczN0b3VNaHJNM1ltdE1pUzRr?=
 =?utf-8?B?azZjaHM1WGVxOWFJZUtRL1RZbmkvdmJqMmpJbDF3eHRaQTlTQm1qaVgxUnds?=
 =?utf-8?B?aDUxK3puNXNGb3UvRFpzVFE5SmJqVVRaM2V5STFEVmFmcG9UWGQ3MHhmT2pV?=
 =?utf-8?B?OVFzbDFaUUdMb1ZES0ZNVDJ0b2lxRzZsSVdTM2NoTTZVckZJUjZBd21xL3hB?=
 =?utf-8?B?MUJPbDJ6Wk1NbjZaTjgzRVYrMmkvV2ZmS1lEUS9NV3ovR2c0Z2ovVXBwQ1Ry?=
 =?utf-8?B?b3NVZmFrWGdkVElwNXlsUE5LMzNhNzJzbVo3MlAyajBmUlhzcWIyVk8raW9t?=
 =?utf-8?B?N3R5TXc2V1A3RkNqbTNXd3JncjdCdTZSYTBJV1dqNjhXNTJ5L0I1T09ENDFN?=
 =?utf-8?B?MXF3VWJjYU4zRDBpbjdBT1JYUUcrSnBydTlWM2NOV1daTUp2d2I0KzBiNCtY?=
 =?utf-8?B?Q0NLdU95WlorQWVqbTRSRjRmdXZCTit0amxBMk4rOEREWEhVLzExRUlUNGd6?=
 =?utf-8?B?U0hMZEJuMzVZaDQyZ09hS252V2g2TWMydHFyRUZreCt4eDdGM3FVVFZSVjln?=
 =?utf-8?B?ZlVQdmUrVmswZlNMekVJTVh3MTdMT0wranhkM2wzRE5ieTl0Uk9Zek9SZWN3?=
 =?utf-8?B?aUJsLy83QzBKMjdzbTRGdDV1MG13QnpxQ0tsanB6U1liL2R6SEd3RCszRlo4?=
 =?utf-8?B?RVhJMHpsQ2k1L0VCTDFPaVZzQlAyQ3hWMlMvRTJBUmZqWVRtdGRrNW42djdn?=
 =?utf-8?B?b2xsZDFZd3orbUxZelVVWVdpUjZSaEV3QkFheENrUVNtL094QWdQdTFHeTkr?=
 =?utf-8?B?aDNpU1owcDJCbDFRNkJiZ21FYTc2WEwvZE1iVzdVMTA2cmVaYmw3eTVVVCsx?=
 =?utf-8?B?TGNtTE45TnZYdGNIeFRhSVMydTduNkNHNGx1RnFNblBEM2hadGdTRzFXeEh4?=
 =?utf-8?B?R1R5TXZoekU0bS92QVNlYVI0cjlrQkNWd3ZIZ3B4aUlzdm02NmR5ek42YUZz?=
 =?utf-8?B?akJvcHlWeXI0OTkvOTlibWRMM2EwOFh3UW45VkpBTmJibnkzazg2cjRoeVcy?=
 =?utf-8?B?VE9uZmpoQjNqU2w1YWthMmRDMWlrWGtab0tHKzhZQ3JSaWFrQnpmaGxKcUM2?=
 =?utf-8?B?N1FFMXMzaEU5cVlIVDZwV2hKdlp5VnBkblRja1phMnFLUmVRUVIyZXAvZUds?=
 =?utf-8?B?WHNSQUFBTGlpaHRaZDBCRkVXWUtiOXhDTmtUS2lmOGdueWZHWVhiRk81YUFH?=
 =?utf-8?B?RFk4SGgwdmRlZWhyamJqeWpHaUJjV0NPcFJFVkxDNVRIOC8xZGFhWThPbHlw?=
 =?utf-8?Q?NLBjGWB0oa95CmRWsCQrSuXD04uiQEDcvim5YzFYdyvs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f322078-a388-4ae3-9a6c-08db472a0b29
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 14:16:50.7568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+MdpB+7OMM3MuI0InWgqs9hlNNw4/6vLlLAqiNf8VuQpg3TsFoUd0iIcPsuSLI+lEF18JpyV+eeSdqfH/25eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4869
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/23 7:29 AM, Reshetova, Elena wrote:
>> On Wed, Apr 26, 2023, Carlos Bilbao wrote:
>>> On 4/26/23 2:53 PM, Sean Christopherson wrote:
>>>> On Wed, Apr 26, 2023, Carlos Bilbao wrote:
>>>>> On 4/26/23 10:51 AM, Sean Christopherson wrote:
>>>>>> This document is named confidential-computing.rst, not tdx-and-snp.rst.
>> Not
>>>>>> explicitly mentioning SEV doesn't magically warp reality to make
>> descriptions like
>>>>>> this one from security/secrets/coco.rst disappear:
>>>>>>
>>>>>>   Introduction
>>>>>>   ============
>>>>>>
>>>>>>   Confidential Computing (coco) hardware such as AMD SEV (Secure
>> Encrypted
>>>>>>   Virtualization) allows guest owners to inject secrets into the VMs
>>>>>>   memory without the host/hypervisor being able to read them.
>>>>>>
>>>>>> My complaint about this document being too Intel/AMD centric isn't that it
>> doesn't
>>>>>> mention other implementations, it's that the doc describes CoCo purely
>> from the
>>>>>> narrow viewpoint of Intel TDX and AMD SNP, and to be blunt, reads like a
>> press
>>>>>> release and not an objective overview of CoCo.
>>>>>
>>>>> Be specific about the parts of the document that you feel are too
>>>>> AMD/Intel centric, and we will correct them.
>>>>
>>>> The whole thing?  There aren't specific parts that are too SNP/TDX centric, the
>>>> entire tone and approach of the document is wrong.  As I responded to Dave,
>> I
>>>> would feel differently if the document were named tdx-and-snp-threat-
>> model.rst,
>>>> but this patch proposes a generic confidential-computing.rst and presents the
>>>> SNP+TDX confidential VM use case as if it's the *only* confidential computing
>> use
>>>> case.
>>>
>>> What part of us describing the current Linux kernel threat model or
>>> defining basic concepts of confidential computing is SNP/TDX centric?
>>>
>>> IMHO, simply stating that "the whole thing" is wrong and that you don't
>>> like the "tone", is not making a good enough case for us to change
>>> anything, including the name of the document.
>>
>> I honestly don't know how to respond since you are either unable or unwilling to
>> see the problems with naming a document "confidential computing" and then
>> talking
>> only about one very, very specific flavor of confidential computing as if that is
>> the only flavor of confidential computing.
> 
> This is simply an unfair statement. I replied yesterday on this particular angle, i.e.
> let's think on how to name this properly: explained our thinking behind using the 
> "Confidential Cloud Computing" term (with references to academia using it) and asked
> what the better name should be. I didn’t get a reply to that, but here you say we
> are not willing to cooperate...
> 
> So I don’t think it is fair to say that we don’t take feedback! 
> 
> I agree with Dave that I think the goal of this document is not to come up with a
> fancy name (I am fine with call it anything), but to introduce kernel developers to the 
> new Linux threat model angle for this-particular-use-case-of-confidential-computing.
> So that when we submit the hardening mechanisms in the future people are 
> already familiar with why we need to do this and we don’t have to repeat this story 
> again and again. 

Yes! To reiterate, there's two things we definitely wish to do:

1. Narrow down the problem: This new document can be specific to CoCo in
   virtual environments. v2 should be clear about that.

2. Gather feedback: we already received some input about potential bias
   toward TDX/SNP, which should be addressed on v2.

Thanks,
Carlos

> 
> Best Regards,
> Elena. 
