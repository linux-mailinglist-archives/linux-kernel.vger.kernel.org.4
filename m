Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDAC73A527
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjFVPf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjFVPfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:35:25 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2103.outbound.protection.outlook.com [40.107.243.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5F6E6E;
        Thu, 22 Jun 2023 08:35:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpwyAbAzwlwkm+ubUSSW3SlYmaTaif645lghTiOHFgXeJLYQZuti9wwhsusb7nx6NqnWCxKuqMIawGTnwflLdq/KOiepP3M6w13eB6Cplw08PIkk914QxJz3y3v7acSPpD0I2uWM4A+Ymtj5X/waw1j6QYUbM6p9JjGwhGLTGxLPUav34je+LYZoOBl3mftsNxZ1dqAQROXeFPRqGLz676oDSTwYNUi85n+OYGFDUTGsg7OAGTA5fAZP7VK9L3z/ijHPBzIiRwXrsOd3hM2kQlKkcAFexrnb4S0vjStTPAdCpBzgwJ9EkFFZ2SgvpkRtJ+kFy4C8Ix8LCg75aWLIow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdVXQtg+fm7K8psDezjlPHVTd860+zOxNCv5oPnprqA=;
 b=M7orae/+381r29ndQI5v+btiAUbYZKBb0j8+RVjQ2v5ZTRhi9TZvv3PJ8uIYbeAPfMv2TnApV3SB1hyc8EOtb05Pb7a3KQw6pgxvkUWDBU1wcNrWSCvNWaDPwzrl56kN1eiRbm5DMX4VYv6C8daVJU1S46GEyy7W+2KT/5Db1skwC7MZxGWjVFKHVQ47Ue7M8j8sWspUbzlD/azkX9e1xhInm2i7hEkYkjJI+jskdOKCe4C09A+LeoJHpL9nIeMmdq98OXTrurWgdO4ChiCgaPFyYKjOb0KmzzNSVx+Vd8K3Zc8jj6rgk377nmMKRxAozpJJYX8qTQctNVq1y+eyZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdVXQtg+fm7K8psDezjlPHVTd860+zOxNCv5oPnprqA=;
 b=LOccfYNanrAP07Zo1sMWVi3bF5UKLAR+mhwtd19Nmc9kTLddLbVU0NigSwmtPIocF60MrrP8bGJWwlLr51ugmb5zaY1nHDHtb9/w4aqkO0Q2YkhP3ZAezuWgyeRAUnjxVmd+gku2vWAdeRMOH/aS2dL5pHKeCQyMMeJsKqEeuLg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DM6PR13MB4413.namprd13.prod.outlook.com (2603:10b6:5:1bf::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 15:35:20 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 15:35:20 +0000
Date:   Thu, 22 Jun 2023 17:35:12 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: broadcom: drop brcm_phy_setbits() and use
 phy_set_bits() instead
Message-ID: <ZJRqMLepCTPqvCD9@corigine.com>
References: <20230622123737.8649-1-giulio.benetti@benettiengineering.com>
 <12d3d3e7-da90-cc73-57e6-1aa7859dce90@benettiengineering.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12d3d3e7-da90-cc73-57e6-1aa7859dce90@benettiengineering.com>
X-ClientProxiedBy: AS4P251CA0025.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::12) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DM6PR13MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: edb13e7f-e331-487d-d4cb-08db7336494b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YEkqYeknatIs6sD24lDm26s98G242P2/O86ocZjYKYxlFyfGh0ZG2Odw/PKLmAVZ2QWdMPmcJzul2Ef0MRxKHd2WAWn84/XhvTDjiWgy+A3+FDjkvS90VGRn5MiyO+yPdBT0JgxpLXUw0K9BFuckErHjRclA/blXTTKRwNBd8p+R/bKVLl1sZZ2WAA7w5Q5zyTYyMv87lsnnKVsCgI6BctLOb73GxJHNNiOWRdt41KJRYtS/1ZEd1A1q3GyntzJZW/iHjKdHzbIB6a4yLAJ02otO3reS8IRnFwno6CsaCJ1rthxLyTEQTyUZ+huo6gGLGLmA6yhz8GKYxhxnZzaN+BLa8+Ro6SQzhh2ggKl2x1jwmTZL1QLqFjsV+6h9eZKmDt7qzUasYNckhv2+YWGtlLNaRyKlbBPs6DDO77ePYTPJxvWgnZK3sN4vYIf6Y/4mzXvzxZO6vWruOhV92u7eNMB1ElSXX9brwnhBOuxGMACLzuPT+LeR//VdEzuVCNBNC0tyH5NFPCSJElp2cuXRMyQEkUoPwoWyZBxDNVNp4mE7YH3hCDeNVmlxRY8bXYXaBPbDheL4Oj4RGXVfHVU1G5kAL9THUxRsmausxwXj2BM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39830400003)(366004)(136003)(346002)(451199021)(6916009)(4326008)(316002)(6666004)(6486002)(36756003)(54906003)(7416002)(8676002)(8936002)(44832011)(478600001)(5660300002)(66556008)(66946007)(66476007)(2906002)(38100700002)(86362001)(83380400001)(41300700001)(53546011)(186003)(6512007)(6506007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fyEO1JU/VnsXfFiBlu5JPGNSRV6F+PDZS1qV349xu1ZgvGfKTXXwjRfCWt/3?=
 =?us-ascii?Q?AzG+ELkIE36OBviKprPQz5fvLwqJV+t5SFy1goVVTl+JZb5p3YfkTMvbuaRQ?=
 =?us-ascii?Q?QuZEYsLxWb+b6jgdfUD/I92Fk6vblZeRcSfslEuhTBfy0QApW3EPq0lANFw3?=
 =?us-ascii?Q?laMgZLwbAA/6NM+cLSPH0W9px9Udp2wNsoYbtEOUzKw5flFF7TxfzvHOpBZQ?=
 =?us-ascii?Q?SRd4GpCTGgJH/HTtJnsNNRy2CtOej/yaKF41d5jyIMUVHgy98Qx1RdP+Gpd/?=
 =?us-ascii?Q?Xc8MrRMJZNA5pXiV42t21o/HBpCJ0QnWmy0xrPqebieHNkuTD/o3UxyxUSXr?=
 =?us-ascii?Q?aEWwVpKiGQ8FwKvOBzkWvlMk6NN3t0Lc5/txEBEdQpEnNdBBfyAhmLJrpauc?=
 =?us-ascii?Q?DnYTpVWMnoV2aUajffWBb36Ze6q3BHl00NLRcz+mwET0oO+q/Fqx/Zy+2DrW?=
 =?us-ascii?Q?W5BIRfl1Q9bD5oYAZRQrF8JZEs7i2RcNNqRnsp3xHj8kZ3RVlJn1JGnhh7hq?=
 =?us-ascii?Q?2qAVn7DzMQEL7kkjZAQwNfxP8aBYs5uDIx1Qo2h7eocKHM4e2VtnB/VwpJHD?=
 =?us-ascii?Q?giG9/s3+9c1e1E8tfh27AtSfqXc1B8Kh1b7BCK2H81e5BW/b/6ZpAaNPb2GP?=
 =?us-ascii?Q?v5+a+HURe2tOxfqdbF5/LXYiPvOq1YSwIF/+ama4lJj+4zebRvBqXi9iZ+8j?=
 =?us-ascii?Q?b6nc8wWUiPAI6xCXSEyoombsjR+zaZKUdDgl8l+pPSIEJSdsoiV7r0TDyctj?=
 =?us-ascii?Q?lzCGZ3TymCf+dT0BViRdrU2gC0B/d+pQ6fCJhStDXLf4fKv6oOQox43yUI/L?=
 =?us-ascii?Q?Uj9eTH1CxfY5gMygBD7af464xxe0xzuIwqY98LqPaqvv/zTbaakZXKmVMiCj?=
 =?us-ascii?Q?djDmT9yb5jrBuWbjiXwp2wSvpo5h1kcdfsJgZRxCjhwwOx+zZ3Ua+UkHUsJf?=
 =?us-ascii?Q?8ZnCPxXSYXMQ4Dh4b4CVZtJ4Mq6WWOsKo1gJZiKjDAUlPl1O6axHXR9lO+LG?=
 =?us-ascii?Q?4R6aXFx7FwIzGMnSlBHG1pIgoE+54T+qjfISyyYdgYrk/0tyVd34/CILiADS?=
 =?us-ascii?Q?85R3oj8kvmTFgtIpvWXhn83yjUeceBK9GRzpXSfK28IhGOyZA5fW5xQvzSlh?=
 =?us-ascii?Q?/hWYYDhATCodtddmqrQ0rx6z63xwDtEJFjvYg0xm/oiPE8ngCWoiS96PoAbb?=
 =?us-ascii?Q?oDWd6i+d8GnLFVW6fCMwQlzrrzZYO5sGddVWMj9arBrWl/XDgbD01+WR4Kpy?=
 =?us-ascii?Q?zLqURQ+kGKqHPQ4EnMYahdsykzZLtvCHTxFrZC0dm49ryKruijUVT5p8q/HH?=
 =?us-ascii?Q?gmYDh9yn79IaEKot/ewY7nvyqKMUO8cQ1WML+CiizSXqGiGN1OjhzpMrnXvf?=
 =?us-ascii?Q?7JFazSMxO4WwQYh2bPUN2LOxqcGvJZTklAIEoPPtXBFbCjda1llJ7CZ7WglM?=
 =?us-ascii?Q?3cphkQWNsID0jdIByWJgWXXThoCKoZVz/0BOjmC+SKZdyP5uxjamD9RhR7Wd?=
 =?us-ascii?Q?tvilzhrs/hZr1VI7UKvyWFS7rRRkV663lU4P24jMWRPIElxGSPdNFNOH0K5/?=
 =?us-ascii?Q?9n37gVNgj1iHRh9gDlD79sM2tjfyKTfQodSz85uhoM5EVxJRE4ur8QNjeWln?=
 =?us-ascii?Q?mbmw2UrWmG6otPiNExfcOlFnUPLBS9DXYUvphz5b2MEmBgUsniNBEkfIZ+Pc?=
 =?us-ascii?Q?yu0hWw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb13e7f-e331-487d-d4cb-08db7336494b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:35:20.0117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4kTi8mqQLy9QrU5XjoXlHdSkYqWDQxaAPVKIHV+Vmsrjv+wnROF09JzaVCwkcSSOGTiGcUWPaABpafvoSN8FlVdXCO+ZY8R3D7IZwnYULs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4413
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 02:48:46PM +0200, Giulio Benetti wrote:
> Pardon,
> 
> On 22/06/23 14:37, Giulio Benetti wrote:
> > Linux provides phy_set_bits() helper so let's drop brcm_phy_setbits() and
> > use phy_set_bits() in its place.
> > 
> > Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> > ---
> >   drivers/net/phy/broadcom.c | 15 ++-------------
> >   1 file changed, 2 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
> > index ad71c88c87e7..d684c5be529a 100644
> > --- a/drivers/net/phy/broadcom.c
> > +++ b/drivers/net/phy/broadcom.c
> > @@ -608,17 +608,6 @@ static int bcm54616s_read_status(struct phy_device *phydev)
> >   	return err;
> >   }
> > -static int brcm_phy_setbits(struct phy_device *phydev, int reg, int set)
> > -{
> > -	int val;
> > -
> > -	val = phy_read(phydev, reg);
> > -	if (val < 0)
> > -		return val;
> > -
> > -	return phy_write(phydev, reg, val | set);
> > -}
> > -
> >   static int brcm_fet_config_init(struct phy_device *phydev)
> >   {
> >   	int reg, err, err2, brcmtest;
> > @@ -689,14 +678,14 @@ static int brcm_fet_config_init(struct phy_device *phydev)
> >   		goto done;
> >   	/* Enable auto MDIX */
> > -	err = brcm_phy_setbits(phydev, MII_BRCM_FET_SHDW_MISCCTRL,
> > +	err = phy_set_bits(phydev, MII_BRCM_FET_SHDW_MISCCTRL,
> >   				       MII_BRCM_FET_SHDW_MC_FAME);
> 
> I've missed to checkpatch.pl and there is a style error ^^^
> 
> >   	if (err < 0)
> >   		goto done;
> >   	if (phydev->dev_flags & PHY_BRCM_AUTO_PWRDWN_ENABLE) {
> >   		/* Enable auto power down */
> > -		err = brcm_phy_setbits(phydev, MII_BRCM_FET_SHDW_AUXSTAT2,
> > +		err = phy_set_bits(phydev, MII_BRCM_FET_SHDW_AUXSTAT2,
> >   					       MII_BRCM_FET_SHDW_AS2_APDE);
> 
>                                       and here ^^^
> 
> I wait some time for any feedback and then I send a V2.

Hi Giulio,

Please include the target tree, net-next, when you send v2:

	Subject: [PATCH net-next v2] ...
