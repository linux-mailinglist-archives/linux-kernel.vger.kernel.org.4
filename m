Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12CE664D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 21:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjAJUO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 15:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbjAJUOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 15:14:17 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF02213DF1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673381656; x=1704917656;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=h+05CkOpPuaMDJQzzLZjWgwZpp/WjJPrnVYzuwghIGY=;
  b=dN2TFLFs61VcYTGFW+ilB+Zdg4YhsVCPGSG8TLg1/Xu2Bu4EwX/B9ZBO
   F8/uFHq039e5Cy4l2T7jGJC3VQ5w2rRcQXBlVwL2alRCxYE1uqp7llTmP
   k0XckaVtQ216b5Gd21X8noJY3m8OMKTVKMkeHgovIto/cmyohlQ5EfeKW
   DeMaLkHGNbO6kq14pX1n6AHuv9NrkoDWSCsEBzIx6DuDJg/8zFiCYm7J2
   O9yGco0rgAhBhsmICebSU2BM6a4dEH2rLSNzXxR2o+5fYH9E4ndyxykCR
   3JAOjSO5bb0ta5olXI1QDAknDrDv32uj17vaBbfUcGF04Fw6HDj5P7Yub
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="323310713"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="323310713"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 12:14:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="657181994"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="657181994"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 10 Jan 2023 12:14:16 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 12:14:16 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 12:14:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 10 Jan 2023 12:14:15 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 10 Jan 2023 12:14:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ex3keqArXppPYpK+0s7NcW+5cs8Lowgvg0lzYv6k64/twJ4fkQ7AuxfF2Z2l2a42crKX85huHmGP5IuUNm1J53zDZekVJVjuQVBBK66sMRblBELEgY9JbPEHnXKEXag04QYAB+7aJl7n04TAQTGRmEaSP2ZzVKgQCvEp9UGxNUnAAjv3b8aFjANLMxs6mY8M8VZyyVfBUibtjm5dByaR9Wr+xC82Vy7efS6Zkvm1zu1vEtcJjw0KLy7J8gq7irPfVhCfC8OzJURAuSTdjhStp3I3mP6U9iwXI9G8o+odbpUAB282JW4AHPDcWuThOlogGg9j9XsdKad4c6Mwok1lag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ytk83W8dWNYv4NlvacA8+uNLhZRllN0DYG+9N5MiA2s=;
 b=Och3NHUlC5vdURaKfGRux1SPPe31E5TlYPegwERt6SiguGijG+uyVD4LDB7RaHUm0SckeN1x1t0dc90PO2AOAXi6cwcIBBT3ZgOEhbWhNGMFnXTgsHEjaK3VS4qG9dAKvE05HeCiBYmVD+JG6czi+hvesWcjXcTArX6GVG8CcimGRS0dWgg+35UFiRLvv/jZWNPSjK4r29UvHRZizAiaKDU0FdxDldWAkuPn3fhANC9HooRm3u9lKh6Vq9SX7CTi0HX6m2FR/Rm8MMCXsyJUUJXiRi58kp5HQL++Qd2oPgk916uqZNkg2yWP4m+RJlQw5a2P92pfNhYcr2iz+MNLNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SA2PR11MB5019.namprd11.prod.outlook.com (2603:10b6:806:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 20:14:13 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6566:25b5:89ba:e209]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6566:25b5:89ba:e209%4]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 20:14:13 +0000
Message-ID: <9d935618-8f84-2d6e-4f4c-9d38eec2ba67@intel.com>
Date:   Tue, 10 Jan 2023 12:14:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/7] x86/cpu: Enumerate LASS CPUID and CR4 bits
Content-Language: en-US
To:     Yian Chen <yian.chen@intel.com>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Tony Luck" <tony.luck@intel.com>, Paul Lai <paul.c.lai@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-2-yian.chen@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230110055204.3227669-2-yian.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:217::6) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SA2PR11MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c26233-eea5-4184-125f-08daf3473da8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gdVNJADf/1x5ZdOPX4Qy8nWhth4ZM7Zb2gzUzqt6PHEtfMJ1ki5rEgQL+Iwkqw5tWqtc6XRJRPUgZlP0lwypeQjARDnLlCF7vEEOaDPVAY40hR+NkDfdCsdWx9JaN7+bdBykDlTZ28YduoaUm57l0TQk5dCDJT9kh2xB/r1u5rz8/FMts3K6xbHPe8IQ6LevtIpEjQCp0I5rHSqctjq4QBaTci4daJjdYqiUouKXkEoGfHxGpe6ZEM3APki2952IZ4vdyCXudar1McJrGeNemWWXgA05+KwHBCs7sMWqbCutyJ9zFAqxkpkdvhR9jhryYiyq4Q5KfQYmVl1jq4Qk93b2louMbu0N1YPt9Pwd2M4t0QXY2nECBhPk77S+o4ryZs6ikPvMDxqP/asAJENoQM6JASKZTfJZ/VRSCSxTPn3iOMUxl7Odlmqm3SDnCWhgYPqoTzvWV1Cp/B4xbSMT37iJtFhjC8JyNvlxBAEEJVEH2hhc3ws6gciCDhmpAmbKtFibZz+7zgXR9skWGeauNSOe146yrc4oauAk6K73v6MJzv0vMXi8aO3o2VNP9FJ23Fhm1qQae1JsuqhzbX+Sz4fxr5fXKX9dkOxsf9ITIf3YJyyXrJQArrcV2DzGTRUlAlNuzJ7RLKDz6Ix5LPgrzos0NbyDqBOBImSeogXiAI5EOqcDnShAakyZ1yKNMTAP9NYtV6Cs0v5vdp4ANCKlpRL4Y8O1pI/npGePJKqcfV4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199015)(6506007)(6486002)(53546011)(478600001)(2616005)(26005)(186003)(6512007)(66556008)(316002)(8676002)(66476007)(6636002)(110136005)(86362001)(38100700002)(82960400001)(83380400001)(31696002)(41300700001)(66946007)(31686004)(5660300002)(36756003)(2906002)(8936002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djI5cktEQWs4R1JUaTcweDRZQXFvSWxwTFRiR3YxcnlzQ3BWbGx6aHg1NWZR?=
 =?utf-8?B?YldzZFdSRkdlb09STGptV2hBT0tKU29RdTJISk0rZGptVlMvUWxYbDBmajRq?=
 =?utf-8?B?OW81TDR4Y245bk1oSnFqQU91YUltSnF5NS9yTU03bGpPS0phK3VNUWJMQmhJ?=
 =?utf-8?B?SXcwcXpOOTBobTFiOFQwcmlMbmhsWkxmLzJjMkVjRTN4RFBFYUNtYVkrWUVO?=
 =?utf-8?B?dWNIWjZWOE9xclkvcS91ZnpFbW40RWhXbCt3WjlRUkkwaTRmWWNMdkw5TFR2?=
 =?utf-8?B?ZzQzcEtnMFdqU1psSUNYelpCSEE1cDJvTk14dk14cWl0Ty91NktvemNqbFNN?=
 =?utf-8?B?b2xKNThJS2ZWbzdXWkhiUStrTFBYanVqQXFhdk9ITkZncU50NGZEbFdNTUF2?=
 =?utf-8?B?WnpIR0UzVENaMENZUnZzbU5CTUdITEQzVHZWOE15VkNyaEtlVEd5ZXU0T1Nx?=
 =?utf-8?B?ZU1NUkZwdmJaTkFISE9XK0xvQjk2TFE2b2NPS2owR1N2dEtOV21UNEZBbFMw?=
 =?utf-8?B?c082b1c2alFZRjRua2hqMG9PRzhBMzR5b0dIMlBMOXpEaVlOMkR6ZFRnWG9a?=
 =?utf-8?B?VkdlN0t2MTllVFpvUTVmSFlrZ3hEQ0dRcEpnSGhZOHUwZ2k4SzVnNG1EZmFZ?=
 =?utf-8?B?WURxaXBWcm5PNFFZQmtJbjhIdHpYTXhTZlRXMVB2dHhLTTNUdmNhb3VnMmI3?=
 =?utf-8?B?dTNMV0d3M0U5bEtxYUg4MGFkWXFoSmVnYlFEbVY5a1Zjank5VEplZ3E3eWxT?=
 =?utf-8?B?bDZNekloRjc4RkxvVHNJVWxUeXI4M3ljdkN3ZlQwd05rMlYrUUQ1RDJJd0VF?=
 =?utf-8?B?aW0zSVFDOW4vVCtuamJJdGFzVStrSzF2Tk9oS3VnS2IxbE5zT0NFemVBZ3dQ?=
 =?utf-8?B?R1FDM1JsUVNvS1pRekRRQklSNFZicUhWVDg2aWVNVlJES3hOUmdLUEt6Tjla?=
 =?utf-8?B?c1YvbERVL2FBdnFJZEJFN0pSV0xyRjhvM2lwOUNlMGtQZS9PbW9OY200aUEv?=
 =?utf-8?B?bHE0RU80SFJVQVhRL1M0dHg1U2U3Um5lcWFNbFFBMDU2cWdnQWtBOTZvRTJh?=
 =?utf-8?B?aGVnbEYyNE4wZSsyZkM5NXdHMGpjMHkrSGhvNERuaWtrekZFQVBIamNaNmJJ?=
 =?utf-8?B?RUVVV3FwK1NtL3daaGJuZGh0azEvTFgzRi9VV1VDUGxLdHRsMmVRcWNETmRW?=
 =?utf-8?B?Y1RDTkxCT3hkbkNBb1hmY1dyL0toY2NOZHBuWkk3WTc5R1FrckhtbmlzVU5x?=
 =?utf-8?B?cUt3SlFqR1p6bGgwc3NlamhuYjlxZW9XWHFPa2tnRTM0QklPMi9RRXhqWUFp?=
 =?utf-8?B?VkpxWEE2N1UrYnhXVGh2aWVQcmt3YUpES3VnSXo5NW5vNW5MbWkrUWxSNXZ6?=
 =?utf-8?B?TXJMc29zQ1dUU1l4cGExRHJIalZXZ0U2QVJyem53eGNqRlROZkloWlhPeHRL?=
 =?utf-8?B?aWJjMmpEK2c3ZnVZa0g5QTBnL1pUdlZRVnhYMVNqYkNmeGVVNmpUOVJ6clh3?=
 =?utf-8?B?Mlg1Nmk1TkRncnNtczlNMXg3aGpnN1FJYk1IUzd0T3ZGMEs5T3pyWFl1Z2o3?=
 =?utf-8?B?aXFTRlNpSmVVZkpQdjlPb3ZqQkNxTW13SmFYUy9kdHJuQ1QvMm5OeTk0QkVY?=
 =?utf-8?B?SkF6QnR0ZGwvd05QMXFENjhwbDAwdGtrR3MwU0ZuRTZJRVdWZ3h0eE1sNUVx?=
 =?utf-8?B?ck5uN3NpTkRsZkJNSEF6UC9ONWVpcVV5REJCSGEzODlaZXpEdndaU1ZBdkVB?=
 =?utf-8?B?MEJDZzlvaUJOa3IvNkExY3B4d21zb1FJVGVQRnJwTHFQRitFa29VTWZiS1Bq?=
 =?utf-8?B?bnRvd2FIS1F2eWNqVU5CdHR5VVcvSlE0WDc4RVU5YUNvK1N1Tk5zU0pITmpV?=
 =?utf-8?B?YXZQdWlLU0NHeHR1aHcrbDhLdDh1NSs3aDllb0R4ZmRZMEJVaXFYSmFJd2hP?=
 =?utf-8?B?cWl3TUcyQjZoUXczV3pJTS9XVVBKS2pwYmlYQmdKNzRlVkNhNGxrZko2Unc5?=
 =?utf-8?B?dkx4ekJFb3NuQUNUZjJpeHRvZFMyVDFmRzhTTDg1NGxOSHI3YnRnZHVxVzh3?=
 =?utf-8?B?ZmZZRXlmWG1uQjJoWHlWVW16aW9nRlk0ZTFUdDJpZGwrUGt4VHZpa0xmMFJ4?=
 =?utf-8?Q?B56Wt3VrhgxE14QLmkaqHV8Lh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c26233-eea5-4184-125f-08daf3473da8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 20:14:13.0405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Whvb4oVMcqH8zmVA6yrkSOu3IPsrXcgRaQanZiIQZJ2TDdwLBOfsz4g3YtCNcv9nWyYrhiMZbgO/r7Lnkt8dqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5019
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/2023 9:51 PM, Yian Chen wrote:
> LASS (Linear Address Space Separation) is a CPU feature to
> prevent speculative address access in user/kernel mode.
> 

Would it be better to say?

LASS (Linear Address Space Separation) is a security feature that 
intends to prevent unintentional speculative address access across 
user/kernel mode.


> LASS partitions 64-bit virtual address space into two
> halves, lower address (LA[63]=0) and upper address
> (LA[63]=1). It stops any data access or code execution
>      1. from upper half address space to any lower half address
>      2, from lower half address space to any upper half address
> and generates #GP fault for a violation.
> 

I am not sure if this is the best way to say it. The kernel already 
partitions the address space this way. LASS takes what is already the 
typical OS implementation and bakes it into the hardware architecture.

> In Linux, this means LASS does not allow both kernel code
> to access any user space address and user code to access
> any kernel space address.
> 

There is clearly an overlap between the protections provided by paging 
and with SMAP and SMEP. It would be useful to paraphrase some of the 
information mentioned in the spec regarding how LASS differs from them.

"With these mode-based protections, paging can prevent malicious 
software from directly reading or writing memory inappropriately. To 
enforce these protections, the processor must traverse the hierarchy of 
paging structures in memory. Unprivileged software can use timing 
information resulting from this traversal to determine details about the 
paging structures, and these details may be used to determine the layout 
of supervisor memory.

Linear-address space separation (LASS) is an independent mechanism that 
enforces the same mode-based protections as paging but without 
traversing the paging structures. Because the protections enforced by 
LASS are applied before paging, “probes” by malicious software will 
provide no paging-based timing information."

> Signed-off-by: Yian Chen <yian.chen@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

