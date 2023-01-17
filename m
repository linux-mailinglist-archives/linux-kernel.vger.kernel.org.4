Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CCD66DAEC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 11:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbjAQK0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 05:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbjAQKZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 05:25:55 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2134.outbound.protection.outlook.com [40.107.113.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9555F2DE78;
        Tue, 17 Jan 2023 02:25:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuFTwCryMSIPxv2bj9VxbIjZmOyGikLIwb5+a9brqiVVc+ztaq1kxhdR15Jp/8olVFKKDxAlDYpQfIl5Xd2v+9nVLKDRV4mAJ9llMDfLluchPOnWk0ynWeTuHJmwQNTLLMtDzUDMErkdPOzMpXu3qCf2WIfovlaqZcX8eK1xEel2f6kqDyIannku3VHYNIWLSq2I8XBarf7vFzd5tj1/w8wQ8vbOmfMXn9DGSNnmeG1zna4gHZKWAJMeuZjUAs3qUVsXGRJKt2yF4xjH4ltrYX5BqCOeYMkjOFRztjX3Kiy1FIFaiCjSXwPJyghDzt+kXSgsAJ8G+T8UhlgsS3SOmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G01HVv1buvOkOXrEuyd9Gl5FWj7qZWuXH5V/dOJJZys=;
 b=SCUkgvoXVF5kMKRsK9wgG33s4jbCwljILuO1vrOSG6qqXA7kIWXPOX4i2D3bObfV4pPPsr20dx0T7MRYYXR2EXRdgnUcn+7olygpz5uo8S2/O3KhU17UB5+w7NcupJ1id9NBO5z83L5o1vAs8ceV6D9zxlww26OcSo5I8jsXmje2cNQZaujkwWvMP39fNQP5bikJpQPxOLuORzqV3TG0aYCIjauz3xW9nFbZg3JL24g6S4lQyzfKtXRqL/JoYwG4XhMQdekmSaSjActj3V9cUVssOnkSmsuujDlv3vXWHR8tnLYU03zcqzEA5DhXpkedrkl8Hso/rmQYYEvEKiYlEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G01HVv1buvOkOXrEuyd9Gl5FWj7qZWuXH5V/dOJJZys=;
 b=Qr9HnAxWnVmttP1RWcpVW6esm46jn39z0uPPGQ3K5/PVJ9d7utQG2xMBjKv7J+WbIRLFiGj3FprXwD0Vb7AwOmcLPRi48AvmC0DSz0rwcR8c/w8Il0mOvdwkpZbVkDnS33dCIzN1GzsHw8TaVXDL78Z1LBqXtX0PQec+KAZ7JVs=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB5887.jpnprd01.prod.outlook.com (2603:1096:400:a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 10:25:51 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%6]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 10:25:50 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/2] media: dt-bindings: media: renesas,vsp1: Document
 RZ/V2L VSPD bindings
Thread-Topic: [PATCH v4 1/2] media: dt-bindings: media: renesas,vsp1: Document
 RZ/V2L VSPD bindings
Thread-Index: AQHY/qlsiqUPLyRiZEakeAuWQTj/0q6ivSew
Date:   Tue, 17 Jan 2023 10:25:50 +0000
Message-ID: <OS0PR01MB5922EED83E05EC0B6EEC245986C69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221122193415.1873179-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20221122193415.1873179-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB5887:EE_
x-ms-office365-filtering-correlation-id: fcade56f-dcab-43b2-dfd1-08daf8753478
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wom+nnJteCUN2ERXaVW99DqAd2aZscxmW7wUrPMnSLZJdinpJ06v9sZKWvcPEDimI83sQcsr2of8UBl8Bt9f8y1YfDwRytJ4Y5B+wjn+8AvW0fUFd8Hbz1Axtj+4o7agwIeaLgxR/+DaHWTeuUIgIgDZtp+rQjpLrCtOCYcOPYkRWb5xSCS2D4Uj5pjnKBxsmjo0siXanTr3RDMtEalvypSknv3chiH6KViq+3SIa/2m0f3zQvchMWEaGFY/AEYBNOBG68UnF6vg+/Fc+1oAfspHh+o/MBtxMVDkIQIhxDafgDd6vZdoqly4CSqSQZlYH/boVyHfqKpSxn+ThROsrxokV33iv9uEP8eSXYFWfv0B5T7lovZXdyjD9DjSZQ53uD+RrNO66caQw44Dy0hv5VU+ZmZDNCgACSmES07Bti+utnPOrqlu96ZO34ILtDeX2MotUImIM+WfmegU6R+a9X721sPfZgVeNBq7cI7oTbUZqEoWKzTYFtXrpUvvqVOb6hfLfqr5BIq2PoekzqnPxrXtwnHv5KpqRkDEcM8a9gHXQVsvYEvMHlN3uz+lGEky/KP4VK02wubQiIFKpPXjtAdcyb4RNdCouibQe0t7EUV1aIaT6q8lWBVqrmkeGGVHKpLixZDe2G0eFf/qwSKwwsFkdXJx8QVlqNZTxM877FMdCJN3HCnKzm7MmiTp3estsgcdpJWNIzybiJf2cJMSNrjC0R4viM2PA52SwUr3Rn5thnyIcqSoCAgW+tlcPqOfqoQuKgMghiyhxwso6+I2IQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199015)(83380400001)(33656002)(122000001)(38100700002)(66446008)(52536014)(86362001)(38070700005)(5660300002)(55016003)(2906002)(4326008)(7416002)(8936002)(66946007)(66556008)(76116006)(8676002)(66476007)(64756008)(41300700001)(186003)(6506007)(26005)(9686003)(53546011)(110136005)(71200400001)(54906003)(316002)(7696005)(478600001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6L8x1m4Gu75arMmvM0S9n+bYUbFGXfKlKmAY0GpOZ0veHov/muEwx1B9KxMY?=
 =?us-ascii?Q?0TPrIaGTiNJ1Xb7SfvLl6i1K4Ke2/ECQ4Z4dYsftyfu/IUXpMZx605feiDU8?=
 =?us-ascii?Q?SYCdWADh6Hsi9lHHzOszsm1BK4v3Dubx3aiSTZ1WK9fUqoHB+sVqP83McnAN?=
 =?us-ascii?Q?XetYAhaIVNJ7JM0WMQ1EP0U1RM1Cmisd3TN6G+t43cBFp/RHW6svHKunOtK6?=
 =?us-ascii?Q?W/RUUV9yHFJtZB7nTktVaf41PMb1eY4DV5SR3a/I929fsOYPSStNn0w/JmQE?=
 =?us-ascii?Q?mxlKP6OU2CaZ4fsbqBquvWbgwHRCNIf3Z5KLmJCRW1SXKBc3QL+4nJ/EWTlW?=
 =?us-ascii?Q?+lqLiJ/AeZHuUzFhmSMQBl2UdUPdnMG8+9PtrLDw3HALRU2xuv8u9lkiSxEy?=
 =?us-ascii?Q?iCxHLv37lYnxmetg0weJ2k5k20wQFgLuV+RgmIZHuqNtoaippolcYoyAHgec?=
 =?us-ascii?Q?n8vXiiT43q9JWv1xdBG2oQs8cn+aaFSsXrrUmBDIW+eEDdbnitcpuZTDgihL?=
 =?us-ascii?Q?4t1dM/0oUXNXgLWVY/vgE4wASa5I17iEJmeBKRRyLW/qcqYVXq6cQ1MX82in?=
 =?us-ascii?Q?QeG1BKVefXZHMpuPkPU1CEAcjxt+5VzTJRTijaj6+sf/QmZbWFqtTvT3/2ra?=
 =?us-ascii?Q?u16wZ78bh8CeLeAVLvoPNWSDTT0CKiLaTt8gqP+A4ysRMcE23Kc03JtfolQ3?=
 =?us-ascii?Q?TtEMRw4NGM70wEKRRVOvOOLMVwg9POtctbFWU5E/Nxn1YTUtCOKJPelentzD?=
 =?us-ascii?Q?Z0MSXpF40fr7JuxHMYYzIM4wKVuHYCSeuJOnu9YkJZpEjWHZrf5ANlNHdaje?=
 =?us-ascii?Q?1o2rpLCueT8p1BZQPAl/5dTWE3KJw0JXnqJwcefbYu9bdVEUrbVlVd/cOPaE?=
 =?us-ascii?Q?j9R2tl2a8rEpIR16dmPJFhWzQG0Fd+8Edc7cUhLskNj5J9zZxnmv+T5QjCw2?=
 =?us-ascii?Q?kew40ZsRTN+LHdaKxhRDmFWRpVW2yxzNr9j7h6ZqjI5aQRdDYoLeQrMc8bH3?=
 =?us-ascii?Q?qUdVDmBLd2uVVE2gRWGzuI+zIAWumJ8CYS2UhQY20CMA1ht9LFrgqjwCgjeN?=
 =?us-ascii?Q?NnHI9ZxgX8qVtRcIFJv5bWnFGwwDDju2HQ0xyR/56h4gVm2/QAv/YiHu56p6?=
 =?us-ascii?Q?GZt+XviZcAWlwBsp3dKpQdatMWRI8uuPwSszhdThfXLN0vAQ6nOpJwf0buPI?=
 =?us-ascii?Q?OhwYOU1eTE5y4jxNMoQmbD4dW1Rn/Xc9fZD84v+nYYjnm14MlGyr/moQhTbg?=
 =?us-ascii?Q?kOsZtN3XGUm0Fei36wa4P8abOqRrG0Pm5bxZ2bHarHfcONkkoXmFl/nPUQPn?=
 =?us-ascii?Q?x3HJWktLMTG4r8kKRgibD6MbZLjwBM7zsUs2KUXtJXuo3OLkwE8MdW7MNYih?=
 =?us-ascii?Q?tHRMwhZVo6mYjFjYhQTWGEFbP+EbwjtfPKc4lECgRk9G0nebt1/v8EzoF8no?=
 =?us-ascii?Q?Wp2XvxbNJTvKe8COXzb4TjrTCEe1NKjAoQPplCreSZyJC/dw7Raam3iT/DT2?=
 =?us-ascii?Q?Yxn9WBYCKavDEjxXM7r1Tl5mV2Ph7Kdv9DnVIaDz835WHXeIshhjYIt+QiZH?=
 =?us-ascii?Q?FHWX4lOecrDnEQmyvekjx7Y5L7ApeZ9RFRYFzE39E/2M+r2DINvS0+bXQBr0?=
 =?us-ascii?Q?Pw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcade56f-dcab-43b2-dfd1-08daf8753478
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 10:25:50.1389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tIQlUASGUfqmMTtYHZj75irSFTlJDT5S5YEhoITawnMrkZE6u2IWGDHJzi9HOfhNQJ0m2smDz2sF0G9k4gf/Ba2muytOewAJmaGy28prwK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5887
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Gentle ping.

This patch is reviewed by both Krzysztof Kozlowski and Geert=20

It is blocking for accepting SoC dtsi patches[1] through renesas-soc tree
1] https://lore.kernel.org/all/20221122213529.2103849-1-biju.das.jz@bp.rene=
sas.com

Cheers,
Biju

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: 22 November 2022 19:34
> To: Mauro Carvalho Chehab <mchehab@kernel.org>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Laurent Pinchart
> <laurent.pinchart@ideasonboard.com>; Kieran Bingham
> <kieran.bingham+renesas@ideasonboard.com>; linux-media@vger.kernel.org;
> linux-renesas-soc@vger.kernel.org; devicetree@vger.kernel.org; Geert
> Uytterhoeven <geert+renesas@glider.be>; Fabrizio Castro
> <fabrizio.castro.jz@renesas.com>
> Subject: [PATCH v4 1/2] media: dt-bindings: media: renesas,vsp1: Document
> RZ/V2L VSPD bindings
>=20
> Document VSPD found in RZ/V2L SoC. The VSPD block is identical to RZ/G2L =
SoC
> and therefore use RZ/G2L fallback to avoid any driver changes.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> * New patch
> ---
>  .../devicetree/bindings/media/renesas,vsp1.yaml     | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/media/renesas,vsp1.yaml
> b/Documentation/devicetree/bindings/media/renesas,vsp1.yaml
> index 7a8f32473852..3265e922647c 100644
> --- a/Documentation/devicetree/bindings/media/renesas,vsp1.yaml
> +++ b/Documentation/devicetree/bindings/media/renesas,vsp1.yaml
> @@ -16,10 +16,15 @@ description:
>=20
>  properties:
>    compatible:
> -    enum:
> -      - renesas,r9a07g044-vsp2 # RZ/G2L
> -      - renesas,vsp1 # R-Car Gen2 and RZ/G1
> -      - renesas,vsp2 # R-Car Gen3 and RZ/G2
> +    oneOf:
> +      - enum:
> +          - renesas,r9a07g044-vsp2 # RZ/G2L
> +          - renesas,vsp1 # R-Car Gen2 and RZ/G1
> +          - renesas,vsp2 # R-Car Gen3 and RZ/G2
> +      - items:
> +          - enum:
> +              - renesas,r9a07g054-vsp2    # RZ/V2L
> +          - const: renesas,r9a07g044-vsp2 # RZ/G2L fallback
>=20
>    reg:
>      maxItems: 1
> --
> 2.25.1

