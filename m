Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8796E7928
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjDSL7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjDSL72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:59:28 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2116.outbound.protection.outlook.com [40.107.11.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333F414F63;
        Wed, 19 Apr 2023 04:59:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgyu5BuHrlLlZAFS1tI/gCBFAQKDLXJXafe47D7mid747DuSOsUgRDjF7i8Hco/Hgeu2AUzHnqHL7rh45wsFSQnInq7Xq3K07FHfNp6OLH6i/HTEw6rada8HXLP+gL5sWI/xVtPFEXUEqIINOpO6u4/Cz278i4FlfrYnDAEobGaXdvcw/dBMxL2T0+wMkgyOzBhwW0EOzfl8O4PEWW6XshH/7DQCU5iSm/sugyPWAuh054IQKKsLoCHe4sbxiidQ3vd6kOlO5EmruWKOkZFlQaWKfSt2Xe850uUNXEBwnUvCRZ7L1UN0Lkrzt9qXKiDT6nyb5AoEiOXLRGJ4RrurvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImlHxZUFrY6g2WtqmlmkyyWT5hENjKYll6SoiVKZlMc=;
 b=DPpy8Q/WXMdv+6QByjMRPgZTGbxS+LNJLe5YLHMXcYe2+JcK448UA6rvInNV32rCwkYgMwV/5HAvcV6y1ZTA+EOfNOjKQvoS93AqcSfd1NGeMei7YBeRNOttD2kmwwzVtk6wKNcC65GlAHhcak1uvJ5ireSeAAeYQl1iqzHuuHGYl5kWfMUa9ghhUB3mbfwNlGKsIsX8igTmZSKsmtgPWQGCoJy28sWlz8nE1yMplwXjkLst3AAvaP5/6Z32anLUcXj4wgQb3wZa1TsKdEgk5RSLEX4H4Y6Z3cabhxdA8uIaORgRcdeLrSephWiKCeblhNa/5KEsrQILbYFcjJPXnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImlHxZUFrY6g2WtqmlmkyyWT5hENjKYll6SoiVKZlMc=;
 b=TsmJXUSOAlb27s7WWSUtLhxbUATKdCI9qAGmbCdI5N+ZE4+fOOah1ne4h8aP9M91u+TfZj/cSkJ/EFPE6OCmsb4cAqBW65pZoVluMlL7soogCg8/0ltJDjgx/iBD3XPTflxlxhI/7N0ID76zyPmNi5dq/pS6GWeURYxxPSTDkzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15f::14)
 by CWLP265MB6321.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Wed, 19 Apr
 2023 11:58:52 +0000
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1b25:7ea3:7339:6a0f]) by CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1b25:7ea3:7339:6a0f%4]) with mapi id 15.20.6319.020; Wed, 19 Apr 2023
 11:58:52 +0000
Date:   Wed, 19 Apr 2023 12:58:47 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Josh Stone <jistone@redhat.com>,
        William Brown <william.brown@suse.com>,
        Georgy Yakovlev <gyakovlev@gentoo.org>,
        Jan Alexander Steffens <jan.steffens@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH 1/3] rust: alloc: clarify what is the upstream version
Message-ID: <20230419125847.2083dbf5.gary@garyguo.net>
In-Reply-To: <20230418214347.324156-2-ojeda@kernel.org>
References: <20230418214347.324156-1-ojeda@kernel.org>
        <20230418214347.324156-2-ojeda@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0345.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::21) To CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:15f::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB5186:EE_|CWLP265MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: c7038cc4-daf7-45a1-7db2-08db40cd717e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z9Mmy5r8CgJvBHhLKxwnPlZb/fEgyTb3U6zxE2VmvgIi9Ugx+wS8ZxobLR6gXILzL/zOrHlOJHmljs+W7/2Tbnriixbnhz9hZEPikFd6QYZ0ZfkVA9JHTQdDBykmBuQGwFxIYkY0eEM9U2fx4n1k8zUBCpDTFLC/R85DETrfOvNiHERK8KJE+gOVC1lldAv10P1yimdMD7990z4MtA6QWcJfZahnf/1/PTcpYS+6EssRK/RS0eL0d43XLXb71bsJN+2bHZ/PJxcUbPBNVA2o8TmKfDdcNP53TLGZMiMy+RoZgu/qrQ+3KTxtQFdf4xqxAhxV/z7XeVoNGRRfTcsixzZtsVrqiCtnK9fXrrRLGLWUvNxywty92K5fGgcEzkrny6Q0VE8nAAz6RtaoN4xN4b1NG2EOz0YF1FCPDmzrwW2sxwumyqxe/8p5y42jPI/+cQIZlvWLjGb36NT/huevnCy8lvZ0UaapLegsh5fpOiWDuF+fDSBwm/HI5bE/mY66vHU/uQMxK9RaNMEgg1tJn4pFJ2DXXmndT+9izKqFeog2SfuToIG4PRrIWuInEktj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39830400003)(396003)(376002)(366004)(451199021)(186003)(6916009)(4326008)(54906003)(316002)(66946007)(66476007)(66556008)(478600001)(6486002)(8676002)(8936002)(6666004)(41300700001)(5660300002)(2906002)(7416002)(86362001)(36756003)(38100700002)(2616005)(6512007)(26005)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iQevyFEJ4DdW4n4Mz5YLoCrXkscI4u7ob2hrYQAjDQTbIhTrHi9PMPsDvSH4?=
 =?us-ascii?Q?SFOUJGozYF2iWnKh4isB5h/JlDU081eybO8AlO1uhb9xEpvlL537/xYxI9c3?=
 =?us-ascii?Q?pmQIORmOfjUWc8y3T3atxTJpbrK3+LualGA0WN69gnmvKFFnQDI7OMkrf2Z8?=
 =?us-ascii?Q?tL0nr9jFMHwEg+QFdhp72xeo3ncXwtMN82X18xYdLyiNJH/0zhhRh4OkdTml?=
 =?us-ascii?Q?DcDn6EAxZcCiZtS52T2qvahc2XSFT1CrmYBXbPy6nt3qvaSfaQW3KseT3Fkp?=
 =?us-ascii?Q?TE46gzyT4Y/sD8obOttisg886Uz9gusPXyMN+pqqCNKMWNJzRuwFItC5iNn1?=
 =?us-ascii?Q?9y+YvHdLlxjfqTF0ysSvWDxbQ/Qsh7rSCOlMOuGRh0gA0orWdD/UZDsixDY/?=
 =?us-ascii?Q?kRAHZEApmjUpgQhkaHegmfI8u1tI6+Ed0sAriF6/h+ftV5kJJs/yl/yVGzNB?=
 =?us-ascii?Q?H0Scb62xYFen7tKVZCsUuMRSj8xlU+jIcxMzUnppGhOqtbRn0Gm2MOsJJ/av?=
 =?us-ascii?Q?GlDhH6oIdT+QVf4tiMQw8p/vc+JLV5pZXU18uWhuKIGHKMQy27ducruUJ4Zl?=
 =?us-ascii?Q?9ur0F/quPts51huwotiGCWlwaISNqZJ9YLe7h6weJKL3vaJwd43434BkViWP?=
 =?us-ascii?Q?bKpxcNBa9AQcTDPG3M+IdMeYawN7/cFyGP2u5zeAhabM36kRErU/JS2cGvRV?=
 =?us-ascii?Q?poqMW8fbTn8hC05OHmqtKtcPiosNIrChx0IIb1DqwYMkqgkexuO+O8SDZZ9a?=
 =?us-ascii?Q?7IdF5cTGkgMKGtJsUV8nZESapg7i61Uv7qtsdul0Dmkv6gdeiwOEi5awtbkA?=
 =?us-ascii?Q?7fpG8f2fMeQqJz176NtrOtKoIONlskbJUgk9QSbadhUHUueCfNrBqevXxDfJ?=
 =?us-ascii?Q?sG1lzoE9lm4FJ4Rn24cQyTtcnXCxwsdPyn6CPOLctgE3hsObEAK+VZ2v+DaW?=
 =?us-ascii?Q?z4yUBtZW1Ls/BAdS9QDBn0z4Qty9G0GKYfQgd/q49IrbSN2V38HIKlEbm3fC?=
 =?us-ascii?Q?8kbHHv0v7CJvjYduZdbthrhz5ODKf93j2eNL+8BfUtAaz36E7+fqRV+1yUiW?=
 =?us-ascii?Q?1HH+KZSwpNRXIx/eARMq73h/QM67b0hKK9P7yc4yGQwJLmaHpTopNh3Cot2H?=
 =?us-ascii?Q?kVfbMeB9kk8lrv2iwSZofb1zU39IV4ixxYhUZm9oqWWvKKGuIH6B6lBCDS4h?=
 =?us-ascii?Q?ywgs+advT1d6hvhx44SxY22dUoL+P8fGzJTD+6KN29hBiyyMsnT/ijHEbatp?=
 =?us-ascii?Q?4Eh4kjuh93UoVAmxgR3hSXD7FpwIIxqKEcOmwAj76CVctzCWZa7MaQNaNb7w?=
 =?us-ascii?Q?9fWVpxXGL81XKHeJ/hnBNexMknd5oNbsnE1tU4LBq+6h0Rca5BiBty5QeunY?=
 =?us-ascii?Q?R+Ip5CIZHxBS5CHH/6iftsyjisbat4TDC2imv2ZZXoLULw/ke6DYpPtmjk68?=
 =?us-ascii?Q?GlWRynR91TyTg9j178UwRRw8ANAKsQgNqSt3FN6cnWYTbx7ONlueani+Uj0c?=
 =?us-ascii?Q?Niy/9gEw+17fOV8aWRQ7r2LNWQkfEyu69NVWS2Ee8ppAtHjzrpshEgICtFbk?=
 =?us-ascii?Q?2c0d7Vwf3Iz8SAarYvc=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c7038cc4-daf7-45a1-7db2-08db40cd717e
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 11:58:52.1624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3Vu3EBwVh5N/qItm++R602BZGLGKcwbwDffVVKwSMM+NV6k5BNRF6ltuhwv8uiKTZlPjjme05GXAG1kvuCRYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6321
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 23:43:45 +0200
Miguel Ojeda <ojeda@kernel.org> wrote:

> It may be unclear for readers which upstream Rust version these files
> are based on. They may be unaware that they are intended to match the
> minimum (and only, so far) supported version of Rust in the kernel.
> 
> Thus clarify it.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/alloc/README.md | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/rust/alloc/README.md b/rust/alloc/README.md
> index c89c753720b5..eb6f22e94ebf 100644
> --- a/rust/alloc/README.md
> +++ b/rust/alloc/README.md
> @@ -10,6 +10,9 @@ upstream. In general, only additions should be performed (e.g. new
>  methods). Eventually, changes should make it into upstream so that,
>  at some point, this fork can be dropped from the kernel tree.
>  
> +The Rust upstream version on top of which these files are based matches
> +the output of `scripts/min-tool-version.sh rustc`.
> +
>  
>  ## Rationale
>  

