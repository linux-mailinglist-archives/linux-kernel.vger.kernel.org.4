Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DDD73F9D5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjF0KNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjF0KNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:13:20 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2095.outbound.protection.outlook.com [40.107.117.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3657D9;
        Tue, 27 Jun 2023 03:13:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4FjUfQtqJ0l1jdfkxipyqe+oSBfbRm4W9FpJq1IpWZyc5erHO5xoAf+gMpisVTr/Vq/6mukvh3eBZz9Bvjb8Xg3b88XpdFdBy9OmBpJEI86+CPQYawG5rsNOuIjBanWCEZBKl/gmbrx8pTz/78TdL9OSmY18US3OC/Wvltw7ui/28DDpzr+Sz7PPp+z8nWuvTT9/jpsf0z4GnZMJDUyYidIhQxGzwOM7fulcKZR5yDn8M8G8dSXi2KpY2wfRvpN8MQ/B2LCtat4eow2Bvd8zAhOZNhnXn/CO1l+nwmn4JDj2+fAMoUrK2U523DJGuaz5WRz9RqG79JwNCN0mzj+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIDiHe/rKfUW7a8OOFMF6L/9a5UImOfAGi3mGpqkEvk=;
 b=M+RzrcwpZU4kjsTky7/af307UisL4jP5dp1DxEi/HZOGlC5kyAh3YsbanMxWUI8uHu+I9knFSf/09EShALdV2+SUiavkbI4898xl2+fqmNjWtqqlLHTuPH8RVFs+Uz2hgPezo3yAOcHn/lHoGiCwr7r5M28cUeyw6SAWDUP2QfmV2vx4LFkymjP5RtOLR7iu2/WRUdcK7Wq4//XAjpVl7IyTQm+F8OjaYANKtRyUREwEKy4QPpU6+vJ68mNapND9QqObmQF5maY8ruTG5dbHrRs8yby3brnPRUnPwpn3JnZnWUlQ5VhdgC2vCUN55+z21tF7RsWk3g7bbt17R7atCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIDiHe/rKfUW7a8OOFMF6L/9a5UImOfAGi3mGpqkEvk=;
 b=dyaDhbf2Eh6qDkD9c82RRdoAUfsbdzDdCKB0Iu+r79lEAXfZKx7NcX/XiWT+9aWLXnSBpCwAle9uCM0twutrLwaL0dih7qZW41gyznc8I5Y5XeYpcvPFTlYerIeLnwHZ6cJNnwjYo681EzyqM/HMniyiTAa0a4VLodvq+h3LmSjI4rA5ZWh2345+LH2ET35xXLMPFzp9s87H3C6jahv57Rh5oWOGzLQC1PSfRor7sLdmtSFk7CQgCZKuA20iTbpklgbeqPhbq5GGuev3Lv8W44AQAuM90dcEqieWJ5k6GgeUiUvEyvopnPQ4JkvY+52BzPNTryWCjyooxblCyhUTdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6661.apcprd06.prod.outlook.com (2603:1096:101:168::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Tue, 27 Jun
 2023 10:13:04 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 10:13:04 +0000
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
Subject: [PATCH v2 06/15] thermal/drivers/imx: remove redundant msg
Date:   Tue, 27 Jun 2023 18:12:06 +0800
Message-Id: <20230627101215.58798-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230627101215.58798-1-frank.li@vivo.com>
References: <20230627101215.58798-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: 318e6a37-01ac-4c1c-1243-08db76f718a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I7Oacp7nXkD3qjOQktH0o0hDIhUEVNltUVP8sSrgwdlFAmdk7lAnhGte1ic4/0k8cX/L/7AEEyxgrxvjRW7JANVRlU7m4olDGjw7n7Gqm/PWO5FsGwHOTNNo8balkP0WJxyMmv7QmJvhYPw+CcWA+aWqT8sTn2CeCIMAj9EdAUnQoyRSN1WFmT03ZaLq3oOnBtl0aGXsY71M8ek19Q5ERQnNSXPCd08eLYBMnx6NlGQng0jl7irJlbyoY1U/JHRACzGnCs1Ix40gDO5lyZkJPyaeekf1JECVtws+CWLZLdC8JrkTy8hPfa9PDXAeGe2i6xhrKRxjnqKyN72LYwaZG9ZjSRu9WG2hCZGCMR6A5UBmHkbiYYgLFMCMZVLcT20jDi/HrEXhy+cVJSdMGlVaVKHA5wF1W+0mBkgX7pwrq7vaNxpEVhWFff3c8c5BS0UAUboslnp849IWVRtQ7xVxuNnGlneSoE2hUHPprgWfL3FDJ8v3pE6YPrwhI8ub0OpAvW64thltJIk2BUY3D/2WJCM2DO2ldozkQQ+uMh6en7y5hlBNtWKdehKdj4VyiLR811VcE8i+3g5vCcu/WTMFGcQmKd2Du5B5pANOHUZXX3KkLOQze1psV/P92SNa1n3zDzmsNkHR3xc555UzdRhKFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(7416002)(7406005)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(4744005)(2906002)(86362001)(41300700001)(6486002)(52116002)(186003)(38350700002)(6506007)(6512007)(1076003)(26005)(921005)(38100700002)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L9s1Pxc1Ka+RpYFEv7pd0zZazRs3HHtoZZ/5rhVYsICAIM0yvid8+aO4jL0X?=
 =?us-ascii?Q?7MAviNNbtfV4R3XR/vw9rmrmKmEnR8NkjBsZlGrxplDBJigFC5fyoBvrc4IZ?=
 =?us-ascii?Q?SYsjcrRBydM9uMJP6ZsP2RoayToWf93N7lWODhQfORwBYXUmwShH7Bcvq8Hw?=
 =?us-ascii?Q?Lek7GlK5uvAAqNQAixTwFxgaPjXiMjB7FAwKfEkSAeI+WmovYavzIC9dDgrF?=
 =?us-ascii?Q?pVLbS0XPXDlUMntMjBS8bj7zbUmTurhcS9V91P9OqrXO/TYzPfIoG0gDOG4e?=
 =?us-ascii?Q?mpBuS9p2IMMAC1fWy1YU3r/HFiGv9AVqG4fIapXnLk8KIbiJfACHsmND7jSN?=
 =?us-ascii?Q?uHPUdw7MlBSbU1uXPPmWoT5EKZKMsboxxXBPLfZ0QxObnf8K8G8YtoD6zOUy?=
 =?us-ascii?Q?NuRUS/mCpKve51+6hDfu0iE7I/2D0YhEJdedHgq2QF2QmqTSSxRtSlujXljI?=
 =?us-ascii?Q?Ece6IXHmw1sMsTq8ew36TdJLmo07R6qQZA9yft82KmhEBoBtFpv9PlCpHBwY?=
 =?us-ascii?Q?n3dI28tJwglFU264cfHyll0dP0LjQwXkHyApYcfNgXSogtW3JVJHCH0foy83?=
 =?us-ascii?Q?yf+1r8TrJrGGR26I+ry9Evrv++o2uqgkUOSzIs6slQS/UFON0k0Q7WeVSodT?=
 =?us-ascii?Q?Qdv3lHjUgLWcmfBMtvVkkeNeEkxUAembD2QE2aJ5SOxfNuPqAA3cKshqEXCr?=
 =?us-ascii?Q?PQ9O/xgeNpH7oduFey10McpIdd1yZB3kQ5TBk5h3b+5BHs0QWkbSD3FJVVbQ?=
 =?us-ascii?Q?/kUhlTm1mZencnlvULpDRSeL5hMCS9iGse+vO3ixQb2DLJ7B4KnVlkDsI2jV?=
 =?us-ascii?Q?uOw4t4oZ9aigDcexP8EAf2icjYdvlA7ypYOAU4JsKYlFDj285czv6U8oGFIX?=
 =?us-ascii?Q?EbHLnDHmCAFTIDZzET4O9/FUSWelYCMQhmYeaWijhO/M+PwWUgm3DhC7iNMU?=
 =?us-ascii?Q?ahA9A3Fcp3TaRjkaoGSeCPS1NvsCUns5BUuyGBe03psyx1nZrPSMp2qi3rRB?=
 =?us-ascii?Q?2D7at3GBkc2n/oq2EdIJB476zWnGQ9FB/yqRPSk20bLrdQBu1osiUFv1JTcD?=
 =?us-ascii?Q?TeAyxOlnfbDcqEVTFn3rQtN+SQB3N0Zi/QglA7PJ+iyGGJrqmw+7Q6pPEJgN?=
 =?us-ascii?Q?fb61WljJfCaciwbgNSYQX73BPxoepB931VST9sT9fxXKa1P6mizhjc7SwAWp?=
 =?us-ascii?Q?9U9O+FFlNpyovXJggJbgKBlAyU0Dk2FAzJ0LBHyPJzorOW1HlSxKsEsounE6?=
 =?us-ascii?Q?988mcwhlKYameEDZ+ES+W0QfOQKLgsGLIcXY2/Ecl4b+kkGTGKechP9+MWPn?=
 =?us-ascii?Q?/lCrFvNsnkFqdH4BVrFj+mczW9Uccach1DXN4UxEU9OxxNHU7VY4JFV9JYfo?=
 =?us-ascii?Q?8WjShoycM2AhysxZmNfoE8bTJzwMlYclm6wvCxUDU8gzV6y3ePBiepkk40RV?=
 =?us-ascii?Q?wS2eN8E6PQzEaCOGjY1hi9Dlkmof60zMw/XUX841bzAe+h/xsAe6u6R1DZ3x?=
 =?us-ascii?Q?39OWkxkhleabgd3V4AMDm6EaEUhCbvGYQkZ0NliNYg8NVtZ0HVczNgymdY44?=
 =?us-ascii?Q?2D1IlIHMk3G24vayk1ICbgSAZsJmmTLBTqrVUMza?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 318e6a37-01ac-4c1c-1243-08db76f718a4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 10:13:04.7245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhrVYK5MZG/XdnI7cQqQACKDY0G1gfxL14s9EQP/XFODqwPTKIFKEylMzoxD6jCf5RL3uoe8i8JictQPpx3FQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6661
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper devm_request_threaded_irq() function prints directly
error message.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/imx_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index a94ec0a0c9dd..9be252bea1f0 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -749,10 +749,8 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
 			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
 			0, "imx_thermal", data);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
+	if (ret < 0)
 		goto thermal_zone_unregister;
-	}
 
 	pm_runtime_put(data->dev);
 
-- 
2.39.0

