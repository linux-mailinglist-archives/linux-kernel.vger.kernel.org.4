Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A62373DB76
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjFZJfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjFZJfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:35:16 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2111.outbound.protection.outlook.com [40.107.117.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B33183;
        Mon, 26 Jun 2023 02:35:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S02yL4Da7zB9HVfhZYNzOh9oijn6XjTw9TwOS7UCrGubSlYsiZF/ZC20XsZDLo9jYDRVdRuwOMjOKmN/rdReBeuitwJPLBvLvvQGqU6oLxnPPgM8gZ0THowJk0b7BjmmvoEUKqhu6hHvj5sQeSp8shYgV1HKj4aCvRbKjtvpem74KZnn2AyPCD8PbeJc5x2jz+d4vXEYom+R98yptAO0CrlB1CghwNNH/yfeSkBF8DUMTRzeI5UcdmvAwNvEEbGHDnKQMtOsx/+5XA+xsVRVIfJ1xRpH6cG4lg2uCgzfL4eXd671KrBtSFImdH4LvEVPeC1N2TP8eKZflBBzpoWRYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emBV2bbaiq096+6joF0dFlD7a96OChrW5UPXvvCrtcw=;
 b=hhWcoVK+s65FmZuIT+JAGBHFIVpF9+7X2NNx1ugRzviGJ5zXZH0VlZ5g9+6QAI68evI8q1z9dnrvWUzuBeMBccn9t/1C0I1jVffMnEwIlNHRlohgKUOrBXpoqtz0UErEN+msbmvFRsGmL06w1zF8j5o6hLk7mfBk470N7QB1zVd5/jzOMrRoB8oKKvN35M6lye4oHIpZzP7BpoKlDKF6OTmgY7xAzRb4+P0a5HNYlOMW4IHU2W7SC29reFsjkurK96GgqV1GvyW9AqHIZwlkxUlRKL2SRSO7TRVTMAxvB4LTCivmmePjwRoymYjKhv8HpXlBgHMvnF/tIU48fULHRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emBV2bbaiq096+6joF0dFlD7a96OChrW5UPXvvCrtcw=;
 b=esBMQrhunuM3svBp6XpZfL9ob3DdDkod30bMJ0YQiurUiVM3gIBTI3aEdfmI5jyuZ8qXdHnaRSY0aML6vMb41ZS6JaOuk3O0uJFKk1PRWayNMXb2P1aaxZuGNDphDa/ZomncoTe+Q4McQGweeev8I7ttou6V1Ik5VzeHr186l0W/ALWz+7+jeggwY76Q2x04EzsZg92snlg58nRGYPch7jiKCi2l0WahTiXUStjZanb5DahfH6utg/elyO3L0hihINaewl0hURzo6TMe5FqDwOUaE4A4xE0R1om6r+EcPQFj375y4qvg5yY6zH/zRnLyiecKA9VfSXP2rzYlRPOBxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com (2603:1096:301:11d::13)
 by KL1PR0601MB4323.apcprd06.prod.outlook.com (2603:1096:820:75::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 09:35:11 +0000
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::adc0:c22:ffae:227b]) by PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::adc0:c22:ffae:227b%6]) with mapi id 15.20.6500.045; Mon, 26 Jun 2023
 09:35:10 +0000
From:   You Kangren <youkangren@vivo.com>
To:     Kalle Valo <kvalo@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>,
        Simon Horman <simon.horman@corigine.com>,
        You Kangren <youkangren@vivo.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-wireless@vger.kernel.org (open list:RAYLINK/WEBGEAR 802.11
        WIRELESS LAN DRIVER), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH] wifi: ray_cs: Replace the ternary conditional operator with min()
Date:   Mon, 26 Jun 2023 17:35:02 +0800
Message-Id: <20230626093504.1325-1-youkangren@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0302.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::14) To PUZPR06MB5936.apcprd06.prod.outlook.com
 (2603:1096:301:11d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5936:EE_|KL1PR0601MB4323:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d61aeb-2a3a-469b-9fde-08db7628a2a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mSxp1wgVtdB62IAL34vN3fHAKg9+CSKxR1QOPer/s8gY9Nh+W7IrwIRMCtMI7QRP2ZzPiZBOqGdofn5Xp7rUMafI3V9V78NWjDQbbj/HQlFb6QAcIBQL+VPx/kyxfZpALTODUaF1NuumCEO0M528ccPIlmmsQNkPlcmCtmxraZqG9aoZph8PGHU+QEmvnRkHzhYu5IFoxF6h2NOZNIQif4exEN458ZokNOOkOhPSeCbSipTr5NnvNSVCmCqnriOpmr0c1/qTbtiNt8pFxeAOK1egnh0A3Aqim7ruqigBbuBzSCc0wR8EShJVhxoTakbJhCCNkSakasUDFJt8WfJCuHqHTNQu/S/wp2fEvvolrib0h+9G6DbBqQ/Ve7on7fD1naN34jGMFGIQipt27ffZYeB+IE19IxCgtRS2aSWd4uQO9hKpWGNwuvasgPFjPkDFIWnX+2wiHWrK2hfNA1p5XsnCcMrlk+2k7LkDY+U2NT3dx3AcRC4dedCdcNBXn0SbjYN5Frewv3AHzjV2fK7AUfYHxXrR0DxIswS6QCsV1JfCi8JivcX4gmCUwluGib09Jl9ugp3gKt5ae3vexcViWRDPdLdu5izOW2jiMOlJPSBM7sfEK86LlPTlE0aijpzZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5936.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199021)(4744005)(2906002)(6486002)(52116002)(6666004)(38100700002)(38350700002)(2616005)(107886003)(83380400001)(6512007)(6506007)(1076003)(186003)(26005)(41300700001)(86362001)(110136005)(478600001)(316002)(66946007)(66556008)(66476007)(4326008)(8936002)(8676002)(5660300002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a/1tgPT4NXIQAhEQemcoWj3e6Ce/BTCTWxB+OoYNcMcqMOy70pFZ5SwiYuUy?=
 =?us-ascii?Q?neUJ5IKLajCH2ftNCLand2Dv2pNXosrgNz64KDggLFHVh876YyS1Qr+bZxuq?=
 =?us-ascii?Q?2RLsp2nUKVvXqBP1hWjiLQTCo62CjSXZBVkWY1/+voyy/f8CAjT6OWBKVOx8?=
 =?us-ascii?Q?KVrUQ1x9pv/g0375MRJdoq+dKep5kCrLE82RiEgzMp1OONzvGW+rasZwNeXa?=
 =?us-ascii?Q?q7DQWiL5/MDL4hd2b+nFDkhUOj2O0we64zQVh8AZZnVnC7RcsQ3SCChntYzm?=
 =?us-ascii?Q?Ja393Z6u5w1l5/KqrDMaUgEmGK4s1+OEoJVLcuxrgU9eo2UCuR4UhMEwdi8T?=
 =?us-ascii?Q?rB5ySWH/Tfs0CEYpCvoRb5NjO7YxR7K4w4fSW63aP+bW6tULkCRT1z1dGhTo?=
 =?us-ascii?Q?Ryk+t1k5KEZTTE3MMNUR5dXrsmKaj2Vj+CsN1cFxjoOSviu4gI+MswsFILdW?=
 =?us-ascii?Q?qF6WrVf3EjmY7JROSd0gECykva2r/KiPw5tND++2MNEbP8FBWFO/U6BX0BLu?=
 =?us-ascii?Q?c1d/K/22e4/WKam7t0oQay2r4Aav2MYi4J/uJVLzRfu0xfNQjA5gjhpMRd6/?=
 =?us-ascii?Q?5tjpViOM+mfHNWU0fvA7wBiocM8zko7jyCTiYJ+r1d3QFqdDg+sh1RWoq2k5?=
 =?us-ascii?Q?nn7E+zhGQyllqp5ANvzpEtOR1dat78GO8Sjv5s4Ex8wVqJup4aFdCzJ5pojM?=
 =?us-ascii?Q?oqO+OWO2RlyPEU5A6rzJ5i/emZgBlAqVw+UFliii/cWkjr62TvFX5oBTwaQO?=
 =?us-ascii?Q?srDmwy3r+wAdT1KzeBb7kCUq/pyw9YFdtDO68+B1rv0Lsbr0IQ8CvShupj/Q?=
 =?us-ascii?Q?DDkfpJM0h74VBfQR2ys7W+jTwkfP5/6rsgg0ZyJ/4DkKt45H6foSJhzVwk/4?=
 =?us-ascii?Q?7X6tzPFQRLJmeiWf/NhgpkcikJXvvTS+C2kG9zvOJGwhWSBQQprPpD+Wrw63?=
 =?us-ascii?Q?Lr3d3apCuWb+V2X3Fw8M5brrxLJ5edWYb1tJeiIfyYIYsy7bdHzBeD1ly3pJ?=
 =?us-ascii?Q?tuM5Z40+vKEnnFwY0T4wDK6eXJCb7nMn0UD8kfIR8zJpDYiYuFjvT+1ZLjFy?=
 =?us-ascii?Q?xsG7bIxpRQcEn7ofgfinxfGGBnThhuibGhDhjMLqxLrScAkNo+dRc4XAIdRQ?=
 =?us-ascii?Q?hYyFLGrSzrS1aiy+R6AmZ49vtRM7t6OBXer78rpilBaEXeIhRUzeQagvOS9F?=
 =?us-ascii?Q?Rtq1XkR2ODYFmIoXlskNB2ZFahxnR+3OFEuyeBhNFVjGII3B7Meno+KwBEEv?=
 =?us-ascii?Q?Tg27OJKa8d03+N5UHN7sZKk+sedlC+8OsvWigZMXFlDIqXE+R8f88iMSWDo7?=
 =?us-ascii?Q?QTjMUX2hOk7SyD/qnhJ2482mG3/YjssgUAvC9suVjd0+V6WnSyem63dL0J7K?=
 =?us-ascii?Q?At24cN94ZBYPcmJ/J6eA4eN5IZyAHF3rckhspTUuDP7McIszKayA9kHbJYPB?=
 =?us-ascii?Q?JOS2MZoHCSGido84CwJZSHLkN5L+N0THLzm89Np0QFNgLbh4L7pdloCl5Sc7?=
 =?us-ascii?Q?GhKFGTChFHOSxjSplAbTs55kiG6pxuCo8JXYsUicTEJpvZrQgaWA6c5M2EkN?=
 =?us-ascii?Q?1ftuNDHNvDqFI/5I+bEdhGr429EjVCxg2MmQPkBO?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d61aeb-2a3a-469b-9fde-08db7628a2a6
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5936.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 09:35:10.4967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hl/mfDlm+sPOsOlbKWP9uR3Zafb77N5GTq4pNISZDh9LFSsA3JDiunxv5CoKzxyk76/emooDZYmKIDmKqPwlUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4323
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the ternary conditional operator with min() to make the code clean

Signed-off-by: You Kangren <youkangren@vivo.com>
---
 drivers/net/wireless/legacy/ray_cs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/legacy/ray_cs.c b/drivers/net/wireless/legacy/ray_cs.c
index 8ace797ce951..96f34d90f601 100644
--- a/drivers/net/wireless/legacy/ray_cs.c
+++ b/drivers/net/wireless/legacy/ray_cs.c
@@ -2086,8 +2086,7 @@ static void ray_rx(struct net_device *dev, ray_dev_t *local,
 			rx_data(dev, prcs, pkt_addr, rx_len);
 
 		copy_from_rx_buff(local, (UCHAR *) &local->last_bcn, pkt_addr,
-				  rx_len < sizeof(struct beacon_rx) ?
-				  rx_len : sizeof(struct beacon_rx));
+				  min(rx_len, sizeof(struct beacon_rx));
 
 		local->beacon_rxed = 1;
 		/* Get the statistics so the card counters never overflow */
-- 
2.39.0

