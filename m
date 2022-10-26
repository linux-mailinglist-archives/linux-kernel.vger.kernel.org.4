Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA08660EAB2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 23:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbiJZVMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 17:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbiJZVMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 17:12:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E54CF879
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 14:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666818755; x=1698354755;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=63R4ysYL/lw5YWPcFgugpjlMa5jc0EHu4AZJb/fUiaY=;
  b=gr2pE47nIQ4864CwVClWqUluL6BQuAemBUSps2a100/vrk1aLtGmLdLy
   a5220HvhW6kH2TdPDl0FY18sBjuBusmywS8ezqUDEgmYlWgoiX6i7DXb9
   JU/iA1NyiVNXOTywIwIPesVQOetZRODOqOfzZ9fQE3/XVZY16TkCOcbIw
   +aISiWoQn0H4dGVKb1Z86moNK+r/i/qevUK3dhbm9oBWpbSMOwerERUYH
   yJLK1BubX1qV+n2WxwFMHMXfuFBV5cjOibUbb5NdJnjbjbGoxhOe68tXH
   S7EhlJixMX5Ww1mpONqUGHBacLQMGQnnO57Dep/5EqZCPMn7h9iWsZ1lv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="287776380"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="287776380"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 14:12:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="757462915"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="757462915"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 26 Oct 2022 14:12:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 14:12:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 14:12:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 26 Oct 2022 14:12:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 26 Oct 2022 14:12:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnP74QsD9pQpw5q/Dqw48qQ90+mlWpaB9EYU5Iojime0fB6lIw0bc1tXG6i7LV2I6efyiNIkmjGuyPiqG5O6mAV8paHNtiE0IogGrJZPFNISRfzGJcYWzVBUNY9EAVj0elohm/t7BJ6W0v3cBNNiZ464DWuVZLjMquOEIOF6RDt24n9F+j8h5J7GO0zTnwqImbGLFMPObShMn7owBEV+8XfceZZRO+t4wYZk9ZXT8XenNtSOth8lFDMA2uChs5kEYKKU4d503SKO2k0BvUIVaejP5uiizQ2ARcNQ+JvAEtDP/X2sendPFzfcefmr8XRwYOKs5abeiB8A7c9blSGpRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dalevQwm0ty2B5KTImRPUaGVePKqaEA7Und4gYdIQl4=;
 b=godaglOMTRd6U8dgV0954JDwUWaUjW+2XN0gxUXIVnDq1MZIcWSnwXav1TpBL9z3Pzuv7w89QRnQNVdLq6hfmMo3O2jGlnaH/9YNgbLg74YcF31FhzC29+EraoSRpaUOKXXAAc+O9MGkAxRnU0oQZpRHZOKS4hFWCeG4US2e+eXMZLvK9C4Fr/KqXFdbQ19Pravc3rbq4YFdbwZbS5Zlr/C5hUnuEHv/yQ1WB4jtEREe26BBJyfVO7tdMJunEm1pQZh5IZds4Ds1VW2aE7MzxVoTBEueZPjp+MeSsjMcwR3zmRBIgEgLpBi3ljuyj1sqzsnue2BqxwDA+3lxfPx56Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MW3PR11MB4762.namprd11.prod.outlook.com (2603:10b6:303:5d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 21:12:31 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5746.028; Wed, 26 Oct
 2022 21:12:31 +0000
Message-ID: <317b4a96-f28d-aab5-57cc-f0222b7e4901@intel.com>
Date:   Wed, 26 Oct 2022 14:12:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>,
        James Morse <james.morse@arm.com>
CC:     Tony Luck <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Babu Moger" <Babu.Moger@amd.com>,
        Gaurang Upasani <gupasani@google.com>
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com>
 <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com>
 <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
 <76bb4dc9-ab7c-4cb6-d1bf-26436c88c6e2@arm.com>
 <CALPaoCiKUQC+LxDwKQ0gE5AQniJi_nbzrXi_HA9ZBRtiXdw_dg@mail.gmail.com>
 <835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com>
 <CALPaoCgiwtvxZMJ6f-BOTNMPXDbMB8QM42HyCAvYRi4grPiphQ@mail.gmail.com>
 <CALPaoCg2-9ARbK+MEgdvdcjJtSy_2H6YeRkLrT97zgy8Aro3Vg@mail.gmail.com>
 <715e4123-fdb3-a71e-4069-91d16a56a308@arm.com>
 <CALPaoCjUk31HvhaqWKfkLNLyZJzbDLJOnEqTsqn882CToLCGcw@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCjUk31HvhaqWKfkLNLyZJzbDLJOnEqTsqn882CToLCGcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::16) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MW3PR11MB4762:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dff0d19-cd5e-4dda-3235-08dab796cb64
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ikzKv7nhwQyPo9MuH07UIgDqy9D3HHFotyFVYCcs/Pp64jAbuRw2n3MsVVpn8qPbu6aouUhhqOHCNKE2qoPdfhUbdELMVQir6D7sXsXQtBnIi38lJecBEfIM8ft0kDy8G+blr3MWYXCbbUT/AOkvkkWcXrnUHdJDy5Dn2z7zuJW+T/Pg1bWO2x0iNiJ7+zepyhHJ4slU1cLFULgWpubUH9JvgPaYiBHeLV4y4mYDMeQcT9YTKfYRqmjbzka/otptiZAJiCsxzB0haDfKZVV4MbMUqNbL7dvCiSb9FAfYwFSmrxrpghbbssgo9OWG2zTnUEANVg2qYwANiXi4EQB/C9PFYVKq7cDqhS+Z6RkltuB7sAs6KmSBS9O4mMVDdPnoRM8hRL97mH1suPQhngCCxy+gcbVprNMb2S73zbMLzVk5mi/LH43eocJDVWGzfE9H26lFIPWMQq63GqN0CDkWnb+AezcOg4h8XE05nppxzc8uiPybc6sMAaSAlKcsZTybN44MV7a+Kb3UQPnKP7deaeE2rjM4g0bsF6Ok9i1lK+6cBJx6FJmiy7Zzo5MOF22LskS/RaYhEmcnY3PS7P/arUohNc9WKsKFy6gKTMZ80mqdx/V63eLsNpt/9VYJFE1Aa4ceapzRyJPeRcfW9LW5sHYA/QsmwjQSP/WrBMeFDAbdFu/Nc2admkDqQg754sp+I3GTTFxdGshC7oCov3Mkb1eQCTiIG0Y2Fr4V9CQzCD+3IpdThisYWzIH68GHrPLyUSde3mLShoDgfbBuJngWtQE2aL2couJF/EExosWMnKY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199015)(38100700002)(478600001)(31686004)(6486002)(82960400001)(6512007)(6666004)(54906003)(110136005)(36756003)(31696002)(53546011)(86362001)(83380400001)(8676002)(5660300002)(26005)(4326008)(41300700001)(186003)(316002)(2906002)(66476007)(66556008)(66946007)(8936002)(2616005)(44832011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clpMemYwWWcwVmhiSnVONkJVMGYvOHpSYWxMVmY5RnYydjF6T0piZkE2ekxO?=
 =?utf-8?B?ejY5d3BpY2orOGVNZExEbzk2blBjOWpRNnUwUStXNnB4NjQwbVREZzAyRkVv?=
 =?utf-8?B?UzZEcjUwYS9ickU5VG9hNFNFQnp3UFplN3F6YUp1VTd2eWllRGpxR3I0bk9W?=
 =?utf-8?B?dHRITHQ3ZGZpWk95NndEeDh2c1RaY3lYNWY0aGorWUNQcHdaM0VWRkhFNThQ?=
 =?utf-8?B?dHUzd2hSZ2grUEtqU2IvMmF4R091Y2xnQUQzOXJ1WkY1a2c0UlY2RS9EWTVV?=
 =?utf-8?B?eGNqM1R5NndLUHlNR0RpS0RBYXVEcWhPRVlncjd6eDJiZU9Oblc2YTRzM3pS?=
 =?utf-8?B?RUVDV013d1BSaGdybFRtVEdzNzZGY1VLTEhZb2owN0RzQVdLTC9QTlZiWlVP?=
 =?utf-8?B?QmJOcHE5WTVWdC9yTHFEc09VcDVMSGpwZHMrUXhCT2lWTVYydVNyZzEwWXIy?=
 =?utf-8?B?eERyOW1LWmN0ejAvOXdHVjVNaE15WnlhMlZ2OUNuU2Y2NkIrVjcvS2UyRGZM?=
 =?utf-8?B?VFpWZkNQcDZWQVFOVjBnYjgreWltUVpCNk5WOUcxZEozTGd4Z2kzazMveEhq?=
 =?utf-8?B?Y2pDdEF6dEtiS2lZZXp2ZDRDWGVFbThpaWMzMGlEZUQ3SmhmRXVhYUtLNzhH?=
 =?utf-8?B?NG5xR2YrdCtaRlhvYUM4b0FEYlNaUkM1NXpCTWhIV2lmNGwzNDM4R3hFNFlD?=
 =?utf-8?B?aW5mQUxhNkJWMGM4V1pVRDI0NXZOdmNCTFROZ3oyUmJ6QlViNFJxdnhNeXZW?=
 =?utf-8?B?SzlWajZlUCtoK3RZSEN3ZWFTRnNuSHlhbW9jbUtyM1Q3ZVQrakh2WkU4TzNq?=
 =?utf-8?B?T3ptcXBwMytJTlRNWkkzY1FjOTFnWnNzUFRVamt1a0g4RnhnQjRFTGt6ajhv?=
 =?utf-8?B?WlBTQnlRVnJvQnJGNXNmdmoyVXlQTDUvSk9ab2RIOEd1Z0lobkRHMytNZUt6?=
 =?utf-8?B?Z21nOUZFUzZLdFRsa1dQckMyMm5jVVNUc0pOTEdHeVgzVjFRVmVvV3NvNU05?=
 =?utf-8?B?dnYwQTJDMHNlYlpHd0dGZWhraGxZaC8rNjRMd2hZdDQ4RDltR0xmWGd0TndK?=
 =?utf-8?B?V3NpMGZBYjJITWFzWnNqSjAwZnFweDRvRm5VcjYyaWFUdEJ4RkVVbEgwbDB1?=
 =?utf-8?B?MHc2ZVpwUmNTMlR6Y3ovb2NiVlJvVlNEbStlVzQxeWdrTUk2cnFWUWFaK0h1?=
 =?utf-8?B?aVhEZW44RHQ2ZmxZcERwUGNmYVZMQzFHWmZRQklQbGFxalF5OFc3QnhoUVU4?=
 =?utf-8?B?M1U2UG4rNE5zSG9sT2pOY252cldOSmt1WVUvYmpIOVludDNEVlRvNnFiR1li?=
 =?utf-8?B?cUdvMm9wdjcrMjJsclNMRVVJNFIvZVh0SGVkRkI4aGJLV3lIa3pmM01yTEI0?=
 =?utf-8?B?eVJkaUNBMFF5KzdwZjJMaVJSWUVLQnpQYnpTZXlwODkzUVpjNHgyZjR6NXZm?=
 =?utf-8?B?dVRKb1UrZEV3ZGVUbmNqcUJLam9VZnVLNUZlWHoxYlB2Znp6UlBKZkxOTDFa?=
 =?utf-8?B?S3JCS2ZDRnJOM3RlemxJR0Y3UmU1eEdkNWlZcDJFekwrcE43OC9Eb0Vob3ZQ?=
 =?utf-8?B?UVBuenlhWVdlQkhoYUJJQUs4dG9aNDV5OUYrN1pYY0ZwcE1rM1lENERqbVcx?=
 =?utf-8?B?SkJGdUNzaWFZeGsxZGM4Zlc1QmZQaHRjRjRSbjV2d2h2TSswejJmaHU4ZlQ0?=
 =?utf-8?B?ajI3UlJHbFgwZUJNeWZhVFZrQU81NFVGV2NHSzh5NFpSVXZQWkl3UWdOTlpC?=
 =?utf-8?B?c0J2STZjSkZ5b0gxYS82dzluM0hKZm82elVaZW41dE14dkdTOWpnS1VoSEpy?=
 =?utf-8?B?alRpUDJVZXpHQ1QxQTgraUdxa0xTQm9IdlhSbmNZNHNQQUJHTkdzNFg2U3Zv?=
 =?utf-8?B?TzUzQThtSFU3VlhjUHd5d2JuVlI5cXpOWDkzVXFYSTBkT1hkSGYzVm9xMFJu?=
 =?utf-8?B?YnNKRU9NeDRJYTE1M0hKS0orT2RTbldzSHdGN09ydTh3d2FTV0VUaUlWUTVq?=
 =?utf-8?B?RE1ERWk3WkF6ZHpZdXBMRUdRSnBLcUN0RVBnRnlYRnhiT0cyNlArSHpSQWdH?=
 =?utf-8?B?ZjZ0VGRPd0Z3S1AxeUpBd0xlekRjM3FzZkd3WnR3KzQxK3NRVVVaeW5XYzFU?=
 =?utf-8?B?SkpEVVdva2ZNNStQb2xXMWpBdnZYZ2RBenQzZ2ttZnhBdHZBMS9ZQlFnNG9N?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dff0d19-cd5e-4dda-3235-08dab796cb64
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 21:12:31.4321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PajtCkY+QVyOt14t8WJ+NXmYm/dyRQzS3P52kWtNOByi6nTch+unTKuEZJ8kUrPzSNz3pP5phyXKdFXuLd4N7R2f9ROQd1BpVo38C8iDfwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4762
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 10/26/2022 1:52 AM, Peter Newman wrote:
> On Tue, Oct 25, 2022 at 5:55 PM James Morse <james.morse@arm.com> wrote:
>> On 21/10/2022 13:42, Peter Newman wrote:
>>> Even on x86, without an smp_mb(), the stores to t->closid and t->rmid could be
>>> reordered with the task_curr(t) and task_cpu(t) reads which follow. The original
>>> description of this scenario seemed to assume that accesses below would happen
>>> in program order:
>>>
>>>     WRITE_ONCE(t->closid, to->closid);
>>>     WRITE_ONCE(t->rmid, to->mon.rmid);
>>>
>>>     /*
>>>      * If the task is on a CPU, set the CPU in the mask.
>>>      * The detection is inaccurate as tasks might move or
>>>      * schedule before the smp function call takes place.
>>>      * In such a case the function call is pointless, but
>>>      * there is no other side effect.
>>>      */
>>>     if (IS_ENABLED(CONFIG_SMP) && mask && task_curr(t))
>>>          cpumask_set_cpu(task_cpu(t), mask);
>>>
>>> If the task concurrently switches in on another CPU, the code above may not
>>> observed that it's running, and the CPU running the task may not have observed
>>> the updated rmid and closid yet, so it could continue with the old rmid/closid
>>> and not get interrupted.
>>
>> Makes sense to me - do you want to send a patch to fix it?
> 
> Sure, when I think of a solution. For an smp_mb() to be effective above,
> we would need to execute another smp_mb() unconditionally before reading
> the closid/rmid fields when switching a task in.
> 
> The only quick fix I know will work without badly hurting context switch
> time would be to go back to pinging all CPUs following a mass
> task-movement operation.
> 
> I'll see if I can come up with anything better, though.
> 

The original concern is "the stores to t->closid and t->rmid could be
reordered with the task_curr(t) and task_cpu(t) reads which follow". I can see
that issue. Have you considered using the compiler barrier, barrier(), instead?
From what I understand it will prevent the compiler from moving the memory accesses.
This is what is currently done in __rdtgroup_move_task() and could be done here also?

Reinette

