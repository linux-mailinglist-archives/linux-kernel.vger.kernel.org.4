Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BCC6A6CAF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 14:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCANAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 08:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjCAM76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:59:58 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2051.outbound.protection.outlook.com [40.107.105.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECC03B21B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:59:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsBw2SQOi17etxY/ek07+tWZcKk5q1qdkpBEa059cztE3kfcJ3hF/F6p181mTYf+1Nzr0OwIEXhy/tbP4IbCofxcEze39RsirTb0UA/kSlQVAgoZEYwJY6ZtzxwaBN6Unma1Vh+Wp/tUrNdSYFH1nzjqzzpjAP1UdM5EeOrFp61WyR517rwEFTHi4gVx3hf6pftHi4qaQlQYtivQmFTCPTS65v04hCjt0InZDMpWsL4xjkD1VPXn8Zlxw84zm9lJr1t5bg2RiHnF+QLOiFl3M31mmJ00VaZyNqFalJmKX17XEYEIZqIqSy1jDbqFQi+Bca9FwvbvoS75yRAhpvTaiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZ2EId8YSMT+k7FYtXUIaym5IiB79PSlmUByhHgn+no=;
 b=RlY4cakSYJlVtdSapDXfKFqlYCMsXhe+ekZJx848QlvyQJ1bI+0vsfKw3zkTUVI0dNyCmZC0W4nkl0q0nimogSVE4I4qXZd8yvQenFODv+6BhwwQFmxNSVOjJasIDiidCEmSw9Uvd/nz9BeK56w4pn8Hb7ggJeYZLy8BVlyyswlPqICU3dzVaBH+ndHmU5wqfclzhhJ2XEm3dmnmvCUmQ540/m8qCzJgW5oyXLijTT+0DGxJwNQQQYyYRyi8jxmSU4MzEsm5IgIzWggtH8CfObgASi9jBor3mvsC/KgS1EZmWkBVc+D2U9Oyj7ckesJ6VTzLQnVjlw5eDn0vIz6sZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZ2EId8YSMT+k7FYtXUIaym5IiB79PSlmUByhHgn+no=;
 b=q4TfrQFpGDneIIw/4CXLnLd6lWCy3q1Hd6A2RlUqdpdbmOq6USSN3erBl5a7K16NlkNDHIGJd0rvi8ZJkTeLBFimwUfazeoxmwlozjTNEfGfuIRL5evnGSjNdLEKIpNw71BNZeDs6UfBBM7xt4Ai62/nreQL2i1FHmcX2TADFMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by AS1PR04MB9335.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.20; Wed, 1 Mar
 2023 12:59:20 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36%6]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 12:59:20 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, m.felsch@pengutronix.de,
        jindong.yue@nxp.com
Subject: [PATCH v3 0/7] soc: imx8m: Support building imx8m soc driver as module
Date:   Wed,  1 Mar 2023 21:05:50 +0800
Message-Id: <20230301130557.3949285-1-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.36.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To GV1PR04MB9183.eurprd04.prod.outlook.com
 (2603:10a6:150:27::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9183:EE_|AS1PR04MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c75e79-8634-4442-4c16-08db1a54c569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cn1L/EQ9old38wYXxiUeoy9PxsHqG85IYqPsajWH95c9R5VHg1P+ObQFhQS0w1aaXHmmBVU2LqsOsXJJgsNQkPVHgsjBTHIEv8qwm44n69Q0CjyGLWl3VvgJ+CIfUdVVCrRTkXi0VP6URUKvH206hj3LIVVzy+8KLwaJN5rmugyRWmcMhI7YumZzJS63Px/Pqulk+wSUNTHPjtkUX9+8R7nCs3//AvxEBhkguIBBxKclJwNTOCTmS8/Qn4n/RChvgeXSSoxkpu99BUZXNnXsS5j9lVx4wiWe9uuXeXdGfRBzfE5Tx5CpPdGWIWkTcgUoWoFTXQDaXn57BVvrYEKDhGhaCwtrxZmDC/ZYADfgOzNLuXEIaTl+DhmHdCveluClTMQ8ezfKxGdh8lJFdBomDV9wFviy/v54BAWyr8aJDXMzjeMtHKIvE85BlsBbwMjytHCdwQOlJCDzVKxXdKQ9+Fk3aSxKyLTf7oDueWXb6VXkOnl71RGcIDymw4EGNuurRcaMcmmleyJpFFWdDHIDzmo+3jvlP1ZZU6t0lmQQZFJ3RTJ8SltJQ7OOoq32oOfDqNQPqp2sEf5TiCcX/Hnq/HZN3EUCYBBjEUyswwbE8yHTr1EbiF75K6WI8DTIfys3YEoF244jywGbbou0KQ8LeWp8747I0nK2+Gp0+HrATsumFFGSPSlN+jQ4I+NKD55XPRiiVmOzzPXEYGekhNDSEP2cQ2fsdf5v/rFtxikY6jY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199018)(4744005)(36756003)(44832011)(2906002)(5660300002)(83380400001)(6666004)(186003)(2616005)(26005)(4326008)(1076003)(38100700002)(38350700002)(66946007)(8676002)(66476007)(316002)(41300700001)(6486002)(6506007)(86362001)(478600001)(6512007)(66556008)(52116002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjREVmZZdHBMeHpoT1NPNVU4NzluQUxWR2JjckxXbzlFK09XWndJR0VDWThj?=
 =?utf-8?B?MkRuMVF6VElpampUYTU1NG5XLzFIWis1SzJTaTEzTUlPcEJQQUVGdlp0b2ti?=
 =?utf-8?B?NE1QaHY1djV6bXhIc2xzZHNNVXpCYXFpY1A3ZW55RG81WExJZ0JhRm9laEFs?=
 =?utf-8?B?UVFlS2dHbHpkaStxV3JUNzVRY1V4V3Flb0RWbXFzWVlVSUw0Sm1OdUFiTTY0?=
 =?utf-8?B?K0x4Qk5FUjg3ZlMyUUZEaXVwaVA4b1c1V3JEaWlaWkxSVDlvdmVEQmxjMlFw?=
 =?utf-8?B?TUJtSUNLeDdmNjlhSHZBN2lZVzFLVVJtTCsvdjZqZi9NZU9rMjd4bGpQTCs4?=
 =?utf-8?B?RmhMU1dleGkzM2QxUVMxZXE2cmtZaXgvTHRzeERybzYvUENxc2hOcmJUNjRN?=
 =?utf-8?B?QzdyOE44K2wzM1doTXhRZ3l2U01mbTJLd1RUR2RrdTJJLzExVzB6OWlablVt?=
 =?utf-8?B?dzQ3UitseDU3MWdsMGthbzBwRGhjOW45bGJNWGQ5eDE1R0hBRndBTkltNmdV?=
 =?utf-8?B?OEMyTXp5YzZEaFpwd0hYVENuU25WYTI0UnAyQ20wSXVtVGZ0ODVMcHZrYmVQ?=
 =?utf-8?B?cFZ5L000RC8zZHBSbkNpMS93VXFkTDcySEZiaXNaNEw3cXFSd0FnM3hoNGpp?=
 =?utf-8?B?MkhmRERreFNrcFl4NzQ3aVpPWG4xdGpsaXJCdnZsdVJoNnpPeCtXem5oenJV?=
 =?utf-8?B?SFNPSUlCdlRZby9kQWJZMDVxN0ZZSXA3UTZmdVp0d2RyU2I0Sm5FYlNqWVNp?=
 =?utf-8?B?WHlvWG9ka1VtZkNqZ0IxQ0ZDNndLbjRqWEE4UUdnSS9STGdYUm9XeUU4SHZk?=
 =?utf-8?B?UFZNbXBsbUdhQm9USDYyWTRiRjFwZDdyanc3aXJ0M1p6c0JlZ3JyOXFQSlUz?=
 =?utf-8?B?MnVnYUFQVmtKd1BudzJnK1JDNzZNYWpMbytxQy83TjVHNnByV2UvVUtVZ0dM?=
 =?utf-8?B?OGhBTG95aXNaT3ZjTVBmY0kwdzRJSlJMUVZVdnAyTmxRUWZXRzg4WGlVSlBy?=
 =?utf-8?B?ZE93UjQwUlAvQnJlKzNaUnk1RXBvaWY0SnZlY1U5Yld2Rk14U1UwbEEyVTVK?=
 =?utf-8?B?NmFQVEhBOE8ydk9zMFNoWlhod3FVYmtwckdQbndYcHlqU0hPaHlxdmRxeFlv?=
 =?utf-8?B?bkNTRWVxanhHdDN4cUtQeStPV0JnS2lLZ2M2dHhsNWxtbndaK3BqNUwyZk9k?=
 =?utf-8?B?anl6YUhFenAxeWJQMTU3eFF2K0pBZ2JzM2NwTkJSMzkyNnZaMlpMbjk4Y0ZQ?=
 =?utf-8?B?SC9rQ25vaS80T2FBZlgwSGFBbDBJb2J3aUJVbnBSWkFPY0xSZE5nYW1RQ1My?=
 =?utf-8?B?THBudVBDcG83TTZvOXBrMmNxeXRtME1DU0JCU2NreU5hbEc4NXJwQVN0TGx6?=
 =?utf-8?B?UHlOTlY2VERjVGxqbTJqN2FvS0VBTXJTajF4UGlmbWJDdWJXZXJkTkxuVkRE?=
 =?utf-8?B?Nkd5eDdDczgrb1ZxS09QSEZnTDFnWmh3VmtNbms2TU1ZR3M4V05uMG53RW4v?=
 =?utf-8?B?eW5CWDVoZ2ZDNTkyN1ZjR2cvRDMwWW8ySEVMNmhLdDI0NDlWT09kU3BIS24z?=
 =?utf-8?B?dGRHdVB0SW1WQjY1Ynh4OTAwWWtxMGFXdnVsbm9lcDcrYzNnUy9jMUw0R3lJ?=
 =?utf-8?B?bDJDV2dlNDVmT2J2Vzd6RkcyeldlSmhadXk0emYydlVwTjl1U1BORHdmT3dJ?=
 =?utf-8?B?Z3lLS2dWOGRMMUgzS05QTDlFNGd1RWxGYnFvZENXamxsWE93VTFGN3p6NVhu?=
 =?utf-8?B?djFWb0lCbjVTeUNKR0dyOWpnaDg4dFdhcXduVDUrSldrS2xDdVZZM0VXbElm?=
 =?utf-8?B?ZmtJeU56NUhCN050akkxMzU3WllUNE5xM09NNHBLM01uNGE1bHlBc2RwZ0Rl?=
 =?utf-8?B?VzRFOVlabFV3b1FRejRJQlJEK21zK0lSUU9xSWx1SmtYQVpnb2ZySTkzalVO?=
 =?utf-8?B?VitwK0p5RXh0SXNtdjU2MGk4QXd2VnV2aEE5WFR5a2UzOHRCVWFESGJ3RHZr?=
 =?utf-8?B?Q0VnNWcrcWh1a2IzYVkwN1h0OVZGOGkwR0tqSjFmSUU5ZXFnQUttNDhHQXAz?=
 =?utf-8?B?dEFjcUVGWmhRM09idUxzSnhSTlYwcWtVMHNMQkVzaTY3dVViZGl0ckU0aWZZ?=
 =?utf-8?Q?78lPvJSRZZGCoEOCtfaNSnI9u?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c75e79-8634-4442-4c16-08db1a54c569
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 12:59:20.1064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAEWd1oVxWXpKFOjIEtyCjts7tevf5FiemriCw2W9EnJ0YIBUffqCcwOltXOmEyr7dK4WCr4qQswFVN/4Dqa+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9335
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for building imx8m soc driver as module.

----
v3: Update commit message to include link error of
  undefined genpd_dev_pm_attach_by_name symbol
v2: Use dev_pm_domain_attach_by_name() for imx8m*-blk-ctrl.
----


Jindong Yue (7):
  soc: imx: imx8mp-blk-ctrl: Use dev_pm_domain_attach_by_name
  soc: imx: imx8mp-blk-ctrl: Fix typo of imx8m_blk_ctrl_of_match
  soc: imx: imx8mp-blk-ctrl: Add MODULE_LICENSE
  soc: imx: imx8m-blk-ctrl: Use dev_pm_domain_attach_by_name
  soc: imx: imx8m-blk-ctrl: Add MODULE_LICENSE
  soc: imx8m: Add MODULE_LICENSE
  soc: imx8m: Support building imx8m soc driver as module

 drivers/soc/imx/Kconfig           | 2 +-
 drivers/soc/imx/imx8m-blk-ctrl.c  | 3 ++-
 drivers/soc/imx/imx8mp-blk-ctrl.c | 5 +++--
 drivers/soc/imx/soc-imx8m.c       | 1 +
 4 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.36.0

