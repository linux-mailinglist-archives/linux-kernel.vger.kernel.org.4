Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC0E5E8464
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 22:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiIWUxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 16:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiIWUxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 16:53:14 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2106.outbound.protection.outlook.com [40.107.114.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F1CF192C;
        Fri, 23 Sep 2022 13:53:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3xzG0x4SGaU59F3agpd5UdxL0vX1Cew/dAJpJU5/WevTjPMO4MD79PSv79ZCCsbiZ3m6LzSLvN1vIAqCi1Nm848MuZMoThKf3azyUB/b9DZvDpo6ft0Q+aE+UgYAA9HM6U/Mss8ydhqGqXDk7nXR8mtP5229R7W/C7m8wRkggW0UtVKLxsea4VXrWaX5WJeUf4t4ABc9y10YW7d6TPB6vKx57ERWGgJhA3D9ya8KNR/XR8CqJU45XneMYB69u4MZB2limLrc7kD0XT6erb0IxkWenfsoFypomgUBP+VZ0+GRCxe/p42iSG3hckMyjzwETN4YuM4ycPFKZMF81h2SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOG2gv8kAw6Nuqojux2A14cnHiLsxZgEzpqSF2q4hCA=;
 b=bxxUl6PP+tDi4VUIRp/fE3ncaNiHtwDFskM6PHQ/jgiIZ97ZiH8uOhPnvcdEiir4rWmGxXMzmUn699oKknbxlSTCFWjrPuUsx0DiEIdw1jQRlxppplA7eCjqtXbTiUxswpqZhlDD9X68+v6i4tllbSQlYEIXBw2eotvCK/qQ/jzFIIIh/ssNYELqgUR8JTk2sELQUuS+K1+6whRRByLg2k0EqYAzDSPCXYjAUq7bax1IFOAq/4ORQGSnakF37/VPWr7+khOkSunnW0LC1U/VyjBDQ6Xf77x9ykuebcsVcttWKWKZHvevF+ENgk0zUhU/Rf6LL+jvIgjT8r4hI0zvGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOG2gv8kAw6Nuqojux2A14cnHiLsxZgEzpqSF2q4hCA=;
 b=aV3z6+WR1ABg+WSypWxpKS+326FGKtgWroWjyfhLFcYY13qlFlsauRmm/H0/4VS2MGgKGaBxgWib00Ed0MzNBDL5GYb0wQRufiXSCAdDddP+2DYYk6a5rR9q43qnuG3L4TWuR/Ygv13CowTb9R8OMcQLEOliZZJuVNpe8nQR1jk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com (2603:1096:604:5b::23)
 by OSZPR01MB8499.jpnprd01.prod.outlook.com (2603:1096:604:16e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 20:53:09 +0000
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::700f:4552:de5:c2dc]) by OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::700f:4552:de5:c2dc%3]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 20:53:07 +0000
From:   Alex Helms <alexander.helms.jy@renesas.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        geert+renesas@glider.be, alexander.helms.jy@renesas.com
Subject: [PATCH v2 0/2] Add support for Renesas ProXO XP oscillator
Date:   Fri, 23 Sep 2022 13:52:49 -0700
Message-Id: <20220923205251.1387-1-alexander.helms.jy@renesas.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0042.namprd02.prod.outlook.com
 (2603:10b6:a03:54::19) To OSAPR01MB3892.jpnprd01.prod.outlook.com
 (2603:1096:604:5b::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSAPR01MB3892:EE_|OSZPR01MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: 33bef58a-0e24-418e-b1fc-08da9da59ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ov5Gm4slG+k7Z4TrUFs/VxibufQhSrtooTd9v3e3aaVXeGSFeMefrOCzeV8ze+rYfOLxgpxv2Sij7F7W3f2XqWXHXqA6jREO7OYsLOAE7Jse+U9mpY15oJmDbgqVBpSqvZl5/kDIrExKV0VpVaNMpYwZSmImpr4upwPprsVSdgQH8m8Q+FOkqkCHmZa4dTGi7xERp2249e5b9VWC9Fsgq50q8A89qW/kHVn7PYWoFaKUYDPlhdtXEc7V5a+IrpCsugqnfHCIDfUMzISkkdVnaerjH7i5SS2h4fvkZiV0iDBFzUpVY21zvcETcrei9+m+rGbc4iFddOu+rQVgssIEhvJ8p5lNhuOtHuziVY0pDYJnKYprJvRmKn+9XzsSi+aAB9Ci9C1gqgDpTuf3gIMkTeW0/6g6ZC9wcyFLyKnBc5TT2MiHEJNlwDR4QmRMbFBFrkXWKOoLPFwfsdx8wpSZ93R97WbUp1W8ZzLwtBlITyQaSxCaLiASHRpE27GZvRWfCfXn+n0z0iRDmPAEg1NIwOuMx8b7mDbnBhoTnlmM3gsbag8rPwCPMnwTfXJERJLjbaH/wLSnxuI6pIVCU8TKqHYWOHCaEbe77WL/snn4dbPpiPcyNMNzintV5Lx/c9YNDZazWcCblKxF18TYkZ171nNND4CbYg4V/Ioxmr8Bg/m4s9788H8BhwoIJzehHexJ0TL9ZJ5NlT6b3hNdsIj06U0eBZDKQr3ul0UQnMG6VsQPHGpeAHJRzJ5icycJibUe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB3892.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199015)(6486002)(6666004)(41300700001)(316002)(478600001)(6506007)(2616005)(8676002)(66556008)(4326008)(66476007)(66946007)(6512007)(107886003)(26005)(8936002)(83380400001)(2906002)(38100700002)(38350700002)(1076003)(5660300002)(186003)(4744005)(52116002)(86362001)(36756003)(103116003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y5DCPiSZdr8l9xLPNnClBNccb4qIxVfF4zFFkHJEvt2B/bGuF43GL/Vy+pzW?=
 =?us-ascii?Q?/ZDdZ0qZOVryfzSXIFU6NSg6qESxcl40HYEW172E6Jm6YChxmPW6k25FbfLM?=
 =?us-ascii?Q?5bKq14ERkkn/tyfRIgzOsg3mEsKum1B5bPEQJXgyxX/mav/XMdpE99VvM5eh?=
 =?us-ascii?Q?aACQ2Jv9zBrZhoUXMTzznJlf7RmZgieOA5wy4eoYFOpK6qkjGpKMbV1BYmWp?=
 =?us-ascii?Q?12KRifU9d++Q/GI2qacfYr8+k+ULbpJ8lgRYYe+FjlT4GbJQHQQvXVdsJzOD?=
 =?us-ascii?Q?XhFV/AFIQvgCOKjooXI6siythEpvdHjQxiXNjOaqHIfsvASH7hOGtBrdEazw?=
 =?us-ascii?Q?f53Pwi4AtlDkBPKIkqJTmQ9XodbqsTh6TTKvXfj1zeYT+HSXUT7PYuQ3H/D6?=
 =?us-ascii?Q?CgHQA5GMoQmXWgDbRAUUnG6GF0ObQA7/SwvUiQhGsb06pOSJKIgZ58eNaFOn?=
 =?us-ascii?Q?DQj3G2RUKQmsbY1zS51EEcF7S+G8EpZLUg4Knkn2owHRAUmPh+pOdqXDUSsF?=
 =?us-ascii?Q?XHOITeztmE0NQxjBq0tKNqXAaRzXxJYzqoIkmwJgrhV76iM1eSjxGQVY6FOz?=
 =?us-ascii?Q?JeWt9BKgR9AxGVkto/LpQIdghODTfLoxq+CwEefnLjIvL0PXzjxAN3urvSVl?=
 =?us-ascii?Q?THPTa2z/Q407Qrt6to8QYCIO/AT7HWYL254gs2Yeh4/ZEwtarA/isLG/HPEo?=
 =?us-ascii?Q?WPWjw8y7NE/FrWUFbJJt/IZ1Q8etLATw8lgTxrjNqi9k8mXh0BKfY0RRDTLO?=
 =?us-ascii?Q?Xz3zpLuK4HLTEGJ/Do/UITMQenIS+ljv1Bfg/xNHNR8p2UIILW2FhUXnUXwY?=
 =?us-ascii?Q?mb+gCE55PEPm9MFTBgJWq258cfypZtEsmHQTzTa7x28F2v/rRPhmKSs+9Gal?=
 =?us-ascii?Q?p6G4FjMcA7T/eOvsPfgtaHjWC8cjChGbWzodrBi28qaryqioogAyNoeoKcjn?=
 =?us-ascii?Q?nQxu1B4YWqHgOdXnZGPgCE/B+UZfs/I73LqgksTohYmKb+e3J1hY5osiHaP/?=
 =?us-ascii?Q?JIrFkANwcfuwAak3jVdhsI/QnXBBHDjacj6XKxRPf6CLhC5LxuwVUO2YNR6g?=
 =?us-ascii?Q?2l99BhIJiujsgniDOgXSMRGUhoH6WBsazLxLoguYM/J8M0TzjjLbFPIDpv+2?=
 =?us-ascii?Q?vOXtS88t4HWxAox6pFe8pL5mFSYiW8r8p6G8wG6fqLUOcNczKtxLi1IsFMKH?=
 =?us-ascii?Q?9Axy374hEA/JoEl2FVEREIh7dLDFZvvKfPcD+ek1pAuQZI/b1j2OlD0ujIuW?=
 =?us-ascii?Q?GS8LQBCjZedCdfO+er4VLpK7MSUTQi30kl6+5JfaW6LJ+f70WzG8GLTwsQEL?=
 =?us-ascii?Q?7/hK+v0RRjNuDadXg7byRqKJnZczthGk4aVve5Z1I7ndo5AKWMkbX0aCR32x?=
 =?us-ascii?Q?uEL5eVFqirUroB+GTNQBije2G0s4Fy7o64UN4cNhgpoc4ZdjDwWdDBpw891h?=
 =?us-ascii?Q?OMS/vdlaRnot53DU5128He7vbwB8xvNgI1Ss3uvA1h3r4TpXeeAq1Ys1U4wQ?=
 =?us-ascii?Q?0FEvUlgW+smk/Kso+NAq+me/MZVsvxM9vrD6f6skiaA2Lk+vZN2kNqWmIGMh?=
 =?us-ascii?Q?rOfC7i/05i+SGTpfonn3OhTlF3GoNg7hH2DYUV3UuDEvDgCb+TMearuqpaBD?=
 =?us-ascii?Q?hZTgi6MUfWRpIolVAiRO57s=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bef58a-0e24-418e-b1fc-08da9da59ddd
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB3892.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 20:53:07.2875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7WzywWQedTxKNx6yw9iUg+kTSlwlLjW72AeEudzFHWfDgDTxv4Vb9qtFgz+OSkuNrc5rBG78XOX0RJEsAvyHgAWJTFuVxiIe67vy+K8ZxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8499
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree bindings and a common clock framework device drivers
for the Renesas ProXO XP oscillator.

V2:
 - Fix minor issues in dt bindings
 - Change renesas,xtal to renesas,crystal-frequency

Alex Helms (2):
  dt-bindings: clock: Add bindings for Renesas ProXO
  clk: Add support for Renesas ProXO oscillator

 .../bindings/clock/renesas,proxo.yaml         |  49 +++
 MAINTAINERS                                   |   6 +
 drivers/clk/Kconfig                           |   7 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-proxo.c                       | 410 ++++++++++++++++++
 5 files changed, 473 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,proxo.yaml
 create mode 100644 drivers/clk/clk-proxo.c


base-commit: f64b5666e11dce481737208027d4af300c63842d
-- 
2.30.2

