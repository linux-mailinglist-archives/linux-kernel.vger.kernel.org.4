Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7586573DE88
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjFZMLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjFZMLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:11:19 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2111.outbound.protection.outlook.com [40.107.215.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83CA1B7;
        Mon, 26 Jun 2023 05:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3B4ncWTgf6+tZSGoKKwjs26jGgbf9A/WPjKJ6W55+n6A/HFP8hnl18gZfl7YmU+wQSzUjAgUmZ6heKVx6n+pUfrs8bjGS6NTXYHlYzyUN0BQaekLY33Sq6zL/nhA3b8twOyhMkrdmQQ2ytNjYmVkcMqSs9LQjjz3YvGNEq5oUiD8eIZiS9gS+5gDh78Y0P0XPJNCcIn6DN7Ul90Of9UfxeFMiPOBa0GMJMPcRwjJeYVLPPCW/eI3i/QkJoEJrRh0DmnBjPIBhA0eGe0uB3PzeAXpVn+XsCUX+rYaxfvITVO58VfeEwtkPiZx9JH08BONmNBJVrYNDdKaunnGO2loQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RCyenHzUGlY7SFgLTwgka1ANQ6uwE3cXCXrqK98mJU=;
 b=DCa+qsA5r0SA+3Qxbml29iy5qYuNSWfP8u/EYnT5k2pN69pXdGkOquzG/KoMmIeSocPar2SdKfkbcRWEr13vB8/x6sKP7pbURv/nbnkN2QA7Rsc12rrOwduJnM+P02G2FmHe7LHE4BBi7w0Jh+JtRKlwEzdB1P5zG97sZBId4MOyX+UgFB5mwxcePy7S0Oe9cFKqlgCJ5BAILpVvlcqv+opbHQoZnIo2veeZ5JJk00TyL0ka4AcDx6GaiYTP6x+CcTcwka4gqnmRt50idqzvaRt0hR5YuS01GPcXy0Vt/fqjm4RJ9VMYq03vhi+WWFjR2cDGqrNQaRGPhAESOXIRsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RCyenHzUGlY7SFgLTwgka1ANQ6uwE3cXCXrqK98mJU=;
 b=NLsS9B5MO4P7rQJ4ZsDebMDdAO3M8C0TxIs+s5oTFUMTGccJUhfCAlbW0SfoRfPNRgWCEMFMigGNiHw6ruqLynXqnm0QRUkAKJSvPHakeik8qqwO1Ach4QQBrVY4l0h6U64Net5aC5mUmRSR4fO647MFw1q1TSw7W8UWh2pViE09SAz7115TScArO3Mry4yljJFGQCKjcgjzztHMm2ufjSrL439pD2HDp/NtqXsO6cfEADPbkv6VjGqQri9L3icdaNXHn82FsEf75+S3NzOZmxArXoCbF95V4XNERfCF9cprbBG4L43W9IFlDwLccJVgHomdtg448PlO7FN2JlTNng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com (2603:1096:301:11d::13)
 by JH0PR06MB6724.apcprd06.prod.outlook.com (2603:1096:990:37::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 12:11:12 +0000
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::adc0:c22:ffae:227b]) by PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::adc0:c22:ffae:227b%6]) with mapi id 15.20.6500.045; Mon, 26 Jun 2023
 12:11:12 +0000
From:   You Kangren <youkangren@vivo.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:USB TYPEC PORT CONTROLLER DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, youkangren@vivo.com
Subject: [PATCH] usb: typec: tcpm: Replace the ternary conditional operator with max()
Date:   Mon, 26 Jun 2023 20:11:05 +0800
Message-Id: <20230626121105.3252-1-youkangren@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0102.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::18) To PUZPR06MB5936.apcprd06.prod.outlook.com
 (2603:1096:301:11d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5936:EE_|JH0PR06MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: c3e2816a-1b80-43b1-5956-08db763e6e8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: edSMYMlhiyBVm1CEvsnZQhArdG4xmmrqJxwUNOHDPncHI6SLyZsKhEXflxm/I9WqieMtqO2Y7pYpyswNU4g1uo2cpTcyoqPZ1U8YdBMIGptxbyUIsxsqCv/YWDPMVdvFazqvmoWKCGAByYEgLaBlH+VpmZVVP0tH3bKvEQ/Ze02mJhpZ3XK8FNv8yLMbBUEeUEJfgfbX/GlI4FoKYkpvsr25Y/YD601y9TE4sikATuvEWd8yzgNFOnY91aFgBk1Q2tKuC5HETYP8bNzzl5tVH3F3TErCCcl9uigd4VmN5z6YyyY5+qq7tDSSjtqoSKFgO45ctZtaMZurfKUW4tVkmhz6Pk2x/GGhKwva++EA2JsG2fLM2zScp2efrf/+pIKBOIQIx9++Fji7qbZu8OpLzgwNGdhtsVwZM+/LzKVwt5iEp8Ed5zFY5PbkDfsXKWDIf75+Uzxyl3w7g9QDY1ID7XQZhxtixEE+Ofgldb/P7/9qMh2lVfIMkKWt1I1WDeG6wYrd484L07dJVV8ZwZGB9iraUARoIzyTp4umrAdCfOC09GSPAEtZcwYUTtOoVYKYK91+SI/8i6Z8DrKBFRObmEZr5g533u/v7fd9p6N4mDMZ12rqmHY/dNFEa0H85tFQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5936.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(2906002)(6486002)(52116002)(6666004)(38350700002)(107886003)(38100700002)(2616005)(83380400001)(6512007)(6506007)(1076003)(26005)(4744005)(186003)(41300700001)(110136005)(86362001)(478600001)(316002)(36756003)(66556008)(4326008)(66946007)(66476007)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5HzPlnCul7pysfwnsdeLMVxef5JlkMCr/yGqr77sKjnLC8+fhScX5NvT6Z7O?=
 =?us-ascii?Q?SZ01GIKiVoTYNFjF3ITX2Vve+iJL85xzOqy4ovoEek2vKXibuSZ0eUu6ngEh?=
 =?us-ascii?Q?sQv00opWyNJVdPWwBy6XmaY4JiBb6NCoziN2bvljO9/eieUdwYB35LriSre/?=
 =?us-ascii?Q?10dF7PpO5nYvda3kKzozUgLU4b8q6c15qxwQ2OokM8FpaZKJLkK5D8vLfqvd?=
 =?us-ascii?Q?zVzyF4q9vOHQ8/YAXrKs+kG4lhzOVayXwqj8lifJ+mYOdfZginf30O65Akxa?=
 =?us-ascii?Q?X3rpICOhNkGzeWvS2DD5DzpCZFDJEALcsaA7nbsfRKv/rm3Z4cjgMDYOeLrw?=
 =?us-ascii?Q?y4LbjQNo4QiFiTiFfB66p7E06EG9hiQ6WILOZLodorsuoGTNcSshPFlCDUPT?=
 =?us-ascii?Q?dXLpZIVglAOJBEjqWe+K2HsLl1wTEtPFNttqO1e9FCXcFPe8Rx8FCgkrPsB4?=
 =?us-ascii?Q?bsaB0u6+pkdIWufTwNzl7e1Xjw+fTTf3JVY5Bcqz7JXqJabIRkNThroOJuVV?=
 =?us-ascii?Q?RjPMF7fJSR3nvH/GKNe4C32no3QaOJRT7PH+Oi2reEz2RAA5dweu3kc/dCpT?=
 =?us-ascii?Q?jbFNr2F1OdIfxAB+2igEsYXZ7F2ulbymZlzkjyFPa/iMHThqaXzl4DE6zSc7?=
 =?us-ascii?Q?B0AysF2316WrOnUv7lZm/+PS2hE0fVmp74U0xQ/xkbyo1SIn00FCux7GQuVX?=
 =?us-ascii?Q?//8S4SVMmuWtZmeXX5g9n0ogSkdVfJBmBZ4ar9YsV8IQni7/s5BXNJqVB07b?=
 =?us-ascii?Q?X9f5C1dgjWfltyrajlLIQ32Sf424xjSC09nagRcSX6+fzYvdqKAXy9Hnicxd?=
 =?us-ascii?Q?o9VCooIt5lQ8lJ8XTsZ6WBu+RJlzoLtFSJFdHj0nyVWz/xrsEYWe7f0X7rnH?=
 =?us-ascii?Q?GMmpA8vOzu7pE4MAGKWKrfSFJAjG9Etbal0wFY6QyqV336p37Dx6n5KfrdGW?=
 =?us-ascii?Q?bqrTs1iwxL/C5PBiRGYiAPdNiz3mmwswuf6z2LoTNA/Hxx3HcDSaka9eIZn6?=
 =?us-ascii?Q?zsFG1t4VV09CWvoYinxizAtA8DuxW4QD/3akWuuTXlgMcZtYQ6aUCGfiMf9S?=
 =?us-ascii?Q?rkVPZ86pAi8fIBblKSIqXbyYeV8YiQHxtlNTCt5mAZ4dlszzKfTtF61xOqsv?=
 =?us-ascii?Q?G6S2YzscWD5khoVCZPWiI/erx1vyyuf6TfeRnHwN7fKVrBP8cqomigJ+3/iU?=
 =?us-ascii?Q?uEl+z3qerm9Ua9SNSCIxA9lyd6zdMUq6qgGmjeSj1laMJ2nJdrWxeehGPeko?=
 =?us-ascii?Q?nAp54qYi/QtXN6ORDUga6yZelon5i24SWw9YgortvchKm9exF7laEQ0wq+uB?=
 =?us-ascii?Q?EOFYy9v621OQ21r1QnQF+TRKgMpf4fW29m2ZfZxWj1OAmlZ45UmbjPJHv/4t?=
 =?us-ascii?Q?79xtKyP6HCfm2oaxyeNfGcgZmeUuHpDftQyJuGWSdJ4UkBwUym0nwY7xXVkT?=
 =?us-ascii?Q?aVL2uvUVzIw1WAkuz4SyKaYUgvSP5Xz+W8jvoNB3f2JstX4NqFsKB8Zcse/Q?=
 =?us-ascii?Q?6TJMeJxhWLG+dAukQqKSRP9DX/HF2ALaXaSgtGCMxIQB0hVRNbh2RTHUMqWZ?=
 =?us-ascii?Q?hbHIfWz71dd9Q2xM6PkhtuB4nU1X3JLGPTpynnVT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e2816a-1b80-43b1-5956-08db763e6e8f
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5936.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 12:11:12.2430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93Tu4PmdEPPbJmptVr2EbNv3Zpv/zbV67Z2K1hOmxmSTkDgnrDoNjRWyCbaWEvDNz/GV3rG2s7PWKjWcccUn3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6724
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the ternary conditional operator with max() to make the code clean

Signed-off-by: You Kangren <youkangren@vivo.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 829d75ebab42..2a0b33bd2eb8 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -6353,7 +6353,7 @@ static int tcpm_psy_get_input_power_limit(struct tcpm_port *port,
 			src_mv = pdo_fixed_voltage(pdo);
 			src_ma = pdo_max_current(pdo);
 			tmp = src_mv * src_ma;
-			max_src_uw = tmp > max_src_uw ? tmp : max_src_uw;
+			max_src_uw = max(tmp, max_src_uw);
 		}
 	}
 
-- 
2.39.0

