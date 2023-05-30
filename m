Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31DA715A8B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjE3JqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjE3JqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:46:06 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2116.outbound.protection.outlook.com [40.107.215.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CD1F9;
        Tue, 30 May 2023 02:45:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSwemf0eBBIb55Yu6KBwhr/22fl26wiG4DCdQLS3PQQIL62SZvcxeg+FxjCMwmaz/kHtzrHIfA7K0qYU8/NBM3uGpvQUlkaO/S8HgY2A7zL8XDFfp3VsA3nrwv2Rp3tI7zLi0XJQcBfZg6Bq3qxYtBU7dMi6ibR2OyzHRTKhaY5yilLaNdLdYYzhi221T7pfk3P8l0IZ50j55M7zKF981MSo7qhXfQNVSzajyc85r0WDV2GagnY74OE3+htb98USoU22ErOtNURyKpn42L6MGzlfU6U6v2VSzIGSWd0a6alEe0rJAh1Sowb0InL29ES0M5ql8SBFQAR6wOU4GQKFRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFa4RmEVfTlwxtoMiTnxKntg4S14ZfofZ6OB+HfI7so=;
 b=TPUb2clRzmudAt1G62bNUUZC5RWjFbgn7rTfS7Suo/6tOUSV2275rXlyzMybsCh6l+4zx6shTbelQ0fOcdB9bcf7K+1Szrtmm+AOYRPESdw/16OukEs/LXHMlC4VGHllpDY7kLV3z3aT5QGeG6wZiDV6iVCiSaUGiKKsfIJzlQlNBC28bBzhV1U/GeJIH0/AYtZDq8385iE0F57kpKvQGyUQqFKYDHBe12N9WMZNf+flK054jLsgmMJvuRTzzfaaelnfP+4Sj1roh9CsZO6VrtI0JNn0V5PiklIUBJeh4mHq08CqjTrJaFY2wYP87OZDWhtu02Kz+2Eojscc9fT7yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFa4RmEVfTlwxtoMiTnxKntg4S14ZfofZ6OB+HfI7so=;
 b=GdbPu/HEgki+L9YfvqIwLbxvQqsebH7k2M0rpyJBPOhgFMkB3eP/IlR2EjZzNiZXLpZFY19cPPxFlNK9aIOJxw7xWc+hVIJicX5bvtkoe6uai7vHpl0M0PhOtGIvPm2iTkLllC+x6gbn6xtqKkisYMEAha0hcd9JvV02GgW4P+tGI/6FWInR3LyLw2qYVIEmk3DdnZsDoikHM91z1Fwespal4Vzaz3cT+7SrBuWsN+cK630lhOlVLygscwvx6fC3Vyqu6/vSLDzOUwUUuOZ6+kh1fM+nixxbc77PFX6iGrJyaf6438UrOrVWni1nKZrSQrSOUDuWT8DQtGFKovLqYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by SI2PR06MB4394.apcprd06.prod.outlook.com (2603:1096:4:15b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 09:45:51 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6433.018; Tue, 30 May 2023
 09:45:51 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>, Lu Hongfei <luhongfei@vivo.com>,
        Sun Ke <sunke32@huawei.com>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)),
        linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH] media: Fix resource leaks in for_each_child_of_node() loops
Date:   Tue, 30 May 2023 17:45:34 +0800
Message-Id: <20230530094541.23396-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:404:42::27) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|SI2PR06MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: 5709294f-cdf5-4ce6-a408-08db60f2a74d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //oidyZ/t2XD3aaU7F9AqYYA4eqkJbnZPI9rsXub1d/uu2Zm2GdlBsaZZ9aiVb5tMv2aXEARyp4rCqOxjWK2HXwgjh4DPXT+RVDVJHHD9wksrSbDj3v3f4hGD9n7Inmt0m8jtJ7Jw5tc8JU9YmpXVMsRaoLJqZz+viGBaxt8mOCHnUWd0N6wxN+daoe98saPBwarxBZGJR6Le8ty5N2TOlrVsDlMv+Cqi5Aq+0skpYOoiwAobMEgfJMpDSSaYM0ZOyIjjAlo3H89j50C/G1+qbWQAUENwx7Rwat8o7qf6DNVTVNJ20tYlHZU2Db/6tE76tuS8lJNcDYhAoUWTJs/anlYo0AIus/Abs0VapfVoWbVLCWZH8wHVFG+I0bOzMQpisIhlm0gv50i3j0owLIJJYoaQ8XvTu3t0vUZX1lTtwcf2MhfNWFAl3EDPuyLJb5Tx4alQQ/vfEuOqGbRZe9EEdNTUSoZ8niYUkWGyRPKwRiEv//9c43KYKAw/o7PYIrO9Jfi5bh6+U1Q3olQTG4et2LNDMzBMzvxmgfxFm+lyf7RlngcTIvjIt4mh5Lfk4iX9yUmCBEd+dz58AhCR/G2XMUD18f83fHeSx2WZ6rGazhPsfbMg5tV6Vu4vhYdRr5I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(26005)(1076003)(107886003)(38100700002)(41300700001)(38350700002)(6486002)(6666004)(52116002)(186003)(6506007)(2616005)(6512007)(478600001)(110136005)(4326008)(66556008)(66946007)(921005)(66476007)(316002)(5660300002)(8676002)(8936002)(7416002)(86362001)(4744005)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y19Pa7yWFBVAxHLb1GrUBAbf6Y+FIdr3/Hs3W7s/Twds2i7ge9JlPJ5lgPgc?=
 =?us-ascii?Q?f+y9KNcsmdH8BaTIYvW67F+Xvoh2oyRzBYpXcemqKkh7eSo+RtkkIBXkT4+/?=
 =?us-ascii?Q?3UNcvKQQ8RWpFcBUMQ4n4ZVuEj2pKzUuK0/frTNv8i81FsRVScOR9CpbPZ0M?=
 =?us-ascii?Q?m8uOsMP8Z7yH0rEA6+o9u6HE84pbBtoi0Eh5mMG/niN8gUwT+U3mXKIP16bK?=
 =?us-ascii?Q?gv9dOHDnhY0O9heduM3UzJFwmhtIlXAC+e4sLjJCmulpFMaHraq/4uzFQPhw?=
 =?us-ascii?Q?BVYgPqmmAWmFpwt/7DQhhHW/PJ0PUbOYziB1eiU52G6uC9qRTlD5lyG4aJvp?=
 =?us-ascii?Q?KNMeUGY9BwIlOWzcN9CE36jufP40Bb46d/Zqj675Ja4/0aCOQWARydQfCKh5?=
 =?us-ascii?Q?MrPxn41SWFcEKdmsYGw1GNSSLr7a6S8s7qU6y5HxXhd2BpGHcmEPKsFD3SgZ?=
 =?us-ascii?Q?IEvpMG27EDYpllgbumk+dCvrU03M3A6otytZPGSLpLAubyqAm7LgZPkL9dHS?=
 =?us-ascii?Q?BQF4HQFd8pZAc00KLgtweQ0m9nvkYfCiLbnX9vh9hCy55JOIJE5r5oXDdBxO?=
 =?us-ascii?Q?+spHbGgmoxYh/tVUc3e6Vfkxt1b5ugt9LP1Yp1Lk7K8ZghDKRuxPMTY4j5op?=
 =?us-ascii?Q?p4vyn5WlJR3ofSzs55emPsaKh86qfZA6gIMz3gYgD3uqPirLHkBcWNPJtfiO?=
 =?us-ascii?Q?sPog/A7kgDhDKWaiyqaHN3EUFZ0z4Z9r4FeRPpkpVqvDOX4HbpFGvs83OyEi?=
 =?us-ascii?Q?U64MrHWs1uwjFmZF532FAsvoOm5qvhSLaPOdV8hn9cpZdyJd4RHUjCboaKh0?=
 =?us-ascii?Q?04xhQwn7V+1ZVYh1fUoMQYFJj79iyKbzaDuEEGW/uzb0ZBgorMVDyS8En3ji?=
 =?us-ascii?Q?jV+ZeASYkwilV2axMUOYdv3SByp7hVnkeiqq2EtqcFTa7frrxWLOTqyGzF/I?=
 =?us-ascii?Q?K+D2Db1YrsRRUCcDwdwooADNIXOF2Obo0QgkXKAG80kGQO2xnXWIfq441Hyo?=
 =?us-ascii?Q?bFWKQTAWGhB5fdiSPe5qmt3ZBwuoyS85RAmzSlatv9hQA1tEoEma7P2lEnke?=
 =?us-ascii?Q?/K37TK3pvIARiFc4ba34y0BnyfAOMf6mv91loVBuL++aWshyhs6skaMGtWQG?=
 =?us-ascii?Q?ppvJFCa3qy52GJDmLkrYOS0wGUpDid4JXM8zNyWsBvmAyzdaJflzPB2iL4xE?=
 =?us-ascii?Q?w5Bkn0s4n+EQPY1u5xJaliHmAslLvrzIztF4bybASw+tF6cVTIGkYCowuSCH?=
 =?us-ascii?Q?IBbtwhzq/OSpLrRpba4iCqslnzuATohfJUO/gIDn7Y1EWJ+tX7mTmyYIhVlQ?=
 =?us-ascii?Q?HdQebETML6rSU8QTqsfblJjjB29sGvppwlyBQbevtj5mKgq1CJ+BdeQLehuC?=
 =?us-ascii?Q?n/WxnnTBkmAf1P3M0vLWVvyemLWDd7MijN15xeibHmAG5yy15ih2+x3LkT4C?=
 =?us-ascii?Q?WZCUo7KohghiinfWbNc9PabhDgDBbCGDySKBuTrTjj3Y9O4QRVEO4+fOoRtm?=
 =?us-ascii?Q?XcNZO7cMI+T31635KwJ9mgfUb/lh9hKfm57XXh+3VDqDadNFnfvPSlQM9wxS?=
 =?us-ascii?Q?Tq7/rJAZi+7jLcG2ULVZBz8r+G2LHuv7a5g10NWZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5709294f-cdf5-4ce6-a408-08db60f2a74d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 09:45:51.0730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emFrmuSny5RNCjFkKRaoXITCu15tIskva+gyN7/3/6L0N/VCkUBixW5UpmOiX2GYer7kiKv4nnTsZCJivCjTbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4394
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

for_each_child_of_node should have of_node_put() avoid resource leaks.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c | 3 +++
 1 file changed, 3 insertions(+)
 mode change 100644 => 100755 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
index 19a4a085f73a..5a6a61d68cba
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
@@ -1128,6 +1128,7 @@ int mdp_comp_config(struct mdp_dev *mdp)
 		comp = mdp_comp_create(mdp, node, id);
 		if (IS_ERR(comp)) {
 			ret = PTR_ERR(comp);
+			of_node_put(node);
 			goto err_init_comps;
 		}
 
@@ -1137,6 +1138,8 @@ int mdp_comp_config(struct mdp_dev *mdp)
 		pm_runtime_enable(comp->comp_dev);
 	}
 
+	of_node_put(node);
+
 	ret = mdp_comp_sub_create(mdp);
 	if (ret)
 		goto err_init_comps;
-- 
2.39.0

