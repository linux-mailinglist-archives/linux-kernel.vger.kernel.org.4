Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFA36E796A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjDSMLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbjDSML3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:11:29 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2137.outbound.protection.outlook.com [40.107.10.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E815461AB;
        Wed, 19 Apr 2023 05:11:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=It0zX3ZCaXxF/13STsJAIXAvqyyKLIOGLKpoWjXOHJDKMOcIEb0UDH2FjpWdizYC3TnjbJnZOq33wH1yPK5OedkWbHD4HdL926F+3ZYxB7kS1K0sr5x7IuNXPTgDzJmY8ALaOzfnMhPW/rBkiIaYhYI5USG+AKn9O8ffYWamxUJjq9MBVPIP0XZ5Huy/AnK2aPutoN0IJT/hOYnSTxMdgTbHixHhqSQkfY6d8YN3gtTClotisfSmXdG2TwYCItu1Q3gT5c21BGFDkkeiTZKJfI4ML4eXtFymCyEhwJYxYIAu177011ZX3zS9DtnCyX4mM53QGCPJxc1CMPvqPmpLbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0/fg8BXxMaJWfZ6AIraY1IascZUbBQQfTqBzRPzOw0=;
 b=BptdP6xvxuX58XK36Zc4i3qmuIDAt7bCy/dhDC8GwsT3FO+mG376No77VDgTAGStTmo+OmUeonJ4YPz5WLJSYGRsjITzAzqz/jaZCTpX2s5SBafLjAT4FnpvaFPcyOFVx016Tp4htWf8E1arehM06C+SqGOnbf9x/eEO5Xo2WI56ZzBQ1cNTq3bJQ+c+3YHdZjWxte83Vb2eFcarwIEoiu+oAT0rA6PfauHqhjF00bo0q4EiQHlcUSbRx+pj8eShdd8fTUjDpFWd14BGveaC5w+3OIUUwD/xXGyA4l6OwlY1paMUvQIq9mIcyU2ycF2Rh+pvhUmGw25l+13kle9CyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0/fg8BXxMaJWfZ6AIraY1IascZUbBQQfTqBzRPzOw0=;
 b=oN4/erj0dCoJ127lf+PRf+jOnjzr0x/O5luJoV2d6KUz4lk6RpImMdvuKSuzAdbaecvVdeBSttkkn03Ye9Xgx+6Tp9MtiwjwxdlIORTnzbCDga1ZZQiDh/X6IyqIBv/Mz6MaA7PvKsqFOk440hsRuvHAs/GzoOm3ntk5TJ+BEEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15f::14)
 by CWXP265MB5009.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:19a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Wed, 19 Apr
 2023 12:11:23 +0000
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1b25:7ea3:7339:6a0f]) by CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1b25:7ea3:7339:6a0f%4]) with mapi id 15.20.6319.020; Wed, 19 Apr 2023
 12:11:23 +0000
Date:   Wed, 19 Apr 2023 13:11:21 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jean Delvare <jdelvare@suse.de>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH] .gitattributes: set diff driver for Rust source code
 files
Message-ID: <20230419131121.6f5f5acf.gary@garyguo.net>
In-Reply-To: <20230418233048.335281-1-ojeda@kernel.org>
References: <20230418233048.335281-1-ojeda@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0185.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::10) To CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:15f::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB5186:EE_|CWXP265MB5009:EE_
X-MS-Office365-Filtering-Correlation-Id: db42e17f-6ea9-4e00-3c3d-08db40cf3190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i8s68f9fJWvcZ2K/PhHBBDlt1DgPU4D2AadGF2S5dfFU0tmdjOcVtKrjXhMifwRi/XbdSRlcB3etVeByxIZEgZyW8N1LKXJcUq1FYw1dwkPFSr5MkUiI6y2Q5DgXX7S5CAi2aUC2l8c2MY8mx9f3XFiuQwena9Y7bnt//EQwEHpARUrS6iMs1Z8/gXNQTstnwR9s6GmlPJ+JlFt4ogaaFlMhgX8ChQqOrmQylMIIZPCzNdwTqrr+P5lGVT2I/38zQDmpxs7x5M8eQ7BXVqiokA7LUwkS+5KB/x6OpIpAWszgngEqrlgRxTAj9X1jipQmVSYAL2z2NlEd+VyaIyxkQfohldGgacLa4yQL+BQlQNdiSsqxWmlEDo1yV5xZmj3z7GxGAyt+6/b1iU3TAE3qji4+f6L6PBRzISTP7VJwbZgmzdXsSp5wHQuaseOuD5TWGghvV29d/5E1pEoxD6q98Scueff+KzV2d7crFvLFksKcjKEDn9TZT5oUIqf+b2LDZCVJQC+ERpE07bz3JHOSU5XOF9JiRaD9meq/J+01HQE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(396003)(376002)(366004)(346002)(136003)(451199021)(6486002)(966005)(478600001)(86362001)(36756003)(2616005)(83380400001)(6512007)(186003)(6506007)(26005)(38100700002)(1076003)(316002)(66946007)(66476007)(66556008)(2906002)(6916009)(8676002)(5660300002)(8936002)(7416002)(41300700001)(4326008)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AnDfZtyidZ5C/DKU+elkLrG/TspLqBJyvHWxamnXujvAqXMfZXvaUbWEQmG/?=
 =?us-ascii?Q?ijTCihTFjd+aI7fe6b79w5hXCkskxjXymGkMw+7y5fFKMAHgTsAcJBz6URm2?=
 =?us-ascii?Q?AESVcOXC9ntzJDN5bIKiBLNv0YeotJtmhD29+IAEl0js+jWcE2cwyipLSJJB?=
 =?us-ascii?Q?LYIhYDHOuPTTohxEmVBc1x+HCRtgUX5QbxNATGUQjzH7QJEjSYLFLUPpJI9j?=
 =?us-ascii?Q?9A3xxBj+fOFOEUznoSdcv5B2Irs8VGgzQucpFm7lDsea1Gt4p/jgd0OH0HI5?=
 =?us-ascii?Q?1x5zcGvZx3Ke5SH/UpwiCvzwSfb2QHeOlsmlihSiXhgbpEQB8hLLaNiTZJRg?=
 =?us-ascii?Q?aVZD1nEybnBNYiR/HG1C13Zn50r49SsfVqQcdqUNKdqMOohVSfNJNWT3dICC?=
 =?us-ascii?Q?CUPOGL9LnnUibajjBMgwUZ5ntHOpUgfkfCUZx35enHARdSww/kJExnWVZJts?=
 =?us-ascii?Q?u0wiQKSvAOMQvspHMUuXVZq3gsoDL3vMi2CFnimK56ZC2+zBV1K9LuDg/MDw?=
 =?us-ascii?Q?3cqBQXCXtDyB8ZGlD8ce+19eI+wgN+PrYqSh+juCV/N2D/FmHidWdnawOOmX?=
 =?us-ascii?Q?trPg0asnpBRDIr662jhibjkLhtOlQb9RwCVcZ1AdYIbCA5teSEh+y8NbwF05?=
 =?us-ascii?Q?eJEZmqu+nGkVf6OB9LEp+SNVqpQWJvrSEVguWoCGojBJnkajoT+a1qwsheF/?=
 =?us-ascii?Q?jpr5Nek8YdWv8xG+CvgIg/MgBV2FlzarEnOQn9oxXeMIa4kvhmZVdWuI3SBp?=
 =?us-ascii?Q?z3IPdlPdE5IfxHnDOPLvW45eanMS+4D5sTd6ROA2pSkpeW/8ZOs2bcZ104pN?=
 =?us-ascii?Q?yfhDjoPI2b91dVdc5AqJaJQlAUtEIGs1h5hlaKAFuJ24U5kJQwWKU43cF+QU?=
 =?us-ascii?Q?AB8OnUZ0x/zINelID2sx0er7TJqBXqcpEBL6yaUC8jo5xPRuJs4cKAP/Yph0?=
 =?us-ascii?Q?29YtuSwdYB1HZm+yU/Id4orWviWb9kQ6+IOmkyZKPyHTV78fl1jMkPfzHnf2?=
 =?us-ascii?Q?lmS5ogM6bu2IhEC6WQI58560UWPvBCSmvXFCfBS64PS9VqrCx3964XHT4kaZ?=
 =?us-ascii?Q?eq38wHyLvOGj4YIbaQOhGvDWUgHwcpfknEsJjrgBwQq5pijKUyNJxzxxtVLW?=
 =?us-ascii?Q?WNQzjvUacE3sN08ZkuO5OzCh5ywdr2cdXf3j04arNmloYEfvkjwE4T0gNWFP?=
 =?us-ascii?Q?t2/MrXYdcgI8mryAf5ZtvOV2QwBNuP9LWpOaFfx3iDKiGHTHgxIuDHgg8l1+?=
 =?us-ascii?Q?BGdmtwqy+BwS6ok4XXdepsClodxq+ioLa3pacLzGxSv3LuogD969NycYG5Fj?=
 =?us-ascii?Q?HEZqKXNLL/qqxeGUB9xRiXqlHqRQ3481MQyZk83MYD+iNpLb4RPBm4PfjDR4?=
 =?us-ascii?Q?7IyWSX/gtX0Zl+N0OJGdOF/kOp70iNm9HwMP/kLgHIRJlIX8V7G0XMGbmwze?=
 =?us-ascii?Q?EOoaLst4sZ1st7xKCxjtqQfKG3WVBSBQiQG8dAGA/GfVj5+FlNEbUZIx5aPV?=
 =?us-ascii?Q?9FJU0NkIyU/72mCO+xQIT01ldCcxL7ug0y3yVzfvTJmfjggVC7fEPkVZJ7Id?=
 =?us-ascii?Q?5gfhfuMmednTbkkXNqaLxQG9Sv9VXJ8ejXsZQuJE?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: db42e17f-6ea9-4e00-3c3d-08db40cf3190
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 12:11:23.8325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/uFDiJPIdrK9opo9ydqaEgX0jAa/1MiHmyrTAHD1QTFW04DOk98L3zE3PKT7uXgCMiWU5zWch0hhygN2//rhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5009
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023 01:30:48 +0200
Miguel Ojeda <ojeda@kernel.org> wrote:

> Git supports a builtin Rust diff driver [1] since v2.23.0 (2019).
> 
> It improves the choice of hunk headers in some cases, such as
> diffs within methods, since those are indented in Rust within
> an `impl` block, and therefore the default diff driver would
> pick the outer `impl` block instead (rather than the method
> where the changed code is).
> 
> For instance, with the default diff driver:
> 
>     @@ -455,6 +455,8 @@ impl fmt::Write for RawFormatter {
>              // Amount that we can copy. `saturating_sub` ensures we get 0 if `pos` goes past `end`.
>              let len_to_copy = core::cmp::min(pos_new, self.end).saturating_sub(self.pos);
> 
>     +        test_diff_driver();
>     +
>              if len_to_copy > 0 {
>                  // SAFETY: If `len_to_copy` is non-zero, then we know `pos` has not gone past `end`
>                  // yet, so it is valid for write per the type invariants.
> 
> With the Rust diff driver:
> 
>     @@ -455,6 +455,8 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
>              // Amount that we can copy. `saturating_sub` ensures we get 0 if `pos` goes past `end`.
>              let len_to_copy = core::cmp::min(pos_new, self.end).saturating_sub(self.pos);
> 
>     +        test_diff_driver();
>     +
>              if len_to_copy > 0 {
>                  // SAFETY: If `len_to_copy` is non-zero, then we know `pos` has not gone past `end`
>                  // yet, so it is valid for write per the type invariants.
> 
> Thus set the `rust` diff driver for `*.rs` source files.
> 
> Link: https://git-scm.com/docs/gitattributes#_defining_a_custom_hunk_header [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

This is also done in rustc repo:
https://github.com/rust-lang/rust/blob/master/.gitattributes

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  .gitattributes | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitattributes b/.gitattributes
> index c9ba5bfc4036..2325c529e185 100644
> --- a/.gitattributes
> +++ b/.gitattributes
> @@ -2,3 +2,4 @@
>  *.[ch] diff=cpp
>  *.dts diff=dts
>  *.dts[io] diff=dts
> +*.rs diff=rust
> 
> base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d

