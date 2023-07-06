Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AC0749AED
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjGFLkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjGFLkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:40:11 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20715.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::715])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC92A199F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 04:40:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaRZMWzSsDKTVv9EACZ75I94nR2zhwOD+LDOU4A9xG4+Hmj1nlCdl/NE+ed1haBODN1N+onogmVRdrg4oCQDg3ld5YJIasE9qp9Aw1U6UMTOUmlabdZhL071PPFPu4ahM1AwEAmCTR9OOgKmX7EB7SYl4iIvEtWmom+zQMQKpJmErpLFM4reweosN3nx1b0ZE5APCKbKM/Gv5c0BSUTwB0ak2NbtyOdBmXAypJKZ0B5UnNb0MJ1bwhMYbn/a5QXb19ndzOnZmFleI8P2/pkzOL6hDIWAsL/FnrLbv77t8OoD4zsFKuoKFTAxRIINRC749uG8qJmsATzSEajGAh7GQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkkgF8YHddSyx8rnTy7lYfUam+fBm30/3EkM/GLn1GE=;
 b=PZokQ6oFmbg89zOVVolPORUA8Pyblpg0ip+5P6El9O1FX3emeGGE8/xAIfo0XXKcyR6HtmGTuyixQGUPN1AkKwRwAQUanvtXJIKXY0CGrnwCkFh5yKpiE6mcDC2KLNCzy5y8QgExTUAQnBLpBWrlb4lgvOjXkcuEoiqFsxAUOoSY/CXpvqH3R4uBVkzfDqI2VjNr7IU/+j2ByAdVxddsPNAQjqdxb1ZTxBcpgknk9AXOt7ryF9xILic+q2Pvhoc7Pfb0RdL2wrY+JJJdYYP4KJkuMkZ3xLImoHiz+lRXBgXqJsoVB4878UOaM2y0E3B2mczQZKdbYzbj5NIUu8FgeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkkgF8YHddSyx8rnTy7lYfUam+fBm30/3EkM/GLn1GE=;
 b=iwvJX0453caonVeRj+y7P4toQ6Ya6ZUyVuTk3HVkte5wzLZ3j5mYCtIAmPJpR/4VDXw+9BzyrJHcOdZ51+wlGGsWT5tfKGgbgP4rQtM87u+LHRyARATs600ofkY75pVkrQfNVTP7oXRn9femVLiyfKqTRRpIE+K7SMYGAlRmFw6XJ60K05hyMRMWRK+e251ovQbx/YnfAXMrAY3iMaacTF1qHmtsS5uqMSlQfhNQ7OnT5dxhPHkZQonKobNuAVv+OwERJ/M6WQMgq36MB6EdyoDmgzvoxSNKeQ7RGdFpoIitBxeJ/i8JU2MR8/WQBxurrv+yk6ZhvN//QFRXDhLehA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5889.apcprd06.prod.outlook.com (2603:1096:101:d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 11:39:58 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 11:39:58 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Lee Jones <lee@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] mfd: stm32-timers: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 19:39:38 +0800
Message-Id: <20230706113939.1178-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706113939.1178-1-frank.li@vivo.com>
References: <20230706113939.1178-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:3:17::25) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: eba0402b-fc3e-4add-fc79-08db7e15b9f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IxQ0D3szxE3i/MbgvtIZlAxQj4YVaZaosJwPivy5h2vLo0bAMeZcRJJozNEjAF4O+nJzdnWp4sc/G0O2oINjvXle5oFBYVkfOn+xcgMi5gw0s7CgDvGymmVrSwUPBHnmcME8WMVoag32vAxJY/rlTpmG1PvEpCauq42PnMMPoBJjScoW7PHzPn1l6yXDajZ2FQsN6LJH6B4K/tJmznDvBTP8inng4eEKffTecouVOAmpgyXlpZf5QwK1IE843U6cqFN8CAlI4UECBXyTLwUqwwPpMTpiycbN2clprsoNzeXVev/b84DeR0medFgmUffgROSmBDGitZFiNwhO2CmoHis3sNkoGCXjzboXViIdEBmU1wanLoszIicT+PZc4f6e8YXLpW3O1PYBKxS47LEzcoOfu3Jr5xS5lNHBfWn3zlvB0ENeIBkrqIdna4JGnSixxzCTkE2k5u8RwlK/CGgmdJRvmUIpxxOOuWG/W5B1VmqLu0oXlTL02QPKgX5c6pLuefZxI0PzPQf2wlRFMl+45r1aBUSlBhbknv9oh8duz4jcOdppPFoEavSMyEx2kquPYDeDxL5JQAJ5uYlg9vi7k5HhNFknQVtRnaBi0nht41IqgXfBXfwWkXTVxz7AppWR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199021)(36756003)(86362001)(2616005)(4744005)(6512007)(6666004)(52116002)(478600001)(110136005)(2906002)(38100700002)(38350700002)(26005)(186003)(1076003)(6506007)(41300700001)(8676002)(5660300002)(6486002)(66556008)(66476007)(66946007)(8936002)(4326008)(83380400001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bymyHT71pbQFZgcGdORY/9a+utrNzRinLmP2BQDnqgI08E+3EcNwxcTBK4AI?=
 =?us-ascii?Q?+Nc+P6qxjo4TgIqLtO20vy9rrBPEDWVhDVuBISiTThY7t1NPsP2JfmH2K+LG?=
 =?us-ascii?Q?EiUQkYrAP2lng4eJVXImti9MSAGErl8ZMFwtWEJNwAKHtYVe6zc3iA0plBrN?=
 =?us-ascii?Q?50jT9Y/rNr2Q/okiLRf2M/qiVlYe6sBKIuc5UTOkqWgFanR8k5ooG8lWaRP5?=
 =?us-ascii?Q?/pKL/xmsTKpSurcouaQVeQ2ZigI8VcWLyD0sSYcjWN3tbM/82QEXSKeccR5c?=
 =?us-ascii?Q?Ne3lhu2Gx9j0lLsqbpngoruGrMvLg2jS1Qak0zqvW5j0LtPOTOY4X43dJNEn?=
 =?us-ascii?Q?R/Pkh+O1vGPnAR7btHX7x78C3LR9SZnBkPRv4bENfEB9LOaxA5hkdez6TwmX?=
 =?us-ascii?Q?uuQ3hnItXvOMU4YcZgscS4CVafMq+xzphCT3edWiAhMP4/w9bNS1aUIvQ0ns?=
 =?us-ascii?Q?CVLtTx3GPHKn15YBS3IUDN1gqLxJi6d6Lt8OE2c7kFLcauEulfflYSgghNNX?=
 =?us-ascii?Q?2ZNAZzZC8b9R9AYhX6CnBXHWXNqEySXd1jXunVQFhx2m3t4PQ+FEcRiXld0/?=
 =?us-ascii?Q?Mi224oQRAt/qHotDQ++UEHijh+5yoVv+88OpqGcPC8bOz0aOIGQ0F+b+LHub?=
 =?us-ascii?Q?2F1Qos7BNVF0L46B4mQbSbeXArqSPWY4lrKSoBFaPPklgmtbHRTCTvt+eUjd?=
 =?us-ascii?Q?kJnnalllUKdeMBhvU7s/MTNk5ecaVZ8NzuYOKLPnW4wxky9oufGPkmwgIF9t?=
 =?us-ascii?Q?a8jE6yfANHUmx/WsQMEGPPOuiGGcoTb+jG6FmxfKjD+tGZxj/EVY6ByWOHrX?=
 =?us-ascii?Q?cgtXeFZgnp8hIamRH4VL3d7TAf26fENsz9ByGQAInvt5SO4KXuSzw75v33H7?=
 =?us-ascii?Q?CWaHLEv64pv0Y2Nni/KpZ8fuPADxDm/isHfBd8z72//487y0UhZPXfLc9TRP?=
 =?us-ascii?Q?9zkb0gFCVY/5MLNAeYSWg6/p0d9dnVDL4ybauC9eIk8ejLnbx3krT3D8VAHQ?=
 =?us-ascii?Q?2PX/i2IHjoZzgNvD3ukZec1OC/6BSoDZ3mTIYmfsz9U3hNBcD743SnwMjbRc?=
 =?us-ascii?Q?0FLRCq42zzCNxxZjUt8XrWjSRybvZ8EtWK0r6ik8yW5xU4Gz+m9toa+vsNR/?=
 =?us-ascii?Q?9rlOV0MNnTpme5bcN8qiOrDpO3HkgoN+xJvTcQQpmYMT3RWgvxaEj9OHYtp4?=
 =?us-ascii?Q?2WG5pJM0FUpPd/I+kFMPnmbgFwcwuj0pOL+1ctJBLYipN2P25V5Cn5r3cYIl?=
 =?us-ascii?Q?FB5njW7Ky8bQ3wLP6/wRLuVA7SJGJT4uo1BL/WvzAqVKGsHE87nTjXm4rIum?=
 =?us-ascii?Q?aNsumViKO4NGw5NSdhgaGkWbhu4YD+KWY1sLdN5SLCvivfjNF6nvufjgSSDV?=
 =?us-ascii?Q?YvZp2FaAat4/DbwTdEl9LFm4CBPhmnnxaWogad306CU1odablHbFevYMAs+x?=
 =?us-ascii?Q?unzM6NeecKviHcPEnY1bizqOqrnEl83O5S8Bw2zyJnuQO6zndH2GVV5QcWk5?=
 =?us-ascii?Q?Fr5XirsLNGkrVqfI4SrHT0p5cROYxuwrUOnlLJx+nA8cJX4cq4j001bPgl+A?=
 =?us-ascii?Q?jlhrp4xAXNE7KRXLf/51i76Xc7ofJta6xmD4LkNL?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba0402b-fc3e-4add-fc79-08db7e15b9f7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 11:39:58.4577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NrwZNsm/AFscaOIqjm0kL8TBX1GNU2ryUqGlqH0hdyl4TLG2bg90uqGhiySdJ1eQBQqRwpiJe2h50pi1nBDyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5889
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/mfd/stm32-timers.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
index 44ed2fce0319..dc0cd0808736 100644
--- a/drivers/mfd/stm32-timers.c
+++ b/drivers/mfd/stm32-timers.c
@@ -226,8 +226,7 @@ static int stm32_timers_probe(struct platform_device *pdev)
 	if (!ddata)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mmio = devm_ioremap_resource(dev, res);
+	mmio = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(mmio))
 		return PTR_ERR(mmio);
 
-- 
2.39.0

