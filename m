Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800DD74952E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjGFGBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 02:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjGFGBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:01:33 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2075.outbound.protection.outlook.com [40.107.105.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F541BD6
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 23:01:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkFwCX/06Kx/nag4b3S8PuNAu/1Fj2b1OUIxj045KMn8nzr6bFLIFwNBUF+r4MuevFKBgZYBkw4SYpgyxqplcWsTOgXCZI6rm5BLGue5L9/CkZ3JlFbqA0gdC0uf8JYw4Efkdj/Gj5FTQof03s8BtduzcxfDP62k+jnLInx8lrndG0HEVW3CvPu7m1bT6TwCZaiQypT5wFYlhRSCIOtgNz0m5LR3cwIrpoD2YNSDDZR1sFnITzZJ5QpbJs732lH+/yZR3GMQo7OA0TuFJYoKL7F1y3smk8TQHboFDGoWpEioP4SGjAQ06c6VTg25fF4sPbK5X5Fb5LJXI5g6HPeDfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6ZNdCd+UijVnbTZi3U99cGsZ599/noebP1fYIsjpSY=;
 b=TfYwGZqjwvMID9q0BfwvtqO4RVDCuRX6nvCDatf4cSaplTGYNZ3S/IPlYiZ1ECbr6FWKZPOfBZtnANDxzhQ6cBS//7GkhZ4gjhu+zvzDR0D2P62+hK28bZV9iiVhnEuecPoyMQnd98wT/QA0WYWdVj6I43nGIbaT1/LDRe5rEfAB6SETuNLDn786v7nOPL3LL4DOF12aeHOX3cLO9wR2I3hlS9imQPFwospdCVxNc1dJZglt7mkXPGiVle9dSRcnw/uMTvo+vfEQLq2VaincJxZRc8MsyDqn9YsOmZckCzIhCjg0ARtFEaqUec2uFQ5kEgyTYyEKYd/R+avpr3L1Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6ZNdCd+UijVnbTZi3U99cGsZ599/noebP1fYIsjpSY=;
 b=Bx9+bl+XHg9AXBFxnhIrumOd+kCSV7UOFluZrqxhTDoUXORKR3jMswOhrLMCYN9Mk4RLJ2v7la3AIML+IHj57pAyMGL1yAL5yLUrY/lDMczhiQO1JXO4KfKryu8VMpLvG92e1465s/QlSVX2kJqEd3o/QrSWQXdeTgwBIJOB/bA=
Received: from AM9PR04MB8907.eurprd04.prod.outlook.com (2603:10a6:20b:40a::22)
 by GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 06:01:29 +0000
Received: from AM9PR04MB8907.eurprd04.prod.outlook.com
 ([fe80::eb70:e071:7cf0:6eaa]) by AM9PR04MB8907.eurprd04.prod.outlook.com
 ([fe80::eb70:e071:7cf0:6eaa%3]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 06:01:29 +0000
From:   Alison Wang <alison.wang@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Leo Li <leoyang.li@nxp.com>, Forrest Shi <xuelin.shi@nxp.com>,
        "X.F. Ren" <xiaofeng.ren@nxp.com>, Feng Guo <feng.guo@nxp.com>
Subject: Re: [EXT] Re: [PATCH 1/8] ethosu: Add Arm Ethos-U driver
Thread-Topic: [EXT] Re: [PATCH 1/8] ethosu: Add Arm Ethos-U driver
Thread-Index: AQHZoBVsg6habxYIbEmfvjjh7HkyA6+M9moAgB9jeNA=
Date:   Thu, 6 Jul 2023 06:01:29 +0000
Message-ID: <AM9PR04MB8907F8BFA64324B88C114E52F42CA@AM9PR04MB8907.eurprd04.prod.outlook.com>
References: <20230616055913.2360-1-alison.wang@nxp.com>
 <20230616055913.2360-2-alison.wang@nxp.com>
 <2023061616-sacrifice-mollusk-737f@gregkh>
In-Reply-To: <2023061616-sacrifice-mollusk-737f@gregkh>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8907:EE_|GV1PR04MB9071:EE_
x-ms-office365-filtering-correlation-id: 028e5260-5f63-434b-d86d-08db7de67110
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P3miwZlJQgyU56euqrcXCbUvfTIBYFWZ1dLPyrZrTP5bdVk2YRVFwvjh5daExzclzRCKgZc/j4aXlEoFY9p9yvbiYXex43ohht7zh3MjH5DsUQXyvXz59YWF4fobjJ4pN6mZnsejqo9Rnh2igd4/ILs4r/Q8pRp7ydufQYqUjFJXLzSTqxtBXLiazW7/d8qVaZOJzlkWCWIDXjmnG28F5HSyvOzUUSphI7rTMN1N1BGi+94ienGYGU0lFAXQm7kTn4gJs8J+HLtk0aqgdF2B4u2ufvBVGcBGcqXWJoaPGWrgENIiQD2R1osY6Bb/EPATORWkrRNcvrmVJV0G3tMPHuZ0OVxC9q9wmo57L08MEF73QERSY9Xz8cko++JuO7Av7eqEOk7rvzBXGyACnPdFYxKJVV2OkRxSaOmHWqj46SlZPdegENXJTTCaL0BFOuavZJ2MCCA3guq+SnLdQgf8IIQjuRPzL99nsrPjKfhiZJNgiX++ANjsoF4fFU1CiJjvkughDhzjrmhUgFbJ9rWDZr6cyAjXO43mooiu1DNgWlqQGSNdyJ6iP6kY2CDy+nyX4cI+6BL+94X5dD7jwBLbc2fGfZt6snjiXRXplSO+4RA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8907.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199021)(41300700001)(66446008)(478600001)(38070700005)(966005)(9686003)(54906003)(45080400002)(38100700002)(86362001)(83380400001)(71200400001)(122000001)(66476007)(4326008)(66574015)(64756008)(7696005)(316002)(66946007)(33656002)(6916009)(76116006)(55016003)(2906002)(8676002)(52536014)(8936002)(66556008)(5660300002)(186003)(44832011)(6506007)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JQxTDyNxxS4I3wGKmy7TsDiSsaQe8cmJrHeXe4QG3QrQW3krbkPMaXEUoX?=
 =?iso-8859-1?Q?Va8Lk7Klp0x4ZVEQT8aBXrrOuAMXd5zZ8uls8g+0jGNWP3f81cUHeNtae1?=
 =?iso-8859-1?Q?0VG/DkD5qpyfGbdJ/jssitFDxC6xIBeXjHGmLt3yfdNj3biFIhNbFsMnFm?=
 =?iso-8859-1?Q?y7KxCpNI7x+yYv/li14O+IebN8j+5q119ENhquwFXLdun2DlhH/KkSbHH6?=
 =?iso-8859-1?Q?wPnodxbD1U5LmABlepAEao8vQhHN/y8CIE+J0ybTt5zkLdGlEM703/DBKi?=
 =?iso-8859-1?Q?6GzKqf5Sr4+PLzENdw9Dx8t2xWr1qUzIW6YykPgA1zn/ghw7yWI26R16+0?=
 =?iso-8859-1?Q?fnaLtm00XEPLFys2BFMi9UOrYMvQhvBIapCI958yMEUdukCaRlyAPwFz1M?=
 =?iso-8859-1?Q?lYcAYiTQpT2OUJ6eoBDrBXUAjUGLjJwk8FHNfJdm3S5gt0HFq503QgDJ+M?=
 =?iso-8859-1?Q?d/lNt2vcPt2W+pR8CYKeKtSMf55VWI1bcyN6DDarFZi/RxVWnMUjqChU+9?=
 =?iso-8859-1?Q?O2pXTLt1hrhXwWhz4KHJdxW6RypLWIs5TTKN4qMUj6+NbQyKW+MGtbakLk?=
 =?iso-8859-1?Q?eR2alT64k3Jim7BqbFFS6f7D4KlHQNN2l0qYLk/w0oukGbKUrqz7re/oUF?=
 =?iso-8859-1?Q?qCqMYgRTJKgWG1Vli50DO0afDi1n6v6fHnUb5aNmuMJ/x8F2lWblqjbVEW?=
 =?iso-8859-1?Q?n4T4Il+Fx4yzvg4Jw0wE9OvByILnr/HnPfwgtzabJaJ+KId8kG7aQmr+Q7?=
 =?iso-8859-1?Q?AmI9VOP4o6Jb2oMVX+YS247WqshD/AAMCoM1gjtN4F5PZUg7II0x16itJZ?=
 =?iso-8859-1?Q?Qf+CTLwAR32A+b0e6KhmlwwX+PDY5bzDUnIiEUaMXfCXDJf9+lYWzYLvvj?=
 =?iso-8859-1?Q?JY2QwiCR+zlcoaNxXOoPg/7iVmneMxGByuhdq9h3XcVU3jgjaHe9EVWR7g?=
 =?iso-8859-1?Q?NMDdOrRHn8aUGLB7/7De84H7ImOHLXMA7IdKBeXgwhlz/4mi2BmNA61bTb?=
 =?iso-8859-1?Q?ha2C39g0x5nq7W0t/Upd67Ffe0g55FvbKaXS7EMnW3bTzIOUJLfbyuHQ5E?=
 =?iso-8859-1?Q?LOxcnPTanEdb44fBIggnw+z1sK4WO2UoT75c/Hki9POaRnQ/mhRKaWeBT8?=
 =?iso-8859-1?Q?Ii9S2k1ucc6677eUg36cTyEFhalcUczTK7A9cHg0XpmMrvpuyknkiqOFi9?=
 =?iso-8859-1?Q?dyUxliA6Fu4KDRR/ctl+xgleIsSsMw0vZH9NHtexweBdr1IphyxbJAXTAQ?=
 =?iso-8859-1?Q?S0779ee/OeJ6EFh70jEtKaw9fUt9OFA1AvLpsP033m8ujnvXuKxWzx6Zy8?=
 =?iso-8859-1?Q?2FvGWdq7OHc2RMCn/NL+rVn6QOgUIjwQZhKUMOsFhFQXc8nxtw02XRiVYo?=
 =?iso-8859-1?Q?V9fQPnRzb9lvPeajpkIjD+7g6S0L0oUZWIXiDp4q1xP1eQjbR89fje+7YP?=
 =?iso-8859-1?Q?aXr/KvTf4rB/5q8PdCGp7eZihLEEITxAKkxuR6mJddBdjIpWkuU4R4UjAU?=
 =?iso-8859-1?Q?jNqOcS6phmlWNOryyJquIkwWfUAoHkg7jJAmzulN14JSbUgeSMbxCIpVWG?=
 =?iso-8859-1?Q?xgxnS0BRD6xvZmABQrCVCF10M6R1EswrmS6KeAlBUpJ+T8ctAXbRFK1V4S?=
 =?iso-8859-1?Q?Ylk3pwzHF7OdQBjd3F+r6llpmepikFYt5X?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8907.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028e5260-5f63-434b-d86d-08db7de67110
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 06:01:29.5353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gvzqHjXVXB48bVXKNqZ+0h/rWsFsJ46iqpqO4b0ojVBo7dTjBGB8LbR4ebmzDGsbH/Ue/RjUcQ7gdkpVP/yU0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Fri, Jun 16, 2023 at 01:59:06PM +0800, Alison Wang wrote:
> > Ethos-U Linux driver is to provide an example of how a rich operating
> > system like Linux can dispatch inferences to an Arm Cortex-M
> > subsystem, consisting of an Arm Cortex-M and an Arm Ethos-U NPU.
> >
> > Link:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
.
> >
> mlplatform.org%2Fml%2Fethos-u%2Fethos-u-linux-driver-stack.git&data=3D05
> > %7C01%7Calison.wang%40nxp.com%7C4b1681cd19b9450e832208db6e32
> 709b%7C686
> >
> ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638224935139578328%7C
> Unknown%7
> >
> CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> LCJXV
> >
> CI6Mn0%3D%7C3000%7C%7C%7C&sdata=3Djwhvw5i1Q2M%2FOLID8TsOOnaI
> 9LqD6y%2BMnn
> > jzdvdCXcw%3D&reserved=3D0
> > Tag: 22.02
>=20
> What does "Tag:" mean?
>=20
> >
> > Signed-off-by: Kristofer Jonsson <kristofer.jonsson@arm.com>
> > Signed-off-by: Per Astrand <per.astrand@arm.com>
> > Signed-off-by: Jonny Sv=E4rd <jonny.svaerd@arm.com>
> > Signed-off-by: Lior Dekel <Lior.dekel@arm.com>
> > Signed-off-by: Henrik Hoglind <henrik.hoglind@arm.com>
> > Signed-off-by: Davide Grohmann <davide.grohmann@arm.com>
> > Signed-off-by: Alison Wang <alison.wang@nxp.com>
>=20
> If this many people signed off on this, it better be correct :)

Our patches are derived from the ethos-u-linux-driver-stack in mlplatform (=
https://git.mlplatform.org/ml/ethos-u/ethos-u-linux-driver-stack.git).
As a gesture of respect to the original authors, we initially included the =
ARM authors' names on the signed-off-by line.
However, after discussions with ARM, we would like to clarify Arm has not s=
igned off on this patchset and therefore we will remove their signed-off-by=
 tags on the next update.

Thanks.
Alison
