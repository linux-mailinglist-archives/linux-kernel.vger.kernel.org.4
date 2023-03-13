Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EBC6B7244
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCMJOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCMJOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:14:34 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930255FFA;
        Mon, 13 Mar 2023 02:14:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMDwXAAePH17SwSSxHImJREizTls1Dytp7hiPgJX6LHbPlEqrFgofX+AYEeMYA47wwePW9TA1bDCcPT7C8EGrIwm0g6fDG8jmuet95HAtP/pax6Pspahf7z7cG6IlX+W4PPam4b/5dBT4DPo9ReMuu2gApjnfq49qpmdZLpAv/vZnNMnCzDwGWmPx3HVvSm6b3JPiKOL07QeVYp5Lj2yAvkCjVIh8vE/IMb1Pv55bi8lEY/NswTDi/bZ3BrBSLG3nLZL9NomcAsVgFDKEf7OneNRh0VxjMobKr7nbQQenGozu+9hKrcN2kRuMx3fHmTlmuFDqzhaNlytHAY6mYwVvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+lDFJC04MWM1aBeWfpGs/RJfvG5yFS6RGEY2rV2bHw=;
 b=l9OfxEQvFMLiFNyP9suJ5jjiOeHrpaHOtjBK4AFQmT62Wz46dQJvn7aS2BqUbdmfdgCPVWlmPQxT/kWaKp4kKLxM6/QT7Ze0YuEAbCmZ1PtxSqcBQDjwLOy4vY0QVia0ZCajlHJ9ycpbSyj/k6lg4EEDNi+pCbceUfSYYAr1hFaANda9n+vKjun5iRUYZL3tMF9lvW989t4QN3MPF3M8Za8ySGXwNTKnUVObedhqOWr1I7SYrfwE/KMHo9hKh61Ona6IJdULZWIOhclN9km6QynxnWE3AGk8+bxSdFOiGdfb4r3uy7OrblC7Vas5B15nzDSjYW3if04AJUZn8RTLnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+lDFJC04MWM1aBeWfpGs/RJfvG5yFS6RGEY2rV2bHw=;
 b=IPhDt5yVAO+JodGsnnTT69QM8j63snVh9qu34ceiBrSdU7vXC/Qmwdg9tN1StIUep68TnIPUVUVpuT3dF4LLr2QOREKC2LsyaNoZZNUfZtIPrT2PSAmj+EUcSnyLXsyZMPsbn/gN/aJTWpjMRrjn/SHTIhCRWindoj5nQ/X0y6g=
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by PAXPR04MB9445.eurprd04.prod.outlook.com (2603:10a6:102:2b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 09:14:30 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e%5]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 09:14:29 +0000
From:   Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
To:     Varun Sethi <V.Sethi@nxp.com>, Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] crypto: tls - Use data directly in completion function
Thread-Topic: [PATCH] crypto: tls - Use data directly in completion function
Thread-Index: AQHZUzs1GrLLqVso40eqVqf5w6Qskq74ccXw
Date:   Mon, 13 Mar 2023 09:14:29 +0000
Message-ID: <DU0PR04MB95639B763B060C2AEFC3F64D8EB99@DU0PR04MB9563.eurprd04.prod.outlook.com>
References: <20230310102912.1966201-1-meenakshi.aggarwal@nxp.com>
In-Reply-To: <20230310102912.1966201-1-meenakshi.aggarwal@nxp.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9563:EE_|PAXPR04MB9445:EE_
x-ms-office365-filtering-correlation-id: 6010b8ed-af92-4c8c-5b80-08db23a359d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pVD4QKcD6GWpMJYRVFPHWql9D/C6VqWVD6FOi9LofSXI8gSVETZtp8P64I6vQQpPHMSoBDxAPaaoQw/ia20ne7YrtqSZNmGdqGgodMJPf6Abgsk2Hq6JSYmIwhdYJhEtPF+TqMUb7C0bXUFzZQt063H99BXmjHFEUOAtSoY0HlXm1lNgrCgiZtVVSYnMgktm2/q4oU+mnwaYtWnQlpqgynqPvGx/y7WOnXjqrJ9AYenYNG9IgxZtmKsinEuiI+tiSHBv9QDBtbz192ITp9FOZu2g+Gl5qK3z2DeUIl3VLuKMhcgKIM9qY1AtHJgKoFNDbbw599B+j8jyrmGJnk1GYv4oWW4c/JMBpWGvMf7cUx3ngIc7iXaBLYtDc4vfArBOtzNAbV6qP6ifaUcFCMb5yOQ4EDzhi92+QlyVUpYl82spp+ew8oIHHzYPEHKobahLGWtgoaDKPDMbRU0xP4+bMNl3DUGg59A9pRaghZ97yNQWvEH1goGXO6zttbORGBirRMNvQbMJSpVNOJjLC9acOPrkUDUCdJVUP9lWhfcjjn+0EVXNZczNM3AUrHK44rHP+9vXuOw6U6eRhp1DEttAUottJlNOPYYH/yPC1GUFjHjmfPCG4xLrdg+3Ziqth8RMqa2EaDv7xUjkV6e2QHO1MmqVqTxi11wtNNqBezgJ3pZbSRvq1c2RQPITUNx8urBOIUnMhfncvLH8VKMhUjCbsu9qnkEVXcsGGM6UJoIunlA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199018)(86362001)(38070700005)(33656002)(122000001)(55016003)(38100700002)(66476007)(66446008)(8676002)(76116006)(66946007)(66556008)(64756008)(52536014)(41300700001)(8936002)(110136005)(478600001)(316002)(5660300002)(2906002)(44832011)(83380400001)(7696005)(9686003)(186003)(53546011)(6506007)(26005)(71200400001)(2004002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j5fPXU2wlayudV8QmXkJPERXYxb9qG30a2WsRy5h60VeN8IhAtd0szD0Sf7k?=
 =?us-ascii?Q?ZW2LgR7VshKtpHN6RoU0eJ5X01vKwJ0+iK3rZjfuqybFNM3S89G5EZa5hnA8?=
 =?us-ascii?Q?rGZPHio1UkzrU/fbDkJfSFaBzor+ulM4k0FfTwanl+d5cQaDmJF416qZlmQI?=
 =?us-ascii?Q?wIzLV0mBOuk313LGpcBQdPij6ctQJ+Kmp+BSJ3UhfSNtG3nQh8l8nHEsKoDd?=
 =?us-ascii?Q?7Mzx5hKIjGKC7y9qgR1cM/D5bNx3HMlSUIFhGHr5ONsJfTuGeQ+lOKRHcEr9?=
 =?us-ascii?Q?ryw37Re5wQVq1cXZNT1+6YjDNqpW6Wz+G3i2cTXrzPg6+TvXm1PnEFbgeBLc?=
 =?us-ascii?Q?Zc2aP2hwfeyP3w56wkR1WG7K7KIscJTrAbahmi/v5mHumH/WXGT8pPwwyoQr?=
 =?us-ascii?Q?HCTrkCFYceQASK0grj1EDe5x1wJEkK47W/FnBtEBnhIRoVPr3YYXmeHUs20G?=
 =?us-ascii?Q?lfyEZ/Zdeu0PJv07VIHP0lvCC89d7puYq50DqLUsYboW018aiaUF3sCVQWs+?=
 =?us-ascii?Q?+8vXY+IAMqe4i2SZ2nbm7zI9+38OIEoi7e/cUci0DxJnWs5pr46fhWGFHMB8?=
 =?us-ascii?Q?XnHLPHNRQz5omt9ZrxuArI5TiGv96bEAEwj/eeiYS6ipHZc/Sp7buj5PMrzd?=
 =?us-ascii?Q?qbd638NKf2L/w3UhmVc4J0yed23Z2BK2JGM+7pq6lPA8UV4TpkB8RHkHyfxy?=
 =?us-ascii?Q?WVljAtn73m6GqDfVeO33UQ4oWTb0utGPiMqf4aKiKipZDLAUvXsEoZYvaDcn?=
 =?us-ascii?Q?C9DajhYlf7TsGxjynsNCw1S7MjNTt44qFoVEwKn0WfMVsn12XikZpmv3uige?=
 =?us-ascii?Q?NG+CGtBxd+8aQ9/aCxILa8m4g6AWn1yRz7NX0FKbdWfAU9ZFCptXx8HIgTu8?=
 =?us-ascii?Q?B+VF80RkwiHhCqBvCdKLRLEoHROqFVzhbHHQ4fsrULpX6gwf4Lyc18chSomv?=
 =?us-ascii?Q?fXoMlvselZoD0zO8vwiydLlnkBTgnN4RCOnmcy4HBwdh20PXnuHW/QnZloot?=
 =?us-ascii?Q?x8Cc9OxqfnAjJW17TCyyK43idmUEaFmgqgvTIqBT9pl+9Gg+YXykAAjD4Spd?=
 =?us-ascii?Q?ebXRex7TP8k5nxnuPSONtp1YVLC1E95QnWi8A41XrKp9knHDdVJBsf17nXOB?=
 =?us-ascii?Q?ochxtM/Qne2+jBrjJFOinSdev4X1YDHz98vCMX7ECAIiH46psOgHoxcTyA3W?=
 =?us-ascii?Q?OGLnu8fNVzXwA/p5DbVgSCy55RvrIJnoZU5vzZ57WnjRFKWX3MkpbICTFPf8?=
 =?us-ascii?Q?d4fJVRuSMqzM5AEmnu2FklJgn+Ai+Tu6muOLVejY/USxJIhDGeJJBy5kuV2k?=
 =?us-ascii?Q?+jc2h0Q5twTls6IZrhuMW0igDa0cp93SNUi5oZGH6/ZSLj4vek2O5GIRJ9ss?=
 =?us-ascii?Q?x24JWBNnBjTqwmiDzWKcGypQzxrskab5+aezZN3CHLOI3X9HnFMDMWg0lgsk?=
 =?us-ascii?Q?swLDuXFkQN/t8b+KUQ590us+LMyIhkd2br/GxoqDXA1D2dBvUeUjFhBt8xcG?=
 =?us-ascii?Q?L+ts3p1K+pscKoRhVQnsNw2I4aGQ3ncnMB7/ibUWCpmncescGOX1AVO9J+Ia?=
 =?us-ascii?Q?5+zb9WWbOqQuiACr8uSU8Fae12lav5GAVBH6ywsEztj/FMzt5zG97Sa7gGyV?=
 =?us-ascii?Q?bQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6010b8ed-af92-4c8c-5b80-08db23a359d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 09:14:29.3678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Nzhd+qopwQzD9pjdHxRERxhaYrjTV+jgyTgPGrn9l86l1K6fcg78DcXdXAznLLIhdyEV8AVomAIJlRYOIf+RpiXepwOecBSuwgjLpe8fv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9445
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't review the patch, sent by mistake.

Thanks,
Meenakshi

> -----Original Message-----
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Sent: Friday, March 10, 2023 3:59 PM
> To: Varun Sethi <V.Sethi@nxp.com>; Pankaj Gupta <pankaj.gupta@nxp.com>;
> Gaurav Jain <gaurav.jain@nxp.com>; herbert@gondor.apana.org.au;
> davem@davemloft.net; linux-crypto@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Subject: [PATCH] crypto: tls - Use data directly in completion function
>=20
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
>=20
> Facing build error in building tls
> error: passing argument 3 of ?ahash_request_set_callback?
> from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
>=20
> Issue introduced after changing prototype of "crypto_completion_t"
> function pointer in include/linux/crypto.h, conversion of completion func=
tion of
> tls was missed.
>=20
> Changes are done to use data directly in completion function of tls.
>=20
> Fixes: 255e48eb1768 ("crypto: api - Use data directly in completion funct=
ion")
> Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> ---
>  crypto/tls.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/crypto/tls.c b/crypto/tls.c index e04f3b450b43..f16810238d1a
> 100644
> --- a/crypto/tls.c
> +++ b/crypto/tls.c
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright 2013 Freescale
> - * Copyright 2017 NXP
> + * Copyright 2017, 2023 NXP
>   *
>   * This program is free software; you can redistribute it and/or modify =
it
>   * under the terms of the GNU General Public License as published by the=
 Free
> @@ -50,9 +50,9 @@ struct async_op {
>  	int err;
>  };
>=20
> -static void tls_async_op_done(struct crypto_async_request *req, int err)
> +static void tls_async_op_done(void *data, int err)
>  {
> -	struct async_op *areq =3D req->data;
> +	struct async_op *areq =3D data;
>=20
>  	if (err =3D=3D -EINPROGRESS)
>  		return;
> --
> 2.25.1

