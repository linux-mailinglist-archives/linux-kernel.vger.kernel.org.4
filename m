Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990CB64F7D4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 06:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiLQFb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 00:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiLQFb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 00:31:56 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2138.outbound.protection.outlook.com [40.107.255.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F822B247
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 21:31:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4zhR2J2KefYutfunq6OpED2VzR0XmhF6lFMZbMn2y716q45GdXYRKQbgKylj4yGCGK5ZzPss/adSnnWDgpujY7HE3o588qcCmGdvXRlZlGBun3WYtfageRnKfnVk9rXHu6qqQGb2YXyTobWzmSc1DP1IKAv3xlNOqSq8E/Ys/6zKNGzwR7eOHhvyNdJG1z+uVR4fvMfMC1x1z2uVgorDkhmkx6+1cvfGS1qhej2kGYYaclHArygkx/zbTVcR9p8QUZGtTmCL8hZuH/eKvpdUzG2W1vY9841Y98Kky+x7gJWsHaY0c8p1Ny0Rd8BY4soHDW4MMfbxjoX2k8FJClx3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVl6QnGFiO2c3mSqSdLfwxOxe+NntM+JqQuI9V7FiAw=;
 b=VuGeUL4Dyo1ndW7poy9RVyUW2oCc8vLaMLj6+gOMD4cw1V9rZYUAnqEoPsQJHcwApLAmJfTrb7OOFn73ugr8PIRx2dblZ0Xwb9NeoLSVxLtC1WEV4+pLqzwP8OiA8gPznskyIMnKaNJq9pE8oxBhsuaG+3PTyyOmpOpj2LgX4ZlB7Bc2nZWINA0ptn+6Vw+x7fLdxqbG00+SA9dsDUZNDqRraFiRr08eEp3ed1OVow2ZpGWjCCeEOooWWPsds/R8WODFk5XOOdKr5R3uJJaYi/KRmB806eHBEhAgcQLn4AL/3fqYKVKaPK0RIBztH7cz66U+9fkPlihD6h2WzghAWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVl6QnGFiO2c3mSqSdLfwxOxe+NntM+JqQuI9V7FiAw=;
 b=FLH2x8uZ0Ve0Eh4b9gDeWaug3+VzUSr7OBjL7oi12sB54jFKqdS+SueF8LNxQxCwpZkMRAViAKiSmYTADOwTTXOZAXOJ/k4ogd9HdMyIBXC/o9b40S7jaBbYBLl+wR4wSGhyRWUL8EFt3tZ9CUJV5L87/6qOy/Jn1zBk2iE/7K8imofkAh70IWStbDemYIGhVhZBqyfhAaV8DUe2OIxLPu3s0b4SB6nAin6ORNDBM97vC4fNfw0C3OF2SLSwSvRA010UXEwAbSZQFmZ3NiBch+JJek/n+7umZ9qqos1P6snuM0ZbvwagmCOxiGjEX/WffAcnKaaA929t1Tg4lNvNsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5216.apcprd06.prod.outlook.com (2603:1096:4:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Sat, 17 Dec
 2022 05:31:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5924.016; Sat, 17 Dec 2022
 05:31:50 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add f2fs's patchwork
Date:   Sat, 17 Dec 2022 13:31:42 +0800
Message-Id: <20221217053142.61678-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221216024506.77048-1-frank.li@vivo.com>
References: <20221216024506.77048-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SG2PR06MB5216:EE_
X-MS-Office365-Filtering-Correlation-Id: c19f31a9-3336-44be-ca21-08dadfefff33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s07Z6dMUAI9TVc8TfZDaXpYcHar3HdjxmKnZX+lShhuzVatuZJZVfqxzIlLNs18Th8DFfbdoQojN8nCOQq7ANbFC1bYMzxhKwos4B6tgQ4yyQsIbJqEoJP8mmlg7SNiFMmvCvk91HxcPFjLsfSrp+W3Cbs9+QUw2jTBoObhMew1Gj3HBTkYUpRHcRuiqUwm+im4wLso8FDAnQWpVVHZHXDzgopoiHaARyrKBi1xGfrYMxHg04N3w2YjJXIwIO6b1AcIuSZTA+WPruypAh0TePTPb8Tc8XWEpw24s9192l45T6/knMNWUKsWWQjGMIsSH4CKuS4bw952VqT9vDixGRapVyPYwxaoGZVmmykD6ycyQH12Umm62DBKaRLOeNpVDXMeoVglsbjTgUVXJR1IWBLbWUIw2aiSjqhe1iN+iE/rDC+p6ybJTokmaFIXnT8f7f8j+c5LkmCKesAnqFyB9Lq4QdvTsFUJE+khc/fxxtBuduHog6tabweSZXoa/bUHEWwlOfsijs10b7uQBlrp02KeVp3GEjBfVl+VfK0dvPCZW3CLhGKN0N+1PoSHBy2soqxIpYXHp6EZzv95MHRnuKwDe7BZvuH0Wj55x5x4QCmW3xtOjxaNsO1Li1lSj5bSl2QIiZYvG3GFjxjo0pIUe9Rmj25vys38YeaP1lRY0emPjPo3XfPjDni3zr36jePSUUCvmkYIAih038t0kJwe4toXLskcfI4hno3nuuSVQpqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199015)(2906002)(38350700002)(8936002)(38100700002)(4326008)(8676002)(5660300002)(558084003)(316002)(36756003)(86362001)(66556008)(66946007)(66476007)(52116002)(26005)(6486002)(6512007)(186003)(6506007)(966005)(6666004)(41300700001)(2616005)(478600001)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ImcyaPofK2DI+53rCxEvMvl3TuyxjKil/ptBtwop6VhfMlk33FKXQPcChz4K?=
 =?us-ascii?Q?00hAfPQUg9AvysLH6lpa/G00RFFD0tkFHj1ZJ9XLFtmjgLTczABsTOOZyV1z?=
 =?us-ascii?Q?tMt1gcT1JwrDosYGnpGjIphe6NlV8aMQ7t4OVtv8qfWCGp2TsObL21soPP86?=
 =?us-ascii?Q?SUZDLt2o2ez/Jc2dsD5tpyvzBgaMOvHAI0M1cmn4mt28p/P9YHYoiTMD5XR3?=
 =?us-ascii?Q?PqL4WGuVEi/8egC2PLQt30XXQ+Cmhe7frVVCzBuqy/JXU+/Ro8pVbPJPqcir?=
 =?us-ascii?Q?F0gyAe6aMn3fsIa0fSAbP/spUZ3PDiHuhsfI1vTfIrJ7gikihz4Q1iC85io7?=
 =?us-ascii?Q?VRmT2TPehbFalIt5rAAoG6VJKNGzUDBi6+YJkHrmU3mSs51XXK6DY7/9V81h?=
 =?us-ascii?Q?QNhBI19LnCcOHtndMAbHJrH57FpeJVQKcjoU+8v5QLOornGuijG00dem2MJy?=
 =?us-ascii?Q?ssuezJfgdWqOvYRN51Xnytz5jWdE8cuHnSJld645YqrX0IAMyDBpsELRI59h?=
 =?us-ascii?Q?bGhmTDsXXzqsDDWzK/8npCdECnpTN5ECnDfGGL2qZlnBek3hK+Zj7PzhcEuS?=
 =?us-ascii?Q?fCB3c1x+xI/ZYKPF0+GMJGOcNrIqih/oXbRXW2wu1joJetlFBezJosRchLP4?=
 =?us-ascii?Q?1gjQn+FjJOYy+j9UpbV3goxBecevt3+aWVX1qOALbFPYy6/4xnTrXN05r8hj?=
 =?us-ascii?Q?+lRVIVlzd0KGh0TtCCEt5m2pMlTxKB1lza0c6RQIxte6hnM3vvmA262rfTj4?=
 =?us-ascii?Q?xYlpsQdmYhixlrrG/veDt36jSt5aHya8uDBTRyyDJQJmxcECRcYGVeMNi6YH?=
 =?us-ascii?Q?XnDB8xB6QNqLbop3bJUKQaGzmBKadVuRixSXFvKfvpSRFt7PsYrG9qPvsN93?=
 =?us-ascii?Q?mGTQvASObCIiSSA17AjDsL9Gma9oQ2zKPuGH9artMjRk98PARNMGSi9xX0cl?=
 =?us-ascii?Q?0BiT9gFqgMqjh3NvZ24TbaDDuoDWzsgWee7hi6gVN0pBPCj1d70Q7EhiQn0u?=
 =?us-ascii?Q?g2Hn5X+DhHtcEhhRdJc9sGPqaXhLUASC3ZI667PRdy/h715zoTzfc1aqMzs+?=
 =?us-ascii?Q?LgNiia0vUypMsGQ/XX8rkwS8XHlob6aPoNBeaITbZ/OLO932OBSYViH9aE+v?=
 =?us-ascii?Q?KgMDohTNOfaMoRvjy999u8t9zuUHN/uuweApBbImWc4XIT4jdSgQUN0gD7tr?=
 =?us-ascii?Q?5VB65EcjDisZblLI/ZHgRqU9qzt/KJGfrIPn0+O30Q1OBPyoOrXHzC7R8gHx?=
 =?us-ascii?Q?N2lCWIFAyBFUnZM7T0vB0G5oGS3DX/Tyz7Dm/7DdGTm+4SAU3UI2naP1WhRU?=
 =?us-ascii?Q?t2u9mnyZOaJiXbvh86NhdaygG7M6BE87LVzC92LJEVBvjy7xSyIwoiwKAU0u?=
 =?us-ascii?Q?nuO3naJiNcBplBtV1wSW0LK84bz5wMCOhxxAmb5I0rZn1oJsMS2wUxERchlw?=
 =?us-ascii?Q?dKFTeeSN9CDX4iYtf0ZPxN3jFyOmGegYO/DRqfePv4nuB3gCqpkq0To110w9?=
 =?us-ascii?Q?jltNQMYuxYiuTA+jITPS1Zkq60umJ+d2d8PEoIEoh5nYavGb7JbVxTZwwRGn?=
 =?us-ascii?Q?ZUSmW/gyqHxMJ9xbxAF46qA9l2CpMKVxt+C5YOE2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19f31a9-3336-44be-ca21-08dadfefff33
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2022 05:31:50.0139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPAG0KTxEXPYsL5wQgDMsA6RF23ci/6oxw+KkHZVT07JB9//w5Zrrv+rJYpK3/Afi05a1nDdrI6osFly85UlVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5216
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks,

https://patchwork.kernel.org/project/f2fs/list/ now works!

I guess it started working after Patchwork Bot was added?

Anyway, now we can use it.

Thx,
Yangtao
