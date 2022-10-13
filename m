Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8787E5FD390
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 05:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiJMDfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 23:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiJMDf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 23:35:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3A47CA9E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 20:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665632126; x=1697168126;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=16tEOWZa3XNo0rUQnvjz6Upxm1HAx6AIAYJYJdcHIEA=;
  b=l3mQnTYVKawsfuJT6xX0TKNKDR9lBRChMk5G0tMcLA0ut8Wib88EMkAh
   NVoEZHsMeveXEziRZwpB++Z5ibVblIBWWmQjc89GNSD2pbGSKpmlQd9cv
   9pgH2rwxty3SAtrByz9IdiXJBxpXueHV04c1fD2cT47po2oJvl9dF1Sbi
   W9gMHkMHQe7yGp3B0xB5pCm71ZbA7Y9nn2iO7UjDVvFKFrzFmgJCJbLfn
   5fK25oHlR/6wqWWZyJ6yDqzjQq3gUo0/Lu15SdSnUTB9nN6dKybo4+ssJ
   8rziMCLvcCwT+s5rekpuqkoKcbY+bQZsioXD1Gt7fLJQvYyd2mIi3iy4z
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="285351010"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="285351010"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 20:35:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="769452431"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="769452431"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 12 Oct 2022 20:35:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 20:35:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 20:35:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 12 Oct 2022 20:35:22 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 12 Oct 2022 20:35:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IE3hBWrFPo9rFTTcGtP+k0jreti94mZtVhPEtfO5OEUDTqiStdLdRgaXwis+TxsUAKLAFC+bYmnBl8kL8gAT04+aqHgSlvlIUoCCdUgoMoDQXTvLHqnTSFOWXy4Nst2efcX3bQPwUNm1MMkQNyEP9ZrUm8duAuLvUu3rUq7gKPwnSNKPXrR3GpCHf5kNvqxIb089gGYTa6Au2xy6FMxYm7nquoV9B0RYPoEicWu7TX47OInM64+xRGtpL9vgaRl8kZ+HkXb3hyv+nC4nBw/cJNv8wzwEsvmOck//ljgG5DGgVMHoePhLTmZt9j5z+oOTIKPmcO5/x0rSpjjl/qCp/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TR8jYlL0rqwI3S0NJhSNq2bnJ9J1GVzkUuNeITdDCeg=;
 b=RxyC34yM2K+UEZGRYtZwHjdVuhL0opPjjZVhTfkquq20SCZsYieD05ChmAEUcYHDa6OPL7Pia9mCrD6myH9emJrhdh3i8bAqulFydSK7Mw6yZPtR+FWR5JZnZTXY3kJQr5hJ64E1LQBEQMiMrDUKx1omYb7FXfAu0K2pYk4nkhdJNHZ77PC57+/Vth3LEExC0ALOXJDCDyvJY6oHL6wnwdoGb8IsUsUb9UyPyF3ZV6KyiQHGlQAQU6ekhviDIHy/ktFRDs1Pn7T3lOE5TRWBzzFOB0MHQd2/upAx0Rv0exok+Y1NdHvsjt4m1u4k8FXn8OTAzV8NQ7ItsdjI7Ut86A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3717.namprd11.prod.outlook.com (2603:10b6:a03:b0::12)
 by SJ0PR11MB5216.namprd11.prod.outlook.com (2603:10b6:a03:2db::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.43; Thu, 13 Oct
 2022 03:35:21 +0000
Received: from BYAPR11MB3717.namprd11.prod.outlook.com
 ([fe80::e3a9:2e44:76bf:8c28]) by BYAPR11MB3717.namprd11.prod.outlook.com
 ([fe80::e3a9:2e44:76bf:8c28%7]) with mapi id 15.20.5723.026; Thu, 13 Oct 2022
 03:35:21 +0000
From:   "Yao, Yuan" <yuan.yao@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH] x86/fpu: Remove dynamic features from xcomp_bv for
 init_fpstate
Thread-Topic: [PATCH] x86/fpu: Remove dynamic features from xcomp_bv for
 init_fpstate
Thread-Index: AQHY3cA8G+rUHXTHGkezKzq8f0LSDa4LpX7Q
Date:   Thu, 13 Oct 2022 03:35:20 +0000
Message-ID: <BYAPR11MB3717EDEF2351C958F2C86EED95259@BYAPR11MB3717.namprd11.prod.outlook.com>
References: <20221011222425.866137-1-dave.hansen@linux.intel.com>
In-Reply-To: <20221011222425.866137-1-dave.hansen@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3717:EE_|SJ0PR11MB5216:EE_
x-ms-office365-filtering-correlation-id: 4037c2c5-9173-4d82-e284-08daaccbf4af
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 61l7O7mGPkRA79pwjo5kXNohGWUIzVdCGHORCh6wLV4FebICEGDbJ1OiNQX5+tG7ROdXG7YkdAscsKYHOMWK0t58xq4r2T8H1LPZE+8dbDwaJ0p/hlpbYPXn0kvygw+hZpZ4IPAxm52zRXVFGw9E/fDdtR8XmhKdKEYtIyULkh5bWC8I2p1ODr9n9vU/oUXZ0PAH4C/4EMJvqr/0xOayZ4oVTSG0DDg035SLsfjZAqyV1lIb8HMaSJaZcWh7+x1W9N2pTKhZS3djnovuwTwCuhA0qe9s9iMpXi1uHET18w3HUZ5G1jjV/Xo6NqPQnIQS12dSiaF7zHsoKLiagMKo906Osi+IKHomWm5NHutQS49SR5KKdUQsjXmxN+hX81jcV5jBGBpnzpN9Y32xa2aMMicefdJdkOid+NqObuHWznTpyqljCChpHoMHG8WkXt6BB3e7FzNdvC5X8V+LJlzmR4jE449qOrTOFfJz9oZAa0MXkrPn/aQweWYbUL/4si15IWHpqjfQTdER1EtowhXSCNomN9TKZ6fzBRS4w/Cc9LfvRjUr8MAnKNU6MOfG3sTmIH3nfzF/PVUVatEVE7nAOnC0NjXwuFwIX29aCvt1M5GZ0reOKqZ8fUJ8YyHB/6wcQkRNIU4nhEEztGc7EjbhuZIrBCW7pU3wK8d4tA3KUhSzjUimhhP3GwLSc1FfquuFf+EJ9F2PdsBygAnetPjy6hUP5syz3v2zrzpL9UmGGa2YwhfHGP1njDSsQ9eZqLBhmUBO574J3v1XXqQmpt35Mw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3717.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(39860400002)(346002)(396003)(376002)(451199015)(33656002)(55016003)(26005)(41300700001)(6506007)(7696005)(82960400001)(45080400002)(64756008)(76116006)(66946007)(66556008)(66476007)(66446008)(478600001)(4326008)(9686003)(38100700002)(8676002)(122000001)(71200400001)(8936002)(30864003)(52536014)(5660300002)(38070700005)(83380400001)(54906003)(186003)(316002)(2906002)(110136005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?in//WmBa8XneSaEpkqybFTClgICAEUwS0USjZw5C7aZvYxYHPr6FfIFxLexP?=
 =?us-ascii?Q?3VMhELM2BcA5szeOvu/sZGuceIzob7j4L+8UMw0pBhTLhBWmq5YORHeWQcIK?=
 =?us-ascii?Q?9I5KcA4v7GBWhorbOd6MnllTRnIb27rcWVoVbLRT+/WouDg4iKK9g4sxWmoi?=
 =?us-ascii?Q?Fu0hC4RxAnfkbsn1mx1Y1wVXZ7cwjZxbt24aEcdC7IwqvcXhyeiaEcakQoKD?=
 =?us-ascii?Q?XPFNWvPmp7Y9a23YqTKrn/nXwAzyrZtbERcR4Lss2zLb0ZF/PqFE6lzG+1sQ?=
 =?us-ascii?Q?Fr0zoZTe8msyclDgFqFPvogQvKf62jwIC26dO/HH6xWqQco4K1V47JS1wtx+?=
 =?us-ascii?Q?xuBo8gPuS9HZDQ8FXK3nhppgdJhUPcTuXyaiPxkOQuYTtri/7gJF1BILE9dS?=
 =?us-ascii?Q?GNg0XsXYxN+q1QciXTvHKe6nSaB6OonIpNLyxbnDWZ4R8hwEG04KUDRTjslm?=
 =?us-ascii?Q?1KzCZ/rk8OZtVoUOp9Wuybwt65qDWAyz7ZLW5o40Z66gvf4umefknVhsbazR?=
 =?us-ascii?Q?OrOJYfl+qyJHPQEnscGELJI5uFjdeLK5VTVTs0pUu/D1tLsQGaAfc/vSxGWr?=
 =?us-ascii?Q?F2mL1BTV8D/Pvvv1uLG49U4mrQowg90G49o7yZQlbIYQzbNAbRFMarT8w3/3?=
 =?us-ascii?Q?Zdrgw65F+qytNtjUNqbLqLVnS7wyp5F7dw4hGrc17Rv2TSxBi2bi6rOnboAe?=
 =?us-ascii?Q?xl5iezanjH2sC6VInSFmkwapb536F7zrKnzWPdkqUQTbei0u34SSqF0s2Hxg?=
 =?us-ascii?Q?9yrx36Nh86aWkoXQaKaGGwVcOKDITr+pKWIkq30slYSRfSNA975fVbQA08zG?=
 =?us-ascii?Q?AXtzV/+wUQaCO8yYe/zS1n3Q4nOywcq1dPh+NEGCUXsjwWbHITHp7YPeWSI+?=
 =?us-ascii?Q?wBQKLg0eI1rGHdmtvUWQriH8bd6nDT2Xsfe7A4/Y8H/mX9KFiNDdXLJIW31C?=
 =?us-ascii?Q?izrbHqmsdJ0mk8MqX1DQt5GiZOVciSUkKrpcV4vN8lSCv+wvtYXZtVe8MeH/?=
 =?us-ascii?Q?WjA6U8s02nNNd1avB/hOApAisnJlTZaz9dsiXst4q7m2KrrOCVkbC9rtMFA5?=
 =?us-ascii?Q?YtHAOcdP2aZTTbbprACIh4edfuILpIgWagW/iS52bL5XwtZaOWTgF/PoVTCn?=
 =?us-ascii?Q?rz1gLRESQGK1UoADnLcmxz5vDFnAcO1XBrqbZEpPMWz9lDZi8mkcxBfBkJNU?=
 =?us-ascii?Q?+GZ3lqASz/3PxVCyEFJao9f7ErMO1QyiJs5uoKDMPcjAA1x19pG7+Nr2NJT6?=
 =?us-ascii?Q?bpHLvV626j6UwtUaT49CWK+6v6sHSiI197fQxHwKmvrHM6whf0EiPbya1jNA?=
 =?us-ascii?Q?Dr4b4wHV+nz6/cXYkKGtAZdGxUQopdu15YFdx1YYMur19ZfV3lzGCduGEdBc?=
 =?us-ascii?Q?mvekU1UfTGGqzR+V/eL5pNF5w7zG28LSWK4+TZEOd5Zprw4dtGE0wN8Ta/cu?=
 =?us-ascii?Q?s8RdCYpouo0m5Y67p1HW9XPmmTQfqJp84U6AzmJkurTBQdjJik3Oqr/8bB4f?=
 =?us-ascii?Q?2w1ZVvTcz5MjDnfsHZc1VXqO5A3vr0h3A0PiNyV213fS47JGw/A5YEerD71w?=
 =?us-ascii?Q?ZsLNA2hNXhK2XUvksrc35Q2ehofUc8Vx/NzLEtCU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3717.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4037c2c5-9173-4d82-e284-08daaccbf4af
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 03:35:20.9696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vjMTPL3rwthqp+RoGWwkrnRwT3oZu1/XrDlkkp3VtuVoGQZOFo1BbYKnNuxiOrF8q3pJU/IgdaIC2eaCVSoIpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5216
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Dave Hansen <dave.hansen@linux.intel.com>
>Sent: Wednesday, October 12, 2022 06:24
>To: linux-kernel@vger.kernel.org
>Cc: Bae, Chang Seok <chang.seok.bae@intel.com>; x86@kernel.org; Yao, Yuan =
<yuan.yao@intel.com>; Hansen, Dave
><dave.hansen@intel.com>; Thomas Gleixner <tglx@linutronix.de>
>Subject: [PATCH] x86/fpu: Remove dynamic features from xcomp_bv for init_f=
pstate
>
>From: Yuan Yao <yuan.yao@intel.com>
>
>This was found a couple of months ago in a big old AMX
>backport.  But, it looks to be a problem in mainline too.
>Please let me know if this looks OK.  I'd also especially
>appreciate some testing from folks that have AMX hardware
>handy.
>
>Builds and survives a quick boot test on non-AMX hardware.
>
>--
>
>=3D=3D Background =3D=3D
>
>'init_fpstate' is a sort of template for all of the fpstates
>that come after it.  It is copied when new processes are
>execve()'d or XRSTOR'd to get fpregs into a known state.
>
>That means that it represents the *starting* state for a
>process's fpstate which includes only the 'default' features.
>Dynamic features can, of course, be acquired later, but
>processes start with only default_features.
>
>During boot the kernel decides whether all fpstates will be
>kept in the compacted or uncompacted format.  This choice is
>communicated to the hardware via the XCOMP_BV field in all
>XSAVE buffers, including 'init_fpstate'.
>
>=3D=3D Problem =3D=3D
>
>But, the existing XCOMP_BV calculation is incorrect.  It uses
>the set of 'max_features', not the default features.
>
>As a result, when XRSTOR operates on buffers derived from
>'init_fpstate', it may attempt to "tickle" dynamic features which
>are at offsets for which there is no space allocated in the
>fpstate.
>
>=3D=3D Scope =3D=3D
>
>This normally results in a relatively harmless out-of-bounds
>memory read.  It's harmless because it never gets consumed.  But,
>if the fpstate is next to some unmapped memory, this "tickle" can
>cause a page fault and an oops.
>
>This only causes issues on systems when dynamic features are
>available and when an XSAVE buffer is next to uninitialized
>memory.  In other words, it only affects recent Intel server
>CPUs, and in relatively few memory locations.
>
>Those two things are why it took relatively long to catch this.
>
>=3D=3D Solution =3D=3D
>
>Use 'default_features' to establish the init_fpstate
>xcomp_bv value.  Reset individual fpstate xcomp_bv values
>when the rest of the fpstate is reset.
>
>[ dhansen: add reset code from tglx, rewrites
>	   commit message and comments ]
>
>Fixes: 1c253ff2287f ("x86/fpu: Move xstate feature masks to fpu_*_cfg")
>Suggested-by: Dave Hansen <dave.hansen@intel.com>
>Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>Signed-off-by: Yuan Yao <yuan.yao@intel.com>
>Cc: stable@vger.kernel.org
>---
> arch/x86/kernel/fpu/core.c   | 3 +++
> arch/x86/kernel/fpu/xstate.c | 7 ++++++-
> 2 files changed, 9 insertions(+), 1 deletion(-)
>
>diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
>index 3b28c5b25e12..4d64de34da12 100644
>--- a/arch/x86/kernel/fpu/core.c
>+++ b/arch/x86/kernel/fpu/core.c
>@@ -526,6 +526,9 @@ static void __fpstate_reset(struct fpstate *fpstate, u=
64 xfd)
> 	fpstate->xfeatures	=3D fpu_kernel_cfg.default_features;
> 	fpstate->user_xfeatures	=3D fpu_user_cfg.default_features;
> 	fpstate->xfd		=3D xfd;
>+
>+	/* Ensure that xcomp_bv matches ->xfeatures */
>+	xstate_init_xcomp_bv(&fpstate->regs.xsave, fpstate->xfeatures);
> }
>
> void fpstate_reset(struct fpu *fpu)
>diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
>index c8340156bfd2..f9f45610c72f 100644
>--- a/arch/x86/kernel/fpu/xstate.c
>+++ b/arch/x86/kernel/fpu/xstate.c
>@@ -360,7 +360,12 @@ static void __init setup_init_fpu_buf(void)
>
> 	print_xstate_features();
>
>-	xstate_init_xcomp_bv(&init_fpstate.regs.xsave, fpu_kernel_cfg.max_featur=
es);
>+	/*
>+	 * 'init_fpstate' is sized for the default feature
>+	 * set without any of the dynamic features.
>+	 */
>+	xstate_init_xcomp_bv(&init_fpstate.regs.xsave,
>+			     fpu_kernel_cfg.default_features);

Below trace is observed on host kernel with this patch applied when create =
VM.

The reason is __copy_xstate_to_uabi_buf() copies data from &init_fpstate wh=
en the component
is not existed in the source kernel fpstate (here is the AMX tile component=
), but the
AMX TILE bit is removed from init_fpstate due to this patch, so the WARN is=
 triggered and return
NULL which causes kernel NULL pointer dereference later.

I considered 2 possible ways to fix this without big change:
1. For such non-exist component, we can fill the buffer in target fpstate t=
o 0 and don't WARN if the bit is not set
    in init_fpstate.
2. Enlarge the init_fpstate to content the dynamic components and still kee=
l fpu_kernel_cfg.max_features
    in init_fpstate (but still remove the dynamic bit from new cloned threa=
d), so we can use it safely in above case,
    but near 2 pages (8K) is wasted.

[  100.989998] ------------[ cut here ]------------
[  100.995332] WARNING: CPU: 109 PID: 2910 at arch/x86/kernel/fpu/xstate.c:=
944 __raw_xsave_addr+0x49/0x50
[  101.005948] Modules linked in: kvm_intel kvm x86_pkg_temp_thermal snd_pc=
m input_leds snd_timer led_class joydev mac_hid irqbypass efi_pstore snd so=
undcore button sch_fq_codel ip_tables x_tables ixgbe mdio mdio_devres libph=
y igc [last unloaded: kvm]
[  101.030924] CPU: 109 PID: 2910 Comm: CPU 0/KVM Tainted: G          I    =
    6.0.0-rc6-kmv-upstream-queue+ #23
[  101.054199] RIP: 0010:__raw_xsave_addr+0x49/0x50
[  101.059511] Code: 85 15 b3 44 39 01 74 1c 0f 1f 44 00 00 48 0f a3 f7 73 =
17 e8 d9 fe ff ff 89 c0 48 01 d8 5b 5d c3 cc cc cc cc 0f 0b 31 c0 eb f3 <0f=
> 0b 31 c0 eb ed 90 0f 1f 44 00 00 55 49 89 d0 48 89 f1 48 89 e5
[  101.080865] RSP: 0018:ffa000000b8cbc30 EFLAGS: 00010206
[  101.086870] RAX: 0000000000002000 RBX: ffffffff823be3c0 RCX: 00000000000=
00012
[  101.095038] RDX: 0000000000040000 RSI: 0000000000000012 RDI: 80000000000=
206e7
[  101.103177] RBP: ffa000000b8cbc38 R08: ffffffff823bf400 R09: 00000000000=
00001
[  101.111350] R10: ffa000000b8cbc70 R11: ff110008ef3f4008 R12: ff110008ef3=
f4b00
[  101.119500] R13: 0000000000002000 R14: 0000000000000012 R15: 00000000000=
00012
[  101.127678] FS:  00007fca15639700(0000) GS:ff1100104fd40000(0000) knlGS:=
0000000000000000
[  101.136922] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  101.143512] CR2: 00007fca202a9001 CR3: 00000008f49a8005 CR4: 00000000007=
73ee0
[  101.151658] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  101.159817] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 00000000000=
00400
[  101.167961] PKRU: 55555554
[  101.171110] Call Trace:
[  101.173972]  <TASK>
[  101.176435]  __copy_xstate_to_uabi_buf+0x33b/0x870
[  101.181936]  fpu_copy_guest_fpstate_to_uabi+0x28/0x80
[  101.187720]  kvm_arch_vcpu_ioctl+0x14c/0x1460 [kvm]
[  101.196409]  ? __this_cpu_preempt_check+0x13/0x20
[  101.204924]  ? vmx_vcpu_put+0x2e/0x260 [kvm_intel]
[  101.213531]  kvm_vcpu_ioctl+0xea/0x6b0 [kvm]
[  101.221507]  ? kvm_vcpu_ioctl+0xea/0x6b0 [kvm]
[  101.229661]  ? __fget_light+0xd4/0x130
[  101.237011]  __x64_sys_ioctl+0xe3/0x910
[  101.244395]  ? debug_smp_processor_id+0x17/0x20
[  101.252463]  ? fpregs_assert_state_consistent+0x27/0x50
[  101.261228]  do_syscall_64+0x3f/0x90
[  101.268090]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  101.276574] RIP: 0033:0x7fca1b8f362b
[  101.283312] Code: 0f 1e fa 48 8b 05 5d b8 2c 00 64 c7 00 26 00 00 00 48 =
c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2d b8 2c 00 f7 d8 64 89 01 48
[  101.312528] RSP: 002b:00007fca15638488 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[  101.323793] RAX: ffffffffffffffda RBX: 000055b3c88ea9c0 RCX: 00007fca1b8=
f362b
[  101.334583] RDX: 00007fca0c001000 RSI: ffffffff9000aecf RDI: 00000000000=
0000e
[  101.345320] RBP: 00007fca15638580 R08: 000055b3c80d95f0 R09: 000055b3c88=
20320
[  101.355994] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffeed1=
9156e
[  101.366611] R13: 00007ffeed19156f R14: 00007ffeed191630 R15: 00007fca156=
38880
[  101.377221]  </TASK>
[  101.382225] ---[ end trace 0000000000000000 ]---
[  101.390004] BUG: kernel NULL pointer dereference, address: 0000000000000=
000
[  101.400468] #PF: supervisor read access in kernel mode
[  101.408908] #PF: error_code(0x0000) - not-present page
[  101.417319] PGD 88bd3e067 P4D 0
[  101.423541] Oops: 0000 [#1] PREEMPT SMP
[  101.430410] CPU: 109 PID: 2910 Comm: CPU 0/KVM Tainted: G        W I    =
    6.0.0-rc6-kmv-upstream-queue+ #23
[  101.463968] RIP: 0010:memcpy_erms+0x6/0x10
[  101.471389] Code: cc cc cc cc eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 =
03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 cc cc cc cc 66 90 48 89 f8 48 89 d1 <f3=
> a4 c3 cc cc cc cc 0f 1f 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
[  101.501238] RSP: 0018:ffa000000b8cbc40 EFLAGS: 00010246
[  101.510134] RAX: ff110008ef3f4b00 RBX: 0000000000002000 RCX: 00000000000=
02000
[  101.521233] RDX: 0000000000002000 RSI: 0000000000000000 RDI: ff110008ef3=
f4b00
[  101.532327] RBP: ffa000000b8cbce0 R08: ffffffff823bf400 R09: 00000000000=
00001
[  101.543425] R10: ffa000000b8cbc70 R11: ff110008ef3f4008 R12: ff110008ef3=
f6b00
[  101.554530] R13: 0000000000000000 R14: 0000000000000012 R15: 00000000000=
00012
[  101.565652] FS:  00007fca15639700(0000) GS:ff1100104fd40000(0000) knlGS:=
0000000000000000
[  101.577915] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  101.587555] CR2: 0000000000000000 CR3: 00000008f49a8005 CR4: 00000000007=
73ee0
[  101.598786] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  101.609993] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 00000000000=
00400
[  101.621163] PKRU: 55555554
[  101.627358] Call Trace:
[  101.633163]  <TASK>
[  101.638474]  ? __copy_xstate_to_uabi_buf+0x381/0x870
[  101.646977]  fpu_copy_guest_fpstate_to_uabi+0x28/0x80
[  101.655526]  kvm_arch_vcpu_ioctl+0x14c/0x1460 [kvm]
[  101.663832]  ? __this_cpu_preempt_check+0x13/0x20
[  101.671938]  ? vmx_vcpu_put+0x2e/0x260 [kvm_intel]
[  101.680146]  kvm_vcpu_ioctl+0xea/0x6b0 [kvm]
[  101.687746]  ? kvm_vcpu_ioctl+0xea/0x6b0 [kvm]
[  101.695513]  ? __fget_light+0xd4/0x130
[  101.702466]  __x64_sys_ioctl+0xe3/0x910
[  101.709507]  ? debug_smp_processor_id+0x17/0x20
[  101.717289]  ? fpregs_assert_state_consistent+0x27/0x50
[  101.725823]  do_syscall_64+0x3f/0x90
[  101.732497]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  101.740842] RIP: 0033:0x7fca1b8f362b
[  101.747555] Code: 0f 1e fa 48 8b 05 5d b8 2c 00 64 c7 00 26 00 00 00 48 =
c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2d b8 2c 00 f7 d8 64 89 01 48
[  101.776677] RSP: 002b:00007fca15638488 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[  101.787889] RAX: ffffffffffffffda RBX: 000055b3c88ea9c0 RCX: 00007fca1b8=
f362b
[  101.798637] RDX: 00007fca0c001000 RSI: ffffffff9000aecf RDI: 00000000000=
0000e
[  101.809379] RBP: 00007fca15638580 R08: 000055b3c80d95f0 R09: 000055b3c88=
20320
[  101.820038] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffeed1=
9156e
[  101.830642] R13: 00007ffeed19156f R14: 00007ffeed191630 R15: 00007fca156=
38880
[  101.841228]  </TASK>
[  101.846230] Modules linked in: kvm_intel kvm x86_pkg_temp_thermal snd_pc=
m input_leds snd_timer led_class joydev mac_hid irqbypass efi_pstore snd so=
undcore button sch_fq_codel ip_tables x_tables ixgbe mdio mdio_devres libph=
y igc [last unloaded: kvm]
[  101.878964] CR2: 0000000000000000
[  101.885472] ---[ end trace 0000000000000000 ]---

>
> 	/*
> 	 * Init all the features state with header.xfeatures being 0x0
>--
>2.34.1

