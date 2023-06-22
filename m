Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C2C73982D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjFVHe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjFVHeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:34:24 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2100.outbound.protection.outlook.com [40.107.95.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700F11995;
        Thu, 22 Jun 2023 00:34:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdoC/T2j26vBjGRMy6+5PVBX8tSbo5UdBUZumsyT6kaiCB+IEufhum9kf29hsGzZWEAmlW4fI+BA/IbY3fYlOqks66VV6x6+ihM8RtlugjbYuve/9IeU+pt61h1GorAm0mv5yCKhPpVeD/bOobRhBOaLv4IFDx+kcHLHsM8h0UHZ9Xfecutu+iuWqLeD9qmoRpyz+s9s8IlKBxHpDDpW39Q9aDUhX8J8b+GjwNJch78vH/XrDReoaMdgcqb0LeFJmx/rq3i31dvdkzAol/8eZRLo3zw0RXtoaPPOr69x+08rgiFgNhoAFhLvjJ/wmK/ZIDxoviMv3O7pBWH9em0cbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UX5Cr9qKentGBI5KovNp9ddoMbbmzQ5FxohPHFYDAi8=;
 b=E0RFGkwiTVu/5xYT0/TKumoc4+8CqK61Nx8F7VwwGg8OosK0ObP3FNSdQufTmO5aXuJYceUN/Vy/fwa/wR271qG/iWzzEgbHbCvvk2lA8Hr1oIGqFYMmqboLTrOMZ1ttsTkMuBhkUSaONxRrl3AqUnyGsgXrnMWMLdcq8zEEhvumwGqLr75mJvq3oqP+k0GWQwmTsmeCswYLiB97GPTWliMNXDcFNSlqps/1aZlQaYrtj4fCAU7yjA2xmwH6QMhQI+wteMFqXgiYZfAydfHojUwMtq9DZ+aAAI+YtMo6tsXhC2nDSCvfNQ+lZJ80B0SpfQ+NZhKyY+NOfPnBI9ad3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UX5Cr9qKentGBI5KovNp9ddoMbbmzQ5FxohPHFYDAi8=;
 b=jrK6cGUSqrj6VQsbHKOMqzwmS6NwXOvyn+jWq01PweovwTiQzPG5KkgvCw12LvvlQrGPfDl27B9md10AUl8SJY0abv0+FjfU+02SA5FCWUd/qB66GZJrBLl+HRNNwhRc1InZ8ZEnZh72bCfJICP25IHv1BeNmiUV81s7kv4RISk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW3PR13MB3914.namprd13.prod.outlook.com (2603:10b6:303:58::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 07:34:20 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 07:34:20 +0000
Date:   Thu, 22 Jun 2023 09:34:13 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     netdev@vger.kernel.org, linus.walleij@linaro.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/6] net: dsa: vsc73xx: convert to PHYLINK
Message-ID: <ZJP5dWDuAS/5pSYa@corigine.com>
References: <20230621191302.1405623-1-paweldembicki@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621191302.1405623-1-paweldembicki@gmail.com>
X-ClientProxiedBy: AS4PR09CA0011.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::13) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW3PR13MB3914:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d08cac4-479f-4276-0359-08db72f3176c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mRSbleJhcrrQ/2C28oi/E+pLzOU7BBx72zYM3hB678bpV3A2yhetoZ1NiNp9bZX29POAq3Z61bhou75klxH9ZJuPZi/gXgvCOf6Bg19EZTVK9n/ixQVpAvcSO+MsF77+4OuY+e28gf4hel7BnoA3n068JbucE+qUcmbwMK+HmZi00J/io/dRubcDVqWIKtGiZBvF/jF7dp75RsGe8UELcLtM+RoUSP+gF0toUcOtahMJ8XSjEWwoc/DjoNSp21wVrHVGWejXFisy4BzAD4G15/LfOkA1iJPb4XdrSFPVmQn3xumUqeFru1T8jro3h0z/v5Tgb255JnaZKnoOQivMsNQJnwk2DpSCYHD1P1dyKyo8WCVqFxZ2nzEfz0l5GWPibMffdOt2ubjOzAJKQYy9hYVl3029NehV1NpDKoQFrenZ8W65HJIIxWiPJvQVOp8m2bJe57MooNDB5FBiyhf/DvS/+CrtJBQFnz2GBCV+fd/bhThV8/aCJMUn7yLphxlZizaWGLLUW5fjBjatP+iWn9Z6N0QSteCtFw5WCnejC4EiV7hJlIW9cWHKFQAqbgClQTj5SUjPtLRBCNwqDorrP+rU0i+lMizo5eujMdS4n7I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39840400004)(366004)(346002)(376002)(451199021)(38100700002)(6486002)(83380400001)(6506007)(186003)(2616005)(7416002)(44832011)(5660300002)(2906002)(41300700001)(8676002)(8936002)(4326008)(6666004)(36756003)(478600001)(66556008)(6512007)(66946007)(66476007)(6916009)(316002)(86362001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EiG31Jh6msLF4AEwEzKrkgiFT3uVyZeHjp6y/VILtkSdxNatK9xg3KPu1q1l?=
 =?us-ascii?Q?7oG3FR9az9G/S1bDTLovmTDxImYDFaseffBc9NPLWzq6S+1GZm3i3bx9fI6f?=
 =?us-ascii?Q?Mcxgj3AeVkXJaaEA+BoTz3v9KgzRuzTE+I/2v2kpOKeyyjBwZ9QAVeUf5Cb/?=
 =?us-ascii?Q?UL73u1JYJkF6q4L2jkhETg1dIPphit9DMo7MzoiN63Hm3zMMrtooXF+3MHwA?=
 =?us-ascii?Q?PANfhfJhgNQg4Bu8mLk2C3hovkMfXO/Mrp5UgRjMFC4NaTVI+319vwGH9qK8?=
 =?us-ascii?Q?MYgVOMVRavdO65PlyznrhocymXnqxf1v3rV/6hi04JDUg6m8t5/NEMOk6iPJ?=
 =?us-ascii?Q?X+FwlsI6dvSJxDjopUCyf7XshqL8cbxzsf5lsCnxQ5De5l6EOHHde8SWKMu8?=
 =?us-ascii?Q?bVFxh+5DxdoxY3qiQUV6BGrRls863n19LWr+AH1wS84JAhhWP2mabAjPCyhr?=
 =?us-ascii?Q?Qf5w6KKaFbLYt0EpfkrPmY7VFYW7mzBLUKwca1sTV/jXhOFZNTil37fwkQRI?=
 =?us-ascii?Q?G+fOgcZvmiwI5E2EfuYJ+5Bopk6bKMHADFARcW/QTfKALcArGUiWzbjCR6D+?=
 =?us-ascii?Q?QSBuhoioME2hsIYRodAvq6bqxWhZ4isy1ypojn1g6kyJkqhD4df88Hvz1zcc?=
 =?us-ascii?Q?Rpb3tZVgcvJHdMKc527fzLujbM+LveZ/DcajdAoBD+YeoQd47IHUPmAlvtzG?=
 =?us-ascii?Q?QicCNrLgbKOvQxDUo63DLnrX2B4bFF5Q/gmUKf8+IVpYOmsvALWx1PaGkmlT?=
 =?us-ascii?Q?4I+3iB/J+SwRwPHH5IPajRIhrNMyr9y2XC0+vmn/GQhgG6IUOnP6OJXoRaqH?=
 =?us-ascii?Q?lPzJO+UdYzPHPuHygZx+OC/VJdzoCk26xSKyiNGL+8QIu43Ql7OpYGnJrjWW?=
 =?us-ascii?Q?V4pXLG1kl4z/phtiTAgSw5HT87kTJBlDGXUeKod+8SAfQvGZXqDBgRbeGaX4?=
 =?us-ascii?Q?LMl0kpwasZmFibqvm+xI93TDTS36mUEX+BNnaHxJLD100ro7mAc0H3hX6I5B?=
 =?us-ascii?Q?ox9sSZKd9wVZyfI2hnYTKqqqVN/Mk/rMK9UwYSk5qj4hMrFonpIyGWYrxPMt?=
 =?us-ascii?Q?oVViD5XzFDUp1pPgeS7ATSGijBBpkrRXAiFqJBCw3zCgdOW6SBUL+4acZqGO?=
 =?us-ascii?Q?fC2DjpXSYX/MS/3n+Xdd+p7Wam+3N3/T1SqcqsvjUYg8YySenvbgMegjB9zI?=
 =?us-ascii?Q?qm3hsZvC34yrq1aNQ/q+DpHXAcqOq65NwIg7/CgyrCb4ET5Z/LSJdrhzabvA?=
 =?us-ascii?Q?4vs/q1+IBmdORx9sRnZKadhh5LjrXX/rBfMdB8rT4W2xaL3I3GXcAUgjqidh?=
 =?us-ascii?Q?/USbOW5bA+12w9dwTiWDEwtgnPSAPwnDBS+UIPbAtUjky5TWqO0vuLqAmGZX?=
 =?us-ascii?Q?yo3JjtvEvuOkEe1lqXMTemEjPYJHD9SsW6gST5a0bPoRP+Mle1tKBiD9LIS9?=
 =?us-ascii?Q?j3iGD/NFkOeDjWkGDQnEJ8R/k5CydY5g+/EyFm3SdmagnOuRSNTDQrM76mkn?=
 =?us-ascii?Q?WPJNdGED/I7b9PgOkbVbigHAuUWRtJIbbCHzy3tP8LPh0ZJ9QmWW0Emz9IZA?=
 =?us-ascii?Q?IQ8w1m6jumxF+fs4XxmyUM+ZEt4pM6LAuY7jxROsie6MeB1m6kcXJt0baO4R?=
 =?us-ascii?Q?hR9a2l1Tv2iNpu+s/6w8UfdH8YVPKOj7spWkLUYt052KL/Kcm+o02XmeCSIM?=
 =?us-ascii?Q?KDOR+Q=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d08cac4-479f-4276-0359-08db72f3176c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 07:34:20.0745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+rMFiREi6Yum7COXWH3zFWjj4PGfagXeZni3i0m5WdntteOb5RYyKMPKOhstSlZDIAVzcO7M/9647RR/oZPKaD7dTl6P4V1vMHZ/VEqwUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB3914
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 09:12:56PM +0200, Pawel Dembicki wrote:
> This patch replaces the adjust_link api with the phylink apis that provide
> equivalent functionality.
> 
> The remaining functionality from the adjust_link is now covered in the
> phylink_mac_link_* and phylink_mac_config.
> 
> Removes:
> .adjust_link
> Adds:
> .phylink_get_caps
> .phylink_mac_link_down
> .phylink_mac_link_up
> .phylink_mac_link_down
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

...

> +static void vsc73xx_phylink_mac_link_up(struct dsa_switch *ds, int port,
> +					unsigned int mode,
> +					phy_interface_t interface,
> +					struct phy_device *phydev,
> +					int speed, int duplex,
> +					bool tx_pause, bool rx_pause)
> +{
> +	struct vsc73xx *vsc = ds->priv;
> +	u32 val;
>  
> +	switch (speed) {
> +	case SPEED_1000:
>  		/* Set up default for internal port or external RGMII */
> -		if (phydev->interface == PHY_INTERFACE_MODE_RGMII)
> +		if (interface == PHY_INTERFACE_MODE_RGMII)
>  			val = VSC73XX_MAC_CFG_1000M_F_RGMII;
>  		else
>  			val = VSC73XX_MAC_CFG_1000M_F_PHY;
> -		vsc73xx_adjust_enable_port(vsc, port, phydev, val);
> -	} else if (phydev->speed == SPEED_100) {
> -		if (phydev->duplex == DUPLEX_FULL) {
> -			val = VSC73XX_MAC_CFG_100_10M_F_PHY;
> -			dev_dbg(vsc->dev,
> -				"port %d: 100 Mbit full duplex mode\n",
> -				port);
> -		} else {
> -			val = VSC73XX_MAC_CFG_100_10M_H_PHY;
> -			dev_dbg(vsc->dev,
> -				"port %d: 100 Mbit half duplex mode\n",
> -				port);
> -		}
> -		vsc73xx_adjust_enable_port(vsc, port, phydev, val);
> -	} else if (phydev->speed == SPEED_10) {
> -		if (phydev->duplex == DUPLEX_FULL) {
> +		break;
> +	case SPEED_100:
> +	case SPEED_10:
> +		if (duplex == DUPLEX_FULL)
>  			val = VSC73XX_MAC_CFG_100_10M_F_PHY;
> -			dev_dbg(vsc->dev,
> -				"port %d: 10 Mbit full duplex mode\n",
> -				port);
> -		} else {
> +		else
>  			val = VSC73XX_MAC_CFG_100_10M_H_PHY;
> -			dev_dbg(vsc->dev,
> -				"port %d: 10 Mbit half duplex mode\n",
> -				port);
> -		}
> -		vsc73xx_adjust_enable_port(vsc, port, phydev, val);
> -	} else {
> -		dev_err(vsc->dev,
> -			"could not adjust link: unknown speed\n");
> +		break;
>  	}
>  
>  	/* Enable port (forwarding) in the receieve mask */
>  	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
>  			    VSC73XX_RECVMASK, BIT(port), BIT(port));
> +	vsc73xx_adjust_enable_port(vsc, port, val);

Hi Pawel,

GCC 12.3.0 [1] reports that val may now be uninitialised at this point,
and in turn used uninitialised in vsc73xx_adjust_enable_port.

 In function 'vsc73xx_adjust_enable_port',
     inlined from 'vsc73xx_phylink_mac_link_up' at drivers/net/dsa/vitesse-vsc73xx-core.c:891:2:
 drivers/net/dsa/vitesse-vsc73xx-core.c:725:13: warning: 'val' may be used uninitialized [-Wmaybe-uninitialized]
   725 |         val |= VSC73XX_MAC_CFG_RESET;
       |             ^
 drivers/net/dsa/vitesse-vsc73xx-core.c: In function 'vsc73xx_phylink_mac_link_up':
 drivers/net/dsa/vitesse-vsc73xx-core.c:869:13: note: 'val' was declared here
   869 |         u32 val;
       |             ^~~

...
