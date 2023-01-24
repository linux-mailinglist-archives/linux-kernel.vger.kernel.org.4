Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEA7679656
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbjAXLNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbjAXLNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:13:35 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2123.outbound.protection.outlook.com [40.107.104.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91BFEC63;
        Tue, 24 Jan 2023 03:13:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVhvvgMxMWq8r6se6EOEMvym5azmhiDkJJkB689h2USgqTP1eOa8RVFl12az+I53VOUIg/YXoocE5F2H7M+C5lFF5Hk79aD6ipydwcb58c901HtIFUPCZqfGGZm1T+W02wFeUJIeGX9U7mQpAmDwUD1zxccte0yCQKrREZLj08uVEZuIjSCiPC919KNxteBlsnLWCxac0e0uCaMN0ByJULvX4X7xb6kXZvo9fCW9qprzh65tWi+pejHBUC2baFy+3eQCTW7HzcAU+C4uJzXqjns7ay7cvGI3ZF6MK6vE5em0ujkMZi3ehpe/8Yz99DbZdpj5a++UarsMk1dhjjs6+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnodbyZMopN7JaAyoJy+8eyLEBzx5ZhK8voZ+UTUvUc=;
 b=UkD6qPtlPdzsB9cQwgWpId/tjTYcfQC08jdjI9DWHyT8P29nXVp5tl2EUHHUiOOczWgMt1twbqq3nDrxgjRGbrPNna1IXFsUlrThChSLh8zUpWOspRVgUhV57eqP96ITgCFkSs9pfHz8lFsarg5jzCjnirbThfCZ5oVGavko5+kiP913E9xPi4E8a9H+HzVfNZdN03i9XjPZNzyLsSzM1OJQuaB9h4V8uiozrCNED4UL8JebqQcHLei/Nypczvk+BnwilaDU4vRpfIyiPv0xWTFSvJj5dJ1bFPowtGVilNlBCJ7sThwQpXoCz6lVhysiZu0Yq2WNA3rm+//lvTjtzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnodbyZMopN7JaAyoJy+8eyLEBzx5ZhK8voZ+UTUvUc=;
 b=CxaLKHjkcMMJvOMNccXgh/9aq8s6KUpqwfYdSb8rhFy8ilc28XRZrtOpN21tNsBjVOv9ex1MKU6j7XQlMxqc09A5XLsP0ZZXTSCpvJtCK9uNtG8shLej26DDJA/hd/58OxVeaHXrJNbA+oDOTZZrViJBG1jj+1yb0Z9JBdlLMJZiA/ln4X5Ovmr98WqHsSm7tm7K3cj4u2W1Q5zbTvzuofwuT9FgiskZE3gl7tjvviZ4pIlJ+tSSO9QP2Dl9jz4H7vVsCCqb3GdggLVejrglzYFTgbX8XGqatrcXCcX1LUCqrlKxujRBh/iU0WxcJ2JWxG0Ip/YH/XBebRnD9kAczA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by DB9PR03MB9639.eurprd03.prod.outlook.com (2603:10a6:10:45b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 11:13:31 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%5]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 11:13:31 +0000
Date:   Tue, 24 Jan 2023 12:13:29 +0100
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org
Subject: [PATCH 2/3 v6] input: pwm-beeper: add feature to set volume level
Message-ID: <Y8+9WRP51u+dof8p@mt.com>
References: <Y8+8824hy/fWkpEk@mt.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8+8824hy/fWkpEk@mt.com>
X-ClientProxiedBy: AS4P189CA0036.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::7) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|DB9PR03MB9639:EE_
X-MS-Office365-Filtering-Correlation-Id: 8202e2c4-155f-43fa-98c1-08dafdfc06f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /DoLYMOGqCtPgNRme7Ku/UNbTO9/FVKp/le9+9pdagAu1gh1QiyTL11IV69QlOUUSNC03NuaUOBbHTp7X76wHCBRsh5ClPbWAAsZdcTVHGJYHquEWbQq8/sfqogvqO03qKkYa9CiK4vE8BCS/Zm1KK8AZqc1QBRtY2ax0OihhmDhwduT/oKz9crA6hay1PuKMNTLd7u7WSBHgPDUyYKau/2WDODErwzQglnElJNjufimApxTW0whOtm9r12GnuizJJj+DX92NJbUDmmCp5aG8b2bWq774Uu8Kz+HhR88YuMPh/SvfjSnjssTg6R5bOl9sqPKj/zG/cALTLp+ahghp/pObxGJzRxnqYxr83/8MOt9oVFpy5lkoTmaBHhx00yJzCLRFJpWMbJWXZ2aaPAJUXo2h+IOAV+kyZ6epgA356eqNytOCI+Ejxj5XN/hGp6v/JyoDkEeNHilimUQyp7xJBaJq79VQwAtyrcXcGz1Mx5llY4S5oGyf/3yWQg4sTECgHHAFAotlp4pxSjvt3X0Dx6f1ysapah8Ai8o1/rMIQlvyW9ABF9lJV/FSIVDXwwTL1jX+0CLqeqNvt0NCTOIcXDJ/yR3Clx+3yk60KHylC4v+LMHwFgWgP7lZ/JvBiydPRejEAKdbRzTP9zQjxbTUIXbxTYGHumZezDoIifRbJ24xh5k31bol9oL+L4z5DbkWHOO+RjBlOR+cSMzLh47Bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199015)(2906002)(54906003)(41300700001)(4326008)(66476007)(66946007)(36756003)(6916009)(66556008)(8676002)(44832011)(5660300002)(2616005)(8936002)(316002)(186003)(6512007)(38350700002)(86362001)(6506007)(38100700002)(26005)(52116002)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUxSWXdUSHNOVVdlRS9QcFNzbzAxNmkxWTZ6eVhKNElsQWVpUm1sYmhQeXVp?=
 =?utf-8?B?d01MRm9NUGFKN2tTS0t6VW13aXdFUFZ2VC90UHVRa3l5ZVZUU2txSFk0VWVj?=
 =?utf-8?B?M1h1dkZBbUQyZS8yTEZCOWhaR3FEL2haWXRFcHAvcElkVXBxVkxQeEFBcTN5?=
 =?utf-8?B?T1I1dUlZZWgwY3dlUlBqajlLU0hJZkhzTWhtdUxqWXc0dnJFYjZHeFZqQjFL?=
 =?utf-8?B?RjZyTGg4aG0yQ1RvWUFDV3J4Yjd5d2o3Mi9xZ2RZOFExK2tMVmV6N2tnTjhI?=
 =?utf-8?B?Q2Zhell1RFc2bGRXeVJqRjNLY0dWMFlWdnl2Rjk0NmV6eXJSZEsyb21wUTZX?=
 =?utf-8?B?OFJxcTlWTXM4R0hRR0lPSGlDdHZJSjFFTGptSkFGVW96cVdmRVVnWXlnbmZQ?=
 =?utf-8?B?SkRxRjNCZjZKM3plVldORUlpQisydSsweVlKUkpQbTNqRGp3Y0lQOVJjVERz?=
 =?utf-8?B?aktvL3RvTlNvRUdCaFpLVndDWmlyeTJOY0U0eGhlY0NrWDBhUmE2TUEvNURx?=
 =?utf-8?B?bVV2cFlzUk9OdGx4djh2KzhlTlNOK01DMVNHQ2Z1RGdkRjhTV1JwZmxhcHBL?=
 =?utf-8?B?NzAyUkF5R1BPTEJNdFNIRitpci9ycURqKzRQZW15Smg4ZkJ1MnkzeDNMNU9q?=
 =?utf-8?B?SWNCRk5WS2JrSFlQQ3pCLzBIbjREOFROWHo5bldQN0hiMERlaVFZeGhtV24z?=
 =?utf-8?B?VTJGN0JvM2tISXFFZTdNOEhaUVV6SnVFSHo5ZVU1MHhxYVpIZ1pJUDdJSU85?=
 =?utf-8?B?c205YXVDSjlCNk1lV1M0bWdxd1g2eG5pUmEwcFVUZWsyU2hkSW1objdpcFFS?=
 =?utf-8?B?OHRHMVBwL2JSNHAwa1MrOS9jV1VlZVpWeXd4TTBlZmw2azRLV2s2WVVGb0Y0?=
 =?utf-8?B?QUVOQW9waUNMVVA3b2g2WStGL212YTQyWkpzbHFoWHEvVkI0UUdBeGVBZmxW?=
 =?utf-8?B?TUpqMGdXTkw2MzgzQUZIMzcvSk1pakY1WGpIdWNuTlUwc0ljZldIRjdxVlZC?=
 =?utf-8?B?VGxudWdwQVN0NkhCbzF0WjE4a01iRjRqcmthUjZUSTg5Q2xtMkx0aHBqVVlN?=
 =?utf-8?B?S2FSdGxldE1GZ1FNV0RHMVd2WUN1YXpTa1dSb2VQdjZTdkFUMHdwNjVWTEtB?=
 =?utf-8?B?YlFjSkp6VExNQXV0SWlzRFNrVVcxbC9oUWJobkR4UEE5ZnE3ZHVXQTMwYTNG?=
 =?utf-8?B?SUFlOVZKRHViT0VwZG0yZHJCUGtiNWxRdVVoLzQ2TGFkcTRkL28zM29jVUFB?=
 =?utf-8?B?bEdXbFEwSXBOU2VGY3FhMjFCam1MOWQ3Ulo1U2Nlb1F0eGpLZ3ZFMC9UMkMv?=
 =?utf-8?B?M2VZeUltK1ZSUk50clNNOTlLYTBMeUVvK2EyTjRyQSszUWRWUy9aU1JaSGRo?=
 =?utf-8?B?dnFxMDVDSmNmWmtFdzAwS1lsclJVZ1NzbjYxT25RcE1XRCt1VTBKcXByUEFp?=
 =?utf-8?B?MDdoQ2d2SVlSaUZqbXJwUDZ2dEZYcnMyQ3VpN2kzM1UrU25ha0R1YXFTQjZ1?=
 =?utf-8?B?Znd6MDZwN0hhc2Z6VVpBcHFHRDd3R2k1ZHRnUlArQ2J0YThXZjRLTEFzeHNa?=
 =?utf-8?B?b2VVZW92N1dqRW1rbjBRbGw1MmpPUlljZW5zbm5IRGl1NjZIV0pIM2FKYmNa?=
 =?utf-8?B?dFVIaUpFd25vVGRhZlM0TzNBS3daakxsQUNvSUZneTBkL2ZUR3BMczZlckZ6?=
 =?utf-8?B?c0oxMUNkM1Y4QW5mK2N1aE9MYzNZdCtGdEprY0ZDcGUrOHZzVC9JTUxhK3Z0?=
 =?utf-8?B?ZHFJUVFCL3U3bHJ2ekhHWTR0TExtL3NIenUzOE0wdm9Sc1N3cS9vbU8zWWhz?=
 =?utf-8?B?UjNNS0lNUVpBN0UwSjZTNUMrcG1wSWptRGxjQ2hCbTU2NGhQakNNYTQvMmJk?=
 =?utf-8?B?UHV6VktwTnZpOUxpdXBiSEtiZTRLc0ZQOW9nK0JYY0pGM2RHTTNUWDFWTUJr?=
 =?utf-8?B?ZnFnOWxrR0ZEQWhRRkZkVUpxTjRwdFUwbFUyNVRRRmp0SnNDdTRNRXZxTlV1?=
 =?utf-8?B?V3JheVQzZUViZWJZUVBHSlZGbWdHRjV2d0FQQ0UrUnAxYkpMcjVjSGJwUk44?=
 =?utf-8?B?UlFjS3p1NUtPcDgwVEpzN3BsQnVXREJrOCtnMDYrR3hpNEpBcW03bVcwdWg0?=
 =?utf-8?Q?tgXDYIRSQDp8uL93GZXnxzjQI?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8202e2c4-155f-43fa-98c1-08dafdfc06f9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 11:13:31.7890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8JjyLNwiyv/EypsAcuvqcOmKhDu8S7ubHHQxR7ZzQ8NUqnRHKJv3UiTOOdrbyuKGOoSiHm2PlXiXw4koTFnpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB9639
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the documentation for the devicetree bindings to set
the volume levels.

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/input/pwm-beeper.txt          | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt b/Documentation/devicetree/bindings/input/pwm-beeper.txt
index 8fc0e48c20db..93cab5eee9f2 100644
--- a/Documentation/devicetree/bindings/input/pwm-beeper.txt
+++ b/Documentation/devicetree/bindings/input/pwm-beeper.txt
@@ -9,6 +9,15 @@ Required properties:
 Optional properties:
 - amp-supply: phandle to a regulator that acts as an amplifier for the beeper
 - beeper-hz:  bell frequency in Hz
+- volume-levels: Array of PWM duty cycle values that correspond to
+      linear volume levels. These need to be in the range of 0 to 500,
+      while 0 means 0% duty cycle (mute) and 500 means 50% duty cycle
+      (max volume).
+      Please note that the actual volume of most beepers is highly
+      non-linear, which means that low volume levels are probably somewhere
+      in the range of 1 to 30 (0.1-3% duty cycle).
+- default-volume-level: the default volume level (index into the
+      array defined by the "volume-levels" property)
 
 Example:
 
@@ -21,4 +30,6 @@ beeper {
 	compatible = "pwm-beeper";
 	pwms = <&pwm0>;
 	amp-supply = <&beeper_amp>;
+	volume-levels = <0 8 20 40 500>;
+	default-volume-level = <4>;
 };
-- 
2.39.0

