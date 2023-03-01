Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582236A65D0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCACyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCACyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:54:11 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455D1166EE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:54:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFtwsAJ+vu/lk/HIxvUOLxndn26lwGWAMzWGW585WBDVCUlxaXBVPrVO3SxC8Fe5PWd0pSlroZYw1nzK/W2jhPN/w8G/YOdBbybZOw0otbWy7saTwpYNGRmjNYshSU6qPqp4aFFiAw+uJLrSQGYW37rd23wJNNm7gi7W0f1RP74p+qHm2fj2Jsw2LonYLUVajfwiWfyOVfb8ILNAeJJgfcI07RMN60MT95AMubiv7V3V8exBsIzM3e0lQ25+FLEAZSHijOxqS9E7NYyPfVxK14f8fE4gdxnXR+ccLGRyf5VqAgkOqMB0hZNa+QCaiktijMsxvxLCde16bco0BTBWGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mwFGKkasiRBwxF2jSIUolhAo0prQGRc+74oe4GVbc0=;
 b=WAUyIfA+2DT/v5Pylt1ORry+bZWihRseTtxM/aZE6ez6aI0tpgt8a7xqV1Y7p98S4JLAc41VHDCLjHD46b69+7x9xFAaFUyg9qPQD55BYOM4N7uh6xi3UF28aJUvhj4tV85KqpixRvQApdbPgFLY5CVbtQZXJ1aaKYIT17jnpaTf2hbZSFeUyiPdgbG94+Rgt1mvezcvN4+L4rrAePFIxnY7QZk69YjG8vNYQH2KtViza6VHWvIrGoiwpCkxyoaO/V24t2Avju85Yowm7r9YdVLpZV/mM11yxxkeAfJuwMTa/4SEFlaavqzI8GMYd+9JaLmf6ftoaH/Kck/Hzdfucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mwFGKkasiRBwxF2jSIUolhAo0prQGRc+74oe4GVbc0=;
 b=AzGa1oY7QlDrf9xoH7HqIovBFcIIqllbU+xJoIgiS36/Om8Wgf3ZGoG3SONltmbEqm/XcLniGbUyTVStIkS8xBJjKZPWJhKVZ5UjZomPQyi+YATM+CQQ0RpUytqkfpzt2dx/z3rhghi9t2xkHryQ92wEqpznpyOrR6WCUl6WNEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 02:54:07 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36%6]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 02:54:07 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jindong.yue@nxp.com
Subject: [PATCH v2 0/7] soc: imx8m: Support building imx8m soc driver as module
Date:   Wed,  1 Mar 2023 11:00:35 +0800
Message-Id: <20230301030042.2357706-1-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.36.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:4:188::16) To GV1PR04MB9183.eurprd04.prod.outlook.com
 (2603:10a6:150:27::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9183:EE_|VE1PR04MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d7ed86-45b3-41c6-ded2-08db1a003962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q/1KyRRscwlOheUBpK0HbBQueugIZ+j1+51/ot3N3lsg+esDQn0mCFPhCL6L0j2hD8FQXgNW3/DVrHzAVAvC2dD/THFYOYMeQ32OOWd59XZ6Bjc6CgwP4Utfu0aEc/3w3cbQLTNZM0m2p65lzfCCH8Nve7E2R7K+AERq8lj+EEWlYm9DBAgx/DkTpHiUo4/MEZVsnYkZGpfzGZCPGVFjuzofv5IGTrRa6QgSC70nB9cUh6iNusw6jYTTEYaf81ASI/ApgxkK6V3AWu27yN/qPNPTGmbzVx44P2qbto8mXNwPsv7jIGbdBt7HHFdg7BDGegpamQw1ghbZ72KDmRdRvUiowzQTb8f7foJb1ZC4BuNnOxd9WS+Xh6HoQeVkI1JNpj7JpcPDobWwBaQrHDC/SL5uY9ZFKrpWLWpHjfZxegP3gfUvnkVORVsPOO1jzMbqPlZxdOP9ZZvdgjFWuGubEx0DI1epkg1xn7rC1InnLTNUE4nSVQ23BNF/JcUq203w2LgNu0ElrLfvgZMc0rAgciT/ODJElFD9CMyZRHX9of6jlbZwEiq1TqTRoeYYrn2OMmT1IxvDSrSyAxKWqPpDY7pLYs/PRgbr6uuhp6a6cpHmf+TfYXR0wqponRvVuSlEKjMCPJOWchDpbkOTw4DjfHgTUnUfic3ivOe6278H14YLDIwrgj33jN2Yyfzru3voLJ6BA5p41O8m506U6VXgjORSgmn+JVnnAnQGhjDLAJo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199018)(316002)(86362001)(41300700001)(6666004)(2616005)(66476007)(8676002)(66946007)(66556008)(4326008)(4744005)(5660300002)(186003)(478600001)(36756003)(44832011)(2906002)(52116002)(6512007)(26005)(1076003)(38100700002)(6506007)(38350700002)(6486002)(8936002)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3hpZHY0UE1ZS0RVQ0VZT25mQ3MvWXhZd3ZpMnhSSXdNcTNKeEF5dGsveVg5?=
 =?utf-8?B?bWlnR2huRTBQMWdzY2tSWTZOK0l2dENoandSTyt1U3ArbUhXUDZSZmxlTGQ4?=
 =?utf-8?B?UWJaR24za0J2blZFYmpOZVl1STJFdVVEOEVEZitzZ2dYUG1XT1E5aHd3Z3Y3?=
 =?utf-8?B?U1k2WnE4QW5DOG9ma1g0RWNlS0thZG5qRFl2dGcrTTk4aDJjMXZVSEpZYWFK?=
 =?utf-8?B?NVRMdSsxZW1YTXI3TklUaGVXeWZKcTNlejZVZmxuZHZoT3FzUG9VelNlbUo1?=
 =?utf-8?B?Z0o0NGt1b2VKcGhNK3ZtRWFDQ0szdXpHZVBNSTZNYUZhRjJkWHc4U0dBV0I1?=
 =?utf-8?B?MURMUDN5WUFZZlF6RzhpVDNmNW1RMGRGQm1BQXFpeWEvMmh4dUhENUVIQVA5?=
 =?utf-8?B?SUNZTWpOOTlET0hLWVhhWjEwTTJaRnU3STIxT0lLSGhEN2JoSXJ6ZFpTUXk1?=
 =?utf-8?B?MkZ2YWRFaFEvMkJpRm1QamNGWU9Uc1hpcG1rUit6V1ZjWVhwUzd3TVR4Zkgv?=
 =?utf-8?B?SUU5MEhYMkRlNzRCS2RVektvYkp3Q1dKbGlERUp2Qkg0Z0dPbFRSU0tVUUlh?=
 =?utf-8?B?alloaGd4L2IyRGlWWU9Td3dDUEkzNTlHeGRqd08vNUt4V2szT2RVUzIzdHR3?=
 =?utf-8?B?QmVseFJpQUM0aVVGZDUzNW5OWGIwRWRabUthckFFc2c2eXU3cUtRZFlqR0I5?=
 =?utf-8?B?Tkx1eGh3ZHVJSzBJeDRTc3cvWGpPVHNzSjlBa3Rqc3FvbzlJZkIxT3lkdVdv?=
 =?utf-8?B?M2t3NWFRbHNvbGZQZGRFTEV0WUtLZEhXVkJheUtYTXhVWk14SktTM1krbXVt?=
 =?utf-8?B?NjQwckV2UTk4ZGpQbW0xV25RZTl0Tld2cTZDc0RyUURuL0t1dFJ2dFgzUGwy?=
 =?utf-8?B?Z3pxRFJ6SXhpUW12NGdYc3Uwckc4ZWR2TzlBL0dybDQvc3ZXeFA4bWlSVHlN?=
 =?utf-8?B?L0h0a3pjdnc0amxvVTdNN08wL1pEc0FhTGxwWVFZM2NyaUpqcXpHaGZORUdD?=
 =?utf-8?B?UjJScXpoaFRCeWxaUGtyYTZ1Z2hwRVNuSHN3L21EOU0yTHlRaEo0VDBsaDdS?=
 =?utf-8?B?SlJObnU4aFgrYi9lQVQ3M2JQZythd1RQRllvSERXY0ovcFRMZk5VdFE2RkNp?=
 =?utf-8?B?Z0RsOHY5a3lXR0I3SEhjaUg2OXRablVGNGxuRWx3TzlJT3dpdGoyV0oyK3Jn?=
 =?utf-8?B?TU1SSnFnQlcyeW8zVUtwMk9HMGJ4eVJ6UVFBWlVJZTJIL3p5RisrRlVjS2Rh?=
 =?utf-8?B?R1RaNnRQYmVjWGlweXJkekw4SFRoRDRydVpCUDRRbFhSNlBURlFrd0Q4T3hQ?=
 =?utf-8?B?NTVnYWpsVG81YzUxT21CdzE5RUhURTBQQzhEQ2VzNmcwd01WV054M2F0MkxP?=
 =?utf-8?B?bzhiY2pFQzEvZFR4anNpdm5WRVIwVjlJSGFWWThrR2UzRTQ3VDFTMWdNK21x?=
 =?utf-8?B?NkNYdHpIbk1OaVB0RG5EajJJb0NqaFlkcmxPSDhmbHpjN1dzcWF6SUxkbTJD?=
 =?utf-8?B?TU1EZUNrc3k4ZGk4dXlZcS8zVDFDME5aaThLRnRvYTJxZXBQdWhiN21ZeTly?=
 =?utf-8?B?NFpnTFN1TFJwVU5PdWRlWWpNZll6YnFDemtuMm5sTlZaN3Y5bkxOdTU4Wmts?=
 =?utf-8?B?dWFGVkxXZGVmQzFENk1PVGFKeGNZR1FFRFhMbWhqYlFOY25OeTU0eWZsUk1q?=
 =?utf-8?B?VkR4dEhMMXpLNUM2cnBkYW8wMGxuU0oxTkpzRktldi9LTmw2dk44WWpiNysw?=
 =?utf-8?B?Y2VrQjRjcS9jYys5ZnNNaWVJSmtNNDdCY3NPZFRzT1dTOUxzanFEUW5UdVp2?=
 =?utf-8?B?QjZmbjRPNWtzMlVoVmszOGxuQk10RHlST1Bpd2E3WVl6R0F5bWQyRlRCdjFk?=
 =?utf-8?B?N2pxRCtLdnVhVkxtZElsQitjTnYrRFRoZXp6enJRdGlMZW5nTWhhNmtzSlNS?=
 =?utf-8?B?elRJQW1jTkoxZjJsN1N3bkZjVkxWQkRhM0U5M1F6SFF2MWJxdXUxQUVjcFFo?=
 =?utf-8?B?RGtoNlJiM2xtc0FUcmxMb2pjS3UvOGFxbVhNSi9BVDhxR2Y0aGU1OEVZSXgz?=
 =?utf-8?B?cFlwdC9KaDhpdTBTQXVnTm1QTWlSMFdHajhHaGJuWWt5ZEVycm0rcDRlTjVn?=
 =?utf-8?Q?olXUn/vpVv355u5UEBUoYd3bW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d7ed86-45b3-41c6-ded2-08db1a003962
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 02:54:07.1752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQz8ETxGq7gBinff8YVCVfnT8eWAWBqlpIy6dRukWrVB5oRzhHCf9+afKEI+7TBcz5sYgPAfiyfp+0UXaVWpgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469
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

