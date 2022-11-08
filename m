Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80456621204
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiKHNKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbiKHNKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:10:32 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEA417E1B;
        Tue,  8 Nov 2022 05:10:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCKy0wmNFVAeZOnvbbFIQtQXiBky59rpWTmxMnCigImm6mxPn6jXj7AI7+0Dx/Dtp7M2lFZgXR4gumxERTCdb9wONtHvIT+IRIRjxo8w4AQIzNM7CJ9jy7aLixzSduLRumP4Woq2N23NYG27gyi2MKbTWdN0BgIChbgtQKV6e5b0IVUKt3nXE28/QCf39/5BM6G95DQERpLets0M1/g6qCT4KawNptZK/aAOvVesdlh4QovUz3z11P6lNgUy4kkUl/b7XnjAVh5xeCGAlka1qCcs4FBNjPF60SkD0yrx7C/lNuSEh5GmkvCmi3cFd7fEQe7eq8IHECN19FTurXHk/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/VGtSU9FOb+Tr4EV3rDrCaOXqoac3lpA6gKCxTe308=;
 b=kP5Mm+7BKIjvgs6aZuAX+bOPnvfqk7d3PH+lG+M2R4JkMRXOF8BHWT6slEuoyAfR8ocSO6P6GFDBPsr+ZPulYc4hE75vJXstP7MszSSjgvnwg81td9v4otxqpgTSWByaSCdxulVF6RVF0sNVugwd73D1nQc/gRB9ek4sYYthS1KgTAi/wlE/zG6ByHgiFMepS1QwdF0DZfgWeO7KVYUlO46RXa8fO+9eQtvfpfAmOtTCNzo7Gq4K70nzSOpRtQN7X4oGlLhYdCUaHjDNn6lRc49AMqxGJeVX87aKr6MTjjSQZ2PYcrWoyKSmA0UZHP/TUCxjQd0shBbsJbAvxjAINA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/VGtSU9FOb+Tr4EV3rDrCaOXqoac3lpA6gKCxTe308=;
 b=KcsEkFGkOg559hLWBnzFChULpsNGlPIQxdvgtx+4KUmMMklZkDwGqYtRJxoYYiSUHFGYdtMu8irKhbHm+njMa8SVwpPP4i8J+d5UgFYGfrDmlYj3N6rFekdvXDmPGVT9eMNVKD7F+J/bAnLAdeOaF/rX7uFMSRoQh0wiuhwWMy5YDBpSemlryrqiCOUM1XUAuds8xwdLYFbbd7aNiimIVy7xwe56vWTNuAkjlFyFFsGOxWYpvGegYsRvMG3oYfgRWsEc8ZZC3vzSL4KtZaa9vj7i2ebLg1cQSrYho5QxTqNBnpNGpDvopRe/A2DgDY4hiEpCZHIeDWu0GiwA3hfg6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.26; Tue, 8 Nov 2022 13:10:26 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::774:7ac5:2a7e:4255]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::774:7ac5:2a7e:4255%5]) with mapi id 15.20.5791.025; Tue, 8 Nov 2022
 13:10:26 +0000
Date:   Tue, 8 Nov 2022 14:10:19 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ninad Malwade <nmalwade@nvidia.com>, jonathanh@nvidia.com,
        linux@roeck-us.net, jdelvare@suse.com, nicolinc@nvidia.com,
        rkasirajan@nvidia.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] ina3221: add support for summation channel control
Message-ID: <Y2pVO70OkxeDSASB@orome>
References: <20221108045243.24143-1-nmalwade@nvidia.com>
 <af3bc209-5c89-e0c4-1534-7d190d5daae0@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wWc2dchpchWGmScn"
Content-Disposition: inline
In-Reply-To: <af3bc209-5c89-e0c4-1534-7d190d5daae0@kernel.org>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.7 (2022-08-07)
X-ClientProxiedBy: AS9PR04CA0039.eurprd04.prod.outlook.com
 (2603:10a6:20b:46a::33) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|DM4PR12MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: a22b078c-a5d7-4f63-f141-08dac18a9a68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ELYW19XY0SuLIPMNJTwPWK65kWzsB9uOLZfLCDxeTzInH3pUWpxD5gHeqr3UHfkWtEbhCfet/zeyMdWW9/okAZRm8jEuGfrJHeoscZja0C/ooZgPN0NXlgkjAgKx1es3Nx9eMege/xu1kgUBi6kRyw//nQUsW02KkiPX9Y7IjpnWerpELFxoroZzha9xX08F3ew3E3qcm3QSlt+2Xplg5fJO84VIA5M3qyNM8PQv3U6/qtEFS/zL3MeMBIbisz2BYRRX9MCtvqxYCWgBG2QHarg8RkHPgw1qG9kJyVh9W8iZVDxvJ72ZDSzCcWu+2HlXqqFlT4mu2ieuRrBw7vOhCqcxlhUMsjyl1H66ltzFIqkTk/1IWshzPRL/mXxdRJGHcHHazO3o/20otgZF5lAuYjLJnWS6qTsQhLnGZY21XrWB/dhBpCHBgwFIYr9oaV4P1KVJYHknPFaZv8/JAou3IGTjx/muGgXvcV6sud7nEpWDGoWYNdTZabcRtcEUhgf9v0YJEQUwOJGCCGUPVsWM29H41Vky64ljOKNY6lJE8JPA1L8tJH0yg4grP6MHHbUdZLEFOJ+rABxJgVtyQGnEFx0mePcy/9UxlFHg4wmTNIPTk4joCdeXcmxp29E5OLWp5ppzZ2p40zjXjCglUbZ3omCCySBNFZVu5j4RTXxlXaecHNhE2QZ82zi2sCyTS2khRikiKo2GDNbloPXODN14U8tLw1Q3QoSDbnLaw05DH5FTAmO9qKObpkhA92scVPQ1N62sk4bQfgBO7Mc8yqO3LyE6T8wUGA3md/6B0URcSkGMsZW7LTsZqg649Grnjacqh4cncJvGj1/X5UWGRISO8w28FWiL9AhWG49XmNkgcqWUfR6z18nKgDTsp9J87HUDvLYaXOiupgghRm/1j5ACvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199015)(6506007)(86362001)(41300700001)(8936002)(2906002)(38100700002)(21480400003)(83380400001)(186003)(5660300002)(66476007)(478600001)(4326008)(8676002)(66556008)(9686003)(44144004)(53546011)(66946007)(316002)(6512007)(6916009)(6486002)(966005)(33716001)(6666004)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eB0CUQ19A2m1xeQmoqzfELHJfXcJhzzE7EP7KE6Uyuc/NF6niOVi8jou4yVa?=
 =?us-ascii?Q?1hcXlx0V7qgLnCrBEgVoHX+A1khJTW+wJcK4Nxe5PQcFnU/t+L7om3wDJaHX?=
 =?us-ascii?Q?R6VSa/1vLtaETrNYSNlYUZjJSRpWwiacwBLii/UDSsa0SP2CvtyX6U1VrJS6?=
 =?us-ascii?Q?gR4DYVVdn+eWsLT9fG4TJiWH5mtRSVKBgVeZ7c2CnKaHbetw0fgpwaGfkNHH?=
 =?us-ascii?Q?4yxxH67IiLMmI1FApE1AnkvRT7Nqeq6FD0VgvSdmelH3MZF+K/x2E0vbV3l/?=
 =?us-ascii?Q?hUEW6A0z20t0/D/S7gMtZajtqpVGY3N+/rMnZ39XBMFdZnONX7uIxfVtsvW/?=
 =?us-ascii?Q?UjubX/ZI9xnfWJ3YPfx+V9ZEkzRzK72rCNsDu2tXerWIUmlYTAS2Stu/vQeI?=
 =?us-ascii?Q?S/5epqH2O6R5BV4GeXZyt0BFs+yBk4nb36ISpEa4P9A1Tp6kn6FVQ5Muq68d?=
 =?us-ascii?Q?ylgCAQrboe/Sp+I/auRxxu6u8/TFcAr4jwVdHmMKZ2RqU6w25Aizw9k9P0/M?=
 =?us-ascii?Q?8cFrrhNyVEoEroBcBVIYI/AptFCyAzxI+KWjft+DETxAVXGrBV1hG+VmKGop?=
 =?us-ascii?Q?3ryfDTjYrTQFS7zrlzzBAw8fEdtf+R+LNA5D98QhlUqZ/IYHmzpCi6+Q+ckK?=
 =?us-ascii?Q?rx7gcnTBt27zqQFR/8s3d/mNTMTIVVQ+OhatHCQZ+ZjbjxoeCjQNSvd69tAO?=
 =?us-ascii?Q?Ms9bP6c4hhbpZnBSuCvNgXxJE/NGELk+llLZLThareP82TkO7FdUuMlL5I40?=
 =?us-ascii?Q?xWv0VQCtTawRXSh6C+jar91TnusDPPRoaJ4dVEDQWX8djk8/+PU8d0r65W8/?=
 =?us-ascii?Q?NIdzV7IqV35utLsYiUnXqO/DH+pwZZ/X5BPI1NO7oyXw6jWi8YSmTKC3mci0?=
 =?us-ascii?Q?jJsComlna5EYUUaG+/buuESK2R8Edjy//GhKYnkapv4WFG7YBvjmOeMpVj7B?=
 =?us-ascii?Q?IJBcSIy8ZeiZdhyPilKYMqQQ82MwWjbqwPIJJRD6PDJalDcC3feVPEpLNVHp?=
 =?us-ascii?Q?sc5wJ9JXT4eGjellpmP/p1rGpRWCLYkanX6hz6fw14zY1Gl4vhwtImo+SHc1?=
 =?us-ascii?Q?cSYx8usQy7+LvbcXvbKU+bBKhjUEiS8BMIUzlVYJD2LJw4/LHW39HXb6UgLW?=
 =?us-ascii?Q?CnnkZVGpn4MU1SgwmrcJGjDjFOTMn6SWZC0wlzdBR4iwJlauAE6EP+/EsEW7?=
 =?us-ascii?Q?bPRD7u61pzj/ZebWXLoJ+v2i/F+F681HC30XOCrO1SXbp0lrSHZCkh7UXTP0?=
 =?us-ascii?Q?wUm0DFBi0HF6aVmR3ASYR0ZYZ+p+Xc1/R0/WTn9ARSafPZrO+2ITppq+LXfb?=
 =?us-ascii?Q?DUXoaTdYiYYcYv5/vREGG3yW6irXStSXPAuVt3agY+UcKdi2QWmPdlMHXwm3?=
 =?us-ascii?Q?j98jukZwesnKZwDJjbz/TzOYYdIiaAGBWdibBKx2Qm4HeiRmi1bFkTSCIb7z?=
 =?us-ascii?Q?a+wfbumQZcC/StSplBccyMCPLPxeb7IgqkAoqacfygJNTWGvlP5HaiPRUuc2?=
 =?us-ascii?Q?N4NomYN7FybYPh+s98R34W8qtGQuteKUVpsAYlFBVgx0uAhExSkzlK8UcvqK?=
 =?us-ascii?Q?5nOqPaq79gqwQlblwu91g6S4jt2Q6Z7YoIf3CY1Nexhn+lgZWHGRTkVu/0U+?=
 =?us-ascii?Q?ZIj5PZA5A9kDihM37kTzc4Aw/676q9+f1/EQ+Py0mXX+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a22b078c-a5d7-4f63-f141-08dac18a9a68
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 13:10:26.8749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vcaa6wQSJzgIHYMnUZeZqO25vGesFEJkd9v7KgqrtXDMsb1zyIXLl1iLMA2YkKVopmiNTbsx4sTChUHbI6ilAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--wWc2dchpchWGmScn
Content-Type: multipart/mixed; boundary="tKC3JFOyBrA8RDQE"
Content-Disposition: inline


--tKC3JFOyBrA8RDQE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 08, 2022 at 02:02:54PM +0100, Krzysztof Kozlowski wrote:
> On 08/11/2022 05:52, Ninad Malwade wrote:
> > Add support to initialize summation channel control via kernel device
> > tree property "summation-bypass". The channel which has this property
> > is excluded from channel summation.
> >=20
> > Signed-off-by: Ninad Malwade <nmalwade@nvidia.com>
>=20
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC.  It might happen, that command when run on an older
> kernel, gives you outdated entries.  Therefore please be sure you base
> your patches on recent Linux kernel.
>=20
> You skipped not only one, but all DT maintainers and mailing lists...
>=20
> > ---
> >  .../devicetree/bindings/hwmon/ina3221.txt          |  2 ++
> >  drivers/hwmon/ina3221.c                            | 14 ++++++++++++--
>=20
> DT bindings and driver changes are separate patches.
>=20
>=20
> >  2 files changed, 14 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/hwmon/ina3221.txt b/Docu=
mentation/devicetree/bindings/hwmon/ina3221.txt
> > index fa63b6171407..c6e8e6aafcce 100644
> > --- a/Documentation/devicetree/bindings/hwmon/ina3221.txt
> > +++ b/Documentation/devicetree/bindings/hwmon/ina3221.txt
> > @@ -29,6 +29,7 @@ Texas Instruments INA3221 Device Tree Bindings
> >    Optional properties:
> >    - label: Name of the input source
> >    - shunt-resistor-micro-ohms: Shunt resistor value in micro-Ohm
> > +  - summation-bypass: exclude from channel summation.
>=20
> Convert to DT schema first.

I do have a local patch to convert, I'll attach it here so that Ninad
can include it in this series.

Thierry

--tKC3JFOyBrA8RDQE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline;
	filename="0001-dt-bindings-hwmon-ina3221-Convert-to-json-schema.patch"
Content-Transfer-Encoding: quoted-printable

=46rom d9ae5bbf569516ef0f2d230d934c6a5c0d7ad3a6 Mon Sep 17 00:00:00 2001
=46rom: Thierry Reding <treding@nvidia.com>
Date: Thu, 25 Nov 2021 19:33:03 +0100
Subject: [PATCH] dt-bindings: hwmon: ina3221: Convert to json-schema

Convert the TI INA3221 bindings from the free-form text format to
json-schema.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../devicetree/bindings/hwmon/ina3221.txt     |  54 ---------
 .../devicetree/bindings/hwmon/ti,ina3221.yaml | 109 ++++++++++++++++++
 2 files changed, 109 insertions(+), 54 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/ina3221.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,ina3221.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/ina3221.txt b/Document=
ation/devicetree/bindings/hwmon/ina3221.txt
deleted file mode 100644
index fa63b6171407..000000000000
--- a/Documentation/devicetree/bindings/hwmon/ina3221.txt
+++ /dev/null
@@ -1,54 +0,0 @@
-Texas Instruments INA3221 Device Tree Bindings
-
-1) ina3221 node
-  Required properties:
-  - compatible: Must be "ti,ina3221"
-  - reg: I2C address
-
-  Optional properties:
-  - ti,single-shot: This chip has two power modes: single-shot (chip takes=
 one
-                    measurement and then shuts itself down) and continuous=
 (
-                    chip takes continuous measurements). The continuous mo=
de is
-                    more reliable and suitable for hardware monitor type d=
evice,
-                    but the single-shot mode is more power-friendly and us=
eful
-                    for battery-powered device which cares power consumpti=
ons
-                    while still needs some measurements occasionally.
-                    If this property is present, the single-shot mode will=
 be
-                    used, instead of the default continuous one for monito=
ring.
-
-  =3D The node contains optional child nodes for three channels =3D
-  =3D Each child node describes the information of input source =3D
-
-  - #address-cells: Required only if a child node is present. Must be 1.
-  - #size-cells: Required only if a child node is present. Must be 0.
-
-2) child nodes
-  Required properties:
-  - reg: Must be 0, 1 or 2, corresponding to IN1, IN2 or IN3 port of INA32=
21
-
-  Optional properties:
-  - label: Name of the input source
-  - shunt-resistor-micro-ohms: Shunt resistor value in micro-Ohm
-
-Example:
-
-ina3221@40 {
-	compatible =3D "ti,ina3221";
-	reg =3D <0x40>;
-	#address-cells =3D <1>;
-	#size-cells =3D <0>;
-
-	input@0 {
-		reg =3D <0x0>;
-		status =3D "disabled";
-	};
-	input@1 {
-		reg =3D <0x1>;
-		shunt-resistor-micro-ohms =3D <5000>;
-	};
-	input@2 {
-		reg =3D <0x2>;
-		label =3D "VDD_5V";
-		shunt-resistor-micro-ohms =3D <5000>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina3221.yaml b/Docu=
mentation/devicetree/bindings/hwmon/ti,ina3221.yaml
new file mode 100644
index 000000000000..0c6d41423d8c
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ti,ina3221.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/ti,ina3221.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments INA3221 Current and Voltage Monitor
+
+maintainers:
+  - Jean Delvare <jdelvare@suse.com>
+  - Guenter Roeck <linux@roeck-us.net>
+
+properties:
+  compatible:
+    const: ti,ina3221
+
+  reg:
+    maxItems: 1
+
+  ti,single-shot:
+    description: |
+      This chip has two power modes: single-shot (chip takes one measureme=
nt
+      and then shuts itself down) and continuous (chip takes continuous
+      measurements). The continuous mode is more reliable and suitable for
+      hardware monitor type device, but the single-shot mode is more power-
+      friendly and useful for battery-powered device which cares power
+      consumptions while still needs some measurements occasionally.
+
+      If this property is present, the single-shot mode will be used, inst=
ead
+      of the default continuous one for monitoring.
+    $ref: /schemas/types.yaml#/definitions/flag
+
+  "#address-cells":
+    description: Required only if a child node is present.
+    const: 1
+
+  "#size-cells":
+    description: Required only if a child node is present.
+    const: 0
+
+patternProperties:
+  "^input@[0-2]$":
+    description: The node contains optional child nodes for three channels.
+      Each child node describes the information of input source.
+    type: object
+    properties:
+      reg:
+        description: Must be 0, 1 and 2, corresponding to the IN1, IN2 or =
IN3
+          ports of the INA3221, respectively.
+        enum: [ 0, 1, 2 ]
+
+      label:
+        description: name of the input source
+
+      shunt-resistor-micro-ohms:
+        description: shunt resistor value in micro-Ohm
+
+    additionalProperties: false
+
+    required:
+      - reg
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra186-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/tegra186-reset.h>
+
+    i2c@3160000 {
+        compatible =3D "nvidia,tegra186-i2c";
+        reg =3D <0x03160000 0x10000>;
+        interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+        clocks =3D <&bpmp TEGRA186_CLK_I2C1>;
+        clock-names =3D "div-clk";
+        resets =3D <&bpmp TEGRA186_RESET_I2C1>;
+        reset-names =3D "i2c";
+
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        ina3221@40 {
+            compatible =3D "ti,ina3221";
+            reg =3D <0x40>;
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+
+            input@0 {
+                reg =3D <0x0>;
+                status =3D "disabled";
+            };
+
+            input@1 {
+                reg =3D <0x1>;
+                shunt-resistor-micro-ohms =3D <5000>;
+            };
+
+            input@2 {
+                reg =3D <0x2>;
+                label =3D "VDD_5V";
+                shunt-resistor-micro-ohms =3D <5000>;
+            };
+        };
+    };
--=20
2.38.1


--tKC3JFOyBrA8RDQE--

--wWc2dchpchWGmScn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNqVTsACgkQ3SOs138+
s6GacA//Yf//el5yTG700XQ9JXeuhJMKYNIcQlI+ojdMaef9ADQ2T0vImRQ+7G8C
b2awDNsCzGqXcBtn0Gv4d43W9ctir80L9qjzRaI6x7ux9U1yPwHpl4RYSCUuf46z
MzbBKiSYxw01mZNAoShpxCQNzcnoPuAngzpRYaytJr0XYdDnYMA3Fky/UbPDTvPR
Ql1IBEC/c4J7Tv4ojFCGD3NKz5cDg9ypbVHnNY0OX19qCVOOjvSBl9wA1LRSeDFu
/VmLOiUWtaGrD2olesDQUygDtmN2I4lJEdIla08FQyhFB/cfZu7bOWP3eYuQvVj1
9ENURAnyIyxemCQRIhu088WfV7cjR8W9cKFfPNpa+hhQ3XjudPBmSxvqrQjAcRvo
Rk3Suhm0X2YWZoqofn+cMhxTzDvEvUFllPa3uIbHN8HQFAH7MNw7yTuDjxrJ0HBV
tnMW4moH4ZrAroJ5SrulMDCwMOZe0JsPpfxq1nHHwSi/2rzDuXLmgK6Qz+ZbxMwf
+scmRikEIcIlqoIHp3OusHPGzfn2jsfuUUs/+3cHGXwtym8QEhkwP7nTjDw3/Xub
YsdQ1WUni0DCblOC0k/0LmxhTWX4sTASjPQEB1uIJRLU6k6yFvV2tEvRqWyPJ4HM
7fmc2NvSHu5PCc/29AavC2EhQEWnJjIZnucoWybcdYUYKNDpG9w=
=ffOz
-----END PGP SIGNATURE-----

--wWc2dchpchWGmScn--
