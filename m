Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A326D745C1F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjGCMUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjGCMUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:20:17 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2139.outbound.protection.outlook.com [40.107.215.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5269E69;
        Mon,  3 Jul 2023 05:20:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=as+30XHx7HCV5gicGQEW+nnERsjPOJ9OC/nQinTlfIKK5LZcqY4mFIxizWriM1MaORuy6D+dDQuQ1Veg1lhnwEWpA9tYRVmtNSd1rCux2+9S14M/PeOyxfNzem8g0ZQVZsUY3vNjNuf03k7i4dOdP1hEf6XCkCbSCZAASQzJZl9HF8rzbWMIVOqtyCvZyPKEPJaWAZBXVbTmgllZfl0S0JAKSztrn726Di6j0hCCxd34VoV7xWx6UNoDYrP1yOZJGhXBOQOmWCfPaRhGYnAfiwZo+mWQunv1dkUesVHkDl3VjvJUjW04tJBHBtguypUKTRAXiRqizDU5X+cVqFWP8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqwaxnR3m41ZLeRiQ5+ccNXQz0KPWjyIStNkchv/s0o=;
 b=HeIb6kmRbgdXoCdTtCIMCsqHjNUOLbkw7H3G0ir3gGWKBM7Kwc5CxHCyYzYwjm1UqtqvgOeHpnnZ+29lNpoj4BSnWCKNSN0kXXtuMi8dMeAdMT7tPTGmVgURvG3fOwhMUD2rmz37f3+Bsd8EqFUydTCeTEK4bCxLMkyXYMjS6mBVPSk1YdOglmEPL2k6uIOcMwWoLayVDoX47wUBbiQzyX9TmcpsrdLFGPHorzivpD3vlNnmMrL6sskCOqCToQsh2MM5aFdrbjLu+WizX9sMINeWbdg1wWHPyoLGrT9404xbHyTwTVjPSZ0tsfLGaPCxvGdekXnt1jAIX0SadbPTqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqwaxnR3m41ZLeRiQ5+ccNXQz0KPWjyIStNkchv/s0o=;
 b=n90k6Yq+wxVp/PEtaOvRU9+MFgGqnrA567jMwtL/BxY8Bcxscy0ijiWtV2ip+InIzROvS8WEeZI8JaLCLv1m2+iIXBW/OrIGwu5kXxjScvREz7YIXhS8syZSuMDcvmjlMXyIIQMzSF7BPel738Sv7kAvLpSBvPO5ryIhp942Z9vYJSBTsWvTEdsgB1uqg+A6EagD/8TRrDw9L6ltfRRbhQS3plUdfJFS0mitsDwhy2ZQPXvibO+jYTDPw9GL+rLViNB8ReQqqd0oMYVieedB879F+9KZm4IGBtPN7XmrK2VQ8mWfMLWlVehaQ3HhWBY4+08caHoHvFac2gcaz2TVRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5373.apcprd06.prod.outlook.com (2603:1096:101:6a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 12:19:58 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 12:19:57 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     tglx@linutronix.de, DLG-Adam.Ward.opensource@dm.renesas.com,
        agross@kernel.org, alexandre.torgue@foss.st.com, amitk@kernel.org,
        andersson@kernel.org, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, bcm-kernel-feedback-list@broadcom.com,
        chi.minghao@zte.com.cn, daniel.lezcano@linaro.org,
        festevam@gmail.com, florian.fainelli@broadcom.com,
        frank.li@vivo.com, hayashi.kunihiko@socionext.com, heiko@sntech.de,
        jernej.skrabec@gmail.com, johan+linaro@kernel.org,
        jonathanh@nvidia.com, kernel@pengutronix.de,
        konrad.dybcio@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, matthias.bgg@gmail.com,
        mcoquelin.stm32@gmail.com, miquel.raynal@bootlin.com,
        mmayer@broadcom.com, niklas.soderlund+renesas@ragnatech.se,
        rafael@kernel.org, rui.zhang@intel.com, s.hauer@pengutronix.de,
        shangxiaojing@huawei.com, shawnguo@kernel.org,
        srinivas.pandruvada@linux.intel.com, thara.gopinath@gmail.com,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        wenst@chromium.org
Subject: Re: [PATCH v2 01/15] genirq/devres: Add error information printing for devm_request_threaded_irq()
Date:   Mon,  3 Jul 2023 20:19:44 +0800
Message-Id: <20230703121944.19016-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <87h6qpyzkd.ffs@tglx>
References: <87h6qpyzkd.ffs@tglx>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0101.apcprd03.prod.outlook.com
 (2603:1096:4:7c::29) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5373:EE_
X-MS-Office365-Filtering-Correlation-Id: bf26a7c5-ea23-4e75-0a96-08db7bbfd0bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: maHk/O+WNWrYBcZrQxrr2d61N6NPCs3h0MWQ8vrHNj8fSoRnyWHqr8FMmHsixYAINkWMasMZNjT3eWFVNNEVl2Axnmlb/WZWVQ+13TvhuidY4VXKAQ8pxhbg5V2ZKQyTx8+3xJi6RWM+r0lrEsjypM7DGXSiqrIkYDsryRK+tTNbUwOC0Cv0XhWqZFRLa9flcgDKvMq+wrx+KUlHs2siTZfC3b0/47AltKyHiS9FFVO8V5JKt8KJ/0+ittROIUzPciK+DvZSzOz4EOubUijlw2SosMaAqjqJUo/VS97LxXkAeJg8dNYlQMtoe3OftWp34GoxsS1Omzg75tlcT9somg/8x7RCfXkfcA8HwM9XxOlL/4o2clgU83dp/344TJ9PHcvPfUhCls5qJxidLNoYe1uAqzRqyMNZZI977oQY692kED6gsjakOF9GB0UZ+3b3edAyv2cXyaigbTMPd5th5LWLdCGbIYj7vEiTcyTwDVfY8BcL96++LfqcjpIaVYViTZ4hJeRyVuLqMek2qD630w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199021)(26005)(478600001)(1076003)(6666004)(6512007)(6506007)(86362001)(2616005)(186003)(38350700002)(38100700002)(6916009)(4326008)(66556008)(66946007)(66476007)(52116002)(6486002)(316002)(5660300002)(8676002)(8936002)(7416002)(7406005)(41300700001)(2906002)(558084003)(36756003)(15477505002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?40zAarMHXU7cdcyXpy/xTkguWVOl40TwdkHwi5/G99MfsKuczImKWjrMRrro?=
 =?us-ascii?Q?sedqSrBMRezJZ+JObZeVu5Oc1xqQ6DAIYJq21wKApSkmZXFL01kJxAC0YheI?=
 =?us-ascii?Q?ekXLmIEwtwZZed+H8DVwhyQsR9bXTiMQshEuza8ima7Q42rwyhz/IIeCI03u?=
 =?us-ascii?Q?dR5/eHw8oh525se9/HW8womRvjG/IGGNldNlvJaCU7l+9kEdmobgx+FTLdpe?=
 =?us-ascii?Q?PRSW8nsSrX16ftZWdOB/afZzqdPakcvqMuDsRzcw16PIt3ng7auNnfWoeItW?=
 =?us-ascii?Q?ObSa/JdRwH0qbPwZip/VoEJr4zB326AIszKEXUP0y66x4Sbmcy1RcqmRG0YK?=
 =?us-ascii?Q?x42OTMqpkpeYhzIlLtGUspZr07ivhGEEalsRDSMrRCEdcEo66bGU3dAb2vfb?=
 =?us-ascii?Q?jiEfTXE0IVc/l3bn9d75TVPP2vej4qp8eHaarQZW0PsRl1bozE0tRnlQj4D3?=
 =?us-ascii?Q?JLNJRjfvIzPya7kltiRYHdEVgPXSaK6JxKTu0SaWcmFrkcTyodEXXCDs+zUB?=
 =?us-ascii?Q?sLovf2qRYjAXr11Qfq6NerKT1xvUpD2sEAhkG0HFTUzwobIwMInslz9wedc3?=
 =?us-ascii?Q?W8n7bzq18vPJ2p+QO2eOdS8nGacZO7iloAdxHomHcNhemJG9kGc5mU9enk1G?=
 =?us-ascii?Q?HCg7Tq2M6dWVmLEAKuiWtGraZwamLkwgCiIXixnYDL2E0NdYoUxxx1qqxvAi?=
 =?us-ascii?Q?Lq03qhhaPVPj9ahn4Hz35sUOu20tlAPgU4nAcSglI6nErIWF6CPFqijnChU7?=
 =?us-ascii?Q?Ykl2gPe8aiF/e0+nJVZmZpdB5ERQ0fcd78LyDOUGb4biSaPmPyYxCrDoTYGE?=
 =?us-ascii?Q?055kK8tigtGwl6Lv6aJkI+bLbZ+gpqmO+6sb8rXUQFoBh6J606UpIVuMVAR4?=
 =?us-ascii?Q?TCiyBBJElAe4FTXDDJpZXDJU4o8Zqg6IcJRJ0dZhd34YE1lOHamT36jqyjaO?=
 =?us-ascii?Q?MAVupT9JhZjP176qW8kbx6qXXdM0KszeKr75pCXROyNR9ynrQEEp3BJ5WKz7?=
 =?us-ascii?Q?rtv1Ek/nkDNH0foqZQudoI6Y76fl1/setqMNQ3RrVV3yR4qElX8CRRf+x71s?=
 =?us-ascii?Q?xIYArV5Zw7SauxBhh/KuewibmpCwc4Sz24Bo2+eTnIyW/wTzyYNkULtokOPq?=
 =?us-ascii?Q?Pnl6nMv8566Gd2ETgnX4FptWP13bORUOGvKUlvUD8eRyUIIGR2A7rudwMmkk?=
 =?us-ascii?Q?fqy0DO35Xee6XVQvysvtcbCDo9wlPwHexcBZHROP5h24OKyc4x9e/M/HwOMi?=
 =?us-ascii?Q?mgorBLE32Mx/xsg87MXpVcMh2gle0XHRnu8Bkss3CfLhg8pnyzupBZOH0QCf?=
 =?us-ascii?Q?kIlEKssU/P01012iRoLdhmUuV90JwczoizvxM51hNV2413NGsTyAmJlEV12g?=
 =?us-ascii?Q?bKs5xGRfst8PU34Oni0IAKDsN7LP5zbcM6x6Dnkanct2y45qgF3JvDT0z6Tv?=
 =?us-ascii?Q?vSzFobj2ccHdhtk2mvGeN3jVWMegWMzcuFXbpG0FJYczETtDG2UL2mD6tRc8?=
 =?us-ascii?Q?soS9Uv3CFiGwVwQWpBxGd4hQsUatz+bDeAgZXpkqtDsEZyY1NKyI8HLFLRaa?=
 =?us-ascii?Q?jBbmHUxOQBxwhTdwDe8Z1Op+/FCiUmdQlI+/R82Y?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf26a7c5-ea23-4e75-0a96-08db7bbfd0bd
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 12:19:57.5974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: goqbXUv8FUqBD8TGwVi67mIVC8YaECgVv0moCAOft7hE+pfPFYcO/QjV3wDLaIXM7gVPqSJ4x5n9zj+yBwbHYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5373
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc krzysztof.kozlowski@linaro.org
