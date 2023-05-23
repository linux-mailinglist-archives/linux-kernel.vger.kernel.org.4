Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223AE70E980
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238738AbjEWXZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238529AbjEWXZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:25:04 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2113.outbound.protection.outlook.com [40.107.114.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A071BF;
        Tue, 23 May 2023 16:24:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZthFyqXmlIZELmhiTbzMdvkXctB6Sds9N3Q673/eg9hho2jpOBmkdzYDSLT08JhTTU42mMni07/0bYzi6SWjWZeP4qhfMsQuAmTZhH4BEMMmhzo2EYLajt6ebs2WECJHAz0a6daPQ+ldSqoIHmliJMLWeHxnJT5F90OmAe1F8WBy5j0Kgn8GbPJWsAkQvN+vcqPwtwtm/Qnei/XvivpqxaH1UX/x/Vzt4l6SAPsfuVpOFunTJSztMBJ7o9yzUjpMKcJLJdH+TomZJMk66i2h39GqM63qr0pByXQ/NE8Wous1eHQVbQfw0jNSZdwCacjKwWNZNIEl7N9Y1GEdrbiwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3ujJ2CwOV0bl6stQWR9eX5JT2hC/BR550BciKT3h0o=;
 b=bBDCJbGb55MWhb3OWEIVJU3TzO49AL1Ynyp4+pgtj3w3b7PRjIWJG3E2d/m1+tHEITjLZ7Lfk4blqNdFGg3+xCUkFhERxRcqv19/nDTAPeFGYdAmqtOqEEaVDelqmeIwvbCXYaEm/N+r4+VDIfYQe8+sZIuRjcbmOQR4Nttr1dvAxZxHy2H1niGk06pn8BzDk1prHEr76TCidVgvgPQnXODWyxszDC/BCFI+OuGSRlB6LldXRvaHHE76vB3TElA/IMl7r9z6tiWbOJBjTAcLBA0kkQFiIYbOfvswX8eY8C0XMZaRQBXt8Ckw/BUr4MHeGrhwwFLqqXwdayZvfMgYSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3ujJ2CwOV0bl6stQWR9eX5JT2hC/BR550BciKT3h0o=;
 b=P9G4luXVJ5UALxc1hT4J51Jeycj1smWXTOPCHpXc/wQNi9OI9oPqvR9jzSSy/qG9yBNr0gdxo7jLar18B6a1fG+ROMRQTBwoB12wFafGL4inzmZN2DRTQCHXdvMfXJYPGRm4EjeLZzM0Ij66Z1N720YOi7AFbzc96PQrGs0MK8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com (2603:1096:604:194::10)
 by OS3PR01MB7993.jpnprd01.prod.outlook.com (2603:1096:604:162::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 23:24:35 +0000
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::91e7:a94f:9f75:d840]) by OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::91e7:a94f:9f75:d840%6]) with mapi id 15.20.6433.015; Tue, 23 May 2023
 23:24:34 +0000
Message-ID: <87o7ma7hsj.wl-kuninori.morimoto.gx@renesas.com>
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
Subject: Re: [PATCH v2 8/9] ASoC: simple-card: Add missing of_node_put() in case of error
In-Reply-To: <20230523151223.109551-9-herve.codina@bootlin.com>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
        <20230523151223.109551-9-herve.codina@bootlin.com>
User-Agent: Wanderlust/2.15.9 Emacs/27.1 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date:   Tue, 23 May 2023 23:24:34 +0000
X-ClientProxiedBy: TYCPR01CA0114.jpnprd01.prod.outlook.com
 (2603:1096:405:4::30) To OS3PR01MB8426.jpnprd01.prod.outlook.com
 (2603:1096:604:194::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB8426:EE_|OS3PR01MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b776fd-0b7a-4fd8-6634-08db5be4de6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EEneGWa2XKY+1qPNfgs7COoq/EsIlvB3+LA9+zw9aVfmc1AR/UUUIs4cyspbQ/q0btbkjBYcf3kEGLUV+85gX/LTh/xQEckCe4lTgI59wrlK0w/LT8aDkY+/8u43Yd+Xm6j0CjXxcsISu8SFGXT+C0L+GQdDKO/1SSu7WVAUbU9ofZkIKZlfajhWj8oJqFZK3LIag7Ue00Jn0EUIXczQ3OQe95XmmbQFg2PgFzB/1SdJWMm0aJEo69yETqZcld6tYZ8O0ysi8vX4De9fpKkBPyH6eS85GWiC5qPs0EhGc+3hBDDyq2aR3h+x8Zs2BLsl4C0u0GeYrSzd0un1BGS/GtsBX/8KUXkjhvDovGjr5KVH3UiZ2J0dGvniThiAQ20FHn8YUXAeUhNFzY4O/Ndk9YmCjrnw0Ufh4xNvftdCmzXb/HNCG1YLA5mJldViN17vDl/tnNnU5K1DBpD7N7BCAr1D03bBJvl+fSxxTz/1QUrCS3t9cSmEqu8azykAlhZ2Ga2LQgWu1tzk3CYacYbFTROACVjCo+UJNs6NVmRYzrxtvjeGnBiqIwLBAcBg4dI4KzLh1sFESwTx4Xa4hx1JBhUYEAiTUW8TGVZ+wrEemT9tZ+2TI9d6fGc+LCgAkQsK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8426.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(2906002)(41300700001)(316002)(4326008)(6916009)(66556008)(66476007)(66946007)(8676002)(8936002)(7416002)(5660300002)(558084003)(36756003)(86362001)(38350700002)(38100700002)(2616005)(6512007)(6506007)(26005)(186003)(6486002)(52116002)(478600001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y9JVDBj1Q5KqYn6QQvKBX7SNc73te29R0/n3DFXJC4e8lovzWLLar2uYHq9E?=
 =?us-ascii?Q?YMmxzaZi7RS9v0jD0q9qE/LXEVgn4q3JtjCwjewWg/lqTxFloZYEKPnNxYAm?=
 =?us-ascii?Q?d2F3v6OWou0QFp6cpmHmK38Ds6loRLv/7tukBVyX5SyAi9Ix55UZWLil0Cw+?=
 =?us-ascii?Q?UjuCLnSrASYVSbifaP92yzrvs/3WT/Or5+FYulI3qdiYFMSpYakLAHKDxXgU?=
 =?us-ascii?Q?RgmH2awNKp63ax1zZXBoDlfkvr/67mIF6qlpgZsfqrTXJxXgiPPE+IriaU3m?=
 =?us-ascii?Q?RdMIBQg7RhZ4+jjs1dKdNt9RK5zL+cOoHGZX1e4r89MoHvVfcOjxgx2TTKyW?=
 =?us-ascii?Q?dc+2xzIi0pnUSsJkgKlyrdI+G24CWEFP+HEfPQFxuVavazVPMmK17hc9Zdrp?=
 =?us-ascii?Q?2bJQ9s93cBCFEv/10DF+cdsCdgSo8/pXyFw5rdY3xKdCaJhprNnSMUAzacS7?=
 =?us-ascii?Q?jatXTp2pyx56D24EAosb1yLbtmZw/VIdq3MPE97Ln1/TQLQ1eatIDmZwg3p4?=
 =?us-ascii?Q?KoEq5ANGSDpPas2mdY+p52q7TWGIcLK5DQ4csHd3v2xMJs2GcCsFlofL/o5M?=
 =?us-ascii?Q?nT/64Rq9vEcVZJVlpFGUXg4ll9eDjny40ukLuISpJD7mU1tc6qrO0LI83PUW?=
 =?us-ascii?Q?xUl7QVBC7BTnFCYzoY3vn8qbHr53N0e58rq+/coC7D0ZbdjGoDYBK+26JtrB?=
 =?us-ascii?Q?KjkLZNzfQbsuKLxC5r8b/zUmQ9NZw80mRibP7vLC6duz2L+BqQ9NFRPMORxp?=
 =?us-ascii?Q?Yc1LVvBQhkoOq/r90xTDwg9buYPdBm00PlyIHG/Fksy5Akj8of25MKzJoTMy?=
 =?us-ascii?Q?FPxSWi/0e7FxZ4JN+Fa2h7O/7sLfqRsT67G82G4qc21MOIYr+8u1dpsGADO2?=
 =?us-ascii?Q?A7HD/xEa0PbxLQW9MfprntlHF6QQ1ck2CZ1FXkFAZQG5JDcZ0XLMW5JMCSCR?=
 =?us-ascii?Q?peT67y2+tT7CDJUDheXGvf6UGprXBldhcE0GpcNEn0hwoz/M0v80U+deGj7W?=
 =?us-ascii?Q?/PcZ3XFpXys8PJX3U6c2Y5bY0xY2x+Y888LyDBOPu37U+3Esqm3XplVCyFFI?=
 =?us-ascii?Q?4jh9eNl0XXUArWM73Tt+ZXXtO+wjCeAQa7k36QysuH1Tiw3eUCFsn7DgcNT/?=
 =?us-ascii?Q?Pm5jG34ihgnLHv5aSrnEjS60hBJZK6bHEQF7Xe6Kk7L59/Hb4GX8ikbebMIU?=
 =?us-ascii?Q?NS4Y5I4+LeqjEhpCdjy4sJ5Brv0ZefmRnE5wWj6qe/ZJqAAZtcvFQgK6fwSP?=
 =?us-ascii?Q?xrQjpaqom7KtoXNfPj8mJYubbJmlymemYwQBPOwTcZ44PtL/Q2xg+Ry6JaLt?=
 =?us-ascii?Q?4lB8wWUfUluQXmZzZ8tvp819FflhlYEcKPbNFwmSG8Tp28A1y755q7lV4Glr?=
 =?us-ascii?Q?TUrvlyZpuO/BbDPhn5LEEefp3IFeOqZ1DVQlQh0lQPGrOkINzhNukhyD2pv8?=
 =?us-ascii?Q?b7EjeTgACeKQ3M/kaP6BsdjxiclLWxODhOgyGGUr3G5ZcPYWl7FIm2wgRQvM?=
 =?us-ascii?Q?n5n4X6nmyYassuFTy+lg/bBFVVoW44XIfiuj5n476mF4/y+SYS4A7QubCITy?=
 =?us-ascii?Q?ECOOEs7Z77L8H6T9GRLYkN8CTW1oqs8wCP0PAV8QcWnWVB/S58kWKe8ljI6J?=
 =?us-ascii?Q?Rn2uIhePP1iI3VF46vj96cM=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b776fd-0b7a-4fd8-6634-08db5be4de6e
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8426.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:24:34.7610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/JczdHsbdLXdcIHnXohekdCaJommI9t0oxGgVIhTSFxBbjKk8IFr8yfF8dwZLe3P6FzxxmbZ+Mpc3fVXeLEoQg44aiM5AjKOn4imelUxXYtR9ykk6DNu9Hd4CPkFg1v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7993
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

> In the error path, a of_node_put() for platform is missing.
> Just add it.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thank you for your help !!

Best regards
---
Kuninori Morimoto
