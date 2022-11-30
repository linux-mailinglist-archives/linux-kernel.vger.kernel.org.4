Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBBA63CEC4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 06:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbiK3FiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 00:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiK3FiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 00:38:22 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A49C40903
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 21:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669786701; x=1701322701;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=sSnQmRXpmAhCQpP3I1DUv1VjWMIb9WdcIJcpDZul1G8=;
  b=GZRMKdMgX66KsxY3hPRwr4/Ia5Lye1BJ8tNrCXVoSJUU4VsPEIxqdsDW
   uj8Er37P4D3d7hrK+LsUrcQ2cfnw7eawcwJNrbcISJxtfW8nUJVGPP55G
   TiCEtxAdv9WTqf8dQ9wMb+sY6yQTzv/CtBaE+Vi0mL5ZF6uy8y2+PWOpx
   bdGsuQz+18NKjD95Zz1TrzbFHJRhsODjW+YQ5Vgs2PIdE3TSv/hS/RSLC
   SuxrSPAE/42BSaraSjfSQnVRL3M+Q2toZLrHN0v0kdjOgQLUXW3jsyZg/
   q7qRaNQRfqsvGthInNhnha1FlHbOsqET+y1igybx6gknC1HJCejeL0ncb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="342231683"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="342231683"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 21:38:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="750187167"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="750187167"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 29 Nov 2022 21:38:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 21:38:20 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 21:38:19 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 29 Nov 2022 21:38:19 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 29 Nov 2022 21:38:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcUle5WKSQuh1Y8D04a/EJOhZCy2tYrOzFbH4TOqkb/nqlZfyjqCD21P/lzSApb0gbu3ZQ+PyUr5mVsZ0mhLVwisVfwaVtrWHu4AWYYlwM8cTrp2clC9zQYFNR5F/1Y0C1kRI47ALH0ezbLkqfVBSz3mlbRjpgdv1BxMotz5B7YImWuJjOePu9dLz/ur2OoWcoXg8L1M4wVWD4L0rhGXaVKGzb/Fsjr9tSTw5x2tHhYILeFCKK/6qCaz213jAqyMxswE74E9UeMp48oGSycO6a/BQst6wZgKWdWBEUgN8AESDvEB2IGEau7wan7zlZbGC7fMHCAeIH5xIC/uqsnRDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzQ37rJr7oX8v51XkU5qWHtyYhcTxAAlt4L+FvahfFA=;
 b=ciq+E4fe4gpX2wfgr2A6XNJ82rUBkDU546QF8nYJO6dm09Y+Fm5ieTuPss0tA2JtPvU957Ci20f1AwrgKdbamk8QuoO6Ij9YbqFhHAQGooIHGcClSOrNAfmBiuSOL9nKzlv4O2CR/LfO6EOTA/diGUtERsaN9iO3GWpZPL4AS9ai+rSio00QA1UaYD3f/eLB86etJBDPBwIW3xpbpYpM/ncPPqraaRDRkl085bbTLDZP9f7G1DxhPqXbbF+NnzTsy4qPCnoALV9S7ab2LIbKHs/7Es0UfAUxajRQxa7Zy4mzKY7XbeVd0fNsAfbBRngSvkg9aDWxy2GiYBWdOCUmWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH0PR11MB5658.namprd11.prod.outlook.com (2603:10b6:510:e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 05:38:17 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%6]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 05:38:16 +0000
Date:   Wed, 30 Nov 2022 13:35:08 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <john.stultz@linaro.org>,
        <sboyd@kernel.org>, <corbet@lwn.net>, <Mark.Rutland@arm.com>,
        <maz@kernel.org>, <kernel-team@meta.com>, <neeraju@codeaurora.org>,
        <ak@linux.intel.com>, <zhengjun.xing@intel.com>,
        Chris Mason <clm@meta.com>, John Stultz <jstultz@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH clocksource 1/3] clocksource: Reject bogus watchdog
 clocksource measurements
Message-ID: <Y4brjD/xUDlzJ4v7@feng-clx>
References: <Y3zxB6r1kin8pSH1@feng-clx>
 <20221122220712.GP4001@paulmck-ThinkPad-P17-Gen-1>
 <Y32HFE+BaATh9+l/@feng-clx>
 <20221123212348.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4QZzzk+FdGj4AXm@feng-clx>
 <20221129192915.GD4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4az+FT5YjpAWjZc@feng-clx>
 <20221130041206.GK4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4bg1H/HLRLfucNO@feng-clx>
 <20221130051600.GL4001@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221130051600.GL4001@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH0PR11MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: cfab9798-21a5-4760-f3fa-08dad29513db
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QTL7WxnQ1w4qbYPfz+xBj3q3reU0942/3DpzxyFLgUR7i4xlQopaU3iDnAku1MLbgYMoL+5koa4RYBECaFdtE1pVSThnsuBrFl+JymZEo3LbzMzf2GC+pe2A5xpwNInwMTHsmUEusu6kDK5wlvRTNg+LitRoDYgGeP97/osgDFL81dm9wS3lECodgbGUdK04qgYxZZjdIGFHFwG4rpORPTVCpZe6IOeo4AzH9OS+ovC1ACf+jjrsT+38VWpCKtWCgafo5wI9bLZ7EphZbms8hh+xIITeD0iUZ2IJXKqJIsS3Siv0ksTPOjnZKrm3YfsHqbhVPNimUxshcP7smOsl+ZQ9hp+YEdeN0Ti3Hdja+J5YSp9LukN+Hh4GnK157DSXncMGTS7HAZ3KbVo34Emwk136Fvc4Cbx6gnd1tcm/oKhnTMw65KRfTweyB9aaaO4gR2W1G/0ywXYXgP341sHPa4RJiLVCiZS578lbHwh5O2q2KPXUI6Zi+M0TiuyGd46x2JTWxtP7Ls/hHXbpLLcOwMtU0pnGiLucrKxWkHRMPp24mPSTlAGUKRQCigjCVCWvd5hHG+f3GCIu+2yKCIJWtfvmIb/EAfC2f84ic740FSeLKz34vL6X1L/aA3b6hzH3YwAMeFW4dBNF+dSzXKoxEmF9I0qQGbLZkxfQ6pkRHCRkLhxQG31UzEJlf6LReTbI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199015)(8676002)(41300700001)(4326008)(6916009)(316002)(66946007)(6506007)(54906003)(6512007)(86362001)(66476007)(26005)(9686003)(83380400001)(186003)(33716001)(6486002)(966005)(6666004)(66556008)(478600001)(2906002)(82960400001)(38100700002)(5660300002)(8936002)(44832011)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHdRRDMyMkZtUDh6d1gxanhXSXJ3VmI1MWo4SjQySU5DK0MrQmNyNWdtWE1F?=
 =?utf-8?B?T0ZmN28zRmY1MGFMTFcxMXdJTDNQS2Q3WFFleCs2a1czazVYbkg3eHFMSDM2?=
 =?utf-8?B?bU5YRXdJT29ybUg4WDQzQ2NnbWo5QjJhSlo0RkR0aTJMakpSNEkrNjkydGJY?=
 =?utf-8?B?WWgrMVdrOWNBSG9OZjBFb0kzcm90RzdHMWNMeVIxT3ZEYmNGaHM4VXZTWDdC?=
 =?utf-8?B?Y0JGWFl6Y1hRanVCRnBYYS9jVnhKcHlDaTlGTEZjVzlUbk5oVjZxQVI0STZD?=
 =?utf-8?B?N3BWV3EvdEZSRW5kZ0xRc24vaC9TaFBVTCtBbjFNbmR5Y3hRT1hnSzI3T0RS?=
 =?utf-8?B?WVlLWjE4QXBOcm1JTEI4YXhmMVVhMnBCdlFYWnBObkJ0QTltbWMwLzNhQ0NT?=
 =?utf-8?B?Tys1YnBKanIrNm9GUHg3WTFhSTNROHVId1VHOGduWjBNSFUzdmJCSmlPYWsv?=
 =?utf-8?B?U2Vuc1ZCRkNXK0hTUzZGRjBFa0ovbFdjZFpVL2ptaC9keU5xZmRTcmYxVktW?=
 =?utf-8?B?dWJHcGZ0MWZjdWx0QkhwQXVLSmd0NlNKcGVKV3ZWM1daVVBZaXVEL1lUbXFE?=
 =?utf-8?B?WHk3Tk4zMHB2ZTlqZkQvbU40bStWTW4ySHlwQnc4b0x6YnFpZFVjRjhQM085?=
 =?utf-8?B?bUNmVzRyVjVoR0ZXTnJVWnhnTXBNaktYL2NyNnJKcVpNQ2JPcVF3a0hhRml4?=
 =?utf-8?B?NWNvQU1GdVlTaC9hcmxNcEx2Ri9qc3VJc0tPNHpuSE1XM1FVMUVGbVJUcjRv?=
 =?utf-8?B?ZUJjUnZ0ODRzNzNxOVdQQUdiYU43S0FVQm9CblE2NGc2RXpmVllZMEpaeFJY?=
 =?utf-8?B?TGhvRmJ0RHhSOGx4RjNiUnNkZHZ2ZjRCV3JlYTRUQnhmS1QvMXU4MDlrNGh1?=
 =?utf-8?B?M29UeEZOMkdxNGxLK3d5cGxwVTVVUDYrUVc0YUxxUDhscEJISFdhUFgvYVI2?=
 =?utf-8?B?ZHFWQ1V1c1E5NFl0bk9JZ3RYc3dkTXZCcHRDbnV3VHl0bTI0SFl5U1RaVzhM?=
 =?utf-8?B?eUk2MGFZK3YwUkFxckhxUFdmRFJHM1hXTlpKZUEwNEtKYmRiMXJTRUl2SWNY?=
 =?utf-8?B?cDVNRkVxNmRxMVB4Vmo4VGV0UDQrTnpydVV2ZFBNM28xL3k4NWh0cFRXeENJ?=
 =?utf-8?B?Z3p1c0VmbGYxWmJBWGdncjlxL01yNUozUGxjNG1SL1VVRzZPTllReEJyQlla?=
 =?utf-8?B?T2hRRU9yejM2NTNHVFBkS1BIWWNzWnFzS3NtWDNVNXFMQTFxa1JBTlU0Sk13?=
 =?utf-8?B?Y3RwbmZ2YXdXcUl4bE5iSlhFT2FyTk1IeW1UYmxGUDgzK2c4WXJKQ0oxamQ2?=
 =?utf-8?B?MS9HeWFnaldtVFFTY1JlWDR1QWV5aGF2byt2YzZxQ2xtSTlLOVh6SGYzYlg5?=
 =?utf-8?B?NlFkNklkTVlvaGlSZWZ6OVMxTkptejNXNW1xT1N2aGQ5UGZMaTd1ekkxOGtI?=
 =?utf-8?B?akFiMG85MUoyTFJyN2QzTlF1QjUwSzhRSksrQWJEMEVKMlZiWmF0SHpka0Nm?=
 =?utf-8?B?NXI3cHZUZVdnM3ZpdFBXREZDOHhVdDZXQVVsNXhwdVVZYWwxeVkxVlJiYmNh?=
 =?utf-8?B?djAxU3huUWM0YkN1b3RDbzBNSmJGZFIvcmU1cHBnYmtmWkRJTGdJQkNXaSth?=
 =?utf-8?B?QVlwbHJZVUFrR2JUQWVJOXJoMmZWWDJkbjdPSUU2OS9kSXpzSW85UjVNTEN2?=
 =?utf-8?B?eEJhTi80c1FyeUlQK2V2Z2ZuTmlwR29ZaTh5SHI1YzVUdU1iSXVmcWpQTG5q?=
 =?utf-8?B?K0xFdnMvWVA3K1dPNW9WTXlJMUhmNVN2M0NoOUxYYW5CQWFVSEVYKzhScW1J?=
 =?utf-8?B?QnBCWWNVbVg1OUNhY3Ezdmx0Ky9yWW5EbXlGL2xTdWdDdW9GWXgrR090Vzhp?=
 =?utf-8?B?V3QwTVdsVzdtRlYzVG15Vlg3RW90TVFBQTJMVll2MDlFczQyUXMzQncrSVQ5?=
 =?utf-8?B?SUJZQUNhRytPcTR3cVlnbHpFU2EyT2FYUm1VMEhzUTBHbytNZi9Kb0ozZDVw?=
 =?utf-8?B?N0tmbmp5N2pubFFOMllwSEdxTzI2Ny9GdXg2ZW9GMTF3RGZEVyt5c1BPWHpz?=
 =?utf-8?B?OFJYbDBldSs2S2JybHBCdnU4bmd2eFpiVEd6cUR0Kzd5Y0FvN0dXLzZQR2hy?=
 =?utf-8?Q?2O1PyZlpP9KD5uMQz5wtoy7/G?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cfab9798-21a5-4760-f3fa-08dad29513db
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 05:38:16.9011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5MjHmfYR8kp9k9vPwPV2gtJIcZGqZMktuNLYwgMpnwUiYcVY6yhQVFuyOfQ1yVK6Vx5jvXFwo8bNbWu+rtLGQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5658
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 09:16:00PM -0800, Paul E. McKenney wrote:
> On Wed, Nov 30, 2022 at 12:49:24PM +0800, Feng Tang wrote:
> > On Tue, Nov 29, 2022 at 08:12:06PM -0800, Paul E. McKenney wrote:
> > > On Wed, Nov 30, 2022 at 09:38:00AM +0800, Feng Tang wrote:
> > > > On Tue, Nov 29, 2022 at 11:29:15AM -0800, Paul E. McKenney wrote:
> > > > [...]
> > > > > > > > IIUC, this will make TSC to watchdog HPET every 500 ms. We have got
> > > > > > > > report that the 500ms watchdog timer had big impact on some parallel
> > > > > > > > workload on big servers, that was another factor for us to seek
> > > > > > > > stopping the timer.
> > > > > > > 
> > > > > > > Another approach would be to slow it down.  Given the tighter bounds
> > > > > > > on skew, it could be done every (say) 10 seconds while allowing
> > > > > > > 2 milliseconds skew instead of the current 100 microseconds.
> > > > > > 
> > > > > > Yes, this can reduce the OS noise much. One problem is if we make it
> > > > > > a general interface, there is some clocksource whose warp time is
> > > > > > less than 10 seconds, like ACPI PM_TIMER (3-4 seconds), and I don't
> > > > > > know if other ARCHs have similar cases.
> > > > > 
> > > > > Maybe a simpler approach is for systems with such high sensitivity to
> > > > > OS noise to simply disable the clocksource watchdog.  ;-)
> > > > 
> > > > That's what the reported did, test with and without "tsc=reliable"
> > > > parameter :)
> > > > 
> > > > And AFAIK, many customers with big server farms hate to add more
> > > > cmdline parameters when we suggested so.
> > > 
> > > It can be surprisingly hard.  It is sometimes easier to patch the kernel
> > > to change the default. 
> > 
> > Indeed, sometimes we were askd to provide patch than cmdline parameters :)
> 
> Do any of them like CONFIG_BOOT_CONFIG_EMBED?  ;-)
> 
> > > Part of the problem is getting the right set
> > > of command-line parameters associated with the right versions of the
> > > kernel in the not-uncommon case where different portions of the server
> > > farm are running different versions of the kernel.
> > > 
> > > > > > > > Is this about the concern of possible TSC frequency calibration
> > > > > > > > issue, as the 40 ms per second drift between HPET and TSC? With 
> > > > > > > > b50db7095fe0 backported, we also have another patch to force TSC
> > > > > > > > calibration for those platforms which get the TSC freq directly
> > > > > > > > from CPUID or MSR and don't have such info in dmesg:
> > > > > > > >  "tsc: Refined TSC clocksource calibration: 2693.509 MHz" 
> > > > > > > > 
> > > > > > > > https://lore.kernel.org/lkml/20220509144110.9242-1-feng.tang@intel.com/
> > > > > > > > 
> > > > > > > > We did met tsc calibration issue due to some firmware issue, and
> > > > > > > > this can help to catch it. You can try it if you think it's relevant.
> > > > > > > 
> > > > > > > I am giving this a go, thank you!
> > > > > > 
> > > > > > Thanks for spending time testing it!
> > > > > 
> > > > > And here are the results from setting tsc_force_recalibrate to 1:
> > > > > 
> > > > > $ dmesg | grep -E 'calibrat|clocksource'
> > > > > [    5.272939] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> > > > > [   16.830644] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 76450417870 ns
> > > > > [   17.938020] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
> > > > > [   24.548583] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> > > > > [   49.762432] clocksource: Switched to clocksource tsc-early
> > > > > [   50.076769] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> > > > > [   55.615946] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
> > > > > [   55.640270] clocksource: Switched to clocksource tsc
> > > > > [   56.694371] tsc: Warning: TSC freq calibrated by CPUID/MSR differs from what is calibrated by HW timer, please check with vendor!!
> > > > > [   56.724550] tsc: Previous calibrated TSC freq:        1896.000 MHz
> > > > > [   56.737646] tsc: TSC freq recalibrated by [HPET]:     1975.000 MHz
> > > > 
> > > > Looks like there is really something wrong here. I assume the first
> > > > number '1896 MHz' is got from CPUID(0x15)'s math calculation.
> > > 
> > > How about this from earlier in that same console?
> > > 
> > > [    0.000000] efi: EFI v2.80 by American Megatrends
> > > [    0.000000] efi: ACPI=0x6f569000 ACPI 2.0=0x6f569014 TPMFinalLog=0x6f56b000 SMBIOS=0x753e1000 SMBIOS 3.0=0x753e0000 MEMATTR=0x62176018 ESRT=0x64bd1018 TPMEventLog=0x58737018
> > > [    0.000000] [Firmware Bug]: TPM Final Events table missing or invalid
> > > [    0.000000] SMBIOS 3.5.0 present.
> > > [    0.000000] DMI: Quanta Grand Teton 1F0TUBZ0007/Grand Teton MB, BIOS F0T_1A15 08/25/2022
> > > [    0.000000] tsc: Detected 1900.000 MHz processor
> > > [    0.000000] tsc: Detected 1896.000 MHz TSC
> > 
> > I'm still not sure, but it's likely from CPUID(0x15). I met cases
> > that even severs of same generations get their tsc frequence from
> > different sources.
> > 
> > I locally have debug patch to check it:
> > 
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index cafacb2e58cc..82ddb4b0529a 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -654,8 +654,11 @@ unsigned long native_calibrate_tsc(void)
> >  	 * frequency and is the most accurate one so far we have. This
> >  	 * is considered a known frequency.
> >  	 */
> > -	if (crystal_khz != 0)
> > +	if (crystal_khz != 0) {
> > +		printk("tsc: using CPUID[0x15] crystal_khz= %d kHz ebx=%d eax=%d\n",
> > +		crystal_khz, ebx_numerator, eax_denominator);
> >  		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> > +	}
> >  
> >  	/*
> >  	 * Some Intel SoCs like Skylake and Kabylake don't report the crystal
> > @@ -668,6 +671,7 @@ unsigned long native_calibrate_tsc(void)
> >  		cpuid(0x16, &eax_base_mhz, &ebx, &ecx, &edx);
> >  		crystal_khz = eax_base_mhz * 1000 *
> >  			eax_denominator / ebx_numerator;
> > +		printk("tsc: using CPUID[0x16] base_khz=%d kHz\n", crystal_khz);
> >  	}
> >  
> >  	if (crystal_khz == 0)
> 
> I will give this one a go, thank you!
> 
> > This remind me that maybe we can add a line in dmesg telling people
> > which exact soure that the TSC frequency comes from (CPUID, MSR or
> > calibration from HW timers like HPET/PM_TIMER).
> 
> Thus far, it seems that this information could be useful.
> 
> > > > I thinks 2 more things could be try:
> > > > 
> > > > * add "nohpet" to the cmdline, so the tsc_force_recalibrate should use
> > > >   ACPI PM_TIMER to do the calibration, say a third-party check.
> > > 
> > > OK, getting things teed up for TSC recalibration and nohpet.
> > > 
> > > > * If the system don't have auto-adjusted time setting like NTP, I
> > > >   guess the system time will have obvious drift comparing to a normal
> > > >   clock or a mobile phone time, as the deviation is about 4%, which
> > > >   is 2.4 minutes per hour.
> > > 
> > > No ntpd, but there is a chronyd.
> > > 
> > > I will let you know what happens with HPET disabled and TSC recalibration
> > > enabled.
> 
> And here you go:
> 
> [    0.000000] tsc: Detected 1900.000 MHz processor
> [    0.000000] tsc: Detected 1896.000 MHz TSC
> [    5.254788] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> [   25.669260] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
> [   32.182958] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> [   57.785756] clocksource: Switched to clocksource tsc-early
> [   58.106661] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [   63.578433] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
> [   63.602169] clocksource: Switched to clocksource tsc
> [   64.636612] tsc: Warning: TSC freq calibrated by CPUID/MSR differs from what is calibrated by HW timer, please check with vendor!!
> [   64.664615] tsc: Previous calibrated TSC freq:        1896.000 MHz
> [   64.677714] tsc: TSC freq recalibrated by [PM_TIMER]:         1975.000 MHz
 
Great! As both HPET and PM_TIMER get the same calibration 1975.000 MHz,
and it matches the 40ms drift per second you mentioned earlier, this
seems like the CPUID(0x15) gave the wrong frequence number.

Or unlikely, HPET and PM_TIMER are driven by the same circuit source,
which has deviation.

Either way, I think the HW/FW could have some problem.

Thanks,
Feng

> Same same, give or take, anyway.
> 
> 							Thanx, Paul
