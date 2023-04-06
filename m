Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C6A6D8BEF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjDFAgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjDFAgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:36:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF80271E;
        Wed,  5 Apr 2023 17:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680741370; x=1712277370;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wO6aeHCiJVrNeRK5JJpykdkXhNYw/Lge0lSXf2iW0aY=;
  b=VWQZ5K2cQ7U4V91gQjy8uqLm62TFMovkoYNxgbmc+qCm6m6cHRVojxDb
   qyDL9gEm6O35PdniRAiS7LXvz/a8efVJ8BDc9Lqb0RTITwpoxn48Md6Nj
   HcVgxiFUjNvck+UhrKDR3VlKCGdTicO6Z4e45KlqnmjM/gn3yKH1Dl78k
   rL4KQ+/OHKmW7OCGqjA8SDB0I78rg/FPtMs+jfjKB8Y+OvniHDpwObfZH
   S7niDGPa+jdGLssgjDTTOHUL/9lK4ya3VILv7ktDiAIUBW9VhhIPAkahw
   impIfivga8+5+mDNKGwKs8cBasa+h95Rpz89Eq1K7S83PUCOViJ5KLddn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="342616247"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="342616247"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 17:36:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="751450098"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="751450098"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 05 Apr 2023 17:36:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 17:36:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 17:36:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 5 Apr 2023 17:36:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 5 Apr 2023 17:36:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/79dfKOCmK7Vwf6N/dko4TpLejGo3o2OvtACrwwMManHZAQU827JzrNDH+uQ5J3ql5R+fvCTe6jAc9NUVh2K4RPc4nwv/HMhmGGTbN35KrshGpzqW0Clcj8qXkHCrKatGEVYciBusrWd3vCuf1ymikv/cDwSTKfD7gUup2mtdcGkey48MbPgmLPyxEzZU0F8amZ7u9mCBnSbrW3WVByo/dsv4IP6QafSFJ17ZUxwgDx0kyPUkYWFuoHyHWusqu6MqcaSV5O3pEWSI8gJpdDuc3rj/0mzgPOV574OOi+y/ohcWAwELhxFgNpK2muSQH9NS0d4CNhPQcQF9KqT9vrAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nio1cva07ogNYesEQdTQ1fYCampvmJjQ68hVizdE+I=;
 b=lyD8KJslX3FO9hTFWWap79+D7y3jdRBzKGNeU2IDwbRVR6iDtMT8T0EcOzSf6a+QdPodmFJecg6D7n6wA57GGC6i6DN9Ve1pdnwIJ3DV9s9xJTJJd/prGD/eA2CkBe78wxIrMED/xqIimxrBjEWIXpUBIe+pPEHQqFZs2u+fjs3XNzmPajP5szPoDpHJI3JKB2TyQHj8+jrk2oqXZlnbgr6soEbVfUmHty4mTDJ36Zka9r0kn4Ljwzp75e6YvPWoV+s/t919AfoERPcYKf/OuotHlEQOrybaC1Iakjjx/eYXahKTViS1kHxRxBdMpa0ldvOoTjluBNUPkX7TVSmAWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5466.namprd11.prod.outlook.com (2603:10b6:408:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 00:36:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6254.033; Thu, 6 Apr 2023
 00:36:06 +0000
Date:   Wed, 5 Apr 2023 17:36:02 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>,
        Kees Cook <kees@outflux.net>,
        Dan Williams <dan.j.williams@intel.com>
Subject: RE: [PATCH 22/32] ACPICA: actbl2: Replace 1-element arrays with
 flexible arrays
Message-ID: <642e13f27c63e_21a829429@dwillia2-xfh.jf.intel.com.notmuch>
References: <4845957.31r3eYUQgx@kreacher>
 <14903668.tv2OnDr8pf@kreacher>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <14903668.tv2OnDr8pf@kreacher>
X-ClientProxiedBy: BYAPR01CA0004.prod.exchangelabs.com (2603:10b6:a02:80::17)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5466:EE_
X-MS-Office365-Filtering-Correlation-Id: fd5cb53a-7eb2-4000-2d25-08db3636e8c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H/bpzt4KNjMo09PyUjfmNkopqoV9IwYvQ3yiS//IQl1grZdWVkywHoEcUCEXmbz+9d5jwAuKaYftqYOnZbEKOlqnUrAri769055Cx5K9T8TCqgVIvpc2cyK3CE8GeGmIxyTd0bRkgsKiberHTudw1yIlDHI/FdRWSoJbQCFQXqwszunOORWQ2uf8rcZp8A+5nxtmSAVxv/OYC4paP48+AkGge9jydK02MKSrmtUAgGaXdRyx/cZp2KnDagkYZhkgD2zzHAr+BjmSFQ3N6VkzERcdDVlbg9N6p5n21oKGvHuRYfSQ7zL2LV4YkmWny6Bd83GYGuvYeADKE8QGl0tfg8Ux2c7dTiBmFO3lEnRm5sSVhIMmsZtJFnH2epS0PAL9UWbCgaZTLuqYtmvzGfQ8NZPW4OqF6W3s+7G2V2ZqMRBSvhfK4Oo5LmVsXAn7/iiDLuj2pYf1MEJ3YoNSgsYgeQ7C6TjpImIyX84vivaZLvzCGtW/M1zVsSnZqrNmcBwysaL0Pt0DLqjMAZqrHarqWzKgHUWRKu8454TcmsLIAd8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(396003)(376002)(366004)(451199021)(86362001)(2906002)(966005)(6486002)(107886003)(6506007)(26005)(6512007)(9686003)(6666004)(186003)(66476007)(66556008)(66946007)(8676002)(4326008)(478600001)(38100700002)(41300700001)(82960400001)(54906003)(316002)(5660300002)(110136005)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yT3KtGL5EU6oimw4eeQyV8lUKO7VNgu3lfFQnDVpMMmHI8qCGPx5wZbORBWh?=
 =?us-ascii?Q?uTjWP6S5nBHwnXXPM5mpn2PsCqwSbRwNQ9RDQrNaeXrS3+ZX/9cDhAEjxSe3?=
 =?us-ascii?Q?c9DI3I8SfnQmyJc/BpSxPuf8427c6RYhfSCHMK+C57Z3W3iGWMk/g6D4p8la?=
 =?us-ascii?Q?3aJqxp8C+dacRie56MwQ9OvHd1WTC0kDZLiyg2caiNETU3xxROhUcILyxZVg?=
 =?us-ascii?Q?NWpo9dynIWj3dki0hBBD0HB/72TvHYA2awYeIqsCeIgPGryB3VL6cP0qus76?=
 =?us-ascii?Q?ynZbzQiub32KDus5WqMS5EKIfR4h0kk5GjdxnNSxaIww7KGVZkv9cAeX+odb?=
 =?us-ascii?Q?zq75aLSCHR+UhF0eNKtEMwvvCZd7p3yknYp2dD5DC29WcAF5kFu3oUNh8t3s?=
 =?us-ascii?Q?b9E2sTzo8p/9LH50Cy9/aduPI70L7zQA7YqSDP16a15q8v8Nt1OoCvPF9bTu?=
 =?us-ascii?Q?cZQARqpxCDET0FPnu22f1ZYPQ2L5IAFLuqXOnA9Xf5My2rSOZmNHNLD0gTuU?=
 =?us-ascii?Q?iQBUl8XdGBBNQwBrRXAirwMntHPYOML5U9AXqebihfz6kHdaaDsGxshv8OEk?=
 =?us-ascii?Q?atOAfEn86F1DbHJWK4h9qAjKso1zxrl5KvDWUtvgAK/So5Smo76Mu4lSz3rY?=
 =?us-ascii?Q?I6D04q2G2O5w3cnM9ZOorwE1P/8IMfe8bU+XFLsOjl9QmC7tPrNYrDFv8Sfa?=
 =?us-ascii?Q?S2fOW9gkhsYnaqkKgRzF4b9D8kGsGSi8PESSH9qqRYJ8f491ajbb3A6+mpTf?=
 =?us-ascii?Q?Vy+rtufsDLB/D5hXltKWmNfuM9SXEqJuKwWOeV2dnrfljzTzb/eDR7zXLFBH?=
 =?us-ascii?Q?bw9hFldL1uvX3hmFvVY7LGskxs4qMrmzdn+DwIkt3+a7j5b6yEP73fUtY8+/?=
 =?us-ascii?Q?56IE3X4My4z3x13GYZedyY/DbdI/oe7ycNnM2+KYcR5NkDU+lKP3eeQki2M+?=
 =?us-ascii?Q?bXWADWZ5rljs4tgH02GfJ1PDoA3Pgbv9K4JlJkk+G6VJ98Dngmgig07fcKAI?=
 =?us-ascii?Q?EASQo0v67WvONPlk3vooTiDy/4ZXxl+vXoX39BQl2pGCTNcvCwPXmLPw9W8r?=
 =?us-ascii?Q?8mHwqIc7QL3hxo6buOW55Ft8dgNSmMK+tAdLPCnp/GDn+amGhdpP6Efjgs1J?=
 =?us-ascii?Q?BQkZD4JKkHcs70XOIrcqi5qOaVOiFy2aF2/ABZVO1vswMUwpHw+xG+SzewJd?=
 =?us-ascii?Q?xKvPaphC8av0N1BdpZgMpPg/I30PId4p7DeyCrr75T6mEY1m1OJMqBL3Bjaa?=
 =?us-ascii?Q?wFq3ZbohY/l2ThAq+0liBrETk5wzN6159Tg4cnZ0TcsMieDb3LGXIl0H2Rbx?=
 =?us-ascii?Q?ksAwUrvG9SYH7xbFGG7Lx4BaGYc7ioY+1PsKX9gh/1EyguXqCMkgG6iwE4ne?=
 =?us-ascii?Q?e9dVeAIMPpj59TNuEQFPvv3IjDo3OCHF6Z4IMvXeJhI0+FJdUizcvLsjTN2P?=
 =?us-ascii?Q?xc44yQKrj61vl9S3eKAslveL6co8X3JP0AknrhiUhvcJI/lmxM5r4hMVIPu7?=
 =?us-ascii?Q?lica9Qxe63ofA04t63LACys7hheitsSusiQ0anxZWxaPyG7AMn+fnRbTd3qZ?=
 =?us-ascii?Q?JhEkdUmFsIFI2Btn+KJWpT0ezvTdEI0U2PhdFyDYYmrk8y/yVXx/Qqt0p9dQ?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5cb53a-7eb2-4000-2d25-08db3636e8c8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 00:36:06.6071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtwI6kNyTUs9QcXMoY+0wq+VbKiWS5q/erIQVD/khhUzbChtJpJ53xY4baWk07/2mF7hE3qRpRLOixW6wD/+TjGMRDV696YwgyK5QV4hsTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5466
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> From: Kees Cook <kees@outflux.net>
> 
> ACPICA commit 44f1af0664599e87bebc3a1260692baa27b2f264
> 
> Similar to "Replace one-element array with flexible-array", replace the
> 1-element array with a proper flexible array member as defined by C99.
> 
> This allows the code to operate without tripping compile-time and run-
> time bounds checkers (e.g. via __builtin_object_size(), -fsanitize=bounds,
> and/or -fstrict-flex-arrays=3).
> 
> The sizeof() uses with struct acpi_nfit_flush_address and struct
> acpi_nfit_smbios have been adjusted to drop the open-coded subtraction
> of the trailing single element. The result is no binary differences in
> .text nor .data sections.
> 
> Link: https://github.com/acpica/acpica/commit/44f1af06
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

This one needs the following folded in to pass my tests.

Feel free to fold and add:

Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com> 

-- >8 --
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 981f8b0f595d..85d9d67e38a4 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -894,7 +894,7 @@ static size_t sizeof_flush(struct acpi_nfit_flush_address *flush)
 {
 	if (flush->header.length < sizeof(*flush))
 		return 0;
-	return sizeof(*flush) + sizeof(u64) * (flush->hint_count - 1);
+	return struct_size(flush, hint_address, flush->hint_count);
 }
 
 static bool add_flush(struct acpi_nfit_desc *acpi_desc,
diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index c75abb497a1a..745c4a27bc35 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -1878,14 +1878,14 @@ static size_t sizeof_spa(struct acpi_nfit_system_address *spa)
 static int nfit_test0_alloc(struct nfit_test *t)
 {
 	struct acpi_nfit_system_address *spa = NULL;
+	struct acpi_nfit_flush_address *flush;
 	size_t nfit_size = sizeof_spa(spa) * NUM_SPA
 			+ sizeof(struct acpi_nfit_memory_map) * NUM_MEM
 			+ sizeof(struct acpi_nfit_control_region) * NUM_DCR
 			+ offsetof(struct acpi_nfit_control_region,
 					window_size) * NUM_DCR
 			+ sizeof(struct acpi_nfit_data_region) * NUM_BDW
-			+ (sizeof(struct acpi_nfit_flush_address)
-					+ sizeof(u64) * NUM_HINTS) * NUM_DCR
+			+ struct_size(flush, hint_address, NUM_HINTS) * NUM_DCR
 			+ sizeof(struct acpi_nfit_capabilities);
 	int i;
 
