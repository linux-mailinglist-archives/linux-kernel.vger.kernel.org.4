Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74EA6F6879
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjEDJka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjEDJk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:40:27 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B3D5247
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 02:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683193200; x=1714729200;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0zPHZfGe41uBz/sWfe+fK0hOx8IcIZ7Q662CIOWXatE=;
  b=EJ+bIpCVt4zVFukr+4AJzjEK0fVXkirGX3Odhpe9qcJMjFB28xT0pw87
   AGk8CCML6SNyJWehrTUbc6wDgXYhQF7ksC3sK/RyhFyPTLw7A9xQrwROC
   GFo1HKZ4waWvVPA4MmwOHwuVzap2SZ6DSKf0VhdpBdhtVdbwdxQ6MrqtL
   a5J/A4u64usbDJJ89Y1bw+yfXuiamtrj1KOfVougMqN1GdJq5fiMbSmH6
   m321o0ijwwcccCl/gh58V9upzUhDJscZ+ajR17g48PNzB5T7L7Ie0O5mj
   2qRI3dnh/GxmHgMcu+Mn72SsGFv+EUIKK2Z4QNYEOhe8TYBx+nlRoS+25
   w==;
X-IronPort-AV: E=Sophos;i="5.99,249,1677513600"; 
   d="scan'208";a="234839960"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2023 17:39:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKDAaY8QKcbsjTkeIRqoPam+G8iL5vTcw9Bp7hkoNKlKQcVFpP6oNSC2FNI4fvk38soI4HdRHZdhzM96P/VwYM/9k15AvW5Fdy0Vvj2IB4EfL3LJWjdd2HoZzlxcvyCdeL4OdyzhNvikIGTbIfPvOHCbd8W906+BvGAPy3OaMRiRPzIcaaoolZ47HuvY1y6Mzr/799gvvZXqaIRZn6/grBGLp7ow0p5bMTW1BnHfGmmzxibOmNKpNQpTUtYKjs2RVU1QZ72tLTfGG0IF3++IeYkbrx1NClcAO+KEoIDS8p0JzQdDUr3oysHp1bWFZwN6SOEPvuyzBUZ+5EI5sYPINg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zPHZfGe41uBz/sWfe+fK0hOx8IcIZ7Q662CIOWXatE=;
 b=RoDtXvehfsJCnfbMqQiEKvbncNZqgRBwMUSzpyuunOlWUCIxTKodo6KUBXNwaCC5k1upzYRaU+FumekNIjpnQhd7eiHI7k/oW1Nlj9KxrKIb9tWqGYPDH3uHvNBVTMB0T/YFJowmaA8M9zHUEccbWjFLgEpXpJ8HsGlO1qCTxJGPFXmJZ8YpU2hkqBqKTQsMzRcexv3h3zpAsw2sNcS4LlQN+3Gp6Qo2+vvUh2UtbWJtDB1384iOQdlPzQAkzXXZFJJh5YPur3Nv8cij+VMaFAJH+TrUMlczvjFSgOeX47CBI/2D7+1KQOpilUBZxVmcYsr5sImqrCUGYgLEApetLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zPHZfGe41uBz/sWfe+fK0hOx8IcIZ7Q662CIOWXatE=;
 b=Z9XDZHOnHuDAgyBoyORGREJtHsnS6HOIGhqVjsBCXZ4AnTVR0QeEAcxCEpS3p2mUuFzhvheFT36Big6w0TnvlHj5tTrRphMD/rPYDShIqir+gSxzl/LafZKUMBZVaZLan+pY7nB8oGSpvux+XvtvgekBVWm0r6sro/lGmHNoUhc=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SJ0PR04MB8341.namprd04.prod.outlook.com (2603:10b6:a03:3d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.26; Thu, 4 May
 2023 09:39:54 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fd:6db1:5165:2ade]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fd:6db1:5165:2ade%7]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 09:39:54 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     "jiweisun126@126.com" <jiweisun126@126.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "ahuang12@lenovo.com" <ahuang12@lenovo.com>,
        "sunjw10@lenovo.com" <sunjw10@lenovo.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] nvme: add cond_resched() to nvme_complete_batch()
Thread-Topic: [PATCH] nvme: add cond_resched() to nvme_complete_batch()
Thread-Index: AQHZfmxhAnBWBykOJUOdfcgNJU7LAQ==
Date:   Thu, 4 May 2023 09:39:54 +0000
Message-ID: <ZFN9aWYCxJW/HdHi@x1-carbon>
References: <20230502125412.65633-1-jiweisun126@126.com>
 <ZFKLxfet7qUIwScd@kbusch-mbp.dhcp.thefacebook.com>
 <ZFLxXjiQUPl+tV8L@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZFLxXjiQUPl+tV8L@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SJ0PR04MB8341:EE_
x-ms-office365-filtering-correlation-id: a7ffddd8-4827-42ee-0fae-08db4c838439
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LXHY0Nk1euacplpwaunkhPzr+HVdEF+FG4xQp9ICc2tAEqNOogDhszuBox4JknXpaDzsy3C7diRBsfEDO0vzmtXMs39JmnfwTEumuVL0RtzMO75cS3FMNo/pAIoctboBbMMR6QDekzKo1I9INZ9DNXL875ZppMMUo+XGtWzIzsqo3rX4SeYIK20cmvT6CzvsByWHhhCKdVS9xio9FnzT+ur82e1bcX1J7xBFGySmrN5/z3SvRMQedkifczTD1uEwNIZaBWZDwS8wUO1chrVXEAjK4K1tS3dEHAnI2eURn8AhgcXVGE8HiXt76Hp41sAgOCmiL0BG+lIabg3xTnU0oKGbPwqDT2CF2WajRpFYqVVBffwn284GErjjwH0xFc6Ggu3ZMaV0k5fI3d9HqsBI/ag6LV5fU9uyhOvi32iTkK82wlbuJb+0BjbOtmLv7ekGSVqn93sRa5TxnP4xNgzevoJfqPfSbzGV5tORyrOOvlwwT51/MuCuRQweKF+9j+KBuIbhn5R8VyLoCcdCkoW8v5g/MRjG9015q2/596lq7W3iDYhm3cftdDGONyHHlXmqW1NRY4dk1dblKUl+QXMxY1wU5P+0blCfdUjA5SgYTAr3HrO6WH/5ZFzSHm4G05A7E2jtAA5EVlI0OZLc07bJ+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(376002)(366004)(39860400002)(346002)(396003)(451199021)(86362001)(38100700002)(38070700005)(122000001)(82960400001)(76116006)(316002)(4326008)(64756008)(66946007)(66476007)(66556008)(8936002)(41300700001)(66446008)(2906002)(6916009)(91956017)(7416002)(8676002)(26005)(186003)(6506007)(478600001)(6486002)(71200400001)(54906003)(966005)(9686003)(6512007)(83380400001)(5660300002)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c18KKt8wyYmkJtyymhgvXJSqXrvpO3G4BAEwbH478JBi5gzpoezz8Z/UkX5D?=
 =?us-ascii?Q?uOub3VFDpJA/4mm88/kLlhGKkL2O/76UpvH74lPzi7UEmUt7oIh4Og2OIxUm?=
 =?us-ascii?Q?N/a9ItV57qLRipoaN29LI5KhQYXrMmkDWx3gSvcngiVctd6+o6xF7TJlALtv?=
 =?us-ascii?Q?e3b+Q3L8PVlD0CP4IUD4U97rwSGJApSFsSggaKSp8ZOGyq98zhJwkR9ZZUHn?=
 =?us-ascii?Q?SZke2FPea2ZsW1wd1JMDYc+3s7wZofhYakd+9g7LUgD4iZKocF0dXZ6MP3FC?=
 =?us-ascii?Q?MjwLkwzm96CY/U7JW7QiMHrudWFVsHQeHTIdkG1y7m9QffvHR1LVgsMCQ3jm?=
 =?us-ascii?Q?bS+xnNDPQ+b+6/O0ifZkJHN2Sfnj8ANDSOX8IPF29BZLIiOpDj5JGEfGzP0/?=
 =?us-ascii?Q?Ogea6nQ67KAGlbqNAqgxVV+CalRrbMbCCIitpqmPE/NOU+lfQgg++cQt9/vs?=
 =?us-ascii?Q?Nnh/sxLqHLYQiBjvz8Xg5UYkmJBtzDEe2TDlHtz33iQiQ7zalBEaegX/MKMd?=
 =?us-ascii?Q?yitJHwWDQlnG/adt6dFFiGgMrzoIA5KOpFyzuE9MOLEKcnu15E+ULaGrlp9S?=
 =?us-ascii?Q?GiiCzZPoNIFtehfnNStSY2wkuRHQvGEf6xBgqBPp+p90JWdrFZI4k/jHngKQ?=
 =?us-ascii?Q?aQaSh1VX06bWHf/DoX72WRvk+9nJmY3xPqNSAHnwmyfjkUEYBaIzWlL0Ra/H?=
 =?us-ascii?Q?eIIG4IduAkjrQzyRvxSdRxA2cw7/8senxZLmsc/8AV18Hv3b1XGE17kPDeXr?=
 =?us-ascii?Q?BpE1H0byP1CaRfLK/ieNjtSPnsSc7enNLD+4rIv8APs5hemsGl+zZAZT9rQB?=
 =?us-ascii?Q?6dlG0WjVZxMGN3+lk/nNMgSzEkCW6+hNXTKWgywu/YkQ1iJhT80SknoAynnn?=
 =?us-ascii?Q?v0fQyBD0+q+aPD3Sdd2WsECkfsVhj1RFVsbUQ6pSPCMEJZuu26qQKUwA4mZZ?=
 =?us-ascii?Q?GORaIKk96ApTAOP3YZLrFNBF5lnoFI3iCDYMhwz509GsbMGoxlrAC1A7lxCG?=
 =?us-ascii?Q?7tTWRS1AoMLoeon2i88jDuBCH5NgjOV2oW+vQrSnZVO938mWD8uCEGEzd1Rg?=
 =?us-ascii?Q?RNBdoxct9jN5LUATwvpz00UY8b/PIXEFtPH1lV9Wylyps5ffVJbBa+yl1FpE?=
 =?us-ascii?Q?4TE/qvlSmr+SzO1cHRnTI7Ay4IHrXrUdzvY9FK6mWKFl3bhrd0LPMif5ItVJ?=
 =?us-ascii?Q?hlqRkSfHoiRRsEM/9UpAR8zQuBoaJwRxRzvMIWgfHR5dv8q+fN3k+aHJTs3B?=
 =?us-ascii?Q?mEwHqdJcaLSzW9ORu8m5snYWSu9EnE9rJWn7eCouuBBRhE00OAFdNtuRvtFS?=
 =?us-ascii?Q?71J1ewkwxyLnDE/c173IvD5uQJHszH1Q1PAjWHDjEdAeN1jDFlJYDhPE0BB5?=
 =?us-ascii?Q?yMrBJU3iuzRiNxpCeTCMHikZisgaQiwnaHwSyaR24xXRc5lmXUvYGG1AmJS7?=
 =?us-ascii?Q?AMXPGmtc2Kbd4PwCGzm0afk5b+1CD1Y5lZ9y4s1nLp2FoK7Tc+eMYamOUCd0?=
 =?us-ascii?Q?Oah2WDwe3JsTG/e8U70nSL7slSzmW0m8brkavgDsmk66lBZz0nGU9xV+ZZYE?=
 =?us-ascii?Q?AOpplrExvE0RqTd/xigg2wqm7xdSOGZr/Fb8VvUwXmTQkREsejFzpDUwJtBj?=
 =?us-ascii?Q?WQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4F00156802A7CC4FA5751F011E4FC3F2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?asx3SaRVE19ObEfq2dtwBzLOx0cizkLsR3H37kXkpfvRs8WM/mWZyR4a8N7/?=
 =?us-ascii?Q?/FHo+6KxAxCDggUKzNG1/sHoZ4YFvxeB8BPsdo2+neszsMLfX1Ju+PSjQJi0?=
 =?us-ascii?Q?9zUNWxSACGtU8ahCti/O8wovid45bl4xnV1z4aujd4A1m1/y66Cwbpd5dLNA?=
 =?us-ascii?Q?l1jOcbkRU/SvBcAlb4jka43vyw1jvEU0conx371eUkdDuUOXMd6kwhwM1AQj?=
 =?us-ascii?Q?7JLFK4XFLsFUrmRDTAWd5bOz5znHLdMdajmFb+RvOAyjnWeI+a25mMPaLYrK?=
 =?us-ascii?Q?u5XbDc+d0rh7h0HXWvXGlLySkBPJk3OZG1WK3B+SdLueKN4k5RWRnDMX37nY?=
 =?us-ascii?Q?jOccd5Sg2GvMIlL5PyblxtI4oo3cDJRG1ArZiozqN3iuIB06WcjTX4UUvqel?=
 =?us-ascii?Q?oO4Uxi04pg3Y7oRBe9xhevMPkYi+VoS9n1Qe5YOMps0bpK34uzSxmX5MLKNZ?=
 =?us-ascii?Q?TRXmXay5dlSJbhIqBCZ4j/pDr/894EfgTsozeJdCPZnbswCYJbeKTKR1FEjs?=
 =?us-ascii?Q?PPgEik5Y7Tq1EAy3cL69oTacjol2w1K8wnNvY6JLv6cfn3K1DS2v84/hH0ww?=
 =?us-ascii?Q?vjvzDX2TTB0G9hNM5lqvCg72UgpPVOctQna4sGFE/PfgmOwTuvpQVGAKQeRu?=
 =?us-ascii?Q?iC+z5+tlzMXGNnA50+C3kiG0vPFkSqclTHGcik/R2Vuotlx8kboJthA2Jg0t?=
 =?us-ascii?Q?MQ/1nPDYG+MtaW70r+1cD1boDJEMbdF4CXYB3kCphW6wjr2s2LU91Jnl/PqG?=
 =?us-ascii?Q?imM2/x7cNjC/BBd6VGJXd2ggxbiN5R/rUn4Ju+j4AmiihhJ2ZuGKeWhVlyw5?=
 =?us-ascii?Q?hH1jPWFlj5MkpmCdmhtuMEwQOw098D11dYRPId93u/qHa/8nazwDLyTkO4B5?=
 =?us-ascii?Q?lxo2M+TLsW8o+aytMvGKex1Dnz/7jI2Ld16ieyZKiuLbZ2VPzgAgzohS6tkC?=
 =?us-ascii?Q?xf+qF9PmvBSCEhPolfNcjmJGVHUjtmA5YXl9YTJHAbsPVq3Xv5J3mFTxFu7A?=
 =?us-ascii?Q?KLmBYw1fKgtSH0HC/mhr2dtekb+CyPYbF8e5v7Jgts1YoKg=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ffddd8-4827-42ee-0fae-08db4c838439
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 09:39:54.5626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Dp45YJenZKjH8WHAFX0WSz1jMsTSgABSRo6OjfbxYU17XbJ2d5vQF/uLGlOin+6HX/gnUJgN8TFsjqhVU/xXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8341
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 05:42:22PM -0600, Keith Busch wrote:
> On Wed, May 03, 2023 at 10:28:53AM -0600, Keith Busch wrote:
> > On Tue, May 02, 2023 at 08:54:12PM +0800, jiweisun126@126.com wrote:
> > > According to the above two logs, we can know the nvme_irq() cost too =
much
> > > time, in the above case, about 4.8 second. And we can also know that =
the
> > > main bottlenecks is in the competition for the spin lock pool->lock.
> >=20
> > I have a fix that makes pool->lock critical section much shorter and co=
nstant
> > time. It was staged in mm tree for months, but mysteriously it's missin=
g...
>=20
> Well this is certainly odd: the commit I'm referring to is in Linus' log,=
 but
> the file it modified is not updated. What kind of 'git' madness is this??
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Da4de12a032fa6d0670aa0bb43a2bf9f812680d0f
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/mm=
/dmapool.c
>=20

Hmm, this is very interesting indeed.

It looks like:
a4de12a032fa ("dmapool: link blocks across pages") matches
https://patchwork.kernel.org/project/linux-mm/patch/20230126215125.4069751-=
12-kbusch@meta.com/
so everything good.

However, the following commit:
2d55c16c0c54 ("dmapool: create/destroy cleanup")
does not match what was on the list:
https://patchwork.kernel.org/project/linux-mm/patch/20230126215125.4069751-=
13-kbusch@meta.com/



It kind of looks like
2d55c16c0c54 ("dmapool: create/destroy cleanup") is actually
a revert of a4de12a032fa ("dmapool: link blocks across pages"),
plus some additional changes. Scary.



Additionally, it seems like the fix:
https://patchwork.kernel.org/project/linux-mm/patch/20230221165400.1595247-=
1-kbusch@meta.com/
was never merged.


Something is fishy here...

(Perhaps the maintainer did a git revert instead of applying the fix...
and accidentally squashed the revert with a proper commit...
But even that does not make sense, as there simply seems to be too many
lines changed in 2d55c16c0c54 ("dmapool: create/destroy cleanup") for that
to be the case...)


Kind regards,
Niklas=
