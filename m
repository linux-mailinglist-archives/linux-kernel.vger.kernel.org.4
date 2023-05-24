Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E99F70F41C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjEXKZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjEXKY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:24:57 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2138.outbound.protection.outlook.com [40.107.102.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84AF8F;
        Wed, 24 May 2023 03:24:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFGRppCG1fZhKYBmNmSBM2KcNLE4/F/KN/UP5lvuQkykYTgdBr8f3PrAIA/7EXZQOZu8/2I/V5cQMBXRaxcZvZIMZuTfDCUek8IkmYOCXutFJfkwdoG2hW9v0jx9n0vFnl78Bu0vR1lzv9TibFmc1BlYn4vZdYR6MvNKJkoKW8GQt2yWkr4JPeGPCfT9m9JIjNC0N5M5UIS+EStz/5FYv4xTbFdoIGi5RVzUL7Gr48BYskcrzwyhy5oFCOe77JLu510LcO907Z/Hr8H/ewy5+wKw5vMidxCxWlU9NMLhgBcRHnhebliT7GPa8WP+TTOJlPvibhmwBkz9HOp2w+RyqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsadmGohoANc/Hsnh9NSnUGuUe95pbGgFKMSFIA4KQQ=;
 b=jlpp7yUFtQ7LACS2vV8qI1zB914JdATyGUyCWds5U1oclMsqo7HnPWe2wq/O5pkbeAMKvuDG+0zmMPMeCisi/D63JcW87r0VRwEgR1FlSPikz92jrz90yNQXf8z/BcepuZkIEZNmp49JEwQg78t/UsrBmG787+K9mfm7PIsvUpunsU2KL8J52/aM/1JvcJelKEc+N/lbvUIbPC+Qcs4X3LQA6+AeH32tQQxsW0cDpNFWVP6nvh+kt49Kv20CUq5j+n+VW6aCDN27ZpFJ7hoQRQWFdZyrtca0RKn/0t4uszu66aPIJ20rySld1cjK2060vlYzxUpU08ZX4evLtYB4bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsadmGohoANc/Hsnh9NSnUGuUe95pbGgFKMSFIA4KQQ=;
 b=fvqdCGr77959Ecqi7MVe7wzJ2C3ILEkdWSndtai6An5FyO69fbYwYmTPIEHBoq6I4EN+J1mRBISQloZQi1mMaaPp2ne/GqY1jhAtHH1nc3PxuhdS8/sdOLVCdE0gjrgA5YCyhGEPN1fagLoG7QIhlUeMoXA0FWrAJFX1uwuEqvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY5PR13MB3795.namprd13.prod.outlook.com (2603:10b6:a03:21a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 10:24:52 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34%5]) with mapi id 15.20.6411.029; Wed, 24 May 2023
 10:24:52 +0000
Date:   Wed, 24 May 2023 12:24:45 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless] orinoco: Fix an error handling path in
 spectrum_cs_probe()
Message-ID: <ZG3l7Uq6wW7NyfGZ@corigine.com>
References: <c0bc0c21c58ca477fc5521607615bafbf2aef8eb.1684567733.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0bc0c21c58ca477fc5521607615bafbf2aef8eb.1684567733.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: AM0PR06CA0105.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::46) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY5PR13MB3795:EE_
X-MS-Office365-Filtering-Correlation-Id: 456edb63-5590-4c79-084d-08db5c411c4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wpRlM9IObYjs8KcFQRqihYQSYTNxEzUd8TojYl6ENTZpXJAAyPD5YYwwfkWFnLV5L1UWDzjjvFdKy9tTC/1mhE9/Z7mH3glLed8pKL7dQj/9YROugeD7m3dAyawvbr+iuuzUd5OEpntn8zQuuqNhLCeEA8nn3bMdoHFR2PIaIVQ5kLN1a2QbKMfJ1sjcKff/PoFSjT+XwR0WwBB8rL6nco9CG0w29xI6dRatN1fTXLVBdjbfap06K69Cvvduwiwzh939aP8aFAs+pvkovKmo1OHFETfnePo4xwJopz79P0Zq/Y8JBtG2bvoRFqWL8bBmBFLUG4ZbCGCehHbXCRV9hdb8Z+rtOHyOhXQZPderzy+DLKUOQFI+DTJZJzU2TrSKNJsnFRGxDt3XsO06/iE7ZBd2UPuv+U7PWUEXrT1go+XIsrrttMNmqkTEVPi+aSfE/9lgF5XbAn89euyh1FlY3Axr2nfBsvrb7H5ma9PX0UZY8AvALaKNxVmYQuBUpYIGHpMno9zIyFAnror53qBUJ/1OQG9DaKGEHAqLiNerWywlKZSulQdTGvnikpJRhCWYmZ5HtKHXrDiTkj2oKoiR2JazKKRlsqkMf0wI+79V5LQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39830400003)(376002)(366004)(346002)(136003)(396003)(451199021)(66476007)(66556008)(54906003)(66946007)(6666004)(6512007)(6506007)(316002)(6916009)(4326008)(6486002)(41300700001)(478600001)(8936002)(8676002)(5660300002)(2616005)(86362001)(36756003)(2906002)(4744005)(44832011)(38100700002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l564fnBBW5jNC5DAE5tAGelm+gWrHiOkT7ryfb/D2WgKfks9KwOaG3lYxYRJ?=
 =?us-ascii?Q?SfR9iuztsM0BBIsC8U93NLu0AfN9Hph1bkmTxYUoIMABd0kza42jdlFhUBRK?=
 =?us-ascii?Q?qRyWrCrG71eojYD5YPPVd0KV+ptZtyw3giobPzF2A+LBBefJIDAvt2MGl7A5?=
 =?us-ascii?Q?e/MN9PVWb16yeiCDaTq+L9g+apy/aoM8SOem9xXyKYA//O4F/CofXiPypqiD?=
 =?us-ascii?Q?ijJVeMvVQQ6RCqYXyKD93yp62uA/1FoG1EsRJmOkXPdZyDHurxxNKIJ6MrWM?=
 =?us-ascii?Q?KJLlP1uvhgHkgCUGEybi5edg2Csn1QCu4kSG7DNSXLtofNdUFYpdTrOqHJ+v?=
 =?us-ascii?Q?XqQaINF2NTNfL0QakltWU6OzUhP4j+X4iXQX5pt69DNGB+0xDy4iO2J2INwF?=
 =?us-ascii?Q?hs9ggegOnNUAC9Dkq1LE1E31C1VotCKIS/hnQq0/oCc7wQR80sM+JI2erJBQ?=
 =?us-ascii?Q?/e4MhGeIg883po1a2mf+RLGOSqWXWfxJjpeNDCRGcc/2WyKZFE7BDa7fVKgd?=
 =?us-ascii?Q?a12BcsDCrpXMfZjajZnvyXuh93xt9Z2kiPjZi9o5sYh1JZ3dO8o/mGRN08eF?=
 =?us-ascii?Q?mdO94dSsRMGUU4VG/QuMs2A+0ljZQoWSCXDIOHNcrY6LEyw03oVukQyF4Abc?=
 =?us-ascii?Q?gR9DJJD2s37yGHCIe2Y84rTwmLdq/iDhs9Z3bMovmrQNcAexPuKv/AQRTWn/?=
 =?us-ascii?Q?Qs9+Q5wDl2jaXJlTUQh6pP9H/sC9gF4p1QWk6apnW3r+Kt3XFW6UySq4n87J?=
 =?us-ascii?Q?m4aDSsB6Sh9Yjx4pv2LI1E18m9FzKPWAh1LXM6zYK8f8yDQGAfqnXbpdRQkf?=
 =?us-ascii?Q?20INJRYM3yd8rAVYVx9g+WRFdrMFxssL1WKEi2dNv8OPhD34bbqRY/uKt1yy?=
 =?us-ascii?Q?iJPrHMDfD0r64yPvhjMoo4o3//xADRak6yGBig6DK7UfuDfDHCMKJYJZAho+?=
 =?us-ascii?Q?nbiH0VU3ND2IxIYWA3OKvTZ3SsJp/0+jwDsg9W7J72TPfKjngC3iiplJ8VDA?=
 =?us-ascii?Q?dOCEatbMkEBlJRi66F17qK4vFPRuTtuErmY73gPgG0sF31++Ln4zVAqfd+yI?=
 =?us-ascii?Q?Nupl4FRyF4gaatQwpFWByqn8KniexqU+kyUgCoDjg0RI95RuZ/r/ZIUZ7Fef?=
 =?us-ascii?Q?mjV75600dX9skWAN3ZswqQaqvR/uzv9+7RzWyxG8TvFuMuo/KCwGY7TEe+Q0?=
 =?us-ascii?Q?hOigtYsVjSDXIORJpSt2uK/XCZOwlZy8oQXVAniGa6BpTJQnJG4TR+cYJOcy?=
 =?us-ascii?Q?zLrlTNHbpQd6vFXWOnbrGGjvRawfmzLT+UMX+mb05aB8G7nQOdPgcXZzxFLB?=
 =?us-ascii?Q?AFiz/e3pC6LNx3D+4haMUxU/DjFkJj7LMEUrCBYEz9kSQnuv4bExicEXnT/J?=
 =?us-ascii?Q?CUkBJ2OgIYk/UUnq11YNy3eRVlQ8lGnSU6kThI1rdGIbpv5YRy6zyKZtO9eO?=
 =?us-ascii?Q?vTxR0QF2T3cbnU/rKo37Q1O9SyboeTjIXLW9R6ri0BjBEsDqABTicqBjhQmQ?=
 =?us-ascii?Q?4prChNvzBJv7G0N+6UWTKRQYQdtB7/rRiEYcGFf41UHHPPFSCheqIKbCrSPo?=
 =?us-ascii?Q?r1cTJbTOUtvqBZUnX7brxaX+ureNmy5VXxwcbkUryr50nQAWxK8laCFOyho6?=
 =?us-ascii?Q?lNgp5lxSC8FSHRHvYEAUnvDbNSs/AOP6m5ybFy9g+Wm0SSzaGydj5IstLPLz?=
 =?us-ascii?Q?fH/Nzg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456edb63-5590-4c79-084d-08db5c411c4a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 10:24:52.1796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAtC9+y0a5gN+eqU8SUzdauPA1dLiruKkIk38nMlf1ic3DXgjtFw4ifwEnB5LfrtTRR0eXfwZ2CV65rNQYYrnt9gzYtBhYkNjI0x+S+wE3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3795
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2023 at 09:29:46AM +0200, Christophe JAILLET wrote:
> Should spectrum_cs_config() fail, some resources need to be released as
> already done in the remove function.
> 
> While at it, remove a useless and erroneous comment. The probe is
> spectrum_cs_probe(), not spectrum_cs_attach().
> 
> Fixes: 15b99ac17295 ("[PATCH] pcmcia: add return value to _config() functions")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

