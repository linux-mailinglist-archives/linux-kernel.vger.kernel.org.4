Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B4A6F3D39
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 08:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjEBGNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 02:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjEBGN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 02:13:27 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFF035A2;
        Mon,  1 May 2023 23:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683008005; x=1714544005;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XnhhV5iYo9q0m0AZ5eLUYuIwWlD8uvjia9LcRj65nHw=;
  b=Yo+izIIsBgQSuJBR2zADOAq53ZoTTWQ6+oB+d1cTydmEF2Kaq9SSqeP9
   RFRrlg8flDEIIhDGlJGakzwhP3KrBpXz8z4GmMEsFHbUiqGcNiays6mNj
   gBGbyzMvyKrt1W2NlNTcQp1hv9nCBcO7tqHDTWfEyM+Fkdkydi4sbtErt
   hvLPuwVrOXz0uPzDcAOaOfJ2qz1hOBeaGQA7iiYecgjcmiNnkjwWM9GKf
   xR7k0iDKI/WR4QKnR7xxPW5VsAn9GOexUj9BQV1foTzCs5pmgiMokrmbu
   f7VbIIw+NlslhYY9lLxcKj5+7qu4J3xWxr+nJOdkgjX4gpAa7mS7TaQoD
   g==;
X-IronPort-AV: E=Sophos;i="5.99,243,1677513600"; 
   d="scan'208";a="334119926"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 14:13:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFVtU3u1KeOX5uLPhnZ0+PPrpjhLm46wNwrl4r3ENN1iGsjSYbOGQ0CFBhnm+0p8M2qppB9HRP5+NvfMil2TqChC3r9CuvvPe4KcdfW75bf0tHoWfmqi0bR5E8xkslYCQl4cLq0o89PX2oP5453alNN78c9yf/kwOQNC3kOqcNbQP1QqSiIA4sNQTdup3o6rHgyOoKSdttTnW6igZ+l/MQOaB9q7V/7ZzoDNBBbQBhwLRQOI01xWy05z0eUdRB09qwlpvZ35xxg8OHKTbKhR9zPlg9TVc/uwmjswswxU7EOq7pB4mBLezsOBL9Sn8ATh6yjXGpQWd5XZdYXtT1ajGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4cHl/WsCvUe+71Itvfib7vfevE8zlD9Fle0fbg+1uI=;
 b=dxQV3ohS+BXMK80Q7gRFbnS23CnIpyQYRZ+HpUOokwYL2C75cmGGKtszKTMF+mprA1f2W5d0fKNzncGyIUr+YcKflA6U1dzxWja9OO2dr89lvR3SwN8FYJPAtg2Vru/COvxhDN7DJmCwy1ZBKHeeH2DhGkDGYsFeu2093BP8jkWVu935Q8KhaqKzoOiMTyzJuZjOhbzJQrHPWb2npPHFeAblr1N7TtIsndWJFO2UzRA/wSnUKDMJ1OfpMo3AIPZFpaNVKFjTw6g6POzBsNYJOTs4VVZyjUupkAkjdb/3cOdEWEWWezj8SwCTn8oxnxC9BCR5d8CoCRxC9Oa5V3iaNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4cHl/WsCvUe+71Itvfib7vfevE8zlD9Fle0fbg+1uI=;
 b=fUVBuhTQQ6+vu4iF1jn5wr/csmY+mr6tesFyssh5CVJFNCGibKLfaIXkvD4O4XY08qxs6spIZ4E5LETEGs78hSCdZuWmqO4ciBqSyrWWu8BbJph+lhM2eSc0N+qT08mBpzrbhspwtzCmVxCVMe1aHR3qCJoBZDiiF2/fgdlp0f0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MW6PR04MB8870.namprd04.prod.outlook.com (2603:10b6:303:243::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.30; Tue, 2 May 2023 06:13:22 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6340.030; Tue, 2 May 2023
 06:13:22 +0000
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
Thread-Index: AQHZe09FVEwtRfzey0GWUGL193fJOq9FdtgAgAEM6wA=
Date:   Tue, 2 May 2023 06:13:22 +0000
Message-ID: <73gciykkvntmmmbsbz6yjec66ujhasmzj33zp2sv4qzezmfzyr@3xsdsqatdrv2>
References: <20230419084757.24846-1-dwagner@suse.de>
 <20230419084757.24846-3-dwagner@suse.de>
 <3ec250a9-54c7-3e0d-2463-f8faf15cdb58@grimberg.me>
 <3euieyvxpsww5p4m457pzupfipbnbv3atxauh2lrp54gqmqcco@hs7ytoop5osf>
 <1b060988-fc63-4a86-33b8-88ba61c9358f@grimberg.me>
 <gqeyqpv2idkkkf7jajdxbgj4fi5tnlbt7tmuudwxq3gul3w56y@ijwb4axr52dl>
 <eb9fec81-0ba6-ce3d-dadd-934250001126@grimberg.me>
In-Reply-To: <eb9fec81-0ba6-ce3d-dadd-934250001126@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MW6PR04MB8870:EE_
x-ms-office365-filtering-correlation-id: dd3b4a78-8d7a-443b-06c9-08db4ad454f9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EUQOdol9aneRxbI6/9kkTxFevPqfNEE2YpRedD74UogaGgE5hKsqQ08yGFT8lE6CKqJaAuiP70B73lwsaEcKSz93e+XcYu8sZREUdkTtWTnuDypK9IyrqitAKUbJBlbvGbuzok34n3CaaxFQBaMBjTMXIV7OAztdY8Br15R0SPtYqHkaaNwpwefYRruR5yjtC6lyrmg1KmyfpqiKJfIvithvI0VB4JqAoFuoDyO1okBjB1oCImDUTqqxTD/xn7F8p2WryS9tMdireZn67GHbTpBOA8jKCgOUNrB4iEYGG6SP9d4PSBqewyzLOJ+La6/+t+HPzO/FkFwD2a5JKG9d7xzQKlYEhopsEWMLIWVYKlBeP/CT2p1kaC377LlfSIriGLFWN+AyNSTvt3QkiFfPUZ3oGqRuxaQij8IFyAFYS7iUYL24YBq5As9Jpka8e3s3v7l9kN4ffHGRctStHd06cJZcSBOzYa7QOeAHZeixb07DW1SeboMnLHuwKWn9+IwWDaKiKu1V6l8/jCgR0lUp/qtFM3kN4OPOcv7FcLeaBZXEJD1D/wFiGJsg5tBkMu4bA9Zj0AK+x7bAiHet0dTeypIM397DhA6GXKN/qv49AWF0y9foZDF7N1qo2tN7/P3f
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(451199021)(86362001)(82960400001)(38100700002)(122000001)(38070700005)(8676002)(66946007)(5660300002)(66476007)(41300700001)(4326008)(76116006)(8936002)(64756008)(91956017)(44832011)(66446008)(6916009)(66556008)(316002)(2906002)(6486002)(71200400001)(54906003)(478600001)(186003)(6506007)(9686003)(6512007)(53546011)(83380400001)(26005)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zxf7/m4KRhrdWx3h7hQyXssi4Vq+6vE4cC2NUmOlukpzvfEs/+vuBccBGzSx?=
 =?us-ascii?Q?Qssb2LF/qlIrm8iLNEASICQCpTPX8YTKjtnjCe2cdpOoGtL+8eIiQXhFzAKt?=
 =?us-ascii?Q?k6MpOrGXCLLZi46Phb+hjTL5p5GblXc9qLKxrqqx43n9LUW9Z4tndqqEpOmG?=
 =?us-ascii?Q?1abuHvjmACkcj8xz4iGVDhk3smdY/x8T4LBiHEJaWHJxo+uIpgKzRvvOn91B?=
 =?us-ascii?Q?BvFur+oQNIvuvFWSTaAf9k6UDn7By5R2oEL0pRJZkTQrp8sP+FuoGYFM5pV5?=
 =?us-ascii?Q?6rvYTT+MdaepDywiwIkuCqSWm7YK+mcK+Tf9JYa2xTgEBiBHkvXnwDrF/Bgc?=
 =?us-ascii?Q?zarot8i5FMmROPL1Z9/DyRUaPZiC3sn6T2hRwaRmNTbQmsZ+wmXSuhcLBZfK?=
 =?us-ascii?Q?DCUYtF2/jEy1WEB4NB7Hm/B6NHZzpdCm/jVj4VFA7CcH42Uv/+LQnhmEsXsj?=
 =?us-ascii?Q?IExQLT5q1c8AL+gMzlL+i4xMhcsgGCzEUzGUz0FOeViy9yShEUjGvdCBXld9?=
 =?us-ascii?Q?66y+2wvqgBZr++6uasDn5TvQ6Y5Wq1ldcyNZOr5muutsKF97dIoDqTQ+nGpT?=
 =?us-ascii?Q?r5641fBQpZUGPw5yUbbHvW9l3K7MJ5fuCNSkjkOULgok5B+oPRkUJiroDlg4?=
 =?us-ascii?Q?hsoKtOWzbwVPiVqACOxEbCazmy3CEK8nuEeKKTKvKRcPAmCURvbWNnuvFXz1?=
 =?us-ascii?Q?aaU1lTG3KnbqXhdp2LsRtFRPxfznswXuTgbP3zdfOTBw0pAuKNL+ZJxw1odX?=
 =?us-ascii?Q?JjjvRig6fBjGCGmqdHBBL4qQDHKFiu65sFv7ea4BnxOsNRHO/qsaZxNubTKK?=
 =?us-ascii?Q?/lYCcaZ5XzxshNaTivj6lnGlnbj9/De11hrtceMrLasbAp6aZ9RkypttvU3b?=
 =?us-ascii?Q?tbnd20ADfrW1qZaapXel9d6M02+97VP/NVqMZJcdi/Kp3nXhXXfuS13ZcNgf?=
 =?us-ascii?Q?KdrBCbud2WwdCOJgA5NmAAw8Pi1K95vDz8IoyuEtjINsz4FYpOwfbq2+GImH?=
 =?us-ascii?Q?nji6qsGdUSX6lVcJ2VkYP++Icrs+rfXwVWLf3QK61XsvJo1Fee35aJ1rQmk4?=
 =?us-ascii?Q?3VqQnT9XI1X+UoSLZclCjd9QZE6VfBdFHBidi8bI8WH2InM7mwYOPkXggaVf?=
 =?us-ascii?Q?TMnWHZ/SBn+qYoC/X9njW9384/KJtvxiGx9NVePXQm6FOQKB6i51gZNNEuPX?=
 =?us-ascii?Q?o+qYbMC2xKs+lieqqDk3+cTVCdcEWtgtUyhWFUTQ5xR9P3Zqvcv5Xc6BQrlz?=
 =?us-ascii?Q?2fYleXs8ZVgc8fQcoE17s5pFRfA4YZaQcU5hVru8uMQ/MZBOkNBH2Mk/5wvR?=
 =?us-ascii?Q?i+iDjfT2fcsXzwO7IIf3vQeMbWkuIVY7ELCrz+HHTSqDA+GYq0hv1K8t76V5?=
 =?us-ascii?Q?84eMb5Q1gDkLyIeRgjWcVpuy2jJPzciK1tVN9kwJJqVjTZY1JXLC5LOa9XxJ?=
 =?us-ascii?Q?Cw/KeQ9En9x1jvtGDJRPKT1qDMJ7aBoq5TI0VV5ojo76022MZcyhLt1g/AMi?=
 =?us-ascii?Q?OcmQieAcO1zvF+43IVDRziJDD/P/vbneCCmSesApsGKmCgAB3jdE8b8z10HS?=
 =?us-ascii?Q?MkO50aqebZEIxvw+wVGKv1l86/hBIU4fiNZ1iE+orcMnYZU8rnwo85YkLuV6?=
 =?us-ascii?Q?9MdmjU4iG4WjVM75b7kGKDE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <970821485EE7614992CBDFE95DA1335D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Nxjeks+IUhi17MQNLGKmkaoz2KEeZU4ngDPN+u+VlYMzNmL8atm/3NiJZQc4?=
 =?us-ascii?Q?AhI4lryTVlY1B8BWtaz+lw4VYmhz2watF2X7uh8cNtYbEdbzdqXvyCOktniM?=
 =?us-ascii?Q?OqFMPIM+U9uNHYzqjWmkJUwe9aZ8mnCKRkgmJWmbWF62Kb/Z3cJf2x0X/1fm?=
 =?us-ascii?Q?GdJNIKJXgz1sJOhnJNFSnEtEz0Ffz+o/yH6pHaAtEkUASNdn0R79DE1BGE+s?=
 =?us-ascii?Q?rYS0eM7KA88qQ25GposNs8fkTJs963GFOy4kuUjw9iSk/Dth3VpEVosaSW+8?=
 =?us-ascii?Q?WgkH9GGfM6mn4EwhUzPLxOL2c0WXEGnxX1+quiUOAsspDaHOJIYscZCa83sF?=
 =?us-ascii?Q?hUC0mTvs5gD66+XQXmBRZixQIICXHVTU2JByfGzaQPvGyNiJUaHCryRRQ/VX?=
 =?us-ascii?Q?2cED69I7s5pAx1QobC+G1lyX/LfV8/LzhwZl+kmvzI2gu033Zw3+GzG687We?=
 =?us-ascii?Q?SSM4UBg4rKdd+vib8SFa5/FB7h+IiGQ0qaG1pEqf52s1OV/69+nzLbIIPnMR?=
 =?us-ascii?Q?QFS8BqT2sdg0a9+DaZOpcyQDDgUPglZFX44BmHHnbswitP8wF9wGBNieBHo2?=
 =?us-ascii?Q?EVUQoKilvXuzTi084M4XdFB5QHHPs2t2M+TDxWWaai9MF60VnRRnk9GSKeGt?=
 =?us-ascii?Q?vQ9cZ5ujYH1VPGwaj1B+WlMHouruuT3VVBUp+xkjpwkHHYocZDBmVfegJNv+?=
 =?us-ascii?Q?2cEKBbnIVaDxrJkiPMlPPdCUf3sSdaeTyTtW94E+GVOAHnloVbvwZuLfo8Td?=
 =?us-ascii?Q?n8vO6NRuoMqDrT2UCSj51wN6h8TsiZeaO7yKbjBmc1xwDOBwFo8L/cx5Ma31?=
 =?us-ascii?Q?QJ1HhgkgTf69Q1pzrAimnLcCFy9X8igonYg4MW9K8ej4dPnQZdAFffE+VnZK?=
 =?us-ascii?Q?KPx9XU0AhiXrAV67tuN62BXIVqOjVDxyl1QHnG0dIZ1BglRjctlhI1vTlr3M?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3b4a78-8d7a-443b-06c9-08db4ad454f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 06:13:22.1768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dMs0vyGtHVC5o74uAQU2AE1e5gw7uuGvawezzsr/eMhJMaLij10zlYFsVerhz+XJ9TwBZzHlsuX2KWfsK2IyYQ78OqP90nttCHzSnzIZwcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB8870
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 01, 2023 / 17:10, Sagi Grimberg wrote:
> On 4/30/23 13:34, Shinichiro Kawasaki wrote:
[...]
> > Sagi, this comment above was not clear for me. Is Daniel's patch ok for=
 you?
> >=20
> > IMO, it is reasonable to "do clean-up in reverse order as setup" as a g=
eneral
> > guide. It will reduce the chance to see module related failures when th=
e test
> > cases do not expect such failures. Instead, we can have dedicated test =
cases for
> > the module load/unload order related failures. start_soft_rdma and
> > stop_soft_rdma do module load and unload. So I think the guide is good =
for those
> > helper functions also.
>=20
> As I mentioned here, this change exercises a code path in the driver
> that is a surprise unplug of the rdma device. It is equivalent to
> triggering a surprise removal of the pci device normally during
> nvme-pci test teardown. While this is worth testing, I'm not sure we
> want the default behavior to do that, but rather add dedicated tests for
> it.
>=20
> Hence, my suggestion was to leave nvme-rdma as is.

Thanks for the clarification. I assume that stop_soft_rdma is the "surprise
unplug of the rdma device". If I understand it correctly, the change for nv=
me-fc
will be like this:


diff --git a/tests/nvme/rc b/tests/nvme/rc
index ec0cc2d..24803af 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -260,6 +260,11 @@ _cleanup_nvmet() {
 	shopt -u nullglob
 	trap SIGINT
=20
+	if [[ "${nvme_trtype}" =3D=3D "fc" ]]; then
+		_cleanup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
+				"${def_remote_wwnn}" "${def_remote_wwpn}"
+		modprobe -rq nvme-fcloop
+	fi
 	modprobe -rq nvme-"${nvme_trtype}" 2>/dev/null
 	if [[ "${nvme_trtype}" !=3D "loop" ]]; then
 		modprobe -rq nvmet-"${nvme_trtype}" 2>/dev/null
@@ -268,10 +273,6 @@ _cleanup_nvmet() {
 	if [[ "${nvme_trtype}" =3D=3D "rdma" ]]; then
 		stop_soft_rdma
 	fi
-	if [[ "${nvme_trtype}" =3D=3D "fc" ]]; then
-		_cleanup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
-			        "${def_remote_wwnn}" "${def_remote_wwpn}"
-	fi
 }
=20
 _setup_nvmet() {=
