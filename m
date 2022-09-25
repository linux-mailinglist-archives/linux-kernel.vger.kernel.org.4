Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB8E5E90A8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 03:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiIYBd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 21:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiIYBd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 21:33:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B516D2ED4B
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 18:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664069636; x=1695605636;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nYNeVktNQEpGIwu8HmAqber2mcDoJNJbl7jwkHHnHc4=;
  b=ioYbT35w84qFjWAp2jC/gdZDuDaut4ox+8Fn719uCz1TPVVyBfrq+jaF
   /rXEfoeMN3i4cY3Jpcv/CglJG26rfIoS7I5IJKRrDl+NN/rcR3YvhHyZD
   WGGDHwqxCUibfyRjRmM0np5MdkUL3vo/tc11lfy30acqzUspAS1BzuFdR
   1NuJR/KBKAEGizP8qHXsShTqFu8xm/uRGnfMoHMEyPJ/3QGtmChjlhyJ9
   /JMfBkRO+G+tzFO2pY9s00ssYMwtKIdHTiqto5Yhj0+zXTvTpBXDcWwDq
   Nhca3CbO6d8ZQGFPOoLhrJso1y8DJCpPJQ8npLHISDOmpYUk9eWeguuIv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10480"; a="283936482"
X-IronPort-AV: E=Sophos;i="5.93,343,1654585200"; 
   d="scan'208";a="283936482"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2022 18:33:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,343,1654585200"; 
   d="scan'208";a="622926443"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 24 Sep 2022 18:33:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 18:33:55 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 18:33:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 24 Sep 2022 18:33:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 24 Sep 2022 18:33:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gz7yKlRBH1/1JtercJ70+HrsMsmTIQM/p2FXgEFfF/uGE/qrgFEDdNfEBl42MxHSTA8jMmCRYm0UCSbG/NGcIic7nwFIVdf9qEYlTWofO5U67/MCabp9xoF1GQwrKB6VYXux3RuduvXVgmkDUd8qQ1zbwwBnaNkzUFBXPt4rgp3o5VYS2Mm4vofeUuZNhEDsnptXNCLTiX1GkcdHFWWoD8loHKZuyL7AXJp/JaMb3b4driGEPdabCvVYQKHLuQdq3xpld597TyIPMF3ku8od4BxfIs2j7/o63r7xlgq5OBKhkJ7LH3VqUe9dIoGKVbc5RTVLA9Q5XAIQcm1tBiFRvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Mqq2K4KcYYqwDpnvK6kaIVw5QA4Nk7GzOGOBTaOJCg=;
 b=mg0vpZAUjAijdg/ffwaYDNTvsIvcI6axYs4i6F9vUY2Y7Y5khG2D0U5kporXtu+ELc+xzfPRVpLO4Jn/cy8isEh8DWLIEhzfOFXiTuNHY8tHhR9dGoBs/igikkJ31BRq3jhNsOAQiaUzAWf2TeGjB0EXdEcCO2hIFKTJIzb1sRAwdBQIPxp3f08Lc8hfiY1DXGjldfQKuRuDPZWXzxs2NZuzOCCOEe4AmT22UlLP2jLVC5Lzjo3O2hYYucQRWrzNuYPOMhdWhbTePcQRY8qqeBPYUdnrzsQwsoJ0vtPWaqu1AG+j+A2Dc0VAEEYemJyYA0X/z5Sjiyf8qSkzSfr3/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN9PR11MB5305.namprd11.prod.outlook.com
 (2603:10b6:408:136::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Sun, 25 Sep
 2022 01:33:53 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%11]) with mapi id 15.20.5654.024; Sun, 25 Sep
 2022 01:33:53 +0000
Date:   Sat, 24 Sep 2022 18:33:50 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <torvalds@linux-foundation.org>
CC:     <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] NVDIMM and DAX fixes for 6.0-final
Message-ID: <632faffe84f7c_746b294d1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: BY5PR20CA0017.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::30) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|BN9PR11MB5305:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a2426a-fb2b-405f-8335-08da9e960112
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oYbQ4zt17vK1jThlufcOUowWNY8WUwmFs9KbNJbZfpF518BdCEiSfgwSS2+s+yQahyOCyrgVfhohSEGkOurYvM1M1HlFir/rbef7AMPySK4RWeVzB49AptYjDPXT+MFAZc6Eg1OxZOr9hSeaof/upRlC6MP/Ox/NlGmKOPR+NBEnEKpAHSPoamy6Len+0/V2CdUoNp9dqIXMU12hz1nDUsn+7hSCMl+Kd+RogucINBclK7mtKKAqzCGVJeU0WtRyMBgqpNjTrM72eiA6BkvNALRd2ayAZY9tKAiuzRSyRZTp9sL+1rbE5RUVMQeoFdH+4PZ76eyLhfttp34Yad4EzZtAk9jetHBOPslh4W9/ZO6l27agrZ8jVSwTi5ietDDEhHcUvTAhGUNQiqscU2e3y4KLLkSVAuKFeZOW8yfL1NM368HNsOoxbS8qtCL0kW1zZW8L2CXDUnHeRNOzQSKpjFl1k7+R3NNPmnsvIL1S6Gchdxcl0aeADGTrjSPwkBGWvEcLFtBA7RetcTG4QlENNvoVFmBFhbHmXjIPldBHlpUMo1UZ/6UY5SJzrAwczKtGRCTzxwKyXZw4jOaaj6iaUU8bnyerzRs/tNdfDwhjx32sgqdnMfSBGhtws40v+vkS7Wd4KL5jM9w90HkODlEvFao30Navyd98k2XEI4L+NOnHkwt+DyQp6r6jOzRzpoNO544GTFnRRxXEFsVmLJ/Fyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199015)(6916009)(9686003)(6512007)(26005)(41300700001)(478600001)(6486002)(8936002)(8676002)(4326008)(6506007)(5660300002)(2906002)(83380400001)(82960400001)(38100700002)(186003)(66946007)(66476007)(316002)(66556008)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nimA0Qkf3pJch11Gm8FLzptYwLr4u5CKxqAulB5r2MYFUsaa7uWKVPk4uj2C?=
 =?us-ascii?Q?xoatr7+sYDFwb1emZgZ/EWN7aT/S9ys07ra8VXawYthPeyWH2+su4swH9o01?=
 =?us-ascii?Q?7WaCokNP1jcJ+3n/grYVqRvnPHBj1vyBQIKN7mJuFPiCsRBIAYBskJ5Q7L45?=
 =?us-ascii?Q?EjgxKv8w8pz9L+J3jq4qIA9Q4zoo6b+7DL+UDMslVzZDwbSLj2QO1X5pUi5x?=
 =?us-ascii?Q?FqC+6eWmKw/z8cMCq+dtpb7thnUvmwcYyuwDokSTDVL7GcqobChqujU2M8A9?=
 =?us-ascii?Q?EzaMndXio01q2PVJHL7rbsNicf55xpjEYuKXl/48Yu+D1fK/ZtNWUqBUsqKc?=
 =?us-ascii?Q?/wXQRm/9iiEj7KSI06Q2sQF3QjM6SR9xogOtGyY5B+6ArDMwSZG9HQ/b2Je2?=
 =?us-ascii?Q?rvkqtZsL2CC2CBZFU5xazAdZknWNSc/b5M0J6cPkPC1Qoo3vHQlctD7YWwqb?=
 =?us-ascii?Q?yRpIsnA5rf1+EOy7oOUjVdJpH8mpHzlAwpc1gygzO8LE72FM3MhuUQQtZJRb?=
 =?us-ascii?Q?0YBJj9aWIgJYLOBNldDcrNcNz1Jp+f5nDfWmBagvFIYpZmwx2IGB4E2lcBxr?=
 =?us-ascii?Q?ucLJM0lkG1NvvhH29bzj7RC0f5eOwHGB92mXFO2KCEsTmWZlulL/WtsOgm8m?=
 =?us-ascii?Q?6jXzNe+2ju8bFX1LoZ/2O+fwODplAeFKtOkjiFU0pNHJysy9oUqLHKyNVMZb?=
 =?us-ascii?Q?rzAT4k4srlXF9vypgqIzuSxrm3kJ15CnM1gIz/vwoXh/Nh4ZH3Y15La9g3zn?=
 =?us-ascii?Q?e6HYPUj8ahegnbFE94xDVxnASbeF0ADJpCE8iXcWV1sbaj0Lm1DSWlkazohW?=
 =?us-ascii?Q?qWWw/lxziAZvEz3JCCpseuhkbUqfs1LkehKsEGcFlPhglS0obCukv2YdZ5VW?=
 =?us-ascii?Q?n0mnjRpl7y8fDZtoYeXWfYWPAlc5GNmTEu5frwipLVjCERsiGG1kpEIEGB/c?=
 =?us-ascii?Q?Bey/KzOUNtmMmqSUUsgb+LE0rHTEce0/oydoh4DR00ZkHam8Nts+ptX+Vk0w?=
 =?us-ascii?Q?qK3enmcPLFv78n3wEXgeR5JRiQ+YWq//C5MKEzpYpoPMQbKWWHT2HEg1FqzM?=
 =?us-ascii?Q?NCnWoz2kkrv2SqGgg1yHRU4YyMPUlTwYjnm1dDNmF6zx6hDfssMnAOWM5Nnm?=
 =?us-ascii?Q?EW5fr3DD8dfPotNBCL7hZLFH96PJbKnTm0bdwDW0JOoupxM/+AIOLQ63D2Ew?=
 =?us-ascii?Q?bKY0PpaWtdGuwYP+FVtB6x8zj7x7WR4KlSVXh/za1BRXkidz2t6Y4OM0nsUD?=
 =?us-ascii?Q?aiKN5qM4GZsShVzf7OMNN+cZtfOgKtQvl6LqJQ3Kxqy+7nIQ1gj98L/zS5JD?=
 =?us-ascii?Q?r2cQ6ScsnF7Z3fN0zL1FcPYUl/oqhXNoROOvjlvwJ7cYI4ZMPzMIY21BaPPO?=
 =?us-ascii?Q?L5cHdAikGKi2QtbJ8ahhmayJvbFbQTgC5PjupPSmaqvTKHsTvkZMk8QRQlnd?=
 =?us-ascii?Q?kcw9NBMZUuJOtQ4bP27izTMqpzo3zwNJ7vzkRHndAaCGr8dB/XkaAF5t4u7i?=
 =?us-ascii?Q?v5SFkm8maraC35CleZNBsRYo3irtGFQ8KJN6wiQwnQTbLXtaOlaLWiccAMiX?=
 =?us-ascii?Q?ORi0mn2HrfLqPKtxUBkPyHJUMZILD4vFr2vadD5kx/2KnJ7iW8XRDZZ4CpcZ?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a2426a-fb2b-405f-8335-08da9e960112
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2022 01:33:52.8182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewmlkv/bT9tiVfwBuEGg1mJDyozSsedrpfKX6CPUd++PDU0uYOcMFlwuHJRjou8pGkJKmXCc17YLTNxPd0xBoHPmWf0qF23vnXocnj/w8Q4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5305
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-and-nvdimm-fixes-v6.0-final

...to receive a recently discovered one-line fix for devdax that further
addresses a v5.5 regression, and (a bit embarrassing) a small batch of
fixes that have been sitting in my fixes tree for weeks. The older fixes
have soaked in linux-next during that time and address an fsdax infinite
loop and some other minor fixups.

---

The following changes since commit 521a547ced6477c54b4b0cc206000406c221b4d6:

  Linux 6.0-rc6 (2022-09-18 13:44:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-and-nvdimm-fixes-v6.0-final

for you to fetch changes up to b3bbcc5d1da1b654091dad15980b3d58fdae0fc6:

  Merge branch 'for-6.0/dax' into libnvdimm-fixes (2022-09-24 18:14:12 -0700)

----------------------------------------------------------------
dax-and-nvdimm-fixes-v6.0-final

- Fix a infinite loop bug in fsdax

- Fix memory-type detection for devdax (EINJ regression)

- Small cleanups

----------------------------------------------------------------
Andy Shevchenko (1):
      nvdimm/namespace: drop nested variable in create_namespace_pmem()

Dan Williams (2):
      devdax: Fix soft-reservation memory description
      Merge branch 'for-6.0/dax' into libnvdimm-fixes

Jane Chu (1):
      pmem: fix a name collision

Li Jinlin (1):
      fsdax: Fix infinite loop in dax_iomap_rw()

Shivaprasad G Bhat (1):
      ndtest: Cleanup all of blk namespace specific code

 drivers/dax/hmem/device.c          |  1 +
 drivers/nvdimm/namespace_devs.c    |  2 -
 drivers/nvdimm/pmem.c              |  6 +--
 fs/dax.c                           |  3 ++
 tools/testing/nvdimm/test/ndtest.c | 77 --------------------------------------
 5 files changed, 7 insertions(+), 82 deletions(-)
