Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902FB5B558B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiILHvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiILHvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:51:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06692220C5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K8F+rdAwC0qS+um9JcSPpbZOhWj6p58Dlo6S/7F6MgQ=; b=dTAbwXcz9l4TtK2fRyA/xZNgg+
        FsWuOmO1k7u04VquCYOVYsIOvlmkZAJz+5YOiL0hUKEAhIlxuLT9YO2fB+GBw1qcwD1W+AVncV9J5
        t2DQxx/COSHz3YDN54qTzfxgVwj4akQefgype9iTSmNDhPyEy9Wgd/hGYOiDeR5Mk9569ctfYXJCV
        qkygyxDDmZNU7GN0TVgcx61soLatnwcrEKVnS6l61J+mNoZ6rYr+z22UyqPYXZ54n9SzVWPV5L4Ec
        q+b8Ckr4pggrfO+vkAY/kh6lPXBPl1FJolZsWByvYu/4/SPi2IWvrRM1iwvCaZZra25JK1u2zHucC
        qzEUG6aQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oXeDd-00FijQ-S9; Mon, 12 Sep 2022 07:51:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3423730030F;
        Mon, 12 Sep 2022 09:50:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D8F57201E0B22; Mon, 12 Sep 2022 09:50:58 +0200 (CEST)
Date:   Mon, 12 Sep 2022 09:50:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     lizhe.67@bytedance.com, dave.hansen@linux.intel.com,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        lizefan.x@bytedance.com, yuanzhu@bytedance.com
Subject: Re: [RFC] x86/mm/dump_pagetables: Allow dumping pagetables by pid
Message-ID: <Yx7k4uNTaJeAvBMs@hirez.programming.kicks-ass.net>
References: <20220804070401.86524-1-lizhe.67@bytedance.com>
 <ca8d4f94-a106-dc56-893d-d32d43beed85@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca8d4f94-a106-dc56-893d-d32d43beed85@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2022 at 04:09:55PM -0700, Dave Hansen wrote:
> On 8/4/22 00:04, lizhe.67@bytedance.com wrote:
> > In current kernel we can only dump a user task's pagetable
> > by task itself. Sometimes we need to inspect the page table
> > attributes of different memory maps to user space to meet
> > the relevant development and debugging requirements. This
> > patch helps us to make our works easier. It add two file
> > named 'pid' and 'pid_pgtable_show'. We can use 'pid' to
> > input the task we want to inspect and get pagetable info
> > from 'pid_pgtable_show'.
> > 
> > User space can use file 'pid' and 'pid_pgtable_show' as follows.
> > ====
> > $ echo $pid > /sys/kernel/debug/page_tables/pid
> > $ cat /sys/kernel/debug/page_tables/pid_pgtable_show
> 
> This seems a wee bit silly considering that we have /proc.  It's also
> impossible to have an ABI like this work if multiple processes are
> trying to dump different pids.
> 
> Are there any other per-process things in debugfs where folks have done
> something similar?

Not that I'm aware of; we can ofcourse duplicate the whole process tree
in /debug once again, but that would suck.

Another option that sucks is writing and reading to the same filedesc;
something like:

  exec 3<> /debug/page_tables/pid_user
  echo $pid >&3
  cat - <&3

that way you can have multiple concurrent users.
