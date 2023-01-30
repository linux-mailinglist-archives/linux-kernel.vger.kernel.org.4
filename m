Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E987D681989
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbjA3SmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236122AbjA3SmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:42:08 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2123.outbound.protection.outlook.com [40.107.104.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6BE13DD9;
        Mon, 30 Jan 2023 10:41:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9O6v4qm+hOqJj7GES4mjzHknuUHUUhxM19qyGsHHnALI+jB4c4hNu7UFMbUI2a3r94jUz00GMv0/tVA/jYk71IlsZqD+SG5ZLdfzbm2Q0Kn19YYT35eml1SGbAZ1W00eZJWPXgQlzBznSRjmT33kU90NjcLfkApni+5MUUCw6P9bYDE+/SlOCdolwpkppGLv8k0pChCg2xGoTSvjIfj17/OqusvVjdHnD3aa/Vub1WpF2pfeN03difs8eskjpp26N4PMAyWiOfw7AR9n5iUOXBeELKaIm52MLDJosgRZTETZRCe3le8JusAWOgmcUUlYPSUE1TvDYxPlJPk5S8k/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twEehz9aSLZ4jvnDk9MCgZx2FTFEX2gPExoOj1/Njc4=;
 b=UZS+7SjvP7OaWi7HBloR0J0TWI/RoP3Q/a0i90Qui4kkFyHivXgn9dqk1Xpy4hgeRhlgyoLHKx+bayUUkw9Pbz0hKWPOwaKTlmNFcj/7vNFA2nB8DBL+yu6bcx4fwmc6KQk1YF2Pv/1Fk5Tey+bUI1Nm5pdVyHY0j5+5F1OCbqdC2yA9HKFsIPIaBK1xq2RcjpGV+p9D89xJz3KfpPasWRf4i+u+Wkq+dzR67XQLe+ZXW8jgekXilWBg7RLsbCm3X+S0qpfXcMRJBRb4BrLmCkekzecBGfMKUpdmAeRVc1szDKkMj4G/b18Riswar47IGxIKFR0fesHUx5Z5FrGKWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twEehz9aSLZ4jvnDk9MCgZx2FTFEX2gPExoOj1/Njc4=;
 b=Gewpyd9Qzxi/bngmsIN/uNiFP6R5a7OC6zHMhZYm0l+3HYv4AoDK9CJWaX/0eMkflKomcVw4YjTnSi9MRSK3ai+pxCYVdwQe46uIMjf8hPiH5c448zQibGqFZlPC4/tCNQwOAeWQt5xkywIwUb5rfHfZduivd4er51jvzEAQh6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB7029.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 18:41:56 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 18:41:56 +0000
Date:   Mon, 30 Jan 2023 18:41:51 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: Re: [PATCH v2 4/5] rust: types: implement `ForeignOwnable` for the
 unit type
Message-ID: <20230130184151.651303ad.gary@garyguo.net>
In-Reply-To: <20230130064404.744600-4-wedsonaf@gmail.com>
References: <20230130064404.744600-1-wedsonaf@gmail.com>
        <20230130064404.744600-4-wedsonaf@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0071.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::35) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 3330ee5b-a3d0-4be5-6790-08db02f1a9c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H5hZFSGCjQuQb0D9YKsulgrCtNzd2Ld0S2TnUjmEf7Yn6L9+IZB14IPRT4yURCTZj3evAfILkH+jCj2MkRuCmhh8x5dEqEelOjJSRDQiClYEmIFyDAyq4mOwc1v76//Gef+npafmypsekF3o0rAL86VSwf+vMEwe4B3OrGZdoGCl48nFRnLSzFLZIQX9dJ8Gxg80ehTYr36Zja6l+WvPLDYJzKUKPblftSopZ1DrfnuO2LovWMj9L/np8QrVzUsyVI/aScjNcH1PgGeatZV/EGzmuztSLhVJAFGI5u+X5eDedVElGPibg1L6aRhvzqPrV+ikxHflfbMKmJZZpelu04RepMea0dk858lJwOTNa4XrwD64XEeDRmYPBkhdXIRogaMHxQUHJ2TRvdBvCJNEOmfIs1hXzDRopD0+UgWONIED81zkubTTC1ZLGnS3sYZW1xBySa8x30nCa6271g6GOfUVu1HEecfwqD++DceQyac4sg74EPLvvmGHd9oiuUylY7IcGJ5uT4FTQBXI/PgikrFMAgrbXcgHwlmsOpCWxkYuEvwAv9W6LlldmKDhftQZXMDJNciAKgaySczKwFZv3ngt4Z5DagkTeZXcBP3TXp+pqzgYuR3Eq4Y4FXLcRR1G+RCLM8iTpemuzsxVjsYAPDw5zyX8TYkFb1detk6MOuCx0IBmVIcMChUuU33RCUkc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(376002)(136003)(396003)(39830400003)(451199018)(8936002)(41300700001)(5660300002)(66556008)(83380400001)(86362001)(38100700002)(66476007)(4326008)(36756003)(6486002)(6916009)(316002)(478600001)(54906003)(8676002)(66946007)(2616005)(186003)(6506007)(26005)(6512007)(6666004)(1076003)(2906002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4gm7+KoQegXdA2rboQWiSKXT4h8ijCpZYZvjDpDWH7/0qOL04e8z/yJSxusd?=
 =?us-ascii?Q?u6vcVdcYjXLQmppbV9KFpT4RG4WDcW2vDVoGBSdAGwMUvAYx7jD4bsOkJ6tv?=
 =?us-ascii?Q?+VpuRTwLgCQOIccPKb7kK0ycjAOzLx+R+DRfqpqGoO+W8NxzJTWviLzwqgFx?=
 =?us-ascii?Q?jWRk+kDxDAmD80ecr7O9URhlJCC0ssnqooV4tsumibnbMp48GTlbKaMMB6rB?=
 =?us-ascii?Q?fHmnamFElz0m4FE6EVDjAwZU0W/0SkJwpmcY0mnZVZeiWXbb3+7f8jwiOA/d?=
 =?us-ascii?Q?RQfROA13e4DLqgNH1JqJ3Yo9aRMVF1v8yh6CBfCZItq5IAADfymSy+vM4OMq?=
 =?us-ascii?Q?KVSP5myPwQ14wK6YMllkJNX2keDIFGzGRnLOyh04PRMfLLmkMc0VJ83TjY3h?=
 =?us-ascii?Q?hdaGXSC6iBbO1rZhb4Brkg911hjb5Eu+10iNOPPhQ+DGAQiDTCBX98H3YjOM?=
 =?us-ascii?Q?v+rUlzcKSWNbts8LUBqQ4CeixJNsy7ZTIJXSpbWjoBr6hdIyB96niqgOLYlX?=
 =?us-ascii?Q?4kDA91Z+mQddTnNiX37uj7SNw7OGuqY0eer0D7inhOpefR0nvtB+H91z54gQ?=
 =?us-ascii?Q?kKftFOkPleRUTTAQGJQxHMZchiFE+thBzd4/2KPRMkskQy1N+gbQlNn54RzJ?=
 =?us-ascii?Q?vTwaMEhwkPvjDE62sH8SE/VUlr/8ljNt+0MuMXLC/Ci1IRmAEkrMMGSNXez+?=
 =?us-ascii?Q?I6YGd+uy/KlTAF/uaamNpDVWSKy0jZB1U4wtHLyEA1udUZ3d7nom5J9ZM7JG?=
 =?us-ascii?Q?EyPEcRT+5bydmxaVx9HlT8YdplDlqHgX3Qbn/OU84L17qCpMUGo0J7CWIfEu?=
 =?us-ascii?Q?bZ2f1zr9/wBiGz9xZJmsJrAnKEMd48dGe3icMAkwHEYbguu8J3x74GgdHiH3?=
 =?us-ascii?Q?+VV+cOYlV+INKY7HD0M1WrQwgTjuxYOk1kC5iA+DR5sd7uNSfMMONLoQyTXX?=
 =?us-ascii?Q?xLQVFOBkBBV26v8Ja8I8fZfFQ7YrteFVSJKjr6X6pweFhh9Wm7j2I7/oXGbH?=
 =?us-ascii?Q?HKpNczMmrg0GaTatiNpUqFghx2p/nr5lsmStLaEet3LiJLQQR7aNXIAN2PsD?=
 =?us-ascii?Q?gDC5c/Kj87abGD1zNAI12KSyYhEISr+6MWE+cZjso8e6srJVmilYR6i6lHrW?=
 =?us-ascii?Q?1TuMN7lm6zcqOC/Ye/wD9pn1YHq7Lh49LdwoC1JHEZ7B7Jhn9aVKLpFq1mly?=
 =?us-ascii?Q?nTF6clLyZGuYzv80OOTE1dWQAFHZBa+PnDZixUIXV/FV+W9jAj8bItmb8WtT?=
 =?us-ascii?Q?FjMt2XzpNTpd82Zxqb+jDw/G1c2RsqbzGeu0iamxxb2daif62xdQ3/B2hhW5?=
 =?us-ascii?Q?dmdNK7cmNFJuj6TyXJ/MxxdY65hQwETixkvrMA4Ry0tjQcgwfHy8nWGZq5Sk?=
 =?us-ascii?Q?eKFJbgoST2kjlFHso7PrRIurLlzuTeG9HzRoOLcYVrZvNkLxdoIMpjP1iT8M?=
 =?us-ascii?Q?lATGZ9W7f2LTQhnPh4pFnDim31iTTPanFX7VmCFXqzKQYLaozbF75BVmS6Uk?=
 =?us-ascii?Q?N9yexWrtDKhsL/Yh79dIxJeD/ILjv8UaC4NEA5h/tuyoUzQvZlhr6oI5OPvY?=
 =?us-ascii?Q?epJ5N+GkwoZBVSmuh2hsALtka5TvdEFou9M2b6Lt?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3330ee5b-a3d0-4be5-6790-08db02f1a9c0
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 18:41:56.2639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gL8Wtu4I80e5fZF5Y1mkbsfLkyP5GOGWOq6XHoV6DLSsZaHLoW6H7zopZh3h5Y4N8JKNn8RAO+KbV96NBIcA0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB7029
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2023 03:44:03 -0300
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> This allows us to use the unit type `()` when we have no object whose
> ownership must be managed but one implementing the `ForeignOwnable`
> trait is needed.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> v1 -> v2: use `NonNull::dangling` to generate pointer
> 
>  rust/kernel/types.rs | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 411655eca3e9..9d0fdbc55843 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -85,6 +85,18 @@ impl<T: 'static> ForeignOwnable for Box<T> {
>      }
>  }
>  
> +impl ForeignOwnable for () {
> +    type Borrowed<'a> = ();
> +
> +    fn into_foreign(self) -> *const core::ffi::c_void {
> +        core::ptr::NonNull::dangling().as_ptr()
> +    }
> +
> +    unsafe fn borrow<'a>(_: *const core::ffi::c_void) -> Self::Borrowed<'a> {}
> +
> +    unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
> +}
> +
>  /// Runs a cleanup function/closure when dropped.
>  ///
>  /// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.

