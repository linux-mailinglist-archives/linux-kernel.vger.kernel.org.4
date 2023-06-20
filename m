Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464CE73756A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjFTTxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFTTxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:53:39 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2091.outbound.protection.outlook.com [40.107.94.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16062D7;
        Tue, 20 Jun 2023 12:53:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKm1YnkzFcOyefAWzRi12Sn8TbrXz1eK8PYGc05ldV6c2wH9o4aqmlIqpZgvkpmuGTIhC4ItVuiXcARUYLvC57Nv30dpmxf2wRGpcRmz/m/bM+dKJJ2gQD3H0xXNF6bfzGgniZO9y5t5Zusyo5P0MqE8vKCHlnwKaNh1jVhRkjAqp7atvvYQ9WwAmNSo2fdoWCgqqHPgNutxbhqLG7yp1fm2I2LBnfi2wVQu/1klPkHyT2Lo3M6tKeotXCSlxf6k7Ux3OwgvLiqYaGnCn0Q3KlbzYr9dB8nW+IYLBvDDsbGkezB/tOm3vm2cpK1ijlz/7V0EPuja52mQZNpCobzZrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4JAA1vK4RKaUexBC3bZPvyJBVEF/nPBOvA9GDZHNws=;
 b=ghoVk21bFKQf1H3ncNCSUM8p2cxs4jv2LNlCy7EKbPr1+JR349BRSwm+YmgOwfzYGuEQfum4HxwaljJvkvl/WDLGqNEbT11AZPXJ+GQfq9tgBgf/hSJCjkgU/xXtP8HA3BGC5eLokopUlgfQvXDGy947sabV0kSqCB/aM9uLlHFs2UQULqhB+0MnHZzaNvi09HbZRRvdPdUjgkDXhcRxz+RTUhalA0G8taM6WtdmCSHeBmp7phXMnxUzW/IpUDrxhf6XMQrbxGjKv3eBR92xaE8dsgjB6MNWVyl9o/lOD8QTRbzKTwj97B9IQvomXfkRyvFAKXdynKd4VbzKqZijyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4JAA1vK4RKaUexBC3bZPvyJBVEF/nPBOvA9GDZHNws=;
 b=YAFLY9RX5zehztYXWVRFZYtUTfFDNl6/+lBbPBq8hu16aoMjHMGdFnl3JIyRKipnceosrqK8oLhz2122NHMHvss/2bwCuTsR+5RQSR0Z7ZDZBI5k9SfFOg8xIKLBukwwD68ew5M12x3CedBVSV9pR/26OOkgs4HTEHabcM1u8CM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DM8PR13MB5141.namprd13.prod.outlook.com (2603:10b6:8:a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37; Tue, 20 Jun 2023 19:53:34 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 19:53:34 +0000
Date:   Tue, 20 Jun 2023 21:53:27 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH net-next] net: phy: at803x: Use
 devm_regulator_get_enable_optional()
Message-ID: <ZJIDt9jDaZY4cw1A@corigine.com>
References: <f5fdf1a50bb164b4f59409d3a70a2689515d59c9.1687011839.git.christophe.jaillet@wanadoo.fr>
 <6f7a5ee4-7ebf-2973-de3f-b72af631f52a@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f7a5ee4-7ebf-2973-de3f-b72af631f52a@wanadoo.fr>
X-ClientProxiedBy: AS4P192CA0049.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::22) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DM8PR13MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a67470-6822-4f55-1d63-08db71c807f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gJiTm2PMuH52iH2O+sMPjtEj6W8MkuV/bIN+8dPnM3IflP9pcJx710wXDCebfqsTwpnDa48Brid2YUH1sOJnbiKeF2PgJCgl3jLThZBLJ4+kA6UaS5fDd9Ua3oPyJgunMcLfDSzpA8rNukW/xjF82RfqoS1Pt1pG/s4OWE6faban6NUIBlpm1u8i+gMRwk1TBnSbQXn0E1C1P07XTOeVrEkYSO9qG7GiTg/WYLvNLgjIPXNcUV4xq48lr+L1RPzVWUxTk2LpOajKg9BF67pwEDuKa73hV8SxenRua1R5rBI5zG0y4puxUzH30O9N0v8MV2to37dHWb/YKYeGoWXXd26qSZMNvr9OzyTmaY+9Y50veXRWyqJ5nFwzZhc4qcOJs86QNjUnT2GgBZLTmHTZZyNyakkqpgp2HlItsUQsyBZr6hZ7P8biLsdlCwEBqMUz+2hrr5tA9fKTCuScZ6YSbVmeL/HSzEX6Has1eqXWKOR3d06S2ZBkEm908W6MSpqQiU7asXNMjveehSCi52NMyiiwyKafDc8IMmNFQPyp3z5H284pav6JeDgBlPV0t5J3QFGBQ8/K/lyT9y6Uw1WHJnb+AGwXrwGoSjCu+JSpjqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39840400004)(376002)(346002)(136003)(396003)(451199021)(66946007)(66556008)(2906002)(66574015)(83380400001)(8676002)(7416002)(2616005)(478600001)(966005)(6486002)(6666004)(54906003)(5660300002)(6506007)(6512007)(8936002)(44832011)(6916009)(316002)(66476007)(4326008)(41300700001)(186003)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1Q5bzFONkl1NStIb0dvdGExTk5RcGYyQ3ZpWTR4UjJhMkRMcFc0ZGJVN1R6?=
 =?utf-8?B?VHpjMGFXdTc4M01yaHNtaFYxeSswQzR4bXJBUzlYODZOK1FwbHhEZlJFcHhp?=
 =?utf-8?B?QmVIY2pYOFppR2lLNzNIbkFMUnJRWXFEL0VCQXZOdm92L3FsMEpPclk2Y2lD?=
 =?utf-8?B?TEV3aVZEL1ZkUVZNbnRYOEp1T2FXTUJZQlRQNjh4a2lDYzNnSGk3SFQ2QmVX?=
 =?utf-8?B?ZHkwT05nK2JxNW5OczBHcnpGWXVzemVEVHA5UDc3Y2wzVlBxV3JqWUpuVUhI?=
 =?utf-8?B?Z0wrS2lSSWlBNEl5SGQ3SGpPVjBjUDhsSVVSYnB2RU95Nll6OXlhc3pOL09q?=
 =?utf-8?B?SHZ5UjBsZVMwaWZxVkNuTDVlL2ZaQXBqc25vdFhFeFlvZS9kYk96V1RJQUJr?=
 =?utf-8?B?NlpiNzI5V01aZW5URzU3ZEQxN3FZalVZS1o3N3Y2QVZjVFJab3A2U3Fzd2xz?=
 =?utf-8?B?QzVWbWthTDM3L052MFArVmhKTkMvR1orTnZzQWx4SmdxT0RsajJXNGhSNnlp?=
 =?utf-8?B?WXBUTlNrenZQOTR5R2NXWnd0TW1Zbk9zTkJXa3lFMkQya0kyS0UyZ0NNU3JD?=
 =?utf-8?B?SlBHTzBmR0NEZEhMK3BuT00wVHFXNHBqSzBJeVZWTXRxT25aUFVLeXRTR2FD?=
 =?utf-8?B?UW5sQzZzS1dHczZCMnV2NWR3d2doRWdoRnIweCt1TWlWTDljZlNJc0crWnJM?=
 =?utf-8?B?ME9mcTYwYTFpd2NIWnR2NVFyZkk2YlNTeENTTWhXSEZJYk5qdGRSMlVhVGNN?=
 =?utf-8?B?ZjA2WHN6Rlp4TlBMaGk5dWFLejRJcWo2WlFGL3B1QTlnWFo4OU5WS082d09q?=
 =?utf-8?B?emdqUVhMUXJ5ZDVnY05aVzJwUW1POTVFeksyUm1tQlIzcmNwajlISFVZL0dK?=
 =?utf-8?B?ZFVVb0doOTcvcnBCNzhvVGF4bFdORktBZW1YRkkxSVl0dXF2RGZELzlXTk0x?=
 =?utf-8?B?NHZhSTNIUFl4VVM5cmxHZEI4cGg5d1BVcXF1aUNWVXk5YjRycE1VOU1nR3Np?=
 =?utf-8?B?VS9Hb0VJejJBN3I5RGRzTGVodGRoN1BXOXhQZXFWTjlXN3VXNE5Uc3A0cm03?=
 =?utf-8?B?amw2YUZ6SnJPWkRxOW8yTUs4L2pLd0hlS0MvWG4wM1NkNTZXejhwcmxnNEJy?=
 =?utf-8?B?Rm5lb2o0UENaNGpBVUZEZlJBZjJVZ1k0eDQwR0pFaCtsTW5RTEV0Wk50Y0Jx?=
 =?utf-8?B?SjdDUks5YnY0MEVBeVpZM1FJbVhRdE9IN3Bsc29SV05ZTnUrUllLUmhXeE9J?=
 =?utf-8?B?cHd0dVgvb05GU0tpTTEzczNRbTB2QktOaExTTjhsUkdBblkyVkM5V05oWlpY?=
 =?utf-8?B?QUpCY3d1bFhOWllTZU5KTTgxeEZNMG1xN1ZvUEtTYUZZTEZzVUVrMFlQZmRV?=
 =?utf-8?B?Qk9rUTR6OTZsVHBWNlpDUHhCUjgza0tMNktqejJtWHk1V1RMREdCWmNpdWJE?=
 =?utf-8?B?MmlFYWJrZ3RiR05pZEpFa0s2SXo2bVN0dnViNE1SSVEvMG00TnhxY2J4NDRm?=
 =?utf-8?B?QmtJcy8weHhySVhlTURVNG40WUJKSUNyVlNJUnEwSGFQMFZmQ3VpZitjQjY0?=
 =?utf-8?B?ZEw5R1RaVVZPRGRTVzlSTHMzUmE1ejh5NGNqT1J1TnZwWXBRV2o1TjI0c2pm?=
 =?utf-8?B?M1R0SGFZUDJ0VWdGYXBGaVpWc3FMUW01UWxuWEVVbDZneCtDUjQrSUwrQzVa?=
 =?utf-8?B?V1pXOFVsNENKSllYRFZsQk9ucGV0NE8yWHRpeHN2RkU4ZWt0QXB5OUNRY1FG?=
 =?utf-8?B?dWUxNTJWODl5dFVtUzFUYXh0REo4ZXJ0RGY3NDdtSG5sRThxbzNzQzJIdWZC?=
 =?utf-8?B?cjh2TThGRmMxTno4VUlBREZuSWFZeC9BRSs5Zmw2cm5YaEd1Rml0NjdYWHho?=
 =?utf-8?B?Q1RJeXMzTzBBSUJmWkxHeDB5WTNYZEQwcC9Zci9HQVl0UFZ0aFc1OU9ESWNt?=
 =?utf-8?B?YzVvZzJicVZtZXh1OHVZN1RXV0M5MXU2c3QyOStTcXJHZ01QRkExVk9SbEpz?=
 =?utf-8?B?c2lacW9TREVPRVliZ3psZ09xRFU4OHB6TjhMNFlLbW50dnBXTDFWR0M3ZVlw?=
 =?utf-8?B?VFhGUGJra29sYitVZ1NRZGhtb2FsR3VrUUNWbzlZSTFmdHAvdDJ1MGtwaGZr?=
 =?utf-8?B?M3hSRU1xd1VhVEhEd1FTKy9Reng0cXhsQmNxTjRQbTVJZExhM3c3ZDFoWXBx?=
 =?utf-8?B?cVA5ZzF0NTR3TTNsUGNhdVBzL0VZcUIrR2l4dmdCQUhNYjB0dXNNeXlVOVRQ?=
 =?utf-8?B?UVpzZWw4OUdpMWN5MVVrWDRXaTRRPT0=?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a67470-6822-4f55-1d63-08db71c807f5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 19:53:34.6319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EO5A1pkUwkiw9pgae+Q+tOjFzL1YrOHi9v4PcUmj2bCwDUbl9WyQdVzAA7db4mKh4WWGt6JAvLsbso5guFkhb0MNHIifvURWpYwGZOwmeWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR13MB5141
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Johan and Wolfram

On Tue, Jun 20, 2023 at 07:45:24PM +0200, Christophe JAILLET wrote:
> Le 17/06/2023 à 16:24, Christophe JAILLET a écrit :
> > Use devm_regulator_get_enable_optional() instead of hand writing it. It
> > saves some line of code.
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > Compile tested-only.
> > 
> > If my reading is correct, regulator_disable() is still called in the same
> > order, should an error occur or the driver be removed.
> > ---
> >   drivers/net/phy/at803x.c | 44 +++++++---------------------------------
> >   1 file changed, 7 insertions(+), 37 deletions(-)
> > 
> > diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> > index 656136628ffd..c1f307d90518 100644
> > --- a/drivers/net/phy/at803x.c
> > +++ b/drivers/net/phy/at803x.c
> > @@ -304,7 +304,6 @@ struct at803x_priv {
> >   	bool is_1000basex;
> >   	struct regulator_dev *vddio_rdev;
> >   	struct regulator_dev *vddh_rdev;
> > -	struct regulator *vddio;
> >   	u64 stats[ARRAY_SIZE(at803x_hw_stats)];
> >   };
> > @@ -824,11 +823,11 @@ static int at803x_parse_dt(struct phy_device *phydev)
> >   		if (ret < 0)
> >   			return ret;
> > -		priv->vddio = devm_regulator_get_optional(&phydev->mdio.dev,
> > -							  "vddio");
> > -		if (IS_ERR(priv->vddio)) {
> 
> Hi,
> 
> my patch is not broken by itself, but the existing code looks spurious.
> 
> If the optional regulator is not found, then -ENODEV is returned,
> at803x_parse_dt() will return this error and the probe will fail.
> 
> It looks that the test should be more subtle.
> 
> I can send a follow up patch, unless there is a better way to fix the
> pre-existing issue.
> 
> See [1] for a more detailed explanation.
> 
> CJ
> 
> [1]: https://lore.kernel.org/all/ZJFqCQ8bbBoX3l1g@hovoldconsulting.com/

My understanding is that this patch cleans things up (good)
and retains some dubious behaviour (not making it worse or better).

Meanwhile, a solution to the dubious behaviour was discussed in
the context of [1] and moreover a patch linked from there and associated
solution from Wolfram.

If so. I guess we can either:

1) Move forwards with this patch and
   then follow-up with the preferred solution for the dubious behaviour,
   once that solution is decided upon and available.
2) Skip this patch and follow-up later.

FWIIW, either seems fine to me.

> > +		ret = devm_regulator_get_enable_optional(&phydev->mdio.dev,
> > +							 "vddio");
> > +		if (ret) {
> >   			phydev_err(phydev, "failed to get VDDIO regulator\n");
> > -			return PTR_ERR(priv->vddio);
> > +			return ret;
> >   		}
> >   		/* Only AR8031/8033 support 1000Base-X for SFP modules */
> > @@ -856,12 +855,6 @@ static int at803x_probe(struct phy_device *phydev)
> >   	if (ret)
> >   		return ret;
> > -	if (priv->vddio) {
> > -		ret = regulator_enable(priv->vddio);
> > -		if (ret < 0)
> > -			return ret;
> > -	}
> > -
> >   	if (phydev->drv->phy_id == ATH8031_PHY_ID) {
> >   		int ccr = phy_read(phydev, AT803X_REG_CHIP_CONFIG);
> >   		int mode_cfg;
> > @@ -869,10 +862,8 @@ static int at803x_probe(struct phy_device *phydev)
> >   			.wolopts = 0,
> >   		};
> > -		if (ccr < 0) {
> > -			ret = ccr;
> > -			goto err;
> > -		}
> > +		if (ccr < 0)
> > +			return ccr;
> >   		mode_cfg = ccr & AT803X_MODE_CFG_MASK;
> >   		switch (mode_cfg) {
> > @@ -890,25 +881,11 @@ static int at803x_probe(struct phy_device *phydev)
> >   		ret = at803x_set_wol(phydev, &wol);
> >   		if (ret < 0) {
> >   			phydev_err(phydev, "failed to disable WOL on probe: %d\n", ret);
> > -			goto err;
> > +			return ret;
> >   		}
> >   	}
> >   	return 0;
> > -
> > -err:
> > -	if (priv->vddio)
> > -		regulator_disable(priv->vddio);
> > -
> > -	return ret;
> > -}
> > -
> > -static void at803x_remove(struct phy_device *phydev)
> > -{
> > -	struct at803x_priv *priv = phydev->priv;
> > -
> > -	if (priv->vddio)
> > -		regulator_disable(priv->vddio);
> >   }
> >   static int at803x_get_features(struct phy_device *phydev)
> > @@ -2021,7 +1998,6 @@ static struct phy_driver at803x_driver[] = {
> >   	.name			= "Qualcomm Atheros AR8035",
> >   	.flags			= PHY_POLL_CABLE_TEST,
> >   	.probe			= at803x_probe,
> > -	.remove			= at803x_remove,
> >   	.config_aneg		= at803x_config_aneg,
> >   	.config_init		= at803x_config_init,
> >   	.soft_reset		= genphy_soft_reset,
> > @@ -2043,7 +2019,6 @@ static struct phy_driver at803x_driver[] = {
> >   	.name			= "Qualcomm Atheros AR8030",
> >   	.phy_id_mask		= AT8030_PHY_ID_MASK,
> >   	.probe			= at803x_probe,
> > -	.remove			= at803x_remove,
> >   	.config_init		= at803x_config_init,
> >   	.link_change_notify	= at803x_link_change_notify,
> >   	.set_wol		= at803x_set_wol,
> > @@ -2059,7 +2034,6 @@ static struct phy_driver at803x_driver[] = {
> >   	.name			= "Qualcomm Atheros AR8031/AR8033",
> >   	.flags			= PHY_POLL_CABLE_TEST,
> >   	.probe			= at803x_probe,
> > -	.remove			= at803x_remove,
> >   	.config_init		= at803x_config_init,
> >   	.config_aneg		= at803x_config_aneg,
> >   	.soft_reset		= genphy_soft_reset,
> > @@ -2082,7 +2056,6 @@ static struct phy_driver at803x_driver[] = {
> >   	PHY_ID_MATCH_EXACT(ATH8032_PHY_ID),
> >   	.name			= "Qualcomm Atheros AR8032",
> >   	.probe			= at803x_probe,
> > -	.remove			= at803x_remove,
> >   	.flags			= PHY_POLL_CABLE_TEST,
> >   	.config_init		= at803x_config_init,
> >   	.link_change_notify	= at803x_link_change_notify,
> > @@ -2100,7 +2073,6 @@ static struct phy_driver at803x_driver[] = {
> >   	PHY_ID_MATCH_EXACT(ATH9331_PHY_ID),
> >   	.name			= "Qualcomm Atheros AR9331 built-in PHY",
> >   	.probe			= at803x_probe,
> > -	.remove			= at803x_remove,
> >   	.suspend		= at803x_suspend,
> >   	.resume			= at803x_resume,
> >   	.flags			= PHY_POLL_CABLE_TEST,
> > @@ -2117,7 +2089,6 @@ static struct phy_driver at803x_driver[] = {
> >   	PHY_ID_MATCH_EXACT(QCA9561_PHY_ID),
> >   	.name			= "Qualcomm Atheros QCA9561 built-in PHY",
> >   	.probe			= at803x_probe,
> > -	.remove			= at803x_remove,
> >   	.suspend		= at803x_suspend,
> >   	.resume			= at803x_resume,
> >   	.flags			= PHY_POLL_CABLE_TEST,
> > @@ -2183,7 +2154,6 @@ static struct phy_driver at803x_driver[] = {
> >   	.name			= "Qualcomm QCA8081",
> >   	.flags			= PHY_POLL_CABLE_TEST,
> >   	.probe			= at803x_probe,
> > -	.remove			= at803x_remove,
> >   	.config_intr		= at803x_config_intr,
> >   	.handle_interrupt	= at803x_handle_interrupt,
> >   	.get_tunable		= at803x_get_tunable,
> 
> 
