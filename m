Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2188674B24
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjATEpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjATEo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:44:26 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:7010::701])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6099FC132A;
        Thu, 19 Jan 2023 20:39:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYbgQv6nKJhpykKrRyacIWpeNEWvJa5tNKHQK1QhM+eJt0SCo0mRankafmylCWhsV9MSu8kaQaFp/wczhZC+l4PZwdftwxjioeX8x8ExBXQUuo1dYWjiZBhSC5dVwGWhY5QQSGeRfV3anJx9GhlwbDknI85gm9GemSE3pqSxUwSZuvdCWRcojbhJA8rYEGOhO8JyrNXYBjZHLYUZaYjTgL50VDTjfaRC29bV4lkJWp4xB+wRUmIL366lVkQi3Ho43lYUbrV0Z/U6dLE4ZfM2ufMjp+POsZ4qRfrbE7p2bVLeEu7zUulCwB9oTyX2Ib65tOhAPHBS7jeMTe0KMUiayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xi2kwd1mmwsb17BpSTFMKO77fkGsBOzbMaIz8fiGSBA=;
 b=YKqCCm8HgELQSZJHSAA9bJP/WKcofzHYr9qAI2NUlZB+1uaQwwnRgGNVCU+8uxnxF7TkHa0TBGSEioPqopkEsR40qdhSxn1EdxzB6r1zwN/CANIBQq+PS2SYBINOy3hp32aLtdep5w5sRtBOKzELtPNAt5V6dCV/jRg8r24BvkHeWXXLShWKTVSHHlCHCVe9JBtyOxp0Rlxpl+4TTmI44V0Apf0DaHZH8uivMIgppulwPJtkYj6NyBvXTdr3w2E8BaegCR02Mkuo9PuOyG+rHHdQ6bQ7cztb9nS+dIN1mRcZNLrL+a3RlvSmxIkepZJFtDxHunQmf+LeSQgv1nAuCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xi2kwd1mmwsb17BpSTFMKO77fkGsBOzbMaIz8fiGSBA=;
 b=QNhh1X8jeg4TUL7/IdjuPb3tkzUaaDuQMqHKdTNZlrBhWgbTlkX1x2VWJQBuHtfCt2hrcRmXOO/MFRyRdvrdz2UfI9NFeeaFwyTxtZcx9t9MafJSwbmrz3Tgl3W/3An4uIWx15AlHXNkfzYS/G7t87fgoE737+HbmlfyhySDcgc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com (2603:1096:604:194::10)
 by OSZPR01MB8435.jpnprd01.prod.outlook.com (2603:1096:604:16e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 04:38:28 +0000
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::3cd7:a7b5:ea86:9ae]) by OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::3cd7:a7b5:ea86:9ae%4]) with mapi id 15.20.6002.012; Fri, 20 Jan 2023
 04:38:28 +0000
Message-ID: <87lelxlt18.wl-kuninori.morimoto.gx@renesas.com>
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     =?ISO-8859-2?Q?Micha=B3?= Grzelak <mchl.grzlk@gmail.com>
Cc:     linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: sound: audio-graph-port: Add capture and playback
In-Reply-To: <20230120011744.550701-1-mchl.grzlk@gmail.com>
References: <20230120011744.550701-1-mchl.grzlk@gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/26.3 Mule/6.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 20 Jan 2023 04:38:28 +0000
X-ClientProxiedBy: TY2PR02CA0067.apcprd02.prod.outlook.com
 (2603:1096:404:e2::31) To OS3PR01MB8426.jpnprd01.prod.outlook.com
 (2603:1096:604:194::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB8426:EE_|OSZPR01MB8435:EE_
X-MS-Office365-Filtering-Correlation-Id: ea8e22ed-1236-4be2-366c-08dafaa02d2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: og1SMvgrJGWU+WYLQ9HI7t0YhrdbnrObsgLXY/eoKaJ1eUaq6mZ0u0RYq12SY0iZ1lfUcF+44XWZZXeHnmFL/Ge67a1ucu2vYJuLBcweUV2lU3eVDx9iLCTFVcMQ5rLM7umcOm7k2DH7KlrUmLLgdtVn8tSP4HCG09ZO61QQVZ98V1T3/OX+Jt8FoQYqGZYk9vEinMqfnKrcVFAmP7VMolPDKU4qZO6+2dKtWctpm+8UA5cDddYobLcBckGr+sUknJVGJR1fxhqTIQvy8FXvCBwHEO8xTV1cdfeRF+47UpsWin91zjtUaapqRpd3ljZwMTnO3oFh+0r7WZ7s/63iAISv/BIBMBNqPKhlRsE2bN2IA5relc6pR/Ez/gg9R/TQx6ulQP257U+sGxfvCmdAmJKbbEGF8KOPY8Z1UI0Qpa8UR8M1GLdZLfbzrdXtMGdznAddfbJCociq3JIK3hs9KoBAYBKAW474mR+qtszowKGY/0aHfL7Rhb9XAreRtPJY1wIuRwGFrNE5LLV1E1qxq2FqKaPUqMNFeiegEQ9aGz+HoGHG97Ohi4W5it3lV5PQUBwk3dLZBpS1GVLErIH9GfEIitP4xL1zKRTspSTasIQR1M602LyrnWqqWBWWjT7OCfqOiQKVHAr/l0djQ6hCNgfjHNMhPEpwVE55Bz5ZsuzIJsbt92vFo9u6kj/dU1hWF6L4RCRjHDE8LG31LAXEd2fYng1H8ZepRKK072SxJfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8426.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199015)(66476007)(8676002)(4326008)(6916009)(66556008)(66946007)(2616005)(966005)(6486002)(478600001)(26005)(6512007)(186003)(6506007)(316002)(36756003)(83380400001)(52116002)(38350700002)(38100700002)(2906002)(41300700001)(86362001)(5660300002)(4744005)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-2?Q?4Lz1tyhSFXy2RcGNXAzdgz5qSCdlC68HV9StrwaPgJUBTqnxJeg60qWUYS?=
 =?iso-8859-2?Q?sYKM9d5AFkKk2ol4AyyepIMmOnU6s9PMYmPmp6TDwu3lZw4PJ5MlFaJa6L?=
 =?iso-8859-2?Q?JQdNz4iyQu1PJHD1CR+LjItVnj3aM8BLKh7KogjeyupCqC5es0iZ41CbuN?=
 =?iso-8859-2?Q?cVme5DxT11UoVG8RpQ7k1YuS7yFuNuuWz52URvz9pnk147qunJbDR9VHc+?=
 =?iso-8859-2?Q?+WBOABkw0aWARywlfabjGO1RMaOojT1Qf58JuIOTVWLYW0QLTr7XQ56CwR?=
 =?iso-8859-2?Q?itGSmcPsj8wOD97oqhzt4hIR0C5jS77fWl7ubDR7YhWNK/mm80oULUgi4U?=
 =?iso-8859-2?Q?PkzlJuZW0KKPit1m0VVrbiZAqPP7flhWEeqx/pufftXnCG3j9kcpneDcA0?=
 =?iso-8859-2?Q?6+Jjer+ZH+ZQsFrUiIDqwUe5xj6DCpoLhGDGfsz2ur7IOLPaynwbQR6/T3?=
 =?iso-8859-2?Q?QXFnRyGPGgw+KAcdYWHEFdt+4wSVzdkAVV2c5w1UQHTP3a1zm0eY0ZPPVT?=
 =?iso-8859-2?Q?KIEYJ+tUEetXLzMgnU8Kg2Y1LahvBhRr+7GQpJcFTZk6ROSnJFXUdRvPnJ?=
 =?iso-8859-2?Q?osalSnM0DKh+hxdFNHcwRTFYqLvfy7WCadry0g75R5fPVUyOaYM9daZtJm?=
 =?iso-8859-2?Q?lZ3RcfHvGZCOXvESdz4oEA/WGSqmj0GmdLnIuKFSiqgfqTvMn72BHkhYUa?=
 =?iso-8859-2?Q?1L2rA9OQxcK9qKRKrCB5Fl0K+fR70ZwCwguYOY+cazocYLIpsXXfZi5UvI?=
 =?iso-8859-2?Q?O6AlsX0qSKavuApmgi6OfpPr/4kT2f6y8HKxORpq4GfVUCv7O9gua4cRN1?=
 =?iso-8859-2?Q?ILt5vghWYfiaiaR/VA8ryemduKv3RQV0uaTbppmLFuAD+r8Ne1kLSnRuTS?=
 =?iso-8859-2?Q?SagdDPBFYm9zS5GVR2bTBOrqTlo3cpvMHl4ivFGNviaUjkNzWau4Q36RJB?=
 =?iso-8859-2?Q?JQJUUyM9eV6JSMt93wxmiokb7pTJGwGDly8WokpQ+kr8x480WRhVlXw5st?=
 =?iso-8859-2?Q?3EIUlsYUKS60RuZqb2fcKKk0pufXtQN2RsNVQxlRo3iGri4ozHXsbHaECG?=
 =?iso-8859-2?Q?086pmoNFV834toMKrHtxpBB9IS+wC7Xpoj/IFmhE6ex4skt863+RnwgKCQ?=
 =?iso-8859-2?Q?nUkGnvlz7gcj+7OOw8wJljpUb2ic5c6fYfx1LsAMszEJbPY1dd0mnPi8Bj?=
 =?iso-8859-2?Q?+sop4X4C1NuQ7oXzwFcvI+QODT4g3DWFhTlLY6azMIRrFpvuDI+oKYGrNq?=
 =?iso-8859-2?Q?dmcFz38kgMazZ09c4jIXhheAqVcJcianewQRf+nqjPiwgbyenXjJn3wVEx?=
 =?iso-8859-2?Q?REfYpBbPonP0ZPqWviUe+Hh1a7EUoWVpQ7n047t49X82IJu/C9qhqdFE14?=
 =?iso-8859-2?Q?5ppG/2ag1u0CQDpu5lWjaQLlrzRtQP5JtZAYfmLSBPspmxoqOGcU1WwcFH?=
 =?iso-8859-2?Q?GjFe8obActQ60Nxs5xdXpzRBSuHgpW1SRxGPtT/EZ3Lt3xNdBSrEXngren?=
 =?iso-8859-2?Q?93b1FMif1YZDYJo0ZtVWMxaLKmIDccg4UYlhq73Tm2VbjCczQLP3nSf/nP?=
 =?iso-8859-2?Q?+s5XVfoMR0plTpNMGNYYVMtCbCz4LDg6278cQgMfSzdjkGh+fMvojek2pN?=
 =?iso-8859-2?Q?lj9GqJbpe2h3BrRKXaGYT9BHj29MyrMzYbN+fchqmmsT2lgwYkzybjpYw9?=
 =?iso-8859-2?Q?QKS6tAcO7+MDsamyJbE=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8e22ed-1236-4be2-366c-08dafaa02d2b
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8426.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 04:38:28.6958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ndvhe2es13FdMKebuIe3EdTkX8e3xVCj5GJShUV/igOau6rgDMr9V3tBvF+pGdyaMQ9cxvECSDj+CeeLZ15M/LFlHVyigYrze89AGautUMHH4TvmA40pdFwHptx3t9U/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8435
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Micha=B3

Thank you for your patch

> Running 'make DT_SCHEMA_FILES=3Drenesas,rsnd.yaml dt_binding_check'
> gives following warning:
>=20
> bindings/sound/renesas,rsnd.example.dtb:
> sound@ec500000: port:endpoint: Unevaluated properties are not allowed
> ('capture', 'playback' were unexpected)
>         From schema: bindings/sound/renesas,rsnd.yaml

Now I'm posting the patch for it.

	https://lore.kernel.org/r/87358hj2ub.wl-kuninori.morimoto.gx@renesas.com

Thank you for your help !!

Best regards
---
Kuninori Morimoto
