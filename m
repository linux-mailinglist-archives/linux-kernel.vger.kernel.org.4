Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBB8636D06
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 23:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiKWWXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 17:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiKWWXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 17:23:05 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E57F30F70;
        Wed, 23 Nov 2022 14:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669242181; x=1700778181;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cbiyBCx+jIxHVMLWtuD9EpT0/zvu4JRIw4qu7VvdMxg=;
  b=b/raA/KM8VJ06XR4jp5LbmsfJxunrMWVuL9tXua48NrFbvYTC9a8dtRn
   0/2dwg2yfHh0JJEskxc4857q7lUbFf7XNQCcAbSYgotUx15KlMXO5ZTk9
   h01Xo7uI+ZKWwmlIcg7cb+oxO9E30NkzJRz/vNGTBOzPbtALpfpZ42aeU
   9cprl2zMA2a7wXxiPe87U+2pwPYUfbuUdpw6mGDKKMKvhsArAh6lMXHXi
   YESqve4Snx026IXNtLRQNUbThx+N6VskrSC5Kubx7/kCwgPmAGxMif13/
   9uj0Smpt8qa6Lu0OtUAwcaB/6mfxcNmw9asYeyq90OA3UG90C4OQb/gwD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="341056588"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="341056588"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 14:22:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="730929113"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="730929113"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Nov 2022 14:22:54 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 23 Nov 2022 14:22:54 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 14:22:52 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 14:22:52 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 14:22:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjJz8wCyt3nHklhw8IUNfgGTnV6ryoj+YeaihkE+0uW/L1mEVRYFfOTrZGSBJrUa93iVTMhdJTk7i0g4Hktre1AIQr4TsKQhpcW+fHXGe+L3mkRrMOIKMCXm3SGN2UHhL2koDVHZshYFldkSzpy9sMwGW8TEC6IyTPX6F9mUh3tHdIS79xN4dCC9YxL2QmgyuXEeEX0+s9bwIbMMsDlcwXoV//2xi/arbmkxqf6/uMLjoylx8ebmLOsAMTxNKGEL6yWas6QTBtzu0vJErTR8c0DJqEydr6dXZLL2oMW1MjXfYSEIHxJkO/pRFb/g9H3Spd8oOp1t+meAy2MaunAVEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3o0CPX9u1G5Xx6LMuzGSesP3gdTMBfdu00wXdVDYUI=;
 b=FBVH7+N00YddQrqnPwerxric2DDicX/DBKjzwgxdL/okerf8+dK4Q20cGQ2pnS3L2+CDhdyvqKr2EXPyXyfko5fm6KTP/lyh/UYrG74vIrx5hr4QjK+o806LWdX/hps2a/yppxptU3wNZ0zzp36uzWo+jPzf6s2be6NuTTgjIGiJVaLUc88hU7MxZhNyh+wUF/yRmwfYfVytQscnsSq1wGFAYnJpV6DpakWkQzL+xeCXoV2mGS3i+DbZk08L76Z9/p2C7YL6rK87o0bYIirhcdKGroKU8SQPEY550Th7wex7cBRolFoJnTK3gdQGE4kgQd7wh0tEN2o2/97zTIC1zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CY8PR11MB6939.namprd11.prod.outlook.com (2603:10b6:930:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Wed, 23 Nov
 2022 22:22:47 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a%12]) with mapi id 15.20.5834.015; Wed, 23 Nov
 2022 22:22:47 +0000
Message-ID: <f461c201-8ef2-d7c1-0fa0-35b10a89039a@intel.com>
Date:   Wed, 23 Nov 2022 14:22:43 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v8 10/13] x86/resctrl: Add sysfs interface to write
 mbm_total_bytes_config
Content-Language: en-US
To:     "Moger, Babu" <Babu.Moger@amd.com>,
        Peter Newman <peternewman@google.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
References: <166759206900.3281208.11975514088019160962.stgit@bmoger-ubuntu>
 <20221107102134.255757-1-peternewman@google.com>
 <cccacde9-7d0b-f0c8-2e3d-2b09c910b8c5@amd.com>
 <5ce5bdd7-c2ee-fa7c-a01c-174ee3ee24d8@intel.com>
 <MW3PR12MB45531279C61A2A75C8CC47C2950C9@MW3PR12MB4553.namprd12.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <MW3PR12MB45531279C61A2A75C8CC47C2950C9@MW3PR12MB4553.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0060.namprd08.prod.outlook.com
 (2603:10b6:a03:117::37) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CY8PR11MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: 117c0d92-d0f9-41e7-bc7e-08dacda13fbd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xSR+SLs+sLM/L5DPIJYB7NdywG+qpqthaCXUTUOV2WvKTClvW1QZawQjEJBwdG4p0T5BWdPMqlZEfOWndJnAmhDFJ6QU68kFOC7UiHRVt2wq5kRnlYd2a46N+xi1ud5XxeYnb62YsavOupH35luzNNP62+T5NL09iJJtnJ2w84Bnx/ylNp3xu6BmkMTa2wSaMWBR4CACmcBn2aVQ4VrC737WSSKEIxyC0RwcxBAhUptb6i/4aa/8hn7Mi7BUb27CpF3zowEEDVGHeHkhXm6onsJ4e3fyA1JcErOve8F2y2bBkoCCCpZ7HdWBwM6t4i8h+dlsC/wkNnV5dQcfipBkKQz6sDkDDxBvbMJaZ45Vf5kVLuqllbbsQVAEEg3Hw+v5+8Ic1CBiWm4wO6hWoaWLnxtuTo/amZ66fExO2I6OdvbG/unSkNuw1gKdPUy7VAI/jnjQ0WRRg9PM1nZL/IBN3pIL4bwcP/wDfsOVjZugCIyzLsnZR+43q95Wc5+cDqrA22n1VSl8yeVq76GSYX+jau0U7rpUYrwmisA6ryjCVDHihoRUx1d7tu+AfOx3ddsySd9zwxLNWHLjrREA+6ZFENk7Gu+UhbaVNaVtLlY6KPlYeE2F0+L0q9zrfgJ8e+lY5i34k7+GAN4f0LhFpYyEyh1BgsS/05+USpV0vKULKYxj6TOYuzceA/zPdOcynHAAsN5+IufGuc0TG7vUVUke1kvr9QQxM95fbS2ybHb1D0h/ewNFVDP/4MbxXpkTG+L6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199015)(26005)(41300700001)(44832011)(8936002)(2906002)(2616005)(45080400002)(6506007)(54906003)(6512007)(316002)(6666004)(110136005)(186003)(36756003)(53546011)(83380400001)(66476007)(66946007)(66556008)(7416002)(4326008)(5660300002)(8676002)(31696002)(31686004)(966005)(82960400001)(478600001)(38100700002)(6486002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z291MUtBdmhOMnZJbmdkSlBLbFBKcHRFL3Qwbm9XcGthYk82ZmtKTWl0QlNs?=
 =?utf-8?B?empEUm1GaWZVS2JEckdMSzVEYmh2VTBkR1o1M1RhRmlWV0pCUUlTMCtPTDBI?=
 =?utf-8?B?RzQrUHlQWDhhRTZENkI4ai9hZEIwSDFNN3R1SVBjbHNxb3NpMzE1SmdTdUY5?=
 =?utf-8?B?blhxL3VKRm5nVTFDNDM1YVpONjFNakxqdGhHamZTRWhpbWxDZDVmTVdoK2ZG?=
 =?utf-8?B?SVpkTFFXTWFjR1RJMDBGNEZ5RitjODR5OTdvVmpuUlFSRTVUSUZzSTU1QXBV?=
 =?utf-8?B?VEc1M0ZXZHVYdWc0VjVTQTkwUkkyNVpRbElsMCtrUjY5dU1sZXYvVmJhdUpk?=
 =?utf-8?B?ZzdIYUNOS1VrL0ZMekpPMFZrbFM5eWFWTFRwVjFZR1hWRFZFc0lTeFkwU1Zz?=
 =?utf-8?B?dE5QOTVuWThmSjJOVjREbHpFKzh2VjBxOEltZzlLdGpWdTJ4L01nbmZqQjhy?=
 =?utf-8?B?NFFtQlVwcWhCdFFHV3NMaVp3SjNzUUVBWUdMSnhSeEIxZmQrWGtmM1hnNUVF?=
 =?utf-8?B?WmFyeXZ0SEt1VDVLRFVtVjNmQWhIYlhKQnFjYjNPblVhYlUvTEl4S3NMbXJ6?=
 =?utf-8?B?SjZMeFR2ZnZDeXF2ZEpvVEZNa2NvcG9qSlhibk81Nk45ZDNsZERDUzBMcWNQ?=
 =?utf-8?B?ejIxSW9TYWQ2SHhYYTM2MlZxbElNZks2ZDVLQWFSMkFlNXhvMUExRUxnUERk?=
 =?utf-8?B?WDVYMkFhYTJnaWxKM3MrVDBNREJNQlF4NDc0QnpEUU94T1BCU1R3ak13VzNk?=
 =?utf-8?B?T01za3VqcHlOeHN1aW0yaXRvOWg0aGJSbDZMWU1uMm9HZGFWcm1nRmNYQ0tO?=
 =?utf-8?B?Z3FLUEk4WjVyU3dxcm5vSnNIaGxGWWV1MXFCVGFQS2x4dlNncW9SWURST1Ry?=
 =?utf-8?B?K3JTSi9xZmJhamFWam9zQlZsbk42Ti9CNDBBR1BqaHY2MlN2VGpQY1R6eXRS?=
 =?utf-8?B?Qi8vNzJweGlWb09ycVhKenZMOThuTG9ld0xuTG42UlAzNU5rODQwN0FQRVNw?=
 =?utf-8?B?Z0krQlp5NkZ6S0FNeUlUMU9ubHFTdXk3WFBSdTRsTUk2eHI3a3BXckZjY3gr?=
 =?utf-8?B?bFZGMXBsMjBXTHlEdU1XSnduZFlHZ2loeDlFS01QaXVBaXRCNVBXSEV5Sm5M?=
 =?utf-8?B?TVpYK1JCV0NRcEk3bkFYZ2N6ZUpvYldZMGpVUFg3bHNtQSs0WGVuaGZQTVM0?=
 =?utf-8?B?MWFpNmVoQkI5TGxndTlJMStPQytWVEpwL0Z6b0o5alAxRCtTN0h1bUNQSEZk?=
 =?utf-8?B?S0Zrc1RuOHY2ZDF4RW85WXZleU56ZFJPWFlTb0NFRmV2YlIwbnhkZk1rYmta?=
 =?utf-8?B?VS9mZW1hU3hDc0dyUW9iaWlPVXlYdjAxSGJOWkVmcTE5am9IR0NMNWN6QkNw?=
 =?utf-8?B?ZWsveXZLaHBwU0VBbmhiS1c2R3NUaW9RZ1dTMnRxSDRLdW9ZQ0p3bVVqM0Zl?=
 =?utf-8?B?eGtWSG1aQXhkeVB3dHQ0U21nemJVZ3BqdFozWkJveWpWVTMrSlA2N2ZSQmFh?=
 =?utf-8?B?LzhhWTNRb0poUG1YZTRmcFF3ZzRkd3kwRmU1emU5ZUlzM0Vzc3RCdUlpNC9p?=
 =?utf-8?B?U0cvdlNXNmVtMkZSRE9UbnF2MlZ5a3UwSlpZTGdJK1N2aXM3ekJDUGZGdjBo?=
 =?utf-8?B?dkpZMVNYbncweG1GVDVKR1hNNHh4T0ZHa2Z2dGZMSXF3V0djemF6dHl2SzBE?=
 =?utf-8?B?MGpLWVRpdXR0RUpXR05jcVB6dDJyTFVhNU9JZ1BYbU9ITFY1aEcvME5LQzN5?=
 =?utf-8?B?d2wwMmlsanFaaEtEMUtFRC9oUVB1WWNGWVJIRU1LQjNRMTR3MWNHeVhGWjBt?=
 =?utf-8?B?Z0R6aStKQ1FlRDRHT3ozRzlrTVh4dCtwM0ZPNC9oQVNpa3Q1WkZ0YjFxdnhj?=
 =?utf-8?B?VzhZTC90bDBKOURDOGtiN3pXak1iQmVwVlRaOENhNEk2VktRYjhTcm5sUXdX?=
 =?utf-8?B?QnlqMGZhZE8wdFVxb243RFlBaWphbHVybk5TbmdURGNVZ2NlejkyRUNhTjNY?=
 =?utf-8?B?TkljdWRhWHU1eXVOdUphUjVFOTcya1NVazFObzc1emJraHNkeHBXWmhiMHVV?=
 =?utf-8?B?d1BqeXVoNkkzdW5YNHU4RzZWdzhNMTk0Z0Y2alh2Tnc0S0VEemJ1Q2NadXNT?=
 =?utf-8?B?TDl5WDc2QlF4Vm5ZQklTRk9iYmRPdnVWVDJYb0daZWMvZ1JQSGU3aytuMWI2?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 117c0d92-d0f9-41e7-bc7e-08dacda13fbd
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 22:22:47.1205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gdb+4mBjE2cz/vAOqzMLkNmCWSAKrvB73Sf7VEaTRqxLPQIZ6mx0Jmp1f8fSy9RovESrBAnrGdeToU0y2MljvRotTJ1ntrDq5JjSkLxe35U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6939
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 11/23/2022 1:44 PM, Moger, Babu wrote:
> [AMD Official Use Only - General]
> 
> Hi Reinette,
> 
>> -----Original Message-----
>> From: Reinette Chatre <reinette.chatre@intel.com>
>> Sent: Tuesday, November 22, 2022 5:43 PM
>> To: Moger, Babu <Babu.Moger@amd.com>; Peter Newman
>> <peternewman@google.com>
>> Cc: akpm@linux-foundation.org; bagasdotme@gmail.com; bp@alien8.de;
>> chang.seok.bae@intel.com; corbet@lwn.net;
>> damien.lemoal@opensource.wdc.com; daniel.sneddon@linux.intel.com;
>> dave.hansen@linux.intel.com; eranian@google.com; fenghua.yu@intel.com;
>> hpa@zytor.com; james.morse@arm.com; jmattson@google.com;
>> jpoimboe@kernel.org; linux-doc@vger.kernel.org; linux-
>> kernel@vger.kernel.org; mingo@redhat.com; paulmck@kernel.org;
>> pawan.kumar.gupta@linux.intel.com; pbonzini@redhat.com;
>> peterz@infradead.org; quic_neeraju@quicinc.com; rdunlap@infradead.org;
>> Das1, Sandipan <Sandipan.Das@amd.com>; songmuchun@bytedance.com;
>> tglx@linutronix.de; tony.luck@intel.com; x86@kernel.org
>> Subject: Re: [PATCH v8 10/13] x86/resctrl: Add sysfs interface to write
>> mbm_total_bytes_config
>>
>> Hi Babu,
>>
>> On 11/7/2022 11:00 AM, Moger, Babu wrote:
>>>
>>> On 11/7/22 04:21, Peter Newman wrote:
>>>> Hi Babu,
>>>>
>>>> On Fri, Nov 04, 2022 at 03:01:09PM -0500, Babu Moger wrote:
>>>>> + /*
>>>>> +  * When an Event Configuration is changed, the bandwidth counters
>>>>> +  * for all RMIDs and Events will be cleared by the hardware. The
>>>>> +  * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for
>>>>> +  * every RMID on the next read to any event for every RMID.
>>>>> +  * Subsequent reads will have MSR_IA32_QM_CTR.Unavailable (bit 62)
>>>>> +  * cleared while it is tracked by the hardware. Clear the
>>>>> +  * mbm_local and mbm_total counts for all the RMIDs.
>>>>> +  */
>>>>> + memset(d->mbm_local, 0, sizeof(struct mbm_state) * r->num_rmid);
>>>>> + memset(d->mbm_total, 0, sizeof(struct mbm_state) * r->num_rmid);
>>>> Looking around, I can't find a reader for mbm_total anymore. It looks
>>>> like the last place it was used went away in James's recent change:
>>>>
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flor
>>>> e.kernel.org%2Fall%2F20220902154829.30399-19-
>> james.morse%40arm.com&am
>>>>
>> p;data=05%7C01%7Cbabu.moger%40amd.com%7Ccb4a2daf65b84b45aeac08da
>> cce35
>>>>
>> 66d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63804757402544
>> 6241%7
>>>>
>> CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
>> 6Ik
>>>>
>> 1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=QZUVrpdr0YQFSJ
>> BbS0BHSu
>>>> q%2BhMwZHAA06MUqx98hD0U%3D&amp;reserved=0
>>>>
>>>> Are we supposed to be clearing arch_mbm_total now?
>>>>
>>> Patch got garbled in previous response.
>>>
>>> Here is it now.
>>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index 6b222f8e58ae..28d9d99a639e 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -1517,7 +1517,7 @@ static int mbm_config_write(struct rdt_resource
>>> *r, struct rdt_domain *d,
>>>                             u32 evtid, u32 val)
>>>  {
>>>         struct mon_config_info mon_info = {0};
>>> -       int ret = 0;
>>> +       int ret = 0, i;
>>>
>>>         rdt_last_cmd_clear();
>>>
>>> @@ -1557,8 +1557,10 @@ static int mbm_config_write(struct rdt_resource
>>> *r, struct rdt_domain *d,
>>>          * cleared while it is tracked by the hardware. Clear the
>>>          * mbm_local and mbm_total counts for all the RMIDs.
>>>          */
>>> -       memset(d->mbm_local, 0, sizeof(struct mbm_state) *
>>> r->num_rmid);
>>> -       memset(d->mbm_total, 0, sizeof(struct mbm_state) *
>>> r->num_rmid);
>>> +       for (i = 0; i < r->num_rmid; i++) {
>>> +               resctrl_arch_reset_rmid(r, d, i,
>>> +QOS_L3_MBM_TOTAL_EVENT_ID);
>>> +               resctrl_arch_reset_rmid(r, d, i,
>>> +QOS_L3_MBM_LOCAL_EVENT_ID);
>>> +       }
>>>
>>>  write_exit:
>>>         return ret;
>>
>> Resetting each member of an array individually seems unnecessary when the
>> array could just be reset as a unit. How about instead a new
>> resctrl_arch_reset_rmid_all() that can do so?
> 
> Yes. We can do something like this below.
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index a188dacab6c8..2e67de911222 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -176,6 +176,14 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
>                 memset(am, 0, sizeof(*am));
>  }
> 
> +void resctrl_arch_reset_rmid_all(struct rdt_domain *d)
> +{
> +       struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> +
> +       memset(hw_dom->arch_mbm_total, 0, sizeof(*hw_dom->arch_mbm_total));
> +       memset(hw_dom->arch_mbm_local, 0, sizeof(*hw_dom->arch_mbm_local));
> +}
> +
>  static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
>  {
>         u64 shift = 64 - width, chunks;

It looks like the above would only reset the first entry of the array.
I expect that the resource should also be provided as parameter so that
the num_rmid can be obtained to be able to clear the entire array.
Also, what is the likelihood of this being called when the array does not
exist? It may be safer to wrap each memset() with an is_mbm_total_enabled()
or is_mbm_local_enabled().

Reinette
