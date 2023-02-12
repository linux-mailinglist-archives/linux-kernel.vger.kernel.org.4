Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EAA6936EC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 11:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBLK4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 05:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBLK4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 05:56:39 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BE68A49;
        Sun, 12 Feb 2023 02:56:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFSHdVbkDcJbo+HxmTyTQOXHTySVHwMHu9Gto/vnTzTqqTPHIFXep64+MH5Rn8FsizQx5JKlurtjsF93P8zuqZ43+BJ4giqx5pT7ICcRdRnHFRUSxQkq+7gUMbvmXBXWO5JqwI3BypeoZFS+c6Z3rPV8hMtd5av21j6JEoueyoDVvrU3EavGmX7+thWBj4w3OYMiChCgxavAWd4JRIPaS5FWw83Fn+IYLekfw0SNWlMsh64H4SWms3IjQEPnhfqg/Xexxt4LZeGYtHCGIId58y5id8zF6MRFKErQwNR/2XERm82QU7sS4jXnsbmZy9xOXQBgKxHQRuev/6voRcTm9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3s2nuhM4Su+qcJxatKsRRa2+nQDN7dAITc+ThLykQSs=;
 b=HRfkNlsTRSB8Zr9LjX5/wBN6StYuB2sptv4To1qWeMkQAepfU3XBh50VGi+ddaQZn3qoPMcLD//RVCm+B4QuIQbGrvPViF+FYvttwsfsLnD4BgdBIFKy7eekgAxw2jNL9I1UYuSgy66NB2k0PO39ejrl5Ej2lF/iyieddJ4ND9vhQSVJJgfT0fSMtIJWfizklch6aen6n0z8OAZyrQhLI7trIdiRyvX3efd11FWXYzT4ilrXCqWBoKKyC7donxgLyB5a/vU1a+8dXlMZgbclowq0Klqd0GS62wF1TVGQNIyt213r1dK3EEa51lajkfoKPLmhMo7ufO/oWfMHjkYjag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3s2nuhM4Su+qcJxatKsRRa2+nQDN7dAITc+ThLykQSs=;
 b=FpzRse3m/5jDVxv7jU2W3ogoOY4Yk6p/xlY9nyMbVw2Am+qPtr9oFRKPQZM7f+6Wo2jAY8bWaf/ZTs09M1wGqA+ra2AFuNnq1Un/ieQVHZRgCCnCqY/FJHlg/04BQsmHPpXMXc1Lhi2IuaNRgOx32ezY0u8xoGWc475Guot0YEA=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9689.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Sun, 12 Feb
 2023 10:56:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6086.022; Sun, 12 Feb 2023
 10:56:31 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Abel Vesa <abel.vesa@linaro.org>,
        "djakov@kernel.org" <djakov@kernel.org>
CC:     Mike Tipton <quic_mdtipton@quicinc.com>,
        Vivek Aknurwar <quic_viveka@quicinc.com>,
        "djakov@kernel.org" <djakov@kernel.org>,
        "quic_okukatla@quicinc.com" <quic_okukatla@quicinc.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "abel >> Philipp Zabel" <p.zabel@pengutronix.de>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: RE: [PATCH] interconnect: Skip call into provider if initial bw is
 zero
Thread-Topic: [PATCH] interconnect: Skip call into provider if initial bw is
 zero
Thread-Index: AQHZJ5uglincFtnDF0iVAMF0/8auRK6dHp+AgAAEe4CACTWEAIAAG4eAgAYRjICAACeagIAKeLYAgBQr07A=
Date:   Sun, 12 Feb 2023 10:56:31 +0000
Message-ID: <DU0PR04MB9417A7E511E4C8B512A0CB9E88DC9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <1673647679-15216-1-git-send-email-quic_viveka@quicinc.com>
 <83a7bfed-3b16-3d01-b1b2-f197252bd0b1@linaro.org>
 <5e1f37ba-494a-19d2-e412-7631508ab142@linaro.org>
 <151790dd-02e5-a1f5-aab5-360f39e21c57@quicinc.com>
 <35dcb764-e340-5fe7-6637-cdb5f84266ce@linaro.org>
 <6dd7b0b0-f6fb-9de4-c365-d6cbfe04f2c0@quicinc.com>
 <742ff9cd-e7be-11b8-3805-5b60aba6b2f1@linaro.org>
 <Y9fZ6GUzWsCMXzba@linaro.org>
In-Reply-To: <Y9fZ6GUzWsCMXzba@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS4PR04MB9689:EE_
x-ms-office365-filtering-correlation-id: 090fa614-f589-486b-b8ac-08db0ce7ccf1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qw65Ij6rrAO1hXcVFQWnhjkw9ex3r6puWcNzRxwJfYlu+0itPcNY7K8B3BuAU5X+PH1jFZ5NKxPEXSmacuSpdvi9YLa3jtHp0oho2G5d/qTmbGbbhaMcaaDqeI9xgo/Ak1ffjY9jjQCufNTGY4et0Ic/tGfa6XtMLvtRkcnRPD8rQF+UmoXwoLCQYkQDoWjbgEjzczNI+JnnAL8eYA6gO0Ih2QJaVvckKbN7DVm+vV91Mw6Ik56mA0GvUd0nWnMZZrPiDglyC+bNgdQbaARMjCwsxxSvbL8lfeghHJ2WbxFCZ11u/NXdVf3M/sWDjGjo+M/K91NV5Jjunij/ltwNEhB/9AWPlICAuOig9xABAA+/3Zv9FDgInrkRmxIccHw0cEuOS9GKoVUg1sxYtARi+C1i2S8PRHz3Ey1DiqyxPNqe5HaHnG7PZX+/DN1NEZnUV7ydsS+AyTB0RlN07S4cI1wLN6o/YKp46/JXEmHXYzcLVBRWLy4NG+ot7tExyqzo9UFSWUUcBqvspPvO0fLzBwZo7ZRD4p8VgK9keIW/8Im5grOC5O9m6HPkukKCOZGlBgmg5tSKmIYEpVW78K5TfRd39hpUZqQZ0VqJ29sjPdUgWto767/4TsdWQ9Z33ttJbNLNK4tVYni05kkABE4jVsVDAELmOqpzrUJTSVF93XTeJwOnAciiJpcKid0Jgi/gRXr9N/cV8u6ceUYl4UBQDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199018)(7696005)(478600001)(55016003)(33656002)(38100700002)(122000001)(86362001)(38070700005)(9686003)(26005)(53546011)(186003)(6506007)(66946007)(66476007)(4326008)(8936002)(76116006)(64756008)(7416002)(66446008)(54906003)(316002)(66556008)(52536014)(5660300002)(8676002)(110136005)(2906002)(41300700001)(71200400001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r+1J0+K52siGUGy2/5FugF+Ja9ZqMqDhPYX1JHEU6gwfvckIV7mAsM7LExaP?=
 =?us-ascii?Q?p0rmtoD20HjH0VNxzU1s0MPnWmQH+5J0oVOzh1EV0FbZPHo06DTVP+qWSm5Z?=
 =?us-ascii?Q?VVxYfgzAjhO6LJh7F89hRwX/NJ0CNxg9n+3Q0721IrfTiSPXsMARtAReHvzg?=
 =?us-ascii?Q?DE7+bt46NHfOlaSUvZo448bHWZCy3bSEnSgfH5O1iomUYwQLe8miKUVMwiFB?=
 =?us-ascii?Q?1NZZ8SzMqXCC0Ppj6q+fIBuiAYvhTzUgzB+D5A07rasNOcWM+MJVkjWnRoLC?=
 =?us-ascii?Q?W4ei+5LxIeKgHRhucZSgwgQXN18+qAjHlkv3UmbV/JeVjONCXA/Wtm6FK6vW?=
 =?us-ascii?Q?6PplA+NZ93tAoV5AywS424GoL9/PNJ9rW47BdC9j47vIr99OTqVyuawmjuMl?=
 =?us-ascii?Q?OosudkORfA9FdscZROtikUwqu4XDsIrvT5Yn94yefdDypU3/YVLqh6FU0Q8T?=
 =?us-ascii?Q?Fm5UFuXunlf54td5sgkX6fTHso5hAe2DcNtWEc8Fgr1K8l+ZeHN57DHLyyiY?=
 =?us-ascii?Q?f9H21VATFWmVcFLll9KfboeDmJA9frPdWb4maXc7UXTTOYrWOJJBbkM/9OiT?=
 =?us-ascii?Q?mf1lCJW2kphyG1lwLpfHjBgd+SlKHfbq/mvXv/f9ErNsOU7ea1VCDZMxRYAd?=
 =?us-ascii?Q?if9Ft3tdbXk09srHKBYaYjWJ5fY9amQ1Rl4xrimRFapC88oTlhqrG4a1uV3P?=
 =?us-ascii?Q?oFsZqlqueVJMBtReDIQSTh9bD8PQfGyjOUc/J7vUt3wYKDyNuxTX5Im2mAjk?=
 =?us-ascii?Q?ElZn/t5dliNegtGnWkmqU+mU0q9JE9ww+r9TUFm2YA27RRI07vIYtvpEmNBX?=
 =?us-ascii?Q?XCH8zmNL22de+E6EWMDaYAZN4ymsWUFxlvpkD6Pv+Y+wBFWBiXOqmGKGj34t?=
 =?us-ascii?Q?MtYtufaS9XIpWPoiJusCWXYFD4pdckNuolhxSZXLK9KVFUMfEMY2w88sAlKL?=
 =?us-ascii?Q?MQSFO2/pMx25yjxsCJq5cpVeNyUcarIklF0IUzUVD/ItQEExZZP9BgX54fh6?=
 =?us-ascii?Q?Sgp4zMXCqAj08ue8Odm2blRTa9P6kGmvQfwytpUXfJ0dcMY75VNibdjC4u8F?=
 =?us-ascii?Q?YRfbVIruACLYj59Wa7bJ3Ewi20LxuzkoATDo4kSzEgtLUXB7njUgFZ22O3Bq?=
 =?us-ascii?Q?8LbmrRfKMjPykFVygfkdi4dc4ab//Ye//XbyGFCQRzlSBRHx5qIByWuJa433?=
 =?us-ascii?Q?3RJxoZPfT19IiMgtp4TmgclwG29ytmTMcN+ECOGlJgHIC60de7MafFNy3BmV?=
 =?us-ascii?Q?1JYm5bCA621Ga502SHDb0K3QOLEu5RVVzUgixOowUCxNQrSKYeKZQNSTEFB8?=
 =?us-ascii?Q?0DPO3dRhJGebI7FhGmz295+2GhQW0Umc3x7OiKch75pY5x72vEIuqAgxJPzM?=
 =?us-ascii?Q?cu+0L4gKygRW1t8bLEibw78D1bQYmxZkSu17I2LzjXSg3ASiZQCe9qwixhKc?=
 =?us-ascii?Q?U2yFYpXwVzd3StauKm47ywOm0Twt92RQY+9vw9avQVuPZmC92aRvfFPfJt0r?=
 =?us-ascii?Q?2dbaHKrJMZnv5YKW1ghWsYXx+MKhkaiHo+hjNY07fvmOnliK1F9S5HXb2tyt?=
 =?us-ascii?Q?IhgTgBpkRDJ3GLzi/ebp583gVxlf/weycXoAiFR1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090fa614-f589-486b-b8ac-08db0ce7ccf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2023 10:56:31.8273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rAstFiBkueCwFlP+92LBWuzK254CUcrepIoXkbMaExc0lDvuikaMBcyFCTX9mf9HDivCg3KICpv9JxP5wwK7bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9689
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Subject: Re: [PATCH] interconnect: Skip call into provider if initial bw =
is zero
>=20
> On 23-01-23 22:58:49, Bryan O'Donoghue wrote:
> > On 23/01/2023 20:37, Mike Tipton wrote:
> > >
> > > This isn't actually changing it for all providers. Only for those
> > > that define the get_bw() callback. Right now that's only
> > > qcom/msm8974 and imx/imx. If get_bw() isn't defined, then
> > > icc_node_add() defaults to INT_MAX. So, the logical behavior in that
> > > case is unchanged. Which means this isn't even changing the behavior
> for rpmh yet, either.
> >
> > Yes that adds up.
> >
> > Looking at the commit for get_bw() for the 8974, I think this change
> > would be OK with the intent of this commit
> >
> > commit 9caf2d956cfa254c6d89c5f4d7b3f8235d75b28f
> > Author: Georgi Djakov <georgi.djakov@linaro.org>
> > Date:   Mon Nov 9 14:45:12 2020 +0200
> >
> > @Abel what effect will skipping pre->aggregation() have on i.MX ?
>=20
> I don't think there is any impact on i.MX platforms.
>=20
> Peng, any input?

Thanks for CC me.

No impact on i.MX.

Thanks,
Peng.
>=20
> >
> > ---
> > bod
