Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B4667835F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjAWRgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjAWRfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:35:34 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0939AA5F1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:35:09 -0800 (PST)
Received: (qmail 133953 invoked by uid 1000); 23 Jan 2023 12:34:37 -0500
Date:   Mon, 23 Jan 2023 12:34:37 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, akpm@osdl.org,
        tglx@linutronix.de, joel@joelfernandes.org,
        diogo.behrens@huawei.com, jonas.oberhauser@huawei.com,
        linux-kernel@vger.kernel.org,
        Hernan Ponce de Leon <hernanl.leon@huawei.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] Fix data race in mark_rt_mutex_waiters
Message-ID: <Y87FLV0dWSyQz3NZ@rowland.harvard.edu>
References: <20230120135525.25561-1-hernan.poncedeleon@huaweicloud.com>
 <562c883b-b2c3-3a27-f045-97e7e3281e0b@linux.intel.com>
 <20230120155439.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <9a1c7959-4b8c-94df-a3e2-e69be72bfd7d@huaweicloud.com>
 <20230123164014.GN2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123164014.GN2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 08:40:14AM -0800, Paul E. McKenney wrote:
> In the case, the value read is passed into cmpxchg_relaxed(), which
> checks the value against memory.  In this case, as Arjan noted, the only
> compiler-and-silicon difference between data_race() and READ_ONCE()
> is that use of data_race() might allow the compiler to do things like
> tear the load, thus forcing the occasional spurious cmpxchg_relaxed()
> failure.

Is it possible in theory for a torn load to cause a spurious 
cmpxchg_relaxed() success?  Or would that not matter here?

Alan
