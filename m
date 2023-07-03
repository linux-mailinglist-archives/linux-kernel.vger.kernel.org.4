Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EFA745C46
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjGCMdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGCMdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:33:02 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2131.outbound.protection.outlook.com [40.107.215.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79B911F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 05:33:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWwrP7aBsC/8T/zqy+gkbqtgsuWNdUdpu9lrfCNduRhFy64fe6Lv4BLyHXXPxCfzQWPM90n6XUu09zT5Q3q60PtfcELLwjzVtowvIWcLqOiDB4DmkxKDTruoifh28MfSqcphkShvKiK4Pc4CSv/0uf8XTz13tLEwsM3nXAjsoxCYAAVbwrtg3hLGDpdo9hW+Ghd70qjhp/gPZWbCEtiI5NDq3zfFReo33o37eLTV1QSxmyLZqNttCIdbr45YN9g+EjQYEwvhbLJ2zAH5I4L+Z1F3InNBix3Sb/I4lmr+PmLoT9ibh2A7dJc6Hvjzymq6W2ydMLgYh1nSsLuPzpLC7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8m82linWTRuTX/WARgBkoAdOvyx9WUa71UmGo+5sbA=;
 b=SUCoMHxvSk5WOZk2wbvuknhb2MXR2Mv0jp+BUSZD0npXJplZnK11paKs/S9nYyvEVzOuSj45X4exoruCh+bsmhV7Z9uO/MxnVvPGbq6e20uMEBIVNs14ZW07UqFMwtZe2ET3QsWBl079arAW778l4o1wk9TklzrepJz+vq0sheJqWBzo1zLShCegeqZX9Ax5RcUQyfEkwpaGT0eEwArck93/PM41OOM1QyI+zHchUkUOInK4OGOD3eIaQipDQDGASGYB+Yus2I368wtLF8yrsNrkFgpOB8RW45c/vib/A+U15JnBX5OeJ0PLCZ//dmQVhdj03ERNEUg8xPzic14gNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8m82linWTRuTX/WARgBkoAdOvyx9WUa71UmGo+5sbA=;
 b=NtDshecXLrcpWbIF3/RZ1IJhzShdgtzZMrxvGGtlf27lz4dR5qZ2BUnnqxZOCeg5moiVQ7r9ZTG0tEn8wbdkDdxs1A4H2GTLsP2nuI6lzJHSPQHCGNgA/Tbni/OG4489Klwb474PqWgALepjtOmGtQNTrkyIoJ4X1KI/RXbW7VCoUkIYXUDTTIrjHU/lHUICwCcLGuu/wkzChgnAlyRVVtjBl81NlSCHhggyZnbKT+ImA3Nzl8fxXL08cPrTSNfCeeUazDZBeoueWwMYCc57X8Lt1SFVEliC+SgDIDJqAYXGgNAbmt5pnbH+GHR+kljin7zytwc9Kt9wHmOn//gdlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 KL1PR06MB6134.apcprd06.prod.outlook.com (2603:1096:820:d0::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Mon, 3 Jul 2023 12:32:57 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920%6]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 12:32:56 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     chris@zankel.net, jcmvbkbc@gmail.com, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org, 11162212@vivo.com
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] arch: free dev before return
Date:   Mon,  3 Jul 2023 20:32:43 +0800
Message-Id: <20230703123243.7795-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0046.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::15)
 To SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|KL1PR06MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 110b1c6c-c267-40b0-49ea-08db7bc1a0b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RnHFuQ7JuMZtnZfygtq7VC3daAUspypxe6E2Oy/vvBVCS7BdZ+G2oOj/xKL9vA6Ct0Bgkd6uurx1vd3pDdoB7EykjuzBPPVeXkJALaZGx83sgudAh86d+TM7YTFeBUUPvcj1BO+rX+HoG8kv2OL8I8BUX2HFa23ME/eCRRxYdbAsvcnTLQqwKi0DKDWgtEOrYgeeHXwX9ALrtpELnelQ63LZdh7KRUvcwxhNjs4XOSU/0wp1O01m6kXzZ9p3reP/xhD1EthvTXgbRL5sUOJ/1JAPpPOmbfqMVMsRmIAFvrDa9qyXR13H/hO4nPNAfaj9tS10/rZDEfN6+trU1EFPq3hV/h31l0Z+u5RgQoI0o4mPnr/lssMi6/ficMvBHZmdtywEhEwrxKyKP+Pxfe8uX1/SZUWjfeqxjRgl/HEZQx5Q+XHHD3Ef4Ucv8C4ZZ/1uOg3N/DDfFUaDTTL/W6E98Pum2zX0oiwUt/20RmLbQvggvV0JUWd17Ucy707VfLmtxM6+0DAl0iy9GN53GtfRocN22fgNW4CEcFZAjw/6jml8R31WjZ83xdvl9M2h6lYurcmLbHqtirS7vrGQkMavickKQdMkjH/I9Ct6TiF3yOi6PR3jJ/1VHD+lRwAFmjT2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199021)(41300700001)(6486002)(4744005)(38100700002)(6666004)(38350700002)(52116002)(2616005)(83380400001)(107886003)(6506007)(1076003)(26005)(186003)(6512007)(86362001)(478600001)(316002)(36756003)(2906002)(66476007)(4326008)(66556008)(66946007)(6636002)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+tkUPNNI64NPmD5uTc/R76La/qlIXClKVk1M0ZmrJ0czljjJOU3p3uFm9K4x?=
 =?us-ascii?Q?GbVjfMUk/XiH6etBjUeMfgKYXH/uRnaCO6lX/9TtmE1HhrIp+thVldMPAY9F?=
 =?us-ascii?Q?T6n44RGiTyU1xpdOqr28UB9WXVVl44lKvUxnedw5kCb8Dy66lYdp7Xh+R0Yj?=
 =?us-ascii?Q?xojDeU9i7MAEXDcbhGAGTmnL1gAduoBhwVTQyt7fozqoVf1sPSwIaMwMksJD?=
 =?us-ascii?Q?vuIcbi/kkTGoD/hvlkH+PBha9hh/894fqcAjdDzHAIzlx7etcmWYzTYiSlHE?=
 =?us-ascii?Q?Pg6V9gDmJAldYu4cS5bz7/fgAdJ1DlSDkPnYcMEEbLKA9WXQ5W0R3lpve5XS?=
 =?us-ascii?Q?FEG1S5R/U6nJPFVqOdQcXCH2RB7iGqIrtVkjmYuuJiZg5PHgwa2IwTaiDf0U?=
 =?us-ascii?Q?HRB0pgiaN5Lm9jBaTLgrB/KAAJHhgyU2LZpeSQuWIzAxkReuB0d3mjoR0W/h?=
 =?us-ascii?Q?Slx/WxjWiHz+9vDat5LRt8Xp1ucYn4RlVlvJb0rvG4zV6rZrPMnRJ8MqiYHR?=
 =?us-ascii?Q?eK8umpGUyPakSVYavXCuo4jEtmd+El/1hcmMRKQqzMFZr+25FEe/vJJG6ujj?=
 =?us-ascii?Q?Fz+6+9woRaNSpSUcoL0reDU4AZJvj9sqcLOQUWOnGUBMvhTeFqbLKswJrMy6?=
 =?us-ascii?Q?1RLoQBQPsfXhlti/JaKPz/PhublIt1YuajojhW0mZwWOooN4d/GpZS99s0Wm?=
 =?us-ascii?Q?JvH0OfSud1qLzIuUxDFJN5oGzY1/8k4TcnqU/FBRWWICndV0CaxXecbzCxal?=
 =?us-ascii?Q?mEh/dWtGVabg+c05svBmRFd2HD3e2mJq74Z8Vi43ujariWOkk4hnSXolpUp+?=
 =?us-ascii?Q?F6qDvCbRU5NdvopA0GQKb3pd7JsQRrOzVh3GbWQxq7aOhegJFuXahoTOIOkQ?=
 =?us-ascii?Q?fIeyPw4FiQGDoil8s5f/ioyPhMHFidnoru1Q+w4Jz1tiJakWd9btJ/aVH7hE?=
 =?us-ascii?Q?cHezU7w8Dl0Wyr5F7x8NIN8BIg4yunt6wOszeEbirLrilmkRXfCogWm1yicR?=
 =?us-ascii?Q?2Fd6jplM4xmctCjbKRqNqzqTt5DqFMDe1K6DXIV0yZNI6Qz4aBQUs0JO8c8l?=
 =?us-ascii?Q?64X9pj/vnCGYFEWsGVifdqmiLlHlwRk4U5Vt38pvDqwLnw5NEv6MSOv/D4np?=
 =?us-ascii?Q?2ozj+laujeF37v/ieoyXgi7MDLwkyEiDD4z3t1cfvcN/jyGf63u1Ru8+fPqk?=
 =?us-ascii?Q?lFxbdEpZJwZ8HmavvLEvL9fFrS73fsZE1R3lPRp9g45PUqjER6EzZOk893+m?=
 =?us-ascii?Q?ATxuVTXPBX7o5ih95LIGELojILmLBzBnsMNmO+KYbthWvYJn8tGTgsfepIaj?=
 =?us-ascii?Q?gCSHIo4RUfiB/oIlYvewQPeBbBbv81fs64qjBkntpzECV8jy/H7pzGHBtTy3?=
 =?us-ascii?Q?2e1GP4abcDbQLTCmv0iPVxx3jrUA3B5qAw5e50tLNizwX/vTqyuy1f9W0NEd?=
 =?us-ascii?Q?dGrNBaJLXvJn+DlH+IfAi5TVAVRbi7oWIoSub4bARfYV8z6FLOrM4TS5PzAo?=
 =?us-ascii?Q?7Gev7EMcUwCsKWCIKuwyqrhpXcZMj21u+OLRd7RBBqSAw18DEf6gh7D/AdLr?=
 =?us-ascii?Q?6qIE9vrkccR0xolh6titO7U4MVcE4OZIcvE0wKOf?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110b1c6c-c267-40b0-49ea-08db7bc1a0b3
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 12:32:56.0404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PeX4aNMnbiNEjMFGIO1Dq0FJkwg3igdqds4fk28/ArnuStD285RguG5upgez2XD1KhCnVocuT6QkDImlptftkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6134
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We fixed a bug where the variable dev
was not freed before return.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 arch/xtensa/platforms/iss/network.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
index 9ac46ab3a..e33f3b37c 100644
--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -540,6 +540,7 @@ static void iss_net_configure(int index, char *init)
 		rtnl_unlock();
 		pr_err("%s: error registering net device!\n", dev->name);
 		platform_device_unregister(&lp->pdev);
+		free_netdev(dev);
 		return;
 	}
 	rtnl_unlock();
-- 
2.39.0

