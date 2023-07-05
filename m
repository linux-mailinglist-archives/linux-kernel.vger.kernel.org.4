Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE4A748F11
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 22:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbjGEUk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 16:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjGEUk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 16:40:26 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338C519A9;
        Wed,  5 Jul 2023 13:40:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwcP8j7rfWjxJz2aT7uxY4mrxzR9HDpb1v2Eo5VThv0aDAzBDWRguVXY+elmuW1UUOgJAL4o3N1zllKUsqf0VPwIphtYgu00ejPm3ivSF+wG0WGDvbbjPPdvq5oOZnqrIlhnLS6viCWXT8sWJaJ5zqjyMPm+D4gHVAe2snfiVldT8d+wZZ7HfIRPT4rxVBdNcg9jphlTasN+7g0Lsr3ALWFIKfc9qtoh+5QvQeYV+ALubKiZ32BFy7aHxeicXA4OLoP8gBf5f6uXKKpDR8FBww87riCdDTKfStM0hEa+PSiiRJvzzSdgux4nYKacF12V5cyhO9WEV+TGLRbU7Ubaqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFB05Vs4tuNxpfwJ1Hxop0zJzLxAytTQsIINUjsyeHE=;
 b=ic74bUFqIQP2C4HXhof4nQSoQl3a/d0LGp+zz1neFiFV+INfaCV/T8+vdLmG2hDMyhs4Q3HaNCjHozGVd0g/z1DiGE/MuFzjvhQ6LB8JAqGVkssCOTAwi79C23p6k+zDzshEKA42cUZEj0+ZSX/pKV6dwA+pfw5hLfbiShbVBCaXdXmrX6eXjXdp4hcI4DwuSDagPwL8xM/qh6UpWjKIOdqbx3rUP9cJYkEoNWtDM8dFDnqtc1WIuZhotI7XEo9KJOCfVkpubZe/rjXOPJe6zquJyil9UiwBaeryr55qD1UN1ZF+MGIZ8auPll2mGSsirZyQCnXM7UZQVV0mvvZPyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFB05Vs4tuNxpfwJ1Hxop0zJzLxAytTQsIINUjsyeHE=;
 b=VaL2CaZ6DByWUl2PXMrZocpWn4/PFWVRUEzsGSHQpb/D8sK2tws9xAzmFb+PcjmHMLouuSAolPCzlHXBU099yNqdtnX2yWbGplW/23TZQQvR6NpaOaIQexdt76Jf5ycgkSp45R31MfMcx3Je7Ro4rAVW/ZzOQXyMLW4rJgSQD5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB7569.eurprd04.prod.outlook.com (2603:10a6:20b:2d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 20:40:22 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 20:40:21 +0000
Date:   Wed, 5 Jul 2023 16:40:07 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     imx@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        coresight@lists.linaro.org
Subject: Re: [PATCH 1/1] arm64: dts: imx8mp: Add coresight trace components
Message-ID: <ZKXVJ1U8UbFSrsqM@lizhi-Precision-Tower-5810>
References: <20230505195151.1874071-1-Frank.Li@nxp.com>
 <33362029-3d5b-b16a-27e7-578df34f0ede@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33362029-3d5b-b16a-27e7-578df34f0ede@arm.com>
X-ClientProxiedBy: BYAPR01CA0011.prod.exchangelabs.com (2603:10b6:a02:80::24)
 To AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 15973e25-37bc-47d2-48b7-08db7d980d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZTW7No+s8ldjAVrNf3P8RS+vDyBPZSav/eHYMSrdY4ia+rmzoGU0gsemTIPrU0B3GJVvNwwG/uygxyxC+S74goK3xOia0XVG5IdqYL+5+3RvYbjfx+atTogQGDsc0B68H9NdterpQFCWhy9Nsow56J/3zB5Y4mirocnXzCcsabpeOp1j3ZgPHYmUrXQgafEPBASjuvrLoZuTUKwssDUc8zhqPTLkO8s7WFJ1qWrE/n7OsBnQrwkRip5yAaPs7mqzaND9LfMHwxYAghqD7GEDT+WmLOY9659HdNwhk07FFslatGlik/pTflwefZxpvTOPPFzrzKKgtPSN+x/YlXbl3dRrz3YEjjZeaKH2d/quaDwlk7hkpf2AfrjEVbarPozFk7INiXB5vj3ETampUWP3lZUpFC382r1kJUSeapjgkQaAxFOgJyKuP5YGrCMtgI8TqO9QtzZUgtbW1IOVw93v+8X6sKPRCM7vIz69F6nRY0uaI/QMdUaNFFcLqtCXrD+uBivng9Wc+mBpDXnfniUiU4WDxpeO45W3tWntDdoAbnG853t4VGrKFoRtVILtyQsiN0fGtsIE5pQQVoz4oIJ+g/u3vgIwxHU5C0h5j8I1QGjQQlPrdOWvPvr19cAuHYWIpa+6V1cQUKDyDPVAkc8F7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199021)(5660300002)(7416002)(33716001)(8676002)(8936002)(41300700001)(316002)(2906002)(66556008)(66476007)(4326008)(6916009)(66946007)(6506007)(38350700002)(38100700002)(86362001)(186003)(478600001)(54906003)(6666004)(26005)(9686003)(53546011)(6486002)(52116002)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWgxdlV4S1NqeFF2eXhQU1BhQnpwU2JzcnZQZ1lFRmM1WVFUdEF2WVAwdzNB?=
 =?utf-8?B?SVBRbVc4dXVXVVNlZ3lSOUZQZllDMjVvK2dLTmRZQTYxT0xPd3IvSTZPQ2dn?=
 =?utf-8?B?MGgwdDkyN0ExSjR6Tkw4aXFFNmdEZmN5ZGJCYmt1ZFhJNEppenYvUlU0S01j?=
 =?utf-8?B?Y2lMTEFNbjV5RkZiY0RRWTdtWENrSVhKZXlBaGxGZE5QR1ptUTZUSEcvWHJD?=
 =?utf-8?B?ODdiV2VteG1UQTNTb1VTYXZmMW9sczNMcjVYRjl2ajh2WFJ5aU5TVzkxZjc3?=
 =?utf-8?B?MkQ3ZXE4QkM2NUh1OFZZbVNDcU9ZMlVWS1l5U05PNkNPakF0TEEyZ215NW1O?=
 =?utf-8?B?bnpXbDlvSS9ITmpFdDNqV2VwZ2FYTCt6YXVyQmlWclhtRmZDTUxCWUVNRktB?=
 =?utf-8?B?SVczL2JEbWdzL3pvQ0ZtcU9POTNkUzZvRjhVcGJIclhKL1o5Sks0K1l2REsx?=
 =?utf-8?B?RUQrWFBERTBnamVjZ2EyUzBKc3diQllhdHFNdEoyM2VKclQ1bStHYVJsT3Jy?=
 =?utf-8?B?YkdNa2twNEZoWFVUUEtOWVBHa3Evc3AvVEUwQzc0WXlQYnJRY04rMWtVdHBl?=
 =?utf-8?B?Wmx4clFDVG1EYlkwQkN3dmNNVDdKWmVUNHg2eERZdUFkR21vNnJQWTRLK1J6?=
 =?utf-8?B?TGdaRFF6Sm13QVpDZWpiS0V1ZlliM0d5SW14aWF5ZnRhU1pZYVpTbXA2eG9o?=
 =?utf-8?B?cGQ2ODQwMHV4QWZHb1V2YXloMEFTa3NBNTYrQkFqUHVqWGhuQ3AyMk5YZnY0?=
 =?utf-8?B?R1lrSXFRekFiblY4cTVSVUU3UTY5OXQ1MkE1U2lzWGQ0WUppbXRlayt5M2dy?=
 =?utf-8?B?Z21jU1N3bFNQWCsvMDluMmp2Vlk5M3dQM3JuMkM1cWdNcm00bVZpVEMyMS9Y?=
 =?utf-8?B?bGRvVU53SWVSZU9XOGJPMkFNaTlsdDkwb1hSQjYybGlmTXJsZGMwVE50R1dk?=
 =?utf-8?B?Q2lOclI1UFdIUTQ2eVhLbHVQSzUya1o4dFJjblhWNmxndG1EeEpHZm1QZTc4?=
 =?utf-8?B?YXRWYmE4MGNRQVJncDR6VzczOEdWMW5pQ3VqUzFOU1d5eWNva21HNTV6bTI2?=
 =?utf-8?B?cG01QkRidjdZV0k4RC9YNk56aTJIeFo4QjFqSGI1akJpVTZuUDdjRjZEd1ln?=
 =?utf-8?B?YnFHd2s5Y0hRZHNrUW9YalZuVldjZkViT2xZTXlucWxXT1Fab0FxeFczVzZG?=
 =?utf-8?B?VFhlb0JOV3FMY3Q4L20rTHpKWW5RWWpGQ0FVa0paYS9aa3I3ckYrcmtqVkFO?=
 =?utf-8?B?eW9MUEdRUnF2c254MjJSQTFSbzRsS2FtL3QwUjUzMU05dFZGQVhQTFFiSm9E?=
 =?utf-8?B?amtSN2hoMzdmbmI5Qm1iaFNSVXpPN2x1bmovQTg4ZGFvaUt1SGM2VDNxTzBs?=
 =?utf-8?B?cEQ1dUdhMllKajczQTVQbjBCaXN1UWcxQWxQRVp2NzdpMUJyVTljQXc5WHJV?=
 =?utf-8?B?djJ6NHNoRmY2K09hUFA4QnJMZFI2alBpT2g1enduZUtXdDRKNHJLUTJtemFP?=
 =?utf-8?B?eEtmL1RDQk5GaGROOWE3VVZwZWRzNnV0Mm84cXF3WnpWd2lxLytPc1NFRWVG?=
 =?utf-8?B?MW9IT2k1b1FVSkpDZlNnanpwdTFPY1dzZ0k3RHJzQjdJL0xqQy9FNkFMT1hI?=
 =?utf-8?B?QlNxeTliNzRTWWp6cUZuZjAvQ2Y2YjFHUm1sZ1dSMzBKTUF0eWIvbXF3NG1r?=
 =?utf-8?B?Q24yeU1yb0hvUDZxSkVzVFFkN2F3elBPTXZUWWV1Z2hab0NFN0xTWUNMN0hX?=
 =?utf-8?B?MGpzMlpQTWtJQ0NqMVhSM3FReTdFUHZ2MXlpeHhCcnJ0elB6QTE3c1l4elhm?=
 =?utf-8?B?bTlZZU9JUDd6UmgvbStLc01pSVJ1bHlNM1dJN2xrallGb20ybFF2bDJPNk0x?=
 =?utf-8?B?K05lNnRRNkJiOTYzNW1kUVExRHJHbXg4N2hES2grZU9oMWFDZUlsT1pjeTI3?=
 =?utf-8?B?NjNqU3l4ZXo2eW5XWFAxYzVDblV5V1NLcWRhZG16bkZubVI3WUY2SkVwaVRP?=
 =?utf-8?B?NnZyZDJkN3g0c09kMU1uNDk5VmhzbHp6R1ZIWldybmFRckUrcmZLaFV2Um1R?=
 =?utf-8?B?VVV6RERORVNEaHpDVzNKQ0N4VTBlZ0psSWhzQXhFekpQOGNJbFdHWWg4Yk5H?=
 =?utf-8?Q?bhweKTEWOi3U9I6gHP5oH1AUf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15973e25-37bc-47d2-48b7-08db7d980d52
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 20:40:21.7018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/8TqQ2eT0UXNwRZ28GUpNRV7jk5HGi7PJ7gd2fgsJ7JWnf1mKtf/LmaA+S0C3aYMf7QEKnJ8sJO32ltq1MFHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7569
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 04:20:18PM +0100, Suzuki K Poulose wrote:
> On 05/05/2023 20:51, Frank Li wrote:
> > Add coresight trace components (ETM, ETF, ETB and Funnel).
> > 
> > ┌───────┐  ┌───────┐  ┌───────┐
> > │ CPU0  ├─►│ ETM0  ├─►│       │
> > └───────┘  └───────┘  │       │
> >                        │       │
> > ┌───────┐  ┌───────┐  │  ATP  │
> > │ CPU1  ├─►│ ETM1  ├─►│       │
> > └───────┘  └───────┘  │       │
> >                        │ FUNNEL│
> > ┌───────┐  ┌───────┐  │       │
> > │ CPU2  ├─►│ ETM2  ├─►│       │
> > └───────┘  └───────┘  │       │   ┌─────┐  ┌─────┐
> >                        │       │   │     │  │     │
> > ┌───────┐  ┌───────┐  │       │   │ M7  │  │ DSP │
> > │ CPU3  ├─►│ ETM3  ├─►│       │   │     │  │     │
> > └───────┘  └───────┘  └───┬───┘   └──┬──┘  └──┬──┘               AXI
> >                            │          │        │                   ▲
> >                            ▼          ▼        ▼                   │
> >                        ┌───────────────────────────┐   ┌─────┐   ┌─┴──┐
> >                        │          ATP FUNNEL       ├──►│ETF  ├─► │ETR │
> >                        └───────────────────────────┘   └─────┘   └────┘
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >   arch/arm64/boot/dts/freescale/imx8mp.dtsi | 179 ++++++++++++++++++++++
> >   1 file changed, 179 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > index a19224fe1a6a..0fa74477b9e1 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -304,6 +304,185 @@ soc: soc@0 {
> >   		nvmem-cells = <&imx8mp_uid>;
> >   		nvmem-cell-names = "soc_unique_id";
> > +		etm0: etm@28440000 {
> > +			compatible = "arm,coresight-etm4x", "arm,primecell";
> > +			reg = <0x28440000 0x10000>;
> > +			arm,primecell-periphid = <0xbb95d>;
> 
> Why is this needed (and for all the ETMs) ?

Reg size is wrong set to 64k(should be 4k), so crash when call amba_read_periphid().
let me send out a fixed patch.
Thank you for found it.

Frank

> 
> Suzuki
> 
