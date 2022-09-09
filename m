Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342325B2F55
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiIIG4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIIG4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:56:49 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10062.outbound.protection.outlook.com [40.107.1.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7739D129519;
        Thu,  8 Sep 2022 23:56:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzA3Ia36N7PifoEdunWRYudc0FT6VUYu4li9fGBCsyRKzU+Z9JPQxz8w/asxKusXy0Ape5WfuW2QufTgn03ig1BDYpKIWIwXcsLQsVaOIQgwDGm6S1nShk+6uIxacz1oIPcTrOIl9qHsx9LWadeLejP+kEo9hVlCp1f52TCy5GNMMCQjsx/1cjOFlm75ORrVNqMFL9rk1swbYYp6wRb8+9O/5e9BIYuOE7xQ/xhK/wNBUTxTBQ5EFnVX1LsaqKcV67VpJP2yPhavtf4fFA1Jm1VGTdFl0KPKXckG+/4zdQQQYSbX+qJUwuZXYf0GwFc8pBA60MM470nofu/ukwumfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tk7jXHD5H6qDqyuPss1QrAztwN/iw14euu8cbC1+tI=;
 b=Cnj9Gh73h9gYhNdudv8DgKQ2JuQTpEBjWGjaAtCpkDXEiOfnedNN94sk+NmLeX4eGNLuEXe3smfT5pvNUy3nvQfqjn6e1WHBExo7R/zze4plpuRDe3+hy8XInVy9PNwwFiJcty7QlyXEI+rplsAEZbY6bu8k2UOzTONTsTilIgDTSMBoOB5QTwtZgFkFI67BRJAScbZCnEQtuOnf62xpaD3A6aNTYqtv1AFkmpi8ECiWdf9TWYYdAaiakdRNS+t2tT/GgUYYoGtVufOEUC8ZbLGQ4F1UlGHOVIlDsq03E2Qv4gm00iHZADtY8Dzn7Z7rVuro+yu2KrpVkIYF+Op+pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tk7jXHD5H6qDqyuPss1QrAztwN/iw14euu8cbC1+tI=;
 b=QDO5+jX+rerXj5Kfd48hVpbjNK8GeMoyMBz1IzGOsfD1iNNf44/g4yWmlfV7++wxjwGhYlsMvLObQKOlGAflXB08OSy9IOdFnzgLNWsDstzG+9IjMrkDme4e+OldwSjS7AABa2a5wEr90cRz0d7CiW1LXfMAOHqfbK3SLvWmhs0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 06:56:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Fri, 9 Sep 2022
 06:56:45 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Marek Vasut <marex@denx.de>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>
Subject: RE: BD71847 clk driver disables clk-32k-out causing RTC/WDT failure
Thread-Topic: BD71847 clk driver disables clk-32k-out causing RTC/WDT failure
Thread-Index: AQHYvlGBdqdb0Wka20ODtoakwJg21K3LiDmAgAozSACAAA+IgIAAKeoAgAAUeoCAAFoVIIAACWUAgABIzlA=
Date:   Fri, 9 Sep 2022 06:56:45 +0000
Message-ID: <DU0PR04MB9417919287BF69B2535348CC88439@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <CAJ+vNU1Za2CPGVX3q4HKufsxbL5zRrk1B5CWFpKritetrTs4dA@mail.gmail.com>
 <59b6dd0a-7cbb-5dbd-8da0-57baeba3327e@gmail.com>
 <CAJ+vNU2FVQRwCa3DnOwkFjaZg-ntFLZmetwDbSggDXDdwOOGTg@mail.gmail.com>
 <2ab24cc4-4aa2-d364-9b29-55f5d6b23626@denx.de>
 <CAJ+vNU0voeMW06Je6nyrV1Ud3sT8Us+RACcQtsKUwKVaXF+dQw@mail.gmail.com>
 <ce0ffc43-bae7-a55b-ebea-985abc765c33@denx.de>
 <DU0PR04MB9417D8123D40FBC980E9C05388439@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <a03ce7a3-dfa5-6016-afbf-33193a5e2376@denx.de>
In-Reply-To: <a03ce7a3-dfa5-6016-afbf-33193a5e2376@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83ae52c2-4b8b-464b-09f8-08da92307598
x-ms-traffictypediagnostic: AM0PR04MB6802:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OBO1nq9nX2Eg7sIDkShS/CIcDI7c7pJTeLfmEQL9TpjeHk3FfQ70nYz8wKHJAt2g1IUvNhqTzkDqKebBrjjD8GFG8aN9KR5j18pdEwLdykVBxBzXDTKI4uE82ra9h8wohZFCJ9DlMzcCQk5eO8UER/C5vzje/cRNj5vgkpz7Mum2rwDkL0EGHhJS+Zg2XRGXRg0ybA1ez5m8uvvayOdTEABzWKmzW1WEMHRNXHfIFz2uW05GUxy6GIO9ShdvVg4kn7JLIb2mFk1uwht4Ykjzf2yHkPbRGJ5iJ6mj8FizmaYuob4gxl8TbW4pOP+N2373sFcrd9anAO1qMrGZ9QMWKkqtUFx4YVYRHbUZ/LVmGSZn2royp8ctws6Eh4Xd5y9QYGscGd8B+sfM26f+h0TujQ3oC8/z33ec8xMUgOEhgq0UUagzP9hBVbMdr1tYhv4+2pBpSsjuOodqSszYkrKnnPyB+S4DYc0x1no+Ka9An2M02Z4J8JeBVTiWQhf0fqWmVqbiUlg1n5F8yTlWu0qMNK2xr4jTsRfStb49loCFdo26iMcAzD0KjmeEZZztIlW3xKlJqx3gFxFdgYfcfigAncp6nttYAfYYog284IW5nFviDhlUM6Q3N6PZd2wrN8dQI+ItLH9fZJvhZRmjfzV6w6UuJ09GOTH69HF6KRheRpdjVbdaKPezUgIj4N9PytRSG0om42Lp3UKYDAC1HJCzVW7HaXEzwvyMXV2OfHb+m+MKQNkQkbZ1I8Aj4hlsZV7QIa9XS40HqOI0/nX9KSfDpmlWr/D+asIzVg9uibxdGWg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(38070700005)(86362001)(55016003)(66446008)(38100700002)(122000001)(66556008)(66946007)(64756008)(66476007)(76116006)(4326008)(6506007)(8676002)(8936002)(52536014)(9686003)(26005)(53546011)(7696005)(71200400001)(41300700001)(478600001)(45080400002)(54906003)(110136005)(966005)(316002)(2906002)(5660300002)(186003)(83380400001)(44832011)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9pdxnhx/1zQGCy4lt1azZu/0oHBB6YsKNXogxRt6uSZJ65KS91hjpyxnDAB6?=
 =?us-ascii?Q?U23PXPIj9UBNGsbAIFNFrS1J48FD3mEO/d9WSSMnquBFLEDaHke9klEiwdYV?=
 =?us-ascii?Q?hNPc4fnomeNP7asf/uiA4TPl38vSa3U7JvUT4s0uTKIeyr/fnsfKIMTP1jLh?=
 =?us-ascii?Q?2w86RiU4cEUCptH7w4INp/t7p9kPQADDwCXC097ybfHq0OXYie4cA5YUIzh6?=
 =?us-ascii?Q?TVRcIBZ/nUrrqTvBfMSkNruEZwC3k1vdSbcp5LNGzduuerj9c/K6W2V+PbTo?=
 =?us-ascii?Q?bfsRm9FBfpIBc8NMPBq21pkUOehTPy4luTjl3b9tn8lwWzYUVwmYJpOT8Drd?=
 =?us-ascii?Q?G7sjUiMipxD/Amq4G7dGNeQOz9z9hgn+G7sRmrCPVAfvTyzDfrX3b+3uzT1w?=
 =?us-ascii?Q?qV9J3GN3yQkQ44OmmIKXPX91lHaeSGYlk5MDtQ8k0/NCoCoHwQVyG6SzcUOj?=
 =?us-ascii?Q?9HUOICkmK0cbZoh9b9vGpa8ieMMaQslB5D5O/txMgrfXEcCoYcVtTtMQoLZt?=
 =?us-ascii?Q?HrVB+sSOIK4uopw4S/hJpHAqNumAjVztHUsSomKiin7jxDkjwizCIw0aSu4F?=
 =?us-ascii?Q?ZSr0bnywdVDve9eBJfxWTCdHZGAQWRKlZsZu6Y8ZahxtW24R/ksvH6z+8A2a?=
 =?us-ascii?Q?qahcCC5T8EssI4hr3ljTbkYmAz6egtF4kWAHVmhLzEKdP5RC4bfck03yKvf6?=
 =?us-ascii?Q?PlH0VLPHsMcREMnwXJGpOqPrPHRVrxCFpOhNaOw+4ECeyu6aGxUaYT2ZdOvE?=
 =?us-ascii?Q?gwoCIBCLyTNgrEcbUxVusGS2qbQOeqWARHkI0pTGhuE5HUvhctv1KBKUOma0?=
 =?us-ascii?Q?H0wjw2BrFaA/StVyzaXoGHey084/1/q9ZgOe7C8KgS4zWU/1y+Dei3MWj4ps?=
 =?us-ascii?Q?4gkgNjYFQTg9/yij2bTr5Ze6Zg2oZqPOd0FdMHQIEtwyVxxEqq9EYU0rcr93?=
 =?us-ascii?Q?t0vFiIClpuMc9kO1OqJ8GYJPq2QLWipC6+NX7z0vZsjypWbE4t8lKLkZAH5P?=
 =?us-ascii?Q?+5DzSiQgrW86sETvdlUzNw4EN8ciPfvZqDiietv3Q8BGl5Ed+T7+UqE/M9w4?=
 =?us-ascii?Q?OT7iHMNLhYm9UeGpjCGvWx4W7Mu64rpC+MVRJUf/IPRv6fYwxDDhUz/Kqqdx?=
 =?us-ascii?Q?k5vzHXRZzwIQtBNa/2JuqpTnXnqnMngo1SVwQk/4z4A3LNmpSxfWSPA8Nhkz?=
 =?us-ascii?Q?mJrzE6ynVAZG0JCNb/gp9W9491gOkB8ZEExmGFrIf7Gj26mDet6sPoE6YKkA?=
 =?us-ascii?Q?EyGZf/79EeJfM2qlxjcviUux4eBB2zdlAu9RtMzjaeFhPrf8GzJFuuqC2//c?=
 =?us-ascii?Q?UXNC0JYXb6u19DHy+ur9Ow9nMRqSYLzVDfIKmAd14RJ5NC3C8dACBfovi2eS?=
 =?us-ascii?Q?XdXcC2zcFMikdnxW47EwVLbF7G/74R8vgTM42L4Wm+L/1wcqQdtuSC6EtIxj?=
 =?us-ascii?Q?GeBnrSuRlNupmUQKj+QARMiFv5U/Z9nk8SQ7JVl8dH6gfwKIwPToEAHDg4Xk?=
 =?us-ascii?Q?vsA3ZXMe83puwkD3zEqK3TA+2SSd1zfZt7a8jkmmotqZ+DC1Mkd+AzMaqDWs?=
 =?us-ascii?Q?FCjAbBBcreU5DdxH9iY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ae52c2-4b8b-464b-09f8-08da92307598
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 06:56:45.5174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iZA3m4Ke2KGRjvB+ythEusggdUGOK0zq3mnBxvils+Bo/KajcBoDXk8t61J7s6vROdjZZpqeHL06sk8VtGm6Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6802
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: BD71847 clk driver disables clk-32k-out causing RTC/WDT fail=
ure
>=20
> On 9/9/22 04:06, Peng Fan wrote:
> >> Subject: Re: BD71847 clk driver disables clk-32k-out causing RTC/WDT
> >> failure
> >>
> >> On 9/8/22 21:25, Tim Harvey wrote:
> >>> On Thu, Sep 8, 2022 at 9:55 AM Marek Vasut <marex@denx.de> wrote:
> >>>>
> >>>> On 9/8/22 18:00, Tim Harvey wrote:
> >>>>> On Thu, Sep 1, 2022 at 9:14 PM Matti Vaittinen
> >> <mazziesaccount@gmail.com> wrote:
> >>>>>>
> >>>>>> Hi Tim,
> >>>>>>
> >>>>>> On 9/2/22 01:23, Tim Harvey wrote:
> >>>>>>> Greetings,
> >>>>>>>
> >>>>>>> I've found that the bd71847 clk driver
> >> (CONFIG_COMMON_CLK_BD718XX
> >>>>>>> drivers/clk/clk-bd718x7.c) disables clk-32k-out (the BD71847
> >>>>>>> C32K_OUT
> >>>>>>> pin) which is connected IMX8MM RTC_XTALI which ends up
> disabling
> >>>>>>> the IMX RTC as well as the IMX WDOG functionality.
> >>>>>>
> >>>>>> //snip
> >>>>>>
> >>>>>>> This happens via clk_unprepare_unused() as nothing is flagging
> >>>>>>> the clk-32k-out as being used. What should be added to the
> >>>>>>> device-tree to signify that this clk is indeed necessary and shou=
ld
> not be disabled?
> >>>>>>
> >>>>>> I have seen following proposal from Marek Vasut:
> >>>>>>
> >>>>>>
> >> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl
> >>>>>> ore.kernel.org%2Fall%2F20220517235919.200375-1-
> >> marex%40denx.de%2FT%
> >>>>>>
> >>
> 2F%23m52d6d0831bf43d5f293e35cb27f3021f278d0564&amp;data=3D05%7C0
> >> 1%7Cp
> >>>>>>
> >>
> eng.fan%40nxp.com%7C07d48edcc47c4694e08208da91da2bf4%7C686ea1d
> >> 3bc2b
> >>>>>>
> >>
> 4c6fa92cd99c5c301635%7C0%7C0%7C637982664162868785%7CUnknown%
> >> 7CTWFpb
> >>>>>>
> >>
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> >> 6
> >>>>>>
> >>
> Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DuF26u9g4onuqCWzPRAvD%2F%
> >> 2FLByaEhh5
> >>>>>> Dtah9K8CcAOAM%3D&amp;reserved=3D0
> >>>>>>
> >>>>>> I am not sure if the discussion is completed though. I guess it
> >>>>>> was agreed this was needed/usefull and maybe the remaining thing
> >>>>>> to decide was just the property naming.
> >>>>>>
> >>>>>> Best Regards
> >>>>>>            -- Matti
> >>>>>>
> >>>>>
> >>>>> Thanks Matti,
> >>>>>
> >>>>> Marek - has there been any progress on determining how best to
> >>>>> keep certain clocks from being disabled?
> >>>>
> >>>> No. You can read the discussion above.
> >>>
> >>> Marek,
> >>>
> >>> I wasn't on the linux-clk list at that time so can't respond to the
> >>> thread but the discussion seems to have died out a couple of months
> >>> ago with no agreement between you or Stephen on how to deal with it.
> >>>
> >>> So where do we take this from here? It looks like there are about 18
> >>> boards with dt's using "rohm,bd718*" which would all have non
> >>> working RTC/WDOG with CONFIG_COMMON_CLK_BD718XX enabled
> (which it is
> >>> in
> >>> arch/arm64/configs/defconfig) right?
> >
> > Is there any requirement that the bd718xx clk needs to be runtime on/of=
f?
>=20
> Yes, the 32kHz clock on BD71xxx should behave like any other clock, unles=
s
> specified otherwise, see below.
>=20
> > I suppose the clk should always be never be off, if yes, why not have
> something:
>=20
> What is needed in this specific case of BD718xx is I think clock consumer=
 on
> the MX8M clock driver side which would claim the 32kHz input from the
> PMIC and up the clock enable count to keep the 32 kHz clock always on. Th=
e
> PMIC is most likely supplying 32 kHz clock to the MX8M, which if the 32 k=
Hz
> clock are turned off would hang (I observed that before too).

i.MX8M has internal 32 KHz XTAL module, why need external pmic 32KHz feed
in?

Thanks,
Peng.
>=20
> What I tried to address in this thread is a generic problem which commonl=
y
> appears on various embedded systems, except every time anyone tried to
> solve it in a generic manner, it was rejected or they gave up.
>=20
> The problem is this -- you have an arbitrary clock, and you need to keep =
it
> running always otherwise the system fails, and you do not have a clock
> consumer in the DT for whatever reason e.g. because the SoC is only used
> as a clock source for some unrelated clock net. There must be a way to ma=
rk
> the clock as "never disable these", i.e. critical-clock.
> (I feel like I keep repeating this over and over in this thread, so pleas=
e read
> the whole thread backlog)
