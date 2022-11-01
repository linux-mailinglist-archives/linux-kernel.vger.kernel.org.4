Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741196154EF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiKAW02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiKAW0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:26:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3A01B3;
        Tue,  1 Nov 2022 15:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667341579; x=1698877579;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W6VZFJknwzb79Q0qteUErl+cRBqrwFdKkyECJ+QplDg=;
  b=Ngexn1FDnd58vWCUUPk383KEOh8qGL3NxB3FsCFL+VS8ACk2AFIexNcy
   aktjNEixVsgML6B1t52jKirjWFNTHyC2TQV4Tp8q8pkyVd/aS4Y9//8xG
   pn9w29TvJwEHaWLeMerk2ZW1KXpJ1Yx4gui3BxL83FFCH10Y00ZAXFpuz
   pE18ELPy3TQojAouttX8uMu23NvTVwg3snGEwE0FL/KlM4EpZHpogdXNU
   hGuzvnsHcln7to0JyLrGhBD/husxEzBC1sLH65FaZxr/0iuzmALTEOkLC
   0EcbmtNhPIYU1d+AyIgwahMH3oPvmM4UdWIvQz6gAQMiAuGrCtqKAwgRZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="306872766"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="306872766"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 15:26:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="739505023"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="739505023"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 01 Nov 2022 15:26:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 15:26:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 15:26:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 15:26:18 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 15:26:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neLUdKMS2/thb7ao4uJDX5lca4YSh4I1giTrfFlWQH+fJe6pefx19Nb6tQ6pG4HCTYGeqo/yx1Gw19GwhQJ/E4UOOX9l5IaL41czPK2N0fvPAzhGko5kRFWRQRhx4QzfrniEqX0mN73FXmN4mZZ8q6O/gMrUy1a6qL7eofcrCYKY5kPhyWfiabbJT+F0Wz3n4w3DTZfPMunJxXOowCv8q3E9ZeWow81LGERg3qwPpd9/juPIhbZReEW7z53AnosHr6id7w5YGzbjC7TTREW2EVC9GQGPL2WV+xfMbzoCTT2525G+Y0gXe61diO+Q1ymiDvrn/mHog982+C9QUorn/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHSHWDWPOiSxfvsBizDCOXTzbcY/NTysZkLyeylStpA=;
 b=O3xCXkMhnFpsNpCAnKFf9hM0gGZpsiQ26OXATuyKZgZKqh5Xb2AQz7X/I8o6Ybl9nC8KYJ3vX0Xm/DLvW98VnmE1Vrqlm01jQoA2XaFSA5Fx1i2G5KUv7N2XxqIo8jA/67AkJOhPoVIDTD9xd7Njo3n0gB5BMPa0aQo3TKG+gNK0FX4bNUGAz0GuX3ODaheyovkTzaOz8vhcb5RPpYixfSLflAtU5wMzIHGzO1KMbjxyoiQJY5XHWqBKbiXWm54Gsxvk/sh4yTbkZlgrercY6ASImphZvG13SIR/bZR46+hY+d3uRxmzrr6LX1AgjTE+iFqVYMCqGxIZj8ibXsH++Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH0PR11MB5879.namprd11.prod.outlook.com (2603:10b6:510:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 22:26:02 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232%7]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 22:26:02 +0000
Message-ID: <9bfd45cb-ab5c-1d46-1e16-03417c89298b@intel.com>
Date:   Tue, 1 Nov 2022 15:26:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 12/14] platform/x86/intel/ifs: Add current_batch sysfs
 entry
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
 <20221021203413.1220137-13-jithu.joseph@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221021203413.1220137-13-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::28) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH0PR11MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: c8652805-474b-4c87-1c8d-08dabc580f5a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9SdfepCZ0hgwq5XL2bHx5eSXdOrkQb7b9tdC3nDH2yM06hK45tQjmmL7QTZy+YeJVp5Sq9CU3izxmE0YZJqsE/ueEHAI22/pO+37Qrwijg6EhEB8LCStImNpcyrmNWVOcBlr9mjZTLsiKenK7xWjIwdgAZLhJTrnjJ3YO35rU5TD90//Gcgqgy73GSUYXwBUHsSYu2pBtHIAVvF0dxBEu2pSKHTtGzFpiXlJ0dQ68ouSM7SmyMdLHVulnmb59YdxUcbcdanC8PWPe3n/d6qqoLB/L+4wUHKG+fhBvM/sZNyI/8PEs9yZrIeIG1Y6KVn+QWgZdCg0ltWFw4pZbDd81rbK1T1DlPSORwa8VYLqgtq4Ac+VUoxZUFEQ531JvG47JRaWN5hR2Rspx4Pj1qXHVSTohLgbJCU2BwYJho6uoJgE+cuNq8BF1MGATyDY9RpZQLhBWpvOafT/tQNMFcNxUpXRAdKIvP3WBidSfSaOb+DxJXsiV36fyy9AdmzN94ZGIId2TggQZrq/8gV/biw7G9NSfOuL/yBZTmgVzIM4Xu0u7+kVC/rTqFgH+g4U1Y2B2Dd2/cyRbrwIBh7nxshKTIys6sXPt+bKbWCl8yGzlhZvrXML5Tlb9PcmqtAxznMwqSQow8ir65woa72V6ttCFt44lolW6dJbziZn0GbRma7J2GjujJAfeGjD4vTqb+pQYYQzD9pA+QuYnb7Ad1QGkVpXWeFGDHhy22ZIpe+2k5KCdSnvq/2apA8sFMfeBah7BZRV9ZuQ7QQIblQZcudEern+bop12S5f0H+h+mqDio8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199015)(83380400001)(31696002)(86362001)(36756003)(38100700002)(82960400001)(478600001)(316002)(31686004)(186003)(6486002)(6512007)(41300700001)(26005)(44832011)(5660300002)(8936002)(66556008)(7416002)(66476007)(66946007)(6506007)(8676002)(2616005)(2906002)(4326008)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2lsSTdXR1BrN3p4TEVEbng0cFpNVmNjRGJmbmFUdDBEdkdOdGtOWlZ4TjBH?=
 =?utf-8?B?K0UyREdsZXZ3b2xkaVdIeDNZeGNSbnVOYlYxbk0yS21UK2Q1UEUyalZKMzVz?=
 =?utf-8?B?Ti9mTzdVSzBLM0J3TlhYMmJaa0xYZTMvSnVOVElVN2FsY3h3UEtCVmFDTUdl?=
 =?utf-8?B?U1FnQWJFNFYwaHJIcGNDMEh4d25VM1FEQnp3OHhNbFNOQVpQMGp0YlB1YTRL?=
 =?utf-8?B?ay96ekJuZlFDNC8rd2dwODZzL00rVTByL1dNay9PK2p5QVVCblBERmRFYnF5?=
 =?utf-8?B?c3ZVTGJYMVRqQkVrVmRJMU8vTzNHd1hMSkh4ODJKN0FJeHNVdWZubVFkbnZW?=
 =?utf-8?B?ZjlCM1N5bjNsdThpa2RMUHNnS0VBaHI3V1hZVTAxODBUVVhVeHJWU2pjeTY5?=
 =?utf-8?B?LzBib2NDU0NnMEtEcjY5cGpoMDExVks0UFdka2kxWFBPNzlSNjJubnFLOVVH?=
 =?utf-8?B?U1UrVWNFTHlGMDZhaUdSeE5rb0FIdmtVejJFZmE0V3FvYWJ1YWs4UTlPcUNP?=
 =?utf-8?B?YWtjVlpSMTVzWnVBMlkxZWc5YjhWdmZoRllUMUVqQ3BSOUxJMk0vc05uc0JP?=
 =?utf-8?B?OVhtZTZTMXVEVFQvVmZ1V1ZqbkpDT2RCYSs5L3VoSDJ4ZzF0eVFGaHlqcGFW?=
 =?utf-8?B?VDdVVmx0eVNiYnVPMlprT1l2S3dBSDlrQ04yQVo1WFYwM0RtVWNzWVZBVjZh?=
 =?utf-8?B?bkxGSzF0UEpyTU1TQ2JYR2s4QUgycncrYU1lY3Y3MlBwazNsZVNXczJmUU9Y?=
 =?utf-8?B?VzVUblE1VWpiVFh1NFhmMFQ3eDY4SzlJS0VlTzlqc3BTMnUzekpuWTNQSE9y?=
 =?utf-8?B?TWpKaHFCWnFMbXViT2tQVzdIdHBTUEtpMVU5aVZPRlhEdXdabFhYNkpZUXdY?=
 =?utf-8?B?OXpudzFIb3d6T3hndmJQOW1RRkJ0N21ndDZFYWd0cStKcWR3cEhNVWFETlR2?=
 =?utf-8?B?enR0UDRYd0tKd0c1Q0EveThBblBPSmZrYTVOMmx3b1EvYWptcmVyN0JyMGJL?=
 =?utf-8?B?MEFUZjZBV0xvd2Q1R21xNjFsV3U5RHV1VDVDZXlhNEx4VWRBTzJZejdtekF6?=
 =?utf-8?B?ZmRMNzJHR1pCVkxLZVVXbFQwazZNdTE1VlBpWjh6Z3QrbHpUMUFXcG1FUFdh?=
 =?utf-8?B?Um9RcElXREdVUWNMR1BDakh1QldHVmhvRWVjYTFJN2sxTHZPTFE4RXdvc3lC?=
 =?utf-8?B?Y1ZHQmFtWngraU91WVJsR3c3VWMyZjY3dUh4Y0ZkOGRXMUlhQTIwbnowMEFP?=
 =?utf-8?B?MzZFZ21sN3F2OFVTOFFqS05lUlI3R1VGMVl3blpkaHJNVStkaTRieDBkQUho?=
 =?utf-8?B?Q2V2NnZtSU8vNDFzWXlvQTJudmMxNVRsajRSY2pOaFkwNTRQUnJGN0dpUlRL?=
 =?utf-8?B?NjFwcHIzZy9tMFNDR3V5bUpvcE1DOEtrcjVPa3VENWNUeFY2b2hHbFdwYmhu?=
 =?utf-8?B?TUxhNnp6WVF1MWttZ0R3ZzBNOGVSUWUzVFhjeUJWUjZseEVIUzhFSWZpb3RK?=
 =?utf-8?B?bFpSazBIRTFWcjdLa3gwOWZOMjJJRzlkRkNYQnNXelFSdGJjdUMvVFFGUDFC?=
 =?utf-8?B?clhBYmZLcDdMNGVmNmJZNVg5NldJZEV5Y0RxamNNZzJNWGFqQWRhNGFFQWpD?=
 =?utf-8?B?dUxBZ0NxeVJLcW5TWXArb2MzWEZKdlc1ODhkTlMrYlpCS1VLdWVQVHdlbWpZ?=
 =?utf-8?B?ZU1RdlhJakdSVHB1NDVyNnlnU3p6VVF1QVpWdStBZ2E5bzdPT3cxQ2xaRWhV?=
 =?utf-8?B?ejc3czFpSE9ybUFhZFd6dnk3UTQ1TGFRYnpWRTRGeUZ2aENXcFRScFc4Q3Js?=
 =?utf-8?B?d25meEl5L3M3RHBBTGQ0QlN4OWhNVGZ6S0VKNng4ZmVFckFmejlUajRuU0x3?=
 =?utf-8?B?VWFGZlllWkFlYkRhM3Bsdm1wTjFWeHk3TDlNU0FQVGZQbEMwY1p3TTEwenJG?=
 =?utf-8?B?U2habjFsMk9sL1pTU25TNkVBRVFDZk1VeGNiUXhLNi9Hem9jdVpHQUNPTTFr?=
 =?utf-8?B?U2x2VDlzQzV1TXgyR2pxODNIMzNzQ3ZueXQxakliV1VqUU5sMldhTFp6VWwy?=
 =?utf-8?B?VDAxYi9vVHpodHNpQVhvck9TVWk2QURxNUhBUHRwSnppdnVyZytXV2Jrb0hl?=
 =?utf-8?B?ekZkWUZVd2lIcXNDN3o0SjlwUlZKRkxCMHY4MUR4MnEyUW5KUEZoakVnd3Rv?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8652805-474b-4c87-1c8d-08dabc580f5a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 22:26:02.7835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdRCTus6/jHmtJsgygUWDeYmlTzMT7EBtOLCpzrC4KfLSaRBM3AU66S/RuxGs3TcrWmFH+xcqmgXVzXe3rafYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5879
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/2022 1:34 PM, Jithu Joseph wrote:
> Initial implementation assumed a single IFS test image file with a
> fixed name ff-mm-ss.scan. (where ff, mm, ss refers to family, model
> and stepping  of the core)
> 
> Subsequently, it became evident that supporting more than one
> test image file is needed to provide more comprehensive
> test coverage. (Test coverage in this scenario refers to testing
> more transistors in the core to identify faults)
> 
> The other alternative of increasing the size of a single scan test image
> file would not work as the  upper bound is limited by the size of memory
> area reserved by BIOS for loading IFS test image.
> 
> Introduce "current_batch" file which accepts a number. Writing a
> number to the current_batch file would load the test image file by name
> ff-mm-ss-<xy>.scan, where <xy> is the number written to the
> "current_batch" file in hex. 

Any specific reasoning why the name "current_batch" was chosen? To me, 
batch seems to suggest multiple or a group of files. But in reality only 
one test file is loaded at a time.

Naming can sometimes be quite subjective so it might be useful to get 
multiple opinions here.

As per my understanding, there is sysfs file called run_test which runs 
a loaded test. Instead of current_batch how about the name load_test (or 
maybe current_test)?

load_test - Write a number less than or equal to 0xff to load an IFS 
test image. (Description as-is from the documentation patch)


>    * Running tests
>    * -------------
> @@ -207,6 +217,7 @@ struct ifs_data {
>   	int	status;
>   	u64	scan_details;
>   	int	cur_batch;
> +	int	test_num;
>   };
>   
>   struct ifs_work {
> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
> index 5fb7f655c291..1f040837e8eb 100644
> --- a/drivers/platform/x86/intel/ifs/core.c
> +++ b/drivers/platform/x86/intel/ifs/core.c
> @@ -22,6 +22,7 @@ MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
>   static struct ifs_device ifs_device = {
>   	.data = {
>   		.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
> +		.test_num = 0,

Is this initialization really needed? Wouldn't it default to 0?

Maybe if you explain what does test_num refer to it might answer the above?


> +static ssize_t current_batch_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct ifs_data *ifsd = ifs_get_data(dev);
> +
> +	if (!ifsd->loaded)
> +		return sysfs_emit(buf, "%s\n", "none");

Why not:

sysfs_emit(buf, "none\n");

> +	else
> +		return sysfs_emit(buf, "0x%02x\n", ifsd->cur_batch);
> +}

Sohil

