Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0436C5F498F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 21:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJDTGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 15:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJDTF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:05:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E6C4AD76;
        Tue,  4 Oct 2022 12:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664910355; x=1696446355;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oafstkZPyBS9BfgKo83z5/XM7nVYn8jwfkaURYqqMa8=;
  b=cJaOESArRxqpgpXoUXnemAIBH4nwWh3y04RFEVK0emLRAIjqaSpDW4v5
   1Vy9UZ8uNa9FDzBNQPiuuvV/PYPPS9M4FK66nNdHyfb0embtihU18Z0Wp
   +nZ2wqYa+yRp/cS1v6TsS2NMkARXVUwGff4Qe71ndgB7tTUPh53dEVaIZ
   zdRu4svOJZMWt2O+ngH67uwObpcteR/3/bObY81LGEGeei0tae4Kfpwjv
   UwNJYAo9yOIwjHGJ18LqfLy7/nXYMXz2qbeMBvvx8DO3KACJTgsp8RPNA
   QetVGruBfNgAg3aNoI5PY40/PF1Tictr4/WvwwxrOmxHUfVs/l72nCBbv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="304570307"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="304570307"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 12:05:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="692612485"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="692612485"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 04 Oct 2022 12:05:54 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 12:05:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 12:05:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 4 Oct 2022 12:05:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 4 Oct 2022 12:05:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Boa5jIx+K9M3jqI3RT2R1zNDHlRLggxJvgyuo0QUSy7ZnjmaZykE3gqljSWod4nIKOQn7DbeoB1tGsVaKbXOJvFjiYA3h3dxt7nFeqVR2Tpq4Q0PlKkV9QIlNTjE0hYoWTSzs6MHmh2BK9gtSixULjWbNB+tlOKPdj8xAapzm/rtHXh13t7+6Kcjukss4c4A90Yu/BDY6pT3dKNtKLUOxnlVo5/5WG95gsoNrG/TSifa8cbDRiZvRiuQB+KaBSJcIkexFreUXlulss/IkUWgo9j3P6KCyrrR4+hLJcjSmqJLOSuHJvlScPPZ9mSgRxkliY7KAA44uMxmZ8g+ilXF7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pWEfjztjskcskE36vnqUTMOrxXeB4DwobaSrwkOGvA=;
 b=SuQmztMJdNwXmNgqCJSYy9/PRsHjd9ZdKH8cDZfirDFqymUqWIqoDkAsyeqwl68kACaq83N/mptXSPReBLC6/7ekvIoftIUa+8tM59Es3fO0nXrRsjZAL8QINh0P4zHFMWgf6u5i9IKL0ri4+GVwSnyg0fbCiq5ZjJtd3PEv+koBSw8CXFUxqc609BVq6cWbZBqqyFhnIeYS6Cc/bdcc3KLjgW5lUrrV/ajfDPToetpH6PNlidryBRL2iAD3KxIXZLzkrNvF8HpUFCU4+uvGzC5AW0h3OhS3Y3xMQgWx59MX4MZta6QvDw+buSY1Z66LT6SI8OvXwTsKCZrt1DZNQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS0PR11MB7407.namprd11.prod.outlook.com (2603:10b6:8:136::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Tue, 4 Oct
 2022 19:05:41 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 19:05:41 +0000
Message-ID: <51a7a481-ae64-e5da-5d4f-9bc6bf575f45@intel.com>
Date:   Tue, 4 Oct 2022 12:05:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.1
Subject: Re: [PATCH v5 12/12] Documentation/x86: Update resctrl_ui.rst for new
 features
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
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
 <166431042060.373387.8454967155095795574.stgit@bmoger-ubuntu>
 <71ca01ad-e563-3ac3-815d-0bbc3814ed6f@intel.com>
 <05f0ff0c-b328-46ac-c1fa-7aac09fbb9bc@amd.com>
 <39c3bf58-052d-fbab-3bbd-029f5507ff23@intel.com>
 <d60a73cd-3228-84bc-dd49-52ccb9fd0015@amd.com>
 <c4560cfe-f116-9f9d-1e60-b7ee932fb4b6@intel.com>
 <a7766c60-5e2e-77f7-97ba-8a9628d3cca8@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <a7766c60-5e2e-77f7-97ba-8a9628d3cca8@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0238.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::33) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DS0PR11MB7407:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e84522-02e6-4430-6002-08daa63b6e21
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NSqwfYp/p6i3icNj9THl/0fx8PPltIBjLqay4cxCJtX/ObW+sjRJMNBPCjjOJOtrnprEYqwoPnmZZ8Xb2L81416gSJIn9VC3olRMaEaw/O4gqeHeFjtL72yuZU4/QEP2UbbA1crKI8jzVlHyhAU19S5Cb5+A8XDT+SoI9Utrhfvwbyk52HISA8/xJyL4wCOaFm5lquJ+nYD/0LePyKgxsabq5nZc7Dmh9jmIArqILbeuQum2pFfGcms3lFlEubzTxgjmm7yp8SZEoN8tUgUCsdAlH91M83AD9X9Iz4faj235x+pc7ZiunJNDV5HEQ+JsaDqxAeIQCekdHMUwTUmMqWJPPrRxK+6j/M2d5xtuAdliNEobFWmhTud4x4DvwHQaU1CD4mcCvH+UFjNS0h2gjdMIEWr3UhmacDBDq3i/IlUx9yRUUUgv59Mfg1s1j5fLWu4LXxGG9mq3vqjt+on9FxGTIYKKRjquuBoseige2GFKPEpq8GVBrg1eeBMCi4gLJOENB3rgOmhy7Merq1AuJo7b2O2PEY9tQrQODaVe1V1zNiKdkiJMKCS4f2q5pTNZwRgfVUXLCcgD8SJD9qFnLLDKcHPtV/sr23iSRxsPuyjKegO1EAmpyx/0CbpeD4Yvya+niTeWqiYpl6vFBw7fuKtVhPrpCyTkizA0f+polv0BDJJKqYA7YkeKZO8vPYapDPsmuKQ5gRj6Y3ZaWm8uT6azWW/LVUGj/z2UgIJp9cxXOCRzFtJnD/BrhepO8BcsSM+UwhtDWEIQDn02V/HCuvzth+i77YFp5yqXpC0smHRuSqp5r4Qtp+ZDxkMMlCnMewjgzSy9+3hOJKF368Jn5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199015)(31686004)(966005)(82960400001)(8676002)(6666004)(6506007)(2906002)(2616005)(53546011)(15650500001)(6512007)(41300700001)(6486002)(478600001)(4326008)(316002)(44832011)(186003)(86362001)(31696002)(5660300002)(26005)(83380400001)(38100700002)(66556008)(66946007)(66476007)(8936002)(7416002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlhITG1ZNDM4SVdmVmNUV1hBOFkrZEhmSUZYWTNxNnlTb3FGTmI1KzRyVkQ0?=
 =?utf-8?B?YW9SNlZmVWZVRk1pUzRyV21neUcvVTgwYWllQklHelJ4ejZEcjg1ckFLRWtv?=
 =?utf-8?B?L0R6UlhSWkhHVnZOaThTeUtlUEpZcXk0dGZFTjVBT3p2UlNHdjVDYktxaVd0?=
 =?utf-8?B?cG4xTTZwSTZ3UzVyTzlaYUlRcHM3VVI0N3prMDQvOVdoTmtqMmhwRzJ0dVgy?=
 =?utf-8?B?Myt0SHo4VitkY3pmT1VrWGxpS3k0VmhwYXZ1Tm16SGlpTGFyVmhTRExxOUV4?=
 =?utf-8?B?YVorb2cvUDNQUkh4NjU1RFFabjYvSXBXNVAxTEFXdnpBSVpzRUtMelBXS2NY?=
 =?utf-8?B?aFFKc1pvcFo3MlpkSDI4c3dMTC8rcnhRSitSOU1NOGVTY3E0UHU2U0xpRzdK?=
 =?utf-8?B?Z05VRXFlQkZ3a0h3Q2tUd2ZRMGEwNjNhTWhkOW9DTHNpR2YrY0JydFk3NHlJ?=
 =?utf-8?B?cjdKaEIzeWJTQ2tydXhNeHVzcmtOZ1UvVW1hMElZdUFDZzlDRkEwd0xIbWhX?=
 =?utf-8?B?QVJmV0VQYjUyMzJucDNON1hmdDdPUVBHbUNKbkVER0JsNmd5THZYRkEvQ1FB?=
 =?utf-8?B?ODdEM2lXQ1FMR2pZRnAwc0RBUzVkVWMvZU1wUHpabVh4ZUZrSVJxUHZZM0J5?=
 =?utf-8?B?NEtCTlkzcWk3WmFuMGNoSGNWT3k4Vmlnb2pOb3JpNyttODRzcVdtdHFQK0lR?=
 =?utf-8?B?UHRWd081UVpISDJVRVYvdmh5V3dwa2dlUUVLb2Y1WWk2eGdVemdxdm94UEVB?=
 =?utf-8?B?d29oUDg3cENjcW8yR2NvZmZlK1p0cnJ4T1hXaGFRa0ExZGtjaTRKZUcyZkRQ?=
 =?utf-8?B?T0V2dWw5eFA5SldVRVpaNUdTQ1BnQlE5NXdPUnErdG5hZjNJU3pSeUxBK0d6?=
 =?utf-8?B?TkZZNzRwWi9lVDVIMXQySVhldFlNQWtVMHFpeVFwQ3Z3WkRwZWJNdkVaNlJ5?=
 =?utf-8?B?M2VSeXlyQnMreGEzVDNxdG5CNEx3d2trTTVOMEJEdGc2RDVPQmRrclRmWEZi?=
 =?utf-8?B?SDBqVkJrLzJWM3dwRHlyNldpRmZobkV5TWNUT3diTjhENTViclNEQzhWSURj?=
 =?utf-8?B?ZjczbU5yR1p1akhwUmZOZHYyV2ZjbGIxaFN5SzFCZFBqVEtXSXZmNGovK0xX?=
 =?utf-8?B?aTMxck5wemMzbCtDRlpsREdYMUg5NEx5NFNPbVVKUE8yRUw4WkFCNkMwWUdt?=
 =?utf-8?B?bkJrYmR3Z04vQXdaNXJzQks3clRXNUdObGxXN2ZYY0o5YkhMNHV1MzJVZlBr?=
 =?utf-8?B?cXNWVFRCMUlPby8vb1pZQkwyTFErTGQ0R2tXcC9EcGdlYjBUM2RBbDhIZ05v?=
 =?utf-8?B?bS9FVDZmaEdEdVZYYVZpNkd2SGd4aWVmYTBMUnJpOFVyVEhIaEdkcGpYVnpw?=
 =?utf-8?B?aXRNL3pWUVhGNFVxV1ZHakFXWjN4TVJNRTNLdC9pZEhZR3ZrV2dTeHNZeWJC?=
 =?utf-8?B?U1RRdVlGZW9ETzU3MzJBU2hBV2FmS2wrcDNZZGVkNXFyOFAyWmJsTE5CZUFi?=
 =?utf-8?B?ZkJNSWRpOS9uOFNCeHlrWnlwMWVCUUtNUWR0SVhSQ2xEOSt4Y2tYU0dyVmRO?=
 =?utf-8?B?aXAyYXpseXR6UDh5TEo0L2dWVGtFc1VNd2tSL0NJSUR4VkozUVV4MGRnemdt?=
 =?utf-8?B?UTJsWnBWQmswWGNXcFNkOUhYbjhKZlhLWE5VaTIwMHZpMVBiV0RFNjJlWGp5?=
 =?utf-8?B?UHE4MGtXM3JrNlBzaEEraE9pUkxxaUlnQ1pNblRWa2NGcjROMk1aMHNWYk15?=
 =?utf-8?B?cUxzMFZKYjhNQ0Zha0dBMVU3Y1VIR09LUVZqeUZ1bkhLekUra3BQL0hYNUh4?=
 =?utf-8?B?aWRML1hid2c2ZWdPRExGK25sNDdtRllQWkcrbnpZd0hOZXcyeU5STUg2bUdX?=
 =?utf-8?B?L3kzWjZIZ1VMUzZXTExGbHJ0ZmQzRXBKYk5YaXdwYWtSblN4TkhOR0g5aGhJ?=
 =?utf-8?B?MElrN1NOa2pyVUYxWFE3WGVPUEs0amE5cXJaQlpCL1dWT294bXQrRWkzZmxS?=
 =?utf-8?B?SlIrYWlGWDYxQVBWdzJmQis3SVVVbzBpVG8rUnZOUGxhcjUxQ25naVVvYzRx?=
 =?utf-8?B?dHpDQ0p4bFk0WFpnRUphT2ZWajBHWDlwVXc2VmhOYkVUelFEd0NYRGRMeUVq?=
 =?utf-8?B?V3l3U3R1blNRT3M5NEJ0RlFiVjJralUyZk1qV04wcE11c3FhcjhrZEhJV2ZS?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e84522-02e6-4430-6002-08daa63b6e21
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 19:05:40.9496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2aLBvB3jPcBT+oX89hGls6IB+GUWD+F7DO2WCAPFY4M+n325VrhZDg8kmE0Mh2qu/8sPajX7g2G2hDEEINI+0Hi71MATvViDs8khFCrExeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7407
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 10/4/2022 11:18 AM, Moger, Babu wrote:
> On 10/4/22 11:15, Reinette Chatre wrote:
>> On 10/4/2022 7:00 AM, Moger, Babu wrote:
>>> On 10/3/22 10:36, Reinette Chatre wrote:
>>>> On 10/3/2022 7:28 AM, Moger, Babu wrote:
>>>>> On 9/29/22 17:10, Reinette Chatre wrote:
>>>>>> Hi Babu,
>>>>>>
>>>>>> In subject: resctrl_ui.rst -> resctrl.rst
>>>>>>
>>>>>> On 9/27/2022 1:27 PM, Babu Moger wrote:

...

>>> +        * However, the hardware team recommends to update the MSR on
>>> +        * all the CPU threads. It is not clear in the document yet.
>> To be consistent, could "CPU threads" be "CPUs"?
> sure.
>>
>> Could you please be specific about which document you refer to? Although,
> I am talking about AMD64 Technology Platform Quality

I know that. I was referring to the text just referring to "the document"
without any indication what document it actually refers to. 

> 
> of Service Extensions, Revision: 1.03 Publication # 56375 Revision: 1.03 Issue Date: February 2022".
> 
> Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-quality-service-extensions
> 
> Will add this link in the commit message.

Adding the link to the commit message will be helpful to support the
change but it will not help people make sense of terms like "the document"
when reading the comments in the code after the change has been merged.

Reinette
