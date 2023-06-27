Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7518873F52D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjF0HRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjF0HRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:17:45 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2133.outbound.protection.outlook.com [40.107.215.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976851FC4;
        Tue, 27 Jun 2023 00:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCRlaEMxrVtX1bNBmZU35++zgVUW2gsfBASZFunkyuP4yIwdT/exWgeXSzZRYZOulvLTl5ndJF/OlaDQzfWvcBsapG82LGDGeK6Xb5TMQz+opIbrwEZ/MbzKz5b8nMiLr3272JtKUXSJlkNDjOMjasjLghtI6u3LtxI5QD5xlQ08tEVXiuZQyzarSjYT8mCxvuN5yk04yfNoVKPC5QwAAwXPcFdLGxNdstYzs/w0NH/1Nehk39FkoBirQSjIlXo0nY0w1/OfjNyqtnERvuOuTFk1wZwGB7Wa8IPdk/ngGXx8NkslMjqgWbcSnge0qoElsl+BqzofugVh+9MmbDjR6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdY9ViiKU3jb+D9rWMWV5YCpwmMPpqUqtJSh7ply6w0=;
 b=SVdbDPlZyhkLumFE4Wb9lJafG1AiQVcQTB0gjSXEIjGfrj6d1GrQHasMes71ZN+8barCXUbi3YFF4BOQn3WM5I/V0xbTSskPsr9iwLvBKw4lhsxrI1B34bcINEPJPXQ8OsIIBG9nWsqWjVKr01MOtmrlihQ7G1SKQUhr+mO89GObes4oQBAi+d99m/buldedh9p30rKqGR7Bdm7077if0NU1Rn3SUSHEq6Z3gvDVJ0LMnApVxojfuOQYZxmqJ9SYC1RSiHSN9/gRoCkCepqxVkbO6TFKJusB0N9QzS1TEzKnDRztpy/ixstuy98h3A/zT69VGa2+6p77R0TVSpFPMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdY9ViiKU3jb+D9rWMWV5YCpwmMPpqUqtJSh7ply6w0=;
 b=Y++Ju77qsKvgtFrJ9Ta8bNh8iyUDGIcrZMWQPzDGFs8t6M//GZ24PvFj9B5jeJlEkc1/Yoc3ip/yzXf0bIFjd7Q/6Cb4/evC5g66/jgX4tjiHybBNfxZIS8x5l1WLlxh18jvMyltOnpzxn1UTWUQPazi0r/rHubS3q9iipD9dzVv07cilaUHtZdIIRbFiPx30JhH8Vg1ny/hysPqfuzX1mw+EV4KLwdTRM0Bjz9EDB4lUigoAnidcU12Bfjjwtxcff9n5aqTggvKH/k1cJyn83AKVbsTejWZ8CExEJOQYnCPgJwuxVNT/3Wg87JsA4MvFcLJnn9Kk4cI6vzpP8oUUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com (2603:1096:301:11d::13)
 by SI2PR06MB4155.apcprd06.prod.outlook.com (2603:1096:4:f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 07:17:34 +0000
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::adc0:c22:ffae:227b]) by PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::adc0:c22:ffae:227b%6]) with mapi id 15.20.6500.045; Tue, 27 Jun 2023
 07:17:34 +0000
From:   You Kangren <youkangren@vivo.com>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        You Kangren <youkangren@vivo.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Damian Muszynski <damian.muszynski@intel.com>,
        Srinivas Kerekare <srinivas.kerekare@intel.com>,
        qat-linux@intel.com (open list:QAT DRIVER),
        linux-crypto@vger.kernel.org (open list:CRYPTO API),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v2] crypto: qat - Replace the if statement with min()
Date:   Tue, 27 Jun 2023 15:17:24 +0800
Message-Id: <20230627071726.20578-1-youkangren@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::23)
 To PUZPR06MB5936.apcprd06.prod.outlook.com (2603:1096:301:11d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5936:EE_|SI2PR06MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: ead73a88-2683-4fe9-b106-08db76de93c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AmwPmJzaX4CLpgbEOjb7QmM/LnDrgSu+0rABLUmW0ZQ0uDSrTbfJ/z1f7MOIvmw0x/zunVyE7L0ThHvzmoMYGj/UZDUF9t9Ah2NtZS603VUiR9mLh14mO5/DMAceRlcyQJxSehxWCZCF10E8rbP98nuHTzUB1GumSWRgVSdmwo+ndL8XTRki5QtzLsSh1PXMTC3o8j0OuzW26HSbj4zp6kt8d5BZliQ7LP62o5q0CxmiX6MXST4im42z6mXufH1R7f39eiaE98J/Vt7KtoYbb38rxO4BfXQwCu3n3T0vIGQnwa9fEsZQ00zE3OD9KPWfAEOmN8j1YQdKGWEMsBDU5FsbRO9VP9e5BTX9hzt0GkcI4xuQJU+zdF+ahIR2Dl6B6WUXspqJKr/X77HPmvIRX16sdsRvZa/svYCZFliYECpjIisn8pwGPyhoZbJlkXmpJD1N4527/6XeGn5Di5z7rG8eptMoWQ5/fPEUBQpLkMaKm15oPwyW3zVMDl0KSYSBUL9RhuvdXEJOzf72HwWM3sndNpos6YtsqHcZWbgpWDeFgk+vRkdOTPcKgjBrmvkPUckl8JYt/3M3t6Qgc+5uykHEFGoMmXXkPTR/XwiSHBnhH3RuL9aGL2gM4b0goaBY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5936.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199021)(316002)(107886003)(66476007)(7416002)(110136005)(66556008)(8676002)(5660300002)(478600001)(52116002)(8936002)(66946007)(38100700002)(38350700002)(4326008)(36756003)(921005)(6486002)(6666004)(2906002)(41300700001)(2616005)(186003)(26005)(1076003)(6512007)(4744005)(83380400001)(6506007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3VFi7IsNpHHOTaLLv/7cJdtgOIMctZ97O/5O+Z8lpzMY8kg4Qh/+TDzIznVS?=
 =?us-ascii?Q?kne96ogynDfGOD3auOjIBKjI+Lw5fPme++STBpiM6kKywEejsSPQqHsE0dES?=
 =?us-ascii?Q?mjwyX/o/Jnt+9jKIgBZ3yPeEJFK/h9LZzkeYhU1wYbbvfZZuyNoNPUAOSkNU?=
 =?us-ascii?Q?nYq44EZtC2/OlAyc071g66ytLfw+n93fNI7WmBgJe+EAyRMCK1ng3qX0jXp4?=
 =?us-ascii?Q?SBRSu5kz9qr0DxVPc63yPsxcIVOtDMOBSZgn1v6GXtVKVbvTLopYYbpTRlsB?=
 =?us-ascii?Q?i8HOsRYEKq+07brf43MMV+ecqvhJe2kqCyaGDUYHcZINPdG/DkdO+eM6nGqQ?=
 =?us-ascii?Q?rarUmd26X4mSemDcZThjwz8WjSGygqCp4PtZp9FVmrTMDP5R9bCWw1SPTNMG?=
 =?us-ascii?Q?6xVSEPRRaC4LemtsVtXrddh5LR2j28mK962sS1DZG2WspXqB4wW7eQiYB8+H?=
 =?us-ascii?Q?gUZczavrUmM167t3G8F4n+dNDIXnCnFvxRM4iiK8yhe21c8pR9ofHELkd6XI?=
 =?us-ascii?Q?rZKfKuu2Evbr9ZayA6GHJFSD7FP2rHMxBG3B+v5Mvy/WJf6ErufV+38bgcQT?=
 =?us-ascii?Q?IuQtjRrDv1n+aw2gbvZcfL53aQTfTuN9n7dNAXW7MgdbkEjUZDeY4JMNOWlc?=
 =?us-ascii?Q?QC/PrE5jduZn7p5kRH2AzyEFU9wB8VQU/MzWZCy//wnopv7wk56NSpUE8N9R?=
 =?us-ascii?Q?K/s7qzxmmIIG4ENN98zBDLueBio+OHWCmP+093VmC83AHHLCVrunZpz7t0sj?=
 =?us-ascii?Q?IoAGegdm+DSiA44XGDrCF5jXlF66/DNxeS0eHuIf1CJXW6JXl3g3pjWdIZb7?=
 =?us-ascii?Q?hx/lbPy8zGMTktZyd0SjEd8cIr4w3EJNTdChMLmb1OmY9AT0f6QJege/2Bqx?=
 =?us-ascii?Q?WA3wmQPRmJ5BLPu1Eig3sPNfaYPBDWfSoUz4C/a+HxYf/gCU+K0/BxqYbIob?=
 =?us-ascii?Q?ZWeABpRWQuj0MYd6egwtXW/sLWq6YGzC1HADVJxlpp4ybsVTGsxyELkvd9ua?=
 =?us-ascii?Q?okbMEhJijvhv+X4lpkCFrnqRVzCPmd7LOiEVdoy7O34468c2TRlIJ7Jo+MMu?=
 =?us-ascii?Q?h56UjSS92jUd2pci7SfpqaxN8XybZHpZ9q+xpgAWVJ/VvCP05Npj0UF7rkJz?=
 =?us-ascii?Q?BYroF5GOcjzWCXFUu6se+eh9OUPtyRgLwbAlp/6RKAKGoPl+CmjdJTczw28/?=
 =?us-ascii?Q?c8sx492B8aOu1G9jl86UIyNx5+BdLCah4zJ9ER8HYv3lc/8ur7m9BnJDBJ08?=
 =?us-ascii?Q?R9wRX1BAVtn+d+UqOzITtJiaOybOUjthXQH9JwWD6LiKTCQw79dhCG1jEzcc?=
 =?us-ascii?Q?Fh/J+WiZtEiGXJFG1DFHVP+9ZozJB4q4y1A96pquO0fu5Ddi9RNazQXGDfM6?=
 =?us-ascii?Q?b0kr8Y8tJMXuENk9dysHuwhfkGsEHUwNowMOfDlZCYvkb9tR2iWtoyw8mN7X?=
 =?us-ascii?Q?efNXQe5GumS4ofajutW6TCfRnP8hN4P5p9U6gHrlcpdXGXP00LziVKp0ST9e?=
 =?us-ascii?Q?RF9G5Kb5fqRgzNmaPq70H/Ca39qI0LVyEkY6Z1Fsud5u4tOkqh3LiMevriw2?=
 =?us-ascii?Q?YMcIOBVmXulpAE90SuuajYL98my1CXda98MguTku?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead73a88-2683-4fe9-b106-08db76de93c4
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5936.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:17:33.9765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQTARyZKZYhIqZN+eYcmAWlyBymVWSPk3wbLXn5Gn4o1k2q4XIZjJM+s/hhMk/gkgW+A5UT6Vq84seDDIB6/vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4155
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the if statement with min_t() to simplify the code

Signed-off-by: You Kangren <youkangren@vivo.com>
---
 drivers/crypto/intel/qat/qat_common/qat_uclo.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/qat_uclo.c b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
index ce837bcc1cab..b42a4d22b9d2 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_uclo.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
@@ -1986,10 +1986,7 @@ static void qat_uclo_wr_uimage_raw_page(struct icp_qat_fw_loader_handle *handle,
 	uw_relative_addr = 0;
 	words_num = encap_page->micro_words_num;
 	while (words_num) {
-		if (words_num < UWORD_CPYBUF_SIZE)
-			cpylen = words_num;
-		else
-			cpylen = UWORD_CPYBUF_SIZE;
+		cpylen = min_t(unsigned int, words_num, UWORD_CPYBUF_SIZE);
 
 		/* load the buffer */
 		for (i = 0; i < cpylen; i++)
-- 
2.39.0

