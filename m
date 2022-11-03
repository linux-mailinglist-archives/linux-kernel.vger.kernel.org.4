Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECDF61875E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiKCSWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiKCSWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:22:49 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0B613D53;
        Thu,  3 Nov 2022 11:22:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CY8tFi5j4eb57wIWm9SmJ3WS+msYucNe0KCWBo/bP83s9NOI8zkhLkyk9b3e8ruwDqU3kurBZSuwwjGsdMadf4mBvY9SCfgN1FtbnHSqEK0N7JRKS9KBWQ2OZQhS1sBOEU5ETnOBWdpnOLsb2H/eoNmGZlkuWXPb5SeDW+A8mDv5HVruXWBGa7O4wuBPFS2+rsKuyhMfWcpctrm5sj3FTKI04X7tf22nllb95Y+9eszpHJVHP2tVuoO8AW2LOKtxmn7zQBD5DZipASGgr/C7+sX/ozwokWqDAUJck5kKzzC8RHV9f9rp6UHHtCIvaueLcItG2cx5DbnSpnr7ofdhYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mm8b+i8kaoa5GNIQmxKcTysRfGEQ/TwPev1Pm7fN78=;
 b=byIKyBf456hTxf1j6UUFTaaAXJmf6wbfyawbQhlmssRlmm7J09EP+bqOaMNnPQiuiCu19k6+jqk27LhrTPssKtkzx9KiN79pgb+yKSMEj+7HFm2kTckgw4CyKJAbM/zI8/EgMblvBG5/IO6AAGpoe5H5jFc0euAwCZsC8EIy/lOtA9rgOo48erSOrdoFF0KMkfaMJCwy85hbyb8pVso9kKUK993kqq6Bm4ziEPmAHHUmHAuM+wmQyNXlprD3qi+t4SiM+XqwQXLYwk//vLRWJTIG267PyB+uH2fz+cVUXssMpEJQ4IhRlANYQxgEvBHRRHzcw21mqUlodA2PVRMQOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mm8b+i8kaoa5GNIQmxKcTysRfGEQ/TwPev1Pm7fN78=;
 b=NkKTSWUYgxBnswbTIvKqCEnwd5xiLjpKRmu0mYT4XIsJlriF2IDzQOyhOy6jcX87yI0qwbNfEals9qiN8/iSPqFt+QkYDkTd4yspJQdpaGU1bfgQw2Z8VG8+kM6iivo/RO0lAbVwLAQPTYtOpi5ZwKoXnDO35jageiaujQ9vfVxmlsVb/UUyVi8eP4ev+Bjk4O1oMYHKg7WJLTWipG4sXTmDnfq0fr4CKgusMfZxvz82ue5yYxWNmUN8XOAXH+LVERM2p1MUxO+Zz05PxZhwQALiFdaayBILoR1zmdQNrcVK272gboZzo+z03J1SInwl2iyIS0Nnlx4hBBTt/ZHIFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AM0PR03MB6195.eurprd03.prod.outlook.com (2603:10a6:20b:159::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Thu, 3 Nov
 2022 18:22:43 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::e9d6:22e1:489a:c23d]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::e9d6:22e1:489a:c23d%4]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 18:22:43 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        John Stultz <jstultz@google.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Clark <robdclark@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Samuel Holland <samuel@sholland.org>,
        Sean Paul <sean@poorly.run>, Takashi Iwai <tiwai@suse.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Will Deacon <will@kernel.org>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Yong Wu <yong.wu@mediatek.com>, alsa-devel@alsa-project.org,
        etnaviv@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 0/2] drm: Add component_match_add_of and convert users of drm_of_component_match_add
Date:   Thu,  3 Nov 2022 14:22:20 -0400
Message-Id: <20221103182222.2247724-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0027.prod.exchangelabs.com
 (2603:10b6:207:18::40) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR03MB4972:EE_|AM0PR03MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 165d6b21-a0ae-421e-e929-08dabdc86649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zjRfd+QnVSzRpss+q5NSVrdboESkeLaf635jO7nCd+5AfHOytRGwOhHasmTTO1pQpqajph4sSEOJmybpoBRCvBwaVzDdezHbGCECIqNuEdjncZFkx1a2G3VXWi/GWV4AEajDOJpGpfgw0f6Ec+/kox3kUV5MhGqzyiHOjgLbIuEFU8utsPKdGnIN5rwamChxdfmgGTq3DYrvxgceaGJhM9M1v3eKweLM/BXJcMDEP8D7RnMLhiU/waidHwGdwBGhHB22fM6KWq8hF85m4EV/i83ih1rZOk0ruKpB+jNtkY9/x3Xxk6BEVZeT2eZcaJbRc6ltwMh/ggkEkB5xt9P5jpYNY5MijiJXXt4eym5vPdvP7la0g2JLxrm9oiVBhpjq9N6HhuIgSiPkg7FLpxIxLBTzldx2p1tkwXjFej+ualaShF6JFG7gDyBIlnSu/UJo+JhitiPaEszCipMrdAfPZvhuSk6arWfQHs7RvWtBmoOfvVmCfYK4GC1ZGIIEqIxoGNj9ErQYSj4Ox/hs5SQM6eCB/qqqadzoIqa4QxZjcsG8K+brDJgzo8KbsFvx50nHlOWVoFvNh/eYoe3N5ckUdfTGQM6eXwi0oa26u/nP4fGBC6AlXJejFQo6huGQ3hTFe6SjtkatWkERmr1PR8rJ7Yv7kxdEo76vvDlSBq+KDWJh9Bc8z2y18dX0gr6+yRkg4RrU3JxSkBdClNTirjikXGodeV6j5Vmvzm7Xy4G/YGZD2IAlm6cJVCBG9cMbTP64Re6xTjLVPLM6P3KDPyx4mQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(396003)(39850400004)(376002)(451199015)(2906002)(8676002)(66556008)(66476007)(66946007)(4326008)(316002)(26005)(6506007)(6512007)(8936002)(36756003)(110136005)(44832011)(54906003)(41300700001)(86362001)(5660300002)(7416002)(7406005)(7366002)(478600001)(6666004)(6486002)(38100700002)(83380400001)(38350700002)(52116002)(186003)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qvhgM9JIIGfJ36wiGqaYbIGFpm433vLbQDQwOoDtqEGLjJ02JFdfiDPyJAjB?=
 =?us-ascii?Q?UiIX69KTyq3VdsSpFVKuwCk1nDKr1tGlheBBgq0mPiif0XCBi9xUwh/ctbJn?=
 =?us-ascii?Q?UEpMsDjD5FwR/5wonmgQfrmpUIQuRYzppt1Oievas9DK0Ru+xjy7+zWDgSkg?=
 =?us-ascii?Q?PYQlSM+b5BPBQZFWGx6BTGo5M+vavQi0e5SbXV6wAtwGz39mPQyQigYpEZ88?=
 =?us-ascii?Q?w0Kh0xeqwPPRLvLOV/9jl1PvIcSPSaxxqorITWkSFty5VY/OHaX/leN/u0Z7?=
 =?us-ascii?Q?g2ZbiO9vubp4PE7hzy4mUi356Y/EaaI2+fGVkUBEq6+J2dRmlYJinlayrt8o?=
 =?us-ascii?Q?KhprkwaRYu+CDu3xM+5obPhLBPGzrl0nbLdN69ohn5lw5ueLoZMxcHIp6gZx?=
 =?us-ascii?Q?cbh3/ltgqGbRzxwAguIOayKAmpzWbYsBqNbaajhFGtFijZxUo+sGXhOGjLRq?=
 =?us-ascii?Q?lfMpc1g12QbcHg+m1nN+32xmvgLCAm/9B4yMVx89lmSBUr4AabvuqzDFyQtn?=
 =?us-ascii?Q?8wPlWIGkIrK2+MdUBolibmUFCxF02N/9QihgMWJ2HWJiC+9aLaDoV8nn2Vn9?=
 =?us-ascii?Q?mf5Od65R1d2N9W3BibxSoi2vytGhlem3HlOe2vyYKGO+vwuRAFOvl1mZt+4M?=
 =?us-ascii?Q?+x9LHK4TvOCkbHMQi3zfSsBoXSbAw5sJ3X1Hb+nfAc0z6p6oeTEUPx9Xcv7w?=
 =?us-ascii?Q?MG/ZrQ0mXLZRJ+P9Zf6oxhSKnDCn6wYF+4Ll3AT48uOtbWbafVrEWQxA6nty?=
 =?us-ascii?Q?nVrJULYEXx/44+6E6A9YLZoWRWyEEZL267vhjhN7bjMeaxuXKaK2YtaRn7Zn?=
 =?us-ascii?Q?++gNSqjcUjYOsQquzCj4pvNoNldR5KmtDlYDOehAjaK6GkSzZJmnsxFNBDD8?=
 =?us-ascii?Q?bEDTxI1V84Le01L6YPsGok3iYqc+7td/rwFr0h2NzIGWhEq0bT18q0Wtrqgw?=
 =?us-ascii?Q?prhvpJhPK5VT18jIXFHDg0nm3ebklihKDis3oizLoXpHBlWhrvvo3hk13Q39?=
 =?us-ascii?Q?elncT7AODsOg4gGZyTNmxKkyTfopYFjYbKlfGBboBwKMMrIk9e3wPwL4CCp+?=
 =?us-ascii?Q?L8n94fyECt56+1f15IyaUyZcuzu0zoQM+LY/QFdbJiT2EZLG+ZKjJq0fgxQ1?=
 =?us-ascii?Q?n85V4eaKkCNUn30XElqlnaui72d8KlADRQHDZar6YfIvAlFLq29lMGz384tI?=
 =?us-ascii?Q?MuQ0pAG+rp0j65CJwtqnDfSen6Q0gZCDhJmKoIvi9cMCR35LacT+Nf0n29iF?=
 =?us-ascii?Q?S8Q6Cm7QAIHToVoh8ZroC2VLcSUuNyQNA65IQv4phFDyyg7KmLHctPRJOHMW?=
 =?us-ascii?Q?HuT24FULWewwaLcsVLf7DMjZ7mLHfxp4P53Vyro47t8xZd45/lX3qOUWKcum?=
 =?us-ascii?Q?vh90OxbHcKS2wPWz7SSyrmfex7MvFoqguWGBOJEyf/eI0coVC/gdIXzkvP8l?=
 =?us-ascii?Q?l09qv0QXoA4HC/MPUNipuTtwcYEtz1V4jEzfVyisPQ2v6GiqK25HGNcRk4Wu?=
 =?us-ascii?Q?7NdJITYR4dEqnQnoPU2Q1hm3IymR5e4BudICNYbnYZSkDHyNnw+OKfj+OeP+?=
 =?us-ascii?Q?KrXkNKFJA0Lsc6WnU2Oo5twtewMLIeyI1RvMUZlv10QXA1y3uxWki7cCUmiB?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165d6b21-a0ae-421e-e929-08dabdc86649
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 18:22:43.5137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ig2SGSpQ6OnuzxRZlRDcbW3gp/tRXSTxR0/0VOG8ABtDrrJPqKRI8p5gXODyrlIqpORn8X+Hvnsm0o4VSjg5QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6195
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a new function component_match_add_of to simplify the
common case of calling component_match_add_release with
component_release_of and component_compare_of. There is already
drm_of_component_match_add, which allows for a custom compare function.
However, all existing users just use component_compare_of (or an
equivalent).

I can split the second commit up if that is easier to review.


Sean Anderson (2):
  component: Add helper for device nodes
  drm: Convert users of drm_of_component_match_add to
    component_match_add_of

 .../gpu/drm/arm/display/komeda/komeda_drv.c   |  6 ++--
 drivers/gpu/drm/arm/hdlcd_drv.c               |  9 +-----
 drivers/gpu/drm/arm/malidp_drv.c              | 11 +------
 drivers/gpu/drm/armada/armada_drv.c           | 10 ++++---
 drivers/gpu/drm/drm_of.c                      | 29 +++----------------
 drivers/gpu/drm/etnaviv/etnaviv_drv.c         |  4 +--
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   |  3 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c     |  3 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  4 +--
 drivers/gpu/drm/msm/msm_drv.c                 | 14 ++++-----
 drivers/gpu/drm/sti/sti_drv.c                 |  3 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c             |  3 +-
 drivers/gpu/drm/tilcdc/tilcdc_external.c      | 10 ++-----
 drivers/iommu/mtk_iommu.c                     |  3 +-
 drivers/iommu/mtk_iommu_v1.c                  |  3 +-
 include/drm/drm_of.h                          | 12 --------
 include/linux/component.h                     |  9 ++++++
 sound/soc/codecs/wcd938x.c                    |  6 ++--
 18 files changed, 46 insertions(+), 96 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty

