Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B334D72A8AF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 05:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjFJDNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 23:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbjFJDNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 23:13:12 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3773AB7;
        Fri,  9 Jun 2023 20:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686366790; x=1717902790;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=K/BmCx3xgQXSMu5DlXt/VS1jZwsgoumqvowuEhTlSUE=;
  b=g6pL+kK371pIBb1FC/14xXugmLBq95m4YATGW7Bavd1yEqfJ03jwhwt8
   FvbmpM70Jrj6LZYauEm3c0GxXUD3XHhuCEh5gH+OOCPCpERZkZizHMt8y
   N8tg7EYVTXUim2bR0CK9oOCYUGbO6Vk/OnuepIsWj3uHpeQKHZf6kCee7
   ubN4wy94syuNMAaZUAX0NdYC7vCAktk/nTG6UGWnR00G2modDkpHFGMEH
   C/R+5BiIIp7+5Bhz/od81Ogwkt+3+V26RncFA5ltC+/t9DLYNTclLusY9
   UA60Vlu0ZKhk3KkSJS6fo4X+K2jemqnJ2De5Y88EJH+XMDevFY9XAAhKM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="423604481"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="423604481"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 20:13:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="800420740"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="800420740"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jun 2023 20:13:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 20:13:09 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 20:13:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 20:13:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 20:13:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnjOlMMVG5P7GtRmkl9BInsgXif8Wwquty1NyLQALC225P7fQIP6bMzxqIWqQDuvnPmmhQ4Xt6e8q3Ij8S0+pAdVBY8bOp6uaYt/dmFcGhRlc+46G+iDrkbzMXELN8RDrBZTtyvKS1Qqsq4QX8XFNZ2Zy3cZmjsKz9rL2Tunl0yauz/HH6mWt8pbXuoA5fSLQO7jMC7lVbYYykBNpEmvFyl8P39KJi11YXH4eH5j9ra+L37QGuv/V0m5nCdS2pkUZI1vebtHTBOM66Y/WGYTkQVEDkgEzSYBeL2/8Hp8dKLSLomojfwxiDJ/K2FA+Fs9x9bJ8uoZhmYyJP+bCQVDGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6HSgVIVcWy9ql9eG3w/MVCG+5nInpRk/a02b/nTbkg=;
 b=c2xAfqIGnJoZ5v5YCuXaj6/7KnnWmOW/2ZlO5HcNR3CNZ4pzYL/mn7PpSAmOnQ5EWwmAebOY42M0bzw5lfv/m19LZu7J41NpZfT9olzKZIZv4QaWaADC8OMOMuzKa+epsIt9MU/Fnvk0dIEUEOgXJDbffX2yxY6KZApEblVLfxd94auiXvDdzB9qkKDF7yoxnQmamxkJ0t4ua9/XxG309nwkdngyZN9HQ5MeY5mD0M0/3h4OKx2TZI+/gqAy3omwLysubZ4X87FucZR5FYRcoiUOFZqRMX1k7lEbaRwV9PaNQoMNdNvxfEo11dS/eXHsgptY27ssqQeM5J/9aGk2IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8363.namprd11.prod.outlook.com (2603:10b6:610:177::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Sat, 10 Jun
 2023 03:13:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 03:13:04 +0000
Date:   Fri, 9 Jun 2023 20:12:59 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 21/26] cxl/pci: Update CXL error logging to use RAS
 register address
Message-ID: <6483ea3b63b75_e067a294b0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-22-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-22-terry.bowman@amd.com>
X-ClientProxiedBy: BYAPR08CA0055.namprd08.prod.outlook.com
 (2603:10b6:a03:117::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: 9abf01ec-82e3-4859-5447-08db69609aae
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ygxSoKbkpfhcJIixQupX1kTz8aef54FjPXc4a3ElK7NTdHT80vhoyEhuKAhunqE0PxHO9JOE2Oc32+Q6KuUL6PjXU2v6iDE1q4nPB7flR0mRSGeLQA3TEGMeZTIJv/UR0Rt6oyj1ZIXWuYE4X25NR/OXwLG2KMLbpPGNdUXQ9zwFjcGkNgOdU6szB79SPBg7EJiTldJG0XBJKNOZkejQTwVGUpFDWE1mX/MoDI+RAV9Xsdq0BQwIR9bwAG52RBJbkJ6r9NzoIzgyqc8BH7/USH/dxK3nbgpWnNN0JUWWm3PfEXVAcaXmbemNjFxmojKdU/MZQm8p+NJb4wNKUibyivgriEqv761B/wWG9K7zQoLmgQt9U+WjPS7bKQmuDAhgLeyX9bpLfDJiMIq4UXTLCvBhrE25leS7q5iyPriPY9BJ1/tQpEloJqUMQLhLAHcfNrS8VwnL1UUDHBzsQHjW8HiYgLmnUj13Ipyc/mC8CocF/v1YzFLXcKUhzzTRH8mzv3aYIcPqV9NU4DLrpPwWHVZY/j8aglp768by6L/+qyY1eoYfyDPywaGvYE6xMK3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199021)(15650500001)(2906002)(4744005)(5660300002)(6486002)(86362001)(6666004)(478600001)(41300700001)(82960400001)(6512007)(6506007)(26005)(4326008)(316002)(38100700002)(9686003)(66476007)(66946007)(66556008)(186003)(8936002)(8676002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vWkLoFuHjp77wtY60QOnhV+a3hGnliprYaSqvevncOQHgWQ+v9awPzdKZtHv?=
 =?us-ascii?Q?j04W1gtndRgFwY1X5yFnm3Pv3t40wO2crrT8ukY36DXx+5lU3vTa++w9gHTb?=
 =?us-ascii?Q?Cp5Atzqoo+dvKzdUGnNOcLC5nzkCFNfEYiIumBUsIskldEk/MoqPq8bvl8nu?=
 =?us-ascii?Q?sfK9QLGgIqymLERH5/DVEEUnNGHgCXx3Gbc9o/Oy8ncB/kJa7Ho1wgywxU3w?=
 =?us-ascii?Q?kaJcXVl6Z3tGBXGKgICug9f8+8Z3xpiPBKzb92QGkXzFVIxwglfptW9bIM36?=
 =?us-ascii?Q?yWkQwXueiNrgsjskVeBCUV36AluTBqH3/GIR/8BCBft4pvIxnyqouUG/6A7B?=
 =?us-ascii?Q?F0nveHqmOrEtX98KcPksoX2h8MDbJeDR0mzvB8OQg9TyrYb7zT04AhL2vu/3?=
 =?us-ascii?Q?glvaO72E2IXMxP9aTpuZSySa46aqk4h3WxkDDBzJCBqDqj/5xajZzUd4NFnM?=
 =?us-ascii?Q?bmcaWYTPUEGvcC2/giqztnWJqHpbIGtGgcPLLsWSq9Q5FKQ7eIu8vajJjPMO?=
 =?us-ascii?Q?PfNFB7xdJMpOyDM7MOKAxHz11WTZdZeW9vZdD+llx2WMjuIIClsKf4XWeYFh?=
 =?us-ascii?Q?J6FoIxm10BD5O8Iw9eBi94LhPdcy9x62/wlq9fxBhgMBv0M4SPRjb7IChkJ0?=
 =?us-ascii?Q?c6j7mbVTI6Ba+9N7Z0KT99anbC0RRWKwXZXQ6eGUSCtnzAR6RGe+dTZ4LcwU?=
 =?us-ascii?Q?PKNTMCtwuSViK2d9elPJGbOHovW8P62AtmSHIiQMZfb3+NEvKW7j3wK1yMCS?=
 =?us-ascii?Q?+fU4AQZ8dWrMhkjEdPbMkGDh7f+7u2t20/9WTsyB98iaZDoF3oV0sQcBRFgQ?=
 =?us-ascii?Q?/5CQBSvnyMRafCMGuSSSLSHPmc8umX0npoPAXFvJpsh/Tusbp6NGYufCN+iM?=
 =?us-ascii?Q?+8bcKuk4v4I8Na0yOexphsEIdIlq+I97dR2v6EIb6gIa75XeUNdHLn/5MNQI?=
 =?us-ascii?Q?J++SMJGO31V9UzzMhIY6ygnSHol4nOTUL6aNCwalotYQ8t5W2MChDbya6vPu?=
 =?us-ascii?Q?udI3N3HlSkgKBIKMRfylE/j/p7PROICJi/Xw5jLfG1e3BI/nGeTeFOVVKirl?=
 =?us-ascii?Q?qrptN2VZcBVTAEZ1RfKwemS++tt2wjwPb6704vTX0WsRZl2bkWlrYIa4+k/j?=
 =?us-ascii?Q?jJKnmKPAIPPoblJO6f2Q3HT/mVw/iQBKxCSS7DVLBExW93H/e2KbqPJ7Sp91?=
 =?us-ascii?Q?qiZgpE0VuJLo8j1qmHD3Udmug5WLCr1cpXkblN8BBL5b8XJ6N11zgU7uM8G5?=
 =?us-ascii?Q?6nTayhpPh1Iq1DihiIJ0dmHBXWDr71tKPqAQQ+LWtawV2UluthUAhrDnRvGF?=
 =?us-ascii?Q?lyN0AAGvGbwOx01K7kEDbXN+ZNhuGkH/KosSU8sUscuQS6xveItWybGtNMbq?=
 =?us-ascii?Q?g2DWsWCL7zzKSp5Atcxj7dn6iHHx9icVq3iu8XQnsqvce6CerxA1Ep2QmHVG?=
 =?us-ascii?Q?Y0bFGY0EiPrDtVWjXggQV7WyJ1AEid8jfwv02HCO7PTWF5lI/IscTsMmsuk4?=
 =?us-ascii?Q?oW0U0BItud1iFS/dYgoRQt1KHfg3vZEcNfjWscC+2ScEtV0JD5cDOLMLlq/4?=
 =?us-ascii?Q?ycPIkfazS1z2igJxfiS6i2+c2dbdezKxHe7WipV56TFcPS4ibr6Ujo2UqY3H?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9abf01ec-82e3-4859-5447-08db69609aae
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 03:13:03.8578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+5l+wq64U/6/yiE4Cx2/gwi5stbL0OiSuWszlhE5RSXLr2GFkkg1pC85Y7QpVxuBNcqZ6/skpJLFl6MYIz1egVz2zPuw0undKa9zqbhH2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8363
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
> The CXL error handler currently only logs endpoint RAS status. The CXL
> topology includes several components providing RAS details to be logged
> during error handling.[1] Update the current handler's RAS logging to use a
> RAS register address. This will allow for adding support to log other CXL
> component's RAS details in the future.
> 
> [1] CXL3.0 Table 8-22 CXL_Capability_ID Assignment
> 
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Looks good.
