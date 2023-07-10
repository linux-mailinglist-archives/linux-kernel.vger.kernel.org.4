Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFD174D40E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjGJK6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGJK6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:58:43 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288AFBA;
        Mon, 10 Jul 2023 03:58:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbKLyRb85lFAgkurxZK47UuGJMgrpuAmhrchv8pCQvblHfUCLRUdUMG1WwXebLCdbBU6RhgCIT8DmmK+/PWJkHYqE98N5EfT0E3PZd9jBQ0lsbffvP4ibDzaXJL0hQ5zpldZickWnwunEcM54r5CgHmUwBeaajqjd2YZzoS+flASJOf3WPqv0yn+MJSbsCd0VL9gaGd0WR1LqfxFxmyvGaVnEb0s9n/34xoOpo7f9d1SMoqWyxu0wUtCxZQzDvaOw9M/2s1hUYhBM3C8JI7xp5I0kaDJhXxsy2wopP1NE5CIeEy+e3bo7gz+pCcRc8a+3FZqJBRykDShruW/neWUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLW/aCaaiccvEzIyurULonPQUuoBrda8v2prmrkGY98=;
 b=c7kRqKTnl6dvVWA6ez40hjnswlVe7W8RgEBXYXNxqEQwmCZ2yetoleehVzbyBH/ivByoLmR4hwGHF/gcKquKf7nZOIc4FlmuHBmPMp5fq9eHaX3N4F1mYAi9Cs+R0eJD+Lzy5+r3WHeDnzFK1kS2Ac1bg3HGWOdnIdweLJ2pSb6OB7JhoUvaYYXCSKU/ep0Gn5nSmoDznAUufWkSpr/VfRUuTyf0z4Bfs+d3TEh9LbzogSDvhB5jTJlqD5vBhpuw3qqq+fRyPb7MZh/wv+olQi9kmD/gknIwzbL+X3YrvZAG+C/S/IIyVIBqKN2YMp/hqHzg/94wyPy0j/h2jNw1Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLW/aCaaiccvEzIyurULonPQUuoBrda8v2prmrkGY98=;
 b=GnCXJiQzeHsrgdU4E0Zf3UDyEaQB9+HdnR+qO9TaOZr4GmRVL73QyhBv4MO2Dq/FmO0cuvqbtM148rWX49yg9tpSSToCunB0/0r9Og9yJgtgn61JLZUKk4fjdZA6EbKopfdgJiNhJ/DtVHTNahQ3SeasEvZHhyRJxGzLTHK0zRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB7053.eurprd04.prod.outlook.com (2603:10a6:800:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 10:58:39 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850%6]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 10:58:39 +0000
Date:   Mon, 10 Jul 2023 13:58:35 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Lu Hongfei <luhongfei@vivo.com>
Cc:     Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH] net: dsa: Removed unneeded of_node_put in
 felix_parse_ports_node
Message-ID: <20230710105835.4e4pv7nxbatx7ygq@skbuf>
References: <20230710031859.36784-1-luhongfei@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710031859.36784-1-luhongfei@vivo.com>
X-ClientProxiedBy: PAZP264CA0071.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fd::6) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VI1PR04MB7053:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f9660dd-6b4d-438e-d12f-08db81349dd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HdDX39162vi3Fi2+PdQgg6+mhcQ9qHUANt2AweW60EV2PiZfYgOCjUrzpQutpDeTozdCYBTlWA9PkFlO6bavt86FEW40UGTCFRVPSx8G7A9aYa7HN1UDpJxiOHTM/4YzlFr1x2+/GhhNT6L7Up2ChuQp9rwJFCe0yLK7DGX7PjMehdZP9rXY9vqPJ2LK6tP+HCyw2gD3XYvFKrfo/St6hDWlTPyqfjBhsS1aUeyQ+lP+NfoXqDnlIbLoLhoQy2PVzQEqJQuHK57XAtwgAwj1aIHSAMFqZcAiF9K+e/+uVecUBXokQT0k15k2Cs64DsWPuxAx03SQiDp/xEJOf0W6QRVFPoeXtaw2OUQuecNjHsc8ENc222qAC7k/o78vgrzomTRKDMiZKA+3uVPRrHOsCZDXZSZdR6PwIODpCYJpC3Y2Ts+v5W4McHpUQbjnAJhmgSppCo4I6/z2JoquRSIJAOqpYUw6vavrSMrQHeomQyfajDF1omnjjW6b8hoRSIlkJp/3uzsfIwpQ95hY0t+g3Vo6OO+7lZQEJ1ni1Z/dxAxSQwPrAenTgRAqB1sInDEF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199021)(6486002)(478600001)(6666004)(54906003)(83380400001)(86362001)(2906002)(33716001)(66946007)(1076003)(26005)(6506007)(186003)(9686003)(6512007)(38100700002)(8676002)(4326008)(5660300002)(316002)(6916009)(66556008)(66476007)(41300700001)(8936002)(44832011)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BYn07SLBez5zsJ76tGLe8afdg7vz8P4Jsz40SdCCsC6/OXq0MUstdXTG5I5M?=
 =?us-ascii?Q?3sM+liLxJYVeR03Ie0JIe7OVQqs9HX4mE2QE1WbOzLPJchBZn74SUlUy2lSM?=
 =?us-ascii?Q?vAFfQSuiwmPDhbsOBEMnZVCNDt+8qDWoNVtA/bwcdbE2z+4Mcb6CPVQl7W9J?=
 =?us-ascii?Q?RTcFT7IfVS8kA5aI13P1sidsnWNpCnEMi/z5UCT8HG7u/IjhdHON8aoiRJkH?=
 =?us-ascii?Q?ojapdt3fD55S8SDJPBlU7CQ5JAH2qlM4jZ5ILUgbQ1MknotrnOQvj5fslFOm?=
 =?us-ascii?Q?BCWevf1EDaJIMi0TlgmyQTnELNHFUE9rvwA0cBL9/Z351VgVifgQScV7SYoH?=
 =?us-ascii?Q?MYXL3O8VCK3rKePosaBEdQ8YEgHTUXd1o7fgl2tLX4V864BODCY8DDfx2+2k?=
 =?us-ascii?Q?mJoTRQ7DY48wxxAEs1OCdAj6WVN4Qd7Yo0DQmlJJFuNgtWGqCAvTZcPK4EU8?=
 =?us-ascii?Q?nP9WQstHWYwWxZx9Y5+h8JG+X5P1NMxrazA3SnIHul9A1LZi2uWfYVqONkR/?=
 =?us-ascii?Q?DAh8HhFZRzPMHmEp1dRVtfxMqBEJyhNhukWVgBn8UraxenQ7M+1WEgGffws/?=
 =?us-ascii?Q?tySwXAErFbW3DrjwpY1uBOdE0HY1Ln1WkGIIvngPqPSrgSM5aezE3wiUmsoC?=
 =?us-ascii?Q?xY+zSxgsJsEtNKvhi8bT+HwyVDl7xnN7yYyRwxTe4r/ua2HPVvijMQVBFS2W?=
 =?us-ascii?Q?7SBGEwM/TmyeXf7MfaIsv4uj4QlNchZ79W2iOnWKGf7WNMjmeEQ3B0zIG571?=
 =?us-ascii?Q?zJocnKoyIjxvU1rGOEp6gR6hAyuop5cTDeIKKNi24Bj5spoAvO/bleX2YRmu?=
 =?us-ascii?Q?GfELpfpZbsSyZi63SUuk34TN40GCJOhIuxIyhG5rlhwdnWgRdP3vt6inxyh7?=
 =?us-ascii?Q?K3PPxxfB+j3tFl1v+wmlzuMk7fz4PmrGsN4y2v64g5G1vlvjWkw/0ajZriWD?=
 =?us-ascii?Q?6le/yGL3J0deUzrtjrMq6xOm4bW2naBz3Ujs8zkjlQ9YrAJLneUUlUyE6x2O?=
 =?us-ascii?Q?IG2126gBMdgthT7sKvMUyvehjtvVqqzuvflrNqJd5+d/g+8XX4G+yPaLA3LA?=
 =?us-ascii?Q?QjVUQX1XnhVGOXwep3zgIbAQwLbVlylE4dD0WZbDnNZ5FB0pzkR69wbdachh?=
 =?us-ascii?Q?vznQM7wOoL7NSR+2GqAuJj0v7Va9KdCJn98/YxU2USi8Jwio6eLy3Q7pTzdF?=
 =?us-ascii?Q?3JBH7/RwtoyyeISPTrDDTYfvlHzDy3dKvxMGtjyLWNQxU/5f2KIAaVn4KdTM?=
 =?us-ascii?Q?HUpJTXpnQ6IW1ql0GK34cmGyU7Ag/p/tpdehkEiwf5bNOWPRWrOC7pJppkPW?=
 =?us-ascii?Q?fQSpip2UI+7RqIicja2hEMTK78FPEukT9lItfGGLm2D80LkWCUWu+z+RI7xg?=
 =?us-ascii?Q?RB7Y14+4Ffalctc2GNoYUBw/1ngbwpGF3Bq1NTmbd6wAirDc4w9FW+wMlh99?=
 =?us-ascii?Q?WWpV2kqoxeLm+wdEDeM0afXDzR1N3bwbp2Dhl8WBajiM3zpN5F22t6Lpcsse?=
 =?us-ascii?Q?/TAyzlsAk1rWqFQPfmpSxrBdOTsFtPPbjBjBlUP0P8Prdj4zC01/BZSElDXk?=
 =?us-ascii?Q?J9uwUKBOMqYTXvR8UGXvgL4eBsIVUfd6S/n7F3Qhgpd/mbQYHWEgEK0Pr46s?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9660dd-6b4d-438e-d12f-08db81349dd3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 10:58:39.3563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHL1/3A91hp3jVqjRJUPJXjLmVei6i8K6yepg3+SLwoqlcqeaPFZfXhPOaTlNLaQNQfBiaCTuKDQG+yfgDOKHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7053
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 11:18:59AM +0800, Lu Hongfei wrote:
> Remove unnecessary of_node_put from the continue path to prevent
> child node from being released twice, which could avoid resource
> leak or other unexpected issues.
> 
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> ---
>  drivers/net/dsa/ocelot/felix.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
> index dee43caee19e..8da46d284e35 100644
> --- a/drivers/net/dsa/ocelot/felix.c
> +++ b/drivers/net/dsa/ocelot/felix.c
> @@ -1286,7 +1286,6 @@ static int felix_parse_ports_node(struct felix *felix,
>  		if (err < 0) {
>  			dev_info(dev, "Unsupported PHY mode %s on port %d\n",
>  				 phy_modes(phy_mode), port);
> -			of_node_put(child);
>  
>  			/* Leave port_phy_modes[port] = 0, which is also
>  			 * PHY_INTERFACE_MODE_NA. This will perform a
> -- 
> 2.39.0
>

Fixes: de879a016a94 ("net: dsa: felix: add functionality when not all ports are supported")
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
