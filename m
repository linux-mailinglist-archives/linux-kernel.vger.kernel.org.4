Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8822E74CA6A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 05:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjGJDYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 23:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjGJDYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 23:24:25 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2091.outbound.protection.outlook.com [40.107.117.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ED4FA
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 20:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUh/ihRWK4xW3J/S4jGah5VrCYWDFxK1OWJjXa7hRC/OUJnU6XEnaduvAhn4Hr6FlxocsgHFjfYkwy3MyEoklHI0DnTZt7uEEPnLd2UIX7JuJlYTzHDB2ZWUV9Jil+TNRpRA+TZXPKjzjO3SGiinnWtBnz8D+lsxgBy3xWVxMwKpTkzJOsynC9nhsPdLVKdI+A7vfiNPBNe5jS16kCIxgp7pRMP4TIaw6w3A57+KvQDD4VrUo4h+lEbAIBsq2ckEDmvKAHMcPih4LdXtb+CS7ADjhrCfeXEFW2U80+X04mQd+okwYXYh+8ob9MmgCew19P2pIM3rpumId8PGuV34Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VHd6o1KlaeXRDzheijeTO56ksEWDi1edEW91oDjNh4=;
 b=KYvpsJIFp81q4Rm8yfx8wiyXcsfdg4QEhV02lGWUBHkxzdrHnOAPEDg/LK1Sn3TLR2wE5Ppwy4sg/zfxYgh1qi51xtPLNrLEJ768SRx6zLXOKOVukoZRKMAPR42IMhzeyGIjyyj3yep3pXnFo/HS+fvlV5yGMBlRcvT1zFfgT5a2TWoe8yoK4YZcIUHPakBdQ2CpN2JcZHuOpYggOPsyS6I9Sl+u+O7DKOpCdi6dm2fBiZaShre4t/teOluxYNXm8DcVIsEaAjOYr6Lfgo66oLNnrBQp48G+ulIytI333aTPBSKittZrclH7U9kKjdtqoRGOHu1kpVYWEJCd5M5YhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VHd6o1KlaeXRDzheijeTO56ksEWDi1edEW91oDjNh4=;
 b=pDaWgdm1xZ2eDEFkCtFCcEs2Pj7kWFGUmqBbo3dd7GGY4KgK8THAtRG+++ZEor6isYlrwoVU0/2Tv6Li6jtwGmDWJv8M/EPhVk1QLAfrYQa7OTS1cCX5dNxowziGU2GgYGe7BDtopy88nbR24jTYOEZC5x7As5QJRJmb5JZD0IjOTV+3l+qiv9J6KYyhh/T56C6Yj64lG1n+wNDfv01ynNqk/IV/uMkk2xK4uG3KNRhICe47TIAwiKuEmCU8mCuf5HErfWlB/0iYOEl9QrU+EU+nhiYfoxgEh0CawUOfn7MSn2a5lQnBS5MxiEvsOkiqEoTvycSjrk+7/EVrDtalng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYSPR06MB6472.apcprd06.prod.outlook.com (2603:1096:400:47b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 03:24:22 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 03:24:22 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Yangtao Li <frank.li@vivo.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/19] drm: bridge: dw_hdmi: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 10 Jul 2023 11:23:42 +0800
Message-Id: <20230710032355.72914-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230710032355.72914-1-frank.li@vivo.com>
References: <20230710032355.72914-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::32)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYSPR06MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ccdee01-41ff-4c15-a101-08db80f52774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jitNmo9ZvTayjMgJeeOGQnloNoQeFXg7IhlS3e5vwCETXorcJ4gpNGnwmlJk4htL/42jYXmPLRq5kCfpTDhUACA393yUfNau8By0cOiBBa0hxvvDZ0f2Bf+PjEKqhIU7WL7gw9wZIPWz+FRWeDBMe6y7jCSrAxLXUKpe9uoCrJDyb91zLpI3Nv9hoPLNyxUcxfnl7iPHsxu+xReldVgj4KHhj2zezNTWcZaJBdIR8WEyCAF1dFaLvEl/+6yVPcgpkrfblIzBFDEManMTeHYBcg6V2L/FxItyRtjHkB+RtNs/QnV/BtpMblW7uMnt2Ltrmu16sscF8DLdBjvX+ARAmrYXTTDl3wg8HjBAWMb0X5tNTMHoDU0BmGtqJQ30eR52aKc4IiNMLRLWjU6GKycUGaABR9R1nbaza9I5YI3hSuyUGQ9p0Lo29qLaCJK89p9vvIq+RlUNxGv+WtpesH+klH/mTwGOPxpA3kroj/uewPY2ciqC2zMGdEXWdL+8uWbJSbzPI+71Ah+Gs/BGwdgWs6XFeOTPFtlwO79jmnnFAEQpqS9YTQoOypUR3SQXiF4hZ/ww8E+ARFQqXtcREU51hMFU9ONwieaQujilNqoIkvspqSxI5xS9tUfdH2YQGXEG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199021)(186003)(6506007)(26005)(1076003)(2616005)(6512007)(83380400001)(4744005)(41300700001)(4326008)(2906002)(66556008)(316002)(7416002)(5660300002)(8676002)(8936002)(66476007)(478600001)(66946007)(6486002)(52116002)(6666004)(110136005)(36756003)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U1Sai6yJu8h5n18DeWz/WHmvVEb0FuKLoxwDBnPNFZVaMwauy3ZFGsHl9r3r?=
 =?us-ascii?Q?RS43Fqer6WQtjoW+eFLDr/pcElnibSa+2ZR0QSuTl8yhChoMo1dfzF933ARv?=
 =?us-ascii?Q?YONHqfYzlk60gyY5MRo6WjEqLnKKBEUllkpHKPlrj721BhPu0l+5wynIsVU8?=
 =?us-ascii?Q?Psa0dXjWIJwlUQ3qyAnX5xY5Yd9Nh7UdxWNcevMtRicXUJGxEi8kiCCfydkG?=
 =?us-ascii?Q?i1JrNoMuG9s8LESm3YIkQp1FHsZFygWzs7/2B0HzTtfE6iTkEV/8Hcs+lZSW?=
 =?us-ascii?Q?5GnjBaAdJaN1dPODT9lTsm2yatxirhIQImXUQhuOl3U7f6MnUBKmWq3hyrAp?=
 =?us-ascii?Q?HqI91J+OWKnBu/YnDt88DmesNwBCfuPKMmasxrhCOSKbnEMtZwSrJPSFyoI8?=
 =?us-ascii?Q?E7KC+iqcYtsw5xZFVR0XpeBPWxwejy9zIoWmzKDK+FHLVk2HIzDrIIZRvR0I?=
 =?us-ascii?Q?7Wssz4PIfRoZcQt+sLT0tp/gJtpQqhzyW/dAusurVugbPW/kLg/rJ3pZWwTN?=
 =?us-ascii?Q?q3hyWD56jm5+U5mORyCGa+vCSX+qeuTv0f3j6PZqS1/xLa/uGrIK8U2eWT4n?=
 =?us-ascii?Q?qbKue7rqw0QuHvbgoYoUcfgj9Zx9o8Afi4mdecEHpUUu/qTKUkvQLBRe3w+6?=
 =?us-ascii?Q?CUEtdILSKlFmi3J2UlNPVa5F9gLhkm46803GAwHl5KPZT0U4K6kfniipZfWu?=
 =?us-ascii?Q?A7WeU2RjXF2ucKcVjan6qTSXwD3QApKvYZAySxLIZMF84WOmFA2BwOisdCm+?=
 =?us-ascii?Q?ct6dZAJaqe1wBjZZoAfHFnYdF1aYu0GGxy8eFGHtEL5eyBD7y1UpSItE6KrC?=
 =?us-ascii?Q?5PbVw8iK64CMDaOXHpZnZez3NgCQAzGvtHIlOukljQq9OnmOHQDx1e+Vx8bg?=
 =?us-ascii?Q?KFjweSEe4/kn4Ik97oa5A9Uz4lDyOxGgibpLHYsxQsEPnIhnJeCvtiMKVk/w?=
 =?us-ascii?Q?mBwpf+GoLtB+9JqxGb2lfsxAe8Xp3gQBD9T3gkwjgUqQZNiOK9DAdQriCMXJ?=
 =?us-ascii?Q?VPJTaSG6rbu0ijnCEc7Y83rkrxzluUDJfX58GkGoKXttSdfuvOPyJotBTSPg?=
 =?us-ascii?Q?S/Rxxxhc9ocRdvPp2CkBWbfRnRVSU4zpucEUEkJhrlhvY0MXophs/r1I+OUO?=
 =?us-ascii?Q?wvYAwDPjr/8vfCbDUnaX+KKC9EuLMePUnLlZd9v7ancfTcGXnQ2nIKeRXPSq?=
 =?us-ascii?Q?VqlhgZJCBbi78Qe1y3TVrJP2gja0PXZTUxtp6z32C7j6ZQ5jOalSm33BnqVS?=
 =?us-ascii?Q?1QRMMeNHkNYF5wDSYZYLY04RXapAUh+udKzCy5xLM/7Ov+J52ZGbrMFDwqJf?=
 =?us-ascii?Q?M7XJ8ShDpNEEmDdq831xSVdVPcip0IQEPVieaBJGa7Lk9Wwl2lRvPOBt00zn?=
 =?us-ascii?Q?WBNOwNm3mRvMDObSZrTsNUD0bTvcoOGJrmbMpML7hdeeyIlePZ/Ebm3fVBH5?=
 =?us-ascii?Q?25Vc8wi/Bq9Cpp7WBfe+ngeb5XJLYyAfV5gze2AVN75uzJdelD5gAJEXjjkE?=
 =?us-ascii?Q?VPKdj6lAilCCBexg0dKbiUQc4gu1l2xpe//FwEUEjJ1jGNLi4c/946pMKSB+?=
 =?us-ascii?Q?fi2IV0NB1aa2IkGVR9RT6xFUU8oOAFiyurb5LLQX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ccdee01-41ff-4c15-a101-08db80f52774
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 03:24:22.2681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UbRcr3wwFP9PkOyT/MO090GS9o8TO8l9jjZ6w2h3Zd6XJ6jQ1ABs6i09zBT/GXyOc1ZyjTHTq9DbuU4kyWe+wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6472
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 7b66f362afd8..b2b320ba2196 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -3417,8 +3417,7 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
 			return ERR_PTR(-EINVAL);
 		}
 
-		iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		hdmi->regs = devm_ioremap_resource(dev, iores);
+		hdmi->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &iores);
 		if (IS_ERR(hdmi->regs)) {
 			ret = PTR_ERR(hdmi->regs);
 			goto err_res;
-- 
2.39.0

