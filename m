Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8A073CBA2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 17:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjFXPrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 11:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjFXPrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 11:47:02 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2124.outbound.protection.outlook.com [40.107.243.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D62BB0;
        Sat, 24 Jun 2023 08:46:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdhTUr92TivpJZ9/piS9IwnJiunMgAW2jlk6semB8KXEhJKOQQKTAVxG0/2g7VU+YkeN/EKRSptpVvShBRcBs3f/x+PyflpMqq1N+CVzh6qlGQY+D3Kk1BuHp2eDdxkgSZO4/Zj+wAmtgc6GYLCN+jmY7EcOcrRovBkYmwle/Hc/e18fTtLtzf1JCMyG1aim8G7D+L2SkMiod534kHnAdbdzhsoPP764I/m1pRt9e0u1BZGy88Mq9NPoEABGAN7Z+gJeiPZU6Cd2F/vbR9fhpudx+EWr/69YhCgbQR4+2gy7yl7EdkecA38UqSd2r1KmDwZFl/AAXgSPxc68kV6fjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8F/tHgI3/AWjCd125+JeIcKSyRkZaV3VRlrm5w/I1CE=;
 b=RUmLHtgckMNs/b1JjcVrciWmmsnN5zkfVJKDfc+5uDugdzjCL4E0qd0ArK6/JPzmfASbX653rahd20N7puFsLT/5yDm0/z5NYQqm787ZotG1vgGa0C5PEZwYA8r38x/JTqGuNbUSiGRaVKmS+Wd1uTEr45G9ZzDqXaWTzd5j11zh5DFXx6emKlwqxDB5HvHmGGImeqAjZCjDvf38jWkPu3HiMcgs8NN9bEQi43qsgKcHSCiwgRbkW8lygUXnfNwpZNSdUmYyuhBCe6NyOss3UgG8O2zLOvlKOXvnJbXyflBMHzZHa4SEQqyxXs0G3jW3yqe8tbQLvaR94S5EZLviFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8F/tHgI3/AWjCd125+JeIcKSyRkZaV3VRlrm5w/I1CE=;
 b=c31CYG5I1sGoIeq6Q1A8MR9JhOGxOiNnBRNJ1Ca5cjXwo72yeM3El7BFZaEWrl5Z+mo6b5UtX9cAT8H53s3Duzztquvh3hZTePfiBt6uCB+rFxrA5hfLr6SFYgYGC+8GxLCjLXMVCNulp8hhkrLurkctutbSqZEUgG41zJusBeg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH0PR13MB4875.namprd13.prod.outlook.com (2603:10b6:510:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sat, 24 Jun
 2023 15:46:54 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Sat, 24 Jun 2023
 15:46:53 +0000
Date:   Sat, 24 Jun 2023 17:46:46 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Veerasenareddy Burru <vburru@marvell.com>, keescook@chromium.org,
        kernel-janitors@vger.kernel.org,
        Abhijit Ayarekar <aayarekar@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/26] octeon_ep: use array_size
Message-ID: <ZJcP5orP0eidH2re@corigine.com>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
 <20230623211457.102544-3-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623211457.102544-3-Julia.Lawall@inria.fr>
X-ClientProxiedBy: AS4P192CA0047.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::19) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH0PR13MB4875:EE_
X-MS-Office365-Filtering-Correlation-Id: c20e0ddd-412a-4002-8c10-08db74ca3b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ojyHAwVLlYsGdneuznbVvgYsGkvcSyE1H5D3nckkOsZC4YrZT3MpUkeUwYz4tm3qEGYD7crjrLDESOFPKLOwI4p4iTqhtvqTl/NgWPdpa7j3ZAEeiGijJpN2Qnxt+6XR8+LBprU6S/L91YGHuqNoZM9FVm5azJcBNoIvT3sPgM2qOFNDKPHfH0FCcaTTVYDAMZ/RfU2OPpKNm9Y+UUHouCDrPfjUvgJFJZdOySWo/Y4pCPmzoDmkM1D1s8chtOORmukWwdFAgZcZgvsbCabM/xpL8HvCzZXZXtLPHkMOG8ypLfH2fFH1TiaXZNHNUvjHckrOGgQ7CYBj6nATTE2mjRRch54C6VBTkHZZL75HRztsgkGL5m22h3hEe7rb1UbzXV7uaxVbFAA2dgdjUgLwSIL3WMueRJqMhoAtcqelGGBdMf7N1IMJM0CC3yW8yHbEhhiMLJy7RfnQgsL4Xx5voaypsdIadVC0QdfWgouWuq6el75iihwstTS7JjYGdHnJTiDqyiWY40LoWc2J/PxdGzwuBh6AIel/pMzmbs/SxRi1uC1LAuY4icFLB9uCw58TUBDAJg0LeAZF1pdS4Xtc9tQ2fpwCXiixDml/vzLn2Ik=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39830400003)(376002)(396003)(346002)(366004)(136003)(451199021)(2906002)(4744005)(186003)(38100700002)(2616005)(6512007)(6506007)(44832011)(5660300002)(41300700001)(66476007)(66556008)(66946007)(8936002)(316002)(7416002)(36756003)(8676002)(6666004)(54906003)(6486002)(86362001)(4326008)(478600001)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZF5Sk+wrKEqrY+1t/FWmJcBK+3lR1WtuhHlFnEPBQxdAQLgiRO12J+psOC1p?=
 =?us-ascii?Q?iVWVskZ3Mc8BBwT0RxGoZlPvq3We/oMEkw4+C3G/TAEMvOIK+uQ+AROf3Q6Z?=
 =?us-ascii?Q?uamxkY/xAEB6qZcxqEML6vOLYlgsX+KYq0i4g2+eO+wwbasv/itJ1GZvPXzy?=
 =?us-ascii?Q?7SlON5AvGVNhoHZ20slyfucTS/OA1DDeYo1GI+gImesuGbdCS//p/ZSJirmf?=
 =?us-ascii?Q?txEc1Aud4rrbcszhLNL9twwI0XC1df9JFackL2iOhcqjGpiUf0G1Wj8Nq9Jv?=
 =?us-ascii?Q?J3U4Dw784jPDREan6R3YRtoZgF/6LMQX/JmusmTF6H8BFtVtG7VimMxPzP6G?=
 =?us-ascii?Q?DpAHiWpKPKKBa2JcrzLWTFK1zGnWqo166akbHWMeDnWzrW5sHDnQ5LVSzW8d?=
 =?us-ascii?Q?d/GaQiojdCazrxmJtFzqIRQeE7HtrbRRoBkjFZGpVBZ9V57AlhlHW7VilO1l?=
 =?us-ascii?Q?oX2DJoQQ0xJQJnMnXst//s7MfBalU0dhT7mg0UvisnnduTgSvgCeBKn1GLdR?=
 =?us-ascii?Q?8MA1jln5iS3UFbA9ggaE3ylG8ZONYTSvkFlgFG4luPbFvHqZDuq5BOrzy4KL?=
 =?us-ascii?Q?mGGm7jWPn1GjJjFor/489Q2gvXpODM2SkQjY6qvQOnR3QGccIbSp9n8VrPjM?=
 =?us-ascii?Q?kLY5fCc9Wozd9Muk/8on8QRkNfV0Wwfua5zk9pXEwTLz3yH/lc9DFxwFCvMz?=
 =?us-ascii?Q?0R6T2a/zq5hq4Kfc4M/hAe3dkmOzVhAys6iNyz1n5KIRcRfuKEV7w4tX3HdD?=
 =?us-ascii?Q?AhQDbRxmdCjrawTkQbh9F8P+mQTI23VOrKHoXT44viY3o5IAX6zMmwzdoNHF?=
 =?us-ascii?Q?QO6IPAl1hEOtHA8q7YwEM20AVcPx5fSdPsSHEH12APRU0Jl/Fb15LlWyquCZ?=
 =?us-ascii?Q?zXrJStEQ3tfa4nmwmowN7OtkWKnlXcQ1G/aNlW9Sr0PjaeLcqvtYY/kFNrbU?=
 =?us-ascii?Q?BRgSLrAEBburlwp9tCWOzPQmop0+O21f1JFEd2YRzhgZv0FWVSpr7IbE4041?=
 =?us-ascii?Q?sXfs79nLHigUSIUvI9GOUkzy5yt/P70sC5JAuYk3hJgnOMeCdq/dX/Sq2K91?=
 =?us-ascii?Q?emaXxuhhF1m5QJMArgFmwvKA3jOgQkMbEc1D9HRGrjCwkMTm+KFFpROxpIx/?=
 =?us-ascii?Q?4yjXxFs9M5XWavu5+P7gRdR7zGApT+efFkwd+SPf2uJyYKSaXMgcrl2tlm9z?=
 =?us-ascii?Q?lsp9bzjOZelvXBGqU8RCP4UCeeLF4LMho+PggmMBmXJcpKkT8UtMvJ5JkGUP?=
 =?us-ascii?Q?cFX4PDvd6+giaA6lhUT9mjoGglj7yfxaExC0bnZVyqZxNb+xgkMKEFhdCYCo?=
 =?us-ascii?Q?XKh2IDVmgxsggMMoWrEcHrpICP/veohnLFbodUlorm5RftnPxIUCqPUHEOAa?=
 =?us-ascii?Q?x3Gp1g8e/jJekntdiYzK6iKm28LdZ5r/soEu40vec0kT+Zlr0FbCcVKTiLnx?=
 =?us-ascii?Q?3AX/lvZ9GgMs9WIcQlMy11G6+f1p0OE9ACb2yxYuz6MKs3Omc1YprQC6PQrD?=
 =?us-ascii?Q?fWQxtjMud1yPGFV1Fw6Qz8J5STLs+9F+PZWpcCzraqXTH5mH9s/oI23fmfdm?=
 =?us-ascii?Q?4k65JADH1uxBB3RQSvQ+tL3rC2XgQ1mW/AzWX/NJDpS4HbhqomC1oS7B+EBx?=
 =?us-ascii?Q?78eI3K2i2XqrDhEdvWbBHnp9uO5O5I8n1hYM51HBa0uu1CoovJSD75mBqBlh?=
 =?us-ascii?Q?fc60WQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c20e0ddd-412a-4002-8c10-08db74ca3b61
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2023 15:46:53.3628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAeKAN3Eq8cgkJ6GBHcnpsAUk+9NlrrSD5t2z632RFBL0pfE6VXlZa5FsmobSj34U2znTNLGIW8H9jRZ40HtBsrOzWco4voPXRe1EiR5wtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB4875
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 11:14:33PM +0200, Julia Lawall wrote:
> Use array_size to protect against multiplication overflows.
> 
> The changes were done using the following Coccinelle semantic patch:
> 
> // <smpl>
> @@
>     expression E1, E2;
>     constant C1, C2;
>     identifier alloc = {vmalloc,vzalloc};
> @@
>     
> (
>       alloc(C1 * C2,...)
> |
>       alloc(
> -           (E1) * (E2)
> +           array_size(E1, E2)
>       ,...)
> )
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

