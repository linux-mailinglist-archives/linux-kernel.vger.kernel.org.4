Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322966EF640
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241335AbjDZOUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241326AbjDZOUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:20:41 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2109.outbound.protection.outlook.com [40.107.114.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C146E8F;
        Wed, 26 Apr 2023 07:20:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmSF50zBaPdKiLw1t7kGyglfzAkqDAWlYetqYmQNkqTyLyks+sLhhmngzmF3dsv28E90ibGWMyYj6+5Gr//fhJgfIDbKKxnriqf5+oFyKr36VDwBWfvj16J1wWBv/gCTnwvugZ8mslusrMDa/8jq6Ts+MKDBpEjR6RUlatJVb34URj4w7a572hUOj1mWtinCGBSAqewojonlxVnxhnws0STucVn+HObPHF908Jc+rSCWTqvwJAIRuaVg3gGxA4YT0y7EvETtQc2fgsGh2UgTWWQtRo5kcWaHB6oVjNv9DpZRQweMRfXo3HymbCUURzI+kpduzwRYbhjy3f58Al7tXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMqEkc8549KLQqdIAhTnnKJh642uL1OpbbdRJqOVV5A=;
 b=B6f7/K39mhh8mswL0JXUJLYJFjSyhnmbZoItnAB+GuedOzGpVPkhDxcLXfkwibjPFWxIrDC0mmiP0RyaM4shhFI104K51cwm2BfVwV7ygiFL9N5MfVUdaCxasx0ZYZMGbujp0xSNWM8VUhBpo8017NjflG6mv4G2FpveK6J03wiq8/Sa2VJ3EcLREMIWxeyI3vedw3vrWJjZUkkdyGn3QDRQbcyH1NOs5cWv6YDV43YWHoVYq/QlNt7Akj91yfymyRG+KH9a565C7Ju4B26V35dRrzwb0JZHxBQcCFk6GQ+vRaG6FtE+TQEFgjf/sVIFBXJUFthLOaC9sKYnBI2w8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMqEkc8549KLQqdIAhTnnKJh642uL1OpbbdRJqOVV5A=;
 b=X7ioH9lR0k+iTHIIPBFWignIbSkZyWVzKhcylZ6EtPB79/iCP0KTkX0pks8evZsdnXXkNOUy7JB1pFcz1qYHQWl3n3ebB93s/nTiXEUTDAMYa0y+/HhyyNiPJwaza7Vs5iwFK2vj3X3TtbXQpNU0cQkbzDNuKL19OtIXJQNb2/k=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYCPR01MB12041.jpnprd01.prod.outlook.com (2603:1096:400:387::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 14:20:36 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::f687:2c30:bf97:7ca2]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::f687:2c30:bf97:7ca2%7]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 14:20:36 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Chris Paterson <Chris.Paterson2@renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>
Subject: RE: [PATCH] dt-bindings: pinctrl: renesas,rzv2m: Change maintainer to
 Fabrizio Castro
Thread-Topic: [PATCH] dt-bindings: pinctrl: renesas,rzv2m: Change maintainer
 to Fabrizio Castro
Thread-Index: AQHZeCcT+SzNJUNsTkS5Tamptw0o1a89pAOA
Date:   Wed, 26 Apr 2023 14:20:36 +0000
Message-ID: <TYWPR01MB8775806E3A68403B0137A7BCC2659@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230426100832.11945-1-chris.paterson2@renesas.com>
In-Reply-To: <20230426100832.11945-1-chris.paterson2@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYCPR01MB12041:EE_
x-ms-office365-filtering-correlation-id: 9a242f78-1c33-4661-9385-08db46616781
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pMQ3CwkkfkaFsSAf++2WJuVAR5zI4OIW7hdKMxFwYwVlq+sg2Fg+zLMPql6ehHS86wdGbf3wcpXQ6FkEGWqQLb0I45/jwoveSCxUf7w66Xr3W88y6grYgtrDaRX+4MbBvRMgYxIbcPEOdFJzI+LxBK2QfzkMuoy9Ki36JtMK9UZkqO6OKy2vr6EmrMeft5n66dQNytoAI9z7WuHZFcSSrWxGEwoPydNT4l5wjpaxb5XcPUcrulqs04zUf9JFyGe3IPTYaI1lSoNA38RSTzw6Zu02KjOpJwIJQgvZe+qz1mt0tfahKrjdZzdCF9WFi2jrDPXdB0whmMMDi2eAenQwHQn4Df4TIYfE99s3J17AkrzWneXWqGSOfu4IBrPeFAp7+QJo24yPHBiCaYhIV3Dt95sY9XsitT6/jJf6CPkVOS3SEY7OxXhLaLBdP5UQv4NtGGY0VfYENASaFGGioLWHV62Hf6oeGS7oeShssi/SB5HuVJYhThgcWGg8gJPjHYgYa1VS3NPYwybdsXclC/wkbKN08K8ma1oAJc32/yHxIAlEsJGesoM3hw2ULehebusCUzyjT8cqx6NgOUIkvZorWk0rYxaW9vBit/mdDZseS4o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199021)(7696005)(33656002)(5660300002)(52536014)(122000001)(558084003)(2906002)(38100700002)(71200400001)(478600001)(55016003)(316002)(41300700001)(38070700005)(4326008)(66946007)(66556008)(66446008)(64756008)(66476007)(76116006)(86362001)(186003)(107886003)(6506007)(9686003)(54906003)(26005)(8936002)(8676002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xr6G9Fr2cTWBX1F2/Ip7v3GDrxWdME9JZZZaCLxbfh8ZkNI0jHPABloJUlGX?=
 =?us-ascii?Q?FQA88i9XHcXaaevjsGJRA+tPkQzdFNz4lJ0/21m+HxLLbVwmmQDGJ1DFPXFo?=
 =?us-ascii?Q?KfjxXgd3WSGetRbIEjZzPHgVKlaxphqt7OVy3srpXh29I5dOTlotfCULW9eC?=
 =?us-ascii?Q?YVhyW18GVvUAkkJELnvHxuZYM0ubmwp3zstbvYfrWaI4oiFD6bHS5qVb2i6f?=
 =?us-ascii?Q?KUSZF8yCf7ExnP5XBUNMBrkuYqiF1W6jYpU9iMaWuOP81fe/P+SHmfppErYR?=
 =?us-ascii?Q?g4dsbTRwlaZB/XYR38c/nOlhVopO8kyuGOr1alxxT1WHWoUAqoUC2ZQtyjgS?=
 =?us-ascii?Q?BIsEJLWzRk1vJxDAzyWhz2xyMwPl23RWjlCzRHGImP7Mec6Jx1mHi6K/GUz/?=
 =?us-ascii?Q?STXFB/UwZDP9AWP5sabmtcNRMlCK0gMAxebUqs6NXFWD0ir0S1X6y0poW7wt?=
 =?us-ascii?Q?UId1Chq5ssnpsUnJrd+u5RbA4bvGJ5mZDXIw3cQ0uyic7/5rgQvUkDX71my2?=
 =?us-ascii?Q?3YhfClUdi/kcjGI9BJMqdf92ou35UouckcXnxYFr2FwoKCL0s3lnFJV5S2Bj?=
 =?us-ascii?Q?COyE27h9BLAkVImRzrpwU3Y+IG/+GiO4WxhrjqMlMqMSfJ8KR5kv+qWB5NPu?=
 =?us-ascii?Q?g9o6raJ9lzAmdIU5u2/imJWRCTGOybJx36pgXZIMF+1jHfvOXx9P+fmlD2ju?=
 =?us-ascii?Q?N+JF5m9XGDfqhssQxK6WYyJkurTRZR7T//aODxRo8K4nUIigvgBB4teFvQVQ?=
 =?us-ascii?Q?phTlcyCdRazymsJ9L8hF4+HmtnsKJrOYuk0auOqxS6Xb5bIvFKIy1Yagrcem?=
 =?us-ascii?Q?QGr09SIRXXlHFVyZ+GQNoC9KHpZ1jRZwkxrsvfzjzgPujYCrJnwh2G0yMJ5j?=
 =?us-ascii?Q?rzYzPDGpcsDSCj/aBJ+4QR/no1aCdFwE77/idx0W7GtkBObfguyauEMPWpIC?=
 =?us-ascii?Q?RDyM78Woz0gyrewi4ThNT7k4fynAAn79RqZFyrBd6MqLtSFz8oCieZMkVG0/?=
 =?us-ascii?Q?Vkqaja1i17qlBCa5jmgL1BizAN70jXsqVVeEjbg+eDOuEkdIG3orUruHTJWV?=
 =?us-ascii?Q?HY/6+h5Q2i5KcaNK6+MfATJUE/EfAz4C5OkWCGo1c9vDbko7Kkq1TzzHk5tH?=
 =?us-ascii?Q?R2mJ1RNC1IirA+ssRJOJQXUAVpntIjgBdClAWnO6tGaDpNv9b45HkEt2HrxE?=
 =?us-ascii?Q?oLxXTtV36uvPAj4WEBrvLg5nzoZJaEsZlzNH048UNbvAkiRcNQ3KqTfPsjup?=
 =?us-ascii?Q?Sttyi2R48aNMojSFc5DgA+k6uTjfB6hrF+KsAVnhduhGO+AsBwn6bAY8Bizt?=
 =?us-ascii?Q?RAVaffApDRq1ImNnfJsshlFGNCSCJ0nknA8/suHUDKzEtyF5elM5TlcJTgea?=
 =?us-ascii?Q?chplZJlE9TBVWZF5NMQkEkwLqx+x6miCSr/qAI9aYEfbSSAwEZyELZOivHEU?=
 =?us-ascii?Q?W5i2p84GhXvNMUO7s5hE4KRHiM6E+nhMNA2OQDyclQrhtGBI/QYRuPSCUXEL?=
 =?us-ascii?Q?oGQfhFzXRYEpFercn2jrE6Lm79meISCFVYPLtOdiXxFuAaaRiRGLcPCIpKoS?=
 =?us-ascii?Q?pRsaMh7HlpE/aC0LMXm+fWz6ac4ZBQI9nZaKU3wnNSgoTsY12GY/WHT+iqJW?=
 =?us-ascii?Q?ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a242f78-1c33-4661-9385-08db46616781
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 14:20:36.5155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1SeaxcemnrIKEf3r4sjPshOh61xCnvD5DQ+kundLaqTF8BDxrV1yocvhRUdHuxBGCb6A70YGhqnQsFXifvO91qRiCM669dur0cCzgUzfQkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB12041
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

Thanks for your patch.

> From: Chris Paterson <chris.paterson2@renesas.com>
> Subject: [PATCH] dt-bindings: pinctrl: renesas,rzv2m: Change
> maintainer to Fabrizio Castro
>=20
> Phil no longer works for Renesas.
>=20
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

Acked-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
