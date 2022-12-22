Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2720654966
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 00:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiLVXiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 18:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLVXiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 18:38:21 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2044.outbound.protection.outlook.com [40.107.6.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E4BB6A;
        Thu, 22 Dec 2022 15:38:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEG4ToBcxgKEUITpP8TsnXx02Et+fOynRU73t5IjGeevr3BmfnebqcwAB3YxL/uLrJImnGNk+6BXKuJ2Nm1n9Q+8tLW6kKHIivRM9rVhk0zxC5KARPX7CXncHecjCuumOnCpEMzOSVzL019BynSF+rOzetCAeYY9Qv8+GZWE8mZGCP/g25ote3BHmCFg2ICuHju723jgeYKiie48gJs0Yw97jfWmhhG2t97cOmzNq816PJpeu8Vm5y2LXM+aa4E07DvH1NzQERpZuMy5+5vlINwO3U4S7pR+aejnCxYsmmpJbU3x4gpH0r1r7wYBg2j6GIpE4eoWBRv1QXwXHGj3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iX9wKz0aqai7Sdrr5N2vKqm9Ad5snU+tJzidN8DyPA0=;
 b=W9dynWaHT28n7FZ+1Yf4M8qiSV4TdX4rrDDd3z8LHEBU8Glt2IACR8eXRCjfEqkhkL9n70s8C64xgSlxv4P0OqjvfcxfiWxWSEgqV11JCGF8LxfXaNQ1oGAbXxl291YovPXQG9dV6g9SL2ZMBWYD9DrA2DYjnmk8lykagd9AnzsKmYI4sP4DSHG2KkueKXXdeNvYqNB/pTPjBtCWVpbTCJJjQ+yVHMRJh9/Wz30F96WF5giLILyeBRAlGloT8xLoP1eP0qifunA1Qv/Ms+BbR0N0zkJ9/cF2LWWooXvK9YnEf5TKS6WWIX/tQLoP4AVLpQJmbfHdeXigz+7SNBTDhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iX9wKz0aqai7Sdrr5N2vKqm9Ad5snU+tJzidN8DyPA0=;
 b=yhEFY9kCGF/NiYIYrCyBh05bM94ycy60OHv91C7q6PTmtzeGKeg9Tj9hj0GP3cyT6cjXb1FxMomOyA8O4K2pJRhMLjQCQufdtlWNqFnynHfSfieEZ6i/sjs72hocHcWtZcznsvpyh1EhVRVA7L7I8SBaQrrYJzpowOBIeCN/qGuthTo5O3FixQ8GAFKuYyR2p9lSeHldPN7am8UxOaX0nerXOCzqUtJ1dO+YsE9MfsLQTvqSBm8gJUgugdtgz6DOCQ+AyXqvebQTJtrkz+AxG6zc2TpRwC06uhNejGE4cbZ0TAk8fDjYumITAdFN1LRzJaqXbC93+PHDGh9RlYiO9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AS2PR03MB9100.eurprd03.prod.outlook.com (2603:10a6:20b:5fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 23:38:15 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2b95:1fe4:5d8f:22fb]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2b95:1fe4:5d8f:22fb%7]) with mapi id 15.20.5944.013; Thu, 22 Dec 2022
 23:38:14 +0000
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
Subject: [PATCH v2 0/3] drm: Add component_match_add_of and convert users of drm_of_component_match_add
Date:   Thu, 22 Dec 2022 18:37:56 -0500
Message-Id: <20221222233759.1934852-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0205.namprd13.prod.outlook.com
 (2603:10b6:208:2be::30) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|AS2PR03MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: 95bddabe-aee3-464d-2fbe-08dae4759843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qja4W2aRGHd/OWJchZu9X+5LyHNge2NwqDEEyYXky9xitvHfJarZ7uRBr1JxHYrXO5LGyF1YnZwttN6MXBDVJiNaeDbMVpNKH/7qYp8E+i6PQQdzVu5zJqYcbjrFfXC5iqI2zZYSBpVS48uFZZKZcJi9vmuTZk2Z/dFTPaB8+Puk8V7aWKWtrRXNTy7M43XxR+A5v2l0S1m88CysODsyGtsqHvWvlK1hlUQ3SiR5O+n3d/StnYSFjNsIbATWDPT1V2BFCJ/hRWp94bSca15MQReVu1bm3GyzKHnl2c92YDHoRmHggWDygUQ5SV9fQ5HwRA3F6t6sZxGJaRLStLRUsW2gsxws+QvjBz9ZfB+vzRC002lBaqF9aca341Z5ZgYM7n8QKo6cZYULaLAUI4MT3NAo0M6ZzPjWcjuuzdW9UJ1owe2HI9UgYb88QMMm4Mx9RHUCLS7Y7cr+a4ORqaeH7uArPwgrdTagNDrRjsty+WRHYHKIf8H7wdmj3gYK6bI8fLkqYKmt7awwgDZYyRDW6fyLFAUkIk22FCqjY+Vw6W7tDSczfVEWMOp63Up11bewCHDr2pwQ/3OEeEAVPrteO4pui3SGvAbAsAn5rpJgUAJaRvN13WOE4qqGRR8x/X1ECHJOfwdFUTIWN3gGT/iW7wSnWIWLQIfc5HNiNtVFX/b2r3gs/ECnfU2erjAmZuOdc1RvvZRPvprEvE9wrxelYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(376002)(136003)(39850400004)(451199015)(86362001)(36756003)(110136005)(316002)(7406005)(54906003)(478600001)(38350700002)(52116002)(8936002)(7366002)(44832011)(41300700001)(2906002)(4326008)(6486002)(66946007)(66556008)(7416002)(6666004)(5660300002)(66476007)(38100700002)(26005)(8676002)(6512007)(83380400001)(6506007)(186003)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEduVXFCcXpyNXdjOU1oQzU0VFJKeHNYOEU0QmpFUUFwTW1GRW1qRFFwZlJV?=
 =?utf-8?B?NDUxK25OTGkvWXdsWTBlWkFBb2oyNW5FRll4TTB0amZkUjVyS2RuRUdRYmoy?=
 =?utf-8?B?cDNyZllpb3cwb2Rma1h4Ym1SVVI3dHQ2SExqemlDVG9BRFdUNFQyaEpuZGI4?=
 =?utf-8?B?bFIxZXhCT1VNaTJ4cTNLYlZBb3JoalljQ3doOTBxcmVabFptYmJwdmdwbUZn?=
 =?utf-8?B?a1JHbWpmczBOYzFNRHZIS1gxbTNsTWI4QnpCZktWTzlZaWVVN3R4c0liUmtB?=
 =?utf-8?B?LzNweHVYbmI2cHdUTHIvc0sxRlZIckhScEQxN3BHR29WckMxVVRyL213ZUNT?=
 =?utf-8?B?c2xDTnQ1Y0JRbGV0WGZIM0Z3T2xmejNWRzFZZXVDcTJhZDNwREJjblhMQjBO?=
 =?utf-8?B?NDc2NmZmZmUvSWlOY3Blc3MxRmtsTk5zWUEweUxpZHBlOU4yVFhoQUNIMzRz?=
 =?utf-8?B?ZkhhZFV0Y3VJMWJzWEs5dnd0SXZ4UlhtTDRDbHhxY2hzSnF0QWIxNzMrWnA0?=
 =?utf-8?B?S0M0bHJYU055L2VTbDN3RWJ6TlNJSjVDbGFXcklydm91V0Zzbkc4Q25Ockhi?=
 =?utf-8?B?dlhhVXVUZmgyK2UwUVAwdmdhbHRzS0NLcisycU5pYW82MEp5Q2g2VU1VOUEz?=
 =?utf-8?B?T05NZkhYeGsvUU10dC9USzRLN2M5eURpdWM5MDRuOXVvOXl6aHErME5RY1JW?=
 =?utf-8?B?QXR4c0RHK1d1UEVsaEp3R3FUZEVEKzJCSStkUWluZzJDNllVQjlSWjV5WmV4?=
 =?utf-8?B?anhRMWRGcjNhL0lFZEpTUVA2bWdjcmoyYXdOSXJHRHA4TUhXTStPU1dpdWVP?=
 =?utf-8?B?aGdWUzJLRlZMRDdwSFdIQTNHc2diMStQZ3p6U3JqM0NKa3pUNnNmTGtCbWFq?=
 =?utf-8?B?N2NZSjhwYkJobXoyRmVDRXRHUS83cXFodmJ2b1NCZTVzekc1cFZUckgyd0tY?=
 =?utf-8?B?dDRERXJ1aE5hUW5mN2hxZGdXMXgzZkZlbGVmaU91YXFiSGxQUlJsUGI4MXgx?=
 =?utf-8?B?V2dFYXRYeDVtWUxRa1QrQlZKTWQwTTZTdElYNlNXemxTOFFYSUQ3MXNXcjBK?=
 =?utf-8?B?dnpYTlVGSjdwdzlyK1VvTEFFWGkyQ01QWnNtbEdpY1JCZEt0Wm1VZVlLYUY1?=
 =?utf-8?B?V3NGbHlkc2dRNmJsU0NYOXlYNUo5QmttRkpkci96SnBDMDZEWm4xTC9DMGxt?=
 =?utf-8?B?UjFmVDVJZnhyeHpYZ01OZWtCMHp2T2IwOXA3ajNwVHQxaGhOaVF2Sis2a2JG?=
 =?utf-8?B?L0l2R1pyamZ1TWhKMXZGOFhNZTE0ZDRYNXU1ektnTGxkYkkyTGNYVThGeHhr?=
 =?utf-8?B?amRnUFdvYkNDc3REcFVwMEF5UlVuNytTL01MR1A2SUdtTkhRalZGeEFtWFJI?=
 =?utf-8?B?bGpqaXM1WUtNOEJVdVNhU0U0TGF6ckJDeldrNWgyM2ZkMTNZRmYvd0NOUndr?=
 =?utf-8?B?SWdtOEs1Z0REdzFFazJnUGJWMzlmcXdoQlQ5UjlwUExjSEZFUllUNmQxOWxQ?=
 =?utf-8?B?VTNHaERLdHdLWG5iMzFwWnN4L3NYak5xbWhDbkFaUmpTdkZrN3pzc2tORW12?=
 =?utf-8?B?OE9RQjB1TDdNSVN1dzVzK3JzM0hFRXA2b0J0UUsvT3hERHRMYnJUVHcvTGdM?=
 =?utf-8?B?dzRvNGpLY1dGNHlGQlM2ZlM0em9VMEtJdll0UDF0V01xVHJXQkpPbGMzSWRB?=
 =?utf-8?B?Z2gxQ1dCZ0d4YS9BdnVkbktIem5jMS8wS3lENUJPQktBaWFFY0c3eEdSd0U5?=
 =?utf-8?B?VHYycUJjRElPa3BJOXl0SEtPNmtLNUVmcFdlYktHVjUwUlQ4eVpCaUk1K3Ix?=
 =?utf-8?B?VGxyajNIM1gvVlJSb0JpY0F3VVRET3lsWDE4V0E4dWRsMUZMV1ZUTFlLcW1P?=
 =?utf-8?B?b3lNSXNPSHVCQzVoM0xHTW1keUZVZkI0QjhGOWxJQXFKQ1B0dDk4YTcrM1VK?=
 =?utf-8?B?ZUFTL290REYwdWlBR2syTXhjT2pmQkxvb1oxbWJqek1XWHBvMUtrcWxLWEtM?=
 =?utf-8?B?OWExTEVyVlFvNUFtOERiQnFIaU4rbWk4ZjJhL0VTUlBHbnRlQ1JtZjJWUUhH?=
 =?utf-8?B?N3NZYWdDZ050VnNLd09IN2RPUDU0SFFEVFZkc3N0eFRoZ3E1ZVhhVGFuUFJs?=
 =?utf-8?B?c21OdVRncTcwVUZQZnRra1lEQ3duVXRPbTlQQXUwZEtxYlp2elFTRXpTV2RM?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bddabe-aee3-464d-2fbe-08dae4759843
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB8847.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 23:38:14.5223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LXQgymlxgccz8OK/+OoLStjlMTW3CLIijdzO3LkagAh8sYgNsd+pIObMSk9WssAzh9YojyL17nsDLxvH6c173g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9100
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

Changes in v2:
- Split off conversion from helper addition
- Rebased onto drm/drm-next

Sean Anderson (3):
  component: Add helper for device nodes
  iommu/sound: Use component_match_add_of helper
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

