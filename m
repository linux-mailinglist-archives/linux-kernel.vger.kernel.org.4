Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1C268062E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 07:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbjA3Gro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 01:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbjA3Grn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:47:43 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2072.outbound.protection.outlook.com [40.107.7.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906CA16335;
        Sun, 29 Jan 2023 22:47:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLnHRXeH5i3SWs9k7wg9QkbQIn+D9g1rAa8yWciWVZema+tlGXbuiR3Hx2LCC8831BjgRIFh4jTBT4oP/f/cB4X7BXYSLLJC33KB4+OPsIZER3/xQ0aGIu8TcKZZRK5/5LUkvP0e0aGFDW1LLDLoxx2GPrbmzUDH8epgsSCqp3Q3cb30jil0sQmhd3O6xF92O5k1Z8/aPIdkBVG9f8FNUsxp4KWhQJSaA3NKLCihuLcNVvx6KAH0EJeSQq0yj9mTet0i6ZvW/pWdQj4r+sQlnD3NLaC0bU0gwhU/n5o66m10st944F+rfnLTcMGS/GfXlSALq3KObkVhtG23z7nuyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/wnbMquvz8qH1WLQr4U66ejI7/J5tcEUwkZYXVgTWY=;
 b=EEyX7bmSc965K13cBMZceylkRN2gPAACmXgiFDVoBcCHN0v6z6uldNAuvGdZd8LhZ+eesLCuN9Gf3uDj8WqoHLjfY2z6SueFgf1OSUB+a5DXlBtcNox8ds7y5EG6BIjy/BGqiuZWU57FT6x581XQKgjIKAeXAKs5UFJ/XFr468Mcgs1blrKl9wq3tzRf1zM4l+W/g9md8ZWrMQM+YMrHX6A55eSZl6nvgS+LNHYTPr/RCxHFqX67glq3aWx4YPPe+QOl/f7TlPgUE24JHKA5pf5/igh7dbHN1YcE76DWgN97KOE2U2e+Ty24MzafScUnFk0CfaRjY6sWLMKT6t2IPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/wnbMquvz8qH1WLQr4U66ejI7/J5tcEUwkZYXVgTWY=;
 b=R9JoX312iv1q/UoLun5kpOTZ6Rc8wudI46SooD0ZRIu/uwAOT8400VZx1sADuoiWcZ434zXvAz5Z0die3FBPnqmqoBqQMev1aK7t/OdIS1hKqRnmkg4EOOzsCdjfJw3UI8OvDoDoyJV9FxdIklHZDLnc/7eTeK9z1dtJB0aShig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PR3PR04MB7289.eurprd04.prod.outlook.com (2603:10a6:102:8a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 06:47:22 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7f24:bc0a:acd4:b13f]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7f24:bc0a:acd4:b13f%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 06:47:22 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 0/6] tty: serial: fsl_lpuart: improve RXWATER setting and add imx8ulp support 
Date:   Mon, 30 Jan 2023 14:44:43 +0800
Message-Id: <20230130064449.9564-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|PR3PR04MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: aa200c9a-c08e-43d8-3292-08db028dd6a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QFnRkEg3bcfr61oo7jeYraciUzy6V7KYGy+lghuLiatIOJzz3YrrEexwfUDzDEH7jR1AXJFmAP6I9O/3aQKOQbN978fTCV00f0e4htieHs01+clyO6sAtL6LjmUkFhOzuGOEHu1PWu8LnvJNh+xyxD+YkQgQQ9KiVTzLiBI47/H8hQf8vV2KJ3PVIEK5ToXw7hPBPSCnKbQJhmlIwBk0LCXvTlXLcrBKWGonhLro0sTlFTD1NRDSMYEqGC7W/XfXw4dul3QXbMLjJPjXx0FekGhIgwRTHLRE2Y3iTkmYickFQJZ7hMkWibj4HcUFKMUeGA9IcTyxPuSziVh8jdl/v2AU3S1X8X8dRgJYJ/GwgD3IqUxCFThYlCdxbuGY0407l4y6XX6YZ94OG8oVhnTqxVv28IbCogDUId1J9Ys42+CyowNwA7qt1xMYgw8XA1F9B+hamv+k/48OOEoZI8xnRONTwbVTXgDVGVXa3uC5jIn8muMDOAq1VzYR8IfrfZHJY2XUyfM4e7AxBHa98UvvlmBJH0dgAs+BtmBBFOFlRm4ww1RMvTNXp7o4hhTYTxJ4iQzXzyx28b0XBYJiURT4RyUArBatr8B7zBXYcj+GG1hVJ/LIlQg2hLvvkC94OGBgF+RGxyXA9QmbXsU84c6oFp2bi3RarDmuJEaXpkuQxIDMJFUVf4zndFXcyR05c7z1x3wCiyG8HGjuEA1U9NTTAO0WMrBVpMgwV12bFU7cTI8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199018)(38100700002)(86362001)(38350700002)(36756003)(41300700001)(2906002)(6666004)(478600001)(52116002)(6486002)(8936002)(5660300002)(316002)(4744005)(66946007)(4326008)(8676002)(44832011)(2616005)(83380400001)(26005)(66556008)(6512007)(186003)(4743002)(1076003)(6506007)(66476007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2390Oa6AEy0cn38PmGP31ST27ORQZPXVqwIpL5TGa8UmF0GYS/ElC+zUgt/p?=
 =?us-ascii?Q?yTMeiJaxAR3KnVoAG3uZVxPktFZ6FcD61Y3FMIKKA6ai4++eBFa5KUEu1cWN?=
 =?us-ascii?Q?XKUa26/fz5BmyLNzCeB8E9HbhUjzTfQIo7pyLuiG5WOIrjeL70wzbs3ArsFe?=
 =?us-ascii?Q?Sw7QgFBERPsSjl1c+yZJI4V46KkU8F7Tdq4UkJoM3txDm8qvXtjoJeXxEko+?=
 =?us-ascii?Q?2dApRyi1/d0iufopqYLzEhNiMZUyhJz0id/gR7wWxT51rzBQJ+Tl+hdxY60v?=
 =?us-ascii?Q?7iOoLMS44B9ZbQ0Z8wK4/k15N5acAK/jylvVpc+UFv8tQXoskV9xm+UN8Dxv?=
 =?us-ascii?Q?gABNUmQwntxkN3WLHxHYDSvFoWysdYnlj+YaBGIkGClWIH9uSyn2uRxsPYAw?=
 =?us-ascii?Q?qdj2CKxt12Y/J+NwFGswpPMpQcc+xXuow/qmOOPYVTEHw/FW3L6Kf5IgSvK+?=
 =?us-ascii?Q?NZsbU2FoRPsIll9B9p9QcWsjOh2QwhvdH7thhyBrwN34AJJjqUqiJ6TILZmw?=
 =?us-ascii?Q?tcmyQaC3bU043UNR08aZg2nwqQkDup01Zpj/IgMV0BeSabxApXUFQ1Oi1HWh?=
 =?us-ascii?Q?CHe5gfVIRVdFY03QmG2Fa184R3H1fOHBI9q/Bmgef1EQbk4W3/zTP6fCdHFB?=
 =?us-ascii?Q?AaZsGHxgHL4nTdLR7gyj9y2yh0XvGe4wP1NeX16nDXfuYD5/jmjO+rMCM6m/?=
 =?us-ascii?Q?CKhr4KWzf9JP1E47lHXnR29X8AVoD0KVCYhTzBZxtOTYXZOSzNFZVY4TLwe/?=
 =?us-ascii?Q?XIpwqWQOerFGJuKKPUDQsSgw8BRucG5iKq3buKC5MFdJAvFudxDqhrCgOczr?=
 =?us-ascii?Q?zsWeoGwldiHAimVNeokV3sMV0sb0U8pnWWhICeDT3NBhWmZUDnO1ETKa4vyn?=
 =?us-ascii?Q?kcGiQSMEcwZZpJpWyzVY2awwh0mYdAAiGUOEpMkn/VIRHGEcRaDDlodE0AaP?=
 =?us-ascii?Q?FV0U5Vuw29QhpvTGiSd88n7m/Sf29w29l1wBiyoIBX6yvYI0UguXBlMcAeu2?=
 =?us-ascii?Q?LhTvmZM+ceOzsKUD8BT2qVXgpsjXVlq5ytLXBLcCOBn6BnsNjUxmFyBCeT8l?=
 =?us-ascii?Q?dimH4Jcv4njOT8gmbYB02rbsI8ncJ6ZRfbu1fGTnh6Dyexut27dceMYsnjtm?=
 =?us-ascii?Q?Qssb7LgDBLi8xVQd3XdQxyM9NeS5DQ9wTcXhmeOwmZbNPWiHzV0GWJswtTUK?=
 =?us-ascii?Q?H1Px0uvfVjzq3lFilDoI7JjEqqqqtfwEgn4O7cMKY25bIBx9kLUtKDYlsRWv?=
 =?us-ascii?Q?7Qph7Hjnre57iRnUA3oXzaict2YI28FirignOUY9yN6qsPxEZi4kd6ngdx+A?=
 =?us-ascii?Q?i2qLqRBNXBwvwHoMMu2nHC5rqniPdfyWiyCCaa2m8/ObQHra72yq0xeRW6qZ?=
 =?us-ascii?Q?Bhe8evODZLXpslhbJlfSywxWclydGECd/gw+lOG3Rbct14YSKeE4yCjRfaXs?=
 =?us-ascii?Q?3uw5cYJRu7kcxnIHIJfhPhz0CyPccviMsCfeXBNlnJghx08a+25ZZS539sig?=
 =?us-ascii?Q?fYJAIIjFaILpPeHlYaNfguIjsL0Uj9nJCUw//fRxuM+IE1diTQyWmYQU/Yzi?=
 =?us-ascii?Q?QSPf/9YonOIKWYFiHkUozm8MBmazMbgv7yAlabkO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa200c9a-c08e-43d8-3292-08db028dd6a3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 06:47:22.0846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+Qv+eTGvrbsUpBUk+2zI2NpfuZjDh6/oZ/FyCvKUmrADhKZ8zsx05PUtIuH2aqRSnM15XQuu6rd3xAdtEiTEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7289
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set improves RXWATER setting for lpuart, also adds support for
imx8ulp which has different rx_watermark value with imx7ulp.

Sherry Sun (6):
  tty: serial: fsl_lpuart: make rx_watermark configurable for different
    platforms
  tty: serial: fsl_lpuart: set receive watermark for imx8qxp platform
  tty: serial: fsl_lpuart: Fix the wrong RXWATER setting for rx dma case
  tty: serial: fsl_lpuart: Enable Receiver Idle Empty function for
    LPUART
  tty: serial: fsl_lpuart: set RTS watermark for lpuart
  tty: serial: fsl_lpuart: add imx8ulp support

 drivers/tty/serial/fsl_lpuart.c | 50 +++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 9 deletions(-)

-- 
2.17.1

