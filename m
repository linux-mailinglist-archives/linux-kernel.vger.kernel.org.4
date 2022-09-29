Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E21D5EFF87
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 23:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiI2V6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 17:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiI2V6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 17:58:33 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F8914D48C;
        Thu, 29 Sep 2022 14:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664488712; x=1696024712;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=elGaXmPLFY/r3D+sHp4VJFGxgi0AveC6XA2CVh09HrU=;
  b=Ag2KynXqDQRnZCPFdlTZOJlwERiuhVWILfMa2P/wcLJ3R7LEgftDiUhR
   AZ/Ce0m5EDK9gTtSIdb1n9ADCTC/6Ov/GWI/2T7MFt+ofLd/lkmJodX1L
   uGsAr4TUAbBOSpIW8JKALsoRP0+kpP7H6Mav//5XU/4bgzkHO239EBe09
   fV+A2FGxVe1pBZGagpSfuVjN0hXfaSU4QwqB1YzbSyjI5k/e4NTCx/oA0
   D2xxrqRTuLg7KVggleOc4vk9NM64HIJ06nvqwU8vabWhZ67S9xHdwMbVr
   AvVBpo06UkrCwg0fHs4Wy+0GSp/hUbFLRASGsDbmddG9ut8RNpaDFhgmT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="366087739"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="366087739"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 14:58:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="748007926"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="748007926"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 29 Sep 2022 14:58:32 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 14:58:31 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 14:58:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 29 Sep 2022 14:58:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 29 Sep 2022 14:58:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EB6mz9OBzerm4pCP9cgv388EMQ3hl1fA5+N8Js/LbNBhR47tmtZlGX3cA6Ilrnx8A6agaOe7Jf6roaMsVOL74dEPuQM2vkDWbUZCJikSca2faC4OL8p9vcoObMSXmVe9FyCpbJd/SXKkBsoaa9gLJlLs7zPAf8KfU0He2xrkBvY4Qwj5IZlttYXnq9b9Prp18ffaQAr+YPOzCr4np84vFgDDsk+W9ZMYkJbIYksdZNEbZNlkmFz4G+8ICVZEcidgo0psuf+w3i0LlENh57pxWJi8xEYNuscPJuO+gifLFL7QnihJz9bNZweOQDnAK3QlO65N9gEOuhqi8WzZ4Xrfiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuQ2WBt70v/WnKAh7wF8WnCiUDmI48dqPYT7N5eIQlI=;
 b=bjSgpu1WpGGvDdPDift464xItdmCZezyR6iP3Ojwx1RGySr2H6Ml4JBwZQhxBauaJgFYPy6mRp87v8TG+5btktF+jiVIo3looRjs/mUypgTzddxhvfqXxAINPlqh21xM9OeHCwN/Eu5IePtjG3rMQUJTtBsvY0ZqsxzbgmU1CCX/8JjkvDxIjFqEnTeEPEuV5FMZ0BywYcmowg+3KcQA8KemD4Q35D1YM37eFmeDPz+AkdvmYhEtM8F+NNIhJ5Zlis4rjIN75owpVmhrT6vs6j+KhRa8lgdcaBJ46ynPriRB/GIpUMKAveehvikAGgIbEJcYydAdvCNJVIajO3deCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BN9PR11MB5356.namprd11.prod.outlook.com (2603:10b6:408:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 21:58:23 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5676.015; Thu, 29 Sep
 2022 21:58:23 +0000
Message-ID: <9c45dbf7-854a-1a26-8cec-dde1a1d645e2@intel.com>
Date:   Thu, 29 Sep 2022 14:58:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.0
Subject: Re: [PATCH v5 01/12] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>
References: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
 <166431033184.373387.6520785024194837522.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166431033184.373387.6520785024194837522.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0017.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::30) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|BN9PR11MB5356:EE_
X-MS-Office365-Filtering-Correlation-Id: f39490a1-6a9b-41ff-77fc-08daa265ba62
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0zAJ6VRCehoJSSwjdqYH2nabyi0/nubCE4EERljxqpfKja4v9e8YrFSooQfb8R4hgR0I0uyWp5bj/M+v4s59/tuHM5reDwmdTqIZRG7IKfgBo59xVNTPIewtuQVLvvZgcyNg3DkYHCpuC5L5w6Nfu64P16PFlJgmioINZkEvrILLss1+ao4p3tiCogvu6HDDD71eduUL6H1vUs2Lyysbw9GrERtNn2TBi7P4Y075hf9E+bKBW7Mf+4lgoTp1zUm8bkCnaNSd7z9U2HkQo+e6ZK+A2XFe5tsXkOhKPuWqVUPPYK6Ess1xa5YPhUeZNhXdFeSKbo6q5kI22QleBdLKijTlSctD9avkXXQjGwY11QLSrvVgdpBVP5movW2lNN9L24ZO6Y6zcdQ9io68wqgIYjbFmZIfLd0GWijvp8oK0rGJUVYqn5TUOx8asZrk47D0dICSKvQaheqTaRLMJJGwkMh3aL8b8AtHYghtsX2T1jeBnZ50QHnuzoLozAmlrg9Po0XC9FsMA0izN9glj3OwQ5rD+LPapAVLfS2UPPtmH+5QLsAWAO/XF/PAdV3zBwwoD/tlFOMtf8QACl5ylsgIpDsCUSaInSo+VByY6bOBzAre1hBBWKkmUckW6SZkFEm6j9l0GNaho1d9v9pXpH83ksjP/y3R4znyxj6ETn3qle74z/oqQTTeg4JACx+op4KIb0ntqB9Vgz1Sl8tCbC31jxdAusafAIvNZza+BHA580aA11ZujdHnRQw968ZvhVbQr4DHscVH9Q3i07Plf+YXQGt7eTX8rv13HT9Wij+oBhVqQ4B83N/cSq1TBC+HogjbbNdrSoSt3krm38gpj5qH7RjCtIK2CM+fQuSVlDmcSi3CTcDhdyyC2+fxS3+q+zk9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199015)(31686004)(36756003)(2616005)(44832011)(82960400001)(8936002)(38100700002)(186003)(83380400001)(31696002)(86362001)(6666004)(966005)(53546011)(478600001)(8676002)(6512007)(26005)(6506007)(316002)(41300700001)(7416002)(5660300002)(66946007)(66556008)(66476007)(4326008)(2906002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME04WU5wSi9ua1RwQS9STVRVQmdQa3ppS21OUm05TmVqMWVTQmtnaUdjU3dH?=
 =?utf-8?B?d24yelBuRURweTRQQnR3aUoveXYxT1ZyMHdCRWs2WHFBQ0JhYjQ3VktodVl1?=
 =?utf-8?B?VWU5dlNpM1JyRDRFSktVdUlBaDN5TlhReVpmMWNpblp5RGs1OGg5Z1BZVXF0?=
 =?utf-8?B?OHIzTVlOc2ZmQ2d6SUh6TXY3Rk9MRlRiSkpTS2JBYlhJeUNzT21XejF5ZGdk?=
 =?utf-8?B?NlpRSDVsd0liSUxPbmNQSXBKWmFlV0duaUJPeFhKdmp3cndtSUYyOUVXMGRp?=
 =?utf-8?B?OTBFaElhTlJ6TTZLWW1wUVpTeEpRUzhUNHVScGVRSkZUUmVvanVnOE5Pcko3?=
 =?utf-8?B?MHl1bEJVUkJzaTFWVC9lSG1tcXh5OXBmRWFIa1hGYVhtU083TTBHOHphTXlu?=
 =?utf-8?B?RCtSUGNkLzNQaU81WWZkYmd5a3pCWExqQjMvMENsb25LRi9GQjVMZ1cwc2pz?=
 =?utf-8?B?RXBlYmhBSU5aZlZsWnd4YlRoZW9WMjRuMHVYaVQ2Q3Iwbk1Cc3dnSHpNdCtO?=
 =?utf-8?B?L1BCQzYzZThJV2ZQMzQrTjRSUUJqS2h0NWpnN2d2Zk1HNlI3U1JIZU1TZkdD?=
 =?utf-8?B?MnhSMlRNdERLYjBsYVB4Z1pxQ3k4cjFNVUJFSVRFU1BlZW9NbU5Tc29ZTERi?=
 =?utf-8?B?a21BTEVNUjhJc2RWeWZ1WStSQU9YZEY4ekFua21hWE1OYW9ReVlEYVhvbExJ?=
 =?utf-8?B?Znl1b1o2NHRob09pOGJpbmI3eVc3TjF5dXlOcDZndkMzMVdXQzM4V1lnWUJK?=
 =?utf-8?B?cGoyaUd6Y28venhvM0VoVkVwS2lUb1JQWkIzZytuYzJOYVljb2JHWVRLcjdj?=
 =?utf-8?B?ckJtREZOTURheVNjbDI3b21rTXhzRjhadGk4bmpYM253ZHBHMmF4Mk1rMmUw?=
 =?utf-8?B?cGhzZkZqbklFaC96S0NiVXROMjl4ajR6cVhzMlF3MFIyQ1ZRY2xLSFpNM2xG?=
 =?utf-8?B?MFQ0SWRXSWhzQnNCQzBUTWoxS1V2aG55YXdDanQxWGJNSXg5YUJDZVhvL2Vv?=
 =?utf-8?B?S0F1RVljMDBKN0ZYUjAwdzAxNkM3R3FwS3hVTFBsbmxONUZVOVhZV3U2b0Zp?=
 =?utf-8?B?Q1pia0lhck80MHVEVFhvbS9EVnhpdVZnaEhwQjN6cVJFL3Q2aWtPOVRRYVZ5?=
 =?utf-8?B?dW1VYVBieU5SMUhuMmNocWNOLzdrWkFjeWlSMGd6NUt1eURYc1FhN2liTFlI?=
 =?utf-8?B?cDJWMkViTWRxOFdKMXM5M3ZQTkZKaFhGRjNFc1NMNGpITU1FZnYyUEkzZFFD?=
 =?utf-8?B?TjVPQkdyc3hpRGQ5TlBDSS8xQy9xRm9NSUR6T1NHK2hGM3VycFU2eUhLdWE1?=
 =?utf-8?B?OStyS0VaN2xYbW5KdWVxRDR0am9VSXVjQ1VnM1o5Z3lXeUFCR215dVEwcitY?=
 =?utf-8?B?UkJIZ1ZXd2NoR2Y3TlVaUStYeS9QaklyQ3RiQjVHT21DcEs5NUdBQk4zcW42?=
 =?utf-8?B?RFNYM0htMitvTm9NTUlVS1VDakxpUE9kdjd2bENJOGVwdWd5TjFwQm5uaFl3?=
 =?utf-8?B?dVB6Y1dTakdVMGVpMTJEYTdJZFJPN1FGNWVnQjFEUEhZRkoxS1BONkYyRG5n?=
 =?utf-8?B?SXlFSlBNZm15QU1SMUFCVVJtRXhnK1BuVWdSUVVGakNTc0hWR1JHTlkzRXJO?=
 =?utf-8?B?cmIybUlQYWRmZkNORHV2MWg5WnN4UzQ1MnQ1bnJGQ2t1a21OdUxaanQvd0Ex?=
 =?utf-8?B?TG1ZK09DU0h6emxDclRUQmpERHU2eEMrZVZhLzlYQTMvbTlEVXF5SGQ0eFBj?=
 =?utf-8?B?RnRyaXBPQ1BpakdGOXZha0grM1pDdXlhL2RwZ3ArT3JPOHgxY21Ya2xEUkJJ?=
 =?utf-8?B?UmtMWllyQ0NhMnJCSFRkdVVIb1NnaDd0dUhTeW11THNnNFFZY0ZJZWl3V1Br?=
 =?utf-8?B?eWhvM0VQYi9kRFZCNmdOMWFicVFxb0JoMU9RYm5wVlZNcFdhOEQ3VXByNHBX?=
 =?utf-8?B?SG9JczBqOVNBVnlVanZ5aEdRd2lUNVgzYlYrQXVVY2VHMlVyL1VyTitrN1d2?=
 =?utf-8?B?TUhrdDBoVHF0STVtMmEyTmEyTWQyeTVZcGc2NHo2bVFYcm5FM2xYREIwc05w?=
 =?utf-8?B?R0VRc21qaFpBazFRZzBPK3hKbnVJYVIwdTJRekV4blZqcG1kMXl3QWlJbkpU?=
 =?utf-8?B?Sllpdzk5citCdFFuSUlOMlpQVFdGUWcyTnliWkRoeDhWczBtSTZoRWhhaUZM?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f39490a1-6a9b-41ff-77fc-08daa265ba62
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 21:58:23.0789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jn0G/fOC65bTp/h84Sdpm7hBvMkOqywPDgMbJEQwysD6A4QlidNFl7bD+Qf37yO26GJRI+z+jQW4gWxTrBzq7y47xeJ91hD8nN3HJgS4Pwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5356
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/27/2022 1:25 PM, Babu Moger wrote:
> Add the new AMD feature X86_FEATURE_SMBA. With this feature, the QOS
> enforcement policies can be applied to external slow memory connected
> to the host. QOS enforcement is accomplished by assigning a Class Of
> Service (COS) to a processor and specifying allocations or limits for
> that COS for each resource to be allocated.
> 
> This feature is identified by the CPUID Function 8000_0020_EBX_x0.
> 
> CPUID Fn8000_0020_EBX_x0 AMD Bandwidth Enforcement Feature Identifiers
> (ECX=0)
> 
> Bits    Field Name      Description
> 2       L3SBE           L3 external slow memory bandwidth enforcement
> 
> 
> Currently, CXL.memory is the only supported "slow" memory device. With
> the support of SMBA feature, the hardware enables bandwidth allocation
> on the slow memory devices. If there are multiple slow memory devices
> in the system, then the throttling logic groups all the slow sources
> together and applies the limit on them as a whole.
> 
> The presence of the SMBA feature(with CXL.memory) is independent of
> whether slow memory device is actually present in the system. If there
> is no slow memory in the system, then setting a SMBA limit will have no
> impact on the performance of the system.
> 
> Presence of CXL memory can be identified by numactl command.
> 
> $numactl -H
> available: 2 nodes (0-1)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
> node 0 size: 63678 MB node 0 free: 59542 MB
> node 1 cpus:
> node 1 size: 16122 MB
> node 1 free: 15627 MB
> node distances:
> node   0   1
>    0:  10  50
>    1:  50  10
> 
> CPU list for CXL memory will be empty. The cpu-cxl node distance is
> greater than cpu-to-cpu distances. Node 1 has the CXL memory in this
> case. CXL memory can also be identified using ACPI SRAT table and
> memory maps.
> 
> Feature description is available in the specification, "AMD64
> Technology Platform Quality of Service Extensions, Revision: 1.03
> Publication # 56375 Revision: 1.03 Issue Date: February 2022".
> 
> Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-quality-service-extensions
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/include/asm/cpufeatures.h |    1 +
>  arch/x86/kernel/cpu/scattered.c    |    1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index ef4775c6db01..349852b9daa4 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -304,6 +304,7 @@
>  #define X86_FEATURE_UNRET		(11*32+15) /* "" AMD BTB untrain return */
>  #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime firmware calls */
>  #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit when EIBRS is enabled */
> +#define X86_FEATURE_SMBA		(11*32+18) /* Slow Memory Bandwidth Allocation */
>  
>  /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
>  #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> index fd44b54c90d5..885ecf46abb2 100644
> --- a/arch/x86/kernel/cpu/scattered.c
> +++ b/arch/x86/kernel/cpu/scattered.c
> @@ -44,6 +44,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>  	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
>  	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
>  	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
> +	{ X86_FEATURE_SMBA,             CPUID_EBX,  2, 0x80000020, 0 },
>  	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
>  	{ 0, 0, 0, 0, 0 }
>  };
> 
> 

Please respect the coding style of the area you are modifying.
This is the same feedback as provided in v4 in
https://lore.kernel.org/lkml/ba36c68c-0b13-e8a2-fb45-8b84ea9f7259@intel.com/

Looking ahead the same issue also remains in patch 3 as previously
mentioned in v4 feedback.
https://lore.kernel.org/lkml/c4a9ea23-4280-d54c-263b-354ea321f746@intel.com/

Also missing is highlighting that configuration has changed from
per-domain to per-CPU and why.

It does not seem as though this series is ready. I will wait
for next version to have existing review comments addressed before
trying to look at new changes.

Reinette
