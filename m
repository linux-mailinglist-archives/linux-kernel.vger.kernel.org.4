Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A67C5EB745
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 03:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiI0B5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 21:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiI0B5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 21:57:09 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC57D11F;
        Mon, 26 Sep 2022 18:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxiiy6RXaMxpQarZ3DQ0weehDut5An14iDZXA1hmlLXuLub/35slW4zLjijd1cXUnRcIjk/a4H6V/pl2nhyHiKqRr3vdUywNaYkLsS/KzLGiFXXn4gCccdSeNUai10+z/3dy0Kr2hYMG7JhahhQ1x9bQLvHGbMb2FgSr6oMJJHuS171VQP/+8mo3w3ny/On2OWkLf3bJzpARCxprjt8KpvD5iWBfby80KrFoTgQmg5z87s54sXiypBvGJroeFSyj2COlBfvu5ifbDWTMt3geP+i2R87OxKZSs4mlf6SHYNF2xIH7LP/yNz0vVHy1lfvHofm+VJ3GbTpXCau61ruSeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uCXsjOt+OKXNSTEDQWs4kAFppq71yW2Vpai/fMZwjo=;
 b=AhzhER3LCVS/geqMKr1YkSIBQyLfggif8HLodgKPHrsaSxVN3InOohZvXrbC3ArAISxEuvRk+LXaPyLYvBVS+8I/70AAx2tQxl2Aqxlvl179ZlgfAAsMLtcY41SvzpvIuvpWANbexh4MW67beiBsVv9nUqHa7kWistYSuvUe/GlFInXsSrChoTzVWO4cnjniGL38/vyZC6jNT/1rVngJOW7EaHfQ2x4fR1tEa5eMFVV0vqWOlcaLsZMejL4zCZLm9vdLLl9w2CyUHtjLZLx0ic7BtS0+Mc54Astfnut9ja0mHPpHuoKEx4P6llfi6VcpqbCQIaVQdAxcr+/RGgTJrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uCXsjOt+OKXNSTEDQWs4kAFppq71yW2Vpai/fMZwjo=;
 b=B5TG1E8/zH5O0dZPHMvGirVoaCzvStYtzSrANYI5fOreBB5wLkGcHwkY6Q9uaX+86SNH/tAnQVA9cokcfaCwc+OSpIE7zEjdoy8rIeRYWLkJ5AlKAkOP8ZCf6DlPiK7WGkTNCyKFSiDnaY7JeoHC6HoW96U0wtX2FC5HejOXH8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by PH0PR08MB7655.namprd08.prod.outlook.com
 (2603:10b6:510:dd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 01:57:05 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::afa7:70e3:c2c9:b680]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::afa7:70e3:c2c9:b680%7]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 01:57:05 +0000
Date:   Mon, 26 Sep 2022 20:56:54 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc:     Quentin Schulz <foss+kernel@0leil.net>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        dmitry.torokhov@gmail.com, klaus.goger@theobroma-systems.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 1/3] Input: add `SW_BOOT_ALT`
Message-ID: <YzJYZrw09dXEihnn@nixie71>
References: <20220922101211.3215888-1-foss+kernel@0leil.net>
 <20220922101211.3215888-2-foss+kernel@0leil.net>
 <YyyZRt5j180KzGqc@nixie71>
 <7add41ad-2cff-adef-08c4-dbc02f7c7c31@theobroma-systems.com>
 <Yy3qj432McMJ/5rl@nixie71>
 <953e4d00-110e-b337-3c6c-af008c843046@theobroma-systems.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <953e4d00-110e-b337-3c6c-af008c843046@theobroma-systems.com>
X-ClientProxiedBy: SA0PR11CA0199.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::24) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|PH0PR08MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: bb09f3b1-d1be-41e0-f743-08daa02b9330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3vzG55XKpqY6Z/rc8Z9NfzisdIKI84vaIxvtCbl4CAOb7rXJw2jjqeu7bqWzdSu6/SlPoCuHb2nub/ST6TeUq+n18/WmHX9mfElMRxiNTVJSwjCIUHunD9949BunwENbw+WOH/9YF0AkLY++gM8EWoxt+vfbaNbMM2cr5m8mQYJsoqwmvfOLS8Lh8BsW76jXBsqYQxRjwbvU6nV2IrkNbAXNSYsH9RS0TuDFIQ3SlTVAh26/XdxcC6G4XcVSzrA+gcf5f1IXTZiP7joGFdWuUItNcwzN4cdrso/qOilHoatBjqmhAviMc0b646bz4DN3w9n5moG0FT968xUIHwYC9hErZPgtLMMB01z4HpT55UQNB+SGJ/xieKtP3yy26XYjqrAXvH+jRau9BSOJ2TNz5W7gpkmPQ71HWkdjXXLtzmmUIWKmRU9m3rIErfBp3oxEUVw6nIfHnmSg9Vl/rz8NEgLNJC5H3uNmP3nns5Ot6NLxyEMruZ+0QgzF7lgUOLEFa5jjVECOw1UbwGH1SEuvofiZXbv119iS0mfnqIDbouu8rGfYUsWthNXjhQOX/MRagj9knh4sK4u5LA/m+FI+59QDwsYzIikzOtxFfmt7T8Pr8wOJqkP6KEg0VSyzY9g1HXMFTD6jN4CwjDsJ8mvPOIQkq1tt4ytDkZeVwBiMpleZW96mjc412/T/9bygUvcrH8ug2vtw2FZwwbuYlkhZpQp2RBc4ehxOULk13TDhrF+mLGwKeBP4Jz9Yr/WkajU6tkbM1XEoRRBavQIPqfn/iA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39830400003)(136003)(346002)(396003)(376002)(366004)(451199015)(33716001)(53546011)(41300700001)(86362001)(6506007)(6512007)(26005)(2906002)(478600001)(966005)(9686003)(6486002)(186003)(6666004)(7416002)(83380400001)(5660300002)(316002)(4326008)(8936002)(6916009)(66946007)(38100700002)(66556008)(66476007)(8676002)(81973001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fDsxSeh5vTfHUR+gfHz6VUszUG5SM0OrbfuG7d51RPhD9STpa2jchWTPmsXg?=
 =?us-ascii?Q?kiYZXehGpUlogYKMK4QJ5RnjVhLBlh6/ZryKWf5ILyqj9LVPHZPkCTSeidrT?=
 =?us-ascii?Q?rr2eRXKKWULsPrVXbx6jNlLfCzPkMG0YLKvGMK4qPZuXZz7D5xd/k+tyqlht?=
 =?us-ascii?Q?Jy4iY7UsYqWyhO2p35gs7vNlG6beHpiGtCiajLqvJArffZeIBvq/oItnPiyP?=
 =?us-ascii?Q?SnD0AvnHRVi5BiF1LbTHtLOvxj8URw1xWP4ZHl2JvlZTgAnIN9kJrPALfhcM?=
 =?us-ascii?Q?3SrkoxwKtmXg5dPkgwmmKsgZOLziD0Ei6JcooIbLU0zGEUv1CJC9hThOjWPs?=
 =?us-ascii?Q?0dp9WtGSPtW3g+cJwjmmKa8pTsG1BBrK72KD6/DA9CuaoIBfFZPLFYMZEtzD?=
 =?us-ascii?Q?iP4p/RXVEe8bZiOm3x4hVUSpXR2gYwsK0KBAhIC6R2s4qnmFg5PLmPnE9TZd?=
 =?us-ascii?Q?a/9jxOvVro0lXnIkEQQ9jfV5jE6hNCe4/Y4/UN2a/Pk4WeaFs3eE7LZm/LW+?=
 =?us-ascii?Q?Tm6UP8VluLNYn9JHVBgUFpe1mPmaLujtKqmnXwHyY+hHibsf2v23GORDkmJL?=
 =?us-ascii?Q?r8eulGlRzUSA32XH/+IKO4ZGJE7O/lXMgCp6Mwexpkgla1phwgSVLBcauodu?=
 =?us-ascii?Q?LSrAYCYnn1ZG3zZqUEhxela+6rZXUmxCAqhD33H8oCotiHce1cJBK2/mTXxm?=
 =?us-ascii?Q?cF8YjSosJQncPEhxuU4wNU9H7vICKVAfM7xGPnWoYwsoDdS0kPay5T72Lqow?=
 =?us-ascii?Q?xsC93D9gFL2MlCVZwVhtAR/hxLm9fCWvwi9zI4RBCZz9DmVew/4MJONQwooB?=
 =?us-ascii?Q?dgLqjFLvBkGBP88FP4r9uf4Tiveec9ig86SEGUTAboxwHfwWx5BXXO2EMf6W?=
 =?us-ascii?Q?9aw4MUQLn9TfA7Xf6FMfKr+LOlygI6CsHvd46+Uf3TIKVM225KPOCRJnd0wX?=
 =?us-ascii?Q?cup8CRyEa/nxm/nV0yUB8ZTcT/ivgmQXOghKvgWpzAGeQYQIrJtcpQpncteD?=
 =?us-ascii?Q?egWb5u9f+So+BMoQaH2a29I7qpGhRLQuGKfMlRuVyMUlEsgZeY5KeEil2XkB?=
 =?us-ascii?Q?/X9nopH6JfKQnrIHM32W8wnEiAKX1wR4DtrOFRnw5LKBgkwinPb5ZPELeL2g?=
 =?us-ascii?Q?ZEN3DI5McsVMlmAgmiaWU0DQkds3SEs/LSYqMR3s8hL/Dron3OfddG8pg3Br?=
 =?us-ascii?Q?DUedmrKzW7jQ6gIVgxRc4vB/NLq6IVHqAc2Q1QJt5kVBOZ8OVZL4dCBPk3U8?=
 =?us-ascii?Q?FAYUb7l1qFu4EDRp4gAuIz7r2iEf1R0gfSzuNeWGUnfa2M85TyXd7jSJpJyR?=
 =?us-ascii?Q?QvDzDSh2F2JYNQZRt2odBbLXhUUbqUZmP1RxyZ/CdxZqzsO7oe4O3PIYgIIZ?=
 =?us-ascii?Q?DCSQ3Ty5UWorMdyr3xLkrVyn6B4S78BCKKUXW5Z/MWxN2EdcMR065fVozVPe?=
 =?us-ascii?Q?Nzfqkv8BYyR32ARdDNx4z9cMBs+vkRydJbpDtoHIDkp1r0FbBSlVTCZCBNku?=
 =?us-ascii?Q?yh1tgYwj/+uhhe8eYx+CadNeyyXSpCp7pB4edQxwtsXy5H1dqQybbbRX7uk7?=
 =?us-ascii?Q?P2Jmuhs7yCfsoJ0g+mPgrlTWkuvBac+HOUbl8R+Y?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb09f3b1-d1be-41e0-f743-08daa02b9330
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 01:57:04.9843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0nb9XG9ilnDzMvTDvAoqnfJM+ZG9x+D4iphjFjKPoxwfyQDeJ6YXKisKBNmVoMfh1Mcnep+knU4WBsBF2gPELg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB7655
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Mon, Sep 26, 2022 at 11:37:45AM +0200, Quentin Schulz wrote:
> Hi all,
> 
> On 9/23/22 19:19, Jeff LaBundy wrote:
> [...]
> > > 
> > > I have this switch on the board and I want to expose its state to the user,
> > > if this new event code is not possible/a good idea what would you suggest we
> > > could use?
> > > 
> > > Note that we already support the same switch but in a different way: https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_pub_scm_linux_kernel_git_torvalds_linux.git_tree_arch_arm64_boot_dts_rockchip_rk3399-2Dpuma-2Dhaikou.dts-23n167&d=DwIBAg&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=vObtDja6hUlL_kVvKRILCvaQfklw1gl7TAW7cm5_9H_Yi00zkzGV6-D3yzazR2gU&s=0Xo-7CDmMoriaTNn_hJdMwftLlcY-tgopPcgzXfQtJE&e=
> > > We are just configuring the GPIOs into the GPIO mode with a pull-up, and
> > > then it's up to the user to use gpiod or gpio-sysfs to check the state of
> > > the GPIO used for this switch. I don't like this, very not user-friendly and
> > > was looking for something better :)
> > 
> > Actually, that's exactly what I was going to suggest. What in particular
> > is not user-friendly about it?
> > 
> 
> The implementation we currently have in place for Puma Haikou is just muxing
> the pins in their GPIO function with a pull-up. Nothing else. This means the
> user still needs to know exactly which GPIO number is for which
> signal/event. Not that great. Also does not allow for a consistent user
> "experience" across modules on the same devkit (different GPIOs depending on
> the SoM).
> 
> I had hoped gpio-hog in input mode would expose it to userspace but it does
> not seem to?

No, I don't believe that is the case. That being said, you should be
able to grep /sys/kernel/debug/gpio for the hog node's label and get
the pin state (lo or hi).

> 
> Anything to recommend so that we can export a GPIO line for a specific
> function to usersapce without needing the user to know which GPIO number
> they should look at?

If debugfs won't work for your purposes, another option is to request
the GPIO from a general-purpose platform driver and return one of two
strings via sysfs.

> 
> While I have your attention, I was wondering about the BATTERY event. We
> have a BATLOW button, following the Q7 standard:
> """
> Battery low input. This signal may be driven active low by external
> circuitry to signal that the system battery is low or may be used to
> signal some other external battery management event.
> """
> 
> Oddly vague, but the EV_BATTERY event is not really more precise though (at
> least didn't find more precise information and the introducing commit is a
> bit vague too on the usage). Was just wondering if there was any specific
> usage for this event or if I'm using it correctly here?

Do you mean KEY_BATTERY?

> 
> Cheers,
> Quentin

Kind regards,
Jeff LaBundy
