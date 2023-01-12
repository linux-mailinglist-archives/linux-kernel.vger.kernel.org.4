Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B52F667D7F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240156AbjALSFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236952AbjALSDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:03:50 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F89C2612;
        Thu, 12 Jan 2023 09:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673544662; x=1705080662;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gjihfRNk8MCNCn6eE80+faM35ePZ7Ds0xgeOXhLGSdw=;
  b=kW0ag73ZppxMl6KUQkph2PIsGXI2n9cGOG8MqHqHUQyeEJXFIHxSzGTe
   HxBlTPmOxXzikSLwh+dCqAW2eTxTPL991BbMi1A8iELABG9P9tszGUPMB
   /uBkggC0wyBJ7Qv+yB5OweOt51vDwQEbCRazyQvtqaukD2T0l018jFuKU
   OkwB6fS8jbl0aWstnk0vl2hloNHjC0UAFcg+2OK0sXv314UlXm9BZo9K3
   P42COSrhtxzW5A6srILW5EKMjdpwuohytnuNLjp/73WIE9n37u8ZDLUhZ
   g5D8VtBvBn+n3J9d+3DI/pU87bWLnosBoL3IZ5y2T3e5w5P3DrfOPmgXn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="321464766"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="321464766"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 09:31:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="903288658"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="903288658"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jan 2023 09:31:00 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 09:30:59 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 09:30:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 12 Jan 2023 09:30:59 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 12 Jan 2023 09:30:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0wxRoD4YqxlrBvktZnfPkuOGiauU3fFIy/ZP0Xh3b6qNz/88GlyoFz8ZH3uqI6AOepb8vpw0j4RPoyP1AjBk1d7rzwPH7Wx9iqWNtDKlmFDAU7M7sBewWgMACR6B/78qfW7oiuwdCYb+bppC9x8BQTsWjIFtf24ma6zi095syerBSpelT7HPeBgLGY6i94YZ4S6qDeBmRac4f7qbJdFfNQgkz1yQqzKirok6hMBk78NLht3gwBc+F7eBDP1UNIJalrZhQhyaUD0O41BLBSXxaW4oPFAwRZlZJpOcrGRiB6IPSbdFMNuk3K0C0724k3ASPJPa7adoJeKipi/Dl0Tng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FE2vZmt0QRwFX3g5OwD1MD7J7tP4wV4T3Z0n/PBy5ho=;
 b=l88sAXNfb4t16FDDHgoYWutUeiEYmVYlJzFmCUgoTqAFCfuzRwbF0SRpkvX11DVB+W5GKiqoEu/3/ZBplx7ZveycEijqKfDG7hhQrith/iCnApgfUTUN/7NK5PHqOJPLa2FCPWMmRGoe5ho30EeFDyhCmGqdBgRPlucW9mhjuZTGYAtJwoRw9oaI/PgbQrGmu9z4YAjGgqBkXcbh/4alyUNBAUFajyEmdj1DZWq6Q2pCNBxFiDNinDHQnycsaUxPwfSasdTBSt4MvUFDjI9p9IX8zbxgUx+wPnCb2qTBNo75Yf3gRrSMRQSIIT9T7h8FA31N/htWGCvu/M7n3rYlIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SJ0PR11MB6767.namprd11.prod.outlook.com (2603:10b6:a03:47e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Thu, 12 Jan
 2023 17:30:52 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 17:30:52 +0000
Message-ID: <65927b26-9f0e-7a82-a150-6459b5477a92@intel.com>
Date:   Thu, 12 Jan 2023 09:30:47 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v11 13/13] Documentation/x86: Update resctrl.rst for new
 features
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
References: <20230109164405.569714-1-babu.moger@amd.com>
 <20230109164405.569714-14-babu.moger@amd.com>
 <c7d563ce-13d9-ca6b-a5c9-7e08a3cdc3a9@intel.com>
 <MW3PR12MB45538E045D655C1D6B3BD02C95FC9@MW3PR12MB4553.namprd12.prod.outlook.com>
 <812a0d4d-dfb9-d351-9c9d-01d6943cd72b@intel.com>
 <MW3PR12MB45534504C044EBAEABA9E9E295FD9@MW3PR12MB4553.namprd12.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <MW3PR12MB45534504C044EBAEABA9E9E295FD9@MW3PR12MB4553.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0253.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::18) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SJ0PR11MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4bf116-8695-4bb9-6f88-08daf4c2c09c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BARuTTU+qmMlqeo9ChIu7QPDCx4EhrhiSFuJcHJzA9ucNy7xvbnc15BL8ReloKUDG22fb3sHIB4QcrSUaNWEN/Ur4LZ7AkpB8SbXzkGjkZAPx9NMTxOLXBe1wYquPMZsMM2OlXBeQWDm5zD8p5iow0zAd7jgx151+is4iEDnFOG8LUkQ/SYp4Fu5P3KZs5qYH9COP7d2UvevMwkHye21S8chwPJj62AllozpwYC4Rua/7tTGdmunRdQhrtKpm7b34vSr601jGx+ghWF+kbYOAaY5fyrBwoS89jX/D3ky66QWKwsO6L0vZhd03BZeP4LjrzfWHNVvzekkTwgYYT9wbqsIehzBX4X/J0yK1/Xwsqe3RmrFM002EjS21g4wepw51/o57Jjw5BiDH8+TSwFnVw8Wn5eQn/V4f5VlE5aZd5dyqdYNpa4CT4Xm3zMaqOHlnl/rb+uL7YuotE+pFWF4hS1hzYKbtDzMWoaBMtbueN5OoC8Y7qJq+lUcB9LS1wVBy+0DlWtOtLtdO71x1DRERy6+H+A0XqXMCidS1yuSFmPEuah1aI5u4GinuL0N59pwA/E5HNPpPAy93gYNQngk5xWbK0A0hsNRFcuHYymBavi59ysU01h2C8AIaGqIhaxxvTT0KsoaSRSLgLHKHF/eFveAfCURiyT/qNqNSgeAYHulYosUMMiuGUKLQoDYO3MRYKfcs5zrL/4sqNpDd8QfD4gHmUquU5pjNwnfp2XCOHA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199015)(6512007)(6486002)(31686004)(478600001)(26005)(186003)(110136005)(66556008)(66476007)(66946007)(316002)(53546011)(6666004)(54906003)(2616005)(6506007)(4326008)(8676002)(86362001)(38100700002)(8936002)(5660300002)(7416002)(7406005)(41300700001)(31696002)(44832011)(36756003)(82960400001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWkyU21RanpFOXNiV0NnS3NZSlU1eFdDYnhjWGp5MjR0b3EvY1lwb2J1S0J2?=
 =?utf-8?B?akxQS1BmQm9ycitBQWxxNlVmVzRxSGxCdlVtMmRJUHhubmFJNk1HdW42Z29P?=
 =?utf-8?B?TTFtQXNWMVVnVEVjZjZWeUZMbFZhRzVJVGpUOGZ6K0g5U0tQaFFEQkZtRzh5?=
 =?utf-8?B?VnNranV4SUhYaXR3VG5LR1A0NXAydlZFVks1bmxLLy9KMG1wbXlGTW05Q3Zq?=
 =?utf-8?B?cFd5SkZGczRNbW9KUzhqcUpKUUgvTnNSb2thakxmcTZ0ZkdWSGtGMVFFZzBt?=
 =?utf-8?B?WlpnZXhGODI0RVlhRFhMZlpPZnZGdHE1QlBuUlhZZlhLcGpPVDJ3eTNlRlFu?=
 =?utf-8?B?bGNXZlRMTjhJUjBHU0dSTy9yODM3NVdvOWVNV3cra0RGZlkzQmUxVnppNWtP?=
 =?utf-8?B?S1NGcVBZSEwxR3NnSzIzVDY5ZGpXQVhlWGgzYzJHQk1oYXVxbkR4ajR2dmdT?=
 =?utf-8?B?RlNWaGk2bFA1TmtaVmRheThZUmw2ajlzMEFRWmc0Qm5XRUdNbEFpcEFyenVr?=
 =?utf-8?B?NFgzYkhyblVJRjl5dVdFNllMZlF6US83WW9HY0owQkpOaTJuQnZKV210eEhQ?=
 =?utf-8?B?TnFoQUhVZnlRbUxmb1NFbEFxZ1JEMzVrRWltNWZIa1VaZnFHRS92S3MxMk9P?=
 =?utf-8?B?WWR5Wm95aTVvYll2REpvdzFjYjFUekMyU3JKSiszdHl5T0l5WmRPWEtZRjN4?=
 =?utf-8?B?UVhkOEhwb1pvQ1RoRXR6d0xSVkM0OTB6aHBid3VKQ0VSVnN4bUt3UnNHbDFI?=
 =?utf-8?B?ZWl3bzNTQVEzMjZsNjVYNHc0RFFqOE5XR21rcVJQYkpDbmxlb083L0hGeWZv?=
 =?utf-8?B?SGJwb2RtckNBeWhZMk5JVExPK1ZIdzNvNGMzSzdMSnZIK28wMnczNWdzV0pt?=
 =?utf-8?B?SlI3RzhPWDdWY014ai9VcGFvalkwTXdJVkNpUFhXd0ZPWG1BQ2ZTWDVaMlpF?=
 =?utf-8?B?L0Q2WUVjQk5GenhET1JpWXkzWkxGcDludFFoY2JvbXlSSWdxeXRjdFgxK2li?=
 =?utf-8?B?K0hIUGNJK2xnQk1qdk9QZ2ZUTndFZlhUdjlwUk1HZUtST0lVMnlGeUs5RlNO?=
 =?utf-8?B?cjE4eGZmbkNOTnBOalkya0FzaE9PRzFaeHcxa3J4LytqUVJRdEtUYTQ3UXA0?=
 =?utf-8?B?MGhMNWk5dnFFNVlWcE9HWGt2N09YQnBqS2pVODNNN2pPcENkSEQwRWFMZGFS?=
 =?utf-8?B?bnRLMnd0WEQxdjVERVU1Tm9TcjRDVGdpTlM1cXhFT0xTc1VOWTFjV1UwRU1j?=
 =?utf-8?B?QUtqd2JsYnk2RDR6R3NqRDhoODlWOS9EcDNuU3JXcTBPRkpJWWJFZlBZUHdS?=
 =?utf-8?B?LzBLdGttN3hMaDNKY1J4UDVBUWcyUGIxeXRHcnBvOGJCZmpyR2JIQ214YUth?=
 =?utf-8?B?Yjh3dXFWS2VFYXhVM0NkdCtSUUt6blkwUXhKQnYvRmhxbi8reEx2emhtTGVQ?=
 =?utf-8?B?enFXb1BWMUc3YXFTZ0xUWFZZdzQ4dC8vVnBTRXV2Q0NFR0xvRGplZjFwUCsx?=
 =?utf-8?B?NUE4ZXVSU0FmR1lYVGlPUkovZjJmU25DbXFJTk5kaHJyclZHcU1oK3VhN2Jv?=
 =?utf-8?B?a1dlU1JvMUE1NytaM005SWZweGlWU3NwYXYxdjVxOFVGUWd2RERkODBKT2h6?=
 =?utf-8?B?dC9PNnd2a1c5VnQzclNsUDNSYzdwZnRIYjVDMjZPQXVWaS9GbkxMQnhISTRI?=
 =?utf-8?B?ekZWaS8xSm11VzRLTkozRVpvamRiTHRVNTVHcHV3WHlMbm5NWUhqRWxmOVcx?=
 =?utf-8?B?d0dQOFBNekFocTNBNGozMjllWjBSQUlOVGtkeDFkTVUyb2ltZXYzZXBkOUg4?=
 =?utf-8?B?NG9QS3MveUFhdzlIUHpDbU8rMHZpM09VUkZKRFJyQ1NxNXdpanFzWW9vNjZZ?=
 =?utf-8?B?SkxUMDdlRXpLYW1HbklFMElnQzNoRUYrbnF1RWF5OGRVa1RldmxqVGFtTC9q?=
 =?utf-8?B?UlI2WlNXYUl4WTFQdFMwaXg3bkxiNlZqU1RVQU0xQy9rZTYxMExmK0lkaG95?=
 =?utf-8?B?aWkyR1Rva3ZyZWpwWkNtQlhXUEZweURVS0JUYStSaloxbFRhaU1KcmcyZGh5?=
 =?utf-8?B?OFhtMlZROStuQlY3c2lhbnhuTzU5QVYxeURIdHZpVTJlVE9rMnQzZUlTMS9i?=
 =?utf-8?B?SzZCNjVwQ25xc0RTYnV4VG11SEZFbnRVOGFHQTRkaElFdlAweHF1ZmhtVG83?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4bf116-8695-4bb9-6f88-08daf4c2c09c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 17:30:52.1175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHYvtib6wAdMkNBDUT93EnHLDYKHzM51wpRRaxWMP0AO2RE7wY157yDNXnRo9su9RXO0PrO9Hlfq70D88T+nZTzwo4DL02naTUiKXH4OqN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6767
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

Hi Babu,

On 1/11/2023 4:47 PM, Moger, Babu wrote:
 
> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> index 2860856f4463..7df5889237f4 100644
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -24,10 +24,15 @@ CDP (Code and Data Prioritization)          "cdp_l3", "cdp_l2"
>  CQM (Cache QoS Monitoring)                     "cqm_llc", "cqm_occup_llc"
>  MBM (Memory Bandwidth Monitoring)              "cqm_mbm_total", "cqm_mbm_local"
>  MBA (Memory Bandwidth Allocation)              "mba"
> -SMBA (Slow Memory Bandwidth Allocation)         "smba"
> -BMEC (Bandwidth Monitoring Event Configuration) "bmec"
> +SMBA (Slow Memory Bandwidth Allocation)         ""
> +BMEC (Bandwidth Monitoring Event Configuration) ""
>  ===============================================        ================================
> 
> +Historically, new features were made visible by default in /proc/cpuinfo. This
> +resulted in the feature flags becoming hard to parse by the humans. Adding a new
> +flag to /proc/cpuinfo should be avoided if user space can obtain information
> +about the feature from resctrl's info directory.
> +

Could you please replace "parse by the humans" with "parse by humans"?

The rest looks good to me.

Could you please do a sanity check by building the documentation to ensure
that the usage of the empty quotes looks as expected and is not parsed out by a
tool when, for example, creating the html docs?

>  To use the feature mount the file system::
> 
>   # mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps]] /sys/fs/resctrl

Thank you very much

Reinette
