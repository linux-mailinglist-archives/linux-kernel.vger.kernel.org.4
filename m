Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088D9708CE6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjESA1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjESA1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:27:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0D710EC;
        Thu, 18 May 2023 17:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684456058; x=1715992058;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2r0mhdVwN89L4mi7HpKDYGgnlzELYqS+D23TJeQKCiM=;
  b=TUljwNMrb0n2L+mWZkj/0PIt259I0HguWok01X+tdssBmcvbb3Cftula
   hfg4eLvx3sX2cyow8hLMOOSBSTctGIlqo/TIX136jDsLGuYRzAaV6XxBZ
   CY2OfRwHi+raQ9p7nbOQtX6VDsFSJNwsAcrz+68BniWXdfUekuHzdVPmG
   I+E8V4CSYKaIRoc2MGoVWA3VFzhy/sbyxbukl5ETsWlDQHlRvKY21lia5
   3Me7mDCs597Bo8fAceTKmlZDoyyAUKmu7luZnTXxQXLq7x8bvJA2SL01k
   7eJaaChNZXl7M2gyQAfuwOa0i6yi0NEkxdyPLeTBQ9x+QIxq8zyiAHLPK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="351072544"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="351072544"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 17:27:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="846685171"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="846685171"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 18 May 2023 17:27:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 17:27:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 17:27:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 17:27:37 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 17:27:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btOdo7Xmjc5+JvmfHfxbGkWcnv2Z0J2SgzBBY56vBznxCfauSzV/PZkiiWRLdzDSfdSq4Y0QIPBxgZ0H1FG2CwtguzRIhaG36ql4aMz8dcb267Hjw0pdkNA6vzIX2GsQxHystpy9BtEwRNoiT5mW8h+0jKa2TPhuznF4KrzoyOdpIQHYdjGQS7lyJhvuqWLE5BTTeAcOCZEpV5MOqCCziIw7DHKKoplkgHEFln9QBAcXpJ6Pz9V/BONRDU5t+cgJ9JuZ7FsJneEq/6lLx144DIYMkR/3gIJ1ZdevqZ/jztgjE3Z9LlA0Stq0vBF5OsEx94e5mXY56+eFQ17z0nY1RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7FwNStXHxjOudfFSuag1ecBsiZhg2HoAUmFPLJPxy0=;
 b=gMyHpH9n98ttsbUqXVBl8JzFC+Vfl1K1wvYG7gKeZfx9H6SAAVMs+HgN+RJZec8sbFC470m8TPAzszbzDLWynP6C71sHprJqCml2QlkwF2+W3ZBFpQELFyiFA5+8lWIb7tKklJyZSGTYWO+GGIhjtkKP128GmqasoB5XlpqmL36hiAusallL82SKXNslS8ehuRzEP8dnFaTyM1myTvmOWoJT7y4Nw8tQBuCPEevdA9KL9u0VAREh+sKDZdYDoV76GzDx8LchQN2pzcZ17JH9cpYa44FVnPN9UEiYK1yG48F7VZfJlcMRrSTrQHjfXp3VV7foLeCjPrgDQ6pPYhNQ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4694.namprd11.prod.outlook.com (2603:10b6:208:266::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 00:27:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.017; Fri, 19 May 2023
 00:27:34 +0000
Date:   Thu, 18 May 2023 17:27:30 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jane Chu <jane.chu@oracle.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Gregory Price <gregory.price@memverge.com>,
        <nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ira.weiny@intel.com>
Subject: RE: [PATCH] dax: fix missing-prototype warnings
Message-ID: <6466c272e944c_682c129459@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230517125532.931157-1-arnd@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230517125532.931157-1-arnd@kernel.org>
X-ClientProxiedBy: BY5PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:a03:180::49) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4694:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f4360d5-9a7e-4bb9-f681-08db57ffd68e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qcyPoSZ+0TOck4KnVAYE6iNjrn4vOL6lUeZ9pbziuIW/4vDqxeyifF0DgZ9ocfVnB0PVcNKY5HEb3PdQMYRN4FgGofDIpKrbxKh0GP4/p0dqKyiJcY+4me35hvyI6G6cgTIDYqyzqwzE7xt/I7+CtbPpP5+V7Y+HaEGtO8V+Qraomck0yRc64/9to1juAZivwavyPYEPsM0WnjsfOKF7goJbFjhkXAVjWwnMkfAWY81nXLW4R3cBZ0+v1cY1HRxthSPJMahgyg2iInoShko3nwny0dM4Yvv1mOAp5bBa03d/dXdkfa9jQyPR03rwXKm5oMDiG998CILAnlPVLPsW/KL6muhZDpdXtZU/Shnm9HgKF2qRmB0uH0UOS9+t07HPG5qX4iL/eSIkW1GWIgTC0H9mq0/GeQFmy8ozbViPJnktzrqWnfWWNd7p73aqvU6ls0CTp6fOG5WFtnP1XtjnEZfa/XB+PzVU8afYe2k9lOEqc15WQiR497FFq0F5tSrkHri9RmfU69V3631Ws94Th0fSp2/KB67T3UUkA1sUx4s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(966005)(478600001)(6666004)(6486002)(54906003)(9686003)(26005)(6512007)(6506007)(110136005)(186003)(2906002)(5660300002)(8676002)(8936002)(82960400001)(38100700002)(4326008)(66476007)(316002)(66946007)(66556008)(86362001)(41300700001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zh5N2nfOrz+ejl3Pr3d89+W5pZfqpF1GwfhHB8274RdZDbtrzrwHJKUndl9H?=
 =?us-ascii?Q?Jmxs/IDEinkUumSYImmMz/pffnfSFM/Sec+kT68lzXy4bKbkGt6qN2TkZVOr?=
 =?us-ascii?Q?JjKbg3zS5kQVD8/OOon2HwqiepbfIwvSgP2qhyIDDeRuidSE8kcrvWt34PZ6?=
 =?us-ascii?Q?dz/rhmNyx5JScM0dIID5fXhbiXOQupO9xeG46VHVi20Q443hjaQ1NAHHLx3v?=
 =?us-ascii?Q?VJcG3CtKFXJ8CP9erFkWNdZngKhePnY7zdnF8egFYsE1012xic3UPSmHcHLH?=
 =?us-ascii?Q?XXoLlqfpopMR1ALPpUnk436l6+0ttV1px1ahcIvHvXNRbqjFSJ/oxhtZtAtT?=
 =?us-ascii?Q?kJa+BNsMlkBJr5m89EF76JHfLVuBBNrczYX4tKa736Y0iUoj4G3JWCrFiCo1?=
 =?us-ascii?Q?GYkoB1cxMdEXOVKOD1VRoNRnRELJzU4xpT8dlABOpSmb7GG6Clpc927dsYXF?=
 =?us-ascii?Q?bluiIdMN+FUTVLLmw5p8JmzNavgSy8o1InjNEyJlNhSDkTIyOGZal1lbgCnH?=
 =?us-ascii?Q?Ty6u6JPx2J/6w6ChW0HVKSwIuA/qSKIcnrC50tViBS6qqfH38nsHH/xvNCrm?=
 =?us-ascii?Q?7FJbFIyvEG0aonC9sEbc9vAtMTFwsiatrYSn8PawtOVg2iQ4Ih1x23QBOwRs?=
 =?us-ascii?Q?JI94DIb1t2xdPw5+h6htFbS5iX1kxIeTTUgQ+xTV0rT3+HfflknFoyWUHINX?=
 =?us-ascii?Q?pWm05S2cbWvnHEJqvFx3tvJLIGqNUkIK3l7pNjkneKILLGVGjcKp0q6d7dGN?=
 =?us-ascii?Q?ISnEX8MUwkl4ldB2ayqegh38C1tnm1EjyTOyLzkHR7QxetiE+eyTGJkKgSLB?=
 =?us-ascii?Q?7CuYLrfJceDyKBCzoBiPjfum4nUsewxPFtQv/EzAQCXjMBuzQQNa303UFnEf?=
 =?us-ascii?Q?ppdyRrGNvBIfBar4vHuZdUnesWN9AKa1fZDiuygaEYpXDO6x2Uh0UqqdMvCk?=
 =?us-ascii?Q?UeX4lu+YQDGhHW19rxBctSgzaAShJv4wc/KIYDjOe7PZv7C/mEi/u/dnH5fw?=
 =?us-ascii?Q?rBaBI0w88Dpu57gORVrziLai+u0ij9UOE6+Xh9QbohTBnCrqHM725OoSmae6?=
 =?us-ascii?Q?+Nz3L3to4C6cnBoAI3jQOuQ/qmfxiytwSiHUd4w5RiBI0GnBvvS5RD5Ps2VL?=
 =?us-ascii?Q?iG6NXXr5Ln1gq7V7o38LTy+l5YkCmvPOYusI73RklZ+Tlm2eV7rtMHhLuAle?=
 =?us-ascii?Q?E0Qbk8JPkAjB19j0Y4JWfuBVRidmnZvASllVYkguUrKGTu81uCZdyThjoAJx?=
 =?us-ascii?Q?kkj5gtSR1nWfHBGzMKyC2X+V0Lj8dORaI6sSWxpOqBq2bKlQxCIftYIJrADe?=
 =?us-ascii?Q?hbI08Y8BHYjcVKc5HkdcQi6UYIlQIc39dOAUfJucc//bsGhV38BjIqJ2FoUU?=
 =?us-ascii?Q?K5xl1gehk5inNRRfyg9CvfcK5jzDLol6x32SXKdLzcrRQ4d1eRK1ObRN5Tkf?=
 =?us-ascii?Q?N/iYrPm25ln9bav9y29jcZ0IhiIgiFQaDETOoeQgVITGmrwE5kreYc8xQQiS?=
 =?us-ascii?Q?ovZ0hFH1lC95U9a+2BNxXOmLqp3fZ5lknDJx+mfqqGtrvXwQ9ryyjg7ldlcA?=
 =?us-ascii?Q?e1lBGGjU2BggcyUVfszEYti2AxL+h3KBLkHHTf5s8QXrpcq9pbkpD/c6SjGY?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4360d5-9a7e-4bb9-f681-08db57ffd68e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 00:27:33.7085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BhK6c6TZEvqPvcqXSS4a3K6wRk9H+NbEXeVsYTdmz9u3Q9DmcC///0uNVDGyrQaQCfZRYW3S11Q+UvSSgySPFgzMEA+iHbOaMEcB0LDpxvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4694
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

Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> dev_dax_probe declaration for this function was removed with the only
> caller outside of device.c. Mark it static to avoid a W=1
> warning:
> drivers/dax/device.c:399:5: error: no previous prototype for 'dev_dax_probe'
> 
> Similarly, run_dax() causes a warning, but this one is because the
> declaration needs to be included:
> 
> drivers/dax/super.c:337:6: error: no previous prototype for 'run_dax'
> 
> Fixes: 83762cb5c7c4 ("dax: Kill DEV_DAX_PMEM_COMPAT")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

> ---
>  drivers/dax/device.c | 3 +--
>  drivers/dax/super.c  | 1 +
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> index af9930c03c9c..30665a3ff6ea 100644
> --- a/drivers/dax/device.c
> +++ b/drivers/dax/device.c
> @@ -396,7 +396,7 @@ static void dev_dax_kill(void *dev_dax)
>  	kill_dev_dax(dev_dax);
>  }
>  
> -int dev_dax_probe(struct dev_dax *dev_dax)
> +static int dev_dax_probe(struct dev_dax *dev_dax)
>  {
>  	struct dax_device *dax_dev = dev_dax->dax_dev;
>  	struct device *dev = &dev_dax->dev;
> @@ -471,7 +471,6 @@ int dev_dax_probe(struct dev_dax *dev_dax)
>  	run_dax(dax_dev);
>  	return devm_add_action_or_reset(dev, dev_dax_kill, dev_dax);
>  }
> -EXPORT_SYMBOL_GPL(dev_dax_probe);
>  
>  static struct dax_device_driver device_dax_driver = {
>  	.probe = dev_dax_probe,

This hunk looks good.

> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index c4c4728a36e4..8c05dae19bfe 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -14,6 +14,7 @@
>  #include <linux/dax.h>
>  #include <linux/fs.h>
>  #include "dax-private.h"
> +#include "bus.h"

This one came up before, and IIRC last time I said lets just move the run_dax()
prototype to dax-private.h.

https://lore.kernel.org/all/YiqF1a9VNiSWI5j0@iweiny-desk3

I can fix that up when applying.
