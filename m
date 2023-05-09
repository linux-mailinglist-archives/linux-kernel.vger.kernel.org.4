Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34F06FBC21
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 02:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjEIAtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 20:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEIAtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 20:49:47 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2078.outbound.protection.outlook.com [40.107.14.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5694C0E;
        Mon,  8 May 2023 17:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzc5oruPqjZUl2D3e+ZM+pCTHY+Taall47H8cPFRLtnfRYteBf4305uSdrNDG18nr21HLF0VJZhD/PMH/oL8v0BFzUtSWwEaPm3alWhU8tTpjN0BffYIT2rLnhN+GZzxirxSjMw8u6hPVju/oHa9EygXxb43UeVxgZ1xYaUU8C5vxXHl8NtrgSecGm0zRglkEcwHqMElKaIONQLIIb1ekMBDZSei87RjLbcbPr8XJOcAAj6NzM7ViHVWBVb7wn68HwpV0L2oKQfN3/dV5BVbHhZvyNFhwJ6CfqxUDYP3OaRcjxuvaZo5OlgXLPcVscW8y+BRwhIYjPFmKJFRBJ8+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIsA6EsrEMxG9GteUzOgiXSs3G1NNPKBoTcW6jxMY5I=;
 b=UO9YaZO3VGASlBNhxaI5M2+do8BjNy8zEqd+c6H9rDrDyJsGYiWRxCmFfUt6apIw9MC9+IVQ89r6xCwrsKaWapYsChf1ECTKDw7qKUWxf7hGnuKn5M78WIqO68bsgkYZx729imJyGrN+LKxRYlBkMfa3XxR3PLXC8KBaLeT7Nn1zGdcrssGrffZtECpX0OtyFLKKM/vfGJ3MbLbWi7ImstnSR8rfIGjOzYzV3SgP1DLExRZOL16YEvJPNzVOe6G2/6M0WZrkADsoVa2NORswUhUy6fNKRoZ6eKVI8UewwdLfr6wxgHapG0EhM6c5sHm5stE6ZyBi7NSiXPJLsQUi0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIsA6EsrEMxG9GteUzOgiXSs3G1NNPKBoTcW6jxMY5I=;
 b=gwxO10TFy3xaDg3tCIXpC3wNjwMhh9dxB3vFTUaLhNeD2csu5iT3g/oerCR8Wzj0md3nPHTlLZ4LHoFFbQBlninbq+nbZU5mct8Um35ZUL+E8YRCOlvJ6lvRJNF3ob2KDJqJkLlra5+M4ByrC5d7F8Y8JzKSNTO9Ai9PXmycxFw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8810.eurprd04.prod.outlook.com (2603:10a6:20b:409::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 00:49:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 00:49:42 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>
Subject: RE: [PATCH V2 1/2] dt-bindings: nvmem: imx-ocotp: support i.MX93
Thread-Topic: [PATCH V2 1/2] dt-bindings: nvmem: imx-ocotp: support i.MX93
Thread-Index: AQHZgaIO2xvIu9hUGkWNsAtR1PCbaq9QTa8AgADO9HA=
Date:   Tue, 9 May 2023 00:49:42 +0000
Message-ID: <DU0PR04MB9417DCA5F9465792F86F648888769@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230508114639.1525521-1-peng.fan@oss.nxp.com>
 <168354885877.927501.14485011836566521791.robh@kernel.org>
In-Reply-To: <168354885877.927501.14485011836566521791.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8810:EE_
x-ms-office365-filtering-correlation-id: f07d7790-0a8e-4290-59f0-08db50274711
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZSY3Sm+VRaF9Wbfu3Q1w54X4z+AJNiEuqYTbuK+2Qt7ItWBJs9Bdcp1RfXnR0mb9D8GhJ469Hv4NBebx+34xPrKI5CzOMOYD2M2OPV0xHN0ssJjK0Ap/mcfG+ul3aq4PztgObv3ct5tgPezk72PW5wW1MhBSWF3IAIHjqnAJOqE+L9kcylSFSyJEa5EYM0f9PF7avl5pGQITFsERIRXfIAv6VbZFWLjknOyvcapiFAwaqVV1STaKRMu5XXzkbeIJusxjqvNmU36xUUS9ARy2e1tTuP+9xAz/wMnO8C8o8ROrmIc24oK9DL3Gz6Y0Ekhn9okQh9iXsjL9ffTE4MkFvSoBsxYk4v02lRUTDG+2m6oHgEunrl20WZ0hC4Me8UG2Qm5N1hDDoUKl9wGdmo3qE458o+JbKZzUtgbVKF8O+AKFm3CF7HmqUmDVJmQKUavWqCIfCrBgoPSD7MjUOlgRbl+gh6TqYAj2u8dASu3Fi7SrC45Jx706TUZWP8RyqJjhxHDM2hkfLg4vpDmfiLqSKNyj4LZBhWF81MRGsfch+r+dy11ExZOZ0nQ9gS+2LrneJ4zMPnAvmzZYM/cIfdXu1e0cR6AICp6L/JGE9/yr6EDH5y3TGaDp9140fbZo+92A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199021)(45080400002)(86362001)(33656002)(966005)(110136005)(54906003)(316002)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(478600001)(76116006)(7696005)(55016003)(8936002)(5660300002)(52536014)(44832011)(8676002)(2906002)(41300700001)(7416002)(38070700005)(38100700002)(122000001)(186003)(26005)(9686003)(6506007)(83380400001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AmKm0g9X/zp/W+x8keMEHj9HKh5kSDrYmpqFYP+UphSO8NkIpgEnRZcrhGEF?=
 =?us-ascii?Q?brzMAgXNVtBXXPEfkS+8ZiKdHmdBVEQlRoJq2sHpL2Rapdg8mH71ReDMmlVR?=
 =?us-ascii?Q?CunKw6TUDFUz36hS0/Ir7WDgZRZiLipN/kg9ePMt7TuofIJgxfNCBcsI6kwW?=
 =?us-ascii?Q?Xec1Fb2pMk0DO7Fsi+KYt98cj3WFT7vyZDIKHdOoxhvlLqoTcNWMZwrb3v3Z?=
 =?us-ascii?Q?n2y64oEOUTovf16wO0jw9UpSg/QsJrCXO/5cr2w9FNgl108Lfpqyi4ktQvcW?=
 =?us-ascii?Q?+aO87AXWgyzYYePZPNRLaPF3cMAWoEexnUG/+ZOsn++Kbm6DCpbKdzpz9hXK?=
 =?us-ascii?Q?VJ6BbJ8l1oqymjVAJ85fL1KuXW4wEDIgpTATHS0p6Y1OewR0DQNmmmGk+jfM?=
 =?us-ascii?Q?DlmZe11W1gYBrWkuOSujfxpW8mYAfhMVj82V+j/j9/7TWmxfuaYV9KF2k8Vk?=
 =?us-ascii?Q?4gPNi4hsP66+Ep1R3MsbLpcw3YDEhhH+FuUJrKD8JzeW1WUjumH8LiVeUKh2?=
 =?us-ascii?Q?A1m9NCpdZtstWxzy648owjId0JwMwamKumIgSG/BE0TqZrF704rJ/Iv8LGdl?=
 =?us-ascii?Q?dNn87XyDbYMplgFomvsnhnuHMTrGlJXJRCGmBoljLO6SAWEqxMWjLw8txKuJ?=
 =?us-ascii?Q?Pcc8pc+eWVjZNV+0fv81phB8QtTi2S5nwvM1xJxsROJuD3pR1p6yeOFa1ZWs?=
 =?us-ascii?Q?pcoJnf06QoqvfqWpX+arp3WeU6xjo76wKsjnFfv/1Rl9K/vSJoTuCjCUCzLK?=
 =?us-ascii?Q?N5ZB6hGhqJwtQr/nEEkTHrzV8RjUuRbLLc2AgnU6BlXI+Xctb5+SmfcBrhB2?=
 =?us-ascii?Q?AQrNrmc8g25UQ9dE/ONZqVulvdkksRrUAE3G2F+UMW6dZg6KRvdwx4EdHOpz?=
 =?us-ascii?Q?Wa57dea9rLnHfzAfywUZR4g921B8rNSiyo+jOegNpKoMvn10epMtq/vKY0GC?=
 =?us-ascii?Q?hfJ3cmVdyWlpkuLiKtznmw0k6wsL0OKlChPp4PTpTAGKjbDa2M95buHKwSfW?=
 =?us-ascii?Q?sWKWWcxyv7RX4f8JtNspP0dG/6KnpLof7HME5kVD9BpesbrqOB01JuEi2kaW?=
 =?us-ascii?Q?EMc9ZlxdrRhONy9CPQpy4mwdLK3I/k+IyNz3b81/CspNMZBARc935xWVJzfC?=
 =?us-ascii?Q?yQVGpkMxNN65NJbGvayUCDI5bKXPDMtjzQYwXkCGB1ZTJriB7U0Dc3k2WtiB?=
 =?us-ascii?Q?LO3UyxFhiN7CjQyUuQl4KU80o7AzAGZaGjKGMdJWYOVSX7Mpx9YoDFcvBmx0?=
 =?us-ascii?Q?ZXQhdhjXuvNqWxCQV3xDr5oYlvEeHTtSubzaZ4UVsifrBT1+fyoGh6JxdNYw?=
 =?us-ascii?Q?KclJbvjSYbM+mHVNK6IOr+fd16PRu9pCYN6xHKkqLEIYKuMexBFp1FNvm2VC?=
 =?us-ascii?Q?dC0D6z05IOFaCbeH9jmVJq1bFefDg8iNGi/BCMu9UImoxQb4RWZrUEW+dy+Z?=
 =?us-ascii?Q?hTMgSVOR7dS3K2/j3hdtMlnPj5BcBudapCywaREFGrDQRfAgpnNjSA28o51g?=
 =?us-ascii?Q?GgAtpA8sFo5cxuJcvDM2acisC961GS96+Vwv3y9I6M11Hhi+KPA2/tuQZ3CV?=
 =?us-ascii?Q?eJFVUcpP/qyEr1xl8Ac=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f07d7790-0a8e-4290-59f0-08db50274711
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 00:49:42.8877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SAz7gfxk7F2D17TrLfKMTOdfGtpmj749uApa+c23H4CwqH4k5NFGv7M45htbyZyqjzdLoH7Vf+JLzzRrJ36HUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8810
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> Subject: Re: [PATCH V2 1/2] dt-bindings: nvmem: imx-ocotp: support i.MX93
>=20
>=20
> On Mon, 08 May 2023 19:46:38 +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add i.MX93 OCOTP support
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V2:
> >  Reuse imx-ocotp.yaml
> >  Based on
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore
> > .kernel.org%2Fall%2F20230506064128.34005-1-
> krzysztof.kozlowski%40linar
> >
> o.org%2F&data=3D05%7C01%7Cpeng.fan%40nxp.com%7Ca420ce0c500d4c7e7
> 63a08db4
> >
> fbfa1d7%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638191456
> 69328409
> >
> 9%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzI
> iLCJBTiI6
> >
> Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DV7QDS9Ko3cvQ3q
> rR%2FzlHVVI
> > NImlIzkkqBmDHPFme5oI%3D&reserved=3D0
> >
> >  Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m
> dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
[Peng Fan]=20

I think the following errors are not related this patch. I not touch
pcie, camera in this patch.

Thanks,
Peng.

>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/media/rockchip-
> isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
> 	From schema: /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
> /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.exampl
> e.dtb: camera-sensor@3c: port:endpoint:data-lanes: [[1]] is too short
> 	From schema: /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
> /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-
> ep.example.dtb: pcie-ep@33800000: Unevaluated properties are not
> allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-cloc=
ks'
> were unexpected)
> 	From schema: /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
>=20
> doc reference errors (make refcheckdocs):
> Documentation/usb/gadget_uvc.rst: Documentation/userspace-
> api/media/v4l/pixfmt-packed.yuv.rst
> MAINTAINERS: Documentation/devicetree/bindings/pwm/pwm-apple.yaml
>=20
> See
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatc
> hwork.ozlabs.org%2Fproject%2Fdevicetree-
> bindings%2Fpatch%2F20230508114639.1525521-1-
> peng.fan%40oss.nxp.com&data=3D05%7C01%7Cpeng.fan%40nxp.com%7Ca42
> 0ce0c500d4c7e763a08db4fbfa1d7%7C686ea1d3bc2b4c6fa92cd99c5c301635
> %7C0%7C0%7C638191456693284099%7CUnknown%7CTWFpbGZsb3d8eyJW
> IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C3000%7C%7C%7C&sdata=3DBagDUtBuSrbiQNnFQkFSiXMUwzpdxZFwuyizKx%
> 2BnEhs%3D&reserved=3D0
>=20
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above error=
(s),
> then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit after running the above command yourself.
> Note that DT_SCHEMA_FILES can be set to your schema file to speed up
> checking your schema. However, it must be unset to test all examples with
> your schema.

