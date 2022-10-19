Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C57160385B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 05:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJSDDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 23:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJSDD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 23:03:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E73E6F6E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 20:03:26 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Msb5r6Lr6zmVBM;
        Wed, 19 Oct 2022 10:58:40 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 11:03:24 +0800
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 11:03:24 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <hackerzheng666@gmail.com>
CC:     <alex000young@gmail.com>, <arnd@arndb.de>,
        <dimitri.sivanich@hpe.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <security@kernel.org>,
        <zhengyejian1@huawei.com>, <zyytlz.wz@163.com>
Subject: Re: [PATCH v3] misc: sgi-gru: fix use-after-free error in  gru_set_context_option, gru_fault and gru_handle_user_call_os
Date:   Wed, 19 Oct 2022 11:02:49 +0000
Message-ID: <20221019110249.3472339-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAJedcCzTfjeeoRzdMZHHtYhpcx+1TiM-cf7UKwwrDw83OtWAUA@mail.gmail.com>
References: <CAJedcCzTfjeeoRzdMZHHtYhpcx+1TiM-cf7UKwwrDw83OtWAUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022 10:39:11 +0800, Zheng Hacker <hackerzheng666@gmail.com> wrote:
> Zheng Yejian <zhengyejian1@huawei.com> 于2022年10月19日周三 09:56写道：
> > On Wed, 19 Oct 2022 00:52:59 +0800, Zheng Wang <zyytlz.wz@163.com> wrote:
> > > Gts may be freed in gru_check_chiplet_assignment.
> > > The caller still use it after that, UAF happens.
> > >
> > > Fix it by introducing a return value to see if it's in error path or not.
> > > Free the gts in caller if gru_check_chiplet_assignment check failed.
> > >
> > > Fixes: 55484c45dbec ("gru: allow users to specify gru chiplet 2")
> > > Reported-by: Zheng Wang <hackerzheng666@gmail.com>
> > > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > > ---
> > > v3:
> > > - add preempt_enable and use VM_FAULT_NOPAGE as failure code by Yejian
> >
> > Sorry, maybe I didn't make it clearly enough in
> > https://lore.kernel.org/lkml/20221009201418.509417-1-zhengyejian1@huawei.com/
> >
> > What I suggested was that return value of gru_fault() should be some VM_FAULT_XXX,
> > because this return value would be specially handled in pagefault flow like:
> >     __do_fault() {
> >         ......
> >         ret = vma->vm_ops->fault(vmf);
> >         ......
> >     }
> >
> > But in other functions that are not in pagefault flow, common error code
> > like -EINVAL is ok. Meanings of every error code can be found in:
> > https://man7.org/linux/man-pages/man3/errno.3.html
> >
> > By the way, these are all personal suggestions. You need Reviewed-by Maintainer :)
>
> Hi Zheng Yejian,
>
> Thanks for your suggestion! Sorry for my late patch, I was a little
> bit busy last week. I think the trigger path of this issue is divise.
> So yes, -EINVAL may be a better choice.
>
> I'll update the patch soon after.

Hi Wang,
I'm very glad for my suggestion being adopted.
And really thank you for your efforts!

>
> Best Regards,
> Zheng Wang
