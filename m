Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAFB69E44A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbjBUQMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbjBUQME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:12:04 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F892A993;
        Tue, 21 Feb 2023 08:12:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJTR+RRPtXHAUYEUN6Zaz3Q0uFqYYvbGIYck1wrEbkJUKgFMYCe3ddSIK1bic8+y5wB6ygLMTRERwkc0h2HdwN+Wxsq10G71oNRBpl/B133mLpfSRh2tqoGRJLBwUJ2ByJjweF8zK+zZWzGKRhp4x3ZUhgqIctle/yG5HcmtINkQNmN2rIlQnrPUJrvsqkP0FcZ5FhamuKzXVTKdWf4KA9epc7L1w3C/wMQx733pAbitTyNYceW6VGL60NZchqJfRHXs9g4wx/Xtdbvh4PyjkKyFsSBkznWjg3LmaxXu4SdBy0FxnmvXKktuHUhx/SO+vXDbS4dd17IWoHKkipC1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vl7ab/rQ7X0ipImeb9Rdai43xQ7L73vRkbp5UyKcGsI=;
 b=fH8DvIt3bo7CZqi1YDSSJbtVgBm3GNavEvuSlQ2Yp78DuvY0Lcueon1fTiG7XoWinoZu6uQUk2+uQ1ev7qOhJsgeZLTbKhUcHpHs5257STU4XRGHKorRhBLJ8uMfeYW9Oxcfun/irzMMbCaUi29RyVGKu0Xh3TmL71f6os77Fbr+jZnvSuAz+z0cerZtVPEK648jlGG0rQjvSb7PmRNk2xPHz0A5j+VLhjW7vZ2MrklclHWjx2TkupU4pj9afbqKu4v1TZytOGwFVjcwizlRPDkE9O16Yr2cdUUuaPObhLz4cbleO6+Wfa3Zq8I+OWjRcMMN6y+GCcGvEy2nMUFlXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vl7ab/rQ7X0ipImeb9Rdai43xQ7L73vRkbp5UyKcGsI=;
 b=BisiAKWudpcdu65t1sqQMe3Lxi1qTnjsTLNzJc40a4jJRMahnYkoXfiP9IDYIKQGo39xJ7YMc5QZ5FLfJH1SvtdgTbYSsFZr/xo6IUVqiurHoRQp9ly6HEeyXugM9bublzGFusFcqn7IoTHUG+CbWpMR2YXVwqNawZIzMB8FHJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by SJ0PR17MB5761.namprd17.prod.outlook.com (2603:10b6:a03:400::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 16:12:00 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%3]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 16:12:00 +0000
Date:   Sat, 18 Feb 2023 05:53:35 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        avagin@gmail.com, peterz@infradead.org, luto@kernel.org,
        krisman@collabora.com, tglx@linutronix.de, corbet@lwn.net,
        shuah@kernel.org
Subject: Re: [PATCH 2/2] ptrace,syscall_user_dispatch: checkpoint/restore
 support for SUD
Message-ID: <Y/CuL9CAf1tfAmhR@memverge.com>
References: <20230214085215.106708-1-gregory.price@memverge.com>
 <20230214085215.106708-3-gregory.price@memverge.com>
 <20230216135737.GC5200@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216135737.GC5200@redhat.com>
X-ClientProxiedBy: BYAPR01CA0036.prod.exchangelabs.com (2603:10b6:a02:80::49)
 To BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|SJ0PR17MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2c1480-a1dc-40a5-d960-08db14265ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pau71jakcXiVinwXHs3Bxsb5q9pLmxAL6AkoulhiP26psIq4jQm29QmWeAfD40OdJ8Mumh+iseLMKSMGJzqpsRAffVlC4TmrYi6HK7NwKZqTrUHxRiX42Cfxpe9CYkiMMslEGI5TU1eB2r7dBObM81a6hhhtbvPKKjOHrLfu/Vv2/ni1KOIssMLlmEDzEDghaPwRBOelouvIblFK1kK9ekIhCo8fxSenXUnNqjeJyyvRl5H25FaVcglQNYKAC7oIjaWdAG4tf6zCbSw+P2U3ovezryP2CNLtaL3Cdp0q8JF8IwlNi+2BnmKknKZ/BJb8QyXmCp9dt5gjKFRTVdnC/KtFiTz9F77o2CgGoQAXOnnt6N2H1Mj5s4nmxjdsWx6J2azGgrMTDr6m9WxInJsZdC3BeGNlMF3d3nXuYK0QXII2H6M1zmt2qqyZtHwySPzzvNTvf+4HgmnheVa1qrMZV9mzH/Qv3mLn6M8IJmap3StNDLTWvLgyEDKjqSS8NPGocyf6B6vUZuBfRaq/7eVDoMg7qhkWk0zIMl46IJQw6E7lC87yr3IcB/3HFM+Y/rvhRFLvCaDyBeSWbiyl3UyrAVshbiXtQLiAaBYy3v2QNbktzpW14qozI+EppR1RfO3V21OHexTT8CFrrEbceoQxrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39830400003)(136003)(396003)(376002)(346002)(366004)(451199018)(2906002)(6512007)(6506007)(6486002)(186003)(26005)(38100700002)(6666004)(44832011)(7416002)(5660300002)(8936002)(2616005)(41300700001)(86362001)(66476007)(66556008)(8676002)(4326008)(66946007)(6916009)(36756003)(316002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qIbnEaZsep8xP5DZ0WaY0rhNdani3y+SGFs4z3pUP6/b75Lb3Fy+UaGEPnfc?=
 =?us-ascii?Q?z9LOav3yE6qMjFji430B/xmxknI5+nVqknWrFo4wvhqf6MtWeBHK6WRYxV63?=
 =?us-ascii?Q?SJ6ogDhAywwrBsIUJ3yxK4UFKamncAiKEo/RPYiBN06Q3+XgrA68MZUVc0+Z?=
 =?us-ascii?Q?K6xs/vG47kIb25qGEaedpTwecgxmmjTYx+02PZPPH2+s984hlKmvaBbCRd04?=
 =?us-ascii?Q?V0o5HfkP4UvJct68JJjEmIWtBmnxDkqrozkWkUmmzhRD5BAB68IA9tJjHgbL?=
 =?us-ascii?Q?6C6JUlUF5WYoCgbsWzvymv96Mj7YlZN6O7OdeAG4ItAm7dh8etglHtJstJ0Y?=
 =?us-ascii?Q?oITD+fvu7AfTOJFge6AzEkfTe8iOv8YJ6ynl9PD+pypuGES0ei0OB/IPH3Sv?=
 =?us-ascii?Q?9mgm0BD2wT3n3a9W+YJ9HZOMv4C2N8pPMTT6Tg02wxd+HCO8rUP9NtI7zKLR?=
 =?us-ascii?Q?NRD2ncezHFqEKH+7WDqyQU1YVzYGvHBQ9jiRK5Z6Lj+lP1bkXvM4+bODYRUG?=
 =?us-ascii?Q?am/vRkf9m3Qv11zxwYhTrfWrL9L+O4cWJXVd8ixU8/bvss7LfdLD/xhVzQlr?=
 =?us-ascii?Q?gJ8U9lx7f6uAOjr+2QWlZhmI2oyBsdq7UESYwqufLA0R+Zy/M1v6Eqg0gfFf?=
 =?us-ascii?Q?Hg8MgLIQ1+wezv4JgoGB2iYbaj0/w5uuf1eJ+NFAV+Ctuavz9pBtpSxmhQI1?=
 =?us-ascii?Q?rX20xMETDv+KXjAA8IdLlTqde3AGoBOk0VmgSiIesPU4TymEloZGQeAwvv4g?=
 =?us-ascii?Q?zRHD3qwUaO080onfKVN+1GPe8Njf3ThBNbbKOeHyGJ7+xckgqgdc0I5DuGv4?=
 =?us-ascii?Q?GsSRs6kvEXQrR17+2Jy0NxcRYvcAULuwS2g7/jK3Wco3D5pqhltJ14helNOr?=
 =?us-ascii?Q?5YsiwAYAZEdxYO5QCvFwa/BL7RgVII04wgnMuDxFK9AqnJB8upPNqS7gP3Kv?=
 =?us-ascii?Q?dx+RqeaWlVMMWjKsyp1y9F9G6Fx0b/aNJV7Y7X+0ugRxqTVHgndk1jsDP755?=
 =?us-ascii?Q?RLUcqM9dlu0wbM5YIhMMNF3j0D0bP8fowqWqX2J+ukMNk1oT+vMHMpaikU94?=
 =?us-ascii?Q?QpyTgRBFz5iTmrFsRaUlNd7KL7U0TqhNZ01b4HMmpgtu9OQvFlv4owzJr5tA?=
 =?us-ascii?Q?XQVISacSi4kQp73KTGH+k+ZdVVql7hh21qHwghSB2ft8F87WMKSR5W2D3EtO?=
 =?us-ascii?Q?gw7Furbktv9uMuzsfIQQiCjxzBupZ7kwPSwt5iNetOVpDxkJJeZKOdJkyBJY?=
 =?us-ascii?Q?BJFCkvYoaXW8WKWTHIZuhrC8cm0r83KpLaRQmng0nXullS3FFa3Ygr4Wks29?=
 =?us-ascii?Q?2CnrBUX1ZeMBRPAlnm003T1zE7cmwo1h4qUQFN9rY6Lf0Oky0NzYQBbuySeU?=
 =?us-ascii?Q?zo3a8vBP93Q3SQoCBhs0kWPBBvSAryGV+3LZfwTB1s5YOTfhYHHyINwr9Sct?=
 =?us-ascii?Q?jV4g6srn5JFtwJwXOYcwa0R+X4qhchv+DhPLngPaYQZkjMZelV4ACdq3gW6e?=
 =?us-ascii?Q?5/aoQGst2TIRJ2r+xzZG4BB/Mu6q8jDAHhctJ6k8bNktlJXDb9bORgsj+lVb?=
 =?us-ascii?Q?iOleBnzK/EqXi79Vx9zGTbnBZ8Q5CBlX38+u7U6NGH3gWns/NCAOZ99KpyD5?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2c1480-a1dc-40a5-d960-08db14265ca5
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 16:12:00.3742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgtYDilgaCnGvsPGdM6YjepBX6EvzK+yaRAhCgcIJ0HCem5daKI/w1Idvj8G5q0p1DX8Et1s/rX2CJMo7TOmYgmQSXZ/NufTk5YcMjBVjoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB5761
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 02:57:38PM +0100, Oleg Nesterov wrote:
> On 02/14, Gregory Price wrote:
> >
> > +struct compat_ptrace_sud_config {
> > +        compat_ulong_t mode;
> > +        compat_uptr_t selector;
> > +        compat_ulong_t offset;
> > +        compat_ulong_t len;
> > +};
> 
> ...
> 
> > +int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
> > +		                     void __user *data)
> > +{
> > +	struct syscall_user_dispatch *sd = &task->syscall_dispatch;
> > +#ifdef CONFIG_COMPAT
> > +	if (unlikely(in_compat_syscall())) {
> > +		struct compat_ptrace_sud_config cfg32;
> > +
> > +		if (size != sizeof(struct compat_ptrace_sud_config))
> > +			return -EINVAL;
> > +
> 
> Horror ;) why?
> 
> See my reply to v9, just make
> 
> 	struct ptrace_sud_config {
> 		__u8  mode;
> 		__u64 selector;
> 		__u64 offset;
> 		__u64 len;
> 	};
> 
> Oleg.
> 

It was unclear to me what the prior note was asking an I followed the
pattern of other compat code in ptrace.  For some reason i got it in my
head that u64 would compile down to u32 in compatibility mode and i went
full-stupid.

will back out this compat code here and fixup the struct.
