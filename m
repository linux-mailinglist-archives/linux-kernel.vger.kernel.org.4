Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0726289E9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbiKNT4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbiKNT4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:56:07 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2124.outbound.protection.outlook.com [40.107.113.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196455F80;
        Mon, 14 Nov 2022 11:56:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEs3VX6KR092SLjJoc9D/s8We98U1tp7k/UrlrusufLTjOw1DrigLnZfSmh3ROK0EQElSoVxGb0ZU3TAmkKrSdBVOKF+KrYBK6htv1ZewYlyhNZ2kUERGwGWWmLBIJij6/yqJ0TVeupDH4w3cZ3LXKByzbCKRqi9Q8j1zTlHw29eyJCGMq5juZLC290CYacl4emuY8i4VanrzVpB72tbDtANgI/t/5ECvjQH5USwHCd1adOP1qWtiWWZO3xvPQKJrISBtlffUBU7GaMwns496AteOSMOp7KDCHescutzRsfNNQJtBxmPc0ciNdcvfKnvIk4Z4EJuP8rAI4BallNRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/SFkT6h1oZ5GShOmjuW1vfSNgwOa8q4oAZiTxeVpUc=;
 b=hYNclWB4wjuP+ymLG8dfOVj0OIT91tTUGwN0pz78VdxbVKGyErttdClWwYJZ8Jxw25UhnkgjWxt3iUWMKb+cU80lbbyai+6B9bKzUyxqceLBfcZYHOfuZBdmMHUX3O+nBKq7nQFBY7sW7sTv1o2uT20sQ9LyS5VmjQDb9D0DTYNJNi+yWip7NahMxw78AruiEG72AMPNWzQRbyxJFMEIrxOFgK8UR69LeMYVRMvRk7q1AcqvUYWw6p0zIi/MZnycPYin0CyDP3/2uow/MQPboqI77aNfUcRmYWk9STPmghn9LSKINbLCo3gpizEj7czuOe1tRMFSLl0T2ndHvpvx6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/SFkT6h1oZ5GShOmjuW1vfSNgwOa8q4oAZiTxeVpUc=;
 b=SoOA+seVpktUpqSJ561szFOB8lKh4L485V8awioVajgWwFlPD8v2XEbRzJnxN7lnGX8yH72mbuF6OYCQPlgoUy6VeJZxsTVatFhm7izMUo8jv7IiBiV9vhj2GChLvNTYG0heTLV3K7519QPDuxxp0qXLjExRQt8s5ZoYtbPGTmc=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB7895.jpnprd01.prod.outlook.com (2603:1096:400:184::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 19:56:04 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5813.018; Mon, 14 Nov 2022
 19:56:04 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Detlev Casanova <detlev.casanova@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marex@denx.de>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:ARM/RENESAS ARCHITECTURE" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: RE: [PATCH] arm64: dts: renesas: r8a77951: Add reserved memory region
Thread-Topic: [PATCH] arm64: dts: renesas: r8a77951: Add reserved memory
 region
Thread-Index: AQHY+GJCXYcA+xTX10eEM0Sf9MBXjq4+1M2w
Date:   Mon, 14 Nov 2022 19:56:04 +0000
Message-ID: <OS0PR01MB5922888E58D92CF72ABC95EB86059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221114194846.108814-1-detlev.casanova@collabora.com>
In-Reply-To: <20221114194846.108814-1-detlev.casanova@collabora.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB7895:EE_
x-ms-office365-filtering-correlation-id: 379e2cad-dd59-49f4-c3fb-08dac67a4321
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dCPrU1jihw3Lb/oVKTGMaDhOwdhDifR/9/ZuMdUbYHSoKDjzxtZ8/vvqJoI5ZrYtWzTk4YNzBpD+oXlaTk8zWuImXoaIqDMIwAFZAUYxTX4t635H4i2meuyDFIj8Wu24Ua+1QhI8V9fQjp1YtIgAnviSnb2iCeJ/OsGgZsO4Nn3Q2E3Te+JSB8RFLOfajbXAtJj9NaMbXbLUfJLwecnhUYxDNC1OlsACE33pq731DAmb1+yf2oOCL4h1tv6dXxiJSf+vpC1LcVeRneqF27n2lBpj9/8PYyXIVpIaeWN3jUq/XF+ZFTnuuiJy9ksxFyClw/Onc87QMQPfFgSR2VTU1qjBJJcp/LaBPaeGdS+cDuwuckfqcvlZvD5Q8t3I1scquN8HaAQ1AgHi12tKxsYHVU4tzGiXE1Z+m6S02/xrv0d9ZKVIiVE2JZKVZ0eRTVNKuS3hcMZvqP9k7AMvz8etqmAIXFApppc1ZgwoXTD5U/Ulbd0bSL9zf6Asx1oZ64dZTLNvYPVJdO2TBD4vpvQznLFN2QO++j5YF3k3b5MOjHMzBF6zRwaXw5QFHVY7L5mWik9GBdQ4g7Gah3C87H3nn11WD/oEsrMqG+fPWaCqkHpNfr89SQLBus+vYVIw0gN7/ru7/zqz1plT8JuhTYyXolt0kvitwCdWp53DLHSHtUoDnj7A1CHq4GMvdgXkho9p2Ag+iGVB1JSANF6VhlqsuFHB/j9gjiDg9EzwWqs4fdNwE8bUYHZLT7Zura3UNSEpQf3q+8Ang1Y9IXar1l2Ts/X1osLTbFyJbcoL68BBHBE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199015)(2906002)(66446008)(66556008)(66946007)(76116006)(8936002)(5660300002)(83380400001)(4326008)(41300700001)(8676002)(53546011)(6506007)(54906003)(122000001)(38100700002)(52536014)(66476007)(33656002)(316002)(110136005)(86362001)(71200400001)(55016003)(478600001)(38070700005)(64756008)(9686003)(966005)(7696005)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l/XUVceHrny0GSAB66IjunBznZAUczQ7K6q6EIPjixT/UXyqRCPLqepMJ4cM?=
 =?us-ascii?Q?oC6UWZodywyoBZFOfY+6UFSR4YQwF2JX999DkKBYbqSvjcdEoGhsLKyimYRB?=
 =?us-ascii?Q?6W4N5wMXYR4GIgT/zRDPsAotuw2MYsrsa9JEAqzJHWqXsdRPEHP0oKT1g1Yv?=
 =?us-ascii?Q?wwWd5CpLUaI1aWMM9XbdXERDqoi46h/YEYUXYsdqhejwCyxWIrOVZkAVQ6wY?=
 =?us-ascii?Q?2YPxw6ge/1Rs7GXF4tdSWAnLTL8x+TWtpYJbo6bLkInDpNX1xmJ/Io8XXC/s?=
 =?us-ascii?Q?EfIbTICirfe0tV6fYJ9lP+ysWdwBduqwtm71UQFlg/KntFweVMvVkTLip5TI?=
 =?us-ascii?Q?blbEpTE7st6qiVoLX280nPXis577r8yaUBlAMBz1N08cmUpVmuqNFgC5q6bS?=
 =?us-ascii?Q?aNxndsbvH3V8YJJg/p0FDIdGwmhV2bnYBUeedZk/OrpRaV6nGNFkfXQYWFaJ?=
 =?us-ascii?Q?abqp/tOr2OWk/M7ymUIYXKmq/dX86Rm9OgBBX0dEUhLUJscddQUwaKCH3sfj?=
 =?us-ascii?Q?nwYjuuQRhU83Kvt8+6nVe3JmG2Chsl58j88vn/a8ldL87s+QUR5nVicJyBAf?=
 =?us-ascii?Q?fdD7TdBQfuAywHtCrPbG+mJG/dHXueRm+ZxaM4q53qefsl8hTf6qtNvqrV6h?=
 =?us-ascii?Q?rAf9VfYkS4s5hltAdFNBt1jBBE97BnSd458sfCvJZPtkbHXMAmniLK+Gi9q2?=
 =?us-ascii?Q?Ouh8DiGXbmf4ishh7iyk448+scjjjQV8bsMMneWXAcwus13jnpEWRHm0So6S?=
 =?us-ascii?Q?SL6jxiKWj5stYr477wlY+9Pis4Sw7s+NeSEaBC0GcXCmp6ekHBAW+ut/s3Wm?=
 =?us-ascii?Q?BmAFgXKYD8MflEP6VG5/2VEG5DSDkT9uCy48rcIRjr8jJj0FCl9b6dr/tjBG?=
 =?us-ascii?Q?7z5H2ui6fCrO8MvgXT8Yp+20keDz2sc9Zfl4sp8ZJOqn+w7B3YQJSjhdXuZq?=
 =?us-ascii?Q?YADEwIWnx3l+AI6XwZMCI5IHQsQAiXlEZwQ4xLkyA15lffdP0YF9WdXfSgxl?=
 =?us-ascii?Q?cVDzxIT3T2BCHvSf97n/icsqrcjE2WXsd0aLa6+HfSMimi6GLONNGCC4+Bkw?=
 =?us-ascii?Q?8XIRIkJT4dZHZyQb9La14Vb/+iM686pi0Eg7X/Ld5tn19s5eBgwRSSaOFFvP?=
 =?us-ascii?Q?pNde6M1DgiCt/yEckWcYfoLsKa+JBCgLvztUUWumOyVpmzi59p3E0Ogvjb99?=
 =?us-ascii?Q?OlSwRAhPFJ4HyyCmBxN4t24lfFIjRXRhm/wmk/vS4DdoV2UVajeo5ffpRDrW?=
 =?us-ascii?Q?Ar0mSNnzUgTNnqcBFMH4vBP2IX/JepCw141Wlcn0cwKq+mwUVUmlAsUPRrvh?=
 =?us-ascii?Q?h2aioLtwhmx3df5v7JXXn8HMmRpmNuZPUcPAmOjq5Z9UERYdgvyf/amlDfor?=
 =?us-ascii?Q?6oUYjuT9ksdCyZvY3On1lCHoUyIXKUQYE6JbFOuAi1vDbwusZa1pwy7DmLkZ?=
 =?us-ascii?Q?i/r/ZLn5mOr6x0QlfBd7mzn99seSfAbR7U1AKdGiLwB6wOcW90IhZC1ijsJK?=
 =?us-ascii?Q?xco5Brqzki2FeHkHl4Wsc8DUE15/SfSILYhoYzk+SnPnoUEy6AUkj2SnlFDz?=
 =?us-ascii?Q?WRaXDPV6v3J8b10UW9apo4IxLYZ+XfBV4iuzoPpVqV0NJRhoSbKiTcJtH9Ib?=
 =?us-ascii?Q?AA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 379e2cad-dd59-49f4-c3fb-08dac67a4321
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 19:56:04.0630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jmg9CCmmwJbArXFmPYQ2sg6YqE9VHljoTnl39wrYwR+qR04fiNFjbYbv9cBEn7GqVSntsnmiLamJAsOE0teIFLf2c/7WH0T3NvWBhNCVXb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7895
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Detlev Casanova <detlev.casanova@collabora.com>
> Sent: 14 November 2022 19:49
> To: linux-kernel@vger.kernel.org
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>; Magnus Damm
> <magnus.damm@gmail.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; open list:ARM/RENESAS
> ARCHITECTURE <linux-renesas-soc@vger.kernel.org>; open list:OPEN
> FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; Detlev Casanova
> <detlev.casanova@collabora.com>
> Subject: [PATCH] arm64: dts: renesas: r8a77951: Add reserved memory
> region
>=20
> The 0x3000000 bytes memory region starting at 0x54000000 is reserved
> for the lossy_decompression hardware that will try to decompress any
> data written in the region.
>=20
> Mark the region as no-map to prevent linux from using it as RAM.
>=20
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a77951.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/renesas/r8a77951.dtsi
> b/arch/arm64/boot/dts/renesas/r8a77951.dtsi
> index 07c8763c1e77..171833d91313 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77951.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77951.dtsi
> @@ -290,6 +290,18 @@ CPU_SLEEP_1: cpu-sleep-1 {
>  		};
>  	};
>=20
> +	reserved-memory {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +
> +		/* device specific region for Lossy Decompression */
> +		lossy_decompress: memory-region@54000000 {
> +			no-map;
> +			reg =3D <0x00000000 0x54000000 0x0 0x03000000>;
> +		};
> +	};

Is not part of TFA[1]?

[1] https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/tree/plat/r=
enesas/rcar/bl2_plat_setup.c#n174

> +
>  	extal_clk: extal {
>  		compatible =3D "fixed-clock";
>  		#clock-cells =3D <0>;
> --
> 2.38.1

