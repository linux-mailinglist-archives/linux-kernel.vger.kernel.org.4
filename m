Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0B26F05EB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243688AbjD0MhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243700AbjD0MhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:37:04 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2131.outbound.protection.outlook.com [40.107.10.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478B33AAA;
        Thu, 27 Apr 2023 05:36:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0vcYU6apWe1aXPmn7OllqEaOf9yyl+kwLoOBHCNzX3zul6xD9/7SMk5lJ9oB6Cps+rZheIoliQcU1rXfA4GHp8enYm8pDzds8anrdAXkRnYno62f9vgL8zlQJTv/TGlY81jWerQgiHBS7nKbtea4WpCNKYT9UpyE6BPY0vzcC9JyMWH/EwFWN0ZJBybFilUoZJQ47egY6m/yVvpMWVCqo4y4leWTjtaZMc3z21320/olRBc8a6Y56yS6jGfgPmPsWlHGwu3v84jAlaXX8V+WqUu6KHIooWubpKvFCgPMaJcLkjOZm8NqchxzsfeRtWjHgpMdLMmuz2vemKli5RX7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuIjHLXXpE65b0UjVzXEiocMBOYurbj7I+C2lfmujt0=;
 b=gL0Uxifz2pXRy2uq1+d5+/KdVMEWGUIylDV3OINYsoq2wPp4T65BnFFaHeKUiKHc3vHr8T4LA1gk/v6m5DF1SlSjN036XJejH1tKykrsFB0nL7L4nK+egZxeXST50EMO7Ah3QohGZU+qG3XOylibX+Uo9fcAv0/ffkzzjE9j8qC3gIal1p59Jcm1R7tKnP446SbK1qqDWeY1UdzkuTGEfJMVR4I2gMKbUPCNu+YWmzV5D8Mrt6ZTqEgQfrYZUhhIqVyTHyODUlDMaoT96pZ2ZpYZ9Mw1/zA1G9mtwZji8cTtMycnw7eTz4HxWAgKFYOSXinGMUhl2eXqTILQrKue7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuIjHLXXpE65b0UjVzXEiocMBOYurbj7I+C2lfmujt0=;
 b=Hu4ys5pjf0J9wIZ1VZl6t2+kL9xz2caLT7iRX1mZDq3Q5mkTISqjw+C/FaPRpDElRV7C4ZtGJath3rxjQ1UN2h6A5PwJNggtFDsUivTxS6tKAh3Ulo1s3QvBrg8Laew1X767JBDxwRpfbkKjyIa+DIYVpz6xrs+ETUJZv1WcVPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LOYP265MB2221.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:122::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.9; Thu, 27 Apr
 2023 12:36:52 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf%4]) with mapi id 15.20.6363.009; Thu, 27 Apr 2023
 12:36:51 +0000
Date:   Thu, 27 Apr 2023 13:36:48 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Ariel Miculas <amiculas@cisco.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
        benno.lossin@proton.me
Subject: Re: [PATCH v3] rust: helpers: sort includes alphabetically in
 rust/helpers.c
Message-ID: <20230427133648.01c7bc13.gary@garyguo.net>
In-Reply-To: <20230426204923.16195-1-amiculas@cisco.com>
References: <CANiq72nm-tWGPHMaNF11baVRDFpk8ruvTAVDEWKfraEzADWqQQ@mail.gmail.com>
        <20230426204923.16195-1-amiculas@cisco.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0253.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::25) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LOYP265MB2221:EE_
X-MS-Office365-Filtering-Correlation-Id: c5747221-6445-4b79-79de-08db471c13a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kV50jM16oCDR/KDa1oFz/MmkSguueheWl8IAD8FOQS+UEJwuDK/r/JuNVLXAzcFIRIAAf3r3+Jl+dFDrv/uFwGRC3WF/l3yehzH+GILQ8jbZSg9ags3gPVGPJACNYvqH1VW6KFyksNpgO2EWFVUeNT0DmH5uFkg/GAHPQhNQVB+H7wQCCpY/sBy3wLfUu+U1/+zgRMN2/ROlWL2ZtWoe88hIpetc7GpsWpufog8AvByAVmDTVV3PQoO9QegEkk0cPh+3AksCGs7Y3wlTuIslx2OCbBU9cDCSAEyRr/UDO3INSujZHFhQqfGROamHsemlzUxGqbQDBxZmG6mbjfJqrgtpBDctVse3sUlC+6ZRZDIJrbjz22qK/MR4kdL0Xbm0Z4ETCPcDL8cziK2K+9y30s5RLcoN0d4BrusEH0J0pxBFkLbAKjDnBdAsm0LdDUm1zdMmZhvEf8xUIVeJ6erugsKcw3AIGzbEfs6rR4a6k+EQxaov1L/5ui6oEtd4K8f9dfu5UaxT/+g4eGjJ9TslmehiCuuOG1vQ6ng7GgjR6Q0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(39830400003)(366004)(136003)(346002)(376002)(451199021)(86362001)(41300700001)(26005)(1076003)(6512007)(6506007)(2906002)(966005)(5660300002)(8676002)(8936002)(36756003)(478600001)(83380400001)(38100700002)(186003)(6486002)(6666004)(66556008)(66476007)(4326008)(6916009)(316002)(66946007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NLVLm0DF3PwXb3mpLe/rRrW5iXye5M7i0LHSR3XoHUhMtcQp9QXO9qZgNmyx?=
 =?us-ascii?Q?lQ4jwrDMNn4YV5jHFH7anlzrpp8rZnViYc2YwgRYaQR6r5RHBH4/CyzqFwY6?=
 =?us-ascii?Q?506j0ylIpYSbWN+dc1qWChrgsNRQfwRjZESLrqjN/dKcX6NaLvjpEYJyNWui?=
 =?us-ascii?Q?cnxKOHPiBavkSwSDoYPYYkIR5VYt6JvEhkvZ4Fz6AtkgRVYRLRRAmbrElNMp?=
 =?us-ascii?Q?NMMeYePm9XGn6NmhQ+1DSIRX1DkYzHB7P33XuQNSO9Y0EGUXZI7H+jEp3U8h?=
 =?us-ascii?Q?t7YXqsSg6bMJR72ziy0jFRCj46F5rfnZEF2sqmG6XJZ4NGu2eij7cCqMO98m?=
 =?us-ascii?Q?YQjJFBlS/K6y9+ipQlxhD5p0F2sDa+x6/vS/RymSDmnEqqjLu4DzoQtiRaN3?=
 =?us-ascii?Q?gSM9YHPO5CvTf+8mu9+yQbxMp0oHHGjixgdqUpXGDlOXcSRsU+HbA8bKQSqs?=
 =?us-ascii?Q?4xaf22uJSskrm915Od3uPc2+MDU34HrIsfmwfwmBMPuanB35uCFRFXITs3lV?=
 =?us-ascii?Q?1hDEy3GBZAK+D8fFuYQSrQxcBOAP4g7Gu7quanzKSPQhBFVKX/gzh6FYGIDB?=
 =?us-ascii?Q?4jTaVBa6FqJgPHM2sIhkDTrRnKUrAHOc5Z5VTxwYMZ95KdpkswHHN1xwgOuu?=
 =?us-ascii?Q?8zuJ6rfroljhDzLHUAmo+RmwtHlm1pLIAqvTowOU5Rf7lFZSf4LA+LizgMh3?=
 =?us-ascii?Q?7JKPl6i1WOCWH9QkQ7lLlsqiqjMgFKz+NSBsdKS7vW+VsIVXkyhyguMCQ3rJ?=
 =?us-ascii?Q?NIohHdwvJyUC0PXGjwKc6sd9T0DSv0tnZkugydYjvgkhy6i/qqPJieMEMnP6?=
 =?us-ascii?Q?sImZp5rqo5ZtRr1L+jdQLxxtTkvnCKihmzTB8k2iBZOexC2HsrkjtVDOZGDO?=
 =?us-ascii?Q?1YWryMuSvdrFQvhKiLq+HJEjhsEWYpSMsOz1RX0eYC3Ex5QBlKR35NYO3cxu?=
 =?us-ascii?Q?3sEE1ckF+WTxl4Vwl6XAyPPOJdPrB2+o0eKqbAwoy0/KshN5YKfOjr/xDDNU?=
 =?us-ascii?Q?L4w1XWwXjbxgsJHJjV7m1hxiXtMobU7ZA1oEp4SmWt+pvHgZlsPyITPMITxl?=
 =?us-ascii?Q?eo0i7BTXva3hFiH1PJaqKqN13aNBCB23+eyt9SJY1dniMA7j84xCX2xXcrFO?=
 =?us-ascii?Q?pe+wmpt5W61OckSi0GeDG9XrnZbnZahN2l1k9Zn8+t0mNSQVDHLTgpoev7HR?=
 =?us-ascii?Q?DAShd1n0e87qA4K2l55oGgpinwinUtSKFS/KplKxb3zcqI3kxI1PCu8yCRFB?=
 =?us-ascii?Q?c5nNu7r8ZbNWqRGkLim4XrcAyrgx/PSF76yELDdBG6SaYjhQAqpQ3ZGv4L6N?=
 =?us-ascii?Q?3gls72SLgeAIwHPHWtKtAiOVW+uzE7nHDxbHm67hnNz44Z0B+Pzw+9i4KBdi?=
 =?us-ascii?Q?M4pOvu/9YFRXH6HA2My1JW0m4QnlnDKwovlvKg6kX0pv97E19Z2gJw5m4oev?=
 =?us-ascii?Q?vClg7hXzg7jattBRGk1BXhIM0DtSpdDe8807ms1nGHcXbXFM7QO7vqnqGig0?=
 =?us-ascii?Q?aSsGKPFZiZNFu22g0OArqKFI1Yg30tBU5VR9tc7Uz40644C4toaxiKhzoOoD?=
 =?us-ascii?Q?prtuSWftJ9+plkw71TM=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c5747221-6445-4b79-79de-08db471c13a3
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 12:36:51.8678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40szWhuLcQGwOTBTwvyrM+tgDz41KDNftXlSL5L+bWuMWpn/Wtd5XGrkFrQ5Rgt9GS2ZMswtvH0cBMfmwp61cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2221
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2023 23:49:23 +0300
Ariel Miculas <amiculas@cisco.com> wrote:

> Sort the #include directives of rust/helpers.c alphabetically and add a
> comment specifying this. The reason for this is to improve readability
> and to be consistent with the other files with a similar approach within
> 'rust/'.
> 
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1003
> Signed-off-by: Ariel Miculas <amiculas@cisco.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/helpers.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 81e80261d597..73c01db0c828 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -16,15 +16,17 @@
>   *
>   * All symbols are exported as GPL-only to guarantee no GPL-only feature is
>   * accidentally exposed.
> + *
> + * Sorted alphabetically.
>   */
>  
>  #include <linux/bug.h>
>  #include <linux/build_bug.h>
>  #include <linux/err.h>
> -#include <linux/refcount.h>
>  #include <linux/mutex.h>
> -#include <linux/spinlock.h>
> +#include <linux/refcount.h>
>  #include <linux/sched/signal.h>
> +#include <linux/spinlock.h>
>  #include <linux/wait.h>
>  
>  __noreturn void rust_helper_BUG(void)

