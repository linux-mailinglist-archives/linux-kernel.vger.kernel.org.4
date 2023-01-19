Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C558674290
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjASTRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjASTRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:17:24 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::60b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FE394CB6;
        Thu, 19 Jan 2023 11:16:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8oNTPs96fwsTN2J1iHzUe8T4NzzRhrKnpWH8FK8qfhxZ/9fpUNozNil65JI0cdrdVV32SZaL8Z0SVhrIJlm2okKCVcXOQvyDbCWuiaponfc2DTn3w9Nz//cnMJ9WEOIuh6rDUFbuIT45UAio1ahBFf0SzjVTnm/rAwdAu0mK/9qw+tCIpq7jk+rm/pDgkcCmZvuMIUSBz2xjaqn+pc7ar1f3y9ITZcRjrhnc0zA6Yq+LarwdorLiH9+bOzDu+eZf6XzoCNddRjDUTHzlEIYL1Y8gShyawl1NauVQbdI5uFEUig2zPxbDTR2dT6MN9elADmbfTLbKGwoCvrmsSMiYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4yVKGEYAJ1JxUJ3P+i0jWX8PR5LYdfiOQPVsQw9op0=;
 b=L2c9Z++JOFRThXIXaPxG/JAbUY7T8fsi0Hatc5XRcGfeL1zBqALnPuvpkQEg8I4cK6DiKgo9DMPszTHMOv6MT+5FfxPVq9aqyS04ppGO4yicFWDTAsvyq38DhHFqlIQ7l1cLZWLaF897QKqK07ZdnjcfnwjA7mfzbYhtbxE+YQFGSAzYMKM92qOYe4FsdUWjDUeG8+crjqzqfRo4EQ3CDp1d6s1abppje5/PR3gYMUyPI/rnJTtPlmIeUajTXmzvfxW0F/6/0TyvJcYdyGrXSdGY2RGLaT4fpVlXxiYO+zMlC5sSASoqWXinzlHrzfAIPFEXNQ8FdV8jNCUgH/yMpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4yVKGEYAJ1JxUJ3P+i0jWX8PR5LYdfiOQPVsQw9op0=;
 b=WG4gSkqWYVxfNPP2lYLVeljWWsY1F37O0gL66e23yfs7efAWHl8Jhhg5kxzvTnNg9oD7H0J8eMYD0eTiqvRRgGWmkZfJ5r5ap65rXNLh79ikbjqWvcVlCip9GhothfXLCuh0MtxM/zzc4gq6tdekPURUn8wC6nWRQ04Rgf9g7Ua26D57wvRitq3BxBQILOm7Das0dGerm8vWwEZ6xBei4+CvLfzaYXsPgSkGpSKgFxhruC46jqcnQUba7sbSFnboymLVaUsQ7k4D7+LDFdXL2PdjQMM7WuEOJqb5/lHAB9SbefgFe5X39fITivAnlQ489hxMxCKox//+9Swo/NXVQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DB9PR03MB8259.eurprd03.prod.outlook.com (2603:10a6:10:307::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Thu, 19 Jan
 2023 19:10:54 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::6b03:ac16:24b5:9166]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::6b03:ac16:24b5:9166%2]) with mapi id 15.20.5986.023; Thu, 19 Jan 2023
 19:10:54 +0000
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
Subject: [PATCH v3 0/3] drm: Add component_match_add_of and convert users of drm_of_component_match_add
Date:   Thu, 19 Jan 2023 14:10:36 -0500
Message-Id: <20230119191040.1637739-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0047.namprd02.prod.outlook.com
 (2603:10b6:207:3d::24) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DB9PR03MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: acee74f2-4797-4454-9ac2-08dafa50e2fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2OjThEFm+mVkWgaYQIqcDEN9IEMpLSdBEmxordzg5y+hZbEPS2sIbcfgNSCUNmkLHib3/Ke+R/X7FySfz5hy4Td9UfpOGfZsvHfnQ62ZAqtD6PQM92F7a/EyyVB1CE7AR81l9Q9RCR3bil38k8AY2JywUMxW/ypSznUPmO9FCE8o/bIQ0Qw2NeS1rgNWOOrNPLkKwR9Nqn5NvjoZlb1oyKwtCCSybvD8Xfmgm7B9NLm5c8M+PWDL0XDKt9/o9LrFUdwLUb3YjCidMpXWDlEe9aqcl73jDaK3RBL3g0n6Pq7VRSDYqb+w/CXddYR8aB4oXBh/LpzDD5SpYK9L5M6GtJJ7CA3xQvC6usVYJaaVTqijsIxdtWZlvfJQIOixvbv3sYbyz9cB2ZgGoydLhpCxjwuytqXkhfBM1LJ3Ks8iBmQ+kNLoN+iSedI0QHo463FdDwzbczz61QOGAkDq5AQSye2GC1P6zSEnIExZO7ol8cIrD/fuCndPP2sCjWlVjv2RhYIkb/t/ulUnv/Boha+zxuAjO0wAcsq0X5FtvsIayuZqb3lRZv181nWe/sD3+QCg8LcrP/kStnPZ+OZiY0YIgRi3gGvFIl7p+RMrz06uUy77qclT3IA7tmczw/RoNjsiHS0Y4BKx6PYiHylHGzgdSQd7Hl9l1EvayRRXD5LVkc0XJx6RSgCGg0LI1uISObQGdLHCEOH3RbNZusRdYqHtAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(366004)(346002)(136003)(396003)(376002)(451199015)(66556008)(44832011)(5660300002)(8936002)(7416002)(7406005)(7366002)(54906003)(41300700001)(2906002)(316002)(66946007)(4326008)(110136005)(8676002)(66476007)(478600001)(38350700002)(6486002)(52116002)(38100700002)(26005)(6512007)(6506007)(36756003)(6666004)(186003)(1076003)(86362001)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1dEZDVwM2lNSXJuQW85aXJibkZJWXRoT256SFNRM3Qra2NTdEx4SFBMcXRL?=
 =?utf-8?B?L2hUUlRJU3BSZFRBM2luT1orWUVSc0tpaXZYMlpZMTBFYklCMFhHVG1JYytn?=
 =?utf-8?B?eVJsTnBHcEpaUmprd2Q5TmlsWnVETEpPU0VPZ0dCNFdYNGpiTFZjU1h5ZitB?=
 =?utf-8?B?SERNa0U0R2lmQ0lWQTZ5U0llTUxrYU5BRUIzVUtIaTN0YnFFWkl3U1BSdFZS?=
 =?utf-8?B?SFFCZXRzQ0dSV3l5NHVET2Vhc3ZubDJyekhNYmpTYzlGOTd2T1NoMnZ5czdj?=
 =?utf-8?B?YkZiYUdUaXpRMXBuNE9EcXdWU1owSnpheWp4TkFmUHZhUHA3aXE2bjRqTWRH?=
 =?utf-8?B?VTRMcDNiY3pBcmhHTjNocDNJbTVTbTdlMTZYb2N0R2VmMG9yTmY5aUxqWDA4?=
 =?utf-8?B?dHlqOXdCbi8yZTloR2Y2VE9tSWhrUnNqckpkWHc0NmtQWENTOWVlQ2hITlla?=
 =?utf-8?B?enFwV0FYOTdwTkpxLytFenpOSEh6OWgxeExIQU54WEhUZnArWnB2eDBhZ3My?=
 =?utf-8?B?QTU5WmNsSnc1QXp4bmVLYzNreHlKVkVaZmdrdXVBKzhDSzRFclBwcHVOU0Iy?=
 =?utf-8?B?TFhIWVVuZlJiTDA2SkN1bDZRc1ZhVWo4OTcvUkFUbnQrWXhwZFo0SHRzVXVm?=
 =?utf-8?B?SGFXeDBKWVlZZEYxUUttYzd3Z0FWd3RSWHBsQmpiMDAxT2ZVQ2tXblh5QVBD?=
 =?utf-8?B?OVVGZHlkdFZxc2VLMENEeGVsQ21KdmQ3RzA3YTZWOVI1R0tISjhNUm5SZ3E1?=
 =?utf-8?B?eGZTaEwxUVA2SlJCdGQ4RlQ4ei92TFJxTlVoN2VZVXQ0WUZ3SG5BY2RnU1NB?=
 =?utf-8?B?SWF1UWx4Zi9pOHQ2M1ZXekdxUWdKQTZnVnhyejhMdWJxNzZFS3RMUDhYdTJu?=
 =?utf-8?B?eUUyNGYrSVJnaEh5cnhYamFmTVhFRXEwREhYVlJzbmg0MVVEVkRBVUFUWXpR?=
 =?utf-8?B?UDM4Rk1ZVm5mVGUvRTJjV0tOWHRpYndIOEErMTdqTDB1NVc2S0NwVzFaTm8y?=
 =?utf-8?B?dENEcC8raThkQUV6Z2taNWh3K1dUMzF6UWIxQlczMzRPZitSWmYzd1VHWXNq?=
 =?utf-8?B?T3FwYW9MUXN2QkhtY1hhSlA4MVc2NXhJRyt2cGZCR2FjTWpNcmh6TVRCRjVP?=
 =?utf-8?B?dExGdWVlcG1yOGpsZzFWalhzVGdlQmVMSXRrSmlzNkhDMmZiNzkzTXViQUZu?=
 =?utf-8?B?L2ppdjlTQ2Q5Si9KVU1xQmlIclBBaWttbGxuNTMwU3hiRTAySGliaWd5dVc1?=
 =?utf-8?B?T1YwRld0cHBJblVIVnVXZXB4NiszSjFWVTlxcEFmWDBBQjBaMC9pbEdVWm16?=
 =?utf-8?B?Sk5BNkRoeHBjM1dBMGFyQnVWWnZqZkhtTHE0T3NoblphUFd3NXVJVWRvbWxI?=
 =?utf-8?B?UWU3RlRuOEJhSlQxZm9UdlNIYkM1VlpTbG5TNDd0eXAvM0hBei9abVBTZ01z?=
 =?utf-8?B?VDl6a2MrckdBTmZkQWp1VjExZmd5c2ZXQ1A4QU02VGxhYi9CMDZnRmM0QllR?=
 =?utf-8?B?NEZ5Z2RVY1ZIRGRZb0lJaHd5MERZeVlXWVZ5ZUxTellRNVhFV0gwR1J3bVRD?=
 =?utf-8?B?NUZZQ05FZEFiUWdsa1o0Zi9WQkJvaE4xbXZXOTNydVgvU2tybnRNZmVsLzNH?=
 =?utf-8?B?ZitFQkovUDhGKzBhZ2NUVWh0a3FQbWR3cmhFdjZKQ3ZvM09YSkwwVmVWNDM3?=
 =?utf-8?B?bzcvNXdnRTdvNzliTnBlZHQ0bGNmczRmd3Z0MlREL0ozVnJ6cit6UDltNDda?=
 =?utf-8?B?amtQYzdxYUtEOEpvS25uLzNlZ2M4dDFKeHZuMWtEUjdveDliSVpXY0ZOSmVR?=
 =?utf-8?B?YkYxYmlESHRDeERLczRiK05wd3kzNnpRQ2JRV1pYQnkyTHZKcEdITFdhUG5V?=
 =?utf-8?B?bVFPTFJYRmJIUmJ3eThxRjh4cjlEOGw5Q01JUVpDTWJoQURhNDRvMUwzOWEz?=
 =?utf-8?B?WFB2Q2J3QURjQmlnTlpPWnFTblhuV2pKMUQ2ZmorNm1WTTNXUXNlMnV1NmpP?=
 =?utf-8?B?bFdYK0JZQWFtdlBVMnJmMEFhRDM3ZytqS083cmxKamRoUm42UUxsUXFML0Z6?=
 =?utf-8?B?TVhRSkc1YzRwZVEvaUZXb1UxREQvZnhKMDI3ejBQK2JaQU85M3hSODJhdFZs?=
 =?utf-8?B?U3Zxd1JoZVRZRUo5SnVIQUNZV0hrZEFGdmk4NEZGUnNtUjk2UlpwY2Q1TUhy?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acee74f2-4797-4454-9ac2-08dafa50e2fb
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB8847.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 19:10:54.0688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TExj+ppozAjreSiOV9g4J2ykelKHdKd0NP0WBONLswrnOPWFM+8GVX0rfp3A3TZoY2g0nV9DtTpWGarMmalpFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8259
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v3:
- Rebase onto drm/drm-next

Changes in v2:
- Split off conversion from helper addition
- Rebase onto drm/drm-next

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
 drivers/iommu/mtk_iommu_v1.c                  |  3 +-
 include/drm/drm_of.h                          | 12 --------
 include/linux/component.h                     |  9 ++++++
 sound/soc/codecs/wcd938x.c                    |  6 ++--
 17 files changed, 45 insertions(+), 94 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty

