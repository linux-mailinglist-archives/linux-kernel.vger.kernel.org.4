Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF506C9B5F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 08:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjC0G2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 02:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjC0G2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 02:28:08 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928BF199;
        Sun, 26 Mar 2023 23:28:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6ySsj8Huz29P9+UcYIm31FW+3dgujHeatXgpB5pqZvq1hNjBgHfR2TU7CGQ0j/mZb4g2gVl05/YF1wPmn+jqYwqzOpKb20CwZU+NXbF28YAdU5HZ2z7hpgMelnkW+X4xQQ/9s8mRunpHagDCCypf/aM63qUxW5g+Bsgv8mdc5lOOygTYneDpM+wnmQc+nNtjRjJ2xwngXsmOCdOjCiuZVOey2qEYWIZPyYiQgMpQRXFy8zFFQmgxp0IOsLWvxwpFJwm4TW0W0EVxlGVswvDrdqgSfjfQm9qAMTogHf93PxmTnwiS/nLQrx/Rnx9tWxDYaBkgVb8Kbwv3BQ9T+BaUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDkdd2nHilE5C8H9srDosu1X7h4B7kQSiOChnwNBojg=;
 b=Z0IdaqhmExFG5nPaFSDT6y5ex2Z21fN0KTnDPiOq3h1GT5fbSpZ58IQJgYoChfubtoqJL56GRwV3zCowtZyNrsFfTeSaIeaeDH4NLmpGIhObKDTR1TyOrawC1BQ5I+9yK5AXy1cV1OueSKETsC32ife6VeRp0rfcLHCcRBp9qlWvs42Fym/87VzAseqC9vOTaPTUAZUVfn8TIfGtlpO/w1/jqyylug/b/Eg0BRs9ox0PFusFir6uoKsH7CQHXAIphx4s7PFMyAfhEmnoiEkW+ucSZ6U57XVkrxsP4pGQlxYgtm4D7VgNbIWQLP7EJoB9UhlVOK1pLzGjLRe/GE18ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDkdd2nHilE5C8H9srDosu1X7h4B7kQSiOChnwNBojg=;
 b=RfrLeJGmk28hbpNyBhBM4sGNoEHUG5yJPnS2na7CB+lUuJJragDFAJO8Xyrr74TKLehOlggtJ4JlbUS+7FNlG1vNCgNfkcBLyEY3Os3uIoRXKitQyUePE/0kNzvyfFvIFXeIwwB4Yd7GtKOQpFGWXBt+PNEWkEFjcD4oOqwp6z/eEFsZEChDNb7936M2eWNkae8VO04Nv3wGIoRe7SspVEy7ntix5bIdwdlAHBWSqyMGm2geUY8l80ws361PngqlQo66iqH+q94yoovFniAuUa9dsjc+j49z3lFwxFJuIuL9pN44afCbN8p+mzBi4OigaPJN/BveLVu2OYPo61CP9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 06:28:05 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 06:28:05 +0000
From:   Chester Lin <clin@suse.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Chester Lin <clin@suse.com>, NXP S32 Linux Team <s32@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v5 0/5] pinctrl: s32: driver improvements and generic struct use
Date:   Mon, 27 Mar 2023 14:27:49 +0800
Message-Id: <20230327062754.3326-1-clin@suse.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:404:42::27) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|DBBPR04MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: daa6379b-5f51-451c-a3ef-08db2e8c6bd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EjEMvcGvZwI6Oc7mSOXVuGPba6KZo2NJVAc3Ne5gDuw7RHVMUblgjP2A2DfkWS6B9v7oMvBt1dMlRegnVLmF8R3qewLu9E4H/UhP4I0EEX7Rh72AyzgQ02aBWOsBiF4Bn4O0rhpWww6v+Dh3T8z4WTXF3valIqRvfNBMaA4JlZu/YFgIhtgT1z357Xobc7aeaCGMRq1cBqUvW2RJZySL5WFgArlRFkuXu1N8nnreLrjWJ3BN5loKzJ5mM919CX4Oz5w7xQFrdNAeYhzsP4Ke70+0j1+VutQhS7L0UV5rgL+QVM4nw02eUQI6tY7tKBLF+fXtj/voukz5fW2OE7AJlIHa6hflTC1fgNqVBsyeN5hVwnerS5mbUj1iT+AO1wsAsf8aQ0R/63ghgQzCfODudz9jHA6gXofbPie9PeHJVQ3DlD5bQa8u81Ln3w4m8LpBor2a49edsdgXm+9wktYFJkH9EhGLXtnRsdX9e6SRYaBRbXEBTabYTerjmduS/IqYnhT6cyvzOE/WyxWAyA69E/dKjj/4a8BV0bXdzWn7xu/9tN815m/vYszjeDavfOzpXJ+bBNmjYw61hqQejDVAJxkarL6HUXRVXl5zReAqHv6r23EGu892WGw6VeIp/ipMx7EeAThi8v+Z7KAIdpoexA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199021)(316002)(110136005)(54906003)(478600001)(5660300002)(8936002)(36756003)(86362001)(38100700002)(7416002)(2906002)(4326008)(66556008)(66476007)(8676002)(66946007)(41300700001)(107886003)(6666004)(186003)(6512007)(6506007)(1076003)(26005)(2616005)(83380400001)(6486002)(966005)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8pRDuOlWFn2ufB0FXdFuZ4vtItYVS+YfUneIcIyCWc7fDX1hvUUawViYldm9?=
 =?us-ascii?Q?MWHtt4fCM0m0XaEycSPAzbkxeWJEfC38P6WBsUk9Bm7pgM6ZxrGpk4P5PcVw?=
 =?us-ascii?Q?u7xYzlq+UqQQID2Kvf4VhK2IHx+O4fFc+PFZx4Jqgcx2Ymj0YMOq9qbT1K9+?=
 =?us-ascii?Q?cmvTLb5aPF1z0drnLEhc3XKkDkRN5kB+Ly47keClQ44aZb8zYc3VGKav3OEB?=
 =?us-ascii?Q?/ET0026NLeMCtjf22aCowekZUSnbHnwcnsTGLYIemRxbOkxd1HA56LT+NQHt?=
 =?us-ascii?Q?t4K+RTzWG6F1eTZuY7XrZOy58XtfXR/l3qqEQVPCiNsy4O5knLBFHzk1anYa?=
 =?us-ascii?Q?agUHpsp6MwsqxQFwg8N12msQKEuVdLd9JmDOfRoPP3jh0/pQ16YZNOg6JOnP?=
 =?us-ascii?Q?msFKF4Xfz34BmJY+O5CKvPHwQnN0AuSmwBDqHLdw/m8BUvoiYyZruMVAwmhl?=
 =?us-ascii?Q?p7izMoW1p9IrNs1d6fqgVp20XbjYo9VgTIbALLLZPhZjg8V/KgxU79nCdklH?=
 =?us-ascii?Q?SoYNpctQklhujPYwvBMsjj1tR00p1fQDixQtl2v3iuYzFpYjeiGwzyHwnPIs?=
 =?us-ascii?Q?wSKJmFsn7iiy0cc3+TAyaWKS+rgTnWrCtrPPDI1vcfD+y8S+NUmugC1UcZpe?=
 =?us-ascii?Q?ShYuYeqE/fzw8/Z5O+DmNa95e7WiknggYhPvFe4/gIzX+6/Oyuk5bTswCOYX?=
 =?us-ascii?Q?9W8VeYY+358mtKACGVC/RpsZrg2AViSd/tTIpUrwPhfkEG/aQnLsjQ4M14T9?=
 =?us-ascii?Q?YEGCOXM/wBPoJ5DHUra9woa4eq4sWX1Q5bc7wnXL9SKoRg09IiWhO59F/Bj6?=
 =?us-ascii?Q?UoU+qIixzDWppKACr0kqVphTxzCh8qpZgC97bj6BkJmofbx9n8fWOsvE2koy?=
 =?us-ascii?Q?nhW3992+WNnlzgOx5Glnr/RDTFoi6T0Pt9o7UtzetQdJ/CCxSeasrrN66GVE?=
 =?us-ascii?Q?WVxx6m5Z7yDUUV/gCIxwbREZ2MFLn7MQj96iMpU9a/MntsHFyk6f0i4meEpR?=
 =?us-ascii?Q?mxZoMVytTaSe+zh9U+/OaCzLICY2kEP95xNKHTmd9rTJSCU+D3RpgjLGa98y?=
 =?us-ascii?Q?kJFJI+SrjC+V9/gK4rGS10glj5VSXeAwVWqTWOCqKAkEAyvq7uZyAasTUB+X?=
 =?us-ascii?Q?rxyOIY5ZkD4FTGsexPr66pwTeb8AMvV0hrbo7g2kM0updGjpTtfaR8RNswBK?=
 =?us-ascii?Q?Iw4utMfPW2dpVxN+pS+FKgUDB/Nh0d96839XUhOxLhGv87iKnfGjVUOUdAcN?=
 =?us-ascii?Q?QNjhH8QHF9pYuY+pD5+efGB7gqKARz6uKBN6pEFKM0Sgh8loCuJ6IJhVgcXX?=
 =?us-ascii?Q?lTa41xoxqMucxEXP7lpkEqj/5Smuo6TvG6OEM1hRznGtV7XtyDC7rQmwlooc?=
 =?us-ascii?Q?6UfSUj2Fmz53mAIH2xrHJGqnodpW8ILzfTU6u+Zo5qK5fEUvfJsYyEK7HhCI?=
 =?us-ascii?Q?AwQcrIJRRImdJZZKGrKXys5zVlO/xvR+JVA7k2mxKyeqVvdigPkI9NLyhFRC?=
 =?us-ascii?Q?9l2prG61N38uV3lHrakQYgdFco3tnldclImIoZmtIR2vPbuzDjzfeSnA1HwR?=
 =?us-ascii?Q?BEn6AyE0nYZTp33iqRI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa6379b-5f51-451c-a3ef-08db2e8c6bd0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 06:28:04.5941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnPA7hTJHG3kbmtomgr6W7+Naw1tqbyJHo+KLnhSDr6DDvFvKTmYclx+7xHrZTaD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7930
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series contains some improvements for s32 pinctrl drivers suggested
by upstream[1], such as
  - Fix error shadowings and improve return value handlings.
  - Fix print format.
  - Remove unnecessary blanks.
  - Use proper macros and helpers to simplify codes.
  - Refactor config param parsing and remove config arguments that are never used.
  - Use generic struct pingroup and struct pinfunction to describe pin data.

Regards,
Chester

[1] https://lore.kernel.org/all/20230220023320.3499-1-clin@suse.com/

Changes in v5:
- Remove unnecessary (void *) type casting found in pinctrl-s32g2.

Changes in v4:
- Link: https://lore.kernel.org/lkml/20230324143626.16336-1-clin@suse.com/
- Merge the of_device_get_match_data() patch [v3 1/6] into the last patch
  [v4 5/5, "pinctrl: s32: separate const device data ..."] in order to solve
  compiler warning properly.

Changes in v3:
- Link: https://lore.kernel.org/lkml/20230323144833.28562-1-clin@suse.com/
- Remove unnecessary type casting and correct type qualifiers.
- Split the previous generic-struct patch [v2 4/4] into two separate patches.
- Add a new patch [v3 6/6] to attach a real const .data with of_device_id.

Changes in v2:
- Link: https://lore.kernel.org/lkml/20230320163823.886-1-clin@suse.com/
- Use of_device_get_match_data() to get matched of_device_id data.
- Enhance sizeof() arguments.
- Fix blanks and remove unnecessary parentheses.
- Drop unnecessary marcos and s32_pin_config() implemented in v1 and set/clear
  mask/config values transparently.
- Put pull-function related cases together in s32_pin_set_pull().
- Simply use generic 'struct pinfunction' rather than having extra 'struct
  s32_pmx_func'.

Chester Lin (5):
  pinctrl: s32: refine error/return/config checks and simplify driver
    codes
  pinctrl: s32cc: refactor pin config parsing
  pinctrl: s32cc: embed generic struct pingroup
  pinctrl: s32cc: Use generic struct data to describe pin function
  pinctrl: s32: separate const device data from struct
    s32_pinctrl_soc_info

 drivers/pinctrl/nxp/pinctrl-s32.h   |  40 ++--
 drivers/pinctrl/nxp/pinctrl-s32cc.c | 282 ++++++++++++++++------------
 drivers/pinctrl/nxp/pinctrl-s32g2.c |  17 +-
 3 files changed, 178 insertions(+), 161 deletions(-)

-- 
2.37.3

