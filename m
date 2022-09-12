Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E125B5598
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiILHzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiILHy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:54:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B343BBE3D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2WjSgTbRaIizYXvZweJtPX14wSwusvTBqm3TNtCMuuU=; b=i5On9Wo3kgrBIwJjU4NxOW+Tjv
        kEaJFqQi9gPiWHkqSVPTEyXKFiGlu+SN9fKiExzB4eowVsTvQmCimscBy9SyVYNusz45GsjkwQJ8k
        hTa71M+TrrmvVK+jKazx1Zu0VPj8RJZTSuIap056nblg/cmcrZuS/5D+nRrxouCrBZLDcspb1xw8X
        MqguKePRf57+WLmdzwP5n8AlgA2BES115rYNyl8YwsEfS06WejlE1hLp6dNM4sP4oMJOIDEpEECdk
        YiaredfOagnXx4pjrklohmXZDejwAUUyLdJCuvneyAGwGGnFRTj0Qa8+/TfJRceaNzPkMTHIWs//E
        HSh/CWzg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oXeH6-00BkpV-2q; Mon, 12 Sep 2022 07:54:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9D385300074;
        Mon, 12 Sep 2022 09:54:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 48D60201E0B22; Mon, 12 Sep 2022 09:54:34 +0200 (CEST)
Date:   Mon, 12 Sep 2022 09:54:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Tejun Heo <tj@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [RFC PATCH 1/8] workqueue: Unconditionally set cpumask in
 worker_attach_to_pool()
Message-ID: <Yx7luoAJpenWO5zK@hirez.programming.kicks-ass.net>
References: <20220804084135.92425-1-jiangshanlai@gmail.com>
 <20220804084135.92425-2-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804084135.92425-2-jiangshanlai@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 04:41:28PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> If a worker is spuriously woken up after kthread_bind_mask() but before
> worker_attach_to_pool(), and there are some cpu-hot-[un]plug happening
> during the same interval, the worker task might be pushed away from its
> bound CPU with its affinity changed by the scheduler and worker_attach_to_pool()
> doesn't rebind it properly.

Can you *please* be more explicit. The above doesn't give me enough clue
to reconstruct the actual scenario you're fixing.

Draw a picture or something.
