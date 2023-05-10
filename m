Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD5D6FDA89
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbjEJJUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjEJJUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:20:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFECE3A85
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 02:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683710414; x=1715246414;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sr0Ky1DybJmItQV8oi/0I4tvx1LS/SrG2vCU1IALF10=;
  b=NVFdSwHdRnhF2iwjGQ4vkkUhtKy2nhPoHD+9FYXgrs5XdZX7Ck5nSHiZ
   8DzjE4+zqBDmOs5ihQ48rlL4Abqk2K2xzHbuOF/8A8DPc8SKOoVhIb9sW
   c5JD4lWBA1Ix5jl7KLg46SPYAoC9MEoTdWSJkS313yn7RS2hK95rNBDxB
   p+deMjcjNOMEroTxhakVAIJo7LNpa2eRAXV17qam+lB8R78HMXq2SwRqe
   J5ifhJLU6261YPPkJQGbj/pUp99g7q0oJqBlS6lDA/I2Cu0kjvYXdrlU8
   Nr8S9m1ftyzkFP04rv774QeOurn42b/seJzKuro1t7Wl5uc+iq4qgPHn1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="339410354"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="scan'208";a="339410354"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 02:20:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="649683000"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="scan'208";a="649683000"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 10 May 2023 02:20:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 10 May 2023 02:20:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 10 May 2023 02:20:12 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 10 May 2023 02:20:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 10 May 2023 02:20:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaPwGPh9Ibf9Qu3BeydMcLI+LtVsWOFV7BD0kwIxN+YbBXWaulCk59sacn7Rk/yVjCOKoqsd5lDTxv154d2yB5cXZv4qXVWvQ6iSjpkXxeJRlZ8pQ/byN6fvyI1EYyhm46k9BWH10yZkGGT9d2NYncEyViHc8+U/GtoZsn2hQlL9EyB1jQKd7IdLPluSIeCaJnvXUokAmaAa2BmaA624q1WbWtBh9mr/bFahV/I17kygWNPC7OJG8hYoiaZGpwdQO4zOcf0ZaAM77EMRuVs/cifRPjt5HhtwcCdsAamTut5uV7P7oWcHtQl11sQpcE3ZlxpFtrh3ik2DOiWWAb2UBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0K8yVcuQ6LzyavAfgnInFHq1qiGpR7enVOtw0s9UhgM=;
 b=N+G50PWXXPACuF5EhoJpBK3aRrFwjvfIZtOCM3o8+BqLzCcVC8j/kQ9K6Jn1A4sFXGkHHAoyIVy2AynnsCXBG2Q/LHQFvnV6ox0+KpNokQWP/w7vNb8wih52Sxr99ANGYTF5//m/r1ziqgu6jnQalYg1RY699kaBbxoiaHk/sVuK47fe8sx9sAm2E2LKsYqZw3h2F/YVcovLI4prOSrHjbx0Lfaef1kdlbUTbPG9BTv5g5M3zjV52tBSmzcHkUhZVOLahkmnMj4EEGbtTRqDafwfLQ7liyOB+GgeCKNWxdLA2KxRW0+vOt/MQwn7D6WPH+R7IxX0rsIabkwBHltSDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by IA1PR11MB8174.namprd11.prod.outlook.com (2603:10b6:208:450::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 09:20:11 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b14b:5c9c:fa0e:8e7c]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b14b:5c9c:fa0e:8e7c%7]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 09:20:10 +0000
Date:   Wed, 10 May 2023 17:16:49 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Dave Chinner" <dchinner@redhat.com>
Subject: fs/xfs/scrub/health.c: xfs_trans_resv.h is included more than once.
Message-ID: <202305031113.hV7VVc7w-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR03CA0124.apcprd03.prod.outlook.com
 (2603:1096:4:91::28) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|IA1PR11MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 006096be-f102-4704-b826-08db5137c0f5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DeUeEadNWOSaFhYY8vMdwMu3Ca5ixeXDwFPcXgtTWlqjOlusrQuF+vfxBojrzLeIgnjjo5M9lkn1PvE1fekhXvrG6+ORDNl33cTJzCGCMdus5bkxlhnU9KdXuQjIJUazF0b+nlUcXd96Kb6TR6zrXj7kcWj0TiiIyz+1E9R6ptII0uykFbGg0DNBrU5RyNivjhcjq8QPz+I8TWLwwARuuOwBZj8wA2dApwEQrEJ4lhkEV3hr2yZmVbLPNPSKYpXyefNyRsf6ZckSrBvuXYwKzIFW7zO3Gn7K6gPA31v4ScqMkRK4TrQFQEO5W4pZHb6g9VuBmGQU2Bq1fU4ClBGQAIeozrOKbdBVYmlzXbGgjJ1L+UQuSOLFt0GN/UUymuz6fsczvfvcsFhTlWDpDL10gV6JfooDvR2h185lLktDGnI+T+WorJPoc170d2tasFzm1xHM2h1vW37Xk63jzfPUgpF8xV92c1G2buiyG8vP/k/3DYFWOs7Xg5k+dsRyaBXFM+uaCn/utm1p2CdBV7f6Kn1sSwd6rMi4RM5RwDtm6OBTizsVZSmDanR8T31as0q/ls+bB9mrR3zntK4UlDcniQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199021)(6666004)(83380400001)(966005)(6486002)(478600001)(2616005)(6506007)(186003)(6512007)(26005)(1076003)(2906002)(38100700002)(36756003)(4326008)(86362001)(41300700001)(6916009)(66556008)(316002)(66476007)(66946007)(82960400001)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?57brDyLsR/vFlWpP4cwlaTXmtRDb1OKQC3I3thmE6QLf+mGCUgn+299OyVpX?=
 =?us-ascii?Q?PP6DFDI4sZGLa6QagLk/SDKz1gn/lb0yW4M1TqAZRCiFmOO9V0Y0AO7bDRmm?=
 =?us-ascii?Q?fW6cz5qJk+nY3E0TA7lAs9FzL+1vmPAOLS/7Sxoa+T8DihkFbQca12hwXD49?=
 =?us-ascii?Q?t16VX0/deWlkAA9rauDe3tf0lAOcJOu9zVTvnyJmb338vpYsKId/EoIMZR9p?=
 =?us-ascii?Q?H5dnZXLKBzfNxzX5rR7RG+KGeSsfxpWGTayTeslcVaxR3XGO8yundDRj0QQ8?=
 =?us-ascii?Q?Nlvmiik1F4NIU0Nxu//2KZphAGcM9pNTUiiTjLiWSTOZawgvuYEd/6kIbZwr?=
 =?us-ascii?Q?pIHGZJy+qZeEyhA7O9NnkwGT3s5uctJPGQNZ7kBafGuQZE+8MXah2mzXChXE?=
 =?us-ascii?Q?mzqwTV5u+bgR9/TZ/I1iRao4NyMMNCEDRp987hSDGqUIIy3fe3JPB08im2Iq?=
 =?us-ascii?Q?nBUig6HWB9fxaKYOobT0pDTr1fRI8zEmHjXhKZeP03NXlCGVG7vgK4ydOeFb?=
 =?us-ascii?Q?fqLhdicLnfDFyueItVtAufx5PBI0oPCid679pHyt7ReTBUJ0ww1KirdR94vW?=
 =?us-ascii?Q?Rd96NsSUWpBLMXC0cKlasG4EuI5o4LbMsVKZ81ugjUzvLbmAj3fvP49ihPBF?=
 =?us-ascii?Q?NGnAwn6Y28nY4JoFn1oRu943un0rO7bFDQh9k3DhI5RPO+ioQwkrgiVsmcNd?=
 =?us-ascii?Q?Rjf0LrVN5F6z9hvWdiLSEeKUFQ+eIyu2d+BqlhIMg35l5MyYbC8/5VHKt0Q1?=
 =?us-ascii?Q?/Of7h7Fnpk2WgBn7+AEefs6TUMvi8nq7SAhCaEp1bF74q9JkCBVYW2WtbKxb?=
 =?us-ascii?Q?gAzHYoxXiSA7BsbybC/XeDt9SJUfeanGj4HXxFErWAbxVNIt421iOyYscs0o?=
 =?us-ascii?Q?UemBuO4/yrY6COQdXI4FUrpHkRFtGprh2vY9zdEMcjK/C2DN1SNlnPu/qvpz?=
 =?us-ascii?Q?2iiSGJee0tKz3R+aZFH+tqY5bcIKeWrnzNp3FjcnEs3pDrCaRvSpwk/uQRVs?=
 =?us-ascii?Q?g30XgsqzBLwQ7nroo9HOTT8BDTdifbgQnzoSxUEt6JnE6SYHGXgsPLcJ6XX8?=
 =?us-ascii?Q?mVGqrM5IhCTxxbLeIEW7nXY6/L2cgDcQQb14o3ILB3wPKITWqcgLFP/hW+ga?=
 =?us-ascii?Q?Fj/2k1b58a1PbXG5VrywO9FAfFs/nmIaJAgPzTniPuiKCp/vAl6YHlH9irjW?=
 =?us-ascii?Q?KzrSM/87eHBI2R2FfQ3gM5W4rirUjKP6xGkve4LAdFgey6xYljkCaS2IunM9?=
 =?us-ascii?Q?65qHsZanBp+9xvYxqRyH9yKRTrYhqIAmK8PV98M0aIIwDZQHb4i5InCslRqH?=
 =?us-ascii?Q?zo8W9HzJU+NFO2pj+413O3dWnMacjfIs/1YTFumzuQY5g33hB5I4JyLo0RHf?=
 =?us-ascii?Q?VCdcvau5nKu+476noxgu2E4cayphIr5yduTVnzLdPS2yH1BhqZG9m29tTRnz?=
 =?us-ascii?Q?jbHBwMhc/UPjsZS7ITZAvPe6js0u74ASf4gYy8h0FJREt3kTdjaI9wsgiyMq?=
 =?us-ascii?Q?FZTnF7IRAFwGZe42ugomv9rI/1L7k+rxg66OauACwrfQ/N11BMZZPZfdzUSP?=
 =?us-ascii?Q?Oei1XyTk1GYVtpPKBrH0BcWYLgIE5BvUNjIdEEfN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 006096be-f102-4704-b826-08db5137c0f5
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 09:20:10.6738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0t/TO3bsWKyul1YJMMT+73NUtvKhX3jCNtMvF6Z2yqAf8P73DLq7SMIApWv8W0OUeD4vmuPSior9xOcuwzIOig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8174
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   348551ddaf311c76b01cdcbaf61b6fef06a49144
commit: d5c88131dbf01a30a222ad82d58e0c21a15f0d8e xfs: allow queued AG intents to drain before scrubbing
date:   3 weeks ago
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Link: https://lore.kernel.org/r/202305031113.hV7VVc7w-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> fs/xfs/scrub/health.c: xfs_trans_resv.h is included more than once.
>> fs/xfs/scrub/health.c: xfs_mount.h is included more than once.


4860a05d2475d (Darrick J. Wong 2019-04-16 08:22:00 -0700   6) #include "xfs.h"
4860a05d2475d (Darrick J. Wong 2019-04-16 08:22:00 -0700   7) #include "xfs_fs.h"
4860a05d2475d (Darrick J. Wong 2019-04-16 08:22:00 -0700   8) #include "xfs_shared.h"
4860a05d2475d (Darrick J. Wong 2019-04-16 08:22:00 -0700   9) #include "xfs_format.h"
d5c88131dbf01 (Darrick J. Wong 2023-04-11 18:59:58 -0700 @10) #include "xfs_trans_resv.h"
d5c88131dbf01 (Darrick J. Wong 2023-04-11 18:59:58 -0700 @11) #include "xfs_mount.h"
4860a05d2475d (Darrick J. Wong 2019-04-16 08:22:00 -0700  12) #include "xfs_btree.h"
36029dee382a2 (Dave Chinner    2022-07-07 19:13:21 +1000  13) #include "xfs_trans_resv.h"
36029dee382a2 (Dave Chinner    2022-07-07 19:13:21 +1000  14) #include "xfs_mount.h"
9bbafc71919ad (Dave Chinner    2021-06-02 10:48:24 +1000  15) #include "xfs_ag.h"
4860a05d2475d (Darrick J. Wong 2019-04-16 08:22:00 -0700  16) #include "xfs_health.h"
4860a05d2475d (Darrick J. Wong 2019-04-16 08:22:00 -0700  17) #include "scrub/scrub.h"
5f213ddbcbe86 (Darrick J. Wong 2019-11-06 17:19:33 -0800  18) #include "scrub/health.h"


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

