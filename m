Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01F8745B4A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjGCLiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjGCLhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:37:55 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2091.outbound.protection.outlook.com [40.107.255.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4260DE49;
        Mon,  3 Jul 2023 04:37:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtrHmJDY/+9c6++d6tSrXd+58duE/V7Mo8qfA9lbP0WUs2bLgQ1aJnVWPzfexfOHSkMlXqXoEzDbwM75cA3NFzgAGGN2fLSGSSLSmUpsclvOgS0hqLLkk+EYkbftwc7dcRWNReXo5jB+cO855pgsqqb7YYA6GMRo0GiyEtmlvuCN3mOpBjK6CVYnnkjwFJZ6zPgKWw0jht5Cw50GiSqCPWSk7xvvOvRuOVB3TrvLT/WnAKgY5XRk1zFOmqKstAd3guM25+CfptC6MVgeTgmqdrGG1SXHlcZ2h4YMeH6wWyChhhrr30fo+NzMEAS6VNAMfAG2B9wAt4k7rWNwRYW/SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEW0yzvbqGnP0wo9EGPV1Cj1KlvBhubKts2BCJ7+8LY=;
 b=K/s6ln1mhEQU6qsP5qrY7Bm41wdd1ZqlNHB1t5vCqnnMdD+2+70hgxm40ji3DuDjd+OOOtvzVVYMHKSF16rVGKmJklEmALa2463PftEe4dqbw0Tg1PF3jV3d5uwyQLX1A5cyiY63WPpS3axWoqxY25vmIdy7PuFIpf+dBxta3ITV6Xn8XmevkQlM6D+JdGkICwaAPFyX6JuCNproJU5a+qVcOMBfQ9Em+wF0lG/t6f3ATc3H30+M556/Occ+lSEw3FB1znFE62F1z+/RJpb69B0ObJKEk3QHRzl3XagjhI7uoDs8a7kIzHdoLBoEtaYUTAwu4eB3C4893dfGzoyE4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEW0yzvbqGnP0wo9EGPV1Cj1KlvBhubKts2BCJ7+8LY=;
 b=pOU2yVZmXOxyvx/LJg2Bn1L1d+7u9QOC5TX8IytombwYhqyLKCbG1TLhvUUi6RYT1/FZdeem4qWBX6Mn6G3+iipo3u7o0RzeiamE6wH88heEauI10UbrivKiREaKBnZcXl/fdQDPW9H4mEb2jZbKhXRgooEzPUXfNJomi7dLcY46aaHWWDtia9F/i6MOChxxXvwpSD1K3JoJ36IRobOMItYVFGzS8p2fMrsM+QZlBLeJ/85jFqAj/mygPRoLhEOAv9+HIXl+prAWtErqN1MSHBlmDbO1bjGKFzW4voOlX2u8wGhZKrOfVKun86r7KhCfciyJMJouApY20ymyA2y0xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6230.apcprd06.prod.outlook.com (2603:1096:101:f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 11:37:42 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 11:37:42 +0000
Message-ID: <1d7a3624-8047-1051-41b8-351c5dec672f@vivo.com>
Date:   Mon, 3 Jul 2023 19:37:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 01/15] genirq/devres: Add error information printing
 for devm_request_threaded_irq()
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, rafael@kernel.org,
        amitk@kernel.org, alexandre.torgue@foss.st.com,
        linux-tegra@vger.kernel.org, thierry.reding@gmail.com,
        jernej.skrabec@gmail.com, miquel.raynal@bootlin.com,
        srinivas.pandruvada@linux.intel.com, festevam@gmail.com,
        linux-stm32@st-md-mailman.stormreply.com, bchihi@baylibre.com,
        florian.fainelli@broadcom.com, daniel.lezcano@linaro.org,
        chi.minghao@zte.com.cn, jonathanh@nvidia.com,
        linux-rockchip@lists.infradead.org, agross@kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-imx@nxp.com,
        wenst@chromium.org, rui.zhang@intel.com, thara.gopinath@gmail.com,
        kernel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, s.hauer@pengutronix.de,
        linux-mediatek@lists.infradead.org, mmayer@broadcom.com,
        matthias.bgg@gmail.com, DLG-Adam.Ward.opensource@dm.renesas.com,
        johan+linaro@kernel.org, angelogioacchino.delregno@collabora.com,
        linux-arm-kernel@lists.infradead.org,
        niklas.soderlund+renesas@ragnatech.se, andersson@kernel.org,
        linux-kernel@vger.kernel.org, shangxiaojing@huawei.com,
        konrad.dybcio@linaro.org, mcoquelin.stm32@gmail.com,
        shawnguo@kernel.org
References: <20230627101215.58798-1-frank.li@vivo.com>
 <20230627110025.vgtplc6nluiiuvoh@pengutronix.de> <87h6qpyzkd.ffs@tglx>
 <690b12b7-5586-6ade-de83-99f463bc8397@vivo.com>
 <20230703095337.27bhco7nkqtxr4me@pengutronix.de>
From:   Yangtao Li <frank.li@vivo.com>
In-Reply-To: <20230703095337.27bhco7nkqtxr4me@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: d9382b72-de61-4fbf-8c41-08db7bb9e97c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q2fpAyh8rEmaVD9Th9naeN5/iwn2b0ULWMRBkeFvcNKAZMyce6FCIrYGQibYouUG+ZE97qusbOn8zJw9qUSl9Rbj8mpQTXOnEVeiIJq73HCsmVT2lNNiWzv3PyNdPVIf61rRs1HJ/lZU8U8m4W5jeWaI7YHpjiYFs9eqkzZbZXjQZodOU4ST2gNTmIWGarRVcunJhshpf3YYcamA74coYx0dMuIgVXaY3bMtU5gJ0LmBLB5j9FvNlfaMjtEhXcJowcm/ztozV/VDOge5lopz9LYPzxc+/Z9oVVqamhS5k/RdVCqAQRVLuQnLf4S9EP+EK5FNa3pZjsmMz65ui+l/8boP07qwUEbh5C6fw1jX1Py0D3oH4L97xW14Rwgj2v4kcsU5JKrgFQMFsfKtu40S2BaXAeft+7SIk/3F5RGzSpLNeVsietJO4N2aQtVwr+shmYrMnR0kmRFl68bw+ZqFc6UWoSeQnvIKanqiAQ9zB0z+GvLCX+i2gMkUVWcvavCxIRodLgjND0XNNHM521t3/8DotYGlKy3ieiwvchkZa5Th3D9gxIkquwFEYGn2WcMYTU2s9+4O334H6/yZc57Lb+SyusypUKh6eX/ow3WdXCLwu97ws9r40T2gZgH6ZG0l9a3SIuTa9wSIk/C9HN/KlnB56JAV6SkSSQViSMANee4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(41300700001)(6486002)(4744005)(38100700002)(6666004)(52116002)(38350700002)(2616005)(6506007)(26005)(186003)(53546011)(966005)(6512007)(31696002)(86362001)(478600001)(316002)(36756003)(2906002)(66476007)(6916009)(4326008)(66556008)(66946007)(8936002)(8676002)(31686004)(7406005)(7416002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXBzRDVvVW9TUjJGdkRZUXhnVDExNHUzV2NwSFJuYjdObGY0cDB2S2ZKenls?=
 =?utf-8?B?ZHU3NThzRCtzb3JGUE9oZ2hNdlVISGR5c2VUb0FielNkSHJWTHo5OWZGZGFn?=
 =?utf-8?B?ajhqS3hLdmVXandzWFlXOFY5dHVXK0FNVzV6MWRBbDcwbGl3RUhJVWF2T0hQ?=
 =?utf-8?B?SW0yY3d3YzBhM0FUTktSSGtwRFFGZ1psa2JlNGkxOVExSDNlYW5pTFFOTkZn?=
 =?utf-8?B?VUJMaDhGdkdwUFBGc0c5OFRCbmxXOFpVU280TnkxTzFuYi9EaFp5OU5VeG9C?=
 =?utf-8?B?TFJZci94NXZUZGF1ZXZYT3kwbDd5WW10N3htTnlvbUd0ZU1EY2JYai95RXJL?=
 =?utf-8?B?UWJOTE1WSmg4R2pEN2FNVFd5OEJsM1JrOFlyQitQWXp1RDdXY0oya1cwLzRE?=
 =?utf-8?B?cE1EQVNma1k3a21hMGMvZk95NnpTMkNmUlVIVmxuaHhZTlhUMGFNelVTRUlV?=
 =?utf-8?B?NWxMT2JMQUI4REJlTkt4NDdKS0hESTh1dGllamJnbE1NWnlHTkFZa0h0UjhC?=
 =?utf-8?B?d0ZSMW1yMjhZdXVBeFU4YzR1ZitHUUVGQzYwKzluaEZlVDR1eWptM3Q5VVd5?=
 =?utf-8?B?ZVkwdUZPVnJpenJXRnhHZlZ1eERhU3M0OTIwczlhSEl1eExPeHJWS0lyNEE2?=
 =?utf-8?B?Y3hReEhDUjZiUnJRTE5OWnlVQmhoVklKYURjaldmeEF1azk1RmZJRU4zcVd6?=
 =?utf-8?B?NVU1YzBHdzNqRlBGR3RlZ0tVMHlRTWhJOWt3L2JVdS9UZ2NxQzcremk4M3JJ?=
 =?utf-8?B?ODhJaDQwTENGd0lYOFZFMGxWbzYwMzhxL2U1cEhMTXFWbDNzb0Z1bzV3S2cv?=
 =?utf-8?B?TUxUaVh2cXRHUmF4MHZGLzNuNi9ReStHQVM3OFEzL3JQaGF3eFhoZFVOZy9M?=
 =?utf-8?B?SnJmZjErYW1HM0MxSXVyRlp6dDBOMGorMWlweFhzS2lST0hGbGxoSXRRQkZq?=
 =?utf-8?B?aDcxWlJ2YWJZSTYvL0lJRHU1RnY4V0FTV3NmUmxCMCt5SkgzV1NMc1d6Z1RU?=
 =?utf-8?B?aEI5Y0R1Z2k2ckIvLzJxTnVCeit1WXp0bXdva3A1RHkySDBSL0NuY3Z6OGth?=
 =?utf-8?B?MjJUM2VyM2JodzdKMTBJbnBjdUV5VDM0MllwTkhUWEdxenpGdXBsQ0piY0Zl?=
 =?utf-8?B?TnI5Y2I5ZFhPcE9UbTQ4cXRZem5OUFZxRlJRaWdqY0J2UkMxVk1XVlhNSzRa?=
 =?utf-8?B?OC9PblhTMWtFRTQwNHpXbjNDNU9qZHUxczVYU2ZZZ3c4MnN5WjRrek1aZzd4?=
 =?utf-8?B?dmtSU2hOSndYam1hemlKMzNBcXNOWUgzQWQxQmgrR0o0NlRHZzRHVWczQkRt?=
 =?utf-8?B?K2p6RWxXSmhFUU5KZGlPaWRsb0xHOHRZc25BVFhRYjZSTTcwQ2RPL1VPMm1X?=
 =?utf-8?B?WWswazFVQ0JYTXZ3NFg4NjN3Qk0rNkZuQ0o2amt2V0ZsQ2YwRktRSHEyeXg0?=
 =?utf-8?B?RlpDdlgrV2hHbUVPNC93RitHalJtOE1JTWc0NVdpWm40cjVHSDBpRTIyWDV3?=
 =?utf-8?B?ZVNGb3IzdFBleTVOb213YjR6YnRORE0zalZ6STk5bzI2VTdMdmdqYjhxeGdY?=
 =?utf-8?B?eTA1NkFQVjNNaExXYkdDVy9CY1JrMGkzRFVvMnFoYzBoNEl3V3ZSWnRuWVU1?=
 =?utf-8?B?dmdyYlBSaFpsU2JkNS9heTY2Zjd5KzhPdVVETmt1L3o4UkFTVE5KaXU0R2FG?=
 =?utf-8?B?azNkOXpHQWhtamhpcmxyeHR0d1Q5KzNINnltTXdZNGFzZi84bmZhYWxZSG83?=
 =?utf-8?B?MmJKdGtiMkVPODg5b1dJZkl5RWJ4Q2FsOThueWpJS2xYMDY0TjdsdFFaWjZU?=
 =?utf-8?B?ckRzNEV2QWJHSCtFQXpxTWN1VmUycXc1QVorek5ZbXZvVHNQUmswcTFlVkwv?=
 =?utf-8?B?WEtveUV0SlA5ZXk3UXdmYTVhdDd6T1MzOVVTdnorSWpVQ0ptUVdMbXIvWEEr?=
 =?utf-8?B?VXZPV25CdFo2aVR6Qk4wN0pKY3RnNDgzYWFkem5HUit6VzJMSEI2WGJjemJw?=
 =?utf-8?B?T05Ndkswa09SKzlsWk1Hemx6TzB5TVBlc0c1N2MwQ3B0VUVCTEpaRGpEajJl?=
 =?utf-8?B?ZnVrRDlzaVdnM0p6ZnprMzYwcDZ5OVVPRFkzZ3VxdWs3RzVOWXdKRXhhQVlz?=
 =?utf-8?Q?eRJ1lRSyI2/wk/+aX/4MrjHhD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9382b72-de61-4fbf-8c41-08db7bb9e97c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 11:37:42.1808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfHzR2MI7f9s1Xukcn5bOnNvyVM05mKA8D8eeEJAiku/M3fMzPPFK97xTgkRA/H2rh0kEGh2/ml5jbPbD7YCFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6230
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On 2023/7/3 17:53, Uwe Kleine-König wrote:
> Hello,
>
> On Mon, Jul 03, 2023 at 05:13:29PM +0800, Yangtao Li wrote:
>> [...] v3 has been sent.
> Please make sure that you send a v3 patch series (at least) to the
> people who gave you feedback for v2. If you skip people who had general
> concerns about the whole series, this might help you in the short run
> because they might miss to also criticise v3, but in the long run it
> might result in a loss of trust in you.


Sorry, I'm a little busy. I just added you and Krzysztof Kozlowski in v3.

If others are interested in the follow-up series, please refer to the 
following link:


https://lore.kernel.org/lkml/20230703090455.62101-1-frank.li@vivo.com/


Thx,

Yangtao


>
> Best regards
> Uwe
>
