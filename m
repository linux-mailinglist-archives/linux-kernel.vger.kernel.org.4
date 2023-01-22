Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927B3676D37
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 14:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjAVNr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 08:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjAVNrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 08:47:23 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E171B567
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 05:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XWWDeaQmdiY98ficHpbQ+wYrIC3C8BxnYT+/IlvgHmw=; b=Q0tkFU1Hl4lCkSXzJiHPiffqfb
        DokEVA44Qvih8TS8PonbC0xRhCtKeTJQHuTqZ6eCncc9oTKXulVSi1YaHytPYW8iTbgmbFlQnZ0ts
        6BBEGwlPe53SDIM/VkxuruSE9EnYIAQAV+m4tRT7pbX2EAg6b5+0JZ1jDFOq76nH08b9qYK/5fDjm
        gxn5k2zVSZCQFBkCV7oIHbSVs8tIrwoM8dEwqzlVZiKCSSa9cqP5sOWeZHwF9FMGk+zEzsomSxdzp
        JDBrJV8T+PA9MmZANOQxMqPi6f+DPWPyivZGc+l/XaZ/+887lj1lF+DCUs2IHF4tMUCizbEvVht6p
        1N82yOQA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pJaft-001GKK-1W;
        Sun, 22 Jan 2023 13:46:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 57447300388;
        Sun, 22 Jan 2023 14:46:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E1B423C6925A; Sun, 22 Jan 2023 14:46:48 +0100 (CET)
Date:   Sun, 22 Jan 2023 14:46:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Ting11 Wang =?utf-8?B?546L5am3?= <wangting11@xiaomi.com>
Subject: Re: [PATCH v6 0/6] lockinig/rwsem: Fix rwsem bugs & enable true lock
 handoff
Message-ID: <Y80+SLxrdEVyJHMo@hirez.programming.kicks-ass.net>
References: <20221118022016.462070-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118022016.462070-1-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 09:20:10PM -0500, Waiman Long wrote:

> Waiman Long (6):
>   locking/rwsem: Prevent non-first waiter from spinning in down_write() slowpath
>   locking/rwsem: Disable preemption at all down_read*() and up_read() code paths
>   locking/rwsem: Disable preemption at all down_write*() and up_write() code paths
>   locking/rwsem: Change waiter->hanodff_set to a handoff_state enum

After all these we still have down_read_non_owner() using
__rwsem_set_reader_owner() outside of the preempt_disable() region.

Now, let me go stare at this one:

>   locking/rwsem: Enable direct rwsem lock handoff


