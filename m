Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B53E73713A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjFTQOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjFTQOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:14:38 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2103.outbound.protection.outlook.com [40.107.237.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB39F4;
        Tue, 20 Jun 2023 09:14:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEavZJF30yiVBbUO/lYYN0P9IeznMQG7LIrNeOC+17Fd5adZRZseMq7X/WO37JzN9U8s9PbsLfAKmCE4VPhZVwSciMe09wF6RLcZTiHMtchP9VNjd/vD6LlH9ZeTBmku2TOZ9ThKODRiX5RRfAy5h5mHPQ8+BCj+Nk2j/Va1kdNG/KnnnFKfgrAU5nVwqZuZZ2htkG8+uO9UcsNIF13N4oCHQAWY+htxIy2gR2lAA2FlDVWQ1+WoAZT4JVIWSMWfTwAZOhIYTAKA1uB0+SkyO9ZHwzZ04P1cquBPG6rOWXBnK6hWzvwTUoHe32y3YJO6IF+fzln1D4cabLlj88uigQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0GVYqCTtzkoR3gdnlZ7nbQaG+hnPiIaDi25XOF/lwc=;
 b=U10+pBsbkyctY1rOEf7xidW9Xz5Cn/UmIAR9G1mXcGwDKX59iMX0Rq/dE00icqCvD6j3ldCGHP3BnnCNkSkYACb0zN5bCJm6yBxARvzj08PdbOp5WQYL+xNFafr9UWiHpUmXUMlZpsCjokub44nl9NBrS+j54tcF6LSyZP6zghHHmNjDSQYlSA9aL9Wibhn7gK2BpwBe0Jgxj5sX3jLD05yB+XwBn22dGIqQNSZDU1g5kU6WJ9y9e3+14GmZKAKRfPNBEX5und6/XRJ+K78FIVghDaeW/9q7cnap8SBhvAkMqEiRTVCQyiPE2pZZChefyvxLyEyMXuqWfgSCG5hSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0GVYqCTtzkoR3gdnlZ7nbQaG+hnPiIaDi25XOF/lwc=;
 b=PoY8LpDT3goOmtiVl2oA2jPRGyM4eNS5+wV317X7Sp5jheXMANZ5g2Bmp6cTJhccuhPk14DZKlTIIJvLrbb3pIVE3yKGGoaqdIaUnlOG4WNJqKwU6zIT78vNrmWiwAacTtnTvJJNBEV+cfXM/58B2gV2oE0KVU4m0oVerYdyDVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH7PR13MB5892.namprd13.prod.outlook.com (2603:10b6:510:15b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 20 Jun
 2023 16:14:33 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 16:14:33 +0000
Date:   Tue, 20 Jun 2023 18:14:26 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: dsa: microchip: fix writes to phy
 registers >= 0x10
Message-ID: <ZJHQYqbdTBKhZ0Vz@corigine.com>
References: <20230620113855.733526-1-linux@rasmusvillemoes.dk>
 <20230620113855.733526-4-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620113855.733526-4-linux@rasmusvillemoes.dk>
X-ClientProxiedBy: AM9P250CA0021.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::26) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH7PR13MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: 85330301-bab4-4ab3-98df-08db71a96f30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: plsjLsW2P68/DrcsJwGxu9hi/8U7FyiODpwLYjqFGjdnw7B4DCRGg0muDO781ZzS1nxA/N6Dwq5DkUsVWHHTELl87qF5RN/zt6GEzrWRzG/ml9oR/eLQ9E8N1fpAUr1wVitfoUR8rLiW5MY5TMkszdagfB/07ulYhwB6f4QyPrUihimvS87AIdi4kU0t1JNECoWIM6VEKWV2m9cM3bFzRVj6qjyYTPevP7NOJhjF4odOJknkAgfItOj7+wvRPMF5k8h/4WTVOtBSwEYFIMWP+NqG+a7XJpvP2Prr3y9DCLrWMgChAfTxCteL9g79m3z1u0p49WiPwyTXi3FVAUU82JWJFy9vApWpaOsmeOCfcRyc2o920yk+oWfIqm9TrVRQxpqOxzdrfWi6k4+sSZ4tPb5GSPQNvf1HWvusYav8hADXjHJtaIHI56uSDgqmEPod5LlSdg+XBJihGnTotQ71o+gr0YsnNG9OYhUlqSVlniHvH1DYiMEOe9zQWLmusQ7ONBPVMQKqBTcI2aMQAPLD+KKA1zLe2iXVOv0vIyOWGnEtz0dPmpKfOWUCv/oLVUhwbLWMsSNPqenzy0fa+7Th/wL4bF6/Z+SeTmcqUCtSgIc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(136003)(39840400004)(451199021)(38100700002)(54906003)(6666004)(6486002)(478600001)(4744005)(2906002)(44832011)(5660300002)(4326008)(6916009)(7416002)(316002)(66556008)(66946007)(66476007)(8676002)(8936002)(41300700001)(2616005)(83380400001)(6512007)(186003)(6506007)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qe4QxGm1xlfbg97+C0V7oOzPtRFF7Fgzdvig6AFSgNino7fMKA9qVsmOD/yg?=
 =?us-ascii?Q?NQRYMmpK3mDGItZvwbD1Z9pCUBIa5MyMXkQoijaZoFy4HclDcXJQ/SDbNVj5?=
 =?us-ascii?Q?R0X+hkNast2BGNKdgTZ5qoueiOX/7Z5Wl+D/869bVZBsGAXPCU0Z/BCMpOoQ?=
 =?us-ascii?Q?a8cZSQdpkMRDDSvkGG5jz8s/vgQA2I7J/3hxILiRA0hOqhhhxFS8K13dGshE?=
 =?us-ascii?Q?Vpw3hh3CQSVtWjsfW+XbL2h5GEMb6kJu6jqQJpsVgQ9zcYmrEt4v2VqdPNaL?=
 =?us-ascii?Q?rOnND1TD3vaafnciEb9PVyzOvnOrBxpX6yakbEzQdPWns/TA7q6Dvik271RF?=
 =?us-ascii?Q?XHUwjrYTO4AJyEZf1wBnipV7DTUyZVKtUqe5uuAkJObBjRdtMl+hzWT7O48H?=
 =?us-ascii?Q?LlygEFDTCL1mBiG3X3MqQt5m1p5FrdVPfwTXs78MZFIpBefs5go3rxzLk9Pm?=
 =?us-ascii?Q?KgWmuEuifx2UXwg7BVdFfZXjZkfbqWT9R68yieviuh6X8gISE5esOu81pjlw?=
 =?us-ascii?Q?cGQjNWn79uCXjcvv/zCazw1MJkHoj/25T6xssdsudxr/DT+/FkufTt2NyPgZ?=
 =?us-ascii?Q?WwUUTjV53Owxx3wv739U9dEjEffsid1VyjzdGIYwSw/KKBB74InwUzlvDGxE?=
 =?us-ascii?Q?g1x9L+5LYV6G8T3DKn6f2KorvTfKV5RPNkfnSFqnyiffMBH05W0ismVt3lkk?=
 =?us-ascii?Q?YNnJq3gyD4WMYl1xR6OIoUzHJ+3PoNSOPNFqRQjNKupsC3Na49qhmRc1a45Y?=
 =?us-ascii?Q?/NyV0MvEPf2ZAUBK9s3/uWzutZytoYPPuUXrJ2/lKg9d74/gFm5uiDRH3/tR?=
 =?us-ascii?Q?Dfm3oHw9w3XMKQfiAsDeH7DbUWJEe2Tg6fK4xlqDXMACd/mcheNikLPnP05w?=
 =?us-ascii?Q?KhZabib5Hy3aWPHsEuSsCPDsaolU81zNWFBYnfTN15e2OlvRo9dBKa0Xzgwz?=
 =?us-ascii?Q?DNGsQfQpnyyonauq2QSGX6FC8aLAUWEohHldLRka/Kx8SiMsIhlwgWbXK0iM?=
 =?us-ascii?Q?iolOWhoKJ9qV6BNwXGJNqV4PqXJ2+ph+yDBPx/YRxw9rOA3ytBVuDlYq3Eev?=
 =?us-ascii?Q?44aoNoiWRTJAUNkJe+62f7+bODy6dJroXcKxebxHrrsHyXdEJhI/qYUEvgGg?=
 =?us-ascii?Q?LOTwzVLOMtqGJhAajBMJJQU0ZqluMoG0tRDKGwEAHdSnNPtZX+LOC347xZ0z?=
 =?us-ascii?Q?1iDMis/ZyZpRKIp2HENSuLGnMyI7lMcgdTTrSz+xwTMaX46SFczwTPXUjn33?=
 =?us-ascii?Q?rQHBEx+oMJNO+Ynw2sq1IU7nYMIkSS2uxDaLvI1Teb7rMqE9gSW9OFXdZHpj?=
 =?us-ascii?Q?CjhIu0Wd1pmiYgLxX7Bb3ulL8gml4AUhUIYO7KIO3h/IiSAoYpqqxDp6Um0j?=
 =?us-ascii?Q?QIu2nY2FbNLyCda3H5upr3I9wBxFvUQG25JUu2r+ejs7zOrnbZyKhdI0vugc?=
 =?us-ascii?Q?RC9fltqYFFq2bKigjTWNvF+KdxTonLmgL51/hc3gNYo7nh0fzzplaNdhSwFQ?=
 =?us-ascii?Q?ttOpS1M9m2Zs+KbDwFRw9aj4K//ite4+3A1dTAdM3NCIxJ8/fbOkXGemqT5T?=
 =?us-ascii?Q?f5JMvGwUHonjvr03HArkcNqQUSdMS0FUIqcdbNmgbY0rlcGFpae5yavLqh4u?=
 =?us-ascii?Q?Jq08H3CH0K4RaxqWytdwXXAKORoyPd0q6F6MwlSbFT8LPMYY1AacCrxcDybI?=
 =?us-ascii?Q?DZLyzg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85330301-bab4-4ab3-98df-08db71a96f30
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 16:14:33.3899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tP9eJ7hPNYGBH77N9j6Y/DEwQCQQANbA8mBusqFKz6IAh6bbNNe6i7yPDj3/BuV0yMYvUP0aLg/7j/fI3DDoUiGt+0dH6RgXx6aAFu/CHgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5892
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 01:38:54PM +0200, Rasmus Villemoes wrote:
> According to the errata sheets for ksz9477 and ksz9567, writes to the
> PHY registers 0x10-0x1f (i.e. those located at addresses 0xN120 to
> 0xN13f) must be done as a 32 bit write to the 4-byte aligned address
> containing the register, hence requires a RMW in order not to change
> the adjacent PHY register.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

