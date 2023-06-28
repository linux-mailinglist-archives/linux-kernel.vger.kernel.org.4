Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DD5741202
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjF1NM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:12:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:60590 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230243AbjF1NM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687957946; x=1719493946;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kUI2weqV3ohP9ChOhTxlq7GKxntGyGfiywP3meat0EU=;
  b=P0TihiW1dbvJPlgqMDDOt9jClMxwFYj2IdT6PmKTHsbzux72H00/gkYG
   GKn1DLkyZGM8vxcmyCD/27gQErx26CWqRVuVyMFnJ3JgRic1y2h6/BQ23
   dcasZsYSgsfAO/mnvFi5CilHN38rnvJPJvjYPDLJ4+T6bPshKrE2H1vxM
   mi+akT8alWDDye5TOLK5WzoL0LxjxorB6xX+9/Sz54AakgnvyTvgQD+qf
   UKAz045knC/j7aXmrwhcY1cTCzRG1HMAJt7Td9WGfE1BJMuopJkBx38D/
   eR6FkJNk/jcMhaMX420EqPL5jvZUbTGA3oMkh2oQJlG12N6bWKgXrXspC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="427846424"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="427846424"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 06:12:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="752252732"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="752252732"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 28 Jun 2023 06:12:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 06:12:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 28 Jun 2023 06:12:25 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 28 Jun 2023 06:12:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRz33y0m9qiqT/+HVUHjyFpFQAK/iOR0ZC0q2mw0ouwAcp1OMYl93ivNRfkw+P+SJkihn9thwHQGptI+Wv/YYdmwh8HtZZgUPTUATx9yvHx9vqAfASZSbcaQ7s1vaj9wG17nlSf4JXQqNo1kJ0WvK9MRjw2+pK/3pcL9gtRwzvyEbFCy5UNChXlMiR7vsTwHOROjJiw4o/c44Pk7o/2DSMLOfHI9DhMM9a0NqelzPqGK9M6ULadnAy+yNaASbdV2lQcP/Su9AdhKe6JmfnKNNhXRfMZowYnYxDKUg6a2Q4yrNh0PcJk3pVG1nNs2mbb2zwjCTThy+si4bzyQz4YqBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfWTUTdYzxq8deeniVCVr75H0n8iVLlx13ITF9Yvfs0=;
 b=K9/IutXAV/Zw7QhhkEuXsw/XCQ+/vA0eZfBxF5pUPO9bvVed+Er1ob47d1pFo8criV2nmQ4J4vvOxwQZFqSXb2EvZhioDnD8FE0F2Bn0568+0ZFMM9lGoYU/OPAdqlujp4o1GrNzY2IQF86OJsws4LJQiqF9zMgYuPgZXexvzxMeskFshnP9U4rk/tNNCMNCg71HFGWMppy8mm2Mre4Rm/KYqR6TBRkGEk3MGHx+GRwk1avtWBBeZ05QifmCKDLzhvyjX73xuFXm3Um7WWLIIhSI+9wEZFX6nzRwQ2maC8eakpxGpyxazKXPnrI7pq3e+7qHBeQxHilylLger5lQkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 28 Jun
 2023 13:12:23 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::955a:2397:1402:c329]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::955a:2397:1402:c329%3]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 13:12:23 +0000
Date:   Wed, 28 Jun 2023 14:11:53 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     You Kangren <youkangren@vivo.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Tom Zanussi" <tom.zanussi@linux.intel.com>,
        Damian Muszynski <damian.muszynski@intel.com>,
        Srinivas Kerekare <srinivas.kerekare@intel.com>,
        "open list:QAT DRIVER" <qat-linux@intel.com>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <opensource.kernel@vivo.com>
Subject: [PATCH] crypto: qat - use min() in fw loader
Message-ID: <ZJwxmUGPsIlTv+TG@gcabiddu-mobl1.ger.corp.intel.com>
References: <20230627071726.20578-1-youkangren@vivo.com>
 <ZJwPlLC7/sJP8U7u@smile.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZJwPlLC7/sJP8U7u@smile.fi.intel.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: FR0P281CA0229.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::14) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|CYYPR11MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: 21cad47e-b77f-4eed-8120-08db77d94ef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+bXTqpwjkTBf8SyPtSxPiX4REydmRRHf6+75yWkXl8xVYzmAI30FGxmvbaC1GjUx6xb1hJmNn24GaCEZ+qj5dArePdSFRCluLUbnt4quoBMXdQhOVot1t/+pIK1QiEzubRfzdmVaPdOAZIQdzohb0AXi/wHHpvUKHaQ+Hmc842waZbLmA8fOudNq/Z6pK1wNnRh49LrYFdqYWbXnH8d2lycA/y5PiL5KQYwlAqxa+w/lmeGtlz5Y560ugdcFbVipAalBv1rAKQUsVCItpmQXVlSY6uGYQiWywQO8TITpvUoFG0Pbi/Yv8NM83VUt1mf4azWBqjz9BeqSTEk7EcQqIZ9fjhmzN8dGyDAtT0xNJjxsCG2D5m4grz68B28wfseg/3mRscHoVXW0/dXFIqjlTS5uFTG8oLL1cXxok0mV8CWwwO/69zca7jJ5b9yVgv/XziowLfslylyPKAzsJranhh3rpeX/6aGDZnoN3i5Tv7WH5gSP3o31xcwyZ8CONYuE3ZDIebUL8PwhqFMnUbCkBvOA3leYJ+Pzg7dZLpqT0zLqMNOYQIMOLk10XE2xlC2Uc/Z43od/9IcX2HiybhYT+ZLA4Pmx56km6blghOwxrU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(2906002)(6486002)(36916002)(186003)(82960400001)(83380400001)(38100700002)(26005)(53546011)(6666004)(6512007)(41300700001)(86362001)(54906003)(6506007)(478600001)(316002)(66556008)(66946007)(66476007)(6916009)(4326008)(44832011)(5660300002)(8676002)(8936002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N9E3D9FNUw+RKhEPx1LHXrMlcLFuXd/9vyxa2bXOOYznLaXjBbnaiRcUr9Vs?=
 =?us-ascii?Q?rMvGEsKA0IwMnijsNAPonj3xU4jChHety5QotKi7lHbF/IUElfvcgQVEBsm5?=
 =?us-ascii?Q?/5kG7mF3XmO8zNZmT/cOL3rEuL1LFvYU2HyHptmJtY2rr1cTkx1naHysUl+i?=
 =?us-ascii?Q?ol5X7sFqC2AFxpATqD2qOvQubcvBVqm+/tTwSLASahLIwMYIadLRaTX4+17C?=
 =?us-ascii?Q?7OYU0OKNL+1DeoMH2aF6afUO5Tz6vN9eqtOG5tqSvAa++XO/4onRvvm0nc1p?=
 =?us-ascii?Q?TcT/A9KK5xrmCJz74A/XLuUbMSQAHA2Zl+PE/cQiYny9guVwtHbichqGAVJD?=
 =?us-ascii?Q?bLDByiTQCVMxR49UUZLOEIoWXUr0pJoRSGhPRpE1x9tHt6bjpp4sOTxg47fc?=
 =?us-ascii?Q?O3NwgBSaUGE03wVhfgTEMqYHcOrLFv5o9RdeGgvGBAVkP5hilXRja5adLSh/?=
 =?us-ascii?Q?ynGS2ohLhIsNxePISLF6qngm3HSdibFCPa08yN/6qhAEzFp82vdv1kH52ecL?=
 =?us-ascii?Q?FvUjvxOan69hqj40AEKgjfL7B7K/oTzE1PHEF9B6Shh0VHUDTlY4194mnW/q?=
 =?us-ascii?Q?e2x68ALn3u6+hxHegycfvKZqagmlkTWvqqBwqfldXq3O2VqQNI06yrw/deP5?=
 =?us-ascii?Q?4mJXDHgZ32zwMAVH5lXeLKbfFMB+XXli6P8LlfSVMdhokLPar9QL13OQho9g?=
 =?us-ascii?Q?eRrP3Io9HEvbu/eu9jBklfr9BWa5+TrZa8WEfRmBsqbn7zUbQBFRTI8UAV4G?=
 =?us-ascii?Q?VilbWnpzJM7oD9MDs/qn1n9x4JXE9TaxtsX8XJOcRwle18AHFoTiSDkmJLii?=
 =?us-ascii?Q?MlwSBYzsWgZewPSM78/vmdM9zn58g2xCOSrJeEmmz2BRJ5LeuKbGk5zOV4su?=
 =?us-ascii?Q?G7OrxadiXZiFsOPRN2HnR+6xhpqCO5eNjBFYveMg1VFlP7QyN5x+fHrMP1HX?=
 =?us-ascii?Q?LbMyZcqetla76Z/S1SkTX1zNWoMe3uPFiMc7psm86epgyd8kykZ+0g1+S1Gl?=
 =?us-ascii?Q?knbdTkmC/RVtZaAwS3F0G1CIxLfftnpvmIasyibfThQqzJnEsjGjDT21NM2R?=
 =?us-ascii?Q?s1kSwH2CnQuuR8ZHrTAFWJ1MWFHbFfdtLeBkh8KGRNVL8Zd5o3NtBJZ9t94E?=
 =?us-ascii?Q?0wts2en+/60bLj/hZ17WK++r89hnfSz60HdjjFk8tcVxFO4KDbi/+9NTpkT9?=
 =?us-ascii?Q?QZIXEfX9T/IcgunAMSjMWwx5xHeKGitIPfcNsVRjHr1nfX0F3dR5U8tYayae?=
 =?us-ascii?Q?QHxIdMnVJVfS47grMIIQZbw50JwNuUl4WX0ch2vhVPW0i4wkCfjSertXFByO?=
 =?us-ascii?Q?N5+u6/1Y8WcI+gD/gK6mKsaZIeCtvf6wB2f/q4oGuZpFWp1IseMGinw/C7gK?=
 =?us-ascii?Q?wbgyoBnLB6Vl8M6QjkkfsRvpCZnmF0ScqIkaMJeBeUorteWN15AMfWmYFrv8?=
 =?us-ascii?Q?fIn9OJNTVx65XKrqSSaXClpO3zoSizpvtoTPOjDRZtaIA6Flb63ZL2erdX9X?=
 =?us-ascii?Q?jV25WevQXhdONv37Su2Ywupji1lSNdyqWTUuS8w3Zg0UEf+mqZ4/TmfuFUhf?=
 =?us-ascii?Q?QY+GPAqsS9JmhBVFVeWsHi/5ZUB88LQWU+Cq2Yqqu6FJq4Dmmao1Xu3KVX74?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cad47e-b77f-4eed-8120-08db77d94ef0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 13:12:22.8831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lhckro4+GlJNriUOmhkHkGRCSyYeozTvlTo6oEi2E3atA3/cRJfcM1tIceNkXh8klmcKhIv2+NG2Z6dRJbywhUINsHCwgTriWukEkcBk7XA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8430
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 01:46:44PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 27, 2023 at 03:17:24PM +0800, You Kangren wrote:
> > Replace the if statement with min_t() to simplify the code
> 
> ...
> 
> > -		if (words_num < UWORD_CPYBUF_SIZE)
> > -			cpylen = words_num;
> > -		else
> > -			cpylen = UWORD_CPYBUF_SIZE;
> > +		cpylen = min_t(unsigned int, words_num, UWORD_CPYBUF_SIZE);
> 
> min_t() can be dangerous some times.
> 
> To make it robust I would suggest to use min() and mark UWORD_CPYBUF_SIZE
> with U suffix to make the type the same.
Thanks. I reworked it, added a missing include and ordered the includes
in the file.

----8<----
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Date: Wed, 28 Jun 2023 13:32:09 +0100
Subject: [PATCH] crypto: qat - use min() in fw loader
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland

Use min() macro in firmware loaded instead of if statement.

While at it, reorder the includes on this file in alphabetical order.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/intel/qat/qat_common/qat_uclo.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/qat_uclo.c b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
index ce837bcc1cab..6a52a853e2b1 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_uclo.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
@@ -1,17 +1,19 @@
 // SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
 /* Copyright(c) 2014 - 2020 Intel Corporation */
-#include <linux/slab.h>
 #include <linux/ctype.h>
-#include <linux/kernel.h>
 #include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/minmax.h>
 #include <linux/pci_ids.h>
+#include <linux/slab.h>
+
 #include "adf_accel_devices.h"
 #include "adf_common_drv.h"
-#include "icp_qat_uclo.h"
-#include "icp_qat_hal.h"
 #include "icp_qat_fw_loader_handle.h"
+#include "icp_qat_hal.h"
+#include "icp_qat_uclo.h"
 
-#define UWORD_CPYBUF_SIZE 1024
+#define UWORD_CPYBUF_SIZE 1024U
 #define INVLD_UWORD 0xffffffffffull
 #define PID_MINOR_REV 0xf
 #define PID_MAJOR_REV (0xf << 4)
@@ -1986,10 +1988,7 @@ static void qat_uclo_wr_uimage_raw_page(struct icp_qat_fw_loader_handle *handle,
 	uw_relative_addr = 0;
 	words_num = encap_page->micro_words_num;
 	while (words_num) {
-		if (words_num < UWORD_CPYBUF_SIZE)
-			cpylen = words_num;
-		else
-			cpylen = UWORD_CPYBUF_SIZE;
+		cpylen = min(words_num, UWORD_CPYBUF_SIZE);
 
 		/* load the buffer */
 		for (i = 0; i < cpylen; i++)
-- 
2.40.1


