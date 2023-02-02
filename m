Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DC468761C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 08:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjBBHAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 02:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBBHAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 02:00:45 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1932329144
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 23:00:44 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4P6qQJ0j8wzJrWw;
        Thu,  2 Feb 2023 14:59:04 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Feb
 2023 15:00:39 +0800
Date:   Fri, 3 Feb 2023 07:00:43 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     Changbin Du <changbin.du@huawei.com>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hui Wang <hw.huiwang@huawei.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v3] riscv: patch: Fixup lockdep warning in stop_machine
Message-ID: <20230202230043.737f6z3mi2thukgz@M910t>
References: <20230130232659.3374212-1-changbin.du@huawei.com>
 <Y9fdtcoh8POLZ6CD@wendy>
 <CAJF2gTQm_iHHEOEv+38G6nqjDO5b+oDcUOXi8uKxZLXvG249Kw@mail.gmail.com>
 <Y9jIPOLxRRrjMo2t@wendy>
 <20230201210031.x7c5xlgxxiaoahqz@M910t>
 <Y9pwo5iC7hrPm/wk@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9pwo5iC7hrPm/wk@wendy>
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 02:01:07PM +0000, Conor Dooley wrote:
> On Thu, Feb 02, 2023 at 05:00:31AM +0800, Changbin Du wrote:
> > On Tue, Jan 31, 2023 at 07:50:20AM +0000, Conor Dooley wrote:
> > > On Tue, Jan 31, 2023 at 03:26:33PM +0800, Guo Ren wrote:
> > [snip]
> > > > > >
> > > > > > -     /*
> > > > > > -      * Before reaching here, it was expected to lock the text_mutex
> > > > > > -      * already, so we don't need to give another lock here and could
> > > > > > -      * ensure that it was safe between each cores.
> > > > > > -      */
> > > > > > -     lockdep_assert_held(&text_mutex);
> > > > >
> > > > > I must admit, patches like this do concern me a little, as a someone
> > > > > unfamiliar with the world of probing and tracing.
> > > > > Seeing an explicit check that the lock was held, leads me to believe
> > > > > that the original author (Zong Li I think) thought that the text_mutex
> > > > > lock was insufficient.
> > > > > Do you think that their fear is unfounded? Explaining why it is safe to
> > > > > remove this assertion in the commit message would go a long way towards
> > > > > easing my anxiety!
> > > > >
> > > > > Also, why delete the comment altogether? The comment provides some
> > > > > information that doesn't appear to become invalid, even with the
> > > > > assertion removed?
> > > > Stop_machine separated the mutex context and made a lockdep warning.
> > > > So text_mutex can't be used here. We need to find another check
> > > > solution. I agree with the patch.
> > > 
> > > Whether or not you agree with the change is not the point (with your SoB
> > > I'd hope you agree with it).
> > > I understand that you two are trying to fix a false positive lockdep
> > > warning, but what I am asking for an explanation as to why the original
> > > author's fear is unfounded.
> > > Surely, having added the assertion, they were not thinking of the same
> > > code path that you guys are hitting the false positive on?
> > > 
> > The assertion is reasonable since the fixmap entry is shared. The text_mutex
> > does should be held before entering that function. But the false positive cases
> > make some functions (ftrace for example) difficult to use due to warning log
> > storm.
> > 
> > Either the lockdep should be fixed for stop_machine, or remove the assertion
> > simply now (we can keep the comments). (or do the assertion conditionly?)
> 
> How would you suggest checking it conditionally?
>
Please refer to a early patch from Palmer Dabbelt.
https://lore.kernel.org/all/20220322022331.32136-1-palmer@rivosinc.com/

> Also, if you persist in removing the assertion, there is a comment in
> arch/riscv/kernel/ftrace.c that would need to be updated. (L129-ish)
> 
No problem.

> The comment you removed in this patch seems valid both before and after
> though, so I don't see a compelling reason for its removal.
We all agreed. The key is to get rid of false positive case.

> 
> > And this is not a riscv only problem but common for architectures which use
> > stop_machine to patch text. (arm for example)
> > 
> > > Perhaps Zong themselves can tell us what the original fear was?
> 



-- 
Cheers,
Changbin Du
