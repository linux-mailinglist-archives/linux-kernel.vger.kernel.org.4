Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E5F69750C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 04:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbjBODqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 22:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjBODp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 22:45:57 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1B134027
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 19:45:55 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PGkSj5JJLz16NgJ;
        Wed, 15 Feb 2023 11:43:33 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Wed, 15 Feb
 2023 11:45:52 +0800
Date:   Wed, 15 Feb 2023 11:45:32 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Guo Ren <guoren@kernel.org>
CC:     Conor Dooley <conor@kernel.org>,
        Changbin Du <changbin.du@huawei.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hui Wang <hw.huiwang@huawei.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v4] riscv: patch: Fixup lockdep warning in stop_machine
Message-ID: <20230215034532.xs726l7mp6xlnkdf@M910t>
References: <20230202114116.3695793-1-changbin.du@huawei.com>
 <Y+wlula69tYrSZjQ@spud>
 <CAJF2gTQBiE7d_RiNjxoyx9gppYQxXBLeNhEsX04tjtjM_56gRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJF2gTQBiE7d_RiNjxoyx9gppYQxXBLeNhEsX04tjtjM_56gRQ@mail.gmail.com>
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 09:24:33AM +0800, Guo Ren wrote:
> On Wed, Feb 15, 2023 at 8:22 AM Conor Dooley <conor@kernel.org> wrote:
> >
> > Hey Changbin,
> >
> > On Thu, Feb 02, 2023 at 07:41:16PM +0800, Changbin Du wrote:
> > > The task of ftrace_arch_code_modify(_post)_prepare() caller is
> > > stop_machine, whose caller and work thread are of different tasks. The
> > > lockdep checker needs the same task context, or it's wrong. That means
> > > it's a bug here to use lockdep_assert_held because we don't guarantee
> > > the same task context.
> I'm trying to delete all stop_machine in riscv, from ftrace to kprobe.
> When I have done, we needn't this patch.
>
Which approch would you use? I looked through the riscv-spec, but didn't find any
description abount concurrent modification and execution.

> > >
> > > 2.25.1
> > >
> 
> 
> 
> -- 
> Best Regards
>  Guo Ren

-- 
Cheers,
Changbin Du
