Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD516766CA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 15:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjAUOw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 09:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjAUOw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 09:52:57 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2088.outbound.protection.outlook.com [40.107.15.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5891D6A46
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 06:52:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bw91UxltehCQ8BhzM+vPDYnUirZdxNpDELdTEvbChJPaY4LEVWNNknO4vDnq5A7+E269WvTQKhFFwDSxeWzjeR3xEmf3LCMmcgrELr5df09FRqjvWGXDeZpr5+qhKUEkGAZ4RT/t+V40hkq/znzTcbqjEVpG+CogF9Hq5gRBm4FDJ4fbyVIl2BRiSe2Sfp6Mi3I7J/AmUUQNyxKRvTkTnocQbFEfSvt64NaEFrRZQf25av0lbuLpMgM87Kh3Df9AI09fQXGhp6MCYEuH52lYlqISvPzRKjyXHJYfWR56xkXHsqVb0ItdFbYx1QNYpS3v2CbnYvYbNoj/6fj8v0eyng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3IEtz//iqd1MLOC69KSMpwD/J/pAkVec8TEcM9k9iE=;
 b=GWFWOS8HwvrsWxf14Gy6XocODJTxgebY+4bma080K1FyQmMQLr3aRk5+criLoNqe49wLeVn8jNn+ncgH9uuWWArDibdlJWuqmOF4Rc7/jcyc23NSz78QAioq0+5hCsnhkkeChKb9Ht8lPPYVqGsTLbn9ERskBma9nR2qAIaR045sWrhAm6zsCm9sY+xvHHCI47ZFxDylBoyKrtGc+WbDl51WlNHDgzGkrqPWEUG1bzu747aPzJGoXKWpd8kD4KnGG0eSfVOvgBT619MZiuQSBm5qgiPKdvjSJsKuWBU3rGjXKQ7UmD1eT1x9LbjsnuJVTDI52Qb2JH1LB5xtb9gMlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3IEtz//iqd1MLOC69KSMpwD/J/pAkVec8TEcM9k9iE=;
 b=lc7qF7wNAw1dO0aFC+uRrNc8hnykGTK0fX8mxU4p+2QBEUKIUjaGc/xk4J4wFq5bW64Wy1eLuMi72aSwN0Wbg8L8rKAk7lgTEF/g/71/yWrFzYqpOrwafW4PkZs0YL9XwVfMcI3zpki+npLfe99/8D+n3U64BxyjyuA54NoftpO8RaRdgNTakduO79D8yS0uuu16FA3kNwIoy98jj/3y7dK862wtAMjcz8vHvwFF60Sv7Cw6Mbi8qDNA7N8AU7gkQpsgZt1Hcr9Pes3gbeDYmr5VIWb3FEpgGlGBK3bqS8uBGZlsw6eYHbBPoq/URCyv+Kpl682Tu9r7UvEK69u9mQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by PR3PR08MB5705.eurprd08.prod.outlook.com (2603:10a6:102:93::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28; Sat, 21 Jan
 2023 14:52:50 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::4e5b:51c8:1237:1fee]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::4e5b:51c8:1237:1fee%5]) with mapi id 15.20.6002.027; Sat, 21 Jan 2023
 14:52:50 +0000
From:   Pierluigi Passaro <pierluigi.p@variscite.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     eran.m@variscite.com, nate.d@variscite.com,
        francesco.f@variscite.com, pierluigi.passaro@gmail.com,
        Pierluigi Passaro <pierluigi.p@variscite.com>
Subject: [PATCH] ARM: imx: mach-imx6ul: add imx6ulz support
Date:   Sat, 21 Jan 2023 15:52:42 +0100
Message-Id: <20230121145242.6969-1-pierluigi.p@variscite.com>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0120.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::17) To AM6PR08MB4376.eurprd08.prod.outlook.com
 (2603:10a6:20b:bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4376:EE_|PR3PR08MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: c74167e3-cb10-4454-835c-08dafbbf2b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uF51ChlElTTVUWmGHHkIboaSFRbCvnwfJBNh64iV0zUym1yHZZe7Ef1JD/0lSNNQAEt4o0DfIaqki0vUPM3BRH9Ov/eJER6N69m3yyXKqXIDbfwQMAvIikw71Lp+shb0kcOrYQumd7TnmqpVP8IbYlo1x5apbVObkkkrocX2YWPRO2cZhw0vaD+AA8nSWCLkfV8MMG5Nz9+Ha1STGSXMeXMls3s3XOtAfR/Z58zTVL2r2JNypn5y4SFEUt7LAIB14gFUHTvJHPoD1ObPxkF2xJnrmNywiS590brYXHJxWiyGiyy0tjDYCGoNYAxpDv/fh0Rp3uepBKvyZwvKjVrkngThhcKGP8B4v8pCJnJpXPq/q4CKfotQhn+ygXzTlPtrI2/J/UZqGBNd24xTl3m1OWgxh/Eq2k5PxmLsboFs7Rr3y14sgVm/fduC2NyofwlDs3PJoI+yar9EzzxW3rdkS62I8DdZb5WgcGJ7EqyfSGayxE9Mbid0Vvyf41vD5ZG9EdRFhH10SIeoa2ZktAit5QUUHybzajGCCiNBeTAnjRTwStsJRyP/mV06Zs6+zfNDihEX/UrETaMlLuybFes2+bTYPoPlFNzneORC1eSRp/MeT+R0U8Lqr0JxINJvbTIhGc4TH2A+ifeijJAjgiP5wyjy9l0Q+wQIMIu7P11OCzBUZg59iTtO8dutKUheTqNFB3G3HWZ1YLY/yzzPWxlzSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(366004)(396003)(39840400004)(451199015)(26005)(86362001)(2906002)(4326008)(66946007)(4744005)(5660300002)(38100700002)(38350700002)(36756003)(8676002)(8936002)(52116002)(6486002)(6506007)(1076003)(316002)(107886003)(6512007)(186003)(6666004)(478600001)(41300700001)(66476007)(66556008)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MGxcsFuHLPYJeoda52URbIFb/1leY98ysmJCg07yNqQYjPqZUsa3djBBnLpc?=
 =?us-ascii?Q?eyY8NosJ9He2azjAWjtstfkFJohNvhDb86tY5xmP3x4eQFlburNoDez71JLo?=
 =?us-ascii?Q?rT7Is2Zh6sB+7aE/ovVrtURIpo2/XGVBAcHt5s7AnbGVuUmYf9p2Bw4NyJFs?=
 =?us-ascii?Q?aRq/9VAh5I+BbywCCxAvlrAxJnTpMl/FZq1S9FFpn4sBWzazW4U8ihReQeoe?=
 =?us-ascii?Q?vBGuS6CRJKwkOgIlUmIjPLJe7q+Qd3w9jRxpZO/i+h1BDzYzPEQ+e34Rt21z?=
 =?us-ascii?Q?GXxYj0d0rPeVowGBHObxTxekrL1XGGGjN/5BS2/onTRgzoKicpepfy6ZjqQn?=
 =?us-ascii?Q?oNVrV18rls9dnni44Jzjh9Rzr9l24N2B3S5fgF9rQ6UGE3/URGgP0GeN/1OH?=
 =?us-ascii?Q?nt+Nm6Hn7V1oNBl6zOj4oufSsAeLtgBbtw1Nrd+MU9SOjkZbc6pfarY6rItv?=
 =?us-ascii?Q?Irft4JTQpiQppoBDapRA4FrLxBcxWUfSvaZzXWl/j4ZkYXB6Ci76vvQInQXQ?=
 =?us-ascii?Q?tqc32QjoAw2LbH73SEerAOPR+dxZA85oPD6e48MeF3uZVx4hQgkfduveuEHY?=
 =?us-ascii?Q?S11Cs72DjJTo98XWiIWuIF+HgVOiZIfaVllXQnwitBi3/6hlHaZQ/2dz2wWC?=
 =?us-ascii?Q?c7Bhgrz+uaRPGGTxif5RMqMTYKvPIhjbhCSlCTtCX6meBbpx6fil+8cFqqvl?=
 =?us-ascii?Q?x9E0yL1Ubx2kacIKa7A8/3eimTWnM+qpNpllHaVs2D6OibpLr91nJyPSmVN/?=
 =?us-ascii?Q?VBFy9hcrkxpzfPz8HfnDHVMwLrC9NlP4jztSVx9V3miMIN4HDRR4lq4luT+8?=
 =?us-ascii?Q?HwtiUE3T3y6ziv2XU/kd+qL64m5OQvRohAONGJgOIF65+m+X5BwmdWuQ1lee?=
 =?us-ascii?Q?8milrpHKkaQYmEGDvBumMvQEzeOrc1Oc3ZvhbGMz/ndd4ta9y2irlZ/UdvXh?=
 =?us-ascii?Q?+I6Rep3L1FmICjvA5Su13XuRqeSdHslAms26k4J5KJKYIc5P6aCsE+lIck5g?=
 =?us-ascii?Q?PcuA9YWmbXUOmQVmENjuvN4zrH56cMVtwXha+GtB96CJc6h/UE2k5tvUMmYz?=
 =?us-ascii?Q?Q34RcEXQ2s0fm3T57X5Bv+QYbnV0fQPPFi5EHGhdttBM0thT8Sg50ZI5OOFH?=
 =?us-ascii?Q?YSK/jlaVSbkAuIVxKMZpe8PsJ9Nb3HOJzWBTQnt7hND1isOpoe5QQUU9y5g1?=
 =?us-ascii?Q?QYEBVZ/A/sx+yiGnkzw0S5dc25A6orINBqh1Y3M5F/cI1qIIeYwCtW+5ONYP?=
 =?us-ascii?Q?sZlogxRw8s/VtCkYG01Mek/QEdLVRaoxI6U7w9EIA4E3AHiCstPL5JYEXwGO?=
 =?us-ascii?Q?qYDMBsgq+dYOuS2qXG62dJqNdfiSBzgBHoAU/QPJQRens39HdXhSEyJstyf+?=
 =?us-ascii?Q?uPkbc82pP/02RA5hSzO7STVySIZz/09xIGttm5GEWiMrn2m6jzUjFMnB0i/T?=
 =?us-ascii?Q?kURNm6bLLd4RI8fSBiSvYMw+kXpzBvhW9Hb3MupcRoBuebl5DE4lK3bOE2Va?=
 =?us-ascii?Q?vByETc+efE1jcaMrFctDfSn7siQSup8HQ7IPFDL84u0+PwfYSYiekYdAF39H?=
 =?us-ascii?Q?ZA9Gm/WX/ewoko8PF6+Kxkd7akZHfDRXZDTIiJzzBIEXmfpsexT1NBW87NPI?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74167e3-cb10-4454-835c-08dafbbf2b0a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4376.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2023 14:52:50.8124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19SddbO0SbucbeCG81gEsJ1qFvObVcwKRFgR6+1qheEN+or6ipWvYxmBRSavLf9g54o4QfSocsmHZ99GIgRbGR57UbF0klN28Xuwoeg2ATM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5705
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

imx6ulz is derived SoC from imx6ull.
Currently, the boards based on imx6ulz are correctly recognized only if
the compatible includes "fsl,imx6ull", while "fsl,imx6ulz" is ignored.

Signed-off-by: Pierluigi Passaro <pierluigi.p@variscite.com>
---
 arch/arm/mach-imx/mach-imx6ul.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
index 35e81201cb5d..dbf8d19cef11 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -63,6 +63,7 @@ static void __init imx6ul_init_late(void)
 static const char * const imx6ul_dt_compat[] __initconst = {
 	"fsl,imx6ul",
 	"fsl,imx6ull",
+	"fsl,imx6ulz",
 	NULL,
 };
 
-- 
2.37.2

