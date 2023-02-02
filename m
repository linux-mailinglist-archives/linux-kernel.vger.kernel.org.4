Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A60B688019
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjBBO2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjBBO2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:28:10 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2094.outbound.protection.outlook.com [40.107.22.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4467A1BEA;
        Thu,  2 Feb 2023 06:28:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1L9/nSOekWw3s7sSeKW9/vylC4oxKwCJWx0/M+R2fgmbr2R+SDNedhsPK5QoMXlavrqUPn4svqlq8dVnaGzcUR+8VOwqw6YNkgAAzgdOn2dOI9IS+ySenlLXeVCHIZLX7+061VCsKe18hVT2EFXKwt2lzbfPd+gumO4Q7d9o/8NMKLkm+yoTDFP94gahkqqJX2nmnUfg3cJBJwbTJI9dAFjCusKn0ovHP5lmq4LgshdWRcY10z+uk/BgGhDSwMITdcPLBvGBCYetwzgctnvUGcre9qUtLhy7KV8OgWTaPTS9YSoU2JtDwucZci7IATBVlGTmfMl8zB4x0ZoBnhD4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ExaAf5R9hwdhZAPteAmWue4M/vU3soZh24O60YoviU=;
 b=cJxIwSbwZt7gbUCjG/E6mZSrO77I6GMXMBITBb5IJHefptsRPh2fTMtj65G72N2Z1LajuyuZOt+oiy3x/bz3vx4HMjqFLl/ws+dJxeNIpyaTvB/3tjq+HUUDreuoL69ZK8xmlw0jIxbFfdo2nNNqbwdbtQA0QwlBDeJj3XN/EFBrJ1/hM71EcJY2iiMLruxkjT6pUsE9sLEYv9Ry8jo0yZ62f+RE2utsWIKGMW5/VVxVBLxicFrVuiVyomv+rt13IAeyamxVDKukqxjSODbCeAyj5N6p8fe/f0KJgL3lF56/rOyQ8XuNQE71k/UIbqP6ESGF/T29VUFtf09A0Bj+Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ExaAf5R9hwdhZAPteAmWue4M/vU3soZh24O60YoviU=;
 b=JtAuwI8b7iwmuYBdNesm5ziWJUbFCTBwF0I2prG0iJFusizpCGpcvZ//bIYtgsxbjSSgk12vpSjx7odWV/m1zzO3b2fR/3/qKIClCrbPqBKq5eDB3KoxSfQad/lb3K5Pedx3pkJxIHigTEISdgszR44KeczFkzmuO289PSajnRc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6514.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 14:28:06 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145%9]) with mapi id 15.20.6064.024; Thu, 2 Feb 2023
 14:28:06 +0000
Date:   Thu, 2 Feb 2023 14:28:04 +0000
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
Subject: Re: [RFC 4/5] rust: sync: impl Debug for {Unique,}Arc
Message-ID: <20230202142804.753c898c.gary@garyguo.net>
In-Reply-To: <20230201232244.212908-5-boqun.feng@gmail.com>
References: <20230201232244.212908-1-boqun.feng@gmail.com>
        <20230201232244.212908-5-boqun.feng@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0050.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: b95cbb85-541b-4f55-56b1-08db0529b310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9vsGpGJOczvwOnjDNoQsjYeY7zG8HhNRp56ziC8b6Pn2BRbkCmZnHQzFIg/J04xJZGdI6tDN64MQ5jzJEn4QX1lj4PB7fZt5yyyfGEKHaUYuSnxjs45KOsOQclht2O+lVYfn3wtKEvGnGjv732jO5RXpZ+D9cuFVfmpAbwbyfnvSdfu97y+7WjJD7DgiYRKDBiRDCdq/RKAWubLxPy1h2pOCFDodEYrlfOtFL1dO8HOjIrfsjkAKLAcPnnoZxxiajJJm7vKDgsqSM0iwpjRKrehBGvQAINVzW9R7I2SgRr5MuAmd6Wbd9j7T5oh+j1Qm4q451d9tjKQzvLSgITmVR8UW/rynIWrRbWVsCwLvxdz5xcJpe6449xWIHhN9TuhXos2U1lKs7L6lrlzWxjblFNF8QeCjxDvgwtPuPdcW77BrywDsoHAF3zi9sV1PDCGKK9tvbHmZd+iTN1ESGI/Yno9TRfq05rfcBI2pzshfrUBL6MWEXDERbISUvSKtzZggS0aw5s9amGVujCQQp8TSpUS8j9JDC8IztaDiJ1dQFpGEbUw7pj3iQGmkCPbLthJJlvPKW5Vr/nnKzB/cjP3My2aCC3gSQIVQnNFNaPFKqATC5kzay4QD2+0LvSk4gGV/F8+XB/woX74cpWKASyNZyPzXxDIUhoNx4O+Q3BOSK5Mbh019d7x6w3AHX9Yl+FIp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(39830400003)(366004)(346002)(396003)(136003)(376002)(451199018)(66946007)(66476007)(6916009)(66556008)(6486002)(8676002)(38100700002)(86362001)(36756003)(186003)(26005)(6512007)(1076003)(6506007)(2616005)(41300700001)(8936002)(5660300002)(54906003)(4326008)(316002)(7416002)(478600001)(2906002)(4744005)(222643001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A9fzjrSxGyWNHxowUv2TgYCQgUTkKlK1iIf0iOvpfYwMwzzur+t996prkG83?=
 =?us-ascii?Q?0DcO7El31VYAXbboy9rdhlbTbX8750y5eaFVRbHSZ+/nrWWj71uSe1Q2Pdfh?=
 =?us-ascii?Q?Z7NRg6T328UnIXWnUK/lAJxhABo8RQNHWI/hTj5jG91rWYQqRAlF2ctH2WLp?=
 =?us-ascii?Q?MoarDJ/8DEJWcsjj0ouqQaDgMXaKOXqRLtq/9Vce7TcgVfap+uOVfkyT7x1a?=
 =?us-ascii?Q?4L9Rfa6BhzGC5bfKPoXFCweDcJwd1anB+nG4KivyXouLwZuu8d4EkgVHLJSI?=
 =?us-ascii?Q?BxdNQtHz9vu49eVe81NORy+A5DPaxXBuIyEUdvnGaqvcg0wcfIVef+/zNOCW?=
 =?us-ascii?Q?qJwpWfMiFnKmzjkOMSbMdD54bim5A7TQaA0M6OkFElDsPRfxHrTFCw9yxqRX?=
 =?us-ascii?Q?SwlWRFtMbcvypaWhzcX5sn4p7e49WNB6fk1KpCkoPdMuBygiRxbO8q9CeBwk?=
 =?us-ascii?Q?FX8H6+8EhSQoywSaSrS/wrKMZ0lvFPAeGc/RuZzSILmBVBOngYhhck1TVoVq?=
 =?us-ascii?Q?2sNVl2mYqivfI0uoswiQzxgQuW44ufy2ppcfqf49DsDyrgGbVDq7iaqOg9+t?=
 =?us-ascii?Q?u5pU6Tp54OWiWEHnXif2LkSjOcdtLgqA4Luxi5OrKNLSEHQa1ggb+WgtlmO4?=
 =?us-ascii?Q?onEwSjbKSGPXyzC9H8OVEhWaRQws/0NzAC4NIpTcfCWaYxaoz13YpLskNkVk?=
 =?us-ascii?Q?+kzXkrfRuEVA/lHlsrB6KNC+qNYKk6SsV03nNE7/QRHmbM6im5Ie5Omw4UX0?=
 =?us-ascii?Q?SNv1+Kv6WXlQdXOA6Sejo0mMeQN7o9Cy6wfwkOxX8YkXbc5INBEamiOoS0kD?=
 =?us-ascii?Q?mpv857J6/tpQb9hRgB8BeO3CmakT1fDOLTklEup3qvlVR7kehsslj+q9+XFc?=
 =?us-ascii?Q?7aynAbinmpb+n0WpyQjlavW6RR3WBU6POK8WCmKZ73jOOkR1Wf45DV/NlkdW?=
 =?us-ascii?Q?suq34FsfzAJ0iknPSQD0r79r0RZTqYR9g+RREoYQe8n7Ji2YML8G6nmRs/oy?=
 =?us-ascii?Q?t95H30Rq5Q3nqh+oa/IUayc3xZLCIAPAeN7VdNwfBsOQuclL5c0sIGjo1C9V?=
 =?us-ascii?Q?7V2zH/id5OaxCnvBeZ61rFwi4RwiRO1g00BWB0DBYFNB/k5RlAYustjZPn2U?=
 =?us-ascii?Q?D/mVHvL+KBG+UXUztkqM3y5v9WYyPaXMA6FjnaogcxPYOtV2OZIp23F54LU8?=
 =?us-ascii?Q?sTbDkg7Q3l08zfxGkiodtPt9INZr4QeY3km74iif45Y25w+lkdHUjhmIWigP?=
 =?us-ascii?Q?RpqdDuHxf3YiPyBo8u457QUIYSCu96ScOo4L3tncURbv0VQxcGBJhptaMLxO?=
 =?us-ascii?Q?HOfYR179TSLgyKV2RBp/4XuNBgU7JuBE8zrUUbnjlVpOK4Fs4IZTFVb1b0Q2?=
 =?us-ascii?Q?p/hQpn3bjZAC0Z4tU9K1B5vj2WKbGFsqa1Pqu2kTzmvWCRFFC2ujx+0x0W52?=
 =?us-ascii?Q?almS9wMM+40obiHJdoWidUh9xOWuwkseZBLI6smo0VYNfipdrcxcUWm8MinW?=
 =?us-ascii?Q?JSJH5I97njtpcGRX4q21brOLqD9qar+zfbJ1P52wZfj5jHIjZ3GxsQEXrEXJ?=
 =?us-ascii?Q?ILw4MAaysg1/a/G4GBSIThMqw7kHGqRjJ5IFGSNO?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b95cbb85-541b-4f55-56b1-08db0529b310
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 14:28:06.0453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fww4WGK6ihb4PFXhcrAIa+lei47hKw8UF5HomNRBfhPZS575S43TR5HgLBdwFduRswJpKyyxTzpfMRusUOxd4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6514
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Feb 2023 15:22:43 -0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> This allows printing macros to print the data and the refcount nubmer
> of these struct for debugging purposes.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/kernel/sync/arc.rs | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 4d8de20c996f..f143d8305c36 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -474,6 +474,7 @@ impl<T: ?Sized> Deref for ArcBorrow<'_, T> {
>  ///
>  /// # test().unwrap();
>  /// ```
> +#[derive(Debug)]

I don't think this should be a `#[derive(Debug)]`. For `UniqueArc` the
refcount field in `Arc` is useless, and we should just delegate the
`Debug` impl to that of deref, just like `Display` does.

Best,
Gary
