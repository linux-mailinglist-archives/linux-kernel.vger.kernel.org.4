Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4090C715B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjE3KRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjE3KRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:17:39 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2129.outbound.protection.outlook.com [40.107.117.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E82D9;
        Tue, 30 May 2023 03:17:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnFB+LEyvzrV5UT/kzy9RW5bjyhl/NI7GyPgFpSCxlO2nkS6jy0sRjP23LKPYY5E7fK/6qssmom4Z+Y5jMfG+cds4cBHeIuuPBgWn3BzIzt1lYPwsTA8wH6wBN1ch02lO7fsyWtJBer149Sw6tjo1EVvNA+XYzt9WBszJWBYPijkoRlJuEnnY1aqQMIB+h31Oh55CZcSnvhpF4y0uj1T8ZBySoTR0zB4lq/ykjtAUGzXhdCmMyETnjfpZ9IYBlakx4Cm68jNo+ucU0fmKw8o/6/8c2M9ZQLypaRXBq3XQvKj7gsEOsihctcwfyvCkUv7J8OFH19WOsklpZ7RubdNow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+g7zHyQlpi5vDv55vDX8DwbWAOc0Ei4FtxuCd7Jc/E=;
 b=RNMVz+renba+FQvWgNzPo5vMoqxeAcqTZygGQPGmsUQC6Uryh0Q8juBlqpBB1Pt5n9XnERcStXKM83OrwRT85XDIpsSIJnx1Oh+BzRgAvuCLHnHGtIHLjZVdAuAEpJidx17UgxyAFLdh+VPNBJrsSXjNaCH6wzJXtYvas92GEi9LnbwkSi1rf+ps6/l9B2qDrx7W7fiG7a5+wMVs0o0mNKl1D0HKuw7Fyb0R64LcCYocvLIShrMFIMxLIdRelhG5X7Bb4hYYjuXbq4O+m9YgddTin+B9gszsGOHrfuGFEx1sRD/wvwmDy8AZxTXdtgY+zHzb/IF8Seu/WThJUneRtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+g7zHyQlpi5vDv55vDX8DwbWAOc0Ei4FtxuCd7Jc/E=;
 b=fJPeYCPfm1A49v3D5i9mY3cXNev8r5ou0PhxybU9vaHcqeLtdoVLqNVgJ35FXgAVhQP3auKJu/fiJilFqPioqsQYEKFb2RQjnx9BZAt3J9pZDIHSFbZ0xoNoT+CNKKx6rUSzkp1OEhyoZBi938UQcbJoF9p1+G5NuEhf7dFwb+b4cB/vS+/NcArFzr4FlRrX0BT6XSsO8KaVNreeKxAFWZji1YDofm+cNhqdSkhqVyHiZNt7L68YLwWM/YVxgixAjzshbs3+z1D4+A6ZxLmWa1Fw9N6mPLt+eFdAvX+j3s97rez3GYP1yQkrZ1UYaLuY+ARdixduHAfMRuJKYP2QgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by PUZPR06MB6032.apcprd06.prod.outlook.com (2603:1096:301:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 10:17:34 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6433.018; Tue, 30 May 2023
 10:17:34 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Moudy Ho <moudy.ho@mediatek.com>, Sun Ke <sunke32@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>, Lu Hongfei <luhongfei@vivo.com>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)),
        linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH] media: Fix resource leaks in of_find_device_by_node
Date:   Tue, 30 May 2023 18:17:18 +0800
Message-Id: <20230530101724.31412-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::21) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|PUZPR06MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b71193f-fd70-4f20-7ee5-08db60f715ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J0Zw9Bfds2S/7ajyOj0GQSo6gdrlpm4MxTek7I1cHRwnyLXG2OooCwHI+pCyK/cCq+KXPAuKuYvU3Piivj1WWcg/89HxcFt7Zzicx/C6qf6ouOFLNOyxc85xqvg6BZLTghU6eeFCv7sAKaL4XzK2F/++GtmauJwFKB+96pjPTZt0tKysl6dwBd/GswLqX/AMrxKbs4qqewb3UIOXiXdQBOiB5AOGXnqGV9eMDejtBGXK0pI97drIcPZ4HAntyZJB+0JO/uEtrfDN4uohA72xN6/Hm/2RAlSqvHYD8dSlfnJHDETyspFzP8zauG1NKD5uOoLlTSQl4T3vEosEqkgHGvx90y/lq4mVrriZi+QmZ2VdUaSZGxfUBJTmWK2q8SqC/CssTw1y00MKp6Y6YS/yy5KM86DfsTy/EM3VwzuQTVJ8rFLfyozWDBc6qJa5fAxFTSD8NUwJdvmAHj/HlA3dVhTCbOwpvzPsqYk9UN+4fIlGNCK4ryguYgjTc1VrtV2a+924wW4duhTcvXk8fnpxy2Tcs95SCprLCxH2fDdnz7mVzXkLItSE0bJ7KD1qJh6hmfLmZzCJunPJetDE6dqUUW5vL8fihsJu8quFxmB/W/SNZUqKgkWQGCBpajFxKQ3f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(478600001)(110136005)(8676002)(7416002)(5660300002)(8936002)(36756003)(2906002)(86362001)(66556008)(4326008)(66476007)(66946007)(921005)(316002)(38100700002)(38350700002)(41300700001)(2616005)(107886003)(186003)(1076003)(6512007)(26005)(6506007)(6486002)(52116002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OvJHRLUu+NJQ1N8cHr+mH0rY2feN0donY7dLKU954CkzztGdJCxNJWV4qeqG?=
 =?us-ascii?Q?JbrfWLwBX1VuNIAx1D2DXTsXOw2OZftFqbgf9yzYrhCC66Bg9PJaZKCgUAW+?=
 =?us-ascii?Q?38iG7y0bDT5wS+gNgnFLTxM0f5lS3B3Ev1Ul80XStB9elGw/N8ngswrL7JG0?=
 =?us-ascii?Q?dqBkMiBHQPFOch/FYtto5Blmx558VXAyntkzwfnXScClYPKlOXcfMq6aielM?=
 =?us-ascii?Q?mYrsD9JNnp4zjlr7Y5SHVWqJuUSSjxqm45YWtmiQJ0YYI7LnYO4iV8ImH8Oz?=
 =?us-ascii?Q?Mp24XjQ+mWgb4HbWUrwOZX03842NdsT/kN/eJyNWxhBi+JuP2nWyN3OSqr84?=
 =?us-ascii?Q?kNxbZv1iQ2g1Gc8qpOmWeOP8o0lBw3WKLTL5bd7afBi1PbfJ4zWaTpBxtjaJ?=
 =?us-ascii?Q?nmNWehi8M269QaJny7KhdwbxnE66ylPJViuztt1IzdTII8ilQftQ4aYkq+Rf?=
 =?us-ascii?Q?KpaX+5cFjYefH3YIc9QKwW4WsEykUkUamdvp3WfRo53WpDrDYF7BpbATdLqn?=
 =?us-ascii?Q?QCpL/Ufk6+3i4TRzTguJoeILua9WPqe90QHsMmmlyy7RNmjv83ZFzXheUkqo?=
 =?us-ascii?Q?IJkVVSdO8D5df20P2eFxn9hP0ga1krmRfH3ssfwFgR8Fo2BLpatOaaNvtop9?=
 =?us-ascii?Q?5qlM0DRiMAXw4JPDnj+7Od5gBtraGwcL7Vuq5g62I3oVzs7BnJ683HElgy0T?=
 =?us-ascii?Q?rk4k+nCPmev4fqZQZoAMPNnrXXICPGEx9aIs/Hb0ZSkL/E1EA/K5ECgOOq1i?=
 =?us-ascii?Q?5s9TxtHl03kIezTyuNjLpUkoxEoRI/znlCE5OPVRuzkx5fHcsfV7nuZ0fxKZ?=
 =?us-ascii?Q?AYNL8NV+syyL1rI9s3IqBoHCBuTj1o+kaCD3fgqWdAIwC5YH38bt61iVtMj0?=
 =?us-ascii?Q?LMFAiNQ1413OIYxFJolyT+skUzPQA3Tg0O8vL/VJTo7877vslWvkUkVU++mi?=
 =?us-ascii?Q?+Q/qRpIkkGXPoVMGMKp3JkJs9WYpeFiz3uXRhU8Bc/2l1oO0ybK5mQDA6cKf?=
 =?us-ascii?Q?HFKkNS/3/msKkdM4KzoRKmNJc80eWHxEj+spjqLDcoGDUhwbwVNgWDYi65Ni?=
 =?us-ascii?Q?/4XwdNXFrP4UbOCJqQYYtrSMC320h4tdcTKgSiTOHQG6JQ2Bo9voHalt5zLo?=
 =?us-ascii?Q?xrLteCa1VSCQQ5ScgKsR39P/GsoVYZctfUMaZQ9HTKVtNT9z0K4J+eteD7yy?=
 =?us-ascii?Q?hi06GXgz+Su1x+Ubs2XVqw18Ur/4AMZWcINE5D3nxKO7pMQwlU+Fn8l8ANah?=
 =?us-ascii?Q?J1IJzAq+1MPrHmviTa09l8zgqra9EkhJjmqIDjaxC0yLqclUh11KL9dyMWD6?=
 =?us-ascii?Q?QiJdC7XNn0Gqsd6ddhS43aBc4lCECGqXn7h/3iJlGmwcn2fwhtMlL2vCUChY?=
 =?us-ascii?Q?0VKlrcNUZqYR0UIAeIcuwnlqAbnNOeZ2mURZY9132yFdQLc6f4wkMGL4qJWV?=
 =?us-ascii?Q?FDGmJL611gofrxm3D79iqQo7QPTq5b5d63KevrcwySiKofvnsm69lF3jYAYo?=
 =?us-ascii?Q?qAwld9NuEzaL6LNVMItdlpTQ/+un/0+YahegE3J7rEFDsNAih0sVh2FQS2Je?=
 =?us-ascii?Q?pln1z09n3qjYhFmokunGL46aB+PUyUzIMJEB28uQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b71193f-fd70-4f20-7ee5-08db60f715ee
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 10:17:34.6622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JHC7MzLp71kFw+SZzcs1tqyY04mLVEKgv2/5nHSoM9FuPhplnAHzC26gbuezG1/VjDAayu1BhmvEJwJ7z7XKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use put_device to release the object get through of_find_device_by_node,
avoiding resource leaks.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c | 2 ++
 1 file changed, 2 insertions(+)
 mode change 100644 => 100755 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
index 19a4a085f73a..1fe10a21e395
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
@@ -892,11 +892,13 @@ static int mdp_get_subsys_id(struct mdp_dev *mdp, struct device *dev,
 	ret = cmdq_dev_get_client_reg(&comp_pdev->dev, &cmdq_reg, index);
 	if (ret != 0) {
 		dev_err(&comp_pdev->dev, "cmdq_dev_get_subsys fail!\n");
+		put_device(&comp_pdev->dev);
 		return -EINVAL;
 	}
 
 	comp->subsys_id = cmdq_reg.subsys;
 	dev_dbg(&comp_pdev->dev, "subsys id=%d\n", cmdq_reg.subsys);
+	put_device(&comp_pdev->dev);
 
 	return 0;
 }
-- 
2.39.0

