Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D45069FC8A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjBVTzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjBVTzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:55:48 -0500
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2133.outbound.protection.outlook.com [40.107.10.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E67516ACD;
        Wed, 22 Feb 2023 11:55:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbS0sIDMUFr3Ap8pQGsK4ti4bGn24lLry9gDmUCxufPzKCvf0Z/SDUGVE7twpDBTZJ4X3KlqNKcvQHO7XUFnWbTIeroZ6EcJZFFPgjMovZnDZWJ/lEd6Iusrdn9iIZpzBpsXECfjMJNtwXXouxBBD/PibqssUjfrfJ7VJSFH9c4CTtx2H2iNmYtywk7fLFfLzfLCvRNjRbwRwNRkVZMot2/gOjDmL1MUGyXiNT8qr4BxA/2bcX8kmFrPSugiHj8TRKedJapdM1LcZZONkV4Dpcceo4jI3dKpbXoFDaLFhFC5V8FCTGaEPN7AhzaGKJ17K2DG9BoStZAZVQrnUd36vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SN6fJ7hGgUL5RimHHH1l5kkeJHYu5D5U839n1wd7v+g=;
 b=fCzSgLzO5D3U09jLRcMefg9STkB316oj2kW5zyTHExiMgVdbNNQT3v6fiVVaf0UPkCx4FuF5QVcLtE1eIOFwdjV24kHH8V3K0jainpMywQ7zsy/y3E8wiyVHrELkEymK8IdBnJYt6fvg0F9d6Hku2euTAX6vDofv0c+Y+cV/ypn0K/usskv2MkzZaD72VYJlu3qtdAkaZCuqojdCG+f34MqRp5cMlwGHagAmQASGunYWSVLZlmNZbJlhkxn6LCWeZPz4TB7QEbJP+WXqxAOCn7zvR+UVM/ZRZCMcw53OdbbO8Chod85jUQVuzzZZiidrVMRAkF4JG8tmUEJdrMVmxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SN6fJ7hGgUL5RimHHH1l5kkeJHYu5D5U839n1wd7v+g=;
 b=l+lczL12M7IS6T33jyoC215tr+1k5bWEbCY85DFFMngJ6cFAP/hwCOjv2d3szkStjfIsp/IvBAEQirBcuGoYb/rAzKauBOrHCGiUwa31RTlIsb0NwEm3p1Au2jbBQlNSFqOT8ge016/Pk244ZPgs8TQcbQZ2biqaIZmd9Y6URJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB1889.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:49::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 19:55:39 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%4]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 19:55:39 +0000
Date:   Wed, 22 Feb 2023 19:55:37 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Heghedus Razvan <heghedus.razvan@protonmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Asahi Lina <lina@asahilina.net>,
        Boqun Feng <boqun.feng@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH] rust: time: New module for timekeeping functions
Message-ID: <20230222195537.3462c1c3.gary@garyguo.net>
In-Reply-To: <p7e4M5-kxxScH56bBMtlzht2_m33oSfMPHtExSVbDn0WIPYBEbiJjr2NvNhqCJotFhmYqH5h27EWPDhfSmmST0D-dSU1Alq4_BzDQUR48FA=@protonmail.com>
References: <20230221-gpu-up-time-v1-1-bf8fe74b7f55@asahilina.net>
        <87v8jvnqq4.ffs@tglx>
        <Y/TP6as7qqwfcI42@boqun-archlinux>
        <87h6vfnh0f.ffs@tglx>
        <7b93bf74-abdc-f8c1-9a12-7c7f080f9e19@asahilina.net>
        <87edqioo1e.ffs@tglx>
        <p7e4M5-kxxScH56bBMtlzht2_m33oSfMPHtExSVbDn0WIPYBEbiJjr2NvNhqCJotFhmYqH5h27EWPDhfSmmST0D-dSU1Alq4_BzDQUR48FA=@protonmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0244.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::10) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB1889:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f130720-5e06-40a4-dbea-08db150ec57b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ur8RndepwNhCSuoR/4FapqBxKBQxLgtJ6/9p/M+HWA6w5AvSYqtQ7Eq+6tqj4gW+nGGBjLd5mzS5NTPxbQtR1NpQqrqNvaXN7lNoieI/MNuKKx6RggAHwVoYDzKWLCgIWIoG2wuDq38QA6JKEURCYgUaKYoG8DpfOah4GT+lgkg8k9wDBivJb5W5/oyxpaXIKMscPpL49oGS8ZNt6Hzzm0TLLQfrtT1mYq4h7IhxX88i8BcZeMKxSkcryxj5EWrvqWSXRzf98fe0sMtW3lDrxmFFKdFdWB9w0vAUjOh2EWafbONEELhdiNse/jfgZQ28reIkbA0IDtH0WBxc7qXs2uWncBlqUEmw+LLS+ZrINAfQRnAF0qWv0MJLHbZaT5oPOj9LrExhtu0ZDPbKm64vPv/tI8r0DdbujoaujCQnwl+IqjVuarFRgCWpOLE44/u/MwqFEQ65JP8XuwP7/cdkqnXYqDrRERhcIY/PzXsvQtXgsy0FgexFZLO0fuhq6g2Iw/SLY0qtNX2uIWGjaKzlmBncaRKfdb3Y3e+NK2dZ1ZkMgVx4K8U/SU6/enYjwuWf8JP88g+qa2EIO909wwUezJ6CAHDA1INLNoweys9+7LBWxpUpL6JZCbZ29rfPvgYU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(366004)(39830400003)(136003)(396003)(376002)(346002)(451199018)(38100700002)(2906002)(5660300002)(8936002)(7416002)(54906003)(186003)(6512007)(26005)(41300700001)(83380400001)(36756003)(2616005)(6916009)(66476007)(66556008)(4326008)(66946007)(8676002)(1076003)(6486002)(86362001)(966005)(478600001)(316002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8NUTQIZqLC7ooFQ1poCYZeKhGZxOmVZuRL4O7ZOXqbuYNmfxamL3x9tF5Iec?=
 =?us-ascii?Q?rp4RfQgcC7uZQdF56WjbbZX6RmhQxEKL1/kcDNPTtF2W6upALeYvS4H5JtKg?=
 =?us-ascii?Q?O+wwLCmF20BGHX0TSF3vVpDyifp7GCIhPG3aeW7qqjUpjC6qkuIF7prYiaa/?=
 =?us-ascii?Q?bwgdODGOdzfDj4iaH7E9N2J0VYbTsn2zupdZccSkHcumebNEO7H/EbNE03R+?=
 =?us-ascii?Q?o4VkXzJvEqNAOAMC9ezwUKSR13vZV06at8/QW54CSLh/+rd83s8EaG3bvpLz?=
 =?us-ascii?Q?SUi7mPq8XYS0TdYXxRVhZGzJvbr/JeFfmUudJ9ifOOGCplgXBa2bST+gLv51?=
 =?us-ascii?Q?YuPHPRUNGZoARyS6v1uqqzoSxsplIQplRmG9cR6//Xvwn72YYdgZ2AJsIkII?=
 =?us-ascii?Q?7iQHblqCqy6hEEcbwxUzdiLPV87yHKC59hixuwQNhP3fLVYNBHC1qNcYmW8J?=
 =?us-ascii?Q?Zk0B9cFql5kECz5mTWqghUn3LusByth7Qiw8yPEzawNfnwpFkXejRY9QPiOS?=
 =?us-ascii?Q?DJU+VEsU6uaq6SwLWvYRntVCW/IapsMo33sXHT348fl3oCAM2k5ZVr6dS1d9?=
 =?us-ascii?Q?ynqACMFuRQE0dR1Wyus/3BskObbZ0p/dZl43sCLsQ6UeIkj+mnbSNAwSZ/g3?=
 =?us-ascii?Q?zVbBT9Z0BXdK9YhX4bFGn0ALVrGAytOUJyczq+vRb37U8JCP1Y8btUfJSjl6?=
 =?us-ascii?Q?NMEFHyXBeBdfb5OWofEQhzpJ47/HIAOfQAylgMhCsW7otBkE9G1j48uDNa4S?=
 =?us-ascii?Q?J0j3ISiS8rLIlNnO3eAr0/NDtgT0Pz9Cnxzgp8unprfdwe8HjVZxoJ25N5xc?=
 =?us-ascii?Q?iappDCvwneOMev8TzVVE20CfrLtd1Wf1mStT+ykU7fB86Ho4AuIFhvtP7xUq?=
 =?us-ascii?Q?x/sV62Q7/MFCo8cb9zdoORUvp+44sA3vGLv/YXy0p2RNYSI3OAID7LCAWijC?=
 =?us-ascii?Q?dAi7NrJvXohyBCwrDZM26ykpg1RP96TlX0pAfSnODFH3mvMsinankpEv7npv?=
 =?us-ascii?Q?ZJpDz2AxXNq92s82mwYpN0uZfj0jJ6VS9bylvsqW3BDInymuH+SS6emGBt0k?=
 =?us-ascii?Q?JXaTlYodFqR5bpjtzOYt6Hc5RTz/lKWu+aK07UruFYFoDX4piSFlbZNzcJGm?=
 =?us-ascii?Q?Jty03mIyoRW68qK+vUzOoGYAiOX0g5xuQv/tgX0aCMGlzCwikYEaj+ohd6Cd?=
 =?us-ascii?Q?r/htxlGgH4ZrE4DxzuatGDRpYBrwoB2uFepGRFafEwLxR4cpYjYtarvvpber?=
 =?us-ascii?Q?9uXi/QpEb/C7GpjBxf1f0GF2eRppMcQXEi9lAWnTdAaaWE+y9E1dkt+o67k/?=
 =?us-ascii?Q?0qIgOCeSBLmmHJTj8gWtPLaZDCrMonk24YX5fVPk7b5tuvfjFr+O/u9aTDAO?=
 =?us-ascii?Q?5HovYbkZpHYuevc7aCse+X7hpsaTBUlD6EVQzB73HWJ3SydCqsvdQRf+B7WZ?=
 =?us-ascii?Q?QlegyoPz0kZEoP85S/Exnyi33NrNjNH/FfYPeI690nOOlqNiWcc+vfIkk8Dl?=
 =?us-ascii?Q?CITCLgokQdZwug5sGx1I/yVSbnbygUnKsX6OaUIxGrnIBE3HfT/ortOzbCZC?=
 =?us-ascii?Q?yBRyxSqx5LkiMIZBRPVd5Nfia6xJMmQfho7GI+SV?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f130720-5e06-40a4-dbea-08db150ec57b
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 19:55:39.1586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fotp99F1z/ekB8wiv0slYYBw40q5WK3J+Hu7pNMDKKmiPddfgG6nYVCl/PIhHLW+ML06zRhaGyqAa3RXNB0iNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB1889
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023 21:33:42 +0000
Heghedus Razvan <heghedus.razvan@protonmail.com> wrote:

> On Tuesday, February 21st, 2023 at 8:45 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > That's the same the Rust std time semantics:
> > 
> > Duration = Instance - Instance valid
> > Duration = Systemtime - SystemTime valid
> > Duration = Systemtime - Instance invalid
> > 
> > No?
> >   
> I agree with Thomas on this one. The Rust type system is really powerful and we should take advantage of it. Time deltas can be enforced to be from the same clock at compile time.
> Just for the sake of it, I wrote a small example on how this can be achieve: https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&gist=1d0f70bb5329b181f203ce7270e2957a
> 

`NowTime` don't need the type parameter. Here's a slightly more polished
version (also with names changed a bit so it looks more "Rusty"):

https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&gist=83702f491050da1c67ab9aa129103f7d

Best,
Gary
