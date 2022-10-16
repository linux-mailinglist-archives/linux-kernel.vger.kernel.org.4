Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5281C60006F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiJPPKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiJPPK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:10:27 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2070.outbound.protection.outlook.com [40.92.98.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE5A2A97A
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:10:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKshRsOtTXq5qRJuO+pQ68REP+pcanWGOtBWoPovk4vz4qrh7wUDLCCEawexN5+w3aSZYvkpWhWnwxj5brG/kcQJn7NafzNLf6BD5UbukUT/KmajuwN/7yuBc5NRJScgE5YGPfPnLWb7d1TAdTBvtoezYbESzXjVftd8X41GgTvmti9heUzMvZAD5mE1niwRwprO+MP+J+qLLvU1DH8khThlnpEafSPtYVSQ5hrez6dWVU5FCJ9LP4OOUmhU6YZSNyzQxlOd7oGwItVHuHwsHzlLTdvgmL+/bxTgnv9o9wbPQq8oF+pOloB0+EpalfAD9I8cyvUDludeuS4Myrg+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fV7ncCvYRjaI1s9FvDKq7CjUYER3zkw4M2T7ymiYads=;
 b=j674CbTg+3IXvik9S2yC08Ue+/6fUbdvkFkSZoblxbbwBJoft0581LSWhfYmhEWwjM1kJXFeaDS3CMvoprZUVGn3ojG6COnyB8ZFqIbUqZI+ddPZ/IrQai3Flhrov/D8qmMHQ4Ppo3h+Zi3elrhTx9veds9NwXJGSN/rYGnRjDFJGtR6zW5E3T754JSROzdJWFA4sb6Jg7JqfdnkJmW/Pl+n5UKCWfQQ6ipzzzYCf7E+HxaQHFiyAq5NAcp+AAuETfFNBo0LesrGLXH5uIz8v77ZPG5z0o2v2uyK7fhuWCiGEFVIsDSlMwqbQfCqR8Y7YNW0dV+sPb+RjVjIdOjp3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fV7ncCvYRjaI1s9FvDKq7CjUYER3zkw4M2T7ymiYads=;
 b=OtywiukGAKtxnVLZSQmXoR9IgdQH6uJBZ2XUpxfIGTRZVejPRTcg4LFOxpvqMATIbype2F1zBwox0w/Iobz3zRh5ROfKkBo/jlg1wy8eGXmJoU0rfjVZxQ//la0xWvnNSIRCd2OaLgBszPZuMzIT8t+Wis3lExF0k1huuPqwnkqPbEZTnwEOH5jbP690qqVHY466hzrp7C/HfLWJdlJgYM19uu+93/Q/J+7rMwVSDgAZivnPMydlJOQC7nMz7gwhJXIJ4uFbeKr8DI/DT7pE2AcElnfutZsbfDsw2zPPF7ypogFRdk50NiuNYEMYnG76IMmBZTjFp/rVgOBAhbOEgw==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by OSZP286MB1534.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Sun, 16 Oct
 2022 15:10:19 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4722:62da:4861:9d73]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4722:62da:4861:9d73%3]) with mapi id 15.20.5723.032; Sun, 16 Oct 2022
 15:10:19 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH] um: protect find_task_by_pid_ns() with rcu lock
Date:   Sun, 16 Oct 2022 23:10:05 +0800
Message-ID: <TYCP286MB2323CA02DF3A741B5F58B297CA269@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [yB22yFvLwfEwVWXOVahJJnYgVWNpJSfv]
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20221016151005.1449803-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|OSZP286MB1534:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1347b7-3ba3-49a0-f6a3-08daaf888a25
X-MS-Exchange-SLBlob-MailProps: 30ekHghIwFpFSknDzxoWHvnwgnImnwcfWnCEcx+XI+b7QKh3HS5oTg7S6mo/KTg2CrG7/FVqrMNnc3H5Z+iHvh99nkx5rLRgxiEWiF1V9bCF9Y0bKhkVZ0t2nmnjHFnaADceRII4XtSasotHHOJ/i4xc+AQxIXva9xCEz4nn01i5afje7EQdkL53oFi/JzPfrxwHzmxS4JZDL65RS/dX8JTuDlbjLE43dBF+x/MuU2DmJ1CghTXY8d+DXRrYCi2aaXLnx/BuS8wix5m7FdaedNG+/fEL23f1I5s2i4056zkHeGA5YRKLKlbC6bLEWprC4kuqa0i6dxZnNjs2fD99dsrq5TZ3B59+/dT0Kywpwf/LC6I7nvMGH6PmtzQaY/hF6cXpg3N4e40Qm4b1aAUHMl4TFCHKNaS6/AteCgv5A/TL96S0ESsboQpE6j2Xs+O6VsGxvIq6vMKrjbChEDQDcaw0+P+JoVzbEXruaLG0pDZQGD95OwXzwRFY2WBzrqUoujZYGAqBJ2JqmECGsnqoocAd4FdIFvicsvqC1M9aym4+5QFAYrSrjKKyhe/FeQsgrcJ20HtwjayEOhsXVs5MCEKNHm8BCWOJx/8nrn3Q9I63b0Cm4M7w2NHNZU1s1F37jCVu6Bbi+g2P9dKdnHTCzSxGhwtTRHRJGQNf8ZYGtIQuGAtncYWYRxY8I8HvMt2jGOsdtxuYZNTjy+KRUhZZCevIjdtXfQGsGA+tPvIXhKnNJAh/aTvaPyqHPKZ5Q9ki
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WpIXuSCCK4P8t0jOfsOGWHtvs2r9BAoHp3n+8/Wornhi7nPCeS+IKzyJiDE7hl8lIP0uRMO4UXK8c0M1Ag90NoOJTOjV2atDXaQvNFfyoIE+nEqDEqpQ4hu6tT7IzT9ITNcyTL5bxWfnaCm1rmY2jyH/445AloOohSu+Dw5y317O5vXG8EU4Y2U6rom0VbDTtYibRIJekOCGQ4LwJN8BNDBCKSQCcDddu0ya2uMWo2z6W1NUUidohEwADq2XLqezc51odGi35Js9nryAVGAexAQsQKGi/TL4PGtVYIGz86dYS6uXsRUnWsviUsz6dkKFvfP3BXYLSIir2isiPuqGIG4/HlYxGIbR4uD8MPGFFNB/vF6R2Kiz4xtezMFgBNhShnmKjpuammqT93Vixhj7kAZJQ6l/dPFif5Wy7bypVjgugEN1aEoWPc1/R98BkB0B4RUF7XZBUIdlPdqmkZu69IxutdUon2s+/u7lE8ngjLfyaOkSmnrozra8iotKDTw0y93E3wfjzR8drIjLhw0wcJ2sWQfSGqhOB8Q8tNe4BTi9okJev8aic/FORrLOcnpisq0EyuoehrZtMHlI26Hu3Q89C4aYBx/4p+4Kf8YGFEjo3V/x4zKMH1OPrsaLbbTg/xa/BGPOAb3KldE+95j+eC/EcOXnw3viL5iDXN2TcdPf41G0iydlt9TvOcMjkwLZ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kcKO8dEjy3NO1U0lA0f7ctTmeNs/hnxS+ITBGDriApY08QtclqbDMFhsn6mc?=
 =?us-ascii?Q?3tqo2+RJlyoUCRqUXCfvKM+kTP5UpJUUk8pC+fofLpbKhK2Nva2hsuJ/PGjS?=
 =?us-ascii?Q?27KkHKFIwfStzFoeGhEkN7KJr3Ql0GnAp4JlbkUGL6q73UixDPq+/CleQxyq?=
 =?us-ascii?Q?a/t2ubYDqewuBN7caIOPfVC2ix0ymQg7IS81u0QsBAB4nlQs77iaBRcCSrTZ?=
 =?us-ascii?Q?RZ4XX7TaSBmRg2rZNhDP9DY9zj/dJQD4+7j7QiWGfeQxwZ0wYKUeUrSfNu9I?=
 =?us-ascii?Q?0st0xlkT7CfXyNK3tT2ksgJ/JaOk2QqacoJXlTb6XNjlzNaLKC78JGaQ3f+/?=
 =?us-ascii?Q?IchL99hWuV0jeV4d8DRUgPV5KexkDKJuh9InDwmPiNSSEo9S49gKVPpP7u5m?=
 =?us-ascii?Q?vNW3EvHHJImkTyI+RTKimySZ8yv91zKlM0AnaWpVqCTvwZFgiV7g/EEDLDQs?=
 =?us-ascii?Q?4IkKrySZqUCNdNDM0SV3k7f/VUj5Y5cJzvvlnpgZhwmaiguLWrG5AGWt5JsB?=
 =?us-ascii?Q?gAvxy2WFWtDEsBIydzE0PMvDvzrMgIQZXqupnBhQoKb0pQNgwyF9gbmLrwzS?=
 =?us-ascii?Q?w0kPsb71aRAUilOg5kmcoV6zKKvOh5NGcbtIuQOOPGioqY3qrJ5u/KpCr+yA?=
 =?us-ascii?Q?HX3hkiyw+DxSIcuwsimw+NLRdW8moTq+alsZjqRgz6WFDc4C7uEaepRg22Ir?=
 =?us-ascii?Q?7Cc+hhSkMooSPiqtjYZiNrPj2gKoTw+YRrNaDr78lr1dyOh7ti6mE/ylDu9R?=
 =?us-ascii?Q?WmLSAx3Fv6k9F5k2yrWkjn3qE8mca3qzBrrDBgGxMZMi4h8Nsz9bgP1/c1Kv?=
 =?us-ascii?Q?EgG46NCzO0IMTBH+u7hIlbvRZoS1xkUdp3p0X1RNtkWohCJHLIU9jqym05AQ?=
 =?us-ascii?Q?tgVM3ChKSQzvLe7XhRM7yHcSc4Ek2PNpnK09p646SEjTN9NPKg5L0oe6JfC9?=
 =?us-ascii?Q?jhfCeEYieqxEjDYDyUwFyAzCAYTKXXrt3rQaNqrVN7vK5lYRrj2GXihzLgJt?=
 =?us-ascii?Q?dF/Axa9JVlUQUhpROmnbWpD4KvWyRrnk8a9o4Ums3ebIM7QWDUk86gXYJP6Z?=
 =?us-ascii?Q?KMB8VzLqCfN3Z2t+fI+TXewoiH8sPA24BseJGQBgY1dXdl6DScL/EYRuhR0Z?=
 =?us-ascii?Q?1aKFBRAgtx839ZEzZJkcofZZbhf0D6dJ/UlSZ0lgP+5TiXUGo6veaej8Mqo6?=
 =?us-ascii?Q?UHnPqtr4bhH9CvgxEzlKd9DSLD9TMMfwW/P8jeSAnv0gRIOUiVnjn+l+X9S7?=
 =?us-ascii?Q?0orlIFxmqnxjNM97GR7G03wF5A2zK+os/2AJQIQYwQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1347b7-3ba3-49a0-f6a3-08daaf888a25
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2022 15:10:19.7471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1534
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_task_by_pid_ns() is safe if and only if it's under protection
from rcu read lock, implements the protection.

base-commit: 193cb8372424184dde28088a4230a5fed0afb0ad

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 arch/um/drivers/mconsole_kern.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index 5026e7b9adfe..6b80e766ae80 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -683,7 +683,10 @@ void mconsole_stack(struct mc_request *req)
 		return;
 	}
 
+	rcu_read_lock();
 	to = find_task_by_pid_ns(pid_requested, &init_pid_ns);
+	rcu_read_unlock();
+
 	if ((to == NULL) || (pid_requested == 0)) {
 		mconsole_reply(req, "Couldn't find that pid", 1, 0);
 		return;
-- 
2.25.1

