Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0084E73D032
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 12:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjFYKxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 06:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjFYKxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 06:53:17 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2061.outbound.protection.outlook.com [40.107.247.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8969F121;
        Sun, 25 Jun 2023 03:53:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/bdSmWmsccR+fNnoqSDZ3//ts+oeu0YL1IoaP61j3FHgfqmfWw+74InQ5RtFHU9i8oFsWKrfBL/FJzDzK2j8Ggd0Bwuru7FXMuZCYVhPnNjCjubVoi7xzAhn/YAQPnO3WEsrHmEVhxyENRMl1HYP8n7zClA22+cTbYy8Dt2nKbs9RerqpVe4cip65GEvtcSOdETnljTZoQfPfuTF+JU1XJHWjkKLZb8a3Xd35jEE5xmmZ/30SNk8HYGQ7skU6Qc45oJ11ICdvyYRJ+2o1KbzAxknGhVEXVDCMjIZTAFkEDizq1bTBrVPmuMN0Jt81tsxWJ/ycSWy4gfiLxJOlL3lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4+3AJzb7otanDmqCtHWkAJ16BuGOK2a4xnyvowlHXs=;
 b=TrRpxJqkAAKZdTMSgwtuF3rgpzgeA+8Pe9CGZV+F2vOkz18EkOsdnVB926JgQu7/X9EJCig7N/yR5/LVkNhDn8RH7qrLmA8sWM/qw/qCoctz18thB6fWCv/i49m4jgVjAofQy6N/5tbFljaW6CMRjWIwZMvRTggPW5bolSsDilhrxxYM1QjgEBGof6n1y9lbCzGHVvE73WJV0qFiQwNafy/av9N2nfCDk9YDXkXM3cHKElGrwsAtNpbSW5Pac2jOd0cC3yh+MH3a80glrE4rR2c5IEqCZdQVZzSqWPEuxcrJKYYmdsRDzX1ojqaD1+axbT1U0/afFZgTO3tvurPPgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4+3AJzb7otanDmqCtHWkAJ16BuGOK2a4xnyvowlHXs=;
 b=FhH5iSRoUBfkblnRQcvwFBU7pZ1938l2utyLZCyWOAqWTTSzNL7wVGE3LLDiCokJGxEoQ5aePBEhyT3ZgXb/ihDGb66xrNvcMRVhZAQLneZvimvZEN1ibk8pXxGRvn+a5DYbwIhvVt/XVrOJoThSBwQfZ5uoi7fv6JL9xFxNG+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7928.eurprd04.prod.outlook.com (2603:10a6:20b:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 10:53:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 10:53:12 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/4] arm64: dts: imx93: add thermal/cma/cm33 node
Date:   Sun, 25 Jun 2023 18:55:24 +0800
Message-Id: <20230625105528.4057850-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e09473-3f22-4afd-c089-08db756a5ef2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UlRonki54sUcCSHGFR1FIXL0qUk7JmZIjdtgxhELTmGxsSKITrtBNpvx+DHHvsVP3n8Xc/2kFDBkQn8x9n3ZYceEku8MASHcW6OONJd4dqhHaien8K4eIuvXdrAxO860GQaGYIYKX3/k/qi33/wDDwGUZ4hClK3rmI+sd11zLrcJkvkwE32zm+IrqwlLZo5fwrvUrQkiha5FNXg8IjerSaSZfbTJpChaAEJLcR3rNCyOevopwcr9WfDYtWl/X6dFDgzhoJZtLfbEdQw4dusRTtlMdZQVS6TQflxyoViETi4MNZwkRDSBXArW6q3LEPN5vQFVLLx8tuZs7ZmUWzk783CXvWu8QEReGPE1XOEGQmyhIGoTIVTXOSjDigedODBvEz09oEqo/XFSgxzSou0kCyQbU5LONzJupgPHpMgFHjScS0ycC5FD7ds9L27QsQkwjlhJvddF5EJgwQX0kdJJYy+Lp01M9nra25I8355IwFwvE1PQzTnHBMiIySF9tiIYDR9P3eU/dKMqxNxu6YilJuH7k2HAR0WzmOvluV0MH34fqfzDniDHVSc22+CRewFUV2dJiW9bPcFmwcaztuvVz8nr69UYJN55SCFyiRgGjNa5l68lTv9ugavApxUJmCPn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199021)(316002)(66946007)(66556008)(66476007)(4326008)(478600001)(5660300002)(8936002)(8676002)(86362001)(41300700001)(52116002)(6486002)(4744005)(2906002)(186003)(26005)(1076003)(6512007)(6506007)(38100700002)(38350700002)(6666004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j0zRv+8FVzjXvEAvUKz5bDy1ghm6cFzv1Kcib3b7XQx4A3yaL7iB+zeDpEP3?=
 =?us-ascii?Q?MhuOvJOC9TF/tdEmDlvW8N4Icj7cD9u9SL8cBTLgR7gyG068E9pdhMZBWQIP?=
 =?us-ascii?Q?+RadX4nbHy/OPTAWYR/TAPx0zMSBsXtlWRSwHTvgNm/dILr+SN6M3qWOE31n?=
 =?us-ascii?Q?p3cOObND2oLZwMUSUT8GJaabcdeMbidfQW+HP1ZqNHSB3UO1egScm66MT9pn?=
 =?us-ascii?Q?DhtSlYfkQCZbapokORnpVLZ5kKPnwJ5ARUx9wPyXibjUCRFC0tnNttS2coVt?=
 =?us-ascii?Q?0aU0qoh+BSKVq/u22iZdgymqYgmve2ObBnwL3mEVvGJQ1yAf0FobNO2pg4Hf?=
 =?us-ascii?Q?J8/LZfgT+W9TcwYBhAa80qG1+9OiZJXQ9tEpILTK7MGeNOhh8Q12+iCDWqhz?=
 =?us-ascii?Q?qcPMDg6n4l/EDhf+wLvTQ/KcSaw2MurU0SKnGlFrSYmtPtrdNtCPskAjNx1U?=
 =?us-ascii?Q?i37xd6HLzBXfokEhWEmsnVwQ9l7QlFnf36M0frWaCwOxWZmKKclVoUQfSJ68?=
 =?us-ascii?Q?AjtTZsf0HCYOlHmKEtmMTOutyF3YDUwsxF4pMWgtVfQ/xW7CdYEOQiQvW1nC?=
 =?us-ascii?Q?agERsQ/bGnAwrHBZJiPXGXcXziNHOsvbeet5pSAHyFxCfm9PkuUd8C4NFoNc?=
 =?us-ascii?Q?2btsJF+a6meWhG0NBxUluG512yfqpzQktAgJK8nQxL+IzPubrmVBR0NxlzBs?=
 =?us-ascii?Q?RG0XBnbJ6+SKhKMiz2It6JNztxsqgLClUnjaAZLc2uRWyMQzpC+mm18eLzDf?=
 =?us-ascii?Q?DkrTH+Q1JZw00wwy6NFo6QNio9J0Pk0hHVg3TEioCjQB/c+RAP2m8JsRy/U6?=
 =?us-ascii?Q?QapLQJzGAnPVxB2rQVoWy8wv/NH4yiZei1qmgHmbtl+M0AabuFVu8Igpf3Dc?=
 =?us-ascii?Q?iXByNvhZXtaIYUtB2TPbwgs5sbPKozDsZhbS9HNHK+32kBtdVw/5vf2hUPI9?=
 =?us-ascii?Q?I0fyXF01kGuFUPJkf4OXIBv0kyuIhYoz//2HKnsepQHuvUiSjxNaNicDB1aw?=
 =?us-ascii?Q?iqWLxGrRA50G8eTaxihMD9OsotQJrP7uV5bGCCyFwJAqT5g2SB/6mlVaJouS?=
 =?us-ascii?Q?Q+snxL3TSO/c8AtMBBTMH8kf5wcN2t9kF5BHHcHS345LxZDdEBuwAkl3ifcF?=
 =?us-ascii?Q?CL94YV6hN4XcraDPzZ6Gm0fC+sJ445aB+ZVH+r43JiTj9f1iaFjRizQA7Ubt?=
 =?us-ascii?Q?OhrWaBbsPWzKXG9+aYRpw7N/R32SFYm7zNtuHyiIYOPtmwmEdJfqZOawmhnK?=
 =?us-ascii?Q?oCAsID3BiRqacNAEi4wEUHj7fHwY+jFzQDJpXcENy9Dr3HN5WiycQKflf2CK?=
 =?us-ascii?Q?O+Xl8qxnEr5HAydPDg61SAwszGwX8QB+Qhj5ESDI8wIbILM8nt0kHe0qrYD5?=
 =?us-ascii?Q?/8wKl8xpn7s2gimLASzP+9y+eqNtVTdiXRBvAIyRJSVOZ+fT486okxOmbS61?=
 =?us-ascii?Q?KaXUw5qMt65lrikAuRBoYEc5k3UZHRjZV+0dpzJUmbBXXS2QhlNUAz1/QJbw?=
 =?us-ascii?Q?wkmx5i3s9uQg/CYbhFBPOBgOCeuNYPEOBNCa/gdJk327+wBZMWqzdiwYrUZV?=
 =?us-ascii?Q?K42eDLyjpB7+6OyyxAolC05brV3qmis0B1rDzaH/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e09473-3f22-4afd-c089-08db756a5ef2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 10:53:12.6879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHI1Q6Qz/i7a48SzULWKJsd5nm6Jy/jbnh0CXZqNUqcujO9TNd45ieGY+AsuwoDzqmV2d824oFKfPQEWwm7/Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7928
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add thermal, cma, cm33 node for i.MX93

Peng Fan (4):
  arm64: dts: imx93: add thermal support
  arm64: dts: imx93: add cma area for i.MX93 11x11 EVK
  arm64: dts: imx93: add cm33 node
  arm64: dts: imx93: enable CM33 for 11x11 EVK

 .../boot/dts/freescale/imx93-11x11-evk.dts    | 56 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 59 +++++++++++++++++++
 2 files changed, 115 insertions(+)

-- 
2.37.1

