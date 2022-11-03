Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CF7617894
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 09:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiKCIVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 04:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiKCIVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:21:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DCF63EC;
        Thu,  3 Nov 2022 01:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667463676; x=1698999676;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FkP6UjKq4S2akcKSLQtUPTsOoiBbWtQFSMBefmDE2Bw=;
  b=XDJrdGILJOaz5d1k6UKEI0hvtCmtdn12+jlRnPlrHFgACQYXrrd2sb32
   B9K7BrNxs1pw8P6xjzWX9Zte0WgtTC9yySzXHJtRQ0aKIxhgNCqBAHS+G
   wmh+aBl0YCx554Y/pucKKxLuo2t5b82uA4tYBYKEejGlQ75yu+3gEwjvg
   uc1Wnc0g5m9onJoXnGezEtOy1c0w0iI+Po1ETQN52NFVD+Y6Vt3fKELfz
   Z07pTueIrAD79VkdfEDTrkfou49HunhyHWC9s1HAaBLtZ0LEYtQZ43RPh
   X5lbZ9Eu25Ma6awBnSlzm1PTJa2smqZ9babusKEkqcMD37k7ouJj5hzLi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="373847769"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="373847769"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 01:21:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="777215387"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="777215387"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 03 Nov 2022 01:21:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 01:21:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 01:21:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 3 Nov 2022 01:21:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 3 Nov 2022 01:21:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBovEK37bZlX5jFJ6taW2f10diJzg8c3py4JZ1OMJioIBpCBSCT4qmzk1rfr6ThG1rGeK0h9WJRleVQswQjqhRzmGPBjTwcKfjRhJnWoU+Xk2apFIF46hwX2pTnEY4EeaN3iBB2qa2MsqMMCbP4j4mrhvsNyXacApdNhD3LBuKzwCjwgpADxW3FdKFcfvqTqK+OzR/f9xX3c1Uhj2KvoQXFmBywlR/lVPGxWdfpB8CU8FWuOEUNqbl65bsC6/v8180yXe/fXnKOS1geO/KLpHev62X5Q2fVUDnKsAlgSfKXE1u+bfFm5xZ1IdA4+lqlobBSNagwGTev11B/fo8E5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsArxUlSWQ6E6mfGH5tX8wUOYqAK+mUinLxT8zC0wcI=;
 b=iqU0mHNFjjv7Q1fGGwdcvybVz1gKxq7xaiCyPmlccbSAIYiyeJjc+LuTqiYGQvpOL3fDoI4bW87/dxa2pnfjp+z/7AsDF1ICFzIC2op+XLX2k/jKkik458bMNVbUyOxH6YNe2cJZpYjcWvpHhdCdeCJdFY+5XhXyYqs39vedUSwLAbVZ36BbIuXFyU7MahBjSY2emzjH3ZgXD7PU1YLMjRUAF4xq5zjJNtpCCjCV0ZxD8B/Z4H6hMzbyV6DQ3HQL4e6Nxncs+mA/zSdKqsPNdwwxf4qZbaGqUmVgozLQFCkoUWT0p64ZE2wjyzEAOqVHGaOTfuHDSt+ZIbNq9VV6aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CY5PR11MB6185.namprd11.prod.outlook.com (2603:10b6:930:27::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Thu, 3 Nov
 2022 08:21:11 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232%7]) with mapi id 15.20.5791.020; Thu, 3 Nov 2022
 08:21:11 +0000
Message-ID: <32e8a0a7-7364-bb8a-2e5b-919b25f54905@intel.com>
Date:   Thu, 3 Nov 2022 01:21:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 00/14] IFS multi test image support and misc changes
Content-Language: en-US
To:     Jithu Joseph <jithu.joseph@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221021203413.1220137-1-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::22) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CY5PR11MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: d52f0625-3429-4ba6-7773-08dabd745dc6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cQoVJHjDYCo/EVX8fNUc1JMy+1/Fef5r2gmVzHyQfASyPycwhPsPViT1RI7vnyExTc2Cgev9JKR1LCgEL2z2dgrqHl7J8GpcgfDPjT65KgTMmsfUdbqXZKQ2W+B/T/2bIygdSmEoKVW4nf+HhXXeC/SREz+IvSzXwUuicE21dIdtvjVTHdzihocFD1ITIDZKnyAr4p+o3BFXhNltql50Nax/9OWRMfnj+uFkLujgIuPjdJrX6Hs2vvNp98/TZNsmnXai1A81cSwrbkDL3SBesobaZaXmX/cX5QUurx6iWyHCg95qM1ZLg3SVDkvD2oXrXaWnorZNnTDG5K+DNz0+qJtzRnvg7iv4X9mL94+3mwGZRR6zl0k/v3PrxbTaHWec7h9obdVT6edLHmKsdgdQE/MIalYIVAcL1W7RU+TiBj4GZuULddJRbU2jR+f1D2YUmYj/Qko+oDjcbAVbUhp9ckUTGBFAcvJEIwQLFB1BhxZF/6sPW2TYjsN+5lisqoEADLz6iclu5taAOCqzeGxkJOCLQHUP+hzLIjyULrKEnTyK2iEy4vVeeYkBAB/Tmgo3bJ2jH1MrTQfmIuTUAZIND56dy/9q1ZOpbd2NxPJCgXNGjX1kx+1OIQ3rb/N8TTU4xIr9S8+NlZ1JI0C8CaLt+yeC9SXSREglrIJ68ygq8CTwR+9bGCE5HQ9f6+xzQQMRqAKN7dNnSHzImXP0UPKSLlhuLzX6fs9TazMcNV2OhaAlY8vX38EdiDMdU0jhrRtB3ezguO4cd4X+frUBDgPezCT/u1+pZJSBEWs0DlGTMog=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199015)(2616005)(44832011)(41300700001)(8676002)(186003)(4326008)(66556008)(66946007)(66476007)(6636002)(37006003)(4744005)(6512007)(36756003)(5660300002)(26005)(6862004)(53546011)(31696002)(8936002)(6506007)(6486002)(316002)(7416002)(86362001)(478600001)(31686004)(38100700002)(2906002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTFtWlRrNmNxTmhaQ0ZxeGZhREpZMDQzck5mSlMvWUJkMmVtY1VMMXRQTy9Z?=
 =?utf-8?B?amdIcGo1TFB3MVZIaTZScGtOa1BvYjVoRndHc3Npek5mb0Y2RVVTUDhtZ2xt?=
 =?utf-8?B?QTBObmhlYi91SlJYL1RPdUhObGcvQ29pdFFkWFk2Z3hRUjJRaGMrZ3JYT3gy?=
 =?utf-8?B?VXBhSUk1VUxCS0xWNEJ3NU10dnlMTkkvelgzUnEyeS9SbWtwcElsbURseCtJ?=
 =?utf-8?B?bUlpWFV0WFphVjhDeFhnMGs4RlVibWFHZnE1L3JrcUZXVXBHTXNqdXNOQXNE?=
 =?utf-8?B?Z3ZadTYrODZZWHdtelhpZTNkTlJCa2ZEL29xcHhHY05tYk5SM2dFRlluSVdk?=
 =?utf-8?B?ajZUdFlDbUtvK3plV01LZHpURWhMamptUitseXExK3hwTnhMNDdVRXY5R2ZH?=
 =?utf-8?B?Qm02M0VLOFUxbXY3Rk1JK25wcDEwcW9GOCtmenp5UlV5UktmT05xU0VPdHl5?=
 =?utf-8?B?dTNIM00vaUcxRXlaWjFhNUsySlRQRkl3ZWkxZEs2K1BXa1h1ek1tOEh0bXZs?=
 =?utf-8?B?Zys0eHVydWMwTmxNNlllQkhFQmN2UDFkU0xmZmxDaTZleEc1NXhHYXZRaVk3?=
 =?utf-8?B?a3RoMGRPR1lvbXU0cjUrMEl1VnFjWTVZL09lb2I5SDU2WTIxeXJZUmo1Q2Zz?=
 =?utf-8?B?UUlkNkxqWHFjeG9aaU50WW8rV2Z5NXA4Snk4UkFCV2hQQU9RVjZYREo3VFAz?=
 =?utf-8?B?cExML1JsbFJxaEVwOG5MVkhoVEljWW5pRW45dGQzQUliN09IZ05TK2owa05i?=
 =?utf-8?B?K2dPcXUwOEk2WWxDUHJSbndWbW1XNzhCb3B3VTVaVkJrVkd1LzYxdWJlMHNV?=
 =?utf-8?B?dW02T1N1Y09QV2hjOTVJd2RvZTNrbjlsSHZMdkR4Ny9WaUdHWkc0WCtKZjhm?=
 =?utf-8?B?MmY0OXN2RG9GSVlxRjJBcWZpeE4zMVMySWpXSXQ4K0VFTmJIdTlQVVM2cjFE?=
 =?utf-8?B?L0VtL05NdmVZSWVjK1BCUzBOamgrZ2tVa1d4ZUxWY01adndRQUZrTXJBRHdY?=
 =?utf-8?B?aStNSkVDL0ZqK3RIS2FlZlFTdm13QVZzaUFrTTJLQ1RSZktFZnczcEhjM1ls?=
 =?utf-8?B?alY5bGIxSGNJRGV0RTcwai9kZ25sa3U1M0RnWEhwTm1nbE9seFo3cHlOaW4x?=
 =?utf-8?B?RVVQbkFYdTlMaUt5QUpEcmhxRXQyTXh5UlV6MkVZYWxhOWNRWWdVdThhc3ZR?=
 =?utf-8?B?OEl5ZFEzbm1Jc3E5a2JiRnNQckRsNDFZL0pxS3NyZ0w1TlpsVXBHY1BoSWJx?=
 =?utf-8?B?dU9pSFdWUXFCZmVwaGFVQmpCaFJYZ0ZNR0IwQ3BZenFwRk5JdTBoMXg4Yk5Y?=
 =?utf-8?B?U1IwRkQvWU1FMnBZR2t3V044dVRmOU5MeFd4NjZ3VUJWbk5TN1VXRCtPNTd1?=
 =?utf-8?B?ZFBCbjVyT0NTNjIrNGJFRThqWW45endpbmtUZjF3ZVduT01YSUJGUnN4aUIz?=
 =?utf-8?B?YUxTcWFDVkRrdXJLNnVxbHJFSlZZd0E0MjhxQ21mUmJIWHNMeU05VFhiZDFa?=
 =?utf-8?B?V0x4QW5pUVhhVHdkSCtEYVloS3lPcmVEYnIyWjB3dy9GQ0RDbHkySENsTTFh?=
 =?utf-8?B?eDNMQjd5UUJ3TUl2RjdWL3JmeVVRaU9ocEJFc2JUN0dPcVJaeWphenlWSk5n?=
 =?utf-8?B?SWYrWUUzN21uVEx5dU16QjVkRlVFUnpyb0VpUE5qdWlBRXoxVzhyVzhxL1N4?=
 =?utf-8?B?azg5Y2kxVFViT3Q2OW01VVJPL2x2R2NtSTN2NkVvaEpKS1lQZ1RmVkhhVS9o?=
 =?utf-8?B?d2JzS0JRblM3UVo3VWFzNUt2ekQrSmlOcW9iNzNHRlJzdkhHNzN4SGtjaG9P?=
 =?utf-8?B?dUQrUWgrYlJobkJ4WUhMbCtvWDVzYkdYaktCK2JReHdlY3lFbmVKMG5xdGdJ?=
 =?utf-8?B?TEdmYmQzeFdNaGlzZC9QeWMrYVZWZDlzNmZ5bkJrcXFJaGJmb0JOSTF4ZXha?=
 =?utf-8?B?VDE5NkRpQWZ0eFJJaGZUNTF2TXk0aHZwVFViRXpnSWJ2L1FBcXBvWHVRaWlZ?=
 =?utf-8?B?QXBON2xOc2czKzNKQkdGakI0RWJMNTdyam41UDVjM0RUOVowNDZTOU1jbEFB?=
 =?utf-8?B?VnBmNjFmRU5CQ1VyTU9FdkwzVW9Xb1F0WjRtMDAxdXV1Y3lBSk1YMGFVSkhu?=
 =?utf-8?Q?8hgUinfoM9a4R7m34lwge4MlM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d52f0625-3429-4ba6-7773-08dabd745dc6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 08:21:11.4740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: men1+B0qJK4Y8s9eFVtD5O9V6wUb9tEGqAEKo3r4ZtYsjflKUtcXtSeL7GyoojHmayTD7WzggshZ4b7aMMGbAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6185
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

Hi Jithu,

On 10/21/2022 1:33 PM, Jithu Joseph wrote:

> This series makes the driver aware of multiple scan test image files,
> modifies IFS test image file headers to make it fully compatible
> with microcode headers and adds a few other bug fixes and changes.
> 

I am done with my review comments. In general, the patches look OK to me 
apart from the minor changes that we discussed.

(If some of my suggestions seem out of scope for this series then maybe 
you can follow-up with a separate patch later to avoid complicating this 
series.)

Thanks,
Sohil

