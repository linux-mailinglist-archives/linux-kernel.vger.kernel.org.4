Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42A8750CB4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjGLPic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbjGLPia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:38:30 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2121.outbound.protection.outlook.com [40.107.243.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715B11BD5;
        Wed, 12 Jul 2023 08:38:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXQhAvYr7cfydhS2DCn2rWq9PW7YjcZSaPfd/dZKpld32smwTW+T+TanNMvYduxB+qrLhGAicK/jHZJ4yFqgg3NHlYFcoIN+0OO33StrBfmmgp2fcGdssQgC/AgtX7/Bd4g+9thZr2uGBNlFNlg602Qg3OHZQJ8ntD8Iz5lSuFHr7z8kwWjzkejC87YWiVQT3zF1jx81YwvEK8d8rE5gGLDrw2sOZziCLGc1V0mA6ybuNpRsJai0R4h1asM8Le2m71org6TM/Vs/f4SmO2uxWJMiojXJi1zZ7q7XvouMkIVsLaLvysFuHYaNWEQzxISxXjmBo5ed7O6kFrNCCxcUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTw6IRD3xSiG5WMxt5smunU2lDoy2dUyZLPdLMagCUM=;
 b=NYgOlYzbe2Uj8ZzE+qmPoWeP8Z6ku3bULdedEORlNCNOjrvu1iaFpK1Y7FzOwtYt7r6fg/GDiS/8Qt/42/f0wCAwvLseol8YYgfXgA3cqOYTpUIGjE/6s8cKfX/LckxHzod6DdumD+8gAm5tVsV8ZMd+ICmkudmFhizAO11sR3KGP3t3li+oknOszIsGiOuU5rscFHjnMf5lFD4WNxK8qjfs5w/aXOkROIp4zpOE1b7cZfN2FtfWGTJU6cxzgIg6D+lqjxvYqn9P8ieDo5f7SKF/2DfAV6mTeUtGsNsvxz1dNoqjVivi16oHq+McngkLaQQQBSAEShb8I6UE9wJgUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTw6IRD3xSiG5WMxt5smunU2lDoy2dUyZLPdLMagCUM=;
 b=H5em6qWPO5QaHZBE3Rul4JX5mYOF4h/5fC1v8H2TcopuppzwRvXrTIjt/XEasu98grA5phwhLezz5O8rws/BFQ0tdBLS1Ys9hDz4PAwIbPmNeZruZbVqhuv5EFiUqI6clgOoUXU0F2if5cwhc8AP0FyOqKb0opxP+fWYEd00Mn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by PH7PR10MB6484.namprd10.prod.outlook.com
 (2603:10b6:510:1ef::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 15:38:22 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::f575:8f7d:c91:5078]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::f575:8f7d:c91:5078%6]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 15:38:22 +0000
Date:   Wed, 12 Jul 2023 08:38:16 -0700
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        UNGLinuxDriver@microchip.com,
        Daniel Machon <daniel.machon@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [RFC RESEND v1 pinctrl-next 0/1] add blink and activity
 functions to SGPIO
Message-ID: <ZK7I6P5QG0Ax1RmM@colin-ia-desktop>
References: <20230712022250.2319557-1-colin.foster@in-advantage.com>
 <64ae73ce.050a0220.fe1a6.4b8a@mx.google.com>
 <39b297b0-5266-4f4b-ade6-8ccb95e90411@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39b297b0-5266-4f4b-ade6-8ccb95e90411@lunn.ch>
X-ClientProxiedBy: SJ0PR03CA0135.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::20) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|PH7PR10MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: 0420b603-fa00-46c3-3f03-08db82ee05e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T42nY1xeI6S3NkdKsTqWMEHkR2qksYwcUg5wRAxrnNMen+QBFAm3F5QEi3ArgloX/HROeJPgAxTE7glmEYtpywhjPnFi/I75N+p4moycEsSJ7FTN4N6hmbByKtjIjfOoEr2r3S8mjxwMR6J2ptrhHnkjCdzQcn0mpF0kLgxhdin3SrXnfLeoyLnv/6p6OUySAUFoX2hiAUmMoWFW6qxtwS6Cj+EiR/vNX7pwOzhbtZlAaSDAcsh5PWQMrZbeoVQk54BTOOjccB6HrYXpN2WoFnTnCIwWChAiBP8O0P6j3do4HBWXwbKdUyizy8+/hHCp4mDr+pn7xpPMK6k0b/ZJZ7Z7ovefpgjXx4ji/NtcmA3SaCSdGmbVlqqLXE4QDQd58L6yQ60WrMJRU6eXWIBiDgNeCMuCrEbQtgayPLVzUxT4kazo7EwlVNkxz5QkxXKO7lVEAZBm7cluRJIVkNJkVSUywlnFnnaW6gj0/bEAf7DzdNLrckn58AhnjN+UIzT3x3EzrZ0NYeBa+E96nw5HFvD6DlX6AuxtJxumq7m1utzsD2uOCF+TytEXjRALxcik
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(136003)(366004)(346002)(396003)(39840400004)(451199021)(66899021)(478600001)(6486002)(6666004)(54906003)(83380400001)(86362001)(2906002)(66946007)(33716001)(186003)(6506007)(9686003)(6512007)(38100700002)(8676002)(26005)(316002)(4326008)(66476007)(5660300002)(8936002)(66556008)(6916009)(41300700001)(44832011)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hloRw0xzmxozY4RiYLGKUzXeAnnNNsQcW6aVmZ2Y53nZ7r7pz1q8VB9djBAH?=
 =?us-ascii?Q?wjjCOUeIxHtXZHsC6NpjIwUvrTar0FNZSSufN0phzfuovbv3VEmRh1v41S9X?=
 =?us-ascii?Q?XJ1XfmR23Sq1ovEosLAd1C3egh7ICYsoDOoVwzbxtmo97L4/oUoAWGDMmZbk?=
 =?us-ascii?Q?g1VQdjDgdtEzcDC21Dk8DBthdY/cNsIl9ox1RArIo/XDUlaHypRUz+AvWNGY?=
 =?us-ascii?Q?EDPRxYsktYoEJRpYu+zyKrFYQzQpeB9AXYU/NdQcpX3SKxRx7IKCToxD0vzs?=
 =?us-ascii?Q?hOj1ABFbxvxOMcI9VdOl//jGrvTvwkGw7sUBxmpVZHSCCDs0/XDpdSldu3JS?=
 =?us-ascii?Q?8THltZDNsej6twBMqtpJa+xOxYf6cOg8NFbRaDSzB/M4bQlJIPy5OP5Mwkm1?=
 =?us-ascii?Q?QHtGCGRjVdYD0s4xaOmz6DsDMvuVsFeUzzipHtxpjW1Qoip9fs4R7NgSVGUY?=
 =?us-ascii?Q?FWZ2EPzV+fB09JUe9u6VgWMMuhFHGlrDYRFrajVNEV0GlrDZ5tUFLtJZBKQ+?=
 =?us-ascii?Q?H0AhANXto0pCCTpHWMCHUj2/vkECiok5t5TBATfjW9SXYFy+TKO57RE0izuD?=
 =?us-ascii?Q?QIi9RxBag5BSDCp+p7HfQb/ysqb1dmNueJDpDRhlGPvGh3v/e/nxfhWsH/ax?=
 =?us-ascii?Q?kM8EYRZqqKmI25FQB8KDddg1hK9ZTyLq1dhHjRJjrwoEUE5koy2mZL56livP?=
 =?us-ascii?Q?P0qarhx0HFMejbueMooAh3Q+Tt5sPX0KwL3V70qVHHf+oILNOGO4VnmWncD4?=
 =?us-ascii?Q?egjHVk53HL7bJ64Vnkb9+IF8RzN8/Q8IFH/A3CGzpMXm1MgZWJoehMHJjjVY?=
 =?us-ascii?Q?6Wfm1YBnjAoG/lxr+yjPu6cwAlNayoVXrtMs2mFrYQinfaCm3saqRRggX1vT?=
 =?us-ascii?Q?maWA25cJBBO5t0LwBsmiIzgl0j+AL4ThmXrmFOhwrspmysECnqAtpiS+RQpV?=
 =?us-ascii?Q?SmOpjPgogtmFvIqCvENcudPf/y+LrPvCNNdHFDyBU61wPRmgLWZzXIvsFGDO?=
 =?us-ascii?Q?b6rlX1miOyr1aw3RNJ+s8/BdY18Ws5MrGXbagaBUWkPP1dGDfP0yP9goesDm?=
 =?us-ascii?Q?P42Lt1AeuZYkGl2Zd1cy0xun+eXhvBd+TYN2VdfOO6eP2RiOKsGrFksxEFeD?=
 =?us-ascii?Q?o7aTS5E1OmRIYdZAQpXFhXYjn0R3DkYcK3SG2+xoqpxQgHX9UDaUKyDUkqPS?=
 =?us-ascii?Q?iOrCfJWmw16ncRhvtYBfyLekb6mzXOYmQnkI/RHloYgIFzNSJHgyJ02zw20J?=
 =?us-ascii?Q?1rUUjPtnb9bqnWkAOy+y8uKsI3EtybnjaJ1KRwOUzi+8lCKVsTL0jKugc8Qh?=
 =?us-ascii?Q?YE7Kc/eAl2nC0DOKTujFmOENtxQlElFEfKNBo0b5r2nJpZipXxsCMBWZLsCX?=
 =?us-ascii?Q?h+ukV4ki+IhOK+z4m1UcO7aBnGqMLqb8dsNNMBD6fqmTXIiqovFM7G3WhCrx?=
 =?us-ascii?Q?uYpvc8T76hGJz/d2VnPeTNJk2Jt/H2QMUCljT3cIQl8/+r2IlHkottp9QArV?=
 =?us-ascii?Q?zgo4SLq1vEOXkc8hn35cXyAzuMFUlE7ieZtfYwXm2wyeWH1vC28g78zKzVVR?=
 =?us-ascii?Q?cbvEUEluwi9YCze10RJWb0RKiytKPchTmjyUQsg/JkhWnfty5Wr7kPytwtBz?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0420b603-fa00-46c3-3f03-08db82ee05e5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 15:38:22.0716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwJW08vKAipCsBvaX1uzFOzhy1lZxtJHk2tq3ZJrgdOixwM5gjC9dmq7vX9Wx1FZql87bz/smo9fH9Ex6mYRMjbvNKtV6M6nVexTUzsQWi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6484
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew and Christian,

On Wed, Jul 12, 2023 at 04:55:44PM +0200, Andrew Lunn wrote:
> On Wed, Jul 12, 2023 at 03:59:10AM +0200, Christian Marangi wrote:
> > On Tue, Jul 11, 2023 at 07:22:49PM -0700, Colin Foster wrote:
> > > Preface (new for resend):
> > > 
> > > This is a resend of a patch I'd sent a couple years back. At that time,
> > > I was told to wait for hardware-offloaded LEDS. It looks like that time
> > > has finally come, so I've changed this from PATCH down to an RFC to make
> > > sure this is the right approach for the framework.
> > > 
> > > Ocelot chips (VSC7511, VSC7512, VSC7513, VSC7514) have support for
> > > hardware-offloaded LEDs based on network activity. This is currenty
> > > managed by way of pinctrl-microchip-sgpio (and this current patch).
> > > 
> > > The purpose of this resend is two-fold. First, to come up with an idea
> > > of how this pinctrl-microchip-sgpio module can fit in with the new
> > > hardware-offloaded netdev triggers Christian Marangi recently added. Is
> > > this something that should be in the pinctrl module itself? Or should
> > > there be a drivers/net/ethernet/mscc/ocelot_leds.c module that I should
> > > add?
> > >
> > 
> > I'm a bit out of the loop on what magic OEM did to make LED work on
> > ocelot but I feel an ocelot_leds submodule is needed.

The configuration is basically SPI to an GPIO expander. The ocelot chip
fully manages the SPI bus.

> > 
> > To correctly supports the hw many API needs to be defined and for switch
> > I would stick with how things are done with qca8k, codewise and DT wise
> > (with how LEDs are defined in DT)
> > 
> > Ideally the feature for MAC will be generilized and added to the DSA ops
> > struct, so having things in the DSA driver would make the migration
> > easier.
> 
> `ocelot` is a bit of an odd device, since it is both a DSA device for
> felix and seville and a pure switchdev device for ocelot.

Now you tell me :-)

> 
> You need some integration with the switch driver, because i expect
> only the switch driver has the knowledge of how LEDs are mapped to
> struct netdev and ports. And in order to offload blinking you need
> that mapping.
> 
> I have some WIP patches to add a generalized DSA interface for LEDs,
> and support for mv88e6xxx. I would also like to move qca8k over to
> that. So it could be that felix and seville would use that. Ocelot
> would need to do it slightly different, but i expect it is just a
> layer on top of some shared code, much like the rest of ocelot.

Based on this comment, I might sit on the sidelines for a couple more
cycles.

> 
> Having pinmux in the middle is interesting. I've no idea how that will
> work, but i've not looked at it.

Yeah, I'm not exactly sure either. And integration with the switch
driver will be interesting to say the least. I don't know if Felix /
Seville have this capability (probably not).


I'll keep all this on the back of my mind. It seems like there will
definitely be some subtleties in any way. I figure it is better to bring
up the concept earlier than later, so thanks for the feedback!

> 
>       Andrew
