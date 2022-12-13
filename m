Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D6A64B48D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbiLMLzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbiLMLzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:55:11 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2102.outbound.protection.outlook.com [40.107.255.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E68CE10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:55:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGEggyrurHo7TD8Y1mXdenV+g1jwSgeS1sYCLd71npCZizBI5r9/2WMrblgEkpNtdRf4BdbRi3uwn/nbpAvdqhfw/x2XiaW2svGawnEwg+IAiWpTFtzE3dMKh90zbkiHDMTi8WXkdZjiV9RXZwiLh12KyKLer0rgxWDB2i3KwBjA9qa+LAYryW5hStbYsj1d9NFuoCWIl/Ibw7Zl9gMH0dJZTcdcDDzNNW31KkoEScNnahY5a0BZwE490K+q01Xtga/leX37ztLqEv8dSh4N3S8DzNKejRZ+FO9TWWk/vsMdkuxIjqvGzewsJK98y0h1zsGP1XQN6C9VSMHv5vAsVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSKwJQ6H6KsOFi4xd1MxCLvXFm9rT+aTjtd2MR5zixo=;
 b=E1pRS64L4WtyRGQQMzI/Llj9XMYmPd0pLb/wk37iFf5Y2mT82A5WQaNsFbvsY3wTur0yFk2VyG1GnPKC/T5yhSioYruLLdENoRYI7Q7RcYVXZyXnK/xCRU7I/0EkzJ7isjTHRmi8MUU9Vh0fW4jhccejQTBb9Zf7amUMZUNrRXAWC3gvR7zBOOblvQzdEJxvXCuQtKzHs/NpbI9svaEU/XswoACtFeuRBvTyQzJjo1XU4yc+k4CHJWgegchDsOLTvRk+mWv6N0p4mIreY0e2tsxKUk+aytYlQ1bWW8KENLIgeBxpP04iPWtayroTWlu7lNQKbE/ch8wpg1QWwUhYDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSKwJQ6H6KsOFi4xd1MxCLvXFm9rT+aTjtd2MR5zixo=;
 b=QqKnATV0R8VFa5QgOzsfqEq4W3F6q4T6afG7M1J5VaePgIXtRm2gpcu6XdorVnjCURia+bf6DVgzbOusG6FYreW0ADZETDkxd8p3Q8QX4ELXat7gNKk5gN7GH+sp8n7spU4+M4Utg1bxH0X9cgUlJRbuxAvNuL74rJ4dZCa6mVsZ69Vx1eLLo+XjCD9gWTuha3uSKOqHDBGp+doEPJ8BtAOToJwpgj77adE8Upw4J4+n/nsFI9KGoVLX3J0Pre2L1GzaMBnyMCIh7/lBVi7hVHKvKZPzPV/zLvJ9z8BhGDPedIL6T80d4iuaiUTkEVvlSwJLzr+gBceGRarq3ACraw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB5884.apcprd06.prod.outlook.com (2603:1096:820:dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 11:55:03 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 11:55:03 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix iostat parameter for discard
Date:   Tue, 13 Dec 2022 19:54:54 +0800
Message-Id: <20221213115454.14885-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <ddf243c9-f557-7f11-1964-8d2324f84092@kernel.org>
References: <ddf243c9-f557-7f11-1964-8d2324f84092@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: a882c587-bdd8-4f14-54c7-08dadd00dea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SL55qWGRl6McQ9CMaAsrG0B4szOGZCU8+UxSUJ2pQXe4m1NGZxwVsvvCmHdtik47+xrCzqT95CpdydtHqFKlOgbXGS4C9FOxntF5EDUdEChfHEVMpmTmRjcnoCjwl4jzDypFCN8YCeKbQ60PRUmG/EYrm5Tf6tUMcyYAGLKzzzWP1MK6zjAi4kXvfLwRS+DdBskTznx5QtjccUe1ZcW+OZI5i7lOxZVHg69E5aXPwb1j7efcRI9ylQtfNcGjxGyyTwQvpoNiPHX0lj2FxGMNaXY1k+ua4vU4CHIb1BsQ0tsLm1kP7sMApD9tqsTNO2i7Ul2by9LpKo2bDAEhsZVaiz+AMKsPKpov31RH0YsC7yo0LuAFULO5BTHGnk8IvZ+tVVcWEaWWC7jfrJj/+LNRXGLqpFuN1fdJd9obRewyJET//YVePY1Z2FIpt2B07bk6DWbg2P/lAJjhZXaIufeee6zk+kPocsgHe6fHLzpqjAQRc/pL2N53q4iOQAFOxHLyIJ2gxSvlfWnQ3GZ+7ecNbInMARi5yu7ds4wGspTfE3GrZqVaisticcUWdEiFaUydnjMwEZKI+CJSAvx6at/Zo5OWCzInKpKMhOEg2DabIoxwtwWlU/Zf7Tr5Pd4jk0PALTfCWOqzcIKTC3YA/EhcNuwb1TkPLdFBKK3iREmWQ144Q5obfuxFTy8gXsVopXcHnBL0uGLF3hI0gNrdsfjJ1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199015)(38100700002)(36756003)(38350700002)(26005)(86362001)(6512007)(316002)(478600001)(6486002)(8936002)(6666004)(6506007)(5660300002)(4744005)(83380400001)(2906002)(52116002)(186003)(41300700001)(2616005)(1076003)(66476007)(66556008)(8676002)(66946007)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JVODZVP7F9E4W6ouYuKqeUCxks3We7eV9q6np9dZEV52IVhPxq85o8nqP+Sc?=
 =?us-ascii?Q?f+AdeV1IPu5Pu2S3EpyRqk4UJXZdxJeG28z9KYjZrSSm4Mx3zqXyIPngkQh4?=
 =?us-ascii?Q?5rkqFvrfdeGvISZjk9ODFkhzefAPTt+HK2p6wMN+XSTykAeHbG84+8Jw3YGt?=
 =?us-ascii?Q?tuzr3dQeVBtzWlZbIV59TysV1WwSoJFhsKmbx5HaPtNCCRmY+ylNL07xqnUH?=
 =?us-ascii?Q?vKHF4xxSyuLAOazq8fpOpbQx8K1jGoJlnJYLEUFseSbmEpxac7qSsmA3xYHF?=
 =?us-ascii?Q?0MOev+Fgmc/9g43iF5SG9cFXIyfvBKYUgEiXBxc/1vDMyPq2RP/4SPNwKLCO?=
 =?us-ascii?Q?hMq0q5KSkRmJaiuS+EWiodBF8sChyu5DLCSqzS9w0lbFvzXXoFpzGE8c6wM4?=
 =?us-ascii?Q?hENSDKAMreiQ4GL7cKgm8lZwnMH2hE4lfARHpOl1CrCZQhttGJIohRdvDZeL?=
 =?us-ascii?Q?NgoGqu20u8RaeYtTaWh3eq7+h3GE+TO4QdbJkhOj98AGeuT357z7C0be3ieS?=
 =?us-ascii?Q?wDaUenqxrmkwTP2D6yGahl1L+duuOs/QXQlpUc2AUB8wPkgE/3rlTuGli8RY?=
 =?us-ascii?Q?j2F/ZLTDwOIHTly+0oaOIDJGSqQSvAMBQA4etHprExfzMdeyKC7xYEY3FQ8G?=
 =?us-ascii?Q?2P3EkdV+WgywHdfy6x1u24gB5z6y8RDY8Uw59kSL/rFolunz8CxE2BdZGB3n?=
 =?us-ascii?Q?pvAIdYaPek5ARTAxpOn2jXvYks2IEb4Uw82gV1bqEVrMCZjlL4ta5kaGZzjU?=
 =?us-ascii?Q?pTr6Eg3oxpsago0j0EOdC5byY7C6kGrkAJ0GWhxiYMYy4OtxEm7A8E+Q+WuJ?=
 =?us-ascii?Q?g5lO2PZO9iwpIka/UoRZVsQr12bCyHscSYanPbGk0n58IZwM4Vz7ozQ+Gh1r?=
 =?us-ascii?Q?WV8iI50Z+zNif3fSQjK5aqSDHBTEPfgtX+pOMDqIaBEOx7aiJS7uxr+TYUbM?=
 =?us-ascii?Q?9Kpp3LHsFZrF9rieuZe1asb/h740OT6Dh/AAWvL1Thh/RcbRNzslRtbq5ALa?=
 =?us-ascii?Q?B2rWuXY4mEWKVbYGZ7lnYg86qWdLXNJ8N22gTviefdUcyqcYZ8fcrv2AchXs?=
 =?us-ascii?Q?FnBWQAGK8lTELvrk4FvwqGXTFTYYixE7DCzER5QvpW20FUsPLV6Zvi5FOFpZ?=
 =?us-ascii?Q?TbzLLYHlFj8FyTn5cOs/gLAvMhim6XIB2flzqr2mbx8EFYjNY4HSqiYLwv4Y?=
 =?us-ascii?Q?Q82YV9fbi6MM2mglVtqkYX+QllT6APsD9ldIRkry3CmmOiTjclpQgCU6izqG?=
 =?us-ascii?Q?CUVyILF1qXJMrm67uD7SnD9pa4VKLYCwRQI4PAjSE1zW7YbFTc4icT39z25N?=
 =?us-ascii?Q?3XUUyHaRcM7bHF9PPtInkkLcq0vVYaUQvEq1EzzMyP8a3Mfh2BmpdKGW+hel?=
 =?us-ascii?Q?Vq4fdxP6kR6qpe5qccggjH5nDKWlZ3N1mAyklCYLHM4ayVgZG27hTfzMdpTc?=
 =?us-ascii?Q?bYPniYl4tO0mSY+6tgphA3hyEiUROWl+0KufygzoCRoDdFutOwYRbcxd6GWR?=
 =?us-ascii?Q?Q1areAVp+9XYt73tuI8WIvJWWvdDFuX++PNHwbkgTn5skuFvyO3793SrGw5q?=
 =?us-ascii?Q?6BRZHpth/KGsVhEOuXvKdEIgnstrcBLRc9U5BAmk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a882c587-bdd8-4f14-54c7-08dadd00dea3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 11:55:03.3830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvvQs0KhPe+3CxM9LbK7T2nKWD105vpi+hAxjzrXSf6xulijbhpmWEJdg+b7js4In3UhkMqIWE8Uo8gOMug6vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5884
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What do you think of extending this function to support io_counts?
> 
> void f2fs_update_iostat(struct f2fs_sb_info *sbi, struct inode *inode,
> 			enum iostat_type type, unsigned long long io_bytes,
> 			unsigned long long io_counts)

Support to have extra io_count.

But I don't think there is any need to add additional parameters to f2fs_update_iostat.
IIUC, each call to f2fs_update_iostat means that the corresponding count increases by 1,
so only the internal processing of the function is required.

BTW, let's type out the iocount of the additional record in the following way?

time:           1670930162
[WRITE]
app buffered data:      4096(1)

Thx,
Yangtao
