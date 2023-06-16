Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A197337CF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjFPSAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjFPSAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:00:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB71A2D50
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686938406; x=1718474406;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=G2fDUaJNSGKkHbzDiO26vL8GJ1H6hbTywBCiVe1M9Xg=;
  b=kQdzyMiB3rGFfCottq9UnOtCwKNXtJ2SeMlM2ANoeKvXixV4mtJGaMCA
   7FWqr1MaskSKC0tQDwsR4AuH/L0v6Ni7yMxRMRJ9F6kOpQR231/FQbDk/
   QnTgF2lkHKoLGCtxOQ8ji0NGF6C4fOddi6RjXzk/8VlR9h8yIAV3wUryU
   /58p5On0XeoC0hxPtpmDUwhE/XbLzdx44vSlsRH5kc3/WQ87wmqwkc0vt
   VOs7QuS4YwIncz/58NboDHi1LDwRJk7sx4gDJ2Y0m66H3r5HZchtL4DHB
   Hx1PTvxkJax4KIy4/f3ETenGK6QiS6jIy57hYp3Suct3Fo3VWR0udgJKJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="425214463"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="425214463"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 11:00:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="959706818"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="959706818"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jun 2023 11:00:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 11:00:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 11:00:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 16 Jun 2023 11:00:01 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 16 Jun 2023 11:00:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKflCM9DhirYwf273JbLW5gSuuz7PrzkqwYkVcS7pG7/3ORxz2Qqwm4iIU5ZuOGerVYSEPUPb3uejcpJO6/lOQINR9eeelEEwnit6vz9ncj2cs11fuMkjSAnTjr3pHoa2fYnQ2OI3ZGbGLTBDtXcTTueIa7SihM09uefnB+cpflwyEWFzvFhmx5RW5/wLwBb8mEGnfoWT2fOS3YGMxGHSGdilK7BSzQu7Z0QFo6iEHB7h80STrD+goIr2s64bunqwK/H4tp7xs4XB6AlxZywJj5oXqBhQPJ/CahO+e60PKSlz8UnJ8AixVJxaIvJVVd/IcIWT4jVA5EWd34xggB+ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Loqekexzc3nOqPVD1krr6Qp5yqp0+dQxfeMZG5PxtQk=;
 b=P6MSaVYm1ZkztBTDRDrTjXHTjIbVNR0Y+8u2VrRs9ysyMUnVcEY/5WEcH1o+TMIG6JZAhFzJPTslmnlRcjJMnZ6tqUSUm+GCMgRCFNbnMdJmGmRPHko/7XMJ1yZaHeyxvCjAAqkW9XeycVLWMqorOR9DLypbmXN/sPaftV+BRaP6efEYQDngdTlHKCLUNHxmuSIE0+qJmQoDurZW72V1ZfmMqS2FlHhnqZLkxWhEngObk2Pk2WurEQD/f2/FWB44vH961GKgJ2HOEfEmg/I+Bu4Zcq29RuivfgVx109VqNZMGp70bgoHBH47N0RbrIWV4LsigVAorRf6hcSbG0i1Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ2PR11MB7425.namprd11.prod.outlook.com (2603:10b6:a03:4c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Fri, 16 Jun
 2023 17:59:58 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 17:59:58 +0000
Date:   Fri, 16 Jun 2023 10:59:53 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>, <nvdimm@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH] nvdimm: make nd_class variable static
Message-ID: <648ca319ba772_1da39e2948@iweiny-mobl.notmuch>
References: <20230616160628.11801-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230616160628.11801-1-ben.dooks@codethink.co.uk>
X-ClientProxiedBy: SJ0PR13CA0067.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::12) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ2PR11MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: ea59fdf8-d735-4a32-a4b1-08db6e937faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9OSClwINydHcqn1404I/b276nfK2oas9jTbvK7grtBt+vMDh82yhT48XKNQqtgq2U9iVA0QY1MM9uapJTdFR3xH4v6qKEERC6Aw1Xz0iFBbCRK+E//xq+sPKZIR5/NlAB5gYd1kH6INAIJ/q6cYEJHwfqqHzD3Y7l5wH54jHKFIuHDXmS/lEhBwLwOsS3gLeknHkndILwKw0mLXAtyRLTvRVt+mn58sTGZCC2n7BBfJMjHt8VpwKbk9cEuyOe/u/l/6m2W4AQ5T2gBl4X85UXZCpw26T1D+DFeEKkR2OeGP9YQulEfepqinfHDrpwhtwbJZ+oMw62reQqvV1af62Gn8j4ofAdWoB18c+SyP3XREGeuJ93rsqlIC6y+wnMwg8SqpXqQVOqagTj/VeaU+KE8E1GYUjBrXrfLBVmqNTpUeRwhlkSnSEQeFux99e0wK0uAnrleknmYNSmx9IIUaTmNe6fPJks/vyP8C0iQDQoA/acSFxuKokTE4Y5D6pEOluEvLJ2Xghtybv2KBrnAFPf1lwTWk4iRVRF5AqPohXK/dpLRHRCNH1VE7EtkCqnAwc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(86362001)(66476007)(66556008)(478600001)(316002)(66946007)(6666004)(4326008)(41300700001)(44832011)(4744005)(8676002)(2906002)(5660300002)(8936002)(82960400001)(38100700002)(83380400001)(9686003)(186003)(6506007)(6512007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oaPaA1rhuKLzeUHr4bXUa/C5f6L5uU2mNCNpPPZxTICbylBHltQoIaVVGXMo?=
 =?us-ascii?Q?WIIOV/d2zNbCyts0QTo5D7cThiiXlSuUSZoywV3bKYxLSCwSU6phaGcQx844?=
 =?us-ascii?Q?MSv9S3IuvdmYxrQWzATZszJQL+YxjXFiZPMm8cL/7BmAqNPPZQqaR1Fe20gr?=
 =?us-ascii?Q?5jLvdre7v6G6rIQOdcs3bHWRFQuj5/eYyaSQSm3g6meF828Yx/WAc6TYNwez?=
 =?us-ascii?Q?IsTBHsuQQc0bcSqbVoUkYbBK4jmdpZU0Ti8RZ1f3bs8ZG7ssGb1Hr63MzCpR?=
 =?us-ascii?Q?Sb9YnkqHl54DareIIXe04bUY5bZMTPib70u1wrKBcCc5KrbX3RoPJcRCD1iu?=
 =?us-ascii?Q?gxcB3u4ETpO1urgVGdoxd609BecbM6HLohzyZnHJ0c9JY/iPYb3ULWx90ZZf?=
 =?us-ascii?Q?I/ZHxIR9E4mJrqUNJHRRfgVBw0Sn9h0GMaXEnCrhme/H3KgYFxhJ14enCbeP?=
 =?us-ascii?Q?9jdxf6vN9V23AyaOAUNNrbH/xjBMv3fH2CwFJmBUGOEAkhsMDsrzAOSGAspv?=
 =?us-ascii?Q?LZmJM0aVxaScFlGzncksBNHMgXQFXV3HGF/YiI6DQa7cgYs+VZgm02nfFH1n?=
 =?us-ascii?Q?4ckXNoNMPBJR54T1t+pz63ERmMmxYrCwxZSY/Mf051L9KoH7V/02s23dje39?=
 =?us-ascii?Q?pj2TofTQLeVu5WLoPTIo6q++ogKf5fNtji8/WZlwd1Z6/yZHlVEnYxvq8ldN?=
 =?us-ascii?Q?z1tRSrcETgHB6MSlywaxIQeBuMTo8K4aJ212K8Ld6y9JLGFyjq3mIIaNkhLx?=
 =?us-ascii?Q?kRiKApVfe1xb9c787RJ8WZeCprqEYW07v60bd3Yq2GXSM0LET66+t0E2knDs?=
 =?us-ascii?Q?3DmvJJpy/g3BVn0n68+QR7eT9IH1HP7H7LG1yKWRTzW1egZ95ypUFtE/DRmL?=
 =?us-ascii?Q?ZHLm+8+KGdo8M35KHt5ipXHgZ0Wl+YB5AMoM2QcgB5e08rkAQ4vFZ5bQWuUt?=
 =?us-ascii?Q?b4ZIs4T2ykg8NHp4TIHC5i4E7RFudS7iQ/YgdP3dtp+QmQmbDrVTjAm8RvS/?=
 =?us-ascii?Q?6TE0kKdzFRF5iUuOLh59qhTOxY81crtStQfkcwCUxoAf7QGmwO8M1FyQ/xwf?=
 =?us-ascii?Q?OAtuPgNJomedQmXh3qugcEqup3f/vhl7Y8H4vnYsbiHuBJz3PuC6140dI3kn?=
 =?us-ascii?Q?yddtEs6i96bjA/CkP6ENFwmgQqk1ZO86Y4z4iV3+WLU/98KXg3yROan1aif3?=
 =?us-ascii?Q?wxOo61DqTrNL7SFwC0RE3aP2mPz/QSPEWU7101AQgnZvAkxEts8gLlKavn0G?=
 =?us-ascii?Q?+1syorHARKXbySSKmSS0qaj3xWMwtHXEpdWJe/7+UQ9WV8lAFZmApp4yikll?=
 =?us-ascii?Q?rSfK9qLSnWbI+f7JXjtY+uQMnN253j6Ig7LUuoaDFkbCsSY8/ybE5VAJbkiC?=
 =?us-ascii?Q?7hiVjh8S0MR69fVZa266r7hzAqD3tERycfGs9XcMw4DipdhsFWdRDa/wcG1u?=
 =?us-ascii?Q?9SAPpJPwhy18MDX5A5I4qtH1EJKv521jYZP6SA3cqXaPfvFFVPHjaL41hhUc?=
 =?us-ascii?Q?cV9Bh7yJ2a+Zix5R9gdz8QIOAlBDq47twGD7CE/KfLqAGfreOIJJRVeKEV4n?=
 =?us-ascii?Q?VZpy/giho0c1m2HmSvA0AIGUL1t+v6fwwoO+7G5feW3QxhNSoUc6J86PzIXz?=
 =?us-ascii?Q?Rc6Dx9/USkLWhcoGZxTJw2MV8a7TRukRYlLj2cexTCcy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea59fdf8-d735-4a32-a4b1-08db6e937faf
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 17:59:58.5688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPOlADff7TdMplDDtYKYgn8SJXEhdaU4nkFeAlfWCy+FFzUyYBXICvZPKDMUCPkXso2xS7Ko7H/zeHMbkpxLtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7425
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

Ben Dooks wrote:
> The nd_class is not used outside of drivers/nvdimm/bus.c and thus sparse
> is generating the following warning. Remove this by making it static:
> 
> drivers/nvdimm/bus.c:28:14: warning: symbol 'nd_class' was not declared. Should it be static?
 
Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/nvdimm/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
> index 954dbc105fc8..5852fe290523 100644
> --- a/drivers/nvdimm/bus.c
> +++ b/drivers/nvdimm/bus.c
> @@ -25,7 +25,7 @@
>  
>  int nvdimm_major;
>  static int nvdimm_bus_major;
> -struct class *nd_class;
> +static struct class *nd_class;
>  static DEFINE_IDA(nd_ida);
>  
>  static int to_nd_device_type(const struct device *dev)
> -- 
> 2.39.2
> 


