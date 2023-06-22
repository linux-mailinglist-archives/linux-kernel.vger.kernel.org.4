Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45287398E2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjFVIBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjFVIBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:01:01 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1E4199F;
        Thu, 22 Jun 2023 01:00:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rojx9exu63e96gUVCL5N5C5WMF0AX7hJl8/kdiw6lWKglQyL6m6AHzvWSVJS1CCFwq1U92lmJwB9Rq53xhF87VLteGYU1zgB+b5J7UFwJyPeg8bLwjjF9yXAGJiRcd83ta66r5WVtamCL4+G0UBoEYwtYdQTwK6y1o3WM9cJrdGoVHyqxCh3es8cSPAdHMxdpS+0U07ox/q+WOBHx3jmgbsBuHWpuKYX14rDYgR3AcM0Qq2ku6nVZzO1nTu4alBmZ+NS81PYIiPcuget1oEjxmJnZSRjSiZZ3sPKJYTQ7BCxt1ICx6trvtYc+3d24fvt4TSX1e9z+B4jH785nAFC/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijrg8IJji0WwgqsyDyAweISaU/vrVoAeLHEgEQnxfGw=;
 b=Y5kDkJUSVtcwAvNEQF3DZem5JesV7CwnohMJf2KnzT+1EtqyHCvVr5RQuk1/alpCg6Nl4Uh0U8ZS9RNVm8L8f3t5TEp86xmG3ZSIZYePMs2LtAZtP3dVOQ328oH1MkuCyaT8YgUwq14ftk9DXVXh8c7KltJoMVCcl2q1AFUvFZYCW5QggaS9Ga+Ge8wL2pNeMkzAYR8v7geCM1Y1ikKfDDq5xAyMhAPoI3OnWVpjP7E5sh3ezBIcPGAx3HajhUPm3NbkCE+Z5xM9Kss21MH6sUK141x7NffVeAULcAdTDKz/501sOHyFMg5aJjWVb3Nlln+Swpx3PEcb2NurkduXSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=technica-engineering.de; dmarc=pass action=none
 header.from=technica-engineering.de; dkim=pass
 header.d=technica-engineering.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technica-engineering.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijrg8IJji0WwgqsyDyAweISaU/vrVoAeLHEgEQnxfGw=;
 b=vSaaX7O/Gvph6caU3WaPVjDNXr5trpMXfk+QbjAhRIed4sy/V2Rs04MAx9Z5lkonC+dptYDtZVS+bgXNNfYB4FqFwAPkMj7DJid3WDCBcjOcuezohUc7u7QdflroMiuBTvLSuG3NtOGnX4oyKPC+FawsSw+9/O21s01rKr4VIIg=
Received: from AM9PR08MB6788.eurprd08.prod.outlook.com (2603:10a6:20b:30d::24)
 by AS8PR08MB5926.eurprd08.prod.outlook.com (2603:10a6:20b:29d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 08:00:32 +0000
Received: from AM9PR08MB6788.eurprd08.prod.outlook.com
 ([fe80::33c5:57a:c902:b183]) by AM9PR08MB6788.eurprd08.prod.outlook.com
 ([fe80::33c5:57a:c902:b183%4]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 08:00:32 +0000
From:   Carlos Fernandez <carlos.fernandez@technica-engineering.de>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH v3] net: macsec SCI assignment for ES = 0
Thread-Topic: [PATCH v3] net: macsec SCI assignment for ES = 0
Thread-Index: AQHZo1dsqYxWbDuV+k2nAf3g/vz/Na+V++2AgAB7TfM=
Date:   Thu, 22 Jun 2023 08:00:32 +0000
Message-ID: <AM9PR08MB67880BD6AC346558D62C92C8DB22A@AM9PR08MB6788.eurprd08.prod.outlook.com>
References: <20230620091301.21981-1-carlos.fernandez@technica-engineering.de>
 <20230621173429.18348fc8@kernel.org>
In-Reply-To: <20230621173429.18348fc8@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=technica-engineering.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR08MB6788:EE_|AS8PR08MB5926:EE_
x-ms-office365-filtering-correlation-id: 03f9c42f-04a3-4eff-dce5-08db72f6c0cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f8lQqgaF1LCi5B88iMnpp96eEHUZgTaZYSAOdhRQTa7QDSSgjaWDnNSS5F5C9BQUREYAH1y53szkM7sRR/OMUscGb5HHURMBhUk7T7FSmCKT2XzZrT29k2k/SP61NyzCeHfKpmYlxxF72dvhMyYccsRqS8Pupkii2eaFM8FCpdHQahcDaHrVx8XpAxtucO7ffG9F7xAmf7mRk7HCbCfl8QBnvYRaoCQoyj9esieajWlltSNEZfOiyW5Od4RRgUGmPSKlV5eX4aeIz02XFuJnY+dyw+hB5gS495+c3wFgDQ/8FoKo6ysfFmoYXEZK4V8RGq98XUf7RZ/0KJ0gOfxi4S/agTTJlr5CIhZS8/N5ZH/jPgCHtxIA1h9wmPJgOfqK/WlkU8TUojY238uLzictrtBZZL/0Ai7I9w7TtGtQSRGjLMKvUF1BSz3jY5vaN8WU8jUjidrUA6Th+ee0smpR1tVlJ7noxL6rxblLk+K2iCekOeeogfw2rWK5ezd1e5GTNJIgTOTqMO0BGD/GYJlDENZkRcyl13xlkDTB08REwUKbWcvPVWsrVhceN98jMtYMk16MPvrgIOm+ChtyANfrt7pcljfLtcy/aGYR/ZXNHNhM4eKxWmFHkFCUy4MKCuy9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6788.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(346002)(366004)(136003)(396003)(376002)(451199021)(83380400001)(2906002)(186003)(64756008)(66446008)(71200400001)(9686003)(66556008)(66476007)(6916009)(91956017)(66946007)(54906003)(4326008)(316002)(76116006)(7696005)(478600001)(26005)(44832011)(8936002)(53546011)(6506007)(41300700001)(8676002)(52536014)(5660300002)(55016003)(38100700002)(122000001)(33656002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4tq27V7JXCKs+iy39oNPHCSMbMY1PXoXsuEM684QA9NmESaCFP59JFYikn?=
 =?iso-8859-1?Q?EIW3qCumXUb94RBmCwh1acIHw4KHHkfL8Ng1D2s1Z3Y72FJoiH+9ugNJ8g?=
 =?iso-8859-1?Q?s/7cKgbT8RKjFv+b942eT6uQQ11COHhxHzU09lCQtYfAxq7OJmqPb4YSfu?=
 =?iso-8859-1?Q?L/pDHpwtqzg+L/Sp5Y1IT7CXkm5zk01GF3vgMIpmy5y5ggH4sS7uv6LSV6?=
 =?iso-8859-1?Q?q3jTeRGKo1ux2Uoidnc7v7XZE/Opu6f9dqCSYyaXBKfxDyBN6Wa9KdEpHi?=
 =?iso-8859-1?Q?0qZDJ59J0gavMSQSJgLovDEcn0K7YysP5rJIGWHzYm1AeGk3M5zWDiuqrX?=
 =?iso-8859-1?Q?nd/k0hCzcsjZFW+6rnCLSWTrQ/vLXLkLug5GnMx0yxA/E716YE9LCx7Snm?=
 =?iso-8859-1?Q?UHX8dQgXf87z13p/HD3TrER2RSHr79Z2/CJLDMb3pQdYtW44J5rhgxG1l4?=
 =?iso-8859-1?Q?1rgxkeS8rZ1ev8vZEMtorBPljsTQ9VnItnT0tg/YjgwoGE17gsZl11F75t?=
 =?iso-8859-1?Q?zVlEOzM+EljZpMsMK0JQ7izZylDi/C2Chup5WHMq27RFLq76h0Mb/jaZDm?=
 =?iso-8859-1?Q?kK+1g3e4U4xNOtjnXAfsx1nhELgmnpjJUifq85Bgc+PMYN0Y2csvA4gBEl?=
 =?iso-8859-1?Q?NseOytIt5TqN1/ofGZ2X7zck85V7a72AsakKtQMwcFT2K1b4ahK4UDwOhr?=
 =?iso-8859-1?Q?CWYCWwokwN2zLgn8qQNoT0FhkQRIpFi0FNGWY1pOiAD2AGMNo2tDfbCACD?=
 =?iso-8859-1?Q?TmsWuibAaZn9on9ehVMD6H3z+kYiE71M3u9+CScLL4KbWTun/tzaPxOi9P?=
 =?iso-8859-1?Q?xT/exEeesqEIlCt7FCsv0WS84OJYBjHab5WHicqQ2An2fCDn9Qk2ZObu+Q?=
 =?iso-8859-1?Q?/2mwPkZ42C2SXyFiEvDb/GgoyPGUDYHyMXQE30YFI0MM/ucjuqw2k5odzv?=
 =?iso-8859-1?Q?3iy7KneH03OJkiLiI3qu9IBsVHsZSGuG4RVCtI6lJycXVqhfy2jI9sley/?=
 =?iso-8859-1?Q?T84/ocUVEmrnbDjmFgk5ukGaPiXj83YBEDkUWYOpSMZbmFOsgN7g2i73Gi?=
 =?iso-8859-1?Q?HuXOye6XFTFKKSgg3b10JrmLNax38uf06AA325LZenVgEfNVteBv0W/yWx?=
 =?iso-8859-1?Q?sM1+gX7YB/HK9gC02AxuyKl2gI4LFPoyZkq4Jp9HOiStiHt7qnNXaa5H1C?=
 =?iso-8859-1?Q?7RGl8KqJW+1hSXlwiXxYCM76x/9SIiQt8J9lj/QjCrrJq4HmQzrW6TR8On?=
 =?iso-8859-1?Q?OZa1EDNDgc1/OxAOt4Iq3R/e9wSXAGJ6Vf5Jb0wOcduNVIdNqy6POvlYlu?=
 =?iso-8859-1?Q?vo0EXXscckLdoecf5CFIC2F2nGqavdi08CzVuboprKe+vPJkRx6LXbIMcv?=
 =?iso-8859-1?Q?mdc+hgUb+F5nwKz21YyjYlKXxmpLS1r8luyzY2axz6oM2o7tLu6FjDOhMt?=
 =?iso-8859-1?Q?LlCx8E/Cw8D08zfLO1AjsaxgMnEDCOz6xAF0WA0+5sAkLdYf6KO0TeERzw?=
 =?iso-8859-1?Q?gmqQA2YcHyaYAXiOrqIejzYTHulQCloOD2sxARqbZOYxe0JTu591FgQNcb?=
 =?iso-8859-1?Q?EAi2qLKd3151U8qxQcUt4/X2xzbzm030D6kesn8/Jzs0rWrKN0Nlfe9w92?=
 =?iso-8859-1?Q?zfba0VNThQxDmD4ObWYZJLKnU+Hkvc6z6LZEwoWdbYLm90JCffnShiRkST?=
 =?iso-8859-1?Q?dwfoClS/07NFjvcAfeE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: technica-engineering.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6788.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f9c42f-04a3-4eff-dce5-08db72f6c0cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 08:00:32.5068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1f04372a-6892-44e3-8f58-03845e1a70c1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0660p3gSqpk1/tzi0H4AmGnowaJp0k5gen5dRmjowK13hGt5kubLi+LuIZHgfdEdC4wt3B9CQSeidJSWnq+JbhKLrurg9d3yMeiZDupMZZ9fwWUdgSOAfFVE19Vf2oZkeHmS3XSw1JPvZZfE2ZvRwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5926
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub, =0A=
=0A=
Sure, I'll add Sabrina Dubroca and add your suggestions in the next patch v=
ersion.=0A=
=0A=
The return of the rx_sci is the goal of this patch. When ES =3D 0 and SC =
=3D 0, we should return it instead of the hdr MAC addr. If not, MACSec comm=
unication will not work when using a switch between the transmitter and rec=
eiver, frames will be dropped.=0A=
=0A=
Thanks, =0A=
=0A=
________________________________________=0A=
From: Jakub Kicinski <kuba@kernel.org>=0A=
Sent: Thursday, June 22, 2023 2:34 AM=0A=
To: Carlos Fernandez=0A=
Cc: davem@davemloft.net; edumazet@google.com; pabeni@redhat.com; netdev@vge=
r.kernel.org; linux-kernel@vger.kernel.org; Sabrina Dubroca=0A=
Subject: Re: [PATCH v3] net: macsec SCI assignment for ES =3D 0=0A=
=0A=
CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you recognize the sender and know the c=
ontent is safe.=0A=
=0A=
A few nit picks and questions, when you repost please make sure to CC=0A=
Sabrina Dubroca <sd@queasysnail.net>=0A=
=0A=
On Tue, 20 Jun 2023 11:13:01 +0200=0A=
carlos.fernandez@technica-engineering.de wrote:=0A=
> -static sci_t macsec_frame_sci(struct macsec_eth_header *hdr, bool sci_pr=
esent)=0A=
> +static sci_t macsec_frame_sci(struct macsec_eth_header *hdr, bool sci_pr=
esent,=0A=
> +                           struct macsec_rxh_data *rxd)=0A=
>  {=0A=
> +     struct macsec_dev *macsec_device;=0A=
>       sci_t sci;=0A=
>=0A=
> -     if (sci_present)=0A=
> +     if (sci_present) {=0A=
>               memcpy(&sci, hdr->secure_channel_id,=0A=
> -                    sizeof(hdr->secure_channel_id));=0A=
> -     else=0A=
> +                     sizeof(hdr->secure_channel_id));=0A=
=0A=
the alignment of sizeof() was correct, don't change it=0A=
=0A=
> +     } else if (0 =3D=3D (hdr->tci_an & (MACSEC_TCI_ES | MACSEC_TCI_SC))=
) {=0A=
=0A=
Just=0A=
        } else if (hdr->tci_an & (MACSEC_TCI_ES | MACSEC_TCI_SC)) {=0A=
=0A=
> +             list_for_each_entry_rcu(macsec_device, &rxd->secys, secys) =
{=0A=
> +                     struct macsec_rx_sc *rx_sc;=0A=
> +                     struct macsec_secy *secy =3D &macsec_device->secy;=
=0A=
=0A=
You should reorder these two declaration, networking likes local=0A=
variable declaration lines longest to shortest.=0A=
=0A=
> +                     for_each_rxsc(secy, rx_sc) {=0A=
> +                             rx_sc =3D rx_sc ? macsec_rxsc_get(rx_sc) : =
NULL;=0A=
> +                             if (rx_sc && rx_sc->active)=0A=
> +                                     return rx_sc->sci;=0A=
> +                     }=0A=
=0A=
I haven't looked in detail but are you possibly returning rx_sc->sci=0A=
here just to ...=0A=
=0A=
> +             }=0A=
> +             /* If not found, use MAC in hdr as default*/=0A=
>               sci =3D make_sci(hdr->eth.h_source, MACSEC_PORT_ES);=0A=
> -=0A=
> +     } else {=0A=
> +             sci =3D make_sci(hdr->eth.h_source, MACSEC_PORT_ES);=0A=
> +     }=0A=
>       return sci;=0A=
>  }=0A=
>=0A=
> @@ -1150,11 +1165,12 @@ static rx_handler_result_t macsec_handle_frame(st=
ruct sk_buff **pskb)=0A=
>=0A=
>       macsec_skb_cb(skb)->has_sci =3D !!(hdr->tci_an & MACSEC_TCI_SC);=0A=
>       macsec_skb_cb(skb)->assoc_num =3D hdr->tci_an & MACSEC_AN_MASK;=0A=
> -     sci =3D macsec_frame_sci(hdr, macsec_skb_cb(skb)->has_sci);=0A=
>=0A=
>       rcu_read_lock();=0A=
>       rxd =3D macsec_data_rcu(skb->dev);=0A=
>=0A=
> +     sci =3D macsec_frame_sci(hdr, macsec_skb_cb(skb)->has_sci, rxd);=0A=
> +=0A=
>       list_for_each_entry_rcu(macsec, &rxd->secys, secys) {=0A=
>               struct macsec_rx_sc *sc =3D find_rx_sc(&macsec->secy, sci);=
=0A=
=0A=
... look up the rx_sc based on the sci?=0A=
--=0A=
pw-bot: cr=0A=
