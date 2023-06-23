Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A988773C0F3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 22:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjFWUp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 16:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjFWUpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 16:45:13 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20726.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::726])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5291E41;
        Fri, 23 Jun 2023 13:44:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8znEKYc0+cw1T7oRCMbVQfE4LjBcH+S0M0rO60ZG0CH1/xcWrivJImqXQFd2GY11jhqeuV2qRLXJW0uo8cLDGmRqJiEzltXqLoG5qPM3ECo3RoWsQD5YZSIgW8tCOfbKk6ZAIUpTzHMLuG2d9gnjLnVD2Yz0SDD10haYkGKzHbYXF9XKA1kmg5riEO5uzP0q84YiIabDPhXqnRBvh0pu783ZFlveI6Px5gNYiDFVgPqR/tSR6JcpoG9sr3WW7WpEHRPr95vwx8GtwhZyiOeH5fEg4tMNf/8WCN/E4i8NCnexHP6j+riE89+Sw3ehFkmxBEd4Tqh6Phm8Y5asmgjsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlUJtFg1gFrJ6yoIuKEu/sjTK6MZjar7frfENvSZOCQ=;
 b=iVAoh1wlRAnhWdlK3qLWPCzQk11MDG+xNufeHH1HZLcYy1VmAVZrAh6O+U29Vecv5QdncRFgFQM7dtBvnt6MJhRnv/GpNAJBGCJP6TUbnnP+XsHZEOzP0hiJitSAIhDpdcWnaa4oLUaG1c3Kl62OIE6UYY6UPdN2en7HYymEw1PtySN3NKYCTXFHumEmuW6tlU6gSrxioI6+/cE6V+txxeIdNY2Stv5ScGAej/kHzRsPt7InihY/4QReXgHV+93YgLofmlIO8Pkz6WfDCdX+fyN13JEQKpT4BzenE/qPoy8EkowzoAy0oMXqOgr1M+WYrHDZB2ZrzkNO/LGScG9Jng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlUJtFg1gFrJ6yoIuKEu/sjTK6MZjar7frfENvSZOCQ=;
 b=CmK6EGDZhU0T9zttgSdnUeBdrN0OM48YO9onWYVT5kJtMaeIPCGhacOvkVe7/rABnY5Dt73hKBfaBlhP+T5LdqAAZB6IVaLdV0TcK8xd26rixT9gkyX7dEqRV6a6Zfh4uixtopzHovAV+l+mue2EC+MHmFR1DUQvA84lbGkTn/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY5PR13MB4487.namprd13.prod.outlook.com (2603:10b6:a03:1d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 20:43:58 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 20:43:58 +0000
Date:   Fri, 23 Jun 2023 22:43:51 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Michael Walle <mwalle@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 07/10] net: phy: add support for C45-over-C22
 transfers
Message-ID: <ZJYEBwks5x3WMqyH@corigine.com>
References: <20230620-feature-c45-over-c22-v2-0-def0ab9ccee2@kernel.org>
 <20230620-feature-c45-over-c22-v2-7-def0ab9ccee2@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620-feature-c45-over-c22-v2-7-def0ab9ccee2@kernel.org>
X-ClientProxiedBy: AS4PR10CA0028.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::13) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY5PR13MB4487:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9c9237-d8ab-41d7-d487-08db742a917e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pK5z8ocZxhqaRGsSYUG7etGXfbmxVmtktFLenZtZ35LuhY0L/OejrqZ83xJTwCQYBNMcPwHFJpG3KE3wd/z2tGYO7ITLUCHjtCZVdlQ6VgS8ZSbsBaK/Q46u/Gtj37fJQVMEB4NKA96NVrijcTv4wyRc4Mud5NoZqvGtbYsBpKTILD5cqikEw7C5D/CManB3Se9/EjPhXOyCUu+fRsfqI6n+AgO6tYS9DN4qaju80ucSEkxnmnagXm412RaB8ayOkeGTpm2bL6rwICY1v10G/Sw7rEp/bXl1VVfLUyfmkg+D6boeWchEDCYuEX2aNd06Ww6mmJARtMdkd9+mBLY+fC4an2gMIwepMOIgU2XXzNm//ilnwjkQUvwnI2ZgHJzqS5IMmwzNW0ihDIrfbADfnG6/DTy2H0YF6uFij/FOwRLObtdYLBA6UQBxVv4IprqyhtqC6wp2KgqpgNXGHeLGWXGI8o6m9a/lyuOw7+t66E59Vv+dxzNLx8J1Err+wf3uyIIx3g66f8BoJXA0Q8Tkw26u8sHTcKNemTfnieojBmc98pQ4vbYKr9KtyCd6wt36fSQs/6Bt3HPBeUuMGR7phwkoD/lg/GbcEs3mdnW2vE4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(39830400003)(396003)(136003)(451199021)(478600001)(186003)(8676002)(8936002)(6512007)(41300700001)(38100700002)(316002)(54906003)(2616005)(66946007)(66556008)(66476007)(4326008)(6916009)(36756003)(6666004)(6506007)(44832011)(5660300002)(6486002)(86362001)(2906002)(4744005)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P1/UBssX10j0XEmpOj7j0qjNaMudvuSCMgULZrzEuK5j4Yjjfz2wlJQNEKv1?=
 =?us-ascii?Q?UjChDK8DlHWIjCIKNZ1NEzxRMhApOBCJKjZrqF99sOEzNLAmYfMyFNHenZU5?=
 =?us-ascii?Q?bl2JF1Rq7GtqDhTiooFX+NxJAs410Ew51zGef54t0qIUZhdpNv9ySXo2WsTr?=
 =?us-ascii?Q?hcsA2Qz4243z/LDVjaLQ6J56DlvYjBM68w6nzjFZYtzk+qwukTIUUIN6rGGr?=
 =?us-ascii?Q?7soG/qzNoOlTPvIIyzCyvrCi38xDWwIANblTjTohHmaBBxUu3Pqe1hwyu9ur?=
 =?us-ascii?Q?ZOGIvLQrBMBXn8fV2iRIxX8xhX5Q0vwrntvXxhjYlej2dtroTkaB0pkBQ1Qu?=
 =?us-ascii?Q?J+wBJdv44b3R8WH5In8/VVnQYWy3FSwGfVMj/eSr8dylyiBIOjl9uzDyaknY?=
 =?us-ascii?Q?nTsJrK7adx8ps3efVPNSwX4tV88bmy7ls9lzrLnt0s2f+2EdQDcK921fG28v?=
 =?us-ascii?Q?Wmt3632UYlJbTpcKpFaQjvicrMejmOttmwQ+gVnB/NfN4cCG5H/jL8lXB4ig?=
 =?us-ascii?Q?rOOOPAGf4TghmkkxZiFBopfD/73ZbH0VBWSF9KuIt6nfha9Smd0+5idjhaRZ?=
 =?us-ascii?Q?pgrNqm50ORvvdmWy0uNj8ar/sbew2xTmAZugJhTTBnqsY9em2eY9/SLjDGog?=
 =?us-ascii?Q?4rpRHZ9otZk0Al1URNYS4kLPTFnDCN4X7rV5RgBjqd23ihUJOd0/ofyM6EMI?=
 =?us-ascii?Q?byG5GOnoaXBxIonwPCM0coyLzB3byOomdn6eORcV/nG88VmnD01TSua+92n9?=
 =?us-ascii?Q?zhwCJwnmj4ResgtiDeHC2A6xwnYau+ZcCmTXB9oobpqERVPIn8ITZKpRSVi2?=
 =?us-ascii?Q?GuVV/qfk4cClNUEGF9EGUeJfjDs5gsRJalmb8CbvQu5BfiYtGbZxr5DYhwMa?=
 =?us-ascii?Q?/vkW6gEfKEPPIXbLfs73QXKGL9LIJqPBgaeAMwytZX6VEqWQyKZJYOiQeIto?=
 =?us-ascii?Q?8IuC1fc9f2N3dXj8KozECMheELs9c6BpfN8YphKldl5fwMvdT+ywYyfHXykC?=
 =?us-ascii?Q?oQdPkPMKsBQ8QrZUi7QeaLjshklZPDWR+xIu6htT+iQJ1BCyhh+FJvEnayfh?=
 =?us-ascii?Q?u6r2Pm5Xbm10D/prhWSBr+IS3u3BcqDsipTsnAFp3xiBnPxNm/GFg9ci4gmG?=
 =?us-ascii?Q?LwHqZ5nvNigTkm91Zua7YcQD3APAVPPnLdr+ESrQrGbs1nwYymMd9Qx3X4Iw?=
 =?us-ascii?Q?fNjDUGvveNL/oTh/3ZQQ+EAzg6vUmP6fbYb3fFD8pmfYLp3ngfnUhBfLWjmf?=
 =?us-ascii?Q?seD1O4Li2EzLy8zPmJg7wBAJS0/A/lQX+mMtAfiqU44u+63QFcUrDY1XYb8g?=
 =?us-ascii?Q?ROzCGFwN1KSEMYMUww1wQRv6sdAUnghRCPyBVQKdgsY1RGqnSYEHkPdq94bc?=
 =?us-ascii?Q?0Jh1tYzDuxfzWWMdG8tn5NEBI6Xrcb1ve+6s8cbSnqTCTyNCKVDFE6OnQ31X?=
 =?us-ascii?Q?DXiNk557hZsQPy1i41Bt3GdGCGceasKIduT9ZR0XZlqKeAC4pN0mL5gG2Jxy?=
 =?us-ascii?Q?1M89UqH/++EgDSpmMYyevObVAHXr04voz77Ams98n6EXmLh4MiGdVo90ECqo?=
 =?us-ascii?Q?2nop8+UAYiezsruXlTED5Dgl6aQ/0G6lVG0sdeQZmP36ZZKQld30i26GpSwW?=
 =?us-ascii?Q?J//8Oeqi2RBTZ4NsjpmYIIkDVGXQGPj6XLLfBLrFd60wajyaUDWGn9gkMNYU?=
 =?us-ascii?Q?YmWDCQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9c9237-d8ab-41d7-d487-08db742a917e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 20:43:58.2556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C97otJmz0J/4pr9mq6JLxUA3GUZOfARWTJqXjtV0Romr8N2s4deTk+tTP08TvTQwoiKc3yX4T/RytueUkldfnob4kAc+8aq8N8+GA5HHLi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB4487
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 12:29:16PM +0200, Michael Walle wrote:

...

> @@ -780,7 +806,8 @@ static int get_phy_c45_devs_in_pkg(struct mii_bus *bus, int addr, int dev_addr,
>   * the "devices in package" is invalid.
>   */
>  static int get_phy_c45_ids(struct mii_bus *bus, int addr,
> -			   struct phy_c45_device_ids *c45_ids)
> +			   struct phy_c45_device_ids *c45_ids,
> +			   bool c45_over_c22)

Hi Michael,

Please consider adding c45_over_c22 to the kernel doc for get_phy_c45_ids,
which appears a few lines above.

...
