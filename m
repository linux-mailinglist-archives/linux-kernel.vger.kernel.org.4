Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC716C1FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjCTS3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjCTS3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:29:02 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20724.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::724])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1524920D17
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMdJ6IMOYkhceNRRebiKTVRG1ww24WLt0i/otBzsCHG5voFTDiRnQQHgJALbjg7gJ+spgmJsIj9khMJf24m2NjbwzoSo1OsSjcVcuV0p5VmirF90M2goRrVwhxWlUn/k3jeE2US6m9soohZPdgWVo/EwxQkyN3cOhohOArUY1aQyzRrexEQsZRZ9qy2SNRmsOY0E0nVaVHKNrGwIbQQ+wLws2FKsiG10M1k+0dCnlijULBikYo6pYtuCpi+8qdxoJZarskKC//fMllCw5+KWkRxXjfJH7eJ4UKPFFtyFJzsoElY7Qmv7QfF2Rpfsm/yY2qoKrLOaMDYuHBy1KaQZIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjcCQCDDxemxaFTTSmVn0X1qjESs1pu/oMfTY3Vfz0k=;
 b=cuAUUbGIBR0uydHRT37kyX2c1KxvfpzeFw/Eiyjn0RVsyrTq0yVMeLVKGHnWJvBb9M6zd3uBTw1o9Yw29QCmyZ/YgXfhJQM744tmDnPSfWT4h7coOPQQC8ZkGD0a6Zl5IA1N2CGGSNxBclv6jaddCWy8X1NstQx5L8vChdmhmKqENoOI8U04r8FpUucRobvQQB96X3B7SwucwK+bF970/zdVKfEidWsunu+tSSi0VN//N1mIxcd5wJNYjqd7csCe/1cfYAnpRpGTOX3TAeAKjWn5+RRRPqx9Cu7nCnObx/5FsZMX0FrXVQiAAlg2bXwy5XZ1H8v1ATyTwPpx2A28yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjcCQCDDxemxaFTTSmVn0X1qjESs1pu/oMfTY3Vfz0k=;
 b=FP8WASf8S+HFc274OdRJN2R1xiDf70cWYcRxaelwJZqFz/gAYxE4EWfjXBRGceKJ9njzNbIaAQ4tlGNwNqJFHttsKHoobiEo+xlh/a2mK9BMWTShF4H5c3OwUaycLgY4xnqlS7hLIxwH22TMZztPJbthocwmgCdaLvN2w1zxYrReUrK7jA0gzndW4CE9wjQYv0nROL3K3H3WhhQQMeYkfB6EshACwPlVp8QmGK3gopLyNPyxmzC0bJRaXqtZZIZQme+MJU3OYefeHbapRLL6Q7z5qcf78UHzeCtvsrS/T9xQ0O97zWSb+N9nJ5zS1mHlUyQfZUXT6FuB/ZcD28IBVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4208.apcprd06.prod.outlook.com (2603:1096:400:27::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 18:21:13 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 18:21:13 +0000
From:   Yangtao Li <frank.li@vivo.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: mark ecryptfs as orphan state
Date:   Tue, 21 Mar 2023 02:21:03 +0800
Message-Id: <20230320182103.46350-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB4208:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c1f237-17a7-494c-2aa5-08db296fe328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vk8/O6qLuiXmiW1wk4LMPBHZ3WIkOH4YElZ6jop1siRJoUdi0dTqWc09zvqchasmsbQASYD5iLP+vpC6U/54bpHgdqOo98WCk9ML2njtBer0l7E7xLCFFS+2RQnRm3mcwq9XeJKjaNwdQrGeAtthoZzBtErZc/0DK4Sc4lfb0AIho6LOqnCtQPJYvfD0sr6qaLLDcccg5/Owf/XTxVyr7Xde51prxgMvGv5JNHj5zyW3uPyZlCsmggLMpb0Ir/wln5x0CfO6HUaFuYfQcWiKQPSdFxmJ9xp4zZ7IU172OQL7MTOhw/CqVwFiMaF9hFpehNf77NSYuysRCK0Fnp/ZgkjF/1NTZsK/Jw/Sa99mwE3GuvCf9cNgX9gaR+JivmVd/y8bDXuIBfZ0xZrV+cHrpXehxUilRaTVEqo3A3TBqNJOpoymz7oVdsKeZjLyzpxNQRkI4zh4rXbSx8d0xQInQJdktitam0Pb2PlC3vpXJb1KVMtheT91Eazbog4wkV994t885ciymLSb8t8b6V/3I+juEz6j6AsH+1CnLVZa7l5Qlxaegq/X6HsZEPoWRocbBdcRVJIesiccX9pIp7hcbPG+vl+SBBRt4DCSt5Ke494ANB39mq6mLyba4qoVNjyjiaj90ZQMaslbcbchn7OZis1byoN/jQ5JwAaiGZMTF/45YHT8ugGyS+dnUu3ghLI319hdXy8n/Y5kDqzVTaG8qQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(109986016)(451199018)(8936002)(5660300002)(4744005)(41300700001)(86362001)(38100700002)(38350700002)(2906002)(36756003)(4326008)(966005)(6486002)(478600001)(83380400001)(52116002)(6666004)(2616005)(186003)(26005)(6506007)(6512007)(1076003)(54906003)(316002)(8676002)(66556008)(66946007)(66476007)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8buKi+K3FEmqzVqurXEWyH+88kt9r3nyU3sJWH6d6vP6zwMXiuOMOQctIkPk?=
 =?us-ascii?Q?V2z2l9UH8XKMXbwOG+/nkxWy3QDTIulfFbkvp9SxMyDBQlWBJWGV7HtXWYqm?=
 =?us-ascii?Q?PJH4d/6NYFGG8C7GPMSuqQpd5FSqtTCSE615U+g7xPRspgB0PJViylCIbau+?=
 =?us-ascii?Q?RoJgntXM9sdHuKBr4RUnkCyUlvIaJsHqsl6ncbOxaI/xMoZn6xmccxDpoDmY?=
 =?us-ascii?Q?ZKew/H7VsdS+guabxXQORxsk0ANyhu0fSSZC8yNrt5aF8eAv3UtXjXGQZGoG?=
 =?us-ascii?Q?KofoHQMRo3Sa0ZZd55mwHlkzqz9Rix1fS+VCK5rjEbyKN2oQ3VZrJjN08Hys?=
 =?us-ascii?Q?IKoZLNNpUJC8J0mUdoQFpV9jFieZ3C6gYmdMsKQBNsfWo8ltmK5hCcKA54bp?=
 =?us-ascii?Q?mY6kAQz1YCZDB0WcURJm+nA+pPN0R+ttEeEl2j1KhIZflKFn7ZrOWk/nqp2O?=
 =?us-ascii?Q?xtmLahdxff8n4xDt4tSsGpYqVglR551nWEkZP+KWMZI129Ggqs9AgziujPTU?=
 =?us-ascii?Q?aGx7uERtIZbXdhNyhOTlyJoCbW0TdqIC6em0P/MLD6eopxOBDbch460eIAb8?=
 =?us-ascii?Q?+kBTC2EC4ftA8/HpZEosag4o3dVPWXzpeK5ynjeKxqvJlzhSELq2TGNtwjqJ?=
 =?us-ascii?Q?L2yQK7l2vObiTAkxizegdwYz2Rwh7bm/OAk7ODiJFHWFbbqE8TaReLLrRBcK?=
 =?us-ascii?Q?c6dNAeQfaBM3SAsdLiCWTH495JzSAyoCesS/e2zJrPJH3L7TrxyCgCXyIDnS?=
 =?us-ascii?Q?hzI8ph+5A4sngyyryu1Z58YWIvQ90YW5Xi2v/Wh8fZHMKCc54wcbZh5sFoHB?=
 =?us-ascii?Q?PUhC+oeMicY8J3X6EOffoDg7TmTSM9OoCoyh86GNEgYO63Y+VJAB1Jz5hS6r?=
 =?us-ascii?Q?OAbwW7PGn6y7LXi3WF1HrEEiEZwDidoXr/GopmQrI/I3sGS0CfJy1D76Do6O?=
 =?us-ascii?Q?NS6mDoeA3sSD8T9GTp+bC4td3xbC747hqfu4ejTFbXZJc/TibaXAVzUUtrPc?=
 =?us-ascii?Q?bJjTttf+QYb/zFjtA2t9YDi07SGIXb5feq/M6ku7VEaXVCSOvr+rd2GicWXh?=
 =?us-ascii?Q?vddxTw6nZKJOqZifJcGoofXCvEOTP/nBGkFEU2vS8A0MJnU6XW5FM4wB5SHF?=
 =?us-ascii?Q?A+aWpAMBh5ATHlZmEKuoHO4EnknrCHIDVbDqOB82K6c+/5/tiW6JyroliOA5?=
 =?us-ascii?Q?UARgAoN8PPo9FtQa9aw9wqgl7BL7oiDRRhyaP/7qElQhMFt43hDlu3CO+Cf7?=
 =?us-ascii?Q?QOvqqfnV9aXAj9uOqCzo07UY/VD7w1iwV0fhIVToGJYVVWY5w5/1znp3bEwt?=
 =?us-ascii?Q?zlFNtTntSmbjYgcbwAYAK2d2YGIDZVZCxRURYR140t+e2TeNWBlz2Xfdxvt0?=
 =?us-ascii?Q?rRb9CZZZ4AHewg7304EcvL/lmVqGTceA8ElFtsiriAVpc96yJp8QI5QjLS9R?=
 =?us-ascii?Q?gtiFg9//0jPE/kHH4GxM9h/jU/DdOD2StccQyxEY3hC8PILktOQonsnffV4i?=
 =?us-ascii?Q?ubKzNSWpXw8XcIAKlduVNqksxJc++9QuNPcuoXuLlbKwIxdcy/Q0Omt3QC66?=
 =?us-ascii?Q?A/lvMGC2gDX37g63XDpMuohDetdBP2YWENpXCmqQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c1f237-17a7-494c-2aa5-08db296fe328
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 18:21:13.4257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WP5TYF4ndcoItw4cRx9V5Yt+qhyjWIOJd1mb53xEB8BchsAPohYCDCoRKG3clhvfcVzYoklBDcqd/w4XLGGjww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4208
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ecryptfs has been inactive for a long time, and in fact the filesystem
has no active maintainers. I sent a patch last August, no response
till now. Let's mark it as Orphan status.

Maybe in 2025 we can remove this unmaintained file system?

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 541e7dc05f48..4a6236d5a6ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7270,7 +7270,7 @@ F:	drivers/media/dvb-frontends/ec100*
 ECRYPT FILE SYSTEM
 M:	Tyler Hicks <code@tyhicks.com>
 L:	ecryptfs@vger.kernel.org
-S:	Odd Fixes
+S:	Orphan
 W:	http://ecryptfs.org
 W:	https://launchpad.net/ecryptfs
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git
-- 
2.35.1

