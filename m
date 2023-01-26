Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BE267D493
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjAZSqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjAZSql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:46:41 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48019171C;
        Thu, 26 Jan 2023 10:46:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjnQvza7zTiz0ZuWQY1ebTKv1QTGuFnLPI1ZsoAgkaZsXYD40fo2WJHuJj3SLS6r7fwBEWWBaQnjM1kn6uaVQAWTFD7K8BZC9DQD7sq0GKELVlWytBLgDeUnOobyopPTRlSL6XOyMlMRXzRLLKPOY31W/Qrg+HHzt2IstEQcHQwHCy9QOuWXR+xnKbxJ2qib1pADUul2l28EJZqmZhfyAGGgOAtzq+QiR3UZIQk/XZqImrW10Js93qEyuoiocajgbcV/BDJ59rCFVf0HzkDtUqUYfamJxHuaoMAaoUr4ABlffq5KGK6iWxaXphCYd+B8DPQ1J6rDeagxFONYR654eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEIuhzB7g/TlxCbWGZiyFueNiqSccCawemsicW6Lz+Y=;
 b=JtXdrs0S5AQOYLY6az+O0N/qIZWvmXc8OwLb4VbGSqkvApuHQV+2Lmglf1wrgZUfN3RQON2OC33MUzH2PvFBBmSh+fEVgcAPFPCmvLwtKb1D+a2OaXo69pqurq2pZgR6LtRbpe7J4Ggb5kt9PoIsL1iWwNnhGUNmFpOwo/fnqRSO2uFUWC1/viLoSb+d6bcKPZYt22ySZgV+laAwtiIno7Fr3DFxONiDrSmxoom/mLhbw6nKRhGAF7LU9lvXkZwg5Jo1opZBGxAErGDCV/zKxRcdtmcbBw9SUQZcpolpfT1bHdo4POXfovO3H2cs0OaomJm2EzHC3LxAK8vdGW4n6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEIuhzB7g/TlxCbWGZiyFueNiqSccCawemsicW6Lz+Y=;
 b=RsCXQ4jtsFpHCnWfgR0wRAzU1aBKpZ8ddxf2sh4buW3x6WkEAEslbezr+NWlQqOD/2J2MXkbd+T92HgBz9SUN0h/HiKSRlNTYX5BQKX8jokl+Cul9Awqq1eIv6eceyLAgz1lLoc8o/Hkilt1SwdLiHVFTE1aEwPRw1wBxYeMBZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by DS0PR17MB6892.namprd17.prod.outlook.com (2603:10b6:8:129::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Thu, 26 Jan
 2023 18:46:37 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6002.033; Thu, 26 Jan 2023
 18:46:37 +0000
Date:   Thu, 26 Jan 2023 13:46:33 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrei Vagin <avagin@gmail.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v6 1/2] ptrace,syscall_user_dispatch: Implement Syscall
 User Dispatch Suspension
Message-ID: <Y9LKifpedUSMkHZE@memverge.com>
References: <20230125025126.787431-1-gregory.price@memverge.com>
 <20230125025126.787431-2-gregory.price@memverge.com>
 <20230126003008.GA31684@redhat.com>
 <CANaxB-xn0wW5xA_CT7bA5=jig+td__EDKPBWSpZdfgMgVOezCg@mail.gmail.com>
 <20230126150725.GB4069@redhat.com>
 <CANaxB-woave9F479O75P9PC+nFO3DVmbeFA1rXf2c=bhRmWoiQ@mail.gmail.com>
 <20230126183019.GD4069@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126183019.GD4069@redhat.com>
X-ClientProxiedBy: YT2PR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::35) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|DS0PR17MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: 8699717f-7a11-4564-a8f1-08daffcda7c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vSW0qWyK1c7Ie3soZzqLwPyDzdgV7+nFQLILXfWrAQI2bUgt6/BXc1XWoA4OphYV/cX+8cfCmg/xC6+NTSvprjdXiPiyFI5kNtEMnPErmMFC7ePxlKfvI0KSr+HNb2PdsAsURiHlr5OUCEDqDDScm4Dl+cvR1zzyvldfC4E+rnKnNvH1dhroWJPxa+2IPj/aBA2ycoIlO141MW1bI8QyIrwp5p0gNWM+Wrc7rErax78XqL1MiouT/bH8/RizSXjkkfVx+lnTqcZrbCsjrkBjX+jyCTMRLf0hLQKaOc70ytQAB49WRm9kAKJl2pokWDIjNyR9ZvfsDEW10SAfWVejGpdxq98uH2XF+6jy2S5a1CGkdiLGJO38Lzog3xDWOpYXbtZGCu3wqmWEwGuGJjCjnOhdd3ZDCyNKvKB7KOfMce7zxe0nubahXmcNs7stleJ/2gz2qBCNk+oqVl5TNpQH0cXHEJY2cZnW89JNB5XdjZt4u8Zia0tCs4qLYApd2lApCAPnzCCelF8CCLVaMUO3q2eI8M1Uhz2GL2kC3xQSE2bDzqqzT/lgKRmUY0h4reSc8odDps0srhvbIhylsvcPX84V2s1/zrWUk/aL1pziHxbCBpTzjWf0iCLU5SYf2lQy8CCO4GwTtZwmjT21onI+wQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(136003)(376002)(366004)(39840400004)(451199018)(6666004)(6486002)(5660300002)(478600001)(8936002)(41300700001)(36756003)(83380400001)(44832011)(7416002)(38100700002)(54906003)(6506007)(2616005)(26005)(6512007)(86362001)(53546011)(66946007)(8676002)(6916009)(66556008)(4326008)(66476007)(186003)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xxPUtHx/Cvyb9mA41850yieTFEM/C8PtZoqfuXBIsTq+NHas+X2cHKE/l12D?=
 =?us-ascii?Q?YkRTjjOUqt6pXhCOoQ6RsSR3oBsb4YHONZmUSqabQ97t3+I0V3CbvEqFXDdY?=
 =?us-ascii?Q?HBWxJBucCl5Bml/3hD9plMiiErontpsKZQUkYR18hdHLeoYwg0vnUz50edhI?=
 =?us-ascii?Q?9jDrb/EQGztKfBfWjMySYgdMkI0UaL3fmlUxYEJXQHytvbNYOL+MuDeTov4D?=
 =?us-ascii?Q?+ys68+eF8K9uoIOX4KbVhwkWcWDdPsbouqbIcLZwAyIjKeLyZ/NRQXs4TiuE?=
 =?us-ascii?Q?GH6j42pENwjDc9NOTFcAH2lMrnhgsk/iPJeRno+nR6pX2bFfXTajtIny8U9a?=
 =?us-ascii?Q?Rj2+d1Bi7QLj0o+9Be/555oCJxiCAea2j4zYOPc1nSl6nhaWbgWPnrWkQJVz?=
 =?us-ascii?Q?sVyNOO/P3u8uoo5EgSajXCZFnVIenU652NNI2BLme8vYR6zYOWndUvwbbDv2?=
 =?us-ascii?Q?VQeuCBc4yt2xJpvxUqL0QMMNbjna3MnYHk+Wy/VsmGEsJC3Mj8IqIkSKjjPb?=
 =?us-ascii?Q?D8n21IixxujdcdGiSKEuNqYvXj++F6bEJrs9EpZDNLq24YSegxiiQhnEWtlN?=
 =?us-ascii?Q?fMdt470oxwMQtAnDlyOgyFJmHePy3X/Y1mjQJN00wsrdZlqaSAxfVh3Ej49Z?=
 =?us-ascii?Q?ufdqZ9MtF5ivFZh3G0s4veaQ8BqgfYbgTm4msL2DrV+C0qi98fZ04JrQWi5q?=
 =?us-ascii?Q?w7QJ3Ll2+WgoqtcUwASxhN2p9SnUj9y9zyQqZFqkQNxc1/C44W/xyNxFdxsp?=
 =?us-ascii?Q?2QFVlvxGEp2x6Fdcss4JsWEMXrXkAj3oubcjqa/uDo8nGNmkmQN/3yYAPvQ9?=
 =?us-ascii?Q?5Rp7t9EKv2Jjv2f3Ug/GM3O4HZrMjOi7l7ElkgQcX7OC5LQ09rlr1wnOEmvp?=
 =?us-ascii?Q?trx3NioPMsyzR9Z+cBt7dVvtwf8TuIirJ/xVOBqyfRYxI+f9fjZbYxGo+ZmS?=
 =?us-ascii?Q?HhzRadeS6EnAE+RwMig5vNRTRzo/e0UUixx1WqxqB3Um0nthIR46RApKAsjY?=
 =?us-ascii?Q?+nh/Dl/k/VaB9S91/SRsXIcqEFGOKN3DZ2Iou4GlZPoF8IIo2y6o+aB/LJpT?=
 =?us-ascii?Q?rmeEkcqOnHTY19wnURfG0N90/wRAY1VLIAWGlzMb0jFY29MnpiMSr5T7XjNG?=
 =?us-ascii?Q?qOLM/gsRHesJP2zd2sJHU7CSRkAIMmKnoVupU+9EqO9AXEqlicyDBzZQHYWg?=
 =?us-ascii?Q?Y4hVGP5eFF7oPw/D8kDF0nNXXNWTgA2jfo5sTLWQ4fO0MaobYxxIPjsJkYgP?=
 =?us-ascii?Q?6C3WY4BD76pLrmVXzBw9YgSloRQnPY4IQ4Ak7C6S+7JXEXNH40zA8gaaVOO5?=
 =?us-ascii?Q?Bz4it0ly7J2tvrEs0VpZl5AGmZzqq4EmvjWb/gMiBgKAEU3UBQs5JJaJ/zVN?=
 =?us-ascii?Q?8anaSVmSXiyWiHSYCXkcNC6OFpMbT3s35F9BKwLQS4rX0LjRN19Pm935NnTz?=
 =?us-ascii?Q?6a8v8rV/ewckbLU3avtH97ghV74sUDAaG8zWD0on0HUodBsdG9YRr1oWmE+W?=
 =?us-ascii?Q?pzy8KOE04GhZI0kOK0gZfHKOVaxqoup+WVmPx7kaH5fdi8u2IBgiG0xHuwma?=
 =?us-ascii?Q?Su4cTstiNpr4Cx5o39kq/E5mzWN7us2CwI9lDgumj5vkbwW6RQ45GSg71O7y?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8699717f-7a11-4564-a8f1-08daffcda7c0
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 18:46:37.6021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9zgQnR7GCz4Dd91bLy5ojZUXmzNLOmZcUcqLoqFw+/005VpYleOLzjyi3qA1HFJUK55l6jTdOEqvHwEnZfcElvkaa0T8LQWnJVVVGZ5GtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR17MB6892
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 07:30:19PM +0100, Oleg Nesterov wrote:
> On 01/26, Andrei Vagin wrote:
> >
> > On Thu, Jan 26, 2023 at 7:07 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > IIUC, PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH is needed to run the injected
> > > code, and this also needs to change the state of the traced process. If
> > > the tracer (CRIU) dies while the tracee runs this code, I guess the tracee
> > > will have other problems?
> >
> > Our injected code can reheal itself if something goes wrong. The hack
> > here is that we inject
> > the code with a signal frame and it calls rt_segreturn to resume the process.
> 
> What will happen if CRIU dies and clears ->ptrace right before
> syscall_user_dispatch() checks PT_SUSPEND_SYSCALL_USER_DISPATCH ?
> 
> How the tracee will react to SIGSYS with unexpected .si_syscall ?
> 
> > I don't expect that
> > the syscall user dispatch
> > is used by many applications,
> 
> Agreed, so the case when CRIU will need to do the additional
> PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG twice to disable and then re-enable
> syscall_user_dispatch is unlikely.
> 
> > so I don't strongly insist on
> > PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH.
> 
> I too won't argue too much. but so far I do not feel there is enough
> justification for this feature ...
> 
> Oleg.
> 

I'm not married to the idea, just want to make sure I have the tools
needed to make checkpoint work.  The option seems like the easiest way
given the exclusion area issue.

One idea is to overwrite a portion of the exclusion area, but this
obviously can increase the complexity of the checkpoint process.

Another idea is to disable/enable SUD via get/set, but this produces
potential detach issues.

@Andrei i'm happy to take this to IRC or somewhere else out of band to
discuss the checkpoint specifics, if that would be preferable and you
are interested.
