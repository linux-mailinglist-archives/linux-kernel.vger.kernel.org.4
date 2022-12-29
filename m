Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4606589B2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 07:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbiL2Gaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 01:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiL2Gac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 01:30:32 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C98BCBC;
        Wed, 28 Dec 2022 22:30:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVzUpZekvkFZlglABlM9Vhjbo+8OWkqjt6wje6CkPArnhWUQElQkYECx88CUcvHaoNdNtGTic8h8CQeAiY0kUKhwTo7Cm5jgtamy0CAB1zq1rhOHoen4ektlF1LdFfvJkTndfnJVwMlpmrOUqc7wiCTTHazDwh6xNzUfIt5sJJBrUT+Z+J0m93m7b7c9fSC/ZgxxUqd9yliDuHpRjkzj+yRb8RkAr+iL2TNaHcgeNiW80iIUEbwSXqiN2yYszZhGFC+tay0VboLfYD2kBn62Y99uWkmkLhGogKlOmfh2DRA3wxkinTEwVlG7uEuJe4o8nDRG0v1ALaXxkT3HZXehvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ym0tgKsmNuNBBYjB9nx3qvF5lf/s19DQoccHtnQUM20=;
 b=fFagYtS9S1DzMpU33sMnT3bBJiUwq5Gxv7RpWNvzPKG7TTsMcdssmMdEMp9Hd0owdCAnxLpOf0f8QnWYA2wHPriuc6yRFJzVdYibQbHWmi7J6ah1Awnm8e8Z9/pTLSwRhTyA7y6zsIppulspl0oDAbvUhajtZqAJmOyXXxA342CICegTh7bRkvlkP9LAyAwXZ4jkMgFX/lrCkw78EXCfqxwm8PoNGa/nN2UJy1I+c3sZzxHy6MMo+PAGqj4bxqT93kG93Np5M0GUfjfRCoTHyCCrBeoeqyytTcvPw4RObIROQ8oevppzN4qM8Pc3+9ZXOwOBAXlkZJI0OvKcngkSPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ym0tgKsmNuNBBYjB9nx3qvF5lf/s19DQoccHtnQUM20=;
 b=PWHZsKflLbHQvXAB1+PhHN1A/94YhGLYq3eRjKekvki9aVMqN6904kNjPbkl8C9VUYPstJffpGHvd1ON8AfdQwLpTH2qtlOE0pflxLEOsmy0fT0C/IN2MW3cA656D2b1gk2i8SrYZy1waz2pOA2rpga7f5RlebmR9j5SYf6X060=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (2603:10a6:208:5b::30)
 by DU2PR04MB9193.eurprd04.prod.outlook.com (2603:10a6:10:2f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Thu, 29 Dec
 2022 06:30:29 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c1e7:eafb:408c:6ae5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c1e7:eafb:408c:6ae5%4]) with mapi id 15.20.5944.016; Thu, 29 Dec 2022
 06:30:29 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shengjiu.wang@gmail.com,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        perex@perex.cz, tiwai@suse.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH v2 0/3] Add support for XCVR on i.MX93 platform
Date:   Thu, 29 Dec 2022 14:30:06 +0800
Message-Id: <20221229063009.2396716-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:3:17::29) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:5b::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4211:EE_|DU2PR04MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a366bea-99bc-49b4-0f1f-08dae9662d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: stfmuq3+X2getC5D4VkwXslErprkpgUtwV7LqFDTumaWYr0Mua0/LqrAlIAY21Cay9gDyrAk9K6dO9QcudXEq7AK7r+/0ED0OZgZkf89W253TpfS31tL3fnZGM5a5Ej7chvAeKSv5bZddcpPgOcNO9IyJfa9wMaKXKMH2mBnQ/9DJTEE13F/HwSDgEay8bTC23IApFkvun4MnYRuMXebErrEyGCb6wdgX0Na1Ot3ph/72530561Mshnzpr4Nl/vHoRPukMWrHPZq5IfuqxGGXJiZVC9yKCrdH4s2TVpcjkM2Y+OuN9J7M6lHPaglAMUZHT0gEH1rBLsjYkZW4QeoFJ4oENwDejTjCChZDa43jmOfWGHtL9ljkRMPiJF22MVRpE3JmqMrehSdfpG7dNISVfZvjtSTnpMU4d8bw5s0boLIR2XWXO1sNe4yU3Qnte+Yyk2EM4MogIqawQM2Eet+y5v4+XME/vmYJ+YDHGUrhg8XFGEvXwM2u1rRP8yXjR58rkxPxDo9cnXU+OiOI8b8jdAnj3I+V23+9Aq4F5ttn3KJfKMTkLajVngpBycdhHavDVTXEHSVArZ8xVedBHkq5y2Mmfq4yKn8BnJratmyZh6XUAvo9EzgW6vAOncUG8qkA3+swOoU7aFQ0blU8a8UPgRTr+1zgCwk6VBlUSSZAss8kDdOriwE1j9EUf3Ybl5eYZVfOsknhvEs/xAqg8tWLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4211.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199015)(8936002)(4744005)(8676002)(66556008)(66476007)(66946007)(4326008)(44832011)(316002)(2906002)(83380400001)(7416002)(38350700002)(86362001)(6486002)(52116002)(478600001)(36756003)(6666004)(5660300002)(2616005)(38100700002)(6512007)(186003)(26005)(6506007)(921005)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?izbj/GOhTqUNLNFQuOcvZD9A/RWoYfTNiAodvTzpJuRm5yUANCwv58lvfiOp?=
 =?us-ascii?Q?de+aPvqKhlt3cdZpiyzhg6uFAnoZCMjgRkjpLXbnI7m+sJh4Qi8pAYb5FYYc?=
 =?us-ascii?Q?mNfaedh1P7nGH5g6AgOxUlXklX6GR/+NYW5jFz2dXWyW/6VCiqHHrWnd5Bpq?=
 =?us-ascii?Q?QI17BwlftUcMz3TN3roE5GXpPT4dHItNBURX0+BvBpFnRM7mY5VhbYkUNojV?=
 =?us-ascii?Q?odQx44GTZqr2R47d9vb5Z4p0wQ4rUMIZB5kyBWGZzDkS4hURvlPyb6MCXLY/?=
 =?us-ascii?Q?7xquBKbN9t0KL4iPkd7CsJvFYjDuc4C1luckLharU+XDwBgs1VsoFvlJgeMx?=
 =?us-ascii?Q?JHbGWSHzqSImPF19/9cisM/cWhrC8eqjXHhz5JqMoMZhzy0rB1gP3QHglhnU?=
 =?us-ascii?Q?H9Mnb1oyOCHL0aoC/JcPtQtXxwacJ80bkOaauAnqBmqpVaUuWJPgMRoYnzEE?=
 =?us-ascii?Q?sqG7vtagpO7Mwxj/9UfU4JDYN3G962FsUfskcjCc1sUgezrTuU3CKs48MkSz?=
 =?us-ascii?Q?hw3CqvLZtQZWrDC4SRFUEKpW9EX4JFXiruMFYvROywgeqOYbkCzsVKh0WCwa?=
 =?us-ascii?Q?EWd+/nyZvuPDeezuLuK40LE6HpKqBb0U8w9xjUA0drKvlCNCpmR/Y0FgQv9T?=
 =?us-ascii?Q?SeffWroDoYYQAMcpVsMVEqoxR7XvYlSw/btDPloWUFNJLbXMIlYbLByuU8yT?=
 =?us-ascii?Q?rTPLVUtCIPpatGEW4at+slk6IOKkPNxNeTBgCiQYblFdWCGjkS9xc58zsELB?=
 =?us-ascii?Q?InXgTh0tAvzlBBL/2DRQ6s6PbJ93RPROikpi6mL7H3Rzxw6yPCLzvYT/pvYG?=
 =?us-ascii?Q?IEuYdQ6VKC60CNCtm6oww6r37TIOYDI+VAzoD/P6nxmij313VKXlUYm8ZtFH?=
 =?us-ascii?Q?hPt81Tc3C9KRDoNp+RY6yz0sxFVoIVJzLisiM6prTtvZzRgHii5MVOX2ShTb?=
 =?us-ascii?Q?3zL488sMAQ93b+3h+9oAjTQaQyPKOqz7Kj7Rv/ITJtjq78IKTIkkC/nhRCZi?=
 =?us-ascii?Q?TxJ7ml+xdQWIjlRxuJ1/YgbEJ8lXHxAx+zxISfeAvz2WCT6IKQyZdtvT6eSW?=
 =?us-ascii?Q?Zn/Ujh/jQd4jK1xkFRCTeaoN5yn2iutpV328UDEO3bqx8ZeJfB1TtRAPt3aF?=
 =?us-ascii?Q?zp6fynzQ8mo+/BjkrMXqlKHSmTmLbqctGWNMpQKoJmB44O9e4ZLgBFfY3u5B?=
 =?us-ascii?Q?Q3SmwLtGkyIkLBSBsFbqBiXHJ3aMB1MlYPNiR5t7IemruRzRh16WpVReicMe?=
 =?us-ascii?Q?67vYH9yoX6i8e5zkiKqmx4egp3K9PGJjpC8phMw/LLemruoS1wtxv89Urz24?=
 =?us-ascii?Q?mt0G+uZSJ5kuAOxgY8qLZy00DNisd8v9v+5PRKv4vgM4CQgUvDKpFYq3cSHX?=
 =?us-ascii?Q?97JnLKp0TX0mE07nQKqAq7dmBsE9bFYzJ0U3GEkfZU5gTtwpa9wxjzQfklK0?=
 =?us-ascii?Q?dwCG+xw98s62olUJ16by4rWEwtmIyEcFhFwY7agtJgV7QfOZ3ZQgf/FSR51i?=
 =?us-ascii?Q?hO7Fmmf33ubLYsPD7O9t03/LGP2BdHjipN5OpO99+lPlCqZgpvguUMmYA2D7?=
 =?us-ascii?Q?zOcgonvKUKjS8G2U9Q5oqT/lJkwvEPhhzbCU6Up6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a366bea-99bc-49b4-0f1f-08dae9662d94
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4211.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2022 06:30:29.0085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwEMcsu9aJx7QtKXFZTEK36cvb0/szC/yyhxxK2eRqrB3l05Jh8oz2glM+bekAmQbXY0SCylhROEU8CoCFpxRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset supports XCVR on i.MX93 platform.

changes in v2:
- remove unnecessary code which causes kernel test robot reporting error

Chancel Liu (3):
  ASoC: dt-bindings: fsl,xcvr: Add compatible string for i.MX93 platform
  ASoC: fsl_xcvr: Add support for i.MX93 platform
  ASoC: fsl_xcvr: Add constraints of period size while using eDMA

 .../devicetree/bindings/sound/fsl,xcvr.yaml   |   1 +
 sound/soc/fsl/fsl_xcvr.c                      | 155 ++++++++++++------
 sound/soc/fsl/fsl_xcvr.h                      |   7 +
 3 files changed, 115 insertions(+), 48 deletions(-)

--
2.25.1

