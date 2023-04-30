Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3C16F2876
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 12:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjD3KeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 06:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjD3KeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 06:34:07 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C219A128;
        Sun, 30 Apr 2023 03:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1682850843; x=1714386843;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MzswvGMHcnCxEsF8OVAvVl0w808E8LmOOrijAKpoJCg=;
  b=BuSyciNfUPQLx+dDz2KuxE1yz3sO5q5GTKueyW4MEnOaVcDvl8LJ81Rv
   KrBQsjovmdPadlytL9iRj2iquX/1pZ2cR8qhD3fVRMOhBfMLnWMxm5b2c
   mBAtnaud+MWzHBboFzrNJH7cFg8cSkXEuAWybGtIybqSXlJxkm39Ms2an
   FFZvdyuhhr3zNmq6qGiXIEc3KsrbWx2HHJxvvL+WNDz7n5CpOFhehLe9h
   pifodZBPQiDff82j8ARCUrWgjZPaengEGzv0NxFBkybNVFCInqDNl/W+k
   gqNhlTMFR9+PCPN9Uia3I8Sj9Wtg2vtNVg07qecW9AjKWQAPiPj+anMGL
   g==;
X-IronPort-AV: E=Sophos;i="5.99,239,1677513600"; 
   d="scan'208";a="234561045"
Received: from mail-mw2nam04lp2169.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.169])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2023 18:34:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzdMTdcePfhI64sNNAJZOApa/EfEXU78tqUJLPj0VQIpcZilnXmquRMJ7uC3V8+3agwezdF29AYZoX6IL3SVVPVGleaRPL3jnHgH8uc+M7mWRYqSwDt9O6Z/eWEY+f/Oigxw+EX2DuZeOYZFbn2xlK2YVhQG1ebUdJyLTcinD9osw3X35jDiIidbdqKT3Oc2btajID/Z4as1REAx2SnHQkvH/s83LufELOMNAS7TQkjy/gd+/lUhnyJrHMb/kBFM8FxEWY8HpR3O15K5J504HeZqJRhsYLvbAqKBXLC6UPpm2gH75SFzm7KErRGiwdjJY50+jOuTr2YOIlWohFCE8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnhRl3HxRiKQO3PEQFkeQvI8mz5R0FWshIQwI4mr0cc=;
 b=CsXmSFTgLS9WbL3UYBw8OX1OxA1xqHMJoB1GtBiU+u6seZaiPKoNlBGK0Xkn0HDMw1Cmqy2M6Mo55UF0064Oxq64KWumCRGT9/QCCjSvnVmdJ63RczirxR7y0q9q36RKZXo3sFRScuSrF7K57J7OcfcmTNrrApVqSPsaxYQIk4yWloCJHsflDu7Fd2BcZJsM9Hi6NQj5wWdLiaKaEPEjVsO37z1EfOoEzEkJ2GR4Gsa0mvzO+r76RhpIMOYTY9D/Nh66jUXcFWxHOOru2irmj3qQeYWpI6+p1EizuoMNaFr1PemA7gLULJqkw5WTkWx0prjQddRtCK1CCzVU/Zy3iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnhRl3HxRiKQO3PEQFkeQvI8mz5R0FWshIQwI4mr0cc=;
 b=SiLqFFF5iyJDqFxbEqEiMSR491pNTLIW4ISPd4thNz7ZqKOypis+XX2Abf9nrD6yP6ZtUwMZhyct3DwSGGfQLf4vhj9UIOfM24kDE1u+60XjLy9WkoodfpG4rXcKN3D29RzZrRDQtAzE8oXrAFfHkK4Dk2w1AWtZafeI1is2QJE=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH0PR04MB8145.namprd04.prod.outlook.com (2603:10b6:610:f5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.28; Sun, 30 Apr 2023 10:34:00 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6340.028; Sun, 30 Apr 2023
 10:34:00 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>
CC:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH blktests v2 2/2] nvme-rc: Cleanup fc resource before
 module unloading
Thread-Topic: [PATCH blktests v2 2/2] nvme-rc: Cleanup fc resource before
 module unloading
Thread-Index: AQHZe09FVEwtRfzey0GWUGL193fJOg==
Date:   Sun, 30 Apr 2023 10:34:00 +0000
Message-ID: <gqeyqpv2idkkkf7jajdxbgj4fi5tnlbt7tmuudwxq3gul3w56y@ijwb4axr52dl>
References: <20230419084757.24846-1-dwagner@suse.de>
 <20230419084757.24846-3-dwagner@suse.de>
 <3ec250a9-54c7-3e0d-2463-f8faf15cdb58@grimberg.me>
 <3euieyvxpsww5p4m457pzupfipbnbv3atxauh2lrp54gqmqcco@hs7ytoop5osf>
 <1b060988-fc63-4a86-33b8-88ba61c9358f@grimberg.me>
In-Reply-To: <1b060988-fc63-4a86-33b8-88ba61c9358f@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH0PR04MB8145:EE_
x-ms-office365-filtering-correlation-id: e7da095d-19b8-472f-216c-08db4966690c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DgDFhhtJowUTDTQ/Qhkl5/E6HEzydPTRafIToJ273yC9iWWprcggTLzwWpqR1qwCKsI6tQj4lqga6j1biLUFdCMdEB3ZiE9KtSjBU1hdqXoB44UGTyamlEXif8Gat7iYHcWzImnV50OCMS7mCXJN2VJPVyxRTmPU6xr4NuJxL0mP7fDgkDi2+/F40xQ6oEabYmiUWFBdedXCGmVj4m+Tt2uEEdaJPYpnDGju9jDFBU0gVYsU+y9OTzoj00osOBUn914+Csrhgc//22p4CNjKhRXUG2xDbllpRZr3/dS7skyrdrBfqZIQpJUu+vzfPJjXFb0l3XlgWnfIUvMfwYF6Q3HkITuBvEdpZ41cTLgGGmfLzOuC8UzXhT/vaM9OObSdv6VN+jtsdNiU4v+Az6R5Hevr3VpvgU0hkx5hYDRq3s+ts/EQgnn6x3QsqsEnj4Jg2CnkOHKV0Ysaf3NwypeU/hz3wjCJYwHJ/GzrAOd/6sfAFg1pH4LRBLUWCapw+/OABW/2I0QGnHudTyHpA5xWTCUslNKMwbgo4b9heRC37JofDFPhiOillWksVTy8QgTilQjKyrFydRlDkoPfuAckfzal059MSV+21xupLIB/y0/NMUqwwh8Mjg/DA4Qr8aMO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199021)(86362001)(38070700005)(82960400001)(122000001)(38100700002)(44832011)(5660300002)(66946007)(66556008)(66476007)(66446008)(64756008)(6916009)(4326008)(76116006)(91956017)(8936002)(8676002)(316002)(41300700001)(33716001)(2906002)(83380400001)(71200400001)(6486002)(54906003)(478600001)(9686003)(6512007)(6506007)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vTlmm/QCIRiDzEqeMUdtUdKe5vk5c6dL2wDv6diyFmmsocNxw9VqbqFwWS10?=
 =?us-ascii?Q?NhCm6faAWVXMHGSkUkJWPEmyGvU1Q8b56AJvsKiKVB0yrp7HLB+tlOi0wJG2?=
 =?us-ascii?Q?6l7Ba4tuQ1D8EAifd4O9oMX+Va8VTLbDhXJUVzLF7so483frI7HuM2N+TO1e?=
 =?us-ascii?Q?j1NQ+ZlzjWfUVAvAGb9TPRnaNz4bCInxxAP10UI87nUTeJq5u63KI4HdqRel?=
 =?us-ascii?Q?jtyQT6p+rYVd7CU1nvjhDLGrr2KeM20VIBPrBGik5NFGNExynnHs5j1/vxPX?=
 =?us-ascii?Q?1KgbcRoOyX36VOES8KKZc+GGOwWqUfUZ0xCBRHy8PH2T41cnx09g/wMYEaLI?=
 =?us-ascii?Q?ua5XkuByChmFq6+wUJdGJxpjs3qLtvwCOtuQKFYHS1hxyb2bbKUHTWt1Su1g?=
 =?us-ascii?Q?wTwfjdsJFtXqTiR6GQqTdMJvei+pv3ZnlyuNp1uBpETIQrJ7mtwJbBZomyDE?=
 =?us-ascii?Q?iF40rkbZ3wxEPtdgyVPU4cCHf/6JmnF0qN6a6AUU5kZA16Zdwaz+Wdn33RS4?=
 =?us-ascii?Q?af9DJ0GjV2LnrlXzDfM0gEhlZORdXqLneocmCuU8FFQT4V5RLuQkT1ApfwwC?=
 =?us-ascii?Q?lEk/qx8EjHkgozTtJC9OTUHG1JrDm4LL3CdBmCle5oHNb8I9EyTFX8VVdGWG?=
 =?us-ascii?Q?mpGrAnza3TzNoJJluCSMPZlLYFwLsun56uAKnBOi6GbgaomdBMkFqb7mM072?=
 =?us-ascii?Q?bPO8q8wkQykpI3eCGP6T633kMaUphzbVbVHd0Q577Fo4fFGrYIQ7ZiUOKj3y?=
 =?us-ascii?Q?0g5vGwGr/ADnbWbTQyAcMuO/b4h0d55DMN8pU0PSKfLgiZaY1oLRTAseg77j?=
 =?us-ascii?Q?ZDCWgLe2DI/uAheYCObT0UV67eisV2lsuwvMO3bveK7FU5bGjn49GWy8I0Fa?=
 =?us-ascii?Q?ovE5GCpiTxskLH/I0FWUOshstEHrQ+Ho4B2VM7KP3pC+UnNaSNQtFEhirc+b?=
 =?us-ascii?Q?OqWchlMuxXxOzXz7kUMg3tdBstZX+5K+bRqtteXe4XitRrIB1UlWJcg/+7P0?=
 =?us-ascii?Q?/Kh/YI/gML3Q0Ytx61tr0zcVGxLs+pl1RRCmKI0XsFKPaN8sdeSHrPTPBdck?=
 =?us-ascii?Q?ofJvisZa7IClkbJbpMd1kSrlgFwoE5H2XKNQVn4V2oS1i6ok/TU+wztK8Fl9?=
 =?us-ascii?Q?IiTWiB3QV8jbhesYBm2S8hrsiq8n0Xv3rNycGwuAdqVrQAip17LaxOAzUZ/t?=
 =?us-ascii?Q?08uy39g4S5dKN/dZW7iHdMMfE0ZDGpo0tCmCPZDNAYWQ9HzF/kQ/jYCV5RyZ?=
 =?us-ascii?Q?BZ+84VpoEylQj5ZVnBscfu2xbcRwuexGYbpb7FPwlW4wqIss/fTTf1Zobu68?=
 =?us-ascii?Q?T/HqAEAowsEXdR++oVedTNVW3esWk66Hld1o7XBUhajuJpe3JDKTJkMJgKaR?=
 =?us-ascii?Q?6/2s7F8i/y5AzsCIZW960DlSoaspsWJ9eD5hhT16iAnQs02wyCOivBcGRRS+?=
 =?us-ascii?Q?EjvCS3nwwDdA9Q/Sp2JX+vHmh2ih8IgMPj3H3sw7aEpaUoX/TcemgSXw5H5E?=
 =?us-ascii?Q?RBRjQ16B9C+6GTXnAWjbuqygft2t33nA00HkjMWyyOLWii8jHu58mCm2fgHW?=
 =?us-ascii?Q?MuAUCqzx8VNJqgNWVCp8eRNNcuJp5if4zlP+2+5SivS6/6Kg1rfCTm7SQqgQ?=
 =?us-ascii?Q?1cKVzh5ipU0+CMEprNXZ/6Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <99DFAA1526CAA141BE76DF692111635C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?UVSYdD7DFUg7xaHxfq82t6T+m3DcLi+gIq7RO/MTZKMmC7CPzNepzraJd8Gp?=
 =?us-ascii?Q?e2fLR6Yqw45YRwt+eTIJ73DniPCOB1Sm3si2YHI89MuadK9S5cuA8zDKcd6d?=
 =?us-ascii?Q?YDhy/AilUJnjrk5+WcRRrzD2NP7NsTNZug+QXb7S3rmlZWreagZrLCfU9+s9?=
 =?us-ascii?Q?VFO1TQk/WOElr+7eNlb72Xfui5bQCsaMcdgDT0ouKLaKlbDNVPq6pw1MaK+l?=
 =?us-ascii?Q?PJmVgK1NiTSHYjtIfPPuP46o7myO8qQae7kqjgKDUrtgQIdz9BHdGalZNT+D?=
 =?us-ascii?Q?vVQ38W1fh0AJRitGZrFgy0W0Ao4jyqdPsD6Q/ADOMVUvfALBNfW8TnfHoJVC?=
 =?us-ascii?Q?Tsgi5tvBiFloNA0SeOz8OqeoG37dAKTPEkFjxkyTrxEOjwGPx5BXNQVNvAr/?=
 =?us-ascii?Q?IeJlo/zB+NSaKBGYkQ/oDJkHbZb45LP0Cnof8s2cATSlSq8I69+lo/3Ru4Qf?=
 =?us-ascii?Q?r91p7iHorFAcSJx/urI5zOi8r9wgSrB663FPDs+ufaXefeF4jS6k/2TrH+6Z?=
 =?us-ascii?Q?z6oFtFSzBhtoqVfhNVKJIvjdfJrTak7JDlkV3XUF2/19iiAhl0OCZOa+dHW/?=
 =?us-ascii?Q?py41vSBvbiwXJIbXjWRuLNehii418X/39WrWA3Lh+5J+8A1A3C41IJ08imJI?=
 =?us-ascii?Q?p8Y1mLa/F+6hbl14U7ieofeCHGPy1yZyhPz1LW7LuYFFaC3L8tNADyomEkKD?=
 =?us-ascii?Q?8raOeccvY+a9oZBBhlC7lgpmw9QKaevxK2rAW/mIVFIKRCFwMz/B0M5iIDfg?=
 =?us-ascii?Q?j0DvkPmhVq0VRJUBP1ikFU2frNpKCvAHJPfDdAne/pZuwIEIT/wH2cgO6d8w?=
 =?us-ascii?Q?bynaRZoiBIytyIS5YJ+YJpdvWtRl+Sb6fVrOoBmHZpyDDOSZpHI8iKYyuxDf?=
 =?us-ascii?Q?6kcl/wWpb/4peLp+YbB1yd32g0ZQB1h+Y0jY9pMMN9Thg9qFTgE2DPPUiM0N?=
 =?us-ascii?Q?9kM3lg9xirVN0gq23z3mUw=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7da095d-19b8-472f-216c-08db4966690c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2023 10:34:00.0840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W+sGrws7USIyCEW0wpeK63gkTny8bTNsGO8u8w6jhE4lCWlPpytZOimxuABLI6m9PDDOODh1eYsKdPtaGR41VcEbtuFEByrAy6AuqCYaE5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8145
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 19, 2023 / 13:45, Sagi Grimberg wrote:
>=20
> > > > Before we unload the module we should cleanup the fc resources firs=
t,
> > > > basically reorder the shutdown sequence to be in reverse order of t=
he
> > > > setup path.
> > >=20
> > > If this triggers a bug, then I think it is a good idea to have a
> > > dedicated test that reproduces it if we are changing the default
> > > behavior.
> >=20
> > Right, though I would like to tackle one problem after the other, first=
 get fc
> > working with the 'correct' order.
> >=20
> > > > While at it also update the rdma stop_soft_rdma before the module
> > > > unloading for the same reasoning.
> > >=20
> > > Why? it creates the wrong reverse ordering.
> > >=20
> > > 1. setup soft-rdma
> > > 2. setup nvme-rdma
> > >=20
> > > 2. teardown nvme-rdma
> > > 1. teardown soft-rdma
> > >=20
> > > I don't think we need this change. I mean it is a good test
> > > to have that the rdma device goes away underneath nvme-rdma
> > > but it is good for a dedicated test.

I agree that the new test case is good.

> >=20
> > I was woried about this setup sequence here:
> >=20
> > 	modprobe -q nvme-"${nvme_trtype}"
> > 	if [[ "${nvme_trtype}" =3D=3D "rdma" ]]; then
> > 		start_soft_rdma
> >=20
> > The module is loaded before start_soft_rdma is started, thus I thought =
we should
> > do the reverse, first call stop_soft_rdma and the unload the module.
>=20
> They should be unrelated. the safe route is to first remove the uld and
> then the device.

Sagi, this comment above was not clear for me. Is Daniel's patch ok for you=
?

IMO, it is reasonable to "do clean-up in reverse order as setup" as a gener=
al
guide. It will reduce the chance to see module related failures when the te=
st
cases do not expect such failures. Instead, we can have dedicated test case=
s for
the module load/unload order related failures. start_soft_rdma and
stop_soft_rdma do module load and unload. So I think the guide is good for =
those
helper functions also.
