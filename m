Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151565F01C8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 02:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiI3A3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 20:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiI3A3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 20:29:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18174201906
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 17:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664497749; x=1696033749;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=X14LvE4A941Myn9P5LDoWcf4flbZUR06AS1nI/clnFg=;
  b=XbwcG9/iIdtkLLak01VuqnxI6+esLK7yKeca+7pTmigRt0gyupnzxHi1
   NExu6iTGZZrfDhaALgDN6+SNYXMT/R10g4CahfpBWqJ9UoShs+TbZaRMa
   +cJe20fajyvdP1c37Z/QL7X9l4f2olI6ojEu38pQM/8CtJv1iI8pfXWZk
   LfiQMwMvfjHDMfvw0lirAfeGWSZ4HIxGMWa+7lK1tBAcCys8Uukqexxo9
   0YHGhhVdNbpdNYzBJ9ocqoy3qrwY104Ad1c8Nv53KeiSC88Sz0Hd6yyGw
   Q6CSi0krO/izjRby6+UYEK1uu2kk89+dAhViRwTv21oqHylELpzKFjdcN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="388341699"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="388341699"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 17:29:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691047845"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="691047845"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 29 Sep 2022 17:29:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 17:29:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 17:29:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 29 Sep 2022 17:29:08 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 29 Sep 2022 17:29:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNVeDrLUbpmB41kYD7mcWSYxxTZZO/gnsFUTbMnW6ZDztYmwYeLcDT/X0D6SOylO+uRN32idWMwo11VvHBFqd7rdwKOzAuI9kK1ITryka5qKOVexmWblGfPW+i158Yk9Mh5vEfvbpfNFzwL+TugTlaMGJdnK4nWzoea5mSYGdt/u6pQkeGE4AHNUmmD7TrZPMYKICgom0vfQMSrlN+t+CwxoKCkbiNg7FoX0iixKM1UQj7AASAcKUJTdHt+pwlmM0F6EtIQmsLtkfpJJX4tDLnUE6BeO33SELj76NUGifUCL6CmqYfr0Ue5iqkghzJsU+wIAevYrIPuUokhLJs4cLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X14LvE4A941Myn9P5LDoWcf4flbZUR06AS1nI/clnFg=;
 b=cYB40EUN5CcpJ6L5TH7Qy1GKzOsmNxgn1mJ20AUX6eUWIKeH6239mcXWrGJKc/1GOdaB0WF18DscSJogSeqvj9Yhgfsu0Z50wQeVcrPZW2IF96rtaxkX3e2VVPD/MW1TF25VbiHdzzYKhfoKG2wbRocFOsH0VwjASeVZcBytTKPZE24KH6Cmw0uy9VZiJW1K7jI3TolDNjsEfnwgQ/aLozlvrbl6kt32TcpSTQ54oxnkpq4zSRdWsdBS2/WueH8phVRvEArcUH45OvaDl598OKXfl4JgPyKuN7HxH91znlP7EbaDKCarFZlUTmxlbKHOP6a0iHz8IyHe1PyxzB89qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA2PR11MB5212.namprd11.prod.outlook.com
 (2603:10b6:806:114::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.18; Fri, 30 Sep
 2022 00:29:06 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5676.017; Fri, 30 Sep
 2022 00:29:06 +0000
Date:   Thu, 29 Sep 2022 17:29:03 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Bo Liu <liubo03@inspur.com>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>
CC:     <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: RE: [PATCH] dax: Remove usage of the deprecated ida_simple_xxx API
Message-ID: <6336384fcc803_795a629415@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220926012635.3205-1-liubo03@inspur.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220926012635.3205-1-liubo03@inspur.com>
X-ClientProxiedBy: BYAPR11CA0067.namprd11.prod.outlook.com
 (2603:10b6:a03:80::44) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SA2PR11MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: 3849a82c-e4b2-495b-d87d-08daa27ac8b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NkGi4vPwiMdO4tO5howgJ6sOrr5VBtUQ32O/fU57Er3kIKHa/MCYUmsTui14Fiu7QecmER6T79GnWf5aNM6oYqqLjGpe3SVS33FxuEl1UnkLMm+17GbQF6ygLSCWW/dwvQ3+LObaUFL2P1Ox0BFNl/t3tAREkP0tDzxA3Zixaeq/+dFbNpyMjdHtZ3r9iwDjfmsf7v/am6mOldlRyhevIrCzNQq8Kruqt28PyRvvJZjvqoOay7QV+A95Q0/t/RhF6gQ9HrQqKBWqnVMKTOCSE/VIPHsjhIn2Te01atXF4o2HFAMDSPT93WW6IDe84EKNmTTeuGYixcXOQBLf6NRGwltYQ6Zj0Pi4+TSDj6E0Yj58T+qiCjKta3vAzfc/rhq6cwz7Qb0bcgtLUmI6nKjEAfs65mWM/11dLmfLP7kGxcXJm6+74/5AGrbkq41PaPEsEV6MrY9V1l1Aev4qM5wlc3DZXCU1KtzoceINzDh4slO0l2qp4mn58WylpAbujEGRThiM34UXF7L0HCc69JK0xAPO+NfLu7m9yd5qVju8B5fwBlm02ywV4YM2ghup/Dc29PaWO1z4SNjvOcqdbhPM41i1MCPOB0ilfDiXYThcIwZp9aQGfMzcTR5PolL58PjLt1Gp2KcZQoaF8o3psXkRBMmwco20wjmSkeMgA8rvoVpIJ9F239u4g7+2+HWBUsor52mhoVrR5fMzpviMsivJd3FdLcjnpiOjp9gO+Zt7kknWnrmQ7yHq3WR0nNjHoloPFrDdwHN4cdNSFYDa2MprBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199015)(86362001)(8936002)(66556008)(66946007)(2906002)(41300700001)(4744005)(5660300002)(66476007)(8676002)(4326008)(82960400001)(6636002)(316002)(6486002)(38100700002)(9686003)(26005)(6512007)(478600001)(6506007)(6666004)(186003)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q9B+T8QijqRV3WqSym/q7aW++Lki9Zt/i36SkGaYYrKOPSZvdCfb5nOWG/O3?=
 =?us-ascii?Q?EIcA60v3Y/b85pcX9PZ0vl2tPzgjMDv9W+HNrTzLj5mLKHvghFIi1tDDPm+M?=
 =?us-ascii?Q?+JgDtwGut5PdaO9z8YcyDSnkCI4KiSCubWRdbB7xLV3YaVVZ455C75IKyYFG?=
 =?us-ascii?Q?LG9uAC9pljg72AU+s5E5XrZ1/bGXWkqQDrW3YLUs6bRUJnbQiww9dDX/WoG6?=
 =?us-ascii?Q?/6fvFzk5zGIJulc6u4Ie7aH59xIE9FUEuTvSfbvvoVcJ0ruYOoTjK9M8mv9m?=
 =?us-ascii?Q?COXgf2aiSr2Dm2c7me9gFaIytMHgDgd1xU5yrHpGlhVL8brL8QdEXHlZfhX0?=
 =?us-ascii?Q?nI7EDDEMWQjnuWFRvbsFbJ/nLIIEBgIveqQL2fKrLZazzd3J88IEEE2W/Icq?=
 =?us-ascii?Q?j2tmB+kR9AXSpZrf2dg1YAHsQaaMjiuQRuMui9+LSQgep7RmKzN228dtxj4X?=
 =?us-ascii?Q?8WpNinX3YCj1s4K/J5WbUBoilR2qO/adwDSCqc2vBNdW/FKxeLBAFp5gwbYA?=
 =?us-ascii?Q?9iN+SbHtCoSH89gbUUW+6jRKPjvzcHZgDH0Fv1t++QaPNmZkHGTOYtrzo9fq?=
 =?us-ascii?Q?cBGydFBB3eV9lmmHYEMxwHqKeGQQBlpn8JO4O//gdaA+BG5toBqISl+YoHVV?=
 =?us-ascii?Q?exfoohL1L9DJw6/UeVxVJsw67LaI8R06SFxw7WV+H2PrPKzQhqmcDul9sFWB?=
 =?us-ascii?Q?jP6OuXF36EtnS58YCllmg85o5lcU4VSFGinZHgotqNmdb+FBcGPPPHAcdbSQ?=
 =?us-ascii?Q?EdAuLLvMxGwVVxk68C0wIBKdHxVs0/z2FKZMwGW0CMMf07Gwcg+SGN02NTUC?=
 =?us-ascii?Q?W+xT6yHUenEJou7CjWW/a45/CMmATAwG1leYpWzuolB1S1fF7nsj8hxeZR/s?=
 =?us-ascii?Q?SW13Dq7p57IDup+FVdHRcRKkIcCltVzDoK7IKu2HZZNvRDBDtLThEpCU8ar4?=
 =?us-ascii?Q?hdufzyoLpEIhks1KVVxooHR0DP8DyTgH0QRFPcTuX5BZbXYoxDrIxygFRyjp?=
 =?us-ascii?Q?tcPwK9465kD/h6VdCFW/7tS6rbh4v0jrvDFXKBOjRlx6k+NuuG/vwHElBdd3?=
 =?us-ascii?Q?KpBzghuymqfj5aqvA5RcO9/xpbP+humW1IvaxU+a05p8xkfY9nroS48Y/j2b?=
 =?us-ascii?Q?DybFtxXEZSLzAH3oKY7Qxa9q9BYuTxJ+yuRPxY8gJH1ilEZ7yjJ06jY8HkoN?=
 =?us-ascii?Q?/zvi0VqGCElzGlEkwcG6vvq5NfZiHcMz/RGWjMfrnPCHKl5XDhYDGTjYWmHI?=
 =?us-ascii?Q?7ObeLRgnL+sqOb+4nmvZVTqhZEtogxXXNxEA4kmG3PkgdCNrZ54VBQPyrAQu?=
 =?us-ascii?Q?D7jnBZwWaq+eYHXUi4TehVhSI0RpgH9krfONLbklsTs4Bgekh7BfAjkmpqym?=
 =?us-ascii?Q?nv1OZe3Ai2aTfkODFlkFO/Yz9BjHnnhLJz1SAE/n7ECMCY+o0OjO4OOHLJvs?=
 =?us-ascii?Q?BCaFpdQ0mq7T2Xc6zxGUL4Pf4A2b9Mzpi66uFFqVELv0319sj02etjLIPrfN?=
 =?us-ascii?Q?imSUh+Dasx6xps5dSiMouFAIwsXXVZL6Lxcll1QebSKNNDvG42fMWGEW5ZTc?=
 =?us-ascii?Q?2NfxWxWrc65KmwrvjiMNE92zbDT7cel5wLH680RagGLQqYbpUxXhGZz32YPP?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3849a82c-e4b2-495b-d87d-08daa27ac8b8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 00:29:06.5332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9Tv+YRRXgWSy40khVEF5GdbaIjPlOBMfNDCsbwtnSsL4l35rmE1VoeFisaX9z992C28gjZCjnVIEwWlq2tN/G7rQg8EDIAAdeSuORVyfCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5212
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bo Liu wrote:
> Use ida_alloc_xxx()/ida_free() instead of
> ida_simple_get()/ida_simple_remove().
> The latter is deprecated and more verbose.

The better justification is:

ida_alloc_max() makes it clear that the
second argument is inclusive, and the alloc/free terminology is more
idiomatic and symmetric then get/remove.

Otherwise, I would not apply the patch is the only justfication was
deprecation and verbosity.

I'll fixup the changelog.
