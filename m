Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4391615C56
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 07:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiKBGgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 02:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKBGgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 02:36:11 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3442D25EA0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 23:36:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNTLeIQqt5bc9kUEM4ri2frMiYVDeKUv+SNEQeWz4LFK7uzWVHmSFoCnZ0ovNUkLEwoj9kwPxxGmeaTtG1cY7HsWnQewFQp0Kbm8HGzjqb4P+iOsoBOHBE+b0kc03jvBOvWp5Dnk1iIhGd/P+4wXmz30V5pHptl2b1dqbKW0lOIKaGwoFvcfS1A88yPlNIT/b2yRreWb4PDvxyyIVXshBAucNzajYVlc8R/5kR+mFvQmFN+k12GT1+nYBOpOVqzr3aeI4Rc3sNpi/y4cJZ0/rfiIc11in2yqUPWHnSkcSocrJev9ro5FcyuheKUdR1cJYYE4wx//gol9z8NWWNPQ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++80gqbVUTcBqH4xW79UJARVRVB585J1tmdHb+KsZzg=;
 b=ZizmY3uDKwAfpG73SP4fQ+OGHmqzmmHDkisvHkgq1h0dP6hZ4nB7zLAZfUD0H3c6wgpvL/ZdGPyxMjxr71RAOtFFjssZFKxJLkhgtj3Das5es60V07hQWv2Vc1EsrRTshWiW54peqS65OeGqUFg4um3jwe9n59DEuDWzk60/oZCGKIQH9m8CMLbH1MxFl6yd3YnRCr7pWPSP00oyJvyTJ7iWsO94EqC31+X/NC60QzrTR60TLsUzXNnD3DtKZXMhdV43M/KGVzuoBx2YJwoJ6+jsk+ifzy+o7RbjUm9MhRLmVgnQySpPYgFoIODEOBofDs5/NPNLEwC4tm+Uw/A7/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++80gqbVUTcBqH4xW79UJARVRVB585J1tmdHb+KsZzg=;
 b=rwT7Ql2G4H2C1/Oj6m3mPak7v+tKFGUHc5WGznuf6KE7TJb2D8voFVXciHipzcmg7BRGSjeu5GaW1yvoJiyFl0ipR4NtoXV/a3Q5R90niW65wikjzkMhhJaYxkbQXPWSjj7ajG6Zd3hwD5mUu9B3fpj2zRCsQfMkdbFzy5U6kb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AM0PR08MB5459.eurprd08.prod.outlook.com (2603:10a6:208:186::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 06:36:06 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637%2]) with mapi id 15.20.5769.019; Wed, 2 Nov 2022
 06:36:05 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Simon Xue <xxm@rock-chips.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH] iommu/rockchip: fix permission bits in page table entries v2
Date:   Wed,  2 Nov 2022 07:35:53 +0100
Message-Id: <20221102063553.2464161-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0004.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::14) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AM0PR08MB5459:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb72067-b268-4473-eebf-08dabc9c84e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: au1DiVCuVkexk3Nq7hc/egyl4eGg3QoODZsUEs5XQ5eOrfndd6h4QI0Z920s+slAYAHqOMRaYfHbbYcKEdZqrcYCQGk/OA+aCRXPSmClxlEhDjlF4nNe6YBeLoGy3+/md+3Zq/NHWR8cYXWSSA/3Wd1ipPn3y9tJJQPpq/aIhhG9MQcLLqpye+LB4oyvRwwP5WTZP6bznOSd0LASKUhKarEJ4KWW2MwYfAFhSgLpkfdXP+DnayG8l9ZIabG3dqyLvkXB8QtCU/XL56ueGd+tAzaMmN6BYubt8AM9CEuhGy0BPuyYN63Lfqvo7BWp43vM9oAiWUkRILBngVtv44XNbDKvfbJDI6ppzdG2FEzX6I8oXH+WtTCbUe1S0I0jC9nL7OATtkcsU1gjKfclxVv7TP7ct9iWfhP2HSWOaN8n27CKNo3cHCrNTyTTzRfzrLK3cuoWTmVyT1HYxWdOhk3qJvANWRI8t+tAlSqvcBhNMzT+sKXzlFlrmkGTfXHil2R+CXlZF2cBBmLXpe1r2aFobX6rRE78yhHWGfmXgdWVjVIW9Lcvg5C0Y+jbixCHywrHgoUVNCEhSb7EcoLBoJTfoztgofsv3hFfNQlXibCsy1itYJjz+P4zbVn9pCl7mZIGEqkkLkZwS0V7bVKAdO7hEUNFA6ba8QGaAGwsDlKP/kRB39Dd9f964OcHSi9gWUKFjscRZtwJNsJvdcWlEEU/XNAsow+WLDRlrh2sl1DARec=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(39840400004)(136003)(396003)(451199015)(478600001)(966005)(6486002)(186003)(2906002)(1076003)(2616005)(44832011)(6506007)(4326008)(6666004)(107886003)(54906003)(36756003)(316002)(8676002)(66476007)(52116002)(83380400001)(38100700002)(66946007)(66556008)(5660300002)(7416002)(8936002)(6512007)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gRJsmnxn+SeF8rkDgqsXQW2pA7WRslPlFsyoQSFsG45M1vK9QYGUYNlf1AEe?=
 =?us-ascii?Q?XNgKvvSIGrFv3obXTQKCxmyxqHjeK22Scmw0c3sFM+ORv/ELSL/KbuSQd+WA?=
 =?us-ascii?Q?M9Q8va7+1YMyfJj5I4cT8ntB6QeQ2EpKzmhlw3iRMwS2jVMI7LiM4BtAAtSw?=
 =?us-ascii?Q?gf4Po5LtQAKonw8hp7/NdM5rapWptBfXkUa2mJoKcnGIu3z72uNUSAvI3p2p?=
 =?us-ascii?Q?NuU4UfIDLI4UW7uQ7d4at2VNTM2K8bgjinr+bo8Wjh3Idq9lYADiNt5rrdwy?=
 =?us-ascii?Q?1WsIfGZCEEPIKjWJqhUjHAXUVgGm08Hn7N3/1cpZXiDqurhi6B2ODijlW6r8?=
 =?us-ascii?Q?w9NwmzkRjZJxK+vvwhGcYB7hynEU0rYPolZ7RnWSVa2aWcnf0CdE9Bu7EAkk?=
 =?us-ascii?Q?N2mk6N46zH3fJBtJ1p6Vr0ku2OEHC3/IgNfbACZyQZvE+BEOPdedGeJuxCH1?=
 =?us-ascii?Q?7NO/X7LiKqGaXb+4wbdi0Pq5PqHVTHRz4ZB258v358YSI+Novobr5X3yjAms?=
 =?us-ascii?Q?mE8qS5XHxZXqYFBNZUTwz1xM2xq5ihwYwVfX28wnrB5sIEdZKLNhCGuv/jum?=
 =?us-ascii?Q?VT46xeOX6aH4LWM5rohdTBSATIBD9uMFZG42Flw0SgoU2ZepsjrOVEoCPyly?=
 =?us-ascii?Q?BLtbpe1e32bJK5YpvFMBbcv1mUKbCY8quCrE4bMwD1cLFUaRCjfTPjLo1BS3?=
 =?us-ascii?Q?T5n6+7NKEhf+56DwvxLXoMp0sZmUmtyv8/oZX+fvHZTu29tcSNl6XAk8byhP?=
 =?us-ascii?Q?kjDax3jQugCmJlfAzXWso+O276y+BO+kipiwC8EQfcpFVvjfbmdrfAtXzUiv?=
 =?us-ascii?Q?ywFBk9Zh5SHqllreZm/Ww0dlofn5QwesE2Aug9KdpZGyobi0VTrPsN1bPuoF?=
 =?us-ascii?Q?IOunPcnB7GUk3ytet0QxNjijfAWOd+0t7e8tBiJKIRoz9BRqv2OY9w4QBQ2X?=
 =?us-ascii?Q?xFIn1UFnj7xEfn182VqUSyNXVwidmyNqtaCLeTBeiaVOwu7nTsChxVHRHkWd?=
 =?us-ascii?Q?13ax6dp1jJSBiJDiHGdwycWFCpzmRhv3wWj5iamRQ4ohqbcir0aqJCbXGDTF?=
 =?us-ascii?Q?7FwOJK8jnUGrBH/A+ZTj7OmM97lYP4LQcvmsSAbGmpR+LPg9a800dwPU4hgz?=
 =?us-ascii?Q?6UwkafxikMC5rUZ6PhXUv4pBRH6YrpMVev1zFb2xhWryX1Pdc8SxwpBmb0+y?=
 =?us-ascii?Q?M6KJMFuCmhodjBpnk4TCUt8/T/ihCqqACDpF0YlMIk7LO4w+9n5Xvpd0LpwC?=
 =?us-ascii?Q?gEYWQVer5Fqg3ohvpQoUrj21ZsJrXY03g/swi/cz4m5lMftrE84BAn1NyQs1?=
 =?us-ascii?Q?NTrY4OY77EHgBICK/b6v2m4Exk4kfaw5t++Btj4PLdlsp8/R66xBEmcGOpxW?=
 =?us-ascii?Q?U2gTbiKFWj66zCIwidFkNRHPdyQgIkNKRvlOe3n97mU44ssrAXamDY3QafM3?=
 =?us-ascii?Q?XVqfV0U0u+joWDSJ1+l5oxX3+0lvnplYNvAcUjNYhTYS3iewj0gCgpn21QwS?=
 =?us-ascii?Q?oCgHDdJAtnN08d/ckxHML4ackzSc4QP8dN6dJbINvPWsS3CnaFm62rSYH34n?=
 =?us-ascii?Q?yJ9hUSrOSsIcVQ+12b7I2rtm8d1ZvUvYLg36KI9ID20oBMX2j/iNHSSs7lei?=
 =?us-ascii?Q?wemcP5jVvCfq6XegOjdRCQ4AuE9OYJ796EuL9Z4EI8csPWu/4VRJN/NTMGnR?=
 =?us-ascii?Q?Q75HYA=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb72067-b268-4473-eebf-08dabc9c84e7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 06:36:05.8308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wikYqcQw9xFy8XtF4b6yiyueizbFy+HUc3haRF2QDqiei+R+4+HSm8lyhnaecQhWlM8xUGGU1/ERtJ/aSxK5Uyna37cCuUVLKSzki0X/xss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5459
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As pointed out in the corresponding downstream fix [0], the permission bits
of the page table entries are compatible between v1 and v2 of the IOMMU.
This is in contrast to the current mainline code that incorrectly assumes
that the read and write permission bits are switched. Fix the permission
bits by reusing the v1 bit defines.

[0] https://github.com/rockchip-linux/kernel/commit/e3bc123a2260145e34b57454da3db0edd117eb8e

Fixes: c55356c534aa ("iommu: rockchip: Add support for iommu v2")
Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 drivers/iommu/rockchip-iommu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index a3fc59b814ab..a68eadd64f38 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -280,19 +280,17 @@ static u32 rk_mk_pte(phys_addr_t page, int prot)
  *  11:9 - Page address bit 34:32
  *   8:4 - Page address bit 39:35
  *     3 - Security
- *     2 - Readable
- *     1 - Writable
+ *     2 - Writable
+ *     1 - Readable
  *     0 - 1 if Page @ Page address is valid
  */
-#define RK_PTE_PAGE_READABLE_V2      BIT(2)
-#define RK_PTE_PAGE_WRITABLE_V2      BIT(1)
 
 static u32 rk_mk_pte_v2(phys_addr_t page, int prot)
 {
 	u32 flags = 0;
 
-	flags |= (prot & IOMMU_READ) ? RK_PTE_PAGE_READABLE_V2 : 0;
-	flags |= (prot & IOMMU_WRITE) ? RK_PTE_PAGE_WRITABLE_V2 : 0;
+	flags |= (prot & IOMMU_READ) ? RK_PTE_PAGE_READABLE : 0;
+	flags |= (prot & IOMMU_WRITE) ? RK_PTE_PAGE_WRITABLE : 0;
 
 	return rk_mk_dte_v2(page) | flags;
 }
-- 
2.30.2

