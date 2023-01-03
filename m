Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379AF65C6DF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbjACTDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjACTC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:02:56 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11F2FAFC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:02:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZAuZOeGVq8arv/wIH5PeZPZCk4nyqxvmpAJEYFmY8V5ysN/WceHcY1obyYg0S6qS6iUgDuJOeKSkVZt7IvxVEBiutC+8mtwzxC1wto2ktHzAwLErdZjVIX6llFxrAS7HENOu/kRlHyBYYGwUyuVqx91PSmMHQPpxWPKLpzCx5S1xLq0Xp+bE3+sf3oJyrKLoSePzEh5kF7hDeKwP4TgKb5T3aRAUViuAtPIwV2USWV8l+2MPSbyDHV7And5GGuoUestPGzZIbrMB+/4onzoiWjjCBkWP4FWaRauf91glW8ql5xq/aBOMx2vpihjGV9smTChqq1tSyPQGh+1MO9lug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgWi6DfHFcQizjvFmzhANYJ7KTW8mwJ93a5mCxLiU/4=;
 b=C2YLluyaRPWljCq4vC1vJcTQsw6y90JFt6Sdh4BkTFV/w7mGyemk3P9qNDGWYH5/I589PGlJE95WPt6E3uDckqbooZHcd2qIgBJz98ZuqgZL553KoVYIgpqwJ6KK/IGUFDLscQbW42OsaogSJOVaQntD9N0g0xkdL35DD1MhKB4GUenk19epSSqc7ZEUjcmGPb5d4P1h/f/ZxN8kVJSjCuHWLdqyZRuCoyxgYOnlKSE/UfQ+2Bn5rE3qcOj5CJUpultFMzQ2WEb1YIUu0xWrDJ9T6ubmEzLltgwo1yoHcUFb90Wvl7ZjrHOpZJcXgDyNdn9ZA4wg2dZ4FPASMHD+Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgWi6DfHFcQizjvFmzhANYJ7KTW8mwJ93a5mCxLiU/4=;
 b=RgOy67iTBzybNU7JdO1bK4auPpUsm4Q+YWeCI0YlAJKIN6MKAshHMbX4XUVHfhvc4Oi9d9lTu2wnM31j6v7rZ6O5PHWz4yh0gjGfUDr//bOyKldgucPpDozQw92i6XsqLgJ0ggxG4zdG76azGicRgiKp7Fheru7ZcR7p5cb7xYDSxIwrxiVM3Aj5yZRDGzhEmWOcYstQy48cMOfP7FoDRCGQbk+qxArRBfEFQF/h7FOFrAVq+W3k9OQvdPLUR1MqQ5kDkhxPLjhH3K7JMmGesicj/ZJEWfQV7qxp2AKpQJxAdwYiTP6CofszcL4iJUvPok0DXzfb61ZNl6JgxI2TBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH0PR12MB8050.namprd12.prod.outlook.com (2603:10b6:510:26e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Tue, 3 Jan 2023 19:02:54 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::2585:153b:98ea:3e23]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::2585:153b:98ea:3e23%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 19:02:54 +0000
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
Subject: Re: [PATCH 6/8] migrate_pages: move migrate_folio_done() and
 migrate_folio_unmap()
Date:   Tue, 03 Jan 2023 14:02:52 -0500
X-Mailer: MailMate (1.14r5933)
Message-ID: <926CD8E3-1B52-454B-9026-FACE622666BE@nvidia.com>
In-Reply-To: <20221227002859.27740-7-ying.huang@intel.com>
References: <20221227002859.27740-1-ying.huang@intel.com>
 <20221227002859.27740-7-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_2882185A-8391-4E0E-A871-217F10E68997_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::34) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH0PR12MB8050:EE_
X-MS-Office365-Filtering-Correlation-Id: f1edebbb-7c4f-4aac-2e56-08daedbd1e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nYqOJADRSla4T4H55fT4hJ/UV/1HpRg5eBMtyxuEFVT3H0n+VFoLuddFcpZkEq93IJp74WXeL8v9ysPjEwPCo9QxsZE0XRsZMgFS+OtSaMpjjwiY90dkbRtl6OKrfD5wuPI8VjThpE6XWVF2bv56/q+YhMgkxDP41nLK9iaK/rwcFErOBtnw//d9yn2M+X4Q9qYIFHlwBotigQcAv4y+bWHyeR0pVEjvVk9bxhKp57obsmvG1KkEjjjfeJMKs3/XY8b67BfsXuBKB0IECZ7Fh6dxFIS6OVgfNBM6cqABekYmV6o9hVkuCNge7LUVJGp2C/bdQoArRop6F+tcgEqDDtP0e65KjP6vgjh+0BZKrStRhoYBfrGlIVubxw3vJptxYy/DCV9EZoA4y5W/QG/kTHcsMts4uV23aHW81DkJLBdJ6XPKazPAyj9kIVwI9W3OnsTbrRY3OGSoOZDQ25zUquk/s2IcdIF2M6f4vAFQJTlKFfa2K0E71wewQjzHJqXKg0115gU3FZwNRCUiDZQP/FW2EJzTfDAuq3W9eZzyxbhhOx4voaaCJn7lAhbB0773raHrZINKbSrVJ3ziKxvCJE0iMI2tFbHTprSNSaapADz1IdxVsFJWXYVzmc+gI/HYu17UHLvNwnZsMTo+NUD4GQFoQp6t4PolPYeLDd42pTvX//5G7uoCsIDN/wcPeH+X4WcwU3HgEBICnbKsnIWUY2pxVCSoWqZgsMuEviPF/oaFb4kdDPm3PhKiHkoO3GEY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199015)(6512007)(186003)(2906002)(6486002)(53546011)(478600001)(6506007)(26005)(6916009)(54906003)(8676002)(66476007)(66556008)(66946007)(2616005)(4326008)(41300700001)(316002)(33656002)(7416002)(5660300002)(235185007)(8936002)(38100700002)(36756003)(86362001)(22166006)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bnOAdFS1dSfOw5UpfecCEbn5UHPGAoe/SOxK0lcAFEIj8W/81B9FXgeW580e?=
 =?us-ascii?Q?nZMI9VFBIL716g5byKwpSMBYcxiC+/xuk6NH16TbhmKurDOP/trUzljPM0DH?=
 =?us-ascii?Q?SMQalKs02AaXbaJXjm2w5u+ct45qdrNBxITCqL3otoF6BZCvLSQjOIxvdP5o?=
 =?us-ascii?Q?3UBwxi7g3S1XGIMCoDuCBU8Y4KYq1tj85RFJ7c4a7GyT9XUwRTIQM6AAKGWK?=
 =?us-ascii?Q?4Iq4ITEygMjt/GS4DHfV8Qu89PeaCAidLOep4opAD+sYe3alrxZaZG6xX691?=
 =?us-ascii?Q?z1qiP4V5KxnzsP6mxQAWjfbajmd+3xGWytY/+oKKeIjav1GP4GaqYm/wnH9c?=
 =?us-ascii?Q?nA6wwaS+VNG7iAsD6diaByOXkWwK9QpgV7P6Wz/1Y3BFLt7wDPoOq29TqeD6?=
 =?us-ascii?Q?sbTCaTVhPQcSUjl0Ht+bDK6yRFHHpG6+VH4uVUZGWF7P9x/DdeAa2LM2lsLK?=
 =?us-ascii?Q?HjvgcMa6Cq9HVUllgvl/4g/aIdRoiAZrTIYqLrRHTMBLzX92SyUf6Ic/CbpO?=
 =?us-ascii?Q?pi9C0FzIoxUq6Xk23yu6pBMsiFkQ7doU4DOKEHT4yWNK7M+JyFse4CTu8+6A?=
 =?us-ascii?Q?ej32lacCJIsADD4r8VcRt+kzXAYEBgA1iOd7+iaTph05tTKB6U/hE6SiqakO?=
 =?us-ascii?Q?4TAXly/sk0whiYTJCSia8Y3yRCgIzgS+DWlEGgWPs/cXLuI5p4BpFSLarCQ+?=
 =?us-ascii?Q?cYieFvYRrREWP7Pq8Ky50Oadda/glbmX7wZTgmhVVwQ4WOsRSBI0V6HCyIq0?=
 =?us-ascii?Q?LijyMKY6AAuJUzkcQE77Opthfg8EkLGm2z/DoEXMC6eRWd4wYqjafOg7QmM1?=
 =?us-ascii?Q?SF8GcZa0hCw5p1VUwFvhP5Jb5ZOe3k/suZRm5SdXYioBFwqy71DahO1gVM2L?=
 =?us-ascii?Q?J0JNutx8oUtOz0uOFnh3Trr/bNFxgNLhcLZZtx+tluRVbpuwW56e+3mJMwRx?=
 =?us-ascii?Q?tVbDxOBfk/YFphJuK9PxdO8q8sn/5CIOKzOkWSfx0WaJ1sP4ANxCs1tNJisL?=
 =?us-ascii?Q?aKW2YPuW+nDQ4SNA9s+7NIdQQRFRNn/MeGsZsVjZjkaw9h332PoATqgv7Dax?=
 =?us-ascii?Q?ulazJWgq0eJ+BQhfqutRN5oHsOrRcABINFChipY4vK/T7fB0FqPWmMKWLeT5?=
 =?us-ascii?Q?A42aXgqMW5Rt2gFNuxUkJTN0mDNleeKE9QXZIviJA382FqJV3My8lLCvGW9D?=
 =?us-ascii?Q?zmZjc4v47E1lrCzWXBHXgU2E0R/ougXUvxj2UjdwAvJ5OXe7JpQlWedM4bOm?=
 =?us-ascii?Q?2zIVtCi9y8BqqTJQz2mAuyCjtgazR0f8wphqkWIY2swzVN/3gn9+s7o6Fikv?=
 =?us-ascii?Q?gOHwJhHTQ44zkWWm1E3zuRLUsEXP+IyVivAYdpgaMEejAILovfI+5mtISuSY?=
 =?us-ascii?Q?M5ICxxL0s6pikgsWUwyehfc4TbVWV2GuXX62m/G4NoT+WghU0dS0rpmhCp9D?=
 =?us-ascii?Q?Hfb9NaG/K2KERJF77O2zeEstMSmngVJjDhT2JmNGmwYgEG7cdgnp+Y3zuokO?=
 =?us-ascii?Q?/LLbu5ap0l38IPLo33EEUHgn7fIZ3XP87fJ61UTQMVoHFsmIxnfQes1KPQH9?=
 =?us-ascii?Q?ERxRqasQohPtrvhLAu4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1edebbb-7c4f-4aac-2e56-08daedbd1e6d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 19:02:54.2669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vG42HWKZViq/aZA/MuZ/GN8VgtgLJG0GSZdp/TZG4ivY1MNONN2VMTCJMa041TU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8050
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_2882185A-8391-4E0E-A871-217F10E68997_=
Content-Type: text/plain

On 26 Dec 2022, at 19:28, Huang Ying wrote:

> Just move the position of 2 functions.  There's no any functionality
> change.  This is to make it easier to review the next patch via
> putting code near its position in the next patch.

This probably can be merged into prior patches.

--
Best Regards,
Yan, Zi

--=_MailMate_2882185A-8391-4E0E-A871-217F10E68997_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmO0e9wPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUjIkQAKigaqpCRFjbHm7PVFzavGck9/XveP8g9Ali
U0yIxL/WqfvqHIj18wADGmlCQETnomKKvK1RwxNBAR1hHfcIaLgvbzm6ukQph17M
ExFEXzfn2nZxph5pLtokQeVAUHaBUvWQTBJ4EUMN9b3hvKk7zu4tuKwKyYMzgMiV
UYzypScQ5/UUv+XL1B0JubczNJ3JCmiw+rtDjSt7px1SR7+2DyXXOMrXR4sZB2np
1J7vy0gRkhTQtYRnOdWtZoDvZycml3KWuWWjSVuCeGRzCVzWM+lkIPQIOnThdUFO
+thy9+4CxeW3nxA+W3tf+4uSaoDQgeNeC8liPR41jI39E6TR8WpxO59KrO/JzZ5y
dZ3HqaUdFpO7BEgM+8urep6+o5JXaRCXnSGBA1A+8d/eUfQwprBMpoMqzhDrolKf
A/wYy/QiYVQD3htSJnOGYVOdMAoevnIy8ISoLgQZpPkGxiHIo0DWVq92v0bSxzmY
R7gW77GKhsxzpuolPiawff+3k7+KQZ9TNznrEW5H8IZRptcODkNQx7M1zKVccP+5
0dUPqeT4G5ArOhXyHWQPYRGxE8yxq565/uuwAztJw+9YS+4I6Zsb6LsdfT67pStm
q3PoYsfJv3t0mTo7h4C2/obieBNbMAYz5GLtXlMPo80rLz5zpQ9r87nSPCc/Ldti
V3FdeJJz
=0Xog
-----END PGP SIGNATURE-----

--=_MailMate_2882185A-8391-4E0E-A871-217F10E68997_=--
