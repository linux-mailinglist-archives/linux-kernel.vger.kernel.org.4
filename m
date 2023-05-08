Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8F76FB205
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbjEHNvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjEHNvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:51:08 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2D5D07C;
        Mon,  8 May 2023 06:51:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJuH4rTMooBW29fN0Ghu6trz+eHWofIigKACsQoMHoyaev+7W0wrKNm8V9tyoMnScFiDH+D44shBp0MfjT3kg+3wWFOPndQa8zFUPyPiMpIRd6X6K55FxBLFAdKYZdgNT4IeR6IS1xCrj06FviSJzRZWdyj4abC9cD9BFr5lLiv0jeVKVAkOVjlBoX9NZ5NlyVvyPa8XYY+V2BZS4csijh7qlpKcQd+4EA5Edqx+Gi5Nt4kpA35EbMBBIIRlpHce71dNHOyMWDsbEvB8i074Z1SE68ztITeej9FzlLDq/icGziMAq/DaRk55CIAg4hSSZFc7gKXEpEhQcGrZTQaYag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZ2srTalZwnDWyuhgzi4ddh0JNQocCASIwv9bHgXTaU=;
 b=ebkSIAIE+JFqV7j/fTgLFWKCnDhyIrfGb6Ayr+m0lFDDaLxLez9XDykr8bVxbk0YAuvP35VjpD0Nb3znsupUEG83yNjGPAOErv5GQXqnuSdQ1ri4aSdIeDG3f08gCPovGdueFZMTiWArUeSzIRKP1GxMeWj59yzOG35IGwGzxPqsmBxb4Pl1zuTtT0Jyq5t3tTbhdY6dSFGQgMa2KrVCV8ZIDShbbr61NYYv6beiLqnLxqSLOomyACiztWgNQwTSz6KG7690cRWkjcYnMpQxUcILIdzDXu95+iKE/1QAN4lkVRl1EqCcdwh/G77HjX6l9S3yn98xBvYf97aJMFMnfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZ2srTalZwnDWyuhgzi4ddh0JNQocCASIwv9bHgXTaU=;
 b=JHAqWfe0D/NRxKAds8BpMGXIFsYIfD5GEQxVYqe0SUBPDAHLi7ESH6gwqeXgR3UsOyibnJAj8Z2bOUR9DTUqKtOd36dke0W2czefFIoB7CtAD9FdwvjlvaJmh3bw0/gtbin//GxGRVxhIUZB9tCMWrM6cB7I9xqBz3tE4MqwLGs=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB8052.eurprd04.prod.outlook.com (2603:10a6:20b:234::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 13:51:01 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bcdd:75c9:176c:39ed]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bcdd:75c9:176c:39ed%4]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 13:51:01 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Frank Li <frank.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     "pawell@cadence.com" <pawell@cadence.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [EXT] [PATCH 1/1] arm64: dts: imx8: fix USB 3.0 Gadget Failure in
 QM & QXPB0 at super speed
Thread-Topic: [EXT] [PATCH 1/1] arm64: dts: imx8: fix USB 3.0 Gadget Failure
 in QM & QXPB0 at super speed
Thread-Index: AQHZbh/AiOj349Wx2UW73kdHsqlF4K9Qi/1Q
Date:   Mon, 8 May 2023 13:51:00 +0000
Message-ID: <AM6PR04MB4838CA8EFAA11A765BAD8BE888719@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230413155043.102307-1-Frank.Li@nxp.com>
In-Reply-To: <20230413155043.102307-1-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|AM8PR04MB8052:EE_
x-ms-office365-filtering-correlation-id: 01041810-6481-4ca0-71a4-08db4fcb4225
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OPoN8lb0rxNc6dfPYCK8CbJ240XlSJk6meWNWsWceMMQwXP4njwympjSM4nBmt5O6B/6lRbKzGXhIrJmXbiU7vUIMKRUtOKdxTcWMEBTCTJUSBJafOKcdf91qaH6zHgK8n52F2Iw0TzzEWDJM1MpsJ7+1ewLVtZpZY3h+DxgDsWTC+v7ow31M+KbHQVcs3qaVkS2Gpu6S5DdVnrKQ+eWIuYV4o0Xv4euSvvu+LdQV/Z9wj9Ko2AufiAxEZ45gmkMx23Tx1NQfaK28bQSeYaCvRgugdz3l1QkRiqbUKdo2fPVW7wyJQQWjZqzwgGu7094ScB7M/Dwwr5sQlT+X27rhbxGu+PJR3RxMQlT21PsaWuYB1fTzGd6UHhREwepVu17Esc8/9Aw5sSBOQtrDAVd3w+/aAR9mZGG9ODCNp8h56l/7/0nTtnXLlXx9+9Lq+6B5Qa6D9rcaZlA3O3gbjiMZ0Lfd/ZViHH9cVDRVvYCndu8kvYr7uIXhyze3dSf6WWuLh8vUEWisjxCuRgKwlUbLcnYqy5Qp1U1yPywNsYdvEuED28yFnTkaPT4BP/CpkeQz6QVqtnidq12/L22JoaQkAO+2MK5L6PKcI32tvDTHJxqTsYxHUqpUBCnoBpG6qxGvzDmsd41mLjiHzxbEcef9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199021)(9686003)(26005)(55236004)(6506007)(7696005)(83380400001)(55016003)(38100700002)(33656002)(122000001)(86362001)(921005)(38070700005)(186003)(110136005)(41300700001)(2906002)(54906003)(5660300002)(4326008)(64756008)(66476007)(66446008)(66556008)(316002)(8936002)(8676002)(478600001)(44832011)(7416002)(52536014)(76116006)(66946007)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NJG2nNB/AJX2ucFhcp+EVR+nfSZEnDe9mn7KifrYnzTjc6DaPk4kyyt7s0fc?=
 =?us-ascii?Q?fECe6fIH8gEimsWDWgL+7yBxZwiwBG+ZrAQvSnDu3g0aICl/vKqX/zJec5p6?=
 =?us-ascii?Q?78UhOwR6hje1xge0Ga/QZedKBrnSDVpE6SrXC4o1UlkpCpwBO3Yk3CN51nhU?=
 =?us-ascii?Q?5t6YHtYz4xrJLyi12ibzsINYGvqmIZ3B5xQh9b2xZcTyh/p4sdseK3PKFBrF?=
 =?us-ascii?Q?1wxShKEzagWLawYJqS07V345D7M2d6rdg03wN09iuf2Rvpb1kaPDMxgH+hFI?=
 =?us-ascii?Q?rYduwrk+S3d5mkjXNQXujGPYOMhkCFJkNuIQqzAvpRGIuuGuoKvbbRjxAux1?=
 =?us-ascii?Q?jTcFp8lNiHqRhAUePaDWVxlsouVyNPUbQwc71B8EBVtEdL1ViFaAy0j9qq1P?=
 =?us-ascii?Q?ddDInftt5JG5jAIY1xrl1G4KCzvDrrGr0vIX7Q6HcAKl/nU3ZNIt6Tbr66BN?=
 =?us-ascii?Q?2rFiDHaA5k3TSkTTh5baWGKiK8bmuu4ja6lVsWd/fhf1UIoGWuSkRy9B+FTm?=
 =?us-ascii?Q?KSsf3wDoazTbLr9QmVdO6eot3NMa9Tt96gtAptJD2o8GpoiWC9VL7IjxYSSi?=
 =?us-ascii?Q?bcVCDKhfHyFxMWVYu9pBzD3J/mwEBzphOmkVzT/djwF3yxVC2MtKYQvFqD9c?=
 =?us-ascii?Q?ue0QE6Ve/Bx+uxgltrHtS/K/vwtCavMU5FqyBfftze3tPES8jNBhMeke8kFv?=
 =?us-ascii?Q?Lrs2buOOwdbPjcdPlEoIcE8rEdL3wnL7H5KRTBF9F980nSpaqZNFE1xwbWTW?=
 =?us-ascii?Q?0qrzzmc8YzdUMP+Z5khheXOHIPAoqNRXIjrwoeLeTgrAs3NXlWblcRJtCqig?=
 =?us-ascii?Q?wZtLLsfdA6P4kEs0zMwNAOyGwQ/1YLWXQao33Mn+nGbN8sWatXygfz7arItu?=
 =?us-ascii?Q?R5kJgvhQvlUSJ/LRG6hPUvlke4AEqZOLcarExVHgvzNLhze9D5bw0v6RvWgZ?=
 =?us-ascii?Q?OQ9ctWtzpS7gMBnrmI/V61Q+glgNzIQxoAIIo7Usqdcsw0uNwEXxxTM7bMhX?=
 =?us-ascii?Q?N5a5jmc2XaLZeFR6HdG9+U9a1wfdtwJBYwVA6KtyubYMPSC/Ap+zFOjLhhX/?=
 =?us-ascii?Q?SZ8ba0DXkuWlNXDLONdNAy9Dv3uDAzqMRW5I4T9qL9Eq1GFyGQV/ge5Q+M8I?=
 =?us-ascii?Q?OiV2w25hW1sfN/XX9Y3QhtoxKbIKEe8ya1LIsdYM60NFzhgSLzej0KOCO842?=
 =?us-ascii?Q?5Sv6YTitC+SXWRh2q8S2p7LOVmiSlYfYOFX0iZFRJUMm10S2AbXYxybidnOo?=
 =?us-ascii?Q?SEf0wMAB4fOfNZnmjw8qvwRjsYUWY4MwEpnKkQs3v6CeOf6u/YLMLbeH7scS?=
 =?us-ascii?Q?NlpRButVfWTxYSN1N/q48E4OD94mJv7pC8XgZ/lR4fui53v9plwTqVA75mQg?=
 =?us-ascii?Q?bx2jHMEUyEIPXYP44tHUm+Jklj36FqONLOmys5HUr1eYaoR6KdMV4IaCtM2d?=
 =?us-ascii?Q?7cn7EOM0ridzG6c1tWNAcFZ7LkbNw6S4uriSnt2jdfkmwx+9qh4L6AWJDOQc?=
 =?us-ascii?Q?uDbz0WAQw99/LEtwMFztc4dHGbu+5unMfX4Ipr7ZoUhnP52UQj5dYtkxDkaB?=
 =?us-ascii?Q?rVPkX0ie2e98mmA7ztc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01041810-6481-4ca0-71a4-08db4fcb4225
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 13:51:00.9321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8LSPACuVhtBlxK/oVnyZNsVZVXzCODrP9EAnPNc+DBw4eVJlGh+vB5gNrCIIfG/pIxRLHTMatDyxes4Sth20gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8052
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>=20
> Caution: EXT Email
>=20
> Resolve USB 3.0 gadget failure for QM and QXPB0 in super speed mode with
> single
> IN and OUT endpoints, like mass storage devices, due to incorrect
> ACTUAL_MEM_SIZE in ep_cap2 (32k instead of actual 18k). Implement dt
> property
> cdns,on-chip-buff-size to override ep_cap2 and set it to 18k for imx8QM a=
nd
> imx8QXP chips. No adverse effects for 8QXP C0.
>=20
> Fixes: dce49449e04ff ("usb: cdns3: allocate TX FIFO size according to
> composite EP number")
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Shawn:
Ping, it is important fixes for 8qm.

>  arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
> b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
> index b32c2e199c160..030c273c8be40 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
> @@ -171,6 +171,7 @@ usbotg3_cdns3: usb@5b120000 {
>                         interrupt-names =3D "host", "peripheral", "otg", =
"wakeup";
>                         phys =3D <&usb3_phy>;
>                         phy-names =3D "cdns3,usb3-phy";
> +                       cdns,on-chip-buff-size =3D /bits/ 16 <18>;
>                         status =3D "disabled";
>                 };
>         };
> --
> 2.34.1

