Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2543073B1DB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjFWHl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjFWHlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:41:44 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2043.outbound.protection.outlook.com [40.107.247.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B031BFE;
        Fri, 23 Jun 2023 00:41:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EC0HhLxt6BIKlTpWnswD034HvLKYxZvHUrXrOBrHl2HgcW23Fyb1lxw6ga/1/ve7gqoQiL4MHa7CcRe4k5oPk5MmyQu4lsICu7oHo3c8IIyarHt+idCOp5W6NQjOznim5OuHPGcaABBr43//eSK5WlHk6J1TnTyJOqcSTAqS2bXaMuTeNVncaimZ7GHVpsCe9YPbqTM1U4LWbA7dO/gS/cFpVQJcSD76ZALjUcZdU/Zw1Vg4J/NpryhRGv8GxqJeVYBpwSzmtvlNaLTzJxt3VH7ZpfyH7er07XmxQATcrk+R7xOyU6D29cxtBOmQK0am0G3tSv5hN4+cOwI1SarAaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xM3VD/JzAjR09HetniSsmnZ4UTXCZGwbFG0bsz6yjdg=;
 b=eBR5XW4aB1LwaYiv9zJupyfMtutagiUu4i045GpTE5XaAUd73EzNmr1c9zsJMnW00l0HRS4V1Pip0yO6BySr8KZtm+VsraKqkp85RXMvk5SHBezdDFwKQSKeYJ9+iC2i+HXtpEq2aSV0MaJqhQI1QGJBhVDAhJwh5woYEI6KUGJbG6chm1ULnlk7ocZMAGQBuJioaX8yQz08X8LUxboZ0q325Ub/b0jCbfcyCtbBimJBxvAiTRlyOowVpDCzPtM9IEMrY5dUbRAMWD0vsKUT+qXg2cQhYTvyG/UxBYfpcT/xb0ocAGtGhjkgu6cSn8yLrrBEZ2Kl9eYqm8BebwKw1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xM3VD/JzAjR09HetniSsmnZ4UTXCZGwbFG0bsz6yjdg=;
 b=bhh2b1I1Inkq7OVF39vhMEogna7fXMyhx6Vq5KKEAZfpVH7Cj+MyTLuOw5b0ikKYrYGA9uZdr+H0VT/lwl6x34Wf0j8cWoy2MrfO06EvS1Mz/budiw/EOJG8cEPMgG8DSmDakj5EVPNPwX2NXon2fh+uXO5tdMHHosvM9wVe3OI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS8PR04MB7557.eurprd04.prod.outlook.com (2603:10a6:20b:294::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 07:41:40 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 07:41:40 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH v2 03/13] net: phy: nxp-c45-tja11xx: add *_reg_field functions
Date:   Fri, 23 Jun 2023 10:41:13 +0300
Message-Id: <20230623074123.152931-4-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623074123.152931-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230623074123.152931-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0502CA0011.eurprd05.prod.outlook.com
 (2603:10a6:803:1::24) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AS8PR04MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a02986-e4cb-49a4-92da-08db73bd4873
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: laDZpGPHm7PlUbOF/pClvhWS4rGqEDbaEJGkaoDKOaRuwGYd3qtC4uFXiUOP3QQ/DNm4GxqG864iVbIu/+9OdnAEy/DWWT+uAsUKrJnnbqOxCq3z2Kd3RAe4RH4bRweOPZOWxkJgmjsnqfwO9vpj9igCDOEFsGvS/pskJMYmuYbU0MIIU+BI6Yz4RXUBw4X6z8vespg4WgQjF7UVp8ZF0sS2UJ8algtbSa1oBHT1hz6rOrjrenTOsiQ0xEiX4ZeWSrkZQWNs1TAAT9i50VEjrEim+3TToHeWI27VLzGZYTTRiFst+9hF1ZDpt7Vb7t0F+jmFtQAkBXPLLy4HMqTsqpoZL7XuKf/UgySbC50tqFVVubQneG0YmbckoLt/3fHPTu/0GTkT5NTxyJcX1950mTPuHynJdddOe9olMOvySyteOxrQFbF4RoS/UfauxyylVTdkplZRRCsKChgcTDYAFJLgnPGoGYUPhMm21Ykyt9/bxGXuPKz9mDa8bRfVo3Bm6LXoGGS4n2upXe2WH01lfJ1wfGwTLDdmCwlKDo6jGWzd5hRKDqLsZxgyD2Hs00hDMovfz+h3fFrp0w9UOzW7ui57/W0dUEer+9WxyBIK33IA/zt8r9TkkN2q5DcZXkG0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(41300700001)(8676002)(316002)(8936002)(6486002)(52116002)(66556008)(66946007)(4326008)(66476007)(86362001)(6666004)(478600001)(186003)(26005)(6512007)(6506007)(1076003)(2616005)(5660300002)(2906002)(7416002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cihZyxbp3ECqWGKZ1acN1fw75Y2ug+Iee0kSpUHj8MQoF5PDAngdSeN0GEXk?=
 =?us-ascii?Q?f0q9YXO6u+vHyQXXhBoGp5Ep+CPhlpPoSH0xG1aOjpUSgKVg5mHl2AxyeZSy?=
 =?us-ascii?Q?C37jDp4WWWpfrwo1KY0V4Yg3F+x1y81iCHUPzMW6+DbpmDiyThfL3Whzngu5?=
 =?us-ascii?Q?psnGmpdX10O1GJgIiI/4LrM9FwpRs1OPUpHWBii8s6Np0I+F0tRQz6mxgZH7?=
 =?us-ascii?Q?6bQ6Ufu+lkeGiBAm2KFRf8gvVDw6a5iEL8hGqEHRKq2X+lRXFJmRArHSkkOA?=
 =?us-ascii?Q?pdGZvJpl+hGBwBz61Ddf21mb4snCFFJ+K6pg2NgNhbyaX9MWdL0pTYTijol5?=
 =?us-ascii?Q?CoVuSO6F1+o1AmAf7U7gtpM8CPz4pcunHTbWHBzHnSWqIDnU4nCKn946+ScF?=
 =?us-ascii?Q?el4FT40LBTNL5vKNGsyFjpTdDiaeuxnsb3n04hwHi+xcNtn+7ClcewJvk9z4?=
 =?us-ascii?Q?/CRdo72uHvUFcYRbt3NYEq8/g+ZVODwGPg40KB6+z8f3y3auVOOc5swdaXKd?=
 =?us-ascii?Q?JOAjDrfr/gidYAh5540oowSHVeS0S4BEK4TiFcLzUGFpQEelmb674rfXdq5l?=
 =?us-ascii?Q?QwfApvFdV0aXBS9fy/6VHvzs4oHe4rMtrQ6h4gfOVIvzKvJJzb4VypJ8sAH8?=
 =?us-ascii?Q?wMnZoH6ysnTNzXCL6aYcyYOld+puG1+uIihGuXqNjUX5DHopqefJlEherPjg?=
 =?us-ascii?Q?l/PHrIzoA8qEyNNamZ2AUS3nUYbSZ9c0mjVtqrIE8wTo8oAb1kXR+0qUYhKg?=
 =?us-ascii?Q?y6Dg5CFcdBcrDHG5lOzeQd1lOgEZ3scplSCwpxfkfni9RfEQUhg91JYAD85g?=
 =?us-ascii?Q?s2y6MIGk0/1YRzy5ngjZ/qA12xJtpr31OsSdF3HUYd3ZgRilaICzM7K6Akey?=
 =?us-ascii?Q?mw+RwPktjW9uR5XWxYmwijs4YaXD/LeALIaNGvZdvttiU+b4A4v2bB8ZKnVN?=
 =?us-ascii?Q?aQgv1FRYJaVzYahih58cpILepAe7VYyt6Yu62SbwxanFLlX7mDOFdCuqiwFj?=
 =?us-ascii?Q?NWbTY5r43t7vB274FfkyIxM/GHwM+q0bynwjG1vMwp/G3Ul9J56zgZgUApBV?=
 =?us-ascii?Q?Hh0UvgwQkd+uoBu5pZBNsxS68+AOTuUVTlkV1ChTAwYqSSbOnyC7V3bbaABp?=
 =?us-ascii?Q?WivjJpZMqMkVdyQAMTv1cZ/IvgO6kRPnPjIrTvzsG65GCkiT8Dx2glfu0+8A?=
 =?us-ascii?Q?0QwiBIMtXHbzVIXmYLxXumWPWuhZJeLUH06Ao2RbmFwQEuNqIHA6ZxNAN6ke?=
 =?us-ascii?Q?Lz8zzLCejIXjcajDFnLi/+k8JsleWQQZUk8fHtcqRQ5c64fMAGZ7YaCoSDHO?=
 =?us-ascii?Q?NcNZVPeRM/St99PXMx5dnvfs9f2pbsO9SYNtM4TlRSV84vavlz3j67ftDExY?=
 =?us-ascii?Q?+7g3gr79MizZqUqn8/csP9XBCRkYzMXae9uhCv3Y7ipi+J/zepJeSHSRpk3T?=
 =?us-ascii?Q?weboVneg/CLOyiYoRWDiNP5nNLnswTs3hGfkaag7TSyrIqRNWpKm4aO1IAJX?=
 =?us-ascii?Q?AykWcoVe8yFeij+FjJRYHr0Pue+VqerQ64fmFt+4cFQUMqeIZFhuNhF3Qy3R?=
 =?us-ascii?Q?eJGM9RSlwBXf4evECW2JL69xN1TiLoDJdNr2wiQXmroipx9DDGabrInQdT0K?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a02986-e4cb-49a4-92da-08db73bd4873
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:41:40.6637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOHEj7pxmTd/9Dzzl3fkqBMaFqqT0GDjtEbayDvq7PjN7tYI5AaAQ/uBVy6D9I5NrudJCBbbfVHmISKFH7azlGgmxFi5H+GvPXcXt/if8xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7557
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Between TJA1120 and TJA1103 the hardware was improved, but some register
addresses were changed and some bit fields were moved from one register
to another.

To integrate more PHYs in the same driver with the same register fields,
but these register fields located in different registers at
different offsets, I introduced the nxp_c45_reg_field structure.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 82 +++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index f1f15a1b6cfc..2664b3bfcb35 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -191,6 +191,21 @@ struct nxp_c45_skb_cb {
 	unsigned int type;
 };
 
+#define NXP_C45_REG_FIELD(_reg, _devad, _offset, _size)	\
+	((struct nxp_c45_reg_field) {			\
+		.reg = _reg,				\
+		.devad =  _devad,			\
+		.offset = _offset,			\
+		.size = _size,				\
+	})
+
+struct nxp_c45_reg_field {
+	u16 reg;
+	u8 devad;
+	u8 offset;
+	u8 size;
+};
+
 struct nxp_c45_hwts {
 	u32	nsec;
 	u32	sec;
@@ -225,6 +240,73 @@ struct nxp_c45_phy_stats {
 	u16		mask;
 };
 
+static int nxp_c45_read_reg_field(struct phy_device *phydev,
+				  const struct nxp_c45_reg_field *reg_field)
+{
+	u16 mask;
+	int ret;
+
+	if (reg_field->size == 0) {
+		phydev_err(phydev, "Trying to read a reg field of size 0.\n");
+		return -EINVAL;
+	}
+
+	ret = phy_read_mmd(phydev, reg_field->devad, reg_field->reg);
+	if (ret < 0)
+		return ret;
+
+	mask = reg_field->size == 1 ? BIT(reg_field->offset) :
+		GENMASK(reg_field->offset + reg_field->size - 1,
+			reg_field->offset);
+	ret &= mask;
+	ret >>= reg_field->offset;
+
+	return ret;
+}
+
+static int nxp_c45_write_reg_field(struct phy_device *phydev,
+				   const struct nxp_c45_reg_field *reg_field,
+				   u16 val)
+{
+	u16 mask;
+	u16 set;
+
+	if (reg_field->size == 0) {
+		phydev_err(phydev, "Trying to write a reg field of size 0.\n");
+		return -EINVAL;
+	}
+
+	mask = reg_field->size == 1 ? BIT(reg_field->offset) :
+		GENMASK(reg_field->offset + reg_field->size - 1,
+			reg_field->offset);
+	set = val << reg_field->offset;
+
+	return phy_modify_mmd_changed(phydev, reg_field->devad,
+				      reg_field->reg, mask, set);
+}
+
+static int nxp_c45_set_reg_field(struct phy_device *phydev,
+				 const struct nxp_c45_reg_field *reg_field)
+{
+	if (reg_field->size != 1) {
+		phydev_err(phydev, "Trying to set a reg field of size different than 1.\n");
+		return -EINVAL;
+	}
+
+	return nxp_c45_write_reg_field(phydev, reg_field, 1);
+}
+
+static int nxp_c45_clear_reg_field(struct phy_device *phydev,
+				   const struct nxp_c45_reg_field *reg_field)
+{
+	if (reg_field->size != 1) {
+		phydev_err(phydev, "Trying to set a reg field of size different than 1.\n");
+		return -EINVAL;
+	}
+
+	return nxp_c45_write_reg_field(phydev, reg_field, 0);
+}
+
 static bool nxp_c45_poll_txts(struct phy_device *phydev)
 {
 	return phydev->irq <= 0;
-- 
2.34.1

