Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF9962715E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 18:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiKMRzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 12:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMRzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 12:55:16 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BE1DEC5;
        Sun, 13 Nov 2022 09:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668362114; x=1699898114;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iL0A5Sxv6yqd9qnagnpUoaPselOcGQjzP36/8XLzgJo=;
  b=gWZD9YU4Dv6o8lI+lqnHiYig2wIgberBFxyrJVxrjVsaUFddZ+QCvnMF
   OsFwGJw6YQhUFMP5sC0B3rXriUvnK3QhCzJ0+Jnl/E6Ec/DU33a6OGzHX
   22uFDjW5p0n1KwM2f1Z4/xJ0oo8MdvEjdddxFPsyU4+W4qDY3YqvtTlKJ
   PEKAQZ7KojQ9x6aYaL9GNzJMO6OC6ApN8ntgjIJuZUTZge+hstrjhV3Py
   8fr3hVDt6HxfCwkhYD3USl/lotFqAT5nxXlko4LTjoXR47i88fV23hqnT
   yMMI0puZ3D8lA62+6BNGgr3wHkJvvV6ZWLHiufLMSsA0n0Pl5u4nDdVls
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="310538962"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="310538962"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 09:55:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="671293097"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="671293097"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 13 Nov 2022 09:55:13 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 13 Nov 2022 09:55:12 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 13 Nov 2022 09:55:12 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 13 Nov 2022 09:55:12 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 13 Nov 2022 09:55:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K50j3nDU+vmIafI4yK9oHtQ3OBch7I+HL/fRU104kg0if1zLgqG8rEkidrf+494LcY9Y2NO+i7v5OiNGt8J2KQkFoF8/gS1aAKxJqTEcCqDo3k0/bPJ9sgPf61fZylLR/Ple0Xj2uSPeVlxgbSnfA4vDePL/lojYo10LqxmMNeGpP+EB1w+UeC51hAhPGKdd32qNRu2cW8xq5cbQ7NMRS8ZbA+XhPaCdwUenuBqXmLPK72TLM6Nz+NWGXfXfXas0EDtnDRugmFRtK53HWJRvhfxgS1PGstKyTkgHo/bRl6YTSJzdEJTMzxraAnbwgla35sIG9Sk6Zp6ejfngJxVMuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=820WcdPScOSHiTTCQr/q8q6bwXcn/AwfH9CqUX9m0+U=;
 b=VPoXc4XtezwkX/auYZTKWrNy9iM01BZZtODK+i68F0byNL8v+dZlr6LtRCH0fWfriNLl1+RhKLHmIBSy9n2uV/4W8L76gIUEZsErTJmVIdQrZPbIzHM1o6oYephlwJevjxsZz92fZERAsTEK0AR5IsCkR/Y8r7sh4g0PGy2eIAIBaCIZVJP2AB/arxSrp1aQAPHzUyQEVshF8bBbxCMOM2wMTyGK7xV48kDuVY9QCbWA09W0Pa0WCS3OHqn27vR2o0Iw7JEAiA+CtndOYuJqLK1PiH68UHDYNGcJrBxNVmkAFqY7iNaAOYa5q7biEAKUhPt7SrEtWwBzlWRB0rUT8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by PH7PR11MB7641.namprd11.prod.outlook.com (2603:10b6:510:27b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Sun, 13 Nov
 2022 17:55:03 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0%4]) with mapi id 15.20.5813.016; Sun, 13 Nov 2022
 17:55:03 +0000
Message-ID: <f307b37f-26de-cb8f-e199-f327f2c7f807@intel.com>
Date:   Sun, 13 Nov 2022 09:55:00 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 12/14] platform/x86/intel/ifs: Add current_batch sysfs
 entry
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thiago Macieira <thiago.macieira@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-13-jithu.joseph@intel.com> <Y2/JNAmSoYlLKq3A@zn.tnic>
 <CC3629D6-B205-4150-80E5-FC7A7A76DD25@intel.com> <Y3CevK2zhAmiUyG9@kroah.com>
 <Y3DZmKYV+8HBtZ+Q@zn.tnic> <5e65889d-d68c-b29d-6cea-7b4ce4c87b4a@intel.com>
 <Y3EiKUzpShqwzEf6@zn.tnic>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <Y3EiKUzpShqwzEf6@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0125.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::10) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|PH7PR11MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: ca870ecc-3c7f-46fa-a0da-08dac5a030d8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZuI3x5WTaR4gdy3fWlsAn5U55jMt9zCNkCxeKWfZmDALPf65fp84L4k1TUtFTQJzgnNRQpOvj1RRdZpQIEA0rpBcIUXImakztdWkK9CAZFRLTLUMarUkoACJApDWE2jSbmIw6gPKE/UvQgouTL+stR/H/Vox9wTZ1AjfRn7ie+wopHZ/KUaTgznZsGG7d3ptwPtnWLlu3pLfb+9PD2VZFIuCPlc0z6mZhd0ikal41K6JUoKIMsgU27wPYKMqgTCyljuezIl8of2cahB6RNQKVJODQj+2W//G0htOCrTtJor39zaQpVk0uY7eqFQt0aI7Jyo2J3NhF+IsHgKZXPMm0e0RcEW9gQ538162VXuI7OSBtJ+4ZfruUOdFR6LScshkH7kw2bs2VDAf3fACF3rBujgl8f2kGfuGFTg91LXGx+FGL8G25vzEzryQST8gA0Tvgy02YRlBW9WEMZsIflTjcDqMX8R5P9tHP9spEErym1IZdtRplZdFdLNl6s5V9M+rzZK1JFap7xtJbbw8D0+gBKY8do9oTUHAJiDV8ftRaggc9MG6Q+JiDPdccGWiDQhrd/lvPIkDWbcr7CkhIwyVZyfFJMOjCZN/O/0EVidq3mFH4jTgZbuCOlIOBfblouaTOIoSZX5y9msbxv//xiAPtHs0En6e47pJoBCvjunqwPNaHJmlGuYK1N+F+Jw+4uZ1Y6i+0+WcTIWey8urn9Kn8gG1XgfDDyUwQl0OP42/mUynOEMkjv8+imCQ7Xc/JGxVSCD2ildyTrHQLG8ytT1h8LE/5fnvSUUIQMQdL/vpQ8x85cF2u8xbhfE1ICBCuLiy/SF2jXYOCmgGU2GiVPepA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199015)(36756003)(31686004)(316002)(31696002)(86362001)(82960400001)(38100700002)(2906002)(4326008)(66476007)(41300700001)(8676002)(66556008)(66946007)(8936002)(6506007)(7416002)(53546011)(6916009)(54906003)(5660300002)(2616005)(6486002)(83380400001)(966005)(478600001)(186003)(26005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkJhNVRHLzV0eE1mSTVKdkpMODVYckZuNkdYbjZteHdaZkdGSURXWnFWNm9l?=
 =?utf-8?B?NWQrUHNkQm1DR241MjlPSENLUWgwenhhZllaMWp0dVhwSmpvU0VFTVRaU2NF?=
 =?utf-8?B?VFc5L1lpMjZ2bERxNjBxeG1weUxUNnZtWWpCMGdkNUovOHF4MU5nQzdjdUNs?=
 =?utf-8?B?T1Bjc1NKZ1crNW9RWUR1cXMxV3NYS0FPU2N2S2paOVNrUytuUnY4SER3Tm1H?=
 =?utf-8?B?cG9rcGl3anhyVmZJbEUweis0R1ZWUTl1UVdmY2xuK3YwVVVGNkQxSm5nRzlq?=
 =?utf-8?B?Kzc5SjREbkR0VXluZ2ppN3VTbkZOeG1MWEhhcXJjczQ1dUZ6M3lmMEloWjdo?=
 =?utf-8?B?VTFFaFJva2toOEpNYmVrLzFnY0hWMktiQUZPdDFvLzVRV0pPcnZiTjgrSHRp?=
 =?utf-8?B?TUNkUTdIdTJNU3AyOWZtK2RTTitsN0hyNDlzRVBSdmJkLzhFV24xb1FDTVd6?=
 =?utf-8?B?L3d1ZHdOYmI2U3VkSVErZjMwL1hkOHBEZDQvWlo1RmdNMGFWN3NXSGlMYkRw?=
 =?utf-8?B?V3BFZkpENnJVeHYyemMvZUw3NWRjbmFNMTcwY3RjYnd6cjFITUQwSVBpU29w?=
 =?utf-8?B?ZzhaNzlnNllSKzkycGZYRSs5YjRSVTdrd3FIMG45MzA4cnRtdUNMWDExbzZW?=
 =?utf-8?B?OS9uelAySStQSVNaamVsMXdRd0ZLbmE2Z3RQK2ZpOXZCWk5oSWlYUyswK3VH?=
 =?utf-8?B?dGxzdWhBbEc3aHVWNlIyK3BvMkg3aEcrMnJmQ1owQUFDdWJNVm5saXlMbkdR?=
 =?utf-8?B?ZDVzakpSaTRtTURobmM5Y3FLdFBFbkZoMno2NW5udkQyTXVkWE9tRFE3cEZx?=
 =?utf-8?B?SGVXS2UrTjV1K3NxcytEdlZSSEFiOFNEZHRWMFY2RDRIOE1WMzVJQlJuVTBr?=
 =?utf-8?B?TDlBWURiaWU5ZEdVbVBjeHIzRS9Yb1JCQmxZa3dwdHYwUzJ3NkRHb0dpdTh3?=
 =?utf-8?B?NGVkRDUrUjI3eE5FYW9lUlEvUmdoNEpaUVFaOFJYS2EzVllxYUtJWkEyZlNp?=
 =?utf-8?B?Wit1d0xwSWliZi8zSEpxRTBSbCswN1ZwMTBLWGdZeVYvVklmZVM1RCtDVTZC?=
 =?utf-8?B?elFHTlJabWtjeWJuS0ZWRUdzWEtaWTJQcWNjcG9tdnpyT3lOa1pVOFovWEJm?=
 =?utf-8?B?N0tIRHVmYWFJUDRlWHlRMFNXWTNZeUM3M3pvZmkvU3V3ZHZLcWZuSHlCNkR6?=
 =?utf-8?B?TEVqeFZhdEczUlE1WlBwRkQrUnJmdWdXNlpjbVc1cFAvMkJHWUozQWV2WjBm?=
 =?utf-8?B?aVpjcFYrZkJINU1iaDZ4bnRyNk5DbFM2MXJCRkg3aFVvMjlUMkphMi9wUmY2?=
 =?utf-8?B?czB3SktKOXU5OTFTTkpFYnlPMzB6ZXgzWXJ1K0wyUEpIdWtMZWpmYTgzMitO?=
 =?utf-8?B?bHkwMDdIVFl1cW94T0QzcndCU25GdlFrMXZiODlkTzZQWUU3dnVta1Y2VVR2?=
 =?utf-8?B?N1JDTENCMEhsTE8vVUdXd0pFNE0vdHpGOEtpLzkxVzk5czV2UjZtbW9IWHFZ?=
 =?utf-8?B?TTYxZE9aRlJMelFMOHJ0d2RSaG1ScnlIdWdIekxhenNaT0VDK0p2RHdJMGxk?=
 =?utf-8?B?V3JwY2prbUEzcnFRb21BbGY4NERiaGJDQVJCM2ZFdWlFTGxPRVVzYWVDcDU2?=
 =?utf-8?B?Tk90cHZZS3k3WWVRb2ZucFRXOG9CbHpsSjZuYVZYS3hvRHFwRWk1dE9WWjEr?=
 =?utf-8?B?ZWNraFlZVlNCN0NKRXgrK01KZmVUdzlLTk5obmJ6UHlrTGVPeTdlVFhMRU5q?=
 =?utf-8?B?KzVNRlA2VTJNaUJQVnBHMFQrT0VGei9BdUo0c1BhMHp2NnI2ZkJoZnIxNld5?=
 =?utf-8?B?OGtXbWFQM0s4V2hvMG9saGVqTFcyTktnWTRNNmd1YXZyUWNLcWc4ZzUyb0Ns?=
 =?utf-8?B?QUs4S0U5Zzk2R3JRcHpHeFArN2VVZlNmQTJzNG8vVm51UUlkeGsxRG84RVoy?=
 =?utf-8?B?cnh1U1U3SFl5azdWeTlObDk0bVYxcFdDOTNBRjdyVnFtMHp2MkJ0U1dEc3Ux?=
 =?utf-8?B?UnFGNG8yR2J4R0VISEU1QkNONDdQVmRYWVE0dERrT29nYXpZZExNRmM5Y2Vk?=
 =?utf-8?B?dHlITWt3dDNyN01xS2VrSzRISU82K0tVM0l0UmlzeU1VelhGTjVuWlowMU1J?=
 =?utf-8?B?VEt2bU5iazRvVzBYUnQrd0tRVE5YWFdmYTM1d3Q0YWI5MVB3NlpKalVQOWxs?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca870ecc-3c7f-46fa-a0da-08dac5a030d8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2022 17:55:03.2538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOjLNOojiuhni9Skl10E3PdqZyij2+gPPPiap2/uaKhoVJB6ZoHtYuSidvkdllb2kKiES4Aq5VqSUtpr0pHB4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7641
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



On 11/13/2022 8:58 AM, Borislav Petkov wrote:
> On Sun, Nov 13, 2022 at 08:41:47AM -0800, Joseph, Jithu wrote:
>> Do you think it is better to restrict filename input to confirm
>> to ff-mm-ss-xy.<test> format rather than accepting any string and
>> treating it as a file-name and trying to load it, if it is present ?
> 
> Yap, that way you pre-filter filenames. Yeah, the header checks *must*
> absolutely happen too but it would be a simple first test.
> 
> Also, you can check for:
> 
> ff-mm-ss-X.<test>
> 
> where X is a [0-9]+ of arbitrary length and this way won't have the
> artificial 256 limit you have now.
> 

Thanks for clarifying

>> (Given that, before loading, We do intel_find_matching_signature(),
>> which validates if the signature/pf entries in header confirms to the
>> machine we are on before loading)
>>
>> We did accepting file-name as input before [1] (except for validating
>> if the filename confirms to ff-mm-ss format)
> 
> Yeah, except now you want to do multiple sets of scan files.

The earlier change (which modified reload sysfs file from accepting a file-name instead of 1) was for
allowing multiple test files (i.e no different from what we are doing now)

Then we were told not to specify a filename via sysfs file (apologies for being repetitive)


Jithu


[1] https://lore.kernel.org/lkml/20220710160011.995800-1-jithu.joseph@intel.com/
