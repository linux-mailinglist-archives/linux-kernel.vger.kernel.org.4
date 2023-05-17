Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AB4707077
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjEQSJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjEQSJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:09:39 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2139.outbound.protection.outlook.com [40.107.11.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B308D3AA6;
        Wed, 17 May 2023 11:09:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZVFjlP3SISlxwvHm3EQNrfr5258IvjUr3sG3I4zM6hcDq+Ndmj+uxat2m/XyLRrsi3d84luM7UoIb6KWEJAMo81Dkwn9INsPYETOWoj1n062/21gzXrPWDqnCsB0hk0h5WCeltMXYZi12AEqHx6wWi+DSP4GbshYlaXeXMvj68F8xbXeVwMCqW2GPbBGuHxR7EDBt1m5KqrGnzvIj9T4c/P9JW9OFSFyZ86iEq7Eusrvkx0YkahyCx8X3UMIwSpqCoSY9RWxCxJyDVnCj9Rm5DbCC37yZpDOl+KV3y5YLEwVQFgoozgF1xyPUq8vaClVXiD46KQy0yjQBEWYWZSCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aoD6iUoQxTlet9q0tMlS3w4YlWfO3l7aXZr0zltI/Q=;
 b=HN2baYqDzjPkcLIVS7uNviOBCfEgyExo01xRYx1cADn6y9dMMUbAFcjNn2Jcw6/9NbqntPpwv8nXpS2qzymLsxhDu7wV+wcyQFdiHq6bSKpSG81tAWsabSkFemV+rNg+hJ+KUVpfj0/JYNiSUU8EefzhNg0ROZKXS/UGnqaswOGo5goz6IoT2g1ulmy3cKn04Cs7YFG+pfZvR7XMHDkivTwQKAzdBFIXfkFfzWjjE5gzPO29VZyQ+hbT+7g2cxksDqIPcO/A2TunmB83uPWLFfU06t5vmKfqE//eoUA8IR86hZXw0KVaC1sUoVanUdkswc9Zw6Fh40IkpKR/Jwz0aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aoD6iUoQxTlet9q0tMlS3w4YlWfO3l7aXZr0zltI/Q=;
 b=CY32oo90WQ69pAwm+FnuL+XlQjizB3HTaQCAjM2fS8WcDryeNAcZFuHpMak/5E1zNKbcz3SeENerlgsht/E7xDjVCdBsDu4O6nEGWmJrrEImdF+CzwnkUQnUkXBeYbNl5cRoq+eZHvBGOuppf0CbBa5o8A3WuKQhrt8gd3Dh2ag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5924.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.15; Wed, 17 May
 2023 18:09:34 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf%4]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 18:09:34 +0000
Date:   Wed, 17 May 2023 19:09:28 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     nmi@metaspace.dk, alex.gaynor@gmail.com, alice@ryhl.io,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com,
        yakoyoku@gmail.com
Subject: Re: [PATCH v2] rust: str: add conversion from `CStr` to `CString`
Message-ID: <20230517190928.08cfa0d5.gary@garyguo.net>
In-Reply-To: <20230516111202.2455529-1-aliceryhl@google.com>
References: <871qjhe9xh.fsf@metaspace.dk>
        <20230516111202.2455529-1-aliceryhl@google.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::15) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: 605898e9-4e53-4843-02b9-08db5701de7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KNmTcBTNaT+9/c3t4KG11ueVR/B3YEzDjLzt2c8cDlljYDMNSgN+3DeaaBXNV6vFIQOZDVMJlPX3b21dziN7jbD7pBOWxIRdYYs0e4G0KOaPhevEVV6fd8KlBJ+xuufKM+LrWmDTWJfyJ29sZoYKP50b4m8ls6EV3WqK7ji86ryjXccJKUBkOi6yeUgqZ+h/ZDNPlYIPNin/K1OvEzCCIe27dzgwcxR7opZRgtgp/vpLN8Mov1i877UjC1w8jraMT2o3I4f4G2kxCSJBmnOKZbJ5T3uUJTcIXTJrgKFndqpJDTod/95dQM3PvC/5aQsM9kjZ6VKwfUClM8KRmt9l0T86BEFev4UkawQshbn0KLj+xgoXhI3pQtBPaMcyPbfCHoGAPEpXEYLvoaInhZ6NenGaNNC+OPsZgknAGcEjAN2DxhMu43sq+zqWk7hqlGFAyyu2Suz6R+QpOH9jYMOoSc8c31t4TwTcWWFgZNa86dXsFJ8qOwKLLwGk3DOCsXC+gZ3E45IxowN3baIcv2FwYh2cV8/bt/Ri4wKDrRimO5zYQI2cS0P8IFv/PEmU8FvVCoatq9eQp6bKznI/drMAcHKMwCd9GO6RsGs7Llnvp+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(39830400003)(396003)(366004)(346002)(376002)(451199021)(53546011)(83380400001)(26005)(1076003)(5660300002)(6916009)(4326008)(316002)(6512007)(66946007)(66556008)(66476007)(6506007)(2616005)(6666004)(6486002)(186003)(36756003)(66899021)(478600001)(2906002)(38100700002)(7416002)(8676002)(41300700001)(86362001)(8936002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Kei3ugsjkXB+occgRF798fxzr8ocn8Ox7iQxjd4befZYI4KHlPMEZliG4R9?=
 =?us-ascii?Q?gVaDPPRUjVLN1OR2HVPP+kVegMG5HgRuG/Wk1F6PjnzkptCQcJLIg2cfmR4p?=
 =?us-ascii?Q?lcj5CTm+cxg/lsoPePtESHCddHo5AId0fVTLpYwmJDH6zaq2t3mGnQjXAJUp?=
 =?us-ascii?Q?sUjYDrGryc65VU00ZhBJ1BX9thJ5wDdZcffqSJOo5NlkM4ZRfbftitv/uQyH?=
 =?us-ascii?Q?qDWv7En2d9yCTpPtLaSGzUp/xo6Wflg1iv0xCZxLCDJHfQykwFJMLp5FE9Oa?=
 =?us-ascii?Q?i9OhKWyYhFnzkBx/HvEDraa4Db6IQ36Oi5uARn3nMD1QaSAr4dnktSQgMH3m?=
 =?us-ascii?Q?9O7IPvtDgk/UYAvdb87QOBEXJG/bPk9Y8zki0ax6p18GfHafLObssV4MO1Yn?=
 =?us-ascii?Q?zWmCLAIpZ2yupRMdQy6LHKxSh823xwNMZmMydGQvSJIpGODTQh80edS0h4m0?=
 =?us-ascii?Q?tbA6+n6ZaGc2dv05ait7wCFYN9J4MGVm6OXJ9wh4Km6jebZTlsERPpBDmu/F?=
 =?us-ascii?Q?sY/zjKGIrf1cS8aOMcK22iI/5Tj6Vk4/osRZ475/tRWV4INIbIRxuTmkswER?=
 =?us-ascii?Q?Q/29GkGz4h2SPBrqt1dbKPyrWIRn1ZIIW19qWdlS/Qu1qbJ7NqAXhUe+N2co?=
 =?us-ascii?Q?v3tey/XdSctjcBBLueX07zb9HEgloCcNZAmR2L7LfirJk3x3zlu9bgm1IPRt?=
 =?us-ascii?Q?tYHgqFu+Qf4xwo7j0nK4DGhaBkjdfe5+GWf9ifZ1Ymd51pv9Zn4R2DUgsYbH?=
 =?us-ascii?Q?2FTSVi+ySnOsgRmX8FO4b0Z6zHoBSCcSJY9v9NLPv458mKrSKtf7pDuggT2L?=
 =?us-ascii?Q?A1eI2MB4s5vetrjkN+wbMSyuqUxiHXg8LDmf7RFdtG34M/GRmPZLh5YHAPus?=
 =?us-ascii?Q?8rtObsBdGLvWfbjyXbkjBuY6QFtd8l0V1CDaws8MyUjqnhqOKB+H3A320BSm?=
 =?us-ascii?Q?D4SupMNkmSHiQBqAMeBVAsDJ9qdw3NexWG1U5M83Dpawea4Ss7uS9WTMTHyO?=
 =?us-ascii?Q?rnR4+IMGxUr5XTRzGBI2YUPW5xHFF1l/O7he67b+RTXqSZ4cc8TBBZYSkadC?=
 =?us-ascii?Q?1PvlJN/vhZfFCVp41NFJlqAnTKUxlwxbMyb8GFA2w04Zro3unmBZAC1frYsY?=
 =?us-ascii?Q?rY9g0gOJB4Akfr7dnqjNhpCw9swVXWXcFjDKkIN5M4RhYJBqH+7v82Yo6Tf5?=
 =?us-ascii?Q?yGGNthSzPThOQmlqRNN4WkAinE2QL60hJxMmXvnT/8J3MR0svdCQm9ggZmr9?=
 =?us-ascii?Q?EOYTgI+P2YtxeIf/O1DO41rtQacQJlwpRYfi+pjvey52qekneDuDVLAM0JSn?=
 =?us-ascii?Q?z5mPpxDHjImSgwtuOCrsnb1QzYZE3CTF/8aDYGHyrCSGd4RsLOLNnEF5McvH?=
 =?us-ascii?Q?MYCREULOdoupFKjlbl5QANTXKJAI+tgiWi7Dxwz/aky8b6PzjzmxneZ3sQaa?=
 =?us-ascii?Q?HJEnbBoNXRRliFX/3fnS4tzyOEhnt9CFqU/tH7BXaOixWIvCW7G9shrVdMqu?=
 =?us-ascii?Q?37BdzO5O+gNnuCp+ZnbShmqI6ic3R2SoEeUojoXpO3pDVnyc7tvtKy5Eafgr?=
 =?us-ascii?Q?rCwunxEvWinQM83JKbfCo4wPv/WalO5CNkGNa1tE?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 605898e9-4e53-4843-02b9-08db5701de7f
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 18:09:34.4608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Usi9FDiEGMOoXMD2yh1on0yZdSakDbrldOeErqpJBoOtA+YeZUA0J7PdYDLKdBB258kLVE/v6sZ6bXTYL4UgzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5924
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 11:12:02 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Andreas Hindborg <nmi@metaspace.dk> writes:
> > Alice Ryhl <alice@ryhl.io> writes:  
> >> On 5/8/23 13:41, Gary Guo wrote:  
> >>> On Wed,  3 May 2023 14:10:16 +0000
> >>> Alice Ryhl <aliceryhl@google.com> wrote:  
> >>>> These methods can be used to copy the data in a temporary c string into
> >>>> a separate allocation, so that it can be accessed later even if the
> >>>> original is deallocated.
> >>>>
> >>>> The API in this change mirrors the standard library API for the `&str`
> >>>> and `String` types. The `ToOwned` trait is not implemented because it
> >>>> assumes that allocations are infallible.  
> >>> How about add a `TryToOwned` trait to the kernel crate and implement
> >>> that trait for `CStr` instead?  
> >>
> >> Eh, I don't think it's worth it. It doesn't give anything new to the CStr api,
> >> and I think it's rather unlikely that someone will actually need to be generic
> >> over such a trait any time soon.  
> > 
> > It is just as valid as having `From<&str>` and `ToOwned<&str>`. While it
> > does not add anything in terms of function, it carries intention. I
> > think we should consider adding it at some point.
> > 
> > BR Andreas  
> 
> Sure, I think its quite reasonable to add new traits, I just don't think
> it should be part of this patch. Adding new traits makes it a
> significantly bigger change IMO, and my changes have an actual user down
> the road.
> 
> Alice

Personally I think `CStr` to `CString` conversion should be implemented
on top of `[u8]` to `Vec<u8>` conversion. Now we have two
conversions that fit in the concept of `TryToOwned`, so a trait is
warranted.

Best,
Gary
