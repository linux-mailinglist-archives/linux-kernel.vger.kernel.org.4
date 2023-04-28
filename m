Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9A16F10E9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 06:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjD1EBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 00:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjD1EA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 00:00:59 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268382736;
        Thu, 27 Apr 2023 21:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1682654458; x=1714190458;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Wyg0a64o8hBTQy2qWu1NwvXQJg6OyMmzkz2g8V1RInU=;
  b=TH8KhRSoifVvB4wWaPUg9AZn275SvLDkPuYt/rlZ31E3M/sZi6kB/Ctu
   nQxdyuHjntQqnp8QUlPAzfWVq91xne/7UY1RQJmwEC+1bMP6egx44yVpZ
   dQb/qwxD2+3n/WjO0QHMIk+PY3tCn5g2G6bZlKeoA2I18Gy95MUWFr4UI
   sAdqjy1/ErKTLgHYpw5jIXrlhI+3dY4hS/u4XUoYU4W344zqJejccvEEy
   F7sCYQNnzAU6jK+pnsejxJ1UYW0Fpg/erQI0F2vSoE3rAlUST+fPvZI10
   OUSM1gSuUe8y5JHeWqyct2zgiBsT12zAa5Rl5h0AIg76WTBhEKIMyiORT
   w==;
X-IronPort-AV: E=Sophos;i="5.99,233,1677513600"; 
   d="scan'208";a="341513244"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2023 12:00:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqLwHFqm4OyZ+s7s4QFoUg3zoxkHgo74dobI8O2D3XP1ZnlDC0Y+93HJU5I/3aSY7GXLBRgy40s5rWTNVDgBqnTdLxKcnLmM7B86Z/Z6xVTBg3+R9Yt16c42ilVSt9f9ahe1vJlmy9qN1lH0xjgrthllQVWfbhncMwQ1R027qWr1rzp5DqoqBqR/hwEFO5HbXA7rPSEOzyllchszbpjlcHQjwqE7rwUps1yEjcgP7LDGjNXu/qzKkr9MaXLEsfxSf5skqtexdjx081R0feadbTAoUJ/reu24qeXy+X8LjuyY3MAAbPocHyjTgI6sEUCCn8SSmejlOkANR8Fd6i8ohQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wyg0a64o8hBTQy2qWu1NwvXQJg6OyMmzkz2g8V1RInU=;
 b=PJ6u+n0z5CevQlf3id+vsuYHbOkPMUBgqiFyd6veRq1rdd3kinXCrqeXEA7yB5w/j2pVaiHYNQ2GGsiDyZAFQonrD45kyKieG0s/4xethQgYgcJ+7bX2hPL7NwAjLus/UcZmY+ereZLekSTFh5/Wk3Fh8ME6NUv0//8jhQ2xl3rR/cN8VMdxJGgHxZTD7uiQsIobZRiH8gLkAOD12WMIZWuGNNsJ5YAIbE7xIXq++cI3ZEoKermtL3hhS2Iwjp8u0y7DMXMR7kKX5I70EhBjZfsL5b3WMVe9wBeT4cqBB2l0UiCO+RjWSS78dit8NO2699A4jn4xWj7fa7Nn+VSl9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wyg0a64o8hBTQy2qWu1NwvXQJg6OyMmzkz2g8V1RInU=;
 b=E1pDycvJx/oUoC6pocpRwCzF/yMYIvmwuTL79Al4J1rXAkXT256aIPfwCxdQslW2/d6424EhofljvYkc6+F4Ptd2yeTlgFYvLkZKio7bEgAYna+1fw3YmINuortvTNjwvRhGu/AjGExDIqD+cISJ6vi40hzuq8A/mWwu7RbUxng=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB8375.namprd04.prod.outlook.com (2603:10b6:a03:3d6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.21; Fri, 28 Apr 2023 04:00:54 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 04:00:54 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 7/9] nvme-rc: Calculate IO size for fio
 jobs
Thread-Topic: [PATCH REPOST blktests v2 7/9] nvme-rc: Calculate IO size for
 fio jobs
Thread-Index: AQHZeYYHsLKktkO0eEaJ0SLd6XY4VA==
Date:   Fri, 28 Apr 2023 04:00:54 +0000
Message-ID: <sbkboyc3tcad4g5zjdtko6ardhythnaotwp3njchbotnabhlun@mhhvxut6q2av>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-8-dwagner@suse.de>
In-Reply-To: <20230421060505.10132-8-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB8375:EE_
x-ms-office365-filtering-correlation-id: 14d13f80-91cc-4106-a97f-08db479d2a42
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f5qHl4VYq6eJcz34ane7av5Xp5MkgBoiWbU8D3ZCZD1cc9RZtszqsOxLenD1yYPa1LhMxH68IblxnCSF3C6dutx6X2QVBd2wkQ51axZpA/EPSEiOmJIbXtALN5sRcLFxicv5+Bou4vEjYRPH34+aB0aGWVI/Sk3hA9VXPgBxWP84N4dKwLVVXLENK8eIWsHIGL83FD5YIPEMxkA9vVPMIZfWdEv3ovo2FYIoDgxyWC9ga13i6Ez7MDhFRCU8gbaydAz8Rk3juOK64MwOJnanopCYy8VClQBAUuWoMT+xKgtt08RM1XrMO4gi9/dVIu/4+fWBWgIlyqP/EcVGxJRrnv/RyP7hJH+TWkSbER7TPjF8ViU9DIMH3Ec9Bt7nuG2cTXHv4K+nHtuG4HikXJRQzYiwQMAsqQN22DkneZSwt8Eet52pKkmw8qVE9tJMjdyOy2g/x7Qsavh7RkiHtB69v8ysfZi4KTMjwaXJsHje16i+tS6N8QgTHC7pcddh3P92dDWmP1/SFxMp7O/AuDGNCh88ZBgs86igzVrviS6ySTTwrtV06nfg+OHjlTV3eBtmNZ4drhswijTeYxmeIduo0Aje6R1/L5ZoxNdGAu2RQiprXv8D0i6uQ4Quyv3KNYFh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199021)(86362001)(33716001)(54906003)(478600001)(71200400001)(6486002)(66946007)(76116006)(8936002)(38100700002)(8676002)(41300700001)(122000001)(66446008)(66556008)(91956017)(82960400001)(316002)(6916009)(4326008)(186003)(83380400001)(64756008)(66476007)(26005)(9686003)(4744005)(2906002)(6506007)(38070700005)(6512007)(44832011)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eJYHD01yp1it9irOlJRL+6kAjom8wfJgfYNXJd7FgKTVl122wxDKBfEljQLt?=
 =?us-ascii?Q?tBPX3/ajqB+TgHW/nyCrRtgb/WcYt40gkwjFiH1uoOUhAWPcwK/A6iKK03F+?=
 =?us-ascii?Q?+E84u5I5D5jN5xLX2h3EpWSoJFrdE1Ned/81RtGHNj3gYdtSAY2DLipg9j8A?=
 =?us-ascii?Q?MqaGuDnkjximDAngtszwdE1lgalLYDDGgBCXLFW0+feJe6Ha0+qBq4qVufk4?=
 =?us-ascii?Q?RIbCBHYO48Hgy/NS4S1pChLqbjaBT11sACSGpBmq3niwgi395vytn1QBrzce?=
 =?us-ascii?Q?DS2Z+YgJfZfAXOzRsd2mkez3MgpzKL8f/Qbtvj927TlDuj79GyXBId7VjY+C?=
 =?us-ascii?Q?UM+J6ubac1jd14Xr+YcNTejMPm99B4AtZS+A/EXZoFiZTzWrGNU/RQYsd07n?=
 =?us-ascii?Q?HeAy52oWNMZqqdmAHjNM5OGps9TVxz5xRxUsZgDSr+R5q25dRl7n7UduzO6n?=
 =?us-ascii?Q?f2eWb6FBfUj8lBwCFOyIcPd4v8vpsHYmTNFhmOhbdjvT4sR4cYsMtwM9uo7j?=
 =?us-ascii?Q?Sg5S7y7UAartWUZpiEu8/RbHRyFZSn+PeDpzysCOZzf6zOVk1rDIwzMbqjHY?=
 =?us-ascii?Q?BTqX6HKk8sHeZHd3N8tWztkFLUzoJRmOgCsDeAP05CXOogYnhUfiykDnifjF?=
 =?us-ascii?Q?Ih/KLC7jgomacVpki8OhOnesnvZzyxVMnfpIQACqQekVq2z66XyQ9CMlJY++?=
 =?us-ascii?Q?76pN/ogab8Tmh4sW+RXz9Js6CZww/NUwJW8ghxxiBqwKiYgeIfpR/DPFl3On?=
 =?us-ascii?Q?oSi7aCbK7oUjZp+QB0zobSMwSFMZiv2f8/i273T0QL2SiL5fftSomJXj7Jk5?=
 =?us-ascii?Q?lIMihF5tv9skFY5XJl0l9hL4uDSK/mN7PBDpqq0Gec/SRDynbHeVBG8KVPgm?=
 =?us-ascii?Q?zha7/YXRZjcjMqZi6jOU2ZBsmxDPu+Ip9gr9gItYcx8ZYArAlxPMSsQHHzJq?=
 =?us-ascii?Q?kTkDkXbbqQh5RX1J/YJFcDn536YA9CE++ZvAJQJs5aIsUZ27CDUzvja7XaBH?=
 =?us-ascii?Q?AZToMvSD53V+eH/CkcSXZNQapiMk3iTqBk48AJg3cSns0UHdBE5RismFJfZ5?=
 =?us-ascii?Q?7Ech0eG0fQ295mUuPpnqC16oCB+JMWROc3yr3GgvdVB9fkxF1ianT3AK5Nfc?=
 =?us-ascii?Q?aAD2Okv9MMdYEhfg0yjOIrZLQm1rwdTZCXqfg9fdu0vmqWYxwEVy0lI9SIL8?=
 =?us-ascii?Q?6xX6n6rZaqVmtfSJYpWpLaFgbYd+f1tIqxPNMht/6Qu55dsXuW/b2jJufdAK?=
 =?us-ascii?Q?58A9R0x4TYQNpUoE1fZD7Qwyr02rtoQXvlIy4EMjXPvUtIw3duaud/dRV353?=
 =?us-ascii?Q?wSHs4FBItY9ynTp0jmSv4Xw7513mj5kW4/+wCY+OYClcG4pxOj/aPzDRL424?=
 =?us-ascii?Q?fqE8G1SKZZQ8Ay4a1Iuir4ta19JR/pAHV68imYCx962F3Mi48dubTOECumOK?=
 =?us-ascii?Q?LLV3uAL3Nf7yNrq0O5Xtv2+oguoXnuud54nzhkCS45J6hfj60bYx41Y04Tfk?=
 =?us-ascii?Q?RmimihT/1/ARBsFrOPx5CsEFkSQcS7xaM2IA1XKeffcqFfGBlF8G8boEd7TH?=
 =?us-ascii?Q?2YW8mzl2Sqj68KL/g/jFNvJCFZ1gpcETbb635glcZeuixDXoa4oYCrC8tgZr?=
 =?us-ascii?Q?Lx/BkIq2Ap1eF/kJqH7L+VM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A8FEADCC1FC2874F8074997279D920E8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LuPp0khW2lh6nEzOY5Ac6+EnOVdO9qYZqwKUB76gOVAhJgMsBT3ysZ3N3mZcWNY2QKGolV3DO1pv7pYSGrG1IjF1PUjUvZTNrUnDDaLiJgAwmwRGKvIQ1OY9koYMSVNXMItVPYQS03esBXJuGKxwSo0+TCnCv/7eSeueZrKqRL1PRR8SZN1sZtQkJlEf3CSy4/AFrPyE3v7mnAyoaqdbp0mUh+3sV+oepV4dNLHWHIhMzg7kxbRyf4hDIzPx71ysOqDwlQH51ZKsuc7sVBbNwjslsFshXBtinOJQU8bgzAVe/7FA1YQdlyw3dRxQlsXNWxVs0IQaqog2nt+yYJ3eZmdcwb6ZfOy/NDGhR6ibSenXgki/naTtFvTbAfTHTiwwSe+BF2mTy8rpRmGNcvP/tAMwUirYrS1ZV2nlgjuZiFu3P7Q4VfBD+3rBpYYWJCipQrGZgdpk0r9DYEZa0QbZEb7DYio8Lw1n/vEaL0NfproR4ta5eclJoAJCR0AhEMp8dRFWMZ7kS53oNG3KzwUYU4lwmmP9y1LQDMJyei5ij6dSKE3zxebGO+enKbI/dCt89Ngj1l2fTkByNzmk2NiMulGojjjDHLg8vhkwrHsii4eo9PVxf5OQrneFiS8czq+8a7x+wc6FFrMFl1XhVD0KxtbhWw0BzfHeyj4DNq6ldhp/+ri/91uPYNfigJrO/IFTgB48kHxg0f4lcbX615vSyvLFPUpji5x3OopyfhosTGRl7BCgAY8AnuwUXzW9cp/Fu5mfs5jqn9d/mKUyda49Bbm7OOYs+MjTaI9FkZbPIcFOuLHDMd8TjUlvBE7wXLx6ZEjOdy47m2hdEJzNTnJskfz6Zyxk68eC+/1DHLhxEmILINNCuXG1xqTh7B/WIaBfv0KPJXNqDIekWmcWaJjgaxzO9l/1+FVqjFEFRumkGss=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d13f80-91cc-4106-a97f-08db479d2a42
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 04:00:54.7242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mqdB7J+k8re1fa0c4NavSmYAzcSSsPKA3M1hHzG0R+H+3GXqfWhrf2q8SXEvPdiGinvHqC8P8gMb8iyXiiOa2OBo5G+ZBdtWgVt0Rqh5LVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8375
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 21, 2023 / 08:05, Daniel Wagner wrote:
> Introduce two new function to calculate the IO size for fio jobs.
>=20
> _nvme_calc_io_size() returns the jobs size for _run_fio_verify_io()
> function. Reduce the max size of the job by one megabyte to make the
> test more robust not to run out of space by accident. Note these fio
> calls run with just one jobs.

It is not clear for me what kind of issue happens without the 1MB decrement=
.
Could you share failure symptoms you observed?

>=20
> _nvme_calc_run_io_size() returns the jobs size for _run_fio_rand_io()
> function. Again, the jobs size is not maxing out the space and most
> important it takes the number of jobs into account which are
> created (number of CPUs).

This patch has two purposes, similar but different. It would be the better =
to
separate them.=
