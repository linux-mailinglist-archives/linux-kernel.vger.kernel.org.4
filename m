Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E2C620324
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 00:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiKGXBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 18:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiKGXB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 18:01:27 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAB026481;
        Mon,  7 Nov 2022 15:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667862086; x=1699398086;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N9rlC17JfbthFj7MBYpf0DhrL8T/LtMRc4+ZCxEox1A=;
  b=MeTy5fYk5tRfZ+XbLgIQMkNRFRZCutI/ELWaU8eaFIhEp7AfPHNhwC9D
   O44PA0Mccm+fLRe0RkK0bnyIkhiJ/8cFpO0Bb5FFcyxX7RhfGB7izXsCv
   PsVz8CrzDCpFv2iC7E1sVWRW9lgRgkXRiwLojsK5spuYz4suAQDrQxANM
   GvaBgjxaxAXB98VVlaqjKGO7QvZtJH/jAlvKhoIihiTcw7qNlJlo9Z4dm
   xLu+ryYMLgemesZ+lyH0zz2htDVSelJ6NCXFLCT3ZKZ2DcQGIsMVxqUbb
   m4MGj3n2isseMO2LpZYf0EBPpf+v4IPntrWPuZV7pmvLZ4xptzNPd+UA/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="311698615"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="311698615"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 15:01:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="669320550"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="669320550"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 07 Nov 2022 15:01:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 15:01:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 15:01:25 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 15:01:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 15:01:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiOunF4z+4iwTKCyjamWoYA+OsYEqVb8bskij8+XajgfdL2xbqnXon//iwHK1kmNy54AYLcd+QWEWZKZfZWMeGUUw7p0iWNWwtbtBYYyizMLNYELPipALWtQ4qJXAseKPtdU+hg7R//EG9hGQJ9g61bFnscsoI4PqLJnl716AoefOOgxkiNGkPn+tdm6RAd0Q7fDB8jjdVjT4eg+m3qCqJoIQx4Nef22558i3h/eKf+AlBdDThr0C0XLDrlNS17LCZxuKndpkO5M427yslGOHWlPAJ5dpuGnlIJLa5yh0cSLJ4LjDOSiVkwSZzvTsg+25JT4WoKXo2sB3SPNi9obzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYEBaGl7PvVqMBQxDL+Bv7EN24QtqN/mfyMLqE1/bNo=;
 b=aM7AoL85LM0EMLP1O0brPt3RRElnpxHe4+bLGe/jMK0U647auPFfkH2qUm8X2GmCrF+gw7DyIm8ZAhXSNYsTcuk6b3RAOgdQ1EPw5ZDeQlq6JyA2vhFh4LTf4dmr0/b3noLEcprR22/HhB535SjdBJXRnq3Vb41T7hKSRHfqDGtWCFmjkn2TOHSIids83hLEQbdBKVw9+GcvwSedLPkEc8iN0aB+7gYJa4Q3iMNESC3E6EnORXlHyWzGuUb3p4dhaVp9H8IQCtSJ8awimo8lBQXrPsnLeXKzz4XO19g8Bk68cmTKk6rCl9D1eNPLnxiHMk11fcqz4o1m5YF4rGgJpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by DM6PR11MB4579.namprd11.prod.outlook.com (2603:10b6:5:2ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Mon, 7 Nov
 2022 23:01:22 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0%4]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 23:01:21 +0000
Message-ID: <902803f5-76b1-d9be-b4a2-0230c05c9bd4@intel.com>
Date:   Mon, 7 Nov 2022 15:01:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 00/14] IFS multi test image support and misc changes
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <ef0df3da-c8b1-b996-edfc-d14956f953f4@redhat.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <ef0df3da-c8b1-b996-edfc-d14956f953f4@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::22) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|DM6PR11MB4579:EE_
X-MS-Office365-Filtering-Correlation-Id: bb7eb097-60f4-4d2f-b579-08dac113fcbd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dauJMcKVjqZjKeuvKOVzoljh5AQmk3fJaco2TYYxiOX4lTj1Rqga3KOzCgONZaXxkAZ3T7o9RxF1I4FM7ReTjNIW7EaSfRQl65/jBo3ggY4fkjBdXY9dHRuQvwuG4OB40RkgdcSuzPBIhZV514cnLNbo4fDuypQKnxpE7FCEONDwJ09NyEjwN6fCBr4oMs7aKU/0mwResWZ/6XjNTRsy9ECUGA+STSQ5vhtd4HM6KX/uTD1bCgD0eeZKyLEP3P31k+aY7iGzxJwuSAkwrjYYHtKAeYMevWAk5Z98FZDnIiMpgtgXFXC53suDNGDO13Vht5fyf60jjp6Th7y/t+FmaSF6BRACYA+HnsjeiFNL7oONCy8jhBr4AkY/g2cwXQwJsJGxrn5ieDvYdYwmBjuUCL7MqTWNmqx1gwX4ukWZOD+rwqnEvdMPhGghIWId0mvVCRHpl/rJsj4kQST+XBc3Kk3pq/1InIo1J4iajmRELBcYDi77fPZKUDs4Y+yusvWYrJCdBLI395hTLvC+dCWwXyRTqNifoaSxBNHXzFcwPE93tvwsWgziiJSGFzJ8QQVWgExMtcWyJddjsXyh0KWD6Z5m1ZQWEHrR6oTbHF6BjsmoM3NcN/GrX4jWu40/m/DnjVYN2DqoMhiuXSmtrjx5zK2TyUU3zfr11kLVVhE2TcBzaTITtWDWNbFWMkEgbOXKahttED0M8IvZoRYCNHD8dSOcYUW9cyGy72DGaWdmit/pB8BkOT/C+8P1xmYLmm0p3apPIbzdLzP01N3Z2i9ftd6pPTJbv/R/lTcxF3H0SEY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199015)(6666004)(6486002)(478600001)(4326008)(8676002)(36756003)(316002)(66476007)(66556008)(66946007)(82960400001)(38100700002)(186003)(2616005)(53546011)(6506007)(26005)(6512007)(86362001)(31696002)(83380400001)(8936002)(31686004)(4744005)(7416002)(5660300002)(41300700001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlVUQlhQMCtHOGRNNlNTQ0N3Q3pCeHZad0h2SDNXQjF2R3ZHUlpTNDRrUWsy?=
 =?utf-8?B?RHluVElBSFJFUVJRTE1QZi80TTc0QmFtT1dmRjQ0R0NtSUpDbVM4MVE5UUg0?=
 =?utf-8?B?TG5nNkRjT2h4cUdxcVhiUzdMQW91UUk4eGJBaGxLVTNKSS85c0dLajJXOFdn?=
 =?utf-8?B?YXpjV1VORm9kRTkwZ0hYd2pUSmo1UHZneC9XNjljSGF0V0lSVlU4RGlkRVdU?=
 =?utf-8?B?dDByam82S3dmcUJBVGFiaklWcENDTkQ4akRVUVJkU0ZWV0pKVkxVT3pYNGlK?=
 =?utf-8?B?RFUraGozam1lUnJOTSszb3V2OHA1NFRURzZhckt4OWJLVUtMZCtoUlAyUlYr?=
 =?utf-8?B?N2Z0MUU4Z1k0NUJSUmtFZTlWMUpkNXRrbE0yMzVyejd0K2ozZzljeDFFdzF6?=
 =?utf-8?B?RzkrZWNyZE4zeE0vOHNEYXFZNnhURzlvSVdXOHlnd3o0anlFV1NUd1RFMURq?=
 =?utf-8?B?Sk0wS2ROb3Z0NFQzbVkvdHZpRlNRMks5Y3luenZoNnFYOS84N3BZczg3bUkz?=
 =?utf-8?B?cXhxVzFERUp3QVNmVVpFL1g3ZjNjdlJnbFBDRjB2SVNVaXNyODRLcHVvN3VO?=
 =?utf-8?B?OVh2dGRTNUdtckhLTXFBM3RsZlEwZ2xJSjlGNnFORGM2ZmFnMnFLL3M5cFM3?=
 =?utf-8?B?cjdlTGFBdkNxTzdBMTZXN29Rb1FCV1QxRTBhSlZSdXdXVjM5aVA4ZDBnd3BW?=
 =?utf-8?B?SzdRN3dUb0VIVEFEVXVTdVZpUlFSaFR1NEJQUzZRN2h2RlRwUG9lVjVTL3Mz?=
 =?utf-8?B?R1duWUlSR0drWTUxL25YSjlpUG0ySGNSZXh5UzlreVRPbk81Rkk2RCsyOXVQ?=
 =?utf-8?B?MVVXdWZHYnJwdXluUUNkYm1vYkhtUTNKN2I2UzZtczVSZHFFK3hiYlRYeGJZ?=
 =?utf-8?B?UXRyWW93VnN5VWpRTHY5eFUzUURRcWtQOFhJczFiMTBRdTM1M0NNUkpmWkQ1?=
 =?utf-8?B?R0ZnSm9UNkVKdzJSWDZVWjJEaXNNcVhEbDFua1dkQTBpZXB4amFlSUV3OW1r?=
 =?utf-8?B?ck5vTW5mQTFZS1dhSWR6c09UOFdwOVlIWkNBY3grQ2ZlWTBuVU8zYm4vdUhU?=
 =?utf-8?B?cjM3UUlnTkhicVcwOVBmTWhlME5qTGROOVJpOE85ZDBVbHYrWmZyUUFCSk0r?=
 =?utf-8?B?TWhPeHNSeTJhZC9BRDNadGVNQ2pYU3JaWVlZVlc0SytvdXF3eWRNcmMyWHBs?=
 =?utf-8?B?MzZ3Y1lvc0ZVTEU0bGdsbHc3dm1taGVWbldQcEJQZmpYQlFvL0xhRVRCdFZT?=
 =?utf-8?B?bWZBbnNlZ3FLOTFtTWJiUlNVOGxyd0xBRGFsYkVnZ2RqeXUzSlE5VFNUcEY4?=
 =?utf-8?B?Y2JnanEvWGJDMDFrc3lmNjR0RVp4cnlUbC85Qll6ZnZGU3NpT2wwSmd1Y1B2?=
 =?utf-8?B?RDVHNnlvS1NuSlJFaGVRRG0vYk80bDNoc3BFcmE2MlQrcVU4YW5EQ0lQbjhC?=
 =?utf-8?B?cldVa0k5Z040VnI0Z3ZqN1hZYVlQc2pON0J1cnR3VWhjK0JVTDJtcmJsbWNE?=
 =?utf-8?B?RGtoY2dMUmw3TWgwUW5uZGl0VVgyUjNoTUdxMUVHVTROYUVMT3BjRTlxZVZR?=
 =?utf-8?B?bVlFODhvSG1mRm1Fa21ZQklGVnNPL1FwYStlSWxnZkM2MUdMUk0ySm00WFE2?=
 =?utf-8?B?czhieHhiSURrdHpBN0FoRHBRQkwwdzdhQWtMdGI2YWRud1dMOVd2VkZiV2ZU?=
 =?utf-8?B?YnVrZHdjeEx2T0pHaTZQMVkvcEFPNGtnd2RXYmZRWEdLSktXYjZsRk5FMVFr?=
 =?utf-8?B?ZFFBVHNXeUcyMXd4bmJpdHl1elovbno2K2NaSXBaTWxzS2p1ZUpsSEVLMkc3?=
 =?utf-8?B?RFZPVWdCb204amdGdVpqcU9pc3FTNzAwNmNXTCt6bElwL2pnaDJsalVFb3Bz?=
 =?utf-8?B?Y1RxOUtHeUM0dkZPY2JMbnl3ek1lbmJCU0l1WDRJa1JhbFR5R0lrdkw0a081?=
 =?utf-8?B?QnQ0alpsVTFwcE52QXhQcng0NnZpS0NLZjhSOGYxclpUc0FxZGNQUHdUUFd6?=
 =?utf-8?B?d3c0a0lrMCtsT2J0ZUs1eWFhN2FydkxoQU5PeXFkblVYSS90a2VGYnpaVGxr?=
 =?utf-8?B?ZlBKUzdEWlJIWGV2eUlib2VURFNIdDF3T3grZFJpeWxXQ1NvOFdKWU5DVWZ3?=
 =?utf-8?B?TXVvbm5VSUNCWmtPWDBHZ2RoNkg4R2tobHE1M2ZrSVRDR2ZHZkF4UzQ0QlpQ?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7eb097-60f4-4d2f-b579-08dac113fcbd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 23:01:21.9239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VtfpdbH6/rI8vPVqTRBpFL+l/ok43Pc8iJk1/KvPB8dbsmQBKX4XsK/fLHub4y+/0jknSVc5QbdsUk4X2apsOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4579
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/2022 1:24 AM, Hans de Goede wrote:
> I see that there have been lots of comments on this series already please
> send a new version 2 addressing all the existing comments. Then I will
> review version 2 once posted.

Thanks for getting back Hans. I just posted updated v2 version of the series.

Jithu
 
