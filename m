Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF5A67DA18
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjAZX7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjAZX66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:58:58 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FF1127;
        Thu, 26 Jan 2023 15:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674777537; x=1706313537;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ntiSXnMeW/P5XJdwgk+3ngspQdMN7RlLSiWwlXEKhX4=;
  b=iS4gnbXBmgwYgBZMviE9KXZMsjwCy5OwRStp3+F17a+64wBdyVsYF7me
   U71oDJD0mzIlDlapr3xetyVlZudxGrXKpYKcJpTRYNNc6FCJ2AmaEoIY/
   yAlFTbxo7GZyMJXmmIFjisVawyk4Q6F4ed8jLZLlzMvAel5g5HNlH50jI
   eY5/1EQsHGt7AJsoA3Gff8Lkus8uYwlK24/Zwtta3VDf/uHMWUgHDY6CU
   uhfGqzdYHls5DeIV1ashPJhB9O0Re0Do2EdQ/KaLx6MRcbRGeEWr4INM1
   kHK+CRqdrWWo7rgb+uE6GqRc6oWBaGJZ2ovWFDWf37E+HHG+ZV9lF5cP1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="354283064"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="354283064"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 15:58:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="695331540"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="695331540"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2023 15:58:57 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 15:58:56 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 15:58:56 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 15:58:56 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 26 Jan 2023 15:58:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bg8RowKdPymeLZmQp/aS5wdbF21THGjELEuN3Jz9y46bSIqpB5EbaLNRaYq1sxgJBUbPt5J51iEf3afFxShULv3Rm0IqVhfG5EfHSXFq3prsImT6VCcvOofYGYvjFKhyuZ2vqOg9Es3tFEkKGQ6kE2ki03MhknZSChBj65gtbe6su6QGncSLIVFXQ1J9vDs22pXMg7T751m5ectHUZV8FPpdYjrj7uyuc0k449pMX973wA6k51izepO5W9QNhSCDeA66h+MBZ0UsY1TVlxvf8FmA8SLF62flJgVPf6emCg69EhCW713bbZNei8WnIdoSEasF3lSCIzozDJOXR4v9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plf5TjDEt/PxsT9GP5JD7tOrUxVsGw83XA92pH2ZTDw=;
 b=W1PGzgQk0OfFkfc6qNyH1kqLvCVNtZ+hd6e/MjU3jVrsuhUtAS+ZrdrjrAH6g4g/mVtb8ffdzN+osmbGDNvfomFsCR7LWDZH5NGVOcxbDHJwoWgrt8DvK9ph6Ezk4UkdyR3IyKqGKUd5y+/VZwaY+24dSyh0jDKBF8ztvngRQwgrRGKI1EfuIO5cejbHL1EUFfA19gmoMdrFJSaIs/YLrY7ZyMplFsMZ7XCQEhoF9nc0hWJJwijjo3s+wjj09Rmw+weZydf0oczbaJijz04UcHhWE0ukUD+ud83KSBMYQsEIOHZ2qek+bgZisWAkZz2yasjKHYqO8ipwYSes2HxyPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB4923.namprd11.prod.outlook.com (2603:10b6:806:fa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 23:58:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 23:58:54 +0000
Date:   Thu, 26 Jan 2023 15:58:51 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>
CC:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Robert Richter <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] cxl/mbox: Add debug messages for enabled mailbox
 commands
Message-ID: <63d313bb874a7_ea222294a3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230125085728.234697-1-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230125085728.234697-1-rrichter@amd.com>
X-ClientProxiedBy: SJ0PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB4923:EE_
X-MS-Office365-Filtering-Correlation-Id: fa1262ad-9ac9-40a0-7473-08dafff94771
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ijNkakSSd5H3g5sL3iLGSKgZ5GDNLFydZfjgmzYqKI4hiPdY4smXTEjPvyH9UtP2q0xwTHRQOn8L6Cfl+5erwBIFc5arj914gO/qmxI61tEM/JxKRpZjjzn88Zri671K2GS0QsPmpjCpXLIm/eY71ZAQP0K0EMciZuZ99god2vAiolaL+OxGs/Xpna7lWaKvt3CSsY46uBET36+G1sGHCIjKq4l43JjNG0TOC+9kdzM9xkN6uG4sMMKO+v+7h5KQXOTNKf8sDKFjv5+IvCquGMtyJd85HvADkw+hoM8DtAiDwY/+e3/z67qBMZ6+kB7auae/L4eXC4/dHxJ86KhM9L3tPlwcqYuE77Tj55HLL6uANQ6K8qDbE0h4OnML+/XDuLSqJ9JedKsVM1UEWI3sWLv+eB/TuKVN38cla6VlUGklNNR3MhWFl87OIk52L5Idm+LDxJ0vSMq+sCeMjqCc/t8iHojcm20LEOASd1M3dhymAPQGmy+WRmLyKMTTIwOgkoe3vvtRfZWHFlwsId4EMO9Zm/dC7pAYoA6ksNp3r0BgZNQ2Z6DODDO6z1dDQNceGJOWQjT2vFlDM5Xe2A2B5BXwC6hkRU4BuwJ6eG5/2aNlWSCxXR9i4orSB9UlOwDJVcHvdo11P58E9euLPHMgbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199018)(8676002)(54906003)(82960400001)(6666004)(316002)(6506007)(6486002)(478600001)(66946007)(5660300002)(4744005)(2906002)(15650500001)(4326008)(66476007)(41300700001)(8936002)(66556008)(38100700002)(26005)(6512007)(83380400001)(86362001)(186003)(9686003)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gQVlgecv2hatRV7ZCXX9ZMR7qZhr1VVAiyrCInOMdMk5lc6UdinyJGgp7hTy?=
 =?us-ascii?Q?n985vZHykSq4JekS/FUze3YuTlBWTE3zzoWR2DW8ypm4urniFMK5H1/M9Wjc?=
 =?us-ascii?Q?WfBSub+J2GO6BkWM1hPyi3H8y3iEu4FnTWNnStyj2te0xZ9doSRwpMVq7Tr8?=
 =?us-ascii?Q?sZIXLqfJWgos069KM2ijJWKf8Ke6AMK1j72V9g62h3UFkOlj9pdwkqYQtfI6?=
 =?us-ascii?Q?w1dZ6hnrRUD5XCW/EHWUdzSWXmm6wgMSxnyOkNTnETyecHRme+EF1ki66RM4?=
 =?us-ascii?Q?TkYeJyW3gewKEmBxBgcLyxG/NBU+EOoCUNMfB5c6y1Py6DA3MXNW2Xc2vbfn?=
 =?us-ascii?Q?5v1fsAXZbIXg1FZm87IWDCxvdcEepIXggAN+7nDyBUUtI0q6jGfYr+RRGBe2?=
 =?us-ascii?Q?+mPwKVUmTLJJk+eB90AOVM3uH03/UNLKTUvVacQkAepbTovtJQ1mIoI4QiwD?=
 =?us-ascii?Q?o9K3Zm9R12Bd2M1YTNEMHz/kz/4fbOsP6htpncPrlU4wp/LfnhEsgtbqpGNZ?=
 =?us-ascii?Q?J+geyagfxgQmOb75dsDxEaCiOcy87iL1N9/mm3xYnELsGanc6FGLJgeezj4n?=
 =?us-ascii?Q?FCTSlpGoFnooCniY+6Qs57ciQnVgTeGeWZPGqwvyDKjO5vS/Rp8Y9s+x1UxL?=
 =?us-ascii?Q?Et698aVwtIh6PyzSrK8HQbbxY/HQTIv/tsW1zmbAqcDDhQIzI4I2Vd3Rgm/c?=
 =?us-ascii?Q?9AHC6OSpnT07LzjK2ybIt2APxkYMeSAi49zw8CaVu9PqN5CDRbXyURzJ1i40?=
 =?us-ascii?Q?zmF3fck3TTr/MF3e3Dijm1A1NYBISl2orGZdEkfqr14/2dWTv8GugU5gaFlk?=
 =?us-ascii?Q?PL1Yjc92MGRUZ5OabS94eXhrPboROJSiCVi+oRYub2sG1uHfCSwJxFHAQ17h?=
 =?us-ascii?Q?G/zR1g2SdyqXoJLH7ngir73wK1Emi48yCktEH9kjxiC5hI194FwYfsb0PGNg?=
 =?us-ascii?Q?iDTyHtt1z/IURMPIzvf69OJCj/F1X0JGFYN7I+iSwwW5E2K+QhaakTProc9q?=
 =?us-ascii?Q?NBfdqNb6qNU491FeZ7Lo+CNxDLSPt9lPSt6DiKsJFddCgMnmKTt1RRRboI4k?=
 =?us-ascii?Q?3hgk+OuaIywXqQxnUdYmM1iUbWAynHIedZ3qy+OXvgAMIftYV7lk76hPD3RE?=
 =?us-ascii?Q?o9gBlh2+aIYLuLHVo4pMBJQUQdOsyr626zGtySs7M9VXZUfUqGagT0+ImDYl?=
 =?us-ascii?Q?IMFpicRXJUfxD2Wx4pbAcUEEtGX9bmoiUsnwZpBDAd95Gv24VWB5NCvmIrCK?=
 =?us-ascii?Q?0fhjO9B6ZkbkEVVSKslFg1AG5qBCzFYvaJUSc4XTpdwY9wc/Rxk6Tyt9wpna?=
 =?us-ascii?Q?n/uX63WM8eFidILOSJNhNSYgv7qsVuiCIIS118Rl/enIF0Kb3xDN2zAsmobI?=
 =?us-ascii?Q?cCPKHQ3ZOD7zYzvbn+o+XLKAhmnB/Q/Du8d5aH8crwzrdpHpMvqe4JOWfhPk?=
 =?us-ascii?Q?TI2WpRdT6cuZzz1y4lOEgxTyjnbUxyxrxG/idDPStulrnQVN+/DXrG3nSP6a?=
 =?us-ascii?Q?DbbpwOPVzDwr8Iidso1ZiqQAtJI2+WpzcPhnqNE1R9zFEzyONWD3MSjRlMSA?=
 =?us-ascii?Q?22BZMVkf6kMxb/x0x5HcNzlBCy56STZQdf2rLrmsAG4OdQrSJ+Tk8J0g8Fiq?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1262ad-9ac9-40a0-7473-08dafff94771
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 23:58:53.8622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lnCsFYs/gRbPzyglFqu19bAyEcemTEEQiu/k2X3C1rxbCRdhCvQc1kDmvM3sjYIterf2urvEbbWH0ayC8pMV7qmI9rgLyZZ3q5vJP5whIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4923
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

Robert Richter wrote:
> Only unsupported mailbox commands are reported in debug messages. A
> list of enabled commands is useful too. Change debug messages to also
> report the opcodes of enabled commands. Esp. if card initialization
> fails there is no way to get this information from userland.
> 
> On that occasion also add missing trailing newlines.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
> v2:
>  * Changed message to "Opcode 0x%04x enabled\n". Updated patch
>    description accordingly.

Thanks Robert, replaced v1 with v2 in my tree. Should show up on
cxl/pending shortly.
