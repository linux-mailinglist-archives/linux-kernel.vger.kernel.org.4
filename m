Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7204D66C330
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjAPPCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjAPPAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:00:41 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F7623329;
        Mon, 16 Jan 2023 06:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673880677; x=1705416677;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=06DVKXsdpN1KZZaMPZX/rCpJaPPCtdin7ZxR8hyxNyo=;
  b=MrL+1RXMIdcHl6pQQ3DO8XTaGDLvxxnOAv9TEx6mzu780nHT7Po4N3dx
   wGpygBtCNm0rwzYq669bLGsE2NER10F6yEgDw2YC1MHoVmnfpFNDMsmI5
   yTUTj2RU2QgY6W0u9Yzucfxol3ZlkE7RKUS//UsMmqFWgA/4A+twkRwC9
   LH0nK2Wi11X0rRTeDChH22fiW6hmFNu8ucViOtSQuDPMOPa7J91L2PN4V
   2o7pvpypjw0oXh5pklcHmgFElUj/NDx/87QWMtk9j4JTiF9ydUIdGTkmO
   r7axvSB1thQ3W28G/ETuYeYreDSE403e+IiV2slFYqi7cSubWvkuAaHxe
   g==;
X-IronPort-AV: E=Sophos;i="5.97,221,1669046400"; 
   d="scan'208";a="325237559"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2023 22:51:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9OH7bvW/1KAzQl4BZA+kJMM+OnipUvu41VGce58cQ2x8BrUjGye+QdGAnEvEqE/iw3fNqZkboSmE2XvMWPLULP/J1B/UQQ/cImGZ2u4Pk4w1TpyxYbcvnSNxT0oJcqL7AGdhVuqTj0VdwbuTR1QEYaXpBpJEmGYnrZRLWeDHx1OyoBWQ5ns9NvTHBGrd3EcDlRB6zd5Jmi838kgCJiZpZ0VKwh13XGYzbgTOk8IbSZG6nHSD3NbxVdBq+2kNu0IFKqtH64iwAdt0IKczKtCpflCdwRjo7KH0b5qrIz7Ewj8EZFKHj6BB8Rla7fRFeZGQfCu95BLnxIkjrAQmNMIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwXegxsWNFLJobFLdSb4Pd3Jd+F+d97bvZvNd6oPZHg=;
 b=ni1tRtLfTMDkEpqMb3JEWsAAGZeAT0xyBRHgSch3Ijj50LMT6/O44iJEiQx9K6DsChrXxFzhM819ctsXZlmL3wxSyJpEDV9TLllow1mqmPFY9OAdMUsHXL/H1M2VW3Zr19UyzrDVaCVNwcynR5fGSvpbjolIcrUqnVIg3WP7rICczg1rjnY6UHFT8PCxSpZktuauHf7FmuHiFXPMQzhicKoOVdW0v7PHZ6BTNg2Pj5BGzgQAPzTDqQWh/Shc1znu6K2PkfpKXC1UA2hDFMkVEpfElokiu2e6QRdvqfy2rA+yjsVL0FQOrX4SpeOT8AExPGmZHQuHjIa6Dox7TAy13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwXegxsWNFLJobFLdSb4Pd3Jd+F+d97bvZvNd6oPZHg=;
 b=xcPoN2Mj5lNoxpJ//ZsHEv6vGi1e1FlVy6uJ1d0IqEVNwDubL5OUnZ4cdoG4CCcrxD2MHEdiuexZDImjOYZeSan6NQpti2g13OWSA04VDCEJSpcybovmKtKTq4EZP8E/VAFEj+GONEhZsDc3xB/csnG5oKJ73xdFQW0ctCT1FJY=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM8PR04MB7927.namprd04.prod.outlook.com (2603:10b6:8:3::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.22; Mon, 16 Jan 2023 14:51:14 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ee92:8a0e:803f:4244]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ee92:8a0e:803f:4244%9]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 14:51:14 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: RE: [PATCH] mmc: block: workaround long ioctl busy timeout
Thread-Topic: [PATCH] mmc: block: workaround long ioctl busy timeout
Thread-Index: Adkpq3tb+gXfT/KXQXawlvtJeLUDVwADfyhQ
Date:   Mon, 16 Jan 2023 14:51:14 +0000
Message-ID: <DM6PR04MB65759FBA12E7A48DD904E0D6FCC19@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <68590206e8b044a2a71457cbbeda0794@hyperstone.com>
In-Reply-To: <68590206e8b044a2a71457cbbeda0794@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM8PR04MB7927:EE_
x-ms-office365-filtering-correlation-id: 1290effb-2c7b-49d4-4c13-08daf7d11dbf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p3h00Q/5b4/r8j4LN3gwDbfCXKLgI3GOcF7XaXjw07q+LcLu5eCIYbXrBVK/ueA1zsgWpEW8EJm87OQxyJ784jpQAlE+zFpsUxPa5N0/GVwW8RTW6r1PoVabFhMJQSPBFwzN/JLSNItxclgjIvpfZFwLJxytYN1cmoaaW20MU2pHqKlWSwQ2U0346Pf2uEJQqaDfKHs5oYQijDK9FaAJKF4RUOADUolJpBwkWsE6XetqwkS2G9X5VXmOMItj3X1h2ZkFGgGgbGjOBu54gSEJtSnF7dhgoa8T+qHRaudUyv+LlBelQFEEDlmZvFXWIjFxnUczJKV2E1o5HKxoCdRayGuL2byYt2WSgowkToB6+AlER3vnFCY2cEEkhcvmMcGZi9iHtVWKk1PkD2ozhs5wHrNjOQxfZ7GBL7/V+bnAGhVT3sotTpVwRqQ1m5pTjiYFwwf30JxNbLKwxaL1cMAvioaEoE/CDkHmlroEh3jDzFHPLYxmPNHiMlxpCewaak2cav4c7JpzUDTTIkVcDmiyMshIVZ5nWj9dqZmT78267IS4Di9T87IwopSMFe+Jj4AKWiEIQBjc8HPMXg9rKFoE3/MzYhg6EC8K6nmKXb91+ORit+QeEovXYrEDMUX0Bu8pGuLEupqas43JhUqiTAauZsNSQMMHqPvoicN4/dpwluJZnY5ALNaFfbIDgir+KYx+gqu0JnD1GChXdVb0F6iUiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199015)(2906002)(52536014)(5660300002)(8936002)(316002)(86362001)(83380400001)(66446008)(66476007)(66946007)(76116006)(64756008)(66556008)(33656002)(110136005)(71200400001)(4326008)(41300700001)(8676002)(7696005)(26005)(186003)(9686003)(6506007)(82960400001)(38070700005)(38100700002)(478600001)(55016003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LKoX1m4ohoUL9lIzs7y6VTiCNvsNIESe9shQJIlTY5ewmfrtItgP0akKH8?=
 =?iso-8859-1?Q?T1DFPxwt/f34eFIDlj9dJRPGksZb4NsKPhJQQ/Zalbe/enIUgGVZrz33fw?=
 =?iso-8859-1?Q?OGbeVl54BQiAZ+DsnYPihioyH728ZBqyjgRcmt9In20G83J8gxEJeA8yre?=
 =?iso-8859-1?Q?eCb7BzWLfuudWJCCfBd7ueptH7jarNx4UnKUEAEVktvof9zYsdIAFW+4Cb?=
 =?iso-8859-1?Q?8MQ9asi3WtJdm6TLqP1s1mu+rJ0zl/FxUFl7e801zv7aAE8L4uwK1JQAF0?=
 =?iso-8859-1?Q?lIsj9eVDjdAUM1P5FpgaD75BLKcEKLqG6ez0yooWRyv28eN1QY0f1C9kIq?=
 =?iso-8859-1?Q?9JkIzTia7o7ngDnzCocZo5ywcV6s86lOSq8d0ke7HPBPBbhCAfP044GsSx?=
 =?iso-8859-1?Q?fl1U7jZRmb4k3T4QE1Cx7WYxUDmh5BXXWLBoIz+MFl7E3ZjvB86fcvcgzb?=
 =?iso-8859-1?Q?Padv8tUxoHpwdEvFoLwIRKmsvMVIJKVitewpsnhmRmqhT3j5ELrjhTqITG?=
 =?iso-8859-1?Q?orunCsXBaBajQusjGUSLyuoSAKBQQcu5FjBUsxDMctdFpHYj2k88mciYHg?=
 =?iso-8859-1?Q?rL4I0JJ/WURwti3m/P+JZ3w+hgImUEFgrV/9csw0ozXvFEITNzQvB4r3Xj?=
 =?iso-8859-1?Q?4Z5VmepagdEBJHJA0zjahBtfUS9OkuxbcjyctKgXyoRWi0p9lCx4soOM4Z?=
 =?iso-8859-1?Q?IsRtR/vSifr1TTHr09yh61DnMs2xoVefid45luQT2OUkZQZ7GQto9cCKIJ?=
 =?iso-8859-1?Q?NYxQ4uhq52hpIwefomlDHFwakRp9FxqZmeoVGWHjdcfx67jcP/HCs6pg+w?=
 =?iso-8859-1?Q?GKIdvpUJ+HB452jcHZg754ptBvfKjLa1V/OwCyzEeL87/Jg+Df3nl0HBrv?=
 =?iso-8859-1?Q?HxqIKBUEDrCKenmzqP8gzhXpqg/AVZtmw0gtTrift4he6zll8rXKZ6wu9M?=
 =?iso-8859-1?Q?2/vTUDEalW3Qmca4ax2I5foSm7sX4t+fegP3cEE5u08HmEkvdNZeKRpg9w?=
 =?iso-8859-1?Q?mUV8hR3thN4hA2RxEFA+9lsiWCiKyvYA+LcIOibQa0kvHlHzqnUew7EroO?=
 =?iso-8859-1?Q?SArpMlu0bm6cGI6K2hkXqpDEmDYvotayU+9VMTSpS1ORuUXezcb6uPckBg?=
 =?iso-8859-1?Q?qLiBvFy3OE+0zDzIpDftBz1Ol8JXeJe67iOBJAnRp8M//tQUBoZqvz+ldg?=
 =?iso-8859-1?Q?ZolR3Hq6RLUaR9RwZC0Qrs1Arw5Fxkt1tCEqxSZPeQxw7cvTuNf1m/hbFn?=
 =?iso-8859-1?Q?+yfadt3qdKl72V5faE9xzR66U4PaEZhJr8wqYzJx0gnO2CjDJd87kQvhOo?=
 =?iso-8859-1?Q?Ed9D/sea3Z+XDOh8umH3wGJrAkRjKNdbrIsKzZOxf4UZqNVmlbOmyA9Nmh?=
 =?iso-8859-1?Q?0Ipm5FHXKfcNehkOb0UM0YvA+lJUVT7svPo1m3YHS6RzeVzQFARw5nDQhQ?=
 =?iso-8859-1?Q?Meesd6m8JmrTjP7YFBahd6ZI1qHaKIph3/AZYCJwik2NEC3rg8/CmPzHSn?=
 =?iso-8859-1?Q?vLQAFLwtBoza7v82fSBcLdh2pJlMm+xSmTgMBFd3/irgf6aClB3uJEswCC?=
 =?iso-8859-1?Q?ND/fuhoHys2kZX/ZSHe6Eq7FyBOp3vvamhdXlyF9b5MyYQ5YD+xX1fiiPr?=
 =?iso-8859-1?Q?iEh98QskreRwDsNk9vYqldilbk8HwXI9Ta?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OMSRIFTdvwvwCYii/Bs5BIgZcREl/jjLedWCu3Q4ICxvaUmvRsqk5tGO/jpbARrpMUYAtVCAuYlJNwvLU1IzSfvdSxBei1ebHC4lZPE5k1f++rvewHMEBDFjHC9povkd/HpGQsN/W7WN5v8lmiwLv+/0WLSvEcUH6bM8+yeFQGHlsDT6UKyUoeOOfkm4TViRpYEnIXs2V+E0CeaJgZHYfQ+F+VPNMthX4e2pr12OtBWospliuLEhRHNb36wWG40NMSxo3R2hGyH7oavaVETCCkZo05qltthWRIGScXcoYroft6/uOs3clSYbJpo/hMBNZ1LMZHlQfhlibxrDzImaRs1BTnv9djEctAckO/I+/0O2xC+1XW5aB2XABlJ90ImhaViV20YFMQKIWLZlXsIl8ZSddQkQvVIOQrUAkxL6UQcnjlpATej3DDX7SREx3cZtE+8YhCoLaR+G4Lr2lPv1wirwTHdXSm5/h5GQpxUy+8GtZPJQxSrN0zuk+/YvlsYUweDjmUSdnbep+elLb+PSJWbi+HNPjnFXwOc+b99y2/EctboyHkj6+UQtAxN6DAE6FriDi2SeEpYbfCv34KQ227i5gGCnXh/qGD6Vnf++P+D2LjPysabXo199glQYgMwW1E1c96jVKZJBa7bW6m02UxT5qrjcpnokDUfTBYKoiRrTJgz+ziXy3/15PU+RBfZSIbHHmMHhvNh4G3xIbnYZ6RIB1U1EuiU8SnzGO+LdHlZw9F+yPqdKxDpp9LGcBDIh4vzfDjy1f1SSSb3BXsNVOf/1HUTeV4Y0K0dVhP7Jpe7zdueaSnyBPl2Mi/1V+SessiU+D9vJuiAsIyDLoX3A2r2ojoqn/AMugaf0izOzwqw2t5hntFA0mxlU5oR7xJk2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1290effb-2c7b-49d4-4c13-08daf7d11dbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 14:51:14.5023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nWmQuxvYXW2+aBkGihAqaWNm8icy4Rvzi0HTrkbxrM5COt7kvZq9VUEFHJHicD3/UJmgLTcYGZl927oliIq5YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7927
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> The ioctl interface allowed to set cmd_timeout_ms when polling for busy o=
n
> R1B commands. This was often limited by the max hw timeout so work around
> it like for the sanitize command.
>=20
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/core/block.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> 20da7ed43e6d..ba3bc9014179 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -472,6 +472,8 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> *card, struct mmc_blk_data *md,
>         struct scatterlist sg;
>         int err;
>         unsigned int target_part;
> +       unsigned int busy_timeout =3D MMC_BLK_TIMEOUT_MS;
> +       int poll_prog =3D false;
>=20
>         if (!card || !md || !idata)
>                 return -EINVAL;
> @@ -493,6 +495,12 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> *card, struct mmc_blk_data *md,
>         cmd.opcode =3D idata->ic.opcode;
>         cmd.arg =3D idata->ic.arg;
>         cmd.flags =3D idata->ic.flags;
> +       /* R1B flag might be removed here to work around hw, so save it *=
/
> +       poll_prog =3D (idata->rpmb || (cmd.flags & MMC_RSP_R1B) =3D=3D
> MMC_RSP_R1B);
> +       busy_timeout =3D idata->ic.cmd_timeout_ms ? :
> +               MMC_BLK_TIMEOUT_MS;
Isn't commit 23e09be254f9 already introduced the very same thing?
Meaning mmc_poll_for_busy() is already called with the appropriate timeout?

Thanks,
Avri

> +       if (poll_prog)
> +               mmc_prepare_busy_cmd(card->host, &cmd, busy_timeout);
>=20
>         if (idata->buf_bytes) {
>                 data.sg =3D &sg;
> @@ -596,7 +604,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> *card, struct mmc_blk_data *md,
>         if (idata->ic.postsleep_min_us)
>                 usleep_range(idata->ic.postsleep_min_us, idata-
> >ic.postsleep_max_us);
>=20
> -       if (idata->rpmb || (cmd.flags & MMC_RSP_R1B) =3D=3D MMC_RSP_R1B) =
{
> +       if (poll_prog) {
>                 /*
>                  * Ensure RPMB/R1B command has completed by polling CMD13
> "Send Status". Here we
>                  * allow to override the default timeout value if a custo=
m timeout is
> specified.
> --
> 2.37.3
>=20
>=20
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz Managing Director:
> Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

