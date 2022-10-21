Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222F2607F3E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiJUTrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiJUTrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:47:12 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2133.outbound.protection.outlook.com [40.107.103.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B53297F3E;
        Fri, 21 Oct 2022 12:47:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYxpxBRdD6oIAgbxHjWMjZxAUf6H/l9a12v1fUOluumQr8FHElE9xOBlR49QHgwj1ey9IBERzDu2piFWa345kWQAbytAsjH+O38BYZMZG830f7VHllELRI9TazLuIOT/rDw2tIrjY8yw7gKTcQkff8isdy/pxYv4dfMxQunPf7zqe5yOpODYfNECr8lNymNIZC+/p+iwAzXN7EInad2JNTb3zbtZKeUTqn49Dc28CBmLrfPmnF3cpSpS2isZK4STNU2po0vADXQj8pJOEmTCXMUKml0HssuDJZMZiJPxrytsppuixaJPf5bApRnGTa+jE+2qp645+jM/5d875KVO0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHdv5NXR43TniTBpPHmFPe/OtynXFsea5ZA00JrRFLE=;
 b=Y4jwN7BQRCBVP3O2SM5o8fBI1MPEApgmZGCNhnGytiSqBWDRJaNZq8AjNx7P+W+zbjZrgAvmd46Sq1zL1NSJLpkSpnzDLHG7UysFTXd0xEniW69gYSOoiuwAHArTsbZWWGBM/uT2VcM5WLrbDAYmp7M06+wOGvpjl//92kfRg0T48SmjyUHMbhuvsn5m2RWkCOMoq8fRcSSplclGCRl7gjRqwu4aHZQW6maHQk6I4GIo1/J5O5CR28WTxkz9mQfpJRQIj1NKK8tJK/gzX1wJc7Q2GYUvPYpU9tyq/sPuvyhvgvCmULK9eY1a3c6aVT6mIJXtYB9tT2+saUpYxLcBcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHdv5NXR43TniTBpPHmFPe/OtynXFsea5ZA00JrRFLE=;
 b=DqDV4CBIes8v9LJpKy9CCRdZA3F+9MeDeVISobWpmLJP361o+BzcfLeYTbNkxjpDg9xOfHDey1jAG8OKoXO2PH6bQKdtAvI9aG6fVam/fU+269GzVcBMZNBpjneu2N2m99X2GI41Sg8MlFDm+dz74RXEL27fWuVRZsJnn4SoU8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by PAXP190MB1719.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:281::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Fri, 21 Oct
 2022 19:47:07 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::a621:b61f:de56:b8]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::a621:b61f:de56:b8%7]) with mapi id 15.20.5746.021; Fri, 21 Oct 2022
 19:47:07 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH 0/2] dt-bindings: mtd: marvell-nand: Add YAML scheme
Date:   Fri, 21 Oct 2022 22:45:48 +0300
Message-Id: <20221021194552.683-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::14) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|PAXP190MB1719:EE_
X-MS-Office365-Filtering-Correlation-Id: 965b579a-f3a3-4f69-7359-08dab39d0910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: le9OLJdg9PyrD/RBd/jV2lDmXRKh5Q0lIvgp7UJeoqsgRGJ+rA43jutBmBu23JoFynrq46bcH+PwTYMm7+sZnmW0ScUhATBDQz64Upi/S8Gv5kddqPqBgQdiSQvScVSUkctuMHhLQuXQQEnDH7njftWLE0MuEsk3zeS5FXUh+BwmeVvFcQPa7y+GyDoxTIlwdMrkCaHA2Swv8DtLedI36Ob4KnGYgxuqo987+Ty2v9+/lKBaA5xYZef6o7OC9JYGTqpT6sKZybl1K3n0Rj/51nILeMU0gnkrZQ+IAGrT8x2wCr1w2eqw+npZ6GsYhS6JiP3b2QLbQM9gHt+UF8Tu+ajwUs2vb2PzpSRpzAhAm0cOiZmguw/u+1vmHGK/lF4XNLkr4NwdfiQJRTv0NsiRJtcHuRYaIJkXOlsf1f0DEaZJ6hlW2z+HzWOjzI9TaIgbHxrtIM2Pwn8wuRUQFkN16Dh1uyJBiqNTD+4Xdg+rdhYRmffwAUuQMuUHpm+BNxB8bmidNv2Qe1JEKhEctN4nPwoZVZ9xeC2L+cTMU2/xtdByzmeCC19GGez2WVZH90SmMBG0sOBZ94Fr2S8WYbebXI/ekENwmZ/h61oL2fTmFmAYNY+nqeaiQfE5wReiHZ58Vv6f72sH5GQROAuWmu6mS090WAG1KnoIHcB9i5eJxB5n6lve66nvoBSSK9+reDLD0bMPauux6U5j3DfQuWy4qJhJwp06+tWm2VQ1YucYhjmyeQpO2DYOiWN0pPPE2mv4h6V9NlkTzG9mvMSqk+Yolg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(34036004)(39830400003)(396003)(376002)(366004)(136003)(346002)(451199015)(5660300002)(186003)(8676002)(2906002)(26005)(4326008)(921005)(86362001)(2616005)(508600001)(66556008)(38100700002)(36756003)(110136005)(66476007)(6512007)(38350700002)(107886003)(6666004)(66946007)(54906003)(83380400001)(41300700001)(316002)(8936002)(41320700001)(44832011)(1076003)(4744005)(6506007)(6486002)(7416002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SewVEwqAZ3CMUqDcuivkfkORoMWQFc9eZkxWfx/80szewm0SWJJFAFlQ7T0C?=
 =?us-ascii?Q?HT67xjdPzOLVzBenS+c0g2Txqn/mY/L5CmJURRN8ETR+3Hwd6ogCne13iXq2?=
 =?us-ascii?Q?0l7v7cZbHG26eXZTQAuspPtMEeQgJHivwgMTKrr1ZKQ9mpqOg8IhZLxxCyRQ?=
 =?us-ascii?Q?kphBl2FpUGsA8pn4855P/HLTiwNcJa6aUaQPCep8U7eLQPQ0JFIDwR3RusJT?=
 =?us-ascii?Q?pWxNxl5S1NKoBf07l274t39ooUBXJ8VELXPsTt1AyXZQE3O4BvYvXC9tLngX?=
 =?us-ascii?Q?vDENk3+Hv07enp8zgUmuRDAJ9rRnScTBnsrPRhYKn+T/2ii8EJxCCSMjy49O?=
 =?us-ascii?Q?NrmXygVvkkLj2DvmjlImc/pO6q7ZFCsljyQfV2oM3i8nk/K9m/NP3woorFLl?=
 =?us-ascii?Q?0Ri6u2rATzq6c8gIDXcu8B3nY/4O0d487EDaM1Av/xAqOGYY8VMMBsIE9KO3?=
 =?us-ascii?Q?ajJGezO52xZJRQQJuNbC8lavfUt1iwJGg86DVjlLh9/RZsRfkA6UAlBChnWb?=
 =?us-ascii?Q?78Qvbca98QTDbe993iZeylWYpL8cqvNFlspJxSRQwCnhiVOnPPrnIYY7m0hd?=
 =?us-ascii?Q?dtwnJi0uge/4kAbYojetkzEbi2XM0iT3pKNdE32w9zO5VtDK+Pmu0d/ZASjP?=
 =?us-ascii?Q?Nv2bkNZCJRwf/Jq2oF31bGP2g4mjWY0njqm+V5atxoB0Jg745GFjJY3Xrfo4?=
 =?us-ascii?Q?p56AlwP+X+jFTYN138/IsuDqjUOGqYV+2xEq5ZLJcK1SjbYB4Aoyn+ZnIwVE?=
 =?us-ascii?Q?Bgkzf9RLZd/Pnxj9w90vCUVZ4qwqcy7tJ1SdXOUJdf9sSd6IhgnL7dtR6WkK?=
 =?us-ascii?Q?KtvHA56yru8agrXWUoAFblKYtvFF+CfVHqSzePj8wlQvzw7W0r2ATvGRCOKF?=
 =?us-ascii?Q?ejPZJMbqcEtpaCz4rpMwFgqUYv2YB1yKlkDujAdwIV4mQWTEZZTn+EaOUi97?=
 =?us-ascii?Q?8R3/Ywl4fK5PdHg61dXg8dqmgJ+8O3h8jf4DVsf4o2lMqjM8WSMTjARwncqw?=
 =?us-ascii?Q?kT2DXqGg2xB2dJes+QFeuRsKf1Ue4YTV58qurNvJtjcILXUquIRIUjvLksII?=
 =?us-ascii?Q?ZV9eiP1w5m8RjrggE4FmMYq7Mo+qGmtveRTcYv49npHEBNAoPes28PTXji3X?=
 =?us-ascii?Q?FnwUZp6GUVDxLvYq6UoQF/TDAVlMh0J1mBrs8kxd5c7qgFcjVn7IHliVhuUI?=
 =?us-ascii?Q?DtJOf6rxYSo15aFZsEzc2wzrzHlhap6l0uCWFA20979SToqVEBBHy8Wtnl87?=
 =?us-ascii?Q?2lDsYuFA90Y/LyJzkBv9/7ROp+qoiVecSagurj+XS9DfMU2usoOkfYj2C52M?=
 =?us-ascii?Q?1bDa+HDvGRwF0wIHRscGHZhRXGTnyw/v+5n5rl8O5dWDwTtckYcqEkPMtZLi?=
 =?us-ascii?Q?Euu7oaYNbML72f5HUkQEtML5A6T+w4hxTshpSbXtZkTxmyy/IKTSO8COu1O4?=
 =?us-ascii?Q?duAnVt8JfodKhLUTqeO+xjD9or5A25rTESJ/zPyA4bAefECPeOTbB6k4wd84?=
 =?us-ascii?Q?KV3wi6mXv3OSgdRYTCgtMCJ9mqmxMrYyCChAiqF2KrXQGPTm/9uW2jK0feK2?=
 =?us-ascii?Q?9hEO9YXmrHlu+sn53tNomuu1+CJVi6M5CtplauHTAHK1zpDw8fX2M0zsC0IH?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 965b579a-f3a3-4f69-7359-08dab39d0910
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 19:47:07.1219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrpbLZtr3tYXBvMdg4nP/5vxD57/hR74zLjnYQ9/uDnRra2UOfyjyfAeKlIjHzkzzoqjvfbApSHJXfJALLX5l7XBd1opQ3HBsG8Me4+tCgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP190MB1719
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML scheme for the Marvell's NAND controller
to validate it's DT bindings. Old txt file is deleted,
not included the compatibles and properties which were marked as
deprecated.

Also fix node name in cp11x DTSI acording to nand-controller.yaml

Vadym Kochan (2):
  dt-bindings: mtd: marvell-nand: Convert to YAML DT scheme
  arm64: dts: marvell: cp11x: Fix nand_controller node name according to
    YAML

 .../bindings/mtd/marvell,nand-controller.yaml | 199 ++++++++++++++++++
 .../devicetree/bindings/mtd/marvell-nand.txt  | 126 -----------
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |   2 +-
 3 files changed, 200 insertions(+), 127 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.txt

-- 
2.17.1

