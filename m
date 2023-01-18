Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72ECD67237D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjARQhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjARQg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:36:26 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE537A94;
        Wed, 18 Jan 2023 08:36:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Azod1yGG62Tqu5gXkYKN+EQ1jU1fv2KXvVzYmbTPerga4VTTIMk1SpWv+7zWMgJ/QeKoGB7MyDJiTPcQL3f/9zHiGhEBEGgbsvKxruXrf+bNY4OI2iKm4vZpmNBopF/Q8ylK9V5CMG6NW56703R4qJLcItJ7rs/WKgVVmQpmFbEdUWS7VQCVXCJiuYK9Jwjw6n/FP95tIsPuqvPG+Tl3SUWF15yWmO9wc5h8StYhalUFFFOQrBWKgtiQBb+8pcoOFnXK3K/n8vVyY4IUweXoVUouEHJ4U4cR7miBE12LdTuwDp11/SC2W2jL8b4cyOyb8Ro5JbVq/EDbYlk+mXAnnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4Ld9+jbgILtsIrrkjOpOilBQ0NhhBcHPemPT9XgQ4I=;
 b=bI3M1dLSTIzGnA+sW0CbO/kNNMRs32dKx5aqIIRcwW8vpJRdy7rEBJ7a4N5142ae1ZMkoK7/x171L8nX09i/Ot4b6sna4TvQyfUd9/EjkhApdqQv3wPUP9gzuxrgTmZvm0y0novo1E55RIWST9gbFlQx6gIprbF+ZtkmHmPYFkuTaXu3YLA9jEFNHoVJ7Fd3QtHqDYPXPE6xK6Aq2zbCBSH7cpoalrVs4KWy4Y7MxedXRwvYe9mB2r87HyQDtou7SDH10rf/cY8fpbCXgZK2FsKpsshRh+WHhLn+Vf09+5VraaNzUcfp9KUGhLOQigAge7mwILgQZOxYMRxTMvVUKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4Ld9+jbgILtsIrrkjOpOilBQ0NhhBcHPemPT9XgQ4I=;
 b=pFCgGkEriR9qUY22hvfrU/Bb6I1r7pjasT0J10hQwvvRnQPrNmMxqZ/a/dY/nMxIop9991+vBB6rLrXNN8f7sIiT7iqtLIxLosJJICN7aSLE0usR6rXvTNcyaA3w8pwT5ugSqGFs9V8kBVEBKlqFbkLdci6tYhLZhQA57uVw5oA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB5891.namprd12.prod.outlook.com (2603:10b6:8:67::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 16:36:12 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%8]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 16:36:12 +0000
Message-ID: <6e3ddaa0-f221-3f90-1f86-07d1879fd222@amd.com>
Date:   Wed, 18 Jan 2023 10:36:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v12 00/13] x86/resctrl: Support for AMD QoS new features
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <20230113152039.770054-1-babu.moger@amd.com>
 <9e43dd11-38b3-fe0c-0929-8b454591813a@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <9e43dd11-38b3-fe0c-0929-8b454591813a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0048.namprd07.prod.outlook.com
 (2603:10b6:610:5b::22) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b240b33-de84-4c47-04d1-08daf9721c40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jvsEnGsAqF92nmyOHa+nK/UXgSZe/nYtflrSq3vNv95XFDkr8gb3pwn25JSCxGrnnvaxZrfbAiqxGS6+cwfnXN8z7RUl8KeveKsxj+xj3K1bK5O+UiXseTPlvmRwyxP4TI+H9Clwr9uRotxtVxFpIpqGRQPo4JhyW0IXCaJA08NrOURXH8j1GCvVQ4R4jxDAx8FHy7mAG/sn8lAOBhHz9u11Jxf5GTd56TfZqUlj7ccRFZT/Do3yxusYdVfvTn5V4VOm0n46Dio8BZQBGx+l8ftqAjMt7RjzR46BZEzw7ovo4FEU9Bzd967FPuoR3r2fd35Bx6AhNHVjEP5xTh5viL+uNRLTovEiL8f5zwcHCskXQNpZ1aI+kXIrxBssS7w2DzHnKbcc5b1hGqfC5wTrfQYaxFfivHr5oF4tuIaD02X5mu3Uxgmy1i7737NA7f45w5IO7u+vn9xHBDp8fcNHAgxTzOFxMl2vL2EGS3WMP9Or3hQ8ywSQoYHZHqEBL0xsZByH98Kic7N45R3z3iOus3zUH0SCxzDi7hqwVFe2a3Y3+/fPgAsI8pFQZbHb45jnDQ91HZl3u9c0dRqXvTLFYlwE3NAFPBKbYbaSvsZ3XWXakVmSBuAsyi9IkVh/IPP4vnZvikwPqLA0PPlIk+xaLWL7GMhSlzPR2xfqlYIb5ojWcEORziqp+TWDy3qrnFK9zOmrjaUSE7U0l/RkD+U7ijc0pc0Q8hcxZCVqeLV1tojFzlWBiwaKzKyMszrZcQbi5q7tjBmfKJDqOZfsjrh0deGjAvuuhCkUrO4/10VNM8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199015)(31696002)(36756003)(86362001)(53546011)(6512007)(83380400001)(8676002)(41300700001)(4326008)(186003)(2616005)(66556008)(26005)(66946007)(66476007)(6666004)(6486002)(316002)(2906002)(478600001)(966005)(7406005)(3450700001)(38100700002)(6506007)(7416002)(5660300002)(8936002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUovZVRKMUhKQUVLaDl2S0U1VThXbzY5bHIyaGsrV0N5TVhhMUhiTmR4cHpT?=
 =?utf-8?B?anNQd3JJWStzekh5WGU0VWU1amk0ZGcrNjRyY0FhS3Bhb2srcmEzZ0NtQzdx?=
 =?utf-8?B?bGJ5ZWxUdmFLeHlaaWQ5S2c5U1JjTngvdXIvaVpRTkg0TFp4Rm9ZVHpNbEdL?=
 =?utf-8?B?STY0TWtCQzlnUnRiLys3bjVWZHlUdE1WUVY3Vmp2NGJBd2Fzdm5QN2t5MDlK?=
 =?utf-8?B?eGVGWDBrY2FmYjNnVGJ4YjdaUDlsYUNvYjExV1N3T2JsWkdxWmhpb1JLcWdt?=
 =?utf-8?B?bXpVSmcyZGN1OXgwemVvZTlwbHlWMjc1aTdQNDJrSDFrRXRyVGVOelRpeTZB?=
 =?utf-8?B?bGE3dlNqaGttQXlEK2picHBBbGFTOWVJdFU1L05ld0NMWjcybFJnblEydWJr?=
 =?utf-8?B?SmhwT3VWcjZ2bEhSZ3RpaWdSVllRMWJOU2ZBTzdWVkQwQ3BkOXh1eXdTTWp2?=
 =?utf-8?B?U2lyQ283cXdvamxGNDc5VjdNbklGUDhQOTNNdjBwMFZIQ0JMUjU2OHFEcS9H?=
 =?utf-8?B?bUJXUkltaEJWVXdabE9EYnlheS9EMEd0OXVYYkpoM0Z2d2d2bGUwZnNtcmRN?=
 =?utf-8?B?aEVhWTJZOG1qdy9SMmZVMkFUWWsxVXY4MkNRbmNGb3lSZ3RCVzZPMVk1ZmNt?=
 =?utf-8?B?TDB4OU9GMFVmZmcwK1NFbHhDYmltMlUrTm9IQzVMa0NITG10SFkwQUVVRzJM?=
 =?utf-8?B?dUkwdytWVURUbzNhT25SZUh2aDNYMjkrUGY0eEd1NUtIQXdCQ1owVHRGc3Q4?=
 =?utf-8?B?V1ZJNmFkRHJFWlF2bHlpVllvTGxaeVNva2hnUFlhVFFQRjEyOC9SdVFMSzFK?=
 =?utf-8?B?ekd5VTZMUG9FRHdhN1hTNU1FSmRvYU5iSFFGUlgyb3FMNFZOQk5IRTJmb3Bw?=
 =?utf-8?B?MlNUR3VGR1FYWGNzVjZHb2hSNGpmSzVoTWhJQUpDeGZlenhOYU1VRG01OFhk?=
 =?utf-8?B?V3dkNE9tK3Bmek9mNm5OMjdrU2o3TkRBVGxPTFpjTDlLb2E3SG5SNXpNK0tW?=
 =?utf-8?B?RlErSjdIQVFGNzVmVlRnTStGSVNOK05SMGFUVlYrVGRVNE1uWUFSeExzUTVG?=
 =?utf-8?B?UVUyZGtiWDlnQkdLbjY1d2h5eTFMcEZjWU04L0RONDlWRXF2aEc1WmN2U3FM?=
 =?utf-8?B?bVFVMzBGNmNSV002OE1yUFE4a1VPNi95MHhNN0Fqb0NHNkNTZVBqUXBzYW5z?=
 =?utf-8?B?SWtzTTNrYUJRVlNwcTZjaEliUDFGVWVyWml4dk9iOWw1UU1FQmZOOEJWQUgz?=
 =?utf-8?B?VDR4bDRoSzRWdGIxblBvczJMV3RDamNxWHpucmpDRklOYzJSMHU0TFYyOXFj?=
 =?utf-8?B?MTVEdmdiVU4vTU5UZWl5MDFONWo3cXBrMzRDQWdwSmJEV3lPWXkwYXBZbEU4?=
 =?utf-8?B?bGR6eGJranhYQ1JlazR0cStJYjdjRStVb01EbGpjWTNkMkg3dnE0Y2xUUy94?=
 =?utf-8?B?a0o4dEJsVTMya3hTckcvZzU1c3B2cmt2S3JRR01IZ3JKeWgwWHJueWRrdkMx?=
 =?utf-8?B?M0hHV0VXYWczTmNXOUcwVkFoRDdQZ2tnOG14Z1RHWHM3QzIwQ3loU0dQUmhC?=
 =?utf-8?B?akFqSkRuQnNIUHFrT2dhS1dWNlUzd3FnUUJuQmtXRS9yQ3gwY3pIWHRuaUtT?=
 =?utf-8?B?OWlHODc1akhxL2pzdTAzVWZhNk96TkNaMWdyTlNRK1B1RjVqbWFnU2JSN25R?=
 =?utf-8?B?akJFZWU3T2d1UExTTEIzeXlvekJaWERDakliclcwc0NMcmx5MU1Tcjl6QXJT?=
 =?utf-8?B?dzhkZWgvbzVwUmVPNytnYmFrd0IwNStrT3BuSTFTNU5BVW92NEtvZS9zSE9q?=
 =?utf-8?B?cUJCUEoxSWUzSXNIbE9qMXRMT2dwa203L3ZxdGNlcFNaak1IWk1EbGJYR2lz?=
 =?utf-8?B?ZEtRUkZMamE0aEFhVlJBMHdCZWUyNjRrdWQ1bHdpOHJvNTMvWnJNY3h0MGRi?=
 =?utf-8?B?T0RHNVdPdTVuOWtuMy9kbWhrWDhnendMY0hQTWtzRUEvSndWWldjcXpLaHdE?=
 =?utf-8?B?eDFUazlBY1BPL0VKSlUzK2VvNUZDdjg1WGZyYTJqS0tpQU93dmR2aWFBZDhR?=
 =?utf-8?B?Qk81cmJ6YTNNK2dNQU5ZVEJxK3ZjNWoxTWVFa3pIZDFPUFBSbEN1SkVjRm1Q?=
 =?utf-8?Q?W0Rg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b240b33-de84-4c47-04d1-08daf9721c40
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 16:36:12.3922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Awk8EHVLd6exzp3vIdiGO5Ei2vUfSXRhpv3GmPunbmRhTxYnAYoB5owTJfBtg+ds
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5891
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/17/23 16:16, Reinette Chatre wrote:
> Hi Babu,
>
> On 1/13/2023 7:20 AM, Babu Moger wrote:
>> New AMD processors can now support following QoS features.
>>
>> 1. Slow Memory Bandwidth Allocation (SMBA)
>>    With this feature, the QOS enforcement policies can be applied
>>    to the external slow memory connected to the host. QOS enforcement
>>    is accomplished by assigning a Class Of Service (COS) to a processor
>>    and specifying allocations or limits for that COS for each resource
>>    to be allocated.
>>
>>    Currently, CXL.memory is the only supported "slow" memory device. With
>>    the support of SMBA feature the hardware enables bandwidth allocation
>>    on the slow memory devices.
>>
>> 2. Bandwidth Monitoring Event Configuration (BMEC)
>>    The bandwidth monitoring events mbm_total_event and mbm_local_event 
>>    are set to count all the total and local reads/writes respectively.
>>    With the introduction of slow memory, the two counters are not enough
>>    to count all the different types are memory events. With the feature
>>    BMEC, the users have the option to configure mbm_total_event and
>>    mbm_local_event to count the specific type of events.
>>
>>    Following are the bitmaps of events supported.
>>    Bits    Description
>>      6       Dirty Victims from the QOS domain to all types of memory
>>      5       Reads to slow memory in the non-local NUMA domain
>>      4       Reads to slow memory in the local NUMA domain
>>      3       Non-temporal writes to non-local NUMA domain
>>      2       Non-temporal writes to local NUMA domain
>>      1       Reads to memory in the non-local NUMA domain
>>      0       Reads to memory in the local NUMA domain
>>
>> This series adds support for these features. Also added a minor cleanup(PATCH 1).
>>
>> Feature description is available in the specification, "AMD64 Technology Platform Quality of Service Extensions, Revision: 1.03 Publication # 56375
>> Revision: 1.03 Issue Date: February 2022".
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-quality-service-extensions
> This series looks good to me. I added my "Reviewed-by" tag to patch 13/13. All
> the other patches in this series already have my "Reviewed-by" tag.

Thank you very much.
Babu Moger

