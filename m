Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF4573F9EA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjF0KPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjF0KOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:14:39 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2095.outbound.protection.outlook.com [40.107.117.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA67B109;
        Tue, 27 Jun 2023 03:14:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3GTeiKO+S7oDwGopejrCAYrWeGruW6MA7wlw2k58g/NsAFevzcbcq79/Ba7VyR1tcDAh/XcRee9POMiuTiOUGnBW8njqPv9DerZ++dxZowcYneNQlfPCXRQmbKfYXlXAqHSKAxun/qbCwFfSU/EdntHCLz5C+ueapXCR8EbqiSk/ELEwk/Af/tiIjOy7Nfguc46c7GNvX7C2DZFWxiGq+2MlAO+Cjq5HtiuQ8hy3qbcrqhAlJLX79kmjhQal+J8+Hsw4VVTuf+sjeFc5FwBGTYo9QjlbUVeFY41nV8RPs8moxm+sF693fDX45XmKJ8iV2LOrpaujLIYF/nN+23bGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YC/dwNswXk1tnTpxEL4xWNydXspL/0KVjSUwu9q2bcg=;
 b=iJhjWJLlOdaoyiKMKBsMzscznlaXjYf7DPwqwUDafoTvLXQPaeG2FQ9A1jcBSaego66zYjhXrOB0/VLIQl2Olnem2P1r/26PQNbzxcHBEq2m22TqcQDVYhVUwq3CcsQ/Eig/VbLE6EucVjXGEzkiLA54wZgxsxQ1PygMz963z+xxsMQbRyRyzQ0P2ko56mDfyD8mL7052PBqxWFH2Lct3zkbuedqzg0+CSvEY7dQMHrFJ07VXOm0mhCAKH2zbfg07yi6zY165+A8iJXFvmghyH2u/Ds67wSvhe6+n31at+zup6+LlgFGNZDC2nRoiHl+3aoP8C72DHQkTt1hSnZP+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YC/dwNswXk1tnTpxEL4xWNydXspL/0KVjSUwu9q2bcg=;
 b=IPG9Us1fYgVJXTv8heU4Npg7P7uMBIfGGPnDO4lNhaYdLH3hjzN6cra8YEmszBWCZBU8jfrZvjE5IGuMIwcFPMsofPbVUJH1LVes6lwH2TKFLD+bB8g+mnj6nChfDTCkDaKEFkd44NuFDPc+Ko110dzsLU5Axw2JeGMqg/nAen4iXVzq65He9RrmRKx8y4TvGHJIODNKnmkOZ9eWjIGGEMEU/IRHQ/yDdQAga+h8Pn57+00+qKEWNPlKcNEuu0EmXK8W4C/QZC1kAL6BnMtVtkvNmZnHbw+NsqKAm97zj4CqX94dkYtmPCCrOA7s7EW5HnqvHJWUSZ46wDLs8ZXZmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6661.apcprd06.prod.outlook.com (2603:1096:101:168::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Tue, 27 Jun
 2023 10:13:29 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 10:13:28 +0000
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
Subject: [PATCH v2 10/15] thermal/drivers/int340x: remove redundant msg
Date:   Tue, 27 Jun 2023 18:12:10 +0800
Message-Id: <20230627101215.58798-10-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a15e1084-1904-4923-2e14-08db76f72702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cuwf8W/0PW+OFEtdg7Ug/Rzej36bCt7q8qeqRZuDG433rbYeQ/o2abB1GLAmSpOlHIAtv5mKQisVuV0Qlosls6Z0wGj6riecwr96ZfFIqbsBLTQ0LKoeF9NDamDenODzj8PYVmTAHpEGcIx7PjEHlexFK/x7gC/jtj9py8hJ1GlTszBoPew90pdYJkxJoPMKEuH3MqTUaAfwkh6pLofM6kNrM0JMDEiYOw1R9zxl9qrTNMhWpvu4I0YCD2d92nlJ9v7FkFvBSCz3msl/g9uml7134BeEL2P5ml1YVDiiy8aVW3wcJLhPa5GhjC2PvXuLRCgIZhkp9PbThLrfjl6Oy9rk1XzxUmuBEhlUwvMZdNGjWqn5oCjI8n/lJkWuw2Q7dUKxtmhrSTM2KkwvyIE+P3qCDpCgzn2WNJ4Gt3GDjzBLlrPE3gHtTPoA5+YGaPuB7oj8i9t4FoWDvYuisXzzh+DMjuN1hv8ryszZkL+E41RUHm/Mi7iVfwuGPRsw51aRynTZgFR+uHwduKFUQWUxkgYzG5F6F6DZrS6q1ajkMwbrYWupavUyjQVSb4BDVkdm6vr+qutuQrgGKj+HKmYdpBGYp3saKLduAc+j2pLY2fJwBWh6f12H66H/vzlh9ETMz1wyUJgc8ElxyLJhYANzOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(7416002)(7406005)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(4744005)(2906002)(86362001)(41300700001)(6486002)(52116002)(186003)(38350700002)(6506007)(6512007)(1076003)(26005)(6666004)(921005)(38100700002)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6/wm0koGXj7n88h4eJXv9mGAUoD1BCObFZlCzHEBdDnmi40qT2sLbiAW26Cz?=
 =?us-ascii?Q?hwla9HvrGvSxs7bTB3qEOnMjhjRxZuRx5WfUfn3jyCNsj0JrO+D19WGVaIO9?=
 =?us-ascii?Q?q2QtCjX2lwCDOQ4hB9CnQcpq4taVKli+MhaaABN3XKLRsldBNcUek6TC3r2e?=
 =?us-ascii?Q?JBGM6yvFeNfItZHa5XdYkxuXWVMiV1FELzEmDiZm2g6WYN5SQpVK3waki4Yi?=
 =?us-ascii?Q?pRbjOWMGpGqzod6Xvhc87jI64XsZyVdwJEvASZ55E5Tp1UrYxlOZTkALeopl?=
 =?us-ascii?Q?31/lcVIh53RwfUopEoCj+JAXzR3KzVprKYUm2oisWeZG8sMJbdoReJPZsKAK?=
 =?us-ascii?Q?FxO4LEAQJdiBSOza/8WaR5VS91JoDzlsRwUZXz01ktLfFPjX5Z8sf+HNlM88?=
 =?us-ascii?Q?RgoODGgJeflUTc86uFkhf33T1TD+WdIZsDtgnUBaaqk5yS6cpAb6XT6brUQN?=
 =?us-ascii?Q?PWs/WZ2urB8SyOOpE5nu6dU6wyvc+a0OiJ3k4cvGDiMXp+EbgFioLaNVPwkC?=
 =?us-ascii?Q?7vKWu7klVkjvsrhRsaM52JV+zZW+FQSXKmbCxamm4G2AtLVMyKslJnYCf60C?=
 =?us-ascii?Q?k0jDdGypLqlEzSSNoJ2kVLwAob2NyWq5Lu4pAmgWG+Wac1hnQpZJB0r0Q1bM?=
 =?us-ascii?Q?jMepI8vel6fxaHQu/FE4LPM5lDFJBOOl49Qd93bhXpdMScqJXOpX+yJhfz8C?=
 =?us-ascii?Q?PfG2IIFg5S4r0og25AnKZAjEjIzJKwWZH7gzNTYa4FpkjQGeEfu8QiVilLXJ?=
 =?us-ascii?Q?cnWn8Hp1PEzXBj00g+ROaNl5MlDVS7j4iFcFIF0b2GiGyCg1lP8RQknJTxYw?=
 =?us-ascii?Q?C6gmRHTfjrtpKElw2GiLnqaIlcSfl7/HnJ8w75EbK2UwGF+AKedGZC8itKVs?=
 =?us-ascii?Q?cFJl7G3bCKrRLuiJ8ocr5Bjfg3qqgK25Gz6RSMZR8gPpTkMkLQJzA5GenRik?=
 =?us-ascii?Q?d6dnbIvZr4aIuMBUn9lTMoUrvdptf+TSsCiuLz9ga9Ci9wxXIt8r053OR6b5?=
 =?us-ascii?Q?5CnG+WNjQeEDO7ZFGHeh/M/opNPv/Q4W7JjmmHyCCCEACFvY8Mpx6Nr9KOUe?=
 =?us-ascii?Q?48vDsIzW309dKqxFyXiPotUOt/Kftg6eoVO4xeXbb+cDymDyFoIaIv25MSck?=
 =?us-ascii?Q?uBW3HAKqmvAkJhLqiSapazKEKUa5bc1KuoM1G+CmDEuluO82O4lQMVXt4Em/?=
 =?us-ascii?Q?HTmFRrYxHb+/K7lHSGx9EhwLwuoJNpla8YDVagJlJ3rgc43sboVPBF1yV/Ru?=
 =?us-ascii?Q?harKpkI4ATzV+q8i3gfWCUApLwrYWG0BsMjg1xy8AVjohW0ERiNwt7vWeU18?=
 =?us-ascii?Q?gVnCln9y4bL58AlqlBdBfj4mLShw14NoF49ahadVQ7+VyozB3PQZnRyKtl2c?=
 =?us-ascii?Q?B08y1NATREjndwZ+XvT/xe9L8OxhQamsEDNKSQbXrodOiSCDi0L58zgH320Q?=
 =?us-ascii?Q?+grkA2ytUfha8jYXeUbqKIo2j9AiH+CVJPfeHLWoOiMEUa0ICckJF4F7gns1?=
 =?us-ascii?Q?wTO9raQDSXaeqJHVbhL45rxFosRhc0nIsxRp3K5D9SlzsR+/jBQDcFO/GSTb?=
 =?us-ascii?Q?dlRvrdl7xm/g0Bx8pBPJHjSQN2xlJhlvoXP2cTHG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15e1084-1904-4923-2e14-08db76f72702
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 10:13:28.8249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpKEUKIaqTuycczADsn7bp58NzfC+kAd6gONrlA0jAViO70Zx1m336m4PBYaPKiym8G3IPt8EQR9aYj6KK1R+g==
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
 .../intel/int340x_thermal/processor_thermal_device_pci.c      | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 0d1e98007270..6ea9892b3660 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -261,10 +261,8 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 	ret = devm_request_threaded_irq(&pdev->dev, irq,
 					proc_thermal_irq_handler, NULL,
 					irq_flag, KBUILD_MODNAME, pci_info);
-	if (ret) {
-		dev_err(&pdev->dev, "Request IRQ %d failed\n", pdev->irq);
+	if (ret)
 		goto err_free_vectors;
-	}
 
 	ret = thermal_zone_device_enable(pci_info->tzone);
 	if (ret)
-- 
2.39.0

