Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0236373F8E5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjF0Jma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjF0JmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:42:24 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DC8E54;
        Tue, 27 Jun 2023 02:42:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUOFOVgJlnmEHHNVLKJD3gYXNr/2bWbrbJoDyIFK35A6m33R1mNl/Fpr56W0HH+afYVdA1PtGrPsshcwvVciEyIzWqyXh/adS95gMNvY8KJvGx5dikoIfL9veW0lNRsJh4niPXBpFogRQYZhmmorKkIqtCdw5eR9XWM0tDRrtVxWeYPScT0kCWOCrm2NB3Jj3W+A7uppBd9nZ7S90za1gPobYQ5/+kgMQudYgzjg/WJKnJdYvDdAUv0JQwm3XHFjTCHmf0FfQQ5Oxhb8kun1q+HmftwITi3luyDoJa/GSZIL2/tFxlCUPLTcWhsYqg0JVxymKUm/IBWrJafjpvvwLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u60iQIfO/ID6+YTdWwmhgTGiq7rLVh44RiUFP+VOtEg=;
 b=I7tG/p+PGyIcEMp6OZlNvAUR3/PvhFr5ruC4OJNdKMBN8ArepcUrECWdkLzejgRb/KXtPuRZwuooJjAxAGr6Mkz8fiogP1Z72pG0ja84Vnvq1lqICePtboZARHQSfilNrEghKmvHXQAR89yCOGQV6MNWJb9zIOfpO77UTvKUGzkiU4/rLuGp36Kl3ViWSMmUBFf0eq7ilqJgGJI5wXGVNVojbCjooTi/z07fKnvCRxiXclFgekUelw13W3vb5WZfEe7YilBOjR6xIbDaB6BRvfKUXVx4Mq5ntsw44oE+rqAJqq2pHCP7jVSulSd1WX8emvd9M2O6hfrq/z26zbiYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u60iQIfO/ID6+YTdWwmhgTGiq7rLVh44RiUFP+VOtEg=;
 b=f/trbcWHtzgJVv4eBMqTBa/FfFSguD84ZKomZLOfY8c/ZUxEezpCjIEk6z4XE3tN6MM4bAx37cDaACA/oRa4vyekibdKsSsoINu8vq2XUTfayw38xRe13U/dWuiBHoaIzWXvAWNZ2zyhOKrVEWQF2zq1YMD9s9clgT8ZRGG3AE0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM9PR04MB8649.eurprd04.prod.outlook.com (2603:10a6:20b:43c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 09:42:19 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 09:42:18 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 0/2] Fix PTP received on wrong port with bridged SJA1105 DSA
Date:   Tue, 27 Jun 2023 12:42:05 +0300
Message-Id: <20230627094207.3385231-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::9) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM9PR04MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c71046-951c-4de2-ea1a-08db76f2cc6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CTH4v7jWn18G47kbKGr4ka5+1rduj3WPYY5mKXzQSWy3UqyJDPOhXhqynSu/AQk+B0p/UArfmyxQLP6UtFJ3rG3BhtzYzrAXxZ75/m9jXgng6pGe3ANQfi3WXjeAjykeGopd89tO5hzD7XII904q9PE84ygP5N9RQKhfniDjM6pjdptHYmDUCPzz75ee5gyfqBip6dRUNr/Gw24LvGxwB7pD1136KZt0THRx4xvIR6u32J3mXR51NRkYwTDYCS3+MNyi8Vl3jZ43DTI0q60fYylQDnDVyMCQ6Ncfjx/fnLQXnC9IGtRGg7UlrbHredOKLOT4FRAMFWLZbUji48GVg7Cok8DzyrL/bmZTcJgyso+ThYjRnABo9SKA+N8XSUi8tT3Y53sGoPthHiujyRTU0BjkR5zv54r2B60+qmTcQHaWw55Ekvz0uwrsJO61lTCu4vqjKYqAa+PvI3NedQdrJTLsPT9Rvw5gqq2KSU3i/BJnLW2H2AkaETYpZCOP9sluKPLeOsi7oo4ugaivtS1dBk/EauUGoxhe3zJ63NjhJ5AjyYK/ZsvtwVQjSb+38GEgcIH7VlmTSfvqboi/o2NktVP4bwmQE7tJhcqMtuFCPzl1fiNE21nHW9+B7iF2GSc6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(1076003)(52116002)(6486002)(38100700002)(26005)(83380400001)(2616005)(6666004)(38350700002)(186003)(6506007)(6512007)(41300700001)(2906002)(86362001)(54906003)(478600001)(4326008)(316002)(66946007)(66476007)(6916009)(66556008)(44832011)(8936002)(36756003)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NW0Fz74Qon4liDX5nrQnrYIq1hy8eIzehDNhLAPrLDa6tNoA/2m40Ngt8A21?=
 =?us-ascii?Q?ZtCPSsFpxXWE2L9lQp7yFKAqKB1f4EOIJo3gcFcwwYOTpgAbcK5S9va9jxVS?=
 =?us-ascii?Q?RV9QDU/oUfgUDdimGY9WIHgefCYyDUHKFXv3MjdM3Qe4l2xpqboHlwdol8pv?=
 =?us-ascii?Q?aS36oyyC/7iWb7Z9ZD4hnDN/S0DebfDxEmZAneFut8na4w/4/EHuOT0w2ELE?=
 =?us-ascii?Q?9T8aPlEyw5qJohqHNYLhGT7qBBQ98SDoWm/CEfbk2DYwj+UCypRkoeuIRhBz?=
 =?us-ascii?Q?Zu/3vC0aqnxckreQhwi4IlskPXkP8nb1E40v19Km6cfAd0x5cGIWjdIn/13L?=
 =?us-ascii?Q?aTKkaCTgBQ0FcK5BmNrSMEc4LShJXURMfK+Rem9egvSzCCrhsrU+PKm4i5aT?=
 =?us-ascii?Q?74oad7PuWYB+04VkSsilHAYpA8Scl8Mg8ISsvpBOs17Pz/UAigbV33G0WKu4?=
 =?us-ascii?Q?QpDQanDJFSZU4pvJQZ0wE0ZLl+ZFpk92HwEsWXjftAUkifAbmYXD9/BzD9+c?=
 =?us-ascii?Q?o45S4qj9C5R/aSuQap1FDyAOHb+v917g8fqEyyJwfmSfABpxm0vfNGtFQE5m?=
 =?us-ascii?Q?v8Zfn8sE4/Lfg9p85m8n67Y0PUMK5Rqb4ypx6Hi5K8xmKTe/069bCNiEnvjV?=
 =?us-ascii?Q?t9GMzhy0A3deJFEQw+uT7bMrt2HIIIcwDokauK9+9t868xdImCpUmU6JKVqy?=
 =?us-ascii?Q?yJEZiCVuNGM2+EydbPDP1/KBk7SQ73w+jOWS7NeGQyyt7llyxk5LhR8OanwG?=
 =?us-ascii?Q?/SwgUl2C2ReatVZ/ERLGjWK7A77rLxieGAV4B8x+CogUd7iU3SEOU1KGGUT8?=
 =?us-ascii?Q?xJTvpDVNkgiBSM94wAKoCGRDqiDb6MvQiv/uT5idpGJtJ74KrbSIOC1vKuHu?=
 =?us-ascii?Q?xUKxtELLNmn6uiOxhIaKLr+9nuJWN3B82xOFHOSpXZ1oi+VnOGbXxrac+nGi?=
 =?us-ascii?Q?xBden5BVI0qE5AeaWapWg9v6x/3iX7hwR2qXMMzCCa4fOqQF0G8/d0l2AERn?=
 =?us-ascii?Q?3emAr3bRizOpupg7s8+s5pZlC8dVjIIlNWvE+xrfFnhtBCOxK5U3McsxcrbR?=
 =?us-ascii?Q?d7MCRwFlNEox/+TCVKYyREekT4cUXMUp1HXI/Y/SsCJYeR8szn+fZ7Jmpm8f?=
 =?us-ascii?Q?9vBpOMbP9hiaILxg2dw02KbO+TPrr0gy+KiqNtWDGMXHUA4adwLYwPmZxBOD?=
 =?us-ascii?Q?A/SgPxVkLj7RZx+ajhbyoL56vok/phkl25DA7w87U2Vo/2EtU3ToUINvkTZb?=
 =?us-ascii?Q?ZzmGlvuPeEp7u5SIVSZG6m6qpgmTExbw1A914RhkKKGmAyTT1W53NC2coWr7?=
 =?us-ascii?Q?d6cETjHS0cGriA57zIiLXv/DE8jg5EUTH4RAUZZJX0xLL1cDjXHB+J5oOuaD?=
 =?us-ascii?Q?dIfRaYz6vpKpyjyBxc+YRmLazq0CWU7EIrQi9b74VAh7EP3nNRtZg+a5GqeY?=
 =?us-ascii?Q?9QzrjwsXsQmVIbe9xe1oLrkt+8uvrjeE+zaFFzEuKP+7FTx+JweG3Z23Hm+c?=
 =?us-ascii?Q?m3qoM/7vLzslcskLlCrt2WrJo6ka7xB8AZakOgso6+uzJ695b3vJJF4HECQw?=
 =?us-ascii?Q?SSI8JfyS+zR01iX61rWS5CZcwAYmwAR3wlk8dwYB+zUVXkP5RdD5uPbLyZMQ?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c71046-951c-4de2-ea1a-08db76f2cc6b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 09:42:18.8553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPPXuOKbmTY2JsdVNsq5YRkDmZkT+X21GjLPhmdTS40HYjhTIQSLW7Iz7TOWIqi1sOc3aP96PG7K/C5NXCRHgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8649
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the changes were made to tag_8021q to support imprecise RX for
bridged ports, the tag_sja1105 driver still prefers the source port
information deduced from the VLAN headers for link-local traffic, even
though the switch can theoretically do better and report the precise
source port.

The problem is that the tagger doesn't know when to trust one source of
information over another, because the INCL_SRCPT option (to "tag" link
local frames) is sometimes enabled and sometimes it isn't.

The first patch makes the switch provide the hardware tag for link local
traffic under all circumstances, and the second patch makes the tagger
always use that hardware tag as primary source of information for link
local packets.

Vladimir Oltean (2):
  net: dsa: sja1105: always enable the INCL_SRCPT option
  net: dsa: tag_sja1105: always prefer source port information from
    INCL_SRCPT

 drivers/net/dsa/sja1105/sja1105_main.c |  9 ++----
 net/dsa/tag_sja1105.c                  | 38 ++++++++++++++++++++------
 2 files changed, 31 insertions(+), 16 deletions(-)

-- 
2.34.1

