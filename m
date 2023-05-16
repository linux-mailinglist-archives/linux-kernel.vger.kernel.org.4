Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDA8705AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 00:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjEPWuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 18:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjEPWuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 18:50:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CB26EBB
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 15:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D5AF6400C
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 22:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA396C433EF;
        Tue, 16 May 2023 22:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1684277414;
        bh=nwS/+R1Nz36K2RuprOKSZylh8GjG/v200hMwgApQJ3k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b7J7c6WdL+ItXg9DqLpV1Jsr6fY0rGtXInr7s1fyXhF53Z/mH+yiu1qevDkJ/yrNE
         NyJFTLxiR6gbZB3HdbRyQ6WNtK4DGnhBr4Phxvxcy4Do3XoTyWl4DBzA4PC11bntgn
         i3p/YpxfBzxLrWc2xPGDFYhnNIpihOgt+j2FQ9jU=
Date:   Tue, 16 May 2023 15:50:13 -0700
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
Message-Id: <20230516155013.5c6ec02a8c9deb1e8fc4af8f@linux-foundation.org>
In-Reply-To: <ZGP4fvxQmeDVF7fK@casper.infradead.org>
References: <20230516191441.34377-1-wander@redhat.com>
        <ZGPYVAF6Nkp2umaa@casper.infradead.org>
        <20230516140555.b150a43517d85b7cad75e7da@linux-foundation.org>
        <ZGP4fvxQmeDVF7fK@casper.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 22:41:18 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> 
> Oh, I missed that put_task_struct() was still inlined.  Should it be?
> It seems quite large now.

It's not significantly worse because of this patch.  In fact, it's
unchanged for non-RT kernels.

Possibly put_task_struct() *should* be uninlined, because it made the
mistake of using the dang refcount stuff, which never saw a byte which
it couldn't consume :(


I mean...

--- a/fs/open.c~a
+++ a/fs/open.c
@@ -1572,3 +1572,9 @@ int stream_open(struct inode *inode, str
 }
 
 EXPORT_SYMBOL(stream_open);
+
+#include <linux/refcount.h>
+bool foo(refcount_t *r)
+{
+	return refcount_dec_and_test(r);
+}
_

is worth

339 bytes of text for an allmodconfig build 
67 bytes of text for an allnoconfig build 
77 bytes of text for a defconfig build 



