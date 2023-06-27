Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F4973FF43
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjF0PGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjF0PGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:06:37 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2102.outbound.protection.outlook.com [40.107.100.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D8F12C;
        Tue, 27 Jun 2023 08:06:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkW/yhAjsGwWGGJYQrxXpE7IaK++ByLbO5y7cJ/jmtMsnEcTYBb6jNPz7pYidTJccuvtIAzZBr4uomD6qaM57CL1Vp74hlYA2/qgvB6M0uDDwXLp7OLvPt9DZUI7dooIXqGcq6CloCF7EMxs26hozHO4NIG/pDHhQ+g5SSGFKtF+nspfKXimhnQZjvmvCEzSFy+UFYVslrDjpN+1xzAhpfMwRvO7UpLiByRBmKhOKafLpX88SEAfZalyX4BK0AdO1NuK4S92Y82535I8hCtnwakINDuJxAv5VN3ndrGOGuSg5VNRwkIoCeML2jSIVpRRJxkQWXC0LeMvzKSWukCKJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hvnWKFaV4WXsDizwxK067McVvJGp6/oX8XgKSlsVhQ=;
 b=jwB81YfvxTv674xdcjHJvhjSoNvMSHZ9FpPl13iQlvuEj8oKMamnQVfQSqsJgJRsbHdfmAW+eVB0D+RBcSeioqnWjZYeOduniOX6fgWIbuyIkZbwNepFM7BTurLXX1uM7/akLceF6VvcGQevoYlpVGanUiJoVNNyt00OtfbbaokwgM2UdaJWNQaDoyp3ZLiLez6SzZ4s9/WCD1BfDFEsObsFsMi+7Ef0U83pY+8KsNXd9jbnQ2cjIrSbjU4KFe79ibXhMVooCiWk+VWOkCL3AMeIzCieq7pIB4XNCdoaF3A9e6+pPpJVGmHINH93cnhOxgnzNlZri1UtTDiQvBDRxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hvnWKFaV4WXsDizwxK067McVvJGp6/oX8XgKSlsVhQ=;
 b=Pr7yRGs5MkqtsoB6yY8uk/2I2i6nF7MVYYTQiiBwDwdydaXbs/w8fmgn6+SLZjS7xLr+adtSpLENVfTpRUaiT4f72V8uGjtgXaDVBO5Fg1YYQ9Fb98kc7uhBZuvvPJmops9Ltui1W9ehItNWH8SC1gkirSWTFJLmMi9ZX+QjLwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by LV3PR13MB6500.namprd13.prod.outlook.com (2603:10b6:408:19a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 27 Jun
 2023 15:06:31 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 15:06:31 +0000
Date:   Tue, 27 Jun 2023 17:06:24 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 1/2] net: dsa: sja1105: always enable the
 INCL_SRCPT option
Message-ID: <ZJr68GHgNhlzbObk@corigine.com>
References: <20230627094207.3385231-1-vladimir.oltean@nxp.com>
 <20230627094207.3385231-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627094207.3385231-2-vladimir.oltean@nxp.com>
X-ClientProxiedBy: AM0PR01CA0090.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::31) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|LV3PR13MB6500:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c82b374-8392-4262-3910-08db77201713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1q/lcXklaegGCI8bP0pH5GA/KM8cJY/OxLijXWcJE9FYsZ6yVbkw+iWeNmGK98Vj8EyDBYo8zgdclIzk8g1vfhdTPCCMwq5HpZ69TnGAhAX9tPC2SJBiQ2mDZS7lG7Ii+yGQqgiJ1uadT3CI02sOLnH0zQ9aRkXTYIHZUIZiCFZq/G3+z7fHDCEkxWjE9uP1iAz3d9HWkOBju1XB3fdQYo/vpUEyge0UsnBz0y+h2O2uopxxm8jOMcGUSu5o5iUC1A2tkMi08+f15TRaHoNWbvELJcheaBhMsSQ/FoSu7juBdLJpQgoFSv827Ge8nGZjkmZlrecPba+uS9Al56QuUsphX0xenUDQ5yoiH8p6GG260k8OHKG7+YDkhKw0SvPBOfaNWrfgVFnKVXGTNXlUiTkk5eBrLhnzp9SXLuB0qovXQeWpygEFSIXcfvqS8/8xbdTxFbhCRgISalPTZoadpygX8Z0/HPh6q4WsFGUX32DCjWQAgioZ87PH6KMNrQCYz8TEgJIN9OLk7ZMEZNR1IXL4Cu9VQbWb+T34nt7a8lM0MV54e0BfhF2PbSs07kPBI+Hi5JhAa5G1PmKgifW0d1a8wlNN+AKDQZe+pV8642A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(346002)(366004)(136003)(376002)(396003)(451199021)(38100700002)(86362001)(6506007)(5660300002)(6512007)(66476007)(66556008)(66946007)(44832011)(2616005)(186003)(6916009)(478600001)(2906002)(8676002)(54906003)(4326008)(316002)(6666004)(8936002)(6486002)(41300700001)(83380400001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wa9Gz5VpJ8oDc4fk5nWNBiVPNwXCuzB6M6EOCKiP8RcSKVGXJ9UtEg34NUrG?=
 =?us-ascii?Q?DHob3x1q7qYgs5MfxDZ+TX7dyKvknupfGVBbZshKKRjNpLHInEeEGOwYg1ug?=
 =?us-ascii?Q?ew9/Zcnt4SXKxD/QQ/lQ+rUNzndLNrRZCJeo1AVJDN5NgU2NRTvDcNW05dcQ?=
 =?us-ascii?Q?GuJrA6aMWjJNOekUCi8oOkVti/WcftEOTd3PMAjQOGBxAKvVEuCiCt8499lL?=
 =?us-ascii?Q?cfX1WwQQ6TfpgFUj8gs/zg0Y4iIMQXtkcV8og+S0me49+vza1J+RIXdQha+r?=
 =?us-ascii?Q?t07ipEyHM8AOIgrfhezamSiDVaBNPI4JZynQCZDFdakDLdR+/TdBBrmxh2Ny?=
 =?us-ascii?Q?SLZe9c2yuZw5lB/TiHKFqTJQdmcQ+Aom+cLLYpU6VvJSbp6ft+ZkZ1Q1tMSN?=
 =?us-ascii?Q?eUPARkUaFpKA4AsdJev1b6+Epj7/WfgOsz+QHctim3Ntv4ddkTcUokpKPRa2?=
 =?us-ascii?Q?9OXYPiuUf84E6AZm59vhr6vznAwRpWaZu3OSdwLAOctS92/OcBc71t7qooRt?=
 =?us-ascii?Q?LGHa5VVuA+53DybgpVlsia4/h6FfoJDdxYhqSQSsktCWWIR0misf9aYhwkpo?=
 =?us-ascii?Q?9aj4byBuS0vPPHXMn70mD1jwrV/OI2Tvk8E1uCzzHgzoET6neRmha/2PkN3I?=
 =?us-ascii?Q?vZUpoIkhO2XClGD6pxKHvatJ5Jn96Tah3n5vytqpngOlNYMHApger+I4oAiQ?=
 =?us-ascii?Q?eOkyqAJ6KPArFzhvTF9jGWyJnGVu+FX8KHErt4dz61bWoh1ndvtcrGyOcYV5?=
 =?us-ascii?Q?fp6LMHt0Epjh1igpxO/dl2o5zBI1FnXPEgUvUGZwzmLu0ZErnH78RuvyM9JY?=
 =?us-ascii?Q?dIwPQMhuf6lo0UBCwpYrYREeQVKoL8Viyi17GNaovWJFamrgXmzVE0D8R/hP?=
 =?us-ascii?Q?yE0rLRvczZjKFHF/CB6dEFfA7rJtXL4dKbRGC9vKGuN/6ZIwtryTA9CN7Jbv?=
 =?us-ascii?Q?DBj6pAZd8Un81xfCQ9lGqKxHCc5z/TWSn1TPG8lCBzMZP840YdUb18NEHfD+?=
 =?us-ascii?Q?iwIZUgEHXFXjg1y1nC2hI6sF7j4ex3o3OybREHhgNw3xQj24fXbZt4xZjqhI?=
 =?us-ascii?Q?c4hKNA0WaUIe6MjOo27/43XI8BchvY7FNYfykHN7l0p1WGI28UkkyxcoHWYR?=
 =?us-ascii?Q?63bWJ1TrBRtRx7OkNc1GMvXX9PwF/KQ9a/z2/XxoLpdHXGUgIrXbIJjWoEnS?=
 =?us-ascii?Q?6u9ctTYCSLbD8rP3Io//x3Etz0O/9vENhZHgTsP86nG+n0wJxJvH0dV9Gz6i?=
 =?us-ascii?Q?fdZUvxOHO8rBVrK7cKx+U0TtrPBmowTgIZb1HerfWiTROSaiwMypE0yDT7cn?=
 =?us-ascii?Q?9aDF1S9ucpkh4ZFGNO/RP5RAQI9Fd87bpXmIIJ+TD06rMeKSIpvaNAhdci+h?=
 =?us-ascii?Q?jprSamad8lbD/zu+fEEdIRSM8qiQcnJo4B9r6e4cATimFOrxhXJs2XwN6IkZ?=
 =?us-ascii?Q?OpjwR3sVIsTP54ZQD1klnDkJVPq1Lx66pveoVqNoC0a90VkRg6JPN9FKSuKf?=
 =?us-ascii?Q?0yIgbYvNROEZNnsz8Qd3gz3xdYfMYCVou9bfCYsCse+mQ4DQn3L2L6bJ5DHN?=
 =?us-ascii?Q?LP0778RRbPeM5apH24REy9znla9R5NzJi9ERqfpE4mIh4l/INFLE3NsZBtpV?=
 =?us-ascii?Q?q2kncSLsuHtL9Z3gClwoBGmXWzL5TCZAx8QSnMQxR6+6mKwPgTi0kgre2oMP?=
 =?us-ascii?Q?+uwUYw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c82b374-8392-4262-3910-08db77201713
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 15:06:31.5024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C05Q3JXOj9QqRB6YEy0/EuJMlW3uAHN2bBstq2n+gn7xizPy9hqwDlxKga/WlFsiiqH0KmGM58X3KuRZ4N6XXUSk9Yww1IzjJWsz4wI1Ncw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR13MB6500
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 12:42:06PM +0300, Vladimir Oltean wrote:
> Link-local traffic on bridged SJA1105 ports is sometimes tagged by the
> hardware with source port information (when the port is under a VLAN
> aware bridge).
> 
> The tag_8021q source port identification has become more loose
> ("imprecise") and will report a plausible rather than exact bridge port,
> when under a bridge (be it VLAN-aware or VLAN-unaware). But link-local
> traffic always needs to know the precise source port.
> 
> Modify the driver logic (and therefore: the tagging protocol itself) to
> always include the source port information with link-local packets,
> regardless of whether the port is standalone, under a VLAN-aware or
> VLAN-unaware bridge. This makes it possible for the tagging driver to
> give priority to that information over the tag_8021q VLAN header.
> 
> The big drawback with INCL_SRCPT is that it makes it impossible to
> distinguish between an original MAC DA of 01:80:C2:XX:YY:ZZ and
> 01:80:C2:AA:BB:ZZ, because the tagger just patches MAC DA bytes 3 and 4
> with zeroes. Only if PTP RX timestamping is enabled, the switch will
> generate a META follow-up frame containing the RX timestamp and the
> original bytes 3 and 4 of the MAC DA. Those will be used to patch up the
> original packet. Nonetheless, in the absence of PTP RX timestamping, we
> have to live with this limitation, since it is more important to have
> the more precise source port information for link-local traffic.
> 
> Fixes: d7f9787a763f ("net: dsa: tag_8021q: add support for imprecise RX based on the VBID")
> Fixes: 91495f21fcec ("net: dsa: tag_8021q: replace the SVL bridging with VLAN-unaware IVL bridging")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

