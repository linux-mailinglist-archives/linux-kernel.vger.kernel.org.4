Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80F573C00E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 22:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjFWUg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 16:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjFWUgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 16:36:19 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2137.outbound.protection.outlook.com [40.107.220.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72492728;
        Fri, 23 Jun 2023 13:35:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bj5INSm+hVQFY2BXP1OEtvI4DGWU5c33Wa+tbhMI1QBJAgRqesCO1h9W1YqHTbMJtGffKvELLPaNCHJJZzd2prmQSWkEVA7gA6tMU+43UireIV4ymQbpEr3IajvsLnuJIwGvo4hR5I2cAsCgP0hemWlSk5OQVL3G6YxbBwThFZit9o5EKTL4T/qNgDLqmYXPBkZ4f+1IYZ79pIo06KibtmWkCsZaPI1pIz9WzKNjQY7V6/Mr3rw2tjSZu/mmqrcAn2RO/TgDO4en4DF5mnOGdwN2pSf9NKv6R51PQecTVv6nMtZeWV59uBRhMbIKwEBL3oC05If6HnAy/iARVmGtbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MWAnSCtg2nZ+ZiOCxtfm+6oQoUOHmnAw7aohQcR9cc=;
 b=AN26NWxeTkG9+5j9zuoLYfYjDXtSrEQi3ydKeYJqyzLbwvH8ZOL1TfbmCGmEIEB1d9rXDiiXzyIcS5h8qmZNxE689E2a3I9eZDsfg59NJeNVC10JTnudaDA5RfneLNXBRnq8O/Gh5FIFoThDfsiRCGx53Ad93e/FFoPy1NtuvdDE/S6+nBEDdMQveBKVzlGkPCJORCQn2wFrfq6NZmrNUQXMMRdK7+A5Z/L0A190w7F7nILq22chdewbDUcVavF0FKvI/Xuam//9Af6DLjupfSGLVoumYxT3HRKE62WB9ovgT/qRte9qEk0FPFbiKUJFCoKJUprpN+/LwnCulu+hSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MWAnSCtg2nZ+ZiOCxtfm+6oQoUOHmnAw7aohQcR9cc=;
 b=YiB/lQ1C78DPE6iFA+uJ4WnfUO4J6yGcmsYJFgPm2o/kmXKg1nQbCV3zIoB9xLNgTLyOW/5Inv/6nfDXLIA0Af82OO9IbIclUnrhwhVs5FRZ6TZNpKuALPZaqAIt20F8IwgcS7jiblAQZY5IOq0gllIN/86/nX3QGdBkYUvcEms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY3PR13MB5028.namprd13.prod.outlook.com (2603:10b6:a03:360::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 20:35:24 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 20:35:24 +0000
Date:   Fri, 23 Jun 2023 22:35:17 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Michael Walle <mwalle@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 06/10] net: phy: print an info if a broken
 C45 bus is found
Message-ID: <ZJYCBeKdXBot/9Xd@corigine.com>
References: <20230620-feature-c45-over-c22-v2-0-def0ab9ccee2@kernel.org>
 <20230620-feature-c45-over-c22-v2-6-def0ab9ccee2@kernel.org>
 <af166ce6-b9b2-44e0-9f45-2b2aa001fd6b@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af166ce6-b9b2-44e0-9f45-2b2aa001fd6b@lunn.ch>
X-ClientProxiedBy: AS4PR10CA0020.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::10) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY3PR13MB5028:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a92630-3c9c-4219-fdbb-08db74295f4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1KRxLjhpUupTlXGrWyxbqYozHzRjgRlTn+USPPQ49Og/nppSnkeO6EzJDwr4gWEDoYMG7sJNhmSH7705GFtx6cNVSzGvMQCvYK2IAgQMRIh2Z/Y/UPyLGgptrjEHX8TPWXeb4gmqwea/vM+8L3COUP/gzEwvWjhgtgBeUr3zZEXRvGRvC6PKRsa2hIo72k2S4dlrI3CjQPRmQQ4LYm7sbnfqG8y7Hp/KVVkgOahFkOMlQJs+0tKrC7eYCcb40JBNplz9ipymN+lg8nkbf5kWEl0FftaoWun6v2QSzrx9pVTz/O8pM4434dByYsjGpWAaxAe2+P5Fq4Pdj65Wvxhiyi/mifOYR7utXKHMQ9hAI2GU7FtmJRg7Szsa16SnzSLnHv/q1lFnURiw2iHY07/WrrU+t84XZjL0YzKkPldZByIk6KHXD9PAEZXvlZjdFwJJOXU2cQeNKwILNfNIQOXGqmJnPTviMSs2jPM9YX+g2vcOStvU2mhvhWvP8R5ZYl6V9rLuXoK5BuJUdUhOGXjOwPBkHSZaeAGnmgCqOCNXHVKyfhW8nriq290MoaJwKODxYpuTJ/1x53mF48mTbgb8QSwEWXeRCD3Dc9OhPngH5nE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39840400004)(366004)(451199021)(2906002)(6486002)(83380400001)(6666004)(38100700002)(2616005)(6506007)(6512007)(186003)(41300700001)(86362001)(54906003)(316002)(478600001)(66946007)(66556008)(66476007)(36756003)(6916009)(4326008)(5660300002)(7416002)(8936002)(8676002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dnYU5Q2GRDSkkCaJkxjSYErkZFsN0PEWaAfaTuj5cD+dvzJPcFKkDTC+TSRO?=
 =?us-ascii?Q?1SR+cTqaXrGLgMtfr93f5GHZ/L2tSP1jQCz89hrkD+4YXAwbn6nbJVkeMiU9?=
 =?us-ascii?Q?E+BXT1xD5HUtQCiPIWdXnTycyqxEqJGOMX4lIulzFuLaozKDJ1GahrxJqdn1?=
 =?us-ascii?Q?ssoia8AjfBanqkWdBQcYLCHOtanf3qIZtlGxdY3KdHt1xxsf1lGoXVswNWcg?=
 =?us-ascii?Q?ymdLcpuNuBtzb3YcJyHUHogYe6DkZYWyVre5hZj7TqOD1r4loFDFobupqM5A?=
 =?us-ascii?Q?PmHkeaiR/DqlaIZlRH5i2NNrqPSsYdizGT15Nf3SPThnms/YfoJyLdoe5idD?=
 =?us-ascii?Q?8BGvyagBhxALgwxkMlgn3PIV/W5XUmCf8TwjpzPE/ZvdAO3m1cpEb3R+Laxr?=
 =?us-ascii?Q?/zLL6ldZS4t4gFznnv0hL1aFTJKXI8uu9h3L/m7HCAfLPTUswaKccBccShI4?=
 =?us-ascii?Q?VKRt3XcOKY1jIjAbHSZrna1TmPwI5L4/zr0iD5/GEt4Mdw7Pqt2XqTpEKeSO?=
 =?us-ascii?Q?/eu5MdBtpE0z2qa6krOqVWzMpReGXp7IE9NC5x6yNPl2wArQoERNQH4tLAp5?=
 =?us-ascii?Q?plYdxAngT1UXyJfU16idvDmQO4FohHLFMUKUVLRD3PVbgVJ6+iUSPFV91bl9?=
 =?us-ascii?Q?tA0tddDLyOsA+OGc1nCyTmzKGFmtHZFkuW34B61sPTP/KXGhPCOgIeJbt6gB?=
 =?us-ascii?Q?J96OnFs5fnZFcTTsEeSghpOtQsmoKFarBELzzARdsd/mTwH4DHW9LhEC5/4t?=
 =?us-ascii?Q?eryxqYKeoG01QzHvsdCq8epmnH9kmrIUrGvzFv95oh1Tkdf7+yKM0AAWBhDw?=
 =?us-ascii?Q?RnCK5Lwyg4ud8pUS2ParLsxy2OJ+X9L+l0PHFXqVd+snCiXGIOrIqJVicsjn?=
 =?us-ascii?Q?xiZ7WcII1BykLrixqerrtReJiJXoDtKA3vA9gBj2xaJYrKOKpWH1qwG2Ez84?=
 =?us-ascii?Q?VdoMYKVeXbhB7ojtcW2fD9BEIclxGh0dmEhXQquCBJwI3Cc27rq8w70jm6sI?=
 =?us-ascii?Q?5RVNZimAymVP7Zy36+2mzcboYonhjnbxkRCefZ1YLXEB2jS6eeVSzJg6LjFc?=
 =?us-ascii?Q?+SiqhwkYFBntOyBGGAzAZHXQm0OEa5qUuvWjwU8kKIUSiyyWdSMfbpzMyuLY?=
 =?us-ascii?Q?si37eMPSoy7ixd/PXxEFdE5E1O/Ha6n2SWe8QInOvgRlPY5th7MY661hEKa5?=
 =?us-ascii?Q?Gt+mxHAWZC/eEC/5VSovYZUXN1pSLhsW0Glp7Xgi1vmy8RO262Pi/0B1PwHz?=
 =?us-ascii?Q?btK1N3APH8+5yuNiQHJflxwVTybIC5V5xfx0+zXX9D/yzGrhZ9xSELXT0hyM?=
 =?us-ascii?Q?mBwQd2tENdhSqVDED3cewrhRDDf4gVMn8sFPhAaaWYd2h46GsEoTnLXdR4Iz?=
 =?us-ascii?Q?izyFACpIiOAUf1NPhkwlcfyScd8E25/LNMKsKOWpIpMk+V2zmhOKb0zJftDp?=
 =?us-ascii?Q?bzBwU4ljnpTVU9whodIFDs3L5P3st5JuhDiRgJFdKV1pr5ZnmlPdti/yUgay?=
 =?us-ascii?Q?dT2Wd+YEhLNAhtcAZH8vPAgy/pqKMT2Qq6jYQfN22G5IFLd1NFhmIb7Y7exL?=
 =?us-ascii?Q?8FqCa/rjRfAM+3bJ7MHfb8GyGWgMCJzQlntxhyI3nYwTVgkFJLuNWe9eYb5x?=
 =?us-ascii?Q?i8iChoKh+yKAsWb0xAAICcw3GrUYtQ13emRrq9Auo/F3GjelI6xR7BZ97sIk?=
 =?us-ascii?Q?xxgWzQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a92630-3c9c-4219-fdbb-08db74295f4d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 20:35:24.5922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cue6vw3SReiGC/sPLFYz1wIdc/XQTd5QmgDEz4GCrCFgPJR1V90ss8Umo9skkocYA/rnQG7ppINWpvcqDhnGkLXd03ivGIZknZOveV5r4TU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB5028
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 07:42:08PM +0200, Andrew Lunn wrote:
> On Fri, Jun 23, 2023 at 12:29:15PM +0200, Michael Walle wrote:
> > If there is an PHY which gets confused by C45 transactions on the MDIO
> > bus, print an info together with the PHY identifier of the offending
> > one.
> > 
> > Signed-off-by: Michael Walle <mwalle@kernel.org>
> > 
> > ---
> > I wasn't sure if this should be phydev_dbg() or phydev_info(). I mainly
> > see this as an info to a user why some PHYs might not be probed (or
> > c45-over-c22 is used later).
> 
> The information is useful to the DT writer, not the 'user'. I would
> assume the DT writer has a bit more kernel knowledge and can debug
> prints on. So i would suggest phydev_dbg().
> 
> > @@ -617,10 +617,10 @@ static int mdiobus_scan_bus_c45(struct mii_bus *bus)
> >   */
> >  void mdiobus_scan_for_broken_c45_access(struct mii_bus *bus)
> >  {
> > +	struct phy_device *phydev;
> >  	int i;
> >  
> >  	for (i = 0; i < PHY_MAX_ADDR; i++) {
> > -		struct phy_device *phydev;
> >  		u32 oui;
> 
> It is not clear why you changed the scope of phydev. I guess another
> version used phydev_info(), where as now you have dev_info()?

I think it is so it can be used in the dev_info() call below.
However Smatch has it's doubts that it is always initialised there.

  .../mdio_bus.c:638 mdiobus_scan_for_broken_c45_access() error: we previously assumed 'phydev' could be null (see line 627)

> >  		phydev = mdiobus_get_phy(bus, i);

Line 627 immediately follows the line above, like this:

		if (!phydev)
			continue;

> > @@ -633,6 +633,11 @@ void mdiobus_scan_for_broken_c45_access(struct mii_bus *bus)
> >  			break;
> >  		}
> >  	}
> > +
> > +	if (bus->prevent_c45_access)
> > +		dev_info(&bus->dev,
> > +			 "Detected broken PHY (ID %08lx). Disabling C45 bus transactions.\n",
> > +			 (unsigned long)phydev->phy_id);
> >  }
> >  
> >  /**
> > 
> > -- 
> > 2.39.2
> > 
> 
