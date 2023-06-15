Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7D0730D42
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 04:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242074AbjFOCay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 22:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjFOCav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 22:30:51 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D371FC7;
        Wed, 14 Jun 2023 19:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686796249; x=1718332249;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mLQXLwIGjRIDIr+lSLn3BodfkyBAKCzBE1n2eSnwndg=;
  b=WvKiP7zrbY5PCYz2t7suZXoJygDTUyO44F6CXBwgf2TzKJOmG3sev8dq
   vPrGN+u7ql69AgQfsO6bKJbcx6jSCHjjTcDYcls6LlQDp8gGsSqmL2NW3
   prQC6iA3xINz29WCYorjQRc6MoWS+Qh8NI+lOaMKKQb7V1Awffl6iAdeB
   E77pTzAZRdlfWUv+n2el3RIkBtuWGJnagEhOdfYN6iuUPwDHEQmVStmdy
   fLeaknq3hBFeFEgJ47l5wKL6XOqwrbx+WlSsZieq1PvL+V18en1GPSzps
   bZ/yZWd9qEKqoXIXw4Tf74B48pXSIcuLMRtdX4gA25/wwu6XBMxTP/sT5
   A==;
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2023 10:30:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9RriMld51a/Y3lP9JGm3LCzNqM3+0MfDzQWA5cxx+eIZfCCOtBE4B5kgzJdoJeJ/yiEb46i48Fk94QTrfpYOCri4KkZdAd60VGV4ZWDdE6ruIrOYkJd3dIvWsAJ+47q8lZTWatFyvj+4jN5x36beVKjkOMiFBxCyr0pcjNn+meTrpujYD8qE33Ffa60YAQlNSpHBMLYRsaLtnxnuuMw6YsOOGA/TjNSfCJOhQCW+H2b619ob3Gtyp0sf5iY76GVEseu0BSRlN9BIVYNigQAlCN9qovmo/l3AeaWc7AmPex6zCe1H/0/kzU38aYpL+9JJC47y81IWK11FyFL+p2N9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maYz88gxmF3zE8vFiAKNTJdtIDpPO9iQmRT7eiaPW6M=;
 b=NqIGCUcTlPSzffAQdNy+Ym4jrWz3g7aSCKArPH+ZwGG6kei35QMLTH/G40a94+sW1nchAjwX2yapeqk5kkTQQninLPZOB82TDh0b5EHgNo4h5Rvckg06LNB5GSL8QktO1aXA69OrZDyyq+eN+SlyVLwE1EcG9hU23+Kj4owhSCDJblt++0JtmAbNn2xJ1p3qYuG8DpP4m08+IXV6IRjvHKNyDX0dQ40Yl6IZniMEB6/LF4k1nJTSw1gyk2Fp0AGKnpsXGZjwdLwsQVeqrk2SdD3pzrkvspTQH98hJeFvzNkVwWtznpgCkefQvQfakIPLLjhNzkedltLFcyIGhFDUoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maYz88gxmF3zE8vFiAKNTJdtIDpPO9iQmRT7eiaPW6M=;
 b=B2SxaoCYdb4NYxMGtbWEamehJL4zE0PhYvkAeSm1ZtqLfclnVk5ZuHnjcI/UsscrVM5I/vLJ30mRtym68pN1l1fNuS+EmR7G8MRTDaXAVXG4zZ28sJtzcxaarYv/7Rz2xu/DJ4B5S/l8h7ck0eiv9mTKip3eB+OXPbIMQbP4hS4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7695.namprd04.prod.outlook.com (2603:10b6:a03:31b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 02:30:47 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%6]) with mapi id 15.20.6477.028; Thu, 15 Jun 2023
 02:30:46 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1] nvme/040: Free loop back resources
Thread-Topic: [PATCH blktests v1] nvme/040: Free loop back resources
Thread-Index: AQHZnrE4w5/2y34gjUOOvl0fC4wVwa+KKOwAgAD8dgA=
Date:   Thu, 15 Jun 2023 02:30:46 +0000
Message-ID: <6vx4kyddssjo6lerd2biogylkrwrbtvnpaoajf3wfzsadosiyn@sefcrktyz3zr>
References: <20230612142945.10969-1-dwagner@suse.de>
 <bsbx3i3ut32zbatwrpn3t2vjbjdmttqul2jt7opd3s4mipo6pj@5ojtsv7aunbn>
 <pzgf2abc2piophrwt3m3elaeb3vrrgrvxyq437ytpmah6rnxf5@m4gfyw4bcmxo>
In-Reply-To: <pzgf2abc2piophrwt3m3elaeb3vrrgrvxyq437ytpmah6rnxf5@m4gfyw4bcmxo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7695:EE_
x-ms-office365-filtering-correlation-id: 6973cc50-bd77-493e-b3c8-08db6d4886c2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mVvBfrHty0iZ8BEQM9bWVok3osXPZ4xQ0M9oXYEbGQpvQ3b9SpTuQ7M0oV5sj6dpPwPNzRz+Z86rGSjOombdIAvdU6tiAFbpRyThu0eHRwelgPIEoKLH9jWiIgwH0MI9bzXHdLiAaajrXz9cHWw0e6T2UaFq7beBcQnrg35TxnH1YUrIaL/bH1UwhkEoJ9SZJwMu6wcxgVFUlxU7YEXBU7TiIlT5yaNyqevu6AhLMlt+I+R3ahOjln+hYX6E6KCF/I86SxxDjSPQ6gqjjxqPs/6lpGLYziG7ARzPu7GdAtUpPrMVEMVspGffAtl64bKqlggJ5RVz6hV1b1ykIL6cM48iJVSbI7FMLNI8ISho8ACIRXCpMlXU7CtsYGhgLLEBaJjgGsFhnTdN1mDRguaJel6PAnKjG3n9EeuGLXR3P5dFt8oNFXgEQe+meG06LxLzXBgyyBCXlrHVErpVwx0O35mPyR1dcJYSPcwIbXikeDprpk3tojGZL8hNldYB6Ep6YQsEUY64Kcmrhco9aFD+QvRQVH/AfZVzJ3fPyV8ItI0K2zEih3lmQXfVp3japlh8Rf7o/HGEXHV4XnCAuW8dkxv8QcWda1vDTmoubDPyYxXEuiRQJCyuioNcMxEeN33b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199021)(6512007)(186003)(26005)(9686003)(6506007)(2906002)(66556008)(4326008)(33716001)(76116006)(91956017)(66946007)(64756008)(66476007)(6916009)(66446008)(83380400001)(86362001)(82960400001)(6486002)(41300700001)(5660300002)(8936002)(8676002)(44832011)(316002)(38100700002)(38070700005)(122000001)(54906003)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CdE6wxdzLAm+GqrLtn+dP+c2NBP9unGUKge9fi7ljZ7o27t0g7aS0qEQpYRd?=
 =?us-ascii?Q?SUaxwyZr4Nar1dhD/iJM//QoL9FshrTLmFaSQuSMJuGRrFJVb/DgZWr0qROT?=
 =?us-ascii?Q?Kh9ZNbDtXanEzye97vu5W/4YqUmi45nuUp+Ec//zKO2sVt3nJIXXWwsqPmCe?=
 =?us-ascii?Q?9Ajwc9dpmlBWEKue7DTdJjbP0LE+7xo9eEwrEc5T4yVLWmVABIy5H05lWv5I?=
 =?us-ascii?Q?1YDPtiI2ia8SY5kcWE9KXW0jXKoXn4D5N0b6AQDHIlNpO++WYZdvxfIr9FGg?=
 =?us-ascii?Q?pGBmNDTVSkKY4WRj+4pf+EPUotwb4R88bYrKI49iR6yehSrTPLWqbYHJIYLg?=
 =?us-ascii?Q?MSYEWJXuP7/tTkzRjS0Zo9vsVbswsh1oVHjLWnOKUhheif0a42JntoXcBEGO?=
 =?us-ascii?Q?lO45C9J37JhNtet1/8ej0FhcZsEJZWzFJDGFYR6+GAa00NRMYX9LbI7BIWyF?=
 =?us-ascii?Q?6fdl7kShgEFUv6maNvJJI13ttaBJrJeFMbECpQDmwmQCMhJN1qHELbxP5738?=
 =?us-ascii?Q?vGwDW1s2qjenlkadpL3r9gCb0R0pUNatCGmC8w7nNwGLS9SImLciFWZUOkCV?=
 =?us-ascii?Q?d5aIrh34O9sMGUUNEvixWep5diGAf0YJV8KZnhwaJ4ARM4JNUP/w+lpsIiT/?=
 =?us-ascii?Q?OtwxPkgOQrOKPCtX1n5e/0nGhkm6pjCMDmpj3uoE2nkpcooUZOsp0OVzW8Xu?=
 =?us-ascii?Q?pvEtGYAYzCH9JWoDWntSTnNmMuFC8cu3UYqonoFm/z4k0dlqMxWrQw78tHQB?=
 =?us-ascii?Q?ONnCUN3W7lKctLQtD4/R+a2EW0lFbx8KViJGJ2TzJNBGaXHkoFJd1XzQisW8?=
 =?us-ascii?Q?9ELCUhg5wx11j8enX2ZoEr16H8VhtVlA9S2DvyEB+oTb0LdrvNIDDdwmHqUw?=
 =?us-ascii?Q?EMSe5vVphYaVFyLOxfiE7QjkjihvwPylT2bHsSbg5Dgzhvf1BceVil2NUsnW?=
 =?us-ascii?Q?lsHI7+exwwiT3xSN4GBNMZJkBwHzii+E/DB677r7SEid/naYCPq21jcY2u4c?=
 =?us-ascii?Q?40lZ3YOLYfaKvvuvpmS2qXZtRG75YHB03FMy0oFg896nBhxebmufZrtmDFzb?=
 =?us-ascii?Q?lVkAiTj0K6HsNX4DLnCPFvrh3hx5uhmaC8FnRzh5DxdqdFXdy25F0JYOWGjA?=
 =?us-ascii?Q?HlETY/z/xjfJRgljwcMViZ2AlBZ9oI+6TjLP/Nm8wlF+cl58mcDm6IFLzG0N?=
 =?us-ascii?Q?z24GBwxyP02FnBXG2PxjzFshdLiY3mSubTw3ez4NGz+OQNtdElL5dAiPRcU8?=
 =?us-ascii?Q?fFtAVJyQIzMvOoH9Ou2CvHqvAYSggdRgpNH+VnmGtBYvAmd5N2iGN6e6Q7Su?=
 =?us-ascii?Q?uDXpZKQqE+7uSKeTsly7hiwiBLVq8PUm+e58Va87uKpY/sBu1VFwLZa79y10?=
 =?us-ascii?Q?lUZZnesZnVoRrte1viLl0YZaE0ug5RFJduRzNrlCHpWDPnuRKnpJ/t1Hd5p0?=
 =?us-ascii?Q?hcdlSDBRgUbc/6MhJLbEcuT7Cz0xfvZ4YLMjrJ2zCRZieFqksHjPvbuwFR9s?=
 =?us-ascii?Q?ZlgGEe6onUatItjGzSR636bv04wu9zfIxQNLZxuw64O7aEt8PD8IzGCM6tXN?=
 =?us-ascii?Q?1nK6t5qgT1vXlsTTRqCfBZgbDRUDNJBBxx3iPfQTziyrS69pDE9PqlgnoJ0+?=
 =?us-ascii?Q?JixIHo1KGnm/w/7ui/tza00=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DAABDAB5C834B04FBFCE2352A066FA83@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?aJ2aR7PQrGXsfZnmF6XU56J8noUywWSj0j5Pjhsp9J5AVWrXz3tAegw65JmZ?=
 =?us-ascii?Q?0pDvl+SRqZen/IYziI9Z6lrZxiLqLpM7k8tssYM2dl4mOTMbKwGK4k1LZgwI?=
 =?us-ascii?Q?xOLqf4tzCCkOg+Alo0DlGm6DCySbY8gqwRUVA01WYNxF6pI2sMC9MDfoUSqQ?=
 =?us-ascii?Q?kwc6odbO3aheGXFV2zqUIg1C2U0UqGGAl/ED9I7K1Jm3k6kYKpJ0ANSMaHl7?=
 =?us-ascii?Q?zThg6+IrB55KBEcfzAgg2DntBYJkTb11DpuU/HQK8p7B0dn3+5BOfR/Yausj?=
 =?us-ascii?Q?XEjntssKLL2D3D2yV7SUBSYXPwyKajxOhbdz0HeRSgi8Fup0t9F88SYoIBu3?=
 =?us-ascii?Q?AYU/NbQK7qphJE1Xzw7gLXZZWOpZSK4x2jVA6dSShxp+wV+F0uy3POfRtyNS?=
 =?us-ascii?Q?+1NmfeZyAU182mcpi0ZzIkLQBEIzFcaQ+2Gh43sliW21XmusIRXoXE8AoQrN?=
 =?us-ascii?Q?7s8dGgK9dmjZfGDhbjFbAcmmGlF8gb0gFg4OK41L6EuPJAij72t6k2rtv7oI?=
 =?us-ascii?Q?0hfJb/R+1LACWaU/BWrTjnZdXQeKtYTWOOu0/INZsqcoQ9wAZVkYKu25DqSQ?=
 =?us-ascii?Q?4scTKJ+dryfzcODcCv5OwqwdsCO/LWIhfJVImFy+Z5ItMNm/R1zryAFjcmzm?=
 =?us-ascii?Q?Z3WpY/g6Z/GpWbr08Orq/YDUh1Ti1yIzuvMJ8eztWKZLfX3EgD+IRxbIwynG?=
 =?us-ascii?Q?c8IETJrLKxZJ0GMb8aJAhlMdY40DpBAseZrGsUjeqEdTR2pdhDSpCVHrI3Lk?=
 =?us-ascii?Q?b+RwEh25nJHJPkdLU9cVXNvglncKSY/pkk9ni3c5EWpitKMK+hdc7k7FAqlY?=
 =?us-ascii?Q?UHqnG73EEXIQuNpa95rJlcUsfrGEaP3ZDTF1TP0KpWAricmkudrvugXBU8g3?=
 =?us-ascii?Q?IqRqjl4khwb3dw82491qYb++qCYfRMqdIyTUgBiNNOorLfm5QWd8jyfZiocj?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6973cc50-bd77-493e-b3c8-08db6d4886c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 02:30:46.8967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bjhtH5YV5CRifLzyKPptMmrZEgHa4lkZ12HOOYSHHeLvpJiaaNhNkP+y0gcTdAOtQLIHpbJ/3FT5Vm+EXQI0D85+5bAV9Ct9BGPNTHHOAXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7695
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 14, 2023 / 13:27, Daniel Wagner wrote:
> On Wed, Jun 14, 2023 at 11:13:18AM +0000, Shinichiro Kawasaki wrote:
> > On Jun 12, 2023 / 16:29, Daniel Wagner wrote:
> > > The tests does not cleanup all resources after it has finished. This
> > > leads to rm not being able to remove the TMPDIR cleanly:
> > >=20
> > >   + rm -rf blktests/results/tmpdir.nvme.040.m2J
> > >   rm: cannot remove 'blktests/results/tmpdir.nvme.040.m2J': Directory=
 not empty
> > >=20
> > > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> >=20
> > Hi Daniel, thanks for the patch. It looks good to me. Now the test case=
 leaves a
> > loop device. This patch avoids it. Good.
> >=20
> > Question, I do not observe the rm command failure in my test environmen=
ts. Do
> > you have insight why you were able to find the failure?
>=20
> I am running the tests inside a VM and I am sharing a part of my host fil=
esystem
> via NFS which contain the blktests. If I understood it correctly, the NFS=
 server
> is behaving slightly differently here. I can't observe it either with xfs=
 or
> btrfs.

I see, the NFS sounds triggering the failure. I've applied the patch. Thank=
s!=
