Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A562F6413CC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 03:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbiLCCzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 21:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbiLCCzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 21:55:06 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E2EBB7E4
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 18:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670036105; x=1701572105;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=T+zIuyg2dUKUSn6KuVvaqh1iYNyilMlvSS2pOHJb8AE=;
  b=Dqs3twGUye7HhlcHwNIrs2530+g5FvX1cPL0iyjvUKC0nuAUokfq1Tk+
   W+fZfa51z38cktmddiw9xgW7mXpVTWkgxLlb+WEPDUhXvYXR+6aG44HNe
   A+mV7qmySN5iei1wx9qKUFOLliBTJzency9S6R0erFVjqCbficFab85gK
   CwnZDwGo7sdpzewPkN/PX9t6q99G9zJWdAcyQzgQtyEjmCe5U7REUcxOM
   tI/7UBJrl/IFA3kFMXBIRJSXHY7F5NK2K12QdtQsxyQclhjMucSeRQ0ZC
   L7OyymZb/lOLhyeOzCJsRveaU8+dfhLKsKoMPednJnjphi7Y6DVfZZL0N
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="343062335"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="343062335"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 18:55:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="974124821"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="974124821"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 02 Dec 2022 18:55:04 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 18:55:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 18:55:03 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 18:55:03 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 18:55:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnIjJMRnJfoWhzToSMByoKedPMLg7XMVLdJuHZWfcKRDVlqZrsh5xG3WXiHoczFswHOqZy7hTh7HosEiuGlRkuTt1agdWQa6cSIScFJDnVyFN5p428d9cpQslKijA9W63qzwcZ0WJmX88HzG0jFIPh/heXnTrO0z4XCIbF5LgUtV+WKelF9rhbQRI2g7tqbAtR3N4nompODSDxmQ92DzCXMpSxpYLzPSMeh1lOkVfeLgU2VlsY1v+VQB4iOMyJBigTZy95fEuEIRMVY8pSlFHYgIs/dHiWgGA2nCPBS6AyI8kdMlGJ7erzLvIgb+NzVd6MyIv7J/21XuZZ761JyXJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSh4eREHBD+H8b9K3ahfXp0f3lrc+/6Vo/7jzaZjfmY=;
 b=DSzex0dp15kFYQMpE/FlLaeywGrDjwWxbx0cgmgCFdP2wRJFit1pgm8E3nAzIvUelv522FPYibdCxoIGet/1rK8vTwT4rEUbiDmUMlfP5EXK210U22Spimk6kdDV21TfaZkuQxn/Vm/SmAoNMvJ3/HIWMkPdwop8kGBBv4vaBvx7bPAG4p2xXov0dMFnGB3/WQW6iEmZxFEEZpC4SH/TP72TbAgodyvUgpOaAyptczo95HnSFPkspOy7te1jtRPRV/cyk8cSuVzRd5NkssYKyU6qPhsiil5/oKau0fU7ZHx7ABAKPS0czkPP/NhPkaWJ9C1CL8TFj8dVyIh9v9scIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by MW4PR11MB6958.namprd11.prod.outlook.com (2603:10b6:303:229::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Sat, 3 Dec
 2022 02:54:55 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%6]) with mapi id 15.20.5880.008; Sat, 3 Dec 2022
 02:54:53 +0000
Date:   Sat, 3 Dec 2022 10:51:48 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <sboyd@kernel.org>,
        <corbet@lwn.net>, <Mark.Rutland@arm.com>, <maz@kernel.org>,
        <kernel-team@meta.com>, <ak@linux.intel.com>,
        <zhengjun.xing@intel.com>, Chris Mason <clm@meta.com>,
        John Stultz <jstultz@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH clocksource 1/3] clocksource: Reject bogus watchdog
 clocksource measurements
Message-ID: <Y4q5xObZ4JYIqZ6x@feng-clx>
References: <Y4bg1H/HLRLfucNO@feng-clx>
 <20221130051600.GL4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4brjD/xUDlzJ4v7@feng-clx>
 <20221130055024.GM4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4bxZCEAmPnALsRV@feng-clx>
 <20221201172405.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4lQdKaKh2P7eLBG@feng-clx>
 <20221202014428.GN4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4lc04C6KqYUG5lf@feng-clx>
 <20221202222402.GI4001@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221202222402.GI4001@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|MW4PR11MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a94705e-12fa-4ec6-0611-08dad4d9c0e5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d0WhM+Ng4TAyuPwlBGVITTaGTff7yK7Hmy64NROrOP70gwu5/ySTO1ui+fuMbBSHxtyVCdYWDEZYKnsiQOpoybTUqEoWgNcym+uyncwS7Muj7pYZb994pm4BZlXJNZHTAqgEMUGH/rHY8KzREVGOAZHJUn5YRkdqFgwUIx5Q30/JdUrnH0w4lUnlRYegtx7LcX4clEaxtDIjl/5e5szjdB+GBeB8xoEUdH+/LT6mQvY+YxkDzuQHBQq4qg4Hakma9GxjK3ApXvlhQ8wE9mtNEXZyW3euXplwj52bOIDqb8DDoXLYXcQWJMvC5D6yXxWSxPN//akaAzQcunLYktFcw42j83f//hMFG5nrvLTrgtUdIM2TFEBmoxiJ8bC6ib4uXtxDpMTHl/YqOfSzk/exV92ZZwy/UbDyOOhpBqI7kK/CApcfUfUAceaacd7EYZOKPlsRLyezbmBDOfUMSCdao9h4pYJPqzN+C6FVJMEPlxQBrxH2jRPwuTyihhk1qeWFJ4Hvrqj/75CgyyMXRJ5+nICMWsVGR3XBxv4f6GVXq1iJWQwIV6P0lRJsOYQZ+9JJh28oc5nYWaU3xqQ1DWFQobnPWOErZ33S/fgtsjm0z5b6bwCVvDq+tdO9hMpiVS4BWZVq4C0ZDTfoxA8tlnBPXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199015)(6512007)(26005)(6486002)(6506007)(66556008)(478600001)(6666004)(4326008)(66946007)(41300700001)(5660300002)(66476007)(186003)(8936002)(7416002)(44832011)(2906002)(8676002)(83380400001)(82960400001)(38100700002)(54906003)(6916009)(316002)(9686003)(33716001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWZOdzY5N2lBam4wMlBFZkExa1VrOVhmU1BpVCt2MGpNdndhUkVPMHgzb2I1?=
 =?utf-8?B?aWFCaHZOM0dHclBSeWlaUkhRRk1rZEVnbjB2T0gyT3VpcjBRZ3NIUldyaTJD?=
 =?utf-8?B?M0RVZTRBN2doSnVORGo4OEVjc0hraGFtTkI0cmN3M0dJcHBoRnk5dEtYT0Y5?=
 =?utf-8?B?ZkptaHkyYlJ0YkxmYzdQVnZ6UW1GVmVic3g4YzlZcmZpVkRQVkNoVHRMT05G?=
 =?utf-8?B?VDRjNkpqYVZVMkFuY0NxdEMwa1lQZTQyUllYd3B3dzJHbEltQXdFRkJaazhS?=
 =?utf-8?B?OVYrSTM4ZVVMUlFVVCtBc2RseHFHa3J0MzA0V3c4aHVoMm40dSttU0d6ekpM?=
 =?utf-8?B?eVdKTDZDVGNoZVdsUkFPMDY0TlRFWEtaWE5KbFZMRWJKSDRZM0JXTFg1dUFv?=
 =?utf-8?B?NGZtTXdwUCtzZVdMUGU1SkxlKzJWZjZ5SXp3SU5ERDV1N2xLa2lMbVpXVW9H?=
 =?utf-8?B?Ni9CdnU2bG1RNXJkdjhuZXZXQmd6cHUxYjVVNlhnajk4bDJsMmZDZDYwdG1S?=
 =?utf-8?B?aVRKYytnbU02YUJ2anV5KzQrVi9zZDBibWE1THNwdzVvWE1RSUhKTlUzRk5I?=
 =?utf-8?B?TC8vVjBnNVJVVGpiSUYzQ3RTZ0FuY1ZCS0VUK3pIMGJKckt5dXRPeWN4Wlgr?=
 =?utf-8?B?RkVBampvWE9lekVqQnpkeDc4c1FrMVJQQkY2MHhFNm5JM1lBdTcyeVYrcm1z?=
 =?utf-8?B?d3lWbXpEM3drSmkyUE1VcVFQRCtnZkhXQ21PTmowZEdSWjJqTm5nWnczQ0Nn?=
 =?utf-8?B?L285RWNwSWlMRmYxV2N1VjE5bHpnbUZZbm1Fc3hoSU1ZY2djaVAxdUZOeERQ?=
 =?utf-8?B?dXNRSkplS3ZIWWRPTFBKejdNR3pSKzFZeHRBbU1wYU9URnl4dWEzSDlrUVlj?=
 =?utf-8?B?dHFKQkM3cC90RDBFeWxFOHhEcnBvam11b3lQOGZFeHVqWXVWa003TDRNVlAy?=
 =?utf-8?B?TUVRNGRxWGpxQWZzNksxb0xDdjVwREVwWGJqTm9mUnhZYlFJMVNwVUdZNHJ2?=
 =?utf-8?B?eDROa0wzODZCSlRId0xibW9mRUxLa2psUVpXNXNyMzVGcUtXaXBYQkVJOTVv?=
 =?utf-8?B?K0Y2Ky9TTTZhcXQ1Z1dVakF3QzJBSEVrVFd2bDVzaVJpb3FKRWMxWGhYcEtT?=
 =?utf-8?B?bG9EcDlJOUtZcS9NaGtSZkZEUzRUWnVDZUVUKzhJV2V4ZnBtSFhjd3c3QllW?=
 =?utf-8?B?RHJUY2dvWEFPVlprSVpMUU8rbWxIZGVHMHB6Wk53SllVTjhuZUdmTzJ6SjJZ?=
 =?utf-8?B?UGhsUGdERXJUVjBxUnNLV0U0a3c5dTl3MmJyaVBWK2Zvc2QzU3QzMWk4aHNq?=
 =?utf-8?B?SnZiTW9UUGk0RmZha3ZhdXlPUGM1NG9xKyt6TXJuTnNNTnAwK3AzZlZoTERh?=
 =?utf-8?B?enFUWG9US3NNQTRmMXd6UmpjOGt2ckx6VU5PZS96QnFsNkF3Kzh1RXZwNGlC?=
 =?utf-8?B?UEIyOWxLeElTSHZYQW9GdU5jKzFlN2dDYk0xYXFhWUxJTWxyNElVWmx4NElW?=
 =?utf-8?B?cUVhdkJXN2lyWVlpbytzY3dvVzdpZE5zNW1tZnl6Q08vVVJZVEpVcjNJdUVr?=
 =?utf-8?B?N0ZyWUxWdXd3NFRSL2RBVDdXZ3RLNFM5dFhFSEFIWkNGZTJ0R0N2b2xHUmRx?=
 =?utf-8?B?c2ZWQytQTUY2akgxMy8rT0VPVm5KNWtzVFA0VlFodFlLVC80OUlFU0twWHpP?=
 =?utf-8?B?REZNS0dmdlBHbkxCQllKTXp0UUVQaVVqc3RZWHBVU3pyWUZuYjdXVEx0ZDFu?=
 =?utf-8?B?QkhOcGFIOWFjUEcvUWdJVklmbWRjcjcyNEtKR0hUYzVteERwaldmMjhjZzJR?=
 =?utf-8?B?ckJyVi9pR0p6QjNBbzB2K2lNVUEycjZObFgyQS8vMjJxNnM1N3l4VDJzVGlx?=
 =?utf-8?B?eDc0dkZYc2hWWmdLRWlEczRJc3RrS1lBQjZnNTJsZEhZYW1OYUUrNHFKd0Vu?=
 =?utf-8?B?QTBLajB5anNnS0Q3dzhkMm04UkhYS1k1QlRNWGkrOVYyTzc3aERURnlZV2Ji?=
 =?utf-8?B?aXpOSHYvNi9yNUVhZGhUTE1iS3RMZUY0L1VwVjVCK0ZIZE95dDlnOXFXbS94?=
 =?utf-8?B?T0VCUHpucmkweTJqS04ycTlwL2V1RDYweGwvWjJhd1dvSW5oM2tWUFlORzFs?=
 =?utf-8?Q?WDXvC7vUoudYM9mJQacKUTqh7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a94705e-12fa-4ec6-0611-08dad4d9c0e5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2022 02:54:53.7135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgdMYENCDJC7owjeBb9TT0ArGQuGkvA4gSL7wkJCRIlfx36bdv1nq/D5oGEHHqE/LPsWao8wkui5h3dkJtW+6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6958
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

On Fri, Dec 02, 2022 at 02:24:02PM -0800, Paul E. McKenney wrote:
[...]
> > > > > > > (My next step involves a pillow, but will follow up tomorrow morning
> > > > > > > Pacific Time.)
> > > > > >  
> > > > > > Really thanks for checking this through late night!
> > > > > 
> > > > > No problem, and I guess it is instead the day after tomorrow, but
> > > > > I thought you might be interested in chronyd's opinion:
> > > > > 
> > > > > [root@rtptest1029.snc8 ~]# cat /var/lib/chrony/drift
> > > > >         40001.074911             0.002098
> > > > > 
> > > > > In contrast, on my Fedora laptop:
> > > > > 
> > > > > $ sudo cat /var/lib/chrony/drift
> > > > >             2.074313             0.186606
> > > > > 
> > > > > I am (perhaps incorrectly) taking this to indicate that TSC is in fact
> > > > > drifting with respect to standard time.
> > > >  
> > > > This info is very useful! It further confirms the CPUID(0x15) gave
> > > > the wrong frequency info. 
> > > 
> > > So the TSC is just doing what it is told.  ;-)
> > > 
> > > This indicates a firmware problem?
> > > 
> > > > Also I don't think TSC itself is drifting, and the drift some from
> > > > the wrong match calculation(1896 MHz), if we give it the correct
> > > > number (likely 1975 MHz here), there shouldn't be big chrony drift
> > > > like your Fedora laptop.
> > > 
> > > Resetting so that the clocksource watchdog once again gets rid of TSC,
> > > but leaving nohpet:
> > > 
> > > [    0.000000] tsc: using CPUID[0x15] crystal_khz= 24000 kHz ebx=158 eax=2
> > > [    0.000000] tsc: Detected 1900.000 MHz processor
> > > [    0.000000] tsc: Detected 1896.000 MHz TSC
> > > [    5.287750] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> > > [   17.963947] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
> > > [   19.996287] clocksource: timekeeping watchdog on CPU3: Marking clocksource 'tsc-early' as unstable because the skew is too large:
> > > [   20.040287] clocksource:                       'refined-jiffies' wd_nsec: 503923392 wd_now: fffb73f8 wd_last: fffb7200 mask: ffffffff
> > > [   20.067286] clocksource:                       'tsc-early' cs_nsec: 588021368 cs_now: 581c1eb378 cs_last: 57d9aad9e8 mask: ffffffffffffffff
> > >  [   20.096286] clocksource:                       No current clocksource.
> > >  [   20.111286] tsc: Marking TSC unstable due to clocksource watchdog
> > >  [   24.582541] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> > >  [   49.739301] clocksource: Switched to clocksource refined-jiffies
> > >  [   50.046356] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> > >  [   50.066475] clocksource: Switched to clocksource acpi_pm
> > > 
> > > # cat /var/lib/chrony/drift 
> > >             1.372570             0.020049
> > > 
> > > I interpret this to mean that acpi_pm (and thus from prior observations,
> > > HPET as well) are counting at the correct rate.
> > 
> > Correct. And this is a good news! that 1975 MHz seems to be the right
> > number.
> > 
> > Could you try below patch, it should override the CPUID calculation
> > and forced to use HW timer calibrated number:
> > 
> > ---
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index a78e73da4a74..68a2fea4961d 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -1417,7 +1417,8 @@ static int __init init_tsc_clocksource(void)
> >  	 * When TSC frequency is known (retrieved via MSR or CPUID), we skip
> >  	 * the refined calibration and directly register it as a clocksource.
> >  	 */
> > -	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
> > +//	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
> > +	if (false) {
> >  		if (boot_cpu_has(X86_FEATURE_ART))
> >  			art_related_clocksource = &clocksource_tsc;
> >  		clocksource_register_khz(&clocksource_tsc, tsc_khz);
> > ---
> > 
> > And together with b50db7095fe0 "x86/tsc: Disable clocksource watchdog
> > for TSC on qualified platorms". I assume this will tell TSC to use
> > 1975 MHZ as its frequency.
> 
> This did not change things,

Maybe the kernel is with the tsc reclibrate patch? it will not use
the reclibrated frequency for a KNOWN_FREQ case, but just print
out the info. Anyway this doesn't matter, as it's just for debug,
and your way already proved the 1975 MHz is the right number :)

> but when I hardcoded tsc_khz to 1975, the
> clocksource watchdog no longer disables TSC and chrony shows drifts of
> less than 2.0.  (As opposed to about 40,000 without the hardcoding.)
> 
> So yes, forcing 1975 makes TSC work nicely.  Yay!  ;-)

Great to know it works and we have some workaround before a final
solution :)

Thanks,
Feng

> 							Thanx, Paul
