Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B1462CFD7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbiKQAlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiKQAlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:41:51 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606485F86E;
        Wed, 16 Nov 2022 16:41:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obdlDYcb38zLWneXTBxsMLuu2djMmq8ZxOQWslncYB8/WXkkUmASqwspIPQNVzDK8xSS+d1ULkhR5tpNsy9fWR8xLOtbVb8EczkdcZRM68lRzWq6Kp58FL+g32icSMUl3G0e/Viy89KrjoGtcKjFg61g4y0dK9SekkWdrZutrdBpeM6le6z01waOU6PeatJHrCS44RRwqz7OwKyWDK9a1hUMmllztwG407DsTZieylT4Oo3S9cf23VFG+ikBZHhYdzRltaIZQ3wlju0peyg/y+U4J8NUc6P8FEY4F2cyCGrugz61Mskn+KCRgVrdzHSfU9g+F0xEO0b/EmUVywiT7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyygnzYN+OpTPryeU9H2yFReewtOdaZu4x8HjEzRq8M=;
 b=ZgaSJPIAGp5Ps/cGMfJmYXV/Aop6cYEn0+/0Sp8pkzC6ovfjyUkAL3cCoScSvFRNbNAqSxcKzAZx3dHp7Y3G+XTZL295QFTVAaQaTcbj18TGRYHvj93oiiIWQQMVuSbXaFlLbjqi0dapOjCeMfdIEy3OBu35D+SGAw0bUStEm71l/P9dlaeiFkhCUqMdGgWORIvzhaxLLLDoX2V+SLgUfunjpLsW7IicEb3ebAvgiwPfaRTBkOvoFvnZvWurBlwi9lgJ3QRfUCYmWgAqrVWnJV2yXOkijMWFo3tW2GnxLDUsEKTVRTp3BUvGhjCwvY4HKnxlGla0xWnrizy9TXs5pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyygnzYN+OpTPryeU9H2yFReewtOdaZu4x8HjEzRq8M=;
 b=mfYoRwj2v3qVPK22bzhZEk5xOBqnoUIgb4UsbLb6V7M6IA0aN5Nk26gLP/5HoE+5Fs7c+NSNatoMfDwO/de6+tsR6lNcLSII1B8qCsByV2K9LoZ2tEtt58r50glmc4mXRPNRhZvKIBv5BZ2V2/fImDrhuXXmsQT8wPhxyCcWE48=
Received: from BL0PR12MB2401.namprd12.prod.outlook.com (2603:10b6:207:4d::19)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 00:41:44 +0000
Received: from BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::25d9:dbb:b557:2664]) by BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::25d9:dbb:b557:2664%5]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 00:41:44 +0000
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
Thread-Index: AQHY+fMz1mOoRsElvEWbbkYxqhL2uK5CIjyAgAAkCRw=
Date:   Thu, 17 Nov 2022 00:41:44 +0000
Message-ID: <BL0PR12MB2401ECC21B2EA83A5D806E369B069@BL0PR12MB2401.namprd12.prod.outlook.com>
References: <e9d8c14d-38b3-0401-7bfc-b2bd7ab36c52@linaro.org>
 <20221116193940.67445-1-blarson@amd.com>
 <20221116223045.GA1130586-robh@kernel.org>
In-Reply-To: <20221116223045.GA1130586-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-17T00:41:43.487Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB2401:EE_|SA1PR12MB6971:EE_
x-ms-office365-filtering-correlation-id: dcdb77af-c015-49fa-84d7-08dac8348038
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UJ567NnDzyYtucI9TCc1Rm19fazltxlkeB4f1RvOoM9dsR2nUrqCE3iz8mKlmUpbUi1pJ0N4bVBEHuKPyW0rYYIuH7CzlrOgf3SosDS0a86/Fp8ceTgrBUC6qbMq6wpGubNropxFE1ckx8hOt4zSBBm0+pVTDMs1flo686AW/+o8+3rYYH+xNcZxY1op+9rCNNDuje1PfARL0IuxqQ94bmmTD37vVm2grM/7DB+WUWlcdgUQFL33Z1Xjrk0cM0KHQFcHilTwyV2/r86G3K1A3XxSh1Kl0R3wVEBsWg9n5JcFEOtgsYOp7VsLWiPs+w2mM3K5L7MnYxhLMUVIEcsAZIhAfCJwcppTM3WETyUgvA1AO5Vn+58FyGAq+z9YXd/7HlddeMbljTzJ0CgGqX9aQUDafwfHEZPmabB43d8vvkrMKixYcYs3R6NOVw4iwnsfPdJHnMLUB105NKJew8bxSVjliW+gjTxMGss3b6Ucl94+OMsw1iMpYEH4S6Q5BXhxRzWUkWaEUW5GYUSAMVmmuyYYivaSYoI+/hpkq3Poc84TaQpeDo116+98xUm0OizM+mhRT5HxfsLRYNXOo7k6eJUW2c0k5wCTtvnBN2wwCpaHv/nkFCV20+Rovpe6h1qtu553VnuNrESMIjqrx+MbMLowFYqQYmsfkzTQzo29bBq+cGiISOXYT5KIW7ds0MY2pL8Rhu50zVwsG8gHefKd9e3AWKVyJplmXqRCeE5gLKwd+4IsEiyY6Cb19yiLNJJRq0Ay9pfBJEIq4/s+Pc+bFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199015)(86362001)(38100700002)(55016003)(33656002)(122000001)(38070700005)(26005)(9686003)(91956017)(71200400001)(186003)(316002)(7696005)(6506007)(54906003)(478600001)(110136005)(83380400001)(2906002)(66446008)(41300700001)(66556008)(66946007)(66476007)(76116006)(8676002)(64756008)(4326008)(52536014)(8936002)(7416002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BrVWEpSZ+WhyefGnLqCfDlI6OO//Ho2uClvkJBpEHKY7+2qJg0L1kwIm2M?=
 =?iso-8859-1?Q?X3MDoyYwE2lRlvOX50TukUn424h3Q4DLQ0qNwMFNAgVuS2c5QuuduEA2Nf?=
 =?iso-8859-1?Q?l+L4YQ5UnTdy2JUEEZzuCPftFb0JkoXXb+aonnVrfwmLfRnbwWpau3/Xkn?=
 =?iso-8859-1?Q?RMu7zQBBSZpcBj3AXzWS5nVTjDPYmpmKfv4/MRM/azvnaiPS1bmksoAlde?=
 =?iso-8859-1?Q?KRD5kH7xq4DW1kN5AL6m8Nk7btVCkQXCHs2QOb20la+XqwcYbtiAKRqtLL?=
 =?iso-8859-1?Q?6IGTzAwJEwYXlBGpForH99lIlxda8xHCgVe46EVOW6hG7yXIhf1T4OsE37?=
 =?iso-8859-1?Q?yjtMsNpyq1RVk2S2WckVaz9H4HI9lP4aaauwrqtA+F5D8Q/6nnz1dPmCwC?=
 =?iso-8859-1?Q?BCyse1NVA/xt0c0qFnCQzSxvfVdTE+TBb7pEQvCx6itswHdcWIhuk9xOUU?=
 =?iso-8859-1?Q?rffX0rL+x79wTOgIJcnsjw68ZKNBDHoxE8fiyqd3NBjTFwlKMlrx1bt+Z8?=
 =?iso-8859-1?Q?5ljFMatazzpZQPGkk7mlfR9EhUdb8NhDy4QlyQSfikr/Usulymcohb6rT2?=
 =?iso-8859-1?Q?vhigPqRSsLL1lqua/g3WLMb9nxnQlzA7QuxEUNV/dIb6hylpnt5Ys8ANwW?=
 =?iso-8859-1?Q?T21f/eb9msJtOuBjonNyLbFIiIzTIm68Gqged7c7qyJFRzd+O5naHl8Yau?=
 =?iso-8859-1?Q?r2NR33K3BM/RImt7PogHF6mUz9AQs4hvbwa6yn3o4eOh6ADLFWQhlvJUvg?=
 =?iso-8859-1?Q?qogIFkjgmsDJ6CRKO/TnjHnDN0OManNh+nOdAXY7p6fyYcc1DSoxzlPcbW?=
 =?iso-8859-1?Q?B41DOWZvH+W6Wsg1E1OJ0QxGm3B12KL8twdu9/tnPzAvw4drbYRIXfOXRe?=
 =?iso-8859-1?Q?7Vl4wa4K8HamothmXHdvzP2QqBpoGmKj4oqk9137S56yQDo/Q2V2eyqkrn?=
 =?iso-8859-1?Q?W8hb5beMU1EYGDsf4vuhKY7JbfqzFepxBaa4cBSbpt521ZkTuRFF6uKQBW?=
 =?iso-8859-1?Q?d3sQPqEski15O2SE2GeFZKA7kDe225XW3yZ5LLy33SsTRCes1kPlyUdybK?=
 =?iso-8859-1?Q?s03dOVO6SyAl4+GESHBcYL1evrSqkojwPsDKsHoMjfvAQLWhxeYTZ1dT+R?=
 =?iso-8859-1?Q?lMlNTWjyu0UbjWQXFMaSBoj0/zWq7rgBnhA2Z/p+AJFTPd8tNyq4oMqPO+?=
 =?iso-8859-1?Q?Ab8puxM+ianaQl0LQJmv9xsfovW1uo+kwH38ptVikxaByRcfAT3KasDA4K?=
 =?iso-8859-1?Q?7frHdB01VuwXrMQiocbYC3xqnSF6c926i+LplqJxHEPwykj+I0RsUDZfEQ?=
 =?iso-8859-1?Q?gDy+fd8bAwzJgQp6E4oCxfeL3NwuY179Y/Fd2erUiVkhbZpnPzLltXbjOk?=
 =?iso-8859-1?Q?e1Y2ciEkJYLGGIWGNo4qVrO4JqhtjRnHGdRzBdvfDY3feMdHXegzRBQ3ri?=
 =?iso-8859-1?Q?vwseh8hCD7cWC6VlVhPtr0A6qdM92s6vkNsXk59K6X0DJnf8ikVRbZuZQg?=
 =?iso-8859-1?Q?4X5b3wVhVa+1oR3TGn6/okxNahhkJbEmXR1G9eCXrGJSg8PI4XntxPYpCQ?=
 =?iso-8859-1?Q?MOcYZjEgBcU2tmHkZxxIdcEh9axsIb7K9H4hLT+ZW2eKRCoXSVBfQs6jHD?=
 =?iso-8859-1?Q?dQEQnnQnKtlFI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcdb77af-c015-49fa-84d7-08dac8348038
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 00:41:44.0920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UAFe6nV6Rn1K+tK+6g6nWT5BvgKtqQORuocktmc7piXfBnfONGF713gyEyEjIY2E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971
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

From: Rob Herring <robh@kernel.org>
Sent: Wednesday, November 16, 2022 2:30 PM

>> v8:
>>  - Apply review request changes and picked the two unique examples
>>    for the 4 chip-selects as one has the reset control support and
>>    the other an interrupt.  Missed the --in-reply-to in git
>>    send-email for v7, included in this update.
>
>No, you haven't. By default in git, you don't have to do anything. See
>--thread and --no-chain-reply-to options. If you are messing with
>--in-reply-to, you are doing it wrong.
>
>Please resend the whole series properly threaded.

Will resend the series

>> diff --git a/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.y=
aml b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
>> new file mode 100644
>> index 000000000000..622c93402a86
>> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
>> @@ -0,0 +1,60 @@
...
>> +
>> +title: AMD Pensando Elba SoC Resource Controller
>> +
>> +description: |
>> +  AMD Pensando Elba SoC Resource Controller functions are
>> +  accessed with four chip-selects.  Reset control is on CS0.
>
> One device with 4 chip-selects? Then I'd expect 'reg =3D <0 1 2 3>;'
>
> Hard to say more because I don't have the whole thread nor remember what
> exactly we discussed before. That was 100s of bindings ago...

I agree and the example for v7 had all 4 chip-selects shown.  This is not a=
 pick and
choose device on what functions to use for a usable system.  Krzysztof requ=
ested
only showing two chip-selects in the example.
...
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    spi {
>> +        #address-cells =3D <1>;
>> +        #size-cells =3D <0>;
>> +        num-cs =3D <4>;
>> +
>> +        system-controller@0 {
>> +            compatible =3D "amd,pensando-elbasr";
>> +            reg =3D <0>;
>> +            spi-max-frequency =3D <12000000>;
>> +            #reset-cells =3D <1>;
>> +        };
>> +
>> +        system-controller@2 {
>> +            compatible =3D "amd,pensando-elbasr";
>> +            reg =3D <2>;
>> +            spi-max-frequency =3D <12000000>;
>> +            interrupt-parent =3D <&porta>;
>> +            interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
>> +        };
>> +    };

Regards,
Brad
