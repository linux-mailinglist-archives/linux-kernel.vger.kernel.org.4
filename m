Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA2473FF51
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjF0PLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjF0PL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:11:28 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444DA1FC3;
        Tue, 27 Jun 2023 08:11:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9fuyuQAgY3nYTHc1mvtpEYIvQ8t0mEIU8VITo4I082RVjO7xiPRaeoIdVMgOQlUN0Q6LPqfYvkxk7iBUWy0dZ/MguASjBB6BQTHxC5/bNpMvOPqMYJpYnBUBBFP/mK33sa+ZpnjDsn0cXSRRkVGnBbrQBa3w9GPoxvG9f9iuyzwIh5IgW4GBEw16ZMEyr1fVWujFo3KKHVVy3c8JcKbe3ywdeoxbijeX0xAxXAp3d5pV0SUE2+UVmyTDLzJV/JQlrgJxXpVNOMetNEJTZZNiCD59gaU0x+OAtPBC9dFPCHWMdNvCiMM7ALfxnU3wxsDJezQfoRhKhvs8mMT5/XpWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnXnrUIeLH0HpRNWyaEQr5DD63JOZAUapMSr6Gxt1Ag=;
 b=Nfven1A5MEsAD170wUkEMZ4K8eAjh0gt3sC3/H3g5/BW36hb+Ho+V10r6XrbIbzfzsvnrQfpavSN6oUjGeSjA46RCEhEXPbHohv8NtutgS8R4A1T2B0TJq9EY8CuO+RfEsZAgSg9Wf41ksFvp5lagZvJw7TaX6bNXiGhcEftNRy3sEF/BKfhc/YZhr6Mlt2CpA8zDYoSu/B0+CPEqeoS2lGKyVuvHFumiAiL8DKj4v0o0W1LeSXFB5vaw1VY5x97ALW1sH3Kkud6Y0ujlnlLpOc9bHutENWFmrPFpidC5gTVbCUGW2rgOaQ9uE/DCPf4qz6h01LQYp4nJwMWG5KECg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnXnrUIeLH0HpRNWyaEQr5DD63JOZAUapMSr6Gxt1Ag=;
 b=m6Y6+xOg8WlcWxZ1pOmBfkwscdGHQ+pMgNUGvkplx4xq/JeNKCtjlkYi3+k2NMW/LrGxI5sM3uUJr+2sACvSbaWZmbBiUjFWZhw/jj47iEo+dYLiw7GVJvdjb762yHgwLIolxfxIGIbD8maruXScqekyLU+06IhBBAriEgoukd0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY5PR13MB3795.namprd13.prod.outlook.com (2603:10b6:a03:21a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 15:11:23 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 15:11:23 +0000
Date:   Tue, 27 Jun 2023 17:11:15 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Harini Katakam <harini.katakam@amd.com>
Subject: Re: [PATCH v2 net-next] net: phy: mscc: fix packet loss due to RGMII
 delays
Message-ID: <ZJr8E7iyKnOxlPgG@corigine.com>
References: <20230627134235.3453358-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627134235.3453358-1-vladimir.oltean@nxp.com>
X-ClientProxiedBy: AM0PR01CA0122.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::27) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY5PR13MB3795:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a2b2a7-4a65-41ce-6020-08db7720c501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SRhJPsHE6rdkBcXfpuk+c5s72+oPT+L3oKFDkc0010RmyxYkKSQiPfB5gu1Aurd6yQ2lgOMdLsF4zh/y/El6ZeNgecVBG8NsbAIGP+sAcvzhWLy4A9ws6AD1/VVTwPhqXYp/P/NLhVvlL/tn1GgyOQOyK1dr24ncyXlaMDxzPrF4GdNGT+omOeWPhE0qGzmSsDoWuLDQaHtaL3xmJoWJ5t14tT9qJmIbufQMGZ13lKjy4/W5+xKS2YLUh6gYDHJoLCm+8+ni13dR1LOHy4p7iBF3ysqAG3ZEnApQEDhHy3589UqUkTKANKeSRndiwyZAF51W6NqgTK0At/GThl2ebU0HpQo77I1yXCdolGUqBiqS6JaC7TGRL86V/R5kTIYP4GnbeAJ0mMnQHYM0D/Uou8/sDYbaYBqQ7ro7knbhkt+K+hfn+heNrC+T/7GHKsX1Yt58dAbvvC2FtJbYWLb+WXszZ4SU5DFHjUbGtcuKUYCiFD93WVFdchLDJFhf+J5oOA8G+tiF89DDqerILLKOR/oAAGsuc0mQkDt+3oP3X5n618nHSte4nx+H6ZYTtQVk1x4V4ICwbhqXVVEm0Nzj1YU8AOBGKYVJz87Bdu+UCCk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39830400003)(346002)(376002)(396003)(366004)(451199021)(6506007)(36756003)(6486002)(478600001)(2616005)(6666004)(54906003)(2906002)(6512007)(186003)(4744005)(5660300002)(44832011)(86362001)(7416002)(316002)(66476007)(66946007)(41300700001)(8936002)(4326008)(6916009)(66556008)(38100700002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RJ8EL4/sPYsZHZwzS5PisdUrydDP5xFJEcrECl71ulLq+HYMkVP7EWoS5W4U?=
 =?us-ascii?Q?sgWxg7C7NzT3wKYM8iJ+VECzi6ONpDqNyJmhg2882OfL1MjZoLS64yCbYI4F?=
 =?us-ascii?Q?zpuYAYdjtefK/u2FZTbHlC+n250dCPdDtKytBjlsA0VZpbgDarj/JcAc5F3F?=
 =?us-ascii?Q?os08n0Kx6YYN8dWfHLTGu1jpohwyY4dfTp5KEf++V4dpiIPtIE6r3kh0z4V1?=
 =?us-ascii?Q?HXCq0J5gsoRz4QxDD3NzkBw01baiQlhXX/EU0nZqJ2HTGFIEQ9rUUcqXG8AJ?=
 =?us-ascii?Q?D0irPSHWWVVSsgp7h/5RnjOt4kPjM5T5IfqTJ/bAnqy/U0FIUQa5cJXjhGRT?=
 =?us-ascii?Q?VqaDwmDvMMQpOAsB3PzGJp4FtxdSZT5pLyOPHH7BjfuoG46ZMJcEcxXQlfCD?=
 =?us-ascii?Q?uW4G3s031l6aaFZmWf8C4BfyALaWGOgahspcXAlfLSLJII0eQNBqVWG1anyw?=
 =?us-ascii?Q?ZBfcjgDnX4sqBoGkt2TpwlO+kKT5Hdys4xcWzxa92uENoQKeyfgFTSb6m1IZ?=
 =?us-ascii?Q?KDB8VNT7qFqug2p6D6dFSxuKbCy9MbGiIoMonjAVZzrCpJq3XDcAsGaLlHa+?=
 =?us-ascii?Q?n40YVyFNDeMrzG4+hhUAsxaWzXzgZiovt62JGDHjy4bQjKXTqAEEuqwPgxaM?=
 =?us-ascii?Q?MvX9lJTnwoDy9SezH89DZxNYPUoWnwhnye+cD75RUb4GCaNX7kMbnuJSuNQo?=
 =?us-ascii?Q?MLmZk4m9JD2XznBurxwGvspibLbAnZXgxH/9MLDK7QBpaQWE2dSPSQP0QN6c?=
 =?us-ascii?Q?VZJ8ndn4pHiGlaiFgPrIokz/srgR+aiR/YHCxt8nCKBa783rEG7Qt3ds9Omq?=
 =?us-ascii?Q?j3e7+DsnVof92Xn2jpRZ2wTWWFkiD4IPUpw44QzSPyz8CbzBytaKCxiOhbyh?=
 =?us-ascii?Q?xtJqGDwifNWKVUdEaVPEMD/jcNEnP2owDmvFRK7h2nSFuWyEoUk6rqeRFKaK?=
 =?us-ascii?Q?E16tXWmMC4PbfNq7fKsjS5+rfHaCTiM4t4/ORJCIGKD9WDvR9irHSa4J1xQz?=
 =?us-ascii?Q?Z3y4Qh4OxWkjtszvMQfigs4QcEVz2bxNqMVbLS5kjYSFn1vwJ22KGh6keGtD?=
 =?us-ascii?Q?pK3jLsKaKznV41bBUEP/IHfxlwyzdK3B65xlCtwBsMdGm9xnRZaDLGqlqFBg?=
 =?us-ascii?Q?BDXKdx5CEkyfiH2r9mBYaqSYC/qUOMQQJw2jNTR9S57I+dz+U5QJ14VTe6f9?=
 =?us-ascii?Q?iI3KnoJn3BGu1D9aejpDjq9otDapO/Fg9sVrJhV4WeB/Tn/rim39b/Uq+2rp?=
 =?us-ascii?Q?snJXGav/Fg+1ugPLCWCD9sMCo5ToR9tlO3voPmE7kC5reqAwxNqhX1FYu8W0?=
 =?us-ascii?Q?i+gQLpZi2SHGAPiECcoClxyhEBH/qTg+s4J1x/msASXo+wHjWMFFIJ2iA1cF?=
 =?us-ascii?Q?Ur41PbhuTaetUhLv8fm0AFiygJw+fHLpHKgia2we9POIU+5c1pMex81sPDPW?=
 =?us-ascii?Q?uYqNUvDBLTj+QrWSSgyiZGRMUA9dl0xm5eQ5Df2ZvjKd5t1lCUk8Ocl+Jckn?=
 =?us-ascii?Q?NZeU9/h4RQ6BQsqFor7DWCGTYkIX0DqNx6HdgECb81EJZ27ft4Y/6fq0PnDs?=
 =?us-ascii?Q?p6j7jVmw4rz9xLOqY48LPE3w7LObQ2jCMkuiB8QzlJcgKG+2Ydn2zet60VTv?=
 =?us-ascii?Q?VyaQiYtGEKP/t/KZvAqyd4074T7WP3As4I+0FfcQgzyEbinYG+4wWiLWbe05?=
 =?us-ascii?Q?GnmdVA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a2b2a7-4a65-41ce-6020-08db7720c501
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 15:11:23.2526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1dEtXEC97a2D/wKsIZa+jES3UU2nJSnA2Yf2YawVBT4/O86h8x78+/JDsY12lnHj+OkCn/0DPBw15YhT3R4nrkV1JJPiC3vTxa5LKHMv8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3795
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 04:42:35PM +0300, Vladimir Oltean wrote:
> Two deadly typos break RX and TX traffic on the VSC8502 PHY using RGMII
> if phy-mode = "rgmii-id" or "rgmii-txid", and no "tx-internal-delay-ps"
> override exists. The negative error code from phy_get_internal_delay()
> does not get overridden with the delay deduced from the phy-mode, and
> later gets committed to hardware. Also, the rx_delay gets overridden by
> what should have been the tx_delay.
> 
> Fixes: dbb050d2bfc8 ("phy: mscc: Add support for RGMII delay configuration")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Harini Katakam <harini.katakam@amd.com>
> ---
> v1->v2: resend to net-next

Patch looks good.

Reviewed-by: Simon Horman <simon.horman@corigine.com>

Though, TBH, I'm unsure what the correct tree is at this point.
