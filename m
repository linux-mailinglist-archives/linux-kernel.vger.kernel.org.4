Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A78D61A3D5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 23:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiKDWCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 18:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKDWCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 18:02:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FCF48779;
        Fri,  4 Nov 2022 15:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667599370; x=1699135370;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X2i9aD4LxMIW+O0JWBgGDurP37m/IBFKX0DHWgLiRIQ=;
  b=ZIAp9XS4Y6ofObmLuO1PqwYBMHrETbkuopvS+EMpJ3NPvzwPPQcheGCm
   7f5aVNwKS5p4wRRU2RH9gSV63sQVD4Vzai88Pha9UgxKXbuIAMI8Cb4cz
   k9xuQHNIfhosWFWkvFH/sNmI1xCTzAL7gi5Dr5+FM+AuCYzLN7gWEmT5X
   AQ75Lgtsu/bKRYso3wFixLCu8DNrAL5nD52MEgcvFWR6UykLvtAJhyX4s
   KTSb2500egO8oKV8IsiX//yHd0UPoeRGrG5l/YOyNu0gUv+l4UmzdoGpE
   TuFEGeHqKNR39vttb/kGkbNCywXmXEez3nIEJvuLx7EiIeYrfbp9GQRHA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="311834951"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="311834951"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:02:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668506192"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="668506192"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 04 Nov 2022 15:02:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 15:02:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 15:02:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 4 Nov 2022 15:02:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 4 Nov 2022 15:02:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MK6KlD3RoupjGoxFGLETFZEAXJNVB+SXs9GBbs26fgzIm+rknKg0SF3F/S64vY8gD1yESwKCdyv84C2Xew38GKx4AAhq6/4JkPDyv3MSbM9MwexWW5xgkPhXZGPAErdOPlCySUpx0+wnrMt5v+7aTegkEobdZv2Eqs67r1G3nXrS6nL6H8ifoLPnI1ReMlSV6DH6hechfFlLnWNFJ0fhqMrPKsetxZzk24KJiFqfUSRfL0Mp4KvSJT2rzHej2h35z9cbBBhKP/E61MT8uFpc7hvXk68pKLCZW+2NG5NhCaEkTLmR2+69bhOd3Pll4LZ390QJVB8rUCni8kH9vw8aoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Q86EufHg7E+4JBGLdgnJpQqLTpG9kI4Y622yKyS3JQ=;
 b=ZZm31maeX4Df9V+xiYFASlPEPZUPILJlhfoH+EFZgnWiQbxuHHPAOpu4Leau0PE8Gq9Aq7VGEIfog67NbtdY0a31A/OYXZD6AfwxdNL0VCQHWyuBVrmcmhGtF6u/DaZpZzDn9//XDpqEN9XAwo0VO5b93FxtCf/csvfugXHFX442xLOF58XyVMEmCTzM02Gag1TN5wqIL6WToyIp2chhxMzgDtHG7mruZuZxOBVbEkzMT4l4zh9F8tvAQ4POepNAxQH60yuCcf9jPu0IRHeAtbtaJGb92cPvDv9942fXDML7fZFhbtjzJATf0Re5vkyWdtMqKYOoqKiYPlcsZrgqkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 22:02:45 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0%4]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 22:02:45 +0000
Message-ID: <4ee6073a-461e-562d-5c00-d1b371288b63@intel.com>
Date:   Fri, 4 Nov 2022 15:02:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 07/14] x86/microcode/intel: Expose
 microcode_sanity_check()
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
CC:     <hdegoede@redhat.com>, <markgross@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221021203413.1220137-8-jithu.joseph@intel.com> <Y2OnHuSHgIMGxcUH@zn.tnic>
 <a4107510-add4-3d85-ed2f-2f5e8c32a350@intel.com> <Y2TuhwiGFJ1M1V7u@zn.tnic>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <Y2TuhwiGFJ1M1V7u@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0087.namprd05.prod.outlook.com
 (2603:10b6:a03:332::32) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|PH0PR11MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: 49f78a9b-cebf-409b-983e-08dabeb04d80
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ER7z4dM7Ba4Q2y37l5pnjzR7hs9BOmrRVxe2JNbqhJx3d5gOGfzbAVOIpqqDcrAPrAuXtxmJO7kpedp3ODAiA2EAQb6hZ8pr3pY3r8rM0/APg0GzfvIWf8sKLyshT2i8qeAFxjr0JmAkiNALhrTUyy+qlL4PaVk44IUzmktkub/SSaWWStX7L6Ng+2pce6n6OZKi++1yRn9XXmFx4OfBIJypIZwZljPWg/sPc0n0uXQDzP43YAqX+OV25k/EL/kfepWtDlDSkQ5njZmmfJbY0A1rX0++8bZqEeAWNTr2/ZFPRSUcNa3yyzxmtSlaH8B84qgBWfP8BVizOt3FsYFPhLMCt2vv0biEY8YB+LWFTv1jei5PxAzFQnVtrmtAMag88jmayN5+DS9rRNEFIOy5l/jVs6pjJDb0ubUhvSKGsxTZ2SquUwCQQ5zeHURm0VXa8EN9I9dvX5pf+EPK7SP94yz6k2wnPdHQrpK6GUWIYrnZwA40lViVuu6YYlZpGGduY3R41tFciVzu1uTtY9ekh0QJnwBN0Zk3DrGuYYzCu96d1Rg3Styg8qCGhzv6HZgUzD5hWWr2UEJQEu7BkWYMY2sGF1JnXBwt81i4zPLH15SZWPpDTBNKxTgZz4cjuwREaF+740Pt9D4P76jBQvzo3bYPviT65bnIJCEryYZ9Yj9OOgt58Na+DDpr5wU9LSKYyKMf7EzbRpFh5oFZTiH9+BWR4EXvmca8xYmh3EydihICuVjU39CNh3xvgNDlo4ffCHWn0R2Nm7uvQHNmJOXLt+3/nU7d3JOExJ7oYF4qN8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199015)(6512007)(26005)(38100700002)(36756003)(186003)(2906002)(7416002)(41300700001)(5660300002)(8936002)(6916009)(2616005)(31686004)(6666004)(478600001)(6506007)(31696002)(53546011)(8676002)(66556008)(66476007)(4326008)(86362001)(316002)(66946007)(82960400001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bStvN2c0U2ZrT015aU5qUTcvSUczRmh0bGtOMUZrZWFPWHR1aFNoTlAxOElX?=
 =?utf-8?B?ZTYzbXNieXpNaExSNTJETGdCa09USFVKYnhDYUphOWt5TWpYOUd2VTRSRzNl?=
 =?utf-8?B?QmlrcDZLM3M2MGI5dUlrU1B6MVY2MVE4WXVOaWFBUWR1bDdpSEhxQ0xNVlFs?=
 =?utf-8?B?SFdCQ2NSRDVFQmZIaFMvL3BvTks3aDYrd0dFcmF2em5pVWRJaXlJVXVvNEF4?=
 =?utf-8?B?TVhvbHdEMk9zdVowd1pyM1RaQjBBWS9vQk9Oc0FoRmw5cm5yTEFKSlU4eDFM?=
 =?utf-8?B?K2xQR0NGeE1sOVRSbnNETXZmbnNqbXQyMHAxZHNscXYxVC9JQmx6MUlKOHB3?=
 =?utf-8?B?Z21sb05OZWlnZmJGbURGYk81dFNZVjlhdkoyeDRsVVE1bkZvQVkvUG1oNDVN?=
 =?utf-8?B?cUY3SWNWREJsVmUvSWhqRzB1M2dNRGlqQWhYKzJwVHVuYjRJeUkwQk5QQ1l0?=
 =?utf-8?B?N1dvbjVEOXJLS0g5a3NWblZ6aFhacTJnanMvc2dzQVZNa1A0Znk0NEEyVmtj?=
 =?utf-8?B?NmNJVk9xamptZFNSVy9RU0s1NTA2L1hUTEs0eGRYTHNDRnAxTy93a1Z4ODF6?=
 =?utf-8?B?Tlk3T1pGVG9FSjFVODdhNmpnYUkyU0YwOFU3a2xmQWMvR1Iwa0NiVW1Rc2hG?=
 =?utf-8?B?WE4vKzU2MmpFOFVOQ3E4MVBSYXlhME1zbHNmOXc5N2p4MXVJTlNiRHRuc2ky?=
 =?utf-8?B?V08wb0N0NWg4MWd5bzlndUw1cmF5V3dzUGRQSmxvd2lvNjRaVDNYM01oejRU?=
 =?utf-8?B?K1BidkNQYWdPaERFNmFaSUowbk9wVVRDZjFpQVBvbHp2b2tWS2kwaHE1Tm5Z?=
 =?utf-8?B?K3UzOW03L2xNUGNoeVVhYVU3NUJZcURlTExjS1pDU2tkTGpFcnovdUpra0Rq?=
 =?utf-8?B?T3V3Y2lKbTJkZExucitiRm15MVFFNDB2NEJFUmJEc25WUlpscnoxN3Zkcm00?=
 =?utf-8?B?OVpxdGF2QTJFVlRucUxaWEpOR1B4M2p4UVVYbXZLZVNqUDZEV0Z2NXFIVThm?=
 =?utf-8?B?NTVGU0t0c3BIZXE3aTQ4VXlZY0szM1F5VVRRUXZaOEZyc083TklURzlCQ2hQ?=
 =?utf-8?B?Nnhwb203TXMzZ0x4WFJNdmc1dmtjQmVVQzA2bGQwLytjQWRBUWh6cDVaNW5X?=
 =?utf-8?B?TUtRQ0hYcHdYQ2lET00wWlVEOXMrQ01Id0s3amlWUUhub09pdzBvem1lZ05h?=
 =?utf-8?B?MXFBK3BCclVqMG5LSDc1VXMycXRpWHZJdGhKNVhnWjc0RWlicVp1bVdBdWEv?=
 =?utf-8?B?RUZ3VlAxb0Q0b0s1KzUrOWlRTEREbWdvZUlob3BjTGNqS1NPNWZ5WXFJZ1JO?=
 =?utf-8?B?M0F3NlFKSko0T2tRa2N6bWFHOXZEZzF4ak9STjlFc0lkcEt4RTNPRlI0VS9N?=
 =?utf-8?B?UmZZMEYwYjkxeGFXd200c0FxR2hzMkpyQXdxQmg4QVB2YmR0ZGpxSERpOW10?=
 =?utf-8?B?R2RsSGxFOFMwakZXZzg5K2RLb25STHVKZk1IenVMbWtWYlNiVUNHYUJKRmdV?=
 =?utf-8?B?S0dvNzVxNnc0WTI4VE15dU9DTVJrOEtrSS84NEFERGJyQ29uQ1RkaVE3NmZk?=
 =?utf-8?B?NDY1Y0FwL3hxcU1uaU8rK1FIN2liSFY5VTRzSU5pbm00RXNCcEpNenFnTC9Y?=
 =?utf-8?B?WGg0NTNOV001dDZUaTVtbFdtRjFxeVlDZHhjU1JuTXJzclM3MUxCSit3K2E4?=
 =?utf-8?B?Q0tMNzNKSmRHSzFURGk3bW5DUmxjVGloOU5hS0kwQ0VKL2NrRmVIREJTV0Mx?=
 =?utf-8?B?bk8zTmJVbWtiRG5vOURCOHpaT3NQYXpGWDcrVERLR0NRYXEzK25QMGRNZitr?=
 =?utf-8?B?KytWbmhubWFrRXlDVThENENQTDNhdFBoTndpREloRm9hckV0MnB6WTNDU3Uw?=
 =?utf-8?B?b29aallpWDhyVWhEVkUzU0l6R0ZmbFlyZG1OUWhrVzl3RjE0K08xK282R2NU?=
 =?utf-8?B?Q1BiRHVrR1lFUm1OeDduUVo1TWQyaEVlVjFhZmJkV2Z4WlpTTHpYazhmMGNP?=
 =?utf-8?B?dUoyRHlxOVN5Z2VibHpici9yUmlQTzE4WmMzSm13KyswL0xYaFI3UG5CdU1S?=
 =?utf-8?B?SllZUDFtcldZb0ZlaUxnMlJQb2ZIVE1FeXlveFFYK0k2NGthbFFVOE16c0hH?=
 =?utf-8?B?aGhWS1V0TG10dHVhRkwrdzhGSVpMOXA5MkFwS01iTW43NHRrVks2ZVpYSXNo?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f78a9b-cebf-409b-983e-08dabeb04d80
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 22:02:45.1391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tu0NjGo9cb/gULZC9J+lACqaS+u6vMIQtIo3eoAxdWZdm/t2syE99jWwFUppeToni5wL1hcEj/rVlqVNs3MJRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5832
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/2022 3:50 AM, Borislav Petkov wrote:
> As to patch 8, that metadata checking should not be part of
> microcode_intel_sanity_check() but a separate function. Along with
> microcode_intel_find_meta_data() - all those should go into the IFS
> thing.
> 
> When microcode loading ends up really needing metadata, *then*
> that functionality should be lifted into a more fitting place like
> cpu/intel.c

Thanks for the pointer. I will move the microcode_intel_find_meta_data()
function into IFS driver and also drop the metadata checking from the exported
microcode_intel_sanity_check()

Wanted to check with you, if it is okay to rename the first "reserved" field
in microcode_header_intel to "metasize"  today (as shown in the diff below)
or would you prefer to do that too at a later point ? (doing so today will help to
avoid redefining an IFS specific header struct, with this as the only change )


diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
index a4d2ed43193c..bec23c11ca52 100644
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -14,7 +14,8 @@ struct microcode_header_intel {
        unsigned int            pf;
        unsigned int            datasize;
        unsigned int            totalsize;
-       unsigned int            reserved[3];
+       unsigned int            metasize;
+       unsigned int            reserved[2];
 };


Jithu
