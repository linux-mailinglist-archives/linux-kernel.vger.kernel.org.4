Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4D9687FD9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjBBOXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjBBOW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:22:58 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2105.outbound.protection.outlook.com [40.107.6.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B317D903A9;
        Thu,  2 Feb 2023 06:22:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egkjR/zfjBhFzmdlfKh2Zsa/SGchrxnWHkAvzM9VDs3LA9fU/fKfJziyyRb4FUcxjJ689ICNnIhRY/cZt+a4hIu5OTg9coj32DweU1TPuuiHhM/YR0tkMKkS2DA5ca/CZwOfe20dWJCziKTcKiDtr1XWT2hsT69X3i01AYXtaopppSUd/PLjQ346tKgHnQzK0FN2QQaFtpBVXbCaAbIsYm2h9c0/C7c253jjjO8WJdRa0W+mNwCzm/UNFX3sc4Bx7FZTvTzwtsSy8Bg9tA43gtsfvHY1aaLGjZ3hqPczWC+n3XvnVml5xSrW3D8+a9vKl4fht1uyDVpmCHinmVwPzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mqv5OJsWRJ/nuPg9msDTj+R6y4xFfkPRJeNFsWEzzi4=;
 b=CiSEfWMcy9JrGscvpbImezL9Z1iOC52jK4ILKYZ9iV8WL24jEFNKzNKZDGgERXLPCVj/wb2vYpQUgTmyU3wOPh0+FLbsIM5Cr63nCbO1l+5yWtefeswXIG1QJmXquii6syeK+vT9Kgy2aAZQI3cLbSsi3kvrkQwNzcqrpfNWQTq/FWZH1amKWQwH8Udd7Sk5PmVGfH5fmrsCJwCbGGbuakkBwNwmOYNO3/HcPuSbCmVYzoX7KafbdMjL3W7vdsajeAPnRyroTBaXXkDLqCTvVrciUeOt9qAxFAgfwqKmm/Xh/spPZNmzeMWk8utXULJCBI/2Jkmp3wkpSz70V0MnhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mqv5OJsWRJ/nuPg9msDTj+R6y4xFfkPRJeNFsWEzzi4=;
 b=XJHuhGHgkUID+go709PTW+x8PyfkPH4T4EnXfB7OYAlOP/gdJ8XpbN27gmHzscJ6yiHB8nVpbzEm7A9STZlaF52knzAzjloI3CMS65SdA/byOrRNUkmhCiOpifbcSJOiMdm0kMPv1St5lI+6AhQ3Eohsyst+79hNmEac8CR4m10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6146.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:247::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 14:22:53 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145%9]) with mapi id 15.20.6064.024; Thu, 2 Feb 2023
 14:22:53 +0000
Date:   Thu, 2 Feb 2023 14:22:52 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: Re: [RFC 2/5] rust: sync: Arc: Introduces ArcInner::count()
Message-ID: <20230202142252.24d16d63.gary@garyguo.net>
In-Reply-To: <20230201232244.212908-3-boqun.feng@gmail.com>
References: <20230201232244.212908-1-boqun.feng@gmail.com>
        <20230201232244.212908-3-boqun.feng@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::13) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 17983992-3a9e-44a9-0a16-08db0528f8fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: coKM4qrmmPz2AaAeKU6F/r4AVBRw24A+9GnL3Msw4TjX90l75uQWjYpp65ROwQTuvm4wYWWDDh8nZKXKsfUHxkCmKNc7tQVkOXtmU3Dm577/oLC+dLtrce1jk1hkCrh/JS+YvhveDnV9M2VlIVXVRFo4c7SCuWn7Rf40ZMh7BbXIaqYo7K9vv+oInJcW5qdO3s0SZHXIKhMfKQSfFntchq8sdonMnNYAVFiN4YvI7+D4zhXLH5LUUgfLwK+bvnq9WGEy0wP1vkE9vhnQCeiuPZ8vhGQ6rhTSe7xUocbbb9YAexSY35lp+wUzhP+zzK08JF5NV9eEfekEJDs63hthedhyD+SD8KHbImddel6Nv/FlZ62UETUlsBBAfOxjZvYeiJ5JKwuWr1q2CmMA0M47De5V/fQiyPNenbmo8TrcblmlUwdKKgiUgpNazsuzLlA2y69Lz348Rou0PuChRLKHj3CxtjuZhAMJ9kr9ifGKyE2baqyW9KDounbMQ3rVVd7NaqWgwHEQT9bHchukAVRg9+226YZAYUk9B41tdQ4FRHr6zC29b4zELNo7gKtlo71fb5nHRauIJCI2zxXAKWjwzZuCa9mxr0+3QZCUcuUt3UvcSQhchZ4BU5pgJQmt++lk3VxkwZXC6yYjrT1iRDko7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(39830400003)(346002)(396003)(366004)(451199018)(86362001)(2906002)(478600001)(36756003)(6486002)(7416002)(6506007)(186003)(6512007)(26005)(2616005)(8936002)(1076003)(5660300002)(41300700001)(66476007)(8676002)(66556008)(66946007)(6916009)(38100700002)(4326008)(316002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9JKamoJ+HO+tTE2tx93SlNBXHNEfCO3PpsjgO0LzQ7VsX3IPwwbh4A2qEL03?=
 =?us-ascii?Q?f5ohC0Zz4mbhc7CHnrPufgkzM5FNRjPBAUjEpFnmgoXJWqzkOp2CYlSwaltt?=
 =?us-ascii?Q?9bBVf+eH/1nA04dzUN7YL1SYxqpw1JZhdgyHgQ7QHv2EUTNaiRtxeW8RNn+J?=
 =?us-ascii?Q?witz45HyfyBkrQGRtVwurqBczi7iFh8fOsqRp6vDKb79onVEYD/b3Tzs2cxn?=
 =?us-ascii?Q?2wuuoVPdvZW89cVTa+4T/M6I3xurCwBVcJl6ZEg1mbNgKk0wD5EXYZ02OeQR?=
 =?us-ascii?Q?YwVDnhOBTSQjnl30IRymoS0pYr8Fw1Lleiw/nb44oyFLQ7P0PaIEbHudjXn9?=
 =?us-ascii?Q?Lv+2ZIbCYYheaqZQhFER8eRh9lskvfb9qpLrx+o6+IaKuF2PJvILrrTxvHMf?=
 =?us-ascii?Q?SOCL6ImYyZf5dgdNIhXwkiv/u5RCts2PqONNKg8ulqjm1TeOJ9VyVnJZb9/l?=
 =?us-ascii?Q?zNcPhW/Sz0WHSz2iRQF1Ju5z7Vre7AfaUPxo6oQVdwycHV1z0T1GxU7HSpzF?=
 =?us-ascii?Q?kfMmaNvxEmEZsq6BFCVV+cDZgGwNTTLZ73AjtRPLaINqPFfrVHo1YP4DBb/e?=
 =?us-ascii?Q?Lzh2S/+p/XCcF6bUNtLStiaH6pTBpBo2sxIRVYNzdmb9NCiUjiMOcYl2jxEk?=
 =?us-ascii?Q?tVDU9LMVkI19kNpObn0MxK6EP5xMOA62VSsHt5FUpcG60+dW2C6B9j0TdTEz?=
 =?us-ascii?Q?TkMbbCV8vgMdYyaZSTSW1eOolSXUBN28Upucl4czHhEWIdxiEcp0N0DJocRv?=
 =?us-ascii?Q?KoCRlbwL50VRWESynSSmQaR96lDYxjVrxSNZ/1iMiJcl9xLH9b6ciZ/TSwTn?=
 =?us-ascii?Q?fTaZHCPrFpeusQo32l2Ov337bKUe2wcbTuP5IpF96cQj4Ox/cBOnX/uoGWPL?=
 =?us-ascii?Q?VGkDdN0Lwv3yyhn0MMqA2YrAmk4jM+qZxGh7NW41/loMFnOMFqCAb09hlDXL?=
 =?us-ascii?Q?hxsBErKgvFNTsUqjM7KY24J6fhEsGjA+PgHdnvbuESyoivbGAIjtq65+FhV2?=
 =?us-ascii?Q?SQSSSZr0RXRyNsqLrnnp4cjxUv1sb9r9ru8ipD3D+Gecp7xs7VtrNR02+mQ6?=
 =?us-ascii?Q?mAkrIz50nZ76sZZFyo9a0ffw0ILL66r1AoG0F9QVf10lk77EKOflt+TN1O3O?=
 =?us-ascii?Q?QqzYjqV3r4WfKYwm54bwPl0YC7ivPhCdQZlkHu/0KSOkZybwRP3UFlCu9bGW?=
 =?us-ascii?Q?os98NAo+4BxqhRw7alAJ6TyhFYTotx8QKRfz0XITqefBKKuoCLKCCGiHCkt6?=
 =?us-ascii?Q?ttZavOBc2ECHmtPrp/VThwYudenD5TdCswBMT/EvdVn/L6BKEM1hECfScEO3?=
 =?us-ascii?Q?UewDeWSm6oWQQ69ajX1RJlDoODEvd6NyZsd3rPl0+n8ovg/QXhnTzLd/xia5?=
 =?us-ascii?Q?24/3XeE1dMQQLUxLQk4iCjy2Y35zMD2PZufDKPQveC4JbeVGtVuT7QAIgGDq?=
 =?us-ascii?Q?ZKMZwsJ7u8WLYy38ldD8K69Qt9hIOeq2Q0BqNkjNpabjBvLpNCRPptgAu3fe?=
 =?us-ascii?Q?0mfXASBMW5u7VtuYIqX/NRoNcDPY1D38Bi784N/w6F+WMgudrAsU2bsg2+in?=
 =?us-ascii?Q?R6Xg5t3RltV7yHAosE7xVFxx83N44UlYHZRlE5Vm?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 17983992-3a9e-44a9-0a16-08db0528f8fa
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 14:22:53.8117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4bRSFQb9Ao8EjOYYMnfdGjmjugqlF6647K83ZCvo4p6NtRmYEncNTHf986PjGK3mpPi8nxfAcWAAPoiglWLXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6146
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Feb 2023 15:22:41 -0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> This allows reading the current count of a refcount in an `ArcInner`.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/helpers.c          | 6 ++++++
>  rust/kernel/sync/arc.rs | 9 +++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 09a4d93f9d62..afc5f1a39fef 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -46,6 +46,12 @@ bool rust_helper_refcount_dec_and_test(refcount_t *r)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
>  
> +unsigned int rust_helper_refcount_read(refcount_t *r)
> +{
> +	return refcount_read(r);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_refcount_read);
> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index fc680a4a795c..fbfceaa3096e 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -127,6 +127,15 @@ struct ArcInner<T: ?Sized> {
>      data: T,
>  }
>  
> +impl<T: ?Sized> ArcInner<T> {
> +    /// Returns the current reference count of [`ArcInner`].
> +    fn count(&self) -> u32 {
> +        // SAFETY: `self.refcount.get()` is always a valid pointer, and `refcount_read()` is a
> +        // normal atomic read (i.e. no data race) only requiring on the address is valid.
> +        unsafe { bindings::refcount_read(self.refcount.get()) }
> +    }
> +}
> +
>  // This is to allow [`Arc`] (and variants) to be used as the type of `self`.
>  impl<T: ?Sized> core::ops::Receiver for Arc<T> {}
>  

