Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9CB705946
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 23:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjEPVGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 17:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEPVF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 17:05:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CB476BF
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:05:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 487E763F8F
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 21:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB77C4339E;
        Tue, 16 May 2023 21:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1684271156;
        bh=rglh49XttM/A3Yw8/UP+4HALmbmlwvPVy+YWDyVLm/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SPM/7QhgOGmJhjuPZBF+TZZc41MeUvORho6igaIsZMAbo6BegvYTJ5no4ov7wDn3u
         DxfUdwcCLFO4ugjQ2RGwTHnhAtUe+UdjJzDPyiklGmnjOMxs1u99BL1Aa2pR+5MxLD
         OYBYntSdyMgaW8WmaPRRe3G11z/D5wj4NMK8d/js=
Date:   Tue, 16 May 2023 14:05:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
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
Message-Id: <20230516140555.b150a43517d85b7cad75e7da@linux-foundation.org>
In-Reply-To: <ZGPYVAF6Nkp2umaa@casper.infradead.org>
References: <20230516191441.34377-1-wander@redhat.com>
        <ZGPYVAF6Nkp2umaa@casper.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 20:24:04 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, May 16, 2023 at 04:14:41PM -0300, Wander Lairson Costa wrote:
> > +void __put_task_struct_rcu_cb(struct rcu_head *rhp)
> > +{
> > +	struct task_struct *task = container_of(rhp, struct task_struct, rcu);
> > +
> > +	__put_task_struct(task);
> > +}
> > +EXPORT_SYMBOL_GPL(__put_task_struct_rcu_cb);
> 
> Why does this need to be exported when its only caller is within the
> main kernel and cannot possibly be built as a module?

It's referenced by inlined put_task_struct(), which is called from all
over.

However I believe the above definition could be inside #ifdef
CONFIG_PREEMPT_RT, to save a scrap of resources?
