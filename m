Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76CC6B85BC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 00:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCMXAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 19:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjCMW7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:59:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D00459831;
        Mon, 13 Mar 2023 15:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678748346; x=1710284346;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=23dlI3lFLE173v2KoPE6/4u3CbQkcctZqQj87D2FgVU=;
  b=Ab5f0J9MZ24EFFJUGZPHRylJBZ/pBm6dEtDenYvdGnVF0CwKouPEiXpK
   KyP0wbq5KnF/zyNgDEFyWlov7aBOYl2jcH23LtuROIQePByC96e+q5YwN
   FZEa+v02firjW4MDnQz597uX24XrnT3q0IJY4OvWLi7JB/JT6L1qFWrTm
   mv5+afcsyy0x56mdxsyPoM//u+RVNFBdOliZrSt1AdCCapfNNg+nMccRB
   hPzyWmTZ6QA0XcQJQPzwig4VaH+O556kdGzryW9dO1FCCriNnUHwTRPdV
   T1vpbGOCRRjUTEwXzhdk+4kHqp01p3T/v5OwE9HhHfY7dmis/bcNAYMlI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="402151535"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="402151535"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 15:58:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="1008176677"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="1008176677"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 13 Mar 2023 15:58:22 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 15:58:21 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 15:58:21 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 15:58:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 15:58:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiYuSvQBZsCyaEMOkHSgJzD0XPFtEit4FAg7Fcl8hLvy/vRQuAMHQf7wGQvZ/U/PQXJnd1exDQn7bji4gM2cAeQMG7v4JH+v2TZxilCVQ7Vzkni4YmGyr4eUdEqkBlML3F0eceVmXl7BXRfcY3cduQriwnxlj+kEXB3fv5S/DWr41znVYEu+7C/Toxyk1ya1mZG+bIj6s1asjvRkb4phX3Sf2BcDHHgsY7ZGyHhfzCKb3J19onEoyi3y/niPP9zjIzMVeS/SwoChhjlokcB5mJzo2dt0ePzyIsJxZxBwg7tWzk+32BNkbmI3l9gM/OF/YCObMwoDMbrmhwO0PwyI1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgxdgd6Ngv3UEzd2OV9zbHB5VzVkRrMqWw5OvV3KUek=;
 b=UUHXdbYQsUneX9ynmJfIEWsRw+sudvbWk0Dz9Mx76LYqLLIBVbjy16E5CaVFGqGcbSvFRMvU66fa4aTBaoMa3oPeklPgfTD98pudG3xdcQMXyHOVeNI+MxjA5T/LnF3xD2xJMe4vg9V6zs/uMazj+JIW4ioG7DOwnMb0Htir6spD5mumuCsQv+ZgFtDY6zXqdWS/NG3wABG5CHGwMw4VHO5c2AnCE+xoHQugHOEnxtTdW/KTCO91XM4MWucMtYiIlVbTv/paapebL5crEZXma4kVKWl0zYpCy9xvaaac6C1H7LrRklh8jVtmzwFB4/2qGce1IoS4K193Ej59VGNCRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB5251.namprd11.prod.outlook.com (2603:10b6:610:e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 22:58:17 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 22:58:17 +0000
Date:   Mon, 13 Mar 2023 15:58:12 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v8 6/6] tools/testing/cxl: Mock support for Get Poison
 List
Message-ID: <640faa842551a_22c07f294c5@iweiny-mobl.notmuch>
References: <cover.1678468593.git.alison.schofield@intel.com>
 <2d36d28755beda9d941301fa63da97b525203d7a.1678468593.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2d36d28755beda9d941301fa63da97b525203d7a.1678468593.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW2PR16CA0006.namprd16.prod.outlook.com (2603:10b6:907::19)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB5251:EE_
X-MS-Office365-Filtering-Correlation-Id: b08952af-16b0-443c-e16d-08db24166f0c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8TAho12Zca6ArW0LNYUCILnMJkiLOWV+Bd4KNqss40w0kMRqN0qMNc5KwWQHHIMSO4p2E9JuUse+JvPgbVj0m2FbDJv+FehtElaBu2awyJDN8K4WhMbYXwf3f1PIx/2t6yzXNLntgVmQdmmRbP954DkCbboJysvYAguwlSydtD7QBxECj0LxIrteWCNyPqITnl02u5r/vbi+NlX/n9vhA6kW0yYrTeZ3o05PgoJpdPHWNDGS2rF/Gh4MJ97/CCONCByyLu12Y7o67tEzDZyAv0wqFOyCnHNzpAxdDS4dYSGF6X50qV86aGSdT2nbpInA5FeT7yqU46PzkzhGyhfft88VXErA3ZBSFFoApuSLRJVMzKengIuRU87tOJcY5oowFCGKaJzw9j/UmHg8T2/ks6y6GAUKOrqJMcTuV5syypmbek5YOHcnLqGmK1PfEucYFDc36Iae5YxhqUy7saW8rtjz4phk7JEPA3gHaNVeJmc7zgZ9lOnpiq54+l7nKGoeIEV+f05XWwAk6sKJoYCJoiwoPTx6x/ds9iZWldHPspz09kG5jCpOWPAzWeO7SI3+QZ6NGNebw3lyJEIV7imCkoXFRx3dI8bfDlc+xt+ED+HRdI0cOIdT0wS/GwLrDUaKIVNDKFMXxqW75iD2CxzQFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199018)(186003)(9686003)(6512007)(26005)(44832011)(6506007)(83380400001)(8936002)(6666004)(82960400001)(38100700002)(5660300002)(4744005)(6486002)(66556008)(66476007)(2906002)(4326008)(8676002)(66946007)(41300700001)(54906003)(478600001)(316002)(86362001)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iuBhETwGiJLm6ffPKBsCd3kQEj7dVnriQZ6WB+xkg0y9/RLBF4ckRwMVmD3M?=
 =?us-ascii?Q?BhvD/XQ9vR7s4p1k6cGn86qfXhfpYE6KWLwlJxhkNA2hE80PXtEf37Hfyzbh?=
 =?us-ascii?Q?4B4DBFpIgBxDF6/S/8NAP0g51LdbRNtpMp7vtRNJpWEfJ5VVdC3kmuFj6FsY?=
 =?us-ascii?Q?UTKfV1EpemTpHvvU0z5gXiSPfQZjln1m3guFhMxMR3yaHUgo43AnNnB7nQ/U?=
 =?us-ascii?Q?0CJ2yQ+D4+km2UHWZnfuxa1H2d7jhC/rFLsS+ULamDJ6BG4FrwiMC2Bz4t0Z?=
 =?us-ascii?Q?qwhbFmxxM/6r00K2w+a4TGvAc/EEl5MXMLrQjVSGGmYIF8isjDe3USOtJzNi?=
 =?us-ascii?Q?dvyPSSCYmedVEYE8qphGB0UTJtEPey9ZIPm2r6IHcsuTEBGmSc1rdz8noe0X?=
 =?us-ascii?Q?WBDU1ye1jjL++1wX5ONr1+Q0MGVyO4Ru/yEdgyuWcDkMXUUHHCRFSjC+WZWh?=
 =?us-ascii?Q?fFayfNbrLdQnqKR18aj9C0+CFZpmvUzJf8vC5rkEpCnKOl6rM2Clynjg6SBV?=
 =?us-ascii?Q?R0ujVMY1nKV9d00tP5z2nrIP6KkCtmqQH7yzPHAy5oS7eWS6kJqJz8Bp3nar?=
 =?us-ascii?Q?aasowemzvkQewXHJQQg38e7o8WFIcenW2OWZW6EVXBVyXInW3+gNukqUn5Su?=
 =?us-ascii?Q?Ppzi7MgWVrdBqai1+PiE6Cdrb/y04DEkbS817te3Ql0cPt2bU//PqOaRNuUh?=
 =?us-ascii?Q?907TiZl4Dy0fZJ7exATprznS9NSKfsMErMYJ3H0Qwup5xgkgpXZLx9/ARl18?=
 =?us-ascii?Q?5dFquKdLOShP6mWbF/uTjZpEac3O8YkINBPwKnuLuFi6OIOYi7OAOlne4WHo?=
 =?us-ascii?Q?XUJAOEnR9ua6p4KO26c4OnfxRwhNVf2YTdJ9MddYGH63gjHHrNwMQKF02EHC?=
 =?us-ascii?Q?6Jl//uFSrK0svXowIhepEVrW+34/+tQJevfBVfU5GC8Qvy3501poUtASfC8e?=
 =?us-ascii?Q?EChq5tWriXG/VKe6ulzobdxzpNDesxiBMaA51eZ+a1Df14rQTJcZVeacdJXC?=
 =?us-ascii?Q?FIvDxaINMPfYM/rFn0yd41MTRhkFRJrck+MJ4lcRWNllLixd5zVFjUoZUywR?=
 =?us-ascii?Q?pVJF0OvMb4ejVGAc36c82Ftrr0PBsREAOA4bPxY6AchHsO2F4raWgjLGBIQQ?=
 =?us-ascii?Q?5g5k0KhWW7gPRfVqyKvmEUhpI6OD5amjy17wDJxkUpF1PMhLChlD6mcfc3rb?=
 =?us-ascii?Q?VkRDZObu55pzI6tvYta3onWrd8FaUOeGw/PB+uxiXmRc2u0hkYhs71wljQGa?=
 =?us-ascii?Q?utEgOPjHK6MTC7sxOhx4v6UK0p4wHADa5N5e7aMX0VENySQ08gwR8LjnQ0c5?=
 =?us-ascii?Q?phZ7eDrDOpFM06tDEwjr5QTQvxG0Bsj+lIPLd+twkCY+4IrzsdliaC3FShMr?=
 =?us-ascii?Q?JQ1Z3gUu4xZq9KqaNwcpcZqYnSY3HHjreHK+98YocbaIgRQbinN0b1bX6chJ?=
 =?us-ascii?Q?jX+uDrspknRGMMFbiEaAx1lVhGMVlnY7Hvt9BRdbo9h6xNnyCWUNWXtYHL67?=
 =?us-ascii?Q?uOMuz2yoKHAH8tbi4tsPzAtOXCR5F5gHg+2OCR8LTHA/MFccGu6APcIdbiGo?=
 =?us-ascii?Q?VjDXpsfcndjeZo1l4CEjxIk0QtzcoodtZZ/6Tqxw3MdlQP0XCSXUhOUpo7F9?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b08952af-16b0-443c-e16d-08db24166f0c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 22:58:17.5614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUK7Ymj82oD0S03lm6H/UOOi/udY4xVpD+2KSXXGTgK2AE0Ee0OqWSb2K1oipsyjcB9de0tAThvcVs3dCiKU1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5251
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Make mock memdevs support the Get Poison List mailbox command.
> Return a fake poison error record when the get poison list command
> is issued.
> 
> This supports testing the kernel tracing and cxl list capabilities
> for media errors.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
