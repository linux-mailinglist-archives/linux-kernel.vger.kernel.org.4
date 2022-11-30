Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E26763CE7C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 05:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiK3Eww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 23:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiK3Ewo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 23:52:44 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B45262DA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 20:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669783961; x=1701319961;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=3749ax9ppohGjGjFp7a1GCRqgWIp71oDYMvi23ItfcU=;
  b=KojO4/4dSxJEI89lTcCXakoesIKtCr1U3GSaml0CCTfj+D06JilNsYTr
   2agxbx/srObjvylMdW5XgP4kNEM+ipYuf2axKOUO1/KvzsmOPIhB8vSJm
   EejfDVHG5gx2zIkkl1gAO5cTuZc2+B6/YjxvWRoPC6BOimRru8ZdNXheC
   B9JEtfwVr/tLDfVro5A6Zoe6paPge9z7EK+WBC5QhjyKIpFPRnB+ccbNe
   FJthqdaZYsq6g2hK0y4NFpvS/zYeNWMc0emhV8pKfr09o/zp2tVU/EHad
   PfIhm0I7ItTV35YbgM5XFGwKyO6nQ2AYolg+sigZj1+fhIiHYmx9xWvy+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="317155210"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="317155210"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 20:52:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="621740730"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="621740730"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 29 Nov 2022 20:52:38 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 20:52:38 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 20:52:37 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 29 Nov 2022 20:52:37 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 29 Nov 2022 20:52:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQkAYQit21V6/5Fk4SE9JhYE1Iq960uXshR8dzDGk/x1yHtCFedjyQsfSiaa1Hv580NOuKsjlKzHooMe6qHX03AXjtVTd3h+uGsAejq7F9p3IWLB3rPmMYuwb5A5kSdW+RlLKB0phi0WKRH7XRVn91lVomnUxeOrAtx4XesFPOr9YQ2I7W93a7IBX1BnznOQ0LqoWoM1/bfmmdtxf58PSRLPsHB0oft/Lzjc2HBEd8TGoaz6TunsDt3R9TMtiUgn+znLug0Yq4vb8B2WP8w9eOFs5IOpdbOKKMGnJ+IrumWnnRkK/UCJg8i7juW+0j8FLhSP9YUaWLDBP8ONpAt/Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNnoR/uPHIy4YVAPn4R7G4uKae6bRpWCnu/bWXnaxB4=;
 b=EHjbMaHm0Fbadj51Czxh5eLGKGQu9Tfz/gsBv4+F4EFMRQ9C6otMqLc6vWZb/nvClAK3QUWMhZ+jfHANFMOCnPqXCqdYbdflifeNNhTXsYEIbl672g22cGHaQGDglN5LnX6goIuLSBce0POwOncgW3TbMReeZBVRlyvPe7LOpeyXyVCA5bmSZSKx3ZBOey4ZR3zKFdXbHH8uVce+aVEQ+Cts55du+mL4A8WIHEwV3Xyq1BTTBLiBIDBh06NigZUBcdAfSaXcSqnJ2cA6xQ4vxwe4T3BU//HUPN98m2Ei4cyBgV6fgzZMBiuFehzXf4pRfjGPbt8XCFFnuNjjQAg2eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by IA1PR11MB6121.namprd11.prod.outlook.com (2603:10b6:208:3ef::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 04:52:31 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%6]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 04:52:31 +0000
Date:   Wed, 30 Nov 2022 12:49:24 +0800
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
Message-ID: <Y4bg1H/HLRLfucNO@feng-clx>
References: <Y3rMc2VbgVLHN9db@feng-clx>
 <20221121181449.GA3774542@paulmck-ThinkPad-P17-Gen-1>
 <Y3zxB6r1kin8pSH1@feng-clx>
 <20221122220712.GP4001@paulmck-ThinkPad-P17-Gen-1>
 <Y32HFE+BaATh9+l/@feng-clx>
 <20221123212348.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4QZzzk+FdGj4AXm@feng-clx>
 <20221129192915.GD4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4az+FT5YjpAWjZc@feng-clx>
 <20221130041206.GK4001@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221130041206.GK4001@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|IA1PR11MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: e1614405-e969-4b07-646c-08dad28eafba
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c7dOEwvyIALBefshXQrs8bRkSMybBgXrEc+wOrbK7pACMpGKnVClgqoVnu/buFWH5HLgIoNonWtFWvSMGSIeHP0SnxudZV8iXmzoevK3uHkd2qDJfvM0hINY7FjnClo7dWfPHPCZ4Ch2p7J1T62XJ4fsgfrjhs/f5L5BFruIzBSrdzsrOdUg0NnUI3Zm2lqPJBweuV2PfAjIaK3Fwr7kn7owJCW6ThzudAT+jU624UMm68gR3rjrSnWnQbHGj+lZCIfLN7uT0biu7OiBtzvZc+fdPSFqwKUi/e+LIjyfyFMt8OyoQmRzm1aXorOPPsY3a0rKaoCWx4c3wyuI84IsnSz396LVM2YkqcL6uEd4O0ZTs0XqwHOch1K9ze+ENrOEYJxF5Sbh3YiKFMrdL3xXpO4U7ElX5JItiYwij0Sv/TwtnxTc9YeFERO1LXmZY2FMWkSEmV0GXTi4i8L8HSFNAlJFdbEfrwxk3XPwHa6sI27mvrXvOxCFSiaffm5OHc3QAgzt15UXeRtr5cIXV7smCM/D1QeNBR3KPJJCdtYIk5a6hu5BrvYCk7NUg6RwnoJPHsKXhL3i92fRaJdBeiKKD3O+H39VpuyUC8w/8BPutdYadMAlMgrKdbPSQso3kYtu25/qis6qiwwypApIPrdi29319BiGvYRzaKKSvBrfOZg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199015)(83380400001)(2906002)(6486002)(966005)(41300700001)(33716001)(186003)(478600001)(6666004)(26005)(86362001)(6506007)(82960400001)(38100700002)(7416002)(44832011)(8676002)(4326008)(8936002)(54906003)(6916009)(9686003)(6512007)(5660300002)(66556008)(316002)(66476007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzdPUlQ0cXAyNHhheXhBL3duWWcvYzliVVViWm55TDdQM2pHdmdLUEVYUEJh?=
 =?utf-8?B?blpxQXEwTGIyTFFlMzM1QVhMRDZLeVBONVJrNmxIZ215WWNNYXN4eTFSSUg2?=
 =?utf-8?B?QjBjMVU3VWFLQ3NQdklHK0FnL2VJMnV1TG5lcElkbkZIeXMyNFovZjNNM0Nq?=
 =?utf-8?B?QmtIcWdVbmhPakxRYk9aSHRHTk85TjlyVC9XcDd4NURlbUFQY2dhcDZXSTFW?=
 =?utf-8?B?WkpMRHFMdjNkbWpHVlVLNnFpZjZTY3JWWXVZS3U2ZGFKdmF6ek9oc0h1RGhk?=
 =?utf-8?B?R09jeHNiRXdodkJEUCtscDBYREVFT1RTT3N6OFZZYi9nSitLY2YyUkdUTS9U?=
 =?utf-8?B?YW9zRGc3UjFPdk4xQ2VvMmlkRlpxekhxaVJLUzdpQmVwalZsdEZ4YjNLcU96?=
 =?utf-8?B?WkZKZnk5cVVnL3FsY0N3a2d2RTlTTi9UOXMrM3p0ZXg4cStSTWdqdlpOU2ZS?=
 =?utf-8?B?a1F4cWpJSlh5VnFqZXB1bFNmWDRaT1NvcGVBTzFQd0lDcFpZUjJWUmVCdmVE?=
 =?utf-8?B?UjZmN0FZWFVMYXJOaVV5MTJQMURSbzJ6ditkek1tYm82WHRzOW1nd2pDN0VC?=
 =?utf-8?B?ZFdaQktkUEhmZUtzUnQ0YUJ4NTFsNG9NczJJU2hMTUxmVHhyeHBzQU9MODZO?=
 =?utf-8?B?N3dHS0Q0aXRUUDFFdm5wVUlDZ2k2SnpYRk5KbEdZL2k4SzRwWDZEa1RRNmV6?=
 =?utf-8?B?QWgzVFN6LzQ0VTNPdnhXSnd0alVsVFY3S091Y3M3amZnb3JDTkNzYVMwa3hJ?=
 =?utf-8?B?OUg2b0Eybys5WXJMODJIQ1o5NHgwWEludmU1UDRJcWswa0U5N3M2QS9hcG9U?=
 =?utf-8?B?Z1ZuU0pOMy9qWXljckc1MmlZOTNDZFQrbFg5VWJtTnJDVHBuN2F2cUw3RElW?=
 =?utf-8?B?VzVRVDVGbG1xM2o5ZHJWekFZYWJkTG1rYVQyZlhsZVo0Q0E5eE1OQ0VkRThF?=
 =?utf-8?B?bWtDckZLcFg1aU5FWlNldVpDTThTcnhESlptMGlZeml1QjZ6bmZNVHpWZlNW?=
 =?utf-8?B?TUlLZEVWWDcwUi9kc0I1VGxBTEhqYXlucmQvTFE4T1dBb0lja2ttTDk0OHZk?=
 =?utf-8?B?VXhnRC9WckZEYndMdVpFdXVnNjlueVpHbXVoVzEwSC9vWEpJMFFkeVJVS3R5?=
 =?utf-8?B?aVQ3S2l3cjBsNDNldHR6d3NoZVBDMUg5c2tnUEtJbzVHK0pzYVA3M2E1UDIz?=
 =?utf-8?B?VVZ3cHc4V2tuV2dIaWI1cWxZNmZOU2FWRnM5OUgvS3JzRFRkZnBEamUyaDFD?=
 =?utf-8?B?Q1ZBWnlUTmNIaGNXdndsZXZRTVQxWDd4SUV4VjI5TEU5SDZQWmFGNWkzWGMw?=
 =?utf-8?B?YXp5SVJNYWMxUlVQdnR6a2FLbW9jUmhSNU45ZUY2TFB3Q1JYK3NxWTFqSzFq?=
 =?utf-8?B?RkZUZW1zYWNRVVZuV3M3alNxNExrUS8vN3lRL3FXYXlCeGxnaDJ6V2FMVFBB?=
 =?utf-8?B?T0NlMHhzOXBZUExoRkQ1NGZlNllWQndlWloyRjNUTlFoRC9saUROZlhQakNz?=
 =?utf-8?B?eDVFMWJ6MnBmaW5qanp2RFBMRk1RaDgxUzRNbEJkUjVzOG02MjJQbU5pazlC?=
 =?utf-8?B?aFN2N1UyY0w3bHVEQU5PdXo1WVkvdWd4bGVtdERkRk5zeFhBQjZkNitMdkJD?=
 =?utf-8?B?a3MxVmpILzdIN0hLQkVLbThUMFo4MXkzMnA5Rjd6M0F6SklHajVCazQwMWZi?=
 =?utf-8?B?bVczVVp6ck1kZlZoUnBaTGdLY1RhWUVtUDB3WS8xbGZDbytkQWxhcGh5RXZT?=
 =?utf-8?B?SmJpaEltZ2Zkb1IvRzRjMjJEU01GU0FKaFdmdU02MDc3NE9LL2RzMEdNUS9q?=
 =?utf-8?B?N200Y0xkWVFqckhtUWRYemd3dTY1RSs5VVNReDNsVnhKa3RZWjkwc3FTRi8x?=
 =?utf-8?B?Ym1nWkVZc09MbVdkRGpaaVFVUHVJbkFlRFU4TEZ0Z1hncHcrT3hmRUUwYTB6?=
 =?utf-8?B?cDc0RG4rRzU2d1U5cU9KYTR6WWV3cnRJY3Y1V2NOelRoMmxxTldpZUVYQ1lE?=
 =?utf-8?B?MmJ3UkoyUlA2cUxJNmtDZktVY1Y5K1BvbW00QWpwQS9ibWg2d0JhcDZUWGFT?=
 =?utf-8?B?MVpjeTRCOEk0V2cxenc1YlJZc2k0azhKRHBuZU02Skl4UTdBS290T0ZPdXlM?=
 =?utf-8?Q?9BrynK5C9Rcv5tIuFrnnA1kQR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1614405-e969-4b07-646c-08dad28eafba
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 04:52:31.4573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJrqEeXMxZk5dNFUWZCtErSbcM2pcS6DnBp8bRqga6aMa0vldxUmUnmuysZVU/zfTViCUL8bvEn1NbnUo6j5Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6121
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 08:12:06PM -0800, Paul E. McKenney wrote:
> On Wed, Nov 30, 2022 at 09:38:00AM +0800, Feng Tang wrote:
> > On Tue, Nov 29, 2022 at 11:29:15AM -0800, Paul E. McKenney wrote:
> > [...]
> > > > > > IIUC, this will make TSC to watchdog HPET every 500 ms. We have got
> > > > > > report that the 500ms watchdog timer had big impact on some parallel
> > > > > > workload on big servers, that was another factor for us to seek
> > > > > > stopping the timer.
> > > > > 
> > > > > Another approach would be to slow it down.  Given the tighter bounds
> > > > > on skew, it could be done every (say) 10 seconds while allowing
> > > > > 2 milliseconds skew instead of the current 100 microseconds.
> > > > 
> > > > Yes, this can reduce the OS noise much. One problem is if we make it
> > > > a general interface, there is some clocksource whose warp time is
> > > > less than 10 seconds, like ACPI PM_TIMER (3-4 seconds), and I don't
> > > > know if other ARCHs have similar cases.
> > > 
> > > Maybe a simpler approach is for systems with such high sensitivity to
> > > OS noise to simply disable the clocksource watchdog.  ;-)
> > 
> > That's what the reported did, test with and without "tsc=reliable"
> > parameter :)
> > 
> > And AFAIK, many customers with big server farms hate to add more
> > cmdline parameters when we suggested so.
> 
> It can be surprisingly hard.  It is sometimes easier to patch the kernel
> to change the default. 

Indeed, sometimes we were askd to provide patch than cmdline parameters :)

> Part of the problem is getting the right set
> of command-line parameters associated with the right versions of the
> kernel in the not-uncommon case where different portions of the server
> farm are running different versions of the kernel.
> 
> > > > > > Is this about the concern of possible TSC frequency calibration
> > > > > > issue, as the 40 ms per second drift between HPET and TSC? With 
> > > > > > b50db7095fe0 backported, we also have another patch to force TSC
> > > > > > calibration for those platforms which get the TSC freq directly
> > > > > > from CPUID or MSR and don't have such info in dmesg:
> > > > > >  "tsc: Refined TSC clocksource calibration: 2693.509 MHz" 
> > > > > > 
> > > > > > https://lore.kernel.org/lkml/20220509144110.9242-1-feng.tang@intel.com/
> > > > > > 
> > > > > > We did met tsc calibration issue due to some firmware issue, and
> > > > > > this can help to catch it. You can try it if you think it's relevant.
> > > > > 
> > > > > I am giving this a go, thank you!
> > > > 
> > > > Thanks for spending time testing it!
> > > 
> > > And here are the results from setting tsc_force_recalibrate to 1:
> > > 
> > > $ dmesg | grep -E 'calibrat|clocksource'
> > > [    5.272939] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> > > [   16.830644] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 76450417870 ns
> > > [   17.938020] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
> > > [   24.548583] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> > > [   49.762432] clocksource: Switched to clocksource tsc-early
> > > [   50.076769] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> > > [   55.615946] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
> > > [   55.640270] clocksource: Switched to clocksource tsc
> > > [   56.694371] tsc: Warning: TSC freq calibrated by CPUID/MSR differs from what is calibrated by HW timer, please check with vendor!!
> > > [   56.724550] tsc: Previous calibrated TSC freq:        1896.000 MHz
> > > [   56.737646] tsc: TSC freq recalibrated by [HPET]:     1975.000 MHz
> > 
> > Looks like there is really something wrong here. I assume the first
> > number '1896 MHz' is got from CPUID(0x15)'s math calculation.
> 
> How about this from earlier in that same console?
> 
> [    0.000000] efi: EFI v2.80 by American Megatrends
> [    0.000000] efi: ACPI=0x6f569000 ACPI 2.0=0x6f569014 TPMFinalLog=0x6f56b000 SMBIOS=0x753e1000 SMBIOS 3.0=0x753e0000 MEMATTR=0x62176018 ESRT=0x64bd1018 TPMEventLog=0x58737018
> [    0.000000] [Firmware Bug]: TPM Final Events table missing or invalid
> [    0.000000] SMBIOS 3.5.0 present.
> [    0.000000] DMI: Quanta Grand Teton 1F0TUBZ0007/Grand Teton MB, BIOS F0T_1A15 08/25/2022
> [    0.000000] tsc: Detected 1900.000 MHz processor
> [    0.000000] tsc: Detected 1896.000 MHz TSC

I'm still not sure, but it's likely from CPUID(0x15). I met cases
that even severs of same generations get their tsc frequence from
different sources.

I locally have debug patch to check it:

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index cafacb2e58cc..82ddb4b0529a 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -654,8 +654,11 @@ unsigned long native_calibrate_tsc(void)
 	 * frequency and is the most accurate one so far we have. This
 	 * is considered a known frequency.
 	 */
-	if (crystal_khz != 0)
+	if (crystal_khz != 0) {
+		printk("tsc: using CPUID[0x15] crystal_khz= %d kHz ebx=%d eax=%d\n",
+		crystal_khz, ebx_numerator, eax_denominator);
 		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+	}
 
 	/*
 	 * Some Intel SoCs like Skylake and Kabylake don't report the crystal
@@ -668,6 +671,7 @@ unsigned long native_calibrate_tsc(void)
 		cpuid(0x16, &eax_base_mhz, &ebx, &ecx, &edx);
 		crystal_khz = eax_base_mhz * 1000 *
 			eax_denominator / ebx_numerator;
+		printk("tsc: using CPUID[0x16] base_khz=%d kHz\n", crystal_khz);
 	}
 
 	if (crystal_khz == 0)

This remind me that maybe we can add a line in dmesg telling people
which exact soure that the TSC frequency comes from (CPUID, MSR or
calibration from HW timers like HPET/PM_TIMER).

> > I thinks 2 more things could be try:
> > 
> > * add "nohpet" to the cmdline, so the tsc_force_recalibrate should use
> >   ACPI PM_TIMER to do the calibration, say a third-party check.
> 
> OK, getting things teed up for TSC recalibration and nohpet.
> 
> > * If the system don't have auto-adjusted time setting like NTP, I
> >   guess the system time will have obvious drift comparing to a normal
> >   clock or a mobile phone time, as the deviation is about 4%, which
> >   is 2.4 minutes per hour.
> 
> No ntpd, but there is a chronyd.
> 
> I will let you know what happens with HPET disabled and TSC recalibration
> enabled.

Thanks!

- Feng

> 							Thanx, Paul
