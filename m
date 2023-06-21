Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8AD7386BA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjFUOW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFUOWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:22:24 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2096.outbound.protection.outlook.com [40.107.220.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1E31A8;
        Wed, 21 Jun 2023 07:22:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYebmFaGQHw3JKoMNg/OHt43x0x1AqwDsIjjthJlBRJfgbwExiKSnhkoxw0vcGBpsJV8lwNnQE019BRwUmwO71cSl+N7idpBpfPgLimhTaYbkyhH8duIfDk9pDbqWBg0Q9CyZG/nClAWuNKbUTsdzgVdCcwYjr4Wmb/2FZ7UCsykYkFxwwFYBqzVyxPhL8xG2TgmOLL/J0hwA5GpeW0hYZNUZog8OuC33N0krRpUp6MMltuBNQMwcwfdyDMvu1qvWmhxd8j9z9cV6gpxvny4OsQdlVNd0uVqjFkoBozkdHYR7pNWTv83ChY1jY90K6qX5mo520Ee1BBXXfEoXyDAAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5QnfovQ49mRFNrqZ2pBPnVHS9ooOUAQE6qwbTqJt0A=;
 b=DFSokC65aJ/5X5dEJ8CQXCGKagHsgNNUUzeVpoc4Dc4/DxJQJkq3r42cwXEktyJRYMM1PGU9zNO5jgEXGJE5nv4pGUzRNUpMwAr8jr0T8gYL4EenZCWR1rfgdRQTkoNetB+5QzdNKfP43jSwlf1nvuSFiiFvAHHbnAagkOKOwjteqc8R9Zxfyv8QgU0wKxy7BtrukgKT7GZI/wQlQsqrqzlFKsfjhAj1GbjQg/cQDNXG+nw54oq+Dizx1yxE2vpEIyZ8CZ/aRFo9OZx8bbvH7AjKaFA+m+vPHRVNSxiw6iIs6dn1OiP2aU5vRcAUf6CiCeaCspJienIEI2Z1UINhAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5QnfovQ49mRFNrqZ2pBPnVHS9ooOUAQE6qwbTqJt0A=;
 b=oTPpttEIDvvngtWPne+XrX6PKb7VAXuevvJ2gxATsIpfscc4kuLrm52FvQTQfSo8a0SmyE1zzgin/5NE6CubzekFfNofkmelvHjVLLwQqLzcmVUFbKpeLCMxVdG/EVBidwfmtz5k3UlPVwuv/psO07shmH+VPl1rA/9+oBGUHcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA0PR13MB4143.namprd13.prod.outlook.com (2603:10b6:806:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 14:22:19 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 14:22:19 +0000
Date:   Wed, 21 Jun 2023 16:22:12 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Markus Schneider-Pargmann <msp@baylibre.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julien Panis <jpanis@baylibre.com>
Subject: Re: [PATCH v4 04/12] can: m_can: Add rx coalescing ethtool support
Message-ID: <ZJMHlIp9x8HL97qT@corigine.com>
References: <20230621092350.3130866-1-msp@baylibre.com>
 <20230621092350.3130866-5-msp@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621092350.3130866-5-msp@baylibre.com>
X-ClientProxiedBy: AS4PR10CA0013.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::20) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA0PR13MB4143:EE_
X-MS-Office365-Filtering-Correlation-Id: 15fa9438-6726-41ab-1a1d-08db7262ebd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rfF2VJ2ZjDJ44L22uR7sI/qFp7XNbkQYPwILaiKYDcA9aP666l+5uxEHv+XLc8800ZdnsdKnsKE5/5v/FKHMhCx096PVbK+uBEV6m6OZVwKcpAu+zI1jc/KswwbLTO0mVbHx+uHdRn/6L8ROcIkpXXHB1hsnwk1KqCOZXpq/v/oiX8RZgv4hRd72qphRDOGcsxs536GTGvt7P4SIPod0nTqYtqpTNOSKLRagQr9jImUw2TyekbsMG+Wa9JMmnjGgbUN+WVFtxkAiVFZrTFd4StOSn1T5BppSKVmiZAV0/3ZQTuGGZBzDt727qirdpEvodt3bcdHVzNOwBZ7ky0BnLM2skbAIrGNyC7ynwR0MM4fOKJdDPBHW4TqM/NyeFnZ//YFBrWseGx33uCAEHCoKLjC8Jw6eCmqqWSggF38msg/SJ2Z8UvqFamwom2xDYn+XXPT/Woz+mB/GRtSAJbS0WVAb6aM5NIoUzL4IuaXbsymLJ7InKmNsVrvEAzKuNhXWNPVk2gn6Diku+HAzxq2xJZo0Ay4MvQNyu6a33xkXrlggHmQS0UL9U6K3HIOKHlq16vXYSpnhJkNFx+PF2IEp99apo8yWJWYYOfaknTuKjhw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(346002)(366004)(376002)(136003)(396003)(451199021)(38100700002)(6512007)(6506007)(83380400001)(186003)(2616005)(44832011)(7416002)(2906002)(41300700001)(5660300002)(8676002)(8936002)(36756003)(6666004)(478600001)(6486002)(4326008)(6916009)(66556008)(66946007)(66476007)(316002)(54906003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QT8rZwBSSdohHEF22+IseKRLVZ5F/7UzzGpIwqHoRO3DAfaV/o//fRNYaXZz?=
 =?us-ascii?Q?HHGMwhfz/D66TN8hDVUmUSCk/sIezaGKoAhRnnhyu5+KZHnqVIIMN87iiPEx?=
 =?us-ascii?Q?DuaoVPmvcqeQzh2K57DJUcujpRQp8MVVOrtLoBecIO589o2nEVrbwPXPi+71?=
 =?us-ascii?Q?1mPgpDT78nsy3bxxufiOS168uEThEEZcRLK/8auO2swvd9GRIKdEmSvDAlBq?=
 =?us-ascii?Q?ZfxF3zEUNBywXQ5ea3JC/ArPF4iz2TfKWGNAWN2xlXm8cqDjk/5aDAoJppc0?=
 =?us-ascii?Q?/vPRljpLaL9j/OhiX0ARrCUSRv+r2dmtnRGP+Br1FbeyUaqFp+nzPp58Ry/M?=
 =?us-ascii?Q?ax4R/4CGj4u2K5KvGvc/xik6mY7FDpWkIxsyIP0/nKQgJ6DohAS09LjnDZCa?=
 =?us-ascii?Q?q1vomLTJSNvhKe8jzc1r2gzaSgY/PdOjPl/JN3rF09ng/mJut9KHIGROLBI6?=
 =?us-ascii?Q?Zbf82EhdLL4D4EC4k6eN+33NxEZlOH5xr49EFd5NqIs6oHHLbBFk2opQjEDG?=
 =?us-ascii?Q?8VEv69xRlaonBYWtyhTdVSYCWooy2gQ/8P0Oda09UiMNa9RIA4raUQLe9pdk?=
 =?us-ascii?Q?bfd+qXmPLiJkTb0JZ/CakbJEwW/ok1O/abBF247Chnmz+h3yTfrs0zBe3Cqt?=
 =?us-ascii?Q?t5illsbeZPfKBrRy70BG/ZX/cxNnJ+FqLgA5zne89EtRoZ4FwcPUOu5qkQtE?=
 =?us-ascii?Q?AGK3YPwGMy9uV5M0PTXDWzomQRTv67GZMHM+R9UZD2VcKFkI07+5nYjAFAkB?=
 =?us-ascii?Q?s5baOiEFRTyzsYTMUFopo6wcG9BgagDMTXtQPSxsPQk5J2RlwEzpWQyblgXL?=
 =?us-ascii?Q?jqwuk7M+4ytbpJe7d/aGeMeHnaIRUyhHW7dy1xds6/pBGj//W4PqPz3wltHi?=
 =?us-ascii?Q?eCG2lT1AYiO8bgDiMUfRxH3JAbszF4bABGrTbkaXkOrjgVWDA2EjsQ8KcVY4?=
 =?us-ascii?Q?aKOxsUqML9PZV6O6Q642n/m69eYA5459HlIJ5aa2gT5Kwv21swJaQTV8YSN2?=
 =?us-ascii?Q?/Q021Aeot8z+QbYJn131G3/7XSlnRGcUcPo3pTDw8KvLYTX9ptezf4AQkA9I?=
 =?us-ascii?Q?2PxcQx6p9KZMLu0Q/3mwxIVRr+tfjQKDipxba5LxheeKaDfVwFHfP0WAABlX?=
 =?us-ascii?Q?tnHgsFtB3VV4MrDoAYFvkX6Abd7Xs5/70zXyaJ5aAj9ryX9qXx/gYGXtykaX?=
 =?us-ascii?Q?ntNBAMXnim0mRs7UFifKySsjdW+wHKCt8sVcsM0jrxcslg+ys9lvvbf1hMxI?=
 =?us-ascii?Q?HHDT95plasmr7Uocv6HuU4kjdliiUIrZ3Rj3jf/DYBVAQqcwxCS88ybo6NZb?=
 =?us-ascii?Q?MiHlKG4pyHbe4EjBJyPpO01gQj4kKBXHCUKsxQ+NWs70ebN3xBqAIl3E/oia?=
 =?us-ascii?Q?YUBtR9cBsi47TVaZ+hli/sT7frpHKV2z0p4lMTLSowwdDO77dCPj1vSovsZk?=
 =?us-ascii?Q?F5oWiiWpy+CqnIBPY1M0aljNWKglPePz6nq3btE7d0BiL9sC7bkqpm3aAZc+?=
 =?us-ascii?Q?bwjPGWYgVSCW/XNA6OD1JxKcKfIENLPxjEyhP+WBsyfnA9DH+u3HqQgIO3zN?=
 =?us-ascii?Q?ByIPD7gOsCwu7PIgvDgLq6+caxKrUPejtlQTfyvG3TKq5gsmeF/T2bT7Akz3?=
 =?us-ascii?Q?EpKhAeuDtWam6nb9yCxNHpavQFGX/ifOzWFdAs4TveoeCDbOX8FTdkOOvzVH?=
 =?us-ascii?Q?56lVFw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fa9438-6726-41ab-1a1d-08db7262ebd5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 14:22:19.3099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHhEzqGY9NTUT585dc2tvEdMiBcuuCQ7cL8rjSbivhXMhE6cSqNvgzUDQIubJ+JDqAUxR/CXnrHHoRkAjUDjbvUxghjKgGezJVIT6ysutjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB4143
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:23:42AM +0200, Markus Schneider-Pargmann wrote:

...

> +static int m_can_set_coalesce(struct net_device *dev,
> +			      struct ethtool_coalesce *ec,
> +			      struct kernel_ethtool_coalesce *kec,
> +			      struct netlink_ext_ack *ext_ack)
> +{
> +	struct m_can_classdev *cdev = netdev_priv(dev);
> +
> +	if (cdev->can.state != CAN_STATE_STOPPED) {
> +		netdev_err(dev, "Device is in use, please shut it down first\n");
> +		return -EBUSY;
> +	}
> +
> +	if (ec->rx_max_coalesced_frames_irq > cdev->mcfg[MRAM_RXF0].num) {
> +		netdev_err(dev, "rx-frames-irq %u greater than the RX FIFO %u\n",
> +			   ec->rx_max_coalesced_frames_irq,
> +			   cdev->mcfg[MRAM_RXF0].num);
> +		return -EINVAL;
> +	}
> +	if (ec->rx_max_coalesced_frames_irq == 0 != ec->rx_coalesce_usecs_irq == 0) {

Hi Markus,

For a W=1 build GCC 12.3.0 suggests, rather forcefully, that it would like
some more parentheses here.

 drivers/net/can/m_can/m_can.c: In function 'm_can_set_coalesce':
 drivers/net/can/m_can/m_can.c:1978:45: warning: suggest parentheses around comparison in operand of '!=' [-Wparentheses]
  1978 |         if (ec->rx_max_coalesced_frames_irq == 0 != ec->rx_coalesce_usecs_irq == 0) {
       |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
 drivers/net/can/m_can/m_can.c:1978:50: warning: suggest parentheses around comparison in operand of '==' [-Wparentheses]
  1978 |         if (ec->rx_max_coalesced_frames_irq == 0 != ec->rx_coalesce_usecs_irq == 0) {
       |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~

> +		netdev_err(dev, "rx-frames-irq and rx-usecs-irq can only be set together\n");
> +		return -EINVAL;
> +	}
> +
> +	cdev->rx_max_coalesced_frames_irq = ec->rx_max_coalesced_frames_irq;
> +	cdev->rx_coalesce_usecs_irq = ec->rx_coalesce_usecs_irq;
> +
> +	return 0;
> +}

...
