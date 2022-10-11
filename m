Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B185FAB18
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 05:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiJKDXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 23:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiJKDX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 23:23:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0812E1CFD7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:23:24 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MmgwC0HQzzHtcm;
        Tue, 11 Oct 2022 11:18:19 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 11:23:17 +0800
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 11:23:17 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <joe@perches.com>
CC:     <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <rostedt@goodmis.org>, <zhengyejian1@huawei.com>
Subject: Re: [PATCH] ftrace: Fix char print issue in print_ip_ins()
Date:   Tue, 11 Oct 2022 11:22:32 +0000
Message-ID: <20221011112232.1859993-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0a9453d94419991aa38d64b7a446eeba1f9c5a80.camel@perches.com>
References: <0a9453d94419991aa38d64b7a446eeba1f9c5a80.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On Mon, 10 Oct 2022 19:35:38 -0700, Joe Perches <joe@perches.com> wrote:
> On Mon, 2022-10-10 at 19:15 +0000, Zheng Yejian wrote:
> > When ftrace bug happened, following log shows every byte data in
> > problem ip address:
> >   actual:   ffffffe8:6b:ffffffd9:01:21
> > 
> > However that seems a little confusing, and it is because format
> > '%x' being used to print signed chars in print_ip_ins().
> > 
> > After this patch, the log is like:
> >   actual:   e8:6b:d9:01:21
> > 
> > Fixes: 6c14133d2d3f ("ftrace: Do not blindly read the ip address in ftrace_bug()")
> > Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> > ---
> >  kernel/trace/ftrace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> []
> > @@ -2015,7 +2015,7 @@ static int ftrace_hash_ipmodify_update(struct ftrace_ops *ops,
> >  
> >  static void print_ip_ins(const char *fmt, const unsigned char *p)
> >  {
> > -	char ins[MCOUNT_INSN_SIZE];
> > +	unsigned char ins[MCOUNT_INSN_SIZE];
> >  	int i;
> >  
> >  	if (copy_from_kernel_nofault(ins, p, MCOUNT_INSN_SIZE)) {
> 
> Perhaps nicer would be to change the for loop below this from
> 
> 	for (i = 0; i < MCOUNT_INSN_SIZE; i++)
> 		printk(KERN_CONT "%s%02x", i ? ":" : "", ins[i]);
> 
> to
> 
> 	pr_cont("%*phC", MCOUNT_INSN_SIZE, ins);

It works, thanks for your suggestion. I'll send a new version patch.

-- Zheng Yejian
