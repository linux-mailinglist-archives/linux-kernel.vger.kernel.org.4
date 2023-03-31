Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60526D2843
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjCaSzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbjCaSzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:55:25 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2070e.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::70e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AE723B5E
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 11:55:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=miK8kKJmuduHT0+tO5c3LsH9QpjKS+Z/6y5/aWwaCDHdreSrggcaUPU+A++Tqe3M60OHfqXwvx+KDOoc8iz/+NHe6qxcbbfmF4I3xtbGgEP6L+ChXqSluA/2u0tRb2TUp+4DP7J2iobZjF6dnkw5GywRBe685ZDHqeOA3o6JX79w/vtxjDFXlb0oTmQ8Gmhxh91qYNiSfLF3Hj/uu8wdHR2Sy7AeEt1nrSmXWGkUPf2ccxHrTM6OKE5cTUQqVhunpFubRye3zakS01xT8rJv3fDGpsZZzHO7phZ3mKWwZdASHMn9Twn0m4nOYW0W3nqP683Elc0ExL16zSyQiB21iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCJWTq6uLv/auggJhoRMfub6sDpvGZuTmTsRwAqj1Z4=;
 b=Z3HcUtb8XbnkKkH5edjZsVBCxbLu+svN1UWQ3sbBwQjNmsFPHBumsu5U+lbOedjwFphsuUOjpXPa1Q1vWQt1+nTfkAjA5MugXd6yjuWBn8o7Fq4H0rbb+Yqn9UYkhQwL1b+ixoAMTVF6zDvN2V+Tqgvrmq6hbVvkeM3Tcmi9XYFz9dzsTek5Z/wZjRkFDIk+V/eHln/YZ7rRzQJQcGZ2OOffBJ9NUsEmNBTovpzoYxb09dWYUodXyoAPwbufnsGQjEmoBx+d0xv4ruEt4rw24V4JLFC6184r/5N5QhtG8E6Euq3/FqSQM5V4ruUfMPaIVPbTqFNqJhCv5Dqhta5sag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCJWTq6uLv/auggJhoRMfub6sDpvGZuTmTsRwAqj1Z4=;
 b=czl0uq42i2IS7KUO/dVhlkAh+e+2H4y69CMF6/SocgCW85c6vg0qb01yV/8j44rISIhd0RBftSsh8LFzbMS0YMuV7bYS5EQtk8MJ6rl4IZ0Us+Rvid9zUIZddIYFMKcsBgfP5SRomcw3sO8xfGXY1GonKMofhZq3CzRN3hGVeyX/TQZf95DVnYY21Ykl2cjCR04PuXzZxCgqGwaDCW1IjXa2PN5pQPszPk4JxO614rZgHNm9SzugdLzXO/lbU8GvSiimDt38DoWxZThFWs2Igo0cVaZ1H5O/xjwGKXilKj5oCyvOyPgTRCJVEJjbC4s+Dby9OlhFl/FLJAWJuEufyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB3999.apcprd06.prod.outlook.com (2603:1096:400:2d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Fri, 31 Mar
 2023 18:55:15 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%5]) with mapi id 15.20.6222.040; Fri, 31 Mar 2023
 18:55:15 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     chao@kernel.org
Cc:     frank.li@vivo.com, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: f2fs: support fault injection for f2fs_down_write_trylock()
Date:   Sat,  1 Apr 2023 02:55:05 +0800
Message-Id: <20230331185505.58726-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cc346bd6-16bb-a38d-d0d8-ec7e928b27e9@kernel.org>
References: <cc346bd6-16bb-a38d-d0d8-ec7e928b27e9@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:3:18::36) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB3999:EE_
X-MS-Office365-Filtering-Correlation-Id: c25a4ab3-6699-4ffc-bff1-08db32197690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bvnth8W+IRi4aphV/NXCZaiTT8d8p8PMg1gZv9Jbu3GLokWZ3bwDnTG+AkYihnUpm8rRFytPNedKBlo8h6+hGMqUzPdQPtVNo9ymR9028nbWpl3t7aL9r6DWipRheWi2HhipIchVmEN97urLgYZOgXA+QX8km+d0m93lzFMhesHx8NegOdiCJsHrSkg15WmicMt/sbygm8dRJUu8yWzT2tIZHWQ8LQ0HnYhAXmbMKyVcH4XtgynxnJO1qGJDmFLJUB4tiVVZr9b8qLt35kOkKrsCDJJ7tUHvN/1ANJOoL49A84JCdO5TyjDbcKNNsuZs3AlRK0Pgu6y5hWyYhQD8swa+5GARW2dIGSRYWTHF/I/74uwJqe5BIuv1V+iAnu6IS7hEU6fCU2fBOPe5GbAfNz4tY3q1fOU62xaqyhpl/6n9c1QmqAP5PjTwP8luaqc8F6I4OzszDWcawjkCzOPhr0goLa0+OvmGHUf0Gqm/yd4C47ZeChj9QOrI2vAUC8daXAghG2zY+QV/Y6/Pb12/o79Tzft6caDgu7bPnX5ZFujtmt80C7icWnzVfHy4a9i0YtTdUEVWcqeiVY4UQUA/V1imrUfQL9wr11acFEqpk8HMpLBwoL9OlMUb8LCSoie0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199021)(38350700002)(83380400001)(4326008)(38100700002)(8676002)(2616005)(36756003)(5660300002)(8936002)(4744005)(316002)(41300700001)(66476007)(86362001)(66946007)(66556008)(6916009)(6486002)(52116002)(6512007)(6666004)(6506007)(2906002)(478600001)(26005)(1076003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vx999xugBGwMgHtvEDgDaqPz4bCJ9x+yF3jiX0oTksyEHD6IsGOjZh5Tz6f8?=
 =?us-ascii?Q?OnFX1+sn0UEekbmpQcamDGC9PHXznERf2YwioLmJ6GUDYDLR07Rky6qsr6k6?=
 =?us-ascii?Q?FEcRyet+90HkF9QJNJ+gV/vrE6CA0XpYLQJ5u6m8nAXymLAxxDVd0vyTReWn?=
 =?us-ascii?Q?W5XrmOzkk+y/SGvH6QlVM7m/Qt0NYE6ATWVU1GOIkXASt+r0bgJ2n4FXqvUm?=
 =?us-ascii?Q?1N623gsz6Kt7I6mFnwaRD3z/FFWs/1gDakFYBnhG/hlkpdQk/xSIykL5Xbz7?=
 =?us-ascii?Q?n1Gdsch6Vlq7RYt+oXWX0Xi3L8z1FUemD30YgZdCpZOdnMAkek8JI9EBsJlD?=
 =?us-ascii?Q?+V7rTxaqRH9k9aywuD0el44vwgSq//tJQIgPbbUgZwqsHbWUsV7frH6WwR7f?=
 =?us-ascii?Q?iWwjEVnxLiEC3wI+Q12IiN6k49KYI5LXe1uJ/ih49bAQdllgyQa2ucZ9FhFc?=
 =?us-ascii?Q?bf4o6p7WgJBDQAWkU04LZRGSss269uzetMRDvOZq1gqa8Kxhm9ycdsGjSLax?=
 =?us-ascii?Q?kuOJuCgADvJSnvcuAKGI4l53kBOp3onh9gAFOIY+MMJcQQt2eG9DJ0Dg64kk?=
 =?us-ascii?Q?f0FHKP/fjpe0TCe/e95djK1gEAABm7dl97hgqLJJb32hnCcrSi46Bw4sUdX1?=
 =?us-ascii?Q?3XaImQuhsaPCt1mhEe8SoRgzRkocEgxLWiipMz5wkPmS44QTe03PVcmEkWZA?=
 =?us-ascii?Q?H5KtV0csLkIISRq/+4sG+h/NPnGlQ+tjIciQGc+K7WcnR+LnLoscm5egGd80?=
 =?us-ascii?Q?Q22kDg2XEs35IzRqytDdk6I3xAFg/6nNTvae3jftSl+oUOLzYB/ICH6uVUMD?=
 =?us-ascii?Q?l7sikLCXTEpdtRN0t/AMlHXJPhbweiMLYbO6QhkQm93JzUY4g7iGu0g9pzDG?=
 =?us-ascii?Q?D2G8JFp+8/xA/NGQNWw0FVz19Hm8q2RULK3w4v+KDwSjBjA6tGRUTb6BEXHW?=
 =?us-ascii?Q?U/L3EgMgX66/EdhLTA7Ys17NjUUc+7vYU0yOOL67aUAT5250Pi+oVLIkF2ya?=
 =?us-ascii?Q?v91guvZydW8E6Pbi4+t4VrhSo1KTJj55axJctW0/Lg5W3xitZ7V09hlGUpQn?=
 =?us-ascii?Q?qmeQChsEnelrMUrlE1B7eKelEh0u0oUKboyP0ZxcEnlzImekMhr1+POTNnnI?=
 =?us-ascii?Q?923iC5pLs4bcRRpjHPmRqj1swRHhLnlRPrWOSmeheb5MiCpoowzqzNL91KIi?=
 =?us-ascii?Q?gIokLW2wwmBuFCBTwel4uJQTXXFVgvGzMLB47eSXpFtVUDZlgU/18I3dVanU?=
 =?us-ascii?Q?5CVkI578jf9vqawv+n77cLpKLIB/sDUjlUsCO2Q3ijs1o5X2fFIdwdxltfdq?=
 =?us-ascii?Q?3EAIC1gG25dhfNbHX2Z9aAgwF8HM4AvUC/Obl67fqYapy+2jtA1fVJyBMFX5?=
 =?us-ascii?Q?0noUPBVzP8pPG5otMCRgjl0RcQG/5I5V0RVq48PB2FBIFH3cryeptFPWPWrU?=
 =?us-ascii?Q?mm3winAeRltdUUrE/XA/ak8nw29GnrjFOrXLwFIcR38IHyN4+mB0WB1p1ZQ9?=
 =?us-ascii?Q?y7qb7j9HX+cPNQ6f0iiwQ0VjGtJ6HjMrDPIdAsWAqrjQIsDHJZ/5HcquOwUg?=
 =?us-ascii?Q?8kSPKRZE1B0qggYZEYRcSNTMuQwipKZIubUvJhrd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c25a4ab3-6699-4ffc-bff1-08db32197690
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 18:55:14.9799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MA8aZzDqaXndydFkxnfQMm9MWA4tFoJOEj9RlS6AiRmZDfjS3gONDpAPslSMhiGHRtURxGO/Bd29Cqly2G6nLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3999
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I guess we can cover all trylock w/ FAULT_LOCK_OP type fault injection,
> rather than just cover f2fs_down_write_trylock().
> 
> Including:
> - inode_trylock
> - down_read_trylock
> - down_write_trylock
> - mutex_trylock
> - sb_start_write_trylock
> - trylock_page
> 
> Bug only excluding f2fs_trylock_op which was covered by FAULT_LOCK_OP?

> What do you think?

Sounds great, the 3th has been sent.

Thx,
Yangtao
