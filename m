Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FD3693B39
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 00:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjBLX4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 18:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBLX4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 18:56:52 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2111.outbound.protection.outlook.com [40.107.117.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAF9BDEA;
        Sun, 12 Feb 2023 15:56:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEkJpRCWokBcH/D8M72gdeDNWdLpGq2ESdEjisNo1aJUDsjkY1WjiZq0zosSGKD7j4qGBZrdiyf+ae4Lwoqbu+fLcquN0DmE2xEHAuHZ+8RNeaGw163HcDq2VjXgu3unesidNvEhDk5PMpM+HmxAM2T6iJ71/S5HfCNXxTyplnFujS0wbCI5NFtni+q2QDFt7tDERKNGmS6UhkTEn7vviMgZqBpMRNeUdo1svu/KYMNRLxtfD6/WrjpiK4nEN4AvrPELoclODgIhJPwS2YXp9VhKdbfrYfPr+a1+hHe1PdqqZtLYs5wsQPD9lQ3ewK3SMVDvsDh07GHxZdxddckzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYZWvWzi/zFgx5rBZQmvszSPaJinqB8K7fRgaOK1zr8=;
 b=OhTaZs6KuNoy/huDQ+hCX9quLFmape+8AOGuNtVoUhJsh27KoqGV7dERMADpZZIm1DWL4HnIN8FRb5kVCQ2FRVUnByquD6c1qvqXPp4PYl0UV/6MiDwDe3nVnFdYV+uxaHneOGibGhhYVeSyJCZUr0CtmbrZrFweXeJlcK18dA3iVVEkCcPJrKvuAkQeyfMdSshk+C/vDkxPNfbd1K/aDRA5m8TP4vOCoTi9PF5FK54jNUkoR68KukXntvWgqzfGscNTTUjqb7Dw49mtx5Tdybm7ntBD9xlpxycY4lxMcCAN9EtRqll2nYnlbXJwKh7YoGvcL7OQtlAUpNXyQ6uFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYZWvWzi/zFgx5rBZQmvszSPaJinqB8K7fRgaOK1zr8=;
 b=e/iJMCExm3yA5Z9uYORIGXzslcGumyNhWzBHmTLBWUZ55awJOcRDYG+TIcIv2kyoTDMDmTmx8GBZkh1ElhZ/uVh1mFgUqRJnihObkdAEHBScylNrZLJAIzQaF1XqeSLlCgjreFUg6R1+lmrZQlW/XoTnB9PQNB74UWfQ6Llr5Xw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com (2603:1096:604:194::10)
 by TY3PR01MB9795.jpnprd01.prod.outlook.com (2603:1096:400:22f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Sun, 12 Feb
 2023 23:56:46 +0000
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::4b75:8d8e:d89a:7860]) by OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::4b75:8d8e:d89a:7860%2]) with mapi id 15.20.6086.024; Sun, 12 Feb 2023
 23:56:46 +0000
Message-ID: <87lel2phdu.wl-kuninori.morimoto.gx@renesas.com>
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        oder_chiou@realtek.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/2] ASoC: rt5640: Update MCLK rate in set_sysclk()
In-Reply-To: <4a45f084-7d33-59d2-8ef9-cb95e29866a3@nvidia.com>
References: <1675953417-8686-1-git-send-email-spujar@nvidia.com>
        <1675953417-8686-2-git-send-email-spujar@nvidia.com>
        <87lel61k3h.wl-kuninori.morimoto.gx@renesas.com>
        <4a45f084-7d33-59d2-8ef9-cb95e29866a3@nvidia.com>
User-Agent: Wanderlust/2.15.9 Emacs/26.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date:   Sun, 12 Feb 2023 23:56:46 +0000
X-ClientProxiedBy: TYCP286CA0047.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::18) To OS3PR01MB8426.jpnprd01.prod.outlook.com
 (2603:1096:604:194::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB8426:EE_|TY3PR01MB9795:EE_
X-MS-Office365-Filtering-Correlation-Id: 63db1afa-fc8d-49f6-daaa-08db0d54cc7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6iu8hnH4JAaVy4VlVQrbMuuWwGgD/Kzi42rckJBLLQLucb7XhPLuHI6VKUiQYyAufIJMDmRXq45a1cxe42iaZJViVFUPU7ZGe6XQ5EYv0mITzIHYb5v1DvTgvn8VQilKTCOJ7FzC0hqEVG30PTcsZ9j5bFj3IU8rvCmfmvlCD5cloW28HR6s9JBSofFYY/lkT/nSqZ/B3uVo+H595OGSrFQ36ROzO777iv8nJsQ8mGhhzfFC9vglayvOE/xsOjT8ROLuwFRdiQNA4M94zzn0Zw9I+2r/iR7hx0J4SuuWQUZPY9FOaFLY1UzLEdOvFn4xtWHpxcVLV6P7ZocLPuoqh14Mx2W/IyzM0eVTFrvVjSHQVW7YECwJuyBM7Cw6XNk+mE5UAYSDNLC51ZAk7M7jAsOxvz8lx06X6wTG7rKyK2exldgPrSW59i7ivBdJW6xIMEDegBbYrbHUeJnodwgKfB5G7t6joLWH60xSy4mM2YQCM8N6BTAtg1UIDmzqGYT/d6OcFYcLwgFf/C6sEJhobUnn1Hhv+Eut/Jixpq4S5qcj6XdRfeC2A1xZLPzPNGVq3t7W2gEJEaMoGaM2upDfxk9QePkeeoh+JQnAhg0v/gTW6o2IWNj40cPp8LkmS749miqE38rGurLbfu2YBKf7flUU9b8vDrJX4fiqfaRJTQ8X7iJ1Gh5ySg2S9b/zbs+0oMYbIfNpq6Iv/N1cNrPvQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8426.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199018)(7416002)(5660300002)(83380400001)(41300700001)(8936002)(38100700002)(38350700002)(86362001)(36756003)(15650500001)(2906002)(316002)(6506007)(6512007)(26005)(52116002)(186003)(6916009)(4326008)(478600001)(2616005)(6486002)(66476007)(8676002)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ms0HnH7KdWTyxXGZjI5QdbESoF0kjgyndaFbJFJ8fXW1E+iZ0SV3Xv/Qssmj?=
 =?us-ascii?Q?jlIAEB60S7sX+Q8vCY/MPmsqgXVU2RZUhpvA7Z5UbagyIDxHJcHgPHGbxFtR?=
 =?us-ascii?Q?rUs51NVj1N29Zwt14QlKI1K4Ey9/5d70ycCOm8/9uYqPE3C2ESFrYK8LUzAC?=
 =?us-ascii?Q?1XGtMxe1p+Jq2nVqX9Np/Qsp2Gp4Tuf0P6f0DFXSgK/5aPPC0PO0VeYIeifP?=
 =?us-ascii?Q?cgkbAGlbm4tg3viuRiXEy5/EXhSVVByUAhhKWiZI67r5FKnbCJApx8ItP1+E?=
 =?us-ascii?Q?DsNMhAwaSkvrJvzqNzxBR44+vs2yxKzXSU/xpog3J4uboDFfSL24E8JXHmqz?=
 =?us-ascii?Q?FoIzk9ynTNp3Ea3yT1Etu5Z6Uyylc64zb0GaAAd544HY3tfhaT8YPBhOmYc5?=
 =?us-ascii?Q?yQLzQxNoSb0axilC/YSKogZRLyKuyaGhFpUQstJvBY/iFml0uT70730+gY4h?=
 =?us-ascii?Q?i9Ek0wen6CWzY+5s1B9tzqEojMuXjinYcDyCVcO7uk8PrjSBrcdY1kLYia5v?=
 =?us-ascii?Q?BGf1qsWVo5vCXUuzEoouvc5F3Sdbaz5NVVlNG87DjGPpxGPVDSZqLxvh/P+T?=
 =?us-ascii?Q?vKOdjAmcgl1akYni4c1cO9yGQAlJN++ZiTEQ0OglRwLTjXe1rtVkaCokc2m/?=
 =?us-ascii?Q?tlA+M0MThHaB5Sl1dCkVsskBbYevNbcfa3Ded+pA8VC4xLOeg4Ijq7PT3tXm?=
 =?us-ascii?Q?Zro0RZ9gMknKHQAscUMUHb6aJl2VG8V3o+BKyz1Q6UBRTocrwcobFSB6Bubn?=
 =?us-ascii?Q?4mECJIAm91LgcXBdOlL96cSsFZBEmi8ZckP/L2A89Ss7k5HasPCqnqd/QuQA?=
 =?us-ascii?Q?xFgH11TzfMKyW4Qab+DAB22uGJseriy4wHjy6GU9SrkgxmY9wDQGcpQrBHTM?=
 =?us-ascii?Q?3XMzHxaEUqFWmSjwZ3ImvmLjhkBXcu9Gee8IEJS9aBqZ53HgPO2Hqh2+ezpZ?=
 =?us-ascii?Q?he/b34ZIO9xA0gTRezuFXVors09cGLYimIRSpENScrM9Hvv87UzmGLhNiSph?=
 =?us-ascii?Q?TZdEFgU2sq9wiBf19z9zGrnfy6ypPj5Zs9fK9gZG+MDCoRr8tG+hsqF0d0zp?=
 =?us-ascii?Q?OWrXZCT3+L6Ds+4T8ph3/fX0o/dWLkznj/2IPiz7irsbfF1YqUiVh6sMBmp3?=
 =?us-ascii?Q?ADAEnvTcII83NGuw55IHbpPONE6AovnjGpQYNoSSlNYktcA+CmvZk+LAPqqi?=
 =?us-ascii?Q?HsJtBbKkwdF5sTcff36jzDaIOpIj7MvzPbGOyjk8QW+Kd00ezpDTm9k9UT2H?=
 =?us-ascii?Q?ZcWoLF1jwbmxEwuFyTP1lmza63Z76W/6iKzqE7KlK7yuC+ADIb6UVwHPMEQu?=
 =?us-ascii?Q?CL5AK4T2jG2XsDtDumeePZYtIQMUI2ytV6vQQ6Nder4Cy6DyMf7OJd5uHtID?=
 =?us-ascii?Q?N+88a5bMRE5EPcqAF3ft9/n6CE5jqJYQFKp72sH0/ODIdMazJqz5UKh8SFI/?=
 =?us-ascii?Q?kF8rrJKmWCcfR6OXEDhVeF7zOTi5qmxM5KHZoLJvjonB7mOGnx3jh/IY4DUQ?=
 =?us-ascii?Q?Rj5oWPLwzZDvVXLjDQivOUbmCrDJKajsAnYJ5HKZ5lQfJqqSx1zSqoSO1m6q?=
 =?us-ascii?Q?WCsgVCTXv730msjKbup4Qe0LC8EuyjCU/Zwo74obpelcLML5pCjREFDHft7A?=
 =?us-ascii?Q?gTDlIb3N/AypTxuNGwBTOsc=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63db1afa-fc8d-49f6-daaa-08db0d54cc7a
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8426.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 23:56:46.3011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bb9ftjADzuL3U8HQ3RWYTBn5gJC46Fdup6FL+UeSJUEpIaSn8gTGktyRUzBbfuZDW4e93Yc1uW0o7hPiKeWpwM3I3j33GxRaqi80x2L0JJ/IsmpjCcQuUPXnxKYevHHJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9795
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Sameer

> > Simple-card/audio-graph-card both are using asoc_simple_hw_params,
> > and it calls clk_set_rate() for Codec/CPU if it has mclk.
> > But am I misunderstanding ?
> > If it was simple-card-utils side miss, I'm happy to fix it.
> 
> The simple-card-utils driver does not populate the clock handle whenever 
> the MCLK clock is parsed from CODEC device node. So 
> asoc_simple_set_clk_rate() will not update the rate and clock 
> enable/disable won't happen either.Initially I had tried to fix this in 
> the simple-card-utils itself and it did break few things on other HW.
> Please see [0] for relevant discussion.
> 
> Later [1] was pushed to address the issue I was facing that time.
> 
> In summary, the suggestion was, clock property should be associated with 
> only devices and device driver should own up the clock handling for it. 
> The machine driver can just pass the required configuration for it.

Thank you for explanation about your issue,
I think I could understand it.

Thank you for your help !!

Best regards
---
Kuninori Morimoto
