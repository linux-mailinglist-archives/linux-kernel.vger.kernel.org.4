Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70ED8721B41
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 02:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjFEAgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 20:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjFEAgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 20:36:06 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2110.outbound.protection.outlook.com [40.107.114.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04487CD;
        Sun,  4 Jun 2023 17:36:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsBrub58ea3GmKE06vw7agLiJz5cLJ6I9AI/PhZV/Ex64Jj7FORRIG7dU5E1Jexiko4Uv7N9N4DLTrk0bHYBF07wgbWb2nK75s38Ro5HdOrzmE45VLg3EOhXe6lFlgENuoVNrD9g2prnyeVBxd4ZDFQ5JNVPKWb6lCH8OwSCjxCEF5HjczuGwo85rdNGPTxlLj1WJtDkhU5lC9N8NgFvKJKag8JT6q75d1AKHqCX6gnB5xE8NxycHVLhDdNcLB2x9E7DB794Qze7B8MhI5noW+DgcivThrKxslRbjY6sd5RvXk2T7dKf48EqFOyUkM0Sw2oUAj08Zop27bYHiJvOnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4yBuLMiY8K9kzak5NOKSyfYsnUOeSYAqiIAITcfWYw=;
 b=GqXoqlXEqYfiKWQZQrz1G6X/AIfOva5T/567iSDSsyStTRkMbbBVXYLTVNQbN9w0qCm6zHd2t//RDUpr/BAAyvQnQH87gcYGZB3M1np9Kicj4nzPaAqEIWh1HVSu2JIGiguIefUjcNLuUubR0D0whIWG/e0fD3iGa7uMcz0kdnkWNq0upgkak9TD8WQzfnWSh7fHi9jMohrOHs0fLS79jX2ATK0veLN47PWYa92v6J5mZhaE0Nn/0Vexestpqk2OauFAcgzIOngrsEZ658R4a1cMKRx+kpbyWumtDJb74WihA6qqvHQd889l7v6d8UHKj1a8k7slshgFnPCyHHu7GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4yBuLMiY8K9kzak5NOKSyfYsnUOeSYAqiIAITcfWYw=;
 b=Mkc+i42XwUsDXAKR9ptdn2DCNnORfuLRvAdOcnNtb2/+739icFskbrLX2b5Ud0CzB0JtOSS/a84sNDAwhDAZQNtyAQjNWiGL+EwpZw2o8fWyFw0dDgtLhqne7VShnRywHwkJGsP0grjzAY76DqxqWjei6bme+CI1t9ugv6AUmyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com (2603:1096:604:194::10)
 by TYCPR01MB11386.jpnprd01.prod.outlook.com (2603:1096:400:3b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 00:35:56 +0000
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::91e7:a94f:9f75:d840]) by OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::91e7:a94f:9f75:d840%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 00:35:56 +0000
Message-ID: <871qiqiw44.wl-kuninori.morimoto.gx@renesas.com>
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Alvin =?ISO-8859-2?Q?=A9ipraga?= <alvin@pqrs.dk>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Alvin =?ISO-8859-2?Q?=A9ipraga?= <alsi@bang-olufsen.dk>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ASoC: audio-graph-card2: parse symmetric-clock-roles property
In-Reply-To: <20230602090322.1876359-4-alvin@pqrs.dk>
References: <20230602090322.1876359-1-alvin@pqrs.dk>
        <20230602090322.1876359-4-alvin@pqrs.dk>
User-Agent: Wanderlust/2.15.9 Emacs/27.1 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date:   Mon, 5 Jun 2023 00:35:56 +0000
X-ClientProxiedBy: TYCPR01CA0169.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::12) To OS3PR01MB8426.jpnprd01.prod.outlook.com
 (2603:1096:604:194::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB8426:EE_|TYCPR01MB11386:EE_
X-MS-Office365-Filtering-Correlation-Id: 349937df-40e8-411a-e0a7-08db655cd381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 41V2Q22Ll3TOHIXmeJ9lQnyKLpyuvJXi5SqnhPCihC7iYGYWasUraCPiFfWjx31Vt1c3gvQ1bBgaspaAoKf62xM5h7uqZoOIUdv/3ZpA0ILXIws9XOIp3OCohwHdwWmsO+So/tJfOmAR7PvA295AqaMUvD9mreqHvyyI90V7f8yM4QS3yAOneDcPSpcSbKlCY7NyYG5Zx+qSQ96mzLM5Y6dCIvjDjPtZ0KhOQf2AA0NlOfWb3gMJr+V0wa6KjpA9ua91nP/21xQnf57dA+YZyZ0Jhn+xusOg02t/kvhEgP47JBypCu+4sZhP4C7xOoUdTO+4m/fEdvrzlA8//iAIxaiO6V5dWUtmnMm2i6TTmORe2fMJE/e8Zqax+IUbt62IZgggNREihUap3xAqCIQwFemuibiFu6gmuvlMNrZLxwMQk3X9x8oUXxEhGlgwlRkcXldXf7eKNmyN4RBnuAL3U+qlnqc6Mx0IKbfO0NDKjTzmZTvupsUIj8InO+BGBZ1XYcyWxwhWrBgYXskhZBaEVLY8fIFk9L4uaWTx7GQN3uHp/nHIGXtbBtK7PvX8e0F8WSJIAw5jfMssKRCN39jbRW+viVxN2WBLUwV+Bn+jDvUVp/CGA4+rZz/xdiwJSgZK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8426.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199021)(478600001)(4744005)(2906002)(36756003)(6486002)(52116002)(2616005)(83380400001)(6512007)(6506007)(26005)(86362001)(38100700002)(38350700002)(186003)(5660300002)(316002)(7416002)(8676002)(8936002)(66946007)(6916009)(4326008)(66556008)(66476007)(54906003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+CFDqa3RZdcB9IDsfmV4I6LDDxflYTV+4+2GaqH8ULOk5peCqX+U7U8Eg3Ec?=
 =?us-ascii?Q?7jKnPtBxl3c6ZMZhRclv54bw8HytSYTijQU6o3f9Q+w5tgpzFZ4brx4LgHnq?=
 =?us-ascii?Q?2TIQJYkU20wMMagcMVgBaqZ2hETsL7M/M+tHvw2aleVbXxz4NOP2jOTFeeAa?=
 =?us-ascii?Q?Z+OWAbvbGavzgMg4POQwgGSW+ekmHbxvshp0ago39vBrk4Uf/Zy+XSlWlLoi?=
 =?us-ascii?Q?SsFDhRfix8rjMyR24npG+i7Ocq2CACV7vkACFSfbRWP8YZvFk4EQP/73LlxZ?=
 =?us-ascii?Q?ewEsgPtQNeyjuhImGZgjFVvq84qXwb4RdNGTSMhqXz1WPDBqfnc8SaNqSdjz?=
 =?us-ascii?Q?BDmbuu0s2v1IjqqhviL0B6T0b3V4cbyPtZ0a/4GjLeTlODTKhQfLPQNnQ9Kk?=
 =?us-ascii?Q?ATINLmhEag/3ZGx/9wuJiyJ0iZzJYQMu+b1AX0NlkTvz8J0p9dsHaKIEiQg4?=
 =?us-ascii?Q?oXQkbfa84eI/qFRD3Ai+nXCRfQz2nSTq3smlo5w29w4Ty+vbY4PAah7IOkgU?=
 =?us-ascii?Q?gARmsflS/pQUmZnnuuoph5TT1AH2jiyR/+Q60bDGZQaYS46SIs+/fjJXpAAd?=
 =?us-ascii?Q?tVxm5h5BM0q0k/oYnjhhDmLq21t0in2dS+jF+Q4ZUudfb/jqEbFY23iZg6TK?=
 =?us-ascii?Q?CPkoIoZUwFsKbLm+teys/oYHCVJ2Vsx3CZeXhlhQUmh7R/6y0gKjMnYECnaq?=
 =?us-ascii?Q?OqNaQIPzknH0lrBMMrEA74eGSZ3voMykiTi5lVfjU7H5Ejn+JvZI04xh2dWc?=
 =?us-ascii?Q?a+asQdt+cl0VkqG0Nz04WO66V7z+JltS1M/NfROayNiUX1GTr2vnwPLJdIao?=
 =?us-ascii?Q?xqCmK4msafLSfDw7kGAuPOQCpybgQ0sW6GEHMqfXvgmRuUQ30mcUqKPwCJG7?=
 =?us-ascii?Q?INZWKDukomyCN6D0VnLS/BMOWnvtZUbFl0aS57ATLs+QWSigPGjXi8Pq5pRC?=
 =?us-ascii?Q?18mUX4UgWLn+4ZM3dPXW/RdWDoyJH4I7AfUgcDU76mtTQhYQFVv/6E66OGDW?=
 =?us-ascii?Q?XSwaDm++M5WUiDjDJapt7dG0Wuh6kR7DEWWsF7/SJ4vXmroIPz83CAf2OiUU?=
 =?us-ascii?Q?vfgSclucx2luFbK/yQPSOXeXfcVIZ27B3egbndeR9Efnl6vYog8dRw0oEFB8?=
 =?us-ascii?Q?3Sjcadh/G7Jd3vK5LCdmy6MYpIMzPwHbpnU883Q7ouuhbj13TUzEOd2OSTWg?=
 =?us-ascii?Q?BrbtZ2EiOu75FnRtuC4k12BkzdvUZwL0fkGqERl6iXpiZPrkBB8gtUNJ2x3p?=
 =?us-ascii?Q?OFr//dWsfD3LjWQROcNHPwwk0FyiquRlq6S7Y7YWHGjqtqaEFRGqcezllX1E?=
 =?us-ascii?Q?j4/XEpft3FoXPjyiI0aVQIT/gGCLZiDDCgfZNf9aop9cv49oOJ1hEUOTsH9q?=
 =?us-ascii?Q?n73cnCWHBC65bNel2e+RqzvFRyN2txqh9y63xtOFrL0UfkltiqK5kqTuMyIS?=
 =?us-ascii?Q?ZBNQw7m7Op01o9bmepnijUIffVPrI3IbPs21D5biBcysxtQSUMjkdX1dCza8?=
 =?us-ascii?Q?uMJbHFy6bRbov1I8ra+IaNxMhyIvX72S6uBx94BPcqzAUl8WZa30QGRujkk/?=
 =?us-ascii?Q?tTFDPWWwXUa+XtICd7KI1PiL4Uxg8RnNlkqXfX6G2hJkpSUNORQVgjQsi+o9?=
 =?us-ascii?Q?AVSAkGnffbM4xQfOYJg8QzE=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 349937df-40e8-411a-e0a7-08db655cd381
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8426.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 00:35:56.4091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Miub9P10zm68pwA6iXntOIZSmCyUs0ostT50Q7YZkzHioV0CaIIWE/hnk6KzZtcXjCItpodYDqMETEaEVSdLfO+X+Snzgb1j9qm51kaXX4qRlppy6t6C25Dsh/2aRO1y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11386
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alvin

> --- a/sound/soc/generic/audio-graph-card2.c
> +++ b/sound/soc/generic/audio-graph-card2.c
(snip)
>  	/*
>  	 * convert bit_frame
>  	 * We need to flip clock_provider if it was CPU node,
>  	 * because it is Codec base.
>  	 */
>  	daiclk = snd_soc_daifmt_clock_provider_from_bitmap(bit_frame);
> -	if (is_cpu_node)
> +	if (is_cpu_node && !dai_link->symmetric_clock_roles)
>  		daiclk = snd_soc_daifmt_clock_provider_flipped(daiclk);
>  
>  	dai_link->dai_fmt	= daifmt | daiclk;

Hmm ? I'm confusing
[2/4] patch handling fliping, and [3/4] also handling fliping.
Nothing changed ?

Current SND_SOC_DAIFMT_xx_xx are very confusable,
framework and driver are different (flipped).
and also, audio-graph-card2 is using intuitive DT settings
(need flip for CPU).

Thank you for your help !!

Best regards
---
Kuninori Morimoto
