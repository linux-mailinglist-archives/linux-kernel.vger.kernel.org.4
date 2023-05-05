Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382806F87F0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjEERsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbjEERsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:48:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB65B18DE4;
        Fri,  5 May 2023 10:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683308870; x=1714844870;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nn+aQgtElX1IH++8fbPf+JLbnOJhApMLaoeVMy2SfEI=;
  b=GNh/Hwgg8zEQUby1abJaFXI1NezCwu4YVb2zJw2jXADsvnqnmE3W2A+t
   VHYy6bxR+KC5FdVSno/CJ6dycx6jDpU7Iv4TxsIJ3F+5PbOyTYiUUhoYU
   g5q2+VMXPELZk4RQ1HTo9P47Ahzck8infFmELwORXUd4XSEG8AVj1kb8f
   nnNeNmxA1LJHjFrItSsdi8vuzQRMuJOhpEkT8Cv2cqV3TLX0wEvgw05PZ
   1l3/HPn3UYz/XmoSFt4whv4q/44syKHruyMlz3wkbjc9hFZbRYd2A1Ohe
   q3ol5QoXmGNdSUbPyGrGZKHPNTu5ThI08PV5tGJ2Fl3hPNa5MNAME6pZ5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="352310654"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="352310654"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 10:47:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="767204322"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="767204322"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 05 May 2023 10:47:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 10:47:26 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 10:47:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 5 May 2023 10:47:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 5 May 2023 10:47:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyKvBZqeXaPPWp39XcpBgZU41m2pdU4wQQ0rOBbn1Km7v8Nd6+UFClxCW/gEFxD54xqBDIijpTzKNIJNipltp+vCjvNv9gf/JWQuU8kevNjYfkg4QEBpk2P8A7lJRzsztMhvRexxPWtARzq16diBBKC9ETn+iJZQH9/If8msWiVsXPeK7bOei6bFiBaICPb1EF84tfRxG5Up9/3E4Qg6s1PIX84z3ibgNHbE9ypdkgjcacbi/omm+5BGq0+w2nZeMUv7nX5n4UiRT+IE42aJopB+OJxzBCZs/tRJlKayXmbiSjW71cLW3E8vbOAuaWrCQ93QaRBVObfYQ9tZ0qUdAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBf7Yik2GfKHWs9uQHqo/GCfpDi11mR2wRcmG0xw4co=;
 b=KYUsIoWU4zBvzwK0XafP5ItYKLKF7rVdSbFG6OJpkh0f+GtyFV2GRS08pTw5rWU6zOdi5l7cdFH8uNSBQdEJaUFIiaF1wTVSWLKgzWv8GajKtXAqvPNNRA0v8qeECG5x0f7C5bO5bp7LNUsH/WccGwmc6CsKVjNTVLb2sJ758PhYh1a/HZgB80UkIq3asL8X88dsh16r3JaXqTcLh1QHLT/WBCy+O6tFj0K2R76z/DtEvBpTLOYl1PBSuRFjdjdcwxNgwC7eeNdj3Kvf4RFHe5gqDDVfoTur6GumS3HgqdESWJF4Pubu8MmAhhCBaVFTtPYIPhWqzyH+gJLBvpzyxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB8547.namprd11.prod.outlook.com (2603:10b6:610:1bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:47:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:47:20 +0000
Message-ID: <5d02d54b-60a0-fc43-7340-238b910e22b4@intel.com>
Date:   Fri, 5 May 2023 10:47:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH v4 0/7] x86/resctrl: Miscellaneous resctrl features
Content-Language: en-US
To:     "Moger, Babu" <Babu.Moger@amd.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "eranian@google.com" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <d0e72b31-1865-9e23-51c9-5c43cd71084e@intel.com>
 <MW3PR12MB455312E6A33BA29FD355745595729@MW3PR12MB4553.namprd12.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <MW3PR12MB455312E6A33BA29FD355745595729@MW3PR12MB4553.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:a03:505::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB8547:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d6b0578-5f5d-4730-d5d6-08db4d90c6ac
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8SN9OZJxMy0/JahSHuCwlDrtmP/9wM73fkeYFRbUEy5cS8lsJOej6PFyoz6x5NNBuwZKS3JqyNoA2PfaO9hA56EtUNvMSeSMrTtOfd+ua51APCHavSC1cD3QXcVch4TRb+e+Xk3Qm1MbbxEF9+jaUd1a3xLRmydrIJWOnn9CX397A7puFzUNd3Dmp3nUhVmfdzvA5W8sDNMI3HlfJOGkd335XhBH+j0+zH75bXl7af4YFi7VdrDpNfloJiXT1fsVZCQVZs5Uz9cDs8HSuvg9ymRpCJErDhc6vhtNzJNti4dStAvRYhdcuZk9P2IoBKD8QmoCv8MhhauhDizw1wW91Qad0+WwXP27mG+zeAJers13x/R9prVJyvBOeWem06TcSS7b7YmMT8dsYCcq0Ct0zTmxeSbIa8I0xqgwWzIvSpIJr5XnhkgXeTILPIxWTW40fdweLDYMxVgsM8jPrYiUR8n48nu4BVAe1tN3io6KG9ETmltfrn95ezI0iq7gAJamMEnh+wKYUalU7fdN+sYNcBfB8YYKX0T5SAtyDRXDQ6bL7VzVh4LT0Z0pyBvUnX3QUfLLNMvUDwQuyKwbI7RyF+Fw9nVYA1EHHt4l+Vxt4650Cuw7d/bKy2Ib5SkxSb4SvAuchV6PYkY13DqXqCw6DuaZs39HlymYdF9V+r95GCo4ehsXMCWSMhv/im8M8QVF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(31686004)(966005)(478600001)(66476007)(4326008)(66946007)(66556008)(316002)(54906003)(110136005)(86362001)(6486002)(36756003)(31696002)(83380400001)(6512007)(2616005)(6506007)(53546011)(26005)(8936002)(8676002)(5660300002)(7406005)(2906002)(44832011)(7416002)(41300700001)(186003)(82960400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Kzh0Wi9rd3MxekFzczVBODdjYWxpNGE2MmlySU5vSlpWNGVGNE56NXBHTG9K?=
 =?utf-8?B?MlF1YXFKVUhwaGR4SXdQL2p0RE1oRGlEQ3BLaGdlbThEaHB6M2liSFUwVkx2?=
 =?utf-8?B?TU1aY25EWStJZmJLa3M1ZmNkVFVUVFNHUUxxZEErcXdDMTRJTTJwMVJMRDRQ?=
 =?utf-8?B?K1VtSnptdE5QNDU4eExlVnMrRFBub3ZPUVVMQTh6ZUNvN2pEU2p6V00xQkZj?=
 =?utf-8?B?UjVoN09ZOExzVGdxaUNMUm5KMXdOQjJ1UUYzcTNnOUlmdTlUOWx0cXVQcVhC?=
 =?utf-8?B?bUNZUHQyN2NSNVdqQkZOZ2N2N1QxMUFBaStVYnhteFBtMk1NV0Ryc2FwQWpB?=
 =?utf-8?B?VUFhbXpsUmNaTGg4eVRDYVlUbzQ1WFBhN0dlZGZSMW53SXExaXJIUzkweEh5?=
 =?utf-8?B?OTB6WVBNK2FDN2FSWGI1VUxkdlZvRXlxcXJtUkFBNEV4RGxQZnRyNGNnLzJo?=
 =?utf-8?B?V3pHYjl4WVNGaFpkVUhVUHN4VjhCNVArRXJpQ0tPUms0dnFLUS8vMldZbHBI?=
 =?utf-8?B?SnN5UERRV25HbGtvY0wrRHdoMUlpbFFuYnptdXRQcUxIbVpNRVhjVFJIZ0U5?=
 =?utf-8?B?VURCTXltTEdGalowUkRtK0c2d003bHRKaitPOVprS2FUSmFIQkd0OXlmWDQ2?=
 =?utf-8?B?bCt3OE9xNXRLejc2eDJRaUk2cC94cTlYOEwrMzZVZnlZN1dGWXQvZ0t0OW1G?=
 =?utf-8?B?N0JWV25YVmsvdko4Z3ZTQzgzaWltTDVFWE92K01rb002eTBRQ0FXY0dUTjQ5?=
 =?utf-8?B?WTdlWUhwRy9USlRSL2hxeWpoUi9QSUNtZEM1Y2dsL080OHY2Y3VKLzd2SlBo?=
 =?utf-8?B?VkI4elRCSWJtdGF6emVuRGdXdUZVKzhzY3BvZ0NxT3IyQmNsWE5CRitHMitX?=
 =?utf-8?B?Zis5ei83R3dpUGVtMHhITmFLVFRINEphRHZGZ28zNFIxM1dHdzJsazZ0TmR1?=
 =?utf-8?B?QnZybFRob1psZHpsOFNuQ1JDK0ZsYnNYRUVwUlhmVjFJcURBVFdZTkMzL1Vu?=
 =?utf-8?B?SzZOUXBaam4vdUNVelBVbVdjd1A5WFJCMHhxTy9xd3RoRHZIM1hlSlpnUmJ6?=
 =?utf-8?B?WWJQa3VQdUVtM1NHdmhTSmxnRFZQeU5mSUhXTWpsa0p1emhKWmsxU3gxV0ZQ?=
 =?utf-8?B?aHhZcmhJVzdoMlhUemE0ZE40OGIzSkZ2dzVDbU1jRitPeFBsTDVweWUvaDFX?=
 =?utf-8?B?UEptcEt5bjhLWGx4SHQ3YU9Fd3BlWTYvaWJIOUNYeVVIR0crcUdxMHV4Q250?=
 =?utf-8?B?WlRsZlg5L1QwNVc0NVdXWllIQjlKQmJXbDNJVjV5cWo4T1d4dzBKSFZwUFpj?=
 =?utf-8?B?MHpSMS9UaWJMM2UyUnVkaDg4UDl1cVBmdHZCQXVwM3V1QnI1NC9DUjdEWU1C?=
 =?utf-8?B?ZHNZWWxuQWNoVXVvajNXY2ZmNkZrOXpJTjAyMjVYUEJTaDZncUZ3VTJFUzNr?=
 =?utf-8?B?V2xaT1EvaFR1MjNnWGo4WlNKTkRBRCtyWWRoa3p4RVMweWdPcTFTWEF5eWY1?=
 =?utf-8?B?WCtadjdjRGZzS0hlTno2U0hiYU50YW9jSy9zNllDL0NjTGVzSTJwTlR3VVMy?=
 =?utf-8?B?YWl3K3JWaDc3R1FCdEkzd2FlZi9wd1J1d0xGL3ViSXVZdi9ka29hd3lPcTVr?=
 =?utf-8?B?ejd0QndDU090ZXo1SGVkN1paay9oeGlEK20xKzBoTWJ0WFVsOHh6TWhDN1RQ?=
 =?utf-8?B?M3FGY1ZIQWFQR1JLQjVrT21yVUFRRGpRY2ZYdWY3bThCNHNnRHFZTVBQTnE1?=
 =?utf-8?B?ZXVIVGt4cHBQOXJET1VoZGZnVlc1MVZSM3ZCODVZSUVadkdGSmhDUFpqalNW?=
 =?utf-8?B?NHBONmR5bDF3WlJRMjBROS96NVpQOUV6MDJZSCsrV0o5bnhNeHFvZkQ1b2l6?=
 =?utf-8?B?WjNQaUtpbENxR2RDcG9lUGRnNTNKNG0vcDVnZVdUdElaK2RNeG1NVU4xcFc2?=
 =?utf-8?B?VWREQnBVeUdUQU8ybXorakh1MHY3ZktJSi9iOEZPL01lcjFXMnpGTXViVmdR?=
 =?utf-8?B?K3RzdkxabUhmdUt5dTJKMnhvRDdPMWJNeHdvWkd6cG96UkgyeFBQNnBIYkpC?=
 =?utf-8?B?YlNEQ2s3ODF2TGJSQU5TYitoMjRmTWE2WjIwWStURGdHWEpxWnBSRGdQdTNS?=
 =?utf-8?B?YWpYRGRIaUxvN2lKcVNHVzJXQnF2QzA3SGJkVHNCbGxYODZNQ0RzWkZ0TEVz?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6b0578-5f5d-4730-d5d6-08db4d90c6ac
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:47:20.8371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PP89wW7pDr7p7o04uYJY4UoEknc2AdWKhdu41+jC9BB6v18MruZkz94fxFTeqgXE4EHzyQvpq/KGBitmHEna9iXnNzTt5r/26LE/ndpf++U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8547
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 5/5/2023 8:43 AM, Moger, Babu wrote:
> [AMD Official Use Only - General]
> 
> Hi Reinette,
> 
>> -----Original Message-----
>> From: Reinette Chatre <reinette.chatre@intel.com>
>> Sent: Thursday, May 4, 2023 1:54 PM
>> To: Moger, Babu <Babu.Moger@amd.com>; corbet@lwn.net;
>> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de
>> Cc: fenghua.yu@intel.com; dave.hansen@linux.intel.com; x86@kernel.org;
>> hpa@zytor.com; paulmck@kernel.org; akpm@linux-foundation.org;
>> quic_neeraju@quicinc.com; rdunlap@infradead.org;
>> damien.lemoal@opensource.wdc.com; songmuchun@bytedance.com;
>> peterz@infradead.org; jpoimboe@kernel.org; pbonzini@redhat.com;
>> chang.seok.bae@intel.com; pawan.kumar.gupta@linux.intel.com;
>> jmattson@google.com; daniel.sneddon@linux.intel.com; Das1, Sandipan
>> <Sandipan.Das@amd.com>; tony.luck@intel.com; james.morse@arm.com;
>> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
>> bagasdotme@gmail.com; eranian@google.com; christophe.leroy@csgroup.eu;
>> jarkko@kernel.org; adrian.hunter@intel.com; quic_jiles@quicinc.com;
>> peternewman@google.com
>> Subject: Re: [PATCH v4 0/7] x86/resctrl: Miscellaneous resctrl features
>>

...

>>>     Tried to address Reinette's comment on patch 7. But due to current code
>> design
>>>     I could not do it exact way. But changed it little bit to make it easy debug
>>>     file additions in the future.
>>
>> Could you please elaborate? It actually looks like you may be headed there next
>> according to:
>> https://lore.kernel.org/lkml/933d8ae2-d8b7-7436-5918-
>> f639405c9ecb@amd.com/
> 
> Sorry, I was talking about this comment.
> https://lore.kernel.org/lkml/fef12c9e-7d6f-bcd4-f92e-e776eb9e673b@intel.com/
> 
> I tried to address it here. 
> https://lore.kernel.org/lkml/168177451010.1758847.568218491528297451.stgit@bmoger-ubuntu/
> 
> This may not be the exact way you mentioned.  Reason is, adding the
> flags before rdtgroup_add_files cannot be done. It does not update
> the resctrl root filesystem. These files have to added by calling
> rdtgroup_add_file and kernfs_activate in rdt_enable_ctx.
I think what you are referring to is files not appearing in the default
resource group? From what I can tell the files should appear when new resource
groups are created. Could the default resource group's files not also
be added on resctrl mount (moved from rdtgroup_setup_root() to rdt_get_tree())?
I do not see why the files belonging to the default group are required to be
added before resctrl mount and with the move the resctrl_debug flag can
continue to be set in rdt_enable_ctx() and available to rdtgroup_add_files()
when adding the default resource group's files.

To me this sounds simpler since there is no duplicate file add/remove code,
and the debug files are just another file type.

Reinette

