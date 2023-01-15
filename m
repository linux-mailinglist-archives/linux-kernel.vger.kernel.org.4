Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80E866B061
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 11:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjAOKcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 05:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjAOKcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 05:32:25 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2097.outbound.protection.outlook.com [40.92.98.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C61CDE4;
        Sun, 15 Jan 2023 02:32:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGPuEChIgIOsu1A0JppAh4q4MsNXJncr0U+UUNG0vhANtI6tzyOyN1EUmltiHFbMvmFh31MMfkTlz0RmijJlYhdrcv90AVP4f8xA59WuFjLQwJaLWlwo+0ljsSOwWcZe9k2wRVo+YPLaPrDljh4IVBKoZofr57z2G+0SFHN4gQezz0Md/6EUU+soWX0DmK6auI1tgPAoApSOq6tdPKGtsEoWXJnIpuxZ63FLLFAMP89vOjIC/bnc+K0222zpt0lEz8umywRasolJEOE/o2Ws6QxWKlpEnkyHoGSpC4Y6ApxIUuhZYaiBXJj6J46eWkUPIpcpMKxSI3kAN1MgOYYiBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTIGXCvlKOe9Ar9BRp9PW662OZnjc2ADZMiM18JhV9c=;
 b=VlKuLk0NFlFTW58tTaNyopu1EP81cF0kJaVnjjqLA8h+ymgidRuM58BfMY/s61YVhcXlwRgWPyAvHYYtyey3NDIu+bunukSzfdwAN871p0luRKf5pS3HA7ULgm59I1OpN36t6YlSzEOiSc0k9gltK38u0mYaiz4awiW1RQCMHHVgUwCkfByTu8M6BgCSyJg3ClEljt4w6TYO9WKh1zO/FYM0vfXP4wj2Vrx7oRXDBGG7f8WuJP7e7D0m/F26lxA2flXe3ZCDkKFd7ws/XvCm+PjezhuTPBFPrjTPRiSDgHHK3NS0ZGMcZ/3B0M4bF3S+zhYsu5UzWv36brAk+qPIBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTIGXCvlKOe9Ar9BRp9PW662OZnjc2ADZMiM18JhV9c=;
 b=iWtLCxWKk0RB80/OY6xvlj0YrPqxGNb4CBB3Xw2iAF2h4Bul8T2mCtK6Y9eSOTryL15Ckc0yA4TAIRjXO2OWtA+CwZcoZIMbxfP+h3qFh19L/BeOsuGXyIgsB8/gagnBzeIK9zGkGZFEg/ILFxkKKWCVFq+6bZJth3WuqrISP/M5Y1N00T1MEdvRGMzff00CpYfrrqaww30k6fxAmyh2Gg9aROEoMIdyW79haJLwQGA3NpX4VYLxv8BN5azPoLgq19LRhJmqYkz1lBJKQA0z9Nlw3ZAjmwT/6EGxZVyOstRzKWk8syg9zsvSF1zhFW9s1NH6HhqsTyAisMswJQyirA==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by OS3P286MB2025.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Sun, 15 Jan
 2023 10:32:22 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605%4]) with mapi id 15.20.6002.012; Sun, 15 Jan 2023
 10:32:22 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     linkinjeon@kernel.org, sfrench@samba.org
Cc:     senozhatsky@chromium.org, tom@talpey.com, hyc.lee@gmail.com,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] ksmbd: Remove duplicated codes
Date:   Sun, 15 Jan 2023 18:32:07 +0800
Message-ID: <TYCP286MB232324626E2429754F9A3B73CAC09@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230115103209.146002-1-set_pte_at@outlook.com>
References: <20230115103209.146002-1-set_pte_at@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [jzePy8Ke2U269eFgH6xnfJaRWrsiHvp+UnjAOdp2zZY=]
X-ClientProxiedBy: TYAPR01CA0210.jpnprd01.prod.outlook.com
 (2603:1096:404:29::30) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20230115103209.146002-5-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|OS3P286MB2025:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf5694e-7be6-42aa-7f8d-08daf6e3c98b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NH503JeqDN27RdbYT32y4CUPrkl4oFh2iLiET9ymAjPK+wSrMyyY2KnYlv4HCd/1rWRNU0WkwZ6/lSRQFzD0Q2XpgIcRC+UTu5kRM1OnfSdHGDhi5+thWHYQPFQ+NehZppDsGIek+sz8tm5YGG3zg5WGKF9czBX/kRoQ8IknyKgpqMLgGUHTdOl2a2zjZ4ET4foj6f2t92kPALpAIOgPKMsvje5MPX5UuYqz+Em4IU0OFzj9+VbdpN07MncpUg/IoI/fWB+jmvHJWRZlTvsq8kt0Ro4BHzA7pD5NC0VsJFmqBWGlX+CQKinccWhvJJcpmaWHN9FHDwcRK13NSrDgk8pCMNsCMwvEyVITvAL+yg+hb3WyvHLUon8wSsRQuZAkIr1mfCLFaAgr0EWI74CtlEyuWxY10LMwxdhFWDanUYn2kOFmiZq1WoGJdK8Y/iXvGL5J0qW2QER74csAZnII42CWC2lzixt0g/mmRn6HIJNv24KK75F98cwqCHDe/D/mffkCxMvhxYKYyY/ZUbLwXUEabPNhDv+CLJkHQVt7FBGMhI8flYak8Mr+SCY750bXrfjvCi4+lIIjQ7UN46+6Ci9YBJEHefkZ9FGKsE0QhGw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EptRm/ylxG1AzPhVnMfV3Xl4pHxAYbi8F2rrFy8U11FQu5vCTUK2Lgt9NTqp?=
 =?us-ascii?Q?GXveJ3PBZKLdY+T9q5kUwThqLiOy2yvCk3B6nRdTbIGFKkEx7FCoutoB6anf?=
 =?us-ascii?Q?F1MkrxBFsSrG9OlPpR4vN3XZV1phh05xP8ZJaJ/hstDzaxv44Z26gPgFSDAJ?=
 =?us-ascii?Q?4pWW+jcYMoOG05MBiKZUc3hTaAx6d4Y28NsA+YbPocovyVb8CPgW5IkSySRi?=
 =?us-ascii?Q?K1Cb8j5aXOi7ulN5ClR0zGsvorBnP6dyo2XKDZwEksSq32MP9WEKDY3geKJ8?=
 =?us-ascii?Q?AlVSRDQK39A+NTAT/+2EWqakm2IuPpDv+9yt4Fw1LNEu25xE6r0DPIimw0t9?=
 =?us-ascii?Q?JrtBGDeLwRViL4ahN0tttxZyRdSwXkGYxYmPGc5KoAFhIaS6Sx5kD/T5tdLq?=
 =?us-ascii?Q?St4YZeG4ro4j0cZwt7ue3gF08KBKjj5hka2Z25KFQ+s6ISUknLuoxqKpmYo6?=
 =?us-ascii?Q?kx/88kOCMeMFS1hEG2dyoazUr8+QPayN1IqQ7zOHoi/pDbzDNm74q2xdK/tS?=
 =?us-ascii?Q?Fd1/zfTvqDSddKNqpGJgsyVB0m1AS2vqz2f25mvPUuZmw9WQhBEL0EIELOw4?=
 =?us-ascii?Q?Dp/og9qp+Fh/oM/pgp0Mu0b8aZrdT61I1MCDQDyfohjK820gMwuWG4wEkoYb?=
 =?us-ascii?Q?vPpmW+a25oMX8KRO2jzmlXtwOdtp4lZJMafVB8tV5zWs+P6OUYlFB2cJ8axT?=
 =?us-ascii?Q?inmvshUJkTqXwPbLhx5VFnP+L9M1KDYNCsgoMvVIMnNkEoshdf0IBWV0Q5mk?=
 =?us-ascii?Q?JrIAgR1U63eDh0JDfZba8hZgt0IWdt2AS2LyR8Lan/y2UnoB+AtP/Q4IWbj8?=
 =?us-ascii?Q?/AKVILwg6q5XijbILBcJoMYNFcZoxKjNk6O98biw5+51JFvCy9WqNIWQG+r9?=
 =?us-ascii?Q?9U1Xv9FuSSG84Da0XSncWdv2HSUqnd6YPjHMrsBHNLVOO4D9ybP+nPw1zW1/?=
 =?us-ascii?Q?XK/hB2KhtLnU4/DOaW5bqJOZO3ETcwPfcsRc1rgrmYTIEZPi634EAXoULCaF?=
 =?us-ascii?Q?y6BNI+yUdxvG+wEwj8ChBw9EnjzMW4UNO4X6lkxK8ceLLemI+FBQXXCy7bc+?=
 =?us-ascii?Q?8apUL2LCB8Uls/Z1hITMRiw5+vz4BNiChagjTsM8SJgZHrdbYF3iMx7Blg5+?=
 =?us-ascii?Q?LE5TOplFi38BG0CQPb4Aassqde9OpUROv78PhgCYFk6/hou94Zal0/pQmmAl?=
 =?us-ascii?Q?ynWDppe4iaxdhe7P4uvZlrf9UXspdz+H50eHM/M3qnFhx9taG+CNPDksCxFb?=
 =?us-ascii?Q?lUymvv7mVuKT8idrSMd9yt9hF5pgEqzCQbCG6nX5/otI+2IghN6NbUTtEiE9?=
 =?us-ascii?Q?urc=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf5694e-7be6-42aa-7f8d-08daf6e3c98b
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 10:32:22.8061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2025
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ksmbd_neg_token_init_mech_token() and ksmbd_neg_token_targ_resp_token()
share same implementation, unify them.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 fs/ksmbd/asn1.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/ksmbd/asn1.c b/fs/ksmbd/asn1.c
index c03eba090368..c85e74fa78e5 100644
--- a/fs/ksmbd/asn1.c
+++ b/fs/ksmbd/asn1.c
@@ -208,7 +208,7 @@ int ksmbd_neg_token_init_mech_type(void *context, size_t hdrlen,
 	return 0;
 }
 
-int ksmbd_neg_token_init_mech_token(void *context, size_t hdrlen,
+static int ksmbd_neg_token_alloc(void *context, size_t hdrlen,
 				    unsigned char tag, const void *value,
 				    size_t vlen)
 {
@@ -223,17 +223,16 @@ int ksmbd_neg_token_init_mech_token(void *context, size_t hdrlen,
 	return 0;
 }
 
-int ksmbd_neg_token_targ_resp_token(void *context, size_t hdrlen,
+int ksmbd_neg_token_init_mech_token(void *context, size_t hdrlen,
 				    unsigned char tag, const void *value,
 				    size_t vlen)
 {
-	struct ksmbd_conn *conn = context;
-
-	conn->mechToken = kmalloc(vlen + 1, GFP_KERNEL);
-	if (!conn->mechToken)
-		return -ENOMEM;
+	return ksmbd_neg_token_alloc(context, hdrlen, tag, value, vlen);
+}
 
-	memcpy(conn->mechToken, value, vlen);
-	conn->mechToken[vlen] = '\0';
-	return 0;
+int ksmbd_neg_token_targ_resp_token(void *context, size_t hdrlen,
+				    unsigned char tag, const void *value,
+				    size_t vlen)
+{
+	return ksmbd_neg_token_alloc(context, hdrlen, tag, value, vlen);
 }
-- 
2.25.1

