Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FB2722501
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjFEL5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjFEL4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:56:54 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749E71A5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685966203; x=1717502203;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0jgrboM1eIsHIx/jLvf1E7gDR03ifYA0Wdt8PUV77zo=;
  b=BqM8+Fg7qvvl5fXckIN/JU67s0qMoGzRw7nrrgIN3DuRO4oXAx991/2x
   OxC0Ma312oOatBplt2Nm8V1U9A4C5iQ/yFEtjMnVbSJBPRL4AYuUZg5S9
   ykXx1NQRptasKuZFOkJCXj2afjO00tKJu158CEBiMOKEtGYwfvB/KnAZ8
   1XTyaia01r36iddXFkwZFHLJMt/cEik7hH2+utnJyK9/7UB/1vdhl5bn/
   obgWFAzzGdG98Wci8L2KWq/2slayac6gpWJLkB0V+dqvy9fdIyKoYPU2O
   G9IJcye1fdjZ8Qxvp5NwRPdUh+YYwpXBKAQlW+c00TyVik700HF1AItNr
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,217,1681142400"; 
   d="scan'208";a="237455777"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2023 19:56:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfNwICBE+OH6a42tyQTmQXt7PAk64bayFotfRjkF7TOeZATk4kobeb0Nmvy7RiwzPDa9+3MtWqGr8HljnDTrdsx2J1gI9wW/iYywQS1Kh256MiCoNM+Lj4843/ngnfEKMSKP+YvCDf4nGj6V77Qp3mbLSWmRwA7ZQp21ZrMNxA2uWnlA0Jj0N4tFVoZRJpsN/892LTR7dWY3+RimZxWG0f2x4mU4eoxIRK4B1HBVN3jEY6Tk/XrIWGDNA5dRmWISeZhKc6UBO5jUGeAN46FhtP45TMebM+BPkKVIE3bm2BuscmwDVOjLuzHhui5hWNVdOypySbesQXGnJSlhpFAVMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMKr4I7x1OYAI2My8zrdlF/hz9E3OkTZsmwjQAZsH4s=;
 b=G5Khw0uaRipVH5mUXlmhS0DQNiuDk02A/I/bA6ihlshF4v5vuqdv6GMrKK6hOXshBCulx4pAW+LyqydClVEI4yO9uN48gxcVCFJlG9a5aKl1vyxFdy9bWitpEr3+FQaQtT8BnbkFFHpf5ZLEcToboZewOPjpgNzD8Zvfgk1yL/eMgTKVExaBqz+m9qrkMsf7rj6pM1YZeiIb+P0hBVW/0Tg3EQT0Sr67Lx3tY7lAIJ2Eps9BJ09KZskfA3puD45BBudXXfB3L5laVpsUc1xj/uNcXC4hUPuvtsReEMANpwWY/MPLO1Fe0AsZD7TR2NIr7xOuvH1EQsDlIjLRZ9z+Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMKr4I7x1OYAI2My8zrdlF/hz9E3OkTZsmwjQAZsH4s=;
 b=lT61pHKk2WQxeXgFSqmkINrkbGbnzYPm9qFpkh2XF+M7q6WyWEa4IEa2kuxoELbQINfkTV+VQvBsTWSKzVsxtgDEzNrkuxbCVfi5Y9C/rMMZi9CMroqHCBtKWkNxAt/0/LepEo1kwne1PZFT40PhBnp2aK+Ff+h4RsBlN6Yk/v8=
Received: from BYAPR04MB4296.namprd04.prod.outlook.com (2603:10b6:a02:fa::27)
 by CH2PR04MB6571.namprd04.prod.outlook.com (2603:10b6:610:34::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 11:56:39 +0000
Received: from BYAPR04MB4296.namprd04.prod.outlook.com
 ([fe80::dee9:85b6:1ebb:15fb]) by BYAPR04MB4296.namprd04.prod.outlook.com
 ([fe80::dee9:85b6:1ebb:15fb%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 11:56:39 +0000
From:   Hans Holmberg <Hans.Holmberg@wdc.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     "hch@infradead.org" <hch@infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "hans@owltronix.com" <hans@owltronix.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] f2fs: preserve direct write semantics when buffering
 is forced
Thread-Topic: [RFC PATCH] f2fs: preserve direct write semantics when buffering
 is forced
Thread-Index: AQHZRSW5RGgzfxLfmEqd2IrSayym268D2TwAgAVGSICAAA0xAIAADFcAgAAFugCAAAscgIAEpCYAgG7RPQA=
Date:   Mon, 5 Jun 2023 11:56:39 +0000
Message-ID: <20230605115638.GA23662@gsv>
References: <20230220122004.26555-1-hans.holmberg@wdc.com>
 <ZBhisCo7gTitmKeO@infradead.org> <ZBzPYwcoLXkFngz8@google.com>
 <402cc90ce5defa81c937c3fcd09de1f6497459ee.camel@wdc.com>
 <ZBzkzg+lr+TOXZcW@google.com>
 <8207efb81cd1e9322ad608d313eb4b4bd5740e80.camel@wdc.com>
 <ZBzy7RHlCqmApxUe@google.com> <ZCDXnuV7oZwcYvRP@infradead.org>
In-Reply-To: <ZCDXnuV7oZwcYvRP@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR04MB4296:EE_|CH2PR04MB6571:EE_
x-ms-office365-filtering-correlation-id: 5092adcc-c15a-4668-7e3d-08db65bbebca
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B2+HiwmH+i7Z3zweMjQqoIGypkLjHJbX5fEC7kbGsSBlLWBP0grOssjbxkq37pMC9XJ8u1nOZMU/0KhsvXFJPOuQ4JsSYx664/ViSde2nI9kEmZqGXt25vkxCk5Z/zlF/eWjHK1cP5mhChEX8SvXJaftMnj/7eGeim273sIy/tr1EaP/yUUubH8CXA1eoJAPqV+HSC/Zv/JAsc8X62a7dm+F3UwgN3T8uCWXYGdF/Vk+8x9WYhiJ3I7A29z2XdEd+/H2eBF7WT/ThFjeF7u6xjitMlJ5UHw52ToDTVuIq0gntqn7ZIp1KgIdeTcvVgD3m+hedanBGvshGKaB5RjgyjpdEHf+6sY9zc+tQH5Q5pIUXXHu4gmBZ8aon3i/C+8AR6ZD8pkUmTa8dLptthkaB+8V0H9ruVB7GTcHVYXLHSWUUEABl8nm85Iy9iH34QSYQc5fjFeVsauYZ9lnlV4HdT9Vud3WGn4wgVNp2Hq26BhOlVJ872SIj0X2NauQCBrEkDusYiFQyL/3XsNqoSjocwYpdxjPTsLEvfOLBHzFRgjpvxyjfukAQTYxUWqMra7eOGdNu2mRdvRfS+ZzzmLogd1c5kB8aHVD1K7D+/hsdWleKh1jbgIl0sRKg/YwkhbY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4296.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199021)(1076003)(9686003)(6512007)(6506007)(38100700002)(41300700001)(6486002)(186003)(26005)(83380400001)(71200400001)(478600001)(54906003)(4326008)(66446008)(66476007)(66556008)(64756008)(91956017)(122000001)(6916009)(82960400001)(76116006)(316002)(66946007)(8936002)(8676002)(5660300002)(2906002)(33716001)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YdZ0krb1akVgJOkOj+cXhxKdnkTK2OyMMbP9AA3giNSGWzopZbff5Wfn0tz8?=
 =?us-ascii?Q?QiTB9peRyOF4OXFeMRJ3B3/fYJJ2OC0o01JqI8K8Ah7DzElmWyAOxRjeaVxL?=
 =?us-ascii?Q?Gc8FBK9feZzZNzE8/PsVXFIYG0Zr1qDgySVv3UrVrFuXHRa5rYEXeUjxbbP6?=
 =?us-ascii?Q?m19e2sWI4THdlRlMdKhno0spLsMByJ+bMaQTFCtrPGfiZJ4uFqXVgRGEJp7R?=
 =?us-ascii?Q?b7ymgU4Zz1IO3MeqUc4/8zjogw3rGlfzl6seJbCx/wogyb4e8z1C6Kt3Lmxk?=
 =?us-ascii?Q?b7OnWr0Ku2Sn0IN+W4ydrDSHyt2aWI316VjSEPTqoUEVVAJhG88v0iAAoZaS?=
 =?us-ascii?Q?2rIKvBfTn1V5LfPqnXVWwWqsFw9ixClHsIJX0l/1Z6vObovIL5YI6AHwZDO6?=
 =?us-ascii?Q?4F25M44Gi+6Sb6MkE9jFUQV1kYmqMKl81SGbJPgwTlj5p7xGDKw8ygEBpJdA?=
 =?us-ascii?Q?f3vOg8ewEf+jkkctNl3iGPYOA3DshFiA5dhVPvFjEg+K5TlQUKxyoIW3e0NP?=
 =?us-ascii?Q?SN6OHQxIa7oP1utw1Kl6jox/E8C8SzTtz8UpXWkupQs1XPNo6ZxMI4YkN1+v?=
 =?us-ascii?Q?fYwmMtnIa1TaAKBVRrCDaoYzsRKibbbW9VhFYgpORDX2BnfuVm+PiGJJKfgA?=
 =?us-ascii?Q?r4XPzfcNKjqUotK9KC6gHRsMvtLg7a2pwnP/xmHmk+mCx8UaOic1qbXYoyCX?=
 =?us-ascii?Q?0MXcPO7vkU1oa5Ng4/il39uQ/R7Qv6heYO1ZvqHTPz4+Rny2KsguVurl+mZ3?=
 =?us-ascii?Q?JVVBlcsjAkaO9wZ8MEACsYymEpv/PvtAIeAXFD/VZGMs2ZY8mrfS0z8GRvq4?=
 =?us-ascii?Q?Myfs8H+x9n23sTvgyE1AWjyW3fJlC2S53LQctMwz4EXZ7a46cR+UXi6Fj/T3?=
 =?us-ascii?Q?hjItjaluDgQZxnIObDXXycnF4Qymv0/EbpY56FLNCCPxTon9BVcW0+qPN6/n?=
 =?us-ascii?Q?lrir9qpUn/nqTqCBYLoG6ltsR5Daf/Zk7MLpSyv8D4+HowK+/eXInn9un19f?=
 =?us-ascii?Q?7xj9mknNa7jamcZgpL40/LbF3GM0upNI5jQb2T5qn3CuruCoSp4F1B4u/Oah?=
 =?us-ascii?Q?1gE9ApRLJJufE1zViKtrKWUVXKE2OLzqj/kJhYRzpEr2Kvyy9ljYUVkPs/64?=
 =?us-ascii?Q?h1CpxxSgooNwbGlI84uUewcqGyQhzjkGFLv7ocPxBzlkKJY66AZvpDjk26q4?=
 =?us-ascii?Q?HcphIYLjPOJ1byvVj80cXfsazQLzcRoKefC9RijBn/qR+LkqisZrAsdb/1Sm?=
 =?us-ascii?Q?Jzhc394SYE1wsMu3PpihthXqOR3xYCeHcvSL5g+wfa8Tv4o9t7Iv/+ODX8ie?=
 =?us-ascii?Q?AzV0ueDpMOu48HwAvR9HyvnmxCb7qep9JTH9Bn/2jVbrsa6RB+YxXJZzmyyG?=
 =?us-ascii?Q?9nAquHaiW+80kKgPsRVG5AkGqoRKE41m9J2mJ0Ixop1qJXH++3f+4mGQ4w5f?=
 =?us-ascii?Q?ce5ozryG9+niklTg1EPmzxrI1SWzA28kgZKGEKl+q/a4GayXRJ0JB+YL6DME?=
 =?us-ascii?Q?7FEeC7Yfa8/Rgm3ur1nMvNsCe8tyxqFBb44llD1DBPsg8y1K/wW/NlHxtIi3?=
 =?us-ascii?Q?hZDgdUZYsQLPSfRhWABTiBfU1Ch7LTgkt6P3CJKA?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <390DA133B31F3246A5D376EE458F2D77@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?v3D8NY+0jgf5gkRZvdSZI9l74F9CgNw0XMk7rw4LjgjLyMcCDq7+BRWI64DS?=
 =?us-ascii?Q?QVvJrrbp7M0FGnTwgcTa9QbjG/6t3B6UDRyJf9RGvvSFQKi5ofz/SWzkGbsL?=
 =?us-ascii?Q?D2NvXH8eiwBHy/o+OVQmtjYyUSIu2xLbYB8DSHFkO+Pm87uLERX46swjASnv?=
 =?us-ascii?Q?2v4BYCAS2ZgUgUSIw7ZtUEEd4tj6AUZIYNSgl+UjT0kJsfUY6denomdYX4g2?=
 =?us-ascii?Q?2ShJ5MuoXOk3R8cCH+7KsDJpANzW4qF3ZoEaSrQVpg40DlA3WejMVcNUOm4N?=
 =?us-ascii?Q?mBT1D2xVgJ0hExXVsMxT6QJ+nYKIsOeivmT3UIUXI/XVc2v5hI9DPCuIBoIb?=
 =?us-ascii?Q?h/GsRv2N5xNKc6Xd6brHvfIGuwC/yJAXmDwv6Os9wzR1P0UwqOzz+l5yWYc/?=
 =?us-ascii?Q?63J2+doom+DNUqn7+L8AVaveH6EXh4TjD5xA4Tn8RHLztwSA9apZNlx36AQF?=
 =?us-ascii?Q?Qh+rbB7qnpaclMgkzWjLdNAqLSYAYq9m7P6JAEsYeCsCr5sdOsEGMa2dH0RF?=
 =?us-ascii?Q?2zPtsO4A22w2a2010gQbPZp3jZj8xVQBG8OfT0K+gWqZWNrQhgbdH2mYNEzl?=
 =?us-ascii?Q?SAbcUDnYZk7fBNOhep76DLZJNNbzQYtlVBU0iik/4iSCbLIhkS3DlK8xRDWN?=
 =?us-ascii?Q?pzX0swaWrk5afwXCHdPFEgyXBVbNQDpvM4X9SBddoaUuFsS9AD3xYnkOLFsl?=
 =?us-ascii?Q?EZ2JWOr+PXelyJs+Ou/WQS5MGek5udXo+HkG7sV4qoRu0cl7mhZXwNWpLQ5k?=
 =?us-ascii?Q?lIO+pw10ol440/BAix1sdUZdvNN4q5POh62X5Grc2x84Kdw7XYxbUKsL/2Gy?=
 =?us-ascii?Q?QHgW4uPaHT6uCtmFMnHALgYuHBqhH0eIoev0ffzgXg0tMx7a96heGFOJAwDo?=
 =?us-ascii?Q?PsB6ZrHqq+MQSlt7VQrLPyO++HZ3dli9rxXX6y4Fo6rkHeNrGUH6aCmOsdbB?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4296.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5092adcc-c15a-4668-7e3d-08db65bbebca
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 11:56:39.2133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZdxDsa7+3dlkVSbnyFYmccu7Td+rAk2LDFRA4RT2oPKxGPArVxlaq+sf/a0lkVZ546bneSGCONfmRr3aV/Giyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6571
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, Mar 26, 2023 at 04:39:10PM -0700, hch@infradead.org wrote:
> On Thu, Mar 23, 2023 at 05:46:37PM -0700, Jaegeuk Kim wrote:
> > > Yes, and that was exactly my point: with LFS mode, O_DIRECT write
> > > should never overwrite anything. So I do not see why direct writes
> > > should be handled as buffered writes with zoned devices. Am I missing
> > > something here ?
> >=20
> > That's an easiest way to serialize block allocation and submit_bio when=
 users
> > are calling buffered writes and direct writes in parallel. :)
> > I just felt that if we can manage both of them in direct write path alo=
ng with
> > buffered write path, we may be able to avoid memcpy.
>=20
> Yes.  Note that right now f2fs doesn't really support proper O_DIRECT
> for buffered I/O either, as non-overwrites require a feature similar
> to unwritten extents, or a split of the allocation phase and the record
> metdata phase.  If we'd go for the second choice for f2fs, which is the
> more elegant thing to do, you'll get the zoned direct I/O write support
> almost for free.

So, Jaegeuk, do you think suporting direct io proper is the way to do to fi=
x this
issue? That looks like a better solution to me (at least long term).

Until that would be put into place, do you want my fix (with your code
style fixes) rebased and resent?

Cheers,
Hans=
