Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D31B6969EA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjBNQlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBNQlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:41:10 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A992CFD9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676392833; x=1707928833;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s+d62vMfxJIavXxOILUodZtp+NuTodKwgWgLeYiPIsE=;
  b=H+bdL9avay5Mmb4r8vURIyDxk8EkY1wxHXI08Z/35KnL7o53pdX1KJyn
   W9MaMzFjfpwtGYe9ZSo/iuP80e6ps5flyUB+/rd4WIrwDbvI9ku1GljFx
   HEW+oqQt2f5J3a0ppENySo95j8TkHPY0qofjfUBg6QDfnsWYf18D3jBwi
   bGBgaMtycgEfN/Vv1vfpQwJDhcmpWzhiFCQS9X4o3IYXJ5i4rjW2U6+17
   ujP1h/Q3cv2XhvWexJKErhtLGxi97WdN8St4NHv/PnCJRkqZbi/5jSAn1
   gndIbCe/YMFjuSvXzW5low/bB9/8Sv4sqxhy8N/DUAWBbP6+BXhb7Q6iC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="329828377"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="329828377"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 08:39:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="646813252"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="646813252"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 14 Feb 2023 08:39:54 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 08:39:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 08:39:52 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 08:39:52 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 08:39:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQAAe0V4I3Y2Mz6EBBiM01a0BCvFNP6nBdJVRtSLDavSuN/Ka462ZBcxgg5OpsRJ5UpN/Y1Rn3GnXrPIMn171tiVVWdBT04wXwaENi7kgj2GejSPfFKRsMgjA5R3cPqMxUcwWR6VDltMss6I5qJ02Gn3hakOba7NBTEt4lGfUy3C0xhV+79zKvg1HwPppEgR3c8V+gQ1TA74c9exM2LmLqJwQKlh8opdU/XJGWVakQppUEuWYp7lgsUy651Zdzwye8wKdClEG2uJOSLURbATlzWw+ftHeTPnZhwbwRpXUMZXXke7ky+lgpiXWnmWLTYsFnGMTIjjjXhEAvmvpjUt+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2Js/Soyu82QMdjimdPIMrQIUIJ8hWMdKpqg51JSeic=;
 b=PFYGbj7RMOhZzz7Eu43WcHG6F4UNsTolNezfN5jpLzPvywoSzGcYJcxR1UxQvkU0+NBgUEytYggLCqx6wAd1ZEQD09v4NWuiL31MR5c8+koXQHb8lNNfnYmQi5/HG+PF1yS0RNi78p3WMiBLB8GqyB6msHBt6EjOFNJ7yMoqCDIHsHaHwzijHxWmXJ2mo23kIbWn97g0BoV9k9yFIslECeittc2H2zDmeelXpX/YWVSvK16OoSRMhLDwjeiatNtH8nWNeNDcB1v1A3BFnjfkUQOXduJujW3CqNqMBt7T3nADnGuLFTjH0Ozv8pEHpwdJP8+kgbNBEKm8lq0jk4L1xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO6PR11MB5571.namprd11.prod.outlook.com (2603:10b6:5:35f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Tue, 14 Feb
 2023 16:39:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 16:39:43 +0000
Date:   Tue, 14 Feb 2023 08:39:40 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dax/hmem: build hmem device support as module if possible
Message-ID: <63ebb94c74929_32d61294a4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230214131913.1431969-1-arnd@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230214131913.1431969-1-arnd@kernel.org>
X-ClientProxiedBy: BYAPR05CA0097.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::38) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO6PR11MB5571:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d6484f-b861-44b0-cb17-08db0eaa12e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RhUk5xCWcU3n9zFwh+5Kwn36UMS36aD8u8aQAiGGP8+TnQnp3K/mJ5vvrZ4B92IlLxbH9o55FHuAbpaLo+he2y08Ypb2OgMsdjk0+AbCel05QwMwBrutt8ASGujzQp11LZymT/xim5JVDjBz5GUO1a47lHqw+i59Nze7TKtBsDovVqcwlDBdBJyMT4XjBcNbeEE31iB3MEj5V8N2uRh/krKjhXQumu50Mq6qmVN2q+sCXosLIRAV1Oqw53vRcF0wtADiQo5wgDhVcS9J6KL9WCnPTIOT0OF0NHmdtcyMJCkJqksHCyESK2NJz0ZlQON9spQ1Tu/AO7+fG2YMD1woH3mNa1jUwXDNaZLKAGn2gzbTjgPahvbBoTlYwkTDmZkwtvazupZoxibkiaAMLL4B3dACGPCsM9zBcwJMlRLednjrNs/CL3Eg6RuZ1pCQQlLCUC5FHBB87ZwCHdb2lUa5mXK9oMzMFo3KOd+6/HiTmYZ33SfPc1c2LSmKfcP8jY1fm+aAM1GJ8W/4uJYBOATTPhNZabqsQ9vHZHUPjX+vWu+/PV5rI2ppQAgunR7DfXxdo0QVLEGT+ojVrg12U/o16TtEg3FwuEpRmFbIxzBtx98CL78HlgSn1jlOCKfUu5Tsnq2H3elYGTn+ZjYYtUG8ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199018)(6512007)(26005)(186003)(9686003)(6506007)(38100700002)(82960400001)(86362001)(2906002)(478600001)(6486002)(4744005)(66556008)(66946007)(66476007)(8936002)(6636002)(54906003)(110136005)(5660300002)(4326008)(8676002)(316002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nQvF2jJS1+0pERHDbQFyPA2m+EG22fEa9wV08F2fJmvrzBqju35E2S7p5AR7?=
 =?us-ascii?Q?eyDkqs3AiUsk9d02QIVY7ELFAPwG8YmZx5dy2slFmyQvr57YBPivqR7A5qfU?=
 =?us-ascii?Q?4AFYs/d4Nu3wkLhuGO8HbPZOiNIzJit2Hmv6kGSazZTg60cbCqwNTEa2AolQ?=
 =?us-ascii?Q?dW9QnEY99uKEKaftp3X0jzesZGSxuB9jbMm2LZ5hea/PifFEP+VCDeHoPV1L?=
 =?us-ascii?Q?wSWCm6Ai7uVTVCGQjuZ3CxOExFH6bedKn8r7/wIpZoA0K6W8AHtpvOoeUrZb?=
 =?us-ascii?Q?A3a2qPhAhw7xmg4DwLPNu4Nt8PbxYzVQzHlIrJkuQHaLXtLQEcqiuCuqA8jT?=
 =?us-ascii?Q?hWBMoyCtwHx5HpDiOcsprohTv09gRJ3WcfXsH4gQCBUJdHk/7dj+UUER4bXR?=
 =?us-ascii?Q?SrdC5pfVpGZJHvaIrhPQBVm5jt90PgWvT5oNQqF75byMhPPJT5vvDr1DCrPZ?=
 =?us-ascii?Q?1GI9cVluiDuaypklwP7AGqHixNBG/0sjlaM6J59h7L2DQSWuEqj+8t56RIlN?=
 =?us-ascii?Q?DdEgman3XZCtttRu1kyy2mFmjE+hjxOX9vL1qIhWhZdaY8JsPE4D+y/YD6Vn?=
 =?us-ascii?Q?j9Os/gSfTWvyUgsNE2ol/biN+ThwjS47EaKmDKcBjL3nYDYWYfBKaJVcCn8u?=
 =?us-ascii?Q?EtDu6B9+Z9DYkr2arDfz2xgig/h/naIPbTLLM5SS3ROF6WL754aN050EG23j?=
 =?us-ascii?Q?W8jH5RoT94+MGIfZlxMs5MHvqspW1c6/bOv4FRJQiWH7rFrO1yMWLI2t0aKJ?=
 =?us-ascii?Q?86qeyazdf8krNdGBVUsY/4n32eOf3aglv8ogefkwWVU5iWtkuOk3u8/WjZYv?=
 =?us-ascii?Q?0RmLBfVl0JjBsHfG0KLbRdy+S7e/l96EkpgwppDnggODlyyDVDMNLeLJTNm+?=
 =?us-ascii?Q?AlWTu8MdgMVHBD7iqcnya43+NA2We5chgucg6jfN/ZSOgPhQnncf9eQuOSEd?=
 =?us-ascii?Q?BCLBIjY4Ae3cgDDfFBKeMC7TfHAJczBAz27rLAlKq2lf1DV+bR1Zuv/lMPjE?=
 =?us-ascii?Q?hVbid8zMHBHwXKPsDkvkyHhoQshv8lbC93fToBRNmrhi5nLlG+fpCgwaaf1T?=
 =?us-ascii?Q?lQztrmIRN2yf0AJkEHDHWJJs7lJ8ikITAULXnilf37RcDO/XPX5apfpTI61d?=
 =?us-ascii?Q?VI4RG2EHkz3FsAxAK1QY99DvQdeDpWyL+NG4JoohYLyWsFKpjdlVhxYsfI9a?=
 =?us-ascii?Q?/UCT9Bfu/p6aD1JCrjiwhepAZJ5ixXacLPy3qeldy12cpQ7b1T8rLT/xfeGv?=
 =?us-ascii?Q?1e5y0Nj5s05Q1PD1NLNPofSpxcXEcQoreFFeu5hW6CFJGRWAZxqdB0lOEFhM?=
 =?us-ascii?Q?kMXuHw6TCCIRLYhd5B2fsSYMVBSSprnN8XTDrz3DUX7kMhewFcWofxC0o1d3?=
 =?us-ascii?Q?dZdOpdlM/jGis+DCmt1NTbl6xkQD4SvQU3lfJVm/NFdrQ+TuVv0f4mTn7et0?=
 =?us-ascii?Q?FUWiAnmMJB3cLJByYJgnEM0Jdaeee0sAYvZ2AQeW7eEyV/Hm01te82S7Hdoq?=
 =?us-ascii?Q?kZE1a/54M854LljPFFQEdd9/KWvIcuI7fxfPkAvj5Ejq0uIgvdf+QqPT407D?=
 =?us-ascii?Q?Hvogc4oW9Q+3gW0N1Wx7J9ykeXrdeZgcAjKZwhdUGbAEW+nh7LS1P6QPvJFY?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d6484f-b861-44b0-cb17-08db0eaa12e8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 16:39:42.8939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXcjrVGF86zC1K8HUW0ct8wtMqQCOLGvitEUzyRXHUd1M0ORt5JRHquTq6fPDZYHOwE2aCi9gf/tkkN7p06XI/UG3Cuqxf6BMIZ66Xioqus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5571
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When device_hmem.o is enabled but dax itself is a loadable module, the
> dax_hmem support fails to link because Kbuild never compiles built-in
> code under drivers/dax:
> 
> ERROR: modpost: "walk_hmem_resources" [drivers/dax/hmem/dax_hmem.ko] undefined!
> 
> Make sure that drivers/dax is entered for compiling built-in code
> even with CONFIG_DAX=m.
> 
> Fixes: 7dab174e2e27 ("dax/hmem: Move hmem device registration to dax_hmem.ko")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Thanks, applied.
