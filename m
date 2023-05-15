Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75F87024F3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239961AbjEOGha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236330AbjEOGh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:37:28 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAD8124;
        Sun, 14 May 2023 23:37:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYabNXcJ+8pgvYl+OeWlFLsEsZImKDUO8VESvUlCul0prqX7oV+k9FqiyTfBqbK00LhSQasI2ub4wcB4ZcXHf3XlbIoDDkw7dnUNK7+/CWriyb93ZmbYYeemVgl+HqJAnHfDBnjhRZ2ykUe1MxleCjnMFcSK+0lk9D61ChRKTINSGqVwxBRT0ph+vrsmkUXmD0wuFHyOwTjG3kTxCZ7GSKJZXkK0r1+oCshzwJbKVHeiLh0NhXCJhoO/G6g5SYu4+aW/CIJOM28ONdCMyfBm9pGhnni7k4fUZvAOI8IN32jJQ88giSs1CzZzurfAJ/Ph25wu5mwgZzoVNrF7OpchFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fY4DgpYdPUhZQWAbWds7pSpy4/MIz5IidpZSRpSIwSQ=;
 b=J85YHJcEyIhHDEtmfBDnONPpG56+0oznr47IKSBGotWoit4HPnSsbeVMONMM7HpdCM0ThN1KVgETmhbmJb/5IOX/68H26aleAaVCt+3YL5/7pymexnvKEmB2NxTos00gNiyIZxNd+heqoaeMv9hXpN8wnCXkPZm1kJNz7PUmf+f8vYsTY4/gS8hrARmwUcfMfAa2M0nx9CIwrg9w8sYloDlsXNz7nXZ6K10Opb0ohmDdU4g/DZ1P0mCxE0f/KrtjA7dAPlQk8UsCbGzaPRd2tseuURzhOPc7LbKWNkRHZGHk4Hc8sJeW4ba7mfy/xD8JTOqN1Knx5Z4VQVSEsIMYNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fY4DgpYdPUhZQWAbWds7pSpy4/MIz5IidpZSRpSIwSQ=;
 b=QnP6FbydAW4Fsdzu1thY/knE83H7u3NbSuaiTEhqFWD3itonC+SWMOkCaUSWB3KqcxCxP04tI8wk1wiVuN6LAgK+4ohDu5+RiQcrl2RKepZ0NMUiQdSMfH29l6bZ3CAfWh4SocdTo82F56HZWA3jjgUtYsrR7nY8wLEqm3aW+wc=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by PH7PR12MB7453.namprd12.prod.outlook.com (2603:10b6:510:20a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 06:37:23 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::4db:e158:60d:21e4]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::4db:e158:60d:21e4%6]) with mapi id 15.20.6387.029; Mon, 15 May 2023
 06:37:22 +0000
From:   "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To:     Boerge Struempfel <boerge.struempfel@gmail.com>
CC:     "bstruempfel@ultratronik.de" <bstruempfel@ultratronik.de>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] spi: Add option to keep the MOSI line low, when it is
 idle.
Thread-Topic: [PATCH] spi: Add option to keep the MOSI line low, when it is
 idle.
Thread-Index: AQHZhBDDhXn8cTXNck2E/Yw/97A/1K9a4lHA
Date:   Mon, 15 May 2023 06:37:22 +0000
Message-ID: <BN7PR12MB280217A4D088BE2D951B9A6DDC789@BN7PR12MB2802.namprd12.prod.outlook.com>
References: <20230511135632.78344-1-bstruempfel@ultratronik.de>
In-Reply-To: <20230511135632.78344-1-bstruempfel@ultratronik.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR12MB2802:EE_|PH7PR12MB7453:EE_
x-ms-office365-filtering-correlation-id: eaafb76e-7b0b-46a4-3071-08db550ed69f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bYodXrBB1HN1aZ5p6cVEPq8FXy0lcweHYKoEEED9FiMW2SpNcJc0ApWwSbKgBpxy9ATN5MNrglVzpTHsPSsxi2yqeqdGSxfVRMmsJwwxk1sf0Y1FbnKBxrK8+QlMhn8q4fJhB6/3RCu+Zx7EiOeXCnScAmCWf726WV75ebitxi5Z5JX7meegdHQ4VOOYunlmmATAdchtVQcvQBmP4TQLLAt3xjAMZrxH4dHP/XVNT2VAkfzxlzXBygNSUmSXo8+MWf6ydj2ppVvVpeZnLAUEqAzl7aohqLadQ/vGK2+HfB3Cez2IDYdGoyNHMRO18PBSZCj+sKuFkHOEwPhMt2kmuU0+SJQxhTa3HClqFaE5tnOw1aeTzxR+0aiT0bGUpI9SLf8rZJSBwZDfraVgpDutT99EHU4muZQUJ5B921yuZuFU9/6z+5mI8AlLTLJ8B9AfhCjbqbAmEct6VQO1KO0H//BsByHuLLQHV25SAHVz3aCNjOGq6OnGGoBdezvl9/nOK2An5OYimJwAaTZewHqJLcdK4ywXBUh22TYPm2TOdDR1jSFyu5agexsX0jWSRNBHXbM3ZKCXkcwuI1KELVX+JBVJP/zR3xqqqx8cM/+dVwg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(966005)(76116006)(66556008)(66446008)(64756008)(6916009)(66946007)(66476007)(4326008)(478600001)(7696005)(86362001)(316002)(54906003)(33656002)(71200400001)(83380400001)(26005)(186003)(9686003)(6506007)(41300700001)(52536014)(8936002)(8676002)(5660300002)(7416002)(2906002)(55016003)(122000001)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AyrExMOMCx0yhlQ2rRoiyTNzh/vkPjxCPOhx6K4jgZw7G9wJBqLRUUrh6Hg7?=
 =?us-ascii?Q?eiQuiilxgB4Nyo2H7OvQ3JTvXtkF8A76AbRd7EGql4KwzZaRug3DXvT/G+kr?=
 =?us-ascii?Q?ptoUSUtOlo1yr/RLe0gGaOJGH7JpsMXj9K4BD5eX7OsIevHL8VfCWyAxwEWD?=
 =?us-ascii?Q?V3Y75Pbbm7/JPfxTfX2jvw/ee5y4mE2XTMcVUY9TO3vgOlsDC24Wc6PKy4ms?=
 =?us-ascii?Q?b/4qTJExAZthFlK6nc3CVAhePIe76pyBpWcgp9rkdr9C66xh6IwDOIwTg+gB?=
 =?us-ascii?Q?fnAOyx5QcmyOypI8OLerjzTRSk0uyO0EJDR673AvjX3q9b4xXhGI2SB7ez0e?=
 =?us-ascii?Q?WytcvhFeS9G1GSCoE8gZQKcQONncP6EXKRaLXXNaR0Z5sT2VkbbFQVxw/N9F?=
 =?us-ascii?Q?fF5uyooo3Ek97Wvwyg6Fao//q48avVW0/Jyn3FWHbp/Y+7xwHZljdDC254R0?=
 =?us-ascii?Q?7gsX9IHvItXaTMMu66i+ETFDTXTJcznGUkTkh2kFLaXeHbEXCwZsWtTsZLv6?=
 =?us-ascii?Q?Ph1DP69VfviCzfKHOoVshnvaqqie/1VTXCRU5r2F6kcsVUYcgOVy05yjL/sD?=
 =?us-ascii?Q?wxPWYi/GVE+dv3ZO2M45wdzep6SU7I3kCx3KczE4J9JpoSKbboVIg3UdymEa?=
 =?us-ascii?Q?vYS9dzAE8CR6h9/Kob8KJIR5iTUiaOyq8djocY0XfTD1qdHCEAPHWs5tRBsl?=
 =?us-ascii?Q?2bBdPmgnd+hJ3uLHntHObx56hFXxRvzSLraPsQh5C7M3yhqDVNDEgH7BtKV7?=
 =?us-ascii?Q?mWZTCrwCirRr3NpBl6Rkj4l9jdI1MVHRfjib7U3LDqMSv2jcbKBJt7W3WyVz?=
 =?us-ascii?Q?CpBnfPLFFgEyQ/eRqTaS022ByqOMTfPpRF3XCumLtvQ5ckIFOOVWMjrfO2MU?=
 =?us-ascii?Q?UafJR2p4HFMr2cRc0Yl+RJfOfG55oFWYmzjgLpgHpFOV46v/lrvbXdPjUWiI?=
 =?us-ascii?Q?l9n8WPv26xpsIoYRJCS8YppMpJXCgJN9d/3cje1HGgSg89FpazqriF4FCc+q?=
 =?us-ascii?Q?ntUQwqJECB+n4nVUrlP9mx1JOB57diVAf5E3y0V9p95HLywUrmLXq2XAzuUr?=
 =?us-ascii?Q?5ZrKdXfTP9ZRoEfFeEGdqIZg6pO9lxnqPFeTnkw+5o6NqEMUBBBGr2BI3yRh?=
 =?us-ascii?Q?cVosuWueJ3h+aBQiBsz4H87hp45iXEDGsiIPCcEczxfHve2OQS7G9ttRIrqZ?=
 =?us-ascii?Q?W+Ye3LsdtPUcFjsqmjJBaonSVkjtCnVuUQ6LI4qNI2p0W8FRmX4qz2OrN9ZB?=
 =?us-ascii?Q?6Ygn8UEEN8FJjWtcgETLqvFI+OfZrX1q5+AhMt5vlcW/QDz3HVafgi+AUd1e?=
 =?us-ascii?Q?vSbU2JyumACETtWXi4U1lyYZBWMqyqhJmRjOk+7CUIVeVCo6Lf4iw1OonzSG?=
 =?us-ascii?Q?DP4gZSJhcP5XAoRu755KeSb++xGLd1CUKJ+a+VoDwHnCooP2yzJYzr9wbmwA?=
 =?us-ascii?Q?u67fB79MVcX75dWnAUxgKjwhDjm35Jn3Bbofl4MwTIUf7NmTW23XoxpbAzrU?=
 =?us-ascii?Q?1h8rOp+/0Drb7uDMTX6wY/NXA4KoknH2sDZYCTeh5EfxKyNOF4nz9d3UTG9+?=
 =?us-ascii?Q?GVvzlvyzGhpZ+CYOBbU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaafb76e-7b0b-46a4-3071-08db550ed69f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 06:37:22.1321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qtA4j22h9csX/18u4tziY2PnKXwiNE+PxfnlJIrzhhSc7LcDwe0BZKCXWxrAGZKuT3iNDMbgTnAqJPq6Ae3LwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7453
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> -----Original Message-----
> From: Boerge Struempfel <boerge.struempfel@gmail.com>
> Sent: Thursday, May 11, 2023 7:27 PM
> Cc: boerge.struempfel@gmail.com; bstruempfel@ultratronik.de; Mark
> Brown <broonie@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha
> Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; NXP
> Linux Team <linux-imx@nxp.com>; linux-spi@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] spi: Add option to keep the MOSI line low, when it is id=
le.
>=20
> CAUTION: This message has originated from an External Source. Please use
> proper judgment and caution when opening attachments, clicking links, or
> responding to this email.
>=20
>=20
> By default, the imx spi controller uses a high mosi line, whenever it is =
idle.
> This may not be desired in all use cases. For example neopixel leds can g=
et
> confused and flicker due to misinterpreting the idle state.
> Therefore, we introduce a new spi-mode bit, with which the idle behaviour
> can be overwritten on a per device basis.
>=20
> Signed-off-by: Boerge Struempfel <bstruempfel@ultratronik.de>
> ---
>  drivers/spi/spi-imx.c        | 9 ++++++++-
>  drivers/spi/spi.c            | 2 ++
>  include/uapi/linux/spi/spi.h | 3 ++-
>  3 files changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c index
> 34e5f81ec431e..6acab2b4ffaa5 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -281,6 +281,7 @@ static bool spi_imx_can_dma(struct spi_controller
> *controller, struct spi_device  #define MX51_ECSPI_CONFIG_SCLKPOL(cs)  (1
> << ((cs & 3) +  4))  #define MX51_ECSPI_CONFIG_SBBCTRL(cs)  (1 << ((cs & =
3) +
> 8))
>  #define MX51_ECSPI_CONFIG_SSBPOL(cs)   (1 << ((cs & 3) + 12))
> +#define MX51_ECSPI_CONFIG_DATACTL(cs)  (1 << ((cs & 3) + 16))
>  #define MX51_ECSPI_CONFIG_SCLKCTL(cs)  (1 << ((cs & 3) + 20))
>=20
>  #define MX51_ECSPI_INT         0x10
> @@ -573,6 +574,11 @@ static int mx51_ecspi_prepare_message(struct
> spi_imx_data *spi_imx,
>                 cfg &=3D ~MX51_ECSPI_CONFIG_SCLKCTL(spi_get_chipselect(sp=
i, 0));
>         }
>=20
> +       if (spi->mode & SPI_MOSI_IDLE_LOW)
> +               cfg |=3D MX51_ECSPI_CONFIG_DATACTL(spi->chip_select);

Kindly replace all occurrence of spi->chip_select with spi_get_chipselect(s=
pi, 0)
https://github.com/torvalds/linux/commit/9e264f3f85a56cc109cc2d6010a48aa89d=
5c1ff1

> +       else
> +               cfg &=3D ~MX51_ECSPI_CONFIG_DATACTL(spi->chip_select);

> +
>         if (spi->mode & SPI_CS_HIGH)
>                 cfg |=3D MX51_ECSPI_CONFIG_SSBPOL(spi_get_chipselect(spi,=
 0));
>         else
> @@ -1743,7 +1749,8 @@ static int spi_imx_probe(struct platform_device
> *pdev)
>         spi_imx->controller->prepare_message =3D spi_imx_prepare_message;
>         spi_imx->controller->unprepare_message =3D
> spi_imx_unprepare_message;
>         spi_imx->controller->slave_abort =3D spi_imx_slave_abort;
> -       spi_imx->controller->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_H=
IGH |
> SPI_NO_CS;
> +       spi_imx->controller->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_H=
IGH
> | SPI_NO_CS |
> +                                        SPI_MOSI_IDLE_LOW;
>=20
>         if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx) ||
>             is_imx53_ecspi(spi_imx))
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c index
> 9291b2a0e8871..3ad538b317a84 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2260,6 +2260,8 @@ static int of_spi_parse_dt(struct spi_controller
> *ctlr, struct spi_device *spi,
>                 spi->mode |=3D SPI_LSB_FIRST;
>         if (of_property_read_bool(nc, "spi-cs-high"))
>                 spi->mode |=3D SPI_CS_HIGH;
> +       if (of_property_read_bool(nc, "spi-mosi-idle-low"))
> +               spi->mode |=3D SPI_MOSI_IDLE_LOW;
>=20
>         /* Device DUAL/QUAD mode */
>         if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) { diff=
 --git
> a/include/uapi/linux/spi/spi.h b/include/uapi/linux/spi/spi.h index
> 9d5f580597039..ca56e477d1619 100644
> --- a/include/uapi/linux/spi/spi.h
> +++ b/include/uapi/linux/spi/spi.h
> @@ -28,6 +28,7 @@
>  #define        SPI_RX_OCTAL            _BITUL(14)      /* receive with 8=
 wires */
>  #define        SPI_3WIRE_HIZ           _BITUL(15)      /* high impedance
> turnaround */
>  #define        SPI_RX_CPHA_FLIP        _BITUL(16)      /* flip CPHA on R=
x only xfer
> */
> +#define SPI_MOSI_IDLE_LOW      _BITUL(17)      /* leave mosi line low wh=
en
> idle */
>=20
>  /*
>   * All the bits defined above should be covered by SPI_MODE_USER_MASK.
> @@ -37,6 +38,6 @@
>   * These bits must not overlap. A static assert check should make sure o=
f
> that.
>   * If adding extra bits, make sure to increase the bit index below as we=
ll.
>   */
> -#define SPI_MODE_USER_MASK     (_BITUL(17) - 1)
> +#define SPI_MODE_USER_MASK     (_BITUL(18) - 1)
>=20
>  #endif /* _UAPI_SPI_H */
> --
> 2.25.1

