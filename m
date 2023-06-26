Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C375973DC71
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjFZKss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjFZKsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:48:43 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2093.outbound.protection.outlook.com [40.107.215.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA935E71;
        Mon, 26 Jun 2023 03:48:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdaycFdC/4px/ECIJWX5GYgeskgfripXZjkKT7Q6rhTvbELV5UUcAawQwLg9ylDa6DbvL/c7oLaQ1yolZel0VNhejWtuRUY2Fx0a0tQjUlr/Ymg8I7YvVPlXAAmvk1YFGuHUF4DR34yDDezdbctkvFGibxqqb4w6kWODlT2AaLziL5AluTMxzg1BUeItExGufpALcBvNjal9TtI0dem2juqgbOA/uIfbTDL2mQLyD8EDeso6qW1ye07fF+idCM6z4n4Xaj/K+Xw6oVio7p5EdksTAmS56M9s757cTs3EC3B+xkZcQ/NCdTBljPKEiOs7QuKNZJmCz1sIA0r3lFUP/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSx5Hz5kXmYQDsFKZao0/1OwnhSNkx3D3g3tBFd5Ndk=;
 b=ZjotoY9lKsUYziaIyp7ZzVIpROaVzYrlxrjFTR65PkZeCBQ1qDBoAdapbKcsNCdR/LQTQEUyXNz+yLebDwUbAymlZwAMxtAgCnVEdehKsLR5VhtJzz9SAFMHniW03F2CB6I38mx5jYnsFdu1k92jrX0G0NlBrHvHjjDob0++/98HCiZ3FcyGqUfTpoU8VQX5gu3ILnDpBqbmI/cumfTcMSFk3c4hwhykG3GIsYGH22TQNjZVB8FLWTowWumbMoQx3EpmDcs3iW1PXQuVW5N+ExbdXPEtcvSL7Lqhk5gzGS0FmkS8i6agj+wTG2zcojr/dyKmOxQ/YixsoebmWzNRgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSx5Hz5kXmYQDsFKZao0/1OwnhSNkx3D3g3tBFd5Ndk=;
 b=DadNSKQ99goBWbccwuZXGE2Bv0JzodRMdD6ikQ3AZ2gKj8Ihq0LX9h29zJKpDLK6Yj/LIN2sMvvyr+Bff08O0+rl9CKtmPU1SJsSONg8mgVkwyK7Y65SODEIgTM2h+kzKuww/QNWpGbsDbgUV34A+b55AfsQsSBdLXjfz2zo5WrP4uvba8U/Tjhl24SEMrd8O7jU7yJu0KFiuigicuZU57uFJcQ69XwIIA+qUK9T0w15y+VwUQ6psYgA5qtS56oSzjAVJHVxw5rtUYRvS5YEN9gyjeH4V92Vo2yeNVb3lo6yvA/8+oDS/r7bzRSU48/UXFuwPvI3mZkgEAUeTmPB4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com (2603:1096:301:11d::13)
 by SI2PR06MB4233.apcprd06.prod.outlook.com (2603:1096:4:156::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 10:48:38 +0000
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::adc0:c22:ffae:227b]) by PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::adc0:c22:ffae:227b%6]) with mapi id 15.20.6500.045; Mon, 26 Jun 2023
 10:48:37 +0000
From:   You Kangren <youkangren@vivo.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org (open list:MAC80211),
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, youkangren@vivo.com
Subject: [PATCH] =?UTF-8?q?wifi=EF=BC=9Amac80211:=20Replace=20the=20ternar?= =?UTF-8?q?y=20conditional=20operator=20with=20max()?=
Date:   Mon, 26 Jun 2023 18:48:29 +0800
Message-Id: <20230626104829.1896-1-youkangren@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To PUZPR06MB5936.apcprd06.prod.outlook.com
 (2603:1096:301:11d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5936:EE_|SI2PR06MB4233:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ddd5bad-0cae-4757-5f8f-08db7632e583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ygIEYPYrZGRAfT4zRkgdoqcf1dY37o/MSehLpLWMtRv9+e5uEQH2cBPN541E29uLAmalNkxmAeecBadToTq4P/a9TsFffBkSzWIkzlM1bIhRPDmaf5J+NtCx7LKULBIp7zGaGtFux870wPUxUA8F7ajaQu7rOEY/v+vdRWKRQxT6vRsc8rIQNhh0SoLSs99vOn5tDd98+skjxj1+/uXqV+ip01gIqYLjiMYrfr9SLn4cmi26ehrM2foO6ipI4mFEWO7Q2Jt3zJbiKIGpkbDWcQQkNDSnR0RtUwkmSp86eru76wpWEkFkhy5XMge70EqFxV8oDzfEe7/K78IT+80S1XdFq8KF8EjFlY9FjyAkRv3rPjTSzMD6t3KD4vTFfwb0QmcwO8Sb8Kbm2wbZuHsmlpSBY3sje49SCfiKxQ/wpl8NVcO9ehHdm+gWaFHC/iAZ6h8GvJhy4jie4GHZrylF7N3RdPs2LChl16oaX7EU7naPi2jnodH6yauw3me/PXcqt4h/X2ONueCRg/KUjOJTrFCaCXomxX7xDRugo3E4graXwjtWLit++PYK3Mpr9kyzL9KZfp5kSJGqm2G8RNrAwn+k32bOH8PDGMuPqIIQ32weYbYDahuyz9QbN1yhJAP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5936.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199021)(107886003)(6666004)(2616005)(52116002)(6486002)(83380400001)(110136005)(26005)(6512007)(1076003)(6506007)(186003)(2906002)(4744005)(478600001)(5660300002)(36756003)(38350700002)(38100700002)(66946007)(4326008)(316002)(8936002)(41300700001)(86362001)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3ROam5Pem5NQURmNnIrYnNjMkpweXg2MGZzMENYdU1wK1ZKRDdHdkZYZ2hs?=
 =?utf-8?B?aTYzLzQ4K3RPR2IrTnhiaXJNOXJTNnQvVC9RWm8xK2xNQzZQUGZNV1RLLzBW?=
 =?utf-8?B?dFhXVGVkNE9QWWNwRk1SWEF6K3JSajg3RUFKQkNjdGVsMFlUajNERm1lMGxQ?=
 =?utf-8?B?UWlCOTQ5eVpabkE3MXNoamhuM3BibHJKM2xLbGtPYmR1Nktyb2lnRU85MkFs?=
 =?utf-8?B?MnRtdWgwSjVyZzNneENCYXppMDViMHhJb25qTVFqWmpqNUdsUUlwNXhMOGZJ?=
 =?utf-8?B?WElFbysxdFZkSXJjL2ZDTHU1SkZadG1mTTE2NGs0dWJvN2xXcno5UERqNGo3?=
 =?utf-8?B?YnI2VDJwR211R0VnelgrZ1NsZi9xWTBUMXFMRXY1V2FDOTZmU3M5NEhYM2ZX?=
 =?utf-8?B?Y1B0ZW84R3VNZThlRUNhUzFDRlkrYTUyR3lZMjFVbllHT3pFckNJb0hSY09r?=
 =?utf-8?B?ZkR5c21CNHl2T3Uxbm1RclQ2a1BZYUlSKzFQOVZ3b0U5UG9Oby9XemlNbGZN?=
 =?utf-8?B?RGRNOHN4ejJSeHVvSUJmYjRMMlZqM3NLQjluZnVmRFh3WWx0eDQ5L293a1d3?=
 =?utf-8?B?YlJGVkNtRlZtZWRrSHNuNEQ2S1ZDRzVRQyt2RFVOTlU4dmx5ZmlvbTRWZnp0?=
 =?utf-8?B?bVVMckVqQk4xTVd0bzFQajhXUnhFWnJqRDN5UTZzY0NGdEwySittMXM1T0Jo?=
 =?utf-8?B?THFWTmNCckJDV05oeDdOVkdXZ2dFeXJpR09qblFzeVpxQVBIMHpOOXdHK2VI?=
 =?utf-8?B?ak9IWGlnR0hLRHptVElIS21ubDlJcXhrSWFwTVRIRUFvRWttRCsyOERQVmhk?=
 =?utf-8?B?Z2x2Mkk0MlJLUjdGZzA2a2theStRcGxpcUozbXZxeHNnN3BOUWFyZGlzQ05L?=
 =?utf-8?B?KzFVYWxuM0NvZ0RiN3FlL2oyUjBuNy9hRko0N0tkelhEc3lQaGwvTHZsWVhr?=
 =?utf-8?B?ejhrR1RLcGtqWTRnSk5JamFGUFZhUUh2SzRSRG5nK3BzQ0VWWVB5THVYeTRE?=
 =?utf-8?B?M0hMS3JuOHV1cTRubGJMZnZxcmZveGhPek95S20xMlovdjc2N2Rwa1dTamdh?=
 =?utf-8?B?ZWpBU0FHTDd5VnZBd2hLVzJiTitkaUF3Wkp3Q3lTL1Q2SExKQ2xXV0VpQ0VY?=
 =?utf-8?B?TUg4N0xXVTJXbmdXSGU2MElONHVISXpBZFJ6eHN0Y3VvS3RvckdUSGJZZGRF?=
 =?utf-8?B?dnJCd1YrNVR2ZENzejVGR0NCYXUxYXpXRDVPM1NxUkVtclFxT25RVVVWTnln?=
 =?utf-8?B?bEQxMDIzVThWZGg3ZDZHcGtGcVpvdWxudnZnMUNJOSswd2IreTArOHZYR2FC?=
 =?utf-8?B?REFZdnJkYnhPcExBMEFsWTdlMStJRklZUit0dGpmdjlkY2wxcXIzMFF1TzVP?=
 =?utf-8?B?enFjL2ZwNFZoSzZpZzdkYUlEWURlS3ZERWl4MHYycnVaVkdncG5ldGxaL1Vu?=
 =?utf-8?B?SWFSQmppWlFwUnNMZ0tBQVNwZVUxWXFwdlUyVGtzNFBvUlFsdDVNc2J5YVJI?=
 =?utf-8?B?d2djWHJ5TWM5dmRHUC9RbkQ5djNPa2ZmNTVGL2ZWelVtMTkyQkFTMjNQNVpy?=
 =?utf-8?B?OGRnZmpJSUVRMnUrVm1vU3NhcTV5bE42bjVIekNyZ254VWhSQUk0Q2lCN0p6?=
 =?utf-8?B?VjE5Vi9qUmhKamhZK05iK1VMcWc4aTFoMjROckE3Q0l1Wm82TERLVnJ4eGhN?=
 =?utf-8?B?aWZVVEJXczh3Z2FsN3lrS3pvK1B0ZDJxMVV0RHNaL1RadWh6aGFOM3VLcnBm?=
 =?utf-8?B?L3FnMnhqR3p4a3o3d2loY2RsWjJ5aFBQaENpODFFT25pbEQzd0k5cm0yOHdr?=
 =?utf-8?B?eEQxQjRKOGNjQ3FQaXRmaWtGalJ4VklMWWRVK2c2YmVDdEdocmR3YVgrWjQv?=
 =?utf-8?B?cmJxMmZ1dHlXVkswV0dubURBampzcW9KQlcwM0tyWTM2YlV5MXY3YmJVMHhR?=
 =?utf-8?B?UzQranMzOVlQdXZvTTRjYTVpTGFQa2lUVnNKREhVR0g2ZTFJNFYzRE02Tkxz?=
 =?utf-8?B?ZVZTa3J6RHljOWluQkFSR0daS2ZTbWF1WHNQS21xRys5blNpK3orcWx3S3ls?=
 =?utf-8?B?bGZZaWQ3bTRjZFFvb3dKeHdjdVRjT3JKNXVwWlJXa1ZhUVdLZzlaaXI2T093?=
 =?utf-8?Q?1po5v2hB9ZLAqVcynVnCQYqoP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddd5bad-0cae-4757-5f8f-08db7632e583
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5936.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 10:48:37.7157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGQvE8JIML2hz1cewQUOexC2ptuQTVX0dMYiXNa+kXTE9IomO89nK4VvGD0nN22Cm5CqKo4M5zxk8uIrMxM/Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4233
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the ternary conditional operator with max() to make the code clean

Signed-off-by: You Kangren <youkangren@vivo.com>
---
 net/mac80211/tdls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index a4af3b7675ef..9f8b0842a616 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -946,7 +946,7 @@ ieee80211_tdls_build_mgmt_packet_data(struct ieee80211_sub_if_data *sdata,
 	int ret;
 	struct ieee80211_link_data *link;
 
-	link_id = link_id >= 0 ? link_id : 0;
+	link_id = max(link_id, 0);
 	rcu_read_lock();
 	link = rcu_dereference(sdata->link[link_id]);
 	if (WARN_ON(!link))
-- 
2.39.0

