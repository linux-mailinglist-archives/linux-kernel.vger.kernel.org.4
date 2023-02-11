Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A517C692D70
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 03:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBKCma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 21:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBKCm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 21:42:26 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943AC29424;
        Fri, 10 Feb 2023 18:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676083341; x=1707619341;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yMsG6rYY2Ny8IyvqRQ3uNJmsjniGLiqJPdZtLpL4Cl8=;
  b=P4x63ZC6Ur3W+ijUzWhzBIbwqkrVKnfPvLJTzXbdDF8zJ/6v8nW+HvYX
   VgSe1Oy47o8fn+J/0d9CZxN2vIVcMvjdZ5pGYtB/g3ATJkaYk8zK7Yw2b
   6Qh/LHvKQ8hEEUJ52ooeWJA1Le/0IwhTxrPyGVcgEjThMJZzBWnLiqwzH
   T7Z5kwibIeq1arI3Bm5aljzV8lyW/yQ4+/SvwR37AXfoO2/Q43Qe5bZrk
   J7CyXNB2tv+mTicsd82OFWRUppHL6ds2bPNndJZTRddnFd9QnxefOugIz
   wn4JYGPQBWAsZxsYud+jWCU8JbK2ftTOzUco11F23RoI1zcRQW61ljXYi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="310205367"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="310205367"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 18:42:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="997142899"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="997142899"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 10 Feb 2023 18:42:21 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 18:42:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 18:42:20 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 18:42:20 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 18:42:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNYolhSjCoUHkjSf2cxk+dEj1FEzblP5zrfJMPb6WmfcsyqX8LfEHegH/4T7Yac7Jm2hCK/n2F2NTbJkdlSqkEDlk5VTXF8NI1Icwm8by4IRrMmPcbIRNm839PH6psmBwQQR5kTWI4gYlsDjSnersJYHcxYsrdSpmlv3ZSLVb/q7tkdYck1AUwkMUXsGJQjtbG34E/oOBFAHXEtyjNZuOf5kKG6biFzOf+fMr09SssB5lq8Uwmj6XX6LtGtsPV7zRydYsgH28NX8FwRhHEn3B5Rap332Qo4OdCuTEnDp5RqlK7H4pj6OpRq9P/jo4VyHqcc9L25rXjmu+RUViU93Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53k6HArLzgJUWHGlAK5612L+R068uu+rqrjeYOY7MHs=;
 b=JpSyz3WLIW/s0uLbhKdklF95CnfLr0ziqrQbkmBlJrNT9J+maoiRl4sxSaWDNqnLTpfMEhiJlDwcF90H+0a86f/RNjB95ry4Oj0EaWGm+dgmhBCmPYQt2VbMWRiMoJ+ZOWp2S4I+7Y3ADULxiEwaLdltHi7BYioCbPmf6uUUUVFmrSmyIcoLo7hCrXGmeXc6srzBDgGEVK3OGIJ17Rb4Wi3e4tfCuEPhA/A87ivpRM4hZ41VAhEYKEB5R6EIHEhAaPkuK+V2j2QJCTiCSxcTSiFUj/gb4sv6QCiBccRzhJOQ5DcUVshHFKinWKOHczG6Wg1QT143eD9Hb3S1BnOwUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB4925.namprd11.prod.outlook.com (2603:10b6:a03:2df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Sat, 11 Feb
 2023 02:42:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6086.020; Sat, 11 Feb 2023
 02:42:16 +0000
Date:   Fri, 10 Feb 2023 18:42:13 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <torvalds@linux-foundation.org>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Compute Express Link (CXL) fixes for 6.2-final
Message-ID: <63e700859e02a_88e1294d6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB4925:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fadd24c-a690-453a-9a19-08db0bd9964d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wu7hy1NzFVH0b/Kqu7BdFVjdsHXvI+bySl5DcmLxpIBXHsOM6B7qdj6qwq1NIHUIRCaTJuiDOAfiXKimbuEmlFkWAXX1FepL8+MNaCx1txg6C4e7xNcNElO+fq05ajtAzoxbeYu0PzRMoYgMBrCAj+HREC2So6/6WPuZ+UD0jlejqxKapXut9dKE9lA2QmOY+839ZOVNwRXEM+woPTHQ0eS+hux4RD+tvCYCBcC1UOOG1uIQkhLrSXcSnXQXIdtN/KuK9KtFuTscNSU8+mXGoCPDUzelnQAMxaabVxpyJgTDGDGN+1ZoDQda1xFVO8d6i+41jLN6TdrCqDwiMbqilc0NNRaRb1QHsf1hrihW8IJ6m4YfUCAo6sIm4nB6JlxFsZOwCyWRPrRvGEzSTm2XZfV38kcPu6vLf8YxmNpBXr4DpEvXuP0nWTGLu91ic71e4i3WDprTbyZEhO16ovXAK3BZGAqMZTVd2MWWilid14liKK5N8383liCMpzmthiYJa/sNVpA8ImAIQNVQVVDVbIq/3w2udnd5eq53yKbPw/NUZZzbr+NRNsjrr7xKYgrhyQZeiaIGHG16oLN9ouf9h7Jgeao7VWkYtItdvAAPF4VJsxNra2gnpsyI1LQUK1pheNvirDlhgMTwYq6GAHlhgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199018)(86362001)(9686003)(6512007)(186003)(38100700002)(82960400001)(83380400001)(26005)(6506007)(6666004)(6486002)(478600001)(6916009)(66476007)(66556008)(41300700001)(66946007)(8936002)(316002)(5660300002)(2906002)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ki0kTshfmRGT7D+O2a3FlvIM0cqc2cFiVdewwXlijUdxULK5R/Gvwj4V2pxK?=
 =?us-ascii?Q?Jn5Mra/aanMs3nvmmKWwa5BmwyCva3IQAH1d5xrg6kPefoupuZiEtGfKPnET?=
 =?us-ascii?Q?0ev8VHDM6TSG4xfCUeEMaTY97tZZMj8fWy0c1KidkzJ91HEjqwTj1qaCbibB?=
 =?us-ascii?Q?RWYpfxSeOCpkx42XhSNjbu2Iy8sk5g5VQY5H02veyThPzhJs982agBKtarTq?=
 =?us-ascii?Q?NYvlTWyVy7rM4df6TBfsIIAvGPre2CJQDazrtb3q0Nlp7VcAMRUzyDVKMUe7?=
 =?us-ascii?Q?iNK4OCTKA92Osns/d9n5PLFy6OnBemL1nVSuAnST0tqsNf9j4ZBXtJeslwEL?=
 =?us-ascii?Q?gCvFmB74G11jUEV78Oc156/dTGDHsW7CP80ZcBUXOU74qt9wRtVcES0rjPGu?=
 =?us-ascii?Q?BE9fq5f7uGKemI11Ca4FcoIQ5/MTVogCf8ei6+27loQkW5gkl6Z54pHuYHbr?=
 =?us-ascii?Q?yt2jlQqDbffT1pioxIF2tS0UTqWr5/E4SDTkhRoLMEVWLBv5FYEGkJTw6I/n?=
 =?us-ascii?Q?n25LkIE/IF//7zlmAarzUo950MAhRgo3bliprWn4oNKQi+wPX7bv9gdd5gZY?=
 =?us-ascii?Q?0GJvxtnuBBXHftKzIxI4ZKVi+mBL8VbQcs7QxEibDasoqnbzMdDDqxu6fnYa?=
 =?us-ascii?Q?ZWChls2xAbbH7C1Z9NVHoBeqF0kiYXQ1ywinXcoslItwF4FIefrbkuaw9kth?=
 =?us-ascii?Q?ObslgtH2O2vjbb9jQ/mLDpkPojGCJsDitWMrynvgp9se+9siz1Xn9dehBlZ1?=
 =?us-ascii?Q?rJ0xnFx6k7oNHDetzk+Ime2Q5pZtExnk4pR76/DEnpkzuZD53Rv7he9YMMYK?=
 =?us-ascii?Q?9DpK/l1vpkxLBn71O9dyI8WR2XIuwwvemSWQO+MEbXQkbAiHPvs7ibN17tCL?=
 =?us-ascii?Q?tRm/RrwVV0E1g/SUoqkvzoGCZBHduOHza9gAOcuENAF9YdtVGhF6VuFZB1LF?=
 =?us-ascii?Q?59AJihf9F+oThYcP12PLwY4DEN0bK0zG5AHON+yAYHlgQVJLactchPh1VZwq?=
 =?us-ascii?Q?Nnv8STjqRWrXZF4iNks5I1NZe4CblKkHE3rNW9XWjKyElrgd6029x3Eo7Ois?=
 =?us-ascii?Q?59DH2qwvGWA5v/MRZkBm82IBi93gz+DQjJFah7+8gITwl8Fzpp/2jiHp7T+E?=
 =?us-ascii?Q?3Z0q3m5mgBFGrcvzPYSKpud3Ie2pby+n0mHmmwT93/FX3c+JLeYX5muNGPmW?=
 =?us-ascii?Q?ZAz6qWDy/O3IWP0QcbRFNI2lJ8+o2rTklnOKJcD54Vh4VwN+XMclbJukDXrW?=
 =?us-ascii?Q?hz79NRFAZlSi0lBkHHWrxGiCdzu9xQkzcxg5hzNZekx3fjAWOcTeJYkXAl+5?=
 =?us-ascii?Q?SMM36vte+VfU8z5LDUQxOadOO1ZGk/ZVZJqwyn57SmKra2jVeWjqABIO9ZP2?=
 =?us-ascii?Q?UVv6uW7I/8aSzwYvhgP90VsF4Bcnu4ODRe0BwuUQUfvlsdLCqGNNEB1i/xQa?=
 =?us-ascii?Q?rCOHiaMOysl0q/LSL8BF2W94zicGTjgtLk0Q1t6EvO792kxeW04TChh2vCrn?=
 =?us-ascii?Q?pHAAkRJ7vSNBuMy2Wy3TaCQrbCyUCj+uXJUnv2XT1or/FO7tnGjwONCaeZbM?=
 =?us-ascii?Q?WfgXOAdSntp+w8UaHzLP1XItricIVovU4CPSpkYWmbJgN6yfQc8O5zPKro5x?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fadd24c-a690-453a-9a19-08db0bd9964d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2023 02:42:16.4284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvPRTnmPel//VmQI8upCYHMk9YatdmxFfsFIzlXmrPOMmBw3EO315xLlPWk2SV310qSbA1ik9qy4EScV3qfncRgn23drfbbDy9mfpxwlLXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4925
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.2

...to receive 2 fixups for CXL in presence of passthrough decoders. This
primarily helps developers using the QEMU CXL emulation, but with the
impending arrival of CXL switches these types of topologies will be of
interest to end users.

The first commit has appeared in -next for several days with no issues.
The second has not aged as long, but has been verified by new unit
tests.

---


The following changes since commit 6d796c50f84ca79f1722bb131799e5a5710c4700:

  Linux 6.2-rc6 (2023-01-29 13:59:43 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.2

for you to fetch changes up to 711442e29f16f0d39dd0e2460c9baacfccb9d5a7:

  cxl/region: Fix passthrough-decoder detection (2023-02-07 11:04:30 -0800)

----------------------------------------------------------------
cxl fixes for 6.2

- Fix a crash when shutting down regions in the presence of passthrough
  decoders

- Fix region creation to understand passthrough decoders instead of the
  narrower definition of passthrough ports

----------------------------------------------------------------
Dan Williams (1):
      cxl/region: Fix passthrough-decoder detection

Fan Ni (1):
      cxl/region: Fix null pointer dereference for resetting decoder

 drivers/cxl/core/region.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

