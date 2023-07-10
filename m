Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCB274CA50
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 05:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjGJDTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 23:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGJDTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 23:19:16 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2115.outbound.protection.outlook.com [40.107.117.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98445EC;
        Sun,  9 Jul 2023 20:19:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZPaHIvcXjPlrIaYHE81xK9/WPDKxUdkKEPcJWs1N0G/XC7x1uGu9JMfNlEGTdb7htWWjR43m+2gHbpIxDPn2XcnSdoI/S/J9oHRISCg6Mdr8Vi9M6l2cp6Nm1TVU5hCb85hJvyHC+3Xg3HXyMRk1vBZn7yXdic3mxEAYAZqFLh8k9BFBCExuNVw8Z2N4ucFKz3zm+w5MaFoM66+carqX42+DD8X2Kd+s4pT/099YpBut/FrKhRTZ2gkbIE/pCG13mahOGYnilUym3IvaK2ke5/yaKlyhhIdeoqA6BzUpSdV9A9ivQYtobuPkHq5xhDMAj9QoG2qKoTunSvwxOMwOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxa8InV55vWyEERTbPTwvBYLSIN4XvPwJyu9WVea+8I=;
 b=D+91F8kS2VDGf9vhtMnFHIXijMXF7dMUzkVCTcFAjhuUFp95jfcciH2F6hpDF4oAbi/+iyPAXQTqC1bpPfX3fKRnPtBoD/0DpHeQQ9EMqPMpEECQ9kRz8DgWyTKcaojs5b28o5ie+jgo14D5FzOmjcgclDNsiq7RHWFAjVfnQkNXoOaDIf3qEke+6saBG9Vfu/b4zru/eKY+d6IUBLku1OKAVYlsWsJzaA0vC0j0DrvuKTHvEgtIbesgYLoV69M29yU+XVGsutC0eXDXtJ9ytp4YhLFl55MTb64Yn3X4zpCnVVoUVgaQCFUsGpg4LI9TmzqD671NkkApeIZM3gPJ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxa8InV55vWyEERTbPTwvBYLSIN4XvPwJyu9WVea+8I=;
 b=KnqM9/Kx3MtVondCermaS4k77tc+XEjUoCYtCmq8VEvdyfrwZBQD6SlS4PoltOrNOo2GImYT17FhN5qPDP2n25Bz6YDbmfTIit3lO+RRxmxhQ+fGExXcec2b85S7PPnVcjPJAeY5BVfrZdd3dowGRUuJ+zXj+tVO3zceIaar7b6vh8WjVDx2l7ZsmZ3NwERZZ1hyiyMclTKG+vkpYBk/OX1ZbzoZ2eB7j7wXuZkerkDzZ3+EErWrQVcGpu5qWWsrXLI43i53GPih/lmAA/iqQYwyQy+YXpDnVr9bBUb3jLEE6B4YDcSmYdiJFwTMI9AdENOk7Vax1tjYSfslDHsKPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by TYSPR06MB6606.apcprd06.prod.outlook.com (2603:1096:400:481::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 03:19:11 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::8586:be41:eaad:7c03]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::8586:be41:eaad:7c03%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 03:19:11 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH] net: dsa: Removed unneeded of_node_put in felix_parse_ports_node
Date:   Mon, 10 Jul 2023 11:18:59 +0800
Message-Id: <20230710031859.36784-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0066.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::30) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|TYSPR06MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: ba25be94-1963-42e4-8c6b-08db80f46dfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /1Cdf2b4W0/RKuLmjRjceHP8MZskZwPvOo7S/ZKlnQUFCa/61fk4nk6jd9RhoAhoFFvVsZfWlWf8WhtgE+UbuNJ1/r0l5gw6v3JOGFcC4HXtVt5qzvdfk39z+vM3eYqTAebxZHygbrnKLFa33pMjRzxkD7ABDbo8gQZTmJFokwgsQI5b5emTZ0WZIz0z/7dLCOow4eDNekE/D0W1rjl4Hs7Bb94VK0Pxc1DyVYmSUHHVcwM+vJmFV7V+z87Wfp7C/+1XTnkYiQ93kz73FF/mMS9asb5tv6HCPkbajzoCHN5MiZnVMzEJ+eAUkrlGkE6ulaJC9bJQu+UJ/g6N/tR3gDe/0pSVlZnawP7MDeres+0LsJ3w1WlkhWngPvMWf5TEj766BvQF5yC/ukyRnitBovSlbeOtKV5hxW8aFeNkwFx7McjVnimyGERJMOKS3bm5onUsko9PqghjAWEeMUnp3r2LZE/Lo/LKMplyVvZUFBcsSmxh7b6ydj90RI0Ubfe9xph5Y7gSB7xbp8gon1+bHAJJC002JcOZtPHS5QvbJdndRhY5sliwM3R2WodIaFl0+opOV10OB0U+y5tESSfv9p70SFIZMuYjsuCd1l434g4NBNMbCX9MAkgoYIW28Bir
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(86362001)(38350700002)(38100700002)(36756003)(6666004)(6486002)(52116002)(110136005)(921005)(107886003)(1076003)(6506007)(26005)(186003)(6512007)(2616005)(7416002)(5660300002)(316002)(2906002)(66556008)(478600001)(66946007)(8676002)(8936002)(83380400001)(4744005)(4326008)(66476007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5aRKIn0KF7UY5lJ4ugK06Mimt/DR6X1KPgsxcequZt6pyIj+X2iMv1NzSAH2?=
 =?us-ascii?Q?C3OwYn+nqZqVEBuTv35gmUaGVmYJlN9nFtzMaUGQFXr1E9ECA4de2mdSmWfy?=
 =?us-ascii?Q?EpWKGacAZQ72xRkU8pIjmiBGZXi5LA12cKMu7+F8VXZK1FrsPVxjI1Yf82xj?=
 =?us-ascii?Q?TSikEmD2xj8BoZaNIJ0O/wrJeiClQmLLj8+hEmVKUdA7Ec5UIZHQ6io6clk4?=
 =?us-ascii?Q?slatw52nsNvtx9ejiQXRQ8QPi29uju4i6TbYBAnGtq38q8puj6Jvvf0BiLVl?=
 =?us-ascii?Q?X2LuHv9wbllYtKdofC+Ld8x0tXGA7RqIXasGkttUoerASPLyOH5nQ/F0EWZd?=
 =?us-ascii?Q?T2eeR8Yb0OIyFRyhszPn48YFCkDCwedbKt+lhNUDZhSQF2vPeAJ3xk+PFCOn?=
 =?us-ascii?Q?gxXvser8jo4wH9k7lhmyxKoWmsgLUxuVX6CzLciVsilWlO2YYobLIC/KZKoV?=
 =?us-ascii?Q?+BRM7a6eUfc7O7RCEo0i5Re3S3weC8bdms3uHglRnIvHg946tir6UwDxyFnB?=
 =?us-ascii?Q?YCYTWZplc0HcHcB+2a27fP/2Pl3AS6y1Y2IiijnIcbQz2o0zSnX0fMLyjLgN?=
 =?us-ascii?Q?U35d70VOoqDBQS+TOIaGbDX1DuuU2pRVM2yZzjB5uZK8dBvKCmJIIt74lqR7?=
 =?us-ascii?Q?ZxE77O9plYvG7/LGQhpgqdYlVundSAeInZvw8qGwdnENa+bVPnNF0XlGkmJj?=
 =?us-ascii?Q?AKUfC0zpptZ4i+dk5ZH+I68b4uu5UcTa8mKhfpyLMhPPlxQXzrZ1vuVsu8qX?=
 =?us-ascii?Q?MpU+jH9+110PIKzlhH83GnRm4uxzGPlS2HC0Q2nOZOyY2pefH/u/vfvIvVBA?=
 =?us-ascii?Q?xoeKqwLy3Y0BRy8crbtxkFR2I8WwuVWgLTNvHRlUpkNFcnpkkLJANfATubFf?=
 =?us-ascii?Q?w1QnkQ99Fc1pu8sVcFUNelvlxN6yKq9vyrDJ1LHlxDa88AbBwASaqa6WF8aX?=
 =?us-ascii?Q?6vqn6w53x6Xs6gEJlEYOt+ny81rni6+Utx5xYa76N9lHeATAm6UKchmH9eRh?=
 =?us-ascii?Q?q+qenZ4t3ibK+FRvDw522VHwOBaB3luVgRrbqC4i3vY0aYxqa8QeQ+mYoBzz?=
 =?us-ascii?Q?9jxCS9GHcH4Cjk0tZ0ghqWwBWjPdmc1NK/b65qH9BhxKjBHlOUr2QKcNbBaH?=
 =?us-ascii?Q?cWLPYzIfrR07A3VsGz5vWjkThQRdPeRcsZFe291h7Xe2u7s0JsJJ2rshbFmE?=
 =?us-ascii?Q?LtS6I20LhFfAO9fpdZDl57M6PHnXXGGaRUsmUpb4j8LIwro04fCjDOrrsA3l?=
 =?us-ascii?Q?Cb9nIC2dcBZABU/HO9q4mvOVsPandeEyxj8IuRrQmnx7SlclqkQJWVaSz1vd?=
 =?us-ascii?Q?lSYcXqN84zsgvsDOiXqXbW9e5bJLwp8dpqhcaaqSk2nFztTF9m4xmXbG1nXX?=
 =?us-ascii?Q?aGSeBd/uOtdc8FF9Me/QN6AAJAEfxlLqWL1h5Zjx0mVut6AGjTBACgXXyoJ+?=
 =?us-ascii?Q?lzs2dCX2GyneLTFclOrwfRqZxskBN5oyiXa66LF0nUw8d7j0ZkH6snSz/M8U?=
 =?us-ascii?Q?T9SXaXTvKEvS5cWD8IAPvuJLhcqKXZApC2VGiZXv9lhADDXcKA7SxnsIjk/6?=
 =?us-ascii?Q?U5O38bFjvAYBSRUAtg1MoVFTCQY5wzVVjpY2n1d2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba25be94-1963-42e4-8c6b-08db80f46dfa
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 03:19:11.5612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/GgNjrA17pT3X01kf2xcyq42BGIswKyUHnYomYmBBsrCNlroZZoao0QVot2HjUTDkVUPeY88iKPSHhpWShA2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6606
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary of_node_put from the continue path to prevent
child node from being released twice, which could avoid resource
leak or other unexpected issues.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 drivers/net/dsa/ocelot/felix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index dee43caee19e..8da46d284e35 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -1286,7 +1286,6 @@ static int felix_parse_ports_node(struct felix *felix,
 		if (err < 0) {
 			dev_info(dev, "Unsupported PHY mode %s on port %d\n",
 				 phy_modes(phy_mode), port);
-			of_node_put(child);
 
 			/* Leave port_phy_modes[port] = 0, which is also
 			 * PHY_INTERFACE_MODE_NA. This will perform a
-- 
2.39.0

