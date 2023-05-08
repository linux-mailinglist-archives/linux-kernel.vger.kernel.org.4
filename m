Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2241C6FAEC1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbjEHLr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbjEHLrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:47:11 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2129.outbound.protection.outlook.com [40.107.10.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF6B106FF;
        Mon,  8 May 2023 04:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ij+ykIkuqPeeYmPz04BKlVSHBQ/Z/o2ZcFe21zl+bO4topbhaTIGdKOCZv3UGG1JuoG07oR46JpFWdnUn+BfyAP2JjYPq8/RHVeGGVPsVtkhNTK4nmKBroZJcleiECtpthDsG0iVTnce/oz0mTNQR0SGZ3YC1t4IOzim6UnW9fELpR0D+wGZIhcqbfFBsc1/BzFkJ7aqFsPGuLqURy7zWA2nGvNnvzje6DlrCREZdMl9zZumb16l7KuqIEMZAVRvGTGdS/ek4Vb8Qz1CZlr+4a9HhVNSFsljbsid/3SjGA3jEIbzmbqm9O5SBKGU8w4g/sC9QJRKpmrC5FzdiPGlOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLdmoJazkcFVVj/WqYmTJ1Hnta7DFL4Whpe8B6rWpfc=;
 b=lXLS4TxfHInHL7mF3hzBg7lrQUygYefJvy5oueLeV4AoEADNmSE7d9J3pXJIfp55GJJbnzIDT3XD3Qk2bNFW1uY/HS88sraCXIeaWETy/p8ltSLbiAhbfNQK0PUaAycK/t+IImHV0KToRkgNLaOUDD0US8Gt6RFlrA+mfIUZ4D2Kg2lVCEvCPCROgousxeihbci9Qv8fZ5jhkS/8niLenWrusGLwVhNfo0c0e64ZpETiF5GsENDtcvODRisgewhgo8q04KWhqK6eehEr3bbmho7brPUPG1J3nEYly/cFWXXV20rUXRV+xVWSdNy0xuREW9czp1HubkkYlVxNNb3ehQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLdmoJazkcFVVj/WqYmTJ1Hnta7DFL4Whpe8B6rWpfc=;
 b=O+fommvO3MftVXJrTCrCXW+K4SeJtzcm2KHRr32OxjjfYgX7zMEjJ3T2aFYog8IymIg6ACYHRXYd3yyd1j3Km8AAe08Kr2Q7Rcfz0fC51TnNmbDaNiInyXWN96JAC5RhgVlxTfgu5TvkwkUJQP9vMN5Kl22WGW4eO0oQ4dFfiWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6996.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.17; Mon, 8 May
 2023 11:47:03 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf%4]) with mapi id 15.20.6387.017; Mon, 8 May 2023
 11:47:03 +0000
Date:   Mon, 8 May 2023 12:47:01 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "=?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v2] rust: error: add missing error codes
Message-ID: <20230508124701.443ba331.gary@garyguo.net>
In-Reply-To: <20230504064854.774820-1-aliceryhl@google.com>
References: <20230504064854.774820-1-aliceryhl@google.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0197.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::13) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: d501ed7b-c641-496a-52ad-08db4fb9f0e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h3MxCwuA7FnVPefR0SdEqaDHHbMQJvStZMKyPFlsMYCgU2ZjizarilQHUoiO57PyfcM/dXxz447BQh5aEnzmmpadVXFvnaecpRXQNz65U31KewZ5wZ58wxeSJEBUCTX4u4X9IyhROsKmlr5eP/oULY+2snLLPxTberhd+ajehBWKHpVNJgXh6aTL+7a9XJnnmRdc8v+IqSgWolHY2JWOYAToANA2deNPXXE1Bflb6IHxdC6DbXWOrM/9Kts2K5nDsvWhh7OYNWwo+USL9RbMWGNrhJ9rDsBpIyWUWYr9vUrz4L03gbhgNHmllD0VE2VNFrRb/evBbTLfXTqZ+xNbXqZapsQDbtL3QlZFszqN0vCZGYrF5mU9BPxCMHx9T6eXfAqdcHQK3fgDETcyEHBES0LyaAOIXoLEDMWoxtqT+msh+ARVvowiUbBNstaleA+iTPe+c8ELDXUp3hCxcgZGEZjsmwJPp31ySa6XHMJjQz1KcB+4IbLJpxcbQGVOFIqFS4i/17FwWwsoW3P/bi25RHWNdGdnfT33cgeRaG8jcML/TkwH4qZALC277CLYlLkz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(136003)(376002)(39830400003)(451199021)(6486002)(6506007)(6512007)(26005)(1076003)(83380400001)(36756003)(2616005)(38100700002)(86362001)(186003)(2906002)(7416002)(54906003)(316002)(8676002)(8936002)(41300700001)(6916009)(4326008)(5660300002)(66946007)(66476007)(66556008)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PDi5xTJFu1uLCSUNVgmKyz/zW1wqBcb0BUz9wkmK5AXGG1/6aCTbnp3aWQl+?=
 =?us-ascii?Q?TRz17YqaUIvn9UEu22kJh506V+Ld4m7zVCgpaYPTGX55dEt7UA4r2RWuCqVn?=
 =?us-ascii?Q?50G4/lF8bj5Dhqw53y6Ufg7nd1IQIPQixlxcgCN0JQ9P54CXxdxySDnTXOeG?=
 =?us-ascii?Q?mWUMIUUVHVi6XouGfpDmBZ0dsOJFdnQYB8x4RxNxEoM4wt0inHzhYy0hJhCt?=
 =?us-ascii?Q?QFZxPBXIzVdQDMG6YXWORPQZ7posBAO1f1HeGl7ms9jwhYyOvJdXqxvsCxIz?=
 =?us-ascii?Q?nwv/SMjYDpyTQzVY+weolgvjZ/Jjs4PVoTC7DTGeO3hH5Il56E879jt84QD8?=
 =?us-ascii?Q?AE8bbID/DkJZPiQBOa7km/WcDmfrUtIXx0JFN8WDhObXg/LR0kfW5XKUEXM0?=
 =?us-ascii?Q?LAA6833UU5XgIW4U2Xcie7dCOaRJluxCF8QkVH1DzAb0eoc2CJzx6nwLIGhI?=
 =?us-ascii?Q?eF+BY8orNHXWePNsrw8OWu3RSSgqubXi0WuAejZ1bSKhEFAH008OAm/IH7Vf?=
 =?us-ascii?Q?Z/yPqAf98IvuMD9OVq7VALpslT8nRADd0fvQur3Tc3BPWRDf8w1t97fyYeBZ?=
 =?us-ascii?Q?ARxDLPtMrB3djTa5JGp3ZpEpzrA+6/kY628We6qwwAfdBbdOgzgqOP7BepIk?=
 =?us-ascii?Q?lt0+7f1OkGdqltDtWRIhO4W+wsGrQklg5CV3LFlhYJkxADifmG3DIgQAo0e4?=
 =?us-ascii?Q?N6YEjsglbsNF5mNjn1KZ4F5Y8r/PRAtr56Hor5GLPxSY/mt1u9B6SbxCP0fZ?=
 =?us-ascii?Q?yi/5jhkDttQTK9kuH/HvloYHLbGI/WqkBRFHb2t8VdGNntSJY/UoxjPOzGqi?=
 =?us-ascii?Q?Tn6DPuZqVqNVnFPuscn+QNEKrSpLPt66BzWepMWvjSTbxqK+7LAAjN3gqAxb?=
 =?us-ascii?Q?pK+LH7CWdTpyZ5khdjqV2moWwEbsdlA3zAwDZEYhwZU1p4a8cKX7smp5w5o1?=
 =?us-ascii?Q?OhzHITmoOILYjSFuILXjhAiapQ7Jn2g6vm35CJlfNKi/aOL8J6yJuwFHU5/k?=
 =?us-ascii?Q?Fo7AdbIeApgIMLbB/ffSAHNJt4AoO8A7ZCjYJN/PGZdZqo2rSOcIHpANonC4?=
 =?us-ascii?Q?1wgecbFeHENAj24H2A48niDQWlncdrXgN82VOhm951zb058eSAzfe2ab3yQ5?=
 =?us-ascii?Q?0VCo+sYCx7GvCWF8QTqKo0o5a3gVFw1rVpG1NvELNnz0KalbEGP7AXxEBomG?=
 =?us-ascii?Q?3L2HD5QbtAdOREOu82RwpWkaNwTO6tW1b/D6ohmiIIexBy9rVps7WWE1NglA?=
 =?us-ascii?Q?ykCOfZSMs4tIKAJtTOVZfVSmVU9h7aanSzBTGFWODpqo56abCMmGJdfwEuQz?=
 =?us-ascii?Q?JAzBsV+p2F4CtM5MvM77DVFt/KDEOrexgzjGBlf5VeoyvhtuXFI+6sl7k0Pd?=
 =?us-ascii?Q?WfarDukKg1KMilJxVanQQ3O7kF+K60C7hmr9kxsuz6F55BkW2+/VNKi7sMuI?=
 =?us-ascii?Q?uKzTSbQfpJxRqJ2zlrIpGzJfzkGmYmGsh4FS8viU0ByrOUZdkB+1bsR4ElRw?=
 =?us-ascii?Q?weC46k02E4cX4fmetmiMMgZRCWU7FBlv4lco4VOo9YbqkyPU1LKWSgOIWIku?=
 =?us-ascii?Q?huNBsayyuGQxFji81OJsh5FK7qzvO6x6wt5gFP+P?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d501ed7b-c641-496a-52ad-08db4fb9f0e0
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 11:47:03.3104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+0YtEdC9a+tzKpns0gq82H1TZAs73p3VjNlMa0Kwwby7blBtAvRegHlNKv+ULnwAKf/PFRSIoC+m9g7WAKK5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6996
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  4 May 2023 06:48:54 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> This adds the error codes from `include/linux/errno.h` to the list of
> Rust error constants. These errors were not included originally, because
> they are not supposed to be visible from userspace. However, they are
> still a perfectly valid error to use when writing a kernel driver. For
> example, you might want to return ERESTARTSYS if you receive a signal
> during a call to `schedule`.

`include/linux/errno.h` also includes all of `asm/errno.h`,
which defines EDEADLK - EHWPOISON, which is not included in this patch.
I feel like these error codes should be added first?

> 
> This patch inserts an annotation to skip rustfmt on the list of error
> codes. Without it, three of the error codes are split over several
> lines, which looks terribly inconsistent.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/error.rs | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 5f4114b30b94..de4fa8640f29 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -14,6 +14,7 @@ use core::num::TryFromIntError;
>  use core::str::Utf8Error;
>  
>  /// Contains the C-compatible error codes.
> +#[rustfmt::skip]
>  pub mod code {
>      macro_rules! declare_err {
>          ($err:tt $(,)? $($doc:expr),+) => {
> @@ -58,6 +59,25 @@ pub mod code {
>      declare_err!(EPIPE, "Broken pipe.");
>      declare_err!(EDOM, "Math argument out of domain of func.");
>      declare_err!(ERANGE, "Math result not representable.");
> +    declare_err!(ERESTARTSYS, "Restart the system call.");
> +    declare_err!(ERESTARTNOINTR, "System call was interrupted by a signal and will be restarted.");
> +    declare_err!(ERESTARTNOHAND, "Restart if no handler.");
> +    declare_err!(ENOIOCTLCMD, "No ioctl command.");
> +    declare_err!(ERESTART_RESTARTBLOCK, "Restart by calling sys_restart_syscall.");
> +    declare_err!(EPROBE_DEFER, "Driver requests probe retry.");
> +    declare_err!(EOPENSTALE, "Open found a stale dentry.");
> +    declare_err!(ENOPARAM, "Parameter not supported.");
> +    declare_err!(EBADHANDLE, "Illegal NFS file handle.");
> +    declare_err!(ENOTSYNC, "Update synchronization mismatch.");
> +    declare_err!(EBADCOOKIE, "Cookie is stale.");
> +    declare_err!(ENOTSUPP, "Operation is not supported.");
> +    declare_err!(ETOOSMALL, "Buffer or request is too small.");
> +    declare_err!(ESERVERFAULT, "An untranslatable error occurred.");
> +    declare_err!(EBADTYPE, "Type not supported by server.");
> +    declare_err!(EJUKEBOX, "Request initiated, but will not complete before timeout.");
> +    declare_err!(EIOCBQUEUED, "iocb queued, will get completion event.");
> +    declare_err!(ERECALLCONFLICT, "Conflict with recalled state.");
> +    declare_err!(ENOGRACE, "NFS file lock reclaim refused.");
>  }
>  
>  /// Generic integer kernel error.
> 
> base-commit: ea76e08f4d901a450619831a255e9e0a4c0ed162

