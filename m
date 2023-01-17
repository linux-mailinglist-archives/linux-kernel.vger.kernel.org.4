Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F04F66DEFF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjAQNiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjAQNif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:38:35 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2121.outbound.protection.outlook.com [40.107.255.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398E559C8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 05:38:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwqKAFxxLFrKV/xss4gCtCQsSJmdUfMvvdg8CuLBGVg1kvlk+zhmLAamJS5fWx5AeZPpe7kjJiUsxE9WkIeaZ5c0Dm4olrLR7GeIYUViBTx+bH8alSAB8dUwruwNhs+l0s54g0mYqPqbgggUHLumNOnuqVZ49Vyt0s1pixOORlZBT0qrUoNoUYK/8CtYs+f8KL3fdhaqTMo2env5LEMlICR55h888gdUV5sE+KuZvgPi8V/rC48eKom28Vq9mvjIILKidRVGFuIa5TdDkVcFn9pLiv7yMHTxEFj1NXeI85A8jHZfLuYc/2xrrO4ov+2agE7YsDriF1oHZFlThnB7mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilc9EmlpFb+C3SV5SuHf0aAd/yiSTPSIvy4GYP/YE/Q=;
 b=fILtVTfVsniSVCecKoJS9cZPLUawDnYbWgfKHg1gL2Xrzm0iNYNtu5fmcskRrBt2mzpIHPXXYnbP7tbVoVPZPIIo1l7YBCF5YrMN0dVFn6bkp3w6JEuXvumzN4XBU+r6Btdt1VgUmGBs4xW1Rr8wF7rtB55zxQjw4Azs5pj4NOyANE1cmYMHI4pRLneLTiggH7Sm7uqnKhLx4DzU5/qPgvxtrJeV/oRpl9cvRdnoaVBQ4YLWbWBtyidBi+V7PDTE2RLDe0lZnht4qjwxCjATn5ysyglpM9xR+caqlzIw3nPW5cID0nTcLK/cQRVzLxB9DmtYAVWEaUwYJQL8dhS9RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilc9EmlpFb+C3SV5SuHf0aAd/yiSTPSIvy4GYP/YE/Q=;
 b=ag+31l+EGnNLzXDdJdKjpOXf/fmXY0CCDQq5nz3P2BeIdFJoaXibRI31H8T+5k04aEncvXkvfJCGZ0Vxz/xEbWoNxQUUO9F5KjUbYKdezUnThgJ/+hmU+P5njus609FLKdPUuY9LF2hOXHdfPYcgLdv0yuRDtXLsD9ZBju709QpLkQyGSrCm8L9AEn1drw1UcTML6Gh6ifHAp2DjPQG0v9zIeCJQa6LsElvjdBDkBj9oHTtgty5Oubce0+JOzZ/zxhNPdT5FcFmlXJ5VBU+xz6KL5W779aY5LcPCN/RkJIrrIp5nAmUga3rW7kuXoaL1MJxLSoaiFsypBtaMdJc5vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6239.apcprd06.prod.outlook.com (2603:1096:400:33d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 13:38:22 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%5]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 13:38:22 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org, qxy65535@gmail.com
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, qixiaoyu1@xiaomi.com,
        xiongping1@xiaomi.com
Subject: Re: f2fs: set *_data_age_threshold according to user_block_count
Date:   Tue, 17 Jan 2023 21:38:14 +0800
Message-Id: <20230117133814.79508-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230117115702.GA12653@mi-HP-ProDesk-680-G4-MT>
References: <20230117115702.GA12653@mi-HP-ProDesk-680-G4-MT>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f13d72-b2e4-4d8c-0463-08daf8901a00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: erMlTJc0E7AH0VfygKoBRAI77DN5Y6cD4akAxLUtJCtuKAzGQqRvrvwIBClbztL+6V34QqWwqEMEVxEZD9Gtv7OVOI1yI5h1VMCm1nBwaCMb65b4H5c7LDFhke473zPlZmhlkLcMKplyWP1u2TREjBQZb5fMddB89ZAemkuA5rmWpISVKFft5+2cuVCESFh8LeiNRQm0NBqeclF/RGph+tm6Of/pGkqypo7IMyN6N0v+ydGFMv/dXjthGhacG6mjlTkOHYgYYqe8Lv7tc1v4yqiJAbBcgkI1+14Et6zJ2gapxJB5gSgQ1G4WIfO7zmtzQ5yxCjamwUJOE/bc9CivfD0J0tLYFBhUA9rrd6bMsc3tmSbbzEWHANcfa/bldbO6IxtU/Gyc5ZNjWRc2LsdvkZT75EtWe1BpgyLnJXCK3c2nQ2vqYjqVAsVZuAMncxdVGQ8yWvGSlp5lYfwgp0dneeTlDerciThd4S9XTjRt1lEng0frRCCR1WtgapeyRc2vosMrtN1OIXCHn8ToZs2JPiR8Akk/RcTL5LmQvQ2myxETN/31pruplXLMa4wQgJWJs9pTGLkw4XEASiaswovDY8Ey+Rt2G8sTHEOjvPDjRZ0Dga1anzwe+cfUFfPoD0EyMCpbROFZAN3nQq9XrDC0zPPbKtdfAEUWByxv+9XX0GCaeqWkAb7GmUJF5wocJCL/v3lLdknPzRAuLIKObuIdvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(39850400004)(346002)(136003)(451199015)(66946007)(8936002)(6512007)(66556008)(41300700001)(66476007)(5660300002)(8676002)(4744005)(186003)(86362001)(4326008)(478600001)(26005)(36756003)(2906002)(6486002)(52116002)(316002)(6666004)(1076003)(2616005)(83380400001)(38100700002)(38350700002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UkBUXhleP3mst3Yww4uiBQxjuQZPiwm/JWMgLYPyYO+JsWGYbB8nncNSAT4b?=
 =?us-ascii?Q?2f6OvSBBki0nj5BA5tjzeNV3FVsBaSS+61pfVmPBUNL5sFe2LnE2u1WXTXvH?=
 =?us-ascii?Q?PtvdOCMn+e77C/0tQWxPOqVsMM5Wm+GX5BuhLI+7AOAz7f3AZpvAs/Yw7JGZ?=
 =?us-ascii?Q?kZJCtUUr0Qhr7+z2m1yRYY7L/hYrzrdtAYu6t45a2OAUeAod5AjVTF5I4nyG?=
 =?us-ascii?Q?EXbO+cwTAgMZa4HM/RbQt7Ipsj9GVIy8itKOQ7roiyzZlP+o04ilz7PhgrLe?=
 =?us-ascii?Q?KDjHpWgrLjIBQgQDUU/vTU2+bg6LrOtSqJGq2wmhztdKdPK6/79IrCXezd62?=
 =?us-ascii?Q?CIr3Bfh+JKOnJUuYSQ2QqB6WS5SFHQXIUivqBiXPzZiVgWdRO9QsgJm8F0wp?=
 =?us-ascii?Q?UBNH5gMRsIeaEYkDDMStnxdm2qcspERiSOwwH3okrZibFHhY17IVdPn8A/V9?=
 =?us-ascii?Q?ZqL5RMh/J61ZNIXlAuioJCEoWVcfHcsdpz/FN1PeGL6oFJEtbs/gnCJOf3AW?=
 =?us-ascii?Q?IRoD+dlDO99WMgzfkONLKAtsLDsqZAn8VRqLqIddro+1pqkyaqwZkEtAfzrG?=
 =?us-ascii?Q?Ij4D2kZMuABneZfvmNW31qYk/pD5zVofHt1y1v9hnGpXz/oYHehzGheoLTtg?=
 =?us-ascii?Q?wZjT3KajbRyrjXWTn2yBtfwkz1F+QQDf87zegWvkdtRNp0qrWTTwxH6bz8KB?=
 =?us-ascii?Q?f7vMn6mtl+kVHbgZaXOelXa1lBx9xypxLpA6mC+tiryyrRrA3ZqlqYc+jRWT?=
 =?us-ascii?Q?BHpYY/o6zQKu5ydljSpmxoPnLQ6D798E7cOCZ1L0iNyVDhLwU3tsnl5EpMm0?=
 =?us-ascii?Q?SvQwhXL26qiWbZyf124YoaybTBz1pP7ePam3v1v1Bi63GDU33RzoL/KXAfRN?=
 =?us-ascii?Q?mMDZUqGlmkR3u64RanWSx4gPKPFkaw9E6xJct5mfwwyNLHTGU2t06TF5Hfv6?=
 =?us-ascii?Q?4rLVLkhLGal3i+luZKN7d95fUm9+0zGDObYD1v/ZrwI7Owc0Z68nRwCmKphL?=
 =?us-ascii?Q?J0f0B2YovAqhtHkHSjjYA22cd4t3n0R6vsthZw1+qPFGdtrj3TS0xbHjaE6i?=
 =?us-ascii?Q?9rya4AsBLOpgsIXU0CUMJcUaCU4bisAjZmdbpib7GJYPpfeLGlmmir/gJ9KO?=
 =?us-ascii?Q?mBpH/AjZ+UgC6zndC5IkDK02NYIVeCsYYbDoEQvI0dBfJzUe4t4pXqywE3/F?=
 =?us-ascii?Q?nrachXuUgoOJDzstayfvC7KYJTC1Ad7HdcrX7w/DqeeTNYrakWr0T3un054C?=
 =?us-ascii?Q?c0b7701j5foMwC8/wmBKb+MxP2ElsIQcYVXI0rs4pVQX1Q+tGXynFlzaKUPi?=
 =?us-ascii?Q?adrPL9fZqFwIcj4as8gbDX/D2NHdMLPq5ZVU65FVoW1iY6gxm6pEOQCYduun?=
 =?us-ascii?Q?AQbaZ/Kym8gNOwYLEnGMDAiv4BWnmjwpj/oQcLszTZsiBZtzpooF2gg/Ci4S?=
 =?us-ascii?Q?BqUA7qY43RhnRkr+nHvVuQ6Oi3ERIuIh/Lvyksn65X4QKtuupb7qoeUqqC63?=
 =?us-ascii?Q?nqF3cm5ebAm3G1zpbNJGAYGB1cbv8GuIuW9bKzoftbLIh2/+Z698KeavSgDp?=
 =?us-ascii?Q?d1WgFXR74YWn9hhOZtOmgG0BR7DtwjrX58hSKdKM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f13d72-b2e4-4d8c-0463-08daf8901a00
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 13:38:22.3565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6D+wmsbqFcu8lKPcCee/OUFYatIVNNDdYcyUVe06pIKYjSR8Ek0fif1MGWF6pZBFcOML1PDvg6vro4YwJKNGPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6239
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi qixiaoyu,

> The block age here refers to total data blocks allocated of filesystem between two consecutive updates.

Yes, you are right.

> So, it has nothing to do with storage size.

But I think that the total data blocks allocated of filesystem between two consecutive updates
has something to do with the storage size. For example, for a 60M f2fs image, the lifetime_write_kbytes
will hardly reach 10G, or even 1G.

Thx,
Yangtao
