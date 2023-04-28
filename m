Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283EE6F1094
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 04:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344792AbjD1Cya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 22:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344379AbjD1Cy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 22:54:28 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483A430E7;
        Thu, 27 Apr 2023 19:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1682650464; x=1714186464;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CVOQHoFQ77n/2N5KZv2EkwBl+aLwbzUh0zHXED9n8zc=;
  b=mKgz9WxCEy1h38A+QXevoGXav7ji0IVOKsu0Q1VMDDVgE7AoxA5liHse
   b6OXkIHbOAsieEcWWjEpaE2s93jZtMBlcxC8BntbU/i1QFZHJpyNYwQYm
   1/CRaCv1hmSShxHcV3lnxljYMJMd4Sgg44Qj4eZcmt87V9CsiFzwqqiBW
   vcJtwBb54d6t4j2TAym/8U+NRmFZn52wl/VtJoPfQ6tASL1Lt/htELOrT
   4vhY4CiNWE2KfGE8je30NHKfJy9CtSY8QotWy1ImbzFQ5MG1ydsF7peEm
   bKnJbWghm9M+BWAT+UCes146gxzcFOuAnSKbJ0ceFO0jeJVgR7ZId/56x
   A==;
X-IronPort-AV: E=Sophos;i="5.99,233,1677513600"; 
   d="scan'208";a="333892399"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2023 10:54:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5fVGVcoAxhvh9DvuVquPv4HXe4SrDVcMgy+pnEDmQpURHZLYQwFpa8dEJNkSWiR6qqm09jMNI4H59NJ1lsccQl1e6eFu48ljmjAeQ9HJNn+uG8FcIy3a354PbAJdCdKxX8JsxbWXIHAhzpK5uNkNwwci41gIt9SD0DLSHNEgod0gzeWdqqOOVg7STjCU2uHaEEZJUq31DX8pgOBXTnlLhqDNkLuZl3I+4y5CuJDqCuSmyFz5KfPSnjDUlj7s0KWavhtIZtcX373MwCgRQqtrp3tor3038ySao6sgDX/djNx6O+7xEgu9A0CETfrPTbSYdoQ0083/5Z47I71znvdFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePgn3PfOEq1MpA3r1VfjFaTxUsUoK6hJwlfWCswFrns=;
 b=HLeTHO5Ui95v3i4fQ5bhas1Oca+9/tFGYmpMt0NIHFf299XYrMSNQx4oDvPRQOxBi4BzDL6mjSk0bV3lf/rN9yesQzg54mYnZ29Tq2p0Yg9C8blVoWCZmvM8zSK9descyZ1hUNxFWS4q8fROurL4E8YyQu1kHYuyPy2qbMb684i8AiuBlLXUSUNtSPlaXKuWH/IBMOPagQn65Exr93xyQpuuIoeaJ7i5RvMk+rgrMEiG7jf8DaPDkilRTGlkCgCOA6XpGcQyjIFhwP9+TNtxG8gxATjEUzn5nuWWnAVTzUpR6v0/TDVNM0K+42FGka9bCT+zDmyLEaxcaxqmaGPq3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePgn3PfOEq1MpA3r1VfjFaTxUsUoK6hJwlfWCswFrns=;
 b=zN3vj7jgggCo6R3LZIhBU6jCF+gbUT6NADhxOwBH2G2Rjo+qSTmLKLxmI+75rpzSXtIbzKZGwEVOD/HlDaPVwwqiyG+nm1x1h7aHWA9HIrqr75chXA+myphgJmpWSJt8Yt0GyEn8QMnyr/xAphwxnxCLorfJ1mxDps7XzyhFRng=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN0PR04MB7949.namprd04.prod.outlook.com (2603:10b6:408:154::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Fri, 28 Apr
 2023 02:54:19 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 02:54:19 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     Hannes Reinecke <hare@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 3/9] common-xfs: Make size argument
 optional for _xfs_run_fio_verify_io
Thread-Topic: [PATCH REPOST blktests v2 3/9] common-xfs: Make size argument
 optional for _xfs_run_fio_verify_io
Thread-Index: AQHZeXy68rG2HytVkkq4pAqFsLjcxA==
Date:   Fri, 28 Apr 2023 02:54:19 +0000
Message-ID: <6odezvt3uwnc3c6353qlvqdxadmn5giihsj77xvwi6h4655la4@ezvpevwxfsan>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-4-dwagner@suse.de>
 <1089a043-a40c-6b49-f0a0-38ca3bcd8f91@suse.de>
 <s4xicrnevbwapdwvw5wl2z4bpm6vv6q62lcgimy6wcqnbf6tbo@u7alfvt4bmen>
In-Reply-To: <s4xicrnevbwapdwvw5wl2z4bpm6vv6q62lcgimy6wcqnbf6tbo@u7alfvt4bmen>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN0PR04MB7949:EE_
x-ms-office365-filtering-correlation-id: ec575215-3a5e-46dd-1d9d-08db4793dcd6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yInjjJO+nzdzmEVBbSgqqD8HuV3FFSfpYWzHVd3osbtBX/LrYLsPFz2xGiDvlGo+K9XGTLsljMvZuX9lSfH5m/Jm0qPgdmBCIvtoFDueJJRm2SL9vhKYPP6sZonAi8YsqZ01iOsi8ZUl4Uw1gfT3gC9Sutkx61On/BrgR2/aqdoWPi8dVkQd9Hc/kaVV85L8bw2fXcLI/Op2nZoJWukHHecMj74ap4JzjGE2PrQShZlfT9MPROUq3rzighTy8bvKXMMwnHiOTQi03VvyTkfnbqeBQT6Z8ANTPc8bjXHr72KggqAtonaZAsfNnLMK4WZRY8SWd1qgcW8+SeaEiYOYJKwLmwHi3zt+m96bmGoLikrHMiJ2Bl4NtCByWn6UReWDjJI7orlDwCQTQcWrs4/0tUA8BzVI+nwkL/cz+X6xxptIof0ltY2lOqanXZWnSc3nRgo88VmuL+EnH95cBnh/Y/HRXciNwNO2tMxscpJfH6GC+pCy82eZfzufvXK3j2bkm7HoZjnTbsoT5mJ3/0ZoOavi2fQrP5cEw0zTdr8j+/RMxKnKn2gXcEnKVkJyZabSj1gxx6xiHSkBKI60xr+3Xcwn5+7a9nuUwgZZIJbFuuy+KfL2TDopionr8x2gIRKvVmHDPuY4qD/uvJwV7G0x1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(8936002)(8676002)(44832011)(41300700001)(4326008)(316002)(91956017)(6916009)(66556008)(76116006)(66476007)(64756008)(66446008)(66946007)(2906002)(54906003)(5660300002)(6486002)(478600001)(71200400001)(6506007)(9686003)(6512007)(26005)(53546011)(83380400001)(186003)(122000001)(33716001)(38070700005)(86362001)(82960400001)(38100700002)(27246005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j8FS/wuXzVjt7CMMJcbUJhckBWmb+KUXt2b3HNBNO+KgGxITvAZQIBgXLeUm?=
 =?us-ascii?Q?Tt7KmkpFDqMG1pu8oFFXH6rr1G+wQo3po2FuFc8zFLfQ2/J4iPsLN05ZSdoC?=
 =?us-ascii?Q?1+7lDt7eMzQmGZQTTgNOn8E7O2S/CjFr07g6iqD3H41uq3LmLBmbBpSHAc2M?=
 =?us-ascii?Q?Eujm22+F5t5lPd4vl0jBAgVZM6zcMiYJmC14SrpvS27JlrbgqFBxKOm9KIiS?=
 =?us-ascii?Q?BdDvGEeiyMtJ0wyU7JvO4i7KproCHbTVAI+Oh6T3Cg+QStb507iYdTGQfziR?=
 =?us-ascii?Q?M0B2Kg7WgyLjA3PltfBe+2UYoyvfV74gNLemsaKabeyhy2XF05tfv8ktzjea?=
 =?us-ascii?Q?8ljk6dCjaKxnu1rx7dBaaggCr1cT5Aka6Gv5ys0ZuiOm/r9X/nYL2lb34mah?=
 =?us-ascii?Q?TkwwvEXIowiJJiZlJsGOvHcLj680ddsMq8h0x0IG77Wn5OzSh4bgyzCt6n11?=
 =?us-ascii?Q?A3BgD4CVnYHkUydc9yi29wrDOUwG53pDdcwDK9BWGHLL+9B1kMhX539OT5DO?=
 =?us-ascii?Q?ytgaJkvi3nf8xpxQHREJsMwrQ7KVA58D+5huTGrhZd6AQI8ljMF0abygEvdD?=
 =?us-ascii?Q?k6zvN7FaGXyCYFb9eO91heqH+dqFr/MD0wuQNEAGQmyBbp2JjvVTFxE7Iess?=
 =?us-ascii?Q?EObLNHkDGfWQe6o7WAnndTQTYQI+GknU86uiLjpQNxfKIvwgiybowIaQMtUu?=
 =?us-ascii?Q?cGsFUirTFTAh2IIJoCcIo162pd7Xuuf4O5e9L1ao1yBSzQ75gKfVBw0/nOIy?=
 =?us-ascii?Q?RQlaz3gdDc5GgKjg2ExOCn2n6uPNm3p1pHp0P8gNfo8C+CbYeCeUuNh9If3/?=
 =?us-ascii?Q?BEjyVHmI1i237m9IhozmcJrG4Q2y0hVb5AlqkrwGmWB35tHbNWxyrXaVnU6a?=
 =?us-ascii?Q?jL9Hh7bagwh7rz6f5Pm21/YrwteO/FZdwuMJ0K10Cy9glnRyFy5+ocju5Umo?=
 =?us-ascii?Q?Sv8nvqbfmbtgStGc9EqMRTUDgya8G7hJCIWLXZsK5I8iS4aPGdLwQkZ3eWkq?=
 =?us-ascii?Q?zKqjJXdNwVrDxSnp1WDwkAxcbpwHwpISzz6C6xn/8PKMU1EBRFNi6V1otpJQ?=
 =?us-ascii?Q?kuh0rZ52f+vmvpNB/FJcMDC7gerUIBTQGjkjbn0GE0VIBeIjVhz9FzoOfHSn?=
 =?us-ascii?Q?FyyHRuPH30XzMHm448bzCl1pVY2gIRviq7c+6dJmu8Cm7UFtEEPL/VLm9sdW?=
 =?us-ascii?Q?7xnYua+8raFvjTEvljBmrcM4GTH3FzCm1KbkdCBYwFxcWWieTVLB3Q6DPFKn?=
 =?us-ascii?Q?k1KqYiPLgjxTMgAomHG078Man/m0q4lnifs2UW8nHXujFSe7Wv081Hxvfr+J?=
 =?us-ascii?Q?UVI5/1pxMEQrYplww1m5AXh1/6xof78rHTsY402GScZhszXLv9zUqAMhHVxc?=
 =?us-ascii?Q?cpdanILukHYkEL4/OAj3FnGhqqu4DDp95UPl2Wocn/x3IfSMeYnIkuJtcjIz?=
 =?us-ascii?Q?nSLSHb6qnpO7KjPkqMaphLhtKMCH0nOrEKrwI6oMwLHuElskyVH01F0lXP9Q?=
 =?us-ascii?Q?2sorTkAxERYjZX5FbsXtH7x8DKiUIgowHXA+6CPLD7bCHSXT07su+2uk7eJW?=
 =?us-ascii?Q?KXcJWwCLcb40E2rejFp0SBaGSe+SxVDpjAx5t1qreFlKSNyGwMDjLXwenHjB?=
 =?us-ascii?Q?ptI0A82PREh0x/FQ9zWmjp0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <918C1595D5EEDE4DA3B5161645E8D8B6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fFZl5Bv8I6uQzSQt4L5ghAGnywQGqCi+nuDrdJu6ee74b7OISzcTUWgjhejcx0ybqNW/peYTL3fBGqIZxjg2zATUWQIebHKdSRFfLr4kewvqhXNr4JD7O6d+3ZK9/Bla5xU7AhuYMPGXkv4VmFl6n51W77P11DTeiRCJgGN9BlRZ9ZmJr6nvenalBdHl15sbn+bInOdy+rpdNGdmvi626esPX2DcSU6XwOqd/bgj2soniczqN14YwvGz1kI4aRjSoS4l2poCcCr+yIjoWlrBZylLVI01w1HlzXkCtbzzJCFTGAjusqjRZl9EtANyKMTfQOitY8F4+Vii3oU7gBtuO96a3dFo5dZ8qQ4HqE5k0L/qBXgxJjXeMmxMJZGpzorlusCwwAldYdjzVk4J0ctOvLiFFL5bSaNF9kKQQY0X6ThghzHi51MroJcY6Obk5vT243iKuD8ykCM46CyrW0EW+mHs009miHLz95xlVJqrqU+5vhQ4oF/vuRup+/lsxHapmYPKA4mTf2s7xPx/U8031b5DlDCWPIhtKClFTBZronmv+OXwf4cDLp5EStjRLHfS65rCBzt7QTgFQ6+fj3S2Kwm1+Qo1sgmdMzE7dEOmmShBgAMDxfScm1nynljLpSlPLOka+JpODhIdf2RGCyJ6O6EIWaftG16lpE/843tXOXT/lwGCNZ+mE9Oz/Lf2Y40l0YnldWM/KEYGVXHMuWiYoblEsxwlAh4HCUnYvrFBhv3xbH1JWqdEI4i94tdgzogpRjUmHXeFZqtwn5joBhjTFMqahx5zTVUF94nAFQ4ZRoalj3VHaLoSh9ckkZs6SEFboBXqgGKqnGu49WfZhceTlLf0ClXsLetQd4jpukSqmgaFRxnj1twqkcP2+HEaLknPQvuFgEBziIuVoxupuZovdDc6KDh4so3v8T1IVaRQoxw=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec575215-3a5e-46dd-1d9d-08db4793dcd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 02:54:19.3220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uLG/1M+Jcj1qfvY35n4X7baxot5wcPokPZ3S4VEocOJY1uQKw0Y4zCnVpNauQT7AzcjjUMSgfqtujzt8QudRKBcMXKUkCkDWWJKkuN+rsSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7949
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 21, 2023 / 08:54, Daniel Wagner wrote:
> On Fri, Apr 21, 2023 at 08:27:35AM +0200, Hannes Reinecke wrote:
> > On 4/21/23 08:04, Daniel Wagner wrote:
> > > Make the size argument optional by reading the filesystem info. The
> > > caller doesn't have to guess (or calculate) how big the max IO size.
> > > The log data structure of XFS is reducing the capacity.
> > >=20
> > > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > > ---
> > >   common/xfs     | 6 ++++++
> > >   tests/nvme/012 | 2 +-
> > >   tests/nvme/013 | 2 +-
> > >   tests/nvme/035 | 2 +-
> > >   4 files changed, 9 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/common/xfs b/common/xfs
> > > index 2c5d96164ac1..ec35599e017b 100644
> > > --- a/common/xfs
> > > +++ b/common/xfs
> > > @@ -27,6 +27,12 @@ _xfs_run_fio_verify_io() {
> > >   	_xfs_mkfs_and_mount "${bdev}" "${mount_dir}" >> "${FULL}" 2>&1
> > > +	if [[ -z "${sz}" ]]; then
> > > +		local avail
> > > +		avail=3D"$(df --output=3Davail "${mount_dir}" | awk 'NR=3D=3D2 {pr=
int $1}')"
> >=20
> > df --output=3Davail "${mount_dir}" | tail -1
>=20
> Sure, don't think it matters.
>=20
> > > +		sz=3D"$(printf "%d" $((avail / 1024 - 1 )))m"
> >=20
> > sz=3D$((avail / 1024 - 1))
>=20
> I tried this but the devision is likely to return a floating point which =
fio
> doesn't like. Is there a way to tell bash to do a pure integer devision?

Hmm, AFAIK, bash arithmetic supports integer only. I tried below, and bash =
did
not return floating value...

  $ avail=3D90000; echo $((avail/1024))
  87

Assuming bash arithmetic supports integer only, -1 will not be required in =
the
calculation.=
