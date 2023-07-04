Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B287473EF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjGDOTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjGDOTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:19:07 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2096.outbound.protection.outlook.com [40.107.94.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B58E70;
        Tue,  4 Jul 2023 07:19:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X35DW4tq8r8uJDi4Jhtq6oBnsS64Y6IsUtVuVFmQeExG2MixiFBeiGO+dUDVSwlZABp6MThjaLJgg5rdD0iEKG6BQu5XJr7y+G8Xq1j2tpPLPNtgMdgnoQ+kPkj0OriWP5aROJH+3sWxu8YwFjzB0L3jd1f9Q7mhRqv1vzKL+6gEpVp2EQUW4XEeWNRfBHbYUDYQXvCNzPNVCIA4RloPO2nciC1tr5ozb9cGi4aSSM5Nm1Yvq9KNu9GT0gg5JtiFv6iuR+FyGgp29uKqcQnYqQalbFWtZO1boy4MvQ27KrtGMFSqttZICzliJcTq3nn+w/hjNL1tHFz/ZDvgtCYjRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQDKvPrg30XHYCV+fzesXmCvbg5JPrIjkVOOcVHoxPg=;
 b=R7GXfva1RjnpovvQEgTEzXZ+x+8okXC727q20hxRW0YBEfRjIW+PjysvmqbONWM8rVzCvw3jSjd1DASqeTTUsNpnUAHZ21+6buZM8bkzoz0tFZAS6aW/ELMNGz863kc5CaUrdJAaPs/PwKGl5LhLLKkEYKMdQw+4FhG/eG66elDgObZ84ltnaPsI0BHPWv5aonxPBTE/l+Q5prj6P4KGSrWK6GHof+kbc+oqOKe+iuoraK/C+XJe0MYvdki9bm/nOChW6bx79+yRGXC8Ws0v/wojYclP2H8iKqmaj6vF4TYFDT4TOpBex9GDXb0VU8HQg8iIrh9ALoNchDHVrVRrcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQDKvPrg30XHYCV+fzesXmCvbg5JPrIjkVOOcVHoxPg=;
 b=dX1CxThrr03C4ts3+EYEOl1M1sy6EjUQAibY1RP/al5li0iNsXWZObao3mj7eTzPNg4PRi/x7WO0NSHN3GqabUIjH0Or345WC2GoyCZ+sy8rtnOcYwwLvyZVEBQv3koxhzKO61Xxu1bQBmwE+skHVWGAkCOSDTAYWJdhm6jqTpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY3PR13MB4899.namprd13.prod.outlook.com (2603:10b6:a03:36d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Tue, 4 Jul
 2023 14:19:01 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 14:19:01 +0000
Date:   Tue, 4 Jul 2023 15:18:54 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Hariprasad Kelam <hkelam@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        davem@davemloft.net, sgoutham@marvell.com, lcherian@marvell.com,
        gakula@marvell.com, jerinj@marvell.com, sbhatta@marvell.com,
        richardcochran@gmail.com
Subject: Re: [net Patch v2] octeontx-af: fix hardware timestamp configuration
Message-ID: <ZKQqThyk9LXcX9XI@corigine.com>
References: <20230704042653.11303-1-hkelam@marvell.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704042653.11303-1-hkelam@marvell.com>
X-ClientProxiedBy: LO4P123CA0592.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::9) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY3PR13MB4899:EE_
X-MS-Office365-Filtering-Correlation-Id: a8dafa89-ba76-42b3-1e87-08db7c999d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KnfnsVFxGQZcAELcmcFx9OweBShxlGwPfT8kFnSD0PrCAaxD4T33c2a+CQQ7snrkKczoBG38nBpqCO4GYxZff/KXXr65vOe6ObRBkhQakCGLaKAOf2utE+l8lbpXCTYwzVDH8JDuJ81aBfw0votHb6tthAgxUwfQ7XCyxgY2XrKkpCm1ooV8b/OAt4kaG2i27rVij5ujwBhj8VpK0WNDBzFjMHSC0ngYtiFLZQpq1jHa1SExNumyxgewYsy8smlAzMfU8wjPqik8Yw0141Yt4FyvNI5fjowrTBgzJGMhs1mKhhGnvyehJYhzXgIzW1sL8Gp6XSW9IvfLhdMROBSL2DMD5WSZUdl/H3xlsnYeF9DykL55j9l0GKToXTwknbS/kF61rUVDVEbg7MBCMiZw+YHVs9gDvq+iqhbHGxpyZWFYmM7PW1VgoYsNlf7zhCPmnOC9DlmPHBnp/WKgzAQcpOnJsASMX6DWBGk9GQnb5DX6V7BUFk6FIzBslkXyxM73CntJlf/mRjbmbVvfCbVt0cz7KMXoj+Y/WEfgvdtpLE8JSBBR1jU+BIbGfuji3TF4Dguj+b+Mpb9vMj0OrAlRqOqiIcDpkbuQ4aDWUVgBMCQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39830400003)(136003)(396003)(346002)(366004)(451199021)(6666004)(6512007)(6486002)(478600001)(83380400001)(2616005)(36756003)(86362001)(2906002)(4744005)(26005)(186003)(6506007)(38100700002)(66946007)(66556008)(66476007)(44832011)(6916009)(4326008)(316002)(5660300002)(41300700001)(8936002)(8676002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QTwXF+ywCBdYgv22Qekhc4fLbkh1u+YkLl0NrqSsWcOa5GaVrP/yQyMExIGI?=
 =?us-ascii?Q?FLOK5w1HpA2iByXLJThXOVf1W+lnZgx4aAU+5pEm/B5NXq1JYq5dj+B6hqEt?=
 =?us-ascii?Q?paRzDtWpuWDG+OtEM7IBmh7qCeR+lHcuo6G5aE7E0VBDp9TZbOH/w4NFkJmt?=
 =?us-ascii?Q?lVEZVLWwkIl6gh4fWGCftvwCoklGuhv+vr12JnCQcknOD0EpGHKfTgNR0cRR?=
 =?us-ascii?Q?c1jymSMSypwOqbfI7hcN6jfN7JaQshE2n0O8kejw8si7mI9iB4vBIS7jIEU4?=
 =?us-ascii?Q?VMVNTAKn0mS2ZQBUda3fAS5B45nQufZ0d4gsjTjWzSCbCuMCBL6omdKGG+tn?=
 =?us-ascii?Q?O9ATMiLNMI34xfqil4AwDx6yo+n8ivvl6oEe17IywIYhjwyFbGzY3cP9HcLV?=
 =?us-ascii?Q?/3TM8DW3Mrvi6rNJf1Q7ZbTPgmDZofkFlZ6lQhh3cFdeYftJ17XzR5JnRS0d?=
 =?us-ascii?Q?zBnzqQQUEwWQuoEsmMSX8u9vT/TEy/pMwq+JvRxv6CgM4k4K51anLeumBPpz?=
 =?us-ascii?Q?TTh0a9iNf5i3oWPwy7nJy3ApVoR7kL8OrYaqyfcEiMel5uBC8EdETKwiSPHb?=
 =?us-ascii?Q?mbizsBqQTipmqxYNj/prahf16AtQBqLo+vpLnYO1jt27orotCvC7jAYJu8xW?=
 =?us-ascii?Q?EJ8AWzZ9xH5PCAOhGEq6lpfH9DjkaaOvofkxgRTF+u35ww5R8dz5OPHgRXOE?=
 =?us-ascii?Q?vJwBNuhmEeYxUA9fj+Zg6JsdlqLlh/014rXjN4VQEzQ1idMCMXz7Qkni4j9Q?=
 =?us-ascii?Q?EhYkzyghJVqPelT6CuqExoWsS0Uil1RyslyN7sql6EqePMY6P68YSgeYVVXI?=
 =?us-ascii?Q?cF9kGD7SGvRyu1367MZ2iGm8HWbyEVnylC4vrcfnKKb1KPlDIDKnGDH+mRMI?=
 =?us-ascii?Q?AkLfmk87WCLrPisL1ltv7wzfk6YwfTcLMHrZO8ksDYNUIq23UznLnppLUoWB?=
 =?us-ascii?Q?HMYsoSSNeTSv8k/z+qqw3oSmmV52G6rZ6IZf22FEzjHvAmWYAN7MHDqY+eIS?=
 =?us-ascii?Q?fEBuYR0R3c6lbc1zT1+rSmuBtUjQAfXQMhyQFhQX1nb0UnfC97vHf9FQzcC2?=
 =?us-ascii?Q?5+hHaB2uuv+TX4wjLj0KWisD/pnCKqEr9TSbwETSTqNewqb6XqwJLQAB1xK3?=
 =?us-ascii?Q?vJ8IGh3GIvA44vavSPJDzLnXqauHVxk9d+q+7uAwDd+su8+uHJc4r+8H8mrX?=
 =?us-ascii?Q?kAPdsfvVfmO4ZR6lb3wOca0cwqDcfUUoB0BgEz0LtLu9r6xGA159x8apbgiQ?=
 =?us-ascii?Q?g6aY1qZRjUyPI4zUoihvvj7vvaNRgZT6QEb0OFg2A0Ah5wgUqgdvKyxGN3bI?=
 =?us-ascii?Q?x5ymXJ6s1vkGa7LtXRk+RLXb7UvPASirrIheu/SGMMizQLmDJnym4o6+XXWD?=
 =?us-ascii?Q?TaBsGOTsfEA38C64nqwa7Qps3ozKvEGB+rXF7aki1qQ1LU2UGSEGXHHkYtav?=
 =?us-ascii?Q?55LQ0tdJzw8H1eeRHatE4FV5ppJQj55R+Pe+Sf1PM/KYH7aNHY1S/oV/zp5s?=
 =?us-ascii?Q?RAZ52yRyXYwXV1R5JqwwHbfMmpCQg4ZAPwYJZEoWoAN9bEGuve6fMkOS3kfC?=
 =?us-ascii?Q?jnoFczB0nxFby6mEbVHuO80I+DxY+RGqIMq+bWCSgcnA1fZyRlzIsvYOf/Eg?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8dafa89-ba76-42b3-1e87-08db7c999d78
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 14:19:01.8261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQEQfOfNf7RftlukbhBZeT5qLppTmm+3IYoVwYreRsr6ywY3RkB7soSN29NINBud6ybQBY5/23CfsVcHSjHdmoJhcM0tgFvFgy/lQG9CDiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4899
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 09:56:53AM +0530, Hariprasad Kelam wrote:
> MAC block on CN10K (RPM) supports hardware timestamp configuration. The
> previous patch which added timestamp configuration support has a bug.
> Though the netdev driver requests to disable timestamp configuration,
> the driver is always enabling it.
> 
> This patch fixes the same.
> 
> Fixes: d1489208681d ("octeontx2-af: cn10k: RPM hardware timestamp configuration")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> ---
> v2 * tag the patch to correct tree

Reviewed-by: Simon Horman <simon.horman@corigine.com>

