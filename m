Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4D374DCA2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjGJRk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjGJRkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:40:23 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2064.outbound.protection.outlook.com [40.107.241.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD85DB;
        Mon, 10 Jul 2023 10:40:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iz0gLZCNVZ1cfEUofHB3RYr5lRFVcHLs7fUmXUkLjkkMxZI00gVY+XJHlVk0SAT48ex5QJjtAbUJwu2tvfFZIrghZumaQvhH0D7S0IqEMIc8mxu9JQHYbCG0n1obB0Cl2IRcjJ8iiGPHP8h21K57knmnyqsMBBTQ+QZOUi3scdQ7QRfpLZAVjle0F/LSgpWCDGV7AO75zkHLDyfPMCQjnFQ7CP7WoleX0B/r1LBRyjmikTWn6a+eSRBFtHhby0Vq3W2mkJ3NIGT1yP5YAoQGr/FiwynFeyTXiHj+CvF5qBqVHRqRY2ye+E1yQGfsFR5weYCJ+Frqkege9ARssH2HIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJioDzc732b2F4V7vACI3QCNSYCahyyueb7jG6d11C0=;
 b=eM5w3vtOedwWN/FnJT3pkF6satAwhBO3m+wOSJZIZvtnq6fCusET7wBRKbGKjkGWPVJq8XfJh9BnjVRFqScW78lF7NXcpYtO3pllKajaDYC/H5X4ikYV+Kj2R8Bg5TM9mjyzGm1ILZCq9xLoZXO48lK30C2WLIqo2cjx66ewkpEz/RbPUgEOKkWcQhrI792wHtPweBhhLhYnhHH6NIqon5mdXA9rChR3DxO/HPVuOBjuqIjpdnrCZFxQ4KAB4zu1ZVLRi2c2mD1HjFgNOnypZmWTQjtn6mo4zW/+Im7Tmm6Jj6QGYa8pTe11+ipiu23T5BIiaEiOUABNO58nBVguWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJioDzc732b2F4V7vACI3QCNSYCahyyueb7jG6d11C0=;
 b=lFKudjor9SHfGIyF2Dm+BPPcRgJG232QXm0DdMr73BZcCwM3B0fVoIMR9aBsKMNwy9ShlRyoxp0YIhIysLcRv9HE234R3gtKqlmU/oU1TUDvZtYOX6boUg/QhUAUG/rxZbJU/nJRoglUVeOSnfV2zMJOLeHxBeWkY7Nyr748lDw=
Received: from PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14)
 by DU0PR04MB9323.eurprd04.prod.outlook.com (2603:10a6:10:356::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 17:40:16 +0000
Received: from PAXPR04MB8638.eurprd04.prod.outlook.com
 ([fe80::7650:27db:4ae:b7ec]) by PAXPR04MB8638.eurprd04.prod.outlook.com
 ([fe80::7650:27db:4ae:b7ec%3]) with mapi id 15.20.6544.024; Mon, 10 Jul 2023
 17:40:16 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 7/7] MAINTAINERS: Added maintainer details
Thread-Topic: [PATCH v3 7/7] MAINTAINERS: Added maintainer details
Thread-Index: AQHZoFAhFvgf9BJ+j0GVxXYODBVyba+zal9w
Date:   Mon, 10 Jul 2023 17:40:15 +0000
Message-ID: <PAXPR04MB86384816166737DEE7FEE8EC9530A@PAXPR04MB8638.eurprd04.prod.outlook.com>
References: <20230616181144.646500-1-pankaj.gupta@nxp.com>
 <20230616181144.646500-8-pankaj.gupta@nxp.com>
In-Reply-To: <20230616181144.646500-8-pankaj.gupta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8638:EE_|DU0PR04MB9323:EE_
x-ms-office365-filtering-correlation-id: b576274e-3dd3-4e6e-0a00-08db816cb8cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CkzR86Ysc75VE9E3Mw/Zd4bZJqcBIOdWu2BJD/nLBCryhhdI63Cd5i/wLINyGCrc2tnGDbmLV4W3jhdGp69C2gLRz1xXrR7J/C1MkvSNb2OAiYJVfGuTtBXt6Jc5h4LHRYhrq9t2VAZylbF0pvJwY5at6aTJCJL3Odu2INKtRhIoQRoDjJ5828gbEbL0Xr45ZycCxd/wv2pMdl7mztRRZC6RjdwPetlzMj0JLuLmcDr8Em8xbMM171USrGzcUHxVoDlP1EjODGIcZzyo/z6xuCl51FX5fMW/ucLUI9I71IrewJAbh3mwe4rajCbDiyMYx+qmKujtYiGCDjlJwXiEMYZ58/74y0ZLlRSRvjlr+CKNmKcIgtY/mWc5m3IcBYQShHrst8LcVbwmpHZ7P3lEIPTbSbdzPXEombuKEkKEca9EM+JOweZrLM3uCudMytXXmyNva74MrZbYxJvaQw1csq0jfSBGkdydA6lUWsNymvmwTMEeNF0Un0uAnL3xZjqfyc6pYyhIo3+rfiMRuW+XqCuOr8sUJMOWPbW1w/7JrrVf0SmY874KzqiDdRkfnOCu39tT3C8Dkhp3FfQSXvCfVuxblRUHTWjJ9f0MABRs8EmW51BGIFvA7EoUC2RU+X7yxmBklT8N2jNnsqCnnYsypg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199021)(186003)(26005)(6506007)(53546011)(55236004)(9686003)(44832011)(83380400001)(41300700001)(64756008)(66446008)(66556008)(316002)(2906002)(7416002)(52536014)(5660300002)(66476007)(8676002)(478600001)(66946007)(8936002)(7696005)(76116006)(110136005)(55016003)(71200400001)(33656002)(921005)(122000001)(38100700002)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Aw54BK5BJZ7PtkYFPIXHD/TbuS92GRgCQV2dLPL4kFw44h52hXhqvwdtVRbx?=
 =?us-ascii?Q?QNRlLe8MIVhT3X9nYEhVjbFtzxkVMHVT4C5Loj+DV2hQCodIWn0mhq9CPUVK?=
 =?us-ascii?Q?kqPgK+n6oz+JZccZIOjJfs4hCZ9R2yybPY4BsEwwmkKULj7wCq72Ylv/zioq?=
 =?us-ascii?Q?/ctfnFxCUuUIsIAUVakY0eVIxp2N8xvNmGuKnEutRZWsg8o16tu63GwhNIdF?=
 =?us-ascii?Q?8bIrsn9UqoXbO5V1tjZZVRF+r4TSstIsc1pK1Yu8RpXXx/Y6PlsH9A3T9jzV?=
 =?us-ascii?Q?Yb/uLKoOJahZ8bnabDaz9a75HHLV+pY54ZZ9+XC4He/kTNkr7Hf/UyWQ6PHK?=
 =?us-ascii?Q?EXhq4HCI/lYUjH7ZgNt5/lSkC+HTR3p3/K/OBFZOpQkGUz4fXX7rBYoz+S1q?=
 =?us-ascii?Q?CcDA+JLggJp+P5RTK+OHVbB9lZG/MSJyiKbcH0UB/D2rG33EpS6+rpwPlrwE?=
 =?us-ascii?Q?sLUWy/HH7IuSGUn6jeRejRjd1u8aCt7XJYMfekbofXegfvsfYSnHqkxbLQd0?=
 =?us-ascii?Q?ZZFPtR9YhapFhu8rGwuFKhImYNxjiY7hM7M4/FIScV63I5WnQVmiV7KcXNxh?=
 =?us-ascii?Q?sH+SGH17mmJdu1Q90A8wGuSelBOfUrZFtC5vzApAKlqFzQRPql2Is3Gwsgkt?=
 =?us-ascii?Q?peFCRmqeJXbki+KMDc03lwgHgoohNZQqzqqhXC4nGG3cC/IKJVLbqSLT8aKs?=
 =?us-ascii?Q?03a48QWvAW/5xtkKCP5zHPiad+YEM52M34+sjitC5YsUSi7zOZu3OplKELED?=
 =?us-ascii?Q?oHc+nxivBDah71P6fNgYxVMH3/mSVMi6ZQEKuUcVOhqgTrbUjVhkzbwP2XkS?=
 =?us-ascii?Q?gbW789qr8Uej5fyYxbTGzfWw/cs7XGEPYvE4i9ig7Y2UpHRTmOEFvnZnI6Fm?=
 =?us-ascii?Q?6zUnPAxCRXyuFqEr22IK16t6l6fGxKmlYi4Y44ZEgKgJIW1qfQwETpLEc8Bv?=
 =?us-ascii?Q?C9plyHvvYwepWcHxxk0iaT1PCla2H7/s9pzSZDzUDVMc15LPS9Nz0z0a9BEj?=
 =?us-ascii?Q?QGQ5EYoCXCiId1xjHhbcY7tkwX/AbF0zzOS/GfcbIkQcHRmkPtc68EsaB/mB?=
 =?us-ascii?Q?5BWrRXLe57PoafavDUcPQwGkaLDOHWN8r5P6s6U5PuZRJRQVUbxLgPbg789w?=
 =?us-ascii?Q?1Uth3mksw9INqDDKTEZdxypnzUn2vrjq60af4vWFZxCeMMrbb9vBACD3Od33?=
 =?us-ascii?Q?GfCNRUV55WjBY7uj6lYR8ysyURSO7oIt2iDXQLMKqbfqosuWDISDufk5Yslb?=
 =?us-ascii?Q?yiCYjL+Jhf/Nn01ulqQudxPjEE4w6++tBNqLo4FCsOv2Rcivd9wRGb9cYzcA?=
 =?us-ascii?Q?hIbJjwxADNjgAgclVWNdoTYZ1fuluyyZdndnORxygzBoA8DpzsF59hs/s5Tj?=
 =?us-ascii?Q?2k6hWR7DKMkUVSaWZRdGCxFAUu9Dg8dbwTW67dkMyhx4zaR38SaU4mbPqoPa?=
 =?us-ascii?Q?yHrPg0cJQ0tDOemv8pf6/hYEgI27krRWLqUTLxiwrvHT+iRenoazw7gBm+Of?=
 =?us-ascii?Q?HjBeZi8cPZGLwDpdgShxsIbKp6m8oW0tJ8Z4kjgfxvazF54sqVziyPIg6Nek?=
 =?us-ascii?Q?uuy0U29BGQRO44DsVRIaqQUXerFFqkyv1llm0nrH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b576274e-3dd3-4e6e-0a00-08db816cb8cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 17:40:15.9772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SaE9uCR7OG12F7Bbo3CT+PHNr0dJUSUJKPhGIxmLbgnIaUS25PCLzilC+ydtFZVUBqoBaiLk/t3vIa9ehEZkJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9323
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Pankaj Gupta
> Sent: Friday, June 16, 2023 6:13 PM
> To: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> conor+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx <linux-
> imx@nxp.com>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Gaurav Jain <gaurav.jain@nxp.com>; linux-
> kernel@vger.kernel.org
> Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
> Subject: [PATCH v3 7/7] MAINTAINERS: Added maintainer details
>=20
> MAINTAINERS: Added maintainer details for ele-mu driver.
>=20
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6992b7cc7095..21a7a5604436 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13536,6 +13536,15 @@ F:	mm/
>  F:	tools/mm/
>  F:	tools/testing/selftests/mm/
>=20
> +NXP Edgelock Enclave MU DRIVER
> +M:	Pankaj Gupta <pankaj.gupta@nxp.com>
> +R:	NXP Linux Team <linux-imx@nxp.com>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml

Accepted. Will correct in V4 patch.
> +F:	drivers/firmware/imx/ele*.*
> +F:	include/linux/firmware/imx/ele*.*
> +
>  MEMORY TECHNOLOGY DEVICES (MTD)
>  M:	Miquel Raynal <miquel.raynal@bootlin.com>
>  M:	Richard Weinberger <richard@nod.at>
> --
> 2.34.1

