Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5970A67C400
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 05:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjAZEng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 23:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjAZEnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 23:43:32 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB8D7DB8;
        Wed, 25 Jan 2023 20:43:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxjHi8xCdsQ6sLf3zuDSRuFUe2uBX3rcgf0w95MJnKIF0UyTPa5Byrz8HNy8zYtdQWZFWQ3h2dR+ODWn0+c5d8Fxz+xk7L37fTKn4h28dWenV24NYFfPC4iPKKPazQvWTDHRQpV+6VywPuoEg9Q0SSRCThSm3EU5EGd69W6APc56UZRvVFf3k2i/PlW3y1rI8UboGeIZK9VPpM3OCkDfbkhSaCFyGKHP7GybkgTrOXOnrSENm+XuhuEb3TxbU0jqvHizivHIJUxrnlHcNXz21AItwl0dnV0H0jpHz/bQsf0VTYoYMdCbD9tEyWf3UdbwHnpBgeq0Bo9tS7QmM2wbMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LenMtkMaUOie3PCzbVdzSBBbokNi88XcC8DwVG6zJyM=;
 b=Qgm4fZoDEye/lcaYFRizoTRJ3RYDE2dReVU9jDNiUrA+JV2cQUXGpdrLHkBBtczatQSpf3jj23U6veX8ohcsS0ZF/h7IWoNMpezIZwUV49jBBNl6iU8p4EtciGOy/PUuWJnP2uaejwwnVPgMXOGp6YgCKgWrbIUBz56HEIYfeQ9UcXbu+MtAO575VbY9fZUkQMIdV651xfF5q5dN3RXdtoDYPU7e8FvBpBl3z/zQtHDAYYIhCPSQgJxSByBtqektpncvp2cT5HpoL4NF4D51jyVb7lDPS8DecEgAatbyPkm1t4YDrDwnYHhRDomKecrh43YFodj3whZxE0cCU/iRjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LenMtkMaUOie3PCzbVdzSBBbokNi88XcC8DwVG6zJyM=;
 b=WSzeHhKV63skckg/dfSUfxhU1FF3hvpmTW/nODN2wOzoZUnSnx0boP1KCwCkbbrD2lVMtTzBJ755bLB7jQobpbNu3rAC4Bh1JnhLj19tS9ANik5ZV1x/FtvdVIhDlo1B2t0LAY3zwDPz772zhPsyNWBvLNDpKhr/CNiY8Q4Zlm8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by SJ0PR17MB5857.namprd17.prod.outlook.com (2603:10b6:a03:40c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 04:43:28 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6002.033; Thu, 26 Jan 2023
 04:43:28 +0000
Date:   Wed, 25 Jan 2023 23:43:18 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        avagin@gmail.com, peterz@infradead.org, luto@kernel.org,
        krisman@collabora.com, tglx@linutronix.de, corbet@lwn.net,
        shuah@kernel.org
Subject: Re: [PATCH v6 1/2] ptrace,syscall_user_dispatch: Implement Syscall
 User Dispatch Suspension
Message-ID: <Y9IE5tBjY1GlFCFH@memverge.com>
References: <20230125025126.787431-1-gregory.price@memverge.com>
 <20230125025126.787431-2-gregory.price@memverge.com>
 <20230126003008.GA31684@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126003008.GA31684@redhat.com>
X-ClientProxiedBy: BYAPR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::19) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|SJ0PR17MB5857:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d04389-0a7c-48c7-79c6-08daff57de1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQfgNqZruqb9BRdm+ZSnUmrIwniMq6xl6zxQ0zK7pBL84NNJH1tr67hm2oPYuzuq86Zrvzr0rVf7l+JMiIwlSGfhk2ZaqFCsCRO96Z0zmuFk6hieNJl9uEk1AJ++v9gEsPJzFNuL47tGwUuUtcVw3OD0DmwFc5i/XQCRBel9/6kx0DmdpUqY+X7DdFPOdavNqUpJN7VheGot9XiHb2svy8UfWazwUhqlUBiqdVhafhtuDs2JaWQwjVzv4NSXj1kIa+NCW8e2xpTlj33KnKU30zLXBbFO0sdb6KCzDDoUMGWgER44B2Ph5Uq5+uCC8p+OaXdK46Z2BcUicTex27axpd5ALvykhbrwa3UafJoAWZa3rKwnS4QiuYEfn4qE6NfLs+ltaaIO2mlKkk1uEmQ2MR4kYjx+wy/kqs1dFboJR/0a4YI8iZ31tjfFnnP+OJebjeW76er7IU1aydpkOo13Job3ZIcMFpUt4+PFPRWVACNkXXftk6SynCtMSi1BN2T97ZZkYgxlzj8zxFjKiDyUlXqLno9P/wezGksSHbptRM263Z5GFoGhNf9Z7N0bozlXt/JljZfWBE8REWm+O3UpSjYWqSN5jXhZ41GQ+qYYSdE8TDzUZsEn2mUzJk2KI9AR+S4HGs0KNAuEvl5GOCWBgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(39840400004)(376002)(136003)(396003)(451199018)(2616005)(36756003)(2906002)(86362001)(4326008)(83380400001)(44832011)(8936002)(66476007)(316002)(478600001)(38100700002)(7416002)(6486002)(5660300002)(6506007)(186003)(6916009)(8676002)(26005)(6512007)(66946007)(66556008)(41300700001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UDXE8rul8qXVhfn0umWIZ1yHHOFVJVPxbidN1ZLpJfm0fXhl1uEQ8P6wnuW0?=
 =?us-ascii?Q?dmWdTe2QD0H5L1LAsmJW8goDvzU0NYSTubGo/hs3xsBg9stplifzS0iPyxG/?=
 =?us-ascii?Q?D7SUmQjxC5sYoz0uxt6x1dSrqbmYyxK3JvS/y2U/DOGvJ3G8eNGi8paaWlHj?=
 =?us-ascii?Q?T6qHjCBO+BgXplgIopnFVIKBzazw0Zg6Lob5FaLziuZrvE5vjYRzFHR7dDSf?=
 =?us-ascii?Q?rZYHumhj/xQAY2knSy/jaq27KDpxUGQaAu+eOyMsC+WvvdgoUQKYEliPV2as?=
 =?us-ascii?Q?7hAGjk621bi0HWn849w6GuGCAahvdw4zmEyfrPlswdHmex0eMTlZ79ULhev2?=
 =?us-ascii?Q?r+kG56GuAo5v3iz91xicty6LOXsDvxRUXF1+1NGbt28LiJ3fEOb6Yq3GX3YJ?=
 =?us-ascii?Q?q1T+A7vkazYE1j/3cvmlD0gUzgvwX+U1pmGGJO7Rr3S2rk0/beSuQs14IJa9?=
 =?us-ascii?Q?rN1NDHnk46c1IqcWhh9SNDZcvn+sF+G0swUDdKMKQ2u9Cpi7s2Z/uJULX4vU?=
 =?us-ascii?Q?ZLLwfg6poqDrC+GAIisxwhEHb90rYIRuT71H4B9EPiGAVkAJna/GKPGKacQj?=
 =?us-ascii?Q?FGeV1hgZT6/0lehjD7KFO3q7HALAsDp9WKijPZ+XeZ4Qvea/QqfChJiy6RoM?=
 =?us-ascii?Q?Qzd6u/DYxEw6mDG9vLsdzcfoyyI0HvHX5X9Jb3hNd/Dpnag+MDzK86FwHxah?=
 =?us-ascii?Q?o+iwvg94Miq5UDYyJXgJl5UH/Ixvg73lZL9l3CXulRBbkO3UozOR1ObP8jod?=
 =?us-ascii?Q?4jEtzORjM/x55Erecc1/8mYxMfrOqG9BlMuNX1IE9MlxwTBTG9tri4QuRnkK?=
 =?us-ascii?Q?CXSMaBWDJVYxMAVM2MvTlg+GVvnAgtVbe6swft7OXQ6qwNyjPfAMUxQmjTsk?=
 =?us-ascii?Q?B21gwTXiS4v5tAiKH8jclaKJ5PzmquAtUvBx2Xy+IM6tlVjf4bklSoREWJoV?=
 =?us-ascii?Q?RGfb2qWwxhWU89W5+SvR+3GiIUE/Byx4AjzVqhoOMp0qfEei7zocJ5nJWxPA?=
 =?us-ascii?Q?QM9a6jDoAfjBrjNv14yF9R7cJoRQvZTuXSvA/F4old/8f33x+GH8k2jXIDu/?=
 =?us-ascii?Q?b82VRqQHTt2ZAOCyUgmmEBOWd/orJZgMg9rJ0T6TYJL3O8jjb4L1cs8h/Ply?=
 =?us-ascii?Q?RnxIl1LwywSL26foX+gksCtoS7YUkYOxMZ7Z8oMG+nxfeMWdSLAOJEAmloSB?=
 =?us-ascii?Q?s8ylvwUJ7sqoZRtDlwdJ6oWlfs7ZnDmxQZgCQOmqiDIaUQmEVbr8vPr4RUle?=
 =?us-ascii?Q?jcu6Xpxo+DCqWwitsVu+aw5+gqwBQQfxuc8T2LqAjbI5DeHt4spYbscJZ7cA?=
 =?us-ascii?Q?PFZG7BmgDHzncETDdnRmPC91BrkmZzRcxyI8DHHkeoxOsScYOKG3ixRoEjS5?=
 =?us-ascii?Q?ab0/02qEx4pl+sojEkfU4GtZrwb/bur62Z6WCKDbcVohnVxBgx/SdwH3BfKw?=
 =?us-ascii?Q?km5vF5hT9wEjNojjQxLqgbHKFzNnX2u6dbc9K722uY4jgUNpkrIARK+K0Fji?=
 =?us-ascii?Q?jg52Xs2LitgiBvyX6sUrenyQ4pIb8zWrejT8dnXnC0waZClZd2WvMqKqroI5?=
 =?us-ascii?Q?wuZVq+rYxzk/K2UMlDVDmUPiyZYbIF4WWQqYFDokYzWBmhBleSGAco9Q2UR8?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d04389-0a7c-48c7-79c6-08daff57de1d
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 04:43:28.2245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+iXwA9uAuqZrPvFZzkYLZNx6DS9kyL4u+f/jXunFZMsoLos857rV3G237I511YVB6M/Nv1gQaY23QVBNdiUH3z4VREfE7mD59HqhiuEGqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB5857
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 01:30:08AM +0100, Oleg Nesterov wrote:
> On 01/24, Gregory Price wrote:
> >
> > Adds PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH to ptrace options, and
> > modify Syscall User Dispatch to suspend interception when enabled.
> >
> > This is modeled after the SUSPEND_SECCOMP feature, which suspends
> > SECCOMP interposition.  Without doing this, software like CRIU will
> > inject system calls into a process and be intercepted by Syscall
> > User Dispatch, either causing a crash (due to blocked signals) or
> > the delivery of those signals to a ptracer (not the intended behavior).
> 
> Cough... Gregory, I am sorry ;)
> 
> but can't we drop this patch to ?
> 
> CRIU needs to do PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG and check
> config->mode anyway as we discussed.
> 
> Then it can simply set *config->selector = SYSCALL_DISPATCH_FILTER_ALLOW
> with the same effect, no?
> 
> Oleg.
> 

After further investigation, I believe we can drop 1/2, but for a
different reason:  It's actually insane behavior during the quiesce
phase.  Quiesce allows the program to run until a particular state,
which means we can't turn it off lest we interfere with intended
behavior - (cough cough prior review said this cough cough i'm dumb).

I'll drop patch 1/2 and resubmit (there's an unused variable warning i
need to clean up).

Thanks again for the reviews all
~Gregory
