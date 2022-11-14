Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25366282A0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbiKNOcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237113AbiKNOcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:32:31 -0500
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2134.outbound.protection.outlook.com [40.107.10.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FAC2B1BF;
        Mon, 14 Nov 2022 06:32:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddxwJFo7jlqqpqEOOSOfptzpCGcd3zx0QvKwhPSV2/3Jb7PF/N7a7dKVbIgYW1/xbIpx3i5jLD7AeUMgoON1qV1JI2UPwVQvz9fakOsJ9riY8Kmy3y09RrfgGIbB4JWSHIbTrcdqisbyXpD+qptRo9ixW0vO54TO6R5LPCXLIMBLahp9VO5qpBJomUP9+a6YC5Ee57yDBgZBOTzrHhtn+1WkIjKtuNqOT6i7Fk+lV4ZCgXfHtj9sAPH6HBqz9cEZV/VNLqzt5Q4A3UW4wNVi7wLJs1zWUMyA+kCS5wPj7kQz8ToO8V/cjLmtdt8r8jNg1V0XqMvu8L68SNdNBNL0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbbFmEYEiTlULZ2pcIFenkYPD7mE9wiyawjYnpJLXno=;
 b=mbK7g7AD1i7RS9/iAH6TSFs3cM5wRLzoSkf3xy+2yriYAlkGuBSacVqetm5xMXA7UQWedCZU7GWEhx6fzMrMY8txeOLiadE1XxL3aRcug8pU+r8ZugTWqh2eD3lQ1DAC9AVndx4fxK+lUCe4YOoHzO0iL6PldTsOjg6rsFCm7Q3QLl7vb4GXFzvnn1kSKXFHnXirHImw9eJP0f+m5495npiQUQsWWSK77MV3tZSr4CU4OSkZBhLM2nwPx1KgR5V9zHkzBEU5vnRRBF8mcCiESkJUv0sKfmtsJlhQliqIor84U+Mf3TcueTxrckvAFs1JFVz3DEjDD55UfDmdpKBA+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbbFmEYEiTlULZ2pcIFenkYPD7mE9wiyawjYnpJLXno=;
 b=ywWDJ33qNMbwrAOxKWojkHooQA3FCiKoe6KXpCXo9RqTwR2tppYWJP7iytkDvpYpzxmivFucGnRo7MEBK/lKYXOlQNDfs4AwbY0Be530FU/sB0txZqYr0avrWnWIc8oxkoFybGucS2JP0Sn9X+sA2N63cIjOIHvbBSscnVh2JVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB5406.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:286::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 14:32:27 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7%6]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 14:32:27 +0000
Date:   Mon, 14 Nov 2022 14:32:26 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v1 11/28] rust: prelude: add `error::code::*` constant
 items
Message-ID: <20221114143226.78512a35@GaryWorkstation>
In-Reply-To: <20221110164152.26136-12-ojeda@kernel.org>
References: <20221110164152.26136-1-ojeda@kernel.org>
        <20221110164152.26136-12-ojeda@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0406.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::15) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB5406:EE_
X-MS-Office365-Filtering-Correlation-Id: db72c2d9-0ef1-4396-2318-08dac64d0ded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rKyeiRKAqxw7ZLy1ROz6l3j2X1+fcc7GUADg5K9cjZQK0dEDvOJUDuV7ZQGItz8sXedIQwjuEJnhqhjMYZX8/OcGsJP9tkY4eX+oXfFvsen9aOk+qEKLKD4BwkxIgrdJYN/6FNxPoy2KfBHDSSfq1HLbd+zaLGtDIqXmL81u5Saa8/rCzyr9c7CjBdGxkyNmD+YMebnEVq79Lgbj4Er8Hp4YbG44g6UG/vvphdcsK6aj1FQ1NnPsKIk5vVtdYGY2uLRXAYakgwYJdS1Mt8FwMj7HJa1ZcyXSAyc03rKevIY0Ho55yuDMCnlujXP3AcPiLoep1rg35t/Fa7SprWWXhYHK1yoODf5FCOU2TOT0kUC/OAL9Yw9yeXWinigkHdYjqjt1JFgC1ejIMCmE9Edn4ow4bWEKrkYmqiwwza2gQT9C7GfEQgxFhGmagpfgYrbSlbnYDjbklRmrwnEei8zzYH4N0d8C5mlk/0+7HRzVB0q6GurOzHcna+76jPNOVaTkFfFVVhL4aAAut4Qd6pDrpsWKRVh8FO3ECONAMnofqaAGY/C0ucv16JuLzD+rxlX2SmCsIM6nJmicroa2CmOk0fXZv+aviLSSVW+e7Scdp4UTCsCaypsJ2l6Tn70vTlX3SS/5utD43iF6YTxKduZSlzn4mkAshh229H2M3+OE+UoL2etL9SjiQmpDV35OZFOS3bDckEiKRI54dmosOFW9sioo4srkCcLlogel3LU/FVGNbSPL8YNJDJbdVzcCCTYs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(39830400003)(136003)(376002)(346002)(366004)(451199015)(83380400001)(1076003)(186003)(38100700002)(2906002)(8936002)(478600001)(33716001)(6486002)(6506007)(6512007)(66476007)(9686003)(41300700001)(4326008)(8676002)(66946007)(66556008)(5660300002)(316002)(6916009)(54906003)(86362001)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NlCAhPRMJJLldgC5Yl8Esdro5wGk4E4Q3O+q6MuNjSD68VaWVe8dDpHUdaNL?=
 =?us-ascii?Q?tBOIU64W5I1LxIWwQrbhx4p1NwckYWoJpPR/UxkGJbRgcB5sFfM3gYc0xiZ5?=
 =?us-ascii?Q?ghEyPOpmD1Blsh5noUYy9h0AZQrrE0G2LIcwBkYKodoIgO/k84Ve9Qgnj3RI?=
 =?us-ascii?Q?l7fugv9nTW5X6gbJuZ+/bSQ+xWn1+vb4fBKrRBw/WPno84nwWsz/MkcBnUYa?=
 =?us-ascii?Q?dQtMoQe9QmEHVYbLWhAPMDm1DfYpQ0VX9fOYVQQ7qdqL3YkEr7qtLH3TCGHi?=
 =?us-ascii?Q?5mZTZdOvPvbDi/pmdHbsrcnGoDgC3o4KmVshHG9tLmsf7f6L8wSjH9Up7gIJ?=
 =?us-ascii?Q?1H4Rf9DkU6hoyxhVz17rdBxTxD3f9Jn+yU/s9ktNLgchibmQ0yniBazBPTnF?=
 =?us-ascii?Q?o3QWMc5iPvKagvEIDQ4HdPpSY/S5tXonaCs9/gF7vw7hi+uj5SzqP3JHCpT0?=
 =?us-ascii?Q?V+R8vs/UYGpsauhtZkDE0RIgoZ3O1eiEZMsrJYrLw+83gYmDEdFQZ5cPVbqX?=
 =?us-ascii?Q?2F8NxdGCKyBGXTaCHm79SNIhCeHs+BCyf4UsM0FGy8J8cpCONNW5WaI5cIoe?=
 =?us-ascii?Q?xkOwslhG7O4maEve1d0LOM9ISWoqdLXS7Cdp2RmoprgyRMH7k023XpLIutNU?=
 =?us-ascii?Q?l/21cYXAJhokrwAwByj2ePBKsVGeeaErghiQzWFCqQVKkhqx3N6E2v+LBA3m?=
 =?us-ascii?Q?ZQd5ErsoLb3SkRCpjeEPS9IfunjNJJICxbANKRNpCir/2pp2MDPwhBmc5koR?=
 =?us-ascii?Q?rIFVyoVnucsyI0cROR+RqPBQGHXGH4YfZXNqbtZfj73fyzdcwTHmYGYvXBsv?=
 =?us-ascii?Q?4cCCKPj0l+Pq070Sx+lYRkMNeHWMswahpEVmtr1qyNvNQ3iVsMDCfwVVCHA+?=
 =?us-ascii?Q?cf0ELhKGvAB5YwA9qYRuqyVxpxRi/W+4B1aLDlQrMxwzLMW3wUmAUIOrHyz6?=
 =?us-ascii?Q?QIYQQOXVaV+dDpE1ZyYjJWGV3XDa+0cKobjLt6/GHMaZp/hdnCyMSGd3hnzs?=
 =?us-ascii?Q?DBW3eI7OfAvjK7AxZ08+0/v84Ve+hatsRWOtjiS3LJXirpp/8Z8keOMKpA2y?=
 =?us-ascii?Q?i9q9EGB0p7SoM4FQYXcF8tFqVMXzPN5jmOE8pODwyDOzX/4IXJThnsnkFD4/?=
 =?us-ascii?Q?DX7JFcb3Eb9WofrDN/tdydkExJDFOzHWF0rWj0YCleZbDjPsteNGcT1ccBbi?=
 =?us-ascii?Q?WyGvKDXSP1sJfd+cV13RwJcsBtKDRpnVJ3BjzXhhZ6mCvj3Nb4uihIxxPxUY?=
 =?us-ascii?Q?8PKsoJiaxCvkSK48aIeyhNvS+MTGfUZi/mZdr7IWh43XfaNB75/OGjLZo1Q3?=
 =?us-ascii?Q?densTszNYbZCi8MZyTIm+Mm/tgcABJVZEnkBXePjxC3aRYnpV/nd+W7FTV5d?=
 =?us-ascii?Q?WsaRahXWhsImhDnvwDlTRwol+KhyAsNI/yKoyvhCCzT30XBvCAFLQtwCGnmm?=
 =?us-ascii?Q?c2ooYVi0k5ngV/5qn8Q+7z3900ECVeVsdgz3Wrysa+FnE8cAnZ4/mDDepFvf?=
 =?us-ascii?Q?LoS5RKE2sXJp+Dqjt/sPOAf4LMi6yAPuJOnqxf8FBLGqhLCbRn+0OvO2E4HR?=
 =?us-ascii?Q?9szxQCfSnFJEOe3Dmp5kgCYL3AnCXepdU9iRLNZ/lvzU33T2c4mc38xvXGjF?=
 =?us-ascii?Q?ny0BaNyFu0UwITy5NQHu/ItBDw0fakG7N5Gh3ZPL35w6?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: db72c2d9-0ef1-4396-2318-08dac64d0ded
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 14:32:27.5553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kY42fAoS5fMqhpYgPJTwKu4OtFyx2EyG/ZT5v3szsLyliJuh9KEqRZlCdCbCbnjE8bIb4mYPUl9+HLBQx6Lu6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5406
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022 17:41:23 +0100
Miguel Ojeda <ojeda@kernel.org> wrote:

> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> It is convenient to have all the `Error` constant items (such as
> `EINVAL`) available as-is everywhere (i.e. for code using the kernel
> prelude such as kernel modules).
> 
> Therefore, add all of them to the prelude.

Personally, I would prefer to have all error codes as associated
constants of the `kernel::Error` type so the code below would use
`Err(Error::EINVAL)` (more "Rusty" way of writing things). But IIRC
that we settled on the current approach because it's more similar to
existing C code.

> 
> For instance, this allows to write `Err(EINVAL)` to create
> a kernel `Result`:
> 
>     fn f() -> Result<...> {
>         ...
>         Err(EINVAL)
>     }
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> [Reworded, adapted for upstream and applied latest changes]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/prelude.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index 7c4c35bf3c66..1e08b08e9420 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -19,6 +19,6 @@ pub use macros::{module, vtable};
>  
>  pub use super::{pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, pr_notice, pr_warn};
>  
> -pub use super::error::{Error, Result};
> +pub use super::error::{code::*, Error, Result};
>  
>  pub use super::ThisModule;

