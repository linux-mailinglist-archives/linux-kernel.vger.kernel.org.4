Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04F262E469
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240509AbiKQSiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240579AbiKQSiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:38:03 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2C886A48;
        Thu, 17 Nov 2022 10:38:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZWj2TzLZV432yg2zyS5c1qOy33+dfuV7Re52NFhvpFtREBD2WmG/7zD3RCGz/CLve1PK5tM+Wv2X5M5gHKtbzRZ4Su3AKjQOZZ8lhM1t5FXOvNHtDf+CniIox6VzwO7Z96qySwUEN+ZKdQAVH7u037yLWZv/jxU2iLoa5Ms+Oy2YbzuYFj0+ftr3pll7EYbLzHKCCj3uLnaUkAhG7nKXpP0pBJi0yPDI0koBbXAf5GuLF7cGAtvWz8aPFdccdcPe1NY5bi6yZfe5RP0DnnJULaM1RxNNwLSBo0Zz86g9xKT3GEbLM2g+wH9BZAHARBK6V/L/MthdTokmm8bu9UYsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0eHoQ4k5vpOUzICzK9YN5cgS/da9ul/k99z3DLULNs=;
 b=NFB1nExGevgwqPmD/QBGkFlyKjMrmiu4NEf4kMuuGr6fPJDIY3qKbPcf05pA4LqG2vOqBeHnH+2r0w7Jn5YbO/frWVPasKE8IlUgajPev/HBacX+C+xDhS1T+Uy9VvE5IiFJJgD3lCQyMCL6Ix8wR9jcvqkJiPQ+xJhcSoJMT/nX2ACj1QTBMIkh7OINeXRGBOZrraXiSOiG2QXvDx2CmX5QIFTGRL5nKmKZhW50KVBa5A05ExKawZ8Js5BVUppfKvhS3hHuQiCKVEn+L7LiyYCoSG49fGSOjc12d8UtTqpcr6GK0axw2pi1LM1DPKNIJ61hUto1OjDNQUdRPuhjNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0eHoQ4k5vpOUzICzK9YN5cgS/da9ul/k99z3DLULNs=;
 b=MpODeiaXGYEzrQvp/E4bDMRwsjrOsDLF8h1nztyozLYJWknpS4qg4kg6wwuUMr1wCt/JH8AcwZm/Bl3lXaZDNx/peWj/8GDtRM2AG/9LDuyRsvTuy1fvulmSUNAh4gneTOIczRY1EmqFqkG3kMCiYYg1kHkda53Z5+DqP82YhFQ=
Received: from BL0PR12MB2401.namprd12.prod.outlook.com (2603:10b6:207:4d::19)
 by CH3PR12MB7620.namprd12.prod.outlook.com (2603:10b6:610:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 18:37:59 +0000
Received: from BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::25d9:dbb:b557:2664]) by BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::25d9:dbb:b557:2664%5]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 18:37:59 +0000
From:   "Larson, Bradley" <Bradley.Larson@amd.com>
To:     Rob Herring <robh@kernel.org>, Brad Larson <brad@pensando.io>
CC:     "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
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
Thread-Index: AQHY+fMz1mOoRsElvEWbbkYxqhL2uK5CIjyAgAAkCRyAAR9miQ==
Date:   Thu, 17 Nov 2022 18:37:59 +0000
Message-ID: <BL0PR12MB2401AFF244ADF7B026935A419B069@BL0PR12MB2401.namprd12.prod.outlook.com>
References: <e9d8c14d-38b3-0401-7bfc-b2bd7ab36c52@linaro.org>
 <20221116193940.67445-1-blarson@amd.com>
 <20221116223045.GA1130586-robh@kernel.org>
 <BL0PR12MB2401ECC21B2EA83A5D806E369B069@BL0PR12MB2401.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB2401ECC21B2EA83A5D806E369B069@BL0PR12MB2401.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-17T18:37:58.918Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB2401:EE_|CH3PR12MB7620:EE_
x-ms-office365-filtering-correlation-id: 62a1f186-7352-46d9-78d8-08dac8cada01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sI9o3h9Uy82XBQSt3FB9ymFOOiR5tLdLqgPJxJFu75Zs5foAKBsyMtBI39h0zC7ppAwrct5ziqMhnOhZ+YihLMgBMXvs/BSmTUuRUxOcJhUya4kufWmzGKu4KcTxHzYMHsf0HXwpvUDrL5k79+KWzJLBxVi6sS1/kGvhV4taWitRtdTxtTiq/TBj1V1OzYbQ/vSYrtks/UMbQLAO5FQxIvW+MOUBFcuNJGjlyks/0aimoCHE3CH7cNThQjv5+xKq9uTg+DHp4iC2pm/hUmwNFXyzjZKwVdvU3AgJ14RnWz/frh37JMBQ1+d1T9k1/+HmCQQXoKNJjK7pMiYTC+L7zMna+DX6plogEpgdVPoAYspZNhW3eGSIX17swh7kbJCgP78iBlyfroZjrSKgXu9ikLTzdTlxDLiPIHu2YT1CQztehgwGLF+OMzBgyp54Vjb8SCUbQ53IuGsWXb1o55CS3Je6TRjLbHGaZgc+ruTDEK/9Mk442HyRjeKqZ4JSHeHhMwvG/jTHYNub8cnn/w7iFkP/lPA9toOW/VmyPFMUbWSg24CPvkR0B6SN9wjxznFdCByo66zWkP+CbZgjGMlwvl9GsxkRIYlorJYV50+Ubbqe5izOqf5Aw7YLX+xO6418XQEWmpAz5Jd/jq/jaPGerF+3mJi9O8UukRoWBo3jW7luXKXgPLdITIcToF7STsOwjSgdSkkKK9+qnB5NNf4FLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199015)(33656002)(38100700002)(110136005)(7416002)(66476007)(2906002)(4326008)(38070700005)(52536014)(8936002)(83380400001)(66446008)(122000001)(86362001)(91956017)(316002)(76116006)(186003)(478600001)(66556008)(66946007)(64756008)(8676002)(41300700001)(55016003)(54906003)(5660300002)(9686003)(6506007)(7696005)(71200400001)(2940100002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1bq+bD64M5mUThZDgRXuhRG9NFiySf2kJ3VnDjBuC7zZmIiLj1xrmp5s4t?=
 =?iso-8859-1?Q?Uq/51SkK5xyxdfMs6rA394Nv3tQhz1LS4rrBc4Lqzg4lnPUoTnHLxwgoAs?=
 =?iso-8859-1?Q?swHzDlUm+USw+Vm0NJ14K27R1y0weeb04ByNhEbY2VklDzLTEYuk+GsANk?=
 =?iso-8859-1?Q?T3mMJcg34BkMNMVGVO3fUvtRsjD95wQRR7Ep0kf9MI1DyaXcuMPrZ/sRD/?=
 =?iso-8859-1?Q?g40IE08NFOdSKx0szdZmShNUEqpVFSw6zEdqnvf2nSwTvUUgFIjvt4WkWR?=
 =?iso-8859-1?Q?Aq6TScJiTCiOjwmCJXqGD0kvY5xadHO/VEc2jKQOsxfGCt+kq0TdEvoXYJ?=
 =?iso-8859-1?Q?MwAUueCYQV+HOIFuTXbFx1lTLDHLCi+jKjE9sxjGdiyEEjG78/pxfN2nFO?=
 =?iso-8859-1?Q?MN/855XhHNZXb1Tjiz/aCeL72JpqP9HMxXf1hW5z9nnHJ5XuDGBN21XXYG?=
 =?iso-8859-1?Q?uVzr7Wh9ILEz9fMXNSkyeMOTh5UIYq/Lx346v/FFVLNf2fkx9cxem9TO2x?=
 =?iso-8859-1?Q?qPdKh8daF2oChO5nz8LdACEBK3diz4U6c4x6I7vEjH0DZATDXtdTCPVZO4?=
 =?iso-8859-1?Q?fiMJCCV09N9ro8uX7QK3whch9ZY+be2NuE7bs+IWnrTJzAswQ1QDE0atKs?=
 =?iso-8859-1?Q?a8faZW0vQGhzyCPYUKWAA8ncOLayEqhy2fKVhZpl76W573VlX/TtZ4F0bQ?=
 =?iso-8859-1?Q?GvXhbL3zOHBNk6KTj44XVloATy+kJrFXbfWuyARJPRPbu93cot22ugTA4F?=
 =?iso-8859-1?Q?QtKL+6YodEKZV4Ooa59DZg4vZ6c6hefklId3m6fPgCJPz2udwasZFX6Ih0?=
 =?iso-8859-1?Q?oJFHJNkm4c5KXEmqZgyk2IBtxW6I0xcZyQe0s08T/8CJrWM0kgH+yhdZYm?=
 =?iso-8859-1?Q?xfxeQYYJTAxzeWz+i1H0somAJo8rl6Kui+uN0V3bFhoQq65QwI8pLUg4sd?=
 =?iso-8859-1?Q?YqZKBh3ltNK+6VIc5DlrQUFxmG2iETfU9NnyVfWlhes6yk9VmlzOzoJ6F+?=
 =?iso-8859-1?Q?pD8o1cFrzgaLndFLvpR29vGDY6bfBjHAglWqbEyluvsgvo60r5brmj7pCD?=
 =?iso-8859-1?Q?Hsw8f5e4DlXaG001In+4IqmcQ1CXlv9DroC33qBTUU+1VBhVXcQRyKI5DS?=
 =?iso-8859-1?Q?e2QmCj48s13FQZen7H1Fy0O6t8YoKnNX+hNLOBkibe9WWKmIGA/ReYOLFN?=
 =?iso-8859-1?Q?p+95Epm2Q1TiVkrn4DENYh9zAOYo2df8+aVQoQEaa4CHf90MISo6tMzXB2?=
 =?iso-8859-1?Q?eM+AbHmOUJK6uPPcNtyUth3cCbf5v4ALzZEuBGc2MNTBmblyWbWcPKYknX?=
 =?iso-8859-1?Q?kd3239JY3qSu7epQMvKX/yeNzkSLckzLFvYEOYhXfXZzmGqfvkZPVz6WOL?=
 =?iso-8859-1?Q?CDa8yCGrOZkaxyNl7S974jvH+7xuxTAmZrPyKXlFxy8ujySd/woTIiGhPK?=
 =?iso-8859-1?Q?tE4JMhhv2boghpb9mQlQv8jJCCejtw2ihw0PO9T4+b+PHos9+MuU+tFq9B?=
 =?iso-8859-1?Q?jnStorkZVJ5oxaSfL67aMSuI5+WUFkwpw+a3h9OLK1/dyaLU1l1ZxADF//?=
 =?iso-8859-1?Q?HraLlATUtQFlhaT2fZfidR4mezgC+6aUyzcYJXuHFMahbwIe3rkzUpLL0S?=
 =?iso-8859-1?Q?ThXzP0yMS7k7nJVu5RJVB33YSiuqATd7I4PwRjUS8HwuY3jeoUjyAXT3UK?=
 =?iso-8859-1?Q?u1eJmShIZAxPCwLwqRU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a1f186-7352-46d9-78d8-08dac8cada01
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 18:37:59.2200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Gv2uh9sUh0iu0wYS6rEeCr5CmBjm2rmXOTE1XCGnHyqE+g+aiIW4jm3dTgR3P1u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7620
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

Hi Rob and Krzysztof,

> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yam=
l
> > ...
> > > > +
> > > > +title: AMD Pensando Elba SoC Resource Controller
> > > > +
> > > > +description: |
> > > > +  AMD Pensando Elba SoC Resource Controller functions are
> > > > +  accessed with four chip-selects.  Reset control is on CS0.
> > >
> > > One device with 4 chip-selects? Then I'd expect 'reg =3D <0 1 2 3>;'
> > >
> > > Hard to say more because I don't have the whole thread nor remember w=
hat
> > > exactly we discussed before. That was 100s of bindings ago...
> >
> > I agree and the example for v7 had all 4 chip-selects shown.
>
> That is not what I said. Look at 'reg' above again. You have 1 device,
> but you have 4 nodes which looks like separate 4 devices. The
> exception would be if what's on each chip select is independent from
> each other.
>
> Describe what your h/w has/is/does so we can provide better guidance.

This is the hardware design for every implementation with the Elba SoC

  Elba <-- spi --> One FPGA or CPLD (4 chip-selects)

where there are four functions in the FPGA accessed by userspace applicatio=
ns except for emmc reset control which is a bit in a CS0 register.  The IP =
at CS0 is a bunch of miscellaneous mgmt registers.  CS1 is a designware I2C=
 master/slave.  CS2 is a Lattice dual I2C master.  CS3 is internal storage =
for the CPLD or FPGA depending on the hardware implementation.

'reg =3D <0 1 2 3>' in the dt fragment below is indicating the chip-select =
which is what other bindings appear to be doing.  Maybe one answer is delet=
e this and add our compatible to spidev.c in the patchset we provide to cus=
tomers.  Adding our compatible to spidev.c was nack'ed. Recommendation?

Not including 'reg' results in this compile warning:

  DTC     arch/arm64/boot/dts/amd/elba-asic.dtb
arch/arm64/boot/dts/amd/elba-asic-common.dtsi:73.28-78.4: Warning (spi_bus_=
reg): /soc/spi@2800/system-controller@0: missing or empty reg property
arch/arm64/boot/dts/amd/elba-asic-common.dtsi:80.22-84.4: Warning (spi_bus_=
reg): /soc/spi@2800/system-controller@1: missing or empty reg property
arch/arm64/boot/dts/amd/elba-asic-common.dtsi:86.22-92.4: Warning (spi_bus_=
reg): /soc/spi@2800/system-controller@2: missing or empty reg property
arch/arm64/boot/dts/amd/elba-asic-common.dtsi:94.22-98.4: Warning (spi_bus_=
reg): /soc/spi@2800/system-controller@3: missing or empty reg property
  CALL    scripts/atomic/check-atomics.sh

&emmc {
        bus-width =3D <8>;
        cap-mmc-hw-reset;
        reset-names =3D "hw";
        resets =3D <&rstc 0>;
        status =3D "okay";
};

&spi0 {
        #address-cells =3D <1>;
        #size-cells =3D <0>;
        num-cs =3D <4>;
        cs-gpios =3D <0>, <0>, <&porta 1 GPIO_ACTIVE_LOW>,
                   <&porta 7 GPIO_ACTIVE_LOW>;
        status =3D "okay";

        rstc: system-controller@0 {
                compatible =3D "amd,pensando-elbasr";
                reg =3D <0>;
                spi-max-frequency =3D <12000000>;
                #reset-cells =3D <1>;
        };

        system-controller@1 {
                compatible =3D "amd,pensando-elbasr";
                reg =3D <1>;
                spi-max-frequency =3D <12000000>;
        };

        system-controller@2 {
                compatible =3D "amd,pensando-elbasr";
                reg =3D <2>;
                spi-max-frequency =3D <12000000>;
                interrupt-parent =3D <&porta>;
                interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
        };

        system-controller@3 {
                compatible =3D "amd,pensando-elbasr";
                reg =3D <3>;
                spi-max-frequency =3D <12000000>;
        };
};

Regards,
Brad
