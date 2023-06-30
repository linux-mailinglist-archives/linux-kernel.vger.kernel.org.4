Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07B6743D22
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjF3OBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjF3OBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:01:45 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2129.outbound.protection.outlook.com [40.107.244.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FD12118;
        Fri, 30 Jun 2023 07:01:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuLL3BIsKUJynQLsEyKZ/XjxUgbgVqk0TPrFmRN1vTYeSqgEjt7AqwQ6ybQspdF1YnrAOgeVf7gbF415pKzi/9Gdfm9mK7/tlq8ybNMJ07W2p+c9secZyCXjB0O2/LdqrFt9g9oHj/iKa2Z4DoW2S4hyi9n+p/DRvzFmzFutUqW6j7v4uigBbFfktGeh3/4ZqYjg5pVZ8KSpBB07K6VbV1ArmjL3agczwwTnlJgqHiYdDQBemXU24fgc0jyinVGcV2X9KIowPkdQklT171di7jEnR/5+NaPRPgJ2LT0Aitue5NjLz6/WWLzZmqhVbBgFLDgjPfL37S4NxHHtLxf27g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7oo2zyACdV3PYTEnZ/3COfxpp4Uj9w6Hsu/ZmLj+Vo=;
 b=QmBKOg/E9m4pRLVvOMpMMRE5xBdqTSTR7aS4AVbpFkzytiWsElV2m2pxBUZAOOXqn9vHXaTS2H+ZwPXiJQ3/S6a7w8ivVZCVD2N5K8UrWsuSSja76Es9e16USSbb7QZKDhFTf8kFCJ9I+VVXg/IkBo85eiycMZ7cHIS3e0aWHvr9PsS2Oc6rxiGYufvttuETOWCgIB0YWjcE5KDCFdPYMqYbL+LEKaMMx/GI4Maor3TaEPyYHiiph85FgYxXgH8JZQAkgsPW8YJfYAyj6hfVhYek08dTxCwpMlHMa7pedBpLwVikf+36O1SllIKCiqGBbnuN3s215+tx8qITJSKDuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7oo2zyACdV3PYTEnZ/3COfxpp4Uj9w6Hsu/ZmLj+Vo=;
 b=GT7R4vLpBqYggCCTDVAP0HOhdrQuzoyr4jdZCRDsK5fCrzVP7FYGjmsFWz1eIVIJ6gKJSIZxCjbkkxoSH2EuVdxAeRxzsyUrbJvjmcf6Q5TjwLRUhhNDIEkKIbzZRHyUMNh0IfNXxuAA4dmGkG2QJkZsj931dJk21BlwaaEtOqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ0PR13MB5722.namprd13.prod.outlook.com (2603:10b6:a03:409::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 30 Jun
 2023 14:01:42 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 14:01:42 +0000
Date:   Fri, 30 Jun 2023 16:01:35 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     You Kangren <youkangren@vivo.com>
Cc:     Kalle Valo <kvalo@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "open list:RAYLINK/WEBGEAR 802.11 WIRELESS LAN DRIVER" 
        <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v2] wifi: ray_cs: Remove unnecessary conditional
 statements
Message-ID: <ZJ7gP+huIUZteSgv@corigine.com>
References: <20230627024211.18385-1-youkangren@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627024211.18385-1-youkangren@vivo.com>
X-ClientProxiedBy: AS4P192CA0044.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::8) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ0PR13MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: 9828f29f-9632-4c71-b7da-08db79728881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Br3p4PYkQBHyAk7wZOcVHdDUKFmq6riQVSzt4FqUkZZ8u3GHlQSt6e3Mnzj3+ke43NF1O5vAiawoHw9D+wSnXBoS4Wg6dRjcoSK4WDzm4DYSBK+Q6R5vyFfWbQQp0FSPfLVveET7V263GdU9SQNiZDiHfbGUN0NLvk7rVogeguKcqF1ruwpOZ/137/utgjVLAz8z9G/UweoPzTo1Ap21vUyQ9B4VCJSUexYt3+E/eZ9NqIoTXeIOIcDf2uheb9g6YVPXyqKLnLrOtJFTgoSdmbn1qw5AL52DdEHmn9ESVUy+sIO+c4xPNd5bucbkH2Nd963N2gieHNzwtcHuml/uq/NcWEXZ7weCKluLymBIqO82o6Hk8YaCd/5Y/X1E4a0Rl0sV2fqAE1QCtK/djyPDDhTjtAeQGMX7gQQHx79IMdmUZjDrnEHFvjrlQMiMPmtQzAEVEAGUz+8ZY0mVLZDKSaZlEvW2tPpiVBdSjtNgVnoW9bAzH0KRvjfb5ZjlYlBMQJ4adu/P0BEw+I4Uupc7e/9v2WF1fact+rVH5j15uDUeVR39s0kLomlAe/aoCyW+L7yYrLiMVpTvMw6MZSuUu7Uc5itW2XWyYuPJTCgcdpkPBMgGxVJgHXIWN7D3On098ao5sZmTHl+nnAgOsiTZugCzRGHssoUPQVZK06/4Cg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(396003)(39840400004)(451199021)(5660300002)(8676002)(6486002)(8936002)(44832011)(186003)(2616005)(38100700002)(2906002)(478600001)(41300700001)(54906003)(86362001)(36756003)(316002)(6916009)(558084003)(6506007)(66476007)(66556008)(6666004)(6512007)(66946007)(4326008)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W0qLP50+vGCHLIYizCXkKdgk952dgqXV+KtJbNPn2Wa7VuWG+1A3ATdbNzUM?=
 =?us-ascii?Q?EmQLIrXQmPVC6R55Fh9Omtsargby/rzldJ6UyqrOzEkuyIFdlzq4MDCciG1F?=
 =?us-ascii?Q?npS0YHFnIziafkVoOeVbC9xV5Wzk4ybq5yFmEQoAOIEGv1lfYcivhXI37skI?=
 =?us-ascii?Q?CnVmlIKcDSf9OuQ7Rq6rRoTVg8/JayH1uVZCrjzw3HRXdQz2xmkuF03MYibR?=
 =?us-ascii?Q?NdD93VF8O0l3lurhb+/VH1qgRz9eMH5RKFympQVf234+ArLRG/Imlt7C/gO/?=
 =?us-ascii?Q?sLYJ96wxt5jMze41SXemIl8lasLVoSYiBi8UqWvfiTy/Pc/oRIKySAUltmH4?=
 =?us-ascii?Q?JavPbx6VyvmksJaWLqPDoUUzcEJbwAKlAqJt8XhjOp11QEGDtfQLnrE/a2TS?=
 =?us-ascii?Q?4cGwQu6SCf5hXU8uC6H7zqKgs+3T1NLObEbkcUjGprzxEflsHS2Px5orEMBs?=
 =?us-ascii?Q?ebmZhKLVsC0RRRIv/rpJOZ656wZ+4t2DAcP1wd2Vv5EGNmJLMoMjV5qA7Gnz?=
 =?us-ascii?Q?uCobXViXx8Px+TwmRXRg+zbuthybLEl1dODZZzWlDHyjeHQygRxqgzA9BOuM?=
 =?us-ascii?Q?gr/TUpWeGatEdF6Hkf0U7jHT2uwepB2hJfPZ/Yw0bWU2abrx7oi9Vh/2i2tg?=
 =?us-ascii?Q?ViYxeZC0ahIgfs/dtz/8ituTc+tY4nSYnvR8aX1+oPZDZKvijclCL7b6QRvF?=
 =?us-ascii?Q?6D6je5B//NwxOMUARoF+qVB0nkbmMIcKvp8tfPp89plN3RzVZpGeQEO6m3Yh?=
 =?us-ascii?Q?he8sfQGXngMRsE/m2fA3VFmw28EN3sqCvWWpEXLixUQDpMqUVmJkGOE0KQDa?=
 =?us-ascii?Q?IOv7looaslfB9eV5L1t0e+M0XPo1/DP23keO0QyGvAwQ8ybepIDYM5CxhF9s?=
 =?us-ascii?Q?xwlJSc617sqO/Tly8FUdXJEDRs60Gc62N6ZfoZsSrKnfk6SCGYgbDfy+Zl7q?=
 =?us-ascii?Q?DA4wXuYFXp1/Tw/q59AzqOJM00uLHt3sqWicH9XdCu+m+y+6dOcpYr4QMhdn?=
 =?us-ascii?Q?BRwDStbeIsyWw4zU7/z4WHNVOHfdE4LXswgL2FXP2rxAkiVhN0wAk6FzUIaf?=
 =?us-ascii?Q?Xb3wI69J4FkdCgk6JXhmGdcxm86uNefQvlQ/zXzhs6aKUB5QazciYQ1uQ/eV?=
 =?us-ascii?Q?qW/98cI+iVAp5KBnCCYA1HLRVECYGytxcTyKwZeoGvAHQ8PtdrHgwWODnFjz?=
 =?us-ascii?Q?3kvW40xf0PnE3z7WZYjU7x+RnapJ+4eboQ6Zrbi+gE5xfYJh3Rgs2nI5sUgj?=
 =?us-ascii?Q?J9WuA6QuqFDHGl22dLnScBUz09SxQekzgSVscS3ALmhzTVdQFzTFrdc91hN+?=
 =?us-ascii?Q?c8BNOdLZTPyt+P4IWQZrzBb02wzPjILlmeUHki/FUYnDBbWpISLWOoR7VKlB?=
 =?us-ascii?Q?BDhA9X6Mn2GE0PPOBR57TdW6qZcDt/9Rmar7Ww0X2cBH07Bb1/2Ijl19MEaH?=
 =?us-ascii?Q?Ggg8/Yt6c5buAwoi7YsFpMvnnD7oEyf5iie4mhcDOZK1LBh3xKK0s/jN3wCN?=
 =?us-ascii?Q?XJGpBH5WDwAVFui6uoRhIfUt6vwHkuQtoQgdTFNkCaw7eTD23W8P5P6z3zN7?=
 =?us-ascii?Q?9U+u4PjzeB34LnZQsXyaAXYaDrHuitueLAQ38x3JD0WEXCymsLan2d2dVFbj?=
 =?us-ascii?Q?vdUF3H1eqwEyf0ucM+deAsJ9xI0+P2lPpwz5K9IBxdbHcnz7ihW8kDo4C3eS?=
 =?us-ascii?Q?beEX7Q=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9828f29f-9632-4c71-b7da-08db79728881
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 14:01:42.7776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IiQXgCCLWmRYIa+NSxQGnZ0ywE4FA8K1B53MEJrUlC5TBdwurs4WcTzsLr7Fzc4iBV7+bmJUb1WaWePB75z0ua4S0Iudm0qtFzmYdPzkTA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5722
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 10:42:07AM +0800, You Kangren wrote:
> Remove unnecessary conditional statements to simplify the code
> 
> Signed-off-by: You Kangren <youkangren@vivo.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

