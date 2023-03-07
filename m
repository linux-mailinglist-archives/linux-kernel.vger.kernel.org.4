Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9A56AE73C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjCGQu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjCGQuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:50:03 -0500
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2097.outbound.protection.outlook.com [40.107.10.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50AB9B2C8;
        Tue,  7 Mar 2023 08:46:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1l0oME+aRPg0HSfjZxkOY7LXD+61cNyqKlyn+jgwR/g4AHmxBsPXqWGRMZ1X8KefmlFFbYH4rGJsYHaPHUlK0LMflx5+0dKuFKWFhlfWMLpKtcplIgi3RELXgcogpfO2PcslKX4Fqv7zQEd9Q76pq5pmsFUI0AlTOo0zrCg2fSJLzVkURI4kl0Y4Yu5H7tv3XxxcpcVsSDl0+vAgA0RHs16hMzP/UoV5o0BGfjokoKeCwgjzTC2MmnieYlQtLpQ0b3QQxGw9a7taI6t59GaC87/Ak463WgOyqh3iLlbD9Vsld7f1AHefsyFSV8ND2PLl88Ph/7IQzRgd7pxRElFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heP5NZ8PufvDTNcfTvhBfVFUtD2ZlfINDwB/2R0lTAo=;
 b=BlPgQAevp99psX08C+rodt/JQb1iQjyZmmQTGJhpdtsdo5j5Me+RASNLBJRa3unjfRYr0ubDgKIENA8IY0RTKwPDos2TVZXdXFwz9jWVNjEFqI+wvtDNNrKx9HVf4ZbAIkC6Csax3zOmYBXzGx/z9Fgd2aW37IfCs66x29g+E8G3zg+MqJWolAKaHgEJcV+isyzYAlAUQEzQ6I/3bYE1PhDRPbdqlGx0tz/9NQ5CGEO1s6U3pqT+D51MpfVKrAZmHpSmE9xR9CC8fG9gSuvfjwNDglr59SOy/nYplm5X2mPYRi7WPUHdDkXHP1EVLz3/GcLLF5O4KB7epCdIvkLAvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heP5NZ8PufvDTNcfTvhBfVFUtD2ZlfINDwB/2R0lTAo=;
 b=Tibr+rss+ac+JBCgzzNKMh1SRkcB9EznGs9wJYCTizcqd0I4Fuv2ZbHktPEMKwSfEeVbL2zvogg4J+SJT5cSFiaFpAC1+VhRAIoS5FCpm8SOWTD9jo2qm8+f9eMojbo5+Erv/koob9bar5nIxgTdhZKXIWZy3+orFl5ynlRXTws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5819.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 16:46:04 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%3]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 16:46:04 +0000
Date:   Tue, 7 Mar 2023 16:46:03 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Daniel Almeida <daniel.almeida@collabora.com>
Cc:     wedsonaf@gmail.com, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel@collabora.com
Subject: Re: [PATCH] rust: virtio: add virtio support
Message-ID: <20230307164603.686281dc.gary@garyguo.net>
In-Reply-To: <20230307130332.53029-1-daniel.almeida@collabora.com>
References: <20230307130332.53029-1-daniel.almeida@collabora.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::11) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 2153622e-9c78-4d07-29db-08db1f2b7140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J3sGosBZ9NrU0NsUxCbUlqNjhrctzTXfblVjxW3whGT0Ta//POvSHnbZHOOgE3XjA8GnDpBa3KSAKL2nPkYDdecn/hdhamm2iHYl5qwafKJFJFkpC8W/cT3SHUSbf34mh0lNKBLkheyGWuygI4BzXvvdqAZqVdJQmpVrLsijhFCF9dF4fbNxV6nt3ZHd4T6NV1fEnY3G4J+/e51a11T0vvmTzF7Oj1Ga7D7e5GGDYKIWPgRqnljXJancp+X0v7MTlke9RDz5TKbbHw7JEc60QJWMhyMvahq3x5s70cmB64mXOA9aLe7yT7nouU7KZFUbR/cVF4OLeJNXdTufoA9LehQNfnLJDubXYmrDxD4/6riWlU17gUXoiZALDtZndxKdu43uXWr7L+KG7/tVR+F0sZ/6EftpVeIzCqpLKiwR242RS7/aGg1sJSa0GSpgvY5bE8GjYXTp/oLd94IVvFurxKYkUBrw77jZsnn9guBveGdbF5SHaskXuNzVCMh7x7anvalZYnH752ylLN1UqJYXwt9sdL79zSgGVOF72AwllWvAmfOBFMVmh3/2Kpe5hlyncZqP850JjNYLVFzVSUVDQ4VPZglf0KdMJzJpz1m2lxdkWSkaghPpT2RfJkdHSyLXz0A5ogcqtPbexvBxX6MrlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(39830400003)(136003)(366004)(346002)(451199018)(4326008)(86362001)(36756003)(8936002)(5660300002)(8676002)(4744005)(6916009)(41300700001)(2906002)(38100700002)(6486002)(66946007)(66556008)(66476007)(6506007)(316002)(478600001)(2616005)(1076003)(186003)(26005)(6512007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OuQ8ecx6RCZHbH5TBj3WBhdNOtzwzVZ1Y/xHt7wT5YR/9t8ApKEYL47WxxCK?=
 =?us-ascii?Q?wl+9mBwwVOGo3wFTYWCq+oCD9bIITU5n9xFVm+daL7EtX/RhGAcbhy53H5KL?=
 =?us-ascii?Q?SaE3PiLRBrHWztEqZcDG3D4EgyuS4Zd/ebecoUYbwgWgQB3FuGICZO/GI9NL?=
 =?us-ascii?Q?P2LXx5AGG0RwuaCIJ9qVQ5E+WWKt/6iGsM29wJ1fBmfxiPxX/C0Y7TJ6L4r0?=
 =?us-ascii?Q?PUXeszOp6AHIAKbov2ShQ9ffQnfjKIa5xXxtbmo67bXkNSCiUo3dKp0kpHtV?=
 =?us-ascii?Q?xq4jTmGiZnRoqKAakvY5+aVtkyXcBQvIx0jH5dwjWRN3vC4HZ2e3sT+tiJCp?=
 =?us-ascii?Q?eQ6YWAry8TPIFRfdv5nUWk++RRA53ELVBuEZBuAlf65pUDt9s7I4N7Pq2Xmw?=
 =?us-ascii?Q?8p0mh4mGXFul0aJbHPaL1wrjYDls7L7movZt9LtaHQQh9XfDF7p6tEtNwrZU?=
 =?us-ascii?Q?qxleuh6bOGjcGJSvvW9xtoeFZoUHTj8H25I6CqeMTy9BD/vy9zRwIvKK+ki5?=
 =?us-ascii?Q?mBM4bWEnsq9NyodyCU/6G0UTAXYuaJbp91lollRAyJMOOCWE1pj58Xc78PJ/?=
 =?us-ascii?Q?tKcl/WhKeNNOoDD1QmQDNv0cE2txS8BmrBcjslHQIkwOCXOvZoKPUYYr7geb?=
 =?us-ascii?Q?zcFRmAHLatwf1S6i7ri9O0MSLyWDddIwhZ5QiyODGhgXI7MAj5ag7KThQlDf?=
 =?us-ascii?Q?UnWBLuw3iRFz6MftnKdcN3+dkFlFS/MmB2S9ZFm5dHAQ0H4jgChV6XwS2GSD?=
 =?us-ascii?Q?oQ/sc5mcVq23tUAAUQsObTxOPVmxe/oB+UOQ3z/NoPjMmX1/xR/ENOK3KObL?=
 =?us-ascii?Q?AWzfeIsy9fWH62aYJQttjGtNcN5CL1ZZ0mkCTKdmKPezBg7APg7Z8e/v/+Zb?=
 =?us-ascii?Q?W/WZXaPi3nWeMEIDWer0FmDMJcHiCFzzvH0y1BzUUgXzVt2ehxRXDbFbQ7hg?=
 =?us-ascii?Q?5hjTVaUmgrXkEWb/seytHq6T2VE1TXUIqezRsb+xOvhwxR73kwMaTOAs/PLT?=
 =?us-ascii?Q?2PwZzPPyIb/aweLg1Ob2IePK1CmF3mP3cY0l6fVurIL/kMaMLELwHW+Lw43A?=
 =?us-ascii?Q?4mgFOxRIAac4XzNAD14zYDlTeviQU94/U7PCpEX1sSAwCc0QlbbN8tdaZd0O?=
 =?us-ascii?Q?hYhW+AYg6oTnIBqQQypQHrZWnY0VlmyzHVTaNfpHeMzqvwnDvVfR31cqIkfM?=
 =?us-ascii?Q?f5wHPAURaF7djAvkbHktsg13CQ+qblKqB8vgZLd0VqoObM67hlEuZK7ElBoP?=
 =?us-ascii?Q?1Q8SbtlevzH6BZvZcUneXOOPf/6AGtMfgbkDAAOMO6cTTlGKiOVRotiWyEM0?=
 =?us-ascii?Q?V+9XxN6gYJAZfkKwooyYK4yv6PiXZ58L+pYOwZqmXssyYDS2gcL6nrBDnnYU?=
 =?us-ascii?Q?dSSOriOLO6k5fP3UqkSJwXgATX3b2m8JG6JbS1HcGpBumCDMpYIvLSf3lmUF?=
 =?us-ascii?Q?+0P1tCqEWcJY+IzBpQaPP6TliG/yTwDOcNyP9o7hwkk6CkLcs9zRuRjk4jK/?=
 =?us-ascii?Q?JjJOP2uOWYjGDULNgkGoRKL4X9VMLjsuXKvLbORWajE7DHGG+IPVzr2/ss2l?=
 =?us-ascii?Q?x5C6tfUz7V+H70MYMn/RycdqiE/DCyjocHppkFiq?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2153622e-9c78-4d07-29db-08db1f2b7140
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 16:46:04.8548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGhRuEHpp/+2vM6UBKd7mNdX/Z6k0rsAUvgayxdCxxudMa3OQ4k0PpyQfpNbuyx7XHVs+3TU+KsvxuoJVfCDVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5819
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Mar 2023 10:03:32 -0300
Daniel Almeida <daniel.almeida@collabora.com> wrote:

> This patch adds virtIO support to the rust crate. This includes the
> capability to create a virtIO driver (through the module_virtio_driver
> macro and the respective Driver trait) as well as initial virtqueue
> support.
> 
> A sample virtIO module is included for conveninence.
> 
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
> 
> Ok so this is my first Rust contribution here. It's part of a virtIO
> driver I was originally writing. Both the probing and the virtqueue
> support in here were confirmed as working in said prototype driver, and
> the pieces were picked separately into this patch.
> 
> Feel free to point me to the best practices around Rust patch
> submission, as the C stuff like checkpatch etc probably does not apply
> yet. I did take care to run clippy though.

Hi Daniel,

This patch seems to be based on top the GitHub rust branch, not the
rust-next branch.

Best,
Gary
