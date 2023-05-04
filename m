Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713126F7312
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjEDTN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjEDTNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:13:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFA95247;
        Thu,  4 May 2023 12:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683227572; x=1714763572;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7uZYHqkg/wwXKget8F3hEY6H+iCCjmyHOJi8CgkJeSc=;
  b=XT0dDmG06gWFnp7yWGbbCATz6h8T7luhFoBPeQM09er+P7Jvy4UoIP44
   LSCHPMPo/inkqS5154V6cX8HB6Ww2X/+Zx+wMum8VR2NO+YA3BO46ccnK
   d86ZNFihzS7g4SHTFOJ0SjC7HUzbvFOEmo3awcUZul0aslZW4eKSABwqj
   QAmZcXeGNLO91rLbzUkfk96v9jQZbaqe+N4hNEmkl/mhwl5Dd05QVhbck
   LIrKpPcyhtxeiIMpDfucoYXpaJLlLsMyWnNE2kcsxJyhFDIpc4VFY/ly1
   kxURqVNWSE4B51xMNozQh58AwZ+Yu0oZeWUYYEtZ8GiZUzm6T7Nt6X96s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="352056503"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="352056503"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 12:01:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="674662965"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="674662965"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 04 May 2023 12:01:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 12:01:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 12:01:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 4 May 2023 12:01:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 4 May 2023 12:00:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDHjjvRftBIPhf61sPNHMOaecGAjvipH0KqxqfMiUwWt/1uXrLPNvY73D0GBYrwghPe5GVl9I2DcZ2yMnqUeEAdBTUrpJ4FOByuvFJSHoFLap3uUA9pLF2IF1SF0sLvAKz+TR3lPGhSvP9FXFWv02sYw9XjhHfhVZ0rYgwMnOgS0WPVsg9G0L4moRmpqrCmuWXxyk9MwqhHQR0vzK3JBaJNivS85q5cE7oSDAbg8yaxVchHk4X2KL787xDeS1q+uITSly/rCeVU5lIxjdqSpugbfQquNhduQ6lJG9cDxRfa5li1jfmxOZXkx9P+CTyJXOhIsqEK++iwIjFWtzJkzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uZYHqkg/wwXKget8F3hEY6H+iCCjmyHOJi8CgkJeSc=;
 b=DVWGkdj7baV3FUAFlynTwrhQ0Od5WOdULDoN4U3JSY6lvvdGUhgNbohG4I32AUSOCDslEul0awjBT+6HPSEucuKSeaO37VWZ+159t4hreKAFwxP/TsCKUMBnkNJB4jqXQPrjpKPefGntkZaDIUxWlWv5f3YV/2W5p/jFnp77DytF7r6Ua5+Tax9hGOQHmVU7m+n96DgJUaG8x+R3iRNGauqCyfInHvpRXwHs5U4hIdKhCWV6sS3SjBkoBqtnZ96FdvYCH4kbvW3U7O4+jzOJYj6kH4YOMUULcE/cU+R7rJVNCIMdMCPQSZcWxMh3D7GMBUCiUw8q1sNQSYPEgt5t0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB6947.namprd11.prod.outlook.com (2603:10b6:806:2aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 19:00:14 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 19:00:14 +0000
Message-ID: <0a2bb59f-769e-42b0-9277-10a4b04a03ed@intel.com>
Date:   Thu, 4 May 2023 12:00:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH v4 3/7] x86/resctrl: Rename rftype flags for consistency
Content-Language: en-US
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
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <168177446947.1758847.11380042804869155387.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <168177446947.1758847.11380042804869155387.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0036.namprd08.prod.outlook.com
 (2603:10b6:a03:100::49) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b8f282f-723c-42e7-63fa-08db4cd1cac9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 98Zx0z3hjM4WskYRYAvcCbQz4w1H/XQTtLMU8TTq5zCFfP/QO0x1Dpgs6/oSYNrCfhAWYjSbXu2e41pyoMh9ifqFpmtrHp3yTWkPYt67Igif9kuZ9SaionupokyuY9+3LBv3yFGhrqutDt1ktsDp7lMh8vXJvyz82Y2rfM2QAnvyJ+ibd76Kw1hzJm5Fd9dQSklt2f6W+QuWU9CBk7MAtV4FEQOLUYgWYLbpz9cRgsRTcR1nd6yK1bYqcPWrAxCG2WPL0rqbU5Je/JAZLFktontsPryryv6+wkKZoNL3n1ui6k4Fh6ZXow6FR8aT2bLVGdTkPWRn2ov+AA4K3zOViGHHOkzehkwoHcPP+Gm8okOwrvcTcYPB3sd+LfG0FycVOtO3AB3LhVDPuSNKaX74rrabkQmvJrVp/UCvIgUSKinjGcgZkb/yhTF6VMBKiY2KkOtu0jgZwYEHPGpi5uRAr4dHsdFkKPC4xtIpLpKhljTxzBTme2Owx3+rUCVCZD6jD4NQ9BeXW1gzwvCzsAfXyeA7btp66BQUFGO8PIDr66UofPK+PKosWZhZkuarnVOZt2hvqbkVUuBbNr4rrZtLH9KzwXGcEUqPEQnNQpjbinCXL7vacDtNPQi67siL1WG8MyRjYdGPq5HD/CLV5ITxIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199021)(41300700001)(6506007)(53546011)(6512007)(26005)(478600001)(4326008)(6666004)(31696002)(86362001)(36756003)(2616005)(6486002)(66476007)(66556008)(44832011)(66946007)(38100700002)(31686004)(316002)(186003)(7416002)(7406005)(5660300002)(4744005)(2906002)(82960400001)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW4rbFlXYnl2Vld3NHdXOUxqcy81QzBUL0pyUzZzdWRRVjloR0VIblE0dGFy?=
 =?utf-8?B?WmxrWGg2RkNtNXpJR3Rabk9la3NLZWlWWW01NkpwUEcyY3d0TUJyV1RmNXhT?=
 =?utf-8?B?dHdnZEl3YVFDeXNrOTRUTldZdVd2YkVPZGpWcWh4bW15NHhMeWREaFpTdVd2?=
 =?utf-8?B?V09tYjBaNVBQazVKMEhlcWR3S0FlblFhME0weC9CSkJhTFNIbVR6aXFZME5u?=
 =?utf-8?B?VjBVRVp2U1BDRWJENkZsWXQ4VUQ2ajVaNEszeitReEpsV0R2RmxrRzI5bG5q?=
 =?utf-8?B?WjhpcU5rbk1wdHdMeWZEZFZ4eTNTU3hTaWxOY0YzdUhUVWxhRTNWM3N0MlNO?=
 =?utf-8?B?MGhxWERPQlhxR2RQTitRSmkrb002bHV3YTFHQmREbTFRVGdwQ2pIRzFKWmtQ?=
 =?utf-8?B?dURnaGZKU1RjV3lhZWV3d0lDblNJRG1FeVZ6RzA1dDM3Ykwwa3AxK2VDaXJF?=
 =?utf-8?B?RmZ1SkZNVm54V3JzajlhTkZhYjEwa2R2RGZ6cDVTUmUyaG9HeGU5ZnU4aDMr?=
 =?utf-8?B?c0xsMkdJaFRWd1lsWmhPUklaNVkvUzBmbm5jYXFURzNJRGMzaEUvVzJpeGh6?=
 =?utf-8?B?RVBiOXFzOTE2bmdwRTEwdkJ0dkJ0OGdyN1pVbGRwL0dOZ3hlbHJlbVg4Rkgr?=
 =?utf-8?B?KzhHSnJrU2wxSTh0SXVCWWZQcXBQUVBSWkhvc1NmS0FNeHhaNDVlWVp1ZzYw?=
 =?utf-8?B?a1FBOUlyVGNHV05WWHhuU0thYkh3T2xreGMxVnllSVdvZzZndGJrZGFHMGVG?=
 =?utf-8?B?TW1KTUhnZzBtaC9UdUU1R01lN0FaWWFxYy84UUR0eWtsQnFBZzM3RlZZWHFO?=
 =?utf-8?B?eG9lTm9Rbm5kcWJXbkp1clRUbUtXU3BPQjhISms0VnQyTnZVTVlGSi8vOTha?=
 =?utf-8?B?Y2dvZlZnbWJZZ2d6TkFaOGowZitaSFpVNnp3alhjNHpGRzB4Mkl3Qm9RUHZD?=
 =?utf-8?B?WXFaZ1F1R2pIWnVMdUVtR2s3SWUrRTMwcGF1cHlGY2JaUzBwTEYySXBkKy9s?=
 =?utf-8?B?R1RCTWFtUmZUZ095ZlFxNElpR3p5SnVOWDFzQUtTRHFHOHNxbUl4dUx6U1c5?=
 =?utf-8?B?bmpGeGNTdFgwaWs5aXUyQ05tTmZRTDEvSTNZRDZ6WFNlU1g0cERvYkJubWIw?=
 =?utf-8?B?MVhhbWFzS3FUY0lqbExhSU5CdVFlUUNHQ25HVk15NFE3eDdvc2JJMkYwWjVB?=
 =?utf-8?B?TFpsK3kxN3dXWGZoMnUzaktJYnRGekhoWS9Yd2M5TVZIRWFoTXpSUS9CWlVZ?=
 =?utf-8?B?MFovaFoyYzIyT0lQVEIwbFRhLzM0VVNyQkFQdGhXcS9md0psQ1FWb1I5QUJz?=
 =?utf-8?B?c2wyQ3hXUkk2S3d0aDV1YytrK3NCeCt1ampubThUTmVMcXVVdGZ1WG9RRG8y?=
 =?utf-8?B?Y2k2QzhaK1NieVptNUl1WVlyeTRVc3BKV0lKaWEvOHliOHRYZGw2bFE0OVZB?=
 =?utf-8?B?QUw5TnhuY1BGK3Zpa2dldldwcEpkSWVVQy8xeXM1SVBDc3hLaC9tWWJxTVIz?=
 =?utf-8?B?Ym9ISHNlV2FnQUJuMzFJM3JFOFlFWGVxb2I5SzdDOEI0WE5GSjBtR3FrUWVO?=
 =?utf-8?B?cGxzbUVxblZtM3BaQ1dzN3psK253UU5VdGo1NVYrK3ZMaWxKZ3dvVXlwdktV?=
 =?utf-8?B?TzRKc0VEQlpoMTAxMUFhZXYvTTNZcE5tc25tSy9UMllkVmxYaWhJSm9xaHF2?=
 =?utf-8?B?aW5rdU1WS25na3FXTzVmL2d4ZGF2ZkJsKzFiSlFJTkVtMlp6aFFtQlZodERB?=
 =?utf-8?B?ZTE2UUZCSE1Uc25BVlBJSUNUR0oxVzdmZHJtbVZPTG84WTB3TExZK0R1R0R3?=
 =?utf-8?B?YTh2T3dQRU9nV01iM0Q3dDgzZ0xmbVZJNXVSeiticjVlNGRIYzRqNE0vOG9h?=
 =?utf-8?B?clR0VjRwOXdlS1ZjdWxKby8zbHJsUDZ3WHRzenpMUGw4alM4TnZqbFhJQzg5?=
 =?utf-8?B?b202MXdyeVBGcGhnajROQ0hQV1pvdzgrMFBIOUxrT2FNeHl6U3RJWU54a2xk?=
 =?utf-8?B?d085WXpCQjBDbnhSaW9ORzZHZktweTI0djZJa2RFS3AzOThjYTJKQlAxaUND?=
 =?utf-8?B?NEUvZ0hBbjdQRDJXamoxc0xCQlpaRVE2T2NLSHVDSGg5UzFETVUwbGR6OFhV?=
 =?utf-8?B?UktDM0R2RXB2YjNENEhDdFVCd3lCbS9waEZmcWVZYlloR21pcE9qMkZscmRh?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8f282f-723c-42e7-63fa-08db4cd1cac9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 19:00:13.8745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/hZTbF/ttI6Ujy3D7aijDHnZMpSCdMIPB55z6ubNdKAGkn4MzIljRjMahMlYVy6FExj4821Mqo63RCqX6UGkhYPSv9HOLBWKNUIcOp90aI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6947
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 4/17/2023 4:34 PM, Babu Moger wrote:
> The rftype flags have two different prefixes even though they are used

Could this changelog please start with some context about what the
rftype flags are? Please note that the changelogs are required
to comply to the x86 requirements as documented in:
Documentation/process/maintainer-tip.rst (there is a whole
section on changelogs).

After a context the problem could be made specific with something
like "rftype flags use the RF_ as well as RFTYPE_ prefixes."

Reinette
