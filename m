Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5226C998E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 04:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjC0CZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 22:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjC0CZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 22:25:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD5146AB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 19:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679883932; x=1711419932;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NVuPkaOZQPC514dODfXdqYgMxpIvn3MN+9NLkExXLiI=;
  b=DgLnKNclZETo1hknlhw0sI9p6EqGi1v69O6MWn1ojlmZNd1dCxbdi4Ep
   G0VMyGjpdHedxIYMPNo09vvNgaREhw2P+Zhh9ofXUX8UUZOdM7OEm0C4X
   /Ss6kPQDDpMw80mxXQtfPapVHNVFWrmy0JlBguQiASmtckSodX3aFLvww
   EnELZeYE6xQh3tGUq/rJVWY+RutoQZksqLHQDE4zUDG4kYvVUP6vikxfe
   DuLnfv5cx29CC3zO0RAPjjgCLfvaxS4X+mzDBtsuR0Qj0vd6yFLffgxzR
   93Yfo4E0ankmZlixYuHcBP3GCxT2+NS/qrLdqA26aefRL8O4efhii15vm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="320563564"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="320563564"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 19:25:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="683296708"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="683296708"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 26 Mar 2023 19:25:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 26 Mar 2023 19:25:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 26 Mar 2023 19:25:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 26 Mar 2023 19:25:31 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 26 Mar 2023 19:25:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ID+/Y+ME0PD34vWBlORlpqyWp/kPEg5PSHxOODtkNKML9/uVFk2PKarNcH3ZxNfZvzssH9ndHhr6T/HdBbglORjuj+PXnfK6oVu+IkyWWfGnUkctVk4aFiOP+N447MKHHIx4UyBqoV5ulkCmDArBTUb5cLszLu2S+x3qNKbcNqcRpgQkN352NBjJwP3N31TtB2XD+WfFg9OIt8cxlJ+7iDVIOU7J8gMPWARGjAnkp63dBZ7+Ca/ooBwNSvWfRiHdIefW0UWlDBpaExq8JH6g4flne1Ss+IqX7qRRRK3+u2iCqkGCWKfpH7rxaIaxXgPlB+VusySii8IM2jhuAfuPlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmjb7BIzlDj4ZTr9n312TPv1GKK8XnjH+gpT9p8KdeA=;
 b=ZQxNnT4qp+c7WK9fwqYlbrHFVPSXqYN4Jyw24TP4irsnJYmSKxw/vHjvDmDoV6qQ0cYB9mcGHqmyZNdVMaIXKvR+BUxpvUdsNEBKi6RrLODXAFbtB1ZZS5QUXWwtlhI5sQGvllh6RC43eRShTM5DADN4ahXdWqBTiMQg01P9NiNoj41MX/ytAni5XFt8kL5h4y43EPbs9K14g1xBsSzKfw/bDUBQb7eTlZpY3pquOhxFrGFIJ+dWvLAj54zo3rmepS5OW4D8qt29dR7OZWNi/9UU0+K/rUqiDtBxUWxMbgyQB9rC8TyTaWroB2M2B2VU/A5jgNGq2ov6nR57FgyOQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by MW4PR11MB6861.namprd11.prod.outlook.com (2603:10b6:303:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Mon, 27 Mar
 2023 02:25:28 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::cb54:c0ca:5914:4242]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::cb54:c0ca:5914:4242%9]) with mapi id 15.20.6178.038; Mon, 27 Mar 2023
 02:25:28 +0000
Date:   Mon, 27 Mar 2023 10:19:54 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: A couple of TSC questions
Message-ID: <ZCD9SnZSUCkE9Ss+@feng-clx>
References: <b2f07f18-b60b-403b-90ff-937ea32963ee@paulmck-laptop>
 <ZBqOyLByOgvdAve3@feng-clx>
 <acda3fb5-373a-48b1-b78e-eea18da4ccb0@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <acda3fb5-373a-48b1-b78e-eea18da4ccb0@paulmck-laptop>
X-ClientProxiedBy: SG2P153CA0030.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::17)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|MW4PR11MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d6dd0e-8ac3-4b9c-2b1e-08db2e6a8772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NyOusL380yhUfc7QorkjuIrwyKKRaeASz1skeBTPvIK8Lj6q2pXj10rdOMC+pEn5E+cRxTY8aZCnIBo0j/wwk1W2CnJOt90VW/DLCQWJC29ZCgT3ZD3APT/NWARDrevOShkklhTi779mhI5FlZH6FoRlNTULzuUwKJeldEBvIhUgGyb/Z2zgqJKpiNuU/m19tv756rfWFPXCthIX/Y+u4pyMkEc21GPlUxGfPl9i9mqvKV2/KbjsYzcLpwuh/7VhUu45YrsBlWF2SAmpfnIMJ0x+2I7j7wLC62JId7SDKqs57XNy3J9aYPeF8ysjrPivxsDy6Wh/EX3H3Jwf6vqM/q2lX9tXauxw1L0Sjs79TIJ5oGkl7Ecz9jKEYKu5sVS2M6NiCYKpg+iwbk0mWaOpjfwGET3ZLwLtkDxf9dE9Q7dCh+573gVZoMUhuRBUn4qyDVM6QKz3cLjXjaHc2+AOifWy/LXgP2QQ5Bnqea+pt1GOjqNmNAbwnA4swD8/UDfNETf10golLWRARceD5586BK62ILgYfF+oamd7gNoAAZ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199021)(83380400001)(4326008)(66476007)(66946007)(66556008)(6916009)(8676002)(966005)(54906003)(6486002)(478600001)(9686003)(6512007)(6506007)(26005)(186003)(316002)(6666004)(2906002)(44832011)(33716001)(86362001)(41300700001)(38100700002)(5660300002)(8936002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FlUg5bzIdKa1vW92Hx1YQef8Dg9lANUY6cTDyBLSrzplFHpUzRWAGO0UN54K?=
 =?us-ascii?Q?5GfQ6slMYCoRUPpxQxXQZyvdyOAcWcqxTYD3qmVSAZKEJlxP5EppWD+qxe+o?=
 =?us-ascii?Q?d4qOGS2POg4pQf5qUEK458zUZ00clTh6N/4lDGwWVJH6qUCKLsoAaDpYMhwo?=
 =?us-ascii?Q?jnh+ZfvJFHMuUE9O1lDtazi6vFeICj/rAooMtQNeRyu81b7F3S/R8DwN3QRj?=
 =?us-ascii?Q?PWRAm5JY9JvrPYdTGoHvxRz95sBZ28oieprxsNtFWuwMa/fsrLAgkh9YcKCa?=
 =?us-ascii?Q?8FNl8kEGd2NBJRWJSVOGjJMgPqx4E1PrtYRFvGDiwVfCfWPstypNK0VHgIsL?=
 =?us-ascii?Q?KhgFx4MdWhPrX0eeXccmftjoi4jk3/3MqVUp42mib5TSAUQMjV3w0xZqgigX?=
 =?us-ascii?Q?kkGts2WRI391frdzOFwXS5xs6k/0MdeipO9LThCYyBjTJ0ElDio6DZR5RAb/?=
 =?us-ascii?Q?QS3iPPplMyYS5FV5p++1nKDK8tgqZ+GvcD6bT/lOodgOmcq9b+3CGRQXImzb?=
 =?us-ascii?Q?ocqEk56M++yx5rIedd//xImszgWNq1gtHHwOScnXEKpj448k9dEpib+Ak+4+?=
 =?us-ascii?Q?Idf9gimreXkevAFK7ucn/RLVj375VUS8NKBJkTgCM8rKgrPujBCR8CeiU0p0?=
 =?us-ascii?Q?lh9ItugamB5B6PyFxs74dxDFA19Tn7/txp+3sCwBZ+Xn3N+mvalSLTZj1GL0?=
 =?us-ascii?Q?PniXJsXwyqBgOVp/u+aoQ84MFmIjtxVeQ2+HTG6Qg7bbz/gWJCrrlbZEzfxr?=
 =?us-ascii?Q?BcIl3AqgFkZz47Uj3TNqWMgWKVAeVJ5EHeew8G1+/Ogc61HlPbdGdgbCfl8u?=
 =?us-ascii?Q?rRVEOWBXxpme2WzHeFo+v3eStiWSSFoAiY5wuYPg14gtm6sT52FtMTRqTiue?=
 =?us-ascii?Q?PSExuWYX34mZ9dZ+uCJmesITSDLBSe1EzqStI2JNwzjMSuBPA/wOIiLbZVL1?=
 =?us-ascii?Q?xfAn0Q6+39AgWEajSqRkjz2IEv4PZVVOFcwMnaRQdOWkLdSE42w6/HJfjggg?=
 =?us-ascii?Q?+TNEF9V6t1wxdkGdrCmHEyKBnHFhfDbf9nSAxBGxi7Zx/sebtONYUJyxXgi3?=
 =?us-ascii?Q?7YA50ytTEq7f4pivxgaejYgzhkJoe9iICZ8IORuVLhOb8Ikb5qnelzCNjTBk?=
 =?us-ascii?Q?Sz6Ar18y/4glzzydczmZQhSUmSzGbcFwSRl0QdQiCLQgmcKzOHanzBfs8n8i?=
 =?us-ascii?Q?6r5Mvk0dFaC9Gi+5V/m8WoZ1mAuOBCvRMl8urtGTrV70ydu8iOa84xHdfR00?=
 =?us-ascii?Q?a4csnno3si0zx77Y278DG+PLT5vtfDsFtNUOPJFwKCnDQhnxF3+StagREVE/?=
 =?us-ascii?Q?bMH6rmsVevdCWf3RpDmx3bigHxtsHkJK6LUiZ6gjt1Gokd4IMrg3w57P9oog?=
 =?us-ascii?Q?ltxWUoRmGTRh1sbV6C8FnNKdA1BkJq7pj040a975Ey1tTQqR7zbR7WMOvSxN?=
 =?us-ascii?Q?6T2FISwdpTa6LPnOhq20s/5ZofcVlaaTPmqqEB04qHzipz+dKQ1FRvi4jmJz?=
 =?us-ascii?Q?siKUXJJkYQukaP4xYQPOlHpx/hOZAbhrLdldHMV8GZ+Lsep4Fs8GXavSf1PS?=
 =?us-ascii?Q?MhTHWc8cipezNDPITpErrrpHjC+XoyRU7P7nU608?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d6dd0e-8ac3-4b9c-2b1e-08db2e6a8772
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 02:25:27.8762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdePvyfnl/CzNyx2bZ3Z7OCt1NUGj4ffg9olSX3LzWCt3KE4zUBuPX2Olwj15TBXHzfAl9KmfLoQdlgkL6cK3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6861
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 05:47:33PM -0700, Paul E. McKenney wrote:
> On Wed, Mar 22, 2023 at 01:14:48PM +0800, Feng Tang wrote:
> > Hi, Paul
> > 
> > On Tue, Mar 21, 2023 at 04:23:28PM -0700, Paul E. McKenney wrote:
> > > Hello, Feng!
> > > 
> > > I hope that things are going well for you and yours!
> > 
> > Thanks!
> > 
> > > First, given that the kernel can now kick out HPET instea of TSC in
> > > response to clock skew, does it make sense to permit recalibration of
> > > the still used TSC against the marked-unstable HPET?
> > 
> > Yes, it makes sense to me. I don't know the detail of the case, if
> > the TSC frequency comes from CPUID info, a recalibration against a
> > third party HW timer like ACPI_PM should help here. 
> > 
> > A further thought is if there are really quite some case that the
> > CPUID-provided TSC frequency info is not accurate, then we may need
> > to enable the recalibration by default, and give a warning message
> > when detecting any mismatch. 
> 
> Now that you mention it, it is quite hard to choose correctly within
> the kernel.  To do it right seems to require that NTP information be
> pushed into the kernel.

Yes, we need a 'always-right' reference, but the system have to has
network access.

I know there have been many different problems related to TSC, but
the real HW/FW related problems are only about the accuracy of
TSC frequency's calibration/calculation.

Before commit b50db7095fe0 ("x86/tsc: Disable clocksource watchdog
for TSC on qualified platorms"), if the TSC freq is calculated
from CPUID or MSR, the HPET/ACPI_PM_TIMER can detect the possible
calculation problem during clocksource watchdog check. For this
case, we may need to force the recalibration by HPET/ACPI_PM_TIMER.

Thanks,
Feng

> 
> > > Second, we are very occasionally running into console messages like this:
> > > 
> > > Measured 2 cycles TSC warp between CPUs, turning off TSC clock.
> > > 
> > > This comes from check_tsc_sync_source() and indicates that one CPU's
> > > TSC read produced a later time than a later read from some other CPU.
> > > I am beginning to suspect that these can be caused by unscheduled delays
> > > in the TSC synchronization code, but figured I should ask you if you have
> > > ever seen these.  And of course, if so, what the usual causes might be.
> > 
> > I haven't seen this error myself or got similar reports. Usually it
> > should be easy to detect once happened, as falling back to HPET
> > will trigger obvious performance degradation.
> 
> And that is exactly what happened.  ;-)
> 
> > Could you give more detail about when and how it happens, and the
> > HW info like how many sockets the platform has. 
> 
> We are in early days, so I am checking for other experiences.
> 
> > CC Thomas, Waiman, as they discussed simliar case here:
> > https://lore.kernel.org/lkml/87h76ew3sb.ffs@tglx/T/#md4d0a88fb708391654e78312ffa75b481690699f
> 
> Fun!  ;-)
> 
> 							Thanx, Paul
