Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539FA6E0D83
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 14:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjDMMdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 08:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDMMd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 08:33:29 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2115.outbound.protection.outlook.com [40.107.11.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A068A2688;
        Thu, 13 Apr 2023 05:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TL8Ko6GL7ea5eHYkAFrlSUbR21zHDAV7jdzVJbR5VdWKIpYL9GnQ1U2/sNJ+sWVBfo7Nm3F1EmXB150oRNghZvr7egGtkH0evnHzAFJL3wNmfM5ALLmZ8M5hS2TSOnVaztexF4jYvSlOf0+FMsP8nNLP050/aAH4NluQ0llfqwMS58GB666YnfjAn48X/rjd5eoLFO9MNozakm7bV75BTUO1faQisUvdVbxBsKkEXus8x4g4oQur+lAqdocyKo2RtEGsMICDcKpaEFF2f+IxV8rL6rwls39vR7BuYJdIgPEUUSVDsiXZeoJJOFWmT/2Tz0G1EOFGl0+sSIyiF6S50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVZwvtbSlJvHeYYL4sRBXvG6tfbiExH/YROdtaGa9sk=;
 b=Au3uHkiYZuiwUfTOlYHTwZSKYxUBnJ+e7KU4mDM2AI9mRy8IIVb3KinwI69itwgB8n1waYUpVCRWAVbapokViK4G3UxC22HC32fAztCIEUiOgI2G1U60k079Y1fPQ73lLhxDio+S54l/FcEPU/lfZIqZTI0a91NLe6RhW/x0wpnM93n31R8cWn4DNksEb+hpmUZ82dGPzdPZgTkZlzHtJs7YfiVj+WwVS+VGtTBvk5hEpM/ZLbJOPPm52Xt/OngfmMAt6HnoHoWpL7XiJ8H/3xPaSQlTlplQoQ+x4UrEJNwqzBXL8lygDEzAh2unDW0g9YofVOG+lBji0FGl0J5UzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVZwvtbSlJvHeYYL4sRBXvG6tfbiExH/YROdtaGa9sk=;
 b=YOUOapf+kNd+yXFk6bgPSfR83EvDiojrHftaMAicvxObjMhcNqJ7Ab6V5eyXUY/jXKOkkKlLsjsz3UT8qA7+hd3rfKNUF3M9hC8OuqyT+WBn/zeazRtWIsqXTpdgS5RLTDo3Lb2oHX5pbG6wOyvV6tXo8k3yWbu9mH7cxzpSm3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB7008.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 12:33:25 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161%6]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 12:33:25 +0000
Date:   Thu, 13 Apr 2023 13:33:22 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH] rust: init: broaden the blanket impl of `Init`
Message-ID: <20230413133322.12d58380.gary@garyguo.net>
In-Reply-To: <20230413100157.740697-1-benno.lossin@proton.me>
References: <20230413100157.740697-1-benno.lossin@proton.me>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::17) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e8f172-be96-4141-b3a5-08db3c1b46bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sV2m93CI0n/y6l3VypvlrmHFojYezn/RYv4/LR/ntVZ1TP6DR0PweFsb299l5PUIBEzpeOUfryfDFlauqQ/gDZHeAe787gBiFP0KncVGkGHWM3M2Ss474Jl8iH4PRYlg0hKhFl4P1en/MOitRc5XGdVti/3Gkd9sijFhDAkTGne3GE0HDrbfo+bgNNulvL9st8dm9OdTsBfVu4WhZYIZ/aTV9m3evOmzpr0DxPof60T+BfLqVa8L0FkICDX1333E+r+uQQ2yJUIu0qcDuAEJSTTo2rvMHTQcC/8tVdMXsJKEir/LldOXoQmqWMBoSUOvr+24IWVRbLKT1Ae7zQ4DPkOSK2s/+N1aa1TDWgZIQVoy2k89jcxQ8MtX90mEunJDKdP6RgufYF/C0k5ObYD/1XoG6lEUT95uH0oLAqx7RsXyOv5WFghlfEgKcD2fkRWZ/JCg2LXsG4D2KZ0U7zU3SIQ7KECNBSXCYNoZMvA5rHXmsIyVlSR1rke1v5OdkS1DmRwfkK/krHszeTtdB4Rcp2r8wGbUabu7X36vR4OSEUpVkBqvsleM6/jxBHsJ0yO1YGS2z6CokNTTF+fOR5W9ur0G7790rpd0L1yZSB+jf8I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(376002)(346002)(39830400003)(451199021)(54906003)(478600001)(83380400001)(38100700002)(2616005)(6506007)(186003)(1076003)(36756003)(86362001)(6512007)(26005)(6486002)(6666004)(2906002)(41300700001)(66556008)(316002)(66476007)(66946007)(6916009)(4326008)(8676002)(8936002)(5660300002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sVIk7ajJPJliOtzKNQCMTMGmpAlf/m6ruRY2xhfRa7hflCaOh+2L/jLbraOk?=
 =?us-ascii?Q?6uWK5MmYvQgeLbjGcmdQGEs/bDEbBTBcb6A7ouyzF13611o626XNz0Ww9I4i?=
 =?us-ascii?Q?CfjX9pz1BqnplRaw/x+IXww5lyVBCSw5Ze5O/w2c57ilCKmjp46O6bL10TR5?=
 =?us-ascii?Q?s9rzjTse5c/pbxqbApItxKRTKI+5Go+pvxB1yE3Pp5yynBjkwty8fyHKdUG7?=
 =?us-ascii?Q?D0wp89O2Ko1YsnJOZcHSM2oxN2dH6snKnj/EMQ7gfNL5gvztQwoqgUPvDaiw?=
 =?us-ascii?Q?x3Eao5nOS/UNM6w+Lq1mDU00MBPhVvRZP/63gFwOC2JjUMMRVYB7xTEKkKvX?=
 =?us-ascii?Q?sAT8wBZ+t8q/ZJQcVwap+vL2QBfm24z/xUV8W8w+lcjPOTNVbciZq1JZ/KDg?=
 =?us-ascii?Q?BwpbZpLdhn6CIY3ZWtKIktR/pHLkl+sDVyzKb7pxnJwP+L/h1gR9BDXFbZyH?=
 =?us-ascii?Q?HAcxDptNd2/T7YYMtjTINuOwOd2BBfB7iovnLZR4tl0+NzvN+wM6nJwLvyis?=
 =?us-ascii?Q?UNHU9TioKMlLwlNcxILSrUgR+ANAjsXtW8huglMdK13HW5APB/k8qi+USCK3?=
 =?us-ascii?Q?/R/pwec6Z96n8b/0SHLg1Qsc63ysLYcMq7xfJS2Bmf6MYTbhQ/Kc4NTnbbI1?=
 =?us-ascii?Q?VUz3/7iU+3WdUZ7PiVFv91t8siVOT4sW0hM44rWyf3AL8dHxBmDxPWuXv0Aa?=
 =?us-ascii?Q?6yXm91sf7i2FPzMnn8ijsiEMGX55ciF/TsKY7U3SZ7JYYTxRc7/oQ+NIGCmX?=
 =?us-ascii?Q?KEvvCo7wZg4v84pHLlvhRj46jvFJ+aIY0lTodYwuMyYYGWoDTBkEv4qDLlb3?=
 =?us-ascii?Q?Ay5Rlp7FfcoO0OnhD+bFhnLs26d+NaivwUdHQhZeOfYiNC/ClSvz2+n/iqig?=
 =?us-ascii?Q?7ievE5chI0eMUM3kBiOOYXCixfRjGkVQviaAWyelJytwzoxx8WvTcLlumOHa?=
 =?us-ascii?Q?PnbMGYfvLsz8UwstUiut31y26Lyx+GuKIxMjJMn+dluaNhPT/4mWQBQaFxk/?=
 =?us-ascii?Q?DSB84X/lYGs0EB96YyQAN+1Krw/gBgUKvHNPe7WmLELafkHBicLgJlbnXoGx?=
 =?us-ascii?Q?FgwIYcGKGQxsrdbtZdDJ+CP7NTaBYYe6w3M2+6NmEgLkN7Oc5jJs/8o1EO1v?=
 =?us-ascii?Q?veDJaLEcwvH+IFGuJHzes5kkzG0L8ErESMMqbrU2A46O3y1bcS1LFPBwvVUH?=
 =?us-ascii?Q?/5ro70omORWD0NrH18AsAxBN7OTzsFLFci91cYPPJX0i5KwyAHY/a8uXUa4g?=
 =?us-ascii?Q?DnGnBwKVuSmqFbSygsJBuzSYWTAUpJ3v9+XKGSvOO48BPIiyUUPZNdpEagcn?=
 =?us-ascii?Q?p6W5+4rXp/Zz5tk4c2r035OatrDNooD0M9jZ8QiwNHReF9uNPaR8ekTSrArG?=
 =?us-ascii?Q?cUaLkfCnccL4Uqo/c+Qac9U6kc6hAXeeT6PzaHtnzWNuPjPKRmBCel0PkPcZ?=
 =?us-ascii?Q?92xXQaU58dI3ItphW/jxo5NpZAqWQ3iSZFgK6feOzARwUqRJvL19oHaH0PSG?=
 =?us-ascii?Q?6DPIyYOFYSC6Tqj6kYiSd6MqHLrc9MJQUh9Fk2eR9XWtIeeLykd4KcZYfc3X?=
 =?us-ascii?Q?6S+cKsHW8mb5dpXrPbtgQfWjq3PJoDJQkY4nHpxe?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e8f172-be96-4141-b3a5-08db3c1b46bf
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 12:33:25.3618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7VCDAHObTdkJDzZDFSNLI/keGtM9aNEvvQ042pudQS8Lo+coZ/aw2eYWnCQS7Dkrf+pDNv3h/lwORD2nUMtvDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2023 10:02:17 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> This makes it possible to use `T` as a `impl Init<T, E>` for every error
> type `E` instead of just `Infallible`.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> 
> @Miguel: you can squash this patch into 90e53c5e70a69 or put it on top of
> rust-next.
> 
>  rust/kernel/init.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index a1298c8bbda0..4ebfb08dab11 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -1190,8 +1190,8 @@ pub fn uninit<T, E>() -> impl Init<MaybeUninit<T>, E> {
>  }
> 
>  // SAFETY: Every type can be initialized by-value.
> -unsafe impl<T> Init<T> for T {
> -    unsafe fn __init(self, slot: *mut T) -> Result<(), Infallible> {
> +unsafe impl<T, E> Init<T, E> for T {
> +    unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
>          unsafe { slot.write(self) };
>          Ok(())
>      }
> 
> base-commit: 1944caa8e8dcb2d93d99d8364719ad8d07aa163f
> --
> 2.39.2
> 
> 

