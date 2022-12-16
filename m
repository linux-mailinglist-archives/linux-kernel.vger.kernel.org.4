Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241B664F00B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 18:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiLPRJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 12:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiLPRJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 12:09:12 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824BBEBC;
        Fri, 16 Dec 2022 09:09:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Su/tLwTwHlabFmapw2PIBqUfJAVP4ss2qieCOMyPEwieTBKlq3jSQcJo4OVMSOFRa0AIF9FiyGZ11Xc+HI0R+G2Do00efNqpg8kviBL8ocwB+eFYy+q07+3Z+VjcU02hBSlQFPaTppwfPO+m7+u7UNb4/h8bLbg8U9am1S0hXWPMpROUVInOUxmbnT+tCYrSSWJgzVv9tE9dpFi8CRHBF4SC7fsvN2/iWKCSk3I+HKAU+Fswd1i2uZT/aZZfQuSckeQy5Jge2YFn8r7XxyDwppmP/XUb+ewlvgKML+h1KZn1IHXyLPGCWWy1VBHCjalQN7PIYyJ1BSCh8K0ZvH+WoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+4Tr51MfxPSwWc2teNk1r5oEANOv47DQ//9Fr5IypA=;
 b=ML8MRp0Y5tPr721ZAfWA6pV1gRiTIjRDldqbMR7SAfu/kF9G23rmD2UrJaYKbOXJMDbkkoGrPxWxl4Sbw3hqDSPnsZU0MGpoMwTyqTxRg+1Ya3/Qiyq3bkM4vNXDFqeIdFQnEtSo8JpugGmhoTuz8JQ+gYwUQtkQWRF1nG1smYczWVsa+HOe7Xd3apEJ4d27gxX18awIdN2Iy73e1gEXIEb/7JbrZILIDuK1NRZUt7t6tycIbXDjramBcZ5PssEZk+syZDFUee0cwd2NaAVu4CXMEEyi4t/xMsLBO29XJf+pw95Ney3dQyafBQ+QmMyagxoicEOc/vrChSABhFvHRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+4Tr51MfxPSwWc2teNk1r5oEANOv47DQ//9Fr5IypA=;
 b=zwO1Pbhny2gUuD/7QEOUMtyBuhhv+ZwCxzazCCKtsdXWEjY3+ccfGWL6JMFlXZ+tO5ibqd0hCDDiVVUITRxJm98IbtQqElGUb7hyEr/OioKaXVg05zbCnke4Xn+zQDXS4g7AjIK9ixRmSH1jn0xSEoxs4iRX5shtWqEntLEoYWnV/3Ih+qY66DKepko2s/hUlHoM7jeTziW4yvC5H2qyFzbFhbUHyh/zopx+uUN3wrL+p5P0H6SzgR3fhF/4Eav7Uac0Z8YDHRaImomOHmf5PCCnZS0pC/p2tKtKz9TaZcDlY2/ml6VVhEnkWeXbNuLyvUWZK58D2Hh/fYkexvq8cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by PA4PR03MB6910.eurprd03.prod.outlook.com (2603:10a6:102:e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 17:09:09 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2b95:1fe4:5d8f:22fb]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2b95:1fe4:5d8f:22fb%6]) with mapi id 15.20.5880.019; Fri, 16 Dec 2022
 17:09:09 +0000
Message-ID: <68562aca-5256-9e4b-bcd5-983e43408a7d@seco.com>
Date:   Fri, 16 Dec 2022 12:08:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 0/2] drm: Add component_match_add_of and convert users of
 drm_of_component_match_add
Content-Language: en-US
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
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
References: <20221103182222.2247724-1-sean.anderson@seco.com>
From:   Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20221103182222.2247724-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::26) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|PA4PR03MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: af732301-cfc7-4bd6-4a64-08dadf883ed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dXVxBvj4ZaJElwLzCN8kHn2ebxRzHh3Gf63CAtngtlPvjwfc2UwnxYIu8RSAA9UwqyGOFvXys/Kh1HL8kUFOW9007tLpJdMK0ZWlbFigIZxbI6noBiIixOIZX7bPif2JRXOw5s0jTYF5e/+Ig1diIpJmyzB1FyuGRcBzO1hoCd5N4O+tsvHvAMBQEJ08MMWkdMMwfu266sBpe746IU+or+qjQiSmKwk7VkA3e5JgIPr77OFyYVmZTQhcTc+KoLXdw2DnBtUPdYhW+1Zp/iVS5fRmf/+6PPx2+h3WNGxBzF6BWHX3SgkeAaqWdbIa/V6jSPLkdxWYkmtYCSJObifs1mWKfGhArWozUFYOpjDMx2jQGwzkGoeJJoD/qfAun5iqwtWHNwpKmkLbvhqbI64ndOpRIvh8KATYLCpqhjWXJUV0N/NbI2XUvazt1rrnCefbrf1qEqhv7kLBH/LdeG0D69Q32t8Ef4GGOwe28a+cxWRDRXos3azu1CfJiK5nby5ObG56zMTY3FZiXsGsDckB6DLPv1oiKjurlsMBEhIsrlMOYQignIiOd4PCiegLHybRhWnyHIp5XhRF5cGJvvrKlf/Ws2b6AZbqAy4qBPPdHtuABbP5jIPOLJ5wrR2WN8TfZjTlGgFoLoIkt3soqk/R5XBR3APL9r6axqft/Mk6sAEtZVOny5DCIXVu4QQ4Tcrk8Ig8DzsC273xTFekQKcoYT3cR6CQCEGESHU23rXAnHq0Xh3/BqAm1r55CGEWgoPAQ645qEhg5NA843/ES/icVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(346002)(376002)(366004)(136003)(396003)(451199015)(52116002)(6512007)(2616005)(38100700002)(53546011)(38350700002)(6506007)(36756003)(83380400001)(6666004)(6486002)(186003)(478600001)(8936002)(26005)(31686004)(41300700001)(316002)(54906003)(110136005)(2906002)(86362001)(66946007)(66556008)(8676002)(66476007)(4326008)(7366002)(7416002)(31696002)(7406005)(5660300002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEJNRitKck1jeWxnU2crVFIyTEozVExjZ1krVnhBSktuY1N4ZVJZWXg1V2Vs?=
 =?utf-8?B?WGlXc3FOOGUrNS9DY0ZJZW9rYmFhWlBPWjVOMm1DeVlhNkVDZEdsVzhTcFJU?=
 =?utf-8?B?K0lnZHg1d0dYMGdseDNiWFJpZHFJOVpVSE9mYWdRbis4cGpWdWNza3dhNXdQ?=
 =?utf-8?B?S3RsUkdhVnU3Q1N0c25pV3psSFp3YWM4NDJpd0NlSmxzVy9QU1J0U3RZK0hz?=
 =?utf-8?B?ckpTQXd6VmUrNGI2Rlo4WnlaNUFGNThpeUpUUHB6UUFvbDhVdG0rNVBDdG84?=
 =?utf-8?B?aklESEJZT2FlbXd0MmwwZlBzdW5GTTVNWVdIaHUweWdPa2Foa3ZHWUYxL0g4?=
 =?utf-8?B?RlNpMWdubmVlcG9yYmZtS3ZFZGpLTkNidVc5ejNBdnBLNzRJdlltQkVQWGZV?=
 =?utf-8?B?UitGRzRKUmdIMlZUZm9VZlIydFlDNkNoZ1MzbVI4MWNwRGlmQW9MbnR5enl2?=
 =?utf-8?B?V0tydnZKL0JmM25GaGh3WWgvdDRITGQ5RzU3NWU4dVZ2NFZaejM5clZmQ3JI?=
 =?utf-8?B?WXJTRkxXMk9VdUdCR2VwKy9qQzJNS1dOWldPK2FxOERlVC9HT3Ntd3FiTGZV?=
 =?utf-8?B?bWFtNzJ5Tk5pcDAzVWU1eElObHdmdlE2c2ZHNjRmak9BeEd6aFlpckgxa2VX?=
 =?utf-8?B?Tk9CelVlYWxKMFBZMjIyem9qN21XRUZQbzFsUXFwNFQvRXJjRllUSmI3UEhG?=
 =?utf-8?B?T21vYXNkSDA1ZldUQkZZdnZwSEtJODFyZUh4NzkzK2UvMm5SYThFcWhpTmNu?=
 =?utf-8?B?OUwzRlY1a3h4V1BZdkF5RnQ1YzgzS21qSnFkNmVRY1lsNU5NSi9Uc3NMTWZE?=
 =?utf-8?B?SW9abWlFbklSZkF2VjF2b0xrdno2MWRiUzJJVFdsa1VsVUJzUm1OT2FwVjhS?=
 =?utf-8?B?cC82cE1MbFR3UXZFL1RpSEZhRUNQTWhLa0ZQaG9CQU43SWw4VDRFZ1Rta2lk?=
 =?utf-8?B?TXovOGZITWE2VVhuOUFodFJBOWFMa2ttMERjTG91SDlsRk90aGNuc053QkFl?=
 =?utf-8?B?MlZ2ZHpIbzNBZ2ZJd0lid3d4N1pncjRHbDlpN3ZVbnJzc0tOVlZ0M1N1eWdq?=
 =?utf-8?B?WS9qQTlOMWpzcXJmZDMvamVqNkVpenpHS2x0NkRMeEdYNjh0Q0ZHdDFsRXdi?=
 =?utf-8?B?c3VSSEJUZERlT09BZitZbFI1eE4vcE1OcVh5U2poS2lhdHYwYzlBU1RwYVR3?=
 =?utf-8?B?TXFIc2dDUGN1U01hSkkxNkNHYWRKZ2VtdklaeEhUVk1LVVh6SnE2eHRiVVRL?=
 =?utf-8?B?Q1o0TENOWE9NK29RSFhwWVpDNnNPM1NicVRjZTR4Z01SR1RhTXN4TTJtZjBP?=
 =?utf-8?B?UE9TVEpOZnMwc1huME5TaUlIbVV5OXE0cUhMRDl3eVFyVFlVeDVoVzI5Unk5?=
 =?utf-8?B?QmJkS3JpZmhWcUhNSDFMOGo1Qk9tdy9lYXluMlZpaThKQkZDc25xMWtJNlZz?=
 =?utf-8?B?Qm9NaXJXL3c4WVNWOC9FK0NWZHpISi9LVWZkUjZnU0EzV0M1bGpiMTVCc0hB?=
 =?utf-8?B?cWFPNjVidGtzUFRQeEl5TkptRnhrNFdyRFgrTWpRWUVwRThtbElNMXJzY2xW?=
 =?utf-8?B?YlRNT0lEeU9veHNKOU5IM1RYTU9SajFhbEZwaEQvUkx5TUFDdDR5ZGtHbE1j?=
 =?utf-8?B?NzBJcTkrVEp5REZ4WUlKc1VSUitRZzZEL1JHUWgyendmaEN0NDRLWUY5aWNw?=
 =?utf-8?B?TzhkU2QyY3AxQjFaWGwrWTkycy9YV05xd1dDbng1Y3VMamFCYXJoM3hEQThq?=
 =?utf-8?B?SDBRdDltR2NhRC9haEpiZjZOMmhBRDNkbmkzMjRyT2d0aFI0ZHkyTUlsMFZu?=
 =?utf-8?B?d0h4TnlLWHZ0ZHVvcFBMdGpZOEsxdHNsK2lhTmFYditQZk5UUkNMWitvcGdZ?=
 =?utf-8?B?aVIwdnM4dHIxV3NxcThIc2N2U0puTi9sWjlla0FTaFl3UmcvcVcycS9XTjl3?=
 =?utf-8?B?S0ZzNlRTcTFEVXQxTnRxd0lMbmp5a3RQYUwzSG9Nd3Y4U1RYeGl2Y0RlMHpa?=
 =?utf-8?B?U1NkaFZDbjFQVTNyQ2xRSE5VeXFvL1dkNXJLRndVM0orUVlSNE9nMHFaSmhL?=
 =?utf-8?B?VUluSjY3ZURLaFhUM3hUYUdDd0ZUVHc0cnN6YXAvck41R0cxT0hteGQ4dm56?=
 =?utf-8?B?ckRJTzJPRHpJTWZ4ZXQ4VzdrbHk3RUNEcnRLRnV1ZExSMHloamZJYkpWckEr?=
 =?utf-8?B?bHc9PQ==?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af732301-cfc7-4bd6-4a64-08dadf883ed3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB8847.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 17:09:09.2363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XyLPJ+VUHXumX7wRoSdZtsZYS2a5W53pTd0sK15a2TVN29ad0Wrny9rpJBVKwRUz1Bz7e+GRhc0SaihjuyVXKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6910
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/22 14:22, Sean Anderson wrote:
> This series adds a new function component_match_add_of to simplify the
> common case of calling component_match_add_release with
> component_release_of and component_compare_of. There is already
> drm_of_component_match_add, which allows for a custom compare function.
> However, all existing users just use component_compare_of (or an
> equivalent).
> 
> I can split the second commit up if that is easier to review.
> 
> 
> Sean Anderson (2):
>   component: Add helper for device nodes
>   drm: Convert users of drm_of_component_match_add to
>     component_match_add_of
> 
>  .../gpu/drm/arm/display/komeda/komeda_drv.c   |  6 ++--
>  drivers/gpu/drm/arm/hdlcd_drv.c               |  9 +-----
>  drivers/gpu/drm/arm/malidp_drv.c              | 11 +------
>  drivers/gpu/drm/armada/armada_drv.c           | 10 ++++---
>  drivers/gpu/drm/drm_of.c                      | 29 +++----------------
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c         |  4 +--
>  .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   |  3 +-
>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c     |  3 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  4 +--
>  drivers/gpu/drm/msm/msm_drv.c                 | 14 ++++-----
>  drivers/gpu/drm/sti/sti_drv.c                 |  3 +-
>  drivers/gpu/drm/sun4i/sun4i_drv.c             |  3 +-
>  drivers/gpu/drm/tilcdc/tilcdc_external.c      | 10 ++-----
>  drivers/iommu/mtk_iommu.c                     |  3 +-
>  drivers/iommu/mtk_iommu_v1.c                  |  3 +-
>  include/drm/drm_of.h                          | 12 --------
>  include/linux/component.h                     |  9 ++++++
>  sound/soc/codecs/wcd938x.c                    |  6 ++--
>  18 files changed, 46 insertions(+), 96 deletions(-)
> 

ping?

Should I send a v2 broken up like Mark suggested?

--Sean
