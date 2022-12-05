Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDB2642D5B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiLEQpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiLEQoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:44:44 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3D4117C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670258540; x=1701794540;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OhCcq9XTS13VFlkXeKwlBLoWQjTKY4/Mgf0d/rIbgg4=;
  b=A4Wudxwpkiy8l3DrF1l5t8VAQmkfn51KIt9U91qjGCG/gKH1NOgbQ2nv
   bhuo5zoKZuZRefhrhmnLN0mqzznDG5eiAy7Hh0Act25lF2500XtN2AqqI
   K+mYGD3yoqiXRJBQRiVguzh3QZoK9Agq2YEYPYgqoLyh8F4lG90bJHPJX
   syS8guV7ylOD+cSJfKKwIFuAyp1QQ4/GmErdQ5Od+eI9+QliefLgZYTfl
   hDPVqpkVYTHwaVhxnxbuBM54mfv5/EbwVeD8V/u2/ftVAqJeKQtmARuTP
   OMWB/O6cReSnukT98ab6gNRtAKksbyQpvj1/YxtpOXFSGO7+VgtipwnQ5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="343390002"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="343390002"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 08:42:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="596256860"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="596256860"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 05 Dec 2022 08:42:20 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 08:42:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 08:42:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 5 Dec 2022 08:42:19 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 5 Dec 2022 08:42:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I27YyDhLX7rQqRLsARy0ExT++dBuEncTp+24ltr/e34+vC6oSqB1D7NtS7viSCgkORLFBRm6+c66Dbf9iD6elWGijqZ1ScfkWpOJ5jbwcmrNgqvyY6q9GblFFanb00aSQCmqUVyGuC4A9DwTgfHs3t1vvmY77PRvtM0+0OaS/7AwOEXLUMa7LZkQyZIcIjAZPNinKrofkR1/WaJjJwaG1BQAVK4YtYxIYaKcKuctXQoZqxVj6ypXX3lkJPJwJW219SgiqKeF3gQBkQ7aGHh4x1Tea9sVIjVei2XvGt15zgHbYDUjjoGlX/JTOCt/rrpGkFvJ6vxEX1OXeQO8GALehQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkI9AsKo5wGL4ZoHcjYyGH4cSJfqEbYbmkt7I2Ecpws=;
 b=eOB8RTI2LpNW7qiBs09SbhYkQB5VstowiSITCrEVMyVNymILZhSpvnbR7bl0UzhVLqRLFFfTZa0r8lyvEN6ckXFMy+cqrviTLOE745nWHL3H6n0lTQmSnFg8w4JmzfylB++SvbrYSXmyADZMIMN2GAXJMsivHwEwxgPC1Gwr4uoCKDy/VgEfAw08CT83+De/IRxYuZgbCgFoFbB1ytkAjo+FYX+eSnWquG6kj8nFJMveC7vZJD1bxV+5zEyvMrkf3FuBqdwy1YLj/TsHPdkGYPraP21yU6XirB9DXjOAjjtH3U9sP7S+9Y9BgsF65/YziM6Kg+iNz3rTWd31pzs+uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DM8PR11MB5669.namprd11.prod.outlook.com (2603:10b6:8:36::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 16:42:16 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad%3]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 16:42:16 +0000
Date:   Mon, 5 Dec 2022 08:42:10 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>, <alison.schofield@intel.com>,
        <reinette.chatre@intel.com>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [Patch V1 2/7] x86/microcode/intel: Remove retries on early
 microcode load
Message-ID: <Y44fYl4oV5HmtjJM@a4bf019067fa.jf.intel.com>
References: <20221129210832.107850-1-ashok.raj@intel.com>
 <20221129210832.107850-3-ashok.raj@intel.com>
 <Y43hstW6oL4naReu@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y43hstW6oL4naReu@zn.tnic>
X-ClientProxiedBy: SJ0PR13CA0197.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::22) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|DM8PR11MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de1ddb7-d593-4af8-d4b3-08dad6dfaa45
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Av6tOJaLrkGQ2Wk0qxqQqhb7aII2BJdq43jgLfcJam6iXrP2N1qGdVdqhX1iwNXngJgyS5Ww5jS30OMlTc2gLLVS6UGPucajuZ1uyHIimX0qcoIt98vpDFoV5XfAHjtfi9UskWbOYdSpWMUM1jfiSc/vIV6kYJ/Zu3PLlr/myj7DpWZzsF0YaJR0KZURnG8RaCbczZGJtgp3n3WaHORQIKF6/GIDFL/KNPO2n83GkWy/KJqI6GK/f094Rabk0Z+JW7AVF6rvaSVsdQQntSWBqo0cdoKDQPXpcLNE6aojKRh/bMhqpiLb1YNPKzwY5vpm/ue3efkp/1DKPG7UaM8Px6NgnXvgKKDka8tByFFZUthttwE8hhtLaiZF37n4UNi/jGazOdpOH2sPtmF2XfUCqHYS6EDAPauyBcRNUwQsuoqCtI7u6WTXW8vXBkqNTquTPwlLCwjwNlBfhYxqLZ5FIgkgWfuFP4rd9vxp/YU4T9ngXpsN3bpHBVNufqzeAD3FwXKCxOQkVMl2zAH5HKO9RRQOG5g3EbKM0cmfjJa+9xCBMndP/iX/17aw/IkiihmTH60d/IvudSJHsJXG3Xbm4zEvAnIy2WOPZfJQfoPZAHia59tYEunzWh+5sg8vWeg5F51vZtoThzgpxxOfMMAkuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199015)(82960400001)(38100700002)(86362001)(2906002)(41300700001)(8936002)(4326008)(44832011)(4744005)(5660300002)(83380400001)(66946007)(478600001)(6486002)(66476007)(66556008)(316002)(54906003)(6916009)(8676002)(107886003)(6666004)(6506007)(26005)(186003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pnD9AtlAur0omelJQ6vA3zLcbfNi4piuUceZCZuLg791TCddM+6DcKAfmrPn?=
 =?us-ascii?Q?kncnr6rPVwqYI5A3P/eB0iFrzKpc3ZXO65Iefv4Oo/s/TgC3VYWu5IOuD/kk?=
 =?us-ascii?Q?o/ezsEJu3/Dh1vLg8a7+3sWZ7TPL4gXW7MpWufKXimkvBkGYzj+8Y1TZWbbI?=
 =?us-ascii?Q?WkuMapMwAPbYfyNzcVUv9Ou1d8SXUVeR2xfOHu9jwCazf6CFf59ZbGHZMCiz?=
 =?us-ascii?Q?KwRq/FMmYpb1KbyR6tKsGYVEPYCP73u/Cct+PDo8MzDwmGw5SxbzwXMlGUs9?=
 =?us-ascii?Q?7j7IQF93M/PcocnjU0eg99hflsMi63FTG9pqxv9ueiZ4jFl7omye5vzEOZEP?=
 =?us-ascii?Q?q0Fvq6VgERwGmjLfHOj2MKfzHm2i7PtkGpfGehIcTH+6cEf91TJsUjJn61of?=
 =?us-ascii?Q?11U+B9tOrbG4zqs90RNMmwecOqvJqWi+Glx5Yj3Y65hzDj3C4OHQqSztrgin?=
 =?us-ascii?Q?vGSypTVlcuT51Lxe0qBKF1XNvNZbK2nvuH+sYfgNUF53sFFWTpxlAkSpZw4j?=
 =?us-ascii?Q?2PQJMNgAKQQJS+B8/dXID5WZi9z/onjygFvgZgTAcSzpyvSRNC4/MsR6sqPZ?=
 =?us-ascii?Q?K2/r8c2WImZZmCdkuwPUqjrhZMw22KOb2jSeN7D6pA6hx+BG0cdHnvS6QXFU?=
 =?us-ascii?Q?L+HaTDBb/VOoJNUMeSaGzXwqn4azuXJjYEu0/ez7lWxIaIswERuSQWw7dovU?=
 =?us-ascii?Q?oxOEhhw/nHSPlPN5f+IBX9jfq/WKoKgArH4UDd7wtWd/thIit+FAaYVdh2Mr?=
 =?us-ascii?Q?mpr0xYE+kaQ4I9eg90fj3myTmJbL13qR1WA5AvDCtjwaOGxChBcY458wgZgi?=
 =?us-ascii?Q?kFl9l3qG+um+MLdXW7ilS7j/tm/sTYbIrU+gT6DK6h8e3p8FmGO5F33qQZA+?=
 =?us-ascii?Q?yo+a6RaU4EYXHTENdEnzpF7kj1UjOjZvDURGuAs8hZ9ISEIGO3OZrTGxSJe3?=
 =?us-ascii?Q?uyRYW98bF7M/SmcK1JO0Zgq0YbVFvT4cKbXo7pkqPw5ozhe7GecDDU3c0sJk?=
 =?us-ascii?Q?iyhuWAMAjwxzutaUW06Q2PKla4ZN39dt8jOemXxFXSki/2WCp3eO9QvXuZbE?=
 =?us-ascii?Q?pvdPEmuEGPfLlUEfabQF+mFqI5kht1UIwSNLJLmff7yOZ63wZESLFAr9r1Hl?=
 =?us-ascii?Q?aOmQcx+LfErDWF0XVfiGocvcDTsQJggy/GXQQuGiogdk3c+rXdpyszvnpeYa?=
 =?us-ascii?Q?olbFItRShVI6BI+ucsLBjZNB5AyAyEXZVAHlIaw549hrg57mTZGLtUnT4A4x?=
 =?us-ascii?Q?9kiEhVlVAcGf6sMmRMh0lxvjz61e99xiM7CfKqWAKNUHDcCrF+vqIq9AT6Bj?=
 =?us-ascii?Q?J1HxMvGnhFskP9tbefGsbYXI2q1Ixp413izjUWu0lme7z7h3VpYlyb6T/0kf?=
 =?us-ascii?Q?BKQ+mi9vX3t/hlrkNiITFzwvGoQATo0vndVYBvpOZL7eqmhoC5HEq0UoR0RZ?=
 =?us-ascii?Q?d3vODkbkXfjBfA1OjsoCzgmy+b7PRrVpvhf6einqB+7aag5qvDO0rQRpqh6U?=
 =?us-ascii?Q?79MJU8KYHfTdJp9NpCOpzpBMgRpWUVUO386m82+vdChpiJJZxwVQK7kSkA2D?=
 =?us-ascii?Q?rSli8MwsJ36B5vdE0GqyumIzRqZox9RMn572M2VI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de1ddb7-d593-4af8-d4b3-08dad6dfaa45
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 16:42:16.7929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zD5ygQmBvPScIPA5iS3KvoHRYZTo2J8p0BxnOwHrEoVLNmoEK6OPYebJAT9VSDXN2Ib+uA4g9l0EPGmLLtAyNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5669
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

On Mon, Dec 05, 2022 at 01:18:58PM +0100, Borislav Petkov wrote:
> On Tue, Nov 29, 2022 at 01:08:27PM -0800, Ashok Raj wrote:
> > There is no direct evidence that these end user issues were caused by this
> > retry loop. However, the early boot hangs along with reverting the
> > microcode update workaround provide strong circumstantial evidence to
> > support the theory that they are linked.
> 
> A "circumstantial" reason for why something "might" be broken has no
> place in a commit message.
> 
> If you still wanna chase this and *actually* give me a sane,
> comprehensible reason of why this could cause an endless loop with
> officially released microcode, then I'm willing to listen.

Your changes look fine, thanks for fixing it up.

> 
> Otherwise, I'll apply this:
> 

Cheers,
Ashok
