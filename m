Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08B373CBA8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 17:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjFXPrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 11:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjFXPrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 11:47:46 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2097.outbound.protection.outlook.com [40.107.244.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA5A1FFD;
        Sat, 24 Jun 2023 08:47:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJvhl9gDL3BxcfbaBXSfjh/J1MLRifWSKJstmGQG44SwL3zYDHeyxmxqx3vdZZ/VVzJB/VoBTomTfTMkT2I7vg0UUSBkLp6ylSNUKJC6GQrVuz8WrUQFXTB6SsIzZahTExIvsDjfe902ONU2LbG+kRn/MEZdYAh+GKLyNQBhxWNnBbbtBPp61+pE6K1+te0Jmp9NtXP3OqvWmtG+0SDrRN25qYMRvGGI+EAUgCsg4xKN2roD0uzbLlIGFD0YV4zFHNhuIoDZuhJw3aM6gh1vpP/n2rSn75RY3GUxKZMS8AzYUujilUKZN2vBc9zm5BrgFzwhakUdrxIDT9w+uHcpmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6n0klBR5atJNu01R5L8/8yxUEK1U02ClvfyEPKNbseo=;
 b=dOH6D7q6C3QhIK9S+BS+GspWS8rISfCMD2VZrg3TZlWjNkBPsYb9pFulWi/8/qbuHO6XLDeiolqnMANliiiVzMBlJZBlzgobt/+Z4VO0jfxfjMTU6WxJZSpxVYd3pyraxFt7ISPKN7sZHFuip/YOrw6ShCEm2Ogm1mQHeJ506pmpWq6AyQCC7t9MOc51vRcuxDCU0s6qh4qHWzUX/Sk5uTiAU5EZdZ7ZMbtDoiWx6VQcZP4zYZ4J4nbSwlsct64tm6Q55Sw6E8xe58BzViSPtIBKDUtBGjGHZAPtdZawwxoGOJHVVer7s3GkFWv2bNdWEmi5JF5TxPmz5tKFDt+h/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6n0klBR5atJNu01R5L8/8yxUEK1U02ClvfyEPKNbseo=;
 b=kAgmGO5CA1hVSBlP4eAsLwHPxNBsMYLqKZLJuKSvlTwU+L8nA7j98+FS9mO7RiC9T3wJLYH2cbqXtmeDGpo015uAmKcax25NzkfdxBzal9PANwpYYf7W4GSMLeGACtKKV+9nyJn4kEauyqNfYHfMPu8jI7Q/spLt6V4zAWV30BQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA1PR13MB4895.namprd13.prod.outlook.com (2603:10b6:806:188::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sat, 24 Jun
 2023 15:47:41 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Sat, 24 Jun 2023
 15:47:41 +0000
Date:   Sat, 24 Jun 2023 17:47:34 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Shannon Nelson <shannon.nelson@amd.com>, keescook@chromium.org,
        kernel-janitors@vger.kernel.org,
        Brett Creeley <brett.creeley@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/26] pds_core: use array_size
Message-ID: <ZJcQFu3csAhp4xW2@corigine.com>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
 <20230623211457.102544-10-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623211457.102544-10-Julia.Lawall@inria.fr>
X-ClientProxiedBy: AS4P189CA0010.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::14) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA1PR13MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df86918-b236-4297-9b50-08db74ca57e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u+30hKU4gNFO3oWaSMol+KWPiCNPlzzShoQO9sRRwaG2IHh08PYphb2rb8plltVU0o8f1eXAPJII29V1ipfeEJ3zlOXVUjoe9SumXteMCvPp29ZEjOccreIHQrdLLJgpEgV0/T+Jw6hkWriXyi7wNFkYM4QzEMtPK1+dZIuBI6pmc423DGewL0ofeU88EaWIDOoRYj21SPg5io9TEQe6qWxfTwnJkTTyysSXUwI6lTuiYddzsqlbgX5+4ZUdpyXALxEh3nVjE2KT0/SJhRTmQJ2cYUzOpU/lWD51c907qhBsJDKHfw35IhWTeCf8BrmTG6UhOcpFBkiQPYe+K4kocOaVtO7QyANwciDb9sbhM6vJLZVZzQ0Ax2dLaDNqX2SzasykVPufW7uIYfWfvOMLvaXb7kVgAuCplKS80Nb8nVGaS9lLEoKEQ3bJUmtutDpDbjVOGeh2t8qK5gSsbHn6IYoMlloeOCg/7oQjkSqTsY54tWdgTbLgTZHKWwWPhRL5g0368oHy9dnh6nSDrzEX5OmP8BtS831DejlZxwF1Jte/8ykT94gPmBAnX3DBlALPVdD75XTeEqfUIRE1Kl0w0ICRzJ4nUCiJ1qwX9Za1cIE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39830400003)(136003)(451199021)(36756003)(5660300002)(44832011)(7416002)(41300700001)(316002)(86362001)(66476007)(6916009)(8936002)(8676002)(66556008)(4326008)(38100700002)(66946007)(6486002)(6512007)(6506007)(4744005)(2906002)(186003)(478600001)(54906003)(6666004)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V+D7HrrNXNm05PcSpxfRGFjg4pPKJN+t2z3FXwFXHaVNtiBXLE+zKA5Ma3mL?=
 =?us-ascii?Q?f2QZ/g6e6XQJ8G8NtBpokHFNokwfhDODImbg4JoQo2gfT5erIXwAvk9Ezz+Z?=
 =?us-ascii?Q?fXd4/0J/FZPn4NsizTzeyaU9W5xDUKGqdql7hYpfSlmOyuvYnOO/MPcvW8bG?=
 =?us-ascii?Q?Itbcr3vJfRsD+cliVj0mMbqgv3yHYnQw4ldFFDZ8Z5ImP6duW0LkErpm1jw1?=
 =?us-ascii?Q?D63MfIVdLmvsRqW+k+PfdRcfE+YaUxp2N8eggMq4rqUpAcvcLMlw+PvlNzba?=
 =?us-ascii?Q?3jwpkvGnl1UdsCbxGUAVXCaWG5+PPrn6NOQlNIoPY6z4W6/pgI/bgCNwXkAJ?=
 =?us-ascii?Q?Ys3WLCPhX/cwMD8GGCK6VWFv+lCGDIMmGfGoc+Es3GC06DYiRClB65v/LCQ0?=
 =?us-ascii?Q?94QB33DnUs/JZFiWPuhSV6rg4wo72T8C0XcLd3MSOsTGHFKLj5/fXc5oCg0N?=
 =?us-ascii?Q?4vTf3Y/ShzeSom/I6DcSAaTrQOf17xflTUWZ9tkNWpDg/sG+JBYr0BwLe+WL?=
 =?us-ascii?Q?pupw6kWTKUc9QApSGsLlWnmeHAYNzVex3TB12fj0KSrE+ikmfUp2hxOD9UTG?=
 =?us-ascii?Q?Sa0QUHbPJKgDKBmFAfB/D7olt4MVAlCVpTSI80N9k34PtrilEDAjPzVbReYz?=
 =?us-ascii?Q?gSOHwA75YCv/0dpITc3EHeFiSE8ACD+N4a235Cz7tVBRJN+Et9pCERKoNQNf?=
 =?us-ascii?Q?yN8AGi8W0kpRD5+OyO27x8TDe/mwrcp/UGtDi/I/NznROoiwwIbCgtC2rbIv?=
 =?us-ascii?Q?QN/mJUHN92oH1AWR4GtpZx7Ht2gwo2OSLcRe4ehxL2HWrIZ2x+RY3pVzOWUg?=
 =?us-ascii?Q?WN7k996lQXaOVMJRw5dVZI1IOrbzyjjktJe7etBB79b/gCw6dMxtbqslCIMg?=
 =?us-ascii?Q?cVJkbsrZYY15z8HfHUMLuvvoDU8mhZhB2BhMs2FmlVxvkxTz+qveuwklMqnW?=
 =?us-ascii?Q?ppPhUBkscFfrvMYpHmq8Jqm8YCkan1PDYYmFZV+w1VOl7BuaAeFfDfv5pL2R?=
 =?us-ascii?Q?fyRspgNSr+iHOTLvxnQOlr6X2CiwqaGton7hKUrbqGllTiCCket+xglf7aCR?=
 =?us-ascii?Q?XhUEiqfbJzO1xY6Yct6SttyrEOYw+5ajY3+ozO+oI/s6l1oV/0xM+jqEiXiS?=
 =?us-ascii?Q?o8P2kSZfO7iE3JoqPR7M54SsqE7kvhXDDL0No3RieMB4N0MBDdz7BKcp5OCr?=
 =?us-ascii?Q?n11VP883H+nm5F7AZc0O8fnBjtvPJ+G/7+Dlqz+x24dgT29jmlfMq1SncQcK?=
 =?us-ascii?Q?fc+Cx7yIzmtg/y/0O3y/Tty9NglkIEiJLhc3ls6JPV0c/QdWcmuLht3wZP5a?=
 =?us-ascii?Q?B7+mGFN211SIh0g/9MB3H37/lumcVB2cQPg2zeaaXGrC+5co4IVvJNp+2Ic2?=
 =?us-ascii?Q?LT+cC3eWoOlkze9NSXMsEYAmmreGZF8iwbeSLN53pelNwJMLbmN067QecTGD?=
 =?us-ascii?Q?1cmN+uEcw8n6cPlnsccqIoMvZN5NoPZoBjVqdO6Am97VBzS9TBREIkr7veST?=
 =?us-ascii?Q?Lm8XIUZVl4O3e2rPElM7R4X08oiq4ulUhJl+81Fp/lneoTMRvzo0+Z0ghoL5?=
 =?us-ascii?Q?8WEWhpK4+mn55EPeFRX860KIXFz8Ld9aCHOj+3YxixsHwRBjUwgiJvZlfHJP?=
 =?us-ascii?Q?I6SX9bKpceKQ8JhwqUrdmOG+6V1kjDSZ/gw+wI7ynKRq46NTgR+BWk7cwXUd?=
 =?us-ascii?Q?7bqOJA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df86918-b236-4297-9b50-08db74ca57e4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2023 15:47:41.1276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HAIDAJ23X+JIxkg4dcyYUZ6qaRNDaO2N0S31NgVg6VYdzryEZx5ywmVtrCvXibLzDMkE1DV8l6K1ePH2lNggMs5iJcIkryVqeL+ya8Ajuoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4895
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 11:14:40PM +0200, Julia Lawall wrote:
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

