Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E3165C5AF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjACSHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238434AbjACSGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:06:47 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCB698
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:06:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtD173YHCs+VWco+tQIHL6QC4LaIkqt2J9+6MhVHj32K0JBSUZKCf4CU/4rI7tD/MonievcJ4az2CRK7OyAehiMJ0bGO0x/etM23Gn5Zqa6tzt5MxwIMwTELY1/aPfvRX26d0M4A12YYoh9ZSJwY6gptcjooEt5e+jpViMf6V7+sN+mMSqM9WrO1zWkPTWLxKJYxAbYb5L2ra0Dg4z9o9oUOTaTAFYLZLqPej5pYuna5uyAa75ewAqAU09Iu7+3T/DubWb5dIm1tpJDAuG+HWtujEoBJlpuiLKIckfnimbcd8SjO4uFDXv+WpKwciLo177nG8Ktax6DPXPokJIf7Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TFbMkYPCk3R6NQeNxeG4DZ2uIpm2abFgNmWB4dHCiI=;
 b=gd3bfviAcaBoILYkWl2R56u2TxNfLq/VCYrQLGgBs6oHU7IpM/0j/MWxslKBGgtUXe5C+7TJS24I5cfP/Ob19rEnQcPLdN84iWG5fIwDpm23DDZ5h5gMPRG8WO3uRS6hHMokFuWtGa10oD9NgSmAJlby+jgOYl7Yc06HLV0nJcwKZExpI8ztvtBszZxAkqVO8cgO6XJHNHVfEh4yTv8fFffhvrQ5+4a1XtGch4gMJHOd7pNYMskEGVMtGSKWd8Kih7kLOun+TtxnD439k/LhP1sVQzkLVGeJRaQnp2MUietPP6lWtTmIXaQo9ix4X6OYCfB07yAyq1YUugFNtPzpTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TFbMkYPCk3R6NQeNxeG4DZ2uIpm2abFgNmWB4dHCiI=;
 b=kEnMdToCQXRWTdHYe5m5YQ47fGuFt9BDaMeBZYkGlh00V+tgQtsaYBYCJALed3jxv6uqrYb7RV9Ilm8FR0Qnr/sBWPXDvYlUFLAgCyRk/l66fwmjIbj2CRpZVKkaTYsF5xls4xbGlPKZ3kH9L5/RrcYuWDuAi5ONYrsrrwOEXb2px7mz+3GqWD6mvT5pYDf0s9J6+LuHpKIeHdj6SZhwg3kZ3oYBoGHlLaMzM0qoISENW3sQ216dVemSZNICTjXmftAlfEPY1WR0bg0mARd3WlPtBv7y6dBEeWhqYjL1VAdZokwagbhYfjeTmAsMyvaQv8G0DdfY5rLWODgjseq+Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SN7PR12MB7953.namprd12.prod.outlook.com (2603:10b6:806:345::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 18:06:44 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::2585:153b:98ea:3e23]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::2585:153b:98ea:3e23%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 18:06:44 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH 1/8] migrate_pages: organize stats with struct
 migrate_pages_stats
Date:   Tue, 03 Jan 2023 13:06:42 -0500
X-Mailer: MailMate (1.14r5933)
Message-ID: <5ACB3CB5-158D-4487-B005-3BA573B15A3D@nvidia.com>
In-Reply-To: <20221227002859.27740-2-ying.huang@intel.com>
References: <20221227002859.27740-1-ying.huang@intel.com>
 <20221227002859.27740-2-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_7CA37E54-0FA3-485F-A288-EED0D31A72F6_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BN9PR03CA0453.namprd03.prod.outlook.com
 (2603:10b6:408:139::8) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SN7PR12MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 6407c144-4708-4f06-50a8-08daedb545e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KTJP120D6IhQnhVWGrF+X1wArEM3DLjDhZ7TchT8yU8zufxXA6YFnTJpAOE7pAxly0Yjg609RaXmuMr/1/s554KZwATPkOMnNpGs3owWE+cXNbpYD78FvjcBXYTkyZr3G5H6/AYmzOKAn1p7qJo9HUC0m65Zxk04x93Xw9cMN0wEpKdO7Ip+wp1aJKHzyGpqj5IUxeF/cHIMyiJZc88jCG7oiL7/Re2rcSVWIUkDgHYTvJGBQbDH4T+eNWQxPkqPJlUR896aGofBl+tZ8yyYP74G/NPBqQdREvQ8EvtK7UUGkoXSHKdR2RysZajgWrptykZk1v3HEonf2OFPNaeoIbdWDBsgh/p8yOMveRbHuUlIwHcrtfjOR0MWkfT1gu1OPoTuL5C7JeYDkNrU1lO2vb49uLNuxrl2ZxMGEnA13zgk+AKtApYRkG3pjYeXWQbhmqoR1AE84FagYrDblWG3Y9VFnSY9nwjdnfmKqu09SVi64FmO9csg5wJ8vnWDncaCAGzTkSGyATFZ2rKytbdsbX0JQV/O1h6vbfFfIIFXq78FgK0NUysQerkC5s+4X5I50fxqs6kk/46RK2ACIxxvqelKgzunlC3pWZb0WWBTrv3BbiKkl93dzVhr+U5dI7GPuRfgVFEVufYLq85E7091e5oOKbbaHX4ddqMeNtkk82aBPyH23ROGiXLOzfYpuPj1PvGnIQxpAj3hZl+/PIFYQW21584YlLnyIPRaWUXiI67aJbkwbEzp5Qe4tKttnE5t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199015)(41300700001)(38100700002)(8936002)(4326008)(5660300002)(66946007)(66556008)(235185007)(86362001)(66476007)(8676002)(7416002)(33656002)(2616005)(6506007)(316002)(6486002)(2906002)(53546011)(54906003)(6916009)(83380400001)(6512007)(26005)(186003)(478600001)(36756003)(22166006)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KQLno8RpqgRz3ntIQ++fSYjTVlaR3wbl6Mgerf6tC1ZG2Hb7C3ZykqcDM7gP?=
 =?us-ascii?Q?JY7JCLo1abkDyY+y3Mp+kGwjQS0rrcij0IQi53Ammkks3NcJQuV7A/M4bx3v?=
 =?us-ascii?Q?9oJ2zc64Y03OSVtegw5oWm9VZzEu+0wZn4+jpiwM5elcAf5cADS3FObeK6D2?=
 =?us-ascii?Q?uR4raB1QqMgzZ3ZOxH3z70rrjb/Ra5niIP7n9PxSAgxhBr2BIn4QTC/TX8o7?=
 =?us-ascii?Q?FzShUZDpLZZEFvQJKa9ouQ8H9pBU0VcHMoy2pal+yuLzMeEbbNM8axmDj7fr?=
 =?us-ascii?Q?MHHc43o0WGSlMzeFu25DRlvy1VrIiXyupTO8WrOMtjy4ld4wQFmVMmf6PV4o?=
 =?us-ascii?Q?Mdja7wT4gh1yT5z5q+K3rgb/OazJpfbM8qrJEjiB88itYXuqbHU5c6+VUxkR?=
 =?us-ascii?Q?lJHMWp2icBaQWMv4zPX8+FQod9uygIxWFMXVoOmanSiwgFiHPl91W5GMSa+J?=
 =?us-ascii?Q?EDAemR5O43Z8jAX4Z2F+aXDxFPF34pX9ZphDm+kR4E8XFy/m7qQVt+Fiukw7?=
 =?us-ascii?Q?pCbcTMoVdLkCeCmoGjTl8JgXYhnx0hYtpRzOdx562l1jMQTipguv0wRXeWpK?=
 =?us-ascii?Q?O1vH/RUlMFl5FWzDOxlTYPBtZgqfB6GX8Csw0TTAJN6ItoHR0COTq0f/dN8A?=
 =?us-ascii?Q?roTXSbT4GYrIJnnr4VLcL6p+fQMz1FpMpM518eQeiJ3o+F7c7uUF4WXdMTPu?=
 =?us-ascii?Q?1Z94A+itfqHD9tuJGf+7wCGmgzv9rcUr6EeEniWlldLXNZWHeL6G7gt8LX4u?=
 =?us-ascii?Q?JsRF30PGC6eETEPJAY7UKWCSk6uqSJhxpcHt7M+2uhbw1B/7nEO5elKZX6Rh?=
 =?us-ascii?Q?1rq77AA5++J+B8qLIWNvfQ0LO/a5lbf3zOPWYcwi0uQ4rpAMDUS/tbRJts4L?=
 =?us-ascii?Q?U7QaEZDceVjUbR1g/fgE+PD15T3K0sDnb03I76w0cRJDupMXHdYXwhhLkpaz?=
 =?us-ascii?Q?ZBVHSdcfH99r7H0hifF7o3gJOGyYi7U4ZBYCKMaVjA8VvsShxtxDrQQyM5qe?=
 =?us-ascii?Q?jvNIh9bKvZhM4rSCEMDNFRjmyXsu9k6LC3TwPt4VN30BOWIIkuSuttaLUeps?=
 =?us-ascii?Q?61nrLU9xGc17WbP3kbMtNs6l3BPqB6QQCICk3TRbCzsyQt70AHe2ucvgyTtX?=
 =?us-ascii?Q?p52mQmxKk4kfYe1mb/ug1N/XtcV1Bjmy0hSOXYp66ykRFMwnAg1+QiGeRDeT?=
 =?us-ascii?Q?AucGG0rDvlh4u5ALUUN2tNoNtsavCx1/v66XWkYPRZj2FUi8bLUs0K7257P6?=
 =?us-ascii?Q?lDlc2CxTyPwG8bfBzFl3AlgqUKcqLQgThCqhP21FWQgAH2keSrp5HHdhkYmc?=
 =?us-ascii?Q?35ZnRc3IB1TfUwu03YGB7JsBmyzoo8kH4ZMXHxlGHkwLQ5qP+A6quHg4UEcO?=
 =?us-ascii?Q?n+NSykQiTNjoRL2QPk3K+cn+5rRMbVifBLb0XT9cIB5rdyKd6OLvMlDqmm9V?=
 =?us-ascii?Q?ynx3nMBz73oeGm0/1cQCgllWGqHYFex8vr1PkYtDnPYeiK1WGaBj27/2baeA?=
 =?us-ascii?Q?R/hAFk74HtO7uauuQVsOfZjpdsNX2BROuFre3y7JHUIJP7O9L08gquEFSvXX?=
 =?us-ascii?Q?3akJGM+Tq9lQXZOwGh0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6407c144-4708-4f06-50a8-08daedb545e8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 18:06:44.5312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6mxO77WBRsJ9U3sj9bKRcjxT2saZ15LfdFNoS1hSnO0o3kDTALNoW34Y3+RjJuU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7953
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_7CA37E54-0FA3-485F-A288-EED0D31A72F6_=
Content-Type: text/plain

On 26 Dec 2022, at 19:28, Huang Ying wrote:

> Define struct migrate_pages_stats to organize the various statistics
> in migrate_pages().  This makes it easier to collect and consume the
> statistics in multiple functions.  This will be needed in the
> following patches in the series.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Bharata B Rao <bharata@amd.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: haoxin <xhao@linux.alibaba.com>
> ---
>  mm/migrate.c | 58 +++++++++++++++++++++++++++++-----------------------
>  1 file changed, 32 insertions(+), 26 deletions(-)

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_7CA37E54-0FA3-485F-A288-EED0D31A72F6_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmO0brIPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUPXIP/imz93/lbeuw+l330tX7tNHO2etMhEdHbQUe
xzAuEBYMG+RZWdmNS8Cxa7l4jEkCHSTXTigmDj+9SYqmsdjK0hgEEEtu19ryqbCY
SWakWChRKFA1kQwMXb4TbkOfEkbVC+AOq0BvIExrbIza93pwDF78/8IeCc1y8h5d
gvLOCfftLzlYVWRGTiEvnYpq+N/wQ7blyy7oOc7v/zz+S5O8KsLMXq1KIAE/o3ez
NrkkeChzn0VEYY0mXzcCuV9WLXMx5+qjUIefm1BzFqfd1BWKLCrlCetH4NMTCK7Y
rnrQIQJF9FWVDv05mQDx7v/dcvx6x3xxL07ngYm73ADW+OJKEfo0VM75qZZ4ZngM
eZDEwTBvm/9W7tZAtALMUhv4RTXYYZ2oIw4pOxKW2pQ7O4/31AopqGUO097wkXco
CAqd1PuBIeG/7SL4jHXlD07zmDJPdYht8LELmYmEP4wh29OnVsoj3gkDkJgtp19O
ap+WP4rQ2kaI+M4c2S0UGni/55kYBEJxHHuQgIhIcjr+T6ici2/jGJ1SpIaeJimf
TGbb8A1JJOmQdgv6sD3QLuy+WAohcsJvd5sNAMxpr/SgMnjEt0YhdeWDYFGI8bec
2mXWnnep29TpTCnP/4eUVPI+HwTQMq1sy5zoG+UbV6VaJWzsBGgPdmRfHmjXspjz
+QjydagV
=j538
-----END PGP SIGNATURE-----

--=_MailMate_7CA37E54-0FA3-485F-A288-EED0D31A72F6_=--
