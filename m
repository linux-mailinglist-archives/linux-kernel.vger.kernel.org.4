Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE7D5E80F7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiIWRiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiIWRi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:38:28 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEEE14FE38
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663954647; x=1695490647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i/BaILVI2Wqzcj4+9o9u3SXfzdQ9/ujyjstXsdyjTCU=;
  b=AsC9oIcpYgfkygyVzlLnlo1IMQn0VBZUlVeImwwEgUE9mavmohc1JGGV
   o2iW1V/VnHkMURNAL1Ac+3AnVhNzxn8u0Bim0RWES6f7TLtqY7RVsnrvn
   qLqCon6dAjuLAFocYxap/qpPoeIVG2pdNJpRN9S+ViLLi0IRe6K+W1sXl
   VK/nF0a+bD2dmroEBFg+ZE8JDqmYPMbZE7tSteHRpCVkRPXUIw0/biFgr
   aJT+tOeGCYqXZ5s1/JvMdLL404B3gmF9dwrSboi8WFNQbr3kFE6Mwq2vK
   tpjrZosxiOId32ouKZo1kBuWKywS/aRevAMj9SBGd1HO4DufAg1E2HSiB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="298244731"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="298244731"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 10:37:01 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="724209092"
Received: from bsyntia-mobl2.amr.corp.intel.com (HELO desk) ([10.209.30.246])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 10:37:00 -0700
Date:   Fri, 23 Sep 2022 10:36:59 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>,
        antonio.gomez.iglesias@linux.intel.com,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: Re: [PATCH v3 32/59] objtool: Allow STT_NOTYPE -> STT_FUNC+0
 tail-calls
Message-ID: <20220923173659.7mdnyjnd7iiljdn2@desk>
References: <20220915111039.092790446@infradead.org>
 <20220915111146.224130589@infradead.org>
 <20220922052750.wux3iykp2pfzi75k@desk>
 <Yyw5JqLtiXcqid3K@hirez.programming.kicks-ass.net>
 <Yyw9Pvo7/7YWoKds@hirez.programming.kicks-ass.net>
 <Yyxf3eIF5hY7DHUh@hirez.programming.kicks-ass.net>
 <Yy3EIV9/qa6KsNu/@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Yy3EIV9/qa6KsNu/@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 04:35:13PM +0200, Peter Zijlstra wrote:
>On Thu, Sep 22, 2022 at 03:15:10PM +0200, Peter Zijlstra wrote:
>
>> Ho-Humm.. let me find a non hacky solution.
>
>I've ended up here:
>
>  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=call-depth-tracking&id=c2a8b8187418956af92d2d954ee4574f87f5e188
>  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=call-depth-tracking&id=c74976b9664fb6a1856d85ce246d84db3fd2c2cd
>
>which is arguably quite a lot of work for something relatively minor,
>but I do think it leaves us in a better place.
>
>Combo patch below..

Confirming that the patch fixes the warning. Thanks.
