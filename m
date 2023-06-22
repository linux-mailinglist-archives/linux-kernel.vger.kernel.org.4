Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADE273A018
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjFVLuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjFVLtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:49:52 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2081.outbound.protection.outlook.com [40.107.15.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F881BE6;
        Thu, 22 Jun 2023 04:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQWJbilA4ZDeRozCnXmqCxnNU1wBusF7sVp6cwcPK17SKwdSRbq6AuLmEW5JsXVzpjWj2unyEmQa5XqgzNi9GjMvLtc+WIeubPgOoB0zj2suRRZxgtMlUhvtOY3UDHNVlx3rBfqK/pwYa3i9Dxd82cgwwFuGdJjdcEZhzH3c8tmcAPHUtK8FE2rHk3z1iCgQCvYs4iSoXyTGYKMxdcBedJZG+iVk5dalRDrfGnMslo0UYmS7zkNRnBepEcD5Yaz/vVnVncSCCQ47Tacbg5CF7ZV+bsr2cIiBW2f6p4nAleTNx5BqBOqij3M/jImzy5BjXDZfrrhN2uqwOOCX1JC/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kB84RvZpykmMxEeF1/iGF1ck1g1By6vRDoO345S2tdA=;
 b=E+PDOIUknvP62D8avo3GkoxZ6k6NujzU0mZPeBmNR6T40RrM0hlZJE6YBorWOKhtDOQclLIIQjtQYEdh4LPevyBWMy4Tc9GZGGDNP2LyLQH6YMaqEmp1GumRkiPPct9Lt8TQIkIJsn8gLF1rnCcoghfZxumnG2xDvhCfKbb3x78gmQfEd3OWdC2UmZnc9ai+BuYhAmLsqXOjWkaIlwBZg4oWuXVYBDdmmm8l6OgQwdfzfD0jk+owFgTuxPJF4gruMB/0fpKW/zQ+QrqhgANzuP8W4yNzSxjqBuEIQd8Y9EyxrfihaJXcT0TlmdQwyBiFQoEqoKKP9/JGLfF4buBzJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=technica-engineering.de; dmarc=pass action=none
 header.from=technica-engineering.de; dkim=pass
 header.d=technica-engineering.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technica-engineering.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kB84RvZpykmMxEeF1/iGF1ck1g1By6vRDoO345S2tdA=;
 b=khR6s2EyGnq/jsMNwFPmP688ETva1r6ctUZxJYbOughfI9FPH45OxyywHonyYPVt4J7IGrFbBiyN/2sNs2jLYxRyNWL5h7QxBkZuM4bPNYx6YYH3TLAsKxKKg0E3Efv/blhC6PKg3iQQ0uXCoi92jiOVUQjkwXAt1hb+DZNqPvU=
Received: from AM9PR08MB6788.eurprd08.prod.outlook.com (2603:10a6:20b:30d::24)
 by DB4PR08MB9213.eurprd08.prod.outlook.com (2603:10a6:10:3fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 11:49:44 +0000
Received: from AM9PR08MB6788.eurprd08.prod.outlook.com
 ([fe80::33c5:57a:c902:b183]) by AM9PR08MB6788.eurprd08.prod.outlook.com
 ([fe80::33c5:57a:c902:b183%4]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 11:49:44 +0000
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
Thread-Index: AQHZo1dsqYxWbDuV+k2nAf3g/vz/Na+V++2AgAB7TfOAAEDggg==
Date:   Thu, 22 Jun 2023 11:49:44 +0000
Message-ID: <AM9PR08MB67887483EDDF2AB7B11BF14FDB22A@AM9PR08MB6788.eurprd08.prod.outlook.com>
References: <20230620091301.21981-1-carlos.fernandez@technica-engineering.de>
 <20230621173429.18348fc8@kernel.org>
 <AM9PR08MB67880BD6AC346558D62C92C8DB22A@AM9PR08MB6788.eurprd08.prod.outlook.com>
In-Reply-To: <AM9PR08MB67880BD6AC346558D62C92C8DB22A@AM9PR08MB6788.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=technica-engineering.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR08MB6788:EE_|DB4PR08MB9213:EE_
x-ms-office365-filtering-correlation-id: 5423f376-48ba-4fc9-070b-08db7316c5a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vdgXeig3L+XtxNCf4XnIDjLC2qZOq88BT+x9mDOhd+fFG8Zy9g/Zn9wXh0k2a0Ap/FefQtA0qQwA047ocQ2l4MXBGy+DyAl7rJuI1BbSe2KDEsEK7319h6XTQusXM6o7nEVOmNAmhd/6kSiUZzwg9HoIYZGtKmMHOxZeNpf2fqsMaMQ4fZjFS8Q7mDpKiDhVxCA0diORzUv8cfaFyK6xQuwC++E0/MeUB42ZUbFBbGqKbJnTvgG4ULMoeOBzXtQr6VGNWcSxdQ1w8Qde2s8lssrgc4tyIjO+4RvEkBXKWDfCQRCeueOWp9UL2nVdnl5qT/i/mPav1IIdHRrGJmeWmrms0DTKw0vPphrFr+PHusVqZFRQ5O6/dffhcVdbjg4pfd8tICNvl2wAj9908TYC7qHRtG+m16BvihpYvsK7Zf1l40lwgR0GxzkQ/GQfkeGAdv1XyUuId1DPpuxo2ayIP3Jwn0PhftUb38bpV/Spjssn1oYjEPw7szeBr8JmJd0YOJ3ypZ7BfiRzw+E1omvaQG4Hytetoj1eLiY3EYnIcbc9Sn9ZEAubuT6js6e42g10MKAbsCB0GQmBZ1pyXKWUGu3PYc+qFCk7GbvYoaKu0UU55DVXVKrIYu8u7CLObdH3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6788.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(39840400004)(396003)(376002)(451199021)(33656002)(66946007)(91956017)(76116006)(52536014)(66476007)(478600001)(83380400001)(54906003)(7696005)(71200400001)(66556008)(5660300002)(86362001)(2906002)(44832011)(41300700001)(8936002)(316002)(4326008)(66446008)(6916009)(64756008)(8676002)(186003)(38100700002)(9686003)(122000001)(55016003)(53546011)(6506007)(38070700005)(2940100002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1AtJ6Q+lDKY4o3KnS7CTOuGHbrVoT+D6Uo+ATjaVAolYhFSXqvXEf2je8MET?=
 =?us-ascii?Q?V/3WB7xgvFp/C64j7xNLyAt75B7tfYezpz2FpcLPo3KFycVcHCMmSoxNY5JK?=
 =?us-ascii?Q?J9RuRlv3reguPVy3cijjchejHy+4M+7ecFy4iboo3OH5d8xJ2JkQ8O1HGs+Y?=
 =?us-ascii?Q?kXffp/juaSU1C3i3QJKfFX2wrb3sdrS8aOzulp+634sFzSEXYU55+XkpKs/e?=
 =?us-ascii?Q?jPzOqt+4mrt/ga4hRCMk8JKqnBzP7GTWDEgEzIKraPgAzl1rQ3swRZbjGdJr?=
 =?us-ascii?Q?BTHnTOo9wgN7GRld8SgC6bLKKnzCOYkL5s/RyWqPsiIR38dQGKScgzdtbcPa?=
 =?us-ascii?Q?jHvb7u3g5LKVAJHFTkAe4BZkKXPwqXHkmVt4Q12Y36Pw1St1oZfUzM6oebb4?=
 =?us-ascii?Q?2v3/YMoAsJPu0Hlp9suOEe/X6xBrH41euQ/E4mSVZInMhlemAdGaTegbsFOA?=
 =?us-ascii?Q?GmGvdXKGgW1v+fOSvRrAEFSyE8MGrQuxoxiEhNLSAN/t4zhXRHXQChMK3BUY?=
 =?us-ascii?Q?ijN6m9hQNKEY8DlsJYxkX0Cw59YUw+PzdfxO9HnaPi7YBWPzr7Z7zJMeWfQN?=
 =?us-ascii?Q?qLCVjLivGTYtvA4YuMSb5CIea2ox8Lqp+rjcI05Ou6YlSEjkYKQ+DnFU6fhH?=
 =?us-ascii?Q?ZLOdPa6JTzYmgnRoca6rrlavBhCq4EkY0mewEbWip/SP8b/BY322jZqrf5wV?=
 =?us-ascii?Q?s5t+m3NQkjZBifyYs7aQ4pBerctfvk+/sdVV79NrLkhjtLAx6WhvTUDeVDp0?=
 =?us-ascii?Q?Gu6kJIr7v8OylJjaEtfnfduZbqzyiVE35G1sEn3zVAztOPgrlfIBAc0O4ujq?=
 =?us-ascii?Q?5axUKRIp9bqYMtB10dqDqx5H3qjda68XFcB4MCoYoRe3OD4iATx0T45xPcAI?=
 =?us-ascii?Q?+0vEzuVOsPat9AarrSXgVhBuHtnhNYDT/tmFEf0ux6GkRv2LsAxf82hD+6uw?=
 =?us-ascii?Q?Rqj0OYnbRoUTpGfO2hNd5Jh/5SPjZr9SqpI8W2Fw4foJZ8M01JnyWB4BFIML?=
 =?us-ascii?Q?scqqR5641VUWFjfQ4Tt3018V+h7VfLkDwZUO4TYgXY6x7f+SoWfFrepABQnS?=
 =?us-ascii?Q?sf+SPpWs87deMkFsxz6sNSXRnyH+PLG0OpjB5mrFbuaRCMBetDutwIPzAqMk?=
 =?us-ascii?Q?/R8REkxeydtqpuK3Fr/RiGAKWpVXksuEi0g+w9RO1Ucd00kgWcp2D/b+hOFj?=
 =?us-ascii?Q?FjYmSmq9JpkH6yQbixERaRrQ0vutVBXm2ychjpD+egtgvC9mmE7D6EqJfgwl?=
 =?us-ascii?Q?WC6VuglJjN038ntDgJX+MzQYpYY2lKzumIb+UDmE71YoishzhRl/JeP7INP3?=
 =?us-ascii?Q?c/mZ/ncVz7AD17nzg+xeZ2rpcOoy6U9aO+ekKxfni0QEJdVh6xe/Li2Xgdxt?=
 =?us-ascii?Q?MVUv26EiAbM/JzYL75V/w/GleOo/jOGc/BZpr81mZ32H3Z9F1TCtUVdRcV9n?=
 =?us-ascii?Q?Ffw6cwNrRjLBEcPf2CBJHL0itKO7FfkohLBD5wtRAqwlHgDUSlBeyiakLn8/?=
 =?us-ascii?Q?jCJV0A7O5umxGXleWl8BT2XZPl+lckrJ2jfl9/iYtCRBFHoXidLycqZS/Ogh?=
 =?us-ascii?Q?7MKR4fRJZr2IC5YGIX7uU8tAm5VHWOgRvx1CTK0vjv51rEzESeSDjQESDAMl?=
 =?us-ascii?Q?rFmyYDLuqYLH5rRN2oMPC/U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: technica-engineering.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6788.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5423f376-48ba-4fc9-070b-08db7316c5a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 11:49:44.4821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1f04372a-6892-44e3-8f58-03845e1a70c1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gk2jltw2SkeLyvupEKnv4K3swfW/f6T3jUDTP3f4037YAbWGWWY2p1Nfh2UJjXew6SjigTV50PR6uUOT0qy4WAZi4uiBG8W83Fv5Hx94/d0JJQ0WUbr6OZc79ThfU5+HULCDcN+8Bd+kmzPRm2xm8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9213
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

Also, about the double look up:
I know it's there, but I tried to only change the function that returns the=
 correct SCI in every case. Also, it should be a 1 and only item list. I do=
 not think this should be dangerous or slow.

Thanks,

________________________________________
From: Carlos Fernandez <carlos.fernandez@technica-engineering.de>
Sent: Thursday, June 22, 2023 10:00 AM
To: Jakub Kicinski
Cc: davem@davemloft.net; edumazet@google.com; pabeni@redhat.com; netdev@vge=
r.kernel.org; linux-kernel@vger.kernel.org; Sabrina Dubroca
Subject: Re: [PATCH v3] net: macsec SCI assignment for ES =3D 0

CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you recognize the sender and know the c=
ontent is safe.

Hi Jakub,

Sure, I'll add Sabrina Dubroca and add your suggestions in the next patch v=
ersion.

The return of the rx_sci is the goal of this patch. When ES =3D 0 and SC =
=3D 0, we should return it instead of the hdr MAC addr. If not, MACSec comm=
unication will not work when using a switch between the transmitter and rec=
eiver, frames will be dropped.

Thanks,

________________________________________
From: Jakub Kicinski <kuba@kernel.org>
Sent: Thursday, June 22, 2023 2:34 AM
To: Carlos Fernandez
Cc: davem@davemloft.net; edumazet@google.com; pabeni@redhat.com; netdev@vge=
r.kernel.org; linux-kernel@vger.kernel.org; Sabrina Dubroca
Subject: Re: [PATCH v3] net: macsec SCI assignment for ES =3D 0

CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you recognize the sender and know the c=
ontent is safe.

A few nit picks and questions, when you repost please make sure to CC
Sabrina Dubroca <sd@queasysnail.net>

On Tue, 20 Jun 2023 11:13:01 +0200
carlos.fernandez@technica-engineering.de wrote:
> -static sci_t macsec_frame_sci(struct macsec_eth_header *hdr, bool sci_pr=
esent)
> +static sci_t macsec_frame_sci(struct macsec_eth_header *hdr, bool sci_pr=
esent,
> +                           struct macsec_rxh_data *rxd)
>  {
> +     struct macsec_dev *macsec_device;
>       sci_t sci;
>
> -     if (sci_present)
> +     if (sci_present) {
>               memcpy(&sci, hdr->secure_channel_id,
> -                    sizeof(hdr->secure_channel_id));
> -     else
> +                     sizeof(hdr->secure_channel_id));

the alignment of sizeof() was correct, don't change it

> +     } else if (0 =3D=3D (hdr->tci_an & (MACSEC_TCI_ES | MACSEC_TCI_SC))=
) {

Just
        } else if (hdr->tci_an & (MACSEC_TCI_ES | MACSEC_TCI_SC)) {

> +             list_for_each_entry_rcu(macsec_device, &rxd->secys, secys) =
{
> +                     struct macsec_rx_sc *rx_sc;
> +                     struct macsec_secy *secy =3D &macsec_device->secy;

You should reorder these two declaration, networking likes local
variable declaration lines longest to shortest.

> +                     for_each_rxsc(secy, rx_sc) {
> +                             rx_sc =3D rx_sc ? macsec_rxsc_get(rx_sc) : =
NULL;
> +                             if (rx_sc && rx_sc->active)
> +                                     return rx_sc->sci;
> +                     }

I haven't looked in detail but are you possibly returning rx_sc->sci
here just to ...

> +             }
> +             /* If not found, use MAC in hdr as default*/
>               sci =3D make_sci(hdr->eth.h_source, MACSEC_PORT_ES);
> -
> +     } else {
> +             sci =3D make_sci(hdr->eth.h_source, MACSEC_PORT_ES);
> +     }
>       return sci;
>  }
>
> @@ -1150,11 +1165,12 @@ static rx_handler_result_t macsec_handle_frame(st=
ruct sk_buff **pskb)
>
>       macsec_skb_cb(skb)->has_sci =3D !!(hdr->tci_an & MACSEC_TCI_SC);
>       macsec_skb_cb(skb)->assoc_num =3D hdr->tci_an & MACSEC_AN_MASK;
> -     sci =3D macsec_frame_sci(hdr, macsec_skb_cb(skb)->has_sci);
>
>       rcu_read_lock();
>       rxd =3D macsec_data_rcu(skb->dev);
>
> +     sci =3D macsec_frame_sci(hdr, macsec_skb_cb(skb)->has_sci, rxd);
> +
>       list_for_each_entry_rcu(macsec, &rxd->secys, secys) {
>               struct macsec_rx_sc *sc =3D find_rx_sc(&macsec->secy, sci);

... look up the rx_sc based on the sci?
--
pw-bot: cr

