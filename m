Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0DF5B3A7B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiIIOQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiIIOQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:16:13 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E7CB5A78;
        Fri,  9 Sep 2022 07:16:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUQRaA33r4s9KfChlk3snw2P3c0Ewwb52GW1lSoprQMKvss+h2QdUpLCyi0ya0xhpn3jmdjx39LNQwh6kkJiq0K3uUmy5jlYR++3hmfOeMP2Xl2izp4jPSsU0LtzTOaMnrJgTigziPZRCJ9EKq1Bj6SEdyLgYeXppr+YX454aAKDXSr7vvpxbC8/g6AuN3nwfzQ33WV6d8biiPTjSR7bcCqVwI1WwQP3MWr6N/AKZr247A6YvZW0A+KIK99ZGbgRLxF/3qag4iIQK3zjWDoik+2MYtQlvmk6Wnr87jlf8PP5sg9nGkAaeDMIi8HYKBcWIATnGH1zbvBm0lW3Lk6w/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44WMxbfqtbn/lqtNRuR9q3Xm5ddS8wK6VhT0mJWIq+g=;
 b=EvpKTttEHmbBvrQde7zJLbRnZHwIMmoY/hK5ggF61kMAJPQB5aIgc1hXqlVTH2rlQ7Beza9jwjIBlHz3eblBSTfqgdcU8eXKh+YcmCIeC9rdWjB0A+LG3Pj8kuFPDO0cQy8QwCv/1ImENQj3McgnT0mN8gtHrXEw+7doNp0usAr3Eh5LOQCuXHJTUlu3d0OTrnOkvwEa4QWHmvWO3I3cvlmVrNJ6rtcIMgSEPxiclHpRz+EzYdnv9qsoAQyk1Kibl0DvN8p88+G139HEo/X/2mVA+aR3DNdquGJ5L5gLZzkuFyc8KXgcq7xGaxGdgQUY5o/arfxoVIa51s7h3p2msA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44WMxbfqtbn/lqtNRuR9q3Xm5ddS8wK6VhT0mJWIq+g=;
 b=GWB/ily+aUz6PDRO1ezjG6FEjCfy17syG6Wotj6KlJIdziaMhAqhWjGvGRC9klT+5eEiCZJfh82lJ4R0KQD4nt7QW3zPezhYDuaMdVsUNT/SYOoKSAiCgrLmzbPr569cx9dfgMZL7WUyyh/ZhHZVSw63yEgQg7SPgEu0EbyNrevI1w0ArJ2PyVJ7Xta8eiNGl31YIBNMqIp3P/AxR/rSSY6E1XPK50DNwQ88xb5m95X9xFNdaCgT5v+UO6Lzfm//TQhvbR7GakpMEDeG3BwVcuvqsiq686tnoL5S9FOVLa3avpf/L7cwIZghPiYmqfVlFqYqbtYCbEC+MLd/GPZ5uQ==
Received: from DM6PR12MB3164.namprd12.prod.outlook.com (2603:10b6:5:188::30)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Fri, 9 Sep
 2022 14:16:01 +0000
Received: from DM6PR12MB3164.namprd12.prod.outlook.com
 ([fe80::c5ee:6ad4:e02e:f226]) by DM6PR12MB3164.namprd12.prod.outlook.com
 ([fe80::c5ee:6ad4:e02e:f226%4]) with mapi id 15.20.5612.019; Fri, 9 Sep 2022
 14:16:01 +0000
From:   Petlozu Pravareshwar <petlozup@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Jonathan Hunter <jonathanh@nvidia.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "Kartik ." <kkartik@nvidia.com>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        Sandipan Patra <spatra@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] soc/tegra: pmc: Print reset info during probe
Thread-Topic: [PATCH] soc/tegra: pmc: Print reset info during probe
Thread-Index: AQHYsmmGR8fp18152ESxKlaB5UYTsq20xbIAgAm3/4CAAuglgIAV4rHQ
Date:   Fri, 9 Sep 2022 14:16:00 +0000
Message-ID: <DM6PR12MB316490295E5380D548396C39B5439@DM6PR12MB3164.namprd12.prod.outlook.com>
References: <20220817184456.1184459-1-petlozup@nvidia.com>
 <Yv5XarzacTOkTL1k@orome>
 <DM6PR12MB316434A9BA61A01251E3BA3CB5739@DM6PR12MB3164.namprd12.prod.outlook.com>
 <Ywjuuw/rSRUSORFF@orome>
In-Reply-To: <Ywjuuw/rSRUSORFF@orome>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3164:EE_|MN2PR12MB4423:EE_
x-ms-office365-filtering-correlation-id: 2c849a58-bb61-4394-63ea-08da926dd2b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pRzxS4u00nQDVYJZBOXo42JvKpRQcjB3psm7y7tRUeFst46OZjA6VgvBR+lzTYuIRq+ozDs46AHBLEj+YneSHZEkVhzles4LMiwEwF5ZWlh/KT4M3npQrXoF+GVa1Osd5VTnhP4P3IwBDBJZ+9vpX/yHUwApmGZaFgRWett38n6YJyHAzEEnDfRkHST9rt22KFFh0k93D5GPvx1J0n9vO/IigyFW9JY+o9i1DmFNouTFmXLcy8zZzbE6go1VTQVzrF6ZmQJPkUnplgzbp+PJO/JQo+J4NQBnsMOyEk3HF0D48H6G9CrZQ6u0889f/tFAZxghPKO4J9TjfsWgOK/QBiKJQrBVZct/BPWug0RguWLZ3DIohE0KzxDG5IYaaOSMF1foSQMYXhDfjCAulFDgyxIa39AMeTl8+6OryW0xhWCqYqWzdBPYbZAXofog+DmVMhhNGHdwTJKmI0uA7ZJJUZigWSLtfvmRHGRC2EqOjqEQzQ1Vh43mRaM4GYT+97de2o2p4JoPVjnWoFUlEDQJKy3yKINepq3DHIQ+dugj6IU2uH/yl+S0WwBmZ0SW0B9MS6ALPekzCULZQnXkwcFOgEmE7azon0W+2XdOQfIzl21QDGTmom+POOOViVTCnrRIy0LEdze0zxrwL04drjbLYyGp/0fT4A4cEJZtn3U6xlpTFPe78y0yZQE1C+f+VIm6E9BiiskBUnpyVD3OF4v8ZczUy31Gt+120B08ln+rz5h77t2fTrvARPlVz/aH2bYRs6V/7u/2Me0lw9iXEXbQkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3164.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(9686003)(55236004)(26005)(71200400001)(6506007)(7696005)(38070700005)(86362001)(41300700001)(478600001)(186003)(122000001)(38100700002)(4326008)(76116006)(8676002)(8936002)(55016003)(6916009)(5660300002)(66946007)(316002)(33656002)(66446008)(54906003)(64756008)(2906002)(52536014)(66556008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?67s91SXdSdZSLrU1mxd++Pg8dd48u0vtfVmGdUbcQFMzYkrBKHLr0/xgMlub?=
 =?us-ascii?Q?wlGK2YdRfoaE4ENbqj2xiyyR51TkuAm17i0aQUDsWWk+BllaGfALlw13Uo+R?=
 =?us-ascii?Q?z7XNpDC/4r1EZDrLH79N1hFFwY/PLG4j9DR1ghZxcLlO64aaoMmgZhdnKERH?=
 =?us-ascii?Q?+9CFN2OqmIZ/s/nKCfwKDgbYWHHc+OrWJW3ks+MONubVzw9eKRqwV5j69Yct?=
 =?us-ascii?Q?nSB0DDktGkLitLJ+HtaR13cpD48NGwq638ivnQviSbQKM8ZWFpMum+6fUCZ/?=
 =?us-ascii?Q?ljLNRnLZIujuoTfsk9J08HXU885EQQidayuyyR5jkHE5FyF/2RBxzhDkhUsu?=
 =?us-ascii?Q?YeZJVEsRlHdiYKKw5JZwV97FnJg91NNR4ljeNFAZzLQWWujY/7NifuMh9MDs?=
 =?us-ascii?Q?BLAep23tI7anCIShDcAO6hTqRn/j2zAeZbcqvSBHjcfRoceCp6E1DMHY0HYx?=
 =?us-ascii?Q?I5BLz03dmGtxHVmjhCcuZCx6VA5TK7f8WUGD6FLII0PBeSLsU1VTvaML1vGI?=
 =?us-ascii?Q?ndnIDDU1W5xP/90a+9QVv/oU7EnlkrTCJbIuu3OMJa3WtTeIPlNQBk4OZ/8w?=
 =?us-ascii?Q?+7Ze0BNuEq4s+/zlgUHhYBBQM9S/+RcvBZGTePkrmOHlaIu1aJlWFdtBIc1W?=
 =?us-ascii?Q?BBn0OJxCBctMa2CvQSQOuFwW0jYkgPirku+iJgEYZDG0tPVmkvOlsFqbmtlR?=
 =?us-ascii?Q?rUOOwCv9chFS/XtcM4Tft23v1VXMe70S+/fQ5dh+uKEqukK4u8bttldgg00m?=
 =?us-ascii?Q?GLG8t1ZGQ8AwWZyhOnTZAGiolJey01ju4wGYmaTolanxYj8OLJjcmrJEJzt4?=
 =?us-ascii?Q?gzo4KVKkpC3efkS1Ghnr0x7auhjlBNz+epoBJ36gONWsQIQZZW8spOXl60Gx?=
 =?us-ascii?Q?0vHcCviD8myXtSCUISOZFLq8YbhY0BeSdY+yH9snD5Nnnq8GaMv3CU/gZQzT?=
 =?us-ascii?Q?nGVFHYgXTb0Cgpxc8bOiN/Vo6KPyMV+XQ6U1h5M1w0NYbKF00kRbPu3ohNrn?=
 =?us-ascii?Q?+egPoQAbl881WBwK9uWBSB6el5kuTRtTAc7VVICVwGTohqHjeji0IC3UECaJ?=
 =?us-ascii?Q?szgqKvC19c0eX/14HRO3WG30hQqp7MIf9U/qn4bvcjJST8JWb0eYUVMT50cG?=
 =?us-ascii?Q?gKWakhb1EpWMKv44fl887kM0xDntzrrbaacNsWQnbp33L70YSdYkXrAlP4Ns?=
 =?us-ascii?Q?u7Mkr1NsnVMhV0A0C05itaxyMePpczeM5vxFEVJxBqhCWZJr8bPFVRNUgemQ?=
 =?us-ascii?Q?EwN8UCG/mSxep5W8OP0m3TkvZpSrucXewF04uFjQ5gErM4ublp0TSfzkfCEp?=
 =?us-ascii?Q?IJsx86U8KbYpjG95uHLMk2ocWIz98KhFKXEDtTaQzAE1JGSXV57oehMr4lV2?=
 =?us-ascii?Q?R8gBvi1AhjJF78Q1zd2pDPM54AGO5bq+x2B5FZzyFa97rPdnlPydtYpUxxLg?=
 =?us-ascii?Q?FTGrkYX15MvxQRCfgOIu5VAAVzNzYukKf2JIfgSZJeTFQHAJzjTmDCsoSURP?=
 =?us-ascii?Q?+xpc1cKWSoYsM2Fid9ZcAppKp6+5puaTO6MP2qQ6JgQ0HPKmlQXV6HrCjXb7?=
 =?us-ascii?Q?uDQ/zKP3KhiEmOwSWeqy7JuQSMUL4pSIEU7OndKZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3164.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c849a58-bb61-4394-63ea-08da926dd2b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 14:16:01.0162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XiXcWhhRxp9338TgEGQRmIxHlHkk+X9u1synAT2heyXKzRLetFY4vR7pgPliSJCPc6gCXLfXIVOQ18nl9Szb2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Aug 24, 2022 at 07:39:46PM +0000, Petlozu Pravareshwar wrote:
> > >
> > > On Wed, Aug 17, 2022 at 06:44:56PM +0000, Petlozu Pravareshwar wrote:
> > > > During PMC probe, print previous reset related info such as reset
> > > > reason and reset level.
> > > >
> > > > Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> > > > ---
> > > >  drivers/soc/tegra/pmc.c | 27 +++++++++++++++++++++++++++
> > > >  1 file changed, 27 insertions(+)
> > >
> > > We already expose this information in sysfs, why do we need to print
> > > it during boot?
> > >
> > > Thierry
> > There are some tests which would parse the boot log for this informatio=
n.
> > But I agree, since we are already providing this information through
> > sysfs, there is no need to print it during boot.
>=20
> It'd be a good idea to transition the tests to try and obtain this inform=
ation
> through sysfs first and if that fails they could fall back to using the b=
oot log.
> Although to be honest, I think we've supported this sysfs interface for l=
ong
> enough that we probably don't have to worry about a fallback.
>=20
> Thierry
Agree. Transitioning the tests to obtain the information through sysfs look=
s
good to me. I think this change can be discarded as printing the info in th=
e
boot log is no longer needed.

Thanks.
