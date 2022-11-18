Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443DE62FCCC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242468AbiKRSai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242649AbiKRSaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:30:17 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35F98CFC6;
        Fri, 18 Nov 2022 10:29:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2IqBACs51RAelPrCuU5mcsTC88zqg93fLESlMZHopMwVhgir9xYioZXBixo7krfFxpCj3e8AULRVbJ3nRpIwxKGYrcULZFiUCLv43elJK0e4Eb+EYQoz8YM3Kll4qatC3STJpNj4z3RAtoNQTrUpQGKBl2vRGnQrWEa8Ttgzlp2OzjipB1S5DoPHsYsJAqHGrbc9G+zZ0WTBEkJ3CnMaJ+EhaO8GFoNihOpHJbz4y0enlT8QboL6ckeN3YZgokTF9LZJS8k8w78rBYP1pI755mOzLVpN5Z7dQzQekeDpnZ2o/Dcl2KVIf7xp4I380X9GE3xA1U6WTdaMnYNJ4/ZtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqN7TTANcJq69uEiU7e2HNs5KlvsvaOMiTiOcyZ6uvY=;
 b=KRz8vMWM+hXb6mJgLECtI8K2vYi/AbmIGhOunv84IjZExBnyqcJJ6SMhfNUowZ1OwWkYsW+Ciixf+mKBIDrGrHt+CdxVbLBJBCwi4p8CFJ0B6xUh3SGcTTT3dSloEa9FBL43jgS99KbYfc1Vp70jmilE/18p2Q0CRUh/43tXqidqPu6Azy6Yt7NGkErFx10FjCwlaadwvf8+9pPxckt37iDUexUijSclQMkkD9LmHwNWUfk4Y5jqrmiFbBltpsAaLZy83pc9fY10GFqjfHgDmQ5/BoQJfWuyYGEOd6C3tUF7tSlIjB9xK5hOSaB8M1MQExa8ZSEiBYNn/Y/wQe55oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqN7TTANcJq69uEiU7e2HNs5KlvsvaOMiTiOcyZ6uvY=;
 b=N8ZasDzmLOveJvfExjTaENzTgTHKOTeyyRKREtVVHTgvpCjo4HzBXQdN+MSsOFA+DjMZslsr5rnYUfS6IkmsnP8Ay0E6rUJTNhDYaGTMnwh8UOZGtFeqmDNyvB0dI8XJGeqqn0nRNJt+cMxcCSISpUxad0PlqmofwJLOwOiOE0Y=
Received: from BL0PR12MB2401.namprd12.prod.outlook.com (2603:10b6:207:4d::19)
 by SJ0PR12MB6880.namprd12.prod.outlook.com (2603:10b6:a03:485::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 18:29:47 +0000
Received: from BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::25d9:dbb:b557:2664]) by BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::25d9:dbb:b557:2664%5]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 18:29:46 +0000
From:   "Larson, Bradley" <Bradley.Larson@amd.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Rob Herring <robh@kernel.org>, Brad Larson <brad@pensando.io>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alcooperx@gmail.com" <alcooperx@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "brijeshkumar.singh@amd.com" <brijeshkumar.singh@amd.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "gsomlo@gmail.com" <gsomlo@gmail.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "piotrs@cadence.com" <piotrs@cadence.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v8 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
Thread-Topic: [PATCH v8 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
Thread-Index: AQHY+fMz1mOoRsElvEWbbkYxqhL2uK5CIjyAgAAkCRyAAR9miYAA+d0AgACg5DU=
Date:   Fri, 18 Nov 2022 18:29:46 +0000
Message-ID: <BL0PR12MB2401BE611AE287AAA5F9A5069B099@BL0PR12MB2401.namprd12.prod.outlook.com>
References: <e9d8c14d-38b3-0401-7bfc-b2bd7ab36c52@linaro.org>
 <20221116193940.67445-1-blarson@amd.com>
 <20221116223045.GA1130586-robh@kernel.org>
 <BL0PR12MB2401ECC21B2EA83A5D806E369B069@BL0PR12MB2401.namprd12.prod.outlook.com>
 <BL0PR12MB2401AFF244ADF7B026935A419B069@BL0PR12MB2401.namprd12.prod.outlook.com>
 <CAMuHMdXuTxAZsrqHxfhwhWq6xmJVRuzFNmgMx26zBAY=D2s19A@mail.gmail.com>
In-Reply-To: <CAMuHMdXuTxAZsrqHxfhwhWq6xmJVRuzFNmgMx26zBAY=D2s19A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-18T18:29:46.069Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB2401:EE_|SJ0PR12MB6880:EE_
x-ms-office365-filtering-correlation-id: 8c978a58-73df-4a35-4840-08dac992decc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7sScZ0w614VaJQBPDs3J886baenhwjc9EwTJtC0tUQGLvoRlTQC0yFB3w6WKCGXZwnmrSWOSQKIpnYO+aYVRPr9TW7TxwjjBPm+K9Rs/QHk/NL9E0YwxrvNzEBUrTQQpam4xOc7/DPmG17n/vVlU1ANWhX9ZfSRYJ8syUTq5rVRGTWHohoucQibqJ54PCJPqG99wVt7XiVKyrZgGm2mBvHBGwyMQW3F57NjQBnVQV0nNy+xqT4egCqLRd703B7rR5QrQ22lHK1skUB7gDfdPD/zKr+gmdqYoYLOlwIWJZpsR04SD4B496RLKPaVtZBpKGkf24PPFCNwdowkjAdXUkf39yRFMAKUz32ECpWh0jxtbhXL8/VuUfSUfpgLi/cluRmFJzmRPoJUnzP2CMUaw6nY8dEMjX839rWmzHgjjMqYU3q5ftimuACgLxSL5CRJ++COEhFMczv/EDuypfZsiNhuc3rbKLEBWh89oRn4/zTVNDkxBBhy2kdDupSi4XNusN5jkWlhFDg9mgU9H8UlM2Jfh7l0eOC3BbkXJTy5Eqi+iTDM8moC0+oxS/Wgst/ehsl9BgZvIAHk3H36DPKBl1O/OszMtML/jp3tkHUH/9Kks/2EYRSIS3FqaOvjj+tD0HYuL0vVMihYL3HyNM/EGF4VheSar6srxD+Mp2B0I7F+qYsEf3zgRB2sLzjEkEUuv5sw0O8pSSryeL5cd+uUkGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199015)(7416002)(7696005)(33656002)(5660300002)(186003)(54906003)(316002)(6916009)(6506007)(64756008)(66446008)(9686003)(91956017)(4326008)(66556008)(8936002)(76116006)(52536014)(66946007)(66476007)(8676002)(122000001)(38100700002)(38070700005)(41300700001)(86362001)(2906002)(55016003)(478600001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?n06eSCeVTGnwlXQZFta5hruCh9UgsPIDnNj7QqDSj5Df6oZLbD90vPknu7?=
 =?iso-8859-1?Q?dQWJLhr9pC/ZTQr+HHfustpXQe2VQnkgrCmtYN4HKoQkgMN0E4aZ8e57RU?=
 =?iso-8859-1?Q?gZQfOXeefhsIJdNFFvjeJo/rbVPgbM1AVDKw8XSX2D44ope6LbqC8dk4KI?=
 =?iso-8859-1?Q?Ny3tHocal/Q1SJko50zhRNHh2oFQ++ZcJM57d2Ol/muBvy2yO00fe7e9GM?=
 =?iso-8859-1?Q?ktM1w8k9g95AFA8MshFN3y8a2FguaEuxNV1484lz9rlexGDlRAjSORoVK8?=
 =?iso-8859-1?Q?MhzdJ4rdUwn01hRPw91Bkti5dgOyCHhokSthBe2NfktSqL/dh++o5BrfRb?=
 =?iso-8859-1?Q?f1VzIoRwv9fggOYsLpjU54ERStvIPpR6kgBn208nRHv+gtDOGF96+LdXYD?=
 =?iso-8859-1?Q?xlakXAe+PFyCSCMoVObP5C1r4iDKl0xWsqPmdk+2VoC7Y3wBHfowauSI5f?=
 =?iso-8859-1?Q?vIQ165v3nAnO4jDjpYml6Shs7bWFgwayDLDTzwj0F0tJdmac4B9wwuyPhq?=
 =?iso-8859-1?Q?j5Th3lpFOvWVRGbfhgpz/6WgAbt+lQdeuB+fkMZM+kcEz6Hl2Nu/UkKGBK?=
 =?iso-8859-1?Q?HOdFLLx7lG/D3PK5m3f9jIwd/XvdSqOGOkrWlKkCBfN1NI6xm1t4sxDZ0T?=
 =?iso-8859-1?Q?gzp97McXTRQ1it5A1TOVYNgVpsBBs+e3gMm4ZbI7Pcw6HhpoRQD2EDTWoF?=
 =?iso-8859-1?Q?ESnvYNasISkiIW5tjfS+p2cZwEYzj17YFEft6UBufnR/+tRWWiQ7ACM6yL?=
 =?iso-8859-1?Q?AJ9gcOXijapwL1pvFLkoLiN2oVP5cWA9m7qAPSALBjA1bMkfKfW1twNDC6?=
 =?iso-8859-1?Q?lO6X2MqkmbInoQgNty4HKaqOq6+PH1tdj1fTOj2w65XTEJydBvwrKBwAMl?=
 =?iso-8859-1?Q?en5dcJh2s52gu0oTOYeS+mbAt7Gxp/3xK425mbcnLnjL4td957TVCdQmYo?=
 =?iso-8859-1?Q?OhegvZTzF0+6CzjVrpyvQsaiSGcytTr/OeQ8+tyEgDJ2fq6P4oiGVGDNL1?=
 =?iso-8859-1?Q?Et4U0Vujd8MDnEZ1Zs0vkeEjDDNcJ7xuNT7Oxhlz5fHQiD6VoU2wH1gGwb?=
 =?iso-8859-1?Q?HvuzS0pOWTpGcq0FrEqWBfhIh1AwT51A4D4AFHDLiingaH3Xlzs+snuB/V?=
 =?iso-8859-1?Q?SRK/E4wJaEHuOoGJK7pw7SVXOyF1zzYpuTeMwbxN+ioAEn7hVxRzGxlhKu?=
 =?iso-8859-1?Q?kfjx7X4i6xP1chxaEzVt2c5AEN6CD7SfMdANnNn3aqs+0ignzBaD6iKAw+?=
 =?iso-8859-1?Q?MABggPSJAahuxPfflE7VQHz8hChZRvxFRy+fRByEeSBXWn/XfAYyvAY4L1?=
 =?iso-8859-1?Q?JUlT9TxVm8AUqf3pmbCqIxKObkZ6ZV3Lhr8wY1vZLP3WzNFFRyopEH+hrS?=
 =?iso-8859-1?Q?Wnu4BNEy/nmZByfJi25gY5byJHQbe/3chqEfRQRGVQn/Wr/vrWHIwTXeBp?=
 =?iso-8859-1?Q?qIcwUY/XHtnLVEa7mPs3NWIdHV7LNtn/sYtMq+xTD/EjVWeRe6uaQEucWL?=
 =?iso-8859-1?Q?1+zByn64DwmdHDZELPsZoHwR+OpyxVPbJXUkvd2FxmRnXr9eYLPF7CYfX4?=
 =?iso-8859-1?Q?Wa3gMQG+1S4B71UKYtWr9k36oIxxNcS4uIyBumdW6oZ/OnzN+2rWMLev5i?=
 =?iso-8859-1?Q?W2N51UZSiwvgy9rY7DS8AcNHuou3ISq8fiXniYm7buOxQEHkV7WOQEcEzK?=
 =?iso-8859-1?Q?kody5t823/naqLC3jUo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c978a58-73df-4a35-4840-08dac992decc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 18:29:46.6528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mxPKMtaPVHiUoduwLeNeHh/JzP3vlcA9m41fyNd3AixqZIiBfeZtkHwyLAMD17Hx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Hi Geert,

From: Geert Uytterhoeven <geert@linux-m68k.org>
Sent: Friday, November 18, 2022 12:42 AM
> ...
> > &spi0 {
> >         #address-cells =3D <1>;
> >         #size-cells =3D <0>;
> >         num-cs =3D <4>;
> >         cs-gpios =3D <0>, <0>, <&porta 1 GPIO_ACTIVE_LOW>,
> >                    <&porta 7 GPIO_ACTIVE_LOW>;
> >         status =3D "okay";
> >
> >         rstc: system-controller@0 {
> >                 compatible =3D "amd,pensando-elbasr";
> >                 reg =3D <0>;
> >                 spi-max-frequency =3D <12000000>;
> >                 #reset-cells =3D <1>;
> >         };
> >
> >         system-controller@1 {
> >                 compatible =3D "amd,pensando-elbasr";
> >                 reg =3D <1>;
> >                 spi-max-frequency =3D <12000000>;
> >         };
> >
> >         system-controller@2 {
> >                 compatible =3D "amd,pensando-elbasr";
> >                 reg =3D <2>;
> >                 spi-max-frequency =3D <12000000>;
> >                 interrupt-parent =3D <&porta>;
> >                 interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> >         };
> >
> >         system-controller@3 {
> >                 compatible =3D "amd,pensando-elbasr";
> >                 reg =3D <3>;
> >                 spi-max-frequency =3D <12000000>;
> >         };
>
> The above describes 4 individual but further identical (they have the
> same compatible value) devices, while above you say they are not identica=
l:
>
>     The IP at CS0 is a bunch of miscellaneous mgmt registers.
>     CS1 is a designware I2C master/slave.
>     CS2 is a Lattice dual I2C master.
>     CS3 is internal storage for the CPLD or FPGA depending on the
> hardware implementation.
>
> So either this should be modelled as a single subnode with 4 chip
> selects[*]:
>
>         system-controller@0 {
>                 compatible =3D "amd,pensando-elbasr";
>                 reg =3D <0 1 2 3 4>;
>                 spi-max-frequency =3D <12000000>;
>                 #reset-cells =3D <1>;
>         };
>
> or as 4 separate subnodes, each using 4 different compatible values.
> Giving the wildly different functionalities provided by each, you also ne=
ed
> 4 binding documents.
>
> [*] I'm not sure the Linux SPI core actually supports this yet.

Thanks, I was unfamiliar with reg <0 ...> with differences between
the nodes such as reset-cells for one and interrupts on another.
Below dts boots ok and will change binding and driver as needed.

&spi0 {
        #address-cells =3D <1>;
        #size-cells =3D <0>;
        num-cs =3D <4>;
        cs-gpios =3D <0>, <0>, <&porta 1 GPIO_ACTIVE_LOW>,
                   <&porta 7 GPIO_ACTIVE_LOW>;
        status =3D "okay";

        rstc: system-controller@0 {
                compatible =3D "amd,pensando-elbasr";
                reg =3D <0 1 2 3>;
                spi-max-frequency =3D <12000000>;
                interrupt-parent =3D <&porta>;
                interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
                #reset-cells =3D <1>;
        };
};

Regards,
Brad
