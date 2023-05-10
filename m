Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DDF6FDF38
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbjEJNwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237064AbjEJNwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:52:24 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20618.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::618])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C20A116;
        Wed, 10 May 2023 06:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvNXpkeGbDwGryBSYe2ZzX50uSb9LyGNirzhHS4cnbst+tWGzYfTo5U9xrvzdZJjYtRS03TedT/iHJNpVJYCVuVLXE/bNAdfhoZdq5ZLGGgD7XWk6UjvtiJ0LHUSukjvzzW1z+5ZMOzxZS1qpIyuD7jdZEgOiCiX0jw3ARQafSFZroSOQQ2szpgcdi2jYR/gV7a9iWfgYiCAbAsI5KaFTt6IXETfbI7QAEBhYOIiaviALL/yZ6Dwx5W7zcwWTSuNQ9dKSIGge0yNK+KYfr/b/LViqqgqH2nuNQ0vMBgVKZiYyan0u5fCvDKHPpuUdeLQ1ZzktMI8BGoncSdukFxxfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wzgk7NACNpVo4yLJ6SiMcWCrzayoLFdPfoLoNCtqjhU=;
 b=Jo2RKSOzrHaNsBZSDjOKuNPLXsBPS/jhzpLBMb9x/KfSyUanzHKSjEHwwUgWQzjEXPuFeLqwsepAQ47I9D3lL94011NDjX5XdqlHTgDeSVRc+JTaG/eQCVk/YqXLnaumoTKW4v8lbnwTz5yPIz6Uf8jFPJRdBBsXm/UkRh/SHamkWaVqLAj8aF5oqhpz1z0CXOkHuWXD2/OpLzkTc3TDUiYNETFvFPZk6b58gBPKA1GZVt0Rq6bR2+0xNYwpIa4U0SRn29CfU0c5s4Smia5hrzBt93WjgEqUdgiXQ/U4+WmOtsroPHOvC/7PrYRvPD5oG2rjKjm1G0UJZs5gmHIf/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wzgk7NACNpVo4yLJ6SiMcWCrzayoLFdPfoLoNCtqjhU=;
 b=M47ZPgn3dTh7tznqtKs4fgtQSwGo3WM8GXWNi1iKZU6L0Dn/6A2Gvtogzhj9gFCMph1TDWMWE88uuHw8s42xUjzhEt73GBxvgSAYVOk8DTWjVEH4gQyNrJj0F01gSRYkht0YbH+aZ4ExBKGu0YlojtLk8q9bG3w+9LsWBTRTCJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS2PR08MB9896.eurprd08.prod.outlook.com (2603:10a6:20b:5fe::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 13:51:11 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6387.019; Wed, 10 May 2023
 13:51:11 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH 0/4] Input: support virtual objects on touchscreens
Date:   Wed, 10 May 2023 15:50:45 +0200
Message-Id: <20230510-feature-ts_virtobj_patch-v1-0-5ae5e81bc264@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADWhW2QC/x2NQQrDIBBFrxJcd4pak0CvUkIY7aROFyaMVgohd
 6/p8vF5/+0qkzBlde92JVQ585oamEunQsT0IuBnY2W1veneaFgIy0cISp4rS1n9e96whAhkh7F
 3GpFGp5ruMRN4wRTieVCHqwMJ5pw2oYW//+pjOo4f97Ir9IUAAAA=
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683726670; l=1997;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=ax5hdrOTGsPudux6dPEA+8b4eWTi/NC3+64oRXySfD0=;
 b=gnm9OJXWivQ4WZkDx0sRrBVS7tu3l6gWjmMVXv5QF/bDEdQ7inaeWKUenNmTOWlg14G5LHk5G
 2ENGkezwlfIBGAMztkrljCN55RJ8SUvrMIjPgzNOYtX6o5kV49TsN1d
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR0102CA0093.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::34) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS2PR08MB9896:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b2645ac-569f-4ee1-840f-08db515d9d09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4yF9bxJi0ib4qLk3zM2A5W1sw1HZC9lTmBh+/TY06zFHyZrC6ESPkPrMFTrw/Su3ZymgjOSNbNua0KX+mCIfrl7v3Aj/stQQUFVKPX2NTgORocMkUIvFNjmm2cVaPZWaqbnKjWoSr8r+i67y33BYdbwG4cnmvzyTT/6MiFnpLbC4u7EgY4Pq4YcFcT/2fo20Gvjq0Z+VxS2eQ0Z745D1eN6cY09yKeslLvxLz7WbSMX0cFhJabl4aY+exR5eWz92BGe3vXLlRalqD1HtDZpr0/iaqXA62hR79kpVkMzeBOYma1A6G0HXYAtTwcKtK3Lmm6RYFANyXIk4PxOpf37LoCZJYWvSMq57WXrD7ixoqsTdaXVcNVqPrdzbEAjdsQcgleybDgHc1qFjymh00MtPEukf1hNlkFHdb7vhMIyoL5spVf9hBxMMHdpIeTmZbjp4ix3ZY8gQFyTH7K6Ub4HhpTBTDoM8Muqzb6Xj4UH+X2hQseTrBgpPPF4EpZKQld6ijB6XKGIvQMYaMg15hZn2ApWevUlvh24E2F4SAtKR0ccyOERBSaYTwkAmMdhS8C9iPy2IewlBGYrSjAbp/5KgT3mp3K0uy3attL1LMXcK+OBcptrUo4sXBySIRKfKQRVc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(376002)(346002)(136003)(396003)(366004)(451199021)(6486002)(52116002)(6506007)(26005)(6512007)(107886003)(83380400001)(38100700002)(36756003)(2616005)(38350700002)(86362001)(186003)(110136005)(4326008)(2906002)(5660300002)(6636002)(8676002)(316002)(8936002)(41300700001)(66476007)(478600001)(44832011)(66556008)(66946007)(66899021)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkdybXdsRzBVZWJ6YTRBRXBPYUV4R2orZjZKUW9rL1pHMXUzRHpIUWZ5N3Jy?=
 =?utf-8?B?KzloSkptcGp2L2xMVzd4V0g4bkVhT0JXTUdJa2ZYSFM5bE9YNFc4My9CcXp2?=
 =?utf-8?B?L1JJeUkvRHVzTWUzbzdKK0U3aUZpS3VQL1U3TDRUNEwxdkhrYmVjVkN3ZTlm?=
 =?utf-8?B?ZWZtbjVhdjdIS2Z3bmVyV0tYVzFNbWR2MjJDbUY0RTVGdlpFM0c2Vytnby9H?=
 =?utf-8?B?NkcwS2NMNjMvUkZsUVc3dVRJRVprQkY2b0Fvbkhha0ExY2VRZ3lpNXBOVXRN?=
 =?utf-8?B?M3BGKzVxWkp6WFJaWjNUM2RWdzY1QmpTbWJ3MG9CUlczOTNzVklhdmRTeXMr?=
 =?utf-8?B?MTk5WWRWQm82TGcvTmZTQ3ZXOFliU1l4anF3ejEveXJSeGM5WXdLNGNDZitD?=
 =?utf-8?B?Y2tuNk9ob0RyemNwRWlieUsvRGdVcmNVNnp3SFRHNEJRNm1TTjJhaEFRekF2?=
 =?utf-8?B?ai9RSG1EM0NrR3JlditHSnJPZlR4dWtuRU9wVUt5Nnlmc25sS2VhQXl0ekov?=
 =?utf-8?B?aW52YXNkbTVEcVZXb1pXemRzcTZTU3U1UkF0WXNUOHBUaFUrRk8yRXVxZjVp?=
 =?utf-8?B?VUVlVXk2S1p2dEp1Smp2TVBBaEtLdlBGbWlhQWxDMmRCMVAxL3dYZXNNK1dm?=
 =?utf-8?B?ZXJiamRsQlBFTDcrU3lpM0psUzdPUk1jOFdITHdwMVdqMmptMXBKaHo0cjJT?=
 =?utf-8?B?c3dCOENsS21DbktaTHRaYytEdHVvT3JUTWJObkwzSWxTM3RqdzB6a2F4cE10?=
 =?utf-8?B?a09RSTlJNkdVN2lVaVhpYVo3ZXRnbVBvSjl6OXpPaDNIRWlsTEF2Q05hMW1h?=
 =?utf-8?B?U1o5SjRLWko1UFNGTExiQWlhTTJyeUY4b0lGaDkvZVJxdHVVM0dZdTdTYTFu?=
 =?utf-8?B?eUNJUlNnN2xOSlBMUnRFVURPR3R6bFR6UmNycWloY2hmQ0t2eTF5cVd5STAv?=
 =?utf-8?B?aHYwYk1XTTkrTzJ0Qkc3YWNDbUdiN3UxNXZuMEpGdjY1ZWZPaG40TmlidUtN?=
 =?utf-8?B?ZSt0QjhnYXQvdFhxN2pGT0ZIZU55MGlJbTh5OGNIeUQwM0lnaGkwdzhmMTNy?=
 =?utf-8?B?V2VnZXlkb283T1F4V1hJMFRWYkdmdE1UVDIxTUpGbFUrb1FXM3h1WTBwVHJp?=
 =?utf-8?B?dk1BdmZBc3F3VFk0WkFPd2ovY3pMQkN0eTJZWFpuellzS0pCRzJnbGxEWTNv?=
 =?utf-8?B?Y2k3VStpZkNiTEpjVEVMRDJ4RmV3ZzVGcVpHWTIrTVdsdEJnY1BXWEhYcXdw?=
 =?utf-8?B?d2xvZ2ZLZkFaOVFsNEk2UHhWTjUwS05aWDgxM2pMeU4yeUFRdHhFdjlycTl1?=
 =?utf-8?B?b2E4dldUd1l6YjkwZnI3NjhNaXZkd0NPaWlZN3VIVEdCOHpTYnBYZVdzeWZH?=
 =?utf-8?B?YUZyOHlrc1ZlYXh5dmU0N1pQZm1reTRRU3U0aVBrL1FRMjNjdDVvN0FxdDZE?=
 =?utf-8?B?emRRQ1NNTXNySEk2bWQ4RWN2end4R3RtcnNFdlg4VUJPeXQzL1pwNkgrbFpU?=
 =?utf-8?B?NjVZUDEzcmtZNVlJMVFiTE9XN2Z3dWxvUFZZM04rdUZqYThlNHJlT2s3Y095?=
 =?utf-8?B?b3NkK0lNdjJlNEswMi8xeDRycFJGZEZmb1BhL2hkSXd0N29MMGs5eU51TEdT?=
 =?utf-8?B?WTFsbGdraXRIdzVEVjZxMVk0TkNlbk1vZlBScGo1TGtwRUpadXFPeXFYWXNQ?=
 =?utf-8?B?U3MvNEI4OWFrVkV2bEF0WFNnakV6VzNxOExyMHhla3ovRDRjQXdnQ1FGWGdS?=
 =?utf-8?B?eHVvWWpHOUhwZExXRUM0c0NIK3lLcFQyNlpXTmhmR2l2YjZ5Rm15RGRsREtw?=
 =?utf-8?B?VndhNGlNS0p0Ym0vZDVEVTFYT2hQVFRwU0Q1UE10ZWp0bUVYK2ErTXdyT1h3?=
 =?utf-8?B?d1lXTGw2Q1U2cmhCakdVelVqeEVOOUw0K2ExRzg1MHMvaE5xbisycmZzcDVM?=
 =?utf-8?B?SEZ4d1Frc1VGTEc4Y2c4WHp4eEFBV0l1M29ZQ29CVnBQMmtXYm8zT3cwd250?=
 =?utf-8?B?MGkzWDUvK1V0SGl6ZmJPWUx1YjdzK21kTTRjVk5uZWRyV1RKQjJiTWc0dVdS?=
 =?utf-8?B?cVNzZWM0MXJlbWFoTmU4aEJJanpIanI2M2JQN1JpTU5Xa1A3QVoxck1ZM21S?=
 =?utf-8?B?d1NWTTE0NUtUd0FrN2oxQnFrNzUyMER1UU5zTkdQbVM4dzFKWlN0TlROeS9T?=
 =?utf-8?Q?kNpO1i/HQ4NjU2CigHb8iEA=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2645ac-569f-4ee1-840f-08db515d9d09
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 13:51:11.3158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIYCVMjWsr5sbaMFkTBIY8NZiyC2/GAq+OeP0atUR87pyRfWAVjXDLohrnPHXR+XtWY61N0cNuHTabmMU2CDp3k+chzUT1UoFMi57zBXWsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9896
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some touchscreens are shipped with a physical layer on top of them where
a number of buttons and a resized touchscreen surface might be available.

In order to generate proper key events by overlay buttons and adjust the
touch events to a clipped surface, these patches offer a documented,
device-tree-based solution by means of helper functions.
An implementation for a specific touchscreen driver is also included.

The functions in ts-virtobj provide a simple workflow to acquire
physical objects from the device tree, map them into the device driver
structures as virtual objects and generate events according to
the object descriptions.

This solution has been tested with a JT240MHQS-E3 display, which uses
the st1624 as a touchscreen and provides two overlay buttons and a frame
that clips its effective surface.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
Javier Carrasco (4):
      Input: ts-virtobj - Add touchsreen virtual object handling
      dt-bindings: touchscreen: add virtual-touchscreen and virtual-buttons properties
      Input: st1232 - add virtual touchscreen and buttons handling
      dt-bindings: input: touchscreen: st1232: add example with ts-virtobj

 .../input/touchscreen/sitronix,st1232.yaml         |  40 +++
 .../bindings/input/touchscreen/touchscreen.yaml    |  54 ++++
 MAINTAINERS                                        |   7 +
 drivers/input/touchscreen/Kconfig                  |   9 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/st1232.c                 |  87 +++--
 drivers/input/touchscreen/ts-virtobj.c             | 360 +++++++++++++++++++++
 include/linux/input/ts-virtobj.h                   |  95 ++++++
 8 files changed, 635 insertions(+), 18 deletions(-)
---
base-commit: ac9a78681b921877518763ba0e89202254349d1b
change-id: 20230510-feature-ts_virtobj_patch-e267540aae74

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>

