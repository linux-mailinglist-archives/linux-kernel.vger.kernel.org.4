Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14738737952
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 04:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjFUCph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 22:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjFUCpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 22:45:35 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2129.outbound.protection.outlook.com [40.107.255.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC5E10F1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:45:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSUiAsPQ2T7YgkwrZdPLf8TR+fgVFlGrFoH96O1eF7erjjzDJRu3C36xrisxnkprGleUjeNz5wVkt+ibClBT9DywxwLtpt1h5RCapu2gtptFYdVyp71hdZOA5ReCUSundUlUBDTN9Nrm7t9EGgQXuyw+Xw+Z+azyC3EK0eH52i5l60h/Bt3Dotj/aQzJx90nHdQT3KHSNNHjDdL4CvqOWqQ+JbY78fAng02j8Z2J4r26SodpBLJmt6CYUQ1djDHw7tLLJGGN97q7LtUPV2LrbUd0ousT/Qdgw+MeP4Vi8M5HgFRml/FV6IYtv2uzj/7150HDRQxSnyd3NRhjCefCNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWppc2odrHs1l3f5HcSeU+ZsQ2BBS/KFEI+FnbPD0zg=;
 b=F89I9Ln3seLHLqoT1Wl//vZc7s2QlDSiSPz9Ycri5nODoeF9W0+224qBU119WQeK1flb8jyRN50UeRxbBMIEzoobu6+Eov5m+K85+2Hb30PSPOYkZ0491I3carv0avMOh9Ko/bjDUH6e5giNw9f/pYsJEDQsBLclaEH0phjLCKJWqjePjNGNfjvoFCOQWy0XZqStWR3ODkAK5J3HllqEBli8PpNaPzUZhGuqkvpxWDj09BSsPIGevCjAgZb6TeBT5KaFk04U4H2ZFOGTgXMpZBm5Aazo/3af9gKt74jhd6UMIT8TL3lSgktgIxjXBxBfF9zOraMA9aXxUeP3d26btg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWppc2odrHs1l3f5HcSeU+ZsQ2BBS/KFEI+FnbPD0zg=;
 b=id6UcUbFKhhueQR9IR0TujmTchZN+b2sDLCk8s1MO7nAnLgJxI6hpMX2eMiOromT8+X2B+K/hey+JUH3FJIrbGYwHHRoMjN6YeOI1OenvatfYvvakizlASmOlG5rLvCUQ9Km5l8KKUaDYyyoxTSZnzpCqLMwr5Ww5xf9/o9GGkBlxj3lVKKEhmwk5Sk0bVWPtACLeAQW5Q8xdbded5n/lhOiTbvc/DUGiHSJl8rXn+IdQmTBeMBUiaAj9sW2nnLk9cTj/AtKBUUQ7stxAAha3wRycUl4yb/oi2op98ylNAGBPdJ+MjZNSL1m8H4G+6jEhkOHVVn6dnfyM4hFrDs9fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB6615.apcprd06.prod.outlook.com (2603:1096:101:172::11)
 by TYZPR06MB6168.apcprd06.prod.outlook.com (2603:1096:400:335::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 02:45:29 +0000
Received: from SEYPR06MB6615.apcprd06.prod.outlook.com
 ([fe80::c817:d237:dc0d:576]) by SEYPR06MB6615.apcprd06.prod.outlook.com
 ([fe80::c817:d237:dc0d:576%4]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 02:45:29 +0000
From:   Yang Rong <yangrong@vivo.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org (open list:MEMORY TECHNOLOGY DEVICES
        (MTD)), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com,
        Yang Rong <yangrong@vivo.com>
Subject: [PATCH] drivers: mtd: Fix potential memory leak in mtd_check_of_node
Date:   Wed, 21 Jun 2023 10:43:22 +0800
Message-ID: <20230621024517.1155-1-yangrong@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SG2PR03CA0131.apcprd03.prod.outlook.com
 (2603:1096:4:91::35) To SEYPR06MB6615.apcprd06.prod.outlook.com
 (2603:1096:101:172::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6615:EE_|TYZPR06MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: 157d7d07-88f3-482a-b94f-08db720192ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: swE8vRY+x8uumMPXEIOtEkkzL0qcdU5yZrRyiRYaRTxKu5RuQQl4kURs0ypB0Eid2EuC5CM1smOPBsL71F1iQa4siXkxyM9xDnrcxoSQ5a278ogRlHMzniAietAqpKcKSNIQxYdwQ01UOeix+1qEq0pvY+XzJlmGFcRK88RHeI5feWNH0aa7xwPESkK5/OhgDnaoJ7iusfEgbyRKTJdibzgmM7aVMN0WshkQg51TngQEktkTbCsU7LW8nWdAqnxaU519L1RPMdmf8XRZf7fjoxzIPe/z7dB9RV/rrVIB0DFbN0NK+msA3/EuVag+gSI4GusINsvzOomHkEXL7YosFzan9hdaHW8WMOvI2fllWU5nYaY2m4A2tNSwKMm9Yd4xDfWWX/5IQeKDTkHBTrdM8DEsyzIsW+h9FwwJDV0DJxD1QufRZKtfV6bcLnE8M9nHcFehUzB48STi3jzAU6ksArOBCyJga3FNw/E8CepVHepP+bJatJ9LC+FwaZKQBZpxFv/4IaW4mrqnXyJa0/APpuwU3ZbAq6NowqdAp6HHvEenFo9i04vN663bp/Z8q3FlumbtWfL9RlzrU8DFCHFLPNRMhniGWrTUKdfKd6GIA2iwZyXjOn4PwxE/kENU6Xq7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6615.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(38350700002)(1076003)(6506007)(26005)(6512007)(2616005)(83380400001)(186003)(5660300002)(8676002)(2906002)(107886003)(36756003)(41300700001)(6666004)(6486002)(478600001)(52116002)(66556008)(66476007)(4326008)(66946007)(110136005)(316002)(86362001)(8936002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xpJfWcfLCZYfy8FbmkyE9YRzOod9V/5P1Dfem1yyI3X/hvj1AJILa3hsolRw?=
 =?us-ascii?Q?O2nsbhMcTrSyphxHmNNzXo2tHWPXPzmQZXrzYHZVeK6oOGLyioUxsAgARwme?=
 =?us-ascii?Q?VaZSIywlFCFgE6uL9H1diy08ajPr+JIqbPFTn8sjgoZPhPJyuDjdLjFBoqw6?=
 =?us-ascii?Q?gBowAnAsuui30EUq2a12aCVwGC4wfn/AAlg2nJB2zMGs8X0EheW4h7MVwpWm?=
 =?us-ascii?Q?bOX8rvMNAWbB0vBGO5UWnFTUIE9SuR+hh0t85DXbu4rbHfP9B9OLwuGMy/GS?=
 =?us-ascii?Q?/W5zcpk6vuLrQ4fKdP9yP6DxRtCNW7Hu0gIPMlLWPn5oTQZDgmm8v7BBKXqr?=
 =?us-ascii?Q?JLQcdAqiEJfHPaR/E54Mw5Hqa3kbIvoxSbp8myLVxI4TKQhAr8iAEiLgAuE4?=
 =?us-ascii?Q?tfak9FJ3RzI1kB9PCLe6qlsavJHn6WWfpSg11MBWzYb6HDYulngR9q1dd6sa?=
 =?us-ascii?Q?veYW8E5Df/o9HgrmBMuqELSzNX2Ds3OH1sbbhStMd0wkYmMI/0IT4nTW5Y8Y?=
 =?us-ascii?Q?PQRKFugq3165MXalusNlo2pPmV2B/lfFGAMRKNkMExp3jwnMKgtxMlTbqCVf?=
 =?us-ascii?Q?UoTwPXOA0l4P+YzkaknmjPQSpfU4eLDu64rq5aZruoJrmPNHBpncCLd7STqt?=
 =?us-ascii?Q?SwePrtGqOQubtObfVlvituG7N08UFzS+rePEwNqC2Q+u/AX58MQTIEuK+qaY?=
 =?us-ascii?Q?EzbjHiJFuhg+PkWUbVCJXFx0FytlHEru4KjFEH/yX3g7b7VSnz6GJrQtM69W?=
 =?us-ascii?Q?Zvf3OL6Y69qVBroU0lAxAMdQXO4MgrTtoanw56EXyf8wGVAGoZ5PAXOFkqT9?=
 =?us-ascii?Q?jgQ0Q/z5Bcm23sBfgcxaaZXLnCDQWN4zyIduWb/fyZ2aw++mWy+KBU0Yl/g0?=
 =?us-ascii?Q?sjHkJ9+1JrKonq/Vb7/85nuJSHq9evowVf53wYSc6Ts7yKA/nDfG3Ti7Op81?=
 =?us-ascii?Q?NnXDc8uMUdsXFNrvV0Tc/+KGz13OD+x+lChI0qQmHyzdi5HYTmc7U/0lFmbY?=
 =?us-ascii?Q?ezu6Kee5bXV2Odm6YunhVv+sewLeaapxcQCQiOjiNHP7sRJMzRKeaq3Hc0Y3?=
 =?us-ascii?Q?y+22VDHDxPI38Sv/jUY9zK5Up/PUc5+ziB5F2PgFmWot6XxgAwoK9Sy3wAVo?=
 =?us-ascii?Q?D8izd6XJopK7h/0hURPHbzf/795bwgGKt5nd2FluX/KwFTRG+/sFdYm80Ybu?=
 =?us-ascii?Q?+XkKL01IeITQC7MNY4vsZOhvaBcL18OIx4pPqtFpKZv7GBPJ5EymxAenluxh?=
 =?us-ascii?Q?ziuqb17O/tdI1jVO57VuBE+gyeIsTfCUqy6JL/ToVdebQD+dWD706K3ECDdH?=
 =?us-ascii?Q?652odH6HvX9oxUpgjag1femE1XrELe7ShhZS+L1hGnxbYgPtA4qdVYdS0UA1?=
 =?us-ascii?Q?hpIHk2BfyzddGmSRlTbgWOCiCUti24XOuUDPjENIOMt4sQDGiYjKniPh8gBO?=
 =?us-ascii?Q?WvhP96uJ/0fEQg2Kuy4uM5mivol9NgliZXfFlNJYuYXFYW5DEy3JvzucG7uF?=
 =?us-ascii?Q?DC4ZXKt0JhMMxT3FMCjzphqEo4a+hUHJ+wCjAXrWpfoBUEBInZ/jiConCPyo?=
 =?us-ascii?Q?3A1nnW5KrN3Y20KEKEc9N4YfAXs3niypTUZ4DN0/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157d7d07-88f3-482a-b94f-08db720192ee
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6615.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 02:45:29.2608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ar313aw6M+P6zTW2hIVHO4RMAClu7fJ3IukmwKPCv9774zr46t+QtratLiJPd65dmshJ6klTuPoBp7jM2W04mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The for_each_child_of_node API internally increases the reference count
for each child node traversed. If a break statement is encountered inside
the loop, it leaves one reference unbalanced leading to a memory leak.

The function mtd_check_of_node in drivers/mtd/mtdcore.c uses such a loop
and a break statement without a corresponding of_node_put.

This patch fixes the potential memory leak by adding a call to
of_node_put before the break statement inside the for_each_child_of_node
loop in the function mtd_check_of_node.

Signed-off-by: Yang Rong <yangrong@vivo.com>
---
 drivers/mtd/mtdcore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index e00b12aa5ec9..b02cb8b1a38d 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -591,6 +591,7 @@ static void mtd_check_of_node(struct mtd_info *mtd)
                if (plen =3D=3D mtd_name_len &&
                    !strncmp(mtd->name, pname + offset, plen)) {
                        mtd_set_of_node(mtd, mtd_dn);
+                       of_node_put(mtd_dn);
                        break;
                }
        }
--
2.35.3


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
