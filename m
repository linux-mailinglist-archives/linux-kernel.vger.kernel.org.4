Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923B36D8CA8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjDFBSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDFBSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:18:48 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2068.outbound.protection.outlook.com [40.107.249.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A796181;
        Wed,  5 Apr 2023 18:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqPby51tkZYEgWXN7FkLMuzo+khjhnW3gazcX09eegEPjwG+FYohrb4GFsWYbXMRls3eNR2V3J3MHXBlJUPGyVzsBHpjYqIVEWOa80n7H+cAZbQYvUfWtXeXoT2n4nP2lmZCQqCRJG1j/azGjPBMSNet4i8X6S1dznAhJf9HTuHh1PgurannTtjg/TF0JNEODNljk1SYgMMrEYoxdBQowZF5o9s25A7eOY3L3NJA2EfxGL1cG+sQKOUJ0Swot6g4LPr8gjZknB/fwmd52Fm0NX486l3tCCYJRauVVcYCaMLGIwGH2cbWg20tew8o7dGd+IpNmYh2jwgmfsM8MWWuzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=650zVJQUNWp5xLU9Ba9U75t7SHpmZkspl4YD0eBjuaw=;
 b=DVAJnRBDI37ZAYY0qHXrAgbeMDN+nYKYNa8Zrg3NGXaUP24Ru5wJwQ3r3i5uRxOKp1mWusbbGo2DghzzU785d5xHT66P55egdrULjNhsRMCnKrVRGjYVamINRdAllvHPRNnH6Hc531S5yb51X8OHG3IfVYykwqZuuizzT5JGAR16GA/Nwn31/NDBYSJW6NYzi1mr9TzRChoBMbx78j7OM4GlM2sGqPxvJRNyEJdPI9lJ+YjGkxX9B2ogxpVEI42XA4K22fpq7hKxavnQ36Be/otEOfgULsv7nWln7LlnFiDXnwFdRMc08nIYoEmZ9bCqzxVBjTgkgRKcCiR0qtxxfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=650zVJQUNWp5xLU9Ba9U75t7SHpmZkspl4YD0eBjuaw=;
 b=HQGFvh8DpaIWHRhiE4LQeZygRDzYjm17q0D3Wd+ZtT9psLzK84ViYMY6X5c6OKSUdoOMFQHEG3Prq29Cz0FS65N7TWrNhGI1M3YeY/QB7wNZb7lDY0ek+jMZKkBY8mmePlYGvQ3VAD3zwFEz04UJuqwLF3AyandzABlFZ3C94ag=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7716.eurprd04.prod.outlook.com (2603:10a6:20b:280::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.37; Thu, 6 Apr
 2023 01:18:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Thu, 6 Apr 2023
 01:18:44 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Xu Yang <xu.yang_2@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH V7 10/10] ARM64: dts: imx7ulp: update usb compatible
Thread-Topic: [PATCH V7 10/10] ARM64: dts: imx7ulp: update usb compatible
Thread-Index: AQHZXH4PLNi/iBTlB0aasDLQ95na568cxfqAgADMNyA=
Date:   Thu, 6 Apr 2023 01:18:43 +0000
Message-ID: <DU0PR04MB94178755C624BCBE25D8073C88919@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230322052504.2629429-1-peng.fan@oss.nxp.com>
 <20230322052504.2629429-11-peng.fan@oss.nxp.com>
 <20230405130649.GA11367@dragon>
In-Reply-To: <20230405130649.GA11367@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB7716:EE_
x-ms-office365-filtering-correlation-id: ee2e0011-399c-45ed-a938-08db363cdd2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Upr1I84GPXR+ymyZhJlgovRsnvXd0HVG18RPwdfUaqP1y8OsE8V64uzmrYxdPQBZiC88Y4JWMIPR03+FsJRaF/9M1ZPyKY49i8Kk2vbf20PHHIA8Ucgwt2zvr7jn4vwaEXU2yEF4QhqHVOBwTWGOT6Mg8k8HKcjo18+S/6AtTNUevoyK94GhiujH2zgR2TyHy+79fJWq7aC9apKsZF0guCWp8S+TYgvFVKz7r4orFasDyboT5RU8YeeLgbZJBdzu3v2J+e6jVsDIvaemf9hfCat2T8t6rm5vF7j45zhUo7PA6iyB6YHNmukanr+mAIKuoZqGPTovMCi+HNUf+R1ofqxUMiWSlfIAwZD0v2p4+qTXdl/9UCFBhck1rdyGkos7QcUbwoFkn3fvfNXyWml66wme/1atf9lpmZMRXibec56pHsNwJZSrhxgJyKDAUTqV/zqI8TbglYfcmWLjQDBJkqs30g3BQoJSNQpheoRhzyH+jVCGDMxGZMw5WWQUmurSdUlXWObhFo/9zSO38ZdqxWBBDOVBEr4bfwHYmWDoX0pQPd+yRCxxwd/Y68lSfH5FtcYzizkWypu10zZEOXz9y7zcykOkTK3EhDmpNXMsRRS8YM7Aa5c23V2CNw07V8db
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199021)(26005)(5660300002)(52536014)(8936002)(15650500001)(33656002)(44832011)(55016003)(6506007)(9686003)(7416002)(478600001)(38070700005)(4744005)(54906003)(186003)(86362001)(71200400001)(8676002)(4326008)(110136005)(7696005)(41300700001)(122000001)(66446008)(76116006)(83380400001)(66556008)(66946007)(64756008)(66476007)(316002)(38100700002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3VYr4TJuqXhfi6IoUvKj3+kD99DbnGo8+GLu5A8bQSGW01VSjHAArcvq/+iP?=
 =?us-ascii?Q?cmLL6ye1p5xHwm8mVURjXAfBSdGE0utpomA2IGu7c0YXblWRyBC5LzubvjW1?=
 =?us-ascii?Q?zwUqxHIFOA+i0jLEF9U3qBGVEuDnLdwjCZC/nVhnmcauDo1VHrKLPS73LTzz?=
 =?us-ascii?Q?Dn/e478V6O4UY+7yeHVvNbkZET4KG5nLL6OcRSIAQoRMqRGS5v6PqQ0hT4aQ?=
 =?us-ascii?Q?QIqpOyGvmUT3he4yBYn7DdkuMH86lVMgsxZs2B3/gb3TVT1HXRTpAHj2QepW?=
 =?us-ascii?Q?CGH/erHIffdWX3qF7WSiwonc4iEGiQEyy7KsSru8bcc51z3f1yTgS5TCCwpb?=
 =?us-ascii?Q?++bkbPw78V0AvyjeaLeMjFQI/oisdX/zaaIhHirPcQopihRqJkjMZnHSEo4Z?=
 =?us-ascii?Q?IdPzfG0Y4Hy5hTkxeTcEUPeXOZdGeI3geG8ev/YYIVkn07ZMgxAg0m6cybh2?=
 =?us-ascii?Q?fGIUZAQ4Es7zdr5ZO6YruFT5qBIVm5sO0lpluxhZrz7TgPL6Ej+5kAWtfbqz?=
 =?us-ascii?Q?bzLD7ZXoTPyDbcQcEAvb6NpJ4k5k1FIqipDFJoKGocdkeOz2W2TOf1Y3pa6X?=
 =?us-ascii?Q?0mywwomiDZJHr5yi0nNcXmg42GFotF34XLh+t5hCvWT6J/3xKYYGxr/TXhr+?=
 =?us-ascii?Q?Ax5P37dbpqCtuniCclVAso45uV6mVS7oGBN5e+PdOMurMqhpFSPJ1vsZVvp6?=
 =?us-ascii?Q?qU1eoJiCPYrz+tYbN13cqYnjj3JerNx7RFAJW1GPjSfYX4a0ROtEJ/U1Xi8f?=
 =?us-ascii?Q?8EIxTxapAaZSHCxoiJv9nIgQUz+nfbIRp7A0v3VV0y4QtGCOVEUjkbsgFnI+?=
 =?us-ascii?Q?0WeZxyhOwpIGjrCIxvkmKpRCE/d80LQvlB0K0SPQOez+2ZBC0K3XEbWBfM+r?=
 =?us-ascii?Q?kZH1LtzqDyDnLL9LaxAoJ2v0hKQkr5tZXlDnX+Kic+Mxc4EOkFQUQJtQIt70?=
 =?us-ascii?Q?vBhq8xgM8BT6b5rzFqaLFNdjS343/Yi0Nsj1gpBpoiEN3a5ORds3yOgX3//W?=
 =?us-ascii?Q?Ezq5lpi6v2DFrvKkIhXdcSVnOvYZ58sbovhXJL7YdvBMutHDPRTykUGLahvv?=
 =?us-ascii?Q?ua6ce+YI9f/Q08dSWsDD+NX1F2jvBzSnz4RV3w4uSyjXia+Llu9FW/lZ3huv?=
 =?us-ascii?Q?V0cs/HdaDtlcwWqYPX/+gxs7uUeY13+de2CQB+TXLSnxs3L8twLwsW1gUXTe?=
 =?us-ascii?Q?E1AEbKJo4/WgFi2AJWXomBgPqRxEQx682C3XVU9fS4W+W43wAOaiveV3D3Fx?=
 =?us-ascii?Q?5U7poj+/s5jjLhxpiIHO4oVSn0yd4tSOC6XjWZWE8Wj5V1qJJlSLmFvfX8W9?=
 =?us-ascii?Q?o4AcyeZg5YTlerjfvw5zhoSZqgvAr3gD6FGaO4jjydER7ydK7JTGpMKoJ6EN?=
 =?us-ascii?Q?dhHUNeDdt8iYNQz+Yuc6ww6XenHs6n8xBeKPgskSRbrl+hgCxYjrT7jHqN1U?=
 =?us-ascii?Q?RP1510Ek/MSxL9PAnSsNNvyysvsyHN90nGVhqs7lD76KC875+jkqeDcJehTi?=
 =?us-ascii?Q?yjKJ8AZv7mfTL2ZWbAOtGhfuYEeMzkYnFYtXbBIvxn+WEhmpKPViwUgL4y4R?=
 =?us-ascii?Q?SFZLih/xN4p2T4/2BnQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2e0011-399c-45ed-a938-08db363cdd2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 01:18:43.9386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aA9ilzr7HPiDPyJZrKs7OJEGheTyF8AaeDV4eOMCo3fHujCqdoDBYIk5G8yzkXM1X34UI0P0iMy6NcBCiwoqjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7716
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

> Subject: Re: [PATCH V7 10/10] ARM64: dts: imx7ulp: update usb compatible
>=20
> On Wed, Mar 22, 2023 at 01:25:04PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Per binding doc, update the compatible
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
>=20
> ARM: dts: imx7ulp: ...
>=20
> Fixed it up and applied all DTS patches.
[Peng Fan]=20

Thanks for the fix. But I think Greg already applied the patchset.

Thanks,
Peng.

>=20
> Shawn
