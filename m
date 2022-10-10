Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2325FA6FF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 23:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiJJVa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 17:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJJVax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 17:30:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E567CB64;
        Mon, 10 Oct 2022 14:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665437452; x=1696973452;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GR38PiIw3KOMRQuNXjyAUaIGO0S0NMLbvivgIqRbpoA=;
  b=PMMpf2ULHRJMhnYYMaMAyEbyuG+PZEBBN2j4Q1bj6gN/g5u4pqh8RLby
   /vFQM/Ey1pqniv9b9OGRGDG/fQrylyNiQ3p0rp8oMpOH3Jc5QwYvvHBYe
   Bbrriv3lmttK3sOCQ/H8fVVGdf153llaXr902pKPn3lLHK3H3KTLM3uqF
   R9CRjgdedEXNv6aDPNSvb37ldPtCBndIsM4Aw/e9C/pQPXRJQ89JHGZsF
   9PwkRCFG9s8Eh/mXHER428rj4Cftafsv2uJ39k5nw84aEwesIATW4MT7y
   Ob+0XcTVvfjkf2P2B94oribg7F9v1+zhkR2IKAypcCGmxLN42ERxyCHUw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="284068626"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="284068626"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 14:30:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="577201051"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="577201051"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 10 Oct 2022 14:30:51 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 14:30:51 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 14:30:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 10 Oct 2022 14:30:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 10 Oct 2022 14:30:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kz4xRc3LWiwHfFRy1Z76CSJabZenFz1S0Nl/rLyvwA5vRa8tR6YUNZKrSLIV7XHmxrgEgY9ddFlFrFUdtCsGuFvMKy6xJ/oDRHtt2G0tumhODDXM5g/VWnKR37lYDmCOpPJBV8PGn3XlpT1COGVRKZzgumCcIEmmK9aRWMwR7qUPHo7DrpaQN2xurTcbdLMeAxZnR7Csx+rficPqssppZiBczlyqcfI3Vx9q8QuvRDb7YKv5WOxEjujUNhkpGgSQPxdqCynlV5+LZzB8fBFFikppcGVeqxHFxJ86nypqDRzaTQkn1ahNMGTUgwk+mX91//gTviVKfdQOMZGp8+H8qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2Bpr+DLOxK1gJxQgh6vSlDvPSE/cPUNPH0tqu7tMjY=;
 b=RyLPKgznOmsaMlJPRI6Exx7vhKatiOdMNCN0TtqcsTrRKzM130YUDA80ME9kZmBUqO5ZmBttZKN0le2ouuMhB80edV5kIbBLpPNQDVli+SipnBxO/tJskQjmONBcka71nlgMhOF/lzP6fQ3UBsMLN0nTBvwblCtN5jvfVMaRXRQee7vdGH17DT9aR4pRYH7KMVYKWpWTa4l3+ZIIOMqv5Mf+w4NabfJ/TEjUZ39/WGqsVImcw0F7Qw8UodBm2LJDyx7n1vdhNQzxAgO34Y9ZLkI+fjAI/NvZL+Ii4jrg59HaS0G61XaFn2vIJXD6UgUgU8/pu9XGc2Rq3oPRKQ3aZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA2PR11MB4858.namprd11.prod.outlook.com (2603:10b6:806:f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 21:30:45 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5676.039; Mon, 10 Oct
 2022 21:30:45 +0000
Message-ID: <915c3983-e65a-da98-120a-1aa70b9fea3a@intel.com>
Date:   Mon, 10 Oct 2022 14:30:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.1
Subject: Re: [PATCH v6 12/12] Documentation/x86: Update resctrl_ui.rst for new
 features
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
References: <166543345606.23830.3120625408601531368.stgit@bmoger-ubuntu>
 <166543384024.23830.1715326237069935949.stgit@bmoger-ubuntu>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166543384024.23830.1715326237069935949.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::35) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SA2PR11MB4858:EE_
X-MS-Office365-Filtering-Correlation-Id: d45d42d2-ddfc-4c36-7f93-08daab06b0c4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xe0IqH5K7coDgOBS2C5NtfgZTOl/Cprg8Zql9CCeVnNKWXVrAHpLlKPny5O1h7rZN+gHPmUp6GmTxIYYka1I5v4f3YbJtvee56q9jvYOZElNcXbFL3atR/YyKkZbzDXs7A7EyqsjVh+7KBoo5UWRq/ZFna8QwqJ3LnkEE17Z3pS7FeKuor3KXxPqBTjw6SkJnZei8gekOEqdEHWCcmQfvqKjbu6JNk2JrYvN1raMPUA/tRi7wN1L2CNPgZwlevKROznRQOALHAvX/DSsEoYFc5lnsS2GXsXip3Nq1/eFyvj1y9795geYamFZwVZTSScqtCkomOl9Lf7vx5oVyD+FMEH4CyV8bGFBSGLil/ZSF0vkN/x/c8i98JWyiQDGEP7qePiO4KBhzmmCiBUHbTfz1Am9Wn41tZrh0iG7782AQovIIsV54U7OXx0L6lVUZGjACu63/pXNjGiO9fXjdOjkLT0d/kWnaYFxcQquyYHPdBHzmFU/F3FqQoj6LNUYvZRlaS2hfgUMqazqxzr1sRgoVvtBUAMa5OeMYVtieNiHdkwot4cI+08ZUPR1yeS2bWbKbHYQYk4prQ+AMlxw1wvdLLWbi1UOhW9czqHR8fp9E8ccQg4zZXgjz7YjJ0kYqmXRHqvi5o5pJERDbjKMhodV1R8jlyrgf8+NZDJu0xK9pEaoyxV8O7cVdX3piHRmwlWwF9ZNYtZtgr/Fk0RVvy5JFcs8HzPmaCt/AMJYwhoGHTkAfY4eYxSdkjGsoFouMG+GtR2vp6S6Ivx6z/pCwdJPpw6MfJDemr6f8TaXeSbWadE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199015)(2906002)(31686004)(44832011)(86362001)(31696002)(8936002)(41300700001)(6666004)(478600001)(6486002)(36756003)(8676002)(5660300002)(4326008)(66946007)(7416002)(4744005)(66556008)(316002)(82960400001)(66476007)(83380400001)(6506007)(2616005)(6512007)(26005)(38100700002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVRjL3RiRTMyWkw0aVZ3VDU1VzZrQjY5dUxCbWJENmhHWVFLY0dvNC8xZVRI?=
 =?utf-8?B?SHhiMG1sUmhWMStMKzQvRlVMcCtibkNRdW1xY0x5aHVJSWZOR0FHRWxGVWpw?=
 =?utf-8?B?RXovSWdneGNMSk1nUEpCRXMrMkxHc2FGYmtrc3hBMmdmWUZvNXZLN1BVa0tS?=
 =?utf-8?B?Qk9iM1RjaitaajVpQ1pBZno1YkM2U2RXb3BjdW91RzdlcUxkUnYxanBlQzE1?=
 =?utf-8?B?OWVPZXFqR1NUWEwzKzlGSzlyOFRYNEtCcExJd1pwdlUwNmlFaXRyOXFsb1VB?=
 =?utf-8?B?KzdNZUZhZi9qdG8rYVhrOG13aTM3T1FSY2NOL2habm4zRm9IODRMODNLbmtn?=
 =?utf-8?B?bmErVlVkaTdFbmw0RW9sOFdtenNaY0twNkNocy9iTmNBT0dsYmt6eGZ0VjZN?=
 =?utf-8?B?RzgyZHRkcUxxQ29BdlJUM0hGTHVMNGNrVm9lSlI4UEhqR2JKcTU2VTNtci9N?=
 =?utf-8?B?NzFoTm5BZFdlbTdtMVdBdlpjUThWMkszNVU5dDZtVHk2Zk16WXpwNmYxV3NZ?=
 =?utf-8?B?YjQycE5KR1d4M2k3QWNyZFYraGJsK1lab25lK1VXTGdYUlBtNnZ5R1ptbnN2?=
 =?utf-8?B?UU1uK29GZmlVMXQvYmJyK0ZWUnQyUmhvQW5kb0RuOGpBaVg3NForRUZpRUsv?=
 =?utf-8?B?aUVXangvZ3krSkxBUjc3RExnWUhESEZoakdVM1hlNHJ2OWtYVGQ2K0hSTTE3?=
 =?utf-8?B?VGkzNlk2TUpWZmtPMEhuZEl0ZndVcThVMjBHTUVGRXZDVExRbHcxekx2YlU3?=
 =?utf-8?B?R2lEaS9kWnpjRzlXc2RmUVdwTDJIdGVabWtEV0VvTS9GRGpRdENjRUJGb0NO?=
 =?utf-8?B?MGJZN0dLbXpMcVpJTERNcmlZMUY0Vm9VWk5QN1VyQjVqMWoydXBnTmhJM2lL?=
 =?utf-8?B?NEVud1VBa1pldWlSRHhrM2hnUFkrT1RCKzRoSHB2VWI0UFZQYUVKUWVGaWEz?=
 =?utf-8?B?aDEyYll4dnJTQWFCdjhMMVBSODdlT2dTQVNmWG8ydXYyQzA3T2Foenh6Y1pp?=
 =?utf-8?B?SXRTdndKL2I3ZEdCeFg3WS8yTksvY0JwVnNEMUJpcDVuQ1ZsV2x3d1p1bjBC?=
 =?utf-8?B?R1dYVW9VRGVnZ2dhUysxNXQrNlMxcVp6emhYbWZOcUtUVnc5VTI2OUNYSmt0?=
 =?utf-8?B?QkRad2hLY1FsTzEzazh6MnNWdERSSmthQjJNSGZwVTJqY0JmWmY5NVpibzJi?=
 =?utf-8?B?MFFHLytnTUp0RSs5eWREaERPcGxRRGtrNm4vcjRsck9rWXhoZE1JUFI0OEhp?=
 =?utf-8?B?azE2TnVrM1lsZmVrSWRvMzQ3QndyWE54L0dQeXQ5Wm1rNUlGNzhCQ1JrKzha?=
 =?utf-8?B?OFNPSm1BeXRUdWRidGEvcVpIUmFOVTN3YUFTalAyRGxuZ2M0TytNQjVGazFs?=
 =?utf-8?B?Z25xS0VQbjJ5eDZGVC9aK2QvdWxYb2c3VVA0VUJDOU1vZHpQNmlPeHVCN3Ex?=
 =?utf-8?B?dHJ3NG5DZXNtemVxZUpvalRQVlRHU096NGFsZFNKMzRseG1qRnZ3UW1zMW10?=
 =?utf-8?B?dDkvTTh3RmpUQzFockUxalZVOEMwNldESGY1T0R4dWtpZE82YUwyUldYYWtP?=
 =?utf-8?B?SlAyRHg1eW04RTlIdGxoaTRvS0pJUFNsWmZvOFhuL1JCOU9mMUVGNXpPTzds?=
 =?utf-8?B?RGkvc3RSUHBXRTlYYlpsa1B6WUt5NG91SWFJSnVOWXowUHVHT0VPS1dUT28z?=
 =?utf-8?B?RHNzdFh1Z2hsbXpLUVFOeEZzSVhDM3RMbzRLVC85SXYvemZlamMwVFJ3czY5?=
 =?utf-8?B?RmpQVDVqcXNWQ1NSdW5kWFFpNDhzL2s3L2dTVWRlVWN0U0N6czhIMjFuMWo5?=
 =?utf-8?B?L0x2Q3Qwd1ppM2RVT1lSSzVvL2JmTFZIVEJKU3NHM2tKOUY1Rytrc2pVMlBR?=
 =?utf-8?B?UDlpWHhiZXpyVnZ4LzhNMHZQVWFlalUxM1UrYW4rKzhmMVI5T0wzcWNWaHlM?=
 =?utf-8?B?cFVYaGsvaFQ3dVVSTGRqS3kzMGhJclRDWnBlT0xSSy9sVHZhWVh5S3ZmbWl0?=
 =?utf-8?B?c3hBa1pSb1kzOHlLelpQNGhDV2F0Z2YyTlFLajZacVNDS0FVNDJ2UzgyWTcw?=
 =?utf-8?B?RkVnRCtFRTNnenNmeXUrZjFINENzaWs3MVprSFZxQkJzcVRQaHl4TkJTM3FT?=
 =?utf-8?B?Z0IxMHp4QXZCaGlVY0tpbWdxMm9JbktUTXovM2JuMlBvMk8zQ250SUxJUTlw?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d45d42d2-ddfc-4c36-7f93-08daab06b0c4
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 21:30:45.2355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCs/EM/NJQ5PEK44uh6HA3UDwnL//skviPn6evg0fj/uuil2oFzlhmb5lMUalfihNz83LFyD4VtXi1X9XPNNsqWqAvQe8tdv35kF+UKPTf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4858
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

Without opening any of the patches from this series, by just looking at the
subject line of this patch, it was immediately clear to me that you did not
follow my review feedback. Letting you know about the typo (resctrl_ui.rst does
not exist) in the subject line was one of the few things I mentioned about
v5 after v5 also did not follow review feedback from me in other areas.

Providing feedback is not a good use of time if it is ignored. 

Reinette
