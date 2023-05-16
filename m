Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E571705707
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjEPTZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjEPTYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:24:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE26A86BD
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=18irUwydotXRePLu/J5DGPoXDnh6CdjdyHmv2dIgPhA=; b=f6f+/5h9YDMqbVc3sEKT02jLDv
        XwYuG05KyT3JPaDAAoQqDoXsKSXbrBcjhqgB4tOiKCBccSa08EWJF68HG/LFGIMDFi+hr9Tyw2cxz
        JRLKCawcqb8DoM7MeW0+PrGZYl/BbUC7OGrZAlH/CslxGlcFTUJXQnEeIcGVLlOpF9+EbBXohJ+yF
        XnsTpGCaLOcOmDEJOYp72RyOd2xBm+I4etyD7WHIAV27x9esZUS04S0gZ1/ZlnXnFFCYke67ezxNc
        /VmKz6R7+wA/qWu0Xpmq9sa40NjRZk7MkI7Jt4/sMByTJCXrWpb4Z1kzrGsVmzuIgHt76U3XhsVJK
        SSiYBBMw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pz0HE-004ULm-Mq; Tue, 16 May 2023 19:24:04 +0000
Date:   Tue, 16 May 2023 20:24:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Brian Cain <bcain@quicinc.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stafford Horne <shorne@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <ZGPYVAF6Nkp2umaa@casper.infradead.org>
References: <20230516191441.34377-1-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516191441.34377-1-wander@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 04:14:41PM -0300, Wander Lairson Costa wrote:
> +void __put_task_struct_rcu_cb(struct rcu_head *rhp)
> +{
> +	struct task_struct *task = container_of(rhp, struct task_struct, rcu);
> +
> +	__put_task_struct(task);
> +}
> +EXPORT_SYMBOL_GPL(__put_task_struct_rcu_cb);

Why does this need to be exported when its only caller is within the
main kernel and cannot possibly be built as a module?
