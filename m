Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17845BB799
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 11:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiIQJmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 05:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiIQJm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 05:42:29 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2099.outbound.protection.outlook.com [40.107.104.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677743BC4A
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 02:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITllen4b1L7fEmSFka1UEXFp3Ngbao88eBMkI4Fmnh3d/YbA9wNzkWOaOX6RmB1hAzEEw3Arc2sRrTwoyQcoUSHHteLrnqQB4PwhaaTi7eK3y9lITVKhM4/ydRdDgbD0QrujpibWD8rFt9FsOjGPRkbpKq2Lo1ep39Jc4vOlp17IQVq7H33DUAc8ar6y3CSK82xMpUdeF5s4csKP8DbH3nUXvXw42tP7j2tXb017yqHXMNPqIGADfHvJNlHIi1Sp12/xm/ZxNyOXjyxYefZcLvgi1eGzAFiTDBWHx31wYeSSoMwB6sJGr7JJ8A0gSnvpaL8OZhIHTvAIP2YAjXNTfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roSWDj4h0FFUAJa7PXKangOdoYBJT3gsKNrW71xT7Q8=;
 b=Akkox1zIfnv7R5zg+RlTkmN7jlGaq0ydrifiCXELSg4i3/kv53WbxOlncyPt8EFMNUqQxNL4XFJ1wiOWB3QgPk8aR1co/xQ3zMIDlNQ1ou8QXFlx8jVcDZWiV67CB2IGCq0YTs731v3wNVfr+E5cvD/f2BkHT5oQgUuLHtBSuvkesEPM+B/lkxJjl8mVlAyih1g4WJvGY1wqIvcOFrG85DipHjKq616I3KUzTLkz6vv/WXgML1MmeUyh4OI8ZLE6m7Xrj9X2AX1HgLu+hIbIJahTcTQees3vqNHTUSJb0rBYj+FmtCXOfsl4DGCyyIODFu4oZyQGMuue6vFZ0gaMEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=surban.net; dmarc=pass action=none header.from=surban.net;
 dkim=pass header.d=surban.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=surbannet.onmicrosoft.com; s=selector2-surbannet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roSWDj4h0FFUAJa7PXKangOdoYBJT3gsKNrW71xT7Q8=;
 b=CXQV+uYtt3ypDfZwQ1yagt9+c4frtMvBWjt876uhuHqqH1IBMfBJIlv/hwAd57vgKgPyXtyHjdFShGairX83Y1HpdcYGZ/ARo01nLDN2/LuYki/E0s4hrTJpQvCWgTtZxPa2ERt1WUnfQgwNGpJuFPOU2lk0Mm5rte/a8dJtoP4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=surban.net;
Received: from DB9P189MB1978.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:37d::18)
 by DU0P189MB1866.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:346::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Sat, 17 Sep
 2022 09:42:24 +0000
Received: from DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 ([fe80::415f:7d38:b766:6977]) by DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 ([fe80::415f:7d38:b766:6977%4]) with mapi id 15.20.5632.017; Sat, 17 Sep 2022
 09:42:24 +0000
From:   Sebastian Urban <surban@surban.net>
Cc:     Sebastian Urban <surban@surban.net>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: take OF node reference for MFD cell platform device
Date:   Sat, 17 Sep 2022 11:41:32 +0200
Message-Id: <20220917094132.458194-1-surban@surban.net>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0022.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::7) To DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:37d::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1978:EE_|DU0P189MB1866:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c9c884a-ace6-4536-0c7f-08da9890ecd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bd93w1O5Nox+F/3yNUDtqeym4sD3f2h1QbZ3jGndrYlgdr4+F+XSN5oC3C0mONr4C86ImT2xWR/JIzfXH5yOZ+tSSgySig+uyIzOwtb/PQmz+L4i4PCv/Isxy/2bidUsEu16RHY/z1MpZkuMn1dOVQuXqFIgkSGCo7uSKfztQkdh/Qj7iEuREudaEjd0/lnrMNzNQ7B5jmxYu2pfVtzhcg3roYqNT+10m75FO5AfEZ9Q5kw+k+wud75hdhZruz8N3gSlyKO2C6H4hK8UPw5vNz9ABwnP2TsWAleo3PQ7yvJGNP1OVUUtzDWJmKDvoVeGIV2EwLhFmbJk1i5SBqwNK0YN9PAopH1+nzY7a9mzpBeSTrn3fOrzpesdPEOH7qD5453l5ox+a7ZBdHtoCypHxlIe3t93rlRp1tZZPZ4usCJOY/GqouMZfxLijtWhi3zLrkJcDnKErjM4QnchsDfbqnaOAoxrq+DLQVnV1yz5LipDRjoKpz67SvOZOEe5LUI82KdUaQIC1mTpDWFwrTv+yu+vc0/V27YITk2x6CW0aoY28ZEXst+V+w72dK/ZGAiQtc62ecYNbkZdOxlq3YYmcFDzzGoll77zwtnv869ncA9DLxVm2/diw5v6td/eKui+4+2uUVdAqSl7qb+DhTzu9CBYbpB9Ufhpe6GAoF9gsyTzr/5CCu6gPv0MBpCkpF9WZg8zp00NvOUQoEgurmpmls3uMJq9jGU8/rDSk9PRj7tap7XIiy18IUn4pc5V9T/o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1978.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(39830400003)(346002)(136003)(396003)(451199015)(54906003)(2906002)(38100700002)(316002)(4744005)(478600001)(6512007)(83380400001)(66946007)(6506007)(66476007)(36756003)(6486002)(8936002)(4326008)(5660300002)(8676002)(41300700001)(2616005)(109986005)(6666004)(66556008)(186003)(52116002)(1076003)(86362001)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?svwJBY2J8NivMfAFKBbztZyMM6QtbvcUkhQhdoOlAstpu1YxeoDepHZmNMs0?=
 =?us-ascii?Q?jNPclO0hrpkURZ36RJYX/Y17SRqqtqr/IxRLisBOzQbGDECmLSgEy/YYI/ux?=
 =?us-ascii?Q?pI6ss0sGYT11Fp7Je1ZpwiOI77neldAI/0pJPAmaFYjOyK5KG7Qwru2jHFhg?=
 =?us-ascii?Q?Tp5BMKlUFPrJIZR2ifmws3wQM2PbitcV1HZUpaoUZ6MgS4/PtWH+vjQ9GsTj?=
 =?us-ascii?Q?ISlOvFfpLECmMKVwIJILY7510nTlWw2ggv06gUoFQWnAJxxdpG5k6akKWfaU?=
 =?us-ascii?Q?Ls1mzdK/VLf+5g9SbhfOgyRTeZMskGMm5UkWLJpGlfD96x8tTC7hYQ8YJw4v?=
 =?us-ascii?Q?yFGLLpAdsa5pgPE6+RUqumKZYKWFv2NwYmu3/mUtHuaRhyUzzPRRM+pxt6YK?=
 =?us-ascii?Q?Fe2qsH7BTJxfu5I/Jm3v9xUyVLvIoPaPg/uKl9oC4/ZPwnMRkps90rCbVa9Y?=
 =?us-ascii?Q?vSd106pS+4bfYRpwSszooinJl2I75fbXf7Ppm/cVSBlNQA9diQ2/kUVrxdNH?=
 =?us-ascii?Q?N9LCAJyPAbsoNZb9c+QklCIp1QxzLctV8tzbfyYk6j29TVWS52T+TfDYp7Oo?=
 =?us-ascii?Q?6aYvnIJ1eBeZ5Lc7Kj/7DQNpuZ843SFMqEeLlSXF8Mc1tcLWyEx6OkKKv4HW?=
 =?us-ascii?Q?D6OYY0VnKO8+vpKB5ieD0vNd1nkrZjeivheqUosc3iO88zbi7/oLQCU8s7tB?=
 =?us-ascii?Q?Xj8zi7hlbaCorWw8cnfZJtDAgwKYzjyroWlc7Asb2Y9BCb+60g48tvSeEoWZ?=
 =?us-ascii?Q?5oaaqozzk6WGNf64RgNms4Y1JAzO9QGzR5DOF7ZcLQHGfilUJ4r/ks9/7mli?=
 =?us-ascii?Q?8IdJnVhG+bQFggGz7CQrGCCfszSJoy++IHlJiFAVlZwvi/2v8j9t5noL9l1M?=
 =?us-ascii?Q?creQAxQr2d8je072kC22aOzzcVNOUFqZ7gWbSmn7YMOblUlM/Mktsa5C2CsU?=
 =?us-ascii?Q?RT09lrPVeCwZ0cGNhNI3gOxeO0tFKVxH02xyVdJgZzHKad1EKQ3JVWGn97zW?=
 =?us-ascii?Q?kIKmiuyyCvR2dXXCOUplhJ2UEzT/8bZN8aXDbXicTAd14rMuMgtJWE0G1Wlm?=
 =?us-ascii?Q?NohpivwTYaTk8fDA5ZkeM5QssOOOrHBxdSptNbnyDtr9Mtfzs3EysvqGht1/?=
 =?us-ascii?Q?W6khGLL1dDARDJfiOhE6dyqND2uWtveSB0+nx/tRpYJtAlbVPAJKteBYrVeS?=
 =?us-ascii?Q?IE6+f83k/Yf6Bdz8eO2/d9uBK3NqBsMMq/PkiiY67FtIp4dC8XhPse2qHLDk?=
 =?us-ascii?Q?bdQ0us8eApAUHD6g2PiR4RaVgcrXdQ1ZJqmBrDmlNaavIpcXk4Ymp7B7ByWD?=
 =?us-ascii?Q?cs4ndHY5rTfNMaGduPggyzRZnM5lQH/4fTQv5rT6XwrdPUCsdnEmR8z+vEYQ?=
 =?us-ascii?Q?MrN0xFzzdnb7E5ZHVwhXY0bHTWHDl1Q+mOY7MyINf2/69uQKdZ3LmRsozjro?=
 =?us-ascii?Q?7aHeoEISdZFvPUmmnDe++VCUuozKA75CEbmCkLzlttUbDOv/CKeGMh4TXZ9O?=
 =?us-ascii?Q?fiy4K4u9oUXhwYEZAMvvw+CPGxmyonfzmVP2uJwXQUgXVvPRSx9tO41yeIXN?=
 =?us-ascii?Q?F1hhf3gzvaG2UE2kQR5vywfSTFSEbnRm4lEkQiYaJTZsWUfBQv8lLdDdcL0H?=
 =?us-ascii?Q?OOXHYIVO7YrMdjFxEqK7zk8wVkwK0Ju7Q6p+BJiiTqy7?=
X-OriginatorOrg: surban.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9c884a-ace6-4536-0c7f-08da9890ecd9
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2022 09:42:24.4424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a27af4ff-c4b3-4dec-be8d-845345d2ab67
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YooW4THABTCkGhyvEApDmjq8bvhlTbfhBPI5TvwaCAshFOlhZVD3ZtnGyJslJnB/jK5yjTVC7RGFjpsEXXf5ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P189MB1866
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properly increase OF node reference count when assigning it to a
platform device created for an MFD cell.

Signed-off-by: Sebastian Urban <surban@surban.net>
---
 drivers/mfd/mfd-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 16d1861e9682..8e57f67719cf 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -161,7 +161,7 @@ static int mfd_match_of_node_to_dev(struct platform_device *pdev,
 	of_entry->np = np;
 	list_add_tail(&of_entry->list, &mfd_of_node_list);
 
-	pdev->dev.of_node = np;
+	pdev->dev.of_node = of_node_get(np);
 	pdev->dev.fwnode = &np->fwnode;
 #endif
 	return 0;
-- 
2.34.1

