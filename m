Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F857101DD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 02:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbjEYABW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 20:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjEYABU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 20:01:20 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2097.outbound.protection.outlook.com [40.107.113.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61683139;
        Wed, 24 May 2023 17:01:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUOwifdTncSyO6+D+DtJ7Wda+/1prhNHjJEw6X0xxot/wY+Uc9MH8+D47EqWJFbjdbsnnX7Km8ppLiH456+JwkXtGV/nB88B8xiw5Np8be3Hj2vA1gbw4WBYeeekiTUCqtP2sIncM6cMziGmoYkK2WpAeKPDFaDUjBpKrhWByELi9kmh/1uaWUlbReU/k5XOqWY+hpHPZTkiDNmdPc0rc9JYqEQpujEKM9RCaEAFdthnRhbqbrQrcIyeIJyTiaKVU3e8VA7tu04lGATOaGAqkWErR+kC4VfSyydkAeaM9Owf8MLbNqCaGJFLTIPWawcw/oH3+KUHzwLbpmrRu4v/Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bstA6q2KhAQ8ADi2rh7Nz5+Es+Nhy1lWC0jhMZh/F2A=;
 b=kl6Ry+FIqmM/FZNNXQAiE4qpl5D+QQAQG54ftNSDRu3xA96O5Ad3RtErGLMw1XlW5HNgSXTtQxWdudqQqrg+ufwL7KgCBC6Amd4bj8jW4DyLGF/D/givQTVYtP9dSCsTG/xFOT/b0//SW4dX0ZcgMLFS72Aj6RdQGFtWKH484T4of7mKnIdmRsaY7WxMerStRegrBhSXQ0C1nRWj57yIKade4QciSKu9tMiNGPtuFlDkxQzy0feoetCXntjWGI+iBDVgTLvdtWEmdmrUWTAEB+bnvhwOIyhGWwDc4NpXvgOupX15pP+nHyPBQSxmTpffJ2KY1cynTbVnEZF7G2neFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bstA6q2KhAQ8ADi2rh7Nz5+Es+Nhy1lWC0jhMZh/F2A=;
 b=nHN1prXSK5SdTaU+AlWvxjzYp5G81vngLA2x8JWlrCyQ7ySlv9MRoDTwFixydJKUv3qCd/nsbrsrcEfGP2KPxUi3YzO4qLy0E6hWZ56oyX7BeSnNO7buH9a/Ol+TUa1NYtV9Gs38PL5A/7sUu1YiCqKYQr621tGnE62sjeQ6Snk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB8440.jpnprd01.prod.outlook.com (2603:1096:400:15d::5)
 by TYCPR01MB10995.jpnprd01.prod.outlook.com (2603:1096:400:3ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Thu, 25 May
 2023 00:01:14 +0000
Received: from TYCPR01MB8440.jpnprd01.prod.outlook.com
 ([fe80::6c36:5ff9:24c9:e4f7]) by TYCPR01MB8440.jpnprd01.prod.outlook.com
 ([fe80::6c36:5ff9:24c9:e4f7%6]) with mapi id 15.20.6433.016; Thu, 25 May 2023
 00:01:14 +0000
Message-ID: <87v8ghgtyu.wl-kuninori.morimoto.gx@renesas.com>
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 9/9] ASoC: simple-card: Handle additional devices
In-Reply-To: <20230524141411.28765782@bootlin.com>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
        <20230523151223.109551-10-herve.codina@bootlin.com>
        <87mt1u7fql.wl-kuninori.morimoto.gx@renesas.com>
        <20230524141411.28765782@bootlin.com>
User-Agent: Wanderlust/2.15.9 Emacs/27.1 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date:   Thu, 25 May 2023 00:01:14 +0000
X-ClientProxiedBy: TYBP286CA0037.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::25) To TYCPR01MB8440.jpnprd01.prod.outlook.com
 (2603:1096:400:15d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8440:EE_|TYCPR01MB10995:EE_
X-MS-Office365-Filtering-Correlation-Id: f04d67f1-a2a3-49ba-e9ef-08db5cb32801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8DoaaoR+UwTQCiAOupIgPNioiN136/DhpG08s2JifWqrc565O/xaTEN1v9Uph9iKSS1zNo3Sh4k8Oemmfe91eIxCwpfPbDnhQ0Lx+4k4qubVdw8rPcxZJjCVlRIfbCFoDY5WAEgIAcxzfw/DQcSYiuyAHuNdF4MxtpjYFxcYJPMCyUxGSXBgqEgof+LejTYBFlvasHrwi+rmrxF7Y360P3rWF7GBI6tMl6+DPXDyJKkcmJbPcWDWg8OphIOMHtndWROblgYqBIZ6nPj9XW068Y3TPAHNYZ3Nr0Qf7/kdPhFeWtZExXNSOosBhJvGY22xMwJs4cOBMm01MaIQI5l1MJqVfBBENXa0hGPBoOdmL9Kj3RVt79yWFGFe0rpYNsc/FhYAJx6D9io1BqUFNozl+JbqaglVN+oZA/12uxdDtLvH9cRiZhdDPcqFVH1yaR9THY6D6ThwLWS/DqHS8HYezuNPPuwfaPRpxTea/WnTJhnr+IvfpvobFnc5TQEFLtCjFrRepZ4x2cc6oa6Uq83NR1QRz2K61zClrc+Y+t2fVOkISeOed//EFbIzhNWb9l+x3kBsSk2K507Ils1OnKTDDymqJ9ufjLIXc1fAAP7pupw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8440.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(8676002)(5660300002)(7416002)(478600001)(52116002)(6486002)(316002)(41300700001)(8936002)(66899021)(6512007)(6506007)(26005)(6916009)(4326008)(66946007)(54906003)(66476007)(66556008)(186003)(2616005)(2906002)(4744005)(38100700002)(38350700002)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4F6KMgu5ugExPdPg557gthQcZ5mG0A+OX4HYYbgtaY7DfnOyPP0uHi0K8TzA?=
 =?us-ascii?Q?JkZbZYqpgm6LcBgeQqOdeJmVzEd4c9ilUYnzLaHiwa3WN+sucRo+HZjVbXRk?=
 =?us-ascii?Q?im+2xkWjWR+0s/pN9zJK201VsxfXRskyCRaGuKvwhD1gqagzYFfNDhDr3Uys?=
 =?us-ascii?Q?ENoxsmjpZFOYxPo1bArjDH3xPXzE0lqEcLibad/Yxk5nSe355W6GKpLI1qWx?=
 =?us-ascii?Q?hhCbiQG4ywlUcSk6tJtq0QLqXMyRkX5XIGFCQiNfY4tc7+N8uRTN7qbF7Aoc?=
 =?us-ascii?Q?H4mANqbpmi5bHiTA95DdPyTuzCAWhnm+f8xyHIfE9olYyP05VeSlBboPuTKg?=
 =?us-ascii?Q?coB6M2cOexy0HmTfQkWm9xAGIM1cxCyLoibHAla7rR3c6vHuokhHB2xFTZf/?=
 =?us-ascii?Q?mxk3efBK/4m8Sv1r/G2HuvtxfaBdygqAARtIaPjcTipCPuAS/Zvt5S0oHIef?=
 =?us-ascii?Q?d4XkDa94MLGqreGvgZ/xeHOUngXAeFeyyvb4IVowzBLxVgXhQT0LhvHwzmvr?=
 =?us-ascii?Q?5kvzLGTJYASrmM1uT9HQgzdImFqjVKcNS+pvmCSzpkuWbWVT+CxlRMQtFyy7?=
 =?us-ascii?Q?VXpnN4Zr/IVhQLV9lDRKAbHM5mpq1qXE72qVWJHzUF84KGISS1SpYzx0aama?=
 =?us-ascii?Q?2kwXQyYl5iRtExjzD9q4GNP74gfK7AuI5qJBWJhmXmWt9RsI1PBePe+46ExO?=
 =?us-ascii?Q?E5RaGTyWVRxGDoDhaaveLi2g6lFLKB8YFa3mostLUU5OKGYBEPOeiI4cJthk?=
 =?us-ascii?Q?p0Gly9eGNjkUpbE73fiGJY/4jwZ+br4ZcBB9dysWJ+2ZFOIhl6/QRr4pQsAM?=
 =?us-ascii?Q?Om2t6vhkYF2L1tw3q6E8HPbrdoXQCRZu25lsGf26uV+06YUfs8rH/p2Ha5Hx?=
 =?us-ascii?Q?xKpLAWgie0aVl02hryQOBkRgulCrnE2mu6BDmBsBmyBg+Vrj9rdnzUftOv7v?=
 =?us-ascii?Q?IphlloHAjPLCc6O/gFvijVhWG8tnn0vYFDM45SSw5SWujW4Ulho1zMgypDZ0?=
 =?us-ascii?Q?gy1BZxTbEzv7ozo/k9z9X8Sr5H0J67jPcx2qnpWN+58qKLAnSgx+I8ZsGDWq?=
 =?us-ascii?Q?QAu9GlbpWWUr56zSugmq7ehdHeXx+U/6FhJ2WMKvqQZkQnkPeTti6ALATwZt?=
 =?us-ascii?Q?OTHfBt4dUS4+yt2Yjhmk9eKMrTOGlYKYW4NRCXEd9DJxbKWzBZ3EqpUVRah8?=
 =?us-ascii?Q?2yUPVFgnaQbeDILlh6H3X+ajNGAVHrlFViqkP9sJn4C07gqsDyaN1UzxVIHK?=
 =?us-ascii?Q?eS5KjVSCZUEzerUSe8USxxMKuWrIw/wmTa7NYIQLEt0noNV8eI6FbwaQtrgA?=
 =?us-ascii?Q?4Fqsy05Ps4r/1RWlCea0c8WGH7YoAUCTSzktvBZcbe3Gd7Az2j5Q8kYbaxQA?=
 =?us-ascii?Q?T1aXdgbswygW72RXEcZMKhsZWFdsOvCkxraj5REwhtEKz5IkTMryw0BSLWSq?=
 =?us-ascii?Q?n1zh5nwSITCABEwRVkPeHhVTyxi5FasyNtztoYiZTlBYtPc39KyL0jOOYfSK?=
 =?us-ascii?Q?Vbz/ega7ssAcQ0GKIF9+vY0bQzG682mLXco+xeNvKmu5jnAaDwkmzKRIRGZ5?=
 =?us-ascii?Q?hhcFhOlS+lF/+Qx1+8HPsQbz01LE7WOjSHaFon6Q/r1sY2bqDYfrqZhPLXQS?=
 =?us-ascii?Q?iFwDGu6RJiS/sPpnRV05Atk=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f04d67f1-a2a3-49ba-e9ef-08db5cb32801
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8440.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 00:01:14.4422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRozGx8ABYh7Vc1NWTv0taoPE9SS3Vzq/bCyxgZkQ4nJU77Yf6+EtDSqDi09NPx2Ap6GSNaXVqyfdeYTzDgdvl0cvh2+5GMjtbjmZXSp5E5t2UblSvTaIvuD5DXi0jNW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10995
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Herve

Thank you for your reply.

> So, IMHO, calling simple_populate_aux() from __simple_for_each_link() is
> not correct as it has nothing to do with DAI links and must be call once
> per Card.

My biggest concern is that this code is calling same code multiple times.
It is easy to forget such thing when updating in this kind of code.
We don't forget / take mistake if these are merged.
But we have such code everywhere ;) this is just my concern, not a big deal.

	static int __simple_for_each_link (...)
	{
		...
=>		add_devs = of_get_child_by_name(top, PREFIX "additional-devs");
		...
	}

	static int simple_populate_aux(...)
	{
		...
=>		node = of_get_child_by_name(dev->of_node, PREFIX "additional-devs");
		...
	}

Thank you for your help !!

Best regards
---
Kuninori Morimoto
