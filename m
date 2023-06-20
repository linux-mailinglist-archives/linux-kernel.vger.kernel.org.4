Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2218E736339
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 07:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjFTFji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 01:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFTFjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 01:39:35 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3859010D5;
        Mon, 19 Jun 2023 22:39:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=id3//hdRPppi7ikrNz6ZDahDJ4XHE/2ozYVT3UD39XnbBUjRE0lATQfc3wFQDHE58my9ZuLtux8bLeBxl5EgEwgLQOo1WqF7LkaDsEeBXmon0iSh35ROecmlOG+d14YP7jZKUxxRbm4dp1IuaLa7fVyy5Y14kjlZEjAT+XPAtB+gPgicAFHP/oWCgTG/Qb4+I85swcFQZtaLnDjjks5dXymE5Luob6hYThIYERigdCDe2v5E838D0tNuylKRAC28chyZ6hivFUJ+bkLLz4f7ggHhtCS5b8RxGLfYyBZVLL+2Ornmk+DBFOPvpxIjMgO3zv01oX9P3xXnv8dRI1BURg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=io4fGjIV01sg8LlUoZB5Jr/svgdR4XzObO21JMEjcWM=;
 b=CzHJ2xK6+WE/kyf78p3qagdeNwh4ivif3aMPdYZyzJ9pSQGMq3KVsPoTJGPAdbGMKDG2qcWQ68N3b92g5rZrKl55BeFcP1fqfwqcOGWsxhLA95TSell73jawuN0h+FvjoOiK9WKUyYU/aYRVcXCpo38U3HQBPVWXnYMCCDXHpI0YoPn/gAX4tGHOvEKbSOT7tPmD46JSE7nrzvx6qIhi05ZcJ2OcXwsEXT0WpLTz1xQvm66SyZYj5nOUHgNcwFWX64r/X/Pk8p88Q4Rf2QfRsrwsu6F2JY+qxjb+0O9Sz2hihGGzIR5qowj+eP1FgBUpVKHt92G1ANL1I/7AAzYkCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=io4fGjIV01sg8LlUoZB5Jr/svgdR4XzObO21JMEjcWM=;
 b=Lhgjn3EMPaXYhiaP0o0aQiPN04977lmtD5QGAZbrvWKQGSl2lcwzPyfIb0nRjZb9oBxbP56I4xhoOQ3BZsKiBbGUx+lGcKoCDt2VmiptOJWZiM4G13XcWr62pAe/IB6mK6QNE2s/8ZYp5F6tMvZDrNYBz5axbJ+Yk+/crDeSwGxP2uJ14kJqoXyjtebGwxasE8o+VGZJd2AsLNZjqSRDV4hNGJeYujQ82DEedCkJ4p6b2eRtbBiZU5Bv4aDdvIGX/Fpg6RtSG4dc2E52XG71NRGKRFsnhhgJLywuyVzMzRDSkfgbk84cyc6J572ZQ4kokLhv+ezvMZcA6yYrsZ0QXw==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by PH8PR12MB6745.namprd12.prod.outlook.com (2603:10b6:510:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 05:39:31 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::9a2d:7483:7e1a:5bbd]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::9a2d:7483:7e1a:5bbd%6]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 05:39:31 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 2/4] perf: arm_cspmu: Support implementation specific
 filters
Thread-Topic: [PATCH v3 2/4] perf: arm_cspmu: Support implementation specific
 filters
Thread-Index: AQHZmRqlEz3HzfS+RE+Z/ild+Kash6+TQDbA
Date:   Tue, 20 Jun 2023 05:39:31 +0000
Message-ID: <SJ0PR12MB5676C91B6849FA9588381044A05CA@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20230607083139.3498788-1-ilkka@os.amperecomputing.com>
 <20230607083139.3498788-3-ilkka@os.amperecomputing.com>
In-Reply-To: <20230607083139.3498788-3-ilkka@os.amperecomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB5676:EE_|PH8PR12MB6745:EE_
x-ms-office365-filtering-correlation-id: 57220dd0-3051-4816-fd5b-08db7150b8f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zLYQSs/DXIQSDkljbr9j3IjsIg0FBu/nnRT9WWf5oCOjGTy7pNZ+0lJt0qCuWGFuAwHZtA/CFiti/Sy5PQ+5TO48ZBFXfTEQfwXX3wqVkPB6hBXvWL7uj2LKEbh+dGfIplQNoUt2TvxpvyHwfPUKkMhknSex8MPwRtBwCc1haAr0xyBdHsPDiDiZD4jqRjzRpBeF2jldbiNlLu8njwMvMy/AMPz8xLKFUnqo5upTDQ5T2e5t1Rx2hwARsMSTJGx0pWchk7qYQfwQaaqx1XeHWx08IKpAEJyrcv9JDh93U86b4X3zW+QXNdWUsegjrxpyPWTWw7bjI6EjpBXXqq+7nSks8HS4m7LcxsaTERwEmkOcuqiRs9E3Pu71YO9dixs4lLfl57oM3LvMV0r+GifqFMmNMbHlAGDPL8Y+q1NVatTTSnL6s8qyY4/ssITjalCbReu+SMwPj/AuPlu1Tffn6F0HLEMPIIfhHVMJ/eAhPsqTllG5BVlR9efoRF68MZgsoOt/hRrD2xrM/3+XvnqaZ+DB3Rbrmx8gVV1F5Wkeguyeko+drdGVeZVS06t/GkXPL9jgxb9TKLZ3g94B5uTGPhxISF2+ajB/J+ur6BqTBREdEDTPX1ZxrUHabGSJcCv+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199021)(186003)(110136005)(478600001)(7696005)(71200400001)(9686003)(86362001)(53546011)(26005)(54906003)(6506007)(316002)(38100700002)(83380400001)(66946007)(66556008)(66446008)(64756008)(122000001)(76116006)(66476007)(4326008)(8676002)(8936002)(5660300002)(52536014)(2906002)(41300700001)(55016003)(38070700005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M4V3Rp3rh0U3QnVnJHBZl+H6deBnJZgS/+gM0NEBLHsLEUOIbuGQV+50SJxY?=
 =?us-ascii?Q?vJ07pZXdnVCMn7h6kL5n8fBDm4Kc6MQBZedI4nOg+zv6Ncoy8BLSCYg+tjdu?=
 =?us-ascii?Q?1YjvbaHjwCwZ4J561j7H2KJpu+3ZRyDR0zJN/KbH3AfNpVejUOkZoDBsLOIO?=
 =?us-ascii?Q?3llMH2xCV6LgMR5zDy+4BT1T6zQiWlvoSasUd2tMtIX/86/Br1oO/ET2uDPT?=
 =?us-ascii?Q?yeAb7RbxXxtIDnyGUmXjx4o4t+oon9lXcybitrncM4JBw4SDg43kHRH57d8U?=
 =?us-ascii?Q?un+czkINtLZUELhQrg63EGTSoAH0V4cynZYo97pfTGE8KmnoGpUuHINmiMtA?=
 =?us-ascii?Q?wi3nI5C6zOGHcLu4kqANraRW/MVP8PGO9sCubecj2PeFS0VPtlSYn41yPosy?=
 =?us-ascii?Q?SXWg92o49D+nYJLTKi4b7FgTF0KefaCSDhd1Jg0PqDHocwgnuh2tu1732xVw?=
 =?us-ascii?Q?RiIuPZr3oI2E/PMwgEAOJG8uMSdT3h7MpF34MyocXNEaoRU8nXc0KCwjK4ZJ?=
 =?us-ascii?Q?65SfiVoVU/79fbkrGFmSPh3gnKbngQbsu2X0d8gqNMeAY/s0xtx8CbvZpuW5?=
 =?us-ascii?Q?AtGUsQkyCNur3pUJa/5jCZuCwvZYjZZRX5U9dgiiUyz/kgThzrZrb5NcBCr7?=
 =?us-ascii?Q?t7tTcu9B2IIurWT9bzLRFp9POQMF8ZwLmL1wHuG+jIW6CjCIwY5v30uB1tGA?=
 =?us-ascii?Q?pCv8rWzdRlqMJA7rEkXAOqMsMpHGU8TN0pZt0VnPbambIDNu9d6wp9QKnlGg?=
 =?us-ascii?Q?47zTaDkw/T0fu8AoWLFv/RbcuNWstpJrMGKHwbm0XOjpxRwuwhYlDB2KL104?=
 =?us-ascii?Q?cQenEC046HnQnrUzE83pnly1QGoJFOrsDMyw8PpqY9CsONs833iyCKwmNGsY?=
 =?us-ascii?Q?r2OstX/VPNCUlMPqR4QY9THGwX6uSMAiHg4b47Gdw0Ry7C9cNMBIo0ajuLpo?=
 =?us-ascii?Q?EBFDq+ar8GLKh7+7RX9lCi8LM3sXR0OyxSgX4vov41Eo4xBcjOedu69viJe4?=
 =?us-ascii?Q?f3A7UNppJSmjiqokZ0znid0UDNv8jic+u/eguBfnverF5rIGMqMaaXmymEww?=
 =?us-ascii?Q?rlF8ATCL565qg3mXAjznOq+NZHnZA+sSKbAXGKcOCGYR+PRSEhFjb8cFA2+X?=
 =?us-ascii?Q?4wj4/GScwlrOcHEVhg24Q11znBfAlODSf+KhIXE8RjeSvUvQcEC5rMi7Mqdu?=
 =?us-ascii?Q?mNp5c5WCEHDnXT0H10dVqq2ADTAsBDxyGBO12In01uj8SUSpjvS6Egej8A6C?=
 =?us-ascii?Q?7R1CPsyEcKp31IV+tG+veUYsnsQQAObhUGW9UttF2BWn+ErwNnza6s3Vl6YJ?=
 =?us-ascii?Q?76sZVVw76727VTXf0mXlHMVWRtQCS/guNl0jOGXSO1jB/zMuk5WmzHCxOXQM?=
 =?us-ascii?Q?JAP4NGq2dXDc7zNRjWME7dic7l/tB7p1mYlCEko/fIvxaaLXheRIqQ7l7Alj?=
 =?us-ascii?Q?3TGbezh8L0pbdSYm/SM9oK8RH+jIIepVyNEvSnbwGe/y/GynVPDyhkCOfvgF?=
 =?us-ascii?Q?26ZEkIk9s1gsW1XUkzjqrcjvEz/+ZLGb3s9qYbcHvsVaWh5YRSgYpqA+WufF?=
 =?us-ascii?Q?vfNyGKi1+Oyy+tmeAOqdzhshaNZSv06AzzIYLlYY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57220dd0-3051-4816-fd5b-08db7150b8f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 05:39:31.7067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SZzX2vXY+r8ahbLEx2qOJ3YV/sfhRT50lI+e7oM98y4WKeHLh3cxoWJCQdgv5fRzmGUhHRMQtKTfHWJkQ4QvGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6745
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Sent: Wednesday, June 7, 2023 3:32 PM
> To: Jonathan Corbet <corbet@lwn.net>; Will Deacon <will@kernel.org>; Mark
> Rutland <mark.rutland@arm.com>; Besar Wicaksono
> <bwicaksono@nvidia.com>; Suzuki K Poulose <suzuki.poulose@arm.com>;
> Robin Murphy <robin.murphy@arm.com>
> Cc: linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Subject: [PATCH v3 2/4] perf: arm_cspmu: Support implementation specific
> filters
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Generic filters aren't used in all the platforms. Instead, the platforms
> may use different means to filter events. Add support for implementation
> specific filters.
>=20
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Reviewed-by: Besar Wicaksono <bwicaksono@nvidia.com>

> ---
>  drivers/perf/arm_cspmu/arm_cspmu.c | 8 ++++++--
>  drivers/perf/arm_cspmu/arm_cspmu.h | 4 ++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c
> b/drivers/perf/arm_cspmu/arm_cspmu.c
> index f8b4a149eb88..72ca4f56347c 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -122,6 +122,9 @@
>=20
>  static unsigned long arm_cspmu_cpuhp_state;
>=20
> +static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
> +                                   struct hw_perf_event *hwc, u32 filter=
);
> +
>  /*
>   * In CoreSight PMU architecture, all of the MMIO registers are 32-bit e=
xcept
>   * counter register. The counter register can be implemented as 32-bit o=
r 64-
> bit
> @@ -432,6 +435,7 @@ static int arm_cspmu_init_impl_ops(struct
> arm_cspmu *cspmu)
>         CHECK_DEFAULT_IMPL_OPS(impl_ops, event_type);
>         CHECK_DEFAULT_IMPL_OPS(impl_ops, event_filter);
>         CHECK_DEFAULT_IMPL_OPS(impl_ops, event_attr_is_visible);
> +       CHECK_DEFAULT_IMPL_OPS(impl_ops, set_ev_filter);
>=20
>         return 0;
>  }
> @@ -798,7 +802,7 @@ static inline void arm_cspmu_set_event(struct
> arm_cspmu *cspmu,
>         writel(hwc->config, cspmu->base0 + offset);
>  }
>=20
> -static inline void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
> +static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
>                                            struct hw_perf_event *hwc,
>                                            u32 filter)
>  {
> @@ -832,7 +836,7 @@ static void arm_cspmu_start(struct perf_event
> *event, int pmu_flags)
>                 arm_cspmu_set_cc_filter(cspmu, filter);
>         } else {
>                 arm_cspmu_set_event(cspmu, hwc);
> -               arm_cspmu_set_ev_filter(cspmu, hwc, filter);
> +               cspmu->impl.ops.set_ev_filter(cspmu, hwc, filter);
>         }
>=20
>         hwc->state =3D 0;
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h
> b/drivers/perf/arm_cspmu/arm_cspmu.h
> index 51323b175a4a..f89ae2077164 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.h
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.h
> @@ -102,6 +102,10 @@ struct arm_cspmu_impl_ops {
>         u32 (*event_type)(const struct perf_event *event);
>         /* Decode filter value from configs */
>         u32 (*event_filter)(const struct perf_event *event);
> +       /* Set event filter */
> +       void (*set_ev_filter)(struct arm_cspmu *cspmu,
> +                             struct hw_perf_event *hwc,
> +                             u32 filter);
>         /* Hide/show unsupported events */
>         umode_t (*event_attr_is_visible)(struct kobject *kobj,
>                                          struct attribute *attr, int unus=
ed);
> --
> 2.40.1

