Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60CF730035
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245026AbjFNNgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245025AbjFNNgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:36:09 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2130.outbound.protection.outlook.com [40.107.117.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5EC1FFA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:36:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BM0OyFPg+Wv/FnpTekoZPUwFXHnvi+1rbllzd61VA7ZcFQjDf5ikiQOmvgtHWkz2oKgAV9TVNgbG6WX05RXZcqdH7Hrj0tGpKQMZp2Dlq9nU3/yNksEL3JSwplh9Vh6dHne9Q2P4JoCOJXUo1Y/9yWMyro+Ur/GEbTOCR52YPguwzZuPu1epubmcx8Mk0Z8CQ0+vXwMI9mPxV95gZ6InBgyzQbppmqdcG8WXfatZDbfOYzoEpwPkR81JFqcLGymj8aJfMUjGmvYyw6oV0c3l6mx71Y4/6GetGCPvs4DNoknjanNULnaoFS2sfhJdCwIMmQ49AmhKml3dtRjL9VdrvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Igaj+Ut44ro+GrYc2hRjahnOPjee1r0cyeYwaADurCo=;
 b=bqe2Fon/bzPfCMZGMkWOL+BRn/gh24MKIlStT8COhjhzhVdg/8av+96rbmLFqRmfSeSudQZL1RWuQH53uTCjMvs30hVXGOubv3Z/6v818g0lbpHlHFLuXJ2uRxlMbFlf1lk/ljfz0qxlO4aLpJWuq7fBFiqrJD+wdbHvifX1l3LtBiLXY3gapBmyxgdCxMESpgHkohfSqV4QrX4y7B+m+ZmyppCZ6HldxQPw5TMVG+IDjMOKHZIxndGtI+Uy23hIvoLqWiI866x5bhyzw69jR53ypx6/Xg7rRmKwt9i8F7RyQIriaeDy3JNncCK6EIFVNW6qmNXi8qzmwoRJdoso7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Igaj+Ut44ro+GrYc2hRjahnOPjee1r0cyeYwaADurCo=;
 b=Z5EKePtQ0a11Rhgw3TNEEucYtQ0LNLvcVPh15Ei74KGktQWBweVzy5VYQCZLN+Tv702vSfeL+1RpIc+L+az5cva4OUuDgbY9nGcCbpyTLO1zguW5iTjjnMb8+eZnvGDv2xiAvgoyfUpV1juv8kUis+ZfTfmMNRfRws66f9JWSMwiOn2pm2i/Ea/BlVUWkVSaTQnTJenI+otkgejZfHsrEPUtqIPg5zFgYhew8V65KqdxGrXGmeyq4G455Jco3vYCrmCyONGImSf8bFrKUi5ES/mfMW0muw4gcMBwNY+AHN+slCHjGIeawmLoDVnzsfigd9KalYmVPgmn846A7gZnBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TYZPR06MB5393.apcprd06.prod.outlook.com (2603:1096:400:203::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.29; Wed, 14 Jun 2023 13:36:04 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::7dfd:a3ed:33ca:9cc8]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::7dfd:a3ed:33ca:9cc8%6]) with mapi id 15.20.6455.045; Wed, 14 Jun 2023
 13:36:04 +0000
From:   Wang Ming <machel@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v1] drivers:base:Fix unsigned compared with less than zero
Date:   Wed, 14 Jun 2023 21:35:36 +0800
Message-Id: <20230614133549.3774-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|TYZPR06MB5393:EE_
X-MS-Office365-Filtering-Correlation-Id: c960741e-0204-4bce-4bd1-08db6cdc4c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zwHCK6NEDZwtlfD8nok4bpcb06/KmwvlISWb9MPYh8EMXt7c68MBuv22xYQZEsnaJD8NXhMv8G1OHpK5MKBbC4v6bnYKGUbeGtvFA069TF4h60INLjI/RcM+OOspi5J7kO9AkvcwpOnc7DYCimxap6bovaekMGu8LVDjwUloilOO9lQHZj24L3YhrJms2du1Ilr76fsbsIprqC+l7QF/shW5H9f6psc7cHM6urNfc3TBEMZL/VnpjLdWB7YynO3hm7hz+DFbmp8Ki04ufaxRDZjMCpJXYUtSIY7b3I5d0HE+iFMl8euI1384vJFIvkduYikHINIPQuzGjcGBr3tlI9ZD5j5htHJMOdiNWFagcHROl+srtJlj5SclZoT0CUDmwBG4Y0UlH3NGkeWk3gitvowND2sELMxOsJ7+4Cd4rhL01wqJ39TP2jN5TsWNZ5hzwYJdG1ecUcEF9fRs4BelNMYHLI2C/gQKsWChl11mn1wX0T9OOu644dLiBIhLJN+Dlel4zqQ2YvbHMjC/DcwJItz2magzeKs5UW9srSCC6R4oFz5YZwI/bHCKbdDbOGxiuWyWqMzrQc/ilzhC3aZNksvf3fiSwx04gVO5iqSoGFMhIe5k5N1JcMu1Oe7QVLcF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199021)(66556008)(66946007)(66476007)(6666004)(316002)(107886003)(4326008)(478600001)(110136005)(86362001)(36756003)(1076003)(186003)(6506007)(83380400001)(6512007)(26005)(2906002)(8936002)(8676002)(5660300002)(6486002)(52116002)(41300700001)(38350700002)(2616005)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8JdxNbsI3rgoDZRXXuSnVnhS258nhEteJHLU2Md3n9+LfBSo1tremQsgpn8D?=
 =?us-ascii?Q?Pjd4hOeOkJ4vDxa+LBUFsuHN4/DUrmhazdbWebubjAT6NPCEQFLAWmF88ZC1?=
 =?us-ascii?Q?eZ0RL12jmGBDYAZIyngES299Ez3Yb9OukHIL93gTzBun5HdDbYDi7dz7Ejzd?=
 =?us-ascii?Q?N7D5qoHIPcKKgDGUg4itIvjtTfI4Fy+jT28GgkoExHYxh0QvWKuClKgaB50P?=
 =?us-ascii?Q?8Mp914dHLkplQbsTnr4nPUK6Hx5e1Ttl2F0QWkV/eRC0sbryUHqXQr2grlgY?=
 =?us-ascii?Q?PCv5ohH7y7zvPK7udWQ5fpjBCa+dg3W/QvPxnnZj2p2eZrPiSuAHU+/2TpgR?=
 =?us-ascii?Q?+Dum73ZrFTfKkr7oPZUpM2CGC8xif5LY1ruxd9/3VVQ6roh8bqWQmUhczZQ/?=
 =?us-ascii?Q?99LXcGZXz4ZUx84P/HMMNYETdJ1FMp23UERNwNqk8AoZbIbQfhhSWZQLh6GT?=
 =?us-ascii?Q?dsS8w4BeWcxMGvN8MhJU++c/OH0q+i4hmN4zVZ+9LhQZrEQfF+siPZ7kbxIO?=
 =?us-ascii?Q?J7+oKSjzN3Y+qjpDsrb0pTU6HSmM1b+rV4BaDsN3pJwZ8DH5ZIuy57V51xVN?=
 =?us-ascii?Q?rJTLFnN4BHWPuyy69fbwcL1GTNWCQMPRW+ZDdRcHQ89ZUzuHNWVyZm0qIGKD?=
 =?us-ascii?Q?VhDBWiBnoX5tseHa4THG48pxJYG/G8++W5HSQm1v9cRHrD6IImXiXnSw/3Cd?=
 =?us-ascii?Q?CaUjPSepiajIxDinKCl+fP/Mhm/MxgyC3OFA2HPiwOsBBb2QSZ20aF6Bh6TC?=
 =?us-ascii?Q?jis3Y5ZQBjwf/PT1AJleiEZUMtax91kWwsAn+Nl6lxaH4J8FmcGFp3LQn/re?=
 =?us-ascii?Q?p8zv+UtG7eFEaMSgrvzzZdp0MOmZ0n5VklnS3kFV2oBZeqKMduwYuSjw/0mD?=
 =?us-ascii?Q?i5SLjH350s0Fc/IAlGKFmmAfeKxNIhNPRLUvEJ9SxQDVZmy+66GUVwAePeZV?=
 =?us-ascii?Q?wWpCMZve1H2IDN460yleMMDg7I5Df2CPXYjDoTVxMe0D+DQvjkED0686JURu?=
 =?us-ascii?Q?sKIIFnn+0ojxtS7tghKtRUFsxvI6indiKpXp3ROLSkeu/JliZCxa9S+pNSnA?=
 =?us-ascii?Q?F5ylQ7dRBb08uReknTKrriBI/anJanGXA7SBCzt693pHec30jupPeiur7rMs?=
 =?us-ascii?Q?bn8bmfjbRKX/r33zj6XbOQFRlfozqwkyHiC3Z4br2KhElJhQumrCo6gNmq0N?=
 =?us-ascii?Q?aT73Jj8iL8LncwZEOfguSJNJeyKAvhECLlJFHnoPgMM9449Tyv4KiyrTrQCs?=
 =?us-ascii?Q?0Sv0wil2I2EZTwFYTh8Jeqgk63YQVecpteBk38EiduF4kzNZvzoerYblsa3o?=
 =?us-ascii?Q?A75eQMQUbSoG0Br6Fu5QdD+rg6zsNMpXor/SOkg1fGWFCjrVQ1cwcM2g0tpC?=
 =?us-ascii?Q?IiYSjSVkSVhRXiX0edajPtehN8uBRKSaZTy7dJh0wcIH/aTozSK7W+gBb1Sq?=
 =?us-ascii?Q?7Dl/yCUI+fBjEIBpTKBxL3i3Y6gf5VlhYvgnVQcpBckIH6hNXgytx3kprwYl?=
 =?us-ascii?Q?Q8wAweLhD5ga0/CMyxCNyzbD78Ns8Novn3/FUXgo4q6OhDgC1eR0ZjJrKSZy?=
 =?us-ascii?Q?XwAJcOTeD6/QJFAEubazktkIINtLlNWA5fImWKdy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c960741e-0204-4bce-4bd1-08db6cdc4c19
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 13:36:03.3822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qqjYwDE4vbahCls4zVKoag6n8awkvL9BuFh4eUbriU1S0xaDA7RxMp/LW+u6F4U7MNtW1EMbTMfQebXNsDhuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5393
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of the of_count_cache_leaves() is long.
However, the return value is being assigned to an unsigned
long variable 'leaves',so making 'leaves' to long.

silence the warning:
./drivers/base/cacheinfo.c:300:5-11: WARNING: Unsigned expression
compared with zero: leaves > 0

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/base/cacheinfo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index cbae8be1f..7280d5cb3 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -289,7 +289,8 @@ int init_of_cache_level(unsigned int cpu)
        struct cpu_cacheinfo *this_cpu_ci =3D get_cpu_cacheinfo(cpu);
        struct device_node *np =3D of_cpu_device_node_get(cpu);
        struct device_node *prev =3D NULL;
-       unsigned int levels =3D 0, leaves, level;
+       unsigned int levels =3D 0, level;
+       int leaves;

        if (!of_check_cache_nodes(np)) {
                of_node_put(np);
--
2.25.1


________________________________
=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=86=85=E5=
=AE=B9=E5=8F=AF=E8=83=BD=E5=90=AB=E6=9C=89=E6=9C=BA=E5=AF=86=E5=92=8C/=E6=
=88=96=E9=9A=90=E7=A7=81=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E4=BE=9B=E6=8C=
=87=E5=AE=9A=E4=B8=AA=E4=BA=BA=E6=88=96=E6=9C=BA=E6=9E=84=E4=BD=BF=E7=94=A8=
=E3=80=82=E8=8B=A5=E6=82=A8=E9=9D=9E=E5=8F=91=E4=BB=B6=E4=BA=BA=E6=8C=87=E5=
=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=E6=88=96=E5=85=B6=E4=BB=A3=E7=90=86=E4=BA=
=BA=EF=BC=8C=E8=AF=B7=E5=8B=BF=E4=BD=BF=E7=94=A8=E3=80=81=E4=BC=A0=E6=92=AD=
=E3=80=81=E5=A4=8D=E5=88=B6=E6=88=96=E5=AD=98=E5=82=A8=E6=AD=A4=E9=82=AE=E4=
=BB=B6=E4=B9=8B=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=E6=88=96=E5=85=B6=E9=99=
=84=E4=BB=B6=E3=80=82=E5=A6=82=E6=82=A8=E8=AF=AF=E6=94=B6=E6=9C=AC=E9=82=AE=
=E4=BB=B6=EF=BC=8C=E8=AF=B7=E5=8D=B3=E4=BB=A5=E5=9B=9E=E5=A4=8D=E6=88=96=E7=
=94=B5=E8=AF=9D=E6=96=B9=E5=BC=8F=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=
=BA=EF=BC=8C=E5=B9=B6=E5=B0=86=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6=E3=80=81=
=E9=99=84=E4=BB=B6=E5=8F=8A=E5=85=B6=E6=89=80=E6=9C=89=E5=A4=8D=E6=9C=AC=E5=
=88=A0=E9=99=A4=E3=80=82=E8=B0=A2=E8=B0=A2=E3=80=82
The contents of this message and any attachments may contain confidential a=
nd/or privileged information and are intended exclusively for the addressee=
(s). If you are not the intended recipient of this message or their agent, =
please note that any use, dissemination, copying, or storage of this messag=
e or its attachments is not allowed. If you receive this message in error, =
please notify the sender by reply the message or phone and delete this mess=
age, any attachments and any copies immediately.
Thank you
