Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C117059B4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 23:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjEPVlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 17:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEPVlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 17:41:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4910559C4
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ymyty6nUWDLHx8cOsNLWM5GIjv/3QYjcXUqTdKPQWGc=; b=M1qZTSAmV5YEKRsZOG9TTXrFYh
        aHbYyMOg/jR+IUt67hDNUiantahZv4uNWUhEhpCPSuEy1czStKeWKk1bHaHa1ZG9oJLvqeXOMlQm4
        8An9ZmCRL3xTsHivUjAcD9oaX2O41obzN99H69yZB3fDjLLffJv4I6lf8c/Ubc/VQ4pCzCOD/6Ume
        6CDKK7uKI5QWPNSnyDU5cyxMfF+5G8zt5nea1LLs+PJb2ryKPeevbhBcMbqJx8B0VnfRKR/zKR3WG
        95WPSUCdBdukHD1mMLvnSbDbTJCyvCX6SfCal95qd135XZIyIoqnyqZt18c7AfqW/2BO7FEDnQYTU
        rL0f8jJA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pz2Q2-004aC4-DS; Tue, 16 May 2023 21:41:18 +0000
Date:   Tue, 16 May 2023 22:41:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Brian Cain <bcain@quicinc.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stafford Horne <shorne@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrei Vagin <avagin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Yu Zhao <yuzhao@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Hu Chunyu <chuhu@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: Re: [PATCH v9] kernel/fork: beware of __put_task_struct calling
 context
Message-ID: <ZGP4fvxQmeDVF7fK@casper.infradead.org>
References: <20230516191441.34377-1-wander@redhat.com>
 <ZGPYVAF6Nkp2umaa@casper.infradead.org>
 <20230516140555.b150a43517d85b7cad75e7da@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516140555.b150a43517d85b7cad75e7da@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 02:05:55PM -0700, Andrew Morton wrote:
> On Tue, 16 May 2023 20:24:04 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Tue, May 16, 2023 at 04:14:41PM -0300, Wander Lairson Costa wrote:
> > > +void __put_task_struct_rcu_cb(struct rcu_head *rhp)
> > > +{
> > > +	struct task_struct *task = container_of(rhp, struct task_struct, rcu);
> > > +
> > > +	__put_task_struct(task);
> > > +}
> > > +EXPORT_SYMBOL_GPL(__put_task_struct_rcu_cb);
> > 
> > Why does this need to be exported when its only caller is within the
> > main kernel and cannot possibly be built as a module?
> 
> It's referenced by inlined put_task_struct(), which is called from all
> over.

Oh, I missed that put_task_struct() was still inlined.  Should it be?
It seems quite large now.

> However I believe the above definition could be inside #ifdef
> CONFIG_PREEMPT_RT, to save a scrap of resources?
