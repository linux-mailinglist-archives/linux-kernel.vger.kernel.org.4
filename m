Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDB5660747
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 20:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjAFTmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 14:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjAFTml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 14:42:41 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CDE78A46
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 11:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673034160; x=1704570160;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hyZEZRlHOS1WkgJcArCbv64TIRum7zTPkNMX8iVJHiA=;
  b=YoGZ0fz7jQe22yc3WVIGnk6mrZKujiUwIUabLmEveD/Thn5VUYEyTE5J
   ESdP3d4GErsjgBfVDc1oMu6S6rYEqqtebU8FnX8y2XjFBDKPOSkXckLLF
   bXnKH/W2hqd2ag0Ww8NpzU/rlMMMZxNTEXSd2FwkXbC7FAAM5+8E9Pzat
   cN+WUVHIjzNkTvpU08QPriArW+IvuBvwR9wUnat2HHOYmCZ4GSuKBz4rB
   4up8saCSAgRORa1sUfU5GlA8eSz6hot38Wh/9gICiQNH4WYDhaonYjwGe
   4nUWf2F1utVMERQ4P1Bse2Y2+QegAD6XMtw3YK0F8hxzKXm63S67YOMot
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="349755882"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="349755882"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 11:42:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="984760355"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="984760355"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jan 2023 11:42:39 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 11:42:39 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 11:42:38 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 6 Jan 2023 11:42:38 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 6 Jan 2023 11:42:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSc9ygohuiG8+3NrH/4b9BZ1XCGgAht75h4Ug1CECnZDnpnZqGckfI+o/yj55b1WSFcffJt1yFB2DmJ/qkHNvD3yBKIhfw4h7EZD8/HK9zf0IfP+HjhW6ItRFUrSsw/4CKb9mHe8BXdaREsnyyCI/n1y0KS4+LodO9mYBzvycJQMqr4bZlUJh8lLqoMeKmjdzvKVvMM5COoWfmPp+DU1gUcDWnXXnjk7SVdNjRjX9fht+cLtt9I7/UfxGtqZ73Ca0mKaTbNVC4MmJxdMDIHdU2BFGyX+nHxd12p7PnJLjgo+n2bf58gIHsjpnyQzBErPnlCn5jZK9lOOlsv7ED+wKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kFRx9tXI4u4+jnnvdnYTfcgpZv128m1PCVKM/IetsA=;
 b=Qbd8HxUB97jvqgjzuXYXHsA26MmKO72Ys8HuI+3kJ4n5cWO7DQ3jd3x4Wr1i4cR7YTwYaZudk0FG9RYMab/bos/VIfS+7ih/yJ+iQOOpAugaegsDvaVRHWLNMWRmu0qSFfOOCNwyGT7F7zWuPl2g7B5NjUISD9i+WAnE1WHFamKd3uplN0Npoy7vjSEhWoboyCatmDKcXvgKdTQ/hOvf0kAzMAcQ4VMb3VaAfZZ4Rue/Mln2B7OVrwL+yaNKFW9l4/ACZOUr2cICVbmmw4WAUeVcB3Ul7W6BT1o50GB2AIdrooG4eGN5V7eGWGPSwgCeEGjJ0Xj/R00zNAmQKMYXxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by CO1PR11MB4818.namprd11.prod.outlook.com (2603:10b6:303:93::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 19:42:35 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%9]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 19:42:35 +0000
Date:   Fri, 6 Jan 2023 11:42:32 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>, X86-kernel <x86@kernel.org>,
        "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v3 3/6] x86/microcode: Display revisions only when update
 is successful
Message-ID: <Y7h5qD43kdPeEgQ7@a4bf019067fa.jf.intel.com>
References: <20230103180212.333496-1-ashok.raj@intel.com>
 <20230103180212.333496-4-ashok.raj@intel.com>
 <Y7XMtWqSrs0uGkD7@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y7XMtWqSrs0uGkD7@zn.tnic>
X-ClientProxiedBy: SJ0PR03CA0389.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::34) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|CO1PR11MB4818:EE_
X-MS-Office365-Filtering-Correlation-Id: ae08cf2e-3032-4d04-6c83-08daf01e290f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RpsWI7ilQs3i8qzkd0sRdReGKca6wDwSLZEYnSPepsUmVrZtlO6r/Qp2ysEefj6VmB1h5k4YYfdxkJSF+YXeEXlBu372+k8gOGv/p1XmDSp9Fxk4SR3mQTYsdh/m0rwojMVrJxyhf/MLaZYSm/pvCGN5zp1DypdyhxPFYke5B7AbZ+5MiimZ8pLCREPmstvlZyYG8g070y8evAn07rBOcrJktc+HPovX7RlpMO7RUUtAWTPCb9bG1+zyGowZK/X27VVTjiQBDUhk23sSdUh7/v65eXnrax9ur2az8HId0eKJPmqOY3sWfkRqDNmhmgFeYB8GE0SDnRoMR5WKxbYadDZ0V5C92XWwKqM3YjQ5fvr0w7NC/DkiUYvYzkVvwYeNpPFOCE07v4DVCdeGzFa3Z+zoCp86uSU2Lnus4ScOumYqAnnj30zbMgFoSeADuoVsdofBlOtZeXaNs52O5/eZuWa3S081PxWLp62WpLA6qeBHaKj9f8+FmnBmqtOKDXOrb1WQSDWhaf/zLI2JJlsA/OM0ku2L5wJPTPacrssGKwXHIktjrQrElYmRJ8rMjQTa1P+26pRHZXM6IaD+U9MHfzquwjqg8WYSO6b78WJ5CdSKqP9gwOOwAzIQ0FmYidje0gJEZ3gZBi+laOEprsGKLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199015)(26005)(6666004)(6512007)(107886003)(186003)(6486002)(8936002)(478600001)(6506007)(44832011)(6916009)(54906003)(316002)(66946007)(8676002)(66476007)(66556008)(82960400001)(4326008)(41300700001)(4744005)(83380400001)(5660300002)(15650500001)(2906002)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vDzE79H/8cNiCufOFhwx7nO93TWmK+IA7u6yVMY7XqXzKTT28FLs/C3LWQX5?=
 =?us-ascii?Q?aKztFWaNvX2TrEvc5bWN8DeGZRu0YLKlXu0hHLZm+i1YWXdWNBnyQ4oEeZOi?=
 =?us-ascii?Q?vXPGZDslRMi34idlSwD5YYKVS4LvR/M48o8TSwhfasVHCKjeFQBZrIVOtFCe?=
 =?us-ascii?Q?XqhR9NooMe5BAsdTEgvPK/jflkXWlCPmEcvEvpOQ7Q5ODj21cieMKkCzZ2Pe?=
 =?us-ascii?Q?ggoppNGMn5TWMeFeEvc/xIyu2q+7Et5eXjMF2d4Ipy9HDplU1ft5mxgDP59o?=
 =?us-ascii?Q?RiCOobZ6LufMJ5tk/nvud6PsNQZxIbXwCYk/M9mrCovC/S10YUOxGFp4X3wQ?=
 =?us-ascii?Q?6TJDw0sXyq3D0nnT+grCEdBHjsD0xdOEgC8xvO3JhNwrbdIcD7FP10qC9BUI?=
 =?us-ascii?Q?cmkzNEzM3W4vwAQgKJ2Cs7AthR8C0xOu4/N987i8fY0hnx8u9PaWayqYSMmE?=
 =?us-ascii?Q?zEFSmo93nFRDXhtUYA9IRV8Cg8GLJcbcZf9P2bIFYz3K3MlTcTI5EVqfXZz+?=
 =?us-ascii?Q?E8xcdRZk2e8GhYgln8T1hP7Pu1vTay6BYgCG820Q8sjN7R3gQNYdo1Wk1gMY?=
 =?us-ascii?Q?p49MdFqBmg5rHSMCU32hz9PR8xg90AkQgYsnQDzWjF0VGw9TJUmGCpEt243Y?=
 =?us-ascii?Q?1fxeWO5AmMrY07+MZTbFO4zETK5+kHtlQjoA7zkt3JyIfDIBp1+/Mt24Vkoj?=
 =?us-ascii?Q?Gy51v+nCXXll5xYuDzhLAbWHBtmW9sh7x7eBJjE39djy0BXFD4QevOcG8VZN?=
 =?us-ascii?Q?3qlDxjRuPY+yRSRgoPz1j3vEhMlsW4piTlS/HkkwKC8HIAb7bAimoYP1WTJk?=
 =?us-ascii?Q?xoeXzTe8Stk4qbaEzYYJLzRmXGGx99C7qjw3YYBNxKjBU7UEjm7XeHZ1ZBYo?=
 =?us-ascii?Q?0AuZowK3VsVsa1YVofA4DnaXVqRsSJE7LClcKNJ+fZnLjXze8hlUnmmOhQ29?=
 =?us-ascii?Q?l6NsUMvnlMx4bNyqJ9EhVnhwVEe0NgNATMJ1egzBYDDaffrJW4KiowI9rAnp?=
 =?us-ascii?Q?gxSh0C6HrM6MQtw7LnRuYIPvGgYBNSzLfM1nzSnEqjndsHh+UBbG9O/3/Umq?=
 =?us-ascii?Q?NrA4ODLtO7fofhX3wGkRQRgRHcnFG69Sq3Fa+eOxINR4D7prj11RBsIz7GPG?=
 =?us-ascii?Q?+4IBbfOf0Wut1u4zQCoO8RA4ZdJEJP1HX48hENLoKiZ8+w/gi6+Aa2Y+EGwX?=
 =?us-ascii?Q?4LfoWntaWCDoMlKY1cMG1r7tgA0PD/L8xPi1zaYp/spvkMthE08nAiFmlgZU?=
 =?us-ascii?Q?OpmFttIdhi7UunAn0nr6XRgFgEw/ZZoqGNpPoNky1qlZ2Wll77CklvqAYUgb?=
 =?us-ascii?Q?J70OX3B0MI3/B4wjx4rTf7AOOy6TUctcva+n5HtfAhEMGHJ2mfTBi7V8GxQE?=
 =?us-ascii?Q?0dDdj/J6/Drle20mt9CD16gjncWu9Pz1QiKYdfcrxU752/8A0gIcB66Ru2Fk?=
 =?us-ascii?Q?P4WkEwefuFayYKTe6f6ndf3ocVntvO50it9M5AiFksXi/Dd4wF2NXHt/GzJD?=
 =?us-ascii?Q?5n9B3Et0ITTbz+VsIXhwUdqqhAtALL1NrSolmI5gllLrq5aMuSeihpTljwzS?=
 =?us-ascii?Q?MpaCHGs6WMcQyb+RadWd5OahBg4+fs9Nt//V+aCR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae08cf2e-3032-4d04-6c83-08daf01e290f
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 19:42:35.6470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60hFJBQKIxswTCgAcycelennagZVE7JX8xoHN3Eovzm0KSvI/SVQMjwu63oda7t3qMPAGXod+pPGsgNaxG+drQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4818
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 08:00:05PM +0100, Borislav Petkov wrote:
> On Tue, Jan 03, 2023 at 10:02:09AM -0800, Ashok Raj wrote:
> > Right now, microcode loading failures and successes print the same
> > message "Reloading completed". This is misleading to users.
> 
> 9bd681251b7c ("x86/microcode: Announce reload operation's completion")

Thanks.. yes I can add when I resent the series.

Cheers,
Ashok
