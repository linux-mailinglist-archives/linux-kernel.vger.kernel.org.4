Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20FE72DD11
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240841AbjFMIxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbjFMIxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:53:10 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2079.outbound.protection.outlook.com [40.107.215.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62051CA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:53:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZu4KjbjDHIMlbRcHdlVEl8w+3mZ+ail4gxtt8nX6w7Hlgi/bh+dpsk6mm8w7NpdUzZ4pjEg6D5c37qzBqVGmg622s4tMsTC1mi7WHTogikq/0evLPP7n/8/sqr3+GGH4y1oFMnEp52HqeW6U+wQp+Li6zjRvEDlQ1NT5iQ8ZNgnX6adibPu05mh9Elo8YKC5LDFwn8f5xaqoF5uIG9GTyMVUH1BNa0xw8AK6eLrWgZkZh1taEJAw+h/Z0yR+7KuGf+E0Td7cZ6uHnpTYnjE7FZ5+O2YDgxMr1x9xKBGMYpLATgMQch8oHG3yGn8nX+FBEaBM25Er4SeCsJIs/scSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDS93DPhDN5ULBsF3WoR/o9cKItNLzIXPkMTHV0ui04=;
 b=HNUOHTwPH98NWgyokQNvZgCcI+bvLsWTaOA+P6cfCoGhxFuWDiluc2nWPEiJE0udYJXXGZLBfkJbIVskMgY6Yt5eS9lHFhrRFziRIdmFXctvfHEFn4DjXgl5RqtvyQySwJQAvYJt24hom3Jc+QIIyEy0J5bKSVg3g75sra0/n4doZO/unrC/VAWk9oFW+UlSx+TpCoYw/xY1NW20/dxtTkVOiWxpM1CdoOeyI1al2vYI8NxiDxKpNxHRz5IlzudE59kzA79UdBkkbX/oOnnRXIWw8eCvTURkVOFQCmQR5e01T7F2rSMS2qxcYDiwIGlN0J2qBWiQDRb3cLJcuGLEzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDS93DPhDN5ULBsF3WoR/o9cKItNLzIXPkMTHV0ui04=;
 b=iWFeCgJLLt748iJu/1eGEobvRgWPfsxBSYB5+LQxEjcftgE8A/cQddmfon6WcSy9An2U654cWF8RmNUqEYfL2VCzyZcw7AlZA8UaQXr0RDA0weZcJ8uahN+8DaQ9y85oJn6l58ZcX3FQXLqe1hMupGupikFKZVt9x+L2TG3g8B0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TY2PR02MB4479.apcprd02.prod.outlook.com (2603:1096:404:800e::7)
 by SI2PR02MB5049.apcprd02.prod.outlook.com (2603:1096:4:15e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.21; Tue, 13 Jun
 2023 08:53:04 +0000
Received: from TY2PR02MB4479.apcprd02.prod.outlook.com
 ([fe80::bc4a:4d7a:4c73:76eb]) by TY2PR02MB4479.apcprd02.prod.outlook.com
 ([fe80::bc4a:4d7a:4c73:76eb%4]) with mapi id 15.20.6500.020; Tue, 13 Jun 2023
 08:53:04 +0000
From:   Yunlei He <heyunlei@oppo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yunlei He <heyunlei@oppo.com>
Subject: [f2fs-dev][PATCH] f2fs: not allowed to set file both cold and hot
Date:   Tue, 13 Jun 2023 16:52:50 +0800
Message-Id: <20230613085250.3648491-1-heyunlei@oppo.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To TY2PR02MB4479.apcprd02.prod.outlook.com
 (2603:1096:404:800e::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR02MB4479:EE_|SI2PR02MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cad789d-0448-4d34-49f1-08db6beb99d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w4EQU7pyZWgNNhJNd/E55i81yDz1nZr7azW0WO4/WgvYhamTTuI7dnSNsVx67NhRlu6hOPBXWgbt8l5M85pI9gV+MKHIuZwPu2u0UvFSHP5LOgsIiLMsalHyDDoofMgjI3tClY1kQs9+UfXc6vIhh4qZJbUuVC+XWBZWT4bN8qm13Awjd/Sc6fKkDaz0XllefhQx7Z8xixuE+awrbG5haPoQeUiE5zTz303US8Um7gKm0F729Y74rNTb4d8HzfBYWt2apU4VHZzXCHHXqF067nAntYw/zksirdKfGStd0wgTct6m0scZCkKKzKsbBlmi3hLlTWEGomUsTO1Xn8R2XfaeT6ztOUmSyZyuQzmqUPYFbfcGLxC0+LyPuiKYE90eTz2Ytpdc/oQ5DfKXbcm2Imdrxzo1R9SI7gQhDqIc2xmgUzkZTwITPkVU1MJnYCxBg2n6bY5cYD5QCjamkTU4uNXMwfjOBqOAK2T3MV6I5aaUM5fpQjzFApFzqvo21IZM+1T0YxFqXM66Pl50IYyq70+liwGmcXtipQAn7iygw5asTDBPwh5VV2o+vov0gzDqRdEqvXavg1GlBu41v832TOAMKLkL71Swa7qNw3Va05UWn/iSzN0vvTATl3IJkOnD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR02MB4479.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199021)(5660300002)(66946007)(66556008)(4326008)(8936002)(8676002)(41300700001)(316002)(186003)(2906002)(478600001)(66476007)(6666004)(107886003)(52116002)(6486002)(1076003)(6512007)(6506007)(26005)(83380400001)(36756003)(86362001)(2616005)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cHGUxKSQqBMZD7f4l7B9MjdHLUtJKbKKebfOgUVE8yFipjrq2krRYGXBmryk?=
 =?us-ascii?Q?mbMQ9TlRJSaYxWKhJgOhiyaxjoNl9gVT0Xyoo5qwYIOCZyKzFDEv5Aw5Dgzy?=
 =?us-ascii?Q?fiCyb1+DdUGP85Vyw4Et6Unna7xCMvKORrc5Spi+2NRI5nof7bHGKcjY7MNx?=
 =?us-ascii?Q?/a91YDHiATqmCs74EPuZGDpsXkkH4y8QaKyI7L0yWtBSFkjtSX6o/8UzGJFp?=
 =?us-ascii?Q?WbA03EvEkIC7eoIb4znCaUJIKl8oW2tJJp+hlfm1a9p6bX+kh+8pKKEhP2P4?=
 =?us-ascii?Q?uLW0P2O78cHg7h/NDpLgLjuXu/DNm+xDHtkzGHli3CnBVu+zgltjAAJG0pjh?=
 =?us-ascii?Q?XvvaxdtvZXXylcFZwb/OCblHEv+KUyRwRKgGoaMfwDQHZfk4TKV1sxaSO0AS?=
 =?us-ascii?Q?g4DVP972SFImFdJlWjTR7CIeJg7O3bf7M/eRraqW0qj3ipMANojmSyIWmDyN?=
 =?us-ascii?Q?CvspLu81z5eMVp83HhiewSOnGm3hCCcdYKBOIjSfh/cLmDhQ68OP2tc8WRSz?=
 =?us-ascii?Q?B/qX7qU2RI3IVoPKlMC36sihBolnP2WFFujIw1qSBHR1ap7ICQ1xREorVjOY?=
 =?us-ascii?Q?y8OMHakipVRq2IaEIRIIyh3v5IQekIkLSQZT5cr4lzmrmGdoYtO/IysAuVrC?=
 =?us-ascii?Q?KQpX/kpgQyIm8CEox/AWLLBIcvMsKFgv4yE/uETU5EIpug+yhHxe/mES9+YU?=
 =?us-ascii?Q?6W+pQRs3DzZ5APd043mPpXiooTw2wOLH5jXZ64TSogPUhcUH44eMKSrQ/TDt?=
 =?us-ascii?Q?OpxUTrHSb7EST5E44mGvjdrQg98XTCRz5SyoQxg95AWb35GwAe+Jr3aTFdAz?=
 =?us-ascii?Q?uq3iXZRkpho4biS8bylUVJ1SGzw1CBwTusSHMBIa7UMoTdNfKTZBm4qmDX2m?=
 =?us-ascii?Q?4YRbnIA3hyB8wBem+mbZ21P7FACRpvG0L8MUc5nEbwuNxrdSqDu2KbprorF3?=
 =?us-ascii?Q?oM3+0FXbTNIRWzogT3idd04xcZihyvX4V1MOOFfsWtYnKmZr6dwzPLK4qfxY?=
 =?us-ascii?Q?QE9uTpSvdb+XlwoS3y+CiqVYR6o1pj1tbtdoSOvTR3jV2qZKqULrhswboVXE?=
 =?us-ascii?Q?sCIexXqlr1AYE/2wd3hyip+nSYBH13ewzDCp30360cMGMhZAQbIbJAeTj9CN?=
 =?us-ascii?Q?bOIGrUyvxpbWUDO1d8tRRBVgNoID5lg8ZcibHiENyw4F75irkDiar2QxEmnO?=
 =?us-ascii?Q?FkQZU6yv1RIv8hv+qJhz1JqKMRIP/CnRtHA5aN7XpoSjZH/V6XKNuPcikZFf?=
 =?us-ascii?Q?0XX1Dan6ccC1c1Smm1f256Fsa8i4jm6MnT8nHlhFWXdoWeoms2afyFgP0m2H?=
 =?us-ascii?Q?lbKmIpFe8qOs6S0kv3D1t0gjYNJ5jfEmFa45X+MTIr+OMqd8EFXEyac4wwt6?=
 =?us-ascii?Q?YACvnnBgyX67OaM1vvbZVAe+Fu39FlHVgOnNMtrGksqCgxJD/BEYpJ1JoCBg?=
 =?us-ascii?Q?JwGl6/Fm2tZpZ63r3kO50Y7jSY3NHv010AOsyA/qVhcPFt3xElehGRv/XBPF?=
 =?us-ascii?Q?TLbHwgPJz3XRBTZRhBSbAJCLmaA3Xe2W92Agf7MZ9ZXIFYd8kVckORVxamSC?=
 =?us-ascii?Q?Ml5U+W1xnleVX++sD/FdTd5P8n8ukHw5AFxAP7Vc?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cad789d-0448-4d34-49f1-08db6beb99d6
X-MS-Exchange-CrossTenant-AuthSource: TY2PR02MB4479.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 08:53:04.8135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvbMWNE8gsyqYHAzzE8+WSxHJ/Z++KHGB+Lb8CFYfY+xDK52YWTST8GySbWMurg/ABsGvRgS3Au9S1U7AUqYJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File set both cold and hot advise bit is confusion, so
return EINVAL to avoid this case.

Signed-off-by: Yunlei He <heyunlei@oppo.com>
---
 fs/f2fs/xattr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 213805d3592c..917f3ac9f1a1 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -127,6 +127,9 @@ static int f2fs_xattr_advise_set(const struct xattr_han=
dler *handler,
                return -EINVAL;

        new_advise =3D new_advise & FADVISE_MODIFIABLE_BITS;
+       if ((new_advise & FADVISE_COLD_BIT) && (new_advise & FADVISE_HOT_BI=
T))
+               return -EINVAL;
+
        new_advise |=3D old_advise & ~FADVISE_MODIFIABLE_BITS;

        F2FS_I(inode)->i_advise =3D new_advise;
--
2.40.1

________________________________
OPPO

=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=
=BB=B6=E5=90=AB=E6=9C=89OPPO=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=86=
=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E9=82=AE=E4=BB=B6=E6=
=8C=87=E6=98=8E=E7=9A=84=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=88=E5=8C=85=E5=90=
=AB=E4=B8=AA=E4=BA=BA=E5=8F=8A=E7=BE=A4=E7=BB=84=EF=BC=89=E4=BD=BF=E7=94=A8=
=E3=80=82=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E4=BA=BA=E5=9C=A8=E6=9C=AA=E7=
=BB=8F=E6=8E=88=E6=9D=83=E7=9A=84=E6=83=85=E5=86=B5=E4=B8=8B=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=E3=80=82=E5=A6=82=E6=9E=9C=
=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E5=
=88=87=E5=8B=BF=E4=BC=A0=E6=92=AD=E3=80=81=E5=88=86=E5=8F=91=E3=80=81=E5=A4=
=8D=E5=88=B6=E3=80=81=E5=8D=B0=E5=88=B7=E6=88=96=E4=BD=BF=E7=94=A8=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E4=B9=8B=E4=BB=BB=E4=BD=95=E9=83=A8=E5=88=86=E6=88=96=E5=
=85=B6=E6=89=80=E8=BD=BD=E4=B9=8B=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=EF=BC=
=8C=E5=B9=B6=E8=AF=B7=E7=AB=8B=E5=8D=B3=E4=BB=A5=E7=94=B5=E5=AD=90=E9=82=AE=
=E4=BB=B6=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=
=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E3=80=
=82
=E7=BD=91=E7=BB=9C=E9=80=9A=E8=AE=AF=E5=9B=BA=E6=9C=89=E7=BC=BA=E9=99=B7=E5=
=8F=AF=E8=83=BD=E5=AF=BC=E8=87=B4=E9=82=AE=E4=BB=B6=E8=A2=AB=E6=88=AA=E7=95=
=99=E3=80=81=E4=BF=AE=E6=94=B9=E3=80=81=E4=B8=A2=E5=A4=B1=E3=80=81=E7=A0=B4=
=E5=9D=8F=E6=88=96=E5=8C=85=E5=90=AB=E8=AE=A1=E7=AE=97=E6=9C=BA=E7=97=85=E6=
=AF=92=E7=AD=89=E4=B8=8D=E5=AE=89=E5=85=A8=E6=83=85=E5=86=B5=EF=BC=8COPPO=
=E5=AF=B9=E6=AD=A4=E7=B1=BB=E9=94=99=E8=AF=AF=E6=88=96=E9=81=97=E6=BC=8F=E8=
=80=8C=E5=BC=95=E8=87=B4=E4=B9=8B=E4=BB=BB=E4=BD=95=E6=8D=9F=E5=A4=B1=E6=A6=
=82=E4=B8=8D=E6=89=BF=E6=8B=85=E8=B4=A3=E4=BB=BB=E5=B9=B6=E4=BF=9D=E7=95=99=
=E4=B8=8E=E6=9C=AC=E9=82=AE=E4=BB=B6=E7=9B=B8=E5=85=B3=E4=B9=8B=E4=B8=80=E5=
=88=87=E6=9D=83=E5=88=A9=E3=80=82
=E9=99=A4=E9=9D=9E=E6=98=8E=E7=A1=AE=E8=AF=B4=E6=98=8E=EF=BC=8C=E6=9C=AC=E9=
=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E6=97=A0=E6=84=8F=E4=BD=
=9C=E4=B8=BA=E5=9C=A8=E4=BB=BB=E4=BD=95=E5=9B=BD=E5=AE=B6=E6=88=96=E5=9C=B0=
=E5=8C=BA=E4=B9=8B=E8=A6=81=E7=BA=A6=E3=80=81=E6=8B=9B=E6=8F=BD=E6=88=96=E6=
=89=BF=E8=AF=BA=EF=BC=8C=E4=BA=A6=E6=97=A0=E6=84=8F=E4=BD=9C=E4=B8=BA=E4=BB=
=BB=E4=BD=95=E4=BA=A4=E6=98=93=E6=88=96=E5=90=88=E5=90=8C=E4=B9=8B=E6=AD=A3=
=E5=BC=8F=E7=A1=AE=E8=AE=A4=E3=80=82 =E5=8F=91=E4=BB=B6=E4=BA=BA=E3=80=81=
=E5=85=B6=E6=89=80=E5=B1=9E=E6=9C=BA=E6=9E=84=E6=88=96=E6=89=80=E5=B1=9E=E6=
=9C=BA=E6=9E=84=E4=B9=8B=E5=85=B3=E8=81=94=E6=9C=BA=E6=9E=84=E6=88=96=E4=BB=
=BB=E4=BD=95=E4=B8=8A=E8=BF=B0=E6=9C=BA=E6=9E=84=E4=B9=8B=E8=82=A1=E4=B8=9C=
=E3=80=81=E8=91=A3=E4=BA=8B=E3=80=81=E9=AB=98=E7=BA=A7=E7=AE=A1=E7=90=86=E4=
=BA=BA=E5=91=98=E3=80=81=E5=91=98=E5=B7=A5=E6=88=96=E5=85=B6=E4=BB=96=E4=BB=
=BB=E4=BD=95=E4=BA=BA=EF=BC=88=E4=BB=A5=E4=B8=8B=E7=A7=B0=E2=80=9C=E5=8F=91=
=E4=BB=B6=E4=BA=BA=E2=80=9D=E6=88=96=E2=80=9COPPO=E2=80=9D=EF=BC=89=E4=B8=
=8D=E5=9B=A0=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B9=8B=E8=AF=AF=E9=80=81=E8=80=8C=
=E6=94=BE=E5=BC=83=E5=85=B6=E6=89=80=E4=BA=AB=E4=B9=8B=E4=BB=BB=E4=BD=95=E6=
=9D=83=E5=88=A9=EF=BC=8C=E4=BA=A6=E4=B8=8D=E5=AF=B9=E5=9B=A0=E6=95=85=E6=84=
=8F=E6=88=96=E8=BF=87=E5=A4=B1=E4=BD=BF=E7=94=A8=E8=AF=A5=E7=AD=89=E4=BF=A1=
=E6=81=AF=E8=80=8C=E5=BC=95=E5=8F=91=E6=88=96=E5=8F=AF=E8=83=BD=E5=BC=95=E5=
=8F=91=E7=9A=84=E6=8D=9F=E5=A4=B1=E6=89=BF=E6=8B=85=E4=BB=BB=E4=BD=95=E8=B4=
=A3=E4=BB=BB=E3=80=82
=E6=96=87=E5=8C=96=E5=B7=AE=E5=BC=82=E6=8A=AB=E9=9C=B2=EF=BC=9A=E5=9B=A0=E5=
=85=A8=E7=90=83=E6=96=87=E5=8C=96=E5=B7=AE=E5=BC=82=E5=BD=B1=E5=93=8D=EF=BC=
=8C=E5=8D=95=E7=BA=AF=E4=BB=A5YES\OK=E6=88=96=E5=85=B6=E4=BB=96=E7=AE=80=E5=
=8D=95=E8=AF=8D=E6=B1=87=E7=9A=84=E5=9B=9E=E5=A4=8D=E5=B9=B6=E4=B8=8D=E6=9E=
=84=E6=88=90=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=AF=B9=E4=BB=BB=E4=BD=95=E4=BA=A4=
=E6=98=93=E6=88=96=E5=90=88=E5=90=8C=E4=B9=8B=E6=AD=A3=E5=BC=8F=E7=A1=AE=E8=
=AE=A4=E6=88=96=E6=8E=A5=E5=8F=97=EF=BC=8C=E8=AF=B7=E4=B8=8E=E5=8F=91=E4=BB=
=B6=E4=BA=BA=E5=86=8D=E6=AC=A1=E7=A1=AE=E8=AE=A4=E4=BB=A5=E8=8E=B7=E5=BE=97=
=E6=98=8E=E7=A1=AE=E4=B9=A6=E9=9D=A2=E6=84=8F=E8=A7=81=E3=80=82=E5=8F=91=E4=
=BB=B6=E4=BA=BA=E4=B8=8D=E5=AF=B9=E4=BB=BB=E4=BD=95=E5=8F=97=E6=96=87=E5=8C=
=96=E5=B7=AE=E5=BC=82=E5=BD=B1=E5=93=8D=E8=80=8C=E5=AF=BC=E8=87=B4=E6=95=85=
=E6=84=8F=E6=88=96=E9=94=99=E8=AF=AF=E4=BD=BF=E7=94=A8=E8=AF=A5=E7=AD=89=E4=
=BF=A1=E6=81=AF=E6=89=80=E9=80=A0=E6=88=90=E7=9A=84=E4=BB=BB=E4=BD=95=E7=9B=
=B4=E6=8E=A5=E6=88=96=E9=97=B4=E6=8E=A5=E6=8D=9F=E5=AE=B3=E6=89=BF=E6=8B=85=
=E8=B4=A3=E4=BB=BB=E3=80=82
This e-mail and its attachments contain confidential information from OPPO,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you ar=
e not the intended recipient, please do not read, copy, distribute, or use =
this information. If you have received this transmission in error, please n=
otify the sender immediately by reply e-mail and then delete this message.
Electronic communications may contain computer viruses or other defects inh=
erently, may not be accurately and/or timely transmitted to other systems, =
or may be intercepted, modified ,delayed, deleted or interfered. OPPO shall=
 not be liable for any damages that arise or may arise from such matter and=
 reserves all rights in connection with the email.
Unless expressly stated, this e-mail and its attachments are provided witho=
ut any warranty, acceptance or promise of any kind in any country or region=
, nor constitute a formal confirmation or acceptance of any transaction or =
contract. The sender, together with its affiliates or any shareholder, dire=
ctor, officer, employee or any other person of any such institution (herein=
after referred to as "sender" or "OPPO") does not waive any rights and shal=
l not be liable for any damages that arise or may arise from the intentiona=
l or negligent use of such information.
Cultural Differences Disclosure: Due to global cultural differences, any re=
ply with only YES\OK or other simple words does not constitute any confirma=
tion or acceptance of any transaction or contract, please confirm with the =
sender again to ensure clear opinion in written form. The sender shall not =
be responsible for any direct or indirect damages resulting from the intent=
ional or misuse of such information.
