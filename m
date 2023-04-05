Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C10A6D8AFC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 01:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjDEXL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 19:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjDEXL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 19:11:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D647D6E80;
        Wed,  5 Apr 2023 16:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680736315; x=1712272315;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lc2GdTexAxBxyRSuUokBtJtN31VVPJNaMgDlct2yy1c=;
  b=GSL4u9Jmb/mNkOwguKtp0kPYQRGBFHZsraizkZE1o4gvWkUudqBgkl1m
   mA9opViUaqJ1y/u069LGpBK0VaInJ26hug3kIzVig8l/rifHRcE3PLD0H
   EMCNd0PJPBmdgqIiYy3UouPrCIPhOpSaQkaVgNIspw2fPuLpqc1PDfM40
   uFZXptgtP1Nr0qPql9Y5Az1qJLLp/HXTf74TNqXIdtVcGoPBVPEa+b5oc
   6I4pRw8V1zvNOzr2YNcA2FawkwZU6n9d/ppkgm3HUIjrwMeszCx2yvyuf
   /1u1+8xXoqOV4LzbGo1WtK/NY/5TLv8UId+NHE1hD2WhHffR+4srWb3jp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="428880484"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="428880484"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 16:11:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="686899413"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="686899413"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 05 Apr 2023 16:11:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 16:11:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 16:11:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 5 Apr 2023 16:11:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 5 Apr 2023 16:11:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiPIl9F1XftqP2Ipxo7xhUrKbKkltxnSZ3TttAfx+YTbfpbWfKh5esTAq0YO3JlaECVqv3Bty3KjPz0Ib9ZG7mPzngjgs8MtDt23Owra6dWpGCbsxzZG86BtUfMDJ46jXgJ4TSLami6rA6daE05sLcB4l6aFGgAV5o7LASpdiax38SdVv6L2t7OsG1MfscNybggyUhmFXSXQhj2QKLFBn+xFR0K0Pao7E6U1RcgKS+7LpEP/XHQh2dtGHXpkaUjipbd6miYFPK1xMzEzL3hGpVeFWnRWAvzXU7aKOMfSiIR9ov6vujvx5Xfa8O8EkLXD9y6JqruA0tpvtnxGWS0svw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJgjS+0VnMG0kOERjAtLTzVT5RiC4Fh3oQRo2eu1wjI=;
 b=D/xr/3fGKUnU/j/IHdmoXifDJxF6Q5VDoVYWZWurBU20JzmLBDXLoyOr8A3qYO3aksKgHrli5AMIcDGFhMBnTJLekHE/du5GE85tVX7mnX5wwK7MGQTSYugweiNfzhjfrvkE17tdqiamwDpb796iiCbeZmPorfrg+if5hAW6jWwYTGgrkO60jclmsUh2ZlTWYFvBeE9wlLycpSyHWPioLtvq5xVNMK89BtN0FpTds0SnFouz6IC0ENWy6nmq17nDLL7qeQvlOCf450PclsMaqdtUuWHFSQtjBvtgLT1YZtXmnyZZ8Va/rD/9ypPg8x4yb7bx3UXFipHwMSQlVs3WVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7671.namprd11.prod.outlook.com (2603:10b6:a03:4c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 23:11:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6254.033; Wed, 5 Apr 2023
 23:11:49 +0000
Date:   Wed, 5 Apr 2023 16:11:47 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>,
        Kees Cook <kees@outflux.net>,
        Dan Williams <dan.j.williams@intel.com>
Subject: RE: [PATCH 22/32] ACPICA: actbl2: Replace 1-element arrays with
 flexible arrays
Message-ID: <642e00331b335_29cc294b0@dwillia2-xfh.jf.intel.com.notmuch>
References: <4845957.31r3eYUQgx@kreacher>
 <14903668.tv2OnDr8pf@kreacher>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <14903668.tv2OnDr8pf@kreacher>
X-ClientProxiedBy: SJ0PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 0291a30f-2d77-4290-af4a-08db362b2258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xeojY1COzchkoH/CQVuKiOM19HoFjV3J+L0jFeKpmYfVlgdXumCm5wBvStm60JjNS1CMYooFJFGaQ0eI2yp/yL65TQw+Ve+fRaGu/UM2Q9SMBTvMNvmPR0iSNbgZGbGYYGIdyEwa/gLB93xAg8KI6P501aT7yXgFRgI6L6EI4gxCzgDmEiDLYaRrURsDV3VZLGOuecCEBMgjZ/bBUdHdgjZJZslYOx6Am6qT33Mv19etblXqM1+hJg4FkKRUqEt9dyh4k+GDoY0iOXEvvrkyvHDuhqsf8P0S30OpHiXThSp8RfMtfM5VJ+1OvP+R1ATPie067M/O1LCLrdzaAjPdxqs+2firwkZcqzyxEi1wracBEAQMz89noMaykk+eyOUdVJBb3GfSInBs8lYgtylaaLMrkhh7qdHsEaB24YlAsZuYKStQCJskrmkt9KWX7gDGHWouGmzkyKwj8lvI+6qV6T1gUlIgGHGX/R/SyjCW/gxM5Lj7oxVND3vEBk4gb9ER68CwELmGrCrjtnnlbV2g/YB5zLIJFYTj3qqsyEMBgu4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(396003)(346002)(376002)(451199021)(4326008)(66556008)(8676002)(66946007)(66476007)(9686003)(54906003)(26005)(6506007)(966005)(6486002)(6512007)(107886003)(86362001)(186003)(316002)(110136005)(478600001)(5660300002)(4744005)(8936002)(38100700002)(82960400001)(2906002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KpoKEPQhUdd2PSZtmQc/saJvRLpnT7q6r6u21Rz1zl1CHLSTNS05Z+LFEHZh?=
 =?us-ascii?Q?CputbenY+jhTb6W37LCDQrcz0VbJj3I+Bv/H6hFKIHpkTykxOfPBSCUSQ24g?=
 =?us-ascii?Q?K5BctoGUsVRFXUodfpTA264Jyx6qZeSUo6abMyWai6Chs916OE02ke09/ma6?=
 =?us-ascii?Q?x98prq9UqNeQrrA4wcN50yPfMk0iGU2vgql2XaEEbmaLwvIhgM7PgP5piUWw?=
 =?us-ascii?Q?/qMSsN7T2n5N1BYoZX/CP5dilHKhZ6gr6+K5Jrrj+YMNQq2ZK3mJ/M1W6Vh1?=
 =?us-ascii?Q?xeO2pmmfNU7dZdu0Dwx4/ao7SerO01CJic9pRwFuBS5thUVhwAVFy6Unbx0p?=
 =?us-ascii?Q?Ud1g2r3RMpgx58yyvqw68aePYTHxWHt/+X6ZDfHidp5Mq2dUagiWZ5Iz9xy/?=
 =?us-ascii?Q?peYluhlQXIDjCPq2WW7z4SOvsWB7TeYrKys6gh7LtO8fCCDwDvY2DWrRSzid?=
 =?us-ascii?Q?P8YkTrveDGL8O+KeEItJ+alu8G+jJek94SfycqlzhE0sPI4PuaoybSWKOmQj?=
 =?us-ascii?Q?My9KfYCpEelGpkR9QWrIBe4WjJE4r5Musjy6Jg7oGw+EirNFrlpXNCWxyAoX?=
 =?us-ascii?Q?4M8Ex3RPd0wHXc2WmjOk792Rvkd7RCo6bW5s16il/gd4OXBJ+FWlGqK61ixH?=
 =?us-ascii?Q?8xj67xqe3FI3J1WJz+IQCgTsOLVaKZYbuq4J3czA0K7yOOhQiTB37lXxWLwf?=
 =?us-ascii?Q?cdzvqRipZgXLPCaYzhILjJyVSkSKxeFjQ6+/kd37Kr7rW6wF5NNjw9QXLNJU?=
 =?us-ascii?Q?QmrYfQ3g9y564gBFu9V0z5N4lf2igsrL51xjZRTDegscA4OQZfy26roel8kC?=
 =?us-ascii?Q?3l0SRfw189weMb7aSI0W8TsCoPnQ9xllY0mX9P+J/6mOGQzcp0Q+piVlVbIu?=
 =?us-ascii?Q?EwcW2kBp5lQGtH3PKvRNLmdbZ6uvv71yZvd094fF51GjLjFJ3qmgcuS439tF?=
 =?us-ascii?Q?+pYnCHPo1H2F6jKI8+EgczXhGxGvcn4yMCkpZAhr9adSurvFqSPiRNXxB8Vw?=
 =?us-ascii?Q?sj/FSo7L2gsfEed75Usq9aeSsd23WLhd7JOoC9g7TTwoP3m9gf6aBdWlzL6t?=
 =?us-ascii?Q?ERAj6eYprXPgo893s43jSuJILm0DAgU8250cuQZgfy6qzTGnyKkMxtiskmN6?=
 =?us-ascii?Q?A1QQU7uwVirh9Yb63Iqog9m6C+TKsTJRulZGmCBH7NtXntPikthZ2SQWv0xO?=
 =?us-ascii?Q?Fa0CopIxT00EJG0nHw0t+97VK0tWu+sVup4ZQrvR9EByV12bwvafJPl6qBil?=
 =?us-ascii?Q?yZVN2vyAbKWVbIBdtaRraD9Kk183qgCB7SxUh1Mrkbb41WaHkEpmavGWVKVz?=
 =?us-ascii?Q?MTSxOroHT98HOBBNmUovsUI3fkDtR3Juua5tsHgr8ozM5M425B0Nr6udz8lM?=
 =?us-ascii?Q?mmSChIZLDK5GcZKvOc6Z6t9zaXwurbiapXrF+CeofiJox+Es5aqCLV/GHM3x?=
 =?us-ascii?Q?lhltQhqURt63+2BAJFrp313LYPjB4O/0m7F3m0Yzl0AOrZXIqWGulflGKre6?=
 =?us-ascii?Q?Wo8MkuyM7ETbR/jCw8/ihKuI2ubjb14SlzHnzxZPtr3fVut5W51aGOXpSXxd?=
 =?us-ascii?Q?kn7ESxPU/7AGCDlyVXCbIaSdLjCLxhcwOyQUXsnQ6tpXdLALDaTtaypoNN/M?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0291a30f-2d77-4290-af4a-08db362b2258
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 23:11:49.2916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37rQ2B+9l0MfmDSMo8whTyr0Pu0vfps56fm7KKs9Jzcr9xpmZCCpD+DO5XjGZ8+uGjpRayuz7I/tP4d9Ojtid5mE9NZHoQhu/xEeJORox0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7671
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

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
