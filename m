Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D2B6928F1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjBJVIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjBJVIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:08:18 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2063.outbound.protection.outlook.com [40.107.6.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6847D3C3;
        Fri, 10 Feb 2023 13:08:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfpsdPXrsgiqWrdxWjx/L0RND8Qv8scPnJHsKuuM6kGkd3U2eZuK5vpbwtpYGequ1xgfXV37aiqZ0lhIeiH/2H8WqbKrjCbi1GC2OtgB+xFT/XavAOo9+yGmdg+2Gh0UGDVIPDtw0NCr940GSCpV/tnqFJW8jtE3u8w+Myryjn7B4K+JvF2OFrbpqj5Udrei6uDmC1A6IOhi6Vw/fHUnrZFgxLADQ7h/ncLLUhPY9aa5jBI43Qnp/r5vXaW7mEwZJaeuLQbrfNVOfJEghEruHaU/5zdrTo5M1yCjRE2uTFXo23WkwIaUQHaHxOG1amCIPonDhAIxPGLsXSGclEOXnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpBG8hjVByG8iQSOKT2IQyFOaoe6ZdOc0e6DW+/xaNY=;
 b=J/PRofEy7SwS7n4nxMIHPAgIkVKIHo0jLj44Ua6I5nodTO2IPcLAQ9qr3B07YcG6erhMaudzXVzjMwtccMrVQKt5QrpWF50HnouFwU7LQwIlpYV4V8nSKKZrlvPuoDgcUGayqg6gjw/EnLf2f7nqYXcqprIcCi09Rgd+wriD/6RLJCd0WHftlMeOJSmn9LFjpWcferOIrf6t0kSQcWoMwXcJ7gyd0aA7Pl2n/yX7sVp1vJMj4Hsm1ltlsG44VYWE4fSCgkaSQMdaiI3vP/Vz0wMWGyIfj+vOcCXQY+VLwmCpmopPGb1NyC2s+B4P2WmXALuSiVnJqr6XfhpBtYmIqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpBG8hjVByG8iQSOKT2IQyFOaoe6ZdOc0e6DW+/xaNY=;
 b=E1evzYLgdqQ38VLcF/MUVYjEUdZryQ/hej5K64o8ZoCTSNUbBN9i/iJj7aYUGM7LoB/e8Q0tUpqnirBz+lmasXxHKgDzKa20HmjoIVKkC5Q3dnPJabEIwjBz8ja9GFO7Mos3R9OWcf78h1VIDi0IBwoWF0voxsmrfaoCDUWMVlw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by AM9PR04MB7651.eurprd04.prod.outlook.com (2603:10a6:20b:280::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 21:08:12 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::3cfb:3ae7:1686:a68b]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::3cfb:3ae7:1686:a68b%4]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 21:08:11 +0000
Date:   Fri, 10 Feb 2023 23:08:04 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxim Kiselev <bigunclemax@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 00/12] fw_devlink improvements
Message-ID: <20230210210804.vdyfrog5nq6hrxi5@skbuf>
References: <20230207014207.1678715-1-saravanak@google.com>
 <20230210101333.h2e7hcl3ylsoh6fy@skbuf>
 <CAGETcx_SQJ1q_f8r+zKATF-EEb0P-T_ot15AQ1x1Vc_3h=XfCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx_SQJ1q_f8r+zKATF-EEb0P-T_ot15AQ1x1Vc_3h=XfCw@mail.gmail.com>
X-ClientProxiedBy: AM4PR05CA0006.eurprd05.prod.outlook.com (2603:10a6:205::19)
 To VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5136:EE_|AM9PR04MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: d66a0e63-c040-492d-5c56-08db0baaeaaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HtlxEYg67LYrOZ4shxwKSsge7aqsPb6weuQZYI3uEqRVgXeo3Pm2VTiM+6UmvS8ad5FcLK02om9j9XhrZOmsaM4qhv5wDjpXHupvD0q2vEjTuksYOPcP1WdS0pMJvgGPMZuhO+BSTSM53XW+T+cP8ssOMhZiBJ5bEG9WTh7QLm2/dU3vBHEJRTQKfWp9sEwp4nMLs/qjgjgY3qZOaFmSAlDLpIGXylamFVQAu6f+PFIcBARkBmpSoJ93K7TtIn+7Dx3x2aMS17vSX4eTbHbykdqOaKD1WS0v+F2P8WpkON6DHiGZQFK9vsld3ClkYpMdlAPnB/lIKLgCE9EX+WzLmnenDqjHTqBY5NibGPEVZI22zfsRpnXdNNLRxFBWLPKOezKqIV+c5NooKEPxFD7okme0GUsvIm9U9u0Wwd0jsJed3tdQW7DsawoCwpSiE6So+TXp7VOOYbBJvnqw4z2pG4gUAY4ILjoszEL154kdjJC+EfnYxB99aDXIMdkLjD2XWdYlnCbF0rh+0a8XerAsLhOA3ShpLZKalo2OXTjO4RsQFNnteLc3qH11bXKI6lZqMU8I/Alim9Vnx8I6WJ5VtbFiAzH3bsQTAM99boBULFYc7WgBVtsM8YGCbV+OXNyTcgWm/71iS5xYHmB4aakESW+vhrOlz5opmDb+XsKTfw4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199018)(66476007)(7406005)(186003)(9686003)(8676002)(66946007)(7416002)(8936002)(6512007)(66556008)(6506007)(1076003)(4326008)(6916009)(86362001)(26005)(33716001)(38100700002)(5660300002)(66574015)(2906002)(53546011)(478600001)(316002)(6486002)(966005)(54906003)(44832011)(41300700001)(6666004)(30864003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVVrdXRxTzFjdmhRZXBhOFZOMXNCRTJGZDhpbmYyU1NuVEhnZStBOG5yb2Qw?=
 =?utf-8?B?RkJJQjlicHNzNm5oNVlvVHk3b3ovekJleUpYZ3RONmRIQmpRVFJlV1JPZkZZ?=
 =?utf-8?B?VTVKS2VnekUveEMwZEQ0aVVTdWxvRzJWVGNSbG9XY3EzN0pscitlSW5rZDZI?=
 =?utf-8?B?NG84SktmRGx3WTkwZkJLSElOaXZ5YTgvVUFiNmdTV0ozWW5JSFVPOW1MaHRo?=
 =?utf-8?B?ajAxUHdlbWNTaGkyN0NiS3piQTVEY1pTdy9SbThJZE1UVHBYaUcvSE5oWTNX?=
 =?utf-8?B?UG1hbWNHdW5Qbk9WWmVERXNraGpiZ2h0SW82NS8xZHBXZGUvTUNObFZ5Qmpj?=
 =?utf-8?B?MkxsdHRVWjVCQnhSOG5rbmdVS3dySkVSN3BZS0Q2YktwVk1hYjdlb2J1MGhX?=
 =?utf-8?B?VnRJSm04dzEzZ3h0dWJheWMzWkdjbmRhZWxITldqdDF0YWtSSTdDYklWeXE3?=
 =?utf-8?B?VnBTaDNscEpDUXdlRTVsWXR2cG5zZWJ6UkozS3B2LzZ5L1JPTTdGRHpDTWtt?=
 =?utf-8?B?eW5UWTVQVUcwYm9iTzAzSlVsNzYrRXROb0I5RXlRMHZEajUvZ2YzdHBvMitY?=
 =?utf-8?B?dlpBQUMrNlJBN2V2b3loNkdzcER2eEhXa3hNZ2EzNk5pSWhRYmhLWStpaWtZ?=
 =?utf-8?B?aHl3QWVESW1MMnJpMXpOeUdnRmQ2bVhuajd2ZGFGNTR6SFJRRmVuek5IYndI?=
 =?utf-8?B?Y3c4QnNTc1M5YzlxTUdGLy9TU09VZnZrYVI1L2dNZk83bHNDejNWd1VYbGV3?=
 =?utf-8?B?M1hmOEJRMDNOVi9FYlRvd2ZKZ0pBZG53STNUSkRJWm1aVmtyOEpwYzNnQTRN?=
 =?utf-8?B?T0p5Y2JwZnp2bnduZkwrcVAyV25sanpadXZGMllOOGZGOFdpc1o4V1hOZjJi?=
 =?utf-8?B?YUtIcklIWlY0dEY4RUwzTzhyUUlsdVhLMThMWVk0bmpZK0VMak9KYnFkaDh2?=
 =?utf-8?B?a3ZwUktOVTE5Zk91Nm9DZEgxSndaWWh5UmlXTDJoVTBqa0RrUlBMTWNNQzBL?=
 =?utf-8?B?Umd6UWpuVnI5VDJUSW0wRkJJR1gzdFpLUDhwMFk2VE5vUnRIYnZ1NENZZFJl?=
 =?utf-8?B?M200Y3RoalNqOVBFY2dBNzYrNVJEekFYQUtOK1dBaEZUNk1uTnRGRWU2Wk5O?=
 =?utf-8?B?MGdHbHcxOEZFU1NnYVBabm5jZThtNHd5L0FGdldBdm5BdFI5VDdQc0dsNkJi?=
 =?utf-8?B?KzRVdGJuSXZKbHZITTZ6NXlaUUNRMjNMbGc3TjdKcmhrUDZGdFQvS2QrTi9W?=
 =?utf-8?B?WFhPL2VIV1ZBbVBFM3VWd1N3L3dCaTZSTHhlTnJhcTBzdjc3cWlCTm0rZFl5?=
 =?utf-8?B?b1d1WVppZXBWazBMWWZhQzVMRjdWVjBJRVlGb1VaUlpqMlgxUlg2aGdPQ0Va?=
 =?utf-8?B?alV2NXVteXpnYUVRcVpvc0Nza3J0MUNqVHlRVkFqOFhCd2JCeWsxTUljUjFK?=
 =?utf-8?B?TnJ1WSsrWVhxQ3JXMEhibW9kMkdJRzRvUXdvVGw1Skd3N0lkWlpKK0xiNVhN?=
 =?utf-8?B?VkdMRFJOcld5cUlFRkZ2VW5vZU02U2NEK2k1V3dCMkljeEZ0QVhWS0JLK1Zz?=
 =?utf-8?B?N1dPeEhKVDRVdE1Gc0RmV3dnY2hnQVZWUldtKzBiV29kazNHbVFlWCsra05R?=
 =?utf-8?B?RUdESEFHRGxDMHBzNGdBaEtIR0s2SlBnSW5XR0NEZStDbTgvN2VNazhLaldH?=
 =?utf-8?B?WndYbW5EMmM3R2JNZVRna3FmNDVNY3BVdUo1VWRZNzY4SGlPZXdVcUdhVU53?=
 =?utf-8?B?RURBM3RuUEExOWd2TGMyOTduWGVIZmcvTjBCTUdkQkRJeXhmU1J6bGRWTEJH?=
 =?utf-8?B?Nlp0VGpwNlBtNXNWK0g3MFU2eDRwazB3eUxNa05rYWFvTng1WUdBWG5Ldy93?=
 =?utf-8?B?VlNLNHJCT0FoY3FiNGpBQ2phNHdsL1lROEttNy90Kzh4N1NkWXNqQk9uMGdx?=
 =?utf-8?B?NDU5Y2V6dnU1cDREQlo1V0toM3JVdlhVbWRLbnZYS2VJb1ZKSHFwNG50Y3Jt?=
 =?utf-8?B?NWFaVW5vQ3E2cnFsZGtoR1h4T1o3V3crVGc4d2Y5VTl5VzUxQ1B5VFNhTWVy?=
 =?utf-8?B?dkVnNkR4ZTVVcjRVbUtRUEgvdWQzQldISDVONmxkRndja1ZiZGtFemZ1R3dh?=
 =?utf-8?B?dHR0NTdTOW5BZHhMcThudjJHdzYrUjBnTVREc0xRaXJuOHJqbXNLdlZpUUJO?=
 =?utf-8?B?Z1E9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d66a0e63-c040-492d-5c56-08db0baaeaaf
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 21:08:11.5107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwUY7+XWwsSJzZ3WjR7o2RF/+qQ5Bvy7FuIwLbA6PcsggkzNYZg1s6jTPna1nggEM/myfSao6CdnnzfKMJRR7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7651
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 11:27:11AM -0800, Saravana Kannan wrote:
> On Fri, Feb 10, 2023 at 2:13 AM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> >
> > Hi Saravana,
> >
> > On Mon, Feb 06, 2023 at 05:41:52PM -0800, Saravana Kannan wrote:
> > > Vladimir,
> > >
> > > Ccing you because DSA's and fw_devlink have known/existing problems
> > > (still in my TODOs to fix). But I want to make sure this series doesn't
> > > cause additional problems for DSA.
> > >
> > > All,
> > >
> > > This patch series improves fw_devlink in the following ways:
> > >
> > > 1. It no longer cares about a fwnode having a "compatible" property. It
> > >    figures this out more dynamically. The only expectation is that
> > >    fwnodes that are converted to devices actually get probed by a driver
> > >    for the dependencies to be enforced correctly.
> > >
> > > 2. Finer grained dependency tracking. fw_devlink will now create device
> > >    links from the consumer to the actual resource's device (if it has one,
> > >    Eg: gpio_device) instead of the parent supplier device. This improves
> > >    things like async suspend/resume ordering, potentially remove the need
> > >    for frameworks to create device links, more parallelized async probing,
> > >    and better sync_state() tracking.
> > >
> > > 3. Handle hardware/software quirks where a child firmware node gets
> > >    populated as a device before its parent firmware node AND actually
> > >    supplies a non-optional resource to the parent firmware node's
> > >    device.
> > >
> > > 4. Way more robust at cycle handling (see patch for the insane cases).
> > >
> > > 5. Stops depending on OF_POPULATED to figure out some corner cases.
> > >
> > > 6. Simplifies the work that needs to be done by the firmware specific
> > >    code.
> > >
> > > The v3 series has gone through my usual testing on my end and looks good
> > > to me.
> >
> > Booted on an NXP LS1028A (arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts)
> > and a Turris MOX (arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts)
> > with no observed regressions.
> 
> Thanks for testing Vladimir!
> 
> > Is there something specific you would like
> > me to test?
> 
> Not really, I just want to make sure the common DSA architectures
> don't hit any regression. In the hardware you tested, are there cases
> of PHYs where the supplier is the parent MDIO? I remember that being
> the only case where I needed special casing
> (FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD) in fw_devlink -- so it'll be
> good to make sure I didn't accidentally break anything there.
> 
> -Saravana

Yes and no (I never had a system which depended on FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD).

Yes, because well, yes, in arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts,
the PHYs will depend on interrupts provided by their (parent) switch. However this
is not explicit in the device tree. To make it explicit, one would need to add:

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index cd0988317623..d789cda49e35 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -305,12 +305,14 @@ phy1: ethernet-phy@1 {
 	};
 
 	/* switch nodes are enabled by U-Boot if modules are present */
-	switch0@10 {
+	switch0_peridot: switch0@10 {
 		compatible = "marvell,mv88e6190";
 		reg = <0x10>;
 		dsa,member = <0 0>;
 		interrupt-parent = <&moxtet>;
 		interrupts = <MOXTET_IRQ_PERIDOT(0)>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
 		status = "disabled";
 
 		mdio {
@@ -319,34 +321,42 @@ mdio {
 
 			switch0phy1: switch0phy1@1 {
 				reg = <0x1>;
+				interrupts-extended = <&switch0_peridot 1 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch0phy2: switch0phy2@2 {
 				reg = <0x2>;
+				interrupts-extended = <&switch0_peridot 2 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch0phy3: switch0phy3@3 {
 				reg = <0x3>;
+				interrupts-extended = <&switch0_peridot 3 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch0phy4: switch0phy4@4 {
 				reg = <0x4>;
+				interrupts-extended = <&switch0_peridot 4 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch0phy5: switch0phy5@5 {
 				reg = <0x5>;
+				interrupts-extended = <&switch0_peridot 5 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch0phy6: switch0phy6@6 {
 				reg = <0x6>;
+				interrupts-extended = <&switch0_peridot 6 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch0phy7: switch0phy7@7 {
 				reg = <0x7>;
+				interrupts-extended = <&switch0_peridot 7 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch0phy8: switch0phy8@8 {
 				reg = <0x8>;
+				interrupts-extended = <&switch0_peridot 8 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
@@ -430,12 +440,14 @@ port-sfp@a {
 		};
 	};
 
-	switch0@2 {
+	switch0_topaz: switch0@2 {
 		compatible = "marvell,mv88e6085";
 		reg = <0x2>;
 		dsa,member = <0 0>;
 		interrupt-parent = <&moxtet>;
 		interrupts = <MOXTET_IRQ_TOPAZ>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
 		status = "disabled";
 
 		mdio {
@@ -444,18 +456,22 @@ mdio {
 
 			switch0phy1_topaz: switch0phy1@11 {
 				reg = <0x11>;
+				interrupts-extended = <&switch0_topaz 0x11 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch0phy2_topaz: switch0phy2@12 {
 				reg = <0x12>;
+				interrupts-extended = <&switch0_topaz 0x12 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch0phy3_topaz: switch0phy3@13 {
 				reg = <0x13>;
+				interrupts-extended = <&switch0_topaz 0x13 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch0phy4_topaz: switch0phy4@14 {
 				reg = <0x14>;
+				interrupts-extended = <&switch0_topaz 0x14 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
@@ -497,12 +513,14 @@ port@5 {
 		};
 	};
 
-	switch1@11 {
+	switch1_peridot: switch1@11 {
 		compatible = "marvell,mv88e6190";
 		reg = <0x11>;
 		dsa,member = <0 1>;
 		interrupt-parent = <&moxtet>;
 		interrupts = <MOXTET_IRQ_PERIDOT(1)>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
 		status = "disabled";
 
 		mdio {
@@ -511,34 +529,42 @@ mdio {
 
 			switch1phy1: switch1phy1@1 {
 				reg = <0x1>;
+				interrupts-extended = <&switch1_peridot 1 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch1phy2: switch1phy2@2 {
 				reg = <0x2>;
+				interrupts-extended = <&switch1_peridot 2 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch1phy3: switch1phy3@3 {
 				reg = <0x3>;
+				interrupts-extended = <&switch1_peridot 3 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch1phy4: switch1phy4@4 {
 				reg = <0x4>;
+				interrupts-extended = <&switch1_peridot 4 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch1phy5: switch1phy5@5 {
 				reg = <0x5>;
+				interrupts-extended = <&switch1_peridot 5 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch1phy6: switch1phy6@6 {
 				reg = <0x6>;
+				interrupts-extended = <&switch1_peridot 6 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch1phy7: switch1phy7@7 {
 				reg = <0x7>;
+				interrupts-extended = <&switch1_peridot 7 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch1phy8: switch1phy8@8 {
 				reg = <0x8>;
+				interrupts-extended = <&switch1_peridot 8 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
@@ -622,12 +648,14 @@ port-sfp@a {
 		};
 	};
 
-	switch1@2 {
+	switch1_topaz: switch1@2 {
 		compatible = "marvell,mv88e6085";
 		reg = <0x2>;
 		dsa,member = <0 1>;
 		interrupt-parent = <&moxtet>;
 		interrupts = <MOXTET_IRQ_TOPAZ>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
 		status = "disabled";
 
 		mdio {
@@ -636,18 +664,22 @@ mdio {
 
 			switch1phy1_topaz: switch1phy1@11 {
 				reg = <0x11>;
+				interrupts-extended = <&switch1_topaz 0x11 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch1phy2_topaz: switch1phy2@12 {
 				reg = <0x12>;
+				interrupts-extended = <&switch1_topaz 0x12 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch1phy3_topaz: switch1phy3@13 {
 				reg = <0x13>;
+				interrupts-extended = <&switch1_topaz 0x13 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch1phy4_topaz: switch1phy4@14 {
 				reg = <0x14>;
+				interrupts-extended = <&switch1_topaz 0x14 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
@@ -689,12 +721,14 @@ port@5 {
 		};
 	};
 
-	switch2@12 {
+	switch2_peridot: switch2@12 {
 		compatible = "marvell,mv88e6190";
 		reg = <0x12>;
 		dsa,member = <0 2>;
 		interrupt-parent = <&moxtet>;
 		interrupts = <MOXTET_IRQ_PERIDOT(2)>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
 		status = "disabled";
 
 		mdio {
@@ -703,34 +737,42 @@ mdio {
 
 			switch2phy1: switch2phy1@1 {
 				reg = <0x1>;
+				interrupts-extended = <&switch2_peridot 1 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch2phy2: switch2phy2@2 {
 				reg = <0x2>;
+				interrupts-extended = <&switch2_peridot 2 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch2phy3: switch2phy3@3 {
 				reg = <0x3>;
+				interrupts-extended = <&switch2_peridot 3 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch2phy4: switch2phy4@4 {
 				reg = <0x4>;
+				interrupts-extended = <&switch2_peridot 4 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch2phy5: switch2phy5@5 {
 				reg = <0x5>;
+				interrupts-extended = <&switch2_peridot 5 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch2phy6: switch2phy6@6 {
 				reg = <0x6>;
+				interrupts-extended = <&switch2_peridot 6 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch2phy7: switch2phy7@7 {
 				reg = <0x7>;
+				interrupts-extended = <&switch2_peridot 7 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch2phy8: switch2phy8@8 {
 				reg = <0x8>;
+				interrupts-extended = <&switch2_peridot 8 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
@@ -805,12 +847,14 @@ port-sfp@a {
 		};
 	};
 
-	switch2@2 {
+	switch2_topaz: switch2@2 {
 		compatible = "marvell,mv88e6085";
 		reg = <0x2>;
 		dsa,member = <0 2>;
 		interrupt-parent = <&moxtet>;
 		interrupts = <MOXTET_IRQ_TOPAZ>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
 		status = "disabled";
 
 		mdio {
@@ -819,18 +863,22 @@ mdio {
 
 			switch2phy1_topaz: switch2phy1@11 {
 				reg = <0x11>;
+				interrupts-extended = <&switch2_topaz 0x11 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch2phy2_topaz: switch2phy2@12 {
 				reg = <0x12>;
+				interrupts-extended = <&switch2_topaz 0x12 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch2phy3_topaz: switch2phy3@13 {
 				reg = <0x13>;
+				interrupts-extended = <&switch2_topaz 0x13 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			switch2phy4_topaz: switch2phy4@14 {
 				reg = <0x14>;
+				interrupts-extended = <&switch2_topaz 0x14 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 

However, as I had explained in one of the first discussions here:
https://lore.kernel.org/netdev/20210901012826.iuy2bhvkrgahhrl7@skbuf/

it was always hit-or-miss whether the above device tree had an issue
with fw_devlink or not: it depended on how the driver was written (and
the mv88e6xxx switch driver was tricking the fw_devlink logic from that
time to drop the device links because of an unrelated -EPROBE_DEFER).

What I had done to "untrick" fw_devlink so that I could see the issue
(which was originally reported by Alvin Šipraga) was to modify the
mv88e6xxx driver, and change the placement of mv88e6xxx_mdios_register()
to a point after which we will never hit -EPROBE_DEFER (from driver probe()
to the dsa_switch_ops :: setup() method):

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 0a5d6c7bb128..48650465660d 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3672,11 +3672,18 @@ static int mv88e6390_setup_errata(struct mv88e6xxx_chip *chip)
 	return mv88e6xxx_software_reset(chip);
 }
 
+static int mv88e6xxx_mdios_register(struct mv88e6xxx_chip *chip,
+				    struct device_node *np);
+static void mv88e6xxx_mdios_unregister(struct mv88e6xxx_chip *chip);
+
 static void mv88e6xxx_teardown(struct dsa_switch *ds)
 {
+	struct mv88e6xxx_chip *chip = ds->priv;
+
 	mv88e6xxx_teardown_devlink_params(ds);
 	dsa_devlink_resources_unregister(ds);
 	mv88e6xxx_teardown_devlink_regions_global(ds);
+	mv88e6xxx_mdios_unregister(chip);
 }
 
 static int mv88e6xxx_setup(struct dsa_switch *ds)
@@ -3686,6 +3693,10 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 	int err;
 	int i;
 
+	err = mv88e6xxx_mdios_register(chip, chip->dev->of_node);
+	if (err)
+		return err;
+
 	chip->ds = ds;
 	ds->slave_mii_bus = mv88e6xxx_default_mdio_bus(chip);
 
@@ -3811,8 +3822,10 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 unlock:
 	mv88e6xxx_reg_unlock(chip);
 
-	if (err)
+	if (err) {
+		mv88e6xxx_mdios_unregister(chip);
 		return err;
+	}
 
 	/* Have to be called without holding the register lock, since
 	 * they take the devlink lock, and we later take the locks in
@@ -3837,6 +3850,7 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 	mv88e6xxx_teardown_devlink_params(ds);
 out_resources:
 	dsa_devlink_resources_unregister(ds);
+	mv88e6xxx_mdios_unregister(chip);
 
 	return err;
 }
@@ -7220,18 +7234,12 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 	if (err)
 		goto out_g1_atu_prob_irq;
 
-	err = mv88e6xxx_mdios_register(chip, np);
-	if (err)
-		goto out_g1_vtu_prob_irq;
-
 	err = mv88e6xxx_register_switch(chip);
 	if (err)
-		goto out_mdio;
+		goto out_g1_vtu_prob_irq;
 
 	return 0;
 
-out_mdio:
-	mv88e6xxx_mdios_unregister(chip);
 out_g1_vtu_prob_irq:
 	mv88e6xxx_g1_vtu_prob_irq_free(chip);
 out_g1_atu_prob_irq:
@@ -7268,7 +7276,6 @@ static void mv88e6xxx_remove(struct mdio_device *mdiodev)
 
 	mv88e6xxx_phy_destroy(chip);
 	mv88e6xxx_unregister_switch(chip);
-	mv88e6xxx_mdios_unregister(chip);
 
 	mv88e6xxx_g1_vtu_prob_irq_free(chip);
 	mv88e6xxx_g1_atu_prob_irq_free(chip);

After applying both of the above changes on top of yours, I confirm that
the PHYs on the mv88e6xxx on Turris MOX still probe with their specific
PHY driver rather than the generic one, and with interrupts (not poll mode):

[    6.125894] mv88e6085 d0032004.mdio-mii:11 lan9 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch1@11!mdio:01] driver [Marvell 88E6390 Family] (irq=49)
[    6.222024] mv88e6085 d0032004.mdio-mii:11 lan10 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch1@11!mdio:02] driver [Marvell 88E6390 Family] (irq=50)
[    6.277554] mv88e6085 d0032004.mdio-mii:11 lan11 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch1@11!mdio:03] driver [Marvell 88E6390 Family] (irq=51)
[    6.361556] mv88e6085 d0032004.mdio-mii:11 lan12 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch1@11!mdio:04] driver [Marvell 88E6390 Family] (irq=52)
[    6.445574] mv88e6085 d0032004.mdio-mii:11 lan13 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch1@11!mdio:05] driver [Marvell 88E6390 Family] (irq=53)
[    6.529560] mv88e6085 d0032004.mdio-mii:11 lan14 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch1@11!mdio:06] driver [Marvell 88E6390 Family] (irq=54)
[    6.589555] mv88e6085 d0032004.mdio-mii:11 lan15 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch1@11!mdio:07] driver [Marvell 88E6390 Family] (irq=55)
[    6.673559] mv88e6085 d0032004.mdio-mii:11 lan16 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch1@11!mdio:08] driver [Marvell 88E6390 Family] (irq=56)
[    6.733558] mv88e6085 d0032004.mdio-mii:12 lan17 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch2@12!mdio:01] driver [Marvell 88E6390 Family] (irq=74)
[    6.817557] mv88e6085 d0032004.mdio-mii:12 lan18 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch2@12!mdio:02] driver [Marvell 88E6390 Family] (irq=75)
[    6.889628] mv88e6085 d0032004.mdio-mii:12 lan19 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch2@12!mdio:03] driver [Marvell 88E6390 Family] (irq=76)
[    6.973593] mv88e6085 d0032004.mdio-mii:12 lan20 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch2@12!mdio:04] driver [Marvell 88E6390 Family] (irq=77)
[    7.057572] mv88e6085 d0032004.mdio-mii:12 lan21 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch2@12!mdio:05] driver [Marvell 88E6390 Family] (irq=78)
[    7.109547] mv88e6085 d0032004.mdio-mii:12 lan22 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch2@12!mdio:06] driver [Marvell 88E6390 Family] (irq=79)
[    7.193553] mv88e6085 d0032004.mdio-mii:12 lan23 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch2@12!mdio:07] driver [Marvell 88E6390 Family] (irq=80)
[    7.277550] mv88e6085 d0032004.mdio-mii:12 lan24 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch2@12!mdio:08] driver [Marvell 88E6390 Family] (irq=81)
[    7.365556] mv88e6085 d0032004.mdio-mii:10 lan1 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch0@10!mdio:01] driver [Marvell 88E6390 Family] (irq=109)
[    7.421549] mv88e6085 d0032004.mdio-mii:10 lan2 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch0@10!mdio:02] driver [Marvell 88E6390 Family] (irq=110)
[    7.505554] mv88e6085 d0032004.mdio-mii:10 lan3 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch0@10!mdio:03] driver [Marvell 88E6390 Family] (irq=111)
[    7.589571] mv88e6085 d0032004.mdio-mii:10 lan4 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch0@10!mdio:04] driver [Marvell 88E6390 Family] (irq=112)
[    7.673560] mv88e6085 d0032004.mdio-mii:10 lan5 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch0@10!mdio:05] driver [Marvell 88E6390 Family] (irq=113)
[    7.733547] mv88e6085 d0032004.mdio-mii:10 lan6 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch0@10!mdio:06] driver [Marvell 88E6390 Family] (irq=114)
[    7.817555] mv88e6085 d0032004.mdio-mii:10 lan7 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch0@10!mdio:07] driver [Marvell 88E6390 Family] (irq=115)
[    7.901572] mv88e6085 d0032004.mdio-mii:10 lan8 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch0@10!mdio:08] driver [Marvell 88E6390 Family] (irq=116)

even though I am seeing these error messages earlier in the boot process (maybe this is something to look into):

[    0.910219] mdio_bus d0032004.mdio-mii:10: Failed to create device link with d0032004.mdio-mii:10
[    0.910228] mdio_bus d0032004.mdio-mii:10: Failed to create device link with d0032004.mdio-mii:10
[    0.910237] mdio_bus d0032004.mdio-mii:10: Failed to create device link with d0032004.mdio-mii:10
[    0.910244] mdio_bus d0032004.mdio-mii:10: Failed to create device link with d0032004.mdio-mii:10
[    0.910251] mdio_bus d0032004.mdio-mii:10: Failed to create device link with d0032004.mdio-mii:10
[    0.910259] mdio_bus d0032004.mdio-mii:10: Failed to create device link with d0032004.mdio-mii:10
[    0.910266] mdio_bus d0032004.mdio-mii:10: Failed to create device link with d0032004.mdio-mii:10
[    0.910273] mdio_bus d0032004.mdio-mii:10: Failed to create device link with d0032004.mdio-mii:10
[    0.910936] mv88e6085 d0032004.mdio-mii:10: switch 0x3900 detected: Marvell 88E6390, revision 1
[    0.928360] mdio_bus d0032004.mdio-mii:11: Failed to create device link with d0032004.mdio-mii:11
[    0.928380] mdio_bus d0032004.mdio-mii:11: Failed to create device link with d0032004.mdio-mii:11
[    0.928388] mdio_bus d0032004.mdio-mii:11: Failed to create device link with d0032004.mdio-mii:11
[    0.928396] mdio_bus d0032004.mdio-mii:11: Failed to create device link with d0032004.mdio-mii:11
[    0.928403] mdio_bus d0032004.mdio-mii:11: Failed to create device link with d0032004.mdio-mii:11
[    0.928410] mdio_bus d0032004.mdio-mii:11: Failed to create device link with d0032004.mdio-mii:11
[    0.928418] mdio_bus d0032004.mdio-mii:11: Failed to create device link with d0032004.mdio-mii:11
[    0.928425] mdio_bus d0032004.mdio-mii:11: Failed to create device link with d0032004.mdio-mii:11
[    0.928993] mv88e6085 d0032004.mdio-mii:11: switch 0x1900 detected: Marvell 88E6190, revision 1
[    0.943306] mdio_bus d0032004.mdio-mii:12: Failed to create device link with d0032004.mdio-mii:12
[    0.943327] mdio_bus d0032004.mdio-mii:12: Failed to create device link with d0032004.mdio-mii:12
[    0.943334] mdio_bus d0032004.mdio-mii:12: Failed to create device link with d0032004.mdio-mii:12
[    0.943342] mdio_bus d0032004.mdio-mii:12: Failed to create device link with d0032004.mdio-mii:12
[    0.943349] mdio_bus d0032004.mdio-mii:12: Failed to create device link with d0032004.mdio-mii:12
[    0.943357] mdio_bus d0032004.mdio-mii:12: Failed to create device link with d0032004.mdio-mii:12
[    0.943364] mdio_bus d0032004.mdio-mii:12: Failed to create device link with d0032004.mdio-mii:12
[    0.943371] mdio_bus d0032004.mdio-mii:12: Failed to create device link with d0032004.mdio-mii:12
[    0.943879] mv88e6085 d0032004.mdio-mii:12: switch 0x1900 detected: Marvell 88E6190, revision 1


If _on top_ of all the above, I also remove the logic that sets FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD:

 drivers/net/phy/mdio_bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 00d5bcdf0e6f..4d4c42771d37 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -665,9 +665,9 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 	if (!bus->read && !bus->read_c45)
 		return -EINVAL;
 
-	if (bus->parent && bus->parent->of_node)
-		bus->parent->of_node->fwnode.flags |=
-					FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD;
+//	if (bus->parent && bus->parent->of_node)
+//		bus->parent->of_node->fwnode.flags |=
+//					FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD;
 
 	WARN(bus->state != MDIOBUS_ALLOCATED &&
 	     bus->state != MDIOBUS_UNREGISTERED,

then *finally* I get something approximating Alvin's reported issue.
In my case, one switch out of 3 gets its PHYs bound to the Generic PHY
driver (why not all is a story for another time):

[    6.106204] mv88e6085 d0032004.mdio-mii:11 lan9 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch1@11!mdio:01] driver [Marvell 88E6390 Family] (irq=49)
[    6.193561] mv88e6085 d0032004.mdio-mii:11 lan10 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch1@11!mdio:02] driver [Marvell 88E6390 Family] (irq=50)
[    6.249654] mv88e6085 d0032004.mdio-mii:11 lan11 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch1@11!mdio:03] driver [Marvell 88E6390 Family] (irq=51)
[    6.333580] mv88e6085 d0032004.mdio-mii:11 lan12 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch1@11!mdio:04] driver [Marvell 88E6390 Family] (irq=52)
[    6.417577] mv88e6085 d0032004.mdio-mii:11 lan13 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch1@11!mdio:05] driver [Marvell 88E6390 Family] (irq=53)
[    6.501561] mv88e6085 d0032004.mdio-mii:11 lan14 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch1@11!mdio:06] driver [Marvell 88E6390 Family] (irq=54)
[    6.561655] mv88e6085 d0032004.mdio-mii:11 lan15 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch1@11!mdio:07] driver [Marvell 88E6390 Family] (irq=55)
[    6.645583] mv88e6085 d0032004.mdio-mii:11 lan16 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch1@11!mdio:08] driver [Marvell 88E6390 Family] (irq=56)
[    6.733557] mv88e6085 d0032004.mdio-mii:12 lan17 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch2@12!mdio:01] driver [Marvell 88E6390 Family] (irq=74)
[    6.817563] mv88e6085 d0032004.mdio-mii:12 lan18 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch2@12!mdio:02] driver [Marvell 88E6390 Family] (irq=75)
[    6.873653] mv88e6085 d0032004.mdio-mii:12 lan19 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch2@12!mdio:03] driver [Marvell 88E6390 Family] (irq=76)
[    6.957582] mv88e6085 d0032004.mdio-mii:12 lan20 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch2@12!mdio:04] driver [Marvell 88E6390 Family] (irq=77)
[    7.041567] mv88e6085 d0032004.mdio-mii:12 lan21 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch2@12!mdio:05] driver [Marvell 88E6390 Family] (irq=78)
[    7.093561] mv88e6085 d0032004.mdio-mii:12 lan22 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch2@12!mdio:06] driver [Marvell 88E6390 Family] (irq=79)
[    7.177476] mv88e6085 d0032004.mdio-mii:12 lan23 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch2@12!mdio:07] driver [Marvell 88E6390 Family] (irq=80)
[    7.245560] mv88e6085 d0032004.mdio-mii:12 lan24 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch2@12!mdio:08] driver [Marvell 88E6390 Family] (irq=81)
[    7.269178] mv88e6085 d0032004.mdio-mii:10 lan1 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch0@10!mdio:01] driver [Generic PHY] (irq=POLL)
[    7.288234] mv88e6085 d0032004.mdio-mii:10 lan2 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch0@10!mdio:02] driver [Generic PHY] (irq=POLL)
[    7.307295] mv88e6085 d0032004.mdio-mii:10 lan3 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch0@10!mdio:03] driver [Generic PHY] (irq=POLL)
[    7.326342] mv88e6085 d0032004.mdio-mii:10 lan4 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch0@10!mdio:04] driver [Generic PHY] (irq=POLL)
[    7.345384] mv88e6085 d0032004.mdio-mii:10 lan5 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch0@10!mdio:05] driver [Generic PHY] (irq=POLL)
[    7.364449] mv88e6085 d0032004.mdio-mii:10 lan6 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch0@10!mdio:06] driver [Generic PHY] (irq=POLL)
[    7.383496] mv88e6085 d0032004.mdio-mii:10 lan7 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch0@10!mdio:07] driver [Generic PHY] (irq=POLL)
[    7.402563] mv88e6085 d0032004.mdio-mii:10 lan8 (uninitialized): PHY [!soc!internal-regs@d0000000!mdio@32004!switch0@10!mdio:08] driver [Generic PHY] (irq=POLL)

So I guess that FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD does something.

OTOH, if I apply just my patch to remove the FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD,
but without making the device tree change or the mv88e6xxx driver change, the PHYs
still probe with the correct driver and with interrupts (i.e. they don't get their
probing deferred). This also seems to prove my point that my patches to bring the
Turris MOX to a testable state for this fwnode flag are indeed required.

HTH.
