Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A3A72A6FA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 02:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjFJASz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 20:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFJASx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 20:18:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFACB35BE;
        Fri,  9 Jun 2023 17:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686356330; x=1717892330;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1jJa7/vx9mKmOu/gS+vyNv6TsJS6/uH4fKr+8giNImc=;
  b=AocL6YOsQMnSugd8ik+xZDkfIe0psDM3+F/uI0xdDrX0u9Xh/TA5jIFE
   59oAaY4gthkrDz0edkAn9mv4KFnDAKh59u7QsTA0Gta5RYjI9LBGA1ION
   zFs/R4esNOC1nNjbTF57jCvClPR5UM06BAzewzgbSvfNzl7sj6lA0LKYb
   YQneAjopy6oFun45TG44vuRUVBRf2wmJypCmRzXSwiH5ZivfsVJ5OOv4t
   itQFekAEe2QtdIT39NZge07v0UNgJGxn1ZghDS9s2qsqrg8BrSpFsg6vd
   /uTtwYUtR8uaafb5CWsnb/BM8ZVpKGd9lzrNQww3ChsX8QTZGRJVPrKbU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="421303770"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="421303770"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 17:18:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="740339740"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="740339740"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 09 Jun 2023 17:18:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 17:18:49 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 17:18:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 17:18:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 17:18:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5gdHe7TYLgENlcx8UQJ9vqJmXNmuNxhEYidRUaihR6JwrfbLb/cRVT/HEfepLWUZGHlJFfMoASUfoSHcLMKzXZIaSPsSO/TAjkMqCPd3WH5IEJa9e616e0b6CXpZXTgXRrvteWueKWxub2bm4G7AvouzA6RZIOC5gAPjwnqqigO4WZarkFp8g2afjFidWl5sXXaPln9+Dhx95nrnxWLn1GGybwVgyEhkM7LbMqwbtOen3CTnFw6E4U7/1s4uTMdE9mS3U9SSlVq4e0Il0y0z0rWF3OlJhc8CrPk8B7idob31DJVVVObLBPKy5f3/lGUScJi6HacQ7WNTnR3bMCtuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55dLhz3AhA9aE/WTqMzX6prghV9CUDbWuzdYYGhcSjY=;
 b=nuTzJd+3ZYVfN0ar5aqh74b4ssa7TOKmLB6AK4ALorZRvkUHMmFTb1HlG0LuzK83hNkiN0oy2CilZ2XtBVtFsu+Vt0CXJkdq5EfyOhLZKydETE0jY9uGv/a5KyFc+yQLSyATIX8HLy8+Qa11n9KV1Ta4fVjS/5CcOxUG8NPLjLp54GQA1lB08usU7+qnYvPKy5moV5dOzTFfB1GJoikdV/jj1G4Y6Oiuc+3LwCsyXmQ/nN3MtqgMtP4zkyHcAlje1UiiMzeqMdyuCVU8w2K9hUKSdPkTWTxssvVzJwSK4FdJpvZ8u/SMpo2OtUsumtawN89BnrgOkgGE3qAfKIrF/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6126.namprd11.prod.outlook.com (2603:10b6:8:9e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Sat, 10 Jun 2023 00:18:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 00:18:48 +0000
Date:   Fri, 9 Jun 2023 17:18:43 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 09/26] cxl/regs: Remove early capability checks in
 Component Register setup
Message-ID: <6483c1639f58_e067a294bd@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-10-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-10-terry.bowman@amd.com>
X-ClientProxiedBy: BY3PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:a03:255::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc7c003-b92b-4306-79da-08db6948425c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WZRIUyTOLu54GrjhA/R4+woY1Mn1dnSQjIiw9qVoGWvjgMw+pFeZVFNNFy1nA4P/Azllp/r5E82LjwqpLDVq3KfE6ghUt20wCd462tmdWZTZqGzSQO+7V56HMEBH7rk1szSo4Jq3mkVi0vf0LnGla08KKjeitmPKo9Yp7mfSQHqWVlwem9vX0dLz/tDjuQKbbE2g0QiIrabwRlyiQUX8EoTfTPApe1uqKVPlv+lsRSY0J35WYdqqyENJA5/2P8xMhqm2qejamazj7Vjo2zzyBVA53zVga+Tf4OVIBIJ7gllY1LGhYRRPQHacZxHqcvUQl45eUxXg8Ee4iL4mFs1bDtqLJGgfR9cIP9prC8bjEp4pnAbuDqdlC3SnThYov1mPmvgkpb3T2IYJBnQolsLrZ8KTuzwtww8keHN5FD9eNTGMmdoO2/CFX9FHY4yRSQ9HMQ9CRBLB9OKTf7UNEwl83cNyyE0chV3t+Vv/FZoKtGY1C7MYUgceuN14YLQpQ9j4A/GjP+LT6QHDEwXFiwaK54l7BuSfzsORF53dLYjoKxa9Fa6MZFLyEKHtnPm6U4Zk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199021)(4744005)(2906002)(86362001)(82960400001)(38100700002)(316002)(6486002)(41300700001)(6666004)(5660300002)(8936002)(186003)(8676002)(478600001)(66946007)(6506007)(6512007)(66476007)(9686003)(4326008)(26005)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NwARnaXgLhgOwWj4NaZXmaxwfF3Oa5r97lIhNkcAJ57cq3jY0AyBDn2Y2gJB?=
 =?us-ascii?Q?HJQX03we0iFjYQ12Omd2pCYGlh0dvEdQSUEqmcW4YADKseUtA+n+D9aHTPwo?=
 =?us-ascii?Q?evyLkldIbpfAZSItAZ7V47iCmu9JBY+c2cotUC5h79tsYMdB1tBj69aGdqCQ?=
 =?us-ascii?Q?hOveVuEbMbJCEK66c6+Vcqxeuos32xMB11tnVUdqNRXxAvVWzis3i/iXXhuZ?=
 =?us-ascii?Q?1idLI3KskAf3VESL6UCUIoRow2+kj6nZnwTfybwctp+uTUBJ5Hsf2Vvs6LHW?=
 =?us-ascii?Q?OTqZmTy3Y7KDE4UsSGSyLfCYYVb5auzw+LvFlZjXE5nnX4t3NwPbB+UKpJl2?=
 =?us-ascii?Q?LxXKePYTQpe3oLGCL4Snb0RzVTJLVa1a/8LKf48OOrUHhgyFyrIfVCSst6Fs?=
 =?us-ascii?Q?QCgI21ej9fcVoYM1F9/p/T6uQBJEnak2gee4/MPYNTuPQskKXd29vT3MzT5S?=
 =?us-ascii?Q?/6RmLJF7sVPc9odoo5OZ/uoqM1Cgp1L6NvArBxAOaTTdqjnsuki2qAYN0+c4?=
 =?us-ascii?Q?L/1oGE2eqotSQ8YhVsMy7I7NpN1NRGL67D/A3eMizkiqq2wX2PKSANlaPvGm?=
 =?us-ascii?Q?6S6YX1DxxvqBxo+eUddZzuEdAgL9VJS7TtQD+DuWTBEtf2oFM965diTWzBd5?=
 =?us-ascii?Q?PtRzXuNodToFTI+l+3m7acyXsHtQPUApu+E82V4ZfIB4qnYb6OX5DJ4ZuZ7A?=
 =?us-ascii?Q?eqh2z5PJMM6YZfO8xPRAgE+erNSwsYDuemTEg4zPGnYZQ2DWhDjP6LGKCCYE?=
 =?us-ascii?Q?rA1qCUR9AwGUYqAFDx6t7BYDSYQRcwt/s/Zb8qvV7XTmXYQy0pRAnTdZhQld?=
 =?us-ascii?Q?yq010hY8L2Cfb2DIQlMcGUK14hqnqN9bp4/lSVpXY8Cki7x67Nw6vNqx1Ui+?=
 =?us-ascii?Q?m6HbEX/5zwOz7U0/Fl6bhe/X3vijg52QhpJWgJN6iJ/rdSFrMyoWk7QvceZ2?=
 =?us-ascii?Q?OUeyfLJobV05xia5jcnin0NDt4dLCdQzcO8vl1Bo9d9iSanZIConbZZPEPSH?=
 =?us-ascii?Q?7vXMx5cJKsSm3n1jlZx7RcTk0BSCj0Bwth7V2jZBd/AZk/seQ6jBEKYZhMd5?=
 =?us-ascii?Q?tVYodt/gZ1K2Jpw9psGi7xgZ9jA8gyNIVo6bPytZ/lFW8WjvjAG+vlWbE07R?=
 =?us-ascii?Q?nruM6VeROKg7RGSfFCQtmVFm6JMuDpqpxG8vmce+oHJuC0jOLQo8d9X39NnF?=
 =?us-ascii?Q?WDD4WcnwJhiOIENab20p3f4AtO8PRCbuovlTdPAtluTAcLmRgPHegluGVlks?=
 =?us-ascii?Q?asANGbGGQTtFgVHkXA/Mm4mtMaEBHUBvF5LOprT//LAYGBBddnm4Gw63t7Te?=
 =?us-ascii?Q?b5nekOxngMa99NiVdQF7xokkfCz1GjcW+6Y09xrBq0KfUD6/fp1oBZY2rzVR?=
 =?us-ascii?Q?ShgK/oJaVIJ+EPdNen3vQmdZjLT/u5G5LkG2si2l8YH3jmdwyZqWTZLnF8wF?=
 =?us-ascii?Q?d3UkECk0gZ2OnfoGy2Yz0Ps7UjS53UD4H6jMKsLEUlWTKovUaRuH1T/oSDQg?=
 =?us-ascii?Q?c7cSwOp0HEl2BXbh5CQGFYat5FEf7a/ujbHLm1Nzn34WyzYyC5YY5F6tCZMs?=
 =?us-ascii?Q?9yXeqKdaaabiGrId/lxfBrj9SkMOZX4HlSTm6q9lLZmnxceETVbGbnLdof8x?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc7c003-b92b-4306-79da-08db6948425c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 00:18:47.8587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWcWmIvxNdUp1QeXJtIC8VlFEX1Xv8uJVpACRBkpAl0ODEuqvB/4neipw4gcuLnAbSDDwI0hCHTzu/fGxDmB7xu49iGpKMYbwEvDd5SIDmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6126
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> When probing the Component Registers in function cxl_probe_regs()
> there are also checks for the existence of the HDM and RAS
> capabilities. The checks may fail for components that do not implement
> the HDM capability causing the Component Registers setup to fail too.
> 
> Remove the checks for a generalized use of cxl_probe_regs() and check
> them directly before mapping the RAS or HDM capabilities. This allows
> it to setup other Component Registers esp. of an RCH Downstream Port,
> which will be implemented in a follow-on patch.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Looks good.
