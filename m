Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0EB74864B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjGEOZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjGEOZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:25:05 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2133.outbound.protection.outlook.com [40.107.117.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A8E26A0;
        Wed,  5 Jul 2023 07:24:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjRnPTxKUYVUDb5+pWsYDZTtF5Rz29q6SRqE3qHka3uzr2WawAj8BMMxJRlcn9vdt7fNhjhfomaUbnYfgcZZrRvkfUOtro8Zu4lm15swnvWaGePYqvEmOnpM8z0rRJhM7A0WdHru5sAEtMkQPuWa58GOpPIZWoCllHdWcptNfHwi1X2dnVWuP5D/cAY3kzrOH2nbV50VkfeJ8S7RBXINPwyezCAL+2PzsaQ17uibYp+qaEDlF9eobLypZLJIJVGi7UY6Ks2SCQhjWxf9rj5FhB49R9mzElug9PY6u/Hetb+ui16h5PcaH1/0HkGf1TB4uuJOdEknlNaoJx089Cpl0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdRfup+/WpNpdbINDMZVoORaLPUPldGqGyYlWej5t8A=;
 b=AQEKzJM4s983s+iy1MQ0mHBTViRRViwsn0f7m/3ONM0/wiryH/VES1wpFYeleg942ArTpc/SxxOZ1kFH+9TFDY1R6xLFUdQAbc6nKYiGE0/OrC/SU0RbAPyFpqo+CimhA0i9W41SMP6c2P6eS8QXsPDUxFaMJK8i0j4T5JHGq+Mdn53mo6JzW/xPg4OwWgIwbknNV8QtvCDlww6IdBdw6Q6Wnnp0CCHHCcrnoM3Szu1vdg0SBRs5RHgpl5SvzL/J5WGyFlfNPmdWSoSz+LTtM7nyM/+8uEzJi/1r0l7j//F13QUiOPF6GDh48fdGskSA5jPz2tTZvFNItHNaH0mGow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdRfup+/WpNpdbINDMZVoORaLPUPldGqGyYlWej5t8A=;
 b=IsaXlW3X/fcBJlzgOCAz4mfORMsYdwaAGHxTpYY7sdcYZLZij1ac1MWJtJBuax4BNlX5+iCTAwb4HCGcQemWUMPnvh4c1zmxyaNDslqqkPhgqkROevRzm99cnlFE3RvYVW7dzzxxs5k6M3BSwWgZv2QFtIMbzHkF/nIoEQxhs5fb3LZDAjKOXNag8wDYF/JBis89U4tECZSbrB4lYnTLv7Qtxtpn3IQ9nFL7sqBLoeXBjfgB9nB1El1pcIUd6Wz/QT6aig+eYVWd8CwiWM8+w3Z6c/oyB3kSQjMslvKRBAZXNMGNrYctQNZ018YR+N92vjUIisVpPo7WNhv2PMovKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18) by TYZPR06MB4335.apcprd06.prod.outlook.com
 (2603:1096:400:74::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 14:23:34 +0000
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::9531:2f07:fc59:94e]) by PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::9531:2f07:fc59:94e%4]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 14:23:34 +0000
From:   Wang Ming <machel@vivo.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v1] media:Fix repeated initialization
Date:   Wed,  5 Jul 2023 22:21:31 +0800
Message-Id: <20230705142142.3526-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0056.jpnprd01.prod.outlook.com
 (2603:1096:403:a::26) To PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR0601MB3737:EE_|TYZPR06MB4335:EE_
X-MS-Office365-Filtering-Correlation-Id: 8838d06c-a76d-47f1-acf9-08db7d636a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y+SNIrgyz5aGWn9G4IzREAuVwsBCZtgphhhFJ5Ba5cOneAgiYrlyhYA7H8M3xnxUJSgEhLW6nyDiQ9YRhXBPNMWZOqZqGY8E1xJgOb9RuZ2aVcpCjg4MW456xxQzNfq3ih2WxG+2MOfb+h0Jx4Rs8g8cOczg68KYGp3D3CUmvFUOuOIvvo5UeKBLpffFP4yg4aNDg8rKkbR0sqRdezhPc7f2VfPmlL9FX+cjJU6BQvKWh4UgonKb5wyLMbCSt+NwqsHyi7KhCL3U7+ayXnp0gKfBkVeCBIdTGweqwIqY/opqfO19MWjJLjqwZ0a1iDxwrlzyHnNbzng4Gs+9v5qrmRED17X9s/+922q/SGANlOkUTvyPWaofeOGXuHFbaAB1qE4ViCUO1q7EmOYTk8Kf53jJ8YIrhlo2kCaYy84B4zKG8fSaB/zunUyR4p0mgg3cqxu0QdbW4Dg/a032797y/gT/exBFPOMEbLksKQM5ao/D95xA8je/tOoCsaG8DSDDgeNtLZ9xDqeCLUHqPW9Tp7EkYvqpC+z6nh5DXkDEdZTOKg69PtyO0D7IHAa4J1LZLi8D7iDfcATMf6nUysbklFOBbFqBW4OgI/zAxQ9o7BgCUuWYueksonO5Df4MVQFe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR0601MB3737.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199021)(110136005)(8676002)(8936002)(478600001)(26005)(41300700001)(6666004)(36756003)(6486002)(2906002)(5660300002)(52116002)(86362001)(316002)(6506007)(66476007)(4326008)(66556008)(38100700002)(66946007)(1076003)(38350700002)(6512007)(2616005)(83380400001)(186003)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MFn0oBIIkv5/oRFTxlN+04QHfTqWx3744Nt70vCDSoJ1HOXvQFubAxSOgK4D?=
 =?us-ascii?Q?VBki54K4exrr3pcWJxS68gTQME6I1Ed/fynWvxX2iaOcYR5jIzmp/MI1T28P?=
 =?us-ascii?Q?KqRZRhYT/tuiIMWVh0IxCD34CvN+iy3dbT0WMgBhrq43W08Qr/PS1NjPA7Hk?=
 =?us-ascii?Q?kYbwcUizpuE40br9WAdodbeoEq8ZoCz062LR4UQ80v8LLFt5HfwBBU7/WEEs?=
 =?us-ascii?Q?xHak4F3nw5iZjTXiPEroG6iRiN+/b9zJjchH8oRAAzzmqXit7vkBh984wrv9?=
 =?us-ascii?Q?tVuKigM7zfJWhSiMdCMbiMyuTikfQZWYHbLKrMlGOSVjve2F9o6MmM/89D93?=
 =?us-ascii?Q?i/msCPw9X9ev3Uu8SjIkDxqmB0RTGgRAHXapOcchOhwzqNz40mzJgCnjixhe?=
 =?us-ascii?Q?oI/loVzeLWhwUyWNE7702sKm1bLNclBMY6lqOffcEUElETEa+dSYAX2+VTbq?=
 =?us-ascii?Q?j+u4f+eg87LWEPVu6Y2wnM+UXo9+7j07h38D1Igk/bxmAI98/zuNRcWDaTuY?=
 =?us-ascii?Q?ZeWVt//twF3bu5RIMmpUzN7UZr7izKy2WAz2P9ZXNn8hYz4D5iMELLNOBRjf?=
 =?us-ascii?Q?aP/INorrMTQzmcEi9is7nbSP5j1yqX/x4DXxcvHO0wK0c6eD3aPE+HuDEAod?=
 =?us-ascii?Q?+5EEsKgTPcZgU6DhiU5j1oJzC/Z4LTgc6ZysRnTWvAwj6JKCluKy/jjVZc+O?=
 =?us-ascii?Q?fHhOhKlyoWAE+OL6isNxUeJAqnZDqVNRQd/Obwx7GzJypeezuaHzfIO2SQOh?=
 =?us-ascii?Q?a0cNVGTnkZyPphw2mfoSMvit6hrEQ3Ku/14V0/43VDeTBo3h1LG1i8jBtIFh?=
 =?us-ascii?Q?CKR+5rIFAqxg51YFrdpQIBlsbYdsM4+FVYvc6pTl1By85SM49il7Yx1fpqUm?=
 =?us-ascii?Q?ALTn/kT6JXFXJV6ntCh2Ngk4LJFbFMBmObTk2WLEJ+Jln6Z/YC3gmeLII+j0?=
 =?us-ascii?Q?gh5aV4MKLlytVvc1dTcIL63kcbtPufixLKN9bJxKCxjnmo/u0S9jPKQe3wEA?=
 =?us-ascii?Q?JUJTqHPukqFhvsHsgDXOzpaqw8FANLQBuI/kdLT6Qrvo5+XO+I+pKaPk7UOq?=
 =?us-ascii?Q?2FQg9eaYMaLvXUdLeaheIM+Fb5UKM91UExOagLOak3s8eyq5xk6c8Lf0NSit?=
 =?us-ascii?Q?KuP37sti+DIHdEEGKelv64FK/LoxJ2XMUmZIVnN8tfBcw5Ny398DYDKIZc8H?=
 =?us-ascii?Q?kUJKLOkvp3RxKYz7ZSlAC91u8S8D6ZSgHWsBfandN+0I46RBX1xcuA6BkGrB?=
 =?us-ascii?Q?4uaaqY4ssAhHsfhYt3kcOwXe+O/f2abQFSDWT9VlX+mDeXE8t7jfVwOezlrD?=
 =?us-ascii?Q?d0kG3SnhtjfgYk8cUJ9bVbBdpkfH9NPoTThUOM4KgmyZ9ujqqvnejRergasj?=
 =?us-ascii?Q?Huhi4MLql6qHX0cu3Wxeib/F14agt+L/em78Ohrn5z6X5ICVCPPcvlF/39An?=
 =?us-ascii?Q?07MEuuPc1v75+/b0W3JiGlmZQMs5E6Una4DZy7Mcesz6N+DU5/T5LNxZYpZ2?=
 =?us-ascii?Q?NIYeTfaDNH/IkCLtEeKDJvgXAA3hDilpb0FRuB1u9y7RRrW4JaPStb+ahqlQ?=
 =?us-ascii?Q?UzjRbHsaqDokAbzoECt78+VitfTsiPgpo+yNcxaz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8838d06c-a76d-47f1-acf9-08db7d636a50
X-MS-Exchange-CrossTenant-AuthSource: PS1PR0601MB3737.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 14:23:34.3661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/g7SzJISPcwvXF+duNxTPQPdf4jXwb/mn38Edkm8KLI7atB0SZZHi55G6Qq5cEHrDTXqwk5nIcQGrWTC7lzQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4335
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the first report returns NULL,
there is no need to execute the
fimc_capture_try_format() function
again.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 .../media/platform/samsung/exynos4-is/fimc-capture.c   | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-capture.c b/drivers/media/platform/samsung/exynos4-is/fimc-capture.c
index a0d43bf892e6..5ce2f04afa1e 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-capture.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-capture.c
@@ -825,10 +825,12 @@ static int fimc_pipeline_try_format(struct fimc_ctx *ctx,
 		tfmt->height = mf->height;
 		ffmt = fimc_capture_try_format(ctx, &tfmt->width, &tfmt->height,
 					NULL, &fcc, FIMC_SD_PAD_SINK_CAM);
-		ffmt = fimc_capture_try_format(ctx, &tfmt->width, &tfmt->height,
-					NULL, &fcc, FIMC_SD_PAD_SOURCE);
-		if (ffmt && ffmt->mbus_code)
-			mf->code = ffmt->mbus_code;
+		if (ffmt) {
+			ffmt = fimc_capture_try_format(ctx, &tfmt->width, &tfmt->height,
+				NULL, &fcc, FIMC_SD_PAD_SOURCE);
+			if (ffmt && ffmt->mbus_code)
+				mf->code = ffmt->mbus_code;
+		}
 		if (mf->width != tfmt->width || mf->height != tfmt->height)
 			continue;
 		tfmt->code = mf->code;
-- 
2.25.1

