Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396555F5560
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiJEN3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiJEN3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:29:04 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ECD79A75
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 06:29:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGgZjtxNGpmSpHbIlkVL9bbStiqsF+M/cTz8ad/HWBe8Nc/U1desGJTUvCETk94pYeXbp1V+CrMEPJ+kym/68OWSb0AKl2jZViqJLDbRSa4EUU90gclCbvGQgPANa8gb9NI2L83bJHaeZvrJ/rPtWYWjK1B0+c4YEIa6Q0A8j6DfqeBycQCqKR5Opk0zi2f16Fy87jFZH91w/kXjXxCCQsNWkjthhiZn7S3zc/zGmGeRe9BS64WU67d3Jc5slnO/8k9xaw6VUykafw14CYVjxS+Su/NJxoQm9towADok2D3xqyDyfG8UMiw+mv63WhLM84wmLFX6oKk8yThHF/PDjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RW0gisH9OSvlrlYJokWS7fwQxx10o+/QbVE9qD9VzWg=;
 b=JyZTABQDNH8L4bfwhvSVxI4Rz4BJgA0f+vASdImGs3nTPaExSxa7W2bMY4zR0Q5FfYL4hUe1WZViq8PnXvdo218XcesM0dp3x0l309cxJojhtBl1flUO8MRP/BhE2aUrG6BKpfoAIOOZiI8OwFtF0kQG7IP64Z2T1BE8q+5b2F8fwLJ1HozJgNEJGb5HuiqcQJMwACOP+uOU2h/Ou6fkVniVve5py5qBABZp4Kd2PeccV0VPPD90Vi8CeZiriovkg5QmUGItNXJG2604hlPQ8UZXOBcKCxscMlGD4OpMtRUtOHoyCH7cgKFO3NSxWu7NzkxN3FB0V0wJob0Y6jI3Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RW0gisH9OSvlrlYJokWS7fwQxx10o+/QbVE9qD9VzWg=;
 b=OkSy50+jDSOpHPiBbDUYDAv/9S3en9cinZybFuAUSIRtz8Uh8J6cJ/pY9rETIfOSXIYImzs4Jb7pluIdc9dXkwbtWtT8ok8dM/xYture7Zyt0A68H/8+msIVKv/T1r+6aizUmgvHj44bnprhcRSHkOWL80ak+lfS4W0SNycix3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BL1PR12MB5061.namprd12.prod.outlook.com (2603:10b6:208:310::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 13:29:00 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396%4]) with mapi id 15.20.5676.033; Wed, 5 Oct 2022
 13:29:00 +0000
Message-ID: <81950d38-4d5a-6902-bc2e-327d2800eb58@amd.com>
Date:   Wed, 5 Oct 2022 08:28:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 RESEND] x86/asm: Force native_apic_mem_read to use mov
Content-Language: en-US
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Adam Dunlap <acdunlap@google.com>,
        Peter Gonda <pgonda@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ben Dooks <ben-linux@fluff.org>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Jacob Xu <jacobhxu@google.com>,
        Alper Gun <alpergun@google.com>, Marc Orr <marcorr@google.com>
References: <20220812183501.3555820-1-acdunlap@google.com>
 <20220908170456.3177635-1-acdunlap@google.com>
 <CAMkAt6qUs526FCq26Ht48c2KVZWe=QcNds6_LE6JJbs-7Hzk+g@mail.gmail.com>
 <2625dbfa-434c-7d55-6469-9d9e89397e8f@intel.com>
 <YyH/tOqrl8pZmoub@google.com>
 <CAMkAt6p2Y=6sBB1JiZ2FovYXme9QBFWFu+EtnNyuQ3Db3ZhBSg@mail.gmail.com>
 <CAMBK9=YB=8EQymDUda300qPFAL1=7dzC61c0pshrWEC5ibrUfQ@mail.gmail.com>
 <B7175642-351D-44A0-B7AD-E69C6B64FC18@zytor.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <B7175642-351D-44A0-B7AD-E69C6B64FC18@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:208:32e::23) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|BL1PR12MB5061:EE_
X-MS-Office365-Filtering-Correlation-Id: 71210f31-acfa-4fca-2204-08daa6d59018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +bRuhtVNuTMWgBDi2ocXTAI11t2xK6nPRsNuwXqXth05J8uqVHfUaNjM24Zoib6Q44fIVLQ/8CREIp8Ozh4gd0t4cKslvyVN3Q6YqYkFGlNLSIsv5FJ1c3OtgVd/yA3KfQTj3xu17fUVjncFEjnmzKw0uF/Zmch7pzid42z+kT5IIyJtn9W/fNbhCk13Ug1sgncHcmZIkoRIcKVA368EQxQhINvZBPSk/CkAmGDmBHE0A2sdjo43FoRF3jjYgZE7A2sOon9rsljFubCeWfizGqaGAXRLuMB0OGu6kgqYEpB8LHDAGRuTlywnWv4JR0W98QAbFU+Gw0RjoNx5DHcHQJ5YdLtnXDFJRehni01wuaZKFEa+6rWZGoWTwfutVxRfdvMIK7Qq8kDPrRTbixeKfO3X5IqL/M06izqJ3evuwKFlTUX8dB8FixzAJ1D0Afcy8Mly5z9AZWV2VYGZeyrYv1wCJ7mMuUOXvP6XMvRSThXFeNMSzOZImrasMRrhlHl4NX9dJJ9z19js/NfeyQ1tnb0jOdkJ1waFdm5f55yeOzHjHix1X3mYpInwj8fWQgxpgOGoX+zrCMy6zml26Z0x46skGPtNvdlKsMIZSOn0sBzLwR3ys45ptAkFcUaEXt1rsvkzrZKnpXOmUREGCUZ39fT3MurEqE9m1l6zK0Go+r8x1axoKwox8xbKPB+xpxhtRa5xNOS6x8ekachV1ORHeGEKzLsnKnWEywhxztn0opT3GAzbXcUXVCxScvqy7QLriFynJhK0uoZsM5qzuw8WesV7IEbVjsiYEE8UpG5MGvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199015)(6512007)(4326008)(8676002)(66556008)(66476007)(26005)(54906003)(66946007)(478600001)(186003)(86362001)(6486002)(316002)(110136005)(38100700002)(31696002)(36756003)(6666004)(2616005)(8936002)(31686004)(7416002)(2906002)(4744005)(5660300002)(41300700001)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU1qZ0VGUEZqcE5Dc1hGbE5kVnExNnc2S2ZEUUJNdUZQdEpZMlE1YWk2TDh0?=
 =?utf-8?B?NUR5SG5RNkZqSlFsRkFvTURoZTRHejNkU3dhRDV6ZXYySGVESERNQU9YcVhx?=
 =?utf-8?B?VGFJMmJPdWhJRFZrMTkwTEVUSXNkZFhrRGdHWXZIRFUrS2VXL29BekVEQUl2?=
 =?utf-8?B?bFB3Qjk2N3cwN2Ixd0JNdlRQMitRQWNqYWcyRWc4V2ZMZ1M1bHJoNXM4cEZu?=
 =?utf-8?B?OU5vRHVsd3cxNHFMVUUzOEtzVkoxaTFKS29Zb2lxTm5PNDZHVW5KcXFVdGlX?=
 =?utf-8?B?aUg0L2pGRUdJSmt1SU5KY3FrTXpqeVpwQW85UUY0L0FrNTBaakZUUGpEMW0v?=
 =?utf-8?B?UCs3aVIrd3E2ZDM0cEpBa0FvUStydHJwTHBTem5PbjMwMnlxV0dUZWprSTVu?=
 =?utf-8?B?YlpGd0NNU1d5aTFnQUcxQ1J5eHdyNWk3Wkg0cXhEa3U3ZXRHaXlJTjVidGM3?=
 =?utf-8?B?OG42R1l5T0ZXajh0RHdaSVhnMTVldTFMY3VlTHphMnJlemtJYlpvOVg5d3BW?=
 =?utf-8?B?aDE2djE2VndDOXRWOGhUWkxXUTY2WGQveUcvYUhtblFYR3dzNFdFdUVOZjFH?=
 =?utf-8?B?VVJRTFhWUE1NaFZocHpVdGxSVEQrUWIxSkVsTzFzYkJmeUN3WGl4UVEvcExG?=
 =?utf-8?B?bEdoa2cvc1Vpckc4WitPV0VhdUY2YVh4RGZTcTBXYjFaa2JaUDd4SmxrVEJQ?=
 =?utf-8?B?RlBabnhrODJmd2IrV0JyMGcyV2o1U0FhRWlvdHJ0Q2NkaUJ1UHFJVmJyUDUx?=
 =?utf-8?B?Qy9EYlhBZHBCV090VVo1MWNPc3BwNkVxYjdEYUpGeWdSdWtiM2JDTnVHN3hC?=
 =?utf-8?B?VDdORnBLMXJmeGJHeStLOTYwaDhwSGU3TzlQQUFZTWhlNmxEMmk5eXNIajZM?=
 =?utf-8?B?YXI4Sm9oNG85eEdXSEVnMlVJRnE2OTBEdnJtSWtydmJkUzBhR1NkUFJBRnc3?=
 =?utf-8?B?dEc1UUY3TVBiU3MxWnNyMzNjNVdqZnZjaitWT0c5TCs4WUxlZi94eDBHMERw?=
 =?utf-8?B?Rk00Z213eXBnTERUbkt2cjNrbkd1S1NKOVRScnpPZ1NUdWEvYWpRYkhuVDRM?=
 =?utf-8?B?ejBuU2dCT1NMS3NNSE8rczFKWWFXSUdyVzlCNVRyM0FSOGJ5d0xHeEFMenJo?=
 =?utf-8?B?UkFTejYvd1FWRXFWMlNxQUpZWDJLUk5SeFhKVEZhSDBZMVZDL0pYd3ptcGFq?=
 =?utf-8?B?emhxc2kzSlJmMXpIR05hdTBxSmFMMEU4WE1mald0dkFGOVRyb2ZWVStZSm5C?=
 =?utf-8?B?ZHFEVVdWWlluZGFZc1dUeEJQVlNXOThDRUdzY3R6bW5XWWx3anpyVFNkakpv?=
 =?utf-8?B?SlhvUU1GeGJySnJWM2IyTnVTU1JiNFB0c0ZySFg5OEJpWTM3MldMbWt2WVNm?=
 =?utf-8?B?cnFPb2dWUVNobVhRM3M3VFg5YVIvSmZveFVGdGh6SHdsem9wY3g2aWF4T3Uw?=
 =?utf-8?B?dm9KdjdVQ1k0RUVrWlZZMHpCbFM1dzdvM0s5dVlWZ0QvYkdwaGpLV3hPTlBt?=
 =?utf-8?B?ZnV0WHRxUmNzSjJyUytUMzM0SXo3NGRSc2pySDk4STdCZVpsVjk4Rm45ZzJm?=
 =?utf-8?B?MGlBbk5GZzNibkF0bFkzM1pvVnVCRys3U0JMZ1BJNlR5Q1B3QXdOR0lJQm1N?=
 =?utf-8?B?c3pWYW5UNGJYT2R1Y3BKejJRUCtDY01HejdkY2ZiNDlTbTlKdlFLS0lqcUFB?=
 =?utf-8?B?Q1FVRFhWdzN4YWJPVWhCSkpuYWl0ZkR3L2hWUFJsbUZ1WkRJT2JqYkF4Y01N?=
 =?utf-8?B?MGJoUnQwQlNnQnBVYzFYdVBLTFVUVUJ5Ynd2c29SRG5veGxNbzBjNTBjNzk1?=
 =?utf-8?B?VDZGK3BxMElmMXJ0cHZ4YnZvR243WUZMbGNpT3A4b1MzakY0SDR4SEZ3ZEtZ?=
 =?utf-8?B?SFI1c2JuVUVyKzA3aHNjQTIxMWo3aGhYOHNMRDJZcS9keVFHWUI1SmdBMldM?=
 =?utf-8?B?VUllNXNkRVlKdEtpSThhR3JNVFVFc0JMV0lVTTNZd2xJL1hIQ0pzY2g1SXQw?=
 =?utf-8?B?MFd6bTQySGxvd21uamxTbzdwNVdraWcyeit4REJ1RDJXQjk3YmlhTHB0azJ3?=
 =?utf-8?B?L25KendaVkJoTmViZ2VSbGhmOWNDaEF3N0ozdlljNGJhSDhMV3dWMkdkMVlH?=
 =?utf-8?Q?hn9Lp5rUjX/tbdWM+e+8MBwTA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71210f31-acfa-4fca-2204-08daa6d59018
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 13:29:00.7247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQ3fMX3MMRaEPVUO25x+nxqtKr751rrMiTccscgbu0JA45H7k679NhF5SU0jN6uUMlIUGllyqCmO60wXko9VEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5061
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/22 18:11, H. Peter Anvin wrote:
> On October 3, 2022 4:01:01 PM PDT, Adam Dunlap <acdunlap@google.com> wrote:
>> Thanks for all the responses. Is the consensus that we should use the
>> readl function here or instead use inline assembly directly as in the patch
>> I originally sent out:
>>
>> asm_inline("movl %1, %0" : "=r"(out) : "m"(*addr));
>>
>> ? The readl function has this exact same code, I'm just not sure
>> which version fits better stylistically.
> 
> Is mov with an arbitrary addressing mode still acceptable for whatever is causing this problem?

The acceptable forms of MOV are covered by insn_decode_mmio() in 
arch/x86/lib/insn-eval.c.

Thanks,
Tom
