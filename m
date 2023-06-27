Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2143073F588
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjF0HXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjF0HWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:22:34 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2122.outbound.protection.outlook.com [40.107.117.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D58C2950;
        Tue, 27 Jun 2023 00:21:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KozvCwT0Lzox/yVWGwCFD6kNBW5z/FtI3JLFN2eyYf0oZdt2SMHm9RZrxYh8r8DAEQBOJ5H4jQgGAzqUOUtj/8uoQZbyeX3jpyT2zAcaGPljy6NTuywnIdhhcrAxtkhrV8fFKAtvDggKWc9G3VfF3jVdDXUgwviLS8cYWHwRo72mXSDOTMfrWu4/coH1kWOPN7uOpmj7Fc1EMiXTSB2X/IIhOLxn1OXFK375REmRKmS9UU471nNnfOIFuqKqGpWixW/vFQPoIsh+nU8y+zf0xxr7wtglWitBYOw3VNbmbfBMRTEEnClBHk7Ah3Qgps3UomYQsBYm4NkO/vJ5UzKDuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUTBeRR7HOpprFxmVjklLNxaPINBXQ4D0vNvhK25J0s=;
 b=OneaE9zcsr7/BU5qMQlDY3q7fvhoHHYnacYv178Y37WUCQx9O4S/da5/QerCHHE9GSRIz3GBdKFjA/C3u/UT+smw+7LAKeNKLoE+3DrsnNH/UcKiu79BzPo4UZL02AatUfGidrHUh/Aep6TnN17wh4YypuKh4HTYhhqgueyMAIXUM5cvW5BAdq61NmHe85amP8E8HZvK+9kqDasQELwtvQqqpmXu04U13vH1YGLyt5GMRI5d7f+JVzFBqU5+/VoQ402I42cyITHo4zS8WSg6dnZ7bMHu9XEX9dsD4D4qibDfczB85J+CitrIuIzaoIz2lmSMjhTjtCOwVb/FRnCS/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUTBeRR7HOpprFxmVjklLNxaPINBXQ4D0vNvhK25J0s=;
 b=Fvl4lRKrq3qzD+CU0wOTwx6JNElpwQdnJc1tAgEh1H1yta+m1gKgxsXf9T+Wgz9pgB/7JwuqAdQaTj/IddsNHSWshWq6AnV1LI4lR83BBaJIly7SKghXzdj3aAnq/IYu7m2oDmQ3zgFdfvCQ8jMHJ/nNPLPaGsoFpAq5Qx0EaeIg7KZ7CKg5Y32j5i6bsChlqKuRaGDgfCex4ngNWl7I4k4P0kFOGwpw1pGSpUEnBk8aMnWh/isGmf3rhFHGBaUIb34tlMNu2pDDpOs+CCqrQT83ohxBVunMydAoPbEQrHFCp+1Wq4oZtzjAPlvsqu/y7qMbv/OGB4bPoaTNLT90hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4289.apcprd06.prod.outlook.com (2603:1096:820:78::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 07:19:45 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 07:19:45 +0000
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
Subject: [PATCH 13/15] thermal/drivers/rockchip: remove redundant msg
Date:   Tue, 27 Jun 2023 15:17:04 +0800
Message-Id: <20230627071707.77659-13-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4289:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3247a1-99a1-465f-1c88-08db76dee25e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SaVBky6Q8Gpz1YO3/MaXPvmzu4zoldqWarh+7hGDYoa5Dxli0MI9QowHnESa8r4gH+qe9z3zHq4gOANS4R7mO4bJHn74HkIPVZEP+KzVHkNQoMqpsdFXTtWwrNcdTn83ecG/4tMbPISyhY8IP0D5rHmc4sJ7K6BexgRjxR7TNoy4Ft63LoE9NKMILwGUuSl6oGhkIc+v2PcNaEJC2YandQIVi3cArmNdKiJWx0//fGsH5u70orA1/IHx5R1OdYKXrqD8ruon6ufSYZ/SrQOlxKQwFCig75md2h7AAlMlFkS18m0A5r4z26YZuHUEQfXRfBCZdDQDhrIh3kdqAMgvyCwZFRXIGw5nwxJQgjQy2EZ8m4bmOQ4DJUKB5RNVf4Ee5l7VtmUh8H12QlJLEV5Wb2taImTYm98Ig6Ovdz74ll6eTAUHA+1Fqa8XjNBA0ojAHdvfSfoFuWFlZUKdB6z5alEs3hwFxKRMn2k0wuxB+87bKBj8pmJ54stZ/GBhtlKMvfo6mWdoww5RXPVorp8qCkGpR8VpqB/BO1WrSFGRjSkthiv01pBTLVyqbWDdWYU9Kp/pemhvZdREgQsXcNNvPhB/eaGznMXIT9zDt6TR8r3qBazooYlvkDyp5VxWdsXNlAD0diMvVFpdW2F5PMk5ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199021)(6506007)(36756003)(6486002)(478600001)(52116002)(2616005)(6666004)(83380400001)(2906002)(1076003)(26005)(6512007)(186003)(4744005)(5660300002)(316002)(86362001)(7416002)(7406005)(921005)(66476007)(38100700002)(38350700002)(66946007)(41300700001)(8936002)(4326008)(8676002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PSMAeV8n/ZUTQvwDPVEYR/+ZxVeak+mn6ArfNswihtETSY3NNUvnZj0f2OcI?=
 =?us-ascii?Q?4MarRCfx+ySEvVYxSn/09jEzW2juYSrGwg4IWGaBOyOpQXVJlyoOz1O9cZjC?=
 =?us-ascii?Q?0lCd7tFDgX7+FHUVbf2bDncxJcnSG7DBNOl8qB8hYsjkqrtl/vKh3tEfG96W?=
 =?us-ascii?Q?urvYcRsfLZHT11vW1447ByrvEaaaEOpY5hjdLUb3ZygzTwEoAiqinc2pK/mn?=
 =?us-ascii?Q?jcCPRBNp7AwNxpEp8cRXS3jTkJ3lGOgWjcM/qOjlIoT19qu9ZGd2vMNsULNZ?=
 =?us-ascii?Q?3IUkckuOpl/HMuBlJZrfxwzIY0nP9h6i5HquSTcjgj+SyjzSMVPpnKJWEd02?=
 =?us-ascii?Q?khBr2LItYFllnlJ1vtgYtbPPa/jtsnS9pEa7uIuMAAaJLdr+50ZuM8HZi1Hu?=
 =?us-ascii?Q?eEyAlhgJHmPEbW6f8lbTMcHSOwpblc3pFD2V1uMgczBczEjBcWmiIxBgeQPH?=
 =?us-ascii?Q?rU9e/Speafv3jvB79gs0ccrK8G551O0hLHtTE6skNkeYRAyFoDtuaFYXOjKk?=
 =?us-ascii?Q?u6rN89LtizRKUyz5MEqeeq9SJHggeN/dYl0dOUyHQBtYNPXwcPKEZcefrpta?=
 =?us-ascii?Q?GXrNfPVGQ7fRxSwfGXFnhkuqk5kdlfpP3scTuLKpdcV7gwyRT6kYIjkHTmrk?=
 =?us-ascii?Q?Om9f9YdCoHT5hbnD+mh/EJO3wupWf/uhuQO1WzM0cLLi7tnWAyp8tkwtohpc?=
 =?us-ascii?Q?2QJ76YkDsLA+cza19Tvg8eRlbh4nieX5a/O1GpYfJJtDTZqzuNaMxlMEVaM7?=
 =?us-ascii?Q?uNknH65Eirwjrebr3nu/yIcZoBHk5OMLBxQlQ8EVyK14a63XTkWC2tmmgKYN?=
 =?us-ascii?Q?8Q2j6Zpxg8unwTzOjgMbaN8fOYMOJcz9ym13CjLYOxerHSJKSlfSodRC4ld4?=
 =?us-ascii?Q?HVrVfiED3YSpBl7MrRNBuRxKYWvnI3i/geKhzYV0M1pzC9YGKQeORK5ipbLG?=
 =?us-ascii?Q?xrw/HEqK+78FvSPq5i8UHUjgSnuQGIEA2EvJyX16bI4gZW1Ozgj/QegmYh9d?=
 =?us-ascii?Q?/Hp3bsSQpoUoR5CsJA6YAGYseH0YWNE8Ps1jaOIvnK4W1O6LlJkpfizIFk17?=
 =?us-ascii?Q?7K57PjlNwFZaxIlhnsU9iN8cbbOj04fBZJUJKmxaheCv0EyDLGtr1K/hziN2?=
 =?us-ascii?Q?isIjMiYhQEPeNi1keF3x+SIIw3RMzP0FClFqtmvJmxR2T8THRjoMbmEV1NVD?=
 =?us-ascii?Q?knufk4Ktmc4kOipNj7VTdrVlGk/Oxs1H8eu08NhQk19IpyuC871vc2rk12pE?=
 =?us-ascii?Q?nhcz7MfEBh261VvD/JXlX6CXMhqRzSB3CkK6y9FWxRJq9eliwL6puQJv49tQ?=
 =?us-ascii?Q?Hguk0Wnh2sxzxw77o351QVQlEwWQEHEPe/371eovvutqqAKYVy4XrGc6m2vx?=
 =?us-ascii?Q?3NDWwgzt5N7xJHC+1W4ZzSl8aTx8zKxfeBoJCWcmQabpRwND5wgXRvVTTUyJ?=
 =?us-ascii?Q?rqJNr74R2kZoscogyZjPo/NprPlae5aPDpOWh6Rb2O84+SAF77bimlguCfjm?=
 =?us-ascii?Q?PbzTwBKH4NZfeRweqGatlJj28/4dfpal+NEzURK/DCWCfcR/bKJH/W0LWDvp?=
 =?us-ascii?Q?wdTBenWAoh0zUtpB4KPCh1cYUn8u6qBJLDAx2PV+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3247a1-99a1-465f-1c88-08db76dee25e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:19:45.7476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiZBkFUjolTHXGzX7+Mwt+puZi/vwqZ/cEepWWwT+daO/FiWC0z3bEx9on5MyYCkuIz9pLww7RiqvV3isk63Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4289
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
 drivers/thermal/rockchip_thermal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 77231a9d28ff..e741f5539389 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1582,8 +1582,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 					  IRQF_ONESHOT,
 					  "rockchip_thermal", thermal);
 	if (error)
-		return dev_err_probe(&pdev->dev, error,
-				     "failed to request tsadc irq.\n");
+		return error;
 
 	thermal->chip->control(thermal->regs, true);
 
-- 
2.39.0

