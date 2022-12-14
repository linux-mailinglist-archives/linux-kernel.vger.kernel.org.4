Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4794164D375
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 00:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiLNX36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 18:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiLNX32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 18:29:28 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4EC50D55;
        Wed, 14 Dec 2022 15:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671060486; x=1702596486;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cYneVxJ3PDqNRoBAXGDupkxaG/ytABcZpr39Ky2NOdY=;
  b=FfCt1SwrpP3zTNVy71Z3SwLYdYaUOw13jqAGGoEy7CavG9eeDe1+gZ9e
   wgBetCK5wgAbxiLLg9j6S2lL5QxWDb737F1zGEQ/KXuNnn8Vk77lyA3Z8
   o5hKKXFTdbOtIDUoPrgMTa6iPwwfGf7LWUx0te22TyuLFL4gIeolg93SC
   YTqsS2mkCaDNsmyNWnzpFoVebAUuV1STPgJnad5T+bJQzOiMIGcHhIJEk
   MK3b6WFS37B4fddhWlyNl1Q9xwndlHmm/8iH+D92WyyVJmoVAovE5c6ZL
   3wqg2/MZMkfmQxbtUsqZ2BOhSk7J1hmBqugoA9WbLIZW4gcF40Qpx4gq4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="320393794"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="320393794"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 15:27:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="649189961"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="649189961"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 14 Dec 2022 15:27:57 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 14 Dec 2022 15:27:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 14 Dec 2022 15:27:56 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 14 Dec 2022 15:27:56 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 14 Dec 2022 15:27:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXaHR2eSe/5Bb7rBCoDD7jLRl7I4QXWSyHhWjaLz/A5mcR23pSsPKXVe/eIGhpYNpQnUNfCntJH2JdjGYrhQno8NrgYOIQOC3RA4TLZPJtdyj07ojs1stvkfVC/L/YrdHFhHmfYtkO+5hQHJAtSbrzM4XkRDlMxMJLkLeSoa4E9/qrCzaoQXqvh0NP5rwCF98CniDUeyzG3qvue32RlksO/zqax12q3DU09tUAnPxoI36exDb6veiTxL37xPjdhV27aSUDOzGacifaSDCHlExan9tpZ908BKmCDERSTPptXo0PeBDd2Px5H7yuNZenNABSGdQ8W5F0qODoDPrPleSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIBLTbWyS1W8iDSy2N1uFq5R8TtSPUJbQgDLtH9mTMg=;
 b=MBJtnutYX5h1/PzQ9lvBzJzk9eNoBMNb5EErX29rflbed+gLFA763kSwA0J1WOPT8RXjrQBlQfjql7W1QbuDmsdCQOKgIKHKsQAZkjZx3cwGqM+zUGOgkIR39SW97Gj2+fdMT10AwFgj/tmxqM38Rzea1U7InoQzTro8w7XwwVZK3DGezabItfDmb3mBQUsOoJbhgjQjkhu+sIPk5pUoBPdtrfi9Aw3sW9s4Ai2FCl+cFlakqHOmGJCxBIDjTvQsZ5t+8pgr6vVevLeIGVPOxB5f6jFw8qw5O9/v/DaiPF+j+2VBQQ+DTfukuQWZQapPNmQDUjSKVhoBOZ2hTthb9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN7PR11MB6797.namprd11.prod.outlook.com
 (2603:10b6:806:263::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 23:27:54 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5924.011; Wed, 14 Dec 2022
 23:27:54 +0000
Date:   Wed, 14 Dec 2022 15:27:51 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, <masahiroy@kernel.org>,
        <nathan@kernel.org>, <ndesaulniers@google.com>,
        <nicolas@fjasle.eu>, <linux-kbuild@vger.kernel.org>,
        <alison.schofield@intel.com>, <dan.j.williams@intel.com>
CC:     <dave@stgolabs.net>, <a.manzanares@samsung.com>,
        <mcgrof@kernel.org>, <lucas.de.marchi@gmail.com>,
        <linux-cxl@vger.kernel.org>, <linux-modules@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] kbuild: Modify default INSTALL_MOD_DIR from extra to
 updates
Message-ID: <639a5bf779bad_b05d1294ee@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221214231718.1002194-1-mcgrof@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221214231718.1002194-1-mcgrof@kernel.org>
X-ClientProxiedBy: BY5PR16CA0007.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::20) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SN7PR11MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 1feefd96-377a-45b4-895e-08dade2ad341
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9RqA2Q5j3nuuS3VabE0T1mpZWvZlcTUNa709ltD+9Sllvo17oxBxuA6i/bL2H2MXQ9FCx5IZQk4WKaV52Ym5kdQOiBA4jZti/VvIuR/lJeMWTbs7UxADBp9T3WUDAjnz67awHqaRkaB4sH8EaiLWxW8uBRKANPBhTe6FiihBzzAO1m/EjY9fTMcobAhsQPrGObsDr8z2rHaNTYAxByUQp4IcUM7iE5DtKqMWLZHIAOPzKfV4uwbVnFrDf5UJ0f+a9SM96PV1/NQkVekp3jw2qNWa4Tqi9kFCkAUVEX3KkSQyAXVOBVBFzs4tNVWt/5G0DomGmlApYJ+sjnK7rrKdSO4AVK3kbTZtEEYck3H/syxqdmRa1XV1MJi1OHz/BJ1jTD6htAMTE7mkQPxygEJjn7jkwxRwXnVfjxmaI8t399A+i2i8XTrcwLWleOKM18m9tiaTjaPx7kxty8Z4RWMJYIac9KJCxwt83fk3OTfiFRwoyj885QitfD0NslRjMYEEYiyPAuGxyn/QrmWHAhtEyh1AmHkManYLvjxsYqR8TJlKKzmExTqIgh7nRVG1tN+YoAous0CIEvmcosTWf1YdeoCmsByFbhloGSrFby1WuZzNiZ+xwTEAoBvxZS2nfGcBRUw6D1ZFS1vgkMzQ0FChHHaCd/WYTawYSk27qvsX124=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199015)(38100700002)(82960400001)(86362001)(5660300002)(478600001)(7416002)(15650500001)(6486002)(41300700001)(6666004)(966005)(6506007)(66476007)(8936002)(66946007)(4326008)(83380400001)(316002)(186003)(26005)(6512007)(9686003)(66556008)(8676002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?twJoLNqjUMIOBl+rdp3tb5ZAeTS5D0JvLRYLjqruDKFCgvHk4+ck2fJEV4kB?=
 =?us-ascii?Q?mIX9lsRoJtGhE5fA8OPDZOUuvGqZuil1rGnGcNIZ1YBe+gdXLjOcU2fD58H8?=
 =?us-ascii?Q?/ZWTHdb+C1Qvos0/4za9IoX/o7SCjTD7NGhd2dLZ+OHbPQVHC9sVbxfDRuU6?=
 =?us-ascii?Q?nJRbDbYQ1Vzaza1WZfODnyZoierKymYJOdI0IYwlu+jSFViol7v6tpshXTm/?=
 =?us-ascii?Q?OPyezQaTEDQmuktb9jaxcZrmme6qvVXddk+tF1v1mauKfZVNStHbJ2NSCs+G?=
 =?us-ascii?Q?6bZB7AAvXuo3VG9NeKbXc8bUCGCp9f8r8ROLU1FlxDcDgQcI3mf2dngtYEKM?=
 =?us-ascii?Q?WthBA7zTqL0gRdL5lshlMx6W83Kv3PN+4cnmwgLoXcGepeo/vY+U+v2uhpq0?=
 =?us-ascii?Q?ZtZ/0wo/opu0FSi/jSW7OIksmJiZMd1Jrg6y9v41ICQVhq9bxmrqOM2Q+kr7?=
 =?us-ascii?Q?vmZ+WQo89Dbh2Ne+IzyTu5tUlqoBTcu/VW4GG7UfdkHwwlSO495QlJ1HtA4R?=
 =?us-ascii?Q?eu9fP41XDezgTzMQPgRoXylHjI2UYgkg+2vmVp7qyQnYq1pUXZv/E+CFx2nJ?=
 =?us-ascii?Q?TgSImCpdBloN+FdqWqifh8mb5hMXm1TmgkrU/DYd+LbldX8fqoVsoTL5kqR3?=
 =?us-ascii?Q?nS3GFFBFa0+f8q0vSbYfwd63Q+MefezXLpXXSoqnVTEmiEmOO9d6ZZ/EvU/Q?=
 =?us-ascii?Q?efUn798sEhds+D3DnfXU7+igFaYmTduDB/pt0cJp5K/SA4aKqqbZF/Tlw4/3?=
 =?us-ascii?Q?9Gg4Md8bRTrfH8IgliQ76lHJC2cxu0KF965R/qgVNd1pi7WN+/3+Y1P3g8D5?=
 =?us-ascii?Q?sJmWUY1kz52rpkUuXv+C8MEvn51P/zd2nS5mgLnvdgrcYiGIUp+uawHV9/vL?=
 =?us-ascii?Q?jYbOCGF/fLYzy/YSgGjuXrDNDhKQD3Oa9lAGbwFkQfDsBjUoXSYSgCAGMvZG?=
 =?us-ascii?Q?jwNetZgptWDFmtqXqyYndtzKETF8yN9LfedznGt7b8Husp4sARdiEA0gn3Gu?=
 =?us-ascii?Q?3W46Bvi2GQVz05kjyfcQMYqf6cHlQiO16Od8nprNCwjfiBd+MR43NXZ7jUIk?=
 =?us-ascii?Q?9EgN7kJgjduZAvh2CenqM9L7tr7zAHuLVS0PIGS/0KaBcaxAUfwbL4o1H5Mf?=
 =?us-ascii?Q?yYQhjwGuRtHF3psaNRLKhEUh/TqYdHnp5LN/3pahUNFzq6pZxfa6/h2AFYGG?=
 =?us-ascii?Q?YfSl5WizYALkxiOS+5YQBwWLdhPXjJWxGWrGBcxZ8TXa1XDa/lOnG864uotC?=
 =?us-ascii?Q?QZL9S+vJpV0cHZrkn54mbDnvU0Z/+XQdAvEpfJmlI4S9z5StaoEg5UtPRHLk?=
 =?us-ascii?Q?jp/w6oVonbBYi57HO8yRaO0NRHwk1uum+Jk3HdBrN92fBeRO163OjWu+zeaJ?=
 =?us-ascii?Q?GUNUuXfwtwDg3kjaTtA1W6lA/LhxCxjgOeSho+iJgmsZVSqQdKFE3s1bnK8L?=
 =?us-ascii?Q?5ak4/FUhicsQSfa4h8YnokpuRCZ5Xs5oz/6+vShnCyoWvSiQiOl3D3MYi+Qy?=
 =?us-ascii?Q?QYSsp4p1URmv4b8o3t2sekgfSQhiYwbY+tyF9b2uYhdvH4yMQK7vdQpF2IXx?=
 =?us-ascii?Q?+iRZ8pHEdSsgvXkoA5wFEsCudI3OErLbqWIAyRFHTh63qHWDTS4rZsP/IhBf?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1feefd96-377a-45b4-895e-08dade2ad341
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 23:27:54.2189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4+R4erQWGDQtKQQ3CM/sm11Naa/UGwzMixXR4SDkEtR8HhT6dsUATpOmw69GcRGpZizXEBtUX9RCLeDcP46XzikkwXMUHq+K/3urxZUso4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6797
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Chamberlain wrote:
> The default INSTALL_MOD_DIR of using the /lib/modules/$(uname -r)/extra
> directory for external modules assumes distributions will have something
> like  /etc/depmod.d/dist.conf with:
> 
> search updates extra built-in
> 
> However, only some Red Hat release have and use the extra stuff for
> years now. Meanwhile, the depmod.c tool in kmod has *forever* used
> the "updates" directory as part of the search path by default *if*
> your distribution does not have any depmod.d configuration.
> 
> If you compile and install an external module today, even upstream
> kernel mock drivers (tools/testing/cxl) the modules_install target
> will pick up the new drivers but will not allow override of drivers
> from updates to override built-in ones.
> 
> Since module-init-tools was deprecated over 11 years ago and now kmod
> has since its inception used the "updates" directory as part of its
> default search path to allow overrides, and since the "extra" stuff
> was in practice only used by Red Hat stuff, use the more distro
> agnostic override path "updates" to allow external modules to
> also override proper production kernel modules.
> 
> This would allow mocking drivers tools to not have to muck with
> depmod.d config files or assume that your distro will have extra
> on a configuration file over built-in.
> 
> With today's default you end up actually *crashing* Linux when
> trying to load cxl_test with the default "extra" [0] directory being
> used. This fixes that and allows other mocking drivers to do
> less work.
> 
> [0] https://lkml.kernel.org/r/20221209062919.1096779-1-mcgrof@kernel.org
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Thanks for digging into the history here Luis!

Acked-by: Dan Williams <dan.j.williams@intel.com>
