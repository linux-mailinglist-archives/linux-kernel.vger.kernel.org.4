Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED09695518
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 01:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjBNAAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 19:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjBNAAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 19:00:49 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A970F1A492;
        Mon, 13 Feb 2023 16:00:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9xXVq3getWOquGLoVE0PFquEgSGsfzbqq0gBgaGdqjaeKS9poS6FYF421GMMx32BFn9aIE3YHRuTGb2tB1WYDPy2TTsJHko2v8FgQx/Uczjwa5TqPPqaXnUzBvlA68OjExhVhGSAK/6YUPtcZPHAbWPT5sdqjI5mtk9Fw90wgMQbi1WgWjOfc+BQQcNlC7yse+gUuECk8iBm4QEUCUcBMY8fHBsTUm/B2GHPSmVvBGc2nDhfrkRhwJmK/g9W+oHU+5HoMjDBdidj1FFzzu5Tc2TmD8fktDOyXgMLS2pMPy480aihzInH0pyGYQFJEPnEUa9y6rUdyLWPThFz/EiGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDFfeBuzJ8mLeqM4oJRp3rAFmK+k4JMY+bf3y4uDxN8=;
 b=mj5N5t+DGpbqSv3IEpDUILbeP/6Kmss1khH7fS18hSOFtemNKQ+bbZ2VEJ8bekwZTSvdrCx66oNlC5C8yEvF8p6xtw3TDVG0PBd+ja+AZS7pCMlicNvq8S1DcoaF49v4fszhUXpkwSlcI3UjrhYiZ8Id3wR8ZPKggA8oxk0tcnaOcznp/u/A6QLgB12uOwqpc64+/JVidYEyBi3z612I60uHLlivw+KvKYdkhbGkfOj+4ABibrIjQCjDwPs7yfEuEXlhDDkRXP16Uv5yN/emkfg5T0AA+QQjvKRCWnPqyXBSz8A7UPLegF22oWtz5fmGpKNh8Zx9GvqubbWB207Fpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDFfeBuzJ8mLeqM4oJRp3rAFmK+k4JMY+bf3y4uDxN8=;
 b=mEVt5owK5wxZoaINqVNZ3BnBsIyGhNoE9G+W5A7CUlvXkVs5A4zWPCxnygY1JkG29Ysg4a1d12vAK22zp7Rnfp8nlYcGQRMCVtur/G5Wplb4Tk3OSwu/P/CmjwhZxjeKGwVyOfUWD/hiFN1PyYbs+l3ksVz2a4zxEK8IrKCYkCs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by MW4PR17MB4763.namprd17.prod.outlook.com (2603:10b6:303:108::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 00:00:40 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%3]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 00:00:40 +0000
Date:   Mon, 13 Feb 2023 19:00:31 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        oleg@redhat.com, avagin@gmail.com, peterz@infradead.org,
        luto@kernel.org, krisman@collabora.com, corbet@lwn.net,
        shuah@kernel.org
Subject: Re: [PATCH v9 1/1] ptrace,syscall_user_dispatch: checkpoint/restore
 support for SUD
Message-ID: <Y+rPH0T5r38+l2gB@memverge.com>
References: <20230210072503.1808-1-gregory.price@memverge.com>
 <20230210072503.1808-2-gregory.price@memverge.com>
 <871qmttiqa.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qmttiqa.ffs@tglx>
X-ClientProxiedBy: BYAPR07CA0049.namprd07.prod.outlook.com
 (2603:10b6:a03:60::26) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|MW4PR17MB4763:EE_
X-MS-Office365-Filtering-Correlation-Id: bf17928a-a398-44cb-568e-08db0e1e8272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B6NAxjM3bR1jzQ00zrg0ubi6PFsaUoLWLz6o/YjY6ch9+V6NRByr98lkFay2g6nkLrVIdApyO1N3KULOZVWFahSf+w8w/puFfY8ez1GopSPeiybDYoRh8Pq8o3G0BwgBg5SSm9WVLTGJRtu88UvkFMMhWny0Q2vH5Z1vt6un3Ygv1rEgWioDCefaj/SB6QJDk4n4VKxHDQwT7bV7X2haQEZ9lzloJnzfKw1NQBpw8iBZ6GWWudUhjJwsU4Cntz56NJLN7Y1d2cB8yWpZjXtksnix1bbejMTN3X8GJUTneMkSB+gVKKbW037J80JJotiae+hhUxkOZ5rhhh950usDQmsrh2NnLgwMaCWHIOq45Y0JzUOpXYfReeeddDon6Yn3kCg8QJv6Rjf/Bgjc7w7vBiSp9AKeOocqtWzU4DWeDZLN08iS6Y+OdXcrjWM78A2bPqV369cZVqJEczsoYcBj8XLfrDYFKI0AWKFSOjbab7gjbCq5wGPabVRunp6Vu00toqq5C2NgqjfySI2P0FYKpciJ7zF3scBbGZ7sLW8O+GRRAk5YWuhSAeFH4GTe22+BWjmlNJmgIWvqkkSNqmpT4LF+QbVUxykQEd9TH8x+eVA2+s9DrWA+qsza35/0NfLjsz1l/EkwRF16jN2oJETN+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(346002)(396003)(39840400004)(136003)(451199018)(38100700002)(66899018)(8936002)(6506007)(6916009)(4326008)(41300700001)(5660300002)(36756003)(66946007)(86362001)(66556008)(66476007)(8676002)(7416002)(478600001)(6486002)(2616005)(2906002)(6512007)(6666004)(316002)(26005)(44832011)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+2aaI5C0TzYtm2WY+1z7wyejrErlE3PR9iuxK4bRj3IDkrveOWqkvlYEbdHi?=
 =?us-ascii?Q?KIjgbzvJDSRegAKADUr3H7OBrAx8V9XiDd20FdT+fkU7Q9rwpImz6/idfGb9?=
 =?us-ascii?Q?2xy7Bh3XPL/RLPKnlkTkJNWdOZU6IyTxTtR1UIijyT7KlIVoPJzhjYarsr4+?=
 =?us-ascii?Q?etwQSsW+q1WfeL2LBzPCukF2rSp76c8q2SnvTMAqf/2YAQ6C0C9yuv8M4NH+?=
 =?us-ascii?Q?IX1ZGSzCaI0NdNXhJMQWT0AYUWhBICmouhrWxAxdUduvG2B4Hl3yJlfxXkjY?=
 =?us-ascii?Q?1NSiL8gZuA5IolkNnYEli0Bs+4WqgfytQVN+/fyo9q8eX9RB5WRmaVK5iT3X?=
 =?us-ascii?Q?/aQNggWbJzpFaUYQjiaD9PGx7QY9a7eJsnV5w8bFVZ1Av6tPYxfkpzwdtlVm?=
 =?us-ascii?Q?3QoqUV5JMlswhFGsycpx0HssTMuXa7k01g6CQ1i2qeitS89Qk6srfLJZpHgM?=
 =?us-ascii?Q?EqBMp2Bw9p5FEt2WSYglN1CSLWuAkOA6SZMUFkFmYCFJ+hmE9COQJNLv+BuN?=
 =?us-ascii?Q?ACxO2HKXejH57s5BkrnIIS4gtUbfZk+ZMFlCZlUHYL3vQtFXFO7GHgrGs5NN?=
 =?us-ascii?Q?ld0e6S1wSmqyeup+Qd29PfJXNvAKdIs1dVxaU/SGce5SH6R/pnQFF5K/ouJ2?=
 =?us-ascii?Q?2ze8jeIWeJ4gftRUCLDiHLfIw1eqXcKnMWvlpy1MFFT9EYDhb/FK9K+kSVfW?=
 =?us-ascii?Q?hna0DbFmUjZA/s8mVmNrSROHfDc3qxdsrdgpuZRyPZxUwvg+Ydm6G33ArRh6?=
 =?us-ascii?Q?llkOb2uzt6C2x24yN7UBKv2+RBcSs+oWNZo4pvgt359ZEBqZYQbt3mbWyH89?=
 =?us-ascii?Q?4WMZTVQziCotQQKNF5P3s2jpd9eDHIlVBptYDRw46IBuJ0RQE3UYUdreb+dS?=
 =?us-ascii?Q?fmDzErrYLglJvtfP0i+PV8w+FKulKFRxAgaa8IeDkXtnimzFFbg6JnaMMu/L?=
 =?us-ascii?Q?XsG6wUyGntcFA6/8jVBH+t3jZJlXd2QaQWrfCViWClHtPh46KG7VThUi+L/B?=
 =?us-ascii?Q?lXKcW5MVxyFYHxbe0Xw0SftiReHj1bdZDqeC9Gdj9TVpJFcHcvT2BwrKNB1p?=
 =?us-ascii?Q?MAUCfm7AIOwH0CvWEQ7LL9bza35JPeeCMjOu7dgh41gsLXEdHOo9XsknZTdE?=
 =?us-ascii?Q?lUWcbPbZbhWzZXt0zXx5CMwPF4fKn+I9Ui3nrxSPoCrHqJ+aYz5zDhPhE0iY?=
 =?us-ascii?Q?3D79fsQPfCxK963o0dLFFHsd1BuTCEarcFonBTUerZPJtBWX7sRXPHXJYgL8?=
 =?us-ascii?Q?Sw6nF5jLJl7aeAtddWtbVGCNbfo8mqliaeU1P9cK/6vEpol/RXXY2tuF84vD?=
 =?us-ascii?Q?CDVFtxUIw5dKUS+fgvw6Kmkav3qVBX5yaJ6GQybfDS0bEMbAA/oG0g/ilVIB?=
 =?us-ascii?Q?1bJsPIg/ObY+HDC0fxppY13tHA7fUMUTnpbAlbNxg3CBTCf7jZ9kO4fWMVgP?=
 =?us-ascii?Q?pnHdMx8pVr5dt3P5+M7Wb1zNISKXi6FgCfIfsPApPFI6nUK0gnrXJg4ZOVcB?=
 =?us-ascii?Q?kPkTmuSSLw1qif2MDuAHAUWimMRpq3b3srVqRbrf1sl9Rha7fB93JIkfNeaW?=
 =?us-ascii?Q?zLdJxyczkX6BV1BYzHkVpQwvANqYgcvgOhZSGJu6/W3ea45Nam9BJEobnpcl?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf17928a-a398-44cb-568e-08db0e1e8272
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 00:00:40.4958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRImt95Di9aHG63Bl1DtdKLhLVCaSVRMmlNWbHJt5/rgAcgv0Px9qcivlD4apOsTbmBr2dICDCw76u8qQOi2xcSTI9lmKJB6sVQwQszq2H4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB4763
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 09:26:21PM +0100, Thomas Gleixner wrote:
> On Fri, Feb 10 2023 at 02:25, Gregory Price wrote:
> > +struct ptrace_sud_config {
> > +	__u64 mode;
> > +	__s8 *selector;
> 
> How is this correct for a 32bit ptracer running on a 64bit kernel? Aside
> of not wiring up the compat syscall without any argumentation in the
> changelog.
> 

I'm having a little trouble wrapping my head around what is "right" here
with regard to compat.  Granted I've never had to deal with compat
issues, so please excuse the ignorance if this is a trivial issue.


PEEKSIGINFO has a similar u64 field for an argument, and likewise does
not have plumbing through the compat path (it falls through to
ptrace_request).

There is no compat counterpart to this peeksiginfo structure, and
therefore no compat plumbing.  

struct ptrace_peeksiginfo_args {
        __u64 off;      /* from which siginfo to start */
        __u32 flags;
        __s32 nr;       /* how may siginfos to take */
};

static int ptrace_peek_siginfo(struct task_struct *child,
                               unsigned long addr,
                               unsigned long data)
{
        struct ptrace_peeksiginfo_args arg;
[...snip...]
        ret = copy_from_user(&arg, (void __user *) addr,
                                sizeof(struct ptrace_peeksiginfo_args));
[...snip...]
}

This makes it appear that the args struct has a __u64 field regardless
of mode. Either this or anything compiling in 32-bit mode will run into
an issue with any of these __u64 structures.  That doesn't seem likely.

This code suggests there's no need for special compat code. Otherwise,
is this a bug?  Too much data would be copied from userland if the field
is truncated to 32-bit when compiled.

either way, would an appropriate compat structure be:

struct compat_ptrace_sud_config {
    __u32 mode;
    __s8 *selector;
    __u32 offset_high;
    __u32 offset_low;
    __u32 len_high;
    __u32 len_low;
};

Or is a 32-bit program attempting to ptrace a 64-bit program not
generally expected to be supported? (from a bit of research, seems
like "you can make the attempt, good luck", levels of supported).

Thanks again for your time,
~Gregory
