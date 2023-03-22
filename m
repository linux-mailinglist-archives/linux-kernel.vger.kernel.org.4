Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852516C517D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjCVRA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjCVRAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:00:02 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2121.outbound.protection.outlook.com [40.107.215.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7639C2823A;
        Wed, 22 Mar 2023 09:59:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oY2WDcniWteT4RngVY7hMP6WbEIaFQPuRsjU8Pc+FuOjNMy0hkSNQwFkXwHp9H53INUjP6qUd9y83l0H8kx75PYH3VR4Xik6hDiTh7qzAOrpE1/JSqrw0fxySohv3lKSEqxFssz6W3sjhIawUTpHGab0oKofZQtKV/Ol/+hD3RG07k1+5niny1wrWzUfpbV8FCjRf/fAoRZZkCQqKZe10b/jt+VbTOlNHYOi5tM3nqjNdfBeLK2roTkwQwoQ6NBPZjFIq39lfvGHvDv5gOKkWZw10Phmxa9+uwdAVOYm1J8DobhtbOCZbT+xy7s+uGeK+e1snlNh/YUCv++Zu8QJQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WV8vWGKFQ2SpsYCXDRkcEes8uHuerA+1iOZq5yPEi9w=;
 b=FkFJY8I51zoEq6SjBpeKNuDTjGoAR7a3prfvx2AyM1hBzhJ2EDsv49KmdSrKfYomvymPH8uW3SuVDR3k2EiTqPBBoUh+L3Snt1hoCwoROlsTZKkgeuBdN55Aqu2bR9nqKC67APpoxu9g3bz6AIeCOkwuN8+0i0cYLfJsVfgOKLRBNk1kFoh3uJC2Y3Ad5Ys+NWK51aL+4HfBgKMrfsw9h5Lcj7nH3eYWF1/KxQzoBE1DG2imm9k1sdr/oFwccFnl5GukEpehUaa9v57HVlgP0mWi007SlCU28Ry1zBicqSkQYUgykDnk7uI1xstNDNyrWGe7Fm492gq2bLudd4++Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WV8vWGKFQ2SpsYCXDRkcEes8uHuerA+1iOZq5yPEi9w=;
 b=B2wbSRQU3Lh1dcYFSAkPoT8TPBEA6fOM725RJaouswD/vXW0i/jJRGQ8KwyWrcj2bLEwBZTYN65UF7K63y9LfimbFNGbGQbA9xX16TqpFTFOHdKIeoZfb4Au5MMgd8DDx628l/xfrUNDA06byuU6Ve0Am4jSlSXHElYCUr1VB9P/HQZc4Z4gS4AlJrFFTJ5q66RQQHX3U4hZaT53qzstJMClbNyJm0fHIaidVaKxWnBXuGS4HI0gjkng6QsJaL65lcvbvdgUXN64BmUqp+D8ZZ9uKiQ12AkBM/6BXqqsKAZFWHbFU+p/EggXcnPkk0pK8UPtF3mkFHnC5+aYK4b6JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4107.apcprd06.prod.outlook.com (2603:1096:4:f1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Wed, 22 Mar 2023 16:59:53 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 16:59:53 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/10] xfs: convert to kobject_del_and_put()
Date:   Thu, 23 Mar 2023 00:59:02 +0800
Message-Id: <20230322165905.55389-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230322165905.55389-1-frank.li@vivo.com>
References: <20230322165905.55389-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e199792-08c1-4890-65c8-08db2af6db02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P9UQmxOb85J1qfXFMo3kHjkDDWlmoJqGNmA6Zf2mN8Lz9eAz1SZX6BSil0qy87Ddq4SokHR59iRtal1vuHNVeqScNwEO6frwj6SdmaBRvP0tkMwMc3iotvYELgT+nX6vsUSYqD/1S+ijxXzPKAp8IDo5ZfCQIP26sCqVSSiqh5Tagtn9DV13/3cxjPQvu4a/WnDx9q/XiQDSJ3EMY/ZOyUsvnU21IK7Smwz9an0ZijWHgeccV+l08C8fefKf5jPyICsPgV3kV1Vke60WLff+CVhgCAVehOMY3GclFR3AL+jSAWX0MF16Gj2O7poVM8iKxam4bNY6mtmiwckCiImxhwFfcMl2s+xpvMJ4rvQak8AKGx1PAgR9xvn4moOW4e9F7KNtG4tE8af2avjdqPtf2pi7CMZtIy/joKVCORMXzFE61xnnZ7kCp/5PpLwliQHSV56+1c8nOeP9Z7xbICcgepLIrVApzVRP/kIm0C3Bf8vEtxAokpv7tjHqOZQPwsE+3Cn0bPSS+vT4VuZVH6n/q1NJIROO9cIJv6VaovLwp+3l4U65vAX3XkPBHCj601LtI+9XRi40bxW7k/No91aYQSJ/6flA8c5V/P1s2yh6xFG9haePOgHQ9W8TxtH8XWIl9NCDqALgKzw4wF552A6fxlBg9kP3CsZwHnWc9h/UwqU6izJN1WJl5mQ5smU/IU4O5oUV3h1fnsnlHtFYvILrpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199018)(6512007)(2616005)(6666004)(1076003)(52116002)(26005)(478600001)(5660300002)(186003)(6506007)(6486002)(83380400001)(316002)(38350700002)(38100700002)(86362001)(8676002)(66946007)(4744005)(54906003)(41300700001)(36756003)(8936002)(66476007)(66556008)(2906002)(6916009)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u4ZSM5A8Tyt9IzAtaQpqu0z6C13X4yTMYnkVSpJMA4HdtdrKlnXYbT+mYgJf?=
 =?us-ascii?Q?HxLVTR0yOwQK27S/IyUoYIzzepu5dT1PY+ratLW7wSZdCe+pKSOi/U4/ABZ1?=
 =?us-ascii?Q?RDS0VHrn3zMPDz5QPfEXbm5hOxFr8guhmkaOmFub71k0MxIeLhUq0DL8p3jy?=
 =?us-ascii?Q?WiRGB/w4FMN/b8a4EqxrnjIaKQON9oo7vRlAhW/RuILz1b3QQoqJqn8FAk9l?=
 =?us-ascii?Q?sXoEhM5Arn9lRUs7CJfhvvX4FsdiL5j2D28akLOcveYT0inEtS3xRNawdAln?=
 =?us-ascii?Q?FepUsGUpum6n9eVPe+x9VoS6kP6gX3TtcTMuA6DFBn3MggcO4oipHNPWFd+s?=
 =?us-ascii?Q?Hzk4bHjz3pEhW5iRI3p+1/AOU5jZ8xTvh8uiAESvuD8ArydK7/FbMcxBHzhP?=
 =?us-ascii?Q?8B9EYd9yFR5Z33VVdmWH9s7jwHetj3kbgcQkm+ALZpXQgC/BktlqT7UYFYIw?=
 =?us-ascii?Q?208mK+a86yvINTRXJ8QKHul+ZG3gKmispGDWNlWyOLUBt2HVlQ5/Lk6R20JA?=
 =?us-ascii?Q?kIo2LK6XaIOTvmzlsw0GhmmAHqHCQDI1eBkSBiQWyw8knkOOyalL3HhZZkz3?=
 =?us-ascii?Q?0gT+NGz+guhKO5QVcYsinwz2S9lvX42Te2iGRfW+dw5TiD38IkqIzIlNHOOv?=
 =?us-ascii?Q?iDCyNjvUyizgsUjQpYs0hGXt+d4Cy7PWpRCIYp5WI7Psj/PPR5TPb6EDxpjV?=
 =?us-ascii?Q?lFWhT4u7bM/LSCxQkNvTZEBUEv523sr2PRjiD6c1bZBUufFnSrcoDD0NZddi?=
 =?us-ascii?Q?WV1iI9LTbcAx5RaQArc1Jm7X6C9clUoBGSDDNG76BAocR1JiUOBZ8KgB5dm2?=
 =?us-ascii?Q?DsIFrk9dYDrwHG6VSScNssaJ4hM+WDxb4hzaod674OPzU8NSZCDC/h7oJ8ft?=
 =?us-ascii?Q?KE+JYdT6QAJH4cxccAsRnBwMKJo2SSwVmEoNlOegLMxPhjtUdF/OMTOF9hWZ?=
 =?us-ascii?Q?2GaPy4/tt5GIKTA26px0BuexMpvsBoJVoT5eoDEb2bfdYiOls0QFgB79wEhd?=
 =?us-ascii?Q?eKQxJILy4A16vD0ujx9I+iSgJJUdG4acwjXF9S6OePCvbTfmIQcGPENVsqNB?=
 =?us-ascii?Q?p9hxdIlG82+4AQ9g9Xaw9MpBw0h4S8E86i2Vz43Xbb3o+CAh/k5fv+s+JVVy?=
 =?us-ascii?Q?BrR2l8dxCVsgDmMUCdyTHD2Cuj7WPMxXxMzJK4OQEWRe1F8ZYuPjxujfOsAQ?=
 =?us-ascii?Q?P2/vdgf8QkEcATKziXaDUPBiocrpJIa0zmcarpPU4X1DOQNFA5rQRR9xR0CI?=
 =?us-ascii?Q?EzDpu2JgrNeP1Tgv+l3g+hsX/DEsvyUI4VG28W9EgboaJUujLlwpBQXiy7aN?=
 =?us-ascii?Q?iT33qO5x7FUuuWqQ3Enle+xWV4LrY/yyy4e1zrMpq+fV2aq03ZbtU+WncLhl?=
 =?us-ascii?Q?OdH2GxmBV1zxrAuANspe3W8ekoM/5elC5C4/euM7/QAlqhrUQFqfutRWeStz?=
 =?us-ascii?Q?paUgisYk2MOhlmmLxnYjrcVE5fJ5oM7Yx2RcXBLJI17mVDDW6ZmsMK5b85eo?=
 =?us-ascii?Q?PHE4M2D8+X/iRzyt5vNjooW8RqiDT780gS4yvTQMoILD9+B79MTbVjYBVUYp?=
 =?us-ascii?Q?fcBeccophZSCijken9loYzxGDOvzWUFkWLqoE2bf?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e199792-08c1-4890-65c8-08db2af6db02
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 16:59:53.0557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0woDf1NxD3GNWu84fo0lVD1uGFExiZTkyUkPO7w1i/u4tuLvYHkf7oq9qRqE69sPlBMJvtegUZGDSlbLXT/Tyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4107
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobject_del_and_put() to simplify code.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_sysfs.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_sysfs.h b/fs/xfs/xfs_sysfs.h
index 148893ebfdef..e2ff063e2c29 100644
--- a/fs/xfs/xfs_sysfs.h
+++ b/fs/xfs/xfs_sysfs.h
@@ -48,8 +48,7 @@ static inline void
 xfs_sysfs_del(
 	struct xfs_kobj	*kobj)
 {
-	kobject_del(&kobj->kobject);
-	kobject_put(&kobj->kobject);
+	kobject_del_and_put(&kobj->kobject);
 	wait_for_completion(&kobj->complete);
 }
 
-- 
2.35.1

