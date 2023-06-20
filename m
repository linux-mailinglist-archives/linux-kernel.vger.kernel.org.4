Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDF6737128
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjFTQFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjFTQFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:05:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF6B10E6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687277102; x=1718813102;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xRdpAfGKnq8mxHxWkph9F8QCgUaY7N7K64MB2q2O7go=;
  b=anFjcLVrMQwS7UW7JSvKwkxIJmzgnWk2WMkqlhE7XZH3OAiHCogwsxao
   pZBM379KYYDWJpyNm0gXdHjaDHYc+8UmLOKg7bRPcSagRYQB1uXfyCS2O
   r6sP0TBzDtVqZbn62hZ/xeM0UetDApnsO6aJ0KqnidPPrrL8Dqsy5NWVG
   zBgk68S50GCwfDj6i8SWfyoFaltpwDIlJvhhrQL0DYqnb/JoGJcQYDefu
   X+r24Me5UsMm7/rkevjz8EKuqKcuipHM78Z7TTUP9NNsTpIPVD/4Z3/lN
   YTWOMrvyYdCVN1RJqjZX68gcEBaefuYSPXvybQNjgaqN1JiCywBszyYuw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="349633537"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="349633537"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 09:05:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="779481612"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="779481612"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jun 2023 09:05:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 09:04:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 09:04:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 09:04:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 09:04:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjywIdgYfIbVAYEau/LJBfEHYm73EX6kmfcCkvsrQL844fpQ51D//TGX0HSpK6ZdBlT1cE5b3v82/H8eDO3NzIzVnNu/V4IeB3C1sXBNiX6UgpRNBaAK24lm4njq1fCk7SJ03wqFhpccxq1js9GUvksXP1fIz4ZqKjG/FUEGig2BN43rE2kWP6pyCU+2KMHinwjn7zAG33vMMKK4wxJSe1D4hVle/leuCpq7WANGij2HuEOiBdsATYLSsLqO3jeyqNeGQMWlGelYP10zsyRpZGMoTk8Lw7I4FzqzrIjYPxd/2yr+BZmYvCTQfT+0TSrbO2FbNqDfPfkqbQVhh+M5tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBegIPzB90fIs7CQ1R+8n46EZQ4FZvo/2BWfEklpk2s=;
 b=f5CJ0JTKKukOyeYtcnFZnpOZEDELA5K6YMWfc2uPQhkp3I3WhfKrEyACOd3EAyW3dh1ZL7iDCkUW8ELzgyBzqY2DK7kRKIS3ZUpcS2yiUf+nlDNyocgQrExbisKgNkCYYIPH7Lm6elaS9jqMjynYvU+uwQr2+oa8MQYyP1AG5Y7V0pu2wKMrqcV3wt8Wv65EAKysUKf22FR/biVdnAoh2tXfyqqx+XwAC5VcdGYYFtJbPc3lAN+aml7+88njfmRH19MCVbaMJKaKawIEqIiKJpoFU39jrm1eps4izTUIUmArH94wpN23vCr4k1fLS/cJVIl+ZuCFn4CzlYThtezY1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN2PR11MB4678.namprd11.prod.outlook.com (2603:10b6:208:264::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 16:04:44 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 16:04:43 +0000
Date:   Tue, 20 Jun 2023 09:04:36 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <oohall@gmail.com>,
        <aneesh.kumar@linux.ibm.com>
CC:     <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] libnvdimm/of_pmem: Add check and kfree for kstrdup
Message-ID: <6491ce14cc4b4_483a29487@iweiny-mobl.notmuch>
References: <20230619033623.11044-1-jiasheng@iscas.ac.cn>
 <6491ad03658ff_28e7294a5@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6491ad03658ff_28e7294a5@iweiny-mobl.notmuch>
X-ClientProxiedBy: BYAPR06CA0065.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::42) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN2PR11MB4678:EE_
X-MS-Office365-Filtering-Correlation-Id: 584af83c-0381-42d0-23a1-08db71a80f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OpGtuTotljhMKBVShF477ED82vhYB5V+tbAk4C8Zu4L8ttsshF2r7BRwywlwR0BzMg7z0aAPADQyQ+TzmclqhrxcRwKagujf4HijkGYxNQbTkytOArgWiy2p6ifxCU5QFgDAu7F9g5SA9SRUVu0oueH1GYr8Y2vl/m/5GModar2FtAcVtEir53X0kKEpQcOk28Fodd7qN7VtvCHOHa6cj5g9Jy+So1bKB1OMuGLezZhvPq3nfIXz4JDZjkAlASuY4yVFp76hWLoa8Kb8i9cV2NZKGjU5PNWcOQXc3FBIG6CbtCUfj/NPd6PBIeuWywtJNLR+g/bzR0uojXPUiYItScXqT6O8nNgwPguUlQrRn8GAJ1QpW2s7s5DCJRm4z7WAWVCxlWPDcK5InJjYAlXszJzJPM6qV9XoAlM5AmiDCtPb4BgnrGG7g9dvLkhkkyQMySQe+j9+acpskR4cmHc8NpLPZUyTFnBHIvLIwOl3sssC/t1+JjtuhCkOtXcJDEJ+9MrRl6SOfr3PJwcNpfPHIYBXTXtprxQNuM4D99DVSAqmbjuAajM/pvsfPh6eY7PV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199021)(6486002)(478600001)(6666004)(83380400001)(110136005)(6512007)(26005)(6506007)(186003)(2906002)(9686003)(5660300002)(44832011)(38100700002)(66946007)(82960400001)(4326008)(316002)(8936002)(8676002)(41300700001)(86362001)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Y9gU8yFFOqWziYgs6NUcgiUnXWL0OJZtemI0IDQyzjVVDIdI2awTO28O1Oh?=
 =?us-ascii?Q?eQHIlzCMFC1dwDRIHkr16ua+76wNMtm5LLYKSfRlHRSvzpb6LT0rrNT7cBeG?=
 =?us-ascii?Q?5CzrLMqqPsjYhx69LdauuaGkdv1eDzK26DJeiyy5AILxm8H7HMt9fV4F/e7o?=
 =?us-ascii?Q?9dI6Dk1UzROYCs/HnXoYqlI1VBw5pESrbBNe31gTbNDCbp50r0rCsUHeHyBV?=
 =?us-ascii?Q?WY9yEEH9QkV5DECOVu8OHEnehMR1jIANooZgXSE/wlfN59lAmWXoY5R88QHC?=
 =?us-ascii?Q?z7Stq0ImHgmgF5CS6CD0fK5kaE3MUKUGUuLbFTUb2/14keZNS/C+J75dgs3h?=
 =?us-ascii?Q?1QfXfeYSZZXqG53WbwYPK+vgcPQyENvmF/B/m4Qczgoho/n3IhHaIC1CeGlf?=
 =?us-ascii?Q?y8SWDdBAHlKhvuz27gI8CWzdCWgGJ+TNf/2JB1MEeeTKMG/xfCo2JVgczrWs?=
 =?us-ascii?Q?NUNAqQPshtwDSzhzA/OJfY7/MQD3TOE2v6P+NyElN/91LEdtKvJ7WxeIOjzW?=
 =?us-ascii?Q?ntTGMfPD9/jyG5qSZERzy35wFmriecFEVA3u5JSzgU/+T41C+1LdQu8I6Jw6?=
 =?us-ascii?Q?LS7jBd/EmvjhFubct4GaDNQfBNEI975PYt5uohKmYKuff+TJdSc2yBuXW9pZ?=
 =?us-ascii?Q?RVZ8j9ffNlB8tdDU+PnG7xtW8rPN+6lrIp1Q+6xLqLXrchJZpeWdJzeALjr+?=
 =?us-ascii?Q?nDS+XMSgJZ3AQCxYGHS0dSebDdXZIoDDkUUVbZcR4N03iHjM+xdg8E58J7JO?=
 =?us-ascii?Q?eaLs4xkSt20AIEgiHzOUt6Eb4XHx4EH8mpwKkRnmja45uUW5R0REfjwDEIYM?=
 =?us-ascii?Q?CvGT2uH1jFmKjOWA9Xn2fMEYQnDZ1ftHDQvPT77jZBycDln6uOyBD0q6usC/?=
 =?us-ascii?Q?ti61tjylFHS4Ey5dvHBkSKct3nG4QH7SnD0IxoKvEStOvPbHI+dfla4tJxR3?=
 =?us-ascii?Q?AyGdzx3UvvDJfd2C0qtJn1GaeCaxVkGr71284tDzSZTmwa6mznqRBIMjMo+w?=
 =?us-ascii?Q?gNObhlHt7mj5F4h8iP7up3D2djwfO5MJnOxeRDBB+SmdB6Z32UWN/9FVF86W?=
 =?us-ascii?Q?7AtxNXfUmgAVpmdH/xoWx/DEp8yB9u0fJ9qZEBIamqCkl0vVYpildgg81dl0?=
 =?us-ascii?Q?zWuDjueGnTdsOrwfIN+eviFmaX7aAQBZiRbAUg6mvp/xlh5llh00AL0jXa65?=
 =?us-ascii?Q?ZuOdBkZIxicOezV/yzwqT1jrWCY3HMNRQ9qbyBJojNNTOu2TpeTYbCUkl8Lp?=
 =?us-ascii?Q?+4NMvvJORn7GnLUEniMTgkgKF4iwVLUJ1kVwPVweCS2+vyFgdVoTd+4uWeL5?=
 =?us-ascii?Q?m7mpzonZZgho7AL2KyEOFrtAXdYEGyh0zAFZM7l21opOgdBE/gcXM+R+s+jf?=
 =?us-ascii?Q?ktB/UXYng+BEKsWqa81Chx1JRYvvOd7aYzAQ7rAae3UNSrhnbuhZ8zJQnOQc?=
 =?us-ascii?Q?6LXUv5imumtSR/XFtSCRiFXqFcSV9na1QKwbFBuLArPuJ0DPAAO3JRmUeT2u?=
 =?us-ascii?Q?g6soWvAYQIx/sFpQNGc1u4Yc/vgVBqokXmGwgUkk1WhCZWCocLbmYzS/rklI?=
 =?us-ascii?Q?SQgZoBy6XRsU7LH/OiTUNc8WfDqXRrl1gfuHD2Ib?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 584af83c-0381-42d0-23a1-08db71a80f49
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 16:04:43.3343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzSXX6wy9JKFKb2dJ4IlF2jdLP5C5LhRvNkim1wOlmhsCUZng18Ej7Lc/5G4nQRKNgyfnSmLubtafeQdPnuOkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4678
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ira Weiny wrote:
> Jiasheng Jiang wrote:
> > Add check for the return value of kstrdup() and return the error
> > if it fails in order to avoid NULL pointer dereference.
> > Moreover, use kfree() in the later error handling in order to avoid
> > memory leak.
> > 
> > Fixes: 49bddc73d15c ("libnvdimm/of_pmem: Provide a unique name for bus provider")
> > Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> > ---
> >  drivers/nvdimm/of_pmem.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> > index 10dbdcdfb9ce..fe6edb7e6631 100644
> > --- a/drivers/nvdimm/of_pmem.c
> > +++ b/drivers/nvdimm/of_pmem.c
> > @@ -31,11 +31,17 @@ static int of_pmem_region_probe(struct platform_device *pdev)
> >  		return -ENOMEM;
> >  
> >  	priv->bus_desc.provider_name = kstrdup(pdev->name, GFP_KERNEL);
> > +	if (!priv->bus_desc.provider_name) {
> > +		kfree(priv);
> > +		return -ENOMEM;
> > +	}
> > +
> >  	priv->bus_desc.module = THIS_MODULE;
> >  	priv->bus_desc.of_node = np;
> >  
> >  	priv->bus = bus = nvdimm_bus_register(&pdev->dev, &priv->bus_desc);
> >  	if (!bus) {
> > +		kfree(priv->bus_desc.provider_name);
> 
> Nice catch!
> 
> However, this free needs to happen in of_pmem_region_remove() as well.

Looks like the mail from my phone had html in it.  Sorry for that.

This would be better with devm_kstrdup() and then we don't have to worry
about the kfree at all.

Ira
