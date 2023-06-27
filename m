Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CE973F53D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjF0HS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF0HSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:18:30 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2129.outbound.protection.outlook.com [40.107.255.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F181BEC;
        Tue, 27 Jun 2023 00:18:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+T0drXMnWBkgKTC34AquPqsw3SKVwnB8q8CvFKGkkzTJPOBoZIbutnIx+1GbrVqJojGioh0/93ekeu2DOc2QfAi7ysRdTQHVu/aBRJ0dEvBgqzkFpolq7//FCTBmY/yfBMwlGI7kSQ/TIOPBRuKTEdGxwvIu+E7wRQKZi74tkStlX6Sjs+qkb5eh80Ck0SApjAo3nSM5JrBDUSPhbASF5osRM37VrE5hkxKsxBU0BICI/CTdN0NBJ+I7hcO27xRTSGWvxohHcxfrYiVN+OlCa4epRxrns6fFiU2LhjtTF8b3Zdhf8JUZL2dMxvJiAQbeJhKWypOWo7Ej4pgtVGa8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKSCwtpw3raL+I80x74ps1+sIAYiMdFVosX+0ajPZMI=;
 b=TjdFr68tEu5cQnz02qJxdC/irlgqYf5eR6gIe3KHFCwweJutjz6dN1jkT2aqgIHF7FeLIS4b4TF5xjAHhefgtWry3C8q6MrdCsbNdaaFh8JpZEhh63SLuWH30aaTrFv6KFfCgriME6DFj/34J00J/7VjIL29XKIlJ8gDT9uSwLVPLJI17kA2mEZOxZI70WfeWCt9nMjETROTvT+x2+PDHCLDGS7xkXTIoIm2DdAqW54kttTku6COsE8D00o4FyAXkFnow6jfjRLhuou60z2FfBDYFh0HHVU6mOSMbhlsjbLI0uw+pgOLqMYr2gbU6GxK+UuOIZSjAXLlNBqsu4Agpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKSCwtpw3raL+I80x74ps1+sIAYiMdFVosX+0ajPZMI=;
 b=CbA4PBK8b5S9lXTR5zkxVZxOwgaLpA1GZ4zOu2ubtCtn4t4EYEJNnXgjDH+MsVYnK3SY5vEbC2wSLS0L5C0M/EM/b0B5JL3WlY0fyOO0QXbLJmJ8ljbdGl5M27baJHbM6/tCLiOJ08QAlW56Wt8iIdfSIVxTeQbotsGvJzniiHcHARyTMp+GjKd7GjQCBzgGwfpxHuIt3+P+Hwz165GDEuFL+jaTc+nC8/rmnW46zH726RmOiRQtmHh82PWPJlbfCLQDb7YRAp1czrIz1Ye8yj+q2A5Wn7YblaAA4OOHcSqR4eH9e1Wb6TueNZref5jflJKnz8/EeQynnn4k8+qILQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5137.apcprd06.prod.outlook.com (2603:1096:4:1ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Tue, 27 Jun
 2023 07:18:26 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 07:18:26 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     miquel.raynal@bootlin.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, thara.gopinath@gmail.com,
        heiko@sntech.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, tglx@linutronix.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        srinivas.pandruvada@linux.intel.com,
        DLG-Adam.Ward.opensource@dm.renesas.com, frank.li@vivo.com,
        shangxiaojing@huawei.com, bchihi@baylibre.com, wenst@chromium.org,
        u.kleine-koenig@pengutronix.de, hayashi.kunihiko@socionext.com,
        niklas.soderlund+renesas@ragnatech.se, chi.minghao@zte.com.cn,
        johan+linaro@kernel.org, jernej.skrabec@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 02/15] thermal/drivers/armada: remove redundant msg
Date:   Tue, 27 Jun 2023 15:16:53 +0800
Message-Id: <20230627071707.77659-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230627071707.77659-1-frank.li@vivo.com>
References: <20230627071707.77659-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0098.apcprd02.prod.outlook.com
 (2603:1096:4:92::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5137:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e1f1ff-0a8a-4532-e106-08db76deb317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hjq9ZrtCgIHTwlYnuyhbpwmmX3Hy8e9jgMt3LsPGAohZbaHoDLGtEcnosuuTdGUFHMAzFXkyIWwj92VUHdB+q5UoIrPmRmIK1g85h0jsvmho8aXT+TshJ9VPAJ/+OeAQ8Zzv83W9I7UdwaT/uhWTA4gGfPUc2y8SEV29Cj/WyeXGaZP9IZ+T21ziHymMc0NZsg4Fx3NT6jeSYGU1xGjQ5zjnNZdUBkar452QkzGH14XlkHcqutQR30Zypmf23NuO0K7LjqWnTlexQ4zBNhQ6ACuhPK46zx1Avtc6X3xRdjP6+cjToFywROJaHRpCyl5T0cWq81E21PEO72D9OrAIziO2PB9QIWb2cenx/G8ddr/DmKasAugsXubWFJcw8ulcL+GICaigZCpzmtm9sTKblfW4ikWafQNZPBNxg3exsi0DK88dLv3nPQFGuH8RLb+DtCrJaFklAfmiuzBgAddpLi0AOmDIGOpsPjVdaLZqKVpvnAXXvLUb/uJdAuCLpoPKWYKLG6C2pte0XRbf6LPlXJIyuhcUGMwG4rDg7RVuhNGVpNtpQeHMVwcl7vCIcG8HS6zeLgV/fXan6uupstCazAR7vy1Wtc0ABHxchRMzeyqs+PB9bc9ptPiviHWTd8/v2NIBzNnLFENFkuG/uNgdsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199021)(52116002)(478600001)(6666004)(6486002)(1076003)(4744005)(6506007)(2906002)(26005)(186003)(66476007)(6512007)(66556008)(5660300002)(66946007)(4326008)(7416002)(38350700002)(41300700001)(316002)(8676002)(8936002)(38100700002)(921005)(36756003)(7406005)(2616005)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G/alEVjG7EBds2SD9EQXgdQWv2cZCeZgCFj4/WJ7/PmsKAzkyKzQEwjW1vHK?=
 =?us-ascii?Q?xGqZisXQ7akUvQAdmVFHPWcmn1qj2HUITRQ1aC4m0gRdwxJzBBtvn+X299aJ?=
 =?us-ascii?Q?UXCL+4uwyyNOip7+Xa5sZjcOPqliNi1FniDDstOYioO8KSelMdEaZrjp1VcC?=
 =?us-ascii?Q?jPSVQSd6+8WaVdlg3JbW4GlNMoTm/o17ztKy1H0Tmry7YJO505Sid8xIDZKD?=
 =?us-ascii?Q?pdWdGt35n/iDOtZ4n44tZPE4pqw4PPqWhvukLUqQBPxitbGaxMD52wldW/ub?=
 =?us-ascii?Q?VZp2UNivXmYes+dHAShGTXwLIbuqtiMEvPSkbBFxU8TqUzx4lQuLpWCGipLz?=
 =?us-ascii?Q?ybgestd5apbqJDpj0oIRQNYMmmF25FempRKHn7J29QIlbuAnaj2t1O5cl6La?=
 =?us-ascii?Q?78Ux7muvyiXEZgQ61azWFe+ozVSWvWI3DvB1EomsDfHyVY9eeZ7cqg90ogPy?=
 =?us-ascii?Q?RnBZkEerPiOw8EuGMELxAQ0pZhVtg8st60ilTN/BffKFponmOAiVp+09sYT5?=
 =?us-ascii?Q?oMQtMpARW18qZ9WAdhHkB9rv78gvmwWOXkM88Yhxk0T2EFnyR/zMf5V0+U9j?=
 =?us-ascii?Q?crKhwkrjtn/WPoaHKAvT5qR22x7w8nXO1dgUsTjUJetUkqKLrTSaYNheRw8k?=
 =?us-ascii?Q?cNLYzfo4Gdy3aFv/2fLesUzqxrSRHs0skMx6F6Yl3kwyOywDQ+X+Jw1NMJzx?=
 =?us-ascii?Q?J8bDJ9LKKLPgi6VKW6BEXs7KdB37r12Ttg+ZEwada4kIm4ympd4ttBnJER7l?=
 =?us-ascii?Q?bCc3iLVAhSAhuMVNmLh6jbptacjywuYheWviKVJFzFKb5rip6mc+M5ney9rS?=
 =?us-ascii?Q?bCs/tWEFvc3aMMAFRFlCwFuy2OGp+4cm7yO3gK5FYjryCkrv2NN+NKN+z9Be?=
 =?us-ascii?Q?tS9W05YlQw7TGgbZat7pbX0JU176fbz+Yi31ql6z7l1r1Q794e/Y2yfQbJi9?=
 =?us-ascii?Q?iFUmTt7qOiPNYgtqBCTJ7qd27lv70fufrffeclEqolcWxC/Hddhx1szqJ4SG?=
 =?us-ascii?Q?VK0gFcfR3kmVv3edjjhUzVk2OBtk57xTkZlb+2snTvmtUKjlPQ9KD+Kj7Hlo?=
 =?us-ascii?Q?XUT18ocWVWJSRy0TvgQSmDEG9iG8yuXCFIL9KcfC5fwCXC1sHQFSLINg2Pj/?=
 =?us-ascii?Q?QudL4NhPU38UwhHfwBNvyIltQc8eJx1XGj3DzTD85qCaHWgaukuZ9LK+eB7N?=
 =?us-ascii?Q?THc+mK/KXo5wiigTIR6YhjjkvkhqJ+7f1X8Q19MqCqd/AnSfzMOqz1PAq5n/?=
 =?us-ascii?Q?27vS1pT0lxEJU7MfVmLp3jrk60O/YtrjCpKlKhcwiCRKOkKe2rXeLdC6FHEb?=
 =?us-ascii?Q?KOSwXgY7Vofp0TLKVy4Pz3mrNn2+BpzPfESsaaAxVnhMRV2hUFsD2z8g7XVj?=
 =?us-ascii?Q?U3ZV05fiMlU6GuMTTjtbfdIKS0Vfmamvzi4Vll5gUTIBQalaNeDtKQADGqlF?=
 =?us-ascii?Q?j3064e7pMhxPqJGW6yL51UpAqDbwd++XwR2R0elMgDMttCKyvakHvtn9UD9q?=
 =?us-ascii?Q?Y4OGFzkUSoqtixkoVk6A9T2CZWFDsNSyAVCMo8j405UVcoRj5rMsgyfSvMVb?=
 =?us-ascii?Q?FJyoQ0u0tYkyWfQASjGuAVHUGwiOpCPWwc+o0+6K?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e1f1ff-0a8a-4532-e106-08db76deb317
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:18:26.4364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXtJovZyPA+7fsFMszM4FAXRqiXCHulZLsisgZf/xVot9mwnTY8t4+kbkXujeuRaZX+JH6LifdbvuCE6PvMNEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5137
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper-layer devm_request_threaded_irq() function can directly
print error information.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/armada_thermal.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 9f6dc4fc9112..98b04158f06e 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -917,11 +917,8 @@ static int armada_thermal_probe(struct platform_device *pdev)
 						armada_overheat_isr,
 						armada_overheat_isr_thread,
 						0, NULL, priv);
-		if (ret) {
-			dev_err(&pdev->dev, "Cannot request threaded IRQ %d\n",
-				irq);
+		if (ret)
 			return ret;
-		}
 	}
 
 	/*
-- 
2.39.0

