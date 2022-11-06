Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5E161E53A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 19:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiKFSJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 13:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKFSJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 13:09:15 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F717BC97;
        Sun,  6 Nov 2022 10:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667758151; x=1699294151;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+TZVkGFVTX40Ps1Gnbw/hYzfUEFLIkEinX3C8lLsuiA=;
  b=fXWMLSlePnlV2CGjfgTKQ9Nb59FAt2p1mO92060Rdetb06vlRxBh9sD4
   +qq5Xwk1PzOgWmYOiNTqoywRGTblSRDU2+Q7luC/ZH/zVDknVIozIRKGE
   xr+DodvdNed8kUxrt5+zyzVqEdq43SnJrVDuMucfNHItLpo7A+d/NvhE5
   hLEyZvMIqengBuBZpc7NmQkDbIR4Ep63tpvmQRfwAVkOw3aVotig6enGw
   4ELEQnXqhpYnNb84e/o8yHPicxaS4WtHETVfG6oEAnfGCfTemXomOvCb0
   nosCMBs85PLVGkJuwM8BQjmDTQl+uM2gYcYGTDQw/onQRRNcI6gXYxQeV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="297760563"
X-IronPort-AV: E=Sophos;i="5.96,142,1665471600"; 
   d="scan'208";a="297760563"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 10:09:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="630258976"
X-IronPort-AV: E=Sophos;i="5.96,142,1665471600"; 
   d="scan'208";a="630258976"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 06 Nov 2022 10:09:10 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 6 Nov 2022 10:09:10 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 6 Nov 2022 10:09:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 6 Nov 2022 10:09:09 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 6 Nov 2022 10:09:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9T3UA5Xi1C+Zt2GK/LmAuSeBrHyfN87zACk1fFP82aVH8qF97eLQG4xQu5tSgb74tRDKagJxdHZ/vINEW2sIQzsdPyQSt7TdxqF+FdeCFwfLOvKMIp+FplmBYX3mgKs++fm1dz+h2XnHBH8dR4LK5XmjZn4B/5pLeu7j/RjE6Y0EmtH3bk91EFVq97tHHTSjnceA3ApI+UdYg7crxYdMcHj09sBInAY1mxuUw4PZoz+627rEtimnagiakIXbK/yKWa0Y4EUt3RvE5hw5b0bns+2dryIYwz9qcvFRkfHYrecXo9FdhthB5Z1cux2S7VJhEl/+NYKv6cP2mIDRyxvTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=869wVCWwdYMiWtoQRC6tXgZPVkWKo9EMcokBJOm9X90=;
 b=S+ZpH2kw2agrVVHQzTX6Huv0ra2qAWpxnZmlJD1+2DQprKMzun5pCnW73KX4nAvs36KPVrTsD6jskmp5cSqHZKf+CR/ZSpE5IQKEKcD0jC4v/wyyBNViMUKzpcmYEdkcm9ZGyudFH/ASqrSS/xnaP1NM07kmnwMUiYgXT2YiREejCh8pgpbZnBQKSvC5sWSa1RGqCXi3ztm8nIJixPsByO5JeaT1Ses1WMwNCZ419by4hkyPZAukka5s9BsAZeL1h2hcRPh2lf0uIqLJ2TDNdpFVblUgPkPGrMoF+2bTIUcQ4lcgcnJ00ByrIHj5Wm1WJT6b3m9kvcqCi0ryus3W4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ1PR11MB6203.namprd11.prod.outlook.com
 (2603:10b6:a03:45a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Sun, 6 Nov
 2022 18:09:08 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7194:47de:c1b1:2f63]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7194:47de:c1b1:2f63%12]) with mapi id 15.20.5791.022; Sun, 6 Nov 2022
 18:09:08 +0000
Date:   Sun, 6 Nov 2022 10:09:05 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <torvalds@linux-foundation.org>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] CXL fixes for v6.1-rc4
Message-ID: <6367f8419c601_35f43294c0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::12) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SJ1PR11MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a016f21-903b-4ccd-d411-08dac021ff57
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O1VWFHi3ox0NMHKuMw6rPQ612Q1uV0IGxH0VkY2ZnLdkECth+kqccTgc3rZI81oQKCMt337J+qS833pMsBD3lJpRLuzu1SXKEoaPH8QvdxHtiRLKCP9s9pKIgdor2XMCnHOFpCI9n38bTV8e9LkOSXJXHUs0YoxvEwNQ5W8zYFPEsc0a3W8akX8x4nqyjngFoR/sdZbFmEgJofX+muJclWfMxFm7jV67OwMdfPS+/+6e0E7bVrju8Iro3TxADDlr0IzNInLbfqNgn3fTsgLk8/tXvMNVAGzOFFGXDdRek8ctBVWXA4EB50rd85zJLDf4vzXt9QTU4sBQ8drty8fD7je2B7uMzHkvTn5hdcme9tRA7ygIkQ8VwgCtWug7x1oy6aXqmUwyI3u/48FMC0pP3Hi7jj7zcMLvOBruXa1rETgVolhr35th9AATthlkBRgY3rHrEMTdHP2fSIFhGltZwfsV20qK1pLgRUVkCzqlL6o9DEE94A+87e+/ptVp8IyUshgOOZbSZlCdIGyHP/rMW/K4w837hO4StvRjhd1FeF2eBh7xJZoi8RtVmVZOGIA0xYHXYlrMht7oUDchd8oxGnpzcc4iUy8zr/2Uc3UwCnW/bDriAVS443q+vEkYDWq4EW7wuBkOZuUzn5+qvqxPb9qOzCZLOEZE2NLkHfSod4dYhHBNxGDcBWFxw9kPEDHXe5a0BK73Ch7k8VxJbISyig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199015)(478600001)(6486002)(8936002)(5660300002)(4001150100001)(2906002)(316002)(6916009)(41300700001)(38100700002)(4326008)(66476007)(66556008)(8676002)(66946007)(83380400001)(82960400001)(6666004)(6506007)(86362001)(186003)(9686003)(6512007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vg4HznmOV4vGAZLEY55d/3yVaUu6M4bCeSJVVK5BI3ozLUxzEk5d9m1gBJwV?=
 =?us-ascii?Q?45+LU0AisSD93FYalYh3pStg8d4z/EGKkom4YAvShRWG3Ds8eEquG1/Wk2hI?=
 =?us-ascii?Q?csE+IY7wD4B1FfiGOpbVq1QsJpMQAJwNHSwB8g02hCoADHIsd69PQcxd69gV?=
 =?us-ascii?Q?qLPs09DEp1SjdMflNN/gG9UdUSk5NkrNIfTYiviaooKJQRJHKS1XVFKshhUM?=
 =?us-ascii?Q?LA7qB2QfW7P8XmFLWLmUoB+4BnCUcgq8VigLld2fnBNTGPDWanQ6wBYD8P0i?=
 =?us-ascii?Q?dBB2JNCaLGc1fFZl8pk0bHLrFQs6telPrNuILch/pgoixjD500ewqUc1VGWf?=
 =?us-ascii?Q?ejq1bZsBq1Rx+baq6rHLh6KXoXnlPuspxeKAYBn7XWYFTWQEzFalF0T+ZKqT?=
 =?us-ascii?Q?6TpASK27uhHkB5k1DhCXYolYdxalj4pklLvlERZRSvz/wtQVgJnzWqnx7RNe?=
 =?us-ascii?Q?OZqbPLZM4dBKI8JJsCqtmnd5/x0utZy2qBjhceMvL2ShEIciSzLQkcsqNXUS?=
 =?us-ascii?Q?yj+UXJu5ciOTB67urDxgP3Rj4vsMJCgB3XmkmYAAJHOZqwfaRpRjGE467QE2?=
 =?us-ascii?Q?dpmPJN2qB25CPpp7hMfMd1Iqw9OUG6jDaO5itP/Qzwn+PN8ey2l+p9kU/REw?=
 =?us-ascii?Q?90av+uT3DfuN+m/g3/xoqJ2PG3k+3E5P6691IRUIpEU8J2H31OEEAX64uAsa?=
 =?us-ascii?Q?V3ddWSJCk8viPrVxTuYmddYx/liFt3Hbc+j0QkBo9xgoXWaXc83SV7+WEFYy?=
 =?us-ascii?Q?cKDmVw5ewKURu5Kx3ZCpfTzTYsr/7USXnYXepEirQF4joGK+ttTMkPmwzPoE?=
 =?us-ascii?Q?ohkYB+aMNDoi5YlB9hGO57w1P6VA1ySotOD17pC57FWFuQ6+E4AS8N+EBe/x?=
 =?us-ascii?Q?fmkqL/bnhlCHQACNM42gF87IRa5ED3h77c2KEmvEdXQQGwnnkZWQ/LmO+E5D?=
 =?us-ascii?Q?UShslqno4/4T/dqZY1qTQL7HjPua1hRVLQwGg79mpjW6OF8YphkD1YATPIj/?=
 =?us-ascii?Q?KRhfMKzeK+glMU9o2cdxS7jN2KuEkdvIz1+/Z2bAZX5cwDWEvcf0U5LruUr1?=
 =?us-ascii?Q?RXKBtjaD4L+9KxFhPQbRf5bRZ10bVi671HIYlCJSEmdkXJ/A3JDtGCZ3AQY2?=
 =?us-ascii?Q?V2Dmg938zmmG1WoIRQn5596D5v845oX+psYf3c4KSIUT7RZorUxueeggdmny?=
 =?us-ascii?Q?8fkKgvsPspCbbP5NjLvcRW919NFi55knHFN3mgqIeAIZSRl11cYsnnVgHqdb?=
 =?us-ascii?Q?CJQdIJkNShQbd4kHipdJC/j7lOhO7Usznl9BQunVtQsXTjzVPAtVq5wNzfFw?=
 =?us-ascii?Q?ydimGpzVFv/yy+nDXJPn+Ifff7DOQQmWpc4rCIB5RB9Wlp2p1cC0xR+7qWlf?=
 =?us-ascii?Q?KleH3wBnAa6omw18Lo4qGcR+g/kSxWGjnBnGOL4RI/3H5ujwwYaz59agRiGY?=
 =?us-ascii?Q?Ttc9sjvdZfIbeEoWKSGYDnjdFrZFCxAn0dI49harZkM5ClDrOTW9vSXbZbjh?=
 =?us-ascii?Q?OpyLrDTykYXE73N+KHzpZ46DEy8qJxpzRoW3ryve5H0K0KqpHU8r6EHRVD9l?=
 =?us-ascii?Q?dzX0y4YFsDbOkNhapitgqGKOE5otuAbanEj9zBvYR3EhMsZju31eXj8zNgut?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a016f21-903b-4ccd-d411-08dac021ff57
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2022 18:09:07.8777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5pzky/XiE+JbLSQp1tbYyj6aEz8NwKbG4Cq8QTkabVJmEo58Y1Hq5DOkjjCn6TLLC2lGSVFIz4OGgWbu2PH9lGQwNX0eL47Z1TVkr3JXL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6203
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

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-for-6.1-rc4

...to receive several fixes for CXL region creation crashes, leaks and
failures. This is mainly fallout from the original implementation of
dynamic CXL region creation (instantiate new physical memory pools) that
arrived in v6.0-rc1. Given the theme of "failures in the presence of
pass-through decoders" this also includes new regression test
infrastructure for that case.

Half of this has appeared in a linux-next release, while the other half
has been exposed to the build robots for the past couple days with no
reported issues. Rafael acked the drivers/acpi/ touch, and the risk is
low that linux-next will find anything wrong with the rest that is
self-contained to drivers/cxl/.

---

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-for-6.1-rc4

for you to fetch changes up to 8f401ec1c8975eabfe4c089de91cbe058deabf71:

  cxl/region: Recycle region ids (2022-11-04 16:03:43 -0700)

----------------------------------------------------------------
cxl fixes for 6.1-rc4

- Fix region creation crash with pass-through decoders

- Fix region creation crash when no decoder allocation fails

- Fix region creation crash when scanning regions to enforce the
  increasing physical address order constraint that CXL mandates

- Fix a memory leak for cxl_pmem_region objects, track 1:N instead of
  1:1 memory-device-to-region associations.

- Fix a memory leak for cxl_region objects when regions with active
  targets are deleted

- Fix assignment of NUMA nodes to CXL regions by CFMWS (CXL Window)
  emulated proximity domains.

- Fix region creation failure for switch attached devices downstream of
  a single-port host-bridge

- Fix false positive memory leak of cxl_region objects by recycling
  recently used region ids rather than freeing them

- Add regression test infrastructure for a pass-through decoder
  configuration

- Fix some mailbox payload handling corner cases

----------------------------------------------------------------
Dan Williams (8):
      ACPI: NUMA: Add CXL CFMWS 'nodes' to the possible nodes set
      cxl/region: Fix region HPA ordering validation
      cxl/region: Fix cxl_region leak, cleanup targets at region delete
      cxl/pmem: Fix cxl_pmem_region and cxl_memdev leak
      tools/testing/cxl: Fix some error exits
      tools/testing/cxl: Add a single-port host-bridge regression config
      cxl/region: Fix 'distance' calculation with passthrough ports
      cxl/region: Recycle region ids

Jonathan Cameron (3):
      cxl/mbox: Add a check on input payload size
      cxl/region: Fix null pointer dereference due to pass through decoder commit
      cxl/pmem: Fix failure to account for 8 byte header for writes to the device LSA.

Vishal Verma (1):
      cxl/region: Fix decoder allocation crash

Yu Zhe (1):
      cxl/pmem: Use size_add() against integer overflow

 drivers/acpi/numa/srat.c     |   1 +
 drivers/cxl/core/mbox.c      |   2 +-
 drivers/cxl/core/pmem.c      |   2 +
 drivers/cxl/core/port.c      |  11 +-
 drivers/cxl/core/region.c    | 113 ++++++++++++----
 drivers/cxl/cxl.h            |   4 +-
 drivers/cxl/pmem.c           | 105 +++++++++------
 tools/testing/cxl/test/cxl.c | 301 ++++++++++++++++++++++++++++++++++++++++---
 8 files changed, 448 insertions(+), 91 deletions(-)
