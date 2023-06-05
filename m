Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46305721B3C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 02:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjFEA3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 20:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjFEA33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 20:29:29 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2123.outbound.protection.outlook.com [40.107.113.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A578C10D;
        Sun,  4 Jun 2023 17:28:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwIq6uvchi/VEMQq8kEqWR2gcxTlZ2zuDuvRRLaUnBVEOEnk47MF0YzbrFlCkkcjCgLpDMLGTP5mZCYYIBrnC6FRZQ/sgzImRWX2YDD9kYHxS+xrRoVFdXg4fw5UzYlQT/6uWKDLrzt5724kaFo0/otkzNO/SG0872SX8zTEziy+/cRYK7HAPe9QkWzeUM7KbbLPfHdyUSmEhhqbG6UdhBozRms5aTxi5kfzcce/L1Df2STOszkfbvEscY+FC2+EEE9VOnnTpltRiwReyC93GXkRKx7GY4tragp7SWzPIUzbiKZCfh5xE8zaN/VRpApHjxtdCbw453j+Elc7t/5XbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suM7EOO4+V5IEmbqJC5g1lp3RMQ5Ilw3/+EX2TR3NaM=;
 b=lridU8t479cM6oXquAC0C9Zm3SuUKC1VLpFsqhwpQAPa1ZhG2/OcUOafpfkFZPsrMOyvj0qmYz+sckrxgKC/oYqaCNT41xvZNDPNKG92pW271dgWU3yKj2c5ic81tooIZN6LJlFC4mjJtE5HovhzWeIdV7UC2a0uBe+cBpbl8y2hzzFLh/nn26INNDIOSEwzbJ60FaU+wUN3NVD+70Xi28B8eoKLHQsQzrhA8zOyj4wRiejDz2eRh3uJF/9tYTjGR8mEvoIrg6cLRqJWhbockUnddZI4k6EwApELfe6uKZ5BLF8cm39c5rrp0ZjYmyJnjXPIiwtzXDdeTxA+PbWtvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suM7EOO4+V5IEmbqJC5g1lp3RMQ5Ilw3/+EX2TR3NaM=;
 b=JScn88pkBheP3KwG25u4QlIo3PMP5gSZN7s54TcaY7/Rg20PYuWvY63jWFcmLQdUA+fertowP5alSfOJDYYpI8sibv3f/maQ7+qXFCydZT7batB61OtKQzAei2BymuZ/eoR7K+pgqQQZFJo01+7sYmzUQZ6KUkCiObwozwYroi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com (2603:1096:604:194::10)
 by TYVPR01MB11130.jpnprd01.prod.outlook.com (2603:1096:400:36c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 00:28:15 +0000
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::91e7:a94f:9f75:d840]) by OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::91e7:a94f:9f75:d840%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 00:28:14 +0000
Message-ID: <873536iwgx.wl-kuninori.morimoto.gx@renesas.com>
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
Subject: Re: [PATCH 4/4] ASoC: simple-card: parse symmetric-clock-roles property
In-Reply-To: <20230602090322.1876359-5-alvin@pqrs.dk>
References: <20230602090322.1876359-1-alvin@pqrs.dk>
        <20230602090322.1876359-5-alvin@pqrs.dk>
User-Agent: Wanderlust/2.15.9 Emacs/27.1 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date:   Mon, 5 Jun 2023 00:28:14 +0000
X-ClientProxiedBy: TYCP286CA0212.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::16) To OS3PR01MB8426.jpnprd01.prod.outlook.com
 (2603:1096:604:194::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB8426:EE_|TYVPR01MB11130:EE_
X-MS-Office365-Filtering-Correlation-Id: 681a3d36-5531-4763-66d4-08db655bc06d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ugDyQmJKCpNCHdYC2FcyqK+ZjSBB12kswKjYvyWmJMlK1sDz9g+Q8yblfCTos+DrXk5QrjV+jE4616qzNC5w9hYWFugmRmL7k93cwdhILcgr3WYP1rFU8TYpjYvtTb4I9WUbSGtMrH9htOWE6wRzZXsh/S1ytHRVk4F/iP8UfJk6tC6HAOJDybKk8piTPHw9tr0cXLTVC+/HEjEYvdX7C9LWUeMLbrZh9lYTzklUcK6NlTrfSSafrFr9efEd5VDm/HDYEZzs0Wj2KuP+dBACCxMGiVE5rgreswmwmGO+o1MucUCiETEO5R3ipzBS2goMI+6BmJDmZ9XJj1YbqVCQAm6GMhsL4AcpC+XuGyv/kurOLFSSEr0LshiFG8C9M51v4zS/tnlZG1hVpDzln72DC/vjfa+CLjm1m/QaOqJgUCzAxJYTPbbN5MNBbK6DCityjRIBxRru1yqEz0M+AtpR7RVSiLL66WhURgvCUI2+sLky89wgdyNvNWC7FQ4xjknP/4PH7PKeYBCP9NvOZTnIaDD5YLGX4NBgXze8votbg9Y0/wEzaMTsWQkEb6JpxV4ooUK18cSTp3kVH8es5ue73fWTGrynYqqDia4h4uv9hYBWmGrbv5w5uOcdqi/yb96
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8426.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199021)(6512007)(6506007)(38100700002)(2616005)(41300700001)(38350700002)(6486002)(52116002)(26005)(186003)(83380400001)(478600001)(54906003)(4326008)(66476007)(66556008)(6916009)(316002)(66946007)(7416002)(8936002)(8676002)(5660300002)(2906002)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rxFlW/s/qEqqxqdhO1z/xl30ZbHDrZ5/su78QXH1usZ2IC7F35nVOApB5d95?=
 =?us-ascii?Q?vw34tyQmPSJQUE8ZUuCfO16ZIz/YhsjVM3mcwsv69PScBI4Pa4VH5eflQKkq?=
 =?us-ascii?Q?sCC0oYmjZjukIW76FVjAmrXgqMswrxDjt5MxFXcAoPW8i6gisqXJT6RvJMJH?=
 =?us-ascii?Q?JOEjxEieELXEG3R84CoskGxOyd3RFnrXgNze3lZRAOqKIRUI9b1thIhSCPUB?=
 =?us-ascii?Q?dYch7eO+4xgIgCkBtDBsSzk/Xlfshp4X89ouIgndMubklLV207fuUGcwo2CC?=
 =?us-ascii?Q?gFyVfHhqnMIL4tHo+0uDswBrb9dezM7rF3G3F/3E96KPt0DBy4kEk0r2owok?=
 =?us-ascii?Q?328hQLCwZ1Sp6DRPy0qtNp91qwL7OVJoOFZEI+AzZ2i7D7CzRCeq+aXAcevz?=
 =?us-ascii?Q?gYhsuuzpfOtOQ3k9pfbB+KwiUfQsc+vpFUSOwIW8ulEbXIb0rFM0wfq9imw4?=
 =?us-ascii?Q?ZqW4CyOoaib6rZpMyeCrIPbQb2a5N1ZjmssIr6K+w//pHNtAV3Ogdvvrqnnk?=
 =?us-ascii?Q?TC0v+VTq66Bl2bx3SZThDWsq5y5vDQNSs+cu7jx3NGY2tbvVBZAwx6mG6arN?=
 =?us-ascii?Q?R7la7LLJM5BTeeGyXCA0dAa6D5WXZRu4oxa83/2RgXzIkc7zXBH9ifGQ/owo?=
 =?us-ascii?Q?oIEdhpKoD9+Lzt8NGtw4kqthggQsoPFm+cCavU0Lf1JObRPXY28Td2cXOQ1p?=
 =?us-ascii?Q?j1mZwpvIHvkWyUwXpDGcaLaW/x6gejkcNW+rGmh/mL/AqL66+R+8HgPbDrIf?=
 =?us-ascii?Q?MVn4ETZCUDDSlXK5hYNArdb5BrLuXRL2ROu73439GSsybEigA4TMK60iUxOu?=
 =?us-ascii?Q?2Q83LkYN6SJuWbesDMWVlxRKrbU2daNZV5SgYMYEeNpClk589Kr7uLm5DjSH?=
 =?us-ascii?Q?uj8aDyEelo2+TJaq7Sm6Szsr1F5BnjkG5LXlZAHbqwXOhZ0pCuVTZI01MCVo?=
 =?us-ascii?Q?d5sb1e13a84SciUYY6cLvyncpJeeqr/qQVwsp7hT5sHZ3ajMT9szum9kyj+I?=
 =?us-ascii?Q?PhCdc2Uz+1iKSoIYkt4R+x/3ud5poS6myV9JZhZGf0DwhcVRca3nb2VUMa9n?=
 =?us-ascii?Q?oiDiEdBmJygVi+JiArBKZa3tYcIyHuozPaVccWwFeR/zpo5qw6O8Y/oZShCs?=
 =?us-ascii?Q?DUjlot8ypn4u47yt5EcGXlad760+nJa4pm2nZfBGnorBxnUxQ7VTzcUUk3fO?=
 =?us-ascii?Q?ZbZ3i770sC1jX5RZUC0QVG2CpTLQBsRuiNsergydzv58nXHGbz1ZOvmzOww+?=
 =?us-ascii?Q?rzLVTBRBv73BHk2ikEe14otPWwyUns4uAOFKXszelWFiTzgZ5yavQ9Yxa2nO?=
 =?us-ascii?Q?DvFrtbJ9SkTeBsfF9wtVjjO59tTK+7oXfHt2DnBdu+1rYIVRUuWfOHsCBZ7m?=
 =?us-ascii?Q?a9q08uL555exxlf16EJR5gg0cf3lFRr5dlw+LiX7+7MTWsSFNq2cC7yzMP0Y?=
 =?us-ascii?Q?7Oz03xtqTeECRfsg5B3iaVEZrKn7Flmw+qtSOZDRsSKroaqCniiK4Fb1eyTD?=
 =?us-ascii?Q?W52tcPjw6SI2M/fPyfmZf+iuMFVqvVv1Wyn9RxVstVz6Xo+xkMS7rLZuJgnh?=
 =?us-ascii?Q?fa1MieR5tYR0DqL/v5CjcHxqPGt5R1HrexG1u0+ZN9sr5fJ3fBN+1Rk2/Qrx?=
 =?us-ascii?Q?5c6pQiu3kP/r/zMrwfJx/fA=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 681a3d36-5531-4763-66d4-08db655bc06d
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8426.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 00:28:14.9013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbSvUZXL7Fzow6bIhqQcuVg957BfbX94FFiDArbS9DFKTNLb7kltDACFDa+/flj5gpI9ZoJROu18ThXmd4SHBzIDPVtps+wjcRqArMgpK/cS6J4SsObAueTNVImHqE3Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11130
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

Thank you for the patch

> --- a/sound/soc/generic/simple-card.c
> +++ b/sound/soc/generic/simple-card.c
> @@ -181,6 +181,7 @@ static int simple_link_init(struct asoc_simple_priv *priv,
>  {
>  	struct device *dev = simple_priv_to_dev(priv);
>  	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, li->link);
> +	char prop[128];
>  	int ret;
>  
>  	ret = asoc_simple_parse_daifmt(dev, node, codec,
> @@ -188,6 +189,9 @@ static int simple_link_init(struct asoc_simple_priv *priv,
>  	if (ret < 0)
>  		return 0;
>  
> +	snprintf(prop, sizeof(prop), "%ssymmetric-clock-roles", prefix);
> +	dai_link->symmetric_clock_roles = of_property_read_bool(node, prop);
> +
>  	dai_link->init			= asoc_simple_dai_init;
>  	dai_link->ops			= &simple_ops;

looks good to me.

simple-card / audio-graph-card / audio-graph-card2 want to support same settings
(But unfortunately it is not completely synchronized...).

Could you please add same settings or indicate it on the comment
(like /* FIXME support symmetric-clock-roles here */, etc)
on audio-graph-card, if you create v2 patch ?

Thank you for your help !!

Best regards
---
Kuninori Morimoto
