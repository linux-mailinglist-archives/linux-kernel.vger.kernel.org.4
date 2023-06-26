Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA00773D565
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 02:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjFZArG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 20:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFZArE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 20:47:04 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035A1BD;
        Sun, 25 Jun 2023 17:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687740424; x=1719276424;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VXsRJQsvO7IRZ3uVQLIs4sCvYYKXeqssXDKhRM7iKqM=;
  b=PCN/uqEoLpT0njf93L5l2O56myOy24bxLZJhWNwmQK9SWACcZenxyGke
   u4+LPNr5RpiI2wbHiAOyhFOuhHfJzyc/wfOiTLGOV4NHOpJzIiNERGfzX
   wTzuKKbSN6hjqZ5s7247WTRHwfPbcy5+REy1m4MFGenNPky4U3Ae7BGUz
   qRRWKPfywx6Wrunsdh3rfmc6hBn18ikta5NMs7G9HHcnwa2960TS3xlhE
   xeGIPj79d++mnBJprc7aO+VEnmTJrFvvJnN+i3joBaRmWV0fdRNLh37H+
   S2DjScWndDe5ToWbZJZ1Yck4rcWaIjB7RLHzFX2R+0thtLb2NJbz2i/MS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="350910752"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="350910752"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 17:47:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="829042310"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="829042310"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jun 2023 17:47:01 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 25 Jun 2023 17:47:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 25 Jun 2023 17:47:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 25 Jun 2023 17:47:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 25 Jun 2023 17:47:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQUalgDun9oP0EFLKHLSnrrQNyRtFzExiG+xjdv7d0Yrcba9KfkAvwpkZX3pJ/JG3Nynpt1qRMjpdvT6K4NC3L6XmmMZmi3CU7D+UlR9RZF5v53iYl/5VsiG2YNlfTLbYEF2kXSUKn/iDi/Jorx+aBX+ED0BkK5WeQHWVaHjRJK+rK6wBehAYOCVLINYeiGETZPPBVRUWy4ZC1O3lZut7jpZygGXPMqSkM/Ybsg2a4Rl4mLRv/Np2mKuKCvuCU2vTCJISAccd1DsQEth6PPvRXrIfPbOOIXq9APXij4ACApgUxWAlwLLI4NDfgALKWbL1U89RAuSaVghyp8EKqj4jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBcaJdLMjkX+H1DroTcwW58Ae8TCMYTg6ZJ1I1OHUYQ=;
 b=MkDe4ksFVMsLnmL9g3+ZZihUhmSSZAfxZ48b6UlJbixKPCzn70+o/6vmeT1xt3VgBxNhsQvsXsc4v5h/O8OVNk2yaWD4h1VlevoiO1dOBK5b1IJJh22NTDOHIoueKqXjBHXIc0ZWjhxRNdAhjVAb7KgVzI40Gcur7PVnQHb9pEhxrpZUjVjPa05/vAqxacP7fqXW5UyptSUxBy3IeSUBPwyNV8CbTK9Q1Fp8vL1l+tKaNhFzvG2r0Gbq9xvdPb780KslBGB9ZqhqhDLyWeCDJK1Ad7IDEZvGPGxEFr2kpCOYbCZTEJ+Epfhz4V1OO6Oy7JxGZAVFQeRNYwpbDtFvrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6057.namprd11.prod.outlook.com (2603:10b6:208:375::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 00:46:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Mon, 26 Jun 2023
 00:46:58 +0000
Date:   Sun, 25 Jun 2023 17:46:53 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@gmail.com>,
        Liang Kan <kan.liang@linux.intel.com>,
        <linux-cxl@vger.kernel.org>, <peterz@infradead.org>
CC:     <mingo@reresetdhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <will@kernel.org>, <dan.j.williams@intel.com>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: RE: [PATCH v8 3/5] cxl/pci: Find and register CXL PMU devices
Message-ID: <6498dffd2e228_8e17829465@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230531110011.13963-1-Jonathan.Cameron@huawei.com>
 <20230531110011.13963-4-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230531110011.13963-4-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: MW4PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:303:b4::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: ab943ffd-62a0-4763-f920-08db75ded847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c98RjdqydQJ7j02zqpUzPCB1RUA8S23X0eQFI6m3AWSP4y//wYfIWuuZI1gleSFTq6PYiPKTbDWJXQE6EamPRXeUMAr7ytdWCtJZhVpoBEyAgaA8Hz/TsMQUTp2XuAlX6kqToOXXIi2z/Tds3lVzF3oZWZwc6RI3WKAjDCXcadACwPNvhfBktpnEy+guw+qCjOiRGVHWakkXbW12Tg/r+c9HWr05uwqntdywQ1xq3PkxVUpKImLMhUzuencii+YhlclZt0WrB4b8tkaFT/ag0x78MYXdbTKWCmsYJyAzLygDor7zFU1OqQnMeQNS/BUSDk5np2X/TsO0dcQHkntANlQkzrxtm71RVz+tsaMKxAPOag2ae4frbkYv5dqUS0rK9tBh6BJ4+F0ks1oSUyf4cHJpySXvrYz12kbbix+d7jQM402fQsuRSel8tIzWTGfg6ysToG1K8V+kNmfmAdGkDvM7OtEsQbVS67L4IzoSfNGPDQv3yn2Yjz6JDYlfjuFiCWPTiRgEiYmhj0k+HZ4aExLe5ULGmVseEpysbkr2g1Pfo7mAOJ1aO4SwPzlKO2mh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(82960400001)(38100700002)(83380400001)(86362001)(478600001)(54906003)(110136005)(6486002)(6666004)(41300700001)(66476007)(66556008)(66946007)(316002)(8676002)(8936002)(26005)(4326008)(6506007)(6512007)(186003)(9686003)(2906002)(7416002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9HsodgjSjBT7UrX20WPIpisfP+TKyo5hq4Sw0Ac6u9oBRCnf5sLraTqJWLaS?=
 =?us-ascii?Q?nt4SLQbJywItdy3TNhbHrtcpkZ7I/zTF6Gf16FLbKg8QjFSQ9fABtiqD4qQS?=
 =?us-ascii?Q?2xV8xNfVRinpElj1gBc4JuWTuPd5QE3k8AB6Z6fXR9kfHtrbRnTBfZvOlrVE?=
 =?us-ascii?Q?lkP3a2xqMKvqbUbj34O+mP4k5u3uvzVoU+mo+jKpgGOQTSQDCl7DTUf9t+nS?=
 =?us-ascii?Q?o1PuHlLiOWoUd5VoMlu2sy9Ab6JSadu2tYZ/eUMDYst5kQh+w0lfFyiXltSv?=
 =?us-ascii?Q?O7hyqhJ7yLod+d9SLg+JsbJ3wPQ/FxMpJIrJX/JHnfj8SrtW9qPoN9V6ZhVh?=
 =?us-ascii?Q?Vc5wbCmLKdNfvlB3pZR29jOn16nfOp7bWx0o59+i5JNq4zcf1pyouXGLSEaO?=
 =?us-ascii?Q?v2QiBdvD2o4WIB99ZsEMoYRdiNvAFXFK5GClkBZ5CZ4KwQHYo8kJC0q96rP0?=
 =?us-ascii?Q?Yf96kefM0CfkWYRlBuEEjAgrpChkFzWOi2kHiNP86mrau0PG6gANxphHNMjy?=
 =?us-ascii?Q?3OkMMR2tfnUvVu2hnJu3eUXLLLLV/askmBpGx450xWOah96mUaleDiP/Jii/?=
 =?us-ascii?Q?mGqbiGUIMvb0JKQa/BAWuGNtNeerrOsI+JQPO6CLIK9ideck8oHKd+bbhJ7I?=
 =?us-ascii?Q?MDBYk3e4h+X7ltHD2YXCWmRRnmAsvSNtBj+uWrJSgfHp6BB1Nekefx9/MZEL?=
 =?us-ascii?Q?8fLa0417k5cmjQoQFsAcwVVlD8/K2yuja9x67NIx59jIynSkjMAghyJ6RXGj?=
 =?us-ascii?Q?H+nr6jdelSy7PmzMfu+OCYvENcJ6TX1y9Y7IkA+BKXMHU6Ke6jv+Uilh1Y2D?=
 =?us-ascii?Q?5GU0OETipuZLI75Ly9uV6DhCyXp2RAUAj1J3z4KMQDBTrY/f+SCNYlwOoUK1?=
 =?us-ascii?Q?j0dDE9qaCjkkeTe6bQ1BS6FzT8fpwUJQMYitlJUrXt+734uCg28K3Q+kd9WT?=
 =?us-ascii?Q?2bfpj6o3OTch8hUXdVbzz1xmpgvrRNO+VxlDQNgfcZxb3zCz5W4RNXy/kwUZ?=
 =?us-ascii?Q?VYoO9KT5n7CPaVsgFIxsfGAojcCK16f4tbDqr3aKGf7+8WA6gdMHfR9jg4mO?=
 =?us-ascii?Q?nIaSOlXoojobonWyHszZNNObGIm+V1IFWkyR1PptKLqWB5sHOiAXT18YqtkG?=
 =?us-ascii?Q?5dMb4sIxn8q2nDS6ppTn/1w+kTU5ihbzG1Pnt19pURkjWfLjOmNk5NcRjDwh?=
 =?us-ascii?Q?RP+wx1KBu9684FElAbOtZrEbtWRzlSIyU3QyK3Dl5f0fgWiZ/xFGq91JB9FT?=
 =?us-ascii?Q?2LKhI513t7ZIvbAfZaaNAGTRariw8wmypc44ZmgK8P2UwNRNJzoniwrSJ/cv?=
 =?us-ascii?Q?5CsKWUUSBaiblNEOOqO5m3cYTFSXfsIxiJKaATCu/mpJiGRbhMjoUD34fIUK?=
 =?us-ascii?Q?gdiKlUFmNaBQCT2frA3c7WahkGp6NId2luQnChfwyqyierDttvLJshlFBDBj?=
 =?us-ascii?Q?D6Yvy4WEY61yTJL/1wPXQ0baulcObmkTqZ3Bs8L1Qhr7v86SR4sqwGvRREZD?=
 =?us-ascii?Q?xLA/wBdEtlh+c3+i86C1YznjvD7uifTZ0UT0m4xZpyXJx7So9j7+Yoh8fJFC?=
 =?us-ascii?Q?7jIN6UfaGz9uejuymBj0Xgx+Uioyo4yJjmkaH94YP3bFWdjtBIHertkiLSnN?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab943ffd-62a0-4763-f920-08db75ded847
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 00:46:57.7246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5WHP2phyaQcoTchGVaFcf1JWvHJrzsPw48Ac8NEGfA1ztVsawcMG2A6IjX0aKLRDBS+2AUcUzID9yhAOoQjSwzhvln4CiXdqKA/QWr0eKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6057
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron wrote:
> CXL PMU devices can be found from entries in the Register
> Locator DVSEC.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/Makefile |  1 +
>  drivers/cxl/core/core.h   |  1 +
>  drivers/cxl/core/pmu.c    | 68 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c   |  2 ++
>  drivers/cxl/core/regs.c   | 16 +++++++++
>  drivers/cxl/cxl.h         | 13 ++++++++
>  drivers/cxl/cxlpci.h      |  1 +
>  drivers/cxl/pci.c         | 26 ++++++++++++++-
>  drivers/cxl/pmu.h         | 28 ++++++++++++++++
>  9 files changed, 155 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index ca4ae31d8f57..1f66b5d4d935 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -12,5 +12,6 @@ cxl_core-y += memdev.o
>  cxl_core-y += mbox.o
>  cxl_core-y += pci.o
>  cxl_core-y += hdm.o
> +cxl_core-y += pmu.o

One small addition I will make to this patch is to fix the cxl_test
build with the following complimentary change:

diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 6f9347ade82c..aa0ca7095a64 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -57,6 +57,7 @@ cxl_core-y += $(CXL_CORE_SRC)/memdev.o
 cxl_core-y += $(CXL_CORE_SRC)/mbox.o
 cxl_core-y += $(CXL_CORE_SRC)/pci.o
 cxl_core-y += $(CXL_CORE_SRC)/hdm.o
+cxl_core-y += $(CXL_CORE_SRC)/pmu.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
 cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
 cxl_core-y += config_check.o
