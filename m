Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1E4607F57
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiJUT5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiJUT5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:57:00 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80095.outbound.protection.outlook.com [40.107.8.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E550129B89D;
        Fri, 21 Oct 2022 12:56:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3N6+k0WcEm6+Tvlh4TGO/Gk9+t0rZWTpZRv4Ev+G0sTHggE92K6dUJy01cCVxXdrao7D3W1/WybgDgZWjF+iFQw/csHTAcxwIaBx/bMXCmk9jVt7HOabs237HUwk2/iuHXE6cCJUjK847KTQCo7F0SuqFbbXrhaj/HsYlVowp4FyuRLYgAYALYBdWTVcG1EX3dr54iRHxi/cr+Nc2aw0DVWFWAhgaay1JaPOAEuWD9+48MkLUt0nTJdujvvu6LD02ntyViBTMRSzym7E9PxMtn4iai4mT6h1B5buGArI3lxWiui0drrNX8Iz1lmqxjgqGHxjg1DtTrA/XwBm+UqCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSnhRFzBBNIKzYX6oSirpwIR46mWn+vbuts4BjAq8gU=;
 b=kpPVzOOFOvMsCQxjbR1RTxs57d1AAdqE4X7T5AdXgdbeLBe7T7MorwVt0sIvubarGT30GK0eVSowQNIAL0QixCey2UPD00RB40/yj5SisMWDqeTW3LIG0eqHaWDYjmivXr1p55uA0gZZE69NaiDc+/J04E4+md86KLaM43KaRZriYj6zq5xShco/tvhosadcVI/53KsNAfwniAwNWqDxVw6gen8Izs9/MzfoI1oKCSTWeb+Yro39gSdPcaUo3UqwUj0qvq6K34F632KKwoP0kC7hyRaicX2BZMEZ3IwVoufBKMximLNMS0kGGRpWSqJ+X5Nd4e71tMOxwcrwjCmR5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSnhRFzBBNIKzYX6oSirpwIR46mWn+vbuts4BjAq8gU=;
 b=iAeEZIgCI6oYuE6gZhhfWm1LpRK5Vf641Vkw3U2XxSmf9yQTcRz3Zhc87WEa43HXZHAy9PnfYOO0s1IkXrOJo85Vjne8Xm2N2UZcZImo6go2nL4CmtlGQpn04CNKQJ1Dj90QcY4Rsm1XegG+9iIDvlfYUnhTDURmo5A3txVmsBM=
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by DU0P190MB1953.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:3bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Fri, 21 Oct
 2022 19:56:57 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::a621:b61f:de56:b8]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::a621:b61f:de56:b8%7]) with mapi id 15.20.5746.021; Fri, 21 Oct 2022
 19:56:57 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roger Quadros <rogerq@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Elad Nachman <enachman@marvell.com>,
        Aviram Dali <aviramd@marvell.com>
Subject: Re: [PATCH 2/3] dt-bindings: mtd: Add AC5 specific binding
Thread-Topic: [PATCH 2/3] dt-bindings: mtd: Add AC5 specific binding
Thread-Index: AQHY45PTPI7TLc+fQEC4CnOCf8ArC64VZ4UAgAKEjQCAAVm2bA==
Date:   Fri, 21 Oct 2022 19:56:57 +0000
Message-ID: <VI1P190MB0317D2A6E35BB6420023FC45952D9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
References: <20221019082046.30160-1-vadym.kochan@plvision.eu>
 <20221019082046.30160-3-vadym.kochan@plvision.eu>
 <20221019104654.7ee35744@xps-13>
 <e13c3b91-c092-7756-3969-f1822e04cfdf@alliedtelesis.co.nz>
In-Reply-To: <e13c3b91-c092-7756-3969-f1822e04cfdf@alliedtelesis.co.nz>
Accept-Language: uk-UA, en-US
Content-Language: uk-UA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1P190MB0317:EE_|DU0P190MB1953:EE_
x-ms-office365-filtering-correlation-id: 1b44d0b0-8abb-41a0-7cb6-08dab39e68f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zoI4IULcRNGM7oyZTX5JKkQTryQdWlSyxmHMJtDYKdhKkDiBfzhsEVXtcRvUSMjTKJ5Iz+UAMMbci6l/y8HSVVOEUhftTyC89e80LGhod2+uzsXA4xYWR6/1OA3PsPXBY94Lq+JNKRNI2sxrEcG5hNWTKuOtdZebwrhqn4nxKXs8Jv0xs2gNSjy/a285b+C35mHp9Tq3RgJRPPbvb0z9o+wddlneDbpo8nTv4HWDBZ22ktvDKMVnYSjeZHuSOroYHWRr7TH/tyQ4EJhgC1lK3yJda0bKzFfqF9oTxSKSvN0JGE9FlKbdv/jziOyD3L/E0ImyvVmzt95kYPa5c962a2RUTAQcqR4fFmN0Wpo1z8fvQh6jGfappjuPm9D0ESSGpvjBsUqNQbHAjJefvctI7AZnny3lxaDAErN1ZQzUmHmeTgqSB8woxzCHRdaTy0HTwv9tbhnlTgai7aWiBvOWA3JFJv0dAZbfW8dN1eVGJc/ncFPNzPPoGLimtdYsdsuKiQPs8l9QYjEaf7PmVESAaaWwfchnbJXBpCJCGXCklF/QQJAEokhUtbVJfK2I5I5fn3MS2memn4XgwQmK3jzvqK5CuAzNKqs2Mdft6k0LPuqTRTV+emzoD+dCVj9DVxNMD/WgXK7LxU/0Hi50RYIo8VburvB9fj7+g0w40SLSZreTS4lDxjIICYRXj9J7o6EoCEgGM4k8oqACUMA1YLUb3hEsceED+9jIi9+Tii6vGh+gvKuNwxyD4P6L20m5YrVP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(376002)(34036004)(39840400004)(451199015)(33656002)(8676002)(110136005)(7416002)(86362001)(4326008)(5660300002)(66446008)(66946007)(41300700001)(91956017)(66476007)(66556008)(508600001)(71200400001)(52536014)(2906002)(44832011)(8936002)(6506007)(41320700001)(7696005)(76116006)(186003)(54906003)(316002)(38100700002)(38070700005)(64756008)(55016003)(122000001)(9686003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-u?Q?pBftSUoauGT7Fv1X6X6oQ0gUxflX0J5JV4563kxSOggeMEMslxDuI4kyAOp+VK?=
 =?koi8-u?Q?f7BEpJ/0lBybRv48so6uLKfqNOSboP91lWofh1lXouzxUlfdx8tO2sAceBPlvo?=
 =?koi8-u?Q?mzI1f2l2gG7puuf4O2GoOaTOTiwOqcM/fzDolTIrjAM/PDTGtvI/SuVmZ9k6iV?=
 =?koi8-u?Q?CBplDaJH0dhOglsAZLt5anLTd9nzLOqITMxgtYG1tPtww0bg8FBoVmp1rZnRw8?=
 =?koi8-u?Q?T6BlDb2YE7hqdJGVrLKg4q8XV3QOaOYUVDZ5tCjL6ooa0pEn6WPuQp/sF++u+b?=
 =?koi8-u?Q?IO/Bq23Wwt5kBuLNoWe4m04CBXDLIL4L0/NyZg6yX6k8PIqySYFAEmmqNh6UnE?=
 =?koi8-u?Q?Ok1B6dSiDbVxQntuxIz3VwjJKTrloJ+U3PFQjnZ4kJiX3bj79SM+bWPgIlzISi?=
 =?koi8-u?Q?MgpXcrtzVP+V4gzB8J/TAvyCnFs8sMiSvRODi5ywb1s83Yqh1oopm2mESvyknY?=
 =?koi8-u?Q?Eory1itFcXRWEeNufeTzK4BNmcTfD9UXEdSbkv5NoyhWk3Iq4U6VCfQphLbWQ6?=
 =?koi8-u?Q?rK/mG/096dFKm6WQp2W52TaDDZoDzrS8J2pACYxTSjmPpvnRDZvJkU+1Jiqeeu?=
 =?koi8-u?Q?aHA7hDw/BDq4uaI8frBHbjGhK8PX/N/qfKUrfmyh3z1gM9V4lbIhhvSI2P8gDo?=
 =?koi8-u?Q?jFnuqQW906WQIuqFyMnB8DVCTHPliXC057oRHsdoRRiJ00nkqy/+O74NRQ8lKT?=
 =?koi8-u?Q?3fYUQt0JTBJf7DRUCxNq6O8jrHHWK4Q5PHMXQC1qEMhs0Yn/9VnP5YfcvF8uzN?=
 =?koi8-u?Q?kZRwPpu2ntUm1X3mF1y3qeFIqfItQ1E8pKNxGyIdij3/nepg2bYz7KUpwb+crz?=
 =?koi8-u?Q?4yHYa4BvVTPRbR7lt/dozg41st0zCEMUJIMHt8HFKLcwXadTOO/O2nL3z9f1Oo?=
 =?koi8-u?Q?C7yKgIpZ5he1BB9TokKsJgp6Y66hnDn46K0lmjWeUGqhElUKieoTjZ7Ew3Fohp?=
 =?koi8-u?Q?6/nI8bthaq0ijzD6mOZX6UmhYDYsdaSx+gU0CA+KvSrX1ubrV2N+IEBD863Hma?=
 =?koi8-u?Q?12ahUhcdyqNgGK5DL8l7BtY9T5G0rPrU1uXCCMo+gWvUJ0Bf4kXT7mMmpJHOzP?=
 =?koi8-u?Q?+RVb2JoOCYGTS7shQ1R4jenu5qFKyApPikPpGQrIsLmkGzacU05R5dhOQljGrh?=
 =?koi8-u?Q?einRo5RCnep6g7V9H//Cper14ta2Sr0tzp02HkraERTOC3JccB0U2fvB0A1P9A?=
 =?koi8-u?Q?S66blTlDEsStKQ2rHN2XhWrBIVnJvywXUPyFmd0mrJnIeX7KxvoLgzDzTYXBSi?=
 =?koi8-u?Q?imb76RUdhuIaMpfIFAnKO9mzz4Ngt4LNa5Yfi3RYU1/Ou907kVxQr16/PIwfdJ?=
 =?koi8-u?Q?easqjoEkZhge9R1nJdgsJwhgvGXs6NFhpzZLx4mJJ5v2Pxc0d7b9he2ZAT0VEb?=
 =?koi8-u?Q?a3O6MG5R4KCbY3lYWximWj12r+l0YMM8kPszP61WD4DXkjSBaohatrIZBqlZGb?=
 =?koi8-u?Q?BLhcUfthLJY0lTFwlug72KlwE+g/EL8ZL53HWKPy9/mx/lQFA9nfcWH7wKuSE1?=
 =?koi8-u?Q?UGGpNeGlN2UT+MKViFA/qBMb2y2bM9Bw/2itJc5GI5uc3v1ag1?=
Content-Type: text/plain; charset="koi8-u"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b44d0b0-8abb-41a0-7cb6-08dab39e68f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 19:56:57.2829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9KejrgHFRnjg1jmYE2oRMvu7iPI65mPeqB4KaZReFEIs/zdlaqMLq3Ka7d1PWkqmzR/VE1OxI3J1zvWxcv/t095Nyz3kgEmhUIQq6hSYQsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB1953
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,=0A=
=0A=
>> vadym.kochan@plvision.eu wrote on Wed, 19 Oct 2022 11:20:39 +0300:=0A=
>>=0A=
>>> From: Aviram Dali <aviramd@marvell.com>=0A=
>>>=0A=
>>> Add binding for AC5 SoC which have its special way of handing=0A=
>>> NAND layout.=0A=
>>>=0A=
>>> Signed-off-by: Aviram Dali <aviramd@marvell.com>=0A=
>>> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>=0A=
>>> ---=0A=
>>>   Documentation/devicetree/bindings/mtd/marvell-nand.txt | 1 +=0A=
>>>   1 file changed, 1 insertion(+)=0A=
>>>=0A=
>>> diff --git a/Documentation/devicetree/bindings/mtd/marvell-nand.txt b/D=
ocumentation/devicetree/bindings/mtd/marvell-nand.txt=0A=
>>> index a2d9a0f2b683..293551ec7350 100644=0A=
>>> --- a/Documentation/devicetree/bindings/mtd/marvell-nand.txt=0A=
>>> +++ b/Documentation/devicetree/bindings/mtd/marvell-nand.txt=0A=
>>> @@ -2,6 +2,7 @@ Marvell NAND Flash Controller (NFC)=0A=
>>>=0A=
>>>   Required properties:=0A=
>>>   - compatible: can be one of the following:=0A=
>>> +    * "marvell,ac5-nand-controller"=0A=
>>>       * "marvell,armada-8k-nand-controller"=0A=
>>>       * "marvell,armada370-nand-controller"=0A=
>>>       * "marvell,pxa3xx-nand-controller"=0A=
>> Could you please do the yaml conversion first?=0A=
>If it helps I've done a few of these conversions in the past. I'd be=0A=
>happy to help you out with doing the conversion if it helps you move the=
=0A=
>rest of the series forward.=0A=
=0A=
Thanks for your proposal to help, I already sent the separate series=0A=
just for YAML conversion, actually it is my first YAML experience.=0A=
=0A=
Regards,=0A=
Vadym=0A=
