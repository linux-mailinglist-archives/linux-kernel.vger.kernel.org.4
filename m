Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128E8622171
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 02:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiKIBxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 20:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIBwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 20:52:53 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133C566C8A;
        Tue,  8 Nov 2022 17:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667958773; x=1699494773;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8RLO7vmSprYc/ZRVtzcPDPr4hT2eL3OO5mOHeL8oGPo=;
  b=J9Krg/H0LnU+ZFWNru0c1o14jaVIJ12cCVkB9RMxuGauSam2BIbcqOf6
   M5Lqnrg1qCZKKPomWmFnLZeqUrznaukWaz4yW370kALPAb+Fnky6K9M/d
   Rq1D5we6bfE3J3q9aAGbcl9fGYhdi5wxWNWIC2WMjaQZBVTourEyGPBC2
   7Y+ZzYjCiUWUsgyzesN5F895RMx1qtDK+78KzOlCQqIuYuDtzFLDgu55r
   bH09+56pV3at3Rd4vXFqKto39x5VXZyq7e3BXvIy/bhkTUIehdb6r7wPN
   RdmynL/bT643hzMX1tpFug7kLwhLy2xFP3VJmBSLhMHi7jHoyUfcfHVc9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="309571597"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="309571597"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 17:52:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="636554459"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="636554459"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 08 Nov 2022 17:52:52 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 17:52:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 17:52:51 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 17:52:51 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 17:52:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8U6eiMiAqNfyuh1iSLNmSsTJVQi37DX9qIpCP0yjSOpkx1BoyrwaTO2hHlgR6iu8wS9guFQDpYM3oz87Hyp5rYFTKgReaG5jth/dagWNObj98LuDFl7A6V71hOc6BDxK0OFgyuyNHw9i0x5h9MxD2EZia2aLYSN5k9kWK9zHqicM+uVR2/hxHbw/fTON4F8o6ILBImsi4c2OSjrfH5zJNUibmuEf6zZKU8NA0HBA8R1WAC0rw0ufoOrFCZSOt4SK7VaMJbUQmVvkGX3W19SY+PMG8FGaMzh6pWsVmrixvoUSsQ5IagAjFR33TY3q249+ANZj+h5tmgVcAvxraof/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOcJ1Ve5CyP/Ah57u+ZnscpbN5hbAAQCLcQ146U3Ajs=;
 b=nwXrT8TLBHLOVdyATvxFH41fuXCBtiMyY0bZiydyTquChxXJHoDAD1ilU+ijYWqmr1pmD3jHJER0/8k5XSTD8DCi+NdQX2BwKrFxOOq6b/ab5snSkwUM/4Umj0+rpEqm0jv1JOMF7KGizOoYUtyAhTjosn1MEk+sI8vdap7RdL4jw+1HjRuU37lFPGsFEf+0XDC4mwgMCGFAUopXhgy9bpP3nczoUhnthkxitS4WWn31SISfFV8sygwLJi63vaCQkS47+6DS5GP17ero0Fx966TwKbgF7wMXPfZf4Nkb4Wwwqz0zxn7PSzCXNvkISAOMK57GZX+MVN7LBL+G/RlXVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3322.namprd11.prod.outlook.com (2603:10b6:5:55::19) by
 SA1PR11MB5948.namprd11.prod.outlook.com (2603:10b6:806:23c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 01:52:49 +0000
Received: from DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::2720:c97:3346:ede4]) by DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::2720:c97:3346:ede4%7]) with mapi id 15.20.5791.026; Wed, 9 Nov 2022
 01:52:49 +0000
Message-ID: <37aed949-925c-6473-139e-473563188622@intel.com>
Date:   Tue, 8 Nov 2022 17:52:45 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 01/14] platform/x86/intel/ifs: Remove unused selection
Content-Language: en-US
To:     Jithu Joseph <jithu.joseph@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-2-jithu.joseph@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221107225323.2733518-2-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0079.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::24) To DM6PR11MB3322.namprd11.prod.outlook.com
 (2603:10b6:5:55::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3322:EE_|SA1PR11MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f46780b-9d0e-498e-1442-08dac1f51ad9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DBtrs5UQpfiRZkhjkkD2+Pb6ScrDgR6rgZI7DgydRnAJAGJ8ft+kaIx0cr3deDg3sExD7rHdQjW+z/n13U/xqD6hi02gQZu+F7C7LXkCEp/S//ZVc39nEj+NsRJHu2TpJd177DjoKMUw9XrH/1LvhArs0EfJiwmmM8ohZvSnyx0khhDxpVZAAvybh1r5lG9DJ4XZIoMscWpHBAOpX8Y8Iq+0CLy6QBiZ6hsFkkNv/tLzxIk9yI1IIvPiRksuwyPQotLYysfJ4TkfFDZKcKTVPwP+B4jzejyAt0/FZfW3hKIeCF3bmRIncGgjxI2BlCdiIKPuq01mXztqBWik713s5Dgg+1b2m7DUR8Zqt/gLPuvfF5+cytNCQB/ve+nlkynN3RHmSn4XJ4ME97Yr8EqhkGrrQ63s9p/RJCcux95HbJi4m3Y5f7FDP0j2zXGaw9ggBVJ8npMyIpUqtBj6Fv8oafSEadFOtlzrdaGzwbwEi3mPqd6XaC4l3it5wFAPugLvDW2cqhCjfcDIoHXogSREIW4Q4yiF5VtUrSbXGVmGuVMYHqYwoaOoss0NotyRg4w0FOdagDNSiCxtWztRSgMcyiSvOvyJU2MSBY5Hz7XyFmYEtHwpfHr1dXFnYfKbwMLQBq3mhOanzGYnge3phf4VvfL0V2pEM8YngW2wuwUxxlq6316hn6AYY1r/RMpHW/tj6KUPrTfs5iiLlem0ozc4RzQfH05d+SjWYrllZlrInIeFUHJIDm/X45mk774qTrZdZd7VqZJu/XLZw0YT4gbhc4an/Pyos5qnOHU4dTZlNok=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3322.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199015)(38100700002)(83380400001)(86362001)(31696002)(82960400001)(478600001)(5660300002)(6486002)(7416002)(4744005)(8936002)(6666004)(41300700001)(4326008)(8676002)(66556008)(66476007)(66946007)(316002)(186003)(2616005)(44832011)(53546011)(6512007)(2906002)(6506007)(26005)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmI1TTNqQkhVTkFHTFpxalhEeHdYV2VMb1JkS1AzYUxVNXJlVWswSVJJM1JB?=
 =?utf-8?B?VWtGY2padjM3M2gxWW1wNTMzY0hranNEMXFtRFpTcXBTelpNWU9BUkFOeE10?=
 =?utf-8?B?NDBWaFN3amtjNnNTYm5WalhxZVFENWdwQ1piTk42RTFtTjJiamgrdzRzWG1l?=
 =?utf-8?B?Wmpva1NnZ0hkUit6VXRaZHg4VGsvQ1cwWkg3Wno2QVdOd0ljaU1nMmd0bkh1?=
 =?utf-8?B?Rlp1eUJWazJXeVhGSnR3RE42Q0ZLVkFIeUVQb2tJVGlEdDIxbVBsTVczRGFY?=
 =?utf-8?B?dGx3bFg3OGlEY1NHSDl2L2VZWThvNkgwUU1vRkZGM1lHN1BxZkNkWUxWYkdD?=
 =?utf-8?B?WDBEZDA1VENLWjE1dHdRS0JvRlhkWUhwLzZCRVRPQjFZbmxkL1ZMTUxZSVMw?=
 =?utf-8?B?a0k1UXVzWjg5cVNMbVRBYWdJZVF6ZFpUMWljdENxWTVnektzUVI4SzduUm0r?=
 =?utf-8?B?aEFKeW82dENxSjZwM054ZWJ2bjdqbkxJZEZmOTRSMnN0cThPM2ZwWDZUQnp5?=
 =?utf-8?B?Rm95QjgrNkFBZVU2bmJRZTNScUNKZzQ4bEMydzh3S0N0MTU3QWFQWkZFOTRt?=
 =?utf-8?B?SndBK01wa29qK0xLTVc1ZzgxaExIRVF3RTRQYzZXT3hVUVFQc0lVbmc5ODFH?=
 =?utf-8?B?eGh6MHVkU25rTGxwaDhsOTB6c2R0Wi9WTVd2cnlrZmtKdW54TDRFY2tqVG5L?=
 =?utf-8?B?OHFhQ093dkdGZXpNdlZ3dG1pbm04YjZ2NEorRGNWZGtuQ0xwSnFZQlBtWjdo?=
 =?utf-8?B?ZThrY1ZETUt5NVVPTXNPcGw1SHlKVTR5ZG5VN3N6bzloSEZjUHJYL3IyeUNE?=
 =?utf-8?B?ZjRwbWZKbHNYbFBvNEsrejBHTDBmeXZzcXo3TXR0NHRFd003dHFnVEhHTys2?=
 =?utf-8?B?dnhtWGxMdS9aSHFSWWJDaHRkdTFlQUw3ZHgrVkNWbEtqdGtxaVdod1l1YXJJ?=
 =?utf-8?B?WFRUOG4zdVgyWnJLNXpDQ3p6K241L0NIL0tRckdVc2NacHA0c0d4c2I1RlBS?=
 =?utf-8?B?UjZ2dkpOcSs0ZWh0LzRiNWdkdldvQ1ZnSlFObUJZMUhBTDV3blhXT3kwcWN3?=
 =?utf-8?B?V3Z2SjE0SDBHbWJlTnBna1VYV2JkeU9FTDMvMG9Zalh6ZWZGMWdFRGJFS0Vj?=
 =?utf-8?B?KzBzRTNIRkpicFNYUUhmcDZ6OSs5UW82dlBhY2JjVUxHeDV0OXBsU2gxY1Zs?=
 =?utf-8?B?UnRhSjNPZ2FMZWZDeWNreGJUdUR2TlVCeWdmYkgramRvODdnREdDUmQ3ZHdT?=
 =?utf-8?B?enQ1TUZaN3JzREJXeStabU92b0oxYXQ5a2tTdFpGamJOV29ObGd3c2pxcURR?=
 =?utf-8?B?WHkvbzlndTJpMzBPMXZDRDRQVGpsWUZtcW9QcWtXUkJoOGV5TjRUZHZWcVhh?=
 =?utf-8?B?aE91VGxsa2IwL3NNT2tHZjhlcjJHdFVzeUlyL3NiZllqWWhIM1JKaEZuYmFI?=
 =?utf-8?B?MXkzRWNCeWRtY1pGQ0NkUDFWdEVWaDhCZmJHcnJEekRyTVFZbmFaTm03YzdE?=
 =?utf-8?B?SXFCRGo0NXBUZ2plSUNGZ2E2Uk50OTd5amlkM3BvUFcwN3Y0eVNxUjV5ZTll?=
 =?utf-8?B?YjNsaFJ1SHpyd2VtK0txNk1rYTJuYnlzQXJoRzA5Qy96QUVLMjZKbHJWL1N3?=
 =?utf-8?B?Y21HTEEvR3hzdEF5S0o5QlZ4dlh2MlZUVitUYnk4b1d6WTFDd0wvaTBPQ2gv?=
 =?utf-8?B?bDYzb2pseE9VbE1ZYk1XL1ZwM0ZXL1R6RG80YWxOM2k0NjBkS3NWcU95NkFL?=
 =?utf-8?B?dUJmTzAwWUdFN01rWVNQakJmZ0VpbGlUeEdEL2NOWTdzd0huMHlnQmZvSDZj?=
 =?utf-8?B?YnZ4WXFsWDJRdUNYVkhiMkRlZnRQNG5Vb3BndnZXYXJRQXVwUVY0ZVR0OFZJ?=
 =?utf-8?B?aU5Cd1NPUVROYWZvSk9VZVphZTNXZjBJaFZnOFVWamNYME5RdTA0djRZMGtL?=
 =?utf-8?B?WjBUSStNZCtrRC91M0NsK05YMzJ0bThBTERDci9uSTNZekM0NVNOYjU3N2Q3?=
 =?utf-8?B?bmV2SE5LTHNuYStTWXFJcWdWRVhRSEdtTWpqNDJYRWJ6SWlLSkExZ1Ryc2Zx?=
 =?utf-8?B?N3hMejVPTkR1TUNNTmpiWFZPMG84TWhDdlZnbmM3SHpmM3Z1ZHdiQWJ6RVUz?=
 =?utf-8?Q?NBXdyQKyInakEteEn0NIoPVD6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f46780b-9d0e-498e-1442-08dac1f51ad9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3322.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 01:52:49.0116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLEdVaOF9yDQEHLT3n22RiG3xrMhTlOxmEvpOPNGUcveh1alamwvRxbUAreKMB2ec273/l/OtNRqxolpjMkksA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5948
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

On 11/7/2022 2:53 PM, Jithu Joseph wrote:
> CONFIG_INTEL_IFS_DEVICE is not used anywhere. The selection in
> Kconfig is therefore pointless. Delete it.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

