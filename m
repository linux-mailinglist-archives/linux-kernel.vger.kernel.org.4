Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794CF6D4B45
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbjDCPAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbjDCPAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:00:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3057C729A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680534010; x=1712070010;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=P15B+0EcX2FluToLRJLgbP4yW/HO44D1uP7JnritHqY=;
  b=ExozFu/rZb4v7kWB9rwkFbmAlyDGidffTUrrTIn/yNGBksKpsLZj+j95
   EYGARKUjvBzVcy7qQ1DuSN3CEhUzoe1bPC7ro4cR6ibhMOjGQb1M30eef
   /hO8ZaC+vQcTZ9/nj0Ho9hAjl9DeaZ2RZyREXIsOquqXO4vKWErqdV8hF
   IlpXAlDk7gnqYc/QVQF+2DIXN+GtyB6jlrO51V7sRbJhzDabVPNemk2qs
   s/ZM9r+PICFwTHeRiSJdA88B2dt8nsJM0Ok3L2RR+7si8uMH2uOrsfBum
   qTM87nBxz0Q0IQg8tO0t+SpTZNlbvqTSS7wi80bj3M3upePavKamN9r1n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="325924532"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="325924532"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 07:59:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="860236684"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="860236684"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 03 Apr 2023 07:59:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 07:59:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 07:59:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 07:59:49 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 3 Apr 2023 07:59:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUybxGnz7lcjYGk10qnR3poDr+AVJ1uCN+1cwNNTqFfIfHWWBXYHA6Qu8zzD5+bEiOdecQtGrlb8tLotIKjEvg8yaUvkbUVobOoAfUJWC9jUDqvbg6zkJFtTWOwUNi8McD6a5U2nUr9qqgKc0zt/XSAq5Q/B/P1MWd+7Jshc8hbVnXXi2EtRWEnL2USL9M6GrL3VrE4NLlJllEYVzyx3+7iIFib5oYu8rq/ULfYnkl6dh/KPjHlMbW2icb5oNJ75c5qOouwDgUDk0fbmcJD4sDIp38fWCNZQ4Dc8Z0vt3SXlUZooa3HiWiIYO9uvrbV8DcPlEfuOME01JRsVP3M+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dH6WlIhCblXIIeh9lNvv7h+Tp8G4p1RsFeNM8aAqveo=;
 b=jE8rcMKBrIGWAIXlMWAsmdpNOCZDfuvkXtXpHz8EsrpwqPVzdkKIoWr2CWpBknsgYN5Gh8byiUWYSy+vmaOO5Nny/EzDUfqaguPJWvmvsT73Q67OGb9PoFLzXq4YGsTNW1BWaCuW3UXbBAf3xZrbzc6XJMfddWjAIUqaW+P3ckyxyNG6Aj0PdQ5cmI2ppYVAEw2GRLkUFC0NofQH5YDzcRJMVvkgMaXbNNgSnvaMHMaIWRD89hJKmldSS5DhCm3RV2pQPMDQ9GFO1nCYm4emgR5RR0aHjg/Nw9NktoLl9qzfI2AWKyHFY0va7ioaKvNZJyh/l9pFQ8QURjqSc0L66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW3PR11MB4729.namprd11.prod.outlook.com (2603:10b6:303:5d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 14:59:46 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5b2:6996:5aee:91db]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5b2:6996:5aee:91db%8]) with mapi id 15.20.6254.030; Mon, 3 Apr 2023
 14:59:46 +0000
Date:   Mon, 3 Apr 2023 07:59:42 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     <outreachy@lists.linux.dev>, <hvaibhav.linux@gmail.com>,
        <johan@kernel.org>, <elder@kernel.org>,
        <gregkh@linuxfoundation.org>, <greybus-dev@lists.linaro.org>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH 1/2] staging: greybus: add a single exit path to
 arche_platform_wd_irq()
Message-ID: <642ae9de5ad28_39845e29467@iweiny-mobl.notmuch>
References: <cover.1680185025.git.kamrankhadijadj@gmail.com>
 <e670baa9bde47a3bdb02e59ec37a438a62c52dd1.1680185025.git.kamrankhadijadj@gmail.com>
 <642a1fdcb2648_394c3829469@iweiny-mobl.notmuch>
 <ZCoqMSy1Ary0sAp9@khadija-virtual-machine>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZCoqMSy1Ary0sAp9@khadija-virtual-machine>
X-ClientProxiedBy: BYAPR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::16) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW3PR11MB4729:EE_
X-MS-Office365-Filtering-Correlation-Id: de09060d-7d83-4083-3eac-08db34541098
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dHyEE7T2poJ++AD9P0DnaXkpszpcId4ZPwKr+3tiF4QAgxXiuGz5UaNptlICRDBQlDc/i2YzKtApAObMG2YQ1l8PXPE3pCH4BGqDI2FBgtpUTkZ0BVthAonI51P6E+9I8E4F1IPK2+1IgbjIZXRKyCydZqLXYPfcR2fdchCJuB4gkjquLP0pW28TbPHY0dyqCtPtMwM82LQXIwiDUXAc3q8P80rmySZp24tpemmk9HaUje+NQAyzRjAZP1YOcZWFe0pd20tmSvvfga7LD6+Mtzkfjr9xAKq/ZV2GdiXtAUfKmmv7icz6BvNMz9UtIiVFiW9SWBs3hMhBDpJRslqCkuJNVdvrA2wW9D/urbflHnmg10AUKH5+YuSsdZh7w6iLvOY//UarKOlU+On7dQNrfXSI2iZ3sTSqtL49FxSF2jFgJQchALFV3iyCSRnbaGRwaZZxWISUClBcl1lmJSbehUq7poeSGS0LbifzEHcFOjmeBm7AWT/1xQOByP6x5tCSmGrYjLjXcgKpJpyIov5O+AdmzfluQXzBzoOjpuWu7Xk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199021)(478600001)(110136005)(83380400001)(26005)(107886003)(6506007)(966005)(6486002)(6666004)(86362001)(66476007)(66556008)(66946007)(316002)(9686003)(6512007)(186003)(4326008)(41300700001)(82960400001)(38100700002)(44832011)(2906002)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sWTxEgHcq4G90OgHad8rbN3GvoS0XdZJdF/XPGrgMFKd/h3EUNmSRuOYHGjQ?=
 =?us-ascii?Q?0ky5LoYCuMdmtG4axAnhRfLiNFPcgKsnKyP5ciZzOmkPbzMR9OOXMVLjjzQH?=
 =?us-ascii?Q?ywey7dG2pgwwhgiR6eg9aJjjWyl/L3Mik2tzrFVSfnOW4oiHUAEbhD7LGOEl?=
 =?us-ascii?Q?b3sNjBj5HE8Mvl5mNFLF6eC9HnLGX6Rj6U1DCj+wFsmbtw2rYbSZD8EQ38E1?=
 =?us-ascii?Q?cR3ttMMgKen8Uc5YTA3R1FyxPgz9VNm43bgDfcFtyc0XfYaVftyfrdIgc6fs?=
 =?us-ascii?Q?PMsi3pEORs20ebYU74sWkUk8ehwh9LBiea1FyopXb/VaIovjMXQQ1nZ4m6Rt?=
 =?us-ascii?Q?umrKJIzYJsdORCLpjxqHey6iSIePu6ldvUL6Bn4mz/pNtlj1ECNndjz1zgMA?=
 =?us-ascii?Q?Jy1Bs3EHkTk2/lHZN6ROXjCsu8md70STzZnSnnJFagKBOkguHxrFwZd7b7Zv?=
 =?us-ascii?Q?ka24OzaUgRsRJFvgDCPzNxq0TVGzpJZERc6flwzXdCxGNsd+dq/VAQzLninx?=
 =?us-ascii?Q?hgcia0CUSg2cqDymNFg2ggBMUHx+E/JE1XR+9FCE+n+kpleEuTxt6aR4NjJ7?=
 =?us-ascii?Q?C/R/06AkcnjqXxNmxMUfwh3WLOxxsNtrV/sRfN7T9n8dt1KVJmx33gvMauUz?=
 =?us-ascii?Q?7Tjv89e4SucrTP3IVBXu/wASd030WMtR6o9RQ7eHTMsISQ+CcoVnRw7803FI?=
 =?us-ascii?Q?3AuVG628iDsHse8V5qGhLiEoLCCLLS4etVAhmbTqpmlVNkW4vhNMtD0PvET/?=
 =?us-ascii?Q?aFIRINtHsNbX6rmy5gwNzTopqFzoOWSeK8XHMpwud63rQSlIz54eZ8RAEYt1?=
 =?us-ascii?Q?ulbDDtkvJvHtiHjGtSp4LCF974xa2VptcrSjf1Vp3BctQRmLwgmZZGb/OkaM?=
 =?us-ascii?Q?XQTjUzCElVyO+39A+eETFjzRW4gB7OM4q5DHgP3sZ+SahKE8PByhOe1QTIpy?=
 =?us-ascii?Q?Ugw1QqeqjRJdAkq5Ipqc7z/Lm+7U0DJIUlsol4RWhSNFSiTr8AoIURQcwQTe?=
 =?us-ascii?Q?e9bOP0RRnBMs2F5QjfuwAilu5ZRNX4Au6QkyWmerxmMolg7+p5aG2JVGRvXF?=
 =?us-ascii?Q?jyikUp1+v68lBkKLpmqPz4NgWoqcDxJuLG/k+GndDM1YNDQLa9XtjEU9z2c4?=
 =?us-ascii?Q?u6Zl84BAIPp4GlNFJmuQItmuUTISFTym5xDW2CWugimxfLJJsVzKxS1RcxKK?=
 =?us-ascii?Q?yYU69zAQq+ioFDEcL4Fga4Xo0tq+h/cFlOEZMYO8UkhT/RdDKXlbwM9ieOEi?=
 =?us-ascii?Q?b3nQjhsZqRP62mTOLh5mzlImPm2gO1mZkhW6g9w9ziq/BQfm3kVGPmmrtorK?=
 =?us-ascii?Q?g/KQp9AzaJq3GMgRFP183+nwIAP77YxQdt9OEzvqiPZy/HKtRf083IYsqyRb?=
 =?us-ascii?Q?CrlQ2JFNPPj60lZYQvKTG6vQ1Hpcs0lzWQIRWiwVJTtJl93g0Cb3O5Tuc2zc?=
 =?us-ascii?Q?bLJm8MrMgblLWNm9/SfVxaLllHz0siF8uE8v+wncWNRdThuIDzQvBjwfaZYR?=
 =?us-ascii?Q?RS6uV23xsUil3whSEjWgBeHQmgXp7916Qws5Ew/wFvA6QG+DLeQiyOUeTRyo?=
 =?us-ascii?Q?PD5Kbx3ed0nSF7wd3aSewOi4YkHIMy/cmYbF8Gex?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de09060d-7d83-4083-3eac-08db34541098
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 14:59:46.5955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sz6wKaEIAKT7My1zy9dtkqd1uI2pSXDC8LAjm85HUZeWIk0OleRlU8cedI0rwBquPsuYBRH7KxZFMUja/5rYBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4729
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Khadija Kamran wrote:
> On Sun, Apr 02, 2023 at 05:37:48PM -0700, Ira Weiny wrote:
> > Khadija Kamran wrote:
> > > arche_platform_wd_irq() function has two exit paths. To make the code
> > > more readable, use only one exit path.
> > > 
> > > Suggested-by: Alison Schofield <alison.schofield@intel.com>
> > 
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> >
> 
> Okay, noted.
> 
> Also, would it be okay to send a patch revision with the changes or
> should I wait for the feedback on Dan's comment. Here is a link to it:
> https://lore.kernel.org/outreachy/6ce8aa34-e600-4d6a-adad-ead8255342e5@kili.mountain/

In this case you are going to need to make a v2 of the _series_.  In the
next revision you send both patches again as V2.  (If you are using b4[*]
it will help to track the series versions.)

I am saying this patch looks good but there are still issues with patch
2/2.  If there are no other comments on 1/2 and you don't make any changes
then you include it with my review tag as v2.

When I do this I make a note of picking up tags like so:

---
Changes from V1:
	Add review tags

If you get other comments and make changes then my review is no longer
valid because you have changed the patch.  In that case make those changes
and make a note.  Then I can see why my review was dropped and, more
importantly, I know why I should look at the patch again.

Then in patch 2/2 make changes as needed.

Ira

[*] https://b4.docs.kernel.org/en/latest/
