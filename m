Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA106D35A2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 07:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjDBFml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 01:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDBFmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 01:42:39 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2098.outbound.protection.outlook.com [40.107.117.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F871B368
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 22:42:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMVYz3F4kyKxyE1dLlpNjyqSjdKVXDNV5gHCDMdqZnd3AnwMUHBO1aWfurF4IZoh3N+a6EnGM5/Mn630fzMXkNfjq41PuzrBS/GBkXljtAfuIpVzoCY75IYa3GBgjt8SBP56ygJmmbP1bdWdFaEiAb0ItUf+Ycb9HWpuPVV4CwFh0xsHwKkfo/S0ipNt968ajJcTtawJ27cTHLNDdXSzoW5hQanfO+dULBWgA59x7FQ+/4PaQQWvHZMFUEDQQEIc9bhBtqCe4s/sfFlwJGHkitr/JWeEI3CDMMRc6PHxAHWHPVWoOxXnFG1Hdjo9dfhqUUvc31hcnKbc/eJuZa7KZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hovi2PJZMcAxgtrllGoIdg6aTHuD4nISpa5rq5g57Mk=;
 b=HClgQbmg2zkgQ8fVuXtdvgiUv1mqStqJo/i6ynFQcK0rOBbHwJxE8S16h9aSHhSxXw5BoUDEkEToyvGQkOK47W4ur+Ehr70AgdLpOYG7d0HTRy6QBmftLg/ETQXp77D1pqhLJYF4ETMoCfb1X1sXxqTXjEIPYOlzX9ZM1OcMf2WK8Nl8yu29lkm/2qTtPko2YXp+NkxiOMn+CUvJn2HsWrzekD2mxpPawkCodp9XxAT0WurRquL8cWbTypYtl3g24f+ir4bJDB2wytwRfnGSo6cOw0/KX1OVuQ3vXOedxRb5cmYyWn4IlWvNaN2MYL3B71lyAAZu+3wpT/1Tw7bMfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hovi2PJZMcAxgtrllGoIdg6aTHuD4nISpa5rq5g57Mk=;
 b=RBkwEEm80mIgXJLAWbePAZHWVvYIw/d9OToLdzt3rs7GAyg488qSyWx5sLQ0YH/kC1jspDGqks9CxFZVMFoa8epqBMGzr55Si7ztvIP5snWgmRn5M4CfEjEcawu0lLqb3ESXG8P8aYrVMT7VRAE7gNDmsG7wUWvrkWt/sp/QRrPihJ3lf7YKnLKI/15aZSel/AG74/Hkgi6VNbeuTaoLrRh4ehqm2np4O2VlLRRuCZ1xWL1lRZ7YKee18rzqcvkNjtFjliQ4FXnoL2NqxonKZu0cbH5qe5ZqI1lcGEkDcXNbw8gxdcYlSBZO8rnNPjxamIlv8dNaXKBF+neQRb9Thw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5447.apcprd06.prod.outlook.com (2603:1096:820:c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.29; Sun, 2 Apr
 2023 05:42:28 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6254.028; Sun, 2 Apr 2023
 05:42:28 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     vbabka@suse.cz
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        patches@lists.linux.dev, Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH] mm: remove all the slab allocators
Date:   Sun,  2 Apr 2023 13:42:17 +0800
Message-Id: <20230402054217.61042-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230401094658.11146-1-vbabka@suse.cz>
References: <20230401094658.11146-1-vbabka@suse.cz>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5447:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c14759-e8f1-4a9c-baa7-08db333d0b65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ujWE/PqnMYaKAOUAVcKoed3Zz3MihBFZZ5/VUPbYQNiPy8TEveoRa0DZozi2V7oBYoWhYO1msz6WZC2/r1d0fewQqELWQMqSrsZvZgmrf4HhFSqDvsn//yrggTboJKVrqUyF+izOFlULoUzn+DXA42mMz29CuFOoJtH5uEEVaV6MM9mUNOy6ZZA+nMnaA8kcmNE0sBeJVKN3Pe3A1fwZ9JoDrqKfB5C+eueSVrm+cXSXLgp0oA9BI51O1aT5ZbntcbrJSgPv75TO+Uea8UAoy1S++kcyEo7q932WZwYnvyi8tL55XBeJtKyM2+bNp8SxQ0dRdLYmeLKPi3Gy/wAYKH2CIG3obr4Yxn20+rQnd5LuNznB3JTuyOUhzPLxHWVSbGBdm9OagEpK+oqxqJQA8TGG7oU2W0S1rM6ghtX0OhdG1/VDrPfKINpWfovof2+0xSd3BYViQO6Mw2m3ZT+HOIzSC8lTYLN7/rePDxofCgiFbRSqBG1zLZBQ3MfdpUW2/HtW64LY7RXlkojZ4xRB1TL5xCHL7+lgMvoyUXuuWbQJ6j79XNAu5PmfZ9MuVgALyBaBkkowM3h2vaeoZAuNM8e2hYp4s/2Ke0zlOmeuEB42Da8V2ktsozCVboi/kuBx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(376002)(39850400004)(396003)(451199021)(36756003)(478600001)(41300700001)(316002)(66476007)(6916009)(4326008)(66556008)(66946007)(4270600006)(186003)(2616005)(6666004)(52116002)(6486002)(6512007)(6506007)(1076003)(26005)(107886003)(86362001)(558084003)(2906002)(5660300002)(38350700002)(19618925003)(8676002)(8936002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wp4M5RsHEuJWuBIdi3oht29Las9kn+AOlEfiZ+uPwWvnb+i1pyfup9iQZMXq?=
 =?us-ascii?Q?wsfCI52wopESZq+pQYAUqvhh1LEuAyESxmgc3m7fwoYGcmNPX2Y5KGuSne5k?=
 =?us-ascii?Q?L9Pq3l+6mXjzcgWEXlMmryzz4/hKTVacu+6wSxiKg7m+Kkq4fST0hAK3NCs2?=
 =?us-ascii?Q?jiXV+grgeEV1wAs4Cu1kuuneiV3TCQP+3Q+4ajWZmVO6Y3AKv4jvvrg4ssTc?=
 =?us-ascii?Q?2O0BI0YOKe/YKGfs3g7VCcPH0x7IOHKcvqpS/+SzkhccIawKouyMOl35I0dS?=
 =?us-ascii?Q?W2ZL0mAUX1a8CVXSNDAkZWFShVdc9EUgm0beEPVksiRAk3opgWXIvpO7Y0yc?=
 =?us-ascii?Q?fm4RUvkdbGL0dujofQjTzRK8wOnn/lOeygnms45HNgqm+orQu1llaDiS/Rry?=
 =?us-ascii?Q?ulkwBvgoBTpkP0AWkqL4Zh7SgSSpua4eWH/eqEzPTvzDlMXR3jXOPQ2WxnYm?=
 =?us-ascii?Q?6gJsCpRRucgXK6gMAP9P7seaH2t1ViNZpw5yXImN3HyMeiDHbhJr1XL5bdBx?=
 =?us-ascii?Q?F9U8yj4LfEWrermIF0SknJb8RyxZaXw0XXzGTX3FbgSmpilC7rbAY5T8O7LM?=
 =?us-ascii?Q?+8SqGsFmoxxKF0NKg1bd+nDlyye44u6PpWRiJ3MruvxJuJN04ioaxtxIdhOS?=
 =?us-ascii?Q?Nnz7AQdAA5qds01qqptqnSrCgbOPCV0UL2W3aI3yBlcTK5rZV/nQ8xuie5dM?=
 =?us-ascii?Q?V+Uzp8bhlUOgbaqw6wL8djXjCZ6M1qV7rWketgZqsxR//JY63AtHJHj75E66?=
 =?us-ascii?Q?FMdk/jpv3Rzl+bmOW96uN9fDkiBZ8OxhGbl1l//VlPTxzgLTy/0OZ7KKieSw?=
 =?us-ascii?Q?Q9qeoBaIi6fIxklWxnpg8G4TpC6xIfvpiDpaa/CPMq1KsPqZNWIB2ZOxD/g7?=
 =?us-ascii?Q?OiYXJyjW7uFOwIRzzVvdra7/HIGJcO+cyoAp1Eczt5+Kc9j3tYhsfiiC2CG8?=
 =?us-ascii?Q?hiaMZLQ5GjcDkTXvrhQDxrwVtbeBHkUpL2qVIzKOiBlQv/XpdWrq3eGZ4y/g?=
 =?us-ascii?Q?BJ/wYaD5ztVBzkCwjrhCESyAzvviri4oVnBno/yR/cAR+8k7lZygWPfg5urP?=
 =?us-ascii?Q?ub8wTJmFrfPB8MMp5viua1agd5fHi6UDTVQ3RYtFo0nt82r6A85/4YXdx6LB?=
 =?us-ascii?Q?ABS9IoWfOA9HqAC7DyjD+51kQt5+/50x9xSf8cT0RI0IgVRu7/UwsuJxprwJ?=
 =?us-ascii?Q?cTlvFpPl+IjKQ/ubmkBvMih2qTa04QlsBDv0n9ajnmXw1aXvIVeW8meDlpVs?=
 =?us-ascii?Q?a9qG7Ri8YrgBJsyjTTsHu6VTeVuKO5ZURTsB+tbPUBc8xew6ebp5m6latvxY?=
 =?us-ascii?Q?MAV9+MYIUKHVD3d4BNeII2emCZl8MfCfyT4kEw03HeLXZ1ZLQPFPHRmVgjPk?=
 =?us-ascii?Q?eobbd/fwLIP/X/25kaDY/VrDKBiaxjK6Z9nUxjS92cUlsaP+3s8O5K4tP9HB?=
 =?us-ascii?Q?UgBj2pWcYjR5fIP0R7HA3wAas/u62YcG/NfGWSHuIr0p8DrZPmRPRMNAIJ/V?=
 =?us-ascii?Q?Upfj1HJxA1jU1e2fCHOHifUsPUspblQXWDrGozfhOd0YSlZdpNBShMEvUJTj?=
 =?us-ascii?Q?WNX4LsTVZeIyAayNIkV5uDT5t+ivAvft1uvhoa00?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c14759-e8f1-4a9c-baa7-08db333d0b65
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2023 05:42:28.2976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZfMB95pvp+EnqNnQRmiEc6HSr6DL69hKpJFRPAChUvpCOnWy9HBfvyxizGB8l84adjQ3YRf62O1gO0cKwteg2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5447
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM!

Acked-by: Yangtao Li <frank.li@vivo.com>
