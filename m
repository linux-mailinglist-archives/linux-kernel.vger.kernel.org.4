Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA98E745408
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 05:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjGCDCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 23:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjGCDCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 23:02:19 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2133.outbound.protection.outlook.com [40.107.117.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390CD1BC;
        Sun,  2 Jul 2023 20:02:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnqlgRReScspWyaEa+vvDEOI1EA6qZL93TFTRvjMwKGovJIFF4FOfNjEYr7maSyN8qGyTj94PmLDTOHr7DIch3ff2LMnGH+bMBkX83jbTV00sxT3ALb+6cEaGmdF3AMSJQMn7rL9n/50qsWwmpR/0RuA3bcHnoutGhWDXkG7mgF+mnpcvOhDXCVdNDbL5pjYZpPWHUiBcn2JTV+9fpDoaQNipiOXS3NMZzFLVt3V7v9feSpumaZk5IhrljBZnAp/egjwFN9BmUXG0V/42YTcdPpYu8Ak84s8L84q+ct4Bjk7FMOndC8rDtwj1jKFClEQaXJuS5JlC+4RhvTaNdmO/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ipvBLMpljeI/qzEjr8Rux6XTwBTbVBaTQ7ECyObwcA=;
 b=QF88X/nyhNo+M0GB5hkw8fPy3p/lQbSf68QdsZB1xMa/7mxCEV8Q9wHmCkuv+RxrEHKgx83565kudVXaLA137Ev6TV2Dk/41V3uGtFOvv6IbXuzsdEyXW6ECxrgCPHwR6+MiEX9NRbfpoMtXbaRsZcWY7dhx4fNnEG9FtB2B+aXzMiojWt8i3O6b3gXJ7EC7kfAy5Eq2IbeZXXoslgWl10C3Xu7Dsd8mOFhg9G5pExmPghA7ge8beHbe3aP9013clqfsA5w6VJgcVUpiJQ4fy5p1o9Z+8fUAJiBUUvl4ivBVtFMNTElmPKUuCwfxXtdlaeT7keZY40v2S2F/pLC9/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ipvBLMpljeI/qzEjr8Rux6XTwBTbVBaTQ7ECyObwcA=;
 b=cHmXmAWcNl087GlezizE/BtoMJS1bwBQbOKbK34rcei6i/dt+8twRaQf9v4x4nby/x5Nj9DRV2OZkU4iZQewcFs+bp14q/r9ttkxdL7wpCPwIM9fkK/aGt+OaW6iNjonGskCL6Plf7vIFl4nqPf7eSPOk8QOVhS7uDvE27V7154OWDCp0jA0GV/IkN2xITYoK3xuj21i1L8YTzQXAcEMhzsc0bdQ4FxHWBSS5BwRXgzL3MD37NR7KbK9iyMUZfhZLWDpelH0kiF75dIDhorn+bzkJClsUMHHiv7IQko9suM3HPxINvWBd5taFHC5pb64FQrgWkzIT9WQn2BoQv5mag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com (2603:1096:301:11d::13)
 by SEZPR06MB6231.apcprd06.prod.outlook.com (2603:1096:101:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 03:02:07 +0000
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::5c03:58ad:fb2b:49d9]) by PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::5c03:58ad:fb2b:49d9%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 03:02:07 +0000
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
Subject: [PATCH v4] =?UTF-8?q?wifi=EF=BC=9Amac80211:=20Replace=20the=20ter?= =?UTF-8?q?nary=20conditional=20operator=20with=20conditional-statements?=
Date:   Mon,  3 Jul 2023 11:02:00 +0800
Message-Id: <20230703030200.1067-1-youkangren@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0085.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::8) To PUZPR06MB5936.apcprd06.prod.outlook.com
 (2603:1096:301:11d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5936:EE_|SEZPR06MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 1edd1555-5aec-4d7c-2b7b-08db7b71e2bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7UhfWGuqTN32YkPUTb1gFlxTmKtDdnXuXs1DAg8+BjdtDbYdxL2rR1/sPuQL8RCFBv9rSkGnI7ZW9gdY4GHwaQk4huiPzm/uTysx0QDjeQbwJU507TGADlXVJHs+mVh57zRgKwfnBGtF/h1AAlnBfgy7fWbuuKjpbMNThLBRIdkSh8NDC5MaH84xkqlZ029yrrqLuYcLdA2a2uONQfqPKpB/9bYtBRllML7bv0wVWyXRlMQlqjnR3ikVmdW1q8N7cavv140yAyvuB7PvKxRTBHT9IWj+6mB+ftQn0T7lo7JUcVo2Ddi9Izso/dKE2uWS70UAurlWABvVhcWvh8ZuSUk4iGjU91fBFGJMyvha1o7cNTTAsn0yIGsPeaSS2IEX/CNR2kz3bgpvtQ3+y/zq+Lcu6NwgHxN4wQHBBHg1+ScxddA7Fl1nwZZyaNVpKcpymKNvoD0WZy7Fvufps8cHUiMNgDOcS/UBGbM+Ur4jOUMw8+v5/KXXVENJ+f3r7YgUik4XS8RWb+D8eYaouhgrTVXYK2jFJrvg3PAo0HEUQXjSdQBdrZN/lXhhshHHiq0tiQkAl4vskGnHkdCp0oHzAIjqPpry2kDeXKq6eSSWu3DiyZO9p8K3cZ3kJYiPjNgV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5936.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199021)(4326008)(66476007)(66556008)(66946007)(316002)(478600001)(2906002)(36756003)(8936002)(5660300002)(41300700001)(6512007)(86362001)(110136005)(52116002)(38350700002)(38100700002)(6486002)(4744005)(6666004)(6506007)(1076003)(26005)(186003)(83380400001)(2616005)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmtXOWREZ1FZZzZIV2loWkNxZkFxSklSaEdNQ3I2eXZMbFZzR2dtTVVZbHB5?=
 =?utf-8?B?MFU5UTdHYksyelZCa3pNMGNYSXJ5a2hSOFFCV01qa0NOeFd4RkpXMEdwWUo0?=
 =?utf-8?B?bUo2aUE0L3hHZzhQblhscXJqSWdCSzlGbnhkRjNEUFBSOVZRL1pnaTRaajh1?=
 =?utf-8?B?U014bTJoWTQ2S0ZYeGcwdTZEdWMwUnBhSjJDRGlQMGdCekNUQ0RMdGNDT1g3?=
 =?utf-8?B?eEZxODF6c2VoZlNtWGoxUTZldVBWVnFzZmNRNjJDWTFqQ09vVUY1bkkvZWJv?=
 =?utf-8?B?NnVhYVZzbTVUNVRXaGJoSnYrUWRjVFBRYmh5UTl1MGxCS2hGTC80ajNHcW9X?=
 =?utf-8?B?eGlNMzRlWTRhTlR6ZUdRb1IrckEvV1liUGlRdFNIbE9RQ3h5eDZRN0NDbmZM?=
 =?utf-8?B?N25RZnlwUUFLbFJ2cHM5bkIzb3ByclI3NFZEQnBidzhoR2kxejg1TEF4NmlT?=
 =?utf-8?B?WmFnRXNwQ0lSdDBTczlpakpmNzVpVkxSN1AzYUw5d01Yb0twTkttWUNBS2tw?=
 =?utf-8?B?YkQ0aUxFcWRlQU8rc0M4RFduQ0tRNm1iYTlFVjB4b3FhTXgyY29za1pmaCsv?=
 =?utf-8?B?WktuSFVLOXJXSmt1ODJKbk9xekg5RnZMWUQrWE5uYXgzdDdwQVRncTZzd3RC?=
 =?utf-8?B?OGdGaTJqVVNQYmNORmtmb3RaV2ZtbjVzdGF6eW8yK1Nucm9aSDVZZGp3cDk1?=
 =?utf-8?B?OWg2TXlocmRPdWlubHpVWVd5NnltdEZNc0wrRGxDWVJUK09vODdkNGdrWitV?=
 =?utf-8?B?V2pKbHpnK25OMk55eUt2T21KRkdCSlB0S21qZW5STWJPSW9tV3RCQzVkbUtG?=
 =?utf-8?B?QitJNVV4aU5PQ2NWQVBjYUVTQ3ExZjU3RXh3Z1I3SzhVb2xnOStxQkFacTl3?=
 =?utf-8?B?aGVOZlljTDR4YnZHTnF3amdPbkxrUzgzRG5YVUhVWTVxSSsxcUExL2swSlNM?=
 =?utf-8?B?dENUN1BkQVZmbFZFUUNlSWtPM25nY25mZVAvbFVLdkxwMXRITE9nL2g5djhB?=
 =?utf-8?B?UjJUeEZEb1lhaFIrSUJBUm5KdFJmY3EvTTBNMWc1cTJMcUNHLzRrZXl4dVlU?=
 =?utf-8?B?bnhnajVEYWZ3TTZDSGh4ZDYyQmRjUS9oMXdYSGhjUWVqUW9EbGxZSzdUNTRr?=
 =?utf-8?B?OU5nb1p6YmN2STNBNVR2UGM0bE1zOHJ2RC9wL0JYU0hVWEpITXhYM1Q3Skp1?=
 =?utf-8?B?emFZUmJUYlFnbXV4bVNIVUVZUVRVTDlqamdDS2pCZndSOUpRZkhPUjlSUVlv?=
 =?utf-8?B?a1psQnprWEFNSW1VelNad3BqUmgydU9OSUMxcHI0V2dJc0RhRDc3ek54MkZx?=
 =?utf-8?B?Mnc3eFR0WjJTbURIUEFNMmJzelJMbjc0bXhZWHlhWWx6V2tpQlNrMkVNZytY?=
 =?utf-8?B?YzFNUE1CSENoVjdQcThnTjVxbU54R280UWlEaHJnNlhVUXJReVVlSGRCb2My?=
 =?utf-8?B?cnN4elZtaWNCanFsM1VnYVp3dFJEQVR2cGpzeUIraW4xdVlwM3BhMk5aOVdv?=
 =?utf-8?B?NXY0dStzdmZURVRmaUtOdnhTcTUzU0NKcFUyT1NWQk0zOTVhNnZqVkZnUk5W?=
 =?utf-8?B?ekNYU2R6RkRzSVlrTzRTaEhQUXNrUjRKbXFwQUJRYWhVZGt4dEJNMzBWQWtW?=
 =?utf-8?B?Ui9BSVJpenZUNE5xZmRlTEIvM0JsR2RRWGNQRmRmbFdUa2JqeGhwVkl3bm8w?=
 =?utf-8?B?SWxyMEh5bEQrSitkNlI5S1VVQStUakNDQ2hnRW9paDd4VUtreGxaMDJiY2NK?=
 =?utf-8?B?dGtpbnd4Y2kveG9kcHZzaTZnZkhJRHlBQmh3NnZNR0lRL0JHQUZKdkNkUFhr?=
 =?utf-8?B?Qy9WdmhSczFGaEdxUm9FbFdGUjZ0bXdqWGtKVVUzZnBLQXhJdkxScUxJY290?=
 =?utf-8?B?ZGFVS3JncUI1MUovNVp4bC83R21ONTZSMXBaV0xJSHNwcUQ4OHFUL25CQ0Zw?=
 =?utf-8?B?aXN1MURGbEg3Rys1QU5Sd1ZxcjhoVC9tRndDeVU5UzFHcm5XWWJwOHNRNVc2?=
 =?utf-8?B?V2lURUlEUmh5V3ErU21ncHcrZCtYci8rb2k5SXFYR0FvYVNzeW4yMDNYemNK?=
 =?utf-8?B?aWlkYUM1RGlWZjhqd3luSmdZeE96U0JwQWo0dVFOenBIbDNrMSt1bDBBL2JB?=
 =?utf-8?Q?GYFJR+9XAvdT7g0GqJyEziisq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1edd1555-5aec-4d7c-2b7b-08db7b71e2bc
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5936.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 03:02:07.2589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNxC9aQgTK9YPn1e6vaKeU/4Zo7wjgWzvCz6Mj3jq6wQU15PrX5DoIP4WWzBjdhAqtDZ48PtctEGF1WCDvRD6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6231
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replacing ternary conditional operators with conditional statements 
ensures proper expression of meaning while making it easier for 
the compiler to generate code.

Signed-off-by: You Kangren <youkangren@vivo.com>
---
 net/mac80211/tdls.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index a4af3b7675ef..41176491965d 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -946,7 +946,8 @@ ieee80211_tdls_build_mgmt_packet_data(struct ieee80211_sub_if_data *sdata,
 	int ret;
 	struct ieee80211_link_data *link;
 
-	link_id = link_id >= 0 ? link_id : 0;
+	if (link_id < 0)
+		link_id = 0;
 	rcu_read_lock();
 	link = rcu_dereference(sdata->link[link_id]);
 	if (WARN_ON(!link))
-- 
2.39.0

